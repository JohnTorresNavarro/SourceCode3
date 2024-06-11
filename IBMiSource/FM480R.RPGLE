000100030213     F*-------------------------------------------------------------------------
000200030213     F* FM480     GBS/IO SOFTWARE 2003
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
001700110418     ** 001  SSK  04182011  ADD MARKETING DIARY NOTES                     **
001800030213     **                                                                   **
001900030213     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000030213     FFM480D    CF   E             WORKSTN INFDS(WSDS)
002100030307     FSPRAGXR2  IF   E           K DISK
002200030213     FSMAN      IF   E           K DISK
002300030213     FAGENCY    IF   E           K DISK
002400030213     FSUPRAGCY  IF   E           K DISK
002500030213     FSMANRLT   UF A E           K DISK
002600030703     FSRLHIST0  O  A E           K DISK
002700030213   X***X
002800030213     D WSDS            DS
002900030213     D  FKEY                 369    369A
003000030227    ***
003100030227     D                UDS
003200030227     D SF                    241    241A
003300030227    ***
003400030213     D  F1             C                   CONST(X'31')
003500030213     D  F2             C                   CONST(X'32')
003600030213     D  F3             C                   CONST(X'33')
003700030213     D  F4             C                   CONST(X'34')
003800030213     D  F5             C                   CONST(X'35')
003900030213     D  F6             C                   CONST(X'36')
004000030213     D  F7             C                   CONST(X'37')
004100030213     D  F8             C                   CONST(X'38')
004200030213     D  F9             C                   CONST(X'39')
004300030213     D  F10            C                   CONST(X'3A')
004400030213     D  F11            C                   CONST(X'3B')
004500030213     D  F12            C                   CONST(X'3C')
004600030213     D  F13            C                   CONST(X'B1')
004700030213     D  F14            C                   CONST(X'B2')
004800030213     D  F15            C                   CONST(X'B3')
004900030213     D  F16            C                   CONST(X'B4')
005000030213     D  F17            C                   CONST(X'B5')
005100030213     D  F18            C                   CONST(X'B6')
005200030213     D  F19            C                   CONST(X'B7')
005300030213     D  F20            C                   CONST(X'B8')
005400030213     D  F21            C                   CONST(X'B9')
005500030213     D  F22            C                   CONST(X'BA')
005600030213     D  F23            C                   CONST(X'BB')
005700030213     D  F24            C                   CONST(X'BC')
005800030213    ***
005900030213     D #ISO            S               D   DATFMT(*ISO)
006000030214     D #SEQ            S              8S 0
006100030214     D #TDAY           S              8S 0
006200030213     D #USA            S               D   DATFMT(*USA)
006300030214     D #8              S              8S 0
006400030214     D #8BEG           S              8S 0
006500030214     D #8END           S              8S 0
006600030214     D #8S0            S              8S 0
006700030213    ***
006800030313     D A@20            S             20A
006900030214     D A@40            S             40A
007000030214     D KEY@RELID       S                   LIKE(SRRELID)
007100030306     D KEY@SUPER       S                   LIKE(SXSUPER)
007200030306     D KEY@AGCY        S                   LIKE(SXAGCY)
007300030214     D REC@DS        E DS                  EXTNAME(SMANRLT)
007400030214     D P@4             S              4A
007500030306     D P@35            S             35A
007600030213    ***
007700030214     D @DTA50          S             50A
007800030213     D @EMSG           S             70A
007900030214     D @IM             S              1A
008000030214     D @STEP           S              5A
008100030214     D @SXC            S              1A
008200030214     D @VP             S              1A
008300030214     D @VR             S              1A
008400030214     D @3              S              3A
008500030214     D @70M            S             70A
008600030213     D @8              S              8A
008700030214    ***
008800030214     D HMSG            DS
008900030214     D  HM1                    1     50A
009000030214     D  HM2                   51    100A
009100030214    ***
009200030214     D @TS40           S             40A
009300030214     D @TIMESTAMP      DS
009400030214     D  #TSCYMD                1      8S 0
009500030214     D  #TSTIME                9     14S 0
009600030214     D  @TSJOB                15     24
009700030214     D  @TSUSER               25     34
009800030214     D  #TSNBR                35     40S 0
009900030213   X***X
010000030213    1C                   DOU       @STEP = 'LEAVE'
010100030213    2C     @STEP         CASEQ     'PREP1'       $PREP1
010200030213    2C     @STEP         CASEQ     'STEP1'       $STEP1
010300030213    2C                   ENDCS
010400030213    1C                   ENDDO
010500030213    ***
010600030213     C                   MOVE      *ON           *INLR
010700030213   S***S
010800030213     C     *INZSR        BEGSR
010900030213    ***
011000030213     C     *ENTRY        PLIST
011100030306     C                   PARM                    P@35
011200030213    ***
011300030213     C     KEY#SXF       KLIST
011400030213     C                   KFLD                    KEY@SUPER
011500030213     C                   KFLD                    KEY@AGCY
011600030213    ***
011700030213     C                   CLEAR                   IO01
011800030213     C                   CLEAR                   SRF
011900030213     C
012000030306     C                   IF        %SUBST(P@35:35:1) = 'A'
012100030213     C                   EVAL      @IM = 'A'
012200030213     C                   ELSE
012300030213     C                   EVAL      @IM = 'M'
012400030306     C                   EVAL      KEY@RELID = %SUBST(P@35:1:8)
012500030213     C                   ENDIF
012600030213    ***
012700030213     C                   EVAL      @STEP = 'PREP1'
012800030213    ***
012900030214     C     *DTAARA       DEFINE    COMPANY       @DTA50
013000030213     C                   IN        @DTA50
013100030213    ***
013200030213     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
013300030213     C                   MOVE      *DATE         #ISO
013400030213     C                   MOVE      #ISO          #TDAY
013500030213    ***
013600030213     C                   ENDSR
013700030213   S***S
013800030213     C     $PREP1        BEGSR
013900030213    ***
014000030703     C                   CLEAR                   RSRLHIST
014100030213     C                   EVAL      @STEP = 'STEP1'
014200030213    ***
014300030213    1C                   IF        @IM = 'A'
014400030213     C                   EVAL      *IN27 = *OFF
014500030227     C                   EVAL      @EMSG = 'ID # ASSIGNED WHEN CREATED.'
014600030307     C                   EVAL      SRSMAN = %SUBST(P@35:17:3)
014700030307     C                   EXSR      $GETSMAN
014800030307     C                   EVAL      SRASID = %SUBST(P@35:9:8)
014900030307     C                   EXSR      $GETLINK
015000030213     C                   LEAVESR
015100030213    1C                   ENDIF
015200030213    ***
015300030213     C                   EVAL      *IN27 = *ON
015400030213     C     KEY@RELID     CHAIN     SRF
015500030307     C                   EXSR      $GETSMAN
015600030307     C                   EXSR      $GETLINK
015700030703     C                   EVAL      HBEFORE = REC@DS
015800030213    ***
015900030213     C                   IF        SREFFDTE > 0
016000030213     C     SREFFDTE      MULT      10000.0001    I_BEGDT
016100030213     C                   ELSE
016200030213     C                   Z-ADD     SREFFDTE      I_BEGDT
016300030213     C                   ENDIF
016400030213    ***
016500030213     C                   IF        SRTRMDTE > 0
016600030213     C     SRTRMDTE      MULT      10000.0001    I_ENDDT
016700030213     C                   ELSE
016800030213     C                   Z-ADD     SRTRMDTE      I_ENDDT
016900030213     C                   ENDIF
017000030213    ***
017100030213     C                   ENDSR
017200030213   S***S
017300030307     C     $GETSMAN      BEGSR
017400030307    ***
017500030307     C     SRSMAN        CHAIN(N)  SMANR
017600030307     C                   IF        %FOUND(SMAN)
017700030307     C                   EXSR      $GETSNAME
017800030307     C                   MOVEL(P)  A@40          O_SNAME
017900030307     C                   ELSE
018000030307     C                   MOVEL(P)  '*UNKNOWN'    O_SNAME
018100030307     C                   EVAL      @EMSG = 'INVALID SALESMAN CODE'
018200030307     C                   ENDIF
018300030307    ***
018400030307     C                   ENDSR
018500030307   S***S
018600030307     C     $GETLINK      BEGSR
018700030307    ***
018800030307     C     SRASID        CHAIN     SXF
018900030307     C                   IF        NOT %FOUND(SPRAGXR2)
019000030307     C                   MOVE      *BLANKS       SXAGCY
019100030307     C                   MOVE      *BLANKS       SXSUPER
019200030307     C                   ENDIF
019300030307    ***
019400030307     C                   EVAL      O_AGCY = SXAGCY
019500030307     C                   EVAL      O_SUPER = SXSUPER
019600030307    ***
019700030307     C     SXAGCY        CHAIN     AGENR
019800030307     C                   IF        %FOUND(AGENCY)
019900030307     C                   MOVEL(P)  AGNAM1        O_ANAME
020000030307     C                   ELSE
020100030307     C                   MOVEL(P)  '*UNKNOWN'    O_ANAME
020200030307     C                   ENDIF
020300030307    ***
020400030307     C     SXSUPER       CHAIN     SAF
020500030307     C                   IF        %FOUND(SUPRAGCY)
020600030307     C                   MOVEL(P)  SANAME1       O_SUPRNAME
020700030307     C                   ELSE
020800030307     C                   MOVEL(P)  '*UNKNOWN'    O_SUPRNAME
020900030307     C                   ENDIF
021000030307    ***
021100030307     C                   ENDSR
021200030307   S***S
021300030214     C     $GETSNAME     BEGSR
021400030214    ***
021500030313     C                   CLEAR                   A@20
021600030214     C                   CLEAR                   A@40
021700030214    ***
021800030214     C                   IF        SFNAME <> *BLANKS
021900030313     C                   MOVEL     SFNAME        A@20
022000030214     C                   EXSR      $LDADDR
022100030214     C                   ENDIF
022200030214    ***
022300030214     C                   IF        SMI <> *BLANKS
022400030313     C                   MOVEL     SMI           A@20
022500030214     C                   EXSR      $LDADDR
022600030214     C                   ENDIF
022700030214    ***
022800030214     C                   IF        SLNAME <> *BLANKS
022900030313     C                   MOVEL     SLNAME        A@20
023000030214     C                   EXSR      $LDADDR
023100030214     C                   ENDIF
023200030214    ***
023300030214     C                   ENDSR
023400030214   S***S
023500030214     C     $LDADDR       BEGSR
023600030214    ***
023700030313     C                   EVAL      A@20 = %TRIM(A@20)
023800030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
023900030313     C                   CLEAR                   A@20
024000030214    ***
024100030214     C                   ENDSR
024200030214   S***S
024300030213     C     $STEP1        BEGSR
024400030213    ***
024500030213     C                   MOVEL     @EMSG         EMSG
024600030213     C                   EXFMT     IO01
024700030213     C                   MOVE      *BLANKS       EMSG
024800030213     C                   MOVE      *BLANKS       @EMSG
024900030213    ***
025000030213    1C                   IF        FKEY = F7
025100030213     C                   EVAL      @STEP = 'LEAVE'
025200030306     C                   MOVEL(P)  'X'           P@35
025300030213     C                   LEAVESR
025400030213    1C                   ENDIF
025500030213    ***
025600030213    1C                   IF        FKEY = F1
025700030213     C                   EVAL      @STEP = 'LEAVE'
025800030306     C                   MOVE      *BLANKS       P@35
025900030213     C                   LEAVESR
026000030213    1C                   ENDIF
026100030214    ***
026200110418     C                   IF        FKEY = F2
026300110418     C                   EVAL      @NTEPARM = '011' + KEY@RELID
026400110418     C                   CALL      'MDC010  '
026500110418     C                   PARM                    @NTEPARM         11
026600110418     C                   LEAVESR
026700110418     C                   END
026800110418    ***
026900030224    1C                   IF        FKEY = F4
027000030224    *C                   EXSR      $F4PROC
027100030224    *C                   LEAVESR
027200030224    1C                   ENDIF
027300030214    ***
027400030213     C                   EXSR      $VALID
027500030213    ***
027600030213    2C                   IF        @VP = 'Y'
027700030213     C                   EXSR      $I#O
027800030213     C                   EVAL      @STEP = 'LEAVE'
027900030306     C                   MOVEL(P)  REC@DS        P@35
028000030213     C                   LEAVESR
028100030213    2C                   ENDIF
028200030213    ***
028300030213     C                   ENDSR
028400030213   S***S
028500030224    *C     $F4PROC       BEGSR
028600030214    ***
028700030429     C                   MOVE      *ALL'X'       P@30             30
028800030307     C                   CALL      'FM473CL'
028900030429     C                   PARM                    P@30
029000030429     C                   IF        %SUBST(P@30:1:3) <> '*LR'
029100030429     C                   EVAL      SRASID = %SUBST(P@30:23:8)
029200030307     C                   EXSR      $GETLINK
029300030224     C                   ENDIF
029400030214    ***
029500030224    *C                   ENDSR
029600030214   S***S
029700030214     C     $VALID        BEGSR
029800030214    ***
029900030213    1C                   IF        @IM = 'A'
030000030214     C                   EXSR      $VALIDA
030100030214     C                   ELSE
030200030214     C                   EXSR      $VALIDC
030300030214     C                   ENDIF
030400030213    ***
030500030213     C                   ENDSR
030600030213   S***S
030700030213     C     $VALIDC       BEGSR
030800030213    ***
030900030213     C                   EVAL      @VP = 'N'
031000030213    ***
031100030214     C                   IF        I_ENDDT > 0
031200030214     C     *USA          TEST(DE)                I_ENDDT
031300030214     C                   IF        %ERROR
031400030214     C                   EVAL      @EMSG = 'TERMINATION DATE IS INVALID'
031500030214     C                   LEAVESR
031600030214     C                   ENDIF
031700030214     C                   ENDIF
031800030227    ***
031900030214     C                   EVAL      @VP = 'Y'
032000030213    ***
032100030213     C                   ENDSR
032200030213   S***S
032300030213     C     $VALIDA       BEGSR
032400030213    ***
032500030213     C                   EVAL      @VP = 'N'
032600030214     C                   EVAL      #8BEG = 0
032700030214     C                   EVAL      #8END = 0
032800030214    ***
032900030307     C                   IF        SRASID = *BLANKS
033000030307     C                   EVAL      @EMSG = 'LINK ID CANNOT BE BLANK'
033100030227     C                   LEAVESR
033200030227     C                   ENDIF
033300030214    ***
033400030307     C     SRASID        CHAIN     SXF
033500030307     C                   IF        NOT %FOUND(SPRAGXR2)
033600030307     C                   EVAL      @EMSG = 'INVALID AGENCY/S. AGENCY ID.'
033700030307     C                   LEAVESR
033800030307     C                   ENDIF
033900030307    ***
034000030213     C                   IF        I_BEGDT = 0
034100030213     C                   EVAL      @EMSG = 'EFFECTIVE DATE CANNOT BE ZERO'
034200030213     C                   LEAVESR
034300030213     C                   ENDIF
034400030213    ***
034500030213     C                   IF        I_BEGDT > 0
034600030213     C     *USA          TEST(DE)                I_BEGDT
034700030213     C                   IF        %ERROR
034800030213     C                   EVAL      @EMSG = 'EFFECTIVE DATE IS INVALID'
034900030213     C                   LEAVESR
035000030214     C                   ELSE
035100030214     C                   MOVE      I_BEGDT       #USA
035200030214     C                   MOVE      #USA          #ISO
035300030214     C                   MOVE      #ISO          #8BEG
035400030213     C                   ENDIF
035500030213     C                   ENDIF
035600030213    ***
035700030213     C                   IF        I_ENDDT > 0
035800030213     C     *USA          TEST(DE)                I_ENDDT
035900030213     C                   IF        %ERROR
036000030213     C                   EVAL      @EMSG = 'TERMINATION DATE IS INVALID'
036100030213     C                   LEAVESR
036200030214     C                   ELSE
036300030214     C                   MOVE      I_ENDDT       #USA
036400030214     C                   MOVE      #USA          #ISO
036500030214     C                   MOVE      #ISO          #8END
036600030214     C                   IF        #8END = 0
036700030214     C                   Z-ADD     99999999      #8END
036800030214     C                   ENDIF
036900030213     C                   ENDIF
037000030213     C                   ENDIF
037100030214    ***
037200030213     C                   EVAL      @VP = 'Y'
037300030214    ***
037400030214     C                   ENDSR
037500030214   S***S
037600030214     C     $I#O          BEGSR
037700030214    ***
037800030703    *C                   MOVE      *BLANKS       @TS40
037900030702    ***
038000030703    *C                   CALL      'TIMESTMP'
038100030703    *C                   PARM                    @TS40
038200030703    *C                   MOVEL     @TS40         @TIMESTAMP
038300030703    *C                   EVAL      HRELID = SRRELID
038400030703    *C                   EVAL      HJOB = @TSJOB
038500030703    *C                   EVAL      HUSERID = @TSUSER
038600030703    *C                   MOVE      #TSNBR        HNUMBER
038700030703    *C                   MOVE      #TSCYMD       HDATE
038800030703    *C                   MOVE      #TSTIME       HTIME
038900030214    ***
039000030214    1C                   IF        @IM = 'A'
039100030214    *** ADD RECORD
039200030214     C                   IF        I_BEGDT > 0
039300030214     C     I_BEGDT       MULT      10000.0001    SREFFDTE
039400030214     C                   ELSE
039500030214     C                   Z-ADD     I_BEGDT       SREFFDTE
039600030214     C                   ENDIF
039700030214    ***
039800030214     C                   IF        I_ENDDT > 0
039900030214     C     I_ENDDT       MULT      10000.0001    SRTRMDTE
040000030214     C                   ELSE
040100030214     C                   Z-ADD     I_ENDDT       SRTRMDTE
040200030214     C                   ENDIF
040300030214    ***
040400030214     C     *DTAARA       DEFINE    SRRELID#      #SEQ
040500030214     C     *LOCK         IN        #SEQ
040600030214     C                   ADD       1             #SEQ
040700030214     C                   MOVE      #SEQ          SRRELID
040800030306     C                   EVAL      %SUBST(P@35:1:8) = SRRELID
040900030214     C                   OUT       #SEQ
041000030214     C                   UNLOCK    #SEQ
041100030703     C                   EVAL      HRELID = SRRELID
041200030703     C                   EVAL      HAFTER = REC@DS
041300030703     C                   WRITE     RSRLHIST
041400030214    ***
041500030214     C                   WRITE     SRF
041600030214    ***
041700030214     C                   LEAVESR
041800030214    1C                   ENDIF
041900030214    *** CHANGE RECORD
042000030214     C                   IF        I_ENDDT > 0
042100030214     C     I_ENDDT       MULT      10000.0001    SRTRMDTE
042200030214     C                   ELSE
042300030214     C                   Z-ADD     I_ENDDT       SRTRMDTE
042400030214     C                   ENDIF
042500030214    ***
042600030703     C                   EVAL      HAFTER = REC@DS
042700030703     C                   WRITE     RSRLHIST
042800030214    ***
042900030214     C                   UPDATE    SRF
043000030214    ***
043100030214     C                   ENDSR
043200030214   S***S
