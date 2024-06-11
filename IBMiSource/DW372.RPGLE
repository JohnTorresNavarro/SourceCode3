000100130203     FDW372WF   IPE  F  600        DISK
000200130203     FMEMALT    UF A E           K DISK
000300130203   X***X
000400130203     D KF@MID          S                   LIKE(MAMEMID)
000500130203     D KF@TID          S                   LIKE(MAALTID)
000600130203     D KF@TTP          S                   LIKE(MAALTTP)
000700130203    ***
000800130203     D H@LNAME         S                   LIKE(MALNAME)
000900130203     D H@FNAME         S                   LIKE(MAFNAME)
001000130203    ***
001100130203     D                 DS
001200130203     D @SRCE                   1    600A   DIM(600)
001300130203     D BLK@SRCE                1    600A
001400130203    ***
001500130203     D                 DS
001600130203     D @TRGT                   1    600A   DIM(600)
001700130203     D BLK@TRGT                1    600A
001800130203    ***
001900130203     D I#NDX           S              3S 0
002000130203     D O#NDX           S              3S 0
002100130203     D CC              S              3S 0
002200130203     D MAX_CC          S              3S 0 INZ(25)
002300130203    ***
002400130203     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
002500130203     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
002600130203    ***
002700130203     D @CVTDAT         S             10A
002800130203     D POS             S              5U 0
002900130203     D @4              S              4A
003000130203     D #4              S              4S 0
003100130203     D #DI             S              3S 0
003200130203     D #DO             S              3S 0
003300130203     D #DATE_PART      S              3S 0
003400130203     D #MTH_DGTS       S              1S 0
003500130203     D #DAY_DGTS       S              1S 0
003600130203     D #YR_DGTS        S              1S 0
003700130203    ***
003800130203     D                 DS
003900130203     D DATEIN@                 1     10A   DIM(10)
004000130203     D @DATEIN                 1     10A
004100130203    ***
004200130203     D                 DS
004300130203     D DATEOUT@                1     10A   DIM(10)
004400130203     D @DATEOUT                1     10A
004500130203    ***
004600130203     D #ERRORS         S              5S 0
004700130203     D #COUNT          S             12S 0
004800130203     D #AMOUNT         S             11S 2
004900130203     D #PC             S              1S 0
005000130203     D #CP             S              1S 0
005100130203     D @CENTS          S              2A
005200130203     D #2              S              2S 0
005300130203     D #15             S             15S 0
005400130203     D #17V2           S             17S 2
005500130203    ***
005600130203     D @15             S             15A
005700130203     D #15S4           S             15S 4
005800130203     D NEG             S              1A
005900130203     D POS2            S              5U 0
006000130203     D N@15            S             15A
006100130203     D X               S              2S 0
006200130203     D Y               S              2S 0
006300130203    ***
006400130203     D #11             S             11S 0
006500130203     D @11             S             11A
006600130203     D                 DS
006700130203     D @DOLLAR                 1     15A
006800130203     D DLR@                    1     15A   DIM(15)
006900130203    ***
007000130203     D                 DS
007100130203     D @XLTAMT                 1     15A
007200130203     D XA@                     1     15A   DIM(15)
007300130203    ***
007400130203     D YES             S               N   INZ(*ON)
007500130203     D NO              S               N   INZ(*OFF)
007600130203     D FIELD_FND       S               N
007700130203     D QUOTES_FND      S               N
007800130203     D NEG_FND         S               N
007900130203    ***
008000130203     D #TODAY          S              8S 0
008100130203     D #XSX            S              8S 0
008200130203     D #ISO            S               D   DATFMT(*ISO)
008300130203     D #USA            S               D   DATFMT(*USA)
008400130203     D INZ#ISO         S               D   DATFMT(*ISO)
008500130203     D INZ#USA         S               D   DATFMT(*USA)
008600130203    ***
008700130203   X***X
008800130203     IDW372WF   AA
008900130203     I                                  1  600  INPUT_FLD
009000130203    ***
009100130203   X***X
009200130203     C                   CLEAR                   BLK@TRGT
009300130203     C                   CLEAR                   BLK@SRCE
009400130203    ***
009500130203     C                   EVAL      BLK@SRCE = INPUT_FLD
009600130203     C     LO:UP         XLATE     BLK@SRCE      BLK@SRCE
009700130203     C                   EVAL      I#NDX = 0
009800130203     C                   EVAL      CC = 0
009900130203    ***
010000130203     C                   IF        %SUBST(BLK@SRCE:1:7) <> 'MEM FIR'
010100130203     C                   DOU       CC > MAX_CC OR I#NDX = 600
010200130203     C                   EXSR      $GET_FLD
010300130203     C                   EXSR      $PROC_FLD
010400130203     C                   ENDDO
010500130203     C                   ENDIF
010600130203    ***
010700130203    ***
010800130203   S***S
010900130203     C     *INZSR        BEGSR
011000130203    ***
011100130203     C                   EVAL      #ERRORS = 0
011200130203     C                   EVAL      #ISO = %DATE
011300130203     C                   MOVE      #ISO          #TODAY
011400130203    ***
011500130203     C     KEY#MALT      KLIST
011600130203     C                   KFLD                    KF@MID
011700130203     C                   KFLD                    KF@TTP
011800130328     C*******************KFLD                    KF@TID
011900130203    ***
012000130203     C                   EVAL      KF@TTP = 'CH'
012100130203    ***
012200130203     C                   ENDSR
012300130203   S***S
012400130203     C     $GET_FLD      BEGSR
012500130203    ***
012600130203     C                   CLEAR                   BLK@TRGT
012700130203     C                   EVAL      O#NDX = 0
012800130203     C                   EVAL      FIELD_FND = NO
012900130203     C                   EVAL      QUOTES_FND = NO
013000130203    ***
013100130203     C                   EVAL      #DAY_DGTS = 0
013200130203     C                   EVAL      #MTH_DGTS = 0
013300130203     C                   EVAL      #YR_DGTS = 0
013400130203     C                   EVAL      #DATE_PART = 1
013500130203     C                   EVAL      #DO = 1
013600130203     C                   EVAL      #DI = 0
013700130203     C                   MOVE      INZ#ISO       #ISO
013800130203     C                   MOVE      INZ#USA       #USA
013900130203     C                   EVAL      #XSX = 0
014000130203     C                   EVAL      NEG_FND = NO
014100130203     C                   EVAL      #PC = 1
014200130203     C                   MOVE      *ALL'0'       @DOLLAR
014300130203     C                   MOVE      '00'          @CENTS
014400130203     C                   EVAL      X = 16
014500130203     C                   EVAL      Y = 16
014600130203     C                   EVAL      #CP = 3
014700130203     C                   EVAL      #2 = 0
014800130203     C                   EVAL      #15 = 0
014900130203     C                   EVAL      #17V2 = 0.00
015000130203     C                   EVAL      #AMOUNT = 0.00
015100130203     C                   EVAL      #COUNT = 0
015200130203    ***
015300130203     C                   ADD       1             CC
015400130203     C                   DOU       I#NDX = 600 OR FIELD_FND = YES
015500130203     C                   EXSR      $CHK_EA_POS
015600130203     C                   ENDDO
015700130203    ***
015800130203     C                   ENDSR
015900130203   S***S
016000130203     C     $CHK_EA_POS   BEGSR
016100130203    ***
016200130203     C                   ADD       1             I#NDX
016300130203    ***
016400130203     C                   IF        @SRCE(I#NDX) = ';' AND QUOTES_FND = NO
016500130203     C                   EVAL      FIELD_FND = YES
016600130203     C                   LEAVESR
016700130203     C                   ENDIF
016800130203    ***
016900130203     C                   IF        @SRCE(I#NDX) = '"'
017000130203    * *
017100130203     C                   IF        QUOTES_FND = YES
017200130203     C                   EVAL      QUOTES_FND = NO
017300130203     C                   ELSE
017400130203     C                   EVAL      QUOTES_FND = YES
017500130203     C                   ENDIF
017600130203    * *
017700130203     C                   LEAVESR
017800130203    * *
017900130203     C                   ENDIF
018000130203    ***
018100130203     C                   ADD       1             O#NDX
018200130203     C                   EVAL      @TRGT(O#NDX) = @SRCE(I#NDX)
018300130203    ***
018400130203     C                   ENDSR
018500130203   S***S
018600130203     C     $PROC_FLD     BEGSR
018700130203    ***
018800130203     C                   SELECT
018900130203    *C*
019000130203     C                   WHEN      CC = 1
019100130203     C                   MOVEL(P)  BLK@TRGT      H@FNAME
019200130203    *C*
019300130203     C                   WHEN      CC = 2
019400130203     C                   MOVEL(P)  BLK@TRGT      H@LNAME
019500130203    *C*
019600130203     C                   WHEN      CC = 20
019700130203     C                   MOVEL(P)  BLK@TRGT      KF@MID
019800130203    *C*
019900130203     C                   WHEN      CC = 23
020000130203     C                   IF        BLK@TRGT <> 'SUBSCRIBER'
020100130203     C                   EVAL      I#NDX = 600
020200130203     C                   ENDIF
020300130203    *C*
020400130203     C                   WHEN      CC = 24
020500130203     C                   EVAL      I#NDX = 600
020600130203     C                   MOVEL(P)  BLK@TRGT      KF@TID
020700130203     C     KEY#MALT      CHAIN     MEMALTR
020800130203     C                   IF        NOT %FOUND(MEMALT)
020900130203     C                   CLEAR                   MEMALTR
021000130203     C                   EVAL      MAMEMID = KF@MID
021100130203     C                   EVAL      MAALTID = KF@TID
021200130203     C                   EVAL      MAALTTP = 'CH '
021300130203     C                   EVAL      MALNAME = H@LNAME
021400130203     C                   EVAL      MAFNAME = H@FNAME
021500130203     C                   MOVE      #TODAY        MACRTDT
021600130203     C                   WRITE(E)  MEMALTR
021700130203     C                   ELSE
021800130203     C                   IF        MAALTID <> KF@TID
021900130203     C                   EVAL      MAALTID = KF@TID
022000130203     C                   UPDATE(E) MEMALTR
022100130203     C                   ENDIF
022200130203     C                   ENDIF
022300130203    ***
022400130203     C                   ENDSL
022500130203    ***
022600130203     C                   ENDSR
022700130203   S***S
022800130203      *
022900130203     C*    $EMSG         BEGSR
023000130203    ***
023100130203     C*                  ADD       1             #ERRORS
023200130203    ***
023300130203     C*                  IF        MSG@PRT = *BLANKS
023400130203     C*                  EVAL      MSG@PRT = %TRIM(@EMSG)
023500130203     C*                  ELSE
023600130203     C*                  EVAL      MSG@PRT = %TRIM(MSG@PRT) + '; ' +
023700130203     C*                            %TRIM(@EMSG)
023800130203     C*                  ENDIF
023900130203    ***
024000130203     C*                  EVAL      @EMSG = *BLANKS
024100130203    ***
024200130203     C*                  ENDSR
024300130203   S***S
024400130203     C*    $CFG_DATE     BEGSR
024500130203    ***
024600130203     C*                  EVAL      #DAY_DGTS = 0
024700130203     C*                  EVAL      #MTH_DGTS = 0
024800130203     C*                  EVAL      #YR_DGTS = 0
024900130203     C*                  MOVEL     @CVTDAT       @DATEIN
025000130203     C*                  EVAL      #DATE_PART = 1
025100130203     C*                  EVAL      #DO = 1
025200130203     C*                  EVAL      #DI = 0
025300130203    ***
025400130203     C*                  DO        10            #DI
025500130203    * *
025600130203     C*                  IF        DATEIN@(#DI) = '/'
025700130203     C*                  ADD       1             #DATE_PART
025800130203     C*                  ITER
025900130203     C*                  ENDIF
026000130203    * *
026100130203     C*                  IF        #DATE_PART = 2 AND #MTH_DGTS = 1
026200130203     C*                  ADD       1             #DO
026300130203     C*                  EVAL      DATEOUT@(2) = DATEOUT@(1)
026400130203     C*                  EVAL      DATEOUT@(1) = '0'
026500130203     C*                  EVAL      #MTH_DGTS = 2
026600130203     C*                  ENDIF
026700130203    * *
026800130203     C*                  IF        #DATE_PART = 3 AND #DAY_DGTS = 1
026900130203     C*                  ADD       1             #DO
027000130203     C*                  EVAL      DATEOUT@(4) = DATEOUT@(3)
027100130203     C*                  EVAL      DATEOUT@(3) = '0'
027200130203     C*                  EVAL      #DAY_DGTS = 2
027300130203     C*                  ENDIF
027400130203    * *
027500130203     C*                  IF        DATEIN@(#DI) = ' '
027600130203     C*                  ITER
027700130203     C*                  ENDIF
027800130203    * *
027900130203     C*                  EVAL      DATEOUT@(#DO) = DATEIN@(#DI)
028000130203     C*                  ADD       1             #DO
028100130203    * *
028200130203     C*                  SELECT
028300130203     C*                  WHEN      #DATE_PART = 1
028400130203     C*                  ADD       1             #MTH_DGTS
028500130203     C*                  WHEN      #DATE_PART = 2
028600130203     C*                  ADD       1             #DAY_DGTS
028700130203     C*                  WHEN      #DATE_PART = 3
028800130203     C*                  ADD       1             #YR_DGTS
028900130203     C*                  ENDSL
029000130203    * *
029100130203     C*                  ENDDO
029200130203    ***
029300130203     C*                  IF        #YR_DGTS = 2
029400130203     C*                  EVAL      DATEOUT@(7) = DATEOUT@(5)
029500130203     C*                  EVAL      DATEOUT@(8) = DATEOUT@(6)
029600130203     C*                  EVAL      DATEOUT@(5) = '2'
029700130203     C*                  EVAL      DATEOUT@(6) = '0'
029800130203     C*                  ENDIF
029900130203    ***
030000130203     C*                  MOVEL     @DATEOUT      #XSX
030100130203     C*                  MOVE      #XSX          #USA
030200130203     C*                  MOVE      #USA          #ISO
030300130203     C*                  MOVE      #ISO          #XSX
030400130203    ***
030500130203     C*                  ENDSR
030600130203   S***S
030700130203     C*    $CFG_AMT      BEGSR
030800130203    ***
030900130203     C*                  EVAL      NEG_FND = NO
031000130203     C*                  EVAL      #PC = 1
031100130203     C*                  MOVE      *ALL'0'       @DOLLAR
031200130203     C*                  MOVE      '00'          @CENTS
031300130203     C*                  EVAL      X = 16
031400130203     C*                  EVAL      Y = 16
031500130203     C*                  EVAL      #CP = 3
031600130203     C*                  EVAL      #2 = 0
031700130203    ***
031800130203     C*                  DO        15
031900130203    * *
032000130203     C*                  SUB       1             X
032100130203    * *
032200130203     C*                  SELECT
032300130203     C*                  WHEN      XA@(X) = ' '
032400130203     C*                  ITER
032500130203     C*                  WHEN      XA@(X) = '.'
032600130203     C*                  ADD       1             #PC
032700130203     C*                  ITER
032800130203     C*                  WHEN      XA@(X) = '-'
032900130203     C*                  EVAL      NEG_FND = YES
033000130203     C*                  ITER
033100130203     C*                  ENDSL
033200130203    * *
033300130203     C*                  IF        #PC = 1
033400130203     C*                  SUB       1             #CP
033500130203     C*                  EVAL      %SUBST(@CENTS:#CP:1) = XA@(X)
033600130203     C*                  ELSE
033700130203     C*                  SUB       1             Y
033800130203     C*                  EVAL      DLR@(Y) = XA@(X)
033900130203     C*                  ENDIF
034000130203    * *
034100130203     C*                  ENDDO
034200130203    ***
034300130203     C*                  MOVE      @DOLLAR       #15
034400130203    ***
034500130203     C*                  IF        @CENTS <> '00'
034600130203     C*                  MOVE      @CENTS        #2
034700130203     C*                  EVAL      #17V2 = #15 + (#2 / 100)
034800130203     C*                  ELSE
034900130203     C*                  EVAL      #17V2 = #15
035000130203     C*                  ENDIF
035100130203    ***
035200130203     C*                  IF        NEG_FND = YES
035300130203     C*                  MULT      -1            #17V2
035400130203     C*                  ENDIF
035500130203    ***
035600130203     C*                  Z-ADD     #17V2         #AMOUNT
035700130203    ***
035800130203     C*                  ENDSR
035900130203   S***S
036000130203     C*    $CFG_CNT      BEGSR
036100130203    ***
036200130203     C*                  EVAL      NEG_FND = NO
036300130203     C*                  EVAL      #PC = 1
036400130203     C*                  MOVE      *ALL'0'       @DOLLAR
036500130203     C*                  EVAL      X = 16
036600130203     C*                  EVAL      Y = 16
036700130203     C*                  MOVE      *ZEROS        #COUNT
036800130203    ***
036900130203     C*                  EVAL      POS = %SCAN('.':@XLTAMT)
037000130203     C*                  IF        POS > 0
037100130203     C*                  EVAL      @XLTAMT = %SUBST(BLK@TRGT:1:POS - 1)
037200130203     C*                  ENDIF
037300130203    ***
037400130203     C*                  DO        15
037500130203    * *
037600130203     C*                  SUB       1             X
037700130203    * *
037800130203     C*                  SELECT
037900130203     C*                  WHEN      XA@(X) = ' '
038000130203     C*                  ITER
038100130203    * *
038200130203     C*                  WHEN      XA@(X) = '-'
038300130203     C*                  EVAL      NEG_FND = YES
038400130203     C*                  ITER
038500130203     C*                  ENDSL
038600130203    * *
038700130203     C*                  SUB       1             Y
038800130203     C*                  EVAL      DLR@(Y) = XA@(X)
038900130203    * *
039000130203     C*                  ENDDO
039100130203    ***
039200130203     C*                  MOVE      @DOLLAR       #15
039300130203    ***
039400130203     C*                  IF        NEG_FND = YES
039500130203     C*                  MULT      -1            #15
039600130203     C*                  ENDIF
039700130203    ***
039800130203     C*                  Z-ADD     #15           #COUNT
039900130203    ***
040000130203     C*                  ENDSR
040100130203   S***S
040200130203     C*    $CFG_AM4      BEGSR
040300130203    ***
040400130203     C*                  IF        @15 = *BLANKS
040500130203     C*                  EVAL      #15S4 = 0.00
040600130203     C*                  LEAVESR
040700130203     C*                  ENDIF
040800130203    ***
040900130203     C*                  EVAL      NEG = 'N'
041000130203     C*                  EVAL      POS2 = 0
041100130203     C*                  EVAL      POS2 = %SCAN('-':@15)
041200130203     C*                  IF        POS2 > 0
041300130203     C*                  MOVE      'Y'           NEG
041400130203     C*                  ENDIF
041500130203    ***
041600130203     C*                  EVAL      N@15 = *BLANKS
041700130203     C*                  EVAL      POS = 0
041800130203     C*                  EVAL      POS = %SCAN('.':@15)
041900130203     C*                  IF        POS > 0
042000130203     C*                  EVAL      X = POS - 1
042100130203     C*                  EVAL      %SUBST(N@15:2:X) = %SUBST(@15:1:X)
042200130203     C*                  EVAL      X = POS + 1
042300130203     C*                  EVAL      Y = (15 - X) + 1
042400130203     C*                  EVAL      %SUBST(N@15:X:Y) = %SUBST(@15:X:Y)
042500130203     C*                  EVAL      @15 = N@15
042600130203     C*                  ENDIF
042700130203    ***
042800130203     C*    ' ':'0'       XLATE     @15           @15
042900130203    ***
043000130203     C*                  MOVEL     @15           @11
043100130203     C*                  MOVE      @11           #11
043200130203     C*                  MOVE      @15           @4
043300130203     C*                  MOVE      @4            #4
043400130203     C*                  EVAL      #15S4 = #11 + (#4 * .0001)
043500130203     C*                  IF        NEG = 'Y'
043600130203     C*                  MULT      -1            #15S4
043700130203     C*                  ENDIF
043800130203    ***
043900130203     C*                  ENDSR
044000130203   S***S
044100130203     O*2000     EADD         OUTF
044200130203     O*                      @OUT           B  2000
