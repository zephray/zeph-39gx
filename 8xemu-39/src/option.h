/*********************************************************************************************
* File name	: option.h
* Author	: embest
* Descript	: Define S3C2410 CPU Option contents 
* History
*			R.X.Huang, Programming modify, March 12, 2005
*********************************************************************************************/

#ifndef __OPTION_H__
#define __OPTION_H__

#define FCLK 75000000
#define HCLK (FCLK/2)
#define PCLK (FCLK/4)
#define UCLK PCLK

#ifdef CLK111_50M
#define FCLK 50000000
#define HCLK 50000000
#define PCLK 50000000
#define UCLK 50000000
#endif

#ifdef CLK124_135M
#define FCLK 135428571
#define HCLK (135428571/2)
#define PCLK (135428571/4)
#endif

#ifdef CLK124_200M
#define FCLK 200000000
#define HCLK (200000000/2)
#define PCLK (200000000/4)
#endif

#ifdef CLK124_220M
#define FCLK 220000000
#define HCLK (220000000/2)
#define PCLK (220000000/4)
#endif

#ifdef CLK124_226M
#define FCLK 226000000
#define HCLK (226000000/2)
#define PCLK (226000000/4)
#endif

#ifdef CLK124_237M
#define FCLK 237000000
#define HCLK (237000000/2)
#define PCLK (237000000/4)
#define UCLK 50000000
#endif

#define FCLK_SPEED 1
#if FCLK_SPEED==0   /*  FCLK=203Mhz, Fin=12Mhz for AUDIO        */
	#define M_MDIV          0xc3
	#define M_PDIV          0x4
	#define M_SDIV          0x1
#elif FCLK_SPEED==1        /* FCLK = 202.8Mhz */
	#define M_MDIV          0xa1
	#define M_PDIV          0x3
	#define M_SDIV          0x1
#endif

#define PWRST             GPIO0
#define OFFRST            GPIO1
#define WDRST             GPIO2
#define POWEROFFLED1	  (0x2<<4)
#define POWEROFFLED2  	  (0x4<<4)
#define POWEROFFLED3  	  (0x8<<4)

//USB Device Options
#define USBDMA		TRUE
#define USBDMA_DEMAND 	FALSE	//the downloadFileSize should be (64*n)
#define BULK_PKT_SIZE	32

#endif    //__OPTION_H__	 

