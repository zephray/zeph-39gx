;====================================================================
; File Name : 2410addr.a
; Function  : S3C2410 Define Address Register (Assembly)
; Program   : Shin, On Pil (SOP)
; Date      : May 06, 2002
; Version   : 0.0
; History
;   0.0 : Programming start (February 18,2002) -> SOP
;         INTERRUPT rPRIORITY 0x4a00000a -> 0x4a00000c       (May 06, 2002 SOP)
;         RTC BCD DAY and DATE Register Name Correction      (May 06, 2002 SOP) 
;====================================================================

;GBLL   BIG_ENDIAN__
;BIG_ENDIAN__   SETL   {FALSE}

;=================
; Memory control 
;=================
BWSCON      EQU  0x48000000     ;Bus width & wait status
BANKCON0    EQU  0x48000004     ;Boot ROM control
BANKCON1    EQU  0x48000008     ;BANK1 control
BANKCON2    EQU  0x4800000c     ;BANK2 cControl
BANKCON3    EQU  0x48000010     ;BANK3 control
BANKCON4    EQU  0x48000014     ;BANK4 control
BANKCON5    EQU  0x48000018     ;BANK5 control
BANKCON6    EQU  0x4800001c     ;BANK6 control
BANKCON7    EQU  0x48000020     ;BANK7 control
REFRESH     EQU  0x48000024     ;DRAM/SDRAM refresh
BANKSIZE    EQU  0x48000028     ;Flexible Bank Size
MRSRB6      EQU  0x4800002c     ;Mode register set for SDRAM
MRSRB7      EQU  0x48000030     ;Mode register set for SDRAM

;=================
; USB Host
;=================

;=================
; INTERRUPT
;=================
SRCPND       EQU  0x4a000000    ;Interrupt request status
INTMOD       EQU  0x4a000004    ;Interrupt mode control
INTMSK       EQU  0x4a000008    ;Interrupt mask control
PRIORITY     EQU  0x4a00000c    ;IRQ priority control           <-- May 06, 2002 SOP
INTPND       EQU  0x4a000010    ;Interrupt request status
INTOFFSET    EQU  0x4a000014    ;Interruot request source offset
SUSSRCPND    EQU  0x4a000018    ;Sub source pending
INTSUBMSK    EQU  0x4a00001c    ;Interrupt sub mask


;=================
; DMA
;=================
DISRC0       EQU  0x4b000000    ;DMA 0 Initial source
DISRCC0      EQU  0x4b000004    ;DMA 0 Initial source control
DIDST0       EQU  0x4b000008    ;DMA 0 Initial Destination
DIDSTC0      EQU  0x4b00000c    ;DMA 0 Initial Destination control
DCON0        EQU  0x4b000010    ;DMA 0 Control
DSTAT0       EQU  0x4b000014    ;DMA 0 Status
DCSRC0       EQU  0x4b000018    ;DMA 0 Current source
DCDST0       EQU  0x4b00001c    ;DMA 0 Current destination
DMASKTRIG0   EQU  0x4b000020    ;DMA 0 Mask trigger

DISRC1       EQU  0x4b000040    ;DMA 1 Initial source
DISRCC1      EQU  0x4b000044    ;DMA 1 Initial source control
DIDST1       EQU  0x4b000048    ;DMA 1 Initial Destination
DIDSTC1      EQU  0x4b00004c    ;DMA 1 Initial Destination control
DCON1        EQU  0x4b000050    ;DMA 1 Control
DSTAT1       EQU  0x4b000054    ;DMA 1 Status
DCSRC1       EQU  0x4b000058    ;DMA 1 Current source
DCDST1       EQU  0x4b00005c    ;DMA 1 Current destination
DMASKTRIG1   EQU  0x4b000060    ;DMA 1 Mask trigger

