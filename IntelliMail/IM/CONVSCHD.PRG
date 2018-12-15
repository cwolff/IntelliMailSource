* Last revised : Sun 4-Sep-88 at 4:01 pm
*************************************************************************
*                                                                       *
* SCHDCONV >>> Database written to convert schedule files               *
*            entry : None                                               *
*            exit : None                                                *
*                                                                       *
* (C)opyright 1988 Personal Touch Software Inc.,  All Rights Reserved.  *
*                                                                       *
* First modify SCHDTMP with the following changes						*
* 	S_SREP_CNT and S_SREP_INT removed									*
* 	S_DL_VAL CHAR 3, S_DL_SCHD CHAR 5, and S_DL_STEP CHAR 3 added 		*
*																		*
*************************************************************************

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
set color to W+/B,W+/N,N,N

store space(5) to SCHD_NAME

@ 5,10 say "Enter name of schedule file to convert"
@ 7,10 say "Schedule Name" get SCHD_NAME picture "XXXXX"

set confirm on
read
clear gets
set confirm off

store SCHD_NAME + "OLD" to OLD_NAME
store SCHD_NAME + "SCH" to NEW_NAME

store NEW_NAME + ".dbf" to START
store OLD_NAME + ".dbf" to END
! rename &START &END

select 1
use SCHDTMP

copy structure to &NEW_NAME

select 1
use

select 1
use &NEW_NAME alias NEW

select 2
use &OLD_NAME alias OLD

*
* Convert old schedule format to new schedule format
*

@ 10,10 say "Converting old schedule format to new schedule format."

do while .not. (bof() .or. eof())

    @ 12,10 say "Converting record number " + ltrim(str(recno()))

    store S_STEP to STEP
    store S_SDESC to SDESC
    store S_SSTP_TYP to SSTP_TYP
    store S_SLTR_TYP to SLTR_TYP
    store S_LTR_VAL to LTR_VAL
    store S_LTR_ID to LTR_ID
    store S_N_SCHD to N_SCHD
    store S_N_STEP to N_STEP
    store S_DCD_NAME to DCD_NAME
    store S_STRG_TYP to O_STRG_TYP
	store S_TRG_VAL to TRG_VAL
    store S_T1_SCHD to T1_SCHDL
    store S_T1_STEP to T1_STEP
    store S_T2_SCHD to T2_SCHDL
    store S_T2_STEP to T2_STEP
    store S_LOGON to LOGON

    select NEW

    *
    * Data from old schedule
    *

    append blank

    replace S_STEP with STEP
    replace S_SDESC with SDESC
    replace S_SSTP_TYP with SSTP_TYP
    replace S_SLTR_TYP with SLTR_TYP
    replace S_LTR_VAL with LTR_VAL
    replace S_LTR_ID with LTR_ID
    replace S_N_SCHD with N_SCHD
    replace S_N_STEP with N_STEP
    replace S_DCD_NAME with DCD_NAME
    replace S_STRG_TYP with O_STRG_TYP
	replace S_TRG_VAL with TRG_VAL
    replace S_T1_SCHD with T1_SCHDL
    replace S_T1_STEP with T1_STEP
    replace S_T2_SCHD with T2_SCHDL
    replace S_T2_STEP with T2_STEP
	replace S_DL_VAL with "90 "
	replace S_DL_SCHD with "TRMNT"
	replace S_DL_STEP with "   "
    replace S_LOGON with LOGON

    select OLD
    skip

enddo


