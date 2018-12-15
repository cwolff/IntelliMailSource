*:*********************************************************************
*:
*:        Program: CLIEDIT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 26-Mar-89 at 0:10 am
*:
*:      Called by: CLIMENU.PRG    
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : GCNAME.PRG
*:               : SELCLI.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : EDITCLI.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : GMNAME.PRG
*:               : SELMRK.PRG
*:               : EDITMRK.PRG
*:               : READCLI          (procedure in UTILITY.PRG)
*:               : CHECKKEY         (procedure in UTILITY.PRG)
*:               : DELDATA.PRG
*:
*:     Documented: 09/04/88 at 16:54               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* CLIEDIT >>> Edit allows user to edit the data base				  *
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
		store "No client selected" to SEL_NAME
		
		set deleted on
		store 1 to CHOICE_PE
		
		do while continue
			
			if REFRESH
				store "Edit Clients and Markers" to hEAD
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do FRAME
			else
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do TAIL
			endif
			
			store CHOICE_PE to CHOICE
			store 4 to MENU_CNT
			store "Select" to MENU_1
			store "Select client by name" to DESC_1
			store "Edit" to MENU_2
			store "Edit markers for selected client" to DESC_2
			store "Remove" to MENU_3
			store "Remove clients that do not have any markers" to DESC_3
			store "Return" to MENU_4
			store "Return to Client Menu" to DESC_4
			do menu
			
			store CHOICE to CHOICE_PE
			
			do case
				
			case CHOICE = 1
				do GCNAME
				
				select CLIENT
				
				goto top
				
				seek SRCH_CLI
				
				if .not. (bof() .or. eof())
					do SELCLI
					
					if CLI_SEL
						store 2 to CHOICE
						store 3 to PICK_CNT
						store 20 to PICK_LINE
						store "Change client" to PICK_1
						store "Don't change client" to PICK_2
						store "Remove client" to PICK_3
						do PICK
						
						do case
						case CHOICE = 1
							do EDITCLI
							
						case CHOICE = 2
							do CLRSCRN
							
						case CHOICE = 3
							store 20 to PMT_LINE
							store "Removing the entry for &CLI_SNAME" to PMT_MSG
							do prompt
							
							store CLI_NBR to MRK_NBR
							
							delete
							
							if file("MARKER.DBF")
								select MARKER
								
								seek MRK_NBR
								
								do while .not. (eof() .or. bof())
									
									delete
									
									seek MRK_NBR
									
								enddo
								
							endif
							
							store "?????" to CLI_SNBR
							store "No client selected" to CLI_SNAME
							store .f. to CLI_SEL
							
						endcase
						
					endif
					
				else
					store 22 to STAT_LINE
					store "Could not find &CLI_SNAME" to STAT_MSG
					do status

					store .F. to CLI_SEL
					
				endif
				
				if CLI_SEL
					store 2 to CHOICE_PE
					store "&CLI_SNAME selected" to SEL_NAME
					
				else
					store 1 to CHOICE_PE
					store "No client selected" to SEL_NAME
					
				endif
				
				do CLRSCRN
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 2
				if CLI_SEL
					
					*
					* Open Schedule Directory and initialize variables
					*
					
					store "6" to SELECT_NBR
					store "SCHDDIR" to FILE_NAME
					store "SCHDDIR" to ALIAS_NAME
					store "SCHDDIR" to INDEX_NAME
					store "SCHD_SNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						store 20 to PMT_LINE
						store "Select the marker you wish to print" to PMT_MSG
						do prompt
						
						do GMNAME
						
						@ 20,0
						
						if MRK_SEL
							select MARKER
							
							goto top
							
							store CLI_NBR + MRK_SNAME to SRCH_MRK
							
							set exact on
							
							seek SRCH_MRK
							
							set exact off
							
							if .not. (bof() .or. eof())
								do SELMRK
								
							else
								store 22 to STAT_LINE
								store "&MRK_SNAME marker not found for &CLI_SNAME" to STAT_MSG
								do status
								
								*
								* Check to see if other markers exist
								*
								
								seek CLI_NBR
								
								if .not. (bof() .or. eof())
									do SELMRK
									
								else
									store .f. to MRK_SEL
									
								endif
								
							endif
							
						endif
						
					endif
					
					if MRK_SEL
						
						if MRK_SEL
							store 2 to CHOICE
							store 3 to PICK_CNT
							store 20 to PICK_LINE
							store "Edit marker" to PICK_1
							store "Don't edit marker" to PICK_2
							store "Delete marker" to PICK_3
							do PICK
							
							do case
							case CHOICE = 1
								store recno() to MRK_SPOT
								
								do EDITMRK
								
								select MARKER
								
							case CHOICE = 2
								do CLRSCRN
								
							case CHOICE = 3
								store 20 to PMT_LINE
								store "Please wait while I delete this entry." to PMT_MSG
								do prompt
								
								store CLI_NBR to MRK_PTR
								
								delete
								
							endcase
							
						endif
						
					endif
					
					do CLRSCRN
					
					store .t. to continue
					store .f. to REFRESH
					
				else
					store 22 to STAT_LINE
					store "You must first select a client" to STAT_MSG
					do status
					
				endif
				
				store 1 to CHOICE_PE
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 3
				store "Removing Clients Without Markers" to L_TAIL
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
					store "Remove clients that do not have any markers" to PMT_MSG
					do prompt
					
					@ 12,17 say "Press Y to begin or press N to cancel ..." get YN picture "X"
					
					read
					
					clear gets
					
					store upper(YN) to YN
					do case
					case YN = "Y"
						store .t. to AGE_CLI
						
					case YN = "N"
						store .f. to AGE_CLI
						
					otherwise
						store " " to YN
						
					endcase
					
				enddo
				
				@ 8,8 say space(65)
				@ 10,8 say space(65)
				@ 12,8 say space(65)
				
				store "Removing Client Without Markers" to L_TAIL
				store "Press Del to CANCEL" to R_TAIL
				do TAIL
				
				if AGE_CLI
					select CLIENT
					goto top
					
					store 8 to PMT_LINE
					store "Removing clients that do not have any markers" to PMT_MSG
					do prompt
					
					store 0 to REC_NBR
					store ltrim(str(REC_NBR)) to REC_CNT
					store reccount() to REC_TOT
					store ltrim(str(REC_TOT)) to REC_TOTCNT
					store 10 to PMT_LINE
					store "Reading client for record number ... " + REC_CNT + " of " + REC_TOTCNT to PMT_MSG
					do prompt
					
					store 0 to REMOVE_NBR
					store ltrim(str(REMOVE_NBR)) to REMOVE_CNT
					
					store 12 to PMT_LINE
					store "Number of clients that have been removed ... &REMOVE_CNT" to PMT_MSG
					do prompt
					
					store 1 to CHOICE
					do while (.not. (bof() .or. eof())) .and. AGE_CLI .and. (CHOICE <> 0)
						store REC_NBR + 1 to REC_NBR
						store ltrim(str(REC_NBR)) to REC_CNT
						
						store 10 to PMT_LINE
						store "Reading client for record number ... " + REC_CNT + " of " + REC_TOTCNT to PMT_MSG
						do prompt
						
						do READCLI
						
						select MARKER
						seek CLI_NBR
						
						if bof() .or. eof()
							store REMOVE_NBR + 1 to REMOVE_NBR
							store ltrim(str(REMOVE_NBR)) to REMOVE_CNT
							
							store 12 to PMT_LINE
							store "Number of clients that have been removed ... " + REMOVE_CNT to PMT_MSG
							do prompt
							
							select CLIENT
							
							delete
							
						else
							select CLIENT
							
						endif
						
						skip
						
						do CHECKKEY
						
					enddo
					
					store 22 to STAT_LINE
					store "Finished removing clients" to STAT_MSG
					do status
					
					store "No marker selected" to SEL_NAME
					
				endif
				
				do CLRSCRN
				
				store 1 to CHOICE_PE
				
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
		select CLIENT
		use
		
	endif
	
endif

return
*: EOF: CLIEDIT.PRG
