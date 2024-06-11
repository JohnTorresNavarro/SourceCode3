000100001206     F*********************************************************************
000200001220     F* FM082      - BONUS DRAWL MAINTENANCE                              *
000300001206     F*                                                                   *
000400001206     F* WRITTEN BY    STEPHEN KING 12/06/2000                             *
000500001206     F*               INNOVATIVE OUTSOURCING  2000                        *
000600001206     F*                                                                   *
000700001206     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
000800001220     F*            BONUS DRAWL FILE.                                      *
000801161229     F* 12/29/16 dlk - change search to find market size by comm from date*
000900001206     F*                                                                   *
001000050930     F*********************************************************************
001100050930     F* MODIFICATION HISTORY                                              *
001200050930     F* ### UUU CCYYMMDD X-->                                             *
001300050930     F* 000 SSK 20001206 ORIGINAL SOURCE                                  *
001400090102     F* 001 DLK 20050930 ADD % OF PREM                                    *
001500090102     F* 002 SSK 20090102 ACTIVATE FLAT FEE                                *
001600001206     F*                                                                   *
001700001206     F*********************************************************************
001800090102     FBONUSDR0  UF A E             DISK
001900010120     FBONUSDR3  IF   E           K DISK    RENAME(RBONUSDR:B3) PREFIX(Z:1)
002000090102     F                                     INFDS(IODBFD)
002100001220     FCARMKSZ3  IF   E           K DISK
002200001206     FFM082D    CF   E             WORKSTN INFDS(WSDS)
002300001206     F                                     SFILE(IO01S:RRT)
002400001206     ***
002500090102     D IODBFD        E DS                  EXTNAME(IODBFD)
002600090102     D #RRN                  397    400B 0
002700090102    ***
002800001206     D WSDS            DS
002900001206     D  FKEY                 369    369A
003000001206     ***
003100001206     D  F1             C                   CONST(X'31')
003200001206     D  F2             C                   CONST(X'32')
003300001206     D  F3             C                   CONST(X'33')
003400001206     D  F4             C                   CONST(X'34')
003500001206     D  F5             C                   CONST(X'35')
003600001206     D  F6             C                   CONST(X'36')
003700001206     D  F7             C                   CONST(X'37')
003800001206     D  F8             C                   CONST(X'38')
003900001206     D  F9             C                   CONST(X'39')
004000001206     D  F10            C                   CONST(X'3A')
004100001206     D  F11            C                   CONST(X'3B')
004200001206     D  F12            C                   CONST(X'3C')
004300001206     D  F13            C                   CONST(X'B1')
004400001206     D  F14            C                   CONST(X'B2')
004500001206     D  F15            C                   CONST(X'B3')
004600001206     D  F16            C                   CONST(X'B4')
004700001206     D  F17            C                   CONST(X'B5')
004800001206     D  F18            C                   CONST(X'B6')
004900001206     D  F19            C                   CONST(X'B7')
005000001206     D  F20            C                   CONST(X'B8')
005100001206     D  F21            C                   CONST(X'B9')
005200001206     D  F22            C                   CONST(X'BA')
005300001206     D  F23            C                   CONST(X'BB')
005400001206     D  F24            C                   CONST(X'BC')
005500001206     ***
005600010109     D MSG             S             50A   DIM(10) CTDATA PERRCD(1)
005700010109     D @STEP           S              5A   INZ('STEP1')
005800010109     D #ISO            S               D   DATFMT(*ISO)
005900010109     D #USA            S               D   DATFMT(*USA)
006000001206     ***
006100001206     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
006200001206     D                UDS
006300001206     D  TITLE                201    240
006400001206     ***
006500010109     C                   DOU       @STEP = 'EXIT'
006600010109     C     @STEP         CASEQ     'STEP1'       $STEP1
006700010109     C     @STEP         CASEQ     'STEP2'       $STEP2
006800010109     C     @STEP         CASEQ     'STEP3'       $STEP3
006900010109     C     @STEP         CASEQ     'STEP4'       $STEP4
007000001206     C                   ENDCS
007100001206     C                   ENDDO
007200001206     C*
007300001206     C                   MOVE      *ON           *INLR
007400001206   S***S
007500001206     C     *INZSR        BEGSR
007600001206     C*
007700001206     C     *ENTRY        PLIST
007800001206     C                   PARM                    @3CARR            3
007900010109     C*
008000010109     C     *LIKE         DEFINE    BDFRDT        #FRDT
008100010109     C     *LIKE         DEFINE    BDTODT        #TODT
008200010109     C*
008300001220     C     UNVKEY        KLIST
008400001206     C                   KFLD                    I_CARR
008500001220     C                   KFLD                    @SZCD             5
008600010109     C     BONKEY        KLIST
008700010109     C                   KFLD                    I_CARR
008800010109     C                   KFLD                    @SZCD
008900010122     C                   KFLD                    #FRDK             8 0
009000010122     C                   KFLD                    #TODK             8 0
009100001206     C*
009200001206     C                   ENDSR
009300001206   S***S
009400001206     C     $STEP1        BEGSR
009500001206     C*
009600001206     C                   MOVEL     @3CARR        I_CARR
009700001206     C                   MOVE      *BLANKS       R1MSG
009800001206     C* CLEAR SFL
009900001206     C                   MOVEA     '011'         *IN(28)
010000001206     C                   WRITE     IO01C
010100001206     C                   MOVEA     '010'         *IN(28)
010200001206     C* SFL BUILD
010300001206     C                   Z-ADD     *ZERO         RRT               3 0
010400001206     C                   MOVE      '0'           @1STLOOP          1
010500001206     C*
010600010120     C     I_CARR        SETLL     B3
010700010120    1C                   DOU       %EOF(BONUSDR3)
010800010120     C     I_CARR        READE     B3
010900010120    2C                   IF        NOT %EOF(BONUSDR3)
011000001206     C*
011100001206     C                   CLEAR                   IO01S
011200001206     C                   MOVE      *ON           *IN28
011300001206     C                   MOVE      *OFF          *IN31
011401161229      *
011402161229      * get market size range for this "from date"
011403161229      *
011404161229     C                   MOVE      *ZEROS        SFFRSZ
011405161229     C                   MOVE      *ZEROS        SFTOSZ
011500010120     C                   MOVEL(P)  ZDSZCD        @SZCD
011501161229     C     UNVKEY        setll     carmksz3
011502161229     c                   dou       %eof(carmksz3)
011503161229     C     UNVKEY        reade     carmksz3
011504161229     C                   if        not %eof(CARMKSZ3) and
011505161229     c                             zdfrdt >= czfrdt and
011506161229     c                             (cztodt = 0 or zdfrdt <= cztodt)
011507161229     C                   Z-ADD     CZFRSZ        SFFRSZ
011508161229     C                   Z-ADD     CZTOSZ        SFTOSZ
011509161229     c                   leave
011510161229     C                   end
011511161229     c                   enddo
011512161229
011513161229     C                   MOVEL(P)  ZDSZCD        SFSZCD
012500001206     C*
012600090102*****
012700050930*****C                   Z-ADD     ZDOVPP        SFOVPP
012800090102*****C                   Z-ADD     ZDOVRA        SFOVRA
012900010120     C                   Z-ADD     ZDOVPC        SFOVPC
013000010120     C                   Z-ADD     ZDSEQ         SFSEQ
013100090102     C                   Z-ADD     #RRN          HK
013200010109     C*
013300010122     C                   Z-ADD     ZDFRDT        #ISA
013400010122     C                   EXSR      $ISOUSA
013500010122     C                   Z-ADD     #ISA          SFFRDT
013600010109     C*
013700010122     C                   Z-ADD     ZDTODT        #ISA
013800010122     C                   EXSR      $ISOUSA
013900010122     C                   Z-ADD     #ISA          SFTODT
014000001206     C*
014100001206     C                   ADD       1             RRT
014200001206    3C                   IF        @1STLOOP = '0'
014300001206     C                   Z-ADD     RRT           SFLRRN
014400001206     C                   MOVE      '1'           @1STLOOP
014500001206    3C                   ENDIF
014600001206     C*
014700001206     C                   WRITE     IO01S
014800001206     C*
014900001206    2C                   ENDIF
015000001206     C*
015100001206    1C                   ENDDO
015200001206     C*
015300001206     C                   MOVEL(P)  'STEP2'       @STEP
015400001206     C                   MOVE      *BLANKS       R1MSG
015500001206     C*
015600001206     C                   ENDSR
015700010122   S***S
015800010122     C     $ISOUSA       BEGSR
015900010122     C     *ISO          TEST (DE)               #ISA
016000010122     C                   IF        %ERROR
016100010122     C                   MOVE      *ZEROS        #ISA
016200010122     C                   ELSE
016300010122     C                   MOVE      #ISA          #ISO
016400010122     C                   MOVE      #ISO          #USA
016500010122     C                   MOVE      #USA          #ISA
016600010122     C                   ENDIF
016700010122     C                   ENDSR
016800001206   S***S
016900010109     C     $STEP2        BEGSR
017000010109    ***
017100010109     C                   EXSR      $DISPLAY
017200010109     C                   MOVE      *BLANKS       R1MSG
017300010109     C                   ADD       1             #ECNT             2 0
017400010109    ***
017500010109     C                   IF        FKEY = F1
017600010109     C                   MOVEL(P)  'EXIT'        @STEP
017700010109     C                   LEAVESR
017800010109     C                   ENDIF
017900010109    ***
018000010109     C                   IF        FKEY = F6
018100090105     C                   CLEAR                   RBONUSDR
018200010109     C                   MOVEL(P)  'STEP3'       @STEP
018300010109     C                   MOVE      'A'           @@A               1
018400010109     C                   LEAVESR
018500010109     C                   ENDIF
018600010109    ***
018700010126     C                   IF        RRT > 0
018800010109     C                   EXSR      $CHKSELC
018900010126     C                   ENDIF
019000010109    ***
019100010109     C                   MOVEL(P)  'STEP1'       @STEP
019200010109    ***
019300010109     C                   ENDSR
019400010109   S***S
019500010109     C* DISPLAY THE SCREEN
019600010109    ***
019700010109     C     $DISPLAY      BEGSR
019800010109    ***
019900010109     C                   WRITE     IO01R
020000010109     C                   EXFMT     IO01C
020100010109     C*
020200010109     C                   MOVE      *BLANKS       R1MSG
020300010109    ***
020400010109     C                   ENDSR
020500010109    ***
020600010109   S***S
020700010109     C     $STEP3        BEGSR
020800010109    ***
020900010109     C                   MOVE      *BLANKS       R2MSG
021000010109    ***
021100010109     C                   MOVE      *BLANKS       R2SZCD
021200010109     C                   MOVE      *ZEROS        R2FRDT
021300010109     C                   MOVE      *ZEROS        R2TODT
021400010109     C                   MOVE      *ZEROS        R2OVPC
021500090102*****C                   MOVE      *ZEROS        R2OVRA
021600050930*****C                   MOVE      *ZEROS        R2OVPP
021700010109     C                   MOVE      *ZEROS        R2FRSZ
021800010109     C                   MOVE      *ZEROS        R2TOSZ
021900010120     C                   MOVE      *ZEROS        R2SEQ
022000010109    ***
022100010109     C                   MOVE      'STEP4'       @STEP
022200010109    ***
022300010109     C                   ENDSR
022400010109   S***S
022500010109     C     $STEP4        BEGSR
022600010109    ***
022700010109     C                   EXFMT     IO02R
022800010109     C                   MOVE      *BLANKS       R2MSG
022900010109    ***
023000010109    1C                   IF        FKEY = F1
023100010109     C                   MOVEL(P)  'STEP1'       @STEP
023200010109     C                   LEAVESR
023300010109    1C                   ENDIF
023400010109    ***
023500010109     C* F4 = MARKET SIZES INQUIRY
023600010109    1C                   IF        FKEY = F4
023700010109     C                   MOVEL(P)  I_CARR        @P8               8
023800150121     C                   CALL      'FM005CL32'
023900010109     C                   PARM                    @P8
024000010109     C                   MOVE      @P8           @5                5
024100010109    2C                   IF        @5 = '*LR '
024200010109     C                   LEAVESR
024300010109    2C                   ELSE
024400010109     C                   MOVEL(P)  @5            R2SZCD
024500010109     C                   MOVEL(P)  @5            @SZCD
024600090102     C     UNVKEY        CHAIN     RCARMKSZ
024700010109    3C                   IF        %FOUND(CARMKSZ3)
024800010109     C                   Z-ADD     CZFRSZ        R2FRSZ
024900010109     C                   Z-ADD     CZTOSZ        R2TOSZ
025000010109    3C                   ELSE
025100010109     C                   MOVE      *ZEROS        R2FRSZ
025200010109     C                   MOVE      *ZEROS        R2TOSZ
025300010109    3C                   ENDIF
025400010109    2C                   ENDIF
025500010109     C                   LEAVESR
025600010109    1C                   ENDIF
025700010109    ***
025800010109     C                   EXSR      $VALIDATE
025900010109    ***
026000010109     C                   IF        @VCC = 'Y'
026100010109     C                   EXSR      $UPDATE
026200010109     C                   ENDIF
026300010109    ***
026400010109     C                   ENDSR
026500010109   S***S
026600010109     C* VALIDATE VALUES
026700010109    ***
026800010109     C     $VALIDATE     BEGSR
026900010109    ***
027000010109     C                   MOVE      'N'           @VCC              1
027100010109     C                   MOVE      *ZEROS        R2FRSZ
027200010109     C                   MOVE      *ZEROS        R2TOSZ
027300010109    ***
027400010109    1C                   IF        R2SZCD = *BLANKS
027500010109     C                   MOVEL(P)  MSG(1)        R2MSG
027600010109     C                   LEAVESR
027700010109    1C                   ENDIF
027800010109    ***
027900010109     C                   MOVEL(P)  R2SZCD        @SZCD
028000090102     C     UNVKEY        CHAIN     RCARMKSZ
028100010109    1C                   IF        %FOUND(CARMKSZ3)
028200010109     C                   Z-ADD     CZFRSZ        R2FRSZ
028300010109     C                   Z-ADD     CZTOSZ        R2TOSZ
028400010109    1C                   ELSE
028500010109     C                   MOVEL(P)  MSG(2)        R2MSG
028600010118     C                   LEAVESR
028700010109    1C                   ENDIF
028800010109    ***
028900010109     C                   IF        R2FRDT = 0
029000010109     C                   MOVEL(P)  MSG(3)        R2MSG
029100010109     C                   LEAVESR
029200010109    1C                   ENDIF
029300010109    ***
029400010109     C     *USA          TEST (DE)               R2FRDT
029500010109     C                   IF        %ERROR
029600010109     C                   MOVEL(P)  MSG(4)        R2MSG
029700010109     C                   LEAVESR
029800010109     C                   ENDIF
029900010109     C*
030000010109     C                   MOVE      R2FRDT        #USA
030100010109     C                   MOVE      #USA          #ISO
030200010109     C                   MOVE      #ISO          #FRISO            8 0
030300010109    ***
030400010109    1C                   IF        R2TODT <> 0
030500010109     C*
030600010109     C     *USA          TEST (DE)               R2TODT
030700010109    2C                   IF        %ERROR
030800010109     C                   MOVEL(P)  MSG(5)        R2MSG
030900010109     C                   LEAVESR
031000010109    2C                   ENDIF
031100010109     C*
031200090102     C                   MOVE      R2TODT        @8                8
031300111129    2C                   IF        %SUBST(@8:3:2) < '27' AND
031400090102     C                             R2FRDT <> R2TODT
031500090102     C                   MOVEL(P)  MSG(5)        R2MSG
031600090102     C                   LEAVESR
031700111129    2C                   ENDIF
031800010109     C                   MOVE      R2TODT        #USA
031900010109     C                   MOVE      #USA          #ISO
032000010109     C                   MOVE      #ISO          #TOISO            8 0
032100111129     C*
032200111129    1C                   ELSE
032300111129     C                   EVAL      #TOISO = 0
032400010109     C*
032500010109    1C                   ENDIF
032600010125    ***
032700010125    1C                   IF        R2OVPC > 100.0000
032800010125     C                   MOVEL     MSG(7)        R2MSG
032900010125     C                   LEAVESR
033000010125    1C                   ENDIF
033100010109    ***
033200050930    *** max 100% % of prem
033300050930    1C                   IF        R2OVPP > 100.0000
033400050930     C                   MOVEL     MSG(6)        R2MSG
033500050930     C                   LEAVESR
033600050930    1C                   ENDIF
033700050930    *** select only one
033800090102    1C                   if        (r2ovpp <> 0 and r2ovpc <> 0 AND R2OVRA <> 0)
033900090102     C                             OR
034000090102    1C                             (r2ovpp <> 0 and r2ovpc <> 0 AND R2OVRA =  0)
034100090102     C                             OR
034200090102    1C                             (r2ovpp =  0 and r2ovpc <> 0 AND R2OVRA <> 0)
034300090102     C                             OR
034400090102    1C                             (r2ovpp <> 0 and r2ovpc =  0 AND R2OVRA <> 0)
034500050930     C                   MOVEL     MSG(8)        R2MSG
034600050930     C                   LEAVESR
034700050930    1C                   ENDIF
034800010109    ***
034900010122    *C*                  EXSR      $CHKFORACT
035000010122    1C*                  IF        @ACTIVE = 'Y'
035100010122    *C*                  MOVEL(P)  MSG(10)       R2MSG
035200010122    *C*                  LEAVESR
035300010122    1C*                  ENDIF
035400010109    ***
035500010109     C                   MOVE      'Y'           @VCC
035600010109    ***
035700010109     C                   ENDSR
035800010109   S***S
035900010122    *C*    $CHKFORACT    BEGSR
036000010122    ***
036100010122    *C*                  MOVE      'N'           @ACTIVE           1
036200010122    *C*                  MOVEL(P)  R2SZCD        @SZCD
036300010122    *C*
036400010122    *C*    UNVKEY        CHAIN(N)  RBONUSDR
036500010122    1C*                  IF        NOT %FOUND(BONUSDR1)
036600010122    *C*                  LEAVESR
036700010122    1C*                  ENDIF
036800010122    *C*
036900010122    *C*    UNVKEY        SETLL     RBONUSDR
037000010122    1C*                  DOU       %EOF(BONUSDR1) OR @ACTIVE = 'A'
037100010122    *C*    UNVKEY        READE     RBONUSDR
037200010122    2C*                  IF        NOT %EOF(BONUSDR1) AND BDTODT = 0
037300010122    3C*                  SELECT
037400010122    3C*                  WHEN      @@A = 'A'
037500010122    *C*                  MOVE      'Y'           @ACTIVE
037600010122    3C*                  WHEN      @@A = 'C' AND (SFOVPP <> BDOVPP OR
037700010122    *C*                            SFOVRA <> BDOVRA OR SFOVPC <> BDOVPC OR
037800010122    *C*                            SFFRDT <> BDFRDT)
037900010122    *C*                  MOVE      'Y'           @ACTIVE
038000010122    3C*                  ENDSL
038100010122    2C*                  ENDIF
038200010122    1C*                  ENDDO
038300010122    ***
038400010122    *C*                  ENDSR
038500010109   S***S
038600010109     C     $UPDATE       BEGSR
038700010109    ***
038800010109    1C                   IF        @@A = 'A'
038900010109     C                   MOVEL(P)  'STEP3'       @STEP
039000010109     C                   CLEAR                   RBONUSDR
039100010109     C                   MOVEL     I_CARR        BDCARR
039200010109     C                   MOVEL     R2SZCD        BDSZCD
039300010109     C                   Z-ADD     #FRISO        BDFRDT
039400010109     C                   Z-ADD     #TOISO        BDTODT
039500010109     C                   Z-ADD     R2OVPC        BDOVPC
039600050930*****C                   Z-ADD     R2OVPP        BDOVPP
039700090102*****C                   Z-ADD     R2OVRA        BDOVRA
039800010120     C                   Z-ADD     R2SEQ         BDSEQ
039900010109     C                   WRITE     RBONUSDR
040000010109     C                   LEAVESR
040100010109    1C                   ENDIF
040200010109    ***
040300090102     C     HK            CHAIN(N)  RBONUSDR
040400090102    1C                   IF        %FOUND(BONUSDR0)
040500010122    2C                   IF        R2SZCD <> BDSZCD OR R2OVPC <> BDOVPC OR
040600010109     C                             #FRISO <> BDFRDT OR #TOISO <> BDTODT OR
040700090102*****C                             R2OVPP <> BDOVPP OR R2SEQ  <> BDSEQ OR
040800090102*****C                             R2OVRA <> BDOVRA
040900090102     C     HK            CHAIN     RBONUSDR
041000010109     C                   MOVEL(P)  SFSZCD        @SZCD
041100010109     C                   Z-ADD     SFFRDT        #FRDT
041200010109     C                   Z-ADD     SFTODT        #TODT
041300010109     C                   MOVEL     R2SZCD        BDSZCD
041400010120     C                   Z-ADD     R2SEQ         BDSEQ
041500010109     C                   Z-ADD     #FRISO        BDFRDT
041600010109     C                   Z-ADD     #TOISO        BDTODT
041700010125     C                   Z-ADD     R2OVPC        BDOVPC
041800050930*****C                   Z-ADD     R2OVPP        BDOVPP
041900090102*****C                   Z-ADD     R2OVRA        BDOVRA
042000010109     C                   UPDATE    RBONUSDR
042100010109     C                   MOVEL(P)  MSG(9)        R2MSG
042200010109    2C                   ENDIF
042300010109    1C                   ENDIF
042400010109    ***
042500010109     C                   ENDSR
042600010109   S***S
042700010109     C* CHECK SUBFILE SELECTION
042800010109    ***
042900010109     C     $CHKSELC      BEGSR
043000010109    ***
043100010109     C                   DOU       %EOF(FM082D)
043200010109     C                   READC     IO01S
043300010109     C                   IF        NOT %EOF(FM082D) AND SEL <> *BLANKS
043400010109     C*
043500010109     C                   SELECT
043600010109     C                   WHEN      SEL = 'C'
043700010109     C                   EXSR      $CHGCTL
043800010109     C                   ENDSL
043900010109     C*
044000010109     C                   IF        R1MSG <> *BLANKS
044100010109     C                   LEAVESR
044200010109     C                   ENDIF
044300010109     C*
044400010109     C                   MOVE      *BLANKS       SEL
044500010109     C                   UPDATE    IO01S
044600010109     C*
044700010109     C                   ENDIF
044800010109     C                   ENDDO
044900010109    ***
045000010109     C                   ENDSR
045100010109   S***S
045200010109     C* CHANGE CONTROL ROUTINE
045300010109    ***
045400010109     C     $CHGCTL       BEGSR
045500010109    ***
045600010109     C                   MOVE      'C'           @@A                            ACTION TYPE
045700010109     C                   MOVE      *OFF          *IN30
045800090102     C                   EVAL      HKEY = HK
045900010109     C                   EXSR      $LOADNLOCK
046000010109     C*
046100010109     C                   IF        R1MSG <> *BLANKS
046200010109     C                   LEAVESR
046300010109     C                   ENDIF
046400010109    ***
046500010109     C                   MOVE      '0'           @@E               1
046600010109     C                   DOU       @@E = '1'
046700010109     C*
046800010109     C                   EXSR      $STEP4
046900010109     C*
047000010109     C                   IF        @STEP = 'STEP1'
047100010109     C                   MOVE      @@STP         @STEP
047200010109     C                   MOVE      '1'           @@E
047300010109     C                   LEAVESR
047400010109     C                   ENDIF
047500010109     C*
047600010109     C                   ENDDO
047700010109    ***
047800010109     C                   ENDSR
047900010109   S***S
048000010109     C* LOAD SCREEN 2 W/O LOCKING REC
048100010109    ***
048200010109     C     $LOADNLOCK    BEGSR
048300010109    ***
048400010109     C                   MOVEL(P)  @STEP         @@STP             5
048500010109     C                   EXSR      $STEP3
048600010109     C                   MOVEL(P)  @@STP         @STEP
048700010109    ***
048800010120     C                   Z-ADD     SFSEQ         R2SEQ
048900010109     C                   MOVEL     SFSZCD        R2SZCD
049000010109     C                   Z-ADD     SFFRDT        R2FRDT
049100010109     C                   Z-ADD     SFTODT        R2TODT
049200010109     C                   Z-ADD     SFOVPC        R2OVPC
049300090102*****C                   Z-ADD     SFOVRA        R2OVRA
049400050930*****C                   Z-ADD     SFOVPP        R2OVPP
049500010109     C                   Z-ADD     SFFRSZ        R2FRSZ
049600010109     C                   Z-ADD     SFTOSZ        R2TOSZ
049700010109    ***
049800010109     C                   MOVEL(P)  SFSZCD        @SZCD
049900010122     C                   Z-ADD     SFFRDT        #ISA              8 0
050000010122     C                   EXSR      $USAISO
050100010122     C                   Z-ADD     #ISA          #FRDK
050200010122     C                   Z-ADD     SFTODT        #ISA              8 0
050300010122     C                   EXSR      $USAISO
050400010122     C                   Z-ADD     #ISA          #TODK
050500090105     C     HKEY          CHAIN(N)  RBONUSDR
050600010109     C*
050700010109     C                   ENDSR
050800010122   S***S
050900010122     C     $USAISO       BEGSR
051000010122     C     *USA          TEST (DE)               #ISA
051100010122     C                   IF        %ERROR
051200010122     C                   MOVE      *ZEROS        #ISA
051300010122     C                   ELSE
051400010122     C                   MOVE      #ISA          #USA
051500010122     C                   MOVE      #USA          #ISO
051600010122     C                   MOVE      #ISO          #ISA
051700010122     C                   ENDIF
051800010122     C                   ENDSR
051900010109   S***S
052000010109123456*8901234567890123456789012345678901234567890
052100010109      *  11111111112222222222333333333344444444445
052200010109** CTDATA MSG
052300010109SIZE CODE CANNOT BE BLANK
052400010109SIZE CODE IS INVALID
052500010109FROM DATE CANNOT BE ZERO
052600010109FROM DATE IS IN A NON-VALID FORMAT
052700010109TO DATE IS IN A NON-VALID FORMAT
052800050930PERCENT OF PREMIUM CANNOT EXCEED 100%
052900010109%AGE OF COMMISSION CANNOT EXCEED 100%
053000050930CHOOSE % OF ADMIN FEE OR % OF PREM, NOT BOTH
053100010109UPDATE OF RECORD COMPLETE
053200010109REC EXISTS OR OPEN RECORD ALREADY EXISTS
