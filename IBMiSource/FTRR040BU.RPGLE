000100100625     FFRMTRKL5  UF   E           K DISK
000200100628     FFTRW040   IF   E           K DISK
000300100625     FFTRW030   O  A E             DISK
000400100621   X***X
000500100629     D RSLT            S              6S 0
000600100629     D RCV#CNT         S              6S 0
000700100629     D CLS#CNT         S              6S 0
000800100625     D #XSX            S              8S 0
000900100625     D #ISO            S               D   DATFMT(*ISO)
001000100625     D A               C                   CONST('''')
001100100625     D Q               S              3A   INZ('","')
001200100621    ***
001300100621     D @STEP           S              5A
001400100621    ***
001500100628     D D#02            S              5S 0
001600100628     D D#37            S              5S 0
001700100628     D D#814           S              5S 0
001800100628     D D#1530          S              5S 0
001900100628     D D#30PLS         S              5S 0
002000100628     D D#TOT           S              5S 0
002100100628     D C#02            S              5S 0
002200100628     D C#37            S              5S 0
002300100628     D C#814           S              5S 0
002400100628     D C#1530          S              5S 0
002500100628     D C#30PLS         S              5S 0
002600100628     D C#TOT           S              5S 0
002700100803    ***
002800100803     D @M              S              2A
002900100803     D @Y              S              4A
003000100803     D @8              S              8A
003100100803     D #8ISO           S               D
003200100803    ***
003300100621   X***X
003400100803     C     *ENTRY        PLIST
003500100803     C                   PARM                    @M
003600100803     C                   PARM                    @Y
003700100803      *
003800100803     C                   SELECT
003900100803     C                   WHEN      @M = '01' OR @M = '03' OR @M = '05' OR
004000100803     C                             @M = '07' OR @M = '10' OR @M = '12' OR
004100100803     C                             @M = '08'
004200100803     C                   EVAL      @8 = @Y + @M + '31'
004300100803     C                   WHEN      @M = '02'
004400100803     C                   EVAL      @8 = @Y + @M + '29'
004500100803     C                   MOVE      @8            #8
004600100803     C                   TEST(DE)                #8
004700100803     C                   IF        %ERROR
004800100803     C                   EVAL      @8 = @Y + @M + '28'
004900100803     C                   ENDIF
005000100803     C                   WHEN      @M = '04' OR @M = '06' OR @M = '09' OR
005100100803     C                             @M = '11'
005200100803     C                   EVAL      @8 = @Y + @M + '30'
005300100803     C                   ENDSL
005400100803      *
005500100803     C                   MOVE      @8            #8                8 0
005600100803     C                   MOVE      #8            #8ISO
005700100803    ***
005800100625     C                   EVAL      @STEP = 'STEP1'
005900100621    ***
006000100621     C                   DOU       @STEP = 'LEAVE'
006100100621     C     @STEP         CASEQ     'STEP1'       $STEP1
006200100621     C     @STEP         CASEQ     'STEP2'       $STEP2
006300100628     C     @STEP         CASEQ     'STEP3'       $STEP3
006400100621     C                   ENDCS
006500100621     C                   ENDDO
006600100621    ***
006700100621     C                   MOVE      *ON           *INLR
006800100621   S***S
006900100622     C     $STEP1        BEGSR
007000100628    ***
007100100628     C                   EVAL      F3OUT = '"PRODUCER: GROUP BENEF' +
007200100628     C                             'IT SERVICES INC."'
007300100628     C                   WRITE     FTRW030R
007400100628     C                   CLEAR                   F3OUT
007500100621    ***
007600100628     C                   EVAL      F3OUT = ','
007700100628     C                   WRITE     FTRW030R
007800100628    ***
007900100625     C                   EVAL      #ISO = %DATE
008000100625     C     *USA          MOVE      #ISO          #XSX
008100100628     C                   EVAL      F3OUT = '"DATE : ' +
008200100625     C                             %TRIM(%EDITC(#XSX:'Y')) + '"'
008300100625     C                   WRITE     FTRW030R
008400100625     C                   CLEAR                   F3OUT
008500100625    * *
008600100625     C                   EVAL      F3OUT = ','
008700100625     C                   WRITE     FTRW030R
008800100625     C                   WRITE     FTRW030R
008900100625     C                   CLEAR                   F3OUT
009000100625    * *
009100100628     C                   EVAL      F3OUT = '"TOTAL MONTHLY ENROLLMENT INVENTO' +
009200100628     C                             'RY","' + A + '0 - 2 DAYS","' + A + '3 - 7' +
009300100628     C                             ' DAYS","' + A + '8 - 14 DAYS","' + A + '1' +
009400100628     C                             '5 - 30 DAYS","OVER 30 DAYS","TOTAL AGING"'
009500100625     C                   WRITE     FTRW030R
009600100625     C                   CLEAR                   F3OUT
009700100625    ***
009800100625     C                   MOVE      'STEP2'       @STEP
009900100625    ***
010000100625     C                   ENDSR
010100100625   S***S
010200100625     C     $STEP2        BEGSR
010300100625    ***
010400100625     C                   READ      FRMTRKR
010500100625    ***
010600100625     C                   IF        %EOF(FRMTRKL5)
010700100628     C                   EVAL      @STEP = 'STEP3'
010800100625     C                   LEAVESR
010900100625     C                   ENDIF
011000100625    ***
011100100628     C                   IF        FTCLSCOD = *BLANKS
011200100628     C                   LEAVESR
011300100628     C                   ENDIF
011400100803    ***
011500100811    *** TURNS OUT, DIS BE WRONG
011600100811     C******             IF        FTCLSDT > #8ISO OR FTCLSDT = D'0001-01-01'
011700100811    ***
011800100811     C                   IF        FTCLSDT > #8ISO AND FTCLSCOD = '834'
011900100803     C                   LEAVESR
012000100803     C                   ENDIF
012100100628    ***
012200100811    *** TURNS OUT, DIS BE WRONG
012300100811    *C*                  IF        FTCLSCOD = 'DNS' OR
012400100811    *C*                            FTCLSCOD = 'DNG' OR
012500100811    *C*                            FTCLSCOD = '4.3'
012600100811    *C*                  LEAVESR
012700100811    *C*                  ENDIF
012800100811    ***
012900100811    *C                   IF        FTCLSCOD = '834'
013000100811     C                   EXSR      $TALLY
013100100811    *C                   ENDIF
013200100625    ***
013300100625     C                   EVAL      FTRPTDTE = %DATE
013400100625     C                   UPDATE    FRMTRKR
013500100625    ***
013600100629    ***
013700100629     C                   ENDSR
013800100629   S***S
013900100629     C     $TALLY        BEGSR
014000100629    ***
014100100629     C                   MOVE      FTRCVDT       #XSX
014200100629     C     #XSX          CHAIN     FTRW040R
014300100629     C                   Z-ADD     F4CNTR        RCV#CNT
014400100629     C                   MOVE      FTCLSDT       #XSX
014500100629     C     #XSX          CHAIN     FTRW040R
014600100629     C                   Z-ADD     F4CNTR        CLS#CNT
014700100629     C                   EVAL      RSLT = CLS#CNT - RCV#CNT
014800100629     C                   SELECT
014900100629     C                   WHEN      RSLT < 3
015000100629     C                   ADD       1             C#02
015100100629     C                   ADD       RSLT          D#02
015200100629     C                   WHEN      RSLT >= 3 AND RSLT <= 7
015300100629     C                   ADD       1             C#37
015400100629     C                   ADD       RSLT          D#37
015500100629     C                   WHEN      RSLT >= 8 AND RSLT <= 14
015600100629     C                   ADD       1             C#814
015700100629     C                   ADD       RSLT          D#814
015800100629     C                   WHEN      RSLT >= 15 AND RSLT <= 30
015900100629     C                   ADD       1             C#1530
016000100629     C                   ADD       RSLT          D#1530
016100100629     C                   WHEN      RSLT > 30
016200100629     C                   ADD       1             C#30PLS
016300100629     C                   ADD       RSLT          D#30PLS
016400100629     C                   ENDSL
016500100629     C                   ADD       1             C#TOT
016600100629     C                   ADD       RSLT          D#TOT
016700100625    ***
016800100628     C                   ENDSR
016900100628   S***S
017000100628     C     $STEP3        BEGSR
017100100628    ***
017200100811     C                   MOVE      *ZEROS        #RSTL            15 4
017300100811     C                   IF        C#TOT > 0 AND D#TOT > 0
017400100629     C                   EVAL      #RSTL = D#TOT / C#TOT
017500100811     C                   ENDIF
017600100708     C                   EVAL      F3OUT = ',"' + A +
017700100708     C                             %EDITC(C#02:'1') + Q + A +
017800100708     C                             %EDITC(C#37:'1') + Q + A +
017900100708     C                             %EDITC(C#814:'1') + Q + A +
018000100708     C                             %EDITC(C#1530:'1') + Q + A +
018100100708     C                             %EDITC(C#30PLS:'1') + Q + A +
018200100629     C                             %EDITC(#RSTL:'1') + '"'
018300100625    ***
018400100625     C                   WRITE     FTRW030R
018500100625    ***
018600100625     C                   CLEAR                   F3OUT
018700100629     C                   EVAL      @STEP = 'LEAVE'
018800100625    ***
018900100622     C                   ENDSR
019000100622   S***S
