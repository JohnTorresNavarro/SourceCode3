000100130110   X***X EDIT ADJUSTMENT CSV LOAD TO WORK FILE
000200130109   X***X
000300130110   X***X READ CSV LINE, PARSE, TEST, IF ERROR, FAIL THE FILE
000400130109   X***X
000500130110   X***X SSK 01/10/13
000600130307   X***X
000700130307   X***X SSK 03/07/2013
000800130307   X***X CURRENT MONTH IS NOW CALLED MITCH#MTH AND IS NOT CURRENT CALENDAR MONTH,
000900130307   X***X  BUT THE PREVIOUS MONTH THAT HE IS ADJUSTING.  SO WE NEED TO SUBTRACT
001000130307   X***X  ONE MONTH FROM CURRENT TO FIND THE MITCH MONTH.
001100130307   X***X
001101200708   X***X JT 07/08/2020 - Eliiminated error (Missing Contract Count)
001200130109   X***X
001300130122     FRPA61WF   IPE  F  200        DISK
001400130109    ***
001500130110     FRPA060L2  IF   E           K DISK
001600130110    ***
001700130109     FTRMUNIQUE IF   E           K DISK
001800130109     FSUMUNIQUE IF   E           K DISK
001900130109     FACMUNIQUE IF   E           K DISK
002000130109     FGRATEL1   IF   E           K DISK    RENAME(GRATER:GRAT1)
002100130109     FGRATEL2   IF   E           K DISK    RENAME(GRATER:GRAT2)
002200130109     FPLNUNIQUE IF   E           K DISK
002300130109     FSMANRLT   IF   E           K DISK
002400130109    ***
002500130122     FRPA60WF   O  A E             DISK
002600130109    ***
002700130109     FT2000     O  A F 2000        DISK
002800130109   X***X
002900130110     D @OUT            S           2000A
003000130109    ***
003100130109     D @CVTDAT         S             10A
003200130109     D POS             S              5U 0
003300130110     D @4              S              4A
003400130110     D #4              S              4S 0
003500130109     D #DI             S              3S 0
003600130109     D #DO             S              3S 0
003700130109     D #DATE_PART      S              3S 0
003800130109     D #MTH_DGTS       S              1S 0
003900130109     D #DAY_DGTS       S              1S 0
004000130109     D #YR_DGTS        S              1S 0
004100130109    ***
004200130109     D                 DS
004300130109     D DATEIN@                 1     10A   DIM(10)
004400130109     D @DATEIN                 1     10A
004500130109    ***
004600130109     D                 DS
004700130109     D DATEOUT@                1     10A   DIM(10)
004800130109     D @DATEOUT                1     10A
004900130109    ***
005000130109     D #ERRORS         S              5S 0
005100130109     D #COUNT          S             12S 0
005200130109     D #AMOUNT         S             11S 2
005300130109     D #PC             S              1S 0
005400130109     D #CP             S              1S 0
005500130109     D @CENTS          S              2A
005600130109     D #2              S              2S 0
005700130109     D #15             S             15S 0
005800130109     D #17V2           S             17S 2
005900130109    ***
006000130109     D @15             S             15A
006100130109     D #15S4           S             15S 4
006200130109     D NEG             S              1A
006300130109     D POS2            S              5U 0
006400130109     D N@15            S             15A
006500130109     D X               S              2S 0
006600130109     D Y               S              2S 0
006700130109    ***
006800130109     D #11             S             11S 0
006900130109     D @11             S             11A
007000130109     D                 DS
007100130109     D @DOLLAR                 1     15A
007200130109     D DLR@                    1     15A   DIM(15)
007300130109    ***
007400130109     D                 DS
007500130109     D @XLTAMT                 1     15A
007600130109     D XA@                     1     15A   DIM(15)
007700130109    ***
007800130109     D YES             S               N   INZ(*ON)
007900130109     D NO              S               N   INZ(*OFF)
008000130109     D FIELD_FND       S               N
008100130109     D QUOTES_FND      S               N
008200130109     D NEG_FND         S               N
008300130109    ***
008400130307     D MITCH#MTH       S              2A
008500130307     D*#CURMTH         S              2A
008600130211     D @XSX            S              8A
008700130109     D #XSX            S              8S 0
008800130109     D #ISO            S               D   DATFMT(*ISO)
008900130109     D #USA            S               D   DATFMT(*USA)
009000130109     D INZ#ISO         S               D   DATFMT(*ISO)
009100130109     D INZ#USA         S               D   DATFMT(*USA)
009200130109    ***
009300130109     D                 DS
009400130109     D @SRCE                   1    200A   DIM(200)
009500130109     D BLK@SRCE                1    200A
009600130109    ***
009700130109     D                 DS
009800130109     D @TRGT                   1    200A   DIM(200)
009900130109     D BLK@TRGT                1    200A
010000130109    ***
010100130109     D I#NDX           S              3S 0
010200130109     D O#NDX           S              3S 0
010300130109     D CC              S              3S 0
010400130111     D MAX_CC          S              3S 0 INZ(17)
010500130109    ***
010600130109     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
010700130109     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
010800130109    ***
010900130109   X***X
011000130122     IRPA61WF   AA
011100130109     I                                  1  200  INPUT_FLD
011200130109   X***X
011300130109    ***
011400130109     C                   CLEAR                   BLK@TRGT
011500130109     C                   CLEAR                   BLK@SRCE
011600130109    ***
011700130109     C                   EVAL      BLK@SRCE = INPUT_FLD
011800130109     C     LO:UP         XLATE     BLK@SRCE      BLK@SRCE
011900130109     C                   EVAL      I#NDX = 0
012000130109     C                   EVAL      CC = 0
012100130109     C                   MOVE      *BLANKS       MSG@PRT         800
012200130109     C                   MOVE      *BLANKS       @EMSG            40
012300130109     C                   MOVE      'N'           @VT               1
012400130109     C                   MOVE      'N'           @VS               1
012500130109    ***
012600130111     C                   DOU       CC > MAX_CC OR I#NDX = 200
012700130109     C                   EXSR      $GET_FLD
012800130109     C                   EXSR      $PROC_FLD
012900130109     C                   ENDDO
013000130110    ***
013100130110     C                   IF        MSG@PRT = *BLANKS
013200130110     C     KEY#RPA       CHAIN     RPA60R
013300130110     C                   IF        %FOUND(RPA060L2)
013400130110     C                   EVAL      @EMSG = 'RECORD ALREADY EXISTS, ' +
013500130110     C                             'ADD DENIED'
013600130110     C                   EXSR      $EMSG
013700130110     C                   ENDIF
013800130110     C                   ENDIF
013900130110    ***
014000130110     C                   IF        MSG@PRT = *BLANKS
014100130122     C                   WRITE     R60F
014200130110     C                   ELSE
014300130110     C                   EVAL      @OUT = %TRIM(INPUT_FLD) + ',"ERROR: ' +
014400130110     C                             %TRIM(MSG@PRT) + '"'
014500130110     C                   EXCEPT    OUTF
014600130110     C                   ENDIF
014700130110    ***
014800130109    ***
014900130109     CLR                 MOVE      #ERRORS       @PARM
015000130109    ***
015100130109    ***
015200130109    ***
015300130109   S***S
015400130109     C     *INZSR        BEGSR
015500130109    ***
015600130109     C                   EVAL      #ERRORS = 0
015700130211     C                   EVAL      #ISO = %DATE
015800130307     C                   SUBDUR    1:*M          #ISO
015900130211     C                   MOVE      #ISO          #XSX
016000130211     C                   MOVE      #XSX          @XSX
016100130307     C                   EVAL      MITCH#MTH = %SUBST(@XSX:5:2)
016200130307     C*******************EVAL      #CURMTH = %SUBST(@XSX:5:2)
016300130109    ***
016400130109     C     *ENTRY        PLIST
016500130109     C                   PARM                    @PARM             5
016600130109    ***
016700130109     C     KL#TSA        KLIST
016800130122     C                   KFLD                    R6TRS
016900130122     C                   KFLD                    R6SUB
017000130122     C                   KFLD                    R6ACC
017100130109    ***
017200130109     C     KL#TS         KLIST
017300130122     C                   KFLD                    R6TRS
017400130122     C                   KFLD                    R6SUB
017500130109    ***
017600130109     C     KL#TSP        KLIST
017700130122     C                   KFLD                    R6TRS
017800130122     C                   KFLD                    R6SUB
017900130122     C                   KFLD                    R6PLN
018000130109    ***
018100130109     C     KL#GTSP       KLIST
018200130122     C                   KFLD                    R6GRP
018300130122     C                   KFLD                    R6TRS
018400130122     C                   KFLD                    R6SUB
018500130122     C                   KFLD                    R6PLN
018600130109    ***
018700130110     C     KEY#RPA       KLIST
018800130122     C                   KFLD                    R6CPDDT
018900130122     C                   KFLD                    R6CDAT
019000130122     C                   KFLD                    R6SEQ
019100130122     C                   KFLD                    R6RELID
019200130122     C                   KFLD                    R6TRS
019300130122     C                   KFLD                    R6SUB
019400130122     C                   KFLD                    R6ACC
019500130122     C                   KFLD                    R6GRP
019600130122     C                   KFLD                    R6PLN
019700130122     C                   KFLD                    R6EFDT
019800130109    ***
019900130116     C                   EVAL      @OUT = '"COMM REMIT DATE","SEQ NBR","COMM ' +
020000130116     C                             'PAID DATE","RELID","TRUST","SUB","ACCT","' +
020100130116     C                             'GROUP #","PLAN ID","EFFECTIVE DATE","PLAN' +
020200130116     C                             ' PREM","MBR CNT","COMM RATE","METHOD","PR' +
020300130116     C                             'EM SPLIT","PAID","NOTE","ERROR"'
020400130116     C                   EXCEPT    OUTF
020500130109    ***
020600130109     C                   ENDSR
020700130109   S***S
020800130109     C     $GET_FLD      BEGSR
020900130109    ***
021000130109     C                   CLEAR                   BLK@TRGT
021100130109     C                   EVAL      O#NDX = 0
021200130109     C                   EVAL      FIELD_FND = NO
021300130109     C                   EVAL      QUOTES_FND = NO
021400130109    ***
021500130109     C                   EVAL      #DAY_DGTS = 0
021600130109     C                   EVAL      #MTH_DGTS = 0
021700130109     C                   EVAL      #YR_DGTS = 0
021800130109     C                   EVAL      #DATE_PART = 1
021900130109     C                   EVAL      #DO = 1
022000130109     C                   EVAL      #DI = 0
022100130109     C                   MOVE      INZ#ISO       #ISO
022200130109     C                   MOVE      INZ#USA       #USA
022300130109     C                   EVAL      #XSX = 0
022400130109     C                   EVAL      NEG_FND = NO
022500130109     C                   EVAL      #PC = 1
022600130109     C                   MOVE      *ALL'0'       @DOLLAR
022700130109     C                   MOVE      '00'          @CENTS
022800130109     C                   EVAL      X = 16
022900130109     C                   EVAL      Y = 16
023000130109     C                   EVAL      #CP = 3
023100130109     C                   EVAL      #2 = 0
023200130109     C                   EVAL      #15 = 0
023300130109     C                   EVAL      #17V2 = 0.00
023400130109     C                   EVAL      #AMOUNT = 0.00
023500130109     C                   EVAL      #COUNT = 0
023600130109    ***
023700130109     C                   ADD       1             CC
023800130111     C                   DOU       I#NDX = 200 OR FIELD_FND = YES
023900130109     C                   EXSR      $CHK_EA_POS
024000130109     C                   ENDDO
024100130109    ***
024200130109     C                   ENDSR
024300130109   S***S
024400130109     C     $CHK_EA_POS   BEGSR
024500130109    ***
024600130109     C                   ADD       1             I#NDX
024700130109    ***
024800130109     C                   IF        @SRCE(I#NDX) = ',' AND QUOTES_FND = NO
024900130109     C                   EVAL      FIELD_FND = YES
025000130109     C                   LEAVESR
025100130109     C                   ENDIF
025200130109    ***
025300130109     C                   IF        @SRCE(I#NDX) = '"'
025400130109    * *
025500130109     C                   IF        QUOTES_FND = YES
025600130109     C                   EVAL      QUOTES_FND = NO
025700130109     C                   ELSE
025800130109     C                   EVAL      QUOTES_FND = YES
025900130109     C                   ENDIF
026000130109    * *
026100130109     C                   LEAVESR
026200130109    * *
026300130109     C                   ENDIF
026400130109    ***
026500130109     C                   ADD       1             O#NDX
026600130109     C                   EVAL      @TRGT(O#NDX) = @SRCE(I#NDX)
026700130109    ***
026800130109     C                   ENDSR
026900130109   S***S
027000130109     C     $PROC_FLD     BEGSR
027100130109    ***
027200130109     C                   SELECT
027300130109    *C*
027400130109     C                   WHEN      CC = 1
027500130109     C                   MOVEL(P)  BLK@TRGT      #XSX
027600130204     C                   TEST(DE)                #XSX
027700130204     C                   IF        %ERROR
027800130204     C                   EVAL      @EMSG = 'COMM REMIT DATE NOT VALID'
027900130204     C                   EXSR      $EMSG
028000130204     C                   ELSE
028100130122     C                   Z-ADD     #XSX          R6CDAT
028200130204     C                   ENDIF
028300130109    *C*
028400130109     C                   WHEN      CC = 2
028500130109     C                   MOVEL     BLK@TRGT      @2                2
028600130110     C                   EVAL      POS = %CHECK( '0123456789' : @2 )
028700130110     C                   IF        POS > *ZERO
028800130109     C                   EVAL      @EMSG = 'SEQ # NOT VALID'
028900130109     C                   EXSR      $EMSG
029000130109     C                   ELSE
029100130122     C                   MOVE      @2            R6SEQ
029200130109     C                   ENDIF
029300130109    *C*
029400130109     C                   WHEN      CC = 3
029500130109     C                   MOVEL(P)  BLK@TRGT      #XSX
029600130204     C***                TEST(DE)                #XSX
029700130204     C***                IF        %ERROR OR
029800130204     C***                          %SUBST(BLK@TRGT:7:2) <> '01'
029900130204     C***                EVAL      @EMSG = 'COMM PAID DATE NOT VALID'
030000130204     C***                EXSR      $EMSG
030100130204     C***                ELSE
030200130122     C                   Z-ADD     #XSX          R6CPDDT
030300130204     C***                ENDIF
030400130211     C                   IF        #XSX > 0
030500130307     C                   IF        %SUBST(BLK@TRGT:5:2) <> MITCH#MTH
030600130307     C*******************IF        %SUBST(BLK@TRGT:5:2) <> #CURMTH
030700130211     C                   EVAL      @EMSG = 'COMM PAID DATE NOT CURRENT OR ZERO'
030800130211     C                   EXSR      $EMSG
030900130211     C                   ENDIF
031000130211     C                   ENDIF
031100130109    *C*
031200130109     C                   WHEN      CC = 4
031300130122     C                   EVAL      R6RELID = %SUBST(BLK@TRGT:1:8)
031400130122     C                   IF        R6RELID = *BLANKS
031500130109     C                   EVAL      @EMSG = 'INVALID RELID'
031600130109     C                   EXSR      $EMSG
031700130109     C                   ELSE
031800130122     C     R6RELID       CHAIN     SRF
031900130109     C                   IF        NOT %FOUND(SMANRLT)
032000130109     C                   EVAL      @EMSG = 'INVALID RELID'
032100130109     C                   EXSR      $EMSG
032200130109     C                   ENDIF
032300130109     C                   ENDIF
032400130109    *C*
032500130109     C                   WHEN      CC = 5
032600130109     C                   MOVEL     BLK@TRGT      @3                3
032700130110     C                   EVAL      POS = %CHECK( '0123456789' : @3 )
032800130110     C                   IF        POS > *ZERO
032900130109     C                   EVAL      @EMSG = 'TRUST NOT VALID'
033000130109     C                   EXSR      $EMSG
033100130109     C                   ELSE
033200130122     C                   MOVE      @3            R6TRS
033300130122     C     R6TRS         CHAIN     TRSMSR
033400130109     C                   IF        NOT %FOUND(TRMUNIQUE)
033500130109     C                   EVAL      @EMSG = 'TRUST NOT VALID'
033600130109     C                   EXSR      $EMSG
033700130109     C                   ELSE
033800130109     C                   MOVE      'Y'           @VT
033900130109     C                   ENDIF
034000130109     C                   ENDIF
034100130109    *C*
034200130109     C                   WHEN      CC = 6
034300130109     C                   MOVEL     BLK@TRGT      @3
034400130110     C                   EVAL      POS = %CHECK( '0123456789' : @3 )
034500130110     C                   IF        POS > *ZERO
034600130109     C                   EVAL      @EMSG = 'SUBDVSN NOT VALID'
034700130109     C                   EXSR      $EMSG
034800130109     C                   ELSE
034900130122     C                   MOVE      @3            R6SUB
035000130109     C                   IF        @VT = 'Y'
035100130109     C     KL#TS         CHAIN     SUBMSR
035200130109     C                   IF        NOT %FOUND(SUMUNIQUE)
035300130109     C                   EVAL      @EMSG = 'SUBDVSN NOT VALID'
035400130109     C                   EXSR      $EMSG
035500130109     C                   ELSE
035600130111     C                   MOVE      'Y'           @VS
035700130109     C                   ENDIF
035800130109     C                   ENDIF
035900130109     C                   ENDIF
036000130109    *C*
036100130109     C                   WHEN      CC = 7
036200130110     C                   MOVEL     BLK@TRGT      @4
036300130110     C                   EVAL      POS = %CHECK( '0123456789' : @4 )
036400130110     C                   IF        POS > *ZERO
036500130109     C                   EVAL      @EMSG = 'ACCOUNT NOT VALID'
036600130109     C                   EXSR      $EMSG
036700130109     C                   ELSE
036800130122     C                   MOVE      @4            R6ACC
036900130109     C                   IF        @VS = 'Y'
037000130109     C     KL#TSA        CHAIN     ACCMSR
037100130109     C                   IF        NOT %FOUND(ACMUNIQUE)
037200130109     C                   EVAL      @EMSG = 'ACCOUNT NOT VALID'
037300130109     C                   EXSR      $EMSG
037400130109     C                   ENDIF
037500130109     C                   ENDIF
037600130109     C                   ENDIF
037700130109    *C*
037800130109     C                   WHEN      CC = 8
037900130122     C                   EVAL      R6GRP = %SUBST(BLK@TRGT:1:15)
038000130122     C                   IF        R6GRP = *BLANKS
038100130109     C                   EVAL      @EMSG = 'INVALID GROUP'
038200130109     C                   EXSR      $EMSG
038300130109     C                   ELSE
038400130122     C     R6GRP         CHAIN     GRAT1
038500130109     C                   IF        NOT %FOUND(GRATEL1)
038600130109     C                   EVAL      @EMSG = 'INVALID GROUP'
038700130109     C                   EXSR      $EMSG
038800130122     C                   EVAL      R6GRP = *BLANKS
038900130109     C                   ENDIF
039000130109     C                   ENDIF
039100130109    *C*
039200130109     C                   WHEN      CC = 9
039300130122     C                   MOVEL     BLK@TRGT      R6PLN
039400130122     C                   IF        R6PLN = *BLANKS
039500130109     C                   EVAL      @EMSG = 'PLAN NOT VALID'
039600130109     C                   EXSR      $EMSG
039700130109     C                   ELSE
039800130109     C                   IF        @VS = 'Y'
039900130109     C     KL#TSP        CHAIN     PLNMSR
040000130109     C                   IF        NOT %FOUND(PLNUNIQUE)
040100130109     C                   EVAL      @EMSG = 'PLAN NOT VALID'
040200130109     C                   EXSR      $EMSG
040300130109     C                   ELSE
040400130122     C                   IF        R6GRP <> *BLANKS
040500130109     C     KL#GTSP       CHAIN     GRAT2
040600130109     C                   IF        NOT %FOUND(GRATEL2)
040700130109     C                   EVAL      @EMSG = 'INVALID GROUP'
040800130109     C                   EXSR      $EMSG
040900130109     C                   ENDIF
041000130109     C                   ENDIF
041100130109     C                   ENDIF
041200130109     C                   ENDIF
041300130109     C                   ENDIF
041400130109    *C*
041500130109     C                   WHEN      CC = 10
041600130109     C                   MOVEL(P)  BLK@TRGT      #XSX
041700130109     C                   TEST(DE)                #XSX
041800130109     C                   IF        %ERROR
041900130109     C                   EVAL      @EMSG = 'EFF DATE NOT VALID'
042000130109     C                   EXSR      $EMSG
042100130109     C                   ELSE
042200130122     C                   Z-ADD     #XSX          R6EFDT
042300130109     C                   ENDIF
042400130109    *C*
042500130109     C                   WHEN      CC = 11
042600130109     C                   MOVEL(P)  BLK@TRGT      @XLTAMT
042700130109     C                   EXSR      $CFG_AMT
042800130122     C                   Z-ADD     #AMOUNT       R6PPRM
042900130109    *C*
043000130109     C                   WHEN      CC = 12
043100130109     C                   MOVEL(P)  BLK@TRGT      @XLTAMT
043200130121     C                   EXSR      $CFG_AMT
043300130122     C                   Z-ADD     #AMOUNT       R6MCNT
043400130109    *C*
043500130109     C                   WHEN      CC = 13
043600130109     C                   MOVEL(P)  BLK@TRGT      @XLTAMT
043700130109     C                   EXSR      $CFG_AMT
043800130122     C                   Z-ADD     #AMOUNT       R6CMRT
043900130109    *C*
044000130109     C                   WHEN      CC = 14
044100130122     C                   MOVEL(P)  BLK@TRGT      R6MTHD
044200130122     C                   IF        R6MTHD <> 'G' AND R6MTHD <> 'C' AND
044300130122     C                             R6MTHD <> 'F' AND R6MTHD <> 'O' AND
044400130122     C                             R6MTHD <> 'P'
044500130109     C                   EVAL      @EMSG = 'METHOD IS INVALID'
044600130109     C                   EXSR      $EMSG
044700130109     C                   ENDIF
044800130109    *C*
044900130109     C                   WHEN      CC = 15
045000130110     C                   EVALR     @15 = %TRIM(BLK@TRGT)
045100130110     C                   EXSR      $CFG_AM4
045200130122     C                   EVAL      R6PSPL = #15S4
045300130109    *C*
045400130109     C                   WHEN      CC = 16
045500130122     C                   MOVEL(P)  BLK@TRGT      R6PAID
045600130122     C                   IF        R6PAID <> 'Y' AND R6PAID <> 'N'
045700130110     C                   EVAL      @EMSG = 'COMM PAID FLAG IS INVALID'
045800130110     C                   EXSR      $EMSG
045900130110     C                   ENDIF
046000130204     C                   IF        (                R6MTHD = 'C' OR
046100130204     C                             R6MTHD = 'F') AND R6PAID = 'Y' AND
046200130204     C                             R6MCNT = 0.00
046300200708     C****               EVAL      @EMSG = 'MISSING CONTRACT COUNT'
046400200708     C****               EXSR      $EMSG
046500130110     C                   ENDIF
046600130204     C                   IF        (R6MTHD = 'O' OR R6MTHD = 'P') AND
046700130204     C                             R6PAID = 'Y' AND
046800130204     C                             R6PPRM = 0.00
046900130204     C                   EVAL      @EMSG = 'MISSING PREMIUM'
047000130204     C                   EXSR      $EMSG
047100130204     C                   ENDIF
047200130122     C                   IF        R6PAID = 'N' AND
047300130122     C                             (R6PPRM <> 0 OR R6MCNT <> 0)
047400130110     C                   EVAL      @EMSG = 'PREM/COUNT SHOULD BE ZERO'
047500130110     C                   EXSR      $EMSG
047600130110     C                   ENDIF
047700130109    *C*
047800130109     C                   WHEN      CC = 17
047900130122     C                   MOVEL(P)  BLK@TRGT      R6NOTE
048000130110    ***
048100130110     C                   ENDSL
048200130109    ***
048300130109     C                   ENDSR
048400130109   S***S
048500130109     C     $EMSG         BEGSR
048600130109    ***
048700130109     C                   ADD       1             #ERRORS
048800130109    ***
048900130109     C                   IF        MSG@PRT = *BLANKS
049000130109     C                   EVAL      MSG@PRT = %TRIM(@EMSG)
049100130109     C                   ELSE
049200130109     C                   EVAL      MSG@PRT = %TRIM(MSG@PRT) + '; ' +
049300130109     C                             %TRIM(@EMSG)
049400130109     C                   ENDIF
049500130109    ***
049600130109     C                   EVAL      @EMSG = *BLANKS
049700130109    ***
049800130109     C                   ENDSR
049900130109   S***S
050000130109     C     $CFG_DATE     BEGSR
050100130109    ***
050200130109     C                   EVAL      #DAY_DGTS = 0
050300130109     C                   EVAL      #MTH_DGTS = 0
050400130109     C                   EVAL      #YR_DGTS = 0
050500130109     C                   MOVEL     @CVTDAT       @DATEIN
050600130109     C                   EVAL      #DATE_PART = 1
050700130109     C                   EVAL      #DO = 1
050800130109     C                   EVAL      #DI = 0
050900130109    ***
051000130109     C                   DO        10            #DI
051100130109    * *
051200130109     C                   IF        DATEIN@(#DI) = '/'
051300130109     C                   ADD       1             #DATE_PART
051400130109     C                   ITER
051500130109     C                   ENDIF
051600130109    * *
051700130109     C                   IF        #DATE_PART = 2 AND #MTH_DGTS = 1
051800130109     C                   ADD       1             #DO
051900130109     C                   EVAL      DATEOUT@(2) = DATEOUT@(1)
052000130109     C                   EVAL      DATEOUT@(1) = '0'
052100130109     C                   EVAL      #MTH_DGTS = 2
052200130109     C                   ENDIF
052300130109    * *
052400130109     C                   IF        #DATE_PART = 3 AND #DAY_DGTS = 1
052500130109     C                   ADD       1             #DO
052600130109     C                   EVAL      DATEOUT@(4) = DATEOUT@(3)
052700130109     C                   EVAL      DATEOUT@(3) = '0'
052800130109     C                   EVAL      #DAY_DGTS = 2
052900130109     C                   ENDIF
053000130109    * *
053100130109     C                   IF        DATEIN@(#DI) = ' '
053200130109     C                   ITER
053300130109     C                   ENDIF
053400130109    * *
053500130109     C                   EVAL      DATEOUT@(#DO) = DATEIN@(#DI)
053600130109     C                   ADD       1             #DO
053700130109    * *
053800130109     C                   SELECT
053900130109     C                   WHEN      #DATE_PART = 1
054000130109     C                   ADD       1             #MTH_DGTS
054100130109     C                   WHEN      #DATE_PART = 2
054200130109     C                   ADD       1             #DAY_DGTS
054300130109     C                   WHEN      #DATE_PART = 3
054400130109     C                   ADD       1             #YR_DGTS
054500130109     C                   ENDSL
054600130109    * *
054700130109     C                   ENDDO
054800130109    ***
054900130109     C                   IF        #YR_DGTS = 2
055000130109     C                   EVAL      DATEOUT@(7) = DATEOUT@(5)
055100130109     C                   EVAL      DATEOUT@(8) = DATEOUT@(6)
055200130109     C                   EVAL      DATEOUT@(5) = '2'
055300130109     C                   EVAL      DATEOUT@(6) = '0'
055400130109     C                   ENDIF
055500130109    ***
055600130109     C                   MOVEL     @DATEOUT      #XSX
055700130109     C                   MOVE      #XSX          #USA
055800130109     C                   MOVE      #USA          #ISO
055900130109     C                   MOVE      #ISO          #XSX
056000130109    ***
056100130109     C                   ENDSR
056200130109   S***S
056300130109     C     $CFG_AMT      BEGSR
056400130109    ***
056500130109     C                   EVAL      NEG_FND = NO
056600130109     C                   EVAL      #PC = 1
056700130109     C                   MOVE      *ALL'0'       @DOLLAR
056800130109     C                   MOVE      '00'          @CENTS
056900130109     C                   EVAL      X = 16
057000130109     C                   EVAL      Y = 16
057100130109     C                   EVAL      #CP = 3
057200130109     C                   EVAL      #2 = 0
057300130109    ***
057400130109     C                   DO        15
057500130109    * *
057600130109     C                   SUB       1             X
057700130109    * *
057800130109     C                   SELECT
057900130109     C                   WHEN      XA@(X) = ' '
058000130109     C                   ITER
058100130109     C                   WHEN      XA@(X) = '.'
058200130109     C                   ADD       1             #PC
058300130109     C                   ITER
058400130109     C                   WHEN      XA@(X) = '-'
058500130109     C                   EVAL      NEG_FND = YES
058600130109     C                   ITER
058700130109     C                   ENDSL
058800130109    * *
058900130109     C                   IF        #PC = 1
059000130109     C                   SUB       1             #CP
059100130109     C                   EVAL      %SUBST(@CENTS:#CP:1) = XA@(X)
059200130109     C                   ELSE
059300130109     C                   SUB       1             Y
059400130109     C                   EVAL      DLR@(Y) = XA@(X)
059500130109     C                   ENDIF
059600130109    * *
059700130109     C                   ENDDO
059800130109    ***
059900130109     C                   MOVE      @DOLLAR       #15
060000130109    ***
060100130109     C                   IF        @CENTS <> '00'
060200130109     C                   MOVE      @CENTS        #2
060300130109     C                   EVAL      #17V2 = #15 + (#2 / 100)
060400130109     C                   ELSE
060500130109     C                   EVAL      #17V2 = #15
060600130109     C                   ENDIF
060700130109    ***
060800130109     C                   IF        NEG_FND = YES
060900130109     C                   MULT      -1            #17V2
061000130109     C                   ENDIF
061100130109    ***
061200130109     C                   Z-ADD     #17V2         #AMOUNT
061300130109    ***
061400130109     C                   ENDSR
061500130109   S***S
061600130109     C     $CFG_CNT      BEGSR
061700130109    ***
061800130109     C                   EVAL      NEG_FND = NO
061900130109     C                   EVAL      #PC = 1
062000130109     C                   MOVE      *ALL'0'       @DOLLAR
062100130109     C                   EVAL      X = 16
062200130109     C                   EVAL      Y = 16
062300130109     C                   MOVE      *ZEROS        #COUNT
062400130109    ***
062500130109     C                   EVAL      POS = %SCAN('.':@XLTAMT)
062600130109     C                   IF        POS > 0
062700130109     C                   EVAL      @XLTAMT = %SUBST(BLK@TRGT:1:POS - 1)
062800130109     C                   ENDIF
062900130109    ***
063000130109     C                   DO        15
063100130109    * *
063200130109     C                   SUB       1             X
063300130109    * *
063400130109     C                   SELECT
063500130109     C                   WHEN      XA@(X) = ' '
063600130109     C                   ITER
063700130109    * *
063800130109     C                   WHEN      XA@(X) = '-'
063900130109     C                   EVAL      NEG_FND = YES
064000130109     C                   ITER
064100130109     C                   ENDSL
064200130109    * *
064300130109     C                   SUB       1             Y
064400130109     C                   EVAL      DLR@(Y) = XA@(X)
064500130109    * *
064600130109     C                   ENDDO
064700130109    ***
064800130109     C                   MOVE      @DOLLAR       #15
064900130109    ***
065000130109     C                   IF        NEG_FND = YES
065100130109     C                   MULT      -1            #15
065200130109     C                   ENDIF
065300130109    ***
065400130109     C                   Z-ADD     #15           #COUNT
065500130109    ***
065600130109     C                   ENDSR
065700130109   S***S
065800130109     C     $CFG_AM4      BEGSR
065900130109    ***
066000130109     C                   IF        @15 = *BLANKS
066100130109     C                   EVAL      #15S4 = 0.00
066200130109     C                   LEAVESR
066300130109     C                   ENDIF
066400130109    ***
066500130109     C                   EVAL      NEG = 'N'
066600130109     C                   EVAL      POS2 = 0
066700130109     C                   EVAL      POS2 = %SCAN('-':@15)
066800130109     C                   IF        POS2 > 0
066900130109     C                   MOVE      'Y'           NEG
067000130109     C                   ENDIF
067100130109    ***
067200130109     C                   EVAL      N@15 = *BLANKS
067300130109     C                   EVAL      POS = 0
067400130109     C                   EVAL      POS = %SCAN('.':@15)
067500130109     C                   IF        POS > 0
067600130109     C                   EVAL      X = POS - 1
067700130109     C                   EVAL      %SUBST(N@15:2:X) = %SUBST(@15:1:X)
067800130109     C                   EVAL      X = POS + 1
067900130109     C                   EVAL      Y = (15 - X) + 1
068000130109     C                   EVAL      %SUBST(N@15:X:Y) = %SUBST(@15:X:Y)
068100130109     C                   EVAL      @15 = N@15
068200130109     C                   ENDIF
068300130109    ***
068400130109     C     ' ':'0'       XLATE     @15           @15
068500130109    ***
068600130109     C                   MOVEL     @15           @11
068700130109     C                   MOVE      @11           #11
068800130109     C                   MOVE      @15           @4
068900130109     C                   MOVE      @4            #4
069000130109     C                   EVAL      #15S4 = #11 + (#4 * .0001)
069100130109     C                   IF        NEG = 'Y'
069200130109     C                   MULT      -1            #15S4
069300130109     C                   ENDIF
069400130109    ***
069500130109     C                   ENDSR
069600130109   S***S
069700130110     OT2000     EADD         OUTF
069800130110     O                       @OUT           B  2000
