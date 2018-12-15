*:*********************************************************************
*:
*:        Program: PRINTSCH.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 1:20 pm
*:
*:      Called by: SCHPRINT.PRG   
*:
*:     Documented: 09/04/88 at 17:00               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* PRINTSCH >>> Put the current record to the printer				  *
*	       entry : #												  *
*	       exit : Current record variables							  *
*                                                                     *
***********************************************************************

@ 3,5 say "<<< Schedule Information  for " + SCH_SNAME +" <<<"

*
* Display schedule name step and logon
*

@ 5,5 say "["+ SCH_SNAME + " step " + step + "]"

*
* Display schedule description
*

@ 7,3 say "Desc [" + SDESC + "]"

store "Method used to decide when to move to the next step [" to lINE

do case
case val(SSTP_TYP) = 1
	@ 9,3 say "Method used to decide when to move to the next step [manual simple    ]"
	@ 10,3 say "manual simple step : goto next schedule [" + N_SCHD + "] next step [" +  N_STEP + "]"
	
case val(SSTP_TYP) = 2
	@ 9,3 say "Method used to decide when to move to the next step [manual menu      ]"
	@ 10,3 say "manual menu step : using menu named [" + DCD_NAME + "]"
	
case val(SSTP_TYP) = 3
	@ 9,3 say "Method used to decide when to move to the next step [manual trigger   ]"
	
case val(SSTP_TYP) = 4
	@ 9,3 say "Method used to decide when to move to the next step [automatic simple ]"
	@ 10,3 say "automatic simple step : goto next schedule [" + N_SCHD + "] step [" + N_STEP + "]"
	
case val(SSTP_TYP) = 5
	@ 9,3 say "Method used to decide when to move to the next step [automatic trigger]"
	
case val(SSTP_TYP) = 6
	@ 9,3 say "Method used to decide when to move to the next step [chain simple     ]"
	@ 10,3 say "chain simple : goto next schedule [" + N_SCHD + "] next step [" + N_STEP + "]"
	
case val(SSTP_TYP) = 7
	@ 9,3 say "Method used to decide when to move to the next step [chain menu       ]"
	@ 10,3 say "chain menu step : using menu named [" + DCD_NAME + "]"
	
case val(SSTP_TYP) = 8
	@ 9,3 say "Method used to decide when to move to the next step [chain trigger    ]"
	
otherwise
	@ 9,3 say "Method used to decide when to move to the next step [invalid step trg ]"
	
endcase

*
* Calculate trigger type
*

if val(SSTP_TYP) = 3 .or. val(SSTP_TYP) = 5 .or. val(SSTP_TYP) = 8
	
	do case
	case val(STRG_TYP) = 1
		@ 10,3 say "Method used to decide step trigger [count      ]" + ;
			"stay in step [" + substr(TRG_VAL,1,2) + "] times"
		
	case val(STRG_TYP) = 2
		@ 10,3 say "Method used to decide step trigger [incremental] " + ;
			"in [" + substr(TRG_VAL,1,3) + "] days"
		
	case val(STRG_TYP) = 3
		@ 10,3 say "Method used to decide step trigger [age        ] " + ;
			"of [" + substr(TRG_VAL,1,2) + "] yrs [" + substr(TRG_VAL,3,2) + "] mnths"
		
	case val(STRG_TYP) = 4
		@ 10,3 say "Method used to decide step trigger [monthly    ] " + ;
			"on [" + substr(TRG_VAL,1,2) + "] of month"
		
	case val(STRG_TYP) = 5
		@ 10,3 say "Method used to decide step trigger [yearly      ] " + ;
			"on [" + substr(TRG_VAL,1,2) + "] month [" + substr(TRG_VAL,3,2) + "] day"
		
	endcase
	
	@ 11,3 say "If less then trigger value : goto schedule [" + T1_SCHD + "] step [" + T1_STEP + "]"
	@ 12,3 say "If greater or equal to trigger value : goto schedule [" + T2_SCHD + "] step [" + T2_STEP + "]"
	
endif

*
* Display deadline value, schedule and step
*

if val(SSTP_TYP) >= 1 .and. val(SSTP_TYP) <= 3
	@ 13,3 say "If not advanced in [" + DL_VAL + "] days : goto schedule [" + DL_SCHD + "] step [" + DL_STEP + "]"
	
endif


*
* Display letter id and letter type followed by appropriate letter info
*

@ 15,3 say "Letter to send [" + LTR_ID + "]"

if val(SSTP_TYP) <> 6 .and. val(SSTP_TYP) <> 7 .and. val(SSTP_TYP) <> 8
	
	do case
	case val(SLTR_TYP) = 1
		@ 16,3 say "Method used to decide letter trigger [incremental] " + ;
			"in [" + substr(LTR_VAL,1,3) + "] days"
		
	case val(SLTR_TYP) = 2
		@ 16,3 say "Method used to decide letter trigger [age        ] " + ;
			"of [" + substr(LTR_VAL,1,2) + "] yrs [" + substr(LTR_VAL,3,2) + "] mnths"
		
	case val(SLTR_TYP) = 3
		@ 16,3 say "Method used to decide letter trigger [monthly    ] " + ;
			"on [" + substr(LTR_VAL,1,2) + "] of month"
		
	case val(SLTR_TYP) = 4
		@ 16,3 say "Method used to decide letter trigger [yearly      ] " + ;
			"on [" + substr(LTR_VAL,1,2) + "] month [" + substr(LTR_VAL,3,2) + "] day"
		
	otherwise
		@ 16,3 say "Method used to decide letter trigger [invalid trg ] "
		
	endcase
	
endif

return



*: EOF: PRINTSCH.PRG
