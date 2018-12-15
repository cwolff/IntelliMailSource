* Last revised : Sun 9-Oct-88 at 0:50 pm
*************************************************************************
*                                                                       *
* SETUP >>> Setup IntelliMail   										*
*            entry : None                                               *
*            exit : None                                                *
*                                                                       *
* (C)opyright 1988 Personal Touch Software Inc.,  All Rights Reserved.  *
*                                                                       *
*************************************************************************

clear all

set echo off
set status off
set scoreboard off
set heading off
set safety off
set talk off
set bell off
set delimiter on
set delimiters to "[]"
set century on
set date american
set deleted on
set exact off

store .F. to COLOR_SCRN
do OPENING

@ 7,5 say "Do you have a color monitor [yn]?"

response = " "
DO WHILE .NOT. response $ "YNW"
	response = UPPER(CHR(INKEY(0)))

ENDDO

@ 7,5 say "                                 "

if RESPONSE = "Y"
    store .T. to COLOR_SCRN
    do OPENING

    set color to W/N

    @ 7,5 say "Is the line below clear [yn] ?"

    set color to B/W

    @ 9,5 say "If you can read this line enter y"

    response = " "
    do while .not. RESPONSE $ "YN"
	    response = upper(chr(inkey(0)))

    enddo

    set color to W/N

    @ 7,5 say "                              "
    @ 9,5 say "                                 "

    if RESPONSE = "N"
        store .F. to COLOR_SCRN
        do OPENING

    endif

endif

if COLOR_SCRN
    set color to G/N,W+/N
else
    set color to W/N,W+/N
endif

store "C" to DRIVE
store "IM      " to DIRECTORY

*
* Set valid drives
*

store "CDEFGHIJKLMNOPQRSTUVWXYZ" to DRIVE_STR

store nbrdrv() to HIGH_DRV

if HIGH_DRV $ "AB"
	store 20 to STAT_LINE
	store "A hard disk is required to use IntelliMail" to STAT_MSG
	do STATUS
			
	return

else
	store substr(DRIVE_STR, 1, at(HIGH_DRV,DRIVE_STR)) to VALID_STR

endif

@ 6,5  say "Valid drives " + VALID_STR
@ 7,5  say "Enter the drive letter"
@ 8,5  say "to install IntelliMail" get DRIVE picture "!" valid DRIVE $ VALID_STR
@ 10,5 say "Enter the directory name to install"
@ 11,5 say "IntelliMail ?" get DIRECTORY picture "!!!!!!!!"

set confirm on
read
set confirm off

clear gets

@ 6,5 clear to 11,45

store trim(DIRECTORY) to DIRECTORY

store "&DRIVE:\&DIRECTORY" to PLACE

@ 7,5 say "Creating &PLACE directory"

store "mkdir &PLACE > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53
@ 7,5 say "Creating &PLACE\LETTER directory"

store "mkdir &PLACE\LETTER > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53

@ 7,5 say "Creating &PLACE\DAILY directory "

store "mkdir &PLACE\DAILY > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53

@ 6,5 clear to 11,45

store 20 to STAT_LINE
store "Please insert IntelliMail Disk Number 1" to STAT_MSG
do STATUS

@ 7,5 say "Installing IntelliMail Disk Number 1"

do while .not. file("A:IM.EXE")
	store 20 to STAT_LINE
	store "Incorrect disk - please correct" to STAT_MSG
	do STATUS
			
enddo

store "copy a:*.* &PLACE > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53

@ 6,5 clear to 11,45

store 20 to STAT_LINE
store "Please insert IntelliMail Disk Number 2" to STAT_MSG
do STATUS

do while .not. file("A:IM1.OVL")
	store 20 to STAT_LINE
	store "Incorrect disk - please correct" to STAT_MSG
	do STATUS
			
enddo

@ 7,5 say "Installing IntelliMail Disk Number 2"

store "copy a:*.* &PLACE > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53

@ 6,5 clear to 11,45

store 20 to STAT_LINE
store "Please insert IntelliMail Disk Number 3" to STAT_MSG
do STATUS

do while .not. file("A:GLOBAL.DBF")
	store 20 to STAT_LINE
	store "Incorrect disk - please correct" to STAT_MSG
	do STATUS
			
enddo

@ 7,5 say "Installing IntelliMail Disk Number 3"

store "copy a:*.* &PLACE > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53
store "copy a:\letter\*.* &PLACE\letter > nul" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53

@ 6,5 clear to 11,45

@ 7,5 say "Setting IntelliMail Configuration" 

store PLACE + "\GLOBAL" to FILE
select 1
use &FILE
goto 1

if COLOR_SCRN
    replace G_MONITOR with "CO"

else
    replace G_MONITOR with "MO"

endif

select 1
use

@ 7,5 say "IntelliMail installation complete   "

store 20 to STAT_LINE
store "IntelliMail has been successfully installed" to STAT_MSG
do STATUS

store DRIVE + ":" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53
store "chdir \&DIRECTORY" to COMMAND
@ 14,5 say ""
run &COMMAND
@ 14,5 clear to 14,53

clear

@ 0,0 say "To begin type IM"

return

