*:*********************************************************************
*:
*:        Program: SELSCHD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:26
*:
*:      Called by: SCHDVIEW.PRG   
*:
*:          Calls: READSCH          (procedure in UTILITY.PRG)
*:               : PUTSCH.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:59               FoxDoc version 1.0
*:*********************************************************************
*																		*
* SELSCHD >>> View step for a particular schedule				        *
*	       entry : current data base 									*
*	       exit : MRK_SEL = T if found F otherwise						*
*																		*
*************************************************************************

goto val(SCH_STEP)

if .not. (eof() .or. bof())
	
	do READSCH
	
	@ 5,1  say "ษอ[       step     ]อออออออออออออออออออออออออออออออออออออออออออออออ[       ]อป"
	@ 6,1  say "บ                                                                            บ"
	@ 7,1  say "บ                                                                            บ"
	@ 8,1  say "บ                                                                            บ"
	@ 9,1  say "บ                                                                            บ"
	@ 10,1 say "บ                                                                            บ"
	@ 11,1 say "บ                                                                            บ"
	@ 12,1 say "บ                                                                            บ"
	@ 13,1 say "บ                                                                            บ"
	@ 14,1 say "บ                                                                            บ"
	@ 15,1 say "บ                                                                            บ"
	@ 16,1 say "บ                                                                            บ"
	@ 17,1 say "บ                                                                            บ"
	@ 18,1 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
	
	do PUTSCH
	
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
				do READSCH
				
				do PUTSCH
				
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
				do READSCH
				
				do PUTSCH
				
			endif
			
		case CHOICE = 3
			store .f. to sCROLL
			
		endcase
		
	enddo
	
endif

return
*: EOF: SELSCHD.PRG
