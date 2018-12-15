*:*********************************************************************
*:
*: Procedure file: UTILITY.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 11:27 am
*:
*:  Procs & Fncts: MENU
*:               : PICK
*:               : OPENFILE
*:               : CLRSCRN
*:               : FRAME
*:               : CHECKKEY
*:               : FLUSH
*:               : GETPASS
*:               : PROMPT
*:               : STATUS
*:               : TAIL
*:               : DATETAIL
*:               : PASSWORD
*:               : CHNGPASS
*:               : YESNO
*:               : READCLI
*:               : WRITECLI
*:               : GETNCLI
*:               : GETCLI
*:               : PUTCLI
*:               : PRINTCLI
*:               : READMRK
*:               : WRITEMRK
*:               : PUTMRK
*:               : PRINTMRK
*:               : READSCH
*:               : WRITESCH
*:               : READBUS
*:               : WRTEBUS
*:               : GETBUS
*:				 : READLF
*:               : WRITELF
*:
*:     Documented: 09/04/88 at 16:51               FoxDoc version 1.0
*:*********************************************************************
*                                                                     *
* UTILTIY >>> Contains dbase III subroutines                          *
*                                                                     *
***********************************************************************

*************************************************************************
*                                      									*
* MENU >>> Display the menu window	                              		*
*	   entry : MENU_CNT, MENU_1, ... , MENU_8                      		*
*              DESC_1, DESC_2 ..., DESC_8                               *
*              CHOICE                                                   *
*	   exit : None						                               	*
*							                                       		*
*************************************************************************

procedure menu
if COLOR_SCRN
	set color to gr+/n,w+/n,n,n
else
	set color to w+/n,w+/n,n,n
endif

@ 5,0 say "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
@ 6,0 say "≥                                                                              ≥"
@ 7,0 say "≥                                                                              ≥"
@ 8,0 say "≥                                                                              ≥"
@ 9,0 say "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
set color to w/n,w+/n,n,n

*
* Initialize
*

do case
	
case MENU_CNT = 1
	store 2 to SEL_1
	if CHOICE > 1
		store 1 to CHOICE
		
	endif
	
case MENU_CNT = 2
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	if CHOICE > 2
		store 2 to CHOICE
		
	endif
	
case MENU_CNT = 3
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	store SEL_2 + len(MENU_2) + 1 to SEL_3
	if CHOICE > 3
		store 3 to CHOICE
		
	endif
	
case MENU_CNT = 4
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	store SEL_2 + len(MENU_2) + 1 to SEL_3
	store SEL_3 + len(MENU_3) + 1 to SEL_4
	if CHOICE > 4
		store 4 to CHOICE
		
	endif
	
case MENU_CNT = 5
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	store SEL_2 + len(MENU_2) + 1 to SEL_3
	store SEL_3 + len(MENU_3) + 1 to SEL_4
	store SEL_4 + len(MENU_4) + 1 to SEL_5
	if CHOICE > 5
		store 5 to CHOICE
		
	endif
	
case MENU_CNT = 6
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	store SEL_2 + len(MENU_2) + 1 to SEL_3
	store SEL_3 + len(MENU_3) + 1 to SEL_4
	store SEL_4 + len(MENU_4) + 1 to SEL_5
	store SEL_5 + len(MENU_5) + 1 to SEL_6
	if CHOICE > 6
		store 6 to CHOICE
		
	endif
	
case MENU_CNT = 7
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	store SEL_2 + len(MENU_2) + 1 to SEL_3
	store SEL_3 + len(MENU_3) + 1 to SEL_4
	store SEL_4 + len(MENU_4) + 1 to SEL_5
	store SEL_5 + len(MENU_5) + 1 to SEL_6
	store SEL_6 + len(MENU_6) + 1 to SEL_7
	if CHOICE > 7
		store 7 to CHOICE
		
	endif
	
case MENU_CNT = 8
	store 2 to SEL_1
	store SEL_1 + len(MENU_1) + 1 to SEL_2
	store SEL_2 + len(MENU_2) + 1 to SEL_3
	store SEL_3 + len(MENU_3) + 1 to SEL_4
	store SEL_4 + len(MENU_4) + 1 to SEL_5
	store SEL_5 + len(MENU_5) + 1 to SEL_6
	store SEL_6 + len(MENU_6) + 1 to SEL_7
	store SEL_7 + len(MENU_7) + 1 to SEL_8
	if CHOICE > 8
		store 8 to CHOICE
		
	endif
	
endcase

*
* Make selection
*

store .t. to CHOOSE

do while CHOOSE
	do case
		
	case MENU_CNT = 1
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
		endcase
		
	case MENU_CNT = 2
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		endcase
		
	case MENU_CNT = 3
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		case CHOICE = 3
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			set color to n/w,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_3
			
		endcase
		
	case MENU_CNT = 4
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		case CHOICE = 3
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			set color to n/w,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			set color to w/n,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			@ 8,2 say space(76)
			@ 8,2 say DESC_3
			
		case CHOICE = 4
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			set color to n/w,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_4
			
		endcase
		
	case MENU_CNT = 5
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		case CHOICE = 3
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			set color to n/w,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			set color to w/n,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 8,2 say space(76)
			@ 8,2 say DESC_3
			
		case CHOICE = 4
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			set color to n/w,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			set color to w/n,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			@ 8,2 say space(76)
			@ 8,2 say DESC_4
			
		case CHOICE = 5
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			set color to n/w,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_5
			
		endcase
		
	case MENU_CNT = 6
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		case CHOICE = 3
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			set color to n/w,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			set color to w/n,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 8,2 say space(76)
			@ 8,2 say DESC_3
			
		case CHOICE = 4
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			set color to n/w,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			set color to w/n,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 8,2 say space(76)
			@ 8,2 say DESC_4
			
		case CHOICE = 5
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			set color to n/w,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			set color to w/n,w+/n,n,n
			@ 6,SEL_6 say MENU_6
			@ 8,2 say space(76)
			@ 8,2 say DESC_5
			
		case CHOICE = 6
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			set color to n/w,w+/n,n,n
			@ 6,SEL_6 say MENU_6
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_6
			
		endcase
		
	case MENU_CNT = 7
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		case CHOICE = 3
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			set color to n/w,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			set color to w/n,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 8,2 say space(76)
			@ 8,2 say DESC_3
			
		case CHOICE = 4
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			set color to n/w,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			set color to w/n,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 8,2 say space(76)
			@ 8,2 say DESC_4
			
		case CHOICE = 5
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			set color to n/w,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			set color to w/n,w+/n,n,n
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 8,2 say space(76)
			@ 8,2 say DESC_5
			
		case CHOICE = 6
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			set color to n/w,w+/n,n,n
			@ 6,SEL_6 say MENU_6
			set color to w/n,w+/n,n,n
			@ 6,SEL_7 say MENU_7
			@ 8,2 say space(76)
			@ 8,2 say DESC_6
			
		case CHOICE = 7
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			set color to n/w,w+/n,n,n
			@ 6,SEL_7 say MENU_7
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_7
			
		endcase
		
	case MENU_CNT = 8
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ 6,SEL_1 say MENU_1
			set color to w/n,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_1
			
		case CHOICE = 2
			@ 6,SEL_1 say MENU_1
			set color to n/w,w+/n,n,n
			@ 6,SEL_2 say MENU_2
			set color to w/n,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_2
			
		case CHOICE = 3
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			set color to n/w,w+/n,n,n
			@ 6,SEL_3 say MENU_3
			set color to w/n,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_3
			
		case CHOICE = 4
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			set color to n/w,w+/n,n,n
			@ 6,SEL_4 say MENU_4
			set color to w/n,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_4
			
		case CHOICE = 5
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			set color to n/w,w+/n,n,n
			@ 6,SEL_5 say MENU_5
			set color to w/n,w+/n,n,n
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_5
			
		case CHOICE = 6
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			set color to n/w,w+/n,n,n
			@ 6,SEL_6 say MENU_6
			set color to w/n,w+/n,n,n
			@ 6,SEL_7 say MENU_7
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_6
			
		case CHOICE = 7
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			set color to n/w,w+/n,n,n
			@ 6,SEL_7 say MENU_7
			set color to w/n,w+/n,n,n
			@ 6,SEL_8 say MENU_8
			@ 8,2 say space(76)
			@ 8,2 say DESC_7
			
		case CHOICE = 8
			@ 6,SEL_1 say MENU_1
			@ 6,SEL_2 say MENU_2
			@ 6,SEL_3 say MENU_3
			@ 6,SEL_4 say MENU_4
			@ 6,SEL_5 say MENU_5
			@ 6,SEL_6 say MENU_6
			@ 6,SEL_7 say MENU_7
			set color to n/w,w+/n,n,n
			@ 6,SEL_8 say MENU_8
			set color to w/n,w+/n,n,n
			@ 8,2 say space(76)
			@ 8,2 say DESC_8
			
		endcase
		
	endcase
	
	store 0 to key
	do while (key = 0)
		store inkey() to key
		
		if key <> 0
			do case
				
				*
				* Left Arrow (<-) for LEFT
				*
				
			case key = 19 .or. key = 26 .or. key = 34
				if CHOICE > 1
					store CHOICE - 1 to CHOICE
					
				else
					store MENU_CNT to CHOICE
					
				endif
				
				*
				* Right Arrow (->) for RIGHT
				*
				
			case key = 2 .or. key = 4 .or. key = 36
				if CHOICE < MENU_CNT
					store CHOICE + 1 to CHOICE
					
				else
					store 1 to CHOICE
					
				endif
				
				*
				* RET KEY (ƒƒŸ) when DONE
				*
				
			case key = 13
				store .f. to CHOOSE
				
			endcase
			
		endif
		
	enddo
	
