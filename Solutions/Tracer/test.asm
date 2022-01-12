*=$801
    !byte $0c, $08                  ;--- next Befehl
    !byte $0a, $00                  ;--- ZeilenNr.
    !byte $9e                       ;--- Befehlstoken >sys<
    !byte $20, $32, $30, $38, $30   ;--- Adresse >2080< ($0820)
    !byte $00                       ;--- Ende-KZ
    !byte $00, $00                  ;--- next Befehl

*=$0820
start
                ;--- addresse v. PGM anzeigen ---
        jsr startbreak

        jsr pgm

        jsr weiter
        rts

;=================================================
; Allgemeine includes
!source          "..\..\include\weiter.asm"
!source          "..\..\include\printf.asm"
!source          "..\..\include\waitkey.asm"
!source          "..\..\include\dectohex.asm"
!source          "..\..\include\startbreak.asm"
!source          "..\..\include\noch_offen.asm"
!source          "..\..\include\storecol.asm"
!source          "..\..\include\dectobin.asm"
!source          "..\..\include\conbcd.asm"
!source          "..\..\include\unpk.asm"
!source          "..\..\include\hextodec.asm"
!source          "..\..\include\adrcalc.asm"
!source          "..\..\include\switch.asm"

!source          "..\..\include\sysrot.i"
!source          "..\..\include\sysvar.i"
!source          "..\..\include\syskonst.i"
!source          "..\..\include\ZeroPage.i"

; Project-includes
!source     ".\vars.i"
!source     ".\countand.asm"
;=================================================
; hier kommt das zu entwickelnde PGM herein
pgm
    jsr work
    rts
;---------------------------------------


;=================================================
;sonstige includes