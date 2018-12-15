*:*********************************************************************
*:
*:        Program: DCDPRINT.PRG
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
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : READDCD.PRG
*:               : PRINTDCD.PRG
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* DCDPRINT >>> Add allows user to print the database				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to DCD_SEL
store "No decider menu selected" to SEL_NAME
store 1 to CHOICE_MP

do while continue
	
	if REFRESH
		store "Printing Decider Menu Choices" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_MP to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select a decider menu" to DESC_1
	store "Print" to MENU_2
	store "Print the selected decider menu choices" to DESC_2
	store "Return" to MENU_3
	store "Return to Editing Decider Menus" to DESC_3
	do menu
	
	store CHOICE to CHOICE_SP
	
	do case
		
	case CHOICE = 1
		
		*
		* Open Schdule Directory and initialize variables
		*
		
		store "8" to SELECT_NBR
		store "DCDDIR" to FILE_NAME
		store "DCDDIR" to ALIAS_NAME
		store "DCDDIR" to INDEX_NAME
		store "DCD_DNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			store 20 to PMT_LINE
			store "Selecting decider menu to print" to PMT_MSG
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
					store .t. to DCD_SEL
					
				else
					store 22 to STAT_LINE
					store "Could not open &DCD_NAME file" to STAT_MSG
					do status
					
					store 20 to PMT_LINE
					store "One moment please, adjusting schedule directory." to PMT_MSG
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
						
					else
						store 22 to STAT_LINE
						store "Could not open DCDDIR file" to STAT_MSG
						do status
						
					endif
					
					store .f. to DCD_SEL
					
					@ 20,0
					
				endif
				
			endif
			
		endif
		
		do CLRSCRN
		
		if DCD_SEL
			store 2 to CHOICE_SP
			store "&DCD_NAME decider menu selected" to SEL_NAME
			
		else
			store "No decider menu selected" to SEL_NAME
			
		endif
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		if DCD_SEL
			do CLRSCRN
			
			goto top
			
			set device to print
			
			do while .not. (bof() .or. eof())
				do READDCD
				do PRINTDCD
				
				eject
				
				skip
				
			enddo
			
			set device to screen
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a decider menu" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_SP
		
	case CHOICE = 3
		select 8
		use
		
		select 9
		use
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: DCDPRINT.PRG
