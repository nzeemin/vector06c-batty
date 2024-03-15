; Графика: элементы обрамления экрана

; Data block at 6B17
; Левый боковой элемент в виде двух концов ракеток (дверь?)
; В игре нигде не используется
spr_bord_unused:
  DEFB $01,$20,$9F,$00,$00,$00,$00,$CF
  DEFB $6E,$3C,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$3C,$6E,$CF,$00,$00,$00
  DEFB $00,$9F,$01,$04,$45,$47,$47,$45

; Data block at 6B3F
; Следующие два спрайта должны идти строго друг за другом
; Левая боковина в виде ракетки
spr_bord_left_bold:
  DEFB $01,$20
  DEFB $3C,$6E,$CF,$9F,$9F,$9F,$9F,$60
  DEFB $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F
  DEFB $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F
  DEFB $60,$9F,$9F,$9F,$9F,$CF,$6E,$3C
  DEFB $01,$04
  DEFB c45,c05,c05,c45
; Правая боковина в виде ракетки
  DEFB $01,$20
  DEFB $3C,$76,$F3,$F9,$F9,$F9,$F9,$06
  DEFB $F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9
  DEFB $F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9
  DEFB $06,$F9,$F9,$F9,$F9,$F3,$76,$3C
  DEFB $01,$04
  DEFB c45,c05,c05,c45

; Data block at 6B8F
; Следующие два спрайта должны идти строго друг за другом
; Левая боковина в виде трубы
spr_bord_left_thin:
  DEFB $01,$18
  DEFB $00,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $00,$5E,$5E,$5E,$5E,$5E,$5E,$00
  DEFB $3C,$3C,$3C,$3C,$3C,$3C,$3C,$00
  DEFB $01,$03
  DEFB c07,c47,c07
; Правая боковина в виде трубы
  DEFB $01,$18
  DEFB $00,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $00,$7A,$7A,$7A,$7A,$7A,$7A,$00
  DEFB $3C,$3C,$3C,$3C,$3C,$3C,$3C,$00
  DEFB $01,$03
  DEFB c07,c47,c07

; Data block at 6BCD
; Горизонталь, левый крайний элемент
spr_bord_horiz_left_edge:
  DEFB $04,$08
  DEFB $9E,$9D,$9B,$97,$AF,$D0,$A0,$7F
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $6C,$6E,$6F,$6F,$69,$93,$96,$6C
  DEFB $04,$01
  DEFB c05,c05,c05,c45

; Data block at 6BF5
; Горизонталь, левая сторона в виде трубы
spr_bord_horiz_left_thin:
  DEFB $04,$08
  DEFB $00,$00,$7F,$7F,$7F,$7F,$00,$00
  DEFB $00,$7E,$7E,$7E,$7E,$00,$7E,$00
  DEFB $00,$00,$FE,$FE,$FE,$FE,$00,$00
  DEFB $3E,$7E,$FE,$FE,$9E,$C1,$61,$3E
  DEFB $04,$01
  DEFB c07,c47,c07,c45

; Data block at 6C1D
; Горизонталь, левая сторона в виде ракетки
spr_bord_horiz_left_bold:
  DEFB $04,$08
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $7C,$7E,$7F,$7F,$79,$83,$86,$7C
  DEFB $04,$01
  DEFB c05,c05,c05,c45

; Data block at 6C45
; Горизонталь, правая сторона в виде трубы
spr_bord_horiz_right_thin:
  DEFB $04,$08
  DEFB $7C,$7E,$7F,$7F,$79,$83,$86,$7C
  DEFB $00,$00,$7F,$7F,$7F,$7F,$00,$00
  DEFB $00,$7E,$7E,$7E,$7E,$00,$7E,$00
  DEFB $00,$00,$FE,$FE,$FE,$FE,$00,$00
  DEFB $04,$01
  DEFB c45,c07,c47,c07

; Data block at 6C6D
; Горизонталь, правая сторона в виде ракетки
spr_bord_horiz_right_bold:
  DEFB $04,$08
  DEFB $3E,$7E,$FE,$FE,$9E,$C1,$61,$3E
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $04,$01
  DEFB c45,c05,c05,c05

; Data block at 6C95:
; Горизонталь, правый крайний элемент
spr_bord_horiz_right_edge:
  DEFB $04,$08
  DEFB $36,$76,$F6,$F6,$96,$C9,$69,$36
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
  DEFB $79,$B9,$D9,$E9,$F5,$0B,$05,$FE
  DEFB $04,$01
  DEFB c45,c05,c05,c05
