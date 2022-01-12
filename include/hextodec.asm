;---------------------------------------
; die routine konveriert ein byte
; (string) in eine zahl
;
; in:  accu - umzurechnender wert
; out: accu - umgerechneter wert
;             ($ff bei fehler)
;
; bsp:  in  - $39 ('9')
;       out - $09
;---------------------------------------
hextodec
         sec
         sbc #$41
         bpl htd001
         clc
         adc #$07
htd001   clc
         adc #10

         ;auf gueltigkeit pruefen
         sta htdvar
         and #$f0
         beq htd020
htd010   ;rc $ff setzen (fehler)
         lda #$ff
         jmp htdend

htd020   ;rc converted setzen
         lda htdvar

htdend
         rts

htdvar   !byte $00

