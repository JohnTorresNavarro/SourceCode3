0001009102150002 F******************************************************************
0002000004140003 F* RP340      GROUP BENEFIT SERVICES SOFTWARE           1990      *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009102150006 F*            DATE - 05/24/90                                     *
0006009102150007 F*                                                                *
0007009102150008 F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE A LIST OF OUT OF      *
0008009102150009 F*                STATE MEMBERS THAT ARE DUE FOR RENEWAL BASED    *
0009009102150010 F*                ON A SELECTED DATE.                             *
0014009811200011 F*                                                                *
0015009811200010 F*  Y2K CONVERT - 1998                                            *
0016000104300012 F* 04/30/01 dlk - convert to RPGLE                                *
0016010104300012 F*                                                                *
0017009102150012 F******************************************************************
0018000104300013 FMEMBER    IP   E           K DISK
0019000104300015 FACCMST    IF   E           K DISK                                         RPM022
0020000104300016 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
0023009711170037 D                 DS
0024000104300038 D  TSA                    1     10  0
0025000104300040 D  MBTRST                 1      3  0
002600010430     D  MBSUB#                 4      6  0
002700010430     D  MBACct                 7     10  0
0028000104300037 D                 DS
0029000104300038 D  ENROLL                 1      8  0
0030000104300040 D  ENRLYY                 1      4  0
003100010430     D  ENRLMM                 5      6  0
0032000104300037 D                 DS
0033000104300038 D  ANVYM                  1      6  0
0034000104300040 D  ANVYY                  1      4  0
003500010430     D  ANVMM                  5      6  0
0036009102150041 D                UDS
0037000104300042 D  TRUST                  1      3
0038009102150043 D  LMM                    4      5  0
0039009811200044 D  LYY                    6      9  0
0040009102150045 D  CONAME               201    240
0041009102150046 D  TIME                 242    247  0
0042000104300047 C     ACCKEY        CHAIN     ACCMST                             H1
0043009102150048 C*
0045009102150050 C* CALCULATE RENEWAL DATE                                           *
0047009102150052 C*
0048009102150053 C     RNEWPD        IFEQ      *ZEROS
0049009102150054 C                   EXCEPT    ERROR
0050009102150055 C                   GOTO      #END
0051009102150056 C                   END
0052009102150057 C*
0053009811200058 C                   Z-ADD     ENRLMM        ANVMM
0054009811200059 C                   Z-ADD     ENRLYY        ANVYY
005500971117     C*
0056009811200063 C     ANVYM         DOUGE     LDAYM
0057009102150064 C                   ADD       RNEWPD        ANVMM
0058009102150065 C*
0059009102150066 C     ANVMM         DOWGT     12
0060009102150067 C                   SUB       12            ANVMM
0061009811200068 C                   ADD       1             ANVYY
0062009102150069 C                   END
0063009102150070 C*
0064009102150071 C                   END
0066009102150073 C*
0067009102150074 C* CHECK RECORD FOR A MATCH TO THE SELECTED DATE
0068009102150075 C*
0069009811200076 C     ANVYM         IFEQ      LDAYM
0070009102150077 C                   EXSR      #ADDR
0071009102150078 C                   EXSR      #NAME
0072009102150079 C                   EXCEPT    DETAIL
0073009102150080 C                   ADD       1             TOTMEM            5 0
0074009102150081 C                   SETON                                        10
0075009102150082 C                   END
0076009102150083 C*
0077009102150084 C     #END          TAG
0078000104300085 C*
0079000104300086 C****************************************************************
007901010430     C*    AL = CITY, ST  ZIP+4                                *
007902010430     C*                    COMPRESS CITY/STATE/ZIP             *
007903010430     C**********************************************************
0082000104300089 C*
0083000104300090 C     #ADDR         BEGSR
0086000104300093 C*
008601010430     C                   MOVE      *BLANKS       AL               31
008602010430     C                   MOVEL     CITY          AL
008603010430     c                   cat       ',':0         al
008604010430     c                   cat       state:1       al
008605010430     c                   cat       '.':0         al
008606010430     C                   MOVEL     ZIP           ZIP5              5
008607010430     C                   MOVE      ZIP           ZIP4              4
008608010430     c                   cat       zip5:1        al
008609010430     C     ZIP4          IFNE      '0000'
008610010430     c                   cat       '-':0         al
008611010430     c                   cat       zip4:0        al
008612010430     C                   END
008613010430     C*
0092000104300128 C                   ENDSR                                                                 RPM02
0093009102150129 C*                                                                   RPM022
0094009102150130 C****************************************************************    SR#NAM
0095009102150131 C*   FIELD= LAST, FIRST MI.                                          SR#NAM
0096009102150132 C*------------------- COMPRESS NAME FIELDS ---------------------*    SR#NAM
0098009102150134 C****************************************************************    SR#NAM
0099009102150135 C     #NAME         BEGSR                                                                 SR#NA
010001010430     C*
010002010430     C                   MOVE      *BLANKS       N                35
010003010430     C                   MOVEl     mlname        N
010004010430     C                   CAT       ',':0         N
010005010430     C                   CAT       mfname:1      N
010006010430     C     mmi           IFNE      ' '
010007010430     C                   CAT       mmi:1         N
010008010430     C                   CAT       '.':0         N
010009010430     C                   END
010010010430     C*
0106009102150175 C                   ENDSR                                                                 SR#NA
0107000104300174 C*                                                                   SR#NAM
010800010430     C     *INZSR        BEGSR
0109000104300060 C                   MOVEL     LYY           LDAYM             6 0
0110000104300061 C                   MOVE      LMM           LDAYM
011100010430     C     ACCKEY        KLIST
011200010430     C                   KFLD                    MBTRST
011300010430     C                   KFLD                    MBSUB#
011400010430     C                   KFLD                    MBACCT
011500010430     C                   ENDSR
0116000104300062 C*
0117009102150176 OREPORT    H    1P                     2 03
0118009102150177 O         OR    OF
0119009102150178 O                                           45 '*****'
0120009102150179 O                       CONAME              85
0121009102150180 O                                           91 '*****'
0122009102150181 O          H    1P                     1
0123009102150182 O         OR    OF
0124009102150183 O                                           68 'OUT OF STATE MEMBERS DUE'
0125009102150184 O                                           83 'FOR RENEWAL ON'
0126009102150185 O                       LMM                 86
0127009102150186 O                                           87 '/'
0128009811200187 O                       LYY                 91
0129009102150188 O          H    1P                     1
0130009102150189 O         OR    OF
0131009102150190 O                                           69 'FOR TRUST :'
0132009102150191 O                       TRUST               73
0133009102150192 O          H    1P                     1
0134009102150193 O         OR    OF
0135009102150194 O                                           24 'PROGRAM NAME: RP340'
0136009102150195 O                                          122 'PAGE :'
0137009102150196 O                       PAGE          Z    131
0138009102150197 O          H    1P                     1
0139009102150198 O         OR    OF
0140009102150199 O                                           14 'RUN DATE:'
0141009102150200 O                       UDATE         Y     25
0142009102150201 O                                          122 'TIME :'
0143009102150202 O                       TIME               131 '  :  :  '
0144009102150203 O          H    1P                     1
0145009102150204 O         OR    OF
0146009102150205 O                                           24 '""""""""""""""""""""""""'
0147009102150206 O                                           48 '""""""""""""""""""""""""'
0148009102150207 O                                           72 '""""""""""""""""""""""""'
0149009102150208 O                                           96 '""""""""""""""""""""""""'
0150009102150209 O                                          120 '""""""""""""""""""""""""'
0151009102150210 O                                          132 '""""""""""""'
0152009102150211 O          H    1P                     1
0153009102150212 O         OR    OF
0154000104300213 O                                            8 'ACCOUNT'
0155009102150214 O                                           18 'SSN'
0156009102150215 O                                           40 'MEMBER NAME'
0157009102150216 O                                           92 '------------------------'
0158009102150217 O                                          116 '---- ADDRESS -----------'
0159009102150218 O                                          132 '----------------'
0160009102150219 O          H    1P                     2
0161009102150220 O         OR    OF
0162009102150221 O                                           24 '""""""""""""""""""""""""'
0163009102150222 O                                           48 '""""""""""""""""""""""""'
0164009102150223 O                                           72 '""""""""""""""""""""""""'
0165009102150224 O                                           96 '""""""""""""""""""""""""'
0166009102150225 O                                          120 '""""""""""""""""""""""""'
0167009102150226 O                                          132 '""""""""""""'
0168009102150227 O          E            DETAIL         1
0169000104300228 O                       TSA                 13 '0   -   -    '
0170000104300229 O                       MBSSNO              26 '0   -  -    '
0171009102150230 O                       N                   64
0172009102150231 O                       ADDR1               98
0173009102150232 O                       AL                 132
0174009102150233 O          E            ERROR       1  2
0175000104300234 O                       TSA                 13 '0   -   -    '
0176009102150235 O                                           38 '<---- THIS ACCOUNT HAS A'
0177009102150236 O                                           62 'N INVALID RENEWAL PERIOD'
0178009102150237 O          T    LR 10               2
0179009102150238 O                                           24 'TOTAL OUT OF STATE MEMBE'
0180009102150239 O                                           43 'RS DUE FOR RENEWAL:'
0181009102150240 O                       TOTMEM        1     49
0182009102150241 O          T    LRN10               2
0183009102150242 O                                           24 'NO OUT OF STATE MEMBERS '
0184009102150243 O                                           39 'DUE FOR RENEWAL'
