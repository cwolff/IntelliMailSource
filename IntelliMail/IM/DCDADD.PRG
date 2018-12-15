*:*********************************************************************
*:
*:        Program: DCDADD.PRG
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
*:               : GDCHOICE.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PUTDCD.PRG
*:               : GETDCD.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : WRITEDCD.PRG
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* DCDADD >>> Add allows user to add to the data base				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to DCD_SEL
store 1 to CHOICE_DA

store "No decider menu selected" to SEL_NAME

do while continue
	
	if REFRESH
		store "Adding Decider Menu Choices" to hEAD
		store SEL_NAME  to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_DA to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select existing decider menu or add new decider menu" to DESC_1
	store "Add" to MENU_2
	store "Add new choice or edit an existing choice in the selected decider menu" to DESC_2
	store "Return" to MENU_3
	store "Return to the Decider Menu Editor" to DESC_3
	do menu
	
	store CHOICE to CHOICE_DA
	
	do case
		
	case CHOICE = 1
		store "8" to SELECT_NBR
		store "DCDDIR" to FILE_NAME
		store "DCDDIR" to ALIAS_NAME
		store "DCDDIR" to INDEX_NAME
		store "DCD_DNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			
			*
			* Inform GDNAME that a new decider menu may be added
			*
			
			store 20 to PMT_LINE
			store "Selecing or adding a decider menu" to PMT_MSG
			do prompt
			
			store 0 to REC_NBR
			store .t. to REC_ADD
			do GDNAME
			
			@ 20,0
			
			if DCD_SEL
				if file((DCD_FNAME + ".DBF"))
					store .t. to DCD_SEL
					
				else
					store 22 to STAT_LINE
					store "Could not open the decider menu &DCD_NAME" to STAT_MSG
					do status
					
					store 20 to PMT_LINE
					store "One moment please, adjusting decider menu directory." to PMT_MSG
					do prompt
					
					store "8" to SELECT_NBR
					store "DCDDIR" to FILE_NAME
					store "DCDDIR" to ALIAS_NAME
					store "DCDDIR" to INDEX_NAME
					store "DCD_DNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						seek DCD_NAME
						if .not. (bof() .or. eof())
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
			store 2 to CHOICE_DA
			store "&DCD_NAME decider menu selected" to SEL_NAME
			
		else
			store "No decider menu selected" to SEL_NAME
			
		endif
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		if DCD_SEL
			store "9" to SELECT_NBR
			store DCD_FNAME to FILE_NAME
			store "DCD" to ALIAS_NAME
			store DCD_FNDX to INDEX_NAME
			store "D_DCHOICE" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				store 20 to PMT_LINE
				store "Selecting or adding a decider menu choice" to PMT_MSG
				do prompt
				
				store 0 to REC_NBR
				store .t. to REC_ADD
				do GDCHOICE
				
				@ 20,0
				
				if DCD_SEL
					do CLRSCRN
					
					@ 5,1  say "ษอ[       choice     ]อออออออออออออออออออออออออออออออออออออออออออออ[       ]อป"
					@ 6,1  say "บ                                                                            บ"
					@ 7,1  say "บ                                                                            บ"
					@ 8,1  say "บ                                                                            บ"
					@ 9,1  say "บ                                                                            บ"
					@ 10,1 say "บ                                                                            บ"
					@ 11,1 say "บ                                                                            บ"
					@ 12,1 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
					
					do PUTDCD
					
					do GETDCD
					
					store .t. to sCROLL
					
					do while sCROLL
						store 1 to CHOICE
						store 3 to PICK_CNT
						store 20 to PICK_LINE
						store "Save choice" to PICK_1
						store "Edit choice" to PICK_2
						store "Throw away choice" to PICK_3
						do PICK
						
						do case
						case CHOICE = 1
							do WRITEDCD
							
							store .f. to sCROLL
							
						case CHOICE = 2
							do GETDCD
							
						case CHOICE = 3
							store .f. to sCROLL
							
						endcase
						
					enddo
					
				endif
				
			endif
			
		else
			store 22 to STAT_LINE
			store "You must first select a decider menu" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_DA
		
	case CHOICE = 3
		select 8
		use
		
		select 9
		use
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: DCDADD.PRG
