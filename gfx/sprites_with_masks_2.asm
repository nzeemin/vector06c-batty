; Спрайт: бомба
; Data block at 786A
spr_bomb:
  DEFB $02,$10
  DEFB $7C,$00,$00,$00
  DEFB $FE,$5C,$00,$00
  DEFB $7C,$38,$00,$00
  DEFB $38,$00,$00,$00
  DEFB $7C,$38,$00,$00
  DEFB $FE,$5C,$00,$00
  DEFB $FE,$5C,$00,$00
  DEFB $FE,$5C,$F8,$00
  DEFB $FE,$5C,$70,$00
  DEFB $7C,$38,$00,$00
  DEFB $38,$00,$70,$00
  DEFB $00,$00,$F8,$00
  DEFB $00,$00,$F8,$00
  DEFB $00,$00,$F8,$00
  DEFB $00,$00,$F8,$00
  DEFB $00,$00,$70,$00

; Спрайт: магнитный круг выключен (маска без тени)
; Data block at 78AC
spr_magnet_circle_off:
  DEFB $03,$17
  DEFB $00,$00,$FF,$00,$80,$00
  DEFB $07,$00,$FF,$7F,$F0,$00
  DEFB $1F,$03,$FF,$C1,$FC,$E0
  DEFB $3F,$0E,$FF,$1C,$FE,$38
  DEFB $3F,$18,$FF,$10,$FE,$0C
  DEFB $7F,$11,$FF,$18,$FF,$44
  DEFB $7F,$32,$FF,$90,$FF,$A6
  DEFB $7F,$24,$FF,$41,$FF,$52
  DEFB $FF,$22,$FF,$9C,$FF,$02
  DEFB $FF,$61,$FF,$26,$FF,$03
  DEFB $FF,$40,$FF,$4F,$FF,$01
  DEFB $FF,$4C,$FF,$5F,$FF,$19
  DEFB $FF,$4C,$FF,$5F,$FF,$19
  DEFB $FF,$40,$FF,$7F,$FF,$01
  DEFB $FF,$60,$FF,$3E,$FF,$03
  DEFB $FF,$21,$FF,$1C,$FF,$42
  DEFB $7F,$22,$FF,$80,$FF,$82
  DEFB $7F,$34,$FF,$5D,$FF,$46
  DEFB $7F,$12,$FF,$90,$FF,$84
  DEFB $3F,$19,$FF,$18,$FF,$4C
  DEFB $3F,$0E,$FF,$10,$FF,$38
  DEFB $1F,$03,$FF,$C1,$FE,$E0
  DEFB $07,$00,$FF,$7F,$F5,$00

; Спрайт: магнитный круг включен (маска с тенью)
; Data block at 7938
spr_magnet_circle_on:
  DEFB $04,$1E
  DEFB $00,$00,$FF,$00,$80,$00,$00,$00
  DEFB $07,$00,$FF,$7F,$F0,$00,$00,$00
  DEFB $1F,$03,$FF,$F7,$FC,$E0,$00,$00
  DEFB $3F,$0F,$FF,$F7,$FE,$F8,$00,$00
  DEFB $3F,$1F,$FF,$F7,$FE,$FC,$00,$00
  DEFB $7F,$1F,$FF,$F7,$FF,$FC,$00,$00
  DEFB $7F,$27,$FF,$C1,$FF,$F2,$00,$00
  DEFB $7F,$39,$FF,$E3,$FF,$CE,$00,$00
  DEFB $FF,$3E,$FF,$B6,$FF,$BE,$80,$00
  DEFB $FF,$7F,$FF,$3E,$FF,$7F,$80,$00
  DEFB $FF,$7E,$FF,$3E,$FF,$3F,$C0,$00
  DEFB $FF,$7F,$FF,$FF,$FF,$FF,$A0,$00
  DEFB $FF,$7F,$FF,$FF,$FF,$FF,$D0,$00
  DEFB $FF,$7E,$FF,$3E,$FF,$3F,$A8,$00
  DEFB $FF,$7F,$FF,$3E,$FF,$7F,$D0,$00
  DEFB $FF,$3E,$FF,$B6,$FF,$BE,$A8,$00
  DEFB $7F,$39,$FF,$E3,$FF,$CE,$54,$00
  DEFB $7F,$27,$FF,$C1,$FF,$F2,$A8,$00
  DEFB $7F,$1F,$FF,$F7,$FF,$FC,$54,$00
  DEFB $3F,$1F,$FF,$F7,$FF,$FC,$A8,$00
  DEFB $3F,$0F,$FF,$F7,$FF,$F8,$54,$00
  DEFB $1F,$03,$FF,$F7,$FE,$E0,$A8,$00
  DEFB $07,$00,$FF,$7F,$F5,$00,$50,$00
  DEFB $00,$00,$FF,$00,$AA,$00,$A8,$00
  DEFB $00,$00,$55,$00,$55,$00,$50,$00
  DEFB $00,$00,$AA,$00,$AA,$00,$A0,$00
  DEFB $00,$00,$55,$00,$55,$00,$50,$00
  DEFB $00,$00,$2A,$00,$AA,$00,$A0,$00
  DEFB $00,$00,$05,$00,$55,$00,$40,$00
  DEFB $00,$00,$00,$00,$AA,$00,$00,$00

; Спрайт: разделитель поля для двоих игроков
; Data block at 7A2A
spr_separator:
  DEFB $02,$18
  DEFB $30,$00,$00,$00
  DEFB $78,$30,$00,$00
  DEFB $FC,$58,$00,$00
  DEFB $FC,$58,$00,$00
  DEFB $FC,$58,$00,$00
  DEFB $FC,$00,$00,$00
  DEFB $FC,$58,$00,$00
  DEFB $FC,$58,$00,$00
  DEFB $FC,$58,$00,$00
  DEFB $FC,$58,$60,$00
  DEFB $FC,$58,$F0,$00
  DEFB $FC,$00,$F0,$00
  DEFB $FC,$58,$F0,$00
  DEFB $FC,$58,$F0,$00
  DEFB $FC,$58,$F0,$00
  DEFB $78,$30,$F0,$00
  DEFB $30,$00,$F0,$00
  DEFB $00,$00,$F0,$00
  DEFB $00,$00,$F0,$00
  DEFB $00,$00,$F0,$00
  DEFB $00,$00,$F0,$00
  DEFB $00,$00,$F0,$00
  DEFB $00,$00,$F0,$00
  DEFB $00,$00,$60,$00

