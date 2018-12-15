*:*********************************************************************
*:
*:        Program: GETDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:09
*:
*:      Called by: DCDADD.PRG     
*:               : EDITDCD.PRG    
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:               : PUTDCD.PRG
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GSSTEP.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : GSNAME.PRG
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* GETDCD >>> Put the current record to the screen					  *
*	       entry : the current record and variables in schedule       *
*					DCD_NAME										  *
*                   DCD_FNAME                                         *
*                   DCD_FNDX                                          *
*	       exit : Current record variables and place    			  *
*                   DCD_FNAME                                         *
*                   DCD_FNDX                                          *
*                   DCD_NAME                                          *
*																	  *
***********************************************************************

store recno() to TDCD_PLACE
store D_DCHOICE to TDCHOICE
store DCD_FNAME to TDCD_FNAME
store DCD_FNDX to TDCD_FNDX

store SEL_NAME to L_TAIL
store "Press   " + chr(27) + " " + chr(26) + " Del to Select ды when Done" to R_TAIL
do TAIL

*
* Make sure the values coming in are valid
*

store DCHOICE to T_DCHOICE
store DPROMPT to T_DPROMPT


if len(trim(NXT_SCHD)) <> 5
	store "TRMNT" to NXT_SCHD
	store "   " to NXT_STEP
	
else
	if trim(NXT_SCHD) = "TRMNT"
		store "   " to NXT_STEP
		
	else
		if val(NXT_STEP) < 1 
			store "1  " to NXT_STEP
			
		endif
		
	endif
	
endif

store NXT_SCHD to T_NXT_SCHD
store NXT_STEP to T_NXT_STEP

store LOGON to T_LOGON

*
* Redisplay the screen to show adjustments
*

do PUTDCD

*
* Position cursor to the first field
*

@ 10,56 say ""

store 1 to select
store .t. to MORE

