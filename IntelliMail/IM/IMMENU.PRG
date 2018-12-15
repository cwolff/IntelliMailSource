*:*********************************************************************
*:
*:        Program: IMMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 1-Jan-89 at 8:18 pm
*:
*:      Called by: IM.PRG         
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : CLIMENU.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : ADVMENU.PRG
*:               : SCHDMENU.PRG
*:               : DCDMENU.PRG
*:               : LTRMENU.PRG
*:               : SENDMENU.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* IMMENU >>> The menu that provides acces to the data base	          *
*	       entry : None						                          *
*	       exit : None						                          *
*									                                  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store "1" to SELECT_NBR
store "GLOBAL" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	goto top
	store G_LOGON to USER_LOGON
	store G_PRMSSN to PRMSSN
	
	select WORK
	use
	
	store 1 to CHOICE_EM
	
	do while continue
		
		if REFRESH
			store "IntelliMail Main Menu" to hEAD
			do DATETAIL
			store "Select Return to STOP" to R_TAIL
			do FRAME
			
			store CHOICE_EM to CHOICE
			store 7 to MENU_CNT
			store "Client" to MENU_1
			store "Use client and/ or marker editors" to DESC_1
			store "Manual" to MENU_2
			store "Manually advance client's markers to the next schedule step" to DESC_2
			store "Schedule" to MENU_3
			store "Use schedule designer" to DESC_3
			store "Menu" to MENU_4
			store "Use decider menu designer" to DESC_4
			store "Letter" to MENU_5
			store "Use letter editor" to DESC_5
			store "Send" to MENU_6
			store "Print letters and labels" to DESC_6
			store "Return" to MENU_7
			store "Return to the First Choice Menu" to DESC_7
			do menu
			
			store CHOICE to CHOICE_EM
		endif
		
		do case
			
		case CHOICE = 1
			if substr(PRMSSN,3,1) = "P"
				do CLIMENU
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "Client and Marker Editor permission denied" to STAT_MSG
				do status
				store .t. to REFRESH
			endif
			
		case CHOICE = 2
			if substr(PRMSSN,4,1) = "A"
				do ADVMENU
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "Advance Client's Marker permission denied" to STAT_MSG
				do status
				store .t. to REFRESH
			endif
			
		case CHOICE = 3
			if substr(PRMSSN,5,1) = "S"
				do SCHDMENU
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "Schedule Editor permission denied" to STAT_MSG
				do status
				store .t. to REFRESH
			endif
			
		case CHOICE = 4
			if substr(PRMSSN,6,1) = "M"
				do DCDMENU
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "Decider Menu Editor permission denied" to STAT_MSG
				do status
				store .t. to REFRESH
			endif
			
		case CHOICE = 5
			if substr(PRMSSN,7,1) = "L"
				do LTRMENU
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "Letters Editor permission denied" to STAT_MSG
				do status
				store .t. to REFRESH
			endif
			
		case CHOICE = 6
			if substr(PRMSSN,8,1) = "A"
				do SENDMENU
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "Send Letters permission denied" to STAT_MSG
				do status
				store .t. to REFRESH
			endif
			
		case CHOICE = 7
			store .f. to continue
			
		endcase
		
	enddo
	
else
	store 22 to STAT_LINE
	store "FATAL ERROR : could not open GLOBAL file" to STAT_MSG
	do status
	
	quit
	
endif

return
*: EOF: IMMENU.PRG