; Спрайт: большой мяч
; Data block at 7A8C
spr_big_ball:
  DEFB $02,$0C
  DEFB $1C,$00,$00,$00
  DEFB $3E,$1C,$00,$00
  DEFB $7F,$26,$00,$00
  DEFB $FF,$4F,$80,$00
  DEFB $FF,$5F,$80,$00
  DEFB $FF,$7F,$F0,$00
  DEFB $7F,$3E,$F8,$00
  DEFB $3F,$1C,$FC,$00
  DEFB $1D,$00,$FC,$00
  DEFB $00,$00,$FC,$00
  DEFB $00,$00,$F8,$00
  DEFB $00,$00,$70,$00

; Спрайт: цифра 400
; Data block at 7ABE
spr_400_points:
  DEFB $03,$0A
  DEFB $30,$00,$7E,$00,$FC,$00
  DEFB $78,$30,$FF,$7E,$FE,$FC
  DEFB $7E,$30,$FF,$7E,$FE,$FC
  DEFB $7F,$36,$FF,$66,$FE,$CC
  DEFB $7F,$36,$FF,$66,$FE,$CC
  DEFB $7F,$3F,$FF,$7E,$FE,$FC
  DEFB $7F,$3F,$FF,$7E,$FE,$FC
  DEFB $3F,$06,$7E,$00,$FC,$00
  DEFB $0F,$06,$00,$00,$00,$00
  DEFB $06,$00,$00,$00,$00,$00

; Спрайт: индикатор жизней
; Data block at 7AFC
spr_lives_indicator:
  DEFB $02,$06
  DEFB $1F,$00,$FE,$00
  DEFB $3F,$0B,$FF,$F4
  DEFB $3F,$1B,$FF,$F6
  DEFB $3F,$1B,$FF,$F6
  DEFB $3F,$0B,$FF,$F4
  DEFB $1F,$00,$FE,$00

; Спрайт: обычный мяч
; Data block at 7B16
spr_ball_normal:
  DEFB $02,$0C
  DEFB $38,$00,$00,$00
  DEFB $7C,$38,$00,$00
  DEFB $FE,$4C,$00,$00
  DEFB $FE,$5C,$00,$00
  DEFB $FE,$7C,$00,$00
  DEFB $7C,$38,$00,$00
  DEFB $38,$00,$00,$00
  DEFB $00,$00,$E0,$00
  DEFB $01,$00,$F0,$00
  DEFB $01,$00,$F0,$00
  DEFB $01,$00,$F0,$00
  DEFB $00,$00,$E0,$00

; Пустой спрайт: резерв для сдвига мяча 1
; Data block at 7B48
spr_ball_normal_shift_1:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00


; Пустой спрайт: резерв для сдвига мяча 2
; Data block at 7B92
spr_ball_normal_shift_2:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига мяча 3
; Data block at 7BDC
spr_ball_normal_shift_3:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига мяча 4
; Data block at 7C26
spr_ball_normal_shift_4:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига мяча 5
; Data block at 7C70
spr_ball_normal_shift_5:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига мяча 6
; Data block at 7CBA
spr_ball_normal_shift_6:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига мяча 7
; Data block at 7D04
spr_ball_normal_shift_7:
  DEFB $00,$00					; Ширина на 1 байт больше не сдвинутого спрайта, то есть $03,$0C
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига нормальной каретки
; Data block at 7D4E
spr_bat_normal_shift:
  DEFB $00,$00			; Ширина на 1 байт больше не сдвинутого спрайта, то есть $05,$0D
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Спрайт: пуля, кадр 1
; Data block at 7DD2
spr_bullet_1:
  DEFB $01,$08
  DEFB $60,$00
  DEFB $F0,$40
  DEFB $F0,$40
  DEFB $F0,$40
  DEFB $60,$00
  DEFB $F0,$A0
  DEFB $F0,$A0
  DEFB $F0,$A0

; Спрайт: пуля, кадр 2
; Data block at 7DE4
spr_bullet_2:
  DEFB $01,$08
  DEFB $60,$00
  DEFB $F0,$40
  DEFB $F0,$40
  DEFB $F0,$40
  DEFB $60,$00
  DEFB $F0,$50
  DEFB $F0,$50
  DEFB $F0,$50

; Спрайт: взрыв пули, кадр 1
; Data block at 7DF6
spr_bullet_blast_1:
  DEFB $01,$06
  DEFB $00,$00
  DEFB $00,$00
  DEFB $18,$00
  DEFB $3C,$18
  DEFB $3C,$18
  DEFB $18,$00

; Спрайт: взрыв пули, кадр 2
; Data block at 7E04
spr_bullet_blast_2:
  DEFB $01,$07
  DEFB $00,$00
  DEFB $18,$00
  DEFB $3C,$18
  DEFB $7E,$24
  DEFB $7E,$24
  DEFB $3C,$18
  DEFB $18,$00

; Спрайт: взрыв пули, кадр 3
; Data block at 7E14
spr_bullet_blast_3:
  DEFB $01,$08
  DEFB $24,$00
  DEFB $7E,$24
  DEFB $E7,$42
  DEFB $E2,$40
  DEFB $47,$02
  DEFB $E7,$42
  DEFB $7E,$24
  DEFB $24,$00

; Спрайт: взрыв пули, кадр 4
; Data block at 7E26
spr_bullet_blast_4:
  DEFB $01,$08
  DEFB $66,$00
  DEFB $C3,$00
  DEFB $89,$00
  DEFB $20,$00
  DEFB $00,$00
  DEFB $89,$00
  DEFB $C3,$00
  DEFB $66,$00

; Спрайт: нормальная каретка
; Data block at 7E38
spr_bat_normal:
  DEFB $04,$0D
  DEFB $3F,$00,$FF,$00,$FF,$00,$C0,$00
  DEFB $7F,$1B,$FF,$7F,$FF,$ED,$E0,$80
  DEFB $FF,$34,$FF,$80,$FF,$12,$F0,$C0
  DEFB $FF,$64,$FF,$80,$FF,$12,$F0,$60
  DEFB $FF,$4B,$FF,$7F,$FF,$ED,$F8,$20
  DEFB $FF,$7B,$FF,$7F,$FF,$ED,$F4,$E0
  DEFB $FF,$7B,$FF,$7F,$FF,$ED,$FA,$E0
  DEFB $FF,$3B,$FF,$7F,$FF,$ED,$F5,$C0
  DEFB $7F,$1B,$FF,$7F,$FF,$ED,$EA,$80
  DEFB $3F,$00,$FF,$00,$FF,$00,$D5,$00
  DEFB $0A,$00,$AA,$00,$AA,$00,$AA,$00
  DEFB $05,$00,$55,$00,$55,$00,$54,$00
  DEFB $02,$00,$AA,$00,$AA,$00,$A8,$00

