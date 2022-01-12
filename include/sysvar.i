;---------------------------------------
; GLOBALE SYSTEMVARIABLEN
;---------------------------------------
TempVar         !fill   20, $00
;         bytes   $00*20  ;--- 20 Bytes temp. Speicher
oldframecol     !byte    0
oldbscol        !byte    0
oldpencol       !byte    0
oldpenhgcol     !byte    0
oldcurpos       !byte    0,0     ;x/y