000100110323   X***X
000200110323     FKTH012WF  IPE  E           K DISK
000300110323     FKTH011WF  O  A F  400        DISK
000400101025     FAGCYRMG0  IF   E           K DISK
000500101025     FRMGRMST0  IF   E           K DISK
000600110323     FAGENL4    IF   E           K DISK
000700110323   X***X
000800110323     D @Y              S            400A   INZ
000900101025     D @X              S            400A   INZ
001000101025     D #ISO            S               D
001100101025     D #XSX            S              8S 0 INZ
001200101025     D Q               S              3A   INZ('","')
001300101025     D A               C                   CONST('''')
001400110323     D H@AGCY          S                   LIKE(F2AGCY)
001500110323   X***X
001600110323     C                   IF        F2AGCTRM = 0 AND F2RELTRM = 0 AND
001700110323     C                             F2SMNTRM = 0
001800110323     C                   IF        F2AGCY <> H@AGCY
001900110323     C                   EXSR      $RELMGR
002000110323     C                   ENDIF
002100110323     C                   IF        @X <> *BLANKS
002200110323     C                   EVAL      @Y = '"' + A + F2SMAN + Q +
002300110323     C                             %TRIM(F2SNAME) + '",' + %TRIM(@X)
002400110323     C                   EXCEPT    OUTF
002500110323     C                   ENDIF
002600110323     C                   ENDIF
002700110323   S***S
002800110323     C     $RELMGR       BEGSR
002900110323      *
003000110323     C                   EVAL      H@AGCY = F2AGCY
003100110323     C                   EVAL      @X = *BLANKS
003200110323      *
003300110323     C     F2AGCY        CHAIN     AGCYRMGR
003400110323     C                   IF        NOT %FOUND(AGCYRMG0)
003500110323     C                   LEAVESR
003600110323     C                   ENDIF
003700110323      *
003800110323     C     F2AGCY        CHAIN     AGENR
003900110323      *
004000101025     C                   EVAL      @X = '"' + A + AGCODE + Q + %TRIM(AGNAM1) +
004100101025     C                             Q + %TRIM(AGNAM2) + Q + ARSGR + Q
004200110323      *
004300101025     C     ARSGR         CHAIN     RMGRMSTR
004400101025     C                   IF        %FOUND(RMGRMST0)
004500101025     C                   EVAL      @X = %TRIM(@X) + %TRIM(RMNAME)
004600101025     C                   ENDIF
004700101025     C                   EVAL      @X = %TRIM(@X) + Q + ARLGR + Q
004800110323      *
004900101025     C     ARLGR         CHAIN     RMGRMSTR
005000101025     C                   IF        %FOUND(RMGRMST0)
005100101025     C                   EVAL      @X = %TRIM(@X) + %TRIM(RMNAME)
005200101025     C                   ENDIF
005300101025     C                   EVAL      @X = %TRIM(@X) + Q + ARRMGR + Q
005400110323      *
005500101025     C     ARRMGR        CHAIN     RMGRMSTR
005600101025     C                   IF        %FOUND(RMGRMST0)
005700101025     C                   EVAL      @X = %TRIM(@X) + %TRIM(RMNAME)
005800101025     C                   ENDIF
005900110323      *
006000101025     C                   EVAL      @X = %TRIM(@X) + Q + %TRIM(AGADD1) + Q +
006100101025     C                             %TRIM(AGADD2) + Q + %TRIM(AGCITY) + Q +
006200101025     C                             %TRIM(AGSTAT) + Q + A + %EDITC(AGZIP5:'X')
006300101025     C                             + '"'
006400110323      *
006500110323     C                   ENDSR
006600110323   S***S
006700101025     C     *INZSR        BEGSR
006800110323     C                   EVAL      @Y = '"RELATIONSHIP MANAGER REPORT - WITH' +
006900110323     C                                  ' BROKERS"'
007000101025     C                   EXCEPT    OUTF
007100110323     C                   EVAL      @Y = ','
007200101025     C                   EXCEPT    OUTF
007300101025     C                   MOVE      *DATE         #ISO
007400101025     C     *USA          MOVE      #ISO          #XSX
007500110323     C                   EVAL      @Y = '"AS OF: ' +
007600101025     C                             %EDITW(#XSX:'0  /  /    ') + '"'
007700101025     C                   EXCEPT    OUTF
007800110323     C                   EVAL      @Y = ','
007900101025     C                   EXCEPT    OUTF
008000110323     C                   EVAL      @Y = '"SMAN","SMAN",' +
008100110323     C                                  '"AGENCY","AGENCY","AGENCY","SMALL","' +
008200101025     C                             'SMALL GROUP","LARGE","LARGE GROUP","RELAT' +
008300101025     C                             'IONSHIP","RELATIONSHIP","ADDRESS","ADDRES' +
008400101025     C                             'S",,,,'
008500101025     C                   EXCEPT    OUTF
008600110323     C                   EVAL      @Y = '"CODE","NAME",' +
008700110323     C                                  '"CODE","NAME 1","NAME 2","GRP CDE","' +
008800101025     C                             'MANAGER","GRP CDE","MANAGER","MGR CODE","' +
008900101025     C                             'MANAGER","LINE 1","LINE 2","CITY","STATE"' +
009000101025     C                             ',"ZIP"'
009100101025     C                   EXCEPT    OUTF
009200101025     C                   ENDSR
009300110323   S***S
009400110323     OKTH011WF  EADD         OUTF
009500110323     O                       @Y             B   400
