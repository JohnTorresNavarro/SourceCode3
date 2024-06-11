000100010412      *? ***************************************************************
000200010607      * FM060_4R - ACCOUNT MASTER RELATED ACCOUNTS
000300010518      *   WRITTEN by Terry Powers  05/01
000400010412      *
000500010607      *? Description: related accounts maint screen
000600010417
000700010417      *? FIELDS BEGINNING WITH W_ ARE DISPLAY FIELDS
000800010416      *? ***************************************************************
000900010607     FFM060_4D  CF   E             WORKSTN PREFIX(W_)
001000010412     F                                     SFILE(SFL_REC1:SRECNO1)
001100010518     F                                      INDDS(INDICATORS)
001200010518     FACCMST    IF   E           K DISK    PREFIX(A_)
001300010518     FSUBMST    IF   E           K DISK    PREFIX(S_)
001400010820     FACRELATP  UF A E           K DISK
001500010412
0016000104120030 D INDICATORS      DS            99
0017000105180019 D  F1_PREVIOUS            1      1N   INZ('0')
0018000105180019 D  F7_END_PGM             7      7N   INZ('0')
001900010518     D  SFLDSP_11             11     11N   INZ('0')
002000010518     D  SFLEND_21             21     21N   INZ('0')
0021000105180019 D CANED_MBR_80           80     80N   INZ('0')
002200010412
002300010412     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002400010412     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002500010416     D SCREEN          S              8A                                        CONTROL VARIABLE
002600010503     D SRECNO1         S              4  0 INZ(*ZEROS)
002700010606     D TRST_E          S                   LIKE(W_TRST)
002800010606     D SUB#_E          S                   LIKE(W_SUB#)
002900010606     D ACCT_E          S                   LIKE(W_ACCT)
003000010502
003100010502     D                 DS
003200010503     D TIMEDATE_DS                   12  0 INZ(*ZEROS)
003300010503     D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
003400010503     D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
003500010412
003600010104     D                 DS
003700010503     D ACCT_NBR                      10  0 INZ(*ZEROS)
003800010412     D  W_TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
003900010412     D  W_SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
004000010412     D  W_ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
004100010518
004200010518     D                 DS
004300010518     D A_ACNAM1                                                                 DS FOR CALL TO FM06*
004400010518     D  W_ACCT_NAME                        OVERLAY(A_ACNAM1)
004500010518
004600010518     D                 DS
004700010518     D S_SUBNAM                                                                 DS FOR CALL TO FM06*
004800010518     D  W_SUB#_NAME                        OVERLAY(S_SUBNAM)
004900010518
005000010417     D                 DS
005100010417     D COMPANY                       50
005200010419     D W_CONAME                            OVERLAY(COMPANY:2)
005300010419     D APPLICATION                    2    OVERLAY(COMPANY:45)
005400010412
005500010412      *? LOCAL DATA AREA
005600000102     D                UDS
005700010503     D  USER_DS              100    107
005800010412      *? ***************************************************************
005900010412
006000010416     C                   DOU       SCREEN = 'EXIT    '
006100010606     C     SCREEN        CASEQ     'SCRN1   '    SCRN1_SR
006200010518     C     SCREEN        CASEQ     'SCRN2   '    SCRN2_SR
006300000102     C                   ENDCS
006400000102     C                   ENDDO
006500010412
006600010412     C                   EXSR      END_JOB_SR
006700010412
006800010412      *? ***************************************************************
006900010412     C     SCRN1_SR      BEGSR
007000010416
007100010606     C                   EVAL      W_TRST = TRST_E
007200010606     C                   EVAL      W_SUB# = SUB#_E
007300010606     C                   EVAL      W_ACCT = ACCT_E
007400010518     C                   EXFMT     SCRN1
007500010518      *? END PGM *******************************************************
007600010518     C                   IF        F7_END_PGM = *ON
007700010518     C                   EVAL      SCREEN = 'EXIT '
007800010518     C                   LEAVESR
007900010518     C                   END
008000010518
008100010518     C     ACCMST_KEY    CHAIN     ACCMSR
008200010518     C                   EVAL      W_ERROR_MSG = '               '
008300010518     C                   IF        NOT %FOUND(ACCMST)
008400010518     C                   EVAL      SCREEN = 'SCRN1'
008500010518     C                   EVAL      W_ERROR_MSG = 'INVALID ACCOUNT'
008600010518     C                   LEAVESR
008700010518     C                   END
008800010518     C                   IF        A_ACDLTD     = 'C'
008900010518     C                   EVAL      CANED_MBR_80 = *ON
009000010518     C                   ELSE
009100010518     C                   EVAL      CANED_MBR_80 = *OFF
009200010518     C                   END
009300010518
009400010518     C     SUBMST_KEY    CHAIN(N)  SUBMSR
009500010518     C                   EVAL      SCREEN = 'SCRN2'
009600010416
009700010518     C                   ENDSR
009800010518      *? ***************************************************************
009900010518     C     SCRN2_SR      BEGSR
010000010607      *?DISPLAY
010100010608     C     ACCRELAT_KEY2 SETLL     ACCRELATR
010200010518     C                   RESET                   W_RECNUM
010300010518     C                   RESET                   SRECNO1
010400010518     C                   RESET                   SFLEND_21
010500010518     C                   EVAL      SFLDSP_11  = *ON
010600010518    ?C                   WRITE     SFL_CTL1
010700010518     C                   RESET                   SFLDSP_11
010800010518     C                   EVAL      SRECNO1  = SRECNO1 + 1
010900010518     C                   EVAL      W_SELECT   = *BLANKS
011000010607     C                   EVAL      W_TRSTX    = *ZEROS
011100010607     C                   EVAL      W_SUB#X    = *ZEROS
011200010607     C                   EVAL      W_ACCTX    = *ZEROS
011300010607     C                   EVAL      W_ACNAM1X  = *BLANKS
011400010518    ?C                   WRITE     SFL_REC1
011500010820     C                   DOU       %EOF(ACRELATP)
011600010608     C     ACCRELAT_KEY2 READE     ACCRELATR
011700010820     C                   IF        NOT %EOF(ACRELATP)
011800010518     C                   EVAL      SRECNO1  = SRECNO1 + 1
011900010518     C                   EVAL      W_SELECT   = *BLANKS
012000010607     C                   EVAL      W_TRSTX    = ARTRSTX
012100010607     C                   EVAL      W_SUB#X    = ARSUB#X
012200010607     C                   EVAL      W_ACCTX    = ARACCTX
012300010607     C     ACCRELATXKEY  CHAIN     ACCMSR
012400010607     C                   IF        %FOUND(ACCMST)
012500010607     C                   EVAL      W_ACNAM1X  = A_ACNAM1
012600010607     C                   ELSE
012700010607     C                   EVAL      W_ACNAM1X  = 'ACCOUNT NOT FOUND'
012800010607     C                   END
012900010518    ?C                   WRITE     SFL_REC1
013000010518     C                   END
013100010518     C                   ENDDO
013200010518
013300010607     C     SUBF          TAG
013400010518    ?C                   WRITE     CMD_LINE1
013500010518    ?C                   EXFMT     SFL_CTL1
013600010518
013700010518     C                   IF        F1_PREVIOUS      = *ON
013800010518     C                   EVAL      SCREEN = 'SCRN1   '
013900010518     C                   LEAVESR
014000010518     C                   END
014100010518
014200010518     C                   IF        F7_END_PGM       = *ON
014300010518     C                   EVAL      SCREEN = 'EXIT    '
014400010518     C                   LEAVESR
014500010518     C                   END
014600010518
014700010607    ?C                   DOU       %EOF
014800010608     C                   EVAL      W_ACNAM1X  = *BLANKS
014900010518    ?C                   READC     SFL_REC1
015000010607     C                   IF        NOT %EOF
015100010607     C     ACCRELAT_KEY  CHAIN     ACCRELATR
015200010518     C
015300010820     C                   IF        %FOUND(ACRELATP)
015400010607     C                   IF        W_SELECT = 'D'
015500010607     C                   DELETE    ACCRELATR
015600010607     C                   END
015700010518     C                   ELSE
015800010607     C                   IF        W_SELECT = 'A'
015900010607     C     ACCRELATXKEY  CHAIN     ACCMSR
016000010607     C                   IF        NOT %FOUND(ACCMST)
016100010607     C                   EVAL      W_ACNAM1X  = 'ACCOUNT NOT FOUND'
016200010607     C                   UPDATE    SFL_REC1
016300010608     C                   LEAVE
016400010607     C                   ELSE
016500010607     C                   EVAL      ARTRST     = W_TRST
016600010607     C                   EVAL      ARSUB#     = W_SUB#
016700010607     C                   EVAL      ARACCT     = W_ACCT
016800010607     C                   EVAL      ARTRSTX    = W_TRSTX
016900010607     C                   EVAL      ARSUB#X    = W_SUB#X
017000091102     C                   EVAL      ARACCTX    = W_ACCTX
017100091102     C                   EVAL      ARSRCH     = %trim(A_ACNAM1)
017200010608     C                   RESET                   ARAPPL
017300010607     C                   WRITE     ACCRELATR
017400010607     C                   END
017500010607     C                   END
017600010607     C                   END
017700010607     C                   END
017800010607    ?C                   ENDDO
017900010607     C                   IF        W_ACNAM1X  = 'ACCOUNT NOT FOUND'
018000010607     C                   GOTO      SUBF
018100010607     C                   END
018200010518
018300010518     C                   ENDSR
018400010518
018500010503      *? ***************************************************************
018600010412     C     END_JOB_SR    BEGSR
018700010416     C                   EVAL      *INLR = *ON
018800010412     C                   RETURN
018900010412     C                   ENDSR
019000010412      *? **********************************************************
019100010412     C     *INZSR        BEGSR                                                  INITIAL SETUP
019200010518
019300010518     C     SUBMST_KEY    KLIST
019400010518     C                   KFLD                    W_TRST
019500010518     C                   KFLD                    W_SUB#
019600010518     C     ACCMST_KEY    KLIST
019700010518     C                   KFLD                    W_TRST
019800010518     C                   KFLD                    W_SUB#
019900010518     C                   KFLD                    W_ACCT
020000010607     C     ACCRELAT_KEY  KLIST
020100010608     C                   KFLD                    ARAPPL
020200010608     C                   KFLD                    W_TRST
020300010607     C                   KFLD                    W_SUB#
020400010607     C                   KFLD                    W_ACCT
020500010607     C                   KFLD                    W_TRSTX
020600010607     C                   KFLD                    W_SUB#X
020700010607     C                   KFLD                    W_ACCTX
020800010608     C     ACCRELATXKEY  KLIST
020900010607     C                   KFLD                    W_TRSTX
021000010607     C                   KFLD                    W_SUB#X
021100010607     C                   KFLD                    W_ACCTX
021200010608     C     ACCRELAT_KEY2 KLIST
021300010608     C                   KFLD                    ARAPPL
021400010608     C                   KFLD                    W_TRST
021500010608     C                   KFLD                    W_SUB#
021600010608     C                   KFLD                    W_ACCT
021700010518
021800010417     C     *DTAARA       DEFINE                  COMPANY
021900010417     C                   IN        COMPANY
022000010416
022100010416     C                   EVAL      SCREEN = 'SCRN1   '
022200010416
022300010503     C                   TIME                    TIMEDATE_DS
022400010503     C     *MDY          MOVE      DATE_DS       USA_DATE
022500010503     C     *MDY          MOVE      DATE_DS       ISO_DATE
022600010412
022700010511     C                   EVAL      W_RECNUM  = 1
022800010606     C     *ENTRY        PLIST
022900010606     C                   PARM                    TRST_E
023000010606     C                   PARM                    SUB#_E
023100010606     C                   PARM                    ACCT_E
023200010608
023300010608     C                   IF        APPLICATION = 'N.'
023400010608     C                   EVAL      ARAPPL = 'S'
023500010608     C                   EVAL      W_APPL = 'SELF'
023600010608     C                   ELSE
023700010608     C                   EVAL      ARAPPL = 'F'
023800010608     C                   EVAL      W_APPL = 'FULL'
023900010608     C                   END
024000010412     C                   ENDSR
