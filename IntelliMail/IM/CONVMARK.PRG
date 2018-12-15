* Last revised : Sun 4-Sep-88 at 4:00 pm
*************************************************************************
*                                                                       *
* CONVMARK >>> Data Base written to convert marker files			    *
*            entry : None                                               *
*            exit : None                                                *
*                                                                       *
* (C)opyright 1988 Personal Touch Software Inc.,  All Rights Reserved.  *
*                                                                       *
* First rename the old marker.dbf to oldmrk.dbf							*
* then create the new marker.dbf file with the following changes		*
* 	M_MREP_CNT and MREP_INT were deleted								*
* 	M_DATE_SNT date was added											*
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

*
* Convert to new marker format
*

select 1
use MARKER index MARKER alias MARKER
delete all
pack

select 2
use OLDMRK alias OLDMRK

select OLDMRK

@ 10,10 say "Converting to new marker format."

do while .not. (bof() .or. eof())

    @ 12,10 say "Converting record number " + ltrim(str(recno()))

    store M_MRK_NBR to MRK_NBR 
    store M_SCHD_PTR to SCHD_PTR 
    store M_STP_PTR to STP_PTR 
    store M_MDESC to MDESC
	store M_DINT to DINT
    store M_LST_SCHD to LST_SCHD 
    store M_LST_STP to LST_STP 
	store M_LST_DESC to LST_DESC
    store M_LST_DINT to LST_DINT 
    store M_LTR_TOS to LTR_TOS 
    store M_DATE_TOS to DATE_TOS 
    store M_SEND_CNT to SEND_CNT 
    store M_TRG_CNT to TRG_CNT 
    store M_TRG_DATE to TRG_DATE 
	store M_MSTP_TYP to MSTP_TYP
	store M_MLTR_TYP to MLTR_TYP
	store M_MTRG_TYP to MTRG_TYP
    store M_ERR_FLAG to ERR_FLAG 
	store M_ERR_DESC to ERR_DESC
    store M_LOGON to LOGON 

    select MARKER

    *
    * Data from old header
    *

    append blank

    replace M_MRK_NBR with MRK_NBR 
    replace M_SCHD_PTR with SCHD_PTR 
    replace M_STP_PTR with STP_PTR 
    replace M_MDESC with MDESC
	replace M_DINT with DINT
    replace M_LST_SCHD with LST_SCHD 
    replace M_LST_STP with LST_STP 
	replace M_LST_DESC with LST_DESC
    replace M_LST_DINT with LST_DINT 
    replace M_LTR_TOS with LTR_TOS 
    replace M_DATE_TOS with DATE_TOS 
    replace M_TRG_CNT with TRG_CNT 
    replace M_TRG_DATE with TRG_DATE 
	replace M_MSTP_TYP with MSTP_TYP
	replace M_MLTR_TYP with MLTR_TYP
	replace M_MTRG_TYP with MTRG_TYP
    replace M_ERR_FLAG with ERR_FLAG 
	replace M_ERR_DESC with ERR_DESC
    replace M_LOGON with LOGON 

	if val(SEND_CNT) > 0
		replace M_SEND_FLG with "T"

	else
		replace M_SEND_FLG with "F"

	endif

    *
    * Assume DATE_SNT is the same as DATE_TOS
	* (not necessarly the date actually sent but actual date not available)
    *

    replace M_DATE_SNT with DATE_TOS

    select OLDMRK

    skip

enddo

select MARKER
index on M_MRK_NBR to MARKER

select MARKER
use

select OLDMRK
use

return

