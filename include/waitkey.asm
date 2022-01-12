;---------------------------------------
; waitkey: die routine wartet auf einen
;          gueltigen tatstendruck
;
; in:
;    $fb/$fc -> adr. der variablenliste
;
;    variablenlisten-aufbau
;
;    a b..b
;    ! !
;    ! +------- gueltige tasten
;    !
;    +--------- anzahl d. guelt. tasten
;
; out:
;    akku  -> gedruecktes zeichen
;    x-reg -> stelle innerhalb b
;---------------------------------------
waitkey

wklo001  ;zeichen einlesen
         jsr GETIN
         beq wklo001

         ;char auswerten
         ldy #0
         sta TempVar   ;retten
         lda ($fb),y
         tay
         lda TempVar

wklo002  cmp ($fb),y
         beq wkpt001
         dey
         bne wklo002
         beq wklo001

wkpt001
         tya
         tax
         lda TempVar
         rts

