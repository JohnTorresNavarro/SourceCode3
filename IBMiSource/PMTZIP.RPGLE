000100020926     FNYZIPXF0  IF A E           K DISK
000200020926     FNYSUASM0  IF   E           K DISK
000300021003     FPMTZIPD   CF   E             WORKSTN INFDS(WSDS)
000400020926   X***X
000500020926     D WSDS            DS
000600020926     D  FKEY                 369    369A
000700020926    ***
000800020926     D  F1             C                   CONST(X'31')
000900020926     D  F2             C                   CONST(X'32')
001000020926     D  F3             C                   CONST(X'33')
001100020926     D  F4             C                   CONST(X'34')
001200020926     D  F5             C                   CONST(X'35')
001300020926     D  F6             C                   CONST(X'36')
001400020926     D  F7             C                   CONST(X'37')
001500020926     D  F8             C                   CONST(X'38')
001600020926     D  F9             C                   CONST(X'39')
001700020926     D  F10            C                   CONST(X'3A')
001800020926     D  F11            C                   CONST(X'3B')
001900020926     D  F12            C                   CONST(X'3C')
002000020926     D  F13            C                   CONST(X'B1')
002100020926     D  F14            C                   CONST(X'B2')
002200020926     D  F15            C                   CONST(X'B3')
002300020926     D  F16            C                   CONST(X'B4')
002400020926     D  F17            C                   CONST(X'B5')
002500020926     D  F18            C                   CONST(X'B6')
002600020926     D  F19            C                   CONST(X'B7')
002700020926     D  F20            C                   CONST(X'B8')
002800020926     D  F21            C                   CONST(X'B9')
002900020926     D  F22            C                   CONST(X'BA')
003000020926     D  F23            C                   CONST(X'BB')
003100020926     D  F24            C                   CONST(X'BC')
003200020926    ***
003300020927     D LDPARM        E DS                  EXTNAME(NYZIPXF0)
003400020927     D @STEP           S              5A
003500020926     D @E              S             70A
003600020926     D @23             S             23A
003700020926     D #A              S              6S 0
003800020926   X***X
003900020926     C                   EVAL      @STEP = 'PREP1'
004000020926     C                   EVAL      @E = *BLANKS
004100020927     C     *ENTRY        PLIST
004200020927     C                   PARM                    @REC              8
004300020926    ***
004400020926     C                   DOU       @STEP = 'LEAVE'
004500020926     C     @STEP         CASEQ     'PREP1'       $PREP1
004600020926     C     @STEP         CASEQ     'STEP1'       $STEP1
004700020926     C     @STEP         CASEQ     'STEP2'       $STEP2
004800020926     C     @STEP         CASEQ     'STEP3'       $STEP3
004900020926     C                   ENDCS
005000020927     C                   ENDDO
005100020926    ***
005200020927     C                   EVAL      @REC = LDPARM
005300020926     C                   EVAL      *INLR = *ON
005400020927     C                   RETURN
005500020926   S***S
005600020926     C     $PREP1        BEGSR
005700020926    ***
005800020926     C                   EVAL      S_ZIP = *BLANKS
005900020926     C                   EVAL      F_ZIP = *ZEROS
006000020926     C                   EVAL      T_ZIP = *ZEROS
006100020926     C                   EVAL      I_REGION = *BLANKS
006200020926     C                   EVAL      WWDESC = *BLANKS
006300020926     C                   EVAL      @STEP = 'STEP1'
006400020926    ***
006500020926     C                   ENDSR
006600020926   S***S
006700020926     C     $STEP1        BEGSR
006800020926    ***
006900020926     C                   MOVEL(P)  @E            ERRMSG
007000020926     C                   EXFMT     SCREEN
007100020926     C                   EVAL      @E = *BLANKS
007200020926    ***
007300020926     C                   IF        FKEY = F12
007400020926     C                   EVAL      @STEP = 'LEAVE'
007500020926     C                   LEAVESR
007600020926     C                   ENDIF
007700020926    ***
007800020926     C                   IF        FKEY = F4
007900020926     C                   EVAL      @23 = *BLANKS
008000020927 001?C                   Call      'SLCSUA  '                                   CALL SELECT PROGRAM
008100020926 001?C                   Parm                    WWRQS             8            REQUEST
008200020926 001?C                   Parm                    WWRTN             8            RETURN CODE
008300020926 001?C                   Parm                    WUPGM            10            PROGRAM
008400020926 001?C                   Parm                    @23                            RECORD DS
008500020926     C                   IF        WWRTN <> 'CANCEL '
008600020926     C                   EVAL      I_REGION = %SUBST(@23:1:3)
008700020927     C                   EVAL      WWDESC = %SUBST(@23:4:20)
008800020926     C                   ENDIF
008900020926     C                   LEAVESR
009000020926     C                   ENDIF
009100020926    ***
009200020926     C                   EXSR      $VALIDATE
009300020926    ***
009400020926     C                   ENDSR
009500020926   S***S
009600020926     C     $VALIDATE     BEGSR
009700020926    ***
009800020926     C                   IF        S_ZIP = *BLANKS AND F_ZIP = 0 AND
009900020926     C                             T_ZIP = 0
010000020926     C                   EVAL      @E = 'MAKE A SELECTION ZIP CODE(S) TO +
010100020926     C                             ADD.'
010200020926     C                   LEAVESR
010300020926     C                   ENDIF
010400020926    ***
010500020926     C                   IF        S_ZIP <> *BLANKS AND F_ZIP <> 0 AND
010600020926     C                             T_ZIP <> 0
010700020926     C                   EVAL      @E = 'CHOOSE SINGLE ZIP OR RANGE, NOT +
010800020926     C                             BOTH.'
010900020926     C                   LEAVESR
011000020926     C                   ENDIF
011100020926    ***
011200020926     C     S_ZIP         CHAIN(N)  RNYZIPXF
011300020926     C                   IF        %FOUND(NYZIPXF0)
011400020926     C                   EVAL      @E = 'ZIP CODE ALREADY SETUP, CHOOSE A +
011500020926     C                             DIFFERENT ZIP TO ADD.'
011600020926     C                   LEAVESR
011700020926     C                   ENDIF
011800020926    ***
011900020926     C                   IF        F_ZIP > T_ZIP
012000020926     C                   EVAL      @E = 'FROM ZIP MUST BE < TO ZIP'
012100020926     C                   LEAVESR
012200020926     C                   ENDIF
012300020927    ***
012400020927     C                   IF        I_REGION = *BLANKS
012500020927     C                   EVAL      @E = 'REGION CANNOT BE BLANK.'
012600020927     C                   LEAVESR
012700020927     C                   ENDIF
012800020927    ***
012900020927     C     I_REGION      CHAIN     RNYSUASM
013000020927     C                   IF        %FOUND(NYSUASM0)
013100020927     C                   EVAL      WWDESC = SURGDESC
013200020927     C                   ELSE
013300020927     C                   EVAL      @E = 'REGION CANNOT BE BLANK.'
013400020927     C                   LEAVESR
013500020927     C                   ENDIF
013600020926    ***
013700020926     C                   IF        S_ZIP = *BLANKS
013800020926     C                   EVAL      @STEP = 'STEP3'
013900020926     C                   ELSE
014000020926     C                   EVAL      @STEP = 'STEP2'
014100020926     C                   ENDIF
014200020926    ***
014300020926     C                   ENDSR
014400020926   S***S
014500020926     C     $STEP2        BEGSR
014600020926    ***
014700020927     C                   CLEAR                   RNYZIPXF
014800020926     C                   EVAL      ZXZIPCOD = S_ZIP
014900020926     C                   EVAL      ZXREGION = I_REGION
015000020926     C                   EVAL      @E = 'ZIP CODE/REGION ' + ZXZIPCOD +
015100020926     C                             '/' + ZXREGION + ' HAS BEEN ADDED.'
015200020926     C                   EVAL      @STEP = 'PREP1'
015300020926     C                   WRITE     RNYZIPXF
015400020926     C                   EVAL      @STEP = 'PREP1'
015500020926    ***
015600020926     C                   ENDSR
015700020926   S***S
015800020926     C     $STEP3        BEGSR
015900020926    ***
016000020927     c                   EVAL      #A = 0
016100020926     C                   DOW       F_ZIP <= T_ZIP
016200020926    ***
016300020926     C                   MOVE      F_ZIP         S_ZIP
016400020926     C     S_ZIP         CHAIN(N)  RNYZIPXF
016500020926     C                   IF        NOT %FOUND(NYZIPXF0)
016600020926     C                   EXSR      $STEP2
016700020926     C                   ADD       1             #A
016800020926     C                   EVAL      @E = *BLANKS
016900020926     C                   ENDIF
017000020926    ***
017100020926     C                   ADD       1             F_ZIP
017200020926     C                   ENDDO
017300020926    ***
017400020927     C                   EVAL      @E = %TRIM(%EDITC(#A:'Z')) + ' ZIP ' +
017500020926     C                             'RECORDS WRITTEN.'
017600020926    ***
017700020926     C                   ENDSR
017800020926   S***S
