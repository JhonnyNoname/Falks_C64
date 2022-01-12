;---------------------------------------
; switch: die routine wartet auf einen
;         gueltigen tatstendruck und
;         verzweigt u.U. zur angegebebenen
;         addresse - es ist eine erwei-
;         terung der routine WAITKEY
;
; in:
;    $fb/$fc -> adr. der variablenliste
;
;    variablenlisten-aufbau
;
;    a b..b c d..d
;    ! !    ! !
;    ! !    ! +----- sprungaddresse (ll/hh)
;    ! !    !        es gehoeren jeweils 2 byte
;    ! !    !        zusammen und sind 
;    ! !    !        in der selben reihenfolge
;    ! !    !        wie die "gueltigen tasten"
;    ! !    !
;    ! !    +------- operations-kz
;    ! !               kennzeichnet den sprungbef
;    ! !               0 .. kein sprung (d => obsolet)
;    ! !               1 .. jsr
;    ! !               2 .. jmp  (achtung mit vorsicht geniessen)
;    ! !
;    ! +------------ gueltige tasten
;    !
;    +-------------- anzahl d. guelt. tasten
;
; out:
;    akku -> gedruecktes zeichen
;    x-reg -> stelle innerhalb b
;---------------------------------------
switch          
        jsr waitkey
        ;--- werte retten ---
        sta sw_par_taste  ;gedrueckte taste
        stx sw_par_pos    ;stelle d. taste innerh. liste
        
        ;--- op-kz auswerten ---
        ldy #0
        lda (ZP_HelpAddr1),y
        tay
        iny
        lda (ZP_HelpAddr1),y
        bne swpt002 
swpt001 ;--- keine weitere bearbeitung ---
        jmp switchend
swpt002 cmp #$01
        bne swpt003
        ;--- operator = 1 --> jsr ($20)
        lda #ASM_JSR
        sta swjumpbef
        jmp swpt004
swpt003 ;--- operator = 2 --> jmp ($4c)
        lda #ASM_JMP
        sta swjumpbef
swpt004 ;--- adr. aus parliste eintragen ---
        ;--- ptr 2. par-teil
;--------------------------------------------------        
        ldy #$00
        lda (ZP_HelpAddr1),y
        sta sw_par_anzahl
        ;--- adresse errechnen ---
        sta TempVar+3
        inc TempVar+3
        sty TempVar+4
        lda #1    ;--- add-kz
        sta TempVar
        lda ZP_HelpAddr1
        sta TempVar+1
        lda ZP_HelpAddr1+1
        sta TempVar+2
        lda #<TempVar
        sta ZP_HelpAddr1
        lda #>TempVar
        sta ZP_HelpAddr1+1
        jsr adrcalc
        stx ZP_HelpAddr1
        sty ZP_HelpAddr1+1
        ;--- sprungaddresse ermitteln ---
        lda sw_par_pos
        sta TempVar
        asl TempVar
        ldy TempVar
        lda (ZP_HelpAddr1),y
        sta swjumpbef+2
        dey
        lda (ZP_HelpAddr1),y
        sta swjumpbef+1
;--------------------------------------------------        
        
        ;--- sprung in routine ---
    swjumpbef
        !byte ASM_NOP           ;jsr / jmp
        !byte ASM_NOP, ASM_NOP

switchend
        lda sw_par_taste  ;gedr. taste
        ldx sw_par_pos    ;pos in auswahlliste
        rts

swvar
sw_par_taste        !byte $00       ;gedr. taste
sw_par_pos          !byte $00       ;innerh. der liste
sw_par_swparameter  !byte $00, $00  ;ptr d. 2. teils der par-liste (ll/hh)
sw_par_anzahl       !byte $00       ;anzahl der uebergeben pars
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        