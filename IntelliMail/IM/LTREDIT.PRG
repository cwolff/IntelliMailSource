*:*********************************************************************
*:
*:        Program: LTREDIT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 24-Mar-89 at 0:22 pm
*:
*:  Procs & Fncts: MFUNC()
*:               : PAD()
*:
*:      Called by: LTRMENU.PRG    
*:
*:     Documented: 09/04/88 at 16:57               FoxDoc version 1.0
*:*********************************************************************
*                                                                     *
* LTREDIT >>> Data Base written for Audiology Clinics                 *
*            entry : MEMOFILE, MEMONAME                               *
*            exit : None                                              *
*                                                                     *
***********************************************************************

parameters MEMOFILE, MEMONAME

store "10" to SELECT_NBR
store "LTTRFMT" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store SEL_NAME to L_TAIL
	store "Select Return to STOP" to R_TAIL
	store "Press   " + chr(27) + " " + chr(26) + " Del to Select ฤู when Done" to R_TAIL
	do TAIL

	do READTF

	select WORK
	use

	if COLOR_SCRN
		set color to w/b,w+/b,n,n
	else
		set color to w/n,w+/n,n,n
	endif

	LINE_LENGTH = val(L_COLT)
	PAGE_SIZE = val(L_ROWT)

	clear

	RET_VAL = 0
	T = 1
	L = 1
	b = 23
	r = 78
	store .t. to update
	store .t. to browse
	UFUNC = "MFUNC"
	INS_ON = .t.
	SCRL_ON = .f.
	WORD_WRAP = .t.
	TABSIZE = 8

	USR_MEMO = memoread(MEMOFILE)
	LINE_NUM = 1
	COL_NUM = 0
	REL_LINE = 0
	REL_COL = 0
	VCHOICE = ""
	SRCH_STR = ""
	RPLCH_STR = ""
	FTCH_FNAME = ""

	MSG_LEN = r - L - 40

	if COLOR_SCRN
		set color to gb/b,w+/b,n,n
	else
		set color to w/n,w+/n,n,n
	endif

	@ T, L, b, r box "ีอธณพอิณ"

	@ T, L+52 say "[ Press Alt-H for help ]"

	if COLOR_SCRN
		set color to w/b,w+/b,n,n
	else
		set color to w/n,w+/n,n,n
	endif

	@ b + 1, L say PAD("Editing letter " + upper(MEMONAME), MSG_LEN)

	INIT_COUNT = 1

	*
	* RET_STATUS
	*   = 0 abort
	*   = 1 write file and exit
	*   = 2 write file
	*	= 3 print file then return to editing
	*	= 4 substitute variable then return to editing
	*	= 5 found search string
	*	= 6 replace string
	*   = 7 fetch file
	*   = 8 set letter layout
	*

	RET_STATUS = 99

	do while RET_STATUS > 1

		USR_MEMO = memoedit(USR_MEMO, T + 1, L + 1, b - 1, r - 1, update, UFUNC, ;
			LINE_LENGTH, TABSIZE, LINE_NUM, COL_NUM, REL_LINE, REL_COL)

		do case
			case RET_STATUS = 1
				@ b + 1, L say space(MSG_LEN)
				@ b + 1, L say "Writing " + upper(MEMONAME) + "..."

				if .not. memowrit(MEMOFILE, USR_MEMO)
					@ b + 1, L say PAD("Disk write error.", MSG_LEN)
		
				else
					@ b + 1, L say PAD("Write successful.", MSG_LEN)
		
				endif

			case RET_STATUS = 2
				@ b + 1, L say space(MSG_LEN)
				@ b + 1, L say "Writing " + upper(MEMONAME) + "..."

				if .not. memowrit(MEMOFILE, USR_MEMO)
					@ b + 1, L say PAD("Disk write error.", MSG_LEN)
		
				else
					@ b + 1, L say PAD("Write successful.", MSG_LEN)
		
				endif

			case RET_STATUS = 3
				@ b + 1, L say PAD("Printing letter " + upper(MEMONAME), MSG_LEN)
	
				set console off
				set print on
	
				TOP_ROW = val(L_TSKP)
				FRST_COL = val(L_IDNT)
	
				*
				* Do Top of Page Margin
				*

				ROW_OFF = val(L_TSKP)
				store 0 to ROW_CNT
				do while ROW_CNT < ROW_OFF
					?
					store ROW_CNT + 1 to ROW_CNT
				enddo

				LINE_CNT = MLCOUNT(USR_MEMO, LINE_LENGTH, TABSIZE, WORD_WRAP)

				for CURR_LINE = 1 to LINE_CNT
					PRINT_LINE = MEMOLINE(USR_MEMO, LINE_LENGTH, CURR_LINE, TABSIZE, WORD_WRAP)
		
					PAGE_FEED = mod(CURR_LINE - 1,PAGE_SIZE)
		
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
		
					? space(FRST_COL) + PRINT_LINE
		
				next

				eject
	
				set console on
				set print off
	
				@ b + 1, L say PAD("Editing letter " + upper(MEMONAME), MSG_LEN)

			case RET_STATUS = 4
				MEMO_LEN = len(USR_MEMO)
				MEMO_POS = mlpos(USR_MEMO, LINE_LENGTH, LINE_NUM, TABSIZE, WORD_WRAP) + COL_NUM

				if MEMO_POS >= MEMO_LEN
					END_CHAR = substr(USR_MEMO,MEMO_LEN,1)

					if END_CHAR = chr(10) .or. END_CHAR = chr(13)
						USR_MEMO = USR_MEMO + VCHOICE

					else
						USR_MEMO = stuff(USR_MEMO, MEMO_POS, 0, VCHOICE)

					endif

				else
					USR_MEMO = stuff(USR_MEMO, MEMO_POS, 0, VCHOICE)

				endif

				store COL_NUM + len(VCHOICE) to COL_NUM
				store COL_NUM to REL_COL

				if COL_NUM > LINE_LENGTH
					store LINE_NUM + 1 to LINE_NUM
					store LINE_NUM to REL_LINE
					store len(VCHOICE) to COL_NUM
					store COL_NUM to REL_COL

				endif

			case RET_STATUS = 5
				MEMO_POS = mlpos(USR_MEMO, LINE_LENGTH, LINE_NUM, TABSIZE, WORD_WRAP) + COL_NUM
				LINE_CNT = MLCOUNT(USR_MEMO, LINE_LENGTH, TABSIZE, WORD_WRAP)

				*
				* If not at end of memo and not found in remainder of first line
				* then search rest of memo
				*

				if MEMO_POS < len(USR_MEMO)
					SRCH_LINE = MEMOLINE(USR_MEMO, LINE_LENGTH, LINE_NUM, TABSIZE, WORD_WRAP)
					store at(SRCH_STR, substr(SRCH_LINE,COL_NUM+2,len(SRCH_LINE))) to SRCH_HIT

					if SRCH_HIT = 0
						for CURR_LINE = LINE_NUM + 1 to LINE_CNT
							SRCH_LINE = MEMOLINE(USR_MEMO, LINE_LENGTH, CURR_LINE, TABSIZE, WORD_WRAP)
							store at(SRCH_STR, SRCH_LINE) to SRCH_HIT

							if SRCH_HIT <> 0

								*
								* Set the LINE_NUM and COL_NUM
								*

								store CURR_LINE to LINE_NUM
								store SRCH_HIT - 1 to COL_NUM

								exit

							endif
					
						next

					else

						*
						* Found on current line to LINE_NUM is already set
						* Adjust for the row
						*

						store SRCH_HIT + COL_NUM to COL_NUM

					endif

					store LINE_NUM to REL_LINE
					store COL_NUM to REL_COL

				endif

			case RET_STATUS = 6
				if len(SRCH_STR) > 0
					MEMO_LEN = len(USR_MEMO)
					MEMO_POS = mlpos(USR_MEMO, LINE_LENGTH, LINE_NUM, TABSIZE, WORD_WRAP) + COL_NUM

					do case
						case MEMO_POS = 1
							USR_MEMO = strtran(substr(USR_MEMO,1,MEMO_LEN),SRCH_STR,RPLCH_STR)

						case MEMO_POS < MEMO_LEN
							USR_MEMO = substr(USR_MEMO,1,MEMO_POS) + strtran(substr(USR_MEMO,MEMO_POS+1,MEMO_LEN-MEMO_POS),SRCH_STR,RPLCH_STR)

					endcase

				endif

			case RET_STATUS = 7
				MEMO_LEN = len(USR_MEMO)
				MEMO_POS = mlpos(USR_MEMO, LINE_LENGTH, LINE_NUM, TABSIZE, WORD_WRAP) + COL_NUM

				do case

					case MEMO_POS = 1
						USR_MEMO = memoread(FTCH_FNAME) + substr(USR_MEMO,MEMO_POS,MEMO_LEN-MEMO_POS)

					case MEMO_POS < MEMO_LEN
						USR_MEMO = substr(USR_MEMO,1,MEMO_POS-1) + memoread(FTCH_FNAME) + substr(USR_MEMO,MEMO_POS,MEMO_LEN-MEMO_POS)

					case MEMO_POS = MEMO_LEN
						USR_MEMO = USR_MEMO + memoread(FTCH_FNAME)

				endcase

			case RET_STATUS = 8
				LINE_LENGTH = val(L_COLT)
				PAGE_SIZE = val(L_ROWT)

		endcase
	
	enddo

	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif

