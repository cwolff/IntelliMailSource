*:*********************************************************************
*:
*:        Program: EDITDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:05
*:
*:      Called by: DCDEDIT.PRG    
*:
*:          Calls: READDCD.PRG
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PUTDCD.PRG
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : GETDCD.PRG
*:               : WRITEDCD.PRG
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* EDITDCD >>> Edit choice for a particular schedule				      *
*	       entry : current database 								  *
*	       exit : MRK_SEL = T if found F otherwise					  *
*																	  *
***********************************************************************

if .not. (eof() .or. bof())
	do READDCD
	
	do CLRSCRN
	
	@ 5,1  say "ษอ[       choice     ]อออออออออออออออออออออออออออออออออออออออออออออ[       ]อป"
	@ 6,1  say "บ                                                                            บ"
	@ 7,1  say "บ                                                                            บ"
	@ 8,1  say "บ                                                                            บ"
	@ 9,1  say "บ                                                                            บ"
	@ 10,1 say "บ                                                                            บ"
	@ 11,1 say "บ                                                                            บ"
	@ 12,1 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
	
	do PUTDCD
	
	store 2 to CHOICE
	store .t. to sCROLL
	do while sCROLL
		
		*
		* CHOICE is initialized outside the loop
		* to make scrolling easier (PICK will point to the last seletion)
		*
		
		store 4 to PICK_CNT
		store 20 to PICK_LINE
		store "Previous choice" to PICK_1
		store "Change this choice" to PICK_2
		store "Next choice" to PICK_3
		store "Stop scrolling" to PICK_4
		do PICK
		
		do case
		case CHOICE = 1
			store recno() to RECOVER
			
			skip -1
			
			if bof()
				store 22 to STAT_LINE
				store "This is the first choice" to STAT_MSG
				do status
				
				goto RECOVER
				
				store 3 to CHOICE
				
			else
				do READDCD
				
				do PUTDCD
				
			endif
			
		case CHOICE = 2
			do GETDCD
			
			*
			* Was the edit successful
			*
			
			if DCD_SEL
				
				store .t. to EDITSCROLL
				
				do while EDITSCROLL
					store 2 to CHOICE
					
					store 1 to CHOICE
					store 3 to PICK_CNT
					store 20 to PICK_LINE
					store "Save changes" to PICK_1
					store "Changes this choice" to PICK_2
					store "Throw away changes" to PICK_3
					do PICK
					
					do case
					case CHOICE = 1
						do WRITEDCD
						
						store 3 to CHOICE
						store .f. to EDITSCROLL
						
					case CHOICE = 2
						do GETDCD
						
						store 1 to CHOICE
						
						if .not. DCD_SEL
							store .f. to EDITSCROLL
							
							do PUTDCD
							
						endif
						
					case CHOICE = 3
						do READDCD
						do PUTDCD
						
						store 3 to CHOICE
						store .f. to EDITSCROLL
						
					endcase
					
				enddo
				
			else
				do PUTDCD
				
			endif
			
		case CHOICE = 3
			store recno() to RECOVER
			
			skip
			
			if eof()
				goto RECOVER
				
				store 22 to STAT_LINE
				store "This is the last choice" to STAT_MSG
				do status
				
				store 1 to CHOICE
				
			else
				do READDCD
				
				do PUTDCD
				
			endif
			
		case CHOICE = 4
			store .f. to sCROLL
			do CLRSCRN
			
		endcase
		
	enddo
	
endif

return
*: EOF: EDITDCD.PRG
