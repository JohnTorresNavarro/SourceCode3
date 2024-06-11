000100910801     H DFTNAME(RP401)
0002009811200011 F*                                                                *
0003009811200010 F*  Y2K CONVERT - 1998                                            *
0004009811200012 F*                                                                *
000500010305   X***X
000600010305    *** RP401R
000700010305    *** 3.5.01 CONVERTED TO RPGLE
000800010305    ***
000900010305   X***X
0010000103060002 FACCMST    IPE  E             DISK
0011000103050014 FSMAN      IF   F  272     3AIDISK    KEYLOC(1)
0012000103060004 FRP401WF   O  A E             DISK
001300010306     FREPORT    O    F  132        PRINTER OFLIND(*INOA)
0014000103060005 I*CCMST    NS  01
0015000103060006 I*                                 1   10 0TRSBAC
001600010306     I*                                 1    6 0TRSUB
001700010306     I*                                 1    3  TR
0018000103060022 I*                                11   50  ACNAM1
0019000103060028 I*                            P  168  172 0AZIP
0020000103060048 I*                            P  210  213 0NOEMPL
0021000103060048 I*                            P  249  253 2APREMI
002200010306C076 I*                               470  471  ACONTY
002300010306C076 I*                               483  485  SMANCD
0024000103060082 I*                               512  512  DLTCD
002500010306C076 I*                               537  544 0TERMDT
0026009108020056 ISMAN      NS
0027009108020068 I                                 93   95  STYPE
0028009102150023 C*
002900010306     C                   MOVE      ACTRST        TR                3
003000950328     C     LTRST         IFNE      'ALL'
003100950328     C     LTRST         IFNE      TR
003200950328     C                   GOTO      #END
003300950328     C                   END
003400950328     C                   END
0035009503280023 C*
003600950328     C     LCNTY         IFNE      '  '
003700950328     C     LCNTY         IFNE      ACONTY
003800950328     C                   GOTO      #END
003900950328     C                   END
004000950328     C                   END
0041009503280025 C*
0042009507130023 C*
004300950713     C     SELEC         IFEQ      'G'
004400950713     C     SMANCD        IFNE      'ZZZ'
004500950713     C                   GOTO      #END
004600950713     C                   END
004700950713     C                   END
0048009507130025 C*
004900950713     C     SELEC         IFEQ      'B'
005000950713     C     SMANCD        IFEQ      'ZZZ'
005100950713     C                   GOTO      #END
005200950713     C                   END
005300950713     C                   END
0054009507130025 C*
005500010306     C     ATRMDT        IFEQ      0
0056009503280025 C*
005700950328     C     TR            IFEQ      '990'
005800910802     C                   GOTO      #END
005900910802     C                   END
006000910802     C*
006100910802     C     SMANCD        CHAIN     SMAN                               67
006200910802     C   67              EXCEPT    PRINT2
006300910805     C  N67              MOVE      'G'           GBSBRK
006400910802     C  N67STYPE         IFEQ      'FBO'
006500910805     C                   MOVE      'B'           GBSBRK            1
006600910802     C                   END
006700910802     C*
006800910802     C  N67STYPE         IFEQ      'FOB'
006900910805     C                   MOVE      'B'           GBSBRK
007000910802     C                   END
007100910802     C*
007200910805     C  N67STYPE         IFEQ      'FO5'
007300910805     C                   MOVE      'B'           GBSBRK
007400910802     C                   END
007500910802     C*
007600010306     C                   WRITE     R401
0077009102150027 C*
007800910802     C                   END
0079009102150028 C*
008000910802     C     #END          TAG
008100010305   S***S
008200010305     C     *INZSR        BEGSR
008300010305     C     *ENTRY        PLIST
008400010305     C                   PARM                    LTRST             3
008500010305     C                   PARM                    LCNTY             2
008600010305     C                   PARM                    SELEC             1
008700010305     C                   ENDSR
008800010305   X***X
0089000103060033 OREPORT    E            PRINT2            1
009000910802     O                                           31 'SALESMAN CODE NOT '
009100910802     O                                           46 'FOUND IN SMAST'
009200910802     O                       SMANCD              55