DISRC2       EQU  0x4b000080    ;DMA 2 Initial source
DISRCC2      EQU  0x4b000084    ;DMA 2 Initial source control
DIDST2       EQU  0x4b000088    ;DMA 2 Initial Destination
DIDSTC2      EQU  0x4b00008c    ;DMA 2 Initial Destination control
DCON2        EQU  0x4b000090    ;DMA 2 Control
DSTAT2       EQU  0x4b000094    ;DMA 2 Status
DCSRC2       EQU  0x4b000098    ;DMA 2 Current source
DCDST2       EQU  0x4b00009c    ;DMA 2 Current destination
DMASKTRIG2   EQU  0x4b0000a0    ;DMA 2 Mask trigger

DISRC3       EQU  0x4b0000c0    ;DMA 3 Initial source
DISRCC3      EQU  0x4b0000c4    ;DMA 3 Initial source control
DIDST3       EQU  0x4b0000c8    ;DMA 3 Initial Destination
DIDSTC3      EQU  0x4b0000cc    ;DMA 3 Initial Destination control
DCON3        EQU  0x4b0000d0    ;DMA 3 Control
DSTAT3       EQU  0x4b0000d4    ;DMA 3 Status
DCSRC3       EQU  0x4b0000d8    ;DMA 3 Current source
DCDST3       EQU  0x4b0000dc    ;DMA 3 Current destination
DMASKTRIG3   EQU  0x4b0000e0    ;DMA 3 Mask trigger


;==========================
; CLOCK & POWER MANAGEMENT
;==========================
LOCKTIME    EQU  0x4c000000     ;PLL lock time counter
MPLLCON     EQU  0x4c000004     ;MPLL Control
UPLLCON     EQU  0x4c000008     ;UPLL Control
CLKCON      EQU  0x4c00000c     ;Clock generator control
CLKSLOW     EQU  0x4c000010     ;Slow clock control
CLKDIVN     EQU  0x4c000014     ;Clock divider control


;=================
; LCD CONTROLLER
;=================
LCDCON1     EQU  0x4d000000     ;LCD control 1
LCDCON2     EQU  0x4d000004     ;LCD control 2
LCDCON3     EQU  0x4d000008     ;LCD control 3
LCDCON4     EQU  0x4d00000c     ;LCD control 4
LCDCON5     EQU  0x4d000010     ;LCD control 5
LCDSADDR1   EQU  0x4d000014     ;STN/TFT Frame buffer start address 1
LCDSADDR2   EQU  0x4d000018     ;STN/TFT Frame buffer start address 2
LCDSADDR3   EQU  0x4d00001c     ;STN/TFT Virtual screen address set
REDLUT      EQU  0x4d000020     ;STN Red lookup table
GREENLUT    EQU  0x4d000024     ;STN Green lookup table 
BLUELUT     EQU  0x4d000028     ;STN Blue lookup table
DITHMODE    EQU  0x4d00004c     ;STN Dithering mode
TPAL        EQU  0x4d000050     ;TFT Temporary palette
LCDINTPND   EQU  0x4d000054     ;LCD Interrupt pending
LCDSRCPND   EQU  0x4d000058     ;LCD Interrupt source
LCDINTMSK   EQU  0x4d00005c     ;LCD Interrupt mask
LPCSEL      EQU  0x4d000060     ;LPC3600 Control


;=================
; NAND flash
;=================
NFCONF      EQU  0x4e000000     ;NAND Flash configuration
NFCMD       EQU  0x4e000004     ;NADD Flash command
NFADDR      EQU  0x4e000008     ;NAND Flash address
NFDATA      EQU  0x4e00000c     ;NAND Flash data
NFSTAT      EQU  0x4e000010     ;NAND Flash operation status
NFECC       EQU  0x4e000014     ;NAND Flash ECC


;=================
; UART
;=================
ULCON0       EQU  0x50000000    ;UART 0 Line control
UCON0        EQU  0x50000004    ;UART 0 Control
UFCON0       EQU  0x50000008    ;UART 0 FIFO control
UMCON0       EQU  0x5000000c    ;UART 0 Modem control
UTRSTAT0     EQU  0x50000010    ;UART 0 Tx/Rx status
UERSTAT0     EQU  0x50000014    ;UART 0 Rx error status
UFSTAT0      EQU  0x50000018    ;UART 0 FIFO status
UMSTAT0      EQU  0x5000001c    ;UART 0 Modem status
UBRDIV0      EQU  0x50000028    ;UART 0 Baud rate divisor

ULCON1       EQU  0x50004000    ;UART 1 Line control
UCON1        EQU  0x50004004    ;UART 1 Control
UFCON1       EQU  0x50004008    ;UART 1 FIFO control
UMCON1       EQU  0x5000400c    ;UART 1 Modem control
UTRSTAT1     EQU  0x50004010    ;UART 1 Tx/Rx status
UERSTAT1     EQU  0x50004014    ;UART 1 Rx error status
UFSTAT1      EQU  0x50004018    ;UART 1 FIFO status
UMSTAT1      EQU  0x5000401c    ;UART 1 Modem status
UBRDIV1      EQU  0x50004028    ;UART 1 Baud rate divisor

ULCON2       EQU  0x50008000    ;UART 2 Line control
UCON2        EQU  0x50008004    ;UART 2 Control
UFCON2       EQU  0x50008008    ;UART 2 FIFO control
UMCON2       EQU  0x5000800c    ;UART 2 Modem control
UTRSTAT2     EQU  0x50008010    ;UART 2 Tx/Rx status
UERSTAT2     EQU  0x50008014    ;UART 2 Rx error status
UFSTAT2      EQU  0x50008018    ;UART 2 FIFO status
UMSTAT2      EQU  0x5000801c    ;UART 2 Modem status
UBRDIV2      EQU  0x50008028    ;UART 2 Baud rate divisor

UTXH0        EQU  0x50000020    ;UART 0 Transmission Hold
URXH0        EQU  0x50000024    ;UART 0 Receive buffer
UTXH1        EQU  0x50004020    ;UART 1 Transmission Hold
URXH1        EQU  0x50004024    ;UART 1 Receive buffer
UTXH2        EQU  0x50008020    ;UART 2 Transmission Hold
URXH2        EQU  0x50008024    ;UART 2 Receive buffer


;=================
; PWM TIMER
;=================
TCFG0    EQU  0x51000000        ;Timer 0 configuration
TCFG1    EQU  0x51000004        ;Timer 1 configuration
TCON     EQU  0x51000008        ;Timer control
TCNTB0   EQU  0x5100000c        ;Timer count buffer 0
TCMPB0   EQU  0x51000010        ;Timer compare buffer 0
TCNTO0   EQU  0x51000014        ;Timer count observation 0
TCNTB1   EQU  0x51000018        ;Timer count buffer 1
TCMPB1   EQU  0x5100001c        ;Timer compare buffer 1
TCNTO1   EQU  0x51000020        ;Timer count observation 1
TCNTB2   EQU  0x51000024        ;Timer count buffer 2
TCMPB2   EQU  0x51000028        ;Timer compare buffer 2
TCNTO2   EQU  0x5100002c        ;Timer count observation 2
TCNTB3   EQU  0x51000030        ;Timer count buffer 3
TCMPB3   EQU  0x51000034        ;Timer compare buffer 3
TCNTO3   EQU  0x51000038        ;Timer count observation 3
TCNTB4   EQU  0x5100003c        ;Timer count buffer 4
TCNTO4   EQU  0x51000040        ;Timer count observation 4


