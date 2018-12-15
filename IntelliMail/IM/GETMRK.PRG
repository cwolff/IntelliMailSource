*:*********************************************************************
*:
*:        Program: GETMRK.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 24-Mar-89 at 10:28 am
*:
*:      Called by: EDITMRK.PRG    
*:               : ADDMRK.PRG     
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : GLNAME.PRG
*:
*:     Documented: 09/04/88 at 16:59               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* GETMRK >>> Get a blank record from the screen which the user added  *
*	       entry : Schedule variables read and pointing at Marker rec *
*				   LOGON											  *
*				   MRK_NBR											  *
*                  SCHD_PTR                                           *
*                  STP_PTR     	                                      *
*                  DINT                                               *
*				   MDESC											  *
*	       exit :  current record variables                           *
*																	  *
***********************************************************************

* procedure GETMRK
store LTR_TOS to T_LTR_TOS
store DATE_TOS to T_DATE_TOS

store SEL_NAME to L_TAIL
store "Press   " + chr(27) + " " + chr(26) + " Del to Select ฤู when Done" to R_TAIL
do TAIL

if SEND_FLG = "T"
	store SEND_FLG to T_SEND_FLG
	
	if dtoc(DATE_SNT) = "  /  /    "
		store ctod("  /  /    ") to DATE_SNT
		store DATE_SNT to T_DATE_SNT
	
	else
		store DATE_SNT to T_DATE_SNT
	
	endif

else
	store "F" to SEND_FLG
	store SEND_FLG to T_SEND_FLG

	store ctod("  /  /    ") to DATE_SNT
	store DATE_SNT to T_DATE_SNT
	
endif


@ 5,3  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
@ 6,3  say "บ                                                                         บ Û"
@ 7,3  say "บ                                                                         บ Û"
@ 8,3  say "บ                                                                         บ Û"
@ 9,3  say "บ                                                                         บ Û"
@ 10,3 say "บ                                                                         บ Û"
@ 11,3 say "บ                                                                         บ Û"
@ 12,3 say "บ                                                                         บ Û"
@ 13,3 say "บ                                                                         บ Û"
@ 14,3 say "บ                                                                         บ Û"
@ 15,3 say "บ                                                                         บ Û"
@ 16,3 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
@ 17,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

@ 5,5 get MRK_NBR picture "99999"

@ 5,69 get LOGON picture "!!!!!"

@ 7,5 say "schedule name, step and date initilized ....";
	get SCHD_PTR picture "!!!!!"

store ltrim(trim(STP_PTR)) to STP_PTR

if val(STP_PTR) = 0
	store "1  " to STP_PTR
	
else
	store ltrim(str(val(STP_PTR),3)) + space(3 - len(ltrim(str(val(STP_PTR),3)))) to STP_PTR
	
endif

@ 7,58 get STP_PTR picture "999"

@ 7,64 get DINT picture "99/99/9999"
@ 8,5 get MDESC picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 9,5 say "last schedule name, step and date initilized";
	get LST_SCHD picture "!!!!!"

@ 9,58 get LST_STP picture "999"

@ 9,64 get LST_DINT picture "99/99/9999"

@ 10,5 get LST_DESC picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 11,5 get ERR_DESC picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

@ 13,5 say "letter to send";
	get LTR_TOS picture "!!!!!!!!"

@ 13,31 say "date to send";
	get DATE_TOS picture "99/99/9999"

@ 14,5 say "letter has been sent";
	get SEND_FLG picture "9"

@ 14,31 say "letter was sent on";
	get DATE_SNT picture "99/99/9999"

clear gets

*
* Position cursor to the first field
*

@ 13,30 say ""

store 1 to SELECT_IT
store .t. to MORE

