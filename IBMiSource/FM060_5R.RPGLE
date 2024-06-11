000100010412      *? ***************************************************************
000200010608      * FM060_4R - COST CENTER MAINT
000300010608      *   WRITTEN by Terry Powers  06/01
000400010412      *
000500010608      *? Description: cost center codes maint screen
000600010417
000700010417      *? FIELDS BEGINNING WITH W_ ARE DISPLAY FIELDS
000800010416      *? ***************************************************************
000900010608     FFM060_5D  CF   E             WORKSTN PREFIX(W_)
001000010412     F                                     SFILE(SFL_REC1:SRECNO1)
001100010518     F                                      INDDS(INDICATORS)
001200010518     FACCMST    IF   E           K DISK    PREFIX(A_)
001300010518     FSUBMST    IF   E           K DISK    PREFIX(S_)
001400010608     FCODES     IF   E           K DISK    PREFIX(C_)
001500010608     FCOSTCTRP  UF A E           K DISK
001600010412
0017000104120030 D INDICATORS      DS            99
0018000105180019 D  F1_PREVIOUS            1      1N   INZ('0')
0019000105180019 D  F7_END_PGM             7      7N   INZ('0')
002000010518     D  SFLDSP_11             11     11N   INZ('0')
002100010518     D  SFLEND_21             21     21N   INZ('0')
0022000105180019 D CANED_MBR_80           80     80N   INZ('0')
002300010412
002400010412     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002500010412     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002600010416     D SCREEN          S              8A                                        CONTROL VARIABLE
002700010503     D SRECNO1         S              4  0 INZ(*ZEROS)
002800010606     D TRST_E          S                   LIKE(W_TRST)
002900010606     D SUB#_E          S                   LIKE(W_SUB#)
003000010606     D ACCT_E          S                   LIKE(W_ACCT)
003100010502
003200010502     D                 DS
003300010503     D TIMEDATE_DS                   12  0 INZ(*ZEROS)
003400010503     D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
003500010503     D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
003600010412
003700010104     D                 DS
003800010503     D ACCT_NBR                      10  0 INZ(*ZEROS)
003900010412     D  W_TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
004000010412     D  W_SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
004100010412     D  W_ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
004200010518
004300010518     D                 DS
004400010518     D A_ACNAM1                                                                 DS FOR CALL TO FM06*
004500010518     D  W_ACCT_NAME                        OVERLAY(A_ACNAM1)
004600010518
004700010518     D                 DS
004800010518     D S_SUBNAM                                                                 DS FOR CALL TO FM06*
004900010518     D  W_SUB#_NAME                        OVERLAY(S_SUBNAM)
005000010608
005100010608     D                 DS
005200010608     D W_CODE                                                                   DS FOR CALL TO FM06*
005300010608     D  CCCODE                             OVERLAY(W_CODE)
005400010608     D  TYPE                          1    OVERLAY(W_CODE)
005500010608     D  C_TYPE                        1    OVERLAY(W_CODE)
005600010608     D  CODE2                         2    OVERLAY(W_CODE:2)
005700010608     D  C_CODE                        2    OVERLAY(W_CODE:2)
005800010518
005900010417     D                 DS
006000010417     D COMPANY                       50
006100010419     D W_CONAME                            OVERLAY(COMPANY:2)
006200010419     D APPLICATION                    2    OVERLAY(COMPANY:45)
006300010412
006400010412      *? LOCAL DATA AREA
006500000102     D                UDS
006600010503     D  USER_DS              100    107
006700010412      *? ***************************************************************
006800010412
006900010416     C                   DOU       SCREEN = 'EXIT    '
007000010606     C     SCREEN        CASEQ     'SCRN1   '    SCRN1_SR
007100010518     C     SCREEN        CASEQ     'SCRN2   '    SCRN2_SR
007200000102     C                   ENDCS
007300000102     C                   ENDDO
007400010412
007500010412     C                   EXSR      END_JOB_SR
007600010412
007700010412      *? ***************************************************************
007800010412     C     SCRN1_SR      BEGSR
007900010416
008000010606     C                   EVAL      W_TRST = TRST_E
008100010606     C                   EVAL      W_SUB# = SUB#_E
008200010606     C                   EVAL      W_ACCT = ACCT_E
008300010518     C                   EXFMT     SCRN1
008400010518      *? END PGM *******************************************************
008500010518     C                   IF        F7_END_PGM = *ON
008600010518     C                   EVAL      SCREEN = 'EXIT '
008700010518     C                   LEAVESR
008800010518     C                   END
008900010518
009000010518     C     ACCMST_KEY    CHAIN     ACCMSR
009100010518     C                   EVAL      W_ERROR_MSG = '               '
009200010518     C                   IF        NOT %FOUND(ACCMST)
009300010518     C                   EVAL      SCREEN = 'SCRN1'
009400010518     C                   EVAL      W_ERROR_MSG = 'INVALID ACCOUNT'
009500010518     C                   LEAVESR
009600010518     C                   END
009700010518     C                   IF        A_ACDLTD     = 'C'
009800010518     C                   EVAL      CANED_MBR_80 = *ON
009900010518     C                   ELSE
010000010518     C                   EVAL      CANED_MBR_80 = *OFF
010100010518     C                   END
010200010518
010300010518     C     SUBMST_KEY    CHAIN(N)  SUBMSR
010400010518     C                   EVAL      SCREEN = 'SCRN2'
010500010416
010600010518     C                   ENDSR
010700010518      *? ***************************************************************
010800010518     C     SCRN2_SR      BEGSR
010900010607      *?DISPLAY
011000010608     C     COSTCTR_KEY2  SETLL     COSTCTRR
011100010518     C                   RESET                   W_RECNUM
011200010518     C                   RESET                   SRECNO1
011300010518     C                   RESET                   SFLEND_21
011400010518     C                   EVAL      SFLDSP_11  = *ON
011500010518    ?C                   WRITE     SFL_CTL1
011600010518     C                   RESET                   SFLDSP_11
011700010518     C                   EVAL      SRECNO1  = SRECNO1 + 1
011800010518     C                   EVAL      W_SELECT   = *BLANKS
011900010608     C                   EVAL      W_CODE     = *BLANKS
012000010608     C                   EVAL      W_DESCR    = *BLANKS
012100010518    ?C                   WRITE     SFL_REC1
012200010608     C                   DOU       %EOF(COSTCTRP)
012300010608     C     COSTCTR_KEY2  READE     COSTCTRR
012400010608     C                   IF        NOT %EOF(COSTCTRP)
012500010518     C                   EVAL      SRECNO1  = SRECNO1 + 1
012600010608     C                   EVAL      W_SELECT   = *BLANKS
012700010608     C                   EVAL      W_CODE     = CCCODE
012800010608     C     CODES_KEY     CHAIN     CODESR
012900010608     C                   IF        %FOUND(CODES)
013000010608     C                   EVAL      W_DESCR    = C_LDESCR
013100010608     C                   ELSE
013200010608     C                   EVAL      W_DESCR    = 'INVALID CODE'
013300010608     C                   END
013400010518    ?C                   WRITE     SFL_REC1
013500010608     C                   END
013600010518     C                   ENDDO
013700010518
013800010608     C     SUBF          TAG
013900010518    ?C                   WRITE     CMD_LINE1
014000010518    ?C                   EXFMT     SFL_CTL1
014100010518
014200010518     C                   IF        F1_PREVIOUS      = *ON
014300010518     C                   EVAL      SCREEN = 'SCRN1   '
014400010518     C                   LEAVESR
014500010518     C                   END
014600010518
014700010518     C                   IF        F7_END_PGM       = *ON
014800010518     C                   EVAL      SCREEN = 'EXIT    '
014900010518     C                   LEAVESR
015000010518     C                   END
015100010518
015200010607    ?C                   DOU       %EOF
015300010518    ?C                   READC     SFL_REC1
015400010608     C                   EVAL      W_DESCR    = *BLANKS
015500010607     C                   IF        NOT %EOF
015600010608     C     COSTCTR_KEY   CHAIN     COSTCTRR
015700010518     C
015800010608     C                   IF        %FOUND(COSTCTRP)
015900010607     C                   IF        W_SELECT = 'D'
016000010608     C                   DELETE    COSTCTRR
016100010607     C                   END
016200010518     C                   ELSE
016300010607     C                   IF        W_SELECT = 'A'
016400010608     C     CODES_KEY     CHAIN     CODESR
016500010608     C                   IF        NOT %FOUND(CODES)
016600010608     C                   EVAL      W_DESCR    = 'INVALID CODE'
016700010608     C                   UPDATE    SFL_REC1
016800010608     C                   LEAVE
016900010608     C                   ELSE
017000010608     C                   EVAL      CCTRST     = W_TRST
017100010608     C                   EVAL      CCSUB#     = W_SUB#
017200010608     C                   EVAL      CCACCT     = W_ACCT
017300010608     C                   EVAL      CCCODE     = W_CODE
017400010608     C                   RESET                   CCAPPL
017500010608     C                   WRITE     COSTCTRR
017600010607     C                   END
017700010607     C                   END
017800010608     C                   END
017900010607     C                   END
018000010607    ?C                   ENDDO
018100010608     C                   IF        W_DESCR    = 'INVALID CODE'
018200010608     C                   GOTO      SUBF
018300010608     C                   END
018400010518
018500010518     C                   ENDSR
018600010518
018700010503      *? ***************************************************************
018800010412     C     END_JOB_SR    BEGSR
018900010416     C                   EVAL      *INLR = *ON
019000010412     C                   RETURN
019100010412     C                   ENDSR
019200010412      *? **********************************************************
019300010412     C     *INZSR        BEGSR                                                  INITIAL SETUP
019400010608
019500010608     C     SUBMST_KEY    KLIST
019600010608     C                   KFLD                    W_TRST
019700010608     C                   KFLD                    W_SUB#
019800010608     C     ACCMST_KEY    KLIST
019900010608     C                   KFLD                    W_TRST
020000010608     C                   KFLD                    W_SUB#
020100010608     C                   KFLD                    W_ACCT
020200010518
020300010608     C     COSTCTR_KEY   KLIST
020400010608     C                   KFLD                    CCAPPL
020500010608     C                   KFLD                    W_TRST
020600010518     C                   KFLD                    W_SUB#
020700010518     C                   KFLD                    W_ACCT
020800010608     C                   KFLD                    W_CODE
020900010608     C     COSTCTR_KEY2  KLIST
021000010608     C                   KFLD                    CCAPPL
021100010608     C                   KFLD                    W_TRST
021200010608     C                   KFLD                    W_SUB#
021300010608     C                   KFLD                    W_ACCT
021400010608
021500010608     C     CODES_KEY     KLIST
021600010608     C                   KFLD                    TYPE
021700010608     C                   KFLD                    CODE2
021800010518
021900010417     C     *DTAARA       DEFINE                  COMPANY
022000010417     C                   IN        COMPANY
022100010416
022200010416     C                   EVAL      SCREEN = 'SCRN1   '
022300010416
022400010503     C                   TIME                    TIMEDATE_DS
022500010503     C     *MDY          MOVE      DATE_DS       USA_DATE
022600010503     C     *MDY          MOVE      DATE_DS       ISO_DATE
022700010412
022800010511     C                   EVAL      W_RECNUM  = 1
022900010606     C     *ENTRY        PLIST
023000010606     C                   PARM                    TRST_E
023100010606     C                   PARM                    SUB#_E
023200010606     C                   PARM                    ACCT_E
023300010608
023400010608     C                   IF        APPLICATION = 'N.'
023500010608     C                   EVAL      CCAPPL = 'S'
023600010608     C                   EVAL      W_APPL = 'SELF'
023700010608     C                   ELSE
023800010608     C                   EVAL      CCAPPL = 'F'
023900010608     C                   EVAL      W_APPL = 'FULL'
024000010608     C                   END
024100010412     C                   ENDSR
