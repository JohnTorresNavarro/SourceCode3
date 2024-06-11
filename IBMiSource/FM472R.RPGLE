000100020613     F*-------------------------------------------------------------------------
000200030110     F* FM472      GBS/IO SOFTWARE 2003
000300030110     F*            FM47* SUPER AGENCY ENCHANCMENT PROJECT
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
001600030110     ** 000  SSK  01102003  ORIGINAL SOURCE                               **
001700020613     **                                                                   **
001800020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900030110     FFM472D    CF   E             WORKSTN INFDS(WSDS)
002000030225     FSPRAGXRF  IF   E           K DISK
002100030225     FSUPRAGCY  IF   E           K DISK
002200020612   X***X
002300020612     D WSDS            DS
002400020612     D  FKEY                 369    369A
002500030109    *D @IM             S              1A
002600030109    *D @IMHOLD         S              1A
002700020612    ***
002800020612     D  F1             C                   CONST(X'31')
002900020612     D  F2             C                   CONST(X'32')
003000020612     D  F3             C                   CONST(X'33')
003100020612     D  F4             C                   CONST(X'34')
003200020612     D  F5             C                   CONST(X'35')
003300020612     D  F6             C                   CONST(X'36')
003400020612     D  F7             C                   CONST(X'37')
003500020612     D  F8             C                   CONST(X'38')
003600020612     D  F9             C                   CONST(X'39')
003700020612     D  F10            C                   CONST(X'3A')
003800020612     D  F11            C                   CONST(X'3B')
003900020612     D  F12            C                   CONST(X'3C')
004000020612     D  F13            C                   CONST(X'B1')
004100020612     D  F14            C                   CONST(X'B2')
004200020612     D  F15            C                   CONST(X'B3')
004300020612     D  F16            C                   CONST(X'B4')
004400020612     D  F17            C                   CONST(X'B5')
004500020612     D  F18            C                   CONST(X'B6')
004600020612     D  F19            C                   CONST(X'B7')
004700020612     D  F20            C                   CONST(X'B8')
004800020612     D  F21            C                   CONST(X'B9')
004900020612     D  F22            C                   CONST(X'BA')
005000020612     D  F23            C                   CONST(X'BB')
005100020612     D  F24            C                   CONST(X'BC')
005200020612    ***
005300020612     D @STEP           S              5A
005400030109    *D P@1             S              1A
005500030429    *D P@3             S              3A
005600030109    *D @VP             S              1A
005700030225     D DS@REC        E DS                  EXTNAME(SPRAGXRF)
005800020612    ***
005900020612     D @EMSG           S             70A
006000020612   X***X
006100020612     C                   DOU       @STEP = 'LEAVE'
006200020612     C     @STEP         CASEQ     'STEP1'       $STEP1
006300020612     C                   ENDCS
006400020612     C                   ENDDO
006500020612    ***
006600020612     C                   MOVE      *ON           *INLR
006700020612   S***S
006800020612     C     *INZSR        BEGSR
006900030110    ***
007000030110     C     *ENTRY        PLIST
007100030110     C                   PARM                    P@3               3
007200030110     C                   PARM                    P@41             41
007300030225    ***
007400030110     C                   MOVEL(P)  P@3           O_AGENCY
007500030110     C                   MOVEL(P)  P@41          O_AGNAM1
007600020612    ***
007700030109     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
007800030109     C                   IN        @DTA50
007900030109    ***
008000030109     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
008100020613    ***
008200020617     C                   EVAL      @STEP   = 'STEP1'
008300030109     C                   EVAL      I_SUPER = *BLANKS
008400020612    ***
008500020612     C                   ENDSR
008600020612   S***S
008700020612     C     $STEP1        BEGSR
008800020612    ***
008900020612     C                   MOVEL     @EMSG         EMSG
009000030109     C                   EXFMT     IO01
009100020612     C                   MOVE      *BLANKS       EMSG
009200020612     C                   MOVE      *BLANKS       @EMSG
009300030429     C                   MOVE      *BLANKS       P@3
009400020612    ***
009500020612     C                   IF        FKEY = F7
009600020612     C                   EVAL      @STEP = 'LEAVE'
009700020612     C                   LEAVESR
009800020612     C                   ENDIF
009900020612    ***
010000030110     C                   IF        FKEY = F9
010100030110     C                   CALL      'FM461CL'
010200030429     C                   PARM                    P@3
010300030429     C                   IF        P@3 <> '*LR'
010400030429     C                   EVAL      I_SUPER = P@3
010500030110     C                   ENDIF
010600030110     C                   LEAVESR
010700030110     C                   ENDIF
010800030110    ***
010900020612     C                   IF        FKEY = F4
011000030429     C                   MOVE      *ALL'X'       P@30             30
011100030429     C                   EVAL      %SUBST(P@30:4:3) = O_AGENCY
011200030110     C                   CALL      'FM471CL'
011300030429     C                   PARM                    P@30
011400030429     C                   IF        %SUBST(P@30:1:3) <> '*LR'
011500030429     C                   EVAL      I_SUPER = %SUBST(P@30:1:3)
011600030429     C                   EVAL      HOLDREC = P@30
011700020612     C                   ENDIF
011800020612     C                   LEAVESR
011900020612     C                   ENDIF
012000020612    ***
012100030110     C                   IF        FKEY = F6
012200020613     C                   EXSR      $F6
012300020613     C                   LEAVESR
012400020613     C                   ENDIF
012500020729    ***
012600020612     C                   EXSR      $VALID
012700020612    ***
012800020613     C                   IF        @VP = 'Y'
012900030110     C*
013000030429     C                   IF        %SUBST(HOLDREC:7:16) = *BLANKS
013100030110     C                   EVAL      @EMSG = 'USE F4 TO SELECT RECORD TO EDIT.'
013200030110     C                   LEAVESR
013300030110     C                   ENDIF
013400020612     C*
013500030110     C                   CALL      'FM470CL'
013600030110     C                   PARM                    HOLDREC
013700020612     C*
013800030110     C                   IF        HOLDREC = 'X'
013900020612     C                   EVAL      @STEP = 'LEAVE'
014000020612     C                   LEAVESR
014100030110     C                   ELSE
014200030110     C                   MOVE      *BLANKS       HOLDREC
014300030109     C                   EVAL      I_SUPER = *BLANKS
014400020612     C                   ENDIF
014500020612     C*
014600020612     C                   ENDIF
014700020613    ***
014800020613     C                   ENDSR
014900020613   S***S
015000020613     C     $F6           BEGSR
015100020613    ***
015200030110     C                   IF        I_SUPER = *BLANKS
015300030109     C                   EVAL      @EMSG = 'A SUPER AGENCY CODE IS REQUIR' +
015400030109     C                             'ED PRIOR TO F6. ADD DENIED.'
015500030109     C                   LEAVESR
015600030109     C                   ENDIF
015700040708    ***
015800040708     C     I_SUPER       CHAIN(N)  SAF
015900040708     C                   IF        NOT %FOUND(SUPRAGCY)
016000040708     C                   EVAL      @EMSG = 'UNKNOWN SUPER AGENCY CODE.'
016100040708     C                   LEAVESR
016200040708     C                   ENDIF
016300020613    ***
016400030110     C                   MOVE      *ALL'A'       HOLDREC
016500030429     C                   EVAL      %SUBST(HOLDREC:1:3) = I_SUPER
016600030429     C                   EVAL      %SUBST(HOLDREC:4:3) = O_AGENCY
016700030110    ***
016800030110     C                   CALL      'FM470CL'
016900030110     C                   PARM                    HOLDREC
017000020617    ***
017100030110     C                   IF        HOLDREC = 'X'
017200030225     C                   MOVE      *BLANKS       HOLDREC
017300030225     C                   EVAL      I_SUPER = *BLANKS
017400030110     C                   EVAL      @STEP = 'LEAVE'
017500030110     C                   ELSE
017600030429     C                   EVAL      I_SUPER = %SUBST(HOLDREC:1:3)
017700030110     C                   ENDIF
017800020612    ***
017900020612     C                   ENDSR
018000020612   S***S
018100020612     C     $VALID        BEGSR
018200020612    ***
018300020612     C                   EVAL      @VP = 'N'
018400020612    ***
018500030109     C                   IF        I_SUPER = *BLANKS
018600030109     C                   EVAL      @EMSG = 'PLEASE SELECT A SUPER AGENCY.'
018700020612     C                   LEAVESR
018800020612     C                   ENDIF
018900030109    ***
019000030109     C     I_SUPER       CHAIN(N)  SAF
019100030109     C                   IF        NOT %FOUND(SUPRAGCY)
019200030109     C                   EVAL      @EMSG = 'UNKNOWN SUPER AGENCY CODE.'
019300030109     C                   LEAVESR
019400030109     C                   ENDIF
019500030429    ***
019600030225     C                   EVAL      HOLDREC = *BLANKS
019700030225     C     KEY#SPR       KLIST
019800030225     C                   KFLD                    I_SUPER
019900030225     C                   KFLD                    O_AGENCY
020000030225     C     KEY#SPR       CHAIN     SXF
020100030225     C                   IF        %FOUND(SPRAGXRF)
020200030225     C                   EVAL      HOLDREC = DS@REC
020300030225     C                   ELSE
020400030225     C                   EVAL      @EMSG = 'BAD AGENCY/S. AGENCY COMBO.'
020500030225     C                   LEAVESR
020600030225     C                   ENDIF
020700020614    ***
020800020612     C                   EVAL      @VP = 'Y'
020900020612    ***
021000020612     C                   ENDSR
021100020612   S***S
