*************************************************************************
*                                                                       *
* FLUSH >>> Clear keyboard buffer                                       *
*                                                                       *
*             entry : NONE                                              *
*             exit : NONE												*
*																		*
*************************************************************************

procedure flush

do while inkey() <> 0
	store CHOICE to CHOICE
	
enddo

return

*************************************************************************
*                                                              			*
* CLRSCRN >>> Erase the menu window (line 4 through line 20)		    *
*	      entry : None					                                *
*	      exit : None				                                    *
*								                                        *
*************************************************************************

procedure CLRSCRN

@ 0,0
@ 4,0 clear to 21,79

return

*************************************************************************
*                                                              			*
* FRAME >>> Erase the screen and frame with a header and trailer       	*
*	    entry : HEAD, L_TAIL, R_TAIL			                        *
*	    exit : None 			                                        *
*                                                              			*
*************************************************************************

procedure FRAME

store "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ" to T_LINE_1
store  T_LINE_1 + "ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ" to T_LINE_1

store "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ" to T_LINE_2
store  T_LINE_2 + "ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู" to T_LINE_2

store "                                              " to blank
store "  F I X I T            " to HEAD_LINE
store HEAD_LINE + substr(blank,1,(56 - len(hEAD)) / 2) + hEAD to HEAD_LINE
store HEAD_LINE + substr(blank,1,79 - len(HEAD_LINE)) + " " to HEAD_LINE

store "ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ" to lINE
store "ี[ " + space(len(L_TAIL)) + " ]" to B_LINE
store B_LINE + substr(lINE,1,80 - ((len(B_LINE) + len(R_TAIL) + 5))) to B_LINE
store len(B_LINE) + 2 to R_COL
store B_LINE + "[ " + space(len(R_TAIL)) + " ]ธ" to B_LINE

store "                                       " to TAIL_LINE
store "ณ" + TAIL_LINE + TAIL_LINE + "ณ" to TAIL_LINE

store "ภฤฤฤ (C) Copyright 1988, Personal Touch " to CPYRGHT
store CPYRGHT + "Software Inc.   All Rights Reserved ฤฤฤู" to CPYRGHT

do CLRSCRN

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 1,0 say T_LINE_1

if COLOR_SCRN
	set color to w/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 2,0 say HEAD_LINE

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 2,0 say "ณ"
@ 2,79 say "ณ"
@ 3,0 say T_LINE_2

if COLOR_SCRN
	set color to b/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 22,0 say B_LINE

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 22,3 say L_TAIL
@ 22,R_COL say R_TAIL

if COLOR_SCRN
	set color to b/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 23,0 say TAIL_LINE

if COLOR_SCRN
	set color to bg/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 24,0 say CPYRGHT

if COLOR_SCRN
	set color to b/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

@ 24,0 say "ภฤฤฤ"
@ 24,76 say "ฤฤฤู"

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

release hEAD,R_TAIL,T_LINE,HEAD_LINE,B_LINE,TAIL_LINE,CPYRGHT,blank,lINE

return

*************************************************************************
*                                      									*
* PROMPT >>> Displays a prompt message centered at the given line      	*
*	       entry : PMT_LINE PMT_MSG                             		*
*	       exit : None			                                      	*
*                                      									*
*************************************************************************

procedure prompt

@ PMT_LINE,(((80-len(PMT_MSG))/2)) say PMT_MSG
release PMT_LINE,PMT_MSG

return

*************************************************************************
*                                              							*
* STATUS >>> Displays a status message at the specified line and       	*
*	       prompts the user to hit any key to continue                 	*
*	       entry : STAT_LINE STAT_MSG			                       	*
*	       exit : None					                               	*
*									                                    *
*************************************************************************

procedure status

do flush

save screen to STATUS_SCR

if COLOR_SCRN
	set color to gr+/r,w+/n,n,n
else
	set color to n/w,w+/n,n,n
endif

@ STAT_LINE-1,0 say "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
@ STAT_LINE,0   say "บ                                                                              บ"
@ STAT_LINE+1,0 say "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"

store STAT_MSG + ", ฤู to continue." to STAT_MSG

if COLOR_SCRN
	set color to gr+/r,w+/r,n,n
else
	set color to n/w,w+/n,n,n
endif

@ STAT_LINE,((80-len(STAT_MSG))/2) say STAT_MSG

store 1 to THE_KEY

do while THE_KEY <> 13
	store inkey() to THE_KEY
	
enddo

release STAT_LINE,STAT_MSG,THE_KEY

if COLOR_SCRN
	set color to g/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

restore screen from STATUS_SCR

return

*************************************************************************
*                                                                       *
* OPENFILE >>> open dbase III file                                      *
*       Entry                                                           *   
*           SELECT_NBR = area number to use for select                  *
*           FILE_NAME = name of file to be opened                       *
*           ALIAS_NAME = alias name                                     *
*           INDEX_NAME = name of index to be opened                     *
*           IFLD_NAME = index field name                                *
*       Exit                                                            *
*           FILE_OPEN = .T. if successful                               *
*                       .F. if failed                                   *
*                                                                       *
*************************************************************************

procedure OPENFILE

store .f. to FILE_OPEN

do case
	
case len(FILE_NAME) > 0 .and. len(INDEX_NAME) = 0
	if file ((FILE_NAME + ".DBF"))
		select &SELECT_NBR
		use &FILE_NAME alias &ALIAS_NAME
		
		store .t. to FILE_OPEN
		
*	else
*		store 22 to STAT_LINE
*		store "Could not open &FILE_NAME file" to STAT_MSG
*		do status
		
	endif
	
