0001000302260002  ******************************************************************
0002001207180003  * DBCONCHKR  GROUP BENEFIT SERVICES SOFTWARE           2012      *
0003000302260007  *                                                                *
0004000302260005  *            WRITTEN BY - R.L.J.                                 *
0005001207190006  *            DATE - 07/2012                                      *
0006000302260007  *                                                                *
0007000302260009  ******************************************************************
0008000302260010  *                                                                *
000900021218     Fdelbill   IP   E           K DISK
001000120718     Fdel2gxrl  IF   E           K DISK
001100120719     FMCOVC     IF   E           K DISK
001200120719     FDCOVC     IF   E           K DISK
001300120718     FDEPNDC    IF   E           K DISK
001400021202     Fdelexcp   O    E             DISK
001500021203      *
001600021203     D                 DS
001700021203     D svgrp                               like(dbgrp)
001800021218     D svclas                              like(dbclas)
001900050527      *       Account Info
002000050606     D  dbelcx                             like(dbelc1)
002100050606     D  dbfmix                             like(dbfmi1)
002200050606     D  dbeldx                             like(dbeld1)
002300050606      *       Account Info
002400050606     D  trst                               like(dgtrst)
002500050606     D  sub#                               like(dgsub#)
002600050606     D  acct                               like(dgacct)
002700050606     D  plan                               like(dgplan)
002800050606     D  stat                               like(dgstat)
002900050527      *       Medical Info
003000050527     D mtrst                               like(dgtrst)
003100050527     D msub#                               like(dgsub#)
003200050527     D macct                               like(dgacct)
003300050527     D mplan                               like(dgplan)
003400021218     D mstat                               like(dgstat)
003500021218      *       Drug Info
003600021218     D rtrst                               like(dgtrst)
003700021218     D rsub#                               like(dgsub#)
003800021218     D racct                               like(dgacct)
003900021219     D rplan                               like(dgplan)
004000021218     D rstat                               like(dgstat)
004100021218      *       Dental Info
004200021218     D dtrst                               like(dgtrst)
004300021218     D dsub#                               like(dgsub#)
004400021218     D dacct                               like(dgacct)
004500021219     D dplan                               like(dgplan)
004600021218     D dstat                               like(dgstat)
004700021218      *       Vision Info
004800021218     D vtrst                               like(dgtrst)
004900021218     D vsub#                               like(dgsub#)
005000021218     D vacct                               like(dgacct)
005100021219     D vplan                               like(dgplan)
005200021218     D vstat                               like(dgstat)
005300120719      *       Hold Info
005400120719     D xtrst                               like(dgtrst)
005500120719     D xsub#                               like(dgsub#)
005600120719     D xacct                               like(dgacct)
005700120719     D xplan                               like(dgplan)
005800120719     D xcat                                like(dbelc1)
005900050606      *
006000050606     D dkacc#                              like(dgacct)
006100120710      *
006200981022     D                 DS
006300021203     D  todate                         D   DATFMT(*ISO)
006400021219     D  updtm                         1
006500021219     D  excnc                         1
006600120719     D  famcv                         1
006700120719     D  spous                         1
006800021219     D  mbrstat                       3
006900030226     D  mbradd                        1
007000030331     D  mbrupd                        1
007100120719     D  seq0                          2  0 INZ(0)
007200091123      *
007300091123     D                 DS
007400091123     D  dbsufx                 1      2
007500091123     D   sufxn                 1      2  0
007600021203      *
007700021203     D                 DS
007800021203     D  dbdate                 1     10
007900021203     D   dbmm                  1      2  0
008000021203     D   dbdd                  4      5  0
008100021203     D   dbyy                  7     10  0
008200021203      *
008300021203     D                 DS
008400021203     D  gbdate                 1      8  0
008500021203     D   gbyy                  1      4  0
008600021203     D   gbmm                  5      6  0
008700021203     D   gbdd                  7      8  0
008800021203      *
008900000103     D                 DS
009000120223     D  dbmssn                 1      9
009100120223     D   ssnn                  1      9  0
009200120223      *
009300120223     D                 DS
009400120223     D  dbsubn                 1      9
009500050601     D   dbsub2                1      2
009600120116      *
009700021203     D                 DS
009800021203     D  gtsa                   1     10  0
009900021203     D  gtst#                  1      3  0
010000000103     D  gsub#                  4      6  0
010100000103     D  gact#                  7     10  0
010200000103     D                 DS
010300000103     D  mtsa                   1     10  0
010400000103     D  mbtrst                 1      3  0
010500000103     D  mbsub#                 4      6  0
010600000103     D  mbacct                 7     10  0
010700120719     D                 DS
010800120719     D  cvresn                 1     40
010900120719     D   cvr1                  1      5    INZ('Plan ')
011000120719     D   cvrpln                6      9
011100120719     D   cvr2                 10     39    INZ(' has FA cov type w/o a spouse ')
011200030319      *
011300050901      * DEPNDC - dependent key
011400050901     C     dpkey         KLIST
011500120718     C                   kfld                    ssnn
011600050901     C                   kfld                    kdpsq             2 0
011700050901      *
011800120719      * MCOVC - mbr coverage key
011900120719     C     mcvky         KLIST
012000120719     C                   kfld                    ssnn
012100120719     C                   kfld                    seq0
012200120719     C                   kfld                    xtrst
012300120719     C                   kfld                    xsub#
012400120719     C                   kfld                    xplan
012500120719      * DCOVC - dependent coverage key
012600120719     C     dcvky         KLIST
012700120719     C                   kfld                    dssno
012800120719     C                   kfld                    dpseq#
012900120719     C                   kfld                    xtrst
013000120719     C                   kfld                    xsub#
013100120719     C                   kfld                    xplan
013200030318      *
013300030318      * Group/Plan Xref key
013400030318     C     GXFKEY        KLIST
013500040715     C                   kfld                    kxgrp             8
013600030318     C                   kfld                    kxcls             4
013700030318     C                   kfld                    kxplc             1
013800021203      *
013900021219      * Acct Mst key
014000021219     C     acckey        KLIST
014100050527     C                   kfld                    trst
014200050527     C                   kfld                    sub#
014300050527     C                   kfld                    acct
014400120710      *
014500021219      ******************************************************************
014600021218      *  Main Line
014700021203      *
014800120718     C                   if        dbgrp <> svgrp or dbclas <> svclas
014900120718     C                   eval      svgrp = dbgrp
015000120718     C                   eval      svclas = dbclas
015100100223      *      Set plan info for the 4 plan types
015200100223     C                   exsr      setpln
015300100223     C                   endif
015400100223      *      Process record
015500100223      *
015600100223     C                   if        dbsufx = '00'
015700120718      *      Look for Fam Ind = A - TFA
015800120718     C                   if        dbfmi1 = 'A'
015900120718      *
016000120718     C                   select
016100120718     C                   when      dbelc1 = 'M'
016200120719     C                   eval      xtrst = mtrst
016300120718     C                   eval      xsub# = msub#
016400120718     C                   eval      xplan = mplan
016500120718     C                   eval      xcat = dbelc1
016600120718     C                   exsr      chkpln
016700120719      *
016800120718     C                   when      dbelc1 = 'R'
016900120719     C                   eval      xtrst = rtrst
017000120718     C                   eval      xsub# = rsub#
017100120718     C                   eval      xplan = rplan
017200120718     C                   eval      xcat = dbelc1
017300120718     C                   exsr      chkpln
017400120719      *
017500120718     C                   when      dbelc1 = 'D'
017600120719     C                   eval      xtrst = dtrst
017700120718     C                   eval      xsub# = dsub#
017800120718     C                   eval      xplan = dplan
017900120718     C                   eval      xcat = dbelc1
018000120718     C                   exsr      chkpln
018100120719      *
018200120718     C                   when      dbelc1 = 'V'
018300120719     C                   eval      xtrst = vtrst
018400120718     C                   eval      xsub# = vsub#
018500120718     C                   eval      xplan = vplan
018600120718     C                   eval      xcat = dbelc1
018700120718     C                   exsr      chkpln
018800120718     C                   endsl
018900120718      *
019000120718     C                   endif
019100120718      *
019200120718     C                   if        dbfmi2 = 'A'
019300120718      *
019400120718     C                   select
019500120718     C                   when      dbelc2 = 'M'
019600120719     C                   eval      xtrst = mtrst
019700120718     C                   eval      xsub# = msub#
019800120718     C                   eval      xplan = mplan
019900120718     C                   eval      xcat = dbelc2
020000120718     C                   exsr      chkpln
020100120719      *
020200120718     C                   when      dbelc2 = 'R'
020300120719     C                   eval      xtrst = rtrst
020400120718     C                   eval      xsub# = rsub#
020500120718     C                   eval      xplan = rplan
020600120718     C                   eval      xcat = dbelc2
020700120718     C                   exsr      chkpln
020800120719      *
020900120718     C                   when      dbelc2 = 'D'
021000120719     C                   eval      xtrst = dtrst
021100120718     C                   eval      xsub# = dsub#
021200120718     C                   eval      xplan = dplan
021300120718     C                   eval      xcat = dbelc2
021400120718     C                   exsr      chkpln
021500120719      *
021600120718     C                   when      dbelc2 = 'V'
021700120719     C                   eval      xtrst = vtrst
021800120718     C                   eval      xsub# = vsub#
021900120718     C                   eval      xplan = vplan
022000120718     C                   eval      xcat = dbelc2
022100120718     C                   exsr      chkpln
022200120718     C                   endsl
022300120718      *
022400120718     C                   endif
022500120718      *
022600120718     C                   if        dbfmi3 = 'A'
022700120718      *
022800120718     C                   select
022900120718     C                   when      dbelc3 = 'M'
023000120719     C                   eval      xtrst = mtrst
023100120718     C                   eval      xsub# = msub#
023200120718     C                   eval      xplan = mplan
023300120718     C                   eval      xcat = dbelc3
023400120718     C                   exsr      chkpln
023500120719      *
023600120718     C                   when      dbelc3 = 'R'
023700120719     C                   eval      xtrst = rtrst
023800120718     C                   eval      xsub# = rsub#
023900120718     C                   eval      xplan = rplan
024000120718     C                   eval      xcat = dbelc3
024100120718     C                   exsr      chkpln
024200120719      *
024300120718     C                   when      dbelc3 = 'D'
024400120719     C                   eval      xtrst = dtrst
024500120718     C                   eval      xsub# = dsub#
024600120718     C                   eval      xplan = dplan
024700120718     C                   eval      xcat = dbelc3
024800120718     C                   exsr      chkpln
024900120719      *
025000120718     C                   when      dbelc3 = 'V'
025100120719     C                   eval      xtrst = vtrst
025200120718     C                   eval      xsub# = vsub#
025300120718     C                   eval      xplan = vplan
025400120718     C                   eval      xcat = dbelc3
025500120718     C                   exsr      chkpln
025600120718     C                   endsl
025700120718      *
025800120718     C                   endif
025900120718      *
026000120718     C                   if        dbfmi4 = 'A'
026100120718      *
026200120718     C                   select
026300120718     C                   when      dbelc4 = 'M'
026400120718     C                   eval      xplan = mplan
026500120719     C                   eval      xtrst = mtrst
026600120718     C                   eval      xsub# = msub#
026700120718     C                   eval      xcat = dbelc4
026800120718     C                   exsr      chkpln
026900120719      *
027000120718     C                   when      dbelc4 = 'R'
027100120719     C                   eval      xtrst = rtrst
027200120718     C                   eval      xsub# = rsub#
027300120718     C                   eval      xplan = rplan
027400120718     C                   eval      xcat = dbelc4
027500120718     C                   exsr      chkpln
027600120719      *
027700120718     C                   when      dbelc4 = 'D'
027800120719     C                   eval      xtrst = dtrst
027900120718     C                   eval      xsub# = dsub#
028000120718     C                   eval      xplan = dplan
028100120718     C                   eval      xcat = dbelc4
028200120718     C                   exsr      chkpln
028300120719      *
028400120718     C                   when      dbelc4 = 'V'
028500120719     C                   eval      xtrst = vtrst
028600120718     C                   eval      xsub# = vsub#
028700120718     C                   eval      xplan = vplan
028800120718     C                   eval      xcat = dbelc4
028900120718     C                   exsr      chkpln
029000120718     C                   endsl
029100120718      *
029200120718     C                   endif
029300120718      *
029400120718     C                   endif
029500021203      ****************************************************
029600021218      *
029700021218      *    SETPLN - set the plan info for the 4 plan types
029800030226      *             And set the status code to 'C' - complete
029900021218      ****************************************************
030000021218     C     setpln        begsr
030100021218      *
030200050527     C                   eval      trst = 0
030300050527     C                   eval      sub# = 0
030400050527     C                   eval      acct = 0
030500050527      *
030600021218     C                   movel(P)  dbgrp         kxgrp
030700021218     C                   eval      kxcls = dbclas
030800021218     C                   eval      excnc = 'N'
030900021218      *     Get Xref info for 4 plan types
031000021218     C                   eval      kxplc = 'M'
031100040720     C     gxfkey        chain     del2gxrl                           21
031200030402     C                   if        *in21 = '1'
031300021218     C                   eval      mtrst = 0
031400021218     C                   eval      msub# = 0
031500021218     C                   eval      macct = 0
031600021218     C                   eval      mplan = *blanks
031700021218     C                   eval      mstat = *blanks
031800021218     C                   else
031900021218     C                   eval      mtrst = dgtrst
032000021218     C                   eval      msub# = dgsub#
032100021218     C                   eval      macct = dgacct
032200021218     C                   eval      mplan = dgplan
032300021218     C                   eval      mstat = dgstat
032400050527      *
032500050527     C                   eval      trst = dgtrst
032600050527     C                   eval      sub# = dgsub#
032700050527     C                   eval      acct = dgacct
032800021218     C                   endif
032900021218      *
033000021218     C                   eval      kxplc = 'R'
033100040720     C     gxfkey        chain     del2gxrl                           21
033200051202     C                   if        *in21 = '1'
033300021218     C                   eval      rtrst = 0
033400021218     C                   eval      rsub# = 0
033500021218     C                   eval      racct = 0
033600021218     C                   eval      rplan = *blanks
033700021218     C                   eval      rstat = *blanks
033800021218     C                   else
033900021218     C                   eval      rtrst = dgtrst
034000021218     C                   eval      rsub# = dgsub#
034100021218     C                   eval      racct = dgacct
034200021218     C                   eval      rplan = dgplan
034300021218     C                   eval      rstat = dgstat
034400050527      *
034500050527     C                   if        trst = 0
034600050527     C                   eval      trst = dgtrst
034700050527     C                   eval      sub# = dgsub#
034800050527     C                   eval      acct = dgacct
034900021218     C                   endif
035000050527     C                   endif
035100021218      *
035200021218     C                   eval      kxplc = 'D'
035300040720     C     gxfkey        chain     del2gxrl                           21
035400051202     C                   if        *in21 = '1'
035500021218     C                   eval      dtrst = 0
035600021218     C                   eval      dsub# = 0
035700021218     C                   eval      dacct = 0
035800021218     C                   eval      dplan = *blanks
035900021218     C                   eval      dstat = *blanks
036000021218     C                   else
036100021218     C                   eval      dtrst = dgtrst
036200021218     C                   eval      dsub# = dgsub#
036300021218     C                   eval      dacct = dgacct
036400021218     C                   eval      dplan = dgplan
036500021218     C                   eval      dstat = dgstat
036600050527      *
036700050527     C                   if        trst = 0
036800050527     C                   eval      trst = dgtrst
036900050527     C                   eval      sub# = dgsub#
037000050527     C                   eval      acct = dgacct
037100050527     C                   endif
037200021218     C                   endif
037300021218      *
037400021218     C                   eval      kxplc = 'V'
037500040720     C     gxfkey        chain     del2gxrl                           21
037600051202     C                   if        *in21 = '1'
037700021218     C                   eval      vtrst = 0
037800021218     C                   eval      vsub# = 0
037900021218     C                   eval      vacct = 0
038000021218     C                   eval      vplan = *blanks
038100021218     C                   eval      vstat = *blanks
038200021218     C                   else
038300021218     C                   eval      vtrst = dgtrst
038400021218     C                   eval      vsub# = dgsub#
038500021218     C                   eval      vacct = dgacct
038600021218     C                   eval      vplan = dgplan
038700021218     C                   eval      vstat = dgstat
038800050527      *
038900050527     C                   if        trst = 0
039000050527     C                   eval      trst = dgtrst
039100050527     C                   eval      sub# = dgsub#
039200050527     C                   eval      acct = dgacct
039300050527     C                   endif
039400021218     C                   endif
039500021218     C                   endsr
039600021218      ************************************************************
039700021218      *
039800120718      *    CHKPLN - Check for correct plan type
039900021218      *
040000021218      ************************************************************
040100120718     C     chkpln        begsr
040200120222      *
040300120718      *    Find Spouse dep seq#
040400120718     C                   eval      spous = 'N'
040500120719     C                   eval      famcv = 'N'
040600120719      *        Look for mbr coverage rec
040700120719     C     mcvky         chain     mcovc                              54
040800120719     C                   if        *in54 = '1' or mcovtp <> 'TFA'
040900120719     C                   leavesr
041000120719     C                   endif
041100120719      *        Look for spouse in depend
041200120718     C                   z-add     0             kdpsq
041300120718     C     dpkey         setll     depndc
041400120718     C                   dow       *in24 = '0'
041500120718     C                   read      depndc                                 24
041600120718     C                   if        *in24 = '1' or ssnn <> dssno
041700120718     C                   leave
041800120718     C                   endif
041900120718     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
042000120718     C                   eval      spous = 'Y'
042100120718     C                   leave
042200120718     C                   endif
042300120718     C                   enddo
042400120718      *
042500120718     C                   if        spous = 'Y'
042600120719      *        Look for dep coverage rec
042700120719     C     dcvky         chain     dcovc                              55
042800120719     C                   if        *in55 = '0'
042900120719     C                   eval      famcv = 'Y'
043000120719     C                   endif
043100120719     C                   endif
043200120719      *
043300120719     C                   if        spous = 'N' or famcv = 'N'
043400120719     C                   eval      cvrpln = xplan
043500120719     C                   eval      dbresn = cvresn
043600120719     C                   write     delexcr
043700120719     C                   endif
043800120719      *
043900120719     C                   endsr