; Спрайт: правая часть каретки
; Data block at 7EA2
spr_bat_right_part:
  DEFB $03,$0D,$FF,$00,$FF,$00,$C0,$00
  DEFB $7F,$7F,$FF,$ED,$E0,$80,$7F,$00
  DEFB $FF,$12,$F0,$C0,$7F,$00,$FF,$12
  DEFB $F0,$60,$7F,$7F,$FF,$ED,$F8,$20
  DEFB $7F,$7F,$FF,$ED,$F4,$E0,$7F,$7F
  DEFB $FF,$ED,$FA,$E0,$7F,$7F,$FF,$ED
  DEFB $F5,$C0,$7F,$7F,$FF,$ED,$EA,$80
  DEFB $FF,$00,$FF,$00,$D5,$00,$AA,$00
  DEFB $AA,$00,$AA,$00,$55,$00,$55,$00
  DEFB $54,$00,$AA,$00,$AA,$00,$A8,$00

; Спрайт: левая часть каретки
; Data block at 7EF2
spr_bat_left_part:
  DEFB $03,$0D,$3F,$00,$FF,$00,$FF,$00
  DEFB $7F,$1B,$FF,$7F,$FF,$FF,$FF,$34
  DEFB $FF,$80,$FF,$00,$FF,$64,$FF,$80
  DEFB $FF,$00,$FF,$4B,$FF,$7F,$FF,$FF
  DEFB $FF,$7B,$FF,$7F,$FF,$FF,$FF,$7B
  DEFB $FF,$7F,$FF,$FF,$FF,$3B,$FF,$7F
  DEFB $FF,$FF,$7F,$1B,$FF,$7F,$FF,$FF
  DEFB $3F,$00,$FF,$00,$FF,$00,$0A,$00
  DEFB $AA,$00,$AA,$00,$05,$00,$55,$00
  DEFB $55,$00,$02,$00,$AA,$00,$AA,$00

; Спрайт: большая каретка
; Data block at 7F42
spr_bat_big:
  DEFB $06,$0D
  DEFB $3F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$C0,$00
  DEFB $7F,$1B,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$ED,$E0,$80
  DEFB $FF,$34,$FF,$80,$FF,$00,$FF,$00,$FF,$12,$F0,$C0
  DEFB $FF,$64,$FF,$80,$FF,$00,$FF,$00,$FF,$12,$F0,$60
  DEFB $FF,$4B,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$ED,$F8,$20
  DEFB $FF,$7B,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$ED,$F4,$E0
  DEFB $FF,$7B,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$ED,$FA,$E0
  DEFB $FF,$3B,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$ED,$F5,$C0
  DEFB $7F,$1B,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$ED,$EA,$80
  DEFB $3F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$D5,$00
  DEFB $0A,$00,$AA,$00,$AA,$00,$AA,$00,$AA,$00,$AA,$00
  DEFB $05,$00,$55,$00,$55,$00,$55,$00,$55,$00,$54,$00
  DEFB $02,$00,$AA,$00,$AA,$00,$AA,$00,$AA,$00,$A8,$00

; Спрайт: пулемёт, кадр 1
; Data block at 7FE0
spr_bat_gun_1:
  DEFB $04,$0D,$1F,$00,$FF,$00,$FF,$00
  DEFB $80,$00,$3F,$0D,$FF,$FF,$FF,$FB
  DEFB $C0,$00,$7F,$1A,$FF,$00,$FF,$05
  DEFB $E0,$80,$7F,$32,$FF,$00,$FF,$04
  DEFB $F0,$C0,$7F,$25,$FF,$FF,$FF,$FA
  DEFB $E8,$40,$7F,$3D,$FF,$FF,$FF,$FB
  DEFB $F4,$C0,$7F,$3D,$FF,$FF,$FF,$FB
  DEFB $FA,$C0,$7F,$1D,$FF,$FF,$FF,$FB
  DEFB $F4,$80,$3F,$0D,$FF,$FF,$FF,$FB
  DEFB $EA,$00,$1F,$00,$FF,$00,$FF,$00
  DEFB $D4,$00,$02,$00,$AA,$00,$AA,$00
  DEFB $AA,$00,$01,$00,$55,$00,$55,$00
  DEFB $54,$00,$00,$00,$AA,$00,$AA,$00
  DEFB $A8,$00

; Спрайт: пулемёт, кадр 2
; Data block at 804A
spr_bat_gun_2:
  DEFB $04,$0D,$1F,$00,$FF,$00,$FF,$00
  DEFB $80,$00,$3F,$0D,$FF,$FF,$FF,$FB
  DEFB $C0,$00,$7F,$1A,$FF,$00,$FF,$05
  DEFB $E0,$80,$7F,$32,$FF,$0B,$FF,$04
  DEFB $F0,$C0,$7F,$25,$FF,$F0,$FF,$FA
  DEFB $E8,$40,$7F,$3D,$FF,$FF,$FF,$FB
  DEFB $F4,$C0,$7F,$3E,$FF,$FF,$FF,$F7
  DEFB $FA,$C0,$7F,$1E,$FF,$FF,$FF,$F7
  DEFB $F4,$40,$3F,$0E,$FF,$FF,$FF,$F7
  DEFB $EA,$00,$1F,$00,$FF,$00,$FF,$00
  DEFB $D4,$00,$02,$00,$AA,$00,$AA,$00
  DEFB $AA,$00,$01,$00,$55,$00,$55,$00
  DEFB $54,$00,$00,$00,$AA,$00,$AA,$00
  DEFB $A8,$00

