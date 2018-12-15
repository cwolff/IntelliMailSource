*:*********************************************************************
*:
*:        Program: ADDCLI.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 6:34 pm
*:
*:      Called by: CLIADD.PRG     
*:
*:          Calls: GETNCLI          (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : GETCLI           (procedure in UTILITY.PRG)
*:               : OPENFILE         (procedure in UTILITY.PRG)
*:               : WRITECLI         (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* ADDCLI >>> Check to see if client is in data base or is to be added *
*	       entry : FST_NAME, LST_NAME								  *
*	       exit : CLI_SEL = T										  *
*			   CLI_SNBR = C_CLI_NBR									  *
*			   CLI_SNAME = C_LST_N + C_FST_N 						  *
*                                                                     *
*		       CLI_SEL = F											  *
*			   CLI_SNAME = "No client selected"					      *
*			   CLI_SNBR = "??????????" 								  *
*																	  *
***********************************************************************

do GETNCLI

store .t. to sCROLL

do while sCROLL
	store 1 to CHOICE
	store 3 to PICK_CNT
	store 20 to PICK_LINE
	store "Save client" to PICK_1
	store "Edit client" to PICK_2
	store "Throw away client" to PICK_3
	do PICK
	
	do case
	case CHOICE = 1
		
		do case
			
		case substr(LST_N,1,1) = " "
			store 20 to STAT_LINE
			store "Please enter the clients name" to STAT_MSG
			do status
			
			do GETCLI
			
		case substr(dtoc(BIRTH),1,2) < "01" .or. substr(dtoc(BIRTH),1,2) > "12"
			store 20 to STAT_LINE
			store "Invalid MONTH for birth date" to STAT_MSG
			do status
			
			do GETCLI
			
		case substr(dtoc(BIRTH),4,2) < "01" .or. substr(dtoc(BIRTH),4,2) > "31"
			store 20 to STAT_LINE
			store "Invalid DAY for birth date" to STAT_MSG
			do status
			
			do GETCLI
			
		otherwise
			store "1" to SELECT_NBR
			store "GLOBAL" to FILE_NAME
			store "WORK" to ALIAS_NAME
			store "" to INDEX_NAME
			store "" to IFLD_NAME
			do OPENFILE
			
			if FILE_OPEN
				store G_NBR to NBRIDX
				replace G_NBR with str(val(NBRIDX) + 1,5)
				
				select WORK
				use
				
				select NEWCLI
				
				store 1 to loop
				
				store "" to CLI_NBR
				
				do while loop < 6
					if substr(NBRIDX,loop,1) = " "
						store CLI_NBR + "0" to CLI_NBR
					else
						store CLI_NBR + substr(NBRIDX,loop,1) to CLI_NBR
					endif
					store loop + 1 to loop
				enddo
				
				store CLI_NBR to CLI_SNBR
				store .t. to CLI_SEL
				
				append blank
				do WRITECLI
				
			else
				store 22 to STAT_LINE
				store "FATAL ERROR : could not open GLOBAL file" to STAT_MSG
				do status
				
			endif
			
			store .f. to sCROLL
			
		endcase
		
	case CHOICE = 2
		do GETCLI
		
	case CHOICE = 3
		store .f. to CLI_SEL
		store "No client selected" to CLI_SNAME
		store "?????" to CLI_SNBR
		store .f. to sCROLL
		
	endcase
	
enddo

do CLRSCRN

return
*: EOF: ADDCLI.PRG
