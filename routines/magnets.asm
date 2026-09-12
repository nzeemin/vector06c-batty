; Used by the routine at game_screen_draw_to_buffer.
; Рисует в буфере все магниты на уровне
print_magnets:
  LD A,$1E	; Меняем высоту спрайта - 30 точек
  LD (spr_magnet_circle_on+1),A
  LD A,(current_level_number_1up)
  ADD A,A
  LD HL,magnets
  CALL hl_add_a
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (IYobj),HL		; В IYobj адрес данных по магнитам для данного уровня
  LD A,(HL)		; IY+$00
  LD (magnets_quantity),A
  AND A
  RET Z
  LD HL,magnet_properties
  LD (IXobj),HL
L8D4C_0:
  PUSH AF
  LD HL,(IXobj)
  INC HL		; +$01
  LD (HL),$06		; IX+$01

  LD HL,(IYobj)
  EX DE,HL
  INC DE		; +$01
  LD A,(DE)		; IY+$01 Координата X магнита
  LD L,A
  INC DE		; +$02
  LD A,(DE)		; IY+$02 Координата Y магнита
  LD H,A
  ; DE уже указывает на +$02 (продвинут на 2 от исходного IYobj, как INC IY / INC IY)
  PUSH HL		; сохраняем координаты (X,Y)
  EX DE,HL
  LD (IYobj),HL
  POP HL

  PUSH HL		; HL = (X,Y) magnet coords
  LD HL,(IXobj)
  INC HL
  INC HL		; +$02
  POP DE		; D=H(Y), E=L(X)
  LD (HL),E		; IX+$02 Запоминаем координату X магнита
  INC HL
  INC HL		; +$04
  LD (HL),D		; IX+$04 Запоминаем координату Y магнита

  CALL ix_buf_addr_calc
  CALL print_obj_to_buff
  LD HL,(IXobj)
  LD DE,$0004
  ADD HL,DE
  LD A,(HL)		; IX+$04
  ADD A,$05
  LD (HL),A		; IX+$04
  CALL random_generate
  LD A,(random_number)
  RRA
  JP C,L8D4C_1
  LD HL,(IXobj)
  INC HL		; +$01
  LD (HL),$07		; IX+$01
  CALL print_obj_to_buff
L8D4C_1:
  LD HL,(IXobj)
  INC HL
  INC HL		; +$02
  LD A,(HL)		; IX+$02
  ADD A,$05
  LD (HL),A		; IX+$02
  LD HL,(IXobj)
  LD DE,$0010
  ADD HL,DE
  LD (IXobj),HL
  POP AF
  DEC A
  JP NZ,L8D4C_0
  LD A,$17		; Меняем высоту спрайта - 23 точки
  LD (spr_magnet_circle_on+1),A
  RET

magnets_quantity:
  DEFB $00

magnet_properties:
  DEFB $03,$06,$00,$00,$00,$00,$00,$00
  DEFB $04,$1E,$00,$00,$0F,$0E,$00,$00

  DEFB $03,$06,$00,$00,$00,$00,$00,$00
  DEFB $04,$1E,$00,$00,$0F,$0E,$00,$00

  DEFB $03,$06,$00,$00,$00,$00,$00,$00
  DEFB $04,$1E,$00,$00,$0F,$0E,$00,$00

  DEFB $03,$06,$00,$00,$00,$00,$00,$00
  DEFB $04,$1E,$00,$00,$0F,$0E,$00,$00

  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

;-----------------------------------------
; Таблица магнитов для уровней
magnets:
  DEFW magnet_level_03		; Данные для первого уровня берутся из 3-го
  DEFW magnet_level_02
  DEFW magnet_level_03
  DEFW magnet_level_04
  DEFW magnet_level_05
  DEFW magnet_level_06
  DEFW magnet_level_07
  DEFW magnet_level_08
  DEFW magnet_level_09
  DEFW magnet_level_10
  DEFW magnet_level_11
  DEFW magnet_level_12
  DEFW magnet_level_13
  DEFW magnet_level_14
  DEFW magnet_level_15
  DEFW magnet_level_15		; Для чего-то продублирован 15-й уровень

; Первый байт - количество магнитов на уровне, далее по два байта их координаты
magnet_level_15:
  DEFB $02,$4C,$82,$9C,$82
magnet_level_14:
  DEFB $04,$8C,$24,$C4,$24,$8C,$64,$C4,$64
magnet_level_13:
  DEFB $04,$10,$20,$D8,$20,$18,$6C,$D0,$6C
magnet_level_12:
  DEFB $03,$74,$08,$20,$44,$C8,$44
magnet_level_11:
  DEFB $02,$5C,$84,$8C,$84
magnet_level_10:
  DEFB $01,$74,$44
magnet_level_09:
  DEFB $04,$40,$3C,$A8,$3C,$54,$6C,$94,$6C
magnet_level_08:
  DEFB $03,$74,$18,$4C,$74,$9C,$74
magnet_level_07:
  DEFB $02,$30,$5C,$D8,$5C
magnet_level_06:
  DEFB $03,$74,$10,$48,$73,$A0,$73
magnet_level_05:
  DEFB $00
magnet_level_04:
  DEFB $01,$74,$7C
magnet_level_03:
  DEFB $00
magnet_level_02:
  DEFB $01,$74,$2C
;-----------------------------------------

current_magnet_prop:
  DEFW $0000

; Used by the routine at LB9E8.
print_one_magnet:
  LD A,(magnets_quantity)
  AND A
  RET Z
  DEC A
  LD B,A
L8E72_0:
  PUSH BC
  CALL random_generate
  LD A,(random_number)
  AND $03
  POP BC
  CP B
  JP Z,L8E72_1
  JP NC,L8E72_0
L8E72_1:
  ADD A,A		; 2+2
  ADD A,A		; 4+4
  ADD A,A		; 8+8
  ADD A,A		; 16+16
  LD HL,magnet_properties
  CALL hl_add_a
  LD (current_magnet_prop),HL
  LD (IXobj),HL ;NOTE: нужен для print_obj_to_buff
  inc HL
  LD A,(HL)		; IX+$01
  XOR $01
  LD (HL),A		; IX+$01
  inc HL
  LD A,(HL)		; IX+$02
  PUSH AF
  SUB $05
  LD (HL),A		; IX+$02
  push HL
  CALL print_obj_to_buff
  pop HL
  POP AF
  LD (HL),A		; IX+$02
  JP play_sound_magnet
  ;RET