endif

return

*************************************************************************
*                                                                       *
* MFUNC >>> Memoedit user function                                      *
*            entry : None                                               *
*            exit : RET_VAL                                             *
*                                                                       *
*************************************************************************

function MFUNC

parameters MODE, LINE, COL

private KEYPRESS

RET_VAL = 0

*
* See what mode this user function was entered with
*
* 0 - idle
* 1 - re-configurable or unknown keystroke (memo unaltered)
* 2 - re-configurable or unknown keystroke (memo altered)
* 3 - start up
*

do case
	
	*
	* 0 - Idle
	*
	
case MODE = 0
	store int((LINE - 1) / PAGE_SIZE) + 1 to SHOW_PAGE
	store int(mod(LINE,PAGE_SIZE)) to SHOW_LINE
	if SHOW_LINE = 0
		store PAGE_SIZE to SHOW_LINE
	endif
	
	store LINE to LINE_NUM
	store COL to COL_NUM 
	store LINE_NUM to REL_LINE
	store COL to REL_COL

	@ b + 1, r - 32 say "Page: " + PAD(ltrim(str(SHOW_PAGE)), 3)
	@ b + 1, r - 20 say "Line: " + PAD(ltrim(str(SHOW_LINE)), 4)
	@ b + 1, r - 8 say "Col: " + PAD(ltrim(str(COL+1)), 3)
	
	*
	* 3 - Start-up
	*
	* Initialization..global variables "INIT_COUNT"
	* control the initialization process..note that this is
	* much simpler when the parameters passed to MEMOEDIT
	* are known in advance (which is usually true)
	*
	
case MODE = 3
	
	if INIT_COUNT = 1
		
		*
		* Set initial insert mode
		*
		
		INS_MODE = READINSERT()
		
		if (INS_ON .and. .not. INS_MODE) .or. (.not. INS_ON .and. INS_MODE)
			
			*
			* Toggle insert mode
			*
			
			RET_VAL = 22
			
		else
			
			*
			* Insert mode correct
			*
			
			INIT_COUNT = 2
			@ b + 1, r - 35 say if(INS_ON, "I", " ")
			
		endif
		
	endif
	
	if INIT_COUNT = 2
		
		*
		* Set initial scroll state (defaults ON if update OFF)
		*
		
		if ((.not. SCRL_ON .and. .not. update) .or.	(SCRL_ON .and. update))
			
			*
			* Need to toggle
			*
			
			RET_VAL = 35
			
		else
			
			*
			* Scroll state correct
			*
			
			INIT_COUNT = 3
			@ b + 1, r - 44 say if(SCRL_ON, "S", " ")
			
		endif
		
	endif
	
	if INIT_COUNT = 3
		
		*
		* Set initial word wrap..always defaults ON
		*
		
		if .not. WORD_WRAP
			
			*
			* Need to toggle
			*
			
			RET_VAL = 34
			
		else
			
			*
			* Word wrap correct
			*
			
			INIT_COUNT = 4
			@ b + 1, r - 34 say if(WORD_WRAP, "W", " ")
			
		endif
		
	endif
	
	if INIT_COUNT = 4
		
		*
		* Finished initialization..note that if all defaults are
		*	correct we reach this point on the first call
		*
		
		RET_VAL = 0
		
	endif
	
	*
	* 1 - re-configurable or unknown keystroke (memo unaltered)
	* 2 - re-configurable or unknown keystroke (memo altered)
	*
	
