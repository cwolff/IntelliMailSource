*:*********************************************************************
*:
*:        Program: GREET.PRG
*:
*:         System: I n t e l l i M a i l
*:         Author: WareWolff
*:      Copyright (c) 1988, Personal Touch Software Inc.
*:  Last modified: Mon 5-Sep-88 at 5:04 pm
*:
*:      Called by: IM.PRG         
*:
*:     Documented: 09/04/88 at 16:52               FoxDoc version 1.0
*:*********************************************************************
*                                                                     *
* GREET >>> Hello greeting											  *
*            entry : None                                             *
*            exit : None                                              *
*                                                                     *
***********************************************************************

set color to w/n

clear

if COLOR_SCRN
	set color to +gr/n
else
	set color to w+/n
endif

@ 01,00 to 24,79

set color to +w/n

@ 02,01 clear to 23,78

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

*
* Display the box
*

@ 02,03 clear to 07,24

*
* Display the letters
*

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "¿"
@ 03,02 say "³"
@ 04,02 say "³"
@ 05,02 say "³"
@ 06,02 say "³"
@ 07,02 say "Ù"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "Ä¿"
@ 03,02 say " ³"
@ 04,02 say " ³"
@ 05,02 say " ³"
@ 06,02 say " ³"
@ 07,02 say "ÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄ¿"
@ 03,02 say "¿ ³"
@ 04,02 say "Ù ³"
@ 05,02 say "  ³"
@ 06,02 say "  ³"
@ 07,02 say "ÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄ¿"
@ 03,02 say "Ä¿ ³"
@ 04,02 say "ÄÙ ³"
@ 05,02 say "   ³"
@ 06,02 say "   ³"
@ 07,02 say "ÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄ¿"
@ 03,02 say "ÚÄ¿ ³"
@ 04,02 say "ÀÄÙ ³"
@ 05,02 say "    ³"
@ 06,02 say "    ³"
@ 07,02 say "ÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄ¿"
@ 03,02 say " ÚÄ¿ ³"
@ 04,02 say " ÀÄÙ ³"
@ 05,02 say "     ³"
@ 06,02 say "     ³"
@ 07,02 say "ÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄ¿"
@ 03,02 say "  ÚÄ¿ ³"
@ 04,02 say "  ÀÄÙ ³"
@ 05,02 say "      ³"
@ 06,02 say "      ³"
@ 07,02 say "ÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄ¿"
@ 03,02 say "   ÚÄ¿ ³"
@ 04,02 say "   ÀÄÙ ³"
@ 05,02 say "       ³"
@ 06,02 say "       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "    ÚÄ¿ ³"
@ 04,02 say "    ÀÄÙ ³"
@ 05,02 say "~       ³"
@ 06,02 say "~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "     ÚÄ¿ ³"
@ 04,02 say "     ÀÄÙ ³"
@ 05,02 say "~~       ³"
@ 06,02 say "~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "      ÚÄ¿ ³"
@ 04,02 say "      ÀÄÙ ³"
@ 05,02 say "~~~       ³"
@ 06,02 say "~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "       ÚÄ¿ ³"
@ 04,02 say "       ÀÄÙ ³"
@ 05,02 say "~~~~       ³"
@ 06,02 say "~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "        ÚÄ¿ ³"
@ 04,02 say "        ÀÄÙ ³"
@ 05,02 say "~~~~~       ³"
@ 06,02 say "~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "         ÚÄ¿ ³"
@ 04,02 say "         ÀÄÙ ³"
@ 05,02 say "~~~~~~       ³"
@ 06,02 say "~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "          ÚÄ¿ ³"
@ 04,02 say "          ÀÄÙ ³"
@ 05,02 say "~~~~~~~       ³"
@ 06,02 say "~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "           ÚÄ¿ ³"
@ 04,02 say "           ÀÄÙ ³"
@ 05,02 say " ~~~~~~~       ³"
@ 06,02 say " ~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "            ÚÄ¿ ³"
@ 04,02 say "            ÀÄÙ ³"
@ 05,02 say "  ~~~~~~~       ³"
@ 06,02 say "  ~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "~            ÚÄ¿ ³"
@ 04,02 say "             ÀÄÙ ³"
@ 05,02 say "   ~~~~~~~       ³"
@ 06,02 say "   ~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "~~            ÚÄ¿ ³"
@ 04,02 say "              ÀÄÙ ³"
@ 05,02 say "    ~~~~~~~       ³"
@ 06,02 say "    ~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "~~~            ÚÄ¿ ³"
@ 04,02 say "               ÀÄÙ ³"
@ 05,02 say "     ~~~~~~~       ³"
@ 06,02 say "     ~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say " ~~~            ÚÄ¿ ³"
@ 04,02 say "                ÀÄÙ ³"
@ 05,02 say "      ~~~~~~~       ³"
@ 06,02 say "      ~~~~~~~       ³"
@ 07,02 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,02 say "³ ~~~            ÚÄ¿ ³"
@ 04,02 say "³                ÀÄÙ ³"
@ 05,02 say "³      ~~~~~~~       ³"
@ 06,02 say "³      ~~~~~~~       ³"
@ 07,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "¿"
@ 03,24 say "³"
@ 04,24 say "³"
@ 05,24 say "³"
@ 06,24 say "³"
@ 07,24 say "Ù"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "Ä¿"
@ 03,24 say " ³"
@ 04,24 say " ³"
@ 05,24 say " ³"
@ 06,24 say " ³"
@ 07,24 say "ÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄ¿"
@ 03,24 say "¿ ³"
@ 04,24 say "Ù ³"
@ 05,24 say "  ³"
@ 06,24 say "  ³"
@ 07,24 say "ÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄ¿"
@ 03,24 say "Ä¿ ³"
@ 04,24 say "ÄÙ ³"
@ 05,24 say "   ³"
@ 06,24 say "   ³"
@ 07,24 say "ÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄ¿"
@ 03,24 say "ÚÄ¿ ³"
@ 04,24 say "ÀÄÙ ³"
@ 05,24 say "    ³"
@ 06,24 say "    ³"
@ 07,24 say "ÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄ¿"
@ 03,24 say " ÚÄ¿ ³"
@ 04,24 say " ÀÄÙ ³"
@ 05,24 say "     ³"
@ 06,24 say "     ³"
@ 07,24 say "ÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄ¿"
@ 03,24 say "  ÚÄ¿ ³"
@ 04,24 say "  ÀÄÙ ³"
@ 05,24 say "      ³"
@ 06,24 say "      ³"
@ 07,24 say "ÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄ¿"
@ 03,24 say "   ÚÄ¿ ³"
@ 04,24 say "   ÀÄÙ ³"
@ 05,24 say "       ³"
@ 06,24 say "       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "    ÚÄ¿ ³"
@ 04,24 say "    ÀÄÙ ³"
@ 05,24 say "~       ³"
@ 06,24 say "~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "     ÚÄ¿ ³"
@ 04,24 say "     ÀÄÙ ³"
@ 05,24 say "~~       ³"
@ 06,24 say "~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "      ÚÄ¿ ³"
@ 04,24 say "      ÀÄÙ ³"
@ 05,24 say "~~~       ³"
@ 06,24 say "~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "       ÚÄ¿ ³"
@ 04,24 say "       ÀÄÙ ³"
@ 05,24 say "~~~~       ³"
@ 06,24 say "~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "        ÚÄ¿ ³"
@ 04,24 say "        ÀÄÙ ³"
@ 05,24 say "~~~~~       ³"
@ 06,24 say "~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "         ÚÄ¿ ³"
@ 04,24 say "         ÀÄÙ ³"
@ 05,24 say "~~~~~~       ³"
@ 06,24 say "~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "          ÚÄ¿ ³"
@ 04,24 say "          ÀÄÙ ³"
@ 05,24 say "~~~~~~~       ³"
@ 06,24 say "~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "           ÚÄ¿ ³"
@ 04,24 say "           ÀÄÙ ³"
@ 05,24 say " ~~~~~~~       ³"
@ 06,24 say " ~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "            ÚÄ¿ ³"
@ 04,24 say "            ÀÄÙ ³"
@ 05,24 say "  ~~~~~~~       ³"
@ 06,24 say "  ~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "~            ÚÄ¿ ³"
@ 04,24 say "             ÀÄÙ ³"
@ 05,24 say "   ~~~~~~~       ³"
@ 06,24 say "   ~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "~~            ÚÄ¿ ³"
@ 04,24 say "              ÀÄÙ ³"
@ 05,24 say "    ~~~~~~~       ³"
@ 06,24 say "    ~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "~~~            ÚÄ¿ ³"
@ 04,24 say "               ÀÄÙ ³"
@ 05,24 say "     ~~~~~~~       ³"
@ 06,24 say "     ~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say " ~~~            ÚÄ¿ ³"
@ 04,24 say "                ÀÄÙ ³"
@ 05,24 say "      ~~~~~~~       ³"
@ 06,24 say "      ~~~~~~~       ³"
@ 07,24 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say "³ ~~~            ÚÄ¿ ³"
@ 04,24 say "³                ÀÄÙ ³"
@ 05,24 say "³      ~~~~~~~       ³"
@ 06,24 say "³      ~~~~~~~       ³"
@ 07,24 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,24 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,24 say " ³ ~~~            ÚÄ¿ ³"
@ 04,24 say " ³                ÀÄÙ ³"
@ 05,24 say " ³      ~~~~~~~       ³"
@ 06,24 say " ³      ~~~~~~~       ³"
@ 07,24 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,25 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,25 say " ³ ~~~            ÚÄ¿ ³"
@ 04,25 say " ³                ÀÄÙ ³"
@ 05,25 say " ³      ~~~~~~~       ³"
@ 06,25 say " ³      ~~~~~~~       ³"
@ 07,25 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,26 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,26 say " ³ ~~~            ÚÄ¿ ³"
@ 04,26 say " ³                ÀÄÙ ³"
@ 05,26 say " ³      ~~~~~~~       ³"
@ 06,26 say " ³      ~~~~~~~       ³"
@ 07,26 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,27 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,27 say " ³ ~~~            ÚÄ¿ ³"
@ 04,27 say " ³                ÀÄÙ ³"
@ 05,27 say " ³      ~~~~~~~       ³"
@ 06,27 say " ³      ~~~~~~~       ³"
@ 07,27 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,28 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,28 say " ³ ~~~            ÚÄ¿ ³"
@ 04,28 say " ³                ÀÄÙ ³"
@ 05,28 say " ³      ~~~~~~~       ³"
@ 06,28 say " ³      ~~~~~~~       ³"
@ 07,28 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "¿"
@ 03,51 say "³"
@ 04,51 say "³"
@ 05,51 say "³"
@ 06,51 say "³"
@ 07,51 say "Ù"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "Ä¿"
@ 03,51 say " ³"
@ 04,51 say " ³"
@ 05,51 say " ³"
@ 06,51 say " ³"
@ 07,51 say "ÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄ¿"
@ 03,51 say "¿ ³"
@ 04,51 say "Ù ³"
@ 05,51 say "  ³"
@ 06,51 say "  ³"
@ 07,51 say "ÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄ¿"
@ 03,51 say "Ä¿ ³"
@ 04,51 say "ÄÙ ³"
@ 05,51 say "   ³"
@ 06,51 say "   ³"
@ 07,51 say "ÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄ¿"
@ 03,51 say "ÚÄ¿ ³"
@ 04,51 say "ÀÄÙ ³"
@ 05,51 say "    ³"
@ 06,51 say "    ³"
@ 07,51 say "ÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄ¿"
@ 03,51 say " ÚÄ¿ ³"
@ 04,51 say " ÀÄÙ ³"
@ 05,51 say "     ³"
@ 06,51 say "     ³"
@ 07,51 say "ÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄ¿"
@ 03,51 say "  ÚÄ¿ ³"
@ 04,51 say "  ÀÄÙ ³"
@ 05,51 say "      ³"
@ 06,51 say "      ³"
@ 07,51 say "ÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄ¿"
@ 03,51 say "   ÚÄ¿ ³"
@ 04,51 say "   ÀÄÙ ³"
@ 05,51 say "       ³"
@ 06,51 say "       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "    ÚÄ¿ ³"
@ 04,51 say "    ÀÄÙ ³"
@ 05,51 say "~       ³"
@ 06,51 say "~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "     ÚÄ¿ ³"
@ 04,51 say "     ÀÄÙ ³"
@ 05,51 say "~~       ³"
@ 06,51 say "~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "      ÚÄ¿ ³"
@ 04,51 say "      ÀÄÙ ³"
@ 05,51 say "~~~       ³"
@ 06,51 say "~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "       ÚÄ¿ ³"
@ 04,51 say "       ÀÄÙ ³"
@ 05,51 say "~~~~       ³"
@ 06,51 say "~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "        ÚÄ¿ ³"
@ 04,51 say "        ÀÄÙ ³"
@ 05,51 say "~~~~~       ³"
@ 06,51 say "~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "         ÚÄ¿ ³"
@ 04,51 say "         ÀÄÙ ³"
@ 05,51 say "~~~~~~       ³"
@ 06,51 say "~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "          ÚÄ¿ ³"
@ 04,51 say "          ÀÄÙ ³"
@ 05,51 say "~~~~~~~       ³"
@ 06,51 say "~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "           ÚÄ¿ ³"
@ 04,51 say "           ÀÄÙ ³"
@ 05,51 say " ~~~~~~~       ³"
@ 06,51 say " ~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "            ÚÄ¿ ³"
@ 04,51 say "            ÀÄÙ ³"
@ 05,51 say "  ~~~~~~~       ³"
@ 06,51 say "  ~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "~            ÚÄ¿ ³"
@ 04,51 say "             ÀÄÙ ³"
@ 05,51 say "   ~~~~~~~       ³"
@ 06,51 say "   ~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "~~            ÚÄ¿ ³"
@ 04,51 say "              ÀÄÙ ³"
@ 05,51 say "    ~~~~~~~       ³"
@ 06,51 say "    ~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "~~~            ÚÄ¿ ³"
@ 04,51 say "               ÀÄÙ ³"
@ 05,51 say "     ~~~~~~~       ³"
@ 06,51 say "     ~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say " ~~~            ÚÄ¿ ³"
@ 04,51 say "                ÀÄÙ ³"
@ 05,51 say "      ~~~~~~~       ³"
@ 06,51 say "      ~~~~~~~       ³"
@ 07,51 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say "³ ~~~            ÚÄ¿ ³"
@ 04,51 say "³                ÀÄÙ ³"
@ 05,51 say "³      ~~~~~~~       ³"
@ 06,51 say "³      ~~~~~~~       ³"
@ 07,51 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,51 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,51 say " ³ ~~~            ÚÄ¿ ³"
@ 04,51 say " ³                ÀÄÙ ³"
@ 05,51 say " ³      ~~~~~~~       ³"
@ 06,51 say " ³      ~~~~~~~       ³"
@ 07,51 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,52 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,52 say " ³ ~~~            ÚÄ¿ ³"
@ 04,52 say " ³                ÀÄÙ ³"
@ 05,52 say " ³      ~~~~~~~       ³"
@ 06,52 say " ³      ~~~~~~~       ³"
@ 07,52 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,53 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,53 say " ³ ~~~            ÚÄ¿ ³"
@ 04,53 say " ³                ÀÄÙ ³"
@ 05,53 say " ³      ~~~~~~~       ³"
@ 06,53 say " ³      ~~~~~~~       ³"
@ 07,53 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,54 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,54 say " ³ ~~~            ÚÄ¿ ³"
@ 04,54 say " ³                ÀÄÙ ³"
@ 05,54 say " ³      ~~~~~~~       ³"
@ 06,54 say " ³      ~~~~~~~       ³"
@ 07,54 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

