/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
#include "buzz.h"
#include "2410addr.h"

void Buzzer_Start(unsigned long freq)
{
	rGPBCON &= ~(3<<4);
	rGPBCON |= (2<<4);
	rTCFG0  &= ~0xff00;
	rTCFG0  |= 0x0f00;
	rTCFG1  &= ~0x0f00;
	rTCFG1  |= 0x0200;
	rTCNTB2 = (PCLK>>7)/freq;
	rTCMPB2 = rTCNTB2 >> 1;
	rTCON &= ~0xF000;
	rTCON |=  0xB000;  
	rTCON &= ~0x2000;   
}

void Buzzer_Stop()
{
	rGPBCON &= ~(3<<4);
	rGPBCON |= (1<<4);
	rGPBDAT &= ~(1<<2);
	rTCON   &= ~0xF000;
}
