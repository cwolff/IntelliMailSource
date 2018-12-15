*:*********************************************************************
*:
*:        Program: LTRMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 1:41 pm
*:
*:      Called by: IMMENU.PRG     
*:
*:          Calls: FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GLNAME.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : LTREDIT.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : GCNAME.PRG
*:               : SELCLI.PRG
*:               : READBUS          (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : SUBTEXT.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* LTRMENU >>> The menu that provides access to the data base		  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to LTR_SEL
store "No letter selected" to SEL_NAME
store 1 to CHOICE_LM

do while continue
	
	if REFRESH
		store "Editing Letters" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
		
		store CHOICE_LM to CHOICE
		store 6 to MENU_CNT
		store "Select" to MENU_1
		store "Select an existing letter or add a new letter to the letter directory" to DESC_1
		store "Edit" to MENU_2
		store "Edit the selected letter" to DESC_2
		store "Change" to MENU_3
		store "Change the description of the selected letters in the letter directory" to DESC_3
		store "Remove" to MENU_4
		store "Remove the selected letter from the letter directory" to DESC_4
		store "Print" to MENU_5
		store "Send the selected letter to the printer" to DESC_5
		store "Return" to MENU_6
		store "Return to the IntelliMail Main Menu" to DESC_6
		do menu
		
		store CHOICE to CHOICE_LM
	endif
	
	do case
		
	case CHOICE = 1
		store "10" to SELECT_NBR
		store "LTRDIR" to FILE_NAME
		store "LTRDIR" to ALIAS_NAME
		store "LTRDIR" to INDEX_NAME
		store "LTR_LNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			
			*
			* Inform GLNAME that a new letter may be added
			*
			
			store 20 to PMT_LINE
			store "Selecting or adding a letter" to PMT_MSG
			do prompt
			
			store 0 to REC_NBR
			store .t. to REC_ADD
			do GLNAME
			
			@ 20,0
			
			if LTR_SEL
				if file(LTR_FNAME)
					store .t. to LTR_SEL
					
				else
					store 22 to STAT_LINE
					store "Could not open &LTR_NAME file" to STAT_MSG
					do status
					
					store 20 to PMT_LINE
					store "One moment please, adjusting letter directory." to PMT_MSG
					do prompt
					
					store "10" to SELECT_NBR
					store "LTRDIR" to FILE_NAME
					store "LTRDIR" to ALIAS_NAME
					store "LTRDIR" to INDEX_NAME
					store "LTR_LNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						seek LTR_NAME
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						select LTRDIR
						use
						
					endif
					
					store .f. to LTR_SEL
					
					@ 20,0
					
				endif
				
			endif
			
		endif
		
		if LTR_SEL
			store 2 to CHOICE_LM
			store "&LTR_NAME letter selected" to SEL_NAME
			
		else
			store "No letter selected" to SEL_NAME
			
		endif
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		if LTR_SEL
			do CLRSCRN
		
			save screen to LTR_SCRN
		
			do LTREDIT with LTR_FNAME, LTR_NAME
		
			restore screen from LTR_SCRN
		
			store 1 to CHOICE_LM

		else
			store 22 to STAT_LINE
			store "You must first select a letter" to STAT_MSG
			do status
			
		endif
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 3
		if LTR_SEL
			store "10" to SELECT_NBR
			store "LTRDIR" to FILE_NAME
			store "LTRDIR" to ALIAS_NAME
			store "LTRDIR" to INDEX_NAME
			store "LTR_LNAME" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				seek LTR_NAME
				
				store LTR_LNAME to LTR_NAME
				store LTR_LDESC to LTR_DESC
				
				if .not. (eof() .or. bof())
					@ 8,3  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»  "
					@ 9,3  say "º                                                                     º Û"
					@ 10,3 say "º                                                                     º Û"
					@ 11,3 say "º                                                                     º Û"
					@ 12,3 say "º                                                                     º Û"
					@ 13,3 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
					@ 14,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
					
					@ 10,5 say "Enter description for &LTR_NAME letter."
					@ 11,5 get LTR_DESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
					
					set confirm on
					
					read
					clear gets
					
					set confirm off
					
					clear gets
					
					store 20 to PICK_LINE
					store 2 to PICK_CNT
					store "Save changes to letter directory" to PICK_1
					store "Throw away changes" to PICK_2
					do PICK
					
					if CHOICE = 1
						replace LTR_LDESC with LTR_DESC
						
					endif
					
				endif
				
				select LTRDIR
				use
				
			endif
			
			do CLRSCRN
			
		else
			store 22 to STAT_LINE
			store "You must first select a letter" to STAT_MSG
			do status
			
		endif
		
		store 1 to CHOICE_LM
		
		store .t. to continue
		store .t. to REFRESH
		
	case CHOICE = 4
		if LTR_SEL
			store 20 to PICK_LINE
			store 2 to PICK_CNT
			store "Remove &LTR_NAME letter" to PICK_1
			store "Don't remove" to PICK_2
			do PICK
			
			if CHOICE = 1
				store 20 to PICK_LINE
				store 2 to PICK_CNT
				store "Continue to remove &LTR_NAME letter" to PICK_1
				store "Cancel" to PICK_2
				do PICK
				
				if CHOICE = 1
					store "10" to SELECT_NBR
					store "LTRDIR" to FILE_NAME
					store "LTRDIR" to ALIAS_NAME
					store "LTRDIR" to INDEX_NAME
					store "LTR_LNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						seek LTR_NAME
						
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						if file(LTR_FNAME)
							delete file &SCH_FNAME
							
						endif
						
						select LTRDIR
						use
						
						store 22 to STAT_LINE
						store "&LTR_NAME letter has been removed" to STAT_MSG
						do status
						
						store .f. to LTR_SEL
						
					endif
					
				endif
				
			endif
			
		else
			store 22 to STAT_LINE
			store "You must first select a letter" to STAT_MSG
			do status
			
		endif
		
		if .not. LTR_SEL
			store "No letter selected" to SEL_NAME
		endif
		
		store 1 to CHOICE_LM
		
		store .t. to continue
		store .t. to REFRESH
		
	case CHOICE = 5
		if LTR_SEL
			do CLRSCRN

			do SETUPLTR

			if PRINT_IT
				do CLRSCRN

				if file(LTR_FNAME)
					store "2" to SELECT_NBR
					store "CLIENT" to FILE_NAME
					store "CLIENT" to ALIAS_NAME
					store "CLILNFN" to INDEX_NAME
					store "C_LST_N + C_FST_N" to IFLD_NAME
					do OPENFILE

					if FILE_OPEN
						do GCNAME

						goto top

						seek SRCH_CLI

						if .not. (bof() .or. eof())
							do SELCLI

							if CLI_SEL
								do CLRSCRN

								@ 8,7  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»  "
								@ 9,7  say "º                                                                   º Û"
								@ 10,7 say "º                                                                   º Û"
								@ 11,7 say "º                                                                   º Û"
								@ 12,7 say "º                                                                   º Û"
								@ 13,7 say "º                                                                   º Û"
								@ 14,7 say "º                                                                   º Û"
								@ 15,7 say "º                                                                   º Û"
								@ 16,7 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
								@ 17,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

								store 10 to PMT_LINE
								store "Reading clinic profile information."	to PMT_MSG
								do prompt

								store "1" to SELECT_NBR
								store "BUSINESS" to FILE_NAME
								store "WORK" to ALIAS_NAME
								store "" to INDEX_NAME
								store "" to IFLD_NAME
								do OPENFILE

								if FILE_OPEN
									do READBUS

									select WORK
									use

								endif

								store "4" to SELECT_NBR
								store "MARKER" to FILE_NAME
								store "MARKER" to ALIAS_NAME
								store "MARKER" to INDEX_NAME
								store "M_MRK_NBR" to IFLD_NAME
								do OPENFILE

								if FILE_OPEN
									store 12 to PMT_LINE
									store "Preparing letter &LTR_NAME" to PMT_MSG
									do prompt

									USR_MEMO = memoread(LTR_FNAME)

									if len(USR_MEMO) > 0
										store "Printing in progress" to L_TAIL
										store "Press Del to CANCEL" to R_TAIL
										do TAIL

										store 14 to PMT_LINE
										store "Currently printing the letter &LTR_NAME" to PMT_MSG
										do prompt

										do PRINTLTR

									else
										store 22 to STAT_LINE
										store "&LTR_NAME is an empty letter" to STAT_MSG
										do status

									endif

								else
									store 22 to STAT_LINE
									store "Could not open MARKER file" to STAT_MSG
									do status

								endif

							endif

						else
							store 22 to STAT_LINE
							store "Could not find &CLI_SNAME" to STAT_MSG
							do status

						endif

					else
						store 22 to STAT_LINE
						store "Could not open CLIENT file" to STAT_MSG
						do status

					endif

				else
					store 22 to STAT_LINE
					store "Could not find &LTR_FNAME file" to STAT_MSG
					do status

				endif

			endif

		else
			store 22 to STAT_LINE
			store "You must select a letter first" to STAT_MSG
			do status

		endif

		store 1 to CHOICE_LM
		
		store .t. to continue
		store .t. to REFRESH
		
	case CHOICE = 6
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: LTRMENU.PRG
