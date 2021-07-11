.psx
.open "exe\SLPS_034.54",0x8000F800

;80016730 : ADDIU   8010000c (a1), 00000000 (r0), 0004 (4)
;.org 0x80016730
;    addiu a1, r0, 0x0

;80016784 : SH      00000008 (v0), 000c (800730b4 (s0)) [800730c0]
;.org 0x80016784
;    nop

;.org 0x80016740
    ;addiu v1, r0, 0x7070p

; Raises the uv mapping height of the Latin characters by one (default 0x00A0)
.org 0x8001BCAC
    addiu a2, v1, 0x00A1

; Reduces the letter height for the draw commands by 1 (default 0x0010)
.org 0x8001BD24
    addiu v0, r0, 0x000F

; Dumb things
;8002fe54 : LUI     00ffffff (t0), 8000 (32768),
;.org 0x8002fe54
    ;lui t0, 0x8000

;8001bf84 : NOP
;Forcing a0 = 0 here makes the Latin text be half transparent
;.org 0x8001bf84
;    addiu a0, r0, 0x0000
    ;nop

;80016b8c : NOP
; Forcing a0 = 0 draws only the 1st chunk of the background. Does not affect text
;.org 0x80016b8c
    ;addiu a0, r0, 0x0000
;    nop