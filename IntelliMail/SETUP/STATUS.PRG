* Last revised : Mon 30-May-88 at 6:26 pm
*************************************************************************
*                                              							*
* STATUS >>> Displays a status message at the specified line and       	*
*	       prompts the user to hit any key to continue                 	*
*	       entry : STAT_LINE STAT_MSG			                       	*
*	       exit : None					                               	*
*                                                                       *
* (C)opyright 1988, Personal Touch Software Inc.,  All Rights Reserved. *
*									                                    *
*************************************************************************

save screen to STATUS_SCR
	
if COLOR_SCRN
    set color to GR+/R,W+/N,N,N
else
	set color to N/W,W+/N,N,N
endif

@ STAT_LINE-1,0 say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
@ STAT_LINE,0   say "บ                                                                              บ"
@ STAT_LINE+1,0 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
                                  
store STAT_MSG + ", ฤู to continue." to STAT_MSG

if COLOR_SCRN
    set color to GR+/R,W+/R,N,N
else
	set color to N/W,W+/N,N,N
endif

@ STAT_LINE,((80-len(STAT_MSG))/2) say STAT_MSG

store 1 to THE_KEY

do while THE_KEY <> 13
	store inkey() to THE_KEY
		
enddo

release STAT_LINE,STAT_MSG,THE_KEY

if COLOR_SCRN
    set color to G/N,W+/N,N,N
else
	set color to W/N,W+/N,N,N
endif

restore screen from STATUS_SCR

return

