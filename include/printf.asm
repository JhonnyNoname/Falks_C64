;---------------------------------------
; printf - die routine druckt einen
;          string aus. "$00" gibt das
;          ende des strings an
;
; in:
;    $fb/$fc -> adr. der variablenliste
;
;    var-listenaufbau (bytes)
;    a b cd e..e f
;    ! ! !  !    !
;    ! ! !  !    +- ende-kz ($00)
;    ! ! !  !
;    ! ! !  +------ ausgabezeichen
;    ! ! !
;    ! ! +--------- ausgabeposition
;    ! !             bs-codes
;    ! !               c/d -> bs-pos.
;    ! !             ascii
;    ! !               c -> x-pos (zeile 0-24)
;    ! !               d -> y-pos (spalte 0-39)
;    ! !
;    ! +----------- ausgabeart (aa)
;    !               0 = keine
;    !               1 = bs-codes
;    !               2 = ascii
;    !
;    +------------- debug-kennzeichen
;                    (damit lokalisiert
;                     werden kann, von
;                     wo die routine
;                     aufgerufen wurde)
;
; out:  accu -> anzahl geschr. chars
;
;     bei 0 (keine):
;       $fb/$fc = adr. d. fehlertextes
;
;---------------------------------------
printf
         ;anzahl der geschriebenen chars
         lda #$00
         sta prnanz

         ;leerer string?
         ldy #4
         lda ($fb),y
         bne prnpt000
         jmp prnfail0
prnpt000
         ;das 1. !byte beinhaltet ein kz
         ;um festzustellen, von wo der
         ;aufruf kommt.
         inc $fb
         bne prnpt001
         inc $fc
prnpt001

         ;bs oder ascii
         ldy #0
         lda ($fb),y
         bne prnpt010   ;ausgabeart
         jmp prnfail1
prnpt010 sta prntmp
         cmp #1         ;bs-code
         beq prnbs
         cmp #2         ;ascii-ausgabe
         beq prnasc
         ;fehler-rc setzen
         lda prntmp     ;falsche aa
         sta prnftxt1x
         lda #48
         clc
         adc prnftxt1x
         sta prnftxt1x
         jmp prnfail1

prnbs    ;bs-code - ausgabe
         ;--------------------
         lda $fb
         sta prnbstmp
         lda $fb
         sta prnbstmp+1
         lda #<prnbstxt
         sta $fb
         lda #>prnbstxt
         sta $fc

         lda #147
         jsr BSOUT

         jsr printf
         lda prnbstmp
         sta $fb
         lda prnbstmp+1
         sta $fb+1
         ;--------------------
         jmp printfend
;------ wenn prnbs fertig ------
;----- diesen teil loeschen ----
prnbstmp !byte 0,0
prnbstxt !byte $ff,2,0,0
         !text "die funktion <printf> "
         !text "unterstuetzt noch "
         !text "keine bs-ausgabe"
         !byte $00
         ;--------------------

prnasc   ;ascii - ausgabe
         inc $fb
         bne prn001
         inc $fc
prn001   lda ($fb),y
         tax
         iny
         lda ($fb),y
         tay
         ;cursor setzen
         clc
         jsr PLOT
         ;$fb/$fc auf daten setzen
         inc $fb
         bne prn002
         inc $fc
prn002   inc $fb
         bne prn003
         inc $fc
prn003
         ;pruefen auf ende-kz (#$00)
         ldy #0
         lda ($fb),y
         beq printfend   ;ja -> fertig
         jsr BSOUT
         inc prnanz      ;weiteres char
         jmp prn002      ;naechstes char
         ;--------------------
         jmp printfend   ;ende

         ;fehlertexte zuweisen
         ;====================
prnfail0 ;leerer string
         lda #<prnftxt0
         sta $fb
         lda #>prnftxt0
         sta $fc
         jsr printf
         jmp printfend   ;ende

prnfail1 ;falsche ausgabeart
         lda #<prnftxt1
         sta $fb
         lda #>prnftxt1
         sta $fc
         jsr printf
         jmp printfend   ;ende

printfend
         lda prnanz
         rts

prnanz    !byte $ff
prntmp    !byte $00

prnftxt0  !byte $fe,2,0,0
          !text "DER AUSZUGEBENDE TEXT BEGINNT MIT $00"
          !byte $00

prnftxt1  !byte $fd,2,0,0
          !text "DIE AUSGABEART "
prnftxt1x !byte 48
          !text " EXISTIERT NICHT!"
          !byte $00

