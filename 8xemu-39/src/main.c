/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
#include <stdio.h>
#include "2410addr.h"
#include "buzz.h"
#include "misc.h"
#include "hwlcd.h"
#include "mmu.h"
#include "timer.h"
#include "interrupt.h"

char * itoa(int num,char *str,int radix)
{
  char index[]="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  unsigned unum;
  int i=0,j,k;
	char temp;

  if(radix==10&&num<0)
  {
    unum=(unsigned)-num;
    str[i++]='-';
  }  
  else unum=(unsigned)num;

  do{
    str[i++]=index[unum%(unsigned)radix];
    unum/=radix;
  }while(unum);
  str[i]='\0';

  if (str[0]=='-') k=1;
  else k=0;

  for(j=k;j<=(i-1)/2;j++)
  {
    temp=str[j];
    str[j]=str[i-1+k-j];
    str[i-1+k-j]=temp;
  }
  return str;
}

int main()
{
	char str[17];
	MMU_Init();
	IRQ_Init();
	LCD_CInit();
	LCD_Init();
	LCD_Clear(0);
	LCD_String(0,0,(unsigned char *)"TI8XEMU",1);
	
	emu_main();
	
	while(1)
	{
	}
}
