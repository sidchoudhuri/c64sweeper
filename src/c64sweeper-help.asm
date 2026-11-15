; C64SWEEPERHELP - the instructions screen and the copy routine
; Screen at $2C00, colours at $3000. The routine at $3400 copies 4 pages:
; POKE 780,from page:POKE 782,to page:SYS 13312
; $3420: 109 marks this file as C64Sweeper V5's. $3440: the blast sprite, 6 multicolour
; frames (sprite blocks 209-214).
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
        !byte 109
        * = $3440
        !binary "c64sweeper-blast-sprites.bin"
