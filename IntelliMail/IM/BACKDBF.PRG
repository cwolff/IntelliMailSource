*:*********************************************************************
*:
*:        Program: BACKDBF.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 19-Mar-89 at 0:35 am
*:
*:      Called by: SYSADMIN.PRG   
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : FLOPPYBU.PRG
*:
*:     Documented: 09/04/88 at 16:54               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* BACKREST >>> Permits the backing up of the child data base		  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************		

store "Backing Up IntelliMail" to hEAD
do DATETAIL
store "Select Return to STOP" to R_TAIL
do FRAME

store .t. to continue
store 1 to CHOICE_BD

do while continue
	store CHOICE_BD to CHOICE
	store 2 to MENU_CNT
	store "Backup" to MENU_1
	store "Begin Backup of all files in the IntelliMail System" to DESC_1
	store "Return" to MENU_2
	store "Return to the System Administration Main Menu" to DESC_2
	do menu
	
	store CHOICE to CHOICE_BD
	
	do case
		
	case CHOICE = 1
		do CLRSCRN
		
		store "Backup in progress" to L_TAIL
		store "Do not disturb this process" to R_TAIL
		do TAIL
		
		@ 5,3  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
		@ 6,3  say "º                                                                         º Û"
		@ 7,3  say "º                                                                         º Û"
		@ 8,3  say "º                                                                         º Û"
		@ 9,3  say "º                                                                         º Û"
		@ 10,3 say "º                                                                         º Û"
		@ 11,3 say "º                                                                         º Û"
		@ 12,3 say "º                                                                         º Û"
		@ 13,3 say "º                                                                         º Û"
		@ 14,3 say "º                                                                         º Û"
		@ 15,3 say "º                                                                         º Û"
		@ 16,3 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
		@ 17,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
		
		store 7 to PMT_LINE
		store "Backing up the IntelliMail Database System to Floppy Disks" to PMT_MSG
		do prompt
		
		store 22 to STAT_LINE
		store "Please Insert disk labeled UTILITY" to STAT_MSG
		do status
		
		save screen to SCREEN_1
		
		clear
		@ 1,0 say "Using DOS format command to format UTILITY disk."
		@ 3,0
		run format a:/4
		restore screen from SCREEN_1
		
		store 9 to PMT_LINE
		store "Saving IntelliMail WORK files" to PMT_MSG
		do prompt
		
		run copy GLOBAL.DBF a:GLOBAL.DBF > NUL
		run copy SYSTEM.DBF a:SYSTEM.DBF > NUL
		
		store "1" to SELECT_NBR
		store "IMSIZE" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			goto top
			
			store "2" to SELECT_NBR
			store "CLIENT" to FILE_NAME
			store "CLIENT" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				goto bottom
				
				if bof() .and. eof()
					store 0 to CLI_SIZE
					
				else
					store recno() to CLI_SIZE
					
				endif
				
				select CLIENT
				use
				
			else
				store 0 to CLI_SIZE
				
			endif
			
			store "4" to SELECT_NBR
			store "MARKER" to FILE_NAME
			store "MARKER" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				goto bottom
				
				if bof() .and. eof()
					store 0 to MRK_SIZE
					
				else
					store recno() to MRK_SIZE
					
				endif
				
				select MARKER
				use
				
			else
				store 0 to MRK_SIZE
				
			endif
			
			select WORK
			
			replace I_CLI_SIZE with CLI_SIZE
			replace I_MRK_SIZE with MRK_SIZE
			
			select WORK
			use
			
			run copy IMSIZE.DBF a: > NUL
			run copy BUSINESS.DBF a: > NUL
			run copy LETTER.DBF a: > NUL
			run copy DOSTXT.DBF a: > NUL
			run copy LABELFMT.DBF a: > NUL
			run copy LTTRFMT.DBF a: > NUL
			run copy VARIABLE.DBF a: > NUL
			
			store "" to SRC_DRIVE
			store "CLIENT" to SRC_FILE
			store "CLI" to DEST_ROOT
			store 10 to ROW_NBR
			store 1000 to NBR_PD
			do FLOPPYBU
			
			store "" to SRC_DRIVE
			store "MARKER" to SRC_FILE
			store "MRK" to DEST_ROOT
			store 11 to ROW_NBR
			store 1000 to NBR_PD
			do FLOPPYBU
			
			store 22 to STAT_LINE
			store "Please Insert disk labeled SCHEDULES" to STAT_MSG
			do status
			
			save screen to SCREEN_1
			clear
			@ 1,0 say "Using DOS format command to format SCHEDULES disk."
			@ 3,0
			run format a:/4
			restore screen from SCREEN_1
			
			store 12 to PMT_LINE
			store "Saving schedule directory and schedule files" to PMT_MSG
			do prompt
			
			run copy SCHDDIR.DBF a: > NUL
			run copy ?????SCH.DBF a: > NUL
			run copy SCHDTMP.DBF a: > NUL
			
			store 13 to PMT_LINE
			store "Saving decider directory and decider files" to PMT_MSG
			do prompt
			
			run copy DCDDIR.DBF a: > NUL
			run copy ?????DCD.DBF a: > NUL
			run copy DCDTMP.DBF a: > NUL
			
			store 14 to PMT_LINE
			store "Saving letter directory and letter files" to PMT_MSG
			do prompt
			
			run copy LTRDIR.DBF a: > NUL
			run copy LETTER.DBF a: > NUL
			run copy LTTRTMP.DBF a: > NUL
			run copy LETTER\*.LTR a: > NUL
			
			store 22 to STAT_LINE
			store "Saving of IntelliMail data files is complete" to STAT_MSG
			do status
			
		else
			store 22 to STAT_LINE
			store "IMSIZE file is needed to perform a backup" to STAT_LINE
			do status
			
		endif
		
		do CLRSCRN
		
	case CHOICE = 2
		store .f. to continue
		
	endcase
	
enddo

return


*: EOF: BACKDBF.PRG
