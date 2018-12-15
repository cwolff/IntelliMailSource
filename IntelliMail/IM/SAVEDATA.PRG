*:*********************************************************************
*:
*:        Program: SAVEDATA.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 7:24 pm
*:
*:      Called by: CLIADD.PRG     
*:
*:          Calls: CLRSCRN          (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:           Uses: NEWCLI.DBF     
*:               : &PFILENAME.DBF 
*:               : NEWMRK.DBF     
*:               : &MFILENAME.DBF 
*:
*:        Indexes: NWPNBR.NDX
*:               : CLINBR.NDX
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SAVEDATA >>> Save all new data to the data base					  *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

do CLRSCRN

store "Saving clients and markers" to L_TAIL
store "Do not disturb this process" to R_TAIL
do TAIL

@ 6,7  say "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป "
@ 7,7  say "บ                                                                 บ Û"
@ 8,7  say "บ                                                                 บ Û"
@ 9,7  say "บ                                                                 บ Û"
@ 10,7 say "บ                                                                 บ Û"
@ 11,7 say "บ                                                                 บ Û"
@ 12,7 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
@ 13,7 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

store 20 to PMT_LINE
store "Checking for new clients and markers." to PMT_MSG
do prompt

store substr(dtoc(date()),7,2)+substr(dtoc(date()),1,2)+substr(dtoc(date()),4,2) to DAY_NBR
store substr(DAY_NBR,1,4) + "00" to MTH_NBR
store substr(MTH_NBR,1,2) + "00" + "00" to YR_NBR

store 0 to CLI_TOT
store 0 to MRK_TOT

*
* SAVE CLIENT DATA
*

store 8 to PMT_LINE
store "Checking for new clients." to PMT_MSG
do prompt

store "2" to SELECT_NBR
store "CLIENT" to FILE_NAME
store "CLIENT" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store "3" to SELECT_NBR
	store "NEWCLI" to FILE_NAME
	store "NEWCLI" to ALIAS_NAME
	store "" to INDEX_NAME
	store "" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN
		goto bottom
		store recno() to ADDCOUNT
		
		if .not. eof()
			@ 8,8 say space(65)
			store 8 to PMT_LINE
			store "Number of new clients added .... " + ltrim(str(ADDCOUNT)) to PMT_MSG
			do prompt
			
			select NEWCLI
			use
			
			select CLIENT
			append from NEWCLI for .not. delete()
			
			select CLIENT
			use
			
			store "CLI" + substr(dtoc(date()),1,2)+substr(dtoc(date()),4,2)+substr(dtoc(date()),10,1) to FILENAMEP
			store "DAILY\CLI" + substr(dtoc(date()),1,2)+substr(dtoc(date()),4,2)+substr(dtoc(date()),10,1)+".DBF" to PFILENAME
			
			if file(PFILENAME)
				store "3" to SELECT_NBR
				store FILENAMEP to FILE_NAME
				store "NEWCLI" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					append from NEWCLI for .not. delete()
					
					select NEWCLI
					use
					
				endif
				
			else
				store "3" to SELECT_NBR
				store "NEWCLI" to FILE_NAME
				store "NEWCLI" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					copy structure to &PFILENAME
					
					select NEWCLI
					use
					
				endif
				
				store "3" to SELECT_NBR
				store FILENAMEP to FILE_NAME
				store "NEWCLI" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					append from NEWCLI for .not. delete()
					
					select NEWCLI
					use
					
				endif
				
			endif
			
			store "3" to SELECT_NBR
			store "NEWCLI" to FILE_NAME
			store "NEWCLI" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				delete all
				pack
				
				index on C_CLI_NBR to NWPNBR
				index on C_LST_N + C_FST_N to NWPLNFN
				
				select NEWCLI
				use
				
			endif
			
			store "2" to SELECT_NBR
			store "CLIENT" to FILE_NAME
			store "CLIENT" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				index on C_CLI_NBR to CLINBR
				index on C_LST_N + C_FST_N to CLILNFN
				
				select CLIENT
				use
				
			endif
			
		else
			select CLIENT
			use
			
			select NEWCLI
			use
			
			@ 8,8 say space(65)
			store 8 to PMT_LINE
			store "No new clients were added." to PMT_MSG
			do prompt
			
		endif
		
	else
		@ 8,8 say space(65)
		store 8 to PMT_LINE
		store "No new clients were added." to PMT_MSG
		do prompt
		
		select CLIENT
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
			index on C_LST_N + C_FST_N to NWPLNFN
			index on C_CLI_NBR to NWPNBR
			
		endif
		
	endif
	
else
	store 22 to STAT_LINE
	store "ERROR : could not open CLIENT file" to STAT_MSG
	do status
	
endif

*
* SAVE NEW MARKER ENTRIES
*

store 10 to PMT_LINE
store "Checking for new markers" to PMT_MSG
do prompt

store "4" to SELECT_NBR
store "MARKER" to FILE_NAME
store "MARKER" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store "5" to SELECT_NBR
	store "NEWMRK" to FILE_NAME
	store "NEWMRK" to ALIAS_NAME
	store "" to INDEX_NAME
	store "" to IFLD_NAME
	do OPENFILE
	
	if FILE_OPEN
		goto bottom
		store recno() to ADDCOUNT
		
		if .not. eof()
			@ 10,8 say space(15)
			store 10 to PMT_LINE
			store "Number of new markers added ... " + ltrim(str(ADDCOUNT)) to PMT_MSG
			do prompt
			
			select NEWMRK
			use
			
			select MARKER
			
			append from NEWMRK for .not. delete()
			
			select MARKER
			use
			
			store "MRK" + substr(dtoc(date()),1,2)+substr(dtoc(date()),4,2)+substr(dtoc(date()),10,1) to FILENAMEM
			store "DAILY\MRK" + substr(dtoc(date()),1,2)+substr(dtoc(date()),4,2)+substr(dtoc(date()),10,1)+".DBF" to MFILENAME
			
			if file(MFILENAME)
				store "4" to SELECT_NBR
				store FILENAMEM to FILE_NAME
				store "NEWMRK" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					append from NEWMRK for .not. delete()
					
					select NEWMRK
					use
					
				endif
				
			else
				store "5" to SELECT_NBR
				store "NEWMRK" to FILE_NAME
				store "NEWMRK" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					copy structure to &MFILENAME
					
					select NEWMRK
					use
					
				endif
				
				store "5" to SELECT_NBR
				store FILENAMEM to FILE_NAME
				store "NEWMRK" to ALIAS_NAME
				store "" to INDEX_NAME
				store "" to IFLD_NAME
				do OPENFILE
				
				if FILE_OPEN
					append from NEWMRK for .not. delete()
					
					select NEWMRK
					use
					
				endif
				
			endif
			
			store "5" to SELECT_NBR
			store "NEWMRK" to FILE_NAME
			store "NEWMRK" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				delete all
				pack
				
				index on M_MRK_NBR + M_SCHD_PTR to NEWMRK
				
				select NEWMRK
				use
				
			endif
			
			store "4" to SELECT_NBR
			store "MARKER" to FILE_NAME
			store "MARKER" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				index on M_MRK_NBR + M_SCHD_PTR to MARKER
				
				select MARKER
				use
				
			endif
			
		else
			
			select MARKER
			use
			
			select NEWMRK
			use
			
			@ 10,8 say space(65)
			store 10 to PMT_LINE
			store "No new markers were added." to PMT_MSG
			do prompt
			
		endif
		
	else
		@ 10,8 say space(65)
		store 10 to PMT_LINE
		store "No new markers were added." to PMT_MSG
		do prompt
		
		select MARKER
		copy structure to NEWMRK
		
		select CLIENT
		use
		
		store "5" to SELECT_NBR
		store "NEWMRK" to FILE_NAME
		store "NEWMRK" to ALIAS_NAME
		store "" to INDEX_NAME
		store "" to IFLD_NAME
		do OPENFILE
		
		if FILE_OPEN
			index on M_MRK_NBR + M_SCHD_PTR to NEWMRK
			
		endif
		
	endif
	
else
	store 22 to STAT_LINE
	store "ERROR : could not open MARKER file" to STAT_MSG
	do status
	
endif

*
* CLEAN UP AND RETURN
*

set exact off

@ 20,0

store 22 to STAT_LINE
store "Finished adding new clients and markers" to STAT_MSG
do status

return

*: EOF: SAVEDATA.PRG
