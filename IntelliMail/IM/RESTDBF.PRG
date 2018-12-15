*:*********************************************************************
*:
*:        Program: RESTDBF.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Fri 24-Mar-89 at 10:43 am
*:
*:      Called by: SYSADMIN.PRG   
*:
*:          Calls: DATETAIL         (procedure in UTILITY.PRG)
*:               : FRAME            (procedure in UTILITY.PRG)
*:               : MENU             (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : FLOPPYRE.PRG
*:
*:           Uses: NEWCLI.DBF     
*:               : NEWMRK.DBF     
*:               : TMP.DBF        
*:
*:        Indexes: SYSTEM.NDX
*:               : CLINBR.NDX
*:               : NWPNBR.NDX
*:               : SCHDDIR.NDX
*:               : &SCHD_NAME
*:               : DCDDIR.NDX
*:               : &DCD_NAME
*:               : LTRDIR.NDX
*:
*:     Documented: 09/04/88 at 16:54               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* RESTDBF >>> Permits the backing up of the child data base			  *
*		   entry : None												  *
*		   exit : None												  *
*																	  *
***********************************************************************

store "Restoring IntelliMail Database" to hEAD
do DATETAIL
store "Select Return to STOP" to R_TAIL
do FRAME

store .t. to continue
store 1 to CHOICE_RD

do while continue
	store CHOICE_RD to CHOICE
	store 3 to MENU_CNT
	store "Restore" to MENU_1
	store "Begin to restore all files in the IntelliMail System" to DESC_1
	store "Rebuild" to MENU_2
	store "Begin to rebuild all indexes in the IntelliMail System" to DESC_2
	store "Return" to MENU_3
	store "Return to System Administration Main Menu" to DESC_3
	do menu
	
	store CHOICE to CHOICE_RD
	
	do case
	case CHOICE = 1
		do CLRSCRN
		
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
		
		store 7 to PMT_LINE
		store "Restoring the IntelliMail Database System from Floppy Disks" to PMT_MSG
		do prompt
		
		store "Restore in progress" to L_TAIL
		store "Do not disturb this process" to R_TAIL
		do TAIL
		
		store 22 to STAT_LINE
		store "Please insert the disk labeled UTILITY" to STAT_MSG
		do status
		
		run DEL *.DBF > NUL
		run DEL *.NTX > NUL
		run DEL letter\*.LTR > NUL
		
		do while .not. file("A:GLOBAL.DBF")
			store 22 to STAT_LINE
			store "Disk not labeled UTILITY - please correct" to STAT_MSG
			do status
			
		enddo
		
		store 9 to PMT_LINE
		store "Copying IntelliMail WORK files" to PMT_MSG
		do prompt
		
		run copy a:GLOBAL.DBF > NUL
		run copy a:SYSTEM.DBF > NUL
		run copy a:IMSIZE.DBF > NUL
		run copy a:BUSINESS.DBF > NUL
		run copy a:LETTER.DBF > NUL
		run copy a:DOSTXT.DBF > NUL
		run copy a:LABELFMT.DBF > NUL
		run copy a:LTTRFMT.DBF > NUL
		run copy a:VARIABLE.DBF > NUL
		
		store "1" to SELECT_NBR
		store "IMSIZE" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			store I_CLI_SIZE to CLI_SIZE
			store I_MRK_SIZE to MRK_SIZE
			
			select WORK
			use
			
			store "A:" to SRC_DRIVE
			store "CLI" to SRC_ROOT
			store "CLIENT" to DEST_FILE
			store 10 to ROW_NBR
			store 1700 to NBR_PD
			store CLI_SIZE to TOTAL_SIZE
			do FLOPPYRE
			
			store "A:" to SRC_DRIVE
			store "MRK" to SRC_ROOT
			store "MARKER" to DEST_FILE
			store 11 to ROW_NBR
			store 1200 to NBR_PD
			store MRK_SIZE to TOTAL_SIZE
			do FLOPPYRE
			
			store 22 to STAT_LINE
			store "Please insert the disk labeled SCHEDULES" to STAT_MSG
			do status
			
			do while .not. file("A:SCHDDIR.DBF")
				store 22 to STAT_LINE
				store "Disk not labeled SCHEDULES - please correct" to STAT_MSG
				do status
				
			enddo
			
			store 12 to PMT_LINE
			store "Copying schedule directory and schedule files" to PMT_MSG
			do prompt
			
			run copy a:SCHDDIR.DBF > NUL
			run copy a:?????SCH.DBF > NUL
			run copy a:SCHDTMP.DBF > NUL
			
			store 13 to PMT_LINE
			store "Copying decider directory and decider files" to PMT_MSG
			do prompt
			
			run copy a:DCDDIR.DBF > NUL
			run copy a:?????DCD.DBF > NUL
			run copy a:DCDTMP.DBF > NUL
			
			store 14 to PMT_LINE
			store "Copying letter directory and letter files" to PMT_MSG
			do prompt
			
			run copy a:LTRDIR.DBF > NUL
			run copy a:LTTRTMP.DBF > NUL
			run copy a:*.LTR LETTER > NUL
			
			store 22 to STAT_LINE
			store "Restoration of All Data Files is Complete" to STAT_MSG
			do status
			
			do CLRSCRN
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open IMSIZE file" to STAT_MSG
			do status
			
		endif
		
	case CHOICE = 2
		do CLRSCRN
		
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
		
		store 7 to PMT_LINE
		store "Rebuilding the IntelliMail Database System Index Files" to PMT_MSG
		do prompt
		
		store "Rebuilding IntelliMail index files" to L_TAIL
		store "Do not disturb this process" to R_TAIL
		do TAIL
		
		store 9 to PMT_LINE
		store "Rebuilding IntelliMail WORK index files" to PMT_MSG
		do prompt
		
		store "1" to SELECT_NBR
		store "SYSTEM" to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			index on S_LOGON to SYSTEM
			select WORK
			use
			
		else
			store 22 to STAT_LINE
			store "FATAL ERROR : could not open SYSTEM file" to STAT_MSG
			do status
			
			quit
			
		endif
		
		store 10 to PMT_LINE
		store "Rebuilding client index files" to PMT_MSG
		do prompt
		
		store "2" to SELECT_NBR
		store "CLIENT" to FILE_NAME
		store "CLIENT" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			index on C_CLI_NBR to CLINBR
			index on C_LST_N + C_FST_N to CLILNFN
			copy structure to NEWCLI
			
			select CLIENT
			use
			
			store "3" to SELECT_NBR
			store "NEWCLI" to FILE_NAME
			store "NEWCLI" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				index on C_CLI_NBR to NWPNBR
				index on C_LST_N + C_FST_N to NWPLNFN
				
				select NEWCLI
				use
				
			else
				store 22 to STAT_LINE
				store "ERROR : could not open NEWCLI file" to STAT_MSG
				do status
				
			endif
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open CLIENT file" to STAT_MSG
			do status
			
		endif
		
		
		store 11 to PMT_LINE
		store "Rebuilding marker index file" to PMT_MSG
		do prompt
		
		store "4" to SELECT_NBR
		store "MARKER" to FILE_NAME
		store "MARKER" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			index on M_MRK_NBR + M_SCHD_PTR to MARKER
			copy structure to NEWMRK
			
			select MARKER
			use
			
			store "4" to SELECT_NBR
			store "NEWMRK" to FILE_NAME
			store "NEWMRK" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				index on M_MRK_NBR + M_SCHD_PTR to NEWMRK
				
				select NEWMRK
				use
				
			else
				store 22 to STAT_LINE
				store "ERROR : could not open NEWMRK file" to STAT_MSG
				do status
				
			endif
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open MARKER file" to STAT_MSG
			do status
			
		endif
		
		store 12 to PMT_LINE
		store "Rebuilding schedule directory's index file" to PMT_MSG
		do prompt
		
		store "6" to SELECT_NBR
		store "SCHDDIR" to FILE_NAME
		store "SCHDDIR" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			sort to TMP on SCHD_SNAME
			
			select SCHDDIR
			use
			
			copy file TMP.DBF to SCHDDIR.DBF
			
			delete file TMP.DBF
			
			store "6" to SELECT_NBR
			store "SCHDDIR" to FILE_NAME
			store "SCHDDIR" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			index on SCHD_SNAME to SCHDDIR
			
			set index to SCHDDIR
			goto top
			
			do while .not. (eof() .or. bof())
				store trim(SCHD_SNAME) + "SCH" to SCHD_NAME
				store trim(SCHD_SNAME) + "LST" to SCHL_NAME
				store trim(SCHD_SNAME) + "ALP" to SCHDL_ALP
				store trim(SCHD_SNAME) + "ZIP" to SCHDL_ZIP
				
				if file((SCHD_NAME + ".DBF"))
					@ 12,4 say space(73)
					store 12 to PMT_LINE
					store "Rebuilding &SCHD_NAME index file" to PMT_MSG
					do prompt
					
					store "7" to SELECT_NBR
					store SCHD_NAME to FILE_NAME
					store "SCHD" to ALIAS_NAME
					store "" to INDEX_NAME
					store "" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						index on S_STEP to &SCHD_NAME
						
						select SCHD
						use
						
					else
						store 22 to STAT_LINE
						store "ERROR : could not open &SCHD_NAME file" to STAT_MSG
						do status
						
					endif
					
					select SCHDDIR
					
				endif
				
				if file((SCHL_NAME + ".DBF"))
					@ 12,4 say space(73)
					store 12 to PMT_LINE
					store "Rebuilding &SCHL_NAME index file" to PMT_MSG
					do prompt
					
					store "10" to SELECT_NBR
					store SCHL_NAME to FILE_NAME
					store "LTTR" to ALIAS_NAME
					store "" to INDEX_NAME
					store "" to IFLD_NAME
					do OPENFILE
					
					if FILE_OPEN
						index on L_LST_N + L_FST_N to &SCHL_ALP
						index on L_ZIP + L_LST_N + L_FST_N to &SCHL_ZIP
						
						select LTTR
						use
						
					else
						store 22 to STAT_LINE
						store "ERROR : could not open &SCHL_NAME file" to STAT_MSG
						do status
						
					endif
					
					
					select SCHDDIR
					
				endif
				
				skip
				
			enddo
			
			@ 12,4 say space(73)
			store 12 to PMT_LINE
			store "All schedule index files have been rebuilt" to PMT_MSG
			do prompt
			
			select SCHDDIR
			use
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open SCHDDIR file" to STAT_MSG
			do status
			
		endif
		
		store 13 to PMT_LINE
		store "Rebuilding decider directory's index file" to PMT_MSG
		do prompt
		
		store "8" to SELECT_NBR
		store "DCDDIR" to FILE_NAME
		store "DCDDIR" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			sort to TMP on DCD_DNAME
			
			select DCDDIR
			use
			
			copy file TMP.DBF to DCDDIR.DBF
			
			delete file TMP.DBF
			
			store "8" to SELECT_NBR
			store "DCDDIR" to FILE_NAME
			store "DCDDIR" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			index on DCD_DNAME to DCDDIR
			
			set index to DCDDIR
			goto top
			
			do while .not. (eof() .or. bof())
				store DCD_DNAME + "DCD" to DCD_NAME
				
				@ 13,4 say space(73)
				store 13 to PMT_LINE
				store "Rebuilding &DCD_NAME index file" to PMT_MSG
				do prompt
				
				store "7" to SELECT_NBR
				store DCD_NAME to FILE_NAME
				store "DCD" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					index on D_DCHOICE to &DCD_NAME
					
					select DCD
					use
					
				else
					store 22 to STAT_LINE
					store "ERROR : could not open &DCD_NAME file" to STAT_MSG
					do status
					
				endif
				
				select DCDDIR
				
				skip
				
			enddo
			
			@ 13,4 say space(73)
			store 13 to PMT_LINE
			store "All decider index files have been rebuilt" to PMT_MSG
			do prompt
			
			select DCDDIR
			use
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open DCDDIR file" to STAT_MSG
			do status
			
		endif
		
		store 14 to PMT_LINE
		store "Rebuilding letter directory index file" to PMT_MSG
		do prompt
		
		store "10" to SELECT_NBR
		store "LTRDIR" to FILE_NAME
		store "LTRDIR" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			sort to TMP on LTR_LNAME
			
			select LTRDIR
			use
			
			copy file TMP.DBF to LTRDIR.DBF
			
			delete file TMP.DBF
			
			store "10" to SELECT_NBR
			store "LTRDIR" to FILE_NAME
			store "LTRDIR" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			index on LTR_LNAME to LTRDIR
			
			select LTRDIR
			use
			
		else
			store 22 to STAT_LINE
			store "ERROR : could not open LTRDIR file" to STAT_MSG
			do status
			
		endif
		
		store 22 to STAT_LINE
		store "IntelliMail database indexes have been rebuilt" to STAT_MSG
		do status
		
		do CLRSCRN
		
	case CHOICE = 3
		store .f. to continue
		
	endcase
	
enddo

return
*: EOF: RESTDBF.PRG
