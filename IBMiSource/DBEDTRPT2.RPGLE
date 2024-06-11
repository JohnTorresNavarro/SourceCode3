0001000302260002  ******************************************************************
0002000305140003  * DBEDTRPT   GROUP BENEFIT SERVICES SOFTWARE           2003      *
0003000302260007  *                                                                *
0004000302260005  *            WRITTEN BY - R.L.J.                                 *
0005000305140006  *            DATE - 05/14/2003                                   *
0006000302260007  *                                                                *
0007000305140006  *  DESCRIPTION - THIS PROGRAM WILL PROVIDE A REPORT OF ISSUES    *
0008000302260008  *                                                                *
000900140410      *  CHANGES: rlj 04/10/2014 Check for invalid DOH dates           *
001000140923      *  CHANGES: rlj 09/23/2014 Check for ACCMST cover thru date      *
001100190827      *  CHANGES: rlj 08/27/2019 Use SSN for Mbr, never Sub# unless    *
001200190827      *                          SSN is blank.                         *
0013000302260009  ******************************************************************
0014000302260010  *                                                                *
001500021218     Fdelbill   IP   E           K DISK
001600040720     Fdel2gxrl  IF   E           K DISK
001700940921     FACCMST    IF   E           K DISK
001800030514     FMEMBER    IF   E           K DISK
001900030522     Fdelexcp   O    E             DISK
002000021203      *
002100021203     D                 DS
002200021203     D svgrp                               like(dbgrp)
002300021218     D svclas                              like(dbclas)
002400050527      *       Account Info
002500050527     D  trst                               like(dgtrst)
002600050527     D  sub#                               like(dgsub#)
002700050527     D  acct                               like(dgacct)
002800021218      *       Medical Info
002900021218     D mtrst                               like(dgtrst)
003000021218     D msub#                               like(dgsub#)
003100021218     D macct                               like(dgacct)
003200021219     D mplan                               like(dgplan)
003300021218     D mstat                               like(dgstat)
003400021218      *       Drug Info
003500021218     D rtrst                               like(dgtrst)
003600021218     D rsub#                               like(dgsub#)
003700021218     D racct                               like(dgacct)
003800021219     D rplan                               like(dgplan)
003900021218     D rstat                               like(dgstat)
004000021218      *       Dental Info
004100021218     D dtrst                               like(dgtrst)
004200021218     D dsub#                               like(dgsub#)
004300021218     D dacct                               like(dgacct)
004400021219     D dplan                               like(dgplan)
004500021218     D dstat                               like(dgstat)
004600021218      *       Vision Info
004700021218     D vtrst                               like(dgtrst)
004800021218     D vsub#                               like(dgsub#)
004900021218     D vacct                               like(dgacct)
005000021219     D vplan                               like(dgplan)
005100021218     D vstat                               like(dgstat)
005200021218      *
005300981022     D                 DS
005400021203     D  todate                         D   DATFMT(*ISO)
005500021219     D  updtm                         1
005600021219     D  excnc                         1
005700021219     D  mbrstat                       3
005800030226     D  mbradd                        1
005900030331     D  mbrupd                        1
006000021203      *
006100021203     D                 DS
006200021203     D  uprqs                         8
006300021203     D  uprtn                         8
006400021203     D  upstr                       256
006500021203      *
006600021203     D                 DS
006700021203     D  dbsufx                 1      2
006800021203     D   sufxn                 1      2  0
006900021203      *
007000021203     D                 DS
007100021203     D  phone#                 1     20
007200021203     D   phn10                 1     10
007300021203     D   darea                 1      3  0
007400021203     D   dphn                  4     10  0
007500021219      *
007600021219     D                 DS
007700021219     D  zip9                   1      9
007800021219     D   zip9n                 1      9  0
007900021220     D  zip5                   1      5
008000021220     D   zip5n                 1      5  0
008100021220     D   zip4n                 6      9  0
008200021220     D  zip9nc                10     18  0
008300021220     D   zip5nc               10     14  0
008400021203      *
008500021203     D                 DS
008600021203     D  dbdate                 1     10
008700021203     D   dbmm                  1      2  0
008800021203     D   dbdd                  4      5  0
008900021203     D   dbyy                  7     10  0
009000021203      *
009100021203     D                 DS
009200021203     D  gbdate                 1      8  0
009300140923     D   gbyymm                1      6  0
009400140923     D   gbyy                  1      4  0
009500021203     D   gbmm                  5      6  0
009600021203     D   gbdd                  7      8  0
009700030116      *
009800140923     D                 DS
009900150408     D  acvtdt                 1      8  0
010000140923     D   acyymm                1      6  0
010100140923      *
010200030116     D                 DS
010300030116     D  gbdatx         S               D
010400021203      *
010500021203     D                 DS
010600021203     D  inrec                  1    149
010700021203     D   dblnam                1     35
010800021219     D    dblnm18              1     18
010900140415     D   dbfnam               36     60
011000021219     D    dbfnm12             36     47
011100140415     D   dbadd1               61    100
011200140415     D    dbad130             61     90
011300140415     D   dbadd2              101    140
011400140415     D    dbad230            101    130
011500140415     D   dbcity              141    159
011600140415     D    dbcty15            141    155
011700021203      *
011800000103     D                 DS
011900021203     D  dbsubn                 1      9
012000050601     D   dbsub2                1      2
012100050601      *
012200050601     D                 DS
012300050601     D  suba                   1      9
012400050601     D  subn                   1      9  0
012500021203      *
012600021203     D                 DS
012700021203     D  dbdeps                 1      2
012800021203     D   ndeps                 1      2  0
012900021203     D                 DS
013000021203     D  gtsa                   1     10  0
013100021203     D  gtst#                  1      3  0
013200000103     D  gsub#                  4      6  0
013300000103     D  gact#                  7     10  0
013400000103     D                 DS
013500000103     D  mtsa                   1     10  0
013600000103     D  mbtrst                 1      3  0
013700000103     D  mbsub#                 4      6  0
013800000103     D  mbacct                 7     10  0
0139000212030053 D                 DS
0140001306040054 D  nossn          C                   'Blank SSN in Member rec - FATAL  '
0141001306040054 D  nocov          C                   'NOCOV - NO COVERAGE SELECTED     '
0142001402100054 D  nohir          C                   'NOHIR - NO HIRE DATE FOR MEMBER! '
0143001404100054 D  inhir          C                   'INHIR - INVALID HIRE DT FOR MEMBER'
0144000301020054 D  noxrf          C                   'NOXRF - NO GRP/PLN XREF FOR GROUP'
0145000212190054 D  actrm          C                   'MEMBER ACCT ALREADY TERMED       '
0146001409230054 D  actcv          C                   'ACCT COVER THRU DATE ERROR       '
0147000212190054 D  mterm          C                   'MEMBER RECORD EXISTS AS TERMED   '
0148000212190054 D  tsaer          C                   'NEW T,S,A DIFFERS FROM MBR REC  '
0149000302260054 D  invel          C                   'INVEL - INV ELIG TYPE - NOT EL/CH'
0150000212030054 D  mbrex          C                   'MBREX - MEMBER RECORD EXISTS     '
0151000212030054 D  msmbra         C                   'Member Add From DB Conversion    '
0152000212030054 D  msmcva         C                   'Coverage Add From DB Convertn    '
015300030318      *
015400030318      * Group/Plan Xref key
015500030318     C     GXFKEY        KLIST
015600040715     C                   kfld                    kxgrp             8
015700030318     C                   kfld                    kxcls             4
015800030318     C                   kfld                    kxplc             1
015900021203      *
016000021219      * Acct Mst key
016100021219     C     acckey        KLIST
016200050527     C                   kfld                    trst
016300050527     C                   kfld                    sub#
016400050527     C                   kfld                    acct
016500021219      *
016600021219      ******************************************************************
016700021218      *  Main Line
016800030103      *
016900030312     C                   if        dbrtyp = *blanks and dbgrp <> *blanks
017000021218      *      Check for invalid Event type
017100030226     C                   if        (dbelt1 <> 'SL' and dbelt1 <> '  ' and
017200030226     C                             dbelt1 <> 'CH') or
017300030226     C                             (dbelt2 <> 'SL' and dbelt2 <> '  ' and
017400030226     C                             dbelt2 <> 'CH') or
017500030226     C                             (dbelt3 <> 'SL' and dbelt3 <> '  ' and
017600030226     C                             dbelt3 <> 'CH') or
017700030226     C                             (dbelt4 <> 'SL' and dbelt4 <> '  ' and
017800030226     C                             dbelt4 <> 'CH')
017900021218     C                   eval      dbresn = invel
018000021218     C                   movel     *DATE         dbprdt
018100021218     C                   write     delexcr
018200021218     C                   else
018300021218      *
018400021218     C                   if        dbgrp <> svgrp or dbclas <> svclas
018500021203     C                   eval      svgrp = dbgrp
018600021218     C                   eval      svclas = dbclas
018700030226     C                   eval      mbradd = 'N'
018800021218      *      Set plan info for the 4 plan types
018900021218     C                   exsr      setpln
019000021218      *
019100021203     C                   endif
019200021203      *      Process record
019300021203      *
019400021203     C                   if        dbsufx = '00'
019500021203      *      Process member record
019600021219     C                   eval      mbrstat = *blanks
019700021218     C                   exsr      chkmbr
019800021218      *
019900021219     C                   select
020000030102      *        If no coverages - write exception rec
020100030102     C                   when      mbrstat = 'NCV'
020200030102     C                   eval      dbresn = nocov
020300021219     C                   movel     *DATE         dbprdt
020400021219     C                   write     delexcr
020500140210      *        If no hire date - write exception rec
020600140210     C                   when      mbrstat = 'NHR'
020700140210     C                   eval      dbresn = nohir
020800140210     C                   movel     *DATE         dbprdt
020900140210     C                   write     delexcr
021000140410      *        If hire date is invalid - write exception rec
021100140410     C                   when      mbrstat = 'IHR'
021200140410     C                   eval      dbresn = inhir
021300140410     C                   movel     *DATE         dbprdt
021400140410     C                   write     delexcr
021500030102      *        If no Xref record - write exception rec
021600030102     C                   when      mbrstat = 'NOX'
021700030102     C                   eval      dbresn = noxrf
021800030102     C                   movel     *DATE         dbprdt
021900030102     C                   write     delexcr
022000130604      *        If Mbr Record has blank SSN - exc
022100130604     C                   when      mbrstat = 'NSN'
022200130604     C                   eval      dbresn = nossn
022300130604     C                   movel     *DATE         dbprdt
022400130604     C                   write     delexcr
022500030331      *        If Member rec is termed - exc
022600021219     C                   when      mbrstat = 'TRM'
022700021219     C                   eval      dbresn = mterm
022800021219     C                   movel     *DATE         dbprdt
022900021219     C                   write     delexcr
023000021219      *        If TSA differs - exc
023100021219     C                   when      mbrstat = 'TSA'
023200021219     C                   eval      dbresn = tsaer
023300021219     C                   movel     *DATE         dbprdt
023400021219     C                   write     delexcr
023500021219      *        If Acct termed - exc
023600021219     C                   when      mbrstat = 'ATR'
023700021219     C                   eval      dbresn = actrm
023800021219     C                   movel     *DATE         dbprdt
023900021219     C                   write     delexcr
024000140923      *        If Acct cover thru issue - exc
024100140923     C                   when      mbrstat = 'ACT'
024200140923     C                   eval      dbresn = actcv
024300140923     C                   movel     *DATE         dbprdt
024400140923     C                   write     delexcr
024500021219      *
024600021219     C                   endsl
024700021203      *
024800021203     C                   else
024900021219      *     Process dep record
025000030103      *
025100030522      *        If any status other than New or Add covg - write exc
025200030522     C                   if        mbrstat <> 'NEW' and mbrstat <> 'ADC'
025300021219     C                   write     delexcr
025400021219      *
025500021203     C                   endif
025600021203      *
025700021203     C                   endif
025800021203     C                   endif
025900030522     C                   endif
026000021203      ****************************************************
026100021218      *
026200021218      *    SETPLN - set the plan info for the 4 plan types
026300030226      *             And set the status code to 'C' - complete
026400021218      ****************************************************
026500021218     C     setpln        begsr
026600050527      *
026700050527     C                   eval      trst = 0
026800050527     C                   eval      sub# = 0
026900050527     C                   eval      acct = 0
027000021218      *
027100021218     C                   movel(P)  dbgrp         kxgrp
027200021218     C                   eval      kxcls = dbclas
027300021218     C                   eval      excnc = 'N'
027400021218      *     Get Xref info for 4 plan types
027500021218     C                   eval      kxplc = 'M'
027600040720     C     gxfkey        chain     del2gxrl                           21
027700030402     C                   if        *in21 = '1'
027800021218     C                   eval      mtrst = 0
027900021218     C                   eval      msub# = 0
028000021218     C                   eval      macct = 0
028100021218     C                   eval      mplan = *blanks
028200021218     C                   eval      mstat = *blanks
028300021218     C                   else
028400021218     C                   eval      mtrst = dgtrst
028500021218     C                   eval      msub# = dgsub#
028600021218     C                   eval      macct = dgacct
028700021218     C                   eval      mplan = dgplan
028800021218     C                   eval      mstat = dgstat
028900050527      *
029000050527     C                   eval      trst = dgtrst
029100050527     C                   eval      sub# = dgsub#
029200050527     C                   eval      acct = dgacct
029300021218     C                   endif
029400021218      *
029500021218     C                   eval      kxplc = 'R'
029600040720     C     gxfkey        chain     del2gxrl                           21
029700030402     C                   if        *in21 = '1'
029800021218     C                   eval      rtrst = 0
029900021218     C                   eval      rsub# = 0
030000021218     C                   eval      racct = 0
030100021218     C                   eval      rplan = *blanks
030200021218     C                   eval      rstat = *blanks
030300021218     C                   else
030400131231      *       Check to see if RX is set to I - Ignore
030500131231     C                   if        dgstat = 'I'
030600131231     C                   eval      rtrst = 0
030700131231     C                   eval      rsub# = 0
030800131231     C                   eval      racct = 0
030900131231     C                   eval      rplan = *blanks
031000131231     C                   eval      rstat = dgstat
031100131231     C                   else
031200021218     C                   eval      rtrst = dgtrst
031300021218     C                   eval      rsub# = dgsub#
031400021218     C                   eval      racct = dgacct
031500021218     C                   eval      rplan = dgplan
031600021218     C                   eval      rstat = dgstat
031700131231     C                   endif
031800050527      *
031900050527     C                   if        trst = 0
032000050527     C                   eval      trst = dgtrst
032100050527     C                   eval      sub# = dgsub#
032200050527     C                   eval      acct = dgacct
032300050527     C                   endif
032400021218     C                   endif
032500021218      *
032600021218     C                   eval      kxplc = 'D'
032700040720     C     gxfkey        chain     del2gxrl                           21
032800030402     C                   if        *in21 = '1'
032900021218     C                   eval      dtrst = 0
033000021218     C                   eval      dsub# = 0
033100021218     C                   eval      dacct = 0
033200021218     C                   eval      dplan = *blanks
033300021218     C                   eval      dstat = *blanks
033400021218     C                   else
033500021218     C                   eval      dtrst = dgtrst
033600021218     C                   eval      dsub# = dgsub#
033700021218     C                   eval      dacct = dgacct
033800021218     C                   eval      dplan = dgplan
033900021218     C                   eval      dstat = dgstat
034000050527      *
034100050527     C                   if        trst = 0
034200050527     C                   eval      trst = dgtrst
034300050527     C                   eval      sub# = dgsub#
034400050527     C                   eval      acct = dgacct
034500050527     C                   endif
034600021218     C                   endif
034700021218      *
034800021218     C                   eval      kxplc = 'V'
034900040720     C     gxfkey        chain     del2gxrl                           21
035000030402     C                   if        *in21 = '1'
035100021218     C                   eval      vtrst = 0
035200021218     C                   eval      vsub# = 0
035300021218     C                   eval      vacct = 0
035400021218     C                   eval      vplan = *blanks
035500021218     C                   eval      vstat = *blanks
035600021218     C                   else
035700021218     C                   eval      vtrst = dgtrst
035800021218     C                   eval      vsub# = dgsub#
035900021218     C                   eval      vacct = dgacct
036000021218     C                   eval      vplan = dgplan
036100021218     C                   eval      vstat = dgstat
036200050527      *
036300050527     C                   if        trst = 0
036400050527     C                   eval      trst = dgtrst
036500050527     C                   eval      sub# = dgsub#
036600050527     C                   eval      acct = dgacct
036700050527     C                   endif
036800021218     C                   endif
036900021218     C                   endsr
037000021218      ************************************************************
037100021218      *
037200021218      *    CHKMBR - Check for validity of member record
037300021218      *
037400021218      ************************************************************
037500021218     C     chkmbr        begsr
037600190827      *       Debug shit
037700190827     C                   if        dbmssn = '231656047'
037800190827     C                   eval      mbrstat = mbrstat
037900190827     C                   endif
038000021231      *             Check to see if coverages exist
038100030102     C                   if        dbelc1 = ' ' and dbelc2 = ' ' and
038200030102     C                             dbelc3 = ' ' and dbelc4 = ' '
038300030102     C                   eval      mbrstat = 'NCV'
038400021231     C                   leavesr
038500021231     C                   endif
038600140210      *             Check to see if Hire date exist
038700140210     C                   if        dbsufx = '00' and dbhrdt = *blanks
038800140210     C                   eval      mbrstat = 'NHR'
038900140210     C                   leavesr
039000140210     C                   endif
039100140410      *             Check to see if Hire date is valid
039200140410     C                   if        dbsufx = '00' and dbhrdt = *blanks
039300140410     C                   if        dbhrdt = '01/01/1753' or
039400140410     C                             dbhrdt = '11/11/1911' or
039500140410     C                             dbhrdt = dbmdob
039600140410     C                   eval      mbrstat = 'IHR'
039700140410     C                   leavesr
039800140410     C                   endif
039900140410     C                   endif
040000021231      *             Check to see if grp/plan xref set up
040100030402     C                   if        (dbelc1 = 'M' and mstat = *blanks) or
040200050527     C                             (dbelc2 = 'M' and mstat = *blanks) or
040300050527     C                             (dbelc3 = 'M' and mstat = *blanks) or
040400050527     C                             (dbelc4 = 'M' and mstat = *blanks)
040500021219     C                   eval      mbrstat = 'NOX'
040600021218     C                   leavesr
040700021218     C                   endif
040800050527     C                   if        (dbelc1 = 'R' and rstat = *blanks) or
040900050527     C                             (dbelc2 = 'R' and rstat = *blanks) or
041000050527     C                             (dbelc3 = 'R' and rstat = *blanks) or
041100050527     C                             (dbelc4 = 'R' and rstat = *blanks)
041200050527     C                   eval      mbrstat = 'NOX'
041300050527     C                   leavesr
041400050527     C                   endif
041500050527     C                   if        (dbelc1 = 'D' and dstat = *blanks) or
041600050527     C                             (dbelc2 = 'D' and dstat = *blanks) or
041700050527     C                             (dbelc3 = 'D' and dstat = *blanks) or
041800050527     C                             (dbelc4 = 'D' and dstat = *blanks)
041900050527     C                   eval      mbrstat = 'NOX'
042000050527     C                   leavesr
042100050527     C                   endif
042200050527     C                   if        (dbelc1 = 'V' and vstat = *blanks) or
042300050527     C                             (dbelc2 = 'V' and vstat = *blanks) or
042400050527     C                             (dbelc3 = 'V' and vstat = *blanks) or
042500050527     C                             (dbelc4 = 'V' and vstat = *blanks)
042600050527     C                   eval      mbrstat = 'NOX'
042700050527     C                   leavesr
042800050527     C                   endif
042900130604      *             If SSN is blanks, set as exc
043000130604     C                   if        dbsub2 = '90' and dbmssn = *blanks
043100130604     C                   eval      mbrstat = 'NSN'
043200130604     C                   leavesr
043300050601     C                   endif
043400130604      *             If sub# is Alt ID - use mbr ssn
043500190827     C*************      if        dbsub2 = '90'
043600190827      *             Use SSN unless 0 - per BS 10/19/17
043700190827     C                   if        dbmssn <> *blanks
043800130604     C                   movel     dbmssn        subn
043900130604     C                   else
044000130604     C                   movel     dbsubn        subn
044100130604     C                   endif
044200021219      *             Check to see if Mbr already exists
044300050601     C     subn          chain     member                             23
044400021219     C                   if        *in23 = '1'
044500021219     C                   eval      mbrstat = 'NEW'
044600021219     C                   leavesr
044700021219     C                   endif
044800021219      *              Mbr rec exists - check if active
044900021219     C                   if        termdt <> 0
045000021219     C                   eval      mbrstat = 'TRM'
045100021219     C                   leavesr
045200021219     C                   endif
045300021219      *              Mbr rec exists - check T,S,A
045400050527     C                   if        (mbtrst <> trst) or (mbsub# <> sub#) or
045500050527     C                             (mbacct <> acct)
045600021219     C                   eval      mbrstat = 'TSA'
045700021219     C                   leavesr
045800021219     C                   endif
045900021219      *              Same T,S,A - check for active acct
046000021219     C     acckey        chain     accmst                             24
046100021219     C                   if        *in24 = '1' or atrmdt <> 0
046200021219     C                   eval      mbrstat = 'ATM'
046300021219     C                   leavesr
046400190816     C                   endif
046500190816      *              Check for account's cover thru date
046600190816     C                   if        linv# <> 0 and acvtdt <> 0
046700190816     C                   if        dbeld1 <> *blanks
046800190816     C                   movel     dbeld1        dbdate
046900190816     C                   else
047000190816     C                   if        dbeld2 <> *blanks
047100190816     C                   movel     dbeld2        dbdate
047200190816     C                   else
047300190816     C                   if        dbeld3 <> *blanks
047400190816     C                   movel     dbeld3        dbdate
047500190816     C                   else
047600190816     C                   if        dbeld4 <> *blanks
047700190816     C                   movel     dbeld4        dbdate
047800190816     C                   endif
047900190816     C                   endif
048000190816     C                   endif
048100190816     C                   endif
048200190816      *
048300190816     C                   z-add     dbdd          gbdd
048400140923     C                   z-add     dbmm          gbmm
048500190816     C                   z-add     dbyy          gbyy
048600190816     C                   if        gbdate <> 0 and gbyymm <= acyymm
048700190816     C                   eval      mbrstat = 'ACT'
048800190816     C                   leavesr
048900190816     C                   endif
049000140923     C                   endif
049100110809      *              O/W active mbr in active acct - add M COV recs
049200021219     C                   eval      mbrstat = 'ADC'
049300021219      *
049400021218     C                   endsr
