;----------------------------------------------------------------------------

	EXPORT KeyLine0
	EXPORT KeyLine2
	EXPORT KeyLine4
	EXPORT KeyLine7
	EXPORT JoystickP
	EXPORT BorderColor
	;EXPORT LDIR8080
	EXPORT LDIR8080B
	;EXPORT LDDR8080
	EXPORT LDDR8080B
	EXPORT SBCHLDE8080
	EXPORT BATTY0_END

;----------------------------------------------------------------------------

	OUTPUT "batty0.bin"
	ORG	100h

	di
	xor a
	out (10h),a		; turn off the quasi-disk
	ld sp,0100h
	ld hl,0C3F3h
	ld (0),hl
	ld a,h
	ld hl,RestartInt
	ld (2),hl
	ld (38h),a
	ld hl,KEYINT		; interrupt handler address
	ld (38h+1),hl

; Clear memory from C000h to FFFFh
	xor a
	ld bc,0C000h	; destination addr
Init_2:
	ld (bc),a
	inc c
	jp nz,Init_2
	inc b
	jp nz,Init_2

	call SetPaletteGame
	di

RestartInt:
	ld sp,100h
	ld a,88h
	out (4),a		; initialize R-Sound 2
; Joystick init
	ld a,83h		; control byte
	out (4),a		; initialize the I/O controller
	ld a,9Fh		; bits to check Joystick-P, both P1 and P2
	out (5),a		; set Joystick-P query bits
	in a,(6)		; read Joystick-P initial value
	ld (KEYINT_J+1),a	; store as xra instruction parameter

; Start BATTY
	; ei
	jp	BATTY0_END

; Set game palette
SetPaletteGame:
	ld hl,PaletteGame+15
; Programming the Palette
SetPalette:
	ei
	halt
	ld de,100Fh
PaletLoop:
	ld a,e
	out (2),a
	ld a,(hl)
	out (0Ch),a
	out (0Ch),a
	out (0Ch),a
	out (0Ch),a
	out (0Ch),a
	dec hl
	out (0Ch),a
	dec e
	out (0Ch),a
	dec d
	out (0Ch),a
	jp nz,PaletLoop
	ret

;----------------------------------------------------------------------------

KEYINT:
	push af
	ld a,8Ah
	out (0),A
; Keyboard scan
	in a,(1)
	or 00011111b
	ld (KeyLineEx),a
	ld a,0FEh
	out (3),a
	in a,(2)
	ld (KeyLine0),a
	ld a,0FBh
	out (3),a
	in a,(2)
	ld (KeyLine2),a
	ld a,0EFh
	out (3),a
	in a,(2)
	ld (KeyLine4),a
	ld a,07Fh
	out (3),a
	in a,(2)
	ld (KeyLine7),A
; Joystick scan
	in A,(6)		; read Joystick-P
KEYINT_J:
	xor 0			; XOR with initial value - mutable param!
	cpl
	ld (JoystickP),A	; save to analyze later

; Scrolling, screen mode, border
	ld A,88h
	out (0),A
	ld A,2
	out (1),A
	ld A,0FFh
	out (3),A		; scrolling
	ld A,(BorderColor)
	and 0Fh
	out (2),A		; screen mode and border
;
	ld A,(IntCount)
	inc a
	ld (IntCount),A
;
	pop af
	ei
	ret

IntCount .EQU 0E000h