otherwise
	
	*
	* Keystroke exception
	*
	
	KEYPRESS = lastkey()
	
	*
	* Save value in case resume edit
	*
	
	LINE_NUM = LINE
	COL_NUM = COL
	REL_LINE = row() - T - 1
	REL_COL = COL() - L - 1
	
	do case
		
		*
		* Ignore (disable) the following key
		*
		* ^B (reformat),
		* ^T (delete word right),
		* ^W (finish and save),
		* ^Y (delete line)
		*
		
	case KEYPRESS = 2 .or. KEYPRESS = 20 .or. KEYPRESS = 23 .or. KEYPRESS = 25
		RET_VAL = 32
		
		*
		* Alt-S..SEARCH
		*
		
	case KEYPRESS = 287
		save screen to MEMO_SCRN
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif

		store space(35) to SRCH_STR

		if LINE < 13
			@ 13,5 say  "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			@ 14,5 say  "บ                                                                บ Û"
			@ 15,5 say  "บ    Please enter the string you want to find.                   บ Û"
			@ 16,5 say  "บ                                                                บ Û"
			@ 17,5 say  "บ                                                                บ Û"
			@ 18,5 say  "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
			@ 19,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

			@ 16,10 say "string to search for" get SRCH_STR

			set confirm on
			read
			set confirm off
			clear gets

		else
			@ 5,5 say  "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			@ 6,5 say  "บ                                                                บ Û"
			@ 6,5 say  "บ    Please enter the string you want to find.                   บ Û"
			@ 7,5 say  "บ                                                                บ Û"
			@ 8,5 say  "บ                                                                บ Û"
			@ 9,5 say  "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
			@ 10,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

			@ 7,10 say "string to search for" get SRCH_STR

			set confirm on
			read
			set confirm off
			clear gets

		endif

		store trim(SRCH_STR) to SRCH_STR

		if COLOR_SCRN
			set color to w/b,w+/b,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		restore screen from MEMO_SCRN

		RET_VAL = 23
		RET_STATUS = 5

		*
		* Alt-U..SEARCH AND REPLACE
		*
		
	case KEYPRESS = 278
		save screen to MEMO_SCRN
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif

		store space(35) to SRCH_STR
		store space(35) to RPLCH_STR

		if LINE < 13
			@ 13,5 say  "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			@ 14,5 say  "บ                                                                 บ Û"
			@ 15,5 say  "บ    Please enter the string you want to replace.                 บ Û"
			@ 16,5 say  "บ                                                                 บ Û"
			@ 17,5 say  "บ    Please enter the string to replace string with               บ Û"
			@ 18,5 say  "บ                                                                 บ Û"
			@ 19,5 say  "บ                                                                 บ Û"
			@ 20,5 say  "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
			@ 21,5 say  " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

			@ 16,10 say "string to replace" get SRCH_STR
			@ 18,10 say "replace with" get RPLCH_STR

			set confirm on
			read
			set confirm off
			clear gets

		else
			@ 5,5 say  "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			@ 6,5 say  "บ                                                                บ Û"
			@ 6,5 say  "บ    Please enter the string your want to replace.               บ Û"
			@ 7,5 say  "บ                                                                บ Û"
			@ 8,5 say  "บ    Please enter the string to replace string with              บ Û"
			@ 9,5 say  "บ                                                                บ Û"
			@ 10,5 say "บ                                                                บ Û"
			@ 11,5 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
			@ 12,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

			@ 7,10 say "string to replace" get SRCH_STR
			@ 9,10 say "replace with" get RPLCH_STR

			set confirm on
			read
			set confirm off
			clear gets

		endif

		store trim(SRCH_STR) to SRCH_STR
		store trim(RPLCH_STR) to RPLCH_STR

		if COLOR_SCRN
			set color to w/b,w+/b,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		restore screen from MEMO_SCRN

		RET_VAL = 23
		RET_STATUS = 6

		*
		* Alt-M..SETUP LETTER MARGINS
		*
		
	case KEYPRESS = 306
		save screen to MEMO_SCRN

		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif

		do LAYOUT

		if COLOR_SCRN
			set color to w/b,w+/b,n,n
		else
			set color to w/n,w+/n,n,n
		endif

		restore screen from MEMO_SCRN

		RET_VAL = 23
		RET_STATUS = 8

		*
		* Alt-F..FETCH FILE
		*
		
	case KEYPRESS = 289
		save screen to MEMO_SCRN
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif

		store "10" to SELECT_NBR
		store "LTRDIR" to FILE_NAME
		store "LTRDIR" to ALIAS_NAME
		store "LTRDIR" to INDEX_NAME
		store "LTR_LNAME" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			do GFNAME
			
			@ 20,0
			
			if LTR_SEL
				if file(LTR_FNAME)
					store .t. to LTR_SEL
				
				else
					store 22 to STAT_LINE
					store "Could not open &LTR_NAME file" to STAT_MSG
					do status
				
					store 20 to PMT_LINE
					store "One moment please, adjusting letter directory." to PMT_MSG
					do prompt
				
					store "10" to SELECT_NBR
					store "LTRDIR" to FILE_NAME
					store "LTRDIR" to ALIAS_NAME
					store "LTRDIR" to INDEX_NAME
					store "LTR_LNAME" to IFLD_NAME
					do OPENFILE
				
					if FILE_OPEN
						seek LTR_NAME
						if .not. (eof() .or. bof())
							delete
							pack
						
						endif
					
						select LTRDIR
						use
					
					endif
				
					store .f. to LTR_SEL
				
					@ 20,0
				
				endif
			
			endif

		endif

		if COLOR_SCRN
			set color to w/b,w+/b,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		restore screen from MEMO_SCRN

		RET_VAL = 23
		RET_STATUS = 7
		
		*
		* Alt-E..WRITE FILE AND EXIT
		*
		
	case KEYPRESS = 274
		RET_VAL = 23
		RET_STATUS = 1

		*
		* Alt-W..WRITE FILE
		*
		
	case KEYPRESS = 273
		RET_VAL = 23
		RET_STATUS = 2
		
		*
		* Esc/Alt-X..EXIT
		*
		
	case KEYPRESS = 301 .or. KEYPRESS = 27
		@ b + 1, L say PAD("(Q)uit (R)esume", MSG_LEN)
		
		RESPONSE = " "
		do while .not. RESPONSE $ "QR"
			RESPONSE = upper(chr(inkey(0)))
			
		enddo
		
		@ b + 1, L say PAD("Editing letter " + upper(MEMONAME), MSG_LEN)
		
		do case
			
			*
			* Throw everthing away
			*
			
		case RESPONSE = "Q"
			RET_VAL = 27
			RET_STATUS = 0
			
			*
			* Continue editing
			*
			
		case RESPONSE = "R"
			RET_VAL = 32
			
		endcase
		
		*
		* Alt-H..display help
		*
		
	case KEYPRESS = 291
		save screen to MEMO_SCRN
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif											  
		
		@ 5,2  say "ษออออออออออออออออออ[ Edit Help : press ฤู when done ]ออออออออออออออออออป"
		@ 6,2  say "บ Use ,  to move up or down         Use " + chr(27) + ", " + chr(26) + " to move left or right    บ Û"
		@ 7,2  say "บ Use PgUp to page up                 Use PgDn to page down             บ Û"
		@ 8,2  say "บ Use Ctrl-PgUp to go to letter start Use Ctrl-PgDn to go to letter end บ Û"
		@ 9,2  say "บ Use Home to move to start of line   Use End to move to end of line    บ Û"
		@ 10,2 say "บ Use Ctrl-Home to move top of page   Use Ctrl-End to move end of page  บ Û"
		@ 11,2 say "บ Use Del to delete right             Use Backspace to delete left      บ Û"
		@ 12,2 say "บ Use Insert to toggle insert mode    Use Alt-P to print letter         บ Û"
		@ 13,2 say "บ Use Alt-R to delete line            Use Alt-I to insert line          บ Û"
		@ 14,2 say "บ Use Alt-T to toggle word wrap       Use Alt-M to set margins          บ Û"
		@ 15,2 say "บ Use Alt-U to update (search & rep.) Use Alt-S to search               บ Û"
		@ 16,2 say "บ Use Alt-V to select substitution    Use Alt-F to fetch another file   บ Û"
		@ 17,2 say "บ Use Alt-W to save letter            Use Alt-X or Esc to quit          บ Û"
		@ 18,2 say "บ                   Use Alt-E to save letter and exit                   บ Û"
		@ 19,2 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 20,2 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		store 1 to THE_KEY								  
		
		do while THE_KEY <> 13
			store inkey() to THE_KEY
			
		enddo
		
		if COLOR_SCRN
			set color to w/b,w+/b,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		restore screen from MEMO_SCRN
		
		*
		* Alt-V..select sustitution variables
		*
		
	case KEYPRESS = 303
		save screen to MEMO_SCRN
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif

		store "10" to SELECT_NBR
		store "VARIABLE" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE

		if FILE_OPEN
			do GVCHOICE

			RET_VAL = VCHOICE

			select 10
			use

			RET_VAL = 23
			RET_STATUS = 4

		endif

		if COLOR_SCRN
			set color to w/b,w+/b,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		restore screen from MEMO_SCRN

		*
		* Alt-P..Print letter
		*
		
	case KEYPRESS = 281
		RET_VAL = 23
		RET_STATUS = 3

		*
		* Alt-R..remove line
		*
		
	case KEYPRESS = 275
		RET_VAL = 25
		
		*
		* Alt-I..insert line
		*
		
	case KEYPRESS = 279
		RET_VAL = 14
		
		*
		* Alt-T..toggle word wrap
		*
		
	case KEYPRESS = 276 .and. update
		WORD_WRAP = .not. WORD_WRAP
		@ b + 1, r - 34 say if(WORD_WRAP, "W", " ")
		RET_VAL = 34
		
		*
		* Insert..toggle insert mode
		*
		
	case (KEYPRESS = 22) .and. update
		INS_ON = .not. INS_ON
		@ b + 1, r - 35 say if(INS_ON, "I", " ")
		RET_VAL = 22
		
	endcase
	
