*:*********************************************************************
*:
*:        Program: FINDSCH.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: 09/04/88     16:06
*:
*:      Called by: MRKMOVE.PRG    
*:               : CMDNEXT.PRG    
*:               : AUTONEXT.PRG   
*:               : STYPE1.PRG     
*:               : STYPE2.PRG     
*:               : STYPE3.PRG     
*:               : STYPE6.PRG     
*:               : STYPE7.PRG     
*:               : STYPE8.PRG     
*:               : STYPE4.PRG     
*:               : STYPE5.PRG     
*:               : STYPEDL.PRG    
*:
*:          Calls: OPENFILE         (procedure in UTILITY.PRG)
*:               : READSCH          (procedure in UTILITY.PRG)
*:
*:     Documented: 09/04/88 at 16:58               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* FINDSCH >>> Locates schedule and step from schedule			      *
*			entry : SCH_FNAME schedule name						      *
*					SCH_FNDX index name							      *
*					SCH_STEP schedule step pointer				      *
*	  		exit : SCH_SEL = .T. if file found						  *
*							= .F. if file not found					  *
*				   STEP_SEL = .T. if step found						  *
*				    	    = .F. if step not found					  *
*				   if SCH_SEL and STEP_SEL then step is read		  *
*																	  *
***********************************************************************

store "7" to SELECT_NBR
store SCH_FNAME to FILE_NAME
store "SCHD" to ALIAS_NAME
store SCH_FNDX to INDEX_NAME
store "S_STEP" to IFLD_NAME
do OPENFILE

if FILE_OPEN
	store .t. to SCH_SEL
	
	goto top
	
	seek val(SCH_STEP)
	
	if .not. (bof() .or. eof())
		store .t. to STEP_SEL
		
		do READSCH
		
	else
		store .f. to STEP_SEL
		
	endif
	
else
	store .f. to SCH_SEL
	store .f. to STEP_SEL
	
endif

return

*: EOF: FINDSCH.PRG
