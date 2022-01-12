;---------------------------------------
; SYSTEMROUTINEN
;---------------------------------------
; AUSGABEN
CLSCR           = $e544         ;BS loeschen
SETMSG          = $ff90         ;Set Message 
BSOUT           = $FFD2         ;CharAusgabe
;                                       in: accu <-- Zeichen
CHKOUT          = $FFC9         ;set file as default output -- OPEN vorher!!!
;                                       in: x <-- lfnr

; EINGABEN
CHRIN           = $FFCF         ;Read byte from default input (for keyboard, read a line from the screen). (If not keyboard, must call OPEN and CHKIN beforehands.)
;                                       in:  -
;                                       out: accu
GETIN           = $FFE4         ;Read byte from default input (If not keyboard, must call OPEN and CHKIN beforehands.)
;                                       in:  -
;                                       out: accu

; INITS
PLOT            = $FFF0         ;CLC => set xy
;                               ;SEC => get xy
CLRCHN          = $ffcc         ;auf Standardeingabe resetten (muss gemacht werden!!!)
                                ;       in:  -
                                ;       out: -
SETFILEPAR      = $FFBA         ;set Fileparameters
;                                       in:  a <-- lfnr
;                                            x <-- devNr
;                                            y <-- secAdr
;                                       out: -
SETFILENAM      = $FFBD         ;set FileName
;                                       in: a <-- Laenge des Filenamens
;                                           x <-- $ll Filename
;                                           y <-- $hh Filename
;                                       out: -
OPEN            = $FFC0         ;open file  (SETFILEPAR; SETFILENAM vorher!!!)
;                                       in: -
;                                       out: -
CLOSE           = $FFC3         ;close file
;                                       in: accu <-- lfnr
;                                       out: -
CHKIN           = $FFC6         ;set file as default input
;                                       in: x <- log.fileNr.
;                                       out: -
RESET           = $FCE2         ;reset

; BASIC-Routinen
BASOUTWORD      = $bdcd         ;HEX-Zahl in dezimaler Form ausgeben (mit Nullunterdr�ckung)
;                                       in: accu  <- hh..
;                                           x-reg <- ..ll
