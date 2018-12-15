*:*********************************************************************
*:
*:        Program: STRGCALC.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sun 4-Sep-88 at 7:26 pm
*:
*:      Called by: STYPE3.PRG     
*:               : STYPE8.PRG     
*:               : STYPE5.PRG     
*:
*:          Calls: STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 17:01               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* STRGCALC >>> Calculate TRG_CNT or TRG_DATE on step trigger type	  *
*              so a comparison can be made by step type 3, 5 or 8     *
*			entry : STRG_TYP = 2,3,4,5                                *
*                               client data read                      *
*                               marker data read                      *
*                               schedule data read                    *
*	  		exit : 	TRG_DATE = date                                   *
*																	  *
***********************************************************************

do case
	
	*
	* Incremental step trigger
	*   TEST_DATE = TRG_VAL (number of days) + TRG_DATE()
	*
	*   "in XXX days"
	*
	
case val(STRG_TYP) = 2
	store (TRG_DATE + val(substr(TRG_VAL,1,3))) to TEST_DATE
	
	*
	* age step trigger
	*    TEST_DATE = TRG_VAL (age of client in months) + BIRTH
	*
	*    "of XX yrs XX mnths"
	*
	
case val(STRG_TYP) = 3
	store (BIRTH + (int(365.25 * int(val(substr(TRG_VAL,1,2)))) + ;
		(int(30.42 * (val(substr(TRG_VAL,3,2))))))) to TEST_DATE
	
	*
	* monthly step trigger
	*   TRG_VAL = the DD of every month
	*
	*   if TRG_DATE day of month < TRG_VAL day of month [substr(TRG_VAL,1,2)]
	*       TEST_DATE = "TRG_DATE month / TRG_VAL day of month / TRG_DATE year"
	*   else
	*       if TRG_DATE month = 12
	*           TEST_DATE = "01 / TRG_VAL day of month / TRG_DATE year + 1"
	*       else
	*          TRG_DATE = "TRG_DATE month + 1 / TRG_VAL / TRG_DATE year
	*
	*   "on MM of month"
	*
	
case val(STRG_TYP) = 4
	
	if val(substr(dtoc(TRG_DATE),4,2)) < val(substr(TRG_VAL,1,2))
		store ctod(substr(dtoc(TRG_DATE),1,3) + ;
			substr(TRG_VAL,1,2) + ;
			substr(dtoc(TRG_DATE),6,5)) to TEST_DATE
		
	else
		if val(substr(dtoc(TRG_DATE),1,2)) = 12
			store ctod("01/" + ;
				substr(TRG_VAL,1,2) + "/" + ;
				ltrim(str(val(substr(dtoc(TRG_DATE),7,4))+1))) to TEST_DATE
			
		else
			store ctod(ltrim(str(val(substr(dtoc(TRG_DATE),1,2))+1)) + "/" + ;
				substr(TRG_VAL,1,2) + ;
				substr(dtoc(TRG_DATE),6,5)) to TEST_DATE
		endif
	endif
	
	*
	* yearly step trigger
	*   TRG_VAL = the MM/DD of every year
	*
	*   if TRG_DATE month of year < TRG_VAL month of year [(substr(TRG_VAL,1,2))]
	*       TEST_DATE = "substr(TRG_VAL,1,2) / TRG_VAL day of month / TRG_DATE year"
	*   else
	*       if TRG_DATE day of month < trigger day (substr(TRG_VAL,3,2))
	*           TEST_DATE = "substr(TRG_VAL,1,2) / substr(TRG_VAL,3,2) / TRG_DATE year"
	*       else
	*           TEST_DATE = "substr(TRG_VAL,1,2) / substr(TRG_VAL,3,2) / TRG_DATE year + 1"
	*
	*   "on MM month DD day"
	*
	
case val(STRG_TYP) = 5
	
	if val(substr(dtoc(TRG_DATE),1,2)) < val(substr(TRG_VAL,1,2))
		store ctod(substr(TRG_VAL,1,2) + "/" + ;
			substr(TRG_VAL,3,2) + ;
			substr(dtoc(TRG_DATE),6,5)) to TEST_DATE
		
	else
		if (val(substr(dtoc(TRG_DATE),1,2)) = val(substr(TRG_VAL,1,2))) .and. ;
				(val(substr(dtoc(TRG_DATE),4,2)) < val(substr(TRG_VAL,3,2)))
			store ctod(substr(TRG_VAL,1,2) + "/" + ;
				substr(TRG_VAL,3,2) + ;
				substr(dtoc(TRG_DATE),6,5)) to TEST_DATE
			
		else
			store ctod(substr(TRG_VAL,1,2) + "/" + ;
				substr(TRG_VAL,3,2) + "/" + ;
				ltrim(str(val(substr(dtoc(TRG_DATE),7,4))+1))) to TEST_DATE
			
		endif
		
	endif
	
otherwise
	if MTRG_TYP <> " "
		store "25" to ERR_FLAG
		store "Invalid step trigger" to MDESC
		
		store 22 to STAT_LINE
		store MDESC to STAT_MSG
		do status
		
	endif
	
endcase

return

*: EOF: STRGCALC.PRG
