000100030616    *** MID-MONTH COMMISSION VARIANCE LISTINGS - PROMPT
000200030616    ***
000300030616    *** SSK  06/16/2003
000400030616    ***
000500080229    *** 02/29/08 dlk - change date default from midmon data area to current
000600080229    ***                month / year
000700030616    ***
000800030616   X***X
000900030616     FRPA066DF  CF   E             WORKSTN INFDS(WSDS)
001000030616   X***X
001100030616     D @STEP           S              5A
001200080229     D*#8              S              8S 0
001300030616    ***
001400030616     D WSDS            DS
001500030616     D  FKEY                 369    369A
001501080229     D                 DS
001502080229     D  #8                     1      8s 0
001503080229     D  #dd                    3      4s 0
001504080229     D                 DS
001505080229     D  mdcy                   1      8s 0
001506080229     D  day                    3      4s 0
001600030616    ***
001700030616     D  F1             C                   CONST(X'31')
001800030616     D  F2             C                   CONST(X'32')
001900030616     D  F3             C                   CONST(X'33')
002000030616     D  F4             C                   CONST(X'34')
002100030616     D  F5             C                   CONST(X'35')
002200030616     D  F6             C                   CONST(X'36')
002300030616     D  F7             C                   CONST(X'37')
002400030616     D  F8             C                   CONST(X'38')
002500030616     D  F9             C                   CONST(X'39')
002600030616     D  F10            C                   CONST(X'3A')
002700030616     D  F11            C                   CONST(X'3B')
002800030616     D  F12            C                   CONST(X'3C')
002900030616     D  F13            C                   CONST(X'B1')
003000030616     D  F14            C                   CONST(X'B2')
003100030616     D  F15            C                   CONST(X'B3')
003200030616     D  F16            C                   CONST(X'B4')
003300030616     D  F17            C                   CONST(X'B5')
003400030616     D  F18            C                   CONST(X'B6')
003500030616     D  F19            C                   CONST(X'B7')
003600030616     D  F20            C                   CONST(X'B8')
003700030616     D  F21            C                   CONST(X'B9')
003800030616     D  F22            C                   CONST(X'BA')
003900030616     D  F23            C                   CONST(X'BB')
004000030616     D  F24            C                   CONST(X'BC')
004100030616   X***X
004200030616     C                   DOU       @STEP = 'LEAVE'
004300030616     C     @STEP         CASEQ     'PREP1'       $PREP1
004400030616     C     @STEP         CASEQ     'STEP1'       $STEP1
004500030616     C                   ENDCS
004600030616     C                   ENDDO
004700030616     C                   MOVE      *ON           *INLR
004800030616   S***S
004900030616     C     *INZSR        BEGSR
005000030616    ***
005100030616     C                   MOVE      'PREP1'       @STEP
005200030616     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
005300030616     C                   IN        @DTA50
005400030616    ***
005500080229     C*    *DTAARA       DEFINE    MIDMON        @8MDY             8
005600080229     C*                  IN        @8MDY
005700080229     C*                  MOVE      @8MDY         #8
005701080229     C                   MOVE      *date         #8
005702080229     C                   MOVE      01            #dd
005800030616    ***
005900030616     C     *ENTRY        PLIST
006000030616     C                   PARM                    @9                9
006100030616     C                   EVAL      @9 = 'N99999999'
006200030616    ***
006300030616     C                   ENDSR
006400030616   S***S
006500030616     C     $PREP1        BEGSR
006600030616    ***
006700030616     C                   CLEAR                   screen1
006800030616    ***
006900030616     C                   EVAL      CONAME = %SUBST(@DTA50:1:40)
007000030616     C                   MOVE      #8            MDCY
007100030616     C                   MOVE      'STEP1'       @STEP
007200030616     C                   EVAL      *IN25 = *OFF
007300030616    ***
007400030616     C                   ENDSR
007500030616   S***S
007600030616     C     $STEP1        BEGSR
007700030616    ***
007800030616     C                   EXFMT     SCREEN1
007900030616     C                   MOVE      *BLANKS       EMSG
008000030616    *** END APP
008100030616    1C                   IF        FKEY = F7
008200030616     C                   MOVEL(P)  'LEAVE'       @STEP
008300030616     C                   LEAVESR
008400030616    1C                   ENDIF
008500030616    ***
008600030616     C                   IF        FKEY = F6 AND *IN25 = *ON
008700030616     C                   EXSR      $VALIDATE
008800030616     C                   IF        EMSG = *BLANKS
008900030616     C                   EVAL      @9 = 'Y' + %EDITC(MDCY:'X')
009000030616     C                   MOVEL(P)  'LEAVE'       @STEP
009100030616     C                   ELSE
009200030616     C                   EVAL      *IN25 = *OFF
009300030616    1C                   ENDIF
009400030616     C                   LEAVESR
009500030616    1C                   ENDIF
009600030616    ***
009700030616     C                   EXSR      $VALIDATE
009800030616    * *
009900030616     C                   IF        EMSG = *BLANKS
010000030616     C                   EVAL      *IN25 = *ON
010100030616     C                   ELSE
010200030616     C                   EVAL      *IN25 = *OFF
010300030616    1C                   ENDIF
010400030616    ***
010500030616     C                   ENDSR
010600030616   S***S
010700030616     C     $VALIDATE     BEGSR
010800030616    ***
010900030616     C                   IF        MDCY = 0
011000030616     C                   EVAL      EMSG = 'DATE OF RUN CANNOT BE ZERO.'
011100030616     C                   LEAVESR
011200030616     C                   ENDIF
011300030616    ***
011400030616     C                   IF        MDCY > 0
011500030616     C     *USA          TEST(DE)                MDCY
011600080229     C                   IF        %ERROR or day <> 01
011700030616     C                   EVAL      EMSG = 'DATE OF RUN IS INVALID'
011800030616     C                   LEAVESR
011900030616     C                   ENDIF
012000030616     C                   ENDIF
012100030616    ***
012200030616     C                   ENDSR
012300030616   S***S
