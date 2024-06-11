000100001207     F*-------------------------------------------------------------------------
000200040708     F* IQR131     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300001207     F*            WRITTEN BY - S.S.K.
000400020612     F*            DATE - 06/02
000500020612     F*  DESCRIPTION - DISPLAY SMAN RECORDS FROM SALESMAN CODE FILES
000600001207     F*  INDICATOR USAGE:
000700020612     F*    01 = EXIT FROM INITIAL SCREEN
000800001207     F*    25 = SFLDSP
000900001207     F*    26 = SFL DSP CTL
001000001207     F*    27 = SFL CLR
001100001207     F*
001200020619     F* INDS FOR SFL CTL DATA
001300020619     F* N30 N31 LOAD SALESMAN CODE SEQ & SHOW NEXT SORT TEXT OF FIRST NAME
001400020619     F*  30 N31 LOAD FIRST NAME SEQ & SHOW NEXT SORT TEXT OF LAST NAME
001500020619     F*  30  31 LOAD LAST NAME SEQ & SHOW NEXT SORT TEXT OF SALESMAN CODE
001600020619     F*
001700020619     F* N32     FILTER OUT ALL N-ACTIVE & SHOW TEXT FOR ALL SALESMAN
001800020619     F*  32     NO FILTER, ALL SALESMAN & SHOW TEXT FOR ACTIVE SALESMAN
001900001207     F*-------------------------------------------------------------------------
002000001207     ** MODIFICATION HISTORY                                              **
002100001207     ** ###  UUU  MMDDCCYY  X---->                                        **
002200020612     ** 000  SSK  06122002  ORIGINAL SOURCE                               **
002300030211001  ** 001  SSK  02102003  BREAK FILL20 INTO FOUR FIELDS                 **
002400001207     **                                                                   **
002500001207     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002600040708     FIQ130W1   IF   E           K DISK    RENAME(SMANR:BYLNAM) USROPN
002700040708     FIQ130W2   IF   E           K DISK    RENAME(SMANR:BYNMBR) USROPN
002800040708     FIQ130W5   IF   E           K DISK    RENAME(SMANR:BYFNAM) USROPN
002900040708     FIQR131D   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
003000001207   X***X
003100001207    ***
003200001207     D WSDS            DS
003300001207     D  FKEY                 369    369A
003400001207    ***
003500001207     D  F1             C                   CONST(X'31')
003600001207     D  F2             C                   CONST(X'32')
003700001207     D  F3             C                   CONST(X'33')
003800001207     D  F4             C                   CONST(X'34')
003900001207     D  F5             C                   CONST(X'35')
004000001207     D  F6             C                   CONST(X'36')
004100001207     D  F7             C                   CONST(X'37')
004200001207     D  F8             C                   CONST(X'38')
004300001207     D  F9             C                   CONST(X'39')
004400001207     D  F10            C                   CONST(X'3A')
004500001207     D  F11            C                   CONST(X'3B')
004600001207     D  F12            C                   CONST(X'3C')
004700001207     D  F13            C                   CONST(X'B1')
004800001207     D  F14            C                   CONST(X'B2')
004900001207     D  F15            C                   CONST(X'B3')
005000001207     D  F16            C                   CONST(X'B4')
005100001207     D  F17            C                   CONST(X'B5')
005200001207     D  F18            C                   CONST(X'B6')
005300001207     D  F19            C                   CONST(X'B7')
005400001207     D  F20            C                   CONST(X'B8')
005500001207     D  F21            C                   CONST(X'B9')
005600001207     D  F22            C                   CONST(X'BA')
005700001207     D  F23            C                   CONST(X'BB')
005800001207     D  F24            C                   CONST(X'BC')
005900020612    ***
006000020612     D @STEP           S              5A
006100020612     D P@3             S              3A
006200020612     D P@4             S              4A
006300020612     D RRT             S              4S 0
006400020612     D #CNTREC         S              4S 0
006500020613     D CMD             S            200A
006600020613     D LENGTH          S             15P 5
006700020613     D #LEN            S              3P 0
006800001207   X***X
006900001207     C* MAINLINE
007000001207    ***
007100020612     C                   DOU       @STEP = 'LEAVE'
007200020612     C     @STEP         CASEQ     'PREP1'       $PREP1
007300020612     C     @STEP         CASEQ     'STEP1'       $STEP1
007400020612     C                   ENDCS
007500020612     C                   ENDDO
007600020612     C                   EVAL      *INLR = *ON
007700020612   S***S
007800020612     C     *INZSR        BEGSR
007900020612    ***
008000020612     C     *ENTRY        PLIST
008100020612     C                   PARM                    P@3
008200020612     C                   PARM                    P@4
008300020612    ***
008400020612     C                   EVAL      @STEP = 'PREP1'
008500020612     C                   MOVE      *BLANKS       SKEY
008600020612     C                   MOVEL(P)  'A'           I_LNAM
008700020612    ***
008800020612     C                   EVAL      *IN30 = *OFF
008900020619     C                   EVAL      *IN31 = *OFF
009000020619     C                   EVAL      *IN32 = *ON
009100020612    ***
009200020612     C                   ENDSR
009300020612   S***S
009400020612     C     $PREP1        BEGSR
009500020612    ***
009600020612     C                   EXSR      $BUILDSFL
009700020612     C                   EVAL      @STEP = 'STEP1'
009800020617     C                   MOVE      *BLANKS       SKEY
009900020617     C                   MOVE      *BLANKS       I_LNAM
010000020613    ***
010100020613     C                   ENDSR
010200020613   S***S
010300020612     C     $BUILDSFL     BEGSR
010400020612    ***
010500020612     C                   MOVE      *ZEROS        RRT
010600020612     C                   MOVE      *ZEROS        #CNTREC
010700020612    ***
010800020612     C                   MOVEA     '011'         *IN(25)
010900020612     C                   WRITE     WDWCTL
011000020612     C                   MOVEA     '010'         *IN(25)
011100020612    ***
011200020619    1C                   SELECT
011300020619    1C                   WHEN      *IN30 = *ON AND *IN31 = *ON
011400020711     C                   EXSR      $SMANCODE
011500020619    1C                   WHEN      *IN30 = *ON AND *IN31 = *OFF
011600020619     C                   EXSR      $FRSTNAME
011700020619    1C                   WHEN      *IN30 = *OFF AND *IN31 = *OFF
011800020711     C                   EXSR      $LASTNAME
011900020619    1C                   ENDSL
012000020612    ***
012100020612     C                   IF        RRT > 6
012200020612     C                   EVAL      *IN91 = *ON
012300020612     C                   ENDIF
012400020619    ***
012500020619     C                   ENDSR
012600020619   S***S
012700020619     C     $LASTNAME     BEGSR
012800020619    ***
012900040708     C                   OPEN      IQ130W1
013000020619    ***
013100020619     C     I_LNAM        SETLL     BYLNAM
013200040708     C                   DOU       %EOF(IQ130W1) OR #CNTREC = 9000
013300020619     C                   READ      BYLNAM
013400040708     C                   IF        NOT %EOF(IQ130W1)
013500020619    ***
013600020619     C                   EXSR      $LOADSFL
013700020619    ***
013800020619     C                   ENDIF
013900020619     C                   ENDDO
014000020619    ***
014100040708     C                   CLOSE     IQ130W1
014200020612    ***
014300020612     C                   ENDSR
014400020612   S***S
014500020619     C     $FRSTNAME     BEGSR
014600020619    ***
014700040708     C                   OPEN      IQ130W5
014800020619    ***
014900020619     C     I_FNAM        SETLL     BYFNAM
015000040708     C                   DOU       %EOF(IQ130W5) OR #CNTREC = 9000
015100020619     C                   READ      BYFNAM
015200040708     C                   IF        NOT %EOF(IQ130W5)
015300020619    ***
015400020619     C                   EXSR      $LOADSFL
015500020619    ***
015600020619     C                   ENDIF
015700020619     C                   ENDDO
015800020619    ***
015900040708     C                   CLOSE     IQ130W5
016000020619    ***
016100020619     C                   ENDSR
016200020619   S***S
016300020619     C     $SMANCODE     BEGSR
016400020619    ***
016500040708     C                   OPEN      IQ130W2
016600020619    ***
016700020619     C     SKEY          SETLL     BYNMBR
016800040708     C                   DOU       %EOF(IQ130W2) OR #CNTREC = 9000
016900020619     C                   READ      BYNMBR
017000040708     C                   IF        NOT %EOF(IQ130W2)
017100020619    ***
017200020619     C                   EXSR      $LOADSFL
017300020619    ***
017400020619     C                   ENDIF
017500020619     C                   ENDDO
017600020619    ***
017700040708     C                   CLOSE     IQ130W2
017800020619    ***
017900020619     C                   ENDSR
018000020619   S***S
018100020612     C     $LOADSFL      BEGSR
018200020612    ***
018300020619     C                   IF        *IN32 = *OFF AND SENDDT > 0
018400020619     C                   LEAVESR
018500020619     C                   ENDIF
018600020619    ***
018700020612     C                   MOVE      *ON           *IN25
018800020612     C                   ADD       1             RRT
018900020612     C                   IF        RRT = 1
019000020612     C                   Z-ADD     RRT           SFLPOS
019100020612     C                   ENDIF
019200020612     C                   MOVE      *BLANKS       SEL
019300020612     C                   MOVEL(P)  SMANCD        SFCODE
019400020612     C                   MOVEL(P)  SLNAME        SFLNAM
019500020612     C                   MOVEL(P)  SFNAME        SFFNAM
019600020612     C                   MOVEL(P)  SMI           SFMIDI
019700020612     C                   MOVE      STYPE         SFSTYPE
019800020619     C                   MOVE      SMDLTD        SFDLTD
019900030211001  C                   IF        FUSE = 'N'
020000020612     C                   EVAL      SFINSR = 'SELF'
020100020612     C                   ELSE
020200020612     C                   EVAL      SFINSR = 'FULL'
020300020612     C                   ENDIF
020400020612     C                   WRITE     POPUP
020500020612     C                   ADD       1             #CNTREC
020600020612    ***
020700020612     C                   ENDSR
020800020612   S***S
020900020612     C     $STEP1        BEGSR
021000020612    ***
021100020612     C                   WRITE     JUNK
021200020612     C                   EXFMT     WDWCTL
021300020612    ***
021400020612     C                   IF        FKEY = F1
021500020612     C                   MOVE      '*LR'         P@3
021600020612     C                   MOVE      *BLANKS       P@4
021700020613     C                   EVAL      @STEP = 'LEAVE'
021800020612     C                   LEAVESR
021900020612     C                   ENDIF
022000020612    ***
022100020612     C                   IF        FKEY = F2
022200020612     C*
022300020619     C                   SELECT
022400020619     C                   WHEN      *IN30 = *OFF AND *IN31 = *OFF
022500020711     C                   MOVEA     '11'          *IN(30)
022600020619     C                   WHEN      *IN30 = *ON  AND *IN31 = *ON
022700020711     C                   MOVEA     '10'          *IN(30)
022800020619     C                   WHEN      *IN30 = *ON  AND *IN31 = *OFF
022900020711     C                   MOVEA     '00'          *IN(30)
023000020619     C                   ENDSL
023100020612     C*
023200020612     C                   EVAL      @STEP = 'PREP1'
023300020612     C                   LEAVESR
023400020612     C*
023500020612     C                   ENDIF
023600020619    ***
023700020619     C                   IF        FKEY = F4
023800020619     C*
023900020619     C                   IF        *IN32 = *ON
024000020619     C                   EVAL      *IN32 = *OFF
024100020619     C                   ELSE
024200020619     C                   EVAL      *IN32 = *ON
024300020619     C                   ENDIF
024400020619     C*
024500020619     C                   EVAL      SKEY = *BLANKS
024600020619     C                   EVAL      I_LNAM = *BLANKS
024700020619     C                   EVAL      I_FNAM = *BLANKS
024800020619     C                   EXSR      $BUILDSFL
024900020619     C*
025000020619     C                   LEAVESR
025100020619     C*
025200020619     C                   ENDIF
025300020612    ***
025400020619     C                   SELECT
025500020619     C*
025600020619     C                   WHEN      *IN30 = *OFF AND *IN31 = *OFF AND
025700020711     C                             I_LNAM <> *BLANKS
025800020619     C                   EXSR      $BUILDSFL
025900020711     C                   MOVE      *BLANKS       I_LNAM
026000020619     C                   LEAVESR
026100020619     C*
026200020619     C                   WHEN      *IN30 = *ON  AND *IN31 = *ON AND
026300020711     C                             SKEY <> *BLANKS
026400020619     C                   EXSR      $BUILDSFL
026500020711     C                   MOVE      *BLANKS       SKEY
026600020619     C                   LEAVESR
026700020619     C*
026800020619     C                   WHEN      *IN30 = *ON  AND *IN31 = *OFF AND
026900020619     C                             I_FNAM <> *BLANKS
027000020619     C                   EXSR      $BUILDSFL
027100020619     C                   MOVE      *BLANKS       I_FNAM
027200020619     C                   LEAVESR
027300020619     C*
027400020619     C                   ENDSL
027500020613    ***
027600020612     C                   EXSR      $CHKSEL
027700020612    ***
027800020612     C                   ENDSR
027900001207   S***S
028000001207     C     $CHKSEL       BEGSR
028100020612    ***
028200020619     C                   MOVE      *OFF          *IN99
028300020612    ***
028400020619     C                   DOU       *IN99 = *ON
028500020619     C                   READC     POPUP                                  99
028600020619     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
028700020612    ***
028800020619     C                   MOVE      *ON           *IN99
028900020612     C                   MOVEL(P)  SFCODE        P@3
029000020612     C                   MOVEL(P)  SFINSR        P@4
029100020612     C                   EVAL      @STEP = 'LEAVE'
029200020612    ***
029300001207     C                   ENDIF
029400001207     C                   ENDDO
029500001207     C*
029600001207     C                   ENDSR
029700001207   S***S
