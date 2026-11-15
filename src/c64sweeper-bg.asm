; C64SWEEPERBG - the C64Sweeper menu background and its helper - SYS 51200
; Screen at $C000, colours at $C400 (all 8: multicolour tiles): a covered minefield over the whole screen
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

; $C83F: 109 marks this file as C64Sweeper V5's.
; $C840: board style, POKE 780,style:SYS 51264 copies the 51 characters that differ between
; the styles into the character set at $3800 (0 Classic, 1 Blue, 2 Outline, 3 Dashed).
; The second shared colour ($D023) is set from BASIC: light grey for Classic, blue for the rest.
        * = $c83f
        !byte 109
        tax
        lda setlo,x
        sta $fb
        lda sethi,x
        sta $fc
        ldx #0
nextch  lda codes,x             ; character code * 8 + $3800
        sta $fd
        lda #0
        sta $fe
        asl $fd
        rol $fe
        asl $fd
        rol $fe
        asl $fd
        rol $fe
        clc
        lda $fe
        adc #$38
        sta $fe
        ldy #7
copy8   lda ($fb),y
        sta ($fd),y
        dey
        bpl copy8
        clc
        lda $fb
        adc #8
        sta $fb
        bcc +
        inc $fc
+       inx
        cpx #51
        bne nextch
        rts
setlo   !byte <set0,<set1,<set2,<set3
sethi   !byte >set0,>set1,>set2,>set3
codes   !byte 64,227,73,74,77,84,192,193,194,195,196,197,198,199,200,201,202,203,212,213,214,215,80,82,83,88,89,90,91,92,93,94,95,96,97,98,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250
set0    !binary "c64sweeper-style-classic.bin"
set1    !binary "c64sweeper-style-blue.bin"
set2    !binary "c64sweeper-style-outline.bin"
set3    !binary "c64sweeper-style-dashed.bin"
