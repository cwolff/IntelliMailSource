*:*********************************************************************
*:
*:        Program: GLNAME.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 30-Sep-88 at 8:01 pm
*:
*:      Called by: LTRMENU.PRG    
*:               : GETMRK.PRG     
*:               : GETSCH.PRG     
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:
*:           Uses: TMP.DBF        
*:               : &LTR_FNAME     
*:
*:     Documented: 09/04/88 at 16:57               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GLNAME >>> Prompts the user to select the letter from the letter dir*
*	       entry : Open and selected shedule directory                *
*                  REC_NBR = record number to point to                *
*	       exit : LTR_NAME                                 		      *
*                 LTR_DESC                                            *
*                 LTR_FNAME                                           *
*                 LTR_SEL                                             *
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

store reccount() to LTR_COUNT

if LTR_COUNT > 0 .or. REC_ADD
	
	if REC_ADD
		store .t. to LTR_ADD
		
	else
		store .f. to LTR_ADD
		
	endif
	
	store REC_NBR to LTR_PLACE
	
	if LTR_PLACE > 0 .and. LTR_PLACE < LTR_COUNT + 1
		goto LTR_PLACE
		
	else
		if LTR_PLACE <> 0
			store 1 to LTR_PLACE
			
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
	
	store " letter" to LTR_PMT
	
	store 7 to NAME_ROW_1
	store space(65) to NAME_1
	store 8 to DESC_ROW_1
	store space(65) to DESC_1
	
	store 9 to NAME_ROW_2
	store space(65) to NAME_2
	store 10 to DESC_ROW_2
	store space(65) to DESC_2
	
	store 11 to NAME_ROW_3
	store space(65) to NAME_3
	store 12 to DESC_ROW_3
	store space(65) to DESC_3
	
	store 13 to NAME_ROW_4
	store space(65) to NAME_4
	store 14 to DESC_ROW_4
	store space(65) to DESC_4
	
	store 15 to NAME_ROW_5
	store space(65) to NAME_5
	store 16 to DESC_ROW_5
	store space(65) to DESC_5
	
	*
	* Get the Letter Directory entries and place in the window variables
	*
	* Display Letter Directory in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (LTR_PLACE - 2) > 0
		goto (LTR_PLACE - 2)
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_1
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_1
	else
		if LTR_PLACE - 2 = 0 .and. LTR_ADD
			store "ADD" + space(62) to NAME_1
			store "Select this choice if you wish to ADD a new letter" + space(15) to DESC_1
			
		else
			store space(65) to NAME_1
			store space(65) to DESC_1
			
		endif
		
	endif
	
	if LTR_PLACE - 1 > 0
		goto LTR_PLACE - 1
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_2
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_2
	else
		if LTR_PLACE - 1 = 0 .and. LTR_ADD
			store "ADD" + space(62) to NAME_2
			store "Select this choice if you wish to ADD a new letter" + space(15) to DESC_2
			
		else
			store space(65) to NAME_2
			store space(65) to DESC_2
			
		endif
		
	endif
	
	if LTR_PLACE > 0
		goto LTR_PLACE
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_3
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_3
		
	else
		store "ADD" + space(62) to NAME_3
		store "Select this choice if you wish to ADD a new letter" + space(15) to DESC_3
		
	endif
	
	if LTR_PLACE + 1 <= LTR_COUNT
		goto LTR_PLACE + 1
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_4
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_4
	else
		store space(65) to NAME_4
		store space(65) to DESC_4
	endif
	
	if LTR_PLACE + 2 <= LTR_COUNT
		goto LTR_PLACE + 2
		store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_5
		store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_5
	else
		store space(65) to NAME_5
		store space(65) to DESC_5
	endif
	
	@ NAME_ROW_1,10 say NAME_1
	@ DESC_ROW_1,10 say DESC_1
	@ NAME_ROW_2,10 say NAME_2
	@ DESC_ROW_2,10 say DESC_2
	
	@ NAME_ROW_4,10 say NAME_4
	@ DESC_ROW_4,10 say DESC_4
	@ NAME_ROW_5,10 say NAME_5
	@ DESC_ROW_5,10 say DESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ NAME_ROW_3,10 say NAME_3
	@ DESC_ROW_3,10 say DESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if LTR_PLACE <> 0
		goto LTR_PLACE
		
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
				if LTR_ADD
					store 0 to LTR_PLACE
					
				else
					store 1 to LTR_PLACE
					
				endif
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if LTR_ADD
					if LTR_PLACE - 5 > 0
						store LTR_PLACE - 5 to LTR_PLACE
						
					else
						store 0 to LTR_PLACE
						
					endif
					
				else
					if LTR_PLACE - 5 > 1
						store LTR_PLACE - 5 to LTR_PLACE
						
					else
						store 1 to LTR_PLACE
						
					endif
					
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if LTR_ADD
					if LTR_PLACE > 0
						store LTR_PLACE - 1 to LTR_PLACE
						
					endif
					
				else
					if LTR_PLACE > 1
						store LTR_PLACE - 1 to LTR_PLACE
						
					endif
					
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if LTR_PLACE < LTR_COUNT
					store LTR_PLACE + 1 to LTR_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if LTR_PLACE + 5 < LTR_COUNT
					store LTR_PLACE + 5 to LTR_PLACE
					
				else
					store LTR_COUNT to LTR_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store LTR_COUNT to LTR_PLACE
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				
				*
				* If LTR_PLACE = 0 then a new letter name was
				* added, check to see if it's in the directory
				* if not check to see if it on disk, if it is
				* allow inform user and place in directory
				*
				
				if LTR_PLACE = 0
					save screen to GL_SCREEN
					
					@ 8,3  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
					@ 9,3  say "º                                                                     º Û"
					@ 10,3 say "º                                                                     º Û"
					@ 11,3 say "º                                                                     º Û"
					@ 12,3 say "º                                                                     º Û"
					@ 13,3 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
					@ 14,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
					
					store space(5) to LTR_NAME
					do while len(ltrim(trim(LTR_NAME))) <> 8
						store space(8) to LTR_NAME
						
						@ 10,5 say "Enter letter name (use 8 character names)."
						@ 11,5 say "Letter name ... " get LTR_NAME picture "!!!!!!!!"
						
						set confirm on
						
						read
						clear gets
						
						set confirm off
						
						store trim(upper(LTR_NAME)) to LTR_NAME
						
						if len(LTR_NAME) <> 8
							store 22 to STAT_LINE
							store "Letter names must be 8 characters long" to STAT_MSG
							do status
							
						endif
						
					enddo
					
					store "letter\" + LTR_NAME + ".LTR" to LTR_FNAME
					
					*
					* Check to see if already in letter directory
					*
					
					seek LTR_NAME
					
					if (bof() .or. eof())
						
						*
						* Check to see if File is on the disk
						*
						
						if file(LTR_FNAME)
							
							*
							* File is not in letter directory but exist on the
							* disk.  Inform user that file is being recovered
							*
							
							store 22 to STAT_LINE
							store "&LTR_NAME already on disk, adding to letter directory" to STAT_MSG
							do status
							
						endif
						
						@ 10,5 say space(65)
						@ 11,5 say space(65)
						
						store space(65) to LTR_DESC
						@ 10,5 say "Enter letter description for &LTR_NAME."
						@ 11,5 get LTR_DESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
						
						set confirm on
						
						read
						clear gets
						
						set confirm off
						
						store 1 to CHOICE
						store 20 to PICK_LINE
						store 2 to PICK_CNT
						store "Add &LTR_NAME to letter directory" to PICK_1
						store "Don't add" to PICK_2
						do PICK
						
						if CHOICE = 1
							
							*
							* If an LTR_NAME entry is not found
							* then append a new record
							* else overwrite the found LTR_LNAME entry
							* (since the file does not exist the entry is invalid)
							*
							
							append blank
							
							replace LTR_LNAME with LTR_NAME
							replace LTR_LDESC with LTR_DESC
							
							store recno() to LTR_PLACE
							
							sort to TMP on LTR_LNAME
							
							select LTRDIR
							use
							
							copy file TMP.DBF to LTRDIR.DBF
							
							delete file TMP.DBF
							
							store "10" to SELECT_NBR
							store "LTRDIR" to FILE_NAME
							store "LTRDIR" to ALIAS_NAME
							store "LTRDIR" to INDEX_NAME
							store "LTR_LNAME" to IFLD_NAME
							do OPENFILE
							
							if .not. (file(("letter\" + LTR_NAME + ".LTR")))
								store "1" to SELECT_NBR
								store "LETTER" to FILE_NAME
								store "LETTER" to ALIAS_NAME
								store "" to INDEX_NAME
								store "" to IFLD_NAME
								do OPENFILE
								
								if FILE_OPEN
									delete all
									pack
									
									append blank
									replace LTR_LINE with LTR_DESC
									append blank
									replace LTR_LINE with space(80)
									
									goto top
									
									store "letter\" + LTR_NAME + ".LTR" to LTR_FNAME
									copy to &LTR_FNAME sdf
									
									select LETTER
									use
									
								endif
								
							endif
							
							select LTRDIR
							
							store .f. to DO_MORE
							store .t. to LTR_SEL
							
						else
							store .f. to DO_MORE
							store .f. to LTR_SEL
							
						endif
						
					else
						store 22 to STAT_LINE
						store "Letter &LTR_NAME already in letter directory" to STAT_MSG
						do status
						
						store .f. to LTR_SEL
						
					endif
					
					restore screen from GL_SCREEN
					
				else
					goto LTR_PLACE
					
					store .f. to DO_MORE
					store .t. to LTR_SEL
					store LTR_LNAME to LTR_NAME
					store LTR_LDESC to LTR_DESC
					store "letter\" + LTR_LNAME + ".LTR" to LTR_FNAME
					
				endif
				
			endcase
			
			if (LTR_PLACE - 2) > 0
				goto (LTR_PLACE - 2)
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_1
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_1
			else
				if LTR_PLACE - 2 = 0 .and. LTR_ADD
					store "ADD" + space(62) to NAME_1
					store "Select this choice if you wish to ADD a new letter" + space(15) to DESC_1
					
				else
					store space(65) to NAME_1
					store space(65) to DESC_1
					
				endif
				
			endif
			
			if LTR_PLACE - 1 > 0
				goto LTR_PLACE - 1
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_2
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_2
			else
				if LTR_PLACE - 1 = 0 .and. LTR_ADD
					store "ADD" + space(62) to NAME_2
					store "Select this choice if you wish to ADD a new letter" + space(15) to DESC_2
					
				else
					store space(65) to NAME_2
					store space(65) to DESC_2
					
				endif
				
			endif
			
			if LTR_PLACE > 0
				goto LTR_PLACE
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_3
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_3
				
			else
				store "ADD" + space(62) to NAME_3
				store "Select this choice if you wish to ADD a new letter" + space(15) to DESC_3
				
			endif
			
			
			if LTR_PLACE + 1 <= LTR_COUNT
				goto LTR_PLACE + 1
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_4
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_4
			else
				store space(65) to NAME_4
				store space(65) to DESC_4
			endif
			
			if LTR_PLACE + 2 <= LTR_COUNT
				goto LTR_PLACE + 2
				store LTR_LNAME + LTR_PMT + space(65 - len(LTR_LNAME + LTR_PMT)) to NAME_5
				store LTR_LDESC + space(65 - len(LTR_LDESC)) to DESC_5
			else
				store space(65) to NAME_5
				store space(65) to DESC_5
			endif
			
			@ NAME_ROW_1,10 say NAME_1
			@ DESC_ROW_1,10 say DESC_1
			@ NAME_ROW_2,10 say NAME_2
			@ DESC_ROW_2,10 say DESC_2
			
			@ NAME_ROW_4,10 say NAME_4
			@ DESC_ROW_4,10 say DESC_4
			@ NAME_ROW_5,10 say NAME_5
			@ DESC_ROW_5,10 say DESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ NAME_ROW_3,10 say NAME_3
			@ DESC_ROW_3,10 say DESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if LTR_PLACE <> 0
				goto LTR_PLACE
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The letter directory is empty" to STAT_MSG
	do status
	
	store .f. to LTR_SEL
	store space(8) to LTR_LNAME
	store LTR_LNAME + "LTR" to LTR_FNAME
	
endif

return


*: EOF: GLNAME.PRG
