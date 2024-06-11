000100000000      *_________________________________________________________________________
000200000000      *
000300100628      *  Description:  Close CFS Tracking Records
000400000000      *
000500100628      *  (c)Copyright 2010 by GBS, Inc.
000600000000      *
000700100628      *    Created by:  JALLEN - June 28, 2010
000800000000      *_________________________________________________________________________
000900100421     FDBEDTL834 UP   E             DISK
001000100628     FFRMTRKL2  UF   E           K DISK
001200100421
001201100628     D Today           s              8s 0 inz
001202100628
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001500000000      *
001601100628      * Close Form Tracking record
001602100628      *
001603100628     C     TRKKEY        Klist
001604100628     C                   Kfld                    FTSSN
001605100628     C                   Kfld                    FTUNIQUE
001606100628
001607100628     C                   Move      D3SUB         FTSSN
001608100628     C                   Eval      FTUNIQUE = *HIVAL
001609100628
001610100628     C     TRKKEY        Setgt     FRMTRKL2
001611100628     C     FTSSN         Readpe    FRMTRKL2
001612100628     C                   Dow       not %eof(FRMTRKL2)
001613100628     C                   If        %trim(FTCLSUSR) = *Blanks
001614100628     C                   Eval      Today = %int(%char(%date : *iso0))
001615100628     C                   Move      Today         FTCLSDT
001616100628     C                   Eval      FTCLSUSR = '834JOB'
001617100707     C                   Eval      FTCLSCOD = '834'
001618100628     C                   Time                    FTCLSTM
001619100628     C                   Update    FRMTRKR
001620100628     C                   End
001621100628     C                   Leave
001622100628     C                   Enddo
004400000000      *___________________________________________________________________
004500000000      * Program open
004600000000      *___________________________________________________________________
004700000000     C     *INZSR        BEGSR
004800000000     C                   ENDSR
