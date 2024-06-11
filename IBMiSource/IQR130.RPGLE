000100020613     F*-------------------------------------------------------------------------
000200040708     F* IQR130     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020613     F*            FM10* SALESMAN MASTER APPLICATION
000400020613     F*            WRITTEN BY - S.S.K.
000500020613     F*            DATE - 06/02
000600020613     F*  DESCRIPTION - PROMPT
000700020613     F*  INDICATOR USAGE:
000800020613     F*    01 = EXIT FROM INITIAL SCREEN
000900020613     F*    25 = SFLDSP
001000020613     F*    26 = SFL DSP CTL
001100020613     F*    27 = SFL CLR
001200020613     F*
001300020613     F*-------------------------------------------------------------------------
001400040102     ** MODIFICATION HISTORY - FROM FM100R                                **
001500020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001600020613     ** 000  SSK  06122002  ORIGINAL SOURCE                               **
001700020729     ** 001  SSK  07292002  EMAIL MAINT W/ RICK-MEISTER                   **
001800030304     ** 002  SSK  03042003  SALESMAN RELATIONSHIP HOOK IN                 **
001900040708     ** ***  SSK  01022004  COPIED TO IQ AND MADE INQUIRY ONLY            **
002000020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100040708     FIQR130D   CF   E             WORKSTN INFDS(WSDS)
002200020612   X***X
002300020612     D WSDS            DS
002400020612     D  FKEY                 369    369A
002500020612     D @BIAS           S              4A
002600020613     D @IM             S              1A
002700020614     D @273            S            273A
002800020614     D @IMHOLD         S              1A
002900020612    ***
003000020612     D  F1             C                   CONST(X'31')
003100020612     D  F2             C                   CONST(X'32')
003200020612     D  F3             C                   CONST(X'33')
003300020612     D  F4             C                   CONST(X'34')
003400020612     D  F5             C                   CONST(X'35')
003500020612     D  F6             C                   CONST(X'36')
003600020612     D  F7             C                   CONST(X'37')
003700020612     D  F8             C                   CONST(X'38')
003800020612     D  F9             C                   CONST(X'39')
003900020612     D  F10            C                   CONST(X'3A')
004000020612     D  F11            C                   CONST(X'3B')
004100020612     D  F12            C                   CONST(X'3C')
004200020612     D  F13            C                   CONST(X'B1')
004300020612     D  F14            C                   CONST(X'B2')
004400020612     D  F15            C                   CONST(X'B3')
004500020612     D  F16            C                   CONST(X'B4')
004600020612     D  F17            C                   CONST(X'B5')
004700020612     D  F18            C                   CONST(X'B6')
004800020612     D  F19            C                   CONST(X'B7')
004900020612     D  F20            C                   CONST(X'B8')
005000020612     D  F21            C                   CONST(X'B9')
005100020612     D  F22            C                   CONST(X'BA')
005200020612     D  F23            C                   CONST(X'BB')
005300020612     D  F24            C                   CONST(X'BC')
005400020612    ***
005500020612     D @STEP           S              5A
005600020613     D P@1             S              1A
005700020612     D P@3             S              3A
005800020612     D P@4             S              4A
005900020612     D @VP             S              1A
006000020612    ***
006100020612     D @EMSG           S             70A
006200020612   X***X
006300020613    ***
006400020612     C                   DOU       @STEP = 'LEAVE'
006500040102     C                   MOVEL     'FULL'        I_INSTYPE
006600020612     C     @STEP         CASEQ     'STEP1'       $STEP1
006700020612     C                   ENDCS
006800020612     C                   ENDDO
006900020612    ***
007000020612     C                   MOVE      *ON           *INLR
007100020612   S***S
007200020612     C     *INZSR        BEGSR
007300020613    ***
007400020617     C                   EVAL      @STEP   = 'STEP1'
007500020612    ***
007600020612     C                   ENDSR
007700020612   S***S
007800020612     C     $STEP1        BEGSR
007900020612    ***
008000020612     C                   MOVEL     @EMSG         EMSG
008100020612     C                   EXFMT     IO01
008200020612     C                   MOVE      *BLANKS       EMSG
008300020612     C                   MOVE      *BLANKS       @EMSG
008400020612     C                   EVAL      P@3 = *BLANKS
008500020612     C                   EVAL      P@4 = *BLANKS
008600020612    ***
008700020612     C                   IF        FKEY = F7
008800020612     C                   EVAL      @STEP = 'LEAVE'
008900020612     C                   LEAVESR
009000020612     C                   ENDIF
009100020612    ***
009200020612     C                   IF        FKEY = F4
009300030603     C                   EVAL      P@3 = I_SMAN
009400040102     C                   EVAL      P@4 = 'FULL'
009500040708     C                   CALL      'IQC131'
009600020612     C                   PARM                    P@3
009700020612     C                   PARM                    P@4
009800020612     C                   IF        P@3 <> '*LR'
009900020612     C                   EVAL      I_SMAN = P@3
010000020612     C                   ENDIF
010100020612     C                   LEAVESR
010200020612     C                   ENDIF
010300020612    ***
010400030304     C                   IF        FKEY = F9 AND *IN25 = *OFF
010500030304     C                   EXSR      $F9
010600030304     C                   LEAVESR
010700030304     C                   ENDIF
010800020613    ***
010900020612     C                   IF        FKEY = F11
011000020612     C                   EXSR      $F11
011100020612     C                   LEAVESR
011200020612     C                   ENDIF
011300020612    ***
011400020612     C                   EXSR      $VALID
011500020612    ***
011600020613     C                   IF        @VP = 'Y'
011700020612     C*
011800020612     C                   EVAL      P@3 = I_SMAN
011900040102     C                   EVAL      P@4 = 'FULL'
012000020617     C*
012100040708     C                   CALL      'IQC133'
012200020612     C                   PARM                    P@3
012300020612     C                   PARM                    P@4
012400020613     C                   PARM                    P@1
012500020612     C*
012600020614     C                   IF        P@1 = 'X'
012700020612     C                   EVAL      @STEP = 'LEAVE'
012800020612     C                   LEAVESR
012900020612     C                   ELSE
013000020612     C                   EVAL      I_SMAN = *BLANKS
013100020612     C                   ENDIF
013200020612     C*
013300020612     C                   ENDIF
013400020613    ***
013500020613     C                   ENDSR
013600020612   S***S
013700030304     C     $F9           BEGSR
013800030304    ***
013900030304     C                   EXSR      $VALID
014000030304    ***
014100030304     C                   IF        @VP = 'N'
014200030304     C                   EVAL      @EMSG = 'NEED VALID SALESMAN CODE AND' +
014300030304     C                             ' INSURANCE TYPE TO ACCESS HISTORY INQ'
014400030304     C                   LEAVESR
014500030304     C                   ENDIF
014600030304    ***
014700030304     C                   EVAL      P@3 = I_SMAN
014800030304    ***
014900040708     C                   CALL      'IQC172'
015000030304     C                   PARM                    P@3
015100030304    ***
015200030304     C                   ENDSR
015300030304   S***S
015400020612     C     $F11          BEGSR
015500020612    ***
015600020612     C                   EXSR      $VALID
015700020612    ***
015800020612     C                   IF        @VP = 'N'
015900020612     C                   EVAL      @EMSG = 'NEED VALID SALESMAN CODE AND' +
016000020612     C                             ' INSURANCE TYPE TO ACCESS HISTORY INQ'
016100020612     C                   LEAVESR
016200020612     C                   ENDIF
016300020612    ***
016400020612     C                   EVAL      P@3 = I_SMAN
016500040102     C                   EVAL      P@4 = 'FULL'
016600020612    ***
016700040708     C                   CALL      'IQC132'
016800020612     C                   PARM                    P@3
016900020612     C                   PARM                    P@4
017000020729    ***
017100020729     C                   ENDSR
017200040107   S***S
017300020612     C     $VALID        BEGSR
017400020612    ***
017500020612     C                   EVAL      @VP = 'N'
017600020614     C                   CLEAR                   @273
017700020612    ***
017800020612     C                   IF        I_SMAN = *BLANKS
017900020612     C                   LEAVESR
018000020612     C                   ENDIF
018100020614    ***
018200020614     C                   EVAL      %SUBST(@273:1:3) = I_SMAN
018300040102     C                   EVAL      %SUBST(@273:96:4) = 'FULL'
018400020614     C                   EVAL      %SUBST(@273:100:2) = 'VR'
018500040708     C                   CALL      'IQR130U'
018600020614     C                   PARM                    @273
018700020614     C                   IF        %SUBST(@273:102:1) = 'N'
018800020614     C                   LEAVESR
018900020614     C                   ENDIF
019000020612    ***
019100020612     C                   EVAL      @VP = 'Y'
019200020612    ***
019300020612     C                   ENDSR
019400020612   S***S
