0001009809280009  *  FL010 - THE TRUST MASTER FILE LISTING
0002009809280009  *       THE TRUST MASTER FILE CONTAINS NAME, DESCRIPTION, RATES
0003009809280010  *       AND OTHER DATA FOR EACH TRUST. TRUST IS THE HIGHEST LEVEL
0004009904130011  *       OF THE HEIRARCHY
0005009809280015  ****************************************************************
0006009904130016 FTRSMST    IP   F  264     3AIDISK    KEYLOC(1)
0007009904130018 FREPORT    O    F  198        PRINTER OFLIND(*INOF)
0008009102150048 D                UDS
0009009102150049 D  CONAME               201    240
0010009102150050 D  TIME                 242    247  0
0011009102150032 ITRSMST    NS  01
0012009102150034 I                                  1    3 0TRUST#
0013009102150035 I                                  4   23  TNAME
0014009102150036 I                                 24   73  TDESCR
0015009102150037 I                                 98  127  PTADL1
0016009102150038 I                                128  157  PTADL2
0017009102150039 I                                158  187  PTADL3
0018009102150040 I                                188  217  PTADL4
0019009102150041 I                             P  218  221 0STLOSS
0020009102150044 I                                255  255  TSCODE
0021009102150045 I                                256  256  DLTCD
002200980928y2k  I                                257  264 0CONTDT
0023009102150051 C/EJECT
0024009809280052  *
0025009809280053  *  FIRST CYCLE ONLY
0026009809280054  *
0027009102150055 C     FIRST         IFNE      'Y'
0028009102150056 C                   Z-ADD     0             CNT               4 0
0029009102150057 C                   MOVE      'Y'           FIRST             1
0030009102150058 C                   END
0031009809280065  *  SETON DETAIL PRINT INDICATOR FOR PAYEE ADDRESS
0032009102150066 C     PTADL1        COMP      *BLANKS                            21
0033009102150067 C     PTADL2        COMP      *BLANKS                            22
0034009102150068 C     PTADL3        COMP      *BLANKS                            23
0035009102150069 C     PTADL4        COMP      *BLANKS                            24
0036009809280070  *
0037009809280072 C                   ADD       1             CNT                            trust records counte
003800980928      *
003900980928y2k  C                   MOVE      CONTDT        CYMD#             8
004000980928     C                   EXSR      #CYMD8
004100980928y2k  C                   MOVE      MDCY#         CONTDT            8 0          contract date
004200980928      *---------------------------------------------------*
004300980928      * Rearrange date / ccyymmdd to mmddccyy
004400980928     C     #CYMD8        BEGSR
004500980928     C                   MOVE      CYMD#         MMDD#             4
004600980928     C                   MOVEL     CYMD#         CCYY#             4
004700980928     C                   MOVEL     MMDD#         MDCY#             8
004800980928     C                   MOVE      CCYY#         MDCY#
004900980928     C                   ENDSR
0050009102150074 C/EJECT
0051009809280075 OREPORT    H    1P                     1 02
0052009102150076 O         OR    OF
0053009809280089 O                                            5 'FL010'
0054009102150077 O                                          129 '**'
0055009102150078 O                       CONAME             126
0056009102150079 O                                           87 '**'
0057009809280080 O          H    1P                     1
0058009102150081 O         OR    OF
0059009809280082 O                       UDATE         Y      8
0060009809280080 O          H    1P                     2
0061009809280081 O         OR    OF
0062009809280091 O                       TIME                 8 '  :  :  '
0063009102150083 O                                          115 'TRUST MASTER FILE LISTIN'
0064009102150084 O                                          116 'G'
0065009102150085 O                                          186 'PAGE :'
0066009102150086 O                       PAGE          Z    192
0067009102150092 O          H    1P                  1
0068009102150093 O         OR    OF
0069009102150094 O                                           24 '------------------------'
0070009102150095 O                                           48 '------------------------'
0071009102150096 O                                           72 '------------------------'
0072009102150097 O                                           96 '------------------------'
0073009102150098 O                                          120 '------------------------'
0074009102150099 O                                          144 '------------------------'
007500910215     O                                          168 '------------------------'
007600910215     O                                          192 '------------------------'
007700910215     O                                          198 '------'
0078009102150100 O          H    1P                  1
0079009102150101 O         OR    OF
0080009102150102 O                                            6 'NUMBER'
0081009102150103 O                                           15 'NAME'
0082009102150104 O                                           50 'DESCRIPTION'
0083009102150105 O                                           88 'PAYEE'
0084009102150106 O                                          118 'TRUST'
0085009102150107 O                                          137 'STOP LOSS'
0086009102150108 O                                          155 'CONTRACT'
0087009609180108 O                                          198 'STATUS'
0088009102150109 O          H    1P                  1
0089009102150110 O         OR    OF
0090009102150111 O                                          121 'CATAGORY'
0091009102150112 O                                          136 'AMOUNT'
0092009102150113 O                                          153 'DATE'
0093009102150114 O          H    1P                  1  1
0094009102150115 O         OR    OF
0095009102150116 O                                           24 '------------------------'
0096009102150117 O                                           48 '------------------------'
0097009102150118 O                                           72 '------------------------'
0098009102150119 O                                           96 '------------------------'
0099009102150120 O                                          120 '------------------------'
0100009102150120 O                                          144 '------------------------'
0101009102150120 O                                          168 '------------------------'
0102009102150120 O                                          192 '------------------------'
0103009102150121 O                                          198 '------'
0104009102150122 O          D    01                  1  1
0105009102150123 O                       TRUST#               4
0106009102150124 O                       TNAME               27
0107009102150125 O                       TDESCR              80
0108009102150126 O                  21   PTADL1             113
0109009102150127 O                       TSCODE             118
0110009102150128 O                       STLOSS        Z    137
011100980928Y2K  O                       CONTDT             155 '  /  /    '
0112009609180130 O                       DLTCD              196
0113009102150132 O          D    01 22                  1
0114009102150133 O                       PTADL2             113
0115009102150134 O          D    01 23                  1
0116009102150135 O                       PTADL3             113
0117009102150136 O          D    01 24                  1
0118009102150137 O                       PTADL4             113
0119009102150138 O          T    LR                  3
0120009102150139 O                                           50 '*** TOTAL TRUSTS *** :'
0121009102150140 O                       CNT           Z     56
