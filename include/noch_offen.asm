;=====================================================
; noch_offen
;=====================================================
noch_offen
                   lda #<noch_offen_text
                   sta $fb
                   lda #>noch_offen_text
                   sta $fc
                   jsr printf
                   jsr weiter
                   rts
                   
noch_offen_text
                   !byte  0, 2, 15, 10, 147
                   !text  "!!! LEIDER !!!"
                   !byte  13
                   !text  "DIE FUNKTION GIBT ES NOCH GAR NICHT"
                   !byte  $00
