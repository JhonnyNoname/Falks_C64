;=============================================================================
; adrcalc
;
;  Die Routine rechnet mit Adressen
;
;       in:     $fb/$fc - Adresse der ParListe
;
;               Parlisten Aufbau
;               a bc de
;               ! !  !
;               ! !  +--------- Adresse 2 (d=ll e=hh)
;               ! !
;               ! +------------ Adresse 1 (b=ll c=hh)
;               !
;               +-------------- Operator
;                                   0 .. Nix - Sinnlos
;                                   1 .. Addition beider Adressen
;                                          Erg. x => ll
;                                               y => hh
;                                   2 .. Subtraktion beider Adressen
;                                                    Adr1
;                                                -   Adr2
;                                               ---------
;                                                    Erg   x => ll
;                                                          y => hh
;                                   3 .. Vergleich beider Adressen
;                                          Erg. Adr1 > Adr2 ==> x = %11110000
;                                               Adr1 < Adr2 ==> x = %00001111
;                                               Adr1 = Adr2 ==> x = %11111111
;=============================================================================
adrcalc
        ;--- Operation ermitteln ---
        ldy #0
        lda ($fb),y
        cmp #1
        beq adrcalcAdd
        cmp #2
        beq adrcalcSub
        cmp #3
        beq adrcalcComp
adrcalcFail     ;--- falsche Operation - darf gar nicht sein ---
        lda #<adrcalcFailText
        sta $fb
        lda #>adrcalcFailText
        sta $fc
        jsr printf
        jsr weiter
        jmp adrcalcEnd  ;--- Ende

adrcalcAdd      ;--- Adressen addieren ---
        ldy #1          ;--- ll (Adr1)
        lda ($fb),y
        ldy #3          ;--- ll (Adr2)
        clc
        adc ($fb),y
        tax             ;--- ==> erg. X-Reg
        ldy #2          ;--- hh (Adr1)
        lda ($fb),y
        ldy #4          ;--- hh (Adr2)
        adc ($fb),y
        tay             ;--- ==> erg. Y-Reg
        jmp adrcalcEnd  ;--- Ende
        
adrcalcSub      ;--- Adressen subtrahieren ---
        ldy #1          ;--- ll (Adr1)
        lda ($fb),y
        ldy #3          ;--- ll (Adr2)
        sec
        sbc ($fb),y
        tax             ;--- ==> erg. X-Reg
        ldy #2          ;--- hh (Adr1)
        lda ($fb),y
        ldy #4          ;--- hh (Adr2)
        sbc ($fb),y
        tay             ;--- ==> erg. Y-Reg
        jmp adrcalcEnd  ;--- Ende

adrcalcComp     ;--- Adressen vergleichen ---
        ldy #2          ;--- hh (Adr1)
        lda ($fb),y
        ldy #4          ;--- hh (Adr2)
        cmp ($fb),y
        bne adrcalcCompPt001
        ;--- idente Adressen? ---
        ldy #1          ;--- ll (Adr1)
        lda ($fb),y
        ldy #3          ;--- ll (Adr2)
        cmp ($fb),y
        bne adrcalcCompPt001
        ldx #$ff
        jmp adrcalcEnd
adrcalcCompPt001
        ;--- Adr1 > Adr2 ??? ---
        bmi adrcalcCompPt002
        ldx #$f0        ;--- Adr1 > Adr2
        jmp adrcalcEnd
adrcalcCompPt002
        ldx #$0f        ;--- Adr1 < Adr2
        jmp adrcalcEnd

adrcalcEnd
        rts

adrcalcFailText 
        !byte 0, 2, 1, 1, 147
        !text "FALSCHER OPERATOR"
        !byte 0