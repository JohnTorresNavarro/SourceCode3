000100020515      *-------------------------------------------------------------------------
000200020516      * FI005R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020516      *  DESCRIPTION - DISPLAY MARKET SIZE
000600020515      *? ***************************************************************
000700020716     FCARMST    IF   E           K DISK
000800030410     FFI080D2   CF   E             WORKSTN
000900020515     F                                     SFILE(SFL_REC1:SRECNO1)
001000020515     F                                      INDDS(INDICATORS)
001100020515   X*
001200020516     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001300020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001400020515     D SCREEN          S              8
001500020715     D STATUS          S              3
001600020524
001700020524     D                 DS
001800020524     D AREA                         100
001900020524     D  TRST_E                        3    OVERLAY(AREA)
002000020524     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
002100020524     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
002200020524     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
002300020524     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
002400020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
002500020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
002600020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
002700020515
0028000205150030 D INDICATORS      DS            99
0029000207150019 D  F1_BACK               01     01N   INZ('0')
0030000207150019 D  F7_EXIT_PGM           07     07N   INZ('0')
003100020515     D  SFLDSP_11             11     11N   INZ('0')
003200020515     D  SFLEND_22             22     22N   INZ('0')
003300020516
003400020716     D                 DS
003500020716     D  CZIP
003600020716     D  CZIP5                              OVERLAY(CZIP)
003700020716     D  CZIP4                              OVERLAY(CZIP:*NEXT)
003800020716
003900020716     D                UDS
004000020716     D  APPL_E                 1      2
004100020716     D  CONAME               201    240
004200020515    *
004300020515      *? ***************************************************************
004400020515     C                   SELECT
004500020515     C                   WHEN      SCREEN = 'INITSFL '
004600020515     C                   EXSR      INITSFL_SR
004700020515     C                   WHEN      SCREEN = 'BLDSFL  '
004800020515     C                   EXSR      BLDSFL_SR
004900020515     C                   WHEN      SCREEN = 'DSPSFL  '
005000020515     C                   EXSR      DSPSFL_SR
005100020716     C                   WHEN      SCREEN = 'READC   '
005200020716     C                   EXSR      READC_SR
005300020716     C                   WHEN      SCREEN = 'SCRN1   '
005400020716     C                   EXSR      SCRN1_SR
005500020515     C                   WHEN      SCREEN = 'EXIT    '
005600020515     C                   EXSR      EXIT_SR
005700020515     C                   OTHER
005800020515     C                   EXSR      EXIT_SR
005900020515     C                   ENDSL
006000020515   S*
006100020515      *? ***************************************************************
006200020515     C     INITSFL_SR    BEGSR
006300020515     C                   EVAL      SRECNO1 = *ZEROS
006400020515     C                   EVAL      RECNUM  = 1
006500020515     C                   EVAL      SFLDSP_11  = *ON
006600020515    ?C                   WRITE     SFL_CTL1
006700020515     C                   EVAL      SFLDSP_11  = *OFF
006800020515     C                   EVAL      SFLEND_22  = *ON
006900020515     C                   EVAL      SCREEN = 'BLDSFL  '
007000020515     C                   ENDSR
007100020515      *? ***************************************************************
007200020515     C     BLDSFL_SR     BEGSR
007300020716     C                   IF        CARRCD = *ZEROS
007400020716     C                   EVAL      CARRCD = *BLANKS
007500020524     C                   END
007600020716     C     CARRCD        SETLL     CARMSR
007700020716     C                   DOU       %EOF(CARMST)
007800020716     C                   READ      CARMSR
007900020716     C                   IF        NOT %EOF(CARMST)
008000020515     C                   EVAL      SRECNO1 = SRECNO1 + 1
008100020716     C                   EVAL      SELECT  = *BLANKS
008200020716     C                   EVAL      CARRCD_H = CARRCD
008300020524     C                   IF        SRECNO1 > 9997
008400020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008500020716     C                   EVAL      CNAME   = 'CANNOT DISPLAY ALL RECORDS'
008600020524     C                   WRITE     SFL_REC1
008700020524     C                   LEAVE
008800020524     C                   END
008900020515     C                   WRITE     SFL_REC1
009000020515     C                   END
009100001222     C                   ENDDO
009200020524     C                   IF        SRECNO1 = *ZEROS
009300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009400020716     C                   EVAL      CNAME   = 'NOT FOUND'
009500020524     C                   WRITE     SFL_REC1
009600020524     C                   END
009700020515     C                   EVAL      SCREEN = 'DSPSFL  '
009800020515    *
009900001222     C                   ENDSR
010000020515      *? ***************************************************************
010100020515     C     DSPSFL_SR     BEGSR
010200020515    ?C                   WRITE     CMD_LINE1
010300020515    ?C                   EXFMT     SFL_CTL1
010400020716     C                   EVAL      SCREEN = 'READC   '
010500020715
010600020715     C                   IF        F1_BACK        = *ON
010700020715     C                   EVAL      SCREEN = 'EXIT    '
010800020715     C                   EVAL      STATUS = 'F1 '
010900020715     C                   LEAVESR
011000020715     C                   END
011100020715
011200020715     C                   IF        F7_EXIT_PGM    = *ON
011300020715     C                   EVAL      SCREEN = 'EXIT    '
011400020715     C                   EVAL      STATUS = 'F7 '
011500020715     C                   LEAVESR
011600020715     C                   END
011700020515
011800020515     C                   ENDSR
011900020716      *? ***************************************************************
012000020716     C     READC_SR      BEGSR
012100030327     C                   DOU       %EOF
012200030327     C                   READC     SFL_REC1
012300020716     C                   IF        NOT %EOF AND
012400020716     C                             SELECT = 'X'
012500020716    ?C                   EVAL      SCREEN = 'SCRN1   '
012600030327     C                   LEAVESR
012700020716     C                   END
012800030327     C                   ENDDO
012900030327     C                   EVAL      SCREEN = 'INITSFL '
013000020716
013100020716     C                   ENDSR
013200020716      *? ***************************************************************
013300020716     C     SCRN1_SR      BEGSR
013400020716     C     *NOKEY        CLEAR     *ALL          CARMSR
013500020716     C     CARRCD_H      CHAIN     CARMSR
013600020716
013700020716    ?C                   EXFMT     SCRN1
013800020717     C                   EVAL      SCREEN = 'INITSFL '
013900020716     C                   IF        F7_EXIT_PGM = *ON
014000020716     C                   EVAL      STATUS = 'F7 '
014100020716     C                   EVAL      SCREEN = 'EXIT    '
014200020716     C                   END
014300020716
014400020716     C                   ENDSR
014500020515
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
015600020524     C     *DTAARA       DEFINE    FI060A        AREA
015700020715     C     *LOCK         IN        AREA
015800020716     C                   MOVE      CARR_E        CARRCD
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
