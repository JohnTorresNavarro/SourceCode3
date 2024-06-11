000100000216     F*********************************************************************
000200010226     F* FI010      - TRUST MASTER MAINTENANCE                             *
000300000216     F*                                                                   *
000400010226     F* REWRITTEN BY  STEPHEN KING  2/26/2000                             *
000500010226     F*               GBS 2001                                            *
000600000216     F*                                                                   *
000700010226     F*  DESCRIPTION - THIS PROGRAM WILL INQUIRE THE TRUST MASTER FILE    *
000800000216     F*                                                                   *
000900000216     F*********************************************************************
001000000216     F* MODIFICATION HISTORY                                              *
001100000216     F* ### UUU CCYYMMDD X-->                                             *
001200010226     F* 000 SSK 20010226 CLONE FM010R AS OF THIS DATE & SWITCH TO INQUIRY *
001300000216     F*                                                                   *
001400000216     F*********************************************************************
001500010226     FFI010D    CF   E             WORKSTN INFDS(WSDS)
001600010226     FTRSMST    IF   E           K DISK
001700000216     FCODES     IF   E           K DISK
001800010226   X***X
001900000920     D #USA            S               D   DATFMT(*USA)
002000000920     D #ISO            S               D   DATFMT(*ISO)
002100000217     ***
002200000216     D WSDS            DS
002300000216     D  FKEY                 369    369A
002400000216     ***
002500000216     D  F1             C                   CONST(X'31')
002600000216     D  F2             C                   CONST(X'32')
002700000216     D  F3             C                   CONST(X'33')
002800000216     D  F4             C                   CONST(X'34')
002900000216     D  F5             C                   CONST(X'35')
003000000216     D  F6             C                   CONST(X'36')
003100000216     D  F7             C                   CONST(X'37')
003200000216     D  F8             C                   CONST(X'38')
003300000216     D  F9             C                   CONST(X'39')
003400000216     D  F10            C                   CONST(X'3A')
003500000216     D  F11            C                   CONST(X'3B')
003600000216     D  F12            C                   CONST(X'3C')
003700000216     D  F13            C                   CONST(X'B1')
003800000216     D  F14            C                   CONST(X'B2')
003900000216     D  F15            C                   CONST(X'B3')
004000000216     D  F16            C                   CONST(X'B4')
004100000216     D  F17            C                   CONST(X'B5')
004200000216     D  F18            C                   CONST(X'B6')
004300000216     D  F19            C                   CONST(X'B7')
004400000216     D  F20            C                   CONST(X'B8')
004500000216     D  F21            C                   CONST(X'B9')
004600000216     D  F22            C                   CONST(X'BA')
004700000216     D  F23            C                   CONST(X'BB')
004800000216     D  F24            C                   CONST(X'BC')
004900010226    ***
005000010226     D MSG             S             45    DIM(11) CTDATA PERRCD(1)
005100010226    ***
005200000216     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
005300000216     D                UDS
005400000216     D  TITLE                201    240
005500010226   X***X
005600000216     C                   DOU       @STEP = 'EXIT'
005700000216     C     @STEP         CASEQ     'STEP1 '      $STEP1
005800000216     C     @STEP         CASEQ     'STEP2 '      $STEP2
005900000216     C                   ENDCS
006000000216     C                   ENDDO
006100000216     C*
006200000216     C                   MOVE      *ON           *INLR
006300010226   S***S
006400000216     C     *INZSR        BEGSR
006500010226    ***
006600000217     C                   MOVE      'O  '         @3                3
006700000216     C                   MOVE      'STEP1 '      @STEP             6
006800000216     C                   MOVE      *BLANKS       @EMSG            45
006900000216     C                   MOVE      'O'           @O                1
007000000222     C                   MOVE      *BLANKS       @TS40            40
007100000216     C     *LIKE         DEFINE    TRTRST        @KEYTRST
007200000216     C     *LIKE         DEFINE    CODE          @CODE
007300000216     C     @CODEKEY      KLIST
007400000216     C                   KFLD                    @O
007500000216     C                   KFLD                    @CODE
007600000216     C                   ENDSR
007700010226   S***S
007800000216     C     $STEP1        BEGSR
007900000216     C*
008000000216     C                   MOVEL(P)  @EMSG         SMSG
008100000216     C                   EXFMT     IO01
008200000216     C                   MOVE      *BLANKS       @EMSG
008300010226     C* F7=EXIT
008400010108    1C                   IF        FKEY = F7
008500000216     C                   MOVEL(P)  'EXIT'        @STEP
008600000216     C                   LEAVESR
008700010108    1C                   ENDIF
008800010226     C* F9=TRUST SELECTOR
008900010226    1C                   IF        FKEY = F9
009000010226     C                   MOVE      *BLANK        @PARM3            3
009100010226     C                   CALL      'FM006CL'
009200010226     C                   PARM                    @PARM3
009300010226    2C                   IF        @PARM3 = '*LR'
009400010226     C                   MOVEL(P)  MSG(3)        @EMSG
009500010226     C                   LEAVESR
009600010226    2C                   ELSE
009700010226     C                   MOVE      @PARM3        TRUST#
009800010226    2C                   ENDIF
009900010226    1C                   ENDIF
010000010226     C* NO TRUST ENTERED
010100010226    1C                   IF        TRUST# = 0
010200000216     C                   MOVEL(P)  MSG(1)        @EMSG
010300000216     C                   LEAVESR
010400010226    1C                   ENDIF
010500010226     C* VALIDATE # ENTERED
010600000216     C                   Z-ADD     TRUST#        @KEYTRST
010700000216     C     @KEYTRST      CHAIN     TRSMSR
010800000216     C*
010900010226    1C                   IF        NOT %FOUND(TRSMST)
011000010226     C                   MOVEL(P)  MSG(1)        @EMSG
011100010226     C                   LEAVESR
011200010226    1C                   ENDIF
011300010226    ***
011400010226    1C                   IF        CONTDT <> 0
011500000920     C                   MOVE      CONTDT        #ISO
011600000920     C                   MOVE      #ISO          #USA
011700000920     C                   MOVE      #USA          I2CNTDT
011800010226    1C                   ENDIF
011900000217     C*
012000000216     C                   MOVE      TSCODE        TC
012100000217     C                   MOVE      *BLANKS       @CODE
012200000217     C                   MOVE      TC            @CODE
012300000217     C     @CODEKEY      CHAIN     CODESR
012400000216     C*
012500010226    1C                   IF        TRDLTD = 'D'
012600000216     C                   MOVEL(P)  MSG(2)        @EMSG
012700010226    1C                   ENDIF
012800010226     C                   MOVEL(P)  'STEP2'       @STEP
012900010226     C                   ENDSR
013000010226     C*
013100010226     C     $STEP2        BEGSR
013200000216     C*
013300000216     C                   MOVEL(P)  @EMSG         SMSG
013400010226     C                   EXFMT     IO02
013500000216     C*
013600000216     C                   SELECT
013700000216     C*
013800000216     C                   WHEN      FKEY = F1
013900000216     C                   MOVEL(P)  'STEP1'       @STEP
014000000216     C                   MOVE      *BLANKS       @EMSG
014100000216     C                   LEAVESR
014200000216     C*
014300000216     C                   WHEN      FKEY = F7
014400000216     C                   MOVEL(P)  'EXIT'        @STEP
014500000216     C                   LEAVESR
014600000216     C*
014700010226     C                   WHEN      FKEY = F10
014800010226     C                   MOVE      'O  '         @3
014900010226     C                   CALL      'FM001CL'
015000010226     C                   PARM                    @3
015100010226     C
015200010226     C                   ENDSL
015300010226     C
015400010226     C                   ENDSR
015500010226   X***X
015600910215**   ERROR MESSAGE ARRAY
015700000216TRUST # CODE IS INVALID
015800010226THIS TRUST HAS BEEN DELETED
015900010226NO SELECTION MADE
