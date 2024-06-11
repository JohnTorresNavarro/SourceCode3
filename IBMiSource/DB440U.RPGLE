000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300050302      *             GROUP BENIFIT SERVICES SOFTWARE           2005     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600050308      *  Date Written:  3/8/05                                         *
000700050308      *  Description:   Find Lost Revenue Utitlity: Determine which    *
000800050308      *                  accounts have at least one member with a      *
000801050308      *                  life plan.                                    *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001302060309      *   3/09.06  szz         Added plan catagory code TL.            *
001400060309      *                        Only accept plan if active or was active*
001500060309      *                         in the last 60 days.                   *
001600001106      *                                                                *
001700990630      *? ***************************************************************
001800010322
001900050302     FACCMST    IF   E           K Disk
001901050302     FMEMAC#    IF   E           K Disk
002000050302     FMCOV      IF   E           K Disk
002100050302     FPLNMST    IF   E           K Disk
002101060309     FGRATE     IF   E           K Disk
002500991230    ? * Program status data structure
002600991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002700001107     D                 DS
002701050302     D MemLifeCtr      S              1  0 Inz
002705050302     D YesLifCtr       S              7  0 Inz
002706050302     D NoLifCtr        S              7  0 Inz
002707050308     D HavePlan        S              1
002708060309     D ActivePlan      S              1
002709060309    ?D ISOToday        S               D   Datfmt(*ISO)
002710060309     D SixtyDate       S               D   Datfmt(*ISO)
006200050308     C     KMem          Chain     ACCMST
006300050308    ?C                   If        %Found(ACCMST)
006401050302     C                   If        ATRMDT = *Zeros  Or
006402050302     C                             ATRMDT > Today
006403050302     C                   If        LIFPCT = 100
006405050303     C     KMem          Setll     MEMAC#
006406050302     C                   Dou       %Eof(MEMAC#)
006407050303     C     KMem          Reade     MEMAC#
006408050302     C                   If        Not %Eof(MEMAC#)
006409050302     C                   Eval      MemLifeCtr =  *Zeros
006410050302     C                   Exsr      Process
006417050302     C                   End
006418050302     C                   Enddo
006420050302     C                   End
008300050302     C                   End
008306050308     C                   If        YesLifCtr  >  *Zeros
008307050308     C                   Eval      HavePlan   =  'Y'
008308050308     C                   Else
008309050308     C                   Eval      HavePlan   =  'N'
008313050302     C                   End
008600050308    ?C                   End
009200050302     C                   Eval      *InLR = *On
009202050302      * ? _____________________________________________________________
009203050302      *? *                                                             *
009204050302      *? *        Process                                              *
009206050302      *? *_____________________________________________________________*
010500050302     C     Process       BEGSR
010601050302    ? *
010602050303     C                   If        (TERMDT  =  *Zeros Or
010603050303     C                             TERMDT   >  Today) And
010604050303     C                             CEXPDT   =  *Zeros
010605050303     C     MBSSNO        Setll     MCOV
010606050303     C                   Dou       %Eof(MCOV)
010607050303     C     MBSSNO        Reade     MCOV
010608050303     C                   If        Not %Eof(MCOV)
010609050302     C                   If        CANDT   =  *Zeros Or
010610050302     C                             CANDT   >  Today
010611050302     C     KPln          Chain     PLNMST
010612050302     C                   If        %Found(PLNMST)
010613060309     C                   If        PLNCAT  =  'PLF'   Or
010614060309     C                             PLNCAT  =  'PTL'
010615060309     C                   Exsr      DetActPlan
010616060309     C                   If        ActivePlan = 'Y'
010617050302     C                   Add       1             MemLifeCtr
010618050303     C                   Leave
010619060309     C                   End
010621050302     C                   End
010622050302     C                   End
010623050302     C                   End
010624050302     C                   End
010631050303     C                   Enddo
010632050303     C                   If        MemLifeCtr =  *Zeros
010633050303     C                   Add       1             NoLifCtr
010641050303     C                   Else
010642050303     C                   Add       1             YesLifCtr
010643050310     C                   Eval      Plan    =     MCPLAN
010644050303     C                   End
010645050302     C                   End
010646050302    ? *
020700050302     C                   Endsr
020701060309      * ? _____________________________________________________________
020702060309      *? *                                                             *
020703060309      *? *        Determine if plan is active by checking rate dates   *
020704060309      *? *_____________________________________________________________*
020705060309     C     DetActPlan    Begsr
020706060309     C                   Eval      ActivePlan =  'N'
020714060309     C     GRTKey        Setll     GRATE
020715060309     C     GRTKey        Reade     GRATE
020716060309     C                   Dow       Not %Eof(GRATE)
020717060309     C                   If        Not %Eof(GRATE)
020718060309     C                   If        (FRMDAT    <= Today       And
020719060309     C                             TODAT      >= Today)       Or
020720060309     C                             (FRMDAT    <= SixtyDays   And
020721060316     C                             TODAT      >= Today)
020722060309     C                   Eval      ActivePlan  = 'Y'
020723060309     C                   LeaveSR
020724060309     C                   End
020725060309     C                   End
020726060309     C     GRTKey        Reade     GRATE
020727060309     C                   Enddo
020728060309     C                   Endsr
029600000118      * ? _____________________________________________________________
029700000118      *? *                                                             *
029800000118      *? *        Initialize.                                          *
029900000118      *? *_____________________________________________________________*
030000050302     C     *Inzsr        Begsr
030001050308      *
030002050308     C     *Entry        Plist
030003050308     C                   Parm                    Trust             3
030004050308     C                   Parm                    Sub               3
030005050308     C                   Parm                    Account           4
030006050308     C                   Parm                    HavePlan          1
030007050310     C                   Parm                    Plan              4
032000050302      *
032100050302     C     KMem          KLIST
032200050308     C                   KFLD                    NTrust            3 0
032300050308     C                   KFLD                    NSub              3 0
032400050308     C                   KFLD                    NAccount          4 0
032407050302      *
032408050302     C     KPln          KLIST
032409050302     C                   KFLD                    ACTRST
032410050302     C                   KFLD                    ACSUB#
032411050302     C                   KFLD                    MCPLAN
032412060309      *
032413060309     C     GRTKey        Klist
032414060309     C                   Kfld                    PLTRST
032415060309     C                   Kfld                    PLSUB#
032416060309     C                   Kfld                    PLPLAN
032419050308      *
032420050308     C                   Move      Trust         NTrust
032421050308     C                   Move      Sub           NSub
032422050308     C                   Move      Account       NAccount
032423050308     C                   Move      'N'           HavePlan
032424050302      *
032501050302     C     *DATE         Mult      10000.0001    Today             8 0
032502050302     C                   Movel     Today         ThisYear          4
032503060309     c     *ISO          Move      Today         ISOToday
032504060309     c     ISOToday      Subdur    60:*d         SixtyDate
032505060309     c                   Move      SixtyDate     SixtyDays         8 0
032700050302     C
032800050302     C                   Endsr
