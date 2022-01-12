;----------------------------------------------------------------
; die Routine ermittelt die anzahl der Befehle des C64
;
; in:  -
; out: BEFANZ - Anzahl der Befehle
;----------------------------------------------------------------
getbefanz
                       ;Anzahl der vorhandenen Befehle ermittlen
                       ;========================================
                   
                       ;Startadresse der Bef-Liste nach $FB/$FC
                   lda #<opcddat
                   sta $fb
                   lda #>opcddat
                   sta $fc
                   ldy #0
                   sty befanz   ;Befehlszaehler
getbefanz001       
                   lda ($fb),y  ;Befehls-Code einlesen
                   cmp #$ff     ; mit ENDE-KZ abgleichen
                   beq getbefanzend  ;Ende gefunden
                       ;Adresse des nächsten Befehls in der Lise ermitteln
                   lda #opcddatln-opcddat
                   clc
                   adc $fb
                   sta $fb
                   bcc getbefanz002
                   inc $fc
getbefanz002       inc befanz
                   beq getbefanz001
                   bne getbefanz001
                   
getbefanzend
                   rts
