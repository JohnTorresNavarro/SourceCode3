000100000000      *_________________________________________________________________________
000200000000      *
000300090501      *  Description:  Update TRNMIT Do Not Sends
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
001400090501      *
001500090501     D W90DATE1        S               d   datfmt(*ISO)
001600090501     D W90DATE2        S               d   datfmt(*ISO)
001700090501     D W90DAYS         S              5S 0 inz
001800090501     D WWDATE          S              8S 0 inz
001900090127      *
002000021024     D                 DS
002100021024     D MMDDYYYYHHMMSS                14S 0
002200021101     D MMDDYYYY                       8S 0 OVERLAY(MMDDYYYYHHMMSS:1) inz
002300021101     D MMDD                           4    OVERLAY(MMDDYYYYHHMMSS:1)
002400021101     D YY                             2    OVERLAY(MMDDYYYYHHMMSS:5)
002500021101     D HHMM                           4    OVERLAY(MMDDYYYYHHMMSS:9)
002600021101     D HHMMSS                         6S 0 OVERLAY(MMDDYYYYHHMMSS:9) inz
002700021024      *
002800021106      * File DS
002900021106     D DBFD          E DS                  EXTNAME(IODBFD)
003000021106      * Program status data structure
003100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
003200000000      *
003300021028     IJOINR         01
003400021106     I                                          SOCSOC        L2
003500021112      * Update Trans
003600090127     C                   If        *IN01
003700021112     C                   Exsr      UpdateTranSR
003800021112     C                   End
003900021024      *
004000021101      *___________________________________________________________________
004100021101      * Update Transmit Record
004200021101      *___________________________________________________________________
004300021101     C     UpdateTranSR  BEGSR
004400090501      *
004500090501     C                   If        QQFLAG = 'D'
004600090501      *
004700090806     C                   If        QQDATE <> 0
004800090501     C     *ISO          Move      WWDATE        W90DATE1
004900090501     C     W90DATE1      adddur    1:*D          W90DATE1
005000090501     C     *ISO          Move      QQDATE        W90DATE2
005100090501     C     W90DATE1      Subdur    W90DATE2      W90DAYS:*D
005200090806     C                   Else
005300090806     C                   Eval      W90DAYS  =   99
005400090806     C                   End
005500021101      *
005600090505     C                   If        W90DAYS  >   7
005700090127     C                   Eval      Count    =   Count + 1
005800090127      *
005900021106     C     WQRELR        Chain     TRNMIT
006000021106     C                   If        %found
006100021101     C                   Eval      dltcod   =    'X'
006200090501     C                   Eval      trnbid   =    'DONOTSEND'
006300090127     C                   Move      Count         trnseq
006400021101     C     *Date         mult      10000.0001    txmtdt
006500030520
006600021106     C                   Update    TRNUPD
006700090501     C                   End
006800021106     C                   End
006900021101      *
007000090501     C                   End
007100090501      *
007200021101     C                   ENDSR
007300000000      *___________________________________________________________________
007400000000      * Program open
007500000000      *___________________________________________________________________
007600000000     C     *INZSR        BEGSR
007700090501      *
007800021024     C                   Eval      MMDDYYYY =    *DATE
007900021024     C                   Time                    HHMMSS
008000090501     C     *Date         mult      10000.0001    WWDATE
008100090501      *
008200000000     C                   ENDSR
