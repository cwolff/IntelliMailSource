*:*********************************************************************
*:
*:        Program: SCHDEDIT.PRG
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
*:               : EDITSCHD.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SCHDEDIT >>> EDIT allows user to edit the schedule				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to SCH_SEL
store "No schedule selected" to SEL_NAME
store 1 to CHOICE_SE

do while continue
	
	if REFRESH
		store "Editing Schedules" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_SE to CHOICE
	store 5 to MENU_CNT
	store "Select" to MENU_1
	store "Select a schedule" to DESC_1
	store "Edit" to MENU_2
	store "Edit a step in the selected schedule" to DESC_2
	store "Change" to MENU_3
	store "Change the description of the schedule in the schedule directory" to DESC_3
	store "Remove" to MENU_4
	store "Remove the selected schedule from the schedule directory" to DESC_4
	store "Return" to MENU_5
	store "Return to Editing Schedules" to DESC_5
	do menu
	
	store CHOICE to CHOICE_SE
	
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
			store "Selecting a schedule to edit" to PMT_MSG
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
					store SCH_SNAME +  " schedule not found, adjusting schedule directory" to PMT_MSG
					do prompt
					
					store "6" to SELECT_NBR
					store "SCHDDIR" to FILE_NAME
					store "SCHDDIR" to ALIAS_NAME
					store "SCHDDIR" to INDEX_NAME
					store "SCHD_SNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						find SCH_SNAME
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						select SCHDDIR
						use
						
						store .f. to SCH_SEL
						
						@ 20,0
						
					endif
					
				endif
				
			endif
			
		endif
		
		if SCH_SEL
			store 2 to CHOICE_SE
			store "&SCH_SNAME schedule selected" to SEL_NAME
			
		else
			store "No schedule selected" to SEL_NAME
			
		endif
		
		do CLRSCRN
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		if SCH_SEL
			store "7" to SELECT_NBR
			store SCH_FNAME to FILE_NAME
			store "SCHD" to ALIAS_NAME
			store SCH_FNDX to INDEX_NAME
			store "S_STEP" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				store 20 to PMT_LINE
				store "Selecting a &SCH_SNAME step to edit" to PMT_MSG
				do prompt
				
				store 1 to REC_NBR
				do GSSTEP
				
				@ 20,0
				
				if STEP_SEL
					goto val(SCH_STEP)
					
					do EDITSCHD
					
					if .not. SCH_SEL
						store "No schedule selected" to SEL_NAME
						
					endif
					
				endif
				
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
		
		store 1 to CHOICE_SE
		
	case CHOICE = 3
		if SCH_SEL
			store "6" to SELECT_NBR
			store "SCHDDIR" to FILE_NAME
			store "SCHDDIR" to ALIAS_NAME
			store "SCHDDIR" to INDEX_NAME
			store "SCHD_SNAME" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				seek SCH_SNAME
				
				if .not. (eof() .or. bof())
					@ 8,3  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
					@ 9,3  say "บ                                                                     บ Û"
					@ 10,3 say "บ                                                                     บ Û"
					@ 11,3 say "บ                                                                     บ Û"
					@ 12,3 say "บ                                                                     บ Û"
					@ 13,3 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
					@ 14,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
					
					@ 10,5 say "Enter schedule description for &SCH_SNAME."
					@ 11,5 get SCH_SDESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
					
					set confirm on
					
					read
					clear gets
					
					set confirm off
					
					clear gets
					
					store 20 to PICK_LINE
					store 2 to PICK_CNT
					store "Save changes to schedule directory" to PICK_1
					store "Throw away changes" to PICK_2
					do PICK
					
					if CHOICE = 1
						replace SCHD_SDESC with SCH_SDESC
						
					endif
					
				endif
				
				select SCHDDIR
				use
				
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
		
		store 1 to CHOICE_SE
		
	case CHOICE = 4
		if SCH_SEL
			store 20 to PICK_LINE
			store 2 to PICK_CNT
			store "Remove &SCH_SNAME schedule" to PICK_1
			store "Don't remove" to PICK_2
			do PICK
			
			if CHOICE = 1
				store 20 to PICK_LINE
				store 2 to PICK_CNT
				store "Continue to remove &SCH_SNAME schedule" to PICK_1
				store "Cancel" to PICK_2
				do PICK
				
				if CHOICE = 1
					store "6" to SELECT_NBR
					store "SCHDDIR" to FILE_NAME
					store "SCHDDIR" to ALIAS_NAME
					store "SCHDDIR" to INDEX_NAME
					store "SCHD_SNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						seek SCH_SNAME
						
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						if file((SCH_FNAME + ".DBF"))
							store SCH_FNAME + ".DBF" to DEL_NAME
							delete file &DEL_NAME
							
						endif
						
						if file(SCH_FNDX + ".NTX")
							store SCH_FNDX + ".NTX" to DEL_NAME
							delete file &DEL_NAME
							
						endif
						
						select SCHDDIR
						use
						
						store 22 to STAT_LINE
						store "&SCH_SNAME schedule has been removed" to STAT_MSG
						do status
						
					endif
					
				endif
				
			endif
			
			store .t. to continue
			store .t. to REFRESH
			
		else
			store 22 to STAT_LINE
			store "You must first select a schedule" to STAT_MSG
			do status
			
			store .t. to continue
			store .f. to REFRESH
			
		endif
		
		store 1 to CHOICE_SE
		
	case CHOICE = 5
		select 7
		use
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: SCHDEDIT.PRG