;=================
; USB DEVICE
;=================
FUNC_ADDR_REG       EQU  0x52000140     ;Function address
PWR_REG             EQU  0x52000144     ;Power management
EP_INT_REG          EQU  0x52000148     ;EP Interrupt pending and clear
USB_INT_REG         EQU  0x52000158     ;USB Interrupt pending and clear
EP_INT_EN_REG       EQU  0x5200015c     ;Interrupt enable
USB_INT_EN_REG      EQU  0x5200016c
FRAME_NUM1_REG      EQU  0x52000170     ;Frame number lower byte
FRAME_NUM2_REG      EQU  0x52000174     ;Frame number lower byte
INDEX_REG           EQU  0x52000178     ;Register index
MAXP_REG            EQU  0x52000180     ;Endpoint max packet
EP0_CSR             EQU  0x52000184     ;Endpoint 0 status
IN_CSR1_REG         EQU  0x52000184     ;In endpoint control status
IN_CSR2_REG         EQU  0x52000188
OUT_CSR1_REG        EQU  0x52000190     ;Out endpoint control status
OUT_CSR2_REG        EQU  0x52000194
OUT_FIFO_CNT1_REG   EQU  0x52000198     ;Endpoint out write count
OUT_FIFO_CNT2_REG   EQU  0x5200019c
EP0_FIFO            EQU  0x520001c0     ;Endpoint 0 FIFO
EP1_FIFO            EQU  0x520001c4     ;Endpoint 1 FIFO
EP2_FIFO            EQU  0x520001c8     ;Endpoint 2 FIFO
EP3_FIFO            EQU  0x520001cc     ;Endpoint 3 FIFO
EP4_FIFO            EQU  0x520001d0     ;Endpoint 4 FIFO
EP1_DMA_CON         EQU  0x52000200     ;EP1 DMA interface control
EP1_DMA_UNIT        EQU  0x52000204     ;EP1 DMA Tx unit counter
EP1_DMA_FIFO        EQU  0x52000208     ;EP1 DMA Tx FIFO counter
EP1_DMA_TTC_L       EQU  0x5200020c     ;EP1 DMA total Tx counter
EP1_DMA_TTC_M       EQU  0x52000210
EP1_DMA_TTC_H       EQU  0x52000214
EP2_DMA_CON         EQU  0x52000218     ;EP2 DMA interface control
EP2_DMA_UNIT        EQU  0x5200021c     ;EP2 DMA Tx unit counter
EP2_DMA_FIFO        EQU  0x52000220     ;EP2 DMA Tx FIFO counter
EP2_DMA_TTC_L       EQU  0x52000224     ;EP2 DMA total Tx counter
EP2_DMA_TTC_M       EQU  0x52000228
EP2_DMA_TTC_H       EQU  0x5200022c
EP3_DMA_CON         EQU  0x52000240     ;EP3 DMA interface control
EP3_DMA_UNIT        EQU  0x52000244     ;EP3 DMA Tx unit counter
EP3_DMA_FIFO        EQU  0x52000248     ;EP3 DMA Tx FIFO counter
EP3_DMA_TTC_L       EQU  0x5200024c     ;EP3 DMA total Tx counter
EP3_DMA_TTC_M       EQU  0x52000250
EP3_DMA_TTC_H       EQU  0x52000254
EP4_DMA_CON         EQU  0x52000258     ;EP4 DMA interface control
EP4_DMA_UNIT        EQU  0x5200025c     ;EP4 DMA Tx unit counter
EP4_DMA_FIFO        EQU  0x52000260     ;EP4 DMA Tx FIFO counter
EP4_DMA_TTC_L       EQU  0x52000264     ;EP4 DMA total Tx counter
EP4_DMA_TTC_M       EQU  0x52000268
EP4_DMA_TTC_H       EQU  0x5200026c


;=================
; WATCH DOG TIMER
;=================
WTCON     EQU  0x53000000       ;Watch-dog timer mode
WTDAT     EQU  0x53000004       ;Watch-dog timer data
WTCNT     EQU  0x53000008       ;Eatch-dog timer count


;=================
; IIC
;=================
IICCON    EQU  0x54000000       ;IIC control
IICSTAT   EQU  0x54000004       ;IIC status
IICADD    EQU  0x54000008       ;IIC address
IICDS     EQU  0x5400000c       ;IIC data shift


