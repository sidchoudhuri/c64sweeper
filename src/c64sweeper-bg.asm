; C64SWEEPERBG - the C64Sweeper menu background and its helper - SYS 51200
; Screen at $C000, colours at $C400: a covered minefield over the whole screen
; with a framed panel in the middle for the menu. The helper at $C800 copies
; both to the screen. It starts with LDY (160) so the loader can tell this
; file from the other games' backgrounds.
        * = $c000
        !binary "c64sweeper-bg-screen.bin"
        * = $c400
        !binary "c64sweeper-bg-colours.bin"
        * = $c800
        ldy #0
-       lda $c000,y
        sta $0400,y
        lda $c100,y
        sta $0500,y
        lda $c200,y
        sta $0600,y
        lda $c2e8,y
        sta $06e8,y
        lda $c400,y
        sta $d800,y
        lda $c500,y
        sta $d900,y
        lda $c600,y
        sta $da00,y
        lda $c6e8,y
        sta $dae8,y
        iny
        bne -
        rts
