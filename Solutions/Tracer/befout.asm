;---------------------------------------
; DIE ROUTINE ZEIGT DEN MNEMONIC MIT
; DAZUGEHOERIGEN ARGUMENT(EN) AN
;
;  IN: $FB/$FC - ADRESSE DER PAR-LISTE
;
;  OUT: -
;
;  AB C D E
;  !  ! ! !
;  !  ! ! +------ ANZEIGE-KZ
;  !  ! !          0 -> NUR LEG.OPCODES
;  !  ! !          1 -> AUCH ILLEG. "
;  !  ! !
;  !  ! +-------- DEBUG-KZ
;  !  !
;  !  +---------- Wiederholungen DER BEFEHLE
;  !
;  +------------- POS. DER ANZEIGE
;                  A -> X-POS (Zeile)
;                  B -> Y-POS (Spalte)
;---------------------------------------
befout

                ;--- Variablen retten ---
                   lda #<befoutvars
                   sta $fd       
                   lda #>befoutvars
                   sta $fe       
                   ldy #4        
befoutloop001      lda ($fb),y
                   sta ($fd),y   
                   dey
                   bpl befoutloop001
                   lda _pc                       ;--- ProcessCounter holen ---
                   sta befoutPC                 ;---   hh
                   lda _pc+1      
                   sta befoutPC+1               ;---   ll
                   lda befoutvars               ;--- Ausgabeposition
                   sta befoutStrPrintf+2        ;---    Zeile
                   lda befoutvars+1
                   sta befoutStrPrintf+3        ;---    Spalte

befoutpt001     ;--- Ausgabestring initialisieren ---
                   lda #<befoutStringAddrHH
                   sta $fb       
                   lda #>befoutStringAddrHH
                   sta $fc       
                   lda #" "
                   ldy #befoutStringEnd-befoutStringAddrHH
                   dey
befoutloop002      sta ($fb),y
                   dey
                   bpl befoutloop002

                ;--- Adresse des Befehls in den String eintragen ---
                   lda befoutPC  
                   jsr dectohex  
                   lda #<befoutStringAddrHH       ;--- $hh-- eintragen ---
                   sta $fd       
                   lda #>befoutStringAddrHH
                   sta $fe       
                   ldy #1        
                   lda ($fb),y   
                   sta ($fd),y   
                   dey
                   lda ($fb),y   
                   sta ($fd),y   
                   lda befoutPC+1
                   jsr dectohex  
                   lda #<befoutStringAddrLL     ;--- $--ll eintragen ---
                   sta $fd       
                   lda #>befoutStringAddrLL
                   sta $fe       
                   ldy #1        
                   lda ($fb),y   
                   sta ($fd),y   
                   dey
                   lda ($fb),y   
                   sta ($fd),y   
                ;=== Mnemonic in den String eintragen ===
                ;--- Befehl in der Liste suchen ---
                   lda befoutPC+1
                   sta $fb       
                   lda befoutPC  
                   sta $fc       
                   ldy #0        
                   lda ($fb),y   
                   jsr opcdsrch  
                   lda #1        ;--- erhaltene Adresse um 1 erhoehen
                   clc
                   adc $fb       
                   sta $fb       
                   bcc befoutpt003
                   inc $fc       
befoutpt003
                ;--- gefundenen Befehl in den String eintragen ---
                   lda #<befoutStringBefehl
                   sta $fd       
                   lda #>befoutStringBefehl
                   sta $fe       
                   ldy #2        
befoutpt004        lda ($fb),y          ;--- Mnemonic eintragen ---
                   sta ($fd),y   
                   dey
                   bpl befoutpt004
        
                ;--- eventuelle Parameter eintragen ---
                   ldy #3        ;--- Adr.art ermitteln ---
                   lda ($fb),y   
befoutpt011        cmp #01       ;--- AA 01
                   bne befoutpt012
                   jsr befoutPar01
                   jmp befoutpt090
befoutpt012        cmp #02       ;--- AA 02
                   bne befoutpt013
                   jsr befoutPar01
                   jmp befoutpt090
befoutpt013        cmp #03       ;--- AA 03
                   bne befoutpt014
                   jsr befoutPar02
                   jmp befoutpt090
befoutpt014        cmp #04       ;--- AA-04
                   bne befoutpt015
                   jsr befoutPar03
                   jmp befoutpt090
befoutpt015        cmp #05       ;--- AA-05
                   bne befoutpt016
                   jsr befoutPar04
                   jmp befoutpt090
befoutpt016        cmp #06       ;--- AA-06
                   bne befoutpt017
                   jsr befoutPar05
                   jmp befoutpt090
