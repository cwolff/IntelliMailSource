*:*********************************************************************
*:
*:        Program: CLIPRINT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 1:40 pm
*:
*:      Called by: CLIMENU.PRG    
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GCNAME.PRG
*:               : SELCLI.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : PRINTCLI         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : GMNAME.PRG
*:               : SELMRK.PRG
*:               : PRINTMRK         (procedure in UTILITY.PRG)
*:               : READMRK          (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* CLIPRINT >>> Add allows user to view the data base				  *
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
		store 1 to CHOICE_PP
		
		do while continue
			
			if REFRESH
				store "Printing Clients and Markers" to hEAD
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do FRAME
			else
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do TAIL
			endif
			
			store CHOICE_PP to CHOICE
			store 3 to MENU_CNT
			store "Select" to MENU_1
			store "Select a client" to DESC_1
			store "Print" to MENU_2
			store "Print the markers for the selected client" to DESC_2
			store "Return" to MENU_3
			store "Return to Editing Clients and Markers" to DESC_3
			do menu
			
			store CHOICE to CHOICE_PP
			
			do case
				
			case CHOICE = 1
				store 20 to PMT_LINE
				store "Select marker for printing" to PMT_MSG
				do prompt
				
				do GCNAME
				
				@ 20,0
				
				select CLIENT
				
				goto top
				
				seek SRCH_CLI
				
				if .not. (bof() .or. eof())
					do SELCLI
					
					if CLI_SEL
						store 1 to CHOICE
						store 2 to PICK_CNT
						store 20 to PICK_LINE
						store "Print client" to PICK_1
						store "Don't print client" to PICK_2
						do PICK
						
						if CHOICE = 1
							store 20 to PMT_LINE
							store "Printing client's information." to PMT_MSG
							do prompt
							
							set device to print
							eject
							
							do PRINTCLI
							eject
							set device to screen
							
							@ 20,0
							
						endif
						
					endif
					
				else
					store .f. to CLI_SEL
					
					store 22 to STAT_LINE
					store "Could not find &CLI_SNAME" to STAT_MSG
					do status
					
				endif
				
				do CLRSCRN
				
				if CLI_SEL
					store 2 to CHOICE_PP
					store "&CLI_SNAME selected" to SEL_NAME
					
				else
					store "No client selected" to SEL_NAME
					
				endif
				
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
								* so they can be prompted for a print out (ALL)
								*
								
								seek CLI_NBR
								
								if .not. (bof() .or. eof())
									do SELMRK
									
								else
									store .f. to MRK_SEL
									
								endif
								
							endif
							
						endif
						
						if MRK_SEL
							store 1 to CHOICE
							store 3 to PICK_CNT
							store 20 to PICK_LINE
							store "Print selected marker" to PICK_1
							store "Print all marker(s)" to PICK_2
							store "Don't print marker(s)" to PICK_3
							do PICK
							
							do case
							case CHOICE = 1
								store 20 to PMT_LINE
								store "Printing &MRK_SNAME marker for &CLI_SNAME" to PMT_MSG
								do prompt
								
								set device to print
								
								eject
								
								do PRINTMRK
								
								eject
								
								set device to screen
								
							case CHOICE = 2
								store 20 to PMT_LINE
								store "Printing all marker(s) for &CLI_SNAME" to PMT_MSG
								do prompt
								
								store CLI_NBR to MRK_NBR
								
								seek MRK_NBR
								
								if .not. (eof() .or. bof())
									do READMRK
									
									do while (.not. (eof() .or. bof())) .and. (CLI_NBR = MRK_NBR)
										set device to print
										
										do PRINTMRK
										
										eject
										
										set device to screen
										
										skip
										
										do READMRK
										
									enddo
									
								endif
								
							endcase
							
						endif
						
					endif
					
					do CLRSCRN
					
				else
					store 22 to STAT_LINE
					store "You must first select a client" to STAT_MSG
					do status
					
				endif
				
				store 2 to CHOICE_PP
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 3
				select CLIENT
				use
				select MARKER
				use
				
				store .f. to continue
				
			endcase
			
		enddo
		
	else
		select CLIENT
		use
		
	endif
	
endif

return
*: EOF: CLIPRINT.PRG
