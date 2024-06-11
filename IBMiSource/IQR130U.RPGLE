000100020614     FSMAN      UF   E           K DISK    USROPN
000200020612   X***X
000300020614     D BLOCKDATA     E DS                  EXTNAME(SMAN)
000400020612     D DS@K          E DS                  EXTNAME(SMAN) PREFIX(K)
000500020612     D @@INS                  96     99A
000600020612     D @@REQ                 100    101A
000700020612     D @@RTN                 102    102A
000800020612    ***
000900020612     D @273            S            273A
001000020612    ***
001100020612     D CMD             S            200A
001200020612     D LENGTH          S             15P 5
001300020612     D #LEN            S              3P 0
001400020612    ***
001500020612   X***X
001600040102     C                   IF        @@REQ = 'VR'
001700020612     C                   EXSR      $VERIFYSLM
001800040102     C                   ENDIF
001900020612    ***
002000020612     C                   MOVEL     DS@K          @273
002100020612    ***
002200020612     C                   EVAL      *INLR = *ON
002300020612   S***S
002400020612     C     *INZSR        BEGSR
002500020612    ***
002600020612     C     *ENTRY        PLIST
002700020612     C                   PARM                    @273
002800020612     C                   MOVEL     @273          DS@K
002900020612    ***
003000020612     C                   ENDSR
003100020612   S***S
003200020612     C     $VERIFYSLM    BEGSR
003300020612    ***
003400020612     C                   EXSR      $OVRDDB
003500020612    ***
003600020612     C                   OPEN      SMAN
003700020612    ***
003800020612     C     KSMANCD       CHAIN(N)  SMANR
003900020612     C                   IF        %FOUND(SMAN)
004000020612     C                   EVAL      @@RTN = 'G'
004100020612     C                   ELSE
004200020612     C                   EVAL      @@RTN = 'N'
004300020612     C                   ENDIF
004400020612    ***
004500020612     C                   CLOSE     SMAN
004600020612    ***
004700020612     C                   EXSR      $RMVOVR
004800020612    ***
004900020612     C                   ENDSR
005000020612   S***S
005100020612     C     $OVRDDB       BEGSR
005200020612    ***
005300020612     C                   CLEAR                   CMD
005400020612    ***
005500020614     C                   EVAL      CMD = 'OVRDBF FILE(SMAN) TOFILE('     +
005600020614     C                             'F.SMAN) LVLCHK(*NO)'
005700020612    ***
005800020612     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
005900020612     C                   Z-ADD     #LEN          LENGTH
006000020612     C                   CALL      'QCMDEXC'                                    EXECUTE
006100020612     C                   PARM                    CMD
006200020612     C                   PARM                    LENGTH
006300020614    ***
006400020612     C                   ENDSR
006500020612   S***S
006600020612     C     $RMVOVR       BEGSR
006700020612    ***
006800020612     C                   CLEAR                   CMD
006900020612    ***
007000020612     C                   EVAL      CMD = 'DLTOVR FILE(SMAN) LVL(*)'
007100020612    ***
007200020612     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
007300020612     C                   Z-ADD     #LEN          LENGTH
007400020612     C                   CALL      'QCMDEXC'                                    EXECUTE
007500020612     C                   PARM                    CMD
007600020612     C                   PARM                    LENGTH
007700020614    ***
007800020614     C                   ENDSR
007900020614   S***S
