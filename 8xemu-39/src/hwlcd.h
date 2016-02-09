/***************************************************
             HP 39GS Repurpose Project
			              by Zweb
		      nbzwt@live.cn  www.zephray.com
***************************************************/

#ifndef __HWLCD_H__
#define __HWLCD_H__

#include "misc.h"

#define LCD_XSIZE					(160)
#define LCD_YSIZE					(69)
#define LCD_CLKVAL				(13)
#define LCD_LINEVAL				(LCD_YSIZE-1)
#define LCD_WDLY					(0)
#define LCD_HOZVAL				(LCD_XSIZE/4-1)
#define LCD_LINEBLANK			(8)
#define LCD_MVAL					(0)
#define LCD_WLH						(0)
#define LCD_MMODE					(LCD_MMODE_VSYNC)
#define LCD_PNRMODE				(LCD_PNRMODE_4BITSINGLE)
#define LCD_BPPMODE				(LCD_BPPMODE_MONOSTN)
#define LCD_LINESIZE			(LCD_XSIZE/8)
#define LCD_PAGEWIDTH			(LCD_XSIZE/16)
#define LCD_SIZE					(LCD_YSIZE * LCD_XSIZE / 8)

#define LCD_MMODE_VSYNC								0
#define LCD_MMODE_MVAL								1
#define LCD_PNRMODE_4BITDUAL					0
#define LCD_PNRMODE_4BITSINGLE				1
#define LCD_PNRMODE_8BITSINGLE				2
#define LCD_PNRMODE_TFTLCD						3
#define LCD_BPPMODE_MONOSTN						0
#define LCD_BPPMODE_2BPPSTN						1
#define LCD_BPPMODE_4BPPSTN						2
#define LCD_BPPMODE_8BPPSTN						3
#define LCD_BPPMODE_12BPPSTN					4
#define LCD_BPPMODE_MONOTFT						8
#define LCD_BPPMODE_2BPPTFT						9
#define LCD_BPPMODE_4BPPTFT						10
#define LCD_BPPMODE_8BPPTFT						11
#define LCD_BPPMODE_16BPPTFT					12
#define LCD_BPPMODE_24BPPTFT					13

#define LCD_CLBLACK	1
#define LCD_CLWHITE 0

void LCD_Init(void);
void LCD_CInit(void);
void LCD_WriteDat(unsigned char d);
void LCD_Clear(unsigned char c);
void LCD_Display_ASCII_8X16_Chr(u16 left,u16 top,u8 chr,u16 color);
void LCD_String(u16 left,u16 top,u8 *s,u16 color);
void LCD_Point(u16 x,u16 y,u16 color);
void LCD_XLine(u16 x0,u16 y0,u16 x1,u16 color);
void LCD_YLine(u16 x0,u16 y0,u16 y1,u16 color);
void LCD_Line(u16 x0,u16 y0,u16 x1,u16 y1,u16 color);
void LCD_Circle(u16 x0,u16 y0,u16 r,u16 color);

#endif