;=================
; IIS
;=================
IISCON    EQU  0x55000000       ;IIS Control
IISMOD    EQU  0x55000004       ;IIS Mode
IISPSR    EQU  0x55000008       ;IIS Prescaler
IISFCON   EQU  0x5500000c       ;IIS FIFO control
IISFIFO    EQU  0x55000010       ;IIS FIFO entry


;=================
; I/O PORT 
;=================
GPACON      EQU  0x56000000     ;Port A control
GPADAT      EQU  0x56000004     ;Port A data
                        
GPBCON      EQU  0x56000010     ;Port B control
GPBDAT      EQU  0x56000014     ;Port B data
GPBUP       EQU  0x56000018     ;Pull-up control B
                        
GPCCON      EQU  0x56000020     ;Port C control
GPCDAT      EQU  0x56000024     ;Port C data
GPCUP       EQU  0x56000028     ;Pull-up control C
                        
GPDCON      EQU  0x56000030     ;Port D control
GPDDAT      EQU  0x56000034     ;Port D data
GPDUP       EQU  0x56000038     ;Pull-up control D
                        
GPECON      EQU  0x56000040     ;Port E control
GPEDAT      EQU  0x56000044     ;Port E data
GPEUP       EQU  0x56000048     ;Pull-up control E
                        
GPFCON      EQU  0x56000050     ;Port F control
GPFDAT      EQU  0x56000054     ;Port F data
GPFUP       EQU  0x56000058     ;Pull-up control F
                        
GPGCON      EQU  0x56000060     ;Port G control
GPGDAT      EQU  0x56000064     ;Port G data
GPGUP       EQU  0x56000068     ;Pull-up control G
                        
GPHCON      EQU  0x56000070     ;Port H control
GPHDAT      EQU  0x56000074     ;Port H data
GPHUP       EQU  0x56000078     ;Pull-up control H
                        
MISCCR      EQU  0x56000080     ;Miscellaneous control
DCKCON      EQU  0x56000084     ;DCLK0/1 control
EXTINT0     EQU  0x56000088     ;External interrupt control register 0
EXTINT1     EQU  0x5600008c     ;External interrupt control register 1
EXTINT2     EQU  0x56000090     ;External interrupt control register 2
EINTFLT0    EQU  0x56000094     ;Reserved
EINTFLT1    EQU  0x56000098     ;Reserved
EINTFLT2    EQU  0x5600009c     ;External interrupt filter control register 2
EINTFLT3    EQU  0x560000a0     ;External interrupt filter control register 3
EINTMASK    EQU  0x560000a4     ;External interrupt mask
EINTPEND    EQU  0x560000a8     ;External interrupt pending
GSTATUS0    EQU  0x560000ac     ;External pin status
GSTATUS1    EQU  0x560000b0     ;Chip ID(0x32410000)
GSTATUS2    EQU  0x560000b4     ;Reset type
GSTATUS3    EQU  0x560000b8     ;Saved data0(32-bit) before entering POWER_OFF mode 
GSTATUS4    EQU  0x560000bc     ;Saved data1(32-bit) before entering POWER_OFF mode


;=================
; RTC
;=================
RTCCON    EQU  0x57000040       ;RTC control
TICNT     EQU  0x57000044       ;Tick time count
RTCALM    EQU  0x57000050       ;RTC alarm control
ALMSEC    EQU  0x57000054       ;Alarm second
ALMMIN    EQU  0x57000058       ;Alarm minute
ALMHOUR   EQU  0x5700005c       ;Alarm Hour
ALMDATE   EQU  0x57000060       ;Alarm day      <-- May 06, 2002 SOP
ALMMON    EQU  0x57000064       ;Alarm month
ALMYEAR   EQU  0x57000068       ;Alarm year
RTCRST    EQU  0x5700006c       ;RTC round reset
BCDSEC    EQU  0x57000070       ;BCD second
BCDMIN    EQU  0x57000074       ;BCD minute
BCDHOUR   EQU  0x57000078       ;BCD hour
BCDDATE   EQU  0x5700007c       ;BCD day        <-- May 06, 2002 SOP
BCDDAY    EQU  0x57000080       ;BCD date       <-- May 06, 2002 SOP
BCDMON    EQU  0x57000084       ;BCD month
BCDYEAR   EQU  0x57000088       ;BCD year


