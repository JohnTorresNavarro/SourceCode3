000100000216     F*********************************************************************
000200010226     F* FI020      - SUBDIVISION MASTER INQUIRY                           *
000300000216     F*                                                                   *
000400010226     F* CLONED FROM FM020R  SSK  02.26.2001                               *
000500000216     F*                                                                   *
000600000216     F*********************************************************************
000700000216     F* MODIFICATION HISTORY                                              *
000800180109     F* ### rlj 20180109 Alter for Adv Mbl check                          *
000900010109     F*                                                                   *
001000010109     F*                                                                   *
001100010109     F*                                                                   *
001200000216     F*********************************************************************
001300010226     FFI020D    CF   E             WORKSTN INFDS(WSDS)
001400010226     FSUBMST    IF   E           K DISK
001500000217     FTRSMST    IF   E           K DISK
001600010226   X***X
001700010226    ***
001800000216     D WSDS            DS
001900000216     D  FKEY                 369    369A
002000010226    ***
002100000216     D  F1             C                   CONST(X'31')
002200000216     D  F2             C                   CONST(X'32')
002300000216     D  F3             C                   CONST(X'33')
002400000216     D  F4             C                   CONST(X'34')
002500000216     D  F5             C                   CONST(X'35')
002600000216     D  F6             C                   CONST(X'36')
002700000216     D  F7             C                   CONST(X'37')
002800000216     D  F8             C                   CONST(X'38')
002900000216     D  F9             C                   CONST(X'39')
003000000216     D  F10            C                   CONST(X'3A')
003100000216     D  F11            C                   CONST(X'3B')
003200000216     D  F12            C                   CONST(X'3C')
003300000216     D  F13            C                   CONST(X'B1')
003400000216     D  F14            C                   CONST(X'B2')
003500000216     D  F15            C                   CONST(X'B3')
003600000216     D  F16            C                   CONST(X'B4')
003700000216     D  F17            C                   CONST(X'B5')
003800000216     D  F18            C                   CONST(X'B6')
003900000216     D  F19            C                   CONST(X'B7')
004000000216     D  F20            C                   CONST(X'B8')
004100000216     D  F21            C                   CONST(X'B9')
004200000216     D  F22            C                   CONST(X'BA')
004300000216     D  F23            C                   CONST(X'BB')
004400000216     D  F24            C                   CONST(X'BC')
004500010226    ***
004600010109     D MSG             S             45    DIM(9) CTDATA PERRCD(1)
004700010226    ***
004800000216     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
004900000216     D                UDS
005000000216     D  TITLE                201    240
005100000216     ***
005200000216     C                   DOU       @STEP = 'EXIT'
005300000216     C     @STEP         CASEQ     'STEP1 '      $STEP1
005400000216     C     @STEP         CASEQ     'STEP2 '      $STEP2
005500000216     C                   ENDCS
005600000216     C                   ENDDO
005700000216     C*
005800000216     C                   MOVE      *ON           *INLR
005900000216     C*
006000000216     C     *INZSR        BEGSR
006100000217     C                   MOVE      'STEP1 '      @STEP             6
006200000217     C                   MOVE      *BLANKS       @EMSG            45
006300000217     C     *LIKE         DEFINE    SBTRST        #TRSKEY
006400000217     C     *LIKE         DEFINE    SBSUB#        #SUBKEY
006500000217     C     @KEYSUB       KLIST
006600000217     C                   KFLD                    #TRSKEY
006700000217     C                   KFLD                    #SUBKEY
006800000217     C*
006900000216     C                   ENDSR
007000000216     C*
007100000216     C     $STEP1        BEGSR
007200000216     C*
007300000216     C                   MOVEL(P)  @EMSG         SMSG
007400000216     C                   EXFMT     IO01
007500000216     C                   MOVE      *BLANKS       @EMSG
007600000216     C*
007700010226    1C                   IF        FKEY = F7
007800000216     C                   MOVEL(P)  'EXIT'        @STEP
007900000216     C                   LEAVESR
008000010226    1C                   ENDIF
008100010109     C*
008200010109    1C                   IF        FKEY = F9
008300010109     C                   MOVE      TRUST#        @3                3
008400010109     C                   CALL      'FM006CL'
008500010109     C                   PARM                    @3
008600010109    2C                   IF        @3 = '*LR'
008700010226     C                   MOVEL(P)  MSG(4)        @EMSG
008800010109     C                   LEAVESR
008900010109    2C                   ELSE
009000010109     C                   MOVE      @3            TRUST#
009100010109     C                   MOVE      @3            #TRSKEY
009200010109    2C                   ENDIF
009300010109    1C                   ENDIF
009400000217     C*
009500000217     C                   Z-ADD     TRUST#        #TRSKEY
009600100114    2C                   eval      *in35 = '0'
009700000223     C     #TRSKEY       CHAIN(N)  TRSMSR
009800000217     C                   IF        NOT %FOUND(TRSMST)
009900000217     C                   MOVEL(P)  MSG(1)        @EMSG
010000000217     C                   LEAVESR
010100000217     C                   ENDIF
010200010109     C*
010300010109    1C                   IF        FKEY = F11
010400010109     C                   MOVE      TRUST#        @3
010500010109     C                   MOVEL(P)  @3            @6                6
010600010109     C                   CALL      'FM007CL'
010700010109     C                   PARM                    @6
010800010109     C                   MOVE      *BLANKS       @3
010900010109     C                   MOVE      @6            @3
011000010109    2C                   IF        @3 = '*LR'
011100010226     C                   MOVEL(P)  MSG(4)        @EMSG
011200010109     C                   LEAVESR
011300010109     C                   ELSE
011400010109     C                   MOVE      @3            #SUBKEY
011500010109     C                   MOVE      @3            SUB#
011600010109    2C                   ENDIF
011700010109    1C                   ENDIF
011800000216     C*
011900000217     C                   IF        SUB# = 0
012000000217     C                   MOVEL(P)  MSG(2)        @EMSG
012100000216     C                   LEAVESR
012200000216     C                   ENDIF
012300000216     C*
012400000223     C                   Z-ADD     TRUST#        SBTRST
012500000223     C                   Z-ADD     SUB#          SBSUB#
012600000223     C                   Z-ADD     TRUST#        #TRSKEY
012700000223     C                   Z-ADD     SUB#          #SUBKEY
012800000216     C*
012900000217     C     @KEYSUB       CHAIN     SUBMSR
013000000216     C*
013100010226     C                   IF        NOT %FOUND(SUBMST)
013200010226     C                   MOVEL(P)  MSG(2)        @EMSG
013300010226     C                   LEAVESR
013400010226     C                   ENDIF
013500010226     C*
013600010226     C                   MOVEL(P)  'STEP2'       @STEP
013700010226     C*
013800010226     C                   ENDSR
013900000216     C*
014000010226     C     $STEP2        BEGSR
014100100114      *
014200100114    2C                   eval      *in35 = '0'
014300180109     C                   If        tscode = 'O N' or tscode = 'O M'
014400100114    2C                   eval      *in35 = '1'
014500100114    2C                   ENDIF
014600000216     C*
014700000216     C                   MOVEL(P)  @EMSG         SMSG
014800000216     C                   EXFMT     IO02
014900000216     C                   MOVE      *BLANKS       @EMSG
015000000216     C*
015100000216     C                   SELECT
015200000216     C*
015300000216     C                   WHEN      FKEY = F1
015400000216     C                   MOVEL(P)  'STEP1'       @STEP
015500000216     C                   MOVE      *BLANKS       @EMSG
015600000216     C                   LEAVESR
015700000217     C*
015800000216     C                   WHEN      FKEY = F7
015900000216     C                   MOVEL(P)  'EXIT'        @STEP
016000000216     C                   LEAVESR
016100000216     C*
016200100114      *
016300100114     C                   WHEN      FKEY = F12
016400180109     C                   If        tscode = 'O N' or tscode = 'O M'
016500100114     C                   MOVEL     SBTRST        @P1               6
016600100114     C                   MOVE      SBSUB#        @P1
016700100114     C                   CALL      'FI022CL'
016800100114     C                   PARM                    @P1
016900100114     C                   LEAVESR
017000100114     C                   ENDIF
017100100114      *
017200000216     C                   ENDSL
017300000216     C*
017400010226     C                   ENDSR
017500000217     C*
017600010226   X***X
017700910215**   ERROR MESSAGE ARRAY
017800010226TRUST # CODE IS INVALID
017900010226SUBDIVISION # IS INVALID
018000010226SUBDIVISION IS DELETED
018100010109NO SELECTION MADE
