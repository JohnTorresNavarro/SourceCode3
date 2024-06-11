0001009102150002 F******************************************************************
0002000804150003 F* cr135b     GROUP BENEFIT SERVICES SOFTWARE           1994      *
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
0015000107260014 F*                  Carrier, Group Code and Final Totals          *
0016000202060014 F*  KSJ   2/04/02   Added Market Size and changed Broker Code     *
0017000202060014 F*                  to Agency Code                                *
0018000303310015 F*  SSK   3/31/2003 RECORD LENGTH CHANGED FOR CR135               *
0019000305010015 F*  ssk   5/01/2003 salesman relationship project                 *
0019010711300015 F*  dlk  11/30/2007 change cr135 file length to match cr130hs*    *
0019020804150015 F*  dlk  04/15/2008 This pgm is a copy of cr135 just for crt130HCL*
0020000804150015 F*                  to use because of the primary file change in  *
0020010804150015 F*                  cr135.                                        *
0020020908060015 F*  dlk  08/06/2009 fix page break so it breaks when the carrier  *
0020030908060015 F*                  or the carrier group code changes (l4 or l5)  *
0020041508130015 F*  dlk  08/13/2015 add group code to group code total line       *
0020061612180015 F*  dlk  12/16/2016 increase rec len of cr135 and field positions
0020070804150015 F*                                                                *
0021009102150016 F******************************************************************
0022009102150017 F*                                                                *
0023001612160018 FCR135     IP   F  263        DISK
0024000602180023 FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
0025000202050027 FCR130P    O    F  236        PRINTER OFLIND(*INOF)
002600030501   X***X
0027009102150124 D                UDS
0028009808120125 D  LMDY                  85     92  0
0029009408260126 D  LSORT                  8     19
0030000711300126 D  lseq                  21     22
0031009408240054 D  CONAME               201    240
003200030501   X***X
0033009606270035 ICR135     NS  01
0034000101250016 I                                  1    3  PCARR         L4
0035000101250039 I                                  4    6 0TRUST#        L1
0036000101250050 I                                  7    9 0SUB#          L1
0037000101250050 I                                 10   13 0ACC#          L1
0038000101250072 I                                 14   15  GRPCD         L5
0039000101250036 I                                 16   55  ACNAM1
0040000305010050 I                                 56   58  SMANCD
0041000101250072 I                                 59   73  GROUP#        L3
0042000101250072 I                                 74   77  plan          L3
0043000101250072 I                                 78   86 2BILAMT
0044000101250072 I                                 87   95 2ADJAMT
0045000101250072 I                                 96  104 2PADAMT
0046000101290037 I                                105  111 2CCOMP
0047000101290037 I                                112  120 2COMEX
0048000101290037 I                                121  127 2CAFP
0049000101290037 I                                128  136 2ADMEX
0050000101290037 I                                137  143 2CBONP
005100010129  37 I                                144  152 2BONDR
0052000101290037 I                                153  162 2TOTCO
0053000101290037 I                                163  163  CSTAT
0054000101290016 I                                164  171 0CEFFDT
0055000101290072 I                                172  179 0EFFINV
005600010129     I                                172  177 0DATEL2        L2
005700010129     I                                180  187 0CBCREC
005701161218     I                                202  208 2CLIVES
005702161218     I                                230  238 0CLIFEV
0057031612180037 I                                239  240  CCMETH
0057041612180037 I                                245  247  CAGCOD
0057051612180037 I                                248  252  CMKSZ
006300030501    ***
0064009102150093 ICARMST    NS
0065009102150094 I*  CARRIER MASTER FILE
0066009102150095 I                                  4   43  CNAME
0067009102150096 I                                 44   83  CNAMEC
006800030501   X***X
0069009102150129 C*
0070009102150130 C*  FIRST CYCLE INITIALIZE FIELDS
0071009102150131 C*
0072009102150132 C     FIRST         IFNE      'F'
0073009102150136 C                   MOVE      'F'           FIRST             1
007400960628     C                   TIME                    HTIME             6 0
0075009602020156 C     PCARR         CHAIN     CARMST                             H4
0076009501300156 C                   EXCEPT    HEAD
0077009102150137 C                   END
007701090806
007702090806      * page break on carrier change (L4)
007703090806
007704090806     c                   if        *inl4
0077050908240156 C     PCARR         CHAIN     CARMST                             H4
007706090806     C     FPAGE         IFEQ      'N'
0077070908060156 C                   EXCEPT    HEAD
0077080908060156 C                   END
0077090908060156 C                   MOVE      'N'           FPAGE             1
007710090806     c                   end
007711090806
0078009412140156 C   L5              EXCEPT    L5DET
007900940906     C*
007901090806     c                   if        *inl4
0085000908060156 C                   EXCEPT    L4DET
0085010908060156 C                   END
0086009102150172 C*
0087009606250173 C* ACCUMULATE AMOUNTS
0088009102150174 C*
0089009606250176 C                   ADD       BILAMT        TBAMT             9 2
0090009606250176 C                   ADD       ADJAMT        TAAMT             9 2
0091009606250176 C                   ADD       PADAMT        TPAMT             9 2
0092009409090179 C*
0093009409090179 C* ACCOUNT TOTALS
0094009409090179 C*
0095000107250160 CL1                 ADD       CLIVES        CTMBR             8 2
0096009606250160 CL1                 ADD       TBAMT         CTBAMT           10 2
0097009606250160 CL1                 ADD       TAAMT         CTAAMT           10 2
0098009606250160 CL1                 ADD       TPAMT         CTPAMT           10 2
0099009606250160 CL1                 ADD       COMEX         CCOMEX           10 2
0100009606250160 CL1                 ADD       ADMEX         CADMEX           10 2
0101009606250160 CL1                 ADD       BONDR         CBONDR           10 2
0102009606250160 CL1   COMEX         ADD       ADMEX         TOTCO            10 2
0103009606250160 CL1                 ADD       BONDR         TOTCO
0104009606250160 CL1                 ADD       TOTCO         CTOTCO           10 2
010500980812     C*
010600980812     CL1                 MOVE      EFFINV        @DATIN
010700980812     CL1                 EXSR      #DATYM
010800980812     CL1                 MOVE      @DATOU        EFIMDY            8 0
0109009808120111 C*
011000010129     CL1                 MOVEL     CCMETH        WCMETH            1
011100010129     CL1                 IF        WCMETH   =    *BLANKS
011200010129     CL1                 MOVEL     '%'           WCMETH
011300010129     CL1                 END
011400020205     CL1                 MOVEL     ACNAM1        ACNAMX           23
0115009606270160 CL1                 EXCEPT    L1OUT
0116009606250156 CL1 OF              EXCEPT    HEAD
0117009409060215 C*
0118009409090179 C* CARRIER TOTALS
0119009409090179 C*
0120000107250160 CL4                 ADD       CTMBR         GTMBR             9 2
0121009606250160 CL4                 ADD       CTBAMT        GTBAMT           10 2
0122009606250160 CL4                 ADD       CTAAMT        GTAAMT           10 2
0123009606250160 CL4                 ADD       CTPAMT        GTPAMT           10 2
0124009412140160 CL4                 ADD       CCOMEX        GCOMEX           10 2
0125009412140160 CL4                 ADD       CADMEX        GADMEX           10 2
0126009412140160 CL4                 ADD       CBONDR        GBONDR           10 2
0127009412140160 CL4                 ADD       CTOTCO        GTOTCO           10 2
012800941214     CL4                 EXCEPT    L4TOT
0129009501300156 CL4 OF              EXCEPT    HEAD
0130009102150215 C*
0131009409090179 C* GROUP TOTALS
0132009409090179 C*
0133000107250160 CL5                 ADD       GTMBR         FTMBR            10 2
0134009606250160 CL5                 ADD       GTBAMT        FTBAMT           11 2
0135009606250160 CL5                 ADD       GTAAMT        FTAAMT           11 2
0136009606250160 CL5                 ADD       GTPAMT        FTPAMT           11 2
0137009412140160 CL5                 ADD       GCOMEX        FCOMEX           10 2
0138009412140160 CL5                 ADD       GADMEX        FADMEX           10 2
0139009412140160 CL5                 ADD       GBONDR        FBONDR           10 2
0140009412140160 CL5                 ADD       GTOTCO        FTOTCO           10 2
014100941214     CL5                 EXCEPT    L5TOT
014200940906     CLR                 EXCEPT    LRTOT
0143009808120107 C*
0144009808120103 C***************************************************
0145009808120104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0146009808120105 C***************************************************
0147009808120107 C*
0148009808120107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0149009808120107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0150009808120107 C*
0151009808120106 C     #DATYM        BEGSR
015200980812     C                   MOVE      @DATIN        @MD               4 0
015300980812     C                   MOVEL     @DATIN        @Y                4 0
015400980812     C                   MOVEL     @MD           @DATOU            8 0
015500980812     C                   MOVE      @Y            @DATOU
015600980812     C                   MOVE      *ZEROS        @DATIN            8 0
0157009808120120 C                   ENDSR
015800980812     C*
0159009606280237 OCR130P    E            HEAD           2  2
0160009606280239 O                                           98 '*****'
0161009606280240 O                       CONAME             139
0162009606280241 O                                          145 '*****'
0163009606280237 OCR130P    E            HEAD           1
016400960628  44 O                                          128 'SUMMARY OF CARRIER PAYME'
0165009606280245 O                                          131 'NTS'
0166009606280237 OCR130P    E            HEAD           1
016700080415 248 O                                           20 'PROGRAM NAME: CR135B'
0168009606280288 O                       PCARR               30
016900960628     O                                           32 '-'
017000960628     O                       CNAME               73
0171009606280244 O                                          120 'FOR THE PERIOD :'
0172009808120254 O                       LMDY               131 '  /  /    '
0173000102090249 O                                          224 'PAGE :'
0174000102090250 O                       PAGE          Z    234
0175009606280237 OCR130P    E            HEAD           2
0176009606280253 O                                            9 'RUN DATE:'
0177009606280254 O                       UDATE         Y     20
017800960628     O                                          111 'SORTED BY:'
017900960628     O                       LSORT              124
018000970213     O                                          134 'SELECT:'
018100071130     O                       lseq               137
0182000102090255 O                                          224 'TIME :'
0183000102090256 O                       HTIME              234 '  :  :  '
0184009606280237 OCR130P    E            HEAD           1
018500020204     O                                           63 'AGENCY'
018600020204     O                                           44 'MARKET'
0187000107250267 O                                           96 'INVOICE'
0188009606280268 O                                          111 'BILLED'
0189009606280268 O                                          128 'ADJUSTMENT'
0190009606280268 O                                          145 'PAYMENT'
0191009606280269 O                                          154 'COMM'
0192009606280269 O                                          168 'COMMISSION'
0193009606280269 O                                          179 'ADMIN FEE'
0194009606280269 O                                          193 'ADMIN FEE'
0195009606280269 O                                          202 'BONUS'
0196000102090269 O                                          217 'BONUS'
0197000102090269 O                                          234 'TOTAL'
0198009606280237 OCR130P    E            HEAD           1
019900020204     O                                           42 'SIZE'
0200009606280272 O                                            9 'ACCOUNT #'
0201000010110273 O                                           25 'ACCOUNT NAME'
0202000102020273 O                                           51 '#MBR'
0203000107250274 O                                           56 'CHG'
0204000107250274 O                                           62 'CODE'
0205000107250275 O                                           71 'GROUP #'
0206000107250275 O                                           84 'PLAN'
0207000107250267 O                                           96 'EFFDT'
0208009606280276 O                                          111 'AMOUNT'
0209009606280276 O                                          128 'AMOUNT'
0210009606280276 O                                          145 'AMOUNT'
0211000101290277 O                                          154 'BASE'
0212009606280278 O                                          168 'EXPENSE'
0213009606280278 O                                          193 'EXPENSE'
0214000102060278 O                                          202 'DRAW'
0215000102090278 O                                          217 'DRAW'
0216000102090278 O                                          234 'COMPENSATION'
0217009606280237 OCR130P    E            HEAD           2
0218009606280281 O                                           24 '------------------------'
0219009606280282 O                                           48 '------------------------'
0220009606280283 O                                           72 '------------------------'
0221009606280284 O                                           96 '------------------------'
0222009606280285 O                                          120 '------------------------'
0223009606280285 O                                          144 '------------------------'
0224009606280285 O                                          168 '------------------------'
0225009606280285 O                                          192 '------------------------'
0226009606280285 O                                          216 '------------------------'
0227009606280286 O                                          236 '--------------------'
0228009606280287 OCR130P    E            L5DET          2
0229009606280288 O                       GRPCD                2
023000960628     O                                           15 '- GROUP CODE'
0231009606280287 OCR130P    E            L4DET          2
0232009606280288 O                       PCARR                5
023300960628     O                                            7 '-'
023400960628     O                       CNAME               48
023500020205 287 OCR130P    E            L1OUT          1
0236009606280288 O                       TRUST#               3
023700960628     O                                            4 '-'
0238009606280289 O                       SUB#                 7
023900960628     O                                            8 '-'
0240009606280290 O                       ACC#                12
0241000202050292 O                       ACNAMX              36
0242000107250292 O                       CLIVES        P     53
0243000107250292 O                       CSTAT               56
0244000202040293 O                       CAGCOD              62
0245000107250293 O                       GROUP#              79
024600020204     O                       CMKSZ               43
0247000107250293 O                       PLAN                84
0248000107250293 O                       EFIMDY              96 '  /  /    '
0249009606280293 O                       TBAMT         JB   111
0250009606280293 O                       TAAMT         JB   128
0251009606280293 O                       TPAMT         JB   145
0252009606280293 O                       CCOMP         3    153
0253000101290293 O                       WCMETH             154
0254009606280293 O                       COMEX         JB   168
0255009606280293 O                       CAFP          3    178
0256009606280293 O                       ADMEX         JB   193
0257009606280293 O                       CBONP         3    201
0258000102090293 O                       BONDR         JB   217
0259000102090293 O                       TOTCO         JB   234
026000960628 296 OCR130P    E            L4TOT          1
0261009606280285 O                                           96 '-----------'
0262009606280285 O                                          120 '------------------------'
0263009606280285 O                                          144 '------------------------'
0264009606280285 O                                          168 '------------------------'
0265009606280285 O                                          192 '------------------------'
0266009606280286 O                                          216 '------------------------'
026700960628D286 O                                          228 '------------'
0268009606280286 O                                          236 '--------------------'
026900010725     O                                           56 '--------------------------'
027000010725     O                                           82 '--------------------------'
027100010725     O                                           85 '---'
027200960628 296 OCR130P    E            L4TOT          1
027300010725     O                                           36 'CARRIER TOTALS :'
027400010822     O                       CTMBR         NB    53
0275009606280293 O                       CTBAMT        JB   111
0276009606280293 O                       CTAAMT        JB   128
0277009606280293 O                       CTPAMT        JB   145
0278009606280293 O                       CCOMEX        JB   168
0279009606280293 O                       CADMEX        JB   193
0280000102090293 O                       CBONDR        JB   217
0281000102090293 O                       CTOTCO        JB   234
028200010725 296 OCR130P    E            L5TOT          1
028301150813     O                                           24 'GROUP CODE'
028302150813     O                       grpcd               27
028303150813     O                                           36 'TOTALS :'
028400010822     O                       GTMBR         NB    53
0285009606280293 O                       GTBAMT        JB   111
0286009606280293 O                       GTAAMT        JB   128
0287009606280293 O                       GTPAMT        JB   145
0288009606280293 O                       GCOMEX        JB   168
0289009606280293 O                       GADMEX        JB   193
0290000102090293 O                       GBONDR        JB   217
0291000102090293 O                       GTOTCO        JB   234
029200010725 296 OCR130P    E            LRTOT          1
029300010725     O                                           36 'FINAL TOTALS :'
029400010822     O                       FTMBR         NB    53
0295009606280293 O                       FTBAMT        JB   111
0296009606280293 O                       FTAAMT        JB   128
0297009606280293 O                       FTPAMT        JB   145
0298009606280293 O                       FCOMEX        JB   168
0299009606280293 O                       FADMEX        JB   193
0300000102090293 O                       FBONDR        JB   217
0301000102090293 O                       FTOTCO        JB   234
