;---------------------------------------
; die routine macht aus einer 3-byte-bcd
; zahl eine 6-stellige, druckbare
; zeichenfolge (fuehrende 0 werden un-
; terdrueckt)
;
; in:    $fb/$fc - adresse der bcd-zahl
;
; out:   $fd/$fe - adresse des strings
;                  (6 byte)
;
; bsp.: input   - $04 $91 $52
;       output  - $20 $34 $39 $31 $35 $32
;---------------------------------------
unpk
         ;ergebnisadresse setzen
         lda #<unpkstr
         sta $fd
         lda #>unpkstr
         sta $fe

         lda #2
         sta unpkincnt
         lda #5
         sta unpkergcnt

unpkpt010 ;re. halbbyte
         ldy unpkincnt
         lda ($fb),y
         and #$0f
         clc
         adc #$30
         ldy unpkergcnt
         sta ($fd),y
          ;li. halbbyte
         dec unpkergcnt
         ldy unpkincnt
         lda ($fb),y
         lsr a
         lsr a
         lsr a
         lsr a
         and #$0f
         clc
         adc #$30
         ldy unpkergcnt
         sta ($fd),y
         dec unpkergcnt
         dec unpkincnt
         bpl unpkpt010

         ;fuehrende 0 entfernen
         ;---------------------
         ldx #5       ;stellenzaehler
         ldy #0
unpkpt020
         lda ($fd),y
         cmp #$30
         bne unpkpt029
         lda #" "
         sta ($fd),y
         iny
         dex
         bne unpkpt020
unpkpt029

         rts

unpkstr     !text "------"
unpkincnt   !byte $00
unpkergcnt  !byte $00

