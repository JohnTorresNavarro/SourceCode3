000100000000      *_________________________________________________________________________
000200000000      *
000300071025      *  Description:  Load M&T Bank Remote Deposit from Spreadsheet
000400000000      *
000500070713      *  (c)Copyright 2007 by GBS, Inc.
000600000000      *
000700071025      *    Created by:  szz 10/25/2007
000800080303      *
000900080303      *  Revision  3/3/2008:  Increase calculation work area by one so that
001000080303      *                       amounts of over 99,999.99 can be accommodated
001100080303      *                       per Shelly R.
001200110420      *  04/20/11 dlk - new spreadsheet format
001300160830      *  08/30/16 dlk - new spreadsheet format (no pgm changes)
001400190313      *  03/13/2019 B.Rees - new spreadsheet format (no pgm changes)
001500000000      *_________________________________________________________________________
001600071025     FMTREMP    IF   E             DISK
001700071105     FMTREMOTE2 O    E             DISK
001800070713      *
001900071025     D                 DS
002000071026     D TSAIn                   1     12
002100071026     D  TrustIn                1      3
002200071026     D  D1                     4      4
002300071026     D  SubIn                  5      7
002400071026     D  D2                     8      8
002500071026     D  AcctIn                 9     12
002600071026     D                 DS
002700071026     D TSAOut                  1     10
002800071026     D  TrustOut               1      3
002900071026     D  SubOut                 4      6
003000071026     D  AcctOut                7     10
003100071026     D                 DS
003200071025     D TransferDate            1     16
003300071025     D  XferDate               1     10    Inz
003400071025     D   M12                   1      2
003500071025     D    M1                   1      1
003600071025     D   D345                  3      5
003700071025     D    D34                  3      4
003800071025     D     D3                  3      3
003900071025     D    D45                  4      5
004000071025     D     D4                  4      4
004100071025     D   Y5678910              5     10
004200071025     D    Y5678                5      8
004300071025     D    Y6789                6      9
004400071025     D    Y78910               7     10
004500071025     D  XferTime                      6    Inz
004600071025     D                 DS
004700071025     D ReceiveDate             1      8
004800071025     D  RM12                   1      2
004900071025     D   RM1                   1      1
005000071025     D   RM2                   2      2
005100071025     D  RD345                  3      5
005200071025     D   RD34                  3      4
005300071025     D    RD3                  3      3
005400071025     D   RD45                  4      5
005500071025     D    RD4                  4      4
005600071025     D   RY5678                5      8
005700071029
005800071025     D ReceiveDt       S              8S 0 Inz
005900071025     D PosM            S              2S 0 Inz
006000071025     D PosD            S              2S 0 Inz
006100071029     D PosC            S              2S 0 Inz
006200071029     D PosX            S              2S 0 Inz
006300071029     D PosRJ           S              2S 0 Inz
006400080401     d stripped        S             10a   inz
006500071030     d cmpfld          S              9a   inz
006600080401     d stripped14      S             14a   inz
006700071030     d cmpfld9         S             13a   inz
006800071029
006900071029010   *   Work array - Strip dashes from fields.
007000080303010  D DASH            S              1    DIM(9)
007100071029010   *   Work array - Strip dashes from fields.
007200080303010  D DAS2            S              1    DIM(9)
007300071029010   *   Work array - Strip dashes from fields.
007400071030010  D DASH9           S              1    DIM(11)
007500071029010   *   Work array - Strip dashes from fields.
007600071030010  D DAS29           S              1    DIM(11)
007700071029
007800071029      *---
007900071029      * Ignore first record (column heading)
008000071029      *---
008100071025     C                   Read      MTREMP
008200071029     C                   Read      MTREMP
008300150914     C                   Dow       not %eof(MTREMP)
008400071029     C                   Movel     MTGBSA        BKACCT
008500071029      *
008600110420      * inv #
008700071029     C                   Evalr     MTINV     =   %trim(MTINV)
008800071029     C                   Eval      MTINV     =   %Xlate(' ':'0':MTINV)
008900071029     C                   Move      MTINV         BKINV
009000071029      *
009100110420      * seq #
009200071025     C                   Clear                   BKBATCH
009300071029     C                   Move      MTITSE        ChkDig            1
009400071029     C                   If        ChkDig   <>   *Blanks
009500071029     C                   Move      MTITSE        BKSEQN            2 0
009600071029     C                   Move      BKSEQN        BKSEQ
009700071029     C                   Else
009800071029     C                   Movel     MTITSE        Seq1              1
009900071029     C                   Move      Seq1          BKSEQ1N           1 0
010000071029     C                   Move      BKSEQ1N       BKSEQ
010100071029     C                   End
010200071029      *
010300110420      * amount
010400071029     C                   Exsr      stripcmp
010500071030     C                   Move      *Blanks       cmpfldA           9
010600071030     C                   Evalr     cmpfldA   =   %Trim(cmpfld)
010700071030     C                   Movel     cmpfldA       cmpfldN           9 0
010800071106     C     cmpfldN       MULT      .01           BKAMT
010900071029      *
011000110420      * check #
011100071029     C                   If        MTSER    <>   *Blanks
011200071029     C                   Evalr     MTSER     =   %trim(MTSER)
011300071029     C                   Eval      MTSER     =   %Xlate(' ':'0':MTSER)
011400071029     C                   Move      MTSER         BKCHK#
011500071029     C                   End
011600071029
011700110420      * receive date
011800071025     C                   Exsr      FmtXferDate
011900110420      * source
012000071025     C                   Eval      BKSOURCE  =   %Trim('REMOTE DEP')
012100110420      * status
012200071025     C                   Eval      BKSTAT    =   *Blank
012300071025     C                   Write     MTREMOTER
012400071025     C                   Read      MTREMP
012500070713     C                   EndDo
012600070713     C                   Eval      *InLR     =   *On
012700071025    ? *________________________________________________________________
012800071025    ? * Reformat the Transfer Date into the Receive Date
012900071025    ? *________________________________________________________________
013000071025    ?C     FmtXferDate   Begsr
013100071025    ? *
013200071025     C                   Movel     MTTRDT        TransferDate
013300071025     C                   Eval      PosM = %Scan('/':XferDate:1)
013400071025
013500071025     C                   If        PosM = 2
013600071025     C                   Move      M1            RM2
013700071025     C                   Move      *Zero         RM1
013800071025     C                   Eval      PosD = %Scan('/':XferDate:4)
013900071025     C                   Select
014000071025     C                   When      PosD = 4
014100071025     C                   Move      D3            RD4
014200071025     C                   Move      *Zero         RD3
014300071025     C                   Move      Y5678         RY5678
014400071025     C                   When      PosD = 5
014500071025     C                   Move      D34           RD34
014600071025     C                   Move      Y6789         RY5678
014700071025     C                   EndSl
014800071025     C                   End
014900071025      *---
015000071025     C                   If        PosM = 3
015100071025     C                   Move      M12           RM12
015200071025     C                   Eval      PosD = %Scan('/':XferDate:5)
015300071025     C                   Select
015400071025     C                   When      PosD = 5
015500071025     C                   Move      D4            RD4
015600071025     C                   Move      *Zero         RD3
015700071025     C                   Move      Y6789         RY5678
015800071025     C                   When      PosD = 6
015900071025     C                   Move      D45           RD34
016000071025     C                   Move      Y78910        RY5678
016100071025     C                   EndSl
016200071025     C                   End
016300071025
016400071025     C                   Move      ReceiveDate   ReceiveDt
016500071025     C     ReceiveDt     Mult      10000.0001    BKRCVDT
016600071025    ?C                   Endsr
016700071025    ? *
016800071029    ? *________________________________________________________________
016900071029    ? * Strip decimal point and comma out of field
017000071029    ? *________________________________________________________________
017100071029
017200071029     C     StripCmp      Begsr
017300071029
017400071029     C                   Clear                   cmpfld
017500071029     C                   Clear                   cmpfld9
017600071029     C                   Eval      PosX = %Scan(',':MTAMT:1)
017700071029     C                   If        PosX <>       *Zero
017800071029     C                   Movel     MTAMT         cmpfld9
017900071029     C                   MOVEA     cmpfld9       DASH9
018000071029     C                   Z-ADD     1             D                 3 0
018100071029     C     ','           LOOKUP    DASH9(D)                               80
018200071029     C     *IN80         IFEQ      '1'
018300071029     C                   Z-ADD     0             E                 3 0
018400071029     C                   MOVEA     *ALL' '       DAS29
018500071030     C     1             DO        11            D
018600071029     C     DASH9(D)      IFNE      ','
018700071029     C                   ADD       1             E
018800071029     C                   MOVE      DASH9(D)      DAS29(E)
018900071029     C                   ENDIF
019000071029     C                   ENDDO
019100080401     C                   MOVEA(P)  DAS29         Stripped14
019200071029     C                   ELSE
019300080401     C                   MOVEL     cmpfld9       Stripped14
019400071029     C                   ENDIF
019500080401     C                   Eval      cmpfld9   =   %Trim(Stripped14)
019600071029     C                   MOVEl     cmpfld9       cmpfld
019700071029     C                   Else
019800071029     C                   Movel     MTAMT         cmpfld
019900071029     C                   End
020000071029      **
020100071029     C                   MOVEA     cmpfld        DASH
020200071029     C                   Z-ADD     1             D                 3 0
020300071029     C     '.'           LOOKUP    DASH(D)                                80
020400071029     C     *IN80         IFEQ      '1'
020500071029     C                   Z-ADD     0             E                 3 0
020600071029     C                   MOVEA     *ALL' '       DAS2
020700080303     C     1             DO        9             D
020800071029     C     DASH(D)       IFNE      '.'
020900071029     C                   ADD       1             E
021000071029     C                   MOVE      DASH(D)       DAS2(E)
021100071029     C                   ENDIF
021200071029     C                   ENDDO
021300071029     C                   MOVEA(P)  DAS2          Stripped
021400071029     C                   ELSE
021500071029     C                   MOVEL     cmpfld        Stripped
021600071029     C                   ENDIF
021700071029     C                   Eval      cmpfld    =   Stripped
021800071029
021900071029    ?C                   Endsr
