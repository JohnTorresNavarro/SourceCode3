000100110701     F*-------------------------------------------------------------------------
000200110701     F* FM105R2    GROUP BENEFIT SERVICES, INC SOFTWARE 2011
000300110701     F*            FM10* SALESMAN MASTER APPLICATION
000400110701     F*            WRITTEN BY - S.S.K.
000500110701     F*            DATE - 07/2011
000600110701     F*  DESCRIPTION - PROMPT
000700110701     F*  INDICATOR USAGE:
000800110701     F*    01 = EXIT FROM INITIAL SCREEN
000900110701     F*    25 = SFLDSP
001000110701     F*    26 = SFL DSP CTL
001100110701     F*    27 = SFL CLR
001200110701     F*
001300110701     F*-------------------------------------------------------------------------
001400110701     ** MODIFICATION HISTORY                                              **
001500110701     ** ###  UUU  MMDDCCYY  X---->                                        **
001600110701     ** 000  SSK  07012011  ORIGINAL SOURCE                               **
001700110701     **                                                                   **
001800110701     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900110701     FFM105D2   CF   E             WORKSTN INFDS(WSDS) SFILE(S03SFL:RR3)
002000110728     FRMGRMST5  IF   E           K DISK
002100110701   X***X
002200110701     D WSDS            DS
002300110701     D  FKEY                 369    369A
002400110701    ***
002500110701     D  F1             C                   CONST(X'31')
002600110701     D  F2             C                   CONST(X'32')
002700110701     D  F3             C                   CONST(X'33')
002800110701     D  F4             C                   CONST(X'34')
002900110701     D  F5             C                   CONST(X'35')
003000110701     D  F6             C                   CONST(X'36')
003100110701     D  F7             C                   CONST(X'37')
003200110701     D  F8             C                   CONST(X'38')
003300110701     D  F9             C                   CONST(X'39')
003400110701     D  F10            C                   CONST(X'3A')
003500110701     D  F11            C                   CONST(X'3B')
003600110701     D  F12            C                   CONST(X'3C')
003700110701     D  F13            C                   CONST(X'B1')
003800110701     D  F14            C                   CONST(X'B2')
003900110701     D  F15            C                   CONST(X'B3')
004000110701     D  F16            C                   CONST(X'B4')
004100110701     D  F17            C                   CONST(X'B5')
004200110701     D  F18            C                   CONST(X'B6')
004300110701     D  F19            C                   CONST(X'B7')
004400110701     D  F20            C                   CONST(X'B8')
004500110701     D  F21            C                   CONST(X'B9')
004600110701     D  F22            C                   CONST(X'BA')
004700110701     D  F23            C                   CONST(X'BB')
004800110701     D  F24            C                   CONST(X'BC')
004900110701    ***
005000110701     D #ISO            S               D   DATFMT(*ISO)
005100110701     D #USA            S               D   DATFMT(*USA)
005200110701     D @STEP           S              5A
005300110701     D P@4             S              4A
005400110701    ***
005500110701     D KF@NAME         S                   LIKE(RMNAME)
005600110701     D @HLNAME         S                   LIKE(C3NAME)
005700110701     D @40             S                   LIKE(C3NAME)
005800110701     D @EMSG           S             70A
005900110701   X***X
006000110701    1C                   DOU       @STEP = 'LEAVE'
006100110701    2C     @STEP         CASEQ     'PREP1'       $PREP1
006200110701    2C     @STEP         CASEQ     'STEP1'       $STEP1
006300110701    2C                   ENDCS
006400110701    1C                   ENDDO
006500110701    ***
006600110701     C                   MOVE      *ON           *INLR
006700110701   S***S
006800110701     C     *INZSR        BEGSR
006900110701    ***
007000110701     C     *ENTRY        PLIST
007100110701     C                   PARM                    P@4
007200110701    ***
007300110701     C                   EVAL      @STEP = 'PREP1'
007400110701    ***
007500110701     C                   ENDSR
007600110701   S***S
007700110701     C     $PREP1        BEGSR
007800110701    ***
007900110701     C                   MOVE      *ZEROS        RR3               4 0
008000110701     C                   MOVE      *ZEROS        #CNTREC           3 0
008100110701    ***
008200110701     C                   EXSR      $CLEAR
008300110701     C                   MOVEL(P)  '*'           C3NAME
008400110701     C                   MOVEL(P)  C3NAME        @HLNAME
008500110701    ***
008600110701     C                   EXSR      $BUILD
008700110701     C                   MOVEL(P)  'STEP1'       @STEP
008800110701    ***
008900110701     C                   ENDSR
009000110701   S***S
009100110701     C     $STEP1        BEGSR
009200110701    ***
009300110701     C                   EXSR      $DISPLAY
009400110701    ***
009500110701    1C                   IF        FKEY = F1
009600110701     C                   MOVEL(P)  'LEAVE'       @STEP
009700110701     C                   LEAVESR
009800110701    1C                   ENDIF
009900110701    ***
010000110701    1C                   IF        @HLNAME <> C3NAME AND C3NAME <> *BLANKS
010100110701     C                   EXSR      $CLEAR
010200110701     C                   EXSR      $BUILD
010300110701     C                   MOVEL(P)  C3NAME        @HLNAME
010400110701     C                   LEAVESR
010500110701    1C                   ENDIF
010600110701    ***
010700110701     C                   EXSR      $CHKSELC
010800110701    ***
010900110701     C                   ENDSR
011000110701   S***S
011100110701     C* INITIALIZE THE SUBFILE
011200110701    ***
011300110701     C     $CLEAR        BEGSR
011400110701    ***
011500110701     C                   MOVEA     '011'         *IN(25)
011600110701     C                   WRITE     S03CTL
011700110701     C                   MOVEA     '010'         *IN(25)
011800110701     C                   Z-ADD     *ZERO         RR3
011900110701    ***
012000110701     C                   ENDSR
012100110701   S***S
012200110701     C* DISPLAY THE SCREEN
012300110701    ***
012400110701     C     $DISPLAY      BEGSR
012500110701    ***
012600110701     C                   WRITE     S03REC
012700110701     C                   EXFMT     S03CTL
012800110701    ***
012900110701     C                   ENDSR
013000110701    ***
013100110701   S***S
013200110701     C* BUILD SUBFILE CONTROL ROUTINE
013300110701    ***
013400110701     C     $BUILD        BEGSR
013500110701    ***
013600110701     C                   MOVE      *ZEROS        #CNTREC
013700110701     C                   MOVE      '0'           @1STLOOP          1
013800110701     C                   MOVEA     '00'          *IN(33)
013900110701     C                   MOVE      '0'           @SFLOOP           1
014000110701     C                   EVAL      KF@NAME = C3NAME
014100110701    ***
014200110701     C     KF@NAME       SETLL     RMGRMSTR
014300110728     C                   DOU       %EOF(RMGRMST5) OR @SFLOOP = '1'
014400110701     C                   READ      RMGRMSTR
014500110728     C                   IF        NOT %EOF(RMGRMST5)
014600110701     C                   EXSR      $LOADSFL
014700110701     C                   ENDIF
014800110701     C                   ENDDO
014900110701    ***
015000110728     C                   IF        %EOF(RMGRMST5)
015100110701     C                   MOVE      *OFF          *IN29
015200110701     C                   MOVE      *BLANKS       @LRNAME          40
015300110701     C                   ELSE
015400110701     C                   MOVE      *ON           *IN29
015500110701     C                   ENDIF
015600110701    ***
015700110701     C                   ENDSR
015800110701   S***S
015900110701     C* LOAD SUBFILE RECORDS
016000110701    ***
016100110701     C     $LOADSFL      BEGSR
016200110701    ***
016300110701     C                   MOVE      *ON           *IN25
016400110701     C                   MOVE      *BLANKS       SEL03
016500110701     C                   EVAL      S3RMGR = RMCODE
016600110701     C                   MOVEL(P)  RMNAME        D_RMGR
016700110701     C*
016800110701     C                   ADD       1             RR3
016900110701     C*
017000110701     C                   IF        @1STLOOP = '0'
017100110701     C                   Z-ADD     RR3           SFLPOS
017200110701     C                   MOVE      '1'           @1STLOOP
017300110701     C                   ENDIF
017400110701     C*
017500110701     C                   WRITE     S03SFL
017600110701     C*
017700110701     C                   ADD       1             #CNTREC
017800110728     C                   IF        #CNTREC = 140
017900110701     C                   MOVE      '1'           @SFLOOP
018000110701     C                   ENDIF
018100110701    ***
018200110701     C                   ENDSR
018300110701   S***S
018400110701     C* CHECK SUBFILE SELECTION
018500110701    ***
018600110701     C     $CHKSELC      BEGSR
018700110701    ***
018800110701     C                   MOVE      *OFF          *IN36
018900110701     C*
019000110701     C                   DOU       %EOF(FM105D2)
019100110701     C                   READC     S03SFL
019200110701     C                   IF        NOT %EOF(FM105D2) AND SEL03 <> *BLANKS
019300110701     C                   MOVEL(P)  S3RMGR        P@4
019400110701     C                   MOVEL(P)  'LEAVE'       @STEP
019500110701     C                   LEAVESR
019600110701     C                   ENDIF
019700110701     C                   ENDDO
019800110701    ***
019900110701     C                   ENDSR
020000110701   S***S
020100110701     C* ROLL CONTROL
020200110701    ***
020300110701    *C*    $RELOAD       BEGSR
020400110701    *C*
020500110701    *C*                  MOVEL(P)  C3NAME        @40
020600110701    *C*                  MOVEL(P)  @LRNAME       C3NAME
020700110701    *C*
020800110701    *C*                  EXSR      $BUILD
020900110701    *C*
021000110701    *C*                  MOVEL(P)  @40           C3NAME
021100110701    ***
021200110701    *C*                  ENDSR
