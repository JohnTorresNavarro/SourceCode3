0001000503030002 F******************************************************************
0002000808200003 F* db433      GROUP BENEFIT SERVICES, INC.                        *
0003000503030004 F*                                                                *
0004000503030005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000808200006 F*            DATE - 08/20/08                                     *
0006000503030007 F*                                                                *
0007000808200011 F* THIS PROGRAM WILL LIST cobra admin fee plans that do not       *
0008000808200011 F* match the cobra admin fee set up in the account master         *
0009000503030011 F*                                                                *
0010000605250011 F*                                                                *
0011000503030013 F******************************************************************
001200050228      *
0013000808200005 Faccmst    ip   e           k disk
0014000808200005 Fmcovx     if   e           k disk
0015000808200005 Fmember    if   e           k disk
0016000808200005 Fsman      if   e           k disk
0017000502280018 FPLNMST    IF   e           k DISK
0018000808200017 Fdb433xl   o  a e             DISK
0019000808200037 D h_prem          S              7  2
002000050303
0021000503040125 Dcsv              c                   const('","')
0022000503030125 Dsmanname         s             25
0023000503030125 Dmemname          s             20
0024000808200037 D workdt          S               d   datfmt(*iso)
002500080820     D                 dS
0026000808200055 D h_tspabct               1     15
0027000808200055 D h_trust                 1      3  0
0028000808200055 D h_sub                   4      6  0
0029000808200055 D h_plan                  7     10
0030000808200055 D h_ageb                 11     12  0
0031000808200055 D h_covtyp               13     15
003200050302     D                 dS
0033000503020125 D  tsa                    1     10  0
0034000503010125 D  actrst                 1      3  0
0035000503010125 D  acsub#                 4      6  0
0036000503010125 D  acacct                 7     10  0
003700050302     D                udS
0038000503020125 D  ldet                   1      1
0039000503020125 D  lacctot                2      2
0040000503020125 D  lsmantot               3      3
0041000506270125 D  lxnofee                4      4
0042000503030125 D  laa                    5      7
0043000503040125 D  lxl                    8      8
0044000503030054 D  CONAME               201    240
0045000503030055 D  TIME                 242    247  0
0046000503030157 D  UD8YMD               248    255  0
004700050228     iaccmsr
004800050302     i              aacode                      a_aacode
004900050228
005000080820      * format sman name
005100050303     c                   clear                   smanname
005200050301     c     smancd        chain     sman
005300050301     c                   if        %found(sman)
005400050301     c     sfname        cat       slname:1      smanname
005500050301     c                   end
005600050627
005700050228
005800080820      * check all mcov in the acct for active cobra admin fee plans
005900080820     c                   exsr      #chkact
006000050228
006100080820      *********************************************************************
006200080820      * check all mcov in the acct for active cobra admin fee plans       *
006300080820      * and compare the billed rate to the cobra admin fee in the accmst  *
006400080820      *********************************************************************
006500080820
006600050627     c     #chkact       begsr
006700050627
006800050627     c     acckey        setll     mcovx
0069000506270131 C                   dou       %eof(mcovx)
0070000506270132 C     acckey        READE     mcovx
0071000506270133 c                   if        %eof(mcovx) or (enrldt = candt) or
007200050627     c                             (candt <> 0 and candt <= ud8ymd)
007300050627     c                   iter
007400050627     c                   end
007500080820
007600080820      * select cobra admin fee plans
0077000506270171 C     PLNKEY        CHAIN     PLNMST
007800080820     c                   if        not %found(plnmst) or
007900080820     c                             plncat <> 'PCA'
008000080820     c                   iter
008100050627     c                   end
008200050627
008300080820      * get billed rate
008400080820     c                   move      mctrst        h_trust
008500080820     c                   move      mcsub#        h_sub
008600080820     c                   move      mcplan        h_plan
008700080820     c                   move      mcageb        h_ageb
008800080820     c                   move      mcovtp        h_covtyp
008900080820     c                   exsr      #getrate
009000080820
009100080820      * If billed rate <> admin fee in accmst it is an error.
009200080820      * Exception - when admin fee in accmst is negative it is paid by
009300080820      * by the broker so the correct fee for the plan is zero.
009400080820
009500080820     c                   if        h_prem <> cobadm and
009600080820     c                             not(COBADM < 0 and h_prem = 0)
009700080820     c                   clear                   memname
009800080820     c     mcssno        chain     member
009900080820     c                   if        %found(member)
010000080820     c     mfname        cat       mlname:1      memname
010100080820     c                   end
010200080820     C                   exsr      writexldet
010300080820     c                   end
010400080820
010500050627     c                   enddo
010600050627
010700050627     c                   endsr
010800050627
0109000503040313 C*
011000080820      ******************************
011100080820      * get grate
011200080820      ******************************
011300080820     c     #getrate      begsr
0114000808200086 C                   clear                   h_prem
011500080820     c                   clear                   wkbilprem
011600080820
011700080820     c     grplist       plist
011800080820     c                   parm                    parmkey          15
011900140106     C                   PARM                    PARMSSN           9
012000140106     C                   PARM                    PARMSEQ           2
012100080820     c                   parm                    parmeffymd        8
012200080820     c                   parm                    parmbenamt        7
012300080820     c                   parm                    parmgroup        15
012400080820     c                   parm                    parmbilrte       11
012500080820     c                   parm                    parmnetrte       11
012600080820     c                   parm                    parmbilprem       7
012700080820     c                   parm                    parmnetprem       7
012800080820     c                   parm                    parmfound         1
012900140106    *
013000140106     C                   EVAL      PARMSSN = *BLANKS
013100140106     C                   EVAL      PARMSEQ = *BLANKS
013200080820
013300080820     c                   move      h_tspabct     parmkey
013400080820     c                   move      runymd        parmeffymd
013500080820     c                   move      *zeros        parmbenamt
013600080820     c                   clear                   parmgroup
013700080820     c                   clear                   parmbilrte
013800080820     c                   clear                   parmnetrte
013900080820     c                   clear                   parmbilprem
014000080820     c                   clear                   parmnetprem
014100080820     c                   clear                   parmfound
014200080820
014300080820     c                   call      'GETRATE'     grplist
014400080820      * grate returned
0145000808200361 C                   if        parmfound = 'Y'
014600080820     c                   move      parmbilprem   wkbilprem         7 2
014700080820     c                   z-add     wkbilprem     h_prem
014800080820     c                   else
014900080820
015000080820      * no rate found - do second rate search for 1 month less
015100080820     C                   move      runymd        workdt
015200080820     C                   subdur    1:*m          workdt
015300080820     C                   move      workdt        runymd2           8 0
015400080820     c                   move      runymd2       parmeffymd
015500080820     c                   clear                   parmgroup
015600080820     c                   clear                   parmbilrte
015700080820     c                   clear                   parmnetrte
015800080820     c                   clear                   parmbilprem
015900080820     c                   clear                   parmnetprem
016000080820     c                   clear                   parmfound
016100080820
016200080820     c                   call      'GETRATE'     grplist
016300080820
016400080820      * RATES found this time?
0165000808200361 C                   if        parmfound = 'Y'
016600080820     c                   move      parmbilprem   wkbilprem
016700080820     c                   z-add     wkbilprem     h_prem
0168000808200363 C                   end
016900080820
0170000808200089 C                   end
017100080820
0172000808200416 C                   endsr
0173000808200107 C*
0174000808200103 C***************************************************
0175000808200104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0176000808200105 C***************************************************
0177000808200107 C*
0178000808200107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0179000808200107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0180000808200107 C*
0181000808200106 C     #DATYM        BEGSR
018200080820     C                   MOVE      @DATIN        @MD               4 0
018300080820     C                   MOVEL     @DATIN        @Y                4 0
018400080820     C                   MOVEL     @MD           @DATOU            8 0
018500080820     C                   MOVE      @Y            @DATOU
018600080820     C                   MOVE      *ZEROS        @DATIN            8 0
0187000808200120 C                   ENDSR
0188000808200107 C*
018900080820     C*
0190000503040164 C*************************************************************
0191000503040164 C*                                                           *
0192000503040164 C* Write Spreadsheet Detail                                  *
0193000503040164 C*                                                           *
0194000503040164 C*************************************************************
019500050304     C     Writexldet    BEGSR
019600080820
019700080820     C                   MOVE      enrldt        @DATIN
019800080820     C                   EXSR      #DATYM
019900080820     C                   MOVE      @DATOU        enrldtmdy         8 0
020000080820     C                   MOVE      candt         @DATIN
020100080820     C                   EXSR      #DATYM
020200080820     C                   MOVE      @DATOU        candtmdy          8 0
020300050304
020400080820      * missing rate? - error
020500080820     c                   clear                   errorfield       15
020600080820     c                   if        parmfound <> 'Y'
020700080820     c                   eval      errorfield = 'MISSING RATE'
020800080820     c                   end
020900080820
021000080820     c                   clear                   fcstfldes        10
021100080820     c                   select
021200080820     c                   when      fcstfl = 'F'
021300080820     c                   eval      fcstfldes = 'FEDERAL   '
021400080820     c                   when      fcstfl = 'S'
021500080820     c                   eval      fcstfldes = 'STATE     '
021600080820     c                   when      fcstfl = 'N'
021700080820     c                   eval      fcstfldes = 'NONE      '
021800080820     c                   endsl
021900080820
022000080820     c                   clear                   acobsrvdes       15
022100080820     c                   select
022200080820     c                   when      acobsrv = 'F'
022300080820     c                   eval      acobsrvdes = 'FULL SERVICE'
022400080820     c                   when      acobsrv= 'L'
022500080820     c                   eval      acobsrvdes = 'LETTER ONLY '
022600080820     c                   when      acobsrv= 'B'
022700080820     c                   eval      acobsrvdes = 'BILLING ONLY '
022800080820     c                   when      acobsrv= ' '
022900080820     c                   eval      acobsrvdes = 'NO SERVICE   '
023000080820     c                   endsl
023100080820
023200080820     c                   clear                   db433fld
023300080820     C                   Eval      db433fld  = '"' +
023400080820     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
023500080820     C                             %trim(acnam1)                        + csv +
023600050304     C                             %trim(smanname)                      + csv +
023700080820     C                             %trim(fcstfldes)                     + csv +
023800080820     C                             %trim(acobsrvdes)                    + csv +
023900080820     C                             %trim(%editc(cobadm:'L':*cursym))    + csv +
024000080820     C                             %trim(%editc(h_prem:'L':*cursym))    + csv +
024100080820     C                             (mcplan)                             + csv +
024200080820     C                             %trim(pdescr)                        + csv +
024300080820     C                             %trim(%editw(mcssno:'0   -  -    ')) + csv +
024400080820     C                             %trim(memname)                       + csv +
024500080820     C                             %trim(%editw(enrldtmdy:'  /  /    ')) + csv +
024600080820     C                             %trim(%editw(candtmdy:'  /  /    ')) + csv +
024700080820     C                             %trim(errorfield)                    + '",'
024800050304     C*
024900080820     C                   Write     db433xr
0250000503040320 C                   ENDSR
025100050304     C*
025200050304     C/EJECT
025300050304     C*************************************************************
025400050304     C*                                                           *
025500050304     C* Write Spreadsheet heading                                 *
025600050304     C*                                                           *
025700050304     C*************************************************************
025800050304     C     Writexlhead   BEGSR
025900050304
026000080820     c                   clear                   db433fld
026100080820     C                   Eval      db433fld = '"' + 'ACCOUNT #'       + csv +
026200080820     C                                              'ACCOUNT NAME'    + csv +
026300080820     C                                              'SALESMAN NAME'   + csv +
026400080820     C                                              'COBRA FLAG'      + csv +
026500080820     C                                              'COBRA SERVICE'   + csv +
026600080820     C                                              'ADMIN FEE'       + csv +
026700080820     C                                              'PREMIUM BILLED'  + csv +
026800080820     C                                              'PLAN'            + csv +
026900080820     C                                              'PLAN DESC'       + csv +
027000080820     C                                              'MEMBER SSN'      + csv +
027100080820     C                                              'MEMBER NAME'     + csv +
027200080820     C                                              'ENROLL DATE'     + csv +
027300080820     C                                              'CANCEL DATE'     + csv +
027400080820     C                                              'ERROR'           + '",'
027500080820     C                   Write     db433xr
027600050304     C*
0277000503040320 C                   ENDSR
027800050302      *******************************************
027900011126     c     *inzsr        begsr
028000050302      *******************************************
028100050304
028200050304     C                   Exsr      Writexlhead
028300050302
028400050228     c     plnkey        klist
028500050228     c                   kfld                    mctrst
028600050228     c                   kfld                    mcsub#
028700050228     c                   kfld                    mcplan
028800050228     c     acckey        klist
028900011126     c                   kfld                    actrst
029000011126     c                   kfld                    acsub#
029100011126     c                   kfld                    acacct
029200080820
029300080820      * run date = 1st of current month
029400080820     c                   move      ud8ymd        runymd            8 0
029500080820     c                   move      01            runymd
029600011126     c                   endsr
