; Used by the routine at LBC10.
; Ввод имени нового рекордсмена, обновление таблицы рекордов и её вывод на экран
input_new_record_name:
  ; DI
  LD IX,txt_high_score_table+227 ; Текст последней строчки таблицы
  LD HL,current_score_1up+2
  LD DE,score_six_digits
  LD B,$03
L910C_0:
  LD A,(HL)
  RRA
  RRA
  RRA
  RRA
  AND $0F
  LD (DE),A
  INC DE
  LD A,(HL)
  AND $0F
  LD (DE),A
  INC DE
  DEC HL
  dec b
  jp nz,L910C_0
  LD IY,score_six_digits
  LD D,$0B
L910C_1:
  LD B,$06
  PUSH IY
  PUSH IX
L910C_2:
  LD A,(IX+$00)
  CP (IY+$00)
  JP C,L910C_4
  JP NZ,L910C_3
  INC IX
  INC IY
  dec b
  jp nz,L910C_2
L910C_3:
  POP IX
  POP IY
  LD A,D
  CP $0B
  RET Z
  JP L910C_5
L910C_4:
  DEC D
  POP IX
  POP IY
  LD BC,$FFEE
  ADD IX,BC
  LD A,D
  DEC A
  JP NZ,L910C_1
L910C_5:
  LD A,$0A
  SUB D
  JP Z,L910C_7
  LD DE,txt_high_scores-1
  LD HL,txt_high_score_table+222 ; Последняя строка таблицы рекордов
L910C_6:
  LD BC,$000E
  CALL LDDR8080
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  DEC DE
  DEC DE
  DEC DE
  DEC DE
  DEC A
  JP NZ,L910C_6
L910C_7:
  LD DE,$0012
  ADD IX,DE
  PUSH IX
  POP DE
  LD HL,score_six_digits
  LD BC,$0006
  CALL LDIR8080
  LD C,$26
  LD (IX+$09),$0A
  LD (IX+$0A),C
  LD (IX+$0B),C
  LD (IX+$0C),C
  LD (IX+$0D),C
  CALL clear_screen_attrib
  CALL clear_screen_pix
  CALL disp_high_score_table_screen
  LD A,(player_number)
  INC A
  LD (txt_player_0_enter_your_name+13),A
  LD DE,txt_player_0_enter_your_name
  CALL print_line
  CALL print_line
  PUSH IX
  POP HL
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  LD (text_line_addr),HL
  LD B,$05
L910C_8:
  LD C,$0A
  PUSH BC
L910C_9:
  CALL get_control_state_1up
  LD A,(ctrl_btns_pressed)
  AND $13
  JP Z,L910C_9
  BIT 4,A
  JP NZ,L910C_12
  CP $03
  JP Z,L910C_9
  POP BC
  RRA
  JP NC,L910C_10
  INC C
  LD A,C
  CP $28
  JP NZ,L910C_11
  LD C,$00
  JP L910C_11
L910C_10:
  DEC C
  BIT 7,C
  JP Z,L910C_11
  LD C,$27
L910C_11:
  LD (IX+$09),C
  PUSH BC
	ex DE,HL
	ld HL,(text_line_addr)
	ex DE,HL
  CALL print_line
  CALL play_sound_choose_letter
  LD D,$20
  CALL pause_short
  JP L910C_9
L910C_12:
  CALL play_sound_confirm_letter
  POP BC
  DEC B
  JP Z,L910C_14
  INC IX
  LD (IX+$09),$0A
  PUSH BC
	ex DE,HL
	ld HL,(text_line_addr)
	ex DE,HL
  CALL print_line
L910C_13:
  CALL get_control_state_1up
  LD A,(ctrl_btns_pressed)
  AND $10
  JP NZ,L910C_13
  POP BC
  JP L910C_8
L910C_14:
  CALL disp_high_score_table_screen
  LD B,$0A
  JP pause_long

; Сюда помещается адрес следующей строки текста для печати
text_line_addr:
  DEFW $0000

; Used by the routines at disp_high_score_table_screen and L93F8.
; Рисует рамку вокруг экрана
draw_frame:		; Specialist ready
  LD HL,$0000
  LD (counter_misc),HL

  CALL clear_screen_attrib
  CALL clear_screen_pix

; Рисуются боковины
  LD HL,zx_scr-$bf		; Адрес в экранной области $98DF
  LD DE,zx_scr+$1f00-$bf	; Адрес в экранной области $B7DF
  LD B,$C0
draw_frame_0:
  LD (HL),$C0
  LD A,$03
  LD (DE),A
  inc E			; поправлено направление для Вектора
  inc L			; поправлено направление для Вектора
  DEC B
  JP NZ,draw_frame_0

; Рисуется верх и низ
  LD HL,zx_scr		; Адрес в экранной области $98DE
  LD DE,zx_scr-$be	; Адрес в экранной области $9820
  LD B,$20
  LD A,$FF
draw_frame_1:
  LD (HL),A
  dec L			; поправлено направление для Вектора
  LD (HL),A
  inc L

  LD (DE),A
  dec E			; поправлено направление для Вектора
  LD (DE),A
  inc E

  INC H
  INC D
  DEC B
  JP NZ,draw_frame_1
  RET

; Used by the routines at input_new_record_name and L927F.
disp_high_score_table_screen:

;  	ld a,c42
;	ld (color_port),a	; Красный цвет

  CALL draw_frame

  LD DE,txt_high_score_table
  LD B,$16
  JP print_message

; Used by the routine at disp_main_menu_and_wait_keys.
disp_hs_table_and_wait_keys:
	CALL disp_high_score_table_screen
check_0_button:
	ld A,(KEYLINE2)		; Проверка ряда цифр '0'..'7'
	cpl
	and %00000001		; '0'?
	ret nz			; Выход из общей процедуры (запуск игры), если нажат 0
any_key:
		ld		a,$82
;		ld		(kb_port_3),a
;		ld		a,(kb_port_1)
		or		$01
		inc a
  JP NZ,disp_main_menu_and_wait_keys

  LD A,$49		; Цикл задержки $80
L927F_1:		; Цикл задержки
  DEC A			; Цикл задержки
  JP NZ,L927F_1		; Цикл задержки

  LD HL,(counter_misc)
  INC HL
  LD (counter_misc),HL

  LD A,H
  AND A,%1000000 ; BIT 6,H

  JP NZ,disp_main_menu_and_wait_keys	; Переход на отображение главного меню, если счётчик достиг нужного значения
  JP check_0_button
