0001000306110015  *******************************************************************
000200100114      * rpa021         Group Benefit Services, Inc.                     *
000300030611      *                                                                 *
000400030611      *    WRITTEN BY - DAVID KETTERMAN                                 *
000500100114      *    DATE       - 01/14/10                                        *
000600030611      *                                                                 *
000700100115      * This program will produce the Care First AR spreadsheet         *
0008001002120015  * workfile # 1 that holds the invoice data.                       *
0009000308050015  *                                                                 *
0010001011240015  * 11/24/10 dlk - fix dec data error when no rec selected          *
0011001207030015  * 05/31/12 dlk - allow for dbe only or all other carriers. Also   *
0012001207030015  *                add choice of carrier group code.                *
0013001211020015  * 11/02/12 dlk - change klist to use lda values for T-S-A         *
0014001401090015  * 01/09/14 dlk - add dep seq# to work file so dependent           *
0015001401100015  *                transactions will not add to the member count.   *
0016001401100015  *                Also override the coverage type for dependent    *
0017001401100015  *                group # search.                                  *
0017011409110015  * 09/11/14 dlk - change r2treff to use idtrmd for cobra rec.      *
001702190305      * 03/05/19 dlk - Cobra transactions will now back out the
0017031903050035  *                2% admin fee from the billed amount instead of
0017041903050035  *                using the net rate since PSF plans have net <>
0017051903050035  *                billed and we want to send tha actual billed amount
0017061903050035  *                without the 2% cobra admin fee.
001707190315      * 03/15/19 dlk - change to how the billed cobra premium is found
001708190315      *                again. Only PSF carriers and cobra manual adj
001709190315      *                will get billed prem as billed - 2%, others
001710190315      *                will still use idtram.
001711190315      *                A better solution is still needed.
0017121903050015  *                                                                 *
0017131903050015  *                                                                 *
0018000306110015  *******************************************************************
0019001001150017 FINVele    IP   E             DISK
0020001001150017 FINVDET    If   E           k DISK
0021009606250019 FCARMST    IF   E           K DISK
0022001001210030 Frpa021wk  O  A E             DISK
0023001001190021 Fqprint    O    F  132        PRINTER OFLIND(*INOg)
002400030926
0025001001190138 D                 DS
0026001001190139 D  tspabct                1     15
0027001011240140 D  IETRST                 1      3  0 inz(0)
0028001011240140 D  IESUBD                 4      6  0 inz(0)
0029001001190140 D  IEPLAN                 7     10
0030001001190141 ** AGEBND                11     12  0
0031001001190141 D  ab                    11     12  0 inz(00)
0032001401100142 D  covtypewk             13     15
003300100115
0034001001190176 D                UDS
0035001211020056 D  ltrust                 1      3  0
0036001211020056 D  lsub                   4      6  0
0037001211020056 D  lacc                   7     10  0
0038001211020056 D  lcarrier              11     11
0039001207030056 D  lcargrp               12     13
0040001001190056 D  lconame              201    240
004100120629
004200120629     C* select DBE only or all other carriers
004300120703     C* select carrier group code
004400100115     C     iecar         CHAIN     CARMST
004500120629     C                   if        not %found(carmst) or
004600120629     C                             (lcarrier = 'D' and carbc <> 'D') or
004700120703     C                             (lcarrier = 'O' and carbc = 'D') or
004800120703     C                             (lcargrp <> '  ' and cgrpcd <> lcargrp)
004900090901     C                   GOTO      #end
005000090901     C                   END
005100100115
005200100115      * get group # from grate
005300140110     c                   move      iect          covtypewk
005400140110      * override coverage type for dependent records that have "TNA" since
005500140110      * there is no grate for it so the group # would not be found.
005600140110     c                   if        covtypewk = 'TNA'
005700140110     c                   eval      covtypewk = 'TIN'
005800140110     c                   end
005900140110
006000100120     c                   move      tspabct       parmkey
006100100120     c                   if        ierc = '20'
006200100120     c                   move      ievcdt        parmeffymd
006300100120     c                   else
006400100120     c                   move      ietref        parmeffymd
006500100120     c                   end
006600100120     c**                 move      ieben         parmbenamt
006700100120
006800100115     c                   exsr      #getrat
006900100115
007000100120      * write rec to work file
007100100120     c                   exsr      #writefileacc
007200021016
007300100119     c     #end          tag
007400100120
007500100120      * get amounts billed to cobra members
007600100120     clr                 exsr      #getcobra
007700100119
0078001001200324 C*******************************************
0079001001200325 C* GET COBRA DATA
0080001001200324 C*******************************************
008100100120     c     #getcobra     begsr
0082001001200384
0083001001200385 C     idkey         setll     invdet
008400100120     c                   dou       %eof(invdet)
008500100120     c     idkey         reade     invdet
008600120629      * select cobra, dbe or all other
008700100120     c                   if        not %eof(invdet) and idcob = 'C' and
008800120629     C                             ((lcarrier = 'D' and idbccc = 'D') or
008900120629     C                             (lcarrier = 'O' and idbccc <> 'D'))
009000100120
009100120706      * select carrier group code if entered on screen
009200120706     C                   if        lcargrp <> '  '
009300120706     C     idcar         CHAIN     CARMST
009400120706     C                   if        not %found(carmst) or
009500120706     C                             (cgrpcd <> lcargrp)
009600120706     C                   iter
009700120706     C                   end
009800120706     C                   end
009900120706
010000100120      * write rec to work file
010100100120     c                   exsr      #writefilecob
010200100120
010300100120     c                   end
010400100120     c                   enddo
010500100120
0106001001200387 C                   endsr
010700100120
0108001001150324 C*******************************************
0109001401100325 C* GET GROUP #
0110001001150324 C*******************************************
011100100115     c     #getrat       begsr
0112001001150384 C*
0113001001150385 C* clear fields first
0114001401100387 C*                  clear                   PREM
0115001401100387 C*                  clear                   NPREM
0116001001150387 C                   clear                   grgroup
011700100115
011800100115     c     grplist       plist
011900100115     c                   parm                    parmkey          15
012000140106     C                   PARM                    PARMSSN           9
012100140106     C                   PARM                    PARMSEQ           2
012200100115     c                   parm                    parmeffymd        8
012300100115     c                   parm                    parmbenamt        7
012400100115     c                   parm                    parmgroup        15
012500100115     c                   parm                    parmbilrte       11
012600100115     c                   parm                    parmnetrte       11
012700100115     c                   parm                    parmbilprem       7
012800100115     c                   parm                    parmnetprem       7
012900100115     c                   parm                    parmfound         1
013000140106    *
013100140106     C                   EVAL      PARMSSN = *BLANKS
013200140106     C                   EVAL      PARMSEQ = *BLANKS
013300100120
013400100115     c                   clear                   parmgroup
013500100115     c                   clear                   parmbilrte
013600100115     c                   clear                   parmnetrte
013700100115     c                   clear                   parmbilprem
013800100115     c                   clear                   parmnetprem
013900100115     c                   clear                   parmfound
014000100115
014100100115     c                   call      'GETRATE'     grplist
014200100115
014300140110      * returned values, this program only needs the group #
0144001001150361 C                   if        parmfound = 'Y'
014500140110     c**                 move      parmbilprem   prem              7 2
014600140110     c**                 move      parmnetprem   nprem             7 2
014700100119     c                   move      parmgroup     grgroup          15
014800100115
014900100115     c                   else
015000100115      * no rate found - error
015100100115     C                   if        hdflg <> 'Y'
015200100115     C                   EXCEPT    prterrhead
015300100115     C                   MOVE      'Y'           HDFLG             1
015400100115     C                   END
015500100115     C   og              EXCEPT    prterrhead
015600100115     C                   EXCEPT    prterrdet
0157001001150363 C                   END
015800100115     c                   endsr
015900100115
0160001001190324 C*******************************************
0161001001200325 C* write output file (Account data)
0162001001190324 C*******************************************
016300100120     c     #writefileacc begsr
0164001001190384
0165001001210387 C                   clear                   rpa021r
016600100119
016700100119     c                   move      IETRST        R2TRUST
016800100119     c                   move      IESUBD        R2SUB
016900100119     c                   move      IEACCT        R2ACCT
017000100119     c                   move      IEVCDT        R2INVEFF
017100100119     c                   move      IEINV#        R2INV#
017200100119     c                   move      grgroup       R2GROUP
017300100212      * trans effdt as 1st of month
017400100120     c                   if        ietref <> 0
017500100119     c                   move      IETREF        R2TREFF
017600100212     c                   move      01            R2TREFF
017700100120     c                   else
017800100120     c                   move      IEvcdt        R2TREFF
017900100120     c                   end
018000100212
018100100119     c                   move      IEPLAN        R2PLAN
018200100119     c                   move      IETRAMB       R2BILLED
018300100119     c                   move      IECOBRA       R2COBRA
018400100119     c                   move      IERC          R2RECCOD
018500140109     c                   move      IEseq         R2dep#
018600100119
018700100121     c                   write     rpa021r
018800100119     c                   endsr
018900100119
0190001001200324 C*******************************************
0191001001200325 C* write output file (cobra data)
0192001001200324 C*******************************************
019300100120     c     #writefilecob begsr
0194001001200384
0195001001210387 C                   clear                   rpa021r
019600100120
019700100120     c                   move      IDTRST        R2TRUST
019800100120     c                   move      IDSUBD        R2SUB
019900100120     c                   move      IDACCT        R2ACCT
020000100120     c                   move      IDCVDT        R2INVEFF
020100100120     c                   move      IDINV#        R2INV#
020200100120     c                   move      IDGRP#        R2GROUP
020300140911      * transaction type effdt - use 1st of month
020400140911     c                   move      IDTRMD        R2TREFF
020500100212     c                   move      01            R2TREFF
020600100212
020700100120     c                   move      IDPLAN        R2PLAN
020800190305      * 3/5/19 - need to send actual billed amount and since PSF plans
020801190305      *          hold premium w/o the PSF we can no longer count on the net
020802190305      *          to hold the premium without the 2% cobra admin fee. Use
020803190305      *          the billed amount (IDRAMB) less the 2% cobra admin fee
020804190305      *          now.
020805190315      * 3/15/19 - change to only get premiumm less 2% from IDTRAMB
020806190315      *           for PSF carriers because the recent change caused older
020807190315      *           transactions to be reported differently than they were
020808190315      *           years ago. All other COBRA still use IDTRAM for billed
020809190315      *           amount of cobra premium w/o the 2%.
020810190315      *           There is still a hole in this logic that needs
020811190315      *           to be fixed, divorced cobra members do NOT get charged
020812190315      *           the 2% and this logic will miss them if they are under
020813190315      *           a psf plan.
020814190315      *
020815190315
020816190315      * idtram holds cobra net (w/o 2%), use this by default
020900190315     c                   move      IDTRAM        R2BILLED
020901190315
020902190315      * idtrab holds full billed cobra (w/2%) but since PSF carriers
020903190318      * cannot use idtram then calc using billed - 2%.
020904190318      * do this for cobra manual adjustments also (CMA)
020906190315     c                   if        (idrc  = 'CMA' or
020907190315     c                              idcar = 'PSM' or idcar = 'PSX')
020908190315     c                             and idtramb <> 0
020909190315     c                   clear                   R2BILLED
020910190305     c     idtramb       div(h)    1.02          r2billed
020911190305     c                   end
020912190305
021000100120     c                   move      IDCOB         R2COBRA
021100100120     c**                 move                    R2RECCOD
021200140109     c                   move      IDseq         R2dep#
021300100120
021400100121     c                   write     rpa021r
021500100120     c                   endsr
021600100120
0217000210160069 C**************************************************************
0218000210160069 C* first time                                                 *
0219000210160069 C**************************************************************
022000021016     c     *inzsr        begsr
022100021016     C                   TIME                    HTIME             6 0
022200100120
022300100120     c     idkey         klist
022400121102     c                   kfld                    ltrust
022500121102     c                   kfld                    lsub
022600121102     c                   kfld                    lacc
022700030805
022800021016     c                   endsr
022900020322
0230001001190108 Oqprint    E            prterrhead     2 03
0231001001190110 O                       lconame             87
0232001001190111 O          E            prterrhead     1
0233001001190113 O                       *DATE         Y     14
0234001207170114 O                                           55 'INVOICE ERRORS - MISSING '
023500120717     O                                           81 'GRATE - GROUP # NOT AVAILA'
023600120717     O                                          105 'BLE IN A/R (IACS) REPORT'
0237001001190115 O                                          120 'PAGE :'
0238001001190116 O                       PAGE2         Z    130
023900100119     O          E            prterrhead     1
0240001001190119 O                                           18 'PROG: RPA021'
0241001001190120 O                                          120 'TIME :'
0242001001190121 O                       HTIME              130 '  :  :  '
024300100119     O          E            prterrhead     1
0244001001190124 O                                           24 '------------------------'
0245001001190125 O                                           48 '------------------------'
0246001001190126 O                                           72 '------------------------'
0247001001190127 O                                           96 '------------------------'
0248001001190128 O                                          120 '------------------------'
0249001001190129 O                                          132 '------------'
025000100119     O          E            prterrhead     1
0251001001190132 O                                           15 'T/S/P/AB/CT'
0252001001190133 O                                           30 'EFFDT'
025300100119     O          E            prterrhead     2
0254001001190141 O                                           24 '------------------------'
0255001001190142 O                                           48 '------------------------'
0256001001190143 O                                           72 '------------------------'
0257001001190144 O                                           96 '------------------------'
0258001001190145 O                                          120 '------------------------'
0259001001190146 O                                          132 '------------'
0260001001190147 O          E            prterrdet      1
0261001001190150 O                       tspabct             15
0262001001190151 O                       parmeffymd          30
0263001001190581 O*
