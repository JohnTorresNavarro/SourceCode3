000100000000      ******************************************************************
000200000000      *                                                                *
000300000000      *  RP541     GROUP BENEFIT SERVICES SOFTWARE                     *
000400000000      *                                                                *
000500000000      *            WRITTEN BY - DAVID KETTERMAN                        *
000600000000      *            DATE - 06/09/97                                     *
000700000000      *                                                                *
000800000000      *  DESCRIPTION - BROKER BUSINESS REPORT - SUMMARY                *
000900000000      *                                                                *
001000000000      *    JGE  12.08.98 - Modified for Y2k date conversion            *
001100000000      *        JGE01     All dates modified to use a 4 digit year for  *
001200000000      *                  comparisons and output.  File record lengths  *
001300000000      *                  modified as needed for new date positions.    *
001400000000      *                                                                *
001500000000      ******************************************************************
001600981214     F***                                                              *
001700000000     FRP540WK   IP   E           K DISK
001800000000     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
001900981214     D***
002000000000     D                UDS
002100000000     D  LBROK                  1      3
002200000000     D  LTRST                  4      6
002300000000     D  LREMM                  7      8
002400990811     D  LREYY                  9     12
002500990811     D  LEFMM                 13     14
002600990811     D  LEFYY                 15     18
002700990811     D  LMEM                  19     19
002800990811     D  LDSB                  20     20
002900000000     D  CONAME               201    240
003000000000     D  TIME                 242    247  0
003100981214     F***
003200981214     I***
003300000000     IRP540R
003400000000     I                                          W#EMP         L1
003500000000     I                                          WSMAN         L2
003600981214     I***
003700981214     C***
003800000000     C     *INOF         IFEQ      *ON
003900000000     C     *INL2         OREQ      *ON
004000000000     C                   EXCEPT    HEAD
004100000000     C                   END
004200000000     C*
004300000000     C                   ADD       1             L1ACC             6 0
004400000000     C                   ADD       W#EMP         L1EMP             6 0
004500000000     C                   ADD       WLPREM        L1PREM           10 2
004600000000     C*
004700000000     C* L1 TOTAL - # OF EMPLOYEES
004800000000     C*
004900000000     CL1                 ADD       L1ACC         L2ACC             6 0
005000000000     CL1                 ADD       L1EMP         L2EMP             6 0
005100000000     CL1                 ADD       L1PREM        L2PREM           11 2
005200000000     CL1 OF              EXCEPT    HEAD
005300000000     CL1                 EXCEPT    L1PRT
005400000000     C*
005500000000     C* L2 TOTAL - BROKER TOTALS
005600000000     C*
005700000000     CL2 OF              EXCEPT    HEAD
005800000000     CL2                 EXCEPT    L2PRT
005900981214     C***
006000981214     O***                                                                 DB020
006100000000     OQSYSPRT   E            HEAD           2 03                                DB020
006200000000     O                       CONAME              83                             DB020
006300981214     O*                                                                   DB020
006400000000     O          E            HEAD           1                                   DB020
006500000000     O                       UDATE         Y      8                             DB020
006600000000     O                                           71 'BROKER BUSINESS REPORT'
006700000000     O                                           81 ' - SUMMARY'
006800000000     O                                          123 'PAGE :'                    DB020
006900000000     O                       PAGE          Z    132                             DB020
007000981214     O*                                                                   DB020
007100000000     O          E            HEAD           1                                   DB020
007200000000     O                                           11 'PROG: RP541'               DB020
007300000000     O                                           66 'EFFECTIVE DATE:'
007400000000     O                       LEFMM               69
007500000000     O                                           70 '/'
007600981215JGE01O                       LEFYY               74
007700000000     O                                          123 'TIME :'                    DB020
007800000000     O                       TIME               132 '  :  :  '                  DB020
007900981214     O*                                                                   DB020
008000000000     O          E            HEAD           1                                   DB020
008100000000     O                                           52 'BROKER:'
008200000000     O                       WSMAN               56
008300000000     O                       WSNAME              90
008400981214     O*                                                                   DB020
008500000000     O          E            HEAD           1                                   DB020
008600000000     O                                           24 '------------------------'  DB020
008700000000     O                                           48 '------------------------'  DB020
008800000000     O                                           72 '------------------------'  DB020
008900000000     O                                           96 '------------------------'  DB020
009000000000     O                                          120 '------------------------'  DB020
009100000000     O                                          132 '------------'              DB020
009200981214     O*                                                                   DB020
009300000000     O          E            HEAD           1                                   DB020
009400000000     O                                            9 '# OF'                      DB020
009500000000     O                                           20 '# OF'                      DB020
009600000000     O                                           33 'TOTAL'                     DB020
009700000000     O                                           49 'TOTAL'                     DB020
009800981214     O*                                                                   DB020
009900000000     O          E            HEAD           1                                   DB020
010000000000     O                                            9 'EMPLOYEES'                 DB020
010100000000     O                                           20 'ACCOUNTS'                  DB020
010200000000     O                                           33 'EMPLOYEES'                 DB020
010300000000     O                                           49 'PREMIUM'                   DB020
010400981214     O*                                                                   DB020
010500000000     O          E            HEAD           2                                   DB020
010600000000     O                                           24 '------------------------'  DB020
010700000000     O                                           48 '------------------------'  DB020
010800000000     O                                           72 '------------------------'  DB020
010900000000     O                                           96 '------------------------'  DB020
011000000000     O                                          120 '------------------------'  DB020
011100000000     O                                          132 '------------'              DB020
011200981214     O*                                                                   DB020
011300000000     O          E            L1PRT          1                                   DB020
011400000000     O                       W#EMP         3B     5                             DB020
011500000000     O                       L1ACC         4B    20                             DB020
011600000000     O                       L1EMP         4B    33                             DB020
011700000000     O                       L1PREM        2B    49                             DB020
011800981214     O*                                                                   DB020
011900000000     O          E            L2PRT          1                                   DB020
012000000000     O                                           20 '------'                    DB020
012100000000     O                                           33 '------'                    DB020
012200000000     O                                           49 '----------'                DB020
012300981214     O*                                                                   DB020
012400000000     O          E            L2PRT          2                                   DB020
012500000000     O                                            5 'TOTAL'
012600000000     O                       L2ACC         4B    20                             DB020
012700000000     O                       L2EMP         4B    33                             DB020
012800000000     O                       L2PREM        2B    49                             DB020
