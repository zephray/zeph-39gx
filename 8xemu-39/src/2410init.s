;-----------------------------------------------------------------------------
;
;          Cstartup file for MBA-2410
;
; This file contains the startup code used by the ICCARM C compiler.
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbols ?cstartup etc.
; If this entire file is assembled and linked with the provided
; libraries, the XLINK option -C must be used to avoid a clash with
; PROGRAM module ?RESET.
; EWARM also has a check box to "Ignore CSTARTUP in library", that has
; the same effect.
;
; All code in the modules (except ?RESET) will be placed in the ICODE segment,
; that must be reachable by a B instruction in ARM mode from segment INTVEC
; (within the first 32 Mbytes).
;
; Define preprocessor symbol __THUMB_LIBRARY__ for Thumb libraries
; or __ARM_LIBRARIES__ for ARM libraries.
;
; Based on cstartup.s79 1.34.
; $Revision: 1.2 $
; modified for MBA-2410 by Wooki of AIJISystem Co., Ltd.
;-----------------------------------------------------------------------------
#include "Option.inc"
#include "2410addr.s"

;  Make sure that __ARM_LIBRARY__ or __THUMB_LIBRARY__ is defined

#define __ARM_LIBRARY__ 1

#ifdef __ARM_LIBRARY__
#ifdef __THUMB_LIBRARY__
#error "Cannot have both __ARM_LIBRARY__ and __THUMB_LIBRARY__ set!"
#endif
#else
#ifndef __THUMB_LIBRARY__
#error "Must have one of  __ARM_LIBRARY__ or __THUMB_LIBRARY__ set!"
#endif
#endif
	
;
; Naming covention of labels in this file:
;
;  ?xxx	  - External labels only accessed from assembler.
;  __xxx  - External labels accessed from or defined in C.
;  xxx	  - Labels local to one module (note: this file contains
;           several modules).
;  main	  - The starting point of the user program.
;


#if __LITTLE_ENDIAN__==1
; RTMODEL attribute __endian

#define ENDIAN_MODE	"little"

#else
#define ENDIAN_MODE	"big"
#endif


#ifdef __THUMB_LIBRARY__

; RTMODEL attribute __cpu_mode
#define CPU_MODE_NAME	"thumb"
; Segment used for libraries
#define LIB_SEGMENT	CODE

CPU_MODE	MACRO
		CODE16
		ENDM


MOV_PC_LR    MACRO
            bx lr
	     ENDM

MOVEQ_PC_LR MACRO
    	    bxeq lr
            ENDM

#else		/////// __ARM_LIBRARY__

; RTMODEL attribute __cpu_mode
#define CPU_MODE_NAME	"arm"
; Segment used for libraries
#define LIB_SEGMENT	CODE

CPU_MODE	MACRO
		CODE32
		ENDM


MOV_PC_LR   MACRO 	
            mov	pc,lr
	    ENDM


MOVEQ_PC_LR MACRO
           moveq pc,lr
            ENDM


#endif

//#define _ISR_STARTADDRESS	ISR_AREA
#define _ISR_STARTADDRESS	0x33FFFF00

SEGMENT_ALIGN	DEFINE	2		; Align all segments to 2^2

BIT_SELFREFRESH DEFINE	(1<<22)
USERMODE    DEFINE 	0x10
FIQMODE     DEFINE	0x11
IRQMODE     DEFINE 	0x12
SVCMODE     DEFINE 	0x13
ABORTMODE   DEFINE 	0x17
UNDEFMODE   DEFINE 	0x1b
MODEMASK    DEFINE 	0x1f
NOINT       DEFINE 	0xc0