@ 02,55 say " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 03,55 say " ³ ~~~            ÚÄ¿ ³"
@ 04,55 say " ³                ÀÄÙ ³"
@ 05,55 say " ³      ~~~~~~~       ³"
@ 06,55 say " ³      ~~~~~~~       ³"
@ 07,55 say " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "³      ~~~~~~~       ³"
@ 09,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "³      ~~~~~~~       ³"
@ 09,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "³      ~~~~~~~       ³"
@ 09,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "³      ~~~~~~~       ³"
@ 09,02 say "³      ~~~~~~~       ³"
@ 10,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "³      ~~~~~~~       ³"
@ 09,29 say "³      ~~~~~~~       ³"
@ 10,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "³      ~~~~~~~       ³"
@ 09,56 say "³      ~~~~~~~       ³"
@ 10,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "³                ÀÄÙ ³"
@ 09,02 say "³      ~~~~~~~       ³"
@ 10,02 say "³      ~~~~~~~       ³"
@ 11,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "³                ÀÄÙ ³"
@ 09,29 say "³      ~~~~~~~       ³"
@ 10,29 say "³      ~~~~~~~       ³"
@ 11,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "³                ÀÄÙ ³"
@ 09,56 say "³      ~~~~~~~       ³"
@ 10,56 say "³      ~~~~~~~       ³"
@ 11,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "³ ~~~            ÚÄ¿ ³"
@ 09,02 say "³                ÀÄÙ ³"
@ 10,02 say "³      ~~~~~~~       ³"
@ 11,02 say "³      ~~~~~~~       ³"
@ 12,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "³ ~~~            ÚÄ¿ ³"
@ 09,29 say "³                ÀÄÙ ³"
@ 10,29 say "³      ~~~~~~~       ³"
@ 11,29 say "³      ~~~~~~~       ³"
@ 12,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "³ ~~~            ÚÄ¿ ³"
@ 09,56 say "³                ÀÄÙ ³"
@ 10,56 say "³      ~~~~~~~       ³"
@ 11,56 say "³      ~~~~~~~       ³"
@ 11,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 09,02 say "³ ~~~            ÚÄ¿ ³"
@ 10,02 say "³                ÀÄÙ ³"
@ 11,02 say "³      ~~~~~~~       ³"
@ 12,02 say "³      ~~~~~~~       ³"
@ 13,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 09,29 say "³ ~~~            ÚÄ¿ ³"
@ 10,29 say "³                ÀÄÙ ³"
@ 11,29 say "³      ~~~~~~~       ³"
@ 12,29 say "³      ~~~~~~~       ³"
@ 13,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 09,56 say "³ ~~~            ÚÄ¿ ³"
@ 10,56 say "³                ÀÄÙ ³"
@ 11,56 say "³      ~~~~~~~       ³"
@ 12,56 say "³      ~~~~~~~       ³"
@ 13,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 08,02 say "                      "
@ 09,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 10,02 say "³ ~~~            ÚÄ¿ ³"
@ 11,02 say "³                ÀÄÙ ³"
@ 12,02 say "³      ~~~~~~~       ³"
@ 13,02 say "³      ~~~~~~~       ³"
@ 14,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 08,29 say "                      "
@ 09,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 10,29 say "³ ~~~            ÚÄ¿ ³"
@ 11,29 say "³                ÀÄÙ ³"
@ 12,29 say "³      ~~~~~~~       ³"
@ 13,29 say "³      ~~~~~~~       ³"
@ 14,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 08,56 say "                      "
@ 09,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 10,56 say "³ ~~~            ÚÄ¿ ³"
@ 11,56 say "³                ÀÄÙ ³"
@ 12,56 say "³      ~~~~~~~       ³"
@ 13,56 say "³      ~~~~~~~       ³"
@ 14,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 09,02 say "                      "
@ 10,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 11,02 say "³ ~~~            ÚÄ¿ ³"
@ 12,02 say "³                ÀÄÙ ³"
@ 13,02 say "³      ~~~~~~~       ³"
@ 14,02 say "³      ~~~~~~~       ³"
@ 15,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 09,29 say "                      "
@ 10,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 11,29 say "³ ~~~            ÚÄ¿ ³"
@ 12,29 say "³                ÀÄÙ ³"
@ 13,29 say "³      ~~~~~~~       ³"
@ 14,29 say "³      ~~~~~~~       ³"
@ 15,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 09,56 say "                      "
@ 10,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 11,56 say "³ ~~~            ÚÄ¿ ³"
@ 12,56 say "³                ÀÄÙ ³"
@ 13,56 say "³      ~~~~~~~       ³"
@ 14,56 say "³      ~~~~~~~       ³"
@ 15,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 10,02 say "                      "
@ 11,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 12,02 say "³ ~~~            ÚÄ¿ ³"
@ 13,02 say "³                ÀÄÙ ³"
@ 14,02 say "³      ~~~~~~~       ³"
@ 15,02 say "³      ~~~~~~~       ³"
@ 16,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 10,29 say "                      "
@ 11,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 12,29 say "³ ~~~            ÚÄ¿ ³"
@ 13,29 say "³                ÀÄÙ ³"
@ 14,29 say "³      ~~~~~~~       ³"
@ 15,29 say "³      ~~~~~~~       ³"
@ 16,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 10,56 say "                      "
@ 11,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 12,56 say "³ ~~~            ÚÄ¿ ³"
@ 13,56 say "³                ÀÄÙ ³"
@ 14,56 say "³      ~~~~~~~       ³"
@ 15,56 say "³      ~~~~~~~       ³"
@ 16,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 11,02 say "                      "
@ 12,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 13,02 say "³ ~~~            ÚÄ¿ ³"
@ 14,02 say "³                ÀÄÙ ³"
@ 15,02 say "³      ~~~~~~~       ³"
@ 16,02 say "³      ~~~~~~~       ³"
@ 17,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 11,29 say "                      "
@ 12,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 13,29 say "³ ~~~            ÚÄ¿ ³"
@ 14,29 say "³                ÀÄÙ ³"
@ 15,29 say "³      ~~~~~~~       ³"
@ 16,29 say "³      ~~~~~~~       ³"
@ 17,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 11,56 say "                      "
@ 12,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 13,56 say "³ ~~~            ÚÄ¿ ³"
@ 14,56 say "³                ÀÄÙ ³"
@ 15,56 say "³      ~~~~~~~       ³"
@ 16,56 say "³      ~~~~~~~       ³"
@ 17,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 12,02 say "                      "
@ 13,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 14,02 say "³ ~~~            ÚÄ¿ ³"
@ 15,02 say "³                ÀÄÙ ³"
@ 16,02 say "³      ~~~~~~~       ³"
@ 17,02 say "³      ~~~~~~~       ³"
@ 18,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 12,29 say "                      "
@ 13,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 14,29 say "³ ~~~            ÚÄ¿ ³"
@ 15,29 say "³                ÀÄÙ ³"
@ 16,29 say "³      ~~~~~~~       ³"
@ 17,29 say "³      ~~~~~~~       ³"
@ 18,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 12,56 say "                      "
@ 13,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 14,56 say "³ ~~~            ÚÄ¿ ³"
@ 15,56 say "³                ÀÄÙ ³"
@ 16,56 say "³      ~~~~~~~       ³"
@ 17,56 say "³      ~~~~~~~       ³"
@ 18,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 13,02 say "                      "
@ 14,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 15,02 say "³ ~~~            ÚÄ¿ ³"
@ 16,02 say "³                ÀÄÙ ³"
@ 17,02 say "³      ~~~~~~~       ³"
@ 18,02 say "³      ~~~~~~~       ³"
@ 19,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 13,29 say "                      "
@ 14,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 15,29 say "³ ~~~            ÚÄ¿ ³"
@ 16,29 say "³                ÀÄÙ ³"
@ 17,29 say "³      ~~~~~~~       ³"
@ 18,29 say "³      ~~~~~~~       ³"
@ 19,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 13,56 say "                      "
@ 14,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 15,56 say "³ ~~~            ÚÄ¿ ³"
@ 16,56 say "³                ÀÄÙ ³"
@ 17,56 say "³      ~~~~~~~       ³"
@ 18,56 say "³      ~~~~~~~       ³"
@ 19,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 14,02 say "                      "
@ 15,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 16,02 say "³ ~~~            ÚÄ¿ ³"
@ 17,02 say "³                ÀÄÙ ³"
@ 18,02 say "³      ~~~~~~~       ³"
@ 19,02 say "³      ~~~~~~~       ³"
@ 20,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 14,29 say "                      "
@ 15,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 16,29 say "³ ~~~            ÚÄ¿ ³"
@ 17,29 say "³                ÀÄÙ ³"
@ 18,29 say "³      ~~~~~~~       ³"
@ 19,29 say "³      ~~~~~~~       ³"
@ 20,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 14,56 say "                      "
@ 15,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 16,56 say "³ ~~~            ÚÄ¿ ³"
@ 17,56 say "³                ÀÄÙ ³"
@ 18,56 say "³      ~~~~~~~       ³"
@ 19,56 say "³      ~~~~~~~       ³"
@ 20,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 15,02 say "                      "
@ 16,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 17,02 say "³ ~~~            ÚÄ¿ ³"
@ 18,02 say "³                ÀÄÙ ³"
@ 19,02 say "³      ~~~~~~~       ³"
@ 20,02 say "³      ~~~~~~~       ³"
@ 21,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 15,29 say "                      "
@ 16,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 17,29 say "³ ~~~            ÚÄ¿ ³"
@ 18,29 say "³                ÀÄÙ ³"
@ 19,29 say "³      ~~~~~~~       ³"
@ 20,29 say "³      ~~~~~~~       ³"
@ 21,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 15,56 say "                      "
@ 16,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 17,56 say "³ ~~~            ÚÄ¿ ³"
@ 18,56 say "³                ÀÄÙ ³"
@ 19,56 say "³      ~~~~~~~       ³"
@ 20,56 say "³      ~~~~~~~       ³"
@ 21,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 16,02 say "                      "
@ 17,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 18,02 say "³ ~~~            ÚÄ¿ ³"
@ 19,02 say "³                ÀÄÙ ³"
@ 20,02 say "³      ~~~~~~~       ³"
@ 21,02 say "³      ~~~~~~~       ³"
@ 22,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 16,29 say "                      "
@ 17,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 18,29 say "³ ~~~            ÚÄ¿ ³"
@ 19,29 say "³                ÀÄÙ ³"
@ 20,29 say "³      ~~~~~~~       ³"
@ 21,29 say "³      ~~~~~~~       ³"
@ 22,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 16,56 say "                      "
@ 17,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 18,56 say "³ ~~~            ÚÄ¿ ³"
@ 19,56 say "³                ÀÄÙ ³"
@ 20,56 say "³      ~~~~~~~       ³"
@ 21,56 say "³      ~~~~~~~       ³"
@ 22,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

