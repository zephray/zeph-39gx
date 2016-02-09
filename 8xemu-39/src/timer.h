/***************************************************
             HP 39GS Repurpose Project
			              by Zweb
		      nbzwt@live.cn  www.arithmax.org
***************************************************/

#ifndef __TIMER_H__
#define __TIMER_H__

extern volatile unsigned long SysTick;

void Tim4_Init(unsigned long freq);
void Tim4_Start(unsigned char on);
__irq void Tim4_IntHandler(void);

#endif
