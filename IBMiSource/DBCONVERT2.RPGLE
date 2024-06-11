000100140812     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200131231     H*ALWNULL(*USRCTL)
0003000302260002  ******************************************************************
0004000302260003  * DBCONVERT  GROUP BENEFIT SERVICES SOFTWARE           2002      *
0005000302260007  *                                                                *
0006000302260005  *            WRITTEN BY - R.L.J.                                 *
0007000302260006  *            DATE - 12/02/2002                                   *
0008000302260007  *                                                                *
0009000302260006  *  DESCRIPTION - THIS PROGRAM WILL PROVIDE UPDATE OF THE MEMBER  *
0010000302260008  *                                                                *
001100030226      *  CHANGES: xxx mm/dd/yyyy Desc.............................     *
001200030226      *           RLJ 02/27/2003 Allow event type 'CH'                 *
001300030226      *                          Update DELGXRL3 status when mbr added *
001400050919      *           RLJ 03/18/2003 Disable loading of duplicate cvg recs *
001500050919      *           RLJ 11/13/2003 Default Medicare, COB and COBBCF to N *
001600050919      *           RLJ 06/01/2005 Look for Alt-ID, if so use Mbr SSN    *
001700050708      *           RLJ 07/08/2005 Look for Alt-ID, if so use Mbr SSN    *
001800050708      *                          Unless Mbr SSN is 0                   *
001900131223      *           RLJ 08/30/2005 Look for correct depenDENT            *
002000051206      *           RLJ 12/06/2005 Capture Medicare info                 *
002100061130      *           RLJ 12/01/2006 Populate Dep's SSN                    *
002200091123      *           RLJ 11/23/2009 If 4.5 - don't process some fields    *
002300120116      *           RLJ 01/16/2012 Load PCP# if available                *
002400120222      *           RLJ 02/22/2012 Load PCP# if available even if SSN    *
002500120222      *                          already exists and write HIST rec.    *
002600130911      *           RLJ 07/30/2012 Fam Ind - E => P2                     *
002700130911      *           JVA 09/11/2013 Added 834 Tracking File               *
002800131010      *           SBT 10/10/2013 Hist file expansion project           *
002900131223      *
003000131223      * SSK 12/23/13 - HCR PROJECT - MC2V/DC2V AS NEEDED.
003100131223      *
003200140210      *           RLJ 02/10/2014 Chk for Hire dt if member rec         *
003300140328      *           RLJ 03/28/2014 Add logic to write to CFS100P file    *
003400140328      *                          if names are long.
003500140410      *           RLJ 04/10/2014 Check for invalid DOH                 *
003600140611      *           RLJ 06/11/2014 Process handicap flag                 *
003700140923      *           RLJ 09/23/2014 Check for ACCMST cover thru date      *
003800171019      *           RLJ 10/19/2017 Always use SSN unless 0, use sub#     *
003900201116      *           RLJ 11/16/2020 Change HIST vals for MDA and MAC      *
004000131223      *
0041001207300009  ******************************************************************
0042000302260010  *                                                                *
004300021218     Fdelbill   IP   E           K DISK
004400040720     Fdel2gxrl  UF   E           K DISK
004500940921     FACCMST    IF   E           K DISK
004600940921     FPLNMST    IF   E           K DISK
004700021219     FMEMBER    UF A E           K DISK
004800030318     FMCOV22    IF A E           K DISK
004900030318     FDCOV22    IF A E           K DISK
005000130911     FDEPNDC    IF A E           K DISK
005100130911     FDW311TRK  O  A E           K DISK
0052000212030061 FHIST      O    E             DISK
005300021202     Fdelexcp   O    E             DISK
005400140328     Fcfs100p   O    E             DISK
005500120710     Fpcp       UF A E           K DISK
005600021203      *
005700021203     D                 DS
005800021203     D svgrp                               like(dbgrp)
005900021218     D svclas                              like(dbclas)
006000050527      *       Account Info
006100050606     D  dbelcx                             like(dbelc1)
006200050606     D  dbfmix                             like(dbfmi1)
006300050606     D  dbeldx                             like(dbeld1)
006400050606      *       Account Info
006500050606     D  trst                               like(dgtrst)
006600050606     D  sub#                               like(dgsub#)
006700050606     D  acct                               like(dgacct)
006800050606     D  plan                               like(dgplan)
006900050606     D  stat                               like(dgstat)
007000050527      *       Medical Info
007100050527     D mtrst                               like(dgtrst)
007200050527     D msub#                               like(dgsub#)
007300050527     D macct                               like(dgacct)
007400050527     D mplan                               like(dgplan)
007500021218     D mstat                               like(dgstat)
007600021218      *       Drug Info
007700021218     D rtrst                               like(dgtrst)
007800021218     D rsub#                               like(dgsub#)
007900021218     D racct                               like(dgacct)
008000021219     D rplan                               like(dgplan)
008100021218     D rstat                               like(dgstat)
008200021218      *       Dental Info
008300021218     D dtrst                               like(dgtrst)
008400021218     D dsub#                               like(dgsub#)
008500021218     D dacct                               like(dgacct)
008600021219     D dplan                               like(dgplan)
008700021218     D dstat                               like(dgstat)
008800021218      *       Vision Info
008900021218     D vtrst                               like(dgtrst)
009000021218     D vsub#                               like(dgsub#)
009100021218     D vacct                               like(dgacct)
009200021219     D vplan                               like(dgplan)
009300021218     D vstat                               like(dgstat)
009400050606      *
009500050606     D dkacc#                              like(dgacct)
009600120710      *
009700120710     D                 DS
009800120710     D kpcssn                              like(pcssn)
009900120710     D kpcdseq                             like(pcdseq)
010000120710     D kpcid#                              like(pcid#)
010100120710      *
010200981022     D                 DS
010300021203     D  todate                         D   DATFMT(*ISO)
010400021219     D  updtm                         1
010500021219     D  excnc                         1
010600021219     D  mbrstat                       3
010700030226     D  mbradd                        1
010800030331     D  mbrupd                        1
010900120222     D  pcphist                       1
011000021203      *
011100021203     D                 DS
011200021203     D  uprqs                         8
011300021203     D  uprtn                         8
011400021203     D  upstr                       256
011500030915      *
011600030915     D                 DS
011700091123     D  dbprnt                 1      9
011800091123     D   prnt3                 1      3
011900091123      *
012000091123     D                 DS
012100091123     D  dbsufx                 1      2
012200091123     D   sufxn                 1      2  0
012300201116     D                 DS
012400201116     D  mcovtp                 1      3
012500201116     D   mcvt2                 2      3
012600021203      *
012700021203     D                 DS
012800021203     D  phone#                 1     20
012900021203     D   phn10                 1     10
013000021203     D   darea                 1      3  0
013100021203     D   dphn                  4     10  0
013200021219      *
013300021219     D                 DS
013400021219     D  zip9                   1      9
013500021219     D   zip9n                 1      9  0
013600021220     D  zip5                   1      5
013700021220     D   zip5n                 1      5  0
013800021220     D   zip4n                 6      9  0
013900021220     D  zip9nc                10     18  0
014000021220     D   zip5nc               10     14  0
014100021203      *
014200021203     D                 DS
014300021203     D  dbdate                 1     10
014400021203     D   dbmm                  1      2  0
014500021203     D   dbdd                  4      5  0
014600021203     D   dbyy                  7     10  0
014700021203      *
014800021203     D                 DS
014900021203     D  gbdate                 1      8  0
015000140923     D   gbyymm                1      6  0
015100021203     D   gbyy                  1      4  0
015200021203     D   gbmm                  5      6  0
015300021203     D   gbdd                  7      8  0
015400030116      *
015500140923     D                 DS
015600150408     D  acvtdt                 1      8  0
015700140923     D   acyymm                1      6  0
015800140923      *
015900030116     D                 DS
016000030116     D  gbdatx         S               D
016100021203      *
016200021203     D                 DS
016300021203     D  inrec                  1    149
016400021203     D   dblnam                1     35
016500021219     D    dblnm18              1     18
016600140328     D    dblnm19             19     35
016700140415     D   dbfnam               36     60
016800021219     D    dbfnm12             36     47
016900140415     D    dbfnm13             48     60
017000140415     D   dbadd1               61    100
017100140415     D    dbad130             61     90
017200140415     D   dbadd2              101    140
017300140415     D    dbad230            101    130
017400140415     D   dbcity              141    159
017500140415     D    dbcty15            141    155
017600021203      *
017700000103     D                 DS
017800120223     D  dbmssn                 1      9
017900120223     D   ssnn                  1      9  0
018000120223      *
018100120223     D                 DS
018200120223     D  dbsubn                 1      9
018300050601     D   dbsub2                1      2
018400050601      *
018500050601     D                 DS
018600050601     D  suba                   1      9
018700050601     D  subn                   1      9  0
018800050601      *
018900021203     D                 DS
019000021203     D  dbdeps                 1      2
019100040719     D   ndeps                 1      2  0 inz(0)
019200120116      *
019300120116     D                 DS
019400120116     D  dbpref                 1     10
019500120116     D    pcef8                1      8
019600120116     D    pcef8n               1      8  0
019700120116      *
019800120116     D                 DS
019900120116     D  dbprtm                 1     10
020000120116     D    pctm8                1      8
020100120116     D    pctm8n               1      8  0
020200201116      *
020300201116     D                 DS
020400201116     D  hs#not                 1     30
020500201116     D   hnpln                 1      4
020600201116     D   hnbl                  5     25    INZ(*blanks)
020700201116     D   hn26                 26     28    INZ('D#-')
020800201116     D   hnd#                 29     30
020900120116      *
021000201116     D                 DS
021100201116     D  hs#not1                1     30
021200201116     D   hnpln1                1      4
021300201116     D   hn7                   7     26    INZ('AgeBand-00  CovType-')
021400201116     D   hnctp                27     28
021500201116      *
021600021203     D                 DS
021700021203     D  gtsa                   1     10  0
021800021203     D  gtst#                  1      3  0
021900000103     D  gsub#                  4      6  0
022000000103     D  gact#                  7     10  0
022100000103     D                 DS
022200000103     D  mtsa                   1     10  0
022300000103     D  mbtrst                 1      3  0
022400000103     D  mbsub#                 4      6  0
022500000103     D  mbacct                 7     10  0
0226000212030053 D                 DS
0227000301030054 D  mcver          C                   'XXX-MCOV Rec already exists      '
0228000301030054 D  dcver          C                   'XXX-DCOV Rec already exists      '
0229000301030054 D  nocov          C                   'NOCOV - NO COVERAGE SELECTED     '
0230001402100054 D  nohir          C                   'NOHIR - NO HIRE DATE FOR MEMBER! '
0231001404100054 D  inhir          C                   'INHIR - INVALID HIRE DT FOR MEMBER'
0232000301020054 D  noxrf          C                   'NOXRF - NO GRP/PLN XREF FOR GROUP'
0233000212190054 D  actrm          C                   'MEMBER ACCT ALREADY TERMED       '
0234001409230054 D  actcv          C                   'ACCT COVER THRU DATE ERROR       '
0235000508300054 D  dptrm          C                   'DEPEND REC ALREADY TERMED        '
0236000212190054 D  mterm          C                   'MEMBER RECORD EXISTS AS TERMED   '
0237000212190054 D  tsaer          C                   'NEW T,S,A DIFFERS FROM MBR REC  '
0238000302260054 D  invel          C                   'INVEL - INV ELIG TYPE - NOT EL/CH'
0239000212030054 D  mbrex          C                   'MBREX - MEMBER RECORD EXISTS     '
0240000212030054 D  msmbra         C                   'Member Add From DB Conversion    '
0241000212030054 D  msmcva         C                   'Coverage Add From DB Convertn    '
0242001202230054 D  addpcp         C                   'PCP# Added from DBE Conversion   '
0243000712270054 D  ssn000         C                   'Members SSN is all zeros         '
024400131025     D thispgmname     S             10a   inz('DBCONVERT2')
024500131223    ***
024600131223     D @1              S              1A   INZ
024700131223     D PRM@73F         S             21A   INZ
024800131223    ***
024900131223   X***X
025000131223      /DEFINE CHK_ACA_PLAN_PR
025100131223      /DEFINE CHK_ACA_PLAN_FIELDS
025200131223      /COPY QCPYSRC,HCRSRVPGMP
025300131223      /UNDEFINE CHK_ACA_PLAN_PR
025400131223      /UNDEFINE CHK_ACA_PLAN_FIELDS
025500131223   X***X
025600131223    ***
025700030318      * MCOV22 - member coverage key
025800030318     C     mckey         KLIST
025900030318     C                   kfld                    mktrst            3 0
026000030318     C                   kfld                    mksub#            3 0
026100030318     C                   kfld                    mkacc#            4 0
026200030318     C                   kfld                    mkssno            9 0
026300030318     C                   kfld                    mkplan            4
026400030319      *
026500050901      * DEPNDC - dependent key
026600050901     C     dpkey         KLIST
026700050901     C                   kfld                    subn
026800050901     C                   kfld                    kdpsq             2 0
026900050901      *
027000050901      * DCOV22 - dependent coverage key
027100050901     C     dckey         KLIST
027200050901     C                   kfld                    dktrst            3 0
027300030319     C                   kfld                    dksub#            3 0
027400030319     C                   kfld                    dkplan            4
027500030319     C                   kfld                    dkssno            9 0
027600030319     C                   kfld                    dkseq#            2 0
027700030318      *
027800030318      * Group/Plan Xref key
027900030318     C     GXFKEY        KLIST
028000040715     C                   kfld                    kxgrp             8
028100030318     C                   kfld                    kxcls             4
028200030318     C                   kfld                    kxplc             1
028300021203      *
028400021219      * Acct Mst key
028500021219     C     acckey        KLIST
028600050527     C                   kfld                    trst
028700050527     C                   kfld                    sub#
028800050527     C                   kfld                    acct
028900120710      *
029000120710      * PCP key
029100120710     C     pcpkey        KLIST
029200120710     C                   kfld                    kpcssn
029300120710     C                   kfld                    kpcdseq
029400120710     C                   kfld                    kpcid#
029500021219      *
029600021219      ******************************************************************
029700021218      *  Main Line
029800030103      *
029900100223     C                   if        dbrtyp = *blanks and dbgrp <> *blanks
030000021218      *      Check for invalid Event type
030100030226     C                   if        (dbelt1 <> 'SL' and dbelt1 <> '  ' and
030200030226     C                             dbelt1 <> 'CH') or
030300030226     C                             (dbelt2 <> 'SL' and dbelt2 <> '  ' and
030400030226     C                             dbelt2 <> 'CH') or
030500030226     C                             (dbelt3 <> 'SL' and dbelt3 <> '  ' and
030600030226     C                             dbelt3 <> 'CH') or
030700030226     C                             (dbelt4 <> 'SL' and dbelt4 <> '  ' and
030800030226     C                             dbelt4 <> 'CH')
030900021218     C                   eval      dbresn = invel
031000021218     C                   movel     *DATE         dbprdt
031100021218     C                   write     delexcr
031200021218     C                   else
031300021218      *
031400021218     C                   if        dbgrp <> svgrp or dbclas <> svclas
031500021203      *
031600100223     C                   if        mbradd = 'Y'
031700140812     C                   exsr      setsts
031800100223     C                   endif
031900100223      *
032000100223     C                   eval      svgrp = dbgrp
032100100223     C                   eval      svclas = dbclas
032200100223     C                   eval      mbradd = 'N'
032300100223      *      Set plan info for the 4 plan types
032400100223     C                   exsr      setpln
032500100223      *
032600100223     C                   endif
032700100223      *      Process record
032800100223      *
032900100223     C                   if        dbsufx = '00'
033000021203      *      Process member record
033100021219     C                   eval      mbrstat = *blanks
033200021218     C                   exsr      chkmbr
033300021218      *
033400021219     C                   select
033500021219      *        If new member - Build mbr rec and mcov rec
033600021219     C                   when      mbrstat = 'NEW'
033700030226     C                   eval      mbradd = 'Y'
033800021219     C                   exsr      bldmbr
033900021219     C                   exsr      bldmcv
034000030102      *        If no coverages - write exception rec
034100030102     C                   when      mbrstat = 'NCV'
034200030102     C                   eval      dbresn = nocov
034300021219     C                   movel     *DATE         dbprdt
034400021219     C                   write     delexcr
034500140210      *        If no coverages - write exception rec
034600140210     C                   when      mbrstat = 'NHR'
034700140210     C                   eval      dbresn = nohir
034800140210     C                   movel     *DATE         dbprdt
034900140210     C                   write     delexcr
035000140410      *        If hire date is invalid - write exception rec
035100140410     C                   when      mbrstat = 'IHR'
035200140410     C                   eval      dbresn = inhir
035300140410     C                   movel     *DATE         dbprdt
035400140410     C                   write     delexcr
035500071227      *        If Mbr# = 0       - write exception rec
035600071227     C                   when      mbrstat = '000'
035700071227     C                   eval      dbresn = ssn000
035800030102     C                   movel     *DATE         dbprdt
035900030102     C                   write     delexcr
036000071227      *        If no Xref record - write exception rec
036100071227     C                   when      mbrstat = 'NOX'
036200071227     C                   eval      dbresn = noxrf
036300071227     C                   movel     *DATE         dbprdt
036400071227     C                   write     delexcr
036500030331      *        If Member rec is termed - exc
036600021219     C                   when      mbrstat = 'TRM'
036700021219     C                   eval      dbresn = mterm
036800021219     C                   movel     *DATE         dbprdt
036900021219     C                   write     delexcr
037000021219      *        If TSA differs - exc
037100021219     C                   when      mbrstat = 'TSA'
037200021219     C                   eval      dbresn = tsaer
037300021219     C                   movel     *DATE         dbprdt
037400021219     C                   write     delexcr
037500021219      *        If Acct termed - exc
037600021219     C                   when      mbrstat = 'ATR'
037700021219     C                   eval      dbresn = actrm
037800021219     C                   movel     *DATE         dbprdt
037900021219     C                   write     delexcr
038000140923      *        If Acct cover thru issue - exc
038100140923     C                   when      mbrstat = 'ACT'
038200140923     C                   eval      dbresn = actcv
038300140923     C                   movel     *DATE         dbprdt
038400140923     C                   write     delexcr
038500021219      *        Active Mbr in active Acct - Chk demo,Add coverage recs
038600021219     C                   when      mbrstat = 'ADC'
038700030226     C                   eval      mbradd = 'Y'
038800021219     C                   exsr      chkdem
038900021219     C                   exsr      bldmcv
039000021219      *
039100021219     C                   endsl
039200021203      *
039300021203     C                   else
039400021219      *     Process dep record
039500021219      *        See if member created an exception rec
039600021219      *
039700021219     C                   select
039800021219      *        If new member - Build dep rec and dcov rec
039900021219     C                   when      mbrstat = 'NEW'
040000030226     C                   eval      mbradd = 'Y'
040100021219     C                   exsr      blddep
040200021219     C                   exsr      blddcv
040300021219      *        Active Mbr in active Acct - Add coverage recs
040400021219     C                   when      mbrstat = 'ADC'
040500030226     C                   eval      mbradd = 'Y'
040600050830     C                   exsr      chkdcv
040700030103      *
040800021219      *        O/W - write exception record
040900021219     C                   other
041000021219     C                   write     delexcr
041100021219      *
041200021219     C                   endsl
041300021219      *
041400021203     C                   endif
041500021203      *
041600021203     C                   endif
041700021203     C                   endif
041800021203      ****************************************************
041900021218      *
042000021218      *    SETPLN - set the plan info for the 4 plan types
042100030226      *             And set the status code to 'C' - complete
042200021218      ****************************************************
042300021218     C     setpln        begsr
042400021218      *
042500050527     C                   eval      trst = 0
042600050527     C                   eval      sub# = 0
042700050527     C                   eval      acct = 0
042800050527      *
042900021218     C                   movel(P)  dbgrp         kxgrp
043000021218     C                   eval      kxcls = dbclas
043100021218     C                   eval      excnc = 'N'
043200021218      *     Get Xref info for 4 plan types
043300021218     C                   eval      kxplc = 'M'
043400040720     C     gxfkey        chain     del2gxrl                           21
043500030402     C                   if        *in21 = '1'
043600021218     C                   eval      mtrst = 0
043700021218     C                   eval      msub# = 0
043800021218     C                   eval      macct = 0
043900021218     C                   eval      mplan = *blanks
044000021218     C                   eval      mstat = *blanks
044100021218     C                   else
044200021218     C                   eval      mtrst = dgtrst
044300021218     C                   eval      msub# = dgsub#
044400021218     C                   eval      macct = dgacct
044500021218     C                   eval      mplan = dgplan
044600021218     C                   eval      mstat = dgstat
044700050527      *
044800050527     C                   eval      trst = dgtrst
044900050527     C                   eval      sub# = dgsub#
045000050527     C                   eval      acct = dgacct
045100021218     C                   endif
045200021218      *
045300021218     C                   eval      kxplc = 'R'
045400040720     C     gxfkey        chain     del2gxrl                           21
045500051202     C                   if        *in21 = '1'
045600021218     C                   eval      rtrst = 0
045700021218     C                   eval      rsub# = 0
045800021218     C                   eval      racct = 0
045900021218     C                   eval      rplan = *blanks
046000021218     C                   eval      rstat = *blanks
046100021218     C                   else
046200140102      *       Check to see if RX is set to I - Ignore
046300140102     C                   if        dgstat = 'I'
046400140102     C                   eval      rtrst = 0
046500140102     C                   eval      rsub# = 0
046600140102     C                   eval      racct = 0
046700140102     C                   eval      rplan = *blanks
046800140102     C                   eval      rstat = dgstat
046900140102     C                   else
047000021218     C                   eval      rtrst = dgtrst
047100021218     C                   eval      rsub# = dgsub#
047200021218     C                   eval      racct = dgacct
047300021218     C                   eval      rplan = dgplan
047400021218     C                   eval      rstat = dgstat
047500140102     C                   endif
047600140102      *
047700050527     C                   if        trst = 0
047800050527     C                   eval      trst = dgtrst
047900050527     C                   eval      sub# = dgsub#
048000050527     C                   eval      acct = dgacct
048100021218     C                   endif
048200050527     C                   endif
048300021218      *
048400021218     C                   eval      kxplc = 'D'
048500040720     C     gxfkey        chain     del2gxrl                           21
048600051202     C                   if        *in21 = '1'
048700021218     C                   eval      dtrst = 0
048800021218     C                   eval      dsub# = 0
048900021218     C                   eval      dacct = 0
049000021218     C                   eval      dplan = *blanks
049100021218     C                   eval      dstat = *blanks
049200021218     C                   else
049300021218     C                   eval      dtrst = dgtrst
049400021218     C                   eval      dsub# = dgsub#
049500021218     C                   eval      dacct = dgacct
049600021218     C                   eval      dplan = dgplan
049700021218     C                   eval      dstat = dgstat
049800050527      *
049900050527     C                   if        trst = 0
050000050527     C                   eval      trst = dgtrst
050100050527     C                   eval      sub# = dgsub#
050200050527     C                   eval      acct = dgacct
050300050527     C                   endif
050400021218     C                   endif
050500021218      *
050600021218     C                   eval      kxplc = 'V'
050700040720     C     gxfkey        chain     del2gxrl                           21
050800051202     C                   if        *in21 = '1'
050900021218     C                   eval      vtrst = 0
051000021218     C                   eval      vsub# = 0
051100021218     C                   eval      vacct = 0
051200021218     C                   eval      vplan = *blanks
051300021218     C                   eval      vstat = *blanks
051400021218     C                   else
051500150408      *       Check to see if Vision is set to I - Ignore
051600150408     C                   if        dgstat = 'I'
051700150408     C                   eval      vtrst = 0
051800150408     C                   eval      vsub# = 0
051900150408     C                   eval      vacct = 0
052000150408     C                   eval      vplan = *blanks
052100150408     C                   eval      vstat = dgstat
052200150408     C                   else
052300021218     C                   eval      vtrst = dgtrst
052400021218     C                   eval      vsub# = dgsub#
052500021218     C                   eval      vacct = dgacct
052600021218     C                   eval      vplan = dgplan
052700021218     C                   eval      vstat = dgstat
052800150408     C                   endif
052900050527      *
053000050527     C                   if        trst = 0
053100050527     C                   eval      trst = dgtrst
053200050527     C                   eval      sub# = dgsub#
053300050527     C                   eval      acct = dgacct
053400050527     C                   endif
053500021218     C                   endif
053600021218     C                   endsr
053700021218      ************************************************************
053800021218      *
053900021218      *    CHKMBR - Check for validity of member record
054000021218      *
054100021218      ************************************************************
054200021218     C     chkmbr        begsr
054300120222      *
054400120222      *    Write PCP rec if it is not blank
054500120222     C                   eval      pcphist = 'N'
054600120222     C                   if        dbprov <> *blanks
054700120710      *        See if PCP record already exists
054800120710     C                   z-add     ssnn          kpcssn
054900120710     C                   z-add     0             kpcdseq
055000120710     C                   movel     dbprov        kpcid#
055100120710     C     pcpkey        chain     pcp                                56
055200120710     C                   if        *in56 = '1'
055300120710      *
055400120710     C                   eval      pcphist = 'Y'
055500120222     C                   clear                   pcpr
055600120710     C                   z-add     ssnn          pcssn
055700120710     C                   z-add     0             pcdseq
055800120710     C                   movel     dbprov        pcid#
055900120222     C                   movel     'MED'         pcspcd
056000120222      *
056100120222     C                   test(D)                 pcef8n                 55
056200120222     C                   if        *in55 = '0'
056300120222     C                   eval      pceff = pcef8n
056400120222     C                   endif
056500120222      *
056600120222     C                   if        pctm8 <> *blanks
056700120222     C                   test(D)                 pctm8n                 55
056800120222     C                   if        *in55 = '0'
056900120222     C                   eval      pccan = pctm8n
057000120222     C                   endif
057100120222     C                   endif
057200120222      *
057300120222     C                   movel     'Y'           pccur
057400120222     C                   write     pcpr
057500120222     C                   endif
057600120710     C                   endif
057700021231      *             Check to see if coverages exist
057800030102     C                   if        dbelc1 = ' ' and dbelc2 = ' ' and
057900030102     C                             dbelc3 = ' ' and dbelc4 = ' '
058000030102     C                   eval      mbrstat = 'NCV'
058100021231     C                   leavesr
058200021231     C                   endif
058300140210      *             Check to see if Hire date exist
058400140210     C                   if        dbsufx = '00' and dbhrdt = *blanks
058500140210     C                   eval      mbrstat = 'NHR'
058600140210     C                   leavesr
058700140210     C                   endif
058800140410      *             Check to see if Hire date is valid
058900140410     C                   if        dbsufx = '00' and dbhrdt = *blanks
059000140410     C                   if        dbhrdt = '01/01/1753' or
059100140410     C                             dbhrdt = '11/11/1911' or
059200140410     C                             dbhrdt = dbmdob
059300140410     C                   eval      mbrstat = 'IHR'
059400140410     C                   leavesr
059500140410     C                   endif
059600140410     C                   endif
059700021231      *             Check to see if grp/plan xref set up
059800030402     C                   if        (dbelc1 = 'M' and mstat = *blanks) or
059900050527     C                             (dbelc2 = 'M' and mstat = *blanks) or
060000050527     C                             (dbelc3 = 'M' and mstat = *blanks) or
060100050527     C                             (dbelc4 = 'M' and mstat = *blanks)
060200021219     C                   eval      mbrstat = 'NOX'
060300021218     C                   leavesr
060400021218     C                   endif
060500050527     C                   if        (dbelc1 = 'R' and rstat = *blanks) or
060600050527     C                             (dbelc2 = 'R' and rstat = *blanks) or
060700050527     C                             (dbelc3 = 'R' and rstat = *blanks) or
060800050527     C                             (dbelc4 = 'R' and rstat = *blanks)
060900050527     C                   eval      mbrstat = 'NOX'
061000050527     C                   leavesr
061100050527     C                   endif
061200050527     C                   if        (dbelc1 = 'D' and dstat = *blanks) or
061300050527     C                             (dbelc2 = 'D' and dstat = *blanks) or
061400050527     C                             (dbelc3 = 'D' and dstat = *blanks) or
061500050527     C                             (dbelc4 = 'D' and dstat = *blanks)
061600050527     C                   eval      mbrstat = 'NOX'
061700050527     C                   leavesr
061800050527     C                   endif
061900050527     C                   if        (dbelc1 = 'V' and vstat = *blanks) or
062000050527     C                             (dbelc2 = 'V' and vstat = *blanks) or
062100050527     C                             (dbelc3 = 'V' and vstat = *blanks) or
062200050527     C                             (dbelc4 = 'V' and vstat = *blanks)
062300050527     C                   eval      mbrstat = 'NOX'
062400050527     C                   leavesr
062500050527     C                   endif
062600050601      *             If sub# is Alt ID - use mbr ssn
062700171019     C*******            if        dbsub2 = '90' and dbmssn <> *blanks
062800171019      *             Use SSN unless 0 - per BS 10/19/17
062900171019     C                   if        dbmssn <> *blanks
063000050601     C                   movel     dbmssn        subn
063100050601     C                   else
063200050601     C                   movel     dbsubn        subn
063300021219     C                   endif
063400071227      *             Check to see if Mbr# is 0
063500071227     C                   if        subn = 0
063600071227     C                   eval      mbrstat = '000'
063700050601     C                   leavesr
063800050601     C                   endif
063900071227      *             Check to see if Mbr already exists
064000071227     C     subn          chain     member                             23
064100071227     C                   if        *in23 = '1'
064200071227     C                   eval      mbrstat = 'NEW'
064300071227     C                   leavesr
064400071227     C                   endif
064500120222      *           Mbr rec exists - check if active
064600120222      *              If PCP# exists - write HIST record
064700120222     C                   if        pcphist = 'Y'
064800120222     C                   clear                   histr
064900120222     C                   move      suba          hkey
065000120222     C                   movel     todate        trdate
065100120222     C                   move      'MPA'         trcode
065200120223     C                   MOVEL     addpcp        CK#NOT
065300120222     C                   MOVEL     dbprov        NOTE2
065400120222     C                   MOVE      'X'           TRMFLG
065500120222     C                   MOVE      'X'           TRLFLG
065600120222     C                   MOVE      'N'           DTRFLG
065700120222     C                   MOVE      '  '          HDSEQ#
065800131025     C                   MOVEL     thispgmname   HPRGNM
065900120222     C                   MOVE      mbtrst        HSTRST
066000120222     C                   MOVE      mbsub#        HSSUB#
066100120222     C                   MOVE      mbacct        HSACCT
066200120222     C                   MOVEL     'DBCONVRT'    HOPER
066300120222     C                   MOVEL     'A'           HSDLTD
066400131010     c                   eval      hstrtime = %time
066500120222     C                   WRITE     HISTR
066600120222     C                   endif
066700120222      *              Check If active
066800021219     C                   if        termdt <> 0
066900021219     C                   eval      mbrstat = 'TRM'
067000021219     C                   leavesr
067100021219     C                   endif
067200021219      *              Mbr rec exists - check T,S,A
067300050527     C                   if        (mbtrst <> trst) or (mbsub# <> sub#) or
067400050527     C                             (mbacct <> acct)
067500021219     C                   eval      mbrstat = 'TSA'
067600021219     C                   leavesr
067700021219     C                   endif
067800021219      *              Same T,S,A - check for active acct
067900021219     C     acckey        chain     accmst                             24
068000021219     C                   if        *in24 = '1' or atrmdt <> 0
068100021219     C                   eval      mbrstat = 'ATM'
068200021219     C                   leavesr
068300021219     C                   endif
068400140923      *              Check for account's cover thru date
068500140923     C                   if        linv# <> 0 and acvtdt <> 0
068600140923     C                   movel     dbeld1        dbdate
068700140923     C                   z-add     dbdd          gbdd
068800140923     C                   z-add     dbmm          gbmm
068900140923     C                   z-add     dbyy          gbyy
069000140923     C                   if        gbdate <> 0 and gbyymm <= acyymm
069100140923     C                   eval      mbrstat = 'ACT'
069200140923     C                   leavesr
069300140923     C                   endif
069400140923     C                   endif
069500021219      *              O/W active mbr in active acct - add MCOV recs
069600021219     C                   eval      mbrstat = 'ADC'
069700021219      *
069800021218     C                   endsr
069900021219      ************************************************************
070000021219      *
070100021219      *    CHKDEM - Compare GBS member demographics w/ input
070200021219      *
070300021219      ************************************************************
070400021219     C     chkdem        begsr
070500021219      *       Set all input demo values to upper case
070600021219     C                   movel     inrec         upstr
070700021219     C                   CALL      'UTLUPLW'
070800021219     C                   PARM                    uprqs
070900021219     C                   PARM                    uprtn
071000021219     C                   PARM                    upstr
071100021219     C                   movel(P)  upstr         inrec
071200021219      *
071300021219     C                   eval      updtm = 'N'
071400021219      *       Last name match?
071500021219     C                   if        dblnm18 <> mlname
071600021219      *              No - write Hist rec
071700021219     C                   clear                   histr
071800050601     C                   move      suba          hkey
071900021219     C                   movel     todate        trdate
072000021219     C                   move      'M01'         trcode
072100021219     C                   MOVEL     mlname        CK#NOT
072200021219     C                   MOVE      dblnm18       NOTE2
072300021219     C                   MOVE      'X'           TRMFLG
072400021219     C                   MOVE      'X'           TRLFLG
072500021219     C                   MOVE      'N'           DTRFLG
072600021219     C                   MOVE      '  '          HDSEQ#
072700131025     C                   MOVEL     thispgmname   HPRGNM
072800021219     C                   MOVE      mbtrst        HSTRST
072900021219     C                   MOVE      mbsub#        HSSUB#
073000021219     C                   MOVE      mbacct        HSACCT
073100021219     C                   MOVEL     'DBCONVRT'    HOPER
073200021219     C                   MOVEL     'A'           HSDLTD
073300131010     c                   eval      hstrtime = %time
073400021219     C                   WRITE     HISTR
073500021219      *              Set field in mbr rec
073600021219     C                   movel     dblnm18       mlname
073700021219     C                   eval      updtm = 'Y'
073800021219     C                   endif
073900021219      *      First name match?
074000021219     C                   if        dbfnm12 <> mfname
074100021219      *              No - write Hist rec
074200021219     C                   clear                   histr
074300050601     C                   move      suba          hkey
074400021219     C                   movel     todate        trdate
074500021219     C                   move      'M02'         trcode
074600021219     C                   MOVEL     mfname        CK#NOT
074700021219     C                   MOVE      dbfnm12       NOTE2
074800021219     C                   MOVE      'X'           TRMFLG
074900021219     C                   MOVE      'X'           TRLFLG
075000021219     C                   MOVE      'N'           DTRFLG
075100021219     C                   MOVE      '  '          HDSEQ#
075200131025     C                   MOVEL     thispgmname   HPRGNM
075300021219     C                   MOVE      mbtrst        HSTRST
075400021219     C                   MOVE      mbsub#        HSSUB#
075500021219     C                   MOVE      mbacct        HSACCT
075600021219     C                   MOVEL     'DBCONVRT'    HOPER
075700021219     C                   MOVEL     'A'           HSDLTD
075800131010     c                   eval      hstrtime = %time
075900021219     C                   WRITE     HISTR
076000021219      *              Set field in mbr rec
076100021219     C                   movel     dbfnm12       mfname
076200021219     C                   eval      updtm = 'Y'
076300021219     C                   endif
076400021219      *      Address1 name match?
076500021219     C                   if        dbad130 <> addr1
076600021219      *              No - write Hist rec
076700021219     C                   clear                   histr
076800050601     C                   move      suba          hkey
076900021219     C                   movel     todate        trdate
077000021219     C                   move      'M04'         trcode
077100021219     C                   MOVEL     addr1         CK#NOT
077200021219     C                   MOVE      dbad130       NOTE2
077300021219     C                   MOVE      'X'           TRMFLG
077400021219     C                   MOVE      'X'           TRLFLG
077500021219     C                   MOVE      'N'           DTRFLG
077600021219     C                   MOVE      '  '          HDSEQ#
077700131025     C                   MOVEL     thispgmname   HPRGNM
077800021219     C                   MOVE      mbtrst        HSTRST
077900021219     C                   MOVE      mbsub#        HSSUB#
078000021219     C                   MOVE      mbacct        HSACCT
078100021219     C                   MOVEL     'DBCONVRT'    HOPER
078200021219     C                   MOVEL     'A'           HSDLTD
078300131010     c                   eval      hstrtime = %time
078400021219     C                   WRITE     HISTR
078500021219      *              Set field in mbr rec
078600021219     C                   movel     dbad130       addr1
078700021219     C                   eval      updtm = 'Y'
078800021219     C                   endif
078900021219      *      Address2 name match?
079000021219     C                   if        dbad230 <> addr2
079100021219      *              No - write Hist rec
079200021219     C                   clear                   histr
079300050601     C                   move      suba          hkey
079400021219     C                   movel     todate        trdate
079500021219     C                   move      'M05'         trcode
079600021219     C                   MOVEL     addr2         CK#NOT
079700021219     C                   MOVE      dbad230       NOTE2
079800021219     C                   MOVE      'X'           TRMFLG
079900021219     C                   MOVE      'X'           TRLFLG
080000021219     C                   MOVE      'N'           DTRFLG
080100021219     C                   MOVE      '  '          HDSEQ#
080200131025     C                   MOVEL     thispgmname   HPRGNM
080300021219     C                   MOVE      mbtrst        HSTRST
080400021219     C                   MOVE      mbsub#        HSSUB#
080500021219     C                   MOVE      mbacct        HSACCT
080600021219     C                   MOVEL     'DBCONVRT'    HOPER
080700021219     C                   MOVEL     'A'           HSDLTD
080800131010     c                   eval      hstrtime = %time
080900021219     C                   WRITE     HISTR
081000021219      *              Set field in mbr rec
081100021219     C                   movel     dbad230       addr2
081200021219     C                   eval      updtm = 'Y'
081300021219     C                   endif
081400021219      *      City match?
081500021219     C                   if        dbcty15 <> city
081600021219      *              No - write Hist rec
081700021219     C                   clear                   histr
081800050601     C                   move      suba          hkey
081900021219     C                   movel     todate        trdate
082000021219     C                   move      'M06'         trcode
082100021219     C                   MOVEL     city          CK#NOT
082200021219     C                   MOVE      dbcty15       note2
082300021219     C                   MOVE      'X'           TRMFLG
082400021219     C                   MOVE      'X'           TRLFLG
082500021219     C                   MOVE      'N'           DTRFLG
082600021219     C                   MOVE      '  '          HDSEQ#
082700131025     C                   MOVEL     thispgmname   HPRGNM
082800021219     C                   MOVE      mbtrst        HSTRST
082900021219     C                   MOVE      mbsub#        HSSUB#
083000021219     C                   MOVE      mbacct        HSACCT
083100021219     C                   MOVEL     'DBCONVRT'    HOPER
083200021219     C                   MOVEL     'A'           HSDLTD
083300131010     c                   eval      hstrtime = %time
083400021219     C                   WRITE     HISTR
083500021219      *              Set field in mbr rec
083600021219     C                   movel     dbcty15       city
083700021219     C                   eval      updtm = 'Y'
083800021219     C                   endif
083900021219      *      State match?
084000021219     C                   if        dbstat <> state
084100021219      *              No - write Hist rec
084200021219     C                   clear                   histr
084300050601     C                   move      suba          hkey
084400021219     C                   movel     todate        trdate
084500021219     C                   move      'M07'         trcode
084600021219     C                   MOVEL     state         CK#NOT
084700021219     C                   MOVE      dbstat        note2
084800021219     C                   MOVE      'X'           TRMFLG
084900021219     C                   MOVE      'X'           TRLFLG
085000021219     C                   MOVE      'N'           DTRFLG
085100021219     C                   MOVE      '  '          HDSEQ#
085200131025     C                   MOVEL     thispgmname   HPRGNM
085300021219     C                   MOVE      mbtrst        HSTRST
085400021219     C                   MOVE      mbsub#        HSSUB#
085500021219     C                   MOVE      mbacct        HSACCT
085600021219     C                   MOVEL     'DBCONVRT'    HOPER
085700021219     C                   MOVEL     'A'           HSDLTD
085800131010     c                   eval      hstrtime = %time
085900021219     C                   WRITE     HISTR
086000021219      *              Set field in mbr rec
086100021219     C                   movel     dbstat        state
086200021219     C                   eval      updtm = 'Y'
086300021219     C                   endif
086400021219      *      Zip match?
086500021220     C                   z-add     0             zip9nc
086600021219     C                   movel(P)  dbzip         zip9
086700021219     C                   testn                   zip9                 41
086800021219     C                   if        *in41 = '1'
086900021220     C                   z-add     zip9n         zip9nc
087000021220     C                   else
087100021220     C                   testn                   zip5                 41
087200021220     C                   if        *in41 = '1'
087300021220     C                   z-add     0             zip9nc
087400021220     C                   z-add     zip5n         zip5nc
087500021220     C                   endif
087600021220     C                   endif
087700021219      *
087800021220     C                   if        (zip9nc <> 0) and (zip9nc <> zip)
087900021219      *              No - write Hist rec
088000021219     C                   clear                   histr
088100050601     C                   move      suba          hkey
088200021219     C                   movel     todate        trdate
088300021219     C                   move      'M08'         trcode
088400021219     C                   MOVEL     zip           CK#NOT
088500021220     C                   MOVE      zip9nc        note2
088600021219     C                   MOVE      'X'           TRMFLG
088700021219     C                   MOVE      'X'           TRLFLG
088800021219     C                   MOVE      'N'           DTRFLG
088900021219     C                   MOVE      '  '          HDSEQ#
089000131025     C                   MOVEL     thispgmname   HPRGNM
089100021219     C                   MOVE      mbtrst        HSTRST
089200021219     C                   MOVE      mbsub#        HSSUB#
089300021219     C                   MOVE      mbacct        HSACCT
089400021219     C                   MOVEL     'DBCONVRT'    HOPER
089500021219     C                   MOVEL     'A'           HSDLTD
089600131010     c                   eval      hstrtime = %time
089700021219     C                   WRITE     HISTR
089800021219      *              Set field in mbr rec
089900021220     C                   movel     zip9nc        zip
090000021219     C                   eval      updtm = 'Y'
090100021219     C                   endif
090200021219      *             Update member record?
090300021219     C                   if        updtm = 'Y'
090400021219     C                   update    membr
090500021219     C                   endif
090600021219      *
090700021219     C                   endsr
090800021218      ****************************************************
090900021218      *
091000021203      * BLDMBR - Build member record
091100021218      *
091200021218      ****************************************************
091300021203     C     bldmbr        begsr
091400021203      *
091500021203     C                   clear                   membr
091600050601     C                   z-add     subn          mbssno
091700021203     C                   movel     inrec         upstr
091800021203     C                   CALL      'UTLUPLW'
091900021203     C                   PARM                    uprqs
092000021203     C                   PARM                    uprtn
092100021203     C                   PARM                    upstr
092200021203     C                   movel(P)  upstr         inrec
092300021203     C                   movel(P)  dblnam        mlname
092400021203     C                   movel(P)  dbfnam        mfname
092500021203     C                   movel     dbmidi        mmi
092600021203     C                   movel(P)  dbadd1        addr1
092700021203     C                   movel(P)  dbadd2        addr2
092800021203     C                   movel(P)  dbcity        city
092900021203     C                   movel     dbstat        state
093000021219      *
093100021219     C                   movel(P)  dbzip         zip9
093200021219     C                   testn                   zip9                 41
093300021219     C                   if        *in41 = '1'
093400021219     C                   z-add     zip9n         zip
093500021220     C                   else
093600021220     C                   testn                   zip5                 41
093700021220     C                   if        *in41 = '1'
093800021220     C                   z-add     0             zip4n
093900021220     C                   z-add     zip9n         zip
094000021220     C                   endif
094100021220     C                   endif
094200021219      *
094300030103     C                   if        dbhphn <> *blanks
094400021203     C                   movel(P)  dbhphn        phone#
094500021203     C                   testn                   phn10                41
094600021203     C                   if        *in41 = '1'
094700021203     C                   z-add     darea         area
094800021203     C                   z-add     dphn          phone
094900021203     C                   endif
095000030103     C                   endif
095100021219      *
095200021203     C                   movel     dbsex         sex
095300050527     C                   z-add     trst          mbtrst
095400050527     C                   z-add     sub#          mbsub#
095500050527     C                   z-add     acct          mbacct
095600091123     C                   if        prnt3 <> '4.5'
095700021203     C                   z-add     ndeps         nodpnd
095800091123     C                   endif
095900021203     C                   movel(P)  'DBCONVRT'    moper
096000030317     C                   movel     'AA'          status
096100030108     C                   MOVE      'A'           EMPST
096200031113     C                   MOVE      'N'           cob
096300031113     C                   MOVE      'N'           cobbcf
096400051206      *
096500031113     C                   MOVE      'N'           medicr
096600051206     C                   if        dbmdc# <> *blanks
096700051206     C                   MOVE      'P'           medicr
096800051206     C                   movel     dbmdc#        med#
096900021203     C                   endif
097000051206      *
097100051206     C                   if        dbmdob <> *blanks
097200051206     C                   movel     dbmdob        dbdate
097300051206     C                   z-add     dbdd          gbdd
097400051206     C                   z-add     dbmm          gbmm
097500051206     C                   z-add     dbyy          gbyy
097600051206     C                   z-add     gbdate        birth
097700051206     C                   endif
097800030915      *
097900030915     C                   if        dbhrdt <> *blanks
098000061109     C                   movel     dbhrdt        dbdate
098100030915     C                   z-add     dbdd          gbdd
098200030915     C                   z-add     dbmm          gbmm
098300030915     C                   z-add     dbyy          gbyy
098400030915     C                   z-add     gbdate        empdt
098500030915     C                   endif
098600021203      *
098700140611     C                   if        dbhdtp <> '4'
098800140611     C                   movel     dbhdtp        hndicp
098900140611     C                   endif
099000140611      *
099100230414     C                   if        dbhdef <> *blanks
099200230414     C                   movel     dbhdef        hdcpdt
099201230414     C                   endif
099202230414      *
099203230414     C****               if        dbhdef <> *blanks and prnt3 <> '4.5'
099204230414     C**                 movel     dbhdef        dbdate
099300230414     C**                 z-add     dbdd          gbdd
099400230414     C**                 z-add     dbmm          gbmm
099500230414     C**                 z-add     dbyy          gbyy
099600230414     C**                 z-add     gbdate        hdcpdt
099700230414     C****               endif
099800021203      *
099900091123     C                   if        dbmdef <> *blanks and prnt3 <> '4.5'
100000021203     C                   movel     dbmdef        dbdate
100100021203     C                   z-add     dbdd          gbdd
100200021203     C                   z-add     dbmm          gbmm
100300021203     C                   z-add     dbyy          gbyy
100400021203     C                   z-add     gbdate        medadt
100500021203     C                   endif
100600021203      *
100700021203     C                   if        dbeffd <> *blanks
100800021203     C                   movel     dbeffd        dbdate
100900021203     C                   z-add     dbdd          gbdd
101000021203     C                   z-add     dbmm          gbmm
101100021203     C                   z-add     dbyy          gbyy
101200021203     C                   z-add     gbdate        mbenrl
101300021203     C                   endif
101400021203      *
101500021203     C                   movel     todate        mlupdt
101600021203     C                   write     membr
101700120116      *
101800140328      *    Write CFS100P rec if names are too long
101900140328     C                   if        dblnm19 <> *blanks or
102000140328     C                             dbfnm13 <> *blanks
102100140328     C                   clear                   cfs100r
102200140328     C                   eval      cfssn = mbssno
102300140328     C                   eval      cfseq = 0
102400140328     C                   eval      cfsfst = dbfnam
102500140402     C                   eval      cfsmid = dbmidi
102600140402     C                   eval      cfslst = dblnam
102700140328     C                   write     cfs100r
102800140328     C                   endif
102900140328      *
103000140328      *    Write mbr add HIST rec
103100140328     C                   clear                   histr
103200140328     C                   move      suba          hkey
103300140328     C                   movel     todate        trdate
103400140328     C                   move      'MMA'         trcode
103500021203     C                   Z-ADD     0             TRAMT
103600021203     C                   MOVE      *BLANKS       CM$FLG
103700120220     C                   MOVEL     msmbra        CK#NOT
103800120220     C                   MOVE      *BLANKS       NOTE2
103900120220     C                   MOVE      'X'           TRMFLG
104000120220     C                   MOVE      'X'           TRLFLG
104100120220     C                   MOVE      'N'           DTRFLG
104200120220     C                   MOVE      '  '          HDSEQ#
104300131025     C                   MOVEL     thispgmname   HPRGNM
104400021203     C                   Z-ADD     0             RECVDT
104500021203     C                   MOVE      mbenrl        COVTDT
104600050527     C                   MOVE      trst          HSTRST
104700050527     C                   MOVE      sub#          HSSUB#
104800050527     C                   MOVE      acct          HSACCT
104900021219     C                   MOVEL     'DBCONVRT'    HOPER
105000021203     C                   MOVEL     'A'           HSDLTD
105100131010     c                   eval      hstrtime = %time
105200021203     C                   WRITE     HISTR
105300120222      *              If PCP# exists - write HIST record
105400120222     C                   if        pcphist = 'Y'
105500120222     C                   clear                   histr
105600120222     C                   move      suba          hkey
105700120222     C                   movel     todate        trdate
105800120222     C                   move      'MPA'         trcode
105900120223     C                   MOVEL     addpcp        CK#NOT
106000120222     C                   MOVEL     dbprov        NOTE2
106100120222     C                   MOVE      'X'           TRMFLG
106200120222     C                   MOVE      'X'           TRLFLG
106300120222     C                   MOVE      'N'           DTRFLG
106400120222     C                   MOVE      '  '          HDSEQ#
106500131025     C                   MOVEL     thispgmname   HPRGNM
106600120222     C                   MOVE      mbtrst        HSTRST
106700120222     C                   MOVE      mbsub#        HSSUB#
106800120222     C                   MOVE      mbacct        HSACCT
106900120222     C                   MOVEL     'DBCONVRT'    HOPER
107000120222     C                   MOVEL     'A'           HSDLTD
107100131010     c                   eval      hstrtime = %time
107200120222     C                   WRITE     HISTR
107300120222     C                   endif
107400120222      *
107500021203     C                   endsr
107600021203      ****************************************************
107700021203      * BLDMCV - Build member coverage record
107800021203      ****************************************************
107900021203     C     bldmcv        begsr
108000050606      *
108100050606     C                   if        dbelc1 <> *blank
108200050606     C                   move      dbelc1        dbelcx
108300050606     C                   move      dbfmi1        dbfmix
108400050606     C                   movel     dbeld1        dbeldx
108500050606     C                   exsr      wrtmcv
108600021219     C                   endif
108700050606      *
108800050606     C                   if        dbelc2 <> *blank
108900050606     C                   move      dbelc2        dbelcx
109000050606     C                   move      dbfmi2        dbfmix
109100050606     C                   movel     dbeld2        dbeldx
109200050606     C                   exsr      wrtmcv
109300050606     C                   endif
109400050606      *
109500050606     C                   if        dbelc3 <> *blank
109600050606     C                   move      dbelc3        dbelcx
109700050606     C                   move      dbfmi3        dbfmix
109800050606     C                   movel     dbeld3        dbeldx
109900050606     C                   exsr      wrtmcv
110000050606     C                   endif
110100050606      *
110200050606     C                   if        dbelc4 <> *blank
110300050606     C                   move      dbelc4        dbelcx
110400050606     C                   move      dbfmi4        dbfmix
110500050606     C                   movel     dbeld4        dbeldx
110600050606     C                   exsr      wrtmcv
110700050606     C                   endif
110800021219      *
110900021219     C                   endsr
111000050606      ****************************************************
111100050606      * WRTMCV - Write member coverage record
111200050606      ****************************************************
111300050606     C     wrtmcv        begsr
111400050606     C                   z-add     subn          mkssno
111500050606      *   Set coverage type and parameters
111600050606     C                   if        dbelcx = 'M'
111700050606      *      Set Medical coverage parameters
111800050606     C                   z-add     mtrst         mktrst
111900050606     C                   z-add     msub#         mksub#
112000050606     C                   z-add     macct         mkacc#
112100050606     C                   movel     mplan         mkplan
112200050606     C                   else
112300050606      *
112400050606     C                   if        dbelcx = 'R'
112500050606      *      Set Drug(RX) coverage parameters
112600140102     C                   if        rstat = 'I'
112700140102     C                   leavesr
112800140102     C                   endif
112900140102      *
113000050606     C                   z-add     rtrst         mktrst
113100050606     C                   z-add     rsub#         mksub#
113200050606     C                   z-add     racct         mkacc#
113300050606     C                   movel     rplan         mkplan
113400050606     C                   else
113500050606      *
113600050606     C                   if        dbelcx = 'D'
113700050606      *      Set Dental coverage parameters
113800050606     C                   z-add     dtrst         mktrst
113900050606     C                   z-add     dsub#         mksub#
114000050606     C                   z-add     dacct         mkacc#
114100050606     C                   movel     dplan         mkplan
114200050606     C                   else
114300050606      *
114400050606     C                   if        dbelcx = 'V'
114500050606      *      Set Vision coverage parameters
114600050606     C                   z-add     vtrst         mktrst
114700050606     C                   z-add     vsub#         mksub#
114800050606     C                   z-add     vacct         mkacc#
114900050606     C                   movel     vplan         mkplan
115000050606     C                   else
115100050606      *
115200050606     C                   leavesr
115300050606     C                   endif
115400050606     C                   endif
115500050606     C                   endif
115600050606     C                   endif
115700050606      *
115800050606     C     mckey         chain     mcov22                             38
115900050606      *        If Rec already exists - write exception
116000050606     C                   If        *in38 = '0' and candt <> 0
116100050606     C                   eval      dbresn = mcver
116200050606     C                   movel     *DATE         dbprdt
116300050606     C                   write     delexcr
116400050606     C                   else
116500050606      *           write coverage record
116600050606      *
116700051201     C                   if        mkplan <> *blanks
116800050606     C                   clear                   mcovr
116900050606     C                   z-add     subn          mcssno
117000050606     C                   z-add     mktrst        mctrst
117100050606     C                   z-add     mksub#        mcsub#
117200050606     C                   movel     mkplan        mcplan
117300050606      *        Set coverage type
117400050606     C                   select
117500050606     C                   when      dbfmix = 'A'
117600050606     C                   movel     'TFA'         mcovtp
117700050606     C                   when      dbfmix = 'B'
117800050606     C                   movel     'THW'         mcovtp
117900050606     C                   when      dbfmix = 'C'
118000050606     C                   movel     'TIN'         mcovtp
118100050606     C                   when      dbfmix = 'D'
118200050606     C                   movel     'TPC'         mcovtp
118300120730     C                   when      dbfmix = 'E'
118400120730     C                   movel     'TP2'         mcovtp
118500050606     C                   endsl
118600050606      *
118700050606     C                   z-add     mkacc#        acc#
118800050606     C                   movel     'A'           mcdltd
118900050606     c                   exsr      #cactfl
119000050606      *
119100050606     C                   if        dbeldx <> *blanks
119200050606     C                   movel     dbeldx        dbdate
119300050606     C                   z-add     dbdd          gbdd
119400050606     C                   z-add     dbmm          gbmm
119500050606     C                   z-add     dbyy          gbyy
119600050606     C                   z-add     gbdate        enrldt
119700050606     C                   endif
119800050606      *
119900050606     C                   write     mcovr
120000131227      *
120100201117     C************       EXSR      $MBRACA
120200130911      *
120300130911      *    Write 834 Tracking rec for plan add
120400130911     C                   exsr      TRK834m
120500050606      *
120600050606      *    Write mcov add HIST rec for plan add
120700050606     C                   clear                   histr
120800050606     C                   move      suba          hkey
120900050606     C                   movel     todate        trdate
121000050606     C                   move      'MAC'         trcode
121100050606     C                   Z-ADD     0             TRAMT
121200050606     C                   MOVE      *BLANKS       CM$FLG
121300201116     C                   MOVEL     mkplan        hnpln1
121400201116     C                   MOVEL     mcvt2         hnctp
121500201116     C                   MOVEL     hs#not1       CK#NOT
121600201116     C                   MOVEL     *blanks       NOTE2
121700050606     C                   MOVE      'X'           TRMFLG
121800050606     C                   MOVE      'X'           TRLFLG
121900050606     C                   MOVE      'N'           DTRFLG
122000050606     C                   MOVE      '  '          HDSEQ#
122100131025     C                   MOVEL     thispgmname   HPRGNM
122200050606     C                   Z-ADD     0             RECVDT
122300050606     C                   MOVE      gbdate        COVTDT
122400050606     C                   MOVE      mktrst        HSTRST
122500050606     C                   MOVE      mksub#        HSSUB#
122600050606     C                   MOVE      mkacc#        HSACCT
122700050606     C                   MOVEL     'DBCONVRT'    HOPER
122800050606     C                   MOVEL     'A'           HSDLTD
122900131010     c                   eval      hstrtime = %time
123000050606     C                   WRITE     HISTR
123100050606      *
123200050606     C                   endif
123300051201     C                   endif
123400050606      *
123500050606     C                   endsr
123600201117   S*
123700021219      ****************************************************
123800050527      * BLDDEP - Build Dependent record and associated recs
123900021203      ****************************************************
124000021203     C     blddep        begsr
124100050901      *           Get next dep seq#
124200050901     C                   z-add     99            kdpsq
124300050901     C     dpkey         setgt     depndc
124400050901     C                   readp     depndc                                 24
124500050901     C                   if        *in24 = '1' or subn <> dssno
124600050901     C                   z-add     01            kdpsq
124700050901     C                   else
124800050901     C     dpseq#        add       01            kdpsq
124900050901     C                   endif
125000050901     C                   z-add     kdpsq         sufxn
125100021203      *
125200021203     C                   clear                   depenr
125300050601     C                   z-add     subn          dssno
125400050901     C                   z-add     kdpsq         dpseq#
125500021203     C                   movel     inrec         upstr
125600021203     C                   CALL      'UTLUPLW'
125700021203     C                   PARM                    uprqs
125800021203     C                   PARM                    uprtn
125900021203     C                   PARM                    upstr
126000021203     C                   movel(P)  upstr         inrec
126100021203     C                   movel(P)  dblnam        dlname
126200021203     C                   movel(P)  dbfnam        dfname
126300021203     C                   movel     dbmidi        dmi
126400021203     C                   movel(P)  dbadd1        daddr1
126500021203     C                   movel(P)  dbadd2        daddr2
126600021203     C                   movel(P)  dbcity        dcity
126700021203     C                   movel     dbstat        dstate
126800061130      *
126900061130     C                   if        dbmssn <> *blanks
127000061130     C                   testn                   dbmssn               41
127100061130     C                   if        *in41 = '1'
127200061130     C                   movel     dbmssn        depss#
127300061130     C                   endif
127400061130     C                   endif
127500061130      *
127600021219     C                   movel(P)  dbzip         zip9
127700021219     C                   testn                   zip9                 41
127800021219     C                   if        *in41 = '1'
127900111010     C                   z-add     zip9n         dzip
128000111010     C                   else
128100111010     C                   testn                   zip5                 41
128200111010     C                   if        *in41 = '1'
128300111010     C                   z-add     0             zip4n
128400111010     C                   z-add     zip9n         dzip
128500021219     C                   endif
128600111010     C                   endif
128700021219      *
128800030103     C                   if        dbhphn <> *blanks
128900021203     C                   movel(P)  dbhphn        phone#
129000021203     C                   testn                   phn10                41
129100021203     C                   if        *in41 = '1'
129200021203     C                   z-add     darea         darea
129300021203     C                   z-add     dphn          dphone
129400021203     C                   endif
129500030103     C                   endif
129600021219      *
129700021203     C                   movel     dbsex         dsex
129800021203      *
129900100604     C                   if        prnt3 = '834'
130000100604      *
130100100604     C                   if        dbrelc = 'S'
130200100604     C                   if        dbsex = 'F'
130300100604     C                   movel     'RWI'         drelcd
130400100604     C                   else
130500100604     C                   movel     'RHU'         drelcd
130600100604     C                   endif
130700100604     C                   else
130800100604     C                   if        dbrelc = 'C'
130900100604     C                   if        dbsex = 'F'
131000100604     C                   movel     'RDA'         drelcd
131100100604     C                   else
131200100604     C                   movel     'RSO'         drelcd
131300100604     C                   endif
131400100604     C                   endif
131500100604     C                   endif
131600100604     C                   else
131700100604      *
131800021219     C                   select
131900021219     C                   when      dbrelc = 'W'
132000021219     C                   movel     'RWI'         drelcd
132100021219     C                   when      dbrelc = 'H'
132200021203     C                   movel     'RHU'         drelcd
132300021219     C                   when      dbrelc = 'S'
132400021203     C                   movel     'RSO'         drelcd
132500021219     C                   when      dbrelc = 'D'
132600021203     C                   movel     'RDA'         drelcd
132700021219     C                   endsl
132800100604      *
132900100604     C                   endif
133000021203      *
133100021203     C                   if        dbsttp = 'F'
133200021203     C                   movel     'Y'           dstudn
133300021203     C                   endif
133400021203      *
133500021203     C                   movel(P)  'DBCONVRT'    doper
133600021203      *
133700021203     C                   if        dbmdob <> *blanks
133800021203     C                   movel     dbmdob        dbdate
133900021203     C                   z-add     dbdd          gbdd
134000021203     C                   z-add     dbmm          gbmm
134100021203     C                   z-add     dbyy          gbyy
134200021203     C                   z-add     gbdate        dbirth
134300021203     C                   endif
134400021203      *
134500140611     C                   if        dbhdtp <> '4'
134600140611     C                   movel     dbhdtp        dhndcp
134700140611     C                   endif
134701230414      *
134702230414     C                   if        dbhdef <> *blanks
134703230414     C                   movel     dbhdef        dhddt
134704230414     C                   endif
134800140611      *
134900230414     C***                if        dbhdef <> *blanks and prnt3 <> '4.5'
135000230414     C*                  movel     dbhdef        dbdate
135100230414     C*                  z-add     dbdd          gbdd
135200230414     C*                  z-add     dbmm          gbmm
135300230414     C*                  z-add     dbyy          gbyy
135400230414     C*                  z-add     gbdate        dhddt
135500230414     C****               endif
135600021203      *
135700091123     C                   if        dbmdef <> *blanks and prnt3 <> '4.5'
135800021203     C                   movel     dbmdef        dbdate
135900021203     C                   z-add     dbdd          gbdd
136000021203     C                   z-add     dbmm          gbmm
136100021203     C                   z-add     dbyy          gbyy
136200021203     C                   z-add     gbdate        dmedad
136300021203     C                   endif
136400021203      *
136500021203     C                   if        dbeffd <> *blanks
136600021203     C                   movel     dbeffd        dbdate
136700021203     C                   z-add     dbdd          gbdd
136800021203     C                   z-add     dbmm          gbmm
136900021203     C                   z-add     dbyy          gbyy
137000021203     C                   z-add     gbdate        mbenrl
137100021203     C                   endif
137200030116      *
137300030116     C                   movel     'N'           dstudn
137400091123     C                   if        dbstef <> *blanks and prnt3 <> '4.5'
137500030116     C                   if        dbsttm = *blanks
137600030116     C                   movel     'Y'           dstudn
137700030116     C                   else
137800030116     C                   movel     dbsttm        dbdate
137900030116     C                   z-add     dbdd          gbdd
138000030116     C                   z-add     dbmm          gbmm
138100030116     C                   z-add     dbyy          gbyy
138200030116     C                   move      gbdate        gbdatx
138300030116     C                   if        gbdatx > todate
138400030116     C                   movel     'Y'           dstudn
138500030116     C                   endif
138600030116     C                   endif
138700030116     C                   endif
138800021203      *
138900050107     C                   movel     'N'           dcob
139000050107     C                   movel     'N'           dmedcr
139100050107     C                   movel     'N'           dcobbc
139200050107      *
139300050107     C                   movel     'A'           dpdltd
139400021203     C                   movel     todate        dlupdt
139500021203     C                   write     depenr
139600140328      *
139700140328      *    Write CFS100P rec if names are too long
139800140328     C                   if        dblnm19 <> *blanks or
139900140328     C                             dbfnm13 <> *blanks
140000140328     C                   clear                   cfs100r
140100140328     C                   eval      cfssn = dssno
140200140328     C                   eval      cfseq = dpseq#
140300140328     C                   eval      cfsfst = dbfnam
140400140402     C                   eval      cfsmid = dbmidi
140500140328     C                   eval      cfslst = dblnam
140600140328     C                   write     cfs100r
140700140328     C                   endif
140800120116      *
140900120116      *    Write PCP rec if it is not blank
141000120116     C                   if        dbprov <> *blanks
141100120710      *        See if PCP record already exists
141200120710     C                   z-add     dssno         kpcssn
141300120710     C                   z-add     dpseq#        kpcdseq
141400120710     C                   movel     dbprov        kpcid#
141500120710     C     pcpkey        chain     pcp                                56
141600120710     C                   if        *in56 = '1'
141700120710      *
141800120116     C                   clear                   pcpr
141900120116     C                   z-add     dssno         pcssn
142000120116     C                   z-add     dpseq#        pcdseq
142100120118     C                   movel     dbprov        pcid#
142200120116     C                   movel     'MED'         pcspcd
142300120116      *
142400120116     C     *USA          test(D)                 pcef8n                 55
142500120116     C                   if        *in55 = '0'
142600120116     C                   eval      pceff = pcef8n
142700120116     C                   endif
142800120116      *
142900120116     C                   if        pctm8 <> *blanks
143000120116     C     *USA          test(D)                 pctm8n                 55
143100120116     C                   if        *in55 = '0'
143200120116     C                   eval      pccan = pctm8n
143300120116     C                   endif
143400120116     C                   endif
143500120116      *
143600120116     C                   movel     'Y'           pccur
143700120116     C                   write     pcpr
143800120222      *              Write HIST record
143900120222     C                   clear                   histr
144000120222     C                   move      suba          hkey
144100120222     C                   movel     todate        trdate
144200120222     C                   move      'MPA'         trcode
144300120223     C                   MOVEL     addpcp        CK#NOT
144400120222     C                   MOVEL     dbprov        NOTE2
144500120222     C                   MOVE      'X'           TRMFLG
144600120222     C                   MOVE      'X'           TRLFLG
144700120222     C                   MOVE      'N'           DTRFLG
144800120222     C                   MOVE      dpseq#        HDSEQ#
144900131025     C                   MOVEL     thispgmname   HPRGNM
145000120222     C                   MOVE      mbtrst        HSTRST
145100120222     C                   MOVE      mbsub#        HSSUB#
145200120222     C                   MOVE      mbacct        HSACCT
145300120222     C                   MOVEL     'DBCONVRT'    HOPER
145400120222     C                   MOVEL     'A'           HSDLTD
145500131010     c                   eval      hstrtime = %time
145600120222     C                   WRITE     HISTR
145700120222      *
145800120116     C                   endif
145900120116      *
146000120710     C                   endif
146100120710      *
146200021203      *
146300021203     C                   endsr
146400050830      ************************************************************
146500050830      *
146600131223      *    CHKDCV - Look for correct depenDENT record
146700050830      *
146800050830      ************************************************************
146900050830     C     chkdcv        begsr
147000131223      *             Check to see if DepenDENT rec exists
147100050901     C                   z-add     0             kdpsq
147200050901     C     dpkey         setll     depndc
147300050901     C                   dow       *in24 = '0'
147400050901     C                   read      depndc                                 24
147500050830     C                   if        *in24 = '1' or subn <> dssno
147600050830      *        Dep is new - Build dep rec and dcov rec
147700050830     C                   exsr      blddep
147800050830     C                   exsr      blddcv
147900050830     C                   leavesr
148000050830     C                   endif
148100050830      *            Covert lower to upper case for name compare
148200050830     C                   movel     inrec         upstr
148300050830     C                   CALL      'UTLUPLW'
148400050830     C                   PARM                    uprqs
148500050830     C                   PARM                    uprtn
148600050830     C                   PARM                    upstr
148700050830     C                   movel(P)  upstr         inrec
148800050830      *            Convert lower to upper case for name compare
148900050830     C                   if        dbfnm12 <> dfname
149000050830     C                   iter
149100050830     C                   endif
149200050830      *            Convert DOB
149300050830     C                   z-add     0             birth
149400050830     C                   if        dbmdob <> *blanks
149500050830     C                   movel     dbmdob        dbdate
149600050830     C                   z-add     dbdd          gbdd
149700050830     C                   z-add     dbmm          gbmm
149800050830     C                   z-add     dbyy          gbyy
149900050830     C                   z-add     gbdate        birth
150000050830     C                   endif
150100050830     C                   if        birth <> dbirth
150200050830     C                   iter
150300050830     C                   endif
150400050830      *           Got the right person - chk if deleted
150500050830     C                   if        dpdltd = 'C'
150600050830      *           If deleted - write exception rec
150700050830     C                   eval      dbresn = dptrm
150800050830     C                   movel     *DATE         dbprdt
150900050830     C                   write     delexcr
151000050830     C                   leavesr
151100050830     C                   endif
151200050830      *           If active - create dep covg rec
151300050830     C                   z-add     dpseq#        sufxn
151400050830     C                   exsr      blddcv
151500050830     C                   leavesr
151600050830      *
151700050830     C                   enddo
151800050830      *
151900050830     C                   endsr
152000021203      ****************************************************
152100021203      * BLDDCV - Build depend coverage record
152200021203      ****************************************************
152300050606      *
152400050606     C     blddcv        begsr
152500100205      *
152600100205     C                   if        dbelc1 <> *blank
152700100205     C                   move      dbelc1        dbelcx
152800100205     C                   move      dbfmi1        dbfmix
152900100205     C                   movel     dbeld1        dbeldx
153000100205     C                   exsr      wrtdcv
153100100205     C                   endif
153200100205      *
153300100205     C                   if        dbelc2 <> *blank
153400100205     C                   move      dbelc2        dbelcx
153500050606     C                   move      dbfmi2        dbfmix
153600050606     C                   movel     dbeld2        dbeldx
153700050606     C                   exsr      wrtdcv
153800050606     C                   endif
153900050606      *
154000050606     C                   if        dbelc3 <> *blank
154100050606     C                   move      dbelc3        dbelcx
154200050606     C                   move      dbfmi3        dbfmix
154300050606     C                   movel     dbeld3        dbeldx
154400050606     C                   exsr      wrtdcv
154500050606     C                   endif
154600050606      *
154700050606     C                   if        dbelc4 <> *blank
154800050606     C                   move      dbelc4        dbelcx
154900050606     C                   move      dbfmi4        dbfmix
155000050606     C                   movel     dbeld4        dbeldx
155100050606     C                   exsr      wrtdcv
155200050606     C                   endif
155300050606      *
155400050606     C                   endsr
155500050606      ****************************************************
155600050606      * WRTDCV - Build depend coverage record
155700050606      ****************************************************
155800050606     C     wrtdcv        begsr
155900050606     C                   z-add     subn          dkssno
156000050606      *   Set coverage type and parameters
156100050606     C                   if        dbelcx = 'M'
156200050606      *      Set Medical coverage parameters
156300050606     C                   z-add     mtrst         dktrst
156400050606     C                   z-add     msub#         dksub#
156500050606     C                   z-add     macct         dkacc#
156600050606     C                   movel     mplan         dkplan
156700050606     C                   else
156800050606      *
156900050606     C                   if        dbelcx = 'R'
157000050606      *      Set Drug(RX) coverage parameters
157100140102     C                   if        rstat = 'I'
157200140102     C                   leavesr
157300140102     C                   endif
157400140102      *
157500050606     C                   z-add     rtrst         dktrst
157600050606     C                   z-add     rsub#         dksub#
157700050606     C                   z-add     racct         dkacc#
157800050606     C                   movel     rplan         dkplan
157900050606     C                   else
158000050606      *
158100050606     C                   if        dbelcx = 'D'
158200050606      *      Set Dental coverage parameters
158300050606     C                   z-add     dtrst         dktrst
158400050606     C                   z-add     dsub#         dksub#
158500050606     C                   z-add     dacct         dkacc#
158600050606     C                   movel     dplan         dkplan
158700050606     C                   else
158800050606      *
158900050606     C                   if        dbelcx = 'V'
159000050606      *      Set Dental coverage parameters
159100050606     C                   z-add     vtrst         dktrst
159200050606     C                   z-add     vsub#         dksub#
159300050606     C                   z-add     vacct         dkacc#
159400050606     C                   movel     vplan         dkplan
159500050606     C                   else
159600050606      *
159700050606     C                   leavesr
159800050606     C                   endif
159900050606     C                   endif
160000050606     C                   endif
160100050606     C                   endif
160200050606      *
160300050606     C     dckey         chain     dcov22                             38
160400050606      *        If Rec already exists - write exception
160500050606     C                   If        *in38 = '0' and ccandt <> 0
160600050606     C                   eval      dbresn = dcver
160700050606     C                   movel     *DATE         dbprdt
160800050606     C                   write     delexcr
160900050606     C                   else
161000050606      *           Else - write DCOV rec
161100051201     C                   if        dkplan <> *blanks
161200050606     C                   clear                   dcovr
161300050606     C                   z-add     subn          ssno
161400050606     C                   z-add     sufxn         dseq#
161500050606     C                   z-add     dktrst        dvtrst
161600050606     C                   z-add     dksub#        dvsub#
161700050606     C                   movel     dkplan        dvplan
161800050606      *
161900050606     C                   movel     'A'           dvdltd
162000050606      *
162100050606     C                   if        dbeldx <> *blanks
162200050606     C                   movel     dbeldx        dbdate
162300050606     C                   z-add     dbdd          gbdd
162400050606     C                   z-add     dbmm          gbmm
162500050606     C                   z-add     dbyy          gbyy
162600050606     C                   z-add     gbdate        denrdt
162700050606     C                   endif
162800131223      *
162900050606     C                   write     dcovr                                39
163000130911      *
163100201117     C******             EXSR      $DEPACA
163200131227      *
163300130911      *    Write 834 Tracking rec for plan add
163400130911     C                   exsr      TRK834d
163500050606      *
163600050606      *    Write dcov add HIST rec
163700050606     C                   clear                   histr
163800050606     C                   move      suba          hkey
163900050606     C                   movel     todate        trdate
164000050606     C                   move      'MDA'         trcode
164100050606     C                   Z-ADD     0             TRAMT
164200050606     C                   MOVE      *BLANKS       CM$FLG
164300201116     C                   MOVEL     dkplan        hnpln
164400201116     C                   MOVEL     dseq#         hnd#
164500201116     C                   MOVEL     hs#not        CK#NOT
164600201116     C                   MOVEL     *blanks       NOTE2
164700050606     C                   MOVE      'X'           TRMFLG
164800050606     C                   MOVE      'X'           TRLFLG
164900050606     C                   MOVE      'N'           DTRFLG
165000050606     C                   z-add     sufxn         HDSEQ#
165100131025     C                   MOVEL     thispgmname   HPRGNM
165200050606     C                   Z-ADD     0             RECVDT
165300050606     C                   MOVE      gbdate        COVTDT
165400050606     C                   MOVE      dktrst        HSTRST
165500050606     C                   MOVE      dksub#        HSSUB#
165600050606     C                   MOVE      dkacc#        HSACCT
165700050606     C                   MOVEL     'DBCONVRT'    HOPER
165800050606     C                   MOVEL     'A'           HSDLTD
165900131010     c                   eval      hstrtime = %time
166000050606     C                   WRITE     HISTR
166100050606     C                   endif
166200050606      *
166300051201     C                   endif
166400051201      *
166500050606     C                   endsr
166600131223   S***S
166700131223   S***S
166800030108      ****************************************************
166900030108      * fill coverage type action flag in mcov based on coverage type
167000030108      ****************************************************
167100030108     C     #cactfl       BEGSR
167200030108     c                   select
167300030108     c                   when      mcovtp = 'TIN'
167400030108     c                   eval      cactfl = 1
167500030108     c                   when      mcovtp = 'TPC'
167600030108     c                   eval      cactfl = 2
167700030108     c                   when      mcovtp = 'THW'
167800030108     c                   eval      cactfl = 3
167900030108     c                   when      mcovtp = 'TFA'
168000030108     c                   eval      cactfl = 4
168100030108     c                   other
168200030108     c                   eval      cactfl = 0
168300030108     c                   endsl
168400030108     C                   endsr
168500030226      ****************************************************
168600030226      *
168700030226      *   SETSTS - set the status code to 'C' - complete
168800030226      ****************************************************
168900030226     C     setsts        begsr
169000030226      *
169100030226     C                   movel(P)  svgrp         kxgrp
169200030226     C                   eval      kxcls = svclas
169300030226     C                   eval      kxplc = 'M'
169400030226      *      Set status of Xref rec to 'C'
169500040720     C     gxfkey        setll     del2gxrl
169600030226     C                   eval      *in33 = '0'
169700030226     C                   dou       *in33 = '1'
169800040720     C     gxfkey        reade     del2gxrl                               33
169900030226     C                   if        *in33 = '0' and dggrid = kxgrp and
170000030226     C                             dgcsid = kxcls and dgplnc = kxplc
170100030226     C                   eval      dgstat = 'C'
170200030331     C                   movel(P)  'DBCONVERT'   dgoper
170300030331     C                   movel     *date         dgupdt
170400040715     C                   update    del2gxrr
170500030226     C                   else
170600030226     C                   leave
170700030226     C                   endif
170800030226     C                   enddo
170900030226      *
171000030226     C                   eval      kxplc = 'R'
171100030226      *      Set status of Xref rec to 'C'
171200040720     C     gxfkey        setll     del2gxrl
171300030226     C                   eval      *in33 = '0'
171400030226     C                   dou       *in33 = '1'
171500040720     C     gxfkey        reade     del2gxrl                               33
171600030226     C                   if        *in33 = '0' and dggrid = kxgrp and
171700030226     C                             dgcsid = kxcls and dgplnc = kxplc
171800030226     C                   eval      dgstat = 'C'
171900030331     C                   movel(P)  'DBCONVERT'   dgoper
172000030331     C                   movel     *date         dgupdt
172100040715     C                   update    del2gxrr
172200030226     C                   else
172300030226     C                   leave
172400030226     C                   endif
172500030226     C                   enddo
172600030226      *
172700030226     C                   eval      kxplc = 'D'
172800030226      *      Set status of Xref rec to 'C'
172900040720     C     gxfkey        setll     del2gxrl
173000030226     C                   eval      *in33 = '0'
173100030226     C                   dou       *in33 = '1'
173200040720     C     gxfkey        reade     del2gxrl                               33
173300030226     C                   if        *in33 = '0' and dggrid = kxgrp and
173400030226     C                             dgcsid = kxcls and dgplnc = kxplc
173500030226     C                   eval      dgstat = 'C'
173600030331     C                   movel(P)  'DBCONVERT'   dgoper
173700030331     C                   movel     *date         dgupdt
173800040715     C                   update    del2gxrr
173900030226     C                   else
174000030226     C                   leave
174100030226     C                   endif
174200030226     C                   enddo
174300030226      *
174400030226     C                   eval      kxplc = 'V'
174500030226      *      Set status of Xref rec to 'C'
174600040720     C     gxfkey        setll     del2gxrl
174700030226     C                   eval      *in33 = '0'
174800030226     C                   dou       *in33 = '1'
174900040720     C     gxfkey        reade     del2gxrl                               33
175000030226     C                   if        *in33 = '0' and dggrid = kxgrp and
175100030226     C                             dgcsid = kxcls and dgplnc = kxplc
175200030226     C                   eval      dgstat = 'C'
175300030331     C                   movel(P)  'DBCONVERT'   dgoper
175400030331     C                   movel     *date         dgupdt
175500040715     C                   update    del2gxrr
175600030226     C                   else
175700030226     C                   leave
175800030226     C                   endif
175900030226     C                   enddo
176000030226      *
176100030226     C                   endsr
176200130911      ****************************************************
176300130911      *              834 Tracking Record
176400130911      ****************************************************
176500130911     C     TRK834m       begsr
176600130911
176700130911     C                   eval      DTSSN  =  MCSSNO
176800130911     C                   eval      DTSEQ  =  0
176900130911     C                   Eval      DTPLN  =  MCPLAN
177000130911     C                   Eval      DTCAT  =  DBELCX
177100130911     C                   Eval      DTFLG  =  'A'
177200130911     C                   Eval      DTEFF  =  ENRLDT
177300130911     C                   Eval      DTTRM  =  0
177400130911     C     *Date         Mult      10000.0001    DTSNT
177500130911
177600130911     C                   Write     DW311TR
177700130911     C                   endsr
177800130911      ****************************************************
177900130911      *              834 Tracking Record - Dependents
178000130911      ****************************************************
178100130911     C     TRK834d       begsr
178200130911
178300130911     C                   eval      DTSSN  =  SSNO
178400130911     C                   eval      DTSEQ  =  DSEQ#
178500130911     C                   Eval      DTPLN  =  DVPLAN
178600130911     C                   Eval      DTCAT  =  DBELCX
178700130911     C                   Eval      DTFLG  =  'A'
178800130911     C                   Eval      DTEFF  =  DENRDT
178900130911     C                   Eval      DTTRM  =  0
179000130911     C     *Date         Mult      10000.0001    DTSNT
179100130911
179200130911     C                   Write     DW311TR
179300130911     C                   endsr
179400021219      ****************************************************
179500021203      *              One time initialization
179600021203      ****************************************************
179700021203     C     *INZSR        BEGSR
179800021203     C                   MOVE      *DATE         todate
179900021203     C                   eval      uprqs = '*UPPER  '
180000021203     C                   ENDSR
