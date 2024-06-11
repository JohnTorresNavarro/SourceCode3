000100090730     FCMJ010WL  UF   E           K DISK
000200090730     FCMJ011WF  O  A F 2000        DISK
000300090729   X***X
000400090729     D W               S           2000A
000500090730     D QC              S              3A   INZ('","')
000600090730     D APS             S              1A   INZ('''')
000700090730     D TP              S              7S 0
000800090730     D TC              S              7S 0
000900090730     D TS              S              7S 0
001000090729   X***X
001100090729     C                   EXSR      $HEAD
001200090730      *
001300090730     C                   MOVE      *ZEROS        TP
001400090730     C                   MOVE      *ZEROS        TC
001500090730     C                   MOVE      *ZEROS        TS
001600090729      *
001700090730     C                   DOU       %EOF(CMJ010WL)
001800090730     C                   READ      CMJF
001900090730     C                   IF        NOT %EOF(CMJ010WL)
002000090730      *
002100090730     C                   IF        CJPSTS = 'TERM' AND
002200090730     C                             CJCSTS = 'TERM'
002300090730     C                   ITER
002400090730     C                   ENDIF
002500090730      *
002600090730     C                   IF        CJPSTS = 'TERM' AND
002700090730     C                             CJCSTS = *BLANKS
002800090730     C                   EVAL      CJCSTS = 'TERM'
002900090730     C                   EVAL      CJCUR = CJPRV
003000090730     C                   UPDATE    CMJF
003100090730     C                   ITER
003200090730     C                   ENDIF
003300090729      *
003400090730     C                   MOVE      *BLANKS       @D               15
003500090730     C     CJADMIN       MULT      10000.0001    #D                8 0
003600090730     C                   EVAL      @D = %EDITC(#D:'Y')
003700090730      *
003800090730     C                   MOVE      *ZEROS        #CALC             7 0
003900090730     C                   MOVE      *BLANKS       @PRV             15
004000090730     C                   MOVE      *BLANKS       @CUR             15
004100090730      *
004200090730     C                   SELECT
004300090730      *
004400090730     C                   WHEN      CJCSTS = 'ACTIVE' AND CJPSTS = 'ACTIVE'
004500090730     C                   EVAL      #CALC = CJCUR - CJPRV
004600090730     C                   EVAL      @PRV = %EDITC(CJPRV:'J')
004700090730     C                   EVAL      @CUR = %EDITC(CJCUR:'J')
004800090730      *
004900090730     C                   WHEN      CJCSTS = 'ACTIVE' AND CJPSTS = 'TERM'
005000090730     C                   EVAL      #CALC = CJCUR
005100090730     C                   EVAL      @PRV = 'TERM'
005200090730     C                   EVAL      @CUR = %EDITC(CJCUR:'J')
005300090730      *
005400090730     C                   WHEN      CJCSTS = 'TERM'
005500090730     C                   EVAL      #CALC = CJCUR * -1
005600090730     C                   EVAL      @PRV = %EDITC(CJPRV:'J')
005700090730     C                   EVAL      @CUR = 'TERM'
005800090730      *
005900090730     C                   WHEN      CJPSTS = *BLANKS
006000090730     C                   EVAL      CJPSTS = 'ACTIVE'
006100090730     C                   EVAL      #CALC = CJCUR - CJPRV
006200090730     C                   EVAL      @PRV = 'NEW'
006300090730     C                   EVAL      @CUR = %EDITC(CJCUR:'J')
006400090730     C                   UPDATE    CMJF
006500090730      *
006600090730     C                   WHEN      CJCSTS = *BLANKS
006700090730     C                   EVAL      #CALC = CJPRV * -1
006800090730     C                   EVAL      @PRV = %EDITC(CJPRV:'J')
006900090730     C                   EVAL      @CUR = 'TERM'
007000090730     C                   EVAL      CJCSTS = 'TERM'
007100090730     C                   EVAL      CJCUR = CJPRV
007200090730     C                   UPDATE    CMJF
007300090730      *
007400090730     C                   ENDSL
007500090730      *
007600090730     C                   ADD       CJPRV         TP
007700090730     C                   ADD       CJCUR         TC
007800090730     C                   ADD       #CALC         TS
007900090730      *
008000090730     C                   EVAL      W = '"' + %TRIM(CJBNAME) + QC +
008100090730     C                             %TRIM(CJANAME) + QC +
008200090730     C                                   %TRIM(@PRV) + QC +
008300090730     C                                   %TRIM(@CUR) + QC +
008400090730     C                                   %TRIM(%EDITC(#CALC:'J')) + QC +
008500090730     C                                   %TRIM(@D) + '"'
008600090730      *
008700090730     C                   EXCEPT    WF
008800090729      *
008900090729     C                   ENDIF
009000090729     C                   ENDDO
009100090730      *
009200090730     C                   EVAL      W = ',,"----------","----------","--------' +
009300090730     C                             '--"'
009400090730     C                   EXCEPT    WF
009500090730      *
009600090730     C                   EVAL      @PRV = %EDITC(TP:'J')
009700090730     C                   EVAL      @CUR = %EDITC(TC:'J')
009800090730     C                   EVAL      W = ',"TOTAL:' + QC +
009900090730     C                                   %TRIM(@PRV) + QC +
010000090730     C                                   %TRIM(@CUR) + QC +
010100090730     C                                   %TRIM(%EDITC(TS:'J')) + '",'
010200090730     C                   EXCEPT    WF
010300090729      *
010400090729     C                   EVAL      *INLR = *ON
010500090729      *
010600090729   S***S
010700090729     C     $HEAD         BEGSR
010800090729      *
010900090729     C                   EVAL      W = '"ACCOUNT MEDICAL CONTRACT COUNT REPORT"'
011000090729     C                   EXCEPT    WF
011100090729      *
011200090729     C                   EVAL      W = ','
011300090729     C                   EXCEPT    WF
011400090729      *
011500090729     C                   EVAL      W = '"FOR WRIGHT-GARDNER INSURANCE, INC."'
011600090729     C                   EXCEPT    WF
011700090729      *
011800090729     C                   EVAL      W = ','
011900090729     C                   EXCEPT    WF
012000090729      *
012100090729     C                   EVAL      W = ','
012200090729     C                   EXCEPT    WF
012300090729      *
012400090729     C                   EVAL      W = '"SALESMAN NAME","ACCOUNT NAME","PREVI' +
012500090729     C                             'OUS MONTH CONTRACTS","CURRENT MONTH CONTR' +
012600090730     C                             'ACTS","ADJUSTMENT TO COUNT","BEGIN ADMIN ' +
012700090730     C                             'DATE"'
012800090729     C                   EXCEPT    WF
012900090729      *
013000090729     C                   ENDSR
013100090729   S***S
013200090730     OCMJ011WF  EADD         WF
013300090729     O                       W              B  2000
