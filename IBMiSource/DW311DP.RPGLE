000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  DW310 Preprocessor - LOAD DW310PF
000400041202      *
000500041202      *  LOAD all MEMBER Plans for trnmit record.
000600000000      *
000700000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000800090819
000900000000      *    Created by:  JALLEN - November 11, 2002
001000000000      *_________________________________________________________________________
001100021111     FDW310JF   IP   E           K DISK
001200090408     FDCOVC     IF   E           K DISK    Prefix(O_)
001300040415     FPLNMST    IF   E           K DISK    Prefix(P_)
001400040415     FCARMST    IF   E           K DISK    Prefix(C_)
001500091124     FDW311TRK  IF   E           K DISK
001600021111     FDW310PF   O  A E           K DISK
001700040416      *
001800090408     D W_SEQ#          s                   like(O_DSEQ#)   inz
001900090408     D W_DWACCT        s                   like(DWACCT)    inz
002000090408     D W_DWCOVT        s                   like(DWCOVT)    inz
002100090408      *
002200040416     D W90DATE1        S               d   datfmt(*ISO)
002300040416     D W90DATE2        S               d   datfmt(*ISO)
002400040416     D W90DAYS         S              5S 0 inz
002500041202     D WWDATE          S              8S 0 inz
002600041202     D COUNT           S              2S 0 inz
002700090430     D COUNTT          S              2S 0 inz
002800090331     D Pos             s              2S 0 inz
002900090331     D X               s              2S 0 inz
003000091112     D W_CAT           s              3    inz
003100091124     D TSENT           s              1A   inz
003101120411     D W8ALPHA         s              8a   inz
003102120411     D W80DATE         s              8s 0 inz
003200090408      *
003300090430     D W_MCOV        E DS                  EXTNAME(MCOV) Prefix(W_) inz
003400090430     D W_DCOV        E DS                  EXTNAME(DCOV) Prefix(W_) inz
003500090331      *
003600090331     D W_PLANS         DS                  OCCURS(20)
003700090331     D APLN                    1     80A   DIM(20)
003800021203      *
003900021111     IJOINR         01
004000090819     I                                          SOCSOC        L4
004100090819     I                                          DEPSEQ        L4
004200110718     I                                          DPLAN#        L2
004300090408      *
004400090408     C     ' ':'0'       xlate     DEPSEQ        DEPSEQ
004500090408     C                   move      DEPSEQ        W_SEQ#
004600090331      *
004700090408     C     DepKey        KLIST
004800090408     C                   KFLD                    SOCSOC
004900090408     C                   KFLD                    W_SEQ#
005000091112      *
005100091112     C     CatKey        KLIST
005200091112     C                   KFLD                    TRUST
005300091112     C                   KFLD                    SUBNO
005400110718     C                   KFLD                    DPLAN#
005500090408      *
005600090331     C     PlanKey       KLIST
005700090408     C                   KFLD                    O_DVTRST
005800090408     C                   KFLD                    O_DVSUB#
005900090408     C                   KFLD                    O_DVPlan
006000090331      *
006100090331     C   L2              Exsr      LoadPlans
006200090331      *
006300090819     CL4                 Exsr      LoadPlans2
006400090331      *-------------------------------------------------------------*
006500090331     C     LoadPlans     Begsr
006600090331      *-------------------------------------------------------------*
006700041202      * Get the Member Coverages because even when trnmit only
006800041202      * has a dependent record the member must have this plan too.
006900091112      *
007000091112      * First, get the plan category
007100091112     C     CatKey        Chain     PLNMST
007200091112     C                   If        %Found(PLNMST)
007300091112     C                   Eval      W_CAT = %trim(P_PLNCAT)
007400091112     C                   Else
007500091112     C                   Eval      W_CAT = *BLANKS
007600091112     C                   End
007700041130      *
007800090430     C                   Eval      Count  = 0
007900090430     C                   Eval      Countt = 0
008000090430     C                   Eval      X      = 0
008100090408      * Find tranmit plan dcov records (depend)
008200090408     C     DEPKEY        Setgt     DCOVC
008300090408     C     DEPKEY        Readpe    DCOVC                                  50
008400021111     C     *IN50         Doweq     *OFF
008500041130      *
008600090430      * If same plan as tranmit file
008700091112      * Get the Active Plan (if any)
008800110718     C                   If        DPLAN# = O_DVPLAN  and
008900091112     C                             O_CCANDT =  0
009000041202      *
009100021111     C     PlanKey       Chain     PLNMST
009200090604     C                   If        %Found     and
009300090604     C                             P_SFADM <> 'Y'
009400040415     C     P_PCARR       Chain     CARMST
009500040415     C                   If        %Found    and
009600040415     C                             C_CARBC = 'D'
009700021203     C                   Eval      DWSSNO = SOCSOC
009800090408     C                   Eval      DWSEQ# = W_SEQ#
009900021111     C                   Eval      DWPCAT = P_PLNCAT
009901120411      * DR only
009902120411     C                   Select
009903120411     C                   When      %trim(ACTCOD) = 'DR'
009904120411     C                   Move      TFILL04       W8ALPHA
009905120411     C     ' ':'0'       Xlate     W8ALPHA       W8ALPHA
009906120411     C                   move      W8ALPHA       W80DATE
009907120411     C                   If        W80DATE <> *ZEROS
009908120411     C                   Eval      DWENRL = W80DATE
009909120411     C                   Else
009910120411     C                   Eval      DWENRL = O_DENRDT
009911120411     C                   End
009912120411     C                   Other
009913120411     C                   Eval      DWENRL = O_DENRDT
009914120411     C                   Endsl
009915120411      *
010100090408     C                   Eval      DWCAND = O_CCANDT
010200021111     C                   Eval      DWTRST = P_PLTRST
010300021111     C                   Eval      DWSUB# = P_PLSUB#
010400021202     C                   Eval      DWPLAN = P_PLPLAN
010500021111     C                   Eval      DWPCAR = P_PCARR
010600021111     C                   Write     DW310R
010700090819      *
010800090819      * Save Plan
010900110718     C                   Eval      pos = %lookup(DPLAN#:APLN)
011000090819     C                   If        pos = 0
011100090819     C                   Eval      x   = x  + 1
011200110718     C                   Eval      APLN(x) = DPLAN#
011300090819     C                   End
011400090331      *
011500090408     C                   Eval      W_ENRLDT = O_DENRDT
011600090408     C                   Eval      W_CANDT  = O_CCANDT
011700091112      *
011800091112     C                   Leave
011900090408      *
012000091112     C                   End
012100040416     C                   End
012200090430     C                   End
012300091112      *
012400090408     C     DEPKEY        Readpe    DCOVC                                  50
012500021111     C                   Enddo
012600091112      *
012700100114     C                   Eval      TSENT = *BLANKS
012800091112      * Find a Term (skip same day terms)
012900091112     C     DEPKEY        Setgt     DCOVC
013000091112     C     DEPKEY        Readpe    DCOVC                                  50
013100091112     C     *IN50         Doweq     *OFF
013200091112      *
013300091124      * If Term, same cat, eff <> trm
013400091124      * If Same Day Term, same cat, same plan, eff = trm, sent as active,
013500091124     C                   If        O_CCANDT <> 0
013600091124      *
013700091124     C                   Select
013800110715     C                   When      O_CCANDT <> O_DENRDT and
013801110718     C                             DPLAN# = O_DVPLAN
013900091124     C                   Exsr      LoadTerms
014000091124     C                   When      O_CCANDT =  O_DENRDT and
014100110718     C                             DPLAN# = O_DVPLAN
014200091124     C     TRKKEY        Chain     DW311TRK
014300091124     C                   If        %found(DW311TRK)
014400091124     C                   Exsr      LoadTerms
014500091124     C                   End
014600091124     C                   Endsl
014700091124
014800091124     C                   If        TSENT = 'Y'
014900091124     C                   Leave
015000091124     C                   End
015100091124
015200091124     C                   End
015300091112      *
015400091112     C     DEPKEY        Readpe    DCOVC                                  50
015500091112     C                   Enddo
015600091112      *
015700091124      *
015800091124     C     TRKKEY        Klist
015900091124     C                   Kfld                    O_SSNO
016000091124     C                   Kfld                    O_DSEQ#
016100091124     C                   Kfld                    O_DVPLAN
016200091124     C                   Kfld                    O_DENRDT
016300090331      *
016400090331     C                   Endsr
016500091124      *-------------------------------------------------------------*
016600091124     C     LoadTerms     Begsr
016700090819      *-------------------------------------------------------------*
016800091124
016900091124     C     PlanKey       Chain     PLNMST
017000091124     C                   If        %Found          and
017100091124     C                             P_SFADM <> 'Y'  and
017200091124     C                             W_CAT   =  P_PLNCAT
017300091124     C     P_PCARR       Chain     CARMST
017400091124     C                   If        %Found    and
017500091124     C                             C_CARBC = 'D'
017600091124     C                   Eval      DWSSNO = SOCSOC
017700091124     C                   Eval      DWSEQ# = W_SEQ#
017800091124     C                   Eval      DWPCAT = P_PLNCAT
017900091124     C                   Eval      DWENRL = O_DENRDT
018000091124     C                   Eval      DWCAND = O_CCANDT
018100091124     C                   Eval      DWTRST = P_PLTRST
018200091124     C                   Eval      DWSUB# = P_PLSUB#
018300091124     C                   Eval      DWPLAN = P_PLPLAN
018400091124     C                   Eval      DWPCAR = P_PCARR
018500091124     C                   Write     DW310R
018600091124     C                   Eval      TSENT = 'Y'
018700091124     C                   End
018800091124     C                   End
018900091124
019000091124     C                   Endsr
019100091124      *-------------------------------------------------------------*
019200090819     C     LoadPlans2    Begsr
019300090819      *-------------------------------------------------------------*
019400090819      * Load remaining ACTIVE coverages
019500090819      *
019600090819     C                   Eval      X     = 0
019700090819      * Find tranmit plan dcov records (depend)
019800090819     C     DEPKEY        Setgt     DCOVC
019900090819     C     DEPKEY        Readpe    DCOVC                                  50
020000090819     C     *IN50         Doweq     *OFF
020100090819      *
020200090819     C                   Eval      pos = %lookup(O_DVPLAN:APLN)
020300090819     C                   If        pos     = 0 and
020400090819     C                             O_CCANDT = 0
020500090819      *
020600090819     C     PlanKey       Chain     PLNMST
020700090819     C                   If        %Found     and
020800090819     C                             P_SFADM <> 'Y'
020900090819     C     P_PCARR       Chain     CARMST
021000090819     C                   If        %Found    and
021100090819     C                             C_CARBC = 'D'
021200090819     C                   Eval      DWSSNO = SOCSOC
021300090819     C                   Eval      DWSEQ# = W_SEQ#
021400090819     C                   Eval      DWPCAT = P_PLNCAT
021500090819     C                   Eval      DWENRL = O_DENRDT
021600090819     C                   Eval      DWCAND = O_CCANDT
021700090819     C                   Eval      DWTRST = P_PLTRST
021800090819     C                   Eval      DWSUB# = P_PLSUB#
021900090819     C                   Eval      DWPLAN = P_PLPLAN
022000090819     C                   Eval      DWPCAR = P_PCARR
022100090819     C                   Write     DW310R
022200090819     C                   End
022300090819     C                   End
022400090819     C                   End
022500090819      *
022600090819     C     DEPKEY        Readpe    DCOVC                                  50
022700090819     C                   Enddo
022800090819      *
022900090819     C     1             do        20            x
023000090819     C     x             occur     W_PLANS
023100090819     C                   Clear                   APLN
023200090819     C                   enddo
023300090819      *
023400090819     C                   Endsr
