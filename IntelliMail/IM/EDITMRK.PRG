*:*********************************************************************
*:
*:        Program: EDITMRK.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Wed 28-Sep-88 at 6:45 pm
*:
*:      Called by: ADVMENU.PRG    
*:               : CLIEDIT.PRG    
*:
*:          Calls: PICK             (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PUTMRK           (procedure in UTILITY.PRG)
*:               : GSSTEP.PRG
*:               : READSCH          (procedure in UTILITY.PRG)
*:               : LTRGINT.PRG
*:               : GETMRK.PRG
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* EDITMRK >>> Edit client marker record 							  *
*	       entry : The current marker record has been read			  *
*	       exit : none												  *
*																	  *
***********************************************************************

do case
case val(ERR_FLAG) = 0
	store 2 to CHOICE
	store 2 to PICK_CNT
	store 20 to PICK_LINE
	store "Move marker to another step" to PICK_1
	store "Edit marker" to PICK_2
	do PICK
	
case val(ERR_FLAG) = 99
	store 2 to CHOICE
	store 3 to PICK_CNT
	store 20 to PICK_LINE
	store "Move marker to another step" to PICK_1
	store "Edit marker" to PICK_2
	store "Recover marker" to PICK_3
	do PICK
	
otherwise
	store 2 to CHOICE
	store 3 to PICK_CNT
	store 20 to PICK_LINE
	store "Move marker to another step" to PICK_1
	store "Edit marker" to PICK_2
	store "Clear error" to PICK_3
	do PICK
	
endcase

do case
case CHOICE = 1
	store .t. to sCROLL
	store .t. to DO_AGAIN
	
	store "EDIT " to LST_SCHD
	store space(3) to LST_STP
	store "This entry was moved via the marker editor" + space(23) to LST_DESC
	store date() to LST_DINT
	
	do while DO_AGAIN
		do CLRSCRN
		
		*
		* Open Scehdule Directory and initialize variables
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
				
				*
				* Reselect the marker database
				*
				
				select MARKER
				
				seek MRK_NBR + SCH_SNAME
				
				if .not. (bof() .or. eof())
					if recno() <> MRK_SPOT
						store .t. to DO_AGAIN
						
						store 22 to STAT_LINE
						store "There is a marker pointing to the &SCH_SNAME schedule" to STAT_MSG
						do status
						
						do CLRSCRN
						
						do PUTMRK
						
					else
						store .f. to DO_AGAIN
						
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
							
							store .f. to REC_ADD
							store 1 to REC_NBR
							do GSSTEP
							
							@ 20,0
							
							if STEP_SEL
								do READSCH
								
								store SCH_SNAME to SCHD_PTR
								store SCH_STEP to STP_PTR
								store date() to DINT
								store SCH_SDESC to MDESC
								
								do CLRSCRN
								
								store "NEW  " to LST_SCHD
								store space(3) to LST_STP
								store date() to LST_DINT
								store "This marker was moved via the marker editor" + space(23) to LST_DESC
								store "00" to ERR_FLAG
								store "no errors" + space(56) to ERR_DESC
								store SSTP_TYP to MSTP_TYP
								
								do LTRGINT
								
								store "0  " to TRG_CNT
								store date() to TRG_DATE
								store STRG_TYP to MTRG_TYP
								
								do GETMRK
								
								select MARKER
								
							endif
							
							select SCHD
							use
							
						else
							store 20 to PMT_LINE
							store SCH_SNAME +  " schedule not found, adjusting schedule directory" to PMT_MSG
							do prompt
							
							store "6" to SELECT_NBR
							store "SCHDDIR" to FILE_NAME
							store "SCHDDIR" to ALIAS_NAME
							store "SCHDDIR" to INDEX_NAME
							store "SCHD_SNAME" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								seek SCH_SNAME
								if .not. (eof() .or. bof())
									delete
									pack
									
								endif
								
								select SCHDDIR
								use
								
							endif
							
							@ 20,0
							
						endif
						
						select MARKER
						
					endif
					
				else
					store .f. to DO_AGAIN
					
					store "7" to SELECT_NBR
					store SCH_FNAME to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store SCH_FNDX to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						
						if FILE_OPEN
							store 20 to PMT_LINE
							store "Select a step in the &SCH_SNAME schedule for the marker to point to" to PMT_MSG
							do prompt
							
							store .f. to REC_ADD
							store 1 to REC_NBR
							do GSSTEP
							
							@ 20,0
							
							if STEP_SEL
								do READSCH
								
								store SCH_SNAME to SCHD_PTR
								store SCH_STEP to STP_PTR
								store date() to DINT
								store SCH_SDESC to MDESC
								
								store "NEW  " to LST_SCHD
								store space(3) to LST_STP
								store date() to LST_DINT
								store "This marker is a new entry" + space(39) to LST_DESC
								store "00" to ERR_FLAG
								store "no errors" + space(56) to ERR_DESC
								store SSTP_TYP to MSTP_TYP
								
								do LTRGINT
								
								store "0  " to TRG_CNT
								store date() to TRG_DATE
								store STRG_TYP to MTRG_TYP
								
								do CLRSCRN
								
								do GETMRK
								
								select MARKER
								
							endif
							
						endif
						
						select SCHD
						use
						
					else
						store 20 to PMT_LINE
						store SCH_SNAME  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store SCHDDIR to FILE_NAME
						store SCHDDIR to ALIAS_NAME
						store SCHDDIR to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek SCH_SNAME
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
					select MARKER
					
				endif
				
				goto MRK_SPOT
				
			endif
			
		endif
		
	enddo
	
case CHOICE = 2
	store .t. to sCROLL
	
	do GETMRK
	
	select MARKER
	
case CHOICE = 3
	store .t. to sCROLL
	
	store "00" to ERR_FLAG
	store "no errors" + space(56) to ERR_DESC
	
	do PUTMRK
	
endcase

store .t. to sCROLL
do while sCROLL
	store 1 to CHOICE
	store 3 to PICK_CNT
	store 20 to PICK_LINE
	store "Save changes" to PICK_1
	store "Make changes" to PICK_2
	store "Throw away changes" to PICK_3
	do PICK
	
	do case
	case CHOICE = 1
		store "EDIT " to LST_SCHD
		store "   " to LST_STP
		store "This entry was moved via the marker editor" + space(23) to LST_DESC
		store date() to LST_DINT
		
		do WRITEMRK
		
		store .f. to sCROLL
		
	case CHOICE = 2
		do case
		case val(ERR_FLAG) = 0
			store 2 to CHOICE
			store 2 to PICK_CNT
			store 20 to PICK_LINE
			store "Move marker to another step" to PICK_1
			store "Edit marker" to PICK_2
			do PICK
			
		case val(ERR_FLAG) = 99
			store 2 to CHOICE
			store 3 to PICK_CNT
			store 20 to PICK_LINE
			store "Move marker to another step" to PICK_1
			store "Edit marker" to PICK_2
			store "Recover marker" to PICK_3
			do PICK
			
		otherwise
			store 2 to CHOICE
			store 3 to PICK_CNT
			store 20 to PICK_LINE
			store "Move marker to another step" to PICK_1
			store "Edit marker" to PICK_2
			store "Clear error" to PICK_3
			do PICK
			
		endcase
		
		do case
		case CHOICE = 1
			do CLRSCRN
			
			store .t. to sCROLL
			store .t. to DO_AGAIN
			
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
					
					*
					* Reselect the Marker database
					*
					
					select MARKER
					
					seek MRK_NBR + SCH_SNAME
					
					if .not. (bof() .or. eof())
						if recno() <> MRK_SPOT
							store .t. to DO_AGAIN
							
							store 22 to STAT_LINE
							store "There is a marker pointing to the &SCH_SNAME schedule" to STAT_MSG
							do status
							
							do CLRSCRN
							
							do PUTMRK
							
						else
							store .f. to DO_AGAIN
							
							store "7" to SELECT_NBR
							store SCH_FNAME to FILE_NAME
							store "SCHD" to ALIAS_NAME
							store SCH_FNDX to INDEX_NAME
							store "S_STEP" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								store 20 to PMT_LINE
								store "Select a step in the &SCH_SNAME for the marker to point to" to PMT_MSG
								do prompt
								
								store .f. to REC_ADD
								store 1 to REC_NBR
								do GSSTEP
								
								if SCH_SEL
									do READSCH
									
									store SCH_SNAME to SCHD_PTR
									store SCH_STEP to STP_PTR
									store date() to DINT
									store SCH_SDESC to MDESC
									
									do CLRSCRN
									
									store "NEW  " to LST_SCHD
									store space(3) to LST_STP
									store date() to LST_DINT
									store "This entry was moved via the marker editor" + space(23) to LST_DESC
									store "00" to ERR_FLAG
									store "no errors" + space(56) to ERR_DESC
									store SSTP_TYP to MSTP_TYP
									
									do LTRGINT
									
									store "0  " to TRG_CNT
									store date() to TRG_DATE
									store STRG_TYP to MTRG_TYP
									
									do GETMRK
									
									select MARKER
									
								endif
								
								select SCHD
								use
								
							else
								store 20 to PMT_LINE
								store SCH_SNAME  + " schedule not found, adjusting schedule directory" to PMT_MSG
								do prompt
								
								store "6" to SELECT_NBR
								store SCHDDIR to FILE_NAME
								store SCHDDIR to ALIAS_NAME
								store SCHDDIR to INDEX_NAME
								store "SCHD_SNAME" to IFLD_NAME
								do OPENFILE
								
								if FILE_OPEN
									seek SCH_SNAME
									if .not. (eof() .or. bof())
										delete
										pack
										
									endif
									
									select SCHDDIR
									use
									
								endif
								
								@ 20,0
								
							endif
							
							select MARKER
							
						endif
						
					else
						store .f. to DO_AGAIN
						
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
							
							store .f. to REC_ADD
							store 1 to REC_NBR
							do GSSTEP
							
							if STEP_SEL
								do READSCH
								
								store SCH_SNAME to SCHD_PTR
								store SCH_STEP to STP_PTR
								store date() to DINT
								store SCH_SDESC to MDESC
								
								do CLRSCRN
								
								store "NEW  " to LST_SCHD
								store space(3) to LST_STP
								store date() to LST_DINT
								store "This marker is a new entry" + space(39) to LST_DESC
								store "00" to ERR_FLAG
								store "no errors" + space(56) to ERR_DESC
								store SSTP_TYP to MSTP_TYP
								
								do LTRGINT
								
								store "0  " to TRG_CNT
								store date() to TRG_DATE
								store STRG_TYP to MTRG_TYP
								
								do GETMRK
								
								select MARKER
								
							endif
							
							select SCHD
							use
							
						else
							store 20 to PMT_LINE
							store SCH_SNAME  + " schedule not found, adjusting schedule directory" to PMT_MSG
							do prompt
							
							store "6" to SELECT_NBR
							store SCHDDIR to FILE_NAME
							store SCHDDIR to ALIAS_NAME
							store SCHDDIR to INDEX_NAME
							store "SCHD_SNAME" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								seek SCH_SNAME
								if .not. (eof() .or. bof())
									delete
									pack
									
								endif
								
								select SCHDDIR
								use
								
							endif
							
							@ 20,0
							
						endif
						
						select MARKER
						
					endif
					
					goto MRK_SPOT
					
				endif
				
			endif
			
		case CHOICE = 2
			store .t. to sCROLL
			
			do GETMRK
			
			select MARKER
			
		case CHOICE = 3
			store .t. to sCROLL
			
			store "00" to ERR_FLAG
			store "no errors" + space(56) to ERR_DESC
			
			do PUTMRK
			
		endcase
		
	case CHOICE = 3
		store .f. to sCROLL
		
	endcase
	
enddo

return

*: EOF: EDITMRK.PRG
