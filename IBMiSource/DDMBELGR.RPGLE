0001002203230002  *****************************************************************************
000200220323      * DDMBELGR   Amwins Connect Administrators                                  *
000300220323      *            WRITTEN BY - R.L.J.                                            *
000400220323      *            DATE - 03/2022                                                 *
000500220323      *  DESCRIPTION - Bld Delta Dental PA Mnthly Elig work file                  *
000600220323      *
0007002203230002  *****************************************************************************
0008002203230015  *  Change Log:                                                              *
000900220323      *  xxx mm/dd/yyyy
001000220323      *                                                                *
0011002203230018 F******************************************************************
0012002203170020 Fddgeligp  IP   E           K DISK
0013002203170020 Fmember    IF   E           K DISK
0014002203170020 Fdelwrkp   IF   E           K DISK
0015002203170020 Fddmeligp  O    E             DISK
001600200317      *
0017001902010250 D                 DS
0018002203170251 D  desubid                1     16
0019002203170251 D    sub13                1      3
0020002203170251 D    sub45                4      5
0021002203170251 D    sub69                6      9
0022002203170251 D    ssnn9                1      9  0
002300220317      *
0024002203170250 D                 DS
0025002203170251 D  dwessn                 1     11
0026002203170251 D    ssn13                1      3
0027002203170251 D    ssnd1                4      4    INZ('-')
0028002203170251 D    ssn45                5      6
0029002203170251 D    ssnd2                7      7    INZ('-')
0030002203170251 D    ssn69                8     11
003100220317      *
0032002203170250 D                 DS
0033002203170251 D  dwgacc                 1     25
0034002203170251 D    gtrst                1      3
0035002203170251 D    gd1                  4      4    INZ('-')
0036002203170251 D    gsub                 5      7
0037002203170251 D    gd2                  8      8    INZ('-')
0038002203170251 D    gacct                9     12
003900200317      *
0040002003200250 D                 DS
0041002203170251 D sq#             S              2  0 INZ(0)
004200220317     D wkdatn          S              8  0
004300220317     D wkdat           S               D
004400220317     D usadt           S               D   DATFMT(*USA/)
004500220317     D dspdt           S             10
004600220317     D svst            S              2
004700200320      *          c
004800020503      ******************************************************************************
004900220317     C     wkkey         klist
005000220317     C                   kfld                    ssnn9
005100220317     C                   kfld                    sq#
005200020517      *      MainLine
005300220317     C                   clear                   ddmeligr
0054002203170297  *
005500220317     C     ssnn9         chain     member                             21
005600220317      *  Format Emp's SSN
005700220317    4C                   eval      ssn13 = sub13
005800220317    4C                   eval      ssn45 = sub45
005900220317    4C                   eval      ssn69 = sub69
006000220317    4C                   eval      dmessn = dwessn
006100220317      *  Format Emp's TSA
006200220317    4C                   movel     mbtrst        gtrst
006300220317    4C                   movel     mbsub#        gsub
006400220317    4C                   movel     mbacct        gacct
006500220317    4C                   movel     dwgacc        dmgacc
006600220317      *
006700220317    4C                   eval      dmgrp# = degrp#
006800220317    4C                   eval      dmdiv# = dediv#
006900220317      *  Format Eff Date
007000220317     C                   if        deeffdt <> *blanks
007100220317     C                   movel     deeffdt       wkdatn
007200220317     C                   movel     wkdatn        wkdat
007300220317     C                   eval      usadt = wkdat
007400220317     C                   movel     usadt         dmeffdt
007500220317     C                   endif
007600220317      *  Format Trm Date
007700220317     C                   if        detrmdt <> *blanks
007800220317     C                   movel     detrmdt       wkdatn
007900220317     C                   movel     wkdatn        wkdat
008000220317     C                   eval      usadt = wkdat
008100220317     C                   movel     usadt         dmtrmdt
008200220317     C                   endif
008300220317      *
008400220317    4C                   movel     demfnam       dmmfnam
008500220317    4C                   movel     demlnam       dmmlnam
008600220317      *  Format DOB
008700220317     C                   if        demdob <> *blanks
008800220317     C                   movel     demdob        wkdatn
008900220317     C                   movel     wkdatn        wkdat
009000220317     C                   eval      usadt = wkdat
009100220317     C                   movel     usadt         dmmdob
009200220317     C                   endif
009300220317      *
009400220317    4C                   movel     desex         dmsex
009500220317      *
009600220317     C                   if        derelc = '10  '
009700220317    4C                   movel     dest          dmst
0098002203170297 C                   eval      svst = dest
009900220317     C                   else
010000220317    4C                   movel     svst          dmst
010100220317    4C                   endif
010200220317      *  Calc Cov Level
010300220317     C     wkkey         chain     delwrkp                            22
010400220317    4C                   if        *IN22 = '0'
010500220317     C                   select
010600220317     C                   when      dwcovt = 'TIN'
0107002203170297 C                   eval      dmcovt = '1'
010800220331     C                   when      dwcovt = 'THW'
0109002203310297 C                   eval      dmcovt = '5'
011000220331     C                   when      dwcovt = 'TPC'
0111002203170297 C                   eval      dmcovt = '6'
011200220317     C                   when      dwcovt = 'TP2'
0113002203170297 C                   eval      dmcovt = '6'
011400220317     C                   when      dwcovt = 'TFA'
0115002203170297 C                   eval      dmcovt = '7'
011600220317     C                   endsl
011700220317      *
011800220317     C                   endif
011900220317      *    Rel Code
012000220317     C                   movel     derelc        dmrelc
0121002003200297  *
0122002203170297 C                   write     ddmeligr
