000100020515      *-------------------------------------------------------------------------
000200020716      * FI120R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020716      *            DATE - 07/16/02
000500020716      *  DESCRIPTION - AGENCY INQUIRY
000600020515      *? ***************************************************************
000700020716     FFI120D    CF   E             WORKSTN
000800020716     F                                     SFILE(SFL_REC1:SRECNO1)
000900020716     F                                      INDDS(INDICATORS)
001000020716     FAGENCY    IF   E           K DISK
001100020515   X*
001200020619     D USA_DATE        S               D   DATFMT(*USA)
001300020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001400020515     D SCREEN          S              8
001500020715     D STATUS          S              3
001600020515
0017000205150030 D INDICATORS      DS            99
0018000206190019 D  F1_BACK               01     01N   INZ('0')
0019000206190019 D  F7_EXIT_PGM           07     07N   INZ('0')
002000020515     D  SFLDSP_11             11     11N   INZ('0')
002100020515     D  SFLEND_22             22     22N   INZ('0')
002200020515
002300020515     D                 DS
002400020515     D AREA                         100
002500020515     D  TRST_E                        3    OVERLAY(AREA)
002600020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
002700020516     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
002800020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
002900020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003000020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003100020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003200020716     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003300020716
003400020716     D                UDS
003500020716     D  APPL_E                 1      2
003600020716     D  CONAME               201    240
003700020515    *
003800020515      *? ***************************************************************
003900020515     C                   SELECT
004000020515     C                   WHEN      SCREEN = 'INITSFL '
004100020515     C                   EXSR      INITSFL_SR
004200020515     C                   WHEN      SCREEN = 'BLDSFL  '
004300020515     C                   EXSR      BLDSFL_SR
004400020515     C                   WHEN      SCREEN = 'DSPSFL  '
004500020515     C                   EXSR      DSPSFL_SR
004600020619     C                   WHEN      SCREEN = 'READC   '
004700020619     C                   EXSR      READC_SR
004800020619     C                   WHEN      SCREEN = 'SCRN1   '
004900020619     C                   EXSR      SCRN1_SR
005000020515     C                   WHEN      SCREEN = 'EXIT    '
005100020515     C                   EXSR      EXIT_SR
005200020515     C                   OTHER
005300020515     C                   EXSR      EXIT_SR
005400020515     C                   ENDSL
005500020515   S*
005600020515      *? ***************************************************************
005700020515     C     INITSFL_SR    BEGSR
005800020515     C                   EVAL      SRECNO1 = *ZEROS
005900020515     C                   EVAL      RECNUM  = 1
006000020515     C                   EVAL      SFLDSP_11  = *ON
006100020515    ?C                   WRITE     SFL_CTL1
006200020515     C                   EVAL      SFLDSP_11  = *OFF
006300020515     C                   EVAL      SFLEND_22  = *ON
006400020515     C                   EVAL      SCREEN = 'BLDSFL  '
006500020515     C                   ENDSR
006600020515      *? ***************************************************************
006700020515     C     BLDSFL_SR     BEGSR
006800020716     C     AGCODE        SETLL     AGENR
006900020716     C                   DOU       %EOF(AGENCY)
007000020716     C                   READ      AGENR
007100020716     C                   IF        NOT %EOF(AGENCY)
007200020716     C                   EVAL      AGCODE_H = AGCODE
007300020716     C                   EVAL      SELECT   = *BLANKS
007400020619     C                   EVAL      SRECNO1 = SRECNO1 + 1
007500020524     C                   IF        SRECNO1 > 9997
007600020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
007700020716     C                   EVAL      AGNAM1   = 'CANNOT DISPLAY ALL RECORDS'
007800020524     C                   WRITE     SFL_REC1
007900020524     C                   LEAVE
008000020524     C                   END
008100020515     C                   WRITE     SFL_REC1
008200020515     C                   END
008300001222     C                   ENDDO
008400020524     C                   IF        SRECNO1 = *ZEROS
008500020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008600020716     C                   EVAL      AGNAM1   = 'NOT FOUND'
008700020524     C                   WRITE     SFL_REC1
008800020524     C                   END
008900020515     C                   EVAL      SCREEN = 'DSPSFL  '
009000020515    *
009100001222     C                   ENDSR
009200020515      *? ***************************************************************
009300020515     C     DSPSFL_SR     BEGSR
009400020515    ?C                   WRITE     CMD_LINE1
009500020515    ?C                   EXFMT     SFL_CTL1
009600020619     C                   EVAL      SCREEN = 'READC   '
009700020715     C                   IF        F1_BACK = *ON
009800020715     C                   EVAL      STATUS = 'F1 '
009900020715     C                   EVAL      SCREEN = 'EXIT    '
010000020715     C                   END
010100020715     C                   IF        F7_EXIT_PGM = *ON
010200020715     C                   EVAL      STATUS = 'F7 '
010300020715     C                   EVAL      SCREEN = 'EXIT    '
010400020715     C                   END
010500020515
010600020515     C                   ENDSR
010700020515
010800020619      *? ***************************************************************
010900020619     C     READC_SR      BEGSR
011000030327     C                   DOU       %EOF
011100020619     C                   READC     SFL_REC1
011200020619     C                   IF        NOT %EOF AND
011300020619     C                             SELECT = 'X'
011400020619    ?C                   EVAL      SCREEN = 'SCRN1   '
011500030327     C                   LEAVESR
011600020619     C                   END
011700030327     C                   ENDDO
011800020619
011900030327     C                   EVAL      SCREEN = 'INITSFL '
012000020619     C                   ENDSR
012100020619      *? ***************************************************************
012200020619     C     SCRN1_SR      BEGSR
012300020619
012400020716     C     *NOKEY        CLEAR     *ALL          AGENR
012500020716     C     AGCODE_H      CHAIN     AGENR
012600020716     C                   IF        AGEFDT <> *ZEROS
012700020716     C     *ISO          MOVE      AGEFDT        USA_DATE
012800020716     C                   MOVE      USA_DATE      AGEFDT
012900020619     C                   END
013000020716     C                   IF        AGTMDT <> *ZEROS
013100020716     C     *ISO          MOVE      AGTMDT        USA_DATE
013200020716     C                   MOVE      USA_DATE      AGTMDT
013300020716     C                   END
013400020619     C
013500020619    ?C                   EXFMT     SCRN1
013600020619     C                   IF        F1_BACK     = *ON
013700020717     C                   EVAL      SCREEN = 'INITSFL '
013800020715     C                   EVAL      STATUS = 'F1 '
013900020619     C                   END
014000020619     C                   IF        F7_EXIT_PGM = *ON
014100020619     C                   EVAL      SCREEN = 'EXIT    '
014200020715     C                   EVAL      STATUS = 'F7 '
014300020619     C                   END
014400020619
014500020619     C                   ENDSR
014600020515      *? ***************************************************************
014700020515     C     EXIT_SR       BEGSR
014800020715     C     *LOCK         IN        AREA
014900020715     C                   MOVE      STATUS        STAT_E
015000020715     C                   OUT       AREA
015100020515     C                   EVAL      *INLR = *ON
015200020515     C                   RETURN
015300020515     C                   ENDSR
015400020515      *? ***************************************************************
015500020515     C     *INZSR        BEGSR
015600020515     C     *DTAARA       DEFINE    FI060A        AREA
015700020715     C     *LOCK         IN        AREA
015800020716     C                   MOVE      AGEN_E        AGCODE
015900020715     C                   MOVE      STAT_E        STATUS
016000020715     C                   OUT       AREA
016100020517    *
016200020517     C                   IF        APPL_E = 'F.'
016300020517     C                   EVAL      W_APPL = 'FULL'
016400020517     C                   ELSE
016500020517     C                   EVAL      W_APPL = 'SELF'
016600020517     C                   END
016700020515    *
016800020515     C                   EVAL      SCREEN = 'INITSFL '
016900020515     C                   ENDSR
