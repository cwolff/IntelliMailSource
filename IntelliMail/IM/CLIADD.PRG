*:*********************************************************************
*:
*:        Program: CLIADD.PRG
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
*:               : PICK             (procedure in UTILITY.PRG)
*:               : ADDCLI.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:               : SELMRK.PRG
*:               : GSSTEP.PRG
*:               : READSCH          (procedure in UTILITY.PRG)
*:               : ADDMRK.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : SAVEDATA.PRG
*:
*:           Uses: NEWCLI.DBF     
*:
*:     Documented: 09/04/88 at 16:54               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* CLIADD >>> Add allows user to add new client information			  *
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
	store "3" to SELECT_NBR
	store "NEWCLI" to FILE_NAME
	store "NEWCLI" to ALIAS_NAME
	store "NWPLNFN" to INDEX_NAME
	store "C_LST_N + C_FST_N" to IFLD_NAME
	do OPENFILE
	
	if .not. FILE_OPEN
		select CLIENT
		copy structure to NEWCLI
		
		store "3" to SELECT_NBR
		store "NEWCLI" to FILE_NAME
		store "NEWCLI" to ALIAS_NAME
		store "NWCLINBR" to INDEX_NAME
		store "C_CLI_NBR" to IFLD_NAME
		do OPENFILE
		
		select NEWCLI
		use
		
		store "3" to SELECT_NBR
		store "NEWCLI" to FILE_NAME
		store "NEWCLI" to ALIAS_NAME
		store "NWPLNFN" to INDEX_NAME
		store "C_LST_N + C_FST_N" to IFLD_NAME
		do OPENFILE
		
	endif
	
	store "4" to SELECT_NBR
	store "MARKER" to FILE_NAME
	store "MARKER" to ALIAS_NAME
	store "MARKER" to INDEX_NAME
	store "M_MRK_NBR" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN
		store "5" to SELECT_NBR
		store "NEWMRK" to FILE_NAME
		store "NEWMRK" to ALIAS_NAME
		store "NEWMRK" to INDEX_NAME
		store "M_MRK_NBR" to IFLD_NAME
		do OPENFILE
		
		if .not. FILE_OPEN
			select MARKER
			copy structure to NEWCLI
			
			store "5" to SELECT_NBR
			store "NEWMRK" to FILE_NAME
			store "NEWMRK" to ALIAS_NAME
			store "NEWMRK" to INDEX_NAME
			store "M_MRK_NBR" to IFLD_NAME
			do OPENFILE
			
		endif
		
		store .t. to REFRESH
		store .t. to continue
		
		store .f. to CLI_SEL
		store "No client selected" to SEL_NAME
		store 1 to CHOICE_PA
		
		do while continue
			
			if REFRESH
				store "Adding Clients and Markers" to hEAD
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do FRAME
			else
				store SEL_NAME to L_TAIL
				store "Select Return to STOP" to R_TAIL
				do TAIL
			endif
			
			store CHOICE_PA to CHOICE
			store 3 to MENU_CNT
			store "Select" to MENU_1
			store "Select a client" to DESC_1
			store "Add" to MENU_2
			store "Add markers for the selected client" to DESC_2
			store "Return" to MENU_3
			store "Return to Editing Clients and Markers" to DESC_3
			do menu
			
			store CHOICE to CHOICE_PA
			
			do case
				
			case CHOICE = 1
				do GCNAME
				
				*
				* If a clients is selected then CLI_SEL will equal .T.
				*
				
				select CLIENT
				
				goto top
				
				seek SRCH_CLI
				
				if .not. (bof() .or. eof())
					do SELCLI
					
					if .not. CLI_SEL
						select NEWCLI
						
						goto top
						
						seek SRCH_CLI
						
						if .not. (bof() .or. eof())
							do SELCLI
							
						else
							store .f. to CLI_SEL
							
						endif
						
					endif
					
				else
					select NEWCLI
					
					goto top
					
					seek SRCH_CLI
					
					if .not. (bof() .or. eof())
						do SELCLI
						
					else
						store .f. to CLI_SEL
						
					endif
					
				endif
				
				if .not. CLI_SEL
					if len(trim(CLI_SNAME)) <> 0
						store 1 to CHOICE
						store 2 to PICK_CNT
						store 20 to PICK_LINE
						store "Add an entry for " + CLI_SNAME to PICK_1
						store "Don't add an entry" to PICK_2
						do PICK
						
						if CHOICE = 1
							do ADDCLI
							
						endif
						
					endif
					
				endif
				
				do CLRSCRN
				
				if CLI_SEL
					store 2 to CHOICE_PA
					store "&CLI_SNAME selected" to SEL_NAME
					
				else
					store "No client selected" to SEL_NAME
					
				endif
				
				store .t. to continue
				store .f. to REFRESH
				
			case CHOICE = 2
				if CLI_SEL
					
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
						store "Select a schedule for the marker to point to" to PMT_MSG
						do prompt
						
						store 1 to REC_NBR
						store .f. to REC_ADD
						do GSNAME
						
						@ 20,0
						
						if SCH_SEL
							select MARKER
							
							store CLI_NBR to MRK_NBR
							store MRK_NBR + SCH_SNAME to SRCH_MRK
							
							seek SRCH_MRK
							
							if .not. (bof() .or. eof())
								do SELMRK
								
								if .not. MRK_SEL
									select NEWMRK
									
									goto top
									
									seek SRCH_MRK
									
									if .not. (bof() .or. eof())
										do SELMRK
										
									else
										store .f. to MRK_SEL
										
									endif
									
								endif
								
							else
								select NEWMRK
								
								goto top
								
								seek SRCH_MRK
								
								if .not. (bof() .or. eof())
									do SELMRK
									
								else
									store .f. to MRK_SEL
									
									
								endif
								
							endif
							
						endif
						
					endif
					
					if .not. MRK_SEL
						store 1 to CHOICE
						store 2 to PICK_CNT
						store 20 to PICK_LINE
						store "Add " + SCH_SNAME to PICK_1
						store "Don't add" to PICK_2
						do PICK
						
						if CHOICE = 1
							
							*
							* Open Schedule and initialize variables
							*
							
							store "7" to SELECT_NBR
							store SCH_FNAME to FILE_NAME
							store "SCHD" to ALIAS_NAME
							store SCH_FNDX to INDEX_NAME
							store "S_STEP" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								store 20 to PMT_LINE
								store "Select a step in the &SCH_SNAME schedule for the marker to point to" to PMT_MSG
								do prompt
								
								store 1 to REC_NBR
								do GSSTEP
								
								@ 20,0
								
								if STEP_SEL
									do READSCH
									
									do ADDMRK
									
								endif
								
							endif
							
						endif
						
					endif
					
					do CLRSCRN
					
					store .t. to continue
					store .t. to REFRESH
					
				else
					store 22 to STAT_LINE
					store "You must first select a client" to STAT_MSG
					do status
					
					store .t. to continue
					store .f. to REFRESH
					
				endif
				
				store 1 to CHOICE_PA
				
			case CHOICE = 3
				select CLIENT
				use
				select NEWCLI
				use
				select MARKER
				use
				select NEWMRK
				
				do SAVEDATA
				
				store .f. to continue
				
			endcase
			
		enddo
		
	else
		select CLIENT
		use
		
	endif
	
endif

return
*: EOF: CLIADD.PRG
