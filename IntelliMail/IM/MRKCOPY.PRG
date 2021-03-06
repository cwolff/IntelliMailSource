*:*********************************************************************
*:
*:        Program: MRKCOPY.PRG
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
* MRKCOPY >>> Edit allows user to copy marker       				  *
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
	
	store .f. to COPY_SEL
	store "No copy selected" to SEL_NAME
	
	set deleted on
	store 1 to CHOICE_CP
	
	do while continue
		
		if REFRESH
			store "Copying Markers" to HEAD
			store SEL_NAME to L_TAIL
			store "Select Return to STOP" to R_TAIL
			do FRAME
		else
			store SEL_NAME to L_TAIL
			store "Select Return to STOP" to R_TAIL
			do TAIL
		endif
		
		store CHOICE_CP to CHOICE
		store 3 to MENU_CNT
		store "Select" to MENU_1
		store "Select a schedule and step to copy and a destination" to DESC_1
		store "Copy" to MENU_2
		store "Copy the selected schedule and step to the selected destination" to DESC_2
		store "Return" to MENU_3
		store "Return to Marker Menu" to DESC_3
		do menu
		
		store CHOICE to CHOICE_CP
		
		do case
			
		case CHOICE = 1
			store .f. to COPY_SEL
			
			*
			* Get the schedule and step to copy client from
			*
			
			store .t. to NOT_DONE
			
			store space(5) to FROM_NAME
			store space(3) to FROM_STEP
			
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
				store "Select the name of the markers to be copied" to PMT_MSG
				do prompt
				
				do GMNAME
				
				@ 20,0
				
				select SCHDDIR
				use
				
				if MRK_SEL
					store MRK_SNAME to FROM_NAME
					
					store "7" to SELECT_NBR
					store MRK_FNAME to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store MRK_FNDX to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store 20 to PMT_LINE
						store "Select the step that &MRK_SNAME markers are pointing to and are to be copied" to PMT_MSG
						do prompt
						
						do GMSTEP
						
						@ 20,0
						
						select SCHD
						use
						
						if MRK_SEL
							store MRK_STEP to FROM_STEP
							
							do CLRSCRN
							
							*
							* Get the schedule and step to copy client to
							*
							
							store space(5) to TO_NAME
							store space(3) to TO_STEP
							
							store "6" to SELECT_NBR
							store "SCHDDIR" to FILE_NAME
							store "SCHDDIR" to ALIAS_NAME
							store "SCHDDIR" to INDEX_NAME
							store "SCHD_SNAME" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								store 20 to PMT_LINE
								store "Select the schedule to copy the &MRK_SNAME step " + trim(MRK_STEP) + " markers to" to PMT_MSG
								do prompt
								
								*
								* The schedule directory is already open
								*
								
								store 1 to REC_NBR
								do GSNAME
								
								@ 20,0
								
								select SCHDDIR
								use
								
								if SCH_SEL
									store SCH_SNAME to TO_NAME
									
									store "7" to SELECT_NBR
									store SCH_FNAME to FILE_NAME
									store "SCHD" to ALIAS_NAME
									store SCH_FNDX to INDEX_NAME
									store "S_STEP" to IFLD_NAME
									do OPENFILE
									
									if FILE_OPEN
										store 20 to PMT_LINE
										store "Select the step to copy the &MRK_SNAME step " + trim(MRK_STEP) + " markers to" to PMT_MSG
										do prompt
										
										store 1 to REC_NBR
										do GSSTEP
										
										if STEP_SEL
											store SCH_STEP to TO_STEP
											
											if FROM_NAME = TO_NAME
												store .f. to COPY_SEL
												store 22 to STAT_LINE
												store "Can not have two steps in the same schedule" to STAT_MSG
												do status

											else
												store .t. to COPY_SEL
												
											endif
											
											select SCHD
											use
											
										endif
										
									endif
									
								endif
								
							endif
							
						endif
						
					endif
					
				endif
				
			endif
			
			if COPY_SEL
				store 2 to CHOICE_CP
				store "Copy selected" to SEL_NAME
				
			else
				store "No copy selected" to SEL_NAME
				
			endif
			
			do CLRSCRN
			
		case CHOICE = 2
			if COPY_SEL
				store "Copying Client Markers" to L_TAIL
				store "Press Y or N" to R_TAIL
				do TAIL
				
				@ 6,7  say "浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様� "
				@ 7,7  say "�                                                                 � �"
				@ 8,7  say "�                                                                 � �"
				@ 9,7  say "�                                                                 � �"
				@ 10,7 say "�                                                                 � �"
				@ 11,7 say "�                                                                 � �"
				@ 12,7 say "�                                                                 � �"
				@ 13,7 say "�                                                                 � �"
				@ 14,7 say "藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様� �"
				@ 15,7 say " 栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩"
				
				store " " to YN
				do while YN <> "Y" .and. YN <> "N"
					store 8 to PMT_LINE
					store "FROM schedule " + FROM_NAME + " step " + trim(FROM_STEP) + ;
						" TO schedule " + TO_NAME + " step " + trim(TO_STEP) to PMT_MSG
					do PROMPT

					store 10 to PMT_LINE
					store "Copy markers FROM 1st schedule/step TO 2nd schedule/step" to PMT_MSG
					do PROMPT

					@ 12,18 say "Press Y to begin or press N to cancel ..." get YN picture "X"
					
					read
					
					clear gets
					
					store upper(YN) to YN
					do case
					case YN = "Y"
						store .t. to COPY_MRK
						
					case YN = "N"
						store .f. to COPY_MRK
						
					otherwise
						store " " to YN
						
					endcase
					
				enddo
				
				@ 8,8 say space(65)
				@ 10,8 say space(65)
				@ 12,8 say space(65)
				
				store "Copying Client Markers" to L_TAIL
				store "Press Del to CANCEL" to R_TAIL
				do TAIL
				
				if COPY_MRK
					select MARKER
					goto top
					
					store 0 to REC_NBR
					store ltrim(str(REC_NBR)) to REC_CNT
					store reccount() to REC_TOT
					store ltrim(str(REC_TOT)) to REC_TOTCNT
					
					store 8 to PMT_LINE
					store "FROM schedule " + FROM_NAME + " step " + trim(FROM_STEP) + ;
						" TO schedule " + TO_NAME + " step " + trim(TO_STEP) to PMT_MSG
					do prompt
					
					store 10 to PMT_LINE
					store "Reading marker for record number ... " + REC_CNT + " of " + REC_TOTCNT to PMT_MSG
					do prompt
					
					store 0 to COPY_NBR
					store ltrim(str(COPY_NBR)) to COPY_CNT
					
					store 12 to PMT_LINE
					store "Number of markers copied ..... " + COPY_CNT to PMT_MSG
					do prompt
					
					store 1 to CHOICE
					do while (.not. (bof() .or. eof())) .and. COPY_MRK .and. (CHOICE <> 0)
						store REC_NBR + 1 to REC_NBR
						store ltrim(str(REC_NBR)) to REC_CNT
						
						store 10 to PMT_LINE
						store "Reading marker for record number ... " + REC_CNT + " of " + REC_TOTCNT to PMT_MSG
						do prompt
						
						do READMRK
						
						if ltrim(trim(FROM_NAME)) = ltrim(trim(SCHD_PTR)) .and. ltrim(trim(FROM_STEP)) = ltrim(trim(STP_PTR))
							
							if .not. deleted()
								store COPY_NBR + 1 to COPY_NBR
								store ltrim(str(COPY_NBR)) to COPY_CNT
								
								store 12 to PMT_LINE
								store "Number of markers copied ..... " + COPY_CNT to PMT_MSG
								do prompt
								
								*
								* Find schedule step and initilize the marker entry
								*
								
								store TO_NAME + "SCH" to SCH_FNAME
								store TO_NAME + "SCH" to SCH_FNDX
								store TO_STEP to SCH_STEP
								
								do FINDSCH
								
								select MARKER
								
								@ 20,0
								
								do case
								case .not. SCH_SEL
									store .f. to COPY_MRK
									
									store 22 to STAT_LINE
									store "Schedule not found" to STAT_MSG
									do status
									
								case .not. STEP_SEL
									store .f. to COPY_MRK
									
									store 22 to STAT_LINE
									store "Schedule step not found" to STAT_MSG
									do status
									
								otherwise
									store .t. to COPY_MRK
									
								endcase
								
								if COPY_MRK
									store MRK_SNAME to SCHD_PTR
									store TO_STEP to STP_PTR

									store SSTP_TYP to MSTP_TYP
									
									*
									* Schedule and step found
									*
									* Setup letter information
									*
									
									do LTRGINT
									
									*
									* Setup trigger information
									*
									
									store "0  " to TRG_CNT
									store date() to TRG_DATE
									store STRG_TYP to MTRG_TYP
									
									store "COPY " to LST_SCHD
									store "   " to LST_STP
									store "This marker was copied via the copy command" + space(23) to LST_DESC
									store date() to DINT
									store date() to LST_DINT

									store "  " to ERR_FLAG
									store "no errors" to ERR_DESC

									append blank

									do WRITEMRK
									
								endif
								
							endif
							
						endif
						
						skip
						
						do CHECKKEY
						
					enddo
					
					store 22 to STAT_LINE
					store "Finished copying markers" to STAT_MSG
					do status
					
					store "No copy selected" to SEL_NAME
					
				endif
				
			else
				store 22 to STAT_LINE
				store "Your must first select a copy" to STAT_MSG
				do status
				
			endif
			
			do CLRSCRN
			
			store 1 to CHOICE_CP
			
			store .t. to continue
			store .f. to REFRESH
			
		case CHOICE = 3
			select MARKER
			use
			
			store .f. to continue
			
		endcase
		
	enddo
	
endif

return


*: EOF: MRKCOPY.PRG
