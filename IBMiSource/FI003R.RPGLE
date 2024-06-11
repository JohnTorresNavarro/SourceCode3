000100020515      *-------------------------------------------------------------------------
000200020523      * FI003R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020523      *  DESCRIPTION - DISPLAY SMAN  RECORDS
000600020515      *? ***************************************************************
000700020517     FSMAN      IF   E           K DISK
000800020517     FFI003D    CF   E             WORKSTN
000900020515     F                                     SFILE(SFL_REC1:SRECNO1)
001000020515     F                                      INDDS(INDICATORS)
001100020515   X*
001200020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001300020515     D SCREEN          S              8
001400020619     D SMAN_HD         S                   LIKE(SMANCD)
001500020715     D STATUS          S              3
001600020515
0017000205150030 D INDICATORS      DS            99
0018000205230019 D F1_PREVIOUS            01     01N   INZ('0')
0019000206190019 D  F7_EXIT_PGM           07     07N   INZ('0')
002000020515     D  SFLDSP_11             11     11N   INZ('0')
002100020515     D  SFLEND_22             22     22N   INZ('0')
002200020515
002300020515     D                 DS
002400020515     D AREA                         100
002500020517     D  TRST_E                        3    OVERLAY(AREA)
002600020517     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
002700020517     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
002800020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
002900020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003000020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003100020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003200020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003300020523
003400020523     D                 DS
003500030327     D STYPE
003600030327     D  CODE_DS                            OVERLAY(STYPE:2)
003700030327
003800030327     D                 DS
003900030327     D SZIPCD
004000030327     D  SZIPCD5                            OVERLAY(SZIPCD)
004100030327     D  SZIPCD4                            OVERLAY(SZIPCD:*NEXT)
004200020523
004300020515     D                UDS
004400020517     D  APPL_E                 1      2
004500020517     D  CONAME               201    240
004600020515    *
004700020515      *? ***************************************************************
004800020515     C                   SELECT
004900020515     C                   WHEN      SCREEN = 'INITSFL '
005000020515     C                   EXSR      INITSFL_SR
005100020515     C                   WHEN      SCREEN = 'BLDSFL  '
005200020515     C                   EXSR      BLDSFL_SR
005300020515     C                   WHEN      SCREEN = 'DSPSFL  '
005400020515     C                   EXSR      DSPSFL_SR
005500020515     C                   WHEN      SCREEN = 'EXIT    '
005600020515     C                   EXSR      EXIT_SR
005700020523     C                   WHEN      SCREEN = 'READC   '
005800020523     C                   EXSR      READC_SR
005900020523     C                   WHEN      SCREEN = 'DSPSCRN2'
006000020523     C                   EXSR      DSPSCRN2_SR
006100020515     C                   OTHER
006200020515     C                   EXSR      EXIT_SR
006300020515     C                   ENDSL
006400020515   S*
006500020515      *? ***************************************************************
006600020515     C     INITSFL_SR    BEGSR
006700020515     C                   EVAL      SRECNO1 = *ZEROS
006800020515     C                   EVAL      RECNUM  = 1
006900020515     C                   EVAL      SFLDSP_11  = *ON
007000020515    ?C                   WRITE     SFL_CTL1
007100020515     C                   EVAL      SFLDSP_11  = *OFF
007200020515     C                   EVAL      SFLEND_22  = *ON
007300020515     C                   EVAL      SCREEN = 'BLDSFL  '
007400020515     C                   ENDSR
007500020515      *? ***************************************************************
007600020515     C     BLDSFL_SR     BEGSR
007700020523     C                   IF        SMAN_E = *ZEROS
007800020523     C                   EVAL      SMAN_E = *BLANKS
007900020523     C                   END
008000020517
008100020619     C     SMAN_HD       SETLL     SMANR
008200020517     C                   DOU       %EOF(SMAN)
008300020517     C                   READ      SMANR
008400020517     C                   IF        NOT %EOF(SMAN)
008500020619     C                   EVAL      SMANCD_H = SMANCD
008600020523     C                   EVAL      SELECT  = *BLANKS
008700020523     C                   EVAL      SRECNO1 = SRECNO1 + 1
008800020524     C                   IF        SRECNO1 > 9997
008900020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009000020524     C                   EVAL      SLNAME  = 'CANNOT DISPLAY ALL RECORDS'
009100020524     C                   WRITE     SFL_REC1
009200020524     C                   LEAVE
009300020524     C                   END
009400020515     C                   WRITE     SFL_REC1
009500020515     C                   END
009600001222     C                   ENDDO
009700020524     C                   IF        SRECNO1 = *ZEROS
009800020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009900020524     C                   EVAL      SLNAME  = 'NOT FOUND'
010000020524     C                   WRITE     SFL_REC1
010100020524     C                   END
010200020515     C                   EVAL      SCREEN = 'DSPSFL  '
010300020515    *
010400001222     C                   ENDSR
010500020515      *? ***************************************************************
010600020515     C     DSPSFL_SR     BEGSR
010700020515    ?C                   WRITE     CMD_LINE1
010800020515    ?C                   EXFMT     SFL_CTL1
010900020523
011000020715     C                   IF        F1_PREVIOUS    = *ON
011100020523     C                   EVAL      SCREEN = 'EXIT    '
011200020715     C                   EVAL      STATUS = 'F1 '
011300020523     C                   LEAVESR
011400020523     C                   END
011500020715
011600020715     C                   IF        F7_EXIT_PGM    = *ON
011700020715     C                   EVAL      SCREEN = 'EXIT    '
011800020715     C                   EVAL      STATUS = 'F7 '
011900020715     C                   LEAVESR
012000020715     C                   END
012100020523     C                   EVAL      SCREEN = 'READC   '
012200020515
012300020515     C                   ENDSR
012400020515
012500020523      *? ***************************************************************
012600020523     C     READC_SR      BEGSR
012700030327     C                   DOU       %EOF
012800020523     C                   READC     SFL_REC1
012900020523     C                   IF        NOT %EOF AND
013000020523     C                             SELECT = 'X'
013100020523    ?C                   EVAL      SCREEN = 'DSPSCRN2'
013200020523     C                   LEAVESR
013300020523     C                   END
013400030327     C                   ENDDO
013500020523
013600020717     C                   EVAL      SCREEN = 'INITSFL '
013700020523
013800020523     C                   ENDSR
013900020523      *? ***************************************************************
014000020523     C     DSPSCRN2_SR   BEGSR
014100020523     C     SMANCD_H      CHAIN     SMANR
014200020523    ?C                   EXFMT     SCRN2
014300020523
014400020619     C                   IF        F1_PREVIOUS    = *ON
014500020717     C                   EVAL      SCREEN = 'INITSFL '
014600020715     C                   EVAL      STATUS = 'F1 '
014700020523     C                   LEAVESR
014800020523     C                   END
014900020619
015000020619     C                   IF        F7_EXIT_PGM    = *ON
015100020619     C                   EVAL      SCREEN = 'EXIT    '
015200020715     C                   EVAL      STATUS = 'F7 '
015300020619     C                   LEAVESR
015400020619     C                   END
015500020717     C                   EVAL      SCREEN = 'INITSFL '
015600020523
015700020523     C                   ENDSR
015800020523
015900020515      *? ***************************************************************
016000020515     C     EXIT_SR       BEGSR
016100020715     C     *LOCK         IN        AREA
016200020715     C                   MOVE      STATUS        STAT_E
016300020715     C                   OUT       AREA
016400020515     C                   EVAL      *INLR = *ON
016500020515     C                   RETURN
016600020515     C                   ENDSR
016700020515      *? ***************************************************************
016800020515     C     *INZSR        BEGSR
016900020515     C     *DTAARA       DEFINE    FI060A        AREA
017000020715     C     *LOCK         IN        AREA
017100020619     C                   MOVE      SMAN_E        SMAN_HD
017200020715     C                   MOVE      STAT_E        STATUS
017300020715     C                   OUT       AREA
017400020517    *
017500020517     C                   IF        APPL_E = 'F.'
017600020517     C                   EVAL      W_APPL = 'FULL'
017700020517     C                   ELSE
017800020517     C                   EVAL      W_APPL = 'SELF'
017900020517     C                   END
018000020515    *
018100020515     C                   EVAL      SCREEN = 'INITSFL '
018200020515     C                   ENDSR
