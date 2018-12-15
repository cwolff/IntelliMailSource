*:*********************************************************************
*:
*:        Program: CLISTAT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 1:41 pm
*:
*:      Called by: CLIMENU.PRG    
*:
*:          Calls: FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : DATETAIL         (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : READCLI          (procedure in UTILITY.PRG)
*:               : CHECKKEY         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : READMRK          (procedure in UTILITY.PRG)
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:
*:           Uses: SCHDLIST.DBF   
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
*                                                                     *
* CLISTAT >>> Print clinet status information (client and marker file)*
*             and/or clear errors for a schedule                      *
*	       entry : None						                          *
*	       exit : None						                          *
*									                                  *
***********************************************************************

store .f. to STA_SEL
store "No status operation selected" to SEL_NAME

set deleted on
store 1 to CHOICE_ST

do while continue
	
	if REFRESH
		store "Status of Clients and Markers" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_ST to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select the status operation to perform" to DESC_1
	store "Perform" to MENU_2
	store "Perform the select status operation" to DESC_2
	store "Return" to MENU_3
	store "Return to Editing Clients and Markers" to DESC_3
	do menu
	
	store CHOICE to CHOICE_ST
	
	do case
		
	case CHOICE = 1
		store space(5) to SCHD_NAME
		store .f. to STA_SEL
		
		do DATETAIL
		store "Press   " + chr(27) + " " + chr(26) + " Del to SELECT ฤู when DONE" to R_TAIL
		do TAIL
		
		store "6" to SELECT_NBR
		store "SCHDDIR" to FILE_NAME
		store "SCHDDIR" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			store 20 to PMT_LINE
			store "One moment please, collecting schedule information." to PMT_MSG
			do prompt
			
			copy to SCHDLIST
			
			select SCHDDIR
			use
			
			store "6" to SELECT_NBR
			store "SCHDLIST" to FILE_NAME
			store "SCHDLIST" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			goto bottom
			append blank
			replace SCHD_SNAME with "ALL  "
			
			goto top
			
			store 0 to MAX_VALUE
			do while .not. (eof() .or. bof())
				store SCHD_SNAME to SCHD_NAME
				
				if SCHD_NAME <> "ALL  "
					store SCHD_NAME + "SCH" to FILENAME
					
					store "7" to SELECT_NBR
					store FILENAME to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store FILENAME to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store reccount() to MAX_VALUE
						
						select SCHD
						use
						
						select SCHDLIST
						replace SCHD_MAX with MAX_VALUE
						
					endif
					
				endif
				
				skip
				
			enddo
			
			@ 20,0
			
			store "Selected schedule is ........................... " to MENU_1
			store "Selected low value of step range is ............ " to MENU_2
			store "Selected high value of step range is ........... " to MENU_3
			store "Selected ERROR filter is ....................... " to MENU_4
			store "Selected WAITING to be ADVANCED filter is ...... " to MENU_5
			store "Clear the errors from the selected clients .... " to MENU_6
			store "Print information from the selected clients ... " to MENU_7
			
			select SCHDLIST
			goto bottom
			store SCHD_SNAME to SCHD_NAME
			
			if SCHD_NAME = "ALL  "
				store "-----------" to ERR_VALUE
				store "-----------" to ADV_VALUE
				store "---" to LSTP_VALUE
				store "---" to HSTP_VALUE
				store "---" to CLR_VALUE
				store "YES" to PRNT_VALUE
			else
				store "NOT USED   " to ERR_VALUE
				store "NOT USED   " to ADV_VALUE
				store SCHD_MAX to MAX_VALUE
				if MAX_VALUE > 0
					store "  1" to LSTP_VALUE
				else
					store "  0" to LSTP_VALUE
				endif
				store str(MAX_VALUE,3) to HSTP_VALUE
				store "NO " to CLR_VALUE
				store "YES" to PRNT_VALUE
			endif
			
			@ 5,3  say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			@ 6,3  say "บ                                                                        บ"
			@ 7,3  say "บ                                                                        บ"
			@ 8,3  say "บ                                                                        บ"
			@ 9,3  say "บ                                                                        บ"
			@ 10,3 say "บ                                                                        บ"
			@ 11,3 say "บ                                                                        บ"
			@ 12,3 say "บ                                                                        บ"
			@ 13,3 say "บ                                                                        บ"
			@ 14,3 say "บ                                                                        บ"
			@ 15,3 say "บ                                                                        บ"
			@ 16,3 say "บ                                                                        บ"
			@ 17,3 say "บ                                                                        บ"
			@ 18,3 say "บ                                                                        บ"
			@ 19,3 say "บ                                                                        บ"
			@ 20,3 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
			
			select SCHDLIST
			
			@  7,5 say "Chose the schedule(s) and step(s) from which to select clients."
			@ 12,5 say "Chose the filter to use to screen the selected clients."
			@ 16,5 say "Chose the action to take place on the selected clients."
			
			@ 18,10 say MENU_7 get PRNT_VALUE picture "XXX"
			@ 17,10 say MENU_6 get CLR_VALUE picture "XXXX"
			@ 14,10 say MENU_5 get ADV_VALUE picture "XXXXXXXXXXXX"
			@ 13,10 say MENU_4 get ERR_VALUE picture "XXXXXXXXXXXX"
			@ 10,10 say MENU_3 get HSTP_VALUE picture "999"
			@  9,10 say MENU_2 get LSTP_VALUE picture "999"
			@  8,10 say MENU_1 get SCHD_NAME picture "XXXXX"
			clear gets
			
			store 1 to select
			store .t. to AGAIN
			store .f. to STA_SEL
			do while AGAIN
				store inkey() to key
				
				if key <> 0
					
					do case
						
						*
						* Up Arrow () for UP
						*
						
					case key = 5 .or. key = 56
						if select > 1
							store select - 1 to select
						else
							store 7 to select
						endif
						
						*
						* Down Arrow () for DOWN
						*
						
					case key = 24 .or. key = 50
						if select < 7
							store select + 1 to select
						else
							store 1 to select
						endif
						
						*
						* RET KEY (ฤฤู) when DONE
						*
						
					case key = 13
						store .f. to AGAIN
						store .t. to STA_SEL
						
						*
						* Del Key to CANCEL
						*
						
					case key = 7
						store .f. to AGAIN
						store .f. to STA_SEL
						
						*
						* Left Arrow (<-) to SELECT previous value
						*
						
					case key = 19 .or. key = 52
						do case
						case select = 1
							skip -1
							if bof()
								goto bottom
							endif
							store SCHD_SNAME to SCHD_NAME
							if SCHD_NAME = "ALL  "
								store "-----------" to ERR_VALUE
								store "-----------" to ADV_VALUE
								store "---" to LSTP_VALUE
								store "---" to HSTP_VALUE
								store "---" to CLR_VALUE
								store "YES" to PRNT_VALUE
							else
								store "NOT USED   " to ERR_VALUE
								store "NOT USED   " to ADV_VALUE
								store SCHD_MAX to MAX_VALUE
								if MAX_VALUE > 0
									store "  1" to LSTP_VALUE
								else
									store "  0" to LSTP_VALUE
								endif
								store str(MAX_VALUE,3) to HSTP_VALUE
								store "NO " to CLR_VALUE
								store "YES" to PRNT_VALUE
							endif
							
						case select = 2
							if LSTP_VALUE <> "---"
								if val(LSTP_VALUE) > 1
									store str((val(LSTP_VALUE) - 1),3) to LSTP_VALUE
								else
									store str(MAX_VALUE,3) to LSTP_VALUE
								endif
								if val(LSTP_VALUE) > val(HSTP_VALUE)
									store LSTP_VALUE to HSTP_VALUE
								endif
							endif
							
						case select = 3
							if HSTP_VALUE <> "---"                    
								if val(HSTP_VALUE) > 1
									store str((val(HSTP_VALUE) - 1),3) to HSTP_VALUE
								else
									store str(MAX_VALUE,3) to HSTP_VALUE
								endif
								if val(LSTP_VALUE) > val(HSTP_VALUE)
									store HSTP_VALUE to LSTP_VALUE
								endif
							endif
							
						case select = 4
							if ERR_VALUE <> "-----------"
								do case
								case ERR_VALUE = "NOT USED   "
									store "NO ERRORS  " to ERR_VALUE
									
								case ERR_VALUE = "NO ERRORS  "
									store "ERRORS ONLY" to ERR_VALUE
									
								case ERR_VALUE = "ERRORS ONLY"
									store "NOT USED   " to ERR_VALUE
								endcase
							endif
							
						case select = 5
							if ADV_VALUE <> "-----------"
								do case	                        
								case ADV_VALUE = "NOT USED   "
									store "NOT WAITING" to ADV_VALUE
									
								case ADV_VALUE = "NOT WAITING"
									store "WAITING    " to ADV_VALUE
									
								case ADV_VALUE = "WAITING    "
									store "NOT USED   " to ADV_VALUE
									
								endcase
							endif
							
						case select = 6
							if CLR_VALUE <> "---"
								if CLR_VALUE = "YES"
									store "NO " to CLR_VALUE
									if PRNT_VALUE <> "YES"
										store "YES" to PRNT_VALUE
									endif
								else
									store "YES" to CLR_VALUE
								endif
							endif
							
						case select = 7
							if CLR_VALUE <> "---"
								if PRNT_VALUE = "YES"
									store "NO " to PRNT_VALUE
									if CLR_VALUE <> "---"
										if CLR_VALUE <> "YES"
											store "YES" to CLR_VALUE
										endif
									endif
								else
									store "YES" to PRNT_VALUE
								endif
							endif
							
						endcase
						
						*
						* Right Arrow (->) to SELECT next value
						*
						
					case key = 4 .or. key = 54
						do case
						case select = 1
							skip
							if eof()
								goto top
							endif
							store SCHD_SNAME to SCHD_NAME
							if SCHD_NAME = "ALL  "
								store "-----------" to ERR_VALUE
								store "-----------" to ADV_VALUE
								store "---" to LSTP_VALUE
								store "---" to HSTP_VALUE
								store "---" to CLR_VALUE
								store "YES" to PRNT_VALUE
							else
								store "NOT USED   " to ERR_VALUE
								store "NOT USED   " to ADV_VALUE
								store SCHD_MAX to MAX_VALUE
								if MAX_VALUE > 0
									store "  1" to LSTP_VALUE
								else
									store "  0" to LSTP_VALUE
								endif
								store str(MAX_VALUE,3) to HSTP_VALUE
								store "NO " to CLR_VALUE
								store "YES" to PRNT_VALUE
							endif
							
						case select = 2
							if LSTP_VALUE <> "---"
								if val(LSTP_VALUE) < MAX_VALUE
									store str((val(LSTP_VALUE) + 1),3) to LSTP_VALUE
								else
									if MAX_VALUE > 0
										store "  1" to LSTP_VALUE
									else
										store "  0" to LSTP_VALUE
									endif
								endif
								if val(LSTP_VALUE) > val(HSTP_VALUE)
									store LSTP_VALUE to HSTP_VALUE
								endif
							endif
							
						case select = 3
							if HSTP_VALUE <> "---"
								if val(HSTP_VALUE) < MAX_VALUE
									store str((val(HSTP_VALUE) + 1),3) to HSTP_VALUE
								else
									if MAX_VALUE > 0
										store "  1" to HSTP_VALUE
									else
										store "  0" to HSTP_VALUE
									endif
								endif
								if val(LSTP_VALUE) > val(HSTP_VALUE)
									store HSTP_VALUE to LSTP_VALUE
								endif
							endif
							
						case select = 4
							if ERR_VALUE <> "-----------"
								do case	                        
								case ERR_VALUE = "NOT USED   "
									store "ERRORS ONLY" to ERR_VALUE
									
								case ERR_VALUE = "ERRORS ONLY"
									store "NO ERRORS  " to ERR_VALUE
									
								case ERR_VALUE = "NO ERRORS  "
									store "NOT USED   " to ERR_VALUE
									
								endcase
							endif
							
						case select = 5
							if ADV_VALUE <> "-----------"
								do case	                        
								case ADV_VALUE = "NOT USED   "
									store "WAITING    " to ADV_VALUE
									
								case ADV_VALUE = "WAITING    "
									store "NOT WAITING" to ADV_VALUE
									
								case ADV_VALUE = "NOT WAITING"
									store "NOT USED   " to ADV_VALUE
									
								endcase
							endif
							
						case select = 6
							if CLR_VALUE <> "---"
								if CLR_VALUE = "YES"
									store "NO " to CLR_VALUE
									if PRNT_VALUE <> "YES"
										store "YES" to PRNT_VALUE
									endif
								else
									store "YES" to CLR_VALUE
								endif
							endif
							
						case select = 7
							if CLR_VALUE <> "---"
								if PRNT_VALUE = "YES"
									store "NO " to PRNT_VALUE
									if CLR_VALUE <> "---"
										if CLR_VALUE <> "YES"
											store "YES" to CLR_VALUE
										endif
									endif
								else
									store "YES" to PRNT_VALUE
								endif
							endif
							
						endcase
						
					endcase
					
					do case
					case select = 1
						@ 18,10 say MENU_7 get PRNT_VALUE picture "XXX"
						@ 17,10 say MENU_6 get CLR_VALUE picture "XXX"
						@ 14,10 say MENU_5 get ADV_VALUE picture "XXXXXXXXXXXX"
						@ 13,10 say MENU_4 get ERR_VALUE picture "XXXXXXXXXXXX"
						@ 10,10 say MENU_3 get HSTP_VALUE picture "999"
						@  9,10 say MENU_2 get LSTP_VALUE picture "999"
						@  8,10 say MENU_1 get SCHD_NAME picture "XXXXX"
						
					case select = 2
						@  8,10 say MENU_1 get SCHD_NAME picture "XXXXX"
						@ 10,10 say MENU_3 get HSTP_VALUE picture "999"
						@  9,10 say MENU_2 get LSTP_VALUE picture "999"
						
					case select = 3
						@  8,10 say MENU_1 get SCHD_NAME picture "XXXXX"
						@  9,10 say MENU_2 get LSTP_VALUE picture "999"
						@ 10,10 say MENU_3 get HSTP_VALUE picture "999"
						
					case select = 4
						@ 13,10 say MENU_4 get ERR_VALUE picture "XXXXXXXXXXXX"
						
					case select = 5
						@ 14,10 say MENU_5 get ADV_VALUE picture "XXXXXXXXXXXX"
						
					case select = 6
						@ 18,10 say MENU_7 get PRNT_VALUE picture "XXX"
						@ 17,10 say MENU_6 get CLR_VALUE picture "XXX"
						
					case select = 7
						@ 17,10 say MENU_6 get CLR_VALUE picture "XXX"
						@ 18,10 say MENU_7 get PRNT_VALUE picture "XXX"
						
					endcase
					
					clear gets
					
				endif
				
			enddo
			
		endif
		
		if STA_SEL
			store "Status operation selected" to SEL_NAME
			store 2 to CHOICE_ST
			
		else
			store "No status operation selected" to SEL_NAME
			
		endif
		
		store .t. to continue
		store .t. to REFRESH
		
	case CHOICE = 2
		
		*
		* If STA_SEL then perform status function as defined by:
		*
		*    filters:
		*        SCHD_NAME -> schedule name ("ALL  ", schedule name)
		*        LSTP_VALUE -> low step range ("1  " to X, "---")
		*        HSTP_VALUE -> high step range ("1  " to X, "---")
		*        ERR_VALUE -> error filter ("NOT USED   ", "NO ERRORS  ", "ERRORS ONLY", "-----------")
		*        ADV_VALUE -> waiting to be advanced filter ("NOT USED   ", "NOT WAITING", "WAITING    ", "-----------")
		*
		*    actions:
		*        CLR_VALUE -> clear error indicator ("YES", "NO ", "---")
		*        PRNT_VALUE -> print indicator ("YES", "NO ", "---")
		*
		
		if STA_SEL
			store "Performing status operation" to L_TAIL
			store "Press Del to CANCEL" to R_TAIL
			do TAIL
			
			@  5,1 say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			@  6,1 say "บ                                                                            บ"
			@  7,1 say "บ                                                                            บ"
			@  8,1 say "บ                                                                            บ"
			@  9,1 say "บ                                                                            บ"
			@ 10,1 say "บ                                                                            บ"
			@ 11,1 say "บ                                                                            บ"
			@ 12,1 say "บ                                                                            บ"
			@ 13,1 say "บ                                                                            บ"
			@ 14,1 say "บ                                                                            บ"
			@ 15,1 say "บ                                                                            บ"
			@ 16,1 say "บ                                                                            บ"
			@ 17,1 say "บ                                                                            บ"
			@ 18,1 say "บ                                                                            บ"
			@ 19,1 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
			
			@  7,18 say "Schedule ........................" get SCHD_NAME picture "XXXXX"
			@  8,18 say "Low Step Range .................." get LSTP_VALUE picture "999"
			@  9,18 say "High Step Range ................." get HSTP_VALUE picture "999"
			@ 10,18 say "Error Filter ...................." get ERR_VALUE picture "XXXXXXXXXXX"
			@ 11,18 say "Waiting to be Advanced Filter ..." get ADV_VALUE picture "XXXXXXXXXXX"
			@ 12,18 say "Clear Error Action .............." get CLR_VALUE picture "XXX"
			@ 13,18 say "Print Action ...................." get PRNT_VALUE picture "XXX"
			
			clear gets
			
			if SCHD_NAME = "ALL  "
				
				*
				* Print SCHD_NAME = "ALL  "
				*
				*     filters (not used);
					*         SCHD_NAME -> schedule name ("ALL  ")
				*         LSTP_VALUE -> low step range ("---")
				*         HSTP_VALUE -> high step range ("---")
				*         ERR_VALUE -> error filter ("-----------")
				*         ADV_VALUE -> waiting to be advanced filter ("-----------")
				*
				*     actions (only PRNT_VALUE used):
				*         CLR_VALUE -> clear error indicator ("---")
				*         PRNT_VALUE -> print indicator ("YES")
				*
				
				store "2" to SELECT_NBR
				store "CLIENT" to FILE_NAME
				store "CLIENT" to ALIAS_NAME
				store "CLILNFN" to INDEX_NAME
				store "C_LST_N + C_FST_N" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					store ltrim(str(reccount())) to REC_TOT
					
					store 0 to REC_NBR
					store ltrim(str(REC_NBR)) to REC_CNT
					
					store 15 to PMT_LINE
					store "Reading client profile for record number ... " + REC_CNT + " of " + REC_TOT to PMT_MSG
					do prompt
					
					set console off
					set print on
					
					eject
					
					? "IntelliMail Client Status Report"
					?
					? "Schedule = " + SCHD_NAME + "            Low Step Range = " + LSTP_VALUE + "  High Step Range = " + HSTP_VALUE
					? "Error Filter = " + ERR_VALUE + "  Waiting to be Advanced Filter = " + ADV_VALUE
					? "Clear Action = " + CLR_VALUE + "          Print Action = " + PRNT_VALUE
					? 
					
					set print off
					set console on
					
					store 2 to UPTOTAL
					store 40 to UPWIDTH
					
					store 1 to CHOICE
					
					do while .not. (eof() .or. bof()) .and. (CHOICE <> 0)
						store 0 to UPCOUNT
						
						store "" to LINE1
						store "" to LINE2
						store "" to LINE3
						store "" to LINE4
						store "" to LINE5		
						
						do while .not. (eof() .or. bof()) .and. (UPCOUNT < UPTOTAL) .and. (CHOICE <> 0)
							store REC_NBR + 1 to REC_NBR
							store ltrim(str(REC_NBR)) to REC_CNT
							
							store 15 to PMT_LINE
							store "Reading client profile for record number ... " + REC_CNT + " of " + REC_TOT to PMT_MSG
							do prompt
							
							do READCLI
							
							store LINE1 + space(UPCOUNT * UPWIDTH - len(LINE1)) + trim(FST_N) + " " + trim(M_I) + " " + trim(LST_N) to LINE1
							store LINE2 + space(UPCOUNT * UPWIDTH - len(LINE2)) + trim(sTREET) to LINE2
							store LINE3 + space(UPCOUNT * UPWIDTH - len(LINE3)) + trim(CITY) + ", " + trim(STATE) + " " + trim(ZIP) to LINE3
							store LINE4 + space(UPCOUNT * UPWIDTH - len(LINE4)) + trim(CLI_NBR) + " " + ;
								trim(dtoc(BIRTH)) + " " + trim(PHONE) + " " + trim(LOGON) to LINE4
							store LINE5 + space(UPCOUNT * UPWIDTH - len(LINE5)) + trim(substr(COMMENTS,1,38)) to LINE5
							
							store UPCOUNT + 1 to UPCOUNT
							
							skip
							
							do CHECKKEY
						enddo
						
						set console off
						set print on
						
						? LINE1
						? LINE2
						? LINE3
						? LINE4
						? LINE5
						?
						
						set print off
						set console on
						
					enddo
					
					if CHOICE <> 0
						store 22 to STAT_LINE
						store "Status operation completed" to STAT_MSG
						do status
						
					else
						store 22 to STAT_LINE
						store "Status operation canceled" to STAT_MSG
						
					endif
					
					select CLIENT
					use
					
				else
					store 22 to STAT_LINE
					store "Could not open CLIENT file" to STAT_MSG
					do status
					
				endif
				
			else
				
				*
				* Print SCHD_NAME <> "ALL  "
				*
				*     filters (all used):
				*         SCHD_NAME -> schedule name (schedule name)
				*         LSTP_VALUE -> low step range ("1  " to X)
				*         HSTP_VALUE -> high step range ("1  " to X)
				*         ERR_VALUE -> error filter ("NOT USED   ", "NO ERRORS  ", "ERRORS ONLY")
				*         ADV_VALUE -> waiting to be advanced filter ("NOT USED   ", "NOT WAITING", "WAITING    ")
				*
				*     actions (at least one used):
				*         CLR_VALUE -> clear error indicator ("YES", "NO ")
				*         PRNT_VALUE -> print indicator ("YES", "NO ")
				*
				
				store SCHD_NAME + "SCH" to SCH_FNAME
				store SCHD_NAME + "SCH" to SCH_FNDX
				
				store "4" to SELECT_NBR
				store "MARKER" to FILE_NAME
				store "MARKER" to ALIAS_NAME
				store "MARKER" to INDEX_NAME
				store "M_MRK_NBR" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					store .t. to STA_SEL
					
					store "2" to SELECT_NBR
					store "CLIENT" to FILE_NAME
					store "CLIENT" to ALIAS_NAME
					store "CLILNFN" to INDEX_NAME
					store "C_LST_N + C_FST_N" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store ltrim(str(reccount())) to REC_TOT
						
						store 0 to REC_NBR
						store ltrim(str(REC_NBR)) to REC_CNT
						
						store 15 to PMT_LINE
						store "Reading client profile for record number ... " + REC_CNT + " of " + REC_TOT to PMT_MSG
						do prompt
						
						store 0 to PTR_NBR
						store ltrim(str(REC_NBR)) to PTR_CNT
						
						store 17 to PMT_LINE
						store "Number of matches found ... " + PTR_CNT to PMT_MSG
						do prompt
						
						*
						* Apply action:
						*     PRNT_VALUE
						*
						
						if PRNT_VALUE = "YES"
							set console off
							set print on
							
							eject
							
							? "IntelliMail Client Status Report"
							?
							? "Schedule = " + SCHD_NAME + "            Low Step Range = " + LSTP_VALUE + "  High Step Range = " + HSTP_VALUE
							? "Error Filter = " + ERR_VALUE + "  Waiting to be Advanced Filter = " + ADV_VALUE
							? "Clear Action = " + CLR_VALUE + "          Print Action = " + PRNT_VALUE
							? 
							
							set print off
							set console on
							
						endif
						
						store 2 to UPTOTAL
						
						store 40 to UPWIDTH
						
						store 1 to CHOICE
						
						do while .not. (eof() .or. bof()) .and. (CHOICE <> 0)
							store 0 to UPCOUNT
							
							*
							* Apply action:
							*     PRNT_VALUE
							*
							
							if PRNT_VALUE = "YES"
								store "" to LINE1
								store "" to LINE2
								store "" to LINE3
								store "" to LINE4
								store "" to LINE5
								
							endif
							
							do while .not. (eof() .or. bof()) .and. UPCOUNT < UPTOTAL .and. (CHOICE <> 0)
								store REC_NBR + 1 to REC_NBR
								store ltrim(str(REC_NBR)) to REC_CNT
								
								store 15 to PMT_LINE
								store "Reading client profile for record number ... " + REC_CNT + " of " + REC_TOT to PMT_MSG
								do prompt
								
								do READCLI
								
								*
								* Apply filter:
								*     SCHD_NAME
								*
								
								select MARKER
								
								store CLI_NBR + SCHD_NAME to MARK_PTR
								
								seek MARK_PTR
								
								if .not. (eof() .or. bof())
									store .f. to READ_ERROR
									do READMRK
									
									*
									* Apply filters:
									*     LSTP_VALUE, HSTP_VALUE,
									*     ERR_VALUE,
									*     ADV_VALUE,
									*
									
									if (val(LSTP_VALUE) <= val(STP_PTR)) .and. (val(HSTP_VALUE) >= val(STP_PTR))
										
										if (ERR_VALUE = "NOT USED   ") .or. ;
												((ERR_VALUE = "ERRORS ONLY") .and. (val(ERR_FLAG) > 0)) .or. ;
												((ERR_VALUE = "NO ERRORS  ") .and. (val(ERR_FLAG) = 0))
											
											if (ADV_VALUE = "NOT USED   ") .or. ;
													((ADV_VALUE = "WAITING    ") .and. (SEND_FLG = "T")) .or. ;
													((ADV_VALUE = "NOT WAITING") .and. (SEND_FLG = "F"))
												
												store PTR_NBR + 1 to PTR_NBR
												store ltrim(str(PTR_NBR)) to PTR_CNT
												
												store 17 to PMT_LINE
												store "Number of matches found ... " + PTR_CNT to PMT_MSG
												do prompt
												
												*
												* Apply action:
												*     PRNT_VALUE
												*
												
												if PRNT_VALUE = "YES"
													store LINE1 + space(UPCOUNT * UPWIDTH - len(LINE1)) + ;
														trim(FST_N) + " " + ;
														trim(M_I) + " " + trim(LST_N) to LINE1
													store LINE2 + space(UPCOUNT * UPWIDTH - len(LINE2)) + ;
														trim(sTREET) to LINE2
													store LINE3 + space(UPCOUNT * UPWIDTH - len(LINE3)) + ;
														trim(CITY) + ", " + trim(STATE) + ;
														" " + trim(ZIP) to LINE3
													store LINE4 + space(UPCOUNT * UPWIDTH - len(LINE4)) + ;
														trim(CLI_NBR) + " " + trim(dtoc(BIRTH)) + " " + ;
														trim(PHONE) + " " + trim(LOGON)to LINE4
													if SEND_FLG = "T" .and. date() - DATE_SNT > 29
														store LINE5 + space(UPCOUNT * UPWIDTH - len(LINE5)) + ;
															trim(SCHD_NAME) + " " + trim(STP_PTR) + ", Err=" + ;
															trim(ERR_FLAG) + ", SNT=" + SEND_FLG + ;
															", " + dtoc(DATE_TOS) + " ***" to LINE5
														
													else
														store LINE5 + space(UPCOUNT * UPWIDTH - len(LINE5)) + ;
															trim(SCHD_NAME) + " " + trim(STP_PTR) + ", Err=" + ;
															trim(ERR_FLAG) + ", SNT=" + SEND_FLG + ", " + dtoc(DATE_TOS) to LINE5
														
													endif
													
												endif
												
												*
												* Apply action:
												*     CLR_VALUE
												*
												
												if CLR_VALUE = "YES"
													store "00" to ERR_FLAG
													do WRITEMRK
													
												endif
												
												store UPCOUNT + 1 to UPCOUNT
												
											endif
											
										endif
										
									endif
									
								endif
								
								select CLIENT
								
								skip
								
								do CHECKKEY
								
							enddo
							
							*
							* Apply action:
							*     PRNT_VALUE
							*
							
							if PRNT_VALUE = "YES"
								set console off
								set print on
								
								? LINE1
								? LINE2
								? LINE3
								? LINE4
								? LINE5
								?
								
								set print off
								set console on
								
							endif
							
						enddo
						
						if CHOICE <> 0
							store 22 to STAT_LINE
							store "Status operation completed" to STAT_MSG
							do status
							
						else
							store 22 to STAT_LINE
							store "Status operation canceled" to STAT_MSG
							
						endif
						
						select CLIENT
						use
						
						select MARKER
						use
						
					else
						store .f. to STA_SEL
						
						store 22 to STAT_LINE
						store "Could not open CLIENT file" to STAT_MSG
						do status
						
					endif
					
				else	
					store .f. to STA_SEL
					
					store 22 to STAT_LINE
					store "Could not open MARKER file" to STAT_MSG
					do status
					
				endif
				
			endif
			
		else
			store 22 to STAT_LINE
			store "You must first select a status operation" to STAT_MSG
			do status
			
		endif
		
		do CLRSCRN
		
		store 1 to CHOICE_ST
		
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 3
		store .f. to continue
		
	endcase
	
enddo

select 6
use

if file("SCHDLIST.DBF")
	delete file SCHDLIST.DBF
	
endif

return

*: EOF: CLISTAT.PRG
