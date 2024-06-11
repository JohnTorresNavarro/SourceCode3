000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Delegated Billing Electronic Enrollment
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - October 24, 2002
000800000000      *_________________________________________________________________________
000900021024      *
001000121112     FDW311RRN  IP   E           K DISK
001100090326     FTRNMIT    UF   E             DISK    Rename(TRNMIR:TRNUPD)
001200121112      *
001300121112     D W_TRSEQ#        S             10s 0 inz
001400121112
001500121112     D                 DS
001600121112     D MMDDYYYYHHMMSS                14S 0
001700121112     D MMDDYYYY                       8S 0 OVERLAY(MMDDYYYYHHMMSS:1) inz
001800121112     D MMDD                           4    OVERLAY(MMDDYYYYHHMMSS:1)
001900121112     D YY                             2    OVERLAY(MMDDYYYYHHMMSS:7)
002000121112     D HHMM                           4    OVERLAY(MMDDYYYYHHMMSS:9)
002100121112     D HHMMSS                         6S 0 OVERLAY(MMDDYYYYHHMMSS:9) inz
002200121112      *
002300121112     IRRNR          01
002400121112     I                                          QQSSN         L2
002500090320      *
002600121112     C   L2              Exsr      RESETL3
002700021112      * Update Trans
002800090326     C   01              Exsr      UpdateTranSR
002900021101      *___________________________________________________________________
003000021101      * Update Transmit Record
003100021101      *___________________________________________________________________
003200021101     C     UpdateTranSR  BEGSR
003300090326      *
003400090326     C                   eval      W_TRSEQ# = W_TRSEQ# + 1
003500021101      *
003600121112     C     QQRELR        Chain     TRNMIT
003700021106     C                   If        %found
003800021101     C                   Eval      dltcod   =    'X'
003900021101     C                   Eval      trnbid   =    MMDD + YY + HHMM
004000090326     C                   Move      W_TRSEQ#      trnseq
004100021101     C     *Date         mult      10000.0001    txmtdt
004200090326     C                   Update    TRNUPD
004300021106     C                   End
004400021101      *
004500021101     C                   ENDSR
004600121112      *___________________________________________________________________
004700121112      * Reset work fields L3
004800121112      *___________________________________________________________________
004900121112     C     RESETL3       BEGSR
005000121112     C                   Eval      W_TRSEQ# = *zeros
005100121112     C                   ENDSR
005200121112      *___________________________________________________________________
005300121112      * Program open
005400121112      *___________________________________________________________________
005500121112     C     *INZSR        BEGSR
005600121112     C                   Eval      MMDDYYYY =    *DATE
005700121112     C                   Time                    HHMMSS
005800121112     C                   ENDSR
