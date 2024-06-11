000100010412      *? ***************************************************************
000200010608      * FM060_2R - CARRIER ID
000300010518      *   WRITTEN by Terry Powers  05/01
000400010412      *
000500010605      *? Description: display carrier identifier maint screen
000600010417
000700010417      *? FIELDS BEGINNING WITH W_ ARE DISPLAY FIELDS
000800010416      *? ***************************************************************
000900010518     FFM060_3D  CF   E             WORKSTN PREFIX(W_)
001000010412     F                                     SFILE(SFL_REC1:SRECNO1)
001100010518     F                                      INDDS(INDICATORS)
001200010518     FACCMST    IF   E           K DISK    PREFIX(A_)
001300010518     FSUBMST    IF   E           K DISK    PREFIX(S_)
001400010611     FCARMST    IF   E           K DISK    PREFIX(C_)
001500010518     FCARACCXP  UF A E           K DISK
001600010412
0017000104120030 D INDICATORS      DS            99
0018000105180019 D  F1_PREVIOUS            1      1N   INZ('0')
0019000105180019 D  F7_END_PGM             7      7N   INZ('0')
002000010518     D  SFLDSP_11             11     11N   INZ('0')
002100010518     D  SFLEND_21             21     21N   INZ('0')
0022000106080019 D CANED_MBR_80           80     80N   INZ('0')
002300010412
002400010412     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002500010412     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002600010416     D SCREEN          S              8A                                        CONTROL VARIABLE
002700010503     D SRECNO1         S              4  0 INZ(*ZEROS)
002800010608     D TRST_E          S                   LIKE(W_TRST)
002900010608     D SUB#_E          S                   LIKE(W_SUB#)
003000010608     D ACCT_E          S                   LIKE(W_ACCT)
003100010502
003200010502     D                 DS
003300010503     D TIMEDATE_DS                   12  0 INZ(*ZEROS)
003400010503     D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
003500010503     D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
003600010412
003700010104     D                 DS
003800010608     D ACCT_NBR                      10  0 INZ(*ZEROS)
003900010412     D  W_TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
004000010412     D  W_SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
004100010412     D  W_ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
004200010518
004300010518     D                 DS
004400020524     D A_ACNAM1
004500010518     D  W_ACCT_NAME                        OVERLAY(A_ACNAM1)
004600010518
004700010518     D                 DS
004800020524     D S_SUBNAM
004900010518     D  W_SUB#_NAME                        OVERLAY(S_SUBNAM)
005000010518
005100010417     D                 DS
005200010417     D COMPANY                       50
005300010419     D W_CONAME                            OVERLAY(COMPANY:2)
005400010419     D APPLICATION                    2    OVERLAY(COMPANY:45)
005500010412
005600010412      *? LOCAL DATA AREA
005700000102     D                UDS
005800010503     D  USER_DS              100    107
005900010412      *? ***************************************************************
006000010412
006100010416     C                   DOU       SCREEN = 'EXIT    '
006200010606     C     SCREEN        CASEQ     'SCRN1   '    SCRN1_SR
006300010518     C     SCREEN        CASEQ     'SCRN2   '    SCRN2_SR
006400000102     C                   ENDCS
006500000102     C                   ENDDO
006600010412
006700010412     C                   EXSR      END_JOB_SR
006800010412
006900010412      *? ***************************************************************
007000010412     C     SCRN1_SR      BEGSR
007100010416
007200010608     C                   EVAL      W_TRST = TRST_E
007300010608     C                   EVAL      W_SUB# = SUB#_E
007400010608     C                   EVAL      W_ACCT = ACCT_E
007500010518     C                   EXFMT     SCRN1
007600010518      *? END PGM *******************************************************
007700010518     C                   IF        F7_END_PGM = *ON
007800010518     C                   EVAL      SCREEN = 'EXIT '
007900010518     C                   LEAVESR
008000010518     C                   END
008100010518
008200010518     C     ACCMST_KEY    CHAIN     ACCMSR
008300010518     C                   EVAL      W_ERROR_MSG = '               '
008400010518     C                   IF        NOT %FOUND(ACCMST)
008500010518     C                   EVAL      SCREEN = 'SCRN1'
008600010518     C                   EVAL      W_ERROR_MSG = 'INVALID ACCOUNT'
008700010518     C                   LEAVESR
008800010518     C                   END
008900010518     C                   IF        A_ACDLTD     = 'C'
009000010518     C                   EVAL      CANED_MBR_80 = *ON
009100010518     C                   ELSE
009200010518     C                   EVAL      CANED_MBR_80 = *OFF
009300010518     C                   END
009400010518
009500010518     C     SUBMST_KEY    CHAIN(N)  SUBMSR
009600010518     C                   EVAL      SCREEN = 'SCRN2'
009700010416
009800010518     C                   ENDSR
009900010518      *? ***************************************************************
010000010518     C     SCRN2_SR      BEGSR
010100010518      *?DISPLAY CODES
010200010608     C     CARACCX_KEY2  SETLL     CARACCXR
010300010518     C                   RESET                   W_RECNUM
010400010518     C                   RESET                   SRECNO1
010500010518     C                   RESET                   SFLEND_21
010600010518     C                   EVAL      SFLDSP_11  = *ON
010700010518    ?C                   WRITE     SFL_CTL1
010800010518     C                   RESET                   SFLDSP_11
010900010518     C                   EVAL      SRECNO1  = SRECNO1 + 1
011000010518     C                   EVAL      W_SELECT   = *BLANKS
011100010518     C                   EVAL      W_HANDLING = *BLANKS
011200010518     C                   EVAL      W_CARRIER  = *BLANKS
011300010518    ?C                   WRITE     SFL_REC1
011400010518     C                   DOU       %EOF(CARACCXP)
011500010608     C     CARACCX_KEY2  READE     CARACCXR
011600010518     C                   IF        NOT %EOF(CARACCXP)
011700010518     C                   EVAL      SRECNO1  = SRECNO1 + 1
011800010518     C                   EVAL      W_SELECT   = *BLANKS
011900010518     C                   EVAL      W_HANDLING = CAHANDLING
012000010518     C                   EVAL      W_CARRIER  = CACARRIER
012100010518    ?C                   WRITE     SFL_REC1
012200010518     C                   END
012300010518     C                   ENDDO
012400010518
012500010611     C     SUBF          TAG
012600010518    ?C                   WRITE     CMD_LINE1
012700010518    ?C                   EXFMT     SFL_CTL1
012800010518
012900010518     C                   IF        F1_PREVIOUS      = *ON
013000010518     C                   EVAL      SCREEN = 'SCRN1   '
013100010518     C                   LEAVESR
013200010518     C                   END
013300010518
013400010518     C                   IF        F7_END_PGM       = *ON
013500010518     C                   EVAL      SCREEN = 'EXIT    '
013600010518     C                   LEAVESR
013700010518     C                   END
013800010518
013900010518    ?C                   DOU       %EOF
014000010518    ?C                   READC     SFL_REC1
014100010518     C                   IF        NOT %EOF
014200010518     C     CARACCX_KEY   CHAIN     CARACCXR
014300010518     C                   EVAL      CATRST     = W_TRST
014400010518     C                   EVAL      CASUB#     = W_SUB#
014500010518     C                   EVAL      CAACCT     = W_ACCT
014600010518     C                   EVAL      CACARRIER  = W_CARRIER
014700010518     C                   EVAL      CAHANDLING = W_HANDLING
014800010518     C
014900010518     C                   IF        %FOUND(CARACCXP)
015000010518     C                   IF        W_SELECT = 'C'
015100010608     C                   RESET                   CAAPPL
015200010518     C                   UPDATE    CARACCXR
015300010518     C                   END
015400010518     C                   IF        W_SELECT = 'D'
015500010518     C                   DELETE    CARACCXR
015600010518     C                   END
015700010518     C                   ELSE
015800010518     C                   IF        W_SELECT = 'A'
015900010611     C     W_CARRIER     CHAIN     CARMSR
016000010611     C                   IF        NOT %FOUND(CARMST)
016100010611     C                   EVAL      W_HANDLING = 'CARRIER NOT FOUND'
016200010611     C                   UPDATE    SFL_REC1
016300010611     C                   LEAVE
016400010611     C                   ELSE
016500010608     C                   RESET                   CAAPPL
016600010518     C                   WRITE     CARACCXR
016700010518     C                   END
016800010611     C                   END
016900010518     C                   END
017000010518     C                   END
017100010518    ?C                   ENDDO
017200010518
017300010611     C                   IF        W_HANDLING = 'CARRIER NOT FOUND'
017400010611     C                   GOTO      SUBF
017500010611     C                   END
017600010518     C                   ENDSR
017700010518
017800010503      *? ***************************************************************
017900010412     C     END_JOB_SR    BEGSR
018000010416     C                   EVAL      *INLR = *ON
018100010412     C                   RETURN
018200010412     C                   ENDSR
018300010412      *? **********************************************************
018400010412     C     *INZSR        BEGSR                                                  INITIAL SETUP
018500010518
018600010518     C     SUBMST_KEY    KLIST
018700010518     C                   KFLD                    W_TRST
018800010518     C                   KFLD                    W_SUB#
018900010518     C     ACCMST_KEY    KLIST
019000010518     C                   KFLD                    W_TRST
019100010518     C                   KFLD                    W_SUB#
019200010518     C                   KFLD                    W_ACCT
019300010518
019400010518     C     CARACCX_KEY   KLIST
019500010608     C                   KFLD                    CAAPPL
019600010608     C                   KFLD                    W_TRST
019700010518     C                   KFLD                    W_SUB#
019800010518     C                   KFLD                    W_ACCT
019900010518     C                   KFLD                    W_CARRIER
020000010608
020100010608     C     CARACCX_KEY2  KLIST
020200010608     C                   KFLD                    CAAPPL
020300010608     C                   KFLD                    W_TRST
020400010608     C                   KFLD                    W_SUB#
020500010608     C                   KFLD                    W_ACCT
020600010518
020700010417     C     *DTAARA       DEFINE                  COMPANY
020800010417     C                   IN        COMPANY
020900010416
021000010416     C                   EVAL      SCREEN = 'SCRN1   '
021100010416
021200010503     C                   TIME                    TIMEDATE_DS
021300010503     C     *MDY          MOVE      DATE_DS       USA_DATE
021400010503     C     *MDY          MOVE      DATE_DS       ISO_DATE
021500010412
021600010511     C                   EVAL      W_RECNUM  = 1
021700010606     C     *ENTRY        PLIST
021800010608     C                   PARM                    TRST_E
021900010608     C                   PARM                    SUB#_E
022000010608     C                   PARM                    ACCT_E
022100010608
022200010608     C                   IF        APPLICATION = 'N.'
022300010608     C                   EVAL      CAAPPL = 'S'
022400010608     C                   EVAL      W_APPL = 'SELF'
022500010608     C                   ELSE
022600010608     C                   EVAL      CAAPPL = 'F'
022700010608     C                   EVAL      W_APPL = 'FULL'
022800010608     C                   END
022900010412     C                   ENDSR
