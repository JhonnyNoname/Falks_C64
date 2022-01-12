;---------------------------------------
; die routine aendert den memcounter
;---------------------------------------
mcand
         ;--- feldbeschreibung ---
         lda #"m"
         sta _andbesch+4
         lda #"c"
         sta _andbesch+5
         lda #":"
         sta _andbesch+6
         lda #<_andbesch
         sta $fb       
         lda #>_andbesch
         sta $fc       
         jsr printf    

         lda #2
         sta mcandcnt

         ;_wrtandtx initialisieren
         lda #"-"
         sta _wrtandtx+7
         sta _wrtandtx+8

         lda #<_wrtandtx
         sta $fb
         lda #>_wrtandtx
         sta $fc
         jsr printf

         ;cursor setzen
         clc
         ldx #5
         ldy #26
         jsr PLOT

mcandpt1 ;pc eingeben
         ;pc -> hh
         sta TempVar+1
         lda #<_hexkey
         sta $fb
         lda #>_hexkey
         sta $fc
         jsr waitkey
         jsr BSOUT
         dec mcandcnt
         bne mcandpt1
         sta TempVar+2
         ;pc -> ll
         lda #2
         sta mcandcnt
mcandpt11 sta TempVar+3
         lda #<_hexkey
         sta $fb
         lda #>_hexkey
         sta $fc
         jsr waitkey
         jsr BSOUT
         dec mcandcnt
         bne mcandpt11
         sta TempVar+4
         ;werte konvertieren
         lda TempVar+1
         jsr hextodec
         asl a
         asl a
         asl a
         asl a
         sta TempVar+1
         lda TempVar+2
         jsr hextodec
         ora TempVar+1
         sta _mc         ;hh (pc)
         lda TempVar+3
         jsr hextodec
         asl a
         asl a
         asl a
         asl a
         sta TempVar+3
         lda TempVar+4
         jsr hextodec
         ora TempVar+3
         sta _mc+1

         ;eingabestring wieder loeschen
         ldy #3         ;zaehler
         lda #<_wrtandtx
         sta $fb
         lda #>_wrtandtx
         sta $fc
         lda #<_LeerZ
         sta $fd
         lda #>_LeerZ
         sta $fe
mcandpt9 lda ($fb),y
         sta ($fd),y
         dey
         bpl mcandpt9
         ;ende-kz setzen
         lda #$00
         sta _LeerZ+9
         lda #<_LeerZ
         sta $fb
         lda #>_LeerZ
         sta $fc
         jsr printf
         ;ende-kz in _LeerZ loeschen
         lda #" "
         sta _LeerZ+9

        ;--- feldbeschreibung loeschen ---
                   lda #" "
                   sta _andbesch+4
                   sta _andbesch+5
                   sta _andbesch+6
                   lda #<_andbesch
                   sta $fb       
                   lda #>_andbesch
                   sta $fc       
                   jsr printf    

         rts

mcandcnt !byte $00
