*:*********************************************************************
*:
*:        Program: WRITEDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:37
*:
*:      Called by: DCDADD.PRG     
*:               : GDNAME.PRG     
*:               : GDCHOICE.PRG   
*:               : EDITDCD.PRG    
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* WRITEDCD >>> Put the current record to the file					  *
*	       entry : the current record and variables in schedule       *
*                   DCD_NBR                                           *
*                   DPROMPT                                           *
*                   NXT_SCHD                                          *
*                   NXT_STEP                                          *
*	       exit : Current record variables and place    			  *
*																	  *
***********************************************************************

replace D_DCHOICE with val(DCHOICE)
replace D_DPROMPT with DPROMPT
replace D_NXT_SCHD with NXT_SCHD
replace D_NXT_STEP with NXT_STEP

return

*: EOF: WRITEDCD.PRG