store 1 to PAUSE
do while PAUSE < 15
	store PAUSE + 1 to PAUSE
enddo

if COLOR_SCRN
	set color to r+/n
else
	set color to w+/n
endif

@ 17,02 say "                      "
@ 18,02 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 19,02 say "³ ~~~            ÚÄ¿ ³"
@ 20,02 say "³                ÀÄÙ ³"
@ 21,02 say "³      ~~~~~~~       ³"
@ 22,02 say "³      ~~~~~~~       ³"
@ 23,02 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

set color to w+/n

@ 17,29 say "                      "
@ 18,29 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 19,29 say "³ ~~~            ÚÄ¿ ³"
@ 20,29 say "³                ÀÄÙ ³"
@ 21,29 say "³      ~~~~~~~       ³"
@ 22,29 say "³      ~~~~~~~       ³"
@ 23,29 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to b+/n
else
	set color to w+/n
endif

@ 17,56 say "                      "
@ 18,56 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 19,56 say "³ ~~~            ÚÄ¿ ³"
@ 20,56 say "³                ÀÄÙ ³"
@ 21,56 say "³      ~~~~~~~       ³"
@ 22,56 say "³      ~~~~~~~       ³"
@ 23,56 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

if COLOR_SCRN
	set color to r/n,w+/n,n,n
