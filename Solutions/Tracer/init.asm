;---------------------------------------
; INIT - DIE ROUTINE ERMITTELT U.A.
;        WIEVIELE BEFEHLE DER TRACER
;        KENNT
;
;   IN: --
;
;   OUT: --
;---------------------------------------
INIT
         ;REGISTER SETZEN
         ;=================
         STA ACCU
         PHP
         PLA
         STA STREG
         STX XREG
         STY YREG

         ;PC+MC SETZEN
         ;============
         LDA #$C0
         STA PC
         STA MC
         LDA #$00
         STA PC+1
         STA MC+1

         ;ANZAHL D. EINTRAEGE
         ;DER OPCODELISTE ERMITTELN
         ;=========================
         LDY #0        ;ZAEHLER INIT.
         LDA #<OPCDDAT ;STARADRESSE
         STA $FB       ; D. OPCODE-
         LDA #>OPCDDAT ; LISTE
         STA $FC       ; SETZEN
INITPT01 LDX #0
         LDA ($FB,X)
         CMP #$FF
         BEQ INITPT99  ;ENDE-KZ GEFUNDEN
         INY
         CLC
         LDA #OPCDDATLN-OPCDDAT
         ADC $FB
         STA $FB
         BCC INITPT02
         INC $FC
INITPT02 BNE INITPT01

INITPT99 STY BEFANZ

         RTS

