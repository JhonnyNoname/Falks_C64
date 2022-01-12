;---------------------------------------
; die routine macht aus 2-byte (hex-inh)
; eine 3-byte-bcd-zahl in dezimaler form
;
; in:    $fb/$fc - adresse d. par.liste
;
;        aufbau d. par.liste
;        a..a
;        !
;        +--------- daten
;
; out:   $fb/$fc - adresse d. erg.
;
; bsp.:  input  - $c0 $00
;        output - $04 $91 $52
;---------------------------------------
conbcd
         ;erg-var initialisieren
         lda #0
         sta cbcderg
         sta cbcderg+1
         sta cbcderg+2

         ;$fd/$fe sichern
         lda $fd
         sta cbcdfdfe
         lda $fe
         sta cbcdfdfe+1

         ;eingabedaten sichern
         lda #<cbcdin
         sta $fd
         lda #>cbcdin
         sta $fe
         ldy #1
cbcdpt001
         lda ($fb),y
         sta ($fd),y
         dey
         bpl cbcdpt001

         ;konvertieren
         ;============
         sed

         ;re. byte - bit 3-0
         ;------------------
         lda cbcdin+1
         beq cbcdpt003  ;li. byte
         and #$0f
         clc
         adc #0         ;bcd-format
         sta cbcderg+2
         ;re. byte - bit 7-4
         ;------------------
         lda cbcdin+1
         lsr a
         lsr a
         lsr a
         lsr a
         tay            ;zaehler
         beq cbcdpt003  ;wenn 0x
cbcdpt002
         ;bit 7-4 (16 * y) addieren
         ;-------------------------
         clc
         lda #$16
         adc cbcderg+2
         sta cbcderg+2
         lda #$00
         adc cbcderg+1
         sta cbcderg+1
         lda #$00
         adc cbcderg
         sta cbcderg
         dey
         bne cbcdpt002
cbcdpt003
         ;li. byte - bit 11-8
         ;-------------------
         lda cbcdin
         beq cbcdpt009
         and #$0f
         beq cbcdpt005
         tay            ;zaehler
cbcdpt004
         ;bit 11-8 (256 * y) addieren
         ;---------------------------
         clc
         lda #$56
         adc cbcderg+2
         sta cbcderg+2
         lda #$02
         adc cbcderg+1
         sta cbcderg+1
         lda #$00
         adc cbcderg
         sta cbcderg
         dey
         bne cbcdpt004
cbcdpt005
         ;li. byte - bit 15-12
         ;--------------------
         lda cbcdin
         lsr a
         lsr a
         lsr a
         lsr a
         tay            ;zaehler
         beq cbcdpt009  ;wenn 0x
cbcdpt006
         ;bit 15-12 (4096 * y) addieren
         ;-----------------------------
         clc
         lda #$96
         adc cbcderg+2
         sta cbcderg+2
         lda #$40
         adc cbcderg+1
         sta cbcderg+1
         lda #$00
         adc cbcderg
         sta cbcderg
         dey
         bne cbcdpt006
cbcdpt009
cbcdpt010
         ;konvert. ende
         ;=============
         cld

         ;ergebnis bereitstellen
         lda #<cbcderg
         sta $fb
         lda #>cbcderg
         sta $fc

         ;$fd/$fe wieder herstellen
         lda cbcdfdfe
         sta $fd
         lda cbcdfdfe+1
         sta $fe
         rts

cbcdin   !byte $00,$00
cbcderg  !byte $00,$00,$00 ;ergebnis
cbcdfdfe !byte $00,$00

