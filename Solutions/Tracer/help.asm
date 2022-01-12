;---------------------------------------
; DIESES IST DIE ONLINE-HILFE
;---------------------------------------
HELP
         JSR UEBERSCHRIFT

         LDA #<HELPTEXT
         STA $FB
         LDA #>HELPTEXT
         STA $FC
         JSR PRINTF

         RTS

HELPTEXT
         byte $00    ;DEBUG-KZ
         byte 2      ;ASCII
         byte 3,0    ;X/Y

         byte 13
         text "ADRESSEN FESTLEGEN:"
         byte 13
         text "   P - PROCESSCOUNTER "
         byte 13
         text "   M - MEMORY-ADRESSE "
         byte 13,13
         text "REGISTER INHALTE:"
         byte 13
         text "   A - ACCU"
         byte 13
         text "   X - X-REGISTER "
         byte 13
         text "   Y - Y-REGISTER"
         byte 13
         text "   S - STATUS-REGISTER"
         byte 13,13
         text "TRACER-FUNCTION:"
         byte 13
         text "  <SPACE> - BEFEHL "
         text "TRACEN"
         byte 13
         text "   Q - PROGRAMM BEENDEN"

         byte $00

