;=====================================================
; ALLGINIT
; - rettet die "original" Farben
;=====================================================
allginit
                   lda PENCOL
                   sta oldpencol
                   lda PENHGCOL
                   sta oldpenhgcol
                   lda BSCOL
                   sta oldbscol
                   lda FRAMECOL
                   sta oldframecol                   
                   rts