befoutpt017        cmp #07       ;--- AA-07
                   bne befoutpt018
                   jsr befoutPar07
                   jmp befoutpt090
befoutpt018        cmp #08       ;--- AA-08
                   bne befoutpt019
                   jsr befoutPar08
                   jmp befoutpt090
befoutpt019        cmp #09       ;--- AA-09
                   bne befoutpt01a
                   jsr befoutPar09
                   jmp befoutpt090
befoutpt01a        cmp #10       ;--- AA-10
                   bne befoutpt01b
                   jsr befoutPar06
                   jmp befoutpt090
befoutpt01b        cmp #11       ;--- AA-11
                   bne befoutpt01c
                   jsr befoutPar10
                   jmp befoutpt090
befoutpt01c        cmp #12       ;--- AA-12
                   bne befoutpt01d
                   jsr befoutPar11
                   jmp befoutpt090
befoutpt01d        cmp #13       ;--- AA-13
                   bne befoutpt01e
                   jsr befoutPar13
                   jmp befoutpt090
befoutpt01e        cmp #14       ;--- AA-14
                   bne befoutpt01f
                   jsr befoutPar01
                   jmp befoutpt090
befoutpt01f        

befoutpt090     ;---  Ende Parameter eintragen ---
                ;--- aufgebauten String ausgeben ---
                   lda #<befoutStrPrintf
                   sta $fb       
                   lda #>befoutStrPrintf
                   sta $fc       
                   jsr printf    

                ;--- noch eine Zeile ausgeben? ---
                   inc befoutStrPrintf+2        ;--- Ausgabezeile erhoehen
                   dec befoutvars+2
                   bmi befoutpt002
                   jmp befoutpt001      ;--- AusgabeString initialisieren
befoutpt002        
                   rts

befoutvars              !fill  5, $00    
befoutPC                !byte $00, $00   ;--- PC - hh/ll
befoutStrPrintf         !byte    0, 2    ;--- Debug-KZ, ASCII
                        !byte    1, 1    ;--- Zeile, Spalte
befoutString            !byte    "$"
befoutStringAddrHH      !text    "--"
befoutStringAddrLL      !text    "--  "
befoutStringBefehl      !text    "---  "
befoutStringParameter   !text    "-------"
befoutStringEnd         !byte $00        ;--- Ende-KZ
;---------------------------------------------------------------------
; internen ProcessCounter um 1 erhoehen
;---------------------------------------------------------------------
befoutCountPC
                   clc
                   lda #1        
                   adc befoutPC+1
                   sta befoutPC+1
                   bcc befoutCountPCpt001
                   inc befoutPC  
befoutCountPCpt001
                   rts
;---------------------------------------------------------------------
; Parameter der AdrArten aufbereiten und eintragen
;---------------------------------------------------------------------
befoutPar01             ;--- AArten 01/02/14
                        ;--- keine Parameter
                   jsr befoutCountPC    ;--- internen PC +1
                   rts
befoutPar02             ;--- AArt 03
                        ;--- xxx  #$nn
                   lda #"#"
                   sta befoutStringParameter
                   lda #"$"
                   sta befoutStringParameter+1
                   jsr befoutCountPC    ;--- internen PC +1
                   lda befoutPC+1       ;--- Parameter holen
                   sta $fb       
                   lda befoutPC  
                   sta $fc       
                   ldy #0        
                   lda ($fb),y   
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+2
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+3
                   jsr befoutCountPC    ;--- internen PC +2
                   rts
befoutPar03             ;--- AArten 04/13
                        ;--- xxx  $hhll
                   lda #"$"
                   sta befoutStringParameter
                   jsr befoutCountPC    ;--- internen PC +1
                   lda befoutPC+1       ;--- $--ll
                   sta $fd 
                   lda befoutPC  
                   sta $fe       
                   ldy #0        
                   lda ($fd),y   
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+3
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+4
                   jsr befoutCountPC;--- internen PC +2
                   lda befoutPC+1       ;--- $hh--
                   sta $fd       
                   lda befoutPC  
                   sta $fe       
                   ldy #0        
                   lda ($fd),y   
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+1
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+2
                   jsr befoutCountPC    ;--- internen PC +3
                   rts
befoutPar04             ;--- AArt 05
                        ;--- xxx  $hhll,x
                   jsr befoutPar03
                   lda #","
                   sta befoutStringParameter+5
                   lda #"X"
                   sta befoutStringParameter+6
                   rts
