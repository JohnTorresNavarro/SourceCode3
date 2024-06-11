000100020613     F*-------------------------------------------------------------------------
000200020613     F* FM100      INNOVATIVE OUTSOURCING SOFTWARE 2002
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
001400020613     ** MODIFICATION HISTORY                                              **
001500020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001600020613     ** 000  SSK  06122002  ORIGINAL SOURCE                               **
001700020729     ** 001  SSK  07292002  EMAIL MAINT W/ RICK-MEISTER                   **
001800030304     ** 002  SSK  03042003  SALESMAN RELATIONSHIP HOOK IN                 **
001900060626     ** 06/26/06 dlk - remove self funded                                 **
002000060626     **                                                                   **
002100020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002200020612     FFM100D    CF   E             WORKSTN INFDS(WSDS)
002300020612   X***X
002400020612     D WSDS            DS
002500020612     D  FKEY                 369    369A
002600020612     D @BIAS           S              4A
002700020613     D @IM             S              1A
002800020614     D @273            S            273A
002900020614     D @IMHOLD         S              1A
003000020612    ***
003100020612     D  F1             C                   CONST(X'31')
003200020612     D  F2             C                   CONST(X'32')
003300020612     D  F3             C                   CONST(X'33')
003400020612     D  F4             C                   CONST(X'34')
003500020612     D  F5             C                   CONST(X'35')
003600020612     D  F6             C                   CONST(X'36')
003700020612     D  F7             C                   CONST(X'37')
003800020612     D  F8             C                   CONST(X'38')
003900020612     D  F9             C                   CONST(X'39')
004000020612     D  F10            C                   CONST(X'3A')
004100020612     D  F11            C                   CONST(X'3B')
004200020612     D  F12            C                   CONST(X'3C')
004300020612     D  F13            C                   CONST(X'B1')
004400020612     D  F14            C                   CONST(X'B2')
004500020612     D  F15            C                   CONST(X'B3')
004600020612     D  F16            C                   CONST(X'B4')
004700020612     D  F17            C                   CONST(X'B5')
004800020612     D  F18            C                   CONST(X'B6')
004900020612     D  F19            C                   CONST(X'B7')
005000020612     D  F20            C                   CONST(X'B8')
005100020612     D  F21            C                   CONST(X'B9')
005200020612     D  F22            C                   CONST(X'BA')
005300020612     D  F23            C                   CONST(X'BB')
005400020612     D  F24            C                   CONST(X'BC')
005500020612    ***
005600020612     D @STEP           S              5A
005700020613     D P@1             S              1A
005800020612     D P@3             S              3A
005900020612     D P@4             S              4A
006000020612     D @VP             S              1A
006100020612    ***
006200020612     D @EMSG           S             70A
006300071003     D I_INSTYPE       S              4A
006400020612   X***X
006500020613     C                   IF        @IM = 'I'
006600020613     C                   EVAL      *IN25 = *ON
006700020613     C                   ELSE
006800020613     C                   EVAL      *IN25 = *OFF
006900020613     C                   ENDIF
007000071003    ***
007100071003     C                   EVAL      @BIAS = 'FULL'
007200071003     C                   EVAL      P@4 = 'FULL'
007300071003     C                   EVAL      I_INSTYPE = 'FULL'
007400020613    ***
007500071003     C*******************MOVEL*****@BIAS         I_INSTYPE
007600020612     C                   DOU       @STEP = 'LEAVE'
007700020612     C     @STEP         CASEQ     'STEP1'       $STEP1
007800020612     C                   ENDCS
007900020612     C                   ENDDO
008000020612    ***
008100020612     C                   MOVE      *ON           *INLR
008200020612   S***S
008300020612     C     *INZSR        BEGSR
008400020612    ***
008500020612     C     *ENTRY        PLIST
008600020612     C                   PARM                    P@4
008700020613     C                   PARM                    P@1
008800020613    ***
008900071003     C*******************MOVEL*****P@4           @BIAS
009000020617     C                   EVAL      @IM     = P@1
009100020617     C                   EVAL      @IMHOLD = P@1
009200020617     C                   EVAL      @STEP   = 'STEP1'
009300020612    ***
009400020612     C                   ENDSR
009500020612   S***S
009600020612     C     $STEP1        BEGSR
009700020612    ***
009800020612     C                   MOVEL     @EMSG         EMSG
009900020612     C                   EXFMT     IO01
010000020612     C                   MOVE      *BLANKS       EMSG
010100020612     C                   MOVE      *BLANKS       @EMSG
010200020612     C                   EVAL      P@3 = *BLANKS
010300071003     C*******************EVAL      P@4 = *BLANKS
010400020612    ***
010500020612     C                   IF        FKEY = F7
010600020612     C                   EVAL      @STEP = 'LEAVE'
010700020612     C                   LEAVESR
010800020612     C                   ENDIF
010900101025    ***
011000101025     C                   IF        I_SMAN = '***'
011100101025     C                   CALL      'KTHMNUC'
011200101025     C                   LEAVESR
011300101025     C                   ENDIF
011400020612    ***
011500030521     C                   IF        FKEY = F12
011600071003     C*******************IF        I_INSTYPE <> 'FULL'
011700071003     C*******************EVAL      @EMSG = 'NEED INSURANCE TYPE'
011800071003     C*******************LEAVESR
011900071003     C*******************ENDIF
012000071003     C*******************eval      P@4 = i_instype
012100071003     C                   eval      P@4 = 'FULL'
012200030521     C                   CALL      'FM107CL'
012300030521     C                   PARM                    P@3
012400030521     C                   PARM                    P@4
012500030521     C                   IF        P@3 <> '*LR'
012600030521     C                   EVAL      I_SMAN = P@3
012700030521     C                   ENDIF
012800030521     C                   LEAVESR
012900030521     C                   ENDIF
013000030521    ***
013100020612     C                   IF        FKEY = F4
013200071003     C*******************IF        I_INSTYPE <> 'FULL'
013300071003     C*******************EVAL      @EMSG = 'NEED INSURANCE TYPE'
013400071003     C*******************LEAVESR
013500071003     C*******************ENDIF
013600030603     C                   EVAL      P@3 = I_SMAN
013700071003     C*******************EVAL      P@4 = I_INSTYPE
013800071003     C                   eval      P@4 = 'FULL'
013900020612     C                   CALL      'FM102CL'
014000020612     C                   PARM                    P@3
014100020612     C                   PARM                    P@4
014200020612     C                   IF        P@3 <> '*LR'
014300020612     C                   EVAL      I_SMAN = P@3
014400071003     C*******************EVAL      I_INSTYPE = P@4
014500020612     C                   ENDIF
014600020612     C                   LEAVESR
014700020612     C                   ENDIF
014800020612    ***
014900020613     C                   IF        FKEY = F5 AND *IN25 = *OFF
015000020612     C                   CALL      'FM101CL'
015100020612     C                   LEAVESR
015200020612     C                   ENDIF
015300020612    ***
015400030304     C                   IF        FKEY = F9 AND *IN25 = *OFF
015500030304     C                   EXSR      $F9
015600030304     C                   LEAVESR
015700030304     C                   ENDIF
015800030304    ***
015900020613     C                   IF        FKEY = F6 AND *IN25 = *OFF
016000020613     C                   EXSR      $F6
016100020613     C                   LEAVESR
016200020613     C                   ENDIF
016300020613    ***
016400090113     C                   IF        FKEY = F15 AND *IN25 = *OFF
016500090113    *C                   CALL      'WRKIRMCL'
016600090113     C                   LEAVESR
016700090113     C                   ENDIF
016800090113    ***
016900020612     C                   IF        FKEY = F11
017000020612     C                   EXSR      $F11
017100020612     C                   LEAVESR
017200020612     C                   ENDIF
017300020612    ***
017400030310    *C                   IF        FKEY = F8
017500030310    *C                   EXSR      $F8
017600030310    *C                   LEAVESR
017700030310    *C                   ENDIF
017800020729    ***
017900020612     C                   EXSR      $VALID
018000020612    ***
018100020613     C                   IF        @VP = 'Y'
018200020612     C*
018300020612     C                   EVAL      P@3 = I_SMAN
018400071003     C*******************EVAL******P@4 = I_INSTYPE
018500071003     C                   eval      P@4 = 'FULL'
018600020614     C                   EVAL      @IMHOLD = P@1
018700020617     C*
018800020612     C                   CALL      'FM104CL'
018900020612     C                   PARM                    P@3
019000020612     C                   PARM                    P@4
019100020613     C                   PARM                    P@1
019200020612     C*
019300020614     C                   IF        P@1 = 'X'
019400020612     C                   EVAL      @STEP = 'LEAVE'
019500020612     C                   LEAVESR
019600020612     C                   ELSE
019700020614     C                   EVAL      P@1 = @IMHOLD
019800020612     C                   EVAL      I_SMAN = *BLANKS
019900071003     C*******************MOVEL     @BIAS         I_INSTYPE
020000020612     C                   ENDIF
020100020612     C*
020200020612     C                   ENDIF
020300020613    ***
020400020613     C                   ENDSR
020500020613   S***S
020600020613     C     $F6           BEGSR
020700020613    ***
020800020613     C                   EXSR      $VALID
020900020613    ***
021000020614     C                   IF        (%SUBST(@273:102:1) = 'G' AND @VP = 'Y')
021100020614     C                             OR (%SUBST(@273:102:1) = ' ' AND
021200020614     C                             @VP = 'N')
021300020613     C                   EVAL      @EMSG = 'NEED INSURANCE TYPE AND NON-' +
021400020613     C                             'EXISTING SALESMAN CODE'
021500020613     C                   LEAVESR
021600020613     C                   ENDIF
021700020614    ***
021800020613     C                   EVAL      P@3 = I_SMAN
021900071003     C*******************EVAL******P@4 = I_INSTYPE
022000071003     C                   eval      P@4 = 'FULL'
022100020613     C                   EVAL      P@1 = 'A'
022200020613    ***
022300020613     C                   CALL      'FM104CL'
022400020613     C                   PARM                    P@3
022500020613     C                   PARM                    P@4
022600020613     C                   PARM                    P@1
022700020617    ***
022800020617     C                   IF        P@1 = 'X'
022900020617     C                   EVAL      @STEP = 'LEAVE'
023000020617     C                   LEAVESR
023100020617     C                   ELSE
023200020617     C                   EVAL      P@1 = @IMHOLD
023300020617     C                   EVAL      I_SMAN = *BLANKS
023400071003     C*******************MOVEL*****@BIAS         I_INSTYPE
023500020617     C                   ENDIF
023600020612    ***
023700020612     C                   ENDSR
023800020612   S***S
023900030304     C     $F9           BEGSR
024000030304    ***
024100090317    *C*                  EXSR      $VALID
024200090317    ***
024300090317    *C*                  IF        @VP = 'N'
024400090317    *C*                  EVAL      @EMSG = 'NEED VALID SALESMAN CODE AND' +
024500090317    *C*                            ' INSURANCE TYPE TO ACCESS HISTORY INQ'
024600090317    *C*                  LEAVESR
024700090317    *C*                  ENDIF
024800090317    ***
024900090317    *C*                  EVAL      P@3 = I_SMAN
025000090317    ***
025100090317    *C*                  CALL      'FM482CL'
025200090317    *C*                  PARM                    P@3
025300030304    ***
025400090317     C                   CALL      'WRKSRECL'
025500090317    ***
025600030304     C                   ENDSR
025700030304   S***S
025800020612     C     $F11          BEGSR
025900020612    ***
026000020612     C                   EXSR      $VALID
026100020612    ***
026200020612     C                   IF        @VP = 'N'
026300020612     C                   EVAL      @EMSG = 'NEED VALID SALESMAN CODE AND' +
026400020612     C                             ' INSURANCE TYPE TO ACCESS HISTORY INQ'
026500020612     C                   LEAVESR
026600020612     C                   ENDIF
026700020612    ***
026800020612     C                   EVAL      P@3 = I_SMAN
026900071003     C*******************EVAL******P@4 = I_INSTYPE
027000071003     C                   eval      P@4 = 'FULL'
027100020612    ***
027200020612     C                   CALL      'FM103CL'
027300020612     C                   PARM                    P@3
027400020612     C                   PARM                    P@4
027500020729    ***
027600020729     C                   ENDSR
027700020729   S***S
027800030310    *C     $F8           BEGSR
027900020813    ***
028000071003     ******************************
028100071003     ********************IF********I_INSTYPE <> 'FULL'
028200071003     C*******************EVAL******@EMSG = 'NEED INSURANCE TYPE'
028300071003     C*******************LEAVESR***
028400071003     C*******************ENDIF*****
028500030603    ***
028600030603    *C                   EVAL      P@1 = *blanks
028700071003    *C*******************EVAL******P@4 = I_INSTYPE
028800071003     C                   eval      P@4 = 'FULL'
028900030603    ***
029000030313    *C                   CALL      'FM106CL'
029100030313    *C                   PARM                    P@4
029200030603    *C                   PARM                    P@1
029300020612    ***
029400030603     C                   IF        P@1 = 'X'
029500030603     C                   EVAL      @STEP = 'LEAVE'
029600030603     C                   LEAVESR
029700030603     C                   ELSE
029800030603     C                   EVAL      P@1 = @IMHOLD
029900030603     C                   EVAL      I_SMAN = *BLANKS
030000071003     C*******************MOVEL*****@BIAS         I_INSTYPE
030100030603     C                   ENDIF
030200030603    ***
030300030310    *C                   ENDSR
030400020612   S***S
030500020612     C     $VALID        BEGSR
030600020612    ***
030700020612     C                   EVAL      @VP = 'N'
030800020614     C                   CLEAR                   @273
030900020612    ***
031000071003     C*******************IF        I_INSTYPE <> 'FULL'
031100071003     C*******************LEAVESR
031200071003     C*******************ENDIF
031300020612    ***
031400020612     C                   IF        I_SMAN = *BLANKS
031500020612     C                   LEAVESR
031600020612     C                   ENDIF
031700020614    ***
031800020614     C                   EVAL      %SUBST(@273:1:3) = I_SMAN
031900071003     C*******************EVAL      %SUBST(@273:96:4) = I_INSTYPE
032000020614     C                   EVAL      %SUBST(@273:100:2) = 'VR'
032100020614     C                   CALL      'FM100RU'
032200020614     C                   PARM                    @273
032300020614     C                   IF        %SUBST(@273:102:1) = 'N'
032400020614     C                   LEAVESR
032500020614     C                   ENDIF
032600020612    ***
032700020612     C                   EVAL      @VP = 'Y'
032800020612    ***
032900020612     C                   ENDSR
033000020612   S***S
