# VGA for Sipeed Tang Primer 25K

This project contains VHDL code for implementing a VGA video adapter on the Tang Primer 25K FPGA development board.
It is designed for use with either the Mouse Lab PMOD-VGA v1.1 or the Digilent PmodVGA adapter.
The adapter uses connectors J5 and J6, which are the ones closest to the USB Type-A port.

Minimal VGA Implementation

This is a basic working implementation of VGA, providing only:

   * Horizontal and vertical sync signals  + back- and front porch.
   * Simple test pattern output

Planned Features and Future Improvements:

   * Further development is required to support full VGA capabilities, including:
   * Frame buffer for pixel data storage
   * Text generator for character display
   * SPI and/or I2C interface for communication with external devices
   * Intended for use with microcontrollers such as ESP32 or Arduino
   * Any other additional enhancements to extend functionality
