;---------------------------------------
; die routine schreibt die ueberschrift
;---------------------------------------
ueberschrift
         lda #<uebervar
         sta $fb
         lda #>uebervar
         sta $fc
         jsr printf

         rts

uebervar
         !byte $00    ;debug-kz
         !byte 2      ;ascii
         !byte 0,0    ;x/y
         !byte 147,240
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,238
         !byte 221
         !text " tracer v3.0       "
         !text "                   "
         !byte 221,237
         !byte 96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96,96
         !byte 96,96,96,96,96,96,96
         !byte 253

         !byte $00

