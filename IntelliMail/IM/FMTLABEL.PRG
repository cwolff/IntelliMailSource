*:*********************************************************************
*:
*:        Program: FMTLABEL.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 5-Mar-89 at 1:09 am
*:
*:      Called by: SENDMENU.PRG
*:
*:          Calls: READLF.PRG
*:				   WRITELF.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* FMTLABEL >>> Format label to print                                 *
*			enter current client record								  *
*           exit LINE(1) - LINE(7) and LINE_NDX                       *
*																	  *
***********************************************************************

*
* The stradegy for building a label
* is to put as much of the information on the label as
* possible.  If there are more fields then lines on the label
* then drop the co title and/ or company name.
*
*

store "" to LINE_1
store "" to LINE_2
store "" to LINE_3
store "" to LINE_4
store "" to LINE_5
store "" to LINE_6
store "" to LINE_7

store ltrim(trim(LBL_CODE)) to T_LBL_CODE
store ltrim(trim(TITLE)) to T_TITLE
store ltrim(trim(LST_N)) to T_LST_N
store ltrim(trim(FST_N)) to T_FST_N
store ltrim(trim(CO_TITLE)) to T_CO_TITLE
store ltrim(trim(CO_NAME)) to T_CO_NAME
store ltrim(trim(ADDR_1)) to T_ADDR_1
store ltrim(trim(ADDR_2)) to T_ADDR_2
store ltrim(trim(CITY)) to T_CITY
store ltrim(trim(STATE)) to T_STATE
store ltrim(trim(ZIP)) to T_ZIP
if substr(T_ZIP,len(T_ZIP),1) = "-"
	store substr(T_ZIP,1,len(T_ZIP) - 1) to T_ZIP
endif

*
* Current label line being filled (index into the line array)
*
* Use macro substitution and the variable LINE_ARRAY to
* simulate an array
*

store 1 to LINE_NDX
store "LINE_1" to LINE_ARRAY

*
* If number of label lines is less then 7
* then count up all the possible labels lines
* to be used when determining if T_CO_TITLE and T_CO_NAME
* should be included on the label
*

if val(L_DEPTH) < 7
	store 0 to COUNT_LINES

	if len(T_LBL_CODE) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

	if len(T_TITLE) > 0 .or. len(T_FST_N) > 0 .or. len(T_LST_N) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

	if len(T_CO_NAME) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

	if len(T_ADDR_1) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

	if len(T_ADDR_2) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

	if len(T_ADDR_2) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

	if len(T_CITY) > 0 .or. len(T_STATE) > 0 .or. len(T_ZIP) > 0
		store COUNT_LINES + 1 to COUNT_LINES
	endif

endif

*
* Is there a T_LBL_CODE
*

if len(T_LBL_CODE) > 0

	*
	* Check to see if enough room, if there is then
	* right justify the T_LBL_CODE
	*

	do case
		case len(T_LBL_CODE) >= val(L_WIDTH)
			store substr(T_LBL_CODE,1,val(L_WIDTH)) to &LINE_ARRAY

		case len(T_LBL_CODE) + 5 <= val(L_WIDTH)
			store space(val(L_WIDTH) - (len(T_LBL_CODE) + 5)) + T_LBL_CODE to &LINE_ARRAY

		case len(T_LBL_CODE) + 4 <= val(L_WIDTH)
			store space(val(L_WIDTH) - (len(T_LBL_CODE) + 4)) + T_LBL_CODE to &LINE_ARRAY

		case len(T_LBL_CODE) + 3 <= val(L_WIDTH)
			store space(val(L_WIDTH) - (len(T_LBL_CODE) + 3)) + T_LBL_CODE to &LINE_ARRAY

		case len(T_LBL_CODE) + 2 <= val(L_WIDTH)
			store space(val(L_WIDTH) - (len(T_LBL_CODE) + 2)) + T_LBL_CODE to &LINE_ARRAY

		case len(T_LBL_CODE) + 1 <= val(L_WIDTH)
			store space(val(L_WIDTH) - (len(T_LBL_CODE) + 1)) + T_LBL_CODE to &LINE_ARRAY

		otherwise
			store space(val(L_WIDTH) - (len(T_LBL_CODE))) + T_LBL_CODE to &LINE_ARRAY

	endcase

	store LINE_NDX + 1 to LINE_NDX
	store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

