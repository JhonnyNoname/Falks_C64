;=====================================================
; die routine gibt die Adresse von >>pgm<< aus
;   um sie im debugger mit >>break ----<< zu setzen
;=====================================================
startbreak
                        ;--- addresse v. PGM anzeigen ---
                   lda #>pgm     ;--- hh v. PGM
                   jsr dectohex  
                   lda #<strtbrktext 
                   sta $fd       
                   lda #>strtbrktext
                   sta $fe       
                   ldy #1        ;--- in den Text schreiben
                   lda ($fb),y   
                   sta ($fd),y   
                   dey
                   lda ($fb),y   
                   sta ($fd),y   
                   lda #<pgm     ;--- hh v. PGM
                   jsr dectohex  
                   lda #<strtbrktext1
                   sta $fd       
                   lda #>strtbrktext1
                   sta $fe       
                   ldy #1        ;--- in den Text schreiben
                   lda ($fb),y   
                   sta ($fd),y   
                   dey
                   lda ($fb),y   
                   sta ($fd),y   
                   lda #<strtbrkvar  ;=== Adresse ausgeben ===
                   sta $fb       
                   lda #>strtbrkvar
                   sta $fc       
                   jsr printf    

                   jsr weiter    

                   rts
;-------------------------------------------------------------
strtbrkvar    !byte 0, 2          ;Debug-KZ / Ausgabe-art
              !byte 0, 0          ;Position
              !byte 147
strtbrktext   !text "HH"
strtbrktext1  !text "LL"
              !byte 0