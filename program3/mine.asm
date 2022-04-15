;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                    ;
;              Anthony Du    ECE109                  ;
;                                                    ;
;            mine.asm    April 12, 2022              ;
;                                                    ;
;        Functions like a minesweeper game,          ;
;       where player enters coordinates to a         ;
;        location in a matrix of blocks and          ;
;        find out if there's an object there         ;
;                                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            .ORIG x3000
            ; clear screen
MAIN        JSR CLEAR
            ; display ASKXMSG
ASKX        LEA R0, ASKXMSG
            PUTS
            ; get the first digit of the first number
            LEA R6, NUM11
            JSR GETNUM1
            ; get the second digit of the first number
            LEA R6, NUM12
            JSR GETNUM12
            ; combine the two digits of the first number
            LEA R5, NUM11
            LEA R6, NUM12
            JSR TODBLDGT
            ; check if the combined number is less than 49
            LD R1, NUM11
            LD R2, NEG49
            ADD R1, R1, R2 ; number - 49
            BRp ASKX
            ; display ASKYMSG
ASKY        LEA R0, ASKYMSG
            PUTS
            ; get the first digit of the second number
            LEA R6, NUM21
            JSR GETNUM1
            ; get the second digit of the second number
            LEA R6, NUM22
            JSR GETNUM22
            ; combine the two digits of the second number
            LEA R5, NUM21
            LEA R6, NUM22
            JSR TODBLDGT
            ; check if the combined number is less than 49
            LD R1, NUM21
            LD R2, NEG49
            ADD R1, R1, R2 ; number - 49
            BRp ASKY
            ; check if the two numbers are both under 49
ENDASK      LEA R0, NL
            PUTS
            LEA R0, NL
            PUTS
            LEA R5, NUM11 ; NUM11 is now X
            LEA R6, NUM21 ; NUM12 is now Y
            JSR CHECKRANGE
            ; get 2^NUM11
            LD R1, NUM11
            ST R1, XCOORD ; copy NUM11 to XCOORD so it won't be messed up by TWOTOTHE
            LEA R6, NUM11
            JSR TWOTOTHE
            ; checks if object exists at the location
            LD R1, BITMAPORIG
            LD R2, NUM21
            ADD R1, R1, R2
            LDR R1, R1, #0
            LD R2, NUM11
            AND R1, R1, R2 ; clear every bit except for the wanted one
            BRz PAINTW ; if the bit is zero, paint white
            BRnp PAINTR ; if the bit is one, paint red

            ; paint red
PAINTR      LD R1, RED
            LEA R0, HIT
            PUTS
            BR PAINT
            ; paint white
PAINTW      LD R1, WHITE
            LEA R0, MISS
            PUTS
            BR PAINT
            ; calculate to find the pixels to paint on diaplay
PAINT       LD R4, XCOORD ; X coordinate
            LD R3, CANVASORIG
            AND R2, R2, #0
            ADD R2, R3, R4 ; 1
            ADD R2, R2, R4 ; 2
            ADD R2, R2, R4 ; 3
            ADD R2, R2, R4 ; 4
            ADD R2, R2, R4 ; 5
            ADD R2, R2, R4 ; 6
            ADD R2, R2, R4 ; 7
            ADD R2, R2, R4 ; 8
            ST R2, LOCATION
            LEA R6, NUM21 ; Y coordinate
            JSR TIMES1024
            LD R2, LOCATION
            LD R3, NUM21
            ADD R2, R2, R3 ; top left corner of the block
            ; paint an 8x8 block at the location
            JSR DRAWROW ; draw first row
            LD R3, YDOWN1
            ADD R2, R2, R3 ; move current coordinate down 1 row
            JSR DRAWROW ; draw row 2
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 3
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 4
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 5
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 6
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 7
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 8
            ; cycle done, go back to ask for another set of coordinates
            BR ASKX

            ; prints thanks message, exits game
THANKS      LEA R0, NL
            PUTS
            LEA R0, NL
            PUTS
            LEA R0, THANKSMSG
            PUTS
            AND R5, R5, #0
            ADD R5, R5, #15
THXOLOOP    AND R0, R0, #0
            ADD R0, R0, #14
