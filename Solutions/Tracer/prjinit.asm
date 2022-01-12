;=====================================================
; initialisiert das Programm
;=====================================================
PrjInit
                ;--- alte Farben retten ---
                   jsr StoreCol

                ;--- Farben auf schwarz setzen ---
                   lda #0        
                   sta BSCOL
                   sta FRAMECOL 
                   lda #1        
                   sta PENCOL  

                   jsr OpCodeInit

                ;--- umschalten auf kleinbuchstaben ---
                   lda #14
                   jsr BSOUT

                   rts