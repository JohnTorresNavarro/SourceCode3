000100030109     F*-------------------------------------------------------------------------
000200040708     F* IQR160    GBS/IO SOFTWARE 2003
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
001700040708     ** ***  SSK  01022004  COPY FM470 TO IQ                              **
001800030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900040708     FIQR160D   CF   E             WORKSTN INFDS(WSDS)
002000040102     FSPRAGXRF  IF   E           K DISK
002100030110     FAGENCY    IF   E           K DISK
002200030110     FSUPRAGCY  IF   E           K DISK
002300030109   X***X
002400030109     D WSDS            DS
002500030109     D  FKEY                 369    369A
002600030109    ***
002700030109     D  F1             C                   CONST(X'31')
002800030109     D  F2             C                   CONST(X'32')
002900030109     D  F3             C                   CONST(X'33')
003000030109     D  F4             C                   CONST(X'34')
003100030109     D  F5             C                   CONST(X'35')
003200030109     D  F6             C                   CONST(X'36')
003300030109     D  F7             C                   CONST(X'37')
003400030109     D  F8             C                   CONST(X'38')
003500030109     D  F9             C                   CONST(X'39')
003600030109     D  F10            C                   CONST(X'3A')
003700030109     D  F11            C                   CONST(X'3B')
003800030109     D  F12            C                   CONST(X'3C')
003900030109     D  F13            C                   CONST(X'B1')
004000030109     D  F14            C                   CONST(X'B2')
004100030109     D  F15            C                   CONST(X'B3')
004200030109     D  F16            C                   CONST(X'B4')
004300030109     D  F17            C                   CONST(X'B5')
004400030109     D  F18            C                   CONST(X'B6')
004500030109     D  F19            C                   CONST(X'B7')
004600030109     D  F20            C                   CONST(X'B8')
004700030109     D  F21            C                   CONST(X'B9')
004800030109     D  F22            C                   CONST(X'BA')
004900030109     D  F23            C                   CONST(X'BB')
005000030109     D  F24            C                   CONST(X'BC')
005100030109    ***
005200030306     D #SEQ            S              8S 0
005300030109     D #TDAY           S              8S 0
005400030109     D #ISO            S               D   DATFMT(*ISO)
005500030109     D #USA            S               D   DATFMT(*USA)
005600030109     D @VP             S              1A
005700030109    ***
005800030109     D @IM             S              1A
005900030109     D @STEP           S              5A
006000030429     D P@30            S             30A
006100030429     D KEY@SUPER       S              3A
006200030110     D KEY@AGCY        S              3A
006300030110     D KEY@EFFDTE      S              8S 0
006400030110     D KEY@TRMDTE      S              8S 0
006500030109    ***
006600030109     D @EMSG           S             70A
006700030110     D @8              S              8A
006800030110     D #8              S              8S 0
006900030109   X***X
007000030109    1C                   DOU       @STEP = 'LEAVE'
007100030109    2C     @STEP         CASEQ     'PREP1'       $PREP1
007200030109    2C     @STEP         CASEQ     'STEP1'       $STEP1
007300030109    2C                   ENDCS
007400030109    1C                   ENDDO
007500030109    ***
007600030109     C                   MOVE      *ON           *INLR
007700030109   S***S
007800030109     C     *INZSR        BEGSR
007900030109    ***
008000030109     C     *ENTRY        PLIST
008100030429     C                   PARM                    P@30
008200030109    ***
008300030110     C     KEY#SXF       KLIST
008400030110     C                   KFLD                    KEY@SUPER
008500030110     C                   KFLD                    KEY@AGCY
008600030110     C                   KFLD                    KEY@EFFDTE
008700030110     C                   KFLD                    KEY@TRMDTE
008800030110    ***
008900030109     C                   CLEAR                   IO01
009000030110     C                   CLEAR                   SXF
009100030306     C*
009200030429     C                   EVAL      O_SUPER = %SUBST(P@30:1:3)
009300030429     C                   EVAL      O_AGENCY = %SUBST(P@30:4:3)
009400040102     C                   EVAL      @IM = 'I'
009500030110    ***
009600030109     C                   EVAL      @STEP = 'PREP1'
009700030109    ***
009800030109     C                   ENDSR
009900030109   S***S
010000030109     C     $PREP1        BEGSR
010100030109    ***
010200030110     C                   EVAL      @STEP = 'STEP1'
010300030110    ***
010400030225     C                   EVAL      *IN25 = *ON
010500030110     C                   MOVEL     O_SUPER       KEY@SUPER
010600030110     C                   MOVEL     O_AGENCY      KEY@AGCY
010700030110     C*
010800030429     C                   EVAL      @8 = %SUBST(P@30:7:8)
010900030110     C                   MOVE      @8            #8
011000030110     C                   MOVE      #8            KEY@EFFDTE
011100030110     C*
011200030429     C                   EVAL      @8 = %SUBST(P@30:15:8)
011300030110     C                   MOVE      @8            #8
011400030110     C                   MOVE      #8            KEY@TRMDTE
011500030306     C*
011600030429     C                   EVAL      O_ASID = %SUBST(P@30:23:8)
011700030110     C*
011800030110     C     KEY#SXF       CHAIN     SXF
011900030109    ***
012000030110     C     O_SUPER       CHAIN(N)  SAF
012100030110     C                   IF        %FOUND(SUPRAGCY)
012200030110     C                   MOVEL(P)  SANAME1       O_SUPRNAME
012300030110     C                   ELSE
012400030110     C                   MOVEL(P)  '*UNKNOWN'    O_SUPRNAME
012500030110     C                   ENDIF
012600030110    ***
012700030110     C     O_AGENCY      CHAIN(N)  AGENR
012800030110     C                   IF        %FOUND(AGENCY)
012900030110     C                   MOVEL(P)  AGNAM1        O_AGNAME1
013000030110     C                   ELSE
013100030110     C                   MOVEL(P)  '*UNKNOWN'    O_AGNAME1
013200030110     C                   ENDIF
013300030110    ***
013400030110     C                   IF        SXEFFDTE > 0
013500030110     C     SXEFFDTE      MULT      10000.0001    I_BEGDT
013600030109     C                   ELSE
013700030110     C                   Z-ADD     SXEFFDTE      I_BEGDT
013800030109     C                   ENDIF
013900030109    ***
014000030110     C                   IF        SXTRMDTE > 0
014100030110     C     SXTRMDTE      MULT      10000.0001    I_ENDDT
014200030109     C                   ELSE
014300030110     C                   Z-ADD     SXTRMDTE      I_ENDDT
014400030109     C                   ENDIF
014500030109    ***
014600030109     C                   ENDSR
014700030109   S***S
014800030109     C     $STEP1        BEGSR
014900030109    ***
015000030109     C                   MOVEL     @EMSG         EMSG
015100030109     C                   EXFMT     IO01
015200030109     C                   MOVE      *BLANKS       EMSG
015300030109     C                   MOVE      *BLANKS       @EMSG
015400030109    ***
015500030109    1C                   IF        FKEY = F7
015600030109     C                   EVAL      @STEP = 'LEAVE'
015700030429     C                   MOVEL(P)  'X'           P@30
015800030109     C                   LEAVESR
015900030109    1C                   ENDIF
016000030109    ***
016100030109    1C                   IF        FKEY = F1
016200030109     C                   EVAL      @STEP = 'LEAVE'
016300030429     C                   MOVE      *BLANKS       P@30
016400030109     C                   LEAVESR
016500030109    1C                   ENDIF
016600030109    ***
016700030109     C                   ENDSR
016800030109   S***S
