*:*********************************************************************
*:
*:        Program: ADDMRK.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 31-Dec-88 at 3:18 pm
*:
*:      Called by: CLIADD.PRG     
*:
*:          Calls: CLRSCRN          (procedure in UTILITY.PRG)
*:               : LTRGINT.PRG
*:               : GETMRK.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PUTMRK           (procedure in UTILITY.PRG)
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:               : GSSTEP.PRG
*:               : READSCH          (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* ADDMRK >>> Check to see if marker is in data base or is to be added *
*	       entry : CLI_NO + SCH_SNAME + SCH_STEP + SCH_SDESC		  *
*	       exit : none												  *
*																	  *
***********************************************************************

select NEWMRK

do CLRSCRN

store USER_LOGON to LOGON
store CLI_NBR to MRK_NBR

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

store ctod("00/00/0000") to DATE_SNT

do GETMRK

select NEWMRK

store .t. to SCROLL
do while SCROLL
	store 1 to CHOICE
	store 3 to PICK_CNT
	store 20 to PICK_LINE
	store "Save marker" to PICK_1
	store "Edit marker" to PICK_2
	store "Throw away marker" to PICK_3
	do PICK
	
	do case
	case CHOICE = 1
		select MARKER
		
		seek MRK_NBR + SCHD_PTR
		
		if .not. (bof() .or. eof())
			store .t. to sCROLL
			
			store 22 to STAT_LINE
			store "There is a marker pointing to the &SCH_SNAME schedule" to STAT_MSG
			do status
			
			do CLRSCRN
			
			do PUTMRK
			
		else
			select NEWMRK
			
			seek MRK_NBR + SCHD_PTR
			
			if .not. (bof() .or. eof())
				store 22 to STAT_LINE
				store "There is a marker pointing to the &SCH_SNAME schedule" to STAT_MSG
				do status
				
				do CLRSCRN
				
				do PUTMRK
				
			else
				store "NEW  " to LST_SCHD
				store "   " to LST_STP
				store "This marker is a new entry" + space(39) to STP_DESC
				store date() to LST_DINT
				
				append blank
				do WRITEMRK
				
				store .f. to SCROLL
				
			endif
			
		endif
		
		select NEWMRK
		
	case CHOICE = 2
		store 1 to CHOICE
		store 2 to PICK_CNT
		store 20 to PICK_LINE
		store "Move marker to another step" to PICK_1
		store "Edit marker" to PICK_2
		do PICK
		
		do case
		case CHOICE = 1
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
					
					select MARKER
					
					seek CLI_NBR + SCH_SNAME
					
					if .not. (bof() .or. eof())
						store .t. to DO_AGAIN
						
						store 22 to STAT_LINE
						store "There is a marker pointing to the &SCH_SNAME schedule" to STAT_MSG
						do status
						
						do CLRSCRN
						
						do PUTMRK
						
					else
						select NEWMRK
						
						seek CLI_NBR + SCH_SNAME
						
						if .not. (bof() .or. eof())
							store 22 to STAT_LINE
							store "There is a marker pointing to the &SCH_SNAME schedule" to STAT_MSG
							do status
							
							do CLRSCRN
							
							do PUTMRK
							
						else
							
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
									
									select NEWMRK
									
								endif
								
							endif
							
						endif
						
					endif
					
				endif
				
			endif
			
		case CHOICE = 2
			store .t. to sCROLL
			
			do CLRSCRN
			
			do GETMRK
			
			select NEWMRK
			
		endcase
		
	case CHOICE = 3
		store .f. to SCROLL
		
	endcase
	
enddo

return
*: EOF: ADDMRK.PRG
