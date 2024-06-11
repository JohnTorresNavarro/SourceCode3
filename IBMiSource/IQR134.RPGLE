000100020613     F*-------------------------------------------------------------------------
000200040708     F* IQR134     INNOVATIVE OUTSOURCING SOFTWARE 2002
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
001600020614     ** 000  SSK  06142002  ORIGINAL SOURCE                               **
001700040708     ** ***  SSK  01022004  COPY FM105R TO IQ                             **
001800020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900040708     FIQR134D   CF   E             WORKSTN INFDS(WSDS) SFILE(S03SFL:RR3)
002000020614     FAGENL1    IF   E           K DISK    PREFIX(I:1) RENAME(AGENR:AGL1)
002100020612   X***X
002200020612     D WSDS            DS
002300020612     D  FKEY                 369    369A
002400020612    ***
002500020612     D  F1             C                   CONST(X'31')
002600020612     D  F2             C                   CONST(X'32')
002700020612     D  F3             C                   CONST(X'33')
002800020612     D  F4             C                   CONST(X'34')
002900020612     D  F5             C                   CONST(X'35')
003000020612     D  F6             C                   CONST(X'36')
003100020612     D  F7             C                   CONST(X'37')
003200020612     D  F8             C                   CONST(X'38')
003300020612     D  F9             C                   CONST(X'39')
003400020612     D  F10            C                   CONST(X'3A')
003500020612     D  F11            C                   CONST(X'3B')
003600020612     D  F12            C                   CONST(X'3C')
003700020612     D  F13            C                   CONST(X'B1')
003800020612     D  F14            C                   CONST(X'B2')
003900020612     D  F15            C                   CONST(X'B3')
004000020612     D  F16            C                   CONST(X'B4')
004100020612     D  F17            C                   CONST(X'B5')
004200020612     D  F18            C                   CONST(X'B6')
004300020612     D  F19            C                   CONST(X'B7')
004400020612     D  F20            C                   CONST(X'B8')
004500020612     D  F21            C                   CONST(X'B9')
004600020612     D  F22            C                   CONST(X'BA')
004700020612     D  F23            C                   CONST(X'BB')
004800020612     D  F24            C                   CONST(X'BC')
004900020613    ***
005000020614     D #ISO            S               D   DATFMT(*ISO)
005100020614     D #USA            S               D   DATFMT(*USA)
005200020612     D @STEP           S              5A
005300020612     D P@3             S              3A
005400020614     D P@4             S              4A
005500020612    ***
005600020614     D @EMSG           S             70A
005700020612   X***X
005800020613    1C                   DOU       @STEP = 'LEAVE'
005900020613    2C     @STEP         CASEQ     'PREP1'       $PREP1
006000020613    2C     @STEP         CASEQ     'STEP1'       $STEP1
006100020613    2C                   ENDCS
006200020613    1C                   ENDDO
006300020612    ***
006400020612     C                   MOVE      *ON           *INLR
006500020612   S***S
006600020612     C     *INZSR        BEGSR
006700020612    ***
006800020612     C     *ENTRY        PLIST
006900020613     C                   PARM                    P@3
007000020614     C                   PARM                    P@4
007100020613    ***
007200020614     C                   EVAL      P@3 = '*LR'
007300020613     C                   EVAL      @STEP = 'PREP1'
007400020613    ***
007500020613     C                   ENDSR
007600020613   S***S
007700020613     C     $PREP1        BEGSR
007800020613    ***
007900020614     C                   MOVE      *ZEROS        RR3               4 0
008000020614     C                   MOVE      *ZEROS        #CNTREC           3 0
008100020614    ***
008200020614     C                   EXSR      $CLEAR
008300020614     C                   MOVEL(P)  'A'           C3NAME
008400020614     C                   MOVEL(P)  C3NAME        @HLNAME          40
008500020614    ***
008600020614     C                   SELECT
008700020614     C                   WHEN      P@4 = 'SELF'
008800020614     C                   EVAL      INSTYPE = 'SELF-FUNDED'
008900020614     C                   WHEN      P@4 = 'FULL'
009000020614     C                   EVAL      INSTYPE = 'FULLY-INSURED'
009100020614     C                   ENDSL
009200020614    ***
009300020614     C                   EXSR      $BUILD
009400020614     C                   MOVEL(P)  'STEP1'       @STEP
009500020614    ***
009600020614     C                   ENDSR
009700020614   S***S
009800020614     C     $STEP1        BEGSR
009900020614    ***
010000020614     C                   EXSR      $DISPLAY
010100020614    ***
010200020614    1C                   IF        FKEY = F1
010300020614     C                   MOVEL(P)  'LEAVE'       @STEP
010400020614     C                   LEAVESR
010500020614    1C                   ENDIF
010600020614    ***
010700020614    1C                   IF        @HLNAME <> C3NAME AND C3NAME <> *BLANKS
010800020614     C                   EXSR      $CLEAR
010900020614     C                   EXSR      $BUILD
011000020614     C                   MOVEL(P)  C3NAME        @HLNAME
011100020614     C                   LEAVESR
011200020614    1C                   ENDIF
011300020614    ***
011400020614    1C                   IF        *IN30 = *ON
011500020614     C                   MOVE      '0'           @SFLOOP
011600020614    2C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
011700020614     C                   READ      AGL1
011800020614    3C                   IF        NOT %EOF(AGENL1)
011900020614     C                   EXSR      $LOADSFL
012000020614    3C                   ENDIF
012100020614    2C                   ENDDO
012200020614    2C                   IF        %EOF(AGENL1)
012300020614     C                   MOVE      *OFF          *IN29
012400020614    2C                   ELSE
012500020614     C                   MOVE      *ON           *IN29
012600020614    2C                   ENDIF
012700020614     C                   LEAVESR
012800020614    1C                   ENDIF
012900020614    ***
013000020614     C                   EXSR      $CHKSELC
013100020614    ***
013200020614     C                   ENDSR
013300020614   S***S
013400020614     C* INITIALIZE THE SUBFILE
013500020614    ***
013600020614     C     $CLEAR        BEGSR
013700020614    ***
013800020614     C                   MOVEA     '011'         *IN(25)
013900020614     C                   WRITE     S03CTL
014000020614     C                   MOVEA     '010'         *IN(25)
014100020614     C                   Z-ADD     *ZERO         RR3
014200020614    ***
014300020614     C                   ENDSR
014400020614   S***S
014500020614     C* DISPLAY THE SCREEN
014600020614    ***
014700020614     C     $DISPLAY      BEGSR
014800020614    ***
014900020614     C                   WRITE     S03REC
015000020614     C                   EXFMT     S03CTL
015100020614    ***
015200020614     C                   ENDSR
015300020614    ***
015400020614   S***S
015500020614     C* BUILD SUBFILE CONTROL ROUTINE
015600020614    ***
015700020614     C     $BUILD        BEGSR
015800020614    ***
015900020614     C                   MOVE      *ZEROS        #CNTREC
016000020614     C                   MOVE      '0'           @1STLOOP          1
016100020614     C                   MOVEA     '00'          *IN(33)
016200020614     C                   MOVE      '0'           @SFLOOP           1
016300020614    ***
016400020614     C     C3NAME        SETLL     AGL1
016500020614     C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
016600020614     C                   READ      AGL1
016700020614     C                   IF        NOT %EOF(AGENL1)
016800020614     C                   EXSR      $LOADSFL
016900020614     C                   ENDIF
017000020614     C                   ENDDO
017100020614    ***
017200020614     C                   IF        %EOF(AGENL1)
017300020614     C                   MOVE      *OFF          *IN29
017400020614     C                   MOVE      *BLANKS       @LRNAME          40
017500020614     C                   ELSE
017600020614     C                   MOVE      *ON           *IN29
017700020614     C                   ENDIF
017800020614    ***
017900020614     C                   ENDSR
018000020614   S***S
018100020614     C* LOAD SUBFILE RECORDS
018200020614    ***
018300020614     C     $LOADSFL      BEGSR
018400020614    ***
018500020614     C                   MOVE      *ON           *IN25
018600020614     C                   MOVE      *BLANKS       SEL03
018700020614     C                   MOVEL(P)  IGCODE        S3CODE
018800020614     C                   MOVEL(P)  IGNAM1        S3NAM1
018900020614     C                   IF        IGTMDT = 0
019000020614     C                   MOVE      *ZEROS        S3TERM
019100020614     C                   ELSE
019200020614     C                   MOVE      IGTMDT        #ISO
019300020614     C                   MOVE      #ISO          #USA
019400020614     C                   MOVE      #USA          S3TERM
019500020614     C                   ENDIF
019600020614     C*
019700020614     C                   ADD       1             RR3
019800020614     C*
019900020614     C                   IF        @1STLOOP = '0'
020000020614     C                   Z-ADD     RR3           SFLPOS
020100020614     C                   MOVE      '1'           @1STLOOP
020200020614     C                   ENDIF
020300020614     C*
020400020614     C                   WRITE     S03SFL
020500020614     C*
020600020614     C                   ADD       1             #CNTREC
020700020614     C                   IF        #CNTREC = 14
020800020614     C                   MOVE      '1'           @SFLOOP
020900020614     C                   ENDIF
021000020614    ***
021100020614     C                   ENDSR
021200020614   S***S
021300020614     C* CHECK SUBFILE SELECTION
021400020614    ***
021500020614     C     $CHKSELC      BEGSR
021600020614    ***
021700020614     C                   MOVE      *OFF          *IN36
021800020614     C*
021900040708     C                   DOU       %EOF(IQR134D)
022000020614     C                   READC     S03SFL
022100040708     C                   IF        NOT %EOF(IQR134D) AND SEL03 <> *BLANKS
022200020614     C                   MOVEL(P)  S3CODE        P@3
022300020614     C                   MOVEL(P)  'LEAVE'       @STEP
022400020614     C                   LEAVESR
022500020614     C                   ENDIF
022600020614     C                   ENDDO
022700020614    ***
022800020614     C                   ENDSR
022900020614   S***S
023000020614     C* ROLL CONTROL
023100020614    ***
023200020614     C     $RELOAD       BEGSR
023300020614     C*
023400020614     C                   MOVEL(P)  C3NAME        @40              40
023500020614     C                   MOVEL(P)  @LRNAME       C3NAME
023600020614     C*
023700020614     C                   EXSR      $BUILD
023800020614     C*
023900020614     C                   MOVEL(P)  @40           C3NAME
024000020614    ***
024100020614     C                   ENDSR
