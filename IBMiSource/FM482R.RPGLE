000100020613     F*-------------------------------------------------------------------------
000200030225     F* FM482      GBS/IO SOFTWARE 2003
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
001800020613     **                                                                   **
001900020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000030225     FFM482D    CF   E             WORKSTN INFDS(WSDS)
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
009200030228    ***
009300030109     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
009400030109     C                   IN        @DTA50
009500030109    ***
009600030109     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
009700020613    ***
009800020617     C                   EVAL      @STEP   = 'STEP1'
009900020612    ***
010000020612     C                   ENDSR
010100020612   S***S
010200030228     C     $GETSNAME     BEGSR
010300030228    ***
010400030313     C                   CLEAR                   A@20
010500030228     C                   CLEAR                   A@40
010600030228    ***
010700030228     C                   IF        SFNAME <> *BLANKS
010800030313     C                   MOVEL     SFNAME        A@20
010900030228     C                   EXSR      $LDADDR
011000030228     C                   ENDIF
011100030228    ***
011200030228     C                   IF        SMI <> *BLANKS
011300030313     C                   MOVEL     SMI           A@20
011400030228     C                   EXSR      $LDADDR
011500030228     C                   ENDIF
011600030228    ***
011700030228     C                   IF        SLNAME <> *BLANKS
011800030313     C                   MOVEL     SLNAME        A@20
011900030228     C                   EXSR      $LDADDR
012000030228     C                   ENDIF
012100030228    ***
012200030228     C                   ENDSR
012300030228   S***S
012400030228     C     $LDADDR       BEGSR
012500030228    ***
012600030313     C                   EVAL      A@20 = %TRIM(A@20)
012700030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
012800030313     C                   CLEAR                   A@20
012900030228    ***
013000030228     C                   ENDSR
013100030228   S***S
013200020612     C     $STEP1        BEGSR
013300020612    ***
013400020612     C                   MOVEL     @EMSG         EMSG
013500030109     C                   EXFMT     IO01
013600020612     C                   MOVE      *BLANKS       EMSG
013700020612     C                   MOVE      *BLANKS       @EMSG
013800020612    ***
013900030307     C                   SELECT
014000030307     C                   WHEN      FKEY = F7
014100020612     C                   EVAL      @STEP = 'LEAVE'
014200020612     C                   LEAVESR
014300030307     C                   WHEN      FKEY = F4
014400030228     C                   EXSR      $F4
014500020612     C                   LEAVESR
014600030307     C                   WHEN      FKEY = F9
014700030307     C                   EXSR      $F9
014800030307     C                   LEAVESR
014900030307     C                   WHEN      FKEY = F6
015000020613     C                   EXSR      $F6
015100020613     C                   LEAVESR
015200030307     C                   WHEN      FKEY = F11
015300030307     C                   EXSR      $F11
015400030307     C                   LEAVESR
015500030307     C                   ENDSL
015600030307    ***
015700030307     C                   IF        I_ASID <> *BLANKS
015800030307    ***
015900030307     C                   IF        HOLDREC = *BLANKS
016000030307     C     KEY#SR1       CHAIN     BYSMN
016100030307     C*
016200030307     C                   IF        NOT %FOUND(SMANRLT1)
016300030307     C                   EVAL      EMSG = 'PRESS F6 TO CREATE THIS NEW ' +
016400030307     C                                    'RELATIONSHIP.'
016500030307     C                   LEAVESR
016600030307     C                   ENDIF
016700030307     C*
016800030307     C                   EVAL      HOLDREC = DS@REC
016900030307     C                   ENDIF
017000030307    ***
017100030225     C                   CALL      'FM480CL'
017200030110     C                   PARM                    HOLDREC
017300020612     C*
017400030110     C                   IF        HOLDREC = 'X'
017500020612     C                   EVAL      @STEP = 'LEAVE'
017600020612     C                   LEAVESR
017700020612     C                   ENDIF
017800030307     C*
017900020612     C                   ENDIF
018000030307    ***
018100030307     C                   ENDSR
018200030307   S***S
018300030307     C     $F9           BEGSR
018400030307    ***
018500030307     C                   MOVE      *ALL'X'       P@35             35
018600030307     C                   EVAL      %SUBST(P@35:17:3) = O_SMAN
018700030307     C                   CALL      'FM481CL'
018800030307     C                   PARM                    P@35
018900030307     C                   IF        %SUBST(P@35:1:3) <> '*LR'
019000030307     C                   EVAL      HOLDREC = P@35
019100030307     C                   MOVEL     P@35          @RELID            8
019200030307     C     @RELID        CHAIN     BYREL
019300030507     C                   EVAL      I_ASID = SRASID
019400030307     C                   EXSR      $DESCS
019500030310     C                   EVAL      O_AGCY = SXAGCY
019600030310     C                   EVAL      O_SUPER = SXSUPER
019700030307     C                   ENDIF
019800030307    ***
019900030307     C                   ENDSR
020000030307   S***S
020100030307     C     $DESCS        BEGSR
020200030307    ***
020300030307     C     SRASID        CHAIN     SXF
020400030307     C                   IF        NOT %FOUND(SPRAGXR2)
020500030307     C                   MOVE      *BLANKS       SXAGCY
020600030307     C                   MOVE      *BLANKS       SXSUPER
020700030307     C                   ENDIF
020800030307    ***
020900030307     C     SXAGCY        CHAIN     AGENR
021000030307     C                   IF        %FOUND(AGENCY)
021100030307     C                   MOVEL(P)  AGNAM1        D_AGCY
021200030307     C                   ELSE
021300030307     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
021400030307     C                   ENDIF
021500030228    ***
021600030307     C     SXSUPER       CHAIN     SAF
021700030307     C                   IF        %FOUND(SUPRAGCY)
021800030307     C                   MOVEL(P)  SANAME1       D_SUPER
021900030307     C                   ELSE
022000030307     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
022100030307     C                   ENDIF
022200030307    ***
022300030228     C                   ENDSR
022400030228   S***S
022500030228     C     $F11          BEGSR
022600030228    ***
022700030307     C                   IF        I_ASID <> *BLANKS AND HOLDREC <> *BLANKS
022800030307     C                   EVAL      P@8 = %SUBST(HOLDREC:1:8)
022900030228     C                   CALL      'FM483CL'
023000030228     C                   PARM                    P@8               8
023100030228     C                   ENDIF
023200030228    ***
023300030228     C                   ENDSR
023400020613   S***S
023500030228     C     $F4           BEGSR
023600030228    ***
023700030429     C                   MOVE      *ALL'X'       P@30             30
023800030307     C                   CALL      'FM473CL'
023900030429     C                   PARM                    P@30
024000030307    ***
024100030429     C                   IF        %SUBST(P@30:1:3) <> '*LR'
024200030429     C                   EVAL      I_ASID = %SUBST(P@30:23:8)
024300030429     C                   EVAL      SRASID = %SUBST(P@30:23:8)
024400030429     C                   EVAL      O_AGCY = %SUBST(P@30:4:3)
024500030429     C                   EVAL      O_SUPER = %SUBST(P@30:1:3)
024600030307     C                   MOVE      *BLANKS       HOLDREC
024700030307     C                   EXSR      $DESCS
024800030228     C                   ENDIF
024900030228    ***
025000030228     C                   ENDSR
025100030228   S***S
025200020613     C     $F6           BEGSR
025300020613    ***
025400030110     C                   MOVE      *ALL'A'       HOLDREC
025500030307     C                   EVAL      %SUBST(HOLDREC:9:8) = I_ASID
025600030228     C                   EVAL      %SUBST(HOLDREC:17:3) = O_SMAN
025700030110    ***
025800030225     C                   CALL      'FM480CL'
025900030110     C                   PARM                    HOLDREC
026000020617    ***
026100030307     C                   IF        %SUBST(HOLDREC:1:1) = *BLANKS OR
026200030307     C                             %SUBST(HOLDREC:1:1) = 'X'
026300030110     C                   IF        HOLDREC = 'X'
026400030228     C                   EVAL      @STEP = 'LEAVE'
026500030228     C                   ELSE
026600030225     C                   MOVE      *BLANKS       HOLDREC
026700030228     C                   ENDIF
026800030110     C                   ELSE
026900030307     C                   EVAL      I_ASID = %SUBST(HOLDREC:9:8)
027000030307     C                   EXSR      $DESCS
027100030310     C                   EVAL      O_AGCY = SXAGCY
027200030310     C                   EVAL      O_SUPER = SXSUPER
027300030228     C                   ENDIF
027400020612    ***
027500020612     C                   ENDSR
027600020612   S***S