; Спрайт: пулемёт, кадр 3
; Data block at 80B4
spr_bat_gun_3:
  DEFB $04,$0D,$3F,$00,$FF,$00,$FF,$00
  DEFB $C0,$00,$7F,$1B,$FF,$F0,$FF,$FD
  DEFB $E0,$80,$FF,$34,$FF,$0B,$FF,$02
  DEFB $F0,$C0,$FF,$64,$FF,$13,$FF,$82
  DEFB $F0,$60,$FF,$4B,$FF,$E0,$FF,$7D
  DEFB $F8,$20,$FF,$7B,$FF,$FF,$FF,$FD
  DEFB $F4,$E0,$FF,$7D,$FF,$FF,$FF,$FB
  DEFB $FA,$E0,$FF,$3D,$FF,$FF,$FF,$FB
  DEFB $F5,$C0,$7F,$1E,$FF,$FF,$FF,$F7
  DEFB $EA,$80,$3F,$00,$FF,$00,$FF,$00
  DEFB $D5,$00,$0A,$00,$AA,$00,$AA,$00
  DEFB $AA,$00,$05,$00,$55,$00,$55,$00
  DEFB $54,$00,$02,$00,$AA,$00,$AA,$00
  DEFB $A8,$00

; Спрайт: пулемёт, кадр 4
; Data block at 811E
spr_bat_gun_4:
  DEFB $04,$0D,$3F,$00,$FF,$00,$FF,$00
  DEFB $C0,$00,$7F,$1B,$FF,$EB,$FF,$7D
  DEFB $E0,$80,$FF,$34,$FF,$13,$FF,$82
  DEFB $F0,$C0,$FF,$64,$FF,$27,$FF,$C2
  DEFB $F0,$60,$FF,$4B,$FF,$C0,$FF,$3D
  DEFB $F8,$20,$FF,$7B,$FF,$FF,$FF,$FD
  DEFB $F4,$E0,$FF,$7D,$FF,$FF,$FF,$FB
  DEFB $FA,$E0,$FF,$3E,$FF,$FF,$FF,$F7
  DEFB $F5,$C0,$7F,$1F,$FF,$7F,$FF,$EF
  DEFB $EA,$80,$3F,$00,$FF,$00,$FF,$00
  DEFB $D5,$00,$0A,$00,$AA,$00,$AA,$00
  DEFB $AA,$00,$05,$00,$55,$00,$55,$00
  DEFB $54,$00,$02,$00,$AA,$00,$AA,$00
  DEFB $A8,$00
   
; Спрайт: пулемёт, кадр 5
; Data block at 8188
spr_bat_gun:
  DEFB $04,$0D
  DEFB $00,$00,$1F,$00,$80,$00,$00,$00
  DEFB $7F,$00,$FF,$0B,$FF,$00,$E0,$00
  DEFB $FF,$3B,$FF,$D3,$FF,$BD,$F0,$C0
  DEFB $FF,$64,$FF,$27,$FF,$C2,$F0,$60
  DEFB $FF,$44,$FF,$0F,$FF,$02,$F8,$20
  DEFB $FF,$7B,$FF,$F0,$FF,$FD,$F4,$E0
  DEFB $FF,$7D,$FF,$FF,$FF,$FB,$FA,$E0
  DEFB $FF,$3E,$FF,$FF,$FF,$F7,$F5,$C0
  DEFB $7F,$0F,$FF,$7F,$FF,$EF,$EA,$00
  DEFB $1F,$00,$FF,$3F,$FF,$C0,$D5,$00
  DEFB $0A,$00,$FF,$00,$EA,$00,$AA,$00
  DEFB $05,$00,$55,$00,$55,$00,$54,$00
  DEFB $02,$00,$AA,$00,$AA,$00,$A8,$00

; Пустой спрайт: резерв для сдвига каретки c пулемётом
; Data block at 81F2
spr_bat_gun_shift:
  DEFB $00,$00				; $05,$0D
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  
  ; Лишние нули? Если их закомментировать, то спрайты не портятся
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Пустой спрайт: резерв для сдвига большой каретки
; Data block at 828A
spr_bat_big_shift:
  DEFB $00,$00		; $07,$0D
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;-------------------------------------
; Спрайт: искра, кадр 1
; Data block at 8342
spr_spark_1:
  DEFB $02,$0B,$10,$00,$00,$00,$38,$10
  DEFB $00,$00,$7C,$10,$00,$00,$FE,$7C
  DEFB $00,$00,$7C,$10,$00,$00,$38,$10
  DEFB $00,$00,$10,$00,$80,$00,$00,$00
  DEFB $80,$00,$03,$00,$E0,$00,$00,$00
  DEFB $80,$00,$00,$00,$80,$00

; Спрайт: искра, кадр 2
; Data block at 8370
spr_spark_2:
  DEFB $01,$0A,$20,$00,$70,$20,$70,$20
  DEFB $F8,$70,$70,$20,$72,$20,$22,$00
  DEFB $07,$00,$02,$00,$02,$00

; Спрайт: искра, кадр 3
; Data block at 8386
spr_spark_3:
  DEFB $01,$08,$20,$00,$70,$20,$F8,$70
  DEFB $70,$20,$20,$00,$02,$00,$07,$00
  DEFB $02,$00

; Спрайт: искра, кадр 4
; Data block at 8398
spr_spark_4:
  DEFB $01,$06,$40,$00,$E0,$40,$E0,$40
  DEFB $40,$00,$08,$00,$08,$00

; Спрайт: искра, кадр 5
; Data block at 83A6
spr_spark_5:
  DEFB $01,$04,$40,$00,$E0,$40,$40,$00
  DEFB $10,$00
;-------------------------------------

;-------------------------------------
; Спрайт: UFO, кадр 1
; Data block at 83B0
spr_ufo_1:
  DEFB $03,$0E,$00,$00,$7E,$00,$00,$00
  DEFB $03,$00,$FF,$5E,$C0,$00,$0F,$03
  DEFB $FF,$9F,$F0,$C0,$3F,$0E,$FF,$3F
  DEFB $FC,$F0,$7F,$38,$FF,$7F,$FE,$FC
  DEFB $FF,$70,$FF,$FF,$FF,$FE,$FF,$61
  DEFB $FF,$FF,$FF,$FE,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$79,$FF,$E7,$FF,$9E
  DEFB $FF,$79,$FF,$E7,$FF,$9E,$FF,$79
  DEFB $FF,$E7,$FF,$9E,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$7F,$FF,$DF,$FF,$FE
  DEFB $7F,$00,$FF,$00,$FE,$00

