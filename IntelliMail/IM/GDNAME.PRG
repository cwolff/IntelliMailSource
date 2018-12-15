*:*********************************************************************
*:
*:        Program: GDNAME.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 30-Sep-88 at 7:58 pm
*:
*:      Called by: DCDVIEW.PRG    
*:               : DCDADD.PRG     
*:               : DCDEDIT.PRG    
*:               : DCDPRINT.PRG   
*:               : GETSCH.PRG     
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : WRITEDCD.PRG
*:
*:           Uses: TMP.DBF        
*:               : &DCD_FNAME.DBF 
*:
*:        Indexes: &DCD_FNDX
*:
*:     Documented: 09/04/88 at 17:00               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GDNAME >>> Prompts the user to type in the menu name                *
*	       entry : Open and selected shedule directory                *
*                  REC_NBR = record number to point to                *
*	       exit : DCD_NAME                                 		      *
*                 DCD_DESC                                            *
*                 DCD_FNAME                                           *
*                 DCD_SEL                                             *
*                 REC_NBR                                             *
*                 REC_ADD                                             *
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

store reccount() to DCD_COUNT

if DCD_COUNT > 0 .or. REC_ADD
	
	if REC_ADD
		store .t. to DCD_ADD
		
	else
		store .f. to DCD_ADD
		
	endif
	
	store REC_NBR to DCD_PLACE
	
	if DCD_PLACE > 0 .and. DCD_PLACE < DCD_COUNT + 1
		goto DCD_PLACE
		
	else
		if DCD_PLACE <> 0
			store 1 to DCD_PLACE
			
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
	
	store " decider menu" to DCD_PMT
	
	store 6 to NAME_ROW_1
	store space(65) to NAME_1
	store 7 to DESC_ROW_1
	store space(65) to DESC_1
	
	store 8 to NAME_ROW_2
	store space(65) to NAME_2
	store 9 to DESC_ROW_2
	store space(65) to DESC_2
	
	store 10 to NAME_ROW_3
	store space(65) to NAME_3
	store 11 to DESC_ROW_3
	store space(65) to DESC_3
	
	store 12 to NAME_ROW_4
	store space(65) to NAME_4
	store 13 to DESC_ROW_4
	store space(65) to DESC_4
	
	store 14 to NAME_ROW_5
	store space(65) to NAME_5
	store 15 to DESC_ROW_5
	store space(65) to DESC_5
	
	*
	* Get the Menu Directory entries and place in the window variables
	*
	* Display Menu Directory in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (DCD_PLACE - 2) > 0
		goto (DCD_PLACE - 2)
		store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_1
		store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_1
	else
		if DCD_PLACE - 2 = 0 .and. DCD_ADD
			store "ADD" + space(62) to NAME_1
			store "Select this choice if you wish to ADD a new menu" + space(17) to DESC_1
			
		else
			store space(65) to NAME_1
			store space(65) to DESC_1
			
		endif
		
	endif
	
	if DCD_PLACE - 1 > 0
		goto DCD_PLACE - 1
		store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_2
		store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_2
	else
		if DCD_PLACE - 1 = 0 .and. DCD_ADD
			store "ADD" + space(62) to NAME_2
			store "Select this choice if you wish to ADD a new menu" + space(17) to DESC_2
			
		else
			store space(65) to NAME_2
			store space(65) to DESC_2
			
		endif
		
	endif
	
	if DCD_PLACE > 0
		goto DCD_PLACE
		store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_3
		store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_3
		
	else
		store "ADD" + space(62) to NAME_3
		store "Select this choice if you wish to ADD a new menu" + space(17) to DESC_3
		
	endif
	
	if DCD_PLACE + 1 <= DCD_COUNT
		goto DCD_PLACE + 1
		store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_4
		store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_4
	else
		store space(65) to NAME_4
		store space(65) to DESC_4
	endif
	
	if DCD_PLACE + 2 <= DCD_COUNT
		goto DCD_PLACE + 2
		store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_5
		store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_5
	else
		store space(65) to NAME_5
		store space(65) to DESC_5
	endif
	
	@ NAME_ROW_1,6 say NAME_1
	@ DESC_ROW_1,6 say DESC_1
	@ NAME_ROW_2,6 say NAME_2
	@ DESC_ROW_2,6 say DESC_2
	
	@ NAME_ROW_4,6 say NAME_4
	@ DESC_ROW_4,6 say DESC_4
	@ NAME_ROW_5,6 say NAME_5
	@ DESC_ROW_5,6 say DESC_5
	
	if COLOR_SCRN
		set color to w+/b,w+/n,n,n
	else
		set color to n/w,w+/n,n,n
	endif
	
	@ NAME_ROW_3,6 say NAME_3
	@ DESC_ROW_3,6 say DESC_3
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	if DCD_PLACE <> 0
		goto DCD_PLACE
		
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
				if DCD_ADD
					store 0 to DCD_PLACE
					
				else
					store 1 to DCD_PLACE
					
				endif
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if DCD_ADD
					if DCD_PLACE - 5 > 0
						store DCD_PLACE - 5 to DCD_PLACE
						
					else
						store 0 to DCD_PLACE
						
					endif
					
				else
					if DCD_PLACE - 5 > 1
						store DCD_PLACE - 5 to DCD_PLACE
						
					else
						store 1 to DCD_PLACE
						
					endif
					
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if DCD_ADD
					if DCD_PLACE > 0
						store DCD_PLACE - 1 to DCD_PLACE
						
					endif
					
				else
					if DCD_PLACE > 1
						store DCD_PLACE - 1 to DCD_PLACE
						
					endif
					
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if DCD_PLACE < DCD_COUNT
					store DCD_PLACE + 1 to DCD_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if DCD_PLACE + 5 < DCD_COUNT
					store DCD_PLACE + 5 to DCD_PLACE
					
				else
					store DCD_COUNT to DCD_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store DCD_COUNT to DCD_PLACE
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				
				*
				* If DCD_PLACE = 0 then a new menu name was
				* added, check to see if it's in the directory
				* if not check to see if it on disk, if it is
				* allow inform user and place in directory
				*
				
				if DCD_PLACE = 0
					save screen to GD_SCREEN
					
					@ 8,3  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
					@ 9,3  say "º                                                                     º Û"
					@ 10,3 say "º                                                                     º Û"
					@ 11,3 say "º                                                                     º Û"
					@ 12,3 say "º                                                                     º Û"
					@ 13,3 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
					@ 14,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
					
					store space(5) to DCD_NAME
					do while len(ltrim(trim(DCD_NAME))) <> 5 .or. DCD_NAME = "TRMNT"
						store space(5) to DCD_NAME
						
						@ 10,5 say "Enter menu name (use 5 character names)."
						@ 11,5 say "Menu name ... " get DCD_NAME picture "!!!!!"
						
						set confirm on
						
						read
						clear gets
						
						set confirm off
						
						store trim(upper(DCD_NAME)) to DCD_NAME
						
						if len(DCD_NAME) <> 5
							store 22 to STAT_LINE
							store "Menu names must be 5 characters long" to STAT_MSG
							do status
							
						endif
						
					enddo
					
					store DCD_NAME + "DCD" to DCD_FNAME
					store DCD_NAME + "DCD" to DCD_FNDX
					
					*
					* Check to see if already in menu directory
					*
					
					seek DCD_NAME
					
					if (bof() .or. eof())
						
						*
						* Check to see if File is on the disk
						*
						
						if file((DCD_FNAME + ".DBF"))
							
							*
							* File is not in menu directory but exist on the
							* disk.  Inform user that file is being recovered
							*
							
							store 22 to STAT_LINE
							store "&DCD_NAME already on disk, adding to dedider menu directory" to STAT_MSG
							do status
							
						endif
						
						@ 10,5 say space(65)
						@ 11,5 say space(65)
						
						store space(65) to DCD_DESC
						@ 10,5 say "Enter menu description for &DCD_NAME."
						@ 11,5 get DCD_DESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
						
						set confirm on
						
						read
						clear gets
						
						set confirm off
						
						store 1 to CHOICE
						store 20 to PICK_LINE
						store 2 to PICK_CNT
						store "Add &DCD_NAME to menu directory" to PICK_1
						store "Don't add" to PICK_2
						do PICK
						
						if CHOICE = 1
							
							*
							* If an DCD_NAME entry is not found
							* then append a new record
							* else overwrite the found DCD_NAME entry
							* (since the file does not exist the entry is invalid)
							*
							
							append blank
							
							replace DCD_DNAME with DCD_NAME
							replace DCD_DDESC with DCD_DESC
							
							store recno() to DCD_PLACE
							
							sort to TMP on DCD_DNAME
							
							select DCDDIR
							use
							
							copy file TMP.DBF to DCDDIR.DBF
							
							delete file TMP.DBF
							
							store "8" to SELECT_NBR
							store "DCDDIR" to FILE_NAME
							store "DCDDIR" to ALIAS_NAME
							store "DCDDIR" to INDEX_NAME
							store "DCD_DNAME" to IFLD_NAME
							do OPENFILE
							
							*
							* If file already exist don't override it
							* but reindex it just in case
							*
							
							if .not. (file((DCD_FNAME + ".DBF")))
								store "9" to SELECT_NBR
								store "DCDTMP" to FILE_NAME
								store "DCD" to ALIAS_NAME
								store "" to INDEX_NAME
								store "" to IFLD_NAME
								do OPENFILE
								
								if FILE_OPEN
									copy structure to &DCD_FNAME
									
									select DCD
									use
									
									store "9" to SELECT_NBR
									store DCD_FNAME to FILE_NAME
									store "DCD" to ALIAS_NAME
									store "" to INDEX_NAME
									store "" to IFLD_NAME
									do OPENFILE
									
									append blank
									
									store "1  " to DCHOICE
									store "This choice was added when this menu was created               " to DPROMPT
									store "TRMNT" to NXT_SCHD
									store "   " to NXT_STEP
									
									do WRITEDCD
									
									store recno() to DCD_PLACE
									
									select DCD
									use
									
								endif
								
							endif
							
							store "9" to SELECT_NBR
							store DCD_FNAME to FILE_NAME
							store "DCD" to ALIAS_NAME
							store "" to INDEX_NAME
							store "" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								index on D_DCHOICE to &DCD_FNDX
								
								select DCD
								use
								
							endif
							
							select DCDDIR
							
							store .f. to DO_MORE
							store .t. to DCD_SEL
							
						else
							store .f. to DO_MORE
							store .f. to DCD_SEL
							
						endif
						
					else
						store 22 to STAT_LINE
						store "Menu &DCD_NAME already in decider menu directory" to STAT_MSG
						do status
						
						store .f. to DCD_SEL
						
					endif
					
					restore screen from GD_SCREEN
					
				else
					goto DCD_PLACE
					
					store .f. to DO_MORE
					store .t. to DCD_SEL
					store DCD_DNAME to DCD_NAME
					store DCD_DDESC to DCD_DESC
					store DCD_NAME + "DCD" to DCD_FNAME
					store DCD_NAME + "DCD" to DCD_FNDX
					
				endif
				
			endcase
			
			if (DCD_PLACE - 2) > 0
				goto (DCD_PLACE - 2)
				store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_1
				store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_1
			else
				if DCD_PLACE - 2 = 0 .and. DCD_ADD
					store "ADD" + space(62) to NAME_1
					store "Select this choice if you wish to ADD a new menu" + space(17) to DESC_1
					
				else
					store space(65) to NAME_1
					store space(65) to DESC_1
					
				endif
				
			endif
			
			if DCD_PLACE - 1 > 0
				goto DCD_PLACE - 1
				store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_2
				store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_2
			else
				if DCD_PLACE - 1 = 0 .and. DCD_ADD
					store "ADD" + space(62) to NAME_2
					store "Select this choice if you wish to ADD a new menu" + space(17) to DESC_2
					
				else
					store space(65) to NAME_2
					store space(65) to DESC_2
					
				endif
				
			endif
			
			if DCD_PLACE > 0
				goto DCD_PLACE
				store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_3
				store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_3
				
			else
				store "ADD" + space(62) to NAME_3
				store "Select this choice if you wish to ADD a new menu" + space(17) to DESC_3
				
			endif
			
			if DCD_PLACE + 1 <= DCD_COUNT
				goto DCD_PLACE + 1
				store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_4
				store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_4
			else
				store space(65) to NAME_4
				store space(65) to DESC_4
			endif
			
			if DCD_PLACE + 2 <= DCD_COUNT
				goto DCD_PLACE + 2
				store DCD_DNAME + DCD_PMT + space(65 - len(DCD_DNAME + DCD_PMT)) to NAME_5
				store DCD_DDESC + space(65 - len(DCD_DDESC)) to DESC_5
			else
				store space(65) to NAME_5
				store space(65) to DESC_5
			endif
			
			@ NAME_ROW_1,6 say NAME_1
			@ DESC_ROW_1,6 say DESC_1
			@ NAME_ROW_2,6 say NAME_2
			@ DESC_ROW_2,6 say DESC_2
			
			@ NAME_ROW_4,6 say NAME_4
			@ DESC_ROW_4,6 say DESC_4
			@ NAME_ROW_5,6 say NAME_5
			@ DESC_ROW_5,6 say DESC_5
			
			if COLOR_SCRN
				set color to w+/b,w+/n,n,n
			else
				set color to n/w,w+/n,n,n
			endif
			
			@ NAME_ROW_3,6 say NAME_3
			@ DESC_ROW_3,6 say DESC_3
			
			if COLOR_SCRN
				set color to g/n,w+/n,n,n
			else
				set color to w/n,w+/n,n,n
			endif
			
			if DCD_PLACE <> 0
				goto DCD_PLACE
				
			endif
			
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The menu directory is empty" to STAT_MSG
	do status
	
	store .f. to DCD_SEL
	store space(5) to DCD_DNAME
	store DCD_DNAME + "DCD" to DCD_FNAME
	store DCD_DNAME + "DCD" to DCD_FNDX
	store DCD_DNAME + "LST" to DCD_LTTR
	
endif

return


*: EOF: GDNAME.PRG
