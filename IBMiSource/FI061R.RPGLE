000100020515      *-------------------------------------------------------------------------
000200020528      * FI061R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020515      *            DATE - 05/15/02
000500020528      *  DESCRIPTION - DISPLAY COMMISSION
000501081217      * 12/17/08 dlk - add primary broker
000600020515      *? ***************************************************************
000700020528     FFI061D    CF   E             WORKSTN
000800020515     F                                     SFILE(SFL_REC1:SRECNO1)
000900020515     F                                      INDDS(INDICATORS)
001000020528     FCMCT14    IF   E           K DISK
001100020528     FSMAN      IF   E           K DISK
001200020528     FPLNMST    IF   E           K DISK
001300020528     FTRSMST    IF   E           K DISK
001400020528     FSUBMST    IF   E           K DISK
001500020528     FACCMST    IF   E           K DISK
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
003901081217     D                 DS
003902081217     D  free5                  1      5
003903081217     D  cmprib                 1      1
004000020515     D                UDS
004100020517     D  APPL_E                 1      2
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
005200020517     C                   WHEN      SCREEN = 'READC   '
005300020517     C                   EXSR      READC_SR
005400020528     C                   WHEN      SCREEN = 'SCRN2   '
005500020528     C                   EXSR      SCRN2_SR
005600020520     C                   WHEN      SCREEN = 'EXIT    '
005700020520     C                   EXSR      EXIT_SR
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
007400020528     C     COMCXR_KEY    SETLL     COMCXR
007500020528     C                   DOU       %EOF(CMCT14)
007600020528     C     COMCXR_KEY    READE     COMCXR
007700020528     C                   IF        NOT %EOF(CMCT14)
007800020528     C                   EXSR      GET_INFO_SR
007900020528
008000020521     C                   EVAL      SELECT  = *BLANKS
008100020521     C                   EVAL      SRECNO1 = SRECNO1 + 1
008200020528     C                   IF        SRECNO1 > 9997
008300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008400020528     C                   EVAL      SFSLNM  = 'CANNOT DISPLAY ALL RECORDS'
008500020524     C                   WRITE     SFL_REC1
008600020524     C                   LEAVE
008700020528     C                   END
008800020517     C                   WRITE     SFL_REC1
008900020528     C                   END
009000020528     C                   ENDDO
009100020524     C                   IF        SRECNO1 = *ZEROS
009200020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009300020528     C                   EVAL      SFSLNM  = 'NOT FOUND'
009400020524     C                   WRITE     SFL_REC1
009500020524     C                   END
009600020517
009700020517     C                   EVAL      SCREEN = 'DSPSFL  '
009800020515    *
009900001222     C                   ENDSR
010000020517      *? ***************************************************************
010100020517     C     DSPSFL_SR     BEGSR
010200020517    ?C                   WRITE     CMD_LINE1
010300020517    ?C                   EXFMT     SFL_CTL1
010400020520
010500020715     C                   IF        F1_CANCEL = *ON
010600020520     C                   EVAL      SCREEN = 'EXIT    '
010700020715     C                   EVAL      STATUS = 'F1 '
010800020520     C                   LEAVESR
010900020520     C                   END
011000020715     C                   IF        F7_EXIT_PGM = *ON
011100020715     C                   EVAL      STATUS = 'F7 '
011200020715     C                   EVAL      SCREEN = 'EXIT    '
011300020715     C                   LEAVESR
011400020715     C                   END
011500020517     C                   EVAL      SCREEN = 'READC   '
011600020517
011700020517     C                   ENDSR
011800020517      *? ***************************************************************
011900020517     C     READC_SR      BEGSR
012000030327     C                   DOU       %EOF
012100020517     C                   READC     SFL_REC1
012200020521     C                   IF        NOT %EOF AND
012300020521     C                             SELECT = 'X'
012400020528    ?C                   EVAL      SCREEN = 'SCRN2   '
012500020517     C                   LEAVESR
012600020521     C                   END
012700030327     C                   ENDDO
012800020521
012900020717     C                   EVAL      SCREEN = 'INITSFL '
013000020517
013100020517     C                   ENDSR
013200020517
013300020517      *? ***************************************************************
013400020528     C     SCRN2_SR      BEGSR
013500020528    ?C                   EXFMT     SCRN2
013600020528
013700020528     C                   IF        F7_EXIT_PGM = *ON
013800020528     C                   EVAL      SCREEN = 'EXIT    '
013900020715     C                   EVAL      STATUS = 'F7 '
014000020528     C                   LEAVESR
014100020528     C                   END
014200020717     C                   EVAL      SCREEN = 'INITSFL '
014300020515
014400020515     C                   ENDSR
014500020528      *? ***************************************************************
014600020528     C     GET_INFO_SR   BEGSR
014700020528     C                   MOVE      *BLANKS       SELECT
014800020528     C     *NOKEY        CLEAR     *ALL          SMANR
014900020528     C     SLSMAN        CHAIN(N)  SMANR
015000020528     C                   MOVE      *BLANKS       SFSLNM
015100020528     C                   IF        %FOUND(SMAN)
015200020528     C                   MOVEL(P)  SLNAME        SFSLNM
015300020528     C                   CAT       ',':0         SFSLNM
015400020528     C                   CAT       SFNAME:1      SFSLNM
015500020528     C                   END
015600020528     C     *NOKEY        CLEAR     *ALL          PLNMSR
015700020528     C     PLNMST_KEY    CHAIN(N)  PLNMSR
015800020528     C                   MOVE      *BLANKS       SFPDES
015900020528     C                   IF        %FOUND(PLNMST)
016000020528     C                   MOVEL(P)  PDESCR        SFPDES
016100020528     C                   END
016200020528
016300020528     C                   EVAL      SFEFDT = *ZEROS
016400020528     C                   IF        EFFDAT   <> *ZEROS
016500020528     C     *ISO          MOVEL     EFFDAT        USA_DATE
016600020528     C                   MOVEL     USA_DATE      SFEFDT
016700020528     C                   END
016800020528
016900020528     C                   EVAL      SFCNDT = *ZEROS
017000020528     C                   IF        CMCAN    <> *ZEROS
017100020528     C     *ISO          MOVEL     CMCAN         USA_DATE
017200020528     C                   MOVEL     USA_DATE      SFCNDT
017300020528     C                   END
017301081217
017302081217     c                   move      cmprib        sfprib
017400020528     C                   ENDSR
017500020515      *? ***************************************************************
017600020515     C     EXIT_SR       BEGSR
017700020715     C     *LOCK         IN        AREA
017800020715     C                   MOVE      STATUS        STAT_E
017900020715     C                   OUT       AREA
018000020515     C                   EVAL      *INLR = *ON
018100020515     C                   RETURN
018200020515     C                   ENDSR
018300020515      *? ***************************************************************
018400020515     C     *INZSR        BEGSR
018500020528     C     PLNMST_KEY    KLIST
018600020524     C                   KFLD                    TRST_N
018700020524     C                   KFLD                    SUB#_N
018800020528     C                   KFLD                    CMPLAN
018900020528
019000020517     C     ACCMST_KEY    KLIST
019100020524     C                   KFLD                    TRST_N
019200020524     C                   KFLD                    SUB#_N
019300020528     C                   KFLD                    ACCT_N
019400020528
019500020517     C     SUBMST_KEY    KLIST
019600020524     C                   KFLD                    TRST_N
019700020524     C                   KFLD                    SUB#_N
019800020528
019900020528     C     COMCXR_KEY    KLIST
020000020528     C                   KFLD                    TRST_N
020100020528     C                   KFLD                    SUB#_N
020200020528     C                   KFLD                    ACCT_N
020300020528
020400020528     C     COMCXR2KEY    KLIST
020500020528     C                   KFLD                    TRST_N
020600020528     C                   KFLD                    SUB#_N
020700020528     C                   KFLD                    ACCT_N
020800020528     C                   KFLD                    CMPLAN
020900020524
021000020515     C     *DTAARA       DEFINE    FI060A        AREA
021100020715     C     *LOCK         IN        AREA
021200020524     C                   MOVE      TRST_E        TRST_N
021300020524     C                   MOVE      SUB#_E        SUB#_N
021400020528     C                   MOVE      ACCT_E        ACCT_N
021500020715     C                   MOVE      STAT_E        STATUS
021600020715     C                   OUT       AREA
021700020524     C     *NOKEY        CLEAR     *ALL          TRSMSR
021800020524     C     TRST_N        CHAIN     TRSMSR
021900020524     C     *NOKEY        CLEAR     *ALL          SUBMSR
022000020524     C     SUBMST_KEY    CHAIN     SUBMSR
022100020524     C     *NOKEY        CLEAR     *ALL          ACCMSR
022200020524     C     ACCMST_KEY    CHAIN     ACCMSR
022300020524     C                   IF        ACDLTD =  'A'
022400020524     C                   EVAL      CANCELED_80 = *OFF
022500020524     C                   ELSE
022600020524     C                   EVAL      CANCELED_80 = *ON
022700020524     C                   END
022800020517    *
022900020517     C                   IF        APPL_E = 'F.'
023000020517     C                   EVAL      W_APPL = 'FULL'
023100020517     C                   ELSE
023200020517     C                   EVAL      W_APPL = 'SELF'
023300020517     C                   END
023400020515    *
023500020515     C                   EVAL      SCREEN = 'INITSFL '
023600020515     C                   ENDSR