; Спрайт: UFO, кадр 2
; Data block at 8406
spr_ufo_2:
  DEFB $03,$0F,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$7E,$00,$00,$00,$03,$00
  DEFB $FF,$3E,$C0,$00,$0F,$03,$FF,$3F
  DEFB $F0,$C0,$3F,$0E,$FF,$7F,$FC,$F0
  DEFB $7F,$38,$FF,$7F,$FE,$FC,$FF,$70
  DEFB $FF,$FF,$FF,$FE,$7F,$00,$FF,$00
  DEFB $FE,$00,$7F,$3C,$FF,$F3,$FF,$CE
  DEFB $7F,$3C,$FF,$F3,$FF,$CE,$7F,$3C
  DEFB $FF,$F3,$FF,$CE,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$7E,$FF,$7F,$FF,$FE
  DEFB $7F,$0F,$FF,$3F,$FE,$E0,$07,$00
  DEFB $FF,$00,$E0,$00

; Спрайт: UFO, кадр 3
; Data block at 8462
spr_ufo_3:
  DEFB $03,$10,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $7E,$00,$00,$00,$03,$00,$FF,$3E
  DEFB $C0,$00,$1F,$03,$FF,$3F,$F8,$C0
  DEFB $7F,$1E,$FF,$3F,$FE,$F8,$FF,$78
  DEFB $FF,$7F,$FF,$FE,$7F,$00,$FF,$00
  DEFB $FE,$00,$7F,$1E,$FF,$79,$FF,$E6
  DEFB $7F,$1E,$FF,$79,$FF,$E6,$7F,$1E
  DEFB $FF,$79,$FF,$E6,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$7C,$FF,$FF,$FF,$FE
  DEFB $7F,$1E,$FF,$7F,$FE,$F8,$1F,$01
  DEFB $FF,$7F,$F8,$80,$01,$00,$FF,$00
  DEFB $80,$00

; Спрайт: UFO, кадр 4
; Data block at 84C4
spr_ufo_4:
  DEFB $03,$11,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$01,$00,$FF,$00
  DEFB $80,$00,$1F,$01,$FF,$7F,$F8,$80
  DEFB $7F,$1E,$FF,$7F,$FE,$F8,$FF,$7C
  DEFB $FF,$FF,$FF,$FE,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$4F,$FF,$3C,$FF,$F2
  DEFB $FF,$4F,$FF,$3C,$FF,$F2,$FF,$4F
  DEFB $FF,$3C,$FF,$F2,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$78,$FF,$7F,$FF,$FE
  DEFB $7F,$1E,$FF,$3F,$FE,$F8,$1F,$03
  DEFB $FF,$3F,$F8,$C0,$03,$00,$FF,$3F
  DEFB $C0,$00,$00,$00,$7E,$00,$00,$00

; Спрайт: UFO, кадр 5
; Data block at 852C
spr_ufo_5:
  DEFB $03,$12,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$07,$00,$FF,$00,$E0,$00
  DEFB $7F,$07,$FF,$3F,$FE,$E0,$FF,$7E
  DEFB $FF,$7F,$FF,$FE,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$67,$FF,$9E,$FE,$78
  DEFB $FF,$67,$FF,$9E,$FE,$78,$FF,$67
  DEFB $FF,$9E,$FE,$78,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$70,$FF,$FF,$FF,$FE
  DEFB $7F,$38,$FF,$7F,$FE,$FC,$3F,$0E
  DEFB $FF,$7F,$FC,$F0,$0F,$03,$FF,$3F
  DEFB $F0,$C0,$03,$00,$FF,$3E,$C0,$00
  DEFB $00,$00,$7E,$00,$00,$00

; Спрайт: UFO, кадр 6
; Data block at 859A
spr_ufo_6:
  DEFB $03,$13,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $7F,$00,$FF,$00,$FE,$00,$FF,$7F
  DEFB $FF,$DF,$FF,$FE,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$73,$FF,$CF,$FE,$3C
  DEFB $FF,$73,$FF,$CF,$FE,$3C,$FF,$73
  DEFB $FF,$CF,$FE,$3C,$7F,$00,$FF,$00
  DEFB $FE,$00,$FF,$61,$FF,$FF,$FF,$FE
  DEFB $FF,$70,$FF,$FF,$FF,$FE,$7F,$38
  DEFB $FF,$7F,$FE,$FC,$3F,$0E,$FF,$3F
  DEFB $FC,$F0,$0F,$03,$FF,$9F,$F0,$C0
  DEFB $03,$00,$FF,$5E,$C0,$00,$00,$00
  DEFB $7E,$00,$00,$00
;-------------------------------------

;-------------------------------------
; Спрайт: птицы, кадр 1
; Data block at 860E
spr_bird_1:
  DEFB $03,$0F,$F0,$00,$18,$00,$0E,$00
  DEFB $FE,$70,$3C,$18,$7F,$0E,$7F,$3E
  DEFB $7E,$3C,$FE,$7C,$3F,$1F,$FF,$5A
  DEFB $FC,$F8,$1F,$07,$FF,$66,$F8,$E0
  DEFB $07,$01,$FF,$99,$E1,$80,$29,$00
  DEFB $FF,$5A,$8A,$00,$15,$00,$FF,$99
  DEFB $94,$00,$09,$00,$FF,$91,$A8,$00
  DEFB $03,$01,$95,$00,$D0,$80,$01,$00
  DEFB $2A,$00,$A0,$00,$00,$00,$15,$00
  DEFB $50,$00,$00,$00,$08,$00,$08,$00
  DEFB $00,$00,$10,$00,$10,$00,$00,$00
  DEFB $08,$00,$08,$00

; Спрайт: птицы, кадр 2
; Data block at 866A
spr_bird_2:
  DEFB $03,$0F,$00,$00,$18,$00,$00,$00
  DEFB $00,$00,$3C,$18,$00,$00,$00,$00
  DEFB $7E,$3C,$00,$00,$01,$00,$FF,$5A
  DEFB $80,$00,$1F,$01,$FF,$7E,$F8,$80
  DEFB $3F,$1F,$FF,$A5,$FC,$F8,$7F,$3F
  DEFB $FF,$5A,$FE,$FC,$FF,$60,$FF,$5A
  DEFB $FF,$06,$64,$00,$FF,$4A,$56,$00
  DEFB $0B,$00,$CB,$81,$AA,$00,$14,$00
  DEFB $95,$00,$55,$00,$02,$00,$AA,$00
  DEFB $4A,$00,$01,$00,$11,$00,$20,$00
  DEFB $00,$00,$00,$00,$40,$00,$00,$00
  DEFB $10,$00,$20,$00

