;---------------------------------------
; diese routine zeigt die register,
; die befehle und den speicher an
;---------------------------------------
anzeige
         ;screen loeschen
         lda #147
         jsr BSOUT

         ;register anzeigen
         jsr regout

         ;befehle anzeigen
         lda #<anzbef
         sta $fb
         lda #>anzbef
         sta $fc
         jsr befout

         ;speicher anzeigen
         lda #<anzmem
         sta $fb
         lda #>anzmem
         sta $fc
         jsr memout

         rts

anzbef   !byte 4,0,15,0,0
anzmem   !byte 20,0,4

