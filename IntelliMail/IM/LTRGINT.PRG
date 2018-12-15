*:*********************************************************************
*:
*:        Program: LTRGINT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Thu 29-Sep-88 at 8:12 pm
*:
*:      Called by: MRKMOVE.PRG    
*:               : CMDNEXT.PRG    
*:               : EDITMRK.PRG    
*:               : AUTONEXT.PRG   
*:               : ADDMRK.PRG     
*:
*:          Calls: STATUS           (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* LTRGINT >>> Initialize DATE_TOS based on letter trigger    		  *
*			entry : SLTR_TYP = 1,2,3,4                                *
*                               client data read                      *
*                               marker data read                      *
*                               schedule data read                    *
*	  		exit : 	DATE_TOS = date                                   *
*																	  *
***********************************************************************

store LTR_ID to LTR_TOS
store date() to DATE_TOS
store "F" to SEND_FLG
store ctod("  /  /    ") to DATE_SNT
store SLTR_TYP to MLTR_TYP

do case
	
	*
	* Incremental letter trigger
	*   DATE_TOS = LTR_VAL (number of days) + date()
	*
	*   "in XXX days"
	*
	
case val(MLTR_TYP) = 1
	store (date() + val(substr(LTR_VAL,1,3))) to DATE_TOS
	
	*
	* age letter trigger
	*    DATE_TOS = LTR_VAL (age of client in months) + BIRTH
	*
	*    "of XX yrs XX mnths"
	*
	
case val(MLTR_TYP) = 2
	store (BIRTH + (int(365.25 * int(val(substr(LTR_VAL,1,2)))) + ;
		(int(30.42 * (val(substr(LTR_VAL,3,2))))))) to DATE_TOS
	
	*
	* monthly letter trigger
	*   DATE_TOS = the DD of every month
	*
	*   if current day of month < LTR_VAL of month
	*       DATE_TOS = current month + LTR_VAL + current year
	*   else
	*       if current month = 12
	*           DATE_TOS = 01 + LTR_VAL + next year
	*       else
	*          DATE_TOS = next month + LTR_VAL + current year
	*
	*   "on XX of month"
	*
	
case val(MLTR_TYP) = 3
	if val(substr(dtoc(date()),4,2)) < val(substr(LTR_VAL,1,2))
		store ctod(substr(dtoc(date()),1,3) + ;
			substr(LTR_VAL,1,2) + ;
			substr(dtoc(date()),6,5)) to DATE_TOS
		
	else
		if val(substr(dtoc(date()),1,2)) = 12
			store ctod("01/" + ;
				+ substr(LTR_VAL,1,2) + ;
				substr(dtoc(date()),6,5)) to DATE_TOS
			
		else
			store ctod(str(val(substr(dtoc(date()),1,2))+1) + "/" + ;
				substr(LTR_VAL,1,2) + ;
				substr(dtoc(date()),6,5)) to DATE_TOS
		endif
	endif
	
	*
	* yearly letter trigger
	*   DATE_TOS = the MM/DD of every year
	*
	*   if current month of year < trigger month (substr(LTR_VAL,1,2)) of year
	*       DATE_TOS = substr(LTR_VAL,1,2) + substr(LTR_VAL,3,2) + current year
	*   else
	*       if current day of month < trigger day (substr(LTR_VAL,3,2))
	*           DATE_TOS = substr(LTR_VAL,1,2) + substr(LTR_VAL,3,2) + current year
	*       else
	*           DATE_TOS = substr(LTR_VAL,1,2) + substr(LTR_VAL,3,2) + next year
	*
	*   "on XX month XX day"
	*
	
case val(MLTR_TYP) = 4
	if val(substr(dtoc(date()),1,2)) < val(substr(LTR_VAL,1,2))
		store ctod(substr(LTR_VAL,1,2) + "/" + ;
			substr(LTR_VAL,3,2) + "/" + ;
			substr(dtoc(date()),7,4)) to DATE_TOS
		
	else
		if (val(substr(dtoc(date()),1,2)) = val(substr(LTR_VAL,1,2))) .and. ;
				(val(substr(dtoc(date()),4,2)) < val(substr(LTR_VAL,3,2)))
			store ctod(substr(LTR_VAL,1,2) + "/" + ;
				substr(LTR_VAL,3,2) + "/" + ;
				substr(dtoc(date()),7,4)) to DATE_TOS
			
		else
			store ctod(substr(LTR_VAL,1,2) + "/" + ;
				substr(LTR_VAL,3,2) + "/" + ;
				str(val(substr(dtoc(date()),4,2))+1,4)) to DATE_TOS
			
		endif
		
	endif
	
otherwise
	store "24" to ERR_FLAG
	store "Invalid letter trigger" to MDESC
	
	store 22 to STAT_LINE
	store MDESC to STAT_MSG
	do status
	
endcase

return

*: EOF: LTRGINT.PRG
