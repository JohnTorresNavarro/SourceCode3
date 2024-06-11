000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  DW310 Preprocessor - LOAD DW310PF
000400041202      *
000500041202      *  LOAD all MEMBER Plans for trnmit record.
000600000000      *
000700000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000800000000      *
000900000000      *    Created by:  JALLEN - November 11, 2002
001000000000      *_________________________________________________________________________
001100021111     FDW310JF   IP   E           K DISK
001200021203     FMCOV      IF   E           K DISK    Prefix(O_)
001300141211     FMCOVC     IF   E           K DISK    extfile('F.MCOVC') rename(mcovr:mcor)
001400141211     F                                     Prefix(D_)
001500040415     FPLNMST    IF   E           K DISK    Prefix(P_)
001600091124     FCARMST    IF   E           K DISK    Prefix(C_)
001700091124     FDW311TRK  IF   E           K DISK
001800021111     FDW310PF   O  A E           K DISK
001900040416      *
002000040416     D W90DATE1        S               d   datfmt(*ISO)
002100040416     D W90DATE2        S               d   datfmt(*ISO)
002200040416     D W90DAYS         S              5S 0 inz
002300041202     D WWDATE          S              8S 0 inz
002400041202     D COUNT           S              2S 0 inz
002500090430     D COUNTT          S              2S 0 inz
002600090331     D Pos             s              2S 0 inz
002700091112     D X               s              2S 0 inz
002800091112     D W_CAT           s              3    inz
002900091124     D TSENT           s              1A   inz
003000090408      *
003100090430     D W_MCOV        E DS                  EXTNAME(MCOV) Prefix(W_) inz
003200090331      *
003300090331     D W_PLANS         DS                  OCCURS(20)
003400090331     D APLN                    1     80A   DIM(20)
003500021203      *
003600021111     IJOINR         01
003700090331     I                                          SOCSOC        L4
003800041202     I                                          PLAN#         L2
003900090331      *
004000090331     C     PlanKey       KLIST
004100090331     C                   KFLD                    O_MCTRST
004200090331     C                   KFLD                    O_MCSUB#
004300090331     C                   KFLD                    O_MCPlan
004400091112      *
004500091112     C     CatKey        KLIST
004600091112     C                   KFLD                    TRUST
004700091112     C                   KFLD                    SUBNO
004800091112     C                   KFLD                    PLAN#
004900090331      *
005000090331     C   L2              Exsr      LoadPlans
005100090331      *
005200090331     CL4                 Exsr      LoadPlans2
005300090331      *-------------------------------------------------------------*
005400090331     C     LoadPlans     Begsr
005500090331      *-------------------------------------------------------------*
005600041202      * Get the Member Coverages because even when trnmit only
005700041202      * has a dependent record the member must have this plan too.
005800091112      *
005900091112      * First, get the plan category
006000091112     C     CatKey        Chain     PLNMST
006100091112     C                   If        %Found(PLNMST)
006200091112     C                   Eval      W_CAT = %trim(P_PLNCAT)
006300091112     C                   Else
006400091112     C                   Eval      W_CAT = *BLANKS
006500091112     C                   End
006600041130      *
006700090430     C                   Eval      Count  = 0
006800090430     C                   Eval      Countt = 0
006900090430     C                   Eval      X      = 0
007000041202      * Find tranmit plan mcov records (member)
007100041202     C     SOCSOC        Setgt     MCOV
007200041202     C     SOCSOC        Readpe    MCOV                                   50
007300021111     C     *IN50         Doweq     *OFF
007400041130      *
007500090430      * If same plan as tranmit file
007600091112      * Get the Active Plan (if any)
007700091112     C                   If        PLAN# = O_MCPLAN  and
007800091112     C                             O_CANDT =  0
007900041202      *
008000021111     C     PlanKey       Chain     PLNMST
008100090604     C                   If        %Found     and
008200090604     C                             P_SFADM <> 'Y'
008300040415     C     P_PCARR       Chain     CARMST
008400040415     C                   If        %Found    and
008500040415     C                             C_CARBC = 'D'
008600021203     C                   Eval      DWSSNO = SOCSOC
008700021203     C                   Eval      DWSEQ# = 0
008800021111     C                   Eval      DWPCAT = P_PLNCAT
008900110928     C                   If        %trim(ACTCOD) = 'MR' and
009000110928     C                             ENRLDT <> 0
009100110928     C                   Eval      DWENRL = ENRLDT
009200110928     C                   Eval      DWCAND = 0
009300110928     C                   Else
009400021111     C                   Eval      DWENRL = O_ENRLDT
009500110928     C                   Eval      DWCAND = O_CANDT
009600110928     C                   End
009700021111     C                   Eval      DWTRST = P_PLTRST
009800021111     C                   Eval      DWSUB# = P_PLSUB#
009900021202     C                   Eval      DWPLAN = P_PLPLAN
010000021202     C                   Eval      DWACCT = O_ACC#
010100021111     C                   Eval      DWPCAR = P_PCARR
010200021111     C                   Eval      DWCOVT = O_MCOVTP
010300021111     C                   Write     DW310R
010400041202     C                   Eval      Count = Count + 1
010500090331      *
010600090331      * Save Plan
010700090331     C                   Eval      pos = %lookup(PLAN#:APLN)
010800090331     C                   If        pos = 0
010900090331     C                   Eval      x   = x  + 1
011000090331     C                   Eval      APLN(x) = PLAN#
011100090331     C                   End
011200090331      *
011300090408     C                   Eval      W_ENRLDT = O_ENRLDT
011400090408     C                   Eval      W_CANDT  = O_CANDT
011500090408      *
011600091112     C                   Leave
011700040415     C                   End
011800040416     C                   End
011900091112     C                   End
012000090408
012100041202     C     SOCSOC        Readpe    MCOV                                   50
012200021111     C                   Enddo
012300091124      *
012400091124     C                   Eval      TSENT = *BLANKS
012500091112      * Find tranmit plan mcov records (member)
012600091112     C     SOCSOC        Setgt     MCOV
012700091112     C     SOCSOC        Readpe    MCOV                                   50
012800091112     C     *IN50         Doweq     *OFF
012900091112      *
013000091124      * If Term, same cat, eff <> trm
013100091124      * If Same Day Term, same cat, same plan, eff = trm, sent as active,
013200091124     C                   If        O_CANDT <> 0
013300091124      *
013400091124     C                   Select
013500091124     C                   When      O_CANDT <> O_ENRLDT
013600091124     C                   Exsr      LoadTerms
013700091124     C                   When      O_CANDT =  O_ENRLDT and
013800091124     C                             PLAN# = O_MCPLAN
013900091124     C     TRKKEY        Chain     DW311TRK
014000091124     C                   If        %found(DW311TRK)
014100091124     C                   Exsr      LoadTerms
014200091124     C                   End
014300091124     C                   Endsl
014400091124
014500091124     C                   If        TSENT = 'Y'
014600091124     C                   Leave
014700091124     C                   End
014800091112
014900091124     C                   End
015000091112     C     SOCSOC        Readpe    MCOV                                   50
015100091112     C                   Enddo
015200091124      *
015300091124     C     TRKKEY        Klist
015400091124     C                   Kfld                    O_MCSSNO
015500091124     C                   Kfld                    O_MDSEQ#
015600091124     C                   Kfld                    O_MCPLAN
015700091124     C                   Kfld                    O_ENRLDT
015800090331      *
015900090331     C                   Endsr
016000091124      *-------------------------------------------------------------*
016100091124     C     LoadTerms     Begsr
016200091124
016300091124     C     PlanKey       Chain     PLNMST
016400091124     C                   If        %Found          and
016500091124     C                             P_SFADM <> 'Y'  and
016600091124     C                             W_CAT   =  P_PLNCAT
016700091124     C     P_PCARR       Chain     CARMST
016800091124     C                   If        %Found    and
016900091124     C                             C_CARBC = 'D'
017000091124     C                   Eval      DWSSNO = SOCSOC
017100091124     C                   Eval      DWSEQ# = 0
017200091124     C                   Eval      DWPCAT = P_PLNCAT
017300091124     C                   Eval      DWENRL = O_ENRLDT
017400091124     C                   Eval      DWCAND = O_CANDT
017500091124     C                   Eval      DWTRST = P_PLTRST
017600091124     C                   Eval      DWSUB# = P_PLSUB#
017700091124     C                   Eval      DWPLAN = P_PLPLAN
017800091124     C                   Eval      DWACCT = O_ACC#
017900091124     C                   Eval      DWPCAR = P_PCARR
018000091124     C                   Eval      DWCOVT = O_MCOVTP
018100141211     C                   Exsr      doublechk
018200091124     C                   Write     DW310R
018300091124     C                   Eval      TSENT = 'Y'
018400091124     C                   End
018500091124     C                   End
018600091124     C                   Endsr
018700141211      *-------------------------------------------------------------*
018800141211     C     doublechk     Begsr
018900141211      *-------------------------------------------------------------*
019000141211
019100141211      * we are looking for another term where selected effective
019200141211      * date is within another records range (weird situation)
019300141211
019400141211     C     dblkey        klist
019500141211     C                   kfld                    dwssno
019600141211     C                   kfld                    dwseq#
019700141211     C                   kfld                    dwtrst
019800141211     C                   kfld                    dwsub#
019900141211     C                   kfld                    dwplan
020000141211
020100141211     C     dblkey        Setgt     MCOVC
020200141211     C     dblkey        Readpe    MCOVC                                  52
020300141211     C     *IN52         Doweq     *OFF
020400141211      *
020500141211      * Skip the selected record
020600141211     C                   If        DWENRL  <> D_ENRLDT  and
020700141211     C                             DWCAND  <> D_CANDT
020800141211
020900141211      * If selected record if found in antoher records range, use new
021000141231      * do not look at candt = because of last day of  month logic -1 day
021100141211     C                   If        DWENRL  >= D_ENRLDT  and
021200141231     C                             DWENRL  <  D_CANDT
021300141211     C                   Eval      DWENRL = D_ENRLDT
021400141211     C                   Eval      DWCAND = D_CANDT
021500141211     C                   Eval      DWACCT = D_ACC#
021600141211     C                   Eval      DWCOVT = D_MCOVTP
021700141211     C                   LeaveSR
021800141211     C                   End
021900141211     C                   End
022000141211      *
022100141211     C     dblkey        Readpe    MCOVC                                  52
022200141211     C                   Enddo
022300141211
022400141211     C                   Endsr
022500090331      *-------------------------------------------------------------*
022600090331     C     LoadPlans2    Begsr
022700090331      *-------------------------------------------------------------*
022800090430      * Load remaining ACTIVE coverages
022900090331      *
023000090331     C                   Eval      X     = 0
023100090331      * Find tranmit plan mcov records (member)
023200090331     C     SOCSOC        Setgt     MCOV
023300090331     C     SOCSOC        Readpe    MCOV                                   50
023400090331     C     *IN50         Doweq     *OFF
023500090331      *
023600090331     C                   Eval      pos = %lookup(O_MCPLAN:APLN)
023700090331     C                   If        pos     = 0 and
023800090331     C                             O_CANDT = 0
023900090331      *
024000090331     C     PlanKey       Chain     PLNMST
024100090604     C                   If        %Found     and
024200090604     C                             P_SFADM <> 'Y'
024300090331     C     P_PCARR       Chain     CARMST
024400090331     C                   If        %Found    and
024500090331     C                             C_CARBC = 'D'
024600090331     C                   Eval      DWSSNO = SOCSOC
024700090331     C                   Eval      DWSEQ# = 0
024800090331     C                   Eval      DWPCAT = P_PLNCAT
024900110928     C                   If        %trim(ACTCOD) = 'MR'  and
025000110928     C                             ENRLDT <> 0
025100110928     C                   Eval      DWENRL = ENRLDT
025200110928     C                   Eval      DWCAND = 0
025300110928     C                   Else
025400090331     C                   Eval      DWENRL = O_ENRLDT
025500090331     C                   Eval      DWCAND = O_CANDT
025600110928     C                   End
025700090331     C                   Eval      DWTRST = P_PLTRST
025800090331     C                   Eval      DWSUB# = P_PLSUB#
025900090331     C                   Eval      DWPLAN = P_PLPLAN
026000090331     C                   Eval      DWACCT = O_ACC#
026100090331     C                   Eval      DWPCAR = P_PCARR
026200090331     C                   Eval      DWCOVT = O_MCOVTP
026300090331     C                   Write     DW310R
026400090331     C                   End
026500090331     C                   End
026600090331     C                   End
026700090331      *
026800090331     C     SOCSOC        Readpe    MCOV                                   50
026900090331     C                   Enddo
027000090331      *
027100090331     C     1             do        20            x
027200090331     C     x             occur     W_PLANS
027300090331     C                   Clear                   APLN
027400090331     C                   enddo
027500090331      *
027600090331     C                   Endsr
027700090331      *-------------------------------------------------------------*
