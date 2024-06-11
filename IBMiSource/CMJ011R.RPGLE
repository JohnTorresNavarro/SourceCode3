000100090730     FCMJ010WF  UF   E           K DISK
000200090730      *
000300090730     C                   DOU       %EOF(CMJ010WF)
000400090730     C                   READ      CMJF
000500090730     C                   IF        NOT %EOF(CMJ010WF)
000600090730      *
000700090730     C                   IF        CJCSTS = 'TERM' AND CJPSTS = 'TERM'
000800090730     C                   ITER
000900090730     C                   ENDIF
001000090730      *
001100090730     C                   IF        CJPSTS = 'ACTIVE' AND CJCSTS = 'TERM'
001200090730     C                   EVAL      CJPRV = CJCUR
001300090730     C                   EVAL      CJPSTS = CJCSTS
001400090730     C                   UPDATE    CMJF
001500090730     C                   ITER
001600090730     C                   ENDIF
001700090730      *
001800090730     C*****ALL ACTIVES FOR CURRENT
001900090730      *
002000090730     C                   EVAL      CJPRV = CJCUR
002100090730     C                   EVAL      CJPSTS = CJCSTS
002200090730     C                   MOVE      *BLANKS       CJCSTS
002300090730     C                   MOVE      *ZEROS        CJCUR
002400090730     C                   UPDATE    CMJF
002500090730      *
002600090730     C                   ENDIF
002700090730     C                   ENDDO
002800090730      *
002900090730     C                   EVAL      *INLR = *ON
