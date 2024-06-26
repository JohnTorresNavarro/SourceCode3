000100020613     F*-------------------------------------------------------------------------
000200020613     F* FM104RU    INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020613     F*            FM10* SALESMAN MASTER APPLICATION
000400020613     F*            WRITTEN BY - S.S.K.
000500020613     F*            DATE - 06/02
000600020613     F*  DESCRIPTION - NEXT GROUPER NUMBER
000700020613     F*
000800020613     F*-------------------------------------------------------------------------
000900020613     ** MODIFICATION HISTORY                                              **
001000020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001100020613     ** 000  SSK  06132002  ORIGINAL SOURCE                               **
001200080610     ** 001  SSK  06102008  REWRITE TO USE DATA AREA                      **
001300020613     **                                                                   **
001400020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001500020612   X***X
001600020613     D P@5             S              5A
001700020612   X***X
001800080610     C     *ENTRY        PLIST
001900080610     C                   PARM                    P@5
002000020612    ***
002100080610     C     *DTAARA       DEFINE    NXTGRP        #SEQ              5 0
002200080610     C     *LOCK         IN        #SEQ
002300080610     C                   MOVE      #SEQ          P@5
002400080610     C                   ADD       1             #SEQ
002500080610     C                   OUT       #SEQ
002600080610    ***
002700080610     C                   RETURN
002800080610     F*FM102W3   IF   E           K DISK
002900080610     F*sman2l    IF   E           K DISK
003000080610   X***X
003100080610    *D*P@5             S              5A
003200080610    *D*#C              S              5S 0
003300080610    *D*@5              S              5A   INZ('00001')
003400080610   X***X
003500080610    *C*                  DOU       %EOF(FM102W3)
003600080610    *C*                  READ      SMANR
003700080610    *C*                  IF        NOT %EOF(FM102W3)
003800080610    ***
003900080610    *C*                  IF        SGRP > @5
004000080610    *C*                  ADD       1             #C
004100080610    *C*                  MOVE      #C            @5
004200080610    *C*
004300080610    *C*                  IF        SGRP > @5
004400080610    *C*    @5            CHAIN     SMAN2R
004500080610    *C*                  IF        %FOUND(SMAN2L)
004600080610    *C*                  ITER
004700080610    *C*                  ENDIF
004800080610    *C*                  LEAVE
004900080610    *C*                  ENDIF
005000080610    *C*
005100080610    *C*                  ENDIF
005200080610    ***
005300080610    *C*                  ENDIF
005400080610    *C*                  ENDDO
005500080610    ***
005600080610    *C*                  IF        SGRP = @5
005700080610    *C*                  ADD       1             #C
005800080610    *C*                  MOVE      #C            @5
005900080610    *C*                  ENDIF
006000080610    ***
006100080610    *C*                  MOVE      @5            P@5
006200080610    *C*                  MOVE      *ON           *INLR
006300080610   S***S
006400080610    *C*    *INZSR        BEGSR
006500080610    ***
006600080610    *C*    *ENTRY        PLIST
006700080610    *C*                  PARM                    P@5
006800080610    ***
006900080610    *C*                  Z-ADD     1             #C
007000080610    ***
007100080610    *C*                  ENDSR
007200080610   S***S
