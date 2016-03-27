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

//Prescaler为Tim2（蜂鸣器）和Tim4共用，保持配置一致
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

//on=1 启动 0 关闭
void Tim4_Start(unsigned char on)
{
	if (on)
	{
          rTCON &= ~0x00700000;//清空设定
          rTCON |=  0x00700000;//开启自动重装，重装初值
	  rTCON &= ~0x00200000;//完成初值重装
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

