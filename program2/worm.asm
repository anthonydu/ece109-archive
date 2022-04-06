;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                    ;
;              Anthony Du    ECE109                  ;
;                                                    ;
;            worm.asm    April 6, 2022               ;
;                                                    ;
;         A program that draws on a canvas           ;
; with a color of your choosing from the 5 provided, ;
;   paint brush is controled with w,a,s,d keys       ;
;                on the keyboard.                    ;
;                                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




            .ORIG x3000

            BR DRAWPIXEL

GETINPUT    GETC
            LD R1, SPACE
            ADD R2, R0, R1 ; check space - white
            BRz SPACED
            LD R1, LINEFEED
            ADD R2, R0, R1 ; check line feed - clear
            BRz ENTERED
            LD R1, LOWERA
            ADD R2, R0, R1 ; check letter a - move left
            BRz APRESSED
            ADD R1, R1, #-1
            ADD R2, R0, R1 ; check letter b - blue
            BRz BPRESSED
            ADD R1, R1, #-2
            ADD R2, R0, R1 ; check letter d - move right
            BRz DPRESSED
            ADD R1, R1, #-3
            ADD R2, R0, R1 ; check letter g - green
            BRz GPRESSED
            ADD R1, R1, #-10
            ADD R2, R0, R1 ; check letter q - quit
            BRz QPRESSED
            ADD R1, R1, #-1
            ADD R2, R0, R1 ; check letter r - red
            BRz RPRESSED
            ADD R1, R1, #-1
            ADD R2, R0, R1 ; check letter s - move down
            BRz SPRESSED
            ADD R1, R1, #-4
            ADD R2, R0, R1 ; check letter w - move up
            BRz WPRESSED
            ADD R1, R1, #-2
            ADD R2, R0, R1 ; check letter y - yellow
            BRz YPRESSED
            BR GETINPUT







WPRESSED    LD R1, LOCATION
            LD R2, YUP4
            ADD R1, R1, R2
            LD R3, ANTIORIG
            ADD R3, R1, R3 ; if goes beyond the origin (coord - orig = negative)
            BRn NEXTCOLOR ; skip setting new location, change color, draw, and get new input
            ST R1, LOCATION ; else set new location and keep going
            BR DRAWPIXEL

APRESSED    LD R1, LOCATION
            ADD R1, R1, #-4
            LD R3, LAST8
            AND R2, R1, R3 ; clear every bit except for the last 8
            LD R3, NEGxFC
            ADD R2, R2, R3 ; if the last two digit is exactly xFC, change color
            BRz NEXTCOLOR
            ST R1, LOCATION ; else set new location and keep going
            BR DRAWPIXEL

SPRESSED    LD R1, LOCATION
            LD R2, YDOWN4
            ADD R1, R1, R2
            LD R3, CANVASEND
            ADD R3, R1, R3 ; if goes beyond the end (coord - end = zero/positive)
            BRzp NEXTCOLOR ; skip setting new location, change color, draw, and get new input
            ST R1, LOCATION
            BR DRAWPIXEL

DPRESSED    LD R1, LOCATION
            ADD R1, R1, #4
            LD R3, LAST8
            AND R2, R1, R3 ; clear every bit except for the last 8
            LD R3, NEGx80
            ADD R2, R2, R3 ; if the last two digit is exactly x80, change color
            BRz NEXTCOLOR
            ST R1, LOCATION
            BR DRAWPIXEL

RPRESSED    LD R1, RED
            ST R1, COLOR
            BR DRAWPIXEL

GPRESSED    LD R1, GREEN
            ST R1, COLOR
            BR DRAWPIXEL

BPRESSED    LD R1, BLUE
            ST R1, COLOR
            BR DRAWPIXEL

YPRESSED    LD R1, YELLOW
            ST R1, COLOR
            BR DRAWPIXEL

SPACED      LD R1, WHITE
            ST R1, COLOR
            BR DRAWPIXEL

ENTERED     LD R1, BLACK
            LD R2, CANVASORIG
            LD R3, CANVASEND
CLEARLOOP   STR R1, R2, #0 ; draw black on current pixel
            ADD R2, R2, #1 ; increment current coordinate by 1
            ADD R4, R2, R3 ; check if current coordinate is at the end of the canvas
            BRz DRAWPIXEL ; if true, break the loop
            BR CLEARLOOP ; if false, continue the loop







DRAWPIXEL   LD R1, COLOR
            LD R2, LOCATION
            JSR DRAWROW ; draw first row
            LD R3, YDOWN1
            ADD R2, R2, R3 ; move current coordinate down 1 row
            JSR DRAWROW ; draw second row
            LD R3, YDOWN1
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw third row
            LD R3, YDOWN1
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw forth row
            BR GETINPUT

DRAWROW     STR R1, R2, #0
            STR R1, R2, #1
            STR R1, R2, #2
            STR R1, R2, #3
            RET





NEXTCOLOR   LD R1, COLOR
            LD R2, ANTIRED
            ADD R2, R1, R2 ; red to green
            BRz GPRESSED
            LD R2, ANTIGREEN
            ADD R2, R1, R2 ; green to blue
            BRz BPRESSED
            LD R2, ANTIBLUE
            ADD R2, R1, R2 ; blue to yellow
            BRz YPRESSED
            LD R2, ANTIYELLOW
            ADD R2, R1, R2 ; yellow to white
            BRz SPACED
            LD R2, ANTIWHITE
            ADD R2, R1, R2 ; white to red
            BRz RPRESSED
            BR DRAWPIXEL






QPRESSED    HALT







SPACE       .FILL xFFE0 ; negative of ascii code of space
LINEFEED    .FILL xFFF6 ; negative of ascii code of line feed
LOWERA      .FILL xFF9F ; negative of ascii code of lower case a

RED         .FILL x7C00 ; color red
ANTIRED     .FILL x8400 ; negative of color red, used to check current color

GREEN       .FILL x03E0 ; color green
ANTIGREEN   .FILL xFC20 ; negative of color green, used to check current color

BLUE        .FILL x001F ; color blue
ANTIBLUE    .FILL xFFE1 ; negative of color blue, used to check current color

YELLOW      .FILL x7FED ; color yellow
ANTIYELLOW  .FILL x8013 ; negative of color yellow, used to check current color

WHITE       .FILL x7FFF ; color white
ANTIWHITE   .FILL x8001 ; negative of color white, used to check current color

BLACK       .FILL x0000 ; color black
COLOR       .FILL x7FFF ; initial/current color

LOCATION    .FILL xE440 ; initial/current location
YUP4        .FILL xFE00 ; when added moves y up by 4, used for upward movement
YDOWN1      .FILL x0080 ; when added moves y down by 1, used for drawing a 4x4 area
YDOWN4      .FILL x0200 ; when added moves y down by 4, used for downward movement

CANVASORIG  .FILL xC000 ; origin point of the canvas (top left)
ANTIORIG    .FILL x4000 ; negative of the origin, used to check if location is out of the canvas
CANVASEND   .FILL x0200 ; negative of the 1 point beyond the end point of the canvas,
                        ; used to check if location is out of the canvas and in clear function

LAST8       .FILL x00FF ; when anded removes all digits other than the last 8
NEGxFC      .FILL xFF04 ; used to check if a value is equal to xFC, 1 point before the left most
NEGx80      .FILL xFF80 ; used to check if a value is equal to x80, 1 point after the right most

            .END
