000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300050302      *             GROUP BENIFIT SERVICES SOFTWARE           2005     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600050302      *  Date Written:  3/2/05                                         *
000700170719      *  Description:   Find Lost Revenue Report - members without a   *
000800170719      *                 life plan in accts that pay for life insurance.*
000901170719      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001400050705      *   7/5/05   szz         Don't show on the audit report if the   *
001500050705      *                         NONEMP field is Y. Per Dave K.         *
001600001106      *                                                                *
001700050728      *   7/28/05  szz         Exclude Cobra per Lisa K.               *
001800050728      *                                                                *
001900051003      *  10/03/05  szz         Exclude Ineligible-for_life from report.*
002000051003      *                                                                *
002100051115      *  11.15.05  dma         Added plan catagory code TL             *
002200051115      *                                                                *
002201060309      *   3/09/06  szz         Determine whether plan is active.       *
002202170719      *  07/19/17  dlk         Remove erroneous plan information and   *
002203170719      *                        printed report.                         *
002204170719      *                                                                *
002300990630      *? ***************************************************************
002400010322
002500050302     FACCMST    IF   E           K Disk
002600050302     FMEMAC#    IF   E           K Disk
002700050302     FMCOV      IF   E           K Disk
002800050302     FPLNMST    IF   E           K Disk
002900050310     FDECLIF    IF   E           K Disk
003000050311     FAACODE    IF   E           K Disk
003001060309     FGRATE     IF   E           K Disk
003100050310     FDB440XL   O  A E             DISK
003300991020
003400010117     D                UDS
003500050310     D  LDet                   1      1
003600050310     D  LAcctot                2      2
003700050310     D  LSmantot               3      3
003800050310     D  LAdminonly             4      4
003900050310     D  LAA                    5      7
004100010118     D  CONAME               201    250
004200991230    ? * Program status data structure
004300991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004400050310     D AgeBand       E DS                  Extname(DECLIF)
004500050310     D  A@FROM                11     50P 0 Dim(20)
004600050310     D  A@TO                  71    110P 0 Dim(20)
004700050310     D                 DS
004800050310     D BIRTH                   1      8  0
004900050310     D  BYR                    1      4  0
005000050310     D  BMO                    5      6  0
005100050302     D MemLifeCtr      S              1  0 Inz
005401060309     D ActivePlan      S              1
005402170719     D notelig         S              1
005403060309    ?D ISOToday        S               D   Datfmt(*ISO)
005404060309     D SixtyDate       S               D   Datfmt(*ISO)
005500050307     DCSV              C                   Const('","')
005600050311     IACCMSR
005700050311     I              AACODE                      A_AACODE
005800050302
005900050302     C                   Read      ACCMST
006000050302    ?C                   Dou       %Eof(ACCMST)
006100050302     C                   If        Not %Eof(ACCMST)
006200050302     C                   If        ATRMDT = *Zeros  Or
006300050302     C                             ATRMDT > Today
006400050308     C                   If        LAdminonly = 'Y'
006500050308     C                   Move      ACTRST        Trust
006600050308     C                   Move      ACSUB#        Sub#
006700050308     C                   Move      ACACCT        Account
006800050310     C                   Clear                   Plan
006900050309     C                   Call      'DB440U'
007000050308     C                   Parm                    Trust             3
007100050308     C                   Parm                    Sub#              3
007200050308     C                   Parm                    Account           4
007300050308     C                   Parm                    HaveLife          1
007400050310     C                   Parm                    Plan              4
008100050308     C                   End
008101170719
008200170719     C                   If        (LAdminonly = 'Y' And HaveLife = 'Y')
008300170719     C                             Or LAdminonly  =  'N'
008400170719
008401170719      * select only accounts with 100% life contribution
008500050302     C                   If        LIFPCT = 100
008600050303     C     KMem          Setll     MEMAC#
008700050302     C                   Dou       %Eof(MEMAC#)
008800050303     C     KMem          Reade     MEMAC#
008900050302     C                   If        Not %Eof(MEMAC#)
009000050302     C                   Eval      MemLifeCtr =  *Zeros
009100051003     C                   Movel     INELIG        INLIFE            1
009200170719     C                   If        NONEMP = *Blanks and
009300170719     C                             EMPST <> 'C' and
009400170719     C                             INLIFE  = *Blanks
009500050302     C                   Exsr      Process
009800050728     C                   End
009900050302     C                   End
010000050302     C                   Enddo
010100050302     C                   End
010200050302     C                   End
010300050302     C                   End
010801170719
011401170719
011500050302     C                   End
011900050302     C                   Read      ACCMST
012000001109    ?C                   Enddo
012001170719
012300050302     C                   Eval      *InLR = *On
012400050302      * ? _____________________________________________________________
012500050302      *? *                                                             *
012600050302      *? *        Process                                              *
012700050302      *? *_____________________________________________________________*
012800050302     C     Process       BEGSR
012900050302    ? *
013000170719     C                   If        (TERMDT = 0 Or TERMDT   >  Today) and
013200170719     C                              CEXPDT = 0
013201170719
013300050303     C     MBSSNO        Setll     MCOV
013400050303     C                   Dou       %Eof(MCOV)
013500050303     C     MBSSNO        Reade     MCOV
013600050303     C                   If        Not %Eof(MCOV)
013700050302     C                   If        CANDT   =  *Zeros Or
013800050302     C                             CANDT   >  Today
013900050302     C     KPln          Chain     PLNMST
014000050302     C                   If        %Found(PLNMST)
014100051115     C                   If        PLNCAT  =  'PLF'  or
014200051115     C                             PLNCAT  =  'PTL'
014201060309     C                   Exsr      DetActPlan
014202060309     C                   If        ActivePlan = 'Y'
014300050302     C                   Add       1             MemLifeCtr
014400050303     C                   Leave
014401060309     C                   End
014500050302     C                   End
014600050302     C                   End
014700050302     C                   End
014800050302     C                   End
014900050303     C                   Enddo
014901170719
015000050311     C                   If        MemLifeCtr <> *Zeros
015100050311     C                   Exsr      DetElgLif
015200050311     C                   End
015201170719
015300050303     C                   If        MemLifeCtr =  *Zeros
015701170719     C     *Year         Sub       BYR           AGE               3 0
015702170719     C     UMONTH        Ifne      12
015703170719     C     UMONTH        Iflt      BMO
015704170719     C                   Sub       1             AGE
015705170719     C                   End
015706170719     C                   End
015707170719      *
015708170719     C     MLNAME        Cat(P)    ',':0         MNAME            23
015709170719     C     MNAME         Cat(P)    MFNAME:1      MNAME
015710170719     C     MNAME         Cat(P)    MMI:1         MNAME
015711170719     C     MNAME         Cat(P)    '.':0         MNAME
015712170719      *
015713170719     C     A_AACODE      Chain     AACODE
015714170719     C                   If        %Found(AACODE)
015715170719     C     AFNAM         Cat(P)    ALNAM:1       AANAME           34
015716170719     C                   Else
015717170719     C                   Eval      AANAME    =   *Blanks
015718170719     C                   End
015801170719
015900170719      * Write to spreadsheet
016100050307     C                   Exsr      WriteXLDet
016700050302     C                   End
016701170719
016702170719     C                   End
016800050302    ? *
016900050302     C                   Endsr
020300050307      * ? _____________________________________________________________
020400050307      *? *                                                             *
020500050307      *? *        Spreadsheet Detail                                   *
020600050307      *? *_____________________________________________________________*
020700050307     C     WriteXLDet    BEGSR
020800050307
020900050309     c                   Clear                   DB440FLD
021000050309     C                   Eval      DB440FLD = '"' +
021100050307     C                             %Editw(ACTRST:'0  ')                 + CSV +
021200050307     C                             %Editw(ACSUB#:'0  ')                 + CSV +
021300050307     C                             %Editw(ACACCT:'0    ')               + CSV +
021400050307     C                             %Trim(ACNAM1)                        + CSV +
021500050311     C                             %Trim(AANAME)                        + CSV +
021600050307     C                             %Trim(MNAME)                         + CSV +
021700050307     C                             %Trim(%Editw(MBSSNO:'0   -  -    ')) + CSV +
022100050310     C                             %Editw(AGE:'0  ')                    + CSV +
022200050311     C                             %Trim(NOTELIG)                       + CSV +
022300050307     C                             '",'
022400050307     C*
022500050309     C                   Write     DB440R
022600050310     C                   ENDSR
022700050307     C*
022800050310    ? *
022900050310      * ? _______________________________________________________________
023000050310      *? *                                                               *
023100050310      *? * Determine if Member is Eligible for Life by checking dec life *
023200050310      *? *_______________________________________________________________*
023300050310     C     DetElgLif     BEGSR
023400050310      *
023500050310     C     KPln          Chain     DECLIF
023600050310     C                   If        %Found(DECLIF)
023700050310     C                   Z-add     *Zeros        X                 3 0
023800050310     C                   For       X       =     20 DownTo 1
023900050311     C**************     Z-add     *zeros        TOPAGEBND
024000050311     C                   Eval      NOTELIG   =   ' '
024100050310     C                   If        A@FROM(X) <>  *Zero
024200050311     C                   If        A@TO(X)   <   AGE
024300050311     C                   Eval      NOTELIG   =   '*'
024400050311     C**************     Z-add     A@TO(X)       TOPAGEBND
024500050311     C                   End
024600050310     C                   Leave
024700050310     C                   End
024800050310     C                   EndFor
024900050311     C                   Else
025000050311     C***************    Z-add     *Zeros        TOPAGEBND
025100050310     C                   End
025200050310      *
025300050310     C                   Endsr
025400050307     C/EJECT
025500050307      * ? _____________________________________________________________
025600050307      *? *                                                             *
025700050307      *? *        Spreadsheet Heading                                  *
025800050307      *? *_____________________________________________________________*
025900050307     C     WriteXLHead   BEGSR
026000050307
026100050309     c                   Clear                   DB440FLD
026200050311     C                   Eval      DB440FLD = '"' + 'TRUST'         + csv +
026300050311     C                                        'SUB'                 + csv +
026400050311     C                                        'ACCOUNT'             + csv +
026500050311     C                                        'ACCOUNT NAME'        + csv +
026600050311     C                                        'ACCT ADMINISTRATOR'  + csv +
026700050311     C                                        'MEMBER NAME'         + csv +
026800050311     C                                        'MEMBER#'             + csv +
027200050311     C                                        'AGE'                 + csv +
027300050311     C                                        'NOT ELIG'            + '",'
027400050309     C                   Write     DB440R
027500050307     C*
027600050310     C                   ENDSR
027601060309      * ? _____________________________________________________________
027602060309      *? *                                                             *
027603060309      *? *        Determine if plan is active by checking rate dates   *
027604060309      *? *_____________________________________________________________*
027605060309     C     DetActPlan    Begsr
027606060309     C                   Eval      ActivePlan =  'N'
027607060309     C     GRTKey        Setll     GRATE
027608060309     C     GRTKey        Reade     GRATE
027609060309     C                   Dow       Not %Eof(GRATE)
027610060309     C                   If        Not %Eof(GRATE)
027611060309     C                   If        (FRMDAT    <= Today       And
027612060309     C                             TODAT      >= Today)       Or
027613060309     C                             (FRMDAT    <= SixtyDays   And
027614060309     C                             TODAT      >= SixtyDays)
027615060309     C                   Eval      ActivePlan  = 'Y'
027616060309     C                   LeaveSR
027617060309     C                   End
027618060309     C                   End
027619060309     C     GRTKey        Reade     GRATE
027620060309     C                   Enddo
027621060309     C                   Endsr
027700000118      * ? _____________________________________________________________
027800000118      *? *                                                             *
027900000118      *? *        Initialize.                                          *
028000000118      *? *_____________________________________________________________*
028100050302     C     *Inzsr        Begsr
028200050302      *
028300050302     C     KMem          KLIST
028400050303     C                   KFLD                    ACTRST
028500050303     C                   KFLD                    ACSUB#
028600050303     C                   KFLD                    ACACCT
028700050302      *
028800050302     C     KPln          KLIST
028900050302     C                   KFLD                    ACTRST
029000050302     C                   KFLD                    ACSUB#
029100050302     C                   KFLD                    MCPLAN
029200050617     C*
029300050617     C     PKey          KLIST
029400050617     C                   KFLD                    ACTRST
029500050617     C                   KFLD                    ACSUB#
029600050617     C                   KFLD                    Plan
029700050617     C*
029701060309     C     GRTKey        Klist
029702060309     C                   Kfld                    PLTRST
029703060309     C                   Kfld                    PLSUB#
029704060309     C                   Kfld                    PLPLAN
029705060309      *
029800050302     C     *DATE         Mult      10000.0001    Today             8 0
029900050302     C                   Movel     Today         ThisYear          4
029901060309     c     *ISO          Move      Today         ISOToday
029902060309     c     ISOToday      Subdur    60:*d         SixtyDate
029903060309     c                   Move      SixtyDate     SixtyDays         8 0
030400050307     C                   Exsr      WriteXLHead
030600050302     C
030700050302     C                   Endsr
