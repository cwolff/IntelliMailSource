*:*********************************************************************
*:
*:        Program: GSSTEP.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 8:06 pm
*:
*:      Called by: CLIADD.PRG     
*:               : MRKMOVE.PRG    
*:               : EDITMRK.PRG    
*:               : SCHDVIEW.PRG   
*:               : SCHDADD.PRG    
*:               : SCHDEDIT.PRG   
*:               : ADDMRK.PRG     
*:               : GETSCH.PRG     
*:               : GETDCD.PRG     
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : WRITESCH         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GSSTEP >>> Prompts the user to type in the schedule step            *
*	       entry : Open and selected schedule directory               *
*	       exit : SCH_STEP                                  	      *
*                 SCH_SDESC                                           *
*                 SCH_SEL                                             *
*                 REC_NBR                                             *
*                 REC_ADD                                             *
*									                                  *
***********************************************************************

*
* Open window
*

@ 6,9  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
@ 7,9  say "º                                                                 º Û"
@ 8,9  say "º                                                                 º Û"
@ 9,9  say "º                                                                 º Û"
@ 10,9 say "º                                                                 º Û"
@ 11,9 say "º                                                                 º Û"
@ 12,9 say "º                                                                 º Û"
@ 13,9 say "º                                                                 º Û"
@ 14,9 say "º                                                                 º Û"
@ 15,9 say "º                                                                 º Û"
@ 16,9 say "º                                                                 º Û"
@ 17,9 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
@ 18,9 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

*
* Make sure the directory is not empty
*

store reccount() to STEP_COUNT

