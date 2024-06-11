000100130904   X***X COBRA STATE MONITOR AND THREW IN COBRA FLAGS AS WELL
000200130904   X***X
000300130904   X***X  JUST A QUICK HIT FOR LISA K
000400130904   X***X
000500130904   X***X SSK 09/04/2013
000600130904   X***X
000700130904   X***X
000800130904   X***X
000900130904   X***X
001000130904     FACMUNIQUE IPE  E           K DISK
001100130904     FAC2MSTL2  IF   E           K DISK
001200130904     FCOB332WF  UF A E           K DISK
001300130904     FT500      O  A F  500        DISK
001400130904   X***X
001500130904    ***
001600130904     D X               S            500A
001700130904     D E               S            500A
001800130904     D M               S            100A
001900130904     D WO              S              1A   INZ('N')
002000130904    ***
002100130904   X***X
002200130904    ***
002300130904     C                   IF        ATRMDT = 0
002400130904    ***
002500130904     C     KL#           CHAIN     ACCMSR2
002600130904    ***
002700130904     C     KL#           CHAIN     F332
002800130904    ***
002900130904     C                   IF        NOT %FOUND(COB332WF)
003000130904    ***
003100130904     C                   EXSR      $GENEW
003200130904    ***
003300130904     C                   ELSE
003400130904    ***
003500130904     C                   EXSR      $CHECK
003600130904    *** *
003700130904     C                   IF        E <> *BLANKS
003800130904     C                   EVAL      C3ACSTATE = ASTATE
003900130904     C                   EVAL      C3A2STATE = A2STATE
004000130904     C                   EVAL      C3COBRA = FCSTFL
004100130904     C                   EVAL      C3SERVC = ACOBSRV
004200130904     C                   UPDATE    F332
004300130904     C                   EXSR      $WRTSTATUS
004400130904     C                   ENDIF
004500130904    *** *
004600130904     C                   ENDIF
004700130904    ***
004800130904     C                   ENDIF
004900130904   S***S
005000130904     ****GENERATE NEW RECORD FOR MONITORING
005100130904     ****
005200130904     C     $GENEW        BEGSR
005300130904    ***
005400130904     C                   CLEAR                   F332
005500130904     C                   EVAL      C3TRST = ACTRST
005600130904     C                   EVAL      C3SUB# = ACSUB#
005700130904     C                   EVAL      C3ACCT = ACACCT
005800130904     C                   EVAL      C3ACSTATE = ASTATE
005900130904     C                   EVAL      C3A2STATE = A2STATE
006000130904     C                   EVAL      C3COBRA = FCSTFL
006100130904     C                   EVAL      C3SERVC = ACOBSRV
006200130904     C                   WRITE     F332
006300130904    ***
006400130904     C                   ENDSR
006500130904   S***S
006600130904     ****CHECK RECORD FOR CHANGES
006700130904     ****
006800130904     C     $CHECK        BEGSR
006900130904    ***
007000130904     C                   EVAL      E = *BLANKS
007100130904     C                   EVAL      M = *BLANKS
007200130904    ***
007300130904     C                   IF        C3ACSTATE <> ASTATE
007400130904     C                   EVAL      M = 'ACCT MASTER STATE CHANGED FROM: ' +
007500130904     C                             C3ACSTATE + ' TO: ' + ASTATE
007600130904     C                   EXSR      $MSG
007700130904     C                   ENDIF
007800130904     C                   IF        C3A2STATE <> A2STATE
007900130904     C                   EVAL      M = 'ACCT MASTER 2 STATE CHANGED FROM: ' +
008000130904     C                             C3A2STATE + ' TO: ' + A2STATE
008100130904     C                   EXSR      $MSG
008200130904     C                   ENDIF
008300130904     C                   IF        C3COBRA <> FCSTFL
008400130904     C                   EVAL      M = 'FED STATE COBRA FLAG CHANGED FROM: ' +
008500130904     C                             C3COBRA + ' TO: ' + FCSTFL
008600130904     C                   EXSR      $MSG
008700130904     C                   ENDIF
008800130904     C                   IF        C3SERVC <> ACOBSRV
008900130904     C                   EVAL      M = 'COBRA SERVICE CHANGED FROM: ' +
009000130904     C                             C3SERVC + ' TO: ' + ACOBSRV
009100130904     C                   EXSR      $MSG
009200130904     C                   ENDIF
009300130904    ***
009400130904     C                   ENDSR
009500130904   S***S
009600130904     ****APPEND MESSAGES TO BUILD STATUS UPDATE
009700130904     ****
009800130904     C     $MSG          BEGSR
009900130904    ***
010000130904     C                   IF        E = *BLANKS
010100130904     C                   EVAL      E = '"' + %TRIM(M) + '",'
010200130904     C                   ELSE
010300130904     C                   EVAL      E = %TRIM(E) + '"' + %TRIM(M) + '",'
010400130904     C                   ENDIF
010500130904    ***
010600130904     C                   EVAL      M = *BLANKS
010700130904    ***
010800130904     C                   ENDSR
010900130904   S***S
011000130904     ****WRITE STATUS UPDATE
011100130904     ****
011200130904     C     $WRTSTATUS    BEGSR
011300130904    ***
011400130904     C                   IF        WO = 'N'
011500130904     C                   EVAL      WO = 'Y'
011600130904     C                   EVAL      X = '"COBRA ACCOUNT STATUS MONITOR REPORT"'
011700130904     C                   EXCEPT    OUTF
011800130904     C                   EVAL      X = ','
011900130904     C                   EXCEPT    OUTF
012000130904     C                   EVAL      X = '"TRUST","SUB","ACCT","NAME","MSG1","M' +
012100130904     C                             'SG2","MSG3","MSG4"'
012200130904     C                   EXCEPT    OUTF
012300130904     C                   ENDIF
012400130904    ***
012500130904     C                   EVAL      X = '"' + %EDITC(ACTRST:'X') + '","' +
012600130904     C                             %EDITC(ACSUB#:'X') + '","' +
012700130904     C                             %EDITC(ACACCT:'X') + '","' +
012800130910     C                             %TRIM(ACNAM1) + '",' +
012900130905     C                             %TRIM(E)
013000130904     C                   EXCEPT    OUTF
013100130904    ***
013200130904     C                   ENDSR
013300130904   S***S
013400130904     C     *INZSR        BEGSR
013500130904    ***
013600130904     C     KL#           KLIST
013700130904     C                   KFLD                    ACTRST
013800130904     C                   KFLD                    ACSUB#
013900130904     C                   KFLD                    ACACCT
014000130904    ***
014100130904     C                   ENDSR
014200130904   S***S
014300130904   X***X
014400130904     OT500      EADD         OUTF
014500130904     O                       X              B   500
