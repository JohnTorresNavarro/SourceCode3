000100920630     H DFTNAME(DB180)
0002009206250002  ******************************************************************  UTL001
0003000004140003  * DB180      GROUP BENEFIT SERVICES SOFTWARE           1992      *  UTL001
0004009206250004  *                                                                *  UTL001
0005009206250005  *            WRITTEN BY - DEBORAH R. BEYER                       *  UTL001
0006009206250006  *            DATE - 06/25/92                                     *  UTL001
0007009206250008  *                                                                *
0008009206250013  *  DESCRIPTION - THIS PROGRAM WILL PRINT GRATE RECORDS           *  UTL001
0009009206250014  *            WITH PLANS ABOUT TO EXPIRE (IN 45 DAYS OR SOONER)   *  UTL001
0010009206250015  *                                                                *  UTL001
0011009808250014 F*                                                                *
0012009808250010 F*  Y2K CONVERT - 1998                                            *
0013009808250015 F*                                                                *
0014009206250016  ******************************************************************  UTL001
001500010222     F* MODIFICATIONS HISTORY
001600010222     F* 08.25.1998 ??? Y2K CONVERSION
001700010222     F* 02.22.2001 SSK RPGIV CONVERSION
001800010222     F*
001900010222     F*
002000010222     F*
002100010222     F******************************************************************
0022009206250017  *                                                                   UTL001
0023000102210019 FGRATE     IP   F   80        DISK
0024000102220021 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
0025009206260145 D                 DS
0026009808250146 D  DAYJUL                 1      8  0
002700980825     D  DAYY                   1      4  0
002800980825     D  DAMM                   5      6  0
002900980825     D  DADD                   7      8  0
0030009206260054 D* LDA                                                               DB020
0031009206260055 D                UDS
003200920626     D  NUMDAY                 1      3  0
003300920626     D  EXPDAY                 4      6  0
0034009206260056 D  CONAME               201    240
0035009206260057 D  STIME                242    253  0
0036009206260058 D  HMS                  242    247  0
003700980825Y2K  D  UD8YMD               248    255  0
0038009102150043 IGRATE     NS
0039009206290044 I                                  1    3 0TRUST#        L2
0040009206250044 I                                  1    3 0TRUST#        L1
0041009206250044 I                                  4    6 0SUB#          L1
0042009808250044 I                                  7   10  PLAN#         L1
0043009808250045 I                                 65   72 0FRCYMD
0044009808250046 I                                 73   80 0TOCYMD
004500920625     C     FLAG          IFNE      'Y'
004600980825     C                   MOVE      UD8YMD        DAYJUL
004700920626     C                   EXSR      JULIAN
004800980825     C                   Z-ADD     DAJD          JULYMD            7 0
004900920625     C                   MOVE      'Y'           FLAG              1
005000910710     C                   END
005100920629      *
005200920629     C   L2              MOVE      *BLANKS       PRTFLG            1
005300920629     C   L2              SETOFF                                       33
005400920629      *
005500920630     CL1                 SETOFF                                       7576
005600920626     CL1                 Z-ADD     TOCYMD        DAYJUL
005700920626     CL1                 EXSR      JULIAN
005800980826     CL1   DAJD          SUB       JULYMD        COMDAY            7 0
005900980826     CL1   EXPDAY        MULT      -1            NEGDAY            7 0
006000920626     CL1   COMDAY        IFLE      NUMDAY
006100920626     CL1   COMDAY        IFGE      NEGDAY
006200920629     CL1   PRTFLG        IFEQ      *BLANKS
006300920629     CL1                 EXCEPT    HEAD
006400920629     CL1                 Z-ADD     1             CNT               4 0
006500920629     CL1                 SETON                                        33
006600920629     CL1                 MOVE      'Y'           PRTFLG
006700920629     CL1                 END
006800920626     CL1                 ADD       1             CNT
006900920626     CL1   COMDAY        IFLT      0
007000920626     CL1                 SETON                                        75
007100920626     CL1                 END
007200920630     CL1   COMDAY        IFEQ      0
007300920630     CL1                 SETON                                        76
007400920630     CL1                 END
007500980826     C*
007600980826     CL1                 MOVE      FRCYMD        @DATIN
007700980826     CL1                 EXSR      #DATYM
007800980826     CL1                 MOVE      @DATOU        FRMDY             8 0
007900980826     C*
008000980826     CL1                 MOVE      TOCYMD        @DATIN
008100980826     CL1                 EXSR      #DATYM
008200980826     CL1                 MOVE      @DATOU        TOMDY             8 0
0083009808260111 C*
008400920626     CL1                 EXCEPT    PRTEXP
008500920626     CL1 OF              EXCEPT    HEAD
008600920626     CL1                 END
008700920626     CL1                 END
008800920625      *
008900920630     CL2 33              EXCEPT    TOTAL
009000920630      *
009100920625      *--------------------------------------------------------------*
009200920625      * THIS SUBROUTINE CONVERTS GREGIORAIN DATE (MMDDYYYY) TO JULIAN*
009300980826      * (YYYYDD)                                                     *
009400920625      *--------------------------------------------------------------*
0095009206250001 C     JULIAN        BEGSR
0096009206250002 C                   Z-ADD     0             DAJD
0097009206250003 C     DAMM          SUB       3             DAMMWK            2 0
0098009206250004 C                   Z-ADD     DAMMWK        DAWKSV            2 0
0099009206260005 C     DAMMWK        IFLT      0
0100009206250006 C                   ADD       12            DAMMWK
0101009206260007 C                   END
0102009206260008 C     DAWKSV        IFNE      0
0103009206260009 C     DAMMWK        MULT(H)   30.6          DAJD
0104009206260010 C                   END
0105009808260011 C                   ADD       DADD          DAJD              7 0
0106009808250012 C                   Z-ADD     DAYY          DAYYWK            4 0
0107009206260013 C     DAYYWK        IFNE      0
0108009206260014 C     DAWKSV        IFLT      0
0109009206260015 C                   SUB       1             DAYYWK
0110009206260016 C                   END
0111009206260017 C                   END
0112009206260018 C     DAYYWK        MULT      365.25        DAJYD             7 0
0113009206250019 C                   ADD       DAJYD         DAJD
0114009206250022 C                   ENDSR
0115009808260107 C*
0116009808260103 C***************************************************
0117009808260104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0118009808260105 C***************************************************
0119009808260107 C*
0120009808260107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0121009808260107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0122009808260107 C*
0123009808260106 C     #DATYM        BEGSR
012400980826     C                   MOVE      @DATIN        @MD               4 0
012500980826     C                   MOVEL     @DATIN        @Y                4 0
012600980826     C                   MOVEL     @MD           @DATOU            8 0
012700980826     C                   MOVE      @Y            @DATOU
012800980826     C                   MOVE      *ZEROS        @DATIN            8 0
0129009808260120 C                   ENDSR
013000980826     C*
013100920625      **************************************************************
0132009102150104 O******************************************************              DB020
0133009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0134009102150106 O******************************************************              DB020
0135009102150107 O*                                                                   DB020
0136009102150108 OREPORT    E            HEAD           2  3
0137009102150110 O                       CONAME              87
0138009102150108 OREPORT    E            HEAD           1
0139009102150113 O                       UDATE         Y     14
0140009808250114 O                                           76 'RATE EXPIRATION REPORT'
0141009102150115 O                                          120 'PAGE :'
0142009102150116 O                       PAGE          Z    126
0143009102150108 OREPORT    E            HEAD           1
0144009206300119 O                                           17 'PROG: DB180'
0145009102150120 O                                          120 'TIME :'
0146009102150121 O                       HMS                130 '  :  :  '
0147009102150108 OREPORT    E            HEAD           1
014800920629     O                       NUMDAY        Z     15
014900920629     O                                           37 'DAYS OR LESS TILL THE'
015000920629     O                                           50 'PLAN EXPIRES'
015100920629     O                                           63 'OR'
015200920629     O                       EXPDAY        Z     75
015300920629     O                                           98 'DAYS OR LESS THAT THE '
015400920629     O                                          122 'PLAN HAS ALREADY EXPIRED'
0155009102150108 OREPORT    E            HEAD           1
0156009102150124 O                                           24 '------------------------'
0157009102150125 O                                           48 '------------------------'
0158009102150126 O                                           72 '------------------------'
0159009102150127 O                                           96 '------------------------'
0160009102150128 O                                          120 '------------------------'
0161009102150129 O                                          132 '------------'
0162009102150108 OREPORT    E            HEAD           1
016300010222     O                                           60 'RATE EFFECTIVE DATE'
016400010222     O                                           66 'RANGE'
0165000102220137 O                                           87 '# OF DAYS'
0166009102150108 OREPORT    E            HEAD           1
0167009206260132 O                                            5 'TRUST'
0168009206260133 O                                           18 'SUB#'
0169009206260134 O                                           32 'PLAN#'
0170009206260135 O                                           50 'FROM DATE'
0171009808250136 O                                           68 'TO DATE'
017200920626     O                                           90 'TILL EXPIRATION'
0173009102150108 OREPORT    E            HEAD           1
0174009102150141 O                                           24 '------------------------'
0175009102150142 O                                           48 '------------------------'
0176009102150143 O                                           72 '------------------------'
0177009102150144 O                                           96 '------------------------'
0178009102150145 O                                          120 '------------------------'
0179009102150146 O                                          132 '------------'
0180000102220147 OREPORT    E            PRTEXP         0
0181009206260149 O                       TRUST#               4
0182009206260150 O                       SUB#                17
0183009206260151 O                       PLAN#               31
0184009808260152 O                       FRMDY               50 '  /  /    '
0185009808260153 O                       TOMDY               68 '  /  /    '
0186000102220154 O              N75      COMDAY        ZB    86
018700920626     O               75                          89 'EXPIRED'
018800920630     O               76                          95 'EXPIRES TODAY'
0189009206300147 OREPORT    E            PRTEXP         0
019000920630     O               76                          95 'EXPIRES TODAY'
0191009206300147 OREPORT    E            PRTEXP         1
019200920630     O               76                          95 'EXPIRES TODAY'
0193009206260156 OREPORT    E            TOTAL       3
0194009206260157 O                                           29 ' TOTAL PLANS TO EXPIRE: '
0195009102150158 O                       CNT           ZB    38
