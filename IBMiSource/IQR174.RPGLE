000100030109     F*-------------------------------------------------------------------------
000200040708     F* IQR174     GBS/IO SOFTWARE 2003
000300030224     F*            FM48* SALESMAN RELATIONSHIP APPLICATION
000400030224     F*                  SUPER AGENCY ENCHANCMENT PROJECT
000500030109     F*            WRITTEN BY - S.S.K.
000600030224     F*            DATE - 02/03
000700030303     F*  DESCRIPTION - DISPLAY SALESMAN RELATIONSHIP RECORDS FOR ANY SMAN
000800030109     F*  INDICATOR USAGE:
000900030109     F*    01 = EXIT FROM INITIAL SCREEN
001000030109     F*    25 = SFLDSP
001100030109     F*    26 = SFL DSP CTL
001200030109     F*    27 = SFL CLR
001300030109     F*
001400030109     F*
001500030109     F*-------------------------------------------------------------------------
001600030109     ** MODIFICATION HISTORY                                              **
001700030109     ** ###  UUU  MMDDCCYY  X---->                                        **
001800030303     ** 000  SSK  03032003  ORIGINAL SOURCE                               **
001900040708     ** ***  SSK  01052004  COPY FM484R TO IQ                             **
002000030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030303     FSMANRLT   IF   E           K DISK    RENAME(SRF:RSEQ)
002200030224     FSMANRLT1  IF   E           K DISK    RENAME(SRF:SSEQ)
002300030110     FSUPRAGCY  IF   E           K DISK
002400030224     FAGENCY    IF   E           K DISK
002500030224     FSMAN      IF   E           K DISK
002600030307     FSPRAGXR2  IF   E           K DISK
002700040708     FIQR174D   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002800030109   X***X
002900030109    ***
003000030109     D WSDS            DS
003100030109     D  FKEY                 369    369A
003200030109    ***
003300030109     D  F1             C                   CONST(X'31')
003400030109     D  F2             C                   CONST(X'32')
003500030109     D  F3             C                   CONST(X'33')
003600030109     D  F4             C                   CONST(X'34')
003700030109     D  F5             C                   CONST(X'35')
003800030109     D  F6             C                   CONST(X'36')
003900030109     D  F7             C                   CONST(X'37')
004000030109     D  F8             C                   CONST(X'38')
004100030109     D  F9             C                   CONST(X'39')
004200030109     D  F10            C                   CONST(X'3A')
004300030109     D  F11            C                   CONST(X'3B')
004400030109     D  F12            C                   CONST(X'3C')
004500030109     D  F13            C                   CONST(X'B1')
004600030109     D  F14            C                   CONST(X'B2')
004700030109     D  F15            C                   CONST(X'B3')
004800030109     D  F16            C                   CONST(X'B4')
004900030109     D  F17            C                   CONST(X'B5')
005000030109     D  F18            C                   CONST(X'B6')
005100030109     D  F19            C                   CONST(X'B7')
005200030109     D  F20            C                   CONST(X'B8')
005300030109     D  F21            C                   CONST(X'B9')
005400030109     D  F22            C                   CONST(X'BA')
005500030109     D  F23            C                   CONST(X'BB')
005600030109     D  F24            C                   CONST(X'BC')
005700030109    ***
005800030307     D @SMN35        E DS                  EXTNAME(SMANRLT)
005900030303     D #ISO            S               D   DATFMT(*ISO)
006000030303     D #USA            S               D   DATFMT(*USA)
006100030303     D #XSX            S              8S 0
006200030303     D @STEP           S              5A
006300030307     D P@35            S             35A
006400030303     D RRT             S              4S 0
006500030303     D #CNTREC         S              4S 0
006600030313     D A@20            S             20A
006700030303     D A@40            S             40A
006800030109   X***X
006900030109     C* MAINLINE
007000030109    ***
007100030109     C                   DOU       @STEP = 'LEAVE'
007200030109     C     @STEP         CASEQ     'PREP1'       $PREP1
007300030109     C     @STEP         CASEQ     'STEP1'       $STEP1
007400030109     C                   ENDCS
007500030109     C                   ENDDO
007600030109     C                   EVAL      *INLR = *ON
007700030109   S***S
007800030109     C     *INZSR        BEGSR
007900030109    ***
008000030109     C     *ENTRY        PLIST
008100030307     C                   PARM                    P@35
008200030109    ***
008300030109     C                   EVAL      @STEP = 'PREP1'
008400030224     C                   EXSR      $CLRCTL
008500030110    ***
008600030224     C                   ENDSR
008700030224   S***S
008800030224     C     $CLRCTL       BEGSR
008900030224    ***
009000030224     C                   MOVE      *BLANKS       I_SMAN
009100030224     C                   MOVE      *BLANKS       I_RELID
009200030109    ***
009300030109     C                   ENDSR
009400030109   S***S
009500030109     C     $PREP1        BEGSR
009600030109    ***
009700030224     C                   MOVE      '  *'         I_SMAN
009800030109     C                   EXSR      $BUILDSFL
009900030109     C                   EVAL      @STEP = 'STEP1'
010000030109    ***
010100030109     C                   ENDSR
010200030109   S***S
010300040708     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
010400030303   S***S
010500030109     C     $BUILDSFL     BEGSR
010600030109    ***
010700030109     C                   MOVE      *ZEROS        RRT
010800030109     C                   MOVE      *ZEROS        #CNTREC
010900030109    ***
011000030109     C                   MOVEA     '011'         *IN(25)
011100030109     C                   WRITE     WDWCTL
011200030109     C                   MOVEA     '010'         *IN(25)
011300030109    ***
011400030224     C                   IF        I_SMAN <> *BLANKS
011500030224    *C*
011600030307     C     I_SMAN        SETLL     SSEQ
011700030507     C                   DOU       %EOF(SMANRLT1) OR #CNTREC = 36
011800030224     C                   READ      SSEQ
011900030224     C                   IF        NOT %EOF(SMANRLT1)
012000030224     C                   EXSR      $LOADSFL
012100030224     C                   ENDIF
012200030224     C                   ENDDO
012300030224    *C*
012400030224     C                   ELSE
012500030224    *C*
012600030224     C     I_RELID       SETLL     RSEQ
012700030507     C                   DOU       %EOF(SMANRLT) OR #CNTREC = 36
012800030224     C                   READ      RSEQ
012900030224     C                   IF        NOT %EOF(SMANRLT)
013000030224     C                   EXSR      $LOADSFL
013100030224     C                   ENDIF
013200030224     C                   ENDDO
013300030224    *C*
013400030224     C                   ENDIF
013500030109    ***
013600030303     C                   IF        RRT > 9
013700030109     C                   EVAL      *IN91 = *ON
013800030109     C                   ENDIF
013900030303    ***
014000030303     C                   EXSR      $CLRCTL
014100030109    ***
014200030109     C                   ENDSR
014300030109   S***S
014400030109     C     $LOADSFL      BEGSR
014500030109    ***
014600030109     C                   MOVE      *ON           *IN25
014700030109     C                   ADD       1             RRT
014800030109     C                   IF        RRT = 1
014900030109     C                   Z-ADD     RRT           SFLPOS
015000030109     C                   ENDIF
015100030224    ***
015200030109     C                   MOVE      *BLANKS       SEL
015300030224     C                   EVAL      S_SMAN = SRSMAN
015400030307    ***
015500030307     C     SRASID        CHAIN     SXF
015600030307     C                   IF        %FOUND(SPRAGXR2)
015700030307     C                   EVAL      S_AGCY = SXAGCY
015800030307     C                   EVAL      S_SUPER = SXSUPER
015900030307     C                   ELSE
016000030307     C                   EVAL      S_AGCY = *BLANKS
016100030307     C                   EVAL      S_SUPER = *BLANKS
016200030307     C                   ENDIF
016300030307    ***
016400030303     C                   EVAL      I_RELID = SRRELID
016500030303    ***
016600030224     C     SRSMAN        CHAIN     SMANR
016700030224     C                   IF        %FOUND(SMAN)
016800030224     C                   EXSR      $GETSNAME
016900030303     C                   MOVEL(P)  A@40          D_SMAN
017000030224     C                   ELSE
017100030224     C                   EVAL      D_SMAN = '*UNKNOWN'
017200030224     C                   ENDIF
017300030224    ***
017400030110     C                   CLEAR                   HLDREC
017500030307     C                   EVAL      HLDREC = @SMN35
017600030110    ***
017700030307     C     S_SUPER       CHAIN     SAF
017800030303     C                   IF        %FOUND(SUPRAGCY)
017900030303     C                   MOVEL(P)  SANAME1       D_SUPER
018000030303     C                   ELSE
018100030303     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
018200030303     C                   ENDIF
018300030110    ***
018400030307     C     S_AGCY        CHAIN     AGENR
018500030303     C                   IF        %FOUND(AGENCY)
018600030303     C                   MOVEL(P)  AGNAM1        D_AGCY
018700030303     C                   ELSE
018800030303     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
018900030303     C                   ENDIF
019000030303    ***
019100030303     C                   MOVE      SREFFDTE      #XSX
019200030303     C                   EXSR      $ISOUSA
019300030303     C                   Z-ADD     #XSX          S_EFFDTE
019400030303    ***
019500030303     C                   MOVE      SRTRMDTE      #XSX
019600030303     C                   EXSR      $ISOUSA
019700030303     C                   Z-ADD     #XSX          S_TRMDTE
019800030303    ***
019900030109     C                   WRITE     POPUP
020000030109     C                   ADD       1             #CNTREC
020100030109    ***
020200030109     C                   ENDSR
020300030109   S***S
020400030303     C     $ISOUSA       BEGSR
020500030303    ***
020600030303     C                   IF        #XSX = 0
020700030303     C                   LEAVESR
020800030303     C                   ENDIF
020900030303     C                   MOVE      #XSX          #ISO
021000030303     C                   MOVE      #ISO          #USA
021100030303     C                   MOVE      #USA          #XSX
021200030303    ***
021300030303     C                   ENDSR
021400030303   S***S
021500030109     C     $STEP1        BEGSR
021600030109    ***
021700030109     C                   WRITE     JUNK
021800030109     C                   EXFMT     WDWCTL
021900030109    ***
022000030109     C                   IF        FKEY = F1
022100030307     C                   MOVEL(P)  '*LR'         P@35
022200030109     C                   EVAL      @STEP = 'LEAVE'
022300030109     C                   LEAVESR
022400030109     C                   ENDIF
022500030109    ***
022600030303     C                   IF        I_SMAN <> *BLANKS OR I_RELID <> *BLANKS
022700030109     C                   EXSR      $BUILDSFL
022800030109     C                   LEAVESR
022900030110     C                   ENDIF
023000030109    ***
023100030109     C                   EXSR      $CHKSEL
023200030109    ***
023300030109     C                   ENDSR
023400030109   S***S
023500030109     C     $CHKSEL       BEGSR
023600030109    ***
023700030109     C                   MOVE      *OFF          *IN99
023800030109    ***
023900030109     C                   DOU       *IN99 = *ON
024000030109     C                   READC     POPUP                                  99
024100030109     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
024200030109    ***
024300030109     C                   MOVE      *ON           *IN99
024400030307     C                   EVAL      P@35 = HLDREC
024500030109     C                   EVAL      @STEP = 'LEAVE'
024600030109    ***
024700030109     C                   ENDIF
024800030109     C                   ENDDO
024900030109     C*
025000030109     C                   ENDSR
025100030109   S***S