UserStack	DEFINE	(_STACK_BASEADDRESS-0x3800)	;0x30ff4800 ~
SVCStack        DEFINE	(_STACK_BASEADDRESS-0x2800) 	;0x30ff5800 ~
UndefStack	DEFINE	(_STACK_BASEADDRESS-0x2400) 	;0x30ff5c00 ~
AbortStack	DEFINE	(_STACK_BASEADDRESS-0x2000) 	;0x30ff6000 ~
IRQStack        DEFINE	(_STACK_BASEADDRESS-0x1000)	;0x30ff7000 ~
FIQStack	DEFINE	(_STACK_BASEADDRESS-0x0)	;0x30ff8000 ~
;---------------------------------------------------------------
; ?RESET
; Reset Vector.
; Normally, segment INTVEC is linked at address 0.
; For debugging purposes, INTVEC may be placed at other
; addresses.
; A debugger that honors the entry point will start the
; program in a normal way even if INTVEC is not at address 0.
;---------------------------------------------------------------


	RSEG	DATA_ID:DATA(2)
	RSEG	DATA_I:DATA(2)
	RSEG	DATA_Z:DATA(2)
	
	//EXTERN	Main    // The main entry of mon program
	EXTERN	?main    // The main entry of mon program
	RSEG	ICODE:CODE:NOROOT(2)
	PUBLIC	__program_start

                LTORG
		CODE32	; Always ARM mode after reset	
		org	0	
__program_start
		B  ?cstartup
		B  HandlerUndef
		B  HandlerSWI
		B  HandlerPabort
		B  HandlerDabort
		B  .
		B  HandlerIRQ
		B  HandlerFIQ



	LTORG

;void EnterPWDN(int CLKCON);
EnterPWDN			
	mov r2,r0		;r2=rCLKCON
	tst r0,#0x8		;POWER_OFF mode?
	bne ENTER_POWER_OFF

ENTER_STOP	
	ldr r0,=REFRESH		
	ldr r3,[r0]		;r3=rREFRESH	
	mov r1, r3
	orr r1, r1, #BIT_SELFREFRESH
	str r1, [r0]		;Enable SDRAM self-refresh

	mov r1,#16	   	;wait until self-refresh is issued. may not be needed.
EX_XX0	subs r1,r1,#1
	bne EX_XX0

	ldr r0,=CLKCON		;enter STOP mode.
	str r2,[r0]

	mov r1,#32
EX_XX1	subs r1,r1,#1	;1) wait until the STOP mode is in effect.
	bne EX_XX0		;2) Or wait here until the CPU&Peripherals will be turned-off
			;   Entering POWER_OFF mode, only the reset by wake-up is available.

	ldr r0,=REFRESH ;exit from SDRAM self refresh mode.
	str r3,[r0]
	
	MOV_PC_LR

ENTER_POWER_OFF	
	;NOTE.
	;1) rGSTATUS3 should have the return address after wake-up from POWER_OFF mode.
	
	ldr r0,=REFRESH		
	ldr r1,[r0]		;r1=rREFRESH	
	orr r1, r1, #BIT_SELFREFRESH
	str r1, [r0]		;Enable SDRAM self-refresh

	mov r1,#16	   	;Wait until self-refresh is issued,which may not be needed.
E_XX0	subs r1,r1,#1
	bne E_XX0

	ldr 	r1,=MISCCR
	ldr	r0,[r1]
	orr	r0,r0,#(7<<17)  ;Make sure that SCLK0:SCLK->0, SCLK1:SCLK->0, SCKE=L during boot-up
	str	r0,[r1]

	ldr r0,=CLKCON
	str r2,[r0]

	b .			;CPU will die here.

WAKEUP_POWER_OFF
	;Release SCLKn after wake-up from the POWER_OFF mode.
	ldr 	r1,=MISCCR
	ldr	r0,[r1]
	bic	r0,r0,#(7<<17)  ;SCLK0:0->SCLK, SCLK1:0->SCLK, SCKE:L->H
	str	r0,[r1]
	
	;Set memory control registers
    	ldr	r0,=SMRDATA
	ldr	r1,=BWSCON	;BWSCON Address
	add	r2, r0, #52	;End address of SMRDATA
W_XX0
	ldr	r3, [r0], #4
	str	r3, [r1], #4
	cmp	r2, r0		
	bne	W_XX0

	mov r1,#256
W_XX1	subs r1,r1,#1	;1) wait until the SelfRefresh is released.
	bne W_XX1	

	ldr r1,=GSTATUS3 	;GSTATUS3 has the start address just after POWER_OFF wake-up
	ldr r0,[r1]
	mov pc,r0

	LTORG

		
