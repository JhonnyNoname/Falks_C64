!source ".\test.asm"
!source ".\test-2.asm"

;=====================================================
; Work.asm
;
;  hier werden die akt. Funktionen u. Prog.Teile
;  entwickelt
;=====================================================
work
        ;jmp workpt004
        
        ;--- waitkey test ---
        lda #wk_tasten_end-wk_tasten-1
        sta wk_tasten
        lda #<wk_tasten
        sta ZP_HelpAddr1
        lda #>wk_tasten
        sta ZP_HelpAddr1+1
        jsr waitkey
        
        ;--- erg in text eintragen ---
        sta worktxttaste
        txa
        jsr dectohex
        ldy #0
        lda (ZP_HelpAddr1),y
        sta worktxtplatz
        iny
        lda (ZP_HelpAddr1),y
        sta worktxtplatz+1

        ;--- text herrichten ---
        lda #<wk_text
        sta ZP_HelpAddr1
        lda #>wk_text
        sta ZP_HelpAddr1+1
        lda #<worktxt11
        sta ZP_HelpAddr2
        lda #>worktxt11
        sta ZP_HelpAddr2+1
        ldy #wk_text_end-wk_text-1
        
workpt001        
        lda (ZP_HelpAddr1),y
        sta (ZP_HelpAddr2),y
        dey
        bpl workpt001
        
        lda #<worktxt1
        sta ZP_HelpAddr1
        lda #>worktxt1
        sta ZP_HelpAddr1+1
        jsr printf
        
        ;--- text wieder resetten ---
        lda #<worktxt11
        sta ZP_HelpAddr1
        lda #>worktxt11
        sta ZP_HelpAddr1+1
        ldy #worktxt11_end-worktxt11-1
        lda #$2d  ;>>-<<
        sta worktxttaste
workpt003
        sta (ZP_HelpAddr1),y
        dey
        bpl workpt003
        ;----------------------------

workpt004        
        ;--- switch-test ---
        lda #wk_tasten_end-wk_tasten-1  ;--- parameteranzahl
        sta wk_tasten
        lda #$01                        ;--- operations-kz (1 => jsr)
        sta sw_pars
        lda #<block_eins      ;--- block-1
        sta sw_pars+1
        lda #>block_eins
        sta sw_pars+2
        lda #<block_zwei      ;--- block-2
        sta sw_pars+3
        lda #>block_zwei
        sta sw_pars+4
        lda #<block_drei      ;--- block-3
        sta sw_pars+5
        lda #>block_drei
        sta sw_pars+6
        lda #<block_vier      ;--- block-4
        sta sw_pars+7
        lda #>block_vier
        sta sw_pars+8
        lda #<block_fuenf      ;--- block-5
        sta sw_pars+9
        lda #>block_fuenf
        sta sw_pars+10
        ;---
        lda #<wk_tasten                 ;--- par-adresse
        sta ZP_HelpAddr1
        lda #>wk_tasten
        sta ZP_HelpAddr1+1
        jsr switch
        
        ;--- erg in text eintragen ---
        sta worktxttaste
        txa
        jsr dectohex
        ldy #0
        lda (ZP_HelpAddr1),y
        sta worktxtplatz
        iny
        lda (ZP_HelpAddr1),y
        sta worktxtplatz+1
        
        ;--- text herrichten ---
        lda #<sw_text
        sta ZP_HelpAddr1
        lda #>sw_text
        sta ZP_HelpAddr1+1
        lda #<worktxt11
        sta ZP_HelpAddr2
        lda #>worktxt11
        sta ZP_HelpAddr2+1
        ldy #wk_text_end-wk_text-1
        
workpt002
        lda (ZP_HelpAddr1),y
        sta (ZP_HelpAddr2),y
        dey
        bpl workpt002
        
        lda #<worktxt1
        sta ZP_HelpAddr1
        lda #>worktxt1
        sta ZP_HelpAddr1+1
        jsr printf

;---------------------------------
        rts

workvar
wk_tasten
        !byte $00     ;Tastenanzahl
        !text "ABDCFE"  ;Tasten
wk_tasten_end
sw_pars !byte $01       ;op-kz
        !byte $00, $00  ;sprungtabelle
        !byte $00, $00
        !byte $00, $00
        !byte $00, $00
        !byte $00, $00
        !byte $00, $00
sw_pars_end

worktxt1      !byte 0       ; debug-kennzeichen
              !byte 2       ; ausgabeart (ascii)
              !byte 2, 2    ; zeile / spalte
              !byte 147
worktxt11     !text "------------"
worktxt11_end !byte 13, 13
              !text "TASTE: >"
worktxttaste  !byte '-'
              !byte '<', 13
              !text "PLATZ IN LISTE:"
worktxtplatz  !text "--"
              !byte 0       ; ende-kz

sw_text       !text "SWITCH-TEST "
sw_text_end              
wk_text       !text "WAITKEY-TEST"
wk_text_end              

              
              
              
              
              
              
              
              
              
              
              
              
              
              