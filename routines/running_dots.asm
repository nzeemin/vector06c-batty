
; Used by the routine at LBAED.
; Обмен содержимым ячеек running_dot_frame_1up и running_dot_frame_2up
running_dot_frame_swap:
  LD A,(running_dot_frame_1up)
  LD B,A
  LD A,(running_dot_frame_2up)
  LD (running_dot_frame_1up),A
  LD A,B
  LD (running_dot_frame_2up),A
  RET

; Used by the routine at LBAED.
; Рисование двух бегающих точек на каретке
; HL = <object_bat_1 либо object_bat_2> + 2
running_dot:
  ld A,(HL)		; Координата X для печати
  ld (running_dot_batx),A
  ld DE,$000A	; переходим к IX+$0C
  add HL,DE
  ld A,(HL)		; ширина объекта
  ld (running_dot_batw),A

  LD DE,scr_buff+$b3 ; $F060 - адрес строки в буфере, где бегают точки по каретке
  LD A,(running_dot_frame_1up)
  AND $7F
  LD B,A
  LD A,(running_dot_batw)	; ширина объекта
  SUB B
  CP $09
  JP NC,LB8E6_0
  LD A,(running_dot_batw)	; ширина объекта
  SUB $0B
  LD B,A		; В В константа для расчёта обеих точек
  LD A,(running_dot_frame_1up)
  AND $80
  OR B
  LD (running_dot_frame_1up),A
LB8E6_0:
  LD A,(running_dot_batx)		; Координата X для печати
  ADD A,B
  LD C,A
  RRA
  RRA
  RRA
  AND $1F
    add a,d
    ld d,a
  LD A,C	; Положение точки внутри каретки
  AND $07
  LD HL,running_dot_mask
  CALL hl_add_a
  LD A,(DE)
  AND (HL)
  LD (DE),A		; Запись первой точки

  LD A,(running_dot_batx)	; Координата X для печати
  ld d,a
  LD A,(running_dot_batw)	; ширина объекта
  add a,d
  SUB B
  DEC A
  LD C,A
  RRA
  RRA
  RRA
  AND $1F
  add a,scr_buff/256	; Вычисление положения второй точки
  ld d,a
  LD A,C
  AND $07
  LD HL,running_dot_mask
  CALL hl_add_a
  LD A,(DE)
  AND (HL)
  LD (DE),A		; Запись второй точки

  LD A,(running_dot_frame_1up)
  or A			; BIT 7,A
  JP Z,LB8E6_1
  and %01111111		; RES 7,A
  DEC A
  CP $09
  JP Z,LB8E6_2
  OR $80
  LD (running_dot_frame_1up),A
  RET
LB8E6_1:
  INC A
  LD B,A
  LD A,(running_dot_batw)	; ширина объекта
  SUB B
  CP $0A
  JP NZ,LB8E6_3
LB8E6_2:
  LD A,(running_dot_frame_1up)
  XOR $80
  LD (running_dot_frame_1up),A
  RET
LB8E6_3:
  LD A,B
  LD (running_dot_frame_1up),A
  RET

running_dot_batx: DEFB 0	; временная переменная под координату X
running_dot_batw: DEFB 0	; временная переменная под ширину

; Бегающая по каретке точка
running_dot_mask:
  DEFB %01111111	; $7F
  DEFB %10111111	; $BF
  DEFB %11011111	; $DF
  DEFB %11101111	; $EF
  DEFB %11110111	; $F7
  DEFB %11111011	; $FB
  DEFB %11111101	; $FD
  DEFB %11111110	; $FE
; Кадр рисования точек на каретке
running_dot_frame_1up:
  DEFB $0E
; Кадр рисования точек на каретке для второго игрока
running_dot_frame_2up:
  DEFB $0E
