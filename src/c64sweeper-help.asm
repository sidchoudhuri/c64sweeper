; C64SWEEPERHELP - the instructions screen and the copy routine
; Screen at $2C00, colours at $3000. The routine at $3400 copies 4 pages:
; POKE 780,from page:POKE 782,to page:SYS 13312
; $3420: 110 marks this file as C64Sweeper V6's. $3440: the blast sprite, 6 multicolour
; frames (sprite blocks 209-214). $35C0: the arrows around the zoomed-in view of the Large
; board (sprite blocks 215-218: up, down, left, right).
        * = $2c00
        !binary "c64sweeper-help-screen.bin"
        * = $3000
        !binary "c64sweeper-help-colours.bin"
        * = $3400
        sta $fc
        sty $fe
        ldy #0
        sty $fb
        sty $fd
        ldx #4
-       lda ($fb),y
        sta ($fd),y
        iny
        bne -
        inc $fc
        inc $fe
        dex
        bne -
        rts
        * = $3420
        !byte 110
        * = $3440
        !binary "c64sweeper-blast-sprites.bin"
        * = $35c0
        !byte $10,0,0,$38,0,0,$7c,0,0,$fe,0,0
        !fill 52,0
        !byte $fe,0,0,$7c,0,0,$38,0,0,$10,0,0
        !fill 52,0
        !byte $10,0,0,$30,0,0,$70,0,0,$f0,0,0,$70,0,0,$30,0,0,$10,0,0
        !fill 43,0
        !byte $80,0,0,$c0,0,0,$e0,0,0,$f0,0,0,$e0,0,0,$c0,0,0,$80,0,0
        !fill 43,0
