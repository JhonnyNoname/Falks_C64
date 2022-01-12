;=====================================================
; ALLGRESET
; - stellt die geretteten "original" Farben wieder her
;=====================================================
allgreset
                   lda oldpencol
                   sta PENCOL
                   lda oldpenhgcol
                   sta PENHGCOL
                   lda oldbscol
                   sta BSCOL
                   lda oldframecol
                   sta FRAMECOL
                   rts
