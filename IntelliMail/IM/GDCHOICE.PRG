*:*********************************************************************
*:
*:        Program: GDCHOICE.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 30-Sep-88 at 7:59 pm
*:
*:      Called by: DCDVIEW.PRG    
*:               : DCDADD.PRG     
*:               : DCDEDIT.PRG    
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : WRITEDCD.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 17:00               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GDCHOICE >>> Prompts the user to type in the decider menu choice    *
*	       entry : Open and selected schedule directory               *
*	       exit : DCD_CHOICE                                  	      *
*                 DPROMPT                                             *
*                 DCD_SEL                                             *
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

store reccount() to CHOICE_CNT

if CHOICE_CNT > 0 .or. REC_ADD
	
	if REC_ADD
		store .t. to CHOICE_ADD
		
	else
		store .f. to CHOICE_ADD
		
	endif
	
	store REC_NBR to CHOICE_PL
	
	if CHOICE_PL > 0 .and. CHOICE_PL < CHOICE_CNT + 1
		goto CHOICE_PL
		
	else
		if CHOICE_PL <> 0
			store 1 to CHOICE_PL
			
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
	
	store "Choice number " to CHOICE_P1
	store " in the &DCD_NAME decider menu" to CHOICE_P2
	
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
		store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
			space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_1
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_1
		
	else
		if CHOICE_PL - 2 = 0 .and. CHOICE_ADD
			store "ADD" + space(62) to CHOICE_1
			store "Select this choice if you wish to ADD a new step" + space(17) to DESC_1
			
		else
			store space(65) to CHOICE_1
			store space(65) to DESC_1
			
		endif
		
	endif
	
	if CHOICE_PL - 1 > 0
		goto CHOICE_PL - 1
		store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
			space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_2
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_2
		
	else
		if CHOICE_PL - 1 = 0 .and. CHOICE_ADD
			store "ADD" + space(62) to CHOICE_2
			store "Select this choice if you wish to ADD a new step" + space(17) to DESC_2
			
		else
			store space(65) to CHOICE_2
			store space(65) to DESC_2
			
		endif
		
	endif
	
	if CHOICE_PL > 0
		goto CHOICE_PL
		store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
			space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_3
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_3
		
	else
		store "ADD" + space(62) to CHOICE_3
		store "Select this choice if you wish to ADD a new step" + space(17) to DESC_3
		
	endif
	
	if CHOICE_PL + 1 <= CHOICE_CNT
		goto CHOICE_PL + 1
		store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
			space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_4
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_4
		
	else
		store space(65) to CHOICE_4
		store space(65) to DESC_4
		
	endif
	
	if CHOICE_PL + 2 <= CHOICE_CNT
		goto CHOICE_PL + 2
		store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
			space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_5
		store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_5
		
	else
		store space(65) to CHOICE_5
		store space(65) to DESC_5
		
	endif
	
	@ CHOICE_R_1,10 say CHOICE_1
	@ DESC_ROW_1,10 say DESC_1
	@ CHOICE_R_2,10 say CHOICE_2
	@ DESC_ROW_2,10 say DESC_2
	
	@ CHOICE_R_4,10 say CHOICE_4
	@ DESC_ROW_4,10 say DESC_4
	@ CHOICE_R_5,10 say CHOICE_5
	@ DESC_ROW_5,10 say DESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ CHOICE_R_3,10 say CHOICE_3
	@ DESC_ROW_3,10 say DESC_3
	
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
				if CHOICE_ADD
					store 0 to CHOICE_PL
					
				else
					store 1 to CHOICE_PL
					
				endif
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if CHOICE_ADD
					if CHOICE_PL - 5 > 0
						store CHOICE_PL - 5 to CHOICE_PL
						
					else
						store 0 to CHOICE_PL
						
					endif
					
				else
					if CHOICE_PL - 5 > 1
						store CHOICE_PL - 5 to CHOICE_PL
						
					else
						store 1 to CHOICE_PL
						
					endif
					
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if CHOICE_ADD
					if CHOICE_PL > 0
						store CHOICE_PL - 1 to CHOICE_PL
						
					endif
					
				else
					if CHOICE_PL > 1
						store CHOICE_PL - 1 to CHOICE_PL
						
					endif
					
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
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				store .t. to CHOICE_SEL
				store .f. to DO_MORE
				
				*
				* If CHOICE_PL = 0 then a new menu choice was
				* requested
				*
				
				if CHOICE_PL = 0
					store 1 to CHOICE
					store 20 to PICK_LINE
					store 2 to PICK_CNT
					store "Add choice to &DCD_NAME menu" to PICK_1
					store "Don't add" to PICK_2
					do PICK
					
					if CHOICE = 1
						append blank
						
						store recno() to TMP
						store ltrim(str(TMP)) + space(3 - len(ltrim(str(TMP)))) to DCHOICE
						store "This choice is ready to be changed                                 " to DPROMPT
						store "TRMNT" to NXT_SCHD
						store "   " to NXT_STEP
						store USER_LOGON to LOGON
						
						do WRITEDCD
						
						store recno() to CHOICE_PL
						
					else
						store .f. to CHOICE_SEL
						
					endif
					
				else
					goto CHOICE_PL
					
					store ltrim(str(CHOICE_PL,3)) + space(3 - len((ltrim(str(CHOICE_PL,3))))) to DCHOICE
					store D_DPROMPT to DPROMPT
					store .t. to CHOICE_SEL
					
				endif
				
				
				
			endcase
			
			if (CHOICE_PL - 2) > 0
				goto (CHOICE_PL - 2)
				store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
					space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_1
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_1
			else
				if CHOICE_PL - 2 = 0 .and. CHOICE_ADD
					store "ADD" + space(62) to CHOICE_1
					store "Select this choice if you wish to ADD a new step" + space(17) to DESC_1
					
				else
					store space(65) to CHOICE_1
					store space(65) to DESC_1
					
				endif
				
			endif
			
			if CHOICE_PL - 1 > 0
				goto CHOICE_PL - 1
				store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
					space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_2
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_2
			else
				if CHOICE_PL - 1 = 0 .and. CHOICE_ADD
					store "ADD" + space(62) to CHOICE_2
					store "Select this choice if you wish to ADD a new step" + space(17) to DESC_2
					
				else
					store space(65) to CHOICE_2
					store space(65) to DESC_2
					
				endif
				
			endif
			
			if CHOICE_PL > 0
				goto CHOICE_PL
				store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
					space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_3
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_3
				
			else
				store "ADD" + space(62) to CHOICE_3
				store "Select this choice if you wish to ADD a new step" + space(17) to DESC_3
				
			endif
			
			if CHOICE_PL + 1 <= CHOICE_CNT
				goto CHOICE_PL + 1
				store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
					space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_4
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_4
			else
				store space(65) to CHOICE_4
				store space(65) to DESC_4
			endif
			
			if CHOICE_PL + 2 <= CHOICE_CNT
				goto CHOICE_PL + 2
				store CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2 + ;
					space(65 - len(CHOICE_P1 + ltrim(str(D_DCHOICE)) + CHOICE_P2)) to CHOICE_5
				store D_DPROMPT + space(65 - len(D_DPROMPT)) to DESC_5
			else
				store space(65) to CHOICE_5
				store space(65) to DESC_5
			endif
			
			@ CHOICE_R_1,10 say CHOICE_1
			@ DESC_ROW_1,10 say DESC_1
			@ CHOICE_R_2,10 say CHOICE_2
			@ DESC_ROW_2,10 say DESC_2
			
			@ CHOICE_R_4,10 say CHOICE_4
			@ DESC_ROW_4,10 say DESC_4
			@ CHOICE_R_5,10 say CHOICE_5
			@ DESC_ROW_5,10 say DESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ CHOICE_R_3,10 say CHOICE_3
			@ DESC_ROW_3,10 say DESC_3
			
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



*: EOF: GDCHOICE.PRG
