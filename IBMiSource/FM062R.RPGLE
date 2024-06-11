000100010219    *** FM060 ACCOUNT MASTER APPLICATION
000200010219    ***
000300010219    *** FM062R - ACCOUNT PRIMARY PLAN MAINTENANCE
000400010219    ***
000500010219    *** SSK REWROTE FROM S36 SRC FM060 FROM 12/00 TO 01/01
000600010219    ***
000700010219    *** 02192001  SSK  CHANGE ARRAY FLAG ADDED TO ENSURE PROPER DATA STRUCTURE IS PROCESSED.
000800010219    ***
000900010219    ***
001000010219    ***
001100010105     FFM062D    CF   E             WORKSTN INFDS(WSDS)
001200010105     F                                     SFILE(S01SFL:RR3)
001300010105     FAPLNP     UF A E           K DISK
001400010105     FTRSMST    IF   E           K DISK
001500010105     FSUBMST    IF   E           K DISK
001600010105     FACCMST    IF   E           K DISK
001700010105     FPLNMST    IF   E           K DISK
001800010105   X***X
001900010105     D                 DS
002000010105     D @CURR                   1     80A
002100010108     D CR@@                    1     80A   DIM(20)
002200010105     D ACP1                    1      4A
002300010105     D ACP2                    5      8A
002400010105     D ACP3                    9     12A
002500010105     D ACP4                   13     16A
002600010105     D ACP5                   17     20A
002700010105     D ACP6                   21     24A
002800010105     D ACP7                   25     28A
002900010105     D ACP8                   29     32A
003000010105     D ACP9                   33     36A
003100010105     D ACP10                  37     40A
003200010105     D ACP11                  41     44A
003300010105     D ACP12                  45     48A
003400010105     D ACP13                  49     52A
003500010105     D ACP14                  53     56A
003600010105     D ACP15                  57     60A
003700010105     D ACP16                  61     64A
003800010105     D ACP17                  65     68A
003900010105     D ACP18                  69     72A
004000010105     D ACP19                  73     76A
004100010105     D ACP20                  77     80A
004200010105    ***
004300010105     D                 DS
004400010105     D @PREV                   1     80A
004500010108     D PR@@                    1     80A   DIM(20)
004600010105     D APP1                    1      4A
004700010105     D APP2                    5      8A
004800010105     D APP3                    9     12A
004900010105     D APP4                   13     16A
005000010105     D APP5                   17     20A
005100010105     D APP6                   21     24A
005200010105     D APP7                   25     28A
005300010105     D APP8                   29     32A
005400010105     D APP9                   33     36A
005500010105     D APP10                  37     40A
005600010105     D APP11                  41     44A
005700010105     D APP12                  45     48A
005800010105     D APP13                  49     52A
005900010105     D APP14                  53     56A
006000010105     D APP15                  57     60A
006100010105     D APP16                  61     64A
006200010105     D APP17                  65     68A
006300010105     D APP18                  69     72A
006400010105     D APP19                  73     76A
006500010105     D APP20                  77     80A
006600010105    ***
006700010105     D                 DS
006800010105     D @R2DS                   1     80A
006900010108     D R2@@                    1     80A   DIM(20)
007000010105     D R2P01                   1      4A
007100010105     D R2P02                   5      8A
007200010105     D R2P03                   9     12A
007300010105     D R2P04                  13     16A
007400010105     D R2P05                  17     20A
007500010105     D R2P06                  21     24A
007600010105     D R2P07                  25     28A
007700010105     D R2P08                  29     32A
007800010105     D R2P09                  33     36A
007900010105     D R2P10                  37     40A
008000010105     D R2P11                  41     44A
008100010105     D R2P12                  45     48A
008200010105     D R2P13                  49     52A
008300010105     D R2P14                  53     56A
008400010105     D R2P15                  57     60A
008500010105     D R2P16                  61     64A
008600010105     D R2P17                  65     68A
008700010105     D R2P18                  69     72A
008800010105     D R2P19                  73     76A
008900010105     D R2P20                  77     80A
009000010105    ***
009100010105     D                 DS
009200010108     D @R2T1                   1    300A
009300010108     D R2T1@                   1    300A   DIM(10)
009400010108     D R2T01                   1     30A
009500010108     D R2T03                  31     60A
009600010108     D R2T05                  61     90A
009700010108     D R2T07                  91    120A
009800010108     D R2T09                 121    150A
009900010108     D R2T11                 151    180A
010000010108     D R2T13                 181    210A
010100010108     D R2T15                 211    240A
010200010108     D R2T17                 241    270A
010300010108     D R2T19                 271    300A
010400010105    ***
010500010105     D                 DS
010600010108     D @R2T2                   1    300A
010700010108     D R2T2@                   1    300A   DIM(10)
010800010108     D R2T02                   1     30A
010900010108     D R2T04                  31     60A
011000010108     D R2T06                  61     90A
011100010108     D R2T08                  91    120A
011200010108     D R2T10                 121    150A
011300010108     D R2T12                 151    180A
011400010108     D R2T14                 181    210A
011500010108     D R2T16                 211    240A
011600010108     D R2T18                 241    270A
011700010108     D R2T20                 271    300A
011800010105    ***
011900010108     D  MSG            S             50A   DIM(8) PERRCD(1) CTDATA
012000010105     D  ASET           S              5A   DIM(20) PERRCD(1) CTDATA
012100010105    ***
012200010105     D                 DS
012300010105     D CTL@@                   1      5A
012400010105     D  #OC                    1      2S 0
012500010105     D  @T                     3      3A
012600010105     D  #NDX                   4      5S 0
012700010105    ***
012800010105     D WSDS            DS
012900010105     D  FKEY                 369    369A
013000010105    ***
013100010105     D  F1             C                   CONST(X'31')
013200010105     D  F2             C                   CONST(X'32')
013300010105     D  F3             C                   CONST(X'33')
013400010105     D  F4             C                   CONST(X'34')
013500010105     D  F5             C                   CONST(X'35')
013600010105     D  F6             C                   CONST(X'36')
013700010105     D  F7             C                   CONST(X'37')
013800010105     D  F8             C                   CONST(X'38')
013900010105     D  F9             C                   CONST(X'39')
014000010105     D  F10            C                   CONST(X'3A')
014100010105     D  F11            C                   CONST(X'3B')
014200010105     D  F12            C                   CONST(X'3C')
014300010105     D  F13            C                   CONST(X'B1')
014400010105     D  F14            C                   CONST(X'B2')
014500010105     D  F15            C                   CONST(X'B3')
014600010105     D  F16            C                   CONST(X'B4')
014700010105     D  F17            C                   CONST(X'B5')
014800010105     D  F18            C                   CONST(X'B6')
014900010105     D  F19            C                   CONST(X'B7')
015000010105     D  F20            C                   CONST(X'B8')
015100010105     D  F21            C                   CONST(X'B9')
015200010105     D  F22            C                   CONST(X'BA')
015300010105     D  F23            C                   CONST(X'BB')
015400010105     D  F24            C                   CONST(X'BC')
015500010105    ***
015600010105     D                UDS
015700010105     D  CONAME               201    240
015800010105    ***
015900010105     D                 DS
016000010105     D @PRMS                   1     10
016100010105     D  #KT                    1      3S 0
016200010105     D  #KS                    4      6S 0
016300010105     D  #KA                    7     10S 0
016400010105   X***X
016500010108    1C                   DOU       @STEP = 'EXIT '
016600010108    2C     @STEP         CASEQ     'STEP0'       $STEP0
016700010108    2C     @STEP         CASEQ     'STEP1'       $STEP1
016800010108    2C     @STEP         CASEQ     'STEP2'       $STEP2
016900010108    2C     @STEP         CASEQ     'STEP3'       $STEP3
017000010108    2C     @STEP         CASEQ     'STEP4'       $STEP4
017100010108    2C                   ENDCS
017200010108    1C                   ENDDO
017300010105     C*
017400010105     C                   MOVE      *ON           *INLR
017500010105     C*
017600010105   S***S
017700010105     C     *INZSR        BEGSR
017800010105    ***
017900010105     C     *ENTRY        PLIST
018000010105     C                   PARM                    @PARM            10
018100010105    ***
018200010108     C                   MOVE      'STEP0'       @STEP             5
018300010105     C                   MOVE      @PARM         @PRMS
018400010105     C                   Z-ADD     794           #K794             3 0
018500010105     C                   Z-ADD     001           #K001             3 0
018600010105    ***
018700010105     C     APLKEY        KLIST
018800010105     C                   KFLD                    I_TRST
018900010105     C                   KFLD                    I_SUB#
019000010105     C                   KFLD                    I_ACCT
019100010105     C                   KFLD                    @PLAN             4
019200010105     C     PLNKEY        KLIST
019300010105     C                   KFLD                    #KT
019400010105     C                   KFLD                    #KS
019500010105     C                   KFLD                    @4                4
019600010105     C     SUBKEY        KLIST
019700010105     C                   KFLD                    #KT
019800010105     C                   KFLD                    #KS
019900010105     C     AP1KEY        KLIST
020000010105     C                   KFLD                    #KT
020100010105     C                   KFLD                    #KS
020200010105     C                   KFLD                    #KA
020300010105     C     KEY794        KLIST
020400010105     C                   KFLD                    #K794
020500010105     C                   KFLD                    #K001
020600010105     C                   KFLD                    @KP4              4
020700010105    ***
020800010105     C                   ENDSR
020900010105   S***S
021000010105     C     $STEP0        BEGSR
021100010108    ***
021200010108     C                   Z-ADD     #KT           I_TRST
021300010108     C                   Z-ADD     #KS           I_SUB#
021400010108     C                   Z-ADD     #KA           I_ACCT
021500010105    ***
021600010105     C     #KT           CHAIN(N)  TRSMSR
021700010108    1C                   IF        %FOUND(TRSMST)
021800010105     C                   MOVEL(P)  TNAME         O_TNAM
021900010108    1C                   ENDIF
022000010105     C     SUBKEY        CHAIN(N)  SUBMSR
022100010108    1C                   IF        %FOUND(SUBMST)
022200010105     C                   MOVEL(P)  SUBNAM        O_SUBN
022300010108    1C                   ENDIF
022400010105     C     AP1KEY        CHAIN(N)  ACCMSR
022500010108    1C                   IF        %FOUND(ACCMST)
022600010105     C                   MOVEL(P)  ACNAM1        O_ACCN
022700010108    1C                   ENDIF
022800010105    ***
022900010105     C                   MOVEL(P)  'STEP1'       @STEP
023000010105    ***
023100010105     C                   ENDSR
023200010105   S***S
023300010105     C     $STEP1        BEGSR
023400010105    ***
023500010105     C                   MOVE      *ZEROS        RR3               4 0
023600010105     C                   MOVE      *ZEROS        #CNTREC           4 0
023700010105    ***
023800010105     C                   EXSR      $CLEAR
023900010105    ***
024000010105     C                   EXSR      $BUILD
024100010105     C                   MOVEL(P)  'STEP2'       @STEP
024200010105    ***
024300010105     C                   ENDSR
024400010105   S***S
024500010105     C* INITIALIZE THE SUBFILE
024600010105    ***
024700010105     C     $CLEAR        BEGSR
024800010105    ***
024900010105     C                   MOVEA     '011'         *IN(25)
025000010105     C                   WRITE     S01CTL
025100010105     C                   MOVEA     '010'         *IN(25)
025200010105     C                   Z-ADD     *ZERO         RR3
025300010105    ***
025400010105     C                   ENDSR
025500010105   S***S
025600010105     C* BUILD SUBFILE CONTROL ROUTINE
025700010105    ***
025800010105     C     $BUILD        BEGSR
025900010105    ***
026000010105     C                   MOVE      *ZEROS        #CNTREC
026100010105     C                   MOVE      '0'           @1STLOOP          1
026200010105     C                   MOVE      '0'           @SFLOOP           1
026300010105    ***
026400010105     C     AP1KEY        SETLL     APLNPR
026500010108    1C                   DOU       %EOF(APLNP) OR @SFLOOP = '1'
026600010105     C     AP1KEY        READE     APLNPR
026700010108    2C                   IF        NOT %EOF(APLNP)
026800010105     C                   EXSR      $LOADSFL
026900010108    2C                   ENDIF
027000010108    1C                   ENDDO
027100010105    ***
027200010105    *C*                  IF        %EOF(APLNP)
027300010105    *C*                  MOVE      *OFF          *IN29
027400010105    *C*                  ELSE
027500010105    *C*                  MOVE      *ON           *IN29
027600010105    *C*                  ENDIF
027700010105    ***
027800010105     C                   ENDSR
027900010105   S***S
028000010105     C* LOAD SUBFILE RECORDS
028100010105    ***
028200010105     C     $LOADSFL      BEGSR
028300010105    ***
028400010105     C                   MOVE      *ON           *IN25
028500010105     C                   MOVE      *BLANKS       SEL
028600010105     C                   MOVEL(P)  APPLN         SFPLAN
028700010105     C                   MOVEL(P)  APPLN         @4
028800010105     C     PLNKEY        CHAIN(N)  PLNMSR
028900010108    1C                   IF        %FOUND(PLNMST)
029000010105     C                   MOVEL(P)  PDESCR        SFPNAM
029100010108    1C                   ELSE
029200010105     C     'NO DESC FOUN'CAT(P)    'D FOR PLAN':0SFPNAM
029300010108    1C                   ENDIF
029400010105     C*
029500010105     C                   ADD       1             RR3
029600010105     C*
029700010108    1C                   IF        @1STLOOP = '0'
029800010105     C                   Z-ADD     RR3           SFLPOS
029900010105     C                   MOVE      '1'           @1STLOOP
030000010108    1C                   ENDIF
030100010105     C*
030200010105     C                   WRITE     S01SFL
030300010105     C*
030400010105     C                   ADD       1             #CNTREC
030500010108    1C                   IF        #CNTREC = 100
030600010105     C                   MOVE      '1'           @SFLOOP
030700010108    1C                   ENDIF
030800010105    ***
030900010105     C                   ENDSR
031000010105   S***S
031100010105     C     $STEP2        BEGSR
031200010105    ***
031300010105     C                   EXSR      $DISPLAY
031400010105     C                   MOVE      *BLANKS       S01MSG
031500010108     C                   ADD       1             #ECNT
031600010105    ***
031700010108    1C                   IF        FKEY = F1
031800010105     C                   MOVEL(P)  'EXIT'        @STEP
031900010105     C                   LEAVESR
032000010108    1C                   ENDIF
032100010105    ***
032200010108    1C                   IF        FKEY = F6
032300010105     C                   MOVEL(P)  'STEP3'       @STEP
032400010105     C                   MOVE      'A'           @@A               1
032500010105     C                   LEAVESR
032600010108    1C                   ENDIF
032700010105    ***
032800010105     C                   EXSR      $CHKSELC
032900010105    ***
033000010108    1C                   IF        @@A = 'D' OR #ECNT >= 3
033100010105     C                   MOVEL(P)  'STEP1'       @STEP
033200010105     C                   LEAVESR
033300010108    1C                   ENDIF
033400010105    ***
033500010105     C                   ENDSR
033600010105   S***S
033700010105     C* DISPLAY THE SCREEN
033800010105    ***
033900010105     C     $DISPLAY      BEGSR
034000010105    ***
034100010105     C                   WRITE     S01REC
034200010105     C                   EXFMT     S01CTL
034300010105     C*
034400010105     C                   MOVE      *BLANKS       S01MSG
034500010105    ***
034600010105     C                   ENDSR
034700010105   S***S
034800010105     C     $STEP3        BEGSR
034900010105    ***
035000010105     C                   MOVE      '0'           @VALID
035100010105     C                   MOVE      *BLANKS       R2PLAN
035200010105     C                   MOVE      *BLANKS       R2PDES
035300010108     C                   MOVE      *BLANKS       @CURR
035400010108     C                   MOVE      *BLANKS       @PREV
035500010105     C                   SETOFF                                       3035
035600010108     C                   MOVE      '11'          *IN(40)
035700010105     C                   MOVE      *BLANKS       @R2T1
035800010105     C                   MOVE      *BLANKS       @R2T2
035900010105     C                   MOVE      *ALL'0'       @R2DS
036000010105     C                   MOVE      'STEP4'       @STEP
036100010105    ***
036200010105     C                   ENDSR
036300010105   S***S
036400010105     C     $STEP4        BEGSR
036500010105    ***
036600010105     C                   EXFMT     S02R
036700010105     C                   MOVE      *BLANKS       R2MSG
036800010105    ***
036900010108    1C                   IF        FKEY = F1
037000010105     C                   MOVE      'STEP1'       @STEP
037100010105     C                   LEAVESR
037200010108    1C                   ENDIF
037300010105    ***
037400010105    1C                   IF        FKEY = F5
037500010105    2C                   IF        @@A = 'A'
037600010105     C                   MOVEL(P)  MSG(8)        R2MSG
037700010105     C                   LEAVESR
037800010105    2C                   ENDIF
037900010108    2C                   IF        *IN40 = *OFF                                 PREV ON SCREEN
038000010219     C                   MOVE      'C'           @@CT              1
038100010105     C                   MOVE      *ON           *IN40
038200010108     C                   MOVE      *OFF          *IN35
038300010105     C                   MOVE      *BLANKS       @R2DS
038400010105     C                   MOVEL     @CURR         @R2DS
038500010108    2C                   ELSE                                                   CURR ON SCREEN
038600010219     C                   MOVE      'P'           @@CT
038700010108     C                   MOVE      *ON           *IN35
038800010105     C                   MOVE      *OFF          *IN40
038900010105     C                   MOVE      *BLANKS       @CURR
039000010108     C                   MOVEL     @R2DS         @CURR
039100010105     C                   MOVE      *BLANKS       @R2DS
039200010105     C                   MOVEL     @PREV         @R2DS
039300010105    2C                   ENDIF
039400010105     C                   EXSR      $794S
039500010105     C                   LEAVESR
039600010105    1C                   ENDIF
039700010105    ***
039800010219    1C                   IF        @@A = 'A' OR (@@A = 'C' AND @@CT = 'C')
039900010105     C                   MOVE      '0'           @VALID
040000010105     C                   EXSR      $VALIDATE
040100010219     C*
040200010219    2C                   IF        @VALID = '0'
040300010219    3C                   IF        @@A = 'A'
040400010105     C                   EXSR      $ADDREC
040500010108     C                   MOVEL(P)  'STEP3'       @STEP
040600010105     C                   LEAVESR
040700010219    3C                   ENDIF
040800010219    3C                   IF        @@A = 'C'
040900010108     C                   EXSR      $CHANGES
041000010219    4C                   IF        @@DC = 'Y'
041100010108     C                   UPDATE    APLNPR
041200010219    4C                   ENDIF
041300010219    3C                   ENDIF
041400010219    2C                   ENDIF
041500010219     C*
041600010108    1C                   ENDIF
041700010105    ***
041800010105     C                   ENDSR
041900010105   S***S
042000010105     C     $ADDREC       BEGSR
042100010105    ***
042200010105     C                   CLEAR                   APLNPR
042300010105     C                   MOVEL     @R2DS         @CURR
042400010105     C                   Z-ADD     I_TRST        APTRST
042500010105     C                   Z-ADD     I_SUB#        APSUB
042600010105     C                   Z-ADD     I_ACCT        APACT
042700010105     C                   MOVEL     R2PLAN        APPLN
042800010105     C                   WRITE     APLNPR
042900010105    ***
043000010105     C                   ENDSR
043100010105   S***S
043200010105     C     $VALIDATE     BEGSR
043300010105    ***
043400010105    1C                   IF        R2PLAN = *BLANKS
043500010105     C                   MOVE      '1'           @VALID
043600010105     C                   MOVEL(P)  MSG(1)        R2MSG
043700010105     C                   LEAVESR
043800010105    1C                   ENDIF
043900010105     C*
044000010105     C                   MOVEL(P)  R2PLAN        @4
044100010105     C     PLNKEY        CHAIN(N)  PLNMSR
044200010105    1C                   IF        %FOUND(PLNMST)
044300010105     C                   MOVEL(P)  PDESCR        R2PDES
044400010105    1C                   ELSE
044500010105     C                   MOVE      '1'           @VALID            1
044600010105     C                   MOVE      *BLANKS       R2PDES
044700010105     C                   MOVEL(P)  MSG(2)        R2MSG
044800010105     C                   LEAVESR
044900010105    1C                   ENDIF
045000010105    ***
045100010105     C                   MOVE      '0'           @@DES             1
045200010105     C                   EXSR      $794S
045300010105    1C                   IF        @@DES = '1'
045400010105     C                   MOVEL(P)  MSG(3)        R2MSG
045500010105     C                   MOVE      '1'           @VALID
045600010105    1C                   ENDIF
045700010105    ***
045800010105     C                   ENDSR
045900010105   S***S
046000010105     C     $794S         BEGSR
046100010105    ***
046200010105     C                   MOVE      *ZEROS        A                 2 0
046300010105     C                   CLEAR                   @R2T1
046400010105     C                   CLEAR                   @R2T2
046500010105    1C                   DO        20
046600010105     C*
046700010105     C                   ADD       1             A
046800010105     C                   MOVEA     ASET(A)       CTL@@
046900010105     C*
047000010105    2C                   IF        R2@@(A) <> '0000'
047100010108     C                   MOVE      *BLANKS       @KP4
047200010108     C                   MOVEA     R2@@(A)       @KP4
047300010105     C     KEY794        CHAIN(N)  PLNMSR
047400010105    3C                   IF        %FOUND(PLNMST)
047500010108     C                   MOVEL(P)  PDESCR        @30              30
047600010105    3C                   ELSE
047700010108     C                   MOVEL(P)  'INVALID #'   @30
047800010105     C                   MOVE      '1'           @@DES             1
047900010105    3C                   ENDIF
048000010108    3C                   IF        @T = '1'
048100010108     C                   MOVEA     @30           R2T1@(#NDX)
048200010108    3C                   ELSE
048300010108     C                   MOVEA     @30           R2T2@(#NDX)
048400010108    3C                   ENDIF
048500010105    2C                   ENDIF
048600010105     C*
048700010108    1C                   ENDDO
048800010105    ***
048900010105     C                   ENDSR
049000010108   S***S
049100010108     C     $CHANGES      BEGSR
049200010108    ***
049300010108     C                   MOVE      *ZEROS        A
049400010108     C                   MOVE      'N'           @@DC              1
049500010219*******                  IF        *IN40 = *OFF
049600010219    1C                   IF        @@CT = 'C'
049700010108     C                   MOVE      *BLANKS       @CURR
049800010108     C                   MOVEL     @R2DS         @CURR
049900010108    1C                   ENDIF
050000010108     C*
050100010108    1C                   DO        20            A
050200010108    2C                   IF        CR@@(A) <> PR@@(A)
050300010108     C                   MOVE      'Y'           @@DC              1
050400010108    2C                   ENDIF
050500010108    1C                   ENDDO
050600010108    ***
050700010108     C                   ENDSR
050800010105   S***S
050900010105     C* CHECK SUBFILE SELECTION
051000010105    ***
051100010105     C     $CHKSELC      BEGSR
051200010105    ***
051300010108     C                   DOU       %EOF(FM062D)
051400010105     C                   READC     S01SFL
051500010108     C                   IF        NOT %EOF(FM062D) AND SEL <> *BLANKS
051600010105     C*
051700010108     C                   MOVE      *OFF          *IN41
051800010105     C                   SELECT
051900010105     C                   WHEN      SEL = 'C'
052000010105     C                   EXSR      $CHGCTL
052100010108     C                   WHEN      SEL = 'D'
052200010108     C                   EXSR      $DLTCTL
052300010117     C                   WHEN      SEL = 'V'
052400010117     C                   EXSR      $DSPCTL
052500010105     C                   ENDSL
052600010105     C*
052700010105     C                   IF        S01MSG <> *BLANKS
052800010105     C                   LEAVESR
052900010105     C                   ENDIF
053000010105     C*
053100010105     C                   MOVE      *BLANKS       SEL
053200010105     C                   UPDATE    S01SFL
053300010105     C*
053400010105     C                   ENDIF
053500010105     C                   ENDDO
053600010105    ***
053700010105     C                   ENDSR
053800010105   S***S
053900010105     C* CHANGE CONTROL ROUTINE
054000010105    ***
054100010105     C     $CHGCTL       BEGSR
054200010105    ***
054300010219     C                   MOVE      'C'           @@CT
054400010108     C                   MOVEL(P)  @STEP         @@STP             5
054500010105     C                   MOVE      'C'           @@A                            ACTION TYPE
054600010122     C                   MOVE      *OFF          *IN30
054700010105     C                   EXSR      $LOADNLOCK
054800010108     C                   MOVE      *BLANKS       @PREV
054900010108     C                   MOVEL     @CURR         @PREV
055000010108     C                   MOVEL(P)  SFPLAN        R2PLAN
055100010105     C*
055200010105     C                   IF        S01MSG <> *BLANKS
055300010105     C                   LEAVESR
055400010105     C                   ENDIF
055500010105    ***
055600010122     C                   MOVE      *ON           *IN39
055700010105     C                   MOVE      '0'           @@E               1
055800010105     C                   DOU       @@E = '1'
055900010105     C*
056000010108     C                   EXSR      $STEP4
056100010105     C*
056200010105     C                   IF        @STEP = 'STEP1'
056300010105     C                   MOVE      @@STP         @STEP
056400010105     C                   MOVE      '1'           @@E
056500010122     C                   MOVE      *OFF          *IN39
056600010105     C                   LEAVESR
056700010105     C                   ENDIF
056800010105     C*
056900010105     C                   ENDDO
057000010105    ***
057100010105     C                   ENDSR
057200010105   S***S
057300010105     C* LOAD SCREEN 2 W/LOCKING REC
057400010105    ***
057500010105     C     $LOADNLOCK    BEGSR
057600010105    ***
057700010105     C                   CLEAR                   APLNPR
057800010105     C                   MOVE      *BLANKS       @R2T1
057900010105     C                   MOVE      *BLANKS       @R2T2
058000010105     C                   MOVE      *ALL'0'       @R2DS
058100010105     C                   MOVE      *ON           *IN40
058200010105    ***
058300010105     C                   MOVEL(P)  SFPLAN        @PLAN
058400010105     C     APLKEY        CHAIN     APLNPR
058500010105     C                   IF        NOT %FOUND(APLNP)
058600010105     C                   MOVEL(P)  MSG(7)        S01MSG
058700010105     C                   LEAVESR
058800010105     C                   ENDIF
058900010105    ***
059000010108     C                   MOVE      *OFF          *IN35
059100010108     C                   MOVEL     @CURR         @R2DS
059200010108     C                   EXSR      $794S
059300010105     C                   MOVEL(P)  SFPNAM        R2PDES
059400010105    ***
059500010105     C                   ENDSR
059600010105   S***S
059700010117     C     $DSPCTL       BEGSR
059800010105    ***
059900010122     C                   MOVE      'V'           @@A                            ACTION TYPE
060000010105     C                   MOVE      '0'           @@E               1            LOOP FLAG
060100010108    ***
060200010105     C                   EXSR      $LOADNLOCK
060300010108     C                   MOVEL(P)  SFPLAN        R2PLAN
060400010108    ***
060500010105    1C                   IF        S01MSG <> *BLANKS
060600010105     C                   LEAVESR
060700010105    1C                   ENDIF
060800010108    ***
060900010117     C                   MOVE      *ON           *IN35
061000010122     C                   SETOFF                                       3039
061100010108    ***
061200010105    1C                   DOU       @@E = '1'
061300010108     C*
061400010105     C                   EXFMT     S02R                                         OK TO DELETE?
061500010108     C*
061600010105     C                   MOVE      *BLANKS       R2MSG
061700010108     C*
061800010105    2C                   IF        FKEY = F1                                    OK TO DELETE? = NO
061900010122     C                   SETOFF                                       303539
062000010105     C                   LEAVESR
062100010105    2C                   ENDIF
062200010108     C*
062300010108    2C                   IF        FKEY = F5
062400010108     C**
062500010108    3C                   IF        *IN40 = *OFF                                 PREV ON SCREEN
062600010108     C                   MOVE      *ON           *IN40
062700010108     C                   MOVE      *BLANKS       @R2DS
062800010108     C                   MOVEL     @CURR         @R2DS
062900010108     C**
063000010108    3C                   ELSE                                                   CURR ON SCREEN
063100010108     C                   MOVE      *OFF          *IN40
063200010108     C                   MOVE      *BLANKS       @R2DS
063300010108     C                   MOVEL     @PREV         @R2DS
063400010108    3C                   ENDIF
063500010108     C**
063600010108     C                   EXSR      $794S
063700010108     C**
063800010108    2C                   ENDIF
063900010108     C*
064000010105    1C                   ENDDO
064100010105    ***
064200010105     C                   ENDSR
064300010117   S***S
064400010117     C     $DLTCTL       BEGSR
064500010117    ***
064600010117     C                   MOVE      'D'           @@A                            ACTION TYPE
064700010117     C                   MOVE      '0'           @@E               1            LOOP FLAG
064800010117    ***
064900010117     C                   EXSR      $LOADNLOCK
065000010117     C                   MOVEL(P)  SFPLAN        R2PLAN
065100010117    ***
065200010117    1C                   IF        S01MSG <> *BLANKS
065300010117     C                   LEAVESR
065400010117    1C                   ENDIF
065500010117    ***
065600010117     C                   SETON                                        3035      ACTIVATE DLT MODE
065700010117    ***
065800010117    1C                   DOU       @@E = '1'
065900010117     C*
066000010117     C                   EXFMT     S02R                                         OK TO DELETE?
066100010117     C*
066200010117     C                   MOVE      *BLANKS       R2MSG
066300010117     C*
066400010117    2C                   IF        FKEY = F1                                    OK TO DELETE? = NO
066500010122     C                   SETOFF                                       303539
066600010117     C                   LEAVESR
066700010117    2C                   ENDIF
066800010117     C*
066900010117    2C                   IF        FKEY = F5
067000010117     C**
067100010117    3C                   IF        *IN40 = *OFF                                 PREV ON SCREEN
067200010117     C                   MOVE      *ON           *IN40
067300010117     C                   MOVE      *OFF          *IN35
067400010117     C                   MOVE      *BLANKS       @R2DS
067500010117     C                   MOVEL     @CURR         @R2DS
067600010117     C**
067700010117    3C                   ELSE                                                   CURR ON SCREEN
067800010117     C                   MOVE      *ON           *IN35
067900010117     C                   MOVE      *OFF          *IN40
068000010117     C                   MOVE      *BLANKS       @R2DS
068100010117     C                   MOVEL     @PREV         @R2DS
068200010117    3C                   ENDIF
068300010117     C**
068400010117     C                   EXSR      $794S
068500010117     C**
068600010117    2C                   ENDIF
068700010117     C*
068800010117    2C                   IF        FKEY = F16                                   OK TO DELETE? = YES
068900010117     C     APLKEY        DELETE    APLNPR                                       DELETE RECORD
069000010117     C                   MOVE      '1'           @@E                            EXIT LOOP FLAG
069100010117     C                   Z-ADD     4             #ECNT             2 0
069200010117    2C                   ENDIF
069300010117     C*
069400010117    1C                   ENDDO
069500010117    ***
069600010117     C                   ENDSR
069700010117   X***X
069800010105123456*8901234567890123456789012345678901234567890
069900010105      *  11111111112222222222333333333344444444445
070000010105** CTDATA MSG
070100010105PLAN CODE CANNOT BE BLANK                         1
070200010105PLAN CODE IS INVALID                              2
070300010105DESCRIPTION PLAN # IS INVALID                     3
070400010105PRESS F16 AGAIN TO CONFIRM RECORD DELETION        4
070500010105TRUST/SUB/ACCT/PLAN HAS BEEN DELETED              5
070600010105TRUST/SUB/ACCT/PLAN ALREADY EXISTS!               6
070700010105UNABLE TO ACCESS PLAN, RETRY SELECTION            7
070800010105PREVIOUS DATA NOT AVAILABLE WHEN ADDING RECORD    8
070900010105** CTDATA ASET
07100001010501101
07110001010502201
07120001010503102
07130001010504202
07140001010505103
07150001010506203
07160001010507104
07170001010508204
07180001010509105
07190001010510205
07200001010511106
07210001010512206
07220001010513107
07230001010514207
07240001010515108
07250001010516208
07260001010517109
07270001010518209
07280001010519110
07290001010520210
