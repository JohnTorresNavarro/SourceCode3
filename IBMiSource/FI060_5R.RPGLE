000100020515      *-------------------------------------------------------------------------
000200020520      * FI060_5R   INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020520      *  DESCRIPTION - DISPLAY COST CTR
000600020515      *? ***************************************************************
000700020520     FFI060_5D  CF   E             WORKSTN
000800020520     F                                     SFILE(SFL_REC1:SRECNO1)
000900020520     F                                      INDDS(INDICATORS)
001000020520     FCOSTCTRP  IF   E           K DISK
001100020520     FTRSMST    IF   E           K DISK
001200020520     FACCMST    IF   E           K DISK
001300020520     FSUBMST    IF   E           K DISK
001400020520     FCODES     IF   E           K DISK
001500020515   X*
001600020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001700020515     D SCREEN          S              8
001800020715     D STATUS          S              3
001900020515
0020000205150030 D INDICATORS      DS            99
0021000206190019 D  F1_BACK               01     01N   INZ('0')
0022000206190019 D  F7_EXIT_PGM           07     07N   INZ('0')
002300020515     D  SFLDSP_11             11     11N   INZ('0')
002400020515     D  SFLEND_22             22     22N   INZ('0')
0025000205240019 D CANCELED_80            80     80N   INZ('0')
002600020515
002700020717     D                 DS
002800020717     D CCCODE
002900020717     D   TYPE                         1    OVERLAY(CCCODE)
003000020717     D   CODE2                        2    OVERLAY(CCCODE:2)
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
004100020520
004200020515     D                UDS
004300020619     D  CCAPPL                 1      1
004400020517     D  CONAME               201    240
004500020515    *
004600020515      *? ***************************************************************
004700020515     C                   SELECT
004800020515     C                   WHEN      SCREEN = 'INITSFL '
004900020515     C                   EXSR      INITSFL_SR
005000020515     C                   WHEN      SCREEN = 'BLDSFL  '
005100020515     C                   EXSR      BLDSFL_SR
005200020515     C                   WHEN      SCREEN = 'DSPSFL  '
005300020515     C                   EXSR      DSPSFL_SR
005400020515     C                   WHEN      SCREEN = 'EXIT    '
005500020515     C                   EXSR      EXIT_SR
005600020515     C                   OTHER
005700020515     C                   EXSR      EXIT_SR
005800020515     C                   ENDSL
005900020515   S*
006000020515      *? ***************************************************************
006100020515     C     INITSFL_SR    BEGSR
006200020515     C                   EVAL      SRECNO1 = *ZEROS
006300020515     C                   EVAL      RECNUM  = 1
006400020515     C                   EVAL      SFLDSP_11  = *ON
006500020515    ?C                   WRITE     SFL_CTL1
006600020515     C                   EVAL      SFLDSP_11  = *OFF
006700020515     C                   EVAL      SFLEND_22  = *ON
006800020515     C                   EVAL      SCREEN = 'BLDSFL  '
006900020515     C                   ENDSR
007000020515      *? ***************************************************************
007100020515     C     BLDSFL_SR     BEGSR
007200020517
007300020520     C     COSTCTR_KEY   SETLL     COSTCTRR
007400020520     C                   DOU       %EOF(COSTCTRP)
007500020524     C     COSTCTR_KEY   READE     COSTCTRR
007600020520     C                   IF        NOT %EOF(COSTCTRP)
007700020515     C                   EVAL      SRECNO1 = SRECNO1 + 1
007800020524     C                   IF        SRECNO1 > 9997
007900020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008000020524     C                   EVAL      LDESCR  = 'CANNOT DISPLAY ALL RECORDS'
008100020524     C                   WRITE     SFL_REC1
008200020524     C                   LEAVE
008300020524     C                   END
008400020524     C     *NOKEY        CLEAR     *ALL          CODESR
008500020524     C     CODES_KEY     CHAIN     CODESR
008600020515     C                   WRITE     SFL_REC1
008700020515     C                   END
008800001222     C                   ENDDO
008900020524     C                   IF        SRECNO1 = *ZEROS
009000020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009100020524     C                   EVAL      LDESCR  = 'NOT FOUND'
009200020524     C                   WRITE     SFL_REC1
009300020524     C                   END
009400020515     C                   EVAL      SCREEN = 'DSPSFL  '
009500020515    *
009600001222     C                   ENDSR
009700020515      *? ***************************************************************
009800020515     C     DSPSFL_SR     BEGSR
009900020516     C                   IF        SRECNO1 = *ZEROS
010000020516     C                   EVAL      SRECNO1 = SRECNO1 + 1
010100020520     C                   EVAL      LDESCR   = 'NOT FOUND'
010200020516     C                   WRITE     SFL_REC1
010300020516     C                   END
010400020515    ?C                   WRITE     CMD_LINE1
010500020515    ?C                   EXFMT     SFL_CTL1
010600020515     C                   EVAL      SCREEN = 'EXIT    '
010700020716     C                   IF        F1_BACK = *ON
010800020716     C                   EVAL      STATUS = 'F1 '
010900020716     C                   EVAL      SCREEN = 'EXIT    '
011000020716     C                   END
011100020716     C                   IF        F7_EXIT_PGM = *ON
011200020716     C                   EVAL      STATUS = 'F7 '
011300020716     C                   EVAL      SCREEN = 'EXIT    '
011400020716     C                   END
011500020515
011600020515     C                   ENDSR
011700020515
011800020515      *? ***************************************************************
011900020515     C     EXIT_SR       BEGSR
012000020715     C     *LOCK         IN        AREA
012100020715     C                   MOVE      STATUS        STAT_E
012200020715     C                   OUT       AREA
012300020515     C                   EVAL      *INLR = *ON
012400020515     C                   RETURN
012500020515     C                   ENDSR
012600020515      *? ***************************************************************
012700020515     C     *INZSR        BEGSR
012800020515     C     *DTAARA       DEFINE    FI060A        AREA
012900020715     C     *LOCK         IN        AREA
013000020524     C                   MOVE      TRST_E        TRST_N
013100020524     C                   MOVE      SUB#_E        SUB#_N
013200020524     C                   MOVE      ACCT_E        ACCT_N
013300020715     C                   MOVE      STAT_E        STATUS
013400020715     C                   OUT       AREA
013500020520
013600020520     C     SUBMST_KEY    KLIST
013700020524     C                   KFLD                    TRST_N
013800020524     C                   KFLD                    SUB#_N
013900020520     C     ACCMST_KEY    KLIST
014000020524     C                   KFLD                    TRST_N
014100020524     C                   KFLD                    SUB#_N
014200020524     C                   KFLD                    ACCT_N
014300020520
014400020520     C     COSTCTR_KEY   KLIST
014500020520     C                   KFLD                    CCAPPL
014600020524     C                   KFLD                    TRST_N
014700020524     C                   KFLD                    SUB#_N
014800020524     C                   KFLD                    ACCT_N
014900020520
015000020520     C     CODES_KEY     KLIST
015100020520     C                   KFLD                    TYPE
015200020520     C                   KFLD                    CODE2
015300020520
015400020524     C     TRST_N        CHAIN(N)  TRSMSR
015500020520     C     ACCMST_KEY    CHAIN(N)  ACCMSR
015600020619     C                   EVAL      CANCELED_80 = *OFF
015700020520     C                   IF        ACDLTD     = 'C'
015800020524     C                   EVAL      CANCELED_80 = *ON
015900020520     C                   END
016000020520
016100020520     C     SUBMST_KEY    CHAIN(N)  SUBMSR
016200020517    *
016300020619     C                   IF        CCAPPL   = 'F'
016400020619     C                   EVAL      W_APPL = 'FULL'
016500020517     C                   ELSE
016600020619     C                   EVAL      W_APPL = 'SELF'
016700020517     C                   END
016800020515    *
016900020515     C                   EVAL      SCREEN = 'INITSFL '
017000020515     C                   ENDSR
