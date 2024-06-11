000100110401    *** MARKETING DIARY NOTE GENERIC
000200020308    ***
000300110401    *** 04.01.2011.SSK.ORIGINAL SOURCE
000400020308    ***
000500020308    ***
000600020308    ***
000700020308    ***
000800020308    ***
000900020308    ***
001000020308    ***
001100020308    ***
001200110401     FMDD011    CF   E             WORKSTN SFILE(S01SFL:RRT) INFDS(WSDS)
001300110412    ***
001400110401     FMKTDIARYD0UF A E           K DISK
001500020108     ** HISTORY DIARY FILE - DETAIL
001600110401     FMKTDIARYH0UF A E           K DISK
001700020108     ** HISTORY DIARY FILE - HEADER
001800020227     FGBSECURE  IF   E           K DISK
001900020227     ** USER SECURITY FILE
002000010508   X***X
002100010508     D WSDS            DS
002200010508     D  FKEY                 369    369A
002300010508    ***
002400110415     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
002500110415     D                UDS
002600110415     D  TITLE                201    240
002700110415   X***X
002800010508     D  F1             C                   CONST(X'31')
002900010508     D  F2             C                   CONST(X'32')
003000010508     D  F3             C                   CONST(X'33')
003100010508     D  F4             C                   CONST(X'34')
003200010508     D  F5             C                   CONST(X'35')
003300010508     D  F6             C                   CONST(X'36')
003400010508     D  F7             C                   CONST(X'37')
003500010508     D  F8             C                   CONST(X'38')
003600010508     D  F9             C                   CONST(X'39')
003700010508     D  F10            C                   CONST(X'3A')
003800010508     D  F11            C                   CONST(X'3B')
003900010508     D  F12            C                   CONST(X'3C')
004000010508     D  F13            C                   CONST(X'B1')
004100010508     D  F14            C                   CONST(X'B2')
004200010508     D  F15            C                   CONST(X'B3')
004300010508     D  F16            C                   CONST(X'B4')
004400010508     D  F17            C                   CONST(X'B5')
004500010508     D  F18            C                   CONST(X'B6')
004600010508     D  F19            C                   CONST(X'B7')
004700010508     D  F20            C                   CONST(X'B8')
004800010508     D  F21            C                   CONST(X'B9')
004900010508     D  F22            C                   CONST(X'BA')
005000010508     D  F23            C                   CONST(X'BB')
005100010508     D  F24            C                   CONST(X'BC')
005200011228     D  ROLLDN         C                   CONST(X'F4')
005300011228     D  ROLLUP         C                   CONST(X'F5')
005400121011    ***
005500121011    ?D WUICOD        E DS                  EXTNAME(CODE20P) PREFIX(ZZZ:3)
005600121011     D WIRQS           S              8A
005700121011     D WORTN           S              8A
005800121011     D WUPGM           S             10A
005900020103    ***
006000020103     D @@APS           C                   CONST('''')
006100110415     D @46             S             46A   INZ
006200110415     D @3              S              3A   INZ
006300110415     D @@CODE          S             10A   INZ
006400110415     D @@SDESCR        S             50A   INZ
006500110415     D @@TITLE         S             50A   INZ
006600110412    ***
006700110412     D DS@70           DS
006800110412     D  D70@                         70A   DIM(100)
006900110415     D  CLR@                   1   7000A   INZ
007000110412     D X               S              3S 0 INZ
007100110412     D C               S              3S 0 INZ
007200010509    ***
007300110415     D @CTL            S              3A   INZ
007400110415     D @@VC            S              1A   INZ
007500011228    ***
007600110415     D DES@SDS         S             10A   INZ
007700110415     D DES@LDS         S             50A   INZ
007800110415    ***                                    INZ
007900110415     D #CNTREC         S              4S 0 INZ
008000110415     D #ISO            S               D   DATFMT(*ISO)
008100020102     D #USA            S               D   DATFMT(*USA)
008200110415     D #USO            S              8S 0 INZ
008300110415     D #ISA            S              8S 0 INZ
008400110415     D @103            S            103A   INZ
008500110415     D @14             S             14A   INZ
008600110415     D #14             S             14S 0 INZ
008700110415     D @6              S              6A   INZ
008800110415     D @8              S              8A   INZ
008900110415     D #8              S              8S 0 INZ
009000110415     D @UPD            S              1A   INZ
009100011228    ***
009200011228     D @MSG            S                   LIKE(S01MSG)
009300010508    ***
009400010508     D @STEP           S              5A
009500040106      *
009600040106    *** TIMESTAMP FIELDS DATA STRUCTURE
009700040106      *
009800040106     D @TIMESTAMP      DS
009900040106     D  #TSCYMD                1      8S 0
010000040106     D  #TSTIME                9     14S 0
010100040106     D  @TSJOB                15     24
010200040106     D  @TSUSER               25     34
010300040106     D  #TSNBR                35     40S 0
010400040106    * *
010500040106     D @TS40           S             40A
010600040106    ***
010700110412    ***
010800110412    *** @PARMOUT: POS 001-003 CONTROL VALUE
010900110412    ***               004-033 KEY VALUES 004-006 SMAN
011000110412    ***                                  007-009 AGENCY
011100110412    ***                                  010-012 SUPER
011200110412    ***                                  013-020 RELID
011300110412    ***                                  021-028 LINKID
011400110412    ***                                  029-033 GROUPER
011500110412    ***               034-073 DESCRIPTION
011600110412    ***               074-088 UNIQUE KEY
011700110412    ***               089-089 '*' FOR PARM INTEGRITY
011800110412    ***
011900110412     D @PARMOUT        S             89A
012000110412     D @89             S             89A   INZ
012100110412     D KF@UNIQ         S             15A   INZ
012200110412    ***
012300010508   X***X
012400010508     C* MAINLINE
012500010508    ***
012600110412     C                   MOVE      'PREP1'       @STEP
012700011228     C     *ENTRY        PLIST
012800110412     C                   PARM                    @PARMOUT
012900110412     C                   EVAL      @89 = @PARMOUT
013000040106    ***
013100110412     C                   DOU       @STEP = 'LEAVE'
013200110412     C     @STEP         CASEQ     'PREP1'       $PREP1
013300110412     C     @STEP         CASEQ     'STEP1'       $STEP1
013400110412     C     @STEP         CASEQ     'STEP2'       $STEP2
013500110412     C     @STEP         CASEQ     'STEP3'       $STEP3
013600110412     C                   ENDCS
013700110412     C                   ENDDO
013800110412    ***
013900110412     C                   MOVE      *ON           *INLR
014000110412     C                   RETURN
014100110412   S***S
014200110412     C     $PREP1        BEGSR
014300110412    ***
014400110412     C                   MOVE      *BLANKS       @ACTION           1
014500110412     C                   MOVE      *ZEROS        RRT               4 0
014600110412     C                   MOVE      *ZEROS        #CNTREC           4 0
014700110412     C                   MOVE      '0'           @1STLOOP          1
014800110412     C                   EVAL      @CTL = %SUBST(@89:1:3)
014900110412     C                   EXSR      $CLEAR
015000110412    ***
015100110412     C                   EVAL      @@DESC = %SUBST(@89:34:40)
015200110412    ***
015300110412     C                   SELECT
015400110412      *
015500110412     C                   WHEN      @CTL = '000'
015600110412     C                   MOVEA     '000'         *IN(35)
015700110412     C                   EVAL      I_SMAN = %SUBST(@89:4:3)
015800110412      *
015900110412     C                   WHEN      @CTL = '001'
016000110412     C                   MOVEA     '001'         *IN(35)
016100110412     C                   EVAL      I_AGENCY = %SUBST(@89:7:3)
016200110412      *
016300110412     C                   WHEN      @CTL = '010'
016400110412     C                   MOVEA     '010'         *IN(35)
016500110412     C                   EVAL      I_SUPER  = %SUBST(@89:10:3)
016600110412      *
016700110412     C                   WHEN      @CTL = '011'
016800110412     C                   MOVEA     '011'         *IN(35)
016900110412     C                   EVAL      I_LINKID = %SUBST(@89:21:8)
017000110412      *
017100110412     C                   WHEN      @CTL = '100'
017200110412     C                   MOVEA     '100'         *IN(35)
017300110412     C                   EVAL      I_RELID  = %SUBST(@89:13:8)
017400110412      *
017500110412     C                   WHEN      @CTL = '101'
017600110412     C                   MOVEA     '101'         *IN(35)
017700110412     C                   EVAL      I_GROUPER = %SUBST(@89:29:5)
017800110412      *
017900110412     C                   ENDSL
018000110412    ***
018100110412     C                   IF        %SUBST(@89:74:15) = 'ADDADDADDADDADD'
018200110412     C                   MOVE      'STEP2'       @STEP
018300110412     C                   ELSE
018400110412     C                   EVAL      KF@UNIQ = %SUBST(@89:74:15)
018500110412     C                   MOVE      'STEP1'       @STEP
018600110412     C                   LEAVESR
018700110412     C                   ENDIF
018800110412    ***
018900110415     C                   CLEAR                   MKTDR
019000110415     C                   CLEAR                   MKTHR
019100110415    ***
019200110412     c                   clear                   @timestamp
019300110412     C                   MOVE      *BLANKS       @TS40
019400110412    ***
019500110412     C                   CALL      'TIMESTMP'
019600110412     C                   PARM                    @TS40
019700110412    ***
019800110412     C                   MOVEL     @TS40         @TIMESTAMP
019900110412    ***
020000110415     C                   EVAL      MHADDT = #TSCYMD
020100110415     C                   EVAL      MHADTI = #TSTIME
020200110415     C                   EVAL      MHADJOB = @TSJOB
020300110415     C                   EVAL      MHADUSER = @TSUSER
020400110415     C                   MOVE      #TSNBR        MHADNBR
020500110415    ***
020600110415     C                   EVAL      O_ADUDT = %TRIM(MHADJOB) + '/' +
020700110415     C                             %TRIM(MHADUSER) + '/' +
020800110415     C                             %TRIM(MHADNBR) + '; ' +
020900110415     C                             %EDITW(MHADDT:'0   /  /  ') + ' ' +
021000110415     C                             %EDITW(MHADTI:'0 :  :  ')
021100110415    ***
021200110412     C                   ENDSR
021300110412   S***S
021400110412     C     $STEP1        BEGSR
021500110415    ***
021600110412     C                   MOVE      *OFF          *IN41
021700110412     C                   MOVE      *ON           *IN40
021800110412     C                   MOVE      *ZEROS        #CNTREC
021900110412     C                   MOVE      '0'           @1STLOOP
022000110412    ***
022100110412     C     KF@UNIQ       CHAIN     MKTHR
022200110415    ***
022300110415     C                   EVAL      O_ADUDT = %TRIM(MHADJOB) + '/' +
022400110415     C                             %TRIM(MHADUSER) + '/' +
022500110415     C                             %TRIM(MHADNBR) + '; ' +
022600110415     C                             %EDITW(MHADDT:'0   /  /  ') + ' ' +
022700110415     C                             %EDITW(MHADTI:'0 :  :  ')
022800110412    ***
022900110415     C                   EVAL      SCCODE = MHCODE
023000110415     C                   EVAL      SCSUBJ = MHSUBJ
023100110415    ***
023200110412     C     KF@UNIQ       SETLL     MKTDR
023300110412    1C                   DOU       %EOF(MKTDIARYD0)
023400110412     C     KF@UNIQ       READE     MKTDR
023500110412    2C                   IF        NOT %EOF(MKTDIARYD0)
023600110412     C                   EXSR      $LOADSFL
023700110412    2C                   ENDIF
023800110412    1C                   ENDDO
023900110412    ***
024000110412    1C                   DOU       FKEY = F12
024100110412    ***
024200110412     C                   EXSR      $DISPLAY
024300110412    ***
024400110412    2C                   IF        FKEY = F12
024500110412     C                   MOVE      'LEAVE'       @STEP
024600110412     C                   LEAVESR
024700110412    2C                   ENDIF
024800110412    ***
024900110412    1C                   ENDDO
025000110412    ***
025100110412     C                   ENDSR
025200110412   S***S
025300110412     C     $CLEAR        BEGSR
025400110412    ***
025500110412     C                   MOVEA     '011'         *IN(25)
025600110412     C                   WRITE     S01CTL
025700110412     C                   MOVEA     '010'         *IN(25)
025800110412     C                   Z-ADD     *ZERO         RRT
025900110412    ***
026000110412     C                   ENDSR
026100110412   S***S
026200110412     C* DISPLAY THE SCREEN
026300110412    ***
026400110412     C     $DISPLAY      BEGSR
026500110412    ***
026600110412     C                   MOVEL(P)  @MSG          S01MSG
026700110412     C                   WRITE     S01REC
026800110412     C                   EXFMT     S01CTL
026900110412     C                   MOVE      *BLANKS       @MSG
027000110412    ***
027100110412     C                   ENDSR
027200110412   S***S
027300110412     C     $LOADSFL      BEGSR
027400110412    ***
027500110412     C                   MOVE      *ON           *IN25
027600110412     C                   ADD       1             #CNTREC
027700110412     C                   MOVEL(P)  MDTEXT        SFTEXT
027800110412     C                   MOVEL(P)  MDTEXT        HTEXT
027900110412     C*
028000110412     C                   ADD       1             RRT
028100110412     C*
028200110412     C                   IF        @1STLOOP = '0'
028300110412     C                   Z-ADD     RRT           SFLPOS
028400110412     C                   MOVE      '1'           @1STLOOP
028500110412     C                   ENDIF
028600110412     C*
028700110412     C                   WRITE     S01SFL
028800110412    ***
028900110412     C                   ENDSR
029000110412   S***S
029100110412     C     $STEP2        BEGSR
029200110412    ***
029300110412     C                   EVAL      MHSMAN = %SUBST(@89:4:3)
029400110412     C                   EVAL      MHAGENCY = %SUBST(@89:7:3)
029500110412     C                   EVAL      MHSUPER  = %SUBST(@89:10:3)
029600110412     C                   EVAL      MHLINKID = %SUBST(@89:21:8)
029700110412     C                   EVAL      MHRELID  = %SUBST(@89:13:8)
029800110412     C                   EVAL      MHGROUPER = %SUBST(@89:29:5)
029900110412    ***
030000110412     C                   EXSR      $GEN100
030100110412    ***
030200110412     C                   MOVE      'STEP3'       @STEP
030300110412    ***
030400110412     C                   ENDSR
030500110412   S***S
030600110412     C     $GEN100       BEGSR
030700110412    ***
030800110415     C                   DOU       #CNTREC >= 100
030900110415     C*
031000110412     C                   MOVE      *ON           *IN25
031100110412     C                   ADD       1             #CNTREC
031200110412     C                   MOVE      *BLANKS       SFTEXT
031300110412     C                   MOVE      *BLANKS       HTEXT
031400110412     C*
031500110412     C                   ADD       1             RRT
031600110412     C*
031700110412     C                   IF        @1STLOOP = '0'
031800110412     C                   Z-ADD     RRT           SFLPOS
031900110412     C                   MOVE      '1'           @1STLOOP
032000110412     C                   ENDIF
032100110412     C*
032200110412     C                   WRITE     S01SFL
032300110415     C*
032400110415     C                   ENDDO
032500110412    ***
032600110412     C                   ENDSR
032700110412   S***S
032800110412     C     $STEP3        BEGSR
032900110412    ***
033000110412     C                   EXSR      $DISPLAY
033100110412    ***
033200110412     C                   IF        FKEY = F12
033300110412     C                   MOVE      'LEAVE'       @STEP
033400110412     C                   LEAVESR
033500110412     C                   ENDIF
033600121011    ***
033700121011     C                   IF        FKEY = F4
033800121011     C                   IF        %SUBST(@89:74:15) = 'ADDADDADDADDADD'
033900121011     C                   EVAL      WIRQS = 'LOAD'
034000121011     C                   EVAL      WORTN = *BLANKS
034100121011     C                   EVAL      WUPGM = 'MDR011'
034200121011     C                   EVAL      ZZZTYPE = 'MKTDIARY  '
034300121011     C                   CALL      'SLCC20'
034400121011    ?C                   Parm                    WIRQS
034500121011    ?C                   Parm                    WORTN
034600121011    ?C                   Parm                    WUPGM
034700121011    ?C                   Parm                    WUICOD
034800121011     C                   EVAL      SCCODE = %SUBST(ZZZCODE:1:10)
034900121011     C                   ELSE
035000121011     C                   EVAL      @MSG = 'CANNOT CHANGE CODE ONCE SET'
035100121011    1C                   ENDIF
035200121011     C                   LEAVESR
035300121011    1C                   ENDIF
035400110412    ***
035500110412     C                   EXSR      $VALIDATE
035600110412     C                   IF        @VALID = 'N'
035700110412     C                   LEAVESR
035800110412    1C                   ENDIF
035900110412    ***
036000110412    1C                   IF        FKEY = F9
036100110412     C                   EXSR      $UPDRTN
036200110412     C                   EXSR      $CLEAR
036300110412     C                   MOVE      'LEAVE'       @STEP
036400110412    1C                   ENDIF
036500110412    ***
036600110412     C                   ENDSR
036700110412   S***S
036800110412     C     $VALIDATE     BEGSR
036900110412    ***
037000110412     C                   MOVE      'N'           @VALID            1
037100110412    ***
037200110412     C                   IF        SCCODE = *BLANKS
037300110412     C                   EVAL      @MSG = 'CODE CANNOT BE BLANK; USE F4 FOR +
037400110412     C                             SELECTIONS'
037500110412     C                   LEAVESR
037600110412    1C                   ENDIF
037700110412    ***
037800110412     C*                  EXSR      $CHKCODE
037900110412     C*                  IF        @@VC = 'N'
038000110412     C*                  EVAL      @MSG = 'ENTER A VALID CODE; USE F4 FOR +
038100110412     C*                            SELECTIONS'
038200110412     C*                  LEAVESR
038300110412    1C*                  ENDIF
038400110412     C*                  MOVEL     DES@LDS       O_SDESCR
038500110412    ***
038600110412     C                   IF        SCSUBJ = *BLANKS
038700110412     C                   EVAL      @MSG = 'SUBJECT TITLE IS REQUIRED'
038800110412     C                   LEAVESR
038900110412    1C                   ENDIF
039000110412    ***
039100110412    *** PULL SFL TO DS@
039200110412    ***
039300110412     C                   EVAL      X = 0
039400110412     C                   CLEAR                   D70@
039500110412     C                   EVAL      C = 0
039600110412     C                   DO        100
039700110412     C                   ADD       1             X
039800110412     C     X             CHAIN     S01SFL
039900110412     C                   IF        %FOUND
040000110412     C                   IF        SFTEXT <> *BLANKS
040100110412     C                   ADD       1             C
040200110412     C                   EVAL      D70@(C) = SFTEXT
040300110412     C                   ENDIF
040400110412     C                   ENDIF
040500110412     C                   ENDDO
040600110412    ***
040700110412     C                   IF        C = 0
040800110412     C                   EVAL      @MSG = 'NOTE TEXT NOT DETECTED, NEED SOME'
040900110412     C                   LEAVESR
041000110412    1C                   ENDIF
041100110412    ***
041200110412    ***
041300110412     C                   MOVE      'Y'           @VALID
041400110412    ***
041500110412     C                   ENDSR
041600110412   S***S
041700110412     C     $UPDRTN       BEGSR
041800110412    ***
041900110412     C                   EXSR      $NEXTNBR
042000110412     C                   MOVE      #U            MHUNIQUE
042100110412     C                   MOVE      #U            MDUNIQUE
042200110415     C                   EVAL      MHCODE = SCCODE
042300110415     C                   EVAL      MHSUBJ = SCSUBJ
042400110412     C                   WRITE     MKTHR
042500110412    ***
042600110412     C                   EVAL      X = 0
042700110412     C                   DO        C
042800110412     C                   ADD       1             X
042900110412     C                   EVAL      MDSEQ = X
043000110415     C                   EVAL      MDTEXT = D70@(X)
043100110415     C                   WRITE     MKTDR
043200110412     C                   ENDDO
043300110412    ***
043400110412     C                   ENDSR
043500110412   S***S
043600110412     C     $NEXTNBR      BEGSR
043700110412    *C     *DTAARA       DEFINE    UNIQMKTDRY    #UNIQ            15 0
043800110412    *C     *LOCK         IN        #UNIQ
043900110412    *C     1             ADD       #UNIQ         #U               15 0
044000110412    *C                   MOVE      #U            #UNIQ
044100110412    *C                   OUT       #UNIQ
044200110412     C                   ENDSR
044300110412   S***S
044400110412    ***
044500110412    ***
