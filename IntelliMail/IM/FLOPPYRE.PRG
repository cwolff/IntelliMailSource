*:*********************************************************************
*:
*:        Program: FLOPPYRE.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:08
*:
*:      Called by: RESTDBF.PRG    
*:
*:          Calls: STATUS           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:
*:           Uses: &DEST_FILE.DBF 
*:               : &FLOPPY        
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* FLOPPYRE >>> Permits the restoring of the child data base			  *
*		   entry : SRC_ROOT - root (3 letter) name of file to restore *
*							  from 									  *
*			   SRC_DRIVE - drive of file(s) to restore from			  *
*			   DEST_FILE - Name of file to restore					  *
*			   ROW_NBR - row to display messages					  *
*			   NBR_PD - number of record per disk					  *
*			   TOTAL_SIZE - total number of records to restore		  *
*		   exit : None												  *
*																	  *
***********************************************************************

if TOTAL_SIZE < NBR_PD
	if TOTAL_SIZE = 0
		store 0 to NBR_DISK
		store 0 to LOW_END
		store 0 to HIGH_END
		
	else
		store 1 to NBR_DISK
		store 1 to LOW_END
		store TOTAL_SIZE to HIGH_END
		
	endif
	
else
	store (TOTAL_SIZE / NBR_PD) to NBR_DISK
	store (NBR_PD * int(NBR_DISK)) to NBR_MOD
	
	if NBR_DISK <> NBR_MOD
		store NBR_DISK + 1 to NBR_DISK
		
	endif
	
	store 1 to LOW_END
	store LOW_END + NBR_PD - 1 to HIGH_END
	
endif

store .t. to sCROLL

do while sCROLL
	if LOW_END = 0 .or. LOW_END = 1
		store DEST_FILE+".DBF" to DEL_FILE
		
		store "A:BU" + SRC_ROOT + "01" to FLOPPY
		
		store 22 to STAT_LINE
		store "Please insert disk labeled " + FLOPPY to STAT_MSG
		do status
		
		if file (DEL_FILE)
			delete file	&DEL_FILE
			
		endif
		
		do while .not. file(FLOPPY+".DBF")
			store 22 to STAT_LINE
			store "Disk not labeled &FLOPPY - please correct" to STAT_MSG
			do status
			
		enddo
		
		store "1" to SELECT_NBR
		store FLOPPY to FILE_NAME
		store "WORK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			copy structure to &DEST_FILE
			
			select WORK
			use
			
			store "1" to SELECT_NBR
			store DEST_FILE to FILE_NAME
			store "WORK" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				goto bottom
				
			else
				store 22 to STAT_LINE
				store "ERROR : unable to open &DEST_FILE file" to STAT_MSG
				do status
				
				store .f. to sCROLL
				
			endif
			
		else
			store 22 to STAT_LINE
			store "ERROR : unable to open &FLOPPY file" to STAT_MSG
			do status
			
			store .f. to sCROLL
			
		endif
		
	else
		store 22 to STAT_LINE
		store "Please insert " + FLOPPY to STAT_MSG
		do status
		
	endif	
	
	if sCROLL
		store ROW_NBR to PMT_LINE
		store DEST_FILE + " <- " + FLOPPY + ", appending records " to PMT_MSG
		store PMT_MSG + str(LOW_END,5)+" - "+str(HIGH_END,5) to PMT_MSG
		do prompt
		
		goto bottom
		append from &FLOPPY
		
		if HIGH_END >= TOTAL_SIZE
			store .f. to sCROLL
			
		else
			store HIGH_END + 1 to LOW_END
			store LOW_END + (NBR_PD-1) to HIGH_END
			
			if HIGH_END > TOTAL_SIZE
				store TOTAL_SIZE to HIGH_END
				
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
		
		
	endif
	
enddo

select 1
use

return
*: EOF: FLOPPYRE.PRG
