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
;    - Anzeige der  - Register
;                   - Memory
;                   - ....
;
;  BP erreicht (ArrBP):
;  ============
;    - die geretteten Befehle wieder zurueckschreiben
;
; diese Routine kann auch f. den "normalen" Trace
;    aufgerufen werden
;=====================================================
SetBP
    jsr BPAnd
    rts
    
ArrBP
    rts