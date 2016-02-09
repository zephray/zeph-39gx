/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
#include "misc.h"

void Delay(unsigned long t)
{
	int i,z;
	for (i=500; i>0; i--)
			for (z=t;z>0;z--);
}

void Delayus(unsigned int t)
{
	int z = t;
	while (z--);
}
