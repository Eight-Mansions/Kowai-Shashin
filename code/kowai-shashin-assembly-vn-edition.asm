.psx
.open "exe\SLPS_034.54",0x8000F800

text_spacing: equ 0x01
freeze_input: equ 0x00010001
freeze_button_value: equ 0x00020002

; Don't wipe out extra routines!
.org 0x8003b6a0
    nop

; Change Latin text backgrounds to correct shadow versions
.org 0x8002FF40
    addiu v0, r0, 0x10

; Offset the text back by a pixel left to create the dropshadow
.org 0x8002FED0
    addiu a1, r0, 0x1F

; Offset the text shadow down by a pixel to create the dropshadow
.org 0x8002FF2C
    addi a2, s2, 0x0001

; Increase the maximum size of the line. The smaller the number, the longer the line
;8001be94 : ADDIU   00000049 (v0), 00000027 (s4), 0010 (16)
.org 0x8001be94
    addiu v0, s4, 0xFFFA

; Don't lower health
;8002637c : SUBU    00001be4 (v1), 00001be4 (v1), 00000000 (a0),
;80027418 : SUBU    00001dd8 (v1), 00001dd8 (v1), 000001f4 (a1),
;80026460 : ADDIU   000020d0 (v0), 000020d0 (v0), fce0 (64736),
.org 0x80027418
    nop
.org 0x8002637C
    nop
.org 0x80026460
    nop

; Change monster attack direction
;80027590 : SH      00000001 (a2), 006a (800ffa30 (a0)) [800ffa9a]
.org 0x80027590
    j freeze_direction

; Hard set only 1 button
;80028548 : LW      00000000 (a1), 0000 (80011c44 (v1)) [80011c44]
;80028558 : SW      00040001 (a1), 0000 (800ffab4 (a0)) [800ffab4]
.org 0x80028548 ; Round 1
    jal freeze_inputs

.org 0x80028600 ; Round 2
    jal freeze_inputs

.org 0x800286b8 ; Round 2
    jal freeze_inputs

; Exorcism is always X
;80028550 : LW      8002a4f0 (a3), 0008 (80011c44 (v1)) [80011c4c]
.org 0x80028550 ; Round 1
    jal freeze_button

.org 0x80028608 ; Round 2
    jal freeze_button

.org 0x800286C0 ; Round 3
    jal freeze_button

.org 0x8001bdec
    jal calculate_width

.org 0x800A1494
calculate_width:
    ; 8001bdec : ADDIU   00000027 (s4), 00000027 (s4), 0008 (8),
    ; We need the above command to return the width instead of 8
    ; s0 contains the letter we need a width for
    la t1, letter_widths ; Load the width table
    addu t1, t1, s0 ; Calculate offset with our letter
    lbu t1, 0(t1) ; Load the letter's width
    nop
    addiu t1, t1, text_spacing
    j 0x8001bdf4
    addu s4, s4, t1 ; Add the width to the current width


freeze_inputs:
    la a1, freeze_input
    jr ra
    addiu a1, a1, 0x0001

freeze_button:
    la a3, freeze_button_value
    jr ra
    nop

freeze_direction:
    addiu a2, r0, 0x2
    sh a2, 0x6a(a0)
    j 0x80027598
    nop


letter_widths:
    .db 0x04 ; space, unused
    .db 0x03 ; !
    .db 0x07 ; "
    .db 0x08 ; #
    .db 0x07 ; $
    .db 0x08 ; %
    .db 0x08 ; &
    .db 0x04 ; '
    .db 0x05 ; (
    .db 0x05 ; )
    .db 0x07 ; *
    .db 0x07 ; +
    .db 0x04 ; ,
    .db 0x06 ; -
    .db 0x04 ; .
    .db 0x08 ; /
    .db 0x07 ; 0
    .db 0x05 ; 1
    .db 0x07 ; 2
    .db 0x07 ; 3
    .db 0x08 ; 4
    .db 0x07 ; 5
    .db 0x07 ; 6
    .db 0x08 ; 7
    .db 0x07 ; 8
    .db 0x07 ; 9
    .db 0x04 ; :
    .db 0x04 ; ;
    .db 0x07 ; <
    .db 0x08 ; =
    .db 0x07 ; >
    .db 0x07 ; ?
    .db 0x08 ; @
    .db 0x07 ; A
    .db 0x08 ; B
    .db 0x08 ; C
    .db 0x08 ; D
    .db 0x08 ; E
    .db 0x08 ; F
    .db 0x08 ; G
    .db 0x07 ; H
    .db 0x05 ; I
    .db 0x08 ; J
    .db 0x08 ; K
    .db 0x08 ; L
    .db 0x08 ; M
    .db 0x08 ; N
    .db 0x08 ; O
    .db 0x08 ; P
    .db 0x08 ; Q
    .db 0x08 ; R
    .db 0x08 ; S
    .db 0x07 ; T
    .db 0x07 ; U
    .db 0x07 ; V
    .db 0x07 ; W
    .db 0x07 ; X
    .db 0x07 ; Y
    .db 0x07 ; Z
    .db 0x05 ; [
    .db 0x07 ; ￥
    .db 0x05 ; ]
    .db 0x07 ; ^
    .db 0x08 ; _
    .db 0x05 ; `
    .db 0x07 ; a
    .db 0x08 ; b
    .db 0x07 ; c
    .db 0x08 ; d
    .db 0x07 ; e
    .db 0x07 ; f
    .db 0x08 ; g
    .db 0x08 ; h
    .db 0x05 ; i
    .db 0x06 ; j
    .db 0x08 ; k
    .db 0x05 ; l
    .db 0x08 ; m
    .db 0x08 ; n
    .db 0x07 ; o
    .db 0x08 ; p
    .db 0x08 ; q
    .db 0x07 ; r
    .db 0x08 ; s
    .db 0x08 ; t
    .db 0x08 ; u
    .db 0x07 ; v
    .db 0x07 ; w
    .db 0x07 ; x
    .db 0x08 ; y
    .db 0x07 ; z
    .db 0x05 ; {
    .db 0x03 ; |
    .db 0x05 ; }
    .db 0x08 ; ~
    .db 0x06 ; space

.close