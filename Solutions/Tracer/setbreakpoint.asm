;=====================================================
; die Routine setzt den Breakpoint
;
; Taetigkeiten
;
;  BP setzen (SetBP):
;  ==========================
;    - Adresse f. den BP setzen
;    - 3 Bytes von der Adresse in den reservierten
;      Bereich verschieben
;
;  BP erreicht (ArrBP):
;  ============
;    - die geretteten Befehle wieder zurueckschreiben
;
; diese Routine kann auch f. den "normalen" Trace
;    aufgerufen werden
;=====================================================
SetBP
                ;--- Adresse des BP setzen ---
                ;-----------------------------
                   jsr bpand     

                ;--- 3 Bytes von der Adresse in den res. Bereich schieben ---
                ;------------------------------------------------------------
                   lda bp+1      ;ll
                   sta $fb       
                   lda bp        ;hh
                   sta $fc       
                   lda #<RESERVED
                   sta $fd       
                   lda #>RESERVED
                   sta $fe       
                   ldy #2        
setbppt001         lda ($fb),y
                   sta ($fd),y   
                   dey
                   bpl setbppt001
                ;--- eintragen:
                ;---    rts ($60)
                ;---    rts ($60)
                ;---    rts ($60)
                   ldy #2        
                   lda #$60
setbppt002         sta ($fb),y
                   dey
                   bpl setbppt002
                   rts

ArrBP
                ;--- die geretteten Befehle wieder zurueckschreiben ---
                ;------------------------------------------------------
                   lda bp+1      ;ll
                   sta $fb       
                   lda bp        ;hh
                   sta $fc       
                   lda #<RESERVED
                   sta $fd       
                   lda #>RESERVED
                   sta $fe       
                   ldy #2        
ArrBPpt001         lda ($fd),y
                   sta ($fb),y   
                   dey
                   bpl ArrBPpt001

                   rts
