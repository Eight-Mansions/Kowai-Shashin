.psx
.open "exe\SLPS_034.54",0x8000F800

seed: equ 0x801FFF80
random_return: equ 0x80028568

; Raises the uv mapping height of the Latin characters by one (default 0x00A0)
.org 0x8001BCAC
    addiu a2, v1, 0x00A1

; Reduces the letter height for the draw commands by 1 (default 0x0010)
.org 0x8001BD24
    addiu v0, r0, 0x000F

; Don't wipe out extra routines!
.org 0x8003b6a0
    nop

;.org 0x80028560
;    j randomize_inputs
;    nop

; 80028550 : LW      8002a4f0 (a3), 0008 (80011c44 (v1)) [80011c4c]
; 80028560 : SW      00030003 (a3), 0008 (800ffab4 (a0)) [800ffabc]

;.org 0x8003F610
.org 0x800A1490
randomize_inputs:

    ;TODO This should only write to the registers in the previous
    ;command, which is saving a3 and t0(?) to the address offset
    ;from a0

    la t1, seed ; Load our random seed value address
    lw v1, 0x00(t1) ; Load a word from that seed
    nop
    andi a1, v1, 0x00000003 ; Take only the last 2 bits to get 1-4

    srl v1, v1, 02 ; Shift to remove those 2 bits
    andi a2, v1, 0x00000003
    
    lw v1, 0x20(t1) ; Load a different random seed value 0x20 away
    nop
    andi a3, v1, 0x00000003
    
    srl v1, v1, 02
    andi t0, v1, 0x00000003

    sw a1, 0x08(a0) ; Save our random values to the address in a0
    sw a2, 0x0A(a0)
    sw a3, 0x0C(a0)
    j random_return
    sw t0, 0x10(a0)