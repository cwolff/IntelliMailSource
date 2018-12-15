*:*********************************************************************
*:
*:        Program: SCHDVIEW.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 1:39 pm
*:
*:      Called by: SCHDMENU.PRG   
*:
*:          Calls: FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : GSSTEP.PRG
*:               : SELSCHD.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SCHVIEW >>> Add allows user to view the data base					  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to SCH_SEL
store "No schedule selected" to SEL_NAME
store 1 to CHOICE_SV

do while continue
	
	if REFRESH
		store "Showing Schedules" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_SV to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select a schedule" to DESC_1
	store "Show" to MENU_2
	store "Show steps in the selected schedule" to DESC_2
	store "Return" to MENU_3
	store "Return to Editing Schedules" to DESC_3
	do menu
	
	store CHOICE to CHOICE_SV
	
	do case
		
	case CHOICE = 1
		
		*
		* Open Schdule Directory and initialize variables
		*
		
		store "6" to SELECT_NBR
		store "SCHDDIR" to FILE_NAME
		store "SCHDDIR" to ALIAS_NAME
		store "SCHDDIR" to INDEX_NAME
		store "SCHD_SNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			store 20 to PMT_LINE
			store "Selecting a schedule to view" to PMT_MSG
			do prompt
			
			store 1 to REC_NBR
			store .f. to REC_ADD
			do GSNAME
			
			@ 20,0
			
			if SCH_SEL
				store "7" to SELECT_NBR
				store SCH_FNAME to FILE_NAME
				store "SCHD" to ALIAS_NAME
				store SCH_FNDX to INDEX_NAME
				store "S_STEP" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					store .t. to SCH_SEL
					
				else
					store 20 to PMT_LINE
					store "One moment please, adjusting schedule directory." to PMT_MSG
					do prompt
					
					store "6" to SELECT_NBR
					store "SCHDDIR" to FILE_NAME
					store "SCHDDIR" to ALIAS_NAME
					store "SCHDDIR" to INDEX_NAME
					store "SCH_SNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						seek SCH_SNAME
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						select SCHDDIR
						use
						
					endif
					
					store .f. to SCH_SEL
					
					@ 20,0
					
				endif
				
			endif
			
		endif
		
		if SCH_SEL
			store "&SCH_SNAME schedule selected" to SEL_NAME
			store 2 to CHOICE_SV
			
		else
			store "No schedule selected" to SEL_NAME
			
		endif
		
		do CLRSCRN
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		
		if SCH_SEL
			store 20 to PMT_LINE
			store "Selecting a &SCH_SNAME step to view" to PMT_MSG
			do prompt
			
			store 1 to REC_NBR
			do GSSTEP
			
			@ 20,0
			
			if STEP_SEL
				do CLRSCRN
				
				do SELSCHD
				
			endif
			
			do CLRSCRN
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a schedule" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_SV
		
	case CHOICE = 3
		select 7
		use
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: SCHDVIEW.PRG
