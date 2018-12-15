*:*********************************************************************
*:
*:        Program: ADVMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 3:02 pm
*:
*:      Called by: IMMENU.PRG     
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GCNAME.PRG
*:               : SELCLI.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : GMNAME.PRG
*:               : SELMRK.PRG
*:               : MANNEXT.PRG
*:               : PUTMRK           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:               : EDITMRK.PRG
*:               : READMRK          (procedure in UTILITY.PRG)
*:               : DELDATA.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* ADVMENU >>> Manually Advance a client's marker                      *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

store "2" to SELECT_NBR
store "CLIENT" to FILE_NAME
store "CLIENT" to ALIAS_NAME
store "CLILNFN" to INDEX_NAME
store "C_LST_N + C_FST_N" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store "4" to SELECT_NBR
	store "MARKER" to FILE_NAME
	store "MARKER" to ALIAS_NAME
	store "MARKER" to INDEX_NAME
	store "M_MRK_NBR" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN
		store .t. to REFRESH
		store .t. to continue
		
		store .f. to CLI_SEL
		store "No client or marker selected" to CLI_SNAME
		store CLI_SNAME to SEL_NAME
		
		set deleted on
		
		store 1 to CHOICE_ADV
		
		do while continue
			
			if REFRESH
				store "Manually Advancing Client's Markers" to hEAD
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do FRAME
			else
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do TAIL
			endif
			
			store CHOICE_ADV to CHOICE
			store 4 to MENU_CNT
			store "Client" to MENU_1
			store "Select a client" to DESC_1
			store "Marker" to MENU_2
			store "Select a marker for a selected client" to DESC_2
			store "Advance" to MENU_3
			store "Advance a selected marker for a selected client" to DESC_3
			store "Return" to MENU_4
			store "Return to the IntelliMail Main Menu" to DESC_4
			
			do menu
			
			store CHOICE to CHOICE_ADV
			
			do case
				
			case CHOICE = 1
				store .f. to CLI_SEL
				
				store 20 to PMT_LINE
				store "Selecting a client to advance" to PMT_MSG
				do prompt
				
				do GCNAME
				
				@ 20,0
				
				select CLIENT
				
				goto top
				
				seek SRCH_CLI
				
				if .not. (bof() .or. eof())
					do SELCLI
					
				else
					store 22 to STAT_LINE
					store "Could not find &CLI_SNAME" to STAT_MSG
					do status
					
				endif
				
				if CLI_SEL
					store "&CLI_SNAME selected" to SEL_NAME
					store 2 to CHOICE_ADV
					
				else
					store "No client or marker selected" to SEL_NAME
					
				endif
				
				do CLRSCRN
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 2
				if CLI_SEL
					store .f. to MRK_SEL
					
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
						store "Select the marker to be advanced" to PMT_MSG
						do prompt
						
						do GMNAME
						
						@ 20,0
						
						if MRK_SEL
							select MARKER
							
							goto top
							
							store CLI_NBR + MRK_SNAME to SRCH_MRK
							
							seek SRCH_MRK
							
							if .not. (bof() .or. eof())
								do SELMRK
								
								if MRK_SEL
									if val(MSTP_TYP) >= 1 .and. val(MSTP_TYP) <= 3
										if val(ERR_FLAG) = 0
											if SEND_FLG = "F"
												do CLRSCRN
											
												@ 7,12  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
												@ 8,12  say "º                                                     º Û"
												@ 9,12  say "º This marker does not presently require  a  response º Û"
												@ 10,12 say "º                                                     º Û"
												@ 11,12 say "º (There has not been a letter sent for this  client) º Û"
												@ 12,12 say "º                                                     º Û"
												@ 13,12 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
												@ 14,12 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
											
												store 22 to STAT_LINE
												store "ATTENTION : Please read the above" to STAT_MSG
												do status
											
												store .f. to MRK_SEL
											
											else
												store recno() to MRK_SPOT
											
												store MRK_NBR to O_MRK_NBR
												store SCHD_PTR to O_SCHD_PTR
												store STP_PTR to O_STP_PTR
												store MDESC to O_MDESC
												store DINT to O_DINT
											
											endif
										
										else
											do CLRSCRN
										
											@ 7,11  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
											@ 8,11  say "º                                                        º Û"
											@ 9,11  say "º You can not select this marker because it has an error º Û"
											@ 10,11 say "º                                                        º Û"
											@ 11,11 say "º Make a note of the client and the marker  selected  so º Û"
											@ 12,11 say "º                                                        º Û"
											@ 13,11 say "º you can clear the error from the  client  status  menu º Û"
											@ 14,11 say "º                                                        º Û"
											@ 15,11 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
											@ 16,11 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
										
											store 22 to STAT_LINE
											store "ATTENTION : Please read the above" to STAT_MSG
											do status
										
											store .f. to MRK_SEL
										
										endif
	
									else
										do CLRSCRN
											
										@ 7,12  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
										@ 8,12  say "º                                                     º Û"
										@ 9,12  say "º      This marker may not be advanced manually.      º Û"
										@ 10,12 say "º                                                     º Û"
										@ 11,12 say "º    This marker does not point to a manual step.     º Û"
										@ 12,12 say "º                                                     º Û"
										@ 13,12 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
										@ 14,12 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
											
										store 22 to STAT_LINE
										store "ATTENTION : Please read the above" to STAT_MSG
										do status
											
										store .f. to MRK_SEL
											
									endif
									
								endif
								
							else
								store .f. to MRK_SEL
								
								store 22 to STAT_LINE
								store "Could not find &MRK_SNAME marker" to STAT_MSG
								do status
								
							endif
							
							do CLRSCRN
							
						endif
						
						do CLRSCRN
							
					endif
					
				else
					store 22 to STAT_LINE
					store "You must first select a client" to STAT_MSG
					do status
					
					store 1 to CHOICE_ADV
					
				endif
				
				if MRK_SEL
					store CLI_SNAME + " " + chr(16) + " " + MRK_SNAME + " selected" to SEL_NAME
					
					store 3 to CHOICE_ADV
					
				else
					store "&CLI_SNAME selected" to SEL_NAME
					
				endif
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 3
				if CLI_SEL
					if MRK_SEL
						do MANNEXT
						
						do CLRSCRN
						
						@ 5,3  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
						@ 6,3  say "º                                                                         º Û"
						@ 7,3  say "º                                                                         º Û"
						@ 8,3  say "º                                                                         º Û"
						@ 9,3  say "º                                                                         º Û"
						@ 10,3 say "º                                                                         º Û"
						@ 11,3 say "º                                                                         º Û"
						@ 12,3 say "º                                                                         º Û"
						@ 13,3 say "º                                                                         º Û"
						@ 14,3 say "º                                                                         º Û"
						@ 15,3 say "º                                                                         º Û"
						@ 16,3 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
						@ 17,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
						
						do PUTMRK
						
						store 1 to CHOICE            
						store 3 to PICK_CNT
						store 20 to PICK_LINE
						store "Accept marker" to PICK_1
						store "Change marker" to PICK_2
						store "Cancel changes" to PICK_3
						do PICK
						
						do case
						case CHOICE = 1
							goto MRK_SPOT
							
							do WRITEMRK
							
						case CHOICE = 2
							do EDITMRK
							
							select MARKER
							
						case CHOICE = 3
							goto MRK_SPOT
							
							do READMRK
							do PUTMRK
							
						endcase
						
						if val(ERR_FLAG) = 99
							
							store 20 to PMT_LINE
							store "This marker is being removed" to PMT_MSG
							do prompt
							
							*
							* This client has been terminated delete
							* the client marker for this client
							*
							
							delete
							
							@ 20,0
							
							store 22 to STAT_LINE
							store "This marker has been deleted" to STAT_MSG
							do status
							
						endif
						
						do CLRSCRN
						
					else
						store 22 to STAT_LINE
						store "You must select a marker" to STAT_MSG
						do status
						
					endif
					
				else
					store 22 to STAT_LINE
					store "You must select a client then a marker" to STAT_MSG
					do status
					
				endif
				
				store .f. to MRK_SEL
				store "&CLI_SNAME selected" to SEL_NAME
				
				store 1 to CHOICE_ADV
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 4
				select CLIENT
				use
				select MARKER
				use
				
				set deleted off
				do DELDATA
				set deleted on
				
				store .f. to continue
				
			endcase
			
		enddo
		
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

*: EOF: ADVMENU.PRG
