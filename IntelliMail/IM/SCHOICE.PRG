*:*********************************************************************
*:
*:        Program: SCHOICE.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 30-Sep-88 at 8:02 pm
*:
*:      Called by: STYPE2.PRG     
*:               : STYPE7.PRG     
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* SCHOICE >>> Prompts the user to type in the decider menu choice     *
*	       entry : Open and selected schedule directory               *
*	       exit : DCD_SCHD                                  	      *
*                 DCD_STEP                                            *
*                 DCD_SEL                                             *
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
@ 16,9 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
@ 17,9 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

*
* Make sure the directory is not empty
*

store reccount() to CHOICE_CNT

if CHOICE_CNT > 0
	store 1 to CHOICE_PL
	
	*
	* Put up prompt
	*
	
	store SEL_NAME to L_TAIL
	store "Press   to Select ÄÙ when Done" to R_TAIL
	do TAIL
	
	*
	* Initialize variables
	*
	
	store 7 to DESC_ROW_1
	store space(65) to DESC_1
	
	store 8 to DESC_ROW_2
	store space(65) to DESC_2
	
	store 9 to DESC_ROW_3
	store space(65) to DESC_3
	
	store 10 to DESC_ROW_4
	store space(65) to DESC_4
	
	store 11 to DESC_ROW_5
	store space(65) to DESC_5
	
	store 12 to DESC_ROW_6
	store space(65) to DESC_6
	
	store 13 to DESC_ROW_7
	store space(65) to DESC_7
	
	store 14 to DESC_ROW_8
	store space(65) to DESC_8
	
	store 15 to DESC_ROW_9
	store space(65) to DESC_9
	
	*
	* Get the Menu choice entries and place in the window variables
	*
	* Display Schdule Steps in window in the following order
	* entry 1,2,3,,4,6,7,8,9 then 5 to have the cursor on the select bar (reverse video)
	*
	
	if (CHOICE_PL - 4) > 0
		goto CHOICE_PL - 4
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_1
		
	else
		store space(65) to DESC_1
		
	endif
	
	if CHOICE_PL - 3 > 0
		goto CHOICE_PL - 3
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_2
		
	else
		store space(65) to DESC_2
		
	endif
	
	if CHOICE_PL - 2 > 0
		goto CHOICE_PL - 2
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_3
		
	else
		store space(65) to DESC_3
		
	endif
	
	if CHOICE_PL - 1 > 0
		goto CHOICE_PL - 1
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_4
		
	else
		store space(65) to DESC_4
		
	endif
	
	goto CHOICE_PL
	store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_5
	
	if CHOICE_PL + 1 <= CHOICE_CNT
		goto CHOICE_PL + 1
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_6
		
	else
		store space(65) to DESC_6
		
	endif
	
	if CHOICE_PL + 2 <= CHOICE_CNT
		goto CHOICE_PL + 2
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_7
		
	else
		store space(65) to DESC_7
		
	endif
	
	if CHOICE_PL + 3 <= CHOICE_CNT
		goto CHOICE_PL + 3
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_8
		
	else
		store space(65) to DESC_8
		
	endif
	
	if CHOICE_PL + 4 <= CHOICE_CNT
		goto CHOICE_PL + 4
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_9
		
	else
		store space(65) to DESC_9
		
	endif
	
	@ DESC_ROW_1,10 say DESC_1
	@ DESC_ROW_2,10 say DESC_2
	@ DESC_ROW_3,10 say DESC_3
	@ DESC_ROW_4,10 say DESC_4
	@ DESC_ROW_6,10 say DESC_6
	@ DESC_ROW_7,10 say DESC_7
	@ DESC_ROW_8,10 say DESC_8
	@ DESC_ROW_9,10 say DESC_9
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ DESC_ROW_5,10 say DESC_5
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if CHOICE_PL <> 0
		goto CHOICE_PL
		
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
				store 1 to CHOICE_PL
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if CHOICE_PL - 9 > 1
					store CHOICE_PL - 9 to CHOICE_PL
					
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
				if CHOICE_PL + 9 < CHOICE_CNT
					store CHOICE_PL + 9 to CHOICE_PL
					
				else
					store CHOICE_CNT to CHOICE_PL
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store CHOICE_CNT to CHOICE_PL
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				goto CHOICE_PL
				
				store D_NXT_SCHD to DCD_SCHD
				store D_NXT_STEP to DCD_STEP
				
				store .t. to CHOICE_SEL
				store .f. to DO_MORE
				
			endcase
			
			if (CHOICE_PL - 4) > 0
				goto CHOICE_PL - 4
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_1
				
			else
				store space(65) to DESC_1
				
			endif
			
			if CHOICE_PL - 3 > 0
				goto CHOICE_PL - 3
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_2
				
			else
				store space(65) to DESC_2
				
			endif
			
			if CHOICE_PL - 2 > 0
				goto CHOICE_PL - 2
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_3
				
			else
				store space(65) to DESC_3
				
			endif
			
			if CHOICE_PL - 1 > 0
				goto CHOICE_PL - 1
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_4
				
			else
				store space(65) to DESC_4
				
			endif
			
			goto CHOICE_PL
			store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_5
			
			if CHOICE_PL + 1 <= CHOICE_CNT
				goto CHOICE_PL + 1
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_6
				
			else
				store space(65) to DESC_6
				
			endif
			
			if CHOICE_PL + 2 <= CHOICE_CNT
				goto CHOICE_PL + 2
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_7
				
			else
				store space(65) to DESC_7
				
			endif
			
			if CHOICE_PL + 3 <= CHOICE_CNT
				goto CHOICE_PL + 3
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_8
				
			else
				store space(65) to DESC_8
				
			endif
			
			if CHOICE_PL + 4 <= CHOICE_CNT
				goto CHOICE_PL + 4
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_9
				
			else
				store space(65) to DESC_9
				
			endif
			
			@ DESC_ROW_1,10 say DESC_1
			@ DESC_ROW_2,10 say DESC_2
			@ DESC_ROW_3,10 say DESC_3
			@ DESC_ROW_4,10 say DESC_4
			@ DESC_ROW_6,10 say DESC_6
			@ DESC_ROW_7,10 say DESC_7
			@ DESC_ROW_8,10 say DESC_8
			@ DESC_ROW_9,10 say DESC_9
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ DESC_ROW_5,10 say DESC_5
			
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
	store  "The &DCD_NAME menu is empty" to STAT_MSG
	do status
	
	store .f. to CHOICE_SEL
	store space(3) to CHOICE_CHC
	store space(65) to DPROMPT
	
endif

return



*: EOF: SCHOICE.PRG
