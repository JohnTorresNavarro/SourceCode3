000100990526     F******************************************************************
000200990526     F*                                                                *
000300990526     F*  RP520      GROUP BENEFIT SERVICES SOFTWARE          1999      *
000400990526     F*                                                                *
000500990526     F*            WRITTEN BY - DAVID KETTERMAN                        *
000600990526     F*            DATE - 05/26/99                                     *
000700990526     F*                                                                *
000800990526     F*  DESCRIPTION - THIS PROGRAM WILL LIST INVOICE VOIDS &          *
000900990526     F*                THE CORRISPONDING RERUN                         *
001000030204     F* 02/04/03 dlk - add option D to include cancelled accounts      *
001001131005      * 10/05/13 dlk - hist file expansion project - recompile only
001100030204     F*                                                                *
001200030204     F*                                                                *
001300990526     F******************************************************************
001400990526     FHIST      IP   E             DISK
001500990526     FHISTAK    IF   E           K DISK
001600990526     F                                     RENAME(HISTR:HISTAKR)
001700990527     F                                     prefix(K)
001800950501     FACCMST    IF   E           K DISK
001900940803     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
0019011303180005 Frp520xl   o  a e             disk
0019021303180125 Dcsv              c                   const('","')
002000990527     Datrmdy           s                   like(atrmdt)
002100990527     Dtrdmdy           s                   like(trdate)
002200990527     Dcovmdy           s                   like(covtdt)
002300990527     Dtrdout           s                   like(trdate)
002400990527     Dtraout           s                   like(tramt)
002500990527     Dsamed            s              1
002600990527     Dnore             s              1
002700990527     Dprint            s              1
002800990528     Dtots             s              6  0
002900990528     Dtotr             s              6  0
003000990526     D                 DS
003100990526     D  CK#NOT                 1     30
003200990526     D  AVIINV                 6     12
003201130318     D                 DS
003202130318     D  tsa                    1     10  0
003203130318     D  hstrst                 1      3  0
003204130318     D  hssub#                 4      6  0
003205130318     D  hsacct                 7     10  0
003300990526     D                UDS
003400990526     D  LFY                    1      4  0
003500990526     D  LFMD                   5      8  0
003600990526     D  LTY                    9     12  0
003700990526     D  LTMD                  13     16  0
003800990527     D  LTRUST                17     19
003900990527     D  LSUB                  20     22
004000990527     D  LACC                  23     26
004100990527     D  LS1                   27     27
004200990527     D  LS2                   28     28
004300990527     D  LS3                   29     29
004400030204     D  LS4                   30     30
004500981214     D  CONAME               201    240
004600981214     D  LTIME                242    247  0
004700990526     IHISTR
004800990526     I                                          HSTRST        L1
004900990526     I                                          HSSUB#        L1
005000990526     I                                          HSACCT        L1
005100990527     C                   if        *inl1
005200030204     C     ACCKEY        CHAIN     ACCMST
005300990527     C                   endif
005400030204
005500990527     C* valid accounts only
005600030204     C                   if        %found(accmst)
005700990526     C*
005800990527     C                   eval      @datin = atrmdt
005900990527     C                   exsr      #datym
006000990527     C                   eval      atrmdy = @datou
006100990526     C*
006200990527     C                   eval      @datin = trdate
006300990527     C                   exsr      #datym
006400990527     C                   eval      trdmdy = @datou
0065009905260111 C*
006600990527     C                   eval      @datin = covtdt
006700990527     C                   exsr      #datym
006800990527     C                   eval      covmdy = @datou
0069009905260111 C*
007000990527     C                   eval      trdout = *zeros
007100990527     C                   eval      traout = *zeros
007200990527     C                   eval      samed = ' '
007300990527     C                   eval      nore = ' '
007400981214     C*
007500990527     C* find invoice rerun
007600990527     C*
007700990527     C                   eval      *in20 = *off
007800990526     C     HISTKY        SETLL     HISTAK
007900990527     C*
008000990527     C                   dou       *in20
008100990526     C                   READ      HISTAK                                 20
008200990526     C*
008300990527     c                   if        *in20 or khkey <> hkey
008400990527     c                   leave
008500990527     c                   endif
008600990526     C*
008700990527     C                   if        ktrcode = 'BMB' and kcovtdt = covtdt
008800990527     C                   eval      @datin = ktrdate
008900990527     C                   exsr      #datym
009000990527     C                   eval      trdout = @datou
009100990527     C                   eval      traout = ktramt
009200990527     C*
009300990527     C                   if        trdate <> ktrdate
009400990527     C                   eval      samed = 'N'
009500990527     C                   endif
009600990527     C*
009700990527     C                   leave
009800990527     C                   endif
009900990526     C*
010000990527     C                   enddo
010100990526     C*
010200990527     C* print line
010300990527     C*
010400030204     C                   if        trdout = 0
010500990527     C                   eval      nore = 'N'
010600990527     C                   endif
010700990527     C*
010800990527     C                   eval      print = ' '
010900990527     C*
011000990527     C* decide what to print based on screen selection
011100990527     C*
011200990527     C                   if        ls1 = 'X'
011300990527     C                   eval      print = 'Y'
011400990527     C                   endif
011500990527     C                   if        ls2 = 'X' and samed = 'N'
011600990527     C                   eval      print = 'Y'
011700990527     C                   endif
011800030204     C                   if        ls3 = 'X' and nore = 'N' and atrmdt = 0
011900990527     C                   eval      print = 'Y'
012000990527     C                   endif
012100030204     C                   if        ls4 = 'X' and nore = 'N' and atrmdt <> 0
012200030204     C                   eval      print = 'Y'
012300030204     C                   endif
012400990527     C*
012500990528     C* accum totals
012600990528     C*
012700990528     C                   if        print = 'Y' and samed = 'N'
012800990528     C                   eval      tots = tots +1
012900990528     C                   endif
013000990528     C                   if        print = 'Y' and nore = 'N'
013100990528     C                   eval      totr = totr +1
013200990528     C                   endif
013300990527     C                   if        print = 'Y'
013400990528     C*
013500130318     C                   EXCEPT    PRT
013501130318     C                   exsr      writexldet
013600990527     C                   endif
013700990526     C*
013800990527     C                   endif
013900990526     C*
014000990526     C*
014100990526     C*
0141011303180164 C*************************************************************
0141021303180164 C*                                                           *
0141031303180164 C* Write Spreadsheet Detail                                  *
0141041303180164 C*                                                           *
0141051303180164 C*************************************************************
014106130318     C     Writexldet    BEGSR
014107130318
014108130318     c                   clear                   rp520fld
014111130318
014128130318     C                   Eval      rp520fld  =                            '"' +
014129130318     C                             %trim(%editw(tsa:'0   -   -    '))   + csv  +
014130130318     C                             %trim(%editw(trdmdy:'  /  /    '))   + csv  +
014131130318     C                             aviinv                               + csv  +
014132130318     C                             %trim(%editw(covmdy:'  /  /    '))   + csv  +
014133130318     C                             %trim(%editc(tramt:'K'))             + csv  +
014134130318     C                             %trim(%editw(trdout:'  /  /    '))   + csv  +
014135130318     C                             samed                                + csv  +
014136130318     C                             %trim(%editc(traout:'K'))            + csv  +
014137130318     C                             %trim(%editw(atrmdy:'  /  /    '))   + csv  +
014138130318     C                             nore                                 + csv  +
014148130318     C                             ' '                                  + '",'
014149130318
014150130318     C                   Write     rp520r
0141511303180320 C                   ENDSR
014152130318     C*
014153130318     C*************************************************************
014154130318     C*                                                           *
014155130318     C* Write Spreadsheet heading                                 *
014156130318     C*                                                           *
014157130318     C*************************************************************
014158130318     C     Writexlhead   BEGSR
014159130318
014160130318     c                   clear                   rp520fld
014161130318     C                   Eval      rp520fld =                     '"' +
014162130318     C                             'ACCOUNT'                   + csv  +
014163130318     C                             'VOID DATE'                 + csv  +
014164130318     C                             'VOID INV #'                + csv  +
014165130318     C                             'VOID EFF DT'               + csv  +
014166130318     C                             'VOID AMOUNT'               + csv  +
014167130318     C                             'RERUN DATE'                + csv  +
014168130318     C                             'RERUN SAME DAY'            + csv  +
014169130318     C                             'RERUN AMOUNT'              + csv  +
014170130318     C                             'ACCT TERM DT'              + csv  +
014171130318     C                             'NO RERUN'                  + csv  +
014175130318     C                             ' '                        + '",'
014176130318     C                   Write     rp520r
014177130318     C*
0141781303180320 C                   ENDSR
014179130318
014200990526     C     *INZSR        BEGSR
014300990526     C*
014400990526     C     ACCKEY        KLIST
014500990526     C                   KFLD                    HSTRST
014600990526     C                   KFLD                    HSSUB#
014700990526     C                   KFLD                    HSACCT
014800990526     C     HISTKY        KLIST
014900990526     C                   KFLD                    HKEY
015000990526     C                   KFLD                    TRDATE
015001130318
015002130318     C                   Exsr      Writexlhead
015003130318
015100990526     C                   ENDSR
015200990526     C*
015300990527   01C*
015400990527   01C*****************************************************
015500990527   01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
015600990527   01C*****************************************************
015700990527   01C*
015800990527   01C*   DATE IN  = @DATIN (8.0) YYYYMMDD
015900990527   01C*   DATE OUT = @DATOU (8.0) MMDDYYYY
016000990527   01C*
016100990527   01C     #DATYM        BEGSR
016200990527   01C                   MOVE      @DATIN        @MD               4 0
016300990527   01C                   MOVEL     @DATIN        @Y                4 0
016400990527   01C                   MOVEL     @MD           @DATOU            8 0
016500990527   01C                   MOVE      @Y            @DATOU
016600990527   01C                   MOVE      *ZEROS        @DATIN            8 0
016700990527   01C                   ENDSR
016800981214     OQSYSPRT   H    1P                     2 03
016900981214     O         OR    OF
017000981214     O                                           44 '*****'
017100981214     O                       CONAME              85
017200981214     O                                           91 '*****'
017300981214     O          H    1P                     1
017400981214     O         OR    OF
017500990527     O                                           73 'INVOICE VOID / RERUN REP'
017600990527     O                                           76 'ORT'
017700981214     O          H    1P                     1
017800981214     O         OR    OF
017900990526     O                                           19 'PROGRAM NAME: RP520'
018000981231     O                                           56 'DATE RANGE:'
018100990527   01O                       LFMD                62 '  /  '
018200990527   01O                                           63 '/'
018300990527   01O                       LFY                 67
018400990526     O                                           69 '-'
018500990527   01O                       LTMD                74 '  /  '
018600990527   01O                                           75 '/'
018700990527   01O                       LTY                 79
018800981214     O                                          122 'PAGE :'
018900981214     O                       PAGE          Z    131
019000981214     O          H    1P                     1
019100981214     O         OR    OF
019200981214     O                                            9 'RUN DATE:'
019300990526     O                       *DATE         Y     20
019400990527     O                                           52 'TRUST:'
019500990527     O                       LTRUST              56
019600990527     O                                           62 'SUB:'
019700990527     O                       LSUB                66
019800990527     O                                           72 'ACC:'
019900990527     O                       LACC                77
020000981214     O                                          122 'TIME :'
020100981214     O                       LTIME              132 '  :  :  '
020200990527     O          H    1P                     1
020300990527     O         OR    OF
020400030204     O                                           40 'SELECT  ALL:'
020500030204     O                       LS1                 +2
020600030204     O                                           +3 'NOT SAME DAY:'
020700030204     O                       LS2                 +2
020800030204     O                                           +3 'NO RERUN ACTIVE:'
020900030204     O                       LS3                 +2
021000030204     O                                           +3 'NO RERUN CANCEL:'
021100030204     O                       LS4                 +2
021200981214     O          H    1P                     1
021300981214     O         OR    OF
021400981214     O                                           24 '""""""""""""""""""""""""'
021500981214     O                                           48 '""""""""""""""""""""""""'
021600981214     O                                           72 '""""""""""""""""""""""""'
021700981214     O                                           96 '""""""""""""""""""""""""'
021800981214     O                                          120 '""""""""""""""""""""""""'
021900981214     O                                          132 '""""""""""""'
022000981214     O          H    1P                     1
022100981214     O         OR    OF
022200990527     O                                           37 '------------------ VOID '
022300990527     O                                           59 '----------------------'
022400990527     O                                           85 '---------- RERUN -------'
022500990527     O                                           92 '-------'
022600990526     O          H    1P                     1
022700990526     O         OR    OF
022800990526     O                                            9 'ACCOUNT #'
022900990526     O                                           25 'TRANSACTION'
023000990526     O                                           34 'INVOICE'
023100990527     O                                           46 'EFFECTIVE'
023200990526     O                                           59 'INVOICE'
023300990526     O                                           72 'TRANSACTION'
023400990527     O                                           78 'SAME'
023500990527     O                                           92 'INVOICE'
023600990527     O                                          105 'ACCOUNT'
023700990527     O                                          112 'NO'
023800981214     O          H    1P                     1
023900981214     O         OR    OF
024000990526     O                                           25 'DATE'
024100990526     O                                           34 'NUMBER'
024200990527     O                                           46 'DATE'
024300990526     O                                           59 'AMOUNT'
024400990526     O                                           72 'DATE'
024500990527     O                                           78 'DAY'
024600990527     O                                           92 'AMOUNT'
024700990527     O                                          105 'TERM DATE'
024800990527     O                                          112 'RERUN'
024900981214     O          H    1P                     2
025000981214     O         OR    OF
025100981214     O                                           24 '""""""""""""""""""""""""'
025200981214     O                                           48 '""""""""""""""""""""""""'
025300981214     O                                           72 '""""""""""""""""""""""""'
025400981214     O                                           96 '""""""""""""""""""""""""'
025500981214     O                                          120 '""""""""""""""""""""""""'
025600981214     O                                          132 '""""""""""""'
025700981214     O          E            PRT            1
025800990526     O                       HSTRST               3
025900990526     O                                            4 '-'
026000990526     O                       HSSUB#               7
026100990526     O                                            8 '-'
026200990526     O                       HSACCT              12
026300990526     O                       TRDMDY        Y     25
026400990526     O                       AVIINV              34
026500990527     O                       COVMDY        Y     46
026600990526     O                       TRAMT         M     59
026700990526     O                       TRDOUT              72 '  /  /    '
026800990527     O                       SAMED               78
026900990527     O                       TRAOUT        M     92
027000990527     O                       ATRMDY             105 '  /  /    '
027100990527     O                       NORE               112
027200990528     O          t    lr                  1  1
027300990528     O                                           78 '------'
027400990528     O                                          112 '------'
027500990528     O          t    lr                     1
027600990528     O                                            7 'TOTALS:'
027700990528     O                       TOTS          3     78
027800990528     O                       TOTR          3    112