endif

*
* If there is a name build it in the following order
*
* If T_TITLE T_FST_N T_LST_N then
* 	T_TITLE T_FST_N T_LST_N or
* 	T_TITLE FI T_LST_N or
* 	T_FST_N T_LST_N or
* 	FI LAST_NAME or
* 	T_LST_N
* endif
*
* If T_FST_N T_LST_N
* 	T_FST_N T_LST_N or
* 	FI LAST_NAME or
* 	T_LST_N
* endif
*
* if T_TITLE T_LST_N
*	T_TITLE T_LST_N or
*	T_LST_N
* endif
*
* if T_TITLE T_FST_N
*	T_TITLE T_FST_N
*	T_FST_N
* endif
*
* if T_LST_N
*	T_LST_N
* endif
*
* if T_FST_N
*	T_FST_N
* end
*
* If T_TITLE
*	T_TITLE
* endif
*
* If ""
* 	null
* endif
*

do case
	case len(T_TITLE) > 0 .and. len(T_FST_N) > 0 .and. len(T_LST_N) > 0
		do case
			case len(T_TITLE) + len(T_LST_N) + len(T_FST_N) + 2 <= val(L_WIDTH)
				store T_TITLE + " " + T_FST_N + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_TITLE) + len(T_FST_N) + 3 <= val(L_WIDTH)
				store T_TITLE + " " + substr(T_FST_N,1,1) + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_FST_N) + len(T_LST_N) + 1 <= val(L_WIDTH)
				store T_FST_N + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_LST_N) + 2 <= val(L_WIDTH)
				store substr(T_FST_N,1,1) + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_LST_N) <= val(L_WIDTH)
				store T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_LST_N,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endcase

	case len(T_TITLE) = 0 .and. len(T_FST_N) > 0 .and. len(T_LST_N) > 0
		do case
			case len(T_FST_N) + len(T_LST_N) + 1 <= val(L_WIDTH)
				store T_FST_N + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_LST_N) + 2 <= val(L_WIDTH)
				store substr(T_FST_N,1,1) + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_LST_N) <= val(L_WIDTH)
				store T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_LST_N,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endcase

	case len(T_TITLE) > 0 .and. len(T_FST_N) = 0 .and. len(T_LST_N) > 0
		do case
			case len(T_TITLE) + len(T_LST_N) + 1 <= val(L_WIDTH)
				store T_TITLE + " " + T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_LST_N) <= val(L_WIDTH)
				store T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_LST_N,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endcase

	case len(T_TITLE) > 0 .and. len(T_FST_N) > 0 .and. len(T_LST_N) = 0
		do case
			case len(T_TITLE) + len(T_FST_N) + 1 <= val(L_WIDTH)
				store T_TITLE + " " + T_FST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			case len(T_FST_N) <= val(L_WIDTH)
				store T_FST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_FST_N,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endcase
		
	case len(T_TITLE) = 0 .and. len(T_FST_N) = 0 .and. len(T_LST_N) > 0
		do case
			case len(T_LST_N) <= val(L_WIDTH)
				store T_LST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_LST_N,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endcase

	case len(T_TITLE) = 0 .and. len(T_FST_N) > 0 .and. len(T_LST_N) = 0
		do case
			case len(T_FST_N) <= val(L_WIDTH)
				store T_FST_N to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_FST_N,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endcase

	case len(T_TITLE) > 0 .and. len(T_FST_N) = 0 .and. len(T_LST_N) = 0
		do case
			case len(T_TITLE) <= val(L_WIDTH)
				store T_TITLE to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX
				store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

			otherwise
				store substr(T_TITLE,1,val(L_WIDTH)) to &LINE_ARRAY
				store LINE_NDX + 1 to LINE_NDX

		endcase

