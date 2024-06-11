000100020909     *** REWROTE NOVEMBER 2001 BY STEPHEN KING
000200020909     ***
000300020909     *** IF CHANGING PAGE 1, WHICH IS THE LETTER TEXT, LOOK ON THE I: DRIVE
000400020909     *** USING THIS PATH I:\MIS\AS400PAGESEGMENTS\RENEWAL LETTERS
000500020909     *** AND OPEN THE DOCUMENT RENEWAL LETTERS IN MS-WORD. MAKE CHANGES AND
000600020909     *** SAVE, THEN PRINT. BE SURE TO USE AN IBM 600 AFP PRINTER DEVICE,
000700020909     *** ENSURE THE PROPERTIES OF THE PRINTER SAYS PAGE SEGMENT AND THEN
000800020909     *** PRINT TO FILE. THEN FTP THE FILE TO THE AS400 AS BINARY. AND THEN
000900020909     *** TURN IT INTO A PAGE SEGMENT AND RECOMPILE YOUR OBJECTS.
001000131011     ***
001100131011      * 10/11/13 sbt - hist file expansion project
001200020909     ***
001300030505      *?  90 DAY LETTER
001400011121     FRP350D    CF   E             WORKSTN INFDS(WSDS)
001500011116     FACCMST    IF   E           K DISK    USROPN
001600011116     FCODES     IF   E           K DISK    USROPN
001700011116     FSMAN      IF   E           K DISK
001800011121    ***
001900011116     FRP350WF   UF A E           K DISK    USROPN
002000011121    ***
002100011127     FTRSMST    IF   E           K DISK
002200011126     FSUBMST    IF   E           K DISK    USROPN
002300011128     FPLNMST    IF   E           K DISK    USROPN
002400011121     FMCOVX     IF   E           K DISK    USROPN
002500011128     F*GRATE     IF   E           K DISK    USROPN
002600011121     FHIST      IF A E           K DISK    USROPN
002700011127     FRP350P    O    E             PRINTER OFLIND(*IN81)
002800011116   X***X
002900011116     D @STEP           S              5A
003000011116     D #RENEW01        S              8S 0
003100011116     D @RENEW01        S              8A
003200011116     D                 DS
003300011116     D @SEPREN                 1      6A
003400011116     D ##SMO                   1      2S 0
003500011116     D ##SYR                   3      6S 0
003600011121    ***
003700011220     D #KNE            S              3S 0
003800011220     D DES             S             40A   DIM(400)
003900011127     D YR              S              9A   DIM(12) CTDATA PERRCD(1)
004000011127     D COV             S              3A   DIM(4) CTDATA PERRCD(1)
004100011128     D M@              S             80A   DIM(12) CTDATA PERRCD(1)
004200011121    ***
004300011121     D WSDS            DS
004400011121     D  FKEY                 369    369A
004500011121    ***
004600011121     D  F1             C                   CONST(X'31')
004700011121     D  F2             C                   CONST(X'32')
004800011121     D  F3             C                   CONST(X'33')
004900011121     D  F4             C                   CONST(X'34')
005000011121     D  F5             C                   CONST(X'35')
005100011121     D  F6             C                   CONST(X'36')
005200011121     D  F7             C                   CONST(X'37')
005300011121     D  F8             C                   CONST(X'38')
005400011121     D  F9             C                   CONST(X'39')
005500011121     D  F10            C                   CONST(X'3A')
005600011121     D  F11            C                   CONST(X'3B')
005700011121     D  F12            C                   CONST(X'3C')
005800011121     D  F13            C                   CONST(X'B1')
005900011121     D  F14            C                   CONST(X'B2')
006000011121     D  F15            C                   CONST(X'B3')
006100011121     D  F16            C                   CONST(X'B4')
006200011121     D  F17            C                   CONST(X'B5')
006300011121     D  F18            C                   CONST(X'B6')
006400011121     D  F19            C                   CONST(X'B7')
006500011121     D  F20            C                   CONST(X'B8')
006600011121     D  F21            C                   CONST(X'B9')
006700011121     D  F22            C                   CONST(X'BA')
006800011121     D  F23            C                   CONST(X'BB')
006900011121     D  F24            C                   CONST(X'BC')
007000011121    ***
007100011121     D                UDS
007200131017     D  luser                  1     10
007201131017     D  CONAME               201    240
007300011121    ***
007400011121     D #USO            S              8S 0
007500011121     D #ISA            S              8S 0
007600011121     D #USA            S               D   DATFMT(*USA)
007700011121     D #ISO            S               D   DATFMT(*ISO)
007800011128     D #TISO           S               D   DATFMT(*ISO)
007900011128     D #ANVISO         S               D   DATFMT(*ISO)
008000011128     D #RNWISO         S               D   DATFMT(*ISO)
008100011128     D #RUNISO         S               D   DATFMT(*ISO)
008200011121    ***
008300011218     D @HSMAN          S                   LIKE(SMANCD)
008400011121     D @@SM1           S                   LIKE(SMSG)
008500011126     D @@SM2           S                   LIKE(SMSG)
008600011121     D E#              S              2S 0
008700011220     D X               S              3S 0
008800011128     D ##2             S              2S 0
008900011127     D #2              S              2S 0
009000011127     D @2              S              2A
009100011218     D @3              S              3A
009200011218     D @4              S              4A
009300011128     D @@2             S              2A
009400011128     D @@3             S              3A
009500011127     D @6              S              6A
009600011127     D @8              S              8A
009700011128     D #8              S              8S 0
009800011127     D #9              S              9S 0
009900011127     D @9              S              9A
010000011127     D @10             S             10A
010100011127     D @50             S             50A
010200011127     D LETCOD          S              6A
010300011127     D #LTRTYP         S              2S 0
010400011121    ***
010500011126     D KEY@TRS         S                   LIKE(TRTRST)
010600011126     D KEY@SUB         S                   LIKE(SBSUB#)
010700011126     D KEY@ACC         S                   LIKE(ACACCT)
010800011218     D KEY@PLN         S                   LIKE(PLPLAN)
010900011126    ***
011000011126     D DES@TRS         S                   LIKE(TNAME)
011100011126     D DES@SUB         S                   LIKE(SUBNAM)
011200011126     D DES@ACC         S                   LIKE(ACNAM1)
011300011126    ***
011400011126     D @T3             S              3A
011500011126     D @S3             S              3A
011600011126     D @A4             S              4A
011700011126     D @TS6            S              6A
011800011126     D @TSAP           S             10A
011900011126    ***
012000011126     D @@VT            S              1A
012100011126     D @@VS            S              1A
012200011126     D @@VA            S              1A
012300011116   X***X
012400011116     C                   DOU       @STEP = 'LEAVE'
012500011116     C     @STEP         CASEQ     'PREP1'       $PREP1
012600011116     C     @STEP         CASEQ     'STEP1'       $STEP1
012700011116     C     @STEP         CASEQ     'STEP2'       $STEP2
012800011128     C     @STEP         CASEQ     'STEP3'       $STEP3
012900011128     C     @STEP         CASEQ     'STEP4'       $STEP4
013000011128     C     @STEP         CASEQ     'STEP5'       $STEP5
013100011128     C     @STEP         CASEQ     'STEP6'       $STEP6
013200011128     C     @STEP         CASEQ     'STEP7'       $STEP7
013300011128     C     @STEP         CASEQ     'STEP8'       $STEP8
013400011128     C     @STEP         CASEQ     'PREP9'       $PREP9
013500011128     C     @STEP         CASEQ     'STEP9'       $STEP9
013600011116     C                   ENDCS
013700011128     C                   ENDDO
013800011116     C                   MOVE      *ON           *INLR
013900011116   S***S
014000011116     C     *INZSR        BEGSR
014100011116    ***
014200011116     C                   MOVE      'PREP1'       @STEP
014300011116     C     KEY#CODE      KLIST
014400011116     C                   KFLD                    TYPE
014500011116     C                   KFLD                    CODE
014600011126     C*
014700011126     C     KEY#SUB       KLIST
014800011126     C                   KFLD                    KEY@TRS
014900011126     C                   KFLD                    KEY@SUB
015000011126     C*
015100011126     C     KEY#ACC       KLIST
015200011126     C                   KFLD                    KEY@TRS
015300011126     C                   KFLD                    KEY@SUB
015400011126     C                   KFLD                    KEY@ACC
015500011127     C*
015600011127     C     KEY#PLN       KLIST
015700011127     C                   KFLD                    KEY@TRS
015800011127     C                   KFLD                    KEY@SUB
015900011218     C                   KFLD                    KEY@PLN
016000011116    ***
016100011116     C                   ENDSR
016200011116   S***S
016300011121     C     $PREP1        BEGSR
016400011116    ***
016500011121     C                   CLEAR                   IO01
016600011121     C                   CLEAR                   IO02
016700011121     C                   MOVEL     CONAME        TITLE
016800011121     C                   MOVE      'STEP1'       @STEP
016900011126     C                   MOVE      *ALL'0'       VLTRST
017000011126     C                   MOVE      *ALL'0'       VLSUB#
017100011126     C                   MOVE      *ALL'0'       VLACCT
017200011127    ***
017300011127     C                   OPEN      SUBMST
017400011127     C                   OPEN      ACCMST
017500011116    ***
017600011116     C                   ENDSR
017700011116   S***S
017800011121     C     $STEP1        BEGSR
017900011121    ***
018000011121     C                   MOVEL     @@SM1         SMSG
018100011121     C                   EXFMT     IO01
018200011121     C                   MOVE      *BLANKS       @@SM1
018300011121     C                   MOVE      *BLANKS       SMSG
018400011121     C                   MOVE      *ZEROS        E#
018500011121    *** END APP
018600011121    1C                   IF        FKEY = F7
018700011121     C                   MOVEL(P)  'LEAVE'       @STEP
018800011121     C                   LEAVESR
018900011121    1C                   ENDIF
019000011126    *** TRUST SELECTOR
019100011126    1C                   IF        FKEY = F2
019200011126     C                   EXSR      $F2PROC
019300011126    2C                   IF        @@VT = 'Y'
019400011126     C                   MOVEL(P)  DES@TRS       O_TNAME
019500011126    2C                   ENDIF
019600011126     C                   LEAVESR
019700011126    1C                   ENDIF
019800011126    *** SUB SELECTOR
019900011126    1C                   IF        FKEY = F4
020000011126     C                   MOVE      VLTRST        @T3
020100011126     C                   EXSR      $F4PROC
020200011126    2C                   IF        @@VS = 'Y'
020300011126     C                   MOVEL(P)  DES@SUB       O_SNAME
020400011126    2C                   ENDIF
020500011126     C                   LEAVESR
020600011126    1C                   ENDIF
020700011126    *** ACCOUNT SELECTOR
020800011126    1C                   IF        FKEY = F6
020900011126     C                   MOVE      VLTRST        @T3
021000011126     C                   MOVE      VLSUB#        @S3
021100011126     C                   EXSR      $F6PROC
021200011126    2C                   IF        @@VA = 'Y'
021300011126     C                   MOVEL(P)  DES@ACC       O_ANAME
021400011126    2C                   ENDIF
021500011126     C                   LEAVESR
021600011126    1C                   ENDIF
021700011126    ***
021800011126     C                   EXSR      $VLDCHK
021900011126     C*
022000011126     C                   IF        @@SM1 = *BLANKS
022100011126     C                   MOVE      'STEP2'       @STEP
022200011126     C                   ENDIF
022300011121    ***
022400011121     C                   ENDSR
022500011121   S***S
022600011126     C     $VLDCHK       BEGSR
022700011126    ***
022800011126    1C                   IF        VLSUB# = 'ALL' AND VLACCT <> 'ALL'
022900011126     C                   MOVEL(P)  'ALL'         VLACCT
023000011126    1C                   ENDIF
023100011126    ***
023200011126     C                   MOVE      VLTRST        @T3
023300011126     C                   EXSR      $CHK_TRST
023400011126    1C                   IF        @@VT = 'N'
023500011126     C                   MOVEL(P)  M@(E#)        @@SM1
023600011126     C                   LEAVESR
023700011126    1C                   ELSE
023800011128     C                   MOVEL(P)  DES@TRS       O_TNAME
023900011126    1C                   ENDIF
024000011126    ***
024100011126     C                   MOVE      VLSUB#        @S3
024200011126     C                   EXSR      $CHK_SUBD
024300011126    1C                   IF        @@VS = 'N'
024400011126     C                   MOVEL(P)  M@(E#)        @@SM1
024500011126     C                   LEAVESR
024600011126    1C                   ELSE
024700011128     C                   MOVEL(P)  DES@SUB       O_SNAME
024800011126    1C                   ENDIF
024900011121    ***
025000011126     C                   MOVE      VLACCT        @A4
025100011126     C                   EXSR      $CHK_ACCT
025200011126    1C                   IF        @@VA = 'N'
025300011126     C                   MOVEL(P)  M@(E#)        @@SM1
025400011126     C                   LEAVESR
025500011126    1C                   ELSE
025600011128     C                   MOVEL(P)  DES@ACC       O_ANAME
025700011126    1C                   ENDIF
025800011126    ***
025900011126    1C                   IF        RENEWMY = 0
026000011127     C                   MOVEL(P)  M@(5)         @@SM1
026100011126     C                   LEAVESR
026200011126    1C                   ENDIF
026300011126     C*
026400011127     C                   MOVE      *BLANKS       @6
026500011127     C                   MOVE      RENEWMY       @6
026600011219     C                   EVAL      @8 = %SUBST(@6:3:4) +
026700011219     C                             %SUBST(@6:1:2) + '01'
026800011128     C                   MOVE      @8            #8
026900011128     C     *ISO          TEST(DE)                #8
027000011126     C                   IF        %ERROR
027100011127     C                   MOVEL(P)  M@(5)         @@SM1
027200011126     C                   LEAVESR
027300011126    1C                   ENDIF
027400011127     C                   MOVE      @8            @RENEW01
027500011127     C                   MOVE      @8            #RENEW01
027600011126    ***
027700011126    1C                   IF        PRTDATE = 0
027800011127     C                   MOVEL(P)  M@(6)         @@SM1
027900011126     C                   LEAVESR
028000011126    1C                   ENDIF
028100011126     C*
028200011126     C                   MOVE      *BLANKS       @8
028300011126     C                   MOVE      PRTDATE       @8
028400011128     C                   MOVE      @8            #8
028500011128     C     *USA          TEST(DE)                #8
028600011126     C                   IF        %ERROR
028700011127     C                   MOVEL(P)  M@(6)         @@SM1
028800011126     C                   LEAVESR
028900011126    1C                   ENDIF
029000011126    ***
029100011121     C                   ENDSR
029200011121   S***S
029300011126     C     $CHK_TRST     BEGSR
029400011126    ***
029500011126     C                   MOVE      'N'           @@VT
029600011126     C                   MOVE      *BLANKS       DES@TRS
029700011126    ***
029800011126    1C                   IF        @T3 = 'ALL'
029900011126     C                   MOVE      'Y'           @@VT
030000011126     C                   EVAL      DES@TRS = 'ALL TRUSTS'
030100011126     C                   LEAVESR
030200011126    1C                   ENDIF
030300011126    ***
030400011126     C                   TESTN                   @T3                  99
030500011126    1C                   IF        *IN99 = *OFF
030600011126     C                   Z-ADD     1             E#
030700011126     C                   LEAVESR
030800011126    1C                   ENDIF
030900011126    ***
031000011126     C                   MOVE      @T3           KEY@TRS
031100011126    ***
031200011126    1C                   IF        KEY@TRS = 0
031300011126     C                   Z-ADD     1             E#
031400011126     C                   LEAVESR
031500011126    1C                   ENDIF
031600011126    ***
031700011126     C     KEY@TRS       CHAIN(N)  TRSMSR
031800011126    1C                   IF        NOT %FOUND(TRSMST)
031900011126     C                   Z-ADD     2             E#
032000011126    1C                   ELSE
032100011126     C                   MOVEL(P)  TNAME         DES@TRS
032200011126     C                   MOVE      'Y'           @@VT
032300011126    1C                   ENDIF
032400011126    ***
032500011126     C                   ENDSR
032600011126   S***S
032700011126     C     $CHK_SUBD     BEGSR
032800011126    ***
032900011126     C                   MOVE      'N'           @@VS
033000011126     C                   MOVE      *BLANKS       DES@SUB
033100011126    ***
033200011126    1C                   IF        @S3 = 'ALL'
033300011126     C                   MOVE      'Y'           @@VS
033400011126     C                   EVAL      DES@SUB = 'ALL SUBDIVISIONS'
033500011126     C                   LEAVESR
033600011126    1C                   ENDIF
033700011126    ***
033800011126    1C                   IF        %SUBST(@S3:1:1) = '*'
033900011126     C                   MOVE      'Y'           @@VS
034000011126     C                   EVAL      DES@SUB = 'ALL MONTH ' + %SUBST(@S3:2:2) +
034100011126     C                             ' SUBDIVISIONS'
034200011126     C                   LEAVESR
034300011126    1C                   ENDIF
034400011126    ***
034500011126     C                   TESTN                   @S3                  99
034600011126    1C                   IF        *IN99 = *OFF
034700011126     C                   Z-ADD     3             E#
034800011126     C                   LEAVESR
034900011126    1C                   ENDIF
035000011126    ***
035100011126     C                   MOVE      @S3           KEY@SUB
035200011126    ***
035300011126    1C                   IF        KEY@SUB = 0
035400011126     C                   Z-ADD     3             E#
035500011126     C                   LEAVESR
035600011126    1C                   ENDIF
035700011126    ***
035800011126     C                   MOVE      @T3           KEY@TRS
035900011126     C     KEY#SUB       CHAIN(N)  SUBMSR
036000011126    1C                   IF        NOT %FOUND(SUBMST)
036100011126     C                   Z-ADD     4             E#
036200011126    1C                   ELSE
036300011126     C                   MOVEL(P)  SUBNAM        DES@SUB
036400011126     C                   MOVE      'Y'           @@VS
036500011126    1C                   ENDIF
036600011126    ***
036700011126     C                   ENDSR
036800011126   S***S
036900011126     C     $CHK_ACCT     BEGSR
037000011126    ***
037100011126     C                   MOVE      'N'           @@VA
037200011126     C                   MOVE      *BLANKS       DES@ACC
037300011126    ***
037400011126    1C                   IF        @A4 = 'ALL '
037500011126     C                   MOVE      'Y'           @@VA
037600011126     C                   EVAL      DES@ACC = 'ALL ACCOUNTS'
037700011126     C                   LEAVESR
037800011126    1C                   ENDIF
037900011126    ***
038000011126     C                   TESTN                   @A4                  99
038100011126    1C                   IF        *IN99 = *OFF
038200011126     C                   Z-ADD     7             E#
038300011126     C                   LEAVESR
038400011126    1C                   ENDIF
038500011126    ***
038600011126     C                   MOVE      @A4           KEY@ACC
038700011126    ***
038800011126    1C                   IF        KEY@ACC = 0
038900011126     C                   Z-ADD     7             E#
039000011126     C                   LEAVESR
039100011126    1C                   ENDIF
039200011126    ***
039300011126     C                   MOVE      @T3           KEY@TRS
039400011126     C                   MOVE      @S3           KEY@SUB
039500011126     C     KEY#ACC       CHAIN(N)  ACCMSR
039600011126    1C                   IF        NOT %FOUND(ACCMST)
039700011126     C                   Z-ADD     8             E#
039800011126    1C                   ELSE
039900011126     C                   MOVEL(P)  ACNAM1        DES@ACC
040000011126     C                   MOVE      'Y'           @@VA
040100011126    1C                   ENDIF
040200011126    ***
040300011126     C                   ENDSR
040400011126   S***S
040500011126    *** TRUST SELECTION WINDOW
040600011126     C     $F2PROC       BEGSR
040700011126    ***
040800011126     C                   MOVE      *BLANKS       @T3
040900011126     C                   CALL      'FM006CL'
041000011126     C                   PARM                    @T3
041100011126    ***
041200011126    1C                   IF        @T3 = '*LR'
041300011126     C                   MOVEL(P)  M@(9)         @@SM1
041400011126     C                   LEAVESR
041500011126    1C                   ENDIF
041600011126    ***
041700011126     C                   MOVE      @T3           VLTRST
041800011126     C                   EXSR      $CHK_TRST
041900011126    1C                   IF        @@VT = 'N'
042000011126     C                   MOVEL(P)  M@(E#)        @@SM1
042100011126    1C                   ENDIF
042200011126    ***
042300011126     C                   ENDSR
042400011126   S***S
042500011126    *** SUBDIVISION SELECTION WINDOW
042600011126    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
042700011126     C     $F4PROC       BEGSR
042800011126    ***
042900011126     C                   EXSR      $CHK_TRST
043000011126     C*
043100011126    1C                   IF        @@VT = 'N'
043200011126     C                   MOVEL(P)  M@(E#)        @@SM1
043300011126     C                   LEAVESR
043400011126    1C                   ENDIF
043500011126    ***
043600011126     C                   MOVEL(P)  @T3           @TS6
043700011126    ***
043800011126     C                   CALL      'FM007CL'
043900011126     C                   PARM                    @TS6
044000011126    ***
044100011126    1C                   IF        %SUBST(@TS6:4:3) = '*LR'
044200011126     C                   MOVEL(P)  M@(10)        @@SM1
044300011126     C                   LEAVESR
044400011126    1C                   ENDIF
044500011126    ***
044600011126     C                   EVAL      @S3 = %SUBST(@TS6:4:3)
044700011126     C                   MOVE      @S3           VLSUB#
044800011126     C*
044900011126     C                   EXSR      $CHK_SUBD
045000011126    1C                   IF        @@VS = 'N'
045100011126     C                   MOVEL(P)  M@(E#)        @@SM1
045200011126    1C                   ENDIF
045300011126    ***
045400011126     C                   ENDSR
045500011126   S***S
045600011126    *** EXISTING ACCT NUMBER INQUIRY
045700011126    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
045800011126     C     $F6PROC       BEGSR
045900011126    ***
046000011126     C                   EXSR      $CHK_TRST
046100011126     C*
046200011126    1C                   IF        @@VT = 'N'
046300011126     C                   MOVEL(P)  M@(E#)        @@SM1
046400011126     C                   LEAVESR
046500011126    1C                   ENDIF
046600011126    ***
046700011126     C                   EXSR      $CHK_SUBD
046800011126     C*
046900011126    1C                   IF        @@VS = 'N'
047000011126     C                   MOVEL(P)  M@(E#)        @@SM1
047100011126     C                   LEAVESR
047200011126    1C                   ENDIF
047300011126    ***
047400011126     C                   EVAL      @TSAP = @T3 + @S3 + '    '
047500011126     C                   CALL      'FM008CL'
047600011126     C                   PARM                    @TSAP
047700011126    ***
047800011126    1C                   IF        %SUBST(@TSAP:7:3) = '*LR'
047900011126     C                   MOVEL(P)  M@(12)        @@SM1
048000011126     C                   LEAVESR
048100011126    1C                   ENDIF
048200011126    ***
048300011126     C                   EVAL      @A4 = %SUBST(@TSAP:7:4)
048400011126     C                   MOVEL(P)  @A4           VLACCT
048500011126     C                   EXSR      $CHK_ACCT
048600011126    1C                   IF        @@VA = 'N'
048700011126     C                   MOVEL(P)  M@(E#)        @@SM1
048800011126    1C                   ENDIF
048900011126    ***
049000011126     C                   ENDSR
049100011126   S***S
049200011126     C     $STEP2        BEGSR
049300011121    ***
049400011126     C                   MOVEL     @@SM2         SMSG
049500011126     C                   EXFMT     IO02
049600011126     C                   MOVE      *BLANKS       @@SM2
049700011126     C                   MOVE      *BLANKS       SMSG
049800011126     C                   MOVE      *ZEROS        E#
049900011126    *** END APP
050000011126    1C                   IF        FKEY = F7
050100011126     C                   MOVEL(P)  'LEAVE'       @STEP
050200011126     C                   LEAVESR
050300011126    1C                   ENDIF
050400011126    *** BACK
050500011126    1C                   IF        FKEY = F12
050600011126     C                   MOVEL(P)  'STEP1'       @STEP
050700011126     C                   LEAVESR
050800011126    1C                   ENDIF
050900011126    ***
051000011126     C                   EXSR      $VALSTP2
051100011126     C                   IF        @@SM2 = *BLANKS
051200011126     C                   MOVE      'STEP3'       @STEP
051300011126     C                   ENDIF
051400011121    ***
051500011121     C                   ENDSR
051600011121   S***S
051700011126     C     $VALSTP2      BEGSR
051800011116    ***
051900011126     C                   IF        LT010 = *BLANKS
052000011126     C                   MOVEL(P)  M@(11)        @@SM2
052100011126     C                   LEAVESR
052200011116     C                   ENDIF
052300011116    ***
052400011116     C                   ENDSR
052500011116   S***S
052600011126     C     $STEP3        BEGSR
052700011116    ***
052800011127     C                   Z-ADD     1             #LTRTYP
052900011127     C* FUTURE           MOVE      *ZEROS        #LTRTYP
053000011126    *C*  USE             SELECT
053100011126    *C*                  WHEN      LT010 <> *BLANKS
053200011126    *C*                  MOVE      1             #LTRTYP
053300011126    *C*                  ENDSL
053400011116    ***
053500011127     C                   CLOSE     SUBMST
053600011116     C                   OPEN      CODES
053700011116     C                   OPEN      RP350WF
053800011116    ***
053900011116     C                   MOVE      @RENEW01      #RENEW01
054000011116     C                   MOVEL     RENEWMY       @SEPREN
054100011116    ***
054200011116     C                   SELECT
054300011126     C                   WHEN      VLTRST =  'ALL' AND VLSUB#  = 'ALL'
054400011126     C                   MOVEL(P)  'STEP4'       @STEP
054500011126     C                   WHEN      VLTRST =  'ALL' AND
054600011126     C                             %SUBST(VLSUB#:1:1) = '*'
054700011126     C                   MOVEL(P)  'STEP5'       @STEP
054800011126     C                   WHEN      VLTRST <> 'ALL' AND VLSUB# =  'ALL'
054900011126     C                   MOVEL(P)  'STEP6'       @STEP
055000011126     C                   WHEN      VLTRST <> 'ALL' AND VLSUB# <> 'ALL' AND
055100011126     C                             VLACCT =  'ALL '
055200011126     C                   MOVEL(P)  'STEP7'       @STEP
055300011126     C                   OTHER
055400011126     C                   MOVEL(P)  'STEP8'       @STEP
055500011116     C                   ENDSL
055600011126    ***
055700011126     C                   ENDSR
055800011126   S***S
055900011126     C     $STEP4        BEGSR
056000011126    ***
056100011126     C                   Z-ADD     1             KEY@TRS
056200011126     C                   Z-ADD     1             KEY@SUB
056300011126     C                   Z-ADD     1             KEY@ACC
056400011126     C     KEY#ACC       SETLL     ACCMSR
056500011126     C                   DOU       %EOF(ACCMST)
056600011126     C                   READ      ACCMSR
056700011126     C                   IF        NOT %EOF(ACCMST)
056800011126     C                   EXSR      $EXTCHK
056900011126     C                   ENDIF
057000011126     C                   ENDDO
057100011126    ***
057200011126     C                   MOVEL(P)  'PREP9'       @STEP
057300011116    ***
057400011116     C                   ENDSR
057500011116   S***S
057600011126     C     $EXTCHK       BEGSR
057700011116    ***
057800011116     C                   IF        ATRMDT <= #RENEW01 AND ATRMDT <> 0
057900011116     C                   LEAVESR
058000011116     C                   ENDIF
058100011116    ***
058200011116     C                   IF        RNEWPD = 0
058300011116     C                   LEAVESR
058400011116     C                   ENDIF
058500011116    ***
058600011116     C                   IF        ACTRST = 4
058700011116     C                   Z-ADD     19920601      #8
058800011116     C                   ELSE
058900011116     C                   Z-ADD     ENROLL        #8
059000011116     C                   ENDIF
059100011116     C*
059200011116     C                   MOVE      #8            #ANVISO
059300011116     C                   MOVE      #RENEW01      #RNWISO
059400011116     C*
059500011116     C                   DOU       #ANVISO >= #RNWISO
059600011116     C                   ADDDUR    RNEWPD:*M     #ANVISO
059700011116     C                   ENDDO
059800011116     C*
059900011116     C                   IF        #ANVISO <> #RNWISO
060000011116     C                   LEAVESR
060100011116     C                   ENDIF
060200011116    ***
060300011116     C     SMANCD        CHAIN(N)  SMANR
060400011116     C                   IF        NOT %FOUND(SMAN)
060500011116     C                   LEAVESR
060600011116     C                   ENDIF
060700011116    ***
060800011116     C                   EVAL      TYPE = %SUBST(STYPE:1:1)
060900011116     C                   EVAL      CODE = %SUBST(STYPE:2:2)
061000011116     C*
061100011119     C     KEY#CODE      CHAIN(N)  CODESR
061200011116     C*
061300011119     C                   IF        NOT %FOUND(CODES)
061400011116     C                   LEAVESR
061500011116     C                   ENDIF
061600011116    ***
061700011126     C                   MOVE      'Z'           SIZECD
061800011126     C                   WRITE     F350
061900011116    ***
062000011116     C                   ENDSR
062100011116   S***S
062200011126     C     $STEP5        BEGSR
062300011126    ***
062400011126     C                   Z-ADD     1             KEY@TRS
062500011127     C                   MOVE      *BLANKS       @2
062600011127     C                   MOVE      *ZEROS        #2
062700011126     C                   EVAL      @2 = %SUBST(VLSUB#:2:2)
062800011126     C                   MOVE      @2            #2
062900011126     C                   Z-ADD     #2            KEY@SUB
063000011126     C                   Z-ADD     1             KEY@ACC
063100011126     C     KEY#ACC       SETLL     ACCMSR
063200011128    1C                   DOU       %EOF(ACCMST)
063300011126     C                   READ      ACCMSR
063400011128    2C                   IF        NOT %EOF(ACCMST)
063500011128     C                   MOVE      ACSUB#        @@3
063600011128     C                   EVAL      @@2 = %SUBST(@@3:2:2)
063700011128     C                   MOVE      @@2           ##2
063800011128    3C                   IF        ##2 = #2
063900011126     C                   EXSR      $EXTCHK
064000011128    3C                   ENDIF
064100011128    2C                   ENDIF
064200011128    1C                   ENDDO
064300011126    ***
064400011126     C                   MOVEL(P)  'PREP9'       @STEP
064500011126    ***
064600011126     C                   ENDSR
064700011126   S***S
064800011126     C     $STEP6        BEGSR
064900011126    ***
065000011128     C                   MOVE      VLTRST        KEY@TRS
065100011126     C                   Z-ADD     1             KEY@SUB
065200011126     C                   Z-ADD     1             KEY@ACC
065300011126     C     KEY#ACC       SETLL     ACCMSR
065400011126     C                   DOU       %EOF(ACCMST)
065500011128     C     KEY@TRS       READE     ACCMSR
065600011126     C                   IF        NOT %EOF(ACCMST)
065700011126     C                   EXSR      $EXTCHK
065800011126     C                   ENDIF
065900011126     C                   ENDDO
066000011126    ***
066100011126     C                   MOVEL(P)  'PREP9'       @STEP
066200011126    ***
066300011126     C                   ENDSR
066400011126   S***S
066500011126     C     $STEP7        BEGSR
066600011126    ***
066700011128     C                   MOVE      VLTRST        KEY@TRS
066800011128     C                   MOVE      VLSUB#        KEY@SUB
066900011126     C                   Z-ADD     1             KEY@ACC
067000011126     C     KEY#ACC       SETLL     ACCMSR
067100011126     C                   DOU       %EOF(ACCMST)
067200011126     C     KEY#SUB       READE     ACCMSR
067300011126     C                   IF        NOT %EOF(ACCMST)
067400011126     C                   EXSR      $EXTCHK
067500011126     C                   ENDIF
067600011126     C                   ENDDO
067700011126    ***
067800011126     C                   MOVEL(P)  'PREP9'       @STEP
067900011126    ***
068000011126     C                   ENDSR
068100011126   S***S
068200011126     C     $STEP8        BEGSR
068300011126    ***
068400011128     C                   MOVE      VLTRST        KEY@TRS
068500011128     C                   MOVE      VLSUB#        KEY@SUB
068600011128     C                   MOVE      VLACCT        KEY@ACC
068700011126     C     KEY#ACC       SETLL     ACCMSR
068800011126     C                   DOU       %EOF(ACCMST)
068900011126     C     KEY#ACC       READE     ACCMSR
069000011126     C                   IF        NOT %EOF(ACCMST)
069100011126     C                   EXSR      $EXTCHK
069200011126     C                   ENDIF
069300011126     C                   ENDDO
069400011126    ***
069500011126     C                   MOVEL(P)  'PREP9'       @STEP
069600011126    ***
069700011126     C                   ENDSR
069800011126   S***S
069900011126     C     $PREP9        BEGSR
070000011116    ***
070100011127     C                   CLOSE     ACCMST
070200011127     C                   CLOSE     CODES
070300011127     C                   CLOSE     RP350WF
070400011127    ***
070500011127     C                   OPEN      MCOVX
070600011128     C**                 OPEN      GRATE
070700011127     C                   OPEN      HIST
070800011127     C                   OPEN      RP350WF
070900011128     C                   OPEN      PLNMST
071000011127    ***
071100011127     C                   MOVE      'STEP9'       @STEP
071200011116    ***
071300011116     C                   ENDSR
071400011116   S***S
071500011127     C     $STEP9        BEGSR
071600011116    ***
071700011128     C                   MOVE      PRTDATE       @8
071800011127     C                   MOVEL     @8            @2
071900011127     C                   MOVE      @2            #2
072000011218     C                   MOVEL     YR(#2)        @9
072100011218     C                   EVAL      @2 = %SUBST(@8:3:2)
072200011218     C                   IF        %SUBST(@2:1:1) = '0'
072300011218     C                   EVAL      %SUBST(@2:1:1) = ' '
072400011218     C                   ENDIF
072500011218     C                   EVAL      HV01 = %TRIMR(@9) + ' ' + %TRIM(@2)
072600011127     C                             + ', ' + %SUBST(@8:5:4)
072700011127    *C*
072800011127     C                   EVAL      @2 = %SUBST(@RENEW01:5:2)
072900011127     C                   MOVE      @2            #2
073000011219     C                   MOVEA     YR(#2)        @9
073100011219     C                   EVAL      HV05 = %TRIMR(@9) + ' 01, ' +
073200011127     C                             %SUBST(@RENEW01:1:4)
073300011127    ***
073400011127     C                   DOU       %EOF(RP350WF)
073500011127     C                   READ      F350
073600011127     C                   IF        NOT %EOF(RP350WF)
073700011127    ***
073800011127     C* FUTURE USE       IF        #LTRTYP = 1
073900011127     C                   MOVEL     'B-90  '      LETCOD
074000011127     C                   EXSR      $LETTER1
074100011127     C* FUTURE USE       ENDIF
074200011127    ***
074300011127     C                   ENDIF
074400011127     C                   ENDDO
074500011219    ***
074600011219     C                   MOVE      'LEAVE'       @STEP
074700011127    ***
074800011127     C                   ENDSR
074900011127   S***S
075000011127     C     $LETTER1      BEGSR
075100011127    ***
075200011218     C                   IF        SMANCD <> @HSMAN
075300011218    *C*
075400011218     C                   MOVEL(P)  SMANCD        @HSMAN
075500011218     C                   EXSR      $L1BODY
075600011218    *C*
075700011218     C                   EVAL      HV11 = HV02
075800011218     C                   EVAL      HV12 = HV05
075900011218     C                   WRITE     HDGF11
076000011218    *C*
076100011218     C                   ENDIF
076200011218    ***
076300011218     C                   EXSR      $L1DETL
076400011218    ***
076500011218     C                   EXSR      $WRTHST
076600011218    ***
076700011218     C                   ENDSR
076800011218   S***S
076900011218     C     $L1BODY       BEGSR
077000011218    ***
077100011127     C     SMANCD        CHAIN(N)  SMANR
077200011127     C                   MOVE      *BLANKS       @50
077300011219     C                   MOVE      *BLANKS       HV04
077400011219     C                   MOVE      *BLANKS       HV03
077500011219     C                   MOVE      *BLANKS       HV02
077600011219     C                   MOVE      *BLANKS       HV06
077700011127    *C*
077800011127     C                   IF        SMI = *BLANKS
077900011127     C                   EVAL      @50 = %TRIMR(SFNAME) + ' ' + SLNAME
078000011127     C                   ELSE
078100011127     C                   EVAL      @50 = %TRIMR(SFNAME) + ' ' + SMI +
078200011127     C                             '. ' + SLNAME
078300011127     C                   ENDIF
078400011127    *C*
078500011219     C                   MOVEL     @50           HV02
078600011127     C     @50           CAT       ':':1         HV06
078700011127    ***
078800011127     C                   CLEAR                   @50
078900011127    *C*
079000011127     C                   MOVE      SZIPCD        #9
079100011127     C                   MOVE      #9            @9
079200011127    *C*
079300011127     C                   EVAL      @50 = %TRIMR(SCITY) + ', ' +
079400011218     C                             %TRIMR(SSTATE) + '. ' + %SUBST(@9:1:5)
079500011127    *C*
079600011127     C                   MOVEL     @50           HV04
079700011219     C                   MOVEL     SADDR         HV03
079800011127    ***
079900011127     C                   WRITE     LTRF01
080000011218     C                   WRITE     PAGES1
080100011127    ***
080200011218     C                   ENDSR
080300011218   S***S
080400011218     C     $L1DETL       BEGSR
080500011218    ***
080600011218     C                   MOVEL(P)  ACNAM1        HV112
080700011218     C                   EVAL      HV122 = (ACTRST * 10000000) +
080800011218     C                             (ACSUB# * 10000) + ACACCT
080900011218     C                   Z-ADD     NOEMPL        HV132
081000011218     C     ACTRST        CHAIN     TRSMSR
081100011218     C                   MOVEL(P)  TNAME         HV142
081200011218     C                   IF        *IN81 = *ON
081300011218     C                   WRITE     PAGES2
081400011218     C                   WRITE     HDGF11
081500011218     C                   EVAL      *IN81 = *OFF
081600011218     C                   ENDIF
081700011218     C                   WRITE     HDGF12
081800011218    ***
081900011127     C                   EXSR      $GETPLANS
082000011127    ***
082100011220     C                   IF        #KNE > 0
082200011220    *C*
082300011220     C                   MOVE      *ZEROS        Z                 3 0
082400011220     C                   MOVE      *ZEROS        Y                 3 0
082500011220     C                   MOVE      *ZEROS        X
082600011220     C                   EVAL      Y = 400 - #KNE
082700011220     C                   DOU       X = #KNE
082800011220     C                   ADD       1             X
082900011127     C                   IF        *IN81 = *ON
083000011218     C                   WRITE     PAGES2
083100011127     C                   WRITE     HDGF11
083200011127     C                   EVAL      *IN81 = *OFF
083300011127     C                   ENDIF
083400011220     C                   EVAL      Z = X + Y
083500011220     C                   MOVEA     DES(Z)        DV11
083600011127     C                   WRITE     DTLF11
083700011127     C                   ENDDO
083800011220    *C*
083900011220     C                   ENDIF
084000011127    ***
084100011218     C                   WRITE     PAGES2
084200011127    ***
084300011127     C                   ENDSR
084400011127   S***S
084500011127     C     $GETPLANS     BEGSR
084600011127    ***
084700011127     C                   MOVE      *ZEROS        #KNE
084800011127     C                   CLEAR                   DES
084900011127     C                   Z-ADD     ACTRST        KEY@TRS
085000011127     C                   Z-ADD     ACSUB#        KEY@SUB
085100011127     C                   Z-ADD     ACACCT        KEY@ACC
085200011127    ***
085300011127     C     KEY#ACC       SETLL     MCOVR
085400011127     C                   DOU       %EOF(MCOVX)
085500011218     C     KEY#ACC       READE     MCOVR
085600011127     C                   IF        NOT %EOF(MCOVX) AND MCDLTD <> 'D'
085700011127    ***
085800011127     C                   MOVE      ENRLDT        @8
085900011127     C                   EVAL      %SUBST(@8:7:2) = '01'
086000011127     C                   MOVE      @8            #8
086100011127    ***
086200011127     C                   IF        CANDT = 0 OR (#RENEW01 >= #8 AND
086300011127     C                             #RENEW01 < CANDT)
086400011218     C                   MOVEL(P)  MCPLAN        KEY@PLN
086500011127     C     KEY#PLN       CHAIN(N)  PLNMSR
086600011127    ***
086700011127     C                   IF        %FOUND(PLNMST)
086800011127     C                   MOVE      *OFF          *IN99
086900011127     C     PDESCR        LOOKUP    DES                                    99
087000011127    ***
087100011127     C                   IF        NOT %FOUND
087200011127     C                   ADD       1             #KNE
087300011127     C                   MOVEA     PDESCR        DES(#KNE)
087400011127    ***
087500011127     C                   ENDIF
087600011127     C                   ENDIF
087700011127     C                   ENDIF
087800011127     C                   ENDIF
087900011127     C                   ENDDO
088000011220    ***
088100011220     C                   IF        #KNE > 0
088200011220     C                   SORTA     DES
088300011220     C                   ENDIF
088400011127    ***
088500011116     C                   ENDSR
088600011116   S***S
088700011126     C     $WRTHST       BEGSR
088800011127    ***
088900011126     C                   CLEAR                   HISTR
089000011218     C                   MOVE      ACTRST        @3
089100011218     C                   CAT       @3:0          HKEY
089200011218     C                   MOVE      ACSUB#        @3
089300011218     C                   CAT       @3:0          HKEY
089400011218     C                   MOVE      ACACCT        @4
089500011218     C                   CAT       @4:0          HKEY
089600011126     C                   MOVE      'UHM'         TRCODE
089700011126     C                   EVAL      CK#NOT = 'SENT RENEWAL LETTER - ' + LETCOD
089800131025     C                   MOVEL     'RP350R'      HPRGNM
089900011126     C                   MOVE      ACTRST        HSTRST
090000011126     C                   MOVE      ACSUB#        HSSUB#
090100011126     C                   MOVE      ACACCT        HSACCT
090200131017     C                   MOVEL     luser         HOPER
090300011126     C                   MOVE      'A'           HSDLTD
090400011218     C                   MOVE      *DATE         #TISO
090500011126     C                   MOVE      #TISO         TRDATE
090600011218     C                   MOVE      *DATE         #RUNISO
090700011126     C                   MOVE      #RUNISO       COVTDT
090800131011     c                   eval      hstrtime = %time
090900011126     C                   WRITE     HISTR
091000011126     C                   ENDSR
091100011121   X***X
091200011121**
091300011121January
091400011121February
091500011121March
091600011121April
091700011121May
091800011121June
091900011121July
092000011121August
092100011121September
092200011121October
092300011121November
092400011121December
092500011121** COVERAGE TYPES
092600011121TIN
092700011121TPC
092800011121THW
092900011121TFA
093000011126** M@ CTDATA
093100011128TRUST NUMBER CANNOT BE ZERO
093200011128TRUST NUMBER IS NOT ON MASTER FILE
093300011128SUBDIVISION NUMBER CANNOT BE ZERO
093400011128TRUST/SUB IS NOT ON SUBDIVISION MASTER FILE
093500011128RENEWAL MONTH/YEAR IS INVALID
093600011128DATE TO BE PRINTED ON LETTERS IS INVALID
093700011128ACCOUNT NUMBER CANNOT BE ZERO
093800011128TRUST/SUB/ACCOUNT IS NOT ON ACCOUNT MASTER FILE
093900011128TRUST NOT SELECTED FROM INQUIRY
094000011128SUBDIVISION NOT SELECTED FROM INQUIRY
094100011128LETTER TO PRINT WAS NOT SELECTED
094200011128ACCOUNT NOT SELECTED FROM INQUIRY
