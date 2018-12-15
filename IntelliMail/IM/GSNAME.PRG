*:*********************************************************************
*:
*:        Program: GSNAME.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 8:06 pm
*:
*:      Called by: SENDMENU.PRG   
*:               : CLIADD.PRG     
*:               : MRKMOVE.PRG    
*:               : EDITMRK.PRG    
*:               : SCHDVIEW.PRG   
*:               : SCHDADD.PRG    
*:               : SCHDEDIT.PRG   
*:               : SCHPRINT.PRG   
*:               : ADDMRK.PRG     
*:               : GETSCH.PRG     
*:               : GETDCD.PRG     
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : WRITESCH         (procedure in UTILITY.PRG)
*:
*:           Uses: TMP.DBF        
*:               : &SCH_FNAME.DBF 
*:
*:        Indexes: &SCH_FNDX
*:
*:     Documented: 09/04/88 at 16:57               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GSNAME >>> Prompts the user to type in the schedule name            *
*	       entry : Open and selected shedule directory                *
*                  REC_NBR = record number to point to                *
*	       exit : SCH_SNAME                                 		  *
*                 SCH_SDESC                                           *
*                 SCH_FNAME                                           *
*                 SCH_FNDX                                            *
*                 SCH_LTTR                                            *
*                 SCH_SEL                                             *
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

store reccount() to SCHD_COUNT