endcase

*
* Next try company title
* If only 5 or 6 lines of label and not enough room skip
*

if len(T_CO_TITLE) > 0
	if val(L_DEPTH) < 7
		do case
			case val(L_DEPTH) = 5
				if COUNT_LINES < 6
					if len(T_CO_TITLE) < val(L_WIDTH)
						store T_CO_TITLE to &LINE_ARRAY
					else
						store substr(T_CO_TITLE,1,val(L_WIDTH)) to &LINE_ARRAY

					endif

					store LINE_NDX + 1 to LINE_NDX
					store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

				endif

			case val(L_DEPTH) = 6
				if COUNT_LINES < 7
					if len(T_CO_TITLE) < val(L_WIDTH)
						store T_CO_TITLE to &LINE_ARRAY
					else
						store substr(T_CO_TITLE,1,val(L_WIDTH)) to &LINE_ARRAY

					endif

					store LINE_NDX + 1 to LINE_NDX
					store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

				endif

		endcase

	else
		if len(T_CO_TITLE) <= val(L_WIDTH)
			store T_CO_TITLE to &LINE_ARRAY
			store LINE_NDX + 1 to LINE_NDX
			store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		else
			store substr(T_CO_TITLE,1,val(L_WIDTH)) to &LINE_ARRAY
			store LINE_NDX + 1 to LINE_NDX
			store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endif
			
	endif

endif

*
* Next try company name
* If only 5 or 6 lines of label and not enough room skip
*

if len(T_CO_NAME) > 0
	if val(L_DEPTH) < 7
		do case
			case val(L_DEPTH) = 5
				if COUNT_LINES < 6 .or. (COUNT_LINES = 6 .and. len(T_CO_TITLE) > 0)
					if len(T_CO_NAME) < val(L_WIDTH)
						store T_CO_NAME to &LINE_ARRAY
					else
						store substr(T_CO_NAME,1,val(L_WIDTH)) to &LINE_ARRAY

					endif

					store LINE_NDX + 1 to LINE_NDX
					store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

				endif

			case val(L_DEPTH) = 6
				if COUNT_LINES < 7
					if len(T_CO_NAME) < val(L_WIDTH)
						store T_CO_NAME to &LINE_ARRAY
					else
						store substr(T_CO_NAME,1,val(L_WIDTH)) to &LINE_ARRAY

					endif

					store LINE_NDX + 1 to LINE_NDX
					store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

				endif

		endcase

	else
		if len(T_CO_NAME) <= val(L_WIDTH)
			store T_CO_NAME to &LINE_ARRAY
			store LINE_NDX + 1 to LINE_NDX
			store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		else
			store substr(T_CO_NAME,1,val(L_WIDTH)) to &LINE_ARRAY
			store LINE_NDX + 1 to LINE_NDX
			store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

		endif
			
	endif

endif

*
* Now try address 1
*

if len(T_ADDR_1) > 0
	if len(T_ADDR_1) <= val(L_WIDTH)
		store T_ADDR_1 to &LINE_ARRAY
		store LINE_NDX + 1 to LINE_NDX
		store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

	else
		store substr(T_ADDR_1,1,val(L_WIDTH)) to &LINE_ARRAY
		store LINE_NDX + 1 to LINE_NDX
		store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

	endif

endif

*
* Now try address 2
*

if len(T_ADDR_2) > 0
	if len(T_ADDR_2) <= val(L_WIDTH)
		store T_ADDR_2 to &LINE_ARRAY
		store LINE_NDX + 1 to LINE_NDX
		store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

	else
		store substr(T_ADDR_2,1,val(L_WIDTH)) to &LINE_ARRAY
		store LINE_NDX + 1 to LINE_NDX
		store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

	endif

