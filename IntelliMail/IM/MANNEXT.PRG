*:*********************************************************************
*:
*:        Program: MANNEXT.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Sat 8-Oct-88 at 10:45 am
*:
*:      Called by: ADVMENU.PRG    
*:
*:          Calls: PROMPT           (procedure in UTILITY.PRG)
*:               : FINDSCH.PRG
*:               : STATUS           (procedure in UTILITY.PRG)
*:               : STYPE1.PRG
*:               : STYPE2.PRG
*:               : STYPE3.PRG
*:               : STYPE6.PRG
*:               : STYPE7.PRG
*:               : STYPE8.PRG
*:               : LTRGINT.PRG
*:
*:     Documented: 09/04/88 at 16:56               FoxDoc version 1.0
*:*********************************************************************
*																	  *
* MANNEXT >>> Manual advance logic                                    *
*	       entry : Selected client and marker                         *
*				   MRK_SPOT                                           *
*                  O_MRK_NBR                                          *
*                  O_SCHD_PTR                                         *
*        		   O_STP_PTR                                          *
*                  O_MDESC                                            *
*                  O_DINT                                             *
*	       exit : None												  *
*																	  *
***********************************************************************

@ 7,5  say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
@ 8,5  say "º                                                                      º Û"
@ 9,5  say "º                                                                      º Û"
@ 10,5 say "º                                                                      º Û"
@ 11,5 say "º                                                                      º Û"
@ 12,5 say "º                                                                      º Û"
@ 13,5 say "º                                                                      º Û"
@ 14,5 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ Û"
@ 15,5 say " ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"

store 9 to PMT_LINE
store "Using marker to determine action to take." to PMT_MSG
do prompt

*
* Check to see if this step for this marker
* is to be advanced
*

if val(MSTP_TYP) >= 1 .and. val(MSTP_TYP) <= 3
	store MRK_SNAME + "SCH" to SCH_FNAME
	store MRK_SNAME + "SCH" to SCH_FNDX
	store STP_PTR to SCH_STEP
	
	do FINDSCH
	
	do case
	case .not. SCH_SEL
		store "21" to ERR_FLAG
		store "Could not find the &MRK_SNAME schedule" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
		store 22 to STAT_LINE
		store ERR_MSG to STAT_MSG
		do status
		
	case .not. STEP_SEL
		store "22" to ERR_FLAG
		store "Could not find step &SCH_STEP in the &MRK_SNAME schedule" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
		store 22 to STAT_LINE
		store ERR_MSG to STAT_MSG
		do status
		
	otherwise
		do case
		case val(SSTP_TYP) = 1
			do STYPE1
			
		case val(SSTP_TYP) = 2
			do STYPE2
			
		case val(SSTP_TYP) = 3
			do STYPE3
			
		otherwise
			store "24" to ERR_FLAG
			store "Invalid MANUAL type in step &SCH_STEP of &MRK_SNAME schedule" to ERR_MSG
			store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
			
			store 22 to STAT_LINE
			store ERR_MSG to STAT_MSG
			do status
			
		endcase
		
		select SCHD
		use
		
	endcase
	
endif

*
* If no errors and the next step is a chain step then continue
*

store 1 to CHOICE

do while ( val(MSTP_TYP) = 6 .or. val(MSTP_TYP) = 7 .or. val(MSTP_TYP) = 8 ) .and. ( val(ERR_FLAG) = 0 ) .and. (CHOICE <> 0)
	store SCHD_PTR + "SCH" to SCH_FNAME
	store SCHD_PTR + "SCH" to SCH_FNDX
	store STP_PTR to SCH_STEP
	
	do FINDSCH
	
	do case
	case .not. SCH_SEL
		store "30" to ERR_FLAG
		store "Could not find the next schedule (&SCHD_PTR)" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
		store 22 to STAT_LINE
		store ERR_MSG to STAT_MSG
		do status
		
	case .not. STEP_SEL
		store "31" to ERR_FLAG
		store "Could not find the next step (&STP_PTR) in the &SCHD_PTR schedule" to ERR_MSG
		store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
		
		store 22 to STAT_LINE
		store ERR_MSG to STAT_MSG
		do status
		
	otherwise
		do case
		case val(MSTP_TYP) = 6
			do STYPE6
			
		case val(MSTP_TYP) = 7
			do STYPE7
			
		case val(MSTP_TYP) = 8
			do STYPE8
			
		otherwise
			store "25" to ERR_FLAG
			store "Invalid CHAIN type in the next step (&STP_PTR) of the &SCHD_PTR schedule" to ERR_MSG
			store ERR_MSG + space(65 - len(ERR_MSG)) to ERR_DESC
			
			store 22 to STAT_LINE
			store ERR_MSG to STAT_MSG
			do status
			
		endcase
		
		select 7
		use
		
	endcase
	
enddo

*
* If no errors initialize marker at the current schedule and step
*

if val(ERR_FLAG) = 0
	
	*
	* Initialize letter info
	*
	
	store 11 to PMT_LINE
	store "Initializing letter trigger information" to PMT_MSG
	do prompt
	
	do LTRGINT
	
	*
	* TRG_CNT zeroed at time it exceeds TRG_VAL (see STYPE[3,5,8].PRG
	* TRG_DATE always initialized
	*
	
	store 12 to PMT_LINE
	store "Initializing step trigger information" to PMT_MSG
	do prompt
	
	store date() to TRG_DATE
	
	*
	* Set last schedule, step, description and data initialized
	*
	
	store O_SCHD_PTR to LST_SCHD
	store O_STP_PTR to LST_STP
	store O_MDESC to LST_DESC
	store O_DINT to LST_DINT
	
endif

select MARKER

if val(ERR_FLAG) <> 99
	if val(ERR_FLAG) <> 0
		@ 9,6  say space(70)
		@ 10,6 say space(70)
		@ 11,6 say space(70)
		@ 12,6 say space(70)
		
		store 9 to PMT_LINE
		store "This client marker has encountered an error in processing." to PMT_MSG
		do prompt
		
		store 10 to PMT_LINE
		store "Make a note of the client and the marker selected  so  you" to PMT_MSG
		do prompt
		
		store 11 to PMT_LINE
		store "can  clear  the  error  from  the  client   status   menu." to PMT_MSG
		do prompt
		
		store 22 to STAT_LINE
		store "ATTENTION : Please read the above" to STAT_MSG
		do status
		
	else
		store 22 to STAT_LINE
		store "The client marker has been successfully advanced" to STAT_MSG
		do status
		
	endif
	
else
	@ 9,6  say space(70)
	@ 10,6 say space(70)
	@ 11,6 say space(70)
	@ 12,6 say space(70)
	
	store 9 to PMT_LINE
	store "This client marker is to be  terminated.  You will be  given" to PMT_MSG
	do prompt
	
	store 10 to PMT_LINE
	store "a chance at the next screen to recover this  clients  marker" to PMT_MSG
	do prompt
	
	store 11 to PMT_LINE
	store "entry if you do not wish for this marker entry to be deleted." to PMT_MSG
	do prompt
	
	store 22 to STAT_LINE
	store "ATTENTION : Please read the above" to STAT_MSG
	do status
	
endif

return
*: EOF: MANNEXT.PRG
