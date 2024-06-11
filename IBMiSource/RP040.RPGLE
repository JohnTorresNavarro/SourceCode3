000100000000      ******************************************************************
000200000000      *                                                                *
000300000000      *  RP040     GROUP BENEFIT SERVICES SOFTWARE           1990      *
000400000000      *                                                                *
000500000000      *            WRITTEN BY - DEBORAH R. BEYER                       *
000600000000      *            DATE - 03 12/90                                     *
000700000000      *                                                                *
000800000000      *  DESCRIPTION - THIS PROGRAM WILL PRINT A MEMBERSHIP REPORT OF  *
000900000000      *         THE # OF MEMBERS AND ACCOUNTS IN A TRUST.              *
001000000000      *                                                                *
001001050926      * 09/26/05 DLK - convert to rpgle                                *
001004140724      * 07/24/14 dlk - make fields larger and fix a few things         *
001100000000      *                                                                *
001200000000      ******************************************************************
001300050926JGE01FMEMBER    IP   F  648        DISK
001400050926JGE01FDEPEND    IF   F  360     9AIDISK    KEYLOC(1)
001500050926     FSUBMST    IF   F  370     6AIDISK    KEYLOC(1)
001600050926JGE01FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
001700140724     FREPORT    O    F  100        PRINTER OFLIND(*INOF)
001800000000     D***
001900000000     D                UDS
002000000000     D  CONAME               201    240
002100000000     IMEMBER    NS  01
002200000000      *  MEMBER FILE
002300000000     I                                  1    9 0MMSSNO
002400000000     I                                136  141 0KEYSUB        L2
002500000000     I                                136  138 0TRUST#        L3
002600000000     I                                139  141 0SUB#
002700000000     I                                142  145 0ACCT          L1
002800000000     I                                155  156 0NODPND
002900000000     I***
003000000000     ISUBMST    NS  01
003100000000      *  SUBDIVISION MASTER FILE
003200000000     I                                  7   26  SUBNAM
003300000000     ITRSMST    NS  02
003400000000      *  TRUST MASTER FILE
003500000000     I                                  1    3 0TRUST#
003600000000     I                                  4   23  TNAME
003700000000     I***
003800000000     IDEPEND    NS  03
003900000000      *  DEPENDENT    FILE
004000000000     I                                  1    9 0DSSNO
004100000000     I                                320  320  DLTCD
004200000000     I***
004300000000     C***
004400000000     C*  FIRST LOGIC CYCLE.......
004500000000     C***
004600000000     C     FIRSTC        IFNE      'Y'
004700000000     C                   MOVE      'Y'           FIRSTC            1
004800000000     C                   TIME                    HTIME             6 0
004900000000     C                   SETON                                        44
005000000000     C                   EXCEPT    TRSCHG
005100000000     C                   END
005200000000     C***
005300140724     C                   ADD       1             COUNT             6 0
005400000000     C     MMSSNO        SETLL     DEPEND
005500000000     C***
005600000000     C     RLOOP1        TAG
005700000000     C     MMSSNO        READE     DEPEND                                 69
005800000000     C  N69DLTCD         IFEQ      'A'
005900000000     C                   ADD       1             NO#DPN            7 0
006000000000     C                   ELSE
006100000000     C                   GOTO      RLOOP1
006200000000     C                   END
006300000000     C***
006400000000     C   69              GOTO      ENDAC
006500000000     C***
006600000000     C                   GOTO      RLOOP1
006700000000     C***
006800000000     C     ENDAC         TAG
006900000000     C     KEYSUB        CHAIN     SUBMST                             31
007000000000     C   OF              EXCEPT    TRSCHG
007100000000     C***
007200000000     C   L2TRUST#        CHAIN     TRSMST                             61
007300000000     C***
007400140724     Cl1   COUNT         IFNE      *ZERO
007500140724     Cl1                 ADD       1             ACCTOT            6 0
007600140724     Cl1                 ADD       1             TRACCT            6 0
007700140724     Cl1                 END
007800000000     C***
007900000000     CL2 OF              EXCEPT    TRSCHG
008000140724     CL2                 ADD       COUNT         TRCNT             6 0
008100000000     CL2                 ADD       NO#DPN        TOTDPN            8 0
008200000000     CL2                 EXCEPT    SUMTOT
008300000000     CL2                 SETOFF                                       44
008400000000     C***
008500000000     CL3 OF              EXCEPT    TRSCHG
008600140724     CL3                 ADD       TRCNT         GRCNT             6 0
008700000000     CL3                 ADD       TOTDPN        GRNDPN            8 0
008800140724     CL3                 ADD       TRACCT        GRACCT            6 0
008900000000     CL3                 EXCEPT    TRSTOT
009000000000     CL3   TRUST#        CHAIN     TRSMST                             61
009100000000     CL3                 SETON                                        44
009200000000     C***
009300000000     CLR                 ADD       TRCNT         GRCNT
009400000000     CLR                 ADD       TRACCT        GRACCT
009500000000     CLR                 EXCEPT    GRTRHD
009600000000     CLR                 EXCEPT    GRFTOT
009700000000     C***
009800000000     O***
009900000000     OREPORT    E            TRSCHG         1 03
010000000000     O                                           13 'PROGRAM NAME:'
010100140724     O                                           19 'RP040'
010200140724     O                       CONAME              74
010300140724     O                                           90 'PAGE:'
010400140724     O                       PAGE          Z     99
010500000000     O***
010600000000     O          E            TRSCHG         1
010700000000     O                                            9 'RUN DATE:'
010800000000     O                       UDATE         Y     19
010900140724     O                                           90 'RUN TIME:'
011000140724     O                       HTIME               99 '  .  .  '
011100000000     O***
011200000000     O          E            TRSCHG         2
011300140724     O                                           62 'MEMBERSHIP REPORT'
011400000000     O***
011500000000     O          E            TRSCHG         1
011600000000     O                                           20 '--------------------'
011700000000     O                                           40 '--------------------'
011800000000     O                                           60 '--------------------'
011900000000     O                                           80 '--------------------'
011901140724     O                                          100 '--------------------'
012000000000     O***
012100000000     O          E            TRSCHG         1
012200140724     O                                            5 'TRUST'
012400140724     O                                           39 'SUBDIVISION'
012600000000     O                                           62 'NO. OF'
012700140724     O                                           77 'NO. OF'
012800140724     O                                           90 'NO. OF'
012900000000     O***
013000000000     O          E            TRSCHG         1
013300000000     O                                           63 'SUBSCRB'
013400140724     O                                           78 'DEPENDN'
013500140724     O                                           90 'ACCNTS'
013600000000     O***
013700000000     O          E            TRSCHG         1
013800000000     O                                           20 '--------------------'
013900000000     O                                           40 '--------------------'
014000000000     O                                           60 '--------------------'
014100000000     O                                           80 '--------------------'
014101140724     O                                          100 '--------------------'
014200000000     O***
014300000000     O          E            SUMTOT         1
014400000000     O               44      TRUST#               4
014500000000     O               44      TNAME               26
014600140724     O                       SUB#                31
014700140724     O                       SUBNAM              53
015001140724     O                       COUNT          B    63 '   ,   '
015002140724     O                       NO#DPN         B    78 '  ,   ,   '
015003140724     O                       ACCTOT         B    90 '   ,   '
015100000000     O***
015200000000     O          E            TRSTOT         2
015601140724     O                       TRCNT          B    63 '   ,   '
015602140724     O                       TOTDPN         B    78 '   ,   ,   '
015603140724     O                       TRACCT         B    90 '   ,   '
015700000000     O***
015800000000     O          E            GRTRHD         1 03
015900000000     O                                           13 'PROGRAM NAME:'
016000140724     O                                           19 'RP040'
016100140724     O                       CONAME              74
016200140724     O                                           90 'PAGE:'
016300140724     O                       PAGE          Z     99
016400000000     O***
016500000000     O          E            GRTRHD         1
016600000000     O                                            9 'RUN DATE:'
016700000000     O                       UDATE         Y     19
016800140724     O                                           90 'RUN TIME:'
016900140724     O                       HTIME               99 '  .  .  '
017000000000     O***
017100000000     O          E            GRTRHD         2
017200140724     O                                           62 'MEMBERSHIP REPORT'
017300000000     O***
017400000000     O          E            GRTRHD         1
017500000000     O                                           20 '--------------------'
017600000000     O                                           40 '--------------------'
017700000000     O                                           60 '--------------------'
017800000000     O                                           80 '--------------------'
017801140724     O                                          100 '--------------------'
017900000000     O***
018000000000     O          E            GRTRHD         1
018100000000     O                                           62 'NO. OF'
018200140724     O                                           77 'NO. OF'
018300140724     O                                           90 'NO. OF'
018400000000     O***
018500000000     O          E            GRTRHD         1
018600000000     O                                           63 'SUBSCRB'
018700140724     O                                           78 'DEPENDN'
018800140724     O                                           90 'ACCNTS'
018900000000     O***
019000000000     O          E            GRTRHD         3
019100000000     O                                           20 '--------------------'
019200000000     O                                           40 '--------------------'
019300000000     O                                           60 '--------------------'
019400000000     O                                           80 '--------------------'
019401140724     O                                          100 '--------------------'
019500000000     O***
019600000000     O          E            GRFTOT      2
019700000000     O                                           23 'GRAND TOTAL FOR ALL '
019800000000     O                                           30 'TRUSTS:'
020200140724     O                       GRCNT          B    63 '   ,   '
020300140724     O                       GRNDPN         B    78 '   ,   ,   '
020400140724     O                       GRACCT         B    90 '   ,   '
