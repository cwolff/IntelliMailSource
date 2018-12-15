* Last modified : Sat 25-Mar-89 at 3:11 am
*:*********************************************************************
*:
*:        Program: PRINTLBL.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 19-Feb-89 at 10:12 am
*:
*:      Called by: SENDMENU.PRG
*:
*:          Calls: NOTHING
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* PRINTLBL >>> Print mailing label                                    *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

set console off
set print on

*
* Print the labels
*
* Deal with tractor feed or single sheets
*			(if single sheets then number of labels per sheet)
*			pause/ no pause
*			number of copies per client
*			number of rows per label
*

if L_ROW = "continuous"
	store 0 to LBL_COUNT

	do while LBL_COUNT < val(L_PERCLI)

		*
		* Print out the formated label lines
		*

		? space(val(L_IDENT)) + LABEL_L1
		? space(val(L_IDENT)) + LABEL_L2
		? space(val(L_IDENT)) + LABEL_L3
		? space(val(L_IDENT)) + LABEL_L4
		? space(val(L_IDENT)) + LABEL_L5

		if val(L_DEPTH) > 5
			? space(val(L_IDENT)) + LABEL_L6
		endif

		if val(L_DEPTH) > 6
			? space(val(L_IDENT)) + LABEL_L7
		endif

		*
		* Line feed the unused lable depth
		*

		if val(L_DEPTH) > 7
			store 0 to LINE_FILL
			do while ( (LINE_FILL) < val(L_DEPTH) - 7)
				?
				store LINE_FILL + 1 to LINE_FILL

			enddo

		endif

		*
		* Line feed the lines between labels
		*

		if val(L_LBTWN) > 0
			store 0 to LINE_FILL
			do while ( (LINE_FILL) < val(L_LBTWN))
				?
				store LINE_FILL + 1 to LINE_FILL

			enddo

		endif

		store LBL_COUNT + 1 to LBL_COUNT

	enddo

else

	store 0 to LBL_COUNT

	do while LBL_COUNT < val(L_PERCLI)

		*
		* Print out the formated label lines
		*

		? space(val(L_IDENT)) + LABEL_L1
		? space(val(L_IDENT)) + LABEL_L2
		? space(val(L_IDENT)) + LABEL_L3
		? space(val(L_IDENT)) + LABEL_L4
		? space(val(L_IDENT)) + LABEL_L5

		if val(L_DEPTH) > 5
			? space(val(L_IDENT)) + LABEL_L6
		endif

		if val(L_DEPTH) > 6
			? space(val(L_IDENT)) + LABEL_L7
		endif

		*
		* Line feed the unused label depth
		*

		if val(L_DEPTH) > 7
			store 0 to LINE_FILL
			do while ( (LINE_FILL) < val(L_DEPTH) - 7)
				?
				store LINE_FILL + 1 to LINE_FILL

			enddo

		endif

		*
		* Line feed the lines between labels
		*

		if val(L_LBTWN) > 0
			store 0 to LINE_FILL
			do while ( (LINE_FILL) < val(L_LBTWN))
				?
				store LINE_FILL + 1 to LINE_FILL

			enddo

		endif

		store LBL_COUNT + 1 to LBL_COUNT

		*
		* Determine if it is time for a line feed
		* for the printer (i.e., lazer, sheet feed etc.)
		*

		store ROW_COUNT + 1 to ROW_COUNT

		if ROW_COUNT >= val(L_ROW)
			eject
			store 1 to ROW_COUNT

			*
			* Determine if we are suppose to pause
			*

			if L_PAUSE = "YES"
				store 22 to STAT_LINE
				store "Label printer pause" to STAT_MSG
				do STATUS

			endif

			*
			* Determine if we are to skip number of first lines
			*

			if val(L_TSKIP) > 0
				store 0 to LINE_FILL
				do while ( (LINE_FILL) < val(L_TSKIP))
					?
					store LINE_FILL + 1 to LINE_FILL

				enddo

			endif

		endif

	enddo

endif

set print off
set console on

return

