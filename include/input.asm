;=====================================================
; input
;
;   input ohne laestiges >>?<< und ohne blinkenden Cursor
;
; in:
;       $fd/$fe -> Adr. der ParListe
;
;       ParListenaufbau (BYTES)
;       A B C DE FG
;       ! ! ! !  !
;       ! ! ! !  +-- Adresse der gueltigen Tasten (f. waitkey - CR muss dabei sein!!!)
;       ! ! ! !         F -> lb
;       ! ! ! !         G -> hb
;       ! ! ! !
;       ! ! ! +----- Adresse des zu druckenden Textes (f. printf)
;       ! ! !           D -> lb
;       ! ! !           E -> hb
;       ! ! !
;       ! ! +------- KZ fuer zu druckenden Text
;       ! !             0 -> keinen Text drucken
;       ! !             1 -> Text an Waitkey weitergeben (mit dessen struktur)
;       ! !
;       ! +--------- Cursorzeichen (ASCII-Code)
;       !
;       +----------- Debug-KZ
;
; out:
;       $fd/$fe -> Adr. des eingegebenen Strings
;
;       Aufbau (BYTES)
;       AAA B C..C
;       !   ! !
;       !   ! +---- String (input_var_string +1)
;       !   !
;       !   +------ Anzahl der eingegebenen Chars (input_var_string)
;       !           (bei nachfolgendem printf kann das ueberschrieben werden)
;       !
;       +---------- 4 Fuellbytes fuer eine evtl. printf-ausgabe (input_var_forprintf)
;=====================================================
input
;Zeropage wegsichern
                   lda $fb     
                   sta input_var_zp
                   lda $fc     
                   sta input_var_zp+1
                   
;Rueckgabewerte
                   lda #1      
                   sta input_var_string                   

;evntl. zu druckender Text
                   ldy #2      
                   lda ($fd),y 
                   cmp #0      ;kein Text
                   beq input_no_txt
                   cmp #1      ;Text mit printf ausgeben
                   beq input_txt_printf
                   jmp input_no_txt
input_txt_printf   ldy #3
                   lda ($fd),y 
                   sta $fb     
                   iny
                   lda ($fd),y 
                   sta $fc     
                   jsr printf
input_no_txt

;Cursor drucken
input_print_crsr   ldy #1
                   lda ($fd),y 
                   jsr BSOUT   
;Tastendruck abwarten
                   ldy #5      
                   lda ($fd),y 
                   sta $fb     
                   iny
                   lda ($fd),y 
                   sta $fc     
                   jsr waitkey 
;eingegebene Taste abspeichern
                   ldx #<input_var_string
                   stx $fb     
                   ldx #>input_var_string
                   stx $fc
                   ldy input_var_string
                   sta ($fb),y 
                   inc input_var_string
;Tastendruck auswerten
                               ;Taste = CR?
                   cmp #13     
                   beq input_print_end
                   sta input_var_temp
                   lda #157    
                   jsr BSOUT   
                   lda input_var_temp
                   jsr BSOUT   ;Taste drucken
                   jmp input_print_crsr
input_print_end    dec input_var_string

;Zeropage wieder herstellen
                   lda input_var_zp
                   sta $fb     
                   lda input_var_zp+1
                   sta $fc     
                   lda #<input_var_forprintf
                   sta $fd     
                   lda #>input_var_forprintf
                   sta $fe

                   rts

input_var_zp          !byte 0, 0, 0, 0
input_var_temp        !byte 0
input_var_forprintf   !fill 3, $0     ;--- 3 bytes reserviert f. printf-ausgabe
input_var_string      !byte $0        ;--- anzahl der eingegebenen bytes
                      !fill 255, $0   ;--- eingegebene bytes
