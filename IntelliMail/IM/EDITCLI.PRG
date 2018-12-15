*:*********************************************************************
*:
*:        Program: EDITCLI.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 7:35 pm
*:
*:      Called by: CLIEDIT.PRG    
*:
*:          Calls: GETCLI           (procedure in UTILITY.PRG)
*:               : PICK             (procedure in UTILITY.PRG)
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : WRITECLI         (procedure in UTILITY.PRG)
*:               : CLRSCRN          (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* EDITCLI >>> Edit client in data base 							      *
*	       entry : FST_NAME, LST_NAME								  *
*	       exit : CLI_SEL = T										  *
*		      CLI_SNAME = C_LST_N + C_FST_N							  *
*			  CLI_SNBR = C_CLI_NBR									  *
*             SEL_NAME = CLI_SNAME                                    *
*		      CLI_SEL = F											  *
*			  CLI_SNAME = "No client selected"						  *
*			  CLI_SNBR = "?????"								      *
*																	  *
***********************************************************************

do GETCLI

store .t. to sCROLL

do while sCROLL
	store 1 to CHOICE
	store 3 to PICK_CNT
	store 20 to PICK_LINE
	store "Save changes" to PICK_1
	store "Make changes" to PICK_2
	store "Throw away changes" to PICK_3
	do PICK
	
	do case
	case CHOICE = 1
		
		do case
		case substr(LST_N,1,1) = " "
			store 22 to STAT_LINE
			store "Please enter the clients name" to STAT_MSG
			do status
			
			do GETCLI
			
		case substr(dtoc(BIRTH),1,2) < "01" .or. substr(dtoc(BIRTH),1,2) > "12"
			store 22 to STAT_LINE
			store "Invalid MONTH for birth date" to STAT_MSG
			do status
			
			do GETCLI
			
		case substr(dtoc(BIRTH),4,2) < "01" .or. substr(dtoc(BIRTH),4,2) > "31"
			store 22 to STAT_LINE
			store "Invalid DAY for birth date" to STAT_MSG
			do status
			
			do GETCLI
			
		otherwise
			do WRITECLI
			
			store .f. to sCROLL
			
		endcase
		
	case CHOICE = 2
		do GETCLI
		
	case CHOICE = 3
		store .f. to sCROLL
		
	endcase
	
enddo

do CLRSCRN

return
*: EOF: EDITCLI.PRG
