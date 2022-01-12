;---------------------------------------
; Globale Variablen
;---------------------------------------
_befanz      !byte $00
_pc          !byte $00,$00   ;pc hh/ll
_mc          !byte $c0,$12   ;memcount hh/ll
_bp          !byte $00,$00   ;breakpoint hh/ll
_accu        !byte $00
_xreg        !byte $00
_yreg        !byte $00
_streg       !byte $00        ;status -byte
_stregbin    !text "12345678" ;st als bin
_reserved    !byte $00, $00, $00    ;reservierter speicherbereich
_hexkey      !byte $10
             !text "0123456789"
             !byte $41,$42,$43,$44,$45,$46
_wrtandtx    !byte 0, 2, 5, 25
             !text "$--  "
             !byte $00        ;ende-kz
_andbesch    !byte 0,2,5,21
             !text "   "
             !byte 0      ;ende-kz
_LeerZ       !fill 04, $00
             !text "                    "
             !text "                   1"
             !byte $00        ;ende-kz
_quit        !byte $0f
