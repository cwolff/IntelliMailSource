*:*********************************************************************
*:
*:        Program: CLIREVUE.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Mon 5-Sep-88 at 4:18 pm
*:
*:      Called by: CLIMENU.PRG    
*:
*:          Calls: FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : READCLI          (procedure in UTILITY.PRG)
*:               : CHECKKEY         (procedure in UTILITY.PRG)
*:               : READMRK          (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* CLIREVUE >>> Print data entered on a given date   				  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to CLI_SEL
store "No date selected" to SEL_NAME

set deleted on
store 1 to CHOICE_RE

do while continue
	
	if REFRESH
		store "Reviewing Clients and Markers" to hEAD
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif
	
	store CHOICE_RE to CHOICE
	store 3 to MENU_CNT
	store "Select" to MENU_1
	store "Select the date of the clients and markers you wish to print" to DESC_1
	store "Review" to MENU_2
	store "Print out clients and markers entered on the selected date" to DESC_2
	store "Return" to MENU_3
	store "Return to Client Menu" to DESC_3
	do menu
	
	store CHOICE to CHOICE_RE
	
	do case
	case CHOICE = 1
		do CLRSCRN
		
		set confirm on
		
		@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
		@ 6,7  say "บ                                                                 บ Û"
		@ 7,7  say "บ                                                                 บ Û"
		@ 8,7  say "บ                                                                 บ Û"
		@ 9,7  say "บ                                                                 บ Û"
		@ 10,7 say "บ                                                                 บ Û"
		@ 11,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 12,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		store date() to THE_DATE
		@ 7,10 say "Please enter the date of the information you wish to print."
		@ 9,10 say "Information entered on ..." get THE_DATE picture "99/99/9999"
		
		read
		clear gets
		
		set confirm off
		
		store dtoc(THE_DATE) to INFO_DATE
		
		do CLRSCRN
		
		store 2 to CHOICE_RE
		
		store .t. to SEL_DATE
		store "&INFO_DATE date selected" to SEL_NAME
		
	case CHOICE = 2
		if SEL_DATE
			store 1 to CHOICE
			store 2 to PICK_CNT
			store 20 to PICK_LINE
			store "Print clients and markers entered on " + INFO_DATE to PICK_1
			store "Don't print" to PICK_2
			do PICK
			
			if CHOICE = 1
				store substr(INFO_DATE,1,2) + substr(INFO_DATE,4,2) + substr(INFO_DATE,10,1) to FILE_DATE
				store "cli" + FILE_DATE to FILENAMEP
				store "daily\cli" + FILE_DATE + ".dbf" to PFILENAME
				store "mrk" + FILE_DATE to FILENAMEM
				store "daily\mrk" + FILE_DATE + ".dbf" to MFILENAME
				
				store 2 to UPTOTAL
				store 40 to UPWIDTH
				
				if file(PFILENAME)
					set console off
					set print on
					
					eject
					
					set print off
					set console on
					
					store "2" to SELECT_NBR
					store FILENAMEP to FILE_NAME
					store "CLIENT" to ALIAS_NAME
					store "" to INDEX_NAME
					store "" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store 0 to REC_NBR
						goto bottom
						store ltrim(str(recno())) to REC_TOT
						goto top
						
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
								
								@ 7,10 say "Reading client profile for record number ... " + REC_CNT + " of " + REC_TOT
								
								store .f. to READ_ERROR
								do READCLI
								
								store LINE1 + space(UPCOUNT * UPWIDTH - len(LINE1)) + trim(FST_N) + " " + trim(M_I) + " " + trim(LST_N) to LINE1
								store LINE2 + space(UPCOUNT * UPWIDTH - len(LINE2)) + trim(sTREET) to LINE2
								store LINE3 + space(UPCOUNT * UPWIDTH - len(LINE3)) + trim(CITY) + ", " + trim(STATE) + " " + trim(ZIP) to LINE3
								store LINE4 + space(UPCOUNT * UPWIDTH - len(LINE4)) + trim(CLI_NBR) + " " + ;
									trim(dtoc(BIRTH)) + " " + trim(PHONE) + " " + trim(LOGON) to LINE4
								store LINE5 + space(UPCOUNT * UPWIDTH - len(LINE5)) + substr(COMMENTS,1,38) to LINE5
								
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
						
						select CLIENT
						use
						
					endif
					
				else
					@ 7,10 say "No client information was added on " + INFO_DATE + "."
					
				endif
				
				if file(MFILENAME) .and. CHOICE <> 0
					set console off
					set print on
					
					eject
					
					set print off
					set console on
					
					store "4" to SELECT_NBR
					store FILENAMEM to FILE_NAME
					store "MARKER" to ALIAS_NAME
					store "" to INDEX_NAME
					store "" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store 0 to REC_NBR
						goto bottom
						store ltrim(str(recno())) to REC_TOT
						goto top
						
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
								
								@ 9,10 say "Reading markers for record number ... " + REC_CNT + " of " + REC_TOT
								
								store .f. to READ_ERROR
								do READMRK
								
								store LINE1 + space(UPCOUNT * UPWIDTH - len(LINE1)) + "client number=" + MRK_NBR to LINE1
								
								store LINE2 + space(UPCOUNT * UPWIDTH - len(LINE2)) + "schedule=" + SCHD_PTR + ;
									", step=" + trim(STP_PTR) +  ", error=" + trim(ERR_FLAG) to LINE2
								
								store LINE3 + space(UPCOUNT * UPWIDTH - len(LINE3)) + "ltr=" + trim(LTR_TOS) + ;
									", send date=" + dtoc(DATE_TOS) to LINE3
								
								store LINE4 + space(UPCOUNT * UPWIDTH - len(LINE4)) + "ltr snt=" + SEND_FLG + ;
									", date sent=" + dtoc(DATE_SNT) to LINE4
								
								store LINE5 + space(UPCOUNT * UPWIDTH - len(LINE5)) + "lmt cnt=" + trim(TRG_CNT) + ;
									", lmt date=" + dtoc(TRG_DATE) + ", " + trim(LOGON) to LINE5
								
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
						
						select MARKER
						use
						
					endif
					
				else
					@ 9,10 say "No marker information was added on " + INFO_DATE + "."
					
				endif
				
				store 22 to STAT_LINE
				store "Done printing information for " + INFO_DATE to STAT_MSG
				do status
				
			endif
			
			do CLRSCRN
			
		else
			store 22 to STAT_LINE
			store "No date selected" to STAT_MSG
			do status
			
		endif
		
		store 1 to CHOICE_RE
		
		store .t. to continue
		store .f. to REFRESH
		
	case CHOICE = 3
		store .f. to continue
		
	endcase
	
enddo

return

*: EOF: CLIREVUE.PRG
