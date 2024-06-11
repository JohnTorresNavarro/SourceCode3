000100060508     F******************************************************************
000200060508     F* FI040      GROUP BENEFIT SERVICES SOFTWARE           1988      *
000300060508     F*                                                                *
000400060508     F*            WRITTEN BY - MICHAEL C. DUNPHY                      *
000500060508     F*            DATE - 07/13/88                                     *
000600060508     F*                                                                *
000700060508     F*            REVISED: 06/20/90   WALTER J PICCININI              *
000800060508     F*            MODIFY GRATE PROCESSING. READ FILE & COMPARE FROM-TO*
000900060508     F*            DATES TO GET CORRECT GRATE RECORD.....              *
001000060508     F*                                                                *
001100060508     F*            REVISED: 08/27/90   WALTER J. PICCININI
001200060508     F*            ADD SCREEN IO03. DISPLAY ALL DATE RANGES FOR PLAN #
001300060508     F*            SELECT WITH AN "X" DATE RANGE TO UPDATE.
001400060508     F*----------------------------------------------------------------*
001500990426     F*  MODIFICATION : COPY OF FM030 MODIFIED FOR COVERAGE PLAN MASTER
001600990426     F*                 FILE INQUIRY ONLY.                3/98   MLF
001700060508     F*                                                                *
001800060503     F* DMA 5.3.06  MAKE ARRAYS 20 ELEMENTS LONG                       *
001900060511     F*                                                                *
002000060511     F* SSK 5.8.06  TOTAL REWRITE OF S36 CODE; ACTUALLY I DELETED ALL  *
002100060511     F*               OF THE S/36 CODE AND COPIED PIECES OF THE        *
002200060511     F*               MAINTENANCE PROGRAM.                             *
002300070925     F* dlk 09/25/07 - change bilrte and netrte to 6 decimal           *
002400130612     F*                                                                *
002500130612     F* SSK.06.12.2013 DANG, 100+ RATE RECS FOR A SINGLE RANGE? SHEESSHH, INCREASE TABLE SIZES
002600130612     F*                                                                *
002700130612     F*                                                                *
002800130612     F*                                                                *
002900060508     F******************************************************************
003000060508     FFI040D    CF   E             WORKSTN INFDS(WSDS)
003100060509     F                                     SFILE(IO03S:RRT)
003200100322y2k  FGRAT24    IF   E           K DISK
003300060508y2k  FPLNMST    IF   E           K DISK
003400060508y2k  FTRSMST    IF   E           K DISK
003500060508y229 FSUBMST    IF   E           K DISK
003600060508     FCARMST    IF   E           K DISK
003700060508   X***X
003800060509     D @PARM           DS
003900060509     D  #TRSTN                 1      3S 0
004000060509     D  #SUBNO                 4      6S 0
004100060509     D  @PLNCD                 7     10A
004200060509     D  @TRNAM                11     24A
004300060509     D  @SBNAM                25     38A
004400060509     D  @PCNAM                39     52A
004500060510     **
004600060510     D                 DS
004700060510     D @@3                     1      3A
004800060510     D ##3                     1      3S 0
004900060509     **
005000060508     D WSDS            DS
005100060508     D  FKEY                 369    369A
005200060508     **
005300060508     D  F1             C                   CONST(X'31')
005400060508     D  F2             C                   CONST(X'32')
005500060508     D  F3             C                   CONST(X'33')
005600060508     D  F4             C                   CONST(X'34')
005700060508     D  F5             C                   CONST(X'35')
005800060508     D  F6             C                   CONST(X'36')
005900060508     D  F7             C                   CONST(X'37')
006000060508     D  F8             C                   CONST(X'38')
006100060508     D  F9             C                   CONST(X'39')
006200060508     D  F10            C                   CONST(X'3A')
006300060508     D  F11            C                   CONST(X'3B')
006400060508     D  F12            C                   CONST(X'3C')
006500060508     D  F13            C                   CONST(X'B1')
006600060508     D  F14            C                   CONST(X'B2')
006700060508     D  F15            C                   CONST(X'B3')
006800060508     D  F16            C                   CONST(X'B4')
006900060508     D  F17            C                   CONST(X'B5')
007000060508     D  F18            C                   CONST(X'B6')
007100060508     D  F19            C                   CONST(X'B7')
007200060508     D  F20            C                   CONST(X'B8')
007300060508     D  F21            C                   CONST(X'B9')
007400060508     D  F22            C                   CONST(X'BA')
007500060508     D  F23            C                   CONST(X'BB')
007600060508     D  F24            C                   CONST(X'BC')
007700060508     D  ROLLDOWN       C                   CONST(X'F4')
007800060508     D  ROLLUP         C                   CONST(X'F5')
007900060509     D*
008000060508  31 D @STEP           S              5A   INZ
008100060509     D @SMSG           S             40A   INZ
008200060509     D #USA            S               D   DATFMT(*USA)
008300060509     D #ISO            S               D   DATFMT(*ISO)
008400060510     D*
008500130612     D S@              S              1A   DIM(200)
008600130612     D A@              S             10A   DIM(200)
008700130612     D T@              S              2A   DIM(200)
008800130612     D B@              S             11S 6 DIM(200)
008900130612     D N@              S             11S 6 DIM(200)
009000130612     D C@              S             15A   DIM(200)
009100060510     D Z               S              3S 0
009200060509     D*
009300981231  72 D                UDS
009400060510  73 D  CONAME               201    240
009500060510     D*
009600060510     D                 DS
009700060510     D ST@                     1     10    DIM(10)
009800060510     D ST01                   01     01A
009900060510     D ST02                   02     02A
010000060510     D ST03                   03     03A
010100060510     D ST04                   04     04A
010200060510     D ST05                   05     05A
010300060510     D ST06                   06     06A
010400060510     D ST07                   07     07A
010500060510     D ST08                   08     08A
010600060510     D ST09                   09     09A
010700060510     D ST10                   10     10A
010800060509     D*
010900060510     D                 DS
011000060510     D AB@                     1    100    DIM(10)
011100060510     D AB01                   01     10A
011200060510     D AB02                   11     20A
011300060510     D AB03                   21     30A
011400060510     D AB04                   31     40A
011500060510     D AB05                   41     50A
011600060510     D AB06                   51     60A
011700060510     D AB07                   61     70A
011800060510     D AB08                   71     80A
011900060510     D AB09                   81     90A
012000060510     D AB10                   91    100A
012100060510     D*
012200060510     D                 DS
012300060510     D TC@                     1     20A   DIM(10)
012400060510     D TC01                    1      2A
012500060510     D TC02                    3      4A
012600060510     D TC03                    5      6A
012700060510     D TC04                    7      8A
012800060510     D TC05                    9     10A
012900060510     D TC06                   11     12A
013000060510     D TC07                   13     14A
013100060510     D TC08                   15     16A
013200060510     D TC09                   17     18A
013300060510     D TC10                   19     20A
013400060510     D*
013500060510     D                 DS
013600070925     D BR@                     1    110S 6 DIM(10)
013700070925     D BR01                    1     11S 6
013800070925     D BR02                   12     22S 6
013900070925     D BR03                   23     33S 6
014000070925     D BR04                   34     44S 6
014100070925     D BR05                   45     55S 6
014200070925     D BR06                   56     66S 6
014300070925     D BR07                   67     77S 6
014400070925     D BR08                   78     88S 6
014500070925     D BR09                   89     99S 6
014600070925     D BR10                  100    110S 6
014700060510     D*
014800060510     D                 DS
014900070925     D NR@                     1    110S 6 DIM(10)
015000070925     D NR01                    1     11S 6
015100070925     D NR02                   12     22S 6
015200070925     D NR03                   23     33S 6
015300070925     D NR04                   34     44S 6
015400070925     D NR05                   45     55S 6
015500070925     D NR06                   56     66S 6
015600070925     D NR07                   67     77S 6
015700070925     D NR08                   78     88S 6
015800070925     D NR09                   89     99S 6
015900070925     D NR10                  100    110S 6
016000060510     D*
016100060510     D                 DS
016200060510     D CG@                     1    150A   DIM(10)
016300060510     D CG01                    1     15A
016400060510     D CG02                   16     30A
016500060510     D CG03                   31     45A
016600060510     D CG04                   46     60A
016700060510     D CG05                   61     75A
016800060510     D CG06                   76     90A
016900060510     D CG07                   91    105A
017000060510     D CG08                  106    120A
017100060510     D CG09                  121    135A
017200060510     D CG10                  136    150A
017300060510     D*
017400060510     D                 DS
017500060510     D AFR                     1     60  0 DIM(20)
017600060510     D  PABF01                 1      3  0
017700060510     D  PABF02                 4      6  0
017800060510     D  PABF03                 7      9  0
017900060510     D  PABF04                10     12  0
018000060510     D  PABF05                13     15  0
018100060510     D  PABF06                16     18  0
018200060510     D  PABF07                19     21  0
018300060510     D  PABF08                22     24  0
018400060510     D  PABF09                25     27  0
018500060510     D  PABF10                28     30  0
018600060510     D  PABF11                31     33  0
018700060510     D  PABF12                34     36  0
018800060510     D  PABF13                37     39  0
018900060510     D  PABF14                40     42  0
019000060510     D  PABF15                43     45  0
019100060510     D  PABF16                46     48  0
019200060510     D  PABF17                49     51  0
019300060510     D  PABF18                52     54  0
019400060510     D  PABF19                55     57  0
019500060510     D  PABF20                58     60  0
019600060510      *
019700060510     D                 DS
019800060510     D T@@                     1     60A   DIM(20)
019900060510     D  T01                    1      3A
020000060510     D  T02                    4      6A
020100060510     D  T03                    7      9A
020200060510     D  T04                   10     12A
020300060510     D  T05                   13     15A
020400060510     D  T06                   16     18A
020500060510     D  T07                   19     21A
020600060510     D  T08                   22     24A
020700060510     D  T09                   25     27A
020800060510     D  T10                   28     30A
020900060510     D  T11                   31     33A
021000060510     D  T12                   34     36A
021100060510     D  T13                   37     39A
021200060510     D  T14                   40     42A
021300060510     D  T15                   43     45A
021400060510     D  T16                   46     48A
021500060510     D  T17                   49     51A
021600060510     D  T18                   52     54A
021700060510     D  T19                   55     57A
021800060510     D  T20                   58     60A
021900060510      *
022000060510     D                 DS
022100060510     D F@@                     1     60A   DIM(20)
022200060510     D  S01                    1      3A
022300060510     D  S02                    4      6A
022400060510     D  S03                    7      9A
022500060510     D  S04                   10     12A
022600060510     D  S05                   13     15A
022700060510     D  S06                   16     18A
022800060510     D  S07                   19     21A
022900060510     D  S08                   22     24A
023000060510     D  S09                   25     27A
023100060510     D  S10                   28     30A
023200060510     D  S11                   31     33A
023300060510     D  S12                   34     36A
023400060510     D  S13                   37     39A
023500060510     D  S14                   40     42A
023600060510     D  S15                   43     45A
023700060510     D  S16                   46     48A
023800060510     D  S17                   49     51A
023900060510     D  S18                   52     54A
024000060510     D  S19                   55     57A
024100060510     D  S20                   58     60A
024200060510      *
024300060510     D                 DS
024400060510     D B@@                     1     80A   DIM(20)
024500060510     D  B01                    1      4A
024600060510     D  B02                    5      8A
024700060510     D  B03                    9     12A
024800060510     D  B04                   13     16A
024900060510     D  B05                   17     20A
025000060510     D  B06                   21     24A
025100060510     D  B07                   25     28A
025200060510     D  B08                   29     32A
025300060510     D  B09                   33     36A
025400060510     D  B10                   37     40A
025500060510     D  B11                   41     44A
025600060510     D  B12                   45     48A
025700060510     D  B13                   49     52A
025800060510     D  B14                   53     56A
025900060510     D  B15                   57     60A
026000060510     D  B16                   61     64A
026100060510     D  B17                   65     68A
026200060510     D  B18                   69     72A
026300060510     D  B19                   73     76A
026400060510     D  B20                   77     80A
026500060510      *
026600060510     D                 DS
026700060510     D ATO                     1     60  0 DIM(20)
026800060510     D  PABT01                 1      3  0
026900060510     D  PABT02                 4      6  0
027000060510     D  PABT03                 7      9  0
027100060510     D  PABT04                10     12  0
027200060510     D  PABT05                13     15  0
027300060510     D  PABT06                16     18  0
027400060510     D  PABT07                19     21  0
027500060510     D  PABT08                22     24  0
027600060510     D  PABT09                25     27  0
027700060510     D  PABT10                28     30  0
027800060510     D  PABT11                31     33  0
027900060510     D  PABT12                34     36  0
028000060510     D  PABT13                37     39  0
028100060510     D  PABT14                40     42  0
028200060510     D  PABT15                43     45  0
028300060510     D  PABT16                46     48  0
028400060510     D  PABT17                49     51  0
028500060510     D  PABT18                52     54  0
028600060510     D  PABT19                55     57  0
028700060510     D  PABT20                58     60  0
028800060508   X***X
028900060509     C     SUBKEY        KLIST
029000060509     C                   KFLD                    TRUST#
029100060509     C                   KFLD                    SUB#
029200060509     C     PLNKEY        KLIST
029300060509     C                   KFLD                    TRUST#
029400060509     C                   KFLD                    SUB#
029500060509     C                   KFLD                    PLANCD
029600060509     C*
029700060509     C                   MOVE      'STEP1'       @STEP
029800060509     C                   CLEAR                   IO01
029900060509     C                   CLEAR                   IO02
030000060510     C                   EVAL      TITLE = CONAME
030100060509     C*
030200060508     C                   DOU       @STEP = 'LEAVE'
030300060508     C     @STEP         CASEQ     'STEP1'       $STEP1
030400060509    2C     @STEP         CASEQ     'STEP2'       $STEP2
030500060509    2C     @STEP         CASEQ     'STEP3'       $STEP3
030600060509    2C     @STEP         CASEQ     'STEP4'       $STEP4
030700060508     C                   ENDCS
030800060508     C                   ENDDO
030900060508     C                   EVAL      *INLR = *ON
031000060508   S***S
031100060508     C     $STEP1        BEGSR
031200060509     C*
031300060509     C                   MOVEL(P)  @SMSG         SMSG
031400060509     C                   EXFMT     IO01
031500060509     C*
031600060509     C                   MOVE      *BLANKS       @SMSG
031700060509     C                   EVAL      TNAME = '* UNKNOWN *'
031800060509     C                   EVAL      SUBNAM = '* UNKNOWN *'
031900060509     C                   EVAL      PDESCR = '* UNKNOWN *'
032000060509     C*
032100060509    1C                   IF        FKEY = F7
032200060509     C                   MOVEL(P)  'LEAVE'       @STEP
032300060509     C                   LEAVESR
032400060509    1C                   ENDIF
032500060509     C*
032600060509    1C                   IF        FKEY = F9
032700060509     c                   call      'INQTMPCL'
032800060509     C                   LEAVESR
032900060509    1C                   ENDIF
033000060509     C*
033100060509    *** TRUST SELECTOR
033200060509    1C                   IF        FKEY = F2
033300060509     C                   EXSR      $F2PROC
033400060509     C                   LEAVESR
033500060509    1C                   ENDIF
033600060509    *** SUB SELECTOR
033700060509    1C                   IF        FKEY = F4
033800060509     C                   EXSR      $F4PROC
033900060509     C                   LEAVESR
034000060509    1C                   ENDIF
034100060509    *** PLAN SELECTOR
034200060509    1C                   IF        FKEY = F6
034300060509     C                   EXSR      $F6PROC
034400060509     C                   LEAVESR
034500060509    1C                   ENDIF
034600060509    *** VALIDATIONS
034700060509     C                   Z-ADD     TRUST#        VLTRST            3 0
034800060509     C                   EXSR      $CHK_TRST
034900060509    1C                   IF        @@VT <> '0'
035000060509     C                   EVAL      @SMSG = 'INVALID TRUST SELECTED.'
035100060509     C                   LEAVESR
035200060509    1C                   ENDIF
035300060509     C*
035400060509     C                   Z-ADD     SUB#          VLSUB#            3 0
035500060509     C                   EXSR      $CHK_SUBD
035600060509    1C                   IF        @@VS <> '0'
035700060509     C                   EVAL      @SMSG = 'INVALID SUBDIVISION SELECTED.'
035800060509     C                   LEAVESR
035900060509    1C                   ENDIF
036000060509     C*
036100060509     C                   MOVEL(P)  PLANCD        VLPLAN            4
036200060509     C                   EXSR      $CHK_PLAN
036300060509    1C                   IF        @@VP <> '0'
036400060509     C                   EVAL      @SMSG = 'INVALID PLAN SELECTED.'
036500060509     C                   LEAVESR
036600060509    1C                   ENDIF
036700060509    ***
036800060509     C                   EVAL      @STEP = 'STEP2'
036900060509     C                   MOVE      *BLANKS       @SMSG
037000060509     C*
037100060509    SC                   ENDSR
037200060509   S***S
037300060509    *** TRUST SELECTION WINDOW
037400060509     C     $F2PROC       BEGSR
037500060509    ***
037600060509     C                   MOVE      *BLANKS       @3                3
037700060509     C                   CALL      'FM006CL'
037800060509     C                   PARM                    @3
037900060509    1C                   IF        @3 = '*LR'
038000060509     C                   EVAL      @SMSG = 'NO TRUST SELECTED.'
038100060509     C                   LEAVESR
038200060509    1C                   ENDIF
038300060509    ***
038400060509     C                   MOVE      @3            TRUST#
038500060509    ***
038600060509     C                   MOVE      @3            VLTRST
038700060509     C                   EXSR      $CHK_TRST
038800060509    1C                   IF        @@VT <> '0'
038900060509     C                   EVAL      @SMSG = 'INVALID TRUST SELECTED.'
039000060509    1C                   ENDIF
039100060509    ***
039200060509     C                   ENDSR
039300060509   S***S
039400060509     C     $CHK_TRST     BEGSR
039500060509    ***
039600060509     C                   MOVE      '1'           @@VT              1
039700060509    1C                   IF        VLTRST <> 0
039800060509     C     VLTRST        CHAIN     TRSMSR
039900060509    2C                   IF        %FOUND(TRSMST)
040000060509     C                   MOVE      '0'           @@VT
040100060509    2C                   ENDIF
040200060509    1C                   ENDIF
040300060509    ***
040400060509     C                   ENDSR
040500060509   S***S
040600060509    *** SUBDIVISION SELECTION WINDOW
040700060509    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
040800060509     C     $F4PROC       BEGSR
040900060509    ***
041000060509     C                   MOVE      *BLANKS       @6                6
041100060509     C*
041200060509     C                   Z-ADD     TRUST#        VLTRST
041300060509     C                   EXSR      $CHK_TRST
041400060509     C*
041500060509    1C                   IF        @@VT <> '0'
041600060509     C                   EVAL      @SMSG = 'INVALID TRUST SELECTED.'
041700060509     C                   LEAVESR
041800060509    1C                   ENDIF
041900060509    ***
042000060509     C                   MOVE      VLTRST        @3                3
042100060509     C                   MOVEL(P)  @3            @6
042200060509     C                   CALL      'FM007CL'
042300060509     C                   PARM                    @6
042400060509     C                   MOVE      @6            @3
042500060509    ***
042600060509    1C                   IF        @3 = '*LR'
042700060509     C                   EVAL      @SMSG = 'NO SUBDIVISION SELECTED.'
042800060509     C                   LEAVESR
042900060509    1C                   ENDIF
043000060509    ***
043100060509     C                   MOVE      @3            SUB#
043200060509     C*
043300060509     C                   MOVE      @3            VLSUB#
043400060509     C                   EXSR      $CHK_SUBD
043500060509    1C                   IF        @@VS <> '0'
043600060509     C                   EVAL      @SMSG = 'INVALID SUBDIVSION SELECTED.'
043700060509    1C                   ENDIF
043800060509    ***
043900060509     C                   ENDSR
044000060509   S***S
044100060509     C     $CHK_SUBD     BEGSR
044200060509    ***
044300060509     C                   MOVE      '1'           @@VS              1
044400060509    1C                   IF        VLSUB# <> 0
044500060509     C     KEY#SUB       CHAIN     SUBMSR
044600060509    2C                   IF        %FOUND(SUBMST)
044700060509     C                   MOVE      '0'           @@VS
044800060509    2C                   ENDIF
044900060509    1C                   ENDIF
045000060509    ***
045100060509     C                   ENDSR
045200060509   S***S
045300060509    *** EXISTING PLAN NUMBER INQUIRY
045400060509    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
045500060509     C     $F6PROC       BEGSR
045600060509    ***
045700060509     C                   MOVE      *BLANKS       @10              10
045800060509    ***
045900060509     C                   Z-ADD     TRUST#        VLTRST
046000060509     C                   EXSR      $CHK_TRST
046100060509     C*
046200060509    1C                   IF        @@VT <> '0'
046300060509     C                   EVAL      @SMSG = 'INVALID TRUST SELECTED.'
046400060509     C                   LEAVESR
046500060509    1C                   ENDIF
046600060509    ***
046700060509     C                   Z-ADD     SUB#          VLSUB#
046800060509     C                   EXSR      $CHK_SUBD
046900060509     C*
047000060509    1C                   IF        @@VS <> '0'
047100060509     C                   EVAL      @SMSG = 'INVALID SUBDIVSION SELECTED.'
047200060509     C                   LEAVESR
047300060509    1C                   ENDIF
047400060509    ***
047500060509     C                   MOVE      VLTRST        @3
047600060509     C                   MOVEL(P)  @3            @10
047700060509     C                   MOVE      VLSUB#        @3
047800060509     C                   CAT       @3:0          @10
047900060509     C                   CALL      'FM004CL'
048000060509     C                   PARM                    @10
048100060509     C     4             SUBST     @10:7         @4                4
048200060509    ***
048300060509    1C                   IF        @4 = '*LR '
048400060509     C                   EVAL      @SMSG = 'NO SUBDIVSION SELECTED.'
048500060509     C                   LEAVESR
048600060509    1C                   ENDIF
048700060509    ***
048800060509     C                   MOVEL(P)  @4            PLANCD
048900060509    ***
049000060509     C                   MOVEL(P)  @4            VLPLAN
049100060509     C                   EXSR      $CHK_PLAN
049200060509    1C                   IF        @@VP <> '0'
049300060509     C                   EVAL      @SMSG = 'INVALID PLAN SELECTED.'
049400060509    1C                   ENDIF
049500060509    ***
049600060509     C                   ENDSR
049700060509   S***S
049800060509     C     $CHK_PLAN     BEGSR
049900060509     c                   eval      *in80 = *off
050000060509    ***
050100060509     C     KEY#SUB       KLIST
050200060509     C                   KFLD                    VLTRST
050300060509     C                   KFLD                    VLSUB#
050400060509    ***
050500060509     C     KEY#PLAN      KLIST
050600060509     C                   KFLD                    VLTRST
050700060509     C                   KFLD                    VLSUB#
050800060509     C                   KFLD                    VLPLAN
050900060509    ***
051000060509     C                   MOVE      '1'           @@VP              1
051100060509    1C                   IF        VLPLAN <> *BLANKS
051200060509     C     KEY#PLAN      CHAIN     PLNMSR
051300060509    2C                   IF        %FOUND(PLNMST)
051400060509     C                   MOVE      '0'           @@VP
051500060509     c     pcarr         chain     CARMSR
051600060509     c                   IF        NOT %found(carmst)
051700060509     C                   EVAL      CNAME = '* UNKNOWN *'
051800060509    2C                   ENDIF
051900060509    2C                   ENDIF
052000060509    1C                   ENDIF
052100060509    ***
052200060508     C                   ENDSR
052300060508   S***S
052400060509    SC     $STEP2        BEGSR
052500060509    ***
052600060509     C                   MOVEA     '011'         *IN(25)
052700060509     C                   WRITE     IO03C
052800060509     C                   MOVEA     '010'         *IN(25)
052900060509     C                   Z-ADD     *ZERO         RRT               4 0
053000060509     C                   MOVE      *ZEROS        #CNTREC           4 0
053100060509     C                   MOVE      '0'           @1STLOOP          1
053200060509    ***
053300060509     C                   MOVEL(P)  'STEP3'       @STEP
053400060509     C                   MOVE      *BLANKS       @SMSG
053500060510     C                   Z-ADD     0             #HLFRM
053600060510     C                   Z-ADD     0             #HLTO
053700060509    ***
053800060509     C                   ENDSR
053900060509   S***S
054000060509    SC     $STEP3        BEGSR
054100060509    ***
054200060509     C     PLNKEY        SETLL     GRATER
054300100322    1C                   DOU       %EOF(GRAT24)
054400060509     C     PLNKEY        READE     GRATER
054500100322    2C                   IF        NOT %EOF(GRAT24)
054600060509     C*
054700060509    3C                   IF        FRMDAT <> #HLFRM OR TODAT <> #HLTO
054800060509     C                   Z-ADD     FRMDAT        #HLFRM            8 0
054900060509     C                   Z-ADD     TODAT         #HLTO             8 0
055000060509     C                   ADD       1             #CNTREC
055100060509     C                   MOVE      *ON           *IN25
055200060509     C                   MOVE      *BLANKS       SEL03
055300060509     C                   MOVE      FRMDAT        #ISO
055400060509     C     *USA          MOVE      #ISO          FRM03
055500060509     C                   MOVE      TODAT         #ISO
055600060509     C     *USA          MOVE      #ISO          TOD03
055700060509     C*
055800060509     C                   ADD       1             RRT
055900060509    4C                   IF        @1STLOOP = '0'
056000060509     C                   Z-ADD     RRT           SFLPOS
056100060509     C                   MOVE      '1'           @1STLOOP
056200060509    4C                   ENDIF
056300060509     C                   WRITE     IO03S
056400060509    3C                   ENDIF
056500060509     C*
056600060509    2C                   ENDIF
056700060509    1C                   ENDDO
056800060509     C*
056900060509     C                   MOVEL(P)  'STEP4'       @STEP
057000060509     C                   MOVE      *BLANKS       @SMSG
057100060509    ***
057200060509     C                   ENDSR
057300060509   S***S
057400060509    SC     $STEP4        BEGSR
057500060509    ***
057600060509     C                   MOVEL(P)  @SMSG         SMSG
057700060509     C*
057800060509     C                   WRITE     IO03R
057900060509     C                   EXFMT     IO03C
058000060509     C*
058100060509     C                   MOVE      *BLANKS       @SMSG
058200060509     C*
058300060509    1C                   SELECT
058400060509     C*
058500060509     C* BACK TO INITIAL SCREEN
058600060509     C*
058700060509    1C                   WHEN      FKEY = F1
058800060509     C                   MOVEL(P)  'STEP1'       @STEP
058900060509     C                   LEAVESR
059000060509     C*
059100060509     C* HISTORY INQUIRY
059200060509     C*
059300060509    1C                   WHEN      FKEY = F4
059400060509     C                   MOVEL(P)  '0000000000'  @PARM
059500060509     C                   Z-ADD     TRTRST        #TRSTN
059600060509     C                   MOVEL(P)  TNAME         @TRNAM
059700060509     C                   Z-ADD     SBSUB#        #SUBNO
059800060509     C                   MOVEL(P)  SUBNAM        @SBNAM
059900060509     C                   MOVEL(P)  PLPLAN        @PLNCD
060000060509     C                   MOVEL(P)  PDESCR        @PCNAM
060100060509     C                   MOVEL(P)  @PARM         @52              52
060200060509     C                   CALL      'FM041R'
060300060509     C                   PARM                    @52
060400060509     C                   LEAVESR
060500060509     C*
060600060509     C* EXIT OUT OF APPLICATION
060700060509     C*
060800060509    1C                   WHEN      FKEY = F7
060900060509     C                   MOVEL(P)  'LEAVE'       @STEP
061000060509     C                   LEAVESR
061100060509     C*
061200060509     C* CHECK SELECTIONS
061300060509     C*
061400060509    1C                   OTHER
061500060509     C                   EXSR      $CHKSELC
061600060509     C*
061700060509     C                   ENDSL
061800060509    ***
061900060509     C                   ENDSR
062000060509   S***S
062100060509    SC     $CHKSELC      BEGSR
062200060509    ***
062300060509     C                   MOVE      *OFF          *IN33
062400060509    1C                   DOU       *IN33 = *ON OR @SMSG <> *BLANKS
062500060509     C                   READC     IO03S                                  33
062600060509    2C                   IF        *IN33 = *OFF
062700060509     C*
062800060509    3C                   IF        SEL03 <> *BLANKS AND FRM03 <> 0
062900060509     C                   MOVE      FRM03         #USA
063000060509     C                   MOVE      #USA          #ISO
063100060509     C                   MOVE      #ISO          #F03ISO           8 0
063200060509     C                   MOVE      TOD03         #USA
063300060509     C                   MOVE      #USA          #ISO
063400060509     C                   MOVE      #ISO          #T03ISO           8 0
063500060509     C                   Z-ADD     #F03ISO       #FDATE            8 0
063600060509     C                   Z-ADD     #T03ISO       #TDATE            8 0
063700060509     C                   Z-ADD     FRM03         FRDATE
063800060509     C                   Z-ADD     TOD03         TODATE
063900060510     C                   EXSR      $SCREEN2
064000060509    3C                   ENDIF
064100060510     C*
064200060509     C                   MOVE      *BLANKS       SEL03
064300060509     C                   UPDATE    IO03S
064400060509     C*
064500060509    2C                   ENDIF
064600060509     C*
064700060509    1C                   ENDDO
064800060509    ***
064900060509     C                   ENDSR
065000060509   S***S
065100060509    SC     $SCREEN2      BEGSR
065200060509    ***
065300060509     C                   EXSR      $MOVE20
065400060510    ***
065500060510     C                   EXSR      $LOADDTA
065600060510    ***
065700060510     C                   EVAL      X = 0
065800060510     C                   DO        10
065900060510     C                   EXSR      $LOADFWD
066000060510     C                   ENDDO
066100060510     C                   IF        Z <= 10
066200060510     C                   EVAL      @SMSG = 'ALL DATA SHOWN.'
066300060511     C                   EVAL      *IN88 = *OFF
066400060511     C                   ELSE
066500060511     C                   EVAL      *IN88 = *ON
066600060510     C                   ENDIF
066700060510    ***
066800060510     C                   DOU       FKEY = F1 OR FKEY = F7
066900060510     C                   EXSR      $CONTROL
067000060510     C                   ENDDO
067100060510    ***
067200060510     C                   EVAL      @SMSG = *BLANKS
067300060510    ***
067400060510     C                   IF        FKEY = F1
067500060510     C                   EVAL      FKEY = *BLANKS
067600060510     C                   ENDIF
067700060510    ***
067800060510     C                   IF        FKEY = F7
067900060510     C                   EVAL      @SMSG = 'EXITING APP'
068000060510     C                   EVAL      @STEP = 'LEAVE'
068100060510     C                   ENDIF
068200060510    ***
068300060510     C                   ENDSR
068400060510   S***S
068500060510    SC     $LOADDTA      BEGSR
068600060510    ***
068700060509     C     G24FKY        KLIST
068800060509     C                   KFLD                    TRUST#
068900060509     C                   KFLD                    SUB#
069000060509     C                   KFLD                    PLANCD
069100060509     C                   KFLD                    #FDATE
069200060509     C                   KFLD                    #TDATE
069300060510     C                   CLEAR                   S@
069400060510     C                   CLEAR                   A@
069500060510     C                   CLEAR                   T@
069600060510     C                   CLEAR                   B@
069700060510     C                   CLEAR                   N@
069800060510     C                   CLEAR                   C@
069900060510     C                   EVAL      L = 0
070000060510     C                   EVAL      Z = 0
070100060510     C                   MOVE      *ZEROS        X                 3 0
070200060509    ***
070300060509     C     G24FKY        SETLL     GRATER
070400100322    1C                   DOU       %EOF(GRAT24)
070500060509     C     G24FKY        READE     GRATER
070600100322    2C                   IF        NOT %EOF(GRAT24)
070700060509    ***
070800060510     C                   ADD       1             Z
070900060510     C                   EVAL      B@(Z) = BILRTE
071000060510     C                   EVAL      N@(Z) = NETRTE
071100060510     C                   EVAL      C@(Z) = GROUP#
071200060510     C                   EVAL      T@(Z) = %SUBST(TYPECD:2:2)
071300060510     C                   EVAL      S@(Z) = GRDLTD
071400060510     C                   IF        AGEBND = 0
071500060510     C                   EVAL      A@(Z) = *BLANKS
071600060510     C                   ELSE
071700060510     C                   MOVE      AGEBND        @2                2
071800060510     C                   EVAL      ##3 = AFR(AGEBND)
071900060510     C                   EVAL      @10 = @2 + ' ' + @@3
072000060510     C                   EVAL      ##3 = ATO(AGEBND)
072100060510     C                   EVAL      @10 = %TRIM(@10) + ' ' + @@3
072200060510     C                   EVAL      A@(Z) = @10
072300060510     C                   ENDIF
072400060509    ***
072500060509     C                   ENDIF
072600060509     C                   ENDDO
072700060510    ***
072800060509     C                   ENDSR
072900060509   S***S
073000060509    SC     $MOVE20       BEGSR
073100060509    ***
073200060510     C                   EVAL      X = 0
073300060510     C                   CLEAR                   B@@
073400060510     C                   CLEAR                   F@@
073500060510     C                   CLEAR                   T@@
073600060510     C                   DO        20
073700060510     C                   ADD       1             X
073800060510     C     X             ADD       50            N
073900060510     C                   IF        AFR(X) <> 0
074000060510     C                   EVAL      B@@(X) = '# ' +
074100060510     C                             %SUBST(%EDITC(X:'X'):2:2)
074200060510     C                   EVAL      ##3 = AFR(X)
074300060510     C                   EVALR     F@@(X) = @@3
074400060510     C                   EVAL      ##3 = ATO(X)
074500060510     C                   EVALR     T@@(X) = @@3
074600060510     C                   EVAL      *IN(N) = *OFF
074700060510     C                   ELSE
074800060510     C                   EVAL      *IN(N) = *ON
074900060510     C                   ENDIF
075000060510     C                   ENDDO
075100060510    ***
075200060510     C                   ENDSR
075300060510   S***S
075400060510    SC     $CONTROL      BEGSR
075500060510    ***
075600060510     C                   MOVEL(P)  @SMSG         SMSG
075700060510     C*
075800060510     C                   EXFMT     IO02
075900060510     C*
076000060510     C                   MOVE      *BLANKS       @SMSG
076100060510     C*
076200060510     C                   IF        FKEY = F1 OR FKEY = F7
076300060510     C                   LEAVESR
076400060510     C                   ENDIF
076500060510    ***
076600060510     C                   IF        FKEY = ROLLDOWN
076700060510     C                   EXSR      $RVSCTL
076800060510     C                   LEAVESR
076900060510     C                   ENDIF
077000060510    ***
077100060510     C                   IF        FKEY = ROLLUP
077200060510     C                   EXSR      $FWDCTL
077300060510     C                   LEAVESR
077400060510     C                   ENDIF
077500060510    ***
077600060510     C                   ENDSR
077700060510   S***S
077800060510    SC     $RVSCTL       BEGSR
077900060510    ***
078000060510     C                   IF        Z <= 10
078100060510     C                   EVAL      @SMSG = 'ALL DATA SHOWN.'
078200060511     C                   EVAL      *IN88 = *OFF
078300060510     C                   LEAVESR
078400060510     C                   ENDIF
078500060510    ***
078600060510     C                   Z-ADD     11            L                 3 0
078700060511     C                   EVAL      *IN88 = *ON
078800060510    ***
078900060510     C                   EVAL      X = X - 9
079000060510    ***
079100060510     C                   IF        X <= 10
079200060510     C                   EVAL      X = 11
079300060510     C                   EVAL      @SMSG = 'START OF DATA SHOWN.'
079400060510     C                   ENDIF
079500060510    ***
079600060510     C                   DO        10
079700060510     C                   EXSR      $LOADRVS
079800060510     C                   ENDDO
079900060510    ***
080000060510     C                   IF        @SMSG = 'START OF DATA SHOWN.'
080100060510     C                   EVAL      X = 10
080200060510     C                   ENDIF
080300060510    ***
080400060510     C                   ENDSR
080500060510   S***S
080600060510    SC     $LOADRVS      BEGSR
080700060510    ***
080800060510     C                   SUB       1             X
080900060510     C                   SUB       1             L
081000060510     C     L             ADD       30            N                 3 0
081100060510     C                   IF        S@(X) <> *BLANKS
081200060510     C                   EVAL      ST@(L) = S@(X)
081300060510     C                   EVAL      AB@(L) = A@(X)
081400060510     C                   EVAL      TC@(L) = T@(X)
081500060510     C                   EVAL      BR@(L) = B@(X)
081600060510     C                   EVAL      NR@(L) = N@(X)
081700060510     C                   EVAL      CG@(L) = C@(X)
081800060510     C                   EVAL      *IN(N) = *OFF
081900060510     C                   ELSE
082000060510     C                   EVAL      *IN(N) = *ON
082100060510     C                   ENDIF
082200060510    ***
082300060510     C                   ENDSR
082400060510   S***S
082500060510    SC     $FWDCTL       BEGSR
082600060510    ***
082700060510     C                   IF        Z <= 10
082800060510     C                   EVAL      @SMSG = 'ALL DATA SHOWN.'
082900060511     C                   EVAL      *IN88 = *OFF
083000060510     C                   LEAVESR
083100060510     C                   ENDIF
083200060510    ***
083300060511     C                   EVAL      *IN88 = *ON
083400060510     C                   MOVE      *ZEROS        L                 3 0
083500060510    ***
083600060510     C                   IF        X > (Z - 10)
083700060510     C*                  EVAL      X = Z - 10
083800060510     C                   EVAL      @SMSG = 'END OF DATA SHOWN.'
083900060511     C                   EVAL      *IN88 = *OFF
084000060510     C                   ENDIF
084100060510    ***
084200060510     C                   DO        10
084300060510     C                   EXSR      $LOADFWD
084400060510     C                   ENDDO
084500060510     C                   IF        @SMSG = 'END OF DATA SHOWN.'
084600060511     C                   EVAL      *IN88 = *OFF
084700060510     C                   EVAL      X = Z
084800060510     C                   ENDIF
084900060510    ***
085000060510     C                   ENDSR
085100060510   S***S
085200060510    SC     $LOADFWD      BEGSR
085300060510    ***
085400060510     C                   ADD       1             X
085500060510     C                   ADD       1             L
085600060510     C     L             ADD       30            N                 3 0
085700060510     C                   IF        S@(X) <> *BLANKS
085800060510     C                   EVAL      ST@(L) = S@(X)
085900060510     C                   EVAL      AB@(L) = A@(X)
086000060510     C                   EVAL      TC@(L) = T@(X)
086100060510     C                   EVAL      BR@(L) = B@(X)
086200060510     C                   EVAL      NR@(L) = N@(X)
086300060510     C                   EVAL      CG@(L) = C@(X)
086400060510     C                   EVAL      *IN(N) = *OFF
086500060510     C                   ELSE
086600060510     C                   EVAL      *IN(N) = *ON
086700060510     C                   ENDIF
086800060510    ***
086900060509     C                   ENDSR
087000060509   S***S
