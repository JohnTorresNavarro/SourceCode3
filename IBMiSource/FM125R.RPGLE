000100090515     FSPRAGXR1  IF   E           K DISK
000200090515     FSMANRLT3  IF   E           K DISK
000300090515     FBLITRKP   IF   E           K DISK
000400090515   X***X
000500090515     D @3              S              3A
000600090515     D KF@AGCY         S              3A
000700090515     D KF@TYPE         S              1A
000800090515     D KF@SMAN         S              3A
000900090515    ***
001000090515     C     *ENTRY        PLIST
001100090515     C                   PARM                    @3
001200090515    ***
001300090515     C     KL#BLT        KLIST
001400090515     C                   KFLD                    KF@TYPE
001500090515     C                   KFLD                    KF@SMAN
001600090515    ***
001700090515     C                   EVAL      KF@AGCY = @3
001800090515     C                   EVAL      @3 = 'OK*'
001900090515    ***
002000090515     C                   EXSR      $CHECK
002100090515    ***
002200090515     C                   EVAL      *INLR = *ON
002300090515    ***
002400090515   S***S
002500090515     C     $CHECK        BEGSR
002600090515    ***
002700090515     C     KF@AGCY       CHAIN     SXF
002800090515     C                   IF        NOT %FOUND(SPRAGXR1)
002900090515    1C                   LEAVESR
003000090515     C                   ENDIF
003100090515    ***
003200090515     C     KF@AGCY       SETLL     SXF
003300090515     C                   DOU       %EOF(SPRAGXR1)
003400090515     C     KF@AGCY       READE     SXF
003500090515     C                   IF        NOT %EOF(SPRAGXR1) AND
003600090515     C                             SXEFFDTE <> SXTRMDTE
003700090515    ***
003800090515     C     SXASID        CHAIN     SRF
003900090515     C                   IF        NOT %FOUND(SMANRLT3)
004000090515     C                   ITER
004100090515    0C                   ENDIF
004200090515    * *
004300090515     C     SXASID        SETLL     SRF
004400090515     C                   DOU       %EOF(SMANRLT3)
004500090515     C     SXASID        READE     SRF
004600090515     C                   IF        NOT %EOF(SMANRLT3) AND
004700090515     C                             SREFFDTE <> SRTRMDTE
004800090515    * *
004900090515     C                   IF        SRSMAN <> KF@SMAN
005000090515     C                   EVAL      KF@SMAN = SRSMAN
005100090515     C                   EVAL      KF@TYPE = 'S'
005200090515     C     KL#BLT        CHAIN     BLITRKR
005300090515     C                   IF        NOT %FOUND(BLITRKP)
005400090515     C                   EVAL      @3 = 'EXP'
005500090515     C                   LEAVESR
005600090515    0C                   ENDIF
005700090515    0C                   ENDIF
005800090515    * *
005900090515    0C                   ENDIF
006000090515    0C                   ENDDO
006100090515    ***
006200090515    0C                   ENDIF
006300090515    0C                   ENDDO
006400090515    ***
006500090515     C                   ENDSR
006600090515   S***S
