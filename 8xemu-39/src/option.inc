;-----------------------------------------------------------------------------
;
;                  Option.inc
;
;  2005. 02  modified for MBA-2410 by Wooki of AIJI System Co., Ltd.
;                                              www.aijisystem.com
;-----------------------------------------------------------------------------



;Start address of each stacks,
_STACK_BASEADDRESS	EQU 0x08038000
_MMUTT_STARTADDRESS	EQU 0x0803c000
_ISR_STARTADDRESS	EQU 0x08039f20

;	GBLL 	PLL_ON_START
;PLL_ON_START	SETL 	{TRUE}
PLL_ON_START	SETA 	1

;	GBLL	ENDIAN_CHANGE
;ENDIAN_CHANGE	SETL	{FALSE}
ENDIAN_CHANGE	SETA	0

;	GBLA	ENTRY_BUS_WIDTH
ENTRY_BUS_WIDTH	SETA	16	



;BUSWIDTH = 16,32
;	GBLA    BUSWIDTH	;max. bus width for the GPIO configuration
BUSWIDTH	SETA    32


;	GBLA	FCLK
FCLK		SETA	50000000

    IF	FCLK = 20000000	
M_MDIV	EQU	0x20	;Fin=12.0MHz Fout=30.0MHz
M_PDIV	EQU	0x4
M_SDIV	EQU	0x2
    ENDIF

    IF	FCLK = 30000000	
M_MDIV	EQU	0x34	;Fin=12.0MHz Fout=30.0MHz
M_PDIV	EQU	0x4
M_SDIV	EQU	0x2
    ENDIF

    IF	FCLK = 50000000	
M_MDIV	EQU	0x5c	;Fin=12.0MHz Fout=50.0MHz
M_PDIV	EQU	0x4
M_SDIV	EQU	0x2
    ENDIF

    IF	FCLK = 60000000	
M_MDIV	EQU	0x70	;Fin=12.0MHz Fout=60.0MHz
M_PDIV	EQU	0x4
M_SDIV	EQU	0x2
    ENDIF

    IF	FCLK = 70000000	
M_MDIV	EQU	0x84	;Fin=12.0MHz Fout=70.0MHz
M_PDIV	EQU	0x4
M_SDIV	EQU	0x2
    ENDIF

    IF	FCLK = 75000000	
M_MDIV	EQU	0x8e	;Fin=12.0MHz Fout=75.0MHz
M_PDIV	EQU	0x4
M_SDIV	EQU	0x2
    ENDIF

;	END
