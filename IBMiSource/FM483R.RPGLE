000100030221     F*-------------------------------------------------------------------------
000200030221     F* FM483      GBS/IO SOFTWARE 2003
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
001900030221     **                                                                   **
002000030221     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030703     FSRLHIST1  IF   E           K DISK    RENAME(RSRLHIST:BEFSEQ)
002200030703     FSRLHIST2  IF   E           K DISK    RENAME(RSRLHIST:AFTSEQ)
002300030221     FGBSECURE  IF   E           K DISK
002400030221     FSMAN      IF   E           K DISK
002500030221     FAGENCY    IF   E           K DISK
002600030221     FSUPRAGCY  IF   E           K DISK
002700030703     FSMANRLT   IF   E           K DISK
002800030307     FSPRAGXR2  IF   E           K DISK
002900030221     FFM483D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
003000030221   X***X
003100030703     D P@8             S              8A
003200030703     D KEY@SUP         S              3A
003300030703     D KEY@DTE         S              8S 0
003400030703     D KEY@USR         S                   LIKE(SCUSR)
003500030703    ***
003600030703     D #ISO            S               D   DATFMT(*ISO)
003700030703     D #USA            S               D   DATFMT(*USA)
003800061024     D #XSX            S              8S 0
003900030703     D #ISA            S              8S 0
004000030703    ***
004100030703     D                UDS
004200030703     D  TITLE                201    240A
004300030703    ***
004400030703     D WSDS            DS
004500030703     D  FKEY                 369    369A
004600030703    ***
004700030703     D  F1             C                   CONST(X'31')
004800030703     D  F2             C                   CONST(X'32')
004900030703     D  F3             C                   CONST(X'33')
005000030703     D  F4             C                   CONST(X'34')
005100030703     D  F5             C                   CONST(X'35')
005200030703     D  F6             C                   CONST(X'36')
005300030703     D  F7             C                   CONST(X'37')
005400030703     D  F8             C                   CONST(X'38')
005500030703     D  F9             C                   CONST(X'39')
005600030703     D  F10            C                   CONST(X'3A')
005700030703     D  F11            C                   CONST(X'3B')
005800030703     D  F12            C                   CONST(X'3C')
005900030703     D  F13            C                   CONST(X'B1')
006000030703     D  F14            C                   CONST(X'B2')
006100030703     D  F15            C                   CONST(X'B3')
006200030703     D  F16            C                   CONST(X'B4')
006300030703     D  F17            C                   CONST(X'B5')
006400030703     D  F18            C                   CONST(X'B6')
006500030703     D  F19            C                   CONST(X'B7')
006600030703     D  F20            C                   CONST(X'B8')
006700030703     D  F21            C                   CONST(X'B9')
006800030703     D  F22            C                   CONST(X'BA')
006900030703     D  F23            C                   CONST(X'BB')
007000030703     D  F24            C                   CONST(X'BC')
007100030703    ***
007200030703     D @STEP           S              5A
007300030703    ***
007400030703     D DS@LOD        E DS                  EXTNAME(SRLHIST0)
007500030703     D  HMSG1                 49     98A
007600030703     D  HMSG2                 99    148A
007700030703    ***
007800030703     D DS@B4         E DS                  EXTNAME(SMANRLT) PREFIX(BA:2)
007900061024     D   XL@B                 20     35A
008000030703    ***
008100030703     D DS@AF         E DS                  EXTNAME(SMANRLT) PREFIX(AA:2)
008200061024     D   XL@A                 20     35A
008300030703    ***
008400030703     D @DTA50          S             50A
008500030703   X***X
008600030703      /FREE
008700030703         KEY@SUP = P@8;
008800030703         @STEP = 'PREP1';
008900030703      /END-FREE
009000030703    ***
009100030703     C     *DTAARA       DEFINE    COMPANY       @DTA50
009200030703     C                   IN        @DTA50
009300030703     C                   EVAL      TITLE = %SUBST(@DTA50:1:40)
009400030703    ***
009500030703    *C                   DOU       @STEP = 'LEAVE'
009600030703    *C     @STEP         CASEQ     'PREP1'       $PREP1
009700030703    *C     @STEP         CASEQ     'STEP1'       $STEP1
009800030703    *C                   ENDCS
009900030703    *C                   ENDDO
010000030703    *C                   EVAL      *INLR = *ON
010100030703  *S***S
010200030703     C* ONETIME ROUTINE
010300030703    ***
010400030703     C     *INZSR        BEGSR
010500030703    ***
010600030703     C     *ENTRY        PLIST
010700030703     C                   PARM                    P@8
010800030703    ***
010900030703     C                   MOVE      *ZEROS        RRT               3 0
011000030703     C                   MOVE      *ZEROS        #CNTREC           2 0
011100030703    ***
011200030703     C                   MOVE      '0'           @1STLOOP          1
011300030703     C                   MOVE      '0'           @SFLOOP           1
011400030703    *C*                  MOVE      '0'           @CNFRM            1
011500030703     C                   MOVE      '1'           @LOOPIT           1
011600030703     C                   MOVE      '0'           @ACTION           1
011700030703     C                   MOVE      'M'           @SEQ              1
011800030703    ***
011900030703     C                   ENDSR
012000030703  *S***S
012100030703     C     $PREP1        BEGSR
012200030703    ***
012300030703     C                   EXSR      $CLEAR
012400030703    *C*
012500030703     C                   EXSR      $BUILD
012600030703    *C*
012700030703     C                   EVAL      @STEP = 'STEP1'
012800030703    ***
012900030703     C                   ENDSR
013000030703  *S***S
013100030703     C     $CLEAR        BEGSR
013200030703    ***
013300030703     C                   MOVEA     '011'         *IN(25)
013400030703     C                   WRITE     GBSCTL
013500030703     C                   MOVEA     '010'         *IN(25)
013600030703     C                   Z-ADD     *ZERO         RRT
013700030703    ***
013800030703     C                   ENDSR
013900030703   S***S
014000030703     C     $BUILD        BEGSR
014100030703    ***
014200030703     C                   EXSR      $CLEAR
014300030703     C                   MOVE      *ZEROS        #CNTREC
014400030703     C                   MOVE      '0'           @1STLOOP
014500030703     C                   MOVE      '0'           @SFLOOP
014600030703    ***
014700030703     C                   EXSR      $LODSCTL
014800030703    ***
014900030703     C                   IF        @SEQ = 'M'
015000030703     C     P@8           SETLL     BEFSEQ
015100030703     C                   EXSR      $BLDBEF
015200030703     C                   ELSE
015300030703     C     P@8           SETLL     AFTSEQ
015400030703     C                   EXSR      $BLDAFT
015500030703     C                   ENDIF
015600030703    ***
015700030703     C                   ENDSR
015800030703   S***S
015900030703     C     $LODSCTL      BEGSR
016000030703    ***
016100030703     C     P@8           CHAIN     SRF
016200030703     C     SRSMAN        CHAIN     SMANR
016300030703     C     SRASID        CHAIN     SXF
016400030703     C     SXAGCY        CHAIN     AGENR
016500030703     C     SXSUPER       CHAIN     SAF
016600030703     C                   EVAL      O_SMAN = SRSMAN
016700030703     C                   EVAL      O_AGCY = SXAGCY
016800030703     C                   EVAL      O_SUPER = SXSUPER
016900030703     C                   MOVE      P@8           O_RELID
017000030703    ***
017100030703     C                   ENDSR
017200030703   S***S
017300030703     C* BUILD BY BEFORE IMAGE
017400030703    ***
017500030703     C     $BLDBEF       BEGSR
017600030703    ***
017700030703     C                   DOU       %EOF(SRLHIST1) OR @SFLOOP = '1'
017800030703     C     P@8           READE     BEFSEQ
017900030703     C                   IF        NOT %EOF(SRLHIST1)
018000030703     C                   EXSR      $LOADSFL
018100030703     C                   ENDIF
018200030703     C                   ENDDO
018300030703    ***
018400030703     C                   ENDSR
018500030703   S***S
018600030703     C     $LOADSFL      BEGSR
018700030703    ***
018800030703     C                   MOVE      *ON           *IN25
018900030703    ***
019000030703     C                   EVAL      HDATA = DS@LOD
019100030703     C                   MOVE      *BLANKS       SEL01
019200030703     C*
019300030703     C                   MOVEL(P)  HUSERID       KEY@USR
019400030703     C     KEY@USR       CHAIN     SECR
019500030703     C                   IF        %FOUND(GBSECURE)
019600030703     C                   MOVEL(P)  SCNAME        SFUSER
019700030703     C                   ELSE
019800030703     C                   MOVE      HUSERID       SFUSER
019900030703     C                   END
020000030703     C*
020100030703     C                   MOVE      HDATE         #ISO
020200030703     C                   MOVE      #ISO          #USA
020300030703     C                   MOVE      #USA          SFDATE
020400030703     C                   Z-ADD     HTIME         SFTIME
020500030703     C*
020600030703     C                   MOVE      *BLANKS       @8                8
020700030703     C                   EVAL      @8 = %SUBST(HBEFORE:20:8)
020800030703     C     ' ':'0'       XLATE     @8            @8
020900061024     C                   MOVE      @8            #XSX
021000061024     C                   EXSR      $ISA
021100061024     C                   MOVE      #XSX          SFEFFDTE
021200030703     C*
021300030703     C                   EVAL      @8 = %SUBST(HBEFORE:28:8)
021400030703     C     ' ':'0'       XLATE     @8            @8
021500061024     C                   MOVE      @8            #XSX
021600061024     C                   EXSR      $ISA
021700061024     C                   MOVE      #XSX          SFOTERM
021800030703     C*
021900030703     C                   EVAL      @8 = %SUBST(HAFTER:28:8)
022000030703     C     ' ':'0'       XLATE     @8            @8
022100061024     C                   MOVE      @8            #XSX
022200061024     C                   EXSR      $ISA
022300061024     C                   MOVE      #XSX          SFNTERM
022400030703     C*
022500030703     C                   ADD       1             RRT
022600030703     C                   IF        @1STLOOP = '0'
022700030703     C                   Z-ADD     RRT           SFLPOS
022800030703     C                   MOVE      '1'           @1STLOOP
022900030703     C                   ENDIF
023000030703     C*
023100030703     C                   WRITE     GBSSFL
023200061024    ***
023300061024     C                   ENDSR
023400061024   S***S
023500061024     C     $ISA          BEGSR
023600061024    ***
023700061024     C                   IF        #XSX = 0
023800061024     C                   LEAVESR
023900061024     C                   ENDIF
024000061024    ***
024100061024     C                   MOVE      #XSX          #ISO
024200061024     C                   MOVE      #ISO          #USA
024300061024     C                   MOVE      #USA          #XSX
024400030703    ***
024500030703     C                   ENDSR
024600030703   S***S
024700030703     C     $BLDAFT       BEGSR
024800030703     C*
024900030703     C                   DOU       %EOF(SRLHIST2) OR @SFLOOP = '1'
025000030703     C     P@8           READE     AFTSEQ
025100030703     C                   IF        NOT %EOF(SRLHIST2)
025200030703     C                   EXSR      $LOADSFL
025300030703     C                   ENDIF
025400030703     C                   ENDDO
025500030703    ***
025600030703     C                   ENDSR
025700030703   S***S
025800030703     C     $STEP1        BEGSR
025900030703    ***
026000030703     C                   EXSR      $DISPLAY
026100030703    ***
026200030703     C                   IF        FKEY = F1
026300030703     C                   EVAL      @STEP = 'LEAVE'
026400030703     C                   LEAVESR
026500030703     C                   ENDIF
026600030703    ***
026700030703     C                   IF        FKEY = F8
026800030703     C                   IF        @SEQ = 'M'
026900030703     C                   MOVE      'X'           @SEQ
027000030703     C                   ELSE
027100030703     C                   MOVE      'M'           @SEQ
027200030703     C                   ENDIF
027300030703     C                   EVAL      @STEP = 'PREP1'
027400030703     C                   LEAVESR
027500030703     C                   ENDIF
027600030703    ***
027700030703     C                   IF        RRT > 0
027800030703     C                   EXSR      $CHKSELC
027900030703     C                   ENDIF
028000030703    ***
028100030703     C                   ENDSR
028200030703   S***S
028300030703     C     $DISPLAY      BEGSR
028400030703    ***
028500030703     C                   WRITE     GBSREC
028600030703     C                   EXFMT     GBSCTL
028700030703    ***
028800030703     C                   ENDSR
028900030703   S***S
029000030703    SC     $CHKSELC      BEGSR
029100030703     C*
029200030703    1C                   DOU       %EOF(FM483D)
029300030703     C                   READC(E)  GBSSFL
029400030703    2C                   IF        NOT %EOF(FM483D) AND SEL01 = 'X' AND
029500030703     C                             NOT %ERROR
029600030703     C                   EXSR      $DSPCTL
029700030703     C                   EVAL      SEL01 = *BLANKS
029800030703     C                   UPDATE    GBSSFL
029900030703    3C                   ENDIF
030000030703    1C                   ENDDO
030100030703    ***
030200030703    SC                   ENDSR
030300030703   S***S
030400030703    SC     $DSPCTL       BEGSR
030500030703    ***
030600030703     C                   EXSR      $FMTDSP
030700030703    ***
030800030703     C                   DOU       FKEY = F1
030900030703     C*
031000030703     C                   EXFMT     EXPNDSCRN
031100030703     C*
031200030703    1C                   ENDDO
031300030703     C                   CLEAR                   FKEY
031400030703    ***
031500030703    SC                   ENDSR
031600030703   S***S
031700030703    SC     $FMTDSP       BEGSR
031800030703    ***
031900030703     C                   EVAL      *IN30 = *OFF
032000030703     C                   Z-ADD     41            ZZ
032100030703     C                   DO        20
032200030703     C                   ADD       1             ZZ                2 0
032300030703     C                   EVAL      *IN(ZZ) = *OFF
032400030703     C                   ENDDO
032500030703    ***
032600030703     C                   MOVEL     HDATA         DS@LOD
032700030703     C                   MOVEL     HBEFORE       DS@B4
032800030703     C                   MOVEL     HAFTER        DS@AF
032900061024    ***
033000061024     C     ' ':'0'       XLATE     XL@B          XL@B
033100061024     C     ' ':'0'       XLATE     XL@A          XL@A
033200030703    ***
033300030703     C                   MOVEL(P)  HUSERID       KEY@USR
033400030703     C     KEY@USR       CHAIN     SECR
033500030703     C                   IF        %FOUND(GBSECURE)
033600030703     C                   MOVEL(P)  SCNAME        O_USERNAME
033700030703     C                   ELSE
033800030703     C                   MOVE      HUSERID       O_USERNAME
033900030703     C                   END
034000030703    ***
034100030703     C                   MOVE      HUSERID       KUSERID
034200061024     C                   MOVE      HTIME         KTIME
034300061024     C                   MOVE      HDATE         #XSX
034400061024     C                   EXSR      $ISA
034500061024     C                   MOVE      #XSX          KDATE
034600030703    ***
034700030703     C                   EVAL      EVSMAN = SRSMAN
034800030703     C                   EVAL      D_SMAN = %TRIM(SFNAME) + ' ' +
034900030703     C                             %TRIM(SMI) + ' ' + %TRIM(SLNAME)
035000030703     C                   EVAL      EVASID = SRASID
035100030703     C                   EVAL      EVAGCY = SXAGCY
035200030703     C                   MOVEL(P)  AGNAM1        D_AGCY
035300030703     C                   MOVEL     SXSUPER       EVSUPER
035400030703     C                   MOVEL(P)  SANAME1       D_SUPER
035500030703     C                   MOVE      P@8           EVRELID
035600030703     C                   MOVEL(P)  HMSG1         D_MSG1
035700030703     C                   MOVEL(P)  HMSG2         D_MSG2
035800030703    ***
035900030703     C                   IF        BAEFFDTE > 0
036000030703     C     BAEFFDTE      MULT      10000.0001    D_EFFDTE
036100030703     C                   ENDIF
036200030703    ***
036300030703     C                   IF        BATRMDTE <> AATRMDTE
036400030703     C                   IF        BATRMDTE > 0
036500030703     C     BATRMDTE      MULT      10000.0001    BATRMDTE
036600030703     C                   ENDIF
036700090317     C                   EVAL      DBTRMDTE = BATRMDTE
036800030703     C                   IF        AATRMDTE > 0
036900030703     C     AATRMDTE      MULT      10000.0001    AATRMDTE
037000030703     C                   ENDIF
037100090317     C                   EVAL      DATRMDTE = AATRMDTE
037200030703     C                   ENDIF
037300030703    ***
037400030703    SC                   ENDSR
037500030703   S***S
