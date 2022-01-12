;---------------------------------------
; ZeroPage
;---------------------------------------
ZP_ProcPort         = $01           ;AA BBB CCC
                                    ;!! !!! !!!
                                    ;!! !!! !!+-- 1=BASIC ROM  / 0=RAM
                                    ;!! !!! !+--- 1=KERNAL-ROM / 0=RAM (BASIC verschwindet auch!)
                                    ;!! !!! +---- 1=E/A        / 0=RAM (verschwindet auch sobald 0 & 1 null sind)
                                    ;!! !!!
                                    ;!! !!+------ Datasette: Datenausgabe
                                    ;!! !+-------            0=Taste gedrueckt / 1=KEINE Taste gedrueckt
                                    ;!! +--------            0=Motor an        / 1=Motor aus
                                    ;!!
                                    ;++---------- immer 0 (unbenutzt)
                                    
ZP_BasicStart       = $2b           ;--- BasicStart     ll (hh => $2c)
ZP_BasicVars        = $2d           ;--- BasicVariablen ll (hh => $2e)
ZP_BasicArrays      = $2f
ZP_HelpAddr1        = $fb
ZP_HelpAddr2        = $fd
