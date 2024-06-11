000100030613     FRP410D    CF   E             WORKSTN INFDS(WSDS)
000200030613     ** PROMPT SCREEN
000300000102     FTRSMST    IF   E           K DISK
000400030613     ** TRUST MASTER
000500011119     FSUBMST    IF   E           K DISK
000600030613     ** SUBDIVISION MASTER
000700011119     FACCMST    IF   E           K DISK
000800030613     ** ACCOUNT MASTER
000900010919   X***X
001000030613     D WSDS            DS
001100030613     D  FKEY                 369    369A
001200030613     ***
001300030613     D  F1             C                   CONST(X'31')
001400030613     D  F2             C                   CONST(X'32')
001500030613     D  F3             C                   CONST(X'33')
001600030613     D  F4             C                   CONST(X'34')
001700030613     D  F5             C                   CONST(X'35')
001800030613     D  F6             C                   CONST(X'36')
001900030613     D  F7             C                   CONST(X'37')
002000030613     D  F8             C                   CONST(X'38')
002100030613     D  F9             C                   CONST(X'39')
002200030613     D  F10            C                   CONST(X'3A')
002300030613     D  F11            C                   CONST(X'3B')
002400030613     D  F12            C                   CONST(X'3C')
002500030613     D  F13            C                   CONST(X'B1')
002600030613     D  F14            C                   CONST(X'B2')
002700030613     D  F15            C                   CONST(X'B3')
002800030613     D  F16            C                   CONST(X'B4')
002900030613     D  F17            C                   CONST(X'B5')
003000030613     D  F18            C                   CONST(X'B6')
003100030613     D  F19            C                   CONST(X'B7')
003200030613     D  F20            C                   CONST(X'B8')
003300030613     D  F21            C                   CONST(X'B9')
003400030613     D  F22            C                   CONST(X'BA')
003500030613     D  F23            C                   CONST(X'BB')
003600030613     D  F24            C                   CONST(X'BC')
003700030613    ***
003800011119     D KEY@TRS         S                   LIKE(TRTRST)
003900011119     D KEY@SUB         S                   LIKE(SBSUB#)
004000011119     D KEY@ACC         S                   LIKE(ACACCT)
004100011119    ***
004200011119     D DES@TRS         S                   LIKE(TNAME)
004300011119     D DES@SUB         S                   LIKE(SUBNAM)
004400011119     D DES@ACC         S                   LIKE(ACNAM1)
004500010919    ***
004600011119     D @T3             S              3A
004700011119     D @S3             S              3A
004800011119     D @A4             S              4A
004900011121     D @TS6            S              6A
005000011121     D @TSAP           S             10A
005100011119    ***
005200011119     D @@VT            S              1A
005300011119     D @@VS            S              1A
005400011119     D @@VA            S              1A
005500030613    ***
005600030613     D                 DS
005700030613     D @PARM                         32A
005800030613     D  SC_TRST                1      3A
005900030613     D  SC_SUB#                4      6A
006000030613     D  SC_ACCT                7     10A
006100030613     D  FRMISO                11     18A
006200030613     D  TOISO                 19     26A
006300030613     D  EFISO                 27     32A
006400030613    ***
006500030613     D E#              S              3S 0
006600030613     D @@SM1           S             70A
006700030613     D #ISO            S               D   DATFMT(*ISO)
006800030613     D #USA            S               D   DATFMT(*USA)
006900030613     D #XSX            S              8S 0
007000030613     D @STEP           S              5A
007100030613     D M@              S             70A   DIM(20) CTDATA PERRCD(1)
007200030613     D @6              S              6A
007300030613     D @8              S              8A
007400010919   X***X
007500030613     C                   DOU       @STEP = 'LEAVE'
007600030613     C     @STEP         CASEQ     'STEP1'       $STEP1
007700030613     C                   ENDCS
007800030613     C                   ENDDO
007900030613     C*
008000030613     C                   MOVEL     @PARM         @P
008100030613     C                   MOVE      *ON           *INLR
008200010919   S***S
008300010919     C     *INZSR        BEGSR
008400010919    ***
008500030613     C                   MOVE      'STEP1'       @STEP
008600030613    ***
008700010919     C     KEY#SUB       KLIST
008800011119     C                   KFLD                    KEY@TRS
008900011119     C                   KFLD                    KEY@SUB
009000010919     C*
009100011119     C     KEY#ACC       KLIST
009200011119     C                   KFLD                    KEY@TRS
009300011119     C                   KFLD                    KEY@SUB
009400011119     C                   KFLD                    KEY@ACC
009500030613    ***
009600030613     C     *ENTRY        PLIST
009700030613     C                   PARM                    @P               32
009800030616     c                   move      @p            h@32             32
009900030616    ***
010000030616     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
010100030616     C                   IN        @DTA50
010200030616     C                   EVAL      gbsrealm =  %SUBST(@DTA50:1:40)
010300011119    ***
010400010919     C                   ENDSR
010500010919   S***S
010600030613     C     $STEP1        BEGSR
010700030613    ***
010800030613     C                   EVAL      EMSG = @@SM1
010900030613     C                   EXFMT     IO01
011000030613     C                   CLEAR                   @@SM1
011100030613     C                   CLEAR                   EMSG
011200030613     C                   EVAL      E# = 0
011300030613    ***
011400030613     C                   IF        FKEY = F7
011500030616     c                   movel     h@32          @parm
011600030613     C                   MOVEL(P)  'LEAVE'       @STEP
011700030613     C                   LEAVESR
011800030613     C                   ENDIF
011900030613    ***
012000010919    *** TRUST SELECTOR
012100010919    1C                   IF        FKEY = F2
012200010919     C                   EXSR      $F2PROC
012300011119    2C                   IF        @@VT = 'Y'
012400011119     C                   MOVEL(P)  DES@TRS       SC_TNAME
012500011119    2C                   ENDIF
012600011119     C                   LEAVESR
012700010919    1C                   ENDIF
012800010919    *** SUB SELECTOR
012900010919    1C                   IF        FKEY = F4
013000011126     C                   MOVE      SC_TRST       @T3
013100010919     C                   EXSR      $F4PROC
013200011119    2C                   IF        @@VS = 'Y'
013300011119     C                   MOVEL(P)  DES@SUB       SC_SNAME
013400011119    2C                   ENDIF
013500010919     C                   LEAVESR
013600010919    1C                   ENDIF
013700030613    *** ACCOUNT SELECTOR
013800010919    1C                   IF        FKEY = F6
013900011126     C                   MOVE      SC_TRST       @T3
014000011126     C                   MOVE      SC_SUB#       @S3
014100010919     C                   EXSR      $F6PROC
014200030613    2C                   IF        @@VA = 'Y'
014300011119     C                   MOVEL(P)  DES@ACC       SC_ANAME
014400011119    2C                   ENDIF
014500010919     C                   LEAVESR
014600010919    1C                   ENDIF
014700010919    *** VALIDATIONS
014800011119    ***
014900030613     C                   EXSR      $VLD_TSA
015000030613    * *
015100030613     C                   IF        E# > 0
015200030613     C                   EVAL      @@SM1 = M@(E#)
015300030613     C                   LEAVESR
015400030613     C                   ENDIF
015500030613    ***
015600030613     C                   EXSR      $VLD_DTES
015700030613    * *
015800030613     C                   IF        E# > 0
015900030613     C                   EVAL      @@SM1 = M@(E#)
016000030613     C                   LEAVESR
016100030613     C                   ENDIF
016200030613    ***
016300030613     C                   MOVEL(P)  'LEAVE'       @STEP
016400030613    ***
016500030613     C                   ENDSR
016600030613   S***S
016700030613     C     $VLD_DTES     BEGSR
016800030613    ***
016900030613     C                   IF        FRMDT = 0
017000030613     C                   Z-ADD     5             E#                             TRUST IS ZERO
017100030613     C                   LEAVESR
017200030613     C                   ENDIF
017300030613    ***
017400030613     C                   IF        FRMDT > 0
017500030613     C     *USA          TEST(DE)                FRMDT
017600030613     C                   IF        %ERROR
017700030613     C                   Z-ADD     6             E#                             TRUST IS ZERO
017800030613     C                   LEAVESR
017900030613     C                   ENDIF
018000030613     C                   ENDIF
018100030613    ***
018200030613     C                   IF        TODAT > 0
018300030613     C     *USA          TEST(DE)                TODAT
018400030613     C                   IF        %ERROR
018500030613     C                   Z-ADD     11            E#                             TRUST IS ZERO
018600030613     C                   LEAVESR
018700030613     C                   ENDIF
018800030613     C                   ENDIF
018900030613    ***
019000030613     C                   IF        EFFMMYY > 0
019100030613     C                   MOVE      EFFMMYY       @6
019200030613     C                   EVAL      @8 = %SUBST(@6:1:2) + '01' +
019300030613     C                             %SUBST(@6:3:4)
019400030613     C                   MOVE      @8            #XSX
019500030613     C     *USA          TEST(DE)                #XSX
019600030613     C                   IF        %ERROR
019700030613     C                   Z-ADD     13            E#                             TRUST IS ZERO
019800030613     C                   LEAVESR
019900030613     C                   ENDIF
020000030613     C                   ENDIF
020100030613    ***
020200030613     C                   MOVE      FRMDT         #XSX
020300030616     C                   MOVE      #XSX          #usa
020400030616     C                   MOVE      #usa          #iso
020500030616     C                   MOVE      #iso          #XSX
020600030613     C                   MOVE      #XSX          FRMISO
020700030613    ***
020800030613     C                   MOVE      TODAT         #XSX
020900030613     C                   IF        #XSX > 0
021000030616     C                   MOVE      #XSX          #usa
021100030616     C                   MOVE      #usa          #iso
021200030616     C                   MOVE      #iso          #XSX
021300030613     C                   ENDIF
021400030613     C                   MOVE      #XSX          TOISO
021500030613    ***
021600030613     C                   MOVE      EFFMMYY       EFISO
021700030613    ***
021800030613     C                   ENDSR
021900030613   S***S
022000030613     C     $VLD_TSA      BEGSR
022100030613    ***
022200030613    1C                   IF        SC_TRST = 'ALL'
022300030613     C                             AND (SC_SUB# <> 'ALL' OR
022400030613     C                             SC_ACCT <> 'ALL')
022500030613     C                   MOVEL     'ALL'         SC_SUB#
022600030613     C                   MOVEL(P)  'ALL'         SC_ACCT
022700030613    1C                   ENDIF
022800030613    ***
022900030613    1C                   IF        SC_SUB# = 'ALL' AND
023000030613     C                             SC_ACCT <> 'ALL'
023100030613     C                   MOVEL(P)  'ALL'         SC_ACCT
023200030613    1C                   ENDIF
023300030613    ***
023400030613     C                   MOVE      SC_TRST       @T3
023500030613     C                   EXSR      $CHK_TRST
023600030613    1C                   IF        @@VT = 'N'
023700030613     C                   MOVEL(P)  M@(E#)        @@SM1
023800030613     C                   LEAVESR
023900030613    1C                   ELSE
024000030613     C                   MOVEL(P)  DES@TRS       SC_TNAME
024100030613    1C                   ENDIF
024200030613    ***
024300030613     C                   MOVE      SC_SUB#       @S3
024400030613     C                   EXSR      $CHK_SUBD
024500030613    1C                   IF        @@VS = 'N'
024600030613     C                   MOVEL(P)  M@(E#)        @@SM1
024700030613     C                   LEAVESR
024800030613    1C                   ELSE
024900030613     C                   MOVEL(P)  DES@SUB       SC_SNAME
025000030613    1C                   ENDIF
025100030613    ***
025200030613     C                   MOVE      SC_ACCT       @A4
025300030613     C                   EXSR      $CHK_ACCT
025400030613    1C                   IF        @@VA = 'N'
025500030613     C                   MOVEL(P)  M@(E#)        @@SM1
025600030613     C                   LEAVESR
025700030613    1C                   ELSE
025800030613     C                   MOVEL(P)  DES@ACC       SC_ANAME
025900030613    1C                   ENDIF
026000030613    ***
026100030613     C                   ENDSR
026200010919   S***S
026300011119    *** #1 IS BLANK OR NONNUMERIC VALUE IN TRUST_FIELD_IN
026400011119    *** #2 IS TRUST NOT ON TRUST MASTER FILE
026500010919     C     $CHK_TRST     BEGSR
026600011121    ***
026700011121     C                   MOVE      'N'           @@VT
026800011121     C                   MOVE      *BLANKS       DES@TRS
026900010919    ***
027000011119    1C                   IF        @T3 = 'ALL'
027100011119     C                   MOVE      'Y'           @@VT
027200011121     C                   EVAL      DES@TRS = 'ALL TRUSTS'
027300011119     C                   LEAVESR
027400011119    1C                   ENDIF
027500011119    ***
027600011119     C                   TESTN                   @T3                  99
027700011119    1C                   IF        *IN99 = *OFF
027800011119     C                   Z-ADD     1             E#                             TRUST IS ZERO
027900011119     C                   LEAVESR
028000011119    1C                   ENDIF
028100011119    ***
028200011119     C                   MOVE      @T3           KEY@TRS
028300011119    ***
028400011119    1C                   IF        KEY@TRS = 0
028500010919     C                   Z-ADD     1             E#                             TRUST IS ZERO
028600011119     C                   LEAVESR
028700011119    1C                   ENDIF
028800011119    ***
028900011119     C     KEY@TRS       CHAIN(N)  TRSMSR
029000011119    1C                   IF        NOT %FOUND(TRSMST)
029100010919     C                   Z-ADD     2             E#                             NOT ON MASTER FILE
029200011119    1C                   ELSE
029300011121     C                   MOVEL(P)  TNAME         DES@TRS
029400011119     C                   MOVE      'Y'           @@VT
029500011119    1C                   ENDIF
029600010919    ***
029700010919     C                   ENDSR
029800010919   S***S
029900010919     C     $CHK_SUBD     BEGSR
030000010919    ***
030100011121     C                   MOVE      'N'           @@VS
030200011121     C                   MOVE      *BLANKS       DES@SUB
030300011121    ***
030400011119    1C                   IF        @S3 = 'ALL'
030500011119     C                   MOVE      'Y'           @@VS
030600011121     C                   EVAL      DES@SUB = 'ALL SUBDIVISIONS'
030700011119     C                   LEAVESR
030800011119    1C                   ENDIF
030900011121    ***
031000011121     C                   TESTN                   @S3                  99
031100011121    1C                   IF        *IN99 = *OFF
031200011121     C                   Z-ADD     3             E#                             TRUST IS ZERO
031300011121     C                   LEAVESR
031400011121    1C                   ENDIF
031500011121    ***
031600011121     C                   MOVE      @S3           KEY@SUB
031700011119    ***
031800011121    1C                   IF        KEY@SUB = 0
031900010919     C                   Z-ADD     3             E#                             SUBD IS ZERO
032000011121     C                   LEAVESR
032100011121    1C                   ENDIF
032200011121    ***
032300011121     C                   MOVE      @T3           KEY@TRS
032400010919     C     KEY#SUB       CHAIN(N)  SUBMSR
032500011121    1C                   IF        NOT %FOUND(SUBMST)
032600010919     C                   Z-ADD     4             E#                             NOT ON MASTER FILE
032700011121    1C                   ELSE
032800011121     C                   MOVEL(P)  SUBNAM        DES@SUB
032900011121     C                   MOVE      'Y'           @@VS
033000010919    1C                   ENDIF
033100010919    ***
033200010919     C                   ENDSR
033300010919   S***S
033400011121     C     $CHK_ACCT     BEGSR
033500011121    ***
033600011121     C                   MOVE      'N'           @@VA
033700011121     C                   MOVE      *BLANKS       DES@ACC
033800011121    ***
033900011121    1C                   IF        @A4 = 'ALL '
034000011121     C                   MOVE      'Y'           @@VA
034100011121     C                   EVAL      DES@ACC = 'ALL ACCOUNTS'
034200011121     C                   LEAVESR
034300011121    1C                   ENDIF
034400011121    ***
034500011121     C                   TESTN                   @A4                  99
034600011121    1C                   IF        *IN99 = *OFF
034700011121     C                   Z-ADD     7             E#                             ACC NOT VALID #
034800011121     C                   LEAVESR
034900011121    1C                   ENDIF
035000011121    ***
035100011121     C                   MOVE      @A4           KEY@ACC
035200011121    ***
035300011121    1C                   IF        KEY@ACC = 0
035400011121     C                   Z-ADD     7             E#                             ACC NOT VALID #
035500011121     C                   LEAVESR
035600011121    1C                   ENDIF
035700011121    ***
035800011121     C                   MOVE      @T3           KEY@TRS
035900011121     C                   MOVE      @S3           KEY@SUB
036000011121     C     KEY#ACC       CHAIN(N)  ACCMSR
036100011121    1C                   IF        NOT %FOUND(ACCMST)
036200011121     C                   Z-ADD     8             E#                             NOT ON MASTER FILE
036300011121    1C                   ELSE
036400011121     C                   MOVEL(P)  ACNAM1        DES@ACC
036500011121     C                   MOVE      'Y'           @@VA
036600011121    1C                   ENDIF
036700011121    ***
036800011121     C                   ENDSR
036900011121   S***S
037000010919    *** TRUST SELECTION WINDOW
037100010919     C     $F2PROC       BEGSR
037200010919    ***
037300011121     C                   MOVE      *BLANKS       @T3
037400010919     C                   CALL      'FM006CL'
037500011121     C                   PARM                    @T3
037600011121    ***
037700011121    1C                   IF        @T3 = '*LR'
037800011126     C                   MOVEL(P)  M@(9)         @@SM1
037900010919     C                   LEAVESR
038000010919    1C                   ENDIF
038100010919    ***
038200011121     C                   MOVE      @T3           SC_TRST
038300010919     C                   EXSR      $CHK_TRST
038400011121    1C                   IF        @@VT = 'N'
038500010919     C                   MOVEL(P)  M@(E#)        @@SM1
038600010919    1C                   ENDIF
038700010919    ***
038800010919     C                   ENDSR
038900010919   S***S
039000010919    *** SUBDIVISION SELECTION WINDOW
039100010919    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
039200010919     C     $F4PROC       BEGSR
039300010919    ***
039400010919     C                   EXSR      $CHK_TRST
039500010919     C*
039600011121    1C                   IF        @@VT = 'N'
039700010919     C                   MOVEL(P)  M@(E#)        @@SM1
039800010919     C                   LEAVESR
039900010919    1C                   ENDIF
040000010919    ***
040100011121     C                   MOVEL(P)  @T3           @TS6
040200011121    ***
040300010919     C                   CALL      'FM007CL'
040400011121     C                   PARM                    @TS6
040500010919    ***
040600011121    1C                   IF        %SUBST(@TS6:4:3) = '*LR'
040700011126     C                   MOVEL(P)  M@(10)        @@SM1
040800010919     C                   LEAVESR
040900010919    1C                   ENDIF
041000010919    ***
041100011121     C                   EVAL      @S3 = %SUBST(@TS6:4:3)
041200011121     C                   MOVE      @S3           SC_SUB#
041300011121     C*
041400010919     C                   EXSR      $CHK_SUBD
041500011121    1C                   IF        @@VS = 'N'
041600010919     C                   MOVEL(P)  M@(E#)        @@SM1
041700010919    1C                   ENDIF
041800010919    ***
041900010919     C                   ENDSR
042000010919   S***S
042100011121    *** EXISTING ACCT NUMBER INQUIRY
042200011121    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
042300011121     C     $F6PROC       BEGSR
042400011121    ***
042500011121     C                   EXSR      $CHK_TRST
042600011121     C*
042700011121    1C                   IF        @@VT = 'N'
042800011121     C                   MOVEL(P)  M@(E#)        @@SM1
042900011121     C                   LEAVESR
043000011121    1C                   ENDIF
043100011121    ***
043200011121     C                   EXSR      $CHK_SUBD
043300011121     C*
043400011121    1C                   IF        @@VS = 'N'
043500011121     C                   MOVEL(P)  M@(E#)        @@SM1
043600011121     C                   LEAVESR
043700011121    1C                   ENDIF
043800011121    ***
043900011121     C                   EVAL      @TSAP = @T3 + @S3 + '    '
044000011121     C                   CALL      'FM008CL'
044100011121     C                   PARM                    @TSAP
044200011121    ***
044300011121    1C                   IF        %SUBST(@TSAP:7:3) = '*LR'
044400011126     C                   MOVEL(P)  M@(12)        @@SM1
044500011121     C                   LEAVESR
044600011121    1C                   ENDIF
044700011121    ***
044800011121     C                   EVAL      @A4 = %SUBST(@TSAP:7:4)
044900011121     C                   MOVEL(P)  @A4           SC_ACCT
045000011121     C                   EXSR      $CHK_ACCT
045100011121    1C                   IF        @@VA = 'N'
045200011121     C                   MOVEL(P)  M@(E#)        @@SM1
045300011121    1C                   ENDIF
045400011121    ***
045500011121     C                   ENDSR
045600011121   S***S
045700011121** M@ CTDATA
045800011126TRUST NUMBER CANNOT BE ZERO                                1
045900011126TRUST NUMBER IS NOT ON MASTER FILE                         2
046000011126SUBDIVISION NUMBER CANNOT BE ZERO                          3
046100011126TRUST/SUB IS NOT ON SUBDIVISION MASTER FILE                4
046200030613FROM DATE CANNOT BE ZERO                                   5
046300030613FROM DATE FORMAT IS INVALID                                6
046400011126ACCOUNT NUMBER CANNOT BE ZERO                              7
046500011126TRUST/SUB/ACCOUNT IS NOT ON ACCOUNT MASTER FILE            8
046600011126TRUST NOT SELECTED FROM INQUIRY                            9
046700030613SUBDIVISION NOT SELECTED FROM INQUIRY                      10
046800030613TO DATE FORMAT IS INVALID                                  11
046900030613ACCOUNT NOT SELECTED FROM INQUIRY                          12
047000030613EFFECTIVE DATE IS INVALID                                  13
