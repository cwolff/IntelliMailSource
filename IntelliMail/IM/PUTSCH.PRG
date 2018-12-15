*:*********************************************************************
*:
*:        Program: PUTSCH.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 1:22 pm
*:
*:      Called by: SCHDADD.PRG    
*:               : SELSCHD.PRG    
*:               : GETSCH.PRG     
*:               : EDITSCHD.PRG   
*:
*:     Documented: 09/04/88 at 16:59               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* PUTSCH >>> Put the current record to the screen					  *
*	       entry : #												  *
*	       exit : Current record variables							  *
*																	  *
***********************************************************************

* procedure PUTSCH

*
* Display schedule name step and logon
*

set color to w+/n,w+/n,n,n
@ 5,5 say SCH_SNAME
@ 5,16 say step
@ 5,70 say LOGON

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

*
* Display schedule description
*

@ 7,3 say "Desc [                                                                 ]"
set color to w+/n,w+/n,n,n
@ 7,9 say SDESC

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 9,3 say "Method used to decide when to move to the next step [                 ]"

do case
case val(SSTP_TYP) = 1
	set color to w+/n,w+/n,n,n
	@ 9,56 say "manual simple    "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	@ 10,3 say "manual simple step : goto next schedule [     ] next step [   ]          "
	set color to w+/n,w+/n,n,n
	@ 10,44 say N_SCHD
	@ 10,62 say N_STEP
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 2
	set color to w+/n,w+/n,n,n
	@ 9,56 say "manual menu   "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	@ 10,3 say "manual menu step : using menu named [     ]                              "
	set color to w+/n,w+/n,n,n
	@ 10,40 say DCD_NAME
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 3
	set color to w+/n,w+/n,n,n
	@ 9,56 say "manual trigger   "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 4
	set color to w+/n,w+/n,n,n
	@ 9,56 say "automatic simple "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	@ 10,3 say "automatic simple step : goto next schedule [     ] step [   ]             "
	set color to w+/n,w+/n,n,n
	@ 10,47 say N_SCHD
	@ 10,60 say N_STEP
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 5
	set color to w+/n,w+/n,n,n
	@ 9,56 say "automatic trigger"
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 6
	set color to w+/n,w+/n,n,n
	@ 9,56 say "chain simple     "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	@ 10,3 say "Chain simple : goto next schedule [     ] next step [   ]                 "
	set color to w+/n,w+/n,n,n
	@ 10,38 say N_SCHD
	@ 10,56 say N_STEP
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 7
	set color to w+/n,w+/n,n,n
	@ 9,56 say "chain menu       "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	@ 10,3 say "Chain menu step : using menu named [     ]                                 "
	set color to w+/n,w+/n,n,n
	@ 10,39 say DCD_NAME
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
case val(SSTP_TYP) = 8
	set color to w+/n,w+/n,n,n
	@ 9,56 say "chain trigger    "
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
otherwise
	@ 9,56 say "invalid step trg "
	
endcase

*
* Calculate trigger type
*