endcase

return RET_VAL

***********************************************************************
*                                      								  *
* GVCHOICE >>> Prompts the user to select the substitution variable   *
*	       entry : Open and selected schedule directory               *
*	       exit : VCHOICE                                   	      *
*									                                  *
***********************************************************************

procedure GVCHOICE

*
* Open window
*

@ 6,5  say "ษออออออออออออออ[ Press   to Select ฤู when Done ]ออออออออออออออป"
@ 7,5  say "บ                                                                 บ Û"
@ 8,5  say "บ                                                                 บ Û"
@ 9,5  say "บ                                                                 บ Û"
@ 10,5 say "บ                                                                 บ Û"
@ 11,5 say "บ                                                                 บ Û"
@ 12,5 say "บ                                                                 บ Û"
@ 13,5 say "บ                                                                 บ Û"
@ 14,5 say "บ                                                                 บ Û"
@ 15,5 say "บ                                                                 บ Û"
@ 16,5 say "บ                                                                 บ Û"
@ 17,5 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
@ 18,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

*
* Make sure the directory is not empty
*

store reccount() to CHOICE_CNT

if CHOICE_CNT > 0
	
	store 1 to CHOICE_PL

	goto CHOICE_PL
	
	*
	* Initialize variables
	*
	
	store 7 to CHOICE_R_1
	store space(65) to CHOICE_1
	store 8 to DESC_ROW_1
	store space(65) to DESC_1
	
	store 9 to CHOICE_R_2
	store space(65) to CHOICE_2
	store 10 to DESC_ROW_2
	store space(65) to DESC_2
	
	store 11 to CHOICE_R_3
	store space(65) to CHOICE_3
	store 12 to DESC_ROW_3
	store space(65) to DESC_3
	
	store 13 to CHOICE_R_4
	store space(65) to CHOICE_4
	store 14 to DESC_ROW_4
	store space(65) to DESC_4
	
	store 15 to CHOICE_R_5
	store space(65) to CHOICE_5
	store 16 to DESC_ROW_5
	store space(65) to DESC_5
	
	*
	* Get the Menu choice entries and place in the window variables
	*
	* Display Schdule Steps in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (CHOICE_PL - 2) > 0
		goto (CHOICE_PL - 2)
		store V_VCHOICE + space(35) to CHOICE_1
		store V_VPROMPT to DESC_1

	else
		store space(65) to CHOICE_1
		store space(65) to DESC_1
			
	endif
	
	if CHOICE_PL - 1 > 0
		goto CHOICE_PL - 1
		store V_VCHOICE + space(35) to CHOICE_2
		store V_VPROMPT to DESC_2
	else
		store space(65) to CHOICE_2
		store space(65) to DESC_2
			
	endif
	
	if CHOICE_PL > 0
		goto CHOICE_PL
		store V_VCHOICE + space(35) to CHOICE_3
		store V_VPROMPT to DESC_3

	endif
	
	if CHOICE_PL + 1 <= CHOICE_CNT
		goto CHOICE_PL + 1
		store V_VCHOICE + space(35) to CHOICE_4
		store V_VPROMPT to DESC_4
	else
		store space(65) to CHOICE_4
		store space(65) to DESC_4
		
	endif
	
	if CHOICE_PL + 2 <= CHOICE_CNT
		goto CHOICE_PL + 2
		store V_VCHOICE + space(35) to CHOICE_5
		store V_VPROMPT to DESC_5

	else
		store space(65) to CHOICE_5
		store space(65) to DESC_5
		
	endif
	
	@ CHOICE_R_1,6 say CHOICE_1
	@ DESC_ROW_1,6 say DESC_1
	@ CHOICE_R_2,6 say CHOICE_2
	@ DESC_ROW_2,6 say DESC_2
	
	@ CHOICE_R_4,6 say CHOICE_4
	@ DESC_ROW_4,6 say DESC_4
	@ CHOICE_R_5,6 say CHOICE_5
	@ DESC_ROW_5,6 say DESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ CHOICE_R_3,6 say CHOICE_3
	@ DESC_ROW_3,6 say DESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if CHOICE_PL <> 0
		goto CHOICE_PL
		
	endif
	
	*
	* Look for up arrow (), down arrow () or return key (ฤฤู)
	*
	
	store .t. to DO_MORE
	do while DO_MORE
		store inkey() to key
		
		if key <> 0
			do case
				
				*
				* Home
				*
				
			case key = 1 .or. key = 55
				store 1 to CHOICE_PL
					
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if CHOICE_PL - 5 > 1
					store CHOICE_PL - 5 to CHOICE_PL
						
				else
					store 1 to CHOICE_PL
						
				endif
					
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if CHOICE_PL > 1
					store CHOICE_PL - 1 to CHOICE_PL
						
				endif
					
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if CHOICE_PL < CHOICE_CNT
					store CHOICE_PL + 1 to CHOICE_PL
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if CHOICE_PL + 5 < CHOICE_CNT
					store CHOICE_PL + 5 to CHOICE_PL
					
				else
					store CHOICE_CNT to CHOICE_PL
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store CHOICE_CNT to CHOICE_PL
				
				*
				* RET KEY (ฤฤู) when DONE
				*
				
			case key = 13
				store .t. to CHOICE_SEL
				store .f. to DO_MORE
				
				goto CHOICE_PL
					
				store ltrim(trim(V_VCHOICE)) to VCHOICE
				store .t. to CHOICE_SEL
				
			endcase
			
			if (CHOICE_PL - 2) > 0
				goto (CHOICE_PL - 2)
				store V_VCHOICE + space(35) to CHOICE_1
				store V_VPROMPT to DESC_1

			else
				store space(65) to CHOICE_1
				store space(65) to DESC_1
				
			endif
			
			if CHOICE_PL - 1 > 0
				goto CHOICE_PL - 1
				store V_VCHOICE + space(35) to CHOICE_2
				store V_VPROMPT to DESC_2

			else
				store space(65) to CHOICE_2
				store space(65) to DESC_2
					
			endif
			
			if CHOICE_PL > 0
				goto CHOICE_PL
				store V_VCHOICE + space(35) to CHOICE_3
				store V_VPROMPT to DESC_3
				
			endif
			
			if CHOICE_PL + 1 <= CHOICE_CNT
				goto CHOICE_PL + 1
				store V_VCHOICE + space(35) to CHOICE_4
				store V_VPROMPT to DESC_4

			else
				store space(65) to CHOICE_4
				store space(65) to DESC_4

			endif
			
			if CHOICE_PL + 2 <= CHOICE_CNT
				goto CHOICE_PL + 2
				store V_VCHOICE + space(35) to CHOICE_5
				store V_VPROMPT to DESC_5

			else
				store space(65) to CHOICE_5
				store space(65) to DESC_5

			endif
			
			@ CHOICE_R_1,6 say CHOICE_1
			@ DESC_ROW_1,6 say DESC_1
			@ CHOICE_R_2,6 say CHOICE_2
			@ DESC_ROW_2,6 say DESC_2
			
			@ CHOICE_R_4,6 say CHOICE_4
			@ DESC_ROW_4,6 say DESC_4
			@ CHOICE_R_5,6 say CHOICE_5
			@ DESC_ROW_5,6 say DESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ CHOICE_R_3,6 say CHOICE_3
			@ DESC_ROW_3,6 say DESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if CHOICE_PL <> 0
				goto CHOICE_PL
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The variable file is empty" to STAT_MSG
	do status
	
	store .f. to CHOICE_SEL
	store space(3) to CHOICE_CHC
	store space(65) to VPROMPT
	