;=================
; ADC
;=================
ADCCON      EQU  0x58000000     ;ADC control
ADCTSC      EQU  0x58000004     ;ADC touch screen control
ADCDLY      EQU  0x58000008     ;ADC start or Interval Delay
ADCDAT0     EQU  0x5800000c     ;ADC conversion data 0
ADCDAT1     EQU  0x58000010     ;ADC conversion data 1                     


;=================                      
; SPI           
;=================
SPCON0      EQU  0x59000000     ;SPI0 control
SPSTA0      EQU  0x59000004     ;SPI0 status
SPPIN0      EQU  0x59000008     ;SPI0 pin control
SPPRE0      EQU  0x5900000c     ;SPI0 baud rate prescaler
SPTDAT0     EQU  0x59000010     ;SPI0 Tx data
SPRDAT0     EQU  0x59000014     ;SPI0 Rx data

SPCON1      EQU  0x59000020     ;SPI1 control
SPSTA1      EQU  0x59000024     ;SPI1 status
SPPIN1      EQU  0x59000028     ;SPI1 pin control
SPPRE1      EQU  0x5900002c     ;SPI1 baud rate prescaler
SPTDAT1     EQU  0x59000030     ;SPI1 Tx data
SPRDAT1     EQU  0x59000034     ;SPI1 Rx data

;=================
; SD Interface
;=================
SDICON      EQU  0x5a000000     ;SDI control
SDIPRE      EQU  0x5a000000     ;SDI baud rate prescaler
SDICmdArg   EQU  0x5a000000     ;SDI command argument
SDICmdCon   EQU  0x5a000000     ;SDI command control
SDICmdSta   EQU  0x5a000000     ;SDI command status
SDIRSP0     EQU  0x5a000000     ;SDI response 0
SDIRSP1     EQU  0x5a000000     ;SDI response 1
SDIRSP2     EQU  0x5a000000     ;SDI response 2
SDIRSP3     EQU  0x5a000000     ;SDI response 3
SDIDTimer   EQU  0x5a000000     ;SDI data/busy timer
SDIBSize    EQU  0x5a000000     ;SDI block size
SDIDatCon   EQU  0x5a000000     ;SDI data control
SDIDatCnt   EQU  0x5a000000     ;SDI data remain counter
SDIDatSta   EQU  0x5a000000     ;SDI data status
SDIFSTA     EQU  0x5a000000     ;SDI FIFO status
SDIIntMsk   EQU  0x5a000000     ;SDI interrupt mask
SDIDAT      EQU  0x5a00003c     ;SDI data

             
;=================
; ISR
;=================
;_ISR_STARTADDRESS=0x33ffff00 
pISR_RESET     EQU  (0x33ffff00 +0x0)
pISR_UNDEF     EQU  (0x33ffff00 +0x4)
pISR_SWI       EQU  (0x33ffff00 +0x8)
pISR_PABORT    EQU  (0x33ffff00 +0xc)
pISR_DABORT    EQU  (0x33ffff00 +0x10)
pISR_RESERVED  EQU  (0x33ffff00 +0x14)
pISR_IRQ       EQU  (0x33ffff00 +0x18)
pISR_FIQ       EQU  (0x33ffff00 +0x1c)
pISR_EINT0     EQU  (0x33ffff00 +0x20)
pISR_EINT1     EQU  (0x33ffff00 +0x24)
pISR_EINT2     EQU  (0x33ffff00 +0x28)
pISR_EINT3     EQU  (0x33ffff00 +0x2c)
pISR_EINT4_7   EQU  (0x33ffff00 +0x30)
pISR_EINT8_23  EQU  (0x33ffff00 +0x34)
pISR_NOTUSED6  EQU  (0x33ffff00 +0x38)
pISR_BAT_FLT   EQU  (0x33ffff00 +0x3c)
pISR_TICK      EQU  (0x33ffff00 +0x40)
pISR_WDT       EQU  (0x33ffff00 +0x44)
pISR_TIMER0    EQU  (0x33ffff00 +0x48)
pISR_TIMER1    EQU  (0x33ffff00 +0x4c)
pISR_TIMER2    EQU  (0x33ffff00 +0x50)
pISR_TIMER3    EQU  (0x33ffff00 +0x54)
pISR_TIMER4    EQU  (0x33ffff00 +0x58)
pISR_UART2     EQU  (0x33ffff00 +0x5c)
pISR_LCD       EQU  (0x33ffff00 +0x60)
pISR_DMA0      EQU  (0x33ffff00 +0x64)
pISR_DMA1      EQU  (0x33ffff00 +0x68)
pISR_DMA2      EQU  (0x33ffff00 +0x6c)
pISR_DMA3      EQU  (0x33ffff00 +0x70)
pISR_SDI       EQU  (0x33ffff00 +0x74)
pISR_SPI0      EQU  (0x33ffff00 +0x78)
pISR_UART1     EQU  (0x33ffff00 +0x7c)
pISR_NOTUSED24 EQU  (0x33ffff00 +0x80)
pISR_USBD      EQU  (0x33ffff00 +0x84)
pISR_USBH      EQU  (0x33ffff00 +0x88)
pISR_IIC       EQU  (0x33ffff00 +0x8c)
pISR_UART0     EQU  (0x33ffff00 +0x90)
pISR_SPI1      EQU  (0x33ffff00 +0x94)
pISR_RTC       EQU  (0x33ffff00 +0x98)
pISR_ADC       EQU  (0x33ffff00 +0xa0)


