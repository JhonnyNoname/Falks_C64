;======================================================
; die routine wartet x Sekunden, und macht dann weiter
;
; in:   Akku -> Anzahl der zu wartenden Zeit
;               (#200 ==> 1/2 Sek)
;
; out:  ----
;======================================================
wait    stx waitvars
        sty waitvars+1
        sta waitcnt
        lda #0
        sta waitcnt+1
wtloop1 dec waitcnt+1
        bne wtloop1
        dec waitcnt
        bne wtloop1
        ldx waitvars
        ldy waitvars+1
        rts

waitvars  !byte    0, 0   ;--- temp-Speicher f. x/y Register
waitcnt   !fill    2, $00 ;--- Zaehler f. Sekunden
