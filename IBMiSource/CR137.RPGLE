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
0014000101240015 F*  jva  01/24/01   ext CR130HST file.                            *
0015000102120015 F*  ksj  02/12/01   Moved last two fields in prtf two positions   *
0016000102120015 F*                   to the left                                  *
0017000107260014 F*  ksj   7/25/01   Added the following totals for #Mbr fields:   *
0018000107260014 F*                  Carrier, Group Code and Final Totals          *
0018010202060014 F*  KSJ   2/04/02   Added Market Size                             *
0018020908060015 F*  dlk  08/06/2009 fix page break so it breaks when the carrier  *
0018030908060015 F*                  or the carrier group code changes (l5 or l6)  *
0018041508130015 F*  dlk  08/13/2015 add group code to group code total line       *
0018051611170015 F*  dlk  11/17/2016 cahnge input file to cr135j
0019009808120015 F*                                                                *
0020009102150016 F******************************************************************
0021009102150017 F*                                                                *
0022001611170018 FCR135j    IP   E             DISK
0023000602180023 FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
0024000202050027 FCR130P    O    F  236        PRINTER OFLIND(*INOF)
0025009102150124 D                UDS
0026009808120125 D  LFYMD                 85     92  0
0027009808120125 D  LFY                   85     88  0
0028009808120125 D  LFMD                  89     92  0
0029009808120125 D  LTYMD                 93    100  0
0030009808120125 D  LTY                   93     96  0
0031009808120125 D  LTMD                  97    100  0
0032009408240054 D  CONAME               201    240
0033009408240055 D  TIME                 242    247  0
0034000101240124 D                 DS                  INZ
0035000101240125 D  CEFINV                 1      8  0
0036000101240125 D  CEFIYY                 1      4  0
0037000101240125 D  CEFIMM                 5      6  0
0038000101240125 D  CEFIDD                 7      8  0
0039000101240035 ICRHSTR        01
0040000101240016 I                                          CCARCD        L5
0041000101240039 I                                          CTRUST        L4
0042000101240050 I                                          CSUB          L4
0043000101240050 I                                          CACCT         L4
0044000101240072 I                                          CGRPCD        L6
0045000101240036 I                                          CACNAM
0046000101240072 I                                          CGROUP        L2
0047000101240072 I                                          CPLAN         L2
0048000101240072 I                                          CBAMT
0049000101240072 I                                          CAAMT
0050000101240072 I                                          CPAMT
0051000101240016 I                                          CEFFDT        L3
005200010125     I                                          CEFIYY        L1
005300010125     I                                          CEFIMM        L1
0054009102150093 ICARMST    NS
0055009102150094 I*  CARRIER MASTER FILE
0056009102150095 I                                  4   43  CNAME
0057009102150096 I                                 44   83  CNAMEC
0058009102150128 C/EJECT
0059009102150129 C*
0060009102150130 C*  FIRST CYCLE INITIALIZE FIELDS
0061009102150131 C*
0062009102150132 C     FIRST         IFNE      'F'
0063009102150136 C                   MOVE      'F'           FIRST             1
0064009501300156 C                   EXCEPT    HEAD
0065009102150137 C                   END
006501090806
006503090806      * page break on carrier change (L5)
006504090806
006505090806     c                   if        *inl5
006506090806     C     FPAGE         IFEQ      'N'
0065070908060156 C                   EXCEPT    HEAD
0065080908060156 C                   END
0065090908060156 C                   MOVE      'N'           FPAGE             1
006510090806     c                   end
006511090806
0066009607020156 C   L6              EXCEPT    L6DET
006700940906     C*
006701090806     c                   if        *inl5
0068000908060156 C     CCARCD        CHAIN     CARMST                             H4
0073000908060156 C                   EXCEPT    L5DET
0073010908060156 C                   END
0074009409090179 C*
0075009510040179 C* DETAIL OUTPUT
0076009409090179 C*
0077009607020179 C*
0078000107250160 C                   ADD       CLIVES        CTMBR             8 2
0079000101240160 C                   ADD       CBAMT         CTBAMT           10 2
0080000101240160 C                   ADD       CAAMT         CTAAMT           10 2
0081000101240160 C                   ADD       CPAMT         CTPAMT           10 2
0082000101240160 C                   ADD       CCOME         CCOMEX           10 2
0083000101240160 C                   ADD       CADME         CADMEX           10 2
0084000101240160 C                   ADD       CBOND         CBONDR           10 2
0085000101240160 C     CCOME         ADD       CADME         CTOTC            10 2
0086000101240160 C                   ADD       CBOND         CTOTC
0087000101240160 C                   ADD       CTOTC         CTOTCO           10 2
008800980812     C*
008900010124     C                   MOVE      CEFINV        @DATIN
009000980812     C                   EXSR      #DATYM
009100980812     C                   MOVE      @DATOU        EFIMDY            8 0
0092009808120111 C*
009300980812     C                   MOVE      CEFFDT        @DATIN
009400980812     C                   EXSR      #DATYM
009500980812     C                   MOVE      @DATOU        CEFMDY            8 0
009600960702     C*
009700010125     C     CCOMP         MULT      100           WCOMP             5 2
009800010125     C     CADMP         MULT      100           WADMP             5 2
009900010125     C     CBONP         MULT      100           WBONP             5 2
010000010129     C                   MOVEL     CCMETH        WCMETH            1
010100010129     C                   IF        WCMETH   =    *BLANKS
010200010129     C                   MOVEL     '%'           WCMETH
010300010129     C                   END
010400020205     C                   MOVEL     CACNAM        CACNAX           23
0105009607020160 C                   EXCEPT    OUT
0106009607020156 C   OF              EXCEPT    HEAD
0107009607020215 C*
0108009607020179 C* CARRIER TOTALS
0109009607020179 C*
0110000107250160 CL5                 ADD       CTMBR         GTMBR             9 2
0111009607020160 CL5                 ADD       CTBAMT        GTBAMT           11 2
0112009607020160 CL5                 ADD       CTAAMT        GTAAMT           11 2
0113009607020160 CL5                 ADD       CTPAMT        GTPAMT           11 2
0114009607020160 CL5                 ADD       CCOMEX        GCOMEX           11 2
0115009607020160 CL5                 ADD       CADMEX        GADMEX           11 2
0116009607020160 CL5                 ADD       CBONDR        GBONDR           11 2
0117009607020160 CL5                 ADD       CTOTCO        GTOTCO           11 2
011800960702     CL5                 EXCEPT    L5TOT
0119009607020156 CL5 OF              EXCEPT    HEAD
0120009607020215 C*
0121009607020179 C* GROUP TOTALS
0122009607020179 C*
0123000107250160 CL6                 ADD       GTMBR         FTMBR            10 2
0124009607020160 CL6                 ADD       GTBAMT        FTBAMT           12 2
0125009607020160 CL6                 ADD       GTAAMT        FTAAMT           12 2
0126009607020160 CL6                 ADD       GTPAMT        FTPAMT           12 2
0127009607020160 CL6                 ADD       GCOMEX        FCOMEX           11 2
0128009607020160 CL6                 ADD       GADMEX        FADMEX           11 2
0129009607020160 CL6                 ADD       GBONDR        FBONDR           11 2
0130009607020160 CL6                 ADD       GTOTCO        FTOTCO           11 2
013100960702     CL6                 EXCEPT    L6TOT
013200960702     C*
013300960702     CLR                 EXCEPT    LRTOT
0134009808120107 C*
0135009808120103 C***************************************************
0136009808120104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0137009808120105 C***************************************************
0138009808120107 C*
0139009808120107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0140009808120107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0141009808120107 C*
0142009808120106 C     #DATYM        BEGSR
014300980812     C                   MOVE      @DATIN        @MD               4 0
014400980812     C                   MOVEL     @DATIN        @Y                4 0
014500980812     C                   MOVEL     @MD           @DATOU            8 0
014600980812     C                   MOVE      @Y            @DATOU
014700980812     C                   MOVE      *ZEROS        @DATIN            8 0
0148009808120120 C                   ENDSR
014900980812     C*
0150009607020237 OCR130P    E            HEAD           2  2
0151009607020239 O                                           98 '*****'
0152009607020240 O                       CONAME             139
0153009607020241 O                                          145 '*****'
0154009607020237 OCR130P    E            HEAD           1
015500960702  44 O                                          128 'HISTORY OF CARRIER PAYME'
0156009607020245 O                                          131 'NTS'
0157009607020237 OCR130P    E            HEAD           1
0158009510040248 O                                           19 'PROGRAM NAME: CR137'
0159009607020244 O                                          120 'FOR THE PERIOD :'
0160009808120254 O                       LFMD               124 '  /  '
0161009808120254 O                                          125 '/'
0162009808120254 O                       LFY                129
0163009607020254 O                                          131 '-'
0164009808120254 O                       LTMD               137 '  /  '
0165009808120254 O                                          138 '/'
0166009808120254 O                       LTY                142
0167000102090249 O                                          224 'PAGE :'
0168000102090250 O                       PAGE          Z    234
0169009607020237 OCR130P    E            HEAD           2
0170009501300253 O                                            9 'RUN DATE:'
0171009501300254 O                       UDATE         Y     20
017200960702     O                                          129 'SORTED BY: ACCOUNT NAME'
0173000102090255 O                                          224 'TIME :'
0174000102090256 O                       TIME               234 '  :  :  '
0175009607020237 OCR130P    E            HEAD           1
017600020204     O                                           44 'MARKET'
0177000010120267 O                                           66 'REMIT'
0178000010120267 O                                           98 'INVOICE'
0179000010120268 O                                          112 'BILLED'
0180009607020268 O                                          128 'ADJUSTMENT'
0181009607020268 O                                          145 'PAYMENT'
0182009607020269 O                                          154 'COMM'
0183009607020269 O                                          168 'COMMISSION'
0184009607020269 O                                          179 'ADMIN FEE'
0185009607020269 O                                          193 'ADMIN FEE'
0186009607020269 O                                          202 'BONUS'
0187000102090269 O                                          217 'BONUS'
0188000102090269 O                                          234 'TOTAL'
0189009607020237 OCR130P    E            HEAD           1
019000020204     O                                           42 'SIZE'
0191009607020272 O                                            9 'ACCOUNT #'
0192000010120273 O                                           25 'ACCOUNT NAME'
0193000107250273 O                                           52 '#MBR'
0194000107250274 O                                           56 'CHG'
0195000010120274 O                                           66 'DATE'
0196000010120275 O                                           74 'GROUP #'
0197000010120275 O                                           87 'PLAN'
0198000010120267 O                                           98 'EFFDT'
0199000010120276 O                                          112 'AMOUNT'
0200009607020276 O                                          128 'AMOUNT'
0201009607020276 O                                          145 'AMOUNT'
0202000101290277 O                                          154 'BASE'
0203009607020278 O                                          168 'EXPENSE'
0204009607020278 O                                          193 'EXPENSE'
0205000102060278 O                                          202 'DRAW'
0206000102090278 O                                          217 'DRAW'
0207000102090278 O                                          234 'COMPENSATION'
0208009607020237 OCR130P    E            HEAD           2
0209009607020281 O                                           24 '------------------------'
0210009607020282 O                                           48 '------------------------'
0211009607020283 O                                           72 '------------------------'
0212009607020284 O                                           96 '------------------------'
0213009607020285 O                                          120 '------------------------'
0214009607020285 O                                          144 '------------------------'
0215009607020285 O                                          168 '------------------------'
0216009607020285 O                                          192 '------------------------'
0217009607020285 O                                          216 '------------------------'
0218009607020286 O                                          236 '--------------------'
0219000101240287 OCR130P    E            L6DET          2
0220000101240288 O                       CGRPCD               2
022100940906     O                                           15 '- GROUP CODE'
0222000101240287 OCR130P    E            L5DET          2
0223000101240288 O                       CCARCD               5
022400940906     O                                            7 '-'
022500940906     O                       CNAME               48
022600020205 287 OCR130P    E            OUT            1
0227000101240288 O                       CTRUST               3
022800960702     O                                            4 '-'
0229000101240289 O                       CSUB                 7
023000960702     O                                            8 '-'
0231000101240290 O                       CACCT               12
0232000202050292 O                       CACNAX              36
0233000107250292 O                       CLIVES        P     53
0234000010120292 O                       CSTAT               55
0235000010120293 O                       CEFMDY              66 '  /  /    '
0236000101240293 O                       CGROUP              82
023700020204     O                       CMKSZ               43
0238000101240293 O                       CPLAN               87
0239000010120293 O                       EFIMDY              98 '  /  /    '
0240000101240293 O                       CBAMT         JB   112
0241000101240293 O                       CAAMT         JB   128
0242000101240293 O                       CPAMT         JB   145
0243000101240293 O                       WCOMP         3    153
0244000101290293 O                       WCMETH             154
0245000101240293 O                       CCOME         JB   168
0246000101240293 O                       WADMP         3    178
0247000101240293 O                       CADME         JB   193
0248000101240293 O                       WBONP         3    201
0249000102090293 O                       CBOND         JB   217
0250000102090293 O                       CTOTC         JB   234
025100960702 296 OCR130P    E            L5TOT          1
0252009607020285 O                                           96 '-----------'
0253009607020285 O                                          120 '------------------------'
0254009607020285 O                                          144 '------------------------'
0255009607020285 O                                          168 '------------------------'
0256009607020285 O                                          192 '------------------------'
0257009607020286 O                                          216 '------------------------'
025800960702D286 O                                          228 '------------'
0259009607020286 O                                          236 '--------------------'
026000010725     O                                           52 '--------------------------'
026100010725     O                                           78 '--------------------------'
026200010725     O                                           85 '-------'
026300960702 296 OCR130P    E            L5TOT          1
026400010725     O                                           35 'CARRIER TOTALS :'
026500010822     O                       CTMBR         NB    53
0266000010120293 O                       CTBAMT        JB   112
0267009607020293 O                       CTAAMT        JB   128
0268009607020293 O                       CTPAMT        JB   145
0269009607020293 O                       CCOMEX        JB   168
0270009607020293 O                       CADMEX        JB   193
0271000102090293 O                       CBONDR        JB   217
0272000102090293 O                       CTOTCO        JB   234
027300010725 296 OCR130P    E            L6TOT          1
027401150813     O                                           23 'GROUP CODE'
027402150813     O                       cgrpcd              26
027403150813     O                                           35 'TOTALS :'
027500010822     O                       GTMBR         NB    53
0276000010120293 O                       GTBAMT        JB   112
0277009607020293 O                       GTAAMT        JB   128
0278009607020293 O                       GTPAMT        JB   145
0279009607020293 O                       GCOMEX        JB   168
0280009607020293 O                       GADMEX        JB   193
0281000102090293 O                       GBONDR        JB   217
0282000102090293 O                       GTOTCO        JB   234
028300010725 296 OCR130P    E            LRTOT          1
028400010725     O                                           35 'FINAL TOTALS :'
028500010822     O                       FTMBR         NB    53
0286000010120293 O                       FTBAMT        JB   112
0287009607020293 O                       FTAAMT        JB   128
0288009607020293 O                       FTPAMT        JB   145
0289009607020293 O                       FCOMEX        JB   168
0290009607020293 O                       FADMEX        JB   193
0291000102090293 O                       FBONDR        JB   217
0292000102090293 O                       FTOTCO        JB   234
