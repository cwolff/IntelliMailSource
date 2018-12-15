*:*********************************************************************
*:
*:        Program: GMSTEP.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 30-Sep-88 at 7:57 pm
*:
*:      Called by: MRKMOVE.PRG    
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GMSTEP >>> Prompts the user to type in the schedule step            *
*	       entry : Open and selected schedule directory, MRK_SNAME    *
*	       exit : MRK_STEP                                  	      *
*                 MRK_DESC                                            *
*                 MRK_SEL                                             *
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


store reccount() to MSTEP_COUNT
store 1 to MSTEP_PLACE
goto top

*
* Make sure the directory is not empty
*

if MSTEP_COUNT > 0
	
	*
	* Put up prompt
	*
	
	store SEL_NAME to L_TAIL
	store "Press   to Select ÄÙ when Done" to R_TAIL
	do TAIL
	
	*
	* Initialize variables
	*
	
	store "This marker is pointing to step " to MRK_PMT1
	store " in the &MRK_SNAME schedule" to MRK_PMT2
	
	store 7 to MSTEP_ROW1
	store space(65) to MSTEP_1
	store 8 to MDESC_ROW1
	store space(65) to MDESC_1
	
	store 9 to MSTEP_ROW2
	store space(65) to MSTEP_2
	store 10 to MDESC_ROW2
	store space(65) to MDESC_2
	
	store 11 to MSTEP_ROW3
	store space(65) to MSTEP_3
	store 12 to MDESC_ROW3
	store space(65) to MDESC_3
	
	store 13 to MSTEP_ROW4
	store space(65) to MSTEP_4
	store 14 to MDESC_ROW4
	store space(65) to MDESC_4
	
	store 15 to MSTEP_ROW5
	store space(65) to MSTEP_5
	store 16 to MDESC_ROW5
	store space(65) to MDESC_5
	
	*
	* Get the Schedule Step entries and place in the window variables
	*
	* Display Schdule Steps in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (MSTEP_PLACE - 2) > 0
		goto (MSTEP_PLACE - 2)
		store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_1
		store S_SDESC + space(65 - len(S_SDESC)) to MDESC_1
	else
		store space(65) to MSTEP_1
		store space(65) to MDESC_2
	endif
	
	if MSTEP_PLACE - 1 > 0
		goto MSTEP_PLACE - 1
		store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_2
		store S_SDESC + space(65 - len(S_SDESC)) to MDESC_2
	else
		store space(65) to MSTEP_2
		store space(65) to MDESC_2
	endif
	
	goto MSTEP_PLACE
	store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_3
	store S_SDESC + space(65 - len(S_SDESC)) to MDESC_3
	
	if MSTEP_PLACE + 1 <= MSTEP_COUNT
		goto MSTEP_PLACE + 1
		store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_4
		store S_SDESC + space(65 - len(S_SDESC)) to MDESC_4
	else
		store space(65) to MSTEP_4
		store space(65) to MDESC_4
	endif
	
	if MSTEP_PLACE + 2 <= MSTEP_COUNT
		goto MSTEP_PLACE + 2
		store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_5
		store S_SDESC + space(65 - len(S_SDESC)) to MDESC_5
	else
		store space(65) to MSTEP_5
		store space(65) to MDESC_5
	endif
	
	@ MSTEP_ROW1,10 say MSTEP_1
	@ MDESC_ROW1,10 say MDESC_1
	@ MSTEP_ROW2,10 say MSTEP_2
	@ MDESC_ROW2,10 say MDESC_2
	
	@ MSTEP_ROW4,10 say MSTEP_4
	@ MDESC_ROW4,10 say MDESC_4
	@ MSTEP_ROW5,10 say MSTEP_5
	@ MDESC_ROW5,10 say MDESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ MSTEP_ROW3,10 say MSTEP_3
	@ MDESC_ROW3,10 say MDESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if MSTEP_PLACE <> 0
		goto MSTEP_PLACE
		
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
				store 1 to MSTEP_PLACE
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if MSTEP_PLACE - 5 > 1
					store MSTEP_PLACE - 5 to MSTEP_PLACE
				else
					store 1 to MSTEP_PLACE
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if MSTEP_PLACE > 1
					store MSTEP_PLACE - 1 to MSTEP_PLACE
					
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if MSTEP_PLACE < MSTEP_COUNT
					store MSTEP_PLACE + 1 to MSTEP_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if MSTEP_PLACE + 5 < MSTEP_COUNT
					store MSTEP_PLACE + 5 to MSTEP_PLACE
					
				else
					store MSTEP_COUNT to MSTEP_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store MSTEP_COUNT to MSTEP_PLACE
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				goto MSTEP_PLACE
				
				store .f. to DO_MORE
				store .t. to MRK_SEL
				store ltrim(str(S_STEP)) + space(3 - len(ltrim(str(S_STEP)))) to MRK_STEP
				store S_SDESC to MRK_DESC
				
			endcase
			
			if (MSTEP_PLACE - 2) > 0
				goto (MSTEP_PLACE - 2)
				store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_1
				store S_SDESC + space(65 - len(S_SDESC)) to MDESC_1
			else
				store space(65) to MSTEP_1
				store space(65) to MDESC_1
			endif
			
			if MSTEP_PLACE - 1 > 0
				goto MSTEP_PLACE - 1
				store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_2
				store S_SDESC + space(65 - len(S_SDESC)) to MDESC_2
			else
				store space(65) to MSTEP_2
				store space(65) to MDESC_2
			endif
			
			goto MSTEP_PLACE
			store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_3
			store S_SDESC + space(65 - len(S_SDESC)) to MDESC_3
			
			if MSTEP_PLACE + 1 <= MSTEP_COUNT
				goto MSTEP_PLACE + 1
				store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_4
				store S_SDESC + space(65 - len(S_SDESC)) to MDESC_4
			else
				store space(65) to MSTEP_4
				store space(65) to MDESC_4
			endif
			
			if MSTEP_PLACE + 2 <= MSTEP_COUNT
				goto MSTEP_PLACE + 2
				store MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2 + space(65 - len(MRK_PMT1 + ltrim(str(S_STEP)) + MRK_PMT2)) to MSTEP_5
				store S_SDESC + space(65 - len(S_SDESC)) to MDESC_5
			else
				store space(65) to MSTEP_5
				store space(65) to MDESC_5
			endif
			
			@ MSTEP_ROW1,10 say MSTEP_1
			@ MDESC_ROW1,10 say MDESC_1
			@ MSTEP_ROW2,10 say MSTEP_2
			@ MDESC_ROW2,10 say MDESC_2
			
			@ MSTEP_ROW4,10 say MSTEP_4
			@ MDESC_ROW4,10 say MDESC_4
			@ MSTEP_ROW5,10 say MSTEP_5
			@ MDESC_ROW5,10 say MDESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ MSTEP_ROW3,10 say MSTEP_3
			@ MDESC_ROW3,10 say MDESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if MSTEP_PLACE <> 0
				goto MSTEP_PLACE
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The &MRK_SNAME schedule is empty" to STAT_MSG
	do status
	
	store .f. to MRK_SEL
	store space(3) to MRK_STEP
	store space(65) to MRK_DESC
	
endif

return


*: EOF: GMSTEP.PRG
