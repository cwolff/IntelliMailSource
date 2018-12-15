*:*********************************************************************
*:
*:        Program: FIX.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Thu 29-Sep-88 at 8:22 pm
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : GREET.PRG
*:               : PASSWORD         (procedure in UTILITY.PRG)
*:               : CHNGPASS         (procedure in UTILITY.PRG)
*:               : DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : IMMENU.PRG
*:               : SYSADMIN.PRG
*:
*:           Uses: DOSTXT.SDF     
*:
*:     Documented: 09/04/88 at 16:51               FoxDoc version 1.0
*:*********************************************************************
*                                                                     *
* Fix IntelliMain >>> Database written for Intelligent Correspondance *
*            entry : None                                             *
*            exit : None                                              *
*                                                                     *
***********************************************************************

clear all

set echo off
set status off
set scoreboard off
set heading off
set safety off
set talk off
set bell off
set delimiter on
set delimiters to "[]"
set century on
set date american
set deleted on
set exact off

clear

store .T. to COLOR_SCRN

store "Fixing Marker File" to hEAD
store dtoc(date()) to L_TAIL
store "Do not disturb this process" to R_TAIL
do FRAME

store .F. to FILE_OPEN
store space(5) to LOGON

*
* Marker Variables
*

store space(5) to MRK_NBR
store space(5) to SCHD_PTR
store space(3) to STP_PTR
store space(65) to MDESC
store date() to DINT
store space(5) to LST_SCHD
store space(3) to LST_STP
store space(65) to LST_DESC
store date() to LST_DINT
store space(8) to LTR_TOS
store date() to DATE_TOS
store "F" to SEND_FLG
store space(3) to TRG_CNT
store date() to TRG_DATE
store date() to DATE_SNT
store space(1) to MSTP_TYP
store space(1) to MLTR_TYP
store space(1) to MTRG_TYP
store space(2) to ERR_FLAG
store space(65) to ERR_DESC

*
* Schedule Variables
*

store space(3) to STEP
store space(65) to SDESC
store space(1) to SSTP_TYP
store space(1) to SLTR_TYP
store space(4) to LTR_VAL
store space(2) to SREP_INT
store space(8) to LTR_ID
store space(5) to N_SCHD
store space(3) to N_STEP
store space(5) to DCD_NAME
store space(1) to STRG_TYP
store space(4) to TRG_VAL
store space(5) to T1_SCHD
store space(3) to T1_STEP
store space(5) to T2_SCHD
store space(3) to T2_STEP
store space(3) to DL_VAL
store space(5) to DL_SCHD
store space(3) to DL_STEP

set procedure to FIXUTIL

store "1" to SELECT_NBR
store "MARKER" to FILE_NAME
store "MARKER" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN

	store ltrim(str(reccount())) to MRK_SIZE

	goto top

	do while .not. (bof() .or. eof())
		store 10 to PMT_LINE
		store "Fixing marker record " + ltrim(str(recno())) + " of " + MRK_SIZE to PMT_MSG
		do PROMPT

		do READMRK

		select 2

		store "2" to SELECT_NBR
		store SCHD_PTR + "SCH" to FILE_NAME	
		store SCHD_PTR + "SCH" to ALIAS_NAME
		store SCHD_PTR + "SCH" to INDEX_NAME
		store "S_STEP" to IFLD_NAME
		do OPENFILE
	
		if FILE_OPEN

			seek val(STP_PTR)

			if .not. (bof() .or. eof())
				do READSCH

				store SSTP_TYP to MSTP_TYP
				store SLTR_TYP to MLTR_TYP
				store STRG_TYP to MTRG_TYP

			else
			   store "1" to MSTP_TYP
			   store "1" to MLTR_TYP
			   store "1" to MTRG_TYP

			endif

		else
		   store "1" to MSTP_TYP
		   store "1" to MLTR_TYP
		   store "1" to MTRG_TYP

		endif

		if SEND_FLG = "F"
			store ctod("  /  /    ") to DATE_SNT

		endif


		select 1

		do WRITEMRK

		skip

	enddo

else
	store 22 to STAT_LINE
	store "FATAL ERROR : Could not open MARKER file" to STAT_MSG
	do status
	
	quit
	
endif


clear

quit

*: EOF: IM.PRG
