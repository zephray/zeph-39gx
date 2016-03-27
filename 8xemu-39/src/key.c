#include "key.h"
#include "2410addr.h"
#include "misc.h"
#include "interrupt.h"

volatile unsigned int KeyMatrixHi;
volatile unsigned int KeyMatrixLo;
//volatile unsigned char CurKey;

//SOURCE CODE ADOPTED FORM newRPL PROJECT, THANKS TO THEIR EPIC WORK

void KBD_Config(void)
{
  KeyMatrixHi=0;
  KeyMatrixLo=0;
  //CurKey=0xFF;
}

void KBD_EXTIConfig(void)
{

}

void KBD_TIMConfig(void)
{

}

void KBD_Scan(void)
{
  unsigned int tmp[DEBOUNCE],f,k;
  unsigned int lo=0,hi=0;

  int col;
  unsigned int control;
    
  rGPGDAT = 0;

  for(col=7;col>=4;--col)
  {
    control = 1<<((col+8)*2);
    control = control | 0x1;
    rGPGCON = control;
    // GPGDAT WAS SET TO ZERO, SO THE SELECTED COLUMN IS DRIVEN LOW
    
    // DEBOUNCE TECHNIQUE

    // FILL DEBOUNCE BUFFER
    for(f=0;f<DEBOUNCE;++f) tmp[f]=f;
    // DO CIRCULAR BUFFER, CHECKING FOR NOISE ON EVERY READ
    k=0;
    do {
      tmp[k]=rGPGDAT & 0xfe;
      for(f=1;f<DEBOUNCE;++f) {
        if(tmp[f]!=tmp[f-1]) break;
      }
      ++k;
      if(k>=DEBOUNCE) k=0;
    } while(f<DEBOUNCE);

    hi=(hi<<8) | ((~(tmp[0]))&0xfe);
  }

  for(;col>=0;--col)
  {
    control = 1<<((col+8)*2);
    control = control | 0x1;
    rGPGCON = control;
    // GPGDAT WAS SET TO ZERO, SO THE SELECTED COLUMN IS DRIVEN LOW
    for(f=0;f<DEBOUNCE;++f) tmp[f]=f;
    // DO CIRCULAR BUFFER, CHECKING FOR NOISE ON EVERY READ
    k=0;
    do {
      tmp[k]=rGPGDAT & 0xfe;
    for(f=1;f<DEBOUNCE;++f) {
      if(tmp[f]!=tmp[f-1]) break;
    }
    ++k;
    if(k>=DEBOUNCE) k=0;
    } while(f<DEBOUNCE);


    lo=(lo<<8) | ((~(tmp[0]))&0xfe);

    }

    rGPGCON = 0x5555AAA9; // SET TO TRIGGER INTERRUPTS ON ANY KEY

    for(f=0;f<DEBOUNCE;++f) tmp[f]=f;
    // DO CIRCULAR BUFFER, CHECKING FOR NOISE ON EVERY READ
    k=0;
    do {
        tmp[k]=rGPFDAT& 0x71;
    for(f=1;f<DEBOUNCE;++f) {
        if(tmp[f]!=tmp[f-1]) break;
    }
    ++k;
    if(k>=DEBOUNCE) k=0;
    } while(f<DEBOUNCE);

    hi |=  (tmp[k]&0x70)<<24;
    hi |=  tmp[k]<<31;

    KeyMatrixHi = hi;
    KeyMatrixLo = lo;
}

void WaitForKey(void)
{

}

void WaitForCertainKey(unsigned char ck)
{

}

unsigned char GetKey(void)
{
  //KBD_Convert();
  //return CurKey;
}
