000100050705     FSMAN2L    UF   E           K DISK
000200050705     FSMANL3    IF   E           K DISK
000300050705     FSM2HIST1  UF   E           K DISK
000400050705    ***
000500050705     D P@GRPR          S              5A
000600050705     D K@G             S              5A
000700050705     D VALID_DLT       S               N
000800050705     D YES             S               N   INZ(*ON)
000900050705     D NO              S               N   INZ(*OFF)
001000050705    ***
001100050705     C     *ENTRY        PLIST
001200050705     C                   PARM                    P@GRPR
001300050705    ***
001400050705     C                   MOVE      P@GRPR        K@G
001500050705    ***
001600050705     C                   EXSR      $VALID
001700050705    ***
001800050705     C                   IF        VALID_DLT = YES
001900050705     C                   EXSR      $DELETE
002000050706     C                   EVAL      P@GRPR = 'PASS '
002100050705     C                   ELSE
002200050705     C                   EVAL      P@GRPR = 'FAIL '
002300050705     C                   ENDIF
002400050705    ***
002500050705     C                   EVAL      *INLR = *ON
002600050705    ***
002700050705     C                   RETURN
002800050706   S***S
002900050705     C     $VALID        BEGSR
003000050705    ***
003100050705     C                   EVAL      VALID_DLT = NO
003200050705    ***
003300050705     C     K@G           CHAIN(N)  SMAN2R
003400050705    ***
003500050705     C                   IF        NOT %FOUND(SMAN2L)
003600050705     C                   LEAVESR
003700050705     C                   ENDIF
003800050705    ***
003900050705     C     K@G           CHAIN     SMANR
004000050705     C                   IF        %FOUND(SMANL3)
004100050705     C                   LEAVESR
004200050705     C                   ENDIF
004300050705    ***
004400050705     C                   EVAL      VALID_DLT = YES
004500050705    ***
004600050705     C                   ENDSR
004700050706   S***S
004800050705     C     $DELETE       BEGSR
004900050706    ***
005000050706     C     K@G           CHAIN     SMAN2R
005100050706    ***
005200050706     C                   IF        %FOUND(SMAN2L)
005300050706     C     K@G           DELETE    SMAN2R
005400050706     C                   ENDIF
005500050706    ***
005600050706     C     K@G           CHAIN     RSM2HIST
005700050706     C                   DOW       %FOUND(SM2HIST1)
005800050706     C     K@G           DELETE    RSM2HIST
005900050706     C                   ENDDO
006000050706    ***
006100050706     C                   ENDSR
