;=====================================================
; Test-2.asm
;
;   hier wird die rout. >>switch<< getestet
;=====================================================
block_eins
      lda #$41
      sta swTxt
      jmp swTest_pt_001
                   
;=====================================================
block_zwei
      lda #$42
      sta swTxt
      jmp swTest_pt_001
                   
;=====================================================
block_drei
      lda #$43
      sta swTxt
      jmp swTest_pt_001
                   
;=====================================================
block_vier
      lda #$44
      sta swTxt
      jmp swTest_pt_001
                   
;=====================================================
block_fuenf
      lda #$45
      sta swTxt
      jmp swTest_pt_001
                   
swTest_pt_001
      lda #<swTest_txt
      sta ZP_HelpAddr1
      lda #>swTest_txt
      sta ZP_HelpAddr1+1
      jsr printf
      ;--- text befüllen ---

      rts

swTest_txt
      !byte   $ff, $02
      !byte   $07, $00    ;--- zeile, spalte
      !text   "dieser text kommt aus block "
swTxt !text   "-"
      !byte   $00