if val(SSTP_TYP) = 3 .or. val(SSTP_TYP) = 5 .or. val(SSTP_TYP) = 8
	
	do case
	case val(STRG_TYP) = 1
		@ 10,3 say "Method used to decide step trigger [           ] "
		set color to w+/n,w+/n,n,n
		@ 10,39 say "count      "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 10,52 say "stay in step [  ] times  "
		set color to w+/n,w+/n,n,n
		@ 10,66 say substr(TRG_VAL,1,2)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(STRG_TYP) = 2
		@ 10,3 say "Method used to decide step trigger [           ] "
		set color to w+/n,w+/n,n,n
		@ 10,39 say "incremental"
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 10,52 say "in [   ] days            "
		set color to w+/n,w+/n,n,n
		@ 10,56 say substr(TRG_VAL,1,3)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(STRG_TYP) = 3
		@ 10,3 say "Method used to decide step trigger [           ] "
		set color to w+/n,w+/n,n,n
		@ 10,39 say "age        "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 10,52 say "of [  ] yrs [  ] mnths   "
		set color to w+/n,w+/n,n,n
		@ 10,56 say substr(TRG_VAL,1,2)
		@ 10,65 say substr(TRG_VAL,3,2)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(STRG_TYP) = 4
		@ 10,3 say "Method used to decide step trigger [           ] "
		set color to w+/n,w+/n,n,n
		@ 10,39 say "monthly    "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 10,52 say "on [  ] of month         "
		set color to w+/n,w+/n,n,n
		@ 10,56 say substr(TRG_VAL,1,2)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(STRG_TYP) = 5
		@ 10,3 say "Method used to decide step trigger [           ] "
		set color to w+/n,w+/n,n,n
		@ 10,39 say "yearly     "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 10,52 say "on [  ] month [  ] day   "
		set color to w+/n,w+/n,n,n
		@ 10,56 say substr(TRG_VAL,1,2)
		@ 10,67 say substr(TRG_VAL,3,2)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	otherwise
		@ 10,3 say space(74)
		
	endcase
	
	@ 11,3 say "If less then trigger value : goto schedule [     ] step [   ]"
	set color to w+/n,w+/n,n,n
	@ 11,47 say T1_SCHD
	@ 11,60 say T1_STEP
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
	@ 12,3 say "If greater or equal to trigger value : goto schedule [     ] step [   ]"
	set color to w+/n,w+/n,n,n
	@ 12,57 say T2_SCHD
	@ 12,70 say T2_STEP
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
else
	@ 11,3 say space(63)
	@ 12,3 say space(73)
	
endif

*
* Display advance timeout value if SSTP_TYP = 1, 2, 3,
*

if val(SSTP_TYP) = 1 .or. val(SSTP_TYP) = 2 .or. val(SSTP_TYP) = 3
	@ 13,3 say "If not advanced in [   ] days : goto schedule [     ] step [   ]"
	set color to w+/n,w+/n,n,n
	@ 13,23 say DL_VAL
	@ 13,50 say DL_SCHD
	@ 13,63 say DL_STEP
	
	if COLOR_SCRN
		set color to g/n,w+/n,n,n
	else
		set color to w/n,w+/n,n,n
	endif
	
else
	@ 13,3 say "                                                                "
	
endif

*
* Display letter id and letter type followed by appropriate letter info
*

@ 15,3 say "Letter to send [        ]"
set color to w+/n,w+/n,n,n
@ 15,19 say LTR_ID

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

if val(SSTP_TYP) <> 6 .and. val(SSTP_TYP) <> 7 .and. val(SSTP_TYP) <> 8
	@ 16,3 say "Method used to decide letter trigger [           ] "
	
	do case
	case val(SLTR_TYP) = 1
		set color to w+/n,w+/n,n,n
		@ 16,41 say "incremental"
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 16,54 say "in [   ] days         "
		set color to w+/n,w+/n,n,n
		@ 16,58 say substr(LTR_VAL,1,3)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(SLTR_TYP) = 2
		set color to w+/n,w+/n,n,n
		@ 16,41 say "age        "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 16,54 say "of [  ] yrs [  ] mnths"
		set color to w+/n,w+/n,n,n
		@ 16,58 say substr(LTR_VAL,1,2)
		@ 16,67 say substr(LTR_VAL,3,2)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(SLTR_TYP) = 3
		set color to w+/n,w+/n,n,n
		@ 16,41 say "monthly    "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 16,54 say "on [  ] of month      "
		set color to w+/n,w+/n,n,n
		@ 16,58 say substr(LTR_VAL,1,2)
		
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	case val(SLTR_TYP) = 4
		set color to w+/n,w+/n,n,n
		@ 16,41 say "yearly     "
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 16,54 say "on [  ] month [  ] day"
		set color to w+/n,w+/n,n,n
		@ 16,58 say substr(LTR_VAL,1,2)
		@ 16,69 say substr(LTR_VAL,3,2)
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
	otherwise
		set color to w+/n,w+/n,n,n
		@ 16,41 say "invalid tgr"
		
		if COLOR_SCRN
			set color to g/n,w+/n,n,n
		else
			set color to w/n,w+/n,n,n
		endif
		
		@ 16,54 say space(24)
		
	endcase
	
else
	@ 16,3 say "                                                                          "
	
endif

clear gets

return


*: EOF: PUTSCH.PRG
