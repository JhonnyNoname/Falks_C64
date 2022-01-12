;=====================================================
; memcopy.asm
;
;  kopiert den angegebenen Speicherbereich
;
;       in:     $fb/$fc - Adresse der ParListe
;
;               Parlisten Aufbau
;               ab cd ef
;               !  !  !
;               !  !  +----- Anzahl (-1) der zu kopierenden Bytes
;               !  !            e -> ll
;               !  !            f -> hh
;               !  !
;               !  +-------- Zieladresse 
;               !               c -> ll
;               !               d -> hh
;               !
;               +----------- Quelladresse
;                               a -> ll
;                               b -> ll
;=====================================================
MemCpy
    ;--- Parameter uebernehmen ---
    ldy #0
    lda (ZP_HelpAddr1),y    ;--- SourceAdr
    sta MemCpVarSource +1
    iny
    lda (ZP_HelpAddr1),y
    sta MemCpVarSource +2
    iny
    lda (ZP_HelpAddr1),y    ;--- TargetAdr
    sta MemCpVarTarget +1
    iny
    lda (ZP_HelpAddr1),y
    sta MemCpVarTarget +2
    iny
    lda (ZP_HelpAddr1),y    ;--- Counter
    sta MemCpVarCount +1
    iny
    lda (ZP_HelpAddr1),y
    sta MemCpVarCount +2
    
    ;--- in welche Richtung wird verschoben? ---
    lda #3  ;--- Vergl-KZ
    sta MemCpVarTemp
    lda MemCpVarSource +1   ;--- Source-Addr
    sta MemCpVarTemp +1
    lda MemCpVarSource +2
    sta MemCpVarTemp +2
    lda MemCpVarTarget +1   ;--- Target-Addr
    sta MemCpVarTemp +3
    lda MemCpVarTarget +2
    sta MemCpVarTemp +4
    lda #<MemCpVarTemp
    sta ZP_HelpAddr1
    lda #>MemCpVarTemp
    sta ZP_HelpAddr1 +1
    jsr adrcalc
    cpx #$0f        ;--- Copy nach "hinten"?
    beq MemCpyPT01
    cpx #$f0        ;--- Copy nach "vorne"
    beq MemCpyPT02
    cpx #$ff        ;--- beide Adressen ident
    jmp MemCpyEnd   ;--- keine Verschiebung

MemCpyPT01      ;--- Copy nach "hinten"
    lda #1
    sta MemCpVarTemp
    lda MemCpVarSource +1
    sta MemCpVarTemp +1
    lda MemCpVarSource +2
    sta MemCpVarTemp +2
    lda MemCpVarCount +1
    sta MemCpVarTemp +3
    lda MemCpVarCount +2
    sta MemCpVarTemp +4
    jsr adrcalc
    stx MemCpVarSource +1
    sty MemCpVarSource +2
    lda MemCpVarTarget +1
    sta MemCpVarTemp +1
    lda MemCpVarTarget +2
    sta MemCpVarTemp +2
    jsr adrcalc
    stx MemCpVarTarget +1
    sty MemCpVarTarget +2
    lda #2      ;--- KZ subtrahieren
    jmp MemCpyPT03
MemCpyPT02      ;--- Copy nach "vorne"
    lda #1      ;--- KZ addierern
MemCpyPT03
    sta MemCpVarSource
    sta MemCpVarTarget
    
    ;--- MemCpVarTemp f. vergleich vorbereiten ---
    lda #3
    sta MemCpVarTemp
    lda #0
    sta MemCpVarTemp +3
    sta MemCpVarTemp +4

MemCpyPT05
    ;--- Speicherbereich kopieren ---
    lda MemCpVarSource +1
    sta ZP_HelpAddr1
    lda MemCpVarSource +2
    sta ZP_HelpAddr1 +1
    lda MemCpVarTarget +1
    sta ZP_HelpAddr2
    lda MemCpVarTarget +2
    sta ZP_HelpAddr2 +1
    ldy #0
    lda (ZP_HelpAddr1),y
    sta (ZP_HelpAddr2),y
    ;--- noch ein DL? ---
    lda MemCpVarCount +1
    sta MemCpVarTemp +1
    lda MemCpVarCount +2
    sta MemCpVarTemp +2
    lda #<MemCpVarTemp
    sta ZP_HelpAddr1
    lda #>MemCpVarTemp
    sta ZP_HelpAddr1 +1
    jsr adrcalc
    cpx #$ff
    beq MemCpyPT04    ;--- kein weiterer DL
    ;--- Counter vermindern ---
    lda #<MemCpVarCount
    sta ZP_HelpAddr1
    lda #>MemCpVarCount
    sta ZP_HelpAddr1 +1
    jsr adrcalc
    stx MemCpVarCount +1
    sty MemCpVarCount +2
    ;--- Quelle u. Ziel anpassen ---
    lda #<MemCpVarSource  ;--- Quelle
    sta ZP_HelpAddr1
    lda #>MemCpVarSource
    sta ZP_HelpAddr1 +1
    jsr adrcalc
    stx MemCpVarSource +1
    sty MemCpVarSource +2
    lda #<MemCpVarTarget  ;--- Ziel
    sta ZP_HelpAddr1
    lda #>MemCpVarTarget
    sta ZP_HelpAddr1 +1
    jsr adrcalc
    stx MemCpVarTarget +1
    sty MemCpVarTarget +2
    jmp MemCpyPT05
    
MemCpyPT04    
    
MemCpyEnd    
    rts

MemCpVars
MemCpVarTemp    !byte $00         ;--- Operator-KZ
                !byte $00, $00    ;--- Addr 1
                !byte $00, $00    ;--- addr 2
MemCpVarSource  !byte $00         ;--- Operator-KZ
                !byte $00, $00    ;--- SourceAdr. ($ll/$hh)
                !byte $01, $00    ;--- Summand oder Subtrahend ($ll/$hh)
MemCpVarTarget  !byte $00         ;--- Operator-KZ
                !byte $00, $00    ;--- TargetAdr. ($ll/$hh)
                !byte $01, $00    ;--- Summand oder Subtrahend ($ll/$hh)
MemCpVarCount   !byte $02         ;--- Operator-KZ
                !byte $00, $00    ;--- Counter, wie oft noch DL ($ll/$hh)
                !byte $01, $00    ;--- Summand oder Subtrahend ($ll/$hh)