else
	set color to w/n,w+/n,n,n
endif

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "t"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "nt"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "ent"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "gent"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "igent"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "ligent"
@ 10,78 say "M"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "lligent"
@ 10,77 say "Ma"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "elligent"
@ 10,76 say "Mai"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "telligent"
@ 10,75 say "Mail"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "ntelligent"
@ 10,74 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say "Intelligent"
@ 10,73 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,1 say " Intelligent"
@ 10,72 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,2 say " Intelligent"
@ 10,71 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,3 say " Intelligent"
@ 10,70 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,4 say " Intelligent"
@ 10,69 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,5 say " Intelligent"
@ 10,68 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,6 say " Intelligent"
@ 10,67 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,7 say " Intelligent"
@ 10,66 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,8 say " Intelligent"
@ 10,65 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,9 say " Intelligent"
@ 10,64 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,10 say " Intelligent"
@ 10,63 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,11 say " Intelligent"
@ 10,62 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,12 say " Intelligent"
@ 10,61 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,13 say " Intelligent"
@ 10,60 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,14 say " Intelligent"
@ 10,59 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,15 say " Intelligent"
@ 10,58 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,16 say " Intelligent"
@ 10,57 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,17 say " Intelligent"
@ 10,56 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,18 say " Intelligent"
@ 10,55 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,19 say " Intelligent"
@ 10,54 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,20 say " Intelligent"
@ 10,53 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,21 say " Intelligent"
@ 10,52 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,22 say " Intelligent"
@ 10,51 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,23 say " Intelligent"
@ 10,50 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,24 say " Intelligent"
@ 10,49 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,25 say " Intelligent"
@ 10,48 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,26 say " Intelligent"
@ 10,47 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,27 say " Intelligent"
@ 10,46 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,28 say " Intelligent"
@ 10,45 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,29 say " Intelligent"
@ 10,44 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,30 say " Intelligent"
@ 10,43 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,31 say " Intelligen"
@ 10,42 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,32 say " Intellige"
@ 10,42 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,33 say " Intellig"
@ 10,42 say "Mail "

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

@ 10,34 say " IntelliMail"

store 1 to PAUSE
do while PAUSE < 10
	store PAUSE + 1 to PAUSE
enddo

set color to w+/n
@ 10,35 say "I"

if COLOR_SCRN
	set color to r+/n,w/n,n,n
else
	set color to w/n,w+/n,n,n
endif
@ 10,36 say "ntelli"

set color to w+/n
@ 10,42 say "M"

if COLOR_SCRN
	set color to b+/n,w/n,n,n
else
	set color to w/n,w+/n,n,n
endif
@ 10,43 say "ail"

if COLOR_SCRN
	set color to gr+/n
else
	set color to w/n
endif

@ 13,22 say "The Intelligent Correspondence System"

store 1 to PAUSE
do while PAUSE < 300
	store PAUSE + 1 to PAUSE
enddo
set color to w+/n
@ 16,07 say "(C)opyright 1988,  Personal Touch Software Inc.  All Rights Reserved"

store 1 to PAUSE
do while PAUSE < 3000
	store PAUSE + 1 to PAUSE
enddo

*: EOF: GREET.PRG
