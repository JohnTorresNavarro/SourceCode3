000100030221     F*-------------------------------------------------------------------------
000200040708     F* IQR173     GBS/IO SOFTWARE 2003
000300030221     F*            WRITTEN BY - S.S.K.
000400030221     F*            DATE - 02/03
000500030221     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR SALESMAN RELATIONSHIP
000600030221     F*  INDICATOR USAGE:
000700030221     F*    03 = EXIT FROM INITIAL SCREEN
000800030221     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900030221     F*    25 = SFLDSP
001000030221     F*    26 = SFL DSP CTL
001100030221     F*    27 = SFL CLR
001200030221     F*    30 = ALLOW ROLL KEY
001300030221     F*    29 = ROLL FUNCTION SELECTED
001400030221     F*
001500030221     F*-------------------------------------------------------------------------
001600030221     ** MODIFICATION HISTORY                                              **
001700030221     ** ###  UUU  MMDDCCYY  X---->                                        **
001800030221     ** 000  SSK  02212003  ORIGINAL SOURCE                               **
001900040708     ** ***  SSK  01052004  COPY FM483R TO IQ                             **
002000030221     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030703     FSRLHIST1  IF   E           K DISK    RENAME(RSRLHIST:BEFSEQ)
002200030703     FSRLHIST2  IF   E           K DISK    RENAME(RSRLHIST:AFTSEQ)
002300030221     FGBSECURE  IF   E           K DISK
002400030221     FSMAN      IF   E           K DISK
002500030221     FAGENCY    IF   E           K DISK
002600030221     FSUPRAGCY  IF   E           K DISK
002700030703     FSMANRLT   IF   E           K DISK
002800030307     FSPRAGXR2  IF   E           K DISK
002900040708     FIQR173D   CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
003000030221   X***X
003100030703     D P@8             S              8A
003200030703     D KEY@SUP         S              3A
003300030703     D KEY@DTE         S              8S 0
003400030703     D KEY@USR         S                   LIKE(SCUSR)
003500030703    ***
003600030703     D #ISO            S               D   DATFMT(*ISO)
003700030703     D #USA            S               D   DATFMT(*USA)
003800030703     D #ISA            S              8S 0
003900030703    ***
004000030703     D WSDS            DS
004100030703     D  FKEY                 369    369A
004200030703    ***
004300030703     D  F1             C                   CONST(X'31')
004400030703     D  F2             C                   CONST(X'32')
004500030703     D  F3             C                   CONST(X'33')
004600030703     D  F4             C                   CONST(X'34')
004700030703     D  F5             C                   CONST(X'35')
004800030703     D  F6             C                   CONST(X'36')
004900030703     D  F7             C                   CONST(X'37')
005000030703     D  F8             C                   CONST(X'38')
005100030703     D  F9             C                   CONST(X'39')
005200030703     D  F10            C                   CONST(X'3A')
005300030703     D  F11            C                   CONST(X'3B')
005400030703     D  F12            C                   CONST(X'3C')
005500030703     D  F13            C                   CONST(X'B1')
005600030703     D  F14            C                   CONST(X'B2')
005700030703     D  F15            C                   CONST(X'B3')
005800030703     D  F16            C                   CONST(X'B4')
005900030703     D  F17            C                   CONST(X'B5')
006000030703     D  F18            C                   CONST(X'B6')
006100030703     D  F19            C                   CONST(X'B7')
006200030703     D  F20            C                   CONST(X'B8')
006300030703     D  F21            C                   CONST(X'B9')
006400030703     D  F22            C                   CONST(X'BA')
006500030703     D  F23            C                   CONST(X'BB')
006600030703     D  F24            C                   CONST(X'BC')
006700030703    ***
006800030703     D @STEP           S              5A
006900030703    ***
007000030703     D DS@LOD        E DS                  EXTNAME(SRLHIST0)
007100030703     D  HMSG1                 49     98A
007200030703     D  HMSG2                 99    148A
007300030703    ***
007400030703     D DS@B4         E DS                  EXTNAME(SMANRLT) PREFIX(BA:2)
007500030703    ***
007600030703     D DS@AF         E DS                  EXTNAME(SMANRLT) PREFIX(AA:2)
007700030703    ***
007800030703     D @DTA50          S             50A
007900030703   X***X
008000030703      /FREE
008100030703         KEY@SUP = P@8;
008200030703         @STEP = 'PREP1';
008300030703      /END-FREE
008400030703    ***
008500030703    *C                   DOU       @STEP = 'LEAVE'
008600030703    *C     @STEP         CASEQ     'PREP1'       $PREP1
008700030703    *C     @STEP         CASEQ     'STEP1'       $STEP1
008800030703    *C                   ENDCS
008900030703    *C                   ENDDO
009000030703    *C                   EVAL      *INLR = *ON
009100030703  *S***S
009200030703     C* ONETIME ROUTINE
009300030703    ***
009400030703     C     *INZSR        BEGSR
009500030703    ***
009600030703     C     *ENTRY        PLIST
009700030703     C                   PARM                    P@8
009800030703    ***
009900030703     C                   MOVE      *ZEROS        RRT               3 0
010000030703     C                   MOVE      *ZEROS        #CNTREC           2 0
010100030703    ***
010200030703     C                   MOVE      '0'           @1STLOOP          1
010300030703     C                   MOVE      '0'           @SFLOOP           1
010400030703    *C*                  MOVE      '0'           @CNFRM            1
010500030703     C                   MOVE      '1'           @LOOPIT           1
010600030703     C                   MOVE      '0'           @ACTION           1
010700030703     C                   MOVE      'M'           @SEQ              1
010800030703    ***
010900030703     C                   ENDSR
011000030703  *S***S
011100030703     C     $PREP1        BEGSR
011200030703    ***
011300030703     C                   EXSR      $CLEAR
011400030703    *C*
011500030703     C                   EXSR      $BUILD
011600030703    *C*
011700030703     C                   EVAL      @STEP = 'STEP1'
011800030703    ***
011900030703     C                   ENDSR
012000030703  *S***S
012100030703     C     $CLEAR        BEGSR
012200030703    ***
012300030703     C                   MOVEA     '011'         *IN(25)
012400030703     C                   WRITE     GBSCTL
012500030703     C                   MOVEA     '010'         *IN(25)
012600030703     C                   Z-ADD     *ZERO         RRT
012700030703    ***
012800030703     C                   ENDSR
012900030703   S***S
013000030703     C     $BUILD        BEGSR
013100030703    ***
013200030703     C                   EXSR      $CLEAR
013300030703     C                   MOVE      *ZEROS        #CNTREC
013400030703     C                   MOVE      '0'           @1STLOOP
013500030703     C                   MOVE      '0'           @SFLOOP
013600030703    ***
013700030703     C                   EXSR      $LODSCTL
013800030703    ***
013900030703     C                   IF        @SEQ = 'M'
014000030703     C     P@8           SETLL     BEFSEQ
014100030703     C                   EXSR      $BLDBEF
014200030703     C                   ELSE
014300030703     C     P@8           SETLL     AFTSEQ
014400030703     C                   EXSR      $BLDAFT
014500030703     C                   ENDIF
014600030703    ***
014700030703     C                   ENDSR
014800030703   S***S
014900030703     C     $LODSCTL      BEGSR
015000030703    ***
015100030703     C     P@8           CHAIN     SRF
015200030703     C     SRSMAN        CHAIN     SMANR
015300030703     C     SRASID        CHAIN     SXF
015400030703     C     SXAGCY        CHAIN     AGENR
015500030703     C     SXSUPER       CHAIN     SAF
015600030703     C                   EVAL      O_SMAN = SRSMAN
015700030703     C                   EVAL      O_AGCY = SXAGCY
015800030703     C                   EVAL      O_SUPER = SXSUPER
015900030703     C                   MOVE      P@8           O_RELID
016000030703    ***
016100030703     C                   ENDSR
016200030703   S***S
016300030703     C* BUILD BY BEFORE IMAGE
016400030703    ***
016500030703     C     $BLDBEF       BEGSR
016600030703    ***
016700030703     C                   DOU       %EOF(SRLHIST1) OR @SFLOOP = '1'
016800030703     C     P@8           READE     BEFSEQ
016900030703     C                   IF        NOT %EOF(SRLHIST1)
017000030703     C                   EXSR      $LOADSFL
017100030703     C                   ENDIF
017200030703     C                   ENDDO
017300030703    ***
017400030703     C                   ENDSR
017500030703   S***S
017600030703     C     $LOADSFL      BEGSR
017700030703    ***
017800030703     C                   MOVE      *ON           *IN25
017900030703    ***
018000030703     C                   EVAL      HDATA = DS@LOD
018100030703     C                   MOVE      *BLANKS       SEL01
018200030703     C*
018300030703     C                   MOVEL(P)  HUSERID       KEY@USR
018400030703     C     KEY@USR       CHAIN     SECR
018500030703     C                   IF        %FOUND(GBSECURE)
018600030703     C                   MOVEL(P)  SCNAME        SFUSER
018700030703     C                   ELSE
018800030703     C                   MOVE      HUSERID       SFUSER
018900030703     C                   END
019000030703     C*
019100030703     C                   MOVE      HDATE         #ISO
019200030703     C                   MOVE      #ISO          #USA
019300030703     C                   MOVE      #USA          SFDATE
019400030703     C                   Z-ADD     HTIME         SFTIME
019500030703     C*
019600030703     C                   MOVE      *BLANKS       @8                8
019700030703     C                   EVAL      @8 = %SUBST(HBEFORE:20:8)
019800030703     C     ' ':'0'       XLATE     @8            @8
019900030703     C                   MOVE      @8            SFEFFDTE
020000030703     C*
020100030703     C                   EVAL      @8 = %SUBST(HBEFORE:28:8)
020200030703     C     ' ':'0'       XLATE     @8            @8
020300030703     C                   MOVE      @8            SFOTERM
020400030703     C*
020500030703     C                   EVAL      @8 = %SUBST(HAFTER:28:8)
020600030703     C     ' ':'0'       XLATE     @8            @8
020700030703     C                   MOVE      @8            SFNTERM
020800030703     C*
020900030703     C                   ADD       1             RRT
021000030703     C                   IF        @1STLOOP = '0'
021100030703     C                   Z-ADD     RRT           SFLPOS
021200030703     C                   MOVE      '1'           @1STLOOP
021300030703     C                   ENDIF
021400030703     C*
021500030703     C                   WRITE     GBSSFL
021600030703    ***
021700030703     C                   ENDSR
021800030703   S***S
021900030703     C     $BLDAFT       BEGSR
022000030703     C*
022100030703     C                   DOU       %EOF(SRLHIST2) OR @SFLOOP = '1'
022200030703     C     P@8           READE     AFTSEQ
022300030703     C                   IF        NOT %EOF(SRLHIST2)
022400030703     C                   EXSR      $LOADSFL
022500030703     C                   ENDIF
022600030703     C                   ENDDO
022700030703    ***
022800030703     C                   ENDSR
022900030703   S***S
023000030703     C     $STEP1        BEGSR
023100030703    ***
023200030703     C                   EXSR      $DISPLAY
023300030703    ***
023400030703     C                   IF        FKEY = F1
023500030703     C                   EVAL      @STEP = 'LEAVE'
023600030703     C                   LEAVESR
023700030703     C                   ENDIF
023800030703    ***
023900030703     C                   IF        FKEY = F8
024000030703     C                   IF        @SEQ = 'M'
024100030703     C                   MOVE      'X'           @SEQ
024200030703     C                   ELSE
024300030703     C                   MOVE      'M'           @SEQ
024400030703     C                   ENDIF
024500030703     C                   EVAL      @STEP = 'PREP1'
024600030703     C                   LEAVESR
024700030703     C                   ENDIF
024800030703    ***
024900030703     C                   IF        RRT > 0
025000030703     C                   EXSR      $CHKSELC
025100030703     C                   ENDIF
025200030703    ***
025300030703     C                   ENDSR
025400030703   S***S
025500030703     C     $DISPLAY      BEGSR
025600030703    ***
025700030703     C                   WRITE     GBSREC
025800030703     C                   EXFMT     GBSCTL
025900030703    ***
026000030703     C                   ENDSR
026100030703   S***S
026200030703    SC     $CHKSELC      BEGSR
026300030703     C*
026400040708    1C                   DOU       %EOF(IQR173D)
026500030703     C                   READC(E)  GBSSFL
026600040708    2C                   IF        NOT %EOF(IQR173D) AND SEL01 = 'X' AND
026700030703     C                             NOT %ERROR
026800030703     C                   EXSR      $DSPCTL
026900030703     C                   EVAL      SEL01 = *BLANKS
027000030703     C                   UPDATE    GBSSFL
027100030703    3C                   ENDIF
027200030703    1C                   ENDDO
027300030703    ***
027400030703    SC                   ENDSR
027500030703   S***S
027600030703    SC     $DSPCTL       BEGSR
027700030703    ***
027800030703     C                   EXSR      $FMTDSP
027900030703    ***
028000030703     C                   DOU       FKEY = F1
028100030703     C*
028200030703     C                   EXFMT     EXPNDSCRN
028300030703     C*
028400030703    1C                   ENDDO
028500030703     C                   CLEAR                   FKEY
028600030703    ***
028700030703    SC                   ENDSR
028800030703   S***S
028900030703    SC     $FMTDSP       BEGSR
029000030703    ***
029100030703     C                   EVAL      *IN30 = *OFF
029200030703     C                   Z-ADD     41            ZZ
029300030703     C                   DO        20
029400030703     C                   ADD       1             ZZ                2 0
029500030703     C                   EVAL      *IN(ZZ) = *OFF
029600030703     C                   ENDDO
029700030703    ***
029800030703     C                   MOVEL     HDATA         DS@LOD
029900030703     C                   MOVEL     HBEFORE       DS@B4
030000030703     C                   MOVEL     HAFTER        DS@AF
030100030703    ***
030200030703     C                   MOVEL(P)  HUSERID       KEY@USR
030300030703     C     KEY@USR       CHAIN     SECR
030400030703     C                   IF        %FOUND(GBSECURE)
030500030703     C                   MOVEL(P)  SCNAME        O_USERNAME
030600030703     C                   ELSE
030700030703     C                   MOVE      HUSERID       O_USERNAME
030800030703     C                   END
030900030703    ***
031000030703     C                   MOVE      HUSERID       KUSERID
031100030703    ***
031200030703     C                   EVAL      EVSMAN = SRSMAN
031300030703     C                   EVAL      D_SMAN = %TRIM(SFNAME) + ' ' +
031400030703     C                             %TRIM(SMI) + ' ' + %TRIM(SLNAME)
031500030703     C                   EVAL      EVASID = SRASID
031600030703     C                   EVAL      EVAGCY = SXAGCY
031700030703     C                   MOVEL(P)  AGNAM1        D_AGCY
031800030703     C                   MOVEL     SXSUPER       EVSUPER
031900030703     C                   MOVEL(P)  SANAME1       D_SUPER
032000030703     C                   MOVE      P@8           EVRELID
032100030703     C                   MOVEL(P)  HMSG1         D_MSG1
032200030703     C                   MOVEL(P)  HMSG2         D_MSG2
032300030703    ***
032400030703     C                   IF        BAEFFDTE > 0
032500030703     C     BAEFFDTE      MULT      10000.0001    D_EFFDTE
032600030703     C                   ENDIF
032700030703    ***
032800030703     C                   IF        BATRMDTE <> AATRMDTE
032900030703     C                   IF        BATRMDTE > 0
033000030703     C     BATRMDTE      MULT      10000.0001    BATRMDTE
033100030703     C                   ENDIF
033200030703     C                   IF        AATRMDTE > 0
033300030703     C     AATRMDTE      MULT      10000.0001    AATRMDTE
033400030703     C                   ENDIF
033500030703     C                   ENDIF
033600030703    ***
033700030703    SC                   ENDSR
033800030703   S***S
