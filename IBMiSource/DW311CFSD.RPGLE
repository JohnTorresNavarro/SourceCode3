000100000000      *_________________________________________________________________________
000200000000      *
000300090813      *  Description:  Get Depend Original CFS Effective Date
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 18, 2009
000800000000      *_________________________________________________________________________
000900090813     FDCOVC     IF   E           K DISK
001000090618     FPLNMST    IF   E           K DISK
001100090618     FCARMST    IF   E           K DISK
001200090618
001300090813     D POS             S              2S 0
001400090618     D P_SSN           S              9A
001500090811     D W_SSN           S              9S 0
001600090813     D P_SEQ           S              2A
001700090813     D W_SEQ           S              2S 0
001800090811     D P_PLN           S              4A
001900090729     D P_CAT           S              3A
002000090729     D P_FLG           S              1A
002100090813     D W_FLG           S              1A
002200090813     D KING            S             80A
002300090813
002400090813     D W_PLANS         DS
002500090813     D APLN                    1     80A   DIM(20)
002600090618
002700090618     C     *ENTRY        PLIST
002800090813     C                   PARM                    P_SSN
002900090813     C                   PARM                    P_SEQ
003000090729     C                   PARM                    P_FLG
003100090813     C                   PARM                    KING
003200090729
003300090813     C                   MOVE      P_SSN         W_SSN
003400090813     C                   MOVE      P_SEQ         W_SEQ
003500090729     C                   Eval      P_FLG = *BLANKS
003600090813     C                   Eval      W_FLG = *BLANKS
003700090813     C                   Eval      W_PLANS = KING
003800090813
003900090813     C     W_KEY         KLIST
004000090813     C                   KFLD                    W_SSN
004100090813     C                   KFLD                    W_SEQ
004200090618
004300091203     C     W_KEY         SETGT     DCOVC
004400091203     C     W_KEY         READPE    DCOVC
004500090813     C                   DOW       not %eof(DCOVC)
004600090813     C                   If        CCANDT = *ZEROS
004700090618     C                   EXSR      CHKPLAN
004800090729     C                   IF        W_FLG <> *BLANKS
004900090618     C                   Leave
005000090813     C                   End
005100090618     C                   End
005200091203     C     W_KEY         READPE    DCOVC
005300090618     C                   Enddo
005400090618
005500090729     C                   MOVE      W_FLG         P_FLG
005600090618     C                   Eval      *INLR = *ON
005700090618     C                   Return
005800090618
005900090618     C     CHKPLAN       BEGSR
006000090618     C     PKEY          KLIST
006100090813     C                   KFLD                    DVTRST
006200090813     C                   KFLD                    DVSUB#
006300090813     C                   KFLD                    DVPLAN
006400090618
006500090813     C                   Eval      pos = %lookup(DVPLAN:APLN)
006600090813     C                   IF        pos = 0
006700090618     C     PKEY          CHAIN     PLNMST
006800090729     C                   IF        %found(PLNMST)
006900090618     C     PCARR         CHAIN     CARMST
007000090618     C                   IF        %found(CARMST)
007100090618     C                   IF        CARBC = 'D'
007200090729     C                   EVAL      W_FLG = 'Y'
007300090729     C                   END
007400090618     C                   END
007500090729     C                   END
007600090618     C                   END
007700090618
007800090618     C                   ENDSR
