;---------------------------------------
; OPCDSRCH - DIE ROUTINE SUCHT DIE
;            ADRESSE DES BEFEHLS AUS DER
;            OPCODE.DAT - LISTE
;
;    IN:   AKKU (BEFEHL)
;
;    OUT:  $FB/$FC (ADRESSE DER BEFEHLS-
;                   BESCHREIBUNG)
;---------------------------------------
opcdsrch
                ;--- Vorbereitungen ---
                   sta opcodevgl ;--- Befehl retten
opcdpt001
                ;--- Bef-Beschreibungs-Adresse nach $FB/$FC bringen
                   lda #<opcddat 
                   sta $fb       
                   lda #>opcddat 
                   sta $fc       

opcdpt002       ;--- Befehl in der Liste suchen
                   ldx _befanz    
opcdpt022          ldy #0
                   lda ($fb),y   
                   cmp opcodevgl 
                   beq opcdpt020 ;--- Befehl gefunden
                   clc           ;--- naechster Bef. suchen
                   lda #opcddatln-opcddat
                   adc $fb       
                   sta $fb       
                   bcc opcdpt021 
                   inc $fc       
opcdpt021          dex
                   beq opcdpt019 ;--- Bef. definiti nicht in der Liste
                   bne opcdpt022 
opcdpt019          lda #<opcdNoBef
                   sta $fb       
                   lda #>opcdNoBef
                   sta $fc       
opcdpt020       ;--- Inhalt v. $FB/$FC => Adr. v. BefDefinition
opcodesrchend
                   rts

opcodevgl       !byte 0  ;--- gesuchter OP-Code