KeyLineEx:	db 11111111b
KeyLine0:	db 11111111b
KeyLine2:	db 11111111b	;   7   6   5   4   3   2   1   0
KeyLine4:	db 11111111b	;   G   F   E   D   C   B   A   @
KeyLine7:	db 11111111b	;  SPC  ^   ]   \   [   Z   Y   X
JoystickP:	db 11111111b

BorderColor:	db 0		; border color number 0..15

;----------------------------------------------------------------------------

ColorNone equ 00000000b    ; Color for empty bits  - black
ColorGame equ 11011011b    ; Color for $E000-$FFFF - yellow
ColorText equ 10111111b    ; Color for $C000-$DFFF - blue
ColorBoth equ 00000111b    ; Color for both planes - red
; Palette colors, game
PaletteGame:		; Palette
	db	ColorNone, ColorGame, ColorText, ColorBoth	; 0..3
	db	ColorNone, ColorGame, ColorText, ColorBoth	; 4..7
	db	ColorNone, ColorGame, ColorText, ColorBoth	; 8..11
	db	ColorNone, ColorGame, ColorText, ColorBoth	; 12..15

;----------------------------------------------------------------------------

; LDIR command replacement
;LDIR8080:
;	push af
;LDIR8080_1:
;	ld a,(HL)
;	ld (de),a
;	inc hl
;	inc de
;	dec bc
;	ld a,b
;	or c
;	jp nz,LDIR8080_1
;	pop af
;	ret

; LDIR command replacement (счётчик - полный BC, как и ожидают все вызывающие)
LDIR8080B:
.loop:	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	dec bc
	ld a,b
	or c
	jp nz,.loop
	ret

; LDDR command replacement
;LDDR8080:
;	push af
;LDDR8080_1:
;	ld a,(HL)
;	ld (de),a
;	dec hl
;	dec de
;	dec bc
;	ld a,b
;	or c
;	jp NZ,LDDR8080_1
;	pop af
;	ret

; LDDR command replacement, but for B as counter (BC in full LDDR)
LDDR8080B:
.loop:	ld a,(hl)
	ld (de),a
	dec hl
	dec de
	dec b
	jp nz,.loop
	ret

; SBC HL,DE
SBCHLDE8080:
	ld (SBCHLDE8080_TMP),A
	ld a,l
	sbc A,e
	ld l,a
	ld a,h
	sbc A,d
	ld h,a
	jp C,$+7
	or l
	jp $+5
	or l
	scf
	ld A,(SBCHLDE8080_TMP)
	ret
SBCHLDE8080_TMP:
	.DB	0

;----------------------------------------------------------------------------

; ZX0 decompressor code by Ivan Gorodetsky
; https://github.com/ivagorRetrocomp/DeZX/blob/main/ZX0/8080/OLD_V1/dzx0_CLASSIC.asm
; input:	de=compressed data start
;		bc=uncompressed destination start

; #ifdef BACKWARD
; #define NEXT_HL dcx h
; #define NEXT_DE dcx d
; #define NEXT_BC dcx b
; #else
; #define NEXT_HL inx h
; #define NEXT_DE inx d
; #define NEXT_BC inx b
; #endif

; dzx0:
; #ifdef BACKWARD
; 		lxi h,1
; 		push h
; 		dcr l
; #else
; 		lxi h,0FFFFh
; 		push h
; 		inx h
; #endif
; 		mvi a,080h
; dzx0_literals:
; 		call dzx0_elias
; 		call dzx0_ldir
; 		jc dzx0_new_offset
; 		call dzx0_elias
; dzx0_copy:
; 		xchg
; 		xthl
; 		push h
; 		dad b
; 		xchg
; 		call dzx0_ldir
; 		xchg
; 		pop h
; 		xthl
; 		xchg
; 		jnc dzx0_literals
; dzx0_new_offset:
; 		call dzx0_elias
; #ifdef BACKWARD
; 		inx sp
; 		inx sp
; 		dcr h
; 		rz
; 		dcr l
; 		push psw
; 		mov a,l
; #else
; 		mov h,a
; 		pop psw
; 		xra a
; 		sub l
; 		rz
; 		push h
; #endif
; 		rar\ mov h,a
; 		ldax d
; 		rar\ mov l,a
; 		NEXT_DE
; #ifdef BACKWARD
; 		inx h
; #endif
; 		xthl
; 		mov a,h
; 		lxi h,1
; #ifdef BACKWARD
; 		cc dzx0_elias_backtrack
; #else
; 		cnc dzx0_elias_backtrack
; #endif
; 		inx h
; 		jmp dzx0_copy
; dzx0_elias:
; 		inr l
; dzx0_elias_loop:
; 		add a
; 		jnz dzx0_elias_skip
; 		ldax d
; 		NEXT_DE
; 		ral
; dzx0_elias_skip:
; #ifdef BACKWARD
; 		rnc
; #else
; 		rc
; #endif
; dzx0_elias_backtrack:
; 		dad h
; 		add a
; 		jnc dzx0_elias_loop
; 		jmp dzx0_elias

; dzx0_ldir:
; 		push psw
; dzx0_ldir1:
; 		ldax d
; 		stax b
; 		NEXT_DE
; 		NEXT_BC
; 		dcx h
; 		mov a,h
; 		ora l
; 		jnz dzx0_ldir1
; 		pop psw
; 		add a
; 		ret

;----------------------------------------------------------------------------

BATTY0_END
	OUTEND
	END
