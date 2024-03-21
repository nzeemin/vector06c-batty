; BATTY
; (C)1987 HIT-PAK
; (С)2020 Юдин С.А. - Адаптация для ПК Специалист

	INCLUDE "batty0.inc"

	org	BATTY0_END
start_bin:
;=================================

; Адрес начала окна ZX-экрана на экране Специалиста
zx_scr EQU $C0E0	; поправка для Вектора

	IFDEF MX

;sound_port EQU $ffe3

; Цвета для Специалиста MX
c00 EQU %00000000 ; $00 - 00 000 000 Чёрный
c03 EQU %01010000 ; $03 - 00 000 011 Фиолетовый (Маджента)
c04 EQU %00100000 ; $04 - 00 000 100 Зелёный
c05 EQU %00110000 ; $05 - 00 000 101 Голубой (Циан)
c06 EQU %01100000 ; $06 - 00 000 110 Жёлтый
c07 EQU %01110000 ; $07 - 00 000 111 Белый

c20 EQU %00000010 ; $20 - 00 100 000 Зелёный-Чёрный

c42 EQU %11000000 ; $42 - 01 000 010 Красный
c43 EQU %11010000 ; $43 - 01 000 011 Фиолетовый (Маджента)
c44 EQU %10100000 ; $44 - 01 000 100 Зелёный
c45 EQU %10110000 ; $45 - 01 000 101 Голубой (Циан)
c46 EQU %11100000 ; $46 - 01 000 110 Жёлтый
c47 EQU %11110000 ; $47 - 01 000 111 Белый

c4F EQU %11111001 ; $4f - 01 001 111 Синий-Белый
c57 EQU %11111100 ; $57 - 01 010 111 Красный-Белый
c5F EQU %11111101 ; $5f - 01 011 111 Фиолетовый-Белый

c70 EQU %00001110 ; $70 - 01 110 000 Жёлтый-Чёрный

	ELSE

;sound_port EQU $ff03

; Цвета для стандартного Специалиста
c00 EQU $d0 ; $00 - 00 000 000 Чёрный
c03 EQU $40 ; $03 - 00 000 011 Фиолетовый (Маджента)
c04 EQU $90 ; $04 - 00 000 100 Зелёный
c05 EQU $80 ; $05 - 00 000 101 Голубой (Циан)
c06 EQU $10 ; $06 - 00 000 110 Жёлтый
c07 EQU $00 ; $07 - 00 000 111 Белый

c20 EQU $d0 ; $20 - 00 100 000 Зелёный-Чёрный

c42 EQU $50 ; $42 - 01 000 010 Красный
c43 EQU $40 ; $43 - 01 000 011 Фиолетовый (Маджента)
c44 EQU $90 ; $44 - 01 000 100 Зелёный
c45 EQU $80 ; $45 - 01 000 101 Голубой (Циан)
c46 EQU $10	; $46 - 01 000 110 Жёлтый
c47 EQU $00 ; $47 - 01 000 111 Белый

c4F EQU $00 ; $4f - 01 001 111 Синий-Белый
c57 EQU $00 ; $57 - 01 010 111 Красный-Белый
c5F EQU $00 ; $5f - 01 011 111 Фиолетовый-Белый

c70 EQU $d0 ; $70 - 01 110 000 Жёлтый-Чёрный

	ENDIF

; Начало программы

; Начальная обработка графики.
  INCLUDE "./routines/preparation.asm"

; Элементы оформления игрового поля
  INCLUDE "./gfx/sprites_with_masks_1.asm"

; Знакогенератор
  INCLUDE "./gfx/font.asm"

; Графика: элементы обрамления экрана
  INCLUDE "./gfx/sprites_color_1.asm"

; Список уровней и их структура
  INCLUDE "./gfx/levels.asm"

; Поиск нужного спрайта по координатам в IX
  INCLUDE "./routines/sprites_search.asm"

; Спрайты с масками
  INCLUDE "./gfx/sprites_with_masks_2.asm"

; Двухбайтовый счётчик, используемый, например, в мигалке главного меню
counter_misc:
  DEFW $0000

; Случайное число
; random_number+$00 - всегда одинаковая последовательность чисел
; random_number+$01 - в последовательность вносят коррективы нажатые кнопки управления
random_number:
  DEFW $8E17

; Счётчик, значение которого $8000-$9FFF
random_seed:
  DEFW $8000

; Used by the routine at game_screen_draw_to_buffer.
; Рисует в буфере все магниты на уровне
  INCLUDE "./routines/magnets.asm"

; Used by the routines at print_magnets, print_one_magnet, disp_main_menu_and_wait_keys, set_bonus, game_restart, LBB97 and LBC10.

; Генератор случайных чисел
random_generate:		; Specialist ready
  EX HL,DE
  LD HL,(random_number)		; 8E17
  EX HL,DE
  LD HL,(random_seed)		; 8000

  LD A,(HL)					; 81 отсюда bat_increase_size_ready LD (IX+$15),$81
  ADD A,$05
  LD B,A
  LD A,(ctrl_btns_pressed)
  ADD A,B
  ADD A,E
  LD E,A			; E += (HL) + $05 + (ctrl_btns_pressed)

  LD A,(HL)
  CPL
  ADD A,$16
  ADD A,D
  ADD A,L
  LD D,A			; D += !(HL) + $16 + L

; D - всегда одинаковая последовательность чисел
; E - в последовательность вносят коррективы нажатые кнопки управления

  EX HL,DE
  LD (random_number),HL
  EX HL,DE

  INC HL
  LD A,H
  AND $9F
  LD H,A			; HL = (HL + 1) & $9FFF
  LD (random_seed),HL
  RET

; Состояние нажатых кнопок джойстика и управления
; Bit 0 $01 - вправо
; Bit 1 $02 - влево
; Bit 2
; Bit 3
; Bit 4 $10 - огонь
ctrl_btns_pressed:
  DEFB $00


; Расшифровываем биты клавиатуры и джойстика Вектора
;TODO: Вынести в файл процедур Вектора
read_keyboard:
  ld hl,read_keyboard_map	; Point HL at the keyboard list
  ld b,$0C
  ld de,KEYLINE0
  call read_keyboard_0
  ld de,KEYLINE7
  call read_keyboard_0
  ld de,JOYSTICKP
  call read_keyboard_0
  ld a,b
  ret
read_keyboard_0:
  ld a,(de)			; get bits for keys
  ld c,8			; number of keys in a row
read_keyboard_1:
  rla				; shift A left; bit 0 sets carry bit
  jp c,read_keyboard_2		; if the bit is 0, we've found our key
  ld e,a	; save A
  ld a,(hl)
  or b
  ld b,a
  ld a,e	; restore A
read_keyboard_2:
  inc hl
  dec c
  jp nz,read_keyboard_1		; continue the loop by bits
  ret
