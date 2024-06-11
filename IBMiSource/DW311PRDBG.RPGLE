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
001100141211     FMCOV      IF   E           K DISK    Prefix(O_)
001200141211     FMCOVC     IF   E           K DISK    extfile('F.MCOVC') rename(mcovr:mcor)
001300141211     F                                     Prefix(D_)
001400040415     FPLNMST    IF   E           K DISK    Prefix(P_)
001500091124     FCARMST    IF   E           K DISK    Prefix(C_)
001600091124     FDW311TRK  IF   E           K DISK
001700130618     FDW310PFDBGO  A E           K DISK
001800040416      *
001900040416     D W90DATE1        S               d   datfmt(*ISO)
002000040416     D W90DATE2        S               d   datfmt(*ISO)
002100040416     D W90DAYS         S              5S 0 inz
002200041202     D WWDATE          S              8S 0 inz
002300041202     D COUNT           S              2S 0 inz
002400090430     D COUNTT          S              2S 0 inz
002500090331     D Pos             s              2S 0 inz
002600091112     D X               s              2S 0 inz
002700091112     D W_CAT           s              3    inz
002800091124     D TSENT           s              1A   inz
002900090408      *
003000130618     D X_DS310JF     E DS                  EXTNAME(DW310JF) inz
003100090430     D W_MCOV        E DS                  EXTNAME(MCOV) Prefix(W_) inz
003200090331      *
003300090331     D W_PLANS         DS                  OCCURS(20)
003400090331     D APLN                    1     80A   DIM(20)
003500021203      *
003600130618     I*OINR         01
003700130618     I*                                         SOCSOC        L4
003800130618     I*                                         PLAN#         L2
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
004900130618      *
005000141231     C                   Eval      TRUST = 580
005100141231     C                   Eval      SUBNO = 012
005200141231     C                   Eval      PLAN# = 'CAAA'
005300141231     C                   Eval      SOCSOC = 219989913
005400090331      *
005500130618     C                   Exsr      LoadPlans
005600090331      *
005700130618     C                   Exsr      LoadPlans2
005800130618      *
005900130618     C                   Eval      *inlr = *on
006000130618     C                   Return
006100090331      *-------------------------------------------------------------*
006200090331     C     LoadPlans     Begsr
006300090331      *-------------------------------------------------------------*
006400041202      * Get the Member Coverages because even when trnmit only
006500041202      * has a dependent record the member must have this plan too.
006600091112      *
006700091112      * First, get the plan category
006800091112     C     CatKey        Chain     PLNMST
006900091112     C                   If        %Found(PLNMST)
007000091112     C                   Eval      W_CAT = %trim(P_PLNCAT)
007100091112     C                   Else
007200091112     C                   Eval      W_CAT = *BLANKS
007300091112     C                   End
007400041130      *
007500090430     C                   Eval      Count  = 0
007600090430     C                   Eval      Countt = 0
007700090430     C                   Eval      X      = 0
007800041202      * Find tranmit plan mcov records (member)
007900041202     C     SOCSOC        Setgt     MCOV
008000041202     C     SOCSOC        Readpe    MCOV                                   50
008100021111     C     *IN50         Doweq     *OFF
008200041130      *
008300090430      * If same plan as tranmit file
008400091112      * Get the Active Plan (if any)
008500091112     C                   If        PLAN# = O_MCPLAN  and
008600091112     C                             O_CANDT =  0
008700041202      *
008800021111     C     PlanKey       Chain     PLNMST
008900090604     C                   If        %Found     and
009000090604     C                             P_SFADM <> 'Y'
009100040415     C     P_PCARR       Chain     CARMST
009200040415     C                   If        %Found    and
009300040415     C                             C_CARBC = 'D'
009400021203     C                   Eval      DWSSNO = SOCSOC
009500021203     C                   Eval      DWSEQ# = 0
009600021111     C                   Eval      DWPCAT = P_PLNCAT
009700110928     C                   If        %trim(ACTCOD) = 'MR' and
009800110928     C                             ENRLDT <> 0
009900110928     C                   Eval      DWENRL = ENRLDT
010000110928     C                   Eval      DWCAND = 0
010100110928     C                   Else
010200021111     C                   Eval      DWENRL = O_ENRLDT
010300110928     C                   Eval      DWCAND = O_CANDT
010400110928     C                   End
010500021111     C                   Eval      DWTRST = P_PLTRST
010600021111     C                   Eval      DWSUB# = P_PLSUB#
010700021202     C                   Eval      DWPLAN = P_PLPLAN
010800021202     C                   Eval      DWACCT = O_ACC#
010900021111     C                   Eval      DWPCAR = P_PCARR
011000021111     C                   Eval      DWCOVT = O_MCOVTP
011100021111     C                   Write     DW310R
011200041202     C                   Eval      Count = Count + 1
011300090331      *
011400090331      * Save Plan
011500090331     C                   Eval      pos = %lookup(PLAN#:APLN)
011600090331     C                   If        pos = 0
011700090331     C                   Eval      x   = x  + 1
011800090331     C                   Eval      APLN(x) = PLAN#
011900090331     C                   End
012000090331      *
012100090408     C                   Eval      W_ENRLDT = O_ENRLDT
012200090408     C                   Eval      W_CANDT  = O_CANDT
012300090408      *
012400091112     C                   Leave
012500040415     C                   End
012600040416     C                   End
012700091112     C                   End
012800090408
012900041202     C     SOCSOC        Readpe    MCOV                                   50
013000021111     C                   Enddo
013100091124      *
013200091124     C                   Eval      TSENT = *BLANKS
013300091112      * Find tranmit plan mcov records (member)
013400141211     C     SOCSOC        Setgt     MCOV
013500141211     C     SOCSOC        Readpe    MCOV                                   50
013600091112     C     *IN50         Doweq     *OFF
013700091112      *
013800091124      * If Term, same cat, eff <> trm
013900091124      * If Same Day Term, same cat, same plan, eff = trm, sent as active,
014000091124     C                   If        O_CANDT <> 0
014100091124      *
014200091124     C                   Select
014300091124     C                   When      O_CANDT <> O_ENRLDT
014400091124     C                   Exsr      LoadTerms
014500091124     C                   When      O_CANDT =  O_ENRLDT and
014600091124     C                             PLAN# = O_MCPLAN
014700091124     C     TRKKEY        Chain     DW311TRK
014800091124     C                   If        %found(DW311TRK)
014900091124     C                   Exsr      LoadTerms
015000091124     C                   End
015100091124     C                   Endsl
015200091124
015300091124     C                   If        TSENT = 'Y'
015400091124     C                   Leave
015500091124     C                   End
015600091112
015700091124     C                   End
015800141211     C     SOCSOC        Readpe    MCOV                                   50
015900091112     C                   Enddo
016000091124      *
016100091124     C     TRKKEY        Klist
016200091124     C                   Kfld                    O_MCSSNO
016300091124     C                   Kfld                    O_MDSEQ#
016400091124     C                   Kfld                    O_MCPLAN
016500091124     C                   Kfld                    O_ENRLDT
016600090331      *
016700090331     C                   Endsr
016800091124      *-------------------------------------------------------------*
016900091124     C     LoadTerms     Begsr
017000091124
017100091124     C     PlanKey       Chain     PLNMST
017200091124     C                   If        %Found          and
017300091124     C                             P_SFADM <> 'Y'  and
017400091124     C                             W_CAT   =  P_PLNCAT
017500091124     C     P_PCARR       Chain     CARMST
017600091124     C                   If        %Found    and
017700091124     C                             C_CARBC = 'D'
017800091124     C                   Eval      DWSSNO = SOCSOC
017900091124     C                   Eval      DWSEQ# = 0
018000091124     C                   Eval      DWPCAT = P_PLNCAT
018100091124     C                   Eval      DWENRL = O_ENRLDT
018200091124     C                   Eval      DWCAND = O_CANDT
018300091124     C                   Eval      DWTRST = P_PLTRST
018400091124     C                   Eval      DWSUB# = P_PLSUB#
018500091124     C                   Eval      DWPLAN = P_PLPLAN
018600091124     C                   Eval      DWACCT = O_ACC#
018700091124     C                   Eval      DWPCAR = P_PCARR
018800091124     C                   Eval      DWCOVT = O_MCOVTP
018900141211     C                   Exsr      doublechk
019000091124     C                   Write     DW310R
019100091124     C                   Eval      TSENT = 'Y'
019200091124     C                   End
019300091124     C                   End
019400091124     C                   Endsr
019500091124      *-------------------------------------------------------------*
019600141211     C     doublechk     Begsr
019700141211      *-------------------------------------------------------------*
019800141211
019900141211      * we are looking for another term where selected effective
020000141211      * date is within another records range (weird situation)
020100141211
020200141211     C     dblkey        klist
020300141211     C                   kfld                    dwssno
020400141211     C                   kfld                    dwseq#
020500141211     C                   kfld                    dwtrst
020600141211     C                   kfld                    dwsub#
020700141211     C     PlanKey2      KLIST
020800141211     C                   KFLD                    D_MCTRST
020900141211     C                   KFLD                    D_MCSUB#
021000141211     C                   KFLD                    D_MCPlan
021100141211
021200141211     C     dblkey        Setgt     MCOVC
021300141211     C     dblkey        Readpe    MCOVC                                  52
021400141211     C     *IN52         Doweq     *OFF
021500141211
021600141211      * look at all plans with same category
021700141211     C     PlanKey2      Chain     PLNMST
021800141211     C                   If        %Found          and
021900141211     C                             P_SFADM <> 'Y'  and
022000141211     C                             DWPCAT  =  P_PLNCAT
022100141211     C     P_PCARR       Chain     CARMST
022200141211     C                   If        %Found    and
022300141211     C                             C_CARBC = 'D'
022400141211      *
022500141211      * Skip the selected record
022600141211     C                   If        DWENRL  <> D_ENRLDT  and
022700141211     C                             DWCAND  <> D_CANDT
022800141211
022900141211      * If selected record if found in antoher records range, use new
023000141211     C                   If        DWENRL  >= D_ENRLDT  and
023100141231     C                             DWENRL  <  D_CANDT
023200141211     C                   Eval      DWENRL = D_ENRLDT
023300141211     C                   Eval      DWCAND = D_CANDT
023400141211     C                   Eval      DWACCT = D_ACC#
023500141211     C                   Eval      DWCOVT = D_MCOVTP
023600141211     C                   LeaveSR
023700141211     C                   End
023800141211     C                   End
023900141211     C                   End
024000141211     C                   End
024100141211      *
024200141211     C     dblkey        Readpe    MCOVC                                  52
024300141211     C                   Enddo
024400141211
024500141211     C                   Endsr
024600090331      *-------------------------------------------------------------*
024700090331     C     LoadPlans2    Begsr
024800090331      *-------------------------------------------------------------*
024900090430      * Load remaining ACTIVE coverages
025000090331      *
025100090331     C                   Eval      X     = 0
025200090331      * Find tranmit plan mcov records (member)
025300090331     C     SOCSOC        Setgt     MCOV
025400090331     C     SOCSOC        Readpe    MCOV                                   50
025500090331     C     *IN50         Doweq     *OFF
025600090331      *
025700090331     C                   Eval      pos = %lookup(O_MCPLAN:APLN)
025800090331     C                   If        pos     = 0 and
025900090331     C                             O_CANDT = 0
026000090331      *
026100090331     C     PlanKey       Chain     PLNMST
026200090604     C                   If        %Found     and
026300090604     C                             P_SFADM <> 'Y'
026400090331     C     P_PCARR       Chain     CARMST
026500090331     C                   If        %Found    and
026600090331     C                             C_CARBC = 'D'
026700090331     C                   Eval      DWSSNO = SOCSOC
026800090331     C                   Eval      DWSEQ# = 0
026900090331     C                   Eval      DWPCAT = P_PLNCAT
027000110928     C                   If        %trim(ACTCOD) = 'MR'  and
027100110928     C                             ENRLDT <> 0
027200110928     C                   Eval      DWENRL = ENRLDT
027300110928     C                   Eval      DWCAND = 0
027400110928     C                   Else
027500090331     C                   Eval      DWENRL = O_ENRLDT
027600090331     C                   Eval      DWCAND = O_CANDT
027700110928     C                   End
027800090331     C                   Eval      DWTRST = P_PLTRST
027900090331     C                   Eval      DWSUB# = P_PLSUB#
028000090331     C                   Eval      DWPLAN = P_PLPLAN
028100090331     C                   Eval      DWACCT = O_ACC#
028200090331     C                   Eval      DWPCAR = P_PCARR
028300090331     C                   Eval      DWCOVT = O_MCOVTP
028400090331     C                   Write     DW310R
028500090331     C                   End
028600090331     C                   End
028700090331     C                   End
028800090331      *
028900090331     C     SOCSOC        Readpe    MCOV                                   50
029000090331     C                   Enddo
029100090331      *
029200090331     C     1             do        20            x
029300090331     C     x             occur     W_PLANS
029400090331     C                   Clear                   APLN
029500090331     C                   enddo
029600090331      *
029700090331     C                   Endsr
029800090331      *-------------------------------------------------------------*
