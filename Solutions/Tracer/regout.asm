;---------------------------------------
; DIE ROUTINE SCHREIBT DIE REG-WERTE
; IN FOLGENDER FORM AN
;
;  PC    AC   XR   YR   SR  NV-BDIZC
;$XXXX  $XX  $XX  $XX  $XX %--------
;-----  ---  ---  ---  ---
;---------------------------------------
regout
                  ;--- akt. Werte in die Vars schreiben ---                  
                  php
                  sta _accu
                  pla
                  sta _streg
                  stx _xreg
                  sty _yreg
                  
                   ;Statusregister
                       ;HEX-Wert
                   lda _streg                   
                   jsr dectohex
                   ldy #0
                   lda ($fb),y
                   sta regotstrsrhex+1
                   iny
                   lda ($fb),y
                   sta regotstrsrhex+2
                       ;BIN-Wert
                   lda _streg
                   jsr dectobin
                   lda #<regotstrsrbin
                   sta $fd
                   lda #>regotstrsrbin
                   sta $fe
                   ldy #7
regoutloop001      lda ($fb),y
                   sta ($fd),y
                   dey
                   bpl regoutloop001
                       ;DEZ-Wert
                   lda #0
                   sta regouttmp
                   lda _streg
                   sta regouttmp+1
                   lda #<regouttmp
                   sta $fb
                   lda #>regouttmp
                   sta $fc
                   jsr conbcd
                   jsr unpk
                   lda #<regotstrsrdez
                   sta $fb
                   lda #>regotstrsrdez
                   sta $fc
                   ldy #5
regoutloop002      lda ($fd),y
                   sta ($fb),y
                   dey
                   bpl regoutloop002
                   
                   ;Y-Register
                       ;HEX-Wert
                   lda _yreg
                   jsr dectohex
                   ldy #0
                   lda ($fb),y
                   sta regotstryrhex+1
                   iny
                   lda ($fb),y
                   sta regotstryrhex+2
                       ;DEZ-Wert
                   lda #0
                   sta regouttmp
                   lda _yreg
                   sta regouttmp+1
                   lda #<regouttmp
                   sta $fb
                   lda #>regouttmp
                   sta $fc
                   jsr conbcd
                   jsr unpk
                   lda #<regotstryrdez
                   sta $fb
                   lda #>regotstryrdez
                   sta $fc
                   ldy #5
regoutloop003      lda ($fd),y
                   sta ($fb),y
                   dey
                   bpl regoutloop003

                   ;X-Register
                       ;HEX-Wert
                   lda _xreg
                   jsr dectohex
                   ldy #0
                   lda ($fb),y
                   sta regotstrxrhex+1
                   iny
                   lda ($fb),y
                   sta regotstrxrhex+2
                       ;DEZ-Wert
                   lda #0
                   sta regouttmp
                   lda _xreg
                   sta regouttmp+1
                   lda #<regouttmp
                   sta $fb
                   lda #>regouttmp
                   sta $fc
                   jsr conbcd
                   jsr unpk
                   lda #<regotstrxrdez
                   sta $fb
                   lda #>regotstrxrdez
                   sta $fc
                   ldy #5
regoutloop004      lda ($fd),y
                   sta ($fb),y
                   dey
                   bpl regoutloop004

                   ;Akku
                       ;HEX-Wert
                   lda _accu
                   jsr dectohex
                   ldy #0
                   lda ($fb),y
                   sta regotstracuhex+1
                   iny
                   lda ($fb),y
                   sta regotstracuhex+2
                       ;DEZ-Wert
                   lda #0
                   sta regouttmp
                   lda _accu
                   sta regouttmp+1
                   lda #<regouttmp
                   sta $fb
                   lda #>regouttmp
                   sta $fc
                   jsr conbcd
                   jsr unpk
                   lda #<regotstracudez
                   sta $fb
                   lda #>regotstracudez
                   sta $fc
                   ldy #5
regoutloop005      lda ($fd),y
                   sta ($fb),y
                   dey
                   bpl regoutloop005

                   ;ProcessCounter
                       ;HEX-Wert
                   lda _pc
                   jsr dectohex
                   ldy #0
                   lda ($fb),y
                   sta regotstrpchex+1
                   iny
                   lda ($fb),y
                   sta regotstrpchex+2
                   lda _pc+1
                   jsr dectohex
                   ldy #0
                   lda ($fb),y
                   sta regotstrpchex+3
                   iny
                   lda ($fb),y
                   sta regotstrpchex+4                   
                       ;DEZ-Wert
                   lda #<_pc
                   sta $fb
                   lda #>_pc
                   sta $fc
                   jsr conbcd
                   jsr unpk
                   lda #<regotstrpcdez
                   sta $fb
                   lda #>regotstrpcdez
                   sta $fc
                   ldy #5
regoutloop006      lda ($fd),y
                   sta ($fb),y
                   dey
                   bpl regoutloop006
                   
                       ;Registerwerte ausgeben
                   lda #<regoutstring
                   sta $fb
                   lda #>regoutstring
                   sta $fc
                   jsr printf                   

                   rts

regouttmp       !byte 0, 0 
regoutstring    !byte 0, 2
                !byte 0, 0
                !text "  PC     AC    XR    YR    SR  NV-BDIZC "
regotstrpchex   !text "$----   "
regotstracuhex  !text "$--   "
regotstrxrhex   !text "$--   "
regotstryrhex   !text "$--   "
regotstrsrhex   !text "$-- "
                !text "%"
regotstrsrbin   !text "--------"
regotstrpcdez   !text " +++++"
regotstracudez  !text "   +++"
regotstrxrdez   !text "   +++"
regotstryrdez   !text "   +++"
regotstrsrdez   !text "   +++"
                !byte 0                   