; Спрайт: птицы, кадр 3
; Data block at 86C6
spr_bird_3:
  DEFB $03,$0F,$00,$00,$18,$00,$00,$00
  DEFB $00,$00,$3C,$18,$00,$00,$00,$00
  DEFB $7E,$3C,$00,$00,$01,$00,$FF,$5A
  DEFB $80,$00,$07,$01,$FF,$7E,$E0,$80
  DEFB $0F,$07,$FF,$A5,$F0,$E0,$1F,$0F
  DEFB $FF,$18,$F8,$F0,$3F,$1C,$FF,$5A
  DEFB $FC,$38,$3C,$18,$FF,$4A,$BC,$18
  DEFB $79,$30,$CB,$81,$9E,$0C,$34,$00
  DEFB $95,$00,$4C,$00,$0A,$00,$AA,$00
  DEFB $AA,$00,$15,$00,$55,$00,$55,$00
  DEFB $00,$00,$20,$00,$80,$00,$00,$00
  DEFB $20,$00,$80,$00

; Спрайт: птицы, кадр 4
; Data block at 8722
spr_bird_4:
  DEFB $03,$0F,$00,$00,$18,$00,$00,$00
  DEFB $03,$00,$3C,$18,$C0,$00,$07,$03
  DEFB $FF,$3C,$E0,$C0,$0F,$07,$FF,$5A
  DEFB $F0,$E0,$1F,$0E,$FF,$A5,$FA,$70
  DEFB $1E,$0C,$FF,$18,$79,$30,$1E,$0C
  DEFB $FF,$5A,$7A,$30,$3E,$1C,$FF,$52
  DEFB $7D,$38,$3D,$18,$D3,$81,$BE,$18
  DEFB $3A,$10,$95,$00,$5D,$08,$15,$00
  DEFB $2A,$00,$AA,$00,$0A,$00,$45,$00
  DEFB $51,$00,$04,$00,$20,$00,$20,$00
  DEFB $00,$00,$10,$00,$40,$00

; Спрайт: птицы, кадр 5
; Data block at 8778
spr_bird_5:
  DEFB $03,$12,$30,$00,$00,$00,$0C,$00
  DEFB $78,$30,$00,$00,$1E,$0C,$3C,$18
  DEFB $00,$00,$3C,$18,$1E,$0C,$18,$00
  DEFB $78,$30,$1F,$0E,$3C,$18,$F9,$70
  DEFB $2F,$07,$FF,$3C,$F2,$E0,$17,$03
  DEFB $FF,$5A,$E5,$C0,$2F,$03,$FF,$7E
  DEFB $EA,$C0,$13,$01,$FF,$A5,$D4,$80
  DEFB $09,$00,$FF,$5A,$A8,$00,$05,$00
  DEFB $7E,$18,$50,$00,$02,$00,$FF,$52
  DEFB $28,$00,$01,$00,$D3,$81,$D0,$00
  DEFB $01,$00,$D7,$81,$A0,$00,$00,$00
  DEFB $A9,$00,$40,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$20,$00,$40,$00
  DEFB $00,$00,$10,$00,$20,$00
;-------------------------------------

;-------------------------------------
; Спрайт: взрыв врага, кадр 1
; Data block at 87E6
spr_alien_blast_1:
  DEFB $02,$0D,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$02,$00
  DEFB $40,$00,$0C,$00,$E8,$40,$1F,$0C
  DEFB $E0,$C0,$1F,$0F,$F0,$C0,$0F,$07
  DEFB $F8,$70,$17,$02,$FC,$38,$0F,$07
  DEFB $F8,$E0,$1F,$0E,$F0,$C0,$0E,$00
  DEFB $E0,$40,$01,$00,$40,$00

; Спрайт: взрыв врага, кадр 2
; Data block at 881C
spr_alien_blast_2:
  DEFB $02,$0D,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$02,$00,$40,$00,$18,$00
  DEFB $E8,$40,$3F,$18,$E0,$C0,$3F,$1E
  DEFB $FC,$E0,$1F,$0F,$FE,$BC,$0F,$06
  DEFB $FC,$38,$27,$03,$F8,$70,$0F,$07
  DEFB $F4,$E0,$0F,$07,$F8,$70,$1F,$0C
  DEFB $78,$30,$0C,$00,$B0,$00

; Спрайт:
; Спрайт: взрыв врага, кадр 3
spr_alien_blast_3:
  DEFB $02,$0E,$00,$00,$20,$00,$08,$00
  DEFB $70,$20,$00,$00,$F4,$60,$1F,$00
  DEFB $F0,$E0,$3F,$1F,$F2,$E0,$1F,$0F
  DEFB $FC,$30,$0F,$06,$FE,$5C,$17,$02
  DEFB $FC,$38,$0F,$07,$F8,$A0,$5F,$0F
  DEFB $F4,$E0,$1F,$0E,$F8,$70,$3E,$18
  DEFB $7A,$30,$19,$00,$38,$10,$00,$00
  DEFB $10,$00

; Спрайт: взрыв врага, кадр 4
; Data block at 888C
spr_alien_blast_4:
  DEFB $02,$10,$00,$00,$80,$00,$49,$00
  DEFB $D2,$80,$03,$01,$E4,$C0,$7F,$03
  DEFB $E0,$C0,$FF,$7B,$FE,$60,$7F,$3E
  DEFB $FF,$7E,$7F,$38,$FE,$9C,$3F,$15
  DEFB $FC,$38,$BF,$1A,$F8,$70,$1F,$0C
  DEFB $FA,$B0,$5F,$0D,$FC,$B8,$3F,$1F
  DEFB $FC,$F8,$3F,$1E,$FE,$FC,$7E,$3C
  DEFB $FE,$3C,$7D,$30,$3E,$0C,$30,$00
  DEFB $0C,$00

