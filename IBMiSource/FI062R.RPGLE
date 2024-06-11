000100020515      *-------------------------------------------------------------------------
000200020517      * FI062R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020619      *  DESCRIPTION - DISPLAY PRIMARY PLANS
000600020515      *? ***************************************************************
000700020517     FFI062D    CF   E             WORKSTN
000800020515     F                                     SFILE(SFL_REC1:SRECNO1)
000900020517     F                                     SFILE(SFL_REC2:SRECNO2)
001000020515     F                                      INDDS(INDICATORS)
001100020517     FAPLNP     IF   E           K DISK
001200020517     FTRSMST    IF   E           K DISK
001300020517     FSUBMST    IF   E           K DISK
001400020517     FACCMST    IF   E           K DISK
001500020517     FPLNMST    IF   E           K DISK
001600020515   X*
001700020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001800020517     D SRECNO2         S              4  0 INZ(*ZEROS)
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
002900020515
003000020515     D                 DS
003100020515     D AREA                         100
003200020517     D  TRST_E                        3    OVERLAY(AREA)
003300020517     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003400020517     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003500020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003600020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003700020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003800020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003900020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
004000020515     D                UDS
004100020517     D  APPL_E                 1      2
004200020517     D  CONAME               201    240
004300020520   X*
004400020820
004500020820     D APLN_EDS      E DS                  EXTNAME(APLNP)
004600020820     D ACP_A                  15     94    DIM(20) INZ(*ZEROS)
004700020515    *
004800020515      *? ***************************************************************
004900020515     C                   SELECT
005000020515     C                   WHEN      SCREEN = 'INITSFL '
005100020515     C                   EXSR      INITSFL_SR
005200020515     C                   WHEN      SCREEN = 'BLDSFL  '
005300020515     C                   EXSR      BLDSFL_SR
005400020515     C                   WHEN      SCREEN = 'DSPSFL  '
005500020515     C                   EXSR      DSPSFL_SR
005600020517     C                   WHEN      SCREEN = 'READC   '
005700020517     C                   EXSR      READC_SR
005800020517     C                   WHEN      SCREEN = 'INITSFL2'
005900020517     C                   EXSR      INITSFL2SR
006000020517     C                   WHEN      SCREEN = 'BLDSFL2 '
006100020517     C                   EXSR      BLDSFL2SR
006200020517     C                   WHEN      SCREEN = 'DSPSFL2 '
006300020517     C                   EXSR      DSPSFL2SR
006400020520     C                   WHEN      SCREEN = 'EXIT    '
006500020520     C                   EXSR      EXIT_SR
006600020515     C                   OTHER
006700020515     C                   EXSR      EXIT_SR
006800020515     C                   ENDSL
006900020515   S*
007000020515      *? ***************************************************************
007100020515     C     INITSFL_SR    BEGSR
007200020515     C                   EVAL      SRECNO1 = *ZEROS
007300020515     C                   EVAL      RECNUM  = 1
007400020515     C                   EVAL      SFLDSP_11  = *ON
007500020515    ?C                   WRITE     SFL_CTL1
007600020515     C                   EVAL      SFLDSP_11  = *OFF
007700020515     C                   EVAL      SFLEND_22  = *ON
007800020515     C                   EVAL      SCREEN = 'BLDSFL  '
007900020515     C                   ENDSR
008000020515      *? ***************************************************************
008100020515     C     BLDSFL_SR     BEGSR
008200020517     C     APLNP_KEY     SETLL     APLNPR
008300020517     C                   DOU       %EOF(APLNP)
008400020524     C     APLNP_KEY     READE     APLNPR
008500020517     C                   IF        NOT %EOF(APLNP)
008600020517     C     *NOKEY        CLEAR     *ALL          PLNMSR
008700020517     C     PLNMST_KEY    CHAIN     PLNMSR
008800020524     C                   MOVE      APACT         ACCT_H
008900020524     C                   MOVE      APPLN         PLAN_H
009000020521     C                   EVAL      SELECT  = *BLANKS
009100020521     C                   EVAL      SRECNO1 = SRECNO1 + 1
009200020524     C                   IF        SRECNO1 > 9997
009300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009400020524     C                   EVAL      PDESCR  = 'CANNOT DISPLAY ALL RECORDS'
009500020524     C                   WRITE     SFL_REC1
009600020524     C                   LEAVE
009700020524     C                   END
009800020517     C                   WRITE     SFL_REC1
009900020517     C                   END
010000020517     C                   ENDDO
010100020524     C                   IF        SRECNO1 = *ZEROS
010200020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
010300020524     C                   EVAL      PDESCR  = 'NOT FOUND'
010400020524     C                   WRITE     SFL_REC1
010500020524     C                   END
010600020517
010700020517     C                   EVAL      SCREEN = 'DSPSFL  '
010800020515    *
010900001222     C                   ENDSR
011000020517      *? ***************************************************************
011100020517     C     DSPSFL_SR     BEGSR
011200020517    ?C                   WRITE     CMD_LINE1
011300020517    ?C                   EXFMT     SFL_CTL1
011400020520
011500020715     C                   IF        F1_CANCEL = *ON
011600020520     C                   EVAL      SCREEN = 'EXIT    '
011700020715     C                   EVAL      STATUS = 'F1 '
011800020520     C                   LEAVESR
011900020520     C                   END
012000020715     C                   IF        F7_EXIT_PGM = *ON
012100020715     C                   EVAL      STATUS = 'F7 '
012200020715     C                   EVAL      SCREEN = 'EXIT    '
012300020715     C                   LEAVESR
012400020715     C                   END
012500020517     C                   EVAL      SCREEN = 'READC   '
012600020517
012700020517     C                   ENDSR
012800020517      *? ***************************************************************
012900020517     C     READC_SR      BEGSR
013000030327     C                   DOU       %EOF
013100020517     C                   READC     SFL_REC1
013200020521     C                   IF        NOT %EOF AND
013300020521     C                             SELECT = 'X'
013400020520    ?C                   EVAL      SCREEN = 'INITSFL2'
013500020517     C                   LEAVESR
013600020521     C                   END
013700030327     C                   ENDDO
013800020521
013900020717     C                   EVAL      SCREEN = 'INITSFL '
014000020517
014100020517     C                   ENDSR
014200020517
014300020517      *? ***************************************************************
014400020517     C     INITSFL2SR    BEGSR
014500020517     C                   EVAL      SRECNO2 = *ZEROS
014600020517     C                   EVAL      RECNUM2 = 1
014700020517     C                   EVAL      SFLDSP_11  = *ON
014800020517    ?C                   WRITE     SFL_CTL2
014900020517     C                   EVAL      SFLDSP_11  = *OFF
015000020517     C                   EVAL      SFLEND_22  = *ON
015100020517     C                   EVAL      SCREEN = 'BLDSFL2 '
015200020517     C                   ENDSR
015300020517      *? ***************************************************************
015400020517     C     BLDSFL2SR     BEGSR
015500020520     C     APLNP2KEY     CHAIN     APLNPR
015600020524     C     *NOKEY        CLEAR     *ALL          ACCMSR
015700020524     C     ACCMST2KEY    CHAIN     ACCMSR
015800020520     C                   IF        ACDLTD   =  'A'
015900020520     C                   EVAL      CANCELED_80 = *OFF
016000020520     C                   ELSE
016100020520     C                   EVAL      CANCELED_80 = *ON
016200020520     C                   END
016300020524     C     PLNMST2KEY    CHAIN     PLNMSR
016400020521     C                   EVAL      W_PDESCR = PDESCR
016500020524     C                   EVAL      PLTRST = 794
016600020524     C                   EVAL      PLSUB# = 1
016700020520     C                   DO        20            INDEX
016800020524     C                   EVAL      APPLN  = ACP_A(INDEX)
016900020524     C     PLNMST3KEY    CHAIN     PLNMSR
017000020524     C                   IF        %FOUND(PLNMST)
017100020520     C                   EVAL      SRECNO2 = SRECNO2 + 1
017200020524     C                   IF        SRECNO2 > 9997
017300020524     C                   EVAL      SRECNO2 = SRECNO2 + 1
017400020524     C                   EVAL      PDESCR  = 'CANNOT DISPLAY ALL RECORDS'
017500020524     C                   WRITE     SFL_REC2
017600020524     C                   LEAVE
017700020524     C                   END
017800020520     C                   WRITE     SFL_REC2
017900020524     C                   END
018000020520     C                   ENDDO
018100020524     C                   IF        SRECNO2 = *ZEROS
018200020524     C                   EVAL      SRECNO2 = SRECNO2 + 1
018300020524     C                   EVAL      PDESCR     = 'NOT FOUND'
018400020524     C                   WRITE     SFL_REC2
018500020524     C                   END
018600020517
018700020717     C                   EVAL      SCREEN = 'DSPSFL2 '
018800020517    *
018900020517     C                   ENDSR
019000020515      *? ***************************************************************
019100020517     C     DSPSFL2SR     BEGSR
019200020517    ?C                   WRITE     CMD_LINE2
019300020517    ?C                   EXFMT     SFL_CTL2
019400020520     C                   IF        F7_EXIT_PGM = *ON
019500020520     C                   EVAL      SCREEN = 'EXIT    '
019600020715     C                   EVAL      STATUS = 'F7 '
019700020520     C                   LEAVESR
019800020520     C                   END
019900020717     C                   EVAL      SCREEN = 'INITSFL '
020000020515
020100020515     C                   ENDSR
020200020515      *? ***************************************************************
020300020515     C     EXIT_SR       BEGSR
020400020715     C     *LOCK         IN        AREA
020500020715     C                   MOVE      STATUS        STAT_E
020600020715     C                   OUT       AREA
020700020515     C                   EVAL      *INLR = *ON
020800020515     C                   RETURN
020900020515     C                   ENDSR
021000020515      *? ***************************************************************
021100020515     C     *INZSR        BEGSR
021200020517     C     APLNP_KEY     KLIST
021300020524     C                   KFLD                    TRST_N
021400030401     C                   KFLD                    SUB_N
021500020524     C                   KFLD                    ACT_N
021600020520     C     APLNP2KEY     KLIST
021700020524     C                   KFLD                    TRST_N
021800030401     C                   KFLD                    SUB_N
021900020520     C                   KFLD                    ACCT_H
022000020520     C                   KFLD                    PLAN_H
022100020517     C     PLNMST_KEY    KLIST
022200020524     C                   KFLD                    TRST_N
022300030401     C                   KFLD                    SUB_N
022400020524     C                   KFLD                    APPLN
022500020524     C     PLNMST2KEY    KLIST
022600020524     C                   KFLD                    TRST_N
022700030401     C                   KFLD                    SUB_N
022800020524     C                   KFLD                    PLAN_H
022900020524     C     PLNMST3KEY    KLIST
023000020524     C                   KFLD                    PLTRST
023100020524     C                   KFLD                    PLSUB#
023200020524     C                   KFLD                    APPLN
023300020517     C     ACCMST_KEY    KLIST
023400020524     C                   KFLD                    TRST_N
023500030401     C                   KFLD                    SUB_N
023600020524     C                   KFLD                    ACT_N
023700020520     C     ACCMST2KEY    KLIST
023800020524     C                   KFLD                    TRST_N
023900030401     C                   KFLD                    SUB_N
024000020520     C                   KFLD                    ACCT_H
024100020517     C     SUBMST_KEY    KLIST
024200020524     C                   KFLD                    TRST_N
024300030401     C                   KFLD                    SUB_N
024400020524
024500020515     C     *DTAARA       DEFINE    FI060A        AREA
024600020715     C     *LOCK         IN        AREA
024700020524     C                   MOVE      TRST_E        TRST_N
024800030401     C                   MOVE      SUB#_E        SUB_N
024900020524     C                   MOVE      ACCT_E        ACT_N
025000020715     C                   MOVE      STAT_E        STATUS
025100020715     C                   OUT       AREA
025200020524     C     *NOKEY        CLEAR     *ALL          TRSMSR
025300020524     C     TRST_N        CHAIN     TRSMSR
025400020524     C     *NOKEY        CLEAR     *ALL          SUBMSR
025500020524     C     SUBMST_KEY    CHAIN     SUBMSR
025600020524     C     *NOKEY        CLEAR     *ALL          ACCMSR
025700020524     C     ACCMST_KEY    CHAIN     ACCMSR
025800020524     C                   IF        ACDLTD =  'A'
025900020524     C                   EVAL      CANCELED_80 = *OFF
026000020524     C                   ELSE
026100020524     C                   EVAL      CANCELED_80 = *ON
026200020524     C                   END
026300020517    *
026400020517     C                   IF        APPL_E = 'F.'
026500020517     C                   EVAL      W_APPL = 'FULL'
026600020517     C                   ELSE
026700020517     C                   EVAL      W_APPL = 'SELF'
026800020517     C                   END
026900020515    *
027000020515     C                   EVAL      SCREEN = 'INITSFL '
027100020515     C                   ENDSR
