000100020613     F*-------------------------------------------------------------------------
000200040708     F* IQR162     GBS/IO SOFTWARE 2003
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
001700040708     ** ***  SSK  01022004  COPY FM472R TO IQ                             **
001800020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900040708     FIQR162D   CF   E             WORKSTN INFDS(WSDS)
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
007700020617     C                   EVAL      @STEP   = 'STEP1'
007800030109     C                   EVAL      I_SUPER = *BLANKS
007900020612    ***
008000020612     C                   ENDSR
008100020612   S***S
008200020612     C     $STEP1        BEGSR
008300020612    ***
008400020612     C                   MOVEL     @EMSG         EMSG
008500030109     C                   EXFMT     IO01
008600020612     C                   MOVE      *BLANKS       EMSG
008700020612     C                   MOVE      *BLANKS       @EMSG
008800030429     C                   MOVE      *BLANKS       P@3
008900020612    ***
009000020612     C                   IF        FKEY = F7
009100020612     C                   EVAL      @STEP = 'LEAVE'
009200020612     C                   LEAVESR
009300020612     C                   ENDIF
009400020612    ***
009500030110     C                   IF        FKEY = F9
009600040708     C                   CALL      'IQC151'
009700030429     C                   PARM                    P@3
009800030429     C                   IF        P@3 <> '*LR'
009900030429     C                   EVAL      I_SUPER = P@3
010000030110     C                   ENDIF
010100030110     C                   LEAVESR
010200030110     C                   ENDIF
010300030110    ***
010400020612     C                   IF        FKEY = F4
010500030429     C                   MOVE      *ALL'X'       P@30             30
010600030429     C                   EVAL      %SUBST(P@30:4:3) = O_AGENCY
010700040708     C                   CALL      'IQC161'
010800030429     C                   PARM                    P@30
010900030429     C                   IF        %SUBST(P@30:1:3) <> '*LR'
011000030429     C                   EVAL      I_SUPER = %SUBST(P@30:1:3)
011100030429     C                   EVAL      HOLDREC = P@30
011200020612     C                   ENDIF
011300020612     C                   LEAVESR
011400020612     C                   ENDIF
011500020612    ***
011600020612     C                   EXSR      $VALID
011700020612    ***
011800020613     C                   IF        @VP = 'Y'
011900030110     C*
012000030429     C                   IF        %SUBST(HOLDREC:7:16) = *BLANKS
012100030110     C                   EVAL      @EMSG = 'USE F4 TO SELECT RECORD TO EDIT.'
012200030110     C                   LEAVESR
012300030110     C                   ENDIF
012400020612     C*
012500040708     C                   CALL      'IQC160'
012600030110     C                   PARM                    HOLDREC
012700020612     C*
012800030110     C                   IF        HOLDREC = 'X'
012900020612     C                   EVAL      @STEP = 'LEAVE'
013000020612     C                   LEAVESR
013100030110     C                   ELSE
013200030110     C                   MOVE      *BLANKS       HOLDREC
013300030109     C                   EVAL      I_SUPER = *BLANKS
013400020612     C                   ENDIF
013500020612     C*
013600020612     C                   ENDIF
013700020613    ***
013800020613     C                   ENDSR
013900020613   S***S
014000020612   S***S
014100020612     C     $VALID        BEGSR
014200020612    ***
014300020612     C                   EVAL      @VP = 'N'
014400020612    ***
014500030109     C                   IF        I_SUPER = *BLANKS
014600030109     C                   EVAL      @EMSG = 'PLEASE SELECT A SUPER AGENCY.'
014700020612     C                   LEAVESR
014800020612     C                   ENDIF
014900030109    ***
015000030109     C     I_SUPER       CHAIN(N)  SAF
015100030109     C                   IF        NOT %FOUND(SUPRAGCY)
015200030109     C                   EVAL      @EMSG = 'UNKNOWN SUPER AGENCY CODE.'
015300030109     C                   LEAVESR
015400030109     C                   ENDIF
015500030429    ***
015600030225     C                   EVAL      HOLDREC = *BLANKS
015700030225     C     KEY#SPR       KLIST
015800030225     C                   KFLD                    I_SUPER
015900030225     C                   KFLD                    O_AGENCY
016000030225     C     KEY#SPR       CHAIN     SXF
016100030225     C                   IF        %FOUND(SPRAGXRF)
016200030225     C                   EVAL      HOLDREC = DS@REC
016300030225     C                   ELSE
016400030225     C                   EVAL      @EMSG = 'BAD AGENCY/S. AGENCY COMBO.'
016500030225     C                   LEAVESR
016600030225     C                   ENDIF
016700020614    ***
016800020612     C                   EVAL      @VP = 'Y'
016900020612    ***
017000020612     C                   ENDSR
017100020612   S***S
