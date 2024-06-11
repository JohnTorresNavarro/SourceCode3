000100000000      *_________________________________________________________________________
000200000000      *
000300100628      *  Description:  Print CFS Safeguard Tracking Report
000400000000      *
000500100628      *  (c)Copyright 2010 by GBS, Inc.
000600000000      *
000700100628      *    Created by:  JALLEN - Jun 28, 2010
000800000000      *_________________________________________________________________________
000801100812     FDW310JF   IP   E           K DISK
000803100628     FFRMTRKL6  IF   E           K DISK
001000100812     FPRTSA0P   O    E             PRINTER oflind(*in91)
001100031107      *
001200081203     D Count           S              5S 0
001300081203     D Tount           S              5S 0
002500081203      *
003001100628      *
003002100628     C     TRKKEY        Klist
003003100628     C                   Kfld                    FTSSN
003004100628     C                   Kfld                    FTUNIQUE
003005100628
003006100812     C                   Move      SOCSOC        FTSSN
003007100628     C                   Eval      FTUNIQUE = *HIVAL
003008100628
003009100628     C     FTSSN         Chain     FRMTRKL6
003010100628     C                   If        not %found(FRMTRKL6)
003011100628    ?C                   Exsr      ChkOvf
003012100812     C                   Eval      WPNAME = %trim(FNAME) + ' ' +
003013100812     C                                      %trim(LNAME)
003014100812     C                   Move      TRUST         WPTRS
003015100812     C                   Move      SUBNO         WPSUB
003016100812     C                   Move      ACCNO         WPACC
003017100628    ?C                   Write     PRTDTL
003018100628     C                   Eval      Count += 1
003019100628     C                   Else
003020100628     C     TRKKEY        Setgt     FRMTRKL6
003021100628     C     FTSSN         Readpe    FRMTRKL6
003022100628     C                   Dow       not %eof(FRMTRKL6)
003023100628     C                   If        %trim(FTCLSUSR) <> *Blanks
003024100628    ?C                   Exsr      ChkOvf
003025100812     C                   Eval      WPNAME = %trim(FNAME) + ' ' +
003026100812     C                                      %trim(LNAME)
003027100812     C                   Move      TRUST         WPTRS
003028100812     C                   Move      SUBNO         WPSUB
003029100812     C                   Move      ACCNO         WPACC
003030100628    ?C                   Write     PRTDTL
003031100628     C                   Eval      Count += 1
003032100628     C                   End
003033100628     C                   Leave
003034100628     C                   Enddo
003035100628     C                   End
003100081203      *
003200100628     CLR                 Exsr      COTALS
003300081203     CLR                 Exsr      TOTALS
003400081203    ? *___________________________________________________________________
003500081203      * Cotals
003600081203    ? *___________________________________________________________________
003700081203     C     COTALS        Begsr
003800081203      *
003900081203     C                   If        Count > 0
003901100726     C                   Eval      *INU1 = *ON
004000081203     C                   Eval      WCCOUNT = Count
004100081203     C                   Eval      WTCOUNT = WTCOUNT + Count
004101100628     C                   If        Count = 0
004200100628     C                   Write     PRTCOT
004201100628     C                   End
004800081203     C                   End
004900081203      *
005000081203     C                   Eval      Count   = 0
005100081203     C                   Eval      WCCOUNT = 0
005200081203      *
005300081203     C                   Endsr
005400081203    ? *___________________________________________________________________
005500081203      * Totals
005600081203    ? *___________________________________________________________________
005700081203     C     TOTALS        Begsr
005800081203      *
005900081203     C                   Write     PRTTOT
006000081203      *
006100081203     C                   Endsr
006200030422    ? *___________________________________________________________________
006300030422    ? * Check Overflow
006400030422    ? *___________________________________________________________________
006500030422    ?C     ChkOvf        Begsr
006600081203B001?C     *in91         Ifeq      *On
006700030422 001?C                   Time                    WPTIM
006800030422 001?C                   Write     PRTHDR
006900030422 001?C                   Move      *Off          *In91
007000030422E001?C                   Endif
007100030422    ?C                   Endsr
007200030422      *___________________________________________________________________
007300030422      * Program initialization
007400030422      *___________________________________________________________________
007500030422     C     *INZSR        BEGSR
007600030422      *
007601100628    ?C                   Move      *on           *in91
007700100812     C                   Eval      WQPGMN =      'PRTSA0R'
007800090714 001?C                   Time                    WPTIM
007900090714 001?C                   Write     PRTHDR
008000090714 001?C                   Move      *Off          *In91
008100030422      *
008200030422    ?C                   Endsr
