*:*********************************************************************
*:
*:        Program: MRKDEL.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 26-Mar-89 at 0:08 am
*:
*:      Called by: MRKMENU.PRG    
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GMNAME.PRG
*:               : GMSTEP.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:               : GSSTEP.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : READMRK          (procedure in UTILITY.PRG)
*:               : FINDSCH.PRG
*:               : LTRGINT.PRG
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:               : CHECKKEY         (procedure in UTILITY.PRG)
*:               : DELDATA.PRG
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* MRKDEL >>> Edit allows user to delete marker     				      *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store "4" to SELECT_NBR
store "MARKER" to FILE_NAME
store "MARKER" to ALIAS_NAME
store "MARKER" to INDEX_NAME
store "M_MRK_NBR" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	
	store .t. to REFRESH
	store .t. to continue
	
	store .f. to DEL_SEL
	store "No remove selected" to SEL_NAME
	
	set deleted on
	store 1 to CHOICE_DM
	
	do while continue
		
		if REFRESH
			store "Removing Markers" to hEAD
			store SEL_NAME to L_TAIL
			store "Select Return to STOP" to R_TAIL
			do FRAME
		else
			store SEL_NAME to L_TAIL
			store "Select Return to STOP" to R_TAIL
			do TAIL
		endif
		
		store CHOICE_DM to CHOICE
		store 3 to MENU_CNT
		store "Select" to MENU_1
		store "Select a schedule and step to remove" to DESC_1
		store "Remove" to MENU_2
		store "Remove the selected schedule and step markers" to DESC_2
		store "Return" to MENU_3
		store "Return to Marker Menu" to DESC_3
		do menu
		
		store CHOICE to CHOICE_DM
		
		do case
			
		case CHOICE = 1
			store .f. to DEL_SEL
			
			*
			* Get the schedule and step to remove client from
			*
			
			store .t. to NOT_DONE
			
			store space(5) to DEL_NAME
			store space(3) to DEL_STEP
			
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
				store "Select the name of the markers to be removed" to PMT_MSG
				do prompt
				
				do GMNAME
				
				@ 20,0
				
				select SCHDDIR
				use
				
				if MRK_SEL
					store MRK_SNAME to DEL_NAME
					
					store "7" to SELECT_NBR
					store MRK_FNAME to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store MRK_FNDX to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store 20 to PMT_LINE
						store "Select the step of the &MRK_SNAME markers to be removed" to PMT_MSG
						do prompt
						
						do GMSTEP
						
						@ 20,0
						
						select SCHD
						use
						
						if MRK_SEL
							store MRK_STEP to DEL_STEP
							store .t. to DEL_SEL

						else
							store .f. to DEL_SEL
							
						endif
						
					endif
					
				endif
				
			endif
			
			if DEL_SEL
				store 2 to CHOICE_DM
				store "Remove selected" to SEL_NAME
				
			else
				store "No remove selected" to SEL_NAME
				
			endif
			
			do CLRSCRN
			
		case CHOICE = 2
			if DEL_SEL
				store "Removing Client Markers" to L_TAIL
				store "Press Y or N" to R_TAIL
				do TAIL
				
				@ 6,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป "
				@ 7,7  say "บ                                                                 บ Û"
				@ 8,7  say "บ                                                                 บ Û"
				@ 9,7  say "บ                                                                 บ Û"
				@ 10,7 say "บ                                                                 บ Û"
				@ 11,7 say "บ                                                                 บ Û"
				@ 12,7 say "บ                                                                 บ Û"
				@ 13,7 say "บ                                                                 บ Û"
				@ 14,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
				@ 15,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
				
				store " " to YN
				do while YN <> "Y" .and. YN <> "N"
					store 8 to PMT_LINE
					store "REMOVE schedule " + DEL_NAME + " step " + trim(DEL_STEP) + ;
						" markers" to PMT_MSG
					do PROMPT

					store 10 to PMT_LINE
					store "Remove markers FROM schedule/step" to PMT_MSG
					do PROMPT

					@ 12,18 say "Press Y to begin or press N to cancel ..." get YN picture "X"
					
					read
					
					clear gets
					
					store upper(YN) to YN
					do case
					case YN = "Y"
						store .t. to DEL_MRK
						
					case YN = "N"
						store .f. to DEL_MRK
						
					otherwise
						store " " to YN
						
					endcase
					
				enddo
				
				@ 8,8 say space(65)
				@ 10,8 say space(65)
				@ 12,8 say space(65)
				
				store "Removing Client Markers" to L_TAIL
				store "Press Del to CANCEL" to R_TAIL
				do TAIL
				
				if DEL_MRK
					select MARKER
					goto top
					
					store 0 to REC_NBR
					store ltrim(str(REC_NBR)) to REC_CNT
					store reccount() to REC_TOT
					store ltrim(str(REC_TOT)) to REC_TOTCNT
					
					store 8 to PMT_LINE
					store "Remove schedule " + DEL_NAME + " step " + trim(DEL_STEP) + ;
						" markers" to PMT_MSG
					do prompt
					
					store 10 to PMT_LINE
					store "Reading marker for record number ... " + REC_CNT + " of " + REC_TOTCNT to PMT_MSG
					do prompt
					
					store 0 to DEL_NBR
					store ltrim(str(DEL_NBR)) to DEL_CNT
					
					store 12 to PMT_LINE
					store "Number of markers removed ..... " + DEL_CNT to PMT_MSG
					do prompt
					
					store 1 to CHOICE
					do while (.not. (bof() .or. eof())) .and. DEL_MRK .and. (CHOICE <> 0)
						store REC_NBR + 1 to REC_NBR
						store ltrim(str(REC_NBR)) to REC_CNT
						
						store 10 to PMT_LINE
						store "Reading marker for record number ... " + REC_CNT + " of " + REC_TOTCNT to PMT_MSG
						do prompt
						
						do READMRK
						
						if ltrim(trim(DEL_NAME)) = ltrim(trim(SCHD_PTR)) .and. ltrim(trim(DEL_STEP)) = ltrim(trim(STP_PTR))
							
							if .not. deleted()
								store DEL_NBR + 1 to DEL_NBR
								store ltrim(str(DEL_NBR)) to DEL_CNT
								
								store 12 to PMT_LINE
								store "Number of markers removed ..... " + DEL_CNT to PMT_MSG
								do prompt
								
								delete
									
							endif
							
						endif
						
						skip
						
						do CHECKKEY
						
					enddo
					
					store 22 to STAT_LINE
					store "Finished removing markers" to STAT_MSG
					do status
					
					store "No remove selected" to SEL_NAME
					
				endif
				
			else
				store 22 to STAT_LINE
				store "Your must first select a remove" to STAT_MSG
				do status
				
			endif
			
			do CLRSCRN
			
			store 1 to CHOICE_DM
			
			store .t. to continue
			store .f. to REFRESH
			
		case CHOICE = 3
			select MARKER
			use
			
			set deleted off
			do DELDATA
			set deleted on
			
			store .f. to continue
			
		endcase
		
	enddo
	
endif

return


*: EOF: MRKDEL.PRG
