0001009102150002 F******************************************************************
0002009909300003 F* CR137      GROUP BENEFIT SERVICES SOFTWARE           1994      *
0003009102150004 F*                                                                *
0004009510040004 F*          DLK - 10/4/95                                         *
0005009510040004 F*                                                                *
0006009510040013 F*  DESCRIPTION - THIS PROGRAM WILL REPRINT A SUMMARY OF CARRIER  *
0007009510040014 F*                PAYMENTS FROM THE CR130HST FILE BY DATE RANGE   *
0008009607020015 F*                IN ACC NAME ORDER                               *
0009009808120014 F*                                                                *
0010009808120010 F*  Y2K CONVERT - 1998                                            *
001100991027     F*  DMA  10.27.99   Changed date level break to CCYYMM            *
0012000008010015 F*  dlk  08/01/00   add commission override at plan level         *
001300001012     F*  DLK  10/12/00 - change group # to 15 in invdet                *
0014000101250015 F*  jva  01/25/01   ext CR130HST file.                            *
0015000102120015 F*  ksj  02/12/01   Moved last two fields in prtf two positions   *
0016000102120015 F*                   to the left                                  *
0016010202060015 F*  KSJ  02/04/02   Added Market Size and changed Broker Code     *
0016020202060015 F*                  to Agency Code                                *
0016031611170015 F*  dlk  11/17/2016 cahnge input file to cr135j
0017009808120015 F*                                                                *
0018009102150016 F******************************************************************
0019009102150017 F*                                                                *
0020001611170018 FCR135j    IP   E           K DISK
0021000602180023 FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
0022009808120023 FSMAN      IF   F  272     3AIDISK    KEYLOC(1)
0023000202050018 FAGENCY    IF   E           K DISK
0024000202050027 FCR130P    O    F  236        PRINTER OFLIND(*INOF)
0025009102150124 D                UDS
0026009808120125 D  LFYMD                 85     92  0
0027009808120125 D  LFY                   85     88  0
0028009808120125 D  LFMD                  89     92  0
0029009808120125 D  LTYMD                 93    100  0
0030009808120125 D  LTY                   93     96  0
0031009808120125 D  LTMD                  97    100  0
0032009802270054 D  LBONLY               199    199
0033009408240054 D  CONAME               201    240
0034009408240055 D  TIME                 242    247  0
0035000101250124 D                 DS                  INZ
0036000101250125 D  EFFINV                 1      8  0
0037000101250125 D  CEFIYY                 1      4  0
0038000101250125 D  CEFIMM                 5      6  0
0039000101250125 D  CEFIDD                 7      8  0
0040000101250035 ICRHSTR        01
0041000101250016 I                                          CCARCD        L4
0042000101250039 I                                          CTRUST        L2
0043000101250050 I                                          CSUB          L2
0044000101250050 I                                          CACCT         L2
0045000202050050 I*                                         CBCODE        L5
0046000101250072 I                                          CGROUP        L2
0047000101250072 I                                          CPLAN         L2
0048000101250016 I                                          CEFFDT        L3
004900010125     I                                          CEFIYY        L1
005000010125     I                                          CEFIMM        L1
005001020205     I                                          CAGCOD        L5
0051009102150093 ICARMST    NS
0052009102150094 I*  CARRIER MASTER FILE
0053009102150095 I                                  4   43  CNAME
0054009102150096 I                                 44   83  CNAMEC
0055009607020056 ISMAN      NS
0056009607020057 I*  SALESMAN MASTER
0057009607020059 I                                  4   21  SLNAME
0058009607020060 I                                 22   33  SFNAME
0059009102150128 C/EJECT
0060009102150129 C*
0061009102150130 C*  FIRST CYCLE INITIALIZE FIELDS
0062009102150131 C*
0063009102150132 C     FIRST         IFNE      'F'
0064009102150136 C                   MOVE      'F'           FIRST             1
0065009501300156 C                   EXCEPT    HEAD
0066009102150137 C                   END
0067009607020131 C*
006800980227     C     *INL5         IFEQ      *ON
0069000202050156 C**   CBCODE        CHAIN     SMAN                               98
0070000202050156 C     CAGCOD        CHAIN     AGENCY                             98
0071009802270156 C                   EXCEPT    L5DET
007200980227     C                   END
007300940906     C*
007400020204     C* LBONLY = Y - AGENCY TOTALS ONLY
007500980227     C*
007600980227     C     *INL4         IFEQ      *ON
007700980227     C     LBONLY        ANDNE     'Y'
0078000101250156 C     CCARCD        CHAIN     CARMST                             H4
0079009802270156 C                   EXCEPT    L4DET
008000980227     C                   END
0081009409090179 C*
0082009510040179 C* DETAIL OUTPUT
0083009409090179 C*
0084000101250160 C                   ADD       CBAMT         CTBAMT           10 2
0085000101250160 C                   ADD       CAAMT         CTAAMT           10 2
0086000101250160 C                   ADD       CPAMT         CTPAMT           10 2
0087000101250160 C                   ADD       CCOME         CCOMEX           10 2
0088000101250160 C                   ADD       CADME         CADMEX           10 2
0089000101250160 C                   ADD       CBOND         CBONDR           10 2
0090000101250160 C     CCOME         ADD       CADME         CTOTC            10 2
0091000101250160 C                   ADD       CBOND         CTOTC
0092000101250160 C                   ADD       CTOTC         CTOTCO           10 2
009300980812     C*
009400980812     C                   MOVE      EFFINV        @DATIN
009500980812     C                   EXSR      #DATYM
009600980812     C                   MOVE      @DATOU        EFIMDY            8 0
0097009808120111 C*
009800980812     C                   MOVE      CEFFDT        @DATIN
009900980812     C                   EXSR      #DATYM
010000980812     C                   MOVE      @DATOU        CEFMDY            8 0
010100980812     C*
010200980227     C*
010300020204     C* LBONLY = Y - AGENCY TOTALS ONLY
010400980227     C*
010500980227     C     LBONLY        IFNE      'Y'
010600010125     C     CCOMP         MULT      100           WCOMP             5 2
010700010125     C     CADMP         MULT      100           WADMP             5 2
010800010125     C     CBONP         MULT      100           WBONP             5 2
010900010129     C                   MOVEL     CCMETH        WCMETH            1
011000010129     C                   IF        WCMETH   =    *BLANKS
011100010129     C                   MOVEL     '%'           WCMETH
011200010129     C                   END
011300020205     C                   MOVEL     CACNAM        CACNAX           23
0114009802270160 C                   EXCEPT    OUT
0115009802270156 C   OF              EXCEPT    HEAD
011600980227     C                   END
011700980227     C*
011800980227     C*
011900010125     C                   MOVE      *ZEROS        CBAMT
012000010125     C                   MOVE      *ZEROS        CAAMT
012100010125     C                   MOVE      *ZEROS        CPAMT
012200010125     C                   MOVE      *ZEROS        CCOME
012300010125     C                   MOVE      *ZEROS        CADME
012400010125     C                   MOVE      *ZEROS        CBOND
012500010125     C                   MOVE      *ZEROS        CTOTC
0126009607020215 C*
0127009607020179 C* CARRIER TOTALS
0128009607020179 C*
0129009607020160 CL4                 ADD       CTBAMT        GTBAMT           11 2
0130009607020160 CL4                 ADD       CTAAMT        GTAAMT           11 2
0131009607020160 CL4                 ADD       CTPAMT        GTPAMT           11 2
0132009607020160 CL4                 ADD       CCOMEX        GCOMEX           11 2
0133009607020160 CL4                 ADD       CADMEX        GADMEX           11 2
0134009607020160 CL4                 ADD       CBONDR        GBONDR           11 2
0135009607020160 CL4                 ADD       CTOTCO        GTOTCO           11 2
013600980227     C*
013700020204     C* LBONLY = Y - AGENCY TOTALS ONLY
013800980227     C*
013900980227     CL4   LBONLY        IFNE      'Y'
014000980227     CL4                 EXCEPT    L4TOT
0141009607020156 CL4 OF              EXCEPT    HEAD
014200980227     CL4                 END
014300980227     C*
014400980227     CL4                 MOVE      *ZEROS        CTBAMT
014500980227     CL4                 MOVE      *ZEROS        CTAAMT
014600980227     CL4                 MOVE      *ZEROS        CTPAMT
014700980227     CL4                 MOVE      *ZEROS        CCOMEX
014800980227     CL4                 MOVE      *ZEROS        CADMEX
014900980227     CL4                 MOVE      *ZEROS        CBONDR
015000980227     CL4                 MOVE      *ZEROS        CTOTCO
0151009607020215 C*
0152009607020179 C* SMAN TOTALS
0153009607020179 C*
0154009607020160 CL5                 ADD       GTBAMT        FTBAMT           12 2
0155009607020160 CL5                 ADD       GTAAMT        FTAAMT           12 2
0156009607020160 CL5                 ADD       GTPAMT        FTPAMT           12 2
0157009607020160 CL5                 ADD       GCOMEX        FCOMEX           11 2
0158009607020160 CL5                 ADD       GADMEX        FADMEX           11 2
0159009607020160 CL5                 ADD       GBONDR        FBONDR           11 2
0160009607020160 CL5                 ADD       GTOTCO        FTOTCO           11 2
016100960702     CL5                 EXCEPT    L5TOT
0162009802270156 CL5 OF              EXCEPT    HEAD
016300960702     C*
016400960702     CLR                 EXCEPT    LRTOT
0165009808120107 C*
0166009808120103 C***************************************************
0167009808120104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0168009808120105 C***************************************************
0169009808120107 C*
0170009808120107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0171009808120107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0172009808120107 C*
0173009808120106 C     #DATYM        BEGSR
017400980812     C                   MOVE      @DATIN        @MD               4 0
017500980812     C                   MOVEL     @DATIN        @Y                4 0
017600980812     C                   MOVEL     @MD           @DATOU            8 0
017700980812     C                   MOVE      @Y            @DATOU
017800980812     C                   MOVE      *ZEROS        @DATIN            8 0
0179009808120120 C                   ENDSR
018000980812     C*
0181000202050237 OCR130P    E            HEAD           2  2
0182009607020239 O                                           98 '*****'
0183009607020240 O                       CONAME             139
0184009607020241 O                                          145 '*****'
0185000202050237 OCR130P    E            HEAD           1
018600960702  44 O                                          128 'HISTORY OF CARRIER PAYME'
0187009607020245 O                                          131 'NTS'
0188000202050237 OCR130P    E            HEAD           1
0189009607020248 O                                           19 'PROGRAM NAME: CR138'
0190009607020244 O                                          120 'FOR THE PERIOD :'
0191009808120254 O                       LFMD               124 '  /  '
0192009808120254 O                                          125 '/'
0193009808120254 O                       LFY                129
0194009808120254 O                                          131 '-'
0195009808120254 O                       LTMD               137 '  /  '
0196009808120254 O                                          138 '/'
0197009808120254 O                       LTY                142
0198000102090249 O                                          224 'PAGE :'
0199000102090250 O                       PAGE          Z    234
0200000202050237 OCR130P    E            HEAD           2
0201009501300253 O                                            9 'RUN DATE:'
0202009501300254 O                       UDATE         Y     20
020300020204     O                                          129 'SORTED BY: AGENCY CODE '
020400020204     O                                          155 'AGENCY TOTALS ONLY:'
0205009802270254 O                       LBONLY             157
0206000102090255 O                                          224 'TIME :'
0207000102090256 O                       TIME               234 '  :  :  '
0208000202050237 OCR130P    E            HEAD           1
020900020204     O                                           44 'MARKET'
0210009607020267 O                                           66 'REMIT'
0211000010120267 O                                           98 'INVOICE'
0212000010120268 O                                          112 'BILLED'
0213009607020268 O                                          128 'ADJUSTMENT'
0214009607020268 O                                          145 'PAYMENT'
0215009607020269 O                                          154 'COMM'
0216009607020269 O                                          168 'COMMISSION'
0217009607020269 O                                          179 'ADMIN FEE'
0218009607020269 O                                          193 'ADMIN FEE'
0219009607020269 O                                          202 'BONUS'
0220000102090269 O                                          217 'BONUS'
0221000102090269 O                                          234 'TOTAL'
0222000202050237 OCR130P    E            HEAD           1
022300020204     O                                           42 'SIZE'
0224009607020272 O                                            9 'ACCOUNT #'
0225000010120273 O                                           25 'ACCOUNT NAME'
0226000102030273 O                                           51 '#MBR'
0227000010120274 O                                           55 'CHG'
0228009607020274 O                                           66 'DATE'
0229000010120275 O                                           74 'GROUP #'
0230000010120275 O                                           87 'PLAN'
0231000010120267 O                                           98 'EFFDT'
0232000010120276 O                                          112 'AMOUNT'
0233009607020276 O                                          128 'AMOUNT'
0234009607020276 O                                          145 'AMOUNT'
0235000101290277 O                                          154 'BASE'
0236009607020278 O                                          168 'EXPENSE'
0237009607020278 O                                          193 'EXPENSE'
0238000102060278 O                                          202 'DRAW'
0239000102090278 O                                          217 'DRAW'
0240000102090278 O                                          234 'COMPENSATION'
0241000202050237 OCR130P    E            HEAD           2
0242009607020281 O                                           24 '------------------------'
0243009607020282 O                                           48 '------------------------'
0244009607020283 O                                           72 '------------------------'
0245009607020284 O                                           96 '------------------------'
0246009607020285 O                                          120 '------------------------'
0247009607020285 O                                          144 '------------------------'
0248009607020285 O                                          168 '------------------------'
0249009607020285 O                                          192 '------------------------'
0250009607020285 O                                          216 '------------------------'
0251009607020286 O                                          236 '--------------------'
0252000202040287 OCR130P    E            L5DET          2
025300020204     O                                            8 'AGENCY :'
0254000202050288 O                       CAGCOD              12
025500960702     O                                           14 '-'
0256000202050288 O              N98      AGNAM1              55
0257009607020288 O               98                          38 '** ERROR - NOT FOUND **'
0258000101250287 OCR130P    E            L4DET          2
0259000101250288 O                       CCARCD               5
026000940906     O                                            7 '-'
026100940906     O                       CNAME               48
026200010125 287 OCR130P    E            OUT            1
0263000101250288 O                       CTRUST               3
026400960702     O                                            4 '-'
0265000101250289 O                       CSUB                 7
026600960702     O                                            8 '-'
0267000101250290 O                       CACCT               12
0268000202050292 O                       CACNAX              36
0269000202040292 O                       CLIVES        P     53
0270000010120292 O                       CSTAT               55
0271000010120293 O                       CEFMDY              66 '  /  /    '
027200020204     O                       CMKSZ               43
0273000101250293 O                       CGROUP              82
0274000101250293 O                       CPLAN               87
0275000010120293 O                       EFIMDY              98 '  /  /    '
0276000101250293 O                       CBAMT         J    112
0277000101250293 O                       CAAMT         J    128
0278000101250293 O                       CPAMT         J    145
0279000101250293 O                       WCOMP         3    153
0280000101290293 O                       WCMETH             154
0281000101250293 O                       CCOME         J    168
0282000101250293 O                       WADMP         3    178
0283000101250293 O                       CADME         J    193
0284000101250293 O                       WBONP         3    201
0285000102090293 O                       CBOND         J    217
0286000102090293 O                       CTOTC         J    234
028700960702 296 OCR130P    E            L4TOT          1
0288009607020285 O                                           96 '-----------'
0289009607020285 O                                          120 '------------------------'
0290009607020285 O                                          144 '------------------------'
0291009607020285 O                                          168 '------------------------'
0292009607020285 O                                          192 '------------------------'
0293009607020286 O                                          216 '------------------------'
029400960702D286 O                                          228 '------------'
0295009607020286 O                                          236 '--------------------'
029600960702 296 OCR130P    E            L4TOT          1
029700960702     O                                           94 'CARRIER TOTALS :'
0298000010120293 O                       CTBAMT        J    112
0299009802270293 O                       CTAAMT        J    128
0300009802270293 O                       CTPAMT        J    145
0301009802270293 O                       CCOMEX        J    168
0302009802270293 O                       CADMEX        J    193
0303000102090293 O                       CBONDR        J    217
0304000102090293 O                       CTOTCO        J    234
030500020204 296 OCR130P    E            L5TOT          1
030600020204     O                                           94 'AGENCY TOTALS :'
0307000010120293 O                       GTBAMT        JB   112
0308009607020293 O                       GTAAMT        JB   128
0309009607020293 O                       GTPAMT        JB   145
0310009607020293 O                       GCOMEX        JB   168
0311009607020293 O                       GADMEX        JB   193
0312000102090293 O                       GBONDR        JB   217
0313000102090293 O                       GTOTCO        JB   234
031400960702 296 OCR130P    E            LRTOT          1
031500960702     O                                           94 'FINAL TOTALS :'
0316000010120293 O                       FTBAMT        JB   112
0317009607020293 O                       FTAAMT        JB   128
0318009607020293 O                       FTPAMT        JB   145
0319009607020293 O                       FCOMEX        JB   168
0320009607020293 O                       FADMEX        JB   193
0321000102090293 O                       FBONDR        JB   217
0322000102090293 O                       FTOTCO        JB   234
