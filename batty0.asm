;----------------------------------------------------------------------------

	.EXPORT KeyLine0, KeyLine7, JoystickP
	.EXPORT BorderColor
	.EXPORT dzx0, BATTY0_END

;----------------------------------------------------------------------------

	.org	100h

	di
	xra	a
	out	10h			; turn off the quasi-disk
	lxi	sp,0100h
	lxi	h,0C3F3h
	shld	0
	mov	a,h
	lxi	h,RestartInt
	shld	2
	sta	38h
	lxi	h,KEYINT		; interrupt handler address
	shld	38h+1

; Clear memory from C000h to FFFFh
	xra	a
	lxi	b,0C000h	; destination addr
Init_2:
	stax	b
	inr	c
	jnz	Init_2
	inr	b
	jnz	Init_2

	call	SetPaletteGame
	di

RestartInt:
	lxi	sp,100h
	mvi	a, 88h
	out	4			; initialize R-Sound 2
; Joystick init
	mvi	a, 83h			; control byte
	out	4			; initialize the I/O controller
	mvi	a, 9Fh			; bits to check Joystick-P, both P1 and P2
	out	5			; set Joystick-P query bits
	in	6			; read Joystick-P initial value
	sta	KEYINT_J+1		; store as xra instruction parameter

; Start BATTY
	; ei
	jp	BATTY0_END

; Set game palette
SetPaletteGame:
	lxi	h, PaletteGame+15
; Programming the Palette
SetPalette:
	ei
	hlt
	lxi	d, 100Fh
PaletLoop:
	mov	a, e
	out	2
	mov	a, m
	out	0Ch
	out	0Ch
	out	0Ch
	out	0Ch
	out	0Ch
	dcx	h
	out	0Ch
	dcr	e
	out	0Ch
	dcr	d
	out	0Ch
	jnz	PaletLoop
	ret

;----------------------------------------------------------------------------

KEYINT:
	push	psw
	mvi	a, 8Ah
	out	0
; Keyboard scan
	in	1
	ori	00011111b
	sta	KeyLineEx
	mvi	a, 0FEh
	out	3
	in	2
	sta	KeyLine0
;	mvi	a, 0FDh
;	out	3
;	in	2
;	sta	KeyLine1
;	mvi	a, 0DFh
;	out	3
;	in	2
;	sta	KeyLine5
;	mvi	a, 0BFh
;	out	3
;	in	2
;	sta	KeyLine6
	mvi	a, 07Fh
	out	3
	in	2
	sta	KeyLine7
; Joystick scan
	in	6		; read Joystick-P
KEYINT_J:
	xri	0		; XOR with initial value - mutable param!
	cma
	sta	JoystickP	; save to analyze later

; Scrolling, screen mode, border
	mvi	a, 88h
	out	0
	mvi	a, 2
	out	1
	mvi	a, 0ffh
	out	3		; scrolling
	lda	BorderColor
	ani	0Fh
	out	2		; screen mode and border
;
	lda	IntCount
	inr	a
	sta	IntCount
;
	pop	psw
	ei
	ret

IntCount .EQU 0E000h

KeyLineEx:	.db 11111111b
KeyLine0:	.db 11111111b
;KeyLine1:	.db 11111111b
;KeyLine5:	.db 11111111b
;KeyLine6:	.db 11111111b
KeyLine7:	.db 11111111b
JoystickP:	.db 11111111b

BorderColor:	.db 0		; border color number 0..15

;----------------------------------------------------------------------------

ColorNone .equ 00000000b    ; Color for empty bits  - black
ColorGame .equ 11011011b    ; Color for $E000-$FFFF - yellow
ColorText .equ 10111111b    ; Color for $C000-$DFFF - blue
ColorBoth .equ 00000111b    ; Color for both planes - red
; Palette colors, game
PaletteGame:		; Palette
	.db	ColorNone, ColorGame, ColorText, ColorBoth	; 0..3
	.db	ColorNone, ColorGame, ColorText, ColorBoth	; 4..7
	.db	ColorNone, ColorGame, ColorText, ColorBoth	; 8..11
	.db	ColorNone, ColorGame, ColorText, ColorBoth	; 12..15

;----------------------------------------------------------------------------

; ZX0 decompressor code by Ivan Gorodetsky
; https://github.com/ivagorRetrocomp/DeZX/blob/main/ZX0/8080/OLD_V1/dzx0_CLASSIC.asm
; input:	de=compressed data start
;		bc=uncompressed destination start

#ifdef BACKWARD
#define NEXT_HL dcx h
#define NEXT_DE dcx d
#define NEXT_BC dcx b
#else
#define NEXT_HL inx h
#define NEXT_DE inx d
#define NEXT_BC inx b
#endif

dzx0:
#ifdef BACKWARD
		lxi h,1
		push h
		dcr l
#else
		lxi h,0FFFFh
		push h
		inx h
#endif
		mvi a,080h
dzx0_literals:
		call dzx0_elias
		call dzx0_ldir
		jc dzx0_new_offset
		call dzx0_elias
dzx0_copy:
		xchg
		xthl
		push h
		dad b
		xchg
		call dzx0_ldir
		xchg
		pop h
		xthl
		xchg
		jnc dzx0_literals
dzx0_new_offset:
		call dzx0_elias
#ifdef BACKWARD
		inx sp
		inx sp
		dcr h
		rz
		dcr l
		push psw
		mov a,l
#else
		mov h,a
		pop psw
		xra a
		sub l
		rz
		push h
#endif
		rar\ mov h,a
		ldax d
		rar\ mov l,a
		NEXT_DE
#ifdef BACKWARD
		inx h
#endif
		xthl
		mov a,h
		lxi h,1
#ifdef BACKWARD
		cc dzx0_elias_backtrack
#else
		cnc dzx0_elias_backtrack
#endif
		inx h
		jmp dzx0_copy
dzx0_elias:
		inr l
dzx0_elias_loop:
		add a
		jnz dzx0_elias_skip
		ldax d
		NEXT_DE
		ral
dzx0_elias_skip:
#ifdef BACKWARD
		rnc
#else
		rc
#endif
dzx0_elias_backtrack:
		dad h
		add a
		jnc dzx0_elias_loop
		jmp dzx0_elias

dzx0_ldir:
		push psw
dzx0_ldir1:
		ldax d
		stax b
		NEXT_DE
		NEXT_BC
		dcx h
		mov a,h
		ora l
		jnz dzx0_ldir1
		pop psw
		add a
		ret

;----------------------------------------------------------------------------
BATTY0_END

	.end
