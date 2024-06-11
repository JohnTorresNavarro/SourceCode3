000100020515      *-------------------------------------------------------------------------
000200020515      * FI007R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020515      *  DESCRIPTION - DISPLAY SUBD  RECORDS
000600020515      *? ***************************************************************
000700020515     FSUBMST    IF   E           K DISK
000800020618     FTRSMST    IF   E           K DISK
000900020515     FFI007D    CF   E             WORKSTN
001000020515     F                                     SFILE(SFL_REC1:SRECNO1)
001100020515     F                                      INDDS(INDICATORS)
001200020515   X*
001300020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001400020515     D SCREEN          S              8
001500020619     D SUB#_HD         S                   LIKE(SBSUB#)
001600020715     D STATUS          S              3
001700020515
0018000205150030 D INDICATORS      DS            99
0019000206180019 D  F1_BACK               01     01N   INZ('0')
0020000206180019 D  F7_EXIT_PGM           07     07N   INZ('0')
002100020515     D  SFLDSP_11             11     11N   INZ('0')
002200020515     D  SFLEND_22             22     22N   INZ('0')
002300020618     D  CANCELED_80           80     80N   INZ('0')
002400020515
002500020515     D                 DS
002600020515     D AREA                         100
002700020515     D  TRST_E                        3    OVERLAY(AREA)
002800020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
002900020517     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003000020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003100020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003200020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003300020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003400020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003500020515     D                UDS
003600020517     D  APPL_E                 1      2
003700020517     D  CONAME               201    240
003800020515    *
003900020515      *? ***************************************************************
004000020515     C                   SELECT
004100020515     C                   WHEN      SCREEN = 'INITSFL '
004200020515     C                   EXSR      INITSFL_SR
004300020515     C                   WHEN      SCREEN = 'BLDSFL  '
004400020515     C                   EXSR      BLDSFL_SR
004500020515     C                   WHEN      SCREEN = 'DSPSFL  '
004600020515     C                   EXSR      DSPSFL_SR
004700020618     C                   WHEN      SCREEN = 'READC   '
004800020618     C                   EXSR      READC_SR
004900020619     C                   WHEN      SCREEN = 'SCRN1   '
005000020619     C                   EXSR      SCRN1_SR
005100020515     C                   WHEN      SCREEN = 'EXIT    '
005200020515     C                   EXSR      EXIT_SR
005300020515     C                   OTHER
005400020515     C                   EXSR      EXIT_SR
005500020515     C                   ENDSL
005600020515   S*
005700020515      *? ***************************************************************
005800020515     C     INITSFL_SR    BEGSR
005900020515     C                   EVAL      SRECNO1 = *ZEROS
006000020515     C                   EVAL      RECNUM  = 1
006100020515     C                   EVAL      SFLDSP_11  = *ON
006200020515    ?C                   WRITE     SFL_CTL1
006300020515     C                   EVAL      SFLDSP_11  = *OFF
006400020515     C                   EVAL      SFLEND_22  = *ON
006500020515     C                   EVAL      SCREEN = 'BLDSFL  '
006600020515     C                   ENDSR
006700020515      *? ***************************************************************
006800020515     C     BLDSFL_SR     BEGSR
006900020619     C                   IF        TRST_HD = *ZEROS
007000020524     C                   EVAL      SCREEN = 'EXIT    '
007100020524     C                   ELSE
007200020619     C     SUBMST_KEY    SETLL     SUBMSR
007300020515     C                   DOU       %EOF(SUBMST)
007400020524     C                   READ      SUBMSR
007500020515     C                   IF        NOT %EOF(SUBMST)
007600020619     C                   IF        TRST_HD <> SBTRST
007700020524     C                   LEAVE
007800020524     C                   END
007900020618     C                   EVAL      SUB#_H  = SBSUB#
008000020515     C                   EVAL      SRECNO1 = SRECNO1 + 1
008100020716     C                   EVAL      SELECT  = *BLANKS
008200020524     C                   IF        SRECNO1 > 9997
008300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008400020524     C                   EVAL      SUBNAM  = 'CANNOT DISPLAY ALL RECORDS'
008500020524     C                   WRITE     SFL_REC1
008600020524     C                   LEAVE
008700020524     C                   END
008800020515     C                   WRITE     SFL_REC1
008900020515     C                   END
009000001222     C                   ENDDO
009100020524     C                   IF        SRECNO1 = *ZEROS
009200020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009300020524     C                   EVAL      SUBNAM  = 'NOT FOUND'
009400020524     C                   WRITE     SFL_REC1
009500020524     C                   END
009600020515     C                   EVAL      SCREEN = 'DSPSFL  '
009700020524     C                   END
009800020515    *
009900001222     C                   ENDSR
010000020515      *? ***************************************************************
010100020515     C     DSPSFL_SR     BEGSR
010200020515    ?C                   WRITE     CMD_LINE1
010300020515    ?C                   EXFMT     SFL_CTL1
010400020618     C                   EVAL      SCREEN = 'READC   '
010500020715     C                   IF        F1_BACK = *ON
010600020715     C                   EVAL      STATUS = 'F1 '
010700020715     C                   EVAL      SCREEN = 'EXIT    '
010800020715     C                   END
010900020715     C                   IF        F7_EXIT_PGM = *ON
011000020715     C                   EVAL      STATUS = 'F7 '
011100020715     C                   EVAL      SCREEN = 'EXIT    '
011200020715     C                   END
011300020515
011400020515     C                   ENDSR
011500020515
011600020618      *? ***************************************************************
011700020618     C     READC_SR      BEGSR
011800030327     C                   DOU       %EOF
011900020618     C                   READC     SFL_REC1
012000020618     C                   IF        NOT %EOF AND
012100020618     C                             SELECT = 'X'
012200020619    ?C                   EVAL      SCREEN = 'SCRN1   '
012300030327     C                   LEAVESR
012400020618     C                   END
012500030327     C                   ENDDO
012600030327     C                   EVAL      SCREEN = 'INITSFL '
012700020618
012800020618     C                   ENDSR
012900020618      *? ***************************************************************
013000020619     C     SCRN1_SR      BEGSR
013100020618     C     *NOKEY        CLEAR     *ALL          TRSMSR
013200020619     C     TRST_HD       CHAIN     TRSMSR
013300020618     C     *NOKEY        CLEAR     *ALL          SUBMSR
013400020619     C     SUBMST2KEY    CHAIN     SUBMSR
013500020618
013600020618     C                   EVAL      CANCELED_80 = *OFF
013700020618    1C                   IF        SBDLTD <> 'A'
013800020618     C                   EVAL      CANCELED_80 = *ON
013900020618    1C                   END
014000020618     C
014100020618    ?C                   EXFMT     SCRN1
014200020717     C                   EVAL      SCREEN = 'INITSFL '
014300020618     C                   IF        F7_EXIT_PGM = *ON
014400020618     C                   EVAL      SCREEN = 'EXIT    '
014500020715     C                   EVAL      STATUS = 'F7 '
014600020618     C                   END
014700020618
014800020618     C                   ENDSR
014900020515      *? ***************************************************************
015000020515     C     EXIT_SR       BEGSR
015100020715     C     *LOCK         IN        AREA
015200020715     C                   MOVE      STATUS        STAT_E
015300020715     C                   OUT       AREA
015400020515     C                   EVAL      *INLR = *ON
015500020515     C                   RETURN
015600020515     C                   ENDSR
015700020515      *? ***************************************************************
015800020515     C     *INZSR        BEGSR
015900020515     C     *DTAARA       DEFINE    FI060A        AREA
016000020715     C     *LOCK         IN        AREA
016100020619     C                   MOVE      TRST_E        TRST_HD
016200020619     C                   MOVE      SUB#_E        SUB#_HD
016300020715     C                   MOVE      STAT_E        STATUS
016400020715     C                   OUT       AREA
016500020619     C     SUBMST_KEY    KLIST
016600020619     C                   KFLD                    TRST_HD
016700020619     C                   KFLD                    SUB#_HD
016800020619     C     SUBMST2KEY    KLIST
016900020619     C                   KFLD                    TRST_HD
017000020618     C                   KFLD                    SUB#_H
017100020517    *
017200020517     C                   IF        APPL_E = 'F.'
017300020517     C                   EVAL      W_APPL = 'FULL'
017400020517     C                   ELSE
017500020517     C                   EVAL      W_APPL = 'SELF'
017600020517     C                   END
017700020515    *
017800020515     C                   EVAL      SCREEN = 'INITSFL '
017900020515     C                   ENDSR