; Спрайт: взрыв врага, кадр 5
; Data block at 88CE
spr_alien_blast_5:
  DEFB $02,$13,$40,$00,$40,$00,$00,$00
  DEFB $E4,$40,$11,$00,$E1,$C0,$43,$01
  DEFB $F4,$E0,$13,$01,$F0,$E0,$7F,$03
  DEFB $F8,$60,$FF,$7F,$FE,$78,$FF,$7E
  DEFB $FF,$7E,$7F,$32,$FE,$8C,$7F,$39
  DEFB $FC,$58,$3F,$1E,$FD,$B8,$9F,$0D
  DEFB $FA,$70,$1F,$0A,$FC,$B8,$3F,$1B
  DEFB $FC,$D8,$7F,$3F,$FE,$7C,$7F,$3E
  DEFB $7F,$3E,$FE,$78,$3F,$0E,$F9,$60
  DEFB $4F,$02,$60,$00,$02,$00
;-------------------------------------

; Спрайт: бонус ракета, кадр 1
; Data block at 891C
spr_bonus_rocket_1:
  DEFB $03,$1B,$0C,$00,$01,$00,$80,$00
  DEFB $1E,$04,$FB,$00,$C0,$80,$3F,$16
  DEFB $FF,$FA,$E0,$C0,$7F,$27,$FF,$74
  DEFB $F0,$E0,$7F,$27,$FF,$04,$F0,$E0
  DEFB $FF,$47,$DF,$88,$F8,$F0,$FF,$4F
  DEFB $FF,$89,$F8,$F0,$FF,$4F,$FF,$A9
  DEFB $F8,$F0,$7F,$30,$FF,$26,$F0,$00
  DEFB $FF,$4F,$FF,$89,$F8,$F0,$FF,$4F
  DEFB $DF,$89,$F8,$F0,$7F,$00,$8F,$00
  DEFB $F0,$00,$1C,$00,$01,$00,$80,$00
  DEFB $3E,$1C,$03,$01,$C0,$80,$7F,$1E
  DEFB $03,$01,$E0,$40,$7F,$36,$07,$02
  DEFB $E0,$80,$7F,$2B,$87,$00,$F0,$20
  DEFB $FF,$53,$87,$02,$E0,$80,$7F,$09
  DEFB $83,$00,$E0,$40,$7F,$22,$83,$01
  DEFB $C0,$00,$7F,$10,$81,$00,$C0,$80
  DEFB $7F,$29,$81,$00,$C0,$00,$3F,$00
  DEFB $81,$00,$C0,$80,$3F,$15,$80,$00
  DEFB $80,$00,$1F,$00,$00,$00,$00,$00
  DEFB $1F,$04,$00,$00,$00,$00,$0E,$00
  DEFB $00,$00,$00,$00

; Спрайт: бонус ракета, кадр 2
; Data block at 89C0
spr_bonus_rocket_2:
  DEFB $03,$1C,$0C,$00,$01,$00,$80,$00
  DEFB $1E,$04,$FB,$00,$C0,$80,$3F,$16
  DEFB $FF,$FA,$E0,$C0,$7F,$27,$FF,$74
  DEFB $F0,$E0,$7F,$27,$FF,$04,$F0,$E0
  DEFB $FF,$47,$DF,$88,$F8,$F0,$FF,$4F
  DEFB $FF,$89,$F8,$F0,$FF,$4F,$FF,$A9
  DEFB $F8,$F0,$7F,$30,$FF,$26,$F0,$00
  DEFB $FF,$4F,$FF,$89,$F8,$F0,$FF,$4F
  DEFB $DF,$89,$F8,$F0,$7F,$00,$8F,$00
  DEFB $F0,$00,$0C,$00,$01,$00,$C0,$00
  DEFB $1E,$0C,$03,$01,$E0,$C0,$3E,$14
  DEFB $07,$02,$F0,$A0,$3F,$0A,$07,$01
  DEFB $F8,$70,$7F,$20,$0F,$06,$F8,$A0
  DEFB $7F,$0A,$0F,$02,$F8,$80,$3E,$10
  DEFB $0F,$04,$F8,$50,$3E,$04,$0F,$01
  DEFB $F0,$00,$1C,$08,$0F,$04,$F0,$40
  DEFB $1C,$00,$0F,$00,$F0,$A0,$1C,$08
  DEFB $07,$01,$E0,$00,$08,$00,$07,$00
  DEFB $E0,$40,$00,$00,$03,$01,$E0,$00
  DEFB $00,$00,$03,$00,$C0,$00,$00,$00
  DEFB $01,$00,$C0,$80,$00,$00,$00,$00
  DEFB $80,$00

; Спрайт: бонус Smash
; Data block at 8A6A
spr_bonus_smash:
  DEFB $03,$0F,$00,$00,$00,$00,$70,$00
  DEFB $38,$00,$20,$00,$F8,$70,$7C,$38
  DEFB $71,$20,$FC,$98,$FF,$4C,$FB,$31
  DEFB $FE,$3C,$FF,$5D,$FF,$F9,$FE,$7C
  DEFB $FF,$7C,$FB,$31,$FE,$FC,$7C,$38
  DEFB $71,$20,$FC,$F8,$38,$00,$20,$00
  DEFB $F8,$70,$7F,$00,$DD,$00,$FC,$00
  DEFB $FF,$77,$FF,$DD,$FE,$D4,$FF,$45
  DEFB $FF,$55,$FE,$14,$FF,$75,$FF,$5D
  DEFB $FE,$DC,$7F,$15,$FF,$54,$FE,$54
  DEFB $FF,$74,$FF,$55,$FE,$D4,$74,$00
  DEFB $55,$00,$D4,$00

; Спрайт: бонус Kill Aliens
; Data block at 8AC6
spr_bonus_kill_aliens:
  DEFB $03,$0F,$0F,$00,$FF,$00,$F0,$00
  DEFB $1F,$0F,$FF,$FF,$F8,$F0,$1F,$0D
  DEFB $FF,$AB,$F8,$70,$3F,$1D,$FF,$6B
  DEFB $FC,$78,$3F,$1C,$FF,$EB,$FC,$78
  DEFB $7F,$3D,$FF,$6B,$FE,$7C,$7F,$3D
  DEFB $FF,$A9,$FE,$3C,$FF,$7F,$FF,$FF
  DEFB $FF,$FE,$FF,$45,$FF,$A2,$FF,$22
  DEFB $FF,$55,$FF,$AE,$FF,$AE,$FF,$45
  DEFB $FF,$A2,$FF,$A2,$FF,$55,$FF,$AE
  DEFB $FF,$BA,$FF,$54,$FF,$A2,$FF,$A2
  DEFB $FF,$7F,$FF,$FF,$FF,$FE,$7F,$00
  DEFB $FF,$00,$FE,$00

