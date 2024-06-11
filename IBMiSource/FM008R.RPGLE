000100001222     F*-------------------------------------------------------------------------
000200010103     F* FM008      INNOVATIVE OUTSOURCING SOFTWARE 2001
000300001222     F*            WRITTEN BY - S.S.K.
000400010103     F*            DATE - 01/01
000500010103     F*  DESCRIPTION - DISPLAY ACCOUNT RECORDS FROM THE ACCOUNT MASTER FILE
000600001222     F*  INDICATOR USAGE:
000700001222     F*    03 = EXIT FROM INITIAL SCREEN
000800001222     F*    25 = SFLDSP
000900001222     F*    26 = SFL DSP CTL
001000001222     F*    27 = SFL CLR
001100001222     F*
001200001222     F*-------------------------------------------------------------------------
001300001222     ** MODIFICATION HISTORY                                              **
001400001222     ** ###  UUU  MMDDCCYY  X---->                                        **
001500010103     ** 000  SSK  01032001  ORIGINAL SOURCE                               **
001600001222     **                                                                   **
001700001222     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800010103     FACCNM2    IF   E           K DISK
001900010103     FFM008D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002000001222   X***X
002100001222     D                 DS
002200010103     D @KEY                    1     40A
002300001222     D @K5                     1      5A
002400001222    ***
002500001222     D WSDS            DS
002600001222     D  FKEY                 369    369A
002700001222    ***
002800001222     D  F1             C                   CONST(X'31')
002900001222     D  F2             C                   CONST(X'32')
003000001222     D  F3             C                   CONST(X'33')
003100001222     D  F4             C                   CONST(X'34')
003200001222     D  F5             C                   CONST(X'35')
003300001222     D  F6             C                   CONST(X'36')
003400001222     D  F7             C                   CONST(X'37')
003500001222     D  F8             C                   CONST(X'38')
003600001222     D  F9             C                   CONST(X'39')
003700001222     D  F10            C                   CONST(X'3A')
003800001222     D  F11            C                   CONST(X'3B')
003900001222     D  F12            C                   CONST(X'3C')
004000001222     D  F13            C                   CONST(X'B1')
004100001222     D  F14            C                   CONST(X'B2')
004200001222     D  F15            C                   CONST(X'B3')
004300001222     D  F16            C                   CONST(X'B4')
004400001222     D  F17            C                   CONST(X'B5')
004500001222     D  F18            C                   CONST(X'B6')
004600001222     D  F19            C                   CONST(X'B7')
004700001222     D  F20            C                   CONST(X'B8')
004800001222     D  F21            C                   CONST(X'B9')
004900001222     D  F22            C                   CONST(X'BA')
005000001222     D  F23            C                   CONST(X'BB')
005100001222     D  F24            C                   CONST(X'BC')
005200001222    ***
005300001222     D                 DS
005400010103     D @PDS                    1     10A
005500001222     D @TR                     1      3A
005600001222     D #TR                     1      3S 0
005700001222     D @SU                     4      6A
005800010103     D #SU                     4      6S 0
005900010103     D @AC                     7     10A
006000001222   X***X
006100001222     C* MAINLINE
006200001222    ***
006300001222     C                   EXSR      ONCE
006400001222     C*
006500001222     C                   DOU       @EXIT = '1'
006600001222     C*
006700001222     C                   IF        FKEY = F1
006800001222     C                   MOVE      '1'           @EXIT
006900010103     C                   MOVEL(P)  '*LR'         @AC
007000001222     C                   ELSE
007100001222     C                   EXSR      $CHKSEL
007200001222     C                   ENDIF
007300001222     C*
007400001222     C                   IF        @EXIT = '0'
007500001222     C*
007600001222     C                   IF        PRTKEY <> @K5
007700001222     C                   MOVEL(P)  PRTKEY        @K5
007800001222     C                   EXSR      $BUILDSFL
007900001222     C                   ENDIF
008000001222     C*
008100001222     C                   WRITE     JUNK
008200001222     C                   EXFMT     WDWCTL
008300001222     C*
008400001222     C                   ENDIF
008500001222     C*
008600001222     C                   ENDDO
008700001222     C*
008800001222     C                   MOVEL(P)  @PDS          @PARM
008900001222     C                   MOVE      *ON           *INLR
009000001222     C                   RETURN
009100001222   S***S
009200001222     C* ONETIME ROUTINE
009300001222    ***
009400001222     C     ONCE          BEGSR
009500001222    ***
009600001222     C     *ENTRY        PLIST
009700010103     C                   PARM                    @PARM            10
009800001222     C                   MOVEL(P)  @PARM         @PDS
009900001222    ***
010000010103     C     SKEY          KLIST
010100010103     C                   KFLD                    #TR
010200010103     C                   KFLD                    #SU
010300010103     C                   KFLD                    @KEY             40
010400010103    ***
010500010103     C     @@KEY         KLIST
010600010103     C                   KFLD                    #TR
010700010103     C                   KFLD                    #SU
010800001222    ***
010900010103     C                   MOVEL(P)  @TR           CTRST
011000010103     C                   MOVEL(P)  @SU           CSUB
011100001222     C                   MOVE      '0'           @EXIT             1
011200001222    ***
011300001222     C                   MOVEL     'A'           @K5
011400001222     C                   MOVEL     'A'           PRTKEY
011500001222     C                   EXSR      $BUILDSFL
011600001222    ***
011700001222     C                   WRITE     JUNK
011800001222     C                   EXFMT     WDWCTL
011900001222    ***
012000001222     C                   ENDSR
012100001222   S***S
012200001222     C     $CHKSEL       BEGSR
012300001222     C*
012400001222     C                   MOVE      *OFF          *IN33
012500001222     C                   DOU       *IN33 = *ON
012600001222     C                   READC     POPUP                                  33
012700001222     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
012800001222     C                   MOVE      *ON           *IN33
012900010103     C                   MOVEL(P)  SFACCT        @AC
013000001222     C                   MOVE      '1'           @EXIT
013100001222     C                   ENDIF
013200001222     C                   ENDDO
013300001222     C*
013400001222     C                   ENDSR
013500001222   S***S
013600001222     C     $BUILDSFL     BEGSR
013700001222    ***
013800001222     C                   MOVE      *ZEROS        RRT               4 0
013900001222    ***
014000001222     C                   MOVEA     '011'         *IN(25)
014100001222     C                   WRITE     WDWCTL
014200001222     C                   MOVEA     '010'         *IN(25)
014300001222     C*
014400010322     C                   MOVE      *ZEROS        #CNTREC           3 0
014500001222     C*
014600010103     C     SKEY          SETLL     ACCMSR
014700010103     C                   DOU       %EOF(ACCNM2) OR #CNTREC = 600
014800010103     C     @@KEY         READE     ACCMSR
014900010103     C                   IF        NOT %EOF(ACCNM2)
015000001222     C                   MOVE      *ON           *IN25
015100001222     C                   ADD       1             RRT
015200001222     C                   IF        RRT = 1
015300001222     C                   Z-ADD     RRT           SFLPOS
015400001222     C                   ENDIF
015500001222     C                   MOVE      *BLANKS       SEL
015600010103     C                   MOVE      ACACCT        SFACCT
015700010103     C                   MOVEL(P)  ACNAM1        SFNAM1
015800010103     C                   MOVEL(P)  ACNAM2        SFNAM2
015900010103     C                   MOVEL(P)  ACDLTD        SFDLTD
016000001222     C                   WRITE     POPUP
016100001222     C                   ADD       1             #CNTREC
016200001222     C                   ENDIF
016300001222     C                   ENDDO
016400001222    ***
016500020221     C                   IF        RRT > 6
016600020221     C                   EVAL      *IN91 = *ON
016700020221     C                   ENDIF
016800020221    ***
016900001222     C                   ENDSR
