000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  DW310 Preprocessor - LOAD DW310PF
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - November 11, 2002
000800040824      *
000900040824      *    Send ALL dependents not just changes.
001000000000      *_________________________________________________________________________
001100021111     FDW310JF   IP   E           K DISK
001200021111     FPLNMST    IF   E           K DISK    Prefix(P_)
001300021203     FDCOVC     IF   E           K DISK    Prefix(D_)
001400040928     FCARMST    IF   E           K DISK    Prefix(C_)
001500041201     FDW310LF   IF A E           K DISK    rename(dw310r:dwlf)
001600041201     FDW310L2   IF A E           K DISK    rename(dw310r:dwl2)
001700021203      *
001800041201     D B_SEQ#          s                   like(D_DSEQ#)   inz
001900021203     D W_SEQ#          s                   like(D_DSEQ#)   inz
002000021203     D W_DWACCT        s                   like(DWACCT)    inz
002100041201     D W_DWCOVT        s                   like(DWCOVT)    inz
002200041201     D N_DWCOVT        s                   like(DWCOVT)    inz
002300041201     D O_DWCOVT        s                   like(DWCOVT)    inz
002400041201     D DIRECTION       s              6    inz
002500021111      *
002600021111     IJOINR         01
002700041201     I                                          SOCSOC        L2
002800060823     I************TEST                          DEPSEQ        L2
002900041202     I                                          PLAN#         L2
003000021111      *
003100021111      * Get the Member Coverages
003200021111     C   L2              Do
003300041202      *
003400041202      * Get Member coverage direction
003500041202     C                   Eval      W_SEQ# = 0
003600041202     C     PlanKey00     Chain     PLNMST
003700041202     C                   If        %Found
003800041202     C     P_PCARR       Chain     CARMST
003900041202     C                   If        %Found    and
004000041202     C                             C_CARBC = 'D'
004100041202     C                   Exsr      ChkMem
004200041202     C                   End
004300041202     C                   End
004400041201      *
004500041201     C     ' ':'0'       xlate     DEPSEQ        DEPSEQ
004600041201     C                   move      DEPSEQ        W_SEQ#
004700041202      *
004800041202      * If Direction is ...
004900041202     C                   Select
005000041202     C                   When      Direction = '*SAME '
005100041202     C                   Exsr      Create_Same
005200041202     C                   When      Direction = '*UPPER'
005300041202     C                   Exsr      Create_Upper
005400041202     C                   When      Direction = '*LOWER'
005500041202     C                   Exsr      Create_Lower
005600041202     C                   Endsl
005700041202      *
005800041202     C                   Enddo
005900041202      *--------------------------------------------------------------------*
006000041202      * Create SAME
006100041202      *--------------------------------------------------------------------*
006200041202     C     Create_Same   Begsr
006300041202      *
006400041202      * If Dependent TRNMIT
006500060823     C********* TEST     If        W_SEQ# <> 0
006600041202      *
006700041202      * Load Dependents only if plans match tranmit
006800041202     C     DEPKEY        Setll     DCOVC
006900041202     C     DEPKEY        Reade     DCOVC                                  50
007000041202     C     *IN50         Doweq     *OFF
007100070501      * (send same-day-terms) 5/1/07
007200070501     C                   If        PLAN# = D_DVPLAN
007300070501     C**************************   D_DENRDT <> D_CCANDT
007400041202      *
007500041202     C     PlanKey       Chain     PLNMST
007600090604     C                   If        %Found     and
007700090604     C                             P_SFADM <> 'Y'
007800041202     C     P_PCARR       Chain     CARMST
007900041202     C                   If        %Found    and
008000041202     C                             C_CARBC = 'D'
008100041202      *
008200041202     C     CovgKey       Chain     DW310LF
008300041202     C                   If        %Found
008400041202     C                   Eval      W_DWACCT = DWACCT
008500041202     C                   Eval      W_DWCOVT = DWCOVT
008600041202     C                   Eval      DWSSNO = SOCSOC
008700041202     C                   Eval      DWSEQ# = D_DSEQ#
008800041202     C                   Eval      DWPCAT = P_PLNCAT
008900041202     C                   Eval      DWENRL = D_DENRDT
009000041202     C                   Eval      DWCAND = D_CCANDT
009100041202     C                   Eval      DWTRST = P_PLTRST
009200041202     C                   Eval      DWSUB# = P_PLSUB#
009300041202     C                   Eval      DWPLAN = P_PLPLAN
009400041202     C                   Eval      DWPCAR = P_PCARR
009500041202     C                   Eval      DWACCT = W_DWACCT
009600041202     C                   Eval      DWCOVT = W_DWCOVT
009700041202     C                   Write     DWLF
009800041202     C                   Else
009900041202     C     CovgKey       Chain     DW310L2
010000041202     C                   If        %Found
010100041202     C                   Eval      W_DWACCT = DWACCT
010200041202     C                   Eval      W_DWCOVT = DWCOVT
010300041202     C                   Eval      DWSSNO = SOCSOC
010400041202     C                   Eval      DWSEQ# = D_DSEQ#
010500041202     C                   Eval      DWPCAT = P_PLNCAT
010600041202     C                   Eval      DWENRL = D_DENRDT
010700041202     C                   Eval      DWCAND = D_CCANDT
010800041202     C                   Eval      DWTRST = P_PLTRST
010900041202     C                   Eval      DWSUB# = P_PLSUB#
011000041202     C                   Eval      DWPLAN = P_PLPLAN
011100041202     C                   Eval      DWPCAR = P_PCARR
011200041202     C                   Eval      DWACCT = W_DWACCT
011300041202     C                   Eval      DWCOVT = W_DWCOVT
011400041202     C                   Write     DWL2
011500041202     C                   End
011600041202     C                   End
011700041202     C                   End
011800041202     C                   End
011900041202     C                   End
012000041202     C     DEPKEY        Reade     DCOVC                                  50
012100041202     C                   Enddo
012200060823     C*********TEST      End
012300041202      *
012400041202     C                   Endsr
012500041202      *--------------------------------------------------------------------*
012600041202      * Create UPPER
012700041202      *--------------------------------------------------------------------*
012800041202     C     Create_Upper  Begsr
012900041202      *
013000041202      * If Dependent TRNMIT
013100060823     C***********TEST    If        W_SEQ# <> 0
013200041202      *
013300041202      * Load Dependents only if plans match tranmit
013400041202     C     DEPKEY        Setll     DCOVC
013500041202     C     DEPKEY        Reade     DCOVC                                  50
013600041202     C     *IN50         Doweq     *OFF
013700041202      *
013800041202     C                   If        PLAN#    = D_DVPLAN and
013900041202     C                             D_CCANDT = 0
014000041202      *
014100041202     C     PlanKey       Chain     PLNMST
014200090604     C                   If        %Found     and
014300090604     C                             P_SFADM <> 'Y'
014400041202     C     P_PCARR       Chain     CARMST
014500041202     C                   If        %Found    and
014600041202     C                             C_CARBC = 'D'
014700041202      *
014800041202     C     CovgKey       Chain     DW310LF
014900041202     C                   If        %Found
015000041202     C                   Eval      W_DWACCT = DWACCT
015100041202     C                   Eval      W_DWCOVT = DWCOVT
015200041202     C                   Eval      DWSSNO = SOCSOC
015300041202     C                   Eval      DWSEQ# = D_DSEQ#
015400041202     C                   Eval      DWPCAT = P_PLNCAT
015500041202     C                   Eval      DWENRL = D_DENRDT
015600041202     C                   Eval      DWCAND = D_CCANDT
015700041202     C                   Eval      DWTRST = P_PLTRST
015800041202     C                   Eval      DWSUB# = P_PLSUB#
015900041202     C                   Eval      DWPLAN = P_PLPLAN
016000041202     C                   Eval      DWPCAR = P_PCARR
016100041202     C                   Eval      DWACCT = W_DWACCT
016200041202     C                   Eval      DWCOVT = W_DWCOVT
016300041202     C                   Write     DWLF
016400041202     C                   Else
016500041202     C     CovgKey       Chain     DW310L2
016600041202     C                   If        %Found
016700041202     C                   Eval      W_DWACCT = DWACCT
016800041202     C                   Eval      W_DWCOVT = DWCOVT
016900041202     C                   Eval      DWSSNO = SOCSOC
017000041202     C                   Eval      DWSEQ# = D_DSEQ#
017100041202     C                   Eval      DWPCAT = P_PLNCAT
017200041202     C                   Eval      DWENRL = D_DENRDT
017300041202     C                   Eval      DWCAND = D_CCANDT
017400041202     C                   Eval      DWTRST = P_PLTRST
017500041202     C                   Eval      DWSUB# = P_PLSUB#
017600041202     C                   Eval      DWPLAN = P_PLPLAN
017700041202     C                   Eval      DWPCAR = P_PCARR
017800041202     C                   Eval      DWACCT = W_DWACCT
017900041202     C                   Eval      DWCOVT = W_DWCOVT
018000041202     C                   Write     DWL2
018100041202     C                   End
018200041202     C                   End
018300041202     C                   End
018400041202     C                   End
018500041202     C                   End
018600041202     C     DEPKEY        Reade     DCOVC                                  50
018700041202     C                   Enddo
018800060823     C**********TEST     End
018900041202      *
019000041202     C                   Endsr
019100041202      *--------------------------------------------------------------------*
019200041202      * Create LOWER
019300041202      *--------------------------------------------------------------------*
019400041202     C     Create_Lower  Begsr
019500041202      *
019600041202      * If Dependent TRNMIT
019700060823     C*********TEST      If        W_SEQ# <> 0
019800041202      *
019900041202      * Load Dependents only if plans match tranmit
020000041202     C     SOCSOC        Setll     DCOVC
020100041202     C     SOCSOC        Reade     DCOVC                                  50
020200041202     C     *IN50         Doweq     *OFF
020300041202      *
020400041202     C                   If        PLAN#    = D_DVPLAN and
020500041202     C                             D_CCANDT = 0
020600041202      *
020700041202     C     PlanKey       Chain     PLNMST
020800090604     C                   If        %Found     and
020900090604     C                             P_SFADM <> 'Y'
021000041202     C     P_PCARR       Chain     CARMST
021100041202     C                   If        %Found    and
021200041202     C                             C_CARBC = 'D'
021300041202      *
021400041202     C     CovgKey       Chain     DW310LF
021500041202     C                   If        %Found
021600041202     C                   Eval      W_DWACCT = DWACCT
021700041202     C                   Eval      W_DWCOVT = DWCOVT
021800041202     C                   Eval      DWSSNO = SOCSOC
021900041202     C                   Eval      DWSEQ# = D_DSEQ#
022000041202     C                   Eval      DWPCAT = P_PLNCAT
022100041202     C                   Eval      DWENRL = D_DENRDT
022200041202     C                   Eval      DWCAND = D_CCANDT
022300041202     C                   Eval      DWTRST = P_PLTRST
022400041202     C                   Eval      DWSUB# = P_PLSUB#
022500041202     C                   Eval      DWPLAN = P_PLPLAN
022600041202     C                   Eval      DWPCAR = P_PCARR
022700041202     C                   Eval      DWACCT = W_DWACCT
022800041202     C                   Eval      DWCOVT = W_DWCOVT
022900041202     C                   Write     DWLF
023000041202     C                   Else
023100041202     C     CovgKey       Chain     DW310L2
023200041202     C                   If        %Found
023300041202     C                   Eval      W_DWACCT = DWACCT
023400041202     C                   Eval      W_DWCOVT = DWCOVT
023500041202     C                   Eval      DWSSNO = SOCSOC
023600041202     C                   Eval      DWSEQ# = D_DSEQ#
023700041202     C                   Eval      DWPCAT = P_PLNCAT
023800041202     C                   Eval      DWENRL = D_DENRDT
023900041202     C                   Eval      DWCAND = D_CCANDT
024000041202     C                   Eval      DWTRST = P_PLTRST
024100041202     C                   Eval      DWSUB# = P_PLSUB#
024200041202     C                   Eval      DWPLAN = P_PLPLAN
024300041202     C                   Eval      DWPCAR = P_PCARR
024400041202     C                   Eval      DWACCT = W_DWACCT
024500041202     C                   Eval      DWCOVT = W_DWCOVT
024600041202     C                   Write     DWL2
024700041202     C                   End
024800041202     C                   End
024900041202     C                   End
025000041202     C                   End
025100041202     C                   End
025200041202     C     SOCSOC        Reade     DCOVC                                  50
025300041202     C                   Enddo
025400060823     C*********TEST      End
025500041202      *
025600041202     C                   Endsr
025700041201      *--------------------------------------------------------------------*
025800041202      * KLIST
025900041201      *--------------------------------------------------------------------*
026000041202     C     KLIST         Begsr
026100041201      *
026200041201     C     DepKey        KLIST
026300041201     C                   KFLD                    SOCSOC
026400060823     C*********TEST      KFLD                    W_SEQ#
026500021203      *
026600021203     C     PlanKey       KLIST
026700021203     C                   KFLD                    D_DVTRST
026800021203     C                   KFLD                    D_DVSUB#
026900021203     C                   KFLD                    D_DVPlan
027000041201      *
027100041201     C     PlanKey00     KLIST
027200041201     C                   KFLD                    TRUST
027300041201     C                   KFLD                    SUBNO
027400041201     C                   KFLD                    PLAN#
027500021203      *
027600021203     C     CovgKey       KLIST
027700021203     C                   KFLD                    D_SSNO
027800041201     C                   KFLD                    B_SEQ#
027900021203     C                   KFLD                    P_PLNCAT
028000041201      *
028100041201     C     CovgKey00     KLIST
028200041201     C                   KFLD                    SOCSOC
028300041201     C                   KFLD                    B_SEQ#
028400041201     C                   KFLD                    P_PLNCAT
028500041201     C                   Endsr
028600041201      *--------------------------------------------------------------------*
028700041202      * Check member coverage direction
028800041201      *--------------------------------------------------------------------*
028900041202     C     ChkMem        Begsr
029000041201     C                   Clear                   N_DWCOVT
029100041201     C                   Clear                   O_DWCOVT
029200041201     C                   Clear                   DIRECTION
029300041201     C     CovgKey00     Chain     DW310LF
029400041201     C                   If        %Found
029500041201     C                   Eval      N_DWCOVT = DWCOVT
029600041201     C                   End
029700041201     C     CovgKey00     Chain     DW310L2
029800041201     C                   If        %Found
029900041201     C                   Eval      O_DWCOVT = DWCOVT
030000041201     C                   End
030100041201     C                   Select
030200070125     C                   When      O_DWCOVT = 'TIN' and
030300070125     C                             N_DWCOVT = 'TP2'
030400070125     C                   Eval      Direction = '*UPPER'
030500041201     C                   When      O_DWCOVT = 'TIN' and
030600041201     C                             N_DWCOVT = 'TPC'
030700041201     C                   Eval      Direction = '*UPPER'
030800041201     C                   When      O_DWCOVT = 'TIN' and
030900041201     C                             N_DWCOVT = 'THW'
031000041201     C                   Eval      Direction = '*UPPER'
031100041201     C                   When      O_DWCOVT = 'TIN' and
031200041201     C                             N_DWCOVT = 'TFA'
031300041201     C                   Eval      Direction = '*UPPER'
031400041201     C                   When      O_DWCOVT = 'TPC' and
031500041201     C                             N_DWCOVT = 'TFA'
031600041201     C                   Eval      Direction = '*UPPER'
031700041201     C                   When      O_DWCOVT = 'THW' and
031800041201     C                             N_DWCOVT = 'TFA'
031900041201     C                   Eval      Direction = '*UPPER'
032000041201     C                   When      O_DWCOVT = 'TFA' and
032100041201     C                             N_DWCOVT = 'THW'
032200041201     C                   Eval      Direction = '*LOWER'
032300041201     C                   When      O_DWCOVT = 'TFA' and
032400041201     C                             N_DWCOVT = 'TPC'
032500041201     C                   Eval      Direction = '*LOWER'
032600070125     C                   When      O_DWCOVT = 'TFA' and
032700070125     C                             N_DWCOVT = 'TP2'
032800070125     C                   Eval      Direction = '*LOWER'
032900041201     C                   When      O_DWCOVT = 'TFA' and
033000041201     C                             N_DWCOVT = 'TIN'
033100041201     C                   Eval      Direction = '*LOWER'
033200041201     C                   When      O_DWCOVT = 'THW' and
033300041201     C                             N_DWCOVT = 'TIN'
033400041201     C                   Eval      Direction = '*LOWER'
033500041201     C                   When      O_DWCOVT = 'TPC' and
033600041201     C                             N_DWCOVT = 'TIN'
033700041201     C                   Eval      Direction = '*LOWER'
033800070125     C                   When      O_DWCOVT = 'TP2' and
033900070125     C                             N_DWCOVT = 'TIN'
034000070125     C                   Eval      Direction = '*LOWER'
034100041201     C                   Other
034200041201     C                   Eval      Direction = '*SAME '
034300041201     C                   Endsl
034400041201     C                   Endsr
