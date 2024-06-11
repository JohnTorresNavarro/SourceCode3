000100020613     F*-------------------------------------------------------------------------
000200040708     F* IQR172     GBS/IO SOFTWARE 2003
000300030225     F*            FM48* SALESMAN RELATIONSHIP APPLICATION
000400030225     F*                  SUPER AGENCY ENCHANCMENT PROJECT
000500030225     F*            WRITTEN BY - S.S.K.
000600030225     F*            DATE - 02/03
000700020613     F*  DESCRIPTION - PROMPT
000800020613     F*  INDICATOR USAGE:
000900020613     F*    01 = EXIT FROM INITIAL SCREEN
001000020613     F*    25 = SFLDSP
001100020613     F*    26 = SFL DSP CTL
001200020613     F*    27 = SFL CLR
001300020613     F*
001400020613     F*-------------------------------------------------------------------------
001500020613     ** MODIFICATION HISTORY                                              **
001600020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001700030225     ** 000  SSK  02222003  ORIGINAL SOURCE                               **
001800040708     ** ***  SSK  01072004  COPY FM482R TO IQ                             **
001900020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000040708     FIQR172D   CF   E             WORKSTN INFDS(WSDS)
002100030228     FSMAN      IF   E           K DISK
002200030228     FAGENCY    IF   E           K DISK
002300030228     FSUPRAGCY  IF   E           K DISK
002400030307     FSPRAGXR2  IF   E           K DISK
002500030307     FSMANRLT   IF   E           K DISK    RENAME(SRF:BYREL)
002600030307     FSMANRLT1  IF   E           K DISK    RENAME(SRF:BYSMN)
002700020612   X***X
002800020612     D WSDS            DS
002900020612     D  FKEY                 369    369A
003000030109    *D @IM             S              1A
003100030109    *D @IMHOLD         S              1A
003200020612    ***
003300020612     D  F1             C                   CONST(X'31')
003400020612     D  F2             C                   CONST(X'32')
003500020612     D  F3             C                   CONST(X'33')
003600020612     D  F4             C                   CONST(X'34')
003700020612     D  F5             C                   CONST(X'35')
003800020612     D  F6             C                   CONST(X'36')
003900020612     D  F7             C                   CONST(X'37')
004000020612     D  F8             C                   CONST(X'38')
004100020612     D  F9             C                   CONST(X'39')
004200020612     D  F10            C                   CONST(X'3A')
004300020612     D  F11            C                   CONST(X'3B')
004400020612     D  F12            C                   CONST(X'3C')
004500020612     D  F13            C                   CONST(X'B1')
004600020612     D  F14            C                   CONST(X'B2')
004700020612     D  F15            C                   CONST(X'B3')
004800020612     D  F16            C                   CONST(X'B4')
004900020612     D  F17            C                   CONST(X'B5')
005000020612     D  F18            C                   CONST(X'B6')
005100020612     D  F19            C                   CONST(X'B7')
005200020612     D  F20            C                   CONST(X'B8')
005300020612     D  F21            C                   CONST(X'B9')
005400020612     D  F22            C                   CONST(X'BA')
005500020612     D  F23            C                   CONST(X'BB')
005600020612     D  F24            C                   CONST(X'BC')
005700020612    ***
005800020612     D @STEP           S              5A
005900030225    *D P@3             S              3A
006000030109    *D @VP             S              1A
006100030225     D DS@REC        E DS                  EXTNAME(SMANRLT)
006200030313     D A@20            S             20A
006300030228     D A@40            S             40A
006400020612    ***
006500020612     D @EMSG           S             70A
006600020612   X***X
006700020612     C                   DOU       @STEP = 'LEAVE'
006800020612     C     @STEP         CASEQ     'STEP1'       $STEP1
006900020612     C                   ENDCS
007000020612     C                   ENDDO
007100020612    ***
007200020612     C                   MOVE      *ON           *INLR
007300020612   S***S
007400020612     C     *INZSR        BEGSR
007500030110    ***
007600030110     C     *ENTRY        PLIST
007700030225     C                   PARM                    P@3
007800030225    ***
007900030225     C                   CLEAR                   IO01
008000030225     C                   MOVEL(P)  P@3           O_SMAN
008100020612    ***
008200030307     C     KEY#SR1       KLIST
008300030307     C                   KFLD                    O_SMAN
008400030307     C                   KFLD                    I_ASID
008500030307    ***
008600030228     C     O_SMAN        CHAIN     SMANR
008700030228     C                   IF        %FOUND(SMAN)
008800030228     C                   EXSR      $GETSNAME
008900030228     C                   ELSE
009000030228     C                   EVAL      D_SMAN = '*UNKNOWN*'
009100030228     C                   ENDIF
009200020613    ***
009300020617     C                   EVAL      @STEP   = 'STEP1'
009400020612    ***
009500020612     C                   ENDSR
009600020612   S***S
009700040708     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
009800030228   S***S
009900020612     C     $STEP1        BEGSR
010000020612    ***
010100020612     C                   MOVEL     @EMSG         EMSG
010200030109     C                   EXFMT     IO01
010300020612     C                   MOVE      *BLANKS       EMSG
010400020612     C                   MOVE      *BLANKS       @EMSG
010500020612    ***
010600030307     C                   SELECT
010700030307     C                   WHEN      FKEY = F7
010800020612     C                   EVAL      @STEP = 'LEAVE'
010900020612     C                   LEAVESR
011000030307     C                   WHEN      FKEY = F4
011100030228     C                   EXSR      $F4
011200020612     C                   LEAVESR
011300030307     C                   WHEN      FKEY = F9
011400030307     C                   EXSR      $F9
011500030307     C                   LEAVESR
011600030307     C                   WHEN      FKEY = F11
011700030307     C                   EXSR      $F11
011800030307     C                   LEAVESR
011900030307     C                   ENDSL
012000030307    ***
012100030307     C                   IF        I_ASID <> *BLANKS
012200030307    ***
012300030307     C                   IF        HOLDREC = *BLANKS
012400030307     C     KEY#SR1       CHAIN     BYSMN
012500030307     C*
012600030307     C                   IF        NOT %FOUND(SMANRLT1)
012700040105     C                   EVAL      EMSG = 'UNKNOWN RELATIONSHIP.'
012800030307     C                   LEAVESR
012900030307     C                   ENDIF
013000030307     C*
013100030307     C                   EVAL      HOLDREC = DS@REC
013200030307     C                   ENDIF
013300030307    ***
013400040708     C                   CALL      'IQC170'
013500030110     C                   PARM                    HOLDREC
013600020612     C*
013700030110     C                   IF        HOLDREC = 'X'
013800020612     C                   EVAL      @STEP = 'LEAVE'
013900020612     C                   LEAVESR
014000020612     C                   ENDIF
014100030307     C*
014200020612     C                   ENDIF
014300030307    ***
014400030307     C                   ENDSR
014500030307   S***S
014600030307     C     $F9           BEGSR
014700030307    ***
014800030307     C                   MOVE      *ALL'X'       P@35             35
014900030307     C                   EVAL      %SUBST(P@35:17:3) = O_SMAN
015000040708     C                   CALL      'IQC171'
015100030307     C                   PARM                    P@35
015200030307     C                   IF        %SUBST(P@35:1:3) <> '*LR'
015300030307     C                   EVAL      HOLDREC = P@35
015400030307     C                   MOVEL     P@35          @RELID            8
015500030307     C     @RELID        CHAIN     BYREL
015600030507     C                   EVAL      I_ASID = SRASID
015700030307     C                   EXSR      $DESCS
015800030310     C                   EVAL      O_AGCY = SXAGCY
015900030310     C                   EVAL      O_SUPER = SXSUPER
016000030307     C                   ENDIF
016100030307    ***
016200030307     C                   ENDSR
016300030307   S***S
016400030307     C     $DESCS        BEGSR
016500030307    ***
016600030307     C     SRASID        CHAIN     SXF
016700030307     C                   IF        NOT %FOUND(SPRAGXR2)
016800030307     C                   MOVE      *BLANKS       SXAGCY
016900030307     C                   MOVE      *BLANKS       SXSUPER
017000030307     C                   ENDIF
017100030307    ***
017200030307     C     SXAGCY        CHAIN     AGENR
017300030307     C                   IF        %FOUND(AGENCY)
017400030307     C                   MOVEL(P)  AGNAM1        D_AGCY
017500030307     C                   ELSE
017600030307     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
017700030307     C                   ENDIF
017800030228    ***
017900030307     C     SXSUPER       CHAIN     SAF
018000030307     C                   IF        %FOUND(SUPRAGCY)
018100030307     C                   MOVEL(P)  SANAME1       D_SUPER
018200030307     C                   ELSE
018300030307     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
018400030307     C                   ENDIF
018500030307    ***
018600030228     C                   ENDSR
018700030228   S***S
018800030228     C     $F11          BEGSR
018900030228    ***
019000040105     C                   IF        I_ASID <> *BLANKS AND HOLDREC <> *BLANKS
019100040105     C                   EVAL      P@8 = %SUBST(HOLDREC:1:8)
019200040708     C                   CALL      'IQC173'
019300030228     C                   PARM                    P@8               8
019400040105     C                   ELSE
019500040105     C                   EVAL      EMSG = 'USE F9 TO SELECT, THEN PRESS ENTE' +
019600040105     C                             'R & F1, THEN PRESS F11.'
019700030228     C                   ENDIF
019800030228    ***
019900030228     C                   ENDSR
020000020613   S***S
020100030228     C     $F4           BEGSR
020200030228    ***
020300030429     C                   MOVE      *ALL'X'       P@30             30
020400040708     C                   CALL      'IQC163'
020500030429     C                   PARM                    P@30
020600030307    ***
020700030429     C                   IF        %SUBST(P@30:1:3) <> '*LR'
020800030429     C                   EVAL      I_ASID = %SUBST(P@30:23:8)
020900030429     C                   EVAL      SRASID = %SUBST(P@30:23:8)
021000030429     C                   EVAL      O_AGCY = %SUBST(P@30:4:3)
021100030429     C                   EVAL      O_SUPER = %SUBST(P@30:1:3)
021200030307     C                   MOVE      *BLANKS       HOLDREC
021300030307     C                   EXSR      $DESCS
021400030228     C                   ENDIF
021500030228    ***
021600030228     C                   ENDSR
021700030228   S***S
