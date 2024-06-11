000100101025     FKTH010WF  O  A F  400        DISK
000200101025     FAGENL4    IPE  E           K DISK
000300101025     FAGCYRMG0  IF   E           K DISK
000400101025     FRMGRMST0  IF   E           K DISK
000500101025     D @X              S            400A   INZ
000600101025     D #ISO            S               D
000700101025     D #XSX            S              8S 0 INZ
000800101025     D Q               S              3A   INZ('","')
000900101025     D A               C                   CONST('''')
001000101025     C                   IF        AGTMDT = 0
001100101025     C     AGCODE        CHAIN     AGCYRMGR
001200101025     C                   IF        %FOUND(AGCYRMG0)
001300101025     C                   EVAL      @X = '"' + A + AGCODE + Q + %TRIM(AGNAM1) +
001400101025     C                             Q + %TRIM(AGNAM2) + Q + ARSGR + Q
001500101025     C     ARSGR         CHAIN     RMGRMSTR
001600101025     C                   IF        %FOUND(RMGRMST0)
001700101025     C                   EVAL      @X = %TRIM(@X) + %TRIM(RMNAME)
001800101025     C                   ENDIF
001900101025     C                   EVAL      @X = %TRIM(@X) + Q + ARLGR + Q
002000101025     C     ARLGR         CHAIN     RMGRMSTR
002100101025     C                   IF        %FOUND(RMGRMST0)
002200101025     C                   EVAL      @X = %TRIM(@X) + %TRIM(RMNAME)
002300101025     C                   ENDIF
002400101025     C                   EVAL      @X = %TRIM(@X) + Q + ARRMGR + Q
002500101025     C     ARRMGR        CHAIN     RMGRMSTR
002600101025     C                   IF        %FOUND(RMGRMST0)
002700101025     C                   EVAL      @X = %TRIM(@X) + %TRIM(RMNAME)
002800101025     C                   ENDIF
002900101025     C                   EVAL      @X = %TRIM(@X) + Q + %TRIM(AGADD1) + Q +
003000101025     C                             %TRIM(AGADD2) + Q + %TRIM(AGCITY) + Q +
003100101025     C                             %TRIM(AGSTAT) + Q + A + %EDITC(AGZIP5:'X')
003200101025     C                             + '"'
003300101025     C                   EXCEPT    OUTF
003400101025     C                   ENDIF
003500101025     C                   ENDIF
003600101025     C     *INZSR        BEGSR
003700101025     C                   EVAL      @X = '"RELATIONSHIP MANAGER REPORT"'
003800101025     C                   EXCEPT    OUTF
003900101025     C                   EVAL      @X = ','
004000101025     C                   EXCEPT    OUTF
004100101025     C                   MOVE      *DATE         #ISO
004200101025     C     *USA          MOVE      #ISO          #XSX
004300101025     C                   EVAL      @X = '"AS OF: ' +
004400101025     C                             %EDITW(#XSX:'0  /  /    ') + '"'
004500101025     C                   EXCEPT    OUTF
004600101025     C                   EVAL      @X = ','
004700101025     C                   EXCEPT    OUTF
004800101025     C                   EVAL      @X = '"AGENCY","AGENCY","AGENCY","SMALL","' +
004900101025     C                             'SMALL GROUP","LARGE","LARGE GROUP","RELAT' +
005000101025     C                             'IONSHIP","RELATIONSHIP","ADDRESS","ADDRES' +
005100101025     C                             'S",,,,'
005200101025     C                   EXCEPT    OUTF
005300101025     C                   EVAL      @X = '"CODE","NAME 1","NAME 2","GRP CDE","' +
005400101025     C                             'MANAGER","GRP CDE","MANAGER","MGR CODE","' +
005500101025     C                             'MANAGER","LINE 1","LINE 2","CITY","STATE"' +
005600101025     C                             ',"ZIP"'
005700101025     C                   EXCEPT    OUTF
005800101025     C                   ENDSR
005900101025     OKTH010WF  EADD         OUTF
006000101025     O                       @X             B   400
