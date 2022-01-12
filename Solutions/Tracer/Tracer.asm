; 10 SYS (2080)

*=$801
        !byte $0c, $08                  ;--- next Befehl
        !byte $0A, $00                  ;--- ZeilenNr.
        !byte $9E                       ;--- Befehlstoken >sys<
        !byte $20                       ;--- Leerzeichen
        !byte $32, $30, $38, $30        ;--- Adresse >2080<
        !byte $00                       ;--- Ende-KZ
        !byte $00, $00                  ;--- next Befehl

;=====================================================
; dieses ist das komplette, fertige Programm
;
; hier kommen die getesteten Aufrufe herein
;=====================================================
*=$0820
start   
                   jsr PrjInit   
                   jsr ueberschrift

                   jsr pcand     
                   jsr mcand     

                   lda #147      
                   jsr BSOUT
                   jsr regout    ;--- Register ---

                ;--- Parameterliste f. befout befuellen ---
                   lda #5
                   sta befoutpar 
                   lda #1        
                   sta befoutpar+1    ;--- x/y
                   lda #12
                   sta befoutpar+2    ;--- Wiederholungen
                   sta befoutpar+3    ;--- KZ
                   lda #1        
                   sta befoutpar+4    ;--- alle
                   lda #<befoutpar    
                   sta $fb       
                   lda #>befoutpar   
                   sta $fc       
                   jsr befout    

                ;--- Parameterliste f. memout befuellen ---
                   lda #20       
                   sta memoutpar 
                   lda #0        
                   sta memoutpar+1
                   lda #3       ;--- Anzahl der Zeilen ---        
                   sta memoutpar+2
                   lda #<memoutpar
                   sta $fb       
                   lda #>memoutpar
                   sta $fc       
                   jsr memout    

                   jsr weiter    

                   jsr RestoreCol
                   rts
;=================================================
; Allgemeine includes
!source          "..\..\include\storecol.asm"
!source          "..\..\include\restorecol.asm"
!source          "..\..\include\printf.asm"
!source          "..\..\include\waitkey.asm"
!source          "..\..\include\weiter.asm"
!source          "..\..\include\hextodec.asm"
!source          "..\..\include\dectohex.asm"
!source          "..\..\include\dectobin.asm"
!source          "..\..\include\conbcd.asm"
!source          "..\..\include\unpk.asm"

!source          "..\..\include\sysrot.i"
!source          "..\..\include\sysvar.i"
!source          "..\..\include\syskonst.i"
!source          "..\..\include\ZeroPage.i"

; Project-includes
!source          "prjinit.asm"
!source          "ueber.asm"
!source          "pcand.asm"
!source          "mcand.asm"
!source          "regout.asm"
!source          "opcodeinit.asm"
!source          "opcodesearch.asm"
!source          "befout.asm"
!source          "memout.asm"
!source          "vars.i"
!source          "opcode.dat"

; sonstige includes

;=================================================
; Variablen
parameterliste     !fill  10, $00  ; allg. Parameterliste
memoutpar          !fill   3, $00
befoutpar          !fill   5, $00
