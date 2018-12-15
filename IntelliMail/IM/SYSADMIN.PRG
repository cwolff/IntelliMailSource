*:*********************************************************************
*:
*:        Program: SYSADMIN.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 8:47 pm
*:
*:      Called by: IM.PRG         
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : READBUS          (procedure in UTILITY.PRG)
*:               : GETBUS           (procedure in UTILITY.PRG)
*:               : WRTEBUS          (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : USERMAIN.PRG
*:               : BACKDBF.PRG
*:               : RESTDBF.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                                  					  *
* SYSADMIN >>> The menu that provides access to system adminstration  *
*	       entry : None					                              *
*	       exit : None		                                          *
*                                                              		  *
***********************************************************************

store .t. to continue
store 1 to CHOICE_SA

do while continue
	
	store "System Administration Main Menu" to hEAD
	do DATETAIL
	store "Select Return to STOP" to R_TAIL
	do FRAME
	
	store CHOICE_SA to CHOICE
	store 5 to MENU_CNT
	store "Define" to MENU_1
	store "Define business information" to DESC_1
	store "User" to MENU_2
	store "User file maintenance" to DESC_2
	store "Backup" to MENU_3
	store "Backing Up IntelliMail Database" to DESC_3
	store "Restore" to MENU_4
	store "Restoring IntelliMail" to DESC_4
	store "Return" to MENU_5
	store "Return to First Choice Menu" to DESC_5
	do menu
	
	store CHOICE to CHOICE_SA
	
	do case
		
	case CHOICE = 1
		store "1" to SELECT_NBR
		store "BUSINESS" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			goto 1
			
			do CLRSCRN
			
			do READBUS
			
			do GETBUS
			
			do WRTEBUS
			
			select WORK
			use
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open BUSINESS file" to STAT_MSG
			do status
			
		endif
		
	case CHOICE = 2
		do USERMAIN
		store .t. to continue
		
	case CHOICE = 3
		do BACKDBF
		store .t. to continue
		
	case CHOICE = 4
		do RESTDBF
		store .t. to continue
		
	case CHOICE = 5
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: SYSADMIN.PRG
