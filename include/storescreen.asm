;--------------------------------
; abspeichern des Screeninhaltes
;--------------------------------
storescreen        lda #<SCREENBASE
                   sta $fb
                   lda #>SCREENBASE
                   sta $fc
                   lda #<savebase
                   sta $fd
                   lda #>savebase
                   sta $fe

                   ldx #3      ;Block-durchlaeufe
                   ldy #$0
stscloop01         lda ($fb),y ;inhalt kopieren ...
                   sta ($fd),y ; ... und speichern
                   dey
                   bne stscloop01
                   inc $fb
                   inc $fd
                   dex
                   bpl stscloop01
                               ;4. Block
                   ldy #232
stscloop02         lda ($fb),y
                   sta ($fd),y
                   dey
                   bne stscloop02
                               ; 1x noch
                   lda ($fb),y
                   sta ($fd),y

       ;Cursor Position ermitteln
                   sec
                   jsr PLOT
                   stx oldcurpos
                   sty oldcurpos+1

                   rts
;-----------------------------
; restoren des Screeninhaltes
;-----------------------------
restorescreen      
       lda#147
       jsr BSOUT
       lda #<SCREENBASE
                   sta $fb
                   lda #>SCREENBASE
                   sta $fc
                   lda #<savebase
                   sta $fd
                   lda #>savebase
                   sta $fe

                   ldx #3      ;Block-durchlaeufe
                   ldy #$0
restscloop01       lda ($fd),y ;inhalt kopieren ...
                   sta ($fb),y ; ... und speichern
                   dey
                   bne restscloop01
                   inc $fb
                   inc $fd
                   dex
                   bpl restscloop01
                               ;4. Block
                   ldy #232
restscloop02       lda ($fd),y
                   sta ($fb),y
                   dey
                   bne restscloop02
                               ; 1x noch
                   lda ($fd),y
                   sta ($fb),y

       ;Cursor Position wieder herstellen
       clc
       ldx oldcurpos
       ldy oldcurpos+1
       jsr PLOT

                   rts
;-----------------------------
savebase  !fill 1000, $00


