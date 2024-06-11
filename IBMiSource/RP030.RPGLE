000100000000      ******************************************************************
000200000000      *                                                                *
000300000414      *  RP030     GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400000000      *                                                                *
000500000000      *            WRITTEN  BY - DAVID V. GOBEL                        *
000600000000      *            DATE - 03/89                                        *
000700000000      *                                                                *
000800000000      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A  MEMBERSHIP LISTING *
000900000000      *                BY ACCOUNT# & NAME.                             *
001000000000      *                                                                *
001401050926      * 09/26/05 DLK - convert to rpgle                                *
001402121204      * 12/04/12 DLK - add dependents per request from Margie for      *
001500121204      *                phase one consulting.                           *
001501121204      *                                                                *
001600000000      ******************************************************************
001700000000     F***                                                              *
001800050926JGE01FMEMBER    IP   F  648        DISK
001900050926JGE01FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
002000050926JGE01FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
002001121204JGE01Fdepend    IF   e           k DISK
002100050926     FREPORT    O    F  132        PRINTER OFLIND(*INOF)
002200000000     F                                     FORMLEN(88)
002300000000     F                                     FORMOFL(78)
002500000000     D TAB1            S              2  0 DIM(12) CTDATA PERRCD(1)             MONTH NAME TABLE
002600000000     D TAB2            S             10    DIM(12) ALT(TAB1)
002900000000     D                UDS
003000121204     D  ldep                  12     12                                         COMPNY
003001121204     D  TIME                 242    247  0                                      COMPNY
003100000000     D  CONAME               201    240
003200000000JGE01D  LD8YMD               248    255  0
003300000000JGE01D  LD8YY                248    251  0
003400000000     IMEMBER    NS  01
003600000000     I                                  1    9 0SSNO
003700000000     I                                 10   27  LNAME
003800000000     I                                 28   39  FNAME
003900000000     I                                 40   40  MI
004000000000     I                                101  115  CITY
004100000000     I                                116  117  STATE
004200000000     I                             P  118  122 0ZIP
004300000000     I                                129  129  SEX
004400000000     I                                136  145 0ACKEY
004500000000     I                                136  138 0TRUST         L1
004600000000     I                                139  141 0SUBNO
004700000000     I                                142  145 0ACCNO
004800000000JGE01I                                513  520 0BIRTH
004900000000JGE01I                                517  518 0BMO
005000000000JGE01I                                513  516 0BYR
005200000000     IACCMST    NS
005500000000     I                                 11   30  ACNAME
005700000000     ITRSMST    NS
005800000000     I*  TRUST MASTER FILE
005900000000     I                                  4   23  TNAME
005901050926
007800050926      * FORCE HEADINGS AND GET TRUST NAME ON NEW TRUST
007901050926     c                   if        *inl1
008300050926     C     TRUST         CHAIN     TRSMST                             H1
008301050926     c                   except    head
008302050926     c                   end
008303050926
008500000000     C*  COUNT MEMBERS
008700000000     C                   ADD       1             COUNT
008701050926
008900000000     C*  CREATE BIRTH DATE  TO PRINT
009101050926JGE01C                   Z-ADD     BIRTH         @DATIN            8 0
009102050926JGE01C                   EXSR      #DATYM
009103050926JGE01C                   Z-ADD     @DATOU        PBIRTH            8 0
009104050926
009300000000     C*  CHAIN TO ACCOUNT MASTER FILE FOR ANAME
009500000000     C     ACKEY         CHAIN     ACCMST                             H2
009501050926
009700000000     C*  CREATE NAME FIELD TO PRINT
009900000000     C                   EXSR      #NAME
009901050926
010000000000     C                   MOVEL     ZIP           ZIP5              5 0
010100000000     C                   MOVE      ZIP           ZIP4              4 0
010200000000     C     ZIP4          IFNE      0
010300000000     C                   SETON                                        40
010400000000     C                   ELSE
010500000000     C                   SETOFF                                       40
010600000000     C                   END
010601050926
010602050926     c   of              except    head
010603050926     c                   except    prt
010604121204
010605121204      * include dependents if selected on prompt screen
010606121204     c                   if        ldep = 'Y'
010607121204     c                   exsr      #getdep
010608121204     c                   end
010609050926
011500000000     C*******************************************************
011600000000     C*   FIELD= LAST, FIRST MI.
011700000000     C*--------------- COMPRESS NAME FIELDS ----------------*
011800050926
011900000000     C     #NAME         BEGSR
012000050926
012001050926     C                   clear                   N                34
012002050926     C                   MOVEL     lname         N
012003050926     C                   CAT       ',':0         N
012004050926     C                   CAT       fname:1       N
014200050926     C                   if        mi <> ' '
014201050926     C                   CAT       mi:1          N
014202050926     C                   CAT       '.':0         N
014900000000     C                   END
014901050926
016300000000     C                   ENDSR
016301121204
016302121204      *****************************************************
016303121204      * get active dependents                             *
016304121204      *                                                   *
016305121204      *****************************************************
016306121204     c     #getdep       begsr
016307121204
016308121204     c     ssno          setll     depend
016309121204     c                   dou       %eof(depend)
016310121204     c     ssno          reade     depend
016311121204     c                   if        not %eof(depend) and dpdltd = 'A'
016312121204     c                   clear                   depname          34
016313121204     C                   movel     dlname        depname
016314121204     C                   CAT       ',':0         depname
016315121204     C                   CAT       dfname:1      depname
016316121204     c                   if        dmi <> *blank
016317121204     C                   CAT       dmi:1         depname
016318121204     C                   CAT       '.':0         depname
016319121204     c                   end
016320121204
016321121204     C*  CREATE BIRTH DATE  TO PRINT
016322121204JGE01C                   Z-ADD     dbirth        @DATIN            8 0
016323121204JGE01C                   EXSR      #DATYM
016324121204JGE01C                   Z-ADD     @DATOU        depbdymd          8 0
016325121204      * count depentents
016326121204     C                   ADD       1             depcnt            7 0
016327121204      * print dependent line
016328121204     c   of              except    head
016329121204     c                   except    prtdep
016330121204     c                   end
016331121204
016332121204     c                   enddo
016333121204
016334121204     c                   endsr
016335121204
017500000000JGE01C***
017600000000JGE01C*****************************************************
017700000000JGE01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
017800000000JGE01C*****************************************************
017900000000JGE01C***
018000000000JGE01C* DATE IN  = @DATIN (8.0) YYYYMMDD
018100000000JGE01C* DATE OUT = @DATOU (8.0) MMDDYYYY
018200000000JGE01C***
018300000000JGE01C     #DATYM        BEGSR
018400000000JGE01C                   MOVE      @DATIN        @MD               4 0
018500000000JGE01C                   MOVEL     @DATIN        @Y                4 0
018600000000JGE01C                   MOVEL     @MD           @DATOU            8 0
018700000000JGE01C                   MOVE      @Y            @DATOU
018800000000JGE01C                   MOVE      *ZEROS        @DATIN            8 0
018900000000JGE01C                   ENDSR
019000000000     C***
019002050926JGE01C     *inzsr        BEGSR
019003050926     C     UMONTH        LOOKUP    TAB1          TAB2                     10
019005050926     C                   Z-ADD     0             COUNT             7 0
019006121204     c                   if        ldep = 'Y'
019007121204     c                   eval      *in90 = *on
019008121204     c                   end
019009121204
019010050926JGE01C                   ENDSR
019100000000     O***
019200000000     O/EJECT
019300000000     O******************************************************
019400000000     O*  OUTPUT SPECIFICATIONS                             *
019500000000     O******************************************************
019600000000     O***
019700050926     OREPORT    e            head           2 03
019900000000     O                                           45 '*****'
020000000000     O                       CONAME              85
020100000000     O                                           91 '*****'
020200000000     O***
020300050926     O          e            head           1
020500000000     O                                           63 'For :'
020600000000     O                       TAB2                75
020900000000     O                       LD8YY               81
021000000000     O***
021101050926     O          e            head           1
021300000000     O                                           66 '   M E M B E R S H I P  '
021400000000     O                                           87 '  L I S T I N G      '
021500000000     O***
021501050926     O          e            head           1
021800000000     O                                           24 'PROGRAM NAME: RP030'
021801121204     o               90                          74 'INCLUDING DEPENDENTS'
021900121204     O                                          123 'PAGE:'
022000121204     O                       PAGE          Z    132
022100000000     O***
022101050926     O          e            head           1
022400000000     O                                           14 'RUN DATE:'
022500000000     O                       UDATE         Y     25
022600121204     O                                          123 'TIME:'
022700000000     O                       TIME               132 '  :  :  '
022800000000     O***
022801050926     O          e            head           1
023100000000     O                                           24 '""""""""""""""""""""""""'
023200000000     O                                           48 '""""""""""""""""""""""""'
023300000000     O                                           72 '""""""""""""""""""""""""'
023400000000     O                                           96 '""""""""""""""""""""""""'
023500000000     O                                          120 '""""""""""""""""""""""""'
023600000000     O                                          132 '""""""""""""'
023700000000     O***
023701050926     O          e            head           1
024000000000     O                                           10 'MEMBER'
024100000000     O                                           26 'MEMBER'
024200000000     O                                           57 'BIRTH'
024300000000     O***
024301050926     O          e            head           1
024600000000     O                                           12 'SOC.SEC.#'
024700000000     O                                           25 'NAME'
024800000000     O                                           56 'DATE'
024900121204     O                                           64 'SEX'
025000000000     O                                           70 'CITY'
025100000000     O                                           84 'ST'
025200000000     O                                           89 'ZIP'
025300000000     O                                          106 'ACCT #'
025400000000     O                                          121 'ACCT NAME'
025500000000     O***
025501050926     O          e            head           1
025800000000     O                                           24 '""""""""""""""""""""""""'
025900000000     O                                           48 '""""""""""""""""""""""""'
026000000000     O                                           72 '""""""""""""""""""""""""'
026100000000     O                                           96 '""""""""""""""""""""""""'
026200000000     O                                          120 '""""""""""""""""""""""""'
026300000000     O                                          132 '""""""""""""'
026400000000     O***
026401050926     O          e            head        1  2
026700000000     O                                            7 'TRUST -'
026800000000     O                       TNAME               28
026900000000     O***
027000050926     O          e            prt            1
027100121204     O                       SSNO                12 '0   -  -    '
027200000000     O                       N                   48
027400121204JGE01O                       PBIRTH              60 '0 /  /    '
027500121204JGE01O                       SEX                 63
027600000000     O                       CITY                80
027700000000     O                       STATE               84
027800000000     O                       ZIP5                91
027900000000     O               40                          92 '-'
028000000000     O               40      ZIP4                96
028100000000     O                       ACKEY              110 '   -   -    -'
028200000000     O                       ACNAME             132
028201121204     O          e            prtdep         1
028203121204     O                                           12 'Dep-'
028204121204     O                       depname             49
028205121204JGE01O                       depbdymd            60 '0 /  /    '
028300000000     O***
028400000000     O          T    L1                  2  1
028500121204     O                                           23 'TOTAL MEMBERS IN TRUST:'
028600121204     O                       COUNT         1B    +2
028601121204     O               90                          +5 'TOTAL DEPENDENTS:'
028602121204     O               90      depcnt        1B    +2
028700000000** MONTH NAME TABLE
02880000000001January
02890000000002February
02900000000003March
02910000000004April
02920000000005May
02930000000006June
02940000000007July
02950000000008August
02960000000009September
02970000000010October
02980000000011November
02990000000012December
