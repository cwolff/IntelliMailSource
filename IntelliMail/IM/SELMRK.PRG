*:*********************************************************************
*:
*:        Program: SELMRK.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 7:25 pm
*:
*:      Called by: ADVMENU.PRG    
*:               : CLIVIEW.PRG    
*:               : CLIADD.PRG     
*:               : CLIEDIT.PRG    
*:               : CLIPRINT.PRG   
*:
*:          Calls: READMRK          (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PUTMRK           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SELMRK >>> Select one of the clients markers                   	  *
*	       entry : current data base (CLIENT.DBF or NEWCLI.DBF)	  *
*                   SRCH_MRK = MRK_NBR + STP_PTR                      *
*	       exit : MRK_SEL = T if selected F otherwise				  *
*																	  *
***********************************************************************

do READMRK

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

do PUTMRK

store .t. to sCROLL
store 2 to CHOICE

do while sCROLL
	store 4 to PICK_CNT
	store 20 to PICK_LINE
	store "Previous marker" to PICK_1
	store "This marker" to PICK_2
	store "Next marker" to PICK_3
	store "Stop scrolling" to PICK_4
	do PICK
	
	do case
	case CHOICE = 1
		store recno() to RECOVER
		
		skip -1
		
		if bof()
			store 22 to STAT_LINE
			store "The first marker for &CLI_SNAME" to STAT_MSG
			do status
			
			goto RECOVER
			
			store 3 to CHOICE
			
		else
			do READMRK
			
			if (MRK_NBR <> substr(SRCH_MRK,1,5))
				goto RECOVER
				
				do READMRK
				
				store 22 to STAT_LINE
				store "The first marker for &CLI_SNAME" to STAT_MSG
				do status
				
			else
				do PUTMRK
				
			endif
			
		endif
		
	case CHOICE = 2
		store .f. to sCROLL
		store .t. to MRK_SEL
		
	case CHOICE = 3
		store recno() to RECOVER
		
		skip
		
		if eof()
			store 22 to STAT_LINE
			store "The last marker for &CLI_SNAME" to STAT_MSG
			do status
			
			goto RECOVER
			
			store 1 to CHOICE
			
		else
			do READMRK
			
			if (MRK_NBR <> substr(SRCH_MRK,1,5))
				goto RECOVER
				
				do READMRK
				
				store 22 to STAT_LINE
				store "The last marker for &CLI_SNAME" to STAT_MSG
				do status
				
			else
				do PUTMRK
				
			endif
			
		endif
		
	case CHOICE = 4
		store .f. to MRK_SEL
		store .f. to sCROLL
		
	endcase
	
enddo

return
*: EOF: SELMRK.PRG
