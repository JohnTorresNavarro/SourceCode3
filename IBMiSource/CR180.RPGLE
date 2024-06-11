000100220214     H
000200220329      ******************************************************************
000300220329      * cr180          Group Benefit Services, Inc.                    *
000400220329      *                                                                *
000500220329      *    WRITTEN BY - DAVID KETTERMAN                                *
000600220329      *    DATE       - 03/29/22                                       *
000700220329      *                                                                *
000800220329      * This program will produce the Delta remittance file            *
000900220329      *                                                                *
001000220329      *                                                                *
001100220329      ******************************************************************
001200220329     Fcr130hso  IP   E             DISK
001300220329     Fagency    IF   E           K DISK
001400220329     Fcr180xl   O  a e             DISK
001500220329     Dcsv              c                   const('","')
001600220329
001700220329     D                 DS
001800220329     D  tsa                    1     10  0
001900220329     D  CTRUST                 1      3  0
002000220329     D  CSUB                   4      6  0
002100220329     D  CACCT                  7     10  0
002200220329     D                 DS
002300220329     D  CEFINV                 1      8  0
002400220329     D  CEFIYY                 1      4  0
002500220329     D  CEFIMM                 5      6  0
002600220329     D  CEFIDD                 7      8  0
002700220329
002800220329     D  csvDS          DS
002900220329     D  D_TSA                        15
003000220329     D  D_grp                        10
003100220329     D  D_div                        10
003200220329     D  D_prod                       10
003300220329     D  D_bildt                      15
003400220329     D  D_covmon                     10
003500220329     D  D_bilamt                     20
003600220329     D  D_adjamt                     20
003700220329     D  D_paidamt                    20
003800220329     D  D_adjman                     20
003900220329     D  D_netprem                    20
004000220329     D  D_tpafee                     20
004100220329     D  D_brkcom                     20
004200220329     D  D_gacom                      20
004300220329     D  D_nettocar                   20
004400220329     D  D_gatin                      20
004500220329     D  D_brkpayto                   10
004600220329     D  D_brktin                     20
004700220329     D                UDS
004800220329     D leffyr                  1      4  0
004900220329     D leffmd                  5      8  0
005000220329     D lwiredt                 9     16  0
005100220329     D lseqfrom               17     18
005200220329     D lseqto                 19     20
005300220329
005400220330      * Process this record
005500220330       exsr #process;
005600220330
005700220330      *************************************************************
005800220330      * Process this record                                       *
005900220330      *************************************************************
006000220330       begsr #process;
006100220330
006200220329       clear csvds;
006300220329
006400220329       D_tsa        = %editw(tsa:'0   -   -    ');
006500220329       D_grp        = %subst(CGROUP:1:5);
006600220329       D_div        = %subst(CGROUP:6:5);
006700220329       D_prod       = 'DELTA';
006800220329       D_bildt      = %editw(ceffdt:'    -  -  ');
006900220329       D_covmon     = %editw(cefinv:'    -  -  ');
007000220329       D_bilamt     = %editc(cbamt:'P');
007100220329       D_adjamt     = %editc(caamt:'P');
007200220329       D_paidamt    = %editc(cpamt:'P');
007300220329       D_adjman     = '0.00';
007400220329       D_netprem    = %editc(cpamt:'P');
007500220329       D_tpafee     = %editc(cadme:'P');
007600220329       D_brkcom     = %editc(ccome:'P');
007700220329       D_gacom      = '0.00';
007800220329       D_nettocar   = %editc((cpamt - cadme -ccome):'P');
007900220329       D_gatin      = '52-1200892';
008000220329       D_brkpayto   = 'A';
008100220329
008200220329      * get agency name
008300220329       if cagcod <> *blanks ;
008400220329       chain (cagcod) agency;
008500220329        if %found(agency);
008600220329         D_brktin     = %editc(agtxid:'X');
008700220329        endif;
008800220329       endif;
008900220329
009000220329      * write record
009100220329       exsr writexldet;
009200220330
009300220330       endsr;
009400220329
009500220329      *************************************************************
009600220329      * Write Spreadsheet Detail                                  *
009700220329      *************************************************************
009800220329       begsr Writexldet;
009900220329
010000220329       clear cr180fld;
010100220329       cr180fld  = '"' +
010200220329         %trim(D_TSA)              + csv +
010300220329         %trim(D_grp)              + csv +
010400220329         %trim(D_div)              + csv +
010500220329         %trim(D_prod)             + csv +
010600220329         %trim(D_bildt)            + csv +
010700220329         %trim(D_covmon)           + csv +
010800220329         %trim(D_bilamt)           + csv +
010900220329         %trim(D_adjamt)           + csv +
011000220329         %trim(D_paidamt)          + csv +
011100220329         %trim(D_adjman)           + csv +
011200220329         %trim(D_netprem)          + csv +
011300220329         %trim(D_tpafee)           + csv +
011400220329         %trim(D_brkcom)           + csv +
011500220329         %trim(D_gacom)            + csv +
011600220329         %trim(D_nettocar)         + csv +
011700220329         %trim(D_gatin)            + csv +
011800220329         %trim(D_brkpayto)         + csv +
011900220330         %trim(D_brktin)           +
012000220330    *    '"';
012100220329       Write cr180r;
012200220329
012300220329       ENDSR;
012400220329
012500220329      *************************************************************
012600220329      * Write Spreadsheet heading                                 *
012700220329      *************************************************************
012800220329       begsr Writexlhead;
012900220329
013000220329       clear cr180fld;
013100220329       cr180fld =  '"' +
013200220408         'EMPLOYER_NO'             + csv +
013300220408         'DELTA_GROUP_NO'          + csv +
013400220408         'DELTA_DIVISION_NO'       + csv +
013500220408         'PRODUCT'                 + csv +
013600220408         'BILLING_DATE'            + csv +
013700220408         'COVERAGE_MONTH'          + csv +
013800220408         'PREMIUM_BILLED'          + csv +
013900220408         'PREMIUM_BILLED_ADJ'      + csv +
014000220408         'PREMIUM_PAID'            + csv +
014100220408         'ADJUSTMENTS'             + csv +
014200220408         'NET_PREMIUM'             + csv +
014300220408         'TPA_ADMIN_FEE'           + csv +
014400220408         'BROKER_COMM'             + csv +
014500220408         'GA_COMM'                 + csv +
014600220408         'NET_TO_CARRIER'          + csv +
014700220408         'GA_TAX_ID'               + csv +
014800220408         'BROKER_COMM_PAYTO'       + csv +
014900220408         'BROKER_TAX_ID'           +
015000220330    *    '"';
015100220329
015200220329       Write cr180r;
015300220329
015400220329       ENDSR;
015500220329
015600220329      ***************************************************
015700220329      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
015800220329      ***************************************************
015900220329      *
016000220329      * DATE IN  = @DATIN (8.0) YYYYMMDD
016100220329      * DATE OUT = @DATOU (8.0) MMDDYYYY
016200220329      *
016300220329     C     #DATYM        BEGSR
016400220329     C                   MOVE      @DATIN        @MD               4 0
016500220329     C                   MOVEL     @DATIN        @Y                4 0
016600220329     C                   MOVEL     @MD           @DATOU            8 0
016700220329     C                   MOVE      @Y            @DATOU
016800220329     C                   MOVE      *ZEROS        @DATIN            8 0
016900220329     C                   ENDSR
017000220329      *
017100220329     C     *inzsr        begsr
017200220329     C                   TIME                    HTIME             6 0
017300220329
017400220329     C                   Exsr      Writexlhead
017500220329     C                   ENDSR
017600220329
