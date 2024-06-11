000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300041004    ? *  Description:  Build Grouper Commission Summary File from GA
000400000000    ? *
000500041001    ? *  (c)Copyright 2004 by Inovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700000000    ? *
000800000000    ? *  History:
000900000000    ? *_________________________________________________________________________
001000041004    ?FBRKPRDL3  IP   E           K DISK
001100041005    ?FACCMSTP   IF   E           K DISK
001200991116    ?FSMAN      IF   E           K DISK
001300041001    ?FGRPSUMP   UF A E           K DISK
001400991116    ?
001500991116    ?D                 DS                                                       DB020
001600041005    ?D  svsman                             LIKE(bpsman)
001700041001    ?D                                     INZ('   ')
001800041005    ?D  svacct                             LIKE(bpacct)
001900041005    ?D                                     INZ(*blanks)
002000041005    ?D  ctacct                             LIKE(gaacct)
002100041001    ?D                                     INZ(0)
002200041005    ?D  svemps                             LIKE(gaemps)
002300041001    ?D                                     INZ(0)
002400041005    ?D  svprem                             LIKE(gaprem)
002500041001    ?D                                     INZ(0)
0026000410010250 D                 DS
0027000410010251 D  ISOdate        S               D
0028000410010251 D  ISOnum         S              8  0
002900041001    ? *
003000041005    ?C                   if        bptrdt = *HIVAL or bptrdt > isodate
003100041005    ?C                   if        bpsplit = 0 or bpsplit > .5
003200041005    ? *
003300041005    ?C                   if        svacct <> bpacct
003400041005    ? *
003500041005    ?C                   if        svacct <> *blanks
003600041005    ? *
003700041005 002?C     svacct        chain     accmstp                            20
003800041005    ?C                   if        *in20 = '0' and adtrdt = *HIVAL or
003900041005    ?C                             *in20 = '0' and adtrdt > isodate
004000041005    ? *
004100041005    ?C                   if        svsman <> bpsman
004200041005    ? *
004300041001    ?C                   if        svsman <> *blanks
004400041001 002?C     svsman        chain     sman                               21
004500041001    ?C                   if        *in21 = '0'
004600041001    ? *
004700041001 002?C     sgrp          chain     grpsump                            22
004800041004    ?C                   if        *in22 = '0'
004900041001    ? *           Add to existing record totals
005000041005B001?C                   add       ctacct        gaacct
005100041005B001?C                   add       svemps        gaemps
005200041005B001?C                   add       svprem        gaprem
005300041001B001?C                   update    grpsumr
005400991116 001? *
005500041001    ?C                   else
005600041001    ? *           Create new record
005700041005    ?C                   clear                   grpsumr
005800041001B001?C                   eval      gsgrp = sgrp
005900041005B001?C                   z-add     ctacct        gaacct
006000041005B001?C                   z-add     svemps        gaemps
006100041005B001?C                   z-add     svprem        gaprem
006200041001B001?C                   write     grpsumr
006300041001    ?C                   endif
006400041001    ?C                   endif
006500041001    ?C                   endif
006600041001 001? *           Reset cummulators
006700041005B001?C                   z-add     0             ctacct
006800041001B001?C                   z-add     0             svemps
006900041001B001?C                   z-add     0             svprem
007000041005B001?C                   eval      svsman = bpsman
007100041001    ?C                   endif
007200041005B001?C                   add       1             ctacct
007300041005B001?C                   add       adbenr        svemps
007400041005B001?C                   add       adpamt        svprem
007500041001    ?C                   endif
007600041005    ?C                   endif
007700041005    ?C                   eval      svacct = bpacct
007800041005    ?C                   endif
007900041005    ?C                   endif
008000041005    ?C                   endif
008100041001    ? ********************************************************************
008200041001     C     *INZSR        BEGSR
0083000410011304  *         Calculate default action dates
008400041001     C                   move      UDATE         ISOdate
008500041001     C                   move      ISOdate       ISOnum
008600041001     C                   ENDSR
