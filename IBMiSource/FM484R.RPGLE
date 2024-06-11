000100030109     F*-------------------------------------------------------------------------
000200030303     F* FM484      GBS/IO SOFTWARE 2003
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
001900030109     **                                                                   **
002000030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030303     FSMANRLT   IF   E           K DISK    RENAME(SRF:RSEQ)
002200030224     FSMANRLT1  IF   E           K DISK    RENAME(SRF:SSEQ)
002300030110     FSUPRAGCY  IF   E           K DISK
002400030224     FAGENCY    IF   E           K DISK
002500030224     FSMAN      IF   E           K DISK
002600030307     FSPRAGXR2  IF   E           K DISK
002700030303     FFM484D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
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
010300030303     C     $GETSNAME     BEGSR
010400030303    ***
010500030313     C                   CLEAR                   A@20
010600030303     C                   CLEAR                   A@40
010700030303    ***
010800030303     C                   IF        SFNAME <> *BLANKS
010900030313     C                   MOVEL     SFNAME        A@20
011000030303     C                   EXSR      $LDADDR
011100030303     C                   ENDIF
011200030303    ***
011300030303     C                   IF        SMI <> *BLANKS
011400030313     C                   MOVEL     SMI           A@20
011500030303     C                   EXSR      $LDADDR
011600030303     C                   ENDIF
011700030303    ***
011800030303     C                   IF        SLNAME <> *BLANKS
011900030313     C                   MOVEL     SLNAME        A@20
012000030303     C                   EXSR      $LDADDR
012100030303     C                   ENDIF
012200030303    ***
012300030303     C                   ENDSR
012400030303   S***S
012500030303     C     $LDADDR       BEGSR
012600030303    ***
012700030313     C                   EVAL      A@20 = %TRIM(A@20)
012800030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
012900030313     C                   CLEAR                   A@20
013000030303    ***
013100030303     C                   ENDSR
013200030303   S***S
013300030109     C     $BUILDSFL     BEGSR
013400030109    ***
013500030109     C                   MOVE      *ZEROS        RRT
013600030109     C                   MOVE      *ZEROS        #CNTREC
013700030109    ***
013800030109     C                   MOVEA     '011'         *IN(25)
013900030109     C                   WRITE     WDWCTL
014000030109     C                   MOVEA     '010'         *IN(25)
014100030109    ***
014200030224     C                   IF        I_SMAN <> *BLANKS
014300030224    *C*
014400030307     C     I_SMAN        SETLL     SSEQ
014500030507     C                   DOU       %EOF(SMANRLT1) OR #CNTREC = 36
014600030224     C                   READ      SSEQ
014700030224     C                   IF        NOT %EOF(SMANRLT1)
014800030224     C                   EXSR      $LOADSFL
014900030224     C                   ENDIF
015000030224     C                   ENDDO
015100030224    *C*
015200030224     C                   ELSE
015300030224    *C*
015400030224     C     I_RELID       SETLL     RSEQ
015500030507     C                   DOU       %EOF(SMANRLT) OR #CNTREC = 36
015600030224     C                   READ      RSEQ
015700030224     C                   IF        NOT %EOF(SMANRLT)
015800030224     C                   EXSR      $LOADSFL
015900030224     C                   ENDIF
016000030224     C                   ENDDO
016100030224    *C*
016200030224     C                   ENDIF
016300030109    ***
016400030303     C                   IF        RRT > 9
016500030109     C                   EVAL      *IN91 = *ON
016600030109     C                   ENDIF
016700030303    ***
016800030303     C                   EXSR      $CLRCTL
016900030109    ***
017000030109     C                   ENDSR
017100030109   S***S
017200030109     C     $LOADSFL      BEGSR
017300030109    ***
017400030109     C                   MOVE      *ON           *IN25
017500030109     C                   ADD       1             RRT
017600030109     C                   IF        RRT = 1
017700030109     C                   Z-ADD     RRT           SFLPOS
017800030109     C                   ENDIF
017900030224    ***
018000030109     C                   MOVE      *BLANKS       SEL
018100030224     C                   EVAL      S_SMAN = SRSMAN
018200030307    ***
018300030307     C     SRASID        CHAIN     SXF
018400030307     C                   IF        %FOUND(SPRAGXR2)
018500030307     C                   EVAL      S_AGCY = SXAGCY
018600030307     C                   EVAL      S_SUPER = SXSUPER
018700030307     C                   ELSE
018800030307     C                   EVAL      S_AGCY = *BLANKS
018900030307     C                   EVAL      S_SUPER = *BLANKS
019000030307     C                   ENDIF
019100030307    ***
019200030303     C                   EVAL      I_RELID = SRRELID
019300030303    ***
019400030224     C     SRSMAN        CHAIN     SMANR
019500030224     C                   IF        %FOUND(SMAN)
019600030224     C                   EXSR      $GETSNAME
019700030303     C                   MOVEL(P)  A@40          D_SMAN
019800030224     C                   ELSE
019900030224     C                   EVAL      D_SMAN = '*UNKNOWN'
020000030224     C                   ENDIF
020100030224    ***
020200030110     C                   CLEAR                   HLDREC
020300030307     C                   EVAL      HLDREC = @SMN35
020400030110    ***
020500030307     C     S_SUPER       CHAIN     SAF
020600030303     C                   IF        %FOUND(SUPRAGCY)
020700030303     C                   MOVEL(P)  SANAME1       D_SUPER
020800030303     C                   ELSE
020900030303     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
021000030303     C                   ENDIF
021100030110    ***
021200030307     C     S_AGCY        CHAIN     AGENR
021300030303     C                   IF        %FOUND(AGENCY)
021400030303     C                   MOVEL(P)  AGNAM1        D_AGCY
021500030303     C                   ELSE
021600030303     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
021700030303     C                   ENDIF
021800030303    ***
021900030303     C                   MOVE      SREFFDTE      #XSX
022000030303     C                   EXSR      $ISOUSA
022100030303     C                   Z-ADD     #XSX          S_EFFDTE
022200030303    ***
022300030303     C                   MOVE      SRTRMDTE      #XSX
022400030303     C                   EXSR      $ISOUSA
022500030303     C                   Z-ADD     #XSX          S_TRMDTE
022600030303    ***
022700030109     C                   WRITE     POPUP
022800030109     C                   ADD       1             #CNTREC
022900030109    ***
023000030109     C                   ENDSR
023100030109   S***S
023200030303     C     $ISOUSA       BEGSR
023300030303    ***
023400030303     C                   IF        #XSX = 0
023500030303     C                   LEAVESR
023600030303     C                   ENDIF
023700030303     C                   MOVE      #XSX          #ISO
023800030303     C                   MOVE      #ISO          #USA
023900030303     C                   MOVE      #USA          #XSX
024000030303    ***
024100030303     C                   ENDSR
024200030303   S***S
024300030109     C     $STEP1        BEGSR
024400030109    ***
024500030109     C                   WRITE     JUNK
024600030109     C                   EXFMT     WDWCTL
024700030109    ***
024800030109     C                   IF        FKEY = F1
024900030307     C                   MOVEL(P)  '*LR'         P@35
025000030109     C                   EVAL      @STEP = 'LEAVE'
025100030109     C                   LEAVESR
025200030109     C                   ENDIF
025300030109    ***
025400030303     C                   IF        I_SMAN <> *BLANKS OR I_RELID <> *BLANKS
025500030109     C                   EXSR      $BUILDSFL
025600030109     C                   LEAVESR
025700030110     C                   ENDIF
025800030109    ***
025900030109     C                   EXSR      $CHKSEL
026000030109    ***
026100030109     C                   ENDSR
026200030109   S***S
026300030109     C     $CHKSEL       BEGSR
026400030109    ***
026500030109     C                   MOVE      *OFF          *IN99
026600030109    ***
026700030109     C                   DOU       *IN99 = *ON
026800030109     C                   READC     POPUP                                  99
026900030109     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
027000030109    ***
027100030109     C                   MOVE      *ON           *IN99
027200030307     C                   EVAL      P@35 = HLDREC
027300030109     C                   EVAL      @STEP = 'LEAVE'
027400030109    ***
027500030109     C                   ENDIF
027600030109     C                   ENDDO
027700030109     C*
027800030109     C                   ENDSR
027900030109   S***S
