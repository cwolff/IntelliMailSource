*:*********************************************************************
*:
*:        Program: GMNAME.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 2:50 pm
*:
*:      Called by: ADVMENU.PRG    
*:               : CLIVIEW.PRG    
*:               : CLIEDIT.PRG    
*:               : CLIPRINT.PRG   
*:               : MRKMOVE.PRG    
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GMNAME >>> Prompts the user to type in the schedule name            *
*	       entry : Open and selected schedule directory               *
*	       exit : MRK_SEL                                             *
*                 MRK_SNAME                                           *
*                 MRK_FNAME                                           *
*                 MRK_FNDX                                            *
*									                                  *
***********************************************************************

*
* Open window
*

@ 5,5  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
@ 6,5  say "º                                                                 º Û"
@ 7,5  say "º                                                                 º Û"
@ 8,5  say "º                                                                 º Û"
@ 9,5  say "º                                                                 º Û"
@ 10,5 say "º                                                                 º Û"
@ 11,5 say "º                                                                 º Û"
@ 12,5 say "º                                                                 º Û"
@ 13,5 say "º                                                                 º Û"
@ 14,5 say "º                                                                 º Û"
@ 15,5 say "º                                                                 º Û"
@ 16,5 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
@ 17,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

*
* Make sure the directory is not empty
*

store reccount() to MRK_COUNT
store 1 to MRK_PLACE
goto top

if MRK_COUNT > 0
	
	*
	* Put up prompt
	*
	
	store SEL_NAME to L_TAIL
	store "Press   to Select ÄÙ when Done" to R_TAIL
	do TAIL
	
	*
	* Initialize variables
	*
	
	store "This marker is pointing to the " to MRK_PMT1
	store " schedule" to MRK_PMT2
	
	store 6 to MNAME_ROW1
	store space(65) to MNAME_1
	store 7 to MDESC_ROW1
	store space(65) to MDESC_1
	
	store 8 to MNAME_ROW2
	store space(65) to MNAME_2
	store 9 to MDESC_ROW2
	store space(65) to MDESC_2
	
	store 10 to MNAME_ROW3
	store space(65) to MNAME_3
	store 11 to MDESC_ROW3
	store space(65) to MDESC_3
	
	store 12 to MNAME_ROW4
	store space(65) to MNAME_4
	store 13 to MDESC_ROW4
	store space(65) to MDESC_4
	
	store 14 to MNAME_ROW5
	store space(65) to MNAME_5
	store 15 to MDESC_ROW5
	store space(65) to MDESC_5
	
	*
	* Get the Schedule Directory entries and place in the window variables
	*
	* Display Schedule Directory in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (MRK_PLACE - 2) > 0
		goto (MRK_PLACE - 2)
		store MRK_PMT1 + SCHD_SNAME + space(65 - len(MRK_PMT1 + SCH_SNAME)) to MNAME_1
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_1
	else
		store space(65) to MNAME_1
		store space(65) to MDESC_1
	endif
	
	if MRK_PLACE - 1 > 0
		goto MRK_PLACE - 1
		store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_2
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_2
	else
		store space(65) to MNAME_2
		store space(65) to MDESC_2
	endif
	
	goto MRK_PLACE
	store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_3
	store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_3
	
	if MRK_PLACE + 1 <= MRK_COUNT
		goto MRK_PLACE + 1
		store MRK_PMT1 + SCHD_SNAME + + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_4
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_4
	else
		store space(65) to MNAME_4
		store space(65) to MDESC_4
	endif
	
	if MRK_PLACE + 2 <= MRK_COUNT
		goto MRK_PLACE + 2
		store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_5
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_5
	else
		store space(65) to MNAME_5
		store space(65) to MDESC_5
	endif
	
	@ MNAME_ROW1,6 say MNAME_1
	@ MDESC_ROW1,6 say MDESC_1
	@ MNAME_ROW2,6 say MNAME_2
	@ MDESC_ROW2,6 say MDESC_2
	
	@ MNAME_ROW4,6 say MNAME_4
	@ MDESC_ROW4,6 say MDESC_4
	@ MNAME_ROW5,6 say MNAME_5
	@ MDESC_ROW5,6 say MDESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ MNAME_ROW3,6 say MNAME_3
	@ MDESC_ROW3,6 say MDESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if MRK_PLACE <> 0
		goto MRK_PLACE
		
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
				store 1 to MRK_PLACE
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if MRK_PLACE - 5 > 1
					store MRK_PLACE - 5 to MRK_PLACE
					
				else
					store 1 to MRK_PLACE
					
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if MRK_PLACE > 1
					store MRK_PLACE - 1 to MRK_PLACE
					
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if MRK_PLACE < MRK_COUNT
					store MRK_PLACE + 1 to MRK_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if MRK_PLACE + 5 < MRK_COUNT
					store MRK_PLACE + 5 to MRK_PLACE
					
				else
					store MRK_COUNT to MRK_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store MRK_COUNT to MRK_PLACE
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				goto MRK_PLACE
				
				store .f. to DO_MORE
				store .t. to MRK_SEL
				store SCHD_SNAME to MRK_SNAME
				store MRK_SNAME + "SCH" to MRK_FNAME
				store MRK_SNAME + "SCH" to MRK_FNDX
				
			endcase
			
			if (MRK_PLACE - 2) > 0
				goto (MRK_PLACE - 2)
				store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_1
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_1
			else
				store space(65) to MNAME_1
				store space(65) to MDESC_1
			endif
			
			if MRK_PLACE - 1 > 0
				goto MRK_PLACE - 1
				store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_2
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_2
			else
				store space(65) to MNAME_2
				store space(65) to MDESC_2
			endif
			
			goto MRK_PLACE
			store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_3
			store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_3
			
			if MRK_PLACE + 1 <= MRK_COUNT
				goto MRK_PLACE + 1
				store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_4
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_4
			else
				store space(65) to MNAME_4
				store space(65) to MDESC_4
			endif
			
			if MRK_PLACE + 2 <= MRK_COUNT
				goto MRK_PLACE + 2
				store MRK_PMT1 + SCHD_SNAME + MRK_PMT2 + space(65 - len(MRK_PMT1 + SCH_SNAME + MRK_PMT2)) to MNAME_5
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to MDESC_5
			else
				store space(65) to MNAME_5
				store space(65) to MDESC_5
			endif
			
			@ MNAME_ROW1,6 say MNAME_1
			@ MDESC_ROW1,6 say MDESC_1
			@ MNAME_ROW2,6 say MNAME_2
			@ MDESC_ROW2,6 say MDESC_2
			
			@ MNAME_ROW4,6 say MNAME_4
			@ MDESC_ROW4,6 say MDESC_4
			@ MNAME_ROW5,6 say MNAME_5
			@ MDESC_ROW5,6 say MDESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ MNAME_ROW3,6 say MNAME_3
			@ MDESC_ROW3,6 say MDESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if MRK_PLACE <> 0
				goto MRK_PLACE
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The schedule directory is empty" to STAT_MSG
	do status
	
	store .f. to MRK_SEL
	store space(8) to MRK_SNAME
	store MRK_SNAME + "SCH" to MRK_FNAME
	store MRK_SNAME + "SCH" to MRK_FNDX
	
endif

return


*: EOF: GMNAME.PRG
