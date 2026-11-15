; C64SWEEPERVIEW - the board view for C64Sweeper, at $9A00
; The board is a map at $9800, 32 bytes to a row (row 1-14, column 1-24): the kind of thing each cell
; shows (0 empty, 1-8 numbers, 9 tile, 10 flag, 11 bomb, 12 crater, 13 wrong flag, 14 pressed,
; 15-16 pop, 17 flag when you win). The view is the part of the board on the screen: VW x VH cells from
; column VX+1, row VY+1, small (1 character) or big (2x2 characters), its top left at row TR, column LC.
; Tiles, flags and wrong flags in the last column or row of the view are drawn as their edge kinds
; (18-26), which leave out the line towards the frame.
;   SYS 39424  A = kind, X/Y = cell (row * 32 + column): set the cell and draw it if it is in view
;   SYS 39427  draw the whole view
;   SYS 39430  fill the map: covered tiles on the board (BW x BH), 0 around it
MAP = $9800
        * = $9a00
        jmp draw
        jmp redraw
        jmp fill
vmode   !byte 0                 ; 39433  0 small cells, 1 big cells
vw      !byte 0                 ; 39434  view width and height, in cells
vh      !byte 0                 ; 39435
vx      !byte 0                 ; 39436  first column and row in view, minus 1
vy      !byte 0                 ; 39437
tr      !byte 0                 ; 39438  screen row and column of the view's top left
lc      !byte 0                 ; 39439
bw      !byte 0                 ; 39440  board width and height
bh      !byte 0                 ; 39441
        !byte 110               ; 39442  marks this file as C64Sweeper V6's
kk      !byte 0
vr      !byte 0
vc      !byte 0
tmp     !byte 0

draw    sta kk
        stx $fb
        sty $fc
        stx $fd                 ; the map byte: MAP + cell
        tya
        clc
        adc #>MAP
        sta $fe
        ldy #0
        lda kk
        sta ($fd),y
        lda $fb                 ; row = cell / 32
        lsr
        lsr
        lsr
        lsr
        lsr
        sta tmp
        lda $fc
        asl
        asl
        asl
        ora tmp
        sec
        sbc #1
        bcc out
        sec
        sbc vy
        bcc out
        cmp vh
        bcs out
        sta vr
        lda $fb                 ; column = cell AND 31
        and #31
        sec
        sbc #1
        bcc out
        sec
        sbc vx
        bcc out
        cmp vw
        bcs out
        sta vc
        jmp put
out     rts

; put: draw kind kk at view row vr, column vc
put     ldx kk
        lda #0
        sta tmp
        ldy vw
        dey
        cpy vc
        bne +
        inc tmp                 ; last column
+       ldy vh
        dey
        cpy vr
        bne +
        lda tmp
        ora #2                  ; last row
        sta tmp
+       lda tmp
        beq kind
        cpx #9
        beq e9
        cpx #10
        beq e10
        cpx #13
        bne kind
        lda #23
        bne eadd
e9      lda #17
        bne eadd
e10     lda #20
eadd    clc
        adc tmp
        tax
kind    lda vmode
        bne bigput
        lda tr                  ; small: one character
        clc
        adc vr
        tay
        lda lc
        clc
        adc vc
        clc
        adc rowlo,y
        sta $fd
        lda rowhi,y
        adc #0
        sta $fe
        ldy #0
        lda ch,x
        sta ($fd),y
        lda $fe
        clc
        adc #$d4
        sta $fe
        lda ck,x
        sta ($fd),y
        rts
bigput  lda vr                  ; big: 2x2 characters
        asl
        clc
        adc tr
        tay
        lda vc
        asl
        clc
        adc lc
        clc
        adc rowlo,y
        sta $fd
        lda rowhi,y
        adc #0
        sta $fe
        ldy #0
        lda q0,x
        sta ($fd),y
        iny
        lda q1,x
        sta ($fd),y
        ldy #40
        lda q2,x
        sta ($fd),y
        iny
        lda q3,x
        sta ($fd),y
        lda $fe
        clc
        adc #$d4
        sta $fe
        lda ck,x
        ldy #0
        sta ($fd),y
        iny
        sta ($fd),y
        ldy #40
        sta ($fd),y
        iny
        sta ($fd),y
        rts

; rowptr: $fd/$fe = MAP + A * 32
rowptr  ldx #0
        stx $fe
        ldx #5
-       asl
        rol $fe
        dex
        bne -
        sta $fd
        lda $fe
        clc
        adc #>MAP
        sta $fe
        rts

redraw  lda #0
        sta vr
rloop   lda #0
        sta vc
cloop   lda vr
        clc
        adc vy
        clc
        adc #1
        jsr rowptr
        lda vc
        clc
        adc vx
        clc
        adc #1
        tay
        lda ($fd),y
        sta kk
        jsr put
        inc vc
        lda vc
        cmp vw
        bne cloop
        inc vr
        lda vr
        cmp vh
        bne rloop
        rts

fill    lda #0
        tax
-       sta MAP,x
        sta MAP+256,x
        inx
        bne -
        lda #1
        sta tmp
floop   lda tmp
        jsr rowptr
        ldy bw
        lda #9
-       sta ($fd),y
        dey
        bne -
        inc tmp
        lda bh
        cmp tmp
        bcs floop
        rts

        * = $9c00
ch      !byte 64,65,66,67,68,69,70,71,72,73,74,75,76,77,84,85,86,87,90,91,92,93,94,95,96,97,98
        * = $9c20
ck      !byte 6,1,7,2,5,4,3,6,1,14,10,15,10,10,14,15,10,13,14,14,14,10,10,10,10,10,10           ; 39968: the colour of each kind (the win's colour wave changes kind 17)
        * = $9c40
q0      !byte 224,228,164,168,172,176,180,184,188,192,200,204,208,212,196,216,220,232,192,192,192,200,200,200,212,212,212
        * = $9c60
q1      !byte 225,229,165,169,173,177,181,185,189,193,201,205,209,213,197,217,221,233,236,193,236,241,201,241,246,213,246
        * = $9c80
q2      !byte 226,230,166,170,174,178,182,186,190,194,202,206,210,214,198,218,222,234,194,238,238,202,243,243,214,248,248
        * = $9ca0
q3      !byte 227,231,167,171,175,179,183,187,191,195,203,207,211,215,199,219,223,235,237,239,240,242,244,245,247,249,250
        * = $9cc0
rowlo   !byte 0,40,80,120,160,200,240,24,64,104,144,184,224,8,48,88,128,168,208,248,32,72,112,152,192
        * = $9ce0
rowhi   !byte 4,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6,6,7,7,7,7,7
