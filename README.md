fast_float_32_avr
=================

32 bit floating point math implementation optimized for AVR microcontrollers

When developing applications on embedded systems, the computational power of microcontrollers is a limiting factor.
This software is an implementation of floating point numbers wich allows the user to make basic 
operations on float type faster than using the compiler implementation on an AVR micocontroller.
I developed this library to increase computation possibilities on microcontrollers, more specifically, to allow faster digital signal processing.

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
2-Run with `make`

Using this software as a library in your project<br/>
1-Copy the FastFloat files (FastFloat.h, FastFloat.cpp, FastFloat_Assembly.S) in your project<br/>
2-Add the .cpp and the .S in the objects of the makefile (or use the provided makefile)

The software may be used with the arduino environment<br/>
Including the FastFloat software as a library in the arduino environment<br/>
1-Copy the FastFloat files in your arduino library folder (Only the FastFloat.cpp, FastFloat_Assembly.S and the FastFloat.h files). The instructions for a manual installation are found at
this link : http://arduino.cc/en/Guide/Libraries<br/>
2-Include the library in your sketch and use it!<br/>

The provided main.cpp is an exemple that allows to test FastFloat class' function.
This software use a serial port to interface with my computer.

===============

Compatibility:

Since most of the software is programmed in assembly, the compatibility may be limited.
Since the atmega and the atxmega microcontrollers (used by most arduino microcontrollers) 
all provide the required instruction set as the one tested, they should work.
The library is compatible on AVR based arduinos, such as arduino UNO.

===============

Performance:

The performances of this software are compared with the default float type implementation from avr-gcc 4.8.1
The microcontroller counter is used to compute the execution time. The table show the number of clock cycle required
to execute the operation, including acces to memory. Since the execution time of
a float operation vary in each case, the \# clock cycle is an average of 256 operations with random numbers.

<MTMarkdownOptions output='html4'>
    <table border="1">
    <tr>
    <th>operation</th>
    <th>FastFloat</th>
    <th>avr-gcc</th>
    </tr>
    <tr>
    <td>addition</td>
    <td>68.2</td>
    <td>149.0</td>
    </tr>
    <tr>
    <td>soustraction</td>
    <td>75.2</td>
    <td>151.7</td>
    </tr>
    <tr>
    <td>multiplication</td>
    <td>66.8</td>
    <td>152.2</td>
    </tr>
    <tr>
    <td>division</td>
    <td>236.1</td>
    <td>494.4</td>
    </tr>
    </table>
</MTMarkdownOptions>



