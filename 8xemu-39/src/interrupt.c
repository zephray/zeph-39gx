/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
/***************************************************
   Thanks to Claudio Lapilli and the newRPL Team
***************************************************/

#include "2410addr.h"
#include "interrupt.h"

#define IVT_Base 0x08039f20
#define IVT(x) (*(volatile unsigned *)((int)IVT_Base+(int)x*4))

__irq void IRQ_Dummy(void)
{
	return;
}

void IRQ_Init(void)
{
  int f;

  //禁用所有中断，清除所有等待标记（其实如果有标记的话应该已经没有机会执行这段代码了
  rINTMSK=0xffffffff;
  rSRCPND=0xffffffff;
  rINTPND=0xffffffff;

  //把所有中断处理程序设置为空
  for(f=0;f<32;++f)
  {
    IVT(f)=(unsigned long)&IRQ_Dummy;
  }
	
}

void IRQ_RegISR(int service_number, __irq void (*serv_routine)(void))
{
	if(service_number<0 || service_number>31) return;
    IVT(service_number)=(unsigned long)serv_routine;

}

void IRQ_UnregISR(int service_number)
{
	if(service_number<0 || service_number>31) return;
    IVT(service_number)=(unsigned long)&IRQ_Dummy;
}

void IRQ_Mask(int service_number)
{
    rINTMSK|=1<<service_number;
}

void IRQ_Unmask(int service_number)
{
    rINTMSK&=~(1<<service_number);
}
