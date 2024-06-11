000100981030     F*------------------------------------------------------------------------------------------*
000200091124      * DBLD2ALR   GROUP BENIFIT SERVICES SOFTWARE           2009                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400091120      *            DATE - 11/2009                                                                *
000500091120      *  DESCRIPTION - Load DBE 4.5 mbr recs intal the all mbr file                              *
000600981030      *------------------------------------------------------------------------------------------*
000700010620      *  Change Log
000800091120      * xxx  mm/dd/yyyy
000900000306      *------------------------------------------------------------------------------------------*
001000091120     Fdelbil2p  IP   E           K DISK
001100030401     Fdelball   UF A E           K DISK
001200040629     Fdel2gxrl  UF A E           K DISK
001300030401      *
001400080718     D                 DS
001500091120     D d2sufx                  1     10
001600091120     D   sufx1                 1      1
001700091120      *
001800091120     D                 DS
001900091120     D elig2                   1     12
002000091120     D   elc2                  1      1
002100091120     D   eld2                  2     11
002200091120     D   fmi2                 12     12
002300091120      *
002400091120     D                 DS
002500091120     D eligb1                  1     12
002600091120     D   dbelc1                1      1
002700091120     D   dbeld1                2     11
002800091120     D   dbfmi1               12     12
002900091120      *
003000091120     D                 DS
003100091120     D eligb2                  1     12
003200091120     D   dbelc2                1      1
003300091120     D   dbeld2                2     11
003400091120     D   dbfmi2               12     12
003500091120      *
003600091120     D                 DS
003700091120     D eligb3                  1     12
003800091120     D   dbelc3                1      1
003900091120     D   dbeld3                2     11
004000091120     D   dbfmi3               12     12
004100091120      *
004200091120     D                 DS
004300091120     D eligb4                  1     12
004400091120     D   dbelc4                1      1
004500091120     D   dbeld4                2     11
004600091120     D   dbfmi4               12     12
004700091120      *
004800091120     D                 DS
004900091120     D d2date                  1      8
005000091120     D   d2yy                  1      4
005100091120     D   d2mm                  5      6
005200091120     D   d2dd                  7      8
005300091120      *
005400091120     D                 DS
005500091120     D dbdate                  1     10
005600091120     D   dbmm                  1      2
005700091120     D   dbsl1                 3      3    INZ('/')
005800091120     D   dbdd                  4      5
005900091120     D   dbsl2                 6      6    INZ('/')
006000091120     D   dbyy                  7     10
006100091120      *
006200091120     D                 DS
006300091120     D grpsts                         1A   inz(*blanks)
006400091120     D effdt                         10
006500080718      *
006600030401      *          Member Key
006700080718     C     dmkey         klist
006800080718     C                   kfld                    dbgrp
006900080718     C                   kfld                    dbclas
007000080718     C                   kfld                    dbsubn
007100080718     C                   kfld                    dbsufx
007200050930      *          Group Key
007300050930     C     dgkey         klist
007400080718     C                   kfld                    dbgrp
007500080718     C                   kfld                    dbclas
007600080718     C                   kfld                    planc             1
007700080718      *
007800981030      *    MAINLINE
007900040629      *   Build group Xref records
008000091120      *      Medical Xref record
008100091120     C                   if        d2medf <> ' '
008200091120     C                   movel     d2grp         dbgrp
008300091120     C                   movel     d2clas        dbclas
008400091120     C                   movel     'M'           planc
008500080722     C     dgkey         chain     del2gxrl                           21
008600091211     C                   IF        *in21 = '0' and dgstat <> 'O'
008700091211      *      If group rec exists and status is complete - delete it
008800091211     C                   delete    del2gxrr
008900091211     C                   endif
009000091211      *
009100091211     C     dgkey         chain     del2gxrl                           21
009200080722     C                   IF        *in21 = '1'
009300090330      *      If group record not there - build it
009400090330     C                   clear                   del2gxrr
009500090330     C                   eval      dggrid = dbgrp
009600090330     C                   eval      dgcsid = dbclas
009700090330     C                   eval      dgplnc = planc
009800090330     C                   eval      dgstat = 'O'
009900090330     C                   movel(P)  'LOAD'        dgoper
010000080718     C                   movel     *date         dgupdt
010100080718     C                   write     del2gxrr
010200080718     C                   endif
010300080718     C                   endif
010400091120      *      Drug Xref record
010500091120     C                   if        d2drgf <> ' '
010600091120     C                   movel     d2grp         dbgrp
010700091120     C                   movel     d2clas        dbclas
010800091120     C                   movel     'R'           planc
010900091120     C     dgkey         chain     del2gxrl                           21
011000091211     C                   IF        *in21 = '0' and dgstat <> 'O'
011100091211      *      If group rec exists and status is complete - delete it
011200091211     C                   delete    del2gxrr
011300091211     C                   endif
011400091211      *
011500091211     C     dgkey         chain     del2gxrl                           21
011600091120     C                   IF        *in21 = '1'
011700091120      *      If group record not there - build it
011800091120     C                   clear                   del2gxrr
011900091120     C                   eval      dggrid = dbgrp
012000091120     C                   eval      dgcsid = dbclas
012100091120     C                   eval      dgplnc = planc
012200091120     C                   eval      dgstat = 'O'
012300091120     C                   movel(P)  'LOAD'        dgoper
012400091120     C                   movel     *date         dgupdt
012500091120     C                   write     del2gxrr
012600091120     C                   endif
012700091120     C                   endif
012800091120      *      Dental Xref record
012900091120     C                   if        d2dntf <> ' '
013000091120     C                   movel     d2grp         dbgrp
013100100113     C                   movel     d2clas        dbclas
013200100113     C                   movel     'D'           planc
013300091120     C     dgkey         chain     del2gxrl                           21
013400100113     C                   IF        *in21 = '0' and dgstat <> 'O'
013500100113      *      If group rec exists and status is complete - delete it
013600100113     C                   delete    del2gxrr
013700100113     C                   endif
013800100113      *
013900100113     C     dgkey         chain     del2gxrl                           21
014000100113     C                   IF        *in21 = '1'
014100091120      *      If group record not there - build it
014200100113     C                   clear                   del2gxrr
014300100113     C                   eval      dggrid = dbgrp
014400100113     C                   eval      dgcsid = dbclas
014500100113     C                   eval      dgplnc = planc
014600091120     C                   eval      dgstat = 'O'
014700091120     C                   movel(P)  'LOAD'        dgoper
014800091120     C                   movel     *date         dgupdt
014900091120     C                   write     del2gxrr
015000091120     C                   endif
015100091120     C                   endif
015200091120      *      Vision Xref record
015300091120     C                   if        d2visf <> ' '
015400091120     C                   movel     d2grp         dbgrp
015500091120     C                   movel     d2clas        dbclas
015600091120     C                   movel     'V'           planc
015700091120     C     dgkey         chain     del2gxrl                           21
015800091211     C                   IF        *in21 = '0' and dgstat <> 'O'
015900091211      *      If group rec exists and status is complete - delete it
016000091211     C                   delete    del2gxrr
016100091211     C                   endif
016200091211      *
016300091211     C     dgkey         chain     del2gxrl                           21
016400091120     C                   IF        *in21 = '1'
016500091120      *      If group record not there - build it
016600091120     C                   clear                   del2gxrr
016700091120     C                   eval      dggrid = dbgrp
016800091120     C                   eval      dgcsid = dbclas
016900091120     C                   eval      dgplnc = planc
017000091120     C                   eval      dgstat = 'O'
017100091120     C                   movel(P)  'LOAD'        dgoper
017200091120     C                   movel     *date         dgupdt
017300091120     C                   write     del2gxrr
017400091120     C                   endif
017500091120     C                   endif
017600051116      *
017700030401      *             Check for duplicate member
017800091120     C                   movel     d2grp         dbgrp
017900091120     C                   movel     d2clas        dbclas
018000091120     C                   movel     d2subn        dbsubn
018100091120     C                   movel     '00'          dbsufx
018200091120     C                   move      sufx1         dbsufx
018300030401     C     dmkey         chain     delball                            22
018400080718     C                   IF        *in22 = '1'
018500091120     C                   movel     d2sgrp        dbsgrp
018600091120     C                   movel     d2clef        d2date
018700091120     C                   movel     d2mm          dbmm
018800091120     C                   movel     d2dd          dbdd
018900091120     C                   movel     d2yy          dbyy
019000091120     C                   movel     dbdate        dbclef
019100091120     C                   movel     dbclef        effdt
019200091120      *
019300091120     C                   movel     d2hrdt        d2date
019400091120     C                   movel     d2mm          dbmm
019500091120     C                   movel     d2dd          dbdd
019600091120     C                   movel     d2yy          dbyy
019700091120     C                   movel     dbdate        dbhrdt
019800091120      *
019900091120     C                   movel     *date         dbupdt
020000091120     C                   movel     *blanks       eligb1
020100091120     C                   movel     *blanks       eligb2
020200091120     C                   movel     *blanks       eligb3
020300091120     C                   movel     *blanks       eligb4
020400091120      *
020500091120     C                   if        d2medf <> ' '
020600091120     C                   movel     'M'           dbelc1
020700091120     C                   movel     effdt         dbeld1
020800091120     C                   movel     d2medf        dbfmi1
020900091120     C                   endif
021000091120      *
021100091120     C                   if        d2drgf <> ' '
021200091120     C                   movel     'R'           elc2
021300091120     C                   movel     effdt         eld2
021400091120     C                   movel     d2drgf        fmi2
021500091120     C                   if        dbelc1 = ' '
021600091120     C                   movel     elig2         eligb1
021700091120     C                   else
021800091120     C                   movel     elig2         eligb2
021900091120     C                   endif
022000091120     C                   endif
022100091120      *
022200091120     C                   if        d2dntf <> ' '
022300091120     C                   movel     'D'           elc2
022400091120     C                   movel     effdt         eld2
022500091120     C                   movel     d2dntf        fmi2
022600091120     C                   if        dbelc1 = ' '
022700091120     C                   movel     elig2         eligb1
022800091120     C                   else
022900091120     C                   if        dbelc2 = ' '
023000091120     C                   movel     elig2         eligb2
023100091120     C                   else
023200091120     C                   movel     elig2         eligb3
023300091120     C                   endif
023400091120     C                   endif
023500091120     C                   endif
023600091120      *
023700091120     C                   if        d2visf <> ' '
023800091120     C                   movel     'V'           elc2
023900091120     C                   movel     effdt         eld2
024000091120     C                   movel     d2visf        fmi2
024100091120     C                   if        dbelc1 = ' '
024200091120     C                   movel     elig2         eligb1
024300091120     C                   else
024400091120     C                   if        dbelc2 = ' '
024500091120     C                   movel     elig2         eligb2
024600091120     C                   else
024700091120     C                   if        dbelc3 = ' '
024800091120     C                   movel     elig2         eligb3
024900091120     C                   else
025000091120     C                   movel     elig2         eligb4
025100091120     C                   endif
025200091120     C                   endif
025300091120     C                   endif
025400091120     C                   endif
025500091120      *
025600091120     C                   movel     d2add1        dbadd1
025700091120     C                   movel     d2add2        dbadd2
025800091120     C                   movel     d2add3        dbadd3
025900091120     C                   movel     d2city        dbcity
026000091120     C                   movel     d2stat        dbstat
026100091120     C                   movel     d2zip         dbzip
026200091120     C                   movel     d2hphn        dbhphn
026300091120     C                   movel     d2rtmd        dbratm
026400091120     C                   movel     d2relc        dbrelc
026500091120     C                   movel     d2lnam        dblnam
026600091120     C                   movel     d2fnam        dbfnam
026700091120     C                   movel     d2midi        dbmidi
026800091120     C                   movel     d2mssn        dbmssn
026900091120     C                   movel     d2sex         dbsex
027000091120      *
027100091120     C                   movel     d2mdob        d2date
027200091120     C                   movel     d2mm          dbmm
027300091120     C                   movel     d2dd          dbdd
027400091120     C                   movel     d2yy          dbyy
027500091120     C                   movel     dbdate        dbmdob
027600091120      *
027700091120     C                   movel     d2msts        dbmsts
027800091120      *
027900091120     C                   movel     d2sttp        dbsttp
028000091120     C                   movel     d2scnm        dbscnm
028100091120     C                   movel     d2sttp        dbsttp
028200091120     C                   movel     d2stef        dbstef
028300091120     C                   movel     d2sttm        dbsttm
028400091120     C                   movel     d2sttr        dbsttr
028500091120      *
028600091120     C                   movel     d2hdef        d2date
028700091120     C                   movel     d2mm          dbmm
028800091120     C                   movel     d2dd          dbdd
028900091120     C                   movel     d2yy          dbyy
029000091120     C                   movel     dbdate        dbhdef
029100091120      *
029200091120     C                   movel     d2hdtm        d2date
029300091120     C                   movel     d2mm          dbmm
029400091120     C                   movel     d2dd          dbdd
029500091120     C                   movel     d2yy          dbyy
029600091120     C                   movel     dbdate        dbhdtm
029700091120      *
029800091120     C                   movel     d2hdtp        dbhdtp
029900091120     C                   movel     d2hdds        dbhdds
030000091120      *
030100091120     C                   movel     d2mdc#        dbmdc#
030200091120      *
030300091120     C                   movel     d2mdef        d2date
030400091120     C                   movel     d2mm          dbmm
030500091120     C                   movel     d2dd          dbdd
030600091120     C                   movel     d2yy          dbyy
030700091120     C                   movel     dbdate        dbmdef
030800091120      *
030900091120     C                   movel     d2mdtm        d2date
031000091120     C                   movel     d2mm          dbmm
031100091120     C                   movel     d2dd          dbdd
031200091120     C                   movel     d2yy          dbyy
031300091120     C                   movel     dbdate        dbmdtm
031400091120      *
031500091120     C                   movel     d2prov        dbprov
031600091120     C                   movel     d2pref        dbpref
031700091120     C                   movel     d2prnm        dbprnm
031800091120      *
031900091120     C                   movel     grpsts        dbstts
032000091120     C                   movel     *blanks       dbfil3
032100091120     C                   movel     *date         dbupdt
032200091120      *
032300091120     C                   movel     '4.5'         dbprnt
032400091120      *
032500050311     C                   write     delbalr
032600091120      *
032700040629     C                   endif
