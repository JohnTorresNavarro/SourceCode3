000100000000      *_________________________________________________________________________
000200000000      *
000300120308      *  Description:  Update EFF for DR Records
000400000000      *
000500120308      *  (c)Copyright 2012 by GBS, Inc.
000600000000      *
000700120308      *    Created by:  JALLEN - March 08, 2012
000800000000      *_________________________________________________________________________
000900120308     FDW310JF   IP   E           K DISK    Infds(DBFD) prefix(X_)
000901120308     FTRNMIT    UF   E             DISK    Rename(TRNMIR:TRNOUT)
000902120308
000903120308     D W8ALPHA         s              8a   inz
000904120308     D W80DATE         s              8s 0 inz
001300091202
001400000000      * Program status data structure
001500091202     D DBFD          E DS                  EXTNAME(IODBFD)
001600000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001700091202
001800091202      *
001900091202     IJOINR         01
002000091202
002100091202      *
002200091202     C   01              EXSR      PROCESS
002300091202      *___________________________________________________________________
002400091202     C     PROCESS       BEGSR
002500091202      *___________________________________________________________________
002501120308      *
002800120308      * DR only
002801120308     C                   If        %trim(X_ACTCOD) = 'DR'
002802120308     C     WQRELR        Chain     TRNMIT
002803120308     C                   If        %found(TRNMIT)
002804120308     C                   Move      TFILL04       W8ALPHA
002805120308     C     ' ':'0'       Xlate     W8ALPHA       W8ALPHA
002806120308     C                   move      W8ALPHA       W80DATE
002807120308     C                   If        W80DATE <> *ZEROS
002808120308     C                   Eval      DENRLD = W80DATE
002809120308     C                   Update    TRNOUT
002810120308     C                   End
002811120308     C                   End
002812120308     C                   End
005300091202      *
005400091202     C                   ENDSR
005500000000      *___________________________________________________________________
005600000000      * Key Lists
005700000000      *___________________________________________________________________
005800000000     C     KLIST         BEGSR
006800000000     C                   ENDSR
006900000000      *___________________________________________________________________
007000000000      * Program open
007100000000      *___________________________________________________________________
007200000000     C     *INZSR        BEGSR
007300000000     C                   ENDSR
