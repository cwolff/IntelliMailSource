*:*********************************************************************
*:
*:        Program: FLOPPYBU.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:07
*:
*:      Called by: BACKDBF.PRG    
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:
*:           Uses: &COPY_FILE.DBF 
*:
*:     Documented: 09/04/88 at 16:57               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* FLOPPYBU >>> Permits the backing up of the child data base		  *
*		   entry : SRC_FILE - name of file to backup				  *
*			   SRC_DRIVE - drive of file to backup					  *
*			   DEST_ROOT - 3 letter root name						  *
*			   ROW_NBR - row to display messages					  *
*			   NBR_PD - number of record per disk					  *
*		   exit : None												  *
*																	  *
***********************************************************************

store SRC_DRIVE + SRC_FILE to SRC_NAME

store "1" to SELECT_NBR
store SRC_NAME to FILE_NAME
store "WORK" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	goto bottom
	
	*
	* If the file is empty the following condition is true
	* (necessary because an empty file will set recno() to 1)
	*
	
	if bof() .and. eof()
		store 0 to NBR_REC
	else
		store recno() to NBR_REC
	endif
	
	if NBR_REC < NBR_PD
		if NBR_REC = 0
			store 0 to NBR_DISK
			store 0 to LOW_END
			store 0 to HIGH_END
			
		else
			store 1 to NBR_DISK
			store 1 to LOW_END
			store NBR_REC to HIGH_END
			
		endif
		
	else
		store (NBR_REC / NBR_PD) to NBR_DISK
		store (NBR_PD * int(NBR_DISK)) to NBR_MOD
		
		if NBR_DISK <> NBR_MOD
			store NBR_DISK + 1 to NBR_DISK
		endif
		
		store str(NBR_DISK,2) to TOTAL_DISK
		store 1 to LOW_END
		store LOW_END + NBR_PD -1 to HIGH_END
		
	endif
	
	store "A:BU" + DEST_ROOT + "01" to FLOPPY
	
	goto top
	
	store .t. to sCROLL
	
	do while sCROLL
		store 22 to STAT_LINE
		store "Please insert disk labeled " + FLOPPY to STAT_MSG
		do status
		
		store FLOPPY to DEL_FILE
		
		save screen to SCREEN_1
		clear
		@ 1,0 say "Using DOS format command to format &FLOPPY disk."
		@ 3,0
		run format a:/4
		restore screen from SCREEN_1
		
		store FLOPPY to COPY_FILE
		
		store ROW_NBR to PMT_LINE
		store SRC_NAME + " -> " + COPY_FILE + ", saving records " to PMT_MSG
		store PMT_MSG + str(LOW_END,5)+" - "+str(HIGH_END,5) to PMT_MSG
		do prompt
		
		if NBR_DISK = 0
			copy structure to &COPY_FILE
			
		else
			goto LOW_END
			copy to &COPY_FILE while recno() >= LOW_END .and. recno() <= HIGH_END
			
		endif
		
		if HIGH_END >= NBR_REC
			store .f. to sCROLL
			
		else
			store HIGH_END + 1 to LOW_END
			store LOW_END + (NBR_PD-1) to HIGH_END
			
			if HIGH_END > NBR_REC
				store NBR_REC to HIGH_END
			endif
			
			store val(substr(FLOPPY,8,2)) to NEXTFILE
			store NEXTFILE + 1 to NEXTFILE
			store substr(FLOPPY,1,7) to PART1
			
			if NEXTFILE < 10
				store str(NEXTFILE,1) to TEMP_PART
				store "0"+TEMP_PART to PART2
				
			else
				store str(NEXTFILE,2) to PART2
				
			endif
			
			store PART1 + PART2 to FLOPPY
			
		endif
		
	enddo
	
	select WORK
	use
	
else
	store 22 to STAT_LINE
	store "ERROR : could not open &SRC_NAME file" to STAT_MSG
	do status
	
endif

return

*: EOF: FLOPPYBU.PRG
