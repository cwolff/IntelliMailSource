*:*********************************************************************
*:
*:        Program: IM.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 12-Mar-89 at 4:49 am
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
* IntelliMain >>> Database written for Intelligent Correspondance     *
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

*
* Global names
*

store "This work is dedicated to the Sacred Heart of Jesus and the Imaculate Heart of Mary" to DEDICATION
store "\[" to GLBL_DATA
store "\[date]" to G_TRGT_1

public L_TAIL
store .f. to FILE_OPEN
store "?????" to SEL_NBR
store space(40) to SEL_NAME
store 0 to REC_NBR
store .f. to REC_ADD
store date() to TEST_DATE

*
* Initialize all Variables
*
* Client Variables
*

store "\(" to CLI_DATA
store "\(cli_birth)" to C_TRGT_1
store "\(cli_lbl_code)" to C_TRGT_2
store "\(cli_title)" to C_TRGT_3
store "\(cli_fst_name)" to C_TRGT_4
store "\(cli_lst_name)" to C_TRGT_5
store "\(cli_co_title)" to C_TRGT_6
store "\(cli_co_name)" to C_TRGT_7
store "\(cli_addr_1)" to C_TRGT_8
store "\(cli_addr_2)" to C_TRGT_9
store "\(cli_city)" to C_TRGT_10
store "\(cli_state)" to C_TRGT_11
store "\(cli_zip)" to C_TRGT_12
store "\(cli_phone)" to C_TRGT_13
store "\(cli_comments)" to C_TRGT_14

store space(5) to CLI_NBR
store space(35) to LBL_CODE
store date() to BIRTH
store space(25) to TITLE
store space(20) to LST_N
store space(15) to FST_N
store space(1) to M_I
store space(25) to CO_TITLE
store space(35) to CO_NAME
store space(35) to ADDR_1
store space(35) to ADDR_2
store space(20) to CITY
store space(2) to STATE
store space(9) to ZIP
store space(10) to PHONE
store space(25) to COMMENTS
store space(5) to LOGON

*
* Returned from GCNAME
*

store space(15) to FST_NAME
store space(20) to LST_NAME
store space(35) to SRCH_CLI

*
* Returned from SELCLI
*

store (5) to CLI_NBR
store space(35) to CLI_SNAME
store .f. to CLI_SEL

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
* Passed to SELMRK and used to seek on marker file
*

store space(11) to SRCH_MRK

*
* Returned from GMNAME
*

store space(8) to MRK_SNAME
store space(8) to MRK_FNAME
store space(8) to MRK_FNDX

*
* Returned from GMSTEP
*

store space(3) to MRK_STEP
store space(65) to MRK_DESC

*
* Returned from GMNAME, GMSTEP, SELMRK
*

store .f. to MRK_SEL

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

*
* Returned from GSNAME and FINDSCH
*

store space(3) to SCH_STEP
store space(5) to SCH_SNAME
store space(65) to SCH_SDESC
store space(8) to SCH_FNAME
store space(8) to SCH_FNDX
store space(8) to SCH_LTTR

*
* Returned from GSSTEP and FINDSCH
*

store .f. to SCH_SEL
store .f. to STEP_SEL

*
* Schedule Directory Variable
*

store space(5) to SCHD_NAME
store space(65) to SCHD_DESC
store 0 to SCHD_MAX

*
* Business Variables
*

store "\{"to BUS_DATA
store "\{bus_fst_name}" to B_TRGT_1
store "\{bus_lst_name}" to B_TRGT_2
store "\{bus_title}" to B_TRGT_3
store "\{bus_name}" to B_TRGT_4
store "\{bus_addr_1}" to B_TRGT_5
store "\{bus_addr_2}" to B_TRGT_6
store "\{bus_city}" to B_TRGT_7
store "\{bus_state}" to B_TRGT_8
store "\{bus_zip}" to B_TRGT_9
store "\{bus_phone}" to B_TRGT_10

store space(15) to BUS_FNME
store space(20) to BUS_LNME
store space(40) to BUS_TTLE
store space(40) to BUS_NAME
store space(30) to BUS_ADD1
store space(30) to BUS_ADD2
store space(20) to BUS_CITY
store space(2) to BUS_ST
store space(9) to BUS_ZIP
store space(12) to BUS_PHNE

*
* Letter temporary file Variables
*

store space(5) to LTTR_NO
store space(20) to LST_N
store space(15) to FST_N
store space(8) to LTTR_TOS

*
* Schedule directory variables
*

store space(5) to SCHD_NAME
store space(65) to SCHD_DESC

*
* Letter directory variables
*

store .f. to LTR_SEL
store space(8) to LTR_NAME
store space(65) to LTR_DESC
store space(1) to LTR_FNAME

*
* Menu (decider) directory variables
*

store 0 to DCHOICE
store space(65) to DPROMPT
store space(5) to NXT_SCHD
store space(3) to NXT_STEP

store .f. to DCD_SEL
store .f. to CHOICE_SEL
store space(5) to DCD_NAME
store space(65) to DCD_DESC
store space(18) to DCD_FNAME
store space(8) to DCD_FNDX

store space(5) to DCD_SCHD
store space(3) to DCD_STEP

*
* Label format variables
*

store space(1) to L_COL
store space(2) to L_ROW
store space(3) to L_PAUSE
store space(2) to L_IDENT
store space(2) to L_TSKIP
store space(2) to L_WIDTH
store space(2) to L_CBTWN
store space(2) to L_DEPTH
store space(2) to L_LBTWN
store space(2) to L_PERCLI

store .f. to PRINT_IT

*
* Letter format variables
*

store space(3) to L_COLP
store space(2) to L_ROWP
store space(2) to L_IDNT
store space(2) to L_TSKP
store space(3) to L_PSE
store space(3) to L_COLT
store space(2) to L_ROWT
store space(2) to L_LPCLI

*
* Format label variables
*

store "" to LINE_1
store "" to LINE_2
store "" to LINE_3
store "" to LINE_4
store "" to LINE_5
store "" to LINE_6
store "" to LINE_7

*
* get procedure file
* configuration from GLOBAL file
* present greeting screen
*

set procedure to UTILITY

store "1" to SELECT_NBR
store "GLOBAL" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store G_DATE to TODAY
	replace G_DATE with date()
	replace G_LOGON with " "
	replace G_PSSWRD with " "
	replace G_PRMSSN with " "
	replace G_PWDATE with date()
	
	*
	* MONITOR - MO -> Monochrome
	*			CO -> Color
	*
	* DRIVE   - DD -> Double Density (360K)
	*		  - HD -> High Density (1.2 meg)
	*
	
	do case
	case G_MONITOR = "MO"
		store .f. to COLOR_SCRN
		
	case G_MONITOR = "CO"
		store .t. to COLOR_SCRN
		
	otherwise
		store .f. to COLOR_SCRN
		
	endcase
	
	do case
	case G_DRIVE = "DD"
		store .f. to HIGH_DRIVE
		
	case G_DRIVE = "HD"
		store .t. to HIGH_DRIVEF
		
	otherwise
		store .f. to HIGH_DRIVE
		
	endcase
	
	select WORK
	use
	
else
	store .f. to COLOR_SCRN

	store 22 to STAT_LINE
	store "FATAL ERROR : Could not open GLOBAL file" to STAT_MSG
	do status
	
	quit
	
endif

do GREET

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

*
* Determine the current directory
*

run CHDIR > DOSTXT.SDF

store "1" to SELECT_NBR
store "DOSTXT" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	zap
	append from DOSTXT.SDF sdf
	store ltrim(trim(DOSTEXT)) to IM_DIR
	
	select WORK
	use
	
else
	store 22 to STAT_LINE
	store "FATAL ERROR : Could not open DOSTXT file" to STAT_MSG
	do status
	
	quit
	
endif

store substr(IM_DIR,1,1) to IM_DRIVE
set default to &IM_DRIVE
store IM_DRIVE + ":" to IM_DRIVE
store IM_DIR + ";" + IM_DIR + "\letter;" + IM_DIR + "\daily" to PATH_DIR
set path to &PATH_DIR

*
* Ready to clear the screen and start with the first menu
*

clear

do PASSWORD

store "1" to SELECT_NBR
store "GLOBAL" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store G_PWDATE to OLD
	
	select WORK
	use
	
	if (TODAY - OLD) > 60
		store 22 to STAT_LINE
		store "Your password has expired" to STAT_MSG
		do status
		do CHNGPASS
		
	endif
	
else
	store 22 to STAT_LINE
	store "FATAL ERROR : Could not open GLOBAL file" to STAT_MSG
	do status
	
	quit
	
endif

store .t. to REFRESH
store .t. to continue
store 1 to CHOICE_FCM

do while continue
	
	if REFRESH
		store "First Choice Menu" to hEAD
		do DATETAIL
		store "Select Exit to QUIT" to R_TAIL
		do FRAME
		
		store 6 to MENU_CNT
		store CHOICE_FCM to CHOICE
		store "IntelliMail" to MENU_1
		store "The Intelligent Corespondance Systems" to DESC_1
		store "Administration" to MENU_2
		store "Define business information, user maintenance and backup/ restore database" to DESC_2
		store "Change" to MENU_3
		store "Change your password" to DESC_3
		store "Secure" to MENU_4
		store "Secure the IntelliMail system, allow another user to logon" to DESC_4
		store "DOS" to MENU_5
		store "Execute DOS command(s) then resume IntelliMail" to DESC_5
		store "Exit" to MENU_6
		store "Exit IntelliMail and return to DOS" to DESC_6
		
		do menu
		
		store CHOICE to CHOICE_FCM
		
	endif
	
	do case
		
	case CHOICE = 1
		do IMMENU
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 2
		store "1" to SELECT_NBR
		store "GLOBAL" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			store G_PRMSSN to PRMSSN
			use
			if substr(PRMSSN,2,1) = "S"
				do SYSADMIN
				store .t. to REFRESH
				store .t. to continue
			else
				store 22 to STAT_LINE
				store "SYSTEM ADMIN permission denied" to STAT_MSG
				do status
				store .f. to REFRESH
				store .t. to continue
			endif
			
		else
			store 22 to STAT_LINE
			store "FATAL ERROR : Could not open GLOBAL file" to STAT_MSG
			do status
			
			quit
			
		endif
		
	case CHOICE = 3
		do CHNGPASS
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 4
		do pASSWORD
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 5
		clear
		@ 1,0 say "Type <exit> to return to IntelliMail"
		run command
		run &IM_DRIVE
		run CHDIR &IM_DIR
		clear
		store .t. to REFRESH
		store .t. to continue
		
	case CHOICE = 6
		store .f. to continue
		
	endcase
	
enddo

clear

quit

*: EOF: IM.PRG
