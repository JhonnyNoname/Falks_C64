;---------------------------------------
; Die Routine setzt den ...
; - PC (ProcessCounter) -> PCAND
; - MC (MemmoryCounter) -> MCAND
; - BP (Breakpointer)   -> BPAND
;---------------------------------------

;---------------------------------------
; DIE ROUTINE AENDERT DEN PC
;---------------------------------------
PCAND
                ;--- Feldbeschreibung ---
                   lda #"P"
                   sta _andbesch+4
                   jsr AndTxtFeld       ;--- allg. Feldbeschreibung

                   jsr CntAnd           ;--- allg. Teil
                ;--- neuen PC abspeichern ---
                   lda TempAdresse
                   sta _pc        
                   lda TempAdresse+1
                   sta _pc+1      
                   rts                  ;--- und wieder retour ---

;---------------------------------------
; DIE ROUTINE AENDERT DEN MC
;---------------------------------------
MCAND
                ;--- Feldbeschreibung ---
                   lda #"M"
                   sta _andbesch+4
                   jsr AndTxtFeld       ;--- allg. Feldbeschreibung

                   jsr CntAnd           ;--- allg. Teil
                ;--- neuen PC abspeichern ---
                   lda TempAdresse
                   sta _mc        
                   lda TempAdresse+1
                   sta _mc+1      
                   rts                  ;--- und wieder retour ---

;---------------------------------------
; DIE ROUTINE AENDERT DEN BreakPoint
;---------------------------------------
BPAnd
                ;--- Feldbeschreibung ---
                   lda #"B"
                   sta _andbesch+4
                   lda #"P"
                   sta _andbesch+5
                   jsr AndTxtFeld1      ;--- allg. Feldbeschreibung

                   jsr CntAnd           ;--- allg. Teil
                ;--- neuen PC abspeichern ---
                   lda TempAdresse
                   sta _bp
                   lda TempAdresse+1
                   sta _bp+1
                   rts                  ;--- und wieder retour ---

;--- gemeinsamer Teil der Feldbeschreibung ---
;---------------------------------------------
AndTxtFeld
                   lda #"C"
                   sta _andbesch+5
AndTxtFeld1        lda #":" 
                   sta _andbesch+6
                   lda #<_andbesch
                   sta $fb
                   lda #>_andbesch
                   sta $fc
                   jsr printf

                   lda #2        
                   STA AndCnt    
                   rts

;-------------------------------------------------------
;--- Allgemeine Aenderungen f. PCAND / MCAND / BPAND ---
;-------------------------------------------------------
CntAnd
                ;WRTANDTX INITIALISIEREN
                   LDA #"-"
                   STA _wrtandtx+7
                   STA _wrtandtx+8

                   LDA #<_wrtandtx
                   STA $FB
                   LDA #>_wrtandtx
                   STA $FC
                   JSR printf

                ;CURSOR SETZEN
                   CLC
                   LDX #5
                   LDY #26
                   JSR PLOT

CntAndPt1       ;PC EINGEBEN
                ;PC -> HH
                   STA TempVar+1
                   LDA #<_hexkey
                   STA $FB
                   LDA #>_hexkey
                   STA $FC
                   JSR waitkey
                   JSR BSOUT
                   DEC AndCnt
                   BNE CntAndPt1
                   STA TempVar+2
                ;PC -> LL
                   LDA #2
                   STA AndCnt
CntAndPt11         STA TempVar+3
                   LDA #<_hexkey
                   STA $FB
                   LDA #>_hexkey
                   STA $FC
                   JSR waitkey
                   JSR BSOUT
                   DEC AndCnt
                   BNE CntAndPt11
                   STA TempVar+4
                ;WERTE KONVERTIEREN
                   LDA TempVar+1
                   JSR hextodec
                   ASL A
                   ASL A
                   ASL A
                   ASL A
                   STA TempVar+1
                   LDA TempVar+2
                   JSR hextodec
                   ORA TempVar+1
                   STA TempAdresse      ;HH
                   LDA TempVar+3
                   JSR hextodec
                   ASL A
                   ASL A
                   ASL A
                   ASL A
                   STA TempVar+3
                   LDA TempVar+4
                   JSR hextodec
                   ORA TempVar+3
                   STA TempAdresse+1    ;LL

                ;EINGABESTRING WIEDER LOESCHEN
                   LDY #3         ;ZAEHLER
                   LDA #<_wrtandtx
                   STA $FB
                   LDA #>_wrtandtx
                   STA $FC
                   LDA #<_LeerZ
                   STA $FD
                   LDA #>_LeerZ
                   STA $FE
CntAndPt9          LDA ($FB),Y
                   STA ($FD),Y
                   DEY
                   BPL CntAndPt9
                ;ENDE-KZ SETZEN
                   LDA #$00
                   STA _LeerZ+9
                   LDA #<_LeerZ
                   STA $FB
                   LDA #>_LeerZ
                   STA $FC
                   JSR printf
                ;ENDE-KZ IN LEERZ LOESCHEN
                   LDA #" "
                   STA _LeerZ+9

        ;--- Feldbeschreibung loeschen ---
                   lda #" "
                   sta _andbesch+4
                   sta _andbesch+5
                   sta _andbesch+6
                   lda #<_andbesch
                   sta $fb
                   lda #>_andbesch
                   sta $fc
                   jsr printf

                   rts

AndCnt          !byte $00
TempAdresse     !byte $00, $00
