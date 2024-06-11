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
002800101209     D @C              S              1A
002900100803     D @M              S              2A
003000100803     D @Y              S              4A
003100100803     D @8              S              8A
003200100803     D #8ISO           S               D
003300100803    ***
003400100621   X***X
003500100803     C     *ENTRY        PLIST
003600100803     C                   PARM                    @M
003700100803     C                   PARM                    @Y
003800101209     C                   PARM                    @C
003900100803      *
004000100803     C                   SELECT
004100100803     C                   WHEN      @M = '01' OR @M = '03' OR @M = '05' OR
004200100803     C                             @M = '07' OR @M = '10' OR @M = '12' OR
004300100803     C                             @M = '08'
004400100803     C                   EVAL      @8 = @Y + @M + '31'
004500100803     C                   WHEN      @M = '02'
004600100803     C                   EVAL      @8 = @Y + @M + '29'
004700100803     C                   MOVE      @8            #8
004800100803     C                   TEST(DE)                #8
004900100803     C                   IF        %ERROR
005000100803     C                   EVAL      @8 = @Y + @M + '28'
005100100803     C                   ENDIF
005200100803     C                   WHEN      @M = '04' OR @M = '06' OR @M = '09' OR
005300100803     C                             @M = '11'
005400100803     C                   EVAL      @8 = @Y + @M + '30'
005500100803     C                   ENDSL
005600100803      *
005700100803     C                   MOVE      @8            #8                8 0
005800100803     C                   MOVE      #8            #8ISO
005900100803    ***
006000100625     C                   EVAL      @STEP = 'STEP1'
006100100621    ***
006200100621     C                   DOU       @STEP = 'LEAVE'
006300100621     C     @STEP         CASEQ     'STEP1'       $STEP1
006400100621     C     @STEP         CASEQ     'STEP2'       $STEP2
006500100628     C     @STEP         CASEQ     'STEP3'       $STEP3
006600100621     C                   ENDCS
006700100621     C                   ENDDO
006800100621    ***
006900100621     C                   MOVE      *ON           *INLR
007000100621   S***S
007100100622     C     $STEP1        BEGSR
007200100628    ***
007300100628     C                   EVAL      F3OUT = '"PRODUCER: GROUP BENEF' +
007400100628     C                             'IT SERVICES INC."'
007500100628     C                   WRITE     FTRW030R
007600100628     C                   CLEAR                   F3OUT
007700100621    ***
007800100628     C                   EVAL      F3OUT = ','
007900100628     C                   WRITE     FTRW030R
008000100628    ***
008100100625     C                   EVAL      #ISO = %DATE
008200100625     C     *USA          MOVE      #ISO          #XSX
008300100628     C                   EVAL      F3OUT = '"DATE : ' +
008400100625     C                             %TRIM(%EDITC(#XSX:'Y')) + '"'
008500100625     C                   WRITE     FTRW030R
008600100625     C                   CLEAR                   F3OUT
008700100625    * *
008800100625     C                   EVAL      F3OUT = ','
008900100625     C                   WRITE     FTRW030R
009000100625     C                   WRITE     FTRW030R
009100100625     C                   CLEAR                   F3OUT
009200100625    * *
009300100628     C                   EVAL      F3OUT = '"TOTAL MONTHLY ENROLLMENT INVENTO' +
009400100628     C                             'RY","' + A + '0 - 2 DAYS","' + A + '3 - 7' +
009500100628     C                             ' DAYS","' + A + '8 - 14 DAYS","' + A + '1' +
009600100628     C                             '5 - 30 DAYS","OVER 30 DAYS","TOTAL AGING"'
009700100625     C                   WRITE     FTRW030R
009800100625     C                   CLEAR                   F3OUT
009900100625    ***
010000100625     C                   MOVE      'STEP2'       @STEP
010100100625    ***
010200100625     C                   ENDSR
010300100625   S***S
010400100625     C     $STEP2        BEGSR
010500100625    ***
010600100625     C                   READ      FRMTRKR
010700100625    ***
010800100625     C                   IF        %EOF(FRMTRKL5)
010900100628     C                   EVAL      @STEP = 'STEP3'
011000100625     C                   LEAVESR
011100100625     C                   ENDIF
011200100625    ***
011300100628     C                   IF        FTCLSCOD = *BLANKS
011400100628     C                   LEAVESR
011500100628     C                   ENDIF
011600100803    ***
011700100811     C                   IF        FTCLSDT > #8ISO AND FTCLSCOD = '834'
011800100803     C                   LEAVESR
011900100803     C                   ENDIF
012000100811    ***
012100100811    *C                   IF        FTCLSCOD = '834'
012200100811     C                   EXSR      $TALLY
012300100811    *C                   ENDIF
012400100625    ***
012500101209     C                   IF        @C = 'Y'
012600100625     C                   EVAL      FTRPTDTE = %DATE
012700100625     C                   UPDATE    FRMTRKR
012800101209    *C                   ENDIF
012900100625    ***
013000100629     C                   ENDSR
013100100629   S***S
013200100629     C     $TALLY        BEGSR
013300100629    ***
013400100629     C                   MOVE      FTRCVDT       #XSX
013500100629     C     #XSX          CHAIN     FTRW040R
013600100629     C                   Z-ADD     F4CNTR        RCV#CNT
013700100629     C                   MOVE      FTCLSDT       #XSX
013800100629     C     #XSX          CHAIN     FTRW040R
013900100629     C                   Z-ADD     F4CNTR        CLS#CNT
014000100629     C                   EVAL      RSLT = CLS#CNT - RCV#CNT
014100100629     C                   SELECT
014200100629     C                   WHEN      RSLT < 3
014300100629     C                   ADD       1             C#02
014400100629     C                   ADD       RSLT          D#02
014500100629     C                   WHEN      RSLT >= 3 AND RSLT <= 7
014600100629     C                   ADD       1             C#37
014700100629     C                   ADD       RSLT          D#37
014800100629     C                   WHEN      RSLT >= 8 AND RSLT <= 14
014900100629     C                   ADD       1             C#814
015000100629     C                   ADD       RSLT          D#814
015100100629     C                   WHEN      RSLT >= 15 AND RSLT <= 30
015200100629     C                   ADD       1             C#1530
015300100629     C                   ADD       RSLT          D#1530
015400100629     C                   WHEN      RSLT > 30
015500100629     C                   ADD       1             C#30PLS
015600100629     C                   ADD       RSLT          D#30PLS
015700100629     C                   ENDSL
015800100629     C                   ADD       1             C#TOT
015900100629     C                   ADD       RSLT          D#TOT
016000100625    ***
016100100628     C                   ENDSR
016200100628   S***S
016300100628     C     $STEP3        BEGSR
016400100628    ***
016500100811     C                   MOVE      *ZEROS        #RSTL            15 4
016600100811     C                   IF        C#TOT > 0 AND D#TOT > 0
016700100629     C                   EVAL      #RSTL = D#TOT / C#TOT
016800100811     C                   ENDIF
016900100708     C                   EVAL      F3OUT = ',"' + A +
017000100708     C                             %EDITC(C#02:'1') + Q + A +
017100100708     C                             %EDITC(C#37:'1') + Q + A +
017200100708     C                             %EDITC(C#814:'1') + Q + A +
017300100708     C                             %EDITC(C#1530:'1') + Q + A +
017400100708     C                             %EDITC(C#30PLS:'1') + Q + A +
017500100629     C                             %EDITC(#RSTL:'1') + '"'
017600100625    ***
017700100625     C                   WRITE     FTRW030R
017800100625    ***
017900100625     C                   CLEAR                   F3OUT
018000100629     C                   EVAL      @STEP = 'LEAVE'
018100100625    ***
018200100622     C                   ENDSR
018300100622   S***S
