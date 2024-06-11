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
001100021203     FMCOV      IF   E           K DISK    Prefix(O_)
001200141211     FMCOVC     IF   E           K DISK    extfile('F.MCOVC') rename(mcovr:mcor)
001300141211     F                                     Prefix(D_)
001400040415     FPLNMST    IF   E           K DISK    Prefix(P_)
001500091124     FCARMST    IF   E           K DISK    Prefix(C_)
001600091124     FDW311TRK  IF   E           K DISK
001700021111     FDW310PF   O  A E           K DISK
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
003000160718     D X_test        E DS                  EXTNAME(DW310JF)
003100090430     D W_MCOV        E DS                  EXTNAME(MCOV) Prefix(W_) inz
003200090331      *
003300090331     D W_PLANS         DS                  OCCURS(20)
003400090331     D APLN                    1     80A   DIM(20)
003500021203      *
003600090331     C     PlanKey       KLIST
003700090331     C                   KFLD                    O_MCTRST
003800090331     C                   KFLD                    O_MCSUB#
003900090331     C                   KFLD                    O_MCPlan
004000091112      *
004100091112     C     CatKey        KLIST
004200091112     C                   KFLD                    TRUST
004300091112     C                   KFLD                    SUBNO
004400091112     C                   KFLD                    PLAN#
004500090331      *
004600160718     C                   Exsr      LoadPlans
004700090331      *
004800160718     C*4                 Exsr      LoadPlans2
004900160718     C                   eval      *inlr = *on
005000160718     C                   return
005100160718
005200090331      *-------------------------------------------------------------*
005300090331     C     LoadPlans     Begsr
005400090331      *-------------------------------------------------------------*
005500041202      * Get the Member Coverages because even when trnmit only
005600041202      * has a dependent record the member must have this plan too.
005700091112      *
005800160718     C                   eval      TRUST = 003
005900160718     C                   eval      SUBNO = 001
006000160718     C                   eval      PLAN# = 'DBNV'
006100160718     C                   eval      SOCSOC = 214503177
006200160718      *
006300091112      * First, get the plan category
006400091112     C     CatKey        Chain     PLNMST
006500091112     C                   If        %Found(PLNMST)
006600091112     C                   Eval      W_CAT = %trim(P_PLNCAT)
006700091112     C                   Else
006800091112     C                   Eval      W_CAT = *BLANKS
006900091112     C                   End
007000041130      *
007100090430     C                   Eval      Count  = 0
007200090430     C                   Eval      Countt = 0
007300090430     C                   Eval      X      = 0
007400041202      * Find tranmit plan mcov records (member)
007500041202     C     SOCSOC        Setgt     MCOV
007600041202     C     SOCSOC        Readpe    MCOV                                   50
007700021111     C     *IN50         Doweq     *OFF
007800041130      *
007900090430      * If same plan as tranmit file
008000091112      * Get the Active Plan (if any)
008100091112     C                   If        PLAN# = O_MCPLAN  and
008200091112     C                             O_CANDT =  0
008300041202      *
008400021111     C     PlanKey       Chain     PLNMST
008500090604     C                   If        %Found     and
008600090604     C                             P_SFADM <> 'Y'
008700040415     C     P_PCARR       Chain     CARMST
008800040415     C                   If        %Found    and
008900040415     C                             C_CARBC = 'D'
009000021203     C                   Eval      DWSSNO = SOCSOC
009100021203     C                   Eval      DWSEQ# = 0
009200021111     C                   Eval      DWPCAT = P_PLNCAT
009300110928     C                   If        %trim(ACTCOD) = 'MR' and
009400110928     C                             ENRLDT <> 0
009500110928     C                   Eval      DWENRL = ENRLDT
009600110928     C                   Eval      DWCAND = 0
009700110928     C                   Else
009800021111     C                   Eval      DWENRL = O_ENRLDT
009900110928     C                   Eval      DWCAND = O_CANDT
010000110928     C                   End
010100021111     C                   Eval      DWTRST = P_PLTRST
010200021111     C                   Eval      DWSUB# = P_PLSUB#
010300021202     C                   Eval      DWPLAN = P_PLPLAN
010400021202     C                   Eval      DWACCT = O_ACC#
010500021111     C                   Eval      DWPCAR = P_PCARR
010600021111     C                   Eval      DWCOVT = O_MCOVTP
010700021111     C                   Write     DW310R
010800041202     C                   Eval      Count = Count + 1
010900090331      *
011000090331      * Save Plan
011100090331     C                   Eval      pos = %lookup(PLAN#:APLN)
011200090331     C                   If        pos = 0
011300090331     C                   Eval      x   = x  + 1
011400090331     C                   Eval      APLN(x) = PLAN#
011500090331     C                   End
011600090331      *
011700090408     C                   Eval      W_ENRLDT = O_ENRLDT
011800090408     C                   Eval      W_CANDT  = O_CANDT
011900090408      *
012000091112     C                   Leave
012100040415     C                   End
012200040416     C                   End
012300091112     C                   End
012400090408
012500041202     C     SOCSOC        Readpe    MCOV                                   50
012600021111     C                   Enddo
012700091124      *
012800091124     C                   Eval      TSENT = *BLANKS
012900091112      * Find tranmit plan mcov records (member)
013000091112     C     SOCSOC        Setgt     MCOV
013100091112     C     SOCSOC        Readpe    MCOV                                   50
013200091112     C     *IN50         Doweq     *OFF
013300091112      *
013400091124      * If Term, same cat, eff <> trm
013500091124      * If Same Day Term, same cat, same plan, eff = trm, sent as active,
013600091124     C                   If        O_CANDT <> 0
013700091124      *
013800091124     C                   Select
013900091124     C                   When      O_CANDT <> O_ENRLDT
014000091124     C                   Exsr      LoadTerms
014100091124     C                   When      O_CANDT =  O_ENRLDT and
014200091124     C                             PLAN# = O_MCPLAN
014300091124     C     TRKKEY        Chain     DW311TRK
014400091124     C                   If        %found(DW311TRK)
014500091124     C                   Exsr      LoadTerms
014600091124     C                   End
014700091124     C                   Endsl
014800091124
014900091124     C                   If        TSENT = 'Y'
015000091124     C                   Leave
015100091124     C                   End
015200091112
015300091124     C                   End
015400091112     C     SOCSOC        Readpe    MCOV                                   50
015500091112     C                   Enddo
015600091124      *
015700091124     C     TRKKEY        Klist
015800091124     C                   Kfld                    O_MCSSNO
015900091124     C                   Kfld                    O_MDSEQ#
016000091124     C                   Kfld                    O_MCPLAN
016100091124     C                   Kfld                    O_ENRLDT
016200090331      *
016300090331     C                   Endsr
016400091124      *-------------------------------------------------------------*
016500091124     C     LoadTerms     Begsr
016600091124
016700091124     C     PlanKey       Chain     PLNMST
016800091124     C                   If        %Found          and
016900091124     C                             P_SFADM <> 'Y'  and
017000091124     C                             W_CAT   =  P_PLNCAT
017100091124     C     P_PCARR       Chain     CARMST
017200091124     C                   If        %Found    and
017300091124     C                             C_CARBC = 'D'
017400091124     C                   Eval      DWSSNO = SOCSOC
017500091124     C                   Eval      DWSEQ# = 0
017600091124     C                   Eval      DWPCAT = P_PLNCAT
017700091124     C                   Eval      DWENRL = O_ENRLDT
017800091124     C                   Eval      DWCAND = O_CANDT
017900091124     C                   Eval      DWTRST = P_PLTRST
018000091124     C                   Eval      DWSUB# = P_PLSUB#
018100091124     C                   Eval      DWPLAN = P_PLPLAN
018200091124     C                   Eval      DWACCT = O_ACC#
018300091124     C                   Eval      DWPCAR = P_PCARR
018400091124     C                   Eval      DWCOVT = O_MCOVTP
018500141211     C                   Exsr      doublechk
018600091124     C                   Write     DW310R
018700091124     C                   Eval      TSENT = 'Y'
018800091124     C                   End
018900091124     C                   End
019000091124     C                   Endsr
019100141211      *-------------------------------------------------------------*
019200141211     C     doublechk     Begsr
019300141211      *-------------------------------------------------------------*
019400141211
019500141211      * we are looking for another term where selected effective
019600141211      * date is within another records range (weird situation)
019700141211
019800141211     C     dblkey        klist
019900141211     C                   kfld                    dwssno
020000141211     C                   kfld                    dwseq#
020100141211     C                   kfld                    dwtrst
020200141211     C                   kfld                    dwsub#
020300141211     C                   kfld                    dwplan
020400141211
020500141211     C     dblkey        Setgt     MCOVC
020600141211     C     dblkey        Readpe    MCOVC                                  52
020700141211     C     *IN52         Doweq     *OFF
020800141211      *
020900141211      * Skip the selected record
021000141211     C                   If        DWENRL  <> D_ENRLDT  and
021100141211     C                             DWCAND  <> D_CANDT
021200141211
021300141211      * If selected record if found in antoher records range, use new
021400141231      * do not look at candt = because of last day of  month logic -1 day
021500141211     C                   If        DWENRL  >= D_ENRLDT  and
021600141231     C                             DWENRL  <  D_CANDT
021700141211     C                   Eval      DWENRL = D_ENRLDT
021800141211     C                   Eval      DWCAND = D_CANDT
021900141211     C                   Eval      DWACCT = D_ACC#
022000141211     C                   Eval      DWCOVT = D_MCOVTP
022100141211     C                   LeaveSR
022200141211     C                   End
022300141211     C                   End
022400141211      *
022500141211     C     dblkey        Readpe    MCOVC                                  52
022600141211     C                   Enddo
022700141211
022800141211     C                   Endsr
022900090331      *-------------------------------------------------------------*
023000090331     C     LoadPlans2    Begsr
023100090331      *-------------------------------------------------------------*
023200090430      * Load remaining ACTIVE coverages
023300090331      *
023400090331     C                   Eval      X     = 0
023500090331      * Find tranmit plan mcov records (member)
023600090331     C     SOCSOC        Setgt     MCOV
023700090331     C     SOCSOC        Readpe    MCOV                                   50
023800090331     C     *IN50         Doweq     *OFF
023900090331      *
024000090331     C                   Eval      pos = %lookup(O_MCPLAN:APLN)
024100090331     C                   If        pos     = 0 and
024200090331     C                             O_CANDT = 0
024300090331      *
024400090331     C     PlanKey       Chain     PLNMST
024500090604     C                   If        %Found     and
024600090604     C                             P_SFADM <> 'Y'
024700090331     C     P_PCARR       Chain     CARMST
024800090331     C                   If        %Found    and
024900090331     C                             C_CARBC = 'D'
025000090331     C                   Eval      DWSSNO = SOCSOC
025100090331     C                   Eval      DWSEQ# = 0
025200090331     C                   Eval      DWPCAT = P_PLNCAT
025300110928     C                   If        %trim(ACTCOD) = 'MR'  and
025400110928     C                             ENRLDT <> 0
025500110928     C                   Eval      DWENRL = ENRLDT
025600110928     C                   Eval      DWCAND = 0
025700110928     C                   Else
025800090331     C                   Eval      DWENRL = O_ENRLDT
025900090331     C                   Eval      DWCAND = O_CANDT
026000110928     C                   End
026100090331     C                   Eval      DWTRST = P_PLTRST
026200090331     C                   Eval      DWSUB# = P_PLSUB#
026300090331     C                   Eval      DWPLAN = P_PLPLAN
026400090331     C                   Eval      DWACCT = O_ACC#
026500090331     C                   Eval      DWPCAR = P_PCARR
026600090331     C                   Eval      DWCOVT = O_MCOVTP
026700090331     C                   Write     DW310R
026800090331     C                   End
026900090331     C                   End
027000090331     C                   End
027100090331      *
027200090331     C     SOCSOC        Readpe    MCOV                                   50
027300090331     C                   Enddo
027400090331      *
027500090331     C     1             do        20            x
027600090331     C     x             occur     W_PLANS
027700090331     C                   Clear                   APLN
027800090331     C                   enddo
027900090331      *
028000090331     C                   Endsr
028100090331      *-------------------------------------------------------------*