THXILOOP    ST R5, NUM11
            ST R0, NUM21
            ; get 2^NUM11
            LD R1, NUM11
            ST R1, XCOORD ; copy NUM11 to XCOORD so it won't be messed up by TWOTOTHE
            LEA R6, NUM11
            JSR TWOTOTHE
            ; checks if object exists at the location
            LD R1, BITMAPORIG
            LD R2, NUM21
            ADD R1, R1, R2
            LDR R1, R1, #0
            LD R2, NUM11
            AND R1, R1, R2 ; clear every bit except for the wanted one
            BRnp THXPAINT ; if the bit is one, paint red
BK2LOOP     ADD R0, R0, #-1
            BRzp THXILOOP
            ADD R5, R5, #-1
            BRzp THXOLOOP

            HALT

THXPAINT    LD R1, BLUE
            LD R4, XCOORD ; X coordinate
            LD R3, CANVASORIG
            AND R2, R2, #0
            ADD R2, R3, R4 ; 1
            ADD R2, R2, R4 ; 2
            ADD R2, R2, R4 ; 3
            ADD R2, R2, R4 ; 4
            ADD R2, R2, R4 ; 5
            ADD R2, R2, R4 ; 6
            ADD R2, R2, R4 ; 7
            ADD R2, R2, R4 ; 8
            ST R2, LOCATION
            LEA R6, NUM21 ; Y coordinate
            JSR TIMES1024
            LD R2, LOCATION
            LD R3, NUM21
            ADD R2, R2, R3 ; top left corner of the block
            LDR R3, R2, #0
            LD R4, ANTIRED ; checks if the block is already red
            ADD R3, R3, R4
            BRz BK2LOOP
            ; paint an 8x8 block at the location
            JSR DRAWROW ; draw first row
            LD R3, YDOWN1
            ADD R2, R2, R3 ; move current coordinate down 1 row
            JSR DRAWROW ; draw row 2
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 3
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 4
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 5
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 6
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 7
            ADD R2, R2, R3 ; repeat
            JSR DRAWROW ; draw row 8
            ; cycle done, go back to ask for another set of coordinates
            BR BK2LOOP

ASKXBRG     BR ASKX
ASKYBRG     BR ASKY
ENDASKBRG   BR ENDASK

; list of variables:

NEG48       .FILL #-48 ; used to convert ascii to number
NEG49       .FILL #-49 ; used to check if the number is below 49
NEG57       .FILL #-57 ; used to check if a digit is <= 9
NEG113      .FILL #-113 ; used to check if input is "q"
POS1024     .FILL #1024 ; used when multiplying 1024

NL          .STRINGZ "\n"
HIT         .STRINGZ "HIT"
MISS        .STRINGZ "MISS"
BOGUSMSG    .STRINGZ "Bogus"
ASKXMSG     .STRINGZ "\n\nEnter X (0-15): "
ASKYMSG     .STRINGZ "\n\nEnter Y (0-14): "
THANKSMSG   .STRINGZ "Thank you for playing!"
TEMPR7      .BLKW #1 ; used for subroutines to store R7
NUM11       .BLKW #1 ; number 1 digit 1
NUM12       .BLKW #1 ; number 1 digit 2
NUM21       .BLKW #1 ; number 2 digit 1
NUM22       .BLKW #1 ; number 2 digit 2
XCOORD      .BLKW #1 ; used for temperarily storing the x coordinate

LOCATION    .BLKW #1 ; used for temperarily storing the location
YDOWN1      .FILL x0080 ; when added moves y down by 1, used for drawing a 7x7 area

BLACK       .FILL x0000 ; color black
RED         .FILL x7C00 ; color red
ANTIRED     .FILL x8400 ; negative of color red, used to check current color
WHITE       .FILL x7FFF ; color white
BLUE        .FILL x001F ; color blue

CANVASORIG  .FILL xC000 ; origin point of the canvas (top left)
CVSANTIEND  .FILL x0200 ; negative of the 1 point beyond the end point of the canvas

BITMAPORIG  .FILL x5000 ; the beginning of the bitmap

; below are the subroutines

