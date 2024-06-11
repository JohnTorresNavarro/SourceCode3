000100001130     F*********************************************************************
000200150217     F* FI083      - BROKER COMMISSION INQUIRY                            *
000300001130     F*                                                                   *
000400001206     F* WROTE BY      STEPHEN KING 12/06/2000                             *
000500001130     F*               INNOVATIVE OUTSOURCING  2000                        *
000600001130     F*                                                                   *
000700001130     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
000800001206     F*            BROKER COMMISSION FILE                                 *
000900001130     F*                                                                   *
001000001130     F*********************************************************************
001100001130     F* MODIFICATION HISTORY                                              *
001200001130     F* ### UUU CCYYMMDD X-->                                             *
001300001206     F* 000 SSK 20001206 ORIGINAL SOURCE                                  *
001400050815     F* 08/15/05 dlk - add % of prem field                                *
001500090102     F* 002 SSK 20090102 ADD DATES                                        *
001600150217     F* 003 SBT 20150217 No source for this program; convert maint pgm    *
001700050815     F*                                                                   *
001800001130     F*********************************************************************
001900150217     FBRKRCOM1  IF   E           K DISK
002000090102     FBRKRCOM0  UF A E             DISK    RENAME(RBRKRCOM:RRNFMT)
002100010122     FBRKRCOM3  IF   E           K DISK    RENAME(RBRKRCOM:B3) PREFIX(Z:1)
002200090102     F                                     INFDS(IODBFD)
002300010118     FCARMKSZ3  IF   E           K DISK
002400150217     FFI083D    CF   E             WORKSTN INFDS(WSDS)
002500010118     F                                     SFILE(IO01S:RRT)
002600001130     ***
002700090102     D IODBFD        E DS                  EXTNAME(IODBFD)
002800090102     D #RRN                  397    400B 0
002900090102    ***
003000001130     D WSDS            DS
003100001130     D  FKEY                 369    369A
003200001130     ***
003300001130     D  F1             C                   CONST(X'31')
003400001130     D  F2             C                   CONST(X'32')
003500001130     D  F3             C                   CONST(X'33')
003600001130     D  F4             C                   CONST(X'34')
003700001130     D  F5             C                   CONST(X'35')
003800001130     D  F6             C                   CONST(X'36')
003900001130     D  F7             C                   CONST(X'37')
004000001130     D  F8             C                   CONST(X'38')
004100001130     D  F9             C                   CONST(X'39')
004200001130     D  F10            C                   CONST(X'3A')
004300001130     D  F11            C                   CONST(X'3B')
004400001130     D  F12            C                   CONST(X'3C')
004500001130     D  F13            C                   CONST(X'B1')
004600001130     D  F14            C                   CONST(X'B2')
004700001130     D  F15            C                   CONST(X'B3')
004800001130     D  F16            C                   CONST(X'B4')
004900001130     D  F17            C                   CONST(X'B5')
005000001130     D  F18            C                   CONST(X'B6')
005100001130     D  F19            C                   CONST(X'B7')
005200001130     D  F20            C                   CONST(X'B8')
005300001130     D  F21            C                   CONST(X'B9')
005400001130     D  F22            C                   CONST(X'BA')
005500001130     D  F23            C                   CONST(X'BB')
005600001130     D  F24            C                   CONST(X'BC')
005700001206    ***
005800010118     D @STEP           S              5A   INZ('STEP1')
005900010118     D #ISO            S               D   DATFMT(*ISO)
006000010118     D #USA            S               D   DATFMT(*USA)
006100090102     D #XSX            S              8S 0
006200010118     ***
006300010118     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
006400010118     D                UDS
006500010118     D  TITLE                201    240
006600010118     ***
006700010118     C                   DOU       @STEP = 'EXIT'
006800010118     C     @STEP         CASEQ     'STEP1'       $STEP1
006900010118     C     @STEP         CASEQ     'STEP2'       $STEP2
007000010118     C     @STEP         CASEQ     'STEP3'       $STEP3
007100010118     C     @STEP         CASEQ     'STEP4'       $STEP4
007200010118     C                   ENDCS
007300010118     C                   ENDDO
007400010118     C*
007500010118     C                   MOVE      *ON           *INLR
007600010118   S***S
007700010118     C     *INZSR        BEGSR
007800010118     C*
007900010118     C     *ENTRY        PLIST
008000010118     C                   PARM                    @3CARR            3
008100010118     C*
008200010118     C     UNVKEY        KLIST
008300010118     C                   KFLD                    I_CARR
008400010118     C                   KFLD                    @SZCD             5
008500010118     C*
008600010118     C                   ENDSR
008700010118   S***S
008800010118     C     $STEP1        BEGSR
008900010118     C*
009000010118     C                   MOVEL     @3CARR        I_CARR
009100010118     C                   MOVE      *BLANKS       R1MSG
009200010118     C* CLEAR SFL
009300010118     C                   MOVEA     '011'         *IN(28)
009400010118     C                   WRITE     IO01C
009500010118     C                   MOVEA     '010'         *IN(28)
009600010118     C* SFL BUILD
009700010118     C                   Z-ADD     *ZERO         RRT               3 0
009800010118     C                   MOVE      '0'           @1STLOOP          1
009900010118     C*
010000010122     C     I_CARR        SETLL     B3
010100010122    1C                   DOU       %EOF(BRKRCOM3)
010200010122     C     I_CARR        READE     B3
010300010122    2C                   IF        NOT %EOF(BRKRCOM3)
010400010118     C*
010500010118     C                   CLEAR                   IO01S
010600010118     C                   MOVE      *ON           *IN28
010700010118     C                   MOVE      *OFF          *IN31
010800010118     C*
010900010122     C                   MOVEL(P)  ZCSZCD        @SZCD
011000090102     C     UNVKEY        CHAIN     RCARMKSZ
011100010118     C                   IF        %FOUND(CARMKSZ3)
011200010118     C                   Z-ADD     CZFRSZ        SFFRSZ
011300010118     C                   Z-ADD     CZTOSZ        SFTOSZ
011400010118     C                   ELSE
011500010118     C                   MOVE      *ZEROS        SFFRSZ
011600010118     C                   MOVE      *ZEROS        SFTOSZ
011700010118     C                   ENDIF
011800010118     C*
011900010122     C                   MOVEL(P)  ZCSZCD        SFSZCD
012000010122     C                   Z-ADD     ZCAMNT        SFAMNT
012100050815     C                   Z-ADD     zcpop         sfpop
012200010122     C                   Z-ADD     ZCSEQ         SFSEQ
012300090102     C*
012400090102     C                   MOVE      ZCFROMDT      #XSX
012500090102     C                   EXSR      $ISOUSA
012600090102     C                   MOVE      #XSX          SFFROMDT
012700090102     C*
012800090102     C                   MOVE      ZCTODATE      #XSX
012900090102     C                   EXSR      $ISOUSA
013000090102     C                   MOVE      #XSX          SFTODATE
013100090102     C*
013200090102     C                   Z-ADD     #RRN          HK
013300010118     C*
013400010118     C                   ADD       1             RRT
013500010118    3C                   IF        @1STLOOP = '0'
013600010118     C                   Z-ADD     RRT           SFLRRN
013700010118     C                   MOVE      '1'           @1STLOOP
013800010118    3C                   ENDIF
013900010118     C*
014000010118     C                   WRITE     IO01S
014100010118     C*
014200010118    2C                   ENDIF
014300010118     C*
014400010118    1C                   ENDDO
014500010118     C*
014600010118     C                   MOVEL(P)  'STEP2'       @STEP
014700010118     C                   MOVE      *BLANKS       R1MSG
014800010118     C*
014900010118     C                   ENDSR
015000010118   S***S
015100010118     C     $ISOUSA       BEGSR
015200010118    ***
015300090102    1C                   IF        #XSX <> 0
015400090102     C     *ISO          TEST (DE)               #XSX
015500010118    2C                   IF        NOT %ERROR
015600090102     C                   MOVE      #XSX          #ISO
015700010118     C                   MOVE      #ISO          #USA
015800090102     C                   MOVE      #USA          #XSX
015900010118    2C                   ELSE
016000090102     C                   MOVE      *ZEROS        #XSX
016100010118    2C                   ENDIF
016200010118    1C                   ENDIF
016300010118    ***
016400010118     C                   ENDSR
016500010118   S***S
016600010118     C     $STEP2        BEGSR
016700010118    ***
016800010118     C                   EXSR      $DISPLAY
016900010118     C                   MOVE      *BLANKS       R1MSG
017000010118     C                   ADD       1             #ECNT             2 0
017100010118    ***
017200010118     C                   IF        FKEY = F1
017300010118     C                   MOVEL(P)  'EXIT'        @STEP
017400010118     C                   LEAVESR
017500010118     C                   ENDIF
017600010118    ***
017700010126     C                   IF        RRT > 0
017800010118     C                   EXSR      $CHKSELC
017900010126     C                   ENDIF
018000010118    ***
018100010122    *C*                  IF        #ECNT >= 3
018200010122     C                   MOVEL(P)  'STEP1'       @STEP
018300010122    *C*                  LEAVESR
018400010122    *C*                  ENDIF
018500010118    ***
018600010118     C                   ENDSR
018700010118   S***S
018800010118     C* DISPLAY THE SCREEN
018900010118    ***
019000010118     C     $DISPLAY      BEGSR
019100010118    ***
019200010118     C                   WRITE     IO01R
019300010118     C                   EXFMT     IO01C
019400010118     C*
019500010118     C                   MOVE      *BLANKS       R1MSG
019600010118    ***
019700010118     C                   ENDSR
019800010118    ***
019900010118   S***S
020000010118     C     $STEP3        BEGSR
020100010118    ***
020200010118     C                   MOVE      *BLANKS       R2MSG
020300010118    ***
020400010118     C                   MOVE      *BLANKS       R2SZCD
020500090102     C                   MOVE      *ZEROS        R2FROMDT
020600090102     C                   MOVE      *ZEROS        R2TODATE
020700010118     C                   MOVE      *ZEROS        R2FRSZ
020800010118     C                   MOVE      *ZEROS        R2TOSZ
020900010118     C                   MOVE      *ZEROS        R2AMNT
021000050815     C                   MOVE      *ZEROS        r2pop
021100010122     C                   MOVE      *ZEROS        R2SEQ
021200010118    ***
021300010118     C                   MOVE      'STEP4'       @STEP
021400010118    ***
021500010118     C                   ENDSR
021600010118   S***S
021700010118     C     $STEP4        BEGSR
021800010118    ***
021900010118     C                   EXFMT     IO02R
022000010118     C                   MOVE      *BLANKS       R2MSG
022100010118    ***
022200010118    1C                   IF        FKEY = F1
022300010118     C                   MOVEL(P)  'STEP1'       @STEP
022400010118     C                   LEAVESR
022500010118    1C                   ENDIF
022600010118    ***
022700010118     C* F4 = MARKET SIZES INQUIRY
022800010118    1C                   IF        FKEY = F4
022900010118     C                   MOVEL(P)  I_CARR        @P8               8
023000150121     C                   CALL      'FM005CL32'
023100010118     C                   PARM                    @P8
023200010118     C                   MOVE      @P8           @5                5
023300010118    2C                   IF        @5 = '*LR '
023400150217     C****               MOVEL(P)  MSG(3)        R2MSG
023500010118     C                   LEAVESR
023600010118    2C                   ELSE
023700010118     C                   MOVEL(P)  @5            R2SZCD
023800010118     C                   MOVEL(P)  @5            @SZCD
023900090102     C     UNVKEY        CHAIN     RCARMKSZ
024000010118    3C                   IF        %FOUND(CARMKSZ3)
024100010118     C                   Z-ADD     CZFRSZ        R2FRSZ
024200010118     C                   Z-ADD     CZTOSZ        R2TOSZ
024300010118    3C                   ELSE
024400010118     C                   MOVE      *ZEROS        R2FRSZ
024500010118     C                   MOVE      *ZEROS        R2TOSZ
024600010118    3C                   ENDIF
024700010118    2C                   ENDIF
024800010118     C                   LEAVESR
024900010118    1C                   ENDIF
025000010118    ***
025100010118     C                   ENDSR
025200010118   S***S
025300010118     C* CHECK SUBFILE SELECTION
025400010118    ***
025500010118     C     $CHKSELC      BEGSR
025600010118    ***
025700150217     C                   DOU       %EOF(FI083D)
025800010118     C                   READC     IO01S
025900150217     C                   IF        NOT %EOF(FI083D) AND SEL <> *BLANKS
026000010118     C*
026100010118     C                   SELECT
026200010118     C                   WHEN      SEL = 'C'
026300010118     C                   EXSR      $CHGCTL
026400010118     C                   ENDSL
026500010118     C*
026600010118     C                   IF        R1MSG <> *BLANKS
026700010118     C                   LEAVESR
026800010118     C                   ENDIF
026900010118     C*
027000010118     C                   MOVE      *BLANKS       SEL
027100010118     C                   UPDATE    IO01S
027200010118     C*
027300010118     C                   ENDIF
027400010118     C                   ENDDO
027500010118    ***
027600010118     C                   ENDSR
027700010118   S***S
027800010118     C* CHANGE CONTROL ROUTINE
027900010118    ***
028000010118     C     $CHGCTL       BEGSR
028100010118    ***
028200150217     C*****              MOVE      'I'           @@A                            ACTION TYPE
028300010118     C                   MOVE      *OFF          *IN30
028400090102     C                   EVAL      HKEY = HK
028500010118     C                   EXSR      $LOADNLOCK
028600010118     C*
028700010118     C                   IF        R1MSG <> *BLANKS
028800010118     C                   LEAVESR
028900010118     C                   ENDIF
029000010118    ***
029100010118     C                   MOVE      '0'           @@E               1
029200010118     C                   DOU       @@E = '1'
029300010118     C*
029400010118     C                   EXSR      $STEP4
029500010118     C*
029600010118     C                   IF        @STEP = 'STEP1'
029700010118     C                   MOVE      @@STP         @STEP
029800010118     C                   MOVE      '1'           @@E
029900010118     C                   LEAVESR
030000010118     C                   ENDIF
030100010118     C*
030200010118     C                   ENDDO
030300010118    ***
030400010118     C                   ENDSR
030500010118   S***S
030600010118     C* LOAD SCREEN 2 W/O LOCKING REC
030700010118    ***
030800010118     C     $LOADNLOCK    BEGSR
030900010118    ***
031000010118     C                   MOVEL(P)  @STEP         @@STP             5
031100010118     C                   EXSR      $STEP3
031200010118     C                   MOVEL(P)  @@STP         @STEP
031300010118    ***
031400010118     C                   MOVEL     SFSZCD        R2SZCD
031500010118     C                   Z-ADD     SFFRSZ        R2FRSZ
031600010118     C                   Z-ADD     SFTOSZ        R2TOSZ
031700090102     C                   Z-ADD     SFFROMDT      R2FROMDT
031800090102     C                   Z-ADD     SFTODATE      R2TODATE
031900010118     C                   Z-ADD     SFAMNT        R2AMNT
032000050815     C                   Z-ADD     sfpop         r2pop
032100010118     C                   MOVEL(P)  SFSZCD        @SZCD
032200010122     C                   Z-ADD     SFSEQ         R2SEQ
032300090102     C     HK            CHAIN     RRNFMT
032400010118    ***
032500010118     C                   ENDSR
032600010118   S***S
032700010118123456*8901234567890123456789012345678901234567890
032800010118      *  11111111112222222222333333333344444444445
