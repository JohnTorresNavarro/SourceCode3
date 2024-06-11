000100010412      *? ***************************************************************
000200020513      * FM060_2R - ACCOUNT MASTER INQUIRY
000300020513      *   WRITTEN by Terry Powers  05/13/02
000400010412      *
000500020513      *? Description: display additional screen
000600010417
000700010417      *? FIELDS BEGINNING WITH W_ ARE DISPLAY FIELDS
000800020430      *? FIELDS beginning with A2 are ac2mst fields
000801051115   ** *  11/15/2005 DLK - Add invoice heading overrides
000802060120   ** *  01/20/2006 DLK - Add invoice heading override effective date
000803060202   ** *  02/02/2006 DLK - Add "Use cost center" field
000900010416      *? ***************************************************************
001000020515     FFI060_2D  CF   E             WORKSTN PREFIX(A2)
001100010412     F                                      INDDS(INDICATORS)
001200020514     FAC2MST    IF   E           K DISK
001300020515     FACCMST    IF   E           K DISK    PREFIX(A_)
001400010503     FSUBMST    IF   E           K DISK    PREFIX(S_)
001500020521     FTRSMST    IF   E           K DISK    PREFIX(T_)
001600010412
0017000104120030 D INDICATORS      DS            99
0018000205150019 D F1_PREVIOUS            01     01N   INZ('0')
001900020515     D F3_INQUIRYS            03     03N   INZ('0')
0020000205150019 D F7_EXIT_PGM            07     07N   INZ('0')
002100010511     D IN52_SELFUNDED         52     52N   INZ('0')
0022000106060019 D CANED_ACT_80           80     80N   INZ('0')
002300010412
002400010412     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002500010412     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002600030326     D USA_DATE2       S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002700010416     D SCREEN          S              8A                                        CONTROL VARIABLE
002800020716     D STATUS          S              3                                         CONTROL VARIABLE
002900020515     D SCREEN_SV       S                   LIKE(SCREEN)                         CONTROL VARIABLE
003000010419     D ACCT_NBR_E      S             10A                                        CONTROL VARIABLE
003100020514     D FKEY1           C                   'F1=Previous Screen  F7=Exit    -
003200020515     D                                      F3=More Inquiry Selections'
003300010502
003400010502     D                 DS
003500010503     D TIMEDATE_DS                   12  0 INZ(*ZEROS)
003600010503     D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
003700010503     D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
003800010412
003900010104     D                 DS
004000010503     D ACCT_NBR                      10  0 INZ(*ZEROS)
004100020515     D  A2TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
004200020515     D  A2SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
004300020515     D  A2ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
004400010503
004500010503     D                 DS
004600020521     D A_ACNAM1
004700020521     D  A2ACNAM                            OVERLAY(A_ACNAM1)
004800020521
004900020521     D                 DS
005000020521     D T_TNAME
005100020521     D  A2TNAME                            OVERLAY(T_TNAME)
005200020521
005300020521     D                 DS
005400020521     D S_SUBNAM
005500020521     D  A2SUBNAM                           OVERLAY(S_SUBNAM)
005600020523
005700020716     D                 DS
005800020716     D AREA                         100
005900020716     D  TRST_E                        3    OVERLAY(AREA)
006000020716     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
006100020716     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
006200020716     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
006300020716     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
006400020716     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
006500020716     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
006600020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
006700020716
006800020523     D                UDS
006900020523     D  APPL_E                 1      2
007000020523     D  A2CONAME             201    240
007100010412
007200010412      *? ***************************************************************
007300020514     C                   SELECT
007400020514     C                   WHEN      SCREEN = 'GET_FILE'
007500020514     C                   EXSR      GET_FILE_SR
007600020514     C                   WHEN      SCREEN = 'SCRN4   '
007700020514     C                   EXSR      SCRN4_SR
007800020514     C                   WHEN      SCREEN = 'SCRN5   '
007900020514     C                   EXSR      SCRN5_SR
008000020515     C                   WHEN      SCREEN = 'INQUIRY '
008100020515     C                   EXSR      INQUIRY_SR
008200020515     C                   WHEN      SCREEN = 'SCRN1   ' OR
008300020515     C                             SCREEN = 'SCRN3   ' OR
008400020514     C                             SCREEN = 'EXIT    '
008500020514     C                   EXSR      EXIT_SR
008600020514     C                   OTHER
008700020514     C                   EXSR      SCRN4_SR
008800020514     C                   ENDSL
008900010412
009000020514      *? ***************************************************************
009100020514     C     GET_FILE_SR   BEGSR
009200020514     C     *NOKEY        CLEAR     *ALL          ACCMSR2
009300020514     C     ACCMST2_KEY   CHAIN     ACCMSR2
009400020514     C                   EVAL      SCREEN = 'SCRN4   '
009500020514     C                   ENDSR
009600010412      *? ***************************************************************
009700020514     C     SCRN4_SR      BEGSR
009800030326     C
009900030326     C                   IF        A2NCAPDT  = *ZEROS
010000030326     C                   EVAL      A2NCAPDTP = *ZEROS
010100030326     C                   ELSE
010200030326     C     *ISO          MOVE      A2NCAPDT      USA_DATE2
010300030326     C                   MOVE      USA_DATE2     A2NCAPDTP
010400030326     C                   END
010500060120      * inv head effdt
010501060120     C                   IF        A2iheff = *ZEROS
010502060120     C                   EVAL      A2a2iheff = *ZEROS
010503060120     C                   ELSE
010504060120     C     *ISO          MOVE      A2iheff       USA_DATE2
010505060120     C                   MOVE      USA_DATE2     A2a2iheff
010506060120     C                   END
010507060120
010508051116      * submst headings
010509051116     C                   EVAL      a2ih1tsub  = s_ih1t
010510051116     C                   EVAL      a2ih2tsub  = s_ih2t
010511051116     C                   EVAL      a2ih3tsub  = s_ih3t
010512051116     C                   EVAL      a2ih4tsub  = s_ih4t
010513051116     C                   EVAL      a2ih5tsub  = s_ih5t
010514051116     C                   EVAL      a2ih6tsub  = s_ih6t
010515051116     C                   EVAL      a2ih7tsub  = s_ih7t
010516051116     C                   EVAL      a2ih8tsub  = s_ih8t
010517051116     C                   EVAL      a2ih9tsub  = s_ih9t
010518051116     C                   EVAL      a2ih1bsub  = s_ih1b
010519051116     C                   EVAL      a2ih2bsub  = s_ih2b
010520051116     C                   EVAL      a2ih3bsub  = s_ih3b
010521051116     C                   EVAL      a2ih4bsub  = s_ih4b
010522051116     C                   EVAL      a2ih5bsub  = s_ih5b
010523051116     C                   EVAL      a2ih6bsub  = s_ih6b
010524051116     C                   EVAL      a2ih7bsub  = s_ih7b
010525051116     C                   EVAL      a2ih8bsub  = s_ih8b
010526051116     C                   EVAL      a2ih9bsub  = s_ih9b
010527051115
010528051116      * invoice heading override
010529051116     C                   EVAL      a2a2ih1t   = a2ih1t
010530051116     C                   EVAL      a2a2ih2t   = a2ih2t
010531051116     C                   EVAL      a2a2ih3t   = a2ih3t
010532051116     C                   EVAL      a2a2ih4t   = a2ih4t
010533051116     C                   EVAL      a2a2ih5t   = a2ih5t
010534051116     C                   EVAL      a2a2ih6t   = a2ih6t
010535051116     C                   EVAL      a2a2ih7t   = a2ih7t
010536051116     C                   EVAL      a2a2ih8t   = a2ih8t
010537051116     C                   EVAL      a2a2ih9t   = a2ih9t
010538051116     C                   EVAL      a2a2ih1b   = a2ih1b
010539051116     C                   EVAL      a2a2ih2b   = a2ih2b
010540051116     C                   EVAL      a2a2ih3b   = a2ih3b
010541051116     C                   EVAL      a2a2ih4b   = a2ih4b
010542051116     C                   EVAL      a2a2ih5b   = a2ih5b
010543051116     C                   EVAL      a2a2ih6b   = a2ih6b
010544051116     C                   EVAL      a2a2ih7b   = a2ih7b
010545051116     C                   EVAL      a2a2ih8b   = a2ih8b
010546051116     C                   EVAL      a2a2ih9b   = a2ih9b
010550051116
010600020514     C                   EXFMT     SCRN4
010700020515
010800020514     C                   IF        F1_PREVIOUS    = *ON
010900020716     C                   EVAL      STATUS = 'F1 '
011000020514     C                   EVAL      SCREEN = 'SCRN3   '
011100020514     C                   LEAVESR
011200020514     C                   END
011300020515     C                   IF        F3_INQUIRYS    = *ON
011400020515     C                   EVAL      SCREEN_SV = SCREEN
011500020515     C                   EVAL      SCREEN = 'INQUIRY '
011600020515     C                   LEAVESR
011700020515     C                   END
011800020515     C                   IF        F7_EXIT_PGM    = *ON
011900020716     C                   EVAL      STATUS = 'F7 '
012000020515     C                   EVAL      SCREEN = 'EXIT    '
012100020515     C                   LEAVESR
012200020515     C                   END
012300020515     C                   EVAL      SCREEN = 'SCRN5   '
012400010412
012500010606     C                   ENDSR
012600010606
012700010606      *? ***************************************************************
012800020514     C     SCRN5_SR      BEGSR
012900010606
013000020514     C                   EXFMT     SCRN5
013100020514     C                   IF        F1_PREVIOUS    = *ON
013200020716     C                   EVAL      STATUS = 'F1 '
013300020514     C                   EVAL      SCREEN = 'SCRN4   '
013400020514     C                   LEAVESR
013500020514     C                   END
013600020515     C                   IF        F3_INQUIRYS    = *ON
013700020515     C                   EVAL      SCREEN_SV = SCREEN
013800020515     C                   EVAL      SCREEN = 'INQUIRY '
013900020515     C                   LEAVESR
014000020515     C                   END
014100020515     C                   IF        F7_EXIT_PGM    = *ON
014200020716     C                   EVAL      STATUS = 'F7 '
014300020716     C                   EVAL      SCREEN = 'EXIT    '
014400020515     C                   LEAVESR
014500020515     C                   END
014600020515     C                   EVAL      SCREEN = 'SCRN1   '
014700010606
014800010606     C                   ENDSR
014900010503
015000020515      *? ***************************************************************
015100020515     C     INQUIRY_SR    BEGSR
015200020716
015300020716     C     *DTAARA       DEFINE    FI060A        AREA
015400020716     C     *LOCK         IN        AREA
015500020716     C                   MOVE      STATUS        STAT_E
015600020716     C                   OUT       AREA
015700020515     C                   CALL      'FI060_1R'
015800020716     C     *LOCK         IN        AREA
015900020716     C                   MOVE      STAT_E        STATUS
016000020716     C                   OUT       AREA
016100020716     C                   EVAL      SCREEN    = SCREEN_SV
016200020716     C                   IF        STATUS = 'F7 '
016300020716     C                   EVAL      SCREEN = 'EXIT    '
016400020716     C                   END
016500020515     C                   ENDSR
016600010605      *? ***************************************************************
016700020514     C     EXIT_SR       BEGSR
016800010605     C                   EVAL      *INLR = *ON
016900010605     C                   RETURN
017000010605     C                   ENDSR
017100010412      *? **********************************************************
017200010412     C     *INZSR        BEGSR                                                  INITIAL SETUP
017300010412
017400010416     C     ACCMST2_KEY   KLIST
017500010416     C                   KFLD                    A2APPL
017600020515     C                   KFLD                    A2TRST
017700020515     C                   KFLD                    A2SUB#
017800020515     C                   KFLD                    A2ACCT
017900020515
018000020515     C     ACCMST_KEY    KLIST
018100020515     C                   KFLD                    A2TRST
018200020515     C                   KFLD                    A2SUB#
018300020515     C                   KFLD                    A2ACCT
018400020515
018500020515     C     SUBMST_KEY    KLIST
018501051116     C                   KFLD                    A2TRST
018502051116     C                   KFLD                    A2SUB#
018800010504
018900020514     C     *ENTRY        PLIST
019000020514     C                   PARM                    ACCT_NBR_E
019100020514     C                   PARM                    SCREEN
019200010503
019300010503     C                   MOVE      ACCT_NBR_E    ACCT_NBR
019400010416
019500020523     C                   IF        APPL_E      = 'N.'
019600010608     C                   EVAL      A2APPL = 'S'
019700020515     C                   EVAL      A2APPL4 = 'SELF'
019800010511     C                   EVAL      IN52_SELFUNDED  = *ON
019900010416     C                   ELSE
020000010608     C                   EVAL      A2APPL = 'F'
020100020515     C                   EVAL      A2APPL4 = 'FULL'
020200010416     C                   END
020300010416
020400020514     C                   EVAL      SCREEN = 'GET_FILE'
020500010416
020600010503     C     ACCMST_KEY    CHAIN(N)  ACCMSR
020700010416
020800010503     C     SUBMST_KEY    CHAIN(N)  SUBMSR
020900020521
021000051116     C     a_actrst      CHAIN(N)  TRSMSR
021100020220
021200010416     C                   IF        A_ACDLTD     = 'C'
021300010606     C                   EVAL      CANED_ACT_80 = *ON
021400010416     C                   ELSE
021500010606     C                   EVAL      CANED_ACT_80 = *OFF
021600010416     C                   END
021700010503     C                   TIME                    TIMEDATE_DS
021800010503     C     *MDY          MOVE      DATE_DS       USA_DATE
021900010503     C     *MDY          MOVE      DATE_DS       ISO_DATE
022000010412
022100020515     C                   EVAL      A2FKEY_LINE =  FKEY1
022200010412     C                   ENDSR