if STEP_COUNT > 0 .or. REC_ADD
	
	if REC_ADD
		store .t. to STEP_ADD
		
	else
		store .f. to STEP_ADD
		
	endif
	
	store REC_NBR to STEP_PLACE
	
	if STEP_PLACE > 0 .and. STEP_PLACE < STEP_COUNT + 1
		goto STEP_PLACE
		
	else
		if STEP_PLACE <> 0
			store 1 to STEP_PLACE
			
		endif
		
		goto top
		
	endif
	
	*
	* Put up prompt
	*
	
	store SEL_NAME to L_TAIL
	store "Press   to Select ÄÙ when Done" to R_TAIL
	do TAIL
	
	*
	* Initialize variables
	*
	
	store "Step number " to STEP_PMT1
	store " in the &SCH_SNAME schedule" to STEP_PMT2
	
	store 7 to STEP_ROW_1
	store space(65) to STEP_1
	store 8 to DESC_ROW_1
	store space(65) to DESC_1
	
	store 9 to STEP_ROW_2
	store space(65) to STEP_2
	store 10 to DESC_ROW_2
	store space(65) to DESC_2
	
	store 11 to STEP_ROW_3
	store space(65) to STEP_3
	store 12 to DESC_ROW_3
	store space(65) to DESC_3
	
	store 13 to STEP_ROW_4
	store space(65) to STEP_4
	store 14 to DESC_ROW_4
	store space(65) to DESC_4
	
	store 15 to STEP_ROW_5
	store space(65) to STEP_5
	store 16 to DESC_ROW_5
	store space(65) to DESC_5
	
	*
	* Get the Schedule Step entries and place in the window variables
	*
	* Display Schdule Steps in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (STEP_PLACE - 2) > 0
		goto (STEP_PLACE - 2)
		store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_1
		store S_SDESC + space(65 - len(S_SDESC)) to DESC_1
	else
		if STEP_PLACE - 2 = 0 .and. STEP_ADD
			store "ADD" + space(62) to STEP_1
			store "Select this choice if you wish to ADD a new step" + space(17) to DESC_1
			
		else
			store space(65) to STEP_1
			store space(65) to DESC_1
			
		endif
		
	endif
	
	if STEP_PLACE - 1 > 0
		goto STEP_PLACE - 1
		store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_2
		store S_SDESC + space(65 - len(S_SDESC)) to DESC_2
	else
		if STEP_PLACE - 1 = 0 .and. STEP_ADD
			store "ADD" + space(62) to STEP_2
			store "Select this choice if you wish to ADD a new step" + space(17) to DESC_2
			
		else
			store space(65) to STEP_2
			store space(65) to DESC_2
			
		endif
		
	endif
	
	if STEP_PLACE > 0
		goto STEP_PLACE
		store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_3
		store S_SDESC + space(65 - len(S_SDESC)) to DESC_3
		
	else
		store "ADD" + space(62) to STEP_3
		store "Select this choice if you wish to ADD a new step" + space(17) to DESC_3
		
	endif
	
	if STEP_PLACE + 1 <= STEP_COUNT
		goto STEP_PLACE + 1
		store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_4
		store S_SDESC + space(65 - len(S_SDESC)) to DESC_4
	else
		store space(65) to STEP_4
		store space(65) to DESC_4
	endif
	
	if STEP_PLACE + 2 <= STEP_COUNT
		goto STEP_PLACE + 2
		store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_5
		store S_SDESC + space(65 - len(S_SDESC)) to DESC_5
	else
		store space(65) to STEP_5
		store space(65) to DESC_5
	endif
	
	@ STEP_ROW_1,10 say STEP_1
	@ DESC_ROW_1,10 say DESC_1
	@ STEP_ROW_2,10 say STEP_2
	@ DESC_ROW_2,10 say DESC_2
	
	@ STEP_ROW_4,10 say STEP_4
	@ DESC_ROW_4,10 say DESC_4
	@ STEP_ROW_5,10 say STEP_5
	@ DESC_ROW_5,10 say DESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ STEP_ROW_3,10 say STEP_3
	@ DESC_ROW_3,10 say DESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if STEP_PLACE <> 0
		goto STEP_PLACE
		
	endif
	
	*
	* Look for up arrow (), down arrow () or return key (ÄÄÙ)
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
				if STEP_ADD
					store 0 to STEP_PLACE
					
				else
					store 1 to STEP_PLACE
					
				endif
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if STEP_ADD
					if STEP_PLACE - 5 > 0
						store STEP_PLACE - 5 to STEP_PLACE
						
					else
						store 0 to STEP_PLACE
						
					endif
					
				else
					if STEP_PLACE - 5 > 1
						store STEP_PLACE - 5 to STEP_PLACE
						
					else
						store 1 to STEP_PLACE
						
					endif
					
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if STEP_ADD
					if STEP_PLACE > 0
						store STEP_PLACE - 1 to STEP_PLACE
						
					endif
					
				else
					if STEP_PLACE > 1
						store STEP_PLACE - 1 to STEP_PLACE
						
					endif
					
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if STEP_PLACE < STEP_COUNT
					store STEP_PLACE + 1 to STEP_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if STEP_PLACE + 5 < STEP_COUNT
					store STEP_PLACE + 5 to STEP_PLACE
					
				else
					store STEP_COUNT to STEP_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store STEP_COUNT to STEP_PLACE
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				store .f. to DO_MORE
				
				*
				* If STEP_PLACE = 0 then a new schedule step was
				* requested
				*
				
				if STEP_PLACE = 0
					store 1 to CHOICE
					store 20 to PICK_LINE
					store 2 to PICK_CNT
					store "Add step to &SCH_SNAME schedule" to PICK_1
					store "Don't add" to PICK_2
					do PICK
					
					if CHOICE = 1
						append blank
						
						store recno() to TMP
						store ltrim(str(TMP)) + space(3 - len(ltrim(str(TMP)))) to STEP
						store "This step is ready to be changed                                 " to SDESC
						store "1" to SSTP_TYP
						store "1" to SLTR_TYP
						store "0    " to LTR_VAL
						store "NOLETTER" to LTR_ID
						store "TRMNT" to N_SCHD
						store "   " to N_STEP
						store "     " to DCD_NAME
						store "1" to STRG_TYP
						store "0   " to TRG_VAL
						store "TRMNT" to T1_SCHD
						store "   " to T1_STEP
						store "TRMNT" to T2_SCHD
						store "   " to T2_STEP
						store "90 " to DL_VAL
						store "TRMNT" to DL_SCHD
						store "   " to DL_STEP
						store USER_LOGON to LOGON
						
						do WRITESCH
						
						store recno() to STEP_PLACE
						
						store ltrim(str(S_STEP)) + space(3 - len(ltrim(str(S_STEP)))) to SCH_STEP
						store S_SDESC to SCH_SDESC
						store .t. to STEP_SEL
						
					else
						store .f. to STEP_SEL
						
					endif
					
				else
					goto STEP_PLACE
					
					store .t. to STEP_SEL
					store ltrim(str(S_STEP)) + space(3 - len(ltrim(str(S_STEP)))) to SCH_STEP
					store S_SDESC to SCH_SDESC
					
				endif
				
			endcase
			
			if (STEP_PLACE - 2) > 0
				goto (STEP_PLACE - 2)
				store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_1
				store S_SDESC + space(65 - len(S_SDESC)) to DESC_1
			else
				if STEP_PLACE - 2 = 0 .and. STEP_ADD
					store "ADD" + space(62) to STEP_1
					store "Select this choice if you wish to ADD a new step" + space(17) to DESC_1
					
				else
					store space(65) to STEP_1
					store space(65) to DESC_1
					
				endif
				
			endif
			
			if STEP_PLACE - 1 > 0
				goto STEP_PLACE - 1
				store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_2
				store S_SDESC + space(65 - len(S_SDESC)) to DESC_2
			else
				if STEP_PLACE - 1 = 0 .and. STEP_ADD
					store "ADD" + space(62) to STEP_2
					store "Select this choice if you wish to ADD a new step" + space(17) to DESC_2
					
				else
					store space(65) to STEP_2
					store space(65) to DESC_2
					
				endif
				
			endif
			
			if STEP_PLACE > 0
				goto STEP_PLACE
				store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_3
				store S_SDESC + space(65 - len(S_SDESC)) to DESC_3
				
			else
				store "ADD" + space(62) to STEP_3
				store "Select this choice if you wish to ADD a new step" + space(17) to DESC_3
				
			endif
			
			if STEP_PLACE + 1 <= STEP_COUNT
				goto STEP_PLACE + 1
				store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_4
				store S_SDESC + space(65 - len(S_SDESC)) to DESC_4
			else
				store space(65) to STEP_4
				store space(65) to DESC_4
			endif
			
			if STEP_PLACE + 2 <= STEP_COUNT
				goto STEP_PLACE + 2
				store STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2 + space(65 - len(STEP_PMT1 + ltrim(str(S_STEP)) + STEP_PMT2)) to STEP_5
				store S_SDESC + space(65 - len(S_SDESC)) to DESC_5
			else
				store space(65) to STEP_5
				store space(65) to DESC_5
			endif
			
			@ STEP_ROW_1,10 say STEP_1
			@ DESC_ROW_1,10 say DESC_1
			@ STEP_ROW_2,10 say STEP_2
			@ DESC_ROW_2,10 say DESC_2
			
			@ STEP_ROW_4,10 say STEP_4
			@ DESC_ROW_4,10 say DESC_4
			@ STEP_ROW_5,10 say STEP_5
			@ DESC_ROW_5,10 say DESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ STEP_ROW_3,10 say STEP_3
			@ DESC_ROW_3,10 say DESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if STEP_PLACE <> 0
				goto STEP_PLACE
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The &SCH_SNAME schedule is empty" to STAT_MSG
	do status
	
	store .f. to STEP_SEL
	store space(3) to SCH_STEP
	store space(65) to SCH_SDESC
	
endif

return


*: EOF: GSSTEP.PRG
