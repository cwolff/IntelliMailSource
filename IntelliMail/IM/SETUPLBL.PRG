*:*********************************************************************
*:
*:        Program: LBLSETUP.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 26-Mar-89 at 0:59 am
*:
*:      Called by: SENDMENU.PRG
*:
*:          Calls: READLF.PRG
*:				   WRITELF.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:***********************************************************************
*																	    *
* LBLSETUP >>> Setup the label format to print labels			        *
*	       entry : None												    *
*	       exit : Ranges for each variable                              *
*		   	Per label page info ----------------------------------      *
*			 	"Number of columns of labels across each page ....... " *
*					L_COL (1-5)                                         *
*			 	"Number of rows of labels down each page ............ " *
*					L_ROW (1-13) or "continuous"                        *
*				"Number of lines for top margin (single sheets only) ." *
*					L_TSKIP (0-60)                                      *
*			 	"Number of characters for left margin identation . "    *
*					L_IDENT (0-60)                                      *
*			 	"Pause between pages ................................ " *
*					L_PAUSE (Yes/No)                                    *
*                                                                       *
*		   	Per label info ---------------------------------------      *
*			 	"Number of characters across a label ................ " *
*					L_WIDTH (20-80)                                     *
*				"Number of characters between label columns ......... " *
*					L_CBTWN (0-60)                                      *
*			 	"Number of lines down a label ....................... " *
*					L_DEPTH (5-20)                                      *
*				"Number of lines between label rows ................. " *
*					L_LBTWN (0-60)								  	    *
*                                                                       *
*			Per client info --------------------------------------      *
*			 	"Number of labels to print for each client .......... " *
*					L_PERCLI (1-99)                                     *
*																	    *
*			PRINT_IT = .t. to print, .f. to cancel					    *
*                                                                       *
*************************************************************************

store "1" to L_COL
store "continuous" to L_ROW
store "0 " to L_IDENT
store "0 " to L_TSKIP
store "NO " to L_PAUSE
store "35" to L_WIDTH
store "0 " to L_CBTWN
store "6 " to L_DEPTH
store "1 " to L_LBTWN
store "1 " to L_PERCLI

