*:*********************************************************************
*:
*:        Program: PRINTDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:20
*:
*:      Called by: DCDPRINT.PRG   
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* PRINTDCD >>> Put the current record to the printer				  *
*	       entry : #												  *
*	       exit : Current record variables							  *
*                                                                     *
***********************************************************************

@ 3,5 say "<<< Decider Menu Information  for " + DCD_NAME +" <<<"

@ 5,5 say "[" + DCD_NAME + " choice " + DCHOICE + "]"
@ 5,68 say "[" + LOGON + "]"
@ 7,5 say "The description used to describe this choice"
@ 8,5 say "[" + DPROMPT + "]"
@ 10,5 say "This choice will move the marker to schedule [" + NXT_SCHD + "] step [" + NXT_STEP + "]"

return



*: EOF: PRINTDCD.PRG
