000100000000      ******************************************************************
000200000000      *                                                                *
000300000414      *  RPA052    GROUP BENEFIT SERVICES SOFTWARE          1990       *
000400000000      *                                                                *
000500000000      *            WRITTEN BY - DEBORAH R. BEYER                       *
000600000000      *            DATE -  8/17/90                                     *
000700000000      *                                                                *
000800000000      *  DESCRIPTION - THIS PROGRAM WILL PRINT A CASH RECEIPTS         *
000900000000      *                LISTING  SORTED BY DAY                          *
001000000000      *                                                                *
001100000000      *    JGE  11.22.98 - Modified for Y2k date conversion            *
001200000000      *        JGE01     All dates modified to use a 4 digit year for  *
001300000000      *                  comparisons and output.  File record lengths  *
001400000000      *                  modified as needed for new date positions.    *
001500000000      *                                                                *
001600981231      *  DMA  12.31.98  increase array's to use 36 months              *
001700990405      *  DMA  04.05.99  increase final total field to 10.2             *
001800100721      *  DLK  07/21/10  ADD PAYMENT TYPE SELECTION                     *
001900100827      *  DLK  08/27/10  fix senior dental carrier code on report       *
002000121024      *  DLK  10/24/12  add acct cancel date per Liliane               *
002100121112      *  DLK  11/12/12  fix userid display                             *
002200131010      *  SBT  10/07/13  hist file expansion project: remove report     *
002300131010      *                    per finance                                 *
002400180109      *  jt   01/09/18  Added changes for Advanced Mobile
002401200124      *  jt   01/09/18  Added changes for CSM
002500000000      ******************************************************************
002600131010     FHIST      IP   F  216        DISK
002700080218     FCODES     IF   F   64     3AIDISK    KEYLOC(1)
002800121024     FACCMST    IF   e           k DISK
002900100329     FTRSMST    IF   E           K DISK
003000100827     Fmcovx     IF   E           K DISK
003100100329     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
003200080221     FPMT050EX  O    E             DISK
003300981231     D AMT             S             10  2 DIM(48)
003400990318     D DTE             S              6  0 DIM(48)
003500100329     D                 DS
003600100329     D  PLNKEY                 1     10
003700100329     D  MCTRST                 1      3  0
003800100329     D  MCSUB#                 4      6  0
003900100329     D  MCPLAN                 7     10
004000000000     D                 DS
004100000000JGE01D  COVTH2                 1      8  0
004200000000JGE01D  CY                     1      4  0
004300000000JGE01D  CM                     5      6  0
004400000000JGE01D  CD                     7      8  0
004500080222     D                 DS
004600080222     D  DATFR                  1      8  0
004700080222     D                 DS
004800080222     D  DATTO                  1      8  0
004900080221     D                 DS
005000080221     D  DAT81                  1      8  0
005100080222     D  XYY                    1      4  0
005200080222     D  XMM                    5      6  0
005300080222     D  XDD                    7      8  0
005400080221     D                 DS
005500080221     D  DAT82                  1      8  0
005600080222     D  MMM                    1      2  0
005700080222     D  DDD                    3      4  0
005800080222     D  YYY                    5      8  0
0059009812310051 D                 DS
006000990318     D  DATE6                  1      6  0
006100981231     D  CMX                    1      2  0
006200990318     D  CYX                    3      6  0
006300080218     D WDTA            DS
006400080218     D  PMTDT1                 1      8  0
006500080218     D  PMTDT2                 9     16  0
006600080221     D  PMTTRS                17     19
006700080221     D  PMTSUB                20     22
006800080221     D  PMTACC                23     26
006900100721     D  PMTCAT                27     36
007000100721     D  PMTTYP                38     43
007100000000     D                UDS
007200080218     D  RECEIV                 1      6
007300080218     D  RECVMM                 1      2
007400080218     D  RECVYY                 3      6
007500000000     D  LTRUST                 7      9
007600000000     D  LSUB                  10     12
007700000000     D  LACCT                 13     16
007800100721     D***                                    17  50 LCATTP
007900000000     D  CONAME               201    240
008000080218     D  HMS                  242    247
008100100721     D  LTYPE                900    905
008200000000     IHIST      NS  01
008300000000     I                                  1    3 0HTRST
008400000000     I                                  1    1  HTYPE
008500000000     I                                  2   10 0SS#
008600000000     I                                 17   19  TRCODE        L1
008700000000     I                             P   20   24 2TRAMT
008800000000     I                                 25   25  CM$FLG                  25
008900000000     I                                 26   55  CK#NOT
009000000000     I                                 56   85  NOTE2                   22
009100000000     I                                 79   85 0BATCH#
009200000000     I                                110  112 0TRUST#
009300000000     I                                113  115 0SUB#
009400000000     I                                116  119 0ACCNO
009500990318JGE01I                                129  136 0TRDATE        L2
009600990318JGE01I                                145  152 0RECVDT        L3        23
009700990318JGE01I                                153  160 0COVTDT                  24
009800131010     I                                207  216  hoper
009900000000     ICODES     NS
010000000000      *  CODES
010100000000     I                                 14   43  LDESCR
010200100329     IPLNMST    NS
010300100329      *  PLAN MASTER FILE
010400100329     I                                 53   55  PCARR
010500000000     C     FCYCLE        IFNE      'Y'
010600000000     C                   Z-ADD     *ZERO         AMT
010700000000     C                   MOVE      'Y'           FCYCLE            1
010800080218     C     *ENTRY        PLIST
010900080218     C                   PARM                    WDTA
011000080221     C                   MOVE      'ALL'         LTRUST
011100080221     C                   MOVE      'ALL'         LSUB
011200080221     C                   MOVE      'ALL'         LACCT
011300080221     C     PMTTRS        IFNE      *BLANKS
011400080218     C                   MOVE      PMTTRS        LTRUST
011500080221     C                   END
011600080221     C     PMTSUB        IFNE      *BLANKS
011700080218     C                   MOVE      PMTSUB        LSUB
011800080221     C                   END
011900080221     C     PMTACC        IFNE      *BLANKS
012000080218     C                   MOVE      PMTACC        LACCT
012100080221     C                   END
012200080222     C                   MOVE      PMTDT1        DAT81
012300080222     C                   MOVE      XYY           YYY
012400080222     C                   MOVE      XMM           MMM
012500080222     C                   MOVE      XDD           DDD
012600080222     C                   MOVE      DAT82         DATFR
012700080222     C                   MOVE      PMTDT2        DAT81
012800080222     C                   MOVE      XYY           YYY
012900080222     C                   MOVE      XMM           MMM
013000080222     C                   MOVE      XDD           DDD
013100080222     C                   MOVE      DAT82         DATTO
013200000000     C                   END
013300000000      *
013400000000     C                   Z-ADD     COVTDT        COVTH2
013500981231     C                   Z-ADD     CM            CMX
013600990318     C                   Z-ADD     CY            CYX
013700000000      *
013800000000      * CHECK FOR ACCOUNT / MEMBER TRANSACTION
013900000000      *
014000000000     C     HTYPE         COMP      ' '                                2121
014100000000      *
014200000000      * GET NEW CODE DESCRIPTION ON CODE CHANGE
014300000000      *
014400000000     C   L1TRCODE        CHAIN     CODES                              H2
014500000000      *
014600000000      * ACCUMULATE TRAMT
014700000000      *
014800131010     C                   Z-ADD     1             X                 2 0
014900990318     C     DATE6         LOOKUP    DTE(X)                                 69
015000981231     C  N69              ADD       1             Y                 2 0
015100990318     C  N69              Z-ADD     DATE6         DTE(Y)
015200981231     C  N69              ADD       TRAMT         AMT(Y)
015300981231     C   69              ADD       TRAMT         AMT(X)
015400000000     C                   ADD       TRAMT         TAMTCR            9 2
015500000000      *
015600000000     C                   ADD       TRAMT         L4AMT             9 2
015700000000      *
015800990405     C                   ADD       TRAMT         LRAMCR           10 2
015900000000      *
016000121024     c                   clear                   acandtwk          8 0
016100121024     C     acckey        CHAIN     ACCMST
016200121024     c                   if        %found(accmst)
016300121024     c                   move      atrmdt        acandtwk
016400121024     c                   end
016500121024
016600000000     C*
016700000000     C*  CREATE DATE FIELD(S) TO PRINT
016800000000     C*
016900000000JGE01C                   EXSR      DATE01
017000080221      *
017001180215     C*  CREATE carrier field for senior dental and advanced mobile
017002180215     C                   clear                   PECARC
017100180215     C     TRUST#        CHAIN     TRSMST
017101180215     C                   IF        %found(trsmst) and
017102200124     C                             (tscode = 'O N' or tscode = 'O M' or
017103200124     C                              tscode = 'O D')
017200180215     C                   EXSR      DENTL
017201180215     c                   end
017300100329      *
017400080221     C                   MOVE      PMTDT1        PEXDT1
017500080221     C                   MOVE      PMTDT2        PEXDT2
017600080221     C                   MOVE      TRUST#        PEXTRS
017700080221     C                   MOVE      SUB#          PEXSUB
017800080221     C                   MOVE      ACCNO         PEXACC
017900080221     C                   MOVE      TRDATE        PEXTRD
018000121024     C                   MOVEl     LDESCR        PEXLDS
018100080221     C                   MOVE      SS#           PEXSSN
018200080221     C                   MOVE      BATCH#        PEXBAT
018300080221     C                   Z-ADD     TRAMT         PEXAMT
018400080221     C                   MOVE      COVTDT        PEXCOV
018500080221     C                   MOVE      RECVDT        PEXREC
018600080221     C                   MOVE      CM$FLG        PEXCM$
018700121024     C                   MOVEl     CK#NOT        PEXNOT
018800121112     C                   MOVE      hoper         PEXOPR
018900121024     C                   MOVE      acandtwk      PEXACANDT
019000080221     C                   WRITE     PMT5EX
019100000000      *
019200000000     C     END#          TAG
019300000000      *
019400000000     C*******************************************************
019500000000     C*             S U B R O U T I N E S                   *
019600000000     C*******************************************************
019700000000JGE01C***
019800000000JGE01C*******************************************************
019900000000JGE01C*  SUBROUTINE TO REVERSE DATES FROM YYYYMMDD TO MMDDYYYY
020000000000JGE01C*  FOR PRINT LINE
020100000000JGE01C*******************************************************
020200000000JGE01C***
020300000000JGE01C     DATE01        BEGSR
020400000000JGE01C                   Z-ADD     TRDATE        @DATIN
020500000000JGE01C                   EXSR      #DATYM
020600000000JGE01C                   Z-ADD     @DATOU        PTRDAT            8 0
020700000000JGE01C*
020800000000JGE01C                   Z-ADD     RECVDT        @DATIN
020900000000JGE01C                   EXSR      #DATYM
021000000000JGE01C                   Z-ADD     @DATOU        PRECDT            8 0
021100000000JGE01C*
021200000000JGE01C                   Z-ADD     COVTDT        @DATIN
021300000000JGE01C                   EXSR      #DATYM
021400000000JGE01C                   Z-ADD     @DATOU        PCOVDT            8 0
021500121024JGE01C*
021600121024JGE01C                   Z-ADD     acandtwk      @DATIN
021700121024JGE01C                   EXSR      #DATYM
021800121024JGE01C                   Z-ADD     @DATOU        acandtmdy         8 0
021900000000JGE01C                   ENDSR
022000000000JGE01C***
022100000000JGE01C*****************************************************
022200000000JGE01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
022300000000JGE01C*****************************************************
022400000000JGE01C***
022500000000JGE01C* DATE IN  = @DATIN (8.0) YYYYMMDD
022600000000JGE01C* DATE OUT = @DATOU (8.0) MMDDYYYY
022700000000JGE01C***
022800000000JGE01C     #DATYM        BEGSR
022900000000JGE01C                   MOVE      @DATIN        @MD               4 0
023000000000JGE01C                   MOVEL     @DATIN        @Y                4 0
023100000000JGE01C                   MOVEL     @MD           @DATOU            8 0
023200000000JGE01C                   MOVE      @Y            @DATOU
023300000000JGE01C                   MOVE      *ZEROS        @DATIN            8 0
023400000000JGE01C                   ENDSR
023401180215
023402180215
023500100329      ******************************************************
023501180215      * get carrier for senior dental and advanced mobile
023502180215      ******************************************************
023600180215     C     DENTL         BEGSR
023601180215
024100100329     C     ACCKEY        KLIST
024200100329     C                   KFLD                    TRUST#
024300100329     C                   KFLD                    SUB#
024400100329     C                   KFLD                    ACCNO
024500100827      *
024600100827      * find active plan
024700100827     C     acckey        SETLL     mcovx
024800100827     C                   dou       %eof(mcovx)
024900100827     C     acckey        READE     mcovx
025000100827     c                   if        not %eof(mcovx) and candt = 0
025100100827     C     PLNKEY        CHAIN     PLNMST
025200100827     c                   if        %found(plnmst)
025300100827     C                   MOVE      PCARR         PECARC
025400100827     C                   leavesr
025500100827     C                   end
025600100827     C                   end
025700100827     C                   enddo
025800100329      *
025900100827      * if no active plan, find latest cancel plan
026000100329     C     PECARC        IFEQ      *BLANKS
026100100827     c                   clear                   holdcandt         8 0
026200100827     C     acckey        SETLL     mcovx
026300100827     C                   dou       %eof(mcovx)
026400100827     C     acckey        READE     mcovx
026500100827     c                   if        not %eof(mcovx) and candt <> 0
026600100827     c                             and enrldt <> candt
026700100827     c                             and candt > holdcandt
026800100827     c                   move      candt         holdcandt
026900100827     C     PLNKEY        CHAIN     PLNMST
027000100827     c                   if        %found(plnmst)
027100100827     C                   MOVE      PCARR         PECARC
027200100827     C                   end
027300100827     C                   end
027400100827     C                   enddo
027500100827     C                   ENDIF
027600100329      *
027700100329     C                   ENDSR
027800100329      ******************************************************
027900100329     C/EJECT
028000000000      ******************************************************
