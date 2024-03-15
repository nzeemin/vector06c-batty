txt_player_0_enter_your_name:

  DEFB $50,$0F,c47,$0C
  DEFB $26,$26,$19,$15,$0A,$22,$0E,$1B  ; __PLAYER 0__ (по два пробела с двух сторон)
  DEFB $26,$00,$26,$26

  DEFB $40,$17,c47,$10
  DEFB $0E,$17,$1D,$0E,$1B,$26,$22,$18  ; ENTER YOUR NAME.
  DEFB $1E,$1B,$26,$17,$0A,$16,$0E,$24
