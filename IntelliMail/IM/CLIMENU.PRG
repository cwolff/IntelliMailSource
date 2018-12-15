*:*********************************************************************
*:
*:        Program: CLIMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 9:10 am
*:
*:      Called by: IMMENU.PRG     
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : CLIVIEW.PRG
*:               : CLIADD.PRG
*:               : CLIEDIT.PRG
*:               : CLIPRINT.PRG
*:               : MRKMENU.PRG
*:               : CLISTAT.PRG
*:               : CLIREVUE.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* CLIMENU >>> The menu that provides access to the data base	      *
*	       entry : None						                          *
*	       exit : None						                          *
*									                                  *
***********************************************************************

store .t. to REFRESH
store .t. to continue
store 1 to CHOICE_PM

do while continue
	
	if REFRESH
		store "Editing Clients and Markers" to hEAD
		do DATETAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
		
		store CHOICE_PM to CHOICE
		store 8 to MENU_CNT
		store "Show" to MENU_1
		store "Show me clients and markers" to DESC_1
		store "Add" to MENU_2
		store "Add clients and markers" to DESC_2
		store "Edit" to MENU_3
		store "Edit clients and markers" to DESC_3
		store "Print" to MENU_4
		store "Print out clients and markers" to DESC_4
		store "Marker" to MENU_5
		store "Remove markers or Move or Copy markers from one schedule step to another" to DESC_5
		store "Status" to MENU_6
		store "Check on clients and markers and clear marker errors" to DESC_6
		store "Review" to MENU_7
		store "Review clients and markers previously entered" to DESC_7
		store "Return" to MENU_8
		store "Return to the IntelliMail Main Menu" to DESC_8
		do menu
		
		store CHOICE to CHOICE_PM
	endif
	
	do case
		
	case CHOICE = 1
		do CLIVIEW
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		do CLIADD
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 3
		do CLIEDIT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 4
		do CLIPRINT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 5
		do MRKMENU
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 6
		do CLISTAT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 7
		do CLIREVUE
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 8
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: CLIMENU.PRG
