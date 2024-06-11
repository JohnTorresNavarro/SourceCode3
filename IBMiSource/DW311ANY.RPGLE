000100000000      *_________________________________________________________________________
000200000000      *
000300090902      *  Description:  Any Active CFS Plans?
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 18, 2009
000800000000      *_________________________________________________________________________
000900090902     FMCOV      IF   E           K DISK
001000090618     FPLNMST    IF   E           K DISK
001100090618     FCARMST    IF   E           K DISK
001200090618
001300090813     D POS             S              2S 0
001400090618     D P_SSN           S              9A
001500090811     D W_SSN           S              9S 0
001600090811     D P_PLN           S              4A
001700090729     D P_CAT           S              3A
001800090729     D P_FLG           S              1A
001900090813     D W_FLG           S              1A
002000090813     D KING            S             80A
002100090813
002200090813     D W_PLANS         DS
002300090813     D APLN                    1     80A   DIM(20)
002400090618
002500090618     C     *ENTRY        PLIST
002600090813     C                   PARM                    P_SSN
002700090729     C                   PARM                    P_FLG
002800090813     C                   PARM                    KING
002900090729
003000090813     C                   MOVE      P_SSN         W_SSN
003100090729     C                   Eval      P_FLG = *BLANKS
003200090813     C                   Eval      W_FLG = *BLANKS
003300090813     C                   Eval      W_PLANS = KING
003400090813
003500090813     C     W_KEY         KLIST
003600090813     C                   KFLD                    W_SSN
003700090618
003800090902     C     W_KEY         SETLL     MCOV
003900090902     C     W_KEY         READE     MCOV
004000090902     C                   DOW       not %eof(MCOV)
004100090902     C                   If        CANDT = *ZEROS
004200090618     C                   EXSR      CHKPLAN
004300090729     C                   IF        W_FLG <> *BLANKS
004400090618     C                   Leave
004500090813     C                   End
004600090618     C                   End
004700090902     C     W_KEY         READE     MCOV
004800090618     C                   Enddo
004900090618
005000090729     C                   MOVE      W_FLG         P_FLG
005100090618     C                   Eval      *INLR = *ON
005200090618     C                   Return
005300090618
005400090618     C     CHKPLAN       BEGSR
005500090618     C     PKEY          KLIST
005600090902     C                   KFLD                    MCTRST
005700090902     C                   KFLD                    MCSUB#
005800090902     C                   KFLD                    MCPLAN
005900090618
006000090902     C                   Eval      pos = %lookup(MCPLAN:APLN)
006100090813     C                   IF        pos = 0
006200090618     C     PKEY          CHAIN     PLNMST
006300090729     C                   IF        %found(PLNMST)
006400090618     C     PCARR         CHAIN     CARMST
006500090618     C                   IF        %found(CARMST)
006600090618     C                   IF        CARBC = 'D'
006700090729     C                   EVAL      W_FLG = 'Y'
006800090729     C                   END
006900090618     C                   END
007000090729     C                   END
007100090618     C                   END
007200090618
007300090618     C                   ENDSR
