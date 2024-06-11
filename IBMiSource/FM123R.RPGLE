000100001130     F*********************************************************************
000200030626     F* FM123      - AGENCY/CARRIER COMMISSION OVERRIDE MAINTENANCE       *
000300001130     F*                                                                   *
000400001206     F* WRITTEN BY    STEPHEN KING 11/30/2000                             *
000500001130     F*               INNOVATIVE OUTSOURCING  2000                        *
000600001130     F*                                                                   *
000700001130     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
000800001130     F*            AGENCY/CARRIER COMMISSION OVERRIDE FILE.               *
000900001130     F*                                                                   *
001000001130     F*********************************************************************
001100001130     F* MODIFICATION HISTORY                                              *
001200001130     F* ### UUU CCYYMMDD X-->                                             *
001300001130     F* 000 SSK 20001130 ORIGINAL SOURCE                                  *
001400100812     F* 001 SSK 20100812 CHANGE TO ENSURE LAST DAY OF MONTH FOR TERM DATE *
001500001130     F*                                                                   *
001600001130     F*********************************************************************
001700001130     FCARMST    IF   E           K DISK
001800001130     FAGENCY    IF   E           K DISK
001900001207     FAGCAROV2  UF A E           K DISK
002000010120     FAGCAROV3  IF   E           K DISK    RENAME(RAGCAROV:A3) PREFIX(V:1)
002100010117     FCARMKSZ3  IF   E           K DISK    PREFIX(Z:1)
002200030626     FFM123D    CF   E             WORKSTN INFDS(WSDS)
002300010116     F                                     SFILE(S01SFL:RRT)
002400001130     ***
002500001130     D #USA            S               D   DATFMT(*USA)
002600001130     D #ISO            S               D   DATFMT(*ISO)
002700100812     D #DAY            S              2S 0
002800001130      *
002900001130    *** TIMESTAMP FIELDS DATA STRUCTURE
003000001130      *
003100001130     D @TIMESTAMP      DS
003200001130     D  #TSCYMD                1      8S 0
003300001130     D  #TSTIME                9     14S 0
003400001130     D  @TSJOB                15     24
003500001130     D  @TSUSER               25     34
003600001130     D  #TSNBR                35     40S 0
003700001130     ***
003800001130     D WSDS            DS
003900001130     D  FKEY                 369    369A
004000001130     ***
004100001130     D  F1             C                   CONST(X'31')
004200001130     D  F2             C                   CONST(X'32')
004300001130     D  F3             C                   CONST(X'33')
004400001130     D  F4             C                   CONST(X'34')
004500001130     D  F5             C                   CONST(X'35')
004600001130     D  F6             C                   CONST(X'36')
004700001130     D  F7             C                   CONST(X'37')
004800001130     D  F8             C                   CONST(X'38')
004900001130     D  F9             C                   CONST(X'39')
005000001130     D  F10            C                   CONST(X'3A')
005100001130     D  F11            C                   CONST(X'3B')
005200001130     D  F12            C                   CONST(X'3C')
005300001130     D  F13            C                   CONST(X'B1')
005400001130     D  F14            C                   CONST(X'B2')
005500001130     D  F15            C                   CONST(X'B3')
005600001130     D  F16            C                   CONST(X'B4')
005700001130     D  F17            C                   CONST(X'B5')
005800001130     D  F18            C                   CONST(X'B6')
005900001130     D  F19            C                   CONST(X'B7')
006000001130     D  F20            C                   CONST(X'B8')
006100001130     D  F21            C                   CONST(X'B9')
006200001130     D  F22            C                   CONST(X'BA')
006300001130     D  F23            C                   CONST(X'BB')
006400001130     D  F24            C                   CONST(X'BC')
006500001130     ***
006600100812     D MSG             S             70A   DIM(14) CTDATA PERRCD(1)             ERROR MESSAGES
006700001130     D @STEP           S              6A   INZ('STEP0 ')                        CONTROL FIELD
006800001130     D @HOLDAG         S              3A                                        HOLD AGENCY
006900001130     D @VALID          S              1A                                        VALID FIELDS ENTERED
007000001130     D @EXIST          S              1A                                        EXISTING REC Y/N
007100001130     D @UPDATE         S              1A                                        UPDATE FILE
007200001130     ***
007300001130     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
007400001130     D                UDS
007500001130     D  TITLE                201    240
007600001130     ***
007700001130     C                   DOU       @STEP = 'EXIT'
007800001130     C     @STEP         CASEQ     'STEP0 '      $STEP0
007900001130     C     @STEP         CASEQ     'STEP1 '      $STEP1
008000001130     C     @STEP         CASEQ     'STEP2 '      $STEP2
008100001130     C     @STEP         CASEQ     'STEP3 '      $STEP3
008200001130     C                   ENDCS
008300001130     C                   ENDDO
008400001130     C*
008500001130     C                   MOVE      *ON           *INLR
008600001130   S***S
008700001130     C     *INZSR        BEGSR
008800001130     C*
008900010117     C     *LIKE         DEFINE    ACCARC        @VCARR
009000010117     C     *LIKE         DEFINE    ACSZCD        @VSZCD
009100010117     C*
009200001130     C     @ACKEY        KLIST
009300001130     C                   KFLD                    I_AGNY
009400010117     C                   KFLD                    @KCA
009500010117     C                   KFLD                    #KED
009600010117     C                   KFLD                    #KTD
009700010117     C                   KFLD                    @KSC
009800001130     C*
009900010117     C     *LIKE         DEFINE    ACCARC        @KCA
010000010117     C     *LIKE         DEFINE    ACEFDT        #KED
010100010117     C     *LIKE         DEFINE    ACTRDT        #KTD
010200010117     C     *LIKE         DEFINE    ACSZCD        @KSC
010300010117     C*
010400001130     C     *ENTRY        PLIST
010500001130     C                   PARM                    @3PAGNY           3
010600010117     C*
010700010117     C                   MOVE      *ZEROS        RRT               4 0
010800010117     C                   MOVE      *ZEROS        #CNTREC           3 0
010900010117     C                   MOVE      *BLANKS       @1STLOOP          1
011000010117     C                   MOVE      *BLANKS       @SFLOOP           1
011100010117     C                   MOVE      *ZEROS        #8ISA             8 0
011200010117     C                   MOVE      *BLANKS       @@GC              1
011300010117     C                   MOVE      *BLANKS       @VCNAM           40
011400010117     C                   MOVE      *BLANKS       @@GD              1
011500010117     C                   MOVE      *BLANKS       @@GS              1
011600010117     C                   MOVE      *ZEROS        #VFRSZ            5 0
011700010117     C                   MOVE      *ZEROS        #VTOSZ            5 0
011800010117     C                   MOVE      *ZEROS        #VFRDT            8 0
011900010117     C                   MOVE      *ZEROS        #VTODT            8 0
012000010117     C                   MOVE      *ZEROS        #ECNT             2 0
012100010117     C                   MOVE      *BLANKS       @@A               1
012200010117     C                   MOVE      *BLANKS       @TS40            40
012300010117     C                   Z-ADD     #8ISA         #TRISO            8 0
012400010117     C                   Z-ADD     #8ISA         #EFISO            8 0
012500010117     C                   MOVE      *BLANKS       @VALID            1
012600010117     C                   MOVE      *BLANKS       @@E               1
012700010117     C                   MOVE      *BLANKS       @5                5
012800010117     C                   MOVE      *BLANKS       @3                3
012900010117     C                   MOVEL(P)  R2CARC        @P8               8
013000001130     C*
013100001130     C                   ENDSR
013200001130   S***S
013300001130     C     $STEP0        BEGSR
013400001130     C*
013500001218     C                   MOVEL(P)  @3PAGNY       I_AGNY
013600010116     C                   MOVE      *ZEROS        #ECNT
013700010116    ***
013800010116     C     I_AGNY        CHAIN(N)  AGENR
013900010116     C                   IF        %FOUND(AGENCY)
014000010116     C                   MOVEL(P)  AGNAM1        O_ANAM
014100010116     C                   ELSE
014200010116     C                   MOVE      *BLANKS       O_ANAM
014300010116     C                   ENDIF
014400010116    ***
014500010117     C                   MOVE      *ZEROS        RRT
014600010117     C                   MOVE      *ZEROS        #CNTREC
014700010116    ***
014800010116     C                   EXSR      $CLEAR
014900010116    ***
015000010116     C                   EXSR      $BUILD
015100010116    ***
015200010116     C                   MOVEL(P)  'STEP1'       @STEP
015300010116    ***
015400010116     C                   ENDSR
015500010116   S***S
015600010116     C* INITIALIZE THE SUBFILE
015700010116    ***
015800010116     C     $CLEAR        BEGSR
015900010116    ***
016000010116     C                   MOVEA     '011'         *IN(25)
016100010116     C                   WRITE     S01CTL
016200010116     C                   MOVEA     '010'         *IN(25)
016300010116     C                   Z-ADD     *ZERO         RRT
016400010116    ***
016500010116     C                   ENDSR
016600010116   S***S
016700010116     C* BUILD SUBFILE CONTROL ROUTINE
016800010116    ***
016900010116     C     $BUILD        BEGSR
017000010116    ***
017100010116     C                   MOVE      *ZEROS        #CNTREC
017200010117     C                   MOVE      '0'           @1STLOOP
017300010116     C                   MOVEA     '00'          *IN(33)
017400010117     C                   MOVE      '0'           @SFLOOP
017500010116    ***
017600010120     C     I_AGNY        SETLL     A3
017700010120     C                   DOU       %EOF(AGCAROV3) OR @SFLOOP = '1'
017800010120     C     I_AGNY        READE     A3
017900010120     C                   IF        NOT %EOF(AGCAROV3)
018000010116     C                   EXSR      $LOADSFL
018100010116     C                   ENDIF
018200010116     C                   ENDDO
018300010116    ***
018400010116     C                   ENDSR
018500010116   S***S
018600010116     C* LOAD SUBFILE RECORDS
018700010116    ***
018800010116     C     $LOADSFL      BEGSR
018900010116    ***
019000010116     C                   MOVE      *ON           *IN25
019100010120     C                   MOVEL(P)  VCSZCD        S1SZCD
019200010116     C                   MOVE      *BLANKS       S1SEL
019300010120     C                   MOVEL(P)  VCCARC        S1CARR
019400010117     C*
019500010120     C                   MOVEL(P)  VCCARC        @VCARR
019600010116     C                   EXSR      $VCARR
019700010116     C                   MOVEL(P)  @VCNAM        S1CNAM
019800010117     C*
019900010120     C                   Z-ADD     VCEFDT        HEFISO
020000010117     C*
020100010120     C                   MOVE      VCEFDT        #8ISA
020200010116     C                   EXSR      $ISOUSA
020300010116     C                   MOVE      #8ISA         S1EFDT
020400010117     C*
020500010120     C                   Z-ADD     VCTRDT        HTRISO
020600010117     C*
020700010120     C                   MOVE      VCTRDT        #8ISA
020800010116     C                   EXSR      $ISOUSA
020900010116     C                   MOVE      #8ISA         S1TRDT
021000010117     C*
021100010120     C                   MOVE      VCSZCD        @VSZCD
021200010116     C                   EXSR      $VSZCD
021300010116     C                   Z-ADD     #VFRSZ        S1FRSZ
021400010116     C                   Z-ADD     #VTOSZ        S1TOSZ
021500010120     C                   Z-ADD     VCOVPC        S1OVPC
021600010120     C                   Z-ADD     VCOVPP        S1OVPP
021700010120     C                   Z-ADD     VCOVRA        S1OVRA
021800010116     C*
021900010116     C                   ADD       1             RRT
022000010116     C*
022100010116     C                   IF        @1STLOOP = '0'
022200010116     C                   Z-ADD     RRT           SFLPOS
022300010116     C                   MOVE      '1'           @1STLOOP
022400010116     C                   ENDIF
022500010116     C*
022600010116     C                   WRITE     S01SFL
022700010116     C*
022800010116     C                   ADD       1             #CNTREC
022900010126     C                   IF        #CNTREC = 600
023000010116     C                   MOVE      '1'           @SFLOOP
023100010116     C                   ENDIF
023200010116    ***
023300010116     C                   ENDSR
023400010116   S***S
023500010116     C     $VCARR        BEGSR
023600010116    ***
023700010117     C                   MOVE      'E'           @@GC
023800010117     C                   MOVE      *BLANKS       @VCNAM
023900010116    ***
024000010116     C                   IF        @VCARR <> *BLANKS
024100010116     C     @VCARR        CHAIN(N)  CARMSR
024200010116     C                   IF        %FOUND(CARMST)
024300010116     C                   MOVE      'G'           @@GC
024400010116     C                   MOVEL(P)  CNAME         @VCNAM
024500010116     C                   ENDIF
024600010116     C                   ENDIF
024700010116    ***
024800010116     C                   ENDSR
024900010116   S***S
025000010116     C     $ISOUSA       BEGSR
025100010116    ***
025200010117     C                   MOVE      'E'           @@GD
025300010116    1C                   IF        #8ISA <> 0
025400010116     C     *ISO          TEST (DE)               #8ISA
025500010116    2C                   IF        NOT %ERROR
025600010117     C                   MOVE      #8ISA         #ISO
025700010116     C                   MOVE      #ISO          #USA
025800010117     C                   MOVE      #USA          #8ISA
025900010116     C                   MOVE      'G'           @@GD
026000010116    2C                   ELSE
026100010116     C                   MOVE      *ZEROS        #8ISA
026200010116    2C                   ENDIF
026300010116    1C                   ENDIF
026400010116    ***
026500010116     C                   ENDSR
026600001130   S***S
026700010116     C     $VSZCD        BEGSR
026800010116    ***
026900010117     C                   MOVE      'E'           @@GS
027000010117     C                   MOVE      *ZEROS        #VFRSZ
027100010117     C                   MOVE      *ZEROS        #VTOSZ
027200010117     C                   MOVE      *ZEROS        #VFRDT
027300010117     C                   MOVE      *ZEROS        #VTODT
027400010116    ***
027500010116     C     SIZKEY        KLIST
027600010116     C                   KFLD                    @VCARR
027700010116     C                   KFLD                    @VSZCD
027800010116     C                   IF        @VSZCD <> *BLANKS
027900010116     C     SIZKEY        CHAIN(N)  RCARMKSZ
028000010116     C                   IF        %FOUND(CARMKSZ3)
028100010116     C                   MOVE      'G'           @@GS
028200010117     C                   MOVE      ZZFRSZ        #VFRSZ
028300010117     C                   MOVE      ZZTOSZ        #VTOSZ
028400010117     C                   MOVE      ZZFRDT        #8ISA
028500010116     C                   EXSR      $ISOUSA
028600010116     C                   MOVE      #8ISA         #VFRDT
028700010117     C                   MOVE      ZZTODT        #8ISA
028800010116     C                   EXSR      $ISOUSA
028900010117     C                   MOVE      #8ISA         #VTODT
029000010116     C                   ENDIF
029100010116     C                   ENDIF
029200010117    ***
029300010117     C                   IF        @VSZCD = *BLANKS
029400010117     C                   MOVE      'G'           @@GS
029500010117     C                   ENDIF
029600010116    ***
029700010116     C                   ENDSR
029800010116   S***S
029900001130     C* PRESENT INITIAL SCREEN
030000001130     C*
030100001130     C     $STEP1        BEGSR
030200010116    ***
030300010116     C                   EXSR      $DISPLAY
030400010116     C                   MOVE      *BLANKS       S1MSG
030500010117     C                   ADD       1             #ECNT
030600010116    ***
030700010116     C                   IF        FKEY = F1
030800010116     C                   MOVEL(P)  'EXIT'        @STEP
030900010116     C                   LEAVESR
031000010116     C                   ENDIF
031100010116    ***
031200010116     C                   IF        FKEY = F6
031300010116     C                   MOVEL(P)  'STEP2'       @STEP
031400010117     C                   MOVE      'A'           @@A
031500010116     C                   LEAVESR
031600010116     C                   ENDIF
031700010116    ***
031800010116     C                   EXSR      $CHKSELC
031900010116    ***
032000010116     C                   IF        #ECNT >= 3
032100010116     C                   MOVEL(P)  'STEP0'       @STEP
032200010116     C                   LEAVESR
032300010116     C                   ENDIF
032400010116    ***
032500010116     C                   ENDSR
032600001130     C*
032700001130   S***S
032800010116     C* DISPLAY THE SCREEN
032900010116    ***
033000010116     C     $DISPLAY      BEGSR
033100010116    ***
033200010116     C                   WRITE     S01REC
033300010116     C                   EXFMT     S01CTL
033400010116     C*
033500010116     C                   MOVE      *BLANKS       S1MSG
033600010116    ***
033700010116     C                   ENDSR
033800010116   S***S
033900010116     C     $STEP2        BEGSR
034000010116    ***
034100010116     C                   MOVE      *BLANKS       R2CARC
034200010116     C                   MOVE      *BLANKS       O_CNAM
034300010116     C                   MOVE      *ZEROS        R2EFDT
034400010116     C                   MOVE      *ZEROS        R2TRDT
034500010116     C                   MOVE      *BLANKS       R2SZCD
034600010116     C                   MOVE      *ZEROS        O_FRSZ
034700010116     C                   MOVE      *ZEROS        O_TOSZ
034800010116     C                   MOVE      *ZEROS        O_FRDT
034900010116     C                   MOVE      *ZEROS        O_TODT
035000010116     C                   MOVE      *ZEROS        R2OVPC
035100010116     C                   MOVE      *ZEROS        R2OVRA
035200010116     C                   MOVE      *ZEROS        R2OVPP
035300010116    ***
035400010117     C                   IF        @@A = 'A'
035500010116     C                   MOVEL(P)  'STEP3'       @STEP
035600010117     C                   ENDIF
035700010116    ***
035800010116     C                   ENDSR
035900010116   S***S
036000010116     C     $STEP3        BEGSR
036100010116    ***
036200010116     C                   EXFMT     IO02
036300010116     C*
036400010116     C                   MOVE      *BLANKS       R2MSG
036500010116    ***
036600010116    1C                   IF        FKEY = F1
036700010117     C                   MOVEL(P)  'STEP0'       @STEP
036800010116     C                   LEAVESR
036900010116    1C                   ENDIF
037000010116    ***
037100010116    1C                   IF        FKEY = F5
037200010116     C                   EXSR      $F5PROC
037300010116     C                   LEAVESR
037400010116    1C                   ENDIF
037500010116    ***
037600010116    1C                   IF        FKEY = F9
037700010116     C                   EXSR      $F9PROC
037800010116     C                   LEAVESR
037900010116    1C                   ENDIF
038000010116    ***
038100010116     C                   MOVE      *BLANKS       O_CNAM
038200010116     C                   MOVE      *ZEROS        O_FRSZ
038300010116     C                   MOVE      *ZEROS        O_TOSZ
038400010116     C                   MOVE      *ZEROS        O_FRDT
038500010116     C                   MOVE      *ZEROS        O_TODT
038600010116    ***
038700010116     C                   EXSR      $VALIDATE
038800010117    ***
038900010117    1C                   IF        @VALID = 'Y'
039000010117     C                   EXSR      $UPDATE
039100010117    1C                   ENDIF
039200010116    ***
039300010116     C                   ENDSR
039400010116   S***S
039500010116     C     $F5PROC       BEGSR
039600010116    ***
039700010117     C                   MOVE      *BLANKS       @3
039800010116     C                   CALL      'FM002CL'
039900010116     C                   PARM                    @3
040000010116    ***
040100010116    1C                   IF        @3 = '*LR'
040200100812     C                   EVAL      R2MSG = MSG(9)
040300010116     C                   LEAVESR
040400010116    1C                   ENDIF
040500010116    ***
040600010116     C                   MOVEL(P)  @3            @VCARR
040700010116     C                   EXSR      $VCARR
040800010116     C                   MOVEL(P)  @VCNAM        O_CNAM
040900010116     C                   MOVEL(P)  @3            R2CARC
041000010116    ***
041100010116     C                   ENDSR
041200010116   S***S
041300010116     C     $F9PROC       BEGSR
041400010116    ***
041500010116     C                   MOVEL(P)  R2CARC        @VCARR
041600010116     C                   EXSR      $VCARR
041700010116    1C                   IF        @@GC = 'E'
041800100812     C                   EVAL      R2MSG = MSG(13)
041900010116     C                   LEAVESR
042000010116    1C                   ENDIF
042100010116     C*
042200010117     C                   MOVEL(P)  R2CARC        @P8
042300010116     C                   CALL      'FM005CL'
042400010116     C                   PARM                    @P8
042500010116     C*
042600010117     C     5             SUBST     @P8:4         @5
042700010117     C     3             SUBST     @P8:4         @3
042800010116    1C                   IF        @3 = '*LR'
042900100812     C                   EVAL      R2MSG = MSG(9)
043000010116     C                   LEAVESR
043100010116    1C                   ENDIF
043200010116     C*
043300010116     C                   MOVEL(P)  @5            R2SZCD
043400010116     C                   MOVE      @5            @VSZCD
043500010116     C                   EXSR      $VSZCD
043600010116     C                   Z-ADD     #VFRSZ        O_FRSZ
043700010116     C                   Z-ADD     #VTOSZ        O_TOSZ
043800010116     C                   Z-ADD     #VFRDT        O_FRDT
043900010116     C                   Z-ADD     #VTODT        O_TODT
044000010116    ***
044100010116     C                   ENDSR
044200010116   S***S
044300010116     C* VALIDATION ROUTINE
044400001130     C     $VALIDATE     BEGSR
044500010116    ***
044600010117     C                   MOVE      'N'           @VALID
044700010116    ***
044800010116     C                   MOVE      R2SZCD        @VSZCD
044900010116     C                   EXSR      $VSZCD
045000010116     C                   IF        @@GS = 'E'
045100100812     C                   EVAL      R2MSG = MSG(1)
045200010116     C                   LEAVESR
045300010116     C                   ENDIF
045400010116     C*
045500010116     C                   Z-ADD     #VFRSZ        O_FRSZ
045600010116     C                   Z-ADD     #VTOSZ        O_TOSZ
045700010116     C                   Z-ADD     #VFRDT        O_FRDT
045800010116     C                   Z-ADD     #VTODT        O_TODT
045900010116    ***
046000010116     C                   MOVEL(P)  R2CARC        @VCARR
046100010116     C                   EXSR      $VCARR
046200010116     C                   IF        @@GC = 'E'
046300100812     C                   EVAL      R2MSG = MSG(2)
046400010116     C                   LEAVESR
046500010116     C                   ENDIF
046600010116     C*
046700010116     C                   MOVEL(P)  @VCNAM        O_CNAM
046800010116    ***
046900010116     C                   MOVE      R2EFDT        #8ISA
047000010116     C                   EXSR      $USAISO
047100010116     C                   IF        @@GD = 'E'
047200100812     C                   EVAL      R2MSG = MSG(3)
047300010116     C                   LEAVESR
047400010116     C                   ENDIF
047500010116     C*
047600010117     C                   Z-ADD     #8ISA         #EFISO
047700010116    ***
047800010116     C                   IF        R2TRDT <> 0
047900010116     C                   MOVE      R2TRDT        #8ISA
048000010116     C                   EXSR      $USAISO
048100010116     C                   IF        @@GD = 'E'
048200100812     C                   EVAL      R2MSG = MSG(4)
048300010116     C                   LEAVESR
048400010116     C                   ENDIF
048500100812     C*
048600100812     C                   MOVE      #8ISA         #ISO
048700100812     C                   EXTRCT    #ISO:*D       #DAY
048800100812     C                   IF        #DAY = 01
048900100812     C                   SUBDUR    1:*D          #ISO
049000100812     C     *USA          MOVE      #ISO          #SHOULDBE         8 0
049100100812     C                   EVAL      R2MSG = MSG(14)
049200100812     C                   EVAL      R2MSG = %TRIM(R2MSG) + %EDITC(#SHOULDBE:'Y')
049300100812     C                   LEAVESR
049400100812     C                   ENDIF
049500010116     C*
049600010117     C                   Z-ADD     #8ISA         #TRISO
049700010116     C                   ELSE
049800010116     C                   MOVE      *ZEROS        #TRISO
049900010116     C                   ENDIF
050000010116    ***
050100010116     C                   IF        #TRISO <> 0 AND #TRISO < #EFISO
050200100812     C                   EVAL      R2MSG = MSG(5)
050300010116     C                   LEAVESR
050400010116     C                   ENDIF
050500010116    ***
050600001130     C                   SELECT
050700010116     C                   WHEN      R2OVPC = 0 AND R2OVPP = 0 AND R2OVRA = 0
050800100812     C                   EVAL      R2MSG = MSG(8)
050900010116     C                   LEAVESR
051000010116     C                   WHEN      R2OVPP <> 0 AND R2OVRA <> 0
051100100812     C                   EVAL      R2MSG = MSG(7)
051200010116     C                   LEAVESR
051300010116     C                   WHEN      R2OVPC <> 0 AND R2OVRA <> 0
051400100812     C                   EVAL      R2MSG = MSG(7)
051500010116     C                   LEAVESR
051600010116     C                   WHEN      R2OVPC <> 0 AND R2OVPP <> 0
051700100812     C                   EVAL      R2MSG = MSG(7)
051800010116     C                   LEAVESR
051900010116     C                   WHEN      R2OVPP > 100.0000
052000100812     C                   EVAL      R2MSG = MSG(6)
052100010116     C                   LEAVESR
052200010116     C                   WHEN      R2OVPC > 100.0000
052300100812     C                   EVAL      R2MSG = MSG(11)
052400010116     C                   LEAVESR
052500001130     C                   ENDSL
052600010116    ***
052700010116     C                   EXSR      $CHKDUPE
052800010116     C                   IF        R2MSG <> *BLANKS
052900010116     C                   LEAVESR
053000010116     C                   ENDIF
053100010116    ***
053200010116     C                   MOVE      'Y'           @VALID
053300010116    ***
053400001130     C                   ENDSR
053500001130   S***S
053600010116     C     $USAISO       BEGSR
053700010116    ***
053800010117     C                   MOVE      'E'           @@GD
053900010116    1C                   IF        #8ISA <> 0
054000010116     C     *USA          TEST (DE)               #8ISA
054100010116    2C                   IF        NOT %ERROR
054200010117     C                   MOVE      #8ISA         #USA
054300010116     C                   MOVE      #USA          #ISO
054400010117     C                   MOVE      #ISO          #8ISA
054500010116     C                   MOVE      'G'           @@GD
054600010116    2C                   ELSE
054700010116     C                   MOVE      *ZEROS        #8ISA
054800010116    2C                   ENDIF
054900010116    1C                   ENDIF
055000010116    ***
055100010116     C                   ENDSR
055200010116   S***S
055300010116     C     $CHKDUPE      BEGSR
055400010116    ***
055500010117     C                   MOVEL(P)  R2CARC        @KCA
055600010117     C                   Z-ADD     #EFISO        #KED
055700010117     C                   Z-ADD     #TRISO        #KTD
055800010117     C                   MOVEL(P)  R2SZCD        @KSC
055900010116     C     @ACKEY        CHAIN(N)  RAGCAROV
056000010117     C                   IF        %FOUND(AGCAROV2) AND @@A = 'A'
056100100812     C                   EVAL      R2MSG = MSG(12)
056200010116     C                   ENDIF
056300010116    ***
056400010117     C                   IF        %FOUND(AGCAROV2) AND @@A = 'C'
056500010117     C                   IF        S1CARR <> R2CARC OR S1EFDT <> R2EFDT OR
056600010117     C                             S1TRDT <> R2TRDT OR S1SZCD <> R2SZCD
056700100812     C                   EVAL      R2MSG = MSG(12)
056800010117     C                   ENDIF
056900010116     C                   ENDIF
057000010116    ***
057100010116     C                   ENDSR
057200010116   S***S
057300001130     C* UPDATE ROUTINE - CREATE IF EXISTENCE = 'N' OR UPDATE IF EXISTENCE = 'Y'
057400001130     C     $UPDATE       BEGSR
057500001130     C*
057600001130     C                   CLEAR                   @TIMESTAMP
057700010117     C                   MOVE      *BLANKS       @TS40
057800010117     C                   CALL      'TIMESTMP'
057900001130     C                   PARM                    @TS40
058000001130     C                   MOVEL     @TS40         @TIMESTAMP
058100001130     C*
058200010117     C                   IF        @@A = 'A'                                    NEW RECORD
058300001130     C                   CLEAR                   RAGCAROV
058400001130     C                   MOVEL     I_AGNY        ACAGNY
058500010117     C                   MOVEL     R2CARC        ACCARC
058600001218     C                   Z-ADD     #EFISO        ACEFDT
058700001218     C                   Z-ADD     #TRISO        ACTRDT
058800010117     C                   MOVEL     R2SZCD        ACSZCD
058900010116     C                   Z-ADD     R2OVRA        ACOVRA
059000010116     C                   Z-ADD     R2OVPP        ACOVPP
059100010116     C                   Z-ADD     R2OVPC        ACOVPC
059200001130     C                   MOVEL     @TSUSER       @@USRC
059300001130     C                   MOVE      #TSCYMD       @@DTEC
059400001130     C                   MOVE      #TSTIME       @@TMEC
059500001130     C                   WRITE     RAGCAROV
059600001130     C                   ELSE                                                   UPDATE CURRENT REC
059700010117     C                   MOVEL(P)  S1CARR        @KCA
059800010117     C                   Z-ADD     HEFISO        #KED
059900010117     C                   Z-ADD     HTRISO        #KTD
060000010117     C                   MOVEL(P)  S1SZCD        @KSC
060100010117     C     @ACKEY        CHAIN     RAGCAROV
060200010117     C                   MOVEL     R2CARC        ACCARC
060300010117     C                   Z-ADD     #EFISO        ACEFDT
060400010117     C                   Z-ADD     #TRISO        ACTRDT
060500010117     C                   MOVEL     R2SZCD        ACSZCD
060600010116     C                   Z-ADD     R2OVRA        ACOVRA
060700010116     C                   Z-ADD     R2OVPP        ACOVPP
060800010116     C                   Z-ADD     R2OVPC        ACOVPC
060900001130     C                   MOVEL     @TSUSER       @@USRU
061000001130     C                   MOVE      #TSCYMD       @@DTEU
061100001130     C                   MOVE      #TSTIME       @@TMEU
061200001130     C                   UPDATE    RAGCAROV
061300001130     C                   ENDIF
061400001130     C*
061500001130     C                   ENDSR
061600001130   S***S
061700010117     C     $CHKSELC      BEGSR
061800010117    ***
061900030626     C                   DOU       %EOF(FM123D)
062000010117     C                   READC     S01SFL
062100030626     C                   IF        NOT %EOF(FM123D) AND S1SEL <> *BLANKS
062200010117     C*
062300010117     C                   SELECT
062400010117     C                   WHEN      S1SEL = 'C'
062500010117     C                   EXSR      $CHGCTL
062600010117     C                   ENDSL
062700010117     C*
062800010117     C                   IF        S1MSG <> *BLANKS
062900010117     C                   LEAVESR
063000010117     C                   ENDIF
063100010117     C*
063200010117     C                   MOVE      *BLANKS       S1SEL
063300010117     C                   UPDATE    S01SFL
063400010117     C*
063500010117     C                   ENDIF
063600010117     C                   ENDDO
063700010117    ***
063800010117     C                   MOVE      7             #ECNT
063900010117    ***
064000010117     C                   ENDSR
064100010117   S***S
064200010117     C* CHANGE CONTROL ROUTINE
064300010117    ***
064400010117     C     $CHGCTL       BEGSR
064500010117    ***
064600010117     C                   MOVE      'C'           @@A                            ACTION TYPE
064700010117     C                   EXSR      $LOADNLOCK
064800010117     C*
064900010117     C                   IF        S1MSG  <> *BLANKS
065000010117     C                   LEAVESR
065100010117     C                   ENDIF
065200010117    ***
065300010117     C                   MOVE      '0'           @@E
065400010117     C                   DOU       @@E = '1'
065500010117     C*
065600010117     C                   EXSR      $STEP3
065700010117     C*
065800010117     C                   IF        @STEP = 'STEP0'
065900010117     C                   MOVE      '1'           @@E
066000010117     C                   ENDIF
066100010117     C*
066200010117     C                   ENDDO
066300010117    ***
066400010117     C                   ENDSR
066500010117   S***S
066600010117     C* LOAD SCREEN 2 W/O LOCKING REC
066700010117    ***
066800010117     C     $LOADNLOCK    BEGSR
066900010117    ***
067000010117     C                   EXSR      $STEP2
067100010117    ***
067200010117     C                   MOVEL     S1CARR        R2CARC
067300010117     C                   MOVEL(P)  S1CARR        @VCARR
067400010117     C                   EXSR      $VCARR
067500010117     C                   MOVEL(P)  @VCNAM        O_CNAM
067600010117     C                   Z-ADD     S1EFDT        R2EFDT
067700010117     C                   Z-ADD     S1TRDT        R2TRDT
067800010117     C                   MOVEL     S1SZCD        R2SZCD
067900010117     C                   MOVE      S1SZCD        @VSZCD
068000010117     C                   EXSR      $VSZCD
068100010117     C                   Z-ADD     #VFRSZ        O_FRSZ
068200010117     C                   Z-ADD     #VTOSZ        O_TOSZ
068300010117     C                   Z-ADD     #VFRDT        O_FRDT
068400010117     C                   Z-ADD     #VTODT        O_TODT
068500010117     C                   Z-ADD     S1OVPC        R2OVPC
068600010117     C                   Z-ADD     S1OVRA        R2OVRA
068700010117     C                   Z-ADD     S1OVPP        R2OVPP
068800010117    ***
068900010117     C                   ENDSR
069000001130   X***X
069100010116      *  11111111112222222222333333333344444444445
069200010116123456*8901234567890123456789012345678901234567890
069300001130**   ERROR MESSAGE ARRAY
069400010117GROUP SIZE CODE IS INVALID OR BLANK
069500010117CARRIER CODE INVALID OR BLANK
069600010117EFFECTIVE DATE INVALID OR ZERO; MMDDCCYY FORMAT
069700010117TERM DATE INVALID OR ZERO; MMDDCCYY FORMAT
069800010117TERM DATE LESS THAN EFFECTIVE DATE
069900010117%AGE OF PREMIUM CANNOT EXCEED 100%
070000010117CHOOSE ONLY ONE %AGE OR AMOUNT
070100010117CHOOSE %AGE OR AMOUNT; CANNOT BOTH BE 0
070200010117NO SELECTION MADE
070300010117NO AGENCY/CARRIER RECORDS EXIST
070400010117%AGE OF COMMISSION CANNOT EXCEED 100%
070500010117AGENCY/CARRIER RECORD EXISTS, ADD DENIED
070600010117VALID CARRIER CODE REQUIRED FOR F9 FUNCTION
070700100812TERM DATE MUST BE END OF MONTH, PLEASE ENTER:
