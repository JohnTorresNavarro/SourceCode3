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
001100091001     FDW310L3   IP   E           K DISK    Prefix(L_)
001200091001     F                                     Rename(DW310R:DW310D)
001300091001     FDW310L2   IF   E           K DISK    Prefix(X_)
001400091001     F                                     Rename(DW310R:DW310X)
001500091001     FDEPEND    IF   E           K DISK    Prefix(D_)
001600090408     FDCOVC     IF   E           K DISK    Prefix(O_)
001700040415     FPLNMST    IF   E           K DISK    Prefix(P_)
001800040415     FCARMST    IF   E           K DISK    Prefix(C_)
001900021111     FDW310PF   O  A E           K DISK
002000090408      *
002100091001     IDW310D        01
002200091001     I                                          L_DWSSNO      L2
002300091001     I                                          L_DWPLAN      L2
002400090331      *
002500091001     C   L2              Exsr      CheckDeps
002600090331      *
002700091001      *-------------------------------------------------------------*
002800091001     C     CheckDeps     Begsr
002900091001      *-------------------------------------------------------------*
003000091001      *
003100091001     C     DEPKEY        KLIST
003200091001     C                   KFLD                    L_DWSSNO
003300091001     C                   KFLD                    D_DPSEQ#
003400091001     C                   KFLD                    L_DWTRST
003500091001     C                   KFLD                    L_DWSUB#
003600091001     C                   KFLD                    L_DWPLAN
003700091001      *
003800091001     C     DEP10K        KLIST
003900091001     C                   KFLD                    L_DWSSNO
004000091001     C                   KFLD                    D_DPSEQ#
004100091001     C                   KFLD                    L_DWPCAT
004200091001     C                   KFLD                    L_DWENRL
004300091001      *
004400091001     C     L_DWSSNO      Setll     DEPEND
004500091001     C     L_DWSSNO      Reade     DEPEND
004600091001     C                   Dow       not %eof(DEPEND)
004700091001     C     DEPKEY        Chain     DCOVC
004800091001     C                   If        %found(DCOVC)
004900091001     C                   If        L_DWCAND = O_CCANDT
005000091001     C     DEP10K        Chain     DW310L2
005100091001     C                   If        not %found(DW310L2)
005200110718     C****               Exsr      CreateDep
005300091001     C                   End
005400091001     C                   End
005500091001     C                   End
005600091001     C     L_DWSSNO      Reade     DEPEND
005700091001     C                   Enddo
005800091001      *
005900091001     C                   Endsr
006000090331      *-------------------------------------------------------------*
006100091001     C     CreateDep     Begsr
006200090331      *-------------------------------------------------------------*
006300091001      *
006400091001     C     PlanKey       KLIST
006500091001     C                   KFLD                    O_DVTRST
006600091001     C                   KFLD                    O_DVSUB#
006700091001     C                   KFLD                    O_DVPlan
006800041202      *
006900021111     C     PlanKey       Chain     PLNMST
007000090604     C                   If        %Found     and
007100090604     C                             P_SFADM <> 'Y'
007200040415     C     P_PCARR       Chain     CARMST
007300040415     C                   If        %Found    and
007400040415     C                             C_CARBC = 'D'
007500091001     C                   Eval      DWSSNO = L_DWSSNO
007600091001     C                   Eval      DWSEQ# = D_DPSEQ#
007700021111     C                   Eval      DWPCAT = P_PLNCAT
007800090408     C                   Eval      DWENRL = O_DENRDT
007900090408     C                   Eval      DWCAND = O_CCANDT
008000021111     C                   Eval      DWTRST = P_PLTRST
008100021111     C                   Eval      DWSUB# = P_PLSUB#
008200021202     C                   Eval      DWPLAN = P_PLPLAN
008300021111     C                   Eval      DWPCAR = P_PCARR
008400021111     C                   Write     DW310R
008500040415     C                   End
008600040416     C                   End
008700090331      *
008800090331     C                   Endsr
