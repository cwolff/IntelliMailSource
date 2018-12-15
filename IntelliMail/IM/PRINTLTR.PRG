* Last modified : Sat 25-Mar-89 at 11:31 am
*:*********************************************************************
*:
*:        Program: PRINTLTR.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 19-Feb-89 at 10:12 am
*:
*:      Called by: SENDMENU.PRG
*:
*:          Calls: CHECKKEY
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* PRINTLTR >>> Print letters                                          *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

set console off
set print on

LINE_LENGTH = val(L_COLT)
WORD_WRAP = .t.
TABSIZE = 8

TOP_ROW = val(L_TSKP)
FRST_COL = val(L_IDNT)
PAGE_SIZE = val(L_ROWT)

LINE_CNT = MLCOUNT(USR_MEMO, LINE_LENGTH, TABSIZE, WORD_WRAP)
store LINE_CNT + 1 to LINE_CNT

CURR_LINE = 1

store 1 to CHOICE
store .t. to LTR_OK

*
* Do Top of Page Margin
*

ROW_OFF = val(L_TSKP)
store 0 to ROW_CNT
do while ROW_CNT < ROW_OFF
	?
	store ROW_CNT + 1 to ROW_CNT
enddo

do while CURR_LINE < LINE_CNT .and. (CHOICE <> 0)
	store .t. to LTR_OK
	PRINT_LINE = MEMOLINE(USR_MEMO, LINE_LENGTH, CURR_LINE, TABSIZE, WORD_WRAP)

	PAGE_FEED = mod(CURR_LINE - 1,PAGE_SIZE)

	store trim(PRINT_LINE) to TEXT_LINE

	if PAGE_FEED = 0 .and. CURR_LINE > 1
		if val(L_ROWP) = 66
			eject

		else

			*
			* Space out bottom of page if no form feed
			*

			store val(L_ROWP) - (val(L_ROWT) + TOP_ROW) to ROW_LMT
			store 0 to ROW_CNT
			do while  ROW_CNT < ROW_LMT
				?
				store ROW_CNT + 1 to ROW_CNT

			enddo

		endif

		*
		* Do Top of Page Margin
		*

		ROW_OFF = val(L_TSKP)
		store 0 to ROW_CNT
		do while ROW_CNT < ROW_OFF
			?
			store ROW_CNT + 1 to ROW_CNT
		enddo

	endif

	do SUBTEXT

	? space(FRST_COL) + TEXT_LINE

	if .not. LTR_OK
		select MARKER

		seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

		if .not. (eof() .or. bof())

			*
			* 04 = invalid substition string
			*

			store .f. to READ_ERROR
			do READMRK

			store "Invalid substitution string in the &LTTR_TOS letter" to ERR_MSG
			store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
			store "04" to ERR_FLAG

			do WRITEMRK

		endif

		select CLIENT

	endif

	set print off
	set console on

	do CHECKKEY

	set console off
	set print on

	CURR_LINE = CURR_LINE + 1

enddo

set print off
set console on

return
 								
