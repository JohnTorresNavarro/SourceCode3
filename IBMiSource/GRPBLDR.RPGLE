000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300041001    ? *  Description:  Build Grouper Commission Summary File
000400000000    ? *
000500041001    ? *  (c)Copyright 2004 by Inovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700000000    ? *
000800000000    ? *  History:
000900000000    ? *_________________________________________________________________________
001000041001    ?FACCMST5   IP   E           K DISK
001100991116    ?FSMAN      IF   E           K DISK
001200041001    ?FGRPSUMP   UF A E           K DISK
001300991116    ?
001400991116    ?D                 DS                                                       DB020
001500041001    ?D  svsman                             LIKE(smancd)
001600041001    ?D                                     INZ('   ')
001700041001    ?D  svacct                             LIKE(gsacct)
001800041001    ?D                                     INZ(0)
001900041001    ?D  svemps                             LIKE(gsemps)
002000041001    ?D                                     INZ(0)
002100041001    ?D  svprem                             LIKE(gsprem)
002200041001    ?D                                     INZ(0)
0023000410010250 D                 DS
0024000410010251 D  ISOdate        S               D
0025000410010251 D  ISOnum         S              8  0
002600041004    ?
002700041004    ?Ismanr         01
002800041004    ?I              smancd                      smann
002900041001    ? *
003000041001    ?C                   if        atrmdt = 0 or atrmdt > isonum
003100041001    ?C                   if        svsman <> smancd
003200991116    ? *
003300041001    ?C                   if        svsman <> *blanks
003400041001 002?C     svsman        chain     sman                               21
003500041001    ?C                   if        *in21 = '0'
003600041001    ? *
003700041001 002?C     sgrp          chain     grpsump                            22
003800041004    ?C                   if        *in22 = '0'
003900041001    ? *           Add to existing record totals
004000041001B001?C                   add       svacct        gsacct
004100041001B001?C                   add       svemps        gsemps
004200041001B001?C                   add       svprem        gsprem
004300041001B001?C                   update    grpsumr
004400991116 001? *
004500041001    ?C                   else
004600041001    ? *           Create new record
004700041005B001?C                   clear                   grpsumr
004800041005B001?C                   eval      gsgrp = sgrp
004900041001B001?C                   z-add     svacct        gsacct
005000041001B001?C                   z-add     svemps        gsemps
005100041001B001?C                   z-add     svprem        gsprem
005200041001B001?C                   write     grpsumr
005300041001    ?C                   endif
005400041001    ?C                   endif
005500041001    ?C                   endif
005600041001 001? *           Reset cummulators
005700041001B001?C                   z-add     0             svacct
005800041001B001?C                   z-add     0             svemps
005900041001B001?C                   z-add     0             svprem
006000041004B001?C                   eval      svsman = smancd
006100041001    ?C                   endif
006200041001B001?C                   add       1             svacct
006300041004B001?C                   add       noempl        svemps
006400041001B001?C                   add       apremi        svprem
006500041001    ?C                   endif
006600041001    ? ********************************************************************
006700041001     C     *INZSR        BEGSR
0068000410011304  *         Calculate default action dates
006900041001     C                   move      UDATE         ISOdate
007000041001     C                   move      ISOdate       ISOnum
007100041001     C                   ENDSR
