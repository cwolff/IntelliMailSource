*:*********************************************************************
*:
*:        Program: SENDMENU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 25-Mar-89 at 1:42 pm
*:
*:      Called by: IMMENU.PRG
*:
*:          Calls: FRAME            (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : AUTONEXT.PRG
*:               : READBUS          (procedure in UTILITY.PRG)
*:               : READCLI          (procedure in UTILITY.PRG)
*:               : SUBTEXT.PRG
*:               : READMRK          (procedure in UTILITY.PRG)
*:               : WRITEMRK         (procedure in UTILITY.PRG)
*:               : CHECKKEY         (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : DELDATA.PRG
*:
*:     Documented: 09/04/88 at 16:53               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SENDMENU >>> Create letter list for a schedule and advance steps    *
*            marked for automatic advancement.                        *
*            Print letters for letter list performing substitution    *
*            for global, client and clinic data.                      *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
*	ERR_FLAG		Error flag set                                    *
*																	  *
***********************************************************************

store .t. to REFRESH
store .t. to continue

store .f. to SCH_SEL
store "No schedule selected" to SEL_NAME

store 1 to CHOICE_SND

do while continue

	if REFRESH
		store "Sending Letters" to HEAD
		store SEL_NAME to L_TAIL
		store "Select Exit to STOP" to R_TAIL
		do FRAME
	else
		store SEL_NAME to L_TAIL
		store "Select Return to STOP" to R_TAIL
		do TAIL
	endif

	store CHOICE_SND to CHOICE
	store 8 to MENU_CNT
	store "Schedule" to MENU_1
	store "Select a schedule to print letters from" to DESC_1
	store "List" to MENU_2
	store "Prepare a list of letters to print from the selected schedule" to DESC_2
	store "Ltr_Alpha" to MENU_3
	store "Print letters from the prepared list in alphabetic order" to DESC_3
	store "Ltr_Bulk" to MENU_4
	store "Print letters from the prepared list in bulk mailing order" to DESC_4
	store "Lbl_Alpha" to MENU_5
	store "Print mailing labels from the prepared list in alphabetic order" to DESC_5
	store "Lbl_Bulk" to MENU_6
	store "Print mailing labels from the prepared list in bulk mailing order" to DESC_6
	store "Clear" to MENU_7
	store "Clear letters from the prepared list" to DESC_7
	store "Return" to MENU_8
	store "Return to the IntelliMail Main Menu" to DESC_8
	do menu

	store CHOICE to CHOICE_SND

	do case

		case CHOICE = 1
			do CLRSCRN

			*
			* Open Schdule Directory and initialize variables
			*

			store "6" to SELECT_NBR
			store "SCHDDIR" to FILE_NAME
			store "SCHDDIR" to ALIAS_NAME
			store "SCHDDIR" to INDEX_NAME
			store "SCHD_SNAME" to IFLD_NAME
			do OPENFILE

			if FILE_OPEN
				store 20 to PMT_LINE
				store "Select the schedule to prepare the mailing for " to PMT_MSG
				do prompt

				store 1 to REC_NBR
				store .f. to REC_ADD
				do GSNAME

				@ 20,0

				if SCH_SEL

					if file((SCH_FNAME + ".DBF"))
						store .t. to SCH_SEL

					else
						store 22 to STAT_LINE
						store "SORRY : " + SCH_SNAME + " not found" to STAT_MSG
						do status

						store 20 to PMT_LINE
						store "One moment please, adjusting schedule directory." to PMT_MSG
						do prompt

						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCH_SNAME" to IFLD_NAME
						do OPENFILE

						if FILE_OPEN
							seek SCH_SNAME
							if .not. (eof() .or. bof())
								delete
								pack

							endif

							select SCHDDIR
							use

						endif

						@ 20,0

						store .f. to SCH_SEL
						store "No schedule selected" to SCH_SNAME

					endif

				endif

			endif

			if SCH_SEL
				store "&SCH_SNAME schedule selected" to SEL_NAME
				store 2 to CHOICE_SND

				store SCH_SNAME + "ALP" to SCH_ALP
				store SCH_SNAME + "ZIP" to SCH_ZIP

			else
				store "No schedule selected" to SEL_NAME

			endif

			store .t. to REFRESH
			store .t. to continue

		case CHOICE = 2
			if SCH_SEL
				do CLRSCRN

				if file((SCH_LTTR + ".DBF"))
					@ 5,0

					@ 7,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
					@ 8,7  say "บ                                                                   บ Û"
					@ 9,7  say "บ                                                                   บ Û"
					@ 10,7 say "บ                                                                   บ Û"
					@ 11,7 say "บ                                                                   บ Û"
					@ 12,7 say "บ                                                                   บ Û"
					@ 13,7 say "บ                                                                   บ Û"
					@ 14,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
					@ 15,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

					@  9,9 say "The prepared letters list has not been cleared for this schedule."
					@ 10,9 say "If you have not printed the letters please do  so.  If  you  have"
					@ 11,9 say "printed the letters then you must  clear  the  list  before  you"
					@ 12,9 say "can create a new list."

					store 22 to STAT_LINE
					store "ATTENTION : Please read the above" to STAT_MSG
					do status

					store 7 to CHOICE_SND

					do CLRSCRN

				else
					store SEL_NAME to L_TAIL
					store "Press Del to escape loops" to R_TAIL
					do TAIL

					do AUTONEXT

					store 22 to STAT_LINE
					store "Finished preparing &SCH_SNAME list" to STAT_MSG
					do status

					store 3 to CHOICE_SND

				endif

			else
				store 22 to STAT_LINE
				store "You must first select a schedule" to STAT_MSG
				do status

				store 1 to CHOICE_SND

				store .t. to continue
				store .f. to REFRESH

			endif

		case CHOICE = 3
			if SCH_SEL
				do CLRSCRN

				do SETUPLTR

				if PRINT_IT
					do CLRSCRN

					if file(("LTTRFMT" + ".DBF"))
						store "10" to SELECT_NBR
						store "LTTRFMT" to FILE_NAME
						store "WORK" to ALIAS_NAME
						store "" to INDEX_NAME
						store "" to IFLD_NAME
						do OPENFILE

						if FILE_OPEN

							do READTF

							@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
							@ 6,7  say "บ                                                                   บ Û"
							@ 7,7  say "บ                                                                   บ Û"
							@ 8,7  say "บ                                                                   บ Û"
							@ 9,7  say "บ                                                                   บ Û"
							@ 10,7 say "บ                                                                   บ Û"
							@ 11,7 say "บ                                                                   บ Û"
							@ 12,7 say "บ                                                                   บ Û"
							@ 13,7 say "บ                                                                   บ Û"
							@ 14,7 say "บ                                                                   บ Û"
							@ 15,7 say "บ                                                                   บ Û"
							@ 16,7 say "บ                                                                   บ Û"
							@ 17,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
							@ 18,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

							store "Printing letters for " + SCH_SNAME + " schedule" to L_TAIL
							store "Press Del to CANCEL" to R_TAIL
							do TAIL

							store 7 to PMT_LINE
							store "Printing client letters from the prepared list." to PMT_MSG
							do prompt

							store 8 to PMT_LINE
							store "Opening client prepared list of letters to print." to PMT_MSG
							do prompt

							if file((SCH_LTTR + ".DBF"))
								store "10" to SELECT_NBR
								store SCH_LTTR to FILE_NAME
								store "LTTR" to ALIAS_NAME
								store "" to INDEX_NAME
								store "" to IFLD_NAME
								do OPENFILE

								if FILE_OPEN

									*
									* Organize labels in alphabetic order
									*

									if .not. file((SCH_ALP + ".NTX"))
										store 20 to PMT_LINE
										store "Organizing list of client letters to print in alphabetic order." to PMT_MSG
										do prompt

										index on L_LST_N + L_FST_N to &SCH_ALP

										@ 20,0

									endif

									set index to &SCH_ALP

									store 9 to PMT_LINE
									store "Reading clinic profile information."	to PMT_MSG
									do prompt

									store "1" to SELECT_NBR
									store "BUSINESS" to FILE_NAME
									store "WORK" to ALIAS_NAME
									store "" to INDEX_NAME
									store "" to IFLD_NAME
									do OPENFILE

									if FILE_OPEN
										do READBUS

										select WORK
										use

										store "2" to SELECT_NBR
										store "CLIENT" to FILE_NAME
										store "CLIENT" to ALIAS_NAME
										store "CLINBR" to INDEX_NAME
										store "C_CLI_NBR" to IFLD_NAME
										do OPENFILE

										if FILE_OPEN
											store "4" to SELECT_NBR
											store "MARKER" to FILE_NAME
											store "MARKER" to ALIAS_NAME
											store "MARKER" to INDEX_NAME
											store "M_MRK_NBR" to IFLD_NAME
											do OPENFILE

											if FILE_OPEN
												select LTTR

												store ltrim(str(reccount())) to LTR_TOT

												store 1 to LTR_NBR
												store 1 to CHOICE

												do while .not. (eof() .or. bof()) .and. (CHOICE <> 0)
													@ 12,8 say space(67)
													@ 13,8 say space(67)
													@ 14,8 say space(67)
													@ 15,8 say space(67)

													store ltrim(str(LTR_NBR)) to LTR_CNT

													store 10 to PMT_LINE
													store "Reading prepared list file for letter number ... " + LTR_CNT + " of " + LTR_TOT to PMT_MSG
													do prompt

													store trim(L_LTTR_NO) to LTTR_NO
													store upper(trim(L_LTTR_TOS)) to LTTR_TOS

													*
													* Check to see if this client has
													* a letter to send
													*

													if LTTR_TOS <> "NOLETTER"
														store "LETTER\" + LTTR_TOS + ".LTR" to CUR_LETTER

														select CLIENT

														store 11 to PMT_LINE
														store "Searching client file for client number ... " + LTTR_NO to PMT_MSG
														do prompt

														seek LTTR_NO

														if .not. (eof() .or. bof())
															store 12 to PMT_LINE
															store "Reading client profile for " + trim(C_FST_N) + " " + trim(C_LST_N) to PMT_MSG
															do prompt

															do READCLI

															store 13 to PMT_LINE
															store "Searching for letter &LTTR_TOS" to PMT_MSG
															do prompt

															if file(CUR_LETTER)
																store 14 to PMT_LINE
																store "Preparing letter &LTTR_TOS" to PMT_MSG
																do prompt

																USR_MEMO = memoread(CUR_LETTER)

																if len(USR_MEMO) > 0
																	store 15 to PMT_LINE
																	store "Currently printing the letter &LTTR_TOS" to PMT_MSG
																	do prompt

																	do PRINTLTR

																else
																	select MARKER

																	seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

																	if .not. (eof() .or. bof())

																		*
																		* 03 = Letter file empty
																		*

																		store .f. to READ_ERROR
																		do READMRK

																		store "The &LTTR_TOS letter is empty" to ERR_MSG
																		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
																		store "03" to ERR_FLAG
																		do WRITEMRK

																	endif

																endif

															else
																select MARKER

																seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

																if .not. (eof() .or. bof())

																	*
																	* 02 = Letter not found
																	*

																	store .f. to READ_ERROR
																	do READMRK

																	store "Could not find the &LTTR_TOS letter" to ERR_MSG
																	store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
																	store "02" to ERR_FLAG
																	do WRITEMRK

																endif

															endif

														else
															select MARKER

															seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

															if .not. (eof() .or. bof())

																*
																* 01 = Client not found
																*

																store .f. to READ_ERROR
																do READMRK

																store "Could not find the client information" to ERR_MSG
																store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
																store "01" to ERR_FLAG
																do WRITEMRK

															endif

														endif

													endif

													select LTTR
													skip

													store LTR_NBR + 1 to LTR_NBR

													do CHECKKEY

												enddo

												set device to print
												eject
												set device to screen

												store 22 to STAT_LINE
												store "Finished printing letters from &SCH_SNAME list" to STAT_MSG
												do status

												select CLIENT
												use

												select MARKER
												use

												select LTTR
												use

												store 4 to CHOICE_SND

											else
												store 22 to STAT_LINE
												store "Could not open MARKER file" to STAT_MSG
												do status

											endif

										else
											store 22 to STAT_LINE
											store "Could not open CLIENT file" to STAT_MSG
											do status

										endif

									else
										store 22 to STAT_LINE
										store "Could not open BUSINESS file" to STAT_MSG
										do status

									endif

								else
									store 22 to STAT_LINE
									store "Could not open &SCH_LTTR file" to STAT_MSG
									do status

								endif

							else
								store 22 to STAT_LINE
								store "You must first prepare the list of letters" to STAT_MSG
								do status

								store 2 to CHOICE_SND

							endif

							store .t. to continue
							store .t. to REFRESH

						else
							store 22 to STAT_LINE
							store "Could not open LTTRFMT file" to STAT_MSG
							do status

						endif

					else
						store 22 to STAT_LINE
						store "Could not find LTTRFMT file" to STAT_MSG
						do status

					endif

				endif

			else
				store 22 to STAT_LINE
				store "You must first select a schedule" to STAT_MSG
				do status

				store 1 to CHOICE_SND

				store .t. to continue
				store .f. to REFRESH

			endif

		case CHOICE = 4
			if SCH_SEL
				do CLRSCRN

				do SETUPLTR

				if PRINT_IT
					do CLRSCRN

					if file(("LTTRFMT" + ".DBF"))
						store "10" to SELECT_NBR
						store "LTTRFMT" to FILE_NAME
						store "WORK" to ALIAS_NAME
						store "" to INDEX_NAME
						store "" to IFLD_NAME
						do OPENFILE

						if FILE_OPEN

							do READTF

							@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
							@ 6,7  say "บ                                                                   บ Û"
							@ 7,7  say "บ                                                                   บ Û"
							@ 8,7  say "บ                                                                   บ Û"
							@ 9,7  say "บ                                                                   บ Û"
							@ 10,7 say "บ                                                                   บ Û"
							@ 11,7 say "บ                                                                   บ Û"
							@ 12,7 say "บ                                                                   บ Û"
							@ 13,7 say "บ                                                                   บ Û"
							@ 14,7 say "บ                                                                   บ Û"
							@ 15,7 say "บ                                                                   บ Û"
							@ 16,7 say "บ                                                                   บ Û"
							@ 17,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
							@ 18,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

							store "Printing letters for " + SCH_SNAME + " schedule" to L_TAIL
							store "Press Del to CANCEL" to R_TAIL
							do TAIL

							store 7 to PMT_LINE
							store "Printing client letters from the prepared list." to PMT_MSG
							do prompt

							store 8 to PMT_LINE
							store "Opening client prepared list of letters to print." to PMT_MSG
							do prompt

							if file((SCH_LTTR + ".DBF"))
								store "10" to SELECT_NBR
								store SCH_LTTR to FILE_NAME
								store "LTTR" to ALIAS_NAME
								store "" to INDEX_NAME
								store "" to IFLD_NAME
								do OPENFILE

								if FILE_OPEN

									*
									* Organize labels in bulk mailing order
									*

									if .not. file((SCH_ZIP + ".NTX"))
										store 20 to PMT_LINE
										store "Organizing list of client letters to print in bulk mailing order." to PMT_MSG
										do prompt

										index on L_ZIP + L_LST_N + L_FST_N to &SCH_ZIP

										@ 20,0

									endif

									set index to &SCH_ZIP

									store 9 to PMT_LINE
									store "Reading clinic profile information."	to PMT_MSG
									do prompt

									store "1" to SELECT_NBR
									store "BUSINESS" to FILE_NAME
									store "WORK" to ALIAS_NAME
									store "" to INDEX_NAME
									store "" to IFLD_NAME
									do OPENFILE

									if FILE_OPEN
										do READBUS

										select WORK
										use

										store "2" to SELECT_NBR
										store "CLIENT" to FILE_NAME
										store "CLIENT" to ALIAS_NAME
										store "CLINBR" to INDEX_NAME
										store "C_CLI_NBR" to IFLD_NAME
										do OPENFILE

										if FILE_OPEN
											store "4" to SELECT_NBR
											store "MARKER" to FILE_NAME
											store "MARKER" to ALIAS_NAME
											store "MARKER" to INDEX_NAME
											store "M_MRK_NBR" to IFLD_NAME
											do OPENFILE

											if FILE_OPEN
												select LTTR

												store ltrim(str(reccount())) to LTR_TOT

												store 1 to LTR_NBR
												store 1 to CHOICE

												do while .not. (eof() .or. bof()) .and. (CHOICE <> 0)
													@ 12,8 say space(67)
													@ 13,8 say space(67)
													@ 14,8 say space(67)
													@ 15,8 say space(67)

													store ltrim(str(LTR_NBR)) to LTR_CNT

													store 10 to PMT_LINE
													store "Reading prepared list file for letter number ... " + LTR_CNT + " of " + LTR_TOT to PMT_MSG
													do prompt

													store trim(L_LTTR_NO) to LTTR_NO
													store upper(trim(L_LTTR_TOS)) to LTTR_TOS

													*
													* Check to see if this client has
													* a letter to send
													*

													if LTTR_TOS <> "NOLETTER"
														store "LETTER\" + LTTR_TOS + ".LTR" to CUR_LETTER

														select CLIENT

														store 11 to PMT_LINE
														store "Searching client file for client number ... " + LTTR_NO to PMT_MSG
														do prompt

														seek LTTR_NO

														if .not. (eof() .or. bof())
															store 12 to PMT_LINE
															store "Reading client profile for " + trim(C_FST_N) + " " + trim(C_LST_N) to PMT_MSG
															do prompt

															do READCLI

															store 13 to PMT_LINE
															store "Searching for letter &LTTR_TOS" to PMT_MSG
															do prompt

															if file(CUR_LETTER)
																store 14 to PMT_LINE
																store "Preparing letter &LTTR_TOS" to PMT_MSG
																do prompt

																USR_MEMO = memoread(CUR_LETTER)

																if len(USR_MEMO) > 0
																	store 15 to PMT_LINE
																	store "Currently printing the letter &LTTR_TOS" to PMT_MSG
																	do prompt

																	do PRINTLTR

																else
																	select MARKER

																	seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

																	if .not. (eof() .or. bof())

																		*
																		* 03 = Letter file empty
																		*

																		store .f. to READ_ERROR
																		do READMRK

																		store "The &LTTR_TOS letter is empty" to ERR_MSG
																		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
																		store "03" to ERR_FLAG
																		do WRITEMRK

																	endif

																endif

															else
																select MARKER

																seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

																if .not. (eof() .or. bof())

																	*
																	* 02 = Letter not found
																	*

																	store .f. to READ_ERROR
																	do READMRK

																	store "Could not find the &LTTR_TOS letter" to ERR_MSG
																	store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
																	store "02" to ERR_FLAG
																	do WRITEMRK

																endif

															endif

														else
															select MARKER

															seek trim(trim(LTTR_NO) + trim(SCH_SNAME))

															if .not. (eof() .or. bof())

																*
																* 01 = Client not found
																*

																store .f. to READ_ERROR
																do READMRK

																store "Could not find the client information" to ERR_MSG
																store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
																store "01" to ERR_FLAG
																do WRITEMRK

															endif

														endif

													endif

													select LTTR
													skip

													store LTR_NBR + 1 to LTR_NBR

													do CHECKKEY

												enddo

												set device to print
												eject
												set device to screen

												store 22 to STAT_LINE
												store "Finished printing letters from &SCH_SNAME list" to STAT_MSG
												do status

												select CLIENT
												use

												select MARKER
												use

												select LTTR
												use

												store 4 to CHOICE_SND

											else
												store 22 to STAT_LINE
												store "Could not open MARKER file" to STAT_MSG
												do status

											endif

										else
											store 22 to STAT_LINE
											store "Could not open CLIENT file" to STAT_MSG
											do status

										endif

									else
										store 22 to STAT_LINE
										store "Could not open BUSINESS file" to STAT_MSG
										do status

									endif

								else
									store 22 to STAT_LINE
									store "Could not open &SCH_LTTR file" to STAT_MSG
									do status

								endif

							else
								store 22 to STAT_LINE
								store "You must first prepare the list of letters" to STAT_MSG
								do status

								store 2 to CHOICE_SND

							endif

							store .t. to continue
							store .t. to REFRESH

						else
							store 22 to STAT_LINE
							store "Could not open LTTRFMT file" to STAT_MSG
							do status

						endif

					else
						store 22 to STAT_LINE
						store "Could not find LTTRFMT file" to STAT_MSG
						do status

					endif

				endif

			else
				store 22 to STAT_LINE
				store "You must first select a schedule" to STAT_MSG
				do status

				store 1 to CHOICE_SND

				store .t. to continue
				store .f. to REFRESH

			endif

		case CHOICE = 5
			if SCH_SEL
				do CLRSCRN

				do SETUPLBL

				if PRINT_IT
					do CLRSCRN

					store SEL_NAME to L_TAIL
					store "Select Return to STOP" to R_TAIL
					do TAIL

					@ 7,3  say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
					@ 8,3  say "บ                                                                        บ Û"
					@ 9,3  say "บ                                                                        บ Û"
					@ 10,3 say "บ                                                                        บ Û"
					@ 11,3 say "บ                                                                        บ Û"
					@ 12,3 say "บ                                                                        บ Û"
					@ 13,3 say "บ                                                                        บ Û"
					@ 14,3 say "บ                                                                        บ Û"
					@ 15,3 say "บ                                                                        บ Û"
					@ 16,3 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
					@ 17,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

					if file((SCH_LTTR + ".DBF"))
						store "10" to SELECT_NBR
						store SCH_LTTR to FILE_NAME
						store "LTTR" to ALIAS_NAME
						store "" to INDEX_NAME
						store "" to IFLD_NAME
						do OPENFILE

						if FILE_OPEN

							*
							* Organize labels in alphabetic order
							*

							if .not. file((SCH_ALP + ".NTX"))
								store 20 to PMT_LINE
								store "Organizing list of client labels to print in alphabetic order." to PMT_MSG
								do prompt

								index on L_LST_N + L_FST_N to &SCH_ALP

								@ 20,0

							endif

							set index to &SCH_ALP

							store SCH_SNAME + " schedule selected" to L_TAIL
							store "Press Del to CANCEL" to R_TAIL
							do TAIL

							store 9 to PMT_LINE
							store "Printing client mailing labels from the prepared list." to PMT_MSG
							do prompt

							store 10 to PMT_LINE
							store "Opening client prepared list of labels to print." to PMT_MSG
							do prompt

							store "2" to SELECT_NBR
							store "CLIENT" to FILE_NAME
							store "CLIENT" to ALIAS_NAME
							store "CLINBR" to INDEX_NAME
							store "C_CLI_NBR" to IFLD_NAME
							do OPENFILE

							if FILE_OPEN
								select LTTR

								store ltrim(str(reccount())) to LTR_TOT

								*
								* Determine if we are to skip number of first lines
								*

								if L_ROW <> "continuous"
									if val(L_TSKIP) > 0
										set console off
										set print on

										store 0 to LINE_FILL
										do while ((LINE_FILL) < val(L_TSKIP))
											?
											store LINE_FILL + 1 to LINE_FILL

										enddo

										set print off
										set console on

									endif

								endif

								store 1 to LTR_NBR
								store 1 to ROW_COUNT

								do while .not. (eof() .or. bof())
									store 0 to UPCOUNT

									store "" to LABEL_L1
									store "" to LABEL_L2
									store "" to LABEL_L3
									store "" to LABEL_L4
									store "" to LABEL_L5
									store "" to LABEL_L6
									store "" to LABEL_L7

									*
									* If more than one label per row continue
									*

									do while .not. (eof() .or. bof()) .and. UPCOUNT < val(L_COL)
										@ 13,8 say space(67)
										@ 14,8 say space(67)

										store ltrim(str(LTR_NBR)) to LTR_CNT

										store 11 to PMT_LINE
										store "Reading prepared list file for label number ... " + LTR_CNT + " of " + LTR_TOT to PMT_MSG
										do prompt

										store trim(L_LTTR_NO) to LTTR_NO

										select CLIENT

										store 12 to PMT_LINE
										store "Searching client file for client number ... " + LTTR_NO to PMT_MSG
										do prompt

										seek LTTR_NO

										if .not. (eof() .or. bof())
											store 13 to PMT_LINE
											store "Reading client profile for " + trim(C_FST_N) + " " + trim(C_LST_N) to PMT_MSG
											do prompt

											do READCLI

											do FMTLABEL

											*
											* Don't pad between labels if this is the
											* last label
											*

											if UPCOUNT = val(L_COL) - 1
												store LABEL_L1 + LINE_1 to LABEL_L1
												store LABEL_L2 + LINE_2 to LABEL_L2
												store LABEL_L3 + LINE_3 to LABEL_L3
												store LABEL_L4 + LINE_4 to LABEL_L4
												store LABEL_L5 + LINE_5 to LABEL_L5
												store LABEL_L6 + LINE_6 to LABEL_L6
												store LABEL_L7 + LINE_7 to LABEL_L7

											else
												store LABEL_L1 + LINE_1 + space(val(L_CBTWN)) to LABEL_L1
												store LABEL_L2 + LINE_2 + space(val(L_CBTWN)) to LABEL_L2
												store LABEL_L3 + LINE_3 + space(val(L_CBTWN)) to LABEL_L3
												store LABEL_L4 + LINE_4 + space(val(L_CBTWN)) to LABEL_L4
												store LABEL_L5 + LINE_5 + space(val(L_CBTWN)) to LABEL_L5
												store LABEL_L6 + LINE_6 + space(val(L_CBTWN)) to LABEL_L6
												store LABEL_L7 + LINE_7 + space(val(L_CBTWN)) to LABEL_L7

											endif

											store UPCOUNT + 1 to UPCOUNT

										endif

										store LTR_NBR + 1 to LTR_NBR

										select LTTR

										skip

									enddo

									store 14 to PMT_LINE
									store "Printing client(s) mailing labels" to PMT_MSG
									do prompt

									do PRINTLBL

									do CHECKKEY

								enddo

								if L_ROW <> "continuous"
									set console off
									set print on

									eject

									set print off
									set console on

								endif

								store 22 to STAT_LINE
								store "Finished printing labels from &SCH_SNAME list" to STAT_MSG
								do status

							endif

							select CLIENT
							use

							select LTTR
							use

							store 1 to CHOICE_SND

						else
							store 22 to STAT_LINE
							store "Could not open &SCH_LTTR file" to STAT_MSG
							do status

						endif

					else
						store 22 to STAT_LINE
						store "You must first prepare the list of letters" to STAT_MSG
						do status

					endif

				endif

			else
				store 22 to STAT_LINE
				store "You must first select a schedule" to STAT_MSG
				do status

				store 1 to CHOICE_SND

			endif

			do CLRSCRN

			store .t. to continue
			store .t. to REFRESH

		case CHOICE = 6
			if SCH_SEL
				do CLRSCRN

				do SETUPLBL

				if PRINT_IT
					do CLRSCRN

					store SEL_NAME to L_TAIL
					store "Select Return to STOP" to R_TAIL
					do TAIL

					@ 7,3  say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
					@ 8,3  say "บ                                                                        บ Û"
					@ 9,3  say "บ                                                                        บ Û"
					@ 10,3 say "บ                                                                        บ Û"
					@ 11,3 say "บ                                                                        บ Û"
					@ 12,3 say "บ                                                                        บ Û"
					@ 13,3 say "บ                                                                        บ Û"
					@ 14,3 say "บ                                                                        บ Û"
					@ 15,3 say "บ                                                                        บ Û"
					@ 16,3 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
					@ 17,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

					if file((SCH_LTTR + ".DBF"))
						store "10" to SELECT_NBR
						store SCH_LTTR to FILE_NAME
						store "LTTR" to ALIAS_NAME
						store "" to INDEX_NAME
						store "" to IFLD_NAME
						do OPENFILE

						if FILE_OPEN

							*
							* Organize labels in bulk mailing order
							*

							if .not. file((SCH_ZIP + ".NTX"))
								store 20 to PMT_LINE
								store "Organizing list of client labels to print in bulk mailing order." to PMT_MSG
								do prompt

								index on L_ZIP + L_LST_N + L_FST_N to &SCH_ZIP

								@ 20,0

							endif

							set index to &SCH_ZIP

							store SCH_SNAME + " schedule selected" to L_TAIL
							store "Press Del to CANCEL" to R_TAIL
							do TAIL

							store 9 to PMT_LINE
							store "Printing client mailing labels from the prepared list." to PMT_MSG
							do prompt

							store 10 to PMT_LINE
							store "Opening client prepared list of labels to print." to PMT_MSG
							do prompt

							store "2" to SELECT_NBR
							store "CLIENT" to FILE_NAME
							store "CLIENT" to ALIAS_NAME
							store "CLINBR" to INDEX_NAME
							store "C_CLI_NBR" to IFLD_NAME
							do OPENFILE

							if FILE_OPEN
								select LTTR

								store ltrim(str(reccount())) to LTR_TOT

								store 1 to LTR_NBR
								store 1 to ROW_COUNT

								store .F. to REPORT_ZIP

								*
								* Determine if we are to skip number of first lines
								*

								if L_ROW <> "continuous"
									if val(L_TSKIP) <> 0
										store 0 to LINE_FILL
										store 0 to LINE_FILL
										do while ( (LINE_FILL) < val(L_TSKIP))
											?
											store LINE_FILL + 1 to LINE_FILL

										enddo

									endif

								endif

								store 1 to ZIP_CNT
								store 1 to ZIP_TOTAL
								store 1 to BATCH_CNT
								store 1 to BATCH_TOTAL

								store 1 to LTR_NBR
								store 1 to ROW_COUNT

								do while .not. (eof() .or. bof())
									store 0 to UPCOUNT

									store "" to LABEL_L1
									store "" to LABEL_L2
									store "" to LABEL_L3
									store "" to LABEL_L4
									store "" to LABEL_L5
									store "" to LABEL_L6
									store "" to LABEL_L7

									*
									* If more than one label per row continue
									*

									do while .not. (eof() .or. bof()) .and. UPCOUNT < val(L_COL)
										if REPORT_ZIP
											store .F. to REPORT_ZIP

											store ltrim(trim(O_ZIP)) to LINE_1
											if substr(LINE_1,len(LINE_1),1) = "-"
												store substr(LINE_1,1,len(LINE_1) - 1) to LINE_1
											endif
											store "Zip = " + LINE_1 to LINE_1
											store "Batch = " + ltrim(str(BATCH_TOTAL)) to LINE_2
											store "Count = " + ltrim(str(ZIP_TOTAL)) to LINE_3
											store "" to LINE_4
											store "" to LINE_5
											store "" to LINE_6
											store "" to LINE_7

											store LINE_1 + space(val(L_WIDTH) - len(LINE_1)) to LINE_1
											store LINE_2 + space(val(L_WIDTH) - len(LINE_2)) to LINE_2
											store LINE_3 + space(val(L_WIDTH) - len(LINE_3)) to LINE_3
											store LINE_4 + space(val(L_WIDTH) - len(LINE_4)) to LINE_4
											store LINE_5 + space(val(L_WIDTH) - len(LINE_5)) to LINE_5
											store LINE_6 + space(val(L_WIDTH) - len(LINE_6)) to LINE_6
											store LINE_7 + space(val(L_WIDTH) - len(LINE_7)) to LINE_7

											if UPCOUNT = val(L_COL) - 1
												store LABEL_L1 + LINE_1 to LABEL_L1
												store LABEL_L2 + LINE_2 to LABEL_L2
												store LABEL_L3 + LINE_3 to LABEL_L3
												store LABEL_L4 + LINE_4 to LABEL_L4
												store LABEL_L5 + LINE_5 to LABEL_L5
												store LABEL_L6 + LINE_6 to LABEL_L6
												store LABEL_L7 + LINE_7 to LABEL_L7

											else
												store LABEL_L1 + LINE_1 + space(val(L_CBTWN)) to LABEL_L1
												store LABEL_L2 + LINE_2 + space(val(L_CBTWN)) to LABEL_L2
												store LABEL_L3 + LINE_3 + space(val(L_CBTWN)) to LABEL_L3
												store LABEL_L4 + LINE_4 + space(val(L_CBTWN)) to LABEL_L4
												store LABEL_L5 + LINE_5 + space(val(L_CBTWN)) to LABEL_L5
												store LABEL_L6 + LINE_6 + space(val(L_CBTWN)) to LABEL_L6
												store LABEL_L7 + LINE_7 + space(val(L_CBTWN)) to LABEL_L7

											endif

											store UPCOUNT + 1 to UPCOUNT

										else
											@ 13,8 say space(67)
											@ 14,8 say space(67)

											store ltrim(str(LTR_NBR)) to LTR_CNT

											store 11 to PMT_LINE
											store "Reading prepared list file for label number ... " + LTR_CNT + " of " + LTR_TOT to PMT_MSG
											do prompt

											store trim(L_LTTR_NO) to LTTR_NO

											select CLIENT

											store 12 to PMT_LINE
											store "Searching client file for client number ... " + LTTR_NO to PMT_MSG
											do prompt

											seek LTTR_NO

											if .not. (eof() .or. bof())
												store 13 to PMT_LINE
												store "Reading client profile for " + trim(C_FST_N) + " " + trim(C_LST_N) to PMT_MSG
												do prompt

												do READCLI

												do FMTLABEL

												*
												* Don't pad between labels if this is the
												* last label
												*

												if UPCOUNT = val(L_COL) - 1
													store LABEL_L1 + LINE_1 to LABEL_L1
													store LABEL_L2 + LINE_2 to LABEL_L2
													store LABEL_L3 + LINE_3 to LABEL_L3
													store LABEL_L4 + LINE_4 to LABEL_L4
													store LABEL_L5 + LINE_5 to LABEL_L5
													store LABEL_L6 + LINE_6 to LABEL_L6
													store LABEL_L7 + LINE_7 to LABEL_L7

												else
													store LABEL_L1 + LINE_1 + space(val(L_CBTWN)) to LABEL_L1
													store LABEL_L2 + LINE_2 + space(val(L_CBTWN)) to LABEL_L2
													store LABEL_L3 + LINE_3 + space(val(L_CBTWN)) to LABEL_L3
													store LABEL_L4 + LINE_4 + space(val(L_CBTWN)) to LABEL_L4
													store LABEL_L5 + LINE_5 + space(val(L_CBTWN)) to LABEL_L5
													store LABEL_L6 + LINE_6 + space(val(L_CBTWN)) to LABEL_L6
													store LABEL_L7 + LINE_7 + space(val(L_CBTWN)) to LABEL_L7

												endif

												store UPCOUNT + 1 to UPCOUNT

											endif

											store LTR_NBR + 1 to LTR_NBR

											select LTTR

											store L_ZIP to O_ZIP

											skip

											do case
												case L_ZIP <> O_ZIP
													store .T. to REPORT_ZIP

													store ZIP_CNT to ZIP_TOTAL
													store 1 to ZIP_CNT

													store BATCH_CNT to BATCH_TOTAL
													store 1 to BATCH_CNT

												case ZIP_CNT < 50
													store ZIP_CNT + 1 to ZIP_CNT

												otherwise
													store .T. to REPORT_ZIP

													store ZIP_CNT to ZIP_TOTAL
													store 1 to ZIP_CNT

													store BATCH_CNT to BATCH_TOTAL
													store BATCH_CNT + 1 to BATCH_CNT

											endcase

										endif

									enddo

									store 14 to PMT_LINE
									store "Printing client(s) mailing labels" to PMT_MSG
									do prompt

									*
									* If there are no more labels to
									* print then finish up printing
									* labels a zip info
									*

									if bof() .or. eof()

										*
										* Set up last zip total
										*

										store ltrim(trim(O_ZIP)) to LINE_1
										if substr(LINE_1,len(LINE_1),1) = "-"
											store substr(LINE_1,1,len(LINE_1) - 1) to LINE_1
										endif
										store "Zip = " + LINE_1 to LINE_1
										store "Batch = " + ltrim(str(BATCH_TOTAL)) to LINE_2
										store "Count = " + ltrim(str(ZIP_TOTAL)) to LINE_3
										store "" to LINE_4
										store "" to LINE_5
										store "" to LINE_6
										store "" to LINE_7

										store LINE_1 + space(val(L_WIDTH) - len(LINE_1)) to LINE_1
										store LINE_2 + space(val(L_WIDTH) - len(LINE_2)) to LINE_2
										store LINE_3 + space(val(L_WIDTH) - len(LINE_3)) to LINE_3
										store LINE_4 + space(val(L_WIDTH) - len(LINE_4)) to LINE_4
										store LINE_5 + space(val(L_WIDTH) - len(LINE_5)) to LINE_5
										store LINE_6 + space(val(L_WIDTH) - len(LINE_6)) to LINE_6
										store LINE_7 + space(val(L_WIDTH) - len(LINE_7)) to LINE_7

										*
										* If L_COL full then print column
										* and place zip info on next line
										* else add zip info to current line
										*

										if UPCOUNT = val(L_COL)

											*
											* Print mailing label
											*

											do PRINTLBL

											*
											* format last zip summary
											*

											store LINE_1 to LABEL_L1
											store LINE_2 to LABEL_L2
											store LINE_3 to LABEL_L3
											store LINE_4 to LABEL_L4
											store LINE_5 to LABEL_L5
											store LINE_6 to LABEL_L6
											store LINE_7 to LABEL_L7

											*
											* Print zip total
											*

											do PRINTLBL

										else
											store LABEL_L1 + LINE_1 to LABEL_L1
											store LABEL_L2 + LINE_2 to LABEL_L2
											store LABEL_L3 + LINE_3 to LABEL_L3
											store LABEL_L4 + LINE_4 to LABEL_L4
											store LABEL_L5 + LINE_5 to LABEL_L5
											store LABEL_L6 + LINE_6 to LABEL_L6
											store LABEL_L7 + LINE_7 to LABEL_L7

											*
											* Print mailing label
											*

											do PRINTLBL

										endif

									else

										*
										* Print mailing label
										* more record to go
										*

										do PRINTLBL

									endif

									do CHECKKEY

								enddo

								if L_ROW <> "continuous"
									set console off
									set print on

									eject

									set print off
									set console on

								endif

								store 22 to STAT_LINE
								store "Finished printing labels from &SCH_SNAME list" to STAT_MSG
								do status

							endif

							select CLIENT
							use

							select LTTR
							use

							store 1 to CHOICE_SND

						else
							store 22 to STAT_LINE
							store "Could not open &SCH_LTTR file" to STAT_MSG
							do status

						endif

					else
						store 22 to STAT_LINE
						store "You must first prepare the list of letters" to STAT_MSG
						do status

					endif

				endif

			else
				store 22 to STAT_LINE
				store "You must first select a schedule" to STAT_MSG
				do status

				store 1 to CHOICE_SND

			endif

			do CLRSCRN

			store .t. to continue
			store .t. to REFRESH

		case CHOICE = 7
			if SCH_SEL
				do CLRSCRN

				if file((SCH_LTTR + ".DBF"))
					@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
					@ 6,7  say "บ                                                                   บ Û"
					@ 7,7  say "บ                                                                   บ Û"
					@ 8,7  say "บ                                                                   บ Û"
					@ 9,7  say "บ                                                                   บ Û"
					@ 10,7 say "บ                                                                   บ Û"
					@ 11,7 say "บ                                                                   บ Û"
					@ 12,7 say "บ                                                                   บ Û"
					@ 13,7 say "บ                                                                   บ Û"
					@ 14,7 say "บ                                                                   บ Û"
					@ 15,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
					@ 16,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

					@  7,9 say "                --- <<< C A U T I O N >>> ---"
					@  8,9 say "If you have not printed the  letters  from  this  list  and  you"
					@  9,9 say "delete the list, the letters from this list can not be  printed."
					@ 10,9 say "IntelliMail has marked the letters as printed  and  the  clients"
					@ 11,9 say "will be treated as if their letters were printed.   If you  have"
					@ 12,9 say "already printed the letter from this list then it is OK to clear"
					@ 13,9 say "this list."

					store 1 to CHOICE
					store 2 to PICK_CNT
					store 20 to PICK_LINE
					store "Don't Clear list for " + SCH_SNAME to PICK_1
					store "Clear list for " + SCH_SNAME to PICK_2
					do PICK

					do CLRSCRN

					if CHOICE = 2
						store SCH_LTTR + ".DBF" to DEL_FILE
						delete file &DEL_FILE

						if file((SCH_ALP + ".NTX"))
							store SCH_ALP + ".NTX" to DEL_FILE
							delete file &DEL_FILE

						endif

						if file((SCH_ZIP + ".NTX"))
							store SCH_ZIP + ".NTX" to DEL_FILE
							delete file &DEL_FILE

						endif

						store 22 to STAT_LINE
						store "The list for " + SCH_SNAME + " has been cleared" to STAT_MSG
						do status

						store 2 to CHOICE_SND

					endif

				else
					store 22 to STAT_LINE
					store "The list for " + SCH_SNAME + " was previouly cleared" to STAT_MSG
					do status

				endif

				store .t. to continue
				store .t. to REFRESH

			else
				store 22 to STAT_LINE
				store "You must first select a schedule" to STAT_MSG
				do status

				store .t. to continue
				store .f. to REFRESH

			endif

		case CHOICE = 8
			store "Checking for deleted data" to L_TAIL
			store "Do not disturb this process" to R_TAIL
			do TAIL

			set deleted off
			do DELDATA
			set deleted on

			store .f. to continue

	endcase

enddo

return

*: EOF: SENDMENU.PRG

