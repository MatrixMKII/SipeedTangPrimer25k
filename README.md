# Sipeed Tang Primer 25K projects


This repository will gradually include a collection of VHDL code targeting the Sipeed Tang Primer 25K.

<br/><br/>
<img src="https://raw.githubusercontent.com/MatrixMKII/SipeedTangPrimer25k/refs/heads/main/VGA640x480_60Hz/pics/TangPrimer25K.jpg" width="50%"/>

###### Tang Primer 25K

### Notes:
An external crystal (XTAL) is connected only to pin E2.
To enable the PLL using the 50 MHz signal from pin E2, perform the following configuration:

Open Project → Configuration → Place & Route → Dual Purpose Pins.

Enable the option “Use SSPI as regular IO” by checking the corresponding box.

This ensures that the SSPI function on pin E2 is disabled, allowing it to operate as a regular input for the crystal.