?ex_hander:		
HandlerIRQ:
		sub	sp,sp,#4        ;decrement sp(to store jump address)
		stmfd	sp!,{r0}        ;PUSH the work register to stack(lr does't push because it return to original address)
		ldr     r0,=HandleIRQ	;load the address of HandleXXX to r0
		ldr     r0,[r0]         ;load the contents(service routine start address) of HandleXXX
		str     r0,[sp,#4]      ;store the contents(ISR) of HandleXXX to stack
		ldmfd   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)

	//	ldmia   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)
HandlerUndef:
		sub	sp,sp,#4        ;decrement sp(to store jump address)
		stmfd	sp!,{r0}        ;PUSH the work register to stack(lr does't push because it return to original address)
		ldr     r0,=HandleUndef	;load the address of HandleXXX to r0
		ldr     r0,[r0]         ;load the contents(service routine start address) of HandleXXX
		str     r0,[sp,#4]      ;store the contents(ISR) of HandleXXX to stack
		ldmfd   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)
HandlerSWI:
		sub	sp,sp,#4        ;decrement sp(to store jump address)
		stmfd	sp!,{r0}        ;PUSH the work register to stack(lr does't push because it return to original address)
		ldr     r0,=HandleSWI	;load the address of HandleXXX to r0
		ldr     r0,[r0]         ;load the contents(service routine start address) of HandleXXX
		str     r0,[sp,#4]      ;store the contents(ISR) of HandleXXX to stack
		ldmfd   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)
HandlerDabort:
		sub	sp,sp,#4        ;decrement sp(to store jump address)
		stmfd	sp!,{r0}        ;PUSH the work register to stack(lr does't push because it return to original address)
		ldr     r0,=HandleDabort	;load the address of HandleXXX to r0
		ldr     r0,[r0]         ;load the contents(service routine start address) of HandleXXX
		str     r0,[sp,#4]      ;store the contents(ISR) of HandleXXX to stack
		ldmfd   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)
HandlerPabort:
		sub	sp,sp,#4        ;decrement sp(to store jump address)
		stmfd	sp!,{r0}        ;PUSH the work register to stack(lr does't push because it return to original address)
		ldr     r0,=HandlePabort	;load the address of HandleXXX to r0
		ldr     r0,[r0]         ;load the contents(service routine start address) of HandleXXX
		str     r0,[sp,#4]      ;store the contents(ISR) of HandleXXX to stack
		ldmfd   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)

HandlerFIQ:
		sub	sp,sp,#4        ;decrement sp(to store jump address)
		stmfd	sp!,{r0}        ;PUSH the work register to stack(lr does't push because it return to original address)
		ldr     r0,=HandleFIQ	;load the address of HandleXXX to r0
		ldr     r0,[r0]         ;load the contents(service routine start address) of HandleXXX
		str     r0,[sp,#4]      ;store the contents(ISR) of HandleXXX to stack
		ldmfd   sp!,{r0,pc}     ;POP the work register and pc(jump to ISR)


IsrIRQ:
		sub	sp,sp,#4       ;reserved for PC
		stmfd	sp!,{r8-r9}
		ldr	r9,=INTOFFSET
		ldr	r9,[r9]
		ldr	r8,=HandleEINT0
		add	r8,r8,r9,lsl #2
		ldr	r8,[r8]
		str	r8,[sp,#8]
		ldmfd	sp!,{r8-r9,pc}

?cstartup

; Initialize System Registers.


		ldr		r0,=WTCON       ;watch dog disable
		ldr		r1,=0x0
		str		r1,[r0]

		ldr		r0,=INTMSK
		ldr		r1,=0xffffffff  ;all interrupt disable
		str		r1,[r0]

		ldr		r0,=INTSUBMSK
		ldr		r1,=0x3ff		;all sub interrupt disable
		str		r1,[r0]

		ldr		r0,=GPFCON
		ldr		r1,=0x5500		
		str		r1,[r0]
		ldr		r0,=GPFDAT
		ldr		r1,=0x10
		str		r1,[r0]
	
		;To reduce PLL lock time, adjust the LOCKTIME register.
		ldr		r0,=LOCKTIME
		ldr		r1,=0xffffff
		str		r1,[r0]

		;Configure MPLL
		ldr		r0,=MPLLCON
		ldr		r1,=0x0
		str		r1,[r0]

	;Check if the boot is caused by the wake-up from POWER_OFF mode.
	ldr	r1,=GSTATUS2
	ldr	r0,[r1]
	tst	r0,#0x2
        ;In case of the wake-up from POWER_OFF mode, go to POWER_OFF_WAKEUP handler.
	bne	WAKEUP_POWER_OFF

	EXPORT StartPointAfterPowerOffWakeUp
StartPointAfterPowerOffWakeUp


  ldr	r0,=SMRDATA
	ldr	r1,=BWSCON	;BWSCON Address
	add	r2, r0, #52	;End address of SMRDATA
SMRDATA_SET:
	ldr	r3, [r0], #4
	str	r3, [r1], #4
	cmp	r2, r0		
	bne	SMRDATA_SET

	// bl	InitStacks

InitStacks
	mrs	r0,cpsr
	bic	r0,r0,#MODEMASK
	orr	r1,r0,#UNDEFMODE|NOINT
	msr	cpsr_cxsf,r1		;UndefMode
	ldr	sp,=UndefStack
	
	orr	r1,r0,#ABORTMODE|NOINT
	msr	cpsr_cxsf,r1		;AbortMode
	ldr	sp,=AbortStack

	orr	r1,r0,#IRQMODE|NOINT
	msr	cpsr_cxsf,r1		;IRQMode
	ldr	sp,=IRQStack

	orr	r1,r0,#FIQMODE|NOINT
	msr	cpsr_cxsf,r1		;FIQMode
	ldr	sp,=FIQStack

	bic	r0,r0,#MODEMASK|NOINT
	orr	r1,r0,#SVCMODE
	msr	cpsr_cxsf,r1		;SVCMode
	ldr	sp,=SVCStack
	
	;USER mode has not be initialized.
	
	// mov	pc,lr
	;The LR register won't be valid if the current mode is not SVC mode.



  ; Setup IRQ handler
        ldr	  r0,=HandleIRQ       ;This routine is needed
        ldr	  r1,=IsrIRQ          ;if there isn't 'subs pc,lr,#4' at 0x18, 0x1c
	str	  r1,[r0]

/*
        //아래와 같이 RAM COPY루닡이 있는데, 이것을 사용하지 않아도 동작에는 이상이 없다.
	//Copy and paste RW data/zero initialized data
	ldr	r0, =SFE(DATA_ID)	// Get pointer to ROM data
	ldr	r1, =SFB(DATA_I)	// and RAM copy
	ldr	r3, =SFE(DATA_I)

	//Zero init base => top of initialised data
	cmp	r0, r1			// Check that they are different
	beq	__xx07
__xx06
	cmp	r1, r3			// Copy init data
	ldrcc	r2, [r0], #4		//--> LDRCC r2, [r0] + ADD r0, r0, #4
	strcc	r2, [r1], #4		//--> STRCC r2, [r1] + ADD r1, r1, #4
	bcc	__xx06
__xx07
	ldr	r1, =SFE(DATA_Z)	// Top of zero init segment
	mov	r2, #0
__xx08
	cmp	r3, r1      // Zero init
	strcc	r2, [r3], #4
	bcc	__xx08

*/



	
#ifdef __ARMVFP__
; Enable the VFP coprocessor.
                mov     r0, #0x30000000                 ; Set EN bit in VFP
                fmxr    fpexc, r0                       ; FPEXC, clear others.

; Disable underflow exceptions by setting flush to zero mode.
; For full IEEE 754 underflow compliance this code should be removed
; and the appropriate exception handler installed.
                mov     r0, #0x01000000		        ; Set FZ bit in VFP
                fmxr    fpscr, r0                       ; FPSCR, clear others.
#endif

; Add more initialization here


; Continue to Main for more IAR specific system startup

                ldr     r0,=?main
//                ldr     r0,=Main
                bx      r0




SMRDATA DATA
; Memory configuration should be optimized for best performance
; The following parameter is not optimized.
; Memory access cycle parameter strategy
; 1) The memory settings is  safe parameters even at HCLK=75Mhz.
; 2) SDRAM refresh period is for HCLK=75Mhz.

        DCD (0+(B1_BWSCON<<4)+(B2_BWSCON<<8)+(B3_BWSCON<<12)+(B4_BWSCON<<16)+(B5_BWSCON<<20)+(B6_BWSCON<<24)+(B7_BWSCON<<28))
    	DCD ((B0_Tacs<<13)+(B0_Tcos<<11)+(B0_Tacc<<8)+(B0_Tcoh<<6)+(B0_Tah<<4)+(B0_Tacp<<2)+(B0_PMC))   ;GCS0
    	DCD ((B1_Tacs<<13)+(B1_Tcos<<11)+(B1_Tacc<<8)+(B1_Tcoh<<6)+(B1_Tah<<4)+(B1_Tacp<<2)+(B1_PMC))   ;GCS1
    	DCD ((B2_Tacs<<13)+(B2_Tcos<<11)+(B2_Tacc<<8)+(B2_Tcoh<<6)+(B2_Tah<<4)+(B2_Tacp<<2)+(B2_PMC))   ;GCS2
    	DCD ((B3_Tacs<<13)+(B3_Tcos<<11)+(B3_Tacc<<8)+(B3_Tcoh<<6)+(B3_Tah<<4)+(B3_Tacp<<2)+(B3_PMC))   ;GCS3
    	DCD ((B4_Tacs<<13)+(B4_Tcos<<11)+(B4_Tacc<<8)+(B4_Tcoh<<6)+(B4_Tah<<4)+(B4_Tacp<<2)+(B4_PMC))   ;GCS4
    	DCD ((B5_Tacs<<13)+(B5_Tcos<<11)+(B5_Tacc<<8)+(B5_Tcoh<<6)+(B5_Tah<<4)+(B5_Tacp<<2)+(B5_PMC))   ;GCS5
    	DCD ((B6_MT<<15)+(B6_Trcd<<2)+(B6_SCAN))    ;GCS6
    	DCD ((B7_MT<<15)+(B7_Trcd<<2)+(B7_SCAN))    ;GCS7
    	DCD ((REFEN<<23)+(TREFMD<<22)+(Trp<<20)+(Trc<<18)+(Tchr<<16)+REFCNT)



	DCD 0x32            ;SCLK power saving mode, BANKSIZE 128M/128M

    	DCD 0x30            ;MRSR6 CL=3clk
    	DCD 0x30            ;MRSR7
;    	DCD 0x20            ;MRSR6 CL=2clk
;    	DCD 0x20            ;MRSR7

;    	ALIGNROM 5
;        ALIGNROM 3
    	
		LTORG


		ASEGN  __ISR_AREA, _ISR_STARTADDRESS	

_isr_init:
HandleReset 	DS32   1
HandleUndef 	DS32   1
HandleSWI   	DS32   1
HandlePabort    DS32   1
HandleDabort    DS32   1
HandleReserved  DS32   1
HandleIRQ   	DS32   1
HandleFIQ   	DS32   1

;Don't use the label 'IntVectorTable',
;The value of IntVectorTable is different with the address you think it may be.
;IntVectorTable

HandleEINT0   	DS32   1
HandleEINT1   	DS32   1
HandleEINT2   	DS32   1
HandleEINT3   	DS32   1
HandleEINT4_7	DS32   1
HandleEINT8_23	DS32   1
HandleRSV6	DS32   1
HandleBATFLT   	DS32   1
HandleTICK   	DS32   1
HandleWDT	DS32   1
HandleTIMER0 	DS32   1
HandleTIMER1 	DS32   1
HandleTIMER2 	DS32   1
HandleTIMER3 	DS32   1
HandleTIMER4 	DS32   1
HandleUART2  	DS32   1
HandleLCD 	DS32   1
HandleDMA0	DS32   1
HandleDMA1	DS32   1
HandleDMA2	DS32   1
HandleDMA3	DS32   1
HandleMMC	DS32   1
HandleSPI0	DS32   1
HandleUART1	DS32   1
HandleRSV24	DS32   1
HandleUSBD	DS32   1
HandleUSBH	DS32   1
HandleIIC   	DS32   1
HandleUART0 	DS32   1
HandleSPI1 	DS32   1
HandleRTC 	DS32   1
HandleADC 	DS32   1


		LTORG



		END








