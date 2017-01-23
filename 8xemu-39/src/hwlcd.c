/***************************************************
             HP 39GS Repurpose Project
			              by ZephRay
		      nbzwt@live.cn  www.zephray.com
***************************************************/
#include "hwlcd.h"
#include "2410addr.h"
#include "misc.h"
#include "font.h"

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

#define LCD_CS_LOW()   rGPDDAT &= ~(1<<9)
#define LCD_CS_HIGH()  rGPDDAT |=  (1<<9)
#define LCD_DAT_LOW()  rGPDDAT &= ~(1<<12)
#define LCD_DAT_HIGH() rGPDDAT |=  (1<<12)
#define LCD_SCK_LOW()  rGPDDAT &= ~(1<<13)
#define LCD_SCK_HIGH() rGPDDAT |=  (1<<13)
#define LCD_UN1_LOW()  rGPDDAT &= ~(1<<7)
#define LCD_UN2_LOW()  rGPDDAT &= ~(1<<8)

//Send one byte to LCD power controller chip
void LCD_WriteDat(unsigned char d)
{
	unsigned char i;
	
	LCD_CS_LOW();
	Delayus(50);
	for (i=0;i<8;i++)
	{
		LCD_SCK_LOW();
		Delayus(50);
		if (d&0x80)
			LCD_DAT_HIGH();
		else
			LCD_DAT_LOW();
		d = d << 1;
		LCD_SCK_HIGH();
		Delayus(50);
	}
	LCD_CS_HIGH();
}

//Init GPIO used by LCD power controller chip
void LCD_IOInit(void)
{
	rGPDCON &= ~(3<<14);
	rGPDCON |=  (1<<14);
	rGPDCON &= ~(3<<16);
	rGPDCON |=  (1<<16);
	rGPDCON &= ~(3<<18);
	rGPDCON |=  (1<<18);
	rGPDCON &= ~(3<<24);
	rGPDCON |=  (1<<24);
	rGPDCON &= ~(3<<26);
	rGPDCON |=  (1<<26);
}

//LCD initialize sequence
void LCD_Init(void)
{
	LCD_UN1_LOW();
	LCD_UN2_LOW();
	LCD_SCK_LOW();
	LCD_CS_LOW();
	LCD_DAT_LOW();
	LCD_IOInit();
	LCD_WriteDat(0x00);
	LCD_WriteDat(0x27);
	LCD_WriteDat(0x65);
	LCD_WriteDat(0x46);
	LCD_WriteDat(0xF6);
	Delay(100);
	LCD_WriteDat(0x40);
	LCD_WriteDat(0xC6);
	LCD_WriteDat(0x24);
	Delay(100);
	LCD_WriteDat(0x26);
	Delay(40);
	LCD_WriteDat(0x27);
	Delay(40);
	LCD_WriteDat(0x41);
	LCD_WriteDat(0xD0);
	Delay(2);
	LCD_WriteDat(0x42);
	LCD_WriteDat(0xDA);
	Delay(2);
	LCD_WriteDat(0x43);
	LCD_WriteDat(0xE4);
	Delay(2);
	LCD_WriteDat(0x44);
	LCD_WriteDat(0xEE);
	Delay(2);
	LCD_WriteDat(0x45);
	LCD_WriteDat(0xFF);
	Delay(2);
	LCD_WriteDat(0x00);
	LCD_WriteDat(0x65);
	Delay(2);
	LCD_WriteDat(0x45);
	LCD_WriteDat(0xFF);
}

//Just clear the internal framebuffer
void LCD_Clear(unsigned char c)
{
	unsigned char *p;
	int i;
	
	p = (unsigned char *)0x0803a000;
	for (i=0;i<1380;i++)
		*(p+i) = c;
}

//Initialize the S3C2410 LCD controller
void LCD_CInit()
{
	rLCDCON1 = (LCD_CLKVAL << 8)|(LCD_MMODE << 7)|(LCD_PNRMODE << 5)|(LCD_BPPMODE<<1);
	rLCDCON2 = (LCD_LINEVAL << 14);
	rLCDCON3 = (LCD_WDLY << 19)|(LCD_HOZVAL << 8)|(LCD_LINEBLANK);
	rLCDCON4 = (LCD_MVAL << 8)|(LCD_WLH);
	rLCDCON5 = 0x00000000;
	rLCDSADDR1 = ((0x0803a000) >> 1);
	rLCDSADDR2 = ((0x3a000 + 1380) >> 1);
	rLCDSADDR3 = (LCD_PAGEWIDTH);
	rLPCSEL &= ~7;
	rTPAL = 0;
	rLCDCON1 |= 0x00000001;
}


