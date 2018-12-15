*:*********************************************************************
*:
*:        Program: CLIVIEW.PRG
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
*:               : GCNAME.PRG
*:               : SELCLI.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GMNAME.PRG
*:               : SELMRK.PRG
*:
*:     Documented: 09/04/88 at 16:54               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* CLIVIEW >>> Add allows user to view the data base					  *
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
		store 1 to CHOICE_PV
		
		do while continue
			
			if REFRESH
				store "Showing Clients and Markers" to hEAD
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do FRAME
			else
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do TAIL
			endif
			
			store CHOICE_PV to CHOICE
			store 3 to MENU_CNT
			store "Select" to MENU_1
			store "Select a client" to DESC_1
			store "Show" to MENU_2
			store "Show the markers for the selected client" to DESC_2
			store "Return" to MENU_3
			store "Return to Editing Clients and Markers" to DESC_3
			do menu
			
			store CHOICE to CHOICE_PV
			
			do case
				
			case CHOICE = 1
				do GCNAME
				
				select CLIENT
				
				goto top
				
				seek SRCH_CLI
				
				if .not. (bof() .or. eof())
					do SELCLI
					
				else
					store .f. to CLI_SEL
					
					store 22 to STAT_LINE
					store "Could not find &CLI_SNAME" to STAT_MSG
					do status
					
				endif
				
				do CLRSCRN
				
				if CLI_SEL
					store 2 to CHOICE_PV
					store "&CLI_SNAME selected" to SEL_NAME
					
				else
					store "No client selected" to SEL_NAME
					
				endif
				
				store .t. to continue
				store .t. to REFRESH
				
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
						store "Select the marker you wish to view" to PMT_MSG
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
					
				else
					store 22 to STAT_LINE
					store "You must first select a client" to STAT_MSG
					do status
					
				endif
				
				store 1 to CHOICE_PV
				
				store .t. to continue
				store .t. to REFRESH
				
			case CHOICE = 3
				store .f. to continue
				
			endcase
			
		enddo
		
	else
		select CLIENT
		use
		
	endif
	
endif

return

*: EOF: CLIVIEW.PRG
