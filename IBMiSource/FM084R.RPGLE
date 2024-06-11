000001220901      *********************************************************************
000002220831     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000100220831      *********************************************************************
000200001218     F* FM084      - CARR MRKT SZS MAINT                                  *
000300001218     F*                                                                   *
000400001218     F* WRITTEN BY    STEPHEN KING 12/18/2000                             *
000500001218     F*               INNOVATIVE OUTSOURCING  2000                        *
000600001218     F*                                                                   *
000700001218     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
000800001218     F*            CARRIER MARKET GROUP SIZES FILE.                       *
000900001218     F*                                                                   *
001000001218     F*********************************************************************
001100001218     F* MODIFICATION HISTORY                                              *
001200001218     F* ### UUU CCYYMMDD X-->                                             *
001300001218     F* 000 SSK 20001218 ORIGINAL SOURCE                                  *
001400020123     F* 001 SSK 20020122 CHANGE STRUCTURE FROM I-O SFL TO A 'WORK WITH'   *
001500020322     F* 002 SSK 20020322 SFLRRN = 0 CAUSED ABEND; FIXED                   *
001600071019     F* 003 SSK 20071019 REMOVE EXISTENCE EDIT                            *
001700071019     F*                  REMOVE OVERLAP PROTECTION                        *
001800020123     F*                                                                   *
001900001218     F*********************************************************************
002000220831     FCARMKSZ1  UF A E           K DISK    extfile('F.CARMKSZ1')
002100010120     FCARMKSZ4  IF   E           K DISK    RENAME(RCARMKSZ:C4) PREFIX(Z:1)
002101220831     f                                     extfile('F.CARMKSZ4')
002200010118     FADMNFEE2  IF   E           K DISK
002300010118     FBONUSDR2  IF   E           K DISK
002400010118     FBRKRCOM2  IF   E           K DISK
002500001218     FFM084D    CF   E             WORKSTN INFDS(WSDS)
002600001218     F                                     SFILE(IO01S:RRT)
002700001218     ***
002800001218     D WSDS            DS
002900001218     D  FKEY                 369    369A
003000001218     ***
003100001218     D  F1             C                   CONST(X'31')
003200001218     D  F2             C                   CONST(X'32')
003300001218     D  F3             C                   CONST(X'33')
003400001218     D  F4             C                   CONST(X'34')
003500001218     D  F5             C                   CONST(X'35')
003600001218     D  F6             C                   CONST(X'36')
003700001218     D  F7             C                   CONST(X'37')
003800001218     D  F8             C                   CONST(X'38')
003900001218     D  F9             C                   CONST(X'39')
004000001218     D  F10            C                   CONST(X'3A')
004100001218     D  F11            C                   CONST(X'3B')
004200001218     D  F12            C                   CONST(X'3C')
004300001218     D  F13            C                   CONST(X'B1')
004400001218     D  F14            C                   CONST(X'B2')
004500001218     D  F15            C                   CONST(X'B3')
004600001218     D  F16            C                   CONST(X'B4')
004700001218     D  F17            C                   CONST(X'B5')
004800001218     D  F18            C                   CONST(X'B6')
004900001218     D  F19            C                   CONST(X'B7')
005000001218     D  F20            C                   CONST(X'B8')
005100001218     D  F21            C                   CONST(X'B9')
005200001218     D  F22            C                   CONST(X'BA')
005300001218     D  F23            C                   CONST(X'BB')
005400001218     D  F24            C                   CONST(X'BC')
005500001218     ***
005600020122     D @45             S             45A
005700020122     D @INUSE          S              1A
005800020122     D @MSG2           S                   LIKE(R2MSG)
005900020122     D @MSG            S             45A   DIM(10) CTDATA PERRCD(1)             ERROR MESSAGES
006000020122     D @STEP           S              5A   INZ('PREP1')                         CONTROL FIELD
006100001220     D #ISO            S               D   DATFMT(*ISO)
006200001220     D #USA            S               D   DATFMT(*USA)
006300020122     D #ISA            S              8S 0
006400020122     D #USO            S              8S 0
006500020122     D @ACTION         S              1A
006600020122     D @VS             S              1A
006700020122     D E#              S              2S 0
006800020122     D #COMPDTE        S                   LIKE(CZFRDT)
006900020122     D #8FISO          S              8S 0
007000020122     D #8TISO          S              8S 0
007100020122     D @VR             S              1A
007200020122     D #SFISO          S              8S 0
007300020122     D #STISO          S              8S 0
007301220901     D fromDate        S              8  0
007302220901     D toDate          S              8  0
007400020122     ***
007500020122     D KEY@SZCD        S                   LIKE(CZSZCD)
007600020122     D KEY@CARR        S                   LIKE(CZCARR)
007700020122     D KEY@FRDT        S                   LIKE(CZFRDT)
007800020122     D KEY@TODT        S                   LIKE(CZTODT)
007900001218     ***
008000001218     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
008100001218     D                UDS
008200020122     D  XITLE                201    240
008300001218     ***
008400020122     C                   DOU       @STEP = 'LEAVE'
008500020122     C     @STEP         CASEQ     'PREP1'       $PREP1
008600020122     C     @STEP         CASEQ     'STEP1'       $STEP1
008700020122     C     @STEP         CASEQ     'STEP2'       $STEP2
008800020122     C     @STEP         CASEQ     'STEP3'       $STEP3
008900020122     C     @STEP         CASEQ     'PREP4'       $PREP4
009000020122     C     @STEP         CASEQ     'STEP4'       $STEP4
009100001218     C                   ENDCS
009200001218     C                   ENDDO
009300001218     C*
009400001218     C                   MOVE      *ON           *INLR
009500001218   S***S
009600001218     C     *INZSR        BEGSR
009700001218     C*
009800001218     C     *ENTRY        PLIST
009900001218     C                   PARM                    @3CARR            3
010000001218     C*
010100020122     C     KEY#UNV       KLIST
010200020122     C                   KFLD                    KEY@SZCD
010300020122     C                   KFLD                    KEY@CARR
010400020122     C*
010500020122     C     KEY#CMS2      KLIST
010600020122     C                   KFLD                    KEY@CARR
010700020122     C                   KFLD                    KEY@SZCD
010800010118     C*
010900020122     C     KEY#CMS1      KLIST
011000020122     C                   KFLD                    KEY@CARR
011100020122     C                   KFLD                    KEY@SZCD
011200020122     C                   KFLD                    KEY@FRDT
011300020122     C                   KFLD                    KEY@TODT
011400020122    ***
011500020122     C                   ENDSR
011600020122   S***S
011700020122     C     $PREP1        BEGSR
011800020122    ***
011900020122     C                   MOVEL     @3CARR        I_CARR
012000020122     C                   MOVEL     @3CARR        KEY@CARR
012100020122     C                   MOVEL     XITLE         TITLE
012200020122     C                   MOVEL     'STEP1'       @STEP
012300020122    ***
012400001218     C                   ENDSR
012500001218   S***S
012600001218     C     $STEP1        BEGSR
012700020122    ***
012800001218     C                   MOVE      *BLANKS       R1MSG
012900001218     C* CLEAR SFL
013000001218     C                   MOVEA     '011'         *IN(28)
013100001218     C                   WRITE     IO01C
013200001218     C                   MOVEA     '010'         *IN(28)
013300001218     C* SFL BUILD
013400001218     C                   Z-ADD     *ZERO         RRT               3 0
013500001218     C                   MOVE      *ZEROS        #O2CREC           3 0
013600001218     C                   MOVE      '0'           @1STLOOP          1
013700001218     C*
013800020122     C     KEY@CARR      SETLL     C4
013900010120    1C                   DOU       %EOF(CARMKSZ4)
014000020122     C     KEY@CARR      READE     C4
014100020122    2C                   IF        NOT %EOF(CARMKSZ4) OR #O2CREC = 200
014200001218     C*
014300001218     C                   CLEAR                   IO01S
014400001218     C                   ADD       1             #O2CREC
014500001218     C                   MOVE      *ON           *IN28
014600001218     C                   MOVE      *OFF          *IN31
014700001218     C*
014800010120     C                   MOVEL(P)  ZZSZCD        SFSZCD
014900010120     C                   Z-ADD     ZZFRSZ        SFFRSZ
015000010120     C                   Z-ADD     ZZTOSZ        SFTOSZ
015100001220    ***
015200020122     C                   MOVE      ZZFRDT        #ISA
015300020122     C                   EXSR      $ISOUSA
015400020122     C                   Z-ADD     #ISA          SFFRDT
015500020122     C*
015600020122     C                   MOVE      ZZTODT        #ISA
015700020122     C                   EXSR      $ISOUSA
015800020122     C                   Z-ADD     #ISA          SFTODT
015900020122    ***
016000001218     C                   ADD       1             RRT
016100001218    3C                   IF        @1STLOOP = '0'
016200001218     C                   Z-ADD     RRT           SFLRRN
016300001218     C                   MOVE      '1'           @1STLOOP
016400001218    3C                   ENDIF
016500001218     C*
016600001218     C                   WRITE     IO01S
016700001218     C*
016800001218    2C                   ENDIF
016900001218     C*
017000001218    1C                   ENDDO
017100001218     C*
017200020122     C                   MOVEL     'STEP2'       @STEP
017300001218     C                   MOVE      *BLANKS       R1MSG
017400020122     C*
017500020122     C                   ENDSR
017600020122   S***S
017700020122     C     $ISOUSA       BEGSR
017800020122     C*
017900020122     C                   IF        #ISA = 0
018000020122     C                   LEAVESR
018100020122     C                   ENDIF
018200020122     C                   MOVE      #ISA          #ISO
018300020122     C                   MOVE      #ISO          #USA
018400020122     C                   MOVE      #USA          #ISA
018500001218     C*
018600001218     C                   ENDSR
018700001218   S***S
018800001218     C     $STEP2        BEGSR
018900001218     C*
019000001218     C                   WRITE     IO01R
019100001218     C                   EXFMT     IO01C
019200001218     C*
019300001218     C                   MOVE      *BLANKS       R1MSG
019400001218     C                   MOVE      *OFF          *IN32
019500001218    ***
019600001218     C* EXIT APPLICATION
019700001218    1C                   IF        FKEY = F1
019800020122     C                   MOVEL     'LEAVE'       @STEP
019900001218     C                   LEAVESR
020000001218    1C                   ENDIF
020100001218    ***
020200020122     C* ADD RECORD
020300020122    1C                   IF        FKEY = F6
020400020122     C                   MOVEL     'STEP4'       @STEP
020500020122     C                   CLEAR                   IO02
020600020122     C                   MOVEL     @3CARR        I_CARR
020700020122     C                   MOVEL     XITLE         TITLE
020800020122     C                   MOVE      'A'           @ACTION
020900020122     C                   LEAVESR
021000020122    1C                   ENDIF
021100020122    ***
021200020322     C                   If        *ZEROS <> #O2CREC
021300020122     C                   MOVEL     'STEP3'       @STEP
021400020322     C                   Endif
021500020122    ***
021600020122     C                   ENDSR
021700020122   S***S
021800020122     C     $STEP3        BEGSR
021900020122    ***
022000020122     C                   READC     IO01S
022100020122    ***
022200020122     C                   IF        %EOF(FM084D)
022300020122     C                   MOVEL     'STEP1'       @STEP
022400020122     C                   LEAVESR
022500020122    1C                   ENDIF
022600020122    ***
022700020122    2C                   IF        SEL = 'C'
022800020122     C                   MOVEL     'PREP4'       @STEP
022900020122     C                   LEAVESR
023000020122    1C                   ENDIF
023100020122    ***
023200020122     C                   ENDSR
023300020122   S***S
023400020122     C     $PREP4        BEGSR
023500020122    ***
023600020122     C                   CLEAR                   IO02
023700020122     C                   MOVEL     @3CARR        I_CARR
023800020122     C                   MOVEL     XITLE         TITLE
023900020122    1C                   MOVEL     SFSZCD        I2SZCD
024000020122     C                   Z-ADD     SFFRSZ        I2FRSZ
024100020122    1C                   Z-ADD     SFTOSZ        I2TOSZ
024200020122     C                   Z-ADD     SFFRDT        I2FRDT
024300020122    1C                   Z-ADD     SFTODT        I2TODT
024400020122     C                   MOVE      'C'           @ACTION
024500020122     C                   MOVEL     'STEP4'       @STEP
024600020122    ***
024700020122     C                   ENDSR
024800020122   S***S
024900020122     C     $STEP4        BEGSR
025000020122    ***
025100020122     C                   MOVEL(P)  @MSG2         R2MSG
025200020122     C                   EXFMT     IO02
025300020122     C                   MOVE      *BLANKS       @MSG2
025400020122     C                   MOVE      *BLANKS       R2MSG
025500020122    ***
025600020122     C                   IF        FKEY = F12
025700020122     C                   IF        @ACTION = 'A'
025800020122     C                   MOVEL     'STEP2'       @STEP
025900020122     C                   ELSE
026000020122     C                   MOVEL     'STEP3'       @STEP
026100020122     C                   ENDIF
026200020122     C                   LEAVESR
026300020122     C                   ENDIF
026400020122    ***
026500020122     C                   EXSR      $VALIDATE
026600020122     C                   IF        @VS = 'N'
026700020122     C                   MOVEA     @MSG(E#)      @45
026800020122     C                   MOVEL(P)  @45           @MSG2
026900020122     C                   LEAVESR
027000020122     C                   ELSE
027100020122     C                   EXSR      $UPDATES
027200020122     C                   IF        @ACTION = 'A'
027300020122     C                   MOVEL     'STEP1'       @STEP
027400020122     C                   ELSE
027500020122     C                   MOVEL     'STEP3'       @STEP
027600020122     C                   ENDIF
027700020122     C                   ENDIF
027800001218    ***
027900001218     C                   ENDSR
028000001218   S***S
028100020122     C     $VALIDATE     BEGSR
028200020122    ***
028300020122     C                   EVAL      @VS = 'N'
028400020122     C                   MOVE      *ZEROS        E#
028500020122    ***
028600020122    1C                   IF        I2SZCD = *BLANKS
028700020122     C                   MOVE      8             E#
028800020122     C                   LEAVESR
028900020122    1C                   ENDIF
029000071019     ******
029100071019     ****** DISABLED BECAUSE IT SCREWS WITH THE CARRIER SET-UP CHANGES.
029200071019     ****** 10/19/2007 SK  BOSS MAN SAID DO IT.
029300071019     ******
029400071019     ******
029500071019    *C*****
029600071019     C*****              EXSR      $CHKEXIST
029700071019    1C*****              IF        @INUSE = 'Y'
029800071019     C*****              MOVE      9             E#
029900071019     C*****              LEAVESR
030000071019    1C*****              ENDIF
030100020122    ***
030200020122     C                   IF        I2FRSZ = 0
030300020122     C                   MOVE      1             E#
030400020122     C                   LEAVESR
030500020122    1C                   ENDIF
030600020122    ***
030700020122     C                   IF        I2TOSZ = 0
030800020122     C                   MOVE      2             E#
030900020122     C                   LEAVESR
031000020122    1C                   ENDIF
031100020122    ***
031200020122    1C                   IF        I2TOSZ < I2FRSZ
031300020122     C                   MOVE      3             E#
031400020122     C                   LEAVESR
031500020122    1C                   ENDIF
031600020122    *C*
031700020122     C                   IF        I2FRDT = 0
031800020122     C                   MOVE      4             E#
031900001220     C                   LEAVESR
032000001220     C                   ENDIF
032100001220    ***
032200020122     C     *USA          TEST(DE)                I2FRDT
032300001220     C                   IF        %ERROR
032400020122     C                   MOVE      6             E#
032500001220     C                   LEAVESR
032600001220     C                   ENDIF
032700001220    ***
032800020122     C                   IF        I2TODT <> 0
032900020122     C     *USA          TEST(DE)                I2TODT
033000001220     C                   IF        %ERROR
033100020122     C                   MOVE      7             E#
033200001220     C                   LEAVESR
033300001220     C                   ENDIF
033400001220     C                   ENDIF
033500001220    ***
033600020122     C                   Z-ADD     I2FRDT        #USO
033700020122     C                   EXSR      $USAISO
033800020122     C                   Z-ADD     #USO          #8FISO
033900001220    ***
034000020122     C                   Z-ADD     I2TODT        #USO
034100020122     C                   EXSR      $USAISO
034200020122     C                   Z-ADD     #USO          #8TISO
034300020122    ***
034400020122     C                   IF        #8FISO > #8TISO AND #8TISO <> 0
034500020122     C                   MOVE      5             E#
034600001220     C                   LEAVESR
034700001220     C                   ENDIF
034800001218    ***
034900071019     ******
035000071019     ****** DISABLED BECAUSE IT SCREWS WITH THE CARRIER SET-UP CHANGES.
035100071019     ****** 10/19/2007 SK  BOSS MAN SAID DO IT.
035200071019     ******
035300071019     ******
035400071019     C*****              EXSR      $CHKRNG
035500071019     C*****              IF        @VR = 'N'
035600071019     C*****              MOVE      10            E#
035700071019     C*****              LEAVESR
035800071019     C*****              ENDIF
035900020122    ***
036000020122     C                   EVAL      @VS = 'Y'
036100020122    ***
036200001218     C                   ENDSR
036300010118   S***S
036400010118     C     $CHKEXIST     BEGSR
036500010118    ***
036600020122     C                   EVAL      @INUSE = 'N'
036700020122     C                   MOVEL(P)  I2SZCD        KEY@SZCD
036800010118     C*
036900020122     C     KEY#UNV       CHAIN(N)  RADMNFEE
037000010118     C                   IF        %FOUND(ADMNFEE2)
037100010118     C                   MOVE      'Y'           @INUSE
037200020122     C                   LEAVESR
037300010118     C                   ENDIF
037400010118     C*
037500020122     C     KEY#UNV       CHAIN(N)  RBONUSDR
037600010118     C                   IF        %FOUND(BONUSDR2)
037700010118     C                   MOVE      'Y'           @INUSE
037800020122     C                   LEAVESR
037900010118     C                   ENDIF
038000010118     C*
038100020122     C     KEY#UNV       CHAIN(N)  RBRKRCOM
038200010118     C                   IF        %FOUND(BRKRCOM2)
038300010118     C                   MOVE      'Y'           @INUSE
038400020122     C                   LEAVESR
038500010118     C                   ENDIF
038600010118    ***
038700010118     C                   ENDSR
038800001218   S***S
038900020122     C     $USAISO       BEGSR
039000020122    ***
039100020122     C                   IF        #USO = 0
039200020122     C                   LEAVESR
039300020122     C                   ENDIF
039400020122     C                   MOVE      #USO          #USA
039500020122     C                   MOVE      #USA          #ISO
039600020122     C                   MOVE      #ISO          #USO
039700020122    ***
039800020122     C                   ENDSR
039900020122   S***S
040000020122     C     $CHKRNG       BEGSR
040100020122    ***
040200020122     C                   MOVE      'Y'           @VR
040300020122    ***
040400020122     C                   IF        SFFRDT <> SFTODT AND I2FRDT = I2TODT
040500020122     C                   LEAVESR
040600020122     C                   ENDIF
040700020122    ***
040800020122     C                   MOVEL(P)  I2SZCD        KEY@SZCD
040900020122    ***
041000020122     C                   MOVE      SFFRDT        #USO
041100020122     C                   EXSR      $USAISO
041200020122     C                   Z-ADD     #USO          #SFISO
041300020122     C*
041400020122     C                   MOVE      SFTODT        #USO
041500020122     C                   EXSR      $USAISO
041600020122     C                   Z-ADD     #USO          #STISO
041700020122     C*
041800020122     C     KEY@CARR      SETLL     RCARMKSZ
041900020122    1C                   DOU       %EOF(CARMKSZ1)
042000020122     C     KEY@CARR      READE     RCARMKSZ
042100020122    2C                   IF        NOT %EOF(CARMKSZ1) AND CZFRDT <> CZTODT
042200020122    ***
042300020122    3C                   IF        @ACTION = 'A' OR (@ACTION = 'C' AND (
042400020122     C                             CZTOSZ <> SFTOSZ OR CZFRSZ <> SFFRSZ OR
042500020122     C                             CZFRDT <> #SFISO OR CZTODT <> #STISO OR
042600020122     C                             CZSZCD <> SFSZCD))
042700020122     C
042800020122    4C                   IF        (I2TOSZ <= CZTOSZ AND I2TOSZ >= CZFRSZ) OR
042900020122     C                             (I2FRSZ >= CZFRSZ AND I2FRSZ <= CZTOSZ) OR
043000020123     C                             (I2FRSZ <  CZFRSZ AND I2TOSZ >  CZTOSZ) OR
043100020123     C                             ((I2TOSZ < CZFRSZ OR I2FRSZ > CZTOSZ) AND
043200020123     C                             I2SZCD = CZSZCD)
043300020122    5C                   IF        CZTODT = 0
043400020122     C                   EVAL      #COMPDTE = 99999999
043500020122    5C                   ELSE
043600020122     C                   EVAL      #COMPDTE = CZTODT
043700020122    5C                   ENDIF
043800020122    5C                   IF        #8FISO <= #COMPDTE
043900020122     C                   MOVE      'N'           @VR
044000020122    5C                   ENDIF
044100020122    4C                   ENDIF
044200020122    3C                   ENDIF
044300020122    ***
044400020122    2C                   ENDIF
044500020122    1C                   ENDDO
044600020122    ***
044700020122     C                   ENDSR
044800020122   S***S
044900001218     C     $UPDATES      BEGSR
044901220901
044902220901     C                   Z-ADD     i2frdt        #USO
044903220901     C                   EXSR      $USAISO
044904220901     C                   Z-ADD     #USO          fromDate
044905220901     C                   Z-ADD     i2todt        #USO
044906220901     C                   EXSR      $USAISO
044907220901     C                   Z-ADD     #USO          toDate
045001220901       chain (i_carr : i2szcd : fromDate : toDate) rcarmksz;
045002220831       if not %found;
045100020122     C                   IF        @ACTION = 'A'
045200020122     C                   CLEAR                   RCARMKSZ
045300020122     C                   MOVEL(P)  I_CARR        CZCARR
045400020122     C                   MOVEL(P)  I2SZCD        CZSZCD
045500020122     C                   Z-ADD     #8FISO        CZFRDT
045600020122     C                   Z-ADD     #8TISO        CZTODT
045700020122     C                   Z-ADD     I2FRSZ        CZFRSZ
045800020122     C                   Z-ADD     I2TOSZ        CZTOSZ
045900020122     C                   WRITE     RCARMKSZ
046000020122     C                   LEAVESR
046001220901     C                   endif
046101220901       endif;
046200220901
046300220901     C                   MOVEL(P)  SFSZCD        KEY@SZCD
046400220901     C                   Z-ADD     SFFRDT        #USO
046500220901     C                   EXSR      $USAISO
046600220901     C                   Z-ADD     #USO          KEY@FRDT
046700220901     C                   Z-ADD     SFTODT        #USO
046800220901     C                   EXSR      $USAISO
046900220901     C                   Z-ADD     #USO          KEY@TODT
046901220901       chain (i_carr : i2szcd : fromDate : toDate) rcarmksz;
046902220901       if not %found;
046903220901        chain (i_carr : KEY@SZCD : KEY@FRDT : KEY@TODT) rcarmksz;
046904220901        if %found;
046905220901         delete rcarmksz;
046906220901        endif;
046907220901
048001220901     C                   Z-ADD     i2frdt        #USO
048002220901     C                   EXSR      $USAISO
048003220901     C                   Z-ADD     #USO          fromDate
048004220901     C                   Z-ADD     i2todt        #USO
048005220901     C                   EXSR      $USAISO
048006220901     C                   Z-ADD     #USO          toDate
048100020122     C                   MOVEL(P)  I2SZCD        CZSZCD
048200220901     C                   Z-ADD     fromDate      CZFRDT
048300220901     C                   Z-ADD     toDate        CZTODT
048400020122     C                   Z-ADD     I2FRSZ        CZFRSZ
048500020122     C                   Z-ADD     I2TOSZ        CZTOSZ
048600220901     C                   write     RCARMKSZ
048601220901        endif;
048602220901       endsr;
048604220901
049100001218**   ERROR MESSAGE ARRAY
049200001218FROM SIZE CANNOT BE ZERO
049300001218TO SIZE CANNOT BE ZERO
049400001218FROM SIZE CANNOT EXCEED TO SIZE
049500001220FROM DATE CANNOT BE ZERO
049600001220TO DATE CANNOT BE LESS THAN FROM DATE
049700001220FROM DATE NOT MMDDCCYY FORMAT
049800001220TO DATE NOT MMDDCCYY FORMAT
049900001220GROUP CODE IS REQUIRED
050000010118SIZE CODE IN USE; CHANGE DENIED.
050100020122OVERLAP HAS OCCURED ADD/CHG IN ERROR
