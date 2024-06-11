000100990825      *---------------------------------------------------------------**
000200990923      * COB330     GROUP BENEFIT SERVICES SOFTWARE           1997      *
000300990825      *                                                                *
000400990825      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000500990825      *            DATE - 08/25/99                                     *
000600990825      *                                                                *
000700990825      *  DESCRIPTION - THIS PROGRAM WILL LIST CHANGED COBRA            *
000800990825      *                FLAGS BASED UPON DATE.                          *
000900990825      *                                                                *
001000041202      * 12/02/04 dlk - add cobra service field                         *
001100120606      * 06/06/2012 SSK - REMOVE PRINT FILE                             *
001200120606      *                  SWITCH TO CSV REPORT                          *
001300120606      *                  ADD COBRA INITIAL NOTICE TEXT                 *
001400120607      *                  OLD VERSION WILL BE ARCHIVED                  *
001500120606      *                                                                *
001600120606      *                                                                *
001700990825      *---------------------------------------------------------------**
001800990825     FHIST      IF   E           K DISK
001900120607     FACMUNIQUE IF   E           K DISK
001901130320     Fcodesl1   IF   E           K DISK
002000120606     FCOB440W2  IF   E           K DISK
002100120607     FT200      O  A F  200        DISK
002200120606   X***X
002300990825      * LDA
002400990825     D                UDS
002500990322     D  LFMDAT                11     18  0
002600990322     D  LTODAT                19     26  0
002700990825     D  CONAME               201    240
002800120607    ***
002900130320     D**#FROMDT         S              8S 0
003000130320     D**#TODATE         S              8S 0
003100120607     D #XSX            S              8S 0
003200120607    ***
003300120607     D @PROC           S             10A
003400120607     D @SERVICE        S             50A
003500120607    ***
003600120607     D COUNT           S              5S 0 INZ(0)
003700120607     D NEWCD           S              1A
003800120607     D NEWSRV          S              1A
003900120607     D Q               C                   CONST('","')
004000120607     D PRVCD           S              1A
004100120607     D PRVSRV          S              1A
004200120607     D X               S            200A
004201130320     D descout         S                   like(ldescr)
004300120607    ***
004400120606   X***X
004500120607     C                   MOVEL(P)  'INITIALIZE'  @PROC
004600120607    ***
004700120607     C                   DOU       @PROC = 'LEAVE LOOP'
004800120607     C     @PROC         CASEQ     'INITIALIZE'  $INITL
004900120607     C     @PROC         CASEQ     'HIST LOOP '  $HSTLOOP
005000120607     C     @PROC         CASEQ     'TOTAL TIME'  $TOTAL
005100120607     C                   ENDCS
005200120607     C                   ENDDO
005300120607    ***
005400120607     C                   EVAL      *INLR = *ON
005500120607    ***
005600120607   S***S
005700120607     C     $INITL        BEGSR
005800120607    ***
005900120607     C     HISKEY        KLIST
006000120607     C                   KFLD                    HSTRST
006100120607     C                   KFLD                    HSSUB#
006200120607     C                   KFLD                    HSACCT
006300120607    ***
006400130320     C**   LFMDAT        MULT      10000.0001    #FROMDT
006500130320     C**   LTODAT        MULT      10000.0001    #TODATE
006600120607    ***
006700120607     C                   EVAL      X = '"PROGRAM - COB330"'
006800120607     C                   EXCEPT    OUTF
006900120607    ***
007000120607     C                   EVAL      X = ','
007100120607     C                   EXCEPT    OUTF
007200120607    ***
007300120607     C                   EVAL      X = '"' + %TRIM(CONAME) + '"'
007400120607     C                   EXCEPT    OUTF
007500120607    ***
007600120607     C                   EVAL      X = ','
007700120607     C                   EXCEPT    OUTF
007800120607    ***
007900120607     C                   EVAL      X = '"CHANGED COBRA FLAG LISTING FROM: ' +
008000120607     C                             %EDITC(LFMDAT:'Y') + ' TO: ' +
008100120607     C                             %EDITC(LTODAT:'Y') + '"'
008200120607     C                   EXCEPT    OUTF
008300120607    ***
008400120607     C                   EVAL      X = ','
008500120607     C                   EXCEPT    OUTF
008600120607    ***
008700130320     C                   EVAL      X = ',,,,,,"COBRA FLAG",,"COBRA SERVICE"' +
008800130320     C                             ',,"INITIAL"'
008900120607     C                   EXCEPT    OUTF
009000120607    ***
009100130320     C                   EVAL      X = '"TRUST","SUB","ACCT",' +
009101130320     C                             '"ACCOUNT NAME","DATE","TRANSACTION",' +
009200120607     C                             '"NEW","PREVIOUS","NEW","PREVIOUS","NOTICE"'
009300120607     C                   EXCEPT    OUTF
009400120607    ***
009500120607     C                   EVAL      @PROC = 'HIST LOOP '
009600130320    ***
009700120607     C                   ENDSR
009800120607   S***S
009900120607     C     $HSTLOOP      BEGSR
010000120606    ***
010100120607     C                   READ      HISTR
010200120607    ***
010300120607     C                   IF        %EOF(HIST)
010400120607     C                   EVAL      @PROC = 'TOTAL TIME'
010500120607     C                   LEAVESR
010600120607     C                   ENDIF
010700120607    ***
010701130320      * 3/20/13 - selection done in query now
010800130320     C**                 IF        TRDATE < #FROMDT OR
010900130320     C**                           TRDATE > #TODATE
011000130320     C**                 LEAVESR
011100130320     C**                 ENDIF
011200120607    ***
011300120607     C     HISKEY        CHAIN     ACCMSR
011400120607     C                   IF        NOT %FOUND(ACMUNIQUE)
011500120607     C                   LEAVESR
011600120607     C                   ENDIF
011601130320
011602130320      * new acounts - select with some form of cobra service only
011604130320     c                   if        (trcode = 'LAA' or trcode = 'GTA') and
011605130320     c                             acobsrv = *blanks
011606130320     C                   leavesr
011607130320     c                   end
011608130320
011609130320
011610130320      * get transaction description
011611130320     c                   clear                   descout
011612130320     C     trcode        chain     codesl1
011613130320     C                   if        %found(codesl1)
011614130320     C                   eval      descout = ldescr
011615130320     C                   end
011616130320      * trdate as mdy
011617130320     C                   MOVE      trdate        @DATIN
011618130320     C                   EXSR      #DATYM
011619130320     C                   MOVE      @DATOU        trdatmdy          8 0
011620130320
011700120607    ***
011800120607     C     HISKEY        CHAIN     C2F
011900120607     C                   IF        %FOUND(COB440W2)
012000120607     C                   EVAL      @SERVICE = 'INITIAL NOTICE ACCOUNT'
012100120607     C                   ELSE
012200120607     C                   EVAL      @SERVICE = *BLANKS
012300120607     C                   ENDIF
012400120607    ***
012500120607     C                   EVAL      COUNT = COUNT + 1
012600120607    ***
012700120607     c                   clear                   prvcd
012800120607     c                   clear                   newcd
012900120607     c                   clear                   prvsrv
013000120607     c                   clear                   newsrv
013100120607    ***
013101130320     c                   select
013200130320     c                   when      trcode = 'L14'
013300120607     C                   EVAL      PRVCD = CK#NOT
013400120607     C                   EVAL      NEWCD = NOTE2
013500130320     c                   when      trcode = 'L34'
013600120607     C                   EVAL      prvsrv = CK#NOT
013700120607     C                   EVAL      newsrv = NOTE2
013701130320      * new acts
013702130320     c                   when      trcode = 'LAA' or trcode = 'GTA'
013703130320     C                   EVAL      newcd  = fcstfl
013704130320     C                   EVAL      newsrv = acobsrv
013800130320     c                   endsl
013900120607    ***
014000120607     C                   EVAL      X = '"' +
014103130320     C                             %EDITC(ACTRST:'X') + Q +
014200120607     C                             %EDITC(ACSUB#:'X') + Q +
014300120607     C                             %EDITC(ACACCT:'X') + Q +
014400120607     C                             %TRIM(ACNAM1) + Q +
014401130320     C                             %EDITW(trdatmdy:'  /  /    ') + Q +
014402130320     C                             %trim(descout) + Q +
014500120607     C                             %TRIM(NEWCD) + Q + %TRIM(PRVCD) + Q +
014600120607     C                             %TRIM(NEWSRV) + Q + %TRIM(PRVSRV) + Q +
014700120607     C                             %TRIM(@SERVICE) + '"'
014800120607     C                   EXCEPT    OUTF
014900120606    ***
015000120607     C                   ENDSR
015100120607   S***S
015200120607     C     $TOTAL        BEGSR
015300120607    ***
015400120607     C                   EVAL      X = ','
015500120607     C                   EXCEPT    OUTF
015600120607    ***
015700120607     C                   EVAL      X = '"TOTAL COUNT: ' + %TRIM(%CHAR(COUNT)) +
015800120607     C                             '"'
015900120607     C                   EXCEPT    OUTF
016000120607    ***
016100120607     C                   EVAL      @PROC = 'LEAVE LOOP'
016200120607    ***
016300120607     C                   ENDSR
016301130320
0165011303200103 C***************************************************
0165021303200104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0165031303200105 C***************************************************
0165041303200107 C*
0165051303200107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0165061303200107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0165071303200107 C*
0165081303200106 C     #DATYM        BEGSR
016509130320     C                   MOVE      @DATIN        @MD               4 0
016510130320     C                   MOVEL     @DATIN        @Y                4 0
016511130320     C                   MOVEL     @MD           @DATOU            8 0
016512130320     C                   MOVE      @Y            @DATOU
016513130320     C                   MOVE      *ZEROS        @DATIN            8 0
0165141303200120 C                   ENDSR
0165151303200107 C*
016600120607     OT200      EADD         OUTF
016700120607     O                       X              B   200
