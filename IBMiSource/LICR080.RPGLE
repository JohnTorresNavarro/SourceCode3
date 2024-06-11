000100140218   X***X RELATIONSHIP MANAGERS FOR ACTIVE AGENCIES REPORT
000200140218   X***X
000300140218   X***X SSK 02/18/2014
000400140218   X***X
000500140218     FAGCYRMG0  IPE  E           K DISK
000600140218     FAGENL4    IF   E           K DISK
000700140218     FRMGRMST0  IF   E           K DISK
000800140218     FT500      O  A F  500        DISK
000900140218   X***X
001000140218    ***
001100140218     D @SGR            S                   LIKE(RMNAME)
001200140218     D @LGR            S                   LIKE(RMNAME)
001300140218     D @RGR            S                   LIKE(RMNAME)
001400140218     D #ISO            S               D   DATFMT(*ISO)
001500140218     D #TODAY          S              8S 0 INZ
001600140218     D #XSX            S              8S 0 INZ
001700140218     D X               S            500A   INZ
001800140218     D Q               C                   CONST('","')
001900140218    ***
002000140218   X***X
002100140218     C     ARAGCY        CHAIN     AGENR
002200140218    ***
002300140218     C                   IF        %FOUND(AGENL4) AND
002400140218     C                             (AGTMDT = 0 OR AGTMDT > #TODAY)
002500140218    ***
002600140218     C                   EXSR      $MGRNAME
002700140218     C                   EVAL      X = '"' + ARAGCY + Q + %TRIM(AGNAM1) + Q +
002800140218     C                             %TRIM(@SGR) + Q + %TRIM(@LGR) + Q +
002900140218     C                             %TRIM(@RGR) + '"'
003000140218     C                   EXCEPT    OUTF
003100140218    ***
003200140218     C                   ENDIF
003300140218   S***S
003400140218     C     $MGRNAME      BEGSR
003500140218    ***
003600140218     C                   EVAL      @SGR = *BLANKS
003700140218     C                   EVAL      @LGR = *BLANKS
003800140218     C                   EVAL      @RGR = *BLANKS
003900140218    ***
004000140218     C     ARSGR         CHAIN     RMGRMSTR
004100140218     C                   IF        %FOUND(RMGRMST0)
004200140218     C                   EVAL      @SGR = %TRIM(RMNAME)
004300140218     C                   ENDIF
004400140218    ***
004500140218     C     ARLGR         CHAIN     RMGRMSTR
004600140218     C                   IF        %FOUND(RMGRMST0)
004700140218     C                   EVAL      @LGR = %TRIM(RMNAME)
004800140218     C                   ENDIF
004900140218    ***
005000140218     C     ARRMGR        CHAIN     RMGRMSTR
005100140218     C                   IF        %FOUND(RMGRMST0)
005200140218     C                   EVAL      @RGR = %TRIM(RMNAME)
005300140218     C                   ENDIF
005400140218    ***
005500140218     C                   ENDSR
005600140218   S***S
005700140218     C     *INZSR        BEGSR
005800140218    ***
005900140218     C                   EVAL      #ISO = %DATE
006000140218     C                   MOVE      #ISO          #TODAY
006100140218    ***
006200140218     C                   EVAL      X = '"AGENCY RELATIONSHIP MANAGER REPORT"'
006300140218     C                   EXCEPT    OUTF
006400140218    ***
006500140218     C                   EVAL      X = ','
006600140218     C                   EXCEPT    OUTF
006700140218     C                   EVAL      X = ','
006800140218     C                   EXCEPT    OUTF
006900140218    ***
007000140218     C                   EVAL      X = '"AGENCY CODE","AGENCY NAME","SMALL GR' +
007100140218     C                             'OUP MANAGER","LARGE GROUP MANAGER","MANAG' +
007200140218     C                             'ER RELATIONSHIP MANAGER"'
007300140218     C                   EXCEPT    OUTF
007400140218    ***
007500140218     C                   ENDSR
007600140218   S***S
007700140218     OT500      EADD         OUTF
007800140218     O                       X              B   500
