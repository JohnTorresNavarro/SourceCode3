0002009102120002 F*
0003009201100003 F* UPDATE MEDEMP FIELD
0004000811030004 F* 11/3/08 - this version became the production version because
0004010811030004 F*           it uses the plan category type of "M".
0004020811030004 F*
0008009809140005 FACCMST    UP   F  560        DISK
0009009809140012 FMEMACC    IF   F  648    10AIDISK    KEYLOC(136)
0010009809140016 FMCOV      IF   F   88     9AIDISK    KEYLOC(1)
0011000810220014 FPLNMST    If   F  200    10AIDISK    KEYLOC(1)
0012000810220014 FCODESL1   If   F   64     3AIDISK    KEYLOC(1)
0013000810220008 FREPORT    O    f  132        PRINTER OFLIND(*INOF)
0014009809140004 D                UDS                                                       COMPNY
001500081022Y2K  D  coname               201    240                                         COMPNY
001501081022Y2K  D  UD8YMD               248    255  0                                      COMPNY
0016009109160007 IACCMST    NS  01
001700920110     I                                  1    3 0ATRST
001800931012     I                                  4    6 0ASUB
001900911003     I                                  1   10 0TSA
002000980914     I                                512  512  ADLT
002100980914     I                                537  544 0ACAN
002200980914     I                                545  552 0AENR
0023009201100100 IMEMACC    NS
0024009109230101 I*  MEMBER FILE
0025009109230102 I                                  1    9 0SSNO
002600980914     I                                512  512  MDLT
002700980914     I                                561  568 0MENRL
002800980914     I                                577  584 0MCAN
0029009201100033 IMCOV      NS
0030009109230034 I*  MEMBER COVERAGE FILE
003100980914     I                                 12   21  KEYPLN
0032009809140039 I                                 18   21  PLAN#
003300980914     I                                 64   64  MCDLT
003400980914     I                                 65   72 0MCENR
003500980914     I                                 73   80 0MCCAN
0036009310120082 IPLNMST    NS  01
0037009109230083 I*  PLAN MASTER
0038009310120088 I                                 11   50  PDESCR
0039009310120138 I                                163  165  PLNCAT
0040000701080082 ICODESL1   NS  01
0041000701080088 I                                 44   44  TYPE
004200931012     C*
004300950822     C* USE THIS DATE FOR ALL CHECKS - FIRST OF CURRENT MONTH
004400941019     C*
0045009809140134 C     FIRST         IFNE      'N'
0046009809140139 C                   MOVE      'N'           FIRST             1
004700980914     C                   MOVE      UD8YMD        DATCHK            8 0
004800980914     C                   MOVE      01            DATCHK
0049009809140141 C                   END
005000941019     C*
005100941019     C*
005200941019     C*
005300920110     C     ACAN          IFGT      0
005400980914     C     ACAN          IFLE      DATCHK
005500911003     C                   GOTO      #END
005600911003     C                   END
005700920110     C                   END
005800911003     C*
005900081022     C     AENR          IFGT      ud8ymd
006000920110     C                   GOTO      #END
006100920110     C                   END
006200920110     C*
006300920113     C                   Z-ADD     0             NUMMED            7 0
006400910923     C                   SETOFF                                           21
006500910923     C     TSA           SETLL     MEMACC
006600910923     C     #T0020        TAG
006700910923     C     TSA           READE     MEMACC                                 21
006800911003     C   21              GOTO      #T0060
006900920110     C     MCAN          IFNE      0
007000980914     C     MCAN          IFLE      DATCHK
007100911003     C                   GOTO      #T0020
007200911003     C                   END
007300920110     C                   END
007400980914     C     MENRL         IFGT      DATCHK
007500920110     C                   GOTO      #T0020
007600920110     C                   END
007700910923     C*
007800910923     C                   SETOFF                                           22
007900910923     C     SSNO          SETLL     MCOV
008000910923     C     #T0030        TAG
008100910923     C     SSNO          READE     MCOV                                   22
008200911003     C   22              GOTO      #T0020
008300920113     C     MCDLT         IFEQ      'D'
008400920113     C                   GOTO      #T0030
008500920113     C                   END
008600920110     C     MCCAN         IFNE      0
008700980914     C     MCCAN         IFLE      DATCHK
008800920110     C                   GOTO      #T0030
008900920110     C                   END
009000920110     C                   END
009100980914     C     MCENR         IFGT      DATCHK
009200920110     C                   GOTO      #T0030
009300920110     C                   END
009400910923     C*
009500081022     C* USE PLAN CAT TYPE of "M" for medical
009600941019     C*
009700931012     C     KEYPLN        CHAIN     PLNMST                             99
009800931012     C   99              GOTO      #T0030
009900070108     C     PLNCAT        CHAIN     CODESL1                            98
010000070108     C   98              GOTO      #T0030
010100070108     C     TYPE          IFNE      'M'
010200070108     C                   GOTO      #T0030
010300931012     C                   ELSE
010400911003     C                   ADD       1             NUMMED
010500931012     C                   GOTO      #T0020
010600920110     C                   END
010700911003     C*
010800920110     C     #T0060        TAG
010900920113     C   U1              EXCEPT    UPACC
011000920113     C                   EXCEPT    PRT
011001081022     c                   add       1             numacc            7 0
011100920110     C                   Z-ADD     0             NUMMED
011200910923     C     #END          TAG
011300910923     C*
0114009110030036 OREPORT    H    1P                     2 03
011500911003     O         OR    OF
011800081022     O                       coname              85
0120009110030367 O          H    1P                     2
012100911003     O         OR    OF
0122000810220369 O                                           72 'NUMBER OF MEDICAL MEMBER'
0123000810220370 O                                           85 'S IN ACCOUNTS'
0124009110030367 O          H    1P                     1
012500911003     O         OR    OF
0126000810220373 O                                           25 'PROGRAM NAME: QDA10B'
0127009109230374 O                                          125 'PAGE:'
0128009109230375 O                       PAGE          Z    131
0129009110030367 O          H    1P                     1
013000911003     O         OR    OF
0131009109230378 O                                           14 'RUN DATE:'
0132009109230379 O                       UDATE         Y     25
0133009110030367 O          H    1P                     1
013400911003     O         OR    OF
0135009109230382 O                                           24 '""""""""""""""""""""""""'
0136009109230383 O                                           48 '""""""""""""""""""""""""'
0137009109230384 O                                           72 '""""""""""""""""""""""""'
0138009109230385 O                                           96 '""""""""""""""""""""""""'
0139009109230386 O                                          120 '""""""""""""""""""""""""'
0140009109230387 O                                          132 '""""""""""""'
0141009110030367 O          H    1P                     1
014200911003     O         OR    OF
014300911003     O                                            7 'ACC#'
014400920113     O                                           31 '# OF MED EMP'
0145009110030367 O          H    1P                     2
014600911003     O         OR    OF
0147009109230382 O                                           24 '""""""""""""""""""""""""'
0148009109230383 O                                           48 '""""""""""""""""""""""""'
0149009109230384 O                                           72 '""""""""""""""""""""""""'
0150009109230385 O                                           96 '""""""""""""""""""""""""'
0151009109230386 O                                          120 '""""""""""""""""""""""""'
0152009109230387 O                                          132 '""""""""""""'
0153009201130380 O          E            PRT            1
015400911003     O                       TSA                 13 '0   -   -    '
015500920113     O                       NUMMED        1     29
0155010810220380 O          t    lr                  1  1
015502081022     O                                           +2 'NUMBER OF ACCOUNTS UPDATED'
015503081022     O                                           +1 ':'
015504081022     O                       numacc        1     +2
015600920110     OACCMST    E            UPACC
015700920110     O                       NUMMED             469P
