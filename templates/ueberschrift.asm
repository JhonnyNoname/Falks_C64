wf=38
;=====================================================
; Ueberschrift
;=====================================================
ueber
        lda #<uebtext
        sta $fb
        lda #>uebtext
        sta $fc
        jsr printf
        rts

uebtext
        !byte 0, 2, 1, 1    ;--- header ---
        !byte 142, 147      ;--- grossBS / loeschen ---
        !byte 117           ;--- Ecke li-ob ---
        !bytes 99*wf        ;--- Strich ---
        !byte 105, 98
        !text "  text text text text text text text  "
        !byte 98, 106
        !bytes 99*wf        ;--- Strich ---
        !byte 107, 0