if SCHD_COUNT > 0 .or. REC_ADD
	
	if REC_ADD
		store .t. to SCHD_ADD
		
	else
		store .f. to SCHD_ADD
		
	endif
	
	store REC_NBR to SCHD_PLACE
	
	if SCHD_PLACE > 0 .and. SCHD_PLACE < SCHD_COUNT + 1
		goto SCHD_PLACE
		
	else
		if SCHD_PLACE <> 0
			store 1 to SCHD_PLACE
			
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
	
	store " schedule" to SCHD_PMT
	
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
	* Get the Schedule Directory entries and place in the window variables
	*
	* Display Schedule Directory in window in the following order
	* entry 1,2,4,5 then 3 to have the cursor on the select bar (reverse video)
	*
	
	if (SCHD_PLACE - 2) > 0
		goto (SCHD_PLACE - 2)
		store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_1
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_1
	else
		if SCHD_PLACE - 1 = 0 .and. SCHD_ADD
			store "ADD" + space(62) to NAME_1
			store "Select this choice if you wish to ADD a new schedule" + space(13) to DESC_1
			
		else
			store space(65) to NAME_1
			store space(65) to DESC_1
			
		endif
		
	endif
	
	if SCHD_PLACE - 1 > 0
		goto SCHD_PLACE - 1
		store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_2
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_2
	else
		if SCHD_PLACE - 1 = 0 .and. SCHD_ADD
			store "ADD" + space(62) to NAME_2
			store "Select this choice if you wish to ADD a new schedule" + space(13) to DESC_2
			
		else
			store space(65) to NAME_2
			store space(65) to DESC_2
			
		endif
		
		store space(65) to NAME_2
		store space(65) to DESC_2
	endif
	
	if SCHD_PLACE > 0
		goto SCHD_PLACE
		store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_3
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_3
		
	else
		store "ADD" + space(62) to NAME_3
		store "Select this choice if you wish to ADD a new schedule" + space(13) to DESC_3
		
	endif
	
	if SCHD_PLACE + 1 <= SCHD_COUNT
		goto SCHD_PLACE + 1
		store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_4
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_4
	else
		store space(65) to NAME_4
		store space(65) to DESC_4
	endif
	
	if SCHD_PLACE + 2 <= SCHD_COUNT
		goto SCHD_PLACE + 2
		store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_5
		store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_5
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
	
	if SCHD_PLACE <> 0
		goto SCHD_PLACE
		
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
				if SCHD_ADD
					store 0 to SCHD_PLACE
					
				else
					store 1 to SCHD_PLACE
					
				endif
				
				*
				* PgUp
				*
				
			case key = 18 .or. key = 31
				if SCHD_ADD
					if SCHD_PLACE - 5 > 0
						store SCHD_PLACE - 5 to SCHD_PLACE
						
					else
						store 0 to SCHD_PLACE
						
					endif
					
				else
					if SCHD_PLACE - 5 > 1
						store SCHD_PLACE - 5 to SCHD_PLACE
						
					else
						store 1 to SCHD_PLACE
						
					endif
					
				endif
				
				*
				* Up Arrow () for UP
				*
				
			case key = 5 .or. key = 56
				if SCHD_ADD
					if SCHD_PLACE > 0
						store SCHD_PLACE - 1 to SCHD_PLACE
						
					endif
					
				else
					if SCHD_PLACE > 1
						store SCHD_PLACE - 1 to SCHD_PLACE
						
					endif
					
				endif
				
				*
				* Down Arrow () for DOWN
				*
				
			case key = 24 .or. key = 50
				if SCHD_PLACE < SCHD_COUNT
					store SCHD_PLACE + 1 to SCHD_PLACE
					
				endif
				
				*
				* PgDn
				*
				
			case key = 3 .or. key = 30
				if SCHD_PLACE + 5 < SCHD_COUNT
					store SCHD_PLACE + 5 to SCHD_PLACE
					
				else
					store SCHD_COUNT to SCHD_PLACE
					
				endif
				
				*
				* End
				*
				
			case key = 6 .or. key = 23
				store SCHD_COUNT to SCHD_PLACE
				
				*
				* RET KEY (ÄÄÙ) when DONE
				*
				
			case key = 13
				
				*
				* If SCHD_PLACE = 0 then a new schedule name was
				* added, check to see if it's in the directory
				* if not check to see if it on disk, if it is
				* allow inform user and place in directory
				*
				
				if SCHD_PLACE = 0
					save screen to GSN_SCREEN
					
					@ 8,3  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
					@ 9,3  say "º                                                                     º Û"
					@ 10,3 say "º                                                                     º Û"
					@ 11,3 say "º                                                                     º Û"
					@ 12,3 say "º                                                                     º Û"
					@ 13,3 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
					@ 14,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
					
					store space(5) to SCH_NAME
					do while len(ltrim(trim(SCH_NAME))) <> 5 .or. SCH_NAME = "TRMNT"
						store space(5) to SCH_NAME
						
						@ 10,5 say "Enter schedule name (use 5 character names)."
						@ 11,5 say "Schedule name ... " get SCH_NAME picture "!!!!!"
						
						set confirm on
						
						read
						clear gets
						
						set confirm off
						
						store trim(upper(SCH_NAME)) to SCH_NAME
						
						do case
						case SCH_NAME = "TRMNT"
							store 22 to STAT_LINE
							store "TRMNT cannot be used to name a schedule" to STAT_MSG
							do status
							
						case len(SCH_NAME) <> 5
							store 22 to STAT_LINE
							store "Schedule names must be 5 characters long" to STAT_MSG
							do status
							
						endcase
						
					enddo
					
					store trim(upper(SCH_NAME)) to SCH_SNAME
					store SCH_SNAME + "SCH" to SCH_FNAME
					store SCH_SNAME + "SCH" to SCH_FNDX
					store SCH_SNAME + "LST" to SCH_LTTR
					
					*
					* Check to see if already in schedule directory
					*
					
					seek SCH_SNAME
					
					if (bof() .or. eof())
						
						*
						* Check to see if File is on the disk
						*
						
						if file((SCH_FNAME + ".DBF"))
							
							*
							* File is not in schedule directory but exist on the
							* disk.  Inform user that file is being recovered
							*
							
							store 22 to STAT_LINE
							store "&SCH_SNAME already on disk, adding to schedule directory" to STAT_MSG
							do status
							
						endif
						
						@ 10,5 say space(65)
						@ 11,5 say space(65)
						
						store space(65) to SCH_SDESC
						@ 10,5 say "Enter schedule description for &SCH_SNAME."
						@ 11,5 get SCH_SDESC picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
						
						set confirm on
						
						read
						clear gets
						
						set confirm off
						
						store 1 to CHOICE
						store 20 to PICK_LINE
						store 2 to PICK_CNT
						store "Add &SCH_SNAME to schedule directory" to PICK_1
						store "Don't add" to PICK_2
						do PICK
						
						if CHOICE = 1
							
							*
							* If an SCHD_SNAME entry is not found
							* then append a new record
							* else overwrite the found SCH_SNAME entry
							* (since the file does not exist the entry is invalid)
							*
							
							append blank
							
							replace SCHD_SNAME with SCH_SNAME
							replace SCHD_SDESC with SCH_SDESC
							
							sort to TMP on SCHD_SNAME
							
							select SCHDDIR
							use
							
							copy file TMP.DBF to SCHDDIR.DBF
							
							delete file TMP.DBF
							
							store "8" to SELECT_NBR
							store "SCHDDIR" to FILE_NAME
							store "SCHDDIR" to ALIAS_NAME
							store "SCHDDIR" to INDEX_NAME
							store "SCHD_SNAME" to IFLD_NAME
							do OPENFILE
							
							*
							* If file already exist don't override it
							* but reindex it just in case
							*
							
							if .not. (file((SCH_FNAME + ".DBF")))
								store "7" to SELECT_NBR
								store "SCHDTMP" to FILE_NAME
								store "SCHD" to ALIAS_NAME
								store "" to INDEX_NAME
								store "" to IFLD_NAME
								do OPENFILE
								
								if FILE_OPEN
									copy structure to &SCH_FNAME
									
									select SCHD
									use
									
									store "7" to SELECT_NBR
									store SCH_FNAME to FILE_NAME
									store "SCHD" to ALIAS_NAME
									store "" to INDEX_NAME
									store "" to IFLD_NAME
									do OPENFILE
									
									append blank
									
									store "1  " to STEP
									store "This step was added when this schedule was created               " to SDESC
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
									
									store recno() to SCHD_PLACE
									
									select SCHD
									use
									
								endif
								
							endif
							
							store "7" to SELECT_NBR
							store SCH_FNAME to FILE_NAME
							store "SCHD" to ALIAS_NAME
							store "" to INDEX_NAME
							store "" to IFLD_NAME
							do OPENFILE
							
							if FILE_OPEN
								index on S_STEP to &SCH_FNDX
								
								select SCHD
								use
								
							endif
							
							select SCHDDIR
							
							store .f. to DO_MORE
							store .t. to SCH_SEL
							
						else
							store .f. to DO_MORE
							store .f. to SCH_SEL
							
						endif
						
					else
						store 22 to STAT_LINE
						store "Schedule &SCH_SNAME already exists in schedule directory" to STAT_MSG
						do status
						
						store .f. to SCH_SEL
						
					endif
					
					restore screen from GSN_SCREEN
					
				else
					goto SCHD_PLACE
					
					store .f. to DO_MORE
					store .t. to SCH_SEL
					store SCHD_SNAME to SCH_SNAME
					store SCHD_SDESC to SCH_SDESC
					store SCH_SNAME + "SCH" to SCH_FNAME
					store SCH_SNAME + "SCH" to SCH_FNDX
					store SCH_SNAME + "LST" to SCH_LTTR
					
				endif
				
			endcase
			
			if (SCHD_PLACE - 2) > 0
				goto (SCHD_PLACE - 2)
				store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_1
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_1
			else
				if SCHD_PLACE - 2 = 0 .and. SCHD_ADD
					store "ADD" + space(62) to NAME_1
					store "Select this choice if you wish to ADD a new schedule" + space(13) to DESC_1
					
				else
					store space(65) to NAME_1
					store space(65) to DESC_1
					
				endif
				
			endif
			
			if SCHD_PLACE - 1 > 0
				goto SCHD_PLACE - 1
				store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_2
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_2
			else
				if SCHD_PLACE - 1 = 0 .and. SCHD_ADD
					store "ADD" + space(62) to NAME_2
					store "Select this choice if you wish to ADD a new schedule" + space(13) to DESC_2
					
				else
					store space(65) to NAME_2
					store space(65) to DESC_2
					
				endif
				
			endif
			
			if SCHD_PLACE > 0
				goto SCHD_PLACE
				store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_3
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_3
				
			else
				store "ADD" + space(62) to NAME_3
				store "Select this choice if you wish to ADD a new schedule" + space(13) to DESC_3
				
			endif
			
			if SCHD_PLACE + 1 <= SCHD_COUNT
				goto SCHD_PLACE + 1
				store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_4
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_4
			else
				store space(65) to NAME_4
				store space(65) to DESC_4
			endif
			
			if SCHD_PLACE + 2 <= SCHD_COUNT
				goto SCHD_PLACE + 2
				store SCHD_SNAME + SCHD_PMT + space(65 - len(SCHD_SNAME + SCHD_PMT)) to NAME_5
				store SCHD_SDESC + space(65 - len(SCHD_SDESC)) to DESC_5
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
			
			if SCHD_PLACE <> 0
				goto SCHD_PLACE
				
			endif
			
		endif
		
	enddo
	
else
	store 22 to STAT_LINE
	store  "The schedule directory is empty" to STAT_MSG
	do status
	
	store .f. to SCH_SEL
	store space(5) to SCH_SNAME
	store SCH_SNAME + "SCH" to SCH_FNAME
	store SCH_SNAME + "SCH" to SCH_FNDX
	store SCH_SNAME + "LST" to SCH_LTTR
	
endif

return


*: EOF: GSNAME.PRG
