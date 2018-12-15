*:*********************************************************************
*:
*:        Program: DELDATA.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 6:38 pm
*:
*:      Called by: ADVMENU.PRG    
*:               : SENDMENU.PRG   
*:               : CLIEDIT.PRG    
*:               : MRKMOVE.PRG    
*:
*:          Calls: CLRSCRN          (procedure in UTILITY.PRG)
*:               : TAIL             (procedure in UTILITY.PRG)
*:               : PROMPT           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:        Indexes: CLINBR.NDX
*:               : CLILNFN.NDX
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* DELDATA >>> Deletes pack and reindex marker records files           *
*	       entry : None												  *
*	       exit : None												  *
*																	  *
***********************************************************************

do CLRSCRN

store "Checking for deleted data" to L_TAIL
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
store "Checking for deleted clients and deleted markers" to PMT_MSG
do prompt

store 8 to PMT_LINE
store "Checking for deleted clients" to PMT_MSG
do prompt

store "2" to SELECT_NBR
store "CLIENT" to FILE_NAME
store "CLIENT" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	locate for delete()
	
	if delete()
		
		@ 8,8 say space(65)
		store 8 to PMT_LINE
		store "Packing CLIENT file." to PMT_MSG
		do prompt
		
		pack
		
		@ 8,8 say space(65)
		store 8 to PMT_LINE
		store "Reindexing CLIENT file." to PMT_MSG
		do prompt
		
		index on C_CLI_NBR to CLINBR
		index on C_LST_N+C_FST_N to CLILNFN
		
		@ 8,8 say space(65)
		store 8 to PMT_LINE
		store "Deleted clients have been removed." to PMT_MSG
		do prompt
		
	else
		@ 8,8 say space(65)
		store 8 to PMT_LINE
		store "No clients were deleted." to PMT_MSG
		do prompt
		
	endif
	
	select CLIENT
	use
	
endif

*
* Check for deleted MARKER data
*

store 10 to PMT_LINE
store "Checking for deleted markers." to PMT_MSG
do prompt

store "4" to SELECT_NBR
store "MARKER" to FILE_NAME
store "MARKER" to ALIAS_NAME
store "" to INDEX_NAME
store "" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	locate for delete()
	
	if delete()
		
		@ 10,8 say space(65)
		store 10 to PMT_LINE
		store "Packing MARKER file." to PMT_MSG
		do prompt
		
		pack
		
		@ 10,8 say space(65)
		store 10 to PMT_LINE
		store "Reindexing MARKER file." to PMT_MSG
		do prompt
		
		index on M_MRK_NBR + M_SCHD_PTR to MARKER
		
		@ 10,8 say space(65)
		store 10 to PMT_LINE
		store "Deleted markers have been removed." to PMT_MSG
		do prompt
		
	else
		@ 10,8 say space(65)
		store 10 to PMT_LINE
		store "No markers were deleted." to PMT_MSG
		do prompt
		
	endif
	
	select MARKER
	use
	
endif

@ 20,0

store 22 to STAT_LINE
store "Finished looking for deleted clients and markers" to STAT_MSG
do status

return
*: EOF: DELDATA.PRG
