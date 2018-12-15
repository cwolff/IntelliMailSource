*:*********************************************************************
*:
*:        Program: SCHDMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 1-Jan-89 at 8:19 pm
*:
*:      Called by: IMMENU.PRG     
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : SCHDVIEW.PRG
*:               : SCHDADD.PRG
*:               : SCHDEDIT.PRG
*:               : SCHPRINT.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* SCHDMENU >>> The menu that provides access to the schedule data base*
*	       entry : None						                          *
*	       exit : None						                          *
*									                                  *
*	SCHEDULE is a collection of records called steps that determine	  *
*		when the next letter is going to be sent and the next step	  *
*		to be executed.												  *
*																	  *
*	Each schedule is taken from SCHDLTMP (schedule template) to 	  *
*		create a new schedule (up to 5 characters for name) which	  *
*		contain steps (records) that controls when letter are sent	  *
*		and what schudule and step is executed next.				  *
*																	  *
*	The schedule information is used to generate information for	  *
*		the client MARKER file. 									  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue
store 1 to CHOICE_SM

do while continue
	
	if REFRESH
		store "Designing Schedules" to hEAD
		do DATETAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
		
		store CHOICE_SM to CHOICE
		store 5 to MENU_CNT
		store "View" to MENU_1
		store "View schedules and schedule steps" to DESC_1
		store "Add" to MENU_2
		store "Add schedules and/ or schedule steps" to DESC_2
		store "Edit" to MENU_3
		store "Edit schedule steps and/ or remove schedules" to DESC_3
		store "Print" to MENU_4
		store "Print schedule steps" to DESC_4
		store "Return" to MENU_5
		store "Return to the IntelliMail Main Menu" to DESC_5
		do menu
		
		store CHOICE to CHOICE_SM
	endif
	
	do case
		
	case CHOICE = 1
		do SCHDVIEW
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		do SCHDADD
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 3
		do SCHDEDIT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 4
		do SCHPRINT
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 5
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: SCHDMENU.PRG