befoutPar05             ;--- AArt 06
                        ;--- xxx  $hhll,y
                   jsr befoutPar03
                   lda #","
                   sta befoutStringParameter+5
                   lda #"Y"
                   sta befoutStringParameter+6
                   rts
befoutPar06             ;--- AArt 10
                        ;--- xxx  ($hhll)
                   jsr befoutPar03
                   lda #"("
                   sta befoutStringParameter
                   lda #"$"
                   sta befoutStringParameter+1
                   lda #")"
                   sta befoutStringParameter+6
                   rts
befoutPar07             ;--- AArt 07
                        ;--- xxx  $ll
                   jsr befoutCountPC    ;--- internen PC +1
                   lda #"$"
                   sta befoutStringParameter
                   lda befoutPC+1
                   sta $fb       
                   lda befoutPC  
                   sta $fc       
                   ldy #0        
                   lda ($fb),y   
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+1
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+2
                   jsr befoutCountPC    ;--- internen PC +2
                   rts
befoutPar08             ;--- AArt 08
                        ;--- xxx  $ll,x
                   jsr befoutPar07
                   lda #","
                   sta befoutStringParameter+3
                   lda #"X"
                   sta befoutStringParameter+4
                   rts
befoutPar09             ;--- AArt 09
                        ;--- xxx  $ll,y
                   jsr befoutPar07
                   lda #","
                   sta befoutStringParameter+3
                   lda #"Y"
                   sta befoutStringParameter+4
                   rts
befoutPar10             ;--- AArt 11
                        ;--- xxx  ----,x)
                   jsr befoutPar12
                   lda #","
                   sta befoutStringParameter+4
                   lda #"X"
                   sta befoutStringParameter+5
                   lda #")"
                   sta befoutStringParameter+6
                   rts
befoutPar11             ;--- AArt 12
                        ;--- xxx  ----),y
                   jsr befoutPar12
                   lda #")"
                   sta befoutStringParameter+4
                   lda #","
                   sta befoutStringParameter+5
                   lda #"Y"
                   sta befoutStringParameter+6
                   rts
befoutPar12             ;--- AArten 11/12
                        ;--- xxx  ($ll
                   lda #"("
                   sta befoutStringParameter
                   lda #"$"
                   sta befoutStringParameter+1
                   jsr befoutCountPC    ;--- internen PC +1
                   lda befoutPC  
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+2
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+3
                   jsr befoutCountPC    ;--- internen PC +2
                   rts
befoutPar13             ;--- AArt 13
                        ;--- xxx  $hhll
                        ;--- Branch-Befehle
                   lda #"$"
                   sta befoutStringParameter
                   lda befoutPC
                   sta $fe
                   lda befoutPC+1
                   sta $fd
                        ;--- Parameter d. Befehls merken ---
                   ldy #1        
                   lda ($fd),y   
                   sta TempVar
                   jsr befoutCountPC    ;--- interner PC +1
                   jsr befoutCountPC    ;--- interner PC +2
                        ;--- Adr. des naechsten Bef. merken ---
                   lda befoutPC  
                   sta TempVar+1        ;--- interner PC hh
                   lda befoutPC+1
                   sta TempVar+2        ;--- interner PC ll
                   lda #$ff      
                   bit TempVar
                   bpl befoutPar13pt001
                        ;--- Adresse ist VOR akt.Adresse
                        ;---   akt.Adresse - Wert
                ;--- Zweierkomplement bilden
                   lda #$ff      
                   eor TempVar   
                   sta TempVar   
                   inc TempVar   
                   sec
                   lda TempVar   
                   sbc TempVar+2 
                   sta TempVar+2 
                   bcs befoutPar13pt004
                   dec TempVar+1 
befoutPar13pt004
                   jmp befoutPar13pt002
befoutPar13pt001        ;--- Adresse ist NACH akt.Adresse
                        ;---   akt.Adresse + Wert
                   clc
                   lda TempVar   
                   adc TempVar+2 
                   sta TempVar+2 
                   bcc befoutPar13pt003
                   inc TempVar+1 
befoutPar13pt003

befoutPar13pt002
                ;--- Adrese aus TEMPVAR (hh)/ TEMPVAR+1 (ll) umrechnen
                   lda TempVar+1
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+1
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+2
                   lda TempVar+2 
                   jsr dectohex  
                   ldy #0        
                   lda ($fb),y   
                   sta befoutStringParameter+3
                   iny
                   lda ($fb),y   
                   sta befoutStringParameter+4
                        ;--- Adresse in String eintragen ---
        
                   rts
befoutPar13var     !byte 0  ;--- Parameter des Branch-Befehls