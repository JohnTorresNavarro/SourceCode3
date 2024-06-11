000100001130     F*********************************************************************
000200001206     F* FM083      - BROKER COMMISSION MAINTENANCE                        *
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
001501161229     F* 12/29/16 dlk - change search to find market size by comm from date*
001600050815     F*                                                                   *
001700001130     F*********************************************************************
001800001206     FBRKRCOM1  UF A E           K DISK
001900090102     FBRKRCOM0  UF A E             DISK    RENAME(RBRKRCOM:RRNFMT)
002000010122     FBRKRCOM3  IF   E           K DISK    RENAME(RBRKRCOM:B3) PREFIX(Z:1)
002100090102     F                                     INFDS(IODBFD)
002200010118     FCARMKSZ3  IF   E           K DISK
002300001206     FFM083D    CF   E             WORKSTN INFDS(WSDS)
002400010118     F                                     SFILE(IO01S:RRT)
002500001130     ***
002600090102     D IODBFD        E DS                  EXTNAME(IODBFD)
002700090102     D #RRN                  397    400B 0
002800090102    ***
002900001130     D WSDS            DS
003000001130     D  FKEY                 369    369A
003100001130     ***
003200001130     D  F1             C                   CONST(X'31')
003300001130     D  F2             C                   CONST(X'32')
003400001130     D  F3             C                   CONST(X'33')
003500001130     D  F4             C                   CONST(X'34')
003600001130     D  F5             C                   CONST(X'35')
003700001130     D  F6             C                   CONST(X'36')
003800001130     D  F7             C                   CONST(X'37')
003900001130     D  F8             C                   CONST(X'38')
004000001130     D  F9             C                   CONST(X'39')
004100001130     D  F10            C                   CONST(X'3A')
004200001130     D  F11            C                   CONST(X'3B')
004300001130     D  F12            C                   CONST(X'3C')
004400001130     D  F13            C                   CONST(X'B1')
004500001130     D  F14            C                   CONST(X'B2')
004600001130     D  F15            C                   CONST(X'B3')
004700001130     D  F16            C                   CONST(X'B4')
004800001130     D  F17            C                   CONST(X'B5')
004900001130     D  F18            C                   CONST(X'B6')
005000001130     D  F19            C                   CONST(X'B7')
005100001130     D  F20            C                   CONST(X'B8')
005200001130     D  F21            C                   CONST(X'B9')
005300001130     D  F22            C                   CONST(X'BA')
005400001130     D  F23            C                   CONST(X'BB')
005500001130     D  F24            C                   CONST(X'BC')
005600001206    ***
005700050816     D MSG             S             50A   DIM(5) CTDATA PERRCD(1)
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
010801161229      *
010802161229      * get market size range for this "from date"
010803161229      *
010804161229     C                   MOVE      *ZEROS        SFFRSZ
010805161229     C                   MOVE      *ZEROS        SFTOSZ
010900010122     C                   MOVEL(P)  ZCSZCD        @SZCD
011000161229     C     UNVKEY        setll     carmksz3
011001161229     c                   dou       %eof(carmksz3)
011002161229     C     UNVKEY        reade     carmksz3
011100161229     C                   if        not %eof(CARMKSZ3) and
011101161229     c                             zcfromdt >= czfrdt and
011102161229     c                             (cztodt = 0 or zCFROMDT <= cztodt)
011200010118     C                   Z-ADD     CZFRSZ        SFFRSZ
011300010118     C                   Z-ADD     CZTOSZ        SFTOSZ
011301161229     c                   leave
011701161229     C                   end
011702161229     c                   enddo
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
017700010118     C                   IF        FKEY = F6
017800090105     C                   CLEAR                   RBRKRCOM
017900010118     C                   MOVEL(P)  'STEP3'       @STEP
018000010118     C                   MOVE      'A'           @@A               1
018100010118     C                   LEAVESR
018200010118     C                   ENDIF
018300010118    ***
018400010126     C                   IF        RRT > 0
018500010118     C                   EXSR      $CHKSELC
018600010126     C                   ENDIF
018700010118    ***
018800010122    *C*                  IF        #ECNT >= 3
018900010122     C                   MOVEL(P)  'STEP1'       @STEP
019000010122    *C*                  LEAVESR
019100010122    *C*                  ENDIF
019200010118    ***
019300010118     C                   ENDSR
019400010118   S***S
019500010118     C* DISPLAY THE SCREEN
019600010118    ***
019700010118     C     $DISPLAY      BEGSR
019800010118    ***
019900010118     C                   WRITE     IO01R
020000010118     C                   EXFMT     IO01C
020100010118     C*
020200010118     C                   MOVE      *BLANKS       R1MSG
020300010118    ***
020400010118     C                   ENDSR
020500010118    ***
020600010118   S***S
020700010118     C     $STEP3        BEGSR
020800010118    ***
020900010118     C                   MOVE      *BLANKS       R2MSG
021000010118    ***
021100010118     C                   MOVE      *BLANKS       R2SZCD
021200090102     C                   MOVE      *ZEROS        R2FROMDT
021300090102     C                   MOVE      *ZEROS        R2TODATE
021400010118     C                   MOVE      *ZEROS        R2FRSZ
021500010118     C                   MOVE      *ZEROS        R2TOSZ
021600010118     C                   MOVE      *ZEROS        R2AMNT
021700050815     C                   MOVE      *ZEROS        r2pop
021800010122     C                   MOVE      *ZEROS        R2SEQ
021900010118    ***
022000010118     C                   MOVE      'STEP4'       @STEP
022100010118    ***
022200010118     C                   ENDSR
022300010118   S***S
022400010118     C     $STEP4        BEGSR
022500010118    ***
022600010118     C                   EXFMT     IO02R
022700010118     C                   MOVE      *BLANKS       R2MSG
022800010118    ***
022900010118    1C                   IF        FKEY = F1
023000010118     C                   MOVEL(P)  'STEP1'       @STEP
023100010118     C                   LEAVESR
023200010118    1C                   ENDIF
023300010118    ***
023400010118     C* F4 = MARKET SIZES INQUIRY
023500010118    1C                   IF        FKEY = F4
023600010118     C                   MOVEL(P)  I_CARR        @P8               8
023700150121     C                   CALL      'FM005CL32'
023800010118     C                   PARM                    @P8
023900010118     C                   MOVE      @P8           @5                5
024000010118    2C                   IF        @5 = '*LR '
024100010118     C                   MOVEL(P)  MSG(3)        R2MSG
024200010118     C                   LEAVESR
024300010118    2C                   ELSE
024400010118     C                   MOVEL(P)  @5            R2SZCD
024500010118     C                   MOVEL(P)  @5            @SZCD
024600090102     C     UNVKEY        CHAIN     RCARMKSZ
024700010118    3C                   IF        %FOUND(CARMKSZ3)
024800010118     C                   Z-ADD     CZFRSZ        R2FRSZ
024900010118     C                   Z-ADD     CZTOSZ        R2TOSZ
025000010118    3C                   ELSE
025100010118     C                   MOVE      *ZEROS        R2FRSZ
025200010118     C                   MOVE      *ZEROS        R2TOSZ
025300010118    3C                   ENDIF
025400010118    2C                   ENDIF
025500010118     C                   LEAVESR
025600010118    1C                   ENDIF
025700010118    ***
025800010118     C                   EXSR      $VALIDATE
025900010118    ***
026000010118     C                   IF        @VCC = 'Y'
026100010118     C                   EXSR      $UPDATE
026200010118     C                   ENDIF
026300010118    ***
026400010118     C                   ENDSR
026500010118   S***S
026600010118     C* VALIDATE VALUES
026700010118    ***
026800010118     C     $VALIDATE     BEGSR
026900010118    ***
027000010118     C                   MOVE      'N'           @VCC              1
027100010118     C                   MOVE      *ZEROS        R2FRSZ
027200010118     C                   MOVE      *ZEROS        R2TOSZ
027300010118    ***
027400010118    1C                   IF        R2SZCD = *BLANKS
027500010118     C                   MOVEL(P)  MSG(1)        R2MSG
027600010118     C                   LEAVESR
027700010118    1C                   ENDIF
027800050816
027900050816    * * only allow flat fee or % of prem, not both
028000050816    1C                   IF        r2amnt <> 0 and r2pop <> 0
028100050816     C                   MOVEL(P)  MSG(4)        R2MSG
028200050816     C                   LEAVESR
028300050816    1C                   ENDIF
028400050816     C* max 100%
028500050816    1C                   IF        r2pop > 100
028600050816     C                   MOVEL(P)  MSG(5)        R2MSG
028700050816     C                   LEAVESR
028800050816    1C                   ENDIF
028900090102     **
029000090102     C                   IF        R2FROMDT = 0
029100090102     C                   EVAL      R2MSG = 'INVALID FROM DATE'
029200090102     C                   LEAVESR
029300090102     C                   ENDIF
029400090102    * *
029500090102     C     *USA          TEST(DE)                R2FROMDT
029600090102     C                   IF        %ERROR
029700090102     C                   EVAL      R2MSG = 'INVALID FROM DATE'
029800090102     C                   LEAVESR
029900090102     C                   ENDIF
030000090102    * *
030100090102     C                   MOVE      R2FROMDT      #USA
030200090102     C                   MOVE      #USA          #ISO
030300090102     C                   MOVE      #ISO          CAP#FRM           8 0
030400090102     **
030500090102     C                   IF        R2TODATE = 0
030600090102    * *
030700090102     C                   EVAL      CAP#TRM = 0
030800090102    * *
030900090102     C                   ELSE
031000090102    * *
031100090102     C     *USA          TEST(DE)                R2TODATE
031200090102     C                   IF        %ERROR
031300090102     C                   EVAL      R2MSG = 'INVALID TO DATE'
031400090102     C                   LEAVESR
031500090102     C                   ENDIF
031600090102    * *
031700090102     C                   MOVE      R2TODATE      @8                8
031800090102     C                   IF        %SUBST(@8:3:2) < '28' AND
031900090102     C                             R2FROMDT <> R2TODATE
032000090102     C                   EVAL      R2MSG = 'INVALID TO DATE'
032100090102     C                   LEAVESR
032200090102     C                   ENDIF
032300090102    * *
032400090102     C                   MOVE      R2TODATE      #USA
032500090102     C                   MOVE      #USA          #ISO
032600090102     C                   MOVE      #ISO          CAP#TRM           8 0
032700090102    * *
032800090102     C                   ENDIF
032900090102     **
033000010118     C                   MOVEL(P)  R2SZCD        @SZCD
033100090102     C     UNVKEY        CHAIN     RCARMKSZ
033200010118    1C                   IF        %FOUND(CARMKSZ3)
033300010118     C                   Z-ADD     CZFRSZ        R2FRSZ
033400010118     C                   Z-ADD     CZTOSZ        R2TOSZ
033500010118    1C                   ELSE
033600010118     C                   MOVEL(P)  MSG(1)        R2MSG
033700010118     C                   LEAVESR
033800010118    1C                   ENDIF
033900010118    ***
034000090102    *C*                  EXSR      $CHKFORACT
034100090102    1C*                  IF        @ACTIVE = 'Y'
034200090102    *C*                  MOVEL(P)  MSG(2)        R2MSG
034300090102    *C*                  LEAVESR
034400090102    1C*                  ENDIF
034500010118    ***
034600010118     C                   MOVE      'Y'           @VCC
034700010118    ***
034800010118     C                   ENDSR
034900010118   S***S
035000090102    *C*    $CHKFORACT    BEGSR
035100090102    ***
035200090102    *C*                  MOVE      'N'           @ACTIVE           1
035300090102    *C*                  MOVEL(P)  R2SZCD        @SZCD
035400090102    *C*
035500090102    *C*    UNVKEY        CHAIN(N)  RBRKRCOM
035600090102    ***
035700090102    1C*                  IF        NOT %FOUND(BRKRCOM1)
035800090102    *C*                  LEAVESR
035900090102    1C*                  ENDIF
036000090102    *C*
036100090102    1C*                  IF        %FOUND(BRKRCOM1) AND @@A = 'A'
036200090102    *C*                  MOVE      'Y'           @ACTIVE
036300090102    *C*                  LEAVESR
036400090102    1C*                  ENDIF
036500090102    *C*
036600090102    1C*                  IF        %FOUND(BRKRCOM1) AND @@A = 'C' AND
036700090102    *C*                            SFSZCD <> R2SZCD
036800090102    *C*                  MOVE      'Y'           @ACTIVE
036900090102    *C*                  LEAVESR
037000090102    1C*                  ENDIF
037100090102    *C*
037200090102    ***
037300090102    *C*                  ENDSR
037400010118   S***S
037500010118     C     $UPDATE       BEGSR
037600010118    ***
037700010118    1C                   IF        @@A = 'A'
037800010118     C                   MOVEL(P)  'STEP3'       @STEP
037900010118     C                   CLEAR                   RBRKRCOM
038000010118     C                   MOVEL     I_CARR        BCCARR
038100010118     C                   MOVEL     R2SZCD        BCSZCD
038200010118     C                   Z-ADD     R2AMNT        BCAMNT
038300050815     C                   Z-ADD     r2pop         bcpop
038400010122     C                   Z-ADD     R2SEQ         BCSEQ
038500090102     C                   MOVE      CAP#FRM       BCFROMDT
038600090102     C                   MOVE      CAP#TRM       BCTODATE
038700010118     C                   WRITE     RBRKRCOM
038800010118     C                   LEAVESR
038900010118    1C                   ENDIF
039000010118    ***
039100050815    1C                   IF        R2SZCD <> BCSZCD OR R2AMNT <> BCAMNT or
039200090102    1C                             r2pop <> bcpop OR R2FROMDT <> CAP#FRM OR
039300090102     C                             R2TODATE <> CAP#TRM
039400010118     C                   MOVEL(P)  SFSZCD        @SZCD
039500090102     C     HKEY          CHAIN     RRNFMT
039600090102    2C                   IF        %FOUND(BRKRCOM0)
039700010118     C                   MOVEL     R2SZCD        BCSZCD
039800010118     C                   Z-ADD     R2AMNT        BCAMNT
039900050815     C                   Z-ADD     r2pop         bcpop
040000010122     C                   Z-ADD     R2SEQ         BCSEQ
040100090102     C                   MOVE      CAP#FRM       BCFROMDT
040200090102     C                   MOVE      CAP#TRM       BCTODATE
040300090102     C                   UPDATE    RRNFMT
040400010118    2C                   ENDIF
040500010118    1C                   ENDIF
040600010118    ***
040700010118     C                   ENDSR
040800010118   S***S
040900010118     C* CHECK SUBFILE SELECTION
041000010118    ***
041100010118     C     $CHKSELC      BEGSR
041200010118    ***
041300010118     C                   DOU       %EOF(FM083D)
041400010118     C                   READC     IO01S
041500010118     C                   IF        NOT %EOF(FM083D) AND SEL <> *BLANKS
041600010118     C*
041700010118     C                   SELECT
041800010118     C                   WHEN      SEL = 'C'
041900010118     C                   EXSR      $CHGCTL
042000010118     C                   ENDSL
042100010118     C*
042200010118     C                   IF        R1MSG <> *BLANKS
042300010118     C                   LEAVESR
042400010118     C                   ENDIF
042500010118     C*
042600010118     C                   MOVE      *BLANKS       SEL
042700010118     C                   UPDATE    IO01S
042800010118     C*
042900010118     C                   ENDIF
043000010118     C                   ENDDO
043100010118    ***
043200010118     C                   ENDSR
043300010118   S***S
043400010118     C* CHANGE CONTROL ROUTINE
043500010118    ***
043600010118     C     $CHGCTL       BEGSR
043700010118    ***
043800010118     C                   MOVE      'C'           @@A                            ACTION TYPE
043900010118     C                   MOVE      *OFF          *IN30
044000090102     C                   EVAL      HKEY = HK
044100010118     C                   EXSR      $LOADNLOCK
044200010118     C*
044300010118     C                   IF        R1MSG <> *BLANKS
044400010118     C                   LEAVESR
044500010118     C                   ENDIF
044600010118    ***
044700010118     C                   MOVE      '0'           @@E               1
044800010118     C                   DOU       @@E = '1'
044900010118     C*
045000010118     C                   EXSR      $STEP4
045100010118     C*
045200010118     C                   IF        @STEP = 'STEP1'
045300010118     C                   MOVE      @@STP         @STEP
045400010118     C                   MOVE      '1'           @@E
045500010118     C                   LEAVESR
045600010118     C                   ENDIF
045700010118     C*
045800010118     C                   ENDDO
045900010118    ***
046000010118     C                   ENDSR
046100010118   S***S
046200010118     C* LOAD SCREEN 2 W/O LOCKING REC
046300010118    ***
046400010118     C     $LOADNLOCK    BEGSR
046500010118    ***
046600010118     C                   MOVEL(P)  @STEP         @@STP             5
046700010118     C                   EXSR      $STEP3
046800010118     C                   MOVEL(P)  @@STP         @STEP
046900010118    ***
047000010118     C                   MOVEL     SFSZCD        R2SZCD
047100010118     C                   Z-ADD     SFFRSZ        R2FRSZ
047200010118     C                   Z-ADD     SFTOSZ        R2TOSZ
047300090102     C                   Z-ADD     SFFROMDT      R2FROMDT
047400090102     C                   Z-ADD     SFTODATE      R2TODATE
047500010118     C                   Z-ADD     SFAMNT        R2AMNT
047600050815     C                   Z-ADD     sfpop         r2pop
047700010118     C                   MOVEL(P)  SFSZCD        @SZCD
047800010122     C                   Z-ADD     SFSEQ         R2SEQ
047900090102     C     HK            CHAIN     RRNFMT
048000010118    ***
048100010118     C                   ENDSR
048200010118   S***S
048300010118123456*8901234567890123456789012345678901234567890
048400010118      *  11111111112222222222333333333344444444445
048500010118** CTDATA MSG
048600010118SIZE CODE IS INVALID OR BLANK
048700010118REC EXISTS OR OPEN RECORD ALREADY EXISTS
048800010118NO SELECTION MADE
048900050816CHOOSE FLAT FEE OR % OF PREM, NOT BOTH
049000050816MAXIMUM % OF PREM IS 100%