read_keyboard_map:                    ; 7   6   5   4   3   2   1   0
  ; KeyLine0
  DB $10,$01,$10,$02,$10,$10,$01,$02  ; Dn  Rt  Up  Lt  ZB  VK  PS  Tab
  ; KeyLine7
  DB $10,$00,$00,$00,$00,$00,$00,$00  ; Spc  ^   ]   \   [   Z   Y   X
  ; JoystickP
  DB $10,$10,$00,$00,$00,$00,$02,$01  ; Fr  Fr  --  --  Dn  Up  Lt  Rt


; Used by the routines at clear_hl_buff16, all_var_init and game_start.
; Очищает буфер адресуемый HL размером, заданным в B
clear_hl_buff:
  LD (HL),$00
  INC HL
  dec B
  jp nz,clear_hl_buff
  RET

spr_level_textures:
  DEFW spr_level_texture_1
  DEFW spr_level_texture_2
  DEFW spr_level_texture_3
  DEFW spr_level_texture_4

; Текстуры уровней 2,3,4 (текстура 1 дальше по тексту)
  INCLUDE "./gfx/sprites_color_2.asm"

; Used by the routine at game_restart.
; Вывод окна с номером уровня и игрока перед началом раунда
show_window_round_number:
; Рисуем чёрное окно
  LD HL,$A458		; Координаты на экране
  CALL screen_addr_calc
  LD C,$20		; Высота окна а пикселях
next_win_line:
  LD B,$0A		; Ширина окна в знакоместах
  PUSH HL
next_win_column:
  LD (HL),$00
  INC H			; next column
  dec B
  jp nz,next_win_column
  POP HL
  inc L   	; поправил направление для Вектора
  DEC C
  JP NZ,next_win_line

; Вписываем двузначный номер раунда в сообщение в 10-тичной системе
  LD A,(round_number_1up)
  INC A
  LD B,A
  XOR A
next_round_number:
  ADD A,$01
  DAA
  dec B
  jp nz,next_round_number
  LD B,A
  RRA
  RRA
  RRA
  RRA
  AND $0F
  LD (txt_round_xx+10),A
  LD A,B
  AND $0F
  LD (txt_round_xx+11),A
; Вписываем номер игрока в сообщение
  LD A,(player_number)
  INC A
  LD (txt_player_x+11),A
  LD DE,txt_player_x
; Печатаем сообщение поверх чёрного окна
  LD B,$02
  CALL print_message

  LD A,(game_mode)
  CP $02
  RET NZ
  LD DE,txt_game_on
  JP print_line

  INCLUDE "./txt/txt_player_x.asm"
  INCLUDE "./txt/txt_round_xx.asm"
  INCLUDE "./txt/txt_game_on.asm"
  INCLUDE "./txt/txt_high_score_table.asm"
  INCLUDE "./txt/txt_high_scores.asm"

; Сюда счёт преобразуется в шесть 10-тичных цифр
score_six_digits:
  DEFB $00,$00,$00,$00,$00,$00

  INCLUDE "./txt/txt_player_0_enter_your_name.asm"

; Used by the routine at LBC10.
  INCLUDE "./routines/record_table.asm"

; Used by the routine at disp_main_menu_and_wait_keys.
; Преобразует цифры в текст и помещает текст в сообщение
score_to_text:		; Specialist ready
  LD B,$03
next_double_digit:
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
  DEC B
  JP NZ,next_double_digit
  RET

; Мусор?
  DEFB $04,$03,$47,$04,$03,$00

coord_ctrl_1up:
  DEFW $6C28		; Координаты (X,Y) указателя игрока 1

coord_ctrl_2up:
  DEFW $6CB8		; Координаты (X,Y) указателя игрока 2

; Указатели управления игроков
  INCLUDE "./gfx/sprites_no_masks_1.asm"

; Два независимых байта для обратного отсчёта
back_counters:
  DEFW $0000

; Надписи PRESS A и PRESS B
  INCLUDE "./gfx/sprites_no_masks_2.asm"

; Подпрограмма рисования главного меню и опроса клавиатуры в нём
  INCLUDE "./routines/main_menu.asm"

  INCLUDE "./txt/txt_main_menu.asm"
  INCLUDE "./txt/txt_score_1up.asm"
  INCLUDE "./txt/txt_score_2up.asm"
  INCLUDE "./txt/txt_1_player.asm"
  INCLUDE "./txt/txt_2_players.asm"
  INCLUDE "./txt/txt_double_play.asm"
  INCLUDE "./txt/txt_controls.asm"

; Сюда сохраняется указатель на текст перед выводом на экран при смене режима игры
pointer_game_mode_text:
  DEFW txt_1_player
  DEFW txt_controls

; +00 - координата Y
; +01 - указатель на текущий атрибут в таблице
current_game_mode_line_prop:
  DEFB $2F,$00

  DEFB $67,$08		; Мусор?

; Used by the routine at disp_main_menu_and_wait_keys.
; Закрашивает текущий режим игры в главном меню нужным цветом (для мигания)
fill_color_current_game_mode:		; Specialist ready
  LD A,(DE)
  LD H,A
  LD L,$70
  CALL screen_coord_attrib
  INC DE
  LD A,(DE)
  PUSH HL
  LD HL,flash_colors
  CALL hl_add_a
  LD A,(HL)
  INC DE

	ld hl,last_color
	cp (HL)
	jp z,nac_2

 ; Перерисовываем буквы, только если изменился цвет
	ld (hl),a
;	ld (color_port),a
	;Считываем и записываем обратно данные
	pop hl
	ld b,$0B
next_attr_column:
	ld c,$08
nac_1:
	ld a,(hl)
	ld (hl),a
	dec hl
	dec c
	jp nz,nac_1
	ld a,l
	add $08
	ld l,a
	inc h
	dec B
	JP NZ,next_attr_column
	push hl
nac_2:
	pop	hl
  LD A,(counter_misc)
  AND $1F
  RET NZ
  DEC DE
  LD A,(DE)
  INC A
  AND $0F
  LD (DE),A
  INC DE
  RET

; Последний используемый цвет в мигалке
last_color:
	defb $00

; Чередующиеся цвета для мигания надписи режима игры в главном меню
; $10 цветов крутятся по кругу
flash_colors:
  DEFB c00,c00,c00,c00,c00,c00,c00,c00	; Чёрный
  DEFB c47,c47,c47,c47,c47,c47,c47,c47	; Яркий белый

; Признак необходимости смены игрока, которому зачислять счёт при Double Play
; Если 0, то менять игрока не нужно
need_change_player:
  DEFB $00

; Шаги очков, за которые будет добавляться дополнительная жизнь: 03(0000), 06(0000), 10(0000) и т.д.
live_add_steps:
  DEFB $03,$06,$10,$15,$20,$25,$50,$75
  DEFB $FF

; Used by the routines at kill_enemy_by_bat, handling_bullet, get_bonus and points_calc_and_add.
; Добавление очков из BC текущему игроку
add_points_to_score:
  LD A,(game_mode)
  CP $02
  JP NZ,score_update	; Пропускаем, если режим не Double Play
  LD A,(need_change_player)
  AND A
  JP Z,score_update ; Пропускаем, если в need_change_player ноль

; Если Double Play и в need_change_player не ноль
; Обмениваем игроков
  PUSH BC
  LD HL,score_1up_in_game
  LD DE,score_2up_in_game
  LD B,$0A
  CALL hl_swap_de
  LD HL,current_score_1up
  LD DE,current_score_2up
  LD B,$03
  CALL hl_swap_de
  POP BC
; Обновляем счёт
  CALL score_update
; Меняем игроков обратно
  LD HL,score_1up_in_game
  LD DE,score_2up_in_game
  LD B,$0A
  CALL hl_swap_de
  LD HL,current_score_1up
  LD DE,current_score_2up
  LD B,$03
  JP hl_swap_de

; Добавление очков из ВС к счёту текущего игрока, добавление жизни, если нужно, и обновление цифр на поле
score_update:
  LD HL,live_add_steps
  LD A,(current_score_1up+$02)
score_update_1:
  CP (HL)
  JP C,score_update_2
  INC HL
  JP score_update_1
score_update_2:
  LD E,(HL)

  LD HL,current_score_1up
  LD A,C
  ADD A,(HL)
  DAA
  LD (HL),A
  INC HL
  LD A,B
  ADC A,(HL)
  DAA
  LD (HL),A
  INC HL
  LD A,$00
  ADC A,(HL)
  DAA
  LD (HL),A
  CP E
  JP C,score_update_4

;--------------------------------
; Добавление ещё одной жизни
  PUSH HL
  PUSH IX
  LD IX,object_lives_indicator
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff
  CALL print_obj_from_buf_to_scr
  LD (IX+$11),$00
  LD A,(IX+$02)
  ADD A,$10
  CP $E9
  JP NC,score_update_3
  LD (IX+$02),A
score_update_3:
  LD A,(lives_1up)
  INC A
  LD (lives_1up),A
  CALL get_free_sound_slot
  ld (HL),sound_live_add
  inc HL
  ld (HL),$20
  POP IX
  POP HL
;--------------------------------

score_update_4:
  LD HL,(score_1up_in_game)
  EXX
  LD HL,current_score_1up+2
  LD A,$01
  LD (scr_score_need_upd),A
; This entry point is used by the routine at game_screen_draw_to_buffer.
print_score_in_game:
  LD B,$03
next_digit:
  LD A,(HL)
  AND $F0
  CALL print_digit
  LD A,(HL)
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  CALL print_digit
  DEC HL
  dec B
  jp nz,next_digit
  RET

; Used by the routine at add_points_to_score.
; Печать цифры счёта на поле
print_digit:
  LD DE,spr_score_digits+2
  ADD A,E
  LD E,A
  JP NC,print_digit_0
  INC D
print_digit_0:
  LD (print_digit_ld_sp_1+$01),DE	; Адрес спрайта цифры
  EXX
  LD (print_digit_ld_hl+$01),HL		; Адрес в буфере
  EX DE,HL

  ld hl,$0000
  add hl,sp
  LD (print_digit_ld_sp_2+$01),hl	; сохраняем SP
  di

  ld hl,$0090
  ADD HL,DE
  LD A,$08
print_digit_ld_sp_1:
  LD SP,$0000		; Адрес спрайта цифры
print_digit_1:
  EX AF,AF'
  POP BC
  LD A,C
  OR (HL)
  XOR B
  LD (DE),A
  inc l
  EX DE,HL
  inc l		; НЕ поправлено направление для Вектора
  EX DE,HL
  EX AF,AF'
  DEC A
  JP NZ,print_digit_1

print_digit_ld_hl:
  LD HL,$0000		; Адрес в буфере
  inc h

print_digit_ld_sp_2:
  LD SP,$0000		; restore SP
  ei
  EXX
  RET

; Used by the routines at add_points_for_left_briks and play_sounds_queue.
; Обновляет участок экрана со счётом текущего игрока
scr_score_update:
  XOR A
  LD (scr_score_need_upd),A
  LD BC,$0608
  LD A,(game_mode)
  CP $02
  JP NZ,scr_score_update_0
  LD HL,$1510
  CALL win_bg_recovery
  LD BC,$0608
  LD HL,$15C0
  JP win_bg_recovery
scr_score_update_0:
  LD HL,$1510
  LD A,(player_number)
  AND A
  JP Z,win_bg_recovery
  LD L,$C0
  JP win_bg_recovery

; Used by the routines at game_restart and briks_calc.
; Поиск адреса уровня по номеру, заданному в ячейке current_level_number_1up
level_addr_calc:
  LD A,(current_level_number_1up)
; This entry point is used by the routine at current_level_2up_copier.
; Поиск адреса уровня по номеру, заданному в А
level_addr_calc_a:
  LD HL,levels
  ADD A,A
  LD E,A
  LD D,$00
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (current_level_addr),HL
  RET

current_level_addr:
  DEFW $0000

; Used by the routines at LBAED, LBB97 and LBC10.
; Постановка игры на паузу клавишами 1, 2, 3 или 4
pause_game:
  CALL press_1_4_check
  RET Z			; Возвращаемся, если не нажата клавиша 1-4
pause_game_0:
  CALL press_1_4_check	; Если нажата, то крутиться здесь, пока не отпустят
  JP NZ,pause_game_0
pause_game_1:
  CALL press_1_4_check	; Если отпустили, то крутится здесь, пока не нажмут
  JP Z,pause_game_1
pause_game_2:
  CALL press_1_4_check	; Если нажали, то крутится здесь, пока не отпустят
  JP NZ,pause_game_2
  RET

; Проверка нажатия клавиш 1-4
; Выход: Z=1: нет нажатия, Z=0: есть нажатие
press_1_4_check:
	ld A,(KEYLINE2)		; Проверка ряда цифр '0'..'7'
	cpl			; Необходимо для правильно установки флага на выходе
	and %00011110		; Маска для клавиш '1'..'4'
	ret

; Used by the routines at input_new_record_name, draw_frame, pause_clear_screen_attrib, print_kinnock, game_restart and LBC10.
clear_screen_attrib:	; Specialist ready
	RET

; Used by the routines at input_new_record_name, draw_frame, game_restart and LBC10.
clear_screen_pix:		; Vector ready
  LD HL,$0000
  LD D,H
  LD E,L
  ADD HL,SP
  LD (clear_screen_1+$01),HL
  LD HL,zx_scr+$2000	; поправка для Вектора
  LD C,$20
  di
clear_screen_3:
  DEC H
  LD SP,HL
  LD B,$60
clear_screen_2:
  PUSH DE
  DEC B
  JP NZ,clear_screen_2
  DEC C
  JP NZ,clear_screen_3
clear_screen_1:
  LD SP,$0000
  ei
  RET

; Used by the routines at input_new_record_name, add_points_for_left_briks, pause_clear_screen_attrib, pause_long and print_kinnock.
; Пауза. Длительность задаётся в регистре D.
pause_short:
  LD E,$FF
pause_short_0:
  DEC E
  JP NZ,pause_short_0
  DEC D
  JP NZ,pause_short
  RET

; Сюда временно сохраняется SP
sp_storage:
  DEFW $0000

; Used by the routines at LBAED, LBB97 and LBC10.
; Сохранение объектов с экранного буфера с тенью и фоном в save_objs_buff
; Перенос объектов (макс. $0B) в буфер
save_objs_to_buff:
  LD IX,object_ball_1
  LD B,$0B
  XOR A
  LD (save_objs_buff),A		; В первой ячейке хранится количество объектов
  LD HL,save_objs_buff+$01
next_obj_to_buff:
  PUSH BC
  LD A,(IX+$00)
  AND A
  CALL NZ,save_one_obj_to_buff
  POP BC
  LD DE,$0016
  ADD IX,DE
  dec B
  jp nz,next_obj_to_buff
  LD (save_obj_buff_end),HL	; Бесполезная команда
  RET

; Сюда один раз сохраняется указатель на конец буфера save_objs_buff,
; но потом это значение никогда не считывается
; Без записи в эту ячейку всё работает без проблем
; Скорее всего сделано для отладки, чтобы выяснить сколько максимум занимает буфер
save_obj_buff_end:
  DEFW $0000

; Routine at 9801
;
; Used by the routine at save_objs_to_buff.
; Сохранение одного объекта с тенью и фоном в текущее место (HL) буфера
save_one_obj_to_buff:

  LD A,(IX+$04)			; координата Y объекта
  CP $C0
  JP C,out_of_bottom	; Переходим, если координата не ниже границы экрана
  SET 7,(IX+$00)		; Делаем объект невидимым (он за пределами экрана)
out_of_bottom:
  BIT 7,(IX+$00)
  RET NZ				; Выходим, если объект за пределами экрана
  LD A,(save_objs_buff)
  INC A
  LD (save_objs_buff),A
  LD C,(IX+$08)			; ширина спрайта с тенью в байтах
  LD A,(IX+$02)			; координата Х объекта
  AND $07
  JP Z,sprite_width_const
  INC C					; если спрайт сдвинут, то увеличиваем его ширину
sprite_width_const:
  LD A,C
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,(IX+$02)		; координата Х правого края объекта
  JP NC,no_cross_right_margin	; переход если не вышло за границы правого края экрана (255)

  LD A,$FF
  SUB (IX+$02)			; координата Х объекта
  SRL A
  SRL A
  SRL A
  INC A
  LD C,A				; номер столбца (1-32)

no_cross_right_margin:
  LD D,(IX+$0A)			; старший адрес в экранном буфере
  LD E,(IX+$0B)			; младший адрес в экранном буфере
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
	ld a,c
  LD (HL),A				; Ширина сохраняемого окна в байтах
  INC HL
  LD B,(IX+$09)			; высота спрайта с тенью в пикселях
  LD (HL),B
  INC HL
  EX DE,HL

; HL - адрес в экранном буфере
; DE - адрес в save_objs_buff
; B - высота спрайта с тенью в пикселях
	ld a,b
	ld (save_obj_02+$01),a
	ld (save_obj_03+$01),a
save_obj_02:
	ld b,$00	; Высота сохраняемого окна
save_obj_01:
	ld a,(hl)
	ld (de),a
	inc l
	inc de
	dec B
	jp nz,save_obj_01
	ld a,l
save_obj_03:
	sub $00		; Высота сохраняемого окна
	ld l,a
	inc h
	dec c
	jp nz,save_obj_02

  EX DE,HL
  RET

; Used by the routine at LBAED.
; Восстанавливает магнит и все объекты
restore_objs_and_magnet:
  LD A,(current_magnet_prop+$01)
  AND A
  JP Z,restore_objs
; Восстанавливаем магнит с фоном и с припуском 5 пикселей
  LD IX,(current_magnet_prop)
  LD A,(IX+$02)			; координата Х объекта
  SUB $05
  LD L,A
  LD A,(IX+$04)			; координата Y объекта
  SUB $05
  LD H,A
  LD BC,$0417
  CALL win_bg_recovery
  XOR A
  LD (current_magnet_prop+$01),A

; This entry point is used by the routines at LBB97 and LBC10.
; Восстанавливает объекты из save_objs_buff в экранный буфер
restore_objs:
  LD A,(save_objs_buff)		; 	Количество восстанавливаемых объектов
  AND A
  RET Z						; Возвращаемся, если нечего восстанавливать
  LD HL,save_objs_buff+$01
next_restore_obj:
  EX AF,AF'
  LD E,(HL)		; младший адрес в экранном буфере
  INC HL
  LD D,(HL)		; старший адрес в экранном буфере
  INC HL
  LD A,(HL)		; шаг отступа для выполнения череды LDI
  ; LD (next_line_restore_obj+$01),A
  INC HL
  LD B,(HL)		; высота спрайта с тенью в пикселях
  INC HL

	ld c,a		; ширина
	ld a,b		; высота спрайта с тенью в пикселях
	ld (rest_obj_02+$01),a
	ld (rest_obj_03+$01),a

rest_obj_02:
	ld b,$00	; Высота восстанавливаемого окна
rest_obj_01:
	ld a,(hl)
	ld (de),a
	inc hl
	inc e
	dec B
	jp nz,rest_obj_01
	ld a,e
rest_obj_03:
	sub $00	; Высота восстанавливаемого окна
	ld e,a
	inc d
	dec c
	jp nz,rest_obj_02

  EX AF,AF'
  DEC A
  JP NZ,next_restore_obj
  RET

  ; LD C,$FF
  ; LD A,E
  ; JP next_line_restore_obj
; check_next_obj:
  ; EX AF,AF'
  ; DEC A
  ; JP NZ,next_restore_obj
  ; RET

  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; LDI
  ; DEC DE
  ; ADD A,$20
  ; LD E,A
  ; JP NC,next_line_restore_obj
  ; INC D
; next_line_restore_obj:
  ; dec B
  ; jp nz,next_line_restore_obj
  ; JP check_next_obj

; Data block at 98DA
; Таблица для настройки процедуры вывода спрайта в зависимости от его размера
table_proc:
  DEFW byte_put_width_1
  DEFW byte_put_width_2
  DEFW byte_put_width_3
  DEFW byte_put_width_4
  DEFW byte_put_width_5
  DEFW byte_put_width_6
  DEFW byte_put_width_7
  DEFW byte_put_width_8

  DEFW byte_put_width_shift_1
  DEFW byte_put_width_shift_2
  DEFW byte_put_width_shift_3
  DEFW byte_put_width_shift_4
  DEFW byte_put_width_shift_5
  DEFW byte_put_width_shift_6
  DEFW byte_put_width_shift_7
  DEFW byte_put_width_shift_8

; Data block at 98FA
; Свойства всех 11-ти наборов спрайтов
; Для сложения с objs_width_sum.
; +$00 - значение для объекта без сдвига по X
; +$01 - значение для объекта со сдвигом по X
objs_width:
  DEFB $08,$0A	; $01 gfx_bat
  DEFB $04,$06	; $02 gfx_ball
  DEFB $00,$00	; $03 gfx_screen_elements
  DEFB $06,$00	; $04 gfx_bonuses
  DEFB $02,$02	; $05 gfx_bullet
  DEFB $04,$04	; $06 anim_rocket
  DEFB $00,$00	; $07 anim_spark
  DEFB $09,$10	; $08 anim_ufo
  DEFB $06,$0C	; $09 anim_bird
  DEFB $04,$09	; $0A anim_alien_blast
  DEFB $05,$07	; $0B gfx_last_sprite

; Routine at 9910
;
; Used by the routines at print_magnets, print_one_magnet, add_points_to_score, bonus_extra_life and game_screen_draw_to_buffer.
; Печатает спрайт с маской в буфер
; На входе: IX = адрес объекта (спрайт с маской)
print_obj_to_buff:
  LD A,(IX+$00)
  BIT 7,A
  RET NZ			; Возвращаемся, если объект невидим (за пределами экрана)
  CP $02
  JP NZ,obj_processing_1	; Переходим, если объект не шарик

; Обработка объекта шарик
  LD A,(object_bat_1+$14)	; применённый к объекту бонус
  CP $07					; spr_bonus_smash
  JP Z,set_big_ball
  LD A,(object_bat_2+$14)	; применённый к объекту бонус
  CP $07					; spr_bonus_smash
  JP NZ,obj_processing

; Установка большого шарика
set_big_ball:
  LD (IX+$01),$08			; spr_big_ball
  RES 7,(IX+$15)

; Обработка длительности действия приза
  LD A,(counter_misc)
  RRA
  JP C,obj_processing		; Переход, если нечётное значение counter_misc
  LD A,(smash_counter)
  INC A
  LD (smash_counter),A		; Увеличение счётчика длительности приза Smash
  CP $F8					; Длительность действия приза Smash
  JP C,obj_processing

; Отключение действия приза, если пришло время
  LD A,(object_bat_1+$14)	; применённый к объекту бонус
  CP $07					; spr_bonus_smash
  JP NZ,not_smash
  LD A,$FF
  LD (object_bat_1+$14),A	; применённый к объекту бонус
not_smash:
  LD A,(object_bat_2+$14)	; применённый к объекту бонус
  CP $07					; spr_bonus_smash
  JP NZ,obj_processing
  LD A,$FF
  LD (object_bat_2+$14),A	; применённый к объекту бонус

; Обработка любого объекта из списка
obj_processing:
  LD A,(IX+$00)
obj_processing_1:
  LD HL,objs_width-$02
  ADD A,A
  CALL hl_add_a
  LD A,(IX+$02)			; координата Х объекта
  AND $07
  JP Z,no_shift_obj
  INC HL
no_shift_obj:
  LD A,(objs_width_sum)
  ADD A,(HL)
  LD (objs_width_sum),A	; Запись суммы ширин objs_width из всех объектов на экране

  CALL sprite_search
  LD HL,table_proc-$02
  LD A,(IX+$04)			; координата Y объекта

  CP $C0
  RET NC				; Возвращаемся, если координата больше 192, то есть объект за пределами экрана

  LD (sp_storage),SP

  BIT 7,(IX+$15)		; BIT7 = 1 - каретка не в процессе трансформации
  LD A,$00
  JP NZ,not_transform	; Переход, если каретка не в процессе трансформации
  LD A,(IX+$02)			; координата Х объекта
not_transform:
  AND $07
  LD C,A
  LD A,(DE)				; ширина в байтах (без учёта маски) (в DE адрес спрайта)
  LD B,A				; ширина в байтах (без учёта маски)
  JP Z,no_shift_obj_2	; Переход, если нет сдвига по X
  ADD A,$08

no_shift_obj_2:
  ADD A,A
  CALL hl_add_a
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (put_byte_1+$01),HL
  LD (put_byte_3+$01),HL
  LD (put_byte_4+$01),HL
  INC DE			; в (DE) - высота в пикселях
  ld a,b
  LD (new_line_bytes_1+$01),A
  LD (new_line_bytes_2+$01),A
  LD H,(IX+$0A)
  LD L,(IX+$0B)		; HL - адрес в экранном буфере
  EX DE,HL			; DE - адрес в экранном буфере
  LD A,(HL)			; A - высота в пикселях
  LD B,A
  EX AF,AF'
  INC HL
  di
  LD SP,HL			; SP - начало пикселей спрайта
  LD A,(IX+$04)		; координата Y объекта
  ADD A,B			; координата Y объекта + высота в пикселях
  CP $C1
  JP C,no_cross_top	; Переход, если объект не пересекает верхнюю границу

  LD A,$C0
  SUB (IX+$04)		; координата Y объекта
  LD B,A			; Остаточная высота спрайта
  EX AF,AF'

no_cross_top:
  LD A,C
  AND A
  JP Z,no_shift_obj_3

  ADD A,A
  ADD A,table_shifts/$100-$02	; $F200/$100-$02=$F0
  LD H,A
  LD (scr_buff_1+$01),DE	; DE - адрес в экранном буфере
  LD A,(DE)
put_byte_4:
  JP put_byte_4

no_shift_obj_3:
  EX DE,HL
  JP put_byte_4

;------------------------------------------------
; В процессе игры ни разу не вызывалась процедура byte_put_width_8
; Вывод спрайта со сдвигом. Процедура настраивается в зависимости от размеров спрайта.
byte_put_width_8:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_7:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_6:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_5:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_4:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_3:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_2:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h
byte_put_width_1:
  POP DE
  LD A,E
  OR (HL)
  XOR D
  LD (HL),A
  inc h

  ld a,h
new_line_bytes_2:
  sub $00
  ld h,a
  inc l
  DEC B
put_byte_1:
  JP NZ,put_byte_1
byte_put_width_0:
  LD HL,(sp_storage)
  ld SP,HL
  ei
  RET

;----------------------------------------------------------------
; byte_put_width_shift_8 и byte_put_width_shift_7 в процессе игры ни разу не вызывались
; Вывод спрайта со сдвигом. Процедура настраивается в зависимости от размеров спрайта.
byte_put_width_shift_8:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_7:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_6:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_5:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_4:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_3:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_2:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
byte_put_width_shift_1:
  POP BC
  LD L,C
  OR (HL)
  LD L,B
  XOR (HL)
  LD (DE),A
  inc d
  INC H
  LD L,C
  LD A,(DE)
  OR (HL)
  LD L,B
  XOR (HL)
  DEC H
  LD (DE),A
  EX AF,AF'
  DEC A
  JP Z,byte_put_width_shift_end
  EX AF,AF'
	ld a,d
new_line_bytes_1:
	sub $00
	ld d,a
	inc e
byte_put_width_shift_0:
  LD A,(DE)
put_byte_3:
  JP put_byte_3

byte_put_width_shift_end:
  LD HL,(sp_storage)
  ld SP,HL
  ei
  RET
;----------------------------------------------------------------
; Routine at 9AC0
; Этот код нигде не вызывается. Дизассемблирован принудительно
  LD A,H
scr_buff_1:
  LD HL,$0000
  LD DE,$0020
  ADD HL,DE
  LD (scr_buff_1+$01),HL
  EX DE,HL
  LD H,A
  JP byte_put_width_shift_0
;----------------------------------------------------------------

; Набор свойств 11 объектов по 22 байта:
; $00 номер набора спрайтов объекта
;		BIT7 = 1 - объект не обрабатывается (за пределами экрана)
; $01 номер спрайта в наборе объекта
; $02 координата Х объекта
; $03
; $04 координата Y объекта
; $05
; $06 направление полёта шарика
; $07 скорость движения: врага - $01, шарика slow bonus - $02. Max - $06
; $08 ширина спрайта с тенью в байтах
; $09 высота спрайта с тенью в пикселях
; $0A старший адрес в экранном буфере
; $0B младший адрес в экранном буфере
; $0C ширина объекта без тени в пикселях
; $0D высота объекта без тени в пикселях
; $0E предыдущая координата Х объекта
; $0F предыдущая координата Y объекта
; $10 предыдущая ширина спрайта с тенью в байтах
; $11 предыдущая высота спрайта с тенью в пикселях
; $12 (у врагов)
; $13 (у врагов / используется при замедлении трёх шариков)
; $14 применяемый к объекту бонус. $FF - нет бонуса
; $15 Свойства каретки:
;		BIT0 = 1 - расширенная каретка
;		BIT1 = 1 - каретка в процессе расширения
;		BIT5 = 1 - каретка в процессе расширения (основной флаг)
;		BIT6 = 1 - каретка в процессе уменьшения
;		BIT7 = 1 - каретка не в процессе трансформации

; Свойства объекта шарик
object_ball_1:
  DEFB $02,$00,$84,$00,$A0,$00,$38,$02
  DEFB $02,$0C,$00,$00,$08,$07,$00,$00
  DEFB $00,$00,$00,$00,$00,$80

; Свойства объекта шарик 2
object_ball_2:
  DEFB $00,$00,$84,$00,$A0,$00,$38,$02
  DEFB $02,$0C,$00,$00,$08,$07,$00,$00
  DEFB $00,$00,$00,$00,$00,$80

; Свойства объекта шарик 3
object_ball_3:
  DEFB $00,$00,$84,$00,$A0,$00,$38,$02
  DEFB $02,$0C,$00,$00,$08,$07,$00,$00
  DEFB $00,$00,$00,$00,$00,$80

; Свойства объекта пуля 1
object_bullet_1:
  DEFB $00,$00,$84,$00,$A0,$00,$30,$01
  DEFB $01,$08,$00,$00,$04,$08,$00,$00
  DEFB $00,$00,$00,$00,$00,$80

; Свойства объекта пуля 2
object_bullet_2:
  DEFB $00,$00,$84,$00,$A0,$00,$30,$01
  DEFB $01,$08,$00,$00,$04,$08,$00,$00
  DEFB $00,$00,$00,$00,$00,$80

; Свойства объекта каретка 2
object_bat_2:
  DEFB $00,$00,$74,$00,$AD,$00,$00,$00
  DEFB $04,$0D,$00,$00,$1C,$0A,$00,$00
  DEFB $00,$00,$F0,$00,$FF,$80

; Свойства объекта каретка 1
object_bat_1:
  DEFB $01,$00,$74,$00,$AD,$00,$00,$00
  DEFB $04,$0D,$00,$00,$1C,$0A,$00,$00
  DEFB $00,$00,$F0,$00,$00,$80

; Свойства объекта каретка 3
object_bat_temp:
  DEFB $00,$03,$84,$00,$AD,$00,$00,$00
  DEFB $03,$0D,$00,$00,$1B,$0A,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Свойства объекта бонус
object_bonus:
  DEFB $00,$00,$28,$00,$9F,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$F0,$60,$00,$00

; Свойства объекта враг (птица или UFO)
object_enemy:
  DEFB $00,$01,$78,$00,$88,$00,$00,$00
  DEFB $03,$18,$00,$00,$18,$18,$00,$00
  DEFB $00,$00,$50,$44,$00,$00

; Свойства объекта ракета
object_rocket:
  DEFB $00,$00,$F8,$00,$A8,$00,$00,$00
  DEFB $03,$1C,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Свойства объекта индикатор жизней
object_lives_indicator:
  DEFB $03,$00,$10,$00,$B9,$00,$00,$00
  DEFB $02,$06,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; В этот объект перед выводом копируются последовательно свойства spr_1up, spr_2up, spr_hi
object_score_indicator:
  DEFB $03,$00,$00,$00,$0C,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; Свойства объекта разделитель поля для двух игроков
object_separator:
  DEFB $03,$05,$7D,$00,$A9,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; Данные окон (спрайтов с фоном) для восстановления из буфера на экран - 7 шт. по 4 байта:
; Первые два байта - координаты
; Вторые два байта - размеры окна
wins_recovery_data:
  DEFB $00,$00,$00,$00
  DEFB $00,$00,$00,$00
  DEFB $00,$00,$00,$00
  DEFB $00,$00,$00,$00
  DEFB $00,$00,$00,$00
  DEFB $00,$00,$00,$00
  DEFB $00,$00,$00,$00

; Счётчик количества окон (спрайтов с фоном) для восстановления из буфера на экран
wins_counter:
  DEFB $00

; Used by the routines at add_points_to_score and bonus_extra_life.
; Вывод на экран объекта уже размещённого в буфере
; Данные для вывода берутся из его свойств в IX
print_obj_from_buf_to_scr:
  LD A,(IX+$00)
  RLA
  JP NC,obj_on_screen
  LD (IX+$00),$00	; Если объект за пределами экрана, то обнуляем его
obj_on_screen:
  LD L,(IX+$02)		; координата Х объекта
  LD A,(IX+$11)		; предыдущая высота спрайта с тенью в пикселях
  AND A
  JP NZ,obj_has_height

; Предыдущая высота спрайта с тенью в пикселях = 0
  LD H,(IX+$04)		; координата Y объекта
  LD A,(IX+$08)		; ширина спрайта с тенью в байтах
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,L
  LD B,A			; В - координата правой стороны объекта
  LD C,(IX+$09)		; высота спрайта с тенью в пикселях
  JP ready_for_restore

; Спрайт имеет какую-то высоту
obj_has_height:
  LD E,L			; координата Х объекта
  LD A,(IX+$0E)		; предыдущая координата Х объекта
  LD D,A
  CP L
  JP NC,obj_has_height_1
  LD L,A
obj_has_height_1:
  LD B,(IX+$08)		; ширина спрайта с тенью в байтах
  SLA B
  SLA B
  SLA B
  LD C,(IX+$10)		; предыдущая ширина спрайта с тенью в байтах
  SLA C
  SLA C
  SLA C
  LD A,E
  ADD A,B
  LD B,A
  LD A,D
  ADD A,C
  CP B
  JP C,obj_has_height_2
  LD B,A
obj_has_height_2:
  LD H,(IX+$04)		; координата Y объекта
  LD D,H
  LD A,(IX+$0F)		; предыдущая координата Y объекта
  LD E,A
  CP H
  JP NC,obj_has_height_3
  LD H,A
obj_has_height_3:
  LD A,D
  ADD A,(IX+$09)	; высота спрайта с тенью в пикселях
  LD D,A
  LD A,E
  ADD A,(IX+$11)	; предыдущая высота спрайта с тенью в пикселях
  CP D
  JP NC,obj_has_height_4
  LD A,D
obj_has_height_4:
  SUB H
  LD C,A

; В - координата правой стороны объекта
; С - высота спрайта с тенью в пикселях
; H - координата Y объекта
; L - координата Х объекта

ready_for_restore:
  LD A,L
  AND $F8
  LD L,A
  CP $F8
  RET NC			; Возвращаемся, если координата Х = $F8 и больше
  CP B
  JP C,ready_for_restore_1
  LD B,$FF			; Прижимаем правую сторону к краю
ready_for_restore_1:
  LD E,L
  BIT 7,A
  JP Z,ready_for_restore_2
  RES 7,L
  RES 7,B
ready_for_restore_2:
  LD A,B
  ADD A,$07
  AND $F8
  SUB L
  SRL A
  SRL A
  SRL A
  LD B,A
  LD L,E

  LD A,(IX+$02)		; координата Х объекта
  LD (IX+$0E),A		; предыдущая координата Х объекта

  LD A,(IX+$04)		; координата Y объекта
  LD (IX+$0F),A		; предыдущая координата Y объекта

  LD A,(IX+$08)		; ширина спрайта с тенью в байтах
  LD (IX+$10),A		; предыдущая ширина спрайта с тенью в байтах

  LD A,(IX+$09)		; высота спрайта с тенью в пикселях
  LD (IX+$11),A		; предыдущая высота спрайта с тенью в пикселях

  LD A,H
  ADD A,C
  CP $C0
  JP C,ready_for_restore_3
  LD A,$C0
  SUB H
  LD C,A
ready_for_restore_3:
  BIT 7,L
  JP Z,ready_for_restore_5
  RES 7,L
  LD A,B
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,L
  SUB $78
  JP C,ready_for_restore_4
  SRL A
  SRL A
  SRL A
  NEG
  ADD A,B
  LD B,A
ready_for_restore_4:
  SET 7,L
ready_for_restore_5:
  LD A,H
  SUB $08
  JP NC,win_bg_recovery
  ADD A,C
  LD C,A
  DEC A
  RLA
  RET C
  LD H,$08

; This entry point is used by the routines at scr_score_update, restore_objs_and_magnet, wins_recovery, game_restart and
; LBC10.
; Копирует прямоугольный участок из буфера на экран c цветом
; HL - Координаты
; BC - Размеры окна
win_bg_recovery:
  PUSH BC
  PUSH HL
  CALL scr_buff_addr_calc
  EX DE,HL
  POP HL
  CALL screen_addr_calc
  EX DE,HL
  POP BC
	ld a,c
	ld (win_bg_recovery_1+$01),a
	ld (win_bg_recovery_3+$01),a
	ld (win_bg_recovery_4+$01),a
win_bg_recovery_1:
	ld c,$00
win_bg_recovery_2:
;	push hl
;	ld a,l
;	rra
;	rra
;	rra
;	or $c0
;	ld l,a
;	ld a,(hl)
;	ld (color_port),a	; Устанавливаем цвет точек
;	pop hl
	ld a,(hl)
	ld (de),a
	inc l
	dec e		; поправка направления для Вектора
	dec c
	jp nz,win_bg_recovery_2
	ld a,l
win_bg_recovery_3:
	sub $00
	ld l,a
	ld a,e
win_bg_recovery_4:
	add $00		; поправка направления для Вектора
	ld e,a
	inc h
	inc d
	dec B
	jp nz,win_bg_recovery_1
	ret

; Сюда сохраняется текущий бонус
current_bonus:
  DEFB $00

; Used by the routine at LAFFC.
; Выбор и установка бонуса
set_bonus:
  LD A,(object_bonus)
  AND A
  RET NZ
  LD A,(game_mode)
  CP $02
  JP NZ,L9D5A_0
  LD A,(LB28F+$01)
  CP $78
  RET Z
L9D5A_0:
  PUSH IY
  EXX
  LD IX,object_bonus
  LD (IX+$00),$04
  LD HL,$0000
  LD (LA557),HL
  LD HL,(LB28F+$01)
  LD (IX+$02),L
  LD (IX+$04),H
  LD A,(object_bat_1+$14)
  LD (current_bonus),A
  LD A,(game_mode)
  CP $02
  JP NZ,L9D5A_1
  LD A,L
  CP $80
  JP C,L9D5A_1
  LD A,(object_bat_2+$14)
  LD (current_bonus),A
L9D5A_1:
  LD (IX+$12),$F0
  LD (IX+$13),$60
  LD (IX+$11),$00
  LD (IX+$0C),$10		; Ширина в пикселях = 16
  LD (IX+$0D),$08		; Высота в пикселях = 8
generate_new_bonus:
  CALL random_generate
  LD A,(random_number+$01)
  AND $0F
  LD HL,bonus_table_current
  CALL hl_add_a
  LD A,(current_bonus)
  CP (HL)
  JP Z,generate_new_bonus
  LD A,(HL)
  CP $04			; $04 - spr_bonus_slow
  JP NZ,L9D5A_6

; Дополнительная обработка замедления
  LD A,(object_ball_1)
  AND A
  JP Z,L9D5A_3
  LD A,(object_ball_1+$07)
  CP $02
  JP Z,generate_new_bonus	; Если шарик уже на самой низкой скорости, то генерировать новый приз
L9D5A_3:
  LD A,(object_ball_2)
  AND A
  JP Z,L9D5A_4
  LD A,(object_ball_2+$07)
  CP $02
  JP Z,generate_new_bonus	; Если второй шарик уже на самой низкой скорости, то генерировать новый приз
L9D5A_4:
  LD A,(object_ball_3)
  AND A
  JP Z,L9D5A_5
  LD A,(object_ball_3+$07)
  CP $02
  JP Z,generate_new_bonus	; Если третий шарик уже на самой низкой скорости, то генерировать новый приз
L9D5A_5:
  JP L9D5A_8

L9D5A_6:
  CP $02					; $02 - spr_bonus_triple_ball
  JP NZ,L9D5A_7

; Дополнительная обработка растроения шарика
  LD A,(balls_quantity)
  DEC A
  JP NZ,generate_new_bonus	; Если шариков больше одного, то генерировать новый приз
  JP L9D5A_8

L9D5A_7:
  CP $05					; $05 - spr_bonus_extra_life
  JP NZ,L9D5A_8

; Дополнительная обработка дополнительной жизни
  LD A,(flag_extra_life)
  AND A
  JP NZ,generate_new_bonus	; Если в раунде жизнь уже выпадала, то генерировать новый приз

L9D5A_8:
  LD A,(HL)
  CP $06					; $06 - spr_bonus_rocket_1
  JP NZ,L9D5A_9

; Дополнительная обработка ракеты
  LD A,(object_rocket)
  AND A
  JP NZ,generate_new_bonus	; Если ракета уже включена, то генерировать новый приз
  LD A,(round_number_1up)
  CP $06
  JP C,L9D5A_9			; Пропускаем, если раунд с 0-го по 5-й
  LD A,(random_number)
  AND $C0
  JP NZ,generate_new_bonus	; Сокращаем вероятность выпадения ракеты

L9D5A_9:
  LD A,(HL)
  DEC A						; $01 - spr_bonus_gun
  JP NZ,L9D5A_10

; Дополнительная обработка пулемёта
  LD A,(game_mode)
  CP $02
  JP NZ,L9D5A_10		; Уходим, если не два игрока одновременно
  LD A,(object_bat_1+$14)
  DEC A
  JP Z,generate_new_bonus	; Если уже есть пулемёт на первой каретке, то генерировать новый приз
  LD A,(object_bat_2+$14)
  DEC A
  JP Z,generate_new_bonus	; Если уже есть пулемёт на второй каретке, то генерировать новый приз

; Обработка всех бонусов
L9D5A_10:
  LD A,(HL)			; Берёт код бонуса
  LD (IX+$14),A			; Помещает код бонуса
  LD (IX+$01),A			; Помещает код бонуса
  CALL calc_write_spr_addr
  EXX
  POP IY
  RET

; Текущая таблица ($10 байт), из которой случайно выбирается бонус
bonus_table_current:
  DEFB $00,$01,$02,$03,$04,$05,$06,$07
  DEFB $08,$09,$00,$04,$00,$03,$01,$02

  DEFB $00,$01,$02,$03,$04,$05,$06,$02
  DEFB $01,$03,$00,$04,$00,$03,$01,$02

; Таблица бонусов для первых 5-ти раундов (0-5)
bonus_table_first:
  DEFB $00,$01,$02,$03,$04,$05,$06,$07
  DEFB $08,$09,$00,$04,$00,$03,$01,$02

  DEFB $00,$01,$02,$03,$04,$05,$06,$02
  DEFB $01,$03,$00,$04,$00,$03,$01,$02

; Таблица бонусов для 6-го и выше раундов (6-F)
bonus_table_second:
  DEFB $00,$01,$02,$03,$02,$00,$06,$07
  DEFB $08,$09,$00,$03,$00,$02,$01,$03

  DEFB $00,$01,$02,$03,$02,$00,$06,$02
  DEFB $01,$03,$00,$03,$00,$02,$01,$03

; Used by the routine at game_restart.
; Делает необходимые приготовления для вывода врагов на раунде
enemy_prepare:
  LD A,(current_level_number_1up)
  CP $04
  RET Z		; Возвращаемся, если текущий уровень - 4

  LD A,(object_bat_1+$14)
  CP $09
  RET Z

  LD A,(object_bat_2+$14)
  CP $09
  RET Z

  LD A,(briks_quantity_1up)
  CP $2C
  RET NC	; Возвращаемся, если осталось 44 и больше кирпичей

  LD A,(object_enemy)
  AND A
  RET NZ	; Возвращаемся, если object_enemy не пустой

  LD HL,object_enemy
  CALL clear_hl_buff16	; Очищаем object_enemy
  LD IX,object_enemy
  LD HL,prop_uneven	; Нечётный раунд
  LD A,(round_number_1up)
  RRA
  JP NC,L9EAA_0
  LD HL,prop_even	; Чётный раунд

; Заполнение object_enemy данными из нужной таблицы
L9EAA_0:
  LD A,(HL)
  LD (IX+$00),A		; Тип врага: 9 - птица, 8 - UFO
  LD (IX+$11),$00
  INC HL
  LD A,(HL)
  LD (IX+$12),A
  INC HL
  LD A,(HL)
  LD (IX+$13),A
  INC HL
  LD A,(HL)
  LD (IX+$0C),A		; Ширина в пикселях
  INC HL
  LD A,(HL)
  LD (IX+$0D),A		; Высота в пикселях
  INC HL
  LD A,(HL)
  LD (IX+$07),A		; Скорость движения
  LD (IX+$01),$00	; Номер спрайта в наборе
  LD (IX+$04),$00	; Координата Y для печати

  LD A,(random_number)
  LD HL,prop_x_coord
  AND $03
  CALL hl_add_a
  LD A,(HL)
  LD (IX+$02),A		; Координата X для печати
  LD (IX+$06),$10
  LD (IX+$14),$10

  LD HL,$0000
  LD (LAA7B),HL
  CALL calc_write_spr_addr
  RET

; Свойство +$02 object_enemy для 4-х раундов подряд
prop_x_coord:
  DEFB $40,$A8,$40,$A8

; Некоторые свойства object_enemy
;+$00,+$12,+$13,+$0C,+$0D,+$07
; Для нечётных раундов
; 09 - птица
prop_uneven:
  DEFB $09,$F0,$70,$18,$0C,$01

; Для чётных раундов
; 08 - UFO
prop_even:
  DEFB $08,$60,$90,$18,$10,$01

; Used by the routine at enemy_prepare.
; Очищает $16 байт в буфере HL
clear_hl_buff16:
  LD BC,$0016
  LD B,C
  JP clear_hl_buff

; Таблица процедур обработки объектов
handling_table_routines:
  DEFW handling_bat_stub	; $01 gfx_bat
  DEFW handling_ball		; $02 gfx_ball
  DEFW handling_ball		; $03 gfx_screen_elements
  DEFW handling_bonus		; $04 gfx_bonuses
  DEFW handling_bullet		; $05 gfx_bullet
  DEFW handling_rocket		; $06 anim_rocket
  DEFW handling_spark		; $07 anim_spark
  DEFW handling_ufo		; $08 anim_ufo
  DEFW handling_bird		; $09 anim_bird
  DEFW handling_blast		; $0A anim_alien_blast
  DEFW handling_400pts		; $0B gfx_last_sprite

; Обработка объекта из IX+$00
handling_object:
  LD HL,handling_table_routines-$02
  LD A,(IX+$00)
  ADD A,A
  CALL hl_add_a
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP (HL)

; Заглушка для обработка каретки. Настоящая обработка ниже.
handling_bat_stub:
  RET

; Used by the routine at game_restart.
; Реальная обработка текущего состояния каретки
handling_bat:
  LD A,(object_bat_temp+$06)	; направление
  CP $1C
  LD A,$00
  JP Z,zero_direction
  LD A,$05
zero_direction:
  LD (objs_width_sum),A	; Записываем $00 или $05, в зависимости от направления

; На какой стороне всё происходит?
  LD A,(IX+$02)	; Координата X биты
  AND $80
  LD (need_change_player),A	; Если координата X меньше 128, то будет 0

; Обработка нажатия клавиш и изменение координат каретки
  LD A,(ctrl_btns_pressed)
  ld C,A
  BIT 1,C		; Нажато Влево
  LD A,(IX+$02)	; Координата X биты
  JP Z,moving_right
  SUB $04		; Уменьшаем координату Х на 4
moving_right:
  BIT 0,C		; Нажато Вправо
  JP Z,moving_left
  ADD A,$04		; Увеличиваем координату Х на 4
moving_left:
  LD (IX+$02),A	; Обновляем координату X каретки

; Проверка и убийство врага
  CALL kill_enemy_by_bat

; Требуется ли изменение размеров каретки?
  LD A,(IX+$15)
  CP $41			; %0100 0001
  JP Z,handling_bat_no_transform
  CP $61			; %0110 0001
  JP Z,handling_bat_no_transform
  AND $C1
  CP $80			; %1000 0000 - Обычная каретка
  JP Z,handling_bat_no_transform
  CP $81			; %1000 0001 - Широкая каретка
  JP Z,handling_bat_no_transform

  LD B,A
  AND $40			; BIT6 %0100 0000
  JP NZ,bat_resize	; переход, если каретка в процессе уменьшения

  LD A,(bonus_flag)
  RLA
  JP C,handling_bat_no_transform		; Переходим, если пулемёт

bat_resize:
  LD (IX+$01),$02	; номер спрайта в наборе объекта - spr_bat_normal_shift
  LD (IX+$08),$03	; ширина спрайта с тенью в байтах
  LD A,$01
  LD (object_bat_temp),A	; gfx_bat
  LD A,(counter_misc)
  LD E,A
  LD A,B
  AND $40
  JP NZ,bat_decrease_size		; Переход, если в процессе уменьшения

; Каретка находится в процессе увеличения
  BIT 0,E			; BIT0 счётчика
  JP Z,no_x_decrease
  DEC (IX+$02)		; Уменьшаем координату Х каретки
no_x_decrease:
  CALL check_margins
  LD A,(IX+$15)
  LD B,A
  AND $1E
  ADD A,(IX+$02)
  ADD A,$08
  LD (object_bat_temp+$02),A
  RR E
  RET C
; Увеличиваем ширину каретки на 2 пикселя
  INC (IX+$0C)		; ширина объекта без тени в пикселях
  INC (IX+$0C)		; ширина объекта без тени в пикселях
  LD A,B			; в В(IX+$15)
  ADD A,$02
  OR $20			; Устанавливаем признак увеличения каретки
  CP $30
  JP Z,bat_increase_size_ready		; Если достигли предела увеличения, то переход
  LD (IX+$15),A
  RET
bat_increase_size_ready:
  LD (IX+$15),$81	; Каретка расширена
  LD (IX+$0C),$2C	; Ширина объекта без тени в пикселях
  JP bat_resize_ready

; Каретка находится в процессе уменьшения
bat_decrease_size:
  BIT 0,E			; BIT0 счётчика
  JP Z,no_x_increase
  INC (IX+$02)		; Увеличиваем координату Х каретки
no_x_increase:
  CALL check_margins
  LD A,(IX+$15)
  AND $3E
  LD B,A
  ADD A,(IX+$02)
  ADD A,$08
  LD (object_bat_temp+$02),A
  RR E
  RET C
  DEC (IX+$0C)		; ширина объекта без тени в пикселях
  DEC (IX+$0C)		; ширина объекта без тени в пикселях
  LD A,B
  SUB $02
  JP C,bat_decrease_size_ready		; Если достигли предела уменьшения, то переход
  OR $40
  LD (IX+$15),A
  RET
bat_decrease_size_ready:
  LD (IX+$0C),$1C	; ширина объекта без тени в пикселях
  LD (IX+$15),$80	; Обычная каретка

bat_resize_ready:
  LD A,(object_bat_temp)
  OR $80
  LD (object_bat_temp),A

  LD A,(IX+$02)
  INC A
  AND $FC
  LD (IX+$02),A		; Увеличиваем координату Х, но не больше $FC (252)
  RRA
  RRA
  AND $01
  LD B,A			; BIT2 координаты X - нужен сдвиг или нет
  LD A,(IX+$15)
  AND $01			; Широкая каретка или нет

  ADD A,A			; 0 (2)
  LD C,A
  ADD A,A			; 0 (4)
  ADD A,B			; 0(1) 4(5)
  LD (IX+$01),A		; номер спрайта в наборе объекта (0-1, 4-5)
  LD A,$04
  ADD A,C			;4 (6)
  LD (IX+$08),A		; ширина спрайта с тенью в байтах (4 или 6)
  RET

; Обработка каретки, когда не требуется её трансформация
handling_bat_no_transform:
  CALL check_left_margin
  CALL check_right_margin
  LD A,(bonus_flag)
  AND A
  JP Z,no_bonus

  push AF
  CALL check_right_margin
  pop AF

  BIT 6,A		; BIT6 bonus_flag
  JP Z,no_bit6

  LD A,(counter_misc)
  RRA
  CALL C,LAAD2

  LD IY,(iy_storage)
  LD DE,$01C8
  CALL sound_beep_cont_d
  ; DI

  LD A,(bonus_flag)
  RLA
  LD A,(IX+$01)
  JP NC,no_bit7_1		; Переход, если BIT7 bonus_flag = 0
  AND A
  RET NZ
  JP check_bat_increase_size
no_bit7_1:
  SUB $0A
  RET NZ

check_bat_increase_size:
  BIT 5,(IX+$15)
  JP Z,normal_bat		; Переход, если каретка не в процессе расширения
  LD (bonus_flag),A
  LD (IX+$15),$22		; Каретка в процессе расширения
  RET

normal_bat:
  LD (IX+$15),$80		; Обычная каретка
  LD (bonus_flag),A
  JP no_bonus

no_bit6:
  RES 7,(IX+$15)		; Каретка в процессе трансформации
  SET 0,(IX+$15)		; Широкая каретка
  RES 1,(IX+$15)		; Каретка не в процессе расширения
  SET 6,(IX+$15)		; Каретка в процессе уменьшения
  RLA
  JP NC,no_bit7_2
  LD (IX+$01),$0C		; spr_bat_normal_shift
  LD (IX+$13),$F0
  LD A,$C0
  LD (bonus_flag),A
  RET

no_bit7_2:
  LD (IX+$13),$AA
  LD (IX+$01),$06		; spr_bat_gun_1
  LD A,$41
  LD (bonus_flag),A
  RET

no_bonus:
  LD A,(IX+$02)			; координата Х объекта
  RRA
  RRA
  AND $01
  LD B,A				; BIT2 координаты Х (сдвинута каретка или нет)
  LD A,(IX+$15)
  AND $01				; BIT0
  ADD A,A
  ADD A,A
  ADD A,B
  LD (IX+$01),A			; номер спрайта каретки (0-1,4-5)

  LD A,(IX+$14)
  DEC A
  RET NZ				; Возвращаемся, если бонус не пулемёт

; Обработка каретки с пулемётом
  LD A,(IX+$01)
  ADD A,$0A
  LD (IX+$01),A			; Заменяем обычную каретку на соответствующую каретку с пулемётом

; Обработка выстрела
  LD A,(bullet)
  SUB $02
  JP C,free_bullet_1
  LD (bullet),A
  RET
free_bullet_1:
  LD A,(ctrl_btns_pressed)
  AND $10
  RET Z
; Нажат Огонь
  LD IY,object_bullet_1
  LD A,(object_bullet_1)
  AND A
  JP Z,free_bullet_2
  LD IY,object_bullet_2
  LD A,(object_bullet_2)
  AND A
  RET NZ
; Включаем пулю, если хотя бы одна из двух пуль свободна
free_bullet_2:
  LD (IY+$00),$05		; gfx_bullet
  LD (IY+$01),$00		; spr_bullet_1
  LD (IY+$09),$08		; высота спрайта с тенью в пикселях
  LD A,(IX+$02)			; координата Х каретки
  ADD A,$0C
  LD (IY+$02),A			; Плюс 12 пикселей к X-координате каретки
  LD (IY+$04),$AC		; 192 - координата Y объекта
  LD (IY+$11),$00
  LD (IY+$15),$00

  LD A,(bullet)
  CPL
  AND $01
  ADD A,$16
  LD (bullet),A

  push HL
  CALL get_free_sound_slot
  ld (HL),sound_shot
  inc HL
  ld (HL),$02
  pop HL

  RET

; Счётчик активных пуль?
bullet:
  DEFB $00

; Used by the routine at game_restart.
; Опрос управления левого игрока
get_left_player_ctrl_state:
  LD A,(game_mode)
  CP $02
  JP NZ,get_control_state_1up	; Переходим на стандартный опрос, если не два игрока одновременно
  LD A,(ctrl_type_1up)
  AND A
  JP NZ,get_control_state_1up	; Переходим на стандартный опрос, если у первого игрока не клавиатура
  LD A,(ctrl_type_2up)
  AND A
  JP NZ,get_control_state_1up	; Переходим на стандартный опрос, если у второго игрока не клавиатура
  ; Опрос клавиатуры для двух игроков одновременно
;  LD C,A		; Обнуляем С
;
;		ld a,#82
;		ld (kb_port_3),a			; Переключаем ВВ55 на чтение рядов
;		ld a,(kb_port_1)
;		ld d,a
;		and %00010000			; Проверка ряда ФЫВАП
;		jp nz,get_left_player_ctrl_state_1
;
;		; Вправо
;		ld a,#91
;		ld (kb_port_3),a			; Переключаем ВВ55 на чтение столбцов
;
;		ld a,%11101111			; Без этого дополнения при нажатии на Огонь, не срабатывают направления
;		ld (kb_port_1),a
;
;		ld a,(kb_port_2)			; Проверка столбцов ФЫВА
;		cpl
;		ld b,a
;		and %0101				; Проверка Ы и А
;		jp z,get_left_player_ctrl_state_2
;		inc c
;
;get_left_player_ctrl_state_2:
;		; Влево
;		ld a,b
;		and %1010				; Проверка Ф и В
;		jp z,get_left_player_ctrl_state_1
;		ld a,c
;		or %00010
;		ld c,a
;
;get_left_player_ctrl_state_1:
;		; Огонь
;		ld a,d
;		and %00100000			; Проверка Й, Ц, У и К
;		jp nz,LA161_2
;		ld a,c
;		or %10000
;		ld c,a

LA161_2:
  LD A,C
  call read_keyboard
  LD (ctrl_btns_pressed),A
  RET

; Used by the routine at game_restart.
; Опрос управления правого игрока
get_right_player_ctrl_state:
  AND A
  JP NZ,get_control_state	; Уходим, если у второго игрока не клавиатура
  LD A,(game_mode)
  CP $02
  LD A,(ctrl_type_2up)
  JP NZ,get_control_state	; Уходим, если не два игрока одновременно
  LD A,(ctrl_type_1up)
  AND A
  LD A,(ctrl_type_2up)
  JP NZ,get_control_state	; Уходим, если у второго игрока не клавиатура
;  LD C,A
;
;		ld a,#82
;		ld (kb_port_3),a			; Переключаем ВВ55 на чтение рядов
;		ld a,(kb_port_1)
;		ld d,a
;		and %00010000			; Проверка ФЫВАП
;		jp nz,get_right_player_ctrl_state_1
;
;		; Вправо
;		ld a,#91
;		ld (kb_port_3),a			; Переключаем ВВ55 на чтение столбцов
;
;		ld a,%11101111			; Без этого дополнения при нажатии на Огонь, не срабатывают направления
;		ld (kb_port_1),a
;
;		ld a,(kb_port_0)			; Проверка столбцов ФЫВА
;		cpl
;		ld b,a
;		and %0101				; Проверка Ж и >
;		jp z,get_right_player_ctrl_state_2
;		inc c
;
;get_right_player_ctrl_state_2:
;		; Влево
;		ld a,b
;		and %1010				; Проверка Д и Э
;		jp z,get_left_player_ctrl_state_1
;		ld a,c
;		or %00010
;		ld c,a
;
;get_right_player_ctrl_state_1:
;		; Огонь
;		ld a,d
;		and %00100000			; Проверка ЕНГШЩЗХ*
;		jp nz,LA19E_2
;		ld a,c
;		or %10000
;		ld c,a

LA19E_2:
  LD A,C
  call read_keyboard
  LD (ctrl_btns_pressed),A
  RET

; Used by the routines at input_new_record_name and get_left_player_ctrl_state.
; Опрос управления первого игрока
get_control_state_1up:
  LD A,(ctrl_type_1up)
; This entry point is used by the routine at get_right_player_ctrl_state.
; Опрос управления
get_control_state:
  AND A
  JP Z,keyboard_ctrl
  DEC A
  JP Z,kempston_ctrl
  DEC A
  JP Z,cursor_ctrl

interface_ii_ctrl:
;		xor a
;		ld c,a
;		ld a,#82
;		ld (kb_port_3),a	; Переключаем ВВ55 на чтение рядов
;		ld a,(kb_port_1)	; Проверка ряда цифр
;		and %01000000
;		jp nz,LA1DB_7	; Уходим, если ни одна цифровая клавиша не нажата
;
;		ld a,#91
;		ld (kb_port_3),a	; Переключаем ВВ55 на чтение столбцов
;
;		ld a,%10111111	; Для исключения блокировки при нажатии на другие клавиши
;		ld (kb_port_1),a
;
;		ld a,(kb_port_0)	; Проверка столбцов с клавишами пробел, влево и вправо
;		cpl
;		ld b,a
;		rra
;		rra
;		rra
;		rra
;		and %11
;		ld c,a
;		ld a,b
;		rla
;		rla
;		rla
;		and %10000
;		or c
		xor a ;DEBUG
		jp LA1DB_71

cursor_ctrl:
;		ld c,a			; Обунляем С
;		ld a,#82
;		ld (kb_port_3),a	; Переключаем ВВ55 на чтение рядов
;		ld a,(kb_port_1)	; Проверка нижнего ряда
;		and %00000100
;		jp nz,LA1DB_7	; Уходим, если ни одна клавиша нижнего ряда не нажата
;		ld a,#91
;		ld (kb_port_3),a	; Переключаем ВВ55 на чтение столбцов
;
;		ld a,%11111011	; Для исключения блокировки при нажатии на другие клавиши
;		ld (kb_port_1),a
;
;		ld a,(kb_port_0)	; Проверка столбцов с клавишами пробел, влево и вправо
;		cpl
;		and %00110100
;		jp z,LA1DB_7
;		rra
;		ld c,a 			; C = %0001 1010
;		rra
;		ld b,a 			; B = %0000 1101
;		rra				; A = %0000 0110
;		or b
;		and %00011
;		ld b,a
;		ld a,c
;		and %10000
;		or b
;		and %10011
		xor a ;DEBUG
  JP LA1DB_71

kempston_ctrl:
  ; Заглушка для Kempston джойстика
  JP LA1DB_71

keyboard_ctrl:
;		ld c,a					; Обунляем С
;		ld a,#82
;		ld (kb_port_3),a			; Переключаем ВВ55 на чтение рядов
;		ld a,(kb_port_1)
;		cpl
;		ld h,a
;		and %00010000			; Проверка ряда ФЫВАПРОЛДЖЭ
;		jp z,keyboard_ctrl_2	; Уходим, если ни одна клавиша ряда не нажата
;
;		; Опрос ВПРАВО
;		ld a,#91
;		ld (kb_port_3),a			; Переключаем ВВ55 на чтение столбцов
;
;		ld a,%11101111			; Без этого дополнения при нажатии на Огонь, не срабатывают направления
;		ld (kb_port_1),a
;
;		ld a,(kb_port_2)			; Проверка столбцов ФЫВА
;		cpl
;		ld d,a
;		and %00000101
;		ld b,a
;		ld a,(kb_port_0)			; Проверка столбцов ПРОЛДЖЭ
;		cpl
;		ld e,a
;		and %01010101
;		or b
;		jp z,keyboard_ctrl_1
;		inc c
;
;keyboard_ctrl_1:
;		; Опрос ВЛЕВО
;		ld a,d
;		and %00001010
;		ld b,a
;		ld a,e
;		and %10101010
;		or b
;		jp z,keyboard_ctrl_2
;		ld a,c
;		or %00010
;		ld c,a
;
;keyboard_ctrl_2:
;		; Опрос ОГОНЬ
;		ld a,h					; Проверка рядов ЙЦУК и ЯЧСМ
;		and %00101000
;		jp z,LA1DB_7
;		ld a,c
;		or %10000
;		ld c,a
;
LA1DB_7:
;  LD A,C
  ;ld a,$10 ;DEBUG
LA1DB_71:
  call read_keyboard
  LD (ctrl_btns_pressed),A
  RET

LA270:
  DEFB $00,$00,$00,$00
LA274:
  DEFB $00,$00,$00,$00
LA278:
  DEFB $00,$00,$00,$00
LA27C:
  DEFB $00,$00

; Обработка шарика
handling_ball:
  LD A,(IX+$12)
  AND $80
  LD (need_change_player),A
  LD A,(counter_2)
  INC A
  LD (counter_2),A
  LD (LA7A6+$02),IX
  PUSH IX
  POP DE
  LD BC,LA270
  LD HL,object_ball_1
  AND A
  CALL SBCHLDE8080	; SBC HL,DE
  JP Z,LA27E_0
  LD BC,LA274
  LD HL,object_ball_2
  AND A
  CALL SBCHLDE8080	; SBC HL,DE
  JP Z,LA27E_0
  LD BC,LA278
LA27E_0:
  LD (LA27C),BC
  LD L,C
  LD H,B
  LD A,(HL)
  AND A
  JP Z,LA27E_1
  DEC (HL)
  JP LA27E_12
LA27E_1:
  INC HL
  LD A,(HL)
  AND A
  JP Z,LA27E_6
  ADD A,(IX+$06)
  AND $3F
  LD (IX+$06),A
  INC HL
  LD B,A
  ADD A,$02
  AND $3C
  LD (HL),A
  AND $0F
  JP NZ,LA27E_4
  LD A,B
  AND $0C
  LD A,(HL)
  JP NZ,LA27E_2
  ADD A,$04
  JP LA27E_3
LA27E_2:
  SUB $04
LA27E_3:
  AND $3F
  LD (HL),A
LA27E_4:
  LD C,(HL)
  INC HL
  LD A,(HL)
  EXX
  LD HL,magnet_properties
  CALL hl_add_a
  PUSH HL
  POP IY
  BIT 0,(IY+$01)
  JP NZ,LA27E_5
  CALL obj_compare
  JP NC,LA27E_5
  EXX
  PUSH BC
  CALL LAD69
  CALL check_margins
  LD E,(IX+$06)
  POP BC
  PUSH DE
  LD (IX+$06),C
  PUSH BC
  CALL LA27E_24
  POP BC
  LD A,(IX+$06)
  CP C
  POP DE
  RET NZ
  LD (IX+$06),E
  RET
LA27E_5:
  LD HL,(LA27C)
  LD (HL),$02
  INC HL
  LD (HL),$00
  EXX
  LD (IX+$06),C
  JP LA27E_23
LA27E_6:
  LD A,(magnets_quantity)
  AND A
  JP Z,LA27E_12
  LD B,A
  LD IY,magnet_properties
LA27E_7:
  BIT 0,(IY+$01)
  JP NZ,LA27E_8
  PUSH BC
  CALL obj_compare
  POP BC
  JP C,LA27E_9
LA27E_8:
  LD DE,$0010
  ADD IY,DE
  dec B
  jp nz,LA27E_7
  JP LA27E_12
LA27E_9:
  PUSH IY
  POP HL
  LD DE,magnet_properties
  AND A
  CALL SBCHLDE8080	; SBC HL,DE
  LD E,L
  LD HL,(LA27C)
  LD (HL),$00
  INC HL
  LD B,$00
  LD A,(IX+$06)
  ADD A,$10
  AND $3F
  CP $20
  JP C,LA27E_10
  LD B,$FE
LA27E_10:
  LD C,$FF
  LD A,(IY+$04)
  ADD A,$04
  CP (IX+$04)
  JP C,LA27E_11
  LD A,B
  XOR $FE
  LD B,A
LA27E_11:
  LD A,C
  XOR B
  LD (HL),A
  INC HL
  INC HL
  LD (HL),E
LA27E_12:
  LD A,(IX+$14)
  AND A
  JP Z,LA27E_20
  DEC A
  LD (IX+$14),A
  JP Z,LA27E_15
  LD A,(game_mode)
  CP $02
  JP NZ,LA27E_13
  LD A,(IX+$02)
  CP $88
  JP NC,LA27E_18
  CP $80
  JP C,LA27E_13
  LD A,(IX+$15)
  AND $7F
  CP $0A
  JP C,LA27E_18
LA27E_13:
  LD A,(ctrl_btns_pressed)
  AND $10
  JP NZ,LA27E_15	; Нажат ОГОНЬ
  LD A,(object_bat_1+$14)
  AND $7F
  CP $03
  JP NZ,LA27E_15
  LD A,(object_bat_1+$02)
LA27E_14:
  LD B,A
  LD A,(IX+$15)
  AND $7F
  ADD A,B
  LD (IX+$02),A
  LD (IX+$04),$A7
  CALL check_margins
  JP LA27E_25
LA27E_15:
  LD (IX+$14),$00
  LD (IX+$04),$A9
  LD A,(object_bat_1+$14)
  RLA
  JP NC,LA27E_16
  LD A,$FF
  LD (object_bat_1+$14),A
LA27E_16:
  LD A,(IX+$15)
  AND $7F
  ADD A,$24
  CP $30
  JP NZ,LA27E_17
  LD A,$34
LA27E_17:
  LD (IX+$06),A
  LD A,(IX+$15)
  AND $80
  LD (IX+$15),A
  LD (IX+$04),$A6
  LD A,(IX+$12)
  AND $80
  LD (IX+$12),A
  push HL
  CALL get_free_sound_slot
  ld (HL),sound_ball_start
  inc HL
  ld (HL),$02
  pop HL
  JP LA27E_25
LA27E_18:
  LD A,(ctrl_btns_pressed_copy)
  AND $10
  JP NZ,LA27E_19
  LD A,(object_bat_2+$14)
  AND $7F
  CP $03
  JP NZ,LA27E_19
  LD A,(object_bat_2+$02)
  JP LA27E_14
LA27E_19:
  LD (IX+$14),$00
  LD (IX+$04),$A9
  LD A,(object_bat_2+$14)
  RLA
  JP NC,LA27E_16
  LD A,$FF
  LD (object_bat_2+$14),A
  JP LA27E_16
LA27E_20:
  LD A,(counter_misc)
  LD C,A
  AND $03
  JP NZ,LA27E_23
  LD A,(IX+$12)
  INC A
  LD (IX+$12),A
  AND $7F
  CP $7F
  JP NZ,LA27E_22
  LD A,(IX+$12)
  AND $80
  LD (IX+$12),A
  LD A,(IX+$06)
  ADD A,$04
  AND $0F
  JP NZ,LA27E_21
  LD A,$04
LA27E_21:
  LD B,A
  LD A,(IX+$06)
  AND $30
  OR B
  LD (IX+$06),A
LA27E_22:
  LD A,C
  AND $07
  JP NZ,LA27E_23
  INC (IX+$13)
  LD A,(IX+$13)
  SUB $94
  JP NZ,LA27E_23
  LD (IX+$13),A

  LD A,(IX+$07)		; Увеличение скорости. Max - $06
  CP $06
  JP Z,LA27E_23
  INC A
  LD (IX+$07),A

LA27E_23:
  CALL LAD69
  LD E,(IX+$06)
  CALL bounce_wall
  LD A,(IX+$06)
  CP E
  CALL NZ,set_sound_bat_beat
LA27E_24:
  CALL LAB1F
  CALL LAFFC
  CALL kill_enemy_by_bat
LA27E_25:
  SET 7,(IX+$15)
  LD A,(IX+$02)
  AND $07
  LD (IX+$01),A
  LD A,(IX+$04)
  CP $C0
  RET C
  LD HL,(LA27C)
  LD (HL),$00
  INC HL
  LD (HL),$00
  SET 7,(IX+$00)
  LD A,(balls_quantity)
  DEC A
  LD (balls_quantity),A
  RET

; Used by the routines at handling_bat and handling_ball.
; Проверка и убивание врага кареткой, если условия соблюдены
kill_enemy_by_bat:
  LD A,(object_enemy)
  AND $7F
  RET Z		; Возвращаемся, если нет врага
  CP $0A
  RET Z		; Возвращаемся, если враг уже в состоянии взрыва
  LD IY,object_enemy
  CALL obj_compare_2pix
  RET NC	; Возвращаемся, если нет пересечения с кареткой

; This entry point is used by the routine at get_bonus.
; Убивание врага, его взрыв, звук и начисление очков
kill_enemy:
  LD (IY+$00),$0A	; anim_alien_blast
  LD (IY+$01),$00
  LD (IY+$12),$50
  LD (IY+$13),$90
  LD A,(IY+$08)
  SUB $02
  ADD A,A
  ADD A,A
  ADD A,(IY+$02)
  LD (IY+$02),A
  LD (IY+$08),$02
  LD (IY+$09),$0D
  LD A,(IY+$04)
  ADD A,$04
  LD (IY+$04),A
  LD A,(IX+$00)
  AND $7F
  CP $02
  JP NZ,LA4CF_4
  LD A,(IX+$06)
  AND $10
  LD DE,$1030
  JP Z,LA4CF_1
  LD DE,$0020
LA4CF_1:
  LD A,(random_number+$01)
  LD B,A
  RLA
  JP C,LA4CF_2
  LD E,D
LA4CF_2:
  LD A,B
  AND $0C
  JP NZ,LA4CF_3
  LD A,(IX+$06)
  AND $0C
LA4CF_3:
  OR E
  LD (IX+$06),A
  LD A,(IX+$12)
  AND $80
  LD (IX+$12),A
LA4CF_4:
  PUSH IX
  LD IX,sounds_queue+21
  LD (IX+$00),$06
  LD (IX+$01),$30
  POP IX
  LD BC,$0350
  JP add_points_to_score

LA557:
  DEFW $0000
LA559:
  DEFB $00

; Обработка бонусов
handling_bonus:
  LD A,(IX+$04)
  CP $A0
  CALL NC,get_bonus
  LD DE,$0008
  LD B,$02
; This entry point is used by the routine at handling_400pts.
LA55A_0:
  LD HL,(LA557)
  ADD HL,DE
  LD A,H
  CP B
  JP NZ,LA55A_1
  LD H,B
  LD L,$00
LA55A_1:
  LD (LA557),HL
  LD D,(IX+$04)
  LD A,(LA559)
  LD E,A
  ADD HL,DE
  LD (IX+$04),H
  LD A,L
  LD (LA559),A
  LD A,H
  CP $C0
  RET C
  SET 7,(IX+$00)
  RET

; Обработка таблички 400 очков
handling_400pts:
  LD A,(IX+$02)
LA590:
  ADD A,$00
  LD (IX+$02),A
  CALL check_left_margin
  CALL check_right_margin
  LD DE,$0028
  LD B,$80
  JP LA55A_0

; Обработка пули
handling_bullet:
  LD A,(IX+$02)
  AND $80
  LD (need_change_player),A
  LD A,(counter_2)
  INC A
  LD (counter_2),A
  LD A,(IX+$01)
  CP $02
  JP NC,LA5A3_0
  XOR $01
  LD (IX+$01),A
  LD A,(IX+$04)
  SUB $06
  LD (IX+$04),A
  JP C,LA5A3_1
  CP $03
  JP NC,LA5A3_2
  JP LA5A3_1
LA5A3_0:
  LD A,(IX+$02)
  AND $F8
  LD (IX+$02),A
  CALL LAAD2
  LD A,(IX+$01)
  AND A
  RET NZ
LA5A3_1:
  SET 7,(IX+$00)
  LD A,(bullet)
  AND $01
  LD (bullet),A
  RET
LA5A3_2:
  CALL LAFFC
  LD A,(object_enemy)
  AND $7F
  RET Z
  CP $0A
  RET Z
  LD IY,object_enemy
  CALL obj_compare_2pix
  RET NC
  LD (IY+$00),$0A		; anim_alien_blast
  LD (IY+$01),$00		; spr_alien_blast_1
  LD (IY+$12),$50
  LD (IY+$13),$90
  LD A,(IY+$08)			; ширина спрайта с тенью в байтах
  SUB $02
  ADD A,A
  ADD A,A
  ADD A,(IY+$02)		; координата Х объекта
  LD (IY+$02),A			; координата Х объекта
  LD (IY+$08),$02		; ширина спрайта с тенью в байтах
  LD (IY+$09),$0D		; высота спрайта с тенью в пикселях
  LD A,(IY+$04)			; координата Y объекта
  ADD A,$04
  LD (IY+$04),A			; координата Y объекта
  LD (IX+$01),$02		; spr_alien_blast_3
  LD (IX+$09),$06
  LD (IX+$12),$50
  LD (IX+$13),$50
  LD A,(IX+$02)			; координата Х объекта
  AND $F8
  LD (IX+$02),A			; координата Х объекта

  PUSH IX
  LD IX,sounds_queue+21
  LD (IX+$00),$06
  LD (IX+$01),$30
  POP IX

  LD BC,$0350
  JP add_points_to_score

; Счётчик длительности приза Smash
smash_counter:
  DEFB $00

; Used by the routine at get_bonus.
; Постановка в очередь звука расширения каретки
push_resize_sound:
  push HL
  CALL get_free_sound_slot
  ld (HL),sound_bat_resize_2
  inc HL
  ld (HL),$02
  pop HL
  RET

bonus_flag_copy:
  DEFB $00

; Used by the routines at get_bonus and game_restart.
; Обмен содержимым ячеек bonus_flag_copy и bonus_flag
bonus_flag_swap:
  LD A,(bonus_flag_copy)
  LD B,A
  LD A,(bonus_flag)
  LD (bonus_flag_copy),A
  LD A,B
  LD (bonus_flag),A
  RET

; Used by the routine at handling_bonus.
; Получение бонуса
get_bonus:
  CP $B0
  RET NC
  LD IY,object_bat_1
  CALL obj_compare_2pix
  JP C,LA67B_0			; Если поймал первой кареткой, то дальше

  LD A,(game_mode)
  CP $02
  RET NZ				; Уходим, если не два игрока одновременно

  LD IY,object_bat_2
  CALL obj_compare
  RET NC				; Уходим, если не поймал второй кареткой

  CALL bonus_flag_swap
  CALL LA67B_0
  JP bonus_flag_swap

LA67B_0:
  LD A,(IX+$01)
  SUB $0A
  JP NZ,LA67B_1			; Если не бомба переходим на обработку бонусов
  LD (balls_quantity),A	; Обнуляем количество шаров
  RET

; Собственно обработка бонуса

; IY - каретка
; IX - бонус

LA67B_1:
  LD A,(IY+$02)			; Координата Х каретки
  AND $80
  LD (need_change_player),A
  XOR A
  LD (smash_counter),A
  LD BC,$0400
  CALL add_points_to_score	; Добавляем 400 очков за бонус

  LD A,(IX+$14)
  CP $05
  CALL NZ,push_resize_sound	; Если не spr_bonus_extra_life

  DEC (IY+$14)
  JP NZ,LA67B_2
  LD A,$80
  LD (bonus_flag),A	; Если у каретки признак пулемёта, то записываем сюда $80
LA67B_2:
  LD A,(counter_misc)
  AND $01
  INC A
  NEG
  LD (LA557+$01),A
  XOR A
  LD (LA557),A
  LD A,(random_number)
  LD B,A
  AND $01
  INC A
  RL B
  JP C,LA67B_3
  NEG
LA67B_3:
  LD (LA590+$01),A
  LD (IX+$00),$0B		; gfx_last_sprite
  LD (IX+$01),$00		; spr_400_points
  CALL calc_write_spr_addr

  LD A,(IX+$14)
  CP $06		; spr_bonus_rocket_1
  JP Z,get_rocket

  LD (IY+$14),A
  LD A,(IY+$14)
  CP $01
  JP NZ,LA67B_4

; Поймали пулемёт
  LD (bonus_flag),A	; $01
  LD A,$01

LA67B_4:
  AND A
  JP Z,bonus_resize 	; Бонус расширитель

  PUSH AF
  LD A,(IY+$0C)
  CP $22
  JP C,LA67B_5
  XOR A
  LD (object_bat_temp+$11),A
  LD (IY+$15),$4E
  LD (IY+$01),$04			; spr_bonus_slow
  push HL
  CALL get_free_sound_slot
  ld (HL),sound_triple_ball
  inc HL
  ld (HL),$10
  pop HL
  LD A,(counter_misc)
  AND $FE
  LD (counter_misc),A
LA67B_5:
  POP AF

  CP $08			; spr_bonus_5000_points
  JP NZ,LA67B_6
; Поймали 5000 очков
  LD BC,$5000
  JP add_points_to_score

LA67B_6:
  CP $09			; spr_bonus_kill_aliens
  JP NZ,LA67B_7
  LD A,(object_enemy)
  AND $7F
  RET Z
  CP $0A
  RET Z
  PUSH IX
  LD IX,LA67B_6
  LD IY,object_enemy
  CALL kill_enemy
  POP IX
  RET

LA67B_7:
  CP $05			; spr_bonus_extra_life
  JP Z,bonus_extra_life
  CP $04			; spr_bonus_slow
  JP NZ,LA67B_8

; Замедление шарика
  LD (IY+$14),$FF
  LD A,$02
  LD (object_ball_1+$07),A
  LD (object_ball_2+$07),A
  LD (object_ball_3+$07),A
  LD HL,(random_number)
  LD A,L
  AND $1F
  ADD A,$1F
  LD (object_ball_1+$13),A
  LD A,H
  AND $1F
  ADD A,$1F
  LD (object_ball_2+$13),A
  LD A,H
  ADD A,L
  AND $1F
  ADD A,$1F
  LD (object_ball_3+$13),A
  RET

LA67B_8:
  CP $02			; spr_bonus_triple_ball
  RET NZ

; Размножение шариков
  LD A,$03
  LD (balls_quantity),A
  LD (IY+$14),$FF
LA7A6:
  LD IY,$0000
  LD L,(IY+$02)
  LD H,(IY+$04)

  LD A,(IY+$06)
  AND $0F
  LD DE,$080C	; Если +$06 = $04  (0100)
  CP $04
  JP Z,LA67B_9
  LD DE,$040C	; Если +$06 = $08 (1000)
  CP $08
  JP Z,LA67B_9
  LD DE,$0408	; Если +$06 = предположительно $0C (1100)
LA67B_9:
  LD A,(IY+$06)
  AND $30
  OR E
  LD (ball2_direction+$03),A
  LD A,(IY+$06)
  AND $30
  OR D
  LD (ball3_direction+$03),A

  LD D,(IY+$07)		; Скорость
  LD C,(IY+$00)
  LD B,(IY+$01)
  LD IY,object_ball_1
  LD A,(object_ball_1)
  AND A
  JP Z,LA67B_10
; Копирование свойств первого шарика во второй + своё направление
  LD IY,object_ball_2
LA67B_10:
  LD (IY+$02),L
  LD (IY+$04),H
  LD (IY+$00),$02		; gfx_ball
  LD (IY+$11),$00
  LD (IY+$07),D			; Скорость
  LD (IY+$00),C
  LD (IY+$01),B
ball2_direction:
  LD (IY+$06),$00		; Направление шарика
  LD IY,object_ball_2
  LD A,(object_ball_2)
  AND A
  JP Z,LA67B_11
; Копирование свойств первого шарика в третий + своё направление
  LD IY,object_ball_3
LA67B_11:
  LD (IY+$02),L
  LD (IY+$04),H
  LD (IY+$00),$02		; gfx_ball
  LD (IY+$11),$00
  LD (IY+$07),D			; Скорость
  LD (IY+$00),C
  LD (IY+$01),B
ball3_direction:
  LD (IY+$06),$00		; Направление шарика
  RET

; Поймали расширитель каретки
bonus_resize:
  XOR A
  LD (object_bat_temp+$11),A
  LD (IY+$15),$20
  LD A,(bonus_flag)
  AND A
  JP Z,LA67B_13
  LD A,$0A				; spr_bat_gun
LA67B_13:
  LD (IY+$01),A			; spr_bat_normal
  push HL
  CALL get_free_sound_slot
  ld (HL),sound_bat_resize_1
  inc HL
  ld (HL),$C0
  pop HL
  LD A,(counter_misc)
  AND $FE
  LD (counter_misc),A
  RET

; Сюда помещается $80, если бонус пулемёт
; $00 - ничего нет
; $41 - пулемёт
; $C0 - обычная с шифтом
bonus_flag:
  DEFB $00

; Used by the routine at get_bonus.
; Получение дополнительной жизни
bonus_extra_life:
  PUSH IX
  LD IX,object_lives_indicator
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff
  CALL print_obj_from_buf_to_scr
  LD (IX+$11),$00
  LD A,(IX+$02)
  ADD A,$10
  CP $E9
  JP NC,LA860_0
  LD (IX+$02),A
LA860_0:
  CALL get_free_sound_slot
  ld (HL),sound_live_add
  inc HL
  ld (HL),$20
  POP IX
  LD A,$01
  LD (flag_extra_life),A
  LD A,(lives_1up)
  INC A
  LD (lives_1up),A
  RET

; Флаг того, что жизнь на раунде уже выпадала
flag_extra_life:
  DEFB $00

; Обработка ракеты
handling_rocket:
  LD A,(counter_misc)
  AND $01
  LD (IX+$01),A
  CALL calc_write_spr_addr
  LD HL,(LA8CF)
  LD DE,$FFE0
  ADD HL,DE
  LD A,(counter_misc)
  CP $38
  JP C,LA89A_0
  LD (LA8CF),HL
LA89A_0:
  LD A,(LA8D1)
  LD E,A
  LD D,(IX+$04)
  ADD HL,DE
  LD A,L
  LD (LA8D1),A
  LD A,H
  LD (IX+$04),A
  SUB $06
  LD (object_bat_1+$04),A
  LD (object_bat_2+$04),A
  RET

LA8CF:
  DEFB $00,$00
LA8D1:
  DEFB $00

; Обработка искр
handling_spark:
  CALL LAD69
  LD A,(IX+$04)
  CP $C0
  JP NC,LA8D2_0
  CALL bounce_wall
  DEC (IX+$15)
  RET NZ
  LD A,(IX+$01)
  CP $04
  JP Z,LA8D2_0
  INC (IX+$01)
  CALL calc_write_spr_addr
  LD A,(IX+$14)
  SRL A
  LD (IX+$14),A
  INC A
  LD (IX+$15),A
  RET
LA8D2_0:
  SET 7,(IX+$00)
  RET

; Обработка UFO
handling_ufo:
  LD A,(IX+$04)
  CP $08
  JP NC,LA902_0
  INC (IX+$04)
  RET
LA902_0:
  CALL bomb_appear
  LD HL,(LAA7B)
  LD A,H
  AND A
  JP Z,LA902_1
  CALL LAA44
  JP LA902_2
LA902_1:
  LD B,$01
  LD A,(counter_misc)
  AND $03
  CALL Z,LAA7D
  CALL LAD69
  CALL LAFFC
  CALL check_margins
LA902_2:
  LD A,(IX+$04)
  CP $C0
  JP C,LA902_3
  SET 7,(IX+$00)
  RET
LA902_3:
  LD A,(counter_misc)
  AND $00
  CALL Z,LAAD2
  LD A,(flag_2)
  AND A
  JP NZ,LAA7D_1
  RET

;---------------------------------------------
; Нигде неиспользуемый код Мусор?
; Routine at A94B
; LA94B:
;   AND $04
;   LD C,A
;   LD A,(IX+$06)
;   ADD A,$10
;   AND $3F
;   CP $20
;   JP NC,LA94B_0
;   INC C
;   INC C
; LA94B_0:
;   LD B,$00
;   LD HL,LA96F
;   ADD HL,BC
;   LD A,(HL)
;   LD (IX+$01),A
;   INC HL
;   LD A,(HL)
;   LD (IX+$13),A
;   LD (IX+$12),$F0
;   RET

LA96F:
  DEFB $01,$44
  DEFB $05,$84
  DEFB $0D,$F0
  DEFB $09,$C0

;---------------------------------------------
; Used by the routines at handling_ufo and handling_bird.
; Включение бомбы
bomb_appear:
  LD A,(object_bonus)
  AND A
  RET NZ					; Возвращаемся, если уже какой-то бонус падает

  LD A,(random_number)
  LD B,A
  LD A,(random_number+$01)
  ADD A,B
  AND $3F
  RET NZ					; Возвращаемся, если случайный номер не удовлетворяет условиям

  LD (object_bonus+$11),A	; Помещаем случайный номер
  LD A,(IX+$04)				; координата Y каретки?
  ADD A,$08
  CP $C0
  RET NC					; Возвращаемся, если пролетела

  LD (object_bonus+$04),A	; координата Y объекта
  LD A,$04
  LD (object_bonus),A		; gfx_bonuses
  LD A,(IX+$02)				; координата Х объекта
  ADD A,$08
  LD (object_bonus+$02),A	; координата Х объекта
  LD A,$0A
  LD (object_bonus+$01),A	; spr_bomb
  LD A,$08
  LD (object_bonus+$0C),A
  LD (object_bonus+$0D),A
  LD HL,$1002
  LD (object_bonus+$08),HL	; Ширина и высота
  LD HL,$0000
  LD (LA557),HL
  RET

handling_bird:
  LD A,(IX+$04)
  CP $08
  JP NC,LA9BC_0
  INC (IX+$04)
  RET
LA9BC_0:
  CALL bomb_appear
  LD A,(IX+$06)
  SUB $10
  AND $3F
  LD (LAA02+$01),A
  LD HL,(LAA7B)
  LD A,H
  AND A
  JP Z,LA9BC_1
  CALL LAA44
  JP LA9BC_2
LA9BC_1:
  LD B,$01
  LD A,(counter_misc)
  AND $03
  CALL Z,LAA7D
  CALL LAD69
  CALL LAFFC
  CALL check_margins
LA9BC_2:
  LD A,(IX+$04)
  CP $C0
  JP C,LA9BC_3
  SET 7,(IX+$00)
  RET
LA9BC_3:
  CALL LAAD2
LAA02:
  LD C,$00
  LD A,(IX+$06)
  SUB $10
  AND $3F
  XOR C
  AND $20
  JP Z,LA9BC_5
  LD A,(IX+$13)
  LD (IX+$13),A
  BIT 5,C
  JP Z,LA9BC_4
  LD A,$0E
  SUB (IX+$01)
  JP LA9BC_5
LA9BC_4:
  LD A,(IX+$01)
  XOR $07
  ADD A,$07
LA9BC_5:
  LD A,(flag_2)
  AND A
  JP NZ,LAA7D_1
  RET

; Обработка взрыва врага
handling_blast:
  LD (IX+$13),$90
  CALL LAAD2
  LD A,(IX+$01)
  AND $3F
  CP $09
  RET NZ
  SET 7,(IX+$00)
  RET

; Used by the routines at handling_ufo and handling_bird.
LAA44:
  LD A,L
  CP $10
  JP NC,LAA44_0
  LD L,$10
  LD (LAA7B),HL
LAA44_0:
  LD A,(IX+$02)
  CP L
  JP Z,LAA44_2
  JP C,LAA44_1
  DEC (IX+$02)
  DEC (IX+$02)
LAA44_1:
  INC (IX+$02)
LAA44_2:
  LD A,(IX+$04)
  CP H
  JP Z,LAA44_4
  JP C,LAA44_3
  DEC (IX+$04)
  RET
LAA44_3:
  INC (IX+$04)
  RET
LAA44_4:
  LD A,(IX+$02)
  CP L
  RET NZ
  LD HL,$0000
  LD (LAA7B),HL
  RET

LAA7B:
  DEFW $0000

; Used by the routines at handling_ufo and handling_bird.
LAA7D:
  LD A,(IX+$06)
  LD L,A
  SUB (IX+$14)
  JP Z,LAA7D_1
  BIT 5,A
  LD A,B
  JP NZ,LAA7D_0
  NEG
LAA7D_0:
  ADD A,L
  AND $3F
  LD (IX+$06),A
  RET
; This entry point is used by the routines at handling_ufo and handling_bird.
LAA7D_1:
  LD A,(random_number)
  AND $3F
  LD (IX+$14),A
  RET

; Used by the routine at get_bonus.
; Получение бонуса ракеты
get_rocket:
  LD A,$06
  LD (object_rocket),A
  XOR A
  LD (object_rocket+$11),A
  LD (LBB83+$01),IY		; IY - объект каретка
  LD A,(IY+$0C)
  CP $1C
  LD A,$04
  JP Z,LAA9D_0
  LD A,$0C
LAA9D_0:
  ADD A,(IY+$02)
  LD (object_rocket+$02),A
  LD A,(IY+$04)
  ADD A,$06
  LD (object_rocket+$04),A
  LD A,$1B
  LD (spr_bonus_rocket_1+$01),A
  LD HL,$0000
  LD (LA8CF),HL
  INC (IY+$14)
  RET

; Used by the routines at handling_bat, handling_bullet, handling_ufo, handling_bird and handling_blast.
LAAD2:
  LD A,(IX+$12)
  LD B,A
  SUB $40
  JP NC,LAAD2_1
  LD A,(IX+$01)
  AND $3F
  INC A
  LD E,A
  LD A,(IX+$13)
  LD D,A
  RRCA
  RRCA
  RRCA
  RRCA
  AND $0F
  CP E
  JP NC,LAAD2_0
  LD A,D
  AND $0F
  LD E,A
LAAD2_0:
  LD (IX+$01),E
  LD A,B
  ADD A,A
  ADD A,A
  AND $C0
  OR (IX+$12)
  EX AF,AF'
  CALL calc_write_spr_addr
  EX AF,AF'
LAAD2_1:
  LD (IX+$12),A
  RET

; Used by the routines at set_bonus, enemy_prepare, get_bonus, handling_rocket, handling_spark and LAAD2.
; Вычисляет спрайт из IX+0 и IX+1, и записывает его размер в IX+$08 и IX+9
calc_write_spr_addr:
  CALL sprite_search
  LD A,(DE)
  LD (IX+$08),A
  INC DE
  LD A,(DE)
  LD (IX+$09),A
  RET

; Used by the routines at handling_ball and LAB1F.
set_sound_bat_beat:
  push HL
  CALL get_free_sound_slot
  ld (HL),sound_bat_beat
  pop HL
  RET

; Used by the routine at handling_ball.
LAB1F:
  LD A,(IX+$04)
  CP $98
  RET C
  LD A,(IX+$0F)
  CP $AA
  RET NC
  LD IY,object_bat_1
  CALL obj_compare
  JP C,LAB1F_0
  LD A,(game_mode)
  CP $02
  RET NZ
  LD IY,object_bat_2
  CALL obj_compare
  RET NC
LAB1F_0:
  RES 7,(IX+$12)
  BIT 7,(IY+$02)
  JP Z,LAB1F_1
  SET 7,(IX+$12)
LAB1F_1:
  CALL set_sound_bat_beat
  LD A,(IY+$14)
  CP $03
  JP NZ,LAB1F_4
  LD A,(IY+$0C)
  CP $1C
  JP NZ,LAB1F_4
  LD A,(IX+$02)
  SUB (IY+$02)
  JP NC,LAB1F_2
  XOR A
LAB1F_2:
  AND $FC
  CP $19
  JP C,LAB1F_3
  LD A,$18
LAB1F_3:
  LD B,A
  LD A,(IX+$15)
  AND $80
  OR B
  LD (IX+$15),A
  LD (IX+$14),$B0
  LD (IX+$04),$A7
  RET
LAB1F_4:
  LD (IX+$04),$A6
  LD A,(IX+$12)
  AND $80
  LD (IX+$12),A
  LD A,(IY+$0C)
  LD HL,LABEE
  CP $1C
  JP Z,LAB1F_5
  LD HL,LABFC
LAB1F_5:
  LD A,(IX+$02)
  ADD A,$03
  SUB (IY+$02)
  JP C,LAB1F_7
LAB1F_6:
  CP (HL)
  JP C,LAB1F_7
  INC HL
  INC HL
  JP LAB1F_6
LAB1F_7:
  INC HL
  LD A,(HL)
  BIT 2,A
  JP NZ,LAB1F_8
  JP LAB1F_10
LAB1F_8:
  CALL LAB1F_9
  LD A,(HL)
  CALL LAB1F_10
LAB1F_9:
  LD A,(IX+$06)
  XOR $1F
  INC A
  AND $3F
  LD (IX+$06),A
  RET
LAB1F_10:
  AND $03
  ADD A,A		; *2
  LD B,A
  ADD A,A		; *4
  ADD A,B		; *6
  LD HL,LAC0A
  CALL hl_add_a
  LD A,$04
LAB1F_11:
  CP (IX+$06)
  JP Z,LAB1F_12
  INC HL
  ADD A,$04
  CP $10
  JP NZ,LAB1F_11
  ADD A,$04
  JP LAB1F_11
LAB1F_12:
  LD A,(HL)
  LD (IX+$06),A
  RET

LABEE:
  DEFB $04,$07,$08,$06,$0C,$05,$10,$00
  DEFB $14,$01,$18,$02,$FF,$03
LABFC:
  DEFB $06,$07,$0C,$06,$12,$05,$1A,$00
  DEFB $20,$01,$26,$02,$FF,$03
LAC0A:
  DEFB $3C,$38,$34,$2C,$28,$24,$3C,$38
  DEFB $34,$34,$34,$34,$3C,$38,$38,$34
  DEFB $38,$38,$3C,$3C,$38,$38,$3C,$3C

; Used by the routines at handling_ball, get_bonus and LAB1F.
; Сравнивает координаты двух объектов, заданных в IX и IY
; Без захлёста
obj_compare:
  LD L,(IX+$02)	; Координата Х для печати
  LD A,(IY+$02)	; Координата Х для печати
  LD C,(IX+$0C)	; Ширина объекта без тени в пикселях
  LD B,(IY+$0C)	; Ширина объекта без тени в пикселях
  CALL LAC22_0
  RET NC
  LD L,(IX+$04)	; Координата Y для печати
  LD A,(IY+$04)	; Координата Y для печати
  LD C,(IX+$0D)	; Высота объекта без тени в пикселях
  LD B,(IY+$0D)	; Высота объекта без тени в пикселях
LAC22_0:
  SUB L			; X IY минус X IX
  JP C,LAC22_1	; Переход, если X IX больше X IY
  SUB C			; и отнимаем от расстояния между X IY и X IX ширину IX
  RET
LAC22_1:
  ADD A,B		; и добавляем расстоянию между X IY и X IX ширину IY
  RET

; Used by the routines at kill_enemy_by_bat, handling_bullet and get_bonus.
; Сравнивает координаты двух объектов, заданных в IX и IY
; С захлёстом в 2 пикселя
obj_compare_2pix:
  LD L,(IX+$02)	; Координата Х для печати
  LD A,(IY+$02)	; Координата Х для печати
  LD C,(IX+$0C) ; Ширина объекта без тени в пикселях
  LD B,(IY+$0C) ; Ширина объекта без тени в пикселях
  CALL LAC45_0
  RET NC
  LD L,(IX+$04)	; Координата Y для печати
  LD A,(IY+$04)	; Координата Y для печати
  LD C,(IX+$0D)	; Высота объекта без тени в пикселях
  LD B,(IY+$0D) ; Высота объекта без тени в пикселях
LAC45_0:
  SUB L			; X IY минус X IX
  JP C,LAC45_1	; Переход, если X IX больше X IY
  DEC C			; Иначе уменьшаем ширину IX на 2
  DEC C
  SUB C			; и отнимаем от расстояния между X IY и X IX ширину IX
  RET
LAC45_1:
  DEC B			; Уменьшаем ширину IY на 2
  DEC B
  ADD A,B		; и добавляем расстоянию между X IY и X IX ширину IY
  RET

; Used by the routines at handling_bat, handling_ball, handling_ufo and handling_bird.
; Не даёт объекту выйти за пределы поля
check_margins:
  CALL check_top_margin
  CALL check_left_margin
  JP check_right_margin

; Used by the routines at handling_ball and handling_spark.
; Отскок от стенки
bounce_wall:
  LD B,$3F
  CALL check_top_margin
  CALL C,change_direction
  LD B,$1F
  CALL check_left_margin
  CALL C,change_direction
  CALL check_right_margin
  RET C
  JP change_direction

;---------------------------
; Нигде неиспользуемый код Мусор?
; Data block at AC8C
  LD A,(IX+$04)
  CP $AF
  RET C
  LD (IX+$04),$AF
  RET
;---------------------------

; Used by the routines at check_margins and bounce_wall.
; Проверка, чтобы содержимое IX+$04 не опускалось ниже $08
; Упираемся объектом в верхний край экрана
check_top_margin:
  LD A,(IX+$04)
  CP $08
  RET NC
  LD (IX+$04),$08
  RET

; Used by the routines at handling_bat, handling_400pts, check_margins and bounce_wall.
; Проверка, чтобы содержимое IX+$02 не опускалось ниже $08
; Упираемся объектом в левый край экрана
check_left_margin:
  LD A,(IX+$02)
  CP $08
  RET NC
  LD (IX+$02),$08
  RET

; Used by the routine at game_restart.
; Проверка, чтобы содержимое IX+$02 не опускалось ниже $80.
; Если было ниже, то сброс 0 бита IX+$01
LACAD:
  LD A,(IX+$02)
  CP $80
  RET NC
  LD (IX+$02),$80
  RES 0,(IX+$01)
  RET

; Used by the routines at handling_bat, handling_400pts, check_margins and bounce_wall.
; Упираемся объектом в правый край экрана
check_right_margin:
  LD A,(IX+$0C)
  ADD A,(IX+$02)	; Складываем значение IX+$0C и IX+$02
  CP $F9
  RET C				; Возвращаемся, если сумма меньше $F9
  LD A,$F8
  SUB (IX+$0C)
  LD (IX+$02),A		; Иначе помещаем в IX+$02 значение $F8 - IX+$0C
  RET

; Used by the routine at game_restart.
LACCE:
  LD A,(IX+$0C)
  ADD A,(IX+$02)
  CP $80
  RET C
  LD A,$80
  SUB (IX+$0C)
  LD (IX+$02),A
  LD A,(IX+$0C)
  CP $1C
  JP Z,LACCE_0
  CP $2C
  RET NZ
LACCE_0:
  SET 0,(IX+$01)
  RET

; Used by the routines at bounce_wall and LAFFC.
; Изменение направления в зависимости от B
change_direction:
  LD A,(IX+$06)		; направление полёта шарика
  XOR B
  INC A
  AND $3F
  LD (IX+$06),A		; направление полёта шарика
  RET

; Used by the routine at LAD13.
LACF9:
  LD H,$00
  LD B,H
  LD L,H
  LD D,(IX+$07)
  LD A,$08
  JP LAD04_0
LAD04:
  DEC A
  RET Z
  SLA C
  RL B
LAD04_0:
  SRL D
  JP NC,LAD04
  ADD HL,BC
  JP NZ,LAD04
  RET

; Used by the routine at LAD69.
LAD13:
  PUSH BC
  CALL LACF9
  POP BC
  INC B
  RET NZ

  LD A,L
  CPL
  LD L,A
  LD A,H
  CPL
  LD H,A	; CPL HL

  INC HL
  RET

; Used by the routine at LAD69.
; Высчитываются значения HL и BC по таблице, а зависимости от направления движения
hl_bc_calc_direction:
  LD HL,direction_table
  LD A,(IX+$06)		; Направление
  AND $0F
  LD B,A
  CALL hl_add_a
  LD C,(HL)			; C = YY из таблицы, в зависимости от направления
  LD A,B
  XOR $0F
  INC A
  LD HL,direction_table
  CALL hl_add_a
  LD L,(HL)			; L = XX из таблицы, в зависимости от направления

  LD H,$00			; HL = $00XX, BC = $00YY
  LD B,H
  LD A,(IX+$06)		; Направление
  AND $30
  RET Z				; Если направление $00, то HL = $00XX, BC = $00YY

  CP $10
  JP NZ,LAD22_0
  LD A,L
  LD L,C
  LD C,A
  DEC B
  RET				; Если направление $10, то HL = $00YY, BC = $FFXX

LAD22_0:
  CP $20
  JP NZ,LAD22_1
  DEC H
  DEC B
  RET				; Если направление $20, то HL = $FFXX, BC = $FFYY

LAD22_1:
  LD A,C
  LD C,L
  LD L,A
  DEC H
  RET				; Если направление $30, то HL = $FFYY, BC = $00XX

; Из этой таблицы в зависимости от направления движения выбираются значения для HL и BC
direction_table:
  DEFB $FF,$FD,$FA,$F4,$E6,$E0,$D4,$C5
  DEFB $B4,$A1,$8D,$78,$61,$4A,$31,$18

  DEFB $00

; Used by the routines at handling_ball, handling_spark, handling_ufo and handling_bird.
LAD69:
  CALL hl_bc_calc_direction
  PUSH HL

  CALL LAD13
  LD D,(IX+$02)		; координата Х объекта
  LD E,(IX+$03)
  ADD HL,DE
  LD (IX+$02),H		; координата Х объекта
  LD (IX+$03),L

  POP BC

  CALL LAD13
  LD D,(IX+$04)		; координата Y объекта
  LD E,(IX+$05)
  ADD HL,DE
  LD (IX+$04),H		; координата Y объекта
  LD (IX+$05),L

  RET

; Used by the routine at all_metal_briks_animation_snd.
; Печатает текущий кадр анимации перелива всех металлических кирпичей
; На входе в IX адрес текущего кадра анимации (IX - anim_brik)
all_metal_briks_frame:
  LD IY,(current_level_addr)
  LD HL,zx_scr+$00E0 ; Адрес в экранной области начала рисования кирпичей
  LD B,$0C
LAD8F_0:
  PUSH BC
  PUSH HL
  CALL line_metal_briks_frame
  POP HL
  ld a,$f8 ;LD A,$08	; поправка для Вектора
  ADD L
  LD L,A
LAD8F_1:
  POP BC
  dec B
  jp nz,LAD8F_0
  RET

; Used by the routine at all_metal_briks_frame.
; Печатает одну строку текущего кадра металлических кирпичей
line_metal_briks_frame:
  LD B,$0F
LADAC_0:
  PUSH BC
  PUSH HL
  CALL print_frame_metal_brik
  POP HL
  INC H
  INC H
  POP BC
  INC IY
  dec B
  jp nz,LADAC_0
  RET

; Used by the routine at line_metal_briks_frame.
; Рисует текущий кадр одного металлического кирпича, если это он
; В IX указатель на текущий спрайт анимации перелива кирпича
; В HL - адрес в экранной области
print_frame_metal_brik:
  ld a,(IY+$00)
  BIT 7,a
  RET NZ	; Возвращаемся, если BIT7 = 1
  BIT 4,a
  RET NZ	; Возвращаемся, если BIT4 = 1

	; Выясняем и установка цвет кирпича
	ld a,h
	sub zx_scr/256 - scr_buff/256
	ld d,a
	ld a,l
	sub zx_scr%256 - scr_buff%256
	rra
	rra
	rra
	or %11000000
	ld e,a
;	ld a,(de)
;	ld (LADBC_01+$01),a	; Устанавливаем цвет для левой половины кирпича
	inc d
	ld a,(de)
;	ld (LADBC_02+$01),a	; Устанавливаем цвет для правой половины кирпича

	; Индивидуальная обработка чёрного кирпича
	IFDEF MX
	; Ничего не делаем
	ELSE
	or a
	jp nz,print_frame_metal_brik_01
	ld a,(anim_brik+$0e)%256
	cp ixl
	jp nz,print_frame_metal_brik_01
	ld a,(anim_brik+$0e)/256
	cp ixh
	jp nz,print_frame_metal_brik_01
	xor a
	ld (print_frame_metal_brik_02),a
	ld ix,anim_brik_black
print_frame_metal_brik_01:
	ENDIF

  LD E,(IX+$00)
  LD D,(IX+$01)
  LD (LADDD+$01),SP
  EX DE,HL
  di
  LD SP,HL
  EX DE,HL
  LD B,$08	; 8 строк по 2 байта
LADBC_0:
  POP DE

LADBC_01:
;  ld a,$00
;  ld (color_port),a	; Цвет левой половины кирпича (на случай тени)

  LD (HL),E
  INC H

LADBC_02:
;  ld a,$00
;  ld (color_port),a	; Цвет правой половины кирпича

  LD (HL),D
  DEC H
  dec L			; поправлено направление для Вектора
  dec B
  jp nz,LADBC_0
LADDD:
  LD SP,$0000
  ei

	; Индивидуальная обработка чёрного кирпича
	IFDEF MX
	; Ничего не делаем
	ELSE
print_frame_metal_brik_02:
	ret
	ld ix,anim_brik+$0e
	ld a,$c9
	ld (print_frame_metal_brik_02),a
	ENDIF

  RET

; Used by the routine at game_screen_draw_to_buffer.
; Вывод в буфер всех кирпичей уровня
print_briks:
  LD IY,(current_level_addr)
  LD HL,scr_buff+$0120			; Адрес начала кирпичей в буфере (было scr_buff+$401)
  LD (brik_addr_buf),HL
  LD HL,attr_buff+$0205			; Адрес начала атрибутов кирпичей в буфере (было attr_buff+$A2)
  LD (brik_attr_buf),HL
  LD B,$0C	; Высота уровня
LADE1_0:
  PUSH BC
  PUSH IY
  CALL print_line_briks
  POP IY

	IFDEF MX
  CALL brik_shadow
	ELSE
  ld b,$0f
LADE1_01:
  inc iy
  dec B
  jp nz,LADE1_01
	ENDIF

  LD HL,(brik_addr_buf)
  ld a,l
  add $08
  ld l,a
  LD (brik_addr_buf),HL
  LD HL,(brik_attr_buf)
  inc l
  LD (brik_attr_buf),HL
  POP BC
  dec B
  jp nz,LADE1_0
  RET

; Used by the routine at print_briks.
print_line_briks:
  LD B,$0F	; Ширина уровня
  LD HL,(brik_addr_buf)
LAE13_0:
  PUSH BC
  PUSH HL
  BIT 7,(IY+$00)
  CALL Z,print_one_brik_buf	; 	Печатаем кирпич, если не пустота
  POP HL
  INC H
  INC H
  INC IY
  POP BC
  dec B
  jp nz,LAE13_0
  RET

; Used by the routine at print_briks.
	IFDEF MX
brik_shadow:
  LD B,$0F
  LD HL,(brik_attr_buf)
brik_shadow_0:
  BIT 7,(IY+$00)
  JP NZ,brik_shadow_1
  ld a,(hl)
  and %01110111
  ld (hl),a
  inc h
  ; Проверка на правый крайний столбец - обрамление поля
  ld a,h
  sub attr_buff/$100
  CPL
  AND $1F
  JP Z,brik_shadow_1
  ld a,(hl)
  and %01110111
  ld (hl),a
  JP brik_shadow_2
brik_shadow_1:
  inc h
brik_shadow_2:
  inc h
  INC IY
  dec B
  jp nz,brik_shadow_0
  RET
	ENDIF

;-----------------------------------------------

; Used by the routine at print_line_briks.
; Печатает один цветной кирпич в буфер
; В HL - координаты кирпича
; В IY - ссылка не текущий код кирпича
print_one_brik_buf:
  LD (LAEB4+$01),SP	; Сохраняем стек

; Оформление верхнего края кирпича
  PUSH HL
  dec l

	IFDEF MX
  LD (HL),$00	; Линия над кирпичом
  inc h
  LD (HL),$00	; Линия над кирпичом
	ELSE
  LD (HL),$00	; Линия над кирпичом
  inc h
  LD (HL),$00	; Линия над кирпичом

  ; LD (HL),$ff	; Линия над кирпичом
  ; inc h
  ; LD (HL),$ff	; Линия над кирпичом
	ENDIF

  POP HL

; Оформление левого края кирпича
  ; Проверка на левый крайний кирпич
  ld a,h

  PUSH HL

	ld c,h

  cp scr_buff/256+1
  JP Z,LAE82_1


  dec h
  LD B,$08
LAE82_0:

	IFDEF MX
  RES 0,(HL)	; Сброс стороны справа от кирпича
	ELSE
  ; SET 0,(HL)	; Сброс стороны справа от кирпича

  RES 0,(HL)	; Сброс стороны справа от кирпича

	ENDIF

  inc l
  dec B
  jp nz,LAE82_0
LAE82_1:

; Раскрашивание кирпича
  LD HL,(brik_attr_buf)	; Адрес атрибутов текущего кирпича
  ld h,c
  dec l
  PUSH HL
  LD A,(IY+$00)
  AND $0F
  LD HL,briks_colors-$01
  CALL hl_add_a
  LD B,(HL)
  POP HL
  LD (HL),B
  inc h
  LD (HL),B

  POP HL
; Рисование кирпича
  di
	LD SP,spr_brik_1

	IFDEF MX
	; Ничего не делаем
	ELSE
	ld a,b
	or a
	jp nz,LAE82_21
	LD SP,spr_brik_black
LAE82_21:
	ENDIF

  LD A,$08
LAE82_2:
  POP BC
  LD (HL),C
  INC H
  LD (HL),B
  dec h
  inc l
  DEC A
  JP NZ,LAE82_2

LAEB4:
  LD SP,$0000	; Восстанавливаем стек
  ei
  ; Оформление левого края кирпича
  ld c,h		; Номер знакоместа второй половины кирпича
  LD (HL),A
  inc h
  LD (HL),A
  ; Проверка на левый крайний кирпич
  ld a,h
  cp scr_buff/256+$1e
  ret Z
  inc h
  dec l

  LD B,$08
LAE82_3:
  ; В обеих версиях рисуем эту линию
  RES 7,(HL)		; Сброс стороны слева кирпича
  dec l
  dec B
  jp nz,LAE82_3
  RET

; Цвета кирпичей
briks_colors:
	IFDEF MX
  DEFB c57,c4F,c5F,c20,c70	; Цвета обычных кирпичей
  DEFB c47,c57,c5F,c4F		; Цвета трудновыбиваемых кирпичей
  DEFB c00					; Не используется
  DEFB c47,c57,c4F,c5F		; Цвета невыбиваемых кирпичей
  DEFB c00					; Не используется
	ELSE
  DEFB $50,$C0,$40,$90,$10	; Цвета обычных кирпичей
  DEFB $00,$50,$40,$C0		; Цвета трудновыбиваемых кирпичей
  DEFB $D0					; Не используется
  DEFB $00,$50,$C0,$40		; Цвета невыбиваемых кирпичей
  DEFB $D0					; Не используется
	ENDIF

; Хранит адреса пикселей и атрибутов в буфере текущего кирпича
brik_addr_buf:
  DEFW $0000
brik_attr_buf:
  DEFW $0000

; Графика кирпичей
  INCLUDE "./gfx/briks.asm"

; Анимация переливания кирпича
anim_brik:
  DEFW spr_brik_2
  DEFW spr_brik_6
  DEFW spr_brik_3
  DEFW spr_brik_7
  DEFW spr_brik_4
  DEFW spr_brik_5
  DEFW spr_brik_5
  DEFW spr_brik_1
  DEFW $0000

	; Индивидуальная обработка чёрного кирпича
	IFDEF MX
	; Ничего не делаем
	ELSE
anim_brik_black:
  DEFW spr_brik_black
  DEFW $0000
	ENDIF


; Used by the routine at LBBFB.
; Добавляет двум игрокам поровну очки за оставшиеся на раунде кирпичи
add_points_for_left_briks:
  LD IY,(current_level_addr)
  XOR A
  LD (brik_value+$01),A
  LD (need_change_player),A
  LD C,$0C		; Высота раунда
add_points_for_left_briks_0:
  LD B,$0F		; Ширина раунда
add_points_for_left_briks_1:
  PUSH BC
  LD A,(IY+$00)
  AND $A0
  JP NZ,add_points_for_left_briks_2	; Если пустое место, то пропускаем

  CALL points_calc_and_add
  CALL scr_score_update
  LD A,(need_change_player)
  XOR $01
  LD (need_change_player),A

add_points_for_left_briks_2:
  PUSH IY
  CALL play_sounds_queue
  POP IY
  LD D,$03
  CALL pause_short
  INC IY
  POP BC
  dec B
  jp nz,add_points_for_left_briks_1
  LD A,(brik_value+$01)
  INC A
  LD (brik_value+$01),A
  DEC C
  JP NZ,add_points_for_left_briks_0
  RET

; Used by the routines at add_points_for_left_briks and LAFFC.
; Вычисляет сколько очков добавлять исходя из значения brik_value+$01
points_calc_and_add:
  LD A,(brik_value+$01)
  ADD A,A
  LD HL,points_table
  CALL hl_add_a
  LD B,(HL)
  INC HL
  LD C,(HL)		; В BC нужное количество очков
  LD A,(IY+$00)	; В IY текущий элемент уровня
  AND $0F
  CP $06			; Если цвет меньше 6 (то есть обычный кирпич), то
  JP C,add_points_to_score	; добавляем одинарное количество очков
  LD A,C
  ADD A,C
  DAA
  LD C,A
  LD A,B
  ADC A,B
  DAA
  LD B,A
  JP add_points_to_score	; Добавляем двойное количество очков

; Таблица добавления очков
points_table:
  DEFB $01,$20	;120
  DEFB $01,$10	;110
  DEFB $01,$00	;100
  DEFB $00,$90	; 90
  DEFB $00,$80	; 80
  DEFB $00,$70	; 70
  DEFB $00,$60	; 60
  DEFB $00,$50	; 50
  DEFB $00,$40	; 40
  DEFB $00,$30	; 30
  DEFB $00,$20	; 20
  DEFB $00,$10	; 10

; Used by the routines at handling_ball, handling_bullet, handling_ufo and handling_bird.
LAFFC:
  XOR A
  LD (flag_2),A
  LD A,(IX+$04)
  CP $80
  RET NC
  ADD A,(IX+$0D)
  CP $20
  RET C
  LD IY,(current_level_addr)
  LD DE,$000F
  LD H,D
  LD B,$0C
  LD C,$20
LAFFC_0:
  LD A,C
  SUB (IX+$04)
  JP C,LAFFC_1
  SUB (IX+$0D)
  JP C,LAFFC_3
  JP LAFFC_2
LAFFC_1:
  ADD A,$08
  JP C,LAFFC_3
LAFFC_2:
  ADD IY,DE
  LD A,C
  ADD A,$08
  LD C,A
  INC H
  dec B
  jp nz,LAFFC_0
  RET

LAFFC_3:
  LD A,H
  LD (brik_value+$01),A
  LD A,(IX+$04)
  ADD A,(IX+$0D)
  SUB C
  LD (LB087+$01),A
  LD H,C
  LD A,(IX+$02)
  LD BC,$1008
  SUB C
LAFFC_4:
  SUB B
  JP C,LAFFC_5
  INC IY
  LD E,A
  LD A,C
  ADD A,B
  LD C,A
  LD A,E
  JP LAFFC_4
LAFFC_5:
  LD (LB069+$01),A
  LD L,C

  LD D,$0F

  BIT 7,(IY+$00)
  JP Z,LAFFC_7
  LD A,L
  CP $E8
  JP Z,LAFFC_6
  LD A,(IX+$0C)
LB069:
  ADD A,$00
  JP NC,LAFFC_6
  SET 7,D
  LD E,L
  LD A,$10
  ADD A,L
  LD L,A
  INC IY
  BIT 7,(IY+$00)
  JP Z,LAFFC_7
  LD L,E
  DEC IY
LAFFC_6:
  LD A,H
  CP $78
  RET NC
  LD C,$08
  ADD A,C
  LD H,A
LB087:
  LD A,$00
  SUB C
  RET C
  LD B,$00
  LD C,$0F
  ADD IY,BC
  PUSH HL
  POP HL
  LD A,(brik_value+$01)
  INC A
  LD (brik_value+$01),A
  BIT 7,(IY+$00)
  JP Z,LAFFC_7
  BIT 7,D
  RET Z
  LD A,L
  ADD A,$10
  LD L,A
  INC IY
  BIT 7,(IY+$00)
  RET NZ
LAFFC_7:
  LD (LB28F+$01),HL
  PUSH HL
  LD L,(IX+$02)
  LD H,(IX+$04)
  LD (LB1C3+$01),HL
  POP HL
  RES 7,D
  LD A,L
  CP $E8
  JP Z,LAFFC_8
  BIT 7,(IY+$01)
  JP NZ,LAFFC_9
LAFFC_8:
  RES 1,D
LAFFC_9:
  CP $08
  JP Z,LAFFC_10
  BIT 7,(IY-$01)
  JP NZ,LAFFC_11
LAFFC_10:
  RES 0,D
LAFFC_11:
  LD A,H
  CP $21
  JP C,LAFFC_12
  BIT 7,(IY-$0F)
  JP NZ,LAFFC_12
  RES 2,D
LAFFC_12:
  CP $78
  JP NC,LAFFC_13
  BIT 7,(IY+$0F)
  JP NZ,LAFFC_13
  RES 3,D
LAFFC_13:
  LD A,D
  LD (LB292+$01),A
  LD A,(IX+$00)
  AND $3F
  CP $05
  JP Z,LAFFC_29
  LD A,(IX+$06)
  LD (LB28B+$03),A
  CP $20
  JP NC,LAFFC_14
  RES 3,D
  JP LAFFC_15
LAFFC_14:
  RES 2,D
LAFFC_15:
  ADD A,$10
  AND $3F
  CP $20
  JP NC,LAFFC_16
  RES 1,D
  JP LAFFC_17
LAFFC_16:
  RES 0,D
LAFFC_17:
  LD A,D
LAFFC_18:
  SRL A
  LD B,$1F
  JP NC,LAFFC_19
  JP Z,LAFFC_26
  JP LAFFC_21
LAFFC_19:
  SRL A
  JP NC,LAFFC_20
  JP Z,LAFFC_27
  JP LAFFC_21
LAFFC_20:
  LD B,$3F
  SRL A
  JP NC,LAFFC_29
  JP Z,LAFFC_28
LAFFC_21:
  BIT 0,D
  JP Z,LAFFC_22
  LD A,(IX+$0C)
  ADD A,(IX+$02)
  SUB L
  JP LAFFC_23
LAFFC_22:
  LD A,L
  ADD A,$10
  SUB (IX+$02)
LAFFC_23:
  LD C,A
  BIT 2,D
  JP Z,LAFFC_24
  LD A,(IX+$0D)
  ADD A,(IX+$04)
  SUB H
  JP LAFFC_25
LAFFC_24:
  LD A,H
  ADD A,$08
  SUB (IX+$04)
LAFFC_25:
  LD E,D
  CP C
  RES 2,D
  RES 3,D
  JP NC,LAFFC_17
  LD A,E
  AND $0C
  JP LAFFC_18
LAFFC_26:
  LD A,L
  SUB (IX+$0C)
  LD (IX+$02),A
  CALL change_direction
  JP LAFFC_30
LAFFC_27:
  LD A,L
  ADD A,$10
  LD (IX+$02),A
  CALL change_direction
  JP LAFFC_30
LAFFC_28:
  LD A,H
  SUB (IX+$0D)
  LD (IX+$04),A
  CALL change_direction
  JP LAFFC_30
LAFFC_29:
  LD A,H
  ADD A,$08
  LD (IX+$04),A
  CALL change_direction
  JP LAFFC_30
LAFFC_30:
  LD A,$01
  LD (flag_2),A
  LD A,(IX+$00)
  AND $7F
  CP $02
  JP Z,LAFFC_32
  CP $05
  JP Z,LAFFC_31
  AND $FE
  CP $08
  RET NZ
  LD L,(IX+$02)
  LD H,(IX+$04)
  LD (LAA7B),HL
LB1C3:
  LD HL,$0000
  LD (IX+$02),L
  LD (IX+$04),H
  RET
LAFFC_31:
  LD (IX+$01),$02
  LD (IX+$09),$06
  LD A,(IX+$02)
  AND $F8
  LD (IX+$02),A
  LD (IX+$12),$50
  LD (IX+$13),$50
  JP LAFFC_33
LAFFC_32:
  BIT 5,(IY+$00)
  JP NZ,LAFFC_34
  LD A,(object_bat_1+$14)
  CP $07
  JP Z,LAFFC_38
  LD A,(object_bat_2+$14)
  CP $07
  JP Z,LAFFC_38
LAFFC_33:
  BIT 4,(IY+$00)
  JP NZ,LAFFC_38
  BIT 5,(IY+$00)
  JP NZ,LAFFC_34
  SET 4,(IY+$00)
LAFFC_34:
  LD HL,(LB28F+$01)
  LD DE,$0007
  PUSH IX
  LD IX,briks_data
  LD B,$05
LAFFC_35:
  LD A,(IX+$00)
  AND A
  JP Z,LAFFC_36
  ADD IX,DE
  dec B
  jp nz,LAFFC_35
  JP LAFFC_37
LAFFC_36:
  PUSH HL
  CALL screen_addr_calc
  LD (IX+$01),L
  LD (IX+$02),H
  POP HL
  CALL scr_buff_addr_calc
  LD (IX+$03),L
  LD (IX+$04),H
  INC (IX+$00)
  PUSH IY
  POP DE
  LD (IX+$05),E
  LD (IX+$06),D
LAFFC_37:
  LD IX,sounds_queue+28
  LD (IX+$00),$02
  LD (IX+$01),$09
  LD (IX+$02),$B0
  POP IX
  RET
LAFFC_38:
  LD A,(briks_quantity_1up)
  DEC A
  LD (briks_quantity_1up),A
  CALL points_calc_and_add
  LD A,(IX+$00)
  AND $7F
  CP $02
  JP NZ,LB28F
  LD A,(IX+$12)
  AND $80
  LD (IX+$12),A
  LD A,(object_bat_1+$14)
  CP $07
  JP Z,LAFFC_39
  LD A,(object_bat_2+$14)
  CP $07
  JP NZ,LB28F
LAFFC_39:
  LD HL,(LB1C3+$01)
  LD (IX+$02),L
  LD (IX+$04),H
LB28B:
  LD (IX+$06),$00
LB28F:
  LD HL,$0000		; Координаты на экране
LB292:
  LD A,$00
  LD BC,$0208
  RRA
  JP NC,LAFFC_41
  DEC L
  INC B
LAFFC_41:
  RRA
  JP NC,LAFFC_42
  INC B
LAFFC_42:
  RRA
  JP NC,LAFFC_43
  DEC H
  INC C
LAFFC_43:
  RRA
  JP NC,LAFFC_44
  INC C
;===============================================
; Выбивание кирпича
LAFFC_44:
  LD DE,scr_buff+$0290	; Адрес низа экрана с текстурой для восстановления под выбитым кирпичом
brik_value:
  LD A,$00		; Здесь хранится ценность кирпича: чем выше число, тем меньше очков за него
  AND $01
	; В DE адрес текстуры внизу экрана для восстановления фона под кирпичом
	jp z,brik_value_0
	ld a,$08
	add e
	ld e,a
brik_value_0:
  PUSH IX
  LD A,(random_number+$01)
  AND $0F
  CP $05
  PUSH IX
  CALL C,set_bonus
  POP IX
  LD A,(IX+$00)
  AND $7F
  CP $05
  JP Z,LB2D8
  push HL
  push DE
  push BC
  CALL get_free_sound_slot
  ld (HL),sound_normall_brik
  inc HL
  ld (HL),$04
  pop BC
  pop DE
  pop HL
LB2D8:
  LD IX,wins_recovery_data
  LD (IX+$01),L		; Координата окна - X
  LD (IX+$00),H		; Координата окна - Y
  LD (IX+$02),B		; Размер окна - ширина в байтах
  LD (IX+$03),C		; Размер окна - высота в пикселях
  PUSH BC
  CALL scr_buff_addr_calc	; На выходе в HL адрес в буфере scr_buff
  POP BC
  LD A,(wins_counter)
  INC A
  LD (wins_counter),A
  BIT 0,(IX+$00)
  JP Z,LAFFC_46
  ; В DE адрес текстуры внизу экрана для восстановления фона под кирпичом
	dec e
LAFFC_46:
  ; в HL адрес в буфере scr_buff
  ld a,h
  and $01
  ; В DE адрес текстуры внизу экрана для восстановления фона под кирпичом
  add a,d
  ld d,a
  LD (LB3DF+$01),HL	; в HL адрес в буфере scr_buff
  EX DE,HL
;-----------------------------------------------
; Восстановление линии фона НАД выбитым кирпичом
  LD A,C	; Размер окна
  CP $08
  JP Z,LAFFC_47
  BIT 0,(IX+$00)
  JP Z,LAFFC_47

  PUSH DE
  PUSH HL
  set 0,h
  set 0,d
	ld a,(hl)
	ld (de),a
	inc h
	inc d
	ld a,(hl)
	ld (de),a
  POP HL ; адрес текстуры внизу экрана для восстановления фона под кирпичом
  POP DE ; адрес в буфере scr_buff

	inc e
	inc l
;-----------------------------------------
; Восстановление фона ЗА выбитым кирпичом
LAFFC_47:
  LD (LB3E2+$01),DE
  PUSH DE
  LD A,B
  LD (LB33D+$01),A
  LD (LB33D_1+$01),A
  LD A,$08
  LD B,$00
LAFFC_48:
  EX AF,AF'
LB33D:
  LD C,$00		; Размер окна
LB33D_0:
  ld a,(hl)
  ld (de),a
  inc h
  inc d
  dec c
  jp nz,LB33D_0
LB33D_1:
  LD C,$00		; Размер окна
	ld a,h
	sub c
	ld h,a
	inc l
	ld a,d
	sub c
	ld d,a
	inc e
  EX AF,AF'
  DEC A
  JP NZ,LAFFC_48

;-----------------------------------------------
; Восстановление линии фона ПОД выбитым кирпичом
  PUSH DE
  LD A,(IX+$03)
  CP $08
  JP Z,LAFFC_51
  CP $0A
  JP Z,LAFFC_49
  BIT 0,(IX+$00)
  JP NZ,LAFFC_51
LAFFC_49:
  BIT 3,(IX+$01)
  JP NZ,LAFFC_50
  inc h
  inc d
LAFFC_50:
	ld a,(hl)
	ld (de),a
	inc h
	inc d
	ld a,(hl)
	ld (de),a

;============================================================================
; Манипуляции с вертикальными линии по краям экрана шириной в знакоместо
; Слева второй сверху элемент в виде ракетки - вплотную к нему
; Справа второй снизу элемент в виде ракетки - вплотную к нему
; Назначение неизвестно. Возможно буфер портится в какой-то момент и эта процедура его восстанавливает
; Возможно это костыль, чтобы за вороной не оставался след, который ранее появлялся чаще
LAFFC_51:
  LD A,(IX+$01)
  CP $E0
  JP C,LAFFC_52
  LD HL,scr_buff+$1e32
  LD C,$FE
  JP LAFFC_53
LAFFC_52:
  CP $10
  JP NC,LAFFC_56
  LD HL,scr_buff+$0132
  LD C,$7F
LAFFC_53:
  LD B,$1C
LAFFC_54:
  LD A,(HL)
  AND C
  LD (HL),A
  inc l
  dec B
  jp nz,LAFFC_54
	ld a,l
	add $1c
	ld l,a
  LD B,$18
LAFFC_55:
  LD A,(HL)
  AND C
  LD (HL),A
  inc l
  dec B
  jp nz,LAFFC_55
;=======================================

LAFFC_56:
  LD DE,(LB28F+$01)		; Координаты на экране
  POP HL				; Адрес в экранном буфере
  LD B,H
  LD C,L
  ; BC - адрес в экранном буфере
  LD A,D
  CP $78
  JP Z,LAFFC_58
	dec c
  	set 0,h
  LD A,E
  CP $08
  JP Z,LAFFC_57
  BIT 7,(IY+$0E)
  JP NZ,LAFFC_57

  RES 7,(HL)

  bit 0,b
  JP NZ,LAFFC_57

	IFDEF MX
  XOR A
	ELSE
  XOR A

	; ld a,$ff

	ENDIF
  LD (BC),A

  LD A,E
LAFFC_57:
  CP $E0
  JP NC,LAFFC_58
  BIT 7,(IY+$10)
  JP NZ,LAFFC_58
  inc h
  LD A,(IX+$02)
  DEC A
  add a,b
  ld b,a

  RES 0,(HL)

  AND $01
  JP Z,LAFFC_58
	IFDEF MX
  XOR A
	ELSE
  XOR A

	; ld a,$ff

	ENDIF
  LD (BC),A

LAFFC_58:
  LD A,D
  CP $20
  JP Z,LAFFC_60
LB3DF:
  LD HL,$0000
LB3E2:
  LD BC,$0000
  set 0,h
  LD A,E
  CP $08
  JP Z,LAFFC_59
  BIT 7,(IY-$10)
  JP NZ,LAFFC_59
  RES 7,(HL)
  bit 0,b
  JP NZ,LAFFC_59
  XOR A
  LD (BC),A
  LD A,E
LAFFC_59:
  CP $E0
  JP NC,LAFFC_60
  BIT 7,(IY-$0E)
  JP NZ,LAFFC_60
  inc h
  RES 0,(HL)
  LD A,(IX+$02)
  DEC A
  add a,b
  ld b,a
  AND $01
  JP Z,LAFFC_60
  XOR A
  LD (BC),A

;------------------------------------------------------
; Обработка соседнего кирпича СЛЕВА от выбитого кирпича
LAFFC_60:
  POP HL
  ld d,$00	; Для дальнейших манипуляций в d нужен 0
  LD A,(IX+$01)
  CP $08
  JP Z,LAFFC_62
  BIT 3,A
  JP Z,LAFFC_62
  PUSH HL
  LD B,$08
LAFFC_61:

  RES 7,(HL)

	inc l
  dec B
  jp nz,LAFFC_61
  POP HL

;-------------------------------------------------------
; Обработка соседнего кирпича СПРАВА от выбитого кирпича
LAFFC_62:
  LD A,(IX+$01)
  CP $E0
  JP NC,LAFFC_64
  LD B,(IX+$02)
  SLA B
  SLA B
  SLA B
  ADD A,B
  CP $F8
  JP Z,LAFFC_64
  AND $08
  JP Z,LAFFC_64


  PUSH HL
  LD A,(IX+$02)
  DEC A
  add a,h
  ld h,a
  LD B,$08
LAFFC_63:
	IFDEF MX
  RES 0,(HL)
	ELSE
  ; SET 0,(HL)
  RES 0,(HL)
	ENDIF
	inc l
  dec B
  jp nz,LAFFC_63
  POP HL


;-----------------------------------------------
; Обработка стороны кирпича над и под выбитым кирпичом
LAFFC_64:
  set 0,h
  LD A,(LB292+$01)
  BIT 2,A
  JP NZ,LAFFC_65
	; В D - 0
	; Подводка под кирпичом, который над выбитым
  LD (HL),D
	inc h
  LD (HL),D
	dec h

LAFFC_65:

  AND $08
  JP NZ,LAFFC_66
  ld a,l
  add $07
  ld l,a

	IFDEF MX
  LD (HL),D
  inc h
  LD (HL),D
	ELSE

	; ld a,$ff
	; ld (hl),a
	; inc h
	; ld (hl),a

  LD (HL),D
  inc h
  LD (HL),D


	ENDIF
;------------------------------------------
; Восстановление цвета под выбитым кирпичом
LAFFC_66:
  LD DE,$0004
  ADD IX,DE
  LD (LB2D8+$02),IX
  POP IX
  LD HL,(LB28F+$01)
  CALL scr_buff_attr_calc
;  В HL адрес в буфере атрибутов

	IFDEF MX
  PUSH HL
  LD DE,(attr_buff+$0202)

; RES 6,E
	ld a,e
	and %01110111
	ld e,a
  LD A,(LB28F+$01)
  CP $08
  JP Z,LAFFC_67
	; SET 6,E
	ld a,e
	and %00000111
	ld a,e
	jp nz,col_res_01
	or %10000000
	jp col_res_02
col_res_01:
	or %10001000
col_res_02:
	ld e,a

LAFFC_67:
  LD A,(LB28F+$02)
  CP $20
  JP Z,LAFFC_69
  BIT 7,(IY-$10)
  JP NZ,LAFFC_68

	; RES 6,E
	ld a,e
	and %01110111
	ld e,a

LAFFC_68:
  BIT 7,(IY-$0F)
  JP NZ,LAFFC_69

	; RES 6,D
	ld a,d
	and %01110111
	ld d,a

LAFFC_69:
  LD (HL),E
  inc h
  LD (HL),D

  inc l
  LD A,(LB28F+$02)
  CP $78
  JP NZ,LAFFC_70

  	; SET 6,(HL)
	ld a,(hl)
	and %00000111
	ld a,(hl)
	jp nz,col_res_03
	or %10000000
	jp col_res_04
col_res_03:
	or %10001000
col_res_04:
	ld (hl),a

	inc h

  	; SET 6,(HL)
	ld a,(hl)
	and %00000111
	ld a,(hl)
	jp nz,col_res_05
	or %10000000
	jp col_res_06
col_res_05:
	or %10001000
col_res_06:
	ld (hl),a

  JP LAFFC_72
LAFFC_70:
  BIT 7,(IY+$0F)
  JP Z,LAFFC_71

  	; SET 6,(HL)
	ld a,(hl)
	and %00000111
	ld a,(hl)
	jp nz,col_res_07
	or %10000000
	jp col_res_08
col_res_07:
	or %10001000
col_res_08:
	ld (hl),a

LAFFC_71:
  inc h
  LD A,(LB28F+$01)
  CP $E8
  JP Z,LAFFC_72
  BIT 7,(IY+$10)
  JP Z,LAFFC_72

  	; SET 6,(HL)
	ld a,(hl)
	and %00000111
	ld a,(hl)
	jp nz,col_res_09
	or %10000000
	jp col_res_10
col_res_09:
	or %10001000
col_res_10:
	ld (hl),a
LAFFC_72:
  POP HL		; hl - адрес в буфере атрибутов
	ELSE

	ld de,(attr_buff+$0202)
	ld (hl),e
	inc h
	ld (hl),d

	ENDIF

;----------------------------------------------------------------
; Моментальное восстановление цвета на экране из буфера атрибутов
	  call col_zm_rest
	  inc h
	  call col_zm_rest
	  inc l
	  call col_zm_rest
	  inc h
	  call col_zm_rest
  SET 7,(IY+$00)
  RET

; Обновление цвета знакоместа сразу на экране по данным из буфера цвета
; На входе в HL - адрес в буфере атрибутов
col_zm_rest:
	push hl
	; Устанавливаем текущий цвет для знакоместа
;	ld a,(hl)
;	ld (color_port),a
	; Из адреса знакоместа буфере получаем адрес байта на экране
	ld a,l
	rla
	rla
	rla
	and %11111000
	add zx_scr%256 - scr_buff%256
	ld l,a
	ld a,h
	add zx_scr/256 - scr_buff/256
	ld h,a
	; Освежаем данные на экране
	ld b,$08
col_zm_rest_0:
	;ld a,(hl)
	;ld (hl),a
	inc l
	dec B
	jp nz,col_zm_rest_0
	pop hl
	ret

; Used by the routines at show_window_round_number, input_new_record_name, disp_main_menu_and_wait_keys, print_message and print_txt_players_1_and_2.
; На входе в DE адрес сообщения
print_line:			; Specialist ready
  EX DE,HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD A,(HL)
;  ld (color_port),a
  INC HL
  LD B,(HL)
  INC HL

  LD A,LB551/256
  LD (symbol_call_jump+$02),A
  LD A,LB551%256
  LD (symbol_call_jump+$01),A 		; Переход на LB551
  LD A,B
  AND %10000000	;  BIT 7,B
  JP Z,print_line_0
  LD A,B
  AND %1000000	;  BIT 6,B
  JP NZ,print_line_0

  LD A,LB55D/256			; Адрес процедуры удвоения символов по высоте при печати
  LD (symbol_call_jump+$02),A
  LD A,LB55D%256
  LD (symbol_call_jump+$01),A 		; Переход на LB55D

  JP print_line_0

print_line_0:
  EX DE,HL
  push bc
  CALL screen_addr_calc
  pop bc
  LD A,B
  AND $3F
  LD B,A
print_line_1:
  PUSH BC
  CALL print_symbol
  POP BC
  INC DE
  DEC B
  JP NZ,print_line_1
  RET

; Used by the routine at print_line.
; DE указывает на код печатаемого символа
print_symbol:		; Specialist ready
  PUSH DE
  LD A,(DE)
  EX DE,HL
  PUSH DE

  LD L,A
  LD H,$00
  ADD HL,HL
  LD E,L
  LD D,H
  ADD HL,HL	; А умножаем на 6
  ADD HL,DE	; и помещаем HL

  LD DE,font+$05
  ADD HL,DE  ; В HL адрес символа в знакогенераторе

  POP DE
  EX DE,HL
  PUSH HL
  LD B,$06
; HL - указатель на код печатаемого символа
; DE - адрес символа в знакогенераторе
; B - $06
symbol_call_jump:
  JP symbol_call_jump

LB551:		; Vector ready
  LD A,(DE)
  LD (HL),A
  DEC DE
  inc l		; поправлено направление для Вектора
  DEC B
  JP NZ,LB551
  POP HL
  INC H
  POP DE
  RET

;--------------------------------------
; Routine at B55D
; Нигде неиспользуемый код. Мусор?
; Удвоение по высоте символов при печати
LB55D:		; Specialist ready
  LD A,(DE)
  LD (HL),A
  DEC HL
  LD A,(DE)
  LD (HL),A
  inc L		; изменение направления для Вектора
  DEC DE
  DEC B
  JP NZ,LB55D
  POP HL
  INC H
  POP DE
  RET

; Used by the routines at fill_color_current_game_mode and fill_gen_win_attrib.
; Вычисляет координаты в экранной области
; На входе в HL координаты, на выходе там же адрес в атрибутах
screen_coord_attrib:	; Specialist ready

; Used by the routines at show_window_round_number, print_obj_from_buf_to_scr, LAFFC, print_line and print_sprite.
; На входе в HL координаты, на выходе там же адрес на экране
screen_addr_calc:		; Vector ready
	ld a,l
	rra
	rra
	rra
	and %11111
	ld b,a
	ld a,h
	ld c,0
	ld hl,zx_scr
	add hl,bc
	neg
	add l
	ld l,a
	ret

; Used by the routines at print_magnets, print_one_magnet, fill_color_current_game_mode, print_obj_to_buff, set_bonus, enemy_prepare, handling_object,
; handling_ball, LAB1F, hl_bc_calc_direction, print_one_brik_buf, points_calc_and_add, running_dot and game_screen_draw_to_buffer.
hl_add_a:
	ADD A,L
	LD L,A
	RET NC
	INC H
	RET

; Used by the routine at game_screen_draw_to_buffer.
; Вывод ч/б спрайта без маски в буфер
; Спрайт рисуется снизу вверх
print_sprite_pix:	; Specialist ready
	push hl
	call scr_buff_addr_calc
	ld a,(de)	; Ширина спрайта
	ld c,a
	inc de
	ld a,(de)	; Высота спрайта
	ld (print_sprite_pix_1+$01),a
	ld (print_sprite_pix_3+$01),a
	inc de
print_sprite_pix_1:
	ld b,$00	; B - высота
print_sprite_pix_2:
	ld a,(de)
	ld (hl),a
	inc de
	dec l		; НЕ поправлено направление для Вектора (рисуем в буфер)
	dec B
	jp nz,print_sprite_pix_2
	ld a,l
print_sprite_pix_3:
	add $00		; B - высота	; НЕ поправлено направление для Вектора (рисуем в буфер)
	ld l,a
	inc h
	dec c
	jp nz,print_sprite_pix_1
  POP HL
  RET

; Used by the routine at disp_main_menu_and_wait_keys.
; Вывод ч/б спрайта без маски на экран
print_sprite:	; Vector ready
  PUSH HL
  CALL screen_addr_calc
  LD A,(DE)
  LD (LB605+$01),A
  INC DE
  LD A,(DE)
  INC DE
  LD C,A
print_sprite_0:
  PUSH HL
LB605:
  LD B,$00
print_sprite_1:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC H
  DEC B
  JP NZ,print_sprite_1
  POP HL
  inc l   ; поправлено направление для Вектора
  DEC C
  JP NZ,print_sprite_0
  POP HL
  RET

; Used by the routine at game_screen_draw_to_buffer.
; Вывод атрибутов цветного спрайта в буфер
print_sprite_attrib:	; Specialist ready
	push hl
	call scr_buff_attr_calc
	ld a,(de)		; Ширина
	ld c,a
	inc de
	ld a,(de)		; Высота
	ld (print_sprite_attrib_1+$01),a
	ld (print_sprite_attrib_3+$01),a
	inc de
print_sprite_attrib_1:
	ld b,$00
print_sprite_attrib_2:
	ld a,l
	or %11000000	; Костыль, чтобы атрибуты всегда писались исключительно в буфер атрибутов
	ld l,a
	ld a,(de)
	ld (hl),a
	inc de
	dec l
	dec B
	jp nz,print_sprite_attrib_2
	ld a,l
print_sprite_attrib_3:
	add a,$00
	ld l,a
	inc h
	dec c
	jp nz,print_sprite_attrib_1
	pop hl
	ret

; Used by the routines at game_restart, LBAED, LBB97 and LBC10.
; Вызов процедуры, переданной в HL, для 11 свойств спрайтов
; HL = адрес процедуры
call_hl_for_all_obj:
	LD (LB678+$01),HL
	LD HL,object_ball_1
	LD B,$0B
LB66A_0:
	PUSH BC
	LD A,(HL)
	ADD A,A
	JP Z,LB678_1
  push HL
  pop IX	;NOTE для передачи в подпрограмму
	push HL
LB678:
	CALL LB678		; Вызов подпрограммы поданной на вход этой процедуры в HL
	pop HL
LB678_1:
	LD DE,$0016
	ADD HL,DE
	POP BC
	dec B
	jp nz,LB66A_0
	RET

; Used by the routines at print_magnets, add_points_to_score, bonus_extra_life and game_screen_draw_to_buffer.
; Вычисляем адрес в буфере из координат IX+$02 и IX+$04
; Кладём адрес в IX+$0A и IX+$0B
ix_buf_addr_calc:
  LD L,(IX+$02)
  LD H,(IX+$04)
  CALL scr_buff_addr_calc
  LD (IX+$0A),H
  LD (IX+$0B),L
  RET

; Used by the routines at game_restart, LBB97 and LBC10.
; Заполняет briks_data данными
fill_briks_data:
	LD HL,briks_data
	LD B,$05
next_brik:
	push BC
	LD A,(HL)
	AND A
	CALL NZ,metal_brik_anim
	LD DE,$0007
	ADD HL,DE
	pop BC
	dec B
	jp nz,next_brik
	RET

; Used by the routine at fill_briks_data.
; Рисуем один кадр переливания кирпича одновременно в буфер и на экран
; Вход: HL, на выходе то же значение!
metal_brik_anim:
  push HL
  pop IY
	LD L,(IY+$05)
	LD H,(IY+$06)
	BIT 7,(HL)		; Проверяем 7 бит (пустота) текущего элемента
	JP Z,LB6A9_0
	LD (IY+$00),$00		; Помечаем текущий слот данных свободным
	RET
LB6A9_0:
	ld e,a

; Установка цвета для переливающегося кирпича
	LD C,(IY+$03)
	LD B,(IY+$04)
; BC - адрес кирпич в буфере
	ld d,c
	ld a,c
	rra
	rra
	rra
	or %11000000
	ld c,a
; BC - адрес атрибута кирпича
	;ld a,(bc)
	;ld (LB6A9_10+$01),a	; Цвет левой половины кирпича
	;inc b
	;ld a,(bc)
	;ld (LB6A9_11+$01),a	; Цвет правой половины кирпича
	;dec B
	ld c,d
; Индивидуальная обработка чёрного кирпича
  IFDEF MX
	; Ничего не делаем
  ELSE
	or a
	jp nz,LB6A9_01
	ld a,e
	cp 15
	jp nz,LB6A9_03
	ld hl,anim_brik_black
	jp LB6A9_02
  ENDIF
LB6A9_01:
	ld a,e
LB6A9_03:
	INC A
	AND $FE
	LD HL,anim_brik-$02
	LD E,A
	LD D,$00
	ADD HL,DE
; В HL ссылка на спрайт текущей анимации переливания кирпича
LB6A9_02:
	LD E,(HL)
	INC HL
	LD D,(HL)
	LD L,(IY+$01)
	LD H,(IY+$02)
; DE - адрес спрайта текущего кадра анимации
; HL - адрес на экране
; BC - адрес в буфере
;-----------------------
	LD A,$07
LB6A9_1:
	EX AF,AF'
LB6A9_10:
;  ld a,$00
;  ld (color_port),a	; Цвет левой половины кирпича (на случай тени)
	LD A,(DE)		; байт из спрайта
	LD (HL),A		; Экран
	LD (BC),A		; Буфер
	INC H
	inc b
	INC DE
LB6A9_11:
;  ld a,$00
;  ld (color_port),a	; Цвет правой половины кирпича
	LD A,(DE)		; байт из спрайта
	LD (HL),A		; Экран
	LD (BC),A		; Буфер
	DEC H
	dec L			; Изменено направление для Вектора
	INC DE
	dec B
	inc c
	EX AF,AF'
	DEC A
	JP NZ,LB6A9_1
;-----------------------
  push IY
  pop HL
	LD A,(HL)
	INC A
	AND $0F
	LD (HL),A
	RET
; -- end of metal_brik_anim -------

; 5 строк по 7 элементов каждая
; Сведения о 5 кирпичах
; IX+$00 - 0 - свободно, 1 - заполнено
; IX+$01 - 2 байта адрес на экране
; IX+$04 - 2 байта адрес в экранном буфере
; IX+$06 - 2 байта - адрес (IY) текущего элемента (кирпича) на текущем уровне
briks_data:
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00

; Used by the routines at LBAED, LBB97 and LBC10.
; Восстанавливает несколько окон, количество задано в A
wins_recovery:
  LD B,A
  LD IX,wins_recovery_data
LB717_0:
  PUSH BC
  LD L,(IX+$01)
  LD H,(IX+$00)
  LD C,(IX+$03)
  LD B,(IX+$02)
  CALL win_bg_recovery
  LD BC,$0004
  ADD IX,BC
  POP BC
  dec B
  jp nz,LB717_0
  XOR A
  LD (wins_counter),A
  LD HL,wins_recovery_data
  LD (LB2D8+$02),HL
  RET

; Used by the routine at all_metal_briks_animation_snd.
; Проигрывает один звук металлического кирпича, если на уровне есть хотя бы один такой кирпич
one_play_sound_metal_brik:
  NOP
  LD A,$C9	;Код команды RET
  LD (one_play_sound_metal_brik),A
  LD HL,(current_level_addr)
  LD B,$B4
LB74A:
  LD A,(HL)
  AND $90
  JP Z,LB754
  INC HL
  dec B
  jp nz,LB74A
  JP LB764
LB754:
  LD IY,(iy_storage)
  PUSH IX
  LD IX,sounds_queue
  CALL play_sound_metal_brik
  ; DI
  POP IX
LB764:
  RET

; Used by the routine at game_restart.
; Анимация со звуком разом всех трудновыбиваемых кирпичей перед началом раунда
all_metal_briks_animation_snd:
  XOR A
  LD (one_play_sound_metal_brik),A
  LD IX,anim_brik
LB765_0:
  LD IY,(iy_storage)

  ; Пауза для анимации металлических кирпичей
  ; Вместо halt необходимо ставить паузу
  ; EI
  ; HALT
  ; EI
  ; HALT
  ; DI
  ld d,$20		; Константа выставлена на глаз
  call pause_short

  CALL all_metal_briks_frame

  LD DE,spr_brik_5
  LD L,(IX+$00)
  LD H,(IX+$01)
  XOR A
  CALL SBCHLDE8080	; SBC HL,DE

  CALL Z,one_play_sound_metal_brik

  INC IX
  INC IX
  LD A,(IX+$01)
  AND A

  JP NZ,LB765_0
  RET

; Ячейки хранения стандартного значения IY для корректной работы IM1
iy_storage:
  DEFW $0000

; Used by the routine at game_restart.
return:
  RET

; Used by the routines at show_window_round_number, disp_high_score_table_screen, disp_main_menu_and_wait_keys, print_kinnock and LBC10.
; На входе в DE адрес сообщения, в B - количество выводимых строк
print_message:		; Specialist ready
  PUSH BC
  CALL print_line
  POP BC
  DEC B
  JP NZ,print_message
  RET

; Data block at B79E
; Мусор?
  DEFB $08,$07,$44,$04,$01,$26,$1E,$19

;--------------------------
; Данные для первого игрока
score_1up_in_game:
  DEFW $0F00	; Адрес в буфере (на старте игры вычисляется по координатам $1510)
  DEFB $47,$06	; Рудимент, не используется?
  DEFW $0000	; 6-й и 5-й разряды счёта
  DEFW $0000	; 4-й и 3-й разряды счёта
  DEFW $0000	; 2-й и 1-й разряды счёта
;--------------------------

; Мусор?
  DEFB $78,$07,$43,$02,$11,$12

hi_score_in_game:
  DEFW $0F68	; Адрес в буфере (на старте игры вычисляется по координатам $1568)
  DEFB $47,$06	; Рудимент, не используется?

;HI score - 3 ячейки
hi_score:
  DEFB $00,$00,$10

; Мусор?
  DEFB $00,$00,$00,$D8,$07,$44,$04,$02
  DEFB $26,$1E,$19

;--------------------------
score_2up_in_game:
  DEFW $0FD0	; Адрес в буфере (на старте игры вычисляется по координатам $15C0)
  DEFB $47,$06	; Рудимент, не используется?
  DEFW $0000	; 6-й и 5-й разряды счёта
  DEFW $0000	; 4-й и 3-й разряды счёта
  DEFW $0000	; 2-й и 1-й разряды счёта
;--------------------------

; Мусор?
  DEFB $06,$07

; Used by the routine at LBC10.
pause_clear_screen_attrib:
  CALL pause_short
  dec B
  jp nz,pause_clear_screen_attrib
  JP clear_screen_attrib

; Used by the routines at input_new_record_name, game_restart, LBBFB and LBC10.
; Пауза - в B задаётся количество циклов. Один цикл - примерно 0,3 сек.
pause_long:
  LD D,$00
  CALL pause_short
  dec B
  jp nz,pause_long
  RET

; Неиспользуемый байт - копия предыдущего? Мусор?
; Data block at B7E4
  RET

; Общие переменные игры
; Режим игры:
; 00 - 1 Player
; 01 - 2 Players
; 02 - Double Play
game_mode:
  DEFB $00
player_number:
  DEFB $00  ; Номер игрока
frames_copy:
  DEFB $00	; Копия системного счётчика кадров

; Данные первого игрока
lives_1up:
  DEFB $03	; Количество жизней
briks_quantity_1up:	; Количество кирпичей на текущем уровне
  DEFB $00
current_level_number_1up:
  DEFB $00		; Текущий уровень - один из 15-ти
round_number_1up:
  DEFB $00	; Номер раунда. Он может быть больше, чем число уровней!
current_score_1up:
  DEFB $00,$00,$00	;Текущий счёт 1-го игрока (три ячейки)

; Тип управления первого игрока:
; $00 - Keyboard
; $FF ($01) - Kempston
; $FE ($02) - Cursor
; $FD ($03) - Interface II
ctrl_type_1up:
  DEFB $00

; Данные второго игрока
lives_2up:
  DEFB $00
;briks_quantity_2up:
  DEFB $00
current_level_number_2up:
  DEFB $00
;round_number_2up:
  DEFB $00
current_score_2up:
  DEFB $00,$00,$00
ctrl_type_2up:
  DEFB $00

; Used by the routine at game_restart.
; Инициализация всех переменных, подготовка всех буферов
all_var_init:
  LD A,(ball_x_coord+$01)
  XOR $88
  LD (ball_x_coord+$01),A	; Запись в object_ball_1+2
  LD A,$0C
  LD (spr_bonus_rocket_1+$01),A
  LD DE,object_ball_1
  LD HL,objects_buff_2
  LD A,$0B
LB7F8_0:
  LD BC,$0016
  CALL LDIR8080		; LDIR
  DEC A
  JP NZ,LB7F8_0
  LD (LBAEB+$01),A		; меняем параметр команды JR
  LD (bonus_flag),A
  LD (bonus_flag_copy),A
  LD (current_magnet_prop+$01),A
  LD (ctrl_btns_pressed),A
  LD (ctrl_btns_pressed_copy),A
  INC A
  LD (balls_quantity),A
  LD A,(game_mode)
  CP $02
  JP NZ,LB7F8_1
  LD A,$01
  LD (object_bat_2),A
  LD A,$38
  LD (object_bat_1+$02),A	; Координата X
  LD A,$B0
  LD (object_bat_2+$02),A	; Координата X
ball_x_coord:
  LD A,$48	; Здесь самомодификация кода
  LD (object_ball_1+$02),A
  CP $C0
  JP NZ,LB7F8_1
  LD A,(object_ball_1+$12)
  OR $80
  LD (object_ball_1+$12),A
  LD A,$FF
  LD (object_bat_1+$14),A
  LD A,$83
  LD (object_bat_2+$14),A
LB7F8_1:
  LD HL,$8CC0			; Это не адрес!
  LD (object_ball_1+$14),HL
  LD L,$08
  LD A,(current_level_number_1up)
  ADD A,$02
  CP $04
  JP C,LB7F8_2
  LD A,$04
LB7F8_2:
  LD A,$03
  LD H,A
  LD (object_ball_1+$06),HL
  LD A,$0E
  LD (running_dot_frame_1up),A
  LD (running_dot_frame_2up),A
  LD A,$83
  LD (object_bat_1+$14),A
  XOR A
  LD (wins_counter),A
  LD HL,wins_recovery_data
  LD (LB2D8+$02),HL
  LD HL,bonus_table_first
  LD A,(round_number_1up)
  CP $06
  JP C,LB7F8_3
  LD HL,bonus_table_second
LB7F8_3:
  LD DE,bonus_table_current
  LD BC,$0010
  CALL LDIR8080		; LDIR
  LD HL,LA270
  LD B,$0C
  CALL clear_hl_buff
  LD HL,sounds_queue
  LD B,$23
  CALL clear_hl_buff
  LD HL,briks_data
  LD B,$23
  JP clear_hl_buff

; Used by the routine at briks_calc.
; Сброс свойств всех кирпичей на уровне
; На входе в HL - адрес уровня
bricks_reset:
  LD B,$B4				; 180 - количество всех ячеек на уровне
bricks_reset_0:
  LD A,(HL)
  CP $C0
  JP Z,bricks_reset_1	; Если пустое место, то пропускаем
  BIT 5,A
  JP NZ,bricks_reset_1	; Если невыбиваемый, то пропускаем

  RES 7,(HL)			; Сбрасываем бит пустоты
  RES 6,(HL)			; Сбрасываем бит пустоты
  SET 4,(HL)			; Устанавливаем признак обычного кирпича
  AND $0F
  CP $06
  JP C,bricks_reset_1		; Если цвет меньше 6 (то есть обычный кирпич), то пропускаем
  RES 4,(HL)			; Всем цветам 6 и выше (до невыбиваемых) сбрасываем признак обычного кирпича
bricks_reset_1:
  INC HL
  dec B
  jp nz,bricks_reset_0
  RET

; Рисование бегающих точек на каретках
  INCLUDE "./routines/running_dots.asm"

; Ячейка для временного хранения нажатых кнопок управления
ctrl_btns_pressed_copy:
  DEFB $00

kinnock:
  DEFB $01	; Если сюда записать ноль, то перед игрой будет надпись про Киннока

; Used by the routine at game_restart.
print_kinnock:
  LD A,(kinnock)
  AND A
  RET NZ
  LD DE,txt_kinnock
  LD B,$02
  CALL print_message
  LD D,$00
  CALL pause_short
  JP clear_screen_attrib

  INCLUDE "./txt/txt_kinnock.asm"

; Начало программы
; Used by the routine at L6800.
game_start:
  LD (iy_storage),IY

  LD HL,$1510
  CALL scr_buff_addr_calc
  LD (score_1up_in_game),HL	; Адрес в буфере по координатам

  LD HL,$15C0
  CALL scr_buff_addr_calc
  LD (score_2up_in_game),HL	; Адрес в буфере по координатам

  LD HL,$1568
  CALL scr_buff_addr_calc
  LD (hi_score_in_game),HL	; Адрес в буфере по координатам

;---------------------------------
; Переносим свойства 11 спрайтов в буфер по адресу 6000
  LD DE,objects_buff_2
  LD HL,object_ball_1
  LD A,$0B
game_start_0:
  LD BC,$0016
  CALL LDIR8080		; LDIR
  DEC A
  JP NZ,game_start_0
;---------------------------------

  LD HL,objs_width_sum
  LD B,$01
  CALL clear_hl_buff	; Странный метод очистки ячейки objs_width_sum (суть - LD (objs_width_sum),$00)

; Used by the routine at LBC10.
; Повторный запуск главного меню (после проигрыша), минуя некоторые инициализации
game_restart:
  ld a,(score_1up_in_game+$01)
  sub scr_buff/$100
  AND $1F
  CP $02
  CALL NZ,players_swap

;----------------------------------
  CALL disp_main_menu_and_wait_keys
;----------------------------------
; Непосредственный запуск игры

  LD HL,$0000
  LD (current_score_1up),HL
  LD (current_score_1up+$01),HL

  ; Обнуление внутриигрового счёта
  LD (score_1up_in_game+$04),HL
  LD (score_1up_in_game+$06),HL
  LD (score_1up_in_game+$08),HL
  LD (score_2up_in_game+$04),HL
  LD (score_2up_in_game+$06),HL
  LD (score_2up_in_game+$08),HL

  LD A,$03				; Количество жизней
  LD (lives_1up),A
  LD A,$C0
  LD (ball_x_coord+$01),A		; Запись в object_ball_1+2
  XOR A		; Начальный уровень = 0
  LD (current_level_number_1up),A
  LD (round_number_1up),A
  LD (player_number),A
  CALL briks_calc
  LD DE,current_level_copy
  LD HL,(current_level_addr)
  LD BC,$00B4			; 180 - количество ячеек на уровне
  CALL LDIR8080		; LDIR
  LD DE,lives_2up
  LD HL,lives_1up
  LD BC,$0007
  CALL LDIR8080		; LDIR
  LD A,(game_mode)
  AND A
  JP NZ,LB9E8_0
  LD (lives_2up),A
LB9E8_0:
  CALL clear_screen_attrib
  CALL clear_screen_pix
; This entry point is used by the routines at LBBFB and LBC10.
LB9E8_1:
  CALL level_addr_calc
  CALL game_screen_draw_to_buffer
  CALL all_var_init
  CALL clear_screen_attrib
  CALL print_kinnock
  CALL buff_to_screen_pixs
  CALL buff_to_screen_attrib
  CALL return		; Заглушка, пустая подпрограмма
  CALL show_window_round_number
  LD B,$04
  CALL pause_long	; Пауза 1,2 сек. (4*0.3)
  CALL all_metal_briks_animation_snd
; Восстанавливаем из буфера пиксели над окном с надписью о номере раунда
  LD HL,$8158		; Координаты
  LD BC,$0A28		; Размеры окна
  CALL win_bg_recovery

; This entry point is used by the routine at LBAED.
LB9E8_2:
  LD A,(random_number+$01)
  CP $99
  CALL Z,print_one_magnet
  XOR A
  LD (counter_2),A
  CALL get_left_player_ctrl_state
  LD HL,(counter_misc)
  INC HL
  LD (counter_misc),HL
  CALL enemy_prepare
  CALL random_generate
  LD IX,object_bat_1
  CALL handling_bat
  LD A,(game_mode)
  CP $02
  JP NZ,LB9E8_3
  CALL bonus_flag_swap
  LD A,(ctrl_btns_pressed)
  PUSH AF
  LD A,(ctrl_type_2up)
  CALL get_right_player_ctrl_state
  LD A,(ctrl_btns_pressed)
  LD (ctrl_btns_pressed_copy),A
  LD IX,object_bat_2
  CALL handling_bat
  POP AF
  LD (ctrl_btns_pressed),A
  LD IX,object_bat_1
  CALL LACCE
  LD IX,object_bat_2
  CALL LACAD
  CALL bonus_flag_swap
LB9E8_3:
  LD HL,handling_object
  CALL call_hl_for_all_obj
  LD HL,ix_buf_addr_calc
  CALL call_hl_for_all_obj
  CALL fill_briks_data
LBAEB:
  JR LBAED_0		;WARN: Параметр JR изменяемый!

LBAED:
  LD A,(object_rocket)
  AND A
  JP NZ,LBAED_6
; This entry point is used by the routine at game_restart.
LBAED_0:
  LD A,(balls_quantity)
  AND A
  JP Z,LBC10
  LD A,(briks_quantity_1up)
  AND A
  JP Z,LBC10
  CALL save_objs_to_buff
  LD HL,print_obj_to_buff
  CALL call_hl_for_all_obj
  CALL play_sounds_queue
  JP NZ,LBAED_4
  LD A,(save_objs_buff)
  CP $04
  JP Z,LBAED_1
  JP C,LBAED_3
  LD A,(objs_width_sum)
  CP $23
  JP NC,LBAED_4
  JP LBAED_3
LBAED_1:
  LD A,(object_bat_1+$0C)	; Ширина каретки в пикселях
  CP $1C
  JP NZ,LBAED_2
  LD A,(object_bonus)
  AND A
  JP NZ,LBAED_3
LBAED_2:
  LD A,(counter_2)
  CP $03
  JP C,LBAED_4
LBAED_3:

  ; Общая скорость геймплея
  ; Вместо halt необходимо ставить паузу
  ; EI
  ; HALT
  ; DI

  ld d,$05		; Константа выставлена на глаз $10
  call pause_short

LBAED_4:
  LD HL,object_bat_1+2
  CALL running_dot
  LD A,(game_mode)
  CP $02
  JP NZ,LBAED_5
  CALL running_dot_frame_swap
  LD HL,object_bat_2+2
  CALL running_dot
  CALL running_dot_frame_swap

LBAED_5:
  LD HL,print_obj_from_buf_to_scr
  CALL call_hl_for_all_obj
  LD A,(wins_counter)
  AND A
  CALL NZ,wins_recovery			; В том числе восстанавливается фон под выбитым кирпичом
  CALL restore_objs_and_magnet
  CALL pause_game
  JP LB9E8_2

LBAED_6:
  LD B,$0B
  LD DE,$0016
  LD IX,object_ball_1
LBAED_7:
  LD A,(IX+$00)
  AND A
  JP Z,LBAED_8
  SET 7,(IX+$00)
LBAED_8:
  ADD IX,DE
  dec B
  jp nz,LBAED_7
  LD A,$01
LBB83:
  LD HL,$0000
  LD (HL),A
  LD A,$06
  LD (object_rocket),A
  LD A,$05
  LD (sounds_queue),A
  XOR A
  LD (counter_misc),A
  JP LBB97_0

LBB97:
  LD A,(counter_misc)
  INC A
  LD (counter_misc),A
  CALL random_generate
  LD HL,handling_object
  CALL call_hl_for_all_obj
  CALL fill_briks_data
; This entry point is used by the routine at LBAED.
LBB97_0:
  LD HL,ix_buf_addr_calc
  CALL call_hl_for_all_obj
  CALL save_objs_to_buff
  LD HL,print_obj_to_buff
  CALL call_hl_for_all_obj
  LD IY,(iy_storage)

  ; Непонятно на что влияющая задержка
  ; Вместо halt необходимо ставить паузу
  ; EI
  ; HALT
  ; DI

  ; ld d,$10		; Константа выставлена на глаз
  ; call pause_short

  CALL play_sounds_queue
  LD HL,print_obj_from_buf_to_scr
  CALL call_hl_for_all_obj
  LD A,(wins_counter)
  AND A
  CALL NZ,wins_recovery
  CALL restore_objs
  CALL pause_game
  LD A,(object_rocket)
  AND A
  JP Z,LBBFB
  JP LBB97

; Used by the routine at LBBFB.
increment_round_number:
  LD A,(round_number_1up)
  INC A
  LD (round_number_1up),A
  LD A,(current_level_number_1up)
  INC A
  CP $0F	; Максимальное количество уровней
  JP Z,LBBE0_0
  LD (current_level_number_1up),A
  JP LBBE0_1
LBBE0_0:
  XOR A
  LD (current_level_number_1up),A
LBBE0_1:
  JP briks_calc

; Used by the routine at LBB97.
LBBFB:
  CALL add_points_for_left_briks
; This entry point is used by the routine at LBC10.
LBBFB_0:
  LD A,(briks_quantity_1up)
  AND A
  CALL Z,play_sounds_queue
  CALL increment_round_number
  LD B,$02
  CALL pause_long
  JP LB9E8_1

; Used by the routine at LBAED.
LBC10:
  LD A,(current_magnet_prop+$01)
  AND A
  JP Z,LBC10_0
  LD IX,(current_magnet_prop)
  LD A,(IX+$02)
  SUB $05
  LD L,A
  LD A,(IX+$04)
  SUB $05
  LD H,A
  LD BC,$0417
  CALL win_bg_recovery
  XOR A
  LD (current_magnet_prop+$01),A
LBC10_0:
  LD IX,object_ball_1
  LD B,$0B
  LD DE,$0016
  LD A,(object_rocket)
  PUSH AF
LBC10_1:
  LD A,(IX+$00)
  AND A
  JP Z,LBC10_2
  SET 7,(IX+$00)
LBC10_2:
  ADD IX,DE
  dec B
  jp nz,LBC10_1
  POP AF
  LD (object_rocket),A
  LD HL,print_obj_to_buff
  CALL call_hl_for_all_obj
  LD HL,print_obj_from_buf_to_scr
  CALL call_hl_for_all_obj
  LD A,(wins_counter)
  AND A
  CALL NZ,wins_recovery
  LD A,(briks_quantity_1up)
  AND A
  JP Z,LBBFB_0
  LD A,$08
  LD (sounds_queue),A
  LD A,$3D
  LD (sounds_queue+$01),A
  XOR A
  LD (flag_extra_life),A
  LD IX,object_ball_1
  LD B,$0A
  LD A,(object_bat_1+$02)
  LD C,A
  LD A,(object_bat_2+$02)
  SUB C
  LD (LBCE6+$01),A
  LD A,(object_bat_1+$0C)	; ширина объекта без тени в пикселях
  or a
  rra		; SRL A
  ADD A,C
  SUB $0C
  LD C,A
  LD DE,$0016
  LD L,$1B

LBC10_3:
  LD (IX+$14),$18		; применяемый к объекту бонус
  LD (IX+$15),$18		; Свойства каретки
  LD (IX+$0C),$08		; ширина объекта без тени в пикселях
  LD (IX+$0D),$07		; высота объекта без тени в пикселях
  LD (IX+$08),$02		; ширина спрайта с тенью в байтах
  LD (IX+$09),$0B		; высота спрайта с тенью в пикселях
  LD (IX+$11),D			; 0 - предыдущая высота спрайта с тенью в пикселях
  LD (IX+$01),D			; 0 - номер спрайта в наборе объекта
  LD (IX+$00),$07		; anim_spark
  LD (IX+$02),C			; координата Х объекта
  LD (IX+$04),$AE		; координата Y объекта
  LD (IX+$06),L			; направление полёта
  LD (IX+$07),$02		; скорость движения

  LD A,L
  ADD A,$05
  AND $3F
  LD L,A

  ADD IX,DE
  INC C
  INC C
  INC C
  dec B
  jp nz,LBC10_3

  LD A,(game_mode)
  CP $02
  JP NZ,LBC10_5
  LD IX,object_ball_2
  LD DE,$0016
  LD B,$05
LBC10_4:
  LD A,(IX+$02)
LBCE6:
  ADD A,$00
  LD (IX+$02),A
  ADD IX,DE
  ADD IX,DE
  dec B
  jp nz,LBC10_4
LBC10_5:
  CALL random_generate
  LD HL,handling_object
  CALL call_hl_for_all_obj
  CALL fill_briks_data
  LD HL,ix_buf_addr_calc
  CALL call_hl_for_all_obj
  CALL save_objs_to_buff

  LD HL,print_obj_to_buff
  LD A,(object_ball_2)
  RLA
  CALL NC,call_hl_for_all_obj

  CALL play_sounds_queue
  LD HL,print_obj_from_buf_to_scr
  CALL call_hl_for_all_obj
  LD A,(wins_counter)
  AND A
  CALL NZ,wins_recovery

  CALL restore_objs
  CALL pause_game

  LD A,(object_ball_2)
  AND A
  JP NZ,LBC10_5

  LD B,$03
  CALL pause_long
  LD A,(lives_1up)
live_dec:
  DEC A			; Отнимаем жизнь
  LD (lives_1up),A
  JP Z,LBC10_6
  LD A,(game_mode)
  DEC A
  CALL Z,current_level_2up_copier

  JP LB9E8_1
LBC10_6:
  LD B,$02
  CALL pause_clear_screen_attrib
  CALL clear_screen_attrib
  CALL clear_screen_pix
  LD A,(player_number)
  INC A
  LD (txt_player_0+$0C),A  ; Номер игрока для надписи GAME OVER PLAYER X
  LD DE,txt_game_over
  LD B,$02
  CALL print_message
  LD A,(game_mode)
  CP $02
  CALL Z,print_txt_players_1_and_2
  LD B,$0C
  CALL pause_clear_screen_attrib
  CALL hi_score_update
  CALL input_new_record_name
  LD A,(game_mode)
  CP $02
  JP NZ,LBC10_7
  CALL players_swap
  CALL hi_score_update
  CALL input_new_record_name
  CALL players_swap
  JP game_restart
LBC10_7:
  DEC A
  JP NZ,game_restart
  LD A,(lives_2up)
  AND A
  JP Z,game_restart
  CALL current_level_2up_copier
  JP LB9E8_1

  INCLUDE "./txt/txt_game_over.asm"
  INCLUDE "./txt/txt_player_0.asm"

; Used by the routine at LBC10.
print_txt_players_1_and_2:
  LD DE,txt_players_1_and_2
  JP print_line

  INCLUDE "./txt/txt_players_1_and_2.asm"

; Мусор????
  DEFB $10,$02,$46

; Used by the routine at game_restart.
;--------------------------------------------------
; Перенос данных (пикселей) вместе с цветом из буфера на экран
buff_to_screen_pixs:
	ld hl,zx_scr
	ld de,scr_buff
	ld a,32
buff_to_screen_pixs_1:
	ex af,af'
	push de
	push hl
	ld c,24
buff_to_screen_pixs_2:
; Вывод одного знакоместа
	; Установка цвета для знакоместа
;	push de
;	ld a,e
;	rra
;	rra
;	rra
;	or %11000000
;	ld e,a
;	ld a,(de)
;	ld (color_port),a	; Устанавливаем цвет точек
;	pop de
	;--------------------------------
	ld b,$08
buff_to_screen_pixs_3:
	ld a,(de)
	ld (hl),a
	inc e
	dec l		; поправка направления для Вектора
	dec B
	jp nz,buff_to_screen_pixs_3
	dec c
	jp nz,buff_to_screen_pixs_2
	pop hl
	pop de
	inc h
	inc d
	ex af,af'
	dec a
	jp nz,buff_to_screen_pixs_1
	ret

; Used by the routine at game_restart.
; Перенос всех атрибутов из буфера на экран
buff_to_screen_attrib:
  RET

; Used by the routines at add_points_to_score and current_level_2up_copier.
; Обмен содержимым ячеек адресуемых парами HL и DE
; Количество ячеек для обмена задаётся в регистре B
hl_swap_de:
  LD C,(HL)
  LD A,(DE)
  LD (HL),A
  LD A,C
  LD (DE),A
  INC HL
  INC DE
  dec B
  jp nz,hl_swap_de
  RET

; Used by the routine at LBC10.
; Делает копию текущего уровня 2-го игрока в current_level_copy
current_level_2up_copier:
  LD A,(lives_2up)
  AND A
  RET Z
  LD DE,(current_level_addr)
  PUSH DE
  LD A,(current_level_number_2up)
  CALL level_addr_calc_a
  POP DE
  LD BC,current_level_copy
  LD A,$B4
LBE0C_0:
  EX AF,AF'
  LD A,(DE)
  PUSH AF
  LD A,(BC)
  LD (HL),A
  POP AF
  LD (BC),A
  INC HL
  INC DE
  INC BC
  EX AF,AF'
  DEC A
  JP NZ,LBE0C_0

; This entry point is used by the routines at game_restart and LBC10.
; Обмен данными игроков
players_swap:
  LD HL,lives_1up
  LD DE,lives_2up
  LD B,$08
  CALL hl_swap_de		; Обмен данными игроков
  LD HL,score_1up_in_game
  LD DE,score_2up_in_game
  LD B,$0A
  CALL hl_swap_de		; Обмен счётов игроков
  LD A,(lives_1up)
  AND A
  RET Z		; Возвращаемся, если жизней не осталось
  LD A,(player_number)
  XOR $01
  LD (player_number),A	; Смена номера игрока
  RET

; Used by the routines at game_restart and increment_round_number.
; Подсчитывает количество кирпичей на уровне
briks_calc:
  CALL level_addr_calc
  PUSH HL			; Адрес уровня
  CALL bricks_reset
  POP HL
  LD B,$B4			; 180 - количество всех ячеек на уровне
  LD C,$00
briks_calc_0:
  LD A,(HL)
  AND $A0			; 0x0x xxxx - признак наличия выбиваемого кирпича на уровне
  JP NZ,briks_calc_1
  INC C
briks_calc_1:
  INC HL
  dec B
  jp nz,briks_calc_0
  LD A,C
  LD (briks_quantity_1up),A
  RET

; Used by the routine at LBC10.
; Обновляем рекордный счёт, если текущий счёт выше
hi_score_update:
  LD HL,hi_score+2
  LD DE,current_score_1up+2
  LD B,$03
hi_score_update_0:
  LD A,(DE)
  CP (HL)
  RET C
  JP NZ,hi_score_update_1
  DEC DE
  DEC HL
  dec B
  jp nz,hi_score_update_0
hi_score_update_1:
  LD DE,hi_score
  LD HL,current_score_1up
  LD BC,$0003
  CALL LDIR8080		; LDIR
  RET

; Used by the routine at game_restart.
; Рисуем полный игровой экран со всеми элементами в буфере
game_screen_draw_to_buffer:
  LD HL,spr_level_textures
  LD A,(current_level_number_1up)
  AND $03
  ADD A,A
  CALL hl_add_a
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD (current_texture+$01),DE	; Помещаем указатель на текстуру уровня

;-----------------------------------
; Заполняем буфер текстурой
  LD HL,$0F00			; Координата в экранном буфере
current_texture:
  LD DE,spr_level_texture_1	; Текстура первого уровня
  CALL print_sprite_pix
  CALL print_sprite_attrib
  LD A,$10
  ADD A,L
  LD L,A
  JP NZ,current_texture
  LD L,$00
  LD A,H
  ADD A,$10
  LD H,A
  CP $CF
  JP NZ,current_texture

;-----------------------------------
; Рисуем обрамление игрового поля
  LD HL,$9F00			; Координата в экранном буфере
  LD DE,spr_bord_left_thin
  EXX
  LD HL,$BF00			; Координата в экранном буфере
  LD DE,spr_bord_left_bold
  LD B,$07
LBE8B_1:
  PUSH BC
  PUSH DE
  LD L,$00			; Координата X левого края
  CALL print_sprite_pix
  CALL print_sprite_attrib
  LD L,$F8			; Координата X правого края
  CALL print_sprite_pix
  CALL print_sprite_attrib
  POP DE
  LD A,$C8
  ADD A,H
  LD H,A
  EXX
  POP BC
  dec B
  jp nz,LBE8B_1

;-------------------------
; Рисование дополнительной обводки бордюра толщиной в пиксель слева и справа с внутренней стороны
; Эта процедура считает, что вначале идёт буфер атрибутов, а СРАЗУ за ним - буфер пикселей
  LD HL,scr_buff+$1FA		; Используется нахлёст на атрибуты
  LD C,$04
LBE8B_2:
  LD B,$1C
  PUSH HL
LBE8B_3:
  RES 7,(HL)	; Слева
  inc l
  dec B
  jp nz,LBE8B_3
  POP HL
  PUSH HL
  LD A,H
  ADD A,$1D
  LD H,A
  LD B,$1C
LBE8B_4:
  RES 0,(HL)	; Справа
  inc l
  dec B
  jp nz,LBE8B_4
  POP HL
  LD B,$07
  ld a,l
  add $38
  ld l,a
  DEC C
  JP NZ,LBE8B_2

; При такой организации буфера для Специалиста возможно не требуется данное восстановление
;-------------------------
; Копируются атрибуты из 30-го в 31-й (из 32) столбец в нижних 6 строках
; Восстанавливаются атрибуты, которые портятся на предыдущем шаге. Это видно на голубом и белом фонах.
  ; LD DE,$0020
  ; LD B,$06
  ; LD HL,attr_buff+$25E
  ; LD A,(attr_buff+$25D)
; LBE8B_5:
  ; LD (HL),A
  ; ADD HL,DE
  ; dec B
  ; jp nz,LBE8B_5

;-------------------------
; Рисование верхней части бордюра
  LD HL,set_border_horizontal
  EXX
  LD HL,$0700
LBE8B_6:
  EXX
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH DE
  EXX
  POP DE
  CALL print_sprite_pix
  CALL print_sprite_attrib
  LD A,$20
  ADD A,L
  LD L,A
  JP NC,LBE8B_6

;----------------------------
; Рисование дополнительной обводки толщиной в пиксель бордюра сверху с внутренней стороны
  LD HL,scr_buff+$108
  LD DE,border_horizontal_addon
  LD B,$1E
LBE8B_7:
  LD A,(DE)
  AND (HL)
  LD (HL),A
  INC H
  INC DE
  dec B
  jp nz,LBE8B_7

;-----------------------------------------
; Рисуем индикаторы количества жизней
  LD A,$08 ; Координата X для указателя первой жизни
  LD (object_lives_indicator+$02),A
  LD A,(lives_1up)
  DEC A
  JP Z,LBE8B_10		; Если жизнь только одна, то не рисуем
  LD B,A
  LD IX,object_lives_indicator
LBE8B_8:
  PUSH BC
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff
  LD A,(object_lives_indicator+$02)	; Координата X
  ADD A,$10		; на 16 правее
  CP $E9		; Если жизни не помещаются на экран, то не рисуем
  JP NC,LBE8B_9
  LD (object_lives_indicator+$02),A
LBE8B_9:
  POP BC
  dec B
  jp nz,LBE8B_8

;---------------------------------
; Рисуем разделитель игроков, если соответствующий режим игры
LBE8B_10:
  LD A,(game_mode)
  CP $02
  JP NZ,LBE8B_11
  LD IX,object_separator
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff

;------------------------------
; Рисуем 1UP, HI и 2UP
LBE8B_11:
  LD IX,object_score_indicator
  LD (IX+$02),$1C
  LD (IX+$01),$01		; spr_1up
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff
  INC (IX+$01)			; spr_2up
  LD (IX+$02),$CC
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff
  INC (IX+$01)			; spr_hi
  LD (IX+$02),$78
  CALL ix_buf_addr_calc
  CALL print_obj_to_buff

;----------------------------
; Рисуем цифры счетов игроков и рекорда
  LD HL,(score_1up_in_game)
  EXX
  LD HL,current_score_1up+2
  CALL print_score_in_game

  LD HL,(score_2up_in_game)
  EXX
  LD HL,current_score_2up+2
  CALL print_score_in_game

  LD HL,(hi_score_in_game)
  EXX
  LD HL,hi_score+2
  CALL print_score_in_game

  CALL print_magnets

  CALL print_briks

	IFDEF MX
; Рисует на поле тень от бордюра
	; Вертикаль
	LD HL,attr_buff+$0101
	LD B,$17
LBFCF_0:
	ld a,(hl)
	and %01110111
	ld (hl),a
	inc l
	dec B
	jp nz,LBFCF_0
	; Горизонталь
	LD HL,attr_buff+$0201
	LD B,$1D
LBFCF_1:
	ld a,(hl)
	and %01110111
	ld (hl),a
	INC h
	dec B
	jp nz,LBFCF_1
	ENDIF

	ret

; Последовательность спрайтов в горизонтали рамки
set_border_horizontal:
  DEFW spr_bord_horiz_left_edge
  DEFW spr_bord_horiz_left_thin
  DEFW spr_bord_horiz_left_bold
  DEFW spr_bord_horiz_left_thin
  DEFW spr_bord_horiz_right_thin
  DEFW spr_bord_horiz_right_bold
  DEFW spr_bord_horiz_right_thin
  DEFW spr_bord_horiz_right_edge

; Дополнительная линия для горизонтальной части рамки
border_horizontal_addon:
  DEFB $00,$00,$03,$FF,$FF,$FF,$C0,$00,$00,$00
  DEFB $03,$FF,$FF,$FF,$C0,$03,$FF,$FF,$FF,$C0
  DEFB $00,$00,$00,$03,$FF,$FF,$FF,$C0,$00,$00

; Графика текстуры уровня 1
  INCLUDE "./gfx/sprites_color_3.asm"

; Used by the routines at print_obj_from_buf_to_scr, LAFFC, print_sprite_pix, ix_buf_addr_calc and game_start.
; На входе в HL координаты
; H - Y (0-192)
; L - X (0-255)
; На выходе в HL адрес в буфере scr_buff ($DA00)
scr_buff_addr_calc:		; Specialist ready
	ld a,l
	rra
	rra
	rra
	and %11111
	ld b,a
	ld c,h
	ld hl,scr_buff
	add hl,bc
	ret

; Used by the routines at LAFFC and print_sprite_attrib.
; На входе в HL координаты,
; H - Y (0-192)
; L - X (0-255)
; на выходе там же адрес в буфере атрибутов D700
scr_buff_attr_calc:		; Specialist ready
	ld a,l
	rra
	rra
	rra
	and %11111
	ld b,a
	ld a,h
	rra
	rra
	rra
	and %11111
	ld c,a
	ld hl,attr_buff
	add hl,bc
	ret

; Процедуры работы со звуком
  INCLUDE "./routines/sound.asm"

;  INCLUDE "./routines/specialist.asm"

; 3 байта - Системная переменная FRAMES (Системный счётчик $5C78)
frames:
	DEFB $00

; Сумма ширин (с некоторым коэффициентом) всех объектов на экране
objs_width_sum:
	DEFB $00

; Количество шариков на поле
balls_quantity:
	DEFB $00

; Флаг. 0 или 1. Назначение пока непонятно.
flag_2:
	DEFB $00

; Счётчик. В одном месте обнуляется, в двух увеличивается. В одном месте сравнивается с 3.
counter_2:
	DEFB $00

; Если не 0, то нужно обновить цифры счёта на экране
scr_score_need_upd:
	DEFB $00

;--------------------------------------------
BATTYCODE_END:
	ASSERT BATTYCODE_END <= $5d00

; Буфер на $100 Сюда копируются 180 ($B4) байт кирпичей из текущего уровня
current_level_copy EQU $5d00

; Буфер на $200 для сохранения объектов с тенью и фоном из экранного буфера (макс: 1 + $0B * $16 = $F3 = 243).
; В первой ячейке - количество объектов в буфере, далее $B объектов по $16 байт:
; +00 - младший адрес в экранном буфере
; +01 - старший адрес в экранном буфере
; +03 - шаг отступа для выполнения череды LDI
; +04 - высота спрайта с тенью в пикселях + 1
; +05...XX - данные спрайта с тенью и фоном
; Буфер должен быть не менее $200 байт

; Буферу и стеку хватает $200 байт
save_objs_buff EQU $5e00
; Верхушка стека
stack EQU save_objs_buff + $200

; Буфер на $2100 теневого экрана 256*256 точек = 256*(256/8) = $2000
; В конце нужно ещё 256 байт, которые портятся из-за тени от искры
scr_buff EQU $6000
attr_buff EQU scr_buff+$c0

; Буфер на $100 для $0B объектов по $16 байт = $DC
objects_buff_2 EQU $8100

; Буфер размером $e00 ($1000 - $200) Адрес генерируемой таблицы сдвигов байтов
table_shifts EQU $8200

;=================================
end_bin:
