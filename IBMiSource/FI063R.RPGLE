000100020515      *-------------------------------------------------------------------------
000200030327      * FI063R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500030327      *  DESCRIPTION - MKT SIZE
000501050308      *
000502050308      * 03/08/05 dlk - fix date display in subfile
000600020515      *? ***************************************************************
000700020528     FFI063D    CF   E             WORKSTN
000800020515     F                                     SFILE(SFL_REC1:SRECNO1)
000900020515     F                                      INDDS(INDICATORS)
001000020717     FMKTCARA1  IF   E           K DISK
001100020517     FTRSMST    IF   E           K DISK
001200020517     FSUBMST    IF   E           K DISK
001300020517     FACCMST    IF   E           K DISK
001400020528     FCARMST    IF   E           K DISK
001500020528     FCARMKSZ3  IF   E           K DISK
001600020515   X*
001700020528     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001800020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001900020520     D INDEX           S              4  0 INZ(*ZEROS)
002000020515     D SCREEN          S              8
002100020715     D STATUS          S              3
002200020515
0023000205150030 D INDICATORS      DS            99
0024000205200019 D  F1_CANCEL             01     01N   INZ('0')
0025000205200019 D  F7_EXIT_PGM           07     07N   INZ('0')
002600020515     D  SFLDSP_11             11     11N   INZ('0')
002700020515     D  SFLEND_22             22     22N   INZ('0')
002800020517     D  CANCELED_80           80     80N   INZ('0')
002900020528     D  LEAVEDO                        N   INZ('0')
003000020515
003100020515     D                 DS
003200020515     D AREA                         100
003300020517     D  TRST_E                        3    OVERLAY(AREA)
003400020517     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003500020517     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003600020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003700020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003800020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003900020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
004000020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
004100020515     D                UDS
004200020620     D  APPL_E                 1      1
004300020517     D  CONAME               201    240
004400020520   X*
004500020515      *? ***************************************************************
004600020515     C                   SELECT
004700020515     C                   WHEN      SCREEN = 'INITSFL '
004800020515     C                   EXSR      INITSFL_SR
004900020515     C                   WHEN      SCREEN = 'BLDSFL  '
005000020515     C                   EXSR      BLDSFL_SR
005100020515     C                   WHEN      SCREEN = 'DSPSFL  '
005200020515     C                   EXSR      DSPSFL_SR
005300020520     C                   WHEN      SCREEN = 'EXIT    '
005400020520     C                   EXSR      EXIT_SR
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
006800020528     C                   EVAL      MESSAGE = *BLANKS
006900020515     C                   ENDSR
007000020515      *? ***************************************************************
007100020515     C     BLDSFL_SR     BEGSR
007200020528     C     ACCMST_KEY    SETLL     RMKTCARA
007300020528    1C                   DOU       %EOF(MKTCARA1)
007400020528     C     ACCMST_KEY    READE     RMKTCARA
007500020528    2C                   IF        NOT %EOF(MKTCARA1)
007600020528     C                   EXSR      BLDSFL2_SR
007700020528     C                   IF        LEAVEDO = *ON
007800020528     C                   EVAL      LEAVEDO = *OFF
007900020528     C                   LEAVE
008000020528     C                   END
008100020528    2C                   END
008200020528    1C                   ENDDO
008300020528     C                   IF        SRECNO1 = *ZEROS
008400020528     C                   EVAL      SRECNO1 = SRECNO1 + 1
008500020528     C                   EVAL      MESSAGE = 'NOT FOUND'
008600020528     C                   WRITE     SFL_REC1
008700020528     C                   END
008800020528     C                   EVAL      SCREEN = 'DSPSFL  '
008900020528    1C                   ENDSR
009000020528      *? ***************************************************************
009100020528     C     BLDSFL2_SR    BEGSR
009200020528     C     *NOKEY        CLEAR     *ALL          ACCMSR
009300020528     C     ACCMST_KEY    CHAIN     ACCMSR
009400020528     C                   IF        %FOUND(ACCMST)
009500020528     C     *NOKEY        CLEAR     *ALL          RCARMKSZ
009600020528     C     CARKEY        CHAIN(N)  RCARMKSZ
009601050308
009602050308     c                   clear                   w_frdt
009603050308     c                   clear                   w_todt
009700020528     C                   IF        MAFRDT   <> *ZEROS
009800020528     C     *ISO          MOVEL     MAFRDT        USA_DATE
009900020528     C                   MOVEL     USA_DATE      W_FRDT
010000020528     C                   END
010100020528     C                   IF        MATODT   <> *ZEROS
010200020528     C     *ISO          MOVEL     MATODT        USA_DATE
010300020528     C                   MOVEL     USA_DATE      W_TODT
010400020528     C                   END
010500020521     C                   EVAL      SRECNO1 = SRECNO1 + 1
010600020524     C                   IF        SRECNO1 > 9997
010700020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
010800020528     C                   EVAL      MESSAGE = 'CANNOT DISPLAY ALL RECORDS'
010900020524     C                   WRITE     SFL_REC1
011000020528     C                   EVAL      LEAVEDO = *ON
011100020528     C                   LEAVESR
011200020524     C                   END
011300020517     C                   WRITE     SFL_REC1
011400020517     C                   END
011500020515    *
011600001222     C                   ENDSR
011700020517      *? ***************************************************************
011800020517     C     DSPSFL_SR     BEGSR
011900020517    ?C                   WRITE     CMD_LINE1
012000020517    ?C                   EXFMT     SFL_CTL1
012100020520
012200020715     C                   IF        F1_CANCEL = *ON
012300020520     C                   EVAL      SCREEN = 'EXIT    '
012400020715     C                   EVAL      STATUS = 'F1 '
012500020520     C                   LEAVESR
012600020520     C                   END
012700020715     C                   IF        F7_EXIT_PGM = *ON
012800020715     C                   EVAL      STATUS = 'F7 '
012900020715     C                   EVAL      SCREEN = 'EXIT    '
013000020715     C                   LEAVESR
013100020715     C                   END
013200020528     C                   EVAL      SCREEN = 'EXIT    '
013300020517
013400020517     C                   ENDSR
013500020515      *? ***************************************************************
013600020515     C     EXIT_SR       BEGSR
013700020715     C     *LOCK         IN        AREA
013800020715     C                   MOVE      STATUS        STAT_E
013900020715     C                   OUT       AREA
014000020515     C                   EVAL      *INLR = *ON
014100020515     C                   RETURN
014200020515     C                   ENDSR
014300020515      *? ***************************************************************
014400020515     C     *INZSR        BEGSR
014500020517     C     ACCMST_KEY    KLIST
014600020524     C                   KFLD                    TRST_N
014700020528     C                   KFLD                    SUB_N
014800020524     C                   KFLD                    ACT_N
014900020528
015000020528     C     SUBMST_KEY    KLIST
015100020528     C                   KFLD                    TRST_N
015200020528     C                   KFLD                    SUB_N
015300020528
015400020528     C     CARKEY        KLIST
015500020528     C                   KFLD                    MACARR
015600020528     C                   KFLD                    MASZCD
015700020524
015800020515     C     *DTAARA       DEFINE    FI060A        AREA
015900020715     C     *LOCK         IN        AREA
016000020524     C                   MOVE      TRST_E        TRST_N
016100020528     C                   MOVE      SUB#_E        SUB_N
016200020524     C                   MOVE      ACCT_E        ACT_N
016300020715     C                   MOVE      STAT_E        STATUS
016400020715     C                   OUT       AREA
016500020524     C     *NOKEY        CLEAR     *ALL          TRSMSR
016600020524     C     TRST_N        CHAIN     TRSMSR
016700020524     C     *NOKEY        CLEAR     *ALL          SUBMSR
016800020524     C     SUBMST_KEY    CHAIN     SUBMSR
016900020524     C     *NOKEY        CLEAR     *ALL          ACCMSR
017000020524     C     ACCMST_KEY    CHAIN     ACCMSR
017100020524     C                   IF        ACDLTD =  'A'
017200020524     C                   EVAL      CANCELED_80 = *OFF
017300020524     C                   ELSE
017400020524     C                   EVAL      CANCELED_80 = *ON
017500020524     C                   END
017600020517    *
017700020620     C                   IF        APPL_E = 'F'
017800020517     C                   EVAL      W_APPL = 'FULL'
017900020517     C                   ELSE
018000020517     C                   EVAL      W_APPL = 'SELF'
018100020517     C                   END
018200020515    *
018300020515     C                   EVAL      SCREEN = 'INITSFL '
018400020515     C                   ENDSR
