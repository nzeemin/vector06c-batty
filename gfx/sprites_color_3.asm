spr_level_texture_1:
  DEFB $02,$10							; Размер текстуры
  DEFB #FE,#FE,#FE,#FE,#FE,#FE,#FE,#F9	; Текстура первая колонка
  DEFB #E7,#9F,#7F,#FF,#7F,#9F,#E7,#F9
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$3F	; Текстура вторая колонка
  DEFB $CF,$F3,$FD,$FE,$FD,$F3,$CF,$3F
  DEFB $02,$02							; Размер раскраски
  DEFB c46,c46,c46,c46
  
  
  ; DEFB $02,$10							; Размер текстуры
  ; DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  ; DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  ; DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  ; DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  ; DEFB $02,$02							; Размер раскраски
  ; DEFB c46,c46,c46,c46
  
  


  ; DEFB $02,$10							; Размер текстуры
  ; DEFB $55,$AA,$55,$AA,$55,$AA,$55,$AA
  ; DEFB $55,$AA,$55,$AA,$55,$AA,$55,$AA
  ; DEFB $55,$AA,$55,$AA,$55,$AA,$55,$AA
  ; DEFB $55,$AA,$55,$AA,$55,$AA,$55,$AA
  ; DEFB $02,$02							; Размер раскраски
  ; DEFB c46,c46,c46,c46