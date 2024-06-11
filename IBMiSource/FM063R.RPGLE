000100010516    *** SUB PROGRAM - CARRIER SIZE MAINTENANCE FOR ACCOUNT MASTER APPLICATION
000200010516    ***
000300010516    *** SSK  01/02/01
000400010516    ***
000500010516    ***
000600140124    *** SSK 05162001 ADD DUMMY LOGIC TO PREVENT UNWANTED KEYSTROKES
000700011211    *** SSK 12112001 ADD DATE RANGE VALIDATION EDITS FOR OVERLAPS
000800140124    *** SSK 02212002 DATE RANGE VALIDATION STILL NON-FUNCTIONAL
000900030501    *** ssk 05012003 conventry project
001000040728    *** KSJ 07282004 Added 2 new parms (Carr and Desc) to be displayed
001100040728    ***               only if this pgm is called from FM040R
001200060310    *** DLK 03/10/06 remove override under 50 field
001300040728    ***
001400000102     FFM063D    CF   E             WORKSTN INFDS(WSDS)
001500000102     F                                     SFILE(S01SFL:RR1)
001600000102     FMKTCARA1  UF A E           K DISK
001700011211     FMKTCARA2  IF   E           K DISK    RENAME(RMKTCARA:MKC2) PREFIX(ZZ:2)
001800000102     FTRSMST    IF   E           K DISK
001900000102     FSUBMST    IF   E           K DISK
002000000102     FACCMST    IF   E           K DISK
002100000102     FCARMST    IF   E           K DISK
002200000102     FCARMKSZ3  IF   E           K DISK
002300000102   X***X
002400040723     D MSG             S             50A   DIM(16) PERRCD(1) CTDATA
002500010116     D #ISO            S               D   DATFMT(*ISO)
002600010116     D #USA            S               D   DATFMT(*USA)
002700010120     D #ISA            S              8S 0
002800000102    ***
002900000102     D WSDS            DS
003000000102     D  FKEY                 369    369A
003100000102    ***
003200000102     D  F1             C                   CONST(X'31')
003300000102     D  F2             C                   CONST(X'32')
003400000102     D  F3             C                   CONST(X'33')
003500000102     D  F4             C                   CONST(X'34')
003600000102     D  F5             C                   CONST(X'35')
003700000102     D  F6             C                   CONST(X'36')
003800000102     D  F7             C                   CONST(X'37')
003900000102     D  F8             C                   CONST(X'38')
004000000102     D  F9             C                   CONST(X'39')
004100000102     D  F10            C                   CONST(X'3A')
004200000102     D  F11            C                   CONST(X'3B')
004300000102     D  F12            C                   CONST(X'3C')
004400000102     D  F13            C                   CONST(X'B1')
004500000102     D  F14            C                   CONST(X'B2')
004600000102     D  F15            C                   CONST(X'B3')
004700000102     D  F16            C                   CONST(X'B4')
004800000102     D  F17            C                   CONST(X'B5')
004900000102     D  F18            C                   CONST(X'B6')
005000000102     D  F19            C                   CONST(X'B7')
005100000102     D  F20            C                   CONST(X'B8')
005200000102     D  F21            C                   CONST(X'B9')
005300000102     D  F22            C                   CONST(X'BA')
005400000102     D  F23            C                   CONST(X'BB')
005500000102     D  F24            C                   CONST(X'BC')
005600000102    ***
005700000102     D                UDS
005800000102     D  CONAME               201    240
005900000102    ***
006000000102     D                 DS
006100000102     D @PRMS                   1     10
006200000102     D  #KT                    1      3S 0
006300000102     D  #KS                    4      6S 0
006400000102     D  #KA                    7     10S 0
006500011211    ***
006600011211     D KEY@TRS         S                   LIKE(MATRST)
006700011211     D KEY@SUB         S                   LIKE(MASUB#)
006800011211     D KEY@ACC         S                   LIKE(MAACC#)
006900011211     D KEY@CAR         S                   LIKE(MACARR)
007000011211     D KEY@SZC         S                   LIKE(MASZCD)
007100011211     D #FRDT           S                   LIKE(MAFRDT)
007200011211     D #TODT           S                   LIKE(MATODT)
007300000102   X***X
007400000102     C                   DOU       @STEP = 'EXIT '
007500000102     C     @STEP         CASEQ     'STEP0'       $STEP0
007600000102     C     @STEP         CASEQ     'STEP1'       $STEP1
007700000102     C     @STEP         CASEQ     'STEP2'       $STEP2
007800000102     C     @STEP         CASEQ     'STEP3'       $STEP3
007900000102     C     @STEP         CASEQ     'STEP4'       $STEP4
008000000102     C                   ENDCS
008100000102     C                   ENDDO
008200000102     C*
008300000102     C                   MOVE      *ON           *INLR
008400000102     C*
008500000102   S***S
008600000102     C     *INZSR        BEGSR
008700000102    ***
008800000102     C     *ENTRY        PLIST
008900000102     C                   PARM                    @PARM            10
009000040728     C                   PARM                    @PARM2            3
009100040728     C                   PARM                    @PARM3           40
009200000102    ***
009300000102     C                   MOVE      @PARM         @PRMS
009400010103     C                   MOVE      'STEP0'       @STEP             5
009500010103     C                   MOVE      *BLANKS       @@STP             5
009600000102    ***
009700000102     C     SUBKEY        KLIST
009800000102     C                   KFLD                    #KT
009900000102     C                   KFLD                    #KS
010000000102     C     ACCKEY        KLIST
010100000102     C                   KFLD                    #KT
010200000102     C                   KFLD                    #KS
010300000102     C                   KFLD                    #KA
010400000102     C     MCKEY         KLIST
010500000102     C                   KFLD                    #KT
010600000102     C                   KFLD                    #KS
010700000102     C                   KFLD                    #KA
010800000102     C                   KFLD                    @KC               3
010900010120     C                   KFLD                    #8F               8 0
011000010120     C                   KFLD                    #8T               8 0
011100010120     C                   KFLD                    @SZ               5
011200011211     C     KEY#MC2       KLIST
011300011211     C                   KFLD                    KEY@TRS
011400011211     C                   KFLD                    KEY@SUB
011500011211     C                   KFLD                    KEY@ACC
011600011211     C                   KFLD                    KEY@CAR
011700011211     C                   KFLD                    KEY@SZC
011800000102     C     CARKEY        KLIST
011900000102     C                   KFLD                    MACARR
012000000102     C                   KFLD                    MASZCD
012100000102    ***
012200000102     C                   ENDSR
012300000102   S***S
012400000102     C     $STEP0        BEGSR
012500000102    ***
012600010108     C                   Z-ADD     #KT           I_TRST
012700010108     C                   Z-ADD     #KS           I_SUB#
012800010108     C                   Z-ADD     #KA           I_ACCT
012900010108    ***
013000000102     C     #KT           CHAIN(N)  TRSMSR
013100010103    1C                   IF        %FOUND(TRSMST)
013200000102     C                   MOVEL(P)  TNAME         O_TNAM
013300010103    1C                   ENDIF
013400000102     C     SUBKEY        CHAIN(N)  SUBMSR
013500010103    1C                   IF        %FOUND(SUBMST)
013600000102     C                   MOVEL(P)  SUBNAM        O_SUBN
013700010103    1C                   ENDIF
013800000102     C     ACCKEY        CHAIN(N)  ACCMSR
013900010103    1C                   IF        %FOUND(ACCMST)
014000000102     C                   MOVEL(P)  ACNAM1        O_ACCN
014100010103    1C                   ENDIF
014200000102    ***
014300000102     C                   MOVEL(P)  'STEP1'       @STEP
014400000102     C                   MOVE      *BLANKS       S01MSG
014500000102    ***
014600000102     C                   ENDSR
014700000102   S***S
014800000102     C     $STEP1        BEGSR
014900000102    ***
015000000102     C                   MOVE      *ZEROS        RR1               4 0
015100000102     C                   MOVE      *ZEROS        #CNTREC           4 0
015200000102    ***
015300000102     C                   EXSR      $CLEAR
015400000102    ***
015500000102     C                   EXSR      $BUILD
015600000102     C                   MOVEL(P)  'STEP2'       @STEP
015700000102    ***
015800000102     C                   ENDSR
015900000102   S***S
016000000102     C* INITIALIZE THE SUBFILE
016100000102    ***
016200000102     C     $CLEAR        BEGSR
016300000102    ***
016400000102     C                   MOVEA     '011'         *IN(25)
016500000102     C                   WRITE     S01CTL
016600000102     C                   MOVEA     '010'         *IN(25)
016700000102     C                   Z-ADD     *ZERO         RR1
016800040728
016900040728     C                   IF        @PARM2 <> *BLANKS
017000040728     C                   EVAL      *IN40 = *ON
017100040728     C                   EVAL      I_CARR = @PARM2
017200040728     C                   EVAL      O_CARN = @PARM3
017300040728     C                   ELSE
017400040728     C                   EVAL      *IN40 = *OFF
017500040728     C                   ENDIF
017600000102    ***
017700000102     C                   ENDSR
017800000102   S***S
017900000102     C* BUILD SUBFILE CONTROL ROUTINE
018000000102    ***
018100000102     C     $BUILD        BEGSR
018200000102    ***
018300000102     C                   MOVE      *ZEROS        #CNTREC
018400000102     C                   MOVE      '0'           @1STLOOP          1
018500000102     C                   MOVE      '0'           @SFLOOP           1
018600040723     C                   MOVE      '0'           *IN20
018700000102    ***
018800000102     C     ACCKEY        SETLL     RMKTCARA
018900010103    1C                   DOU       %EOF(MKTCARA1) OR @SFLOOP = '1'
019000000102     C     ACCKEY        READE     RMKTCARA
019100010103    2C                   IF        NOT %EOF(MKTCARA1)
019200000102     C                   EXSR      $LOADSFL
019300010103    2C                   ENDIF
019400010103    1C                   ENDDO
019500000102    ***
019600000102     C                   ENDSR
019700000102   S***S
019800000102     C* LOAD SUBFILE RECORDS
019900000102    ***
020000000102     C     $LOADSFL      BEGSR
020100000102    ***
020200000102     C                   MOVE      *ON           *IN25
020300000102     C                   MOVE      *BLANKS       SEL
020400000102     C                   MOVEL(P)  MACARR        SFCARR
020500000102     C                   MOVEL(P)  MASZCD        SFSZCD
020600010120     C                   Z-ADD     MAFRDT        HFRISO
020700010120     C                   Z-ADD     MAFRDT        #ISA
020800010120     C                   EXSR      $ISOUSA
020900010120     C                   Z-ADD     #ISA          SFFRDT
021000010120     C                   Z-ADD     MATODT        HTOISO
021100010120     C                   Z-ADD     MATODT        #ISA
021200060310     c**                 move      maou50        sfaou50
021300010120     C                   EXSR      $ISOUSA
021400010120     C                   Z-ADD     #ISA          SFTODT
021500000102     C     CARKEY        CHAIN(N)  RCARMKSZ
021600010103    1C                   IF        %FOUND(CARMKSZ3)
021700000102     C                   Z-ADD     CZFRSZ        SFFRSZ
021800000102     C                   Z-ADD     CZTOSZ        SFTOSZ
021900010103    1C                   ELSE
022000000102     C                   MOVEL(P)  MSG(1)        S01MSG
022100010103    1C                   ENDIF
022200000102     C*
022300000102     C                   ADD       1             RR1
022400000102     C*
022500010103    1C                   IF        @1STLOOP = '0'
022600000102     C                   Z-ADD     RR1           SFLPOS
022700000102     C                   MOVE      '1'           @1STLOOP
022800010103    1C                   ENDIF
022900000102     C*
023000000102     C                   WRITE     S01SFL
023100000102     C*
023200000102     C                   ADD       1             #CNTREC
023300010103    1C                   IF        #CNTREC = 100
023400000102     C                   MOVE      '1'           @SFLOOP
023500010103    1C                   ENDIF
023600010116    ***
023700010116     C                   ENDSR
023800010116   S***S
023900010116     C     $ISOUSA       BEGSR
024000010116    ***
024100010120     C                   MOVE      'E'           @@GD              1
024200010120    1C                   IF        #ISA <> 0
024300010120     C     *ISO          TEST (DE)               #ISA
024400010120    2C                   IF        NOT %ERROR
024500010120     C                   MOVE      #ISA          #ISO
024600010120     C                   MOVE      #ISO          #USA
024700010120     C                   MOVE      #USA          #ISA
024800010120     C                   MOVE      'G'           @@GD
024900010120    2C                   ELSE
025000010120     C                   MOVE      *ZEROS        #ISA
025100010120    2C                   ENDIF
025200010120    1C                   ENDIF
025300000102    ***
025400000102     C                   ENDSR
025500000102   S***S
025600000102     C     $STEP2        BEGSR
025700000102    ***
025800000102     C                   EXSR      $DISPLAY
025900000102     C                   MOVE      *BLANKS       S01MSG
026000010103     C                   MOVE      *BLANKS       @@A
026100000102    ***
026200010103    1C                   IF        FKEY = F1
026300000102     C                   MOVEL(P)  'EXIT'        @STEP
026400000102     C                   LEAVESR
026500010103    1C                   ENDIF
026600000102    ***
026700010103    1C                   IF        FKEY = F6
026800000102     C                   MOVEL(P)  'STEP3'       @STEP
026900000102     C                   MOVE      'A'           @@A               1
027000000102     C                   LEAVESR
027100010103    1C                   ENDIF
027200000102    ***
027300010516     C                   IF        '1' = @1STLOOP
027400000102     C                   EXSR      $CHKSELC
027500000102    ***
027600010103    1C                   IF        @@A <> *BLANKS
027700000102     C                   MOVEL(P)  'STEP1'       @STEP
027800010103    1C                   ENDIF
027900010516     C                   ENDIF
028000000102    ***
028100000102     C                   ENDSR
028200000102   S***S
028300000102     C* DISPLAY THE SCREEN
028400000102    ***
028500000102     C     $DISPLAY      BEGSR
028600000102    ***
028700040723    ***
028800040723     C                   IF        #CNTREC = 0
028900040723     C                   MOVEL(P)  MSG(16)       S01MSG
029000040723     C                   MOVE      '1'           *IN20
029100040723     C                   ENDIF
029200040723    ***
029300000102     C                   WRITE     S01REC
029400000102     C                   EXFMT     S01CTL
029500000102     C*
029600000102     C                   MOVE      *BLANKS       S01MSG
029700000102    ***
029800000102     C                   ENDSR
029900000102   S***S
030000000102     C     $STEP3        BEGSR
030100000102    ***
030200000102     C                   MOVE      '0'           @VALID
030300000102     C                   MOVE      *BLANKS       R2CNAM
030400000102     C                   MOVE      *BLANKS       R2SZCD
030500010120     C                   MOVE      *ZEROS        R2FRDT
030600010120     C                   MOVE      *ZEROS        R2TODT
030700010120     C                   MOVE      *ZEROS        O_FRSZ
030800010120     C                   MOVE      *ZEROS        O_TOSZ
030900010120     C                   MOVE      *ZEROS        O_FRDT
031000010120     C                   MOVE      *ZEROS        O_TODT
031100060310     c**                 move      *blanks       scou50
031200000102     C                   MOVE      'STEP4'       @STEP
031300000102     C                   SETOFF                                       3090
031400000102    ***
031500000102     C                   ENDSR
031600000102   S***S
031700000102     C     $STEP4        BEGSR
031800000102    ***
031900000102     C                   EXFMT     S02R
032000000102     C                   MOVE      *BLANKS       R2MSG
032100000102    ***
032200010103    1C                   IF        FKEY = F1
032300000102     C                   MOVE      'STEP1'       @STEP
032400000102     C                   LEAVESR
032500010103    1C                   ENDIF
032600000102    ***
032700000102     C* F4 = MARKET SIZES INQUIRY
032800000102    1C                   IF        FKEY = F4
032900000102     C                   EXSR      $F4PROC
033000000102     C                   LEAVESR
033100000102    1C                   ENDIF
033200000102    ***
033300000102     C* F9 = CARRIERS INQUIRY
033400000102    1C                   IF        FKEY = F9
033500000102     C                   EXSR      $F9PROC
033600000102     C                   LEAVESR
033700000102    1C                   ENDIF
033800000102    ***
033900000102     C                   EXSR      $VALIDATE
034000000102    ***
034100010102    1C                   IF        @VALID = '0'
034200010102     C                   EXSR      $UPDATE
034300010102    2C                   IF        @@A = 'A'
034400010102     C                   MOVE      'STEP3'       @STEP
034500020222     C                   ELSE
034600020222     C                   MOVE      'STEP1'       @STEP
034700010102    2C                   ENDIF
034800010102    1C                   ENDIF
034900000102    ***
035000000102     C                   ENDSR
035100000102   S***S
035200000102     C     $F4PROC       BEGSR
035300000102    ***
035400000102     C                   EXSR      $VALIDATE
035500000102     C                   MOVE      *BLANKS       R2MSG
035600000102    ***
035700000102    1C                   IF        @VC = 'N'
035800010103     C                   MOVEL(P)  MSG(9)        R2MSG
035900000102     C                   LEAVESR
036000000102    1C                   ENDIF
036100000102    ***
036200000102     C                   MOVEL(P)  R2CARR        @P8               8
036300000102     C                   CALL      'FM005CL'
036400000102     C                   PARM                    @P8
036500000102    ***
036600000102     C     5             SUBST     @P8:4         @5                5
036700000102     C     3             SUBST     @P8:4         @3                3
036800000102    1C                   IF        @3 = '*LR'
036900010103     C                   MOVEL(P)  MSG(10)       R2MSG
037000000102     C                   LEAVESR
037100000102    1C                   ENDIF
037200000102    ***
037300000102     C                   MOVEL(P)  @5            R2SZCD
037400000102    ***
037500000102     C                   MOVEL(P)  R2CARR        MACARR
037600000102     C                   MOVEL(P)  @5            MASZCD
037700000102    ***
037800000102     C     CARKEY        CHAIN(N)  RCARMKSZ
037900000102    1C                   IF        %FOUND(CARMKSZ3)
038000010120     C                   Z-ADD     CZFRSZ        O_FRSZ
038100010120     C                   Z-ADD     CZTOSZ        O_TOSZ
038200000102     C                   ELSE
038300000102     C                   MOVEL(P)  MSG(1)        R2MSG
038400000102    1C                   ENDIF
038500000102    ***
038600000102     C                   ENDSR
038700000102   S***S
038800000102     C     $F9PROC       BEGSR
038900000102    ***
039000000102     C                   MOVE      *BLANKS       @3
039100000102     C                   MOVEL(P)  R2CARR        @3
039200010108     C                   CALL      'FM002CL'
039300000102     C                   PARM                    @3
039400000102    ***
039500000102    1C                   IF        @3 = '*LR'
039600010103     C                   MOVEL(P)  MSG(10)       R2MSG
039700000102     C                   LEAVESR
039800000102    1C                   ENDIF
039900000102    ***
040000000102     C                   MOVEL(P)  @3            R2CARR
040100000102    ***
040200000102     C     @3            CHAIN(N)  CARMSR
040300010103    1C                   IF        %FOUND(CARMST)
040400000102     C                   MOVEL(P)  CNAME         R2CNAM
040500010103    1C                   ELSE
040600000102     C                   MOVEL(P)  MSG(7)        R2MSG
040700010103     C                   MOVE      *BLANKS       R2CNAM
040800000102    1C                   ENDIF
040900000102    ***
041000000102     C                   ENDSR
041100000102   S***S
041200000102     C     $VALIDATE     BEGSR
041300000102    ***
041400010103     C                   MOVE      'N'           @VC               1
041500010102     C                   MOVE      '1'           @VALID            1
041600010120     C                   MOVE      *ZEROS        O_FRSZ
041700010120     C                   MOVE      *ZEROS        O_TOSZ
041800010120     C                   MOVE      *ZEROS        O_FRDT
041900010120     C                   MOVE      *ZEROS        O_TODT
042000010120    *** CARRIER CHECK
042100000102    1C                   IF        R2CARR = *BLANKS
042200000102     C                   MOVEL(P)  MSG(7)        R2MSG
042300010103     C                   MOVE      *BLANKS       R2CNAM
042400000102     C                   LEAVESR
042500000102    1C                   ENDIF
042600000102     C*
042700000102     C     R2CARR        CHAIN(N)  CARMSR
042800000102    1C                   IF        %FOUND(CARMST)
042900010102     C                   MOVEL(P)  CNAME         R2CNAM
043000000102    1C                   ELSE
043100000102     C                   MOVE      *BLANKS       R2CNAM
043200000102     C                   MOVEL(P)  MSG(7)        R2MSG
043300000102     C                   LEAVESR
043400000102    1C                   ENDIF
043500010102    ***
043600010102     C                   MOVE      'Y'           @VC
043700030501    *** allow override of groups under 50 check
043800060310    1c**                 if        scou50 = *BLANKS or (scou50 <> 'Y' and
043900060310     c**                           scou50 <> 'N')
044000060310     C**                 MOVEL(P)  MSG(15)       R2MSG
044100060310     C**                 LEAVESR
044200060310    1C**                 ENDIF
044300010120    *** SIZE CODE CHECK
044400010102    1C                   IF        R2SZCD = *BLANKS
044500010102     C                   MOVEL(P)  MSG(8)        R2MSG
044600010102     C                   LEAVESR
044700010102    1C                   ENDIF
044800011211    *** CARRIER MARKET SIZE MASTER
044900010102     C                   MOVEL(P)  R2CARR        MACARR
045000010102     C                   MOVEL(P)  R2SZCD        MASZCD
045100010102     C     CARKEY        CHAIN(N)  RCARMKSZ
045200010102    1C                   IF        %FOUND(CARMKSZ3)
045300010120     C                   Z-ADD     CZFRSZ        O_FRSZ
045400010120     C                   Z-ADD     CZTOSZ        O_TOSZ
045500010120     C                   MOVE      CZFRDT        #ISA
045600010120     C                   EXSR      $ISOUSA
045700010120     C                   Z-ADD     #ISA          O_FRDT
045800010120     C                   MOVE      CZTODT        #ISA
045900010120     C                   EXSR      $ISOUSA
046000010120     C                   Z-ADD     #ISA          O_TODT
046100010103    1C                   ELSE
046200010102     C                   MOVEL(P)  MSG(8)        R2MSG
046300010120     C                   LEAVESR
046400010102    1C                   ENDIF
046500010120    *** DATE CHECK
046600010120     C                   MOVE      *ZEROS        #FRISO
046700010120     C                   MOVE      R2FRDT        #ISA
046800010120     C                   EXSR      $USAISO
046900010120     C                   IF        @@GD = 'E'
047000010120     C                   MOVEL(P)  MSG(12)       R2MSG
047100010120     C                   LEAVESR
047200010120     C                   ELSE
047300010120     C                   MOVE      #ISA          #FRISO            8 0
047400010120     C                   ENDIF
047500010120     C*
047600010120     C                   MOVE      *ZEROS        #TOISO
047700010120     C                   IF        R2TODT <> 0
047800010120     C                   MOVE      R2TODT        #ISA
047900010120     C                   EXSR      $USAISO
048000010120     C                   IF        @@GD = 'E'
048100010120     C                   MOVEL(P)  MSG(13)       R2MSG
048200010120     C                   LEAVESR
048300010120     C                   ELSE
048400010120     C                   MOVE      #ISA          #TOISO            8 0
048500010120     C                   ENDIF
048600010120     C                   ENDIF
048700010120     C*
048800010120     C                   IF        #TOISO < #FRISO AND #TOISO  > 0
048900010120     C                   MOVEL(P)  MSG(13)       R2MSG
049000010120     C                   LEAVESR
049100010120     C                   ENDIF
049200010120    *** DUPE CHECK
049300011211    1C                   IF        (@@A = 'C' AND (R2CARR <> SFCARR OR
049400011211     C                             R2SZCD <> SFSZCD OR SFFRDT <> R2FRDT OR
049500011211     C                             SFTODT <> R2TODT)) OR @@A = 'A'
049600011211     C                   EXSR      $SPANCHK
049700011211    1C                   ENDIF
049800011211    1C                   IF        @@RECSTS = 'B'
049900011211     C                   LEAVESR
050000011211    1C                   ENDIF
050100010102    ***
050200010102     C                   MOVE      '0'           @VALID
050300000102    ***
050400000102     C                   ENDSR
050500010120   S***S
050600011211     C     $SPANCHK      BEGSR
050700010120    ***
050800011211     C                   Z-ADD     I_TRST        KEY@TRS
050900011211     C                   Z-ADD     I_SUB#        KEY@SUB
051000011211     C                   Z-ADD     I_ACCT        KEY@ACC
051100011211     C                   MOVEL(P)  R2CARR        KEY@CAR
051200011211     C                   MOVEL(P)  R2SZCD        KEY@SZC
051300011211     C                   Z-ADD     #FRISO        #FRDT
051400011211     C                   Z-ADD     #TOISO        #TODT
051500011211     C                   MOVE      'B'           @@RECSTS          1
051600011211    ***
051700011211    1C                   IF        #FRDT = #TODT
051800011211     C                   MOVE      'G'           @@RECSTS
051900011211     C                   LEAVESR
052000011211    1C                   ENDIF
052100011211    ***
052200011211    1C                   IF        #TODT = 0
052300011211     C                   Z-ADD     99999999      #TODT
052400011211    1C                   ENDIF
052500011211    ***
052600011211     C     KEY#MC2       SETLL     MKC2
052700011211    1C                   DOU       %EOF(MKTCARA2)
052800011211     C     KEY#MC2       READE     MKC2
052900020222    2C                   IF        NOT %EOF(MKTCARA2) AND (ZZFRDT <> HFRISO
053000020222     C                             OR ZZTODT <> HTOISO)
053100011211    ***
053200011211    3C                   IF        ZZTODT = 0
053300011211     C                   Z-ADD     99999999      ZZTODT
053400011211    3C                   ENDIF
053500011211    ***
053600020221    3C                   IF        #FRDT  = ZZFRDT AND #TODT  = ZZTODT
053700020221     C                   MOVEL(P)  MSG(11)       R2MSG
053800020221     C                   LEAVESR
053900020221    3C                   ENDIF
054000020221    3C                   IF        (#FRDT < ZZFRDT AND #TODT < ZZFRDT) OR
054100020221    3C                             (#FRDT > ZZTODT AND #TODT > ZZTODT)
054200020221     C                   ITER
054300020221     C                   ELSE
054400020221     C                   MOVEL(P)  MSG(14)       R2MSG
054500020221     C                   LEAVESR
054600020221    3C                   ENDIF
054700020221    ***
054800020221    3C*                  SELECT
054900020221    3C*                  WHEN      #FRDT  = ZZFRDT AND #TODT  = ZZTODT
055000020221    *C*                  MOVEL(P)  MSG(11)       R2MSG
055100020221    *C*                  LEAVESR
055200020221    3C*                  WHEN      #FRDT <= ZZFRDT AND #TODT >  ZZTODT
055300020221    *C*                  MOVEL(P)  MSG(14)       R2MSG
055400020221    *C*                  LEAVESR
055500020221    3C*                  WHEN      #FRDT <  ZZFRDT AND #TODT >  ZZFRDT AND
055600020221    *C*                            #TODT <  ZZTODT
055700020221    *C*                  MOVEL(P)  MSG(15)       R2MSG
055800020221    *C*                  LEAVESR
055900020221    3C*                  WHEN      #FRDT >   ZZFRDT AND #TODT =  ZZTODT
056000020221    *C*                  MOVEL(P)  MSG(15)       R2MSG
056100020221    *C*                  LEAVESR
056200020221    3C*                  WHEN      #FRDT <   ZZFRDT AND #TODT =  ZZTODT
056300020221    *C*                  MOVEL(P)  MSG(15)       R2MSG
056400020221    *C*                  LEAVESR
056500020221    3C*                  WHEN      #FRDT >  ZZFRDT AND #FRDT <  ZZTODT
056600020221    *C**                           #TODT >  ZZTODT
056700020221    *C*                  MOVEL(P)  MSG(16)       R2MSG
056800020221    *C*                  LEAVESR
056900020221    3C*                  WHEN      #FRDT >  ZZFRDT AND #FRDT <  ZZTODT AND
057000020221    *C*                            #TODT <  ZZTODT
057100020221    *C*                  MOVEL(P)  MSG(17)       R2MSG
057200020221    *C*                  LEAVESR
057300020221    3C*                  ENDSL
057400020221    ***
057500020221    2C                   ENDIF
057600020221    1C                   ENDDO
057700020221    ***
057800020221     C                   MOVE      'G'           @@RECSTS
057900011211    ***
058000011211     C                   ENDSR
058100011211   S***S
058200011211     C     $USAISO       BEGSR
058300011211    ***
058400010120     C                   MOVE      'E'           @@GD              1
058500010120    1C                   IF        #ISA <> 0
058600010120     C     *USA          TEST (DE)               #ISA
058700010120    2C                   IF        NOT %ERROR
058800010120     C                   MOVE      #ISA          #USA
058900010120     C                   MOVE      #USA          #ISO
059000010120     C                   MOVE      #ISO          #ISA
059100010120     C                   MOVE      'G'           @@GD
059200010120    2C                   ELSE
059300010120     C                   MOVE      *ZEROS        #ISA
059400010120    2C                   ENDIF
059500010120    1C                   ELSE
059600010120     C                   MOVE      *ZEROS        #ISA
059700010120    1C                   ENDIF
059800010120    ***
059900010120     C                   ENDSR
060000010102   S***S
060100010102     C     $UPDATE       BEGSR
060200010102    ***
060300010103    1C                   IF        @@A = 'A'
060400010102     C                   CLEAR                   RMKTCARA
060500010102     C                   Z-ADD     I_TRST        MATRST
060600010103     C                   Z-ADD     I_SUB#        MASUB#
060700010103     C                   Z-ADD     I_ACCT        MAACC#
060800010103     C                   MOVEL     R2CARR        MACARR
060900010103     C                   MOVEL     R2SZCD        MASZCD
061000010120     C                   Z-ADD     #FRISO        MAFRDT
061100010120     C                   Z-ADD     #TOISO        MATODT
061200060310     c**                 move      scou50        maou50
061300010103     C                   WRITE     RMKTCARA
061400011211     C                   FEOD      MKTCARA1
061500010103     C                   LEAVESR
061600010103    1C                   ENDIF
061700010103    ***
061800010103    1C                   IF        @@A = 'C'
061900010120    2C                   IF        R2CARR <> SFCARR OR R2SZCD <> SFSZCD OR
062000060310     c**                           scou50 <> sfaou50 or
062100060310     C                             R2FRDT <> SFFRDT OR R2TODT <> SFTODT
062200010129     C                   MOVEL(P)  SFCARR        @KC
062300010129     C                   MOVE      HFRISO        #8F
062400010129     C                   MOVE      HTOISO        #8T
062500010129     C                   MOVEL     SFSZCD        @SZ
062600010129     C     MCKEY         CHAIN     RMKTCARA
062700010103     C                   MOVEL     R2CARR        MACARR
062800010103     C                   MOVEL     R2SZCD        MASZCD
062900010120     C                   Z-ADD     #FRISO        MAFRDT
063000010120     C                   Z-ADD     #TOISO        MATODT
063100060310     c**                 move      scou50        maou50
063200010103     C                   UPDATE    RMKTCARA
063300011211     C                   FEOD      MKTCARA1
063400010103     C                   LEAVESR
063500010109    2C                   ENDIF
063600010103    1C                   ENDIF
063700010103    ***
063800010103     C                   ENDSR
063900010103   S***S
064000010103     C* CHECK SUBFILE SELECTION
064100010103    ***
064200010103     C     $CHKSELC      BEGSR
064300010103    ***
064400010103     C                   MOVE      'N'           @@AD              1
064500010103    1C                   DOU       %EOF(FM063D)
064600010103     C                   READC     S01SFL
064700020221    2C                   IF        NOT %EOF(FM063D) AND SEL = 'C'
064800010103     C*
064900010103     C                   EXSR      $CHGCTL
065000010103     C*
065100010103    3C                   IF        S01MSG <> *BLANKS
065200010103     C                   LEAVESR
065300010103    3C                   ENDIF
065400010103     C*
065500010103     C                   MOVE      *BLANKS       SEL
065600010103     C                   UPDATE    S01SFL
065700010103     C                   MOVE      'Y'           @@AD
065800010103     C*
065900010103    2C                   ENDIF
066000010103    1C                   ENDDO
066100020221    ***
066200020221     C                   MOVEL(P)  'STEP1'       @STEP
066300010103    ***
066400010103     C                   ENDSR
066500010103   S***S
066600010103     C* CHANGE CONTROL ROUTINE
066700010103    ***
066800010103     C     $CHGCTL       BEGSR
066900010103    ***
067000010103     C                   MOVE      'C'           @@A                            ACTION TYPE
067100010103     C                   MOVE      *OFF          *IN30
067200010103     C                   EXSR      $LOADNLOCK
067300010103     C*
067400010103    1C                   IF        S01MSG <> *BLANKS
067500010103     C                   LEAVESR
067600010103    1C                   ENDIF
067700010103    ***
067800010103     C                   MOVE      '0'           @@E               1
067900010103     C                   MOVEL(P)  @STEP         @@STP
068000010103    1C                   DOU       @@E = '1'
068100010103     C*
068200010103     C                   EXSR      $STEP4
068300010103     C*
068400010103    2C                   IF        @STEP = 'STEP1'
068500010103     C                   MOVEL(P)  @@STP         @STEP
068600010103     C                   MOVE      '1'           @@E
068700020222     C                   LEAVE
068800010103    2C                   ENDIF
068900010103     C*
069000010103    1C                   ENDDO
069100010103    ***
069200010103     C                   ENDSR
069300010103   S***S
069400010103     C* LOAD SCREEN 2 W/O LOCKING REC
069500010103    ***
069600010103     C     $LOADNLOCK    BEGSR
069700010103    ***
069800010103     C                   MOVEL(P)  SFCARR        R2CARR
069900010103     C     R2CARR        CHAIN(N)  CARMSR
070000010103    1C                   IF        %FOUND(CARMST)
070100010103     C                   MOVEL(P)  CNAME         R2CNAM
070200010103     C                   ELSE
070300010103     C                   MOVE      *BLANKS       R2CNAM
070400010103     C                   MOVEL(P)  MSG(7)        R2MSG
070500010103    1C                   ENDIF
070600010103    ***
070700010120     C                   Z-ADD     SFFRSZ        O_FRSZ
070800010120     C                   Z-ADD     SFTOSZ        O_TOSZ
070900010120     C                   Z-ADD     SFFRDT        R2FRDT
071000010120     C                   Z-ADD     SFTODT        R2TODT
071100010103     C                   MOVEL(P)  SFCARR        @3
071200010117     C                   MOVEL(P)  SFCARR        @KC
071300060310     c**                 move      sfaou50       scou50
071400010120     C                   MOVE      HFRISO        #8F
071500010120     C                   MOVE      HTOISO        #8T
071600010120     C                   MOVEL     SFSZCD        @SZ
071700010103     C     MCKEY         CHAIN     RMKTCARA
071800010103    ***
071900010109     C                   MOVEL(P)  SFSZCD        R2SZCD
072000010103     C     CARKEY        CHAIN(N)  RCARMKSZ
072100010103    1C                   IF        %FOUND(CARMKSZ3)
072200010314     C                   Z-ADD     CZFRSZ        O_FRSZ
072300010314     C                   Z-ADD     CZTOSZ        O_TOSZ
072400010314     C                   MOVE      CZFRDT        #ISA
072500010314     C                   EXSR      $ISOUSA
072600010314     C                   Z-ADD     #ISA          O_FRDT
072700010314     C                   MOVE      CZTODT        #ISA
072800010314     C                   EXSR      $ISOUSA
072900010314     C                   Z-ADD     #ISA          O_TODT
073000010103    1C                   ELSE
073100010314     C                   MOVE      *ZEROS        O_FRSZ
073200010314     C                   MOVE      *ZEROS        O_TOSZ
073300010120     C                   MOVE      *ZEROS        O_FRDT
073400010120     C                   MOVE      *ZEROS        O_TODT
073500010103     C                   MOVEL(P)  MSG(8)        R2MSG
073600010103    1C                   ENDIF
073700010103    ***
073800010103     C                   ENDSR
073900010103   S***S
074000000102   X***X
074100000102123456*8901234567890123456789012345678901234567890
074200000102      *  11111111112222222222333333333344444444445
074300000102** CTDATA MSG
074400010103SOME SIZE CODES FAILED TO MATCH CARRIER SIZE FILE
074500010103PRESS F16 AGAIN TO DELETE OR F1 TO CANCEL
074600010103RECORD DELETED
074700010103RECORD DELETION CANCELED
074800010103F4 NOT AVAILABLE IN DELETE MODE
074900010103F9 NOT AVAILABLE IN DELETE MODE
075000010103CARRIER IS INVALID OR BLANK
075100010103SIZE CODE IS INVALID OR BLANK
075200010103F4 REQUIRES A VALID CARRIER
075300010103NO SELECTION MADE
075400010103CARRIER ALREADY EXISTS FOR THIS ACCOUNT
075500010120FROM DATE IS INVALID OR ZERO; MMDDCCYY FORMAT ONLY
075600010120TO DATE IS INVALID; MMDDCCYY FORMAT OR ZERO ONLY
075700011211OVERLAP FR/TO DT WITHIN ANOTHER RANGE
075800030501OVERRIDE VALUE MUST BE Y OR N
075900040723ALL CARRIERS 2 TO 50
