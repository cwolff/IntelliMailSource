*:*********************************************************************
*:
*:        Program: USERMAIN.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Mon 5-Sep-88 at 4:04 pm
*:
*:      Called by: SYSADMIN.PRG   
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : YESNO            (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:54               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* USERMAIN >>> Maintains the SYSTEM.DBF add kill users, kill passwords*
*	       entry : None	                                              *
*	       exit : None	                                              *
*									                                  *
***********************************************************************

set exact on

store "1" to SELECT_NBR
store "GLOBAL" to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store trim(G_LOGON) to ACT_LOGON
	
	select WORK
	use
	
else
	store 22 to STAT_LINE
	store "FATAL ERROR : could not open GLOBAL file" to STAT_MSG
	do status
	
	quit
	
endif

store "1" to SELECT_NBR
store "SYSTEM" to FILE_NAME
store "WORK" to ALIAS_NAME
store "SYSTEM" to INDEX_NAME
store "S_LOGON" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store "User Administration" to hEAD
	do DATETAIL
	store "Select Return to STOP" to R_TAIL
	do FRAME
	
else
	store 22 to STAT_LINE
	store "FATAL ERROR : could not open SYSTEM file" to STAT_MSG
	do status
	
	quit
	
endif

store .t. to continue
store 1 to CHOICE_UM

do while continue
	
	do CLRSCRN
	
	store CHOICE_UM to CHOICE
	store 6 to MENU_CNT
	store "Add" to MENU_1
	store "Add a new IntelliMail user" to DESC_1
	store "Delete" to MENU_2
	store "Delete an existing IntelliMail user" to DESC_2
	store "Clear" to MENU_3
	store "Clear an IntelliMail user's password" to DESC_3
	store "Edit" to MENU_4
	store "Edit an IntelliMail user's permissions" to DESC_4
	store "List" to MENU_5
	store "List IntelliMail users" to DESC_5
	store "Return" to MENU_6
	store "Return to System Administration Menu" to DESC_6
	do menu
	
	store CHOICE to CHOICE_UM
	
	do case
		
	case CHOICE = 1
		
		@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
		@ 6,7  say "บ                                                                 บ Û"
		@ 7,7  say "บ                                                                 บ Û"
		@ 8,7  say "บ                                                                 บ Û"
		@ 9,7  say "บ                                                                 บ Û"
		@ 10,7 say "บ                                                                 บ Û"
		@ 11,7 say "บ                                                                 บ Û"
		@ 12,7 say "บ                                                                 บ Û"
		@ 13,7 say "บ                                                                 บ Û"
		@ 14,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 15,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		do DATETAIL
		store "Press RETURN to ENTER" to R_TAIL
		do TAIL
		
		store 7 to PMT_LINE
		store "Adding a new user to IntelliMail" to PMT_MSG
		do prompt
		
		store "" to LOGON
		do while len(LOGON) = 0
			set confirm on
			store "     " to LOGON
			@ 10,10 say "Enters users identification to add. "
			@ 12,10 say "Identification ... " get LOGON picture "AAAAA"
			read
			@ 10,8 say space(65)
			@ 12,8 say space(65)
			clear gets
			store trim(upper(LOGON)) to LOGON
			set confirm off
		enddo
		
		goto top
		seek LOGON
		
		if (eof() .or. bof())
			set confirm on
			store 10 to YN_LINE
			store "Does the user have SYSTEM ADMINISTRATION permission ?" to YN_MSG
			store "N" to YN
			do YESNO
			store YN to P_SYS
			
			store 10 to YN_LINE
			store "Does the user have CLIENT and MARKER EDITOR permission ?" to YN_MSG
			store "Y" to YN
			do YESNO
			store YN to P_CLI
			
			store 10 to YN_LINE
			store "Does the user have MANUAL advance client's marker permission ?" to YN_MSG
			store "Y" to YN
			do YESNO
			store YN to P_ADV
			
			store 10 to YN_LINE
			store "Does the user have SCHEDULE EDITOR permission ?" to YN_MSG
			store "N" to YN
			do YESNO
			store YN to P_SCH
			
			store 10 to YN_LINE
			store "Does the user have DECIDER MENU EDITOR permission ?" to YN_MSG
			store "N" to YN
			do YESNO
			store YN to P_MNU
			
			store 10 to YN_LINE
			store "Does the user have LETTER EDITOR permission ?" to YN_MSG
			store "N" to YN
			do YESNO
			store YN to P_LTR
			
			store 10 to YN_LINE
			store "Does the user have SEND LETTER permission ?" to YN_MSG
			store "Y" to YN
			do YESNO
			store YN to P_SND
			
			store "B"+P_SYS+P_CLI+P_ADV+P_SCH+P_MNU+P_LTR+P_SND to PERMISSION
			store "BSPASMLA" to CODE
			store "B" to PRMSSN
			store 2 to count
			do while count < 9
				if substr(PERMISSION,count,1) = "Y"
					store PRMSSN + substr(CODE,count,1) to PRMSSN
				else
					store PRMSSN + "N" to PRMSSN
				endif
				store count + 1 to count
			enddo
			
			append blank
			replace S_LOGON with LOGON
			replace S_PRMSSN with PRMSSN
			
			set confirm off
			
		else
			store 22 to STAT_LINE
			store LOGON + " is already a user" to STAT_MSG
			do status
			
		endif
		
	case CHOICE = 2
		
		@  5,7 say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
		@  6,7 say "บ                                                                 บ Û"
		@  7,7 say "บ                                                                 บ Û"
		@  8,7 say "บ                                                                 บ Û"
		@ 9,7  say "บ                                                                 บ Û"
		@ 10,7 say "บ                                                                 บ Û"
		@ 11,7 say "บ                                                                 บ Û"
		@ 12,7 say "บ                                                                 บ Û"
		@ 13,7 say "บ                                                                 บ Û"
		@ 14,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 15,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		do DATETAIL
		store "Press RETURN to ENTER" to R_TAIL
		do TAIL
		
		store 7 to PMT_LINE
		store "Deleting an existing user from IntelliMail" to PMT_MSG
		do prompt
		
		store "" to LOGON
		do while len(LOGON) = 0
			set confirm on
			store "     " to LOGON
			@ 10,10 say "Enters users identification to delete."
			@ 12,10 say "Identification ... " get LOGON picture "AAAAA"
			read
			clear gets
			store trim(upper(LOGON)) to LOGON
			set confirm off
		enddo
		
		if LOGON <> ACT_LOGON
			goto top
			seek LOGON
			
			if (eof() .or. bof())
				store 22 to STAT_LINE
				store LOGON + " is not a user" to STAT_MSG
				do status
				
			else
				if LOGON = "ADMIN"
					store 22 to STAT_LINE
					store "ADMIN can not be deleted" to STAT_MSG
					do status
					
				else
					delete for S_LOGON = LOGON
					pack
					store 22 to STAT_LINE
					store LOGON + " is now deleted" to STAT_MSG
					do status
					
				endif
				
			endif
			
		else
			store 22 to STAT_LINE
			store "Can not delete an active LOGON" to STAT_MSG
			do status
			
		endif
		
	case CHOICE = 3
		
		@  5,7 say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
		@  6,7 say "บ                                                                 บ Û"
		@  7,7 say "บ                                                                 บ Û"
		@  8,7 say "บ                                                                 บ Û"
		@  9,7 say "บ                                                                 บ Û"
		@ 10,7 say "บ                                                                 บ Û"
		@ 11,7 say "บ                                                                 บ Û"
		@ 12,7 say "บ                                                                 บ Û"
		@ 13,7 say "บ                                                                 บ Û"
		@ 14,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 15,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		do DATETAIL
		store "Press RETURN to ENTER" to R_TAIL
		do TAIL
		
		store 7 to PMT_LINE
		store "Clearing an existing user's password from IntelliMail" to PMT_MSG
		do prompt
		
		store "" to LOGON
		do while len(LOGON) = 0
			set confirm on
			store "     " to LOGON
			@ 10,10 say "Enters users identification to clear password."
			@ 12,10 say "Identification ... " get LOGON picture "AAAAA"
			read
			clear gets
			store trim(upper(LOGON)) to LOGON
			set confirm off
		enddo
		
		if LOGON <> ACT_LOGON
			goto top
			
			seek LOGON
			
			if (eof() .or. bof())
				
				store 22 to STAT_LINE
				store LOGON + " is not a user" to STAT_MSG
				do status
				
			else
				replace S_PSSWRD with "              "
				store S_PRMSSN to PRMSSN
				replace S_PRMSSN with "B" + substr(PRMSSN,2,8)
				
				store 22 to STAT_LINE
				store LOGON + "'s password is now cleared." to STAT_MSG
				do status
				
			endif
			
		else
			store 22 to STAT_LINE
			store "Can not clear an active LOGON's password" to STAT_MSG
			do status
		endif
		
	case CHOICE = 4
		
		@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
		@ 6,7  say "บ                                                                 บ Û"
		@ 7,7  say "บ                                                                 บ Û"
		@ 8,7  say "บ                                                                 บ Û"
		@ 9,7  say "บ                                                                 บ Û"
		@ 10,7 say "บ                                                                 บ Û"
		@ 11,7 say "บ                                                                 บ Û"
		@ 12,7 say "บ                                                                 บ Û"
		@ 13,7 say "บ                                                                 บ Û"
		@ 14,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 15,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		do DATETAIL
		store "Press RETURN to ENTER" to R_TAIL
		do TAIL
		
		store 7 to PMT_LINE
		store "Editing an existing user's permissions to use IntelliMail" to PMT_MSG
		do prompt
		
		store "" to LOGON
		do while len(LOGON) = 0
			set confirm on
			store "     " to LOGON
			@ 10,10 say "Enters users identification to edit. "
			@ 12,10 say "Identification ... " get LOGON picture "AAAAA"
			read
			@ 10,8 say space(65)
			@ 12,8 say space(65)
			clear gets
			store trim(upper(LOGON)) to LOGON
			set confirm off
		enddo
		
		if LOGON <> ACT_LOGON
			
			goto top
			
			seek LOGON
			
			if .not. (eof() .or. bof())
				if LOGON = "ADMIN"
					store 22 to STAT_LINE
					store "ADMIN's permissions can not be edited" to STAT_MSG
					do status
				else
					set confirm on
					store S_PRMSSN to PRMSSN
					store 10 to YN_LINE
					store "Does the user have SYSTEM ADMIN permission ?" to YN_MSG
					if substr(PRMSSN,2,1) = "S"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_SYS
					
					store 10 to YN_LINE
					store "Does the user have CLIENT and MARKER EDITOR permission ?" to YN_MSG
					if substr(PRMSSN,3,1) = "P"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_CLI
					
					store 10 to YN_LINE
					store "Does the user have MANUAL advance client's marker permission ?" to YN_MSG
					if substr(PRMSSN,4,1) = "A"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_ADV
					
					store 10 to YN_LINE
					store "Does the user have SCHEDULE EDITOR permission ?" to YN_MSG
					if substr(PRMSSN,5,1) = "S"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_SCH
					
					store 10 to YN_LINE
					store "Does the user have DECIDER MENU EDITOR permission ?" to YN_MSG
					if substr(PRMSSN,6,1) = "M"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_MNU
					
					store 10 to YN_LINE
					store "Does the user have LETTER EDITOR permission ?" to YN_MSG
					if substr(PRMSSN,7,1) = "L"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_LTR
					
					store 10 to YN_LINE
					store "Does the user have SEND LETTER permission ?" to YN_MSG
					if substr(PRMSSN,8,1) = "A"
						store "Y" to YN
					else
						store "N" to YN
					endif
					do YESNO
					store YN to P_SND
					
					store substr(PRMSSN,1,1)+P_SYS+P_CLI+P_ADV+P_SCH+P_MNU+P_LTR+P_SND to PERMISSION
					store "BSPASMLA" to CODE
					store "B" to PRMSSN
					store 2 to count
					do while count < 9
						if substr(PERMISSION,count,1) = "Y"
							store PRMSSN + substr(CODE,count,1) to PRMSSN
						else
							store PRMSSN + "N" to PRMSSN
						endif
						store count + 1 to count
					enddo
					
					replace S_PRMSSN with PRMSSN
					
					set confirm off
					
				endif
				
			else
				store 22 to STAT_LINE
				store LOGON + " is not a user" to STAT_MSG
				do status
				
			endif
			
		else
			store 22 to STAT_LINE
			store "Can not edit an active LOGON's permissions" to STAT_MSG
			do status
			
		endif
		
	case CHOICE = 5
		do DATETAIL
		store "Press Number KEY Next to Your Choice" to R_TAIL
		do TAIL
		
		@ 5,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  "
		@ 6,7  say "บ                                                                 บ Û"
		@ 7,7  say "บ                                                                 บ Û"
		@ 8,7  say "บ                                                                 บ Û"
		@ 9,7  say "บ                                                                 บ Û"
		@ 10,7 say "บ                                                                 บ Û"
		@ 11,7 say "บ                                                                 บ Û"
		@ 12,7 say "บ                                                                 บ Û"
		@ 13,7 say "บ                                                                 บ Û"
		@ 14,7 say "บ                                                                 บ Û"
		@ 15,7 say "บ                                                                 บ Û"
		@ 16,7 say "บ                                                                 บ Û"
		@ 17,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
		@ 18,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		goto top
		
		store .t. to sCROLL
		store 2 to CHOICE
		
		do while sCROLL
			
			store S_LOGON to LOGON
			store S_PRMSSN to PRMSSN
			
			if substr(PRMSSN,2,1) = "S"
				store "allowed" to P_SYS
			else
				store "NOT allowed" to P_SYS
			endif
			
			if substr(PRMSSN,3,1) = "P"
				store "allowed" to P_CLI
			else
				store "NOT allowed" to P_CLI
			endif
			
			if substr(PRMSSN,4,1) = "A"
				store "allowed" to P_ADV
			else
				store "NOT allowed" to P_ADV
			endif
			
			if substr(PRMSSN,5,1) = "S"
				store "allowed" to P_SCH
			else
				store "NOT allowed" to P_SCH
			endif
			
			if substr(PRMSSN,6,1) = "M"
				store "allowed" to P_MNU
			else
				store "NOT allowed" to P_MNU
			endif
			
			if substr(PRMSSN,7,1) = "L"
				store "allowed" to P_LTR
			else
				store "NOT allowed" to P_LTR
			endif
			
			if substr(PRMSSN,8,1) = "A"
				store "allowed" to P_SND
			else
				store "NOT allowed" to P_SND
			endif
			
			@ 7,8 say space(65)
			@ 7,9  say "IntelliMail user's identification is .............. " + LOGON
			@ 9,8 say space(65)
			@ 9,9  say "SYSTEM ADMINISTRATION permission is ............... " + P_SYS
			@ 10,8 say space(65)
			@ 10,9 say "CLIENT and MARKER EDITOR permission is ............ " + P_CLI
			@ 11,8 say space(65)
			@ 11,9 say "MANUAL advance of client's marker permission is ... " + P_ADV
			@ 12,8 say space(65)
			@ 12,9 say "SCHEDULE EDITOR permission is ..................... " + P_SCH
			@ 13,8 say space(65)
			@ 13,9 say "DECIDER MENU EDITOR permission is ................. " + P_MNU
			@ 14,8 say space(65)
			@ 14,9 say "LETTER EDITOR permission is ....................... " + P_LTR
			@ 15,8 say space(65)
			@ 15,9 say "SEND LETTER permission is ......................... " + P_SND
			
			store 3 to PICK_CNT
			store 20 to PICK_LINE
			store "Previous user" to PICK_1
			store "Next user" to PICK_2
			store "Stop scrolling" to PICK_3
			do PICK
			
			do case
			case CHOICE = 1
				store recno() to RECOVER
				
				skip -1
				
				if bof()
					store 22 to STAT_LINE
					store "This is the first user" to STAT_MSG
					do status
					
					goto RECOVER
					
					store 2 to CHOICE
					
				endif
				
			case CHOICE = 2
				store recno() to RECOVER
				
				skip
				
				if eof()
					store 22 to STAT_LINE
					store "This is the last user" to STAT_MSG
					do status
					
					goto RECOVER
					
					store 1 to CHOICE
					
				endif
				
			case CHOICE = 3
				store .f. to sCROLL
				do CLRSCRN
				
			endcase
			
		enddo
		
	case CHOICE = 6
		store .f. to continue
		
	endcase
	
	do DATETAIL
	store "Select Return to STOP" to R_TAIL
	do TAIL
	
enddo

select WORK
use

set exact off

return

*: EOF: USERMAIN.PRG
