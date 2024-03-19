; Предварительная подготовка к запуску

  DI
  LD SP,stack
  LD A,c00  ; Чёрный
  ;CALL cls ;DEBUG

; -----------------
; Генерируется таблица по адресу $F200-$FFFF (7 * 2 * $100 = $E00 байт)
; По этой таблице сдвигаются спрайты по горизонтали, кроме шарика и всех видов кареток.
  LD HL,table_shifts
  LD B,$01	; 1..7
table_gen_0:
  LD C,$00	; $00..$FF
table_gen_1:
  LD D,C
  push BC
  ld E,$00
table_gen_2:
  ld A,D
  or A
  rra		; SRL D
  ld D,A
  ld A,E
  rra		; RR E
  ld E,A
  DEC B
  JP NZ,table_gen_2
  INC H
  LD (HL),E
  DEC H
  LD (HL),D
  INC HL
  pop BC
  INC C
  JP NZ,table_gen_1
  INC H
  INC B
  ld A,B
  cp 8		; BIT 3,B
  jp nz,table_gen_0

  CALL spr_shift_gen	; Генерация сдвинутых спрайтов шарика и всех видов кареток

; Инвертируется некоторая графика
  LD HL,gfx_bat
gfx_inverse_1:
  ld E,(HL)
  inc HL
  ld D,(HL)
  inc HL
  ld A,E
  or D
  JP Z,L6800_6	; Прекращаем, если вместо адреса следующего спрайта нули
  push HL	; save
  ex DE,HL
  LD C,(HL)
  INC HL
  LD E,(HL)
  INC HL
gfx_inverse_2:
  LD B,C
gfx_inverse_3:
  LD A,(HL)
  INC HL
  XOR (HL)
  LD (HL),A
  INC HL
  dec B
  jp nz,gfx_inverse_3
  DEC E
  JP NZ,gfx_inverse_2
  pop HL	; restore
  JP gfx_inverse_1

L6800_6:
  LD A,$0C	; Устанавливается высота спрайта ракеты в 12 пикселей (отсекается пламя)
  LD (spr_bonus_rocket_1+1),A
  ei
  JP game_start  ; Запуск игры

; Used by the routine at 6800.
; Формирование сдвинутых спрайтов для мяча и разных видов кареток
spr_shift_gen:
  ld HL,L68D7
L6800_8:
  ld E,(HL)	; (IX+$00)
  inc HL
  ld D,(HL)	; (IX+$01)
  inc HL
  ld A,D
  or E
  RET Z
  ld C,(HL)	; (IX+$02)
  inc HL
  ld A,C
  or A
  rra		; SRL C
  ld C,A
  ld A,(HL)	; (IX+$03)
  inc HL
  push HL
  ld H,(HL)	; (IX+$04)
  ld L,A
  ex DE,HL
  LD A,$01
  LD (L68A4+1),A
L6800_9:
  SRL C
  PUSH BC
  CALL C,one_spr_shift_gen
  POP BC
  LD A,C
  AND A
  JP Z,L6800_10
  LD A,(L68A4+1)	; ok (этот комментарий необходим для отключения warning компилятора)
  INC A
  LD (L68A4+1),A
  JP L6800_9
L6800_10:
  pop HL
  inc HL
  JP L6800_8

; Генерация одной фазы сдвига спрайта
; HL - адрес спрайта
; DE - адрес пустого спрайта
; C - сдвиг
one_spr_shift_gen:
  PUSH HL
  LD A,(HL)
  LD (L6899+1),A	; Ширина обрабатываемого спрайта в байтах
  INC A
  LD (DE),A			; Ширина + 1 обрабатываемого спрайта в байтах
  INC HL
  INC DE
  LD A,(HL)
  LD (DE),A			; Высота обрабатываемого спрайта
  INC HL
  INC DE
L6800_12:
  EX AF,AF'

L6899:
  LD B,$00		; Начинается цикл по ширине спрайта
L6800_13:
  PUSH BC
  PUSH DE
  LD A,(HL)		; А - байт маски
  INC HL
  LD E,(HL)		; E - байт спрайта
  INC HL
  LD D,$00
  LD C,D

L68A4:
  LD B,$00
L6800_14:
  ld (L6800_20+1),A ; save A
  ld A,E
  or A
  rra		; SRL E
  ld E,A
  ld A,D
  rra		; RR D
  ld D,A
L6800_20: ld A,$00 ; restore A
  or a
  rra		; SRL A
  ld (L6800_22+1),A ;TODO: save A
  ld A,C
  rra		; RR C
  ld C,A
L6800_22: ld A,$00 ; restore A
  dec b
  jp nz,L6800_14

  LD B,A
  LD A,D
  LD (L68C8+1),A
  LD A,E
  LD (L68BF+1),A
  POP DE
  LD A,(DE)
  OR B
  LD (DE),A
  INC DE
  LD A,(DE)
L68BF:
  OR $00
  LD (DE),A
  INC DE
  LD A,(DE)
  OR C
  LD (DE),A
  INC DE
  LD A,(DE)
L68C8:
  OR $00
  LD (DE),A
  DEC DE
  POP BC
  dec b
  jp nz,L6800_13
  INC DE
  INC DE
  EX AF,AF'
  DEC A
  JP NZ,L6800_12
  POP HL
  RET

L68D7:
  DEFW spr_ball_normal			; Спрайт для сдвига
  DEFB $FF						; Ненулевой бит - фаза сдвига (7 фаз - первый бит не учитывается)
  DEFW spr_ball_normal_shift_1	; Куда помещать сдвинутые спрайты

  DEFW spr_bat_normal			; Спрайт для сдвига
  DEFB $10						; Ненулевой бит - фаза сдвига (1 фаза)
  DEFW spr_bat_normal_shift		; Куда помещать сдвинутый спрайт

  DEFW spr_bat_big				; Спрайт для сдвига
  DEFB $10						; Ненулевой бит - фаза сдвига (1 фаза)
  DEFW spr_bat_big_shift		; Куда помещать сдвинутый спрайт

  DEFW spr_bat_gun				; Спрайт для сдвига
  DEFB $10						; Ненулевой бит - фаза сдвига (1 фаза)
  DEFW spr_bat_gun_shift		; Куда помещать сдвинутый спрайт

  DEFW $0000 ; Маркер конца
