000100030109     F*-------------------------------------------------------------------------
000200030110     F* FM470     GBS/IO SOFTWARE 2003
000300030110     F*           FM47* SUPER AGENCY ENCHANCMENT PROJECT
000400030109     F*           WRITTEN BY - S.S.K.
000500030109     F*           DATE - 01/03
000600030109     F*  DESCRIPTION - PROMPT
000700030109     F*  INDICATOR USAGE:
000800030109     F*    01 = EXIT FROM INITIAL SCREEN
000900030109     F*    25 = SFLDSP
001000030109     F*    26 = SFL DSP CTL
001100030109     F*    27 = SFL CLR
001200030109     F*
001300030109     F*-------------------------------------------------------------------------
001400030109     ** MODIFICATION HISTORY                                              **
001500030109     ** ###  UUU  MMDDCCYY  X---->                                        **
001600030110     ** 000  SSK  01102003  ORIGINAL SOURCE                               **
001700110418     ** 001  SSK  04182011  ADD MARKETING DIARY NOTES                     **
001800030109     **                                                                   **
001900030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000030110     FFM470D    CF   E             WORKSTN INFDS(WSDS)
002100030110     FSPRAGXRF  UF A E           K DISK
002200030110     FAGENCY    IF   E           K DISK
002300030110     FSUPRAGCY  IF   E           K DISK
002400030109   X***X
002500030109     D WSDS            DS
002600030109     D  FKEY                 369    369A
002700030109    ***
002800030109     D  F1             C                   CONST(X'31')
002900030109     D  F2             C                   CONST(X'32')
003000030109     D  F3             C                   CONST(X'33')
003100030109     D  F4             C                   CONST(X'34')
003200030109     D  F5             C                   CONST(X'35')
003300030109     D  F6             C                   CONST(X'36')
003400030109     D  F7             C                   CONST(X'37')
003500030109     D  F8             C                   CONST(X'38')
003600030109     D  F9             C                   CONST(X'39')
003700030109     D  F10            C                   CONST(X'3A')
003800030109     D  F11            C                   CONST(X'3B')
003900030109     D  F12            C                   CONST(X'3C')
004000030109     D  F13            C                   CONST(X'B1')
004100030109     D  F14            C                   CONST(X'B2')
004200030109     D  F15            C                   CONST(X'B3')
004300030109     D  F16            C                   CONST(X'B4')
004400030109     D  F17            C                   CONST(X'B5')
004500030109     D  F18            C                   CONST(X'B6')
004600030109     D  F19            C                   CONST(X'B7')
004700030109     D  F20            C                   CONST(X'B8')
004800030109     D  F21            C                   CONST(X'B9')
004900030109     D  F22            C                   CONST(X'BA')
005000030109     D  F23            C                   CONST(X'BB')
005100030109     D  F24            C                   CONST(X'BC')
005200030109    ***
005300030306     D #SEQ            S              8S 0
005400030109     D #TDAY           S              8S 0
005500030109     D #ISO            S               D   DATFMT(*ISO)
005600030109     D #USA            S               D   DATFMT(*USA)
005700030109     D @VP             S              1A
005800030109    ***
005900030109     D @IM             S              1A
006000030109     D @STEP           S              5A
006100030429     D P@30            S             30A
006200030429     D KEY@SUPER       S              3A
006300030110     D KEY@AGCY        S              3A
006400030110     D KEY@EFFDTE      S              8S 0
006500030110     D KEY@TRMDTE      S              8S 0
006600030109    ***
006700030109     D @EMSG           S             70A
006800030110     D @8              S              8A
006900030110     D #8              S              8S 0
007000030109   X***X
007100030109    1C                   DOU       @STEP = 'LEAVE'
007200030109    2C     @STEP         CASEQ     'PREP1'       $PREP1
007300030109    2C     @STEP         CASEQ     'STEP1'       $STEP1
007400030109    2C                   ENDCS
007500030109    1C                   ENDDO
007600030109    ***
007700030109     C                   MOVE      *ON           *INLR
007800030109   S***S
007900030109     C     *INZSR        BEGSR
008000030109    ***
008100030109     C     *ENTRY        PLIST
008200030429     C                   PARM                    P@30
008300030109    ***
008400030110     C     KEY#SXF       KLIST
008500030110     C                   KFLD                    KEY@SUPER
008600030110     C                   KFLD                    KEY@AGCY
008700030110     C                   KFLD                    KEY@EFFDTE
008800030110     C                   KFLD                    KEY@TRMDTE
008900030110    ***
009000030109     C                   CLEAR                   IO01
009100030110     C                   CLEAR                   SXF
009200030306     C*
009300030429     C                   EVAL      O_SUPER = %SUBST(P@30:1:3)
009400030429     C                   EVAL      O_AGENCY = %SUBST(P@30:4:3)
009500030429     C                   IF        %SUBST(P@30:30:1) = 'A'
009600030110     C                   EVAL      @IM = 'A'
009700030110     C                   ELSE
009800030110     C                   EVAL      @IM = 'M'
009900030110     C                   ENDIF
010000030110    ***
010100030109     C                   EVAL      @STEP = 'PREP1'
010200030109    ***
010300030109     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
010400030109     C                   IN        @DTA50
010500030109    ***
010600030109     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
010700030109     C                   MOVE      *DATE         #ISO
010800030109     C                   MOVE      #ISO          #TDAY
010900030109    ***
011000030109     C                   ENDSR
011100030109   S***S
011200030109     C     $PREP1        BEGSR
011300030109    ***
011400030110     C                   EVAL      @STEP = 'STEP1'
011500030110    ***
011600030110    1C                   IF        @IM = 'A'
011700030213     C                   CLEAR                   SXF
011800030225     C                   EVAL      *IN25 = *OFF
011900030110     C                   LEAVESR
012000030110    1C                   ENDIF
012100030110    ***
012200030225     C                   EVAL      *IN25 = *ON
012300030110     C                   MOVEL     O_SUPER       KEY@SUPER
012400030110     C                   MOVEL     O_AGENCY      KEY@AGCY
012500030110     C*
012600030429     C                   EVAL      @8 = %SUBST(P@30:7:8)
012700030110     C                   MOVE      @8            #8
012800030110     C                   MOVE      #8            KEY@EFFDTE
012900030110     C*
013000030429     C                   EVAL      @8 = %SUBST(P@30:15:8)
013100030110     C                   MOVE      @8            #8
013200030110     C                   MOVE      #8            KEY@TRMDTE
013300030306     C*
013400030429     C                   EVAL      O_ASID = %SUBST(P@30:23:8)
013500030110     C*
013600030110     C     KEY#SXF       CHAIN     SXF
013700030109    ***
013800030110     C     O_SUPER       CHAIN(N)  SAF
013900030110     C                   IF        %FOUND(SUPRAGCY)
014000030110     C                   MOVEL(P)  SANAME1       O_SUPRNAME
014100030110     C                   ELSE
014200030110     C                   MOVEL(P)  '*UNKNOWN'    O_SUPRNAME
014300030110     C                   ENDIF
014400030110    ***
014500030110     C     O_AGENCY      CHAIN(N)  AGENR
014600030110     C                   IF        %FOUND(AGENCY)
014700030110     C                   MOVEL(P)  AGNAM1        O_AGNAME1
014800030110     C                   ELSE
014900030110     C                   MOVEL(P)  '*UNKNOWN'    O_AGNAME1
015000030110     C                   ENDIF
015100030110    ***
015200030110     C                   IF        SXEFFDTE > 0
015300030110     C     SXEFFDTE      MULT      10000.0001    I_BEGDT
015400030109     C                   ELSE
015500030110     C                   Z-ADD     SXEFFDTE      I_BEGDT
015600030109     C                   ENDIF
015700030109    ***
015800030110     C                   IF        SXTRMDTE > 0
015900030110     C     SXTRMDTE      MULT      10000.0001    I_ENDDT
016000030109     C                   ELSE
016100030110     C                   Z-ADD     SXTRMDTE      I_ENDDT
016200030109     C                   ENDIF
016300030109    ***
016400030109     C                   ENDSR
016500030109   S***S
016600030109     C     $STEP1        BEGSR
016700030109    ***
016800030109     C                   MOVEL     @EMSG         EMSG
016900030109     C                   EXFMT     IO01
017000030109     C                   MOVE      *BLANKS       EMSG
017100030109     C                   MOVE      *BLANKS       @EMSG
017200030109    ***
017300030109    1C                   IF        FKEY = F7
017400030109     C                   EVAL      @STEP = 'LEAVE'
017500030429     C                   MOVEL(P)  'X'           P@30
017600030109     C                   LEAVESR
017700030109    1C                   ENDIF
017800030109    ***
017900110418     C                   IF        FKEY = F2
018000110418     C                   EVAL      @NTEPARM = '011' + O_ASID
018100110418     C                   CALL      'MDC010  '
018200110418     C                   PARM                    @NTEPARM         11
018300110418     C                   LEAVESR
018400110418     C                   END
018500110418    ***
018600030109    1C                   IF        FKEY = F1
018700030109     C                   EVAL      @STEP = 'LEAVE'
018800030429     C                   MOVE      *BLANKS       P@30
018900030109     C                   LEAVESR
019000030109    1C                   ENDIF
019100030109    ***
019200030109    1C                   IF        @IM <> 'I'
019300030109     C                   EXSR      $VALID
019400030109    ***
019500030109    2C                   IF        @VP = 'Y'
019600030109     C                   EXSR      $I#O
019700030109     C                   EVAL      @STEP = 'LEAVE'
019800030429     C                   MOVE      *BLANKS       P@30
019900030109     C                   LEAVESR
020000030109    2C                   ENDIF
020100030109    ***
020200030109    1C                   ENDIF
020300030109    ***
020400030109     C                   ENDSR
020500030109   S***S
020600030109     C     $I#O          BEGSR
020700030109    ***
020800030109    1C                   IF        @IM = 'A'
020900030109    *** ADD RECORD
021000030110     C                   CLEAR                   SXF
021100030110     C                   MOVEL     O_AGENCY      SXAGCY
021200030110     C                   MOVEL     O_SUPER       SXSUPER
021300030306    ***
021400030306     C     *DTAARA       DEFINE    SXASID#       #SEQ
021500030306     C     *LOCK         IN        #SEQ
021600030306     C                   ADD       1             #SEQ
021700030306     C                   MOVE      #SEQ          SXASID
021800030306     C                   EVAL      O_ASID = SXASID
021900030306     C                   OUT       #SEQ
022000030306     C                   UNLOCK    #SEQ
022100030306    ***
022200030109     C                   EXSR      $COMNFMT
022300030109    ***
022400030110     C                   WRITE     SXF
022500030109    ***
022600030109     C                   LEAVESR
022700030109    1C                   ENDIF
022800030109    *** CHANGE RECORD
022900030109     C                   EXSR      $COMNFMT
023000030109    ***
023100030110     C                   UPDATE    SXF
023200030109    ***
023300030109     C                   ENDSR
023400030109   S***S
023500030109     C     $COMNFMT      BEGSR
023600030109    ***
023700030109     C                   IF        I_BEGDT > 0
023800030110     C     I_BEGDT       MULT      10000.0001    SXEFFDTE
023900030109     C                   ELSE
024000030110     C                   Z-ADD     I_BEGDT       SXEFFDTE
024100030109     C                   ENDIF
024200030109    ***
024300030109     C                   IF        I_ENDDT > 0
024400030110     C     I_ENDDT       MULT      10000.0001    SXTRMDTE
024500030109     C                   ELSE
024600030110     C                   Z-ADD     I_ENDDT       SXTRMDTE
024700030109     C                   ENDIF
024800030306    ***
024900030429     C                   EVAL      %SUBST(P@30:1:3)  = O_SUPER
025000030429     C                   EVAL      %SUBST(P@30:4:3)  = O_AGENCY
025100030429     C                   EVAL      %SUBST(P@30:7:8)  = %EDITC(SXEFFDTE:'X')
025200030429     C                   EVAL      %SUBST(P@30:15:8) = %EDITC(SXTRMDTE:'X')
025300030429     C                   EVAL      %SUBST(P@30:23:8) = O_ASID
025400030109    ***
025500030109     C                   ENDSR
025600030109   S***S
025700030109     C     $VALID        BEGSR
025800030109    ***
025900030109     C                   EVAL      @VP = 'N'
026000030109    ***
026100030109     C                   IF        I_BEGDT = 0
026200030109     C                   EVAL      @EMSG = 'EFFECTIVE DATE CANNOT BE ZERO'
026300030109     C                   LEAVESR
026400030109     C                   ENDIF
026500030109    ***
026600030109     C                   IF        I_BEGDT > 0
026700030109     C     *USA          TEST(DE)                I_BEGDT
026800030109     C                   IF        %ERROR
026900030109     C                   EVAL      @EMSG = 'EFFECTIVE DATE IS INVALID'
027000030109     C                   LEAVESR
027100030109     C                   ENDIF
027200030109     C                   ENDIF
027300030109    ***
027400030109     C                   IF        I_ENDDT > 0
027500030109     C     *USA          TEST(DE)                I_ENDDT
027600030109     C                   IF        %ERROR
027700030109     C                   EVAL      @EMSG = 'TERMINATION DATE IS INVALID'
027800030109     C                   LEAVESR
027900030109     C                   ENDIF
028000030109     C                   ENDIF
028100030109    ***
028200030109     C                   EVAL      @VP = 'Y'
028300030109    ***
028400030109     C                   ENDSR
028500030109   S***S
