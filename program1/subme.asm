            .ORIG x3000

GO          AND R6, R6, #0 ; clear the negative checker
            ST R6, NUM11 ; set every number variable to zero
            ST R6, NUM12
            ST R6, NUM21
            ST R6, NUM22
            LEA R0, NL
            PUTS
            LEA R0, ESN
            PUTS

GET11       GETC
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz BRTHANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp GET11
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn GET11
            ST R0, NUM11

GET12       GETC
            ADD R1, R0, #-10 ; check if the input is a [LINE FEED]
            BRz SKIPX101
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz BRTHANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp GET12
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn GET12
            ST R0, NUM12

TIMES101    LD R0, NUM11
            AND R1, R1, #0   ; Clear R1
            ADD R1, R1, R0   ; 1 x R0
            ADD R1, R1, R0   ; 2 x R0
            ADD R1, R1, R0   ; 3 x R0
            ADD R1, R1, R0   ; 4 x R0
            ADD R1, R1, R0   ; 5 x R0
            ADD R1, R1, R0   ; 6 x R0
            ADD R1, R1, R0   ; 7 x R0
            ADD R1, R1, R0   ; 8 x R0
            ADD R1, R1, R0   ; 9 x R0
            ADD R1, R1, R0   ; 10 x R0
            ST R1, NUM11

            BRnzp SKIPX101

ESN         .STRINGZ "Enter Start Number (0-49): "
EEN         .STRINGZ "Enter End Number (0-49): "
DIFFMSG     .STRINGZ "The difference of the two numbers is: "
THXMSG      .STRINGZ "Thank you for playing!"
ERRORMSG    .STRINGZ "Error: A value is out of range!"
NL          .STRINGZ "\n"

POS48       .FILL #48
NEG48       .FILL #-48
NEG49       .FILL #-49
NEG57       .FILL #-57
NEG113      .FILL #-113
HYPHEN      .FILL #45

NUM11       .FILL #0
NUM12       .FILL #0
NUM21       .FILL #0
NUM22       .FILL #0

BRTHANKS    BRnzp THANKS
BRGO        BRnzp GO

SKIPX101    LEA R0, NL
            PUTS
            LEA R0, EEN
            PUTS

GET21       GETC
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz THANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp GET21
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn GET21
            ST R0, NUM21

GET22       GETC
            ADD R1, R0, #-10 ; check if the input is a [LINE FEED]
            BRz SUBTRACT
            OUT
            LD R1, NEG113
            ADD R1, R0, R1 ; check if input is "q"
            BRz THANKS
            LD R1, NEG57
            ADD R1, R0, R1 ; check if the input is <= 9
            BRp GET22
            LD R1, NEG48
            ADD R0, R0, R1 ; check if the input is >= 0, set R0 to the actual number
            BRn GET22
            ST R0, NUM22

TIMES102    LD R0, NUM21
            AND R1, R1, #0   ; Clear R1
            ADD R1, R1, R0   ; 1 x R0
            ADD R1, R1, R0   ; 2 x R0
            ADD R1, R1, R0   ; 3 x R0
            ADD R1, R1, R0   ; 4 x R0
            ADD R1, R1, R0   ; 5 x R0
            ADD R1, R1, R0   ; 6 x R0
            ADD R1, R1, R0   ; 7 x R0
            ADD R1, R1, R0   ; 8 x R0
            ADD R1, R1, R0   ; 9 x R0
            ADD R1, R1, R0   ; 10 x R0
            ST R1, NUM21

SUBTRACT    LD R1, NUM11
            LD R2, NUM12
            ADD R0, R1, R2 ; first number stored in R0
            LD R4, NEG49 ; check if the number is greater than 49
            ADD R4, R0, R4
            BRp ERROR
            LD R1, NUM21
            LD R2, NUM22
            ADD R3, R1, R2 ; second number stored in R3
            LD R4, NEG49 ; check if the number is greater than 49
            ADD R4, R3, R4
            BRp ERROR
            NOT R3, R3
            ADD R3, R3, #1 ; convert second number to negative
            ADD R0, R0, R3 ; difference stored in R0

NEGATIVE    BRzp SKIPFLIP
            ADD R6, R6, #1 ; set R6 to 1 if number is negative
            ADD R0, R0, #-1
            NOT R0, R0 ; flip the sign on R0, the difference

SKIPFLIP    AND R1, R1, #0 ; clear R1, use as loop counter
DIV10       ADD R1, R1, #1
            ADD R0, R0, #-10
            BRzp DIV10 ; if (R2 > 0) continue; else break;

            ADD R1, R1, #-1 ; R0 / 10 stored in R1
            ADD R2, R0, #10 ; R2 % 10 stored in R2

            LEA R0, NL
            PUTS
            LEA R0, DIFFMSG
            PUTS
            LD R3, POS48
            ADD R6, R6, #0 ; check if the difference is negative
            BRnz SKIPNEG
            LD R0, HYPHEN
            OUT
SKIPNEG     ADD R1, R1, #0 ; check if the tens digit is 0
            BRz SKIP0
            ADD R0, R1, R3
            OUT
SKIP0       ADD R0, R2, R3
            OUT

            LEA R0, NL
            PUTS
            BRnzp BRGO

ERROR       LEA R0, NL
            PUTS
            LEA R0, ERRORMSG
            PUTS
            LEA R0, NL
            PUTS
            BRnzp BRGO

THANKS      LEA R0, NL
            PUTS
            LEA R0, THXMSG
            PUTS
            LEA R0, NL
            PUTS

            HALT
