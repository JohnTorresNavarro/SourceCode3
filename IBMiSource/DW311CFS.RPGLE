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
001300090824     D P_SSN           S              9A
001400090824     D W_SSN           S              9S 0
001500090824     D P_EFF           S              8A
001600090824     D W_EFF           S              8S 0
001700090811     D P_PLN           S              4A
001800090729     D P_CAT           S              3A
001900090729     D P_FLG           S              1A
002000090729     D W_FLG           S              1A
002100090618
002200090618     C     *ENTRY        PLIST
002300090618     C                   PARM                    P_SSN
002400090811     C                   PARM                    P_PLN
002500090824     C                   PARM                    P_CAT
002600090824     C                   PARM                    P_EFF
002700090729     C                   PARM                    P_FLG
002800090729
002900090824     C                   MOVE      P_SSN         W_SSN
003000090824     C                   MOVE      P_EFF         W_EFF
003100090729     C                   Eval      P_FLG = *BLANKS
003200090729     C                   Eval      W_FLG = *BLANKS
003300090618
003400091203     C     W_SSN         SETGT     MCOV
003500091203     C     W_SSN         READPE    MCOV
003600090618     C                   DOW       not %eof(MCOV)
003700091116     C                   IF        ENRLDT <> CANDT
003800090618     C                   EXSR      CHKPLAN
003900091203     C                   IF        W_FLG = 'C'
004000090618     C                   Leave
004100091116     C                   End
004200090618     C                   End
004300091203     C     W_SSN         READPE    MCOV
004400090618     C                   Enddo
004500090618
004600090729     C                   MOVE      W_FLG         P_FLG
004700090618     C                   Eval      *INLR = *ON
004800090618     C                   Return
004900090618
005000090618     C     CHKPLAN       BEGSR
005100090618     C     PKEY          KLIST
005200090618     C                   KFLD                    MCTRST
005300090618     C                   KFLD                    MCSUB#
005400090618     C                   KFLD                    MCPLAN
005500090618
005600090824     C                   IF        MCPLAN <> P_PLN OR
005700090824     C                             MCPLAN =  P_PLN AND
005800090824     C                             ENRLDT <> W_EFF
005900090618     C     PKEY          CHAIN     PLNMST
006000090729     C                   IF        %found(PLNMST)
006100090729     C                   IF        PLNCAT = P_CAT
006200090618     C     PCARR         CHAIN     CARMST
006300090618     C                   IF        %found(CARMST)
006400090618     C                   IF        CARBC = 'D'
006500091118     C                   IF        MCPLAN <> P_PLN AND
006600091118     C                             CANDT =  W_EFF
006700091118     C                   EVAL      W_FLG = 'C'
006800091203     C                   LEAVESR
006900091203     C                   END
007000091203     C                   IF        MCPLAN <> P_PLN
007100091118     C                   EVAL      W_FLG = 'Y'
007200091203     C                   LEAVESR
007300091118     C                   END
007400090729     C                   END
007500090618     C                   END
007600090618     C                   END
007700090729     C                   END
007800090618     C                   END
007900090618
008000090618     C                   ENDSR
