000100020515      *-------------------------------------------------------------------------
000200020515      * FI006R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020515      *  DESCRIPTION - DISPLAY TRUST RECORDS FROM TRUST MASTER FILE
000600020515      *? ***************************************************************
000700020515     FTRSMST    IF   E           K DISK
000800020716     FCOBRAAA   IF   E           K DISK
000900020716     FAACODE    IF   E           K DISK
001000020618     FCODES     IF   E           K DISK
001100020515     FFI006D    CF   E             WORKSTN
001200020515     F                                     SFILE(SFL_REC1:SRECNO1)
001300020515     F                                      INDDS(INDICATORS)
001400020515   X*
001500020618     D USA_DATE        S               D   DATFMT(*USA)
001600020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001700020515     D SCREEN          S              8
001800020619     D TRST_HD         S                   LIKE(TRTRST)
001900020715     D STATUS          S              3
002000020515
0021000205150030 D INDICATORS      DS            99
0022000206180019 D  F1_BACK               01     01N   INZ('0')
0023000206180019 D  F7_EXIT_PGM           07     07N   INZ('0')
002400020515     D  SFLDSP_11             11     11N   INZ('0')
002500020515     D  SFLEND_22             22     22N   INZ('0')
002600020618     D  CANCELED_80           80     80N   INZ('0')
002700020618
002800020618     D                 DS
002900020618     D TSCODE
003000020618     D  TYPE_DS                       1    OVERLAY(TSCODE)
003100020716     D  CODE_DS                            OVERLAY(TSCODE:*NEXT)
003200020515
003300020515     D                 DS
003400020515     D AREA                         100
003500020517     D  TRST_E                        3    OVERLAY(AREA)
003600020517     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003700020517     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003800020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003900020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
004000020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
004100020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
004200020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
004300020515     D                UDS
004400020517     D  APPL_E                 1      2
004500020515     D  CONAME               201    240
004600020515    *
004700020515      *? ***************************************************************
004800020515     C                   SELECT
004900020515     C                   WHEN      SCREEN = 'INITSFL '
005000020515     C                   EXSR      INITSFL_SR
005100020515     C                   WHEN      SCREEN = 'BLDSFL  '
005200020515     C                   EXSR      BLDSFL_SR
005300020515     C                   WHEN      SCREEN = 'DSPSFL  '
005400020515     C                   EXSR      DSPSFL_SR
005500020618     C                   WHEN      SCREEN = 'READC   '
005600020618     C                   EXSR      READC_SR
005700020619     C                   WHEN      SCREEN = 'SCRN1   '
005800020619     C                   EXSR      SCRN1_SR
005900020515     C                   WHEN      SCREEN = 'EXIT    '
006000020515     C                   EXSR      EXIT_SR
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
007700020619     C     TRST_HD       SETLL     TRSMSR
007800020515     C                   DOU       %EOF(TRSMST)
007900020516     C                   READ      TRSMSR
008000020515     C                   IF        NOT %EOF(TRSMST)
008100020618     C                   EVAL      TRST_H  = TRTRST
008200020618     C                   EVAL      SRECNO1 = SRECNO1 + 1
008300020716     C                   EVAL      SELECT  = *BLANKS
008400020524     C                   IF        SRECNO1 > 9997
008500020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008600020524     C                   EVAL      TNAME   = 'CANNOT DISPLAY ALL RECORDS'
008700020524     C                   WRITE     SFL_REC1
008800020524     C                   LEAVE
008900020524     C                   END
009000020515     C                   WRITE     SFL_REC1
009100020515     C                   END
009200001222     C                   ENDDO
009300020524     C                   IF        SRECNO1 = *ZEROS
009400020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009500020524     C                   EVAL      TNAME   = 'NOT FOUND'
009600020524     C                   WRITE     SFL_REC1
009700020524     C                   END
009800020515     C                   EVAL      SCREEN = 'DSPSFL  '
009900020515    *
010000001222     C                   ENDSR
010100020515      *? ***************************************************************
010200020515     C     DSPSFL_SR     BEGSR
010300020515    ?C                   WRITE     CMD_LINE1
010400020515    ?C                   EXFMT     SFL_CTL1
010500020618     C                   EVAL      SCREEN = 'READC   '
010600020715     C                   IF        F1_BACK = *ON
010700020715     C                   EVAL      STATUS = 'F1 '
010800020618     C                   EVAL      SCREEN = 'EXIT    '
010900020618     C                   END
011000020715     C                   IF        F7_EXIT_PGM = *ON
011100020715     C                   EVAL      STATUS = 'F7 '
011200020715     C                   EVAL      SCREEN = 'EXIT    '
011300020715     C                   END
011400020515
011500020515     C                   ENDSR
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
013200020618     C     TRST_H        CHAIN     TRSMSR
013300020618     C     *NOKEY        CLEAR     *ALL          CODESR
013400020618     C     CODES_KEY     CHAIN     CODESR
013500020716     C     *NOKEY        CLEAR     *ALL          COBRAR
013600020716     C     TRST_H        CHAIN     COBRAR
013700020716     C     *NOKEY        CLEAR     *ALL          AACODR
013800020716     C     CACODE        CHAIN     AACODR
013900020618
014000020618     C                   EVAL      CANCELED_80 = *OFF
014100020618    1C                   IF        TRDLTD <> 'A'
014200020618     C                   EVAL      CANCELED_80 = *ON
014300020618    1C                   END
014400020618     C                   IF        CONTDT <> *ZEROS
014500020618     C     *ISO          MOVE      CONTDT        USA_DATE
014600020618     C                   MOVE      USA_DATE      CONTDT
014700020618     C                   END
014800020618     C
014900020618    ?C                   EXFMT     SCRN1
015000020717     C                   EVAL      SCREEN = 'INITSFL '
015100020715     C                   IF        F7_EXIT_PGM = *ON
015200020715     C                   EVAL      STATUS = 'F7 '
015300020715     C                   EVAL      SCREEN = 'EXIT    '
015400020715     C                   END
015500020618
015600020618     C                   ENDSR
015700020515
015800020515      *? ***************************************************************
015900020515     C     EXIT_SR       BEGSR
016000020715     C     *LOCK         IN        AREA
016100020715     C                   MOVE      STATUS        STAT_E
016200020715     C                   OUT       AREA
016300020515     C                   EVAL      *INLR = *ON
016400020515     C                   RETURN
016500020515     C                   ENDSR
016600020515      *? ***************************************************************
016700020515     C     *INZSR        BEGSR
016800020618     C     CODES_KEY     KLIST
016900020618     C                   KFLD                    TYPE_DS
017000020618     C                   KFLD                    CODE_DS
017100020515     C     *DTAARA       DEFINE    FI060A        AREA
017200020715     C     *LOCK         IN        AREA
017300020715     C                   MOVE      TRST_E        TRST_HD
017400020715     C                   MOVE      STAT_E        STATUS
017500020715     C                   OUT       AREA
017600020517    *
017700020517     C                   IF        APPL_E = 'F.'
017800020517     C                   EVAL      W_APPL = 'FULL'
017900020517     C                   ELSE
018000020517     C                   EVAL      W_APPL = 'SELF'
018100020517     C                   END
018200020515    *
018300020515     C                   EVAL      SCREEN = 'INITSFL '
018400020515     C                   ENDSR
