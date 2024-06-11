000100110323   X***X
000200120306     FSMAN2     IPE  E           K DISK
000300110323     FKTH011WF  O  A F  400        DISK
000400120306     FSMANRMGP  IF   E           K DISK
000500101025     FRMGRMST0  IF   E           K DISK
000600120306     F*SMANSP    IF   E           K DISK    PREFIX(Z) RENAME(SMANR:SMURF)
000700120306     FSMANL3    IF   E           K DISK
000800120306     FSMANRLT2  IF   E           K DISK
000900110323   X***X
001000110323     D @Y              S            400A   INZ
001100101025     D @X              S            400A   INZ
001200101025     D #ISO            S               D
001300101025     D #XSX            S              8S 0 INZ
001400120306     D YES             S               N   INZ(*ON)
001500120306     D NO              S               N   INZ(*OFF)
001600120306     D ACTIVE_REL      S               N
001700101025     D Q               S              3A   INZ('","')
001800101025     D A               C                   CONST('''')
001900120306    ***
002000120306     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
002100120306     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
002200120306    ***
002300110323   X***X
002400120306     C     SGRPCD        SETLL     SMANR
002500120306     C                   DOU       %EOF(SMANL3)
002600120306     C     SGRPCD        READE     SMANR
002700120306     C                   IF        NOT %EOF(SMANL3) AND
002800120306     C                             SENDDT = 0
002900120306      *
003000120306     C                   EXSR      $ACTVREL
003100120306     C                   IF        ACTIVE_REL = NO
003200120306     C                   ITER
003300120306     C                   ENDIF
003400120306      *
003500120306     C     SMANCD        CHAIN     SMANRMGR
003600120306     C     SMRMGR        CHAIN     RMGRMSTR
003700120306     C                   EXSR      $WRITE
003800120306      *
003900110323     C                   ENDIF
004000120306     C                   ENDDO
004100120306   S***S
004200120306     C     $ACTVREL      BEGSR
004300120306      *
004400120306     C                   EVAL      ACTIVE_REL = NO
004500120306      *
004600120306     C     SMANCD        CHAIN     SRF
004700120306     C                   IF        NOT %FOUND(SMANRLT2)
004800120306     C                   LEAVESR
004900120306     C                   ENDIF
005000120306      *
005100120306     C     SMANCD        SETLL     SRF
005200120306     C                   DOU       %EOF(SMANRLT2)
005300120306     C     SMANCD        READE     SRF
005400120306     C                   IF        NOT %EOF(SMANRLT2) AND
005500120306     C                             SRTRMDTE = 0
005600120306      *
005700120306     C                   EVAL      ACTIVE_REL = YES
005800120306     C                   LEAVESR
005900120306      *
006000120306     C                   ENDIF
006100120306     C                   ENDDO
006200120306      *
006300120306     C                   ENDSR
006400110323   S***S
006500120306     C     $WRITE        BEGSR
006600110323      *
006700120306     C                   EXSR      $GETSNAME
006800120306      *
006900120306     C                   EVAL      @Y = '"' + SMANCD + Q +
007000120306     C                             %TRIM(A@40) + Q +
007100120306     C                             %CHAR(SAREA) + %CHAR(SPHONE) + Q +
007200120306     C                             %TRIM(SBREML) + Q +
007300120306     C                             %TRIM(RMNAME)
007400101025     C                             + '"'
007500120306      *
007600120306     C     LO:UP         XLATE     @Y            @Y
007700110323      *
007800120306     C                   EXCEPT    OUTF
007900120306      *
008000110323     C                   ENDSR
008100110323   S***S
008200101025     C     *INZSR        BEGSR
008300120306      *
008400120306     C                   EVAL      @Y = '"ACTIVE SALESMAN RELATIONSHIP LIST ' +
008500120306     C                                  ' WITH RELATIONSHIP MGR INFO"'
008600101025     C                   EXCEPT    OUTF
008700120306      *
008800110323     C                   EVAL      @Y = ','
008900101025     C                   EXCEPT    OUTF
009000120306      *
009100120306     C                   EVAL      #ISO = %DATE
009200101025     C     *USA          MOVE      #ISO          #XSX
009300110323     C                   EVAL      @Y = '"AS OF: ' +
009400101025     C                             %EDITW(#XSX:'0  /  /    ') + '"'
009500101025     C                   EXCEPT    OUTF
009600120306      *
009700110323     C                   EVAL      @Y = ','
009800101025     C                   EXCEPT    OUTF
009900120306      *
010000120306     C                   EVAL      @Y = '"SMAN CODE","SMAN NAME","PHONE","EMA' +
010100120306     C                             'IL","BROKER REP"'
010200101025     C                   EXCEPT    OUTF
010300120306      *
010400101025     C                   ENDSR
010500110323   S***S
010600120306     C     $GETSNAME     BEGSR
010700120306    ***
010800120306     C                   CLEAR                   A@20             20
010900120306     C                   CLEAR                   A@40             40
011000120306    ***
011100120306     C                   IF        SFNAME <> *BLANKS
011200120306     C                   MOVEL     SFNAME        A@20
011300120306     C                   EXSR      $LDADDR
011400120306     C                   ENDIF
011500120306    ***
011600120306     C                   IF        SMI <> *BLANKS
011700120306     C                   MOVEL     SMI           A@20
011800120306     C                   EXSR      $LDADDR
011900120306     C                   ENDIF
012000120306    ***
012100120306     C                   IF        SLNAME <> *BLANKS
012200120306     C                   MOVEL     SLNAME        A@20
012300120306     C                   EXSR      $LDADDR
012400120306     C                   ENDIF
012500120306    ***
012600120306     C                   ENDSR
012700120306   S***S
012800120306     C     $LDADDR       BEGSR
012900120306    ***
013000120306     C                   EVAL      A@20 = %TRIM(A@20)
013100120306     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
013200120306     C                   CLEAR                   A@20
013300120306    ***
013400120306     C                   ENDSR
013500120306   S***S
013600110323     OKTH011WF  EADD         OUTF
013700110323     O                       @Y             B   400
