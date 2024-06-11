000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Get Member Original CFS Effective Date
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 18, 2009
000800000000      *_________________________________________________________________________
000900091001     FDCOVC     IF   E           K DISK
001000090618     FPLNMST    IF   E           K DISK
001100090618     FCARMST    IF   E           K DISK
001200090618
001300091001     D P_SSN           S              9A
001400091001     D W_SSN           S              9S 0
001500091001     D P_SEQ           S              2A
001600091001     D W_SEQ           S              2S 0
001700090824     D P_EFF           S              8A
001800090824     D W_EFF           S              8S 0
001900090811     D P_PLN           S              4A
002000090729     D P_CAT           S              3A
002100090729     D P_FLG           S              1A
002200090729     D W_FLG           S              1A
002300090618
002400090618     C     *ENTRY        PLIST
002500091001     C                   PARM                    P_SSN
002600091001     C                   PARM                    P_SEQ
002700090811     C                   PARM                    P_PLN
002800090824     C                   PARM                    P_CAT
002900090824     C                   PARM                    P_EFF
003000090729     C                   PARM                    P_FLG
003100090729
003200090824     C                   MOVE      P_SSN         W_SSN
003300091001     C                   MOVE      P_SEQ         W_SEQ
003400090824     C                   MOVE      P_EFF         W_EFF
003500090729     C                   Eval      P_FLG = *BLANKS
003600090729     C                   Eval      W_FLG = *BLANKS
003700091001
003800091001     C     W_KEY         KLIST
003900091001     C                   KFLD                    W_SSN
004000091001     C                   KFLD                    W_SEQ
004100090618
004200091203     C     W_KEY         SETGT     DCOVC
004300091203     C     W_KEY         READPE    DCOVC
004400091001     C                   DOW       not %eof(DCOVC)
004500090618     C                   EXSR      CHKPLAN
004600091203     C                   IF        W_FLG = 'C'
004700091203     C                   LEAVE
004800091203     C                   END
004900091203     C     W_KEY         READPE    DCOVC
005000090618     C                   Enddo
005100090618
005200090729     C                   MOVE      W_FLG         P_FLG
005300090618     C                   Eval      *INLR = *ON
005400090618     C                   Return
005500090618
005600090618     C     CHKPLAN       BEGSR
005700090618     C     PKEY          KLIST
005800091001     C                   KFLD                    DVTRST
005900091001     C                   KFLD                    DVSUB#
006000091001     C                   KFLD                    DVPLAN
006100090618
006200091118     C                   IF        DVPLAN <> P_PLN OR
006300091001     C                             DVPLAN =  P_PLN AND
006400091001     C                             DENRDT <> W_EFF
006500091118     C                   IF        DENRDT <> CCANDT
006600090618     C     PKEY          CHAIN     PLNMST
006700090729     C                   IF        %found(PLNMST)
006800090729     C                   IF        PLNCAT = P_CAT
006900090618     C     PCARR         CHAIN     CARMST
007000090618     C                   IF        %found(CARMST)
007100090618     C                   IF        CARBC = 'D'
007200091118     C                   IF        DVPLAN <> P_PLN AND
007300091118     C                             CCANDT =  W_EFF
007400091118     C                   EVAL      W_FLG = 'C'
007500091203     C                   LEAVESR
007600091203     C                   END
007700091203     C                   IF        DVPLAN <> P_PLN
007800090729     C                   EVAL      W_FLG = 'Y'
007900091203     C                   LEAVESR
008000091118     C                   END
008100090729     C                   END
008200091118     C                   END
008300090618     C                   END
008400090729     C                   END
008500091118     C                   END
008600090618     C                   END
008700090618
008800090618     C                   ENDSR