endif

return

***********************************************************************
*                                      								  *
* GFNAME >>> Prompts the user to select the letter from the letter dir*
*	       entry : Open and selected shedule directory                *
*	       exit : FTCH_FNAME                               		      *
*									                                  *
***********************************************************************

procedure GFNAME

*
* Open window
*

@ 6,5  say "ษออออออออออออออ[ Press   to Select ฤู when Done ]ออออออออออออออป"
@ 7,5  say "บ                                                                 บ Û"
@ 8,5  say "บ                                                                 บ Û"
@ 9,5  say "บ                                                                 บ Û"
@ 10,5 say "บ                                                                 บ Û"
@ 11,5 say "บ                                                                 บ Û"
@ 12,5 say "บ                                                                 บ Û"
@ 13,5 say "บ                                                                 บ Û"
@ 14,5 say "บ                                                                 บ Û"
@ 15,5 say "บ                                                                 บ Û"
@ 16,5 say "บ                                                                 บ Û"
@ 17,5 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
@ 18,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

*
* Make sure the directory is not empty
*

store reccount() to LTR_COUNT

if LTR_COUNT > 0
	store 1 to LTR_PLACE
	
	*
	* Initialize variables
	*
	
	store " letter" to LTR_PMT
	
	store 7 to NAME_ROW_1
	store space(65) to NAME_1
	store 8 to DESC_ROW_1
	store space(65) to DESC_1
	
	store 9 to NAME_ROW_2
	store space(65) to NAME_2
	store 10 to DESC_ROW_2
	store space(65) to DESC_2
	
	store 11 to NAME_ROW_3
	store space(65) to NAME_3
	store 12 to DESC_ROW_3
	store space(65) to DESC_3
	
	store 13 to NAME_ROW_4
	store space(65) to NAME_4
	store 14 to DESC_ROW_4
	store space(65) to DESC_4
	
	store 15 to NAME_ROW_5
	store space(65) to NAME_5
	store 16 to DESC_ROW_5
	store space(65) to DESC_5
	
	*
	* Get the Letter Directory entries and place in the window variables
	*
	* Display Letter Directory in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (LTR_PLACE - 2) > 0
		goto (LTR_PLACE - 2)
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_1
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_1
	else
		store space(65) to NAME_1
		store space(65) to DESC_1
		
	endif
	
	if LTR_PLACE - 1 > 0
		goto LTR_PLACE - 1
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_2
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_2
	else
		store space(65) to NAME_2
		store space(65) to DESC_2
		
	endif
	
	if LTR_PLACE > 0
		goto LTR_PLACE
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_3
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_3
		
	endif
	
	if LTR_PLACE + 1 <= LTR_COUNT
		goto LTR_PLACE + 1
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_4
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_4
	else
		store space(65) to NAME_4
		store space(65) to DESC_4
	endif
	
	if LTR_PLACE + 2 <= LTR_COUNT
		goto LTR_PLACE + 2
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_5
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_5
	else
		store space(65) to NAME_5
		store space(65) to DESC_5
	endif
	
	@ NAME_ROW_1,6 say NAME_1
	@ DESC_ROW_1,6 say DESC_1
	@ NAME_ROW_2,6 say NAME_2
	@ DESC_ROW_2,6 say DESC_2
	
	@ NAME_ROW_4,6 say NAME_4
	@ DESC_ROW_4,6 say DESC_4
	@ NAME_ROW_5,6 say NAME_5
	@ DESC_ROW_5,6 say DESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ NAME_ROW_3,6 say NAME_3
	@ DESC_ROW_3,6 say DESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if LTR_PLACE <> 0
		goto LTR_PLACE
		
	endif
	
	*
	* Look for up arrow (), down arrow () or return key (ฤฤู)
	*
	
	store .t. to DO_MORE
	do while DO_MORE
		store inkey() to key
		
		if key <> 0
			do case
				
				*
				* Home
				*
				
			case key = 1 .or. key = 55
				store 1 to LTR_PLACE
					
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if LTR_PLACE - 5 > 1
					store LTR_PLACE - 5 to LTR_PLACE
						
				else
					store 1 to LTR_PLACE
						
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if LTR_PLACE > 1
					store LTR_PLACE - 1 to LTR_PLACE
						
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if LTR_PLACE < LTR_COUNT
					store LTR_PLACE + 1 to LTR_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if LTR_PLACE + 5 < LTR_COUNT
					store LTR_PLACE + 5 to LTR_PLACE
					
				else
					store LTR_COUNT to LTR_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store LTR_COUNT to LTR_PLACE
				
				*
				* RET KEY (ฤฤู) when DONE
				*
				
			case key = 13
				
				*
				* If LTR_PLACE = 0 then a new letter name was
				* added, check to see if it's in the directory
				* if not check to see if it on disk, if it is
				* allow inform user and place in directory
				*
				
				goto LTR_PLACE
					
				store .f. to DO_MORE
				store .t. to LTR_SEL
				store LTR_LNAME to FTCH_NAME
				store "letter\" + LTR_LNAME + ".LTR" to FTCH_FNAME
					
			endcase
			
			if (LTR_PLACE - 2) > 0
				goto (LTR_PLACE - 2)
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_1
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_1
			else
				store space(65) to NAME_1
				store space(65) to DESC_1
					
			endif
			
			if LTR_PLACE - 1 > 0
				goto LTR_PLACE - 1
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_2
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_2
			else
				store space(65) to NAME_2
				store space(65) to DESC_2
				
			endif
			
			if LTR_PLACE > 0
				goto LTR_PLACE
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_3
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_3
				
			endif
			
			
			if LTR_PLACE + 1 <= LTR_COUNT
				goto LTR_PLACE + 1
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_4
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_4
			else
				store space(65) to NAME_4
				store space(65) to DESC_4
			endif
			
			if LTR_PLACE + 2 <= LTR_COUNT
				goto LTR_PLACE + 2
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_5
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_5
			else
				store space(65) to NAME_5
				store space(65) to DESC_5
			endif
			
			@ NAME_ROW_1,6 say NAME_1
			@ DESC_ROW_1,6 say DESC_1
			@ NAME_ROW_2,6 say NAME_2
			@ DESC_ROW_2,6 say DESC_2
			
			@ NAME_ROW_4,6 say NAME_4
			@ DESC_ROW_4,6 say DESC_4
			@ NAME_ROW_5,6 say NAME_5
			@ DESC_ROW_5,6 say DESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ NAME_ROW_3,6 say NAME_3
			@ DESC_ROW_3,6 say DESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if LTR_PLACE <> 0
				goto LTR_PLACE
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The letter directory is empty" to STAT_MSG
	do status
	
	store .f. to LTR_SEL
	store space(8) to LTR_LNAME
	store LTR_LNAME + "LTR" to LTR_FNAME
	