do while MORE
	store inkey() to key
	
	if key <> 0
		do case
			
			*
			* Up Arrow () for UP (Select previous field)
			*
			
		case key = 5 .or. key = 56
			if SELECT_IT > 1
				store SELECT_IT - 1 to SELECT_IT
				
			else
				store 3 to SELECT_IT
				
			endif
			
			*
			* Down Arrow () for DOWN (Select next field)
			*
			
		case key = 24 .or. key = 50
			if SELECT_IT < 3
				store SELECT_IT + 1 to SELECT_IT
				
			else
				store 1 to SELECT_IT
				
			endif
			
			*
			* Left Arrow (<-) to (Select previous value)
			*
			
		case key = 19 .or. key = 52
			do case
			case SELECT_IT = 1
				store "NOLETTER" to T_LTR_TOS
				
			case SELECT_IT = 2
				if T_DATE_TOS > ctod("01/01/1900")
					store T_DATE_TOS - 1 to T_DATE_TOS
				else
					store ctod("12/31/2099") to T_DATE_TOS
				endif
				
			case SELECT_IT = 3
				if T_SEND_FLG = "T"
					store "F" to T_SEND_FLG
					store ctod("  /  /    ") to T_DATE_SNT
					
				else
					store "T" to T_SEND_FLG
					if dtoc(DATE_SNT) = "  /  /    "
						store date() to T_DATE_SNT
					else
						store DATE_SNT to T_DATE_SNT
					endif
					
				endif
				
			endcase
			
			*
			* Right Arrow (->) to (Select next value)
			*
			
		case key = 4 .or. key = 54
			
			do case
			case SELECT_IT = 1
				store "10" to SELECT_NBR
				store "LTRDIR" to FILE_NAME
				store "LTRDIR" to ALIAS_NAME
				store "LTRDIR" to INDEX_NAME
				store "LTR_LNAME" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					save screen to GM_SCREEN
					
					store 20 to PMT_LINE
					store "Selecting a letter" to PMT_MSG
					do prompt
					
					seek T_LTR_TOS
					if .not. (bof() .or. eof())
						store recno() to REC_NBR
						
					else
						store 0 to REC_NBR
						
					endif
					
					store .f. to REC_ADD
					
					do GLNAME
					
					@ 20,0
					
					if LTR_SEL
						store LTR_NAME to T_LTR_TOS
						
						select LTRDIR
						use
						
					endif
					
					restore screen from GM_SCREEN
					
				endif
				
			case SELECT_IT = 2
				if T_DATE_TOS < ctod("01/01/2100")
					store T_DATE_TOS + 1 to T_DATE_TOS
				else
					store ctod("01/01/1900") to T_DATE_TOS
				endif
				
			case SELECT_IT = 3
				if T_SEND_FLG = "T"
					store "F" to T_SEND_FLG
					store ctod("  /  /    ") to T_DATE_SNT
					
				else
					store "T" to T_SEND_FLG
					if dtoc(DATE_SNT) = "  /  /    "
						store date() to T_DATE_SNT
					else
						store DATE_SNT to T_DATE_SNT
					endif
					
				endif
				
			endcase
			
			*
			* RET KEY (ฤฤู) when DONE
			*
			
		case key = 13
			
			*
			* Check to see if the schedules and step needed have values
			* along with letter and menu if needed
			*
			
			store .f. to MORE
			
			store T_LTR_TOS to LTR_TOS
			store T_DATE_TOS to DATE_TOS
			store T_SEND_FLG to SEND_FLG
			store T_DATE_SNT to DATE_SNT
			
			*
			* Del Key to CANCEL
			*
			
		case key = 7
			
			*
			* Restore current schedule variables that may
			* have been changed during this editing session
			*
			
			store .f. to MORE
			
		endcase
		
		*
		* Display the appropriate data and point to the correct
		* field when done according to the field the cursor is in
		*
		
		do case
		case SELECT_IT = 1
			@ 13,5 say "letter to send";
				get T_LTR_TOS picture "!!!!!!!!"
			
		case SELECT_IT = 2
			@ 13,31 say "date to send";
				get T_DATE_TOS picture "99/99/9999"
			
		case SELECT_IT = 3
			@ 14,31 say "letter was sent on";
				get T_DATE_SNT picture "99/99/9999"
			@ 14,5 say "letter has been sent";
				get T_SEND_FLG picture "9"
			
		endcase
		
		clear gets
		
	endif
	
enddo

return


*: EOF: GETMRK.PRG
