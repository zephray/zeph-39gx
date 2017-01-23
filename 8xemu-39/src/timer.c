/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
#include "timer.h"
#include "interrupt.h"
#include "2410addr.h"
#include "key.h"

volatile unsigned long SysTick=0;

//Prescaler was shared by both Tim2(Buzzer) and Tim4(SysTick), 
//so keep the configuration the same
void Tim4_Init(unsigned long freq)
{
	rTCFG0  &= ~0x0000ff00;
	rTCFG0  |=  0x00000f00;
	rTCFG1  &= ~0x000f0000;
	rTCFG1  |=  0x00020000;
	rTCNTB4 = (PCLK>>7)/freq;
	rTCON &= ~0x00070000;
	
	IRQ_RegISR(14, &Tim4_IntHandler);
	IRQ_Unmask(14);
}

//1 is on 0 is off
void Tim4_Start(unsigned char on)
{
	if (on)
	{
        rTCON &= ~0x00700000;//clear settings
        rTCON |=  0x00700000;//auto reload on & reload initial value
        rTCON &= ~0x00200000;//finish reload
	}else
        rTCON &= ~0x00700000;
}

__irq void Tim4_IntHandler(void)
{
    rSRCPND = 1<<14;
    KBD_Scan();
    SysTick++;
    rINTPND = 1<<14;
}