endif

return

*************************************************************************
*																	    *
* SETUPLTR >>> Setup the label format to print labels			        *
*	       entry : None												    *
*	       exit : Ranges for each variable                              *
*		   	Page size info ----------------------------------           *
*			 	"Number of columns across each page ................. " *
*					L_COLP (40-132)                                     *
*			 	"Number of rows (lines) down each page .............. " *
*					L_ROWP (20-66)                                      *
*				"Number of rows (lines) for top margin ..............." *
*					L_TSKP (0-60)                                       *
*			 	"Number of characters for left margin indentation ... " *
*					L_IDNT (0-60)                                       *
*			 	"Pause between pages ................................ " *
*					L_PSE (Yes/No)                                      *
*                                                                       *
*		   	Letter layout info -----------------------------------      *
*			 	"Number of characters across a letter ............... " *
*					L_COLT  (40-132)                                    *
*			 	"Number of rows (lines) down a letter ............... " *
*					L_ROWT (20-66)                                      *
*                                                                       *
*			Per client info --------------------------------------      *
*			 	"Number of letters to print for each client ......... " *
*					L_LPCLI (1-99)                                      *
*																	    *
*************************************************************************

procedure LAYOUT

store "1" to L_COL
store "continuous" to L_ROW
store "0 " to L_IDENT
store "0 " to L_TSKIP
store "NO " to L_PAUSE
store "35" to L_WIDTH
store "0 " to L_CBTWN
store "6 " to L_DEPTH
store "1 " to L_LBTWN
store "1 " to L_LPCLI

