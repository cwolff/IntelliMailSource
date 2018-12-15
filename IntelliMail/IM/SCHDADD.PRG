*:*********************************************************************
*:
*:        Program: SCHDADD.PRG
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
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : GSSTEP.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PUTSCH.PRG
*:               : GETSCH.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : WRITESCH         (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SCHADD >>> Add allows user to add to the data base				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to SCH_SEL
store 1 to CHOICE_SA

store "No schedule selected" to SEL_NAME

do while continue
	
	if REFRESH
		store "Adding Schedules" to hEAD
		store SEL_NAME  to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_SA to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select an existing schedule or add new schedules" to DESC_1
	store "Add" to MENU_2
	store "Add a new step or edit an existing step in the selected schedule" to DESC_2
	store "Return" to MENU_3
	store "Return to Editing Schedules" to DESC_3
	do menu
	
	store CHOICE to CHOICE_SA
	
	do case
		
	case CHOICE = 1
		store "6" to SELECT_NBR
		store "SCHDDIR" to FILE_NAME
		store "SCHDDIR" to ALIAS_NAME
		store "SCHDDIR" to INDEX_NAME
		store "SCHD_SNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			
			*
			* Inform GSNAME that a new schedule may be added
			*
			
			store 20 to PMT_LINE
			store "Selecing or adding a schedule" to PMT_MSG
			do prompt
			
			store 0 to REC_NBR
			store .t. to REC_ADD
			do GSNAME
			
			@ 20,0
			
			if SCH_SEL
				if file((SCH_FNAME + ".DBF"))
					store .t. to SCH_SEL
					
				else
					store 22 to STAT_LINE
					store "SORRY : " + SCH_SNAME + " not found" to STAT_MSG
					do status
					
					store 20 to PMT_LINE
					store "One moment please, adjusting schedule directory." to PMT_MSG
					do prompt
					
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
						
						select SCHDDIR
						use
						
					endif
					
					store .f. to SCH_SEL
					
					@ 20,0
					
				endif
				
			endif
			
		endif
		
		if SCH_SEL
			store 2 to CHOICE_SA
			store "&SCH_SNAME schedule selected" to SEL_NAME
			
		else
			store "No schedule selected" to SEL_NAME
			
		endif
		
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
				store "Selecting or adding a schedule step" to PMT_MSG
				do prompt
				
				store 0 to REC_NBR
				store .t. to REC_ADD
				do GSSTEP

				do READSCH
				
				@ 20,0
				
				if SCH_SEL
					do CLRSCRN
					
					@ 5,1  say "ษอ[       step     ]อออออออออออออออออออออออออออออออออออออออออออออออ[       ]อป"
					@ 6,1  say "บ                                                                            บ"
					@ 7,1  say "บ                                                                            บ"
					@ 8,1  say "บ                                                                            บ"
					@ 9,1  say "บ                                                                            บ"
					@ 10,1 say "บ                                                                            บ"
					@ 11,1 say "บ                                                                            บ"
					@ 12,1 say "บ                                                                            บ"
					@ 13,1 say "บ                                                                            บ"
					@ 14,1 say "บ                                                                            บ"
					@ 15,1 say "บ                                                                            บ"
					@ 16,1 say "บ                                                                            บ"
					@ 17,1 say "บ                                                                            บ"
					@ 18,1 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"

					store SCH_STEP to STEP
					
					do GETSCH
					
					store .t. to sCROLL
					
					do while sCROLL
						store 1 to CHOICE
						store 3 to PICK_CNT
						store 20 to PICK_LINE
						store "Save step" to PICK_1
						store "Edit step" to PICK_2
						store "Throw away step" to PICK_3
						do PICK
						
						do case
						case CHOICE = 1
							do WRITESCH
							
							store .f. to sCROLL
							
						case CHOICE = 2
							do GETSCH
							
						case CHOICE = 3
							store .f. to sCROLL
							
						endcase
						
					enddo
					
				endif
				
			endif
			
		else
			store 22 to STAT_LINE
			store "You must first select a schedule" to STAT_MSG
			do status
			
		endif
		
		store 1 to CHOICE_SA
		
		store .t. to continue
		store .t. to REFRESH
		
	case CHOICE = 3
		
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: SCHDADD.PRG
