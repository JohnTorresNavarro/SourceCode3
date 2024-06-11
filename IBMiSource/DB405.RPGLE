000100941215     H DFTNAME(DB405)
0002009102150002 F******************************************************************  UTL001
0003000004140003 F* DB405      GROUP BENEFIT SERVICES SOFTWARE           1994      *  UTL001
0004009102150004 F*                                                                *  UTL001
0005009108290005 F*            WRITTEN BY - DAVID KETTERMAN                        *  UTL001
0006009412150006 F*            DATE - 12/15/94                                     *  UTL001
0007009102150007 F*                                                                *  UTL001
0008009412090013 F*  DESCRIPTION - THIS PROGRAM WILL PRINT ANY GRATE RECORDS       *  UTL001
0009009412150014 F*            WITH NET RATES = BILL RATES AND THE "SGR REMITANCE" *  UTL001
0010009412150015 F*            FIELD IN THE PLAN MASTER FILE NOT EQUAL TO "B"      *  UTL001
0011009808270014 F*                                                                *
0012009808270010 F*  Y2K CONVERT - 1998                                            *
0013009808270015 F*                                                                *
0014009102150016 F******************************************************************  UTL001
0015000102220014 F* MODIFICATION HISTORY                                           *
0016000102220014 F* ??? 08.27.1998 Y2K CONVERSION                                  *
0017000102220014 F* SSK 02.22.2001 RPGIV CONVERSION                                *
0018001302150014 F* dlk 02/15/13 - fix invalid trust msg and clean up some old code*
0019001302150014 F*                and change printer file to unique name for email*
0020001302150014 F*                of report.                                      *
002100140128   X***X
002200140128   X***X 01/28/2014 SSK SGR RULES DO NOT APPLY TO ACA PLANS.
002300140128   X***X                ZERO RATE GRATE RECORDS AUTOMATICALLY FILTER OUT ACA PLANS.
002400140128   X***X
002500140128   X***X
0026009102150017 F*                                                                   UTL001
0027000102220016 F******************************************************************  UTL001
0028000102220018 FGRATE24   IP   F   80        DISK
0029000102220006 FPLNMST    UF   F  200    10AIDISK    KEYLOC(1)
0030000102220006 FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
0031001302150021 FDB405P    O    F  132        PRINTER OFLIND(*INOF)
003200941215     D ERR             S             40    DIM(3) CTDATA PERRCD(1)
003300130215     D pdescrout       S                   like(pdescr)
0034009108290055 D                UDS
0035009108290056 D  CONAME               201    240
0036009108290058 D  HMS                  242    247  0
0037009412150022 IGRATE24   NS  01
0038009808270027 I                                  1    3  TRUST#        L2
003900980827     I                                  4    6  SUB#
004000980827     I                                  7   10  PLAN#
0041009808270027 I                                  1   10  TSP           L1
004200070927     I                                 42   52 6NETRTE
004300070927     I                                 53   63 6BILRTE
0044009808270048 I                                 65   72 0FRCYMD
0045009808270051 I                                 73   80 0TOCYMD
004600941215     IPLNMST    NS
0047009412150088 I                                 11   50  PDESCR
0048009412150137 I                                162  162  SGRREM
004900950308     ITRSMST    NS
0050009503080088 I                                255  255  TSCODE
005100950308     C*
005200950308     C* GET CATEGORY CODE ON NEW TRUST, IF INVALID TRUST, PRINT ERROR
005300950308     C* AND SKIP ALL RECORDS WITH THIS TRUST
005400950308     C*
005500130215     c                   if        *inl2
005600130215     c                   clear                   pdescrout
005700130215     C     TRUST#        CHAIN     TRSMST
005800130215     c                   if        not %found(trsmst)
005900130215     C                   MOVE      'Z'           TSCODE
006000130215     C                   Z-ADD     3             X                 1 0
006100130215     C                   MOVE      FRCYMD        @DATIN
006200130215     C                   EXSR      #DATYM
006300130215     C                   MOVE      @DATOU        FRMDY             8 0
006400980827     C*
006500130215     C                   MOVE      TOCYMD        @DATIN
006600130215     C                   EXSR      #DATYM
006700130215     C                   MOVE      @DATOU        TOMDY             8 0
006800130215     C                   EXCEPT    ERROR
006900130215     c                   end
007000130215     c                   end
007100130215
007200130215      * ON LAST RECORD OF LAST DATE RANGE IF BILLED = NET, SGR FLAG
007300130215      * MUST BE "B" IN PLNMST
007400130215     cl1                 exsr      #l1tot
007500130215
007600130215     C*
007700130215     c     #l1tot        begsr
007800130215     c                   clear                   pdescrout
007900130215     c                   if        netrte <> 0 and bilrte <> 0 and
008000130215     c                             netrte = bilrte
008100130215     C     TSP           CHAIN     PLNMST
008200130215     c                   if        not %found(plnmst)
008300130215     C                   Z-ADD     1             X                 1 0
008400130215     C                   MOVE      FRCYMD        @DATIN
008500130215     C                   EXSR      #DATYM
008600130215     C                   MOVE      @DATOU        FRMDY             8 0
008700130215
008800130215     C                   MOVE      TOCYMD        @DATIN
008900130215     C                   EXSR      #DATYM
009000130215     C                   MOVE      @DATOU        TOMDY             8 0
009100130215     C                   EXCEPT    ERROR
009200130215     C                   leavesr
009300130215     c                   end
009400950308     C*
009500950308     C* EXCLUDE CATEGORY CODE = Z
009600950308     C*
009700130215     C     TSCODE        IFEQ      'Z'
009800130215     C                   leavesr
009900130215     C                   END
010000950308     C*
010100130215     C     SGRREM        IFNE      'B'
010200130215     C                   Z-ADD     2             X
010300130215     C                   MOVE      FRCYMD        @DATIN
010400130215     C                   EXSR      #DATYM
010500130215     C                   MOVE      @DATOU        FRMDY             8 0
010600980828     C*
010700130215     C                   MOVE      TOCYMD        @DATIN
010800130215     C                   EXSR      #DATYM
010900130215     C                   MOVE      @DATOU        TOMDY             8 0
011000130215     c                   movel     pdescr        pdescrout
011100130215     C                   EXCEPT    ERROR
011200130215     C   U1              EXCEPT    UPDATE
011300130215     C                   END
011400130215     C                   END
011500130215     c                   endsr
011600920923     C*
0117009808270107 C*
0118009808270103 C***************************************************
0119009808270104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0120009808270105 C***************************************************
0121009808270107 C*
0122009808270107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0123009808270107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0124009808270107 C*
0125009808270106 C     #DATYM        BEGSR
012600980827     C                   MOVE      @DATIN        @MD               4 0
012700980827     C                   MOVEL     @DATIN        @Y                4 0
012800980827     C                   MOVEL     @MD           @DATOU            8 0
012900980827     C                   MOVE      @Y            @DATOU
013000980827     C                   MOVE      *ZEROS        @DATIN            8 0
0131009808270120 C                   ENDSR
013200980827     C*
0133009102150104 O******************************************************              DB020
0134009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0135009102150106 O******************************************************              DB020
0136009102150107 O*                                                                   DB020
013700941215     OPLNMST    E            UPDATE
013800941215     O                                          162 'B'
0139001302150108 Odb405p    H    1P                     2  3
014000910215     O         OR    OF
0141009102150110 O                       CONAME              87
0142001302150108 O          H    1P                     1
014300910215     O         OR    OF
0144009102150113 O                       UDATE         Y     14
0145009412150114 O                                           59 'GRATE AUDIT FOR NET = BI'
0146009412150114 O                                           83 'LLED RATES BUT SGR REMIT'
0147009412150114 O                                           96 ' FLAG NOT "B"'
0148009102150115 O                                          120 'PAGE :'
0149009102150116 O                       PAGE          Z    126
0150001302150108 O          H    1P                     1
015100910215     O         OR    OF
0152009412150119 O                                           17 'PROG: DB405'
0153009412150120 O               U1                         110 'UPDATE : YES'
0154009412150120 O              NU1                         110 'UPDATE : NO '
0155009412150120 O                                          120 'TIME :'
0156009102150121 O                       HMS                130 '  :  :  '
0157001302150108 O          H    1P                     1
015800910215     O         OR    OF
0159009102150124 O                                           24 '------------------------'
0160009102150125 O                                           48 '------------------------'
0161009102150126 O                                           72 '------------------------'
0162009102150127 O                                           96 '------------------------'
0163009102150128 O                                          120 '------------------------'
0164009102150129 O                                          132 '------------'
0165001302150108 O          H    1P                     1
016600910215     O         OR    OF
0167009412090132 O                                           14 'TRUST-SUB-PLAN'
0168009412150134 O                                           27 'FROM DATE'
0169009412150135 O                                           38 'TO DATE'
0170009412150136 O                                           59 'PLAN DESCRIPTION'
0171009412150136 O                                           97 'ERROR'
0172001302150108 O          H    1P                     1
017300910215     O         OR    OF
0174009102150141 O                                           24 '------------------------'
0175009102150142 O                                           48 '------------------------'
0176009102150143 O                                           72 '------------------------'
0177009102150144 O                                           96 '------------------------'
0178009102150145 O                                          120 '------------------------'
0179009102150146 O                                          132 '------------'
0180001302150147 O          E            ERROR          1
0181000102220034 O                       TRUST#               5
0182000102220034 O                                            6 '-'
0183000102220034 O                       SUB#                 9
0184000102220034 O                                           10 '-'
0185000102220034 O                       PLAN#               14
0186009808270151 O                       FRMDY               27 '  /  /    '
0187009808270152 O                       TOMDY               39 '  /  /    '
018800130215     O                       PDESCRout           83
018900941215     O                       ERR(X)             132
019000950308** ERROR TABLE
019100941215MISSING PLAN MASTER RECORD
019200941215SGR REMIT FLAG NOT "B"
019300950308INVALID TRUST
