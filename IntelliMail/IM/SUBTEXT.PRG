*:*********************************************************************
*:
*:        Program: SUBTEXT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Thu 2-Mar-89 at 0:49 am
*:
*:      Called by: LTRMENU.PRG    
*:               : SENDMENU.PRG   
*:
*:     Documented: 09/04/88 at 16:57               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* SUBTEXT >>> Substitute the text string for global, client and aud   *
*	       entry : Global Data, Aud Data, Client Data, letter text	  *
*	       exit : LTR_OK											  *
*																	  *
***********************************************************************

if GLBL_DATA $ TEXT_LINE
	do while (GLBL_DATA $ TEXT_LINE .and. LTR_OK)
		if G_TRGT_1 $ TEXT_LINE
			store at(G_TRGT_1,TEXT_LINE) - 1 to START
			store START + len(G_TRGT_1) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP	>= end
				store date() to TDY
				store substr(TEXT_LINE,1,START) + cmonth(TDY) + " " + ltrim(str(day(TDY),2)) + ", " + ;
					str(year(TDY),4) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + dtoc(date()) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		else
			store .f. to LTR_OK
			
		endif
		
	enddo
	
endif

if CLI_DATA $ TEXT_LINE .and. LTR_OK
	do while (CLI_DATA $ TEXT_LINE .and. LTR_OK)
		do case

		case C_TRGT_1 $ TEXT_LINE
			store at(C_TRGT_1,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_1) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(dtoc(BIRTH)) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(dtoc(BIRTH)) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		case C_TRGT_2 $ TEXT_LINE
			store at(C_TRGT_2,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_2) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(LBL_CODE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(LBL_CODE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		case C_TRGT_3 $ TEXT_LINE
			store at(C_TRGT_3,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_3) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(TITLE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(TITLE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		case C_TRGT_4 $ TEXT_LINE
			store at(C_TRGT_4,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_4) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			store trim(FST_N) to FST_N
			store substr(FST_N,1,1) + substr(lower(FST_N),2,len(FST_N)-1) to NAME
			
			if " " $ NAME
				store at(" ",NAME) to PLACE
				store substr(NAME,1,PLACE) + upper(substr(NAME,PLACE+1,1)) + substr(NAME,PLACE+2,len(NAME)-PLACE-1) to NAME
				
			endif
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + NAME to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + NAME + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_5 $ TEXT_LINE
			store at(C_TRGT_5,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_5) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			store trim(LST_N) to LST_N
			store substr(LST_N,1,1) + substr(lower(LST_N),2,len(LST_N)-1) to NAME
			
			if " " $ NAME
				store at(" ",NAME) to PLACE
				store substr(NAME,1,PLACE) + upper(substr(NAME,PLACE+1,1)) + substr(NAME,PLACE+2,len(NAME)-PLACE-1) to NAME
				
			endif
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + NAME  to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + NAME + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_6 $ TEXT_LINE
			store at(C_TRGT_6,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_6) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(CO_TITLE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(CO_TITLE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		case C_TRGT_7 $ TEXT_LINE
			store at(C_TRGT_7,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_7) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(CO_NAME) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(CO_NAME) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		case C_TRGT_8 $ TEXT_LINE
			store at(C_TRGT_8,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_8) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(ADDR_1) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(ADDR_1) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_9 $ TEXT_LINE
			store at(C_TRGT_9,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_9) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(ADDR_2) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(ADDR_2) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		case C_TRGT_10 $ TEXT_LINE
			store at(C_TRGT_10,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_10) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(CITY) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(CITY) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_11 $ TEXT_LINE
			store at(C_TRGT_11,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_11) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(STATE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(STATE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_12 $ TEXT_LINE
			store at(C_TRGT_12,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_12) + 1 to STOP
			store len(TEXT_LINE) + 1 to end

			store trim(ZIP) to TMP_ZIP
			if substr(TMP_ZIP,len(TMP_ZIP),1) = "-"
				store substr(TMP_ZIP,1,len(TMP_ZIP) - 1) to TMP_ZIP
			endif

			if STOP >= end
				store substr(TEXT_LINE,1,START) + TMP_ZIP to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + TMP_ZIP + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_13 $ TEXT_LINE
			store at(C_TRGT_13,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_13) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(PHONE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(PHONE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case C_TRGT_14 $ TEXT_LINE
			store at(C_TRGT_14,TEXT_LINE) - 1 to START
			store START + len(C_TRGT_14) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(COMMENTS) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(COMMENTS) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif

		otherwise
			store .f. to LTR_OK
			
		endcase
		
	enddo
	
endif

if BUS_DATA $ TEXT_LINE .and. LTR_OK
	do while (BUS_DATA $ TEXT_LINE .and. LTR_OK)
		do case
		case B_TRGT_1 $ TEXT_LINE
			store at(B_TRGT_1,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_1) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_FNME) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_FNME) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_2 $ TEXT_LINE
			store at(B_TRGT_2,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_2) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_LNME) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_LNME) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_3 $ TEXT_LINE
			store at(B_TRGT_3,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_3) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_TTLE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_TTLE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_4 $ TEXT_LINE
			store at(B_TRGT_4,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_4) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_NAME) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_NAME) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_5 $ TEXT_LINE
			store at(B_TRGT_5,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_5) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_ADD1) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_ADD1) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_6 $ TEXT_LINE
			store at(B_TRGT_6,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_6) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_ADD2) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_ADD2) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_7 $ TEXT_LINE
			store at(B_TRGT_7,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_7) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_CITY) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_CITY) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_8 $ TEXT_LINE
			store at(B_TRGT_8,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_8) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_ST) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_ST) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_9 $ TEXT_LINE
			store at(B_TRGT_9,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_9) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			store trim(BUS_ZIP) to TMP_ZIP
			if substr(TMP_ZIP,len(TMP_ZIP),1) = "-"
				store substr(TMP_ZIP,1,len(TMP_ZIP) - 1) to TMP_ZIP
			endif

			if STOP >= end
				store substr(TEXT_LINE,1,START) + TMP_ZIP to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + TMP_ZIP + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		case B_TRGT_10 $ TEXT_LINE
			store at(B_TRGT_10,TEXT_LINE) - 1 to START
			store START + len(B_TRGT_10) + 1 to STOP
			store len(TEXT_LINE) + 1 to end
			
			if STOP >= end
				store substr(TEXT_LINE,1,START) + trim(BUS_PHNE) to TEXT_LINE
				
			else
				store substr(TEXT_LINE,1,START) + trim(BUS_PHNE) + substr(TEXT_LINE,STOP,end-STOP) to TEXT_LINE
				
			endif
			
		otherwise
			store .f. to LTR_OK
			
		endcase
		
	enddo
	
endif

return

*: EOF: SUBTEXT.PRG
