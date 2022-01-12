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

!source          "..\..\include\sysrot.i"
!source          "..\..\include\sysvar.i"

; Project-includes
;!source          ".\prjinit.asm"
;!source          ".\failure.asm"
;!source          ".\noch_offen.asm"
;=================================================
; hier kommt das zu entwickelnde PGM herein
pgm
	;jsr work	;--- bei bedarf dekommentieren
        rts
;---------------------------------------


;=================================================
;sonstige includes