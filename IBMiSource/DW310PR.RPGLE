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
001300040415     FPLNMST    IF   E           K DISK    Prefix(P_)
001400040415     FCARMST    IF   E           K DISK    Prefix(C_)
001500021111     FDW310PF   O  A E           K DISK
001600040416      *
001700040416     D W90DATE1        S               d   datfmt(*ISO)
001800040416     D W90DATE2        S               d   datfmt(*ISO)
001900040416     D W90DAYS         S              5S 0 inz
002000041202     D WWDATE          S              8S 0 inz
002100041202     D COUNT           S              2S 0 inz
002200021203      *
002300021111     IJOINR         01
002400041202     I                                          SOCSOC        L2
002500041202     I                                          PLAN#         L2
002600021111      *
002700041202      * Get the Member Coverages because even when trnmit only
002800041202      * has a dependent record the member must have this plan too.
002900041202     C   L2              Do
003000041130      *
003100041202     C                   Eval      Count = 0
003200041202      * Find tranmit plan mcov records (member)
003300041202     C     SOCSOC        Setgt     MCOV
003400041202     C     SOCSOC        Readpe    MCOV                                   50
003500021111     C     *IN50         Doweq     *OFF
003600041130      *
003700070501      * If same plan as tranmit file (send same-day-terms) 5/1/07
003800041202     C                   If        PLAN# = O_MCPLAN   and
003900070501     C************************     O_ENRLDT <> O_CANDT and
004000070131     C                             Count < 1
004100041202      *
004200041202      * If tranmit eff date within 90 days, continue
004300041202     C                   Eval      W90DAYS  = 0
004400041202     C**   *DATE         Mult      10000.0001    WWDATE
004500041202     C**   *ISO          Move      WWDATE        W90DATE1
004600041202     C**                 If        O_ENRLDT  <> 0
004700041202     C**   *ISO          Move      O_ENRLDT      W90DATE2
004800041202     C**                 Else
004900041202     C**   W90DATE1      adddur    91:*D         W90DATE2
005000041202     C**                 End
005100041202     C**   W90DATE1      Subdur    W90DATE2      W90DAYS:*D
005200041202     C                   If        W90DAYS   <   90
005300040416      *
005400021111     C     PlanKey       Chain     PLNMST
005500090604     C                   If        %Found     and
005600090604     C                             P_SFADM <> 'Y'
005700040415     C     P_PCARR       Chain     CARMST
005800040415     C                   If        %Found    and
005900040415     C                             C_CARBC = 'D'
006000021203     C                   Eval      DWSSNO = SOCSOC
006100021203     C                   Eval      DWSEQ# = 0
006200021111     C                   Eval      DWPCAT = P_PLNCAT
006300021111     C                   Eval      DWENRL = O_ENRLDT
006400021111     C                   Eval      DWCAND = O_CANDT
006500021111     C                   Eval      DWTRST = P_PLTRST
006600021111     C                   Eval      DWSUB# = P_PLSUB#
006700021202     C                   Eval      DWPLAN = P_PLPLAN
006800021202     C                   Eval      DWACCT = O_ACC#
006900021111     C                   Eval      DWPCAR = P_PCARR
007000021111     C                   Eval      DWCOVT = O_MCOVTP
007100021111     C                   Write     DW310R
007200041202     C                   Eval      Count = Count + 1
007300040415     C                   End
007400040416     C                   End
007500021111     C                   End
007600041202     C                   End
007700040804      *
007800041202     C     SOCSOC        Readpe    MCOV                                   50
007900021111     C                   Enddo
008000021111     C                   Enddo
008100021203      *
008200021111     C     PlanKey       KLIST
008300021203     C                   KFLD                    O_MCTRST
008400021203     C                   KFLD                    O_MCSUB#
008500021203     C                   KFLD                    O_MCPlan
