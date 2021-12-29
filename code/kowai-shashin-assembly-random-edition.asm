.psx
.open "exe\SLPS_034.54",0x8000F800

text_spacing: equ 0x01
random_seed: equ 0x800FFE64
first_button: equ 0x800FFABC
last_button: equ 0x800FFACC
button_mask: equ 0x00030003

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
;.org 0x80027418
;    nop
;.org 0x8002637C
;    nop
;.org 0x80026460
;    nop

; Randomize the button input
.org 0x80028548
    jal randomize_button
    nop
    nop
    nop

; Randomzie button input round 2
.org 0x80028600
    jal randomize_button
    nop
    nop
    nop

; Randomize button input round 3
.org 0x800286b8
    jal randomize_button
    nop
    nop
    nop

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

randomize_button:
    ; The code loops 16 bytes at a time, loading values until completion
    ; It keeps track of the current row in v1, comparing it to the end goal in v0:
    ; 80028568 : ADDIU   80011c44 (v1), 80011c44 (v1), 0010 (16),
    ; 8002856c : BNE     80011c54 (v1), 80011cc4 (v0), 80028548,
    ; 80028570 : ADDIU   800ffab4 (a0), 800ffab4 (a0), 0010 (16),

    ; We need to load the first 2 words as normal, randomize the next 9 words,
    ; then load the rest as expected

    ; Save some values to free up registers
    sw ra, 0xFFD8(sp) ; Important since we jump return to another function
    sw t3, 0xFFFC(sp)
    sw t4, 0xFFF8(sp)
    sw t5, 0xFFF4(sp)
    sw t6, 0xFFF0(sp)
    sw t7, 0xFFEC(sp)
    sw t8, 0xFFE8(sp)
    sw t2, 0xFFE4(sp)
    sw t1, 0xFFE0(sp)
    sw t9, 0xFFDC(sp)

    ; Load up useful addresses
    la t3, first_button
    la t4, last_button
    la t8, random_seed
    la t2, button_mask

    lb t9, 0x00(t8) ; Load the first byte from our random seed
    lb t1, 0x80(t8) ; Load another byte from a different seed

    addiu t5, a0, 0x0 ; Load the destination address for tracking

    subu t6, t3, t5 ; Subtract the current address from the first button
    bgtz t6, load_one ; Branch if we're before the first button
    subu t6, t5, t4 ; Subtract the last button from the current address
    bgtz t6, load_one ; Branch if we're after the last button
    nop
    jal get_random_number ; Otherwise grab a random number
    nop
    addiu a1, t7, 0x0 ; Save our random number to the correct register
    j load_one_finish
    nop

load_one:
    lw a1, 0x0(v1) ; Standard, non-random load

load_one_finish:
    addiu t5, t5, 0x04 ; Increment the current address

    subu t6, t3, t5 ; Subtract the current address from the first button
    bgtz t6, load_two ; Branch if we're before the first button
    subu t6, t5, t4 ; Subtract the last button from the current address
    bgtz t6, load_two ; Branch if we're after the last button
    nop
    jal get_random_number ; Otherwise grab a random number
    nop
    addiu a2, t7, 0x0 ; Save our random number to the correct register
    j load_two_finish
    nop

load_two:
    lw a2, 0x4(v1) ; Standard, non-random load

load_two_finish:
    addiu t5, t5, 0x04 ; Increment the current address

    subu t6, t3, t5 ; Subtract the current address from the first button
    bgtz t6, load_three ; Branch if we're before the first button
    subu t6, t5, t4 ; Subtract the last button from the current address
    bgtz t6, load_three ; Branch if we're after the last button
    nop
    jal get_random_number ; Otherwise grab a random number
    nop
    addiu a3, t7, 0x0 ; Save our random number to the correct register
    j load_three_finish
    nop

load_three:
    lw a3, 0x8(v1) ; Standard, non-random load

load_three_finish:
    addiu t5, t5, 0x04 ; Increment the current address

    subu t6, t3, t5 ; Subtract the current address from the first button
    bgtz t6, load_four ; Branch if we're before the first button
    subu t6, t5, t4 ; Subtract the last button from the current address
    bgtz t6, load_four ; Branch if we're after the last button
    nop
    jal get_random_number ; Otherwise grab a random number
    nop
    addiu t0, t7, 0x0 ; Save our random number to the correct register
    j load_four_finish
    nop

load_four:
    lw t0, 0xc(v1) ; Standard, non-random load

load_four_finish:
    ; Load the saved registers back again
    lw ra, 0xFFD8(sp)
    lw t3, 0xFFFC(sp)
    lw t4, 0xFFF8(sp)
    lw t5, 0xFFF4(sp)
    lw t6, 0xFFF0(sp)
    lw t7, 0xFFEC(sp)
    lw t8, 0xFFE8(sp)
    lw t2, 0xFFE4(sp)
    lw t1, 0xFFE0(sp)
    lw t9, 0xFFDC(sp)

    jr ra
    nop

get_random_number:
    ; Generates two random numbers and load them into t7
    ; t8 contains our random seed address
    sll t7, t9, 0x10 ; Load the first random byte and store in the upper half
    nop
    or t7, t7, t1 ; Add the second random byte to the lower half
    and t7, t7, t2 ; Mask them down to two values between 0 and 3 each

    srl t9, t9, 0x2 ; Shift our random bytes for new values
    srl t1, t1, 0x2

    jr ra
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