*:*********************************************************************
*:
*:        Program: FIX.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 31-Dec-88 at 5:28 pm
*:
*:      Called by: CMDNEXT.PRG    
*:
*:          Calls: PROMPT           (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : FINDSCH.PRG
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************

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

select 1
use MARKER
goto top

do while .not. (bof() .or. eof())
	@ 10,10 say "Processing record " + ltrim(str(recno()))

	store M_SCHD_PTR + "SCH" to FILE_NAME
	store M_SCHD_PTR + "SCH" to INDEX_NAME
	store val(M_STP_PTR) to THE_KEY

	@ 12,10 say "Searching for " + FILE_NAME + " with THE_KEY = " + ltrim(str(THE_KEY))

	select 2
	use &FILE_NAME index &INDEX_NAME		
	
	seek THE_KEY

	if .not. (bof() .or. eof())
		@ 14,10 say "    FOUND"

		store S_SSTP_TYP to SSTP_TYP
		store S_SLTR_TYP to SLTR_TYP
		store S_STRG_TYP to STRG_TYP

		store .T. to DOIT
	else
		@ 14,10 say "NOT FOUND   ...   record = " + ltrim(str(recno())) + " THE_KEY = " + ltrim(str(THE_KEY))

		store .F. to DOIT
	endif

	select 1

	if DOIT
		replace M_MSTP_TYP with SSTP_TYP
		replace M_MLTR_TYP with SLTR_TYP
		replace M_MTRG_TYP with STRG_TYP

	endif

	skip

enddo
		
return

*: EOF: FIX.PRG

