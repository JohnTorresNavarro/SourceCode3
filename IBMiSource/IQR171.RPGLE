000100030227     F*-------------------------------------------------------------------------
000200040708     F* IQR171     GBS/IO SOFTWARE 2003
000300030227     F*            FM48* SALESMAN RELATIONSHIP APPLICATION
000400030227     F*                  SUPER AGENCY ENCHANCMENT PROJECT
000500030227     F*            WRITTEN BY - S.S.K.
000600030227     F*            DATE - 02/03
000700030227     F*  DESCRIPTION - SALESMAN RELATIONSHIP RECORDS
000800030227     F*                RESTRICTED TO A PARTICULAR SALESMAN
000900030227     F*  INDICATOR USAGE:
001000030227     F*    01 = EXIT FROM INITIAL SCREEN
001100030227     F*    25 = SFLDSP
001200030227     F*    26 = SFL DSP CTL
001300030227     F*    27 = SFL CLR
001400030227     F*
001500030227     F*-------------------------------------------------------------------------
001600030227     ** MODIFICATION HISTORY                                              **
001700030227     ** ###  UUU  MMDDCCYY  X---->                                        **
001800030227     ** 000  SSK  02272003  ORIGINAL SOURCE                               **
001900040708     ** ***  SSK  01052004  COPY FM481R TO IQ                             **
002000030227     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030228     FSMANRLT2  IF   E           K DISK    RENAME(SRF:RSEQ)
002200030227     FSMANRLT1  IF   E           K DISK    RENAME(SRF:SSEQ)
002300030227     FSUPRAGCY  IF   E           K DISK
002400030227     FAGENCY    IF   E           K DISK
002500030307     FSPRAGXR1  IF   E           K DISK    RENAME(SXF:ASAF)
002600030307     FSPRAGXR2  IF   E           K DISK    RENAME(SXF:LNKF)
002700030227     FSMAN      IF   E           K DISK
002800040708     FIQR171D   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002900030227   X***X
003000030227    ***
003100030227     D WSDS            DS
003200030227     D  FKEY                 369    369A
003300030227    ***
003400030227     D  F1             C                   CONST(X'31')
003500030227     D  F2             C                   CONST(X'32')
003600030227     D  F3             C                   CONST(X'33')
003700030227     D  F4             C                   CONST(X'34')
003800030227     D  F5             C                   CONST(X'35')
003900030227     D  F6             C                   CONST(X'36')
004000030227     D  F7             C                   CONST(X'37')
004100030227     D  F8             C                   CONST(X'38')
004200030227     D  F9             C                   CONST(X'39')
004300030227     D  F10            C                   CONST(X'3A')
004400030227     D  F11            C                   CONST(X'3B')
004500030227     D  F12            C                   CONST(X'3C')
004600030227     D  F13            C                   CONST(X'B1')
004700030227     D  F14            C                   CONST(X'B2')
004800030227     D  F15            C                   CONST(X'B3')
004900030227     D  F16            C                   CONST(X'B4')
005000030227     D  F17            C                   CONST(X'B5')
005100030227     D  F18            C                   CONST(X'B6')
005200030227     D  F19            C                   CONST(X'B7')
005300030227     D  F20            C                   CONST(X'B8')
005400030227     D  F21            C                   CONST(X'B9')
005500030227     D  F22            C                   CONST(X'BA')
005600030227     D  F23            C                   CONST(X'BB')
005700030227     D  F24            C                   CONST(X'BC')
005800030228    ***
005900030228     D #XSX            S              8S 0
006000030228     D #ISO            S               D   DATFMT(*ISO)
006100030228     D #USA            S               D   DATFMT(*USA)
006200030227    ***
006300030307     D @SMN35        E DS                  EXTNAME(SMANRLT)
006400030227     D @STEP           S              5A
006500030307     D P@35            S             35A
006600030227     D RRT             S              4S 0
006700030227     D #CNTREC         S              4S 0
006800030313     D A@20            S             20A
006900030228     D A@40            S             40A
007000030307     D KEY@AGCY        S                   LIKE(SXAGCY)
007100030307     D KEY@SUPER       S                   LIKE(SXSUPER)
007200030307     D KEY@ASID        S                   LIKE(SXASID)
007300030227   X***X
007400030227     C* MAINLINE
007500030227    ***
007600030227     C                   DOU       @STEP = 'LEAVE'
007700030227     C     @STEP         CASEQ     'PREP1'       $PREP1
007800030227     C     @STEP         CASEQ     'STEP1'       $STEP1
007900030227     C                   ENDCS
008000030227     C                   ENDDO
008100030227     C                   EVAL      *INLR = *ON
008200040708     C                   RETURN
008300030227   S***S
008400030227     C     *INZSR        BEGSR
008500030227    ***
008600030227     C     *ENTRY        PLIST
008700030307     C                   PARM                    P@35
008800030227    ***
008900030227     C                   EVAL      @STEP = 'PREP1'
009000030228     C                   MOVE      *BLANKS       I_SMAN
009100030228     C                   MOVE      *BLANKS       D_SMAN
009200030227     C                   EXSR      $CLRCTL
009300030228    ***
009400030307     C                   EVAL      I_SMAN = %SUBST(P@35:17:3)
009500030228     C     I_SMAN        CHAIN     SMANR
009600030228     C                   IF        %FOUND(SMAN)
009700030228     C                   EXSR      $GETSNAME
009800030228     C                   ELSE
009900030228     C                   EVAL      D_SMAN = '*UNKNOWN*'
010000030228     C                   ENDIF
010100030227    ***
010200030228     C     KEY#SR1       KLIST
010300030227     C                   KFLD                    I_SMAN
010400030307     C                   KFLD                    KEY@ASID
010500030228    ***
010600030228     C     KEY#SR2       KLIST
010700030228     C                   KFLD                    I_SMAN
010800030228     C                   KFLD                    I_RELID
010900030307    ***
011000030307     C     KEY#SXF       KLIST
011100030307     C                   KFLD                    KEY@AGCY
011200030307     C                   KFLD                    KEY@SUPER
011300030228    ***
011400030228     C                   ENDSR
011500030228   S***S
011600040708     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
011700030227   S***S
011800030227     C     $CLRCTL       BEGSR
011900030227    ***
012000030227     C                   MOVE      *BLANKS       I_AGCY
012100030227     C                   MOVE      *BLANKS       I_SUPER
012200030227     C                   MOVE      *BLANKS       I_RELID
012300030227    ***
012400030227     C                   ENDSR
012500030227   S***S
012600030227     C     $PREP1        BEGSR
012700030227    ***
012800040708     C                   EVAL      I_RELID = '00000001'
012900040708     C                   EVAL      KEY@ASID = '00000000'
013000030227     C                   EXSR      $BUILDSFL
013100030227     C                   EVAL      @STEP = 'STEP1'
013200030227     C                   EXSR      $CLRCTL
013300030227    ***
013400030227     C                   ENDSR
013500030227   S***S
013600030227     C     $BUILDSFL     BEGSR
013700030227    ***
013800030227     C                   MOVE      *ZEROS        RRT
013900030227     C                   MOVE      *ZEROS        #CNTREC
014000030227    ***
014100030227     C                   MOVEA     '011'         *IN(25)
014200030227     C                   WRITE     WDWCTL
014300030227     C                   MOVEA     '010'         *IN(25)
014400030227    ***
014500040708     C                   IF        I_AGCY <> *BLANKS
014600030227    *C*
014700030307     C                   MOVEL(P)  I_AGCY        KEY@AGCY
014800030307     C                   MOVEL(P)  I_SUPER       KEY@SUPER
014900030307     C     KEY#SXF       SETLL     ASAF
015000030307     C                   READ      ASAF
015100030307     C                   IF        NOT %EOF(SPRAGXR1)
015200030307     C                   EVAL      KEY@ASID = SXASID
015300030307     C                   ELSE
015400030307     C                   MOVE      *BLANKS       KEY@ASID
015500030307     C                   ENDIF
015600030307     C*
015700030228     C     KEY#SR1       SETLL     SSEQ
015800030227     C                   DOU       %EOF(SMANRLT1) OR #CNTREC = 9000
015900030303     C     I_SMAN        READE     SSEQ
016000030227     C                   IF        NOT %EOF(SMANRLT1)
016100030227     C                   EXSR      $LOADSFL
016200030227     C                   ENDIF
016300030227     C                   ENDDO
016400030227    *C*
016500030227     C                   ELSE
016600030227    *C*
016700030228     C                   IF        I_RELID <> *BLANKS
016800030228     C     KEY#SR2       SETLL     RSEQ
016900030228     C                   DOU       %EOF(SMANRLT2) OR #CNTREC = 9000
017000030303     C     I_SMAN        READE     RSEQ
017100030228     C                   IF        NOT %EOF(SMANRLT2)
017200030227     C                   EXSR      $LOADSFL
017300030227     C                   ENDIF
017400030227     C                   ENDDO
017500030228     C                   ENDIF
017600030227    *C*
017700030227     C                   ENDIF
017800030227    ***
017900030228     C                   IF        RRT > 9
018000030227     C                   EVAL      *IN91 = *ON
018100030227     C                   ENDIF
018200030227    ***
018300030227     C                   ENDSR
018400030227   S***S
018500030227     C     $LOADSFL      BEGSR
018600030227    ***
018700030227     C                   MOVE      *ON           *IN25
018800030227     C                   ADD       1             RRT
018900030227     C                   IF        RRT = 1
019000030227     C                   Z-ADD     RRT           SFLPOS
019100030227     C                   ENDIF
019200030227    ***
019300030227     C                   MOVE      *BLANKS       SEL
019400030307     C                   MOVE      *BLANKS       S_AGCY
019500030307     C                   MOVE      *BLANKS       D_AGCY
019600030307     C                   MOVE      *BLANKS       S_SUPER
019700030307     C                   MOVE      *BLANKS       D_SUPER
019800030307     C                   MOVE      *ZEROS        S_EFFDTE
019900030307     C                   MOVE      *ZEROS        S_TRMDTE
020000030307     C                   MOVE      *BLANKS       S_RELID
020100030307    ***
020200030307     C                   CLEAR                   HLDREC
020300030307     C                   EVAL      HLDREC = @SMN35
020400030307     C                   EVAL      S_RELID = SRRELID
020500030307    ***
020600030307     C                   MOVE      SREFFDTE      #XSX
020700030307     C                   EXSR      $ISOUSA
020800030307     C                   Z-ADD     #XSX          S_EFFDTE
020900030307    ***
021000030307     C                   MOVE      SRTRMDTE      #XSX
021100030307     C                   EXSR      $ISOUSA
021200030307     C                   Z-ADD     #XSX          S_TRMDTE
021300030307    ***
021400030307     C     SRASID        CHAIN     LNKF
021500030307     C                   IF        %FOUND(SPRAGXR2)
021600030307     C                   EVAL      S_AGCY = SXAGCY
021700030307     C                   EVAL      S_SUPER = SXSUPER
021800030307    *C*
021900030307     C     S_SUPER       CHAIN     SAF
022000030227     C                   IF        %FOUND(SUPRAGCY)
022100030228     C                   MOVEL(P)  SANAME1       D_SUPER
022200030227     C                   ELSE
022300030228     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
022400030227     C                   ENDIF
022500030307    *C*
022600030307     C     S_AGCY        CHAIN     AGENR
022700030228     C                   IF        %FOUND(AGENCY)
022800030228     C                   MOVEL(P)  AGNAM1        D_AGCY
022900030228     C                   ELSE
023000030228     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
023100030228     C                   ENDIF
023200030307    *C*
023300030307     C                   ENDIF
023400030228    ***
023500030227     C                   WRITE     POPUP
023600030227     C                   ADD       1             #CNTREC
023700030228    ***
023800030228     C                   ENDSR
023900030228   S***S
024000030228     C     $ISOUSA       BEGSR
024100030228    ***
024200030228     C                   IF        #XSX = 0
024300030228     C                   LEAVESR
024400030228     C                   ENDIF
024500030228     C                   MOVE      #XSX          #ISO
024600030228     C                   MOVE      #ISO          #USA
024700030228     C                   MOVE      #USA          #XSX
024800030227    ***
024900030227     C                   ENDSR
025000030227   S***S
025100030227     C     $STEP1        BEGSR
025200030227    ***
025300030227     C                   WRITE     JUNK
025400030227     C                   EXFMT     WDWCTL
025500030227    ***
025600030227     C                   IF        FKEY = F1
025700030307     C                   MOVE      *ALL'*LR'     P@35
025800030227     C                   EVAL      @STEP = 'LEAVE'
025900030227     C                   LEAVESR
026000030227     C                   ENDIF
026100030227    ***
026200030228     C                   IF        I_AGCY <> *BLANKS OR I_RELID <> *BLANKS
026300030227     C                   EXSR      $BUILDSFL
026400030227     C                   LEAVESR
026500030227     C                   ENDIF
026600030227    ***
026700030227     C                   EXSR      $CHKSEL
026800030227    ***
026900030227     C                   ENDSR
027000030227   S***S
027100030227     C     $CHKSEL       BEGSR
027200030227    ***
027300030227     C                   MOVE      *OFF          *IN99
027400030227    ***
027500030227     C                   DOU       *IN99 = *ON
027600030227     C                   READC     POPUP                                  99
027700030227     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
027800030227    ***
027900030227     C                   MOVE      *ON           *IN99
028000030307     C                   EVAL      P@35 = HLDREC
028100030227     C                   EVAL      @STEP = 'LEAVE'
028200030227    ***
028300030227     C                   ENDIF
028400030227     C                   ENDDO
028500030227     C*
028600030227     C                   ENDSR
028700030227   S***S
