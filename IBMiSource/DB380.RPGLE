000100941020     H DFTNAME(DB380)
0002009102120002 F*
0003009410200003 F* FIND MISSING GRPCTR REC
0004009102120004 F*
0005009102120005 F*
0006009808260014 F*                                                                *
0007009808260010 F*  Y2K CONVERT - 1998                                            *
0008009808260015 F*                                                                *
000900010222     F* MODIFICATIONS HISTORY
001000010222     F* 08.25.1998 ??? Y2K CONVERSION
001100010222     F* 02.22.2001 SSK RPGIV CONVERSION
001200010222     F*
001300010222     F*
001400010222     F******************************************************************
001500010222      *
0016000102210006 FGRATE     IP   F   80        DISK
0017000102220006 FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
0018000102220013 FGRPCTR    IF   F   48    18AIDISK    KEYLOC(1)
0019000102220008 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
0020009208240119 D                 DS
0021009208240120 D  CARGRP                 1     18
0022009208240121 D  PCARR                  1      3
0023009208240122 D  GROUP#                 4     18
0024009102120007 IGRATE     NS  01
002500980826     I                                  1    3  TRUST#
002600980826     I                                  4    6  SUB#
002700980826     I                                  7   10  PLAN#
002800980826     I                                  1   10  TSP           L1
002900950217     I                                 24   38  GROUP#        L1
003000910614     IPLNMST    NS
003100920824     I                                 53   55  PCARR
0032009208240138 I                                163  165  PLNCAT
0033009208240020 IGRPCTR    NS  01
003400941020     C  NL1              GOTO      #END
003500910614     C     TSP           CHAIN     PLNMST                             20
003600920824     C   20              EXCEPT    ERR1
003700941020     C   20              ADD       1             TOTER1            5 0
003800950217     C   20              GOTO      #END
003900920824     C*
0040009208240146 C     PCARR         IFEQ      'BCM'
0041009208240433 C     CARGRP        CHAIN     GRPCTR                             21
004200920824     C   21              EXCEPT    ERR2
004300941020     C   21              ADD       1             TOTER2            5 0
004400920824     C                   GOTO      #END
004500920824     C                   END
004600960315     C*
0047009603150146 C     PCARR         IFEQ      'BMS'
0048009603150433 C     CARGRP        CHAIN     GRPCTR                             21
004900960315     C   21              EXCEPT    ERR2
005000960315     C   21              ADD       1             TOTER2            5 0
005100960315     C                   GOTO      #END
005200960315     C                   END
005300960315     C*
0054009603150146 C     PCARR         IFEQ      'BVS'
0055009603150433 C     CARGRP        CHAIN     GRPCTR                             21
005600960315     C   21              EXCEPT    ERR2
005700960315     C   21              ADD       1             TOTER2            5 0
005800960315     C                   GOTO      #END
005900960315     C                   END
006000920824     C*
006100920824     C     PCARR         IFEQ      'BCS'
0062009208240147 C     PLNCAT        IFEQ      'PDN'
0063009208240433 C     CARGRP        CHAIN     GRPCTR                             21
006400920824     C   21              EXCEPT    ERR2
006500941020     C   21              ADD       1             TOTER2
006600990309     C                   GOTO      #END
0067009208240149 C                   END
006800920824     C                   END
006900920824     C*
007000910617     C*
007100990309     C*
0072009903090146 C     PCARR         IFEQ      'CPA'
0073009903090433 C     CARGRP        CHAIN     GRPCTR                             21
007400990309     C   21              EXCEPT    ERR2
007500990309     C   21              ADD       1             TOTER2            5 0
007600990309     C                   GOTO      #END
007700990309     C                   END
007800990309     C*
0079009903090146 C     PCARR         IFEQ      'CPH'
0080009903090433 C     CARGRP        CHAIN     GRPCTR                             21
008100990309     C   21              EXCEPT    ERR2
008200990309     C   21              ADD       1             TOTER2            5 0
008300990309     C                   GOTO      #END
008400990309     C                   END
008500990309     C*
008600910625     C     #END          TAG
0087009410200030 OREPORT    H    1P                     1  3
008800941020     O         OR    OF
008900941020     O                                           59 'RATE RECORDS WITH MISSIN'
009000941020     O                                           83 'G BLUE CROSS CONTRACT # '
0091009410200030 OREPORT    H    1P                     1
009200941020     O         OR    OF
009300941020     O                                           14 'TRUST-SUB-PLAN'
009400941020     O                                           34 'CARRIER   GROUP #'
009500941020     O                                           71 'ERROR              '
009600941020     O                                          130 'PROG: DB380'
0097009410200030 OREPORT    H    1P                     1
009800941020     O         OR    OF
0099009410200259 O                                           24 '------------------------'
0100009410200260 O                                           48 '------------------------'
0101009410200261 O                                           72 '------------------------'
0102009410200262 O                                           96 '------------------------'
0103009410200263 O                                          120 '------------------------'
0104009410200264 O                                          132 '------------'
0105009808260033 OREPORT    E            ERR1           1
0106009808260034 O                       TRUST#               3
0107009808260034 O                                            4 '-'
0108009808260034 O                       SUB#                 7
0109009808260034 O                                            8 '-'
0110009808260034 O                       PLAN#               12
011100941020     O                                           71 'INVALID PLAN       '
0112000102220033 OREPORT    E            ERR2           1
0113009808260034 O                       TRUST#               3
0114009808260034 O                                            4 '-'
0115009808260034 O                       SUB#                 7
0116009808260034 O                                            8 '-'
0117009808260034 O                       PLAN#               12
011800010222     O                       PCARR          B    22
011900941020     O                       GROUP#         B    42
012000941020     O                                           71 'INVALID CARR/GROUP#'
0121009410200033 OREPORT    T    LR                  1
012200941020     O                                           22 'TOTAL ERRORS : PLANS -'
012300941020     O                       TOTER1              28
012400941020     O                                           38 'GRPCTR -'
012500941020     O                       TOTER2              44
