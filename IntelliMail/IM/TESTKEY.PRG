* Last revised : Sun 29-May-88 at 8:28 am
*************************************************************************
*                                                                       *
* TESTKEY >>> Gets a key and display its value                          *
*             entry : NONE                                              *
*             exit : NONE                                               *
*                                                                       *
* (C)opyright 1988, Personal Touch Software Inc.,  All Rights Reserved. *
*                                                                       *
*************************************************************************

clear

set echo off
set talk off
set scoreboard off

store 0 to KEY
	
do while KEY <> 27
	KEY = inkey()
    if KEY <> 0
        @ 10,10
        @ 10,10 say "Key = " + str(KEY)

    endif
enddo

return
