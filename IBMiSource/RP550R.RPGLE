000100111117     ***SSK PROGRAM  DIARY NOTE REPORTING
000200111117     *** 11/17/2011 CSV OPTION AND CODES EXPANSION
000300111117     ***
000400020320     FRP550D    CF   E             WORKSTN INFDS(WSDS)
000500000000     FTRSMST    IF   E           K DISK
000600000000     ** TRUST MASTER FILE
000700000000     FSUBMST    IF   E           K DISK
000800000000     ** SUBDIVISION MASTER FILE
000900000000     FACCMST    IF   E           K DISK
001000000000     ** ACCOUNT MASTER FILE
001100000000     FMEMBER    IF   E           K DISK
001200000000     ** MEMBER MASTER FILE
001300020312     FDIARYHD4  IF   E           K DISK    RENAME(RDIARYHD:FMT1)
001400020312     ** HEADER FILE 4
001500020312     FDIARYHD3  IF   E           K DISK    RENAME(RDIARYHD:FMT2)
001600020308     ** HEADER FILE 3
001700000000     FDIARYDT1  IF   E           K DISK
001800000000     ** DETAIL FILE 1
001900000000     FGBSECURE  IF   E           K DISK
002000000000     ** USER SECURITY FILE
002100000000     FCODES     IF   E           K DISK
002200000000     ** CODE MASTER FILE
002300020320     FRP550P1   O    E             PRINTER OFLIND(*IN80) USROPN
002400111117     ** PRINT FILE
002500111117     FRP550W1   O  A F 3000        DISK    USROPN
002600111117     ** CSV FILE
002700000000   X***X
002800020320     D @EOF            S              1A
002900020320     D @SEC            S              1A
003000020312     D @11             S             11A
003100111117     D @CTXT           S             20A
003200111117     D @CELL           S           2000A
003300000000     D #CNTREC         S              4S 0
003400000000     D @1STLOOP        S              1A
003500000000     D RRT             S              4S 0
003600000000     D @DV             S              1A
003700000000     D @STEP           S              5A
003800020312     D @@APS           C                   CONST('''')
003900020321     D @USER           S             10A
004000020308     D @VUSA           S              1A
004100000000     D @@SM1           S                   LIKE(R1MSG)
004200000000     D E#              S              3S 0
004300020312     D M@              S             50A   CTDATA DIM(18)
004400000000     D #ISO            S               D   DATFMT(*ISO)
004500000000     D #USA            S               D   DATFMT(*USA)
004600000000     D #USO            S              8S 0
004700000000     D #ISA            S              8S 0
004800020312     D EFRISO          S              8S 0
004900020312     D ETOISO          S              8S 0
005000000000     D @105            S            105A
005100000000     D @14             S             14A
005200000000     D #14             S             14S 0
005300000000     D @6              S              6A
005400000000     D @8              S              8A
005500000000     D #8              S              8S 0
005600020312     D @UTXT           S             20A
005700000000    ***
005800000000     D                 DS
005900000000     D @PINDS                  1     11A
006000000000     D PIN@SI                  1      1A
006100000000     D PIN@M                   2     10A
006200000000     D PIN@T                   2      4A
006300000000     D PIN@S                   5      7A
006400000000     D PIN@A                   8     11A
006500000000     D PIN@CHK                11     11A
006600000000     D @@PIN           S             11A
006700000000    ***
006800000000     D KEY@TRS         S                   LIKE(TRTRST)
006900000000     D KEY@SUB         S                   LIKE(SBSUB#)
007000000000     D KEY@ACC         S                   LIKE(ACACCT)
007100000000     D KEY@MBR         S                   LIKE(MBSSNO)
007200000000     D KEY@KEY         S                   LIKE(NHKEY)
007300020312     D KEY@ADDT        S                   LIKE(NHADDT)
007400020312     D KEY@ADTI        S                   LIKE(NHADTI)
007500000000     D KEY@TYPE        S                   LIKE(TYPE)
007600000000     D KEY@CODE        S                   LIKE(CODE)
007700000000    ***
007800000000     D DES@TRS         S                   LIKE(TNAME)
007900000000     D DES@SUB         S                   LIKE(SUBNAM)
008000000000     D DES@ACC         S                   LIKE(ACNAM1)
008100000000     D DES@MBR         S                   LIKE(O_MNAME)
008200000000     D DES@SDS         S                   LIKE(SDESCR)
008300000000     D DES@LDS         S                   LIKE(LDESCR)
008400000000    ***
008500111117     D C@T3            S              3A
008600111117     D C@S3            S              3A
008700111117     D C@A4            S              4A
008800000000     D @T3             S              3A
008900000000     D @S3             S              3A
009000000000     D @A4             S              4A
009100000000     D @TS6            S              6A
009200000000     D @TSAP           S             10A
009300000000     D @M9             S              9A
009400000000    ***
009500000000     D @@VT            S              1A
009600000000     D @@VS            S              1A
009700000000     D @@VA            S              1A
009800000000     D @@VM            S              1A
009900000000     D @@VC            S              1A
010000000000    ***
010100000000     D WSDS            DS
010200000000     D  FKEY                 369    369A
010300000000    ***
010400000000     D  F1             C                   CONST(X'31')
010500000000     D  F2             C                   CONST(X'32')
010600000000     D  F3             C                   CONST(X'33')
010700000000     D  F4             C                   CONST(X'34')
010800000000     D  F5             C                   CONST(X'35')
010900000000     D  F6             C                   CONST(X'36')
011000000000     D  F7             C                   CONST(X'37')
011100000000     D  F8             C                   CONST(X'38')
011200000000     D  F9             C                   CONST(X'39')
011300000000     D  F10            C                   CONST(X'3A')
011400000000     D  F11            C                   CONST(X'3B')
011500000000     D  F12            C                   CONST(X'3C')
011600000000     D  F13            C                   CONST(X'B1')
011700000000     D  F14            C                   CONST(X'B2')
011800000000     D  F15            C                   CONST(X'B3')
011900000000     D  F16            C                   CONST(X'B4')
012000000000     D  F17            C                   CONST(X'B5')
012100000000     D  F18            C                   CONST(X'B6')
012200000000     D  F19            C                   CONST(X'B7')
012300000000     D  F20            C                   CONST(X'B8')
012400000000     D  F21            C                   CONST(X'B9')
012500000000     D  F22            C                   CONST(X'BA')
012600000000     D  F23            C                   CONST(X'BB')
012700000000     D  F24            C                   CONST(X'BC')
012800000000    ***
012900000000     D                UDS
013000000000     D  XONAME               201    240
013100000000    ***
013200020312     D @EMLCHK         S              1A
013300020312     D #LEN            S              3P 0
013400020312     D ##RL            S             15P 5
013500020312     D @@CMD           S            300A
013600020312     D @MSGTXT         S            256A
013700020312     D @46             S             46A
013800000000   X***X
013900000000     C                   DOU       @STEP = 'LEAVE'
014000000000     C     @STEP         CASEQ     'PREP1'       $PREP1
014100000000     C     @STEP         CASEQ     'STEP1'       $STEP1
014200000000     C     @STEP         CASEQ     'STEP2'       $STEP2
014300020320     C     @STEP         CASEQ     'STEP3'       $STEP3
014400020320     C     @STEP         CASEQ     'STEP4'       $STEP4
014500020320     C     @STEP         CASEQ     'STEP5'       $STEP5
014600020320     C     @STEP         CASEQ     'STEP6'       $STEP6
014700020320     C     @STEP         CASEQ     'STEP7'       $STEP7
014800020320     C     @STEP         CASEQ     'STEP8'       $STEP8
014900000000     C                   ENDCS
015000000000     C                   ENDDO
015100020320    ***
015200111117     C                   CLOSE(E)  RP550W1
015300111117     C                   CLOSE(E)  RP550P1
015400000000     C                   MOVE      *ON           *INLR
015500020312     C                   IF        @EMLCHK = 'Y'
015600111117     C     PRTOREML      CASEQ     'C'           $CSVMAIL
015700111117     C     PRTOREML      CASEQ     'E'           $EMAIL
015800111117     C                   CAS                     $EXITPRT
015900111117     C                   ENDCS
016000020312     C                   ENDIF
016100000000   S***S
016200111117     C     $EXITPRT      BEGSR
016300000000    ***
016400111117     C                   MOVE      *BLANKS       @MSGTXT
016500111117     C                   EVAL      @MSGTXT = 'RLSSPLF FILE(RP550P1) SPLNBR(*LAS-
016600111117     C                             T)'
016700111117     C                   EVAL      @@CMD = %TRIM(@MSGTXT)
016800111117     C                   MOVE      *ZEROS        #LEN
016900111117     C                   EVAL      #LEN = %LEN(%TRIM(@@CMD))
017000111117     C                   Z-ADD     #LEN          ##RL
017100111117     C                   CALL      'QCMDEXC'
017200111117     C                   PARM                    @@CMD
017300111117     C                   PARM                    ##RL
017400111117    ***
017500111117     C                   ENDSR
017600111117   S***S
017700111117     C     *INZSR        BEGSR
017800111117    ***
017900000000     C                   MOVE      'PREP1'       @STEP
018000000000    ***
018100000000     C     *ENTRY        PLIST
018200000000     C                   PARM                    @@PIN
018300000000     C                   MOVEL     @@PIN         @PINDS
018400000000    ***
018500000000     C     KEY#SUB       KLIST
018600000000     C                   KFLD                    KEY@TRS
018700000000     C                   KFLD                    KEY@SUB
018800020312     C*
018900020312     C     KEY@DTL1      KLIST
019000020312     C                   KFLD                    KEY@KEY
019100020312     C                   KFLD                    KEY@ADDT
019200020312     C                   KFLD                    KEY@ADTI
019300000000     C*
019400000000     C     KEY#CODES     KLIST
019500000000     C                   KFLD                    KEY@TYPE
019600000000     C                   KFLD                    KEY@CODE
019700000000     C*
019800000000     C     KEY#ACC       KLIST
019900000000     C                   KFLD                    KEY@TRS
020000000000     C                   KFLD                    KEY@SUB
020100000000     C                   KFLD                    KEY@ACC
020200000000    ***
020300000000     C                   ENDSR
020400000000   S***S
020500000000     C     $PREP1        BEGSR
020600000000    ***
020700020312     C                   MOVE      'N'           @EMLCHK
020800000000     C                   CLEAR                   IO01
020900000000     C                   MOVEL     XONAME        CONAME
021000000000     C                   MOVE      'STEP1'       @STEP
021100000000    ***
021200000000    1C                   IF        PIN@SI = 'I'
021300000000    *C*
021400000000    2C                   IF        PIN@CHK <> *BLANKS
021500000000    *C*
021600000000     C                   MOVE      *ON           *IN35
021700000000     C                   MOVE      PIN@T         I_TRST
021800000000     C                   MOVE      PIN@S         I_SUB#
021900000000     C                   MOVE      PIN@A         I_ACCT
022000000000    *C*
022100000000    2C                   ELSE
022200000000    *C*
022300000000     C                   MOVE      PIN@M         I_SS#
022400000000     C                   MOVE      *OFF          *IN35
022500000000    *C*
022600000000    2C                   ENDIF
022700000000    *C*
022800000000    2C                   IF        PIN@M <> *BLANKS OR PIN@M <> '000000000'
022900000000     C                   EXSR      $VALIDATION
023000000000    2C                   ENDIF
023100000000    *C*
023200000000    1C                   ELSE
023300000000    *C*
023400000000     C                   MOVE      *ON           *IN35
023500000000     C                   MOVE      *ON           *IN30
023600000000    *C*
023700000000    1C                   ENDIF
023800000000    ***
023900000000     C                   ENDSR
024000000000   S***S
024100000000     C     $STEP1        BEGSR
024200000000    ***
024300000000     C                   MOVEL     @@SM1         R1MSG
024400000000     C                   EXFMT     IO01
024500000000     C                   MOVE      *BLANKS       @@SM1
024600000000     C                   MOVE      *BLANKS       R1MSG
024700000000     C                   MOVE      *ZEROS        E#
024800000000    *** END APP
024900000000    1C                   IF        FKEY = F7
025000000000     C                   MOVEL(P)  'LEAVE'       @STEP
025100000000     C                   LEAVESR
025200000000    1C                   ENDIF
025300000000    *** TOGGLE SCREEN
025400000000    1C                   IF        FKEY = F9
025500000000     C                   IF        *IN35 = *ON
025600000000     C                   MOVE      *OFF          *IN35
025700000000     C                   ELSE
025800000000     C                   MOVE      *ON           *IN35
025900000000     C                   ENDIF
026000000000     C                   LEAVESR
026100000000    1C                   ENDIF
026200020321    *** USER SELECTOR
026300020321    1C                   IF        FKEY = F11
026400020321     C                   EXSR      $F11PROC
026500020321     C                   LEAVESR
026600020321    1C                   ENDIF
026700000000    *** TRUST SELECTOR
026800000000    1C                   IF        FKEY = F2
026900000000     C                   EXSR      $F2PROC
027000000000    2C                   IF        @@VT = 'Y'
027100000000     C                   MOVEL(P)  DES@TRS       O_TNAME
027200000000    2C                   ENDIF
027300000000     C                   LEAVESR
027400000000    1C                   ENDIF
027500000000    *** SUB SELECTOR
027600000000    1C                   IF        FKEY = F4
027700000000     C                   MOVE      I_TRST        @T3
027800000000     C                   EXSR      $F4PROC
027900000000    2C                   IF        @@VS = 'Y'
028000000000     C                   MOVEL(P)  DES@SUB       O_SNAME
028100000000    2C                   ENDIF
028200000000     C                   LEAVESR
028300000000    1C                   ENDIF
028400000000    *** ACCOUNT SELECTOR
028500000000    1C                   IF        FKEY = F6
028600000000     C                   MOVE      I_TRST        @T3
028700000000     C                   MOVE      I_SUB#        @S3
028800000000     C                   EXSR      $F6PROC
028900000000    2C                   IF        @@VA = 'Y'
029000000000     C                   MOVEL(P)  DES@ACC       O_ANAME
029100000000    2C                   ENDIF
029200000000     C                   LEAVESR
029300000000    1C                   ENDIF
029400000000    ***
029500000000     C                   EXSR      $VALIDATION
029600000000    ***
029700000000     C                   IF        @DV = 'Y'
029800000000    1C                   IF        FKEY = F10
029900000000     C                   MOVEL(P)  'STEP2'       @STEP
030000000000     C                   LEAVESR
030100000000    1C                   ENDIF
030200000000     C                   ENDIF
030300000000    ***
030400000000     C                   ENDSR
030500000000   S***S
030600000000     C     $VALIDATION   BEGSR
030700000000    *** VALIDATIONS
030800000000     C                   MOVE      'N'           @DV
030900000000    0C                   IF        *IN35 = *ON
031000020320    ***
031100020320     C                   SELECT
031200020320    1C                   WHEN      I_TRST = 'ALL'
031300020320     C                   MOVEL(P)  'ALL'         I_SUB#
031400020320     C                   MOVEL(P)  'ALL'         I_ACCT
031500020320    1C                   WHEN      I_SUB# = 'ALL'
031600020320     C                   MOVEL(P)  'ALL'         I_ACCT
031700020320    1C                   ENDSL
031800020320    ***
031900000000     C                   MOVE      I_TRST        @T3
032000000000     C                   EXSR      $CHK_TRST
032100000000    1C                   IF        @@VT = 'N'
032200000000     C                   MOVEL(P)  M@(E#)        @@SM1
032300000000     C                   LEAVESR
032400000000    1C                   ELSE
032500000000     C                   MOVEL(P)  DES@TRS       O_TNAME
032600000000    1C                   ENDIF
032700000000    ***
032800000000     C                   MOVE      I_SUB#        @S3
032900000000     C                   EXSR      $CHK_SUBD
033000000000    1C                   IF        @@VS = 'N'
033100000000     C                   MOVEL(P)  M@(E#)        @@SM1
033200000000     C                   LEAVESR
033300000000    1C                   ELSE
033400000000     C                   MOVEL(P)  DES@SUB       O_SNAME
033500000000    1C                   ENDIF
033600000000    ***
033700000000     C                   MOVE      I_ACCT        @A4
033800000000     C                   EXSR      $CHK_ACCT
033900000000    1C                   IF        @@VA = 'N'
034000000000     C                   MOVEL(P)  M@(E#)        @@SM1
034100000000     C                   LEAVESR
034200000000    1C                   ELSE
034300000000     C                   MOVEL(P)  DES@ACC       O_ANAME
034400000000    1C                   ENDIF
034500000000    ***
034600000000    0C                   ELSE
034700020320    ***
034800000000     C                   MOVE      I_SS#         @M9
034900000000     C                   EXSR      $CHK_MBRD
035000000000    1C                   IF        @@VM = 'N'
035100000000     C                   MOVEL(P)  M@(E#)        @@SM1
035200000000     C                   LEAVESR
035300000000    1C                   ELSE
035400000000     C                   MOVEL(P)  DES@MBR       O_MNAME
035500000000    1C                   ENDIF
035600000000    ***
035700000000    0C                   ENDIF
035800000000    ***
035900000000     C                   Z-ADD     EFRUSA        #USO
036000000000     C                   EXSR      $USAISO
036100020312     C                   IF        @VUSA = 'N'
036200020308     C                   MOVEL(P)  M@(14)        @@SM1
036300000000     C                   LEAVESR
036400000000     C                   ENDIF
036500020312     C                   Z-ADD     #USO          EFRISO
036600000000     C*
036700000000     C                   Z-ADD     ETOUSA        #USO
036800000000     C                   EXSR      $USAISO
036900000000     C                   IF        @VUSA = 'N'
037000020308     C                   MOVEL(P)  M@(15)        @@SM1
037100000000     C                   LEAVESR
037200000000     C                   ENDIF
037300020312     C                   Z-ADD     #USO          ETOISO
037400000000     C*
037500000000     C                   IF        EFRUSA > ETOUSA AND ETOUSA <> 0
037600020308     C                   MOVEL(P)  M@(16)        @@SM1
037700000000     C                   LEAVESR
037800000000     C                   ENDIF
037900000000    ***
038000111117     C                   IF        DCSELC1 <> *BLANKS
038100000000     C                   MOVEL     'W'           KEY@TYPE
038200111117     C                   MOVE      DCSELC1       KEY@CODE
038300111117     C     KEY#CODES     CHAIN     CODESR
038400000000     C                   IF        NOT %FOUND(CODES)
038500000000     C                   MOVEL(P)  M@(11)        @@SM1
038600000000     C                   LEAVESR
038700000000     C                   ENDIF
038800000000     C                   ENDIF
038900000000    ***
039000111117     C                   IF        DCSELC2 <> *BLANKS
039100111117     C                   MOVEL     'W'           KEY@TYPE
039200111117     C                   MOVE      DCSELC2       KEY@CODE
039300111117     C     KEY#CODES     CHAIN     CODESR
039400111117     C                   IF        NOT %FOUND(CODES)
039500111117     C                   MOVEL(P)  M@(11)        @@SM1
039600111117     C                   LEAVESR
039700111117     C                   ENDIF
039800111117     C                   ENDIF
039900111117    ***
040000111117     C                   IF        DCSELC3 <> *BLANKS
040100111117     C                   MOVEL     'W'           KEY@TYPE
040200111117     C                   MOVE      DCSELC3       KEY@CODE
040300111117     C     KEY#CODES     CHAIN     CODESR
040400111117     C                   IF        NOT %FOUND(CODES)
040500111117     C                   MOVEL(P)  M@(11)        @@SM1
040600111117     C                   LEAVESR
040700111117     C                   ENDIF
040800111117     C                   ENDIF
040900111117    ***
041000111117     C                   IF        DCSELC4 <> *BLANKS
041100111117     C                   MOVEL     'W'           KEY@TYPE
041200111117     C                   MOVE      DCSELC4       KEY@CODE
041300111117     C     KEY#CODES     CHAIN     CODESR
041400111117     C                   IF        NOT %FOUND(CODES)
041500111117     C                   MOVEL(P)  M@(11)        @@SM1
041600111117     C                   LEAVESR
041700111117     C                   ENDIF
041800111117     C                   ENDIF
041900111117    ***
042000111117     C                   IF        DCSELC5 <> *BLANKS
042100111117     C                   MOVEL     'W'           KEY@TYPE
042200111117     C                   MOVE      DCSELC5       KEY@CODE
042300111117     C     KEY#CODES     CHAIN     CODESR
042400111117     C                   IF        NOT %FOUND(CODES)
042500111117     C                   MOVEL(P)  M@(11)        @@SM1
042600111117     C                   LEAVESR
042700111117     C                   ENDIF
042800111117     C                   ENDIF
042900111117    ***
043000111117     C                   IF        DCSELC6 <> *BLANKS
043100111117     C                   MOVEL     'W'           KEY@TYPE
043200111117     C                   MOVE      DCSELC6       KEY@CODE
043300111117     C     KEY#CODES     CHAIN     CODESR
043400111117     C                   IF        NOT %FOUND(CODES)
043500111117     C                   MOVEL(P)  M@(11)        @@SM1
043600111117     C                   LEAVESR
043700111117     C                   ENDIF
043800111117     C                   ENDIF
043900111117    ***
044000000000     C                   IF        USRSELC <> *BLANKS
044100111117     C     USRSELC       CHAIN     SECR
044200000000     C                   IF        NOT %FOUND(GBSECURE)
044300000000     C                   MOVEL(P)  M@(13)        @@SM1
044400000000     C                   LEAVESR
044500000000     C                   ENDIF
044600000000     C                   ENDIF
044700020308    ***
044800020312     C                   IF        SRTSELC <> '1' AND SRTSELC <> '2'
044900020308     C                   MOVEL(P)  M@(17)        @@SM1
045000020308     C                   LEAVESR
045100020308     C                   ENDIF
045200020312    ***
045300020312     C                   IF        PRTOREML <> 'P' AND PRTOREML <> 'E'
045400111117     C                             AND PRTOREML <> 'C'
045500020312     C                   MOVEL(P)  M@(18)        @@SM1
045600020312     C                   LEAVESR
045700020312     C                   ENDIF
045800000000    ***
045900000000     C                   MOVE      'Y'           @DV
046000000000    ***
046100000000     C                   ENDSR
046200000000   S***S
046300000000     C     $USAISO       BEGSR
046400000000    ***
046500020308     C                   EVAL      @VUSA = 'N'
046600020308    ***
046700020308     C     *USA          TEST(DE)                #USO
046800020308     C                   IF        %ERROR
046900020308     C                   LEAVESR
047000020308     C                   ENDIF
047100020308    ***
047200020308     C                   MOVE      #USO          #USA
047300020308     C                   MOVE      #USA          #ISO
047400020308     C                   MOVE      #ISO          #USO
047500020308     C                   EVAL      @VUSA = 'Y'
047600020308    ***
047700000000     C                   ENDSR
047800000000   S***S
047900000000     C     $CHK_MBRD     BEGSR
048000000000    ***
048100000000     C                   MOVE      'N'           @@VM
048200000000     C                   MOVE      *BLANKS       DES@MBR
048300020320    ***
048400020320    1C                   IF        @M9 = 'ALL'
048500020320     C                   MOVE      'Y'           @@VM
048600020320     C                   EVAL      DES@MBR = 'ALL MEMBERS'
048700020320     C                   LEAVESR
048800020320    1C                   ENDIF
048900000000    ***
049000000000     C                   TESTN                   @M9                  99
049100000000    1C                   IF        *IN99 = *OFF
049200000000     C                   Z-ADD     5             E#
049300000000     C                   LEAVESR
049400000000    1C                   ENDIF
049500000000    ***
049600000000     C                   MOVE      @M9           KEY@MBR
049700000000    ***
049800000000    1C                   IF        KEY@MBR = 0
049900000000     C                   Z-ADD     5             E#
050000000000     C                   LEAVESR
050100000000    1C                   ENDIF
050200000000    ***
050300111117     C     KEY@MBR       CHAIN     MEMBR
050400000000    1C                   IF        NOT %FOUND(MEMBER)
050500000000     C                   Z-ADD     6             E#                             NOT ON MASTER FILE
050600000000    1C                   ELSE
050700000000     C*
050800000000    2C                   SELECT
050900000000    2C                   WHEN      MMI = *BLANKS
051000000000     C                   EVAL      DES@MBR = %TRIM(MFNAME) + ' ' +
051100000000     C                             %TRIMR(MLNAME)
051200000000    2C                   WHEN      MMI <> *BLANKS
051300000000     C                   EVAL      DES@MBR = %TRIM(MFNAME) + ' ' + MMI + ' ' +
051400000000     C                             %TRIMR(MLNAME)
051500000000    2C                   ENDSL
051600000000     C*
051700000000     C                   MOVE      'Y'           @@VM
051800000000    1C                   ENDIF
051900000000    ***
052000000000     C                   ENDSR
052100000000   S***S
052200000000     C     $CHK_TRST     BEGSR
052300000000    ***
052400000000     C                   MOVE      'N'           @@VT
052500000000     C                   MOVE      *BLANKS       DES@TRS
052600000000    ***
052700020320    1C                   IF        @T3 = 'ALL'
052800020320     C                   MOVE      'Y'           @@VT
052900020320     C                   EVAL      DES@TRS = 'ALL TRUSTS'
053000020320     C                   LEAVESR
053100020320    1C                   ENDIF
053200020320    ***
053300000000     C                   TESTN                   @T3                  99
053400000000    1C                   IF        *IN99 = *OFF
053500000000     C                   Z-ADD     1             E#                             TRUST IS ZERO
053600000000     C                   LEAVESR
053700000000    1C                   ENDIF
053800000000    ***
053900000000     C                   MOVE      @T3           KEY@TRS
054000000000    ***
054100000000    1C                   IF        KEY@TRS = 0
054200000000     C                   Z-ADD     1             E#                             TRUST IS ZERO
054300000000     C                   LEAVESR
054400000000    1C                   ENDIF
054500000000    ***
054600111117     C     KEY@TRS       CHAIN     TRSMSR
054700000000    1C                   IF        NOT %FOUND(TRSMST)
054800000000     C                   Z-ADD     2             E#                             NOT ON MASTER FILE
054900000000    1C                   ELSE
055000000000     C                   MOVEL(P)  TNAME         DES@TRS
055100000000     C                   MOVE      'Y'           @@VT
055200000000    1C                   ENDIF
055300000000    ***
055400000000     C                   ENDSR
055500000000   S***S
055600000000     C     $CHK_SUBD     BEGSR
055700000000    ***
055800000000     C                   MOVE      'N'           @@VS
055900000000     C                   MOVE      *BLANKS       DES@SUB
056000000000    ***
056100020320    1C                   IF        @S3 = 'ALL'
056200020320     C                   MOVE      'Y'           @@VS
056300020320     C                   EVAL      DES@SUB = 'ALL SUBDIVISIONS'
056400020320     C                   LEAVESR
056500020320    1C                   ENDIF
056600020320    ***
056700000000     C                   TESTN                   @S3                  99
056800000000    1C                   IF        *IN99 = *OFF
056900000000     C                   Z-ADD     3             E#                             TRUST IS ZERO
057000000000     C                   LEAVESR
057100000000    1C                   ENDIF
057200000000    ***
057300000000     C                   MOVE      @S3           KEY@SUB
057400000000    ***
057500000000    1C                   IF        KEY@SUB = 0
057600000000     C                   Z-ADD     3             E#                             SUBD IS ZERO
057700000000     C                   LEAVESR
057800000000    1C                   ENDIF
057900000000    ***
058000000000     C                   MOVE      @T3           KEY@TRS
058100111117     C     KEY#SUB       CHAIN     SUBMSR
058200000000    1C                   IF        NOT %FOUND(SUBMST)
058300000000     C                   Z-ADD     4             E#                             NOT ON MASTER FILE
058400000000    1C                   ELSE
058500000000     C                   MOVEL(P)  SUBNAM        DES@SUB
058600000000     C                   MOVE      'Y'           @@VS
058700000000    1C                   ENDIF
058800000000    ***
058900000000     C                   ENDSR
059000000000   S***S
059100000000     C     $CHK_ACCT     BEGSR
059200000000    ***
059300000000     C                   MOVE      'N'           @@VA
059400000000     C                   MOVE      *BLANKS       DES@ACC
059500000000    ***
059600020320    1C                   IF        @A4 = 'ALL '
059700020320     C                   MOVE      'Y'           @@VA
059800020320     C                   EVAL      DES@ACC = 'ALL ACCOUNTS'
059900020320     C                   LEAVESR
060000020320    1C                   ENDIF
060100020320    ***
060200000000     C                   TESTN                   @A4                  99
060300000000    1C                   IF        *IN99 = *OFF
060400000000     C                   Z-ADD     7             E#                             ACC NOT VALID #
060500000000     C                   LEAVESR
060600000000    1C                   ENDIF
060700000000    ***
060800000000     C                   MOVE      @A4           KEY@ACC
060900000000    ***
061000000000    1C                   IF        KEY@ACC = 0
061100000000     C                   Z-ADD     7             E#                             ACC NOT VALID #
061200000000     C                   LEAVESR
061300000000    1C                   ENDIF
061400000000    ***
061500000000     C                   MOVE      @T3           KEY@TRS
061600000000     C                   MOVE      @S3           KEY@SUB
061700111117     C     KEY#ACC       CHAIN     ACCMSR
061800000000    1C                   IF        NOT %FOUND(ACCMST)
061900000000     C                   Z-ADD     8             E#                             NOT ON MASTER FILE
062000000000    1C                   ELSE
062100000000     C                   MOVEL(P)  ACNAM1        DES@ACC
062200000000     C                   MOVE      'Y'           @@VA
062300000000    1C                   ENDIF
062400000000    ***
062500000000     C                   ENDSR
062600000000   S***S
062700000000    *** TRUST SELECTION WINDOW
062800000000     C     $F2PROC       BEGSR
062900000000    ***
063000000000     C                   MOVE      *BLANKS       @T3
063100000000     C                   CALL      'FM006CL'
063200000000     C                   PARM                    @T3
063300000000    ***
063400000000    1C                   IF        @T3 = '*LR'
063500000000     C                   MOVEL(P)  M@(9)         @@SM1
063600000000     C                   LEAVESR
063700000000    1C                   ENDIF
063800000000    ***
063900000000     C                   MOVE      @T3           I_TRST
064000000000     C                   EXSR      $CHK_TRST
064100000000    1C                   IF        @@VT = 'N'
064200000000     C                   MOVEL(P)  M@(E#)        @@SM1
064300000000    1C                   ENDIF
064400000000    ***
064500000000     C                   ENDSR
064600000000   S***S
064700000000    *** SUBDIVISION SELECTION WINDOW
064800000000    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
064900000000     C     $F4PROC       BEGSR
065000000000    ***
065100020320     C                   IF        @T3 = 'ALL'
065200020320     C                   LEAVESR
065300020320    1C                   ENDIF
065400020320    ***
065500000000     C                   EXSR      $CHK_TRST
065600000000     C*
065700000000    1C                   IF        @@VT = 'N'
065800000000     C                   MOVEL(P)  M@(E#)        @@SM1
065900000000     C                   LEAVESR
066000000000    1C                   ENDIF
066100000000    ***
066200000000     C                   MOVEL(P)  @T3           @TS6
066300000000    ***
066400000000     C                   CALL      'FM007CL'
066500000000     C                   PARM                    @TS6
066600000000    ***
066700000000    1C                   IF        %SUBST(@TS6:4:3) = '*LR'
066800000000     C                   MOVEL(P)  M@(10)        @@SM1
066900000000     C                   LEAVESR
067000000000    1C                   ENDIF
067100000000    ***
067200000000     C                   EVAL      @S3 = %SUBST(@TS6:4:3)
067300000000     C                   MOVE      @S3           I_SUB#
067400000000     C*
067500000000     C                   EXSR      $CHK_SUBD
067600000000    1C                   IF        @@VS = 'N'
067700000000     C                   MOVEL(P)  M@(E#)        @@SM1
067800000000    1C                   ENDIF
067900000000    ***
068000000000     C                   ENDSR
068100000000   S***S
068200000000    *** EXISTING ACCT NUMBER INQUIRY
068300000000    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
068400000000     C     $F6PROC       BEGSR
068500000000    ***
068600020320     C                   IF        @T3 = 'ALL' OR @S3 = 'ALL'
068700020320     C                   LEAVESR
068800020320    1C                   ENDIF
068900020320    ***
069000000000     C                   EXSR      $CHK_TRST
069100000000     C*
069200000000    1C                   IF        @@VT = 'N'
069300000000     C                   MOVEL(P)  M@(E#)        @@SM1
069400000000     C                   LEAVESR
069500000000    1C                   ENDIF
069600000000    ***
069700000000     C                   EXSR      $CHK_SUBD
069800000000     C*
069900000000    1C                   IF        @@VS = 'N'
070000000000     C                   MOVEL(P)  M@(E#)        @@SM1
070100000000     C                   LEAVESR
070200000000    1C                   ENDIF
070300000000    ***
070400000000     C                   EVAL      @TSAP = @T3 + @S3 + '    '
070500000000     C                   CALL      'FM008CL'
070600000000     C                   PARM                    @TSAP
070700000000    ***
070800000000    1C                   IF        %SUBST(@TSAP:7:3) = '*LR'
070900000000     C                   MOVEL(P)  M@(12)        @@SM1
071000000000     C                   LEAVESR
071100000000    1C                   ENDIF
071200000000    ***
071300000000     C                   EVAL      @A4 = %SUBST(@TSAP:7:4)
071400000000     C                   MOVEL(P)  @A4           I_ACCT
071500000000     C                   EXSR      $CHK_ACCT
071600000000    1C                   IF        @@VA = 'N'
071700000000     C                   MOVEL(P)  M@(E#)        @@SM1
071800000000    1C                   ENDIF
071900000000    ***
072000000000     C                   ENDSR
072100000000   S***S
072200000000     C     $STEP2        BEGSR
072300000000    ***
072400111117     C                   IF        PRTOREML = 'C'
072500111117     C                   OPEN      RP550W1
072600111117     C                   ELSE
072700020320     C                   OPEN      RP550P1
072800111117     C                   ENDIF
072900000000     C                   MOVE      *BLANKS       KEY@KEY
073000020322     C                   CLEAR                   R_SELECTA
073100020322     C                   CLEAR                   R_SELECTB
073200020308     C                   MOVE      *BLANKS       @CTXT
073300020312     C                   MOVE      'Y'           @EMLCHK
073400000000    ***
073500111117     C                   IF        PRTOREML = 'C'
073600111117     C                   EVAL      @3K = '"DIARY NOTES REPORT"'
073700111117     C                   EXCEPT    OUTF
073800111117     C                   ELSE
073900020320     C                   WRITE     TTLF
074000111117     C                   ENDIF
074100020320     C                   EVAL      *IN80 = *OFF
074200020320    ***
074300020322     C                   EXSR      $DETSLCXT
074400020322    ***
074500111117     C                   MOVE      *BLANKS       @3K            3000
074600111117     C                   IF        PRTOREML = 'C'
074700111117     C                   EVAL      @3K = ','
074800111117     C                   EXCEPT    OUTF
074900111117     C                   EVAL      @3K = '"' + %TRIM(R_SELECTA) + '"'
075000111117     C                   EXCEPT    OUTF
075100111117     C                   EVAL      @3K = '"' + %TRIM(R_SELECTB) + '"'
075200111117     C                   EXCEPT    OUTF
075300111117     C                   EVAL      @3K = ','
075400111117     C                   EXCEPT    OUTF
075500111117     C                   EVAL      @3K = '"MEMBER#","MEMBER NAME","TRUST#","T' +
075600111117     C                             'RUST NAME","SUB#","SUB NAME","ACCT#","ACC' +
075700111117     C                             'T NAME","CODE","CODE DESC","SUBJECT","ADD' +
075800111117     C                             ' DATE","ADD TIME","ADD USER","NOTES"'
075900111117     C*****************************' DATE","ADD TIME","ADD USER","DETAIL 01",' +
076000111117     C*                            '"DETAIL 02","DETAIL 03","DETAIL 04",' +
076100111117     C* PER SHELLY 11/17/2011      '"DETAIL 05","DETAIL 06","DETAIL 07",' +
076200111117     C*                            '"DETAIL 08","DETAIL 09","DETAIL 10",' +
076300111117     C*                            '"DETAIL 11","DETAIL 12","DETAIL 13",' +
076400111117     C*                            '"DETAIL 14","DETAIL 15","DETAIL 16",' +
076500111117     C*                            '"DETAIL 17","DETAIL 18","DETAIL 19",' +
076600111117     C*                            '"DETAIL 20","DETAIL 21","DETAIL 22",' +
076700111117     C*****************************'"DETAIL 23","DETAIL 24","DETAIL 25"'
076800111117     C                   EXCEPT    OUTF
076900111117     C                   ELSE
077000020320     C                   WRITE     TTLF2
077100111117     C                   ENDIF
077200000000    ***
077300020320     C                   EXSR      $KEYSELCTR
077400020320    ***
077500020320     C                   ENDSR
077600020321   S***S
077700020322     ****DETERMINE SELECTION TEXT FOR PRINTING
077800020322     **
077900020322     C     $DETSLCXT     BEGSR
078000111117    ***
078100111117     C                   MOVE      *BLANKS       @@DCS            12
078200111117     C                   MOVE      *ZEROS        ##DCS             3 0
078300020322    ***
078400111117     C                   EVAL      @@DCS = DCSELC1 + DCSELC2 + DCSELC3 +
078500111117     C                             DCSELC4 + DCSELC5 + DCSELC6
078600111117     C                   EVAL      ##DCS = %LEN(%TRIM(@@DCS))
078700111117      *
078800111117    1C                   SELECT
078900111117      *
079000111117    1C                   WHEN      ##DCS = 0
079100020322     C                   MOVEL     'ALL'         @CTXT
079200111117      *
079300111117    1C                   WHEN      ##DCS = 1 OR ##DCS = 2
079400111117     C                   MOVEL     'W'           KEY@TYPE
079500111117     C                   EVAL      KEY@CODE = %TRIM(@@DCS)
079600111117     C     KEY#CODES     CHAIN     CODESR
079700020322    2C                   IF        %FOUND(CODES)
079800020322     C                   MOVEL     SDESCR        @CTXT
079900111117    2C                   ENDIF
080000111117
080100111117    1C                   WHEN      ##DCS > 2
080200111117     C                   EVAL      @CTXT = 'CODES:'
080300111117     C                   IF        DCSELC1 <> *BLANKS
080400111117     C                   EVAL      @CTXT = %TRIM(@CTXT) + DCSELC1 + ','
080500111117     C                   ENDIF
080600111117     C                   IF        DCSELC2 <> *BLANKS
080700111117     C                   EVAL      @CTXT = %TRIM(@CTXT) + DCSELC2 + ','
080800111117     C                   ENDIF
080900111117     C                   IF        DCSELC3 <> *BLANKS
081000111117     C                   EVAL      @CTXT = %TRIM(@CTXT) + DCSELC3 + ','
081100111117     C                   ENDIF
081200111117     C                   IF        DCSELC4 <> *BLANKS
081300111117     C                   EVAL      @CTXT = %TRIM(@CTXT) + DCSELC4 + ','
081400111117     C                   ENDIF
081500111117     C                   IF        DCSELC5 <> *BLANKS
081600111117     C                   EVAL      @CTXT = %TRIM(@CTXT) + DCSELC5 + ','
081700111117     C                   ENDIF
081800111117     C                   IF        DCSELC6 <> *BLANKS
081900111117     C                   EVAL      @CTXT = %TRIM(@CTXT) + DCSELC6 + ','
082000111117     C                   ENDIF
082100111117      *
082200111117    1C                   OTHER
082300020322     C                   MOVEL     'UNKNOWN'     @CTXT
082400111117      *
082500111117    1C                   ENDSL
082600111117      *
082700020322    ***
082800020322    1C                   IF        USRSELC = *BLANKS
082900020322     C                   MOVEL     'ALL'         @UTXT
083000020322     C                   ELSE
083100111117     C     USRSELC       CHAIN     SECR
083200020322     C                   IF        NOT %FOUND(GBSECURE)
083300020322     C                   MOVEL     '*UNKNOWN'    @UTXT
083400020322     C                   ELSE
083500020322     C                   MOVEL(P)  SCNAME        @UTXT
083600020322    1C                   ENDIF
083700020322    1C                   ENDIF
083800020322    ***
083900020322    1C                   IF        SRTSELC = '1'
084000020322     C                   EVAL      @11 = 'CODE & DATE'
084100020322    1C                   ELSE
084200020322     C                   EVAL      @11 = 'DATE & TIME'
084300020322    1C                   ENDIF
084400020322     C*
084500020322     C                   SELECT
084600020322     C                   WHEN      *IN35 = *ON AND @T3 = 'ALL'
084700020322     C                   EVAL      R_SELECTA = 'TRUST: ALL; SUBDIVISION: ALL;' +
084800020322     C                             ' ACCOUNT: ALL'
084900020322     C                   WHEN      *IN35 = *ON AND @T3 <> 'ALL' AND
085000020322     C                             @S3 = 'ALL'
085100020322     C                   EVAL      R_SELECTA = 'TRUST: ' + @T3 + ' '           +
085200020322     C                             %TRIM(O_TNAME) + '; SUBDIVISION: ALL'       +
085300020322     C                             '; ACCOUNT: ALL'
085400020322     C                   WHEN      *IN35 = *ON AND @T3 <> 'ALL' AND
085500020322     C                             @S3 <> 'ALL' AND @A4 = 'ALL '
085600020322     C                   EVAL      R_SELECTA = 'TRUST: ' + @T3 + ' '           +
085700020322     C                             %TRIM(O_TNAME) + '; SUBDIVISION: ' + @S3    +
085800020322     C                             ' ' + %TRIM(O_SNAME) + '; ACCOUNT: ALL'
085900020322     C                   WHEN      *IN35 = *ON AND @T3 <> 'ALL' AND
086000020322     C                             @S3 <> 'ALL' AND @A4 <> 'ALL '
086100020322     C                   EVAL      R_SELECTA = 'TRUST: ' + @T3 + ' '           +
086200020322     C                             %TRIM(O_TNAME) + '; SUBDIVISION: ' + @S3    +
086300020322     C                             ' ' + %TRIM(O_SNAME) + '; ACCOUNT: ' + @A4  +
086400020322     C                             ' ' + %TRIM(O_ANAME)
086500020322     C                   WHEN      *IN35 = *OFF AND @M9 = 'ALL'
086600020322     C                   EVAL      R_SELECTA = 'MEMBER: ALL'
086700020322     C                   WHEN      *IN35 = *OFF AND @M9 <> 'ALL'
086800020322     C                   EVAL      R_SELECTA = 'MEMBER: ' + @M9 + ' '          +
086900020322     C                             %TRIM(O_MNAME)
087000020322     C*
087100020322     C                   ENDSL
087200020322     C*
087300020322     C                   EVAL      R_SELECTB = 'FROM DATE-'                    +
087400020322     C                             %TRIM(%EDITC(EFRUSA:'Y')) + '; TO DATE-'    +
087500020322     C                             %TRIM(%EDITC(ETOUSA:'Y')) + '; DIARY CODE-' +
087600020322     C                             %TRIM(@CTXT) + '; USER ID-' + %TRIM(@UTXT)  +
087700020322     C                             '; SORT BY-' + @11
087800020322    ***
087900020322     C                   ENDSR
088000020322   S***S
088100020322     C     $F11PROC      BEGSR
088200020322    ***
088300020321     C                   CALL      'TR124R'
088400020321     C                   PARM                    @USER
088500020321    ***
088600020321     C                   IF        USRSELC <> '*LR'
088700020321     C                   MOVEL(P)  @USER         USRSELC
088800020321     C                   ENDIF
088900020321    ***
089000020321     C                   ENDSR
089100020320   S***S
089200020320     C     $KEYSELCTR    BEGSR
089300020320    ***
089400020320     C                   MOVE      *BLANKS       KEY@KEY
089500020320     C                   SELECT
089600020320     C* ENTIRE ACCMST
089700020320     C                   WHEN      *IN35 = *ON AND @T3 = 'ALL'
089800020320     C                   EVAL      @STEP = 'STEP3'
089900020320     C* ACCMST W/=TRUST
090000020320     C                   WHEN      *IN35 = *ON AND @T3 <> 'ALL' AND
090100020320     C                             @S3 = 'ALL'
090200020320     C                   EVAL      @STEP = 'STEP4'
090300020320     C* ACCMST W/= T/S
090400020320     C                   WHEN      *IN35 = *ON AND @T3 <> 'ALL' AND
090500020320     C                             @S3 <> 'ALL' AND @A4 = 'ALL '
090600020320     C                   EVAL      @STEP = 'STEP5'
090700020320     C* SELECT TSA
090800020320     C                   WHEN      *IN35 = *ON AND @T3 <> 'ALL' AND
090900020320     C                             @S3 <> 'ALL' AND @A4 <> 'ALL '
091000020320     C                   EVAL      @STEP = 'STEP6'
091100020320     C* ENTIRE MEMBER
091200020320     C                   WHEN      *IN35 = *OFF AND @M9 = 'ALL'
091300020320     C                   EVAL      @STEP = 'STEP7'
091400020320     C* SELECT MEMBER
091500020320     C                   WHEN      *IN35 = *OFF AND @M9 <> 'ALL'
091600020320     C                   EVAL      @STEP = 'STEP8'
091700020320     C*
091800020320     C                   ENDSL
091900020320    ***
092000020320     C                   ENDSR
092100020320   S***S
092200020320     C     $STEP3        BEGSR
092300020320    ***
092400020320     C                   EVAL      KEY@TRS = 001
092500020320     C                   EVAL      KEY@SUB = 001
092600020320     C                   EVAL      KEY@ACC = 0001
092700020320     C     KEY#ACC       SETLL     ACCMSR
092800020320     C                   DOU       %EOF(ACCMST)
092900020320     C                   READ      ACCMSR
093000020320    1C                   IF        NOT %EOF(ACCMST)
093100020320    ***
093200020320     C                   EVAL      KEY@KEY = %EDITC(ACTRST:'X') +
093300020320     C                             %EDITC(ACSUB#:'X') + %EDITC(ACACCT:'X')
093400020320    *C*
093500020320     C                   CLEAR                   SECF
093600020320     C                   Eval      *IN36 = *ON
093700020320    *C*
093800020320     C                   MOVE      ACTRST        R_TRS
093900020320     C                   MOVE      ACTRST        KEY@TRS
094000111117     C     KEY@TRS       CHAIN     TRSMSR
094100020320    1C                   IF        NOT %FOUND(TRSMST)
094200020320     C                   MOVE      *BLANKS       TNAME
094300020320     C                   ENDIF
094400020320     C                   MOVEL(P)  TNAME         R_TNAME
094500020320    *C*
094600020320     C                   MOVE      ACSUB#        KEY@SUB
094700020320     C                   MOVE      ACSUB#        R_SUB
094800111117     C     KEY#SUB       CHAIN     SUBMSR
094900020320    1C                   IF        NOT %FOUND(SUBMST)
095000020320     C                   MOVE      *BLANKS       SUBNAM
095100020320     C                   ENDIF
095200020320     C                   MOVEL(P)  SUBNAM        R_SNAME
095300020320    *C*
095400020320     C                   MOVE      ACACCT        R_ACC
095500020320     C                   MOVEL(P)  ACNAM1        R_ANAME
095600020320    *C*
095700020320     C                   EXSR      $COMNPRT
095800020320    ***
095900020320     C                   ENDIF
096000020320     C                   ENDDO
096100020320    ***
096200020320     C                   EVAL      @STEP = 'LEAVE'
096300020320    ***
096400020320     C                   ENDSR
096500020320   S***S
096600020320     C     $COMNPRT      BEGSR
096700020320    ***
096800020320    1C                   IF        SRTSELC = '1'
096900020320     C     KEY@KEY       SETLL     FMT1
097000020320    1C                   ELSE
097100020320     C     KEY@KEY       SETLL     FMT2
097200020320    1C                   ENDIF
097300020320    ***
097400020320     C                   EVAL      @EOF = 'N'
097500020320     C                   EVAL      @SEC = 'N'
097600020320    ***
097700111117    1C                   DOU       @EOF = 'Y'
097800020320     C                   EXSR      $PRINT
097900111117    1C                   ENDDO
098000020308    ***
098100000000     C                   ENDSR
098200000000   S***S
098300020312     C     $PRINT        BEGSR
098400020312    ***
098500020312    1C                   IF        SRTSELC = '1'
098600020312     C     KEY@KEY       READE     FMT1
098700020312    2C                   IF        %EOF(DIARYHD4)
098800020320     C                   EVAL      @EOF = 'Y'
098900020312     C                   LEAVESR
099000020312    2C                   ENDIF
099100020312    1C                   ELSE
099200020312     C     KEY@KEY       READE     FMT2
099300020312    2C                   IF        %EOF(DIARYHD3)
099400020320     C                   EVAL      @EOF = 'Y'
099500020312     C                   LEAVESR
099600020312    2C                   ENDIF
099700020312    1C                   ENDIF
099800020320    ***
099900020320    1C                   IF        NHADDT >= EFRISO AND NHADDT <=ETOISO
100000111117    2C                   IF        ##DCS = 0 OR (##DCS > 0 AND
100100111117     C                             (DCSELC1 = %SUBST(NHCODE:2:2) OR
100200111117     C                              DCSELC2 = %SUBST(NHCODE:2:2) OR
100300111117     C                              DCSELC3 = %SUBST(NHCODE:2:2) OR
100400111117     C                              DCSELC4 = %SUBST(NHCODE:2:2) OR
100500111117     C                              DCSELC5 = %SUBST(NHCODE:2:2) OR
100600111117     C                              DCSELC6 = %SUBST(NHCODE:2:2)))
100700020320    3C                   IF        USRSELC = *BLANKS OR (USRSELC <> *BLANKS
100800020320     C                             AND USRSELC = NHADUS)
100900020320    ***
101000111117     C                   IF        PRTOREML = 'C'
101100111117     C                   EXSR      $CSVPREP
101200111117     C                   ELSE
101300111117     C                   EXSR      $PRTPREP
101400111117     C                   ENDIF
101500020312    ***
101600020320    3C                   ENDIF
101700020320    2C                   ENDIF
101800020320    1C                   ENDIF
101900111117    ***
102000111117     C                   ENDSR
102100111117   S***S
102200111117     C     $CSVPREP      BEGSR
102300111117    ***
102400111117     C                   CLEAR                   @3K
102500111117    ***
102600111117     C                   IF        %SUBST(NHKEY:1:1) = ' '
102700111117     C                   MOVE      NHKEY         @M9
102800111117     C                   MOVE      @M9           KEY@MBR
102900111117     C     KEY@MBR       CHAIN     MEMBR
103000111117    2C                   SELECT
103100111117    2C                   WHEN      MMI = *BLANKS
103200111117     C                   EVAL      DES@MBR = %TRIM(MFNAME) + ' ' +
103300111117     C                             %TRIMR(MLNAME)
103400111117    2C                   WHEN      MMI <> *BLANKS
103500111117     C                   EVAL      DES@MBR = %TRIM(MFNAME) + ' ' + MMI + ' ' +
103600111117     C                             %TRIMR(MLNAME)
103700111117    2C                   ENDSL
103800111117     C                   EVAL      @3K = '"' + @M9 + '","' +
103900111117     C                             %TRIM(DES@MBR) + '",,,,,,,'
104000111117
104100111117     C                   ELSE
104200111117     C                   EVAL      C@T3 = %SUBST(NHKEY:1:3)
104300111117     C                   MOVE      C@T3          KEY@TRS
104400111117     C     KEY@TRS       CHAIN     TRSMSR
104500111117     C                   EVAL      C@S3 = %SUBST(NHKEY:4:3)
104600111117     C                   MOVE      C@S3          KEY@SUB
104700111117     C     KEY#SUB       CHAIN     SUBMSR
104800111117     C                   EVAL      C@A4 = %SUBST(NHKEY:7:4)
104900111117     C                   MOVE      C@A4          KEY@ACC
105000111117     C     KEY#ACC       CHAIN     ACCMSR
105100111117     C                   EVAL      @3K = ',,"' + C@T3 + '","' +
105200111117     C                             %TRIM(TNAME) + '","' + C@S3 + '","' +
105300111117     C                             %TRIM(SUBNAM) + '","' + C@A4 + '","' +
105400111117     C                             %TRIM(ACNAM1) + '",'
105500111117     C                   ENDIF
105600111117    ***
105700111117     C                   EVAL      KEY@TYPE = 'W'
105800111117     C                   EVAL      KEY@CODE = %SUBST(NHCODE:2:2)
105900111117     C     KEY#CODES     CHAIN     CODESR
106000111117     C     NHADDT        MULT      10000.0001    #XSX              8 0
106100111117     C                   EVAL      @3K = %TRIM(@3K) + '"' + %TRIM(KEY@CODE) +
106200111117     C                             '","' + %TRIM(LDESCR)
106300111117     C                             + '","' + %TRIM(NHSUBJ) + '","' +
106400111117     C                             %EDITC(#XSX:'Y') + '","' +
106500111117     C                             %EDITW(NHADTI:'0  :  :  ') + '","' +
106600111117     C                             %TRIM(NHADUS) + '",'
106700111117    ***
106800111117     C                   Z-ADD     NHADDT        KEY@ADDT
106900111117     C                   Z-ADD     NHADTI        KEY@ADTI
107000111117     C                   MOVE      *BLANKS       @CELL
107100111117    ***
107200111117     C     KEY@DTL1      SETLL     RDIARYDT
107300111117    4C                   DOU       %EOF(DIARYDT1)
107400111117     C     KEY@DTL1      READE     RDIARYDT
107500111117    5C                   IF        NOT %EOF(DIARYDT1)
107600111117    * *
107700111117     C                   EVAL      @CELL = %TRIM(@CELL) +  %TRIM(NDTEXT)
107800111117    * *
107900111117     C*******************EVAL      @3K = %TRIM(@3K) + '"' + %TRIM(NDTEXT)
108000111117     C********************         + '",'
108100111117    * *
108200111117    5C                   ENDIF
108300111117    4C                   ENDDO
108400111117    ***
108500111117     C                   EVAL      @3K = %TRIM(@3K) + '"' + %TRIM(@CELL)
108600111117     C                             + '",'
108700111117     C                   EXCEPT    OUTF
108800111117    ***
108900111117     C                   ENDSR
109000111117   S***S
109100111117     C     $PRTPREP      BEGSR
109200111117    ***
109300111117    4C                   IF        @SEC = 'N'
109400111117     C                   EVAL      @SEC = 'Y'
109500111117     C                   EXSR      $SECPREP
109600111117    4C                   ENDIF
109700111117    ***
109800111117     C                   EXSR      $HDGPREP
109900111117     C*
110000111117     C                   Z-ADD     NHADDT        KEY@ADDT
110100111117     C                   Z-ADD     NHADTI        KEY@ADTI
110200111117    ***
110300111117     C     KEY@DTL1      SETLL     RDIARYDT
110400111117    4C                   DOU       %EOF(DIARYDT1)
110500111117     C     KEY@DTL1      READE     RDIARYDT
110600111117    5C                   IF        NOT %EOF(DIARYDT1)
110700111117    ***
110800111117     C                   CLEAR                   TXTF
110900111117     C                   EVAL      R_TEXT = %TRIM(NDTEXT)
111000111117     C*
111100111117     C                   IF        *IN80 = *ON
111200111117     C                   EVAL      *IN80 = *OFF
111300111117     C                   WRITE     TTLF
111400111117     C                   WRITE     TTLF2
111500111117     C                   WRITE     SECF
111600111117     C                   ENDIF
111700111117     C*
111800111117     C                   WRITE     TXTF
111900111117    ***
112000111117    5C                   ENDIF
112100111117    4C                   ENDDO
112200111117     C                   WRITE     BLKF
112300020320    ***
112400020320     C                   ENDSR
112500020320   S***S
112600020320     C     $HDGPREP      BEGSR
112700020320    ***
112800020320     C                   CLEAR                   HDGF
112900020320    ***
113000020320     C                   EVAL      R_CODE = %SUBST(NHCODE:2:2)
113100020320     C*
113200020320     C                   MOVEL     'W'           KEY@TYPE
113300020320     C                   MOVEL(P)  R_CODE        KEY@CODE
113400111117     C     KEY#CODES     CHAIN     CODESR
113500020320    1C                   IF        NOT %FOUND(CODES)
113600020320     C                   EVAL      R_CDES = 'NO XRF FND'
113700020320    1C                   ELSE
113800020320     C                   EVAL      R_CDES = %TRIM(SDESCR)
113900020320    1C                   ENDIF
114000020320     C*
114100020320     C                   EVAL      R_SUBJ = %TRIM(NHSUBJ)
114200020320     C     NHADDT        MULT      10000.0001    R_ADDT
114300020320     C                   Z-ADD     NHADTI        R_ADTI
114400020320     C                   EVAL      R_ADUS = %TRIM(NHADUS)
114500020320     C*
114600020320     C                   IF        *IN80 = *ON
114700020320     C                   EVAL      *IN80 = *OFF
114800020320     C                   WRITE     TTLF
114900020320     C                   WRITE     TTLF2
115000020320     C                   WRITE     SECF
115100020320     C                   ENDIF
115200020320     C*
115300020320     C                   WRITE     HDGF
115400020320    ***
115500020320     C                   ENDSR
115600020320   S***S
115700020320     C     $SECPREP      BEGSR
115800020320    ***
115900020320     C                   IF        *IN80 = *ON
116000020320     C                   EVAL      *IN80 = *OFF
116100020320     C                   WRITE     TTLF
116200020320     C                   WRITE     TTLF2
116300020320     C                   ENDIF
116400020320     C*
116500020320     C                   WRITE     SECF
116600020320    ***
116700020312     C                   ENDSR
116800020312   S***S
116900020320     C     $STEP4        BEGSR
117000020320    ***
117100020320     C                   MOVE      @T3           KEY@TRS
117200020320     C     KEY@TRS       SETLL     ACCMSR
117300020320     C                   DOU       %EOF(ACCMST)
117400020320     C     KEY@TRS       READE     ACCMSR
117500020320    1C                   IF        NOT %EOF(ACCMST)
117600020320    ***
117700020320     C                   EVAL      KEY@KEY = %EDITC(ACTRST:'X') +
117800020320     C                             %EDITC(ACSUB#:'X') + %EDITC(ACACCT:'X')
117900020320    *C*
118000020320     C                   CLEAR                   SECF
118100020320     C                   Eval      *IN36 = *ON
118200020320    *C*
118300020320     C                   MOVE      @T3           R_TRS
118400020320     C                   MOVE      @T3           KEY@TRS
118500020320     C                   MOVEL(P)  O_TNAME       R_TNAME
118600020320    *C*
118700020320     C                   MOVE      ACSUB#        KEY@SUB
118800020320     C                   MOVE      ACSUB#        R_SUB
118900111117     C     KEY#SUB       CHAIN     SUBMSR
119000020320    1C                   IF        NOT %FOUND(SUBMST)
119100020320     C                   MOVE      *BLANKS       SUBNAM
119200020320     C                   ENDIF
119300020320     C                   MOVEL(P)  SUBNAM        R_SNAME
119400020320    *C*
119500020320     C                   MOVE      ACACCT        R_ACC
119600020320     C                   MOVEL(P)  ACNAM1        R_ANAME
119700020320    *C*
119800020320     C                   EXSR      $COMNPRT
119900020320    ***
120000020320     C                   ENDIF
120100020320     C                   ENDDO
120200020320    ***
120300020320     C                   EVAL      @STEP = 'LEAVE'
120400020320    ***
120500020320     C                   ENDSR
120600020320   S***S
120700020320     C     $STEP5        BEGSR
120800020320    ***
120900020320     C                   MOVE      @T3           KEY@TRS
121000020320     C                   MOVE      @S3           KEY@SUB
121100020320     C     KEY#SUB       SETLL     ACCMSR
121200020320     C                   DOU       %EOF(ACCMST)
121300020320     C     KEY#SUB       READE     ACCMSR
121400020320    1C                   IF        NOT %EOF(ACCMST)
121500020320    ***
121600020320     C                   EVAL      KEY@KEY = %EDITC(ACTRST:'X') +
121700020320     C                             %EDITC(ACSUB#:'X') + %EDITC(ACACCT:'X')
121800020320    *C*
121900020320     C                   CLEAR                   SECF
122000020320     C                   Eval      *IN36 = *ON
122100020320    *C*
122200020320     C                   MOVE      @T3           R_TRS
122300020320     C                   MOVEL(P)  O_TNAME       R_TNAME
122400020320    *C*
122500020320     C                   MOVE      @S3           R_SUB
122600020320     C                   MOVEL(P)  O_SNAME       R_SNAME
122700020320    *C*
122800020320     C                   MOVE      ACACCT        R_ACC
122900020320     C                   MOVEL(P)  ACNAM1        R_ANAME
123000020320    *C*
123100020320     C                   EXSR      $COMNPRT
123200020320    ***
123300020320     C                   ENDIF
123400020320     C                   ENDDO
123500020320    ***
123600020320     C                   EVAL      @STEP = 'LEAVE'
123700020320    ***
123800020320     C                   ENDSR
123900020320   S***S
124000020320     C     $STEP6        BEGSR
124100020320    ***
124200020320     C                   EVAL      KEY@KEY = @T3 + @S3 + @A4
124300020320    *C*
124400020320     C                   CLEAR                   SECF
124500020320     C                   Eval      *IN36 = *ON
124600020320    *C*
124700020320     C                   MOVE      @T3           R_TRS
124800020320     C                   MOVEL(P)  O_TNAME       R_TNAME
124900020320    *C*
125000020320     C                   MOVE      @S3           R_SUB
125100020320     C                   MOVEL(P)  O_SNAME       R_SNAME
125200020320    *C*
125300020320     C                   MOVE      @A4           R_ACC
125400020320     C                   MOVEL(P)  O_ANAME       R_ANAME
125500020320    *C*
125600020320     C                   EXSR      $COMNPRT
125700020320    ***
125800020320     C                   EVAL      @STEP = 'LEAVE'
125900020320    ***
126000020320     C                   ENDSR
126100020320   S***S
126200020320     C     $STEP7        BEGSR
126300020320    ***
126400020320     C                   Z-ADD     1             KEY@MBR
126500020320     C     KEY@MBR       SETLL     MEMBR
126600020320     C                   DOU       %EOF(MEMBER)
126700020320     C                   READ      MEMBR
126800020320    1C                   IF        NOT %EOF(MEMBER)
126900020320    ***
127000020320     C                   EVALR     KEY@KEY = %EDITC(MBSSNO:'X')
127100020320     C*
127200020320     C                   CLEAR                   SECF
127300020320     C                   Eval      *IN36 = *OFF
127400020320    *C*
127500020320     C                   MOVE      MBSSNO        R_MBRNO
127600020320    *C*
127700020320    2C                   SELECT
127800020320    2C                   WHEN      MMI = *BLANKS
127900020320     C                   EVAL      DES@MBR = %TRIM(MFNAME) + ' ' +
128000020320     C                             %TRIMR(MLNAME)
128100020320    2C                   WHEN      MMI <> *BLANKS
128200020320     C                   EVAL      DES@MBR = %TRIM(MFNAME) + ' ' + MMI + ' ' +
128300020320     C                             %TRIMR(MLNAME)
128400020320    2C                   ENDSL
128500020320     C                   MOVEL(P)  DES@MBR       R_MNAME
128600020320     C*
128700020320     C                   EXSR      $COMNPRT
128800020320    ***
128900020320     C                   ENDIF
129000020320     C                   ENDDO
129100020320    ***
129200020320     C                   EVAL      @STEP = 'LEAVE'
129300020320    ***
129400020320     C                   ENDSR
129500020320   S***S
129600020320     C     $STEP8        BEGSR
129700020320    ***
129800020320     C                   EVALR     KEY@KEY = @M9
129900020320    ***
130000020320     C                   CLEAR                   SECF
130100020320     C                   Eval      *IN36 = *OFF
130200020320    *C*
130300020320     C                   MOVE      I_SS#         R_MBRNO
130400020320     C                   MOVEL(P)  O_MNAME       R_MNAME
130500020320     C*
130600020320     C
130700020320     C                   EXSR      $COMNPRT
130800020320    ***
130900020320     C                   EVAL      @STEP = 'LEAVE'
131000020320    ***
131100020320     C                   ENDSR
131200020320   S***S
131300020312     C     $EMAIL        BEGSR
131400020312    ***
131500020312     C                   MOVE      *BLANKS       @MSGTXT
131600020312     C                   IF        *IN35 = *OFF
131700020320     C                   EVAL      @MSGTXT = 'ESPOOL FILE(RP550P1) SUBJECT('   +
131800020312     C                             @@APS + 'DIARY NOTE REPORT' + @@APS + ') M' +
131900020312     C                             'SGTXT(' + @@APS + 'DIARY NOTE(S) FOR MEMBE'+
132000020320     C                             'R: ' + I_SS# + @@APS + ')'
132100020312     C                   ELSE
132200020320     C                   EVAL      @MSGTXT = 'ESPOOL FILE(RP550P1) SUBJECT('   +
132300020312     C                             @@APS + 'DIARY NOTE REPORT' + @@APS + ') M' +
132400020312     C                             'SGTXT(' + @@APS + 'DIARY NOTE(S) FOR TSA: '+
132500020320     C                             I_TRST + '-' + I_SUB# + '-' + I_ACCT        +
132600020320     C                             @@APS + ')'
132700020312     C                   ENDIF
132800020312    ***
132900020312     C                   EVAL      @46 = 'SPLNBR(*LAST) TOFILE(DNTES) EXT(' +
133000020312     C                             @@APS + '.TXT' + @@APS + ')'
133100020312     C     @MSGTXT       CAT       @46:1         @@CMD
133200020312    ***
133300020312     C                   MOVE      *ZEROS        #LEN
133400020312     C                   EVAL      #LEN = %LEN(%TRIM(@@CMD))
133500020312     C                   Z-ADD     #LEN          ##RL
133600020312     C                   CALL      'QCMDEXC'
133700020312     C                   PARM                    @@CMD
133800020312     C                   PARM                    ##RL
133900020312    ***
134000020312     C                   ENDSR
134100111117   S***S
134200111117     C     $CSVMAIL      BEGSR
134300111117     C                   MOVE      *BLANKS       @MSGTXT
134400111117     C                   EVAL      @MSGTXT = 'EFILE FILE(RP550W1) LIB(QTEMP) ' +
134500111117     C                             'TOFILE(RP550) EXT(' + @@APS + '.CSV' +
134600111117     C                             @@APS + ')'
134700111117    ***
134800111117     C                   EVAL      @@CMD = %TRIM(@MSGTXT)
134900111117    ***
135000111117     C                   MOVE      *ZEROS        #LEN
135100111117     C                   EVAL      #LEN = %LEN(%TRIM(@@CMD))
135200111117     C                   Z-ADD     #LEN          ##RL
135300111117     C                   CALL      'QCMDEXC'
135400111117     C                   PARM                    @@CMD
135500111117     C                   PARM                    ##RL
135600111117    ***
135700111117     C                   ENDSR
135800111117   S***S
135900000000   X***X
136000111117     ORP550W1   EADD         OUTF
136100111117     O                       @3K            B  3000
136200111117   X***X
136300000000** M@ CTDATA
136400000000TRUST NUMBER CANNOT BE ZERO
136500000000TRUST NUMBER IS NOT ON MASTER FILE
136600000000SUBDIVISION NUMBER CANNOT BE ZERO
136700000000TRUST/SUB IS NOT ON SUBDIVISION MASTER FILE
136800000000MEMBER NUMBER CANNOT BE ZERO
136900000000MEMBER NUMBER IS NOT ON MASTER FILE
137000000000ACCOUNT NUMBER CANNOT BE ZERO
137100000000TRUST/SUB/ACCOUNT IS NOT ON ACCOUNT MASTER FILE
137200000000TRUST NOT SELECTED FROM INQUIRY
137300000000SUBDIVISION NOT SELECTED FROM INQUIRY
137400000000INVALID CODE SELECTED
137500000000ACCOUNT NOT SELECTED FROM INQUIRY
137600000000INVALID USER ENTERED
137700000000FROM DATE IS INVALID
137800000000TO DATE IS INVALID
137900000000FROM/TO DATE INCOMPATIBLE
138000000000SORT SELECTION INVALID
138100020312EMAIL SELECTION INVALID
