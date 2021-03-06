*:*********************************************************************
*:
*:        Program: GCNAME.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 7:32 pm
*:
*:      Called by: ADVMENU.PRG    
*:               : LTRMENU.PRG    
*:               : CLIVIEW.PRG    
*:               : CLIADD.PRG     
*:               : CLIEDIT.PRG    
*:               : CLIPRINT.PRG   
*:
*:          Calls: TAIL             (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:55               FoxDoc version 1.0
*:*********************************************************************
*                                      								  *
* GCNAME >>> Prompts the user to type in the clients name	          *
*	       entry : None						                          *
*	       exit : LST_NAME, FST_NAME, SRCH_CLI, CLI_SNAME             *
*									                                  *
***********************************************************************

@ 6,7  say "浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様� "
@ 7,7  say "�                                                                 � �"
@ 8,7  say "�                       Selecting a Client                        � �"
@ 9,7  say "�                                                                 � �"
@ 10,7 say "�                                                                 � �"
@ 11,7 say "�                                                                 � �"
@ 12,7 say "�                                                                 � �"
@ 13,7 say "�                                                                 � �"
@ 14,7 say "藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様� �"
@ 15,7 say " 栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩栩"

set confirm on

store space(20) to LST_NAME
store space(15) to FST_NAME
@ 10,15 say "Enter the clients last name and first name."
@ 12,15 get LST_NAME picture "!!!!!!!!!!!!!!!!!!!!"
@ 12,37 say ", " get FST_NAME picture "!!!!!!!!!!!!!!!"

store SEL_NAME to L_TAIL
store "Press 潰 to Enter" to R_TAIL
do TAIL

read

clear gets

set confirm off

store trim(upper(FST_NAME)) + " " + trim(upper(LST_NAME)) to CLI_SNAME
store trim(upper(LST_NAME) + upper(FST_NAME)) to SRCH_CLI

return


*: EOF: GCNAME.PRG
