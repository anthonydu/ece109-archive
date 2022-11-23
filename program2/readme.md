# Program 2: worm.asm

For this assignment, you will write a program that draws lines on PennSim’s graphic display, similar to an Etch A Sketch. These lines will look like a worm on the screen. The program user will be able to “drag” a point in an up-down or left-right direction to draw a line, and will be able to change the color of the line that is being drawn. When the head of the worm contacts the boundary of the graphics screen it will not go over, but will change color.
The learning objectives for this assignment are:

 - Use load and store instructions to manipulate the content of memory.

 - Use I/O routines to allow a user to interact with the program.

## Program Specification
The program must start at address x3000.

The program will manipulate the location of a point on the screen, which we will call the Pen. The Pen is a wide-tip, it covers 4 by 4 pixels and appears as a box. The Pen has a color and a location. The screen pixel at the Pen’s current location will take on the Pen’s color. When the Pen moves, the pixels at the previous location retains its color. In other words, moving the Pen will draw a wide line of a particular color.

The PennSim graphics display (the “screen”) is 128 by 124 pixels. We use an (x, y) coordinate system to describe a location on the screen. Location (0, 0) is the top left corner. The x coordinate increases as we move to the right, and the y coordinate increases as we move down. In other words, (1, 0) is one pixel to the right of (0, 0), and location (0, 1) is one pixel below (0, 0). Location (127, 123) is the bottom right corner of the screen. Our pen moves 4 pixels at a time, in any direction.

When the program begins, the Pen location must be set to (64, 62) and the color must be White.

If the user attempts to move the pen past any edge of the screen, the pen will not move. When this happens the pen will change color to the next color in the table order below: r, g, b, y, w and back to red.

The user interacts with the program using one-character commands. The commands are typed on the keyboard, but are not printed to the console display. Nothing will be printed to the console during the execution of this program. The program will wait for a keystroke, perform the corresponding command, and repeat. If the keystroke does not correspond to a legal command, it will have no effect.

There are four commands for changing the location of the Pen. We use the WASD scheme of navigation, used by various computer games:

| Command Character | Action                                                                                                                                                |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| w                 | _Move up four pixels._<br>Location changes from (x, y) to (x, y-4).<br>If the Pen is at the top border of the screen, the command has no effect.      |
| a                 | _Move left four pixels._<br>Location changes from (x, y) to (x-4, y).<br>If the Pen is at the left border of the screen, the command has no effect.   |
| s                 | _Move down four pixels._<br>Location changes from (x, y) to (x, y+4).<br>If the Pen is at the bottom border of the screen, the command has no effect. |
| d                 | _Move right four pixels._<br>Location changes from (x, y) to (x+4, y).<br>If the Pen is at the right border of the screen, the command has no effect. |

There are five commands for changing the Pen color:

| Command Character | Action                    |
|-------------------|---------------------------|
| r                 | Change color to _Red_.    |
| g                 | Change color to _Green_.  |
| b                 | Change color to _Blue_.   |
| y                 | Change color to _Yellow_. |
| space             | Change color to _White_.  |

There are two additional commands:

| Command Character | Action                                                                                           |
|-------------------|--------------------------------------------------------------------------------------------------|
| return            | _Clear the screen._<br>Paint all pixels black, except the Pen location, which retains its color. |
| q                 | _Quit._<br>The simulated machine must stop running.                                              |

## Details

The PennSim graphics display is bit-mapped, meaning that each pixel has a corresponding memory location. The content of that memory location controls the color of the pixel.

### Pixel Addresses

Addresses xC000 through xFDFF are assigned to the graphics display. The low address corresponds to the top left corner (0, 0). Moving one pixel to the right adds one to the address, and it “wraps around” to the next row when it gets to the right edge. Since the display is 128 pixels wide, this means that moving down one pixel is equivalent to adding 128 to the address.

The address of point (x, y) can be calculated as: xC000 + x + 128y.

For this assignment, you will not need to calculate arbitrary pixel addresses, except to figure out where the initial location (64, 62) is. You will be moving left (-1), right (+1), up (-128) or down (+128) from the current address.

You will, however, need to recognize when the Pen is at an edge of the display, so that you don’t go beyond the edge.
