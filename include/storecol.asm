;---------------------------------------
; RETTET DIE ALTEN FARBENWERTE
;---------------------------------------
StoreCol

  ;Farben retten
  lda BSCOL
  sta oldbscol
  lda FRAMECOL
  sta oldframecol
  lda PENCOL
  sta oldpencol
  lda PENHGCOL
  sta oldpenhgcol
  rts
;---------------------------------------

