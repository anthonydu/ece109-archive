# Program 3: mines.asm

This program is a simplified mine sweeper game. Or at least part of such a game. The user tries to find hidden objects by specifying X-Y coordinates. The result of the choice is shown on the video display – a red box for a “hit” and a white box for a “miss”.

In this case, the special addresses that contain hidden objects are represented by a bitmap that is loaded into memory before the program begins.

## Detailed Description

### The Playing Board: Pixels vs. Blocks

Instead of individual pixels, the X-Y coordinates in this game represent 8x8 blocks of the video display. Block (0,0) is the top left corner of the display. (In pixel coordinates, its four corners are (0,0), (7,0), (7,7), and (0,7).)

There are16 blocks in the horizontal direction. (128/8 = 16)

There are 15 blocks in the vertical direction. (124/8 = 15.5) The bottom two pixel rows of the display are unaffected and will always be black during this program.

The unit of drawing for this program is the block. All of the pixels in a given block will always be the same color.

### The Hidden Objects: Bitmap

Some of the blocks contain hidden objects. (E.g., a mine) The locations of these blocks is represented by a “bitmap” – a data structure in which one bit is allocated per block, and that block is “1” if an object is present, and “0” if no object is present.

Bitmap:

The bitmap starts at location x5000. There is one 16-bit word for each row of the display. The first word (16 bits) represents the top row (16 blocks) of the display. The leftmost bit (15) represents the leftmost block of that row. The rightmost bit (0) represents the rightmost block.

Example:
 - Bitmap word for row 0 is `1001000001000001`.
 - This means that blocks (0,0), (3,0), (9,0), and (15,0) contain objects.
  Since there are 15 rows of blocks, that means there are 15 words in the bitmap. You must load a bitmap object file into memory before playing the game.

## Files Provided

We are providing several object (.obj) files, which you can download from the Programming Assignments page on the Moodle site.

The required file is p3os.obj The OS file is the same one from Program 2.

Two other files are sample bitmaps for use in debugging your code. The evenrows.obj file includes a bitmap where every block on even rows (0, 2, 4, ...) is set to 1. The oddcols.obj file is a bit map where every block in odd columns (1, 3, 5, ...) is set to 1. The file random.obj will be the final test for your code.

## Implementation

You must implement your program as a single file: mines.asm. You are required to use at least six (6) subroutines in your program. You may use more, as many as you like. The choice of subroutines is up to you, but there are several obvious candidates: paint a block, get coordinates from user, check the bitmap for a given block, clear the screen, compute the pixel address of a given block, etc.

Subroutines are used to modularize your code. Separate it into manageable pieces. As you write a subroutine, you should also write some code to test that routine on its own. Once you know that a subroutine works, then you can move on to implement and test some other parts of the program. (When there’s a bug, you can be fairly confident that the problem is with the new code, since you’ve already tested and debugged the earlier subroutines.)

You must define the interface for each subroutine. What does the caller pass in? What does the caller get back? This interface must be documented in your code via comments. Each subroutine must have a comment header that describes what the subroutine does and how to use it. Lack of documentation will cause you to lose points.

### Details of User Interface

Each user “turn” will use one line of the console display.

 - The program starts by clearing the screen to black.

 - The program will prompt for the X-coordinate with “\n\nEnter X (0-15): ” (note spaces after the colon sign).

 - The user types a one- or two-digit number (0-49) on the keyboard. As the numbers are typed on the keyboard they should be echoed onto the console window. Any illegal input values are ignored after they are echoed. The program must check and accept only numerical digits. The program should recognize the entry as complete if it sees: [a] 1 valid digit plus a return, or [b] 2 valid digits, return not checked here.

 - The program will prompt for the X-coordinate with “\n\nEnter Y (0-14): ” (note spaces after the colon sign).

 - The user types a one- or two-digit number (0-49) on the keyboard. As the numbers are typed on the keyboard they should be echoed onto the console window. Any illegal input values are ignored after they are echoed. The program must check and accept only numerical digits. The program should recognize the entry is complete if it sees: [a] 1 valid digit plus a return, or [b] 2 valid digits, return not checked here.

 - The program will print two Line Feed (x0A) characters after the number.

 - If the user types the character “q” at any time the program should display a newline and the

string “Thank you for playing!” and then Halt.

 - If either coordinate is out of range (X greater than 15, or Y greater than 14), the program prints “Bogus” and goes back to the first step.

 - If the specified block contains a hidden object, the program colors the block red, then prints “HIT” and goes back to the reading the next X/Y coordinates.

 - If the specified block does not contains a hidden object, the program colors the block white, then prints “MISS” and goes back to the reading the next X/Y coordinates.

Entering ‘q’ is the only way to end the game. Even if all of the blocks have been painted white/red, the game keeps going. We do not detect this case, and we do not detect a “win” when all hidden objects have been found. This is to simplify the program – you can implement added features on your own time!

Example console output, assuming the evenrows.obj bitmap has been loaded: Enter X (0-15): 12

```
Enter Y (0-14): 11

HIT

Enter X (0-15): 8 

Enter Y (0-14): 6 

HIT

Enter X (0-15): 11 

Enter Y (0-14): 9 

MISS

Enter X (0-15): 12

Enter Y (0-14): 43

Bogus

Enter X (0-15): 12

Enter Y (0-14): q

Thank you for playing!
```
