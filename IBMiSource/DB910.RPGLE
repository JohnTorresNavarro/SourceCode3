0002009102150003 F*****************************************************************
0003009102150004 F*                                                               *
0004009102150005 F*  BATCH UPDATE OF ACTIVE MEMBER FIELD.                         *
0005009102150006 F*                                      BY D.GOBEL 5/89          *
0006009808280014 F*                                                                *
0007009808280010 F*  Y2K CONVERT - 1998                                            *
0008009808280015 F*                                                                *
0008011104180015 F* 04/18/11 dlk - add exclusion of members never effective.       *
0008021304240015 F* 04/24/13 dlk - change to unique printer file name for email use*
0009009102150007 F*****************************************************************
0010000102220008 FMEMBER    IP   F  648        DISK
0011000102220010 FACCMST    UF   F  560    10AIDISK    KEYLOC(1)
0012001304240011 Fdb910p    O    F  132        PRINTER OFLIND(*INOF)
0014009102150024 D* LDA
0015009102150025 D                UDS
0016009102150026 D  CONAME               201    240                                              Y
0017009102150027 D  STIME                242    253  0                                           Y
0018009102150028 D  HMS                  242    247  0                                           Y
001900980828Y2K  D  UD8YMD               248    255  0                                      COMPNY
0021009102150013 IMEMBER    NS  01
0023009102150015 I                                136  145 0ACCKEY        L1
002400110418     I                                561  568 0mbenrl
002401110418     I                                577  584 0MEMTRM
0025009102150016 I                                511  512  STATUS
0026009102150017 I                                512  512  STAT1
0027009102150018 IACCMST    NS
0029009102150020 I                             P  210  213 0NOEMPL
0030009808280021 I                                537  544 0TERMDT
0031009102150022 I                                512  512  DLTCD
0039009102150034 C   L1              MOVE      *ZEROS        CNT               7 0
004000930120     C   L1              SETOFF                                       17
004100930120A046 C   L1ACCKEY        CHAIN     ACCMST                             07
004200930120      *
004300930120      *  IF ACCOUNT IS CANCELLED DON'T COUNT MEMBERS BECAUSE NOEMPL
004400930120      *  WILL BE EQUAL TO MEMBER COUNT BEFORE IT WAS CANCELLED
004500930120      *
004600930120     C     TERMDT        IFNE      *ZEROS
004700980828     C     TERMDT        IFLE      UD8YMD
004800930120     C                   SETON                                        17
004900930120     C                   GOTO      #END
005000930120     C                   END
005100980828     C                   END
005200930120      *
005201110418      * skip members never effective
005202110418     c                   if        mbenrl = memtrm
005203110418     C                   GOTO      #END
005204110418     C                   END
005205110418
005300921210     C     MEMTRM        IFEQ      *ZEROS
0054009102150036 C                   ADD       1             CNT
0055009102150037 C                   END
005600921210     C     MEMTRM        IFNE      *ZEROS
005700980828     C     MEMTRM        IFGT      UD8YMD
0058009212100036 C                   ADD       1             CNT
0059009212100037 C                   END
0060009212100037 C                   END
006100930120     C     #END          TAG
0062009102150041 C/SPACE
0063009102150042 C*  TOTAL TIME - CHAIN TO ACCMST FOR UPDATE OF ACTIVE MEMBERS - CNT
0064009808280043 CL1                 SETOFF                                       0203
0065009102150044 CL1                 SETOFF                                       050611
0066009102150045 CL1                 SETOFF                                       12
0067009102150047 C*
0068009301200048 CL1N17NOEMPL        IFNE      CNT
006900980828     CL1N17              ADD       1             TCNT              7 0
0070009301200049 CL1N17              SETON                                        021112
0071009808280050 CL1                 END
0072009102150051 C*
0073009102150052 CL1   CNT           IFEQ      0
0074009102150053 CL1   TERMDT        IFEQ      0
007500930119     CL1                 ADD       1             TCNT
0076009301180054 CL1                 SETON                                        0311
0077009102150055 CL1                 END
0078009212100056 CL1   DLTCD         IFEQ      'A'
0079009301180057 CL1                 SETON                                        0611
0080009212100058 CL1                 END
0081009102150059 CL1                 END
0082009102150060 C*
0083009301200061 CL1N07CNT           IFNE      0
0084009301200062 CL1   TERMDT        IFNE      0
008500980828     CL1   TERMDT        IFLE      UD8YMD
008600930120     CL1                 ADD       1             TCNT
0087009301200063 CL1                 SETON                                        0511
0088009301200065 CL1   DLTCD         IFNE      'A'
0089009301200066 CL1                 SETON                                        0611
0090009301200067 CL1                 END
0091009301200064 CL1                 END
0092009301200064 CL1                 END
0093009301200068 CL1                 END
009400980828     C*
009500980828     CL1                 MOVE      TERMDT        @DATIN
009600980828     CL1                 EXSR      #DATYM
009700980828     CL1                 MOVE      @DATOU        TERMDY            8 0
009800980828     C*
0099009102150071 C/SPACE
0100009808280107 C*
0101009808280103 C***************************************************
0102009808280104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0103009808280105 C***************************************************
0104009808280107 C*
0105009808280107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0106009808280107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0107009808280107 C*
0108009808280106 C     #DATYM        BEGSR
010900980828     C                   MOVE      @DATIN        @MD               4 0
011000980828     C                   MOVEL     @DATIN        @Y                4 0
011100980828     C                   MOVEL     @MD           @DATOU            8 0
011200980828     C                   MOVE      @Y            @DATOU
011300980828     C                   MOVE      *ZEROS        @DATIN            8 0
0114009808280120 C                   ENDSR
011500980828     C*
0116001304240072 Odb910p    H    1P                     2  3
011700910215     O         OR    OF
0118009102150074 O                       CONAME              87
0119001304240072 O          H    1P                     1
012000910215     O         OR    OF
0121009102150077 O                       UDATE         Y     14
0122009102150078 O                                           76 'ACCOUNT UPDATE LIST'
0123009102150079 O                                          120 'PAGE :'
0124001304240080 O                       PAGE          Z    126
0125001304240072 O          H    1P                     1
012600910215     O         OR    OF
0127009102150083 O                                           17 'PROG: DB910'
0128009102150084 O                                          120 'TIME :'
0129009102150085 O                       HMS                130 '  :  :  '
0130001304240072 O          H    1P                     1
013100910215     O         OR    OF
0132009102150088 O                                           24 '------------------------'
0133009102150089 O                                           48 '------------------------'
0134009102150090 O                                           72 '------------------------'
0135009102150091 O                                           96 '------------------------'
0136009102150092 O                                          120 '------------------------'
0137009102150093 O                                          132 '------------'
0138001304240072 O          H    1P                     1
013900910215     O         OR    OF
0140009102150096 O                                           35 '************** NEW '
0141009102150097 O                                           50 '***************'
0142009102150098 O                                           75 '************** OLD '
0143009102150099 O                                           90 '***************'
0144001304240072 O          H    1P                     1
014500910215     O         OR    OF
0146009102150102 O                                            4 'ACC#'
0147009102150103 O                                           25 'EMPLOYEES'
0148009102150104 O                                           40 'CANCEL DATE'
0149009102150105 O                                           50 'DLTCD'
0150009102150106 O                                           65 'EMPLOYEES'
0151009102150107 O                                           80 'CANCEL DATE'
0152009102150108 O                                           90 'DLTCD'
0153001304240072 O          H    1P                     1
015400910215     O         OR    OF
0155009102150111 O                                           24 '------------------------'
0156009102150112 O                                           48 '------------------------'
0157009102150113 O                                           72 '------------------------'
0158009102150114 O                                           96 '------------------------'
0159009102150115 O                                          120 '------------------------'
0160009102150116 O                                          132 '------------'
0161001304240117 O          T    L1 11                  1
0162000102260118 O                       ACCKEY              12 '   -   -    '
0163000102260119 O                       CNT           1     25
0164000102260121 O                       TERMDY              40 '  /  /    '
0165009808280123 O                       DLTCD               48
0166000102260124 O                       NOEMPL        1     65
0167000102260125 O                       TERMDY              80 '  /  /    '
0168009102150126 O                       DLTCD               88
0169009301180127 O               03                         112 '-ZERO MEM FOR ACT ACC#'
0170009301180127 O               05                         110 '-INVALID TERM DATE-'
0171000102260129 O               07                         132 '--NO ACCOUNT RECORD  --'
0172000102260128 O               06                         132 '-INVALID DELETE CODE-'
0173001304240130 O          T    LR                  3
0174009102150131 O                                           29 '*** TOTAL ERRORS:'
0175009102150132 O                       TCNT          ZB    38
0176009205140133 OACCMST    T    L1 12N07
0177009102150134 O               02      CNT            B   213P
