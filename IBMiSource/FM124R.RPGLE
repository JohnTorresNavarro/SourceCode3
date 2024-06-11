000100001201     F*---------------------------------------------------------------**
000200040708     F* IQR140     GROUP BENEFIT SERVICES SOFTWARE                     *
000300040920     F*            WRITTEN BY - SSK                                    *
000400001201     F*            DATE - 08/97                                        *
000500001201     F*  DESCRIPTION - AGENCY MASTER FILE MAINTENANCE                  *
000600001201     F*---------------------------------------------------------------**
000700001201    *** DEC 1, 2000 REWRITE THIS PROGRAM AND ADD AGENCY/CARRIER COMMISSION OVERRIDE APP
000800001201    ***             AND REMOVE ALL THESE HORRIBLE GOTO TAGS.
000900001201    *** SSK  I/O INC.
001000001201    ***
001100010823    *** 08.23.2001 SSK FUNCTION KEYS AVAILABLE ON CHANGE MODE ONLY
001200020130    *** 01.22.2002 SSK CORRECT DATE USAGE IN $SPINNER ROUTINE
001300030109    *** 01.09.2003 SSK ADD SUPER AGENCY INTERFACE
001400040708    *** 01.02.2004 SSK COPY FM120 TO IQ
001500040920    *** 09.20.2004 SSK COPY IQ TO FM124 FOR AGENCY OVERRIDES
001600010823    ***
001700040920     Ffm124d    CF   E             WORKSTN INFDS(WSDS)
001800001201     F                                     SFILE(S03SFL:RR3)
001900001201     FAGENL1    IF   E           K DISK    PREFIX(I:1) RENAME(AGENR:AGL1)
002000040102     FAGENCY    IF   E           K DISK
002100030109     FSUPRAGCY  IF   E           K DISK
002200030110     FSPRAGXR1  IF   E           K DISK
002300001201   X***X
002400001201     D                UDS
002500001201     D  CONAME               201    240
002600001201     ***
002700001201     D WSDS            DS
002800001201     D  FKEY                 369    369A
002900001201     ***
003000001201     D  F1             C                   CONST(X'31')
003100001201     D  F2             C                   CONST(X'32')
003200001201     D  F3             C                   CONST(X'33')
003300001201     D  F4             C                   CONST(X'34')
003400001201     D  F5             C                   CONST(X'35')
003500001201     D  F6             C                   CONST(X'36')
003600001201     D  F7             C                   CONST(X'37')
003700001201     D  F8             C                   CONST(X'38')
003800001201     D  F9             C                   CONST(X'39')
003900001201     D  F10            C                   CONST(X'3A')
004000001201     D  F11            C                   CONST(X'3B')
004100001201     D  F12            C                   CONST(X'3C')
004200001201     D  F13            C                   CONST(X'B1')
004300001201     D  F14            C                   CONST(X'B2')
004400001201     D  F15            C                   CONST(X'B3')
004500001201     D  F16            C                   CONST(X'B4')
004600001201     D  F17            C                   CONST(X'B5')
004700001201     D  F18            C                   CONST(X'B6')
004800001201     D  F19            C                   CONST(X'B7')
004900001201     D  F20            C                   CONST(X'B8')
005000001201     D  F21            C                   CONST(X'B9')
005100001201     D  F22            C                   CONST(X'BA')
005200001201     D  F23            C                   CONST(X'BB')
005300001201     D  F24            C                   CONST(X'BC')
005400001201     ***
005500040102     **
005600040102     D #ISO            S               D   DATFMT(*ISO)
005700040102     D #USA            S               D   DATFMT(*USA)
005800040102    ***
005900040102     d*ds@ag         e ds                  extname(agency)
006000001201   X***X
006100001201     C                   DOU       @STEP = 'EXIT'
006200001201     C     @STEP         CASEQ     'STEP1'       $STEP1
006300001201     C     @STEP         CASEQ     'STEP2'       $STEP2
006400001201     C     @STEP         CASEQ     'STEP3'       $STEP3
006500001201     C     @STEP         CASEQ     'STEP4'       $STEP4
006600001201     C     @STEP         CASEQ     'STEP5'       $STEP5
006700001201     C                   ENDCS
006800001201     C                   ENDDO
006900001201     C*
007000001201     C                   MOVE      *ON           *INLR
007100001201     C*
007200001201   S***S
007300001201     C     *INZSR        BEGSR
007400001201     C                   MOVE      'STEP1'       @STEP             5
007500001201     C                   MOVE      *ZEROS        RR3               3 0
007600001201     C                   ENDSR
007700001201   S***S
007800001201     C     $STEP1        BEGSR
007900001201    ***
008000001201     C                   EXFMT     S01
008100001201    ***
008200001201     C                   IF        FKEY = F7
008300001201     C                   MOVEL(P)  'EXIT'        @STEP
008400001201     C                   LEAVESR
008500001201     C                   ENDIF
008600001201    ***
008700001201     C                   IF        FKEY = F3
008800001201     C                   MOVEL(P)  'STEP4'       @STEP
008900001201     C                   LEAVESR
009000001201     C                   ENDIF
009100001201    ***
009200001201     C                   IF        CODE <> *BLANKS
009300001201     C                   MOVEL(P)  'STEP2'       @STEP
009400001201     C                   ENDIF
009500030513    ***
009600030513     C                   ENDSR
009700030513   S***S
009800001201     C     $STEP2        BEGSR
009900001201    ***
010000001201     C                   MOVEL(P)  CODE          ACODE
010100001201     C     CODE          CHAIN     AGENR
010200001206    1C                   IF        NOT %FOUND(AGENCY)
010300001201     C                   CLEAR                   AGENR
010400010823     C                   MOVE      *OFF          *IN36
010500001206    1C                   ELSE
010600010126     C                   MOVE      AGEFDT        #ISA
010700010126     C                   EXSR      $ISOUSA
010800010126     C                   MOVE      #ISA          S2EFDT
010900010126     C                   MOVE      AGTMDT        #ISA
011000010126     C                   EXSR      $ISOUSA
011100010126     C                   MOVE      #ISA          S2TMDT
011200010823     C                   MOVE      *ON           *IN36
011300030109     C                   EXSR      $CHKSUPER
011400001206    1C                   ENDIF
011500001201    ***
011600001201     C                   MOVEL     'STEP3'       @STEP
011700030109    ***
011800030109     C                   ENDSR
011900030109   S***S
012000030109     C     $CHKSUPER     BEGSR
012100030109    ***
012200030109     C                   MOVE      *BLANKS       O_SACCODE
012300030109     C                   MOVE      *BLANKS       O_SACNAME1
012400030109     C                   MOVE      *ZEROS        O_SACEFF
012500030109     C                   MOVE      *ZEROS        O_SACTRM
012600001201    ***
012700030109     C     CODE          CHAIN     SXF
012800030109     C                   IF        NOT %FOUND(SPRAGXR1)
012900030109     C                   LEAVESR
013000030109     C                   ENDIF
013100030109    ***
013200030109     C     CODE          SETGT     SXF
013300030109     C     CODE          READPE    SXF
013400030109     C                   EVAL      O_SACCODE = SXSUPER
013500030109    ***
013600030109     C     SXSUPER       CHAIN     SAF
013700030109     C                   IF        %FOUND(SUPRAGCY)
013800030109     C                   MOVEL(P)  SANAME1       O_SACNAME1
013900030109     C                   ELSE
014000030109     C                   EVAL      O_SACNAME1 = '*UNKNOWN'
014100030109     C                   ENDIF
014200030109    ***
014300030109     C                   IF        SXEFFDTE > 0
014400030109     C     SXEFFDTE      MULT      10000.0001    O_SACEFF
014500030109     C                   ELSE
014600030109     C                   Z-ADD     0             O_SACEFF
014700030109     C                   ENDIF
014800030109    ***
014900030109     C                   IF        SXTRMDTE > 0
015000030109     C     SXTRMDTE      MULT      10000.0001    O_SACTRM
015100030109     C                   ELSE
015200030109     C                   Z-ADD     0             O_SACTRM
015300030109     C                   ENDIF
015400030109    ***
015500001201     C                   ENDSR
015600010126   S***S
015700010126     C     $ISOUSA       BEGSR
015800030109    ***
015900010126     C                   MOVE      'Y'           @@GD              1
016000010126     C                   IF        #ISA = 0
016100010126     C                   MOVE      'N'           @@GD
016200010126     C                   ELSE
016300010126     C     *ISO          TEST (DE)               #ISA
016400010126     C                   IF        %ERROR
016500010126     C                   MOVE      'N'           @@GD
016600010126     C                   ELSE
016700010126     C                   MOVE      #ISA          #ISO
016800010126     C                   MOVE      #ISO          #USA
016900010126     C                   MOVE      #USA          #ISA              8 0
017000010126     C                   ENDIF
017100010126     C                   ENDIF
017200010126     C                   ENDSR
017300001201   S***S
017400001201     C     $STEP3        BEGSR
017500001201    ***
017600001201     C                   EXFMT     S02
017700001201     C                   MOVE      *BLANKS       S2MSG
017800001201    ***
017900001201     C                   IF        FKEY = F1
018000001201     C                   MOVEL(P)  'STEP1'       @STEP
018100001201     C                   LEAVESR
018200001201     C                   ENDIF
018300001201    ***
018400001201     C                   IF        FKEY = F7
018500001201     C                   MOVEL(P)  'EXIT'        @STEP
018600001201     C                   LEAVESR
018700001201     C                   ENDIF
018800001201    ***
018900040920     C                   IF        FKEY = F9
019000040920     c                   movel     acode         code
019100040920     c                   CALL      'FM123CL'
019200040920     c                   parm                    code
019300030109     C                   LEAVESR
019400030109     C                   ENDIF
019500001201    ***
019600001201     C                   MOVEL(P)  'STEP2'       @STEP
019700030514    ***
019800030514     C                   ENDSR
019900030514   S***S
020000010126     C     $USAISO       BEGSR
020100030514    ***
020200010126     C                   MOVE      'Y'           @@GD              1
020300010126     C                   IF        #ISA = 0
020400010126     C                   MOVE      'N'           @@GD
020500010126     C                   ELSE
020600010126     C     *USA          TEST (DE)               #ISA
020700010126     C                   IF        %ERROR
020800010126     C                   MOVE      'N'           @@GD
020900010126     C                   ELSE
021000010126     C                   MOVE      #ISA          #USA
021100010126     C                   MOVE      #USA          #ISO
021200010126     C                   MOVE      #ISO          #ISA              8 0
021300010126     C                   ENDIF
021400010126     C                   ENDIF
021500010126     C                   ENDSR
021600001201   S***S
021700001201     C     $STEP4        BEGSR
021800001201    ***
021900001201     C                   MOVE      *ZEROS        RR3
022000001201     C                   MOVE      *ZEROS        #CNTREC           3 0
022100001201    ***
022200001201     C                   EXSR      $CLEAR
022300001201     C                   MOVEL(P)  'A'           C3NAME
022400001201     C                   MOVEL(P)  C3NAME        @HLNAME          40
022500001201    ***
022600001201     C                   EXSR      $BUILD
022700001201     C                   MOVEL(P)  'STEP5'       @STEP
022800001201    ***
022900001201     C                   ENDSR
023000001201   S***S
023100001201     C     $STEP5        BEGSR
023200001201    ***
023300001201     C                   EXSR      $DISPLAY
023400001201    ***
023500010108    1C                   IF        FKEY = F1
023600001201     C                   MOVEL(P)  'STEP1'       @STEP
023700001201     C                   LEAVESR
023800010108    1C                   ENDIF
023900001201    ***
024000010108    1C                   IF        @HLNAME <> C3NAME AND C3NAME <> *BLANKS
024100001201     C                   EXSR      $CLEAR
024200001201     C                   EXSR      $BUILD
024300001201     C                   MOVEL(P)  C3NAME        @HLNAME
024400001201     C                   LEAVESR
024500010108    1C                   ENDIF
024600010108    ***
024700010108    1C                   IF        *IN30 = *ON
024800010108     C                   MOVE      '0'           @SFLOOP
024900010108    2C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
025000010108     C                   READ      AGL1
025100010108    3C                   IF        NOT %EOF(AGENL1)
025200010108     C                   EXSR      $LOADSFL
025300010108    3C                   ENDIF
025400010108    2C                   ENDDO
025500010108    2C                   IF        %EOF(AGENL1)
025600010108     C                   MOVE      *OFF          *IN29
025700010108    2C                   ELSE
025800010108     C                   MOVE      *ON           *IN29
025900010108    2C                   ENDIF
026000010108     C                   LEAVESR
026100010108    1C                   ENDIF
026200010108    ***
026300001201     C                   EXSR      $CHKSELC
026400001201     C*
026500001201    ***
026600001201     C                   ENDSR
026700001201   S***S
026800001201     C* INITIALIZE THE SUBFILE
026900001201    ***
027000001201     C     $CLEAR        BEGSR
027100001201    ***
027200001201     C                   MOVEA     '011'         *IN(25)
027300001201     C                   WRITE     S03CTL
027400001201     C                   MOVEA     '010'         *IN(25)
027500001201     C                   Z-ADD     *ZERO         RR3
027600001201    ***
027700001201     C                   ENDSR
027800001201   S***S
027900001201     C* DISPLAY THE SCREEN
028000001201    ***
028100001201     C     $DISPLAY      BEGSR
028200001201    ***
028300001201     C                   WRITE     S03REC
028400001201     C                   EXFMT     S03CTL
028500001201    ***
028600001201     C                   ENDSR
028700001201    ***
028800001201   S***S
028900001201     C* BUILD SUBFILE CONTROL ROUTINE
029000001201    ***
029100001201     C     $BUILD        BEGSR
029200001201    ***
029300001201     C                   MOVE      *ZEROS        #CNTREC
029400001201     C                   MOVE      '0'           @1STLOOP          1
029500001201     C                   MOVEA     '00'          *IN(33)
029600001201     C                   MOVE      '0'           @SFLOOP           1
029700001201    ***
029800001201     C     C3NAME        SETLL     AGL1
029900001201     C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
030000001201     C                   READ      AGL1
030100001201     C                   IF        NOT %EOF(AGENL1)
030200001201     C                   EXSR      $LOADSFL
030300001201     C                   ENDIF
030400001201     C                   ENDDO
030500001201    ***
030600001201     C                   IF        %EOF(AGENL1)
030700001201     C                   MOVE      *OFF          *IN29
030800001201     C                   MOVE      *BLANKS       @LRNAME          40
030900001201     C                   ELSE
031000001201     C                   MOVE      *ON           *IN29
031100001201     C                   ENDIF
031200001201    ***
031300001201     C                   ENDSR
031400001201   S***S
031500001201     C* LOAD SUBFILE RECORDS
031600001201    ***
031700001201     C     $LOADSFL      BEGSR
031800001201    ***
031900001201     C                   MOVE      *ON           *IN25
032000001201     C                   MOVE      *BLANKS       SEL03
032100001201     C                   MOVEL(P)  IGCODE        S3CODE
032200001201     C                   MOVEL(P)  IGNAM1        S3NAM1
032300010108     C                   IF        IGTMDT = 0
032400010108     C                   MOVE      *ZEROS        S3TERM
032500010108     C                   ELSE
032600010108     C                   MOVE      IGTMDT        #ISO
032700010108     C                   MOVE      #ISO          #USA
032800010108     C                   MOVE      #USA          S3TERM
032900010108     C                   ENDIF
033000001201     C*
033100001201     C                   ADD       1             RR3
033200001201     C*
033300001201     C                   IF        @1STLOOP = '0'
033400001201     C                   Z-ADD     RR3           SFLPOS
033500001201     C                   MOVE      '1'           @1STLOOP
033600001201     C                   ENDIF
033700001201     C*
033800001201     C                   WRITE     S03SFL
033900001201     C*
034000001201     C                   ADD       1             #CNTREC
034100001201     C                   IF        #CNTREC = 14
034200001201     C                   MOVE      '1'           @SFLOOP
034300010108 ********                EXSR      $CPNXTREC
034400001201     C                   ENDIF
034500001201    ***
034600001201     C                   ENDSR
034700001201   S***S
034800001201     C* CAPTURE NEXT RECORD FOR ROLL
034900001201    ***
035000001201     C     $CPNXTREC     BEGSR
035100001201    ***
035200001201     C                   READ      AGL1
035300001201     C*
035400001201     C                   MOVEL(P)  AGNAM1        @LRNAME
035500001201    ***
035600001201     C                   ENDSR
035700001201   S***S
035800001201     C* CHECK SUBFILE SELECTION
035900001201    ***
036000001201     C     $CHKSELC      BEGSR
036100001201    ***
036200001201     C                   MOVE      *OFF          *IN36
036300001201     C*
036400040920     C                   DOU       %EOF(fm124d)
036500001201     C                   READC     S03SFL
036600040920     C                   IF        NOT %EOF(fm124d) AND SEL03 <> *BLANKS
036700001201     C                   MOVEL(P)  S3CODE        CODE
036800001201     C                   MOVEL(P)  'STEP2'       @STEP
036900001201     C                   LEAVESR
037000001201     C                   ENDIF
037100001201     C                   ENDDO
037200001201    ***
037300001201     C                   ENDSR
037400001201   S***S
037500001201     C* ROLL CONTROL
037600001201    ***
037700001201     C     $RELOAD       BEGSR
037800001201     C*
037900001201     C                   MOVEL(P)  C3NAME        @40              40
038000001201     C                   MOVEL(P)  @LRNAME       C3NAME
038100001201     C*
038200001201     C                   EXSR      $BUILD
038300001201     C*
038400001201     C                   MOVEL(P)  @40           C3NAME
038500001201    ***
038600001201     C                   ENDSR
038700010120   S***S
