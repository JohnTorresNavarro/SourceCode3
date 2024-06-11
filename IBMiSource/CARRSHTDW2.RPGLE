000100130121     FACMUNIQUE IF   E           K DISK
000200120806     FCARACCX   UF   E           K DISK
000300120517      *
000400130121     FCSAD2RPT  O  A F  500        DISK
000500111005   X***X
000600130121     D X               S            500A
000700130121     D P@T             S              3A
000800130121     D P@S             S              3A
000900130121     D P@A             S              4A
001000130121     D KF@TRS          S              3S 0
001100130121     D KF@SUB          S              3S 0
001200130121     D KF@ACC          S              4S 0
001300111005   X***X
001400130121     C     *ENTRY        PLIST
001500130121     C                   PARM                    P@T
001600130121     C                   PARM                    P@S
001700130121     C                   PARM                    P@A
001800130121    ***
001900130121     C                   MOVE      P@T           KF@TRS
002000130121     C                   MOVE      P@S           KF@SUB
002100130121     C                   MOVE      P@A           KF@ACC
002200130121    ***
002300130121     C     KL#TSA        KLIST
002400130121     C                   KFLD                    KF@TRS
002500130121     C                   KFLD                    KF@SUB
002600130121     C                   KFLD                    KF@ACC
002700130121    ***
002800130121     C                   EXSR      $CHECKING
002900130121    ***
003000130121     C                   EVAL      *INLR = *ON
003100130121   S***S
003200130121     C     $CHECKING     BEGSR
003300130121    ***
003400130121     C     KL#TSA        CHAIN     CARACCR
003500130121     C                   IF        %FOUND(CARACCX)
003600130121     C                   EXSR      $SHUTOFF
003700130121     C                   ENDIF
003800130121    ***
003900130121     C                   ENDSR
004000130121   S***S
004100130121     C     $SHUTOFF      BEGSR
004200130121    ***
004300130121     C     KL#TSA        SETLL     CARACCR
004400130121     C                   DOU       %EOF(CARACCX)
004500130121     C     KL#TSA        READE     CARACCR
004600130121     C                   IF        NOT %EOF(CARACCX) AND
004700130121     C                             CASTATUS = 'Y'
004800130121    ***
004900130121     C                   EVAL      CASTATUS = 'N'
005000130121     C                   UPDATE    CARACCR
005100130121     C     KL#TSA        CHAIN     ACCMSR
005200130121     C                   EVAL      X = '"' + %CHAR(KF@TRS) + '","' +
005300130121     C                             %CHAR(KF@SUB) + '","' +
005400130121     C                             %CHAR(KF@ACC) + '","' +
005500130122     C                             %TRIM(ACNAM1) + '",,,,,,,,,"' +
005600130122     C                             '"**TRANSMISSION STOPPED DUE TO ACCOUNT TE' +
005700130122     C                             'RM OR TRANSFER**"'
005800130121    ***
005900130121     C                   EXCEPT    OUTF
006000130121     C                   LEAVESR
006100130121    ***
006200130121     C                   ENDIF
006300130121     C                   ENDDO
006400130121    ***
006500130121     C                   ENDSR
006600120517   S***S
006700130121     OCSAD2RPT  EADD         OUTF
006800120517     O                       X              B   500
