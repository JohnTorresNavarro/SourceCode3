000100020515      *-------------------------------------------------------------------------
000200020516      * FI008R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020516      *  DESCRIPTION - DISPLAY ACCT  RECORDS
000600020515      *? ***************************************************************
000700020516     FACCMST    IF   E           K DISK
000800020516     FFI008D    CF   E             WORKSTN
000900020515     F                                     SFILE(SFL_REC1:SRECNO1)
001000020515     F                                      INDDS(INDICATORS)
001100020515   X*
001200030326     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001300020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001400020515     D SCREEN          S              8
001500020619     D ACCT_HD         S                   LIKE(ACACCT)
001600020715     D STATUS          S              3
001700020515
0018000205150030 D INDICATORS      DS            99
0019000206190019 D  F1_BACK               01     01N   INZ('0')
0020000206190019 D  F7_EXIT_PGM           07     07N   INZ('0')
002100020515     D  SFLDSP_11             11     11N   INZ('0')
002200020515     D  SFLEND_22             22     22N   INZ('0')
002300030326
002400030326     D                 DS
002500030326     D ACNAM1
002600030326     D  ACNAM134                           OVERLAY(ACNAM1)
002700030326
002800030326     D                 DS
002900030326     D ACNAM2
003000030326     D  ACNAM234                           OVERLAY(ACNAM2)
003100020515
003200020515     D                 DS
003300020515     D AREA                         100
003400020515     D  TRST_E                        3    OVERLAY(AREA)
003500020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003600020516     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003700020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003800020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003900020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
004000020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
004100020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
004200020516
004300020516     D                UDS
004400020517     D  APPL_E                 1      2
004500020619     D   A2APPL                1      1
004600020516     D  CONAME               201    240
004700020515    *
004800020515      *? ***************************************************************
004900020515     C                   SELECT
005000020515     C                   WHEN      SCREEN = 'INITSFL '
005100020515     C                   EXSR      INITSFL_SR
005200020515     C                   WHEN      SCREEN = 'BLDSFL  '
005300020515     C                   EXSR      BLDSFL_SR
005400020515     C                   WHEN      SCREEN = 'DSPSFL  '
005500020515     C                   EXSR      DSPSFL_SR
005600020619     C                   WHEN      SCREEN = 'READC   '
005700020619     C                   EXSR      READC_SR
005800020619     C                   WHEN      SCREEN = 'EXIT    '
005900020619     C                   EXSR      EXIT_SR
006000020515     C                   OTHER
006100020515     C                   EXSR      EXIT_SR
006200020515     C                   ENDSL
006300020515   S*
006400020515      *? ***************************************************************
006500020515     C     INITSFL_SR    BEGSR
006600020515     C                   EVAL      SRECNO1 = *ZEROS
006700020515     C                   EVAL      RECNUM  = 1
006800020515     C                   EVAL      SFLDSP_11  = *ON
006900020515    ?C                   WRITE     SFL_CTL1
007000020515     C                   EVAL      SFLDSP_11  = *OFF
007100020515     C                   EVAL      SFLEND_22  = *ON
007200020515     C                   EVAL      SCREEN = 'BLDSFL  '
007300020515     C                   ENDSR
007400020515      *? ***************************************************************
007500020515     C     BLDSFL_SR     BEGSR
007600020619     C                   IF        TRST_HD = *ZEROS  AND
007700020619     C                             SUB#_HD = *ZEROS
007800020524     C                   EVAL      SCREEN = 'EXIT    '
007900020524     C                   ELSE
008000020619     C     ACCMST_KEY    SETLL     ACCMSR
008100020516     C                   DOU       %EOF(ACCMST)
008200020524     C                   READ      ACCMSR
008300020516     C                   IF        NOT %EOF(ACCMST)
008400020619     C                   IF        TRST_HD = ACTRST AND
008500020619     C                             SUB#_HD = ACSUB#
008600020524     C                   ELSE
008700020524     C                   LEAVE
008800020524     C                   END
008900020619     C                   EVAL      ACCT_H  = ACACCT
009000020619     C                   EVAL      SRECNO1 = SRECNO1 + 1
009100020716     C                   EVAL      SELECT  = *BLANKS
009200020524     C                   IF        SRECNO1 > 9997
009300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009400020524     C                   EVAL      ACNAM134 = 'CANNOT DISPLAY ALL RECORDS'
009500020524     C                   WRITE     SFL_REC1
009600020524     C                   LEAVE
009700020524     C                   END
009800020515     C                   WRITE     SFL_REC1
009900020515     C                   END
010000001222     C                   ENDDO
010100020524     C                   IF        SRECNO1 = *ZEROS
010200020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
010300020524     C                   EVAL      ACNAM134 = 'NOT FOUND'
010400020524     C                   WRITE     SFL_REC1
010500020524     C                   END
010600020515     C                   EVAL      SCREEN = 'DSPSFL  '
010700020524     C                   END
010800020515    *
010900001222     C                   ENDSR
011000020515      *? ***************************************************************
011100020515     C     DSPSFL_SR     BEGSR
011200020515    ?C                   WRITE     CMD_LINE1
011300020515    ?C                   EXFMT     SFL_CTL1
011400020619     C                   EVAL      SCREEN = 'READC   '
011500020715     C                   IF        F1_BACK = *ON
011600020715     C                   EVAL      STATUS = 'F1 '
011700020619     C                   EVAL      SCREEN = 'EXIT    '
011800020619     C                   END
011900020715     C                   IF        F7_EXIT_PGM = *ON
012000020715     C                   EVAL      STATUS = 'F7 '
012100020715     C                   EVAL      SCREEN = 'EXIT    '
012200020715     C                   END
012300020515
012400020515     C                   ENDSR
012500020515
012600020619      *? ***************************************************************
012700020619     C     READC_SR      BEGSR
012800030327     C                   DOU       %EOF
012900020619     C                   READC     SFL_REC1
013000030327     C                   IF        NOT %EOF AND
013100030327     C                             SELECT = 'X'
013200030326     C                   MOVE      ACCT_H        ACCT_HD
013300030326     C                   EVAL      SCREEN = 'EXIT    '
013400030327     C                   EVAL      STATUS = '   '
013500030327     C                   LEAVESR
013600030327     C                   END
013700030327     C                   ENDDO
013800020619
013900030327     C                   EVAL      STATUS = 'F1 '
014000030327     C                   EVAL      SCREEN = 'EXIT    '
014100020619     C                   ENDSR
014200020515      *? ***************************************************************
014300020515     C     EXIT_SR       BEGSR
014400020715     C     *LOCK         IN        AREA
014500030326     C                   MOVE      TRST_HD       TRST_E
014600030326     C                   MOVE      SUB#_HD       SUB#_E
014700030326     C                   MOVE      ACCT_HD       ACCT_E
014800020715     C                   MOVE      STATUS        STAT_E
014900020715     C                   OUT       AREA
015000020515     C                   EVAL      *INLR = *ON
015100020515     C                   RETURN
015200020515     C                   ENDSR
015300020515      *? ***************************************************************
015400020515     C     *INZSR        BEGSR
015500020515     C     *DTAARA       DEFINE    FI060A        AREA
015600020715     C     *LOCK         IN        AREA
015700020619     C                   MOVE      TRST_E        TRST_HD
015800020619     C                   MOVE      SUB#_E        SUB#_HD
015900020619     C                   MOVE      ACCT_E        ACCT_HD
016000020715     C                   MOVE      STAT_E        STATUS
016100020715     C                   OUT       AREA
016200020619     C     ACCMST_KEY    KLIST
016300020619     C                   KFLD                    TRST_HD
016400020619     C                   KFLD                    SUB#_HD
016500020619     C                   KFLD                    ACCT_HD
016600020515    *
016700020515     C                   EVAL      SCREEN = 'INITSFL '
016800020515     C                   ENDSR
