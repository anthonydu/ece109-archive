# Program 1: subme.asm

This LC-3 assembly language program will subtract two values entered by the user.

## Details

The program must start at address x3000. Here’s how the program must behave:

1. The program sends a newline to the console and then prints “Enter Start Number (0-49):
serves as a prompt to tell the user that the program is waiting for input. The prompt string is a string, followed by a single space.

2. The user types a one- or two-digit number (0-49) on the keyboard. As the numbers are typed on the keyboard they should be echoed onto the console window. Any illegal input values are ignored after they are echoed. The program must check and accept only numerical digits. The program should recognize the entry as complete if it sees: [a] 1 valid digit plus a return, or [b] 2 valid digits, return not checked here.

3. The program sends a newline to the console and then prints “Enter End Number (0-49): ”, which serves as a prompt to tell the user that the program is waiting for input. The prompt string is a string, followed by a single space.

4. The user types a one- or two-digit number (0-49) on the keyboard. As the numbers are typed on the keyboard they should be echoed onto the console window. Any illegal input values are ignored after they are echoed. The program must check and accept only numerical digits. The program should recognize the entry is complete if it sees: [a] 1 valid digit plus a return, or [b] 2 valid digits, return not checked here.

5. If the user types the character “q” at any time the program should display a newline and the string “Thank you for playing!” and then Halt.

6. The program will subtract the first number minus the second number, of the values that have been entered on the keyboard. The program then converts this binary difference to a two-digit decimal number and converts the digits to ASCII code. A negative sign must be shown for a negative result.

7. The program sends a newline to the console and then prints the following on the console:

   `The difference of the two numbers is: zz`

   where zz is the two-digit sum. A linefeed (newline) is printed at the end of the string. (Your code will not print in boldface, of course; that’s just used for emphasis here.) Leading zeroes shall NOT be printed in the value.

8. The program returns to step 1.

Subroutines (the JSR instruction) are not allowed for this assignment.

## Example Runs

_Example run:_

```
Enter First Number (0-49): 30

Enter Second Number (0-49): 10

The difference of the two numbers is: 20
```

_Another example run:_

```
Enter First Number (0-49): 15

Enter Second Number (0-49): 30

The difference of the two numbers is: -15
```

_Another example run:_

```
Enter First Number (0-49): 15 

Enter Second Number (0-49): q 

Thank you for playing!
```

_Another example run:_

```
Enter First Number (0-49): 4xd5

Enter Second Number (0-49): wr3dq0

The difference of the two numbers is: 15
```

_Another example run:_

```
Enter First Number (0-49): 4

Enter Second Number (0-49): 4

The difference of the two numbers is: 0
```

_Another example run:_

```
Enter First Number (0-49): 75 

Enter Second Number (0-49): 30 

Error: A value is out of range!
```