store "10" to SELECT_NBR
store "LTTRFMT" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN

	do READTF

	store "Number of columns of across each page ............ " to MENU_1
	store "Number of rows (lines) of down each page ......... " to MENU_2
	store "Number of characters for left margin indentation . " to MENU_3
	store "Number of rows (lines) for top margin ............ " to MENU_4
	store "Pause between pages .............................. " to MENU_5

	store "Number of characters across a letter ............. " to MENU_6
	store "Number of rows (lines) down a letter ............. " to MENU_7

	store "Number of letters to print for each client ....... " to MENU_8

	if val(L_COLP) > 132 .or. val(L_COLP) < 40
		store "80 " to L_COLP
	endif

	if val(L_ROWP) > 66 .or. val(L_ROWP) < 20
		store "66" to L_ROWP
	endif

	if val(L_TSKP) < 0 .or. val(L_TSKP) > 60
		store "3 " to L_TSKP
	endif

	if val(L_IDNT) < 0 .or. val(L_IDNT) > 99
		store "3 " to L_IDNT
	endif

	if L_PSE <> "YES" .and. L_PSE <> "NO "
		store "NO " to L_PSE
	endif

	if val(L_COLT) < 20 .or. val(L_COLT) > 132
		store "74 " to L_COLT
	endif

	if val(L_COLT) > val(L_COLP)
		store L_COLP to L_COLT
	endif

	if val(L_COLT) + val(L_IDNT) > val(L_COLP)
		store ltrim(str((val(L_COLP) - val(L_COLT)),2)) to L_IDNT
		store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
	endif

	if val(L_ROWT) < 20 .or. val(L_ROWT) > 66
		store "60 " to L_ROWT
	endif

	if val(L_ROWT) + 1 > val(L_ROWP)
		store ltrim(str((val(L_ROWP) - 1),2)) to L_ROWT
		store L_ROWT + space(2 - len(L_ROWT)) to L_ROWT
	endif

	if val(L_ROWT) + val(L_TSKP) + 1 > val(L_ROWP)
		store ltrim(str((val(L_ROWP) - (val(L_ROWT)+1)),2)) to L_TSKP
		store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
	endif

	if val(L_LPCLI) < 1 .or. val(L_LPCLI) > 99
		store "1 " to L_LPCLI
	endif

	@ 5,2  say "ษอออออออออออออออ[ Press   " + chr(27) + " " + chr(26) + " to Select ฤู when Done ]ออออออออออออออออป  "
	@ 6,2  say "บ                                                                        บ Û"
	@ 7,2  say "บ                                                                        บ Û"
	@ 8,2  say "บ                                                                        บ Û"
	@ 9,2  say "บ                                                                        บ Û"
	@ 10,2 say "บ                                                                        บ Û"
	@ 11,2 say "บ                                                                        บ Û"
	@ 12,2 say "บ                                                                        บ Û"
	@ 13,2 say "บ                                                                        บ Û"
	@ 14,2 say "บ                                                                        บ Û"
	@ 15,2 say "บ                                                                        บ Û"
	@ 16,2 say "บ                                                                        บ Û"
	@ 17,2 say "บ                                                                        บ Û"
	@ 18,2 say "บ                                                                        บ Û"
	@ 19,2 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
	@ 20,2 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

	@  7,4 say "Select the values for the page."
	@ 13,4 say "Select the values for the size of a text on the page."
	@ 16,4 say "Select the value for the number of letters per client."

	@ 17,10 say MENU_8 get L_LPCLI picture "XX"
	@ 15,10 say MENU_7 get L_ROWT picture "XX"
	@ 14,10 say MENU_6 get L_COLT picture "XXX"
	@ 12,10 say MENU_5 get L_PSE picture "XXX"
	@ 11,10 say MENU_4 get L_TSKP picture "XX"
	@ 10,10 say MENU_3 get L_IDNT picture "XX"
	@  9,10 say MENU_2 get L_ROWP picture "XX"
	@  8,10 say MENU_1 get L_COLP picture "XXX"
	clear gets

	store 1 to select
	store .t. to AGAIN
	store .f. to L_SEL
	store 1 to SELECTION
	do while AGAIN
		store inkey() to KEY
		if key <> 0
			do case

				*
				* Up Arrow () for UP
				*

				case key = 5 .or. key = 56
					if SELECTION > 1
						store SELECTION - 1 to SELECTION
					else
						store 8 to SELECTION
					endif

				*
				* Down Arrow () for DOWN
				*

				case key = 24 .or. key = 50
					if SELECTION < 8
						store SELECTION + 1 to SELECTION
					else
						store 1 to SELECTION
					endif

				*
				* RET KEY (ฤฤู) when DONE
				*

			case key = 13

					*
					* Save new values and exit
					*

					do WRITETF

					select 10
					use

					store .f. to AGAIN
					store .t. to L_SEL

					store .t. to PRINT_IT

				*
				* Del Key to CANCEL
				*

			case key = 7

					*
					* Reset original values and exit
					*

					do READTF

					select 10
					use

					store .f. to AGAIN
					store .f. to L_SEL

					store .f. to PRINT_IT

				*
				* Left Arrow (<-) to SELECTION previous value
				*

				case key = 19 .or. key = 52
					do case
						case SELECTION = 1
							if val(L_COLP) > 40
								store ltrim(str((val(L_COLP) - 1),3)) to L_COLP
								store L_COLP + space(3 - len(L_COLP)) to L_COLP

							else
								store "132" to L_COLP

							endif

							if val(L_COLP) < val(L_COLT)
								store L_COLP to L_COLT
							endif

							if val(L_COLT) + val(L_IDNT) > val(L_COLP)
								store ltrim(str((val(L_COLP) - val(L_COLT)),2)) to L_IDNT
								store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
							endif

						case SELECTION = 2
							if val(L_ROWP) > 20
								store ltrim(str((val(L_ROWP) - 1),2)) to L_ROWP
								store L_ROWP + space(2 - len(L_ROWP)) to L_ROWP

							else
								store "66" to L_ROWP

							endif

							if val(L_ROWT) >= val(L_ROWP)
								store ltrim(str((val(L_ROWP) - 1),2)) to L_ROWT
								store L_ROWT + space(2 - len(L_ROWT)) to L_ROWT
							endif

							if val(L_ROWT) + val(L_TSKP) + 1 > val(L_ROWP)
								store ltrim(str((val(L_ROWP) - (val(L_ROWT) + 1)),2)) to L_TSKP
								store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
							endif

						case SELECTION = 3
							if val(L_IDNT) > 0
								store ltrim(str((val(L_IDNT) - 1),2)) to L_IDNT
								store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
							else
								if val(L_COLT) + 132 <= val(L_COLP)
									store "132" to L_IDNT
								else
									store ltrim(str((val(L_COLP) - val(L_COLT)),3)) to L_IDNT
									store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
								endif

							endif

						case SELECTION = 4
							if val(L_TSKP) > 0
								store ltrim(str((val(L_TSKP) - 1),2)) to L_TSKP
								store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
							else
								if val(L_ROWT) + 66 <= val(L_ROWP)
									store "65" to L_TSKP
								else
									store ltrim(str((val(L_ROWP) - (val(L_ROWT)+1)),2)) to L_TSKP
									store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
								endif

							endif

						case SELECTION = 5
							if L_PSE = "YES"
								store "NO " to L_PSE
							else
								store "YES" to L_PSE
							endif

						case SELECTION = 6
							if val(L_COLT) > 40
								store ltrim(str((val(L_COLT) - 1),3)) to L_COLT
								store L_COLT + space(3 - len(L_COLT)) to L_COLT
							else
								if val(L_IDNT) + 132 <= val(L_COLP)
									store "132" to L_COLT
								else
									store ltrim(str((val(L_COLP) - val(L_IDNT)),3)) to L_COLT
									store L_COLT + space(3 - len(L_COLT)) to L_COLT

								endif

							endif

						case SELECTION = 7
							if val(L_ROWT) > 20
								store ltrim(str((val(L_ROWT) - 1),2)) to L_ROWT
								store L_ROWT + space(2 - len(L_ROWT)) to L_ROWT
							else
								if val(L_TSKP) + 66 <= val(L_ROWP)
									store "65" to L_ROWT
								else
									store ltrim(str((val(L_ROWP) - (val(L_TSKP)+1)),2)) to L_ROWT
									store L_ROWT + space(2 - len(L_ROWT)) to L_ROWT

								endif

							endif

						case SELECTION = 8
							if val(L_LPCLI) > 1
								store ltrim(str((val(L_LPCLI) - 1),2)) to L_LPCLI
								store L_LPCLI + space(2 - len(L_LPCLI)) to L_LPCLI
							else
								store "99" to L_LPCLI
							endif

					endcase

				*
				* Right Arrow (->) to SELECTION next value
				*

				case key = 4 .or. key = 54
					do case
						case SELECTION = 1
							if val(L_COLP) < 132
								store ltrim(str((val(L_COLP) + 1),3)) to L_COLP
								store L_COLP + space(3 - len(L_COLP)) to L_COLP
							else
								store "40 " to L_COLP
							endif

							if val(L_COLP) < val(L_COLT)
								store L_COLP to L_COLT
							endif

							if val(L_COLT) + val(L_IDNT) > val(L_COLP)
								store ltrim(str((val(L_COLP) - val(L_COLT)),2)) to L_IDNT
								store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
							endif

						case SELECTION = 2
							if val(L_ROWP) < 66
								store ltrim(str((val(L_ROWP) + 1),2)) to L_ROWP
								store L_ROWP + space(2 - len(L_ROWP)) to L_ROWP

							else
								store "20" to L_ROWP

							endif

							if val(L_ROWT) + 1 > val(L_ROWP)
								store ltrim(str((val(L_ROWP) - 1),2)) to L_ROWT
								store L_ROWT + space(2 - len(L_ROWT)) to L_ROWT
							endif

							if val(L_ROWT) + val(L_TSKP) > val(L_ROWP)
								store ltrim(str((val(L_ROWP) - (val(L_ROWT)+1)),2)) to L_TSKP
								store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
							endif

						case SELECTION = 3
							if val(L_COLT) + val(L_IDNT) < val(L_COLP)
								store ltrim(str((val(L_IDNT) + 1),2)) to L_IDNT
								store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
							else
								store "0 " to L_IDNT
							endif

						case SELECTION = 4
							if val(L_ROWT) + val(L_TSKP) + 1 < val(L_ROWP)
								store ltrim(str((val(L_TSKP) + 1),2)) to L_TSKP
								store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
							else
								store "0 " to L_TSKP
							endif

						case SELECTION = 5
							if L_PSE = "YES"
								store "NO " to L_PSE
							else
								store "YES" to L_PSE
							endif

						case SELECTION = 6
							if val(L_COLT) + val(L_IDNT) < val(L_COLP)
								store ltrim(str((val(L_COLT) + 1),3)) to L_COLT
								store L_COLT + space(3 - len(L_COLT)) to L_COLT
							else
								store "40 " to L_COLT
							endif

							if val(L_COLT) + val(L_IDNT) > val(L_COLP)
								store ltrim(str((val(L_COLP) - val(L_COLT)),2)) to L_IDNT
								store L_IDNT + space(2 - len(L_IDNT)) to L_IDNT
							endif

						case SELECTION = 7
							if val(L_ROWT) + val(L_TSKP) + 1 < val(L_ROWP)
								store ltrim(str((val(L_ROWT) + 1),2)) to L_ROWT
								store L_ROWT + space(2 - len(L_ROWT)) to L_ROWT
							else
								store "20" to L_ROWT
							endif

							if val(L_ROWT) + val(L_TSKP) + 1 > val(L_ROWP)
								store ltrim(str((val(L_ROWP) - (val(L_ROWT)+1)),2)) to L_TSKP
								store L_TSKP + space(2 - len(L_TSKP)) to L_TSKP
							endif

						case SELECTION = 8
							if val(L_LPCLI) < 99
								store ltrim(str((val(L_LPCLI) + 1),2)) to L_LPCLI
								store L_LPCLI + space(2 - len(L_LPCLI)) to L_LPCLI
							else
								store "1 " to L_LPCLI
							endif

					endcase

			endcase

			do case
				case SELECTION = 1
					@ 14,10 say MENU_6 get L_COLT picture "XXX"
					@ 10,10 say MENU_3 get L_IDNT picture "XX"
					@  8,10 say MENU_1 get L_COLP picture "XXX"

				case SELECTION = 2
					@ 15,10 say MENU_7 get L_ROWT picture "XX"
					@ 11,10 say MENU_4 get L_TSKP picture "XX"
	  				@ 9,10 say MENU_2 get L_ROWP picture "XX"

				case SELECTION = 3
					@  8,10 say MENU_1 get L_COLP picture "XXX"
					@ 10,10 say MENU_3 get L_IDNT picture "XX"

				case SELECTION = 4
	  				@ 9,10 say MENU_2 get L_ROWP picture "XX"
					@ 11,10 say MENU_4 get L_TSKP picture "XX"

				case SELECTION = 5
					@ 12,10 say MENU_5 get L_PSE picture "XXX"

				case SELECTION = 6
					@  8,10 say MENU_1 get L_COLP picture "XXX"
					@ 10,10 say MENU_3 get L_IDNT picture "XX"
					@ 14,10 say MENU_6 get L_COLT picture "XXX"

				case SELECTION = 7
	  				@ 9,10 say MENU_2 get L_ROWP picture "XX"
					@ 11,10 say MENU_4 get L_TSKP picture "XX"
					@ 15,10 say MENU_7 get L_ROWT picture "XX"

				case SELECTION = 8
					@ 17,10 say MENU_8 get L_LPCLI picture "XX"

			endcase

			clear gets

		endif

	enddo

endif

return

*: EOF: LTREDIT.PRG
