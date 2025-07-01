# VGA for Sipeed Tang Primer 25K

This project contains minimum VHDL code for implementing a VGA video adapter on the Tang Primer 25K FPGA development board.
It is designed for use with either the Mouse Lab PMOD-VGA v1.1 or the Digilent PmodVGA adapter.
The adapter uses connectors J5 and J6, which are the ones closest to the USB Type-A port.


<br/><br/>
<img src="https://raw.githubusercontent.com/MatrixMKII/SipeedTangPrimer25k/refs/heads/main/VGA640x480_60Hz/pics/TangPrimer25K.jpg" width="50%"/>

###### Tang Primer 25K

<br/><br/>
<img src="https://raw.githubusercontent.com/MatrixMKII/SipeedTangPrimer25k/refs/heads/main/VGA640x480_60Hz/pics/MuseLab-PMOD-VGA.webp" width="50%"/>

###### Muse LAB PMOD-VGA
<br/><br/>

## Minimal VGA Implementation

This is a basic working implementation of VGA, providing only:

   * Horizontal and vertical sync signals
   * Simple test pattern output

Planned Features and Future Improvements:

   * Frame buffer for pixel data storage
   * Text generator for character display
   * SPI and/or I2C interface for communication with external devices
   * Intended for use with microcontrollers such as ESP32 or Arduino
   
<br/><br/>

<img src="https://raw.githubusercontent.com/MatrixMKII/SipeedTangPrimer25k/refs/heads/main/VGA640x480_60Hz/pics/adapterAndTang25K.jpg" width="50%"/>

###### Tang PRimer 25K and PMOD-VGA board

<br/><br/>

<img src="https://raw.githubusercontent.com/MatrixMKII/SipeedTangPrimer25k/refs/heads/main/VGA640x480_60Hz/pics/LCD_Screen.jpg" width="50%"/>

###### Picture of test image as shown on 4:3 LCD monitor with VGA input

