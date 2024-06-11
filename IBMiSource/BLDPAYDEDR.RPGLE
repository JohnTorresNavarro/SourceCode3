000100101116     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200101116     H option(*SRCSTMT: *NODEBUGIO)
000300000000      *_________________________________________________________________________
000400000000      *
000500101116      * NOTES:  If add, pass mcov eff date as START and *Zeros in STOP
000600101116      *         If trm, pass mcov trm date as STOP and *Zeros in START
000700101116      *
000800101116      *  Description:  Build Payroll Deductions from GBS
000900000000      *
001000101105      *  (c)Copyright 2010 by GBS, Inc.
001100000000      *
001200101116      *    Created by:  JALLEN - Nov 16, 2010
001300000000      *_________________________________________________________________________
001400101116     fPAYDEDL1  if   e           K disk
001500110822     fPAYDEDANL1if   e           K disk
001600110822     fWEBPAYARC if   e           K disk    prefix(P1_)
001700110822     fWEBPAYDED uf   e           K disk    prefix(Q1_)
001800060525
001900060525      * Prototypes
002000101105      /copy *libl/qmodsrc,#getdedpr
002100101105      /copy *libl/qmodsrc,#getclvlpr
002200101105      /copy *libl/qmodsrc,#chknhrpr
002300101116      /copy *libl/qmodsrc,#pchainpr
002400101116      /copy *libl/qmodsrc,#dwritepr
002500061122
002600101105     d pos             s              2s 0 inz
002700101116     d CovLevel        s             20a   inz
002800101105     d NewHire         s              1s 0 inz
002900110727     d wwrtn           s              1a   inz
003000110727     d wwsal           s              1a
003100110909     d SavAmt          s             10s 2 inz
003200061122
003300101105     d Today           S               d   datfmt(*iso)
003400101105     d  wiso           s               d   datfmt(*iso)
003500101105     d w80date         s              8s 0 inz
003600101105
003700101116     d wdta          e ds                  extname(WEBPAYGBS)
003800101116     d webpay        e ds                  extname(WEBPAYROLL)
003900101116     d webded        e ds                  extname(WEBPAYDED)
004000101116     d payded        e ds                  extname(WEBPAYDS)
004100101116
004200101116     C     *Entry        Plist
004300110727     C                   Parm                    wdta
004400110727     C                   Parm                    wwsal
004500101116
004600101116      * Reset
004700101116     C                   Clear                   webded
004800101116
004900101116      * Load Keys
005000101116     C                   Eval      PQTRS = PGTRS
005100101116     C                   Eval      PQSUB = PGSUB
005200101116     C                   Eval      PQACT = PGACT
005300101116     C                   Eval      PQSSN = PGSSN
005400101116     C                   Eval      PQSEQ = PGSEQ
005500101116     C                   Eval      PQCAT = PGCAT
005600101116     C                   Eval      PQPLN = PGPLN
005700101117     C                   Eval      PQBEN = PGBENAM
005800110822
005900110909      * Update user entered amounts
006000110909     C                   Exsr      UPDAMTS
006100101116
006200101116      * Get Rule
006300101116     C                   eval      webpay = #pchain(pgtrs:pgsub:pgact:pgssn)
006400101116
006500101116      * Get Coverage Level
006600101203     C                   Eval      CovLevel = #getclvl(pgtrs:pgsub:pgact:
006700101116     C                                        pgssn:pgpln:pgcat)
006800101117
006900101117      * Add/Term
007000101117     C                   Select
007100101117     C                   When      PGSTART <> *Zeros
007200101117     C                   Eval      W80DATE = PGSTART
007300101117     C                   When      PGSTOP  <> *Zeros
007400101117     C                   Eval      W80DATE = PGSTOP
007500110803     C                   Other
007600110803     C                   eval      PGSTART = %int(%char(%date : *iso0))
007700110803     C                   Eval      W80DATE = PGSTART
007800101117     C                   Endsl
007900101116
008000101116      * Get P/C Code
008100101116
008200101116      * Standard Payroll Deductions
008300101116     C     PDKEYAMT      Setll     PAYDEDL1
008400101116     C     PDKEYAMT      Reade     PAYDEDL1
008500101116     C                   Dow       not %eof(PAYDEDL1)
008600101116     C                   If        %trim(pybpc) = %trim(pdrule) and
008700101116     C                             %trim(pgctp) = %trim(pdcvtp)
008800101117     C                   If        W80DATE >= pdbedt and
008900101117     C                             W80DATE <= pdendt
009000101116     C                   Eval      PQPCMT = PDPCMT
009100101116     C                   End
009200101116     C                   End
009300101116     C     PDKEYAMT      Reade     PAYDEDL1
009400101116     C                   Enddo
009500101116
009600101116      * Ancillary Payroll Deductions
009700101116     C     PDKEYAMT      Setll     PAYDEDANL1
009800101116     C     PDKEYAMT      Reade     PAYDEDANL1
009900101116     C                   Dow       not %eof(PAYDEDANL1)
010000101116     C                   If        %trim(pybpc) = %trim(parule)
010100101117     C                   If        W80DATE >= pabedt and
010200101117     C                             W80DATE <= paendt
010300101116     C                   Eval      PQPCMT = PAPCMT
010400101116     C                   End
010500101116     C                   End
010600101116     C     PDKEYAMT      Reade     PAYDEDANL1
010700101116     C                   Enddo
010800101116
010900101116     C     PDKEYAMT      Klist
011000101116     C                   Kfld                    PGTRS
011100101116     C                   Kfld                    PGSUB
011200101116     C                   Kfld                    PGPLN
011300101116
011400110728      * Start/Stop Date - If Salary, use salary chg date
011500101117     C                   Select
011600110727     C                   When      WWSAL = 'Y'
011700110803     C                   move      pgstart       wiso
011800110803     C     *usa          move      wiso          pqstart
011900110803     C                   Eval      pqstop = *zeros
012000110909     C                   When      WWSAL = 'R'
012100110909     C                   move      pgstart       wiso
012200110909     C     *usa          move      wiso          pqstart
012300110909     C                   Eval      pqstop = *zeros
012400101117     C                   When      PGSTART <> *Zeros
012500101116     C                   If        PQPCMT = 'P'
012600101116     C                   move      pgstart       wiso
012700101116     C                   Subdur    1:*M          wiso
012800101116     C     *usa          move      wiso          pqstart
012900101116     C                   Eval      pqstop = *zeros
013000101116     C                   Else
013100101116     C                   move      pgstart       wiso
013200101116     C     *usa          move      wiso          pqstart
013300101116     C                   Eval      pqstop = *zeros
013400101116     C                   End
013500101117     C                   When      PGSTOP  <> *Zeros
013600101117     C                   If        PQPCMT = 'P'
013700101117     C                   move      pgstop        wiso
013800101117     C                   Subdur    1:*M          wiso
013900101117     C     *usa          move      wiso          pqstop
014000101117     C                   Eval      pqstart = *zeros
014100101117     C                   Else
014200101117     C                   move      pgstop        wiso
014300101117     C     *usa          move      wiso          pqstop
014400101117     C                   Eval      pqstart = *zeros
014500101117     C                   End
014600101117     C                   Endsl
014700101116
014800101105      * Check New Hire
014900160418     C                   eval      NewHire = #chknhr(PGTRS:PGSUB:PGACT:PGSSN:'')
015000101105
015100101105      * Recalculate Deductions
015200101116     C                   Eval      PayDed = #getded(pgtrs:pgsub:pgact:
015300101116     C                                        pgssn:pgseq:pgpln:pgcat:
015400160418     C                                        CovLevel:PGSTART:newhire:'')
015500101105
015600101105      * Update Deductions
015700101112     C                   Eval      pqdamt = dsdamt
015800101112     C                   Eval      pqpcmt = dspcmt
015900101116     C                   Eval      pqpdcd = dspdcd
016000101116     C                   Eval      pqssid = 'BLDPAYDEDR'
016100110909
016200110909      * If now no deduction, send as STOP
016300110909     C                   If        SavAmt > 0 and
016400110909     C                             pqdamt = 0
016500110909     C                   Eval      pqdamt = SavAmt
016600110909     C                   Eval      pqstop = pqstart
016700110909     C                   Eval      pqstart = 0
016800110909     C                   End
016900101116
017000101116      * Create Deductions
017100101116     C                   Eval      wwrtn = #dwrite(webded)
017200101116
017300101116     C                   Eval      *inlr = *on
017400101116     C                   Return
017500110822      *___________________________________________________________________
017600110822      * Update 401 %
017700110822      *___________________________________________________________________
017800110909     C     UPDAMTS       BEGSR
017900110822
018000110822     C     KEYARC        Klist
018100110822     C                   Kfld                    PQTRS
018200110822     C                   Kfld                    PQSUB
018300110822     C                   Kfld                    PQACT
018400110822     C                   Kfld                    PQSSN
018500110822     C                   Kfld                    PQSEQ
018600110822     C                   Kfld                    PQCAT
018700110822     C                   Kfld                    PQPLN
018800110909
018900110909     C                   Eval      SavAmt = 0
019000110822
019100110822     C     KEYARC        Setgt     WEBPAYARC
019200110822     C     KEYARC        Readpe    WEBPAYARC
019300110822     C                   Dow       not %eof(WEBPAYARC)
019400110822     C                   Select
019500110822     C                   When      P1_PQSTOP <> 0
019600110909     C                   Eval      PQ401P = 0
019700110909     C                   Eval      PQ401K = 0
019800110909     C                   Eval      PQFSAM = 0
019900110909     C                   Eval      PQFSAD = 0
020000110909     C                   Eval      PQFSAP = 0
020100110909     C                   Eval      PQFSAT = 0
020200110909     C                   Eval      PQHSA  = 0
020300110909     C                   Eval      PQHSACH= 0
020400110909     C                   Eval      PQBEN  = 0
020500110822     C                   Leave
020600110909     C                   When      P1_PQSTOP = 0
020700110909     C                   Eval      PQ401P = P1_PQ401P
020800110909     C                   Eval      PQ401K = P1_PQ401K
020900110909     C                   Eval      PQFSAM = P1_PQFSAM
021000110909     C                   Eval      PQFSAD = P1_PQFSAD
021100110909     C                   Eval      PQFSAP = P1_PQFSAP
021200110909     C                   Eval      PQFSAT = P1_PQFSAT
021300110909     C                   Eval      PQHSA  = P1_PQHSA
021400110909     C                   Eval      PQHSACH = P1_PQHSACH
021500110909     C                   Eval      PQBEN  = P1_PQBEN
021600110909     C                   Eval      SavAmt = P1_PQDAMT
021700110909     C                   Leave
021800110822     C                   Endsl
021900110822     C     KEYARC        Readpe    WEBPAYARC
022000110822     C                   Enddo
022100110822
022200110822     C     KEYARC        Chain     WEBPAYDED
022300110822     C                   If        %found(WEBPAYDED)
022400110909     C                   Eval      Q1_PQ401P = PQ401P
022500110909     C                   Eval      Q1_PQ401K = PQ401K
022600110909     C                   Eval      Q1_PQFSAM = PQFSAM
022700110909     C                   Eval      Q1_PQFSAD = PQFSAD
022800110909     C                   Eval      Q1_PQFSAP = PQFSAP
022900110909     C                   Eval      Q1_PQFSAT = PQFSAT
023000110909     C                   Eval      Q1_PQHSA  = PQHSA
023100110909     C                   Eval      Q1_PQHSACH = PQHSACH
023200110909     C                   Eval      Q1_PQBEN  = PQBEN
023300110822     C                   Update    WEBPAYDDR
023400110822     C                   End
023500110822
023600110822     C                   ENDSR
023700101105
023800061122      *--------------------------------------------------------------*
023900101105     C     *inzsr        Begsr
024000101105
024100061122     C                   Endsr
