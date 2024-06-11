000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Get Member Original CFS Effective Date
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 18, 2009
000800000000      *_________________________________________________________________________
000900090618     FMCOV      IF   E           K DISK
001000090618     FPLNMST    IF   E           K DISK
001100090618     FCARMST    IF   E           K DISK
001200090618
001300090618     D P_SSN           S              9A
001400090618     D P_ORG           S              8A
001500090618     D W_SSN           S              9S 0
001600090618     D W_ORG           S              8S 0
001700090618
001800090618     C     *ENTRY        PLIST
001900090618     C                   PARM                    P_SSN
002000090618     C                   PARM                    P_ORG
002100090618
002200090618     C                   MOVE      P_SSN         W_SSN
002300090618     C                   EVAL      W_ORG = *ZEROS
002400090618     C                   EVAL      P_ORG = '00000000'
002500090618
002600090618     C     W_SSN         SETLL     MCOV
002700090618     C     W_SSN         READE     MCOV
002800090618     C                   DOW       not %eof(MCOV)
002900091116     C                   IF        ENRLDT <> CANDT
003000090618     C                   EXSR      CHKPLAN
003100090618     C                   IF        W_ORG <> 0
003200090618     C                   Leave
003300091116     C                   End
003400090618     C                   End
003500090618     C     W_SSN         READE     MCOV
003600090618     C                   Enddo
003700090618
003800090618     C                   MOVE      W_ORG         P_ORG
003900090618     C                   Eval      *INLR = *ON
004000090618     C                   Return
004100090618
004200090618     C     CHKPLAN       BEGSR
004300090618     C     PKEY          KLIST
004400090618     C                   KFLD                    MCTRST
004500090618     C                   KFLD                    MCSUB#
004600090618     C                   KFLD                    MCPLAN
004700090618
004800090618     C     PKEY          CHAIN     PLNMST
004900090618     C                   IF        %found(PLNMST)
005000090618     C     PCARR         CHAIN     CARMST
005100090618     C                   IF        %found(CARMST)
005200090618     C                   IF        CARBC = 'D'
005300090618     C                   EVAL      W_ORG = ENRLDT
005400090618     C                   END
005500090618     C                   END
005600090618     C                   END
005700090618
005800090618     C                   ENDSR
