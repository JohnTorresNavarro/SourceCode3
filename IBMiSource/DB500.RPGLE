000100040812     *** MAPPING PROGRAM FOR: GAME WORKSHOP ADJUSTMENTS
000200090414     FDB502WF   IPE  F  400        DISK
000300060203     FDB500WF   UF A E           K DISK
000400060203   X***X
000500060203     D @CVTDAT         S             10A
000600060203     D #DI             S              3S 0
000700060203     D #DO             S              3S 0
000800060203     D #DATE_PART      S              3S 0
000900060203     D #MTH_DGTS       S              1S 0
001000060203     D #DAY_DGTS       S              1S 0
001100060203     D #YR_DGTS        S              1S 0
001200060203    ***
001300060203     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
001400060203     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
001500060203    ***
001600060203     D #XSX            S              8S 0
001700060203     D #ISO            S               D   DATFMT(*ISO)
001800060203     D #USA            S               D   DATFMT(*USA)
001900060203     D INZ#ISO         S               D   DATFMT(*ISO)
002000060203     D INZ#USA         S               D   DATFMT(*USA)
002100060203    ***
002200060203     D                 DS
002300060203     D DATEIN@                 1     10A   DIM(10)
002400060203     D @DATEIN                 1     10A
002500060203    ***
002600060203     D                 DS
002700060203     D DATEOUT@                1     10A   DIM(10)
002800060203     D @DATEOUT                1     10A
002900060203    ***
003000060203     D                 DS
003100060203     D @SRCE                   1    400A   DIM(400)
003200060203     D BLK@SRCE                1    400A
003300060203    ***
003400060203     D                 DS
003500060203     D @TRGT                   1    400A   DIM(400)
003600060203     D BLK@TRGT                1    400A
003700060203    ***
003800060203     D I#NDX           S              3S 0
003900060203     D O#NDX           S              3S 0
004000060203     D CC              S              3S 0
004100060203     D MAX_CC          S              3S 0 INZ(16)
004200060203    ***
004300060203     D YES             S               N   INZ(*ON)
004400060203     D NO              S               N   INZ(*OFF)
004500060203     D FIELD_FND       S               N
004600060203     D QUOTES_FND      S               N
004700060203     D NEG_FND         S               N
004800060203     D WHSL_FND        S               N
004900060203     D UNDER50_FND     S               N
005000060203     D OVER50_FND      S               N
005100060203    ***
005200060203     D                 DS
005300060203     D @XLTAMT                 1     15A
005400060203     D XA@                     1     15A   DIM(15)
005500060203     D X               S              3S 0
005600060203    ***
005700060203     D                 DS
005800060203     D @DOLLAR                 1     15A
005900060203     D DLR@                    1     15A   DIM(15)
006000060203     D Y               S              3S 0
006100060203    ***
006200060203     D #COUNT          S             12S 0
006300060203     D #AMOUNT         S             11S 2
006400060203     D #PC             S              1S 0
006500060203     D #CP             S              1S 0
006600060203     D @CENTS          S              2A
006700060203     D #2              S              2S 0
006800060203     D #15             S             15S 0
006900060203     D #17V2           S             17S 2
007000060203    ***
007100060203   X***X
007200090414     IDB502WF   AA
007300060203     I                                  1  400  INPUT_FLD
007400060203   X***X
007500060203     C                   CLEAR                   BLK@SRCE
007600060203     C                   EVAL      BLK@SRCE = INPUT_FLD
007700060203     C     LO:UP         XLATE     BLK@SRCE      BLK@SRCE
007800060203     C                   EVAL      I#NDX = 0
007900060203     C                   EVAL      CC = 0
008000060203    ***
008100060203     C                   DOU       CC > MAX_CC OR I#NDX = 400
008200060203     C                   EXSR      $GET_FLD
008300060203     C                   EXSR      $PROC_FLD
008400060203     C                   ENDDO
008500060203    ***
008600060203     C                   WRITE     RDBEDOC
008700060203   S***S
008800060203     C     $GET_FLD      BEGSR
008900060203    ***
009000060203     C                   CLEAR                   BLK@TRGT
009100060203     C                   EVAL      O#NDX = 0
009200060203     C                   EVAL      FIELD_FND = NO
009300060203     C                   EVAL      QUOTES_FND = NO
009400060203    ***
009500060203     C                   EVAL      #DAY_DGTS = 0
009600060203     C                   EVAL      #MTH_DGTS = 0
009700060203     C                   EVAL      #YR_DGTS = 0
009800060203     C                   EVAL      #DATE_PART = 1
009900060203     C                   EVAL      #DO = 1
010000060203     C                   EVAL      #DI = 0
010100060203     C                   MOVE      INZ#ISO       #ISO
010200060203     C                   MOVE      INZ#USA       #USA
010300060203     C                   EVAL      #XSX = 0
010400060203     C                   EVAL      NEG_FND = NO
010500060203     C                   EVAL      #PC = 1
010600060203     C                   MOVE      *ALL'0'       @DOLLAR
010700060203     C                   MOVE      '00'          @CENTS
010800060203     C                   EVAL      X = 16
010900060203     C                   EVAL      Y = 16
011000060203     C                   EVAL      #CP = 3
011100060203     C                   EVAL      #2 = 0
011200060203     C                   EVAL      #15 = 0
011300060203     C                   EVAL      #17V2 = 0.00
011400060203     C                   EVAL      #AMOUNT = 0.00
011500060203     C                   EVAL      #COUNT = 0
011600060203    ***
011700060203     C                   ADD       1             CC
011800060203     C                   DOU       I#NDX = 400 OR FIELD_FND = YES
011900060203     C                   EXSR      $CHK_EA_POS
012000060203     C                   ENDDO
012100060203    ***
012200060203     C                   ENDSR
012300060203   S***S
012400060203     C     $CHK_EA_POS   BEGSR
012500060203    ***
012600060203     C                   ADD       1             I#NDX
012700060203    ***
012800060203     C                   IF        @SRCE(I#NDX) = ',' AND QUOTES_FND = NO
012900060203     C                   EVAL      FIELD_FND = YES
013000060203     C                   LEAVESR
013100060203     C                   ENDIF
013200060203    ***
013300060203     C                   IF        @SRCE(I#NDX) = '"'
013400060203    * *
013500060203     C                   IF        QUOTES_FND = YES
013600060203     C                   EVAL      QUOTES_FND = NO
013700060203     C                   ELSE
013800060203     C                   EVAL      QUOTES_FND = YES
013900060203     C                   ENDIF
014000060203    * *
014100060203     C                   LEAVESR
014200060203    * *
014300060203     C                   ENDIF
014400060203    ***
014500060203     C                   ADD       1             O#NDX
014600060203     C                   EVAL      @TRGT(O#NDX) = @SRCE(I#NDX)
014700060203    ***
014800060203     C                   ENDSR
014900040203   S***S
015000040130     C     $PROC_FLD     BEGSR
015100040128    ***
015200040130     C                   SELECT
015300040130    *C*
015400060203     C                   WHEN      CC = 3
015500060203     C                   MOVEL(P)  BLK@TRGT      DDGRP
015600040130    *C*
015700060203     C                   WHEN      CC = 4
015800060203     C                   MOVEL(P)  BLK@TRGT      DDGRNM
015900060203    *C*
016000060203     C                   WHEN      CC = 5
016100060203     C                   MOVEL(P)  BLK@TRGT      DDSTS
016200060203    *C*
016300060203     C                   WHEN      CC = 6
016400060203     C                   MOVEL(P)  BLK@TRGT      DDSUB
016500060203    *C*
016600060203     C                   WHEN      CC = 7
016700060203     C                   MOVEL(P)  BLK@TRGT      @XLTAMT
016800060203     C                   EXSR      $CFG_AMT
016900060203     C                   MOVE      #AMOUNT       DDDPSQ
017000060203    *C*
017100060203     C                   WHEN      CC = 8
017200060203     C                   MOVEL(P)  BLK@TRGT      DDFN
017300060203    *C*
017400060203     C                   WHEN      CC = 9
017500060203     C                   MOVEL(P)  BLK@TRGT      DDLN
017600060203    *C*
017700060203     C                   WHEN      CC = 10
017800060203     C                   MOVEL(P)  BLK@TRGT      DDMRE
017900060203    *C*
018000060203     C                   WHEN      CC = 11
018100060203     C                   MOVEL(P)  BLK@TRGT      DDEI
018200060203    *C*
018300060203     C                   WHEN      CC = 12
018400040130     C                   MOVEL(P)  BLK@TRGT      @CVTDAT
018500040130     C                   EXSR      $CFG_DATE
018600060203     C                   MOVE      #XSX          DDOED
018700040130    *C*
018800060203     C                   WHEN      CC = 13
018900060203     C                   MOVEL(P)  BLK@TRGT      @CVTDAT
019000060203     C                   EXSR      $CFG_DATE
019100060203     C                   MOVE      #XSX          DDMPD
019200040510    *C*
019300060203     C                   WHEN      CC = 14
019400060203     C                   MOVEL(P)  BLK@TRGT      DDPI
019500060203    *C*
019600060203     C                   WHEN      CC = 15
019700060203     C                   MOVEL(P)  BLK@TRGT      DDPN
019800060203    *C*
019900060203     C                   WHEN      CC = 16
020000060203     C                   MOVEL(P)  BLK@TRGT      @CVTDAT
020100060203     C                   EXSR      $CFG_DATE
020200060203     C                   MOVE      #XSX          DDMPE
020300060203    *C*
020400040130     C                   ENDSL
020500040203    ***
020600040203     C                   ENDSR
020700040128   S***S
020800060203     C     $CFG_DATE     BEGSR
020900060203    ***
021000060203     C                   EVAL      #DAY_DGTS = 0
021100060203     C                   EVAL      #MTH_DGTS = 0
021200060203     C                   EVAL      #YR_DGTS = 0
021300060203     C                   MOVEL     @CVTDAT       @DATEIN
021400060203     C                   EVAL      #DATE_PART = 1
021500060203     C                   EVAL      #DO = 1
021600060203     C                   EVAL      #DI = 0
021700060203    ***
021800060203     C                   DO        10            #DI
021900060203    * *
022000060203     C                   IF        DATEIN@(#DI) = '/'
022100060203     C                   ADD       1             #DATE_PART
022200060203     C                   ITER
022300060203     C                   ENDIF
022400060203    * *
022500060203     C                   IF        #DATE_PART = 2 AND #MTH_DGTS = 1
022600060203     C                   ADD       1             #DO
022700060203     C                   EVAL      DATEOUT@(2) = DATEOUT@(1)
022800060203     C                   EVAL      DATEOUT@(1) = '0'
022900060203     C                   EVAL      #MTH_DGTS = 2
023000060203     C                   ENDIF
023100060203    * *
023200060203     C                   IF        #DATE_PART = 3 AND #DAY_DGTS = 1
023300060203     C                   ADD       1             #DO
023400060203     C                   EVAL      DATEOUT@(4) = DATEOUT@(3)
023500060203     C                   EVAL      DATEOUT@(3) = '0'
023600060203     C                   EVAL      #DAY_DGTS = 2
023700060203     C                   ENDIF
023800060203    * *
023900060203     C                   IF        DATEIN@(#DI) = ' '
024000060203     C                   ITER
024100060203     C                   ENDIF
024200060203    * *
024300060203     C                   EVAL      DATEOUT@(#DO) = DATEIN@(#DI)
024400060203     C                   ADD       1             #DO
024500060203    * *
024600060203     C                   SELECT
024700060203     C                   WHEN      #DATE_PART = 1
024800060203     C                   ADD       1             #MTH_DGTS
024900060203     C                   WHEN      #DATE_PART = 2
025000060203     C                   ADD       1             #DAY_DGTS
025100060203     C                   WHEN      #DATE_PART = 3
025200060203     C                   ADD       1             #YR_DGTS
025300060203     C                   ENDSL
025400060203    * *
025500060203     C                   ENDDO
025600060203    ***
025700060203     C                   IF        #YR_DGTS = 2
025800060203     C                   EVAL      DATEOUT@(7) = DATEOUT@(5)
025900060203     C                   EVAL      DATEOUT@(8) = DATEOUT@(6)
026000060203     C                   EVAL      DATEOUT@(5) = '2'
026100060203     C                   EVAL      DATEOUT@(6) = '0'
026200060203     C                   ENDIF
026300060203    ***
026400060203     C                   MOVEL     @DATEOUT      #XSX
026500060203     C                   MOVE      #XSX          #USA
026600060203     C                   MOVE      #USA          #ISO
026700060203     C                   MOVE      #ISO          #XSX
026800060203    ***
026900060203     C                   ENDSR
027000060203   S***S
027100060203     C     $CFG_AMT      BEGSR
027200060203    ***
027300060203     C                   EVAL      NEG_FND = NO
027400060203     C                   EVAL      #PC = 1
027500060203     C                   MOVE      *ALL'0'       @DOLLAR
027600060203     C                   MOVE      '00'          @CENTS
027700060203     C                   EVAL      X = 16
027800060203     C                   EVAL      Y = 16
027900060203     C                   EVAL      #CP = 3
028000060203     C                   EVAL      #2 = 0
028100060203    ***
028200060203     C                   DO        15
028300060203    * *
028400060203     C                   SUB       1             X
028500060203    * *
028600060203     C                   SELECT
028700060203     C                   WHEN      XA@(X) = ' '
028800060203     C                   ITER
028900060203     C                   WHEN      XA@(X) = '.'
029000060203     C                   ADD       1             #PC
029100060203     C                   ITER
029200060203     C                   WHEN      XA@(X) = '-'
029300060203     C                   EVAL      NEG_FND = YES
029400060203     C                   ITER
029500060203     C                   ENDSL
029600060203    * *
029700060203     C                   IF        #PC = 1
029800060203     C                   SUB       1             #CP
029900060203     C                   EVAL      %SUBST(@CENTS:#CP:1) = XA@(X)
030000060203     C                   ELSE
030100060203     C                   SUB       1             Y
030200060203     C                   EVAL      DLR@(Y) = XA@(X)
030300060203     C                   ENDIF
030400060203    * *
030500060203     C                   ENDDO
030600060203    ***
030700060203     C                   MOVE      @DOLLAR       #15
030800060203    ***
030900060203     C                   IF        @CENTS <> '00'
031000060203     C                   MOVE      @CENTS        #2
031100060203     C                   EVAL      #17V2 = #15 + (#2 / 100)
031200060203     C                   ELSE
031300060203     C                   EVAL      #17V2 = #15
031400060203     C                   ENDIF
031500060203    ***
031600060203     C                   IF        NEG_FND = YES
031700060203     C                   MULT      -1            #17V2
031800060203     C                   ENDIF
031900060203    ***
032000060203     C                   Z-ADD     #17V2         #AMOUNT
032100060203    ***
032200060203     C                   ENDSR
032300060203   S***S
032400060203     C     $CFG_CNT      BEGSR
032500060203    ***
032600060203     C                   EVAL      NEG_FND = NO
032700060203     C                   EVAL      #PC = 1
032800060203     C                   MOVE      *ALL'0'       @DOLLAR
032900060203     C                   EVAL      X = 16
033000060203     C                   EVAL      Y = 16
033100060203     C                   MOVE      *ZEROS        #COUNT
033200060203    ***
033300060203     C                   DO        15
033400060203    * *
033500060203     C                   SUB       1             X
033600060203    * *
033700060203     C                   SELECT
033800060203     C                   WHEN      XA@(X) = ' '
033900060203     C                   ITER
034000060203    * *
034100060203     C                   WHEN      XA@(X) = '-'
034200060203     C                   EVAL      NEG_FND = YES
034300060203     C                   ITER
034400060203     C                   ENDSL
034500060203    * *
034600060203     C                   SUB       1             Y
034700060203     C                   EVAL      DLR@(Y) = XA@(X)
034800060203    * *
034900060203     C                   ENDDO
035000060203    ***
035100060203     C                   MOVE      @DOLLAR       #15
035200060203    ***
035300060203     C                   IF        NEG_FND = YES
035400060203     C                   MULT      -1            #15
035500060203     C                   ENDIF
035600060203    ***
035700060203     C                   Z-ADD     #15           #COUNT
035800060203    ***
035900060203     C                   ENDSR
036000060203   S***S
