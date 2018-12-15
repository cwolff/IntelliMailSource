*:*********************************************************************
*:
*:        Program: DCDEDIT.PRG
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
*:               : EDITDCD.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* DCDEDIT >>> EDIT allows user to edit the decider menu				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to DCD_SEL
store "No decider menu selected" to SEL_NAME
store 1 to CHOICE_DE

do while continue
	
	if REFRESH
		store "Editing Decider Menus Choices" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_DE to CHOICE
	store 5 to MENU_CNT
	store "Select" to MENU_1
	store "Select a decider menu" to DESC_1
	store "Edit" to MENU_2
	store "Edit choices in the selected decider menu" to DESC_2
	store "Change" to MENU_3
	store "Change description of selected decider menu in the decider menu directory" to DESC_3
	store "Remove" to MENU_4
	store "Remove the selected decider menu from the decider menu directory" to DESC_4
	store "Return" to MENU_5
	store "Return to the Decider Menu Editor" to DESC_5
	do menu
	
	store CHOICE to CHOICE_DE
	
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
			store "Selecting a decider menu to edit" to PMT_MSG
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
					store 20 to PMT_LINE
					store DCD_NAME +  " decider menu not found, adjusting decider menu directory" to PMT_MSG
					do prompt
					
					store "8" to SELECT_NBR
					store "DCDDIR" to FILE_NAME
					store "DCDDIR" to ALIAS_NAME
					store "DCDDIR" to INDEX_NAME
					store "DCD_DNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						find DCD_NAME
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						select DCDDIR
						use
						
						store .f. to DCD_SEL
						
						@ 20,0
						
					endif
					
				endif
				
			endif
			
		endif
		
		if DCD_SEL
			store 2 to CHOICE_DE
			store "&DCD_NAME decider menu selected" to SEL_NAME
			
		else
			store "No decider menu selected" to SEL_NAME
			
		endif
		
		do CLRSCRN
		
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
				store "Selecting a &DCD_NAME choice to edit" to PMT_MSG
				do prompt
				
				store 1 to REC_NBR
				do GDCHOICE
				
				@ 20,0
				
				if CHOICE_SEL
					goto val(DCHOICE)
					
					do EDITDCD
					
					if .not. DCD_SEL
						store "No decider menu selected" to SEL_NAME
						
					endif
					
				endif
				
			endif
			
			do CLRSCRN
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a decider menu" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_DE
		
	case CHOICE = 3
		if DCD_SEL
			store "8" to SELECT_NBR
			store "DCDDIR" to FILE_NAME
			store "DCDDIR" to ALIAS_NAME
			store "DCDDIR" to INDEX_NAME
			store "DCD_DNAME" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				seek DCD_NAME
				
				if .not. (eof() .or. bof())
					store DCD_DNAME to DCD_NAME
					store DCD_DDESC to DCD_DESC
					
					@ 8,3  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
					@ 9,3  say "บ                                                                     บ Û"
					@ 10,3 say "บ                                                                     บ Û"
					@ 11,3 say "บ                                                                     บ Û"
					@ 12,3 say "บ                                                                     บ Û"
					@ 13,3 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
					@ 14,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
					
					@ 10,5 say "Enter description for &DCD_NAME decider menu."
					@ 11,5 get DCD_DESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
					
					set confirm on
					
					read
					clear gets
					
					set confirm off
					
					clear gets
					
					store 20 to PICK_LINE
					store 2 to PICK_CNT
					store "Save changes to decider menu directory" to PICK_1
					store "Throw away changes" to PICK_2
					do PICK
					
					if CHOICE = 1
						replace DCD_DDESC with DCD_DESC
						
					endif
					
				endif
				
				select DCDDIR
				use
				
			endif
			
			do CLRSCRN
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a decider menu" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_DE
		
	case CHOICE = 4
		if DCD_SEL
			store 20 to PICK_LINE
			store 2 to PICK_CNT
			store "Remove &DCD_NAME decider menu" to PICK_1
			store "Don't remove" to PICK_2
			do PICK
			
			if CHOICE = 1
				store 20 to PICK_LINE
				store 2 to PICK_CNT
				store "Continue to remove &DCD_NAME decider menu" to PICK_1
				store "Cancel" to PICK_2
				do PICK
				
				if CHOICE = 1
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
						
						if file((DCD_FNAME + ".DBF"))
							store DCD_FNAME + ".DBF" to DEL_NAME
							delete file &DEL_NAME
							
						endif
						
						if file((DCD_FNDX + ".NTX"))
							store DCD_FNDX + ".NTX" to DEL_NAME
							delete file &DEL_NAME
							
						endif
						
						select DCDDIR
						use
						
						store 22 to STAT_LINE
						store "&DCD_NAME decider menu has been removed" to STAT_MSG
						do status
						
						store .f. to DCD_SEL
						
					endif
					
				endif
				
			endif
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a decider menu" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_DE
		
	case CHOICE = 5
		select 8
		use
		
		select 9
		use
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: DCDEDIT.PRG
