000100991124     F*-------------------------------------------------------------------------
000200020314     F* FM033      GBS SOFTWARE 2002
000300991124     F*            WRITTEN BY - S.S.K.
000400020314     F*            DATE - 03/02
000500020314     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR PLAN CLASS MAINT
000600991124     F*  INDICATOR USAGE:
000700020208     F*    01 = EXIT FROM INITIAL SCREEN
000800000211     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900991124     F*    25 = SFLDSP
001000991124     F*    26 = SFL DSP CTL
001100991124     F*    27 = SFL CLR
001200991124     F*
001300991124     F*-------------------------------------------------------------------------
001400991209     ** MODIFICATION HISTORY                                              **
001500991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001600000211     ** 000  SSK  02112000  ORIGINAL SOURCE                               **
001601240105     **      jt   01052024  Recompiled so that it can be viewed for debug
001700991209     **                                                                   **
001800991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900020314     FCLSHIST1  IF   E           K DISK    RENAME(RCLSHIST:BEFSEQ)
002000020314     FCLSHIST2  IF   E           K DISK    RENAME(RCLSHIST:AFTSEQ)
002100020314     FFM033D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002200991124   X***X
002300020314     D @90             S             90A
002400020314     D                 DS
002500020314     D @PARMDS                 1     90A
002600020314     D P@TSP                   1     10A
002700020314     D O_TRS                   1      3S 0
002800020314     D O_SUB                   4      6S 0
002900020314     D O_PLN                   7     10A
003000020314     D O_TNAME                11     30A
003100020314     D O_SNAME                31     50A
003200020314     D O_PNAME                51     90A
003300001019    ***
003400000211     D                UDS
003500000211     D  TITLE                201    240A
003600000211    ***
003700991216     D WSDS            DS
003800991216     D  FKEY                 369    369A
003900991216    ***
004000991216     D  F1             C                   CONST(X'31')
004100991216     D  F2             C                   CONST(X'32')
004200991216     D  F3             C                   CONST(X'33')
004300991216     D  F4             C                   CONST(X'34')
004400991216     D  F5             C                   CONST(X'35')
004500991216     D  F6             C                   CONST(X'36')
004600991216     D  F7             C                   CONST(X'37')
004700991216     D  F8             C                   CONST(X'38')
004800991216     D  F9             C                   CONST(X'39')
004900991216     D  F10            C                   CONST(X'3A')
005000991216     D  F11            C                   CONST(X'3B')
005100991216     D  F12            C                   CONST(X'3C')
005200991216     D  F13            C                   CONST(X'B1')
005300991216     D  F14            C                   CONST(X'B2')
005400991216     D  F15            C                   CONST(X'B3')
005500991216     D  F16            C                   CONST(X'B4')
005600991216     D  F17            C                   CONST(X'B5')
005700991216     D  F18            C                   CONST(X'B6')
005800991216     D  F19            C                   CONST(X'B7')
005900991216     D  F20            C                   CONST(X'B8')
006000991216     D  F21            C                   CONST(X'B9')
006100991216     D  F22            C                   CONST(X'BA')
006200991216     D  F23            C                   CONST(X'BB')
006300991216     D  F24            C                   CONST(X'BC')
006400020208    ***
006500020208     D @STEP           S              5A
006600020208    ***
006700991124   X***X
006800020208     C     *ENTRY        PLIST
006900020314     C                   PARM                    @90
007000020314     C                   MOVEL     @90           @PARMDS
007100020208    ***
007200020208     C                   MOVE      *ZEROS        RRT               3 0
007300020208     C                   MOVE      *ZEROS        #CNTREC           2 0
007400020208    ***
007500020208     C                   MOVE      '0'           @1STLOOP          1
007600020208     C                   MOVE      '0'           @SFLOOP           1
007700020314     C                   MOVE      'X'           @SEQ              1
007800020208    ***
007900020208     C                   EXSR      $CLEAR
008000020314    ***
008100020208     C                   EXSR      $BUILD
008200020208    ***
008300020314    1C                   DOU       @STEP = 'LEAVE'
008400020314    ***
008500020314     C                   EXSR      $DISPLAY
008600020314    ***
008700020314    2C                   IF        FKEY = F1
008800020314     C                   EVAL      @STEP = 'LEAVE'
008900020314     C                   LEAVE
009000020314    2C                   ENDIF
009100020314    ***
009200020314    2C                   IF        FKEY = F8
009300020314    3C                   IF        @SEQ = 'M'
009400020314     C                   MOVE      'X'           @SEQ
009500020314    3C                   ELSE
009600020314     C                   MOVE      'M'           @SEQ
009700020314    3C                   ENDIF
009800020314     C                   EXSR      $CLEAR
009900020314     C                   EXSR      $BUILD
010000020314    2C                   ENDIF
010100020314    ***
010200020314    1C                   ENDDO
010300020314    ***
010400020314     C                   EVAL      *INLR = *ON
010500020208  *S***S
010600020208     C     $CLEAR        BEGSR
010700020208    ***
010800020208     C                   MOVEA     '011'         *IN(25)
010900020208     C                   WRITE     GBSCTL
011000020208     C                   MOVEA     '010'         *IN(25)
011100020208     C                   Z-ADD     *ZERO         RRT
011200020208    ***
011300020208     C                   ENDSR
011400020208   S***S
011500020208     C     $BUILD        BEGSR
011600020208    ***
011700020208     C                   EXSR      $CLEAR
011800020208     C                   MOVE      *ZEROS        #CNTREC
011900020208     C                   MOVE      '0'           @1STLOOP
012000020208     C                   MOVE      '0'           @SFLOOP
012100020208    ***
012200020208     C                   IF        @SEQ = 'M'
012300020314     C     P@TSP         SETLL     BEFSEQ
012400020208     C                   ELSE
012500020314     C     P@TSP         SETLL     AFTSEQ
012600020208     C                   ENDIF
012700020314     C                   EXSR      $BUILDF
012800020208    ***
012900020208     C                   ENDSR
013000020208   S***S
013100020208     C* BUILD BY BEFORE IMAGE
013200020208    ***
013300020314     C     $BUILDF       BEGSR
013400020208    ***
013500020314    1C                   DOU       @SFLOOP = '1'
013600020314     C*
013700020314    2C                   IF        @SEQ = 'M'
013800020314     C     P@TSP         READE     BEFSEQ
013900020314     C*
014000020314    3C                   IF        %EOF(CLSHIST1)
014100020314     C                   EVAL      @SFLOOP = '1'
014200020314     C                   LEAVESR
014300020314    3C                   ENDIF
014400020314     C*
014500020314    2C                   ELSE
014600020314     C     P@TSP         READE     AFTSEQ
014700020314     C*
014800020314    3C                   IF        %EOF(CLSHIST2)
014900020314     C                   EVAL      @SFLOOP = '1'
015000020314     C                   LEAVESR
015100020314    3C                   ENDIF
015200020314     C*
015300020314    2C                   ENDIF
015400020314     C*
015500020314     C                   EXSR      $LOADSFL
015600020314     C*
015700020314    1C                   ENDDO
015800020208    ***
015900020208     C                   ENDSR
016000020208   S***S
016100020208     C     $LOADSFL      BEGSR
016200020208    ***
016300020208     C                   MOVE      *ON           *IN25
016400020208    ***
016500020314     C                   EVAL      SFMSG = HMSG
016600020208     C                   MOVE      *BLANKS       SEL01
016700020208     C*
016800020208     C                   ADD       1             RRT
016900020208     C                   IF        @1STLOOP = '0'
017000020208     C                   Z-ADD     RRT           SFLPOS
017100020208     C                   MOVE      '1'           @1STLOOP
017200020208     C                   ENDIF
017300020208     C*
017400020208     C                   WRITE     GBSSFL
017500020208    ***
017600020208     C                   ENDSR
017700991124   S***S
017800991124     C     $DISPLAY      BEGSR
017900991124    ***
018000000211     C                   WRITE     GBSREC
018100000211     C                   EXFMT     GBSCTL
018200991124    ***
018300991124     C                   ENDSR
018400000113   S***S
