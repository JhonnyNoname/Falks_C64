;---------------------------------------
; dectohex: die routine wandelt den
;           inhalt einer speicherstelle
;           in einen 2-stelligen
;           string um (xx)
;
;   in:  accu - umzurechnender wert
;
;   out: $fb/$fc - adresse d. strings
;---------------------------------------
dectohex
         ;werte retten
         sta dthin

         ;maske initialisiern
         lda #$0f
         sta dthmask
         lda #"-"
         sta dtherg
         sta dtherg+1

         ;hh ausmaskieren
         lda dthin
         lsr a
         lsr a
         lsr a
         lsr a
         and dthmask
         cmp #10
         bmi dthpt001
         clc
         adc #7
dthpt001 clc
         adc #48
         sta dtherg
         ;ll ausmaskieren
         lda dthin
         and dthmask
         cmp #10
         bmi dthpt002
         clc
         adc #7
dthpt002 clc
         adc #48
         sta dtherg+1

         ;ergebnis zurueckgeben
         lda #<dtherg
         sta $fb
         lda #>dtherg
         sta $fc

         rts

dthin    !byte $00    ;eingabewert
dthmask  !byte $00    ;maske
dtherg   !text "  "   ;ergebnis

