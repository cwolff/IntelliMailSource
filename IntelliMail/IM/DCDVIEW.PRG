*:*********************************************************************
*:
*:        Program: DCDVIEW.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 1:39 pm
*:
*:      Called by: DCDMENU.PRG    
*:
*:          Calls: FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GDNAME.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : GDCHOICE.PRG
*:               : SELDCD.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* MENUVIEW >>> Add allows user to view the data base				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to DCD_SEL
store "No menu selected" to SEL_NAME
store 1 to CHOICE_DV

do while continue
	
	if REFRESH
		store "Showing Decider Menu Choices" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_DV to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select a decider menu" to DESC_1
	store "Show" to MENU_2
	store "Show the selected decider menu" to DESC_2
	store "Return" to MENU_3
	store "Return to Editing Decider Menus" to DESC_3
	do menu
	
	store CHOICE to CHOICE_DV
	
	do case
		
	case CHOICE = 1
		
		*
		* Open Menu Directory and initialize variables
		*
		
		store "8" to SELECT_NBR
		store "DCDDIR" to FILE_NAME
		store "DCDDIR" to ALIAS_NAME
		store "DCDDIR" to INDEX_NAME
		store "DCD_DNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			store 20 to PMT_LINE
			store "Selecting a menu to view" to PMT_MSG
			do prompt
			
			store 1 to REC_NBR
			store .f. to REC_ADD
			do GDNAME
			
			@ 20,0
			
			if DCD_SEL
				store "9" to SELECT_NBR
				store DCD_FNAME to FILE_NAME
				store "DCD" to ALIAS_NAME
				store DCD_FNDX to INDEX_NAME
				store "D_DCHOICE" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					store .t. to SCH_SEL
					
				else
					store 20 to PMT_LINE
					store "One moment please, adjusting menu directory." to PMT_MSG
					do prompt
					
					store "8" to SELECT_NBR
					store "DCDDIR" to FILE_NAME
					store "DCDDIR" to ALIAS_NAME
					store "DCDDIR" to INDEX_NAME
					store "DCD_DNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						seek DCD_NAME
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						select DCDDIR
						use
						
					endif
					
					store .f. to DCD_SEL
					
					@ 20,0
					
				endif
				
			endif
			
		endif
		
		if DCD_SEL
			store "&DCD_NAME schedule selected" to SEL_NAME
			store 2 to CHOICE_DV
			
		else
			store "No menu selected" to SEL_NAME
			
		endif
		
		do CLRSCRN
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		
		if DCD_SEL
			store 20 to PMT_LINE
			store "Selecting a &DCD_NAME menu choice to view" to PMT_MSG
			do prompt
			
			store 1 to REC_NBR
			store .f. to REC_ADD
			do GDCHOICE
			
			@ 20,0
			
			if CHOICE_SEL
				do CLRSCRN
				
				do SELDCD
				
			endif
			
			do CLRSCRN
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a menu" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_DV
		
	case CHOICE = 3
		select 8
		use
		
		select 9
		use
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: DCDVIEW.PRG
