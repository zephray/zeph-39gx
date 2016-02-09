/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
#include "2410addr.h"
#include "buzz.h"
#include "misc.h"
#include "hwlcd.h"
#include "interface.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

void *RPP_malloc(u32 size)
{
	return malloc(size);
}

void *RPP_memset(void *s, int ch, u32 n)
{
	return memset(s,ch,n);
}

void RPP_free(void *s)
{
	free(s);
}

void RPP_Log(unsigned char * str)
{
	LCD_String(0,0,str,LCD_CLBLACK);
}

void RPP_Halt(u32 index)
{
	LCD_String(0,16,"PROGRAM EXIT",LCD_CLBLACK);
}
