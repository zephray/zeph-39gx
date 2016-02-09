/***************************************************
             HP 39GS Repurpose Project
			              by Zweb
		      nbzwt@live.cn  www.arithmax.org
***************************************************/

#ifndef __INTERRUPT_H__
#define __INTERRUPT_H__

__irq void IRQ_Dummy(void);
void IRQ_Init(void);
void IRQ_RegISR(int service_number, __irq void (*serv_routine)(void));
void IRQ_UnregISR(int service_number);
void IRQ_Mask(int service_number);
void IRQ_Unmask(int service_number);

#endif
