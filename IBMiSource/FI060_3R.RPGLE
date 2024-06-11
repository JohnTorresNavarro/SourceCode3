000100020515      *-------------------------------------------------------------------------
000200020523      * FI060_3R   INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020618      *  DESCRIPTION - DISPLAY CARRIER/IDENTIFIER
000600020515      *? ***************************************************************
000700020517     FFI060_3D  CF   E             WORKSTN
000800020517     F                                     SFILE(SFL_REC1:SRECNO1)
000900020517     F                                      INDDS(INDICATORS)
001000020517     FCARACCXP  IF   E           K DISK
001100020517     FTRSMST    IF   E           K DISK
001200020517     FACCMST    IF   E           K DISK    PREFIX(A_)
001300020517     FSUBMST    IF   E           K DISK    PREFIX(S_)
001400020517     FCARMST    IF   E           K DISK
001500020618     FPRRULE    IF   E           K DISK
001600020515   X*
001700020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001800020515     D SCREEN          S              8
001900020619     D CARR_HD         S                   LIKE(CACARRIER)
002000020715     D STATUS          S              3
002100020515
0022000205150030 D INDICATORS      DS            99
0023000206180019 D  F1_BACK               01     01N   INZ('0')
0024000206180019 D  F7_EXIT_PGM           07     07N   INZ('0')
002500020515     D  SFLDSP_11             11     11N   INZ('0')
002600020515     D  SFLEND_22             22     22N   INZ('0')
002700020517     D  CANCELED_80           80     80N   INZ('0')
002800020515
002900020515     D                 DS
003000020515     D AREA                         100
003100020517     D  TRST_E                        3    OVERLAY(AREA)
003200020517     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003300020517     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003400020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003500020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003600020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003700020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003800020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003900020515     D                UDS
004000020517     D  APPL                   1      2
004100020619     D  CAAPPL                 1      1
004200020517     D  CONAME               201    240
004300020515    *
004400020515      *? ***************************************************************
004500020515     C                   SELECT
004600020515     C                   WHEN      SCREEN = 'INITSFL '
004700020515     C                   EXSR      INITSFL_SR
004800020515     C                   WHEN      SCREEN = 'BLDSFL  '
004900020515     C                   EXSR      BLDSFL_SR
005000020515     C                   WHEN      SCREEN = 'DSPSFL  '
005100020515     C                   EXSR      DSPSFL_SR
005200020618     C                   WHEN      SCREEN = 'READC   '
005300020618     C                   EXSR      READC_SR
005400020618     C                   WHEN      SCREEN = 'SCRN60_3'
005500020618     C                   EXSR      SCRN60_3_SR
005600020515     C                   WHEN      SCREEN = 'EXIT    '
005700020515     C                   EXSR      EXIT_SR
005800020515     C                   OTHER
005900020515     C                   EXSR      EXIT_SR
006000020515     C                   ENDSL
006100020515   S*
006200020515      *? ***************************************************************
006300020515     C     INITSFL_SR    BEGSR
006400020515     C                   EVAL      SRECNO1 = *ZEROS
006500020515     C                   EVAL      RECNUM  = 1
006600020515     C                   EVAL      SFLDSP_11  = *ON
006700020515    ?C                   WRITE     SFL_CTL1
006800020515     C                   EVAL      SFLDSP_11  = *OFF
006900020515     C                   EVAL      SFLEND_22  = *ON
007000020515     C                   EVAL      SCREEN = 'BLDSFL  '
007100020515     C                   ENDSR
007200020515      *? ***************************************************************
007300020515     C     BLDSFL_SR     BEGSR
007400020517     C     *NOKEY        CLEAR     *ALL          TRSMSR
007500020619     C     TRST_HD       CHAIN     TRSMSR
007600020517     C     *NOKEY        CLEAR     *ALL          SUBMSR
007700020517     C     SUBMST_KEY    CHAIN     SUBMSR
007800020517     C     *NOKEY        CLEAR     *ALL          ACCMSR
007900020517     C     ACCMST_KEY    CHAIN     ACCMSR
008000020619     C                   EVAL      CANCELED_80 = *OFF
008100020517     C                   IF        A_ACDLTD <> 'A'
008200020517     C                   EVAL      CANCELED_80 = *ON
008300020517     C                   END
008400020524     C     CARACCX_KEY   SETLL     CARACCXR
008500020517     C                   DOU       %EOF(CARACCXP)
008600020717     C     CARACCX_KEY   READE     CARACCXR
008700020517     C                   IF        NOT %EOF(CARACCXP)
008800020517     C     *NOKEY        CLEAR     *ALL          CARMSR
008900020517     C     CACARRIER     CHAIN     CARMSR
009000020619     C                   EVAL      CARR_H    = CACARRIER
009100020618     C                   EVAL      SRECNO1 = SRECNO1 + 1
009200020716     C                   EVAL      SELECT  = *BLANKS
009300020524     C                   IF        SRECNO1 > 9997
009400020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009500020524     C                   EVAL      CAHANDLING = 'CANNOT DISPLAY ALL RECORDS'
009600020524     C                   WRITE     SFL_REC1
009700020524     C                   LEAVE
009800020524     C                   END
009900020517     C                   WRITE     SFL_REC1
010000020517     C                   END
010100020517     C                   ENDDO
010200020524     C                   IF        SRECNO1 = *ZEROS
010300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
010400020524     C                   EVAL      CAHANDLING = 'NOT FOUND'
010500020524     C                   WRITE     SFL_REC1
010600020524     C                   END
010700020515     C                   EVAL      SCREEN = 'DSPSFL  '
010800020515    *
010900001222     C                   ENDSR
011000020515      *? ***************************************************************
011100020515     C     DSPSFL_SR     BEGSR
011200020515    ?C                   WRITE     CMD_LINE1
011300020515    ?C                   EXFMT     SFL_CTL1
011400020618     C                   EVAL      SCREEN = 'READC   '
011500020715     C                   IF        F1_BACK = *ON
011600020715     C                   EVAL      STATUS = 'F1 '
011700020618     C                   EVAL      SCREEN = 'EXIT    '
011800020618     C                   END
011900020715     C                   IF        F7_EXIT_PGM = *ON
012000020715     C                   EVAL      STATUS = 'F7 '
012100020715     C                   EVAL      SCREEN = 'EXIT    '
012200020715     C                   END
012300020515
012400020515     C                   ENDSR
012500020618      *? ***************************************************************
012600020618     C     READC_SR      BEGSR
012700030327     C                   DOU       %EOF
012800020618     C                   READC     SFL_REC1
012900020618     C                   IF        NOT %EOF AND
013000020618     C                             SELECT = 'X'
013100020618    ?C                   EVAL      SCREEN = 'SCRN60_3'
013200020618     C                   LEAVESR
013300020618     C                   END
013400030327     C                   ENDDO
013500020618
013600020717     C                   EVAL      SCREEN = 'INITSFL '
013700020618
013800020618     C                   ENDSR
013900020618      *? ***************************************************************
014000020618     C     SCRN60_3_SR   BEGSR
014100020618     C     *NOKEY        CLEAR     *ALL          PRRULR
014200020619     C     CPRRUL_H      CHAIN     PRRULR
014300020618     C     *NOKEY        CLEAR     *ALL          CARMSR
014400020619     C     CARR_H        CHAIN     CARMSR
014500020618     C
014600020618    ?C                   EXFMT     SCRN60_3
014700020717     C                   EVAL      SCREEN = 'INITSFL '
014800020618     C                   IF        F7_EXIT_PGM = *ON
014900020618     C                   EVAL      SCREEN = 'EXIT    '
015000020715     C                   EVAL      STATUS = 'F7 '
015100020618     C                   END
015200020618
015300020618     C                   ENDSR
015400020515
015500020515      *? ***************************************************************
015600020515     C     EXIT_SR       BEGSR
015700020715     C     *LOCK         IN        AREA
015800020715     C                   MOVE      STATUS        STAT_E
015900020715     C                   OUT       AREA
016000020515     C                   EVAL      *INLR = *ON
016100020515     C                   RETURN
016200020515     C                   ENDSR
016300020515      *? ***************************************************************
016400020515     C     *INZSR        BEGSR
016500020515     C     *DTAARA       DEFINE    FI060A        AREA
016600020715     C     *LOCK         IN        AREA
016700020619     C                   MOVE      TRST_E        TRST_HD
016800020619     C                   MOVE      SUB#_E        SUB#_HD
016900020619     C                   MOVE      ACCT_E        ACCT_HD
017000020619     C                   MOVE      CARR_E        CARR_HD
017100020715     C                   MOVE      STAT_E        STATUS
017200020715     C                   OUT       AREA
017300020517
017400020517     C     SUBMST_KEY    KLIST
017500020619     C                   KFLD                    TRST_HD
017600020619     C                   KFLD                    SUB#_HD
017700020517     C     ACCMST_KEY    KLIST
017800020619     C                   KFLD                    TRST_HD
017900020619     C                   KFLD                    SUB#_HD
018000020619     C                   KFLD                    ACCT_HD
018100020517
018200020517     C     CARACCX_KEY   KLIST
018300020517     C                   KFLD                    CAAPPL
018400020619     C                   KFLD                    TRST_HD
018500020619     C                   KFLD                    SUB#_HD
018600020619     C                   KFLD                    ACCT_HD
018700020619
018800020619     C     CARACCX2KEY   KLIST
018900020619     C                   KFLD                    CAAPPL
019000020619     C                   KFLD                    TRST_HD
019100020619     C                   KFLD                    SUB#_HD
019200020619     C                   KFLD                    ACCT_HD
019300020619     C                   KFLD                    CARR_H
019400020515    *
019500020517     C                   IF        APPL = 'F.'
019600020517     C                   EVAL      W_APPL = 'FULL'
019700020517     C                   ELSE
019800020517     C                   EVAL      W_APPL = 'SELF'
019900020517     C                   END
020000020515     C                   EVAL      SCREEN = 'INITSFL '
020100020515     C                   ENDSR
