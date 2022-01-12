;---------------------------------------
; weiter:  gibt den "cr/space"-string
;          aus und wartet auf eine der
;          beiden tasten
;---------------------------------------
weiter
         lda #<weitertxt
         sta $fb
         lda #>weitertxt
         sta $fc
         jsr printf

         ;auf tastendruck warten
         lda #<tastenliste
         sta $fb
         lda #>tastenliste
         sta $fc
         jsr waitkey

         rts

tastenliste
        !byte 2, 13, " "

weitertxt 
        !byte 0, 2, 24, 5
        !text "<<WEITER MIT 'CR' OD."
        !text "'SPACE'>>"
        !byte $00     ;ende-kz

