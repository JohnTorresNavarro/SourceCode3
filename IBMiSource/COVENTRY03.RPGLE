000100060524     fPLNMST    IF   e           K disk
000200060523     fCMCT33    if   e           k disk
000300060515   X***X
000400060523     d @IN             s             10a
000500060523     d @OUT            S              8A
000600060523     D #CAP            S              8S 0
000700060523     D KEY@TRS         S                   LIKE(PLTRST)
000800060523     D KEY@SUB         S                   LIKE(PLSUB#)
000900060523     D KEY@PLN         S                   LIKE(PLPLAN)
001000060523     D KEY@ACC         S                   LIKE(CMACCT)
001100060523     D @T3             S              3A
001200060523     D @S3             S              3A
001300060523     D @A4             S              4A
001400060515   X***X
001500060523     C     KEY#PLAN      KLIST
001600060523     C                   KFLD                    KEY@TRS
001700060523     C                   KFLD                    KEY@SUB
001800060523     C                   KFLD                    KEY@PLN
001900060523     C*
002000060523     C     KEY#ACC       KLIST
002100060523     C                   KFLD                    KEY@TRS
002200060523     C                   KFLD                    KEY@SUB
002300060523     C                   KFLD                    KEY@ACC
002400060523     C*
002500060523     c     *ENTRY        PLIST
002600060523     C                   PARM                    @IN
002700060523     c                   PARM                    @OUT
002800060523     C*
002900060523     c                   EVAL      @T3 = %SUBST(@IN:1:3)
003000060523     c                   EVAL      @S3 = %SUBST(@IN:4:3)
003100060523     c                   EVAL      @A4 = %SUBST(@IN:7:4)
003200060523     C*
003300060523     c                   MOVE      @T3           KEY@TRS
003400060523     c                   MOVE      @S3           KEY@SUB
003500060523     c                   MOVE      @A4           KEY@ACC
003600060523     C*
003700060523     C                   EVAL      @OUT = '00000000'
003800060523     C                   EVAL      #CAP = 0
003900060523     C*
004000060523     c     KEY#ACC       SETLL     COMCXR
004100060523     c                   IF        %EQUAL
004200060523     C*
004300060523     c                   DOU       %EOF(CMCT33)
004400060523     c     KEY#ACC       READE     COMCXR
004500060523     c                   IF        NOT %EOF(CMCT33) AND EFFDAT <> CMCAN
004600060523     C*
004700060523     c                   EVAL      KEY@PLN = CMPLAN
004800060523     c     KEY#PLAN      CHAIN     PLNMSR
004900060523     c                   IF        %FOUND(PLNMST) AND PCARR = 'COV'
005000060523     c                   IF        #CAP < EFFDAT
005100060523     c                   EVAL      #CAP = EFFDAT
005200060523     c                   ENDIF
005300060524     c                   ENDIF
005400060523     C*
005500060523     c                   ENDIF
005600060523     c                   ENDDO
005700060523     C*
005800060523     c                   ENDIF
005900060523     C*
006000060523     C                   MOVE      #CAP          @OUT
006100060516     C                   EVAL      *INLR = *ON
