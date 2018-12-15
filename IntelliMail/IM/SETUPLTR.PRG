*:*********************************************************************
*:
*:        Program: SETUPLTR.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 12-Mar-89 at 6:11 am
*:
*:      Called by: SENDMENU.PRG
*:
*:          Calls: READTF.PRG
*:				   WRITETF.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:***********************************************************************
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
	store SEL_NAME to L_TAIL
	store "Select Return to STOP" to R_TAIL
	store "Press   " + chr(27) + " " + chr(26) + " Del to Select ฤู when Done" to R_TAIL
	do TAIL

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

	@ 5,2  say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
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
