000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000400000000      *
000500090730      *    Created by:  JALLEN - July 30, 2009
000600000000      *_________________________________________________________________________
000700090730     FDCOVC     IF   E           K DISK
000800090618     FPLNMST    IF   E           K DISK
000900090618     FCARMST    IF   E           K DISK
001000090618
001100090730     D P_SSN           S              9A
001200090730     D P_SEQ           S              2A
001300090729     D P_FLG           S              1A
001400090730     D W_SSN           S              9S 0
001500090730     D W_SEQ           S              2S 0
001600090729     D W_FLG           S              1A
001700090618
001800090618     C     *ENTRY        PLIST
001900090730     C                   PARM                    P_SSN
002000090730     C                   PARM                    P_SEQ
002100090729     C                   PARM                    P_FLG
002200090729
002300090730     C                   MOVE      P_SSN         W_SSN
002400090730     C                   MOVE      P_SEQ         W_SEQ
002500090730     C     KDEP          KLIST
002600090730     C                   KFLD                    W_SSN
002700090730     C                   KFLD                    W_SEQ
002800090730
002900090729     C                   Eval      P_FLG = *BLANKS
003000090729     C                   Eval      W_FLG = *BLANKS
003100090618
003200090730     C     KDEP          SETLL     DCOVC
003300090730     C     KDEP          READE     DCOVC
003400090730     C                   DOW       not %eof(DCOVC)
003500090730     C                   IF        CCANDT <> *ZEROS
003600090618     C                   EXSR      CHKPLAN
003700090729     C                   IF        W_FLG <> *BLANKS
003800090618     C                   Leave
003900090730     C                   End
004000090618     C                   End
004100090730     C     KDEP          READE     DCOVC
004200090618     C                   Enddo
004300090618
004400090729     C                   MOVE      W_FLG         P_FLG
004500090618     C                   Eval      *INLR = *ON
004600090618     C                   Return
004700090618
004800090618     C     CHKPLAN       BEGSR
004900090618     C     PKEY          KLIST
005000090730     C                   KFLD                    DVTRST
005100090730     C                   KFLD                    DVSUB#
005200090730     C                   KFLD                    DVPLAN
005300090618
005400090618     C     PKEY          CHAIN     PLNMST
005500090729     C                   IF        %found(PLNMST)
005600090618     C     PCARR         CHAIN     CARMST
005700090618     C                   IF        %found(CARMST)
005800090618     C                   IF        CARBC = 'D'
005900090729     C                   EVAL      W_FLG = 'Y'
006000090618     C                   END
006100090729     C                   END
006200090618     C                   END
006300090618
006400090618     C                   ENDSR
