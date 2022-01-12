;---------------------------------------
; die routine schreibt den mem-dump an
;
; !!! in der jetzigen form werden  !!!
; !!! keine ascii-codes ausgegeben !!!
;
; in:
;    $fb/$fc -> adr. der variablenliste
;
;    var-listenaufbau (bytes)
;    ab c
;    !  !
;    !  +------ anzahl der durchlaeufe
;    !
;    +--------- bs-position  a -> x-pos
;                            b -> y-pos
;---------------------------------------
memout   ;parametervariablen sichern
         ;==========================
         ldy #0
         lda ($fb),y      ;x-pos
         sta mmdmpstr+2
         iny
         lda ($fb),y      ;y-pos
         sta mmdmpstr+3
         iny
         lda ($fb),y      ;durchlaeufe
         sta mmotdl
         lda _mc           ;mc holen und
         sta mmotmc       ; - int. saven
         sta mmotasci     ; - ascii
         lda _mc+1
         sta mmotmc+1     ; - int. saven
         sta mmotasci+1   ; - ascii

mmotpt00 ;string aufbereiten
         ;==================
         lda #<mmdmpreg  ;adresse
         sta mmotaa+1      ; der
         lda #>mmdmpreg ; mem-inhalte
         sta mmotaa
         lda #7           ;anzahl d.
         sta mmotanz      ; mem-inhalte

         ;adresse
         ;=======
         lda mmotmc       ;hh-byte
         jsr dectohex     ;byte konvert.
         ldy #0
         lda ($fb),y      ;x---
         sta mmdmpstr+5
         iny
         lda ($fb),y      ;-x--
         sta mmdmpstr+6
         lda mmotmc+1     ;ll-byte
         jsr dectohex     ;byte konvert.
         ldy #0
         lda ($fb),y      ;--x-
         sta mmdmpstr+7
         iny
         lda ($fb),y      ;---x
         sta mmdmpstr+8

mmotpt01 ;memory-inhalt
         ;=============
         lda mmotmc+1     ;in mmotmc
         sta $fb          ; steht der
         lda mmotmc       ; akt. mc
         sta $fc
         ldy #0
         lda ($fb),y
         jsr dectohex     ;wert konvert.
         lda mmotaa       ;li-halbbyte
         sta $fd+1
         lda mmotaa+1
         sta $fd
         ldy #0
         lda ($fb),y
         sta ($fd),y
         iny
         lda ($fb),y
         sta ($fd),y

         ;adressen erhoehen
         ;=================
         lda mmotmc+1     ;ll-byte
         clc
         adc #1
         sta mmotmc+1
         lda #0
         adc mmotmc       ;hh-byte
         sta mmotmc
         lda #3           ;adresse
         clc              ; fuer
         adc mmotaa+1     ; mem-inhalt
         sta mmotaa+1     ; um
         lda #0           ; distanz-wert
         adc mmotaa       ; erhoehen
         sta mmotaa

         ;alle werte (mem-inhalte)
         ;========================
         dec mmotanz
         bpl mmotpt01

         ;vorbereiteter string ausgeben
         ;=============================
         lda #<mmdmpstr
         sta $fb
         lda #>mmdmpstr
         sta $fc
         jsr printf

         ;alle durchlaeufe? (zeilen)
         ;==========================
         dec mmotdl
         beq mmotrts
         inc mmdmpstr+2
         jmp mmotpt00

mmotrts  rts

mmotmc   !byte $00,$00 ;hh/ll
mmotasci !byte $00,$00 ;hh/ll
mmotanz  !byte $00     ;ausgabe-anzahl
mmotdl   !byte $00     ;durchlauefe

mmdmpstr !byte 0,2     ;debug / ascii
         !byte 0,0     ;x-pos / y-pos
         !text "$----  "
mmdmpreg !text "-- -- -- -- "
         !text "-- -- -- -- "
         !text " --------"
         !byte $00     ;ende-kz

mmotaa   !byte $00,$00 ;hh/ll mem-inh.

