000100030109     F*-------------------------------------------------------------------------
000200040708     F* IQR175     GBS/IO SOFTWARE 2003
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
001900040708     ** ***  SSK  02272004  COPY FM484R TO IQ                             **
002000030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030303     FSMANRLT   IF   E           K DISK    RENAME(SRF:RSEQ)
002200030224     FSMANRLT1  IF   E           K DISK    RENAME(SRF:SSEQ)
002300030224     FAGENCY    IF   E           K DISK
002400030224     FSMAN      IF   E           K DISK
002500030307     FSPRAGXR2  IF   E           K DISK
002600040708     FIQR175D   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002700030109   X***X
002800030109    ***
002900030109     D WSDS            DS
003000030109     D  FKEY                 369    369A
003100030109    ***
003200030109     D  F1             C                   CONST(X'31')
003300030109     D  F2             C                   CONST(X'32')
003400030109     D  F3             C                   CONST(X'33')
003500030109     D  F4             C                   CONST(X'34')
003600030109     D  F5             C                   CONST(X'35')
003700030109     D  F6             C                   CONST(X'36')
003800030109     D  F7             C                   CONST(X'37')
003900030109     D  F8             C                   CONST(X'38')
004000030109     D  F9             C                   CONST(X'39')
004100030109     D  F10            C                   CONST(X'3A')
004200030109     D  F11            C                   CONST(X'3B')
004300030109     D  F12            C                   CONST(X'3C')
004400030109     D  F13            C                   CONST(X'B1')
004500030109     D  F14            C                   CONST(X'B2')
004600030109     D  F15            C                   CONST(X'B3')
004700030109     D  F16            C                   CONST(X'B4')
004800030109     D  F17            C                   CONST(X'B5')
004900030109     D  F18            C                   CONST(X'B6')
005000030109     D  F19            C                   CONST(X'B7')
005100030109     D  F20            C                   CONST(X'B8')
005200030109     D  F21            C                   CONST(X'B9')
005300030109     D  F22            C                   CONST(X'BA')
005400030109     D  F23            C                   CONST(X'BB')
005500030109     D  F24            C                   CONST(X'BC')
005600030109    ***
005700030307     D @SMN35        E DS                  EXTNAME(SMANRLT)
005800030303     D #ISO            S               D   DATFMT(*ISO)
005900030303     D #USA            S               D   DATFMT(*USA)
006000030303     D #XSX            S              8S 0
006100030303     D @STEP           S              5A
006200030307     D P@35            S             35A
006300030303     D RRT             S              4S 0
006400030303     D #CNTREC         S              4S 0
006500030313     D A@20            S             20A
006600030303     D A@40            S             40A
006700030109   X***X
006800030109     C* MAINLINE
006900030109    ***
007000030109     C                   DOU       @STEP = 'LEAVE'
007100030109     C     @STEP         CASEQ     'PREP1'       $PREP1
007200030109     C     @STEP         CASEQ     'STEP1'       $STEP1
007300030109     C                   ENDCS
007400030109     C                   ENDDO
007500030109     C                   EVAL      *INLR = *ON
007600030109   S***S
007700030109     C     *INZSR        BEGSR
007800030109    ***
007900030109     C     *ENTRY        PLIST
008000030307     C                   PARM                    P@35
008100030109    ***
008200030109     C                   EVAL      @STEP = 'PREP1'
008300030224     C                   EXSR      $CLRCTL
008400030110    ***
008500030224     C                   ENDSR
008600030224   S***S
008700030224     C     $CLRCTL       BEGSR
008800030224    ***
008900030224     C                   MOVE      *BLANKS       I_SMAN
009000030224     C                   MOVE      *BLANKS       I_RELID
009100030109    ***
009200030109     C                   ENDSR
009300030109   S***S
009400030109     C     $PREP1        BEGSR
009500030109    ***
009600030224     C                   MOVE      '  *'         I_SMAN
009700030109     C                   EXSR      $BUILDSFL
009800030109     C                   EVAL      @STEP = 'STEP1'
009900030109    ***
010000030109     C                   ENDSR
010100030109   S***S
010200040622     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
010300030303   S***S
010400030109     C     $BUILDSFL     BEGSR
010500030109    ***
010600030109     C                   MOVE      *ZEROS        RRT
010700030109     C                   MOVE      *ZEROS        #CNTREC
010800030109    ***
010900030109     C                   MOVEA     '011'         *IN(25)
011000030109     C                   WRITE     WDWCTL
011100030109     C                   MOVEA     '010'         *IN(25)
011200030109    ***
011300030224     C                   IF        I_SMAN <> *BLANKS
011400030224    *C*
011500030307     C     I_SMAN        SETLL     SSEQ
011600030507     C                   DOU       %EOF(SMANRLT1) OR #CNTREC = 36
011700030224     C                   READ      SSEQ
011800030224     C                   IF        NOT %EOF(SMANRLT1)
011900030224     C                   EXSR      $LOADSFL
012000030224     C                   ENDIF
012100030224     C                   ENDDO
012200030224    *C*
012300030224     C                   ELSE
012400030224    *C*
012500030224     C     I_RELID       SETLL     RSEQ
012600030507     C                   DOU       %EOF(SMANRLT) OR #CNTREC = 36
012700030224     C                   READ      RSEQ
012800030224     C                   IF        NOT %EOF(SMANRLT)
012900030224     C                   EXSR      $LOADSFL
013000030224     C                   ENDIF
013100030224     C                   ENDDO
013200030224    *C*
013300030224     C                   ENDIF
013400030109    ***
013500030303     C                   IF        RRT > 9
013600030109     C                   EVAL      *IN91 = *ON
013700030109     C                   ENDIF
013800030303    ***
013900030303     C                   EXSR      $CLRCTL
014000030109    ***
014100030109     C                   ENDSR
014200030109   S***S
014300030109     C     $LOADSFL      BEGSR
014400030109    ***
014500030109     C                   MOVE      *ON           *IN25
014600030109     C                   ADD       1             RRT
014700030109     C                   IF        RRT = 1
014800030109     C                   Z-ADD     RRT           SFLPOS
014900030109     C                   ENDIF
015000030224    ***
015100030109     C                   MOVE      *BLANKS       SEL
015200030224     C                   EVAL      S_SMAN = SRSMAN
015300040227     C                   EVAL      S_RELID = SRRELID
015400040227     C                   EVAL      I_RELID = SRRELID
015500030307    ***
015600030307     C     SRASID        CHAIN     SXF
015700030307     C                   IF        %FOUND(SPRAGXR2)
015800030307     C                   EVAL      S_AGCY = SXAGCY
015900030307     C                   EVAL      S_SUPER = SXSUPER
016000030307     C                   ELSE
016100030307     C                   EVAL      S_AGCY = *BLANKS
016200030307     C                   EVAL      S_SUPER = *BLANKS
016300030307     C                   ENDIF
016400030307    ***
016500030224     C     SRSMAN        CHAIN     SMANR
016600030224     C                   IF        %FOUND(SMAN)
016700030224     C                   EXSR      $GETSNAME
016800030303     C                   MOVEL(P)  A@40          D_SMAN
016900030224     C                   ELSE
017000030224     C                   EVAL      D_SMAN = '*UNKNOWN'
017100030224     C                   ENDIF
017200030224    ***
017300030110     C                   CLEAR                   HLDREC
017400030307     C                   EVAL      HLDREC = @SMN35
017500030110    ***
017600030307     C     S_AGCY        CHAIN     AGENR
017700030303     C                   IF        %FOUND(AGENCY)
017800030303     C                   MOVEL(P)  AGNAM1        D_AGCY
017900030303     C                   ELSE
018000030303     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
018100030303     C                   ENDIF
018200030303    ***
018300030303     C                   MOVE      SREFFDTE      #XSX
018400030303     C                   EXSR      $ISOUSA
018500030303     C                   Z-ADD     #XSX          S_EFFDTE
018600030303    ***
018700030303     C                   MOVE      SRTRMDTE      #XSX
018800030303     C                   EXSR      $ISOUSA
018900030303     C                   Z-ADD     #XSX          S_TRMDTE
019000030303    ***
019100030109     C                   WRITE     POPUP
019200030109     C                   ADD       1             #CNTREC
019300030109    ***
019400030109     C                   ENDSR
019500030109   S***S
019600030303     C     $ISOUSA       BEGSR
019700030303    ***
019800030303     C                   IF        #XSX = 0
019900030303     C                   LEAVESR
020000030303     C                   ENDIF
020100030303     C                   MOVE      #XSX          #ISO
020200030303     C                   MOVE      #ISO          #USA
020300030303     C                   MOVE      #USA          #XSX
020400030303    ***
020500030303     C                   ENDSR
020600030303   S***S
020700030109     C     $STEP1        BEGSR
020800030109    ***
020900030109     C                   WRITE     JUNK
021000030109     C                   EXFMT     WDWCTL
021100030109    ***
021200030109     C                   IF        FKEY = F1
021300030307     C                   MOVEL(P)  '*LR'         P@35
021400030109     C                   EVAL      @STEP = 'LEAVE'
021500030109     C                   LEAVESR
021600030109     C                   ENDIF
021700030109    ***
021800030303     C                   IF        I_SMAN <> *BLANKS OR I_RELID <> *BLANKS
021900030109     C                   EXSR      $BUILDSFL
022000030109     C                   LEAVESR
022100030110     C                   ENDIF
022200030109    ***
022300030109     C                   EXSR      $CHKSEL
022400030109    ***
022500030109     C                   ENDSR
022600030109   S***S
022700030109     C     $CHKSEL       BEGSR
022800030109    ***
022900030109     C                   MOVE      *OFF          *IN99
023000030109    ***
023100030109     C                   DOU       *IN99 = *ON
023200030109     C                   READC     POPUP                                  99
023300030109     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
023400030109    ***
023500030109     C                   MOVE      *ON           *IN99
023600030307     C                   EVAL      P@35 = HLDREC
023700030109     C                   EVAL      @STEP = 'LEAVE'
023800030109    ***
023900030109     C                   ENDIF
024000030109     C                   ENDDO
024100030109     C*
024200030109     C                   ENDSR
024300030109   S***S
