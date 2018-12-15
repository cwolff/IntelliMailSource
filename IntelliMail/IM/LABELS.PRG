* Last modified : Wed 15-Feb-89 at 8:56 am
*
*********************************************************************
*                                                                   *
*   DN_RML                                                          *
*                                                                   *
*   report mailing labels                                           *
*   LA = label across                                               *
*   LW = label width                                                *
*   LS = label spaces                                               *
*   LM = label margin                                               *
*   LL = label lines                                                *
*   LN = label number to start at                                   *
*   W  = width                                                      *
*   RP = row printed                                                *
*   LC = label printer code                                         *
*   MCODE = label code                                              *
*   LTP = labels to print                                           *
*   LPR = labels per record                                         *
*   SLPR = save lables per record                                   *
*                                                                   *
*********************************************************************
*

procedure DN_RML
	CHOICE=space(1)

	do while .t.
		sele 9
		RP = 0

		*
		* Y = label count
		*

		Y = 0

		if CHOICE = space(1)
			@ 07,00 clear
			@ 07,11 say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออป"
			set color to &C2/&C1,&C3/&C4,&C5
			@ 07,25 say " M A I L I N G   L A B E L S "
			set color to &C1/&C2,&C3/&C4,&C5
			@ 08,11 say "บ                                                     บ"
			@ 09,11 say "บ  Labels across................       (1-5)          บ"
			@ 10,11 say "บ  Lines per label..............       (5-99)         บ"
			@ 11,11 say "บ  Left margin indent...........       (0-99)         บ"
			@ 12,11 say "บ  Width of label in spaces.....       (20-99)        บ"
			@ 13,11 say "บ  Spaces between labels........       (0-99)         บ"
			@ 14,11 say "บ  Starting record number.......       (0 for top)    บ"
			@ 15,11 say "บ  Number of labels to print....       (0 for all)    บ"
			@ 16,11 say "บ  Labels per name..............       (1-99)         บ"
			@ 17,11 say "บ  Pause between pages..........       (Y/N)          บ"
			@ 18,11 say "บ  Rows of labels per page......       (1-99)         บ"
			@ 19,11 say "บ  Printer code (optional)......                      บ"
			@ 20,11 say "บ  Label code (optional)........                      บ"
			@ 21,11 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออผ"

			set color to &C3/&C4,&C2/&C1,&C5

			@ 09,43 say LA pict '9'
			@ 10,43 say LL pict '99'
			@ 11,43 say LM pict '99'
			@ 12,43 say LW pict '99'
			@ 13,43 say LS pict '99'
			@ 14,43 say LN pict '99999'
			@ 15,43 say LTP pict '99999'
			@ 16,43 say LPR pict '99'
			@ 17,43 say LP pict '!'
			@ 18,43 say LR
			@ 19,43 say LC
			@ 20,43 say MCODE

			set color to &C1/&C2,&C3/&C4,&C5

		endif

		do while .t.
			@ 23,11 say "CHOICE >>>      (E)xit  (C)hange  (P)rint  (T)est";
				+ space(12)

			CHOICE=space(1)

			do while .not. CHOICE $ 'ECPT'
				@ 23,22 get CHOICE pict '!'
				read

			enddo

			if CHOICE='C'
				@ 09,43 get LA pict '9' range 1,5
				@ 10,43 get LL pict '99' range 5,99
				@ 11,43 get LM pict '99' range 0,99
				@ 12,43 get LW pict '99' range 20,99
				@ 13,43 get LS pict '99' range 0,99
				@ 14,43 get LN pict '99999' range 0,99999
				@ 15,43 get LTP pict '99999' range 0,99999
				@ 16,43 get LPR pict '99' range 1,99
				@ 17,43 get LP pict '!'
				@ 18,43 get LR pict '99' range 1,99
				@ 19,43 get LC
				@ 20,43 get MCODE

				read

				clear gets
				loop

			endif

			exit

		enddo

		if choice = 'E'
			repl LN with 0

		return

	endif

	MLA = LA
	MLL = LL
	MLM = LM
	MLW = LW
	MLS = LS
	MLN = LN
	MLP = LP
	MLR = LR
	MLC = LC
	MLTP = LTP
	MLPR = LPR - 1
	SLPR = LPR - 1
	MMCODE = MCODE
	MPITCH10 = PITCH10
	SLM = space(LM)

	if MLTP = 0
		MLTP = 99999

	endif

	@ 22,05 say "Current Name:"
	set print on
	set cons off

	if MLC # space(5)
		?? &MLC

	endif

	sele 2
	use DN_REPT
	sele 1

	if CHOICE = 'T'
		use DN_TEST

	else
 		use &MDRIVE.DN_&MCF

		if INDEX_SET
			set index to DN_REPT

		else
			set index to &MDRIVE.DN_&MCF

		endif

		if FILT_SET
			set filter to &MFILTER

		endif

		if MLN > 0 .and. MLN < MNOR
			goto MLN

		else
			goto top

		endif

	endif

	MPHONE = 0
	MLL = MLL - 1

	if MMCODE # space(20)
		if upper(MMCODE) = "WPHONE"
			MMCODE = trim(MMCODE)
			MPHONE = 1

		endif

		if upper(MMCODE) = "HPHONE"
			MMCODE = trim(MMCODE)
			MPHONE = 2

		endif

	endif

	do while .not. eof()
		SLL = MLL
		sele 2
		repl all L1 with space(1)
		goto 1

		if MMCODE # space(20)
			if MPHONE = 0
				repl L1 with SLM + substr(MMCODE + space(50), 1, MLW)

			else
				repl L1 with SLM + substr(A->&MMCODE + space(50), 1, MLW)

			endif

			skip

		endif

		if A->FIRSTNAME # space(5)
			if A->LASTNAME # space(5)
				repl L1 with SLM + substr(trim(A->FIRSTNAME) + ' ' ;
					+ trim(A->LASTNAME) + space(50), 1, MLW)

			else
				repl L1 with SLM + substr(trim(A->FIRSTNAME) + space(50), 1, MLW)

			endif

			skip
		else
			if A->LASTNAME # space(5)
				repl L1 with SLM + substr(trim(A->LASTNAME) + space(50), 1, MLW)
				skip

			endif

		endif

		if A->COMPANY # space(5)
			repl L1 with SLM + substr(trim(A->COMPANY) + space(50), 1, MLW)
			skip

		endif

		if A->ADDRESS1 # space(5)
			repl L1 with SLM + substr(trim(A->ADDRESS1) + space(50), 1, MLW)
			skip

		endif

		if A->ADDRESS2 # space(5)
			repl L1 with SLM + substr(trim(A->ADDRESS2) + space(50), 1, MLW)
			skip

		endif

		if A->STATE = space(2)
			repl L1 with SLM + substr(trim(A->CITY) + space(1) ; 
				+ trim(A->ZIP) + space(50), 1, MLW)

		else
			repl L1 with SLM + substr(trim(A->CITY) + ', ' ;
				+ A->STATE + ' ' + trim(A->ZIP) + space(50), 1, MLW)

		endif

		sele 1
		set cons on

		@ 22,20 say recno()
		@ 22,35 say substr(LASTNAME,1,15) + ' ' + substr(COMPANY,1,15)
		set cons off

		if MLPR < 1
			MLPR = SLPR
			skip

		else
			MLPR = MLPR - 1

		endif

		if eof()
			do DN_RLP
			exit

		endif

		sele 2
		goto 1
		x = mla
		w = 0

		do while x > 1
			if X = MLA
				W = W + MLW + MLS + MLM

			else
				W = W + MLW + MLS

			endif

			if MMCODE # space(20)
				if MPHONE = 0
					repl L1 with substr(L1,1,W) + substr(MMCODE + space(50), 1, MLW)

				else
					repl L1 with substr(L1,1,W) + ;
						substr(A->&MMCODE + space(50), 1, MLW)

				endif

				skip

			endif

			if A->FIRSTNAME # space(5)
				if A->LASTNAME # space(5)
					repl L1 with substr(L1,1,W) + substr(trim(A->FIRSTNAME) + ' ' ;
						+ trim(A->LASTNAME) + space(50), 1, MLW)

				else
					repl L1 with substr(L1,1,W) + substr(trim(A->FIRSTNAME) + ;
						space(50), 1, MLW)

				endif

				skip
			else
				if A->LASTNAME # space(5)
					repl L1 with substr(L1,1,W) + ;
						substr(trim(A->LASTNAME) + space(50), 1, MLW)
					skip

				endif

			endif

			if A->COMPANY # space(5)
				repl L1 with substr(L1,1,W) + ;
					substr(trim(A->COMPANY) + space(50), 1, MLW)
				skip

			endif

			if A->ADDRESS1 # space(5)
				repl L1 with substr(L1,1,w) + ;
					substr(trim(A->ADDRESS1) + space(50), 1, MLW)
				skip

			endif

			if A->ADDRESS2 # space(5)
				repl L1 with substr(L1,1,W) + ;
					substr(trim(A->ADDRESS2) + space(50), 1, MLW)
				skip

			endif

			if A->STATE = space(2)
				repl L1 with substr(L1,1,W) + ;
					substr(trim(A->CITY) + space(1) + trim(A->ZIP) + ;
						space(50), 1, MLW)

			else
				repl L1 with substr(L1,1,W) + ;
					substr(trim(A->CITY) + ', ' + A->STATE + ' ' ;
						+ trim(A->ZIP) + space(50), 1, MLW)

			endif

			sele 1
			set cons on
			@ 22,20 say recno()
			@ 22,35 say substr(LASTNAME, 1, 15) + ' ' + substr(COMPANY,1,15)
			set cons off

			if MLPR < 1
				MLPR = SLPR
				skip

			else
				MLPR = MLPR - 1

			endif

			if eof()
				do DN_RLP
				exit

			endif

			x=x-1
			sele 2
			goto 1
		enddo

		sele 1
		if eof()
			exit

		else
			do DN_RLP
			sele 1

			do while SLL - 5 > 0
				?
				SLL = SLL - 1

			enddo

		endif

		if Y> = MLTP
			CHOICE = 'T'
			exit

		endif

		if CHOICE = 'T'
			exit

		endif

	enddo

	if MPITCH10 # space(5)
		?? &MPITCH10

	endif

	set print off

	if CHOICE # 'T'
		set device to print
		@ 01,00 say space(1)
		set device to screen

	endif

	set cons on

	if Y >= MLTP
		SAVEREC = recno()
		sele 9
		repl LN with SAVEREC
		set color to &C3/&C4,&C2/&C1,&C5
		@ 14,43 say LN pict '99999'
		set color to &C1/&C2,&C3/&C4,&C5

	endif

	@ 22,00
enddo

rele MLA, MLL, MLM, MLW, MLS, MLN, MLP, MLR, MLC, ;
	SLM, W, X, SLL, MPER, MLPN, MMCODE, MLPR, SLPR

return

*eop

procedure dn_rlp
	* report label print
	sele 2
	goto 1
	Y = Y + MLA

	do while .not. eof()
		? trim(L1)
		skip

	enddo

	RP = RP+1

	if RP = MLR .and. MLP = 'Y' .and. CHOICE # 'T'
		set cons on
		RP = 0
		set print off
		@ 23,11 say "Press space bar to continue printing or (Q)uit"+space(10)
		set cons off
		RESPONCE = space(1)
		@ 23,58 get RESPONCE pict '!'

		read

		if RESPONCE = 'Q'
			sele 1
			goto bottom
			skip

		endif

		set cons on
		@ 23,00
		set cons off
		set print on

	endif

return

*eop
