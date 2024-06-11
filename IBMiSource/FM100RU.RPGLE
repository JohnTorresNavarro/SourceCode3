000100060626      * 06/26/06 dlk - remove self funded
000200060626
000300020614     FSMAN      UF   E           K DISK    USROPN
000400020614     FSLMHIST0  O  A E             DISK    USROPN
000500020612   X***X
000600020614     D BLOCKDATA     E DS                  EXTNAME(SMAN)
000700020612     D DS@K          E DS                  EXTNAME(SMAN) PREFIX(K)
000800020612     D @@INS                  96     99A
000900020612     D @@REQ                 100    101A
001000020612     D @@RTN                 102    102A
001100020612    ***
001200020612     D @273            S            273A
001300020612    ***
001400020612     D CMD             S            200A
001500020612     D LENGTH          S             15P 5
001600020612     D #LEN            S              3P 0
001700020612    ***
001800020614     D @TS40           S             40A
001900020614     D @TIMESTAMP      DS
002000020614     D  #TSCYMD                1      8S 0
002100020614     D  #TSTIME                9     14S 0
002200020614     D  @TSJOB                15     24
002300020614     D  @TSUSER               25     34
002400020614     D  #TSNBR                35     40S 0
002500020612   X***X
002600020612     C                   SELECT
002700020612     C                   WHEN      @@REQ = 'VR'
002800020612     C                   EXSR      $VERIFYSLM
002900020614     C                   WHEN      @@REQ = 'CG'
003000020614     C                   EXSR      $CHGROUPER
003100020612     C                   ENDSL
003200020612    ***
003300020612     C                   MOVEL     DS@K          @273
003400020612    ***
003500020612     C                   EVAL      *INLR = *ON
003600020612   S***S
003700020612     C     *INZSR        BEGSR
003800020612    ***
003900020612     C     *ENTRY        PLIST
004000020612     C                   PARM                    @273
004100020612     C                   MOVEL     @273          DS@K
004200020612    ***
004300020612     C                   ENDSR
004400020612   S***S
004500020612     C     $VERIFYSLM    BEGSR
004600020612    ***
004700020612     C                   EXSR      $OVRDDB
004800020612    ***
004900020612     C                   OPEN      SMAN
005000020612    ***
005100020612     C     KSMANCD       CHAIN(N)  SMANR
005200020612     C                   IF        %FOUND(SMAN)
005300020612     C                   EVAL      @@RTN = 'G'
005400020612     C                   ELSE
005500020612     C                   EVAL      @@RTN = 'N'
005600020612     C                   ENDIF
005700020612    ***
005800020612     C                   CLOSE     SMAN
005900020612    ***
006000020612     C                   EXSR      $RMVOVR
006100020612    ***
006200020612     C                   ENDSR
006300020612   S***S
006400020612     C     $OVRDDB       BEGSR
006500020612    ***
006600020612     C                   CLEAR                   CMD
006700020612    ***
006800071005     ******************************
006900071005     C*******************SELECT****
007000020612     C*
007100071005     ********************WHEN******@@INS = 'FULL'
007200020614     C                   EVAL      CMD = 'OVRDBF FILE(SMAN) TOFILE('     +
007300020614     C                             'F.SMAN) LVLCHK(*NO)'
007400020612     C*
007500071005     C*******************OTHER*****
007600071005     C*******************EVAL******@@RTN = 'E'
007700071005     C*******************LEAVESR***
007800071005     C*****************************
007900071005     C*******************ENDSL*****
008000020612    ***
008100020612     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
008200020612     C                   Z-ADD     #LEN          LENGTH
008300020612     C                   CALL      'QCMDEXC'                                    EXECUTE
008400020612     C                   PARM                    CMD
008500020612     C                   PARM                    LENGTH
008600020612    ***
008700020614     C                   CLEAR                   CMD
008800020614    ***
008900071005     C*******************SELECT****
009000071005     C*****************************
009100071005     C*******************WHEN******@@INS = 'FULL'
009200020614     C                   EVAL      CMD = 'OVRDBF FILE(SLMHIST0) TOFILE(F.SLM'  +
009300020614     C                             'HIST0) LVLCHK(*NO)'
009400071005     C*****************************
009500071005     C*******************OTHER*****
009600071005     C*******************EVAL******@@RTN = 'E'
009700071005     C*******************LEAVESR***
009800020614     C*
009900071005     C*******************ENDSL*****
010000020614    ***
010100020614     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
010200020614     C                   Z-ADD     #LEN          LENGTH
010300020614     C                   CALL      'QCMDEXC'                                    EXECUTE
010400020614     C                   PARM                    CMD
010500020614     C                   PARM                    LENGTH
010600020614    ***
010700020612     C                   ENDSR
010800020612   S***S
010900020612     C     $RMVOVR       BEGSR
011000020612    ***
011100020612     C                   CLEAR                   CMD
011200020612    ***
011300020612     C                   EVAL      CMD = 'DLTOVR FILE(SMAN) LVL(*)'
011400020612    ***
011500020612     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
011600020612     C                   Z-ADD     #LEN          LENGTH
011700020612     C                   CALL      'QCMDEXC'                                    EXECUTE
011800020612     C                   PARM                    CMD
011900020612     C                   PARM                    LENGTH
012000020614    ***
012100020614     C                   CLEAR                   CMD
012200020614    ***
012300020614     C                   EVAL      CMD = 'DLTOVR FILE(SLMHIST0) LVL(*)'
012400020614    ***
012500020614     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
012600020614     C                   Z-ADD     #LEN          LENGTH
012700020614     C                   CALL      'QCMDEXC'                                    EXECUTE
012800020614     C                   PARM                    CMD
012900020614     C                   PARM                    LENGTH
013000020614    ***
013100020614     C                   ENDSR
013200020614   S***S
013300020614     C     $CHGROUPER    BEGSR
013400020614    ***
013500020614     C                   EXSR      $OVRDDB
013600020614    ***
013700020614     C                   OPEN      SMAN
013800020614     C                   OPEN      SLMHIST0
013900020614    ***
014000020614     C     KSMANCD       CHAIN     SMANR
014100020614     C                   IF        %FOUND(SMAN)
014200020614     C                   EXSR      $PREPHIST
014300020614     C                   EVAL      @@RTN = 'G'
014400030620     C                   MOVEL     KSGRP         SGRP
014500020614     C                   UPDATE    SMANR
014600020614     C                   MOVEL     BLOCKDATA     HAFTER
014700020614     C                   WRITE     RSLMHIST
014800020614     C                   ELSE
014900020614     C                   EVAL      @@RTN = 'N'
015000020614     C                   ENDIF
015100020614    ***
015200020614     C                   CLOSE     SMAN
015300020614     C                   CLOSE     SLMHIST0
015400020614    ***
015500020614     C                   EXSR      $RMVOVR
015600020614    ***
015700020614     C                   ENDSR
015800020614   S***S
015900020614     C     $PREPHIST     BEGSR
016000020614    ***
016100020614     C                   CLEAR                   RSLMHIST
016200020614     C                   CLEAR                   @TIMESTAMP
016300020614     C                   MOVE      *BLANKS       @TS40
016400020614    ***
016500020614     C                   CALL      'TIMESTMP'
016600020614     C                   PARM                    @TS40
016700020614    ***
016800020614     C                   MOVEL     KSMANCD       HFSMAN
016900020614     C                   MOVEL     @TS40         @TIMESTAMP
017000020614     C                   MOVEL     @TSUSER       HUSERID
017100020614     C                   MOVE      #TSCYMD       HDATE
017200020614     C                   MOVE      #TSTIME       HTIME
017300020614     C                   MOVEL     @TSJOB        HJOB
017400020614     C                   MOVE      #TSNBR        HNUMBER
017500020614     C                   MOVEL     BLOCKDATA     HBEFORE
017600020612    ***
017700020612     C                   ENDSR
017800020612   S***S
