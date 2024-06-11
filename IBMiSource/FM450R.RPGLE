000100010920    ************************************************************************
000200010918     **
000300010918     ** MODIFICATION HISTORY
000400010918     **
000500010918     ** ### UUU CCYYMMDD X---->
000600011022     ** 000 SSK 20011022 ORIGINAL SOURCE
000700010918    ************************************************************************
000800010129   X***X
000900011022     FFM450D    CF   E             WORKSTN INFDS(WSDS)
001000010918     ** SCREEN FILE
001100011022    ***
001200011022     FTRSMST    IF   E           K DISK
001300011022     ** TRUST MASTER FILE
001400011022     FSUBMST    IF   E           K DISK
001500011022     ** SUBDIVISION MASTER FILE
001600011022     FPLNMST    IF   E           K DISK
001700010918     ** PLAN MASTER FILE
001800011022    ***
001900011022     FNXTPLN0   UF A E           K DISK
002000011022     ** NEXT YEAR PLANS FILE
002100011022    ***
002200010919   X***X
002300010919     D WSDS            DS
002400010919     D  FKEY                 369    369A
002500010919    ***
002600010919     D  F1             C                   CONST(X'31')
002700010919     D  F2             C                   CONST(X'32')
002800010919     D  F3             C                   CONST(X'33')
002900010919     D  F4             C                   CONST(X'34')
003000010919     D  F5             C                   CONST(X'35')
003100010919     D  F6             C                   CONST(X'36')
003200010919     D  F7             C                   CONST(X'37')
003300010919     D  F8             C                   CONST(X'38')
003400010919     D  F9             C                   CONST(X'39')
003500010919     D  F10            C                   CONST(X'3A')
003600010919     D  F11            C                   CONST(X'3B')
003700010919     D  F12            C                   CONST(X'3C')
003800010919     D  F13            C                   CONST(X'B1')
003900010919     D  F14            C                   CONST(X'B2')
004000010919     D  F15            C                   CONST(X'B3')
004100010919     D  F16            C                   CONST(X'B4')
004200010919     D  F17            C                   CONST(X'B5')
004300010919     D  F18            C                   CONST(X'B6')
004400010919     D  F19            C                   CONST(X'B7')
004500010919     D  F20            C                   CONST(X'B8')
004600010919     D  F21            C                   CONST(X'B9')
004700010919     D  F22            C                   CONST(X'BA')
004800010919     D  F23            C                   CONST(X'BB')
004900010919     D  F24            C                   CONST(X'BC')
005000010919    ***
005100010919     D                UDS
005200010919     D  @USER                100    107
005300010919     D  CONAME               201    240
005400010919    ***
005500010919     D @STEP           S              5A
005600010919     D E#              S              2S 0
005700011022     D @@PNAME         S             30A
005800011022     D M@              S             70A   DIM(12) CTDATA PERRCD(1)
005900011022     D @@SM1           S             70A
006000011022     D @@SM2           S             70A
006100010919    ***
006200010919   X***X
006300010919     C                   DOU       @STEP = 'LEAVE'
006400010919     C     @STEP         CASEQ     'PREP1'       $PREP1
006500010919     C     @STEP         CASEQ     'STEP1'       $STEP1
006600010919     C     @STEP         CASEQ     'STEP2'       $STEP2
006700010919     C                   ENDCS
006800010919     C                   ENDDO
006900010919    ***
007000010919     C                   MOVE      *ON           *INLR
007100010919   S***S
007200010919     C     *INZSR        BEGSR
007300010919    ***
007400010919     C                   MOVE      'PREP1'       @STEP
007500010919    ***
007600010919     C     KEY#SUB       KLIST
007700011022     C                   KFLD                    I_TRS
007800011022     C                   KFLD                    I_SUB
007900010919     C*
008000010919     C     KEY#PLAN      KLIST
008100011022     C                   KFLD                    I_TRS
008200011022     C                   KFLD                    I_SUB
008300011022     C                   KFLD                    @@PLAN
008400010920     C*
008500011022     C     *LIKE         DEFINE    PLPLAN        @@PLAN
008600010919    ***
008700010919     C                   ENDSR
008800010919   S***S
008900010919     C     $PREP1        BEGSR
009000010919    ***
009100010919     C                   CLEAR                   IO01
009200010925     C                   CLEAR                   IO02
009300010919     C                   MOVEL     CONAME        TITLE
009400011022     C                   MOVE      *ZEROS        I_TRS
009500011022     C                   MOVE      *ZEROS        I_SUB
009600011022     C                   MOVE      *BLANKS       I_PLN
009700010919     C                   MOVE      'STEP1'       @STEP
009800010919    ***
009900010919     C                   ENDSR
010000010919   S***S
010100010919     C     $STEP1        BEGSR
010200010919    ***
010300010919     C                   MOVEL     @@SM1         SMSG
010400010919     C                   EXFMT     IO01
010500010919     C                   MOVE      *BLANKS       @@SM1
010600010919     C                   MOVE      *BLANKS       SMSG
010700010919     C                   MOVE      *ZEROS        E#
010800010919    *** END APP
010900010919    1C                   IF        FKEY = F7
011000010919     C                   MOVEL(P)  'LEAVE'       @STEP
011100010919     C                   LEAVESR
011200010919    1C                   ENDIF
011300010919    *** TRUST SELECTOR
011400010919    1C                   IF        FKEY = F2
011500010919     C                   EXSR      $F2PROC
011600010919     C                   LEAVESR
011700010919    1C                   ENDIF
011800010919    *** SUB SELECTOR
011900010919    1C                   IF        FKEY = F4
012000010919     C                   EXSR      $F4PROC
012100010919     C                   LEAVESR
012200010919    1C                   ENDIF
012300010919    *** PLAN SELECTOR
012400010919    1C                   IF        FKEY = F6
012500010919     C                   EXSR      $F6PROC
012600011022    2C                   IF        @4 <> '*LR '
012700011022     C                   MOVEL(P)  @@PLAN        I_PLN
012800011022     C                   MOVEL(P)  @@PNAME       O_PNAME
012900011022    2C                   ENDIF
013000010919     C                   LEAVESR
013100010919    1C                   ENDIF
013200011022    *** NEXT YEAR PLANS SELECTOR
013300011022    1C                   IF        FKEY = F8
013400011022     C                   EXSR      $F8PROC
013500011022     C                   LEAVESR
013600011022    1C                   ENDIF
013700010919    *** VALIDATIONS
013800010919     C                   EXSR      $CHK_TRST
013900010919    1C                   IF        @@VT <> '0'
014000010919     C                   MOVEL(P)  M@(E#)        @@SM1
014100010919     C                   LEAVESR
014200010919    1C                   ENDIF
014300010919    ***
014400010919     C                   EXSR      $CHK_SUBD
014500010919    1C                   IF        @@VS <> '0'
014600010920     C                   MOVEL(P)  M@(E#)        @@SM1
014700010919     C                   LEAVESR
014800010919    1C                   ENDIF
014900010919    ***
015000011022     C                   MOVEL(P)  I_PLN         @@PLAN
015100010919     C                   EXSR      $CHK_PLAN
015200011022    1C                   IF        @@VP <> '0'
015300010920     C                   MOVEL(P)  M@(E#)        @@SM1
015400010919     C                   LEAVESR
015500010919    1C                   ENDIF
015600011022     C                   MOVEL(P)  @@PNAME       O_PNAME
015700010920    ***
015800010919     C                   MOVEL(P)  'STEP2'       @STEP
015900011022     C                   Z-ADD     2002          W_YEAR
016000010919    ***
016100010919     C                   ENDSR
016200010919   S***S
016300010919     C     $CHK_TRST     BEGSR
016400010919    ***
016500010919     C                   MOVE      '1'           @@VT              1            VALID TRUST FLAG
016600011022    1C                   IF        I_TRS = 0
016700010919     C                   Z-ADD     1             E#                             TRUST IS ZERO
016800010919    1C                   ELSE
016900011022     C     I_TRS         CHAIN(N)  TRSMSR
017000010925    2C                   IF        NOT %FOUND(TRSMST)
017100010919     C                   Z-ADD     2             E#                             NOT ON MASTER FILE
017200010919    2C                   ELSE
017300010919     C                   MOVEL     TNAME         O_TNAME
017400010919     C                   MOVE      '0'           @@VT
017500010919    2C                   ENDIF
017600010919    1C                   ENDIF
017700010919    ***
017800010919     C                   ENDSR
017900010919   S***S
018000010919     C     $CHK_SUBD     BEGSR
018100010919    ***
018200010919     C                   MOVE      '1'           @@VS              1            VALID SUBD FLAG
018300011022    1C                   IF        I_SUB = 0
018400010919     C                   Z-ADD     3             E#                             SUBD IS ZERO
018500010919    1C                   ELSE
018600010919     C     KEY#SUB       CHAIN(N)  SUBMSR
018700010919    2C                   IF        NOT %FOUND(SUBMST)
018800010919     C                   Z-ADD     4             E#                             NOT ON MASTER FILE
018900010919    2C                   ELSE
019000010919     C                   MOVEL     SUBNAM        O_SNAME
019100010919     C                   MOVE      '0'           @@VS
019200010919    2C                   ENDIF
019300010919    1C                   ENDIF
019400010919    ***
019500010919     C                   ENDSR
019600010919   S***S
019700010919     C     $CHK_PLAN     BEGSR
019800010919    ***
019900011022     C                   MOVE      '1'           @@VP              1
020000011022    1C                   IF        @@PLAN = *BLANKS
020100010919     C                   Z-ADD     5             E#
020200010919    1C                   ELSE
020300010920     C     KEY#PLAN      CHAIN     PLNMSR
020400011022    2C                   IF        NOT %FOUND(PLNMST)
020500011022     C                   Z-ADD     5             E#
020600011022    2C                   ELSE
020700011022     C                   MOVEL     PDESCR        @@PNAME
020800011022     C                   MOVE      '0'           @@VP
020900010919    2C                   ENDIF
021000010919    1C                   ENDIF
021100010925    ***
021200010925     C                   ENDSR
021300010919   S***S
021400010919    *** TRUST SELECTION WINDOW
021500010919     C     $F2PROC       BEGSR
021600010919    ***
021700010919     C                   MOVE      *BLANKS       @3                3
021800010919     C                   CALL      'FM006CL'
021900010919     C                   PARM                    @3
022000010919    1C                   IF        @3 = '*LR'
022100010919     C                   MOVEL(P)  M@(6)         @@SM1
022200010919     C                   LEAVESR
022300010919    1C                   ENDIF
022400010919    ***
022500011022     C                   MOVE      @3            I_TRS
022600010919     C                   EXSR      $CHK_TRST
022700010919    1C                   IF        @@VT <> '0'
022800010919     C                   MOVEL(P)  M@(E#)        @@SM1
022900010919    1C                   ENDIF
023000010919    ***
023100010919     C                   ENDSR
023200010919   S***S
023300010919    *** SUBDIVISION SELECTION WINDOW
023400010919    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
023500010919     C     $F4PROC       BEGSR
023600010919    ***
023700010919     C                   MOVE      *BLANKS       @6                6
023800010919     C                   EXSR      $CHK_TRST
023900010919     C*
024000010919    1C                   IF        @@VT <> '0'
024100010919     C                   MOVEL(P)  M@(E#)        @@SM1
024200010919     C                   LEAVESR
024300010919    1C                   ENDIF
024400010919    ***
024500011022     C                   MOVE      I_TRS         @3                3
024600010919     C                   MOVEL(P)  @3            @6
024700010919     C                   CALL      'FM007CL'
024800010919     C                   PARM                    @6
024900010919     C                   MOVE      @6            @3
025000010919    ***
025100010919    1C                   IF        @3 = '*LR'
025200010919     C                   MOVEL(P)  M@(7)         @@SM1
025300010919     C                   LEAVESR
025400010919    1C                   ENDIF
025500010919    ***
025600011022     C                   MOVE      @3            I_SUB
025700010919     C                   EXSR      $CHK_SUBD
025800010919    1C                   IF        @@VS <> '0'
025900010919     C                   MOVEL(P)  M@(E#)        @@SM1
026000010919    1C                   ENDIF
026100010919    ***
026200010919     C                   ENDSR
026300010919   S***S
026400010919    *** EXISTING PLAN NUMBER INQUIRY
026500010919    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
026600010919     C     $F6PROC       BEGSR
026700010919    ***
026800010919     C                   MOVE      *BLANKS       @10              10
026900010919    ***
027000010919     C                   EXSR      $CHK_TRST
027100010919     C*
027200010919    1C                   IF        @@VT <> '0'
027300010919     C                   MOVEL(P)  M@(E#)        @@SM1
027400010919     C                   LEAVESR
027500010919    1C                   ENDIF
027600010919    ***
027700010919     C                   EXSR      $CHK_SUBD
027800010919     C*
027900010919    1C                   IF        @@VS <> '0'
028000010919     C                   MOVEL(P)  M@(E#)        @@SM1
028100010919     C                   LEAVESR
028200010919    1C                   ENDIF
028300010919    ***
028400011022     C                   MOVE      I_TRS         @3
028500010919     C                   MOVEL(P)  @3            @10
028600011022     C                   MOVE      I_SUB         @3
028700010919     C                   CAT       @3:0          @10
028800010925     C                   CALL      'FM004CL'
028900010919     C                   PARM                    @10
029000010919     C     4             SUBST     @10:7         @4                4
029100010919    ***
029200010919    1C                   IF        @4 = '*LR '
029300010919     C                   MOVEL(P)  M@(8)         @@SM1
029400010919     C                   LEAVESR
029500010919    1C                   ENDIF
029600010919    ***
029700011022     C                   MOVEL     @4            @@PLAN
029800010919     C                   EXSR      $CHK_PLAN
029900010919    1C                   IF        @@VP <> '0'
030000010919     C                   MOVEL(P)  M@(E#)        @@SM1
030100010919    1C                   ENDIF
030200011022    ***
030300011022     C                   ENDSR
030400011022   S***S
030500011022     C     $F8PROC       BEGSR
030600011022    ***
030700011022     C                   MOVE      *ALL'0'       @18              18
030800011022     C                   CALL      'FM451CL'
030900011022     C                   PARM                    @18
031000011022     C                   MOVEL     @18           @3
031100011022     C                   IF        @3 = '*LR'
031200011022     C                   MOVEL(P)  M@(9)         @@SM1
031300011022     C                   LEAVESR
031400011022     C                   ENDIF
031500011022    ***
031600011022     C                   EVAL      @3 = %SUBST(@18:1:3)
031700011022     C                   MOVE      @3            I_TRS
031800011022     C                   EXSR      $CHK_TRST
031900011022     C                   EVAL      @3 = %SUBST(@18:4:3)
032000011022     C                   MOVE      @3            I_SUB
032100011022     C                   EXSR      $CHK_SUBD
032200011022     C                   EVAL      @4 = %SUBST(@18:7:4)
032300011022     C                   MOVEL     @4            I_PLN
032400011022     C                   MOVEL     @4            @@PLAN
032500011022     C                   EXSR      $CHK_PLAN
032600011022     C                   MOVEL(P)  @@PNAME       O_PNAME
032700011022     C                   EVAL      @4 = %SUBST(@18:11:4)
032800011022     C                   MOVE      @4            W_YEAR
032900011022     C                   EVAL      @4 = %SUBST(@18:15:4)
033000011022     C                   MOVEL     @4            W_PLN
033100011022     C                   MOVEL     @4            @@PLAN
033200011022     C                   EXSR      $CHK_PLAN
033300011022     C                   MOVEL(P)  @@PNAME       W_PNAME
033400010919    ***
033500010919     C                   ENDSR
033600010919   S***S
033700010919     C     $STEP2        BEGSR
033800010919    ***
033900011022     C                   MOVEL     @@SM2         SMSG
034000010919     C                   EXFMT     IO02
034100010919     C                   MOVE      *BLANKS       @@SM2
034200011022     C                   MOVE      *BLANKS       SMSG
034300010919     C                   MOVE      *ZEROS        E#
034400010919    *** FX KEYS
034500011022    1C                   IF        FKEY = F12                                   RETURN TO FIRST
034600011022     C                   MOVEL(P)  'PREP1'       @STEP                           SCREEN
034700010919     C                   LEAVESR
034800011022    1C                   ENDIF
034900011022     C*
035000011022    1C                   IF        FKEY = F6
035100011022     C                   EXSR      $F6PROC
035200011022    2C                   IF        @4 <> '*LR '
035300011022     C                   MOVEL(P)  @@PLAN        W_PLN
035400011022     C                   MOVEL(P)  @@PNAME       W_PNAME
035500011022    2C                   ENDIF
035600011022     C                   LEAVESR
035700011022    1C                   ENDIF
035800010919    ***
035900011022     C                   EXSR      $VALIDS02
036000011022    ***
036100011022     C                   IF        @@ER = 'G'
036200011022     C                   CLEAR                   NPF
036300011022     C                   Z-ADD     I_TRS         NPTRS
036400011022     C                   Z-ADD     I_SUB         NPSUB
036500011022     C                   MOVEL     I_PLN         NPPLN
036600011022     C                   Z-ADD     W_YEAR        NPYR
036700011022     C                   MOVEL     W_PLN         NPNEW
036800011022     C                   WRITE     NPF
036900011022     C                   MOVEL(P)  'PREP1'       @STEP                           SCREEN
037000011022     C                   EVAL      @@SM1 = 'NEW RECORD ADDED'
037100011022     C                   ENDIF
037200010920    ***
037300010919     C                   ENDSR
037400010919   S***S
037500010919     C     $VALIDS02     BEGSR
037600010919    ***
037700010919     C                   MOVE      'E'           @@ER              1
037800010919    ***
037900011022    1C                   IF        W_YEAR = 0
038000011022     C                   Z-ADD     10            E#
038100010919     C                   LEAVESR
038200010919    1C                   ENDIF
038300010919    ***
038400011022    1C                   IF        W_PLN = *BLANKS
038500011022     C                   Z-ADD     11            E#
038600011022     C                   LEAVESR
038700011022    1C                   ENDIF
038800011022    ***
038900011022     C     KEY#NEWPLN    CHAIN(N)  NPF
039000011022     C                   IF        %FOUND(NXTPLN0)
039100011022     C                   Z-ADD     12            E#
039200011022     C                   LEAVESR
039300011022    1C                   ENDIF
039400011022     C     KEY#NEWPLN    KLIST
039500011022     C                   KFLD                    I_TRS
039600011022     C                   KFLD                    I_SUB
039700011022     C                   KFLD                    I_PLN
039800011022     C                   KFLD                    W_YEAR
039900011022     C                   KFLD                    W_PLN
040000010920    ***
040100010920     C                   MOVE      'G'           @@ER              1
040200010920    ***
040300010919     C                   ENDSR
040400010920   S***S
040500010920** M@ CTDATA
040600010925TRUST NUMBER CANNOT BE ZERO
040700010925TRUST NUMBER IS NOT ON MASTER FILE
040800010925SUBDIVISION NUMBER CANNOT BE ZERO
040900010925TRUST/SUB IS NOT ON SUBDIVISION MASTER FILE
041000010925PLAN NUMBER IS BLANK, THIS IS A REQUIRED VALUE
041100010925TRUST NOT SELECTED FROM INQUIRY
041200010925SUBDIVISION NOT SELECTED FROM INQUIRY
041300010925PLAN NOT SELECTED FROM INQUIRY
041400011022NEXT YEAR PLAN NOT SELECTED FROM INQUIRY
041500011022NEW PLAN YEAR CANNOT BE BLANK OR ZERO
041600011022NEW PLAN CANNOT BE BLANK OR ZERO
041700011022THIS RECORD ALREADY EXISTS, ADD DENIED
