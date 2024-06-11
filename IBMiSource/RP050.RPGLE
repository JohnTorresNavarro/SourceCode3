000100000000      ******************************************************************
000200000000      *                                                                *
000300000000      *  RP050      GROUP BENEFIT SERVICES SOFTWARE           1990     *
000400000000      *                                                                *
000500000000      *            WRITTEN BY - DEBORAH R. BEYER                       *
000600000000      *            DATE - 03/12/90                                     *
000700000000      *                                                                *
000800000000      *  DESCRIPTION - THIS PROGRAM WILL PRINT A MEMBERSHIP REPORT OF  *
000900000000      *         THE # OF MEMBERS AND ACCOUNTS IN A TRUST.              *
001000000000      *                                                                *
001100140724      * 07/24/14 dlk - change medical selection to use plan category   *
001200140723      *                type of "M" instead of just plan category "MM", *
001300140724      *                also make fields larger and fix a few things    *
001400140723      *                                                                *
001500000000      ******************************************************************
001600000000     F***
001700050926JGE01FMEMBER    IP   F  648        DISK
001800050926JGE01FDEPEND    IF   F  360     9AIDISK    KEYLOC(1)
001900050926     FSUBMST    IF   F  370     6AIDISK    KEYLOC(1)
002000050926JGE01FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
002100050926JGE01FMCOV      IF   F   88     9AIDISK    KEYLOC(1)
002200050926JGE01FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
002300140723JGE01Fcodesl1   IF   e           k DISK
002400140724     FREPORT    O    F  100        PRINTER OFLIND(*INOF)
002500000000     D***
002600000000     D                UDS
002700000000     D  CONAME               201    240
002800000000     IMEMBER    NS  01
002900000000      *  MEMBER FILE
003000000000     I                                  1    9 0MMSSNO
003100000000     I                                136  141 0KEYSUB        L2
003200000000     I                                136  138 0TRUST#        L3
003300000000     I                                139  141 0SUB#
003400000000     I                                142  145 0ACCT          L1
003500000000     I                                155  156 0NODPND
003600000000     I***
003700000000     ISUBMST    NS  01
003800000000     I*  SUBDIVISION MASTER FILE
003900000000     I                                  7   26  SUBNAM
004000000000     I***
004100000000     ITRSMST    NS  01
004200000000      *  TRUST MASTER FILE
004300000000     I                                  1    3 0TRUST#
004400000000     I                                  4   23  TNAME
004500000000     I***
004600000000     IDEPEND    NS  01
004700000000      *  DEPENDENT    FILE
004800000000     I                                  1    9 0DSSNO
004900000000     I                                320  320  DLTCD
005000000000     I***
005100000000     IMCOV      NS  01
005200990419     I                                 12   21  KEYPLN
005300000000     I                                 64   64  STATUS
005400000000     I***
005500000000     IPLNMST    NS  01
005600000000     I                                  1   10 0PLNKEY
005700140723     I                                163  165  PLNCAT
005800000000     I***
005900000000     C***
006000000000     C*  FIRST LOGIC CYCLE.......
006100000000     C***
006200000000     C     FIRSTC        IFNE      'Y'
006300000000     C                   MOVE      'Y'           FIRSTC            1
006400000000     C                   TIME                    HTIME             6 0
006500000000     C                   SETON                                        44
006600000000     C                   EXCEPT    TRSCHG
006700000000     C                   END
006800000000     C***
006900000000     C*  INCLUDE ONLY MAJOR MEDICAL COVERAGE IN COUNT OF SUBSCRIBERS
007000000000     C***
007100000000     C                   MOVE      '   '         GOTIT
007200000000     C     MMSSNO        SETLL     MCOV
007300000000     C***
007400000000     C     MLOOP1        TAG
007500000000     C     MMSSNO        READE     MCOV                                   68
007600000000     C   68              GOTO      #MM
007700000000     C     STATUS        IFNE      'A'
007800000000     C                   GOTO      MLOOP1
007900000000     C                   ELSE
008000140723     C     KEYPLN        CHAIN     PLNMST
008100140723
008200140723      * plan category type of "M" = medical
008300140723     c                   if        %found(plnmst)
008400140723     C     PLNCAT        chain     codesl1
008500140723     c                   if        %found(codesl1) and action = 'M'
008600140723     C                   ADD       1             COUNT             6 0
008700000000     C                   MOVE      'YES'         GOTIT             3
008800000000     C                   GOTO      #MM
008900000000     C                   END
009000140723     C                   END
009100140723
009200000000     C  N68              GOTO      MLOOP1
009300000000     C                   END
009400000000     C***
009500000000     C     #MM           TAG
009600000000     C     GOTIT         IFNE      'YES'
009700000000     C                   GOTO      ENDAC
009800000000     C                   END
009900000000     C***
010000000000     C     MMSSNO        SETLL     DEPEND
010100000000     C     RLOOP1        TAG
010200000000     C***
010300000000     C     MMSSNO        READE     DEPEND                                 69
010400000000     C  N69DLTCD         IFEQ      'A'
010500000000     C                   ADD       1             NO#DPN            7 0
010600000000     C                   ELSE
010700000000     C                   GOTO      RLOOP1
010800000000     C                   END
010900000000     C***
011000000000     C   69              GOTO      ENDAC
011100000000     C                   GOTO      RLOOP1
011200000000     C***
011300000000     C     ENDAC         TAG
011301140724
011400000000     C     KEYSUB        CHAIN     SUBMST                             31
011601140724     C   OF              EXCEPT    TRSCHG
011602140724     C   L2TRUST#        CHAIN     TRSMST                             61
011700000000     C***
011800140724     Cl1   COUNT         IFNE      *ZERO
011900140724     Cl1                 ADD       1             ACCTOT            6 0
012000140724     Cl1                 ADD       1             TRACCT            6 0
012100140724     Cl1                 END
012200000000     C***
012300000000     CL2 OF              EXCEPT    TRSCHG
012400140723     CL2                 ADD       COUNT         TRCNT             6 0
012500000000     CL2                 ADD       NO#DPN        TOTDPN            8 0
012600000000     CL2                 EXCEPT    SUMTOT
012700000000     CL2                 SETOFF                                       44
012800000000     C***
012900000000     CL3 OF              EXCEPT    TRSCHG
013000140723     CL3                 ADD       TRCNT         GRCNT             6 0
013100000000     CL3                 ADD       TOTDPN        GRNDPN            8 0
013200140723     CL3                 ADD       TRACCT        GRACCT            6 0
013300000000     CL3                 EXCEPT    TRSTOT
013400000000     CL3   TRUST#        CHAIN     TRSMST
013500000000     CL3                 SETON                                        44
013600000000     C***
013700000000     CLR                 ADD       TRCNT         GRCNT
013800000000     CLR                 ADD       TRACCT        GRACCT
013900000000     CLR                 EXCEPT    GRTRHD
014000000000     CLR                 EXCEPT    GRFTOT
014100000000     C***
014200000000     O***
014300000000     OREPORT    E            TRSCHG         1  3
014400000000     O                                           13 'PROGRAM NAME:'
014500140723     O                                           19 'RP050'
014600140723     O                       CONAME              74
014700140723     O                                           90 'PAGE:'
014800140723     O                       PAGE          Z     99
014900000000     OREPORT    E            TRSCHG         1
015000000000     O***
015100000000     O                                            9 'RUN DATE:'
015200000000     O                       UDATE         Y     19
015300140723     O                                           90 'RUN TIME:'
015400140723     O                       HTIME               99 '  .  .  '
015500000000     OREPORT    E            TRSCHG         2
015600000000     O***
015700140723     O                                           67 'MEMBERSHIP REPORT - MEDICA-
015800140723     O                                              L'
015900000000     OREPORT    E            TRSCHG         1
016000000000     O***
016100000000     O                                           20 '--------------------'
016200000000     O                                           40 '--------------------'
016300000000     O                                           60 '--------------------'
016400000000     O                                           80 '--------------------'
016500140723     O                                          100 '--------------------'
016600000000     OREPORT    E            TRSCHG         1
016700000000     O***
016800140724     O                                            5 'TRUST'
016900140724     O                                           39 'SUBDIVISION'
017000000000     O                                           62 'NO. OF'
017100140723     O                                           77 'NO. OF'
017200140723     O                                           90 'NO. OF'
017300000000     OREPORT    E            TRSCHG         1
017400000000     O                                           63 'SUBSCRB'
017500140723     O                                           78 'DEPENDN'
017600140723     O                                           90 'ACCNTS'
017700000000     OREPORT    E            TRSCHG         1
017800000000     O***
017900000000     O                                           20 '--------------------'
018000000000     O                                           40 '--------------------'
018100000000     O                                           60 '--------------------'
018200000000     O                                           80 '--------------------'
018300140723     O                                          100 '--------------------'
018400000000     OREPORT    E            SUMTOT         1
018500000000     O***
018600000000     O               44      TRUST#               4
018700140724     O               44      TNAME               26
018800140724     O                       SUB#                31
018900140724     O                       SUBNAM              53
019000140723     O                       COUNT          B    63 '   ,   '
019100140723     O                       NO#DPN         B    78 '  ,   ,   '
019200140723     O                       ACCTOT         B    90 '   ,   '
019300140723     OREPORT    E            TRSTOT         2
019400000000     O***
019500140723     O                       TRCNT          B    63 '   ,   '
019600140723     O                       TOTDPN         B    78 '   ,   ,   '
019700140723     O                       TRACCT         B    90 '   ,   '
019800000000     OREPORT    E            GRTRHD         1  3
019900000000     O***
020000000000     O                                           13 'PROGRAM NAME:'
020100140723     O                                           19 'RP050'
020200140723     O                       CONAME              74
020300140723     O                                           90 'PAGE:'
020400140723     O                       PAGE          Z     99
020500000000     OREPORT    E            GRTRHD         1
020600000000     O***
020700000000     O                                            9 'RUN DATE:'
020800000000     O                       UDATE         Y     19
020900140723     O                                           90 'RUN TIME:'
021000140723     O                       HTIME               99 '  .  .  '
021100000000     OREPORT    E            GRTRHD         2
021200000000     O***
021300140723     O                                           65 'MEMBERSHIP REPORT - MEDICA-
021400140723     O                                              L'
021500000000     OREPORT    E            GRTRHD         1
021600000000     O***
021700000000     O                                           20 '--------------------'
021800000000     O                                           40 '--------------------'
021900000000     O                                           60 '--------------------'
022000000000     O                                           80 '--------------------'
022100140723     O                                          100 '--------------------'
022200000000     OREPORT    E            GRTRHD         1
022300000000     O***
022400000000     O                                           62 'NO. OF'
022500140723     O                                           77 'NO. OF'
022600140723     O                                           90 'NO. OF'
022700000000     OREPORT    E            GRTRHD         1
022800000000     O***
022900000000     O                                           63 'SUBSCRB'
023000140723     O                                           78 'DEPENDN'
023100140723     O                                           90 'ACCNTS'
023200000000     OREPORT    E            GRTRHD         3
023300000000     O***
023400000000     O                                           20 '--------------------'
023500000000     O                                           40 '--------------------'
023600000000     O                                           60 '--------------------'
023700000000     O                                           80 '--------------------'
023800140723     O                                          100 '--------------------'
023900000000     OREPORT    E            GRFTOT      2
024000000000     O***
024100000000     O                                           23 'GRAND TOTAL FOR ALL '
024200000000     O                                           30 'TRUSTS:'
024300140723     O                       GRCNT          B    63 '   ,   '
024400140723     O                       GRNDPN         B    78 '   ,   ,   '
024500140723     O                       GRACCT         B    90 '   ,   '
