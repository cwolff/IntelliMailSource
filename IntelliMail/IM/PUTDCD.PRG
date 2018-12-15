*:*********************************************************************
*:
*:        Program: PUTDCD.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:20
*:
*:      Called by: DCDADD.PRG     
*:               : SELDCD.PRG     
*:               : GETDCD.PRG     
*:               : EDITDCD.PRG    
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*							                                       	  *
* PUTDCD >>> Put the decider menu to the screen                       *
*	       entry : # to write, current record variables		          *
*	       exit : None						                          *
*									                                  *
***********************************************************************

@ 7,5 say "The description used to describe this choice"
@ 10,5 say "This choice will move the marker to schedule [     ] step [   ]"
@ 8,5 say "[                                                                 ]"

set color to w+/n,w+/n,n,n
@ 5,5 say DCD_NAME
@ 5,18 say DCHOICE
@ 5,70 say LOGON
@ 8,6 say DPROMPT
@ 10,51 say NXT_SCHD
@ 10,64 say NXT_STEP
if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

return

*: EOF: PUTDCD.PRG