; checks if R5 and R6 are under 15 and 14
CHECKRANGE  ST R7, TEMPR7
            LDR R1, R5, #0 ; load X coordinate
            LDR R2, R6, #0 ; load Y coordinate
            ADD R1, R1, #-15
            BRp BOGUS
            ADD R2, R2, #-14
            BRp BOGUS
            LD R7, TEMPR7
            RET
BOGUS       LEA R0, BOGUSMSG
            PUTS
            BR ASKXBRG

; clears the canvas
CLEAR       ST R7, TEMPR7
            LD R1, BLACK
            LD R2, CANVASORIG
            LD R3, CVSANTIEND
CLEARLOOP   STR R1, R2, #0 ; draw black on current pixel
            ADD R2, R2, #1 ; increment current coordinate by 1
            ADD R4, R2, R3 ; check if current coordinate is at the end of the canvas
            BRnp CLEARLOOP ; if false, continue the loop
            LD R7, TEMPR7
            RET



; gets the first digit of a number
GETNUM1     ST R7, TEMPR7
REGET1      GETC
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz THANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp REGET1
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn REGET1
            STR R0, R6, #0 ; the actual number (not ascii) is stored
            LD R7, TEMPR7
            RET

; gets the second digit of the first number
GETNUM12    ST R7, TEMPR7
REGET12     GETC
            ADD R1, R0, #-10 ; check if the input is a [LINE FEED]
            BRz ASKYBRG ; if so, skip straight to asking the second number
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz THANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp REGET12
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn REGET12
            STR R0, R6, #0 ; the actual number (not ascii) is stored
            LD R7, TEMPR7
            RET

; gets the second digit of the second number
GETNUM22    ST R7, TEMPR7
REGET22     GETC
            ADD R1, R0, #-10 ; check if the input is a [LINE FEED]
            BRz ENDASKBRG ; if so, skip straight to the end of the ask process
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz THANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp REGET22
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn REGET22
            STR R0, R6, #0 ; the actual number (not ascii) is stored
            LD R7, TEMPR7
            RET


; draws a row of 8 pixels after some initial coordinates
DRAWROW     ST R7, TEMPR7
            STR R1, R2, #0
            STR R1, R2, #1
            STR R1, R2, #2
            STR R1, R2, #3
            STR R1, R2, #4
            STR R1, R2, #5
            STR R1, R2, #6
            STR R1, R2, #7
            LD R7, TEMPR7
            RET



; multiplys R6 by 1024
TIMES1024   ST R7, TEMPR7
            LDR R4, R6, #0
            LD R2, POS1024
            AND R3, R3, #0
T1024LOOP   ADD R3, R3, R4
            ADD R2, R2, #-1
            BRp T1024LOOP
            STR R3, R6, #0
            LD R7, TEMPR7
            RET



; get 2 to the R6 power, used for matching a x coordinate in a bitmap
TWOTOTHE    ST R7, TEMPR7
            LDR R1, R6, #0 ; use as loop counter
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, #15
            BRz SKIPTTT
            AND R2, R2, #0 ; clear R2
            ADD R2, R2, #1 ; set R2 to 1
TTTLOOP     ADD R2, R2, R2 ; double R2
            ADD R1, R1, #-1
            BRp TTTLOOP
            STR R2, R6, #0
            LD R7, TEMPR7
SKIPTTT     RET


; gets two digits from R5 and R6 and turn them into a single two digit number and store it in R5
TODBLDGT    ST R7, TEMPR7
            LDR R1, R5, #0 ; load the number to be multiplied to R1
            LDR R2, R6, #0 ; load the number to be added to R2
            AND R3, R3, #0 ; Clear R3
            ADD R3, R3, R1 ; 1
            ADD R3, R3, R1 ; 2
            ADD R3, R3, R1 ; 3
            ADD R3, R3, R1 ; 4
            ADD R3, R3, R1 ; 5
            ADD R3, R3, R1 ; 6
            ADD R3, R3, R1 ; 7
            ADD R3, R3, R1 ; 8
            ADD R3, R3, R1 ; 9
            ADD R3, R3, R1 ; 10
            ADD R3, R3, R2 ; add the 10^0 digit
            STR R3, R5, #0 ; store the result to lable LEA'd in R5
            LD R7, TEMPR7
            RET

            .END
