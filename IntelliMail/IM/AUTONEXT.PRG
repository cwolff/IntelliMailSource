*:*********************************************************************
*:
*:        Program: AUTONEXT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 10:45 am
*:
*:      Called by: SENDMENU.PRG   
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : READMRK          (procedure in UTILITY.PRG)
*:               : READCLI          (procedure in UTILITY.PRG)
*:               : FINDSCH.PRG
*:               : STYPE4.PRG
*:               : STYPE5.PRG
*:               : STYPE6.PRG
*:               : STYPE8.PRG
*:               : CHECKKEY         (procedure in UTILITY.PRG)
*:               : LTRGINT.PRG
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:               : STYPEDL.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:           Uses: &SCH_LTTR.DBF  
*:
*:     Documented: 09/04/88 at 16:57               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* AUTONEXT >>> Automatic advance logic                                *
*	       entry : Selected client and marker                         *
*				   MRK_SPOT                                           *
*                  O_MRK_NBR                                          *
*                  O_SCHD_PTR                                         *
*        		   O_STP_PTR                                          *
*                  O_MDESC                                            *
*                  O_DINT                                             *
*	       exit : None												  *
*																	  *
***********************************************************************

@ 5,5  say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
@ 6,5  say "บ                                                                      บ Û"
@ 7,5  say "บ                                                                      บ Û"
@ 8,5  say "บ                                                                      บ Û"
@ 9,5  say "บ                                                                      บ Û"
@ 10,5 say "บ                                                                      บ Û"
@ 11,5 say "บ                                                                      บ Û"
@ 12,5 say "บ                                                                      บ Û"
@ 13,5 say "บ                                                                      บ Û"
@ 14,5 say "บ                                                                      บ Û"
@ 15,5 say "บ                                                                      บ Û"
@ 16,5 say "บ                                                                      บ Û"
@ 17,5 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
@ 18,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

store "2" to SELECT_NBR
store "CLIENT" to FILE_NAME
store "CLIENT" to ALIAS_NAME
store "CLINBR" to INDEX_NAME
store "C_CLI_NBR" to IFLD_NAME
do OPENFILE