void LCD_Point(u16 x,u16 y,u16 c)
{
	unsigned char x_byte;
	unsigned char x_more;
	unsigned char x_bit;
	unsigned char *p;
	
	x = x&0xFF;
	y = y&0x3F;
	c = c&0x01;
	x_byte = x/8;
	x_more = x_byte % 4;
	x_byte = x_byte - x_more + 3 -x_more;
	x_bit  = x%8;
	y = y * LCD_LINESIZE;
	p = (unsigned char *)(0x0803a000+y+x_byte);
	*p &= ~(1 << x_bit);
	*p |=  (c << x_bit);
}

void LCD_XLine(u16 x0,u16 y0,u16 x1,u16 color)
{
  u16 i,xx0,xx1;
  
  xx0=MIN(x0,x1);
  xx1=MAX(x0,x1);
  for (i=xx0;i<=xx1;i++)
  {
    LCD_Point(i,y0,color);
  }
}

void LCD_YLine(u16 x0,u16 y0,u16 y1,u16 color)
{
  u16 i,yy0,yy1;
  
  yy0=MIN(y0,y1);
  yy1=MAX(y0,y1);
  for (i=yy0;i<=yy1;i++)
  {
    LCD_Point(x0,i,color);
  }
}

void LCD_Line(u16 x0,u16 y0,u16 x1,u16 y1,u16 color)
{
  int temp;
  int dx,dy;               //????????????????
  int s1,s2,status,i;
  int Dx,Dy,sub;

  dx=x1-x0;
  if(dx>=0)                 //X???????
    s1=1;
  else                     //X???????
    s1=-1;     
  dy=y1-y0;                 //??Y???????????
  if(dy>=0)
    s2=1;
  else
    s2=-1;

  Dx=abs(x1-x0);             //??????????????
  Dy=abs(y1-y0);
  if(Dy>Dx)                 //               
  {                     //?45??????,??Y??status=1,??X??status=0 
    temp=Dx;
    Dx=Dy;
    Dy=temp;
    status=1;
  } 
  else
    status=0;

/********?????????********/
  if(dx==0)                   //???????,??????
    LCD_YLine(x0,y0,y1,color);
  if(dy==0)                   //???????,??????
    LCD_XLine(x0,y0,x1,color);


/*********Bresenham???????????********/ 
  sub=2*Dy-Dx;                 //?1?????????
  for(i=0;i<Dx;i++)
  { 
    LCD_Point(x0,y0,color);           //?? 
    if(sub>=0)                               
    { 
      if(status==1)               //???Y??,x??1
        x0+=s1; 
      else                     //???X??,y??1               
        y0+=s2; 
      sub-=2*Dx;                 //????????? 
    } 
    if(status==1)
      y0+=s2; 
    else       
      x0+=s1; 
    sub+=2*Dy;   
  } 
}

void LCD_Circle(u16 x0,u16 y0,u16 r,u16 color)
{
  int a,b;
  int di;
  
  a=0;
  b=r;
  di=3-2*r;             //??????????
  while(a<=b)
  {
    LCD_Point(x0-b,y0-a,color);             //3           
    LCD_Point(x0+b,y0-a,color);             //0           
    LCD_Point(x0-a,y0+b,color);             //1       
    LCD_Point(x0-b,y0-a,color);             //7           
    LCD_Point(x0-a,y0-b,color);             //2             
    LCD_Point(x0+b,y0+a,color);             //4               
    LCD_Point(x0+a,y0-b,color);             //5
    LCD_Point(x0+a,y0+b,color);             //6 
    LCD_Point(x0-b,y0+a,color);             
    a++;
    /***??Bresenham????**/     
    if(di<0)
      di +=4*a+6;
    else
    {
      di +=10+4*(a-b);   
      b--;
    } 
    LCD_Point(x0+a,y0+b,color);
  }
}

void LCD_Rect(u16 x1,u16 y1,u16 x2,u16 y2,u16 color)
{
  LCD_XLine(x1,y1,x2,color);
  LCD_XLine(x1,y2,x2,color);
  LCD_YLine(x1,y1,y2,color);
  LCD_YLine(x2,y1,y2,color);
}

void LCD_Display_ASCII_5X7_Chr(u16 left,u16 top,u8 chr,u16 color)
{
  u16 x,y;
  u16 ptr;
  
  if ((chr=='\r')||(chr=='\n')) chr=' ';
  ptr=(chr-0x20)*8;
  for (y=0;y<8;y++)
  {
    for (x=0;x<5;x++)
    {
      if (((Font_Ascii_5X7E[ptr]<<x)&0x80)==0x80)
        LCD_Point(left+x,top+y,color); 
    }
    ptr++;
  }
}

void LCD_String(u16 left,u16 top,u8 *s,u16 color)
{
  u16 x;
  
  x=0;
  while(*s)
  {
    if (*s<128)
    {
      LCD_Display_ASCII_5X7_Chr(left+x,top,*s++,color);
      x+=6;
    }
    else
    {
      //LCD_Display_Chn_Chr(left+x,top,s,color);
      s+=2;
      x+=16;
    }
  }
}
