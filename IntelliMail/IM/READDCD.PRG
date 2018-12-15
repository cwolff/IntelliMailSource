*:*********************************************************************
*:
*:        Program: READDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:21
*:
*:      Called by: DCDPRINT.PRG   
*:               : SELDCD.PRG     
*:               : EDITDCD.PRG    
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* READDCD >>> Get the current record from the file					  *
*	       entry : the current record and variables in schedule       *
*	       exit : Current record variables and place    			  *
*                   DCD_NBR                                           *
*                   DPROMPT                                           *
*                   NXT_SCHD                                          *
*                   NXT_STEP                                          *
*																	  *
***********************************************************************

store ltrim(str(D_DCHOICE,3)) + space(3 - len((ltrim(str(D_DCHOICE,3))))) to DCHOICE
store D_DPROMPT to DPROMPT
store D_NXT_SCHD to NXT_SCHD
store D_NXT_STEP to NXT_STEP

return

*: EOF: READDCD.PRG
