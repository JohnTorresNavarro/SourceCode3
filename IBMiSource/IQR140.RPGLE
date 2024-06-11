000100010823    ***
000200090105    *** AGENCY MASTER INQUIRY
000300090105    *** 01.02.2007 SSK COPIED FROM FM120R
000400090105    ***
000500090105    ***
000600040708     FIQR140D   CF   E             WORKSTN INFDS(WSDS)
000700001201     F                                     SFILE(S03SFL:RR3)
000800001201     FAGENL1    IF   E           K DISK    PREFIX(I:1) RENAME(AGENR:AGL1)
000900040102     FAGENCY    IF   E           K DISK
001000090105     FMKTSTSP   IF   E           K DISK
001100090105     FIRMMSTP   IF   E           K DISK
001200090105     FAGCYRMG0  IF   E           K DISK
001300060322     FRMGRMST0  IF   E           K DISK
001400001201   X***X
001500001201     D                UDS
001600001201     D  CONAME               201    240
001700001201     ***
001800001201     D WSDS            DS
001900001201     D  FKEY                 369    369A
002000001201     ***
002100001201     D  F1             C                   CONST(X'31')
002200001201     D  F2             C                   CONST(X'32')
002300001201     D  F3             C                   CONST(X'33')
002400001201     D  F4             C                   CONST(X'34')
002500001201     D  F5             C                   CONST(X'35')
002600001201     D  F6             C                   CONST(X'36')
002700001201     D  F7             C                   CONST(X'37')
002800001201     D  F8             C                   CONST(X'38')
002900001201     D  F9             C                   CONST(X'39')
003000001201     D  F10            C                   CONST(X'3A')
003100001201     D  F11            C                   CONST(X'3B')
003200001201     D  F12            C                   CONST(X'3C')
003300001201     D  F13            C                   CONST(X'B1')
003400001201     D  F14            C                   CONST(X'B2')
003500001201     D  F15            C                   CONST(X'B3')
003600001201     D  F16            C                   CONST(X'B4')
003700001201     D  F17            C                   CONST(X'B5')
003800001201     D  F18            C                   CONST(X'B6')
003900001201     D  F19            C                   CONST(X'B7')
004000001201     D  F20            C                   CONST(X'B8')
004100001201     D  F21            C                   CONST(X'B9')
004200001201     D  F22            C                   CONST(X'BA')
004300001201     D  F23            C                   CONST(X'BB')
004400001201     D  F24            C                   CONST(X'BC')
004500001201     ***
004600040102     **
004700040102     D #ISO            S               D   DATFMT(*ISO)
004800040102     D #USA            S               D   DATFMT(*USA)
004900040102    ***
005000090105     D DS@IRM        E DS                  EXTNAME(IRMMSTP)
005100090105     D  IMTXT1                 2     41A
005200090105     D  IMTXT2                42     81A
005300090105    ***
005400001201   X***X
005500001201     C                   DOU       @STEP = 'EXIT'
005600001201     C     @STEP         CASEQ     'STEP1'       $STEP1
005700001201     C     @STEP         CASEQ     'STEP2'       $STEP2
005800001201     C     @STEP         CASEQ     'STEP3'       $STEP3
005900001201     C     @STEP         CASEQ     'STEP4'       $STEP4
006000001201     C     @STEP         CASEQ     'STEP5'       $STEP5
006100001201     C                   ENDCS
006200001201     C                   ENDDO
006300001201     C*
006400001201     C                   MOVE      *ON           *INLR
006500001201     C*
006600001201   S***S
006700001201     C     *INZSR        BEGSR
006800001201     C                   MOVE      'STEP1'       @STEP             5
006900001201     C                   MOVE      *ZEROS        RR3               3 0
007000001201     C                   ENDSR
007100001201   S***S
007200001201     C     $STEP1        BEGSR
007300001201    ***
007400001201     C                   EXFMT     S01
007500050311     C                   MOVE      *BLANKS       S1MSG
007600001201    ***
007700001201     C                   IF        FKEY = F7
007800001201     C                   MOVEL(P)  'EXIT'        @STEP
007900001201     C                   LEAVESR
008000001201     C                   ENDIF
008100001201    ***
008200030514     C                   IF        FKEY = F5 and code <> *blanks
008300030514     c                   exsr      $f5
008400030514     C                   LEAVESR
008500030514     C                   ENDIF
008600030513    ***
008700001201     C                   IF        FKEY = F3
008800001201     C                   MOVEL(P)  'STEP4'       @STEP
008900001201     C                   LEAVESR
009000001201     C                   ENDIF
009100001201    ***
009200050311     C                   IF        CODE <> *BLANKS
009300050311    * *
009400050311     C     CODE          CHAIN     AGENR
009500050311    * *
009600050311    1C                   IF        %FOUND(AGENCY)
009700001201     C                   MOVEL(P)  'STEP2'       @STEP
009800050311     C                   LEAVESR
009900050311     C                   ENDIF
010000050311    * *
010100050311     C                   EVAL      S1MSG = 'AGENCY DOES NOT EXIST'
010200050311    * *
010300050311     C                   ELSE
010400050311    * *
010500050311     C                   EVAL      S1MSG = 'AGENCY CANNOT EQUAL BLANKS'
010600050311    * *
010700001201     C                   ENDIF
010800030513    ***
010900030513     C                   ENDSR
011000030513   S***S
011100030514     C     $f5           BEGSR
011200030514    ***
011300040708     c                   CALL      'IQC141'
011400030514     c                   parm                    code
011500030514    ***
011600030514     C                   ENDSR
011700030514   S***S
011800001201     C     $STEP2        BEGSR
011900001201    ***
012000001201     C                   MOVEL(P)  CODE          ACODE
012100001201     C     CODE          CHAIN     AGENR
012200001206    1C                   IF        NOT %FOUND(AGENCY)
012300001201     C                   CLEAR                   AGENR
012400060322     C                   MOVE      'STEP1'       @STEP
012500010823     C                   MOVE      *OFF          *IN36
012600060322     C                   LEAVESR
012700090105    1C                   ENDIF
012800090105    ***
012900010126     C                   MOVE      AGEFDT        #ISA
013000010126     C                   EXSR      $ISOUSA
013100010126     C                   MOVE      #ISA          S2EFDT
013200010126     C                   MOVE      AGTMDT        #ISA
013300010126     C                   EXSR      $ISOUSA
013400010126     C                   MOVE      #ISA          S2TMDT
013500010823     C                   MOVE      *ON           *IN36
013600060322     C                   EXSR      $RMG
013700090105    ***
013800090105     C                   SETON                                        5051
013900090105     C                   EVAL      *IN52 = *OFF
014000090105     C                   EVAL      INAC = *BLANKS
014100090105    * *
014200090105     C                   IF        AGTMDT <> 0
014300090105    * *
014400090105     C                   EVAL      *IN50 = *ON
014500090105     C                   EVAL      *IN51 = *OFF
014600090105     C     KL#MS         KLIST
014700090105     C                   KFLD                    KF@TY             1
014800090105     C                   KFLD                    CODE
014900090105     C                   EVAL      KF@TY = 'A'
015000090105    * *
015100090105     C     KL#MS         CHAIN     MKTSTSR
015200090105     C                   IF        %FOUND(MKTSTSP)
015300090105    * *
015400090105     C                   EVAL      *IN52 = *ON
015500090105     C                   EVAL      *IN50 = *OFF
015600090105     C                   EVAL      *IN51 = *ON
015700090105     C                   EVAL      INAC = MSREASN
015800090105    * *
015900090105     C     MSREASN       CHAIN     IRMMSTR
016000090105     C                   IF        NOT %FOUND(IRMMSTP)
016100090105    * *
016200090105     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
016300090105    * *
016400090105     C                   ENDIF
016500090105    * *
016600090105     C                   ENDIF
016700090105    * *
016800090105     C                   ENDIF
016900001201    ***
017000001201     C                   MOVEL     'STEP3'       @STEP
017100030109    ***
017200030109     C                   ENDSR
017300030109   S***S
017400060322    *C     $RMG          BEGSR
017500060322    ***
017600060322     C                   MOVEL(P)  'N/A'         D_SGR
017700060322     C                   MOVEL(P)  'N/A'         D_LGR
017800060322     C                   MOVEL(P)  'N/A'         D_RMGR
017900060322    ***
018000060322     C     CODE          CHAIN     AGCYRMGR
018100060322     C                   IF        NOT %FOUND(AGCYRMG0)
018200090105     C                   LEAVESR
018300060322     C                   ENDIF
018400060322    ***
018500060322     C     ARSGR         CHAIN     RMGRMSTR
018600060322     C                   IF        %FOUND(RMGRMST0)
018700060322     C                   MOVEL(P)  RMNAME        D_SGR
018800060322     C                   ENDIF
018900060322    ***
019000060322     C     ARLGR         CHAIN     RMGRMSTR
019100060322     C                   IF        %FOUND(RMGRMST0)
019200060322     C                   MOVEL(P)  RMNAME        D_LGR
019300060322     C                   ENDIF
019400060322    ***
019500060322     C     ARRMGR        CHAIN     RMGRMSTR
019600060322     C                   IF        %FOUND(RMGRMST0)
019700060322     C                   MOVEL(P)  RMNAME        D_RMGR
019800060322     C                   ENDIF
019900060322    ***
020000060322     C                   ENDSR
020100060322   S***S
020200010126     C     $ISOUSA       BEGSR
020300030109    ***
020400010126     C                   MOVE      'Y'           @@GD              1
020500010126     C                   IF        #ISA = 0
020600010126     C                   MOVE      'N'           @@GD
020700010126     C                   ELSE
020800010126     C     *ISO          TEST (DE)               #ISA
020900010126     C                   IF        %ERROR
021000010126     C                   MOVE      'N'           @@GD
021100010126     C                   ELSE
021200010126     C                   MOVE      #ISA          #ISO
021300010126     C                   MOVE      #ISO          #USA
021400010126     C                   MOVE      #USA          #ISA              8 0
021500010126     C                   ENDIF
021600010126     C                   ENDIF
021700010126     C                   ENDSR
021800001201   S***S
021900001201     C     $STEP3        BEGSR
022000001201    ***
022100001201     C                   EXFMT     S02
022200001201     C                   MOVE      *BLANKS       S2MSG
022300001201    ***
022400001201     C                   IF        FKEY = F1
022500001201     C                   MOVEL(P)  'STEP1'       @STEP
022600001201     C                   LEAVESR
022700001201     C                   ENDIF
022800001201    ***
022900001201     C                   IF        FKEY = F7
023000001201     C                   MOVEL(P)  'EXIT'        @STEP
023100001201     C                   LEAVESR
023200001201     C                   ENDIF
023300001201    ***
023400030109     C                   IF        FKEY = F10
023500030110     C                   MOVE      *BLANKS       @41
023600030110     C                   EVAL      @41 = AGNAM1 + '*'
023700040708     C                   CALL      'IQC162'
023800030110     C                   PARM                    CODE
023900030110     C                   PARM                    @41              41
024000030505     c                   eval      code = acode
024100030109     C                   LEAVESR
024200030109     C                   ENDIF
024300001201    ***
024400001201     C                   MOVEL(P)  'STEP2'       @STEP
024500030514    ***
024600030514     C                   ENDSR
024700030514   S***S
024800010126     C     $USAISO       BEGSR
024900030514    ***
025000010126     C                   MOVE      'Y'           @@GD              1
025100010126     C                   IF        #ISA = 0
025200010126     C                   MOVE      'N'           @@GD
025300010126     C                   ELSE
025400010126     C     *USA          TEST (DE)               #ISA
025500010126     C                   IF        %ERROR
025600010126     C                   MOVE      'N'           @@GD
025700010126     C                   ELSE
025800010126     C                   MOVE      #ISA          #USA
025900010126     C                   MOVE      #USA          #ISO
026000010126     C                   MOVE      #ISO          #ISA              8 0
026100010126     C                   ENDIF
026200010126     C                   ENDIF
026300010126     C                   ENDSR
026400001201   S***S
026500001201     C     $STEP4        BEGSR
026600001201    ***
026700001201     C                   MOVE      *ZEROS        RR3
026800001201     C                   MOVE      *ZEROS        #CNTREC           3 0
026900001201    ***
027000001201     C                   EXSR      $CLEAR
027100001201     C                   MOVEL(P)  'A'           C3NAME
027200001201     C                   MOVEL(P)  C3NAME        @HLNAME          40
027300001201    ***
027400001201     C                   EXSR      $BUILD
027500001201     C                   MOVEL(P)  'STEP5'       @STEP
027600001201    ***
027700001201     C                   ENDSR
027800001201   S***S
027900001201     C     $STEP5        BEGSR
028000001201    ***
028100001201     C                   EXSR      $DISPLAY
028200001201    ***
028300010108    1C                   IF        FKEY = F1
028400001201     C                   MOVEL(P)  'STEP1'       @STEP
028500001201     C                   LEAVESR
028600010108    1C                   ENDIF
028700001201    ***
028800010108    1C                   IF        @HLNAME <> C3NAME AND C3NAME <> *BLANKS
028900001201     C                   EXSR      $CLEAR
029000001201     C                   EXSR      $BUILD
029100001201     C                   MOVEL(P)  C3NAME        @HLNAME
029200001201     C                   LEAVESR
029300010108    1C                   ENDIF
029400010108    ***
029500010108    1C                   IF        *IN30 = *ON
029600010108     C                   MOVE      '0'           @SFLOOP
029700010108    2C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
029800010108     C                   READ      AGL1
029900010108    3C                   IF        NOT %EOF(AGENL1)
030000010108     C                   EXSR      $LOADSFL
030100010108    3C                   ENDIF
030200010108    2C                   ENDDO
030300010108    2C                   IF        %EOF(AGENL1)
030400010108     C                   MOVE      *OFF          *IN29
030500010108    2C                   ELSE
030600010108     C                   MOVE      *ON           *IN29
030700010108    2C                   ENDIF
030800010108     C                   LEAVESR
030900010108    1C                   ENDIF
031000010108    ***
031100001201     C                   EXSR      $CHKSELC
031200001201     C*
031300001201    ***
031400001201     C                   ENDSR
031500001201   S***S
031600001201     C* INITIALIZE THE SUBFILE
031700001201    ***
031800001201     C     $CLEAR        BEGSR
031900001201    ***
032000001201     C                   MOVEA     '011'         *IN(25)
032100001201     C                   WRITE     S03CTL
032200001201     C                   MOVEA     '010'         *IN(25)
032300001201     C                   Z-ADD     *ZERO         RR3
032400001201    ***
032500001201     C                   ENDSR
032600001201   S***S
032700001201     C* DISPLAY THE SCREEN
032800001201    ***
032900001201     C     $DISPLAY      BEGSR
033000001201    ***
033100001201     C                   WRITE     S03REC
033200001201     C                   EXFMT     S03CTL
033300001201    ***
033400001201     C                   ENDSR
033500001201    ***
033600001201   S***S
033700001201     C* BUILD SUBFILE CONTROL ROUTINE
033800001201    ***
033900001201     C     $BUILD        BEGSR
034000001201    ***
034100001201     C                   MOVE      *ZEROS        #CNTREC
034200001201     C                   MOVE      '0'           @1STLOOP          1
034300001201     C                   MOVEA     '00'          *IN(33)
034400001201     C                   MOVE      '0'           @SFLOOP           1
034500001201    ***
034600001201     C     C3NAME        SETLL     AGL1
034700001201     C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
034800001201     C                   READ      AGL1
034900001201     C                   IF        NOT %EOF(AGENL1)
035000001201     C                   EXSR      $LOADSFL
035100001201     C                   ENDIF
035200001201     C                   ENDDO
035300001201    ***
035400001201     C                   IF        %EOF(AGENL1)
035500001201     C                   MOVE      *OFF          *IN29
035600001201     C                   MOVE      *BLANKS       @LRNAME          40
035700001201     C                   ELSE
035800001201     C                   MOVE      *ON           *IN29
035900001201     C                   ENDIF
036000001201    ***
036100001201     C                   ENDSR
036200001201   S***S
036300001201     C* LOAD SUBFILE RECORDS
036400001201    ***
036500001201     C     $LOADSFL      BEGSR
036600001201    ***
036700001201     C                   MOVE      *ON           *IN25
036800001201     C                   MOVE      *BLANKS       SEL03
036900001201     C                   MOVEL(P)  IGCODE        S3CODE
037000001201     C                   MOVEL(P)  IGNAM1        S3NAM1
037100010108     C                   IF        IGTMDT = 0
037200010108     C                   MOVE      *ZEROS        S3TERM
037300010108     C                   ELSE
037400010108     C                   MOVE      IGTMDT        #ISO
037500010108     C                   MOVE      #ISO          #USA
037600010108     C                   MOVE      #USA          S3TERM
037700010108     C                   ENDIF
037800001201     C*
037900001201     C                   ADD       1             RR3
038000001201     C*
038100001201     C                   IF        @1STLOOP = '0'
038200001201     C                   Z-ADD     RR3           SFLPOS
038300001201     C                   MOVE      '1'           @1STLOOP
038400001201     C                   ENDIF
038500001201     C*
038600001201     C                   WRITE     S03SFL
038700001201     C*
038800001201     C                   ADD       1             #CNTREC
038900001201     C                   IF        #CNTREC = 14
039000001201     C                   MOVE      '1'           @SFLOOP
039100001201     C                   ENDIF
039200001201    ***
039300001201     C                   ENDSR
039400001201   S***S
039500001201     C* CHECK SUBFILE SELECTION
039600001201    ***
039700001201     C     $CHKSELC      BEGSR
039800001201    ***
039900001201     C                   MOVE      *OFF          *IN36
040000001201     C*
040100040708     C                   DOU       %EOF(IQR140D)
040200001201     C                   READC     S03SFL
040300040708     C                   IF        NOT %EOF(IQR140D) AND SEL03 <> *BLANKS
040400001201     C                   MOVEL(P)  S3CODE        CODE
040500001201     C                   MOVEL(P)  'STEP2'       @STEP
040600001201     C                   LEAVESR
040700001201     C                   ENDIF
040800001201     C                   ENDDO
040900001201    ***
041000001201     C                   ENDSR
041100001201   S***S
041200001201     C* ROLL CONTROL
041300001201    ***
041400001201     C     $RELOAD       BEGSR
041500001201     C*
041600001201     C                   MOVEL(P)  C3NAME        @40              40
041700001201     C                   MOVEL(P)  @LRNAME       C3NAME
041800001201     C*
041900001201     C                   EXSR      $BUILD
042000001201     C*
042100001201     C                   MOVEL(P)  @40           C3NAME
042200001201    ***
042300001201     C                   ENDSR
042400010120   S***S
