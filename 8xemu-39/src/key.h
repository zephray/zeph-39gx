#ifndef __KEY_H__
#define __KEY_H__

#define DEBOUNCE  16

void KBD_Config(void);
void KBD_Scan(void);
void KBD_TIMConfig(void);
void WaitForKey(void);
unsigned char GetKey(void);

extern volatile unsigned int KeyMatrixHi;
extern volatile unsigned int KeyMatrixLo;
//extern volatile unsigned char CurKey;

/*

KEYBOARD BIT MAP
----------------
This is the bit number in the 64-bit keymatrix.
Bit set means key is pressed.

    A]-+  B]-+  C]-+  D]-+  E]-+  F]-+
    |41|  |42|  |43|  |44|  |45|  |46|
    +--+  +--+  +--+  +--+  +--+  +--+

    G]-+  H]-+  I]-+        UP]+
    |47|  |53|  |54|        |49|
    +--+  +--+  +--+  LF]+  +--+  RT]+
                      |50|  DN]+  |52|
    J]-+  K]-+  L]-+  +--+  |51|  +--+
    |55|  |57|  |58|        +--+
    +--+  +--+  +--+

    M]--+  N]--+  O]--+  P]--+  BKS]+
    | 33|  | 25|  | 17|  | 09|  | 01|
    +---+  +---+  +---+  +---+  +---+

    Q]--+  R]--+  S]--+  T]--+  U]--+
    | 34|  | 26|  | 18|  | 10|  | 02|
    +---+  +---+  +---+  +---+  +---+

    V]--+  W]--+  X]--+  Y]--+  /]--+
    | 35|  | 27|  | 19|  | 11|  | 03|
    +---+  +---+  +---+  +---+  +---+

    AL]-+  7]--+  8]--+  9]--+  *]--+
    | 60|  | 28|  | 20|  | 12|  | 04|
    +---+  +---+  +---+  +---+  +---+

    LS]-+  4]--+  5]--+  6]--+  -]--+
    | 61|  | 29|  | 21|  | 13|  | 05|
    +---+  +---+  +---+  +---+  +---+

    RS]-+  1]--+  2]--+  3]--+  +]--+
    | 62|  | 30|  | 22|  | 14|  | 06|
    +---+  +---+  +---+  +---+  +---+

    ON]-+  0]--+  .]--+  SP]-+  EN]-+
    | 63|  | 31|  | 23|  | 15|  | 07|
    +---+  +---+  +---+  +---+  +---+

*/

#define KB_SCAN_DOWN    51-32
#define KB_SCAN_LEFT    50-32
#define KB_SCAN_RIGHT   52-32
#define KB_SCAN_UP      49-32
#define KB_SCAN_ENTER   07
#define KB_SCAN_BACKSPACE       01
#define KB_SCAN_MINUS   15
#define KB_SCAN_A       34-32
#define KB_SCAN_B       26
#define KB_SCAN_C       18
#define KB_SCAN_D       10
#define KB_SCAN_E       02
#define KB_SCAN_F       35-32
#define KB_SCAN_G       27
#define KB_SCAN_H       19
#define KB_SCAN_I       11
#define KB_SCAN_J       03
#define KB_SCAN_K       60-32
#define KB_SCAN_L       28
#define KB_SCAN_M       20
#define KB_SCAN_N       12
#define KB_SCAN_O       04
#define KB_SCAN_P       61-32
#define KB_SCAN_Q       29
#define KB_SCAN_R       21
#define KB_SCAN_S       13
#define KB_SCAN_T       05
#define KB_SCAN_U       30
#define KB_SCAN_V       22
#define KB_SCAN_W       14
#define KB_SCAN_X       06
#define KB_SCAN_Y       31
#define KB_SCAN_Z       23
#define KB_SCAN_EQUAL   62-32
#define KB_SCAN_F10     9
#define KB_SCAN_F9      17
#define KB_SCAN_F8      25
#define KB_SCAN_F7      33-32
#define KB_SCAN_QUOTE   57-32
#define KB_SCAN_LCONTROL        55-32
#define KB_SCAN_DELETE  58-32
#define KB_SCAN_F5      45-32
#define KB_SCAN_F4      44-32
#define KB_SCAN_F3      43-32
#define KB_SCAN_F2      42-32
#define KB_SCAN_F1      41-32
#define KB_SCAN_LSHIFT  47-32
#define KB_SCAN_ESC     53-32
#define KB_SCAN_TAB     54-32
#define KB_ON   63-32


#define kb_key_h(x) (KeyMatrixHi&(((unsigned long)1)<<(x)))
#define kb_key(x) (KeyMatrixLo&(((unsigned long)1)<<(x)))

#endif
