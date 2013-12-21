fast_float_32_avr
=================

32 bit floating point math implementation optimized for AVR microcontrollers

This software is an implementation of floating point numbers wich allows the user to make basic 
operations on an AVR micocontroller.

=================

I test the software on a atmega328 running at 8mhz. <br/>
To compile the software, I use the CrossPack toolchain : http://www.obdev.at/products/crosspack/index.html<br/>
I use a modified version of the makefile provided by CrossPack. <br/>
To program the memory of the microcontroller, 
I use another microcontroller acting as an AVRISP : http://arduino.cc/en/Tutorial/ArduinoISP

================

Instructions:

Running the main.cpp to test the software<br/>
1-Enter the makefile's folder in terminal<br/>
2-Run with `make all`

The software may be used with the arduino environment<br/>
Including the FastFloat software as a library in the arduino environment<br/>
Follows the instructions for a manual installation at this link : http://arduino.cc/en/Tutorial/ArduinoISP
Warning: Copy only the FastFloat files in the library folder (FastFloat.h, FastFloat.cpp, FastFloat_Assembly.S)

The provided main.cpp is an exemple that allows to test FastFloat class' function.
This software use a serial port to interface with my computer.

===============

Compatibility:

Since most of the software is programmed in assembly, the compatibility may be limited.
Since the atmega and the atxmega microcontrollers (used by the arduino microcontrollers) 
all use the same instruction set as the one tested, they should work.

===============

Future work:

Some functions are declared but are not programmed yet. I plan on enlarging the functions avalaible.

