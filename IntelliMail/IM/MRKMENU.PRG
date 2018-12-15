*:*********************************************************************
*:
*:        Program: MRKMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 2:04 pm
*:
*:      Called by: CLIMENU.PRG     
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : MRKMOVE.PRG
*:               : MRKCOPY.PRG
*:               : MRKDEL.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* MRKMENU >>> The menu that provides mass access to the markers	      *
*	       entry : None						                          *
*	       exit : None						                          *
*									                                  *
***********************************************************************

store .t. to REFRESH
store .t. to continue
store 1 to CHOICE_MM

do while continue
	
	if REFRESH
		store "Marker Menu" to HEAD
		do DATETAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
		
		store CHOICE_MM to CHOICE
		store 4 to MENU_CNT
		store "Copy" to MENU_1
		store "Copy markers from a step in a schedule to another schedule and step" to DESC_1
		store "Move" to MENU_2
		store "Move marker from a step in a schedule to target schedule and step" to DESC_2
		store "Remove" to MENU_3
		store "Remove markers" to DESC_3
		store "Return" to MENU_4
		store "Return to Editing Clients and Markers" to DESC_4
		do menu
		
		store CHOICE to CHOICE_MM
	endif
	
	do case
		
	case CHOICE = 1
		do MRKCOPY
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		do MRKMOVE
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 3
		do MRKDEL
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 4
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: MRKMENU.PRG
