##About Zeph-39GX

This projects aims to create a third-party open source firmware for HP-39gs calculator. Currently mainly a emulator which will emulate TI-82/83/85/86.

##What's inside this repository

* 8xemu-39: HP-39gs port of TI-8XEMU, an tiny TI-82\83\85\86 emulator

##I am a user, how to install Zeph-39GX to my calculator?

This project is still under early development, currently you may not be able to install on your own.

##I am a developer, how to get started?

Please be aware that all operations should be completed in a PC with Windows 2000 or above OS installed.

* Compile&Build

You would need IAR Embedded Workbench for ARM or KEIL MDK-ARM in order to compile the source code, GNU GCC is not offically supported currently.

* Download to calculator

Currently you would need a JTAG debugger to flash a stock HP-39gs, J-Link and J-Flash are confirmed to work, a homebrew LPT JTAG interface should also work fine.

Flash 39gs.bin in object directory to 0x0000000 of NOR Flash and your own ti-86 ROM file to 0x00080000 of NOR Flash with JTAG.

* Debug

The program should run with a simple reset after downloading. If you wish to debug with IAR or Keil, simply press Debug button(Keil) or Debug without download(IAR) should bring your calculator into debug mode (Surely, via JTAG).

##Contact me

* My website http://zephray.com
* My email nbzwt@126.com)