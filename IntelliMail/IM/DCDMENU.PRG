*:*********************************************************************
*:
*:        Program: DCDMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 1-Jan-89 at 8:20 pm
*:
*:      Called by: IMMENU.PRG     
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : DCDVIEW.PRG
*:               : DCDADD.PRG
*:               : DCDEDIT.PRG
*:               : DCDPRINT.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* DCDMENU >>> The menu that provides access to the schedule data base *
*	       entry : None						                          *
*	       exit : None						                          *
*									                                  *
*	MENU is a collection of records called choices that are may be    *
*	presented to the operator when Advancing a client				  *
*																	  *
*	Each schedule is taken from DCDTMP (menu (decider) template) to   *
*		create a new menu (5 characters for name)					  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue
store 1 to CHOICE_DM

do while continue
	
	if REFRESH
		store "Designing Decider Menus" to hEAD
		do DATETAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
		
		store CHOICE_DM to CHOICE
		store 5 to MENU_CNT
		store "Show" to MENU_1
		store "Show decider menus and decider menu choices" to DESC_1
		store "Add" to MENU_2
		store "Add decider menus and decider menu choices" to DESC_2
		store "Edit" to MENU_3
		store "Edit decider menu choices or remove decider menus" to DESC_3
		store "Print" to MENU_4
		store "Print decider menu choices" to DESC_4
		store "Return" to MENU_5
		store "Return to the IntelliMail Main Menu" to DESC_5
		do menu
		
		store CHOICE to CHOICE_DM
	endif
	
	do case
		
	case CHOICE = 1
		do DCDVIEW
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		do DCDADD
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 3
		do DCDEDIT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 4
		do DCDPRINT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 5
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: DCDMENU.PRG