if FILE_OPEN				
	store "4" to SELECT_NBR
	store "MARKER" to FILE_NAME
	store "MARKER" to ALIAS_NAME
	store "MARKER" to INDEX_NAME
	store "M_MRK_NBR" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN			
		store "10" to SELECT_NBR
		store "LTTRTMP" to FILE_NAME
		store "LTTR" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			copy structure to &SCH_LTTR
			
			select LTTR
			use
			
		endif
		
		store "10" to SELECT_NBR
		store SCH_LTTR to FILE_NAME
		store "LTTR" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			select MARKER
			
			store ltrim(str(reccount())) to MRK_TOT
			
			store 0 to LTR_COUNT
			store ltrim(str(LTR_COUNT)) to LTR_CNT
			store 8 to PMT_LINE
			store "Number of labels and letters to print ... " + LTR_CNT to PMT_MSG
			do prompt
			
			store 0 to DL_COUNT
			store ltrim(str(DL_COUNT)) to DL_CNT
			store 9 to PMT_LINE
			store "Number of markers advanced by deadline ... " + DL_CNT to PMT_MSG
			do prompt
			
			store 1 to MRK_CNT
			
			do while .not. (eof() .or. bof())
				@ 10,6 say space(70)
				@ 12,6 say space(70)
				@ 13,6 say space(70)
				
				store recno() to MRK_SPOT
				
				store ltrim(str(MRK_CNT)) to MRK_PLACE
				
				store 7 to PMT_LINE
				store "Searching client marker record number " + MRK_PLACE + " of " + MRK_TOT to PMT_MSG
				do prompt
				
				store .f. to READ_ERROR
				do READMRK
				
				store MRK_NBR to O_MRK_NBR
				store SCHD_PTR to O_SCHD_PTR
				store STP_PTR to O_STP_PTR
				store MDESC to O_MDESC
				store DINT to O_DINT
				
				*
				* Reset the SCH_SNAME (may have been set to TRMNT)
				*
				
				if SCHD_PTR = SCH_SNAME
					store trim(STP_PTR) to SCH_STP
					
					do case
						
						*
						* Check to see if this client is to receive a letter
						*
						
					case DATE_TOS <= date() .and. SEND_FLG = "F" .and. val(ERR_FLAG) = 0
						select CLIENT
						
						seek MRK_NBR
						
						if .not. (eof() .or. bof())
							do READCLI
							
							store LTR_COUNT + 1 to LTR_COUNT
							
							store ltrim(str(LTR_COUNT)) to LTR_CNT
							
							store 8 to PMT_LINE
							store "Number of labels and letters to print ... " + LTR_CNT to PMT_MSG
							do prompt
							
							store MRK_NBR to LTTR_NO
							store LTR_TOS to LTTR_TOS
							
							store "T" to SEND_FLG
							store date() to DATE_SNT
							
							select LTTR
							
							append blank
							replace	L_LTTR_NO with LTTR_NO
							replace L_ZIP with ZIP
							replace L_LST_N with LST_N
							replace L_FST_N with FST_N
							replace L_LTTR_TOS with LTTR_TOS
							
							*
							* Check to see if this step for this schedule
							* is to be automatically advanced
							*
							
							store .f. to GO_NXT_STP
							
							if val(MSTP_TYP) = 4 .or. val(MSTP_TYP) = 5
								store SCH_SNAME + "SCH" to SCH_FNAME
								store SCH_SNAME + "SCH" to SCH_FNDX
								store STP_PTR to SCH_STEP
								
								do FINDSCH
								
								do case
								case .not. SCH_SEL
									store "21" to ERR_FLAG
									store "Could not find the &SCH_SNAME schedule" to ERR_MSG
									store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
									store .f. to GO_NXT_STP
									
								case .not. STEP_SEL
									store "22" to ERR_FLAG
									store "Could not find step &SCH_STEP in the &SCH_SNAME schedule" to ERR_MSG
									store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
									store .f. to GO_NXT_STP
									
								otherwise
									if val(MSTP_TYP) = 4 .or. val(MSTP_TYP) = 5
										do case
										case val(MSTP_TYP) = 4
											do STYPE4
											store .t. to GO_NXT_STP
											
										case val(MSTP_TYP) = 5
											do STYPE5
											store .t. to GO_NXT_STP
											
										otherwise
											store "23" to ERR_FLAG
											store "Invalid AUTOMATIC type in step &SCH_STEP of &SCH_SNAME schedule" to ERR_MSG
											store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
											store .f. to GO_NXT_STP
											
										endcase
										
									endif
									
									*
									* Since we are not sure if the
									* schedule file was successfully
									* opened we are not sure if
									* the alias name exist so select
									* via absolute number
									*
									
									select 7
									use
									
								endcase
								
							endif
							
							*
							* If no errors and the next step is a chain step then continue
							*
							
							store 1 to CHOICE
							
							do while ( val(MSTP_TYP) = 6 .or. val(MSTP_TYP) = 7 .or. val(MSTP_TYP) = 8 ) .and. ;
									( val(ERR_FLAG) = 0 ) .and. ( CHOICE <> 0 )
								
								store SCHD_PTR + "SCH" to SCH_FNAME
								store SCHD_PTR + "SCH" to SCH_FNDX
								store STP_PTR to SCH_STEP
								
								do FINDSCH
								
								store .f. to GO_NXT_STP
								
								do case
								case .not. SCH_SEL
									store "30" to ERR_FLAG
									store "Could not find the next schedule (&SCHD_PTR)" to ERR_MSG
									store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
									store .f. to GO_NXT_STP
									
								case .not. STEP_SEL
									store "31" to ERR_FLAG
									store "Could not find the next step (&STP_PTR) in the &SCHD_PTR schedule" to ERR_MSG
									store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
									store .f. to GO_NXT_STP
									
								otherwise
									do case
									case val(MSTP_TYP) = 6
										do STYPE6
										store .t. to GO_NXT_STP
										
									case val(MSTP_TYP) = 7
										store "33" to ERR_FLAG
										store "Menu step (&STP_PTR) of the &SCHD_PTR schedule prohibited after auto step" to ERR_MSG
										store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
										store .f. to GO_NXT_STP
										
									case val(MSTP_TYP) = 8
										do STYPE8
										store .t. to GO_NXT_STP
										
									otherwise
										store "25" to ERR_FLAG
										store "Invalid CHAIN type in the next step (&STP_PTR) of the &SCHD_PTR schedule" to ERR_MSG
										store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
										store .f. to GO_NXT_STP
										
									endcase
									
									select 7
									use
									
								endcase
								
								if len(LTR_ID) = 8 .and. val(ERR_FLAG) = 0
									store LTR_COUNT + 1 to LTR_COUNT
									
									store ltrim(str(LTR_COUNT)) to LTR_CNT
									
									store 8 to PMT_LINE
									store "Number of labels and letters to print ... " + LTR_CNT to PMT_MSG
									do prompt
									
									store MRK_NBR to LTTR_NO
									store LTR_ID to LTTR_TOS
									
									store "T" to SEND_FLG
									store date() to DATE_SNT
									
									select LTTR
									
									append blank
									replace	L_LTTR_NO with LTTR_NO
									replace L_LST_N with LST_N
									replace L_FST_N with FST_N
									replace L_LTTR_TOS with LTTR_TOS
									
								endif
								
								do CHECKKEY
								
							enddo
							
							if GO_NXT_STP
								store ctod("00/00/0000/") to DATE_SNT
								
								*
								* initialize letter info
								*
								
								store 12 to PMT_LINE
								store "Initializing letter trigger information" to PMT_MSG
								do prompt
								
								do LTRGINT
								
								*
								* TRG_CNT zeroed at time it exceeds TRG_VAL (see STYPE[3,5,8].PRG
								* TRG_DATE always initialized
								*
								
								store 13 to PMT_LINE
								store "Initializing step trigger information" to PMT_MSG
								do prompt
								
								store date() to TRG_DATE
								
								*
								* Set last schedule, step, description and date initialized
								*
								
								store O_SCHD_PTR to LST_SCHD
								store O_STP_PTR to LST_STP
								store O_MDESC to LST_DESC
								store O_DINT to LST_DINT
								
							endif
							
						else
							
							*
							* 01 = Client not found
							*
							
							store "01" to ERR_FLAG
							store "Could not find the client information" to ERR_MSG
							
						endif
						
						select MARKER
						
						if val(ERR_FLAG) = 99
							delete
							
						else
							do WRITEMRK
							
						endif
						
						*
						* Check to see if this client advance deadline has come
						*
						
					case SEND_FLG = "T" .and. val(ERR_FLAG) = 0 .and. ;
							(val(MSTP_TYP) = 1 .or. val(MSTP_TYP) = 2 .or. val(MSTP_TYP) = 3)
						
						select CLIENT
						
						seek MRK_NBR
						
						if .not. (eof() .or. bof())
							do READCLI
							
							store SCH_SNAME + "SCH" to SCH_FNAME
							store SCH_SNAME + "SCH" to SCH_FNDX
							store STP_PTR to SCH_STEP
							
							do FINDSCH
							
							do case
							case .not. SCH_SEL
								store "21" to ERR_FLAG
								store "Could not find the &SCH_SNAME schedule" to ERR_MSG
								store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
								store .f. to GO_NXT_STP
								
							case .not. STEP_SEL
								store "22" to ERR_FLAG
								store "Could not find step &SCH_STEP in the &SCH_SNAME schedule" to ERR_MSG
								store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
								store .f. to GO_NXT_STP
								
							otherwise
								
								*
								* Check to see if advance deadline has been
								* exceeded
								*
								
								if DATE_SNT + val(DL_VAL) <= date()
									store .f. to GO_NXT_STP
									
									store DL_COUNT + 1 to DL_COUNT
									
									store ltrim(str(DL_COUNT)) to DL_CNT
									
									store 9 to PMT_LINE
									store "Number of markers advanced by deadline ... " + DL_CNT to PMT_MSG
									do prompt
									
									*
									* Deadline step type - advance client
									*
									
									do STYPEDL
									
									*
									* If no errors and the next step is a chain step then continue
									*
									
									store 1 to CHOICE
									
									do while ( val(MSTP_TYP) = 6 .or. val(MSTP_TYP) = 7 .or. val(MSTP_TYP) = 8 ) .and. ;
											( val(ERR_FLAG) = 0 ) .and. ( CHOICE <> 0 )
										
										store SCHD_PTR + "SCH" to SCH_FNAME
										store SCHD_PTR + "SCH" to SCH_FNDX
										store STP_PTR to SCH_STEP
										
										do FINDSCH
										
										store .f. to GO_NXT_STP
										
										do case
										case .not. SCH_SEL
											store "30" to ERR_FLAG
											store "Could not find the next schedule (&SCHD_PTR)" to ERR_MSG
											store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
											store .f. to GO_NXT_STP
											
										case .not. STEP_SEL
											store "31" to ERR_FLAG
											store "Could not find the next step (&STP_PTR) in the &SCHD_PTR schedule" to ERR_MSG
											store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
											store .f. to GO_NXT_STP
											
										otherwise
											do case
											case val(MSTP_TYP) = 6
												do STYPE6
												store .t. to GO_NXT_STP
												
											case val(MSTP_TYP) = 7
												store "34" to ERR_FLAG
												store "Menu step (&STP_PTR) of the &SCHD_PTR schedule prohibited after auto step" to ERR_MSG
												store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
												store .f. to GO_NXT_STP
												
											case val(MSTP_TYP) = 8
												do STYPE8
												store .t. to GO_NXT_STP
												
											otherwise
												store "25" to ERR_FLAG
												store "Invalid CHAIN type in the next step (&STP_PTR) of the &SCHD_PTR schedule" to ERR_MSG
												store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
												store .f. to GO_NXT_STP
												
											endcase
											
											select 7
											use
											
										endcase
										
										if len(LTR_ID) = 8 .and. val(ERR_FLAG) = 0
											store LTR_COUNT + 1 to LTR_COUNT
											
											store ltrim(str(LTR_COUNT)) to LTR_CNT
											
											store 8 to PMT_LINE
											store "Number of labels and letters to print ... " + LTR_CNT to PMT_MSG
											do prompt
											
											store MRK_NBR to LTTR_NO
											store LTR_ID to LTTR_TOS
											
											store "T" to SEND_FLG
											store date() to DATE_SNT
											
											select LTTR
											
											append blank
											replace	L_LTTR_NO with LTTR_NO
											replace L_LST_N with LST_N
											replace L_FST_N with FST_N
											replace L_LTTR_TOS with LTTR_TOS
											
										endif
										
										do CHECKKEY
										
									enddo
									
									if GO_NXT_STP
										store ctod("00/00/0000/") to DATE_SNT
										
										*
										* initialize letter info
										*
										
										store 12 to PMT_LINE
										store "Initializing letter trigger information" to PMT_MSG
										do prompt
										
										do LTRGINT
										
										*
										* TRG_CNT zeroed at time it exceeds TRG_VAL (see STYPE[3,5,8].PRG
										* TRG_DATE always initialized
										*
										
										store 13 to PMT_LINE
										store "Initializing step trigger information" to PMT_MSG
										do prompt
										
										store date() to TRG_DATE
										
										*
										* Set last schedule, step, description and date initialized
										*
										
										store O_SCHD_PTR to LST_SCHD
										store O_STP_PTR to LST_STP
										store O_MDESC to LST_DESC
										store O_DINT to LST_DINT
										
									endif
									
								endif
								
							endcase
							
							*
							* Since we are not sure if the
							* schedule file was successfully
							* opened we are not sure if
							* the alias name exist so select
							* via absolute number
							*
							
							select 7
							use
							
						else
							
							*
							* 01 = Client not found
							*
							
							store "01" to ERR_FLAG
							store "Could not find the client information" to ERR_MSG
							
						endif
						
						select MARKER
						
						if val(ERR_FLAG) = 99
							delete
							
						else
							do WRITEMRK
							
						endif
						
					endcase
					
				endif
				
				skip
				
				store MRK_CNT + 1 to MRK_CNT
				
			enddo
			
			select CLIENT
			use
			select MARKER
			use
			select LTTR
			use
			
		else
			store 22 to STAT_LINE
			store "Could not open LTTRTMP file" to STAT_MSG
			do status
			
		endif
		
		store .t. to continue
		store .t. to REFRESH
		
	else
		store 22 to STAT_LINE
		store "Could not open MARKER file" to STAT_MSG
		do status
		
	endif
	
else
	store 22 to STAT_LINE
	store "Could not open CLIENT file" to STAT_MSG
	do status
	
endif

return

*: EOF: AUTONEXT.PRG