store "10" to SELECT_NBR
store "LABELFMT" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store SEL_NAME to L_TAIL
	store "Select Return to STOP" to R_TAIL
	store "Press   " + chr(27) + " " + chr(26) + " Del to Select ฤู when Done" to R_TAIL
	do TAIL

	do READLF

	store "Number of columns of labels across each page ..... " to MENU_1
	store "Number of rows of labels down each page .......... " to MENU_2
	store "Number of characters for left margin indentation . " to MENU_3
	store "Number of lines for top margin ................... " to MENU_4
	store "Pause between pages .............................. " to MENU_5

	store "Number of characters across a label .............. " to MENU_6
	store "Number of characters between label columns ....... " to MENU_7
	store "Number of lines down a label ..................... " to MENU_8
	store "Number of lines between label rows ............... " to MENU_9

	store "Number of labels to print for each client ........ " to MENU_10

	if val(L_COL) > 5 .or. val(L_COL) < 1
		store "1" to L_COL
	endif

	if L_ROW <> "continuous"
		if val(L_ROW) > 99 .or. val(L_ROW) < 1
			store "continuous" to L_ROW
		endif
	endif

	if val(L_IDENT) < 0 .or. val(L_IDENT) > 99
		store "0 " to L_IDENT
	endif

	if L_PAUSE <> "YES" .and. L_PAUSE <> "NO "
		store "NO " to L_PAUSE
	endif

	if val(L_WIDTH) < 20 .or. val(L_WIDTH) > 99
		store "35" to L_WIDTH
	endif

	if val(L_CBTWN) < 0 .or. val(L_CBTWN) > 60
		store "1 " to L_CBTWN
	endif

	if val(L_DEPTH) < 5 .or. val(L_DEPTH) > 99
		store "6 " to L_DEPTH
	endif

	if val(L_LBTWN) < 0 .or. val(L_LBTWN) > 60
		store "1 " to L_LBTWN
	endif

	if val(L_PERCLI) < 1 .or. val(L_PERCLI) > 99
		store "1 " to L_PERCLI
	endif

	@ 5,3  say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
	@ 6,3  say "บ                                                                        บ Û"
	@ 7,3  say "บ                                                                        บ Û"
	@ 8,3  say "บ                                                                        บ Û"
	@ 9,3  say "บ                                                                        บ Û"
	@ 10,3 say "บ                                                                        บ Û"
	@ 11,3 say "บ                                                                        บ Û"
	@ 12,3 say "บ                                                                        บ Û"
	@ 13,3 say "บ                                                                        บ Û"
	@ 14,3 say "บ                                                                        บ Û"
	@ 15,3 say "บ                                                                        บ Û"
	@ 16,3 say "บ                                                                        บ Û"
	@ 17,3 say "บ                                                                        บ Û"
	@ 18,3 say "บ                                                                        บ Û"
	@ 19,3 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
	@ 20,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

	@  6,5 say "Select the values for the layout of the labels on a label page."
	@ 12,5 say "Select the values for the size of a label."
	@ 17,5 say "Select the value for the number of labels per client."

	@ 18,11 say MENU_10 get L_PERCLI picture "XX"
	if val(L_ROW) <> 1
		@ 16,11 say MENU_9 get L_LBTWN picture "XX"
	endif
	@ 15,11 say MENU_8 get L_DEPTH picture "XX"
	if val(L_COL) <> 1
		@ 14,11 say MENU_7 get L_CBTWN picture "XX"
	endif
	@ 13,11 say MENU_6 get L_WIDTH picture "XX"
	if L_ROW <> "continuous"
		@ 11,11 say MENU_5 get L_PAUSE picture "XXX"
		@ 10,11 say MENU_4 get L_TSKIP picture "XX"
	endif
	@  9,11 say MENU_3 get L_IDENT picture "XX"
	@  8,11 say MENU_2 get L_ROW picture "XXXXXXXXXXXX"
	@  7,11 say MENU_1 get L_COL picture "X"
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
						if SELECTION = 6
							if L_ROW <> "continuous"
								store SELECTION - 1 to SELECTION
							else
								store 3 to SELECTION
							endif
						else
							if SELECTION = 8
								if val(L_COL) = 1
									store 6 to SELECTION
								else
									store SELECTION - 1 to SELECTION
								endif
							else
								if SELECTION = 10
									if val(L_ROW) = 1
										store 8 to SELECTION
									else
										store SELECTION - 1 to SELECTION
									endif
								else
									store SELECTION - 1 to SELECTION
								endif
							endif
						endif
					else
						store 10 to SELECTION
					endif

				*
				* Down Arrow () for DOWN
				*

				case key = 24 .or. key = 50
					if SELECTION < 10
						if SELECTION = 3
							if L_ROW <> "continuous"
								store SELECTION + 1 to SELECTION
							else
								store 6 to SELECTION
							endif
						else
							if SELECTION = 6
								if val(L_COL) = 1
									store 8 to SELECTION
								else
									store SELECTION + 1 to SELECTION
								endif
							else
								if SELECTION = 8
									if val(L_ROW) = 1
										store 10 to SELECTION
									else
										store SELECTION + 1 to SELECTION
									endif
								else
									store SELECTION + 1 to SELECTION
								endif
							endif
						endif
					else
						store 1 to SELECTION
					endif

				*
				* RET KEY (ฤฤู) when DONE
				*

				case key = 13
					do WRITELF

					select 10
					use

					store .f. to AGAIN
					store .t. to L_SEL

					store .t. to PRINT_IT

				*
				* Del Key to CANCEL
				*

				case key = 7
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
							if val(L_COL) > 1
								store ltrim(str((val(L_COL) - 1),1)) to L_COL
								if val(L_COL) = 1
									store "0 " to L_CBTWN
								endif
							else
								store "5" to L_COL
							endif

						case SELECTION = 2
							do case
								case L_ROW = "continuous"
									store "13        " to L_ROW

								case val(L_ROW) > 1
									store ltrim(str((val(L_ROW) - 1),2)) to L_ROW
									store L_ROW + space(10 - len(L_ROW)) to L_ROW
									if val(L_ROW) = 1
										store "0 " to L_LBTWN
									endif

								case val(L_ROW) = 1
									store "continuous" to L_ROW

							endcase

						case SELECTION = 3
							if val(L_IDENT) > 0
								store ltrim(str((val(L_IDENT) - 1),2)) to L_IDENT
								store L_IDENT + space(2 - len(L_IDENT)) to L_IDENT
							else
								store "60" to L_IDENT
							endif

						case SELECTION = 4
							if val(L_TSKIP) > 0
								store ltrim(str((val(L_TSKIP) - 1),2)) to L_TSKIP
								store L_TSKIP + space(2 - len(L_TSKIP)) to L_TSKIP
							else
								store "60" to L_TSKIP
							endif

						case SELECTION = 5
							if L_PAUSE = "YES"
								store "NO " to L_PAUSE
							else
								store "YES" to L_PAUSE
							endif

						case SELECTION = 6
							if val(L_WIDTH) > 20
								store ltrim(str((val(L_WIDTH) - 1),2)) to L_WIDTH
								store L_WIDTH + space(2 - len(L_WIDTH)) to L_WIDTH
							else
								store "80" to L_WIDTH
							endif

						case SELECTION = 7
							if val(L_CBTWN) > 0
								store ltrim(str((val(L_CBTWN) - 1),2)) to L_CBTWN
								store L_CBTWN + space(2 - len(L_CBTWN)) to L_CBTWN
							else
								store "60" to L_CBTWN
							endif

						case SELECTION = 8
							if val(L_DEPTH) > 5
								store ltrim(str((val(L_DEPTH) - 1),2)) to L_DEPTH
								store L_DEPTH + space(2 - len(L_DEPTH)) to L_DEPTH
							else
								store "20" to L_DEPTH
							endif

						case SELECTION = 9
							if val(L_LBTWN) > 0
								store ltrim(str((val(L_LBTWN) - 1),2)) to L_LBTWN
								store L_LBTWN + space(2 - len(L_LBTWN)) to L_LBTWN
							else
								store "60" to L_LBTWN
							endif

						case SELECTION = 10
							if val(L_PERCLI) > 1
								store ltrim(str((val(L_PERCLI) - 1),2)) to L_PERCLI
								store L_PERCLI + space(2 - len(L_PERCLI)) to L_PERCLI
							else
								store "99" to L_PERCLI
							endif

					endcase

				*
				* Right Arrow (->) to SELECTION next value
				*

				case key = 4 .or. key = 54
					do case
						case SELECTION = 1
							if val(L_COL) < 5
								store ltrim(str((val(L_COL) + 1),1)) to L_COL
							else
								store "1" to L_COL
								store "0 " to L_CBTWN
							endif

						case SELECTION = 2
							do case
								case L_ROW = "continuous"
									store "1         " to L_ROW
									store "0 " to L_LBTWN

								case val(L_ROW) < 13
									store ltrim(str((val(L_ROW) + 1),2)) to L_ROW
									store L_ROW + space(10 - len(L_ROW)) to L_ROW

								case val(L_ROW) = 13
									store "continuous" to L_ROW

							endcase

						case SELECTION = 3
							if val(L_IDENT) < 60
								store ltrim(str((val(L_IDENT) + 1),2)) to L_IDENT
								store L_IDENT + space(2 - len(L_IDENT)) to L_IDENT
							else
								store " 0" to L_IDENT
							endif

						case SELECTION = 4
							if val(L_TSKIP) < 60
								store ltrim(str((val(L_TSKIP) + 1),2)) to L_TSKIP
								store L_TSKIP + space(2 - len(L_TSKIP)) to L_TSKIP
							else
								store "0 " to L_TSKIP
							endif

						case SELECTION = 5
							if L_PAUSE = "YES"
								store "NO " to L_PAUSE
							else
								store "YES" to L_PAUSE
							endif

						case SELECTION = 6
							if val(L_WIDTH) < 80
								store ltrim(str((val(L_WIDTH) + 1),2)) to L_WIDTH
								store L_WIDTH + space(2 - len(L_WIDTH)) to L_WIDTH
							else
								store "20" to L_WIDTH
							endif

						case SELECTION = 7
							if val(L_CBTWN) < 60
								store ltrim(str((val(L_CBTWN) + 1),2)) to L_CBTWN
								store L_CBTWN + space(2 - len(L_CBTWN)) to L_CBTWN
							else
								store "0 " to L_CBTWN
							endif

						case SELECTION = 8
							if val(L_DEPTH) < 20
								store ltrim(str((val(L_DEPTH) + 1),2)) to L_DEPTH
								store L_DEPTH + space(2 - len(L_DEPTH)) to L_DEPTH
							else
								store "5 " to L_DEPTH
							endif

						case SELECTION = 9
							if val(L_LBTWN) < 60
								store ltrim(str((val(L_LBTWN) + 1),2)) to L_LBTWN
								store L_LBTWN + space(2 - len(L_LBTWN)) to L_LBTWN
							else
								store "0 " to L_LBTWN
							endif

						case SELECTION = 10
							if val(L_PERCLI) < 99
								store ltrim(str((val(L_PERCLI) + 1),2)) to L_PERCLI
								store L_PERCLI + space(2 - len(L_PERCLI)) to L_PERCLI
							else
								store "1 " to L_PERCLI
							endif

					endcase

			endcase

			do case
				case SELECTION = 1
					if val(L_COL) = 1
						@ 14,11 say space(56)
					else
						@ 14,11 say MENU_7 get L_CBTWN picture "XX"
					endif

					@  7,11 say MENU_1 get L_COL picture "X"

				case SELECTION = 2
					if L_ROW = "continuous"
						@ 11,11 say space(57)
						@ 10,11 say space(56)
						@ 16,11 say MENU_9 get L_LBTWN picture "XX"
					else
						@ 11,11 say MENU_5 get L_PAUSE picture "XXX"
						@ 10,11 say MENU_4 get L_TSKIP picture "XX"
						if val(L_ROW) = 1
							@ 16,11 say space(56)
						else
							@ 16,11 say MENU_9 get L_LBTWN picture "XX"
						endif
					endif

					@ 8,11 say MENU_2 get L_ROW picture "XXXXXXXXXXXX"

				case SELECTION = 3
					@ 9,11 say MENU_3 get L_IDENT picture "XX"

				case SELECTION = 4
					@ 10,11 say MENU_4 get L_TSKIP picture "XX"

				case SELECTION = 5
					@ 11,11 say MENU_5 get L_PAUSE picture "XXX"

				case SELECTION = 6
					@ 13,11 say MENU_6 get L_WIDTH picture "XX"

				case SELECTION = 7
					@ 14,11 say MENU_7 get L_CBTWN picture "XX"

				case SELECTION = 8
					@ 15,11 say MENU_8 get L_DEPTH picture "XX"

				case SELECTION = 9
					@ 16,11 say MENU_9 get L_LBTWN picture "XX"

				case SELECTION = 10
					@ 18,11 say MENU_10 get L_PERCLI picture "XX"

			endcase

			clear gets

		endif

	enddo

endif

return
