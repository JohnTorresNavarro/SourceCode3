000100100628     FFRMTRKL5  IF   E           K DISK
000200100625     FFTRW020   IF   E           K DISK
000300100629     FFTRW040   IF   E           K DISK
000400100625     FFTRW030   O  A E             DISK
000500100621   X***X
000600100629     D RSLT            S              6S 0
000700100629     D RCV#CNT         S              6S 0
000800100629     D CLS#CNT         S              6S 0
000900100625     D #XSX            S              8S 0
001000100625     D #ISO            S               D   DATFMT(*ISO)
001100100625     D A               C                   CONST('''')
001200100625     D Q               S              3A   INZ('","')
001300100621    ***
001400100621     D @STEP           S              5A
001500100621    ***
001600100803     D @M              S              2A
001700100803     D @Y              S              4A
001800100803     D @8              S              8A
001900100803     D #8ISO           S               D
002000100803    ***
002100100621   X***X
002200100803     C     *ENTRY        PLIST
002300100803     C                   PARM                    @M
002400100803     C                   PARM                    @Y
002500100803      *
002600100803     C                   SELECT
002700100803     C                   WHEN      @M = '01' OR @M = '03' OR @M = '05' OR
002800100803     C                             @M = '07' OR @M = '10' OR @M = '12' OR
002900100803     C                             @M = '08'
003000100803     C                   EVAL      @8 = @Y + @M + '31'
003100100803     C                   WHEN      @M = '02'
003200100803     C                   EVAL      @8 = @Y + @M + '29'
003300100803     C                   MOVE      @8            #8
003400100803     C                   TEST(DE)                #8
003500100803     C                   IF        %ERROR
003600100803     C                   EVAL      @8 = @Y + @M + '28'
003700100803     C                   ENDIF
003800100803     C                   WHEN      @M = '04' OR @M = '06' OR @M = '09' OR
003900100803     C                             @M = '11'
004000100803     C                   EVAL      @8 = @Y + @M + '30'
004100100803     C                   ENDSL
004200100803      *
004300100803     C                   MOVE      @8            #8                8 0
004400100803     C                   MOVE      #8            #8ISO
004500100803    ***
004600100625     C                   EVAL      @STEP = 'STEP1'
004700100621    ***
004800100621     C                   DOU       @STEP = 'LEAVE'
004900100621     C     @STEP         CASEQ     'STEP1'       $STEP1
005000100621     C     @STEP         CASEQ     'STEP2'       $STEP2
005100100621     C                   ENDCS
005200100621     C                   ENDDO
005300100621    ***
005400100621     C                   MOVE      *ON           *INLR
005500100621   S***S
005600100622     C     $STEP1        BEGSR
005700100621    ***
005800100625     C                   EVAL      #ISO = %DATE
005900100625     C     *USA          MOVE      #ISO          #XSX
006000100629     C                   EVAL      F3OUT = '"AGING REPORT DTL FOR : ' +
006100100625     C                             %TRIM(%EDITC(#XSX:'Y')) + '"'
006200100625     C                   WRITE     FTRW030R
006300100625     C                   CLEAR                   F3OUT
006400100625    * *
006500100625     C                   EVAL      F3OUT = ','
006600100625     C                   WRITE     FTRW030R
006700100625     C                   WRITE     FTRW030R
006800100625     C                   CLEAR                   F3OUT
006900100625    * *
007000100625     C                   EVAL      F3OUT = '"UNIQUE FORM NBR","MBR NBR","LAST' +
007100100625     C                             ' NAME","FIRST NAME","MI","TRUST","SUB","A' +
007200100625     C                             'CCT","GROUP NAME","RECEIVE DATE","RECEIVE' +
007300100625     C                             ' TIME","RECEIVE USER","CLOSE DATE","CLOSE' +
007400100630     C                             ' TIME","CLOSE USER","CLOSING CODE","TYPE ' +
007500100630     C                             'CODE","DAYS"'
007600100625     C                   WRITE     FTRW030R
007700100625     C                   CLEAR                   F3OUT
007800100625    ***
007900100625     C                   MOVE      'STEP2'       @STEP
008000100625    ***
008100100625     C                   ENDSR
008200100625   S***S
008300100625     C     $STEP2        BEGSR
008400100625    ***
008500100625     C                   READ      FRMTRKR
008600100625    ***
008700100625     C                   IF        %EOF(FRMTRKL5)
008800100625     C                   EVAL      @STEP = 'LEAVE'
008900100625     C                   LEAVESR
009000100625     C                   ENDIF
009100100625    ***
009200100625     C                   IF        FTCLSCOD = *BLANKS
009300100625     C                   LEAVESR
009400100625     C                   ENDIF
009500100625    ***
009600100803     C                   IF        FTCLSDT > #8ISO OR FTCLSDT = D'0001-01-01'
009700100803     C                   LEAVESR
009800100803     C                   ENDIF
009900100803    ***
010000100804    *C*                  IF        FTCLSCOD = 'DNS' OR
010100100804    *C*                            FTCLSCOD = 'DNG' OR
010200100804    *C*                            FTCLSCOD = '4.3'
010300100804    *C*                  LEAVESR
010400100804    *C*                  ENDIF
010500100804    ***
010600100625     C                   MOVE      *BLANKS       @@SSN            11
010700100625     C                   MOVE      *BLANKS       @@T               3
010800100625     C                   MOVE      *BLANKS       @@S               3
010900100625     C                   MOVE      *BLANKS       @@A               4
011000100625     C                   MOVE      *BLANKS       @@RCVDT          15
011100100625     C                   MOVE      *BLANKS       @@CLSDT          15
011200100625     C                   MOVE      *BLANKS       @@RCVTM          10
011300100625     C                   MOVE      *BLANKS       @@CLSTM          10
011400100625     C                   MOVE      *BLANKS       @@CLSCOD         40
011500100625    ***
011600100625     C                   EVAL      @@SSN = %EDITW(FTSSN:'   -  -    ')
011700100625     C                   MOVE      FTTRST        @@T
011800100625     C                   MOVE      FTSUB#        @@S
011900100625     C                   MOVE      FTACCT        @@A
012000100625     C     *USA          MOVE      FTRCVDT       #XSX
012100100625     C                   EVAL      @@RCVDT = %EDITC(#XSX:'Y')
012200100625     C     *USA          MOVE      FTCLSDT       #XSX
012300100625     C                   EVAL      @@CLSDT = %EDITC(#XSX:'Y')
012400100625     C                   EVAL      @@RCVTM = %EDITW(FTRCVTM:'  :  :  ')
012500100625     C                   EVAL      @@CLSTM = %EDITW(FTCLSTM:'  :  :  ')
012600100625    ***
012700100625     C     FTCLSCOD      CHAIN     FTRW020R
012800100625     C                   EVAL      @@CLSCOD = FTCLSCOD + '=' +
012900100625     C                             %TRIM(F2DESC)
013000100629    ***
013100100629     C                   EVAL      RSLT = 0
013200100629     C                   EXSR      $TALLY
013300100625    ***
013400100625     C                   EVAL      F3OUT = '"' + A + %TRIM(FTUNIQUE) + Q + A +
013500100625     C                             %TRIM(@@SSN) + Q + %TRIM(FTNAMEL) + Q +
013600100625     C                             %TRIM(FTNAMEF) + Q + %TRIM(FTNAMEM) + Q + A +
013700100625     C                             %TRIM(@@T) + Q + A + %TRIM(@@S) + Q + A +
013800100625     C                             %TRIM(@@A) + Q + %TRIM(FTGROUP) + Q +
013900100625     C                             %TRIM(@@RCVDT) + Q + %TRIM(@@RCVTM) + Q +
014000100625     C                             %TRIM(FTRCVUSR) + Q + %TRIM(@@CLSDT) + Q +
014100100625     C                             %TRIM(@@CLSTM) + Q + %TRIM(FTCLSUSR) + Q +
014200100629     C                             %TRIM(@@CLSCOD) + Q +
014300100804     C                             %TRIM(FTTYPCOD) + Q +
014400100629     C                             %TRIM(%EDITC(RSLT:'Z')) + '"'
014500100625    ***
014600100625     C                   WRITE     FTRW030R
014700100625    ***
014800100625     C                   CLEAR                   F3OUT
014900100625    ***
015000100622     C                   ENDSR
015100100622   S***S
015200100629     C     $TALLY        BEGSR
015300100629    ***
015400100629     C                   MOVE      FTRCVDT       #XSX
015500100629     C     #XSX          CHAIN     FTRW040R
015600100629     C                   Z-ADD     F4CNTR        RCV#CNT
015700100629     C                   MOVE      FTCLSDT       #XSX
015800100629     C     #XSX          CHAIN     FTRW040R
015900100629     C                   Z-ADD     F4CNTR        CLS#CNT
016000100629     C                   EVAL      RSLT = CLS#CNT - RCV#CNT
016100100629    ***
016200100629     C                   ENDSR
016300100629   S***S
