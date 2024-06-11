000100020515      *-------------------------------------------------------------------------
000200020516      * FI005R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020516      *  DESCRIPTION - DISPLAY MARKET SIZE
000600020515      *? ***************************************************************
000700020516     FCARMKSZ4  IF   E           K DISK
000800020516     FCARMST    IF   E           K DISK
000900020516     FFI005D    CF   E             WORKSTN
001000020515     F                                     SFILE(SFL_REC1:SRECNO1)
001100020515     F                                      INDDS(INDICATORS)
001200020515   X*
001300020516     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001400020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001500020515     D SCREEN          S              8
001600020715     D STATUS          S              3
001700020524
001800020524     D                 DS
001900020524     D AREA                         100
002000020524     D  TRST_E                        3    OVERLAY(AREA)
002100020524     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
002200020524     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
002300020524     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
002400020524     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
002500020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
002600020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
002700020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
002800020515
0029000205150030 D INDICATORS      DS            99
0030000207150019 D  F1_BACK               01     01N   INZ('0')
0031000207150019 D  F7_EXIT_PGM           07     07N   INZ('0')
003200020515     D  SFLDSP_11             11     11N   INZ('0')
003300020515     D  SFLEND_22             22     22N   INZ('0')
003400020516
0035000205160030 D                 DS
0036000205160019 D CNAME
003700020516     D  CARNAM                             OVERLAY(CNAME)
003800020517     D                UDS
003900020517     D  APPL_E                 1      2
004000020517     D  CONAME               201    240
004100020515    *
004200020515      *? ***************************************************************
004300020515     C                   SELECT
004400020515     C                   WHEN      SCREEN = 'INITSFL '
004500020515     C                   EXSR      INITSFL_SR
004600020515     C                   WHEN      SCREEN = 'BLDSFL  '
004700020515     C                   EXSR      BLDSFL_SR
004800020515     C                   WHEN      SCREEN = 'DSPSFL  '
004900020515     C                   EXSR      DSPSFL_SR
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
006800020524     C                   IF        CARR_E = *ZEROS
006900020524     C                   EVAL      CARR_E = *BLANKS
007000020524     C                   END
007100020524     C     CARR_E        SETLL     RCARMKSZ
007200020516     C                   DOU       %EOF(CARMKSZ4)
007300020516     C                   READ      RCARMKSZ
007400020516     C                   IF        NOT %EOF(CARMKSZ4)
007500020516     C     *NOKEY        CLEAR     *ALL          CARMSR
007600020516     C     CZCARR        CHAIN(N)  CARMSR
007700020516     C                   IF        CZFRDT <> *ZEROS
007800020516     C     *ISO          MOVEL     CZFRDT        USA_DATE
007900020516     C                   MOVEL     USA_DATE      CZFRDT
008000020516     C                   END
008100020516     C                   IF        CZTODT <> *ZEROS
008200020516     C     *ISO          MOVEL     CZTODT        USA_DATE
008300020516     C                   MOVEL     USA_DATE      CZTODT
008400020516     C                   END
008500020515     C                   EVAL      SRECNO1 = SRECNO1 + 1
008600020524     C                   IF        SRECNO1 > 9997
008700020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008800020524     C                   EVAL      CARNAM  = 'CANNOT DISPLAY ALL RECORDS'
008900020524     C                   WRITE     SFL_REC1
009000020524     C                   LEAVE
009100020524     C                   END
009200020515     C                   WRITE     SFL_REC1
009300020515     C                   END
009400001222     C                   ENDDO
009500020524     C                   IF        SRECNO1 = *ZEROS
009600020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009700020524     C                   EVAL      CARNAM  = 'NOT FOUND'
009800020524     C                   WRITE     SFL_REC1
009900020524     C                   END
010000020515     C                   EVAL      SCREEN = 'DSPSFL  '
010100020515    *
010200001222     C                   ENDSR
010300020515      *? ***************************************************************
010400020515     C     DSPSFL_SR     BEGSR
010500020515    ?C                   WRITE     CMD_LINE1
010600020515    ?C                   EXFMT     SFL_CTL1
010700020515     C                   EVAL      SCREEN = 'EXIT    '
010800020715
010900020715     C                   IF        F1_BACK        = *ON
011000020715     C                   EVAL      SCREEN = 'EXIT    '
011100020715     C                   EVAL      STATUS = 'F1 '
011200020715     C                   LEAVESR
011300020715     C                   END
011400020715
011500020715     C                   IF        F7_EXIT_PGM    = *ON
011600020715     C                   EVAL      SCREEN = 'EXIT    '
011700020715     C                   EVAL      STATUS = 'F7 '
011800020715     C                   LEAVESR
011900020715     C                   END
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
013300020524     C     *DTAARA       DEFINE    FI060A        AREA
013400020715     C     *LOCK         IN        AREA
013500020715     C                   MOVE      STAT_E        STATUS
013600020715     C                   OUT       AREA
013700020517    *
013800020517     C                   IF        APPL_E = 'F.'
013900020517     C                   EVAL      W_APPL = 'FULL'
014000020517     C                   ELSE
014100020517     C                   EVAL      W_APPL = 'SELF'
014200020517     C                   END
014300020515    *
014400020515     C                   EVAL      SCREEN = 'INITSFL '
014500020515     C                   ENDSR
