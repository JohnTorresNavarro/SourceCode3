000100020515      *-------------------------------------------------------------------------
000200020523      * FI060_4R   INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020516      *  DESCRIPTION - DISPLAY RELATED ACCT  RECORDS
000600020515      *? ***************************************************************
000700020516     FACRELATP  IF   E           K DISK
000800020516     FACCMST    IF   E           K DISK
000900020516     FSUBMST    IF   E           K DISK
001000020516     FTRSMST    IF   E           K DISK
001100020516     FFI060_4D  CF   E             WORKSTN
001200020515     F                                     SFILE(SFL_REC1:SRECNO1)
001300020515     F                                      INDDS(INDICATORS)
001400020515   X*
001500020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001600020515     D SCREEN          S              8
001700020715     D STATUS          S              3
001800020515
0019000205150030 D INDICATORS      DS            99
0020000206190019 D  F1_BACK               01     01N   INZ('0')
0021000206190019 D  F7_EXIT_PGM           07     07N   INZ('0')
002200020515     D  SFLDSP_11             11     11N   INZ('0')
002300020515     D  SFLEND_22             22     22N   INZ('0')
002400020517     D  CANCELED_80           80     80N   INZ('0')
002500020515
002600020515     D                 DS
002700020515     D AREA                         100
002800020515     D  TRST_E                        3    OVERLAY(AREA)
002900020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003000020516     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003100020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003200020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003300020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003400020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003500020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003600020516
003700020516     D                 DS
003800020516     D ACNAM1
003900020516     D  ACNAM1X                            OVERLAY(ACNAM1)
004000020516
004100020516     D                UDS
004200020517     D  APPL_E                 1      2
004300020516     D  CONAME               201    240
004400020515    *
004500020515      *? ***************************************************************
004600020515     C                   SELECT
004700020515     C                   WHEN      SCREEN = 'INITSFL '
004800020515     C                   EXSR      INITSFL_SR
004900020515     C                   WHEN      SCREEN = 'BLDSFL  '
005000020515     C                   EXSR      BLDSFL_SR
005100020515     C                   WHEN      SCREEN = 'DSPSFL  '
005200020515     C                   EXSR      DSPSFL_SR
005300020515     C                   WHEN      SCREEN = 'EXIT    '
005400020515     C                   EXSR      EXIT_SR
005500020515     C                   OTHER
005600020515     C                   EXSR      EXIT_SR
005700020515     C                   ENDSL
005800020515   S*
005900020515      *? ***************************************************************
006000020515     C     INITSFL_SR    BEGSR
006100020515     C                   EVAL      SRECNO1 = *ZEROS
006200020515     C                   EVAL      RECNUM  = 1
006300020515     C                   EVAL      SFLDSP_11  = *ON
006400020515    ?C                   WRITE     SFL_CTL1
006500020515     C                   EVAL      SFLDSP_11  = *OFF
006600020515     C                   EVAL      SFLEND_22  = *ON
006700020515     C                   EVAL      SCREEN = 'BLDSFL  '
006800020515     C                   ENDSR
006900020515      *? ***************************************************************
007000020515     C     BLDSFL_SR     BEGSR
007100020516     C     *NOKEY        CLEAR     *ALL          TRSMSR
007200020524     C     TRST_N        CHAIN     TRSMSR
007300020516     C     *NOKEY        CLEAR     *ALL          SUBMSR
007400020516     C     SUBMST_KEY    CHAIN     SUBMSR
007500020516     C     *NOKEY        CLEAR     *ALL          ACCMSR
007600020516     C     ACCMST_KEY    CHAIN     ACCMSR
007700020717     C                   EVAL      ACCT_NAME = ACNAM1
007800020517     C                   IF        ACDLTD <> 'A'
007900020517     C                   EVAL      CANCELED_80 = *ON
008000020517     C                   ELSE
008100020517     C                   EVAL      CANCELED_80 = *OFF
008200020517     C                   END
008300020516     C     ACRELAT_KEY   SETLL     ACCRELATR
008400020516     C                   DOU       %EOF(ACRELATP)
008500020524     C     ACRELAT_KEY   READE     ACCRELATR
008600020516     C                   IF        NOT %EOF(ACRELATP)
008700020516     C     *NOKEY        CLEAR     *ALL          ACCMSR
008800020516     C     ACCMST_KEY    CHAIN     ACCMSR
008900020515     C                   EVAL      SRECNO1 = SRECNO1 + 1
009000020524     C                   IF        SRECNO1 > 9997
009100020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009200020524     C                   EVAL      ACNAM1X = 'CANNOT DISPLAY ALL RECORDS'
009300020524     C                   WRITE     SFL_REC1
009400020524     C                   LEAVE
009500020524     C                   END
009600020515     C                   WRITE     SFL_REC1
009700020515     C                   END
009800001222     C                   ENDDO
009900020524     C                   IF        SRECNO1 = *ZEROS
010000020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
010100020524     C                   EVAL      ACNAM1X = *BLANKS
010200020524     C                   WRITE     SFL_REC1
010300020524     C                   END
010400020515     C                   EVAL      SCREEN = 'DSPSFL  '
010500020515    *
010600001222     C                   ENDSR
010700020515      *? ***************************************************************
010800020515     C     DSPSFL_SR     BEGSR
010900020515    ?C                   WRITE     CMD_LINE1
011000020515    ?C                   EXFMT     SFL_CTL1
011100020515     C                   EVAL      SCREEN = 'EXIT    '
011200020716     C                   IF        F1_BACK = *ON
011300020716     C                   EVAL      STATUS = 'F1 '
011400020716     C                   EVAL      SCREEN = 'EXIT    '
011500020716     C                   END
011600020716     C                   IF        F7_EXIT_PGM = *ON
011700020716     C                   EVAL      STATUS = 'F7 '
011800020716     C                   EVAL      SCREEN = 'EXIT    '
011900020716     C                   END
012000020515
012100020515     C                   ENDSR
012200020515
012300020515      *? ***************************************************************
012400020515     C     EXIT_SR       BEGSR
012500020715     C     *LOCK         IN        AREA
012600020715     C                   MOVE      STATUS        STAT_E
012700020715     C                   OUT       AREA
012800020515     C                   EVAL      *INLR = *ON
012900020515     C                   RETURN
013000020515     C                   ENDSR
013100020515      *? ***************************************************************
013200020515     C     *INZSR        BEGSR
013300020515     C     *DTAARA       DEFINE    FI060A        AREA
013400020715     C     *LOCK         IN        AREA
013500020524     C                   MOVE      TRST_E        TRST_N
013600020524     C                   MOVE      SUB#_E        SUB#_N
013700020524     C                   MOVE      ACCT_E        ACCT_N
013800020715     C                   MOVE      STAT_E        STATUS
013900020715     C                   OUT       AREA
014000020516     C     SUBMST_KEY    KLIST
014100020524     C                   KFLD                    TRST_N
014200020524     C                   KFLD                    SUB#_N
014300020516     C     ACCMST_KEY    KLIST
014400020524     C                   KFLD                    TRST_N
014500020524     C                   KFLD                    SUB#_N
014600020524     C                   KFLD                    ACCT_N
014700020516     C     ACRELAT_KEY   KLIST
014800020517     C                   KFLD                    ARAPPL
014900020524     C                   KFLD                    TRST_N
015000020524     C                   KFLD                    SUB#_N
015100020524     C                   KFLD                    ACCT_N
015200020517    *
015300020517     C                   IF        APPL_E = 'F.'
015400020517     C                   EVAL      ARAPPL = 'F'
015500020517     C                   EVAL      W_APPL = 'FULL'
015600020517     C                   ELSE
015700020517     C                   EVAL      ARAPPL = 'S'
015800020517     C                   EVAL      W_APPL = 'SELF'
015900020517     C                   END
016000020515     C                   EVAL      SCREEN = 'INITSFL '
016100020515     C                   ENDSR
