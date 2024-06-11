000100020613     F*-------------------------------------------------------------------------
000200040708     F* IQR152     GBS/IO SOFTWARE 2003
000300030109     F*            FM46* SUPER AGENCY ENCHANCMENT PROJECT
000400020613     F*            WRITTEN BY - S.S.K.
000500030109     F*            DATE - 01/03
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
001600030109     ** 000  SSK  01092003  ORIGINAL SOURCE                               **
001700040708     ** ***  SSK  01022004  COPY FM462 TO IQ                              **
001800020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900040708     FIQR152D   CF   E             WORKSTN INFDS(WSDS)
002000030109     FSUPRAGCY  IF   E           K DISK
002100020612   X***X
002200020612     D WSDS            DS
002300020612     D  FKEY                 369    369A
002400030109    *D @IM             S              1A
002500030109    *D @IMHOLD         S              1A
002600020612    ***
002700020612     D  F1             C                   CONST(X'31')
002800020612     D  F2             C                   CONST(X'32')
002900020612     D  F3             C                   CONST(X'33')
003000020612     D  F4             C                   CONST(X'34')
003100020612     D  F5             C                   CONST(X'35')
003200020612     D  F6             C                   CONST(X'36')
003300020612     D  F7             C                   CONST(X'37')
003400020612     D  F8             C                   CONST(X'38')
003500020612     D  F9             C                   CONST(X'39')
003600020612     D  F10            C                   CONST(X'3A')
003700020612     D  F11            C                   CONST(X'3B')
003800020612     D  F12            C                   CONST(X'3C')
003900020612     D  F13            C                   CONST(X'B1')
004000020612     D  F14            C                   CONST(X'B2')
004100020612     D  F15            C                   CONST(X'B3')
004200020612     D  F16            C                   CONST(X'B4')
004300020612     D  F17            C                   CONST(X'B5')
004400020612     D  F18            C                   CONST(X'B6')
004500020612     D  F19            C                   CONST(X'B7')
004600020612     D  F20            C                   CONST(X'B8')
004700020612     D  F21            C                   CONST(X'B9')
004800020612     D  F22            C                   CONST(X'BA')
004900020612     D  F23            C                   CONST(X'BB')
005000020612     D  F24            C                   CONST(X'BC')
005100020612    ***
005200020612     D @STEP           S              5A
005300030109    *D P@1             S              1A
005400030429    *D P@3             S              3A
005500030109    *D @VP             S              1A
005600020612    ***
005700020612     D @EMSG           S             70A
005800020612   X***X
005900020613     C                   IF        @IM = 'I'
006000020613     C                   EVAL      *IN25 = *ON
006100020613     C                   ELSE
006200020613     C                   EVAL      *IN25 = *OFF
006300020613     C                   ENDIF
006400020613    ***
006500020612     C                   DOU       @STEP = 'LEAVE'
006600020612     C     @STEP         CASEQ     'STEP1'       $STEP1
006700020612     C                   ENDCS
006800020612     C                   ENDDO
006900020612    ***
007000020612     C                   MOVE      *ON           *INLR
007100020612   S***S
007200020612     C     *INZSR        BEGSR
007300020612    ***
007400020612     C     *ENTRY        PLIST
007500020613     C                   PARM                    P@1
007600030109    ***
007700020617     C                   EVAL      @IM     = P@1
007800020617     C                   EVAL      @IMHOLD = P@1
007900020617     C                   EVAL      @STEP   = 'STEP1'
008000030109     C                   EVAL      I_SUPER = *BLANKS
008100020612    ***
008200020612     C                   ENDSR
008300020612   S***S
008400020612     C     $STEP1        BEGSR
008500020612    ***
008600020612     C                   MOVEL     @EMSG         EMSG
008700030109     C                   EXFMT     IO01
008800020612     C                   MOVE      *BLANKS       EMSG
008900020612     C                   MOVE      *BLANKS       @EMSG
009000030429     C                   MOVE      *BLANKS       p@3
009100020612    ***
009200020612     C                   IF        FKEY = F7
009300020612     C                   EVAL      @STEP = 'LEAVE'
009400020612     C                   LEAVESR
009500020612     C                   ENDIF
009600030519    ***
009700030519     C                   IF        FKEY = F11
009800030519    * *
009900030519     C                   EXSR      $VALID
010000030519    * *
010100030519     C                   IF        @VP = 'Y'
010200030519     C                   EVAL      p@3 = I_SUPER
010300040708     C                   CALL      'IQC153'
010400030519     C                   PARM                    P@3
010500030519     C                   LEAVESR
010600030519     C                   ENDIF
010700030519    * *
010800030519     C                   ENDIF
010900020612    ***
011000020612     C                   IF        FKEY = F4
011100040708     C                   CALL      'IQC151'
011200030429     C                   PARM                    P@3
011300030429     C                   IF        P@3 <> '*LR'
011400030429     C                   EVAL      I_SUPER = P@3
011500020612     C                   ENDIF
011600020612     C                   LEAVESR
011700020612     C                   ENDIF
011800020612    ***
011900020612     C                   EXSR      $VALID
012000020612    ***
012100020613     C                   IF        @VP = 'Y'
012200020612     C*
012300030429     C                   EVAL      p@3 = I_SUPER
012400020614     C                   EVAL      @IMHOLD = P@1
012500020617     C*
012600040708     C                   CALL      'IQC150'
012700030429     C                   PARM                    p@3
012800020613     C                   PARM                    P@1
012900020612     C*
013000020614     C                   IF        P@1 = 'X'
013100020612     C                   EVAL      @STEP = 'LEAVE'
013200020612     C                   LEAVESR
013300020612     C                   ELSE
013400020614     C                   EVAL      P@1 = @IMHOLD
013500030109     C                   EVAL      I_SUPER = *BLANKS
013600020612     C                   ENDIF
013700020612     C*
013800020612     C                   ENDIF
013900020613    ***
014000020613     C                   ENDSR
014100020613   S***S
014200020612     C     $VALID        BEGSR
014300020612    ***
014400020612     C                   EVAL      @VP = 'N'
014500020612    ***
014600030109     C                   IF        I_SUPER = *BLANKS
014700030109     C                   EVAL      @EMSG = 'PLEASE SELECT A SUPER AGENCY.'
014800020612     C                   LEAVESR
014900020612     C                   ENDIF
015000030109    ***
015100030109     C     I_SUPER       CHAIN(N)  SAF
015200030109     C                   IF        NOT %FOUND(SUPRAGCY)
015300030109     C                   EVAL      @EMSG = 'UNKNOWN SUPER AGENCY CODE.'
015400030109     C                   LEAVESR
015500030109     C                   ENDIF
015600020614    ***
015700020612     C                   EVAL      @VP = 'Y'
015800020612    ***
015900020612     C                   ENDSR
016000020612   S***S
