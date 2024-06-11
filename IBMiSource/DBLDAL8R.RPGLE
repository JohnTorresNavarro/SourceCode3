000100131211      *------------------------------------------------------------------------------------------*
000200100520      * DBLDAL8R   GROUP BENIFIT SERVICES SOFTWARE           2010                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400180705      *            DATE - 05/2010                                                                *
000500100520      *  DESCRIPTION - Load 834 member recs into the all mbr file                               *
000600981030      *------------------------------------------------------------------------------------------*
000700010620      *  Change Log
000800100520      * xxx  mm/dd/yyyy
000900000306      *------------------------------------------------------------------------------------------*
001000100520     Fdelbil8l  IP   E           K DISK
001100030401     Fdelball   UF A E           K DISK
001200231128     Fdel2gxrl  UF A E           K DISK
001300231128      *
001400231128     D                 DS
001500231128     D grpsts                         1A   inz(*blanks)
001600231128      *
001700231128     D                 DS
001800231128     D dbsufx                  1      2
001900231128     D  dsfx1                  1      1
002000100520     D  dsfx2                  2      2
002100231128      *
002200100520     D                 DS
002300231128     D otsufx                  1      2
002400231128     D  osfx1                  1      1
002500231128     D  osfx2                  2      2
002600231128      *
002700231128     D                 DS
002800231128     D dbdeps                  1      2
002900231128     d  ddep1                  1      1
003000231128     D  ddep2                  2      2
003100231128      *
003200231128     D                 DS
003300231128     D otdeps                  1      2
003400231128     D  odep1                  1      1
003500231128     D  odep2                  2      2
003600231128      *
003700231128     D                 DS
003800231128     D dat834                  1     10
003900231128     D  dat8yy                 1      4
004000100520     D  dat8mm                 5      6
004100100520     D  dat8dd                 7      8
004200100520      *
004300100520     D                 DS
004400100520     D datbil                  1     10
004500100520     D  datbmm                 1      2
004600100520     D  datbs1                 3      3    INZ('/')
004700100520     D  datbdd                 4      5
004800100520     D  datbs2                 6      6    INZ('/')
004900100520     D  datbyy                 7     10
005000100520      *
005100100520     D                 DS
005200100520     D datbal          S             10
005300080718      *
005400050311     Idelbalr       01
005500050311     I              dbgrp                       otgrp
005600101025     I              dbclas                      otclas
005700101025     I              dbsubn                      otsubn
005800101025     I              dbsufx                      otsufx
005900101025     I              dbstts                      otstts
006000101025     I              dbupdt                      otupdt
006100101025     I              dbfil3                      otfil3
006200101025     I              dbclef                      otclef
006300110322     I              dbhrdt                      othrdt
006400110322     I              dbeld1                      oteld1
006500110322     I              dbeld2                      oteld2
006600110322     I              dbeld3                      oteld3
006700100520     I              dbeld4                      oteld4
006800110322     I              dbeffd                      oteffd
006900110322     I              dbmdob                      otmdob
007000110322     I              dbdeps                      otdeps
007100100520     I              dbstef                      otstef
007200100520     I              dbsttm                      otsttm
007300100520     I              dbmdef                      otmdef
007400060327      *
007500030401      *          Member Key
007600080718     C     dmkey         klist
007700080718     C                   kfld                    dbgrp
007800080718     C                   kfld                    dbclas
007900080718     C                   kfld                    dbsubn
008000080718     C                   kfld                    dbsufx
008100050930      *          Group Key
008200050930     C     dgkey         klist
008300080718     C                   kfld                    dbgrp
008400080718     C                   kfld                    dbclas
008500080718     C                   kfld                    planc             1
008600080718      *
008700981030      *    MAINLINE
008800080718      *
008900080718     C                   IF        dbrtyp = '  ' and dbgrp <> *blanks
009000040629      *   Build group Xref records
009100210709     C                   IF        dbelc1 <> ' '
009200210709     C                   movel     dbelc1        planc
009300210709     C     dgkey         chain     del2gxrl                           21
009400210709     C                   IF        *in21 = '0' and dgstat <> 'O'
009500210709      *      If group rec exists and status is complete - delete it
009600210709     C                   delete    del2gxrr
009700210709     C                   endif
009800210709      *
009900210709     C     dgkey         chain     del2gxrl                           21
010000210709     C                   IF        *in21 = '1'
010100210709      *      If group record not there - build it
010200210722     C                   clear                   del2gxrr
010300210709     C                   eval      dggrid = dbgrp
010400210722     C                   eval      dgcsid = dbclas
010500210722     C                   eval      dgplnc = planc
010600210722     C                   eval      dgstat = 'O'
010700210722     C                   movel(P)  'LOAD'        dgoper
010800231106     C                   movel     *date         dgupdt
010900231106     C                   write     del2gxrr
011000231106     C                   endif
011100231106     C                   endif
011200231106      *      Check for Elig cat 2
011300231106     C                   IF        dbelc2 <> ' '
011400231106     C                   movel     dbelc2        planc
011500231106     C     dgkey         chain     del2gxrl                           21
011600231106     C                   IF        *in21 = '0' and dgstat <> 'O'
011700231106      *      If group rec exists and status is complete - delete it
011800231106     C                   delete    del2gxrr
011900231106     C                   endif
012000231106      *
012100091211     C     dgkey         chain     del2gxrl                           21
012200080718     C                   IF        *in21 = '1'
012300040629      *      If group record not there - build it
012400090330     C                   eval      dgplnc = planc
012500100527     C                   eval      dggrid = dbgrp
012600100527     C                   eval      dgcsid = dbclas
012700100527     C                   eval      dgplnc = planc
012800100527     C                   eval      dgstat = 'O'
012900100527     C                   movel(P)  'LOAD'        dgoper
013000100527     C                   movel     *date         dgupdt
013100090330     C                   write     del2gxrr
013200090330     C                   endif
013300090330     C                   endif
013400040629      *      Check for Elig cat 3
013500050311     C                   IF        dbelc3 <> ' '
013600050311     C                   movel     dbelc3        planc
013700050311     C     dgkey         chain     del2gxrl                           21
013800091211     C                   IF        *in21 = '0' and dgstat <> 'O'
013900091211      *      If group rec exists and status is complete - delete it
014000091211     C                   delete    del2gxrr
014100091211     C                   endif
014200091211      *
014300091211     C     dgkey         chain     del2gxrl                           21
014400050311     C                   IF        *in21 = '1'
014500040629      *      If group record not there - build it
014600050311     C                   eval      dgplnc = planc
014700100527     C                   eval      dggrid = dbgrp
014800100527     C                   eval      dgcsid = dbclas
014900100527     C                   eval      dgplnc = planc
015000100527     C                   eval      dgstat = 'O'
015100100527     C                   movel(P)  'LOAD'        dgoper
015200100527     C                   movel     *date         dgupdt
015300050930     C                   write     del2gxrr
015400050930     C                   endif
015500050930     C                   endif
015600040629      *      Check for Elig cat 4
015700040629     C                   IF        dbelc4 <> ' '
015800040629     C                   movel     dbelc4        planc
015900040629     C     dgkey         chain     del2gxrl                           21
016000091211     C                   IF        *in21 = '0' and dgstat <> 'O'
016100091211      *      If group rec exists and status is complete - delete it
016200091211     C                   delete    del2gxrr
016300091211     C                   endif
016400091211      *
016500091211     C     dgkey         chain     del2gxrl                           21
016600040629     C                   IF        *in21 = '1'
016700040629      *      If group record not there - build it
016800040629     C                   eval      dgplnc = planc
016900100527     C                   eval      dggrid = dbgrp
017000100527     C                   eval      dgcsid = dbclas
017100100527     C                   eval      dgplnc = planc
017200100527     C                   eval      dgstat = 'O'
017300100527     C                   movel(P)  'LOAD'        dgoper
017400100527     C                   movel     *date         dgupdt
017500051116     C                   write     del2gxrr
017600051116     C                   endif
017700051116     C                   endif
017800051116      *
017900030401      *             Check for duplicate member
018000030401     C     dmkey         chain     delball                            22
018100080718     C                   IF        *in22 = '1'
018200080718     C                   movel     dbgrp         otgrp
018300080718     C                   movel     dbclas        otclas
018400080718     C                   movel     dbsubn        otsubn
018500100520     C                   movel     '00'          otsufx
018600100520     C                   movel     dsfx1         osfx2
018700100520     C                   movel     '00'          otdeps
018800100520     C                   movel     ddep1         odep2
018900050311     C                   movel     grpsts        otstts
019000180705     C                   movel     *blanks       otfil3
019100180705     C                   movel     *date         otupdt
019200180705      *
019300180705     C                   movel     dbclef        dat834
019400180705     C                   exsr      datrtn
019500180705     C                   movel     datbal        otclef
019600180705      *
019700180705     C                   movel     dbhrdt        dat834
019800180705     C                   exsr      datrtn
019900180705     C                   movel     datbal        othrdt
020000180705      *
020100180705     C                   movel     dbeld1        dat834
020200180705     C                   exsr      datrtn
020300180705     C                   movel     datbal        oteld1
020400180705      *
020500180705     C                   movel     dbeld2        dat834
020600180705     C                   exsr      datrtn
020700180705     C                   movel     datbal        oteld2
020800200226      *
020900200226     C                   movel     dbeld3        dat834
021000200226     C                   exsr      datrtn
021100200226     C                   movel     datbal        oteld3
021200200226      *
021300200226     C                   movel     dbeld4        dat834
021400200226     C                   exsr      datrtn
021500200226     C                   movel     datbal        oteld4
021600171009      *
021700200226     C                   movel     dbeffd        dat834
021800200226     C                   exsr      datrtn
021900200226     C                   movel     datbal        oteffd
022000200226      *
022100200226     C                   movel     dbmdob        dat834
022200171009     C                   exsr      datrtn
022300171009     C                   movel     datbal        otmdob
022400171009      *
022500231114     C                   movel     dbstef        dat834
022600231114     C                   exsr      datrtn
022700231114     C                   movel     datbal        otstef
022800231114      *
022900231114     C                   movel     dbsttm        dat834
023000231114     C                   exsr      datrtn
023100231114     C                   movel     datbal        otsttm
023200231114      *
023300231114     C                   movel     dbmdef        dat834
023400231114     C                   exsr      datrtn
023500231114     C                   movel     datbal        otmdef
023600231114      *
023700231114     C                   write     delbalr
023800231114     C                   endif
023900040629     C                   endif
024000100520      ****************************************************
024100100520      *
024200100520      *   DATRTN - Convert dates
024300100520      *
024400100520      ****************************************************
024500190415     C     datrtn        begsr
024600190415      *
024700190415     C                   if        dat834 = *blanks
024800190415     C                   eval      datbal = *blanks
024900190415     C                   leavesr
025000190415     C                   endif
025100190415      *
025200190415     C                   eval      datbmm = dat8mm
025300190415     C                   eval      datbdd = dat8dd
025400190415     C                   eval      datbyy = dat8yy
025500190415     C                   eval      datbal = datbil
025600190415      *
025700190415     C                   endsr
