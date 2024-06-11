0001009102150002 F******************************************************************
0002009909300003 F* CR135      GROUP BENEFIT SERVICES SOFTWARE           1994      *
0003009102150004 F*                                                                *
0004009606270013 F*  DESCRIPTION - THIS PROGRAM WILL REPRINT CR130 BY ACC #/ NAME  *
0005009102150015 F*                                                                *
0006009808120014 F*                                                                *
0007009808120010 F*  Y2K CONVERT - 1998                                            *
000800991027     F*  DMA  10.27.99   Changed date level break to CCYYMM            *
0009000008010015 F*  dlk  08/01/00   add commission override at plan level         *
001000001012     F*  DLK  10/12/00 - change group # to 15 in invdet                *
001100010125     F*  jva  01/25/01 - CR135 new layout.                             *
0012000102120015 F*  ksj  02/12/01   Moved last two fields in prtf two positions   *
0013000102120015 F*                   to the left                                  *
0014000107260014 F*  ksj   7/25/01   Added the following totals for #Mbr fields:   *
0015000107260014 F*                  Carrier, Broker and Final Totals              *
0015010303310015 F*  SSK   3/31/2003 RECORD LENGTH CHANGED FOR CR135               *
0015020711300015 F*  dlk  11/30/2007 change cr135 file length to match cr130hs*    *
0015030804140015 F*  dlk  04/14/2008 change input file to cr135J (a join of CR130HS*  *
0015040804140015 F*                  carrier master to add the CARBC field so it can
0015050804140015 F*                  be used in the opnqryf selection).            *
0015071612180015 F*  dlk  12/16/2016 increase rec len of cr135 and field positions
0016009808120015 F*                                                                *
0017009102150016 F******************************************************************
0018009102150017 F*                                                                *
0019001612160018 FCR135j    IP   F  263        DISK
0020000602180023 FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
0021009808120023 FSMAN      IF   F  272     3AIDISK    KEYLOC(1)
0022000107250027 FCR130P    O    F  236        PRINTER OFLIND(*INOF)
0023009102150123 D/SPACE
0024009102150124 D                UDS
0025009808120125 D  LMDY                  85     92  0
0026009702130126 D  LSORT                  8     19
0027000711300126 D  LSEQ                  21     22
0028009408240054 D  CONAME               201    240
0029000804140035 ICR135j    NS  01
0030000101250016 I                                  1    3  PCARR         L4
0031000101250039 I                                  4    6 0TRUST#        L1
0032000101250050 I                                  7    9 0SUB#          L1
0033000101250050 I                                 10   13 0ACC#          L1
0034000101250072 I                                 14   15  GRPCD
0035000101250036 I                                 16   55  ACNAM1
0036000101250050 I                                 56   58  SMANCD        L5
0037000101250072 I                                 59   73  GROUP#        L3
0038000101250072 I                                 74   77  plan          L3
0039000101250072 I                                 78   86 2BILAMT
0040000101250072 I                                 87   95 2ADJAMT
0041000101250072 I                                 96  104 2PADAMT
0042000101290037 I                                105  111 2CCOMP
0043000101290037 I                                112  120 2COMEX
0044000101290037 I                                121  127 2CAFP
0045000101290037 I                                128  136 2ADMEX
0046000101290037 I                                137  143 2CBONP
004700010129  37 I                                144  152 2BONDR
0048000101290037 I                                153  162 2TOTCO
0049000101290037 I                                163  163  CSTAT
0050000101290016 I                                164  171 0CEFFDT
0051000101290072 I                                172  179 0EFFINV
005200010129     I                                172  177 0DATEL2        L2
005300010129     I                                180  187 0CBCREC
005301161218     I                                202  208 2CLIVES
005302161218     I                                230  238 0CLIFEV
0053031612180037 I                                239  240  CCMETH
0057009102150093 ICARMST    NS
0058009102150094 I*  CARRIER MASTER FILE
0059009102150095 I                                  4   43  CNAME
0060009102150096 I                                 44   83  CNAMEC
0061009607010056 ISMAN      NS
0062009607010057 I*  SALESMAN MASTER
0063009607010059 I                                  4   21  SLNAME
0064009607010060 I                                 22   33  SFNAME
0065009102150128 C/EJECT
0066009102150129 C*
0067009102150130 C*  FIRST CYCLE INITIALIZE FIELDS
0068009102150131 C*
0069009102150132 C     FIRST         IFNE      'F'
0070009102150136 C                   MOVE      'F'           FIRST             1
007100960628     C                   TIME                    HTIME             6 0
0072009501300156 C                   EXCEPT    HEAD
0073009102150137 C                   END
0074009607010156 C   L5SMANCD        CHAIN     SMAN                               98
0075009607010156 C   L5              EXCEPT    L5DET
007600960701     C*
007700940906     C*
0078009412140156 C   L4PCARR         CHAIN     CARMST                             H4
007900960701     C*  L4      FPAGE     IFEQ 'N'
0080009607010156 C*  L4                EXCPTHEAD
0081009607010156 C*                    END
0082009607010156 C*  L4                MOVE 'N'       FPAGE   1
0083009412140156 C   L4              EXCEPT    L4DET
0084009102150172 C*
0085009606250173 C* ACCUMULATE AMOUNTS
0086009102150174 C*
0087009606250176 C                   ADD       BILAMT        TBAMT             9 2
0088009606250176 C                   ADD       ADJAMT        TAAMT             9 2
0089009606250176 C                   ADD       PADAMT        TPAMT             9 2
0090009409090179 C*
0091009409090179 C* ACCOUNT TOTALS
0092009409090179 C*
0093000107250160 CL1                 ADD       CLIVES        CTMBR             8 2
0094009606250160 CL1                 ADD       TBAMT         CTBAMT           10 2
0095009606250160 CL1                 ADD       TAAMT         CTAAMT           10 2
0096009606250160 CL1                 ADD       TPAMT         CTPAMT           10 2
0097009606250160 CL1                 ADD       COMEX         CCOMEX           10 2
0098009606250160 CL1                 ADD       ADMEX         CADMEX           10 2
0099009606250160 CL1                 ADD       BONDR         CBONDR           10 2
0100009606250160 CL1   COMEX         ADD       ADMEX         TOTCO            10 2
0101009606250160 CL1                 ADD       BONDR         TOTCO
0102009606250160 CL1                 ADD       TOTCO         CTOTCO           10 2
010300980812     C*
010400980812     CL1                 MOVE      EFFINV        @DATIN
010500980812     CL1                 EXSR      #DATYM
010600980812     CL1                 MOVE      @DATOU        EFIMDY            8 0
0107009808120111 C*
010800010129     CL1                 MOVEL     CCMETH        WCMETH            1
010900010129     CL1                 IF        WCMETH   =    *BLANKS
011000010129     CL1                 MOVEL     '%'           WCMETH
011100010129     CL1                 END
011200010203     CL1                 MOVEL     ACNAM1        ACNAMX           30
0113009606270160 CL1                 EXCEPT    L1OUT
0114009606250156 CL1 OF              EXCEPT    HEAD
0115009409060215 C*
0116009409090179 C* CARRIER TOTALS
0117009409090179 C*
0118000107250160 CL4                 ADD       CTMBR         GTMBR             9 2
0119009606250160 CL4                 ADD       CTBAMT        GTBAMT           10 2
0120009606250160 CL4                 ADD       CTAAMT        GTAAMT           10 2
0121009606250160 CL4                 ADD       CTPAMT        GTPAMT           10 2
0122009412140160 CL4                 ADD       CCOMEX        GCOMEX           10 2
0123009412140160 CL4                 ADD       CADMEX        GADMEX           10 2
0124009412140160 CL4                 ADD       CBONDR        GBONDR           10 2
0125009412140160 CL4                 ADD       CTOTCO        GTOTCO           10 2
012600941214     CL4                 EXCEPT    L4TOT
0127009501300156 CL4 OF              EXCEPT    HEAD
0128009102150215 C*
0129009607010179 C* SMAN TOTALS
0130009409090179 C*
0131000107250160 CL5                 ADD       GTMBR         FTMBR            10 2
0132009606250160 CL5                 ADD       GTBAMT        FTBAMT           11 2
0133009606250160 CL5                 ADD       GTAAMT        FTAAMT           11 2
0134009606250160 CL5                 ADD       GTPAMT        FTPAMT           11 2
0135009412140160 CL5                 ADD       GCOMEX        FCOMEX           10 2
0136009412140160 CL5                 ADD       GADMEX        FADMEX           10 2
0137009412140160 CL5                 ADD       GBONDR        FBONDR           10 2
0138009412140160 CL5                 ADD       GTOTCO        FTOTCO           10 2
013900941214     CL5                 EXCEPT    L5TOT
014000940906     CLR                 EXCEPT    LRTOT
0141009808120107 C*
0142009808120103 C***************************************************
0143009808120104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0144009808120105 C***************************************************
0145009808120107 C*
0146009808120107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0147009808120107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0148009808120107 C*
0149009808120106 C     #DATYM        BEGSR
015000980812     C                   MOVE      @DATIN        @MD               4 0
015100980812     C                   MOVEL     @DATIN        @Y                4 0
015200980812     C                   MOVEL     @MD           @DATOU            8 0
015300980812     C                   MOVE      @Y            @DATOU
015400980812     C                   MOVE      *ZEROS        @DATIN            8 0
0155009808120120 C                   ENDSR
015600980812     C*
0157000107250237 OCR130P    E            HEAD           2  2
0158009606280239 O                                           98 '*****'
0159009606280240 O                       CONAME             139
0160009606280241 O                                          145 '*****'
0161000107250237 OCR130P    E            HEAD           1
016200960628  44 O                                          128 'SUMMARY OF CARRIER PAYME'
0163009606280245 O                                          131 'NTS'
0164000107250237 OCR130P    E            HEAD           1
016500960701 248 O                                           19 'PROGRAM NAME: CR136'
0166009606280244 O                                          120 'FOR THE PERIOD :'
0167009808120254 O                       LMDY               131 '  /  /    '
0168000102090249 O                                          224 'PAGE :'
0169000102090250 O                       PAGE          Z    234
0170000107250237 OCR130P    E            HEAD           2
0171009606280253 O                                            9 'RUN DATE:'
0172009606280254 O                       UDATE         Y     20
017300960628     O                                          111 'SORTED BY:'
017400960628     O                       LSORT              124
017500970213     O                                          134 'SELECT:'
017600071130     O                       LSEQ               137
0177000102090255 O                                          224 'TIME :'
0178000102090256 O                       HTIME              234 '  :  :  '
0179000107250237 OCR130P    E            HEAD           1
0180000107250267 O                                           63 'BROKER'
0181000107250267 O                                           96 'INVOICE'
0182009606280268 O                                          111 'BILLED'
0183009606280268 O                                          128 'ADJUSTMENT'
0184009606280268 O                                          145 'PAYMENT'
0185009606280269 O                                          154 'COMM'
0186009606280269 O                                          168 'COMMISSION'
0187009606280269 O                                          179 'ADMIN FEE'
0188009606280269 O                                          193 'ADMIN FEE'
0189009606280269 O                                          202 'BONUS'
0190000102090269 O                                          217 'BONUS'
0191000102090269 O                                          234 'TOTAL'
0192000107250237 OCR130P    E            HEAD           1
0193009606280272 O                                            9 'ACCOUNT #'
0194000010120273 O                                           25 'ACCOUNT NAME'
0195000102030273 O                                           51 '#MBR'
0196000107250274 O                                           56 'CHG'
0197000107250274 O                                           61 'CODE'
0198000107250275 O                                           71 'GROUP #'
0199000107250275 O                                           84 'PLAN'
0200000107250267 O                                           96 'EFFDT'
0201009606280276 O                                          111 'AMOUNT'
0202009606280276 O                                          128 'AMOUNT'
0203009606280276 O                                          145 'AMOUNT'
0204000101290277 O                                          154 'BASE'
0205009606280278 O                                          168 'EXPENSE'
0206009606280278 O                                          193 'EXPENSE'
0207000102060278 O                                          202 'DRAW'
0208000102090278 O                                          217 'DRAW'
0209000102090278 O                                          234 'COMPENSATION'
0210000107250237 OCR130P    E            HEAD           2
0211009606280281 O                                           24 '------------------------'
0212009606280282 O                                           48 '------------------------'
0213009606280283 O                                           72 '------------------------'
0214009606280284 O                                           96 '------------------------'
0215009606280285 O                                          120 '------------------------'
0216009606280285 O                                          144 '------------------------'
0217009606280285 O                                          168 '------------------------'
0218009606280285 O                                          192 '------------------------'
0219009606280285 O                                          216 '------------------------'
0220009606280286 O                                          236 '--------------------'
0221009607010287 OCR130P    E            L5DET          2
022200960701     O                                            8 'BROKER :'
0223009607010288 O                       SMANCD              12
022400960701     O                                           14 '-'
0225009607010288 O              N98      SFNAME              27
0226009607010288 O              N98      SLNAME              46
0227009607010288 O               98                          38 '** ERROR - NOT FOUND **'
0228009606280287 OCR130P    E            L4DET          2
0229009606280288 O                       PCARR                5
023000960628     O                                            7 '-'
023100960628     O                       CNAME               48
023200010725 287 OCR130P    E            L1OUT          1
0233009606280288 O                       TRUST#               3
023400960628     O                                            4 '-'
0235009606280289 O                       SUB#                 7
023600960628     O                                            8 '-'
0237009606280290 O                       ACC#                12
0238000107250292 O                       ACNAMX              43
0239000107250292 O                       CLIVES        P     53
0240000107250292 O                       CSTAT               56
0241000107250293 O                       SMANCD              61
0242000107250293 O                       GROUP#              79
0243000107250293 O                       PLAN                84
0244000107250293 O                       EFIMDY              96 '  /  /    '
0245009606280293 O                       TBAMT         JB   111
0246009606280293 O                       TAAMT         JB   128
0247009606280293 O                       TPAMT         JB   145
0248009606280293 O                       CCOMP         3    153
0249000101290293 O                       WCMETH             154
0250009606280293 O                       COMEX         JB   168
0251009606280293 O                       CAFP          3    178
0252009606280293 O                       ADMEX         JB   193
0253009606280293 O                       CBONP         3    201
0254000102090293 O                       BONDR         JB   217
0255000102090293 O                       TOTCO         JB   234
025600010725 296 OCR130P    E            L4TOT          1
0257009606280285 O                                           96 '-----------'
0258009606280285 O                                          120 '------------------------'
0259009606280285 O                                          144 '------------------------'
0260009606280285 O                                          168 '------------------------'
0261009606280285 O                                          192 '------------------------'
0262009606280286 O                                          216 '------------------------'
026300960628D286 O                                          228 '------------'
0264009606280286 O                                          236 '--------------------'
026500010725     O                                           53 '--------------------------'
026600010725     O                                           79 '--------------------------'
026700010725     O                                           85 '------'
026800010725 296 OCR130P    E            L4TOT          1
026900010725     O                                           37 'CARRIER TOTALS :'
027000010822     O                       CTMBR         NB    53
0271009606280293 O                       CTBAMT        JB   111
0272009606280293 O                       CTAAMT        JB   128
0273009606280293 O                       CTPAMT        JB   145
0274009606280293 O                       CCOMEX        JB   168
0275009606280293 O                       CADMEX        JB   193
0276000102090293 O                       CBONDR        JB   217
0277000102090293 O                       CTOTCO        JB   234
027800010725 296 OCR130P    E            L5TOT          1
027900010725     O                                           37 'BROKER TOTALS :'
028000010822     O                       GTMBR         NB    53
0281009606280293 O                       GTBAMT        JB   111
0282009606280293 O                       GTAAMT        JB   128
0283009606280293 O                       GTPAMT        JB   145
0284009606280293 O                       GCOMEX        JB   168
0285009606280293 O                       GADMEX        JB   193
0286000102090293 O                       GBONDR        JB   217
0287000102090293 O                       GTOTCO        JB   234
028800010725 296 OCR130P    E            LRTOT          1
028900010725     O                                           37 'FINAL TOTALS :'
029000010822     O                       FTMBR         NB    53
0291009606280293 O                       FTBAMT        JB   111
0292009606280293 O                       FTAAMT        JB   128
0293009606280293 O                       FTPAMT        JB   145
0294009606280293 O                       FCOMEX        JB   168
0295009606280293 O                       FADMEX        JB   193
0296000102090293 O                       FBONDR        JB   217
0297000102090293 O                       FTOTCO        JB   234
