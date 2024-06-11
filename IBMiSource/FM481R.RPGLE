000100030227     F*-------------------------------------------------------------------------
000200030227     F* FM481      GBS/IO SOFTWARE 2003
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
001500030227     F*
001600030227     F*-------------------------------------------------------------------------
001700030227     ** MODIFICATION HISTORY                                              **
001800030227     ** ###  UUU  MMDDCCYY  X---->                                        **
001900030227     ** 000  SSK  02272003  ORIGINAL SOURCE                               **
002000030227     **                                                                   **
002100030227     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002200030228     FSMANRLT2  IF   E           K DISK    RENAME(SRF:RSEQ)
002300030227     FSMANRLT1  IF   E           K DISK    RENAME(SRF:SSEQ)
002400030227     FSUPRAGCY  IF   E           K DISK
002500030227     FAGENCY    IF   E           K DISK
002600030307     FSPRAGXR1  IF   E           K DISK    RENAME(SXF:ASAF)
002700030307     FSPRAGXR2  IF   E           K DISK    RENAME(SXF:LNKF)
002800030227     FSMAN      IF   E           K DISK
002900030227     FFM481D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
003000030227   X***X
003100030227    ***
003200030227     D WSDS            DS
003300030227     D  FKEY                 369    369A
003400030227    ***
003500030227     D  F1             C                   CONST(X'31')
003600030227     D  F2             C                   CONST(X'32')
003700030227     D  F3             C                   CONST(X'33')
003800030227     D  F4             C                   CONST(X'34')
003900030227     D  F5             C                   CONST(X'35')
004000030227     D  F6             C                   CONST(X'36')
004100030227     D  F7             C                   CONST(X'37')
004200030227     D  F8             C                   CONST(X'38')
004300030227     D  F9             C                   CONST(X'39')
004400030227     D  F10            C                   CONST(X'3A')
004500030227     D  F11            C                   CONST(X'3B')
004600030227     D  F12            C                   CONST(X'3C')
004700030227     D  F13            C                   CONST(X'B1')
004800030227     D  F14            C                   CONST(X'B2')
004900030227     D  F15            C                   CONST(X'B3')
005000030227     D  F16            C                   CONST(X'B4')
005100030227     D  F17            C                   CONST(X'B5')
005200030227     D  F18            C                   CONST(X'B6')
005300030227     D  F19            C                   CONST(X'B7')
005400030227     D  F20            C                   CONST(X'B8')
005500030227     D  F21            C                   CONST(X'B9')
005600030227     D  F22            C                   CONST(X'BA')
005700030227     D  F23            C                   CONST(X'BB')
005800030227     D  F24            C                   CONST(X'BC')
005900030228    ***
006000030228     D #XSX            S              8S 0
006100030228     D #ISO            S               D   DATFMT(*ISO)
006200030228     D #USA            S               D   DATFMT(*USA)
006300030227    ***
006400030307     D @SMN35        E DS                  EXTNAME(SMANRLT)
006500030227     D @STEP           S              5A
006600030307     D P@35            S             35A
006700030227     D RRT             S              4S 0
006800030227     D #CNTREC         S              4S 0
006900030313     D A@20            S             20A
007000030228     D A@40            S             40A
007100030307     D KEY@AGCY        S                   LIKE(SXAGCY)
007200030307     D KEY@SUPER       S                   LIKE(SXSUPER)
007300030307     D KEY@ASID        S                   LIKE(SXASID)
007400030227   X***X
007500030227     C* MAINLINE
007600030227    ***
007700030227     C                   DOU       @STEP = 'LEAVE'
007800030227     C     @STEP         CASEQ     'PREP1'       $PREP1
007900030227     C     @STEP         CASEQ     'STEP1'       $STEP1
008000030227     C                   ENDCS
008100030227     C                   ENDDO
008200030227     C                   EVAL      *INLR = *ON
008300040209     c                   return
008400030227   S***S
008500030227     C     *INZSR        BEGSR
008600030227    ***
008700030227     C     *ENTRY        PLIST
008800030307     C                   PARM                    P@35
008900030227    ***
009000030227     C                   EVAL      @STEP = 'PREP1'
009100030228     C                   MOVE      *BLANKS       I_SMAN
009200030228     C                   MOVE      *BLANKS       D_SMAN
009300030227     C                   EXSR      $CLRCTL
009400030228    ***
009500030307     C                   EVAL      I_SMAN = %SUBST(P@35:17:3)
009600030228     C     I_SMAN        CHAIN     SMANR
009700030228     C                   IF        %FOUND(SMAN)
009800030228     C                   EXSR      $GETSNAME
009900030228     C                   ELSE
010000030228     C                   EVAL      D_SMAN = '*UNKNOWN*'
010100030228     C                   ENDIF
010200030227    ***
010300030228     C     KEY#SR1       KLIST
010400030227     C                   KFLD                    I_SMAN
010500030307     C                   KFLD                    KEY@ASID
010600030228    ***
010700030228     C     KEY#SR2       KLIST
010800030228     C                   KFLD                    I_SMAN
010900030228     C                   KFLD                    I_RELID
011000030307    ***
011100030307     C     KEY#SXF       KLIST
011200030307     C                   KFLD                    KEY@AGCY
011300030307     C                   KFLD                    KEY@SUPER
011400030228    ***
011500030228     C                   ENDSR
011600030228   S***S
011700030228     C     $GETSNAME     BEGSR
011800030228    ***
011900030313     C                   CLEAR                   A@20
012000030228     C                   CLEAR                   A@40
012100030228    ***
012200030228     C                   IF        SFNAME <> *BLANKS
012300030313     C                   MOVEL     SFNAME        A@20
012400030228     C                   EXSR      $LDADDR
012500030228     C                   ENDIF
012600030228    ***
012700030228     C                   IF        SMI <> *BLANKS
012800030313     C                   MOVEL     SMI           A@20
012900030228     C                   EXSR      $LDADDR
013000030228     C                   ENDIF
013100030228    ***
013200030228     C                   IF        SLNAME <> *BLANKS
013300030313     C                   MOVEL     SLNAME        A@20
013400030228     C                   EXSR      $LDADDR
013500030228     C                   ENDIF
013600030228    ***
013700030228     C                   ENDSR
013800030228   S***S
013900030228     C     $LDADDR       BEGSR
014000030228    ***
014100030313     C                   EVAL      A@20 = %TRIM(A@20)
014200030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
014300030313     C                   CLEAR                   A@20
014400030227    ***
014500030227     C                   ENDSR
014600030227   S***S
014700030227     C     $CLRCTL       BEGSR
014800030227    ***
014900030227     C                   MOVE      *BLANKS       I_AGCY
015000030227     C                   MOVE      *BLANKS       I_SUPER
015100030227     C                   MOVE      *BLANKS       I_RELID
015200030227    ***
015300030227     C                   ENDSR
015400030227   S***S
015500030227     C     $PREP1        BEGSR
015600030227    ***
015700040209     C                   EVAL      I_AGCY = *blanks
015800040209     C                   eval      I_RELID = '00000000'
015900030227     C                   EXSR      $BUILDSFL
016000030227     C                   EVAL      @STEP = 'STEP1'
016100030227     C                   EXSR      $CLRCTL
016200040209     C                   EVAL      I_AGCY = *blanks
016300040209     C                   eval      I_RELID = '00000000'
016400030227    ***
016500030227     C                   ENDSR
016600030227   S***S
016700030227     C     $BUILDSFL     BEGSR
016800030227    ***
016900030227     C                   MOVE      *ZEROS        RRT
017000030227     C                   MOVE      *ZEROS        #CNTREC
017100030227    ***
017200030227     C                   MOVEA     '011'         *IN(25)
017300030227     C                   WRITE     WDWCTL
017400030227     C                   MOVEA     '010'         *IN(25)
017500030227    ***
017600030228     C                   IF        I_AGCY <> *BLANKS
017700030227    *C*
017800030307     C                   MOVEL(P)  I_AGCY        KEY@AGCY
017900030307     C                   MOVEL(P)  I_SUPER       KEY@SUPER
018000030307     C     KEY#SXF       SETLL     ASAF
018100030307     C                   READ      ASAF
018200030307     C                   IF        NOT %EOF(SPRAGXR1)
018300030307     C                   EVAL      KEY@ASID = SXASID
018400030307     C                   ELSE
018500030307     C                   MOVE      *BLANKS       KEY@ASID
018600030307     C                   ENDIF
018700030307     C*
018800030228     C     KEY#SR1       SETLL     SSEQ
018900030227     C                   DOU       %EOF(SMANRLT1) OR #CNTREC = 9000
019000030303     C     I_SMAN        READE     SSEQ
019100030227     C                   IF        NOT %EOF(SMANRLT1)
019200030227     C                   EXSR      $LOADSFL
019300030227     C                   ENDIF
019400030227     C                   ENDDO
019500030227    *C*
019600030227     C                   ELSE
019700030227    *C*
019800030228     C                   IF        I_RELID <> *BLANKS
019900030228     C     KEY#SR2       SETLL     RSEQ
020000030228     C                   DOU       %EOF(SMANRLT2) OR #CNTREC = 9000
020100030303     C     I_SMAN        READE     RSEQ
020200030228     C                   IF        NOT %EOF(SMANRLT2)
020300030227     C                   EXSR      $LOADSFL
020400030227     C                   ENDIF
020500030227     C                   ENDDO
020600030228     C                   ENDIF
020700030227    *C*
020800030227     C                   ENDIF
020900030227    ***
021000030228     C                   IF        RRT > 9
021100030227     C                   EVAL      *IN91 = *ON
021200030227     C                   ENDIF
021300030227    ***
021400030227     C                   ENDSR
021500030227   S***S
021600030227     C     $LOADSFL      BEGSR
021700030227    ***
021800030227     C                   MOVE      *ON           *IN25
021900030227     C                   ADD       1             RRT
022000030227     C                   IF        RRT = 1
022100030227     C                   Z-ADD     RRT           SFLPOS
022200030227     C                   ENDIF
022300030227    ***
022400030227     C                   MOVE      *BLANKS       SEL
022500030307     C                   MOVE      *BLANKS       S_AGCY
022600030307     C                   MOVE      *BLANKS       D_AGCY
022700030307     C                   MOVE      *BLANKS       S_SUPER
022800030307     C                   MOVE      *BLANKS       D_SUPER
022900030307     C                   MOVE      *ZEROS        S_EFFDTE
023000030307     C                   MOVE      *ZEROS        S_TRMDTE
023100030307     C                   MOVE      *BLANKS       S_RELID
023200030307    ***
023300030307     C                   CLEAR                   HLDREC
023400030307     C                   EVAL      HLDREC = @SMN35
023500030307     C                   EVAL      S_RELID = SRRELID
023600030307    ***
023700030307     C                   MOVE      SREFFDTE      #XSX
023800030307     C                   EXSR      $ISOUSA
023900030307     C                   Z-ADD     #XSX          S_EFFDTE
024000030307    ***
024100030307     C                   MOVE      SRTRMDTE      #XSX
024200030307     C                   EXSR      $ISOUSA
024300030307     C                   Z-ADD     #XSX          S_TRMDTE
024400030307    ***
024500030307     C     SRASID        CHAIN     LNKF
024600030307     C                   IF        %FOUND(SPRAGXR2)
024700030307     C                   EVAL      S_AGCY = SXAGCY
024800030307     C                   EVAL      S_SUPER = SXSUPER
024900030307    *C*
025000030307     C     S_SUPER       CHAIN     SAF
025100030227     C                   IF        %FOUND(SUPRAGCY)
025200030228     C                   MOVEL(P)  SANAME1       D_SUPER
025300030227     C                   ELSE
025400030228     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
025500030227     C                   ENDIF
025600030307    *C*
025700030307     C     S_AGCY        CHAIN     AGENR
025800030228     C                   IF        %FOUND(AGENCY)
025900030228     C                   MOVEL(P)  AGNAM1        D_AGCY
026000030228     C                   ELSE
026100030228     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
026200030228     C                   ENDIF
026300030307    *C*
026400030307     C                   ENDIF
026500030228    ***
026600030227     C                   WRITE     POPUP
026700030227     C                   ADD       1             #CNTREC
026800030228    ***
026900030228     C                   ENDSR
027000030228   S***S
027100030228     C     $ISOUSA       BEGSR
027200030228    ***
027300030228     C                   IF        #XSX = 0
027400030228     C                   LEAVESR
027500030228     C                   ENDIF
027600030228     C                   MOVE      #XSX          #ISO
027700030228     C                   MOVE      #ISO          #USA
027800030228     C                   MOVE      #USA          #XSX
027900030227    ***
028000030227     C                   ENDSR
028100030227   S***S
028200030227     C     $STEP1        BEGSR
028300030227    ***
028400040209     C                   eval      I_AGCY = *BLANKS
028500040209     C                   eval      I_RELID = '00000000'
028600030227     C                   WRITE     JUNK
028700030227     C                   EXFMT     WDWCTL
028800030227    ***
028900030227     C                   IF        FKEY = F1
029000030307     C                   MOVE      *ALL'*LR'     P@35
029100030227     C                   EVAL      @STEP = 'LEAVE'
029200030227     C                   LEAVESR
029300030227     C                   ENDIF
029400030227    ***
029500040209     C                   IF        I_AGCY <> *BLANKS OR I_RELID <> '00000000'
029600030227     C                   EXSR      $BUILDSFL
029700030227     C                   LEAVESR
029800030227     C                   ENDIF
029900030227    ***
030000030227     C                   EXSR      $CHKSEL
030100030227    ***
030200030227     C                   ENDSR
030300030227   S***S
030400030227     C     $CHKSEL       BEGSR
030500030227    ***
030600030227     C                   MOVE      *OFF          *IN99
030700030227    ***
030800030227     C                   DOU       *IN99 = *ON
030900030227     C                   READC     POPUP                                  99
031000030227     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
031100030227    ***
031200030227     C                   MOVE      *ON           *IN99
031300030307     C                   EVAL      P@35 = HLDREC
031400030227     C                   EVAL      @STEP = 'LEAVE'
031500030227    ***
031600030227     C                   ENDIF
031700030227     C                   ENDDO
031800030227     C*
031900030227     C                   ENDSR
032000030227   S***S
