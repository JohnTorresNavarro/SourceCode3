000100000000      *_________________________________________________________________________
000200000000      *
000300100628      *  Description:  Close CFS Tracking Records
000400000000      *
000500100628      *  (c)Copyright 2010 by GBS, Inc.
000600000000      *
000700100628      *    Created by:  JALLEN - June 28, 2010
000800000000      *_________________________________________________________________________
000900100729     FDBE834ARC UP   E             DISK
001000100628     FFRMTRKL2  UF   E           K DISK
001200100421
001201100729     D Today           s              8s 0 inz
001202100729     D Florida         s               d   datfmt(*ISO)
001203100628
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001500000000      *
001601100628      * Close Form Tracking record
001602100628      *
001603100628     C     TRKKEY        Klist
001604100628     C                   Kfld                    FTSSN
001605100628     C                   Kfld                    FTUNIQUE
001606100729
001607100729     C     *Date         Mult      10000.0001    Today
001608100729     C     *ISO          Move      Today         Florida
001609100628
001610100628     C                   Move      D3SUB         FTSSN
001611100628     C                   Eval      FTUNIQUE = *HIVAL
001612100628
001613100628     C     TRKKEY        Setgt     FRMTRKL2
001614100628     C     FTSSN         Readpe    FRMTRKL2
001615100628     C                   Dow       not %eof(FRMTRKL2)
001616100729     C                   If        %trim(FTCLSUSR) = *Blanks  and
001617100729     C                             FTRCVDT <> FLORIDA
001618100729     C                   Move      FTRCVDT       FTCLSDT
001619100729     C                   ADDDUR    1:*D          FTCLSDT
001621100729     C                   Eval      FTCLSUSR = '834ONE'
001622100707     C                   Eval      FTCLSCOD = '834'
001623100628     C                   Time                    FTCLSTM
001624100628     C                   Update    FRMTRKR
001625100628     C                   End
001626100628     C                   Leave
001627100628     C                   Enddo
004400000000      *___________________________________________________________________
004500000000      * Program open
004600000000      *___________________________________________________________________
004700000000     C     *INZSR        BEGSR
004800000000     C                   ENDSR