enddo

*
* Clean up
*

do case
case MENU_CNT = 1
	release MENU_1
	release DESC_1
	
case MENU_CNT = 2
	release MENU_1,MENU_2
	release DESC_1,DESC_2
	
case MENU_CNT = 3
	release MENU_1,MENU_2,MENU_3
	release DESC_1,DESC_2,DESC_3
	
case MENU_CNT = 4
	release MENU_1,MENU_2,MENU_3,MENU_4
	release DESC_1,DESC_2,DESC_3,DESC_4
	
case MENU_CNT = 5
	release MENU_1,MENU_2,MENU_3,MENU_4,MENU_5
	release DESC_1,DESC_2,DESC_3,DESC_4,DESC_5
	
case MENU_CNT = 6
	release MENU_1,MENU_2,MENU_3,MENU_4,MENU_5,MENU_6
	release DESC_1,DESC_2,DESC_3,DESC_4,DESC_5,DESC_6
	
case MENU_CNT = 7
	release MENU_1,MENU_2,MENU_3,MENU_4,MENU_5,MENU_6,MENU_7
	release DESC_1,DESC_2,DESC_3,DESC_4,DESC_5,DESC_6,DESC_7
	
case MENU_CNT = 8
	release MENU_1,MENU_2,MENU_3,MENU_4,MENU_5,MENU_6,MENU_7,MENU_8
	release DESC_1,DESC_2,DESC_3,DESC_4,DESC_5,DESC_6,DESC_7,DESC_8
	
endcase

release MENU_CNT

@ 5,0 clear to 11,79

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

return

*************************************************************************
*                                      									*
* PICK >>> Display the pick window	                              		*
*	   entry : PICK_CNT, PICK_1, ... , PICK_8                      		*
*			   PICK_LINE												*
*              CHOICE                                                   *
*              SEL_NAME                                                 *
*	   exit : None						                               	*
*							                                       		*
*************************************************************************

procedure PICK
@ PICK_LINE,0

*
* Initialize
*

do case
	
case PICK_CNT = 1
	store 40 - (len(PICK_1)/2) to SEL_1
	if CHOICE > 1
		store 1 to CHOICE
		
	endif
	
