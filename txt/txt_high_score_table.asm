txt_high_score_table:

  DEFB $38,$26,c47,$02
  DEFB $01,$24			; 1.

  DEFB $38,$36,c47,$02
  DEFB $02,$24			; 2.

  DEFB $38,$46,c46,$02
  DEFB $03,$24			; 3.

  DEFB $38,$56,c46,$02
  DEFB $04,$24			; 4.

  DEFB $38,$66,c45,$02
  DEFB $05,$24			; 5.

  DEFB $38,$76,c45,$02
  DEFB $06,$24			; 6.

  DEFB $38,$86,c44,$02
  DEFB $07,$24			; 7.

  DEFB $38,$96,c44,$02
  DEFB $08,$24			; 8.

  DEFB $38,$A6,c43,$02
  DEFB $09,$24			; 9.

  DEFB $30,$B6,c43,$03
  DEFB $01,$00,$24		; 10.

  DEFB $58,$26,c47,$0E
  DEFB $01,$00,$00,$00,$00,$00,$26	; 100000   H I T
  DEFB $26,$26,$11,$26,$12,$26,$1D

  DEFB $58,$36,c07,$0E
  DEFB $00,$09,$00,$00,$00,$00,$26	; 090000   P A K
  DEFB $26,$26,$19,$26,$0A,$26,$14

  DEFB $58,$46,c46,$0E
  DEFB $00,$08,$00,$00,$00,$00,$26	; 080000   H I T
  DEFB $26,$26,$11,$26,$12,$26,$1D

  DEFB $58,$56,c06,$0E
  DEFB $00,$07,$00,$00,$00,$00,$26	; 070000   P A K
  DEFB $26,$26,$19,$26,$0A,$26,$14

  DEFB $58,$66,c45,$0E
  DEFB $00,$06,$00,$00,$00,$00,$26	; 060000   H I T
  DEFB $26,$26,$11,$26,$12,$26,$1D

  DEFB $58,$76,c05,$0E
  DEFB $00,$05,$00,$00,$00,$00,$26	; 050000   P A K
  DEFB $26,$26,$19,$26,$0A,$26,$14

  DEFB $58,$86,c44,$0E
  DEFB $00,$04,$00,$00,$00,$00,$26	; 040000   H I T
  DEFB $26,$26,$11,$26,$12,$26,$1D

  DEFB $58,$96,c04,$0E
  DEFB $00,$03,$00,$00,$00,$00,$26	; 030000   P A K
  DEFB $26,$26,$19,$26,$0A,$26,$14

  DEFB $58,$A6,c43,$0E
  DEFB $00,$02,$00,$00,$00,$00,$26	; 020000   H I T
  DEFB $26,$26,$11,$26,$12,$26,$1D

  DEFB $58,$B6,c03,$0E
  DEFB $00,$01,$00,$00,$00,$00,$26	; 010000   P A K
  DEFB $26,$26,$19,$26,$0A,$26,$14
