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
001200091203     FGRAT24    IF   E           K DISK    Prefix(G_)
001300091222     FHISTAK    IF   E           K DISK
001400090618
001500090824     D P_SSN           S              9A
001600090824     D W_SSN           S              9S 0
001700090824     D P_EFF           S              8A
001800090824     D W_EFF           S              8S 0
001900090811     D P_PLN           S              4A
002000090729     D P_CAT           S              3A
002100090729     D P_FLG           S              1A
002200090729     D W_FLG           S              1A
002300091203     D P_GRP           S             20A
002400091203     D PLNGRP          S             20A
002500091222     D Today           S              8S 0
002600091222     D KEYHST          S             10A
002700090618
002800090618     C     *ENTRY        PLIST
002900090618     C                   PARM                    P_SSN
003000090811     C                   PARM                    P_PLN
003100090824     C                   PARM                    P_CAT
003200090824     C                   PARM                    P_EFF
003300091203     C                   PARM                    P_FLG
003400091203     C                   PARM                    P_GRP
003500090729
003600091222     C                   MOVE      P_SSN         W_SSN
003700091222     C                   MOVE      P_SSN         KEYHST
003800090824     C                   MOVE      P_EFF         W_EFF
003900090729     C                   Eval      P_FLG = *BLANKS
004000091203     C                   Eval      W_FLG = *BLANKS
004100091203     C                   Eval      PLNGRP = *BLANKS
004200091222     C     *Date         Mult      10000.0001    Today
004300090618
004400091203     C     W_SSN         SETGT     MCOV
004500091203     C     W_SSN         READPE    MCOV
004600090618     C                   DOW       not %eof(MCOV)
004700091116     C                   IF        ENRLDT <> CANDT
004800090618     C                   EXSR      CHKPLAN
004900091222     C                   IF        W_FLG <> ' '
005000090618     C                   Leave
005100091116     C                   End
005200090618     C                   End
005300091203     C     W_SSN         READPE    MCOV
005400090618     C                   Enddo
005500090618
005600090729     C                   MOVE      W_FLG         P_FLG
005700090618     C                   Eval      *INLR = *ON
005800090618     C                   Return
005900090618
006000091203      ***
006100090618     C     CHKPLAN       BEGSR
006200091203      ***
006300090618     C     PKEY          KLIST
006400090618     C                   KFLD                    MCTRST
006500090618     C                   KFLD                    MCSUB#
006600090618     C                   KFLD                    MCPLAN
006700090618
006800090824     C                   IF        MCPLAN <> P_PLN OR
006900090824     C                             MCPLAN =  P_PLN AND
007000090824     C                             ENRLDT <> W_EFF
007100090618     C     PKEY          CHAIN     PLNMST
007200090729     C                   IF        %found(PLNMST)
007300090729     C                   IF        PLNCAT = P_CAT
007400090618     C     PCARR         CHAIN     CARMST
007500090618     C                   IF        %found(CARMST)
007600090618     C                   IF        CARBC = 'D'
007700091222      **
007800091222      ** No break in coverage, DIFF PLAN
007900091118     C                   IF        MCPLAN <> P_PLN AND
008000091118     C                             CANDT =  W_EFF
008100091222     C                   EVAL      W_FLG = 'C'
008200091222     C************       EXSR      CHKHIST
008300091203     C                   EXSR      CHKGROUP
008400091203     C                   LEAVESR
008500091203     C                   END
008600091222      **
008700091222      ** Break in Coverage means they had prior coverage - Diff PLAN
008800091203     C                   IF        MCPLAN <> P_PLN
008900091118     C                   EVAL      W_FLG = 'Y'
009000091203     C                   EXSR      CHKGROUP
009100091203     C                   LEAVESR
009200091118     C                   END
009300091222      **
009400091222      ** Break in Coverage means they had prior coverage - Same PLAN
009500091221     C                   IF        MCPLAN =  P_PLN and
009600091221     C                             CANDT <  W_EFF  and
009700091221     C                             CANDT <> 0
009800091221     C                   EVAL      W_FLG = 'Y'
009900091221     C                   EXSR      CHKGROUP
010000091221     C                   LEAVESR
010100091221     C                   END
010200090729     C                   END
010300090618     C                   END
010400090618     C                   END
010500090729     C                   END
010600090618     C                   END
010700090618
010800090618     C                   ENDSR
010900091203
011000091203      ***
011100091203     C     CHKGROUP      BEGSR
011200091203      ***
011300091203      * Group Change should be an ADD.
011400091203      ***
011500091203     C                   Eval      PLNGRP = *blanks
011600091203     C     PKEY          Setll     GRAT24
011700091203     C     PKEY          Reade     GRAT24
011800091203     C                   Dow       not %eof(GRAT24)
011900091203      *
012000091203     C                   If        G_frmdat <> G_todat
012100091203     C                   if        ENRLDT   >= G_frmdat and
012200091203     C                             ENRLDT   <= G_todat
012300091203     C                   If        %trim(P_GRP) <> %trim(G_group#)
012400091203     C                   EVAL      W_FLG = 'A'
012500091203     C                   LEAVESR
012600091203     C                   end
012700091203     C                   end
012800091203     C                   end
012900091203      *
013000091203     C     PKEY          Reade     GRAT24
013100091203     C                   Enddo
013200091203      *
013300091203     C                   ENDSR
013400091222      ***
013500091222     C     CHKHIST       BEGSR
013600091222      ***
013700091222     C                   MOVE      P_SSN         KEYHST
013800091222     C     KEYHST        Setgt     HISTAK
013900091222     C     KEYHST        Readpe    HISTAK
014000091222     C                   Dow       not %eof(HISTAK)
014100091222     C                   If        TRCODE = 'MDC'
014200091222     C                   Movel     CK#NOT        HSPL              4
014300091222     C                   If        HSPL = MCPLAN and
014400091222     C                             TRDATE < Today
014500091222     C                   EVAL      W_FLG = 'R'
014600091222     C                   LeaveSR
014700091222     C                   End
014800091222     C                   End
014900091222     C
015000091222     C     KEYHST        Readpe    HISTAK
015100091222     C                   Enddo
015200091222      ***
015300091222     C                   ENDSR
