000100120517     FPLNUNIQUE IF   E           K DISK
000200120517     FCARUNIQUE IF   E           K DISK
000300130121     FACMUNIQUE IF   E           K DISK
000400120806     FCARACCX   UF   E           K DISK
000500120806     FCARXPTP   IF   E           K DISK
000600120517      *
000700130121     FCSAD2RPT  O  A F  500        DISK
000800111005   X***X
000900130121     D X               S            500A
001000130121     D P@T             S              3A
001100130121     D P@S             S              3A
001200130121     D P@A             S              4A
001300130121     D P@P             S              4A
001400130121     D KF@TRS          S              3S 0
001500130121     D KF@SUB          S              3S 0
001600130121     D KF@ACC          S              4S 0
001700130121     D KF@PLN          S              4A
001800111005   X***X
001900130121     C     *ENTRY        PLIST
002000130121     C                   PARM                    P@T
002100130121     C                   PARM                    P@S
002200130121     C                   PARM                    P@A
002300130121     C                   PARM                    P@P
002400130121    ***
002500130121     C                   MOVE      P@T           KF@TRS
002600130121     C                   MOVE      P@S           KF@SUB
002700130121     C                   MOVE      P@P           KF@PLN
002800130121     C                   MOVE      P@A           KF@ACC
002900130121    ***
003000130121     C     KL#TSP        KLIST
003100130121     C                   KFLD                    KF@TRS
003200130121     C                   KFLD                    KF@SUB
003300130121     C                   KFLD                    KF@PLN
003400130121    ***
003500130121     C     KL#TSA        KLIST
003600130121     C                   KFLD                    KF@TRS
003700130121     C                   KFLD                    KF@SUB
003800130121     C                   KFLD                    KF@ACC
003900130121    ***
004000130121     C                   EXSR      $CHECKING
004100130121    ***
004200130121     C                   EVAL      *INLR = *ON
004300130121   S***S
004400130121     C     $CHECKING     BEGSR
004500130121    ***
004600130121     C     KL#TSP        CHAIN     PLNMSR
004700130121     C                   IF        NOT %FOUND(PLNUNIQUE)
004800130121     C                   LEAVESR
004900130121     C                   ENDIF
005000130121    ***
005100130121     C     PCARR         CHAIN     CARMSR
005200130121     C                   IF        NOT %FOUND(CARUNIQUE)
005300130121     C                   LEAVESR
005400130121     C                   ENDIF
005500130121    ***
005600130121     C                   IF        CGRPCD <> 'AH' AND CGRPCD <> 'GA' AND
005700141210     C                             CGRPCD <> 'AV' AND CGRPCD <> 'EV' AND
005800130827     C                             CGRPCD <> 'VS' AND CGRPCD <> 'HU' AND
005900130121     C                             CGRPCD <> 'HI' AND CGRPCD <> 'CI'
006000130121     C                   LEAVESR
006100130121     C                   ENDIF
006200130121    ***
006300130121     C     KL#TSA        CHAIN     CARACCR
006400130121     C                   IF        %FOUND(CARACCX)
006500130121     C                   EXSR      $SHUTOFF
006600130121     C                   ENDIF
006700130121    ***
006800130121     C                   ENDSR
006900130121   S***S
007000130121     C     $SHUTOFF      BEGSR
007100130121    ***
007200130121     C     KL#TSA        SETLL     CARACCR
007300130121     C                   DOU       %EOF(CARACCX)
007400130121     C     KL#TSA        READE     CARACCR
007500130121     C                   IF        NOT %EOF(CARACCX) AND
007600130121     C                             CASTATUS = 'Y'
007700130121    ***
007800130121     C     CAUNIQ        CHAIN     CARXPTR
007900130121     C                   IF        NOT %FOUND(CARXPTP)
008000130121     C                   ITER
008100130121     C                   ENDIF
008200130121    ***
008300130121     C                   IF        CXGRPD = CGRPCD
008400130121     C                   EVAL      CASTATUS = 'N'
008500130121     C                   UPDATE    CARACCR
008600130121     C     KL#TSA        CHAIN     ACCMSR
008700130121     C                   EVAL      X = '"' + %CHAR(KF@TRS) + '","' +
008800130121     C                             %CHAR(KF@SUB) + '","' +
008900130121     C                             %CHAR(KF@ACC) + '","' +
009000130121     C                             %TRIM(ACNAM1) + '","' +
009100130121     C                             KF@PLN + '","' +
009200130121     C                             %TRIM(PDESCR) + '",,,"' +
009300130121     C                             PCARR + '","' +
009400130121     C                             %TRIM(CNAME) +
009500130122     C                             '"**TRANSMISSION STOPPED DUE TO PLAN CHANG' +
009600130122     C                             'E OR TERM"'
009700130121    ***
009800130121     C                   EXCEPT    OUTF
009900130121     C                   LEAVESR
010000130121     C                   ENDIF
010100130121    ***
010200130121     C                   ENDIF
010300130121     C                   ENDDO
010400130121    ***
010500130121     C                   ENDSR
010600120517   S***S
010700130121     OCSAD2RPT  EADD         OUTF
010800120517     O                       X              B   500
