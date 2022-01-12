;=====================================================
; noch_nicht_fertig
;=====================================================
noch_nicht_fertig
                   lda #<noch_nicht_fertig_text
                   sta $fb
                   lda #>noch_nicht_fertig_text
                   sta $fc
                   jsr printf
                   jsr weiter
                   rts
                   
noch_nicht_fertig_text
                   !byte  0, 2, 15, 0
                   !text  "DIE FUNKTION IST NOCH NICHT FERTIG"
                   !byte  $00
                   