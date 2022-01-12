;---------------------------------------
; C64 - Konstanten
;---------------------------------------
COLOR_BLACK         = $00          ;schwarz   
COLOR_WHITE         = $01          ;weiss
COLOR_RED           = $02          ;rot       
COLOR_CYAN          = $03          ;tuerkis    
COLOR_PURPLE        = $04          ;lila      
COLOR_GREEN         = $05          ;gruen      
COLOR_BLUE          = $06          ;blau      
COLOR_YELLOW        = $07          ;gelb      
COLOR_ORANGE        = $08          ;orange    
COLOR_BROWN         = $09          ;braun     
COLOR_PINK          = $0A          ;rosa      
COLOR_DARKGREY      = $0B          ;dunkelgrau
COLOR_GREY          = $0C          ;grau      
COLOR_LIGHTGREEN    = $0D          ;hellgruen  
COLOR_LIGHTBLUE     = $0E          ;hellblau  
COLOR_LIGHTGREY     = $0F          ;hellgrau  

;---------------------------------------
; Joystick
;---------------------------------------
INPUT_NONE          = $00
INPUT_JOY1          = $01
INPUT_JOY2          = $02
JOY_UP              = %00000001    ;Joystick rauf
JOY_DOWN            = %00000010    ;Joystick runter
JOY_LEFT            = %00000100    ;Joystick links
JOY_RIGHT           = %00001000    ;Joystick rechts
JOY_FIRE            = %00010000    ;Joystick FEUER!

;---------------------------------------
; SPEICHER
;---------------------------------------
PENCOL              = $0286         ;CURSORFARBE
PENHGCOL            = $0287         ;CURSORFARBE-HG
;---------------------------------------
; VIC-II
;---------------------------------------
VICBasisAdr         = $d000         ;Basisadr. v. VIC-II
EABase              = $d000         ;E/A Basisadr.
CharRomAddr         = $d000
CIA1_A              = $DC00         ;Adresse des CIA1-A
CIA1_B              = $DC01         ;Adresse des CIA1-B
CIA2_A              = $dd00         ;Adresse des CIA2-A

BSCOL               = $D021         ;SCREENFARBE
FRAMECOL            = $D020         ;RAHMENFARBE
SCREENBASE          = $0400         ;BILDSCHIRMSPEICHER
COLORBASE           = $D800         ;Beginn des Farbspeichers

;---------------------------------------
; SPRITES
;---------------------------------------
SpriteBlk01     = 64*01
SpriteBlk02     = 64*02
SpriteBlk03     = 64*03
SpriteBlk04     = 64*04
SpriteBlk05     = 64*05
SpriteBlk06     = 64*06
SpriteBlk07     = 64*07
SpriteBlk08     = 64*08
SpriteBlk09     = 64*09
SpriteBlk10     = 64*10
SpriteBlk11     = 64*11
SpriteBlk12     = 64*12
SpriteBlk13     = 64*13
SpriteBlk14     = 64*14
SpriteBlk15     = 64*15
SpriteBlk16     = 64*16
SpriteNr        = $07f8         ;SpritedatenZeiger

;---------------------------------------
; ASM - Befehle
;---------------------------------------
ASM_BRK         = $00
ASM_JMP         = $4c
ASM_JSR         = $20
ASM_NOP         = $EA