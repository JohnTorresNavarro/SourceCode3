000100020613     F*-------------------------------------------------------------------------
000200020613     F* FM101      INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020613     F*            FM10* SALESMAN MASTER APPLICATION
000400020613     F*            WRITTEN BY - S.S.K.
000500020613     F*            DATE - 06/02
000600020613     F*  DESCRIPTION - GROUPER CODE
000700020613     F*  INDICATOR USAGE:
000800020613     F*    25 = SFLDSP
000900020613     F*    26 = SFL DSP CTL
001000020613     F*    27 = SFL CLR
001100020613     F*
001200020613     F*-------------------------------------------------------------------------
001300020613     ** MODIFICATION HISTORY                                              **
001400020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001500020613     ** 000  SSK  06132002  ORIGINAL SOURCE                               **
001600030211001  ** 001  SSK  02102003  BREAK FILL20 INTO FOUR FIELDS                 **
001700020613     **                                                                   **
001800020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900020614     FFM101D    CF   E             WORKSTN INFDS(WSDS) SFILE(GBSSFL:RRT)
002000020614     FFM102W1   IF   E           K DISK    USROPN RENAME(SMANR:BYNAM)
002100020614     FFM102W2   IF   E           K DISK    USROPN RENAME(SMANR:BYNBR)
002200020613     FFM102W3   IF   E           K DISK    USROPN RENAME(SMANR:BYGRP)
002300020613     FFM102W4   IF   E           K DISK    USROPN RENAME(SMANR:BYTYP)
002400030325     F*M102W6   IF   E           K DISK    USROPN RENAME(SMANR:BYCOM)
002500020612   X***X
002600020612     D WSDS            DS
002700020612     D  FKEY                 369    369A
002800020612    ***
002900020612     D  F1             C                   CONST(X'31')
003000020612     D  F2             C                   CONST(X'32')
003100020612     D  F3             C                   CONST(X'33')
003200020612     D  F4             C                   CONST(X'34')
003300020612     D  F5             C                   CONST(X'35')
003400020612     D  F6             C                   CONST(X'36')
003500020612     D  F7             C                   CONST(X'37')
003600020612     D  F8             C                   CONST(X'38')
003700020612     D  F9             C                   CONST(X'39')
003800020612     D  F10            C                   CONST(X'3A')
003900020612     D  F11            C                   CONST(X'3B')
004000020612     D  F12            C                   CONST(X'3C')
004100020612     D  F13            C                   CONST(X'B1')
004200020612     D  F14            C                   CONST(X'B2')
004300020612     D  F15            C                   CONST(X'B3')
004400020612     D  F16            C                   CONST(X'B4')
004500020612     D  F17            C                   CONST(X'B5')
004600020612     D  F18            C                   CONST(X'B6')
004700020612     D  F19            C                   CONST(X'B7')
004800020612     D  F20            C                   CONST(X'B8')
004900020612     D  F21            C                   CONST(X'B9')
005000020612     D  F22            C                   CONST(X'BA')
005100020612     D  F23            C                   CONST(X'BB')
005200020612     D  F24            C                   CONST(X'BC')
005300020612    ***
005400020612     D @STEP           S              5A
005500020614     D KEY@STYP        S              3A
005600020614     D CMD             S            200A
005700020614     D LENGTH          S             15P 5
005800020614     D #LEN            S              3P 0
005900020612    ***
006000020614     D #CNTREC         S              4S 0
006100020614     D @EOF            S              1A
006200020614     D @273            S            273A
006300020612     D @EMSG           S             70A
006400020613     D #S              S              1S 0
006500020614     D FR@SMAN         S              3A
006600020614     D RRT             S              4S 0
006700020614     D TO@GRPR         S              5A
006800020612   X***X
006900020612     C                   DOU       @STEP = 'LEAVE'
007000020613     C     @STEP         CASEQ     'PREP1'       $PREP1
007100020613     C     @STEP         CASEQ     'STEP1'       $STEP1
007200020612     C                   ENDCS
007300020612     C                   ENDDO
007400020612    ***
007500020612     C                   MOVE      *ON           *INLR
007600020612   S***S
007700020612     C     *INZSR        BEGSR
007800020612    ***
007900020613     C                   EVAL      #S = 1
008000020613     C                   MOVE      *BLANKS       SCSMAN
008100020613     C                   EVAL      @STEP = 'PREP1'
008200020613    ***
008300020613     C                   ENDSR
008400020613   S***S
008500020613     C     $PREP1        BEGSR
008600020613    ***
008700020614     C                   EXSR      $RELOAD
008800020614    ***
008900020613     C                   EXSR      $OPENF
009000020613    ***
009100020613     C                   EXSR      $BUILD
009200020613    ***
009300020613     C                   EVAL      @STEP = 'STEP1'
009400020613    ***
009500020613     C                   EXSR      $CLOSEF
009600020614    ***
009700020614     C                   ENDSR
009800020614   S***S
009900020614     C     $RELOAD       BEGSR
010000020614    ***
010100020614     C                   CLEAR                   CMD
010200020614    ***
010300041104     C                   EVAL      CMD = 'CPYF FROMFILE(F.SMAN)' +
010400020614     C                             ' TOFILE(QTEMP/FM102WF) MBROPT(*REPLA' +
010500020614     C                             'CE)'
010600020614    ***
010700020614     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
010800020614     C                   Z-ADD     #LEN          LENGTH
010900020614     C                   CALL      'QCMDEXC'                                    EXECUTE
011000020614     C                   PARM                    CMD
011100020614     C                   PARM                    LENGTH
011200020613    ***
011300020613     C                   ENDSR
011400020613   S***S
011500020613     C     $OPENF        BEGSR
011600020613    ***
011700030325     C                   IF        #S < 1 OR #S > 4
011800020613     C                   Z-ADD     1             #S
011900020613     C                   ENDIF
012000020613    ***
012100020613     C                   SELECT
012200020613     C                   WHEN      #S = 1
012300020613     C                   OPEN      FM102W2
012400020613     C                   EVAL      *IN41 = *ON
012500020613     C                   WHEN      #S = 2
012600020613     C                   OPEN      FM102W1
012700020613     C                   EVAL      *IN42 = *ON
012800020613     C                   WHEN      #S = 3
012900020613     C                   OPEN      FM102W3
013000020613     C                   EVAL      *IN43 = *ON
013100020613     C                   WHEN      #S = 4
013200020613     C                   OPEN      FM102W4
013300020613     C                   EVAL      *IN44 = *ON
013400030325     C*                  WHEN      #S = 5
013500030325     C*                  OPEN      FM102W6
013600030325     C*                  EVAL      *IN45 = *ON
013700020613     C                   ENDSL
013800020613    ***
013900020613     C                   ENDSR
014000020613   S***S
014100020613     C     $BUILD        BEGSR
014200020613    ***
014300020613     C                   MOVE      *ZEROS        RRT
014400020613     C                   MOVE      *ZEROS        #CNTREC
014500020613    ***
014600020613     C                   MOVEA     '011'         *IN(25)
014700020613     C                   WRITE     GBSCTL
014800020613     C                   MOVEA     '010'         *IN(25)
014900020613    ***
015000020613     C                   SELECT
015100020613     C                   WHEN      #S = 1
015200020613     C     SCSMAN        SETLL     BYNBR
015300020613     C                   WHEN      #S = 2
015400020613     C     SCSLNAME      SETLL     BYNAM
015500020613     C                   WHEN      #S = 3
015600030211     C     SCSGRP        SETLL     BYGRP
015700020613     C                   WHEN      #S = 4
015800020614     C                   EVAL      KEY@STYP = 'F' + SCSTYPE
015900020614     C     KEY@STYP      SETLL     BYTYP
016000030325     C*                  WHEN      #S = 5
016100030325     C*    SCSAGE        SETLL     BYCOM
016200020613     C                   ENDSL
016300020613    ***
016400020613     C                   EVAL      @EOF = 'N'
016500020613     C                   DOU       @EOF = 'Y' OR #CNTREC = 9000
016600020613     C                   EXSR      $LOAD
016700020613     C                   ENDDO
016800020613    ***
016900020613     C                   ENDSR
017000020613   S***S
017100020613     C     $LOAD         BEGSR
017200020613    ***
017300020613     C                   SELECT
017400020613     C                   WHEN      #S = 1
017500020613     C                   READ      BYNBR
017600020613     C                   IF        %EOF(FM102W2)
017700020613     C                   EVAL      @EOF = 'Y'
017800020613     C                   ENDIF
017900020613     C                   WHEN      #S = 2
018000020613     C                   READ      BYNAM
018100020613     C                   IF        %EOF(FM102W1)
018200020613     C                   EVAL      @EOF = 'Y'
018300020613     C                   ENDIF
018400020613     C                   WHEN      #S = 3
018500020613     C                   READ      BYGRP
018600020613     C                   IF        %EOF(FM102W3)
018700020613     C                   EVAL      @EOF = 'Y'
018800020613     C                   ENDIF
018900020613     C                   WHEN      #S = 4
019000020613     C                   READ      BYTYP
019100020613     C                   IF        %EOF(FM102W4)
019200020613     C                   EVAL      @EOF = 'Y'
019300020613     C                   ENDIF
019400030325     C*                  WHEN      #S = 5
019500030325     C*                  READ      BYCOM
019600030325     C*                  IF        %EOF(FM102W6)
019700030325     C*                  EVAL      @EOF = 'Y'
019800030325     C*                  ENDIF
019900020613     C                   ENDSL
020000020612    ***
020100020613     C                   IF        @EOF = 'Y'
020200020613     C                   LEAVESR
020300020613     C                   ENDIF
020400020613    ***
020500020613     C                   MOVE      *ON           *IN25
020600020613     C                   ADD       1             RRT
020700020613     C                   IF        RRT = 1
020800020613     C                   Z-ADD     RRT           SFLPOS
020900020613     C                   ENDIF
021000020613    ***
021100020613     C                   MOVE      *BLANKS       SEL
021200071004     ******************************
021300071004001  C*******************IF********FUSE = 'N'
021400071004     C*******************EVAL******ZSELFULL = 'SELF'
021500071004     C*******************ELSE******
021600071004     C*******************EVAL******ZSELFULL = 'FULL'
021700071004     C*******************ENDIF*****
021800030211     C                   MOVEL     SGRP          ZSGRP
021900020613     C                   EVAL      ZSNAME = %TRIM(SFNAME) + ' ' +
022000020613     C                             %TRIM(SMI) + ' ' + %TRIM(SLNAME)
022100020613     C                   MOVEL     SMANCD        ZSMANCD
022200020613     C                   MOVE      STYPE         ZSTYPE
022300020613     C                   MOVE      SMDLTD        ZDLTD
022400020613    ***
022500020613     C                   WRITE     GBSSFL
022600020613     C                   ADD       1             #CNTREC
022700020613    ***
022800020612     C                   ENDSR
022900020612   S***S
023000020613     C     $CLOSEF       BEGSR
023100020613    ***
023200020613     C                   SELECT
023300020613     C                   WHEN      #S = 1
023400020613     C                   CLOSE     FM102W2
023500020613     C                   MOVE      *BLANKS       SCSMAN
023600020613     C                   WHEN      #S = 2
023700020613     C                   CLOSE     FM102W1
023800020613     C                   MOVE      *BLANKS       SCSLNAME
023900020613     C                   WHEN      #S = 3
024000020613     C                   CLOSE     FM102W3
024100030211     C                   MOVE      *BLANKS       SCSGRP
024200020613     C                   WHEN      #S = 4
024300020613     C                   MOVE      *BLANKS       SCSTYPE
024400020613     C                   CLOSE     FM102W4
024500030325     C*                  WHEN      #S = 5
024600030325     C*                  MOVE      *BLANKS       SCSAGE
024700030325     C*                  CLOSE     FM102W6
024800020613     C                   ENDSL
024900020613    ***
025000020613     C                   ENDSR
025100020613   S***S
025200020612     C     $STEP1        BEGSR
025300020612    ***
025400020612     C                   MOVEL     @EMSG         EMSG
025500020614     C                   WRITE     GBSREC
025600020614     C                   EXFMT     GBSCTL
025700020612     C                   MOVE      *BLANKS       EMSG
025800020612     C                   MOVE      *BLANKS       @EMSG
025900020612    ***
026000020612     C                   IF        FKEY = F7
026100020612     C                   EVAL      @STEP = 'LEAVE'
026200020612     C                   LEAVESR
026300020612     C                   ENDIF
026400020612    ***
026500020613     C                   IF        FKEY = F2
026600020613     C                   EXSR      $F2
026700020613     C                   LEAVESR
026800020613     C                   ENDIF
026900020613    ***
027000020613     C                   IF        (*IN41 = *ON AND SCSMAN <> *BLANKS) OR
027100020613     C                             (*IN42 = *ON AND SCSLNAME <> *BLANKS) OR
027200030211     C                             (*IN43 = *ON AND SCSGRP <> *BLANKS) OR
027300030325     C                             (*IN44 = *ON AND SCSTYPE <> *BLANKS)
027400030325     C*                            (*IN45 = *ON AND SCSAGE <> *BLANKS)
027500020613     C                   EVAL      @STEP = 'PREP1'
027600020613     C                   LEAVESR
027700020613     C                   ENDIF
027800020613    ***
027900020613     C                   EXSR      $CHKSELC
028000020613    ***
028100020613     C                   ENDSR
028200020613   S***S
028300020613     C     $F2           BEGSR
028400020613    ***
028500020613     C                   ADD       1             #S
028600020613    ***
028700030325     C                   IF        #S < 1 OR #S > 4
028800020613     C                   Z-ADD     1             #S
028900020613     C                   ENDIF
029000020613    ***
029100020613     C                   SELECT
029200020613     C                   WHEN      #S = 1
029300020628     C                   MOVEA     '10000'       *IN(41)
029400020613     C                   WHEN      #S = 2
029500020628     C                   MOVEA     '01000'       *IN(41)
029600020613     C                   WHEN      #S = 3
029700020628     C                   MOVEA     '00100'       *IN(41)
029800020613     C                   WHEN      #S = 4
029900020628     C                   MOVEA     '00010'       *IN(41)
030000030325     C*                  WHEN      #S = 5
030100030325     C*                  MOVEA     '00001'       *IN(41)
030200020613     C                   ENDSL
030300020613    ***
030400020613     C                   ENDSR
030500020613   S***S
030600020613     C     $CHKSELC      BEGSR
030700020613    ***
030800020613     C                   MOVE      *OFF          *IN33
030900020613     C                   EVAL      TO@GRPR = *BLANKS
031000020613     C                   EVAL      FR@SMAN = *BLANKS
031100020613    ***
031200020614    1C                   DOU       *IN33 = *ON OR (FR@SMAN <> *BLANKS AND
031300020614     C                             TO@GRPR <> *BLANKS)
031400020613     C                   READC     GBSSFL                                 33
031500020614    2C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
031600020613    ***
031700020614    3C                   IF        SEL = 'T' AND TO@GRPR = *BLANKS
031800030211     C                   MOVEL     ZSGRP         TO@GRPR
031900030211     C                   MOVE      ZSGRP         CWTGRPR
032000020614    3C                   ENDIF
032100020614    3C                   IF        SEL = 'C' AND FR@SMAN = *BLANKS
032200020613     C                   MOVEL     ZSMANCD       FR@SMAN
032300020614     C                   MOVEL     ZSMANCD       CWSMAN
032400020614     C                   MOVEL     ZSNAME        CWNAME
032500030211     C                   MOVE      ZSGRP         CWFGRPR
032600071004    4C*******************IF********ZSELFULL = 'SELF'
032700071004     C*******************MOVE*******ON           *IN50
032800071004    4C*******************ELSE******
032900020614     C                   MOVE      *OFF          *IN50
033000071004    4C*******************ENDIF*****
033100020614    3C                   ENDIF
033200020613    ***
033300020614    2C                   ENDIF
033400020614    1C                   ENDDO
033500020614    ***
033600020614    1C                   IF        FR@SMAN <> *BLANKS
033700020613    ***
033800020614     C                   EXFMT     CHGWDW
033900020614    2C                   IF        FKEY = F1
034000020614     C                   CLEAR                   FKEY
034100020614     C                   LEAVESR
034200020614    2C                   ENDIF
034300020614    ***
034400020614    2C                   IF        CWTGRPR = 0
034500020614     C                   EVAL      @EMSG = 'MISSING TO GROUPER CODE, CHAN' +
034600020614     C                             'GE CANCELED.'
034700020614     C                   LEAVESR
034800020614    2C                   ENDIF
034900020614    ***
035000020614     C                   CLEAR                   @273
035100020614     C                   EVAL      %SUBST(@273:1:3) = CWSMAN
035200020614     C                   EVAL      %SUBST(@273:111:5) = %EDITC(CWTGRPR:'X')
035300071004     C*******************IF*********IN50 = *ON
035400071004     C*******************EVAL******%SUBST(@273:96:4) = 'SELF'
035500071004     C*******************ELSE******
035600020614     C                   EVAL      %SUBST(@273:96:4) = 'FULL'
035700071004     C*******************ENDIF*****
035800020614     C                   EVAL      %SUBST(@273:100:2) = 'CG'
035900020614     C                   CALL      'FM100CLU'
036000020613     C                   PARM                    @273
036100020614     C                   EVAL      @STEP = 'PREP1'
036200020614    ***
036300020614    1C                   ENDIF
036400020613    ***
036500020613     C                   ENDSR
036600020613   S***S
