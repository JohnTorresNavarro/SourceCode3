000100020513    * * FI060R - ACCOUNT MASTER INQUIRY
000200020513    * *   WRITTEN
000300020513    * *           BY TPOWERS
000400020513    * *           ON 05/13/02
000500020513    *
000600020513      *? ***************************************************************
000700020513     FFI060D    CF   E             WORKSTN
000800020513     F                                      INDDS(INDICATORS)
000900020513     FACCMST    IF   E           K DISK    PREFIX(W_)
001000020513     FTRSMST    IF   E           K DISK    PREFIX(T_)
001100020513     FSUBMST    IF   E           K DISK    PREFIX(S_)
001200020513    *
001300020513     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
001400020513     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001500030326     D USA_DATE2       S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001600020513     D SCREEN          S              8
001700020513     D ACCT_NBR_E      S             10A                                        CONTROL VARIABLE
001800020515     D SCREEN_SV       S                   LIKE(SCREEN)                         CONTROL VARIABLE
001900020715     D STATUS          S              3                                         CONTROL VARIABLE
002000020513
0021000205130030 D INDICATORS      DS            99
002200020513     D  CANCEL                01     01N   INZ('0')
002300020515     D  INQUIRY               03     03N   INZ('0')
002400020513     D  EXIT_SCREEN           07     07N   INZ('0')
0025000205210019 D CANED_ACT_80           80     80N   INZ('0')
002600020513
0027000205130030 D                 DS
002800030326     D GA_DS2                        12  0 INZ(*ZEROS)
002900030326     D GA_DS                          8  0 OVERLAY(GA_DS2)
003000030427     D  W_GBSGAD                           OVERLAY(GA_DS2)
003100030326
0032000303260030 D                 DS
003300030427     D W_CFSEDT                            INZ(*ZEROS)
003400030427     D CFS_DS                         8  0 OVERLAY(W_CFSEDT)
003500030326
0036000303260030 D                 DS
003700030326     D W_AZIP                              INZ(*ZEROS)
003800030326     D W_AZIP5                             OVERLAY(W_AZIP)
003900030326     D W_AZIP4                             OVERLAY(W_AZIP:*NEXT)
004000020513
004100020513     D                 DS
004200020513     D ACCT_NBR                      10  0 INZ(*ZEROS)
004300020513     D  I_TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
004400020513     D  I_SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
004500020513     D  I_ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
004600020521
004700020521     D                 DS
004800020521     D W_ACNAM1
004900020521     D  W_ACNAM                            OVERLAY(W_ACNAM1)
005000020521
005100020515     D                UDS
005200020515     D  CONAME               201    240
005300020515
005400020515     D                 DS
005500020515     D AREA                         100
005600020515     D  TRST_E                        3    OVERLAY(AREA)
005700020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
005800020516     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
005900020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
006000020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
006100020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
006200020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
006300020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
006400020513      *? ***************************************************************
006500020513
006600020513     C                   SELECT
006700020513     C                   WHEN      SCREEN = 'SCRN1   '
006800020513     C                   EXSR      SCRN1_SR
006900020513     C                   WHEN      SCREEN = 'SCRN2   '
007000020513     C                   EXSR      SCRN2_SR
007100020513     C                   WHEN      SCREEN = 'SCRN3   '
007200020513     C                   EXSR      SCRN3_SR
007300020514     C                   WHEN      SCREEN = 'SCRN4   '
007400020514     C                   EXSR      SCRN4_SR
007500020515     C                   WHEN      SCREEN = 'INQUIRY '
007600020515     C                   EXSR      INQUIRY_SR
007700020513     C                   WHEN      SCREEN = 'EXIT    '
007800020513     C                   EXSR      EXIT_SR
007900020513     C                   OTHER
008000020513     C                   EXSR      SCRN1_SR
008100020513     C                   ENDSL
008200020513      *? ***************************************************************
008300020513     C     SCRN1_SR      BEGSR
008400020513     C                   EXFMT     SCRN1
008500020515     C                   IF        CANCEL = *ON
008600020515     C                   EVAL      SCREEN = 'EXIT    '
008700020515     C                   LEAVESR
008800020515     C                   END
008900020515     C                   IF        EXIT_SCREEN = *ON
009000020515     C                   EVAL      SCREEN = 'EXIT    '
009100020515     C                   LEAVESR
009200020515     C                   END
009300020515     C                   IF        INQUIRY = *ON
009400020515     C                   EVAL      SCREEN_SV = SCREEN
009500020515     C                   EVAL      SCREEN = 'INQUIRY '
009600020515     C                   LEAVESR
009700020515     C                   END
009800020513     C                   EVAL      SCREEN = 'SCRN2   '
009900020513     C                   ENDSR
010000020513      *? ***************************************************************
010100020513     C     SCRN2_SR      BEGSR
010200020513     C     *NOKEY        CLEAR                   TRSMSR
010300020513     C     ACCT_KEY      CHAIN     ACCMSR
010400020513     C     *NOKEY        CLEAR     *ALL          TRSMSR
010500020513     C     I_TRST        CHAIN     TRSMSR
010600020513     C     *NOKEY        CLEAR     *ALL          SUBMSR
010700020513     C     SUBM_KEY      CHAIN     SUBMSR
010800020513
010900020514     C     ACCT_KEY      SETLL     ACCMSR
011000020513     C                   IF        NOT %EQUAL(ACCMST)
011100020513???**C                   EXFMT     ACCERR
011200020513     C                   EVAL      SCREEN = 'SCRN1   '
011300020513     C                   LEAVESR
011400020513     C                   END
011500020521     C                   IF        W_ACDLTD     = 'A'
011600020521     C                   EVAL      CANED_ACT_80 = *OFF
011700020521     C                   ELSE
011800020521     C                   EVAL      CANED_ACT_80 = *ON
011900020521     C                   END
012000020515     C                   IF        W_GBSBDT <> *ZEROS
012100020513     C     *ISO          MOVEL     W_GBSBDT      USA_DATE
012200020513     C                   MOVEL     USA_DATE      W_GBSBDT
012300020515     C                   END
012400020515     C                   IF        W_ATRMDT <> *ZEROS
012500020513     C     *ISO          MOVEL     W_ATRMDT      USA_DATE
012600020513     C                   MOVEL     USA_DATE      W_ATRMDT
012700020515     C                   END
012800020515     C                   IF        W_ENROLL <> *ZEROS
012900020513     C     *ISO          MOVEL     W_ENROLL      USA_DATE
013000020513     C                   MOVEL     USA_DATE      W_ENROLL
013100020515     C                   END
013200030326     C
013300030427     C                   IF        W_GBSGAD = *ZEROS
013400030427     C                   EVAL      W_GBSGAD = *ZEROS
013500030326     C                   END
013600030326     C                   IF        GA_DS   = *ZEROS
013700030326     C                   EVAL      GADATE  = *ZEROS
013800030326     C                   ELSE
013900030326     C     *ISO          MOVE      GA_DS         USA_DATE2
014000030326     C                   MOVE      USA_DATE2     GADATE
014100030326     C                   END
014200020513     C                   EXFMT     SCRN2
014300020513     C                   IF        CANCEL = *ON
014400020513     C                   EVAL      SCREEN = 'SCRN1   '
014500020513     C                   LEAVESR
014600020513     C                   END
014700020515     C                   IF        EXIT_SCREEN = *ON
014800020515     C                   EVAL      SCREEN = 'EXIT    '
014900020515     C                   LEAVESR
015000020515     C                   END
015100020515     C                   IF        INQUIRY = *ON
015200020515     C                   EVAL      SCREEN_SV = SCREEN
015300020515     C                   EVAL      SCREEN = 'INQUIRY '
015400020515     C                   LEAVESR
015500020515     C                   END
015600020515     C                   EVAL      SCREEN = 'SCRN3   '
015700020513     C                   ENDSR
015800020513      *? ***************************************************************
015900020513     C     SCRN3_SR      BEGSR
016000030326     C
016100030427     C                   IF        W_CFSEDT = *ZEROS
016200030427     C                   EVAL      W_CFSEDT = *ZEROS
016300030326     C                   END
016400030326     C                   IF        CFS_DS    = *ZEROS
016500030326     C                   EVAL      CFSDATE = *ZEROS
016600030326     C                   ELSE
016700030326     C     *ISO          MOVE      CFS_DS        USA_DATE2
016800030326     C                   MOVE      USA_DATE2     CFSDATE
016900030326     C                   END
017000020513     C                   EXFMT     SCRN3
017100020513     C                   IF        CANCEL = *ON
017200020513     C                   EVAL      SCREEN = 'SCRN2   '
017300020513     C                   LEAVESR
017400020513     C                   END
017500020515     C                   IF        EXIT_SCREEN = *ON
017600020515     C                   EVAL      SCREEN = 'EXIT    '
017700020515     C                   LEAVESR
017800020515     C                   END
017900020515     C                   IF        INQUIRY = *ON
018000020515     C                   EVAL      SCREEN_SV = SCREEN
018100020515     C                   EVAL      SCREEN = 'INQUIRY '
018200020515     C                   LEAVESR
018300020515     C                   END
018400020514     C                   EVAL      SCREEN = 'SCRN4   '
018500020513     C                   ENDSR
018600020513      *? ***************************************************************
018700020514     C     SCRN4_SR      BEGSR
018800020716     C     *LOCK         IN        AREA
018900020716     C                   MOVE      STATUS        STAT_E
019000020716     C                   OUT       AREA
019100020716     C                   MOVE      ACCT_NBR      ACCT_NBR_E
019200020513     C                   CALL      'FI060_2R'
019300020513     C                   PARM                    ACCT_NBR_E
019400020514     C                   PARM                    SCREEN
019500020716     C     *LOCK         IN        AREA
019600020716     C                   MOVE      STAT_E        STATUS
019700020716     C                   OUT       AREA
019800020716     C                   IF        STATUS = 'F7 '
019900020716     C                   EVAL      SCREEN = 'EXIT    '
020000020716     C                   END
020100020513     C                   ENDSR
020200020515      *? ***************************************************************
020300020515     C     INQUIRY_SR    BEGSR
020400020516     C     *DTAARA       DEFINE    FI060A        AREA
020500020516     C     *LOCK         IN        AREA
020600020516     C                   MOVE      I_TRST        TRST_E
020700020516     C                   MOVE      I_SUB#        SUB#_E
020800020516     C                   MOVE      I_ACCT        ACCT_E
020900020716     C                   MOVE      STATUS        STAT_E
021000020516     C                   OUT       AREA
021100020515     C                   CALL      'FI060_1R'
021200020715     C     *LOCK         IN        AREA
021300030326     C                   MOVE      TRST_E        I_TRST
021400030326     C                   MOVE      SUB#_E        I_SUB#
021500030326     C                   MOVE      ACCT_E        I_ACCT
021600020715     C                   MOVE      STAT_E        STATUS
021700020715     C                   OUT       AREA
021800020715     C                   EVAL      SCREEN    = SCREEN_SV
021900020715     C                   IF        STATUS = 'F7 '
022000020715     C                   EVAL      SCREEN = 'EXIT    '
022100020715     C                   END
022200020515     C                   ENDSR
022300020513      *? ***************************************************************
022400020513     C     EXIT_SR       BEGSR
022500020513     C                   EVAL      *INLR = *ON
022600020513     C                   RETURN
022700020513     C                   ENDSR
022800020513
022900020513      *? ***************************************************************
023000020513     C     *INZSR        BEGSR
023100020513     C                   EVAL      SCREEN = 'SCRN1   '
023200030326
023300020513     C     ACCT_KEY      KLIST
023400020513     C                   KFLD                    I_TRST
023500020513     C                   KFLD                    I_SUB#
023600020513     C                   KFLD                    I_ACCT
023700020513     C     SUBM_KEY      KLIST
023800020513     C                   KFLD                    I_TRST
023900020513     C                   KFLD                    I_SUB#
024000020513
024100020513     C                   ENDSR