;=================
; PENDING BIT
;=================
BIT_EINT0     EQU  (0x1)
BIT_EINT1     EQU  (0x1<<1)
BIT_EINT2     EQU  (0x1<<2)
BIT_EINT3     EQU  (0x1<<3)
BIT_EINT4_7   EQU  (0x1<<4)
BIT_EINT8_23  EQU  (0x1<<5)
BIT_NOTUSED6  EQU  (0x1<<6)
BIT_BAT_FLT   EQU  (0x1<<7)
BIT_TICK      EQU  (0x1<<8)
BIT_WDT       EQU  (0x1<<9)
BIT_TIMER0    EQU  (0x1<<10)
BIT_TIMER1    EQU  (0x1<<11)
BIT_TIMER2    EQU  (0x1<<12)
BIT_TIMER3    EQU  (0x1<<13)
BIT_TIMER4    EQU  (0x1<<14)
BIT_UART2     EQU  (0x1<<15)
BIT_LCD       EQU  (0x1<<16)
BIT_DMA0      EQU  (0x1<<17)
BIT_DMA1      EQU  (0x1<<18)
BIT_DMA2      EQU  (0x1<<19)
BIT_DMA3      EQU  (0x1<<20)
BIT_SDI       EQU  (0x1<<21)
BIT_SPI0      EQU  (0x1<<22)
BIT_UART1     EQU  (0x1<<23)
BIT_NOTUSED24 EQU  (0x1<<24)
BIT_USBD      EQU  (0x1<<25)
BIT_USBH      EQU  (0x1<<26)
BIT_IIC       EQU  (0x1<<27)
BIT_UART0     EQU  (0x1<<28)
BIT_SPI1      EQU  (0x1<<29)
BIT_RTC       EQU  (0x1<<30)
BIT_ADC       EQU  (0x1<<31)
BIT_ALLMSK    EQU  (0xffffffff)

        END