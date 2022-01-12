;---------------------------------------
; STELLT DIE ALTEN FARBENWERTE HER
;---------------------------------------
RestoreCol
  ;Farben wieder herstellen
  lda oldbscol
  sta BSCOL
  lda oldframecol
  sta FRAMECOL
  lda oldpencol
  sta PENCOL
  lda oldpenhgcol
  sta PENHGCOL
  
  rts
;---------------------------------------

