*:*********************************************************************
*:
*:        Program: SELCLI.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 7:25 pm
*:
*:      Called by: ADVMENU.PRG    
*:               : LTRMENU.PRG    
*:               : CLIVIEW.PRG    
*:               : CLIADD.PRG     
*:               : CLIEDIT.PRG    
*:               : CLIPRINT.PRG   
*:
*:          Calls: READCLI          (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:               : PUTCLI           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* SELCLI >>> Allow the user to scroll through the database to select  *
*	       entry : current data base (CLIENT.DBF or NEWCLI.DBF)	      *
*		       with the proper index set							  *
*               SRCH_CLI = LST_N + FST_N							  *
*	       exit : CLI_SEL = T if client selected					  *
*			  CLI_SNAME = trim(C_FST_N) + " " + trim(C_LST_N) 		  *
*             CLI_SNBR = CLI_NBR                                      *
*                                                                     *
*		      CLI_SEL = F if client not selected					  *
*																	  *
***********************************************************************

do READCLI

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
@ 16,3 say "บ                                                                         บ Û"
@ 17,3 say "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ Û"
@ 18,3 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

do PUTCLI

store .t. to sCROLL
store 2 to CHOICE

do while sCROLL
	store 4 to PICK_CNT
	store 20 to PICK_LINE
	store "Previous client" to PICK_1
	store "This client" to PICK_2
	store "Next client" to PICK_3
	store "Stop scrolling" to PICK_4
	do PICK
	
	do case
	case CHOICE = 1
		store recno() to RECOVER
		
		skip -1
		
		if bof()	
			store 22 to STAT_LINE
			store "This is the first client" to STAT_MSG
			do status
			
			goto RECOVER
			
			store 3 to CHOICE
			
		else
			do READCLI
			do PUTCLI
			
		endif
		
	case CHOICE = 2
		store .f. to sCROLL
		store .t. to CLI_SEL
		store trim(FST_N) + " " + trim(LST_N) to CLI_SNAME
		store CLI_NBR to CLI_SNBR
		
	case CHOICE = 3
		store recno() to RECOVER
		
		skip
		
		if eof()
			store 22 to STAT_LINE
			store "This is the last client" to STAT_MSG
			do status
			
			goto RECOVER
			
			store 1 to CHOICE
			
		else
			do READCLI
			do PUTCLI
			
		endif
		
	case CHOICE = 4
		store .f. to sCROLL
		store .f. to CLI_SEL
		
	endcase
	
enddo

return
*: EOF: SELCLI.PRG
