; Used by the routines at disp_hs_table_and_wait_keys and LB9E8.
disp_main_menu_and_wait_keys:
  LD HL,$0000
  LD (back_counters),HL

;	ld a,c43
;	ld (color_port),a	; Фиолетовый цвет

  CALL draw_frame

;	ld a,c47
;	ld (color_port),a	; Белый цвет

  LD HL,$4718		; Адрес на экране
  LD DE,spr_press_a
  CALL print_sprite	; Press A

  LD HL,$47C8		; Адрес на экране
  LD DE,spr_press_b
  CALL print_sprite	; Press B

  LD HL,current_score_1up+2
  LD DE,txt_score_1up+4
  CALL score_to_text
  LD HL,current_score_2up+2
  LD DE,txt_score_2up+4
  CALL score_to_text

  LD DE,txt_main_menu
  LD B,$0F				; Количество строк в сообщении
  CALL print_message

;  	ld a,c47
;	ld (color_port),a	; Белый цвет

  LD HL,(coord_ctrl_1up)
  LD DE,spr_pointer_1
  CALL print_sprite
  LD HL,(coord_ctrl_2up)
  LD DE,spr_pointer_2
  CALL print_sprite

L93F8_0:
  LD HL,(counter_misc)
  INC HL
  LD (counter_misc),HL

  LD A,H
  AND %1000000 ; BIT 6,H

  JP NZ,disp_hs_table_and_wait_keys		; Переход на отображение таблицы рекордов

;  call cheat ;DEBUG

  CALL random_generate
  LD HL,(game_mode)
  EX HL,DE

	ld A,(KEYLINE2)
	cpl
	and %00001110		; клавиши 1, 2, 3
	jp z,L93F8_4		; Не нажата ни одна цифра

	ld A,(KEYLINE2)
	cpl
	and %00000010		; Нажата ли клавиша 1?
	jp z,L93F8_1
; Нажата '1'
  LD A,E
  AND A
  JP Z,L93F8_4
  LD E,$00
  LD HL,txt_1_player
  JP L93F8_3

L93F8_1:
	ld A,(KEYLINE2)
	cpl
	and %00001000		; Нажата ли клавиша 3?
	jp z,L93F8_2
; Нажата '3'
  LD A,E
  CP $02
  JP Z,L93F8_4
  LD E,$02
  LD HL,txt_double_play
  JP L93F8_3

L93F8_2:
	ld A,(KEYLINE2)
	cpl
	and %00000100		; Нажата ли клавиша 2?
	jp z,L93F8_4
; Нажата '2'
  DEC E
  JP Z,L93F8_4
  LD E,$01
  LD HL,txt_2_players

L93F8_3:
  LD A,E
  LD (game_mode),A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,$2F
  LD E,A
  LD D,$00
  EX HL,DE
  LD (current_game_mode_line_prop),HL
  EX HL,DE
  PUSH HL
  EX HL,DE
  LD HL,(pointer_game_mode_text)
  EX HL,DE
  CALL print_line
  POP HL
  LD (pointer_game_mode_text),HL

L93F8_4:
  LD A,(back_counters)
  AND A
  JP Z,L93F8_5
  DEC A
  LD (back_counters),A
  JP L93F8_7

L93F8_5:
	ld A,(KEYLINE4)		; Проверка ряда клавиш
	cpl
	and %00000010		; Проверка клавиши 'A'
	jp z,L93F8_7
; Нажата клавиша 'A'
  LD A,(ctrl_type_1up)
  INC A
  AND $03
  LD (ctrl_type_1up),A
  LD HL,(coord_ctrl_1up)
  LD DE,spr_pointer_empty
  CALL print_sprite
  LD A,(coord_ctrl_1up+1)
  ADD A,$10
  CP $A0
  JP C,L93F8_6
  LD A,$6C
L93F8_6:
  LD (coord_ctrl_1up+1),A
;    ld a,c47
;	ld (color_port),a	; Белый цвет
  LD HL,(coord_ctrl_1up)
  LD DE,spr_pointer_1
  CALL print_sprite
  LD A,$FF
  LD (back_counters),A
  CALL play_sound_choose_ctrl
L93F8_7:
  LD A,(back_counters+1)
  AND A
  JP Z,L93F8_8
  DEC A
  LD (back_counters+1),A
  JP L93F8_10

L93F8_8:
	ld A,(KEYLINE4)		; Проверка ряда клавиш
	cpl
	and %00000100		; Проверка клавиши 'B'
	jp z,L93F8_10
; Нажата клавиша 'B'
  LD A,(ctrl_type_2up)
  INC A
  AND $03
  LD (ctrl_type_2up),A
  LD HL,(coord_ctrl_2up)
  LD DE,spr_pointer_empty
  CALL print_sprite
  LD A,(coord_ctrl_2up+1)
  ADD A,$10
  CP $A0
  JP C,L93F8_9
  LD A,$6C
L93F8_9:
  LD (coord_ctrl_2up+1),A
;    ld a,c47
;	ld (color_port),a	; Белый цвет
  LD HL,(coord_ctrl_2up)
  LD DE,spr_pointer_2
  CALL print_sprite
  LD A,$FF
  LD (back_counters+1),A
  CALL play_sound_choose_ctrl

L93F8_10:
  LD DE,current_game_mode_line_prop
  CALL fill_color_current_game_mode
	ld A,(KEYLINE2)		; Проверка ряда цифр '0'..'7'
	cpl
	and %00000001		; Проверка клавиши '0'
	ret nz			; Выход из общей процедуры (запуск игры), если нажат '0'
	;ret ;DEBUG
  JP L93F8_0
