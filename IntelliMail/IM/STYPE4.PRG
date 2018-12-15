*:*********************************************************************
*:
*:        Program: STYPE4.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 3:36 pm
*:
*:      Called by: AUTONEXT.PRG   
*:
*:          Calls: PROMPT           (procedure in UTILITY.PRG)
*:               : FINDSCH.PRG
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* STYPE4 >>> Locates next step and updates client marker.  		  	  *
*			entry : pointing to client in client file				  *
*					pointing to client in header file				  *
*					N_SCHD - next schedule							  *
*					N_STEP - next step								  *
*	  		exit : 	ERR_FLAG set                                      *
*																	  *
* Uses N_SCHD and N_STEP to find the next step to update the client's *
* marker with :														  *
*																	  *
*		Schedule and step information :							      *
*           SCHD_PTR = N_SCHD	         							  *
*	  			halt and report if MRK_NBR + SCHD_PTR already exists  *
*	  		STEP_PTR = N_STEP										  *
*																	  *
***********************************************************************

store 10 to PMT_LINE
store "   Schedule &SCHD_PTR step &STP_PTR -> automatic simple step     " to PMT_MSG
do prompt

store ltrim(trim(N_SCHD)) to TMP_SNAME
store N_STEP to TMP_STEP

*
* Check to see if we have a legal schedule name and step
*

if len(TMP_SNAME) <> 5
	store "27" to ERR_FLAG
	store "The next schedule in step &STP_PTR of &SCHD_PTR was not specified" to ERR_MSG
	store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
	
else
	if TMP_SNAME <> "TRMNT"
		store ltrim(str(val(TMP_STEP))) + space(3 - len(ltrim(str(val(TMP_STEP))))) to TMP_STEP
		
		if val(TMP_STEP) < 1
			store "28" to ERR_FLAG
			store "The next step in step &STP_PTR of &SCHD_PTR was not specified" to ERR_MSG
			store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
			
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
		store "Could not find the next schedule (TMP_SNAME)" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
	case .not. STEP_SEL
		store "31" to ERR_FLAG
		store "Could not find the next step (TMP_STEP)in the &TMP_SNAME schedule" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
	endcase
	
	if val(ERR_FLAG) = 0
		
		*
		* Check to see if the new schdule exist in the client's marker file
		*
		
		select MARKER
		
		seek MRK_NBR + TMP_SNAME
		
		if .not. (bof() .or. eof())
			if recno() <> MRK_SPOT
				store "29" to ERR_FLAG
				store "There already is a marker pointing to the &TMP_SNAME schedule" to ERR_MSG
				store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
				
			endif
			
		endif
		
		*
		* Go to the client's old marker record and update
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

return


*: EOF: STYPE4.PRG