; Спрайт: бонус липучка
; Data block at 8B22
spr_bonus_hand:
  DEFB $03,$0C,$00,$00,$00,$00,$60,$00
  DEFB $00,$00,$30,$00,$F0,$60,$00,$00
  DEFB $F9,$30,$F8,$70,$03,$00,$FF,$F1
  DEFB $FC,$B8,$07,$03,$FF,$E6,$FC,$D8
  DEFB $7F,$07,$FF,$83,$FC,$58,$FF,$6F
  DEFB $FF,$FC,$FC,$38,$FF,$0F,$FF,$FF
  DEFB $F8,$F0,$FF,$6F,$FF,$FF,$F0,$E0
  DEFB $FF,$6F,$FF,$FF,$E0,$C0,$FF,$6F
  DEFB $FF,$FE,$C0,$00,$6F,$00,$FE,$00
  DEFB $00,$00

; Спрайт: бонус расширитель каретки
; Data block at 8B6C
spr_bonus_size:
  DEFB $03,$0B,$3F,$00,$FF,$00,$F0,$00
  DEFB $7F,$37,$FF,$FF,$F8,$B0,$FF,$48
  DEFB $FF,$00,$FC,$48,$FF,$48,$FF,$00
  DEFB $FC,$48,$7F,$17,$FF,$FF,$F8,$A0
  DEFB $7F,$30,$FF,$FC,$F8,$30,$FF,$7F
  DEFB $FF,$7B,$FC,$F8,$7F,$30,$FF,$FC
  DEFB $F8,$30,$3F,$17,$FF,$FF,$F0,$A0
  DEFB $1F,$0F,$FF,$FF,$E0,$C0,$0F,$00
  DEFB $FF,$00,$C0,$00

; Спрайт: бонус Slow
; Data block at 8BB0
spr_bonus_slow:
  DEFB $03,$0F,$1C,$00,$00,$00,$00,$00
  DEFB $3E,$1C,$00,$00,$00,$00,$7F,$22
  DEFB $08,$00,$00,$00,$FF,$4F,$9C,$08
  DEFB $00,$00,$FF,$5F,$9C,$08,$80,$00
  DEFB $FF,$5F,$9D,$08,$C0,$80,$7F,$3E
  DEFB $39,$10,$C8,$80,$3E,$1C,$39,$10
  DEFB $DC,$88,$3C,$00,$13,$01,$9C,$08
  DEFB $7F,$3C,$01,$00,$38,$10,$7F,$21
  DEFB $9C,$00,$10,$00,$7F,$3D,$BF,$1C
  DEFB $F0,$00,$3F,$05,$FF,$15,$F8,$50
  DEFB $7F,$3D,$FF,$DD,$F8,$F0,$3F,$00
  DEFB $FF,$00,$F0,$00

; Спрайт: бонус пулемёт
; Data block at 8C0C
spr_bonus_gun:
  DEFB $03,$09,$3F,$00,$FF,$00,$C0,$00
  DEFB $7F,$3E,$FF,$B7,$E0,$C0,$FF,$41
  DEFB $FF,$38,$F0,$20,$FF,$42,$FF,$7C
  DEFB $F0,$20,$7F,$3C,$FF,$03,$E0,$C0
  DEFB $7F,$3F,$FF,$FF,$E0,$C0,$3F,$1F
  DEFB $FF,$FF,$C0,$80,$1F,$0F,$FF,$FF
  DEFB $80,$00,$0F,$00,$FF,$00,$00,$00

; Спрайт: бонус дополнительная жизнь
; Data block at 8C44
spr_bonus_extra_life:
  DEFB $03,$0D,$3F,$00,$FF,$00,$80,$00
  DEFB $7F,$37,$FF,$FD,$C0,$80,$FF,$40
  DEFB $FF,$01,$E0,$C0,$FF,$37,$FF,$FD
  DEFB $E0,$C0,$FF,$77,$FF,$FD,$E0,$C0
  DEFB $7F,$37,$FF,$FD,$C0,$80,$3F,$00
  DEFB $FF,$00,$80,$00,$02,$00,$1C,$08
  DEFB $00,$00,$07,$02,$3E,$18,$00,$00
  DEFB $0F,$07,$9C,$08,$00,$00,$07,$02
  DEFB $1C,$08,$00,$00,$02,$00,$3E,$1C
  DEFB $00,$00,$00,$00,$1C,$00,$00,$00

; Спрайт: бонус 5000 очков
; Data block at 8C94
spr_bonus_5000_points:
  DEFB $03,$0E,$7F,$00,$FF,$00,$FC,$00
  DEFB $FF,$7F,$FF,$FF,$FE,$FC,$FF,$42
  DEFB $FF,$10,$FE,$84,$FF,$5E,$FF,$D6
  DEFB $FE,$B4,$FF,$42,$FF,$D6,$FE,$B4
  DEFB $FF,$7A,$FF,$D6,$FE,$B4,$FF,$42
  DEFB $FF,$10,$FE,$84,$FF,$7F,$FF,$FF
  DEFB $FE,$FC,$7F,$1F,$FF,$FF,$FC,$F0
  DEFB $1F,$07,$FF,$FF,$F0,$C0,$07,$01
  DEFB $FF,$FF,$C0,$00,$01,$00,$FF,$7C
  DEFB $00,$00,$00,$00,$7C,$10,$00,$00
  DEFB $00,$00,$10,$00,$00,$00

; Спрайт: бонус три шара
; Data block at 8CEA
spr_bonus_triple_ball:
  DEFB $03,$0F,$00,$00,$20,$00,$00,$00
  DEFB $00,$00,$70,$20,$00,$00,$1F,$00
  DEFB $FF,$70,$C0,$00,$3F,$1E,$FF,$FB
  DEFB $E0,$C0,$3F,$1C,$FF,$21,$E0,$C0
  DEFB $3F,$1C,$FF,$21,$E0,$C0,$3F,$12
  DEFB $FF,$22,$E0,$40,$1B,$01,$FE,$04
  DEFB $40,$00,$01,$00,$FC,$00,$00,$00
  DEFB $00,$00,$F8,$70,$00,$00,$01,$00
  DEFB $FC,$98,$00,$00,$01,$00,$FC,$B8
  DEFB $00,$00,$01,$00,$FC,$B8,$00,$00
  DEFB $00,$00,$F8,$70,$00,$00,$00,$00
  DEFB $70,$00,$00,$00