endif

*
* Now try T_CITY, T_STATE T_ZIP
*

do case
	case len(T_CITY) > 0 .and. len(T_STATE) > 0 .and. len(T_ZIP) > 0
		if len(T_CITY) > val(L_WIDTH) - (len(T_STATE) + len(T_ZIP) + 4)
			store substr(T_CITY,1,val(L_WIDTH) - (len(T_STATE) + len(T_ZIP) + 4)) + ", " + T_STATE + " " + T_ZIP to &LINE_ARRAY
		else
			store T_CITY + ", " + T_STATE + " " + T_ZIP to &LINE_ARRAY
		endif

	case len(T_CITY) = 0 .and. len(T_STATE) > 0 .and. len(T_ZIP) > 0
		if len(T_STATE) > val(L_WIDTH) - (len(T_ZIP) + 1)
			store substr(T_STATE,1,val(L_WIDTH) - (len(T_ZIP) + 1)) + T_ZIP to &LINE_ARRAY
		else
			store T_STATE + " " + T_ZIP to &LINE_ARRAY
		endif

	case len(T_CITY) > 0 .and. len(T_STATE) = 0 .and. len(T_ZIP) > 0
		if len(T_CITY) > val(L_WIDTH) - (len(T_ZIP) + 1)
			store substr(T_CITY,1,val(L_WIDTH) - (len(T_ZIP) + 1)) + T_ZIP to &LINE_ARRAY
		else
			store T_CITY + " " + T_ZIP to &LINE_ARRAY
		endif

	case len(T_CITY) > 0 .and. len(T_STATE) > 0 .and. len(T_ZIP) = 0
		if len(T_CITY) > val(L_WIDTH) - (len(T_STATE) + 2)
			store substr(T_CITY,1,val(L_WIDTH) - (len(T_STATE) + 2)) + ", " + T_STATE to &LINE_ARRAY
		else
			store T_CITY + ", " + T_STATE to &LINE_ARRAY
		endif

	case len(T_CITY) = 0 .and. len(T_STATE) = 0 .and. len(T_ZIP) > 0
		if len(T_ZIP) > val(L_WIDTH)
			store substr(T_ZIP,1,val(L_WIDTH)) to &LINE_ARRAY
		else
			store T_ZIP to &LINE_ARRAY
		endif

	case len(T_CITY) = 0 .and. len(T_STATE) > 0 .and. len(T_ZIP) = 0
		if len(T_STATE) > val(L_WIDTH)
			store substr(T_STATE,1,val(L_WIDTH)) to &LINE_ARRAY
		else
			store T_STATE to &LINE_ARRAY
		endif

	case len(T_CITY) > 0 .and. len(T_STATE) = 0 .and. len(T_ZIP) = 0
		if len(T_CITY) > val(L_WIDTH)
			store substr(T_CITY,1,val(L_WIDTH)) to &LINE_ARRAY
		else
			store T_CITY to &LINE_ARRAY
		endif

	case len(T_CITY) = 0 .and. len(T_STATE) = 0 .and. len(T_ZIP) = 0
		store LINE_NDX - 1 to LINE_NDX
		store "LINE_" + ltrim(str(LINE_NDX)) to LINE_ARRAY

endcase

store LINE_1 + space(val(L_WIDTH) - len(LINE_1)) to LINE_1
store LINE_2 + space(val(L_WIDTH) - len(LINE_2)) to LINE_2
store LINE_3 + space(val(L_WIDTH) - len(LINE_3)) to LINE_3
store LINE_4 + space(val(L_WIDTH) - len(LINE_4)) to LINE_4
store LINE_5 + space(val(L_WIDTH) - len(LINE_5)) to LINE_5
store LINE_6 + space(val(L_WIDTH) - len(LINE_6)) to LINE_6
store LINE_7 + space(val(L_WIDTH) - len(LINE_7)) to LINE_7

return

