;---------------------------------------
; dectobin: die routine wandelt den
;           inhalt einer speicherstelle
;           in einen 8-stelligen
;           string um (xxxxxxxx)
;
;   in:  accu - umzurechnender wert
;
;   out: $fb/$fc - adresse d. strings
;---------------------------------------
dectobin
         ;werte retten
         sta dtbin
         lda #$01     ;maske initial.
         sta dtbmask

         lda #<dtberg
         sta $fb
         lda #>dtberg
         sta $fc
         ldy #7

dtbpt010 lda #"0"
         sta ($fb),y
         ;wert ausmaskieren
         lda dtbin
         and dtbmask
         beq dtbpt011
         lda #1
         clc
         adc ($fb),y
         sta ($fb),y
dtbpt011 asl dtbmask
         dey
         bpl dtbpt010

         rts

dtbin    !byte $00    ;eingabewert
dtbmask  !byte $00
dtberg   !text "--------"