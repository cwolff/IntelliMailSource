*:*********************************************************************
*:
*:        Program: GETSCH.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 8:04 pm
*:
*:      Called by: SCHDADD.PRG    
*:               : EDITSCHD.PRG   
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : PUTSCH.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GDNAME.PRG
*:               : GSNAME.PRG
*:               : GSSTEP.PRG
*:               : GLNAME.PRG
*:
*:     Documented: 09/04/88 at 16:59               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* GETSCH >>> Put the current record to the screen					  *
*	       entry : the current record and variables in schedule       *
*					SCH_NAME										  *
*                   SCH_FNAME                                         *
*                   SCH_FNDX                                          *
*                   SCH_NAME                                          *
*	       exit : Current record variables and place    			  *
*                   SCH_FNAME                                         *
*                   SCH_FNDX                                          *
*                   SCH_NAME                                          *
*																	  *
***********************************************************************

store recno() to TSCH_PLACE
store SCH_SNAME to TSCH_SNAME
store SCH_FNAME to TSCH_FNAME
store SCH_FNDX to TSCH_FNDX

store SEL_NAME to L_TAIL
store "Press   " + chr(27) + " " + chr(26) + " Del to Select ды when Done" to R_TAIL
do TAIL

*
* Make sure the values coming in are valid
*

store STEP to T_STEP
store SDESC to T_SDESC

*
* Check for valid step type
*

if val(SSTP_TYP) = 0 .or. val(SSTP_TYP) > 8
	store "1" to T_SSTP_TYP
	store T_SSTP_TYP to SSTP_TYP
	
else
	store SSTP_TYP to T_SSTP_TYP
	
endif

*
* Check the DL_VAL for length and proper value
*

if val(DL_VAL) < 1 .or. val(DL_VAL) > 999
	store "90 " to DL_VAL
	store DL_VAL to T_DL_VAL
	
else
	store DL_VAL to T_DL_VAL
	
endif

*
* Initialize DL_SCHD and DL_STEP
*

if len(trim(DL_SCHD)) <> 5
	store "TRMNT" to DL_SCHD

endif

store DL_SCHD to T_DL_SCHD
	
if val(DL_STEP) < 1 .or. val(DL_STEP) > 999
	if DL_SCHD <> "TRMNT"
		store "1  " to DL_STEP
	else
		store "   " to DL_STEP
	endif

endif
	
store DL_STEP to T_DL_STEP

*
* Check for valid letter type
*

if val(SLTR_TYP) < 1 .or. val(SLTR_TYP) > 4
	store "1" to T_SLTR_TYP
	store T_SLTR_TYP to SLTR_TYP
	
else
	store SLTR_TYP to T_SLTR_TYP
	
endif

*
* Check the LTR_VAL for length and proper value
* relative to SLTR_TYP
*

if len(LTR_VAL) < 4
	store "    " to T_LTR_TYP
	store T_LTR_TYP to LTR_TYP
	
else
	store LTR_VAL to T_LTR_VAL
	
endif

do case
case val(SLTR_TYP) = 1
	if val(LTR_VAL) <= 0 .or. val(LTR_VAL) > 999
		store "0   " to T_LTR_VAL
		store T_LTR_VAL to LTR_VAL
		
	else
		store LTR_VAL to T_LTR_VAL
		
	endif
	
case val(SLTR_TYP) = 2
	if val(substr(LTR_VAL,1,2)) < 0 .or. val(substr(LTR_VAL,1,2)) > 99
		store "0 " + substr(LTR_VAL,3,2) to LTR_VAL
		
	endif
	
	if val(substr(LTR_VAL,3,2)) < 0 .or. val(substr(LTR_VAL,3,2)) > 12
		store substr(LTR_VAL,1,2) + "0 " to T_LTR_VAL
		store T_LTR_VAL to LTR_VAL
		
	else
		store LTR_VAL to T_LTR_VAL
		
	endif
	
case val(SLTR_TYP) = 3
	if val(LTR_VAL) < 1 .or. val(LTR_VAL) > 12
		store "1   " to T_LTR_VAL
		store T_LTR_VAL to LTR_VAL
		
	else
		store LTR_VAL to T_LTR_VAL
		
	endif
	
case val(SLTR_TYP) = 4
	if val(substr(LTR_VAL,1,2)) < 1 .or. val(substr(LTR_VAL,1,2)) > 12
		store "12" + substr(LTR_VAL,3,2) to LTR_VAL
		
	endif
	
	if val(substr(LTR_VAL,3,2)) < 1 .or. val(substr(LTR_VAL,3,2)) > 28
		store substr(LTR_VAL,1,2) + "28" to T_LTR_VAL
		store T_LTR_VAL to LTR_VAL
		
	else
		store LTR_VAL to T_LTR_VAL
		
	endif
	
endcase

if len(ltrim(trim(LTR_ID))) <> 8
	store "NOLETTER" to LTR_ID
endif

store LTR_ID to T_LTR_ID

if len(ltrim(trim(N_SCHD))) <> 5
	store "TRMNT" to N_SCHD
	
endif

store N_SCHD to T_N_SCHD

if val(N_STEP) < 1 .or. val(N_STEP) > 999
	if N_SCHD <> "TRMNT"
		store "1  " to N_STEP
	else
		store "   " to N_STEP
	endif
	
endif

store N_STEP to T_N_STEP

store DCD_NAME to T_DCD_NAME

*
* Check for valid trigger type
*

if val(STRG_TYP) < 1 .or. val(STRG_TYP) > 5
	store "1" to T_STRG_TYP
	store T_STRG_TYP to STRG_TYP
	
else
	store STRG_TYP to T_STRG_TYP
	
endif

*
* Check the STRG_VAL for length and proper value
* relative to STRG_TYP
*

if len(TRG_VAL) < 4
	store "    " to T_TRG_TYP
	store T_TRG_TYP to TRG_TYP
	
else
	store TRG_VAL to T_TRG_VAL
	
endif

do case
case val(STRG_TYP) = 1
	if val(TRG_VAL) < 1 .or. val(TRG_VAL) > 99
		store "99  " to T_TRG_VAL
		store T_TRG_VAL to TRG_VAL
		
	else
		store TRG_VAL to T_TRG_VAL
		
	endif
	
case val(STRG_TYP) = 2
	if val(TRG_VAL) <= 0 .or. val(TRG_VAL) > 999
		store "0   " to T_TRG_VAL
		store T_TRG_VAL to TRG_VAL
		
	else
		store TRG_VAL to T_TRG_VAL
		
	endif
	
case val(STRG_TYP) = 3
	if val(substr(TRG_VAL,1,2)) < 0 .or. val(substr(TRG_VAL,1,2)) > 99
		store "0 " + substr(TRG_VAL,3,2) to TRG_VAL
		
	endif
	
	if val(substr(TRG_VAL,3,2)) < 0 .or. val(substr(TRG_VAL,3,2)) > 12
		store substr(TRG_VAL,1,2) + "0 " to T_TRG_VAL
		store T_TRG_VAL to TRG_VAL
		
	else
		store TRG_VAL to T_TRG_VAL
		
	endif
	
case val(STRG_TYP) = 4
	if val(TRG_VAL) < 0 .or. val(TRG_VAL) > 12
		store "1   " to T_TRG_VAL
		store T_TRG_VAL to TRG_VAL
		
	else
		store TRG_VAL to T_TRG_VAL
		
	endif
	
case val(STRG_TYP) = 5
	if val(substr(TRG_VAL,1,2)) < 0 .or. val(substr(TRG_VAL,1,2)) > 12
		store "12" + substr(TRG_VAL,3,2) to TRG_VAL
		
	endif
	
	if val(substr(TRG_VAL,3,2)) < 1 .or. val(substr(TRG_VAL,3,2)) > 28
		store substr(TRG_VAL,1,2) + "28" to T_TRG_VAL
		store T_TRG_VAL to TRG_VAL
		
	else
		store TRG_VAL to T_TRG_VAL
		
	endif
	
endcase

if len(ltrim(trim(T1_SCHD))) <> 5
	store "TRMNT" to T1_SCHD
	
endif

store T1_SCHD to T_T1_SCHD

if val(T1_STEP) < 1 .or. val(T1_STEP) > 999
	if T1_SCHD <> "TRMNT"
		store "1  " to T1_STEP
	else
		store "   " to T1_STEP
	endif
	
endif

store T1_STEP to T_T1_STEP

if len(ltrim(trim(T2_SCHD))) <> 5
	store "TRMNT" to T2_SCHD
	
endif

store T2_SCHD to T_T2_SCHD

if val(T2_STEP) < 1 .or. val(T2_STEP) > 999
	if T2_SCHD <> "TRMNT"
		store "1  " to T2_STEP
	else
		store "   " to T2_STEP
	endif

endif

store T2_STEP to T_T2_STEP

store LOGON to T_LOGON

*
* Redisplay the screen to show adjustments
*

do PUTSCH

*
* Position cursor to the first field
*

@ 9,73 say ""

store "STP_TYP" to SELECT_IT
store .t. to MORE

do while MORE
	store inkey() to key
	
	if key <> 0
		do case
			
			*
			* Up Arrow () for UP (Select previous field)
			*
			
		case key = 5 .or. key = 56
			do case
			case SELECT_IT = "STP_TYP"
				do case
				case val(T_SLTR_TYP) = 1
					store "LTR_INC" to SELECT_IT
					
				case val(T_SLTR_TYP) = 2
					store "LTR_AMT" to SELECT_IT
					
				case val(T_SLTR_TYP) = 3
					store "LTR_MDY" to SELECT_IT
					
				case val(T_SLTR_TYP) = 4
					store "LTR_YDY" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "SMP_SCH"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "SMP_STP"
				store "SMP_SCH" to SELECT_IT
				
			case SELECT_IT = "DCD_NME"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_TYP"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_CNT"
				store "TRG_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_INC"
				store "TRG_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_AYR"
				store "TRG_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_AMT"
				store "TRG_AYR" to SELECT_IT
				
			case SELECT_IT = "TRG_MDY"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_YMT"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "TRG_YDY"
				store "TRG_YMT" to SELECT_IT
				
			case SELECT_IT = "TRG_SC1"
				do case
				case val(T_STRG_TYP) = 1
					store "TRG_CNT" to SELECT_IT
					
				case val(T_STRG_TYP) = 2
					store "TRG_INC" to SELECT_IT
					
				case val(T_STRG_TYP) = 3
					store "TRG_AMT" to SELECT_IT
					
				case val(T_STRG_TYP) = 4
					store "TRG_MDY" to SELECT_IT
					
				case val(T_STRG_TYP) = 5
					store "TRG_YDY" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "TRG_ST1"
				store "TRG_SC1" to SELECT_IT
				
			case SELECT_IT = "TRG_SC2"
				store "TRG_ST1" to SELECT_IT
				
			case SELECT_IT = "TRG_ST2"
				store "TRG_SC2" to SELECT_IT
				
			case SELECT_IT = "DL_VAL"
				do case
				case val(T_SSTP_TYP) = 1
					store "SMP_STP" to SELECT_IT
					
				case val(T_SSTP_TYP) = 2
					store "DCD_NME" to SELECT_IT
					
				case val(T_SSTP_TYP) = 3
					store "TRG_ST2" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "DL_SCH"
				store "DL_VAL" to SELECT_IT
				
			case SELECT_IT = "DL_STP"
				store "DL_SCH" to SELECT_IT
				
			case SELECT_IT = "LTR_NME"
				do case
				case val(T_SSTP_TYP) >= 1  .and. val(T_SSTP_TYP) <= 3
					store "DL_STP" to SELECT_IT
					
				case val(T_SSTP_TYP) = 4
					store "SMP_STP" to SELECT_IT
					
				case val(T_SSTP_TYP) = 5
					store "TRG_ST2" to SELECT_IT
					
				case val(T_SSTP_TYP) = 6
					store "SMP_STP" to SELECT_IT
					
				case val(T_SSTP_TYP) = 7
					store "DCD_NME" to SELECT_IT
					
				case val(T_SSTP_TYP) = 8
					store "TRG_ST2" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "LTR_TYP"
				store "LTR_NME" to SELECT_IT
				
			case SELECT_IT = "LTR_INC"
				store "LTR_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_AYR"
				store "LTR_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_AMT"
				store "LTR_AYR" to SELECT_IT
				
			case SELECT_IT = "LTR_MDY"
				store "LTR_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_YMT"
				store "LTR_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_YDY"
				store "LTR_YMT" to SELECT_IT
				
			endcase
			
			*
			* Down Arrow () for DOWN (Select next field)
			*
			
		case key = 24 .or. key = 50
			do case
				
			case SELECT_IT = "STP_TYP"
				do case
				case val(T_SSTP_TYP) = 1
					store "SMP_SCH" to SELECT_IT
					
				case val(T_SSTP_TYP) = 2
					store "DCD_NME" to SELECT_IT
					
				case val(T_SSTP_TYP) = 3
					store "TRG_TYP" to SELECT_IT
					
				case val(T_SSTP_TYP) = 4
					store "SMP_SCH" to SELECT_IT
					
				case val(T_SSTP_TYP) = 5
					store "TRG_TYP" to SELECT_IT
					
				case val(T_SSTP_TYP) = 6
					store "SMP_SCH" to SELECT_IT
					
				case val(T_SSTP_TYP) = 7
					store "DCD_NME" to SELECT_IT
					
				case val(T_SSTP_TYP) = 8
					store "TRG_TYP" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "SMP_SCH"
				store "SMP_STP" to SELECT_IT
				
			case SELECT_IT = "SMP_STP"
				if val(T_SSTP_TYP) = 1
					store "DL_VAL" to SELECT_IT
				else
					store "LTR_NME" to SELECT_IT
				endif
				
			case SELECT_IT = "DCD_NME"
				if val(T_SSTP_TYP) = 2
					store "DL_VAL" to SELECT_IT
				else
					store "LTR_NME" to SELECT_IT
				endif
				
			case SELECT_IT = "TRG_TYP"
				do case
				case val(T_STRG_TYP) = 1
					store "TRG_CNT" to SELECT_IT
					
				case val(T_STRG_TYP) = 2
					store "TRG_INC" to SELECT_IT
					
				case val(T_STRG_TYP) = 3
					store "TRG_AYR" to SELECT_IT
					
				case val(T_STRG_TYP) = 4
					store "TRG_MDY" to SELECT_IT
					
				case val(T_STRG_TYP) = 5
					store "TRG_YMT" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "TRG_CNT"
				store "TRG_SC1" to SELECT_IT
				
			case SELECT_IT = "TRG_INC"
				store "TRG_SC1" to SELECT_IT
				
			case SELECT_IT = "TRG_AYR"
				store "TRG_AMT" to SELECT_IT
				
			case SELECT_IT = "TRG_AMT"
				store "TRG_SC1" to SELECT_IT
				
			case SELECT_IT = "TRG_MDY"
				store "TRG_SC1" to SELECT_IT
				
			case SELECT_IT = "TRG_YMT"
				store "TRG_YDY" to SELECT_IT
				
			case SELECT_IT = "TRG_YDY"
				store "TRG_SC1" to SELECT_IT
				
			case SELECT_IT = "TRG_SC1"
				store "TRG_ST1" to SELECT_IT
				
			case SELECT_IT = "TRG_ST1"
				store "TRG_SC2" to SELECT_IT
				
			case SELECT_IT = "TRG_SC2"
				store "TRG_ST2" to SELECT_IT
				
			case SELECT_IT = "TRG_ST2"
				if val(T_SSTP_TYP) = 3
					store "DL_VAL" to SELECT_IT
				else
					store "LTR_NME" to SELECT_IT
				endif
				
			case SELECT_IT = "DL_VAL"
				store "DL_SCH" to SELECT_IT
				
			case SELECT_IT = "DL_SCH"
				store "DL_STP" to SELECT_IT
				
			case SELECT_IT = "DL_STP"
				store "LTR_NME" to SELECT_IT
				
			case SELECT_IT = "LTR_NME"
				if val(T_SSTP_TYP) > 0 .and. val(T_SSTP_TYP) < 6
					store "LTR_TYP" to SELECT_IT
					
				else
					store "STP_TYP" to SELECT_IT
					
				endif
				
			case SELECT_IT = "LTR_TYP"
				do case
				case val(T_SLTR_TYP) = 1
					store "LTR_INC" to SELECT_IT
					
				case val(T_SLTR_TYP) = 2
					store "LTR_AYR" to SELECT_IT
					
				case val(T_SLTR_TYP) = 3
					store "LTR_MDY" to SELECT_IT
					
				case val(T_SLTR_TYP) = 4
					store "LTR_YMT" to SELECT_IT
					
				endcase
				
			case SELECT_IT = "LTR_INC"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_AYR"
				store "LTR_AMT" to SELECT_IT
				
			case SELECT_IT = "LTR_AMT"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_MDY"
				store "STP_TYP" to SELECT_IT
				
			case SELECT_IT = "LTR_YMT"
				store "LTR_YDY" to SELECT_IT
				
			case SELECT_IT = "LTR_YDY"
				store "STP_TYP" to SELECT_IT
				
			endcase
			
			
			*
			* Left Arrow (<-) to (Select previous value)
			*
			
		case key = 19 .or. key = 52
			do case
			case SELECT_IT = "STP_TYP"
				if val(T_SSTP_TYP) > 1
					store ltrim(str((val(T_SSTP_TYP) - 1),3)) to T_SSTP_TYP
					store T_SSTP_TYP + space(3 - len(T_SSTP_TYP)) to T_SSTP_TYP
					
				else
					store "8  " to T_SSTP_TYP
					
				endif
				
			case SELECT_IT = "SMP_SCH"
				store "TRMNT" to T_N_SCHD
				store "   " to T_N_STEP
				
			case SELECT_IT = "SMP_STP"
				if T_N_SCHD <> "TRMNT"
					if val(T_N_STEP) > 1
						store ltrim(str(val(T_N_STEP) - 1,3)) to TMP
						store TMP + space(3 - len(TMP)) to T_N_STEP
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "DCD_NME"
				store "8" to SELECT_NBR
				store "DCDDIR" to FILE_NAME
				store "DCDDIR" to ALIAS_NAME
				store "DCDDIR" to INDEX_NAME
				store "D_DCD_NBR" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a menu" to PMT_MSG
					do prompt
					
					seek T_DCD_NAME
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GDNAME
					
					@ 20,0
					
					if DCD_SEL
						store DCD_NAME to T_DCD_NAME
						
						select DCDDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
			case SELECT_IT = "TRG_TYP"
				if val(T_STRG_TYP) > 1
					store ltrim(str((val(T_STRG_TYP) - 1),3)) to T_STRG_TYP
					
				else
					store "5" to T_STRG_TYP
					
				endif
				
			case SELECT_IT = "TRG_CNT"
				if val(substr(T_TRG_VAL,1,2)) > 1
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) - 1),2)) to T_TRG_VAL
					store T_TRG_VAL + space(4 - len(T_TRG_VAL)) to T_TRG_VAL
					
				else
					store "99  " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_INC"
				if val(substr(T_TRG_VAL,1,3)) > 0
					store ltrim(str((val(substr(T_TRG_VAL,1,3)) - 1),3)) to T_TRG_VAL
					store T_TRG_VAL + space(4 - len(T_TRG_VAL))  to T_TRG_VAL
					
				else
					store "999 " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_AYR"
				if val(substr(T_TRG_VAL,1,2)) > 0
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) - 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				else
					store "99" + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_AMT"
				if val(substr(T_TRG_VAL,3,2)) > 0
					store ltrim(str((val(substr(T_TRG_VAL,3,2)) - 1),2)) to TMP
					store substr(T_TRG_VAL,1,2) + TMP + space(2 - len(TMP)) to T_TRG_VAL
					
				else
					store substr(T_TRG_VAL,1,2) + "12" to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_MDY"
				if val(substr(T_TRG_VAL,1,2)) > 1
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) - 1),2)) to T_TRG_VAL
					store T_TRG_VAL + space(4 - len(T_TRG_VAL))  to T_TRG_VAL
					
				else
					store "28  " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_YMT"
				if val(substr(T_TRG_VAL,1,2)) > 1
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) - 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				else
					store "12" + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_YDY"
				if val(substr(T_TRG_VAL,3,2)) > 1
					store ltrim(str((val(substr(T_TRG_VAL,3,2)) - 1),2)) to TMP
					store substr(T_TRG_VAL,1,2) + TMP + space(2 - len(TMP)) to T_TRG_VAL
					
				else
					store substr(T_TRG_VAL,1,2) + "28" to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_SC1"
				store "TRMNT" to T_T1_SCHD
				store "   " to T_T1_STEP
				
			case SELECT_IT = "TRG_ST1"
				if T_T1_SCHD <> "TRMNT"
					if val(T_T1_STEP) > 1
						store ltrim(str(val(T_T1_STEP) - 1,3)) to TMP
						store TMP + space(3 - len(TMP)) to T_T1_STEP
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "TRG_SC2"
				store "TRMNT" to T_T2_SCHD
				store "   " to T_T2_STEP
				
			case SELECT_IT = "TRG_ST2"
				if T_T2_SCHD <> "TRMNT"
					if val(T_T2_STEP) > 1
						store ltrim(str(val(T_T2_STEP) - 1,3)) to TMP
						store TMP + space(3 - len(TMP)) to T_T2_STEP
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "DL_VAL"
				if val(substr(T_DL_VAL,1,3)) > 1
					store ltrim(str((val(substr(T_DL_VAL,1,3)) - 1),3)) to T_DL_VAL
					store T_DL_VAL + space(3 - len(T_DL_VAL))  to T_DL_VAL
					
				else
					store "999" to T_DL_VAL
					
				endif
				
			case SELECT_IT = "DL_SCH"
				store "TRMNT" to T_DL_SCHD
				store "   " to T_DL_STEP
				
			case SELECT_IT = "DL_STP"
				if T_DL_SCHD <> "TRMNT"
					if val(T_DL_STEP) > 1
						store ltrim(str(val(T_DL_STEP) - 1,3)) to TMP
						store TMP + space(2 - len(TMP)) to T_DL_STEP
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "LTR_NME"
				store "NOLETTER" to T_LTR_ID
				
			case SELECT_IT = "LTR_TYP"
				if val(T_SLTR_TYP) > 1
					store ltrim(str((val(T_SLTR_TYP) - 1),3)) to T_SLTR_TYP
					
				else
					store "4" to T_SLTR_TYP
					
				endif
				
			case SELECT_IT = "LTR_INC"
				if val(substr(T_LTR_VAL,1,3)) > 0
					store ltrim(str((val(substr(T_LTR_VAL,1,3)) - 1),3)) to T_LTR_VAL
					store T_LTR_VAL + space(4 - len(T_LTR_VAL))  to T_LTR_VAL
					
				else
					store "999 " to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_AYR"
				if val(substr(T_LTR_VAL,1,2)) > 0
					store ltrim(str((val(substr(T_LTR_VAL,1,2)) - 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				else
					store "99" + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_AMT"
				if val(substr(T_LTR_VAL,3,2)) > 0
					store ltrim(str((val(substr(T_LTR_VAL,3,2)) - 1),2)) to TMP
					store substr(T_LTR_VAL,1,2) + TMP + space(2 - len(TMP)) to T_LTR_VAL
					
				else
					store substr(T_LTR_VAL,1,2) + "12" to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_MDY"
				if val(substr(T_LTR_VAL,1,2)) > 1
					store ltrim(str((val(substr(T_LTR_VAL,1,2)) - 1),2)) to T_LTR_VAL
					store T_LTR_VAL + space(4 - len(T_LTR_VAL))  to T_LTR_VAL
					
				else
					store "28  " to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_YMT"
				if val(substr(T_LTR_VAL,1,2)) > 1
					store ltrim(str((val(substr(T_LTR_VAL,1,2)) - 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				else
					store "12" + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_YDY"
				if val(substr(T_LTR_VAL,3,2)) > 1
					store ltrim(str((val(substr(T_LTR_VAL,3,2)) - 1),2)) to TMP
					store substr(T_LTR_VAL,1,2) + TMP + space(2 - len(TMP)) to T_LTR_VAL
					
				else
					store substr(T_LTR_VAL,1,2) + "28" to T_LTR_VAL
					
				endif
				
			endcase
			
			*
			* Right Arrow (->) to (Select next value)
			*
			
		case key = 4 .or. key = 54
			
			do case
			case SELECT_IT = "STP_TYP"
				if val(T_SSTP_TYP) < 8
					store ltrim(str((val(T_SSTP_TYP) + 1),3)) to T_SSTP_TYP
					store T_SSTP_TYP + space(3 - len(T_SSTP_TYP)) to T_SSTP_TYP
					
				else
					store "1  " to T_SSTP_TYP
					
				endif
				
			case SELECT_IT = "SMP_SCH"
				if T_N_SCHD = "TRMNT"
					store "1  " to T_N_STEP
					
				endif
				
				store "6" to SELECT_NBR
				store "SCHDDIR" to FILE_NAME
				store "SCHDDIR" to ALIAS_NAME
				store "SCHDDIR" to INDEX_NAME
				store "SCHD_SNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a schedule" to PMT_MSG
					do prompt
					
					seek T_N_SCHD
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GSNAME
					
					@ 20,0
					
					if SCH_SEL
						store SCH_SNAME to T_N_SCHD
						
						select SCHDDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
			case SELECT_IT = "SMP_STP"
				if T_N_SCHD <> "TRMNT"
					store "7" to SELECT_NBR
					store T_N_SCHD + "SCH" to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store T_N_SCHD + "SCH" to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						save screen to GS_SCREEN
						
						store 20 to PMT_LINE
						store "Selecting a step in the &T_N_SCHD schedule" to PMT_MSG
						do prompt
						
						store T_N_SCHD to SCH_SNAME
						store val(T_N_STEP) to REC_NBR
						
						store .t. to REC_ADD
						
						do GSSTEP
						
						@ 20,0
						
						if STEP_SEL
							store SCH_STEP to T_N_STEP
							
							select SCHD
							use
							
						endif
						
						restore screen from GS_SCREEN
						
					else
						store 20 to PMT_LINE
						store T_N_SCHD  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek T_N_SCHD
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "DCD_NME"
				store "8" to SELECT_NBR
				store "DCDDIR" to FILE_NAME
				store "DCDDIR" to ALIAS_NAME
				store "DCDDIR" to INDEX_NAME
				store "D_DCD_NBR" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a menu" to PMT_MSG
					do prompt
					
					seek T_DCD_NAME
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GDNAME
					
					@ 20,0
					
					if DCD_SEL
						store DCD_NAME to T_DCD_NAME
						
						select DCDDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
			case SELECT_IT = "TRG_TYP"
				if val(T_STRG_TYP) < 5
					store ltrim(str((val(T_STRG_TYP) + 1),3)) to T_STRG_TYP
					
				else
					store "1" to T_STRG_TYP
					
				endif
				
			case SELECT_IT = "TRG_CNT"
				if val(substr(T_TRG_VAL,1,2)) < 99
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) + 1),2)) to T_TRG_VAL
					store T_TRG_VAL + space(4 - len(T_TRG_VAL)) to T_TRG_VAL
					
				else
					store "1   " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_INC"
				if val(substr(T_TRG_VAL,1,3)) < 999
					store ltrim(str((val(substr(T_TRG_VAL,1,3)) + 1),3)) to T_TRG_VAL
					store T_TRG_VAL + space(4 - len(T_TRG_VAL))  to T_TRG_VAL
					
				else
					store "0   " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_AYR"
				if val(substr(T_TRG_VAL,1,2)) < 99
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) + 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				else
					store "0 " + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_AMT"
				if val(substr(T_TRG_VAL,3,2)) < 12
					store ltrim(str((val(substr(T_TRG_VAL,3,2)) + 1),2)) to TMP
					store substr(T_TRG_VAL,1,2) + TMP + space(2 - len(TMP)) to T_TRG_VAL
					
				else
					store substr(T_TRG_VAL,1,2) + "0 " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_MDY"
				if val(substr(T_TRG_VAL,1,2)) < 28
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) + 1),2)) to T_TRG_VAL
					store T_TRG_VAL + space(4 - len(T_TRG_VAL))  to T_TRG_VAL
					
				else
					store "1   " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_YMT"
				if val(substr(T_TRG_VAL,1,2)) < 12
					store ltrim(str((val(substr(T_TRG_VAL,1,2)) + 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				else
					store "1 " + substr(T_TRG_VAL,3,2) to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_YDY"
				if val(substr(T_TRG_VAL,3,2)) < 28
					store ltrim(str((val(substr(T_TRG_VAL,3,2)) + 1),2)) to TMP
					store substr(T_TRG_VAL,1,2) + TMP + space(2 - len(TMP)) to T_TRG_VAL
					
				else
					store substr(T_TRG_VAL,1,2) + "1 " to T_TRG_VAL
					
				endif
				
			case SELECT_IT = "TRG_SC1"
				if T_T1_SCHD = "TRMNT"
					store "1  " to T_T1_STEP
					
				endif
				
				store "6" to SELECT_NBR
				store "SCHDDIR" to FILE_NAME
				store "SCHDDIR" to ALIAS_NAME
				store "SCHDDIR" to INDEX_NAME
				store "SCHD_SNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a schedule" to PMT_MSG
					do prompt
					
					seek T_T1_SCHD
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GSNAME
					
					@ 20,0
					
					if SCH_SEL
						store SCH_SNAME to T_T1_SCHD
						
						select SCHDDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
			case SELECT_IT = "TRG_ST1"
				if T_T1_SCHD <> "TRMNT"
					store "7" to SELECT_NBR
					store T_T1_SCHD + "SCH" to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store T_T1_SCHD + "SCH" to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						save screen to GS_SCREEN
						
						store 20 to PMT_LINE
						store "Selecting a step in the &T_T1_SCHD schedule" to PMT_MSG
						do prompt
						
						store T_T1_SCHD to SCH_SNAME
						store val(T_T1_STEP) to REC_NBR
						
						store .t. to REC_ADD
						
						do GSSTEP
						
						@ 20,0
						
						if STEP_SEL
							store SCH_STEP to T_T1_STEP
							
							select SCHD
							use
							
						endif
						
						restore screen from GS_SCREEN
						
					else
						store 20 to PMT_LINE
						store T_T1_SCHD  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek T_T1_SCHD
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "TRG_SC2"
				if T_T2_SCHD = "TRMNT"
					store "1  " to T_T2_STEP
					
				endif
				
				store "6" to SELECT_NBR
				store "SCHDDIR" to FILE_NAME
				store "SCHDDIR" to ALIAS_NAME
				store "SCHDDIR" to INDEX_NAME
				store "SCHD_SNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a schedule" to PMT_MSG
					do prompt
					
					seek T_T2_SCHD
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GSNAME
					
					@ 20,0
					
					if SCH_SEL
						store SCH_SNAME to T_T2_SCHD
						
						select SCHDDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
			case SELECT_IT = "TRG_ST2"
				if T_T2_SCHD <> "TRMNT"
					store "7" to SELECT_NBR
					store T_T2_SCHD + "SCH" to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store T_T2_SCHD + "SCH" to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						save screen to GS_SCREEN
						
						store 20 to PMT_LINE
						store "Selecting a step in the &T_T2_SCHD schedule" to PMT_MSG
						do prompt
						
						store T_T2_SCHD to SCH_SNAME
						store val(T_T2_STEP) to REC_NBR
						
						store .t. to REC_ADD
						
						do GSSTEP
						
						@ 20,0
						
						if STEP_SEL
							store SCH_STEP to T_T2_STEP
							
							select SCHD
							use
							
						endif
						
						restore screen from GS_SCREEN
						
					else
						store 20 to PMT_LINE
						store T_T2_SCHD  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek T_T2_SCHD
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "DL_VAL"
				if val(substr(T_DL_VAL,1,3)) < 999
					store ltrim(str((val(substr(T_DL_VAL,1,3)) + 1),3)) to T_DL_VAL
					store T_DL_VAL + space(3 - len(T_DL_VAL))  to T_DL_VAL
					
				else
					store "1  " to T_DL_VAL
					
				endif
				
			case SELECT_IT = "DL_SCH"
				if T_DL_SCHD = "TRMNT"
					store "1  " to T_DL_STEP
					
				endif
				
				store "6" to SELECT_NBR
				store "SCHDDIR" to FILE_NAME
				store "SCHDDIR" to ALIAS_NAME
				store "SCHDDIR" to INDEX_NAME
				store "SCHD_SNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a schedule" to PMT_MSG
					do prompt
					
					seek T_DL_SCHD
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GSNAME
					
					@ 20,0
					
					if SCH_SEL
						store SCH_SNAME to T_DL_SCHD
						
						select SCHDDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
				
			case SELECT_IT = "DL_STP"
				if T_DL_SCHD <> "TRMNT"
					store "7" to SELECT_NBR
					store T_DL_SCHD + "SCH" to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store T_DL_SCHD + "SCH" to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						save screen to GS_SCREEN
						
						store 20 to PMT_LINE
						store "Selecting a step in the &T_DL_SCHD schedule" to PMT_MSG
						do prompt
						
						store T_DL_SCHD to SCH_SNAME
						store val(T_DL_STEP) to REC_NBR
						
						store .t. to REC_ADD
						
						do GSSTEP
						
						@ 20,0
						
						if STEP_SEL
							store SCH_STEP to T_DL_STEP
							
							select SCHD
							use
							
						endif
						
						restore screen from GS_SCREEN
						
					else
						store 20 to PMT_LINE
						store T_DL_SCHD  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek T_DL_SCHD
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The choice is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			case SELECT_IT = "LTR_NME"
				store "10" to SELECT_NBR
				store "LTRDIR" to FILE_NAME
				store "LTRDIR" to ALIAS_NAME
				store "LTRDIR" to INDEX_NAME
				store "LTR_LNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GS_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a letter" to PMT_MSG
					do prompt
					
					seek T_LTR_ID
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .t. to REC_ADD
					
					do GLNAME
					
					@ 20,0
					
					if LTR_SEL
						store LTR_NAME to T_LTR_ID
						
						select LTRDIR
						use
						
					endif
					
					restore screen from GS_SCREEN
					
				endif
				
			case SELECT_IT = "LTR_TYP"
				if val(T_SLTR_TYP) < 4
					store ltrim(str((val(T_SLTR_TYP) + 1),3)) to T_SLTR_TYP
					
				else
					store "1" to T_SLTR_TYP
					
				endif
				
			case SELECT_IT = "LTR_INC"
				if val(substr(T_LTR_VAL,1,3)) < 999
					store ltrim(str((val(substr(T_LTR_VAL,1,3)) + 1),3)) to T_LTR_VAL
					store T_LTR_VAL + space(4 - len(T_LTR_VAL))  to T_LTR_VAL
					
				else
					store "0   " to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_AYR"
				if val(substr(T_LTR_VAL,1,2)) < 99
					store ltrim(str((val(substr(T_LTR_VAL,1,2)) + 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				else
					store "0 " + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_AMT"
				if val(substr(T_LTR_VAL,3,2)) < 12
					store ltrim(str((val(substr(T_LTR_VAL,3,2)) + 1),2)) to TMP
					store substr(T_LTR_VAL,1,2) + TMP + space(2 - len(TMP)) to T_LTR_VAL
					
				else
					store substr(T_LTR_VAL,1,2) + "0 " to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_MDY"
				if val(substr(T_LTR_VAL,1,2)) < 28
					store ltrim(str((val(substr(T_LTR_VAL,1,2)) + 1),2)) to T_LTR_VAL
					store T_LTR_VAL + space(4 - len(T_LTR_VAL))  to T_LTR_VAL
					
				else
					store "1   " to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_YMT"
				if val(substr(T_LTR_VAL,1,2)) < 12
					store ltrim(str((val(substr(T_LTR_VAL,1,2)) + 1),2)) to TMP
					store TMP + space(2 - len(TMP)) + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				else
					store "1 " + substr(T_LTR_VAL,3,2) to T_LTR_VAL
					
				endif
				
			case SELECT_IT = "LTR_YDY"
				if val(substr(T_LTR_VAL,3,2)) < 28
					store ltrim(str((val(substr(T_LTR_VAL,3,2)) + 1),2)) to TMP
					store substr(T_LTR_VAL,1,2) + TMP + space(2 - len(TMP)) to T_LTR_VAL
					
				else
					store substr(T_LTR_VAL,1,2) + "1 " to T_LTR_VAL
					
				endif
				
			endcase
			
			*
			* RET KEY (дды) when DONE
			*
			
		case key = 13
			
			*
			* Check to see if the schedules and step needed have values
			* along with letter and menu if needed
			*
			
			store .t. to valid
			
			do case
			case val(T_SSTP_TYP) = 1 .or. val(T_SSTP_TYP) = 4 .or. val(T_SSTP_TYP) = 6
				do case
				case len(trim(T_N_SCHD)) <> 5
					store 22 to STAT_LINE
					store "You must specify the simple next schedule" to STAT_MSG
					do status
					
					store "SMP_SCH" to SELECT_IT
					store .f. to valid
					
				case val(T_N_STEP) < 1 .and. T_N_SCHD <> "TRMNT"
					store 22 to STAT_LINE
					store "You must specify the simple next step" to STAT_MSG
					do status
					
					store "SMP_STP" to SELECT_IT
					store .f. to valid
					
				case val(T_SSTP_TYP) <> 6 .and. len(trim(T_LTR_ID)) <> 8
					store 22 to STAT_LINE
					store "You must specify the letter" to STAT_MSG
					do status
					
					store "LTR_NME" to SELECT_IT
					store .f. to valid
					
					
				endcase
				
			case val(T_SSTP_TYP) = 2 .or. val(T_SSTP_TYP) = 7
				do case
				case len(trim(T_DCD_NAME)) <> 5
					store 22 to STAT_LINE
					store "You must specify a menu" to STAT_MSG
					do status
					
					store "DCD_NME" to SELECT_IT
					store .f. to valid
					
				case val(T_SSTP_TYP) <> 7 .and. len(trim(T_LTR_ID)) <> 8
					store 22 to STAT_LINE
					store "You must specify the letter" to STAT_MSG
					do status
					
					store "LTR_NME" to SELECT_IT
					store .f. to valid
					
				endcase
				
			case val(T_SSTP_TYP) = 3 .or. val(T_SSTP_TYP) = 5 .or. val(T_SSTP_TYP) = 8
				do case
				case len(trim(T_T1_SCHD)) <> 5
					store 22 to STAT_LINE
					store "You must specify the < trigger next schedule" to STAT_MSG
					do status
					
					store "TRG_SC1" to SELECT_IT
					store .f. to valid
					
				case val(T_T1_STEP) < 1 .and. T_T1_SCHD <> "TRMNT"
					store 22 to STAT_LINE
					store "You must specify the < trigger next step" to STAT_MSG
					do status
					
					store "TRG_ST1" to SELECT_IT
					store .f. to valid
					
				case len(trim(T_T2_SCHD)) <> 5
					store 22 to STAT_LINE
					store "You must specify the >= trigger next schedule" to STAT_MSG
					do status
					
					store "TRG_SC2" to SELECT_IT
					store .f. to valid
					
				case val(T_T2_STEP) < 1 .and. T_T2_SCHD <> "TRMNT"
					store 22 to STAT_LINE
					store "You must specify the >= trigger next step" to STAT_MSG
					do status
					
					store "TRG_ST2" to SELECT_IT
					store .f. to valid
					
				case val(T_SSTP_TYP) <> 8 .and. len(trim(T_LTR_ID)) <> 8
					store 22 to STAT_LINE
					store "You must specify the letter" to STAT_MSG
					do status
					
					store "LTR_NME" to SELECT_IT
					store .f. to valid
					
				endcase
				
			endcase
			
			if valid
				
				store .f. to MORE
				
				store .t. to SCH_SEL
				
				*
				* Restore current schedule variables that may
				* have been changed during this editing session
				*
				
				store T_DL_VAL to DL_VAL
				store T_DL_SCHD to DL_SCHD
				store T_DL_STEP to DL_STEP
				
				store TSCH_SNAME to SCH_SNAME
				store TSCH_FNAME to SCH_FNAME
				store TSCH_FNDX to SCH_FNDX
				
				store SEL_NAME to L_TAIL
				store "Press ды to Enter" to R_TAIL
				do TAIL
				
				store 20 to PMT_LINE
				store "Edit the description for this step" to PMT_MSG
				do prompt
				
				@ 7,3 say "Desc" get T_SDESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
				
				set confirm on
				
				read
				
				set confirm off
				
				clear gets
				
				@ 20,0
				
				store T_STEP to step
				store T_SDESC to SDESC
				store T_SSTP_TYP to SSTP_TYP
				store T_SLTR_TYP to SLTR_TYP
				store T_LTR_VAL to LTR_VAL
				store T_LTR_ID to LTR_ID
				store T_N_SCHD to N_SCHD
				store T_N_STEP to N_STEP
				store T_DCD_NAME to DCD_NAME
				store T_STRG_TYP to STRG_TYP
				store T_TRG_VAL to TRG_VAL
				store T_T1_SCHD to T1_SCHD
				store T_T1_STEP to T1_STEP
				store T_T2_SCHD to T2_SCHD
				store T_T2_STEP to T2_STEP
				store T_LOGON to LOGON
				
			endif
			
			*
			* Del Key to CANCEL
			*
			
		case key = 7
			
			*
			* Restore current schedule variables that may
			* have been changed during this editing session
			*
			
			store TSCH_SNAME to SCH_SNAME
			store TSCH_FNAME to SCH_FNAME
			store TSCH_FNDX to SCH_FNDX
			
			store .f. to SCH_SEL
			store .f. to MORE
			store .f. to continue
			
		endcase
		
		*
		* Display the appropriate data and point to the correct
		* field when done according to the field the cursor is in
		*
		
		do case
			
		case SELECT_IT = "STP_TYP"
			
			*
			* Calculate trigger type
			*
			
			if val(T_SSTP_TYP) = 3 .or. val(T_SSTP_TYP) = 5 .or. val(T_SSTP_TYP) = 8
				
				@ 10,3 say "Method used to decide step trigger [           ] "
				
				do case
				case val(T_STRG_TYP) = 1
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1   " to T_TRG_VAL
						
					endif
					
					@ 10,52 say "stay in step [  ] times  "
					set color to w+/n,w+/n,n,n
					@ 10,39 say "count      "
					@ 10,66 say substr(T_TRG_VAL,1,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_STRG_TYP) = 2
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1   " to T_TRG_VAL
						
					endif
					
					@ 10,52 say "in [   ] days            "
					set color to w+/n,w+/n,n,n
					@ 10,39 say "incremental"
					@ 10,56 say substr(T_TRG_VAL,1,3)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_STRG_TYP) = 3
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "0 0 " to T_TRG_VAL
						
					endif
					
					@ 10,52 say "of [  ] yrs [  ] mnths   "
					set color to w+/n,w+/n,n,n
					@ 10,39 say "age        "
					@ 10,56 say substr(T_TRG_VAL,1,2)
					@ 10,65 say substr(T_TRG_VAL,3,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_STRG_TYP) = 4
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1   " to T_TRG_VAL
						
					endif
					
					@ 10,52 say "on [  ] of month         "
					set color to w+/n,w+/n,n,n
					@ 10,39 say "monthly    "
					@ 10,56 say substr(T_TRG_VAL,1,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_STRG_TYP) = 5
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1 1 " to T_TRG_VAL
						
					endif
					
					@ 10,52 say "on [  ] month [  ] day   "
					set color to w+/n,w+/n,n,n
					@ 10,39 say "yearly     "
					@ 10,56 say substr(T_TRG_VAL,1,2)
					@ 10,67 say substr(T_TRG_VAL,3,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				otherwise
					set color to w+/n,w+/n,n,n
					@ 10,39 say "invalid tgr"
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
					@ 10,51 say space(24)
					
				endcase
				
				@ 11,3 say "If less then trigger value : goto schedule [     ] step [   ]"
				@ 12,3 say "If greater or equal to trigger value : goto schedule [     ] step [   ]"
				set color to w+/n,w+/n,n,n
				@ 11,47 say T_T1_SCHD
				@ 11,60 say T_T1_STEP
				@ 12,57 say T_T2_SCHD
				@ 12,70 say T_T2_STEP
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			else
				@ 11,3 say space(63)
				@ 12,3 say space(73)
				
			endif
			
			*
			* If manual then display timeout value, schedule and step
			*
			
			if val(T_SSTP_TYP) >= 1 .and. val(T_SSTP_TYP) <= 3
				@ 13,3 say "If not advanced in [   ] days : goto schedule [     ] step [   ]"
				set color to w+/n,w+/n,n,n
				@ 13,23 say T_DL_VAL
				@ 13,50 say T_DL_SCHD
				@ 13,63 say T_DL_STEP
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			else
				@ 13,3 say "                                                                "
				
			endif
			
			*
			* Display letter id and letter type followed by appropriate letter info
			*
			
			@ 15,3 say "Letter to send [        ]"
			set color to w+/n,w+/n,n,n
			@ 15,19 say T_LTR_ID
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
			if val(T_SSTP_TYP) <> 6 .and. val(T_SSTP_TYP) <> 7 .and. val(T_SSTP_TYP) <> 8
				@ 16,3 say "Method used to decide letter trigger [           ] "
				
				do case
				case val(T_SLTR_TYP) = 1
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1   " to T_LTR_VAL
						
					endif
					
					@ 16,54 say "in [   ] days         "
					set color to w+/n,w+/n,n,n
					@ 16,41 say "incremental"
					@ 16,58 say substr(T_LTR_VAL,1,3)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_SLTR_TYP) = 2
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "0 0 " to T_LTR_VAL
						
					endif
					
					@ 16,54 say "of [  ] yrs [  ] mnths"
					set color to w+/n,w+/n,n,n
					@ 16,41 say "age        "
					@ 16,58 say substr(T_LTR_VAL,1,2)
					@ 16,67 say substr(T_LTR_VAL,3,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_SLTR_TYP) = 3
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1   " to T_LTR_VAL
						
					endif
					
					@ 16,54 say "on [  ] of month      "
					set color to w+/n,w+/n,n,n
					@ 16,41 say "monthly    "
					@ 16,58 say substr(T_LTR_VAL,1,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				case val(T_SLTR_TYP) = 4
					if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
						store "1 1 " to T_LTR_VAL
						
					endif
					
					@ 16,54 say "on [  ] month [  ] day"
					set color to w+/n,w+/n,n,n
					@ 16,41 say "yearly     "
					@ 16,58 say substr(T_LTR_VAL,1,2)
					@ 16,69 say substr(T_LTR_VAL,3,2)
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
				otherwise
					set color to w+/n,w+/n,n,n
					@ 16,41 say "invalid tgr"
					
					if COLOR_SCRN
						set color to g/n,w+/n,n,n
					else
						set color to w/n,n/n,n,n
					endif
					
					@ 16,54 say space(24)
					
				endcase
				
			else
				@ 16,3 say "                                                                          "
				
			endif
			
			*
			* Display step type
			*
			
			@ 9,3 say "Method used to decide when to move to the next step [                 ]"
			
			do case
			case val(T_SSTP_TYP) = 1
				@ 10,3 say "manual simple step : goto next schedule [     ] next step [   ]          "
				set color to w+/n,w+/n,n,n
				@ 10,44 say T_N_SCHD
				@ 10,62 say T_N_STEP
				@ 9,56 say "manual simple    "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 2
				@ 10,3 say "manual menu step : using menu named [     ]                              "
				set color to w+/n,w+/n,n,n
				@ 10,40 say T_DCD_NAME
				@ 9,56 say "manual menu      "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 3
				set color to w+/n,w+/n,n,n
				@ 9,56 say "manual trigger   "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 4
				@ 10,3 say "automatic simple step : goto next schedule [     ] step [   ]             "
				set color to w+/n,w+/n,n,n
				@ 10,47 say T_N_SCHD
				@ 10,60 say T_N_STEP
				@ 9,56 say "automatic simple "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 5
				set color to w+/n,w+/n,n,n
				@ 9,56 say "automatic trigger"
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 6
				@ 10,3 say "Chain simple : goto next schedule [     ] next step [   ]                 "
				set color to w+/n,w+/n,n,n
				@ 10,38 say T_N_SCHD
				@ 10,56 say T_N_STEP
				@ 9,56 say "chain simple     "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 7
				@ 10,3 say "Chain menu step : using menu named [     ]                                 "
				set color to w+/n,w+/n,n,n
				@ 10,39 say T_DCD_NAME
				@ 9,56 say "chain menu       "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SSTP_TYP) = 8
				set color to w+/n,w+/n,n,n
				@ 9,56 say "chain trigger    "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			otherwise
				@ 9,56 say "invalid step trg "
				
			endcase
			
		case SELECT_IT = "SMP_SCH"
			set color to w+/n,w+/n,n,n
			
			do case
			case val(T_SSTP_TYP) = 1
				@ 10,62 say T_N_STEP
				@ 10,44 say T_N_SCHD
				
			case val(T_SSTP_TYP) = 4
				@ 10,60 say T_N_STEP
				@ 10,47 say T_N_SCHD
				
			case val(T_SSTP_TYP) = 6
				@ 10,56 say T_N_STEP
				@ 10,38 say T_N_SCHD
				
			endcase
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "SMP_STP"
			set color to w+/n,w+/n,n,n
			
			do case
			case val(T_SSTP_TYP) = 1
				@ 10,62 say T_N_STEP
				
			case val(T_SSTP_TYP) = 4
				@ 10,60 say T_N_STEP
				
			case val(T_SSTP_TYP) = 6
				@ 10,56 say T_N_STEP
				
			endcase
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "DCD_NME"
			set color to w+/n,w+/n,n,n
			
			do case
			case val(T_SSTP_TYP) = 2
				@ 10,40 say T_DCD_NAME
				
			case val(T_SSTP_TYP) = 7
				@ 10,39 say T_DCD_NAME
				
			endcase
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_TYP"
			*
			* Calculate trigger type
			*
			
			@ 10,3 say "Method used to decide step trigger [           ] "
			
			do case
			case val(T_STRG_TYP) = 1
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1   " to T_TRG_VAL
					
				endif
				
				@ 10,52 say "stay in step [  ] times  "
				set color to w+/n,w+/n,n,n
				@ 10,66 say substr(T_TRG_VAL,1,2)
				@ 10,39 say "count      "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_STRG_TYP) = 2
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1    " to T_TRG_VAL
					
				endif
				
				@ 10,52 say "in [   ] days            "
				set color to w+/n,w+/n,n,n
				@ 10,56 say substr(T_TRG_VAL,1,3)
				@ 10,39 say "incremental"
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_STRG_TYP) = 3
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "0 0 " to T_TRG_VAL
					
				endif
				
				@ 10,52 say "of [  ] yrs [  ] mnths   "
				set color to w+/n,w+/n,n,n
				@ 10,56 say substr(T_TRG_VAL,1,2)
				@ 10,65 say substr(T_TRG_VAL,3,2)
				@ 10,39 say "age        "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_STRG_TYP) = 4
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1 " to T_TRG_VAL
					
				endif
				
				@ 10,52 say "on [  ] of month         "
				set color to w+/n,w+/n,n,n
				@ 10,56 say substr(T_TRG_VAL,1,2)
				@ 10,39 say "monthly    "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_STRG_TYP) = 5
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1 1 " to T_TRG_VAL
					
				endif
				
				@ 10,52 say "on [  ] month [  ] day   "
				set color to w+/n,w+/n,n,n
				@ 10,56 say substr(T_TRG_VAL,1,2)
				@ 10,67 say substr(T_TRG_VAL,3,2)
				@ 10,39 say "yearly     "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			otherwise
				set color to w+/n,w+/n,n,n
				@ 16,39 say "invalid tgr"
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
				@ 15,51 say space(24)
				
			endcase
			
		case SELECT_IT = "TRG_CNT"
			set color to w+/n,w+/n,n,n
			@ 10,66 say substr(T_TRG_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_INC"
			set color to w+/n,w+/n,n,n
			@ 10,56 say substr(T_TRG_VAL,1,3)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_AYR"
			set color to w+/n,w+/n,n,n
			@ 10,56 say substr(T_TRG_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_AMT"
			set color to w+/n,w+/n,n,n
			@ 10,65 say substr(T_TRG_VAL,3,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_MDY"
			set color to w+/n,w+/n,n,n
			@ 10,56 say substr(T_TRG_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_YMT"
			set color to w+/n,w+/n,n,n
			@ 10,56 say substr(T_TRG_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_YDY"
			set color to w+/n,w+/n,n,n
			@ 10,67 say substr(T_TRG_VAL,3,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_SC1"
			set color to w+/n,w+/n,n,n
			@ 11,60 say T_T1_STEP
			@ 11,47 say T_T1_SCHD
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_ST1"
			set color to w+/n,w+/n,n,n
			@ 11,60 say T_T1_STEP
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_SC2"
			set color to w+/n,w+/n,n,n
			@ 12,70 say T_T2_STEP
			@ 12,57 say T_T2_SCHD
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "TRG_ST2"
			set color to w+/n,w+/n,n,n
			@ 12,70 say T_T2_STEP
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "DL_VAL"
			*			@ 13,3 say "If not advanced in [   ] days : goto schedule [     ] step [   ]"
			set color to w+/n,w+/n,n,n
			@ 13,23 say T_DL_VAL
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "DL_SCH"
			*			@ 13,3 say "If not advanced in [   ] days : goto schedule [     ] step [   ]"
			set color to w+/n,w+/n,n,n
			@ 13,63 say T_DL_STEP
			@ 13,50 say T_DL_SCHD
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "DL_STP"
			*			@ 13,3 say "If not advanced in [   ] days : goto schedule [     ] step [   ]"
			set color to w+/n,w+/n,n,n
			@ 13,63 say T_DL_STEP
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_NME"
			set color to w+/n,w+/n,n,n
			@ 15,19 say T_LTR_ID
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_TYP"
			@ 16,3 say "Method used to decide letter trigger [           ] "
			
			do case
			case val(T_SLTR_TYP) = 1
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1   " to T_LTR_VAL
					
				endif
				
				@ 16,54 say "in [   ] days         "
				set color to w+/n,w+/n,n,n
				@ 16,58 say substr(T_LTR_VAL,1,3)
				@ 16,41 say "incremental"
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SLTR_TYP) = 2
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "0 0 " to T_LTR_VAL
					
				endif
				
				@ 16,54 say "of [  ] yrs [  ] mnths"
				set color to w+/n,w+/n,n,n
				@ 16,58 say substr(T_LTR_VAL,1,2)
				@ 16,67 say substr(T_LTR_VAL,3,2)
				@ 16,41 say "age        "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SLTR_TYP) = 3
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1 " to T_LTR_VAL
					
				endif
				
				@ 16,54 say "on [  ] of month      "
				set color to w+/n,w+/n,n,n
				@ 16,58 say substr(T_LTR_VAL,1,2)
				@ 16,41 say "monthly    "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			case val(T_SLTR_TYP) = 4
				if key = 4 .or. key = 19 .or. key = 52 .or. key = 54
					store "1 1 " to T_LTR_VAL
					
				endif
				
				@ 16,54 say "on [  ] month [  ] day"
				set color to w+/n,w+/n,n,n
				@ 16,58 say substr(T_LTR_VAL,1,2)
				@ 16,69 say substr(T_LTR_VAL,3,2)
				@ 16,41 say "yearly     "
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
			otherwise
				set color to w+/n,w+/n,n,n
				@ 16,41 say "invalid tgr"
				
				if COLOR_SCRN
					set color to g/n,w+/n,n,n
				else
					set color to w/n,n/n,n,n
				endif
				
				@ 16,54 say space(24)
				
			endcase
			
		case SELECT_IT = "LTR_INC"
			set color to w+/n,w+/n,n,n
			@ 16,58 say substr(T_LTR_VAL,1,3)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_AYR"
			set color to w+/n,w+/n,n,n
			@ 16,58 say substr(T_LTR_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_AMT"
			set color to w+/n,w+/n,n,n
			@ 16,67 say substr(T_LTR_VAL,3,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_MDY"
			set color to w+/n,w+/n,n,n
			@ 16,58 say substr(T_LTR_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_YMT"
			set color to w+/n,w+/n,n,n
			@ 16,58 say substr(T_LTR_VAL,1,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		case SELECT_IT = "LTR_YDY"
			set color to w+/n,w+/n,n,n
			@ 16,69 say substr(T_LTR_VAL,3,2)
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,n/n,n,n
			endif
			
		endcase
		
	endif
	
enddo

*
* Reopen the schedule
*

store "7" to SELECT_NBR
store TSCH_FNAME to FILE_NAME
store "SCHD" to ALIAS_NAME
store TSCH_FNDX to INDEX_NAME
store "S_STEP" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	goto TSCH_PLACE
	
	if (bof() .or. eof())
		store .f. to SCH_SEL
		
	endif
	
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
		find SCH_SNAME
		if .not. (eof() .or. bof())
			delete
			pack
			
		endif
		
		select SCHDDIR
		use
		
		store .f. to SCH_SEL
		
		@ 20,0
		
	endif
	
endif

return

*: EOF: GETSCH.PRG
