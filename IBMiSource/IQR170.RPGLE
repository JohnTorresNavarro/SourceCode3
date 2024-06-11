000100030213     F*-------------------------------------------------------------------------
000200040708     F* IQR170    GBS/IO SOFTWARE 2003
000300030213     F*           FM48* SUPER AGENCY ENCHANCMENT PROJECT
000400030213     F*           WRITTEN BY - S.S.K.
000500030213     F*           DATE - 02/03
000600030213     F*  DESCRIPTION - PROMPT
000700030213     F*  INDICATOR USAGE:
000800030213     F*    01 = EXIT FROM INITIAL SCREEN
000900030213     F*    25 = SFLDSP
001000030213     F*    26 = SFL DSP CTL
001100030213     F*    27 = SFL CLR
001200030213     F*
001300030213     F*-------------------------------------------------------------------------
001400030213     ** MODIFICATION HISTORY                                              **
001500030213     ** ###  UUU  MMDDCCYY  X---->                                        **
001600030213     ** 000  SSK  02132003  ORIGINAL SOURCE                               **
001700040708     ** ***  SSK  01052004  COPY FM480R TO IQ                             **
001800030213     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900040708     FIQR170D   CF   E             WORKSTN INFDS(WSDS)
002000030307     FSPRAGXR2  IF   E           K DISK
002100030213     FSMAN      IF   E           K DISK
002200030213     FAGENCY    IF   E           K DISK
002300030213     FSUPRAGCY  IF   E           K DISK
002400040105     FSMANRLT   IF   E           K DISK
002500030213   X***X
002600030213     D WSDS            DS
002700030213     D  FKEY                 369    369A
002800030227    ***
002900030213     D  F1             C                   CONST(X'31')
003000030213     D  F2             C                   CONST(X'32')
003100030213     D  F3             C                   CONST(X'33')
003200030213     D  F4             C                   CONST(X'34')
003300030213     D  F5             C                   CONST(X'35')
003400030213     D  F6             C                   CONST(X'36')
003500030213     D  F7             C                   CONST(X'37')
003600030213     D  F8             C                   CONST(X'38')
003700030213     D  F9             C                   CONST(X'39')
003800030213     D  F10            C                   CONST(X'3A')
003900030213     D  F11            C                   CONST(X'3B')
004000030213     D  F12            C                   CONST(X'3C')
004100030213     D  F13            C                   CONST(X'B1')
004200030213     D  F14            C                   CONST(X'B2')
004300030213     D  F15            C                   CONST(X'B3')
004400030213     D  F16            C                   CONST(X'B4')
004500030213     D  F17            C                   CONST(X'B5')
004600030213     D  F18            C                   CONST(X'B6')
004700030213     D  F19            C                   CONST(X'B7')
004800030213     D  F20            C                   CONST(X'B8')
004900030213     D  F21            C                   CONST(X'B9')
005000030213     D  F22            C                   CONST(X'BA')
005100030213     D  F23            C                   CONST(X'BB')
005200030213     D  F24            C                   CONST(X'BC')
005300030213    ***
005400030213     D #ISO            S               D   DATFMT(*ISO)
005500030214     D #SEQ            S              8S 0
005600030214     D #TDAY           S              8S 0
005700030213     D #USA            S               D   DATFMT(*USA)
005800030214     D #8              S              8S 0
005900030214     D #8BEG           S              8S 0
006000030214     D #8END           S              8S 0
006100030214     D #8S0            S              8S 0
006200030213    ***
006300030313     D A@20            S             20A
006400030214     D A@40            S             40A
006500030214     D KEY@RELID       S                   LIKE(SRRELID)
006600030306     D KEY@SUPER       S                   LIKE(SXSUPER)
006700030306     D KEY@AGCY        S                   LIKE(SXAGCY)
006800030214     D REC@DS        E DS                  EXTNAME(SMANRLT)
006900030214     D P@4             S              4A
007000030306     D P@35            S             35A
007100030213    ***
007200030214     D @DTA50          S             50A
007300030213     D @EMSG           S             70A
007400030214     D @IM             S              1A
007500030214     D @STEP           S              5A
007600030214     D @SXC            S              1A
007700030214     D @VP             S              1A
007800030214     D @VR             S              1A
007900030214     D @3              S              3A
008000030214     D @70M            S             70A
008100030213     D @8              S              8A
008200030214    ***
008300030213   X***X
008400030213    1C                   DOU       @STEP = 'LEAVE'
008500030213    2C     @STEP         CASEQ     'PREP1'       $PREP1
008600030213    2C     @STEP         CASEQ     'STEP1'       $STEP1
008700030213    2C                   ENDCS
008800030213    1C                   ENDDO
008900030213    ***
009000030213     C                   MOVE      *ON           *INLR
009100030213   S***S
009200030213     C     *INZSR        BEGSR
009300030213    ***
009400030213     C     *ENTRY        PLIST
009500030306     C                   PARM                    P@35
009600030213    ***
009700030213     C     KEY#SXF       KLIST
009800030213     C                   KFLD                    KEY@SUPER
009900030213     C                   KFLD                    KEY@AGCY
010000030213    ***
010100030213     C                   CLEAR                   IO01
010200030213     C                   CLEAR                   SRF
010300030213     C
010400030306     C                   IF        %SUBST(P@35:35:1) = 'A'
010500030213     C                   EVAL      @IM = 'A'
010600030213     C                   ELSE
010700030213     C                   EVAL      @IM = 'M'
010800030306     C                   EVAL      KEY@RELID = %SUBST(P@35:1:8)
010900030213     C                   ENDIF
011000030213    ***
011100030213     C                   EVAL      @STEP = 'PREP1'
011200030213    ***
011300030213     C                   MOVE      *DATE         #ISO
011400030213     C                   MOVE      #ISO          #TDAY
011500030213    ***
011600030213     C                   ENDSR
011700030213   S***S
011800030213     C     $PREP1        BEGSR
011900030213    ***
012000030213     C                   EVAL      @STEP = 'STEP1'
012100030213    ***
012200030213     C                   EVAL      *IN27 = *ON
012300030213     C     KEY@RELID     CHAIN     SRF
012400030307     C                   EXSR      $GETSMAN
012500030307     C                   EXSR      $GETLINK
012600030213    ***
012700030213     C                   IF        SREFFDTE > 0
012800030213     C     SREFFDTE      MULT      10000.0001    I_BEGDT
012900030213     C                   ELSE
013000030213     C                   Z-ADD     SREFFDTE      I_BEGDT
013100030213     C                   ENDIF
013200030213    ***
013300030213     C                   IF        SRTRMDTE > 0
013400030213     C     SRTRMDTE      MULT      10000.0001    I_ENDDT
013500030213     C                   ELSE
013600030213     C                   Z-ADD     SRTRMDTE      I_ENDDT
013700030213     C                   ENDIF
013800030213    ***
013900030213     C                   ENDSR
014000030213   S***S
014100030307     C     $GETSMAN      BEGSR
014200030307    ***
014300030307     C     SRSMAN        CHAIN(N)  SMANR
014400030307     C                   IF        %FOUND(SMAN)
014500030307     C                   EXSR      $GETSNAME
014600030307     C                   MOVEL(P)  A@40          O_SNAME
014700030307     C                   ELSE
014800030307     C                   MOVEL(P)  '*UNKNOWN'    O_SNAME
014900030307     C                   EVAL      @EMSG = 'INVALID SALESMAN CODE'
015000030307     C                   ENDIF
015100030307    ***
015200030307     C                   ENDSR
015300030307   S***S
015400030307     C     $GETLINK      BEGSR
015500030307    ***
015600030307     C     SRASID        CHAIN     SXF
015700030307     C                   IF        NOT %FOUND(SPRAGXR2)
015800030307     C                   MOVE      *BLANKS       SXAGCY
015900030307     C                   MOVE      *BLANKS       SXSUPER
016000030307     C                   ENDIF
016100030307    ***
016200030307     C                   EVAL      O_AGCY = SXAGCY
016300030307     C                   EVAL      O_SUPER = SXSUPER
016400030307    ***
016500030307     C     SXAGCY        CHAIN     AGENR
016600030307     C                   IF        %FOUND(AGENCY)
016700030307     C                   MOVEL(P)  AGNAM1        O_ANAME
016800030307     C                   ELSE
016900030307     C                   MOVEL(P)  '*UNKNOWN'    O_ANAME
017000030307     C                   ENDIF
017100030307    ***
017200030307     C     SXSUPER       CHAIN     SAF
017300030307     C                   IF        %FOUND(SUPRAGCY)
017400030307     C                   MOVEL(P)  SANAME1       O_SUPRNAME
017500030307     C                   ELSE
017600030307     C                   MOVEL(P)  '*UNKNOWN'    O_SUPRNAME
017700030307     C                   ENDIF
017800030307    ***
017900030307     C                   ENDSR
018000030307   S***S
018100040622     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
018200030214   S***S
018300030213     C     $STEP1        BEGSR
018400030213    ***
018500030213     C                   MOVEL     @EMSG         EMSG
018600030213     C                   EXFMT     IO01
018700030213     C                   MOVE      *BLANKS       EMSG
018800030213     C                   MOVE      *BLANKS       @EMSG
018900030213    ***
019000030213    1C                   IF        FKEY = F7
019100030213     C                   EVAL      @STEP = 'LEAVE'
019200030306     C                   MOVEL(P)  'X'           P@35
019300030213     C                   LEAVESR
019400030213    1C                   ENDIF
019500030213    ***
019600030213    1C                   IF        FKEY = F1
019700030213     C                   EVAL      @STEP = 'LEAVE'
019800030306     C                   MOVE      *BLANKS       P@35
019900030213     C                   LEAVESR
020000030213    1C                   ENDIF
020100030214    ***
020200030213    ***
020300030213     C                   ENDSR
020400030213   S***S
