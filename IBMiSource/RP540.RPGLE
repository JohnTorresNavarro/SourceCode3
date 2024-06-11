000100000000      ******************************************************************
000200000000      *                                                                *
000300000000      *  RP540     GROUP BENEFIT SERVICES SOFTWARE                     *
000400000000      *                                                                *
000500000000      *            WRITTEN BY - DAVID KETTERMAN                        *
000600000000      *            DATE - 06/09/97                                     *
000700000000      *                                                                *
000800000000      *  DESCRIPTION - BROKER BUSINESS REPORT                          *
000900000000      *      *NOTE THIS REPORT DOES NOT JUST LOOK AT ACTIVE RECORDS    *
001000000000      *       IT LOOKS FOR ACTIVE RECORDS AS OF THE EFFDT OF THE       *
001100000000      *       REPORT, SO IT IS POSSIBLE TO RUN THIS REPORT FOR 4/97    *
001200000000      *       AND IF THE ACCT WAS CANCELLED 5/97, IT WILL STILL PRINT  *
001300000000      *                                                                *
001400000000      *    JGE  12.08.98 - Modified for Y2k date conversion            *
001500000000      *        JGE01     All dates modified to use a 4 digit year for  *
001600000000      *                  comparisons and output.  File record lengths  *
001700000000      *                  modified as needed for new date positions.    *
001800000000      *                                                                *
001900990503      *  DLK - 5/99 FIX JGE CODE                                       *
002000000000      ******************************************************************
002100000000     FACCMST    IP   E             DISK
002200000000     FSMAN      IF   E           K DISK
002300000000     FMCOV      IF   E           K DISK
002400000000     FMEMAC#    IF   E           K DISK
002500000000     FPLNMST    IF   E           K DISK
002600000000     FRP540WK   O  A E             DISK
002700000000     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
002800000000     D                 DS
002900981214JGE01D  LREYMD                 1      8  0
003000981214JGE01D  LRYY                   1      4  0
003100981214JGE01D  LRMM                   5      6  0
003200981214JGE01D  LRDD                   7      8  0
003300000000     D                 DS
003400981214JGE01D  LEFYMD                 1      8  0
003500981214JGE01D  LEYY                   1      4  0
003600990503JGE01D  LEMM                   5      6  0
003700990503JGE01D  LEDD                   7      8  0
003800000000     D                 DS
003900981214JGE01D  ANVYM                  1      6  0
004000981214JGE01D  ANVYY                  1      4  0
004100981214JGE01D  ANVMM                  5      6  0
004200000000     D                UDS
004300981214JGE01D  LBROK                  1      3
004400981214JGE01D  LTRST                  4      6
004500990503JGE01D  LREMM                  7      8
004600990503JGE01D  LREYY                  9     12
004700990503JGE01D  LEFMM                 13     14
004800990503JGE01D  LEFYY                 15     18
004900981214JGE01D  LMEM                  19     19
005000981214JGE01D  LDSB                  20     20
005100000000     D  CONAME               201    240
005200000000     D  TIME                 242    247  0
005300000000     IACCMSR
005400000000     I                                          ACTRST        L1
005500000000     I                                          SMANCD        L2
005600000000     C     *INL1         IFEQ      *ON
005700000000     C                   MOVE      'N'           L1HIT             1
005800000000     C                   END
005900000000     C     *INL2         IFEQ      *ON
006000000000     C                   MOVE      'N'           L2HIT             1
006100000000     C                   END
006200000000     C*
006300981214     C*  CHECK ACCT ERNOLL/CANCEL DATE AGAINST REPORT EFFDT
006400000000     C*
006500981214     C     LEFYMD        IFLT      ENROLL
006600000000     C                   GOTO      #END
006700000000     C                   END
006800000000     C*
006900000000     C     ATRMDT        IFNE      0
007000981214     C     LEFYMD        IFGE      ATRMDT
007100000000     C                   GOTO      #END
007200000000     C                   END
007300000000     C                   END
007400000000     C*
007500981214     C*  CHECK RENEWAL DATE FOR SELECTION
007600000000     C*
007700981214     C     LREMM         IFNE      *ZEROS
007800990503     C*
007900990503JGE01C                   MOVE      ENROLL        ANVMD             4 0
008000990503JGE01C                   MOVEL     ANVMD         ANVMM
008100981214JGE01C                   MOVEL     ENROLL        ANVYY
008200981214     C                   MOVEL     LREYY         LDAYM             6 0
008300000000     C                   MOVE      LREMM         LDAYM
008400000000     C*
008500000000     C     ANVYM         DOUGE     LDAYM
008600000000     C                   ADD       RNEWPD        ANVMM
008700000000     C     ANVMM         DOWGT     12
008800000000     C                   SUB       12            ANVMM
008900000000     C                   ADD       1             ANVYY
009000000000     C                   END
009100000000     C                   END
009200000000     C*
009300000000     C     ANVYM         IFNE      LDAYM
009400000000     C                   GOTO      #END
009500000000     C                   END
009600000000     C*
009700000000     C                   END
009800000000     C*
009900000000     C*  PROCESS THIS ACCOUNT
010000000000     C*
010100000000     C                   MOVE      'Y'           L1HIT
010200000000     C                   MOVE      'Y'           L2HIT
010300000000     C     SMANCD        CHAIN     SMAN                               61
010400000000     C                   MOVE      *BLANKS       BROKER           32
010500000000     C  N61SFNAME        CAT       SLNAME:1      BROKER
010600000000     C*
010700981214     C*  PRINT IF NOT SUMMARY ONLY
010800000000     C*
010900000000     C     LDSB          IFNE      'S'
011000000000     C     *INL2         IFEQ      *ON
011100000000     C     *INOF         OREQ      *ON
011200000000     C                   EXCEPT    HEAD
011300000000     C                   END
011400000000     C                   END
011500000000     C*
011600000000     C     ACKEY         SETLL     MEMAC#
011700000000     C     #T0010        TAG
011800000000     C     ACKEY         READE     MEMAC#                                 50
011900000000     C   50              GOTO      #PRINT
012000000000     C*
012100981214     C*  CHECK MEMBER ERNOLL/CANCEL DATE AGAINST REPORT EFFDT
012200000000     C*
012300981214JGE01C     LEFYMD        IFLT      MBENRL
012400000000     C                   GOTO      #T0010
012500000000     C                   END
012600000000     C*
012700000000     C     TERMDT        IFNE      0
012800981214JGE01C     LEFYMD        ANDGE     TERMDT
012900000000     C                   GOTO      #T0010
013000000000     C                   END
013100000000     C*
013200981214     C*  IF MEMBER COUNT BY ACTIVE SELECTED...
013300000000     C*
013400000000     C     LMEM          IFEQ      'A'
013500000000     C                   ADD       1             AEMP              5 0
013600000000     C                   END
013700000000     C*
013800000000     C     MBSSNO        SETLL     MCOV
013900000000     C     #T0020        TAG
014000000000     C     MBSSNO        READE     MCOV                                   51
014100000000     C   51              GOTO      #T0010
014200000000     C*
014300981214     C*  CHECK MCOV ERNOLL/CANCEL DATE AGAINST REPORT EFFDT
014400000000     C*
014500981214JGE01C     LEFYMD        IFLT      ENRLDT
014600000000     C                   GOTO      #T0020
014700000000     C                   END
014800000000     C*
014900000000     C     CANDT         IFNE      0
015000981214JGE01C     LEFYMD        ANDGE     CANDT
015100000000     C                   GOTO      #T0020
015200000000     C                   END
015300000000     C*
015400981214     C*  ACCUMULATE PLANS BY CATEGORY
015500000000     C*
015600000000     C     PLNKEY        CHAIN     PLNMST                             60
015700000000     C     *IN60         IFEQ      *OFF
015800000000     C                   EXSR      #PLNCT
015900000000     C     PLNTYP        IFEQ      'M'
016000000000     C                   ADD       1             AMED              5 0
016100000000     C*
016200981214     C*  IF MEMBER COUNT BY MEDICAL SELECTED...
016300000000     C*
016400000000     C     LMEM          IFEQ      'M'
016500000000     C                   ADD       1             AEMP
016600000000     C                   END
016700000000     C*
016800000000     C                   ELSE
016900000000     C     PLNTYP        IFEQ      'D'
017000000000     C                   ADD       1             ADEN              5 0
017100000000     C                   ELSE
017200000000     C     PLNTYP        IFEQ      'L'
017300000000     C                   ADD       1             ALD               5 0
017400000000     C                   END
017500000000     C                   END
017600000000     C                   END
017700000000     C                   END
017800000000     C*
017900000000     C                   GOTO      #T0020
018000000000     C*
018100000000     C     #PRINT        TAG
018200000000     C                   ADD       1             TNUM              4 0
018300000000     C                   ADD       AEMP          TEMP              6 0
018400000000     C                   ADD       APREMI        TLPREM           10 2
018500000000     C                   ADD       AMED          TMED              6 0
018600000000     C                   ADD       ADEN          TDEN              6 0
018700000000     C                   ADD       ALD           TLD               6 0
018800000000     C*
018900981214     C*  WRITE INFO TO WORK FILE FOR SUMMARY REPORT
019000981214     C*
019100000000     C     LDSB          IFNE      'D'
019200000000     C                   MOVE      SMANCD        WSMAN
019300000000     C                   MOVE      BROKER        WSNAME
019400000000     C                   MOVE      AEMP          W#EMP
019500000000     C                   MOVE      APREMI        WLPREM
019600000000     C                   WRITE     RP540R
019700000000     C                   END
019800000000     C*
019900981214     C*  PRINT IF NOT SUMMARY ONLY
020000000000     C*
020100000000     C     LDSB          IFNE      'S'
020200000000     C   OF              EXCEPT    HEAD
020300990503     C*
020400990503     C                   MOVE      ENROLL        @DATIN
020500990503     C                   EXSR      #DATYM
020600990503     C                   MOVE      @DATOU        ENRMDY            8 0
0207009905030111 C*
020800000000     C                   EXCEPT    DETACC
020900000000     C                   END
021000000000     C                   MOVE      *ZEROS        AEMP
021100000000     C*
021200000000     C     #END          TAG
021300000000     C*
021400981214     C*  TRUST BREAK
021500000000     C*
021600000000     CL1   L1HIT         IFEQ      'Y'
021700000000     CL1                 ADD       TNUM          BNUM              5 0
021800000000     CL1                 ADD       TEMP          BEMP              6 0
021900000000     CL1                 ADD       TLPREM        BLPREM           11 2
022000000000     CL1                 ADD       TMED          BMED              6 0
022100000000     CL1                 ADD       TDEN          BDEN              6 0
022200000000     CL1                 ADD       TLD           BLD               6 0
022300981214     C*
022400000000     CL1   LDSB          IFNE      'S'
022500000000     CL1 OF              EXCEPT    HEAD
022600000000     CL1                 EXCEPT    DETTRS
022700000000     CL1                 END
022800000000     CL1                 END
022900000000     C*
023000981214     C*  BROKER BREAK
023100000000     C*
023200000000     CL2   L2HIT         IFEQ      'Y'
023300000000     CL2   LDSB          IFNE      'S'
023400000000     CL2                 EXCEPT    DETBRK
023500000000     CL2                 SETON                                        OF
023600000000     CL2                 END
023700000000     CL2                 END
023800000000     C*
023900000000     C* FIRST CYCLE ROUTINE
024000000000     C*
024100000000     C     *INZSR        BEGSR
024200000000     C*
024300000000     C     ACKEY         KLIST
024400000000     C                   KFLD                    ACTRST
024500000000     C                   KFLD                    ACSUB#
024600000000     C                   KFLD                    ACACCT
024700000000     C*
024800000000     C     PLNKEY        KLIST
024900000000     C                   KFLD                    MCTRST
025000000000     C                   KFLD                    MCSUB#
025100000000     C                   KFLD                    MCPLAN
025200000000     C*
025300990503     C                   MOVE      LEFYY         LEYY
025400990503     C                   MOVE      LEFMM         LEMM
025500990503     C                   MOVE      01            LEDD
025600990503JGE01C     LREYY         IFNE      '0000'
025700990503     C                   MOVE      LREYY         LRYY
025800990503     C                   MOVE      LREMM         LRMM
025900990503     C                   MOVE      01            LRDD
026000000000     C                   ELSE
026100990503     C                   MOVE      *ZEROS        LREYMD
026200000000     C                   END
026300000000     C*
026400000000     C                   EXCEPT    SELECT
026500000000     C                   MOVE      *ON           *INOF
026600000000     C*
026700000000     C                   ENDSR
026800000000     C*
026900000000     C* DETERMINE PLAN TYPE
027000000000     C*
027100981214     C     #PLNCT        BEGSR
027200000000     C                   MOVE      ' '           PLNTYP            1
027300000000     C*
027400000000     C* MEDICAL
027500981214     C*
027600000000     C     PLNCAT        IFEQ      'PMM'
027700000000     C     PLNCAT        OREQ      'PCM'
027800000000     C     PLNCAT        OREQ      'PMS'
027900000000     C                   MOVE      'M'           PLNTYP
028000000000     C                   END
028100981214     C*
028200981214     C*  DENTAL
028300000000     C     PLNCAT        IFEQ      'PDN'
028400000000     C     PLNCAT        OREQ      'PCD'
028500000000     C                   MOVE      'D'           PLNTYP
028600000000     C                   END
028700981214     C*
028800981214     C*  LIFE/DIS
028900981214     C*
029000000000     C     PLNCAT        IFEQ      'PLF'
029100000000     C     PLNCAT        OREQ      'PDL'
029200000000     C     PLNCAT        OREQ      'PLT'
029300000000     C     PLNCAT        OREQ      'PSL'
029400000000     C     PLNCAT        OREQ      'PWD'
029500000000     C     PLNCAT        OREQ      'PWS'
029600000000     C                   MOVE      'L'           PLNTYP
029700000000     C                   END
029800000000     C                   ENDSR
029900000000     C***
0300009905030107 C*
0301009905030103 C***************************************************
0302009905030104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0303009905030105 C***************************************************
0304009905030107 C*
0305009905030107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0306009905030107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0307009905030107 C*
0308009905030106 C     #DATYM        BEGSR
030900990503     C                   MOVE      @DATIN        @MD               4 0
031000990503     C                   MOVEL     @DATIN        @Y                4 0
031100990503     C                   MOVEL     @MD           @DATOU            8 0
031200990503     C                   MOVE      @Y            @DATOU
031300990503     C                   MOVE      *ZEROS        @DATIN            8 0
0314009905030120 C                   ENDSR
031500990503     C*
031600000000     O***                                                                 DB020
031700000000     OQSYSPRT   E            SELECT         2 03                                DB020
031800000000     O                                           24 '* SELECTION FOR RP540 - '  DB020
031900000000     O                                           48 'BROKER BUSINESS REPORT *'  DB020
032000000000     O***                                                                 DB020
032100000000     O          E            SELECT         1                                   DB020
032200000000     O                                           20 'BROKER..............'      DB020
032300000000     O                       LBROK               24
032400000000     O***                                                                 DB020
032500000000     O          E            SELECT         1                                   DB020
032600000000     O                                           20 'TRUST...............'      DB020
032700000000     O                       LTRST               24
032800000000     O***                                                                 DB020
032900000000     O          E            SELECT         1                                   DB020
033000000000     O                                           20 'RENEWAL MONTH/YEAR..'      DB020
033100000000     O                       LREMM               23
033200000000     O                                           24 '/'
033300981214JGE01O                       LREYY               28
033400000000     O***                                                                 DB020
033500000000     O          E            SELECT         1                                   DB020
033600000000     O                                           20 'EFFECTIVE MONTH/YEAR'      DB020
033700000000     O                       LEFMM               23
033800000000     O                                           24 '/'
033900981214JGE01O                       LEFYY               28
034000000000     O***                                                                 DB020
034100000000     O          E            SELECT         1                                   DB020
034200000000     O                                           20 'MEMBER COUNT A OR M.'      DB020
034300000000     O                       LMEM                24
034400000000     O***                                                                 DB020
034500000000     O          E            SELECT         1                                   DB020
034600000000     O                                           20 'DETAIL SUMM OR BOTH.'      DB020
034700000000     O                       LDSB                24
034800000000     O***                                                                 DB020
034900000000     O          E            HEAD           2 03                                DB020
035000000000     O                       CONAME              83                             DB020
035100000000     O***                                                                 DB020
035200000000     O          E            HEAD           1                                   DB020
035300000000     O                       UDATE         Y      8                             DB020
035400000000     O                                           71 'BROKER BUSINESS REPORT'
035500000000     O                                           80 ' - DETAIL'
035600000000     O                                          123 'PAGE :'                    DB020
035700000000     O                       PAGE          Z    132                             DB020
035800000000     O***                                                                 DB020
035900000000     O          E            HEAD           1                                   DB020
036000000000     O                                           11 'PROG: RP540'               DB020
036100000000     O                                           66 'EFFECTIVE DATE:'
036200000000     O                       LEFMM               69
036300000000     O                                           70 '/'
036400981214JGE01O                       LEFYY               74
036500000000     O                                          123 'TIME :'                    DB020
036600000000     O                       TIME               132 '  :  :  '                  DB020
036700000000     O***                                                                 DB020
036800000000     O          E            HEAD           1                                   DB020
036900000000     O                                           52 'BROKER:'
037000000000     O                       SMANCD              56
037100000000     O              N61      BROKER              90
037200000000     O               61                          90 '***** NOT FOUND *****'
037300000000     O***                                                                 DB020
037400000000     O          E            HEAD           2                                   DB020
037500000000     O                                           24 '------------------------'  DB020
037600000000     O                                           48 '------------------------'  DB020
037700000000     O                                           72 '------------------------'  DB020
037800000000     O                                           96 '------------------------'  DB020
037900000000     O                                          120 '------------------------'  DB020
038000000000     O                                          132 '------------'              DB020
038100000000     O***                                                                 DB020
038200000000     O          E            HEAD           1                                   DB020
038300000000     O                                            9 'ACCOUNT #'                 DB020
038400000000     O                                           18 'NAME'                      DB020
038500000000     O                                           64 'ENROLL'                    DB020
038600000000     O                                           71 '# OF'                      DB020
038700000000     O                                           88 'LAST'                      DB020
038800000000     O                                           97 'MED'                       DB020
038900000000     O                                          105 'DENTAL'                    DB020
039000000000     O                                          116 'LIFE/DSB'                  DB020
039100000000     O***                                                                 DB020
039200000000     O          E            HEAD           1                                   DB020
039300000000     O                                           64 'DATE'                      DB020
039400000000     O                                           71 'EMP'                       DB020
039500000000     O                                           88 'PREMIUM'                   DB020
039600000000     O                                           97 'COV'                       DB020
039700000000     O                                          105 'COV'                       DB020
039800000000     O                                          116 'COV'                       DB020
039900000000     O***                                                                 DB020
040000000000     O          E            HEAD           1                                   DB020
040100000000     O                                           24 '------------------------'  DB020
040200000000     O                                           48 '------------------------'  DB020
040300000000     O                                           72 '------------------------'  DB020
040400000000     O                                           96 '------------------------'  DB020
040500000000     O                                          120 '------------------------'  DB020
040600000000     O                                          132 '------------'              DB020
040700000000     O***                                                                 DB020
040800000000     O          E            DETACC         1                                   DB020
040900000000     O                       ACTRST               3                             DB020
041000000000     O                                            4 '-'                         DB020
041100000000     O                       ACSUB#               7                             DB020
041200000000     O                                            8 '-'                         DB020
041300000000     O                       ACACCT              12                             DB020
041400000000     O                       ACNAM1              54                             DB020
041500990503     O                       ENRMDY        Y     64                             DB020
041600000000     O                       AEMP          4B    71                             DB020
041700000000     O                       APREMI        2B    88                             DB020
041800000000     O                       AMED          4B    97                             DB020
041900000000     O                       ADEN          4B   105                             DB020
042000000000     O                       ALD           4B   116                             DB020
042100000000     O***                                                                 DB020
042200000000     O          E            DETTRS         1                                   DB020
042300000000     O                                           20 '------'                    DB020
042400000000     O                                           71 '------'                    DB020
042500000000     O                                           88 '----------'                DB020
042600000000     O                                           97 '------'                    DB020
042700000000     O                                          105 '------'                    DB020
042800000000     O                                          116 '------'                    DB020
042900000000     O***                                                                 DB020
043000000000     O          E            DETTRS         2                                   DB020
043100000000     O                                           11 'TRUST TOTAL'
043200000000     O                       TNUM          4B    20                             DB020
043300000000     O                       TEMP          4B    71                             DB020
043400000000     O                       TLPREM        2B    88                             DB020
043500000000     O                       TMED          4B    97                             DB020
043600000000     O                       TDEN          4B   105                             DB020
043700000000     O                       TLD           4B   116                             DB020
043800000000     O***                                                                 DB020
043900000000     O          E            DETBRK         1                                   DB020
044000000000     O                                           20 '------'                    DB020
044100000000     O                                           71 '------'                    DB020
044200000000     O                                           88 '----------'                DB020
044300000000     O                                           97 '------'                    DB020
044400000000     O                                          105 '------'                    DB020
044500000000     O                                          116 '------'                    DB020
044600000000     O***                                                                 DB020
044700000000     O          E            DETBRK         2                                   DB020
044800000000     O                                           12 'BROKER TOTAL'
044900000000     O                       BNUM          4B    20                             DB020
045000000000     O                       BEMP          4B    71                             DB020
045100000000     O                       BLPREM        2B    88                             DB020
045200000000     O                       BMED          4B    97                             DB020
045300000000     O                       BDEN          4B   105                             DB020
045400000000     O                       BLD           4B   116                             DB020