case len(FILE_NAME) > 0 .and. len(INDEX_NAME) > 0
	if file ((FILE_NAME + ".DBF"))
		if file ((INDEX_NAME + ".NTX"))
			select &SELECT_NBR
			use &FILE_NAME index &INDEX_NAME alias &ALIAS_NAME
			
			store .t. to FILE_OPEN
			
		else
			
*			if FILE_NAME <> "SYSTEM"
*				store 22 to STAT_LINE
*				store "Could not open &INDEX_NAME index" to STAT_MSG
*				do status
*				
*				store 22 to STAT_LINE
*				store "Will rebuild &FILE_NAME index file &INDEX_NAME" to STAT_MSG
*				do status
*				
*			endif
			
			select &SELECT_NBR
			use &FILE_NAME alias &ALIAS_NAME
			index on &IFLD_NAME to &INDEX_NAME
			set index to &INDEX_NAME
			
			store .t. to FILE_OPEN
			
		endif
		
*	else
*		store 22 to STAT_LINE
*		store "Could not open &FILE_NAME file" to STAT_MSG
*		do status
		
	endif
endcase

return

*************************************************************************
*							                                       		*
* READMRK >>> Read the current record into the record variables        	*
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READMRK

store M_MRK_NBR to MRK_NBR
store M_SCHD_PTR to SCHD_PTR
store M_STP_PTR to STP_PTR
store M_MDESC to MDESC
store M_DINT to DINT
store M_LST_SCHD to LST_SCHD
store M_LST_STP to LST_STP
store M_LST_DESC to LST_DESC
store M_LST_DINT to LST_DINT
store M_LTR_TOS to LTR_TOS
store M_DATE_TOS to DATE_TOS
store M_SEND_FLG to SEND_FLG
store M_TRG_CNT to TRG_CNT
store M_TRG_DATE to TRG_DATE
store M_DATE_SNT to DATE_SNT
store M_MSTP_TYP to MSTP_TYP
store M_MLTR_TYP to MLTR_TYP
store M_MTRG_TYP to MTRG_TYP
store M_ERR_FLAG to ERR_FLAG
store M_ERR_DESC to ERR_DESC
store M_LOGON to LOGON

return

*************************************************************************
*					                                            		*
* WRITEMRK >>> Write current record variables to the screen		        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITEMRK

replace M_MRK_NBR with MRK_NBR
replace M_SCHD_PTR with SCHD_PTR
replace M_STP_PTR with STP_PTR
replace M_MDESC with MDESC
replace M_DINT with DINT
replace M_LST_SCHD with LST_SCHD
replace M_LST_STP with LST_STP
replace M_LST_DESC with LST_DESC
replace M_LST_DINT with LST_DINT
replace M_LTR_TOS with upper(LTR_TOS)
replace M_DATE_TOS with DATE_TOS
replace M_SEND_FLG with SEND_FLG
replace M_TRG_CNT with TRG_CNT
replace M_TRG_DATE with TRG_DATE
replace M_DATE_SNT with DATE_SNT
replace M_MSTP_TYP with MSTP_TYP
replace M_MLTR_TYP with MLTR_TYP
replace M_MTRG_TYP with MTRG_TYP
replace M_ERR_FLAG with ERR_FLAG
replace M_ERR_DESC with ERR_DESC
replace M_LOGON with upper(LOGON)

return

*************************************************************************
*							                                       		*
* READSCH >>> Read the current record into the record variables         *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure READSCH

store ltrim(str(S_STEP)) + space(3 - len(ltrim(str(S_STEP)))) to step
store S_SDESC to SDESC
store S_SSTP_TYP to SSTP_TYP
store S_SLTR_TYP to SLTR_TYP
store S_LTR_VAL to LTR_VAL
store S_LTR_ID to LTR_ID
store S_N_SCHD to N_SCHD
store S_N_STEP to N_STEP
store S_DCD_NAME to DCD_NAME
store S_STRG_TYP to STRG_TYP
store S_TRG_VAL to TRG_VAL
store S_T1_SCHD to T1_SCHD
store S_T1_STEP to T1_STEP
store S_T2_SCHD to T2_SCHD
store S_T2_STEP to T2_STEP
store S_DL_VAL to DL_VAL
store S_DL_SCHD to DL_SCHD
store S_DL_STEP to DL_STEP
store S_LOGON to LOGON

return

*************************************************************************
*					                                            		*
* WRITESCH >>> Write current record variables to the screen		        *
*	       entry : # to write, current record variables		            *
*	       exit : None						                            *
*									                                    *
*************************************************************************

procedure WRITESCH

replace S_STEP with val(step)
replace S_SDESC with SDESC
replace S_SSTP_TYP with SSTP_TYP
replace S_SLTR_TYP with SLTR_TYP
replace S_LTR_VAL with LTR_VAL
replace S_LTR_ID with upper(LTR_ID)
replace S_N_SCHD with upper(N_SCHD)
replace S_N_STEP with ltrim(str(val(N_STEP))) + space(3 - len(ltrim(str(val(N_STEP)))))
replace S_DCD_NAME with DCD_NAME
replace S_STRG_TYP with STRG_TYP
replace S_TRG_VAL with TRG_VAL
replace S_T1_SCHD with upper(T1_SCHD)
replace S_T1_STEP with ltrim(str(val(T1_STEP))) + space(3 - len(ltrim(str(val(T1_STEP)))))
replace S_T2_SCHD with upper(T2_SCHD)
replace S_T2_STEP with ltrim(str(val(T2_STEP))) + space(3 - len(ltrim(str(val(T2_STEP)))))
replace S_DL_VAL with DL_VAL
replace S_DL_SCHD with DL_SCHD
replace S_DL_STEP with DL_STEP
replace S_LOGON with upper(LOGON)

return


