;=======================================
; hier sind die gesammelten Fehlertexte
;
; in:
;   Akku => FC
;
;       $01 -> Funktion ist noch nicht umgesetzt
;       $02 -> DriveAdresse ist nicht gueltig
;       $ff -> Fehlercode nicht implementiert
;=======================================
failure
        cmp #$01
        beq failure01
        cmp #$02
        beq failure02
        jmp failff

        ;--- Spruenge zu den Fehlercodes ---
failure01 jmp fail01
failure02 jmp fail02

        ;=== Ausgabe der Fehlertexte ===
fail01  ;--- FC $01 ---
        jsr ueber       ;--- Ueberschrift
        lda #<fail01txt
        sta $fb
        lda #>fail01txt
        sta $fc
        jsr printf
        jsr weiter
        rts
fail01txt
        !byte    0, 2            ;--- Debug / AArt
        !byte    7, 0            ;--- Zeile / Spalte
        !text    "DIESE FUNKTION IST (NOCH) NICHT"
        !byte    13
        !text    "IMPLEMENTIERT"
        !byte    0               ;--- Ende-KZ
;---------------------------------------------------
fail02  ;--- FC $02 ---
        jsr ueber       ;--- Ueberschrift
        lda #<fail02txt
        sta $fb
        lda #>fail02txt
        sta $fc
        jsr printf
        jsr weiter
        rts
fail02txt
        !byte    0, 2            ;--- Debug / AArt
        !byte    7, 0            ;--- Zeile / Spalte
        !text    "DIE GERAETEADRESSE IST UNGUELTIG"
        !byte    0               ;--- Ende-KZ
;---------------------------------------------------
failff  ;--- Fehlercode nicht implementiert ---
        jsr ueber       ;--- Ueberschrift
        lda #<failfftxt
        sta $fb
        lda #>failfftxt
        sta $fc
        jsr printf
        jsr weiter
        rts
failfftxt
        !byte    0, 2            ;--- Debug / AArt
        !byte    7, 0            ;--- Zeile / Spalte
        !text    "DIESER FEHLERCODE IST NICHT"
        !byte    13
        !text    "IMPLEMENTIERT"
        !byte    0               ;--- Ende-KZ