case PICK_CNT = 2
	store 40 - (len(PICK_1+"  "+PICK_2)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	if CHOICE > 2
		store 2 to CHOICE
		
	endif
	
case PICK_CNT = 3
	store 40 - (len(PICK_1+"  "+PICK_2+"  "+PICK_3)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	store SEL_2 + len(PICK_2) + 2 to SEL_3
	if CHOICE > 3
		store 3 to CHOICE
		
	endif
	
case PICK_CNT = 4
	store 40 - (len(PICK_1+"  "+PICK_2+"  "+PICK_3+"  "+PICK_4)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	store SEL_2 + len(PICK_2) + 2 to SEL_3
	store SEL_3 + len(PICK_3) + 2 to SEL_4
	if CHOICE > 4
		store 4 to CHOICE
		
	endif
	
case PICK_CNT = 5
	store 40 - (len(PICK_1+"  "+PICK_2+"  "+PICK_3+"  "+PICK_4+"  "+PICK_5)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	store SEL_2 + len(PICK_2) + 2 to SEL_3
	store SEL_3 + len(PICK_3) + 2 to SEL_4
	store SEL_4 + len(PICK_4) + 2 to SEL_5
	if CHOICE > 5
		store 5 to CHOICE
		
	endif
	
case PICK_CNT = 6
	store 40 - (len(PICK_1+"  "+PICK_2+"  "+PICK_3+"  "+PICK_4+"  "+PICK_5+"  "+PICK_6)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	store SEL_2 + len(PICK_2) + 2 to SEL_3
	store SEL_3 + len(PICK_3) + 2 to SEL_4
	store SEL_4 + len(PICK_4) + 2 to SEL_5
	store SEL_5 + len(PICK_5) + 2 to SEL_6
	if CHOICE > 6
		store 6 to CHOICE
		
	endif
	
case PICK_CNT = 7
	store 40 - (len(PICK_1+"  "+PICK_2+"  "+PICK_3+"  "+PICK_4+"  "+PICK_5+"  "+PICK_6+"  "+PICK_7)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	store SEL_2 + len(PICK_2) + 2 to SEL_3
	store SEL_3 + len(PICK_3) + 2 to SEL_4
	store SEL_4 + len(PICK_4) + 2 to SEL_5
	store SEL_5 + len(PICK_5) + 2 to SEL_6
	store SEL_6 + len(PICK_6) + 2 to SEL_7
	if CHOICE > 7
		store 7 to CHOICE
		
	endif
	
case PICK_CNT = 8
	store 40 - (len(PICK_1+"  "+PICK_2+"  "+PICK_3+"  "+PICK_4+"  "+PICK_5+"  "+PICK_6+"  "+PICK_7+"  "+PICK_8)/2) to SEL_1
	store SEL_1 + len(PICK_1) + 2 to SEL_2
	store SEL_2 + len(PICK_2) + 2 to SEL_3
	store SEL_3 + len(PICK_3) + 2 to SEL_4
	store SEL_4 + len(PICK_4) + 2 to SEL_5
	store SEL_5 + len(PICK_5) + 2 to SEL_6
	store SEL_6 + len(PICK_6) + 2 to SEL_7
	store SEL_7 + len(PICK_7) + 2 to SEL_8
	if CHOICE > 8
		store 8 to CHOICE
		
	endif
	
endcase

*
* Put up prompt
*

store SEL_NAME to L_TAIL
store "Press "+chr(27)+" "+chr(26)+" to Select ƒŸ when Done" to R_TAIL
do TAIL

set color to w/n,w+/n,n,n

*
* Make selection
*

store .t. to CHOOSE

do while CHOOSE
	do case
		
	case PICK_CNT = 1
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
		endcase
		
	case PICK_CNT = 2
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			
		endcase
		
	case PICK_CNT = 3
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			
		case CHOICE = 3
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			set color to w/n,w+/n,n,n
			
		endcase
		
	case PICK_CNT = 4
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			
		case CHOICE = 3
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			
		case CHOICE = 4
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			set color to w/n,w+/n,n,n
			
		endcase
		
	case PICK_CNT = 5
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			
		case CHOICE = 3
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			
		case CHOICE = 4
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			
		case CHOICE = 5
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			set color to w/n,w+/n,n,n
			
		endcase
		
	case PICK_CNT = 6
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			
		case CHOICE = 3
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			
		case CHOICE = 4
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			
		case CHOICE = 5
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_6 say PICK_6
			
		case CHOICE = 6
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_6 say PICK_6
			set color to w/n,w+/n,n,n
			
		endcase
		
	case PICK_CNT = 7
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			
		case CHOICE = 3
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			
		case CHOICE = 4
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			
		case CHOICE = 5
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			
		case CHOICE = 6
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_6 say PICK_6
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_7 say PICK_7
			
		case CHOICE = 7
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_7 say PICK_7
			set color to w/n,w+/n,n,n
			
		endcase
		
	case PICK_CNT = 8
		do case
		case CHOICE = 1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_1 say PICK_1
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 2
			@ PICK_LINE,SEL_1 say PICK_1
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_2 say PICK_2
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 3
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_3 say PICK_3
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 4
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_4 say PICK_4
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 5
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_5 say PICK_5
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_7
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 6
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_6 say PICK_6
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_7 say PICK_7
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 7
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_7 say PICK_7
			set color to w/n,w+/n,n,n
			@ PICK_LINE,SEL_8 say PICK_8
			
		case CHOICE = 8
			@ PICK_LINE,SEL_1 say PICK_1
			@ PICK_LINE,SEL_2 say PICK_2
			@ PICK_LINE,SEL_3 say PICK_3
			@ PICK_LINE,SEL_4 say PICK_4
			@ PICK_LINE,SEL_5 say PICK_5
			@ PICK_LINE,SEL_6 say PICK_6
			@ PICK_LINE,SEL_7 say PICK_8
			set color to n/w,w+/n,n,n
			@ PICK_LINE,SEL_8 say PICK_8
			set color to w/n,w+/n,n,n
			
		endcase
		
	endcase
	
	store 0 to key
	do while (key = 0)
		store inkey() to key
		
		if key <> 0
			do case
				
				*
				* Left Arrow (<-) for LEFT
				*
				
			case key = 19 .or. key = 26 .or. key = 34
				if CHOICE > 1
					store CHOICE - 1 to CHOICE
					
				else
					store PICK_CNT to CHOICE
					
				endif
				
				*
				* Right Arrow (->) for RIGHT
				*
				
			case key = 2 .or. key = 4 .or. key = 36
				if CHOICE < PICK_CNT
					store CHOICE + 1 to CHOICE
					
				else
					store 1 to CHOICE
					
				endif
				
				*
				* RET KEY (ƒƒŸ) when DONE
				*
				
			case key = 13
				store .f. to CHOOSE
				
			endcase
			
		endif
		
	enddo
	
enddo

*
* Clean up
*

do case
case PICK_CNT = 1
	release PICK_1
	
case PICK_CNT = 2
	release PICK_1,PICK_2
	
case PICK_CNT = 3
	release PICK_1,PICK_2,PICK_3
	
case PICK_CNT = 4
	release PICK_1,PICK_2,PICK_3,PICK_4
	
case PICK_CNT = 5
	release PICK_1,PICK_2,PICK_3,PICK_4,PICK_5
	
case PICK_CNT = 6
	release PICK_1,PICK_2,PICK_3,PICK_4,PICK_5,PICK_6
	
case PICK_CNT = 7
	release PICK_1,PICK_2,PICK_3,PICK_4,PICK_5,PICK_6,PICK_7
	
case PICK_CNT = 8
	release PICK_1,PICK_2,PICK_3,PICK_4,PICK_5,PICK_6,PICK_7,PICK_8
	
endcase

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ PICK_LINE,0

release PICK_CNT,PICK_LINE

return

*************************************************************************
*                                                                       *
* OPENFILE >>> open dbase III file                                      *
*       Entry                                                           *   
*           SELECT_NBR = area number to use for select                  *
*           FILE_NAME = name of file to be opened                       *
*           ALIAS_NAME = alias name                                     *
*           INDEX_NAME = name of index to be opened                     *
*           IFLD_NAME = index field name                                *
*       Exit                                                            *
*           FILE_OPEN = .T. if successful                               *
*                       .F. if failed                                   *
*                                                                       *
*************************************************************************

procedure OPENFILE

store .f. to FILE_OPEN

do case
	
case len(FILE_NAME) > 0 .and. len(INDEX_NAME) = 0
	if file ((FILE_NAME + ".DBF"))
		select &SELECT_NBR
		use &FILE_NAME alias &ALIAS_NAME
		
		store .t. to FILE_OPEN
		
	else
		store 22 to STAT_LINE
		store "Could not open &FILE_NAME file" to STAT_MSG
		do status
		
	endif
	
case len(FILE_NAME) > 0 .and. len(INDEX_NAME) > 0
	if file ((FILE_NAME + ".DBF"))
		if file ((INDEX_NAME + ".NTX"))
			select &SELECT_NBR
			use &FILE_NAME index &INDEX_NAME alias &ALIAS_NAME
			
			store .t. to FILE_OPEN
			
		else
			
			if FILE_NAME <> "SYSTEM"
				store 22 to STAT_LINE
				store "Could not open &INDEX_NAME index" to STAT_MSG
				do status
				
				store 22 to STAT_LINE
				store "Will rebuild &FILE_NAME index file &INDEX_NAME" to STAT_MSG
				do status
				
			endif
			
			select &SELECT_NBR
			use &FILE_NAME alias &ALIAS_NAME
			index on &IFLD_NAME to &INDEX_NAME
			set index to &INDEX_NAME
			
			store .t. to FILE_OPEN
			
		endif
		
	else
		store 22 to STAT_LINE
		store "Could not open &FILE_NAME file" to STAT_MSG
		do status
		
	endif
endcase

return

*************************************************************************
*                                                              			*
* CLRSCRN >>> Erase the menu window (line 4 through line 20)		    *
*	      entry : None					                                *
*	      exit : None				                                    *
*								                                        *
*************************************************************************

procedure CLRSCRN

@ 0,0
@ 4,0 clear to 21,79

return

*************************************************************************
*                                                              			*
* FRAME >>> Erase the screen and frame with a header and trailer       	*
*	    entry : HEAD, L_TAIL, R_TAIL			                        *
*	    exit : None 			                                        *
*                                                              			*
*************************************************************************

procedure FRAME

store "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ" to T_LINE_1
store  T_LINE_1 + "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø" to T_LINE_1

store "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ" to T_LINE_2
store  T_LINE_2 + "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ" to T_LINE_2

store "                                              " to blank
store "  I n t e l l i M a i l" to HEAD_LINE
store HEAD_LINE + substr(blank,1,(56 - len(hEAD)) / 2) + hEAD to HEAD_LINE
store HEAD_LINE + substr(blank,1,79 - len(HEAD_LINE)) + " " to HEAD_LINE

if len(R_TAIL) + len(L_TAIL) > 70
	store substr(L_TAIL,1,70 - len(R_TAIL)) to L_TAIL
endif

store "ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ" to lINE
store "’[ " + space(len(L_TAIL)) + " ]" to B_LINE
store B_LINE + substr(lINE,1,80 - ((len(B_LINE) + len(R_TAIL) + 5))) to B_LINE
store len(B_LINE) + 2 to R_COL
store B_LINE + "[ " + space(len(R_TAIL)) + " ]∏" to B_LINE

store "                                       " to TAIL_LINE
store "≥" + TAIL_LINE + TAIL_LINE + "≥" to TAIL_LINE

store "¿ƒƒƒ (C) Copyright 1988, Personal Touch " to CPYRGHT
store CPYRGHT + "Software Inc.   All Rights Reserved ƒƒƒŸ" to CPYRGHT

do CLRSCRN

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 1,0 say T_LINE_1

if COLOR_SCRN
	set color to w/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 2,0 say HEAD_LINE

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 2,0 say "≥"
@ 2,79 say "≥"
@ 3,0 say T_LINE_2

if COLOR_SCRN
	set color to b/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 22,0 say B_LINE

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 22,3 say L_TAIL
@ 22,R_COL say R_TAIL

if COLOR_SCRN
	set color to b/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 23,0 say TAIL_LINE

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 24,0 say CPYRGHT

if COLOR_SCRN
	set color to b/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 24,0 say "¿ƒƒƒ"
@ 24,76 say "ƒƒƒŸ"

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

release hEAD,R_TAIL,T_LINE,HEAD_LINE,B_LINE,TAIL_LINE,CPYRGHT,blank,lINE

return

*************************************************************************
*                                                                       *
* CHECKKEY >>> CHECK to see if Del key was hit                          *
*                                                                       *
*             entry : NONE                                              *
*             exit : CHOICE = 0, stop                                   *
*					 CHOICE <> 0 continue								*
*																		*
*************************************************************************

procedure CHECKKEY

store 1 to key

do while key <> 0 .and. key <> 7
	store inkey() to key
	
enddo

*
* Del KEY on numberic key pad
*

if key = 7
	save screen to STATUS_SCR

	store 1 to CHOICE
	store 2 to PICK_CNT
	store 20 to PICK_LINE
	store "Stop" to PICK_1
	store "Continue" to PICK_2
	do PICK
	
	do case
	case CHOICE = 1
		store 0 to CHOICE
	case CHOICE = 2
		store 1 to CHOICE
	endcase
	
	restore screen from STATUS_SCR

endif

return

*************************************************************************
*                                                                       *
* FLUSH >>> Clear keyboard buffer                                       *
*                                                                       *
*             entry : NONE                                              *
*             exit : NONE												*
*																		*
*************************************************************************

procedure flush

do while inkey() <> 0
	store CHOICE to CHOICE
	
enddo

return

*************************************************************************
*	                                                                    *
* GETPASS >>> Prompts the use to enter their password                   *
*               entry : PASS_LINE                                       *
*               exit : PSSWRD                                           *
*                                                                       *
*************************************************************************

procedure GETPASS

@ PASS_LINE,15 say "Password ......... "

store "              " to PSSWRD

store .t. to VERIFY

store SEL_NAME to L_TAIL
store "Press ƒŸ to Enter" to R_TAIL
do TAIL

do while VERIFY
	@ PASS_LINE,34 get PSSWRD picture "XXXXXXXXXXXXXX"
	set color to n/n,n/n,n,n
	read
	clear gets
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	store upper(trim(PSSWRD)) to PSSWRD
	if len(PSSWRD) > 4
		store len(PSSWRD) to F_SIZE
		store .f. to VERIFY
	else
		store 22 to STAT_LINE
		store "Start over, password is to short" to STAT_MSG
		do status
		store "              " to PSSWRD
	endif
enddo

store len(PSSWRD) to CODE 
if CODE > 7
	store substr(PSSWRD,1,7) to PSSWRD
	store 7 to CODE
endif

store "!1@2#3$4%5^6&7*8(9)0_-+=~`|\QWERT" to MIX
store "YUIOP][ASDFGHJKL:;'ZXCVBNM<,>.?/}{" + MIX to MIX
store PSSWRD to ENCODE
store str(at(substr(ENCODE,CODE,1),"&MIX")/3,1,0) to PSSWRD
store CODE - 1 to CODE
do while CODE <> 0
	store PSSWRD + str(at(substr(ENCODE,CODE,1),"&MIX"),2,0) to PSSWRD
	store CODE - 1 to CODE
enddo

release PASS_LINE,LETTER,P_SIZE,F_SIZE,ENCODE,CODE,MIX

return

*************************************************************************
*                                      									*
* PROMPT >>> Displays a prompt message centered at the given line      	*
*	       entry : PMT_LINE PMT_MSG                             		*
*	       exit : None			                                      	*
*                                      									*
*************************************************************************

procedure prompt

@ PMT_LINE,(((80-len(PMT_MSG))/2)) say PMT_MSG
release PMT_LINE,PMT_MSG

return

*************************************************************************
*                                              							*
* STATUS >>> Displays a status message at the specified line and       	*
*	       prompts the user to hit any key to continue                 	*
*	       entry : STAT_LINE STAT_MSG			                       	*
*	       exit : None					                               	*
*									                                    *
*************************************************************************

procedure status

do flush

save screen to STATUS_SCR

if COLOR_SCRN
	set color to gr+/r,w+/n,n,n
else
	set color to n/w,w+/n,n,n
endif

@ STAT_LINE-1,0 say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
@ STAT_LINE,0   say "∫                                                                              ∫"
@ STAT_LINE+1,0 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"

if len(STAT_MSG) > 58
	store substr(STAT_MSG,1,58) to STAT_MSG

endif

store STAT_MSG + ", ƒŸ to continue." to STAT_MSG

if COLOR_SCRN
	set color to gr+/r,w+/r,n,n
else
	set color to n/w,w+/n,n,n
endif

@ STAT_LINE,((80-len(STAT_MSG))/2) say STAT_MSG

store 1 to THE_KEY

do while THE_KEY <> 13
	store inkey() to THE_KEY
	
enddo

release STAT_LINE,STAT_MSG,THE_KEY

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

restore screen from STATUS_SCR

return

*************************************************************************
*                                                     					*
* TAIL >>> Display the tail line only			                   		*
*	    entry : L_TAIL, R_TAIL					                        *
*	    exit : None 						                            *
*									                                    *
*************************************************************************

procedure TAIL

if len(R_TAIL) + len(L_TAIL) > 70
	store substr(L_TAIL,1,70 - len(R_TAIL)) to L_TAIL
endif

store "ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ" to lINE
store "’[ " + space(len(L_TAIL)) + " ]" to B_LINE
store B_LINE + substr(lINE,1,80 - ((len(B_LINE) + len(R_TAIL) + 5))) to B_LINE
store len(B_LINE) + 2 to R_COL
store B_LINE + "[ " + space(len(R_TAIL)) + " ]∏" to B_LINE

if COLOR_SCRN
	set color to b/n,bg+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 22,0 say B_LINE

if COLOR_SCRN
	set color to bg/n,bg+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 22,3 say L_TAIL
@ 22,R_COL say R_TAIL

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

return

*************************************************************************
*																		*
* DATETAIL >>> Set the variable L_TAIL to the text date                 *
*		entry : None													*
*		exit : None 													*
*																		*
*************************************************************************

procedure DATETAIL
store date() to TDY
store cdow(TDY) + ", " + cmonth(TDY) + " " + str(day(TDY),2) + ", " + ;
	str(year(TDY),4) to SEL_NAME
store SEL_NAME to L_TAIL

return

**************************************************************************
*                                                                        *
* PASSWORD >>> Prompts the use to enter their ID and password            *
*               entry : None                                             *
*               exit : None                                              *
*                                                                        *
**************************************************************************

procedure pASSWORD
store "          " to PSSWRD

store "IntelliMail Logon Procedure" to hEAD
do DATETAIL
store "Press ƒŸ to Enter" to R_TAIL
do FRAME

store .t. to continue

do while continue
	
	if file ("SYSTEM.NTX")
		delete file SYSTEM.NTX
		
	endif
	
	store "1" to SELECT_NBR
	store "SYSTEM" to FILE_NAME
	store "WORK" to ALIAS_NAME
	store "SYSTEM" to INDEX_NAME
	store "S_LOGON" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN
		goto top
		
		@ 6,7  say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª "
		@ 7,7  say "∫                                                                 ∫ €"
		@ 8,7  say "∫                                                                 ∫ €"
		@ 9,7  say "∫                                                                 ∫ €"
		@ 10,7 say "∫                                                                 ∫ €"
		@ 11,7 say "∫                                                                 ∫ €"
		@ 12,7 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº €"
		@ 13,7 say " €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"
		
		store "" to LOGON
		do while len(LOGON) = 0
			set confirm on
			store "     " to LOGON
			@ 8,15 say "Please enter your identification."
			@ 10,15 say "Identification ... " get LOGON picture "!!!!!"
			read
			clear gets
			store trim(upper(LOGON)) to LOGON
			@ 8,8 say space(65)
			@ 10,8 say space(65)
			set confirm off
		enddo
		
		@ 8,15 say "Please enter your password."
		store 10 to PASS_LINE
		do GETPASS
		@ 8,8 say space(65)
		@ 10,8 say space(65)
		
		seek LOGON
		
		store " " to PRMSSN
		store date() to PWDATE
		
		if len(LOGON) <> len(trim(S_LOGON))
			store 22 to STAT_LINE
			store "No such ID see System Administrator" to STAT_MSG
			do status
			
		else
			if (eof() .or. bof())
				store 22 to STAT_LINE
				store "No such ID see System Administrator" to STAT_MSG
				do status
				
			else
				store S_PRMSSN to PRMSSN
				
				if "              " = S_PSSWRD
					
					if substr(PRMSSN,1,1) = "B"
						replace S_PSSWRD with PSSWRD 
						store "P" + substr(PRMSSN,2,9) to PRMSSN
						replace S_PRMSSN with PRMSSN
						store date() to PWDATE
						replace S_PWDATE with PWDATE
						store 22 to STAT_LINE
						store LOGON + " please remember your new password" to STAT_MSG
						do status 
						store .f. to continue
						
					else
						store " " to PSSWRD
						replace S_PRMSSN with PRMSSN
						store "I" + substr(PRMSSN,2,9) to PRMSSN
						replace S_PRMSSN with PRMSSN
						store " " to PRMSSN
						replace S_PSSWRD with PRMSSN
						store 22 to STAT_LINE
						store "Tampered PASSWORD, report to ADMINSTRATOR" to STAT_MSG
						do status
						
					endif
					
				else
					
					if PSSWRD <> trim(S_PSSWRD)
						store 22 to STAT_LINE
						store "Invalid LOGON" to STAT_MSG
						do status
						
					else
						if substr(S_PRMSSN,1,1) <> "P"
							store "T" + substr(PRMSSN,2,9) to PRMSSN
							replace S_PRMSSN with PRMSSN
							store 22 to STAT_LINE
							store "Tampered PERMISSIONS, report to ADMINSTRATOR" to STAT_MSG
							do status
							
						else
							store S_LOGON to LOGON
							store S_PSSWRD to PSSWRD
							store S_PRMSSN to PRMSSN
							store S_PWDATE to PWDATE
							store .f. to continue
							
						endif
						
					endif
					
				endif
				
			endif
			
		endif
		
		select WORK
		use
		
		store "1" to SELECT_NBR
		store "GLOBAL" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			replace G_LOGON with LOGON
			replace G_PSSWRD with PSSWRD
			replace G_PRMSSN with PRMSSN
			replace G_PWDATE with PWDATE
			
			select WORK
			use
			
		else
			store 22 to STAT_LINE
			store "FATAL ERROR : could not open GLOBAL file" to STAT_MSG
			do status
			
			quit
			
		endif
		
	else
		store 22 to STAT_LINE
		store "FATAL ERROR : could not open SYSTEM file" to STAT_MSG
		do status
		
		quit
		
	endif
	
	
enddo

@ 6,0 clear to 13,79

return

*************************************************************************
*                                                                       *
* CHNGPASS >>> Prompts the user to change their password		        *
*	       entry : None						                            *
*	       exit : None		                                            *
*	                                                              		*
*************************************************************************

procedure CHNGPASS
store "          " to PSSWRD

store "Changing Your Password" to hEAD
do DATETAIL
store "Press RETURN to ENTER" to R_TAIL
do FRAME

store 1 to continue

set exact on

do while continue <> 0
	store "1" to SELECT_NBR
	store "GLOBAL" to FILE_NAME
	store "WORK" to ALIAS_NAME
	store "" to INDEX_NAME
	store "" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN
		store G_PSSWRD to OLDWORD
		store G_LOGON to LOGON
		store G_PRMSSN to PRMSSN
		store trim(LOGON) to LOGON
		
		select WORK
		use
		
	else
		store 22 to STAT_LINE
		store "FATAL ERROR : could not open GLOBAL file" to STAT_MSG
		do status
		
		quit
		
	endif
	
	@ 6,7  say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª "
	@ 7,7  say "∫                                                                 ∫ €"
	@ 8,7  say "∫                                                                 ∫ €"
	@ 9,7  say "∫                                                                 ∫ €"
	@ 10,7 say "∫                                                                 ∫ €"
	@ 11,7 say "∫                                                                 ∫ €"
	@ 12,7 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº €"
	@ 13,7 say " €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"
	
	@ 8,15 say "Enter your old password."
	store 10 to PASS_LINE
	do GETPASS
	@ 8,8 say space(65)
	@ 10,8 say space(65)
	
	if OLDWORD = PSSWRD
		
		@ 8,15 say "Enter your new password."
		store 10 to PASS_LINE
		do GETPASS
		@ 8,8 say space(65)
		@ 10,8 say space(65)
		
		store PSSWRD to NEWWORD
		
		@ 8,15 say "Enter your new password a second time."
		store 10 to PASS_LINE
		do GETPASS
		@ 8,8 say space(65)
		@ 10,8 say space(65)
		
		if NEWWORD = PSSWRD
			if OLDWORD = PSSWRD
				store 22 to STAT_LINE
				store "Can not use the old password again" to STAT_MSG
				do status
				
			else
				store "1" to SELECT_NBR
				store "SYSTEM" to FILE_NAME
				store "WORK" to ALIAS_NAME
				store "SYSTEM" to INDEX_NAME
				store "S_LOGON" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					seek LOGON
					
					if (eof() .or. bof())
						store 22 to STAT_LINE
						store "Unable to change password" to STAT_MSG
						do status
						store OLDWORD to PSSWRD
						
					else
						store NEWWORD to PSSWRD
						replace S_PSSWRD with PSSWRD
						replace S_PWDATE with date()
						store 22 to STAT_LINE
						store LOGON + " please remember your new password" to STAT_MSG
						do status
						
					endif
					
					select WORK
					use
					
				else
					store 22 to STAT_LINE
					store "FATAL ERROR : could not open SYSTEM file" to STAT_MSG
					do status
					
					quit
					
				endif
				
				store "1" to SELECT_NBR
				store "GLOBAL" to FILE_NAME
				store "WORK" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					replace G_PSSWRD with PSSWRD
					replace G_PWDATE with date()
					store 0 to continue
					
					select WORK
					use
					
				endif
				
			endif
			
		else
			
			store 22 to STAT_LINE
			store "Second entry did not match first" to STAT_MSG
			do status
			
			store 1 to continue
			
		endif
		
	else
		
		store 22 to STAT_LINE
		store "Invalid password" to STAT_MSG
		do status
		
		store 1 to continue
		
	endif
	
enddo

set exact off

@ 6,0 clear to 13,79

return

*************************************************************************
*                                                       				*
* YESNO >>> Displays a yes no message at the specified line and       	*
*	     prompts the user to type Y or N				                *
*	     entry : YN_LINE YN_MSG					                        *
*	     exit : YN							                            *
*									                                    *
*************************************************************************

procedure YESNO

@ YN_LINE,10 say YN_MSG
store YN to Y_N
store " " to YN

store SEL_NAME to L_TAIL
store "Press Y or N" to R_TAIL
do TAIL

do while .not. YN $"Y,N"
	store Y_N to YN
	@ YN_LINE+2,10 say "Enter a Y (yes) or an N (no) " get Y_N picture "!"
	read
	clear gets
	store upper(Y_N) to Y_N
	if Y_N = "Y" .or. Y_N = "N"
		store Y_N to YN
	else
		store YN to Y_N
		store " " to YN
	endif
enddo
@ YN_LINE,10 say space(len(YN_MSG))
@ YN_LINE+2,10 say space(32)
release YN_LINE,YN_MSG,Y_N

return

*************************************************************************
*							                                       		*
* READCLI >>> Read the current record into the record variables        	*
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READCLI

store C_CLI_NBR to CLI_NBR
store C_BIRTH to BIRTH
store C_LBL_CODE to LBL_CODE
store C_TITLE to TITLE
store C_LST_N to LST_N
store C_FST_N to FST_N
store C_M_I to M_I
store C_CO_TITLE to CO_TITLE
store C_CO_NAME to CO_NAME
store C_ADDR_1 to ADDR_1
store C_ADDR_2 to ADDR_2
store C_CITY to CITY
store C_STATE to STATE
store substr(C_ZIP,1,5)+"-"+substr(C_ZIP,6,4) to ZIP
store substr(C_PHONE,1,3)+"-"+substr(C_PHONE,4,3)+"-"+substr(C_PHONE,7,4) to PHONE
store C_COMMENTS to COMMENTS
store C_LOGON to LOGON

return

*************************************************************************
*					                                            		*
* WRITECLI >>> Write current record variables to the screen		        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITECLI

replace C_CLI_NBR with CLI_NBR
replace C_BIRTH with BIRTH
replace C_LBL_CODE with LBL_CODE
replace C_TITLE with TITLE
replace C_LST_N with upper(LST_N)
replace C_FST_N with upper(FST_N)
replace C_M_I with upper(M_I)
replace C_CO_TITLE with CO_TITLE
replace C_CO_NAME with CO_NAME
replace C_ADDR_1 with ADDR_1
replace C_ADDR_2 with ADDR_2
replace C_CITY with CITY
replace C_STATE with STATE
replace C_ZIP with substr(ZIP,1,5) + substr(ZIP,7,4)
replace C_PHONE with substr(PHONE,1,3) + substr(PHONE,5,3) + substr(PHONE,9,4)
replace C_COMMENTS with COMMENTS
replace C_LOGON with upper(LOGON)

return

*************************************************************************
*																		*
* GETNCLI >>> Get a blank record from the screen which the user added	*
*	       entry : #													*
*	       exit : Current record variables								*
*																		*
*************************************************************************

procedure GETNCLI

@ 5,3  say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
@ 6,3  say "∫                                                                         ∫ €"
@ 7,3  say "∫                                                                         ∫ €"
@ 8,3  say "∫                                                                         ∫ €"
@ 9,3  say "∫                                                                         ∫ €"
@ 10,3 say "∫                                                                         ∫ €"
@ 11,3 say "∫                                                                         ∫ €"
@ 12,3 say "∫                                                                         ∫ €"
@ 13,3 say "∫                                                                         ∫ €"
@ 14,3 say "∫                                                                         ∫ €"
@ 15,3 say "∫                                                                         ∫ €"
@ 16,3 say "∫                                                                         ∫ €"
@ 17,3 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº €"
@ 18,3 say " €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"


store "?????" to CLI_NBR
@ 5,5 get CLI_NBR picture "99999"

store upper(USER_LOGON) to LOGON
@ 5,69 get LOGON picture "!!!!!"

store upper(LST_NAME) to LST_N
@ 7,5 say "last name, first name, MI";
	get LST_N picture "!!!!!!!!!!!!!!!!!!!!"

store upper(FST_NAME) to FST_N
@ 7,53 say "," get FST_N picture "!!!!!!!!!!!!!!!"

clear gets

set confirm on

store space(25) to TITLE
@ 6,5 say "title (i,e., Mr & Mrs, Doctor etc.)";
	get TITLE picture "XXXXXXXXXXXXXXXXXXXXXXXXX"

store " " to M_I
@ 7,73 get M_I picture "!"

store space(35) to CO_TITLE
@ 8,5 say "title within company ....";
	get CO_TITLE picture "!!!!!!!!!!!!!!!!!!!!!!!!!"

store space(35) to CO_NAME
@ 9,5 say "name of company .........";
	get CO_NAME picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

store space(35) to ADDR_1
@ 10,5 say "address line 1 ..........";
	get ADDR_1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

store space(35) to ADDR_2
@ 11,5 say "address line 2 ..........";
	get ADDR_2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

store space(20) to CITY
@ 12,5 say "city, state and zip .....";
	get CITY picture "!!!!!!!!!!!!!!!!!!!!"

store "  " to STATE
@ 12,55 say ",";
	get STATE picture "!!"

store "     -    " to ZIP
@ 12,63 get ZIP picture "!!!!!-!!!!"

store "   -   -    " to PHONE
@ 13,5 say "phone number";
	get PHONE picture "999-999-9999"

store date() to BIRTH
@ 13,33 say "birth date ";
	get BIRTH picture "99/99/9999"

store space(20) to LBL_CODE
@ 14,5 say "mailing label code";
	get LBL_CODE picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 15,5 say "comments"
store space(65) to COMMENTS
@ 16,5 get COMMENTS picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

store SEL_NAME to L_TAIL
store "Press ƒŸ to Enter" to R_TAIL
do TAIL

read

clear gets

set confirm off

return

*************************************************************************
*																		*
* GETCLI >>> Get client record from the screen which the user edits	*
*	       entry : #													*
*	       exit : Current record variables								*
*																		*
*************************************************************************

procedure GETCLI

@ 5,3  say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
@ 6,3  say "∫                                                                         ∫ €"
@ 7,3  say "∫                                                                         ∫ €"
@ 8,3  say "∫                                                                         ∫ €"
@ 9,3  say "∫                                                                         ∫ €"
@ 10,3 say "∫                                                                         ∫ €"
@ 11,3 say "∫                                                                         ∫ €"
@ 12,3 say "∫                                                                         ∫ €"
@ 13,3 say "∫                                                                         ∫ €"
@ 14,3 say "∫                                                                         ∫ €"
@ 15,3 say "∫                                                                         ∫ €"
@ 16,3 say "∫                                                                         ∫ €"
@ 17,3 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº €"
@ 18,3 say " €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"

@ 5,5 get CLI_NBR picture "99999"

@ 5,69 get LOGON picture "!!!!!"

clear gets

set confirm on

@ 6,5 say "title (i,e., Mr & Mrs, Doctor etc.)";
	get TITLE picture "XXXXXXXXXXXXXXXXXXXXXXXXX"

@ 7,5 say "last name, first name, MI";
	get LST_N picture "!!!!!!!!!!!!!!!!!!!!"

@ 7,53 say "," get FST_N picture "!!!!!!!!!!!!!!!"

@ 7,73 get M_I picture "!"

@ 8,5 say "title within company ....";
	get CO_TITLE picture "!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 9,5 say "name of company .........";
	get CO_NAME picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 10,5 say "address line 1 ..........";
	get ADDR_1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 11,5 say "address line 2 ..........";
	get ADDR_2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 12,5 say "city, state and zip .....";
	get CITY picture "!!!!!!!!!!!!!!!!!!!!"

@ 12,55 say ",";
	get STATE picture "!!"

@ 12,63 get ZIP picture "!!!!!-!!!!"

@ 13,5 say "phone number";
	get PHONE picture "999-999-9999"

@ 13,33 say "birth date ";
	get BIRTH picture "99/99/9999"

@ 14,5 say "mailing label code";
	get LBL_CODE picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 15,5 say "comments"
@ 16,5 get COMMENTS picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

store SEL_NAME to L_TAIL
store "Press ƒŸ to Enter" to R_TAIL
do TAIL

read

clear gets

set confirm off

return

*************************************************************************
*																		*
* PUTCLI >>> Put the current record to the screen						*
*	       entry : #													*
*	       exit : Current record variables								*
*																		*
*************************************************************************

procedure PUTCLI

@ 5,5 get CLI_NBR picture "99999"

@ 5,69 get LOGON picture "!!!!!"

@ 6,5 say "title (i,e., Mr & Mrs, Doctor etc.)";
	get TITLE picture "XXXXXXXXXXXXXXXXXXXXXXXXX"

@ 7,5 say "last name, first name, MI";
	get LST_N picture "!!!!!!!!!!!!!!!!!!!!"

@ 7,53 say "," get FST_N picture "!!!!!!!!!!!!!!!"

@ 7,73 get M_I picture "!"

@ 8,5 say "title within company ....";
	get CO_TITLE picture "!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 9,5 say "name of company .........";
	get CO_NAME picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 10,5 say "address line 1 ..........";
	get ADDR_1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 11,5 say "address line 2 ..........";
	get ADDR_2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 12,5 say "city, state and zip .....";
	get CITY picture "!!!!!!!!!!!!!!!!!!!!"

@ 12,55 say ",";
	get STATE picture "!!"

@ 12,63 get ZIP picture "!!!!!-!!!!"

@ 13,5 say "phone number";
	get PHONE picture "999-999-9999"

@ 13,33 say "birth date ";
	get BIRTH picture "99/99/9999"

@ 14,5 say "mailing label code";
	get LBL_CODE picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 15,5 say "comments"
@ 16,5 get COMMENTS picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

clear gets

return

*************************************************************************
*																		*
* PRINTCLI >>> Put the current record to the printer					*
*	       entry : #													*
*	       exit : Current record variables								*
*																		*
*************************************************************************

procedure PRINTCLI
@ 3,5 say "<<< Client Information <<<"

@ 5,5 say "[" + CLI_NBR + "]"

@ 5,69 say "[" + LOGON + "]"

@ 6,5 say "title (i,e., Mr & Mrs, Doctor etc.) [" + TITLE + "]"

@ 7,5   say "last name, first name, MI [" + LST_N + "], [" + FST_N + "] [" + M_I + "]"

@ 8,5 say "title within company .... [" + CO_TITLE + "]"

@ 9,5 say "name of company ......... [" + CO_NAME + "]"

@ 10,5 say "address line 1 .......... [" + ADDR_1 + "]"

@ 11,5 say "address line 2 .......... [" + ADDR_2 + "]"

@ 12,5 say "city, state and zip ..... [" + CITY + "], [" + STATE + "] [" + ZIP + "]"

@ 13,5  say "phone number ............ [" + PHONE + "]"

@ 12,33 say "birth date ... [" + dtoc(BIRTH) + "]"

@ 14,5 say "mailing label code [" + LBL_CODE + "]"

@ 15,5 say "comments"
@ 16,5 say "[" + COMMENTS + "]"

return

*************************************************************************
*							                                       		*
* READMRK >>> Read the current record into the record variables        	*
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READMRK

store M_MRK_NBR to MRK_NBR
store M_SCHD_PTR to SCHD_PTR
store M_STP_PTR to STP_PTR
store M_MDESC to MDESC
store M_DINT to DINT
store M_LST_SCHD to LST_SCHD
store M_LST_STP to LST_STP
store M_LST_DESC to LST_DESC
store M_LST_DINT to LST_DINT
store M_LTR_TOS to LTR_TOS
store M_DATE_TOS to DATE_TOS
store M_SEND_FLG to SEND_FLG
store M_TRG_CNT to TRG_CNT
store M_TRG_DATE to TRG_DATE
store M_DATE_SNT to DATE_SNT
store M_MSTP_TYP to MSTP_TYP
store M_MLTR_TYP to MLTR_TYP
store M_MTRG_TYP to MTRG_TYP
store M_ERR_FLAG to ERR_FLAG
store M_ERR_DESC to ERR_DESC
store M_LOGON to LOGON

return

*************************************************************************
*					                                            		*
* WRITEMRK >>> Write current record variables to the screen		        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITEMRK

replace M_MRK_NBR with MRK_NBR
replace M_SCHD_PTR with SCHD_PTR
replace M_STP_PTR with STP_PTR
replace M_MDESC with MDESC
replace M_DINT with DINT
replace M_LST_SCHD with LST_SCHD
replace M_LST_STP with LST_STP
replace M_LST_DESC with LST_DESC
replace M_LST_DINT with LST_DINT
replace M_LTR_TOS with upper(LTR_TOS)
replace M_DATE_TOS with DATE_TOS
replace M_SEND_FLG with SEND_FLG
replace M_TRG_CNT with TRG_CNT
replace M_TRG_DATE with TRG_DATE
replace M_DATE_SNT with DATE_SNT
replace M_MSTP_TYP with MSTP_TYP
replace M_MLTR_TYP with MLTR_TYP
replace M_MTRG_TYP with MTRG_TYP
replace M_ERR_FLAG with ERR_FLAG
replace M_ERR_DESC with ERR_DESC
replace M_LOGON with upper(LOGON)

return

*************************************************************************
*																		*
* PUTMRK >>> Put the current client marker record to the screen		    *
*	       entry : #													*
*	       exit : Current record variables								*
*																		*
*************************************************************************

procedure PUTMRK
@ 5,5 get MRK_NBR picture "!!!!!"

@ 5,69 get LOGON picture "!!!!!"

@ 7,5 say "schedule name, step and date initilized ....";
	get SCHD_PTR picture "!!!!!"

store ltrim(trim(STP_PTR)) to STP_PTR

if len(STP_PTR) = 0
	store "1  " to STP_PTR
	
else
	do while substr(STP_PTR,1,1) = "0"
		STP_PTR = substr(STP_PTR,2,len(STP_PTR))
		
	enddo
	
	do case
	case val(STP_PTR) < 10
		store substr(STP_PTR,1,1) + "  " to STP_PTR
		
	case val(STP_PTR) < 100
		store substr(STP_PTR,1,2) + " " to STP_PTR
		
	endcase			
	
endif

@ 7,58 get STP_PTR picture "999"

@ 7,64 get DINT picture "99/99/9999"
@ 8,5 get MDESC picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 9,5 say "last schedule name, step and date initilized";
	get LST_SCHD picture "!!!!!"

@ 9,58 get LST_STP picture "999"

@ 9,64 get LST_DINT picture "99/99/9999"
@ 10,5 get LST_DESC picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 11,5 get ERR_DESC picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 13,5 say "letter to send";
	get LTR_TOS picture "!!!!!!!!"

@ 13,31 say "date to send";
	get DATE_TOS picture "99/99/9999"

@ 14,5 say "letter has been sent";
	get SEND_FLG picture "9"

if val(MSTP_TYP) = 1 .or. val(MSTP_TYP) = 2 .or. val(MSTP_TYP) = 3
	@ 14,31 say "letter was sent on";
		get DATE_SNT picture "99/99/9999"
	
endif

clear gets

return

*************************************************************************
*																		*
* PRINTMRK >>> Put the current record to the printer					*
*	       entry : #													*
*	       exit : Current record variables								*
*																		*
*************************************************************************

procedure PRINTMRK

@ 3,5 say "<<< Client Schedule Information <<<"

@ 5,5 say "[" + MRK_NBR + "]"

@ 5,69 say "[" + LOGON + "]"

@ 7,5 say "schedule name, step and date initilized .... [" + SCHD_PTR + "]"

store ltrim(trim(STP_PTR)) to STP_PTR

if len(STP_PTR) = 0
	store "1  " to STP_PTR
	
else
	do while substr(STP_PTR,1,1) = "0"
		STP_PTR = substr(STP_PTR,2,len(STP_PTR))
		
	enddo
	
	do case
	case val(STP_PTR) < 10
		store substr(STP_PTR,1,1) + "  " to STP_PTR
		
	case val(STP_PTR) < 100
		store substr(STP_PTR,1,2) + " " to STP_PTR
		
	endcase			
	
endif

@ 7,58 say "[" + STP_PTR + "]"

@ 7,64 say "[" + dtoc(DINT) + "]"
@ 8,5 say "[" + MDESC + "]"

@ 9,5 say "last schedule name, step and date initilized [" + LST_SCHD + "]"

@ 9,58 say "[" + LST_STP + "]"

@ 9,64 say "[" + dtoc(LST_DINT) + "]"
@ 10,5 say "[" + LST_DESC + "]"

@ 11,5 say "[" + ERR_DESC + "]"

@ 13,5 say "letter to send [" + LTR_TOS + "]"

@ 13,31 say "date to send [" + dtoc(DATE_TOS) + "]"

@ 14,5 say "letter has been sent [" + SEND_FLG + "]"

if val(MSTP_TYP) = 1 .or. val(MSTP_TYP) = 2 .or. val(MSTP_TYP) = 3
	@ 14,31 say "letter was sent on [" + dtoc(DATE_SNT) + "]";
	
endif

return

*************************************************************************
*							                                       		*
* READSCH >>> Read the current record into the record variables         *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READSCH

store ltrim(str(S_STEP)) + space(3 - len(ltrim(str(S_STEP)))) to step
store S_SDESC to SDESC
store S_SSTP_TYP to SSTP_TYP
store S_SLTR_TYP to SLTR_TYP
store S_LTR_VAL to LTR_VAL
store S_LTR_ID to LTR_ID
store S_N_SCHD to N_SCHD
store S_N_STEP to N_STEP
store S_DCD_NAME to DCD_NAME
store S_STRG_TYP to STRG_TYP
store S_TRG_VAL to TRG_VAL
store S_T1_SCHD to T1_SCHD
store S_T1_STEP to T1_STEP
store S_T2_SCHD to T2_SCHD
store S_T2_STEP to T2_STEP
store S_DL_VAL to DL_VAL
store S_DL_SCHD to DL_SCHD
store S_DL_STEP to DL_STEP
store S_LOGON to LOGON

return

*************************************************************************
*					                                            		*
* WRITESCH >>> Write current record variables to the screen		        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITESCH

replace S_STEP with val(step)
replace S_SDESC with SDESC
replace S_SSTP_TYP with SSTP_TYP
replace S_SLTR_TYP with SLTR_TYP
replace S_LTR_VAL with LTR_VAL
replace S_LTR_ID with upper(LTR_ID)
replace S_N_SCHD with upper(N_SCHD)
replace S_N_STEP with ltrim(str(val(N_STEP))) + space(3 - len(ltrim(str(val(N_STEP)))))
replace S_DCD_NAME with DCD_NAME
replace S_STRG_TYP with STRG_TYP
replace S_TRG_VAL with TRG_VAL
replace S_T1_SCHD with upper(T1_SCHD)
replace S_T1_STEP with ltrim(str(val(T1_STEP))) + space(3 - len(ltrim(str(val(T1_STEP)))))
replace S_T2_SCHD with upper(T2_SCHD)
replace S_T2_STEP with ltrim(str(val(T2_STEP))) + space(3 - len(ltrim(str(val(T2_STEP)))))
replace S_DL_VAL with DL_VAL
replace S_DL_SCHD with DL_SCHD
replace S_DL_STEP with DL_STEP
replace S_LOGON with upper(LOGON)

return

*************************************************************************
*                                                  						*
* READBUS >>> Read the clinic file										*
*	       entry : None					                                *
*	       exit : None		                                            *
*	                                                              		*
*************************************************************************

procedure READBUS
store B_BUS_FNME to BUS_FNME
store B_BUS_LNME to BUS_LNME
store B_BUS_TTLE to BUS_TTLE
store B_BUS_NAME to BUS_NAME
store B_BUS_ADD1 to BUS_ADD1
store B_BUS_ADD2 to BUS_ADD2
store B_BUS_CITY to BUS_CITY
store B_BUS_ST to BUS_ST
store B_BUS_ZIP to BUS_ZIP
store substr(B_BUS_PHNE,1,3) + "-" + substr(B_BUS_PHNE,4,3) + "-" + substr(B_BUS_PHNE,7,4) to BUS_PHNE

return

*************************************************************************
*                                                  						*
* WRTEBUS >>> Write the clinic file									*
*	       entry : None					                                *
*	       exit : None		                                            *
*                                                              			*
*************************************************************************

procedure WRTEBUS
replace B_BUS_FNME with BUS_FNME
replace B_BUS_LNME with BUS_LNME
replace B_BUS_TTLE with BUS_TTLE
replace B_BUS_NAME with BUS_NAME
replace B_BUS_ADD1 with BUS_ADD1
replace B_BUS_ADD2 with BUS_ADD2
replace B_BUS_CITY with BUS_CITY
replace B_BUS_ST with BUS_ST
replace B_BUS_ZIP with BUS_ZIP
replace B_BUS_PHNE with substr(BUS_PHNE,1,3) + substr(BUS_PHNE,5,3) + substr(BUS_PHNE,9,4)

return

*************************************************************************
*                                                  						*
* GETBUS >>> Get the clinic information								    *
*	       entry : None					                                *
*	       exit : None		                                            *
*                                                              			*
*************************************************************************

procedure GETBUS
@ 5,3  say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
@ 6,3  say "∫                                                                         ∫ €"
@ 7,3  say "∫                                                                         ∫ €"
@ 8,3  say "∫                                                                         ∫ €"
@ 9,3  say "∫                                                                         ∫ €"
@ 10,3 say "∫                                                                         ∫ €"
@ 11,3 say "∫                                                                         ∫ €"
@ 12,3 say "∫                                                                         ∫ €"
@ 13,3 say "∫                                                                         ∫ €"
@ 14,3 say "∫                                                                         ∫ €"
@ 15,3 say "∫                                                                         ∫ €"
@ 16,3 say "∫                                                                         ∫ €"
@ 17,3 say "∫                                                                         ∫ €"
@ 18,3 say "∫                                                                         ∫ €"
@ 19,3 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº €"
@ 20,3 say " €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"

store 7 to PMT_LINE
store "Defining Information for Business" to PMT_MSG
do prompt

@ 9,5  say "Professional lst & fst name ." ;
	get BUS_LNME picture "XXXXXXXXXXXXXXXXXXXX"
@ 9,56  say "," ;
	get BUS_FNME picture "XXXXXXXXXXXXXXX"

@ 10,5 say "Professional title .........." ;
	get BUS_TTLE picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 12,5 say "Business name ..............." ;
	get BUS_NAME picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 13,5 say "Business address line 1 ....." ;
	get BUS_ADD1 picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 14,5 say "Business address line 2 ....." ;
	get BUS_ADD2 picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

@ 15,5 say "Business city, state zip ...." ;
	get BUS_CITY picture "XXXXXXXXXXXXXXXXXXXX"

@ 15,56 say "," ;
	get BUS_ST picture "XX"

@ 15,63 say " " ;
	get BUS_ZIP picture "XXXXXXXXX"

@ 17,5 say "Business phone number ......." ;
	get BUS_PHNE picture "999-999-9999"

set confirm on

store SEL_NAME to L_TAIL
store "Press ƒŸ to Enter" to R_TAIL
do TAIL

read

set confirm off

clear gets

return

*************************************************************************
*							                                       		*
* READLF >>> Read the label format file							        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READLF

store L_L_COL to L_COL
store L_L_ROW to L_ROW
store L_L_IDENT to L_IDENT
store L_L_TSKIP to L_TSKIP
store L_L_PAUSE to L_PAUSE
store L_L_WIDTH to L_WIDTH
store L_L_CBTWN to L_CBTWN
store L_L_DEPTH to L_DEPTH
store L_L_LBTWN to L_L_LBTWN
store L_L_PERCLI to L_PERCLI

return

*************************************************************************
*							                                       		*
* WRITELF >>> Write the label format file	   					        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITELF

replace L_L_COL with L_COL
if L_ROW = "tractor feed"
	replace L_L_ROW with "0 "
else
	replace L_L_ROW with L_ROW
endif
replace L_L_IDENT with L_IDENT
replace L_L_TSKIP with L_TSKIP
replace L_L_PAUSE with L_PAUSE
replace L_L_WIDTH with L_WIDTH
replace L_L_CBTWN with L_CBTWN
replace L_L_DEPTH with L_DEPTH
replace L_L_LBTWN with L_L_LBTWN
replace L_L_PERCLI with L_PERCLI

return

*************************************************************************
*							                                       		*
* READTF >>> Read the letter text format file					        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READTF

store L_L_COLP to L_COLP
store L_L_ROWP to L_ROWP
store L_L_IDNT to L_IDNT
store L_L_TSKP to L_TSKP
store L_L_PSE to L_PSE
store L_L_COLT to L_COLT
store L_L_ROWT to L_ROWT
store L_L_LPCLI to L_LPCLI

return

*************************************************************************
*							                                       		*
* WRITETF >>> Write the letter text format file	   				        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITETF

replace L_L_COLP with L_COLP
replace L_L_ROWP with L_ROWP
replace L_L_IDNT with L_IDNT
replace L_L_TSKP with L_TSKP
replace L_L_PSE with L_PSE
replace L_L_COLT with L_COLT
replace L_L_ROWT with L_ROWT
replace L_L_LPCLI with L_LPCLI

return

*: EOF: UTILITY.PRG
