*:*********************************************************************
*:
*:        Program: SELDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:25
*:
*:      Called by: DCDVIEW.PRG    
*:
*:          Calls: READDCD.PRG
*:               : PUTDCD.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 17:00               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SELDCD >>> View choices for a particular menu					      *
*	       entry : current data base 								  *
*	       exit : MRK_SEL = T if found F otherwise					  *
*																	  *
***********************************************************************

goto val(DCHOICE)

if .not. (eof() .or. bof())
	
	do READDCD
	
	@ 5,1  say "ษอ[       choice     ]อออออออออออออออออออออออออออออออออออออออออออออ[       ]อป"
	@ 6,1  say "บ                                                                            บ"
	@ 7,1  say "บ                                                                            บ"
	@ 8,1  say "บ                                                                            บ"
	@ 9,1  say "บ                                                                            บ"
	@ 10,1 say "บ                                                                            บ"
	@ 11,1 say "บ                                                                            บ"
	@ 12,1 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
	
	do PUTDCD
	
	store .t. to sCROLL
	store 2 to CHOICE
	
	do while sCROLL
		store 3 to PICK_CNT
		store 20 to PICK_LINE
		store "Previous step" to PICK_1
		store "Next step" to PICK_2
		store "Stop scrolling" to PICK_3
		do PICK
		
		do case
		case CHOICE = 1
			store recno() to RECOVER
			
			skip -1
			
			if bof()
				store 22 to STAT_LINE
				store "This is the first step" to STAT_MSG
				do status
				
				goto RECOVER
				
				store 2 to CHOICE
				
			else
				do READDCD
				
				do PUTDCD
				
			endif
			
		case CHOICE = 2
			store recno() to RECOVER
			
			skip
			
			if eof()
				store 22 to STAT_LINE
				store "This is the last step" to STAT_MSG
				do status
				
				goto RECOVER
				
				store 1 to CHOICE
				
			else
				do READDCD
				
				do PUTDCD
				
			endif
			
		case CHOICE = 3
			store .f. to sCROLL
			
		endcase
		
	enddo
	
endif

return
*: EOF: SELDCD.PRG
