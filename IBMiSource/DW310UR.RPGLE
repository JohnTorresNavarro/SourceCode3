000100000000      *_________________________________________________________________________
000200000000      *
000300090127      *  Description:  Update TRNMIT
000400000000      *
000500090127      *  (c)Copyright 2009 by GBS, Inc.
000600000000      *
000700090127      *    Created by:  JALLEN - Jan 27, 2009
000800000000      *_________________________________________________________________________
000900021024      *
001000021106     FDW310JF   IP   E           K DISK    Infds(DBFD)
001100021106     FTRNMIT    UF   E             DISK    Rename(TRNMIR:TRNUPD)
001200021216      *
001300090127     D Count           s              6S 0 inz
001400090127      *
001500021024     D                 DS
001600021024     D MMDDYYYYHHMMSS                14S 0
001700021101     D MMDDYYYY                       8S 0 OVERLAY(MMDDYYYYHHMMSS:1) inz
001800021101     D MMDD                           4    OVERLAY(MMDDYYYYHHMMSS:1)
001900021101     D YY                             2    OVERLAY(MMDDYYYYHHMMSS:5)
002000021101     D HHMM                           4    OVERLAY(MMDDYYYYHHMMSS:9)
002100021101     D HHMMSS                         6S 0 OVERLAY(MMDDYYYYHHMMSS:9) inz
002200021024      *
002300021106      * File DS
002400021106     D DBFD          E DS                  EXTNAME(IODBFD)
002500021106      * Program status data structure
002600000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002700000000      *
002800021028     IJOINR         01
002900021106     I                                          SOCSOC        L2
003000021112      * Update Trans
003100090127     C                   If        *IN01
003200021112     C                   Exsr      UpdateTranSR
003300021112     C                   End
003400021024      *
003500021101      *___________________________________________________________________
003600021101      * Update Transmit Record
003700021101      *___________________________________________________________________
003800021101     C     UpdateTranSR  BEGSR
003900090504      *
004000090127     C                   Eval      Count    =   Count + 1
004100090127      *
004200021106     C     WQRELR        Chain     TRNMIT
004300021106     C                   If        %found
004400021101     C                   Eval      dltcod   =    'X'
004500021101     C                   Eval      trnbid   =    MMDD + YY + HHMM
004600090127     C                   Move      Count         trnseq
004700021101     C     *Date         mult      10000.0001    txmtdt
004800030520
004900021106     C                   Update    TRNUPD
005000090504     C                   End
005100021101      *
005200021101     C                   ENDSR
005300000000      *___________________________________________________________________
005400000000      * Program open
005500000000      *___________________________________________________________________
005600000000     C     *INZSR        BEGSR
005700021024     C                   Eval      MMDDYYYY =    *DATE
005800021024     C                   Time                    HHMMSS
005900000000     C                   ENDSR