do while MORE
	store inkey() to key
	
	if key <> 0
		do case
			
			*
			* Up Arrow () for UP (Select previous field)
			*
			
		case key = 5 .or. key = 56
			if select > 1
				store select - 1 to select
				
			else
				store 2 to select
				
			endif
			
			*
			* Down Arrow () for DOWN (Select next field)
			*
			
		case key = 24 .or. key = 50
			if select < 2
				store select + 1 to select
				
			else
				store 1 to select
				
			endif
			
			*
			* Left Arrow (<-) to (Select previous value)
			*
			
		case key = 19 .or. key = 52
			do case
			case select = 1
				store "TRMNT" to T_NXT_SCHD
				store "   " to T_NXT_STEP
				
			case select = 2
				if T_NXT_SCHD <> "TRMNT"
					store "7" to SELECT_NBR
					store T_NXT_SCHD + "SCH" to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store T_NXT_SCHD + "SCH" to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						save screen to GD_SCREEN
						
						store 20 to PMT_LINE
						store "Selecting a step in the &T_NXT_SCHD schedule" to PMT_MSG
						do prompt
						
						store val(T_NXT_STEP) to REC_NBR
						
						store .f. to REC_ADD
						
						do GSSTEP
						
						@ 20,0
						
						if STEP_SEL
							store SCH_STEP to T_NXT_STEP
							
							select SCHD
							use
							
						endif
						
						restore screen from GD_SCREEN
						
					else
						store 20 to PMT_LINE
						store T_T1_DCDD  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek T_NXT_SCHD
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The step is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			endcase
			
			*
			* Right Arrow (->) to (Select next value)
			*
			
		case key = 4 .or. key = 54
			
			do case
			case select = 1
				if T_NXT_SCHD = "TRMNT"
					store "   " to T_NXT_STEP
					
				endif
				
				store "6" to SELECT_NBR
				store "SCHDDIR" to FILE_NAME
				store "SCHDDIR" to ALIAS_NAME
				store "SCHDDIR" to INDEX_NAME
				store "SCHD_SNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GD_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a schedule" to PMT_MSG
					do prompt
					
					seek T_NXT_SCHD
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 1 to REC_NBR
						
					endif
					
					store .f. to REC_ADD
					
					do GSNAME
					
					@ 20,0
					
					if DCD_SEL
						store SCH_SNAME to T_NXT_SCHD
						
						select SCHDDIR
						use
						
					endif
					
					restore screen from GD_SCREEN
					
				endif
				
			case select = 2
				if T_NXT_SCHD <> "TRMNT"
					store "7" to SELECT_NBR
					store T_NXT_SCHD + "SCH" to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store T_NXT_SCHD + "SCH" to INDEX_NAME
					store "S_STEP" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						save screen to GD_SCREEN
						
						store 20 to PMT_LINE
						store "Selecting a step in the &T_NXT_SCHD schedule" to PMT_MSG
						do prompt
						
						store T_NXT_SCHD to SCH_SNAME
						store val(T_NXT_STEP) to REC_NBR
						
						store .f. to REC_ADD
						
						do GSSTEP
						
						@ 20,0
						
						if STEP_SEL
							store SCH_STEP to T_NXT_STEP
							
							select SCHD
							use
							
						endif
						
						restore screen from GD_SCREEN
						
					else
						store 20 to PMT_LINE
						store T_T1_DCDD  + " schedule not found, adjusting schedule directory" to PMT_MSG
						do prompt
						
						store "6" to SELECT_NBR
						store "SCHDDIR" to FILE_NAME
						store "SCHDDIR" to ALIAS_NAME
						store "SCHDDIR" to INDEX_NAME
						store "SCHD_SNAME" to IFLD_NAME
						do OPENFILE
						
						if FILE_OPEN
							seek T_NXT_SCHD
							if .not. (eof() .or. bof())
								delete
								pack
								
							endif
							
							select SCHDDIR
							use
							
						endif
						
						@ 20,0
						
					endif
					
				else
					store 22 to STAT_LINE
					store "The step is marked for deletion" to STAT_MSG
					do status
					
				endif
				
			endcase
			
			*
			* RET KEY (дды) when DONE
			*
			
		case key = 13
			
			*
			* Check to see if the schedules and step needed have values
			* along with letter and menu if needed
			*
			
			store .t. to valid
			
			if valid
				
				store .f. to MORE
				
				*
				* Restore current schedule variables that may
				* have been changed during this editing session
				*
				
				store T_NXT_SCHD to NXT_SCHD
				store T_NXT_STEP to NXT_STEP
				
				store SEL_NAME to L_TAIL
				store "Press ды to Enter" to R_TAIL
				do TAIL
				
				store 20 to PMT_LINE
				store "Edit the prompt for this choice" to PMT_MSG
				do prompt
				
				@ 8,5 get T_DPROMPT picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
				
				set confirm on
				
				read
				
				set confirm off
				
				clear gets
				
				@ 20,0
				
				*
				* Reopen the schedule
				*
				
				store "9" to SELECT_NBR
				store TDCD_FNAME to FILE_NAME
				store "DCD" to ALIAS_NAME
				store TDCD_FNDX to INDEX_NAME
				store "D_DCHOICE" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					goto TDCD_PLACE
					
					if .not. (bof() .or. eof())
						store .t. to DCD_SEL
						
						store T_DCHOICE to DCHOICE
						store T_DPROMPT to DPROMPT
						store T_NXT_SCHD to NXT_SCHD
						store T_NXT_STEP to NXT_STEP
						
					else
						store .f. to DCD_SEL
						
					endif
					
				else
					store 20 to PMT_LINE
					store DCD_SNAME +  " schedule not found, adjusting schedule directory" to PMT_MSG
					do prompt
					
					store "6" to SELECT_NBR
					store "SCHDDIR" to FILE_NAME
					store "SCHDDIR" to ALIAS_NAME
					store "SCHDDIR" to INDEX_NAME
					store "SCHD_SNAME" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						find SCH_SNAME
						if .not. (eof() .or. bof())
							delete
							pack
							
						endif
						
						select SCHDDIR
						use
						
						store .f. to DCD_SEL
						
						@ 20,0
						
					endif
					
				endif
				
				
			endif
			
			*
			* Del Key to CANCEL
			*
			
		case key = 7
			
			*
			* Restore current schedule variables that may
			* have been changed during this editing session
			*
			
			store TDCD_NAME to DCD_NAME
			store TDCD_FNAME to DCD_FNAME
			store TDCD_FNDX to DCD_FNDX
			
			store .f. to DCD_SEL
			store .f. to MORE
			store .f. to continue
			
		endcase
		
		*
		* Display the appropriate data and point to the correct
		* field when done according to the field the cursor is in
		*
		
		set color to w+/n,w+/n,n,n
		
		if select = 1
			@ 10,64 say T_NXT_STEP
			@ 10,51 say T_NXT_SCHD
			
		else
			@ 10,51 say T_NXT_SCHD
			@ 10,64 say T_NXT_STEP
			
		endif
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	endif
	
enddo

return

*: EOF: GETDCD.PRG
