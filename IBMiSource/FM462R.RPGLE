000100020613     F*-------------------------------------------------------------------------
000200030109     F* FM462      GBS/IO SOFTWARE 2003
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
001700020613     **                                                                   **
001800020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900030109     FFM462D    CF   E             WORKSTN INFDS(WSDS)
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
007700030109     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
007800030109     C                   IN        @DTA50
007900030109    ***
008000030109     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
008100020613    ***
008200020617     C                   EVAL      @IM     = P@1
008300020617     C                   EVAL      @IMHOLD = P@1
008400020617     C                   EVAL      @STEP   = 'STEP1'
008500030109     C                   EVAL      I_SUPER = *BLANKS
008600020612    ***
008700020612     C                   ENDSR
008800020612   S***S
008900020612     C     $STEP1        BEGSR
009000020612    ***
009100020612     C                   MOVEL     @EMSG         EMSG
009200030109     C                   EXFMT     IO01
009300020612     C                   MOVE      *BLANKS       EMSG
009400020612     C                   MOVE      *BLANKS       @EMSG
009500030429     C                   MOVE      *BLANKS       p@3
009600020612    ***
009700020612     C                   IF        FKEY = F7
009800020612     C                   EVAL      @STEP = 'LEAVE'
009900020612     C                   LEAVESR
010000020612     C                   ENDIF
010100101025    ***
010200101025     C                   IF        I_SUPER = '***'
010300101025     C                   CALL      'KTHMNUC'
010400101025     C                   LEAVESR
010500101025     C                   ENDIF
010600030519    ***
010700090113     C                   IF        FKEY = F15
010800090113     C                   CALL      'WRKIRMCL'
010900090113     C                   LEAVESR
011000090113     C                   ENDIF
011100090113    ***
011200090318     C                   IF        FKEY = F8
011300090318     C                   CALL      'WRKLKICL'
011400090318     C                   LEAVESR
011500090318     C                   ENDIF
011600090318    ***
011700030519     C                   IF        FKEY = F11
011800030519    * *
011900030519     C                   EXSR      $VALID
012000030519    * *
012100030519     C                   IF        @VP = 'Y'
012200030519     C                   EVAL      p@3 = I_SUPER
012300030519     C                   CALL      'FM463CL'
012400030519     C                   PARM                    P@3
012500030519     C                   LEAVESR
012600030519     C                   ENDIF
012700030519    * *
012800030519     C                   ENDIF
012900020612    ***
013000020612     C                   IF        FKEY = F4
013100030109     C                   CALL      'FM461CL'
013200030429     C                   PARM                    P@3
013300030429     C                   IF        P@3 <> '*LR'
013400030429     C                   EVAL      I_SUPER = P@3
013500020612     C                   ENDIF
013600020612     C                   LEAVESR
013700020612     C                   ENDIF
013800020612    ***
013900020613     C                   IF        FKEY = F6 AND *IN25 = *OFF
014000020613     C                   EXSR      $F6
014100030110     C                   MOVE      *BLANKS       EMSG
014200030110     C                   MOVE      *BLANKS       @EMSG
014300020613     C                   LEAVESR
014400020613     C                   ENDIF
014500020729    ***
014600020612     C                   EXSR      $VALID
014700020612    ***
014800020613     C                   IF        @VP = 'Y'
014900020612     C*
015000030429     C                   EVAL      p@3 = I_SUPER
015100020614     C                   EVAL      @IMHOLD = P@1
015200020617     C*
015300030109     C                   CALL      'FM460CL'
015400030429     C                   PARM                    p@3
015500020613     C                   PARM                    P@1
015600020612     C*
015700020614     C                   IF        P@1 = 'X'
015800020612     C                   EVAL      @STEP = 'LEAVE'
015900020612     C                   LEAVESR
016000020612     C                   ELSE
016100020614     C                   EVAL      P@1 = @IMHOLD
016200030109     C                   EVAL      I_SUPER = *BLANKS
016300020612     C                   ENDIF
016400020612     C*
016500020612     C                   ENDIF
016600020613    ***
016700020613     C                   ENDSR
016800020613   S***S
016900020613     C     $F6           BEGSR
017000020613    ***
017100020613     C                   EXSR      $VALID
017200020613    ***
017300030109     C                   IF        @VP = 'Y'
017400030109     C                   EVAL      @EMSG = 'ATTEMPT TO ADD EXISTING SUPER' +
017500030109     C                             ' AGENCY CODE. ADD DENIED.'
017600030109     C                   LEAVESR
017700030109     C                   ENDIF
017800030109    ***
017900030109     C                   IF        @VP = 'N' AND I_SUPER = *BLANKS
018000030109     C                   EVAL      @EMSG = 'A SUPER AGENCY CODE IS REQUIR' +
018100030109     C                             'ED PRIOR TO F6. ADD DENIED.'
018200030109     C                   LEAVESR
018300030109     C                   ENDIF
018400020613    ***
018500030429     C                   EVAL      p@3 = I_SUPER
018600030109     C                   EVAL      P@1 = 'A'
018700030109     C                   CALL      'FM460CL'
018800030429     C                   PARM                    p@3
018900030109     C                   PARM                    P@1
019000020617    ***
019100020617     C                   IF        P@1 = 'X'
019200020617     C                   EVAL      @STEP = 'LEAVE'
019300020617     C                   LEAVESR
019400020617     C                   ELSE
019500020617     C                   EVAL      P@1 = @IMHOLD
019600030109     C                   EVAL      I_SUPER = *BLANKS
019700020617     C                   ENDIF
019800020612    ***
019900020612     C                   ENDSR
020000020612   S***S
020100020612     C     $VALID        BEGSR
020200020612    ***
020300020612     C                   EVAL      @VP = 'N'
020400020612    ***
020500030109     C                   IF        I_SUPER = *BLANKS
020600030109     C                   EVAL      @EMSG = 'PLEASE SELECT A SUPER AGENCY.'
020700020612     C                   LEAVESR
020800020612     C                   ENDIF
020900030109    ***
021000030109     C     I_SUPER       CHAIN(N)  SAF
021100030109     C                   IF        NOT %FOUND(SUPRAGCY)
021200030109     C                   EVAL      @EMSG = 'UNKNOWN SUPER AGENCY CODE.'
021300030109     C                   LEAVESR
021400030109     C                   ENDIF
021500020614    ***
021600020612     C                   EVAL      @VP = 'Y'
021700020612    ***
021800020612     C                   ENDSR
021900020612   S***S
