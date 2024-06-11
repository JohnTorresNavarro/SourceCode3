000100130328     FDW373WF   IPE  F 2000        DISK
000200130203     FMEMALT    UF A E           K DISK
000300130203   X***X
000400130328     D DS@MEM        E DS                  EXTNAME(MEMALT)
000500130203     D KF@MID          S                   LIKE(MAMEMID)
000600130203     D KF@TID          S                   LIKE(MAALTID)
000700130203     D KF@TTP          S                   LIKE(MAALTTP)
000800130203    ***
000900130203     D H@LNAME         S                   LIKE(MALNAME)
001000130203     D H@FNAME         S                   LIKE(MAFNAME)
001100130203    ***
001200130203     D                 DS
001300130328     D @SRCE                   1   2000A   DIM(2000)
001400130328     D BLK@SRCE                1   2000A
001500130203    ***
001600130203     D                 DS
001700130328     D @TRGT                   1   2000A   DIM(2000)
001800130328     D BLK@TRGT                1   2000A
001900130203    ***
002000130328     D I#NDX           S              5S 0
002100130328     D O#NDX           S              5S 0
002200130328     D CC              S              5S 0
002300130328     D MAX_CC          S              5S 0 INZ(10)
002400130203    ***
002500130203     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
002600130203     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
002700130203    ***
002800130203     D @CVTDAT         S             10A
002900130203     D POS             S              5U 0
003000130203     D @4              S              4A
003100130203     D #4              S              4S 0
003200130203     D #DI             S              3S 0
003300130203     D #DO             S              3S 0
003400130203     D #DATE_PART      S              3S 0
003500130203     D #MTH_DGTS       S              1S 0
003600130203     D #DAY_DGTS       S              1S 0
003700130203     D #YR_DGTS        S              1S 0
003800130203    ***
003900130203     D                 DS
004000130203     D DATEIN@                 1     10A   DIM(10)
004100130203     D @DATEIN                 1     10A
004200130203    ***
004300130203     D                 DS
004400130203     D DATEOUT@                1     10A   DIM(10)
004500130203     D @DATEOUT                1     10A
004600130203    ***
004700130203     D #ERRORS         S              5S 0
004800130203     D #COUNT          S             12S 0
004900130203     D #AMOUNT         S             11S 2
005000130203     D #PC             S              1S 0
005100130203     D #CP             S              1S 0
005200130203     D @CENTS          S              2A
005300130203     D #2              S              2S 0
005400130203     D #15             S             15S 0
005500130203     D #17V2           S             17S 2
005600130203    ***
005700130203     D @15             S             15A
005800130203     D #15S4           S             15S 4
005900130203     D NEG             S              1A
006000130203     D POS2            S              5U 0
006100130203     D N@15            S             15A
006200130203     D X               S              2S 0
006300130203     D Y               S              2S 0
006400130203    ***
006500130203     D #11             S             11S 0
006600130203     D @11             S             11A
006700130203     D                 DS
006800130203     D @DOLLAR                 1     15A
006900130203     D DLR@                    1     15A   DIM(15)
007000130203    ***
007100130203     D                 DS
007200130203     D @XLTAMT                 1     15A
007300130203     D XA@                     1     15A   DIM(15)
007400130203    ***
007500130203     D YES             S               N   INZ(*ON)
007600130203     D NO              S               N   INZ(*OFF)
007700130203     D FIELD_FND       S               N
007800130203     D QUOTES_FND      S               N
007900130203     D NEG_FND         S               N
008000130203    ***
008100130203     D #TODAY          S              8S 0
008200130203     D #XSX            S              8S 0
008300130203     D #ISO            S               D   DATFMT(*ISO)
008400130203     D #USA            S               D   DATFMT(*USA)
008500130203     D INZ#ISO         S               D   DATFMT(*ISO)
008600130203     D INZ#USA         S               D   DATFMT(*USA)
008700130203    ***
008800130203   X***X
008900130328     IDW373WF   AA
009000130328     I                                  1 2000  INPUT_FLD
009100130203    ***
009200130203   X***X
009300130203     C                   CLEAR                   BLK@TRGT
009400130203     C                   CLEAR                   BLK@SRCE
009500130203    ***
009600130203     C                   EVAL      BLK@SRCE = INPUT_FLD
009700130203     C     LO:UP         XLATE     BLK@SRCE      BLK@SRCE
009800130203     C                   EVAL      I#NDX = 0
009900130203     C                   EVAL      CC = 0
010000130203    ***
010100130328     C                   IF        %SUBST(BLK@SRCE:1:7) <> 'CUSTOME'
010200130328     C                   DOU       CC > MAX_CC OR I#NDX = 2000
010300130203     C                   EXSR      $GET_FLD
010400130203     C                   EXSR      $PROC_FLD
010500130203     C                   ENDDO
010600130203     C                   ENDIF
010700130203    ***
010800130203    ***
010900130203   S***S
011000130203     C     *INZSR        BEGSR
011100130203    ***
011200130203     C                   EVAL      #ERRORS = 0
011300130203     C                   EVAL      #ISO = %DATE
011400130203     C                   MOVE      #ISO          #TODAY
011500130203    ***
011600130203     C     KEY#MALT      KLIST
011700130203     C                   KFLD                    KF@MID
011800130203     C                   KFLD                    KF@TTP
011900130328     C****************** KFLD                    KF@TID
012000130203    ***
012100130328     C                   EVAL      KF@TTP = 'UH'
012200130203    ***
012300130203     C                   ENDSR
012400130203   S***S
012500130203     C     $GET_FLD      BEGSR
012600130203    ***
012700130203     C                   CLEAR                   BLK@TRGT
012800130203     C                   EVAL      O#NDX = 0
012900130203     C                   EVAL      FIELD_FND = NO
013000130203     C                   EVAL      QUOTES_FND = NO
013100130203    ***
013200130203     C                   EVAL      #DAY_DGTS = 0
013300130203     C                   EVAL      #MTH_DGTS = 0
013400130203     C                   EVAL      #YR_DGTS = 0
013500130203     C                   EVAL      #DATE_PART = 1
013600130203     C                   EVAL      #DO = 1
013700130203     C                   EVAL      #DI = 0
013800130203     C                   MOVE      INZ#ISO       #ISO
013900130203     C                   MOVE      INZ#USA       #USA
014000130203     C                   EVAL      #XSX = 0
014100130203     C                   EVAL      NEG_FND = NO
014200130203     C                   EVAL      #PC = 1
014300130203     C                   MOVE      *ALL'0'       @DOLLAR
014400130203     C                   MOVE      '00'          @CENTS
014500130203     C                   EVAL      X = 16
014600130203     C                   EVAL      Y = 16
014700130203     C                   EVAL      #CP = 3
014800130203     C                   EVAL      #2 = 0
014900130203     C                   EVAL      #15 = 0
015000130203     C                   EVAL      #17V2 = 0.00
015100130203     C                   EVAL      #AMOUNT = 0.00
015200130203     C                   EVAL      #COUNT = 0
015300130203    ***
015400130203     C                   ADD       1             CC
015500130328     C                   DOU       I#NDX = 2000 OR FIELD_FND = YES
015600130203     C                   EXSR      $CHK_EA_POS
015700130203     C                   ENDDO
015800130203    ***
015900130203     C                   ENDSR
016000130203   S***S
016100130203     C     $CHK_EA_POS   BEGSR
016200130203    ***
016300130203     C                   ADD       1             I#NDX
016400130203    ***
016500130328     C                   IF        @SRCE(I#NDX) = ',' AND QUOTES_FND = NO
016600130203     C                   EVAL      FIELD_FND = YES
016700130203     C                   LEAVESR
016800130203     C                   ENDIF
016900130203    ***
017000130203     C                   IF        @SRCE(I#NDX) = '"'
017100130203    * *
017200130203     C                   IF        QUOTES_FND = YES
017300130203     C                   EVAL      QUOTES_FND = NO
017400130203     C                   ELSE
017500130203     C                   EVAL      QUOTES_FND = YES
017600130203     C                   ENDIF
017700130203    * *
017800130203     C                   LEAVESR
017900130203    * *
018000130203     C                   ENDIF
018100130203    ***
018200130203     C                   ADD       1             O#NDX
018300130203     C                   EVAL      @TRGT(O#NDX) = @SRCE(I#NDX)
018400130203    ***
018500130203     C                   ENDSR
018600130203   S***S
018700130203     C     $PROC_FLD     BEGSR
018800130203    ***
018900130203     C                   SELECT
019000130203    *C*
019100130328     C                   WHEN      CC = 4
019200130203     C                   MOVEL(P)  BLK@TRGT      KF@MID
019300130328    *C*
019400130328     C                   WHEN      CC = 6
019500130328     C                   MOVEL(P)  BLK@TRGT      KF@TID
019600130203    *C*
019700130328     C                   WHEN      CC = 7
019800130328     C                   IF        BLK@TRGT <> 'EE '
019900130328     C                   EVAL      I#NDX = 2000
020000130203     C                   ENDIF
020100130328    *C*
020200130328     C                   WHEN      CC = 8
020300130328     C                   MOVEL(P)  BLK@TRGT      H@LNAME
020400130328    *C*
020500130328     C                   WHEN      CC = 9
020600130328     C                   MOVEL(P)  BLK@TRGT      H@FNAME
020700130328     C                   EXSR      $GEN_REC
020800130328     C                   EVAL      I#NDX = 2000
020900130203    ***
021000130203     C                   ENDSL
021100130203    ***
021200130203     C                   ENDSR
021300130203   S***S
021400130328     C     $GEN_REC      BEGSR
021500130328    ***
021600130328     C     KEY#MALT      CHAIN     MEMALTR
021700130328     C                   IF        NOT %FOUND(MEMALT)
021800130328    ***
021900130328     C                   CLEAR                   MEMALTR
022000130328     C                   EVAL      MAMEMID = KF@MID
022100130328     C                   EVAL      MAALTID = KF@TID
022200130328     C                   EVAL      MAALTTP = 'UH '
022300130328     C                   EVAL      MALNAME = H@LNAME
022400130328     C                   EVAL      MAFNAME = H@FNAME
022500130328     C                   MOVE      #TODAY        MACRTDT
022600130328     C                   WRITE     MEMALTR
022700130328    ***
022800130328     C                   ELSE
022900130328    ***
023000130328     C                   IF        MAALTID <> KF@TID
023100130328     C                   EVAL      MAALTID = KF@TID
023200130328     C                   UPDATE    MEMALTR
023300130328     C                   ENDIF
023400130328    ***
023500130328     C                   ENDIF
023600130328    ***
023700130328     C                   ENDSR
023800130328   S***S
