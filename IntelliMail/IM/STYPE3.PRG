*:*********************************************************************
*:
*:        Program: STYPE3.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 10:37 am
*:
*:      Called by: CMDNEXT.PRG    
*:
*:          Calls: PROMPT           (procedure in UTILITY.PRG)
*:               : STRGCALC.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : FINDSCH.PRG
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* STYPE3 >>> Locates next step and updates client schedule.		      *
*			entry : pointing to client in client file				  *
*					pointing to client in marker file				  *
*					pointing to current step in schedule file	      *
*					Perform Limit check first						  *
*	  		exit : 	ERR_FLAG set                               	      *
*																	  *
*	Uses Limit to determine the next schedule and step to update the  *
*   client schedule with :											  *
*																	  *
*		Schedule and step information :							      *
*           SCHD_PTR = T?_SCHD	         							  *
*	  			halt and report if MRK_NBR + SCHD_PTR already exists  *
*	  		STEP_PTR = T?_STEP										  *
*																	  *
***********************************************************************

store 10 to PMT_LINE
store "    Schedule &SCHD_PTR step &STP_PTR -> manual trigger step      " to PMT_MSG
do prompt

do case
case val(MTRG_TYP) = 1
	store str(val(TRG_CNT) + 1,3) to TRG_CNT
	
	store ltrim(trim(TRG_CNT)) to TRG_CNT	
	
	if val(TRG_CNT) >= val(TRG_VAL)
		store "0  " to TRG_CNT
		
		store ltrim(trim(T2_SCHD)) to TMP_SNAME
		store T2_STEP to TMP_STEP
		
	else
		store ltrim(trim(T1_SCHD)) to TMP_SNAME
		store T1_STEP to TMP_STEP
		
	endif
	
case val(MTRG_TYP) > 1 .and. val(MTRG_TYP) < 6
	
	*
	* Need to calculate trigger date value
	*
	
	do STRGCALC
	
	if ((date() - TEST_DATE) >= 0)
		store ltrim(trim(T2_SCHD)) to TMP_SNAME
		store T2_STEP to TMP_STEP
		
	else
		store ltrim(trim(T1_SCHD)) to TMP_SNAME
		store T1_STEP to TMP_STEP
		
	endif
	
otherwise
	store "26" to ERR_FLAG
	store "Invalid step trigger in step &STP_PTR of the &SCHD_PTR schedule" to ERR_MSG
	store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
	
	store 22 to STAT_LINE
	store ERR_MSG to STAT_MSG
	do status
	
endcase

*
* If no errors proceed
*

if val(ERR_FLAG) = 0

	*
	* Check to see if we have a legal schedule name and step
	*

	if len(TMP_SNAME) <> 5
		store "27" to ERR_FLAG
		store "The next schedule in step &STP_PTR of &SCHD_PTR was not specified" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
	
		store 22 to STAT_LINE
		store ERR_MSG to STAT_MSG
		do status
	
	else
		if TMP_SNAME <> "TRMNT"
			store ltrim(str(val(TMP_STEP))) + space(3 - len(ltrim(str(val(TMP_STEP))))) to TMP_STEP
		
			if val(TMP_STEP) < 1
				store "28" to ERR_FLAG
				store "The next step in step &STP_PTR of &SCHD_PTR was not specified" to ERR_MSG
				store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
			
				store 22 to STAT_LINE
				store ERR_MSG to STAT_MSG
				do status
			
			endif
		
		endif
	
	endif

	*
	* Check to see if this client's marker is to be deleted
	*

	if val(ERR_FLAG) = 0 .and. TMP_SNAME = "TRMNT"
		store "99" to ERR_FLAG
		store "This marker is to be removed" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
	
	endif	

	*
	* Final error checking
	*

	if val(ERR_FLAG) = 0
	
		*
		* Check to see if schedule can be found
		* Save old values to restore later
		*

		store SCH_FNAME to LCL_FNAME
		store SCH_FNDX to LCL_FNDX
		store SCH_STEP to LCL_STEP

		store TMP_SNAME + "SCH" to SCH_FNAME
		store TMP_SNAME + "SCH" to SCH_FNDX
		store TMP_STEP to SCH_STEP
		do FINDSCH
		
		store LCL_FNAME to SCH_FNAME
		store LCL_FNDX to SCH_FNDX
		store LCL_STEP to SCH_STEP

		do case
		case .not. SCH_SEL
			store "30" to ERR_FLAG
			store "Could not find the next schedule (&TMP_SNAME)" to ERR_MSG
			store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
			store 22 to STAT_LINE
			store ERR_MSG to STAT_MSG
			do status
		
		case .not. STEP_SEL
			store "31" to ERR_FLAG
			store "Could not find the next step (&TMP_STEP) in the &TMP_SNAME schedule" to ERR_MSG
			store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
			store 22 to STAT_LINE
			store ERR_MSG to STAT_MSG
			do status
		
		endcase
	
		*
		* Check to see if next schedule is in the marker file
		* (next schedule is allowed to point to itself)
		*
	
		if val(ERR_FLAG) = 0
			select MARKER
		
			seek MRK_NBR + TMP_SNAME
		
			if .not. (bof() .or. eof())
				if recno() <> MRK_SPOT
					store "29" to ERR_FLAG
					store "There already is a marker pointing to the &TMP_SNAME schedule" to ERR_MSG
					store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
				
					store 22 to STAT_LINE
					store ERR_MSG to STAT_MSG
					do status
				
				endif
			
			endif
		
			*
			* Finally, set new step number (even if the same number)
			*
		
			seek MRK_NBR + SCHD_PTR
		
			if val(ERR_FLAG) = 0
				store TMP_SNAME to SCHD_PTR
				store TMP_STEP to STP_PTR
				store SDESC to MDESC
				store date() to DINT
				store SSTP_TYP to MSTP_TYP
				store SLTR_TYP to MLTR_TYP
				store STRG_TYP to MTRG_TYP
			
			endif
		
		endif
	
	endif

endif

return

*: EOF: STYPE3.PRG
