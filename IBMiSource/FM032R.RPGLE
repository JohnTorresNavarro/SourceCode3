000100211008     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000101220719      *=========================================================================
000102220719      * FM032R - Plan Class Maintenance
000103220719      *========================================================================
000104220719      * Date         Int  Description
000105220719      * ---------    ---  -----------------------------------------------------
000200220719      * 07/19/2022   jt   Added plan description to screen
000201220719      *========================================================================
000202220719
000300211008     FFM032D    CF   E             WORKSTN Handler('PROFOUNDUI(HANDLER)')
000400211008     F                                     SFILE(GBSSFL:RRT) INFDS(WSDS)
000500211008
000600220719     FCLASS     UF A E           K DISK    EXTFILE('F.CLASS')
000700220425     FCODES     IF   E           K DISK    EXTFILE('F.CODES')
000800220425     FCLASSMST  IF   E           K DISK    extfile('F.CLASSMST')
000900220425     FCLSHIST0  O  A E             DISK    extfile('F.CLSHIST0')
000901220719
000902220719     ftrsmst    if   e           k disk    rename(trsmsr:trustFile)
000903220719     f                                     extfile('F.TRSMST')
000904220719
000905220719     fsubmst    if   e           k disk    rename(submsr:subFile)
000906220719     f                                     extfile('F.SUBMST')
000907220719
000908220719     fplnmst    if   e           k disk    rename(plnmsr:planFile)
000909220719     f                                     extfile('F.PLNMST')
000910220719
000911220719      *========================================================================
001000220719
001100010508     D WSDS            DS
001200010508     D  FKEY                 369    369A
001300010508    ***
001400010508     D  F1             C                   CONST(X'31')
001500010508     D  F2             C                   CONST(X'32')
001600010508     D  F3             C                   CONST(X'33')
001700010508     D  F4             C                   CONST(X'34')
001800010508     D  F5             C                   CONST(X'35')
001900010508     D  F6             C                   CONST(X'36')
002000010508     D  F7             C                   CONST(X'37')
002100010508     D  F8             C                   CONST(X'38')
002200010508     D  F9             C                   CONST(X'39')
002300010508     D  F10            C                   CONST(X'3A')
002400010508     D  F11            C                   CONST(X'3B')
002500010508     D  F12            C                   CONST(X'3C')
002600010508     D  F13            C                   CONST(X'B1')
002700010508     D  F14            C                   CONST(X'B2')
002800010508     D  F15            C                   CONST(X'B3')
002900010508     D  F16            C                   CONST(X'B4')
003000010508     D  F17            C                   CONST(X'B5')
003100010508     D  F18            C                   CONST(X'B6')
003200010508     D  F19            C                   CONST(X'B7')
003300010508     D  F20            C                   CONST(X'B8')
003400010508     D  F21            C                   CONST(X'B9')
003500010508     D  F22            C                   CONST(X'BA')
003600010508     D  F23            C                   CONST(X'BB')
003700010508     D  F24            C                   CONST(X'BC')
003800011228     D  ROLLDN         C                   CONST(X'F4')
003900011228     D  ROLLUP         C                   CONST(X'F5')
004000010509    ***
004100021003     D CON@NA          C                   CONST('NOT APPLICABLE')
004200021003    ***
004300020212     D @90             S             90A
004400011228     D                 DS
004500020212     D @PARMDS                 1     90A
004600020314     D P@TSP                   1     10A
004700020212     D P@TRS                   1      3S 0
004800020212     D P@SUB                   4      6S 0
004900020212     D P@PLN                   7     10A
005000020212     D P@TD                   11     30A
005100020212     D P@SD                   31     50A
005200020212     D P@PD                   51     90A
005300011228    ***
005400011228     D                UDS
005500011228     D XOPERID                 1      8
005600011228     D XONAME                201    240
005700011228    ***
005800020212     D @@V             S              1A
005900020212     D KEY@TRS         S                   LIKE(CLTRST)
006000020212     D KEY@SUB         S                   LIKE(CLSUB#)
006100020212     D KEY@PLN         S                   LIKE(CLPLAN)
006200020212     D KEY@CVT         S                   LIKE(CLCOVTP)
006300020212     D KEY@TYPE        S                   LIKE(TYPE)
006400020212     D KEY@CODE        S                   LIKE(CODE)
006500011228    ***
006600020212     D @EMSG           S                   LIKE(EMSG)
006700010508    ***
006800020213     D @3              S              3A
006900010508     D @STEP           S              5A
007000020314     D @HT15           S             15A
007100020314     D @HT28           S             28A
007200020314     D @HT30           S             30A
007300020314     D #8              S              8S 0
007400020314     D @TS40           S             40A
007500020314     D @TIMESTAMP      DS
007600020314     D  #TSCYMD                1      8S 0
007700020314     D  #TSTIME                9     14S 0
007800020314     D  @TSJOB                15     24
007900020314     D  @TSUSER               25     34
008000020314     D  #TSNBR                35     40S 0
008100010508   X***X
008200010508     C* MAINLINE
008300010508    ***
008400011228     C     *ENTRY        PLIST
008500020212     C                   PARM                    @90
008600020212     C                   MOVEL     @90           @PARMDS
008700011228    ***
008800010508     C                   DOU       @STEP = 'LEAVE'
008900020212     C     @STEP         CASEQ     'PREP1'       $PREP1
009000010508     C     @STEP         CASEQ     'STEP1'       $STEP1
009100020212     C     @STEP         CASEQ     'PREP2'       $PREP2
009200010508     C     @STEP         CASEQ     'STEP2'       $STEP2
009300010508     C                   ENDCS
009400010508     C                   ENDDO
009500010508    ***
009600010508     C                   MOVE      *ON           *INLR
009700010508     C                   RETURN
009800010508   S***S
009900010508     C* ONETIME ROUTINE
010000010508    ***
010100010508     C     *INZSR        BEGSR
010200010726    ***
010300010508     C                   MOVE      *BLANKS       @ACTION           1
010400010508     C                   MOVE      *ZEROS        RRT               4 0
010500010508     C                   MOVE      *ZEROS        #CNTREC           4 0
010600011228    ***
010700020212     C     KEY#CLSA      KLIST
010800020212     C                   KFLD                    KEY@TRS
010900020212     C                   KFLD                    KEY@SUB
011000020212     C                   KFLD                    KEY@PLN
011100020212    ***
011200020212     C     KEY#CODES     KLIST
011300020212     C                   KFLD                    KEY@TYPE
011400020212     C                   KFLD                    KEY@CODE
011500011228    ***
011600020212     C     KEY#CLSB      KLIST
011700020212     C                   KFLD                    KEY@TRS
011800020212     C                   KFLD                    KEY@SUB
011900020212     C                   KFLD                    KEY@PLN
012000020212     C                   KFLD                    KEY@CVT
012100010508    ***
012200010508     C                   MOVE      '0'           @1STLOOP          1
012300020212     C                   MOVE      'PREP1'       @STEP
012400010508    ***
012500010508     C                   ENDSR
012600010508   S***S
012700020212     C     $PREP1        BEGSR
012800010508    ***
012900020212     C                   CLEAR                   GBSCTL
013000020212    ***
013100020212     C                   EXSR      $CLEAR
013200020212    ***
013300020212     C                   MOVEL     XONAME        TITLE
013400020212     C                   Z-ADD     P@TRS         KEY@TRS
013500020212     C                   Z-ADD     P@SUB         KEY@SUB
013600020212     C                   MOVEL     P@PLN         KEY@PLN
013700020212     C                   Z-ADD     P@TRS         O_TRS
013800020212     C                   Z-ADD     P@SUB         O_SUB
013900020212     C                   MOVEL     P@PLN         O_PLAN
014000020212     C                   MOVEL     P@TD          O_TNAME
014100011228     C                   MOVEL     P@SD          O_SNAME
014200020212     C                   MOVEL     P@PD          O_PNAME
014300010508    ***
014400020212     C                   EXSR      $BUILD
014500020212     C                   MOVE      'STEP1'       @STEP
014600020212    ***
014700011228     C                   ENDSR
014800020212   S***S
014900011228     C     $CLEAR        BEGSR
015000011228    ***
015100011228     C                   MOVEA     '011'         *IN(25)
015200020212     C                   WRITE     GBSCTL
015300011228     C                   MOVEA     '010'         *IN(25)
015400011228     C                   Z-ADD     *ZERO         RRT
015500011228    ***
015600011228     C                   ENDSR
015700011228   S***S
015800020212     C     $BUILD        BEGSR
015900020212    ***
016000020212     C                   MOVE      *ZEROS        #CNTREC
016100020212     C                   MOVE      '0'           @1STLOOP          1
016200020212    ***
016300020212     C     KEY#CLSA      SETLL     FCLASS
016400020212     C                   DOU       %EOF(CLASS)
016500020212     C     KEY#CLSA      READE     FCLASS
016600020212     C                   IF        NOT %EOF(CLASS)
016700020212     C                   EXSR      $LOADSFL
016800020212     C                   ENDIF
016900020212     C                   ENDDO
017000020212    ***
017100020212     C                   ENDSR
017200020212   S***S
017300020212     C     $LOADSFL      BEGSR
017400020212    ***
017500020212     C                   MOVE      *ON           *IN25
017600020212     C                   ADD       1             #CNTREC
017700020212     C                   MOVE      *BLANKS       SEL
017800020212     C                   MOVE      CLCOVTP       SFCOVTP
017900020212     C                   MOVEL     CLCLASS       SFCLASS
018000130225     C                   MOVEL     CLPREFX       SFPREFX
018100021003     C                   IF        CLCOVTP = 'NA'
018200021003     C                   EVAL      SFCVDES = CON@NA
018300021003     C                   ELSE
018400020212     C                   MOVEL     'T'           KEY@TYPE
018500020212     C                   MOVE      CLCOVTP       KEY@CODE
018600211008     C     KEY#CODES     CHAIN     CODESR
018700020212     C                   IF        %FOUND(CODES)
018800020212     C                   MOVEL     LDESCR        SFCVDES
018900020212     C                   ELSE
019000020212     C                   EVAL      SFCVDES = 'NO DESCRIPTION FOUND'
019100021003     C                   ENDIF
019200020212     C                   ENDIF
019300020212     C*
019400020212     C                   ADD       1             RRT
019500020212     C*
019600020212     C                   IF        @1STLOOP = '0'
019700020212     C                   Z-ADD     RRT           SFLPOS
019800020212     C                   MOVE      '1'           @1STLOOP
019900020212     C                   ENDIF
020000020212     C*
020100020212     C                   WRITE     GBSSFL
020200020212    ***
020300020212     C                   ENDSR
020400020212   S***S
020500020212     C     $STEP1        BEGSR
020501220719
020502220719       exsr getHeadings;
020600011228    ***
020700010508     C                   EXSR      $DISPLAY
020800010508    ***
020900010508     C                   IF        FKEY = F1
021000010508     C                   MOVE      'LEAVE'       @STEP
021100010508     C                   LEAVESR
021200010508     C                   ENDIF
021300011228    ***
021400020212     C                   IF        FKEY = F6
021500020212     C                   MOVE      'PREP2'       @STEP
021600011228     C                   LEAVESR
021700011228     C                   ENDIF
021800020314    ***
021900020314     C                   IF        FKEY = F9
022000020314     C                   CALL      'FM033R'
022100020314     C                   PARM                    @90
022200020314     C                   LEAVESR
022300020314     C                   ENDIF
022400010508    ***
022500020212     C                   EXSR      $CHKSELC
022600010508    ***
022700010508     C                   ENDSR
022800010508   S***S
022801220719
022802220719      //=======================================================================
022803220719      // get headings
022804220719      //=======================================================================
022805220719
022806220719       begsr getHeadings;
022807220719
022808220719        o_trs = p@trs;
022809220719        chain p@trs trustFile;
022810220719        if %found;
022811220719         o_tname = tdescr;
022812220719        endif;
022813220719
022815220719        o_sub = p@sub;
022816220719        chain (p@trs : p@sub) subFile;
022817220719        if %found;
022818220719         o_sname = subdsc;
022819220719        endif;
022820220719
022821220719        o_plan = p@pln;
022825220719        chain (p@trs : p@sub : p@pln) planFile;
022826220719        if %found;
022827220719         o_pname = pdescr;
022830220719        endif;
022831220719
022839220719       endsr;
022840220719
022841220719      //=======================================================================
022842220719
022900010508     C* DISPLAY THE SCREEN
023000010508    ***
023100010508     C     $DISPLAY      BEGSR
023200010508    ***
023300020212     C                   WRITE     GBSREC
023400020212     C                   EXFMT     GBSCTL
023500010508    ***
023600010508     C                   ENDSR
023700010508   S***S
023800020212     C     $PREP2        BEGSR
023900020212    ***
024000020212      /FREE
024100020212       WRCOVTP = *BLANKS;
024200020212       O_LDESCR = *BLANKS;
024300020212       WRCLASS = *BLANKS;
024400130225       WRPREFX = *BLANKS;
024500020212       @ACTION = 'A';
024600020212       @STEP = 'STEP2';
024700020212      /END-FREE
024800020212    ***
024900020212     C                   ENDSR
025000020212   S***S
025100020212     C     $STEP2        BEGSR
025200020212    ***
025300020212     C                   EVAL      EMSG = @EMSG
025400020212     C                   EXFMT     GBSWRK
025500020212     C                   EVAL      EMSG = *BLANKS
025600020212     C                   EVAL      @EMSG = *BLANKS
025700020212    ***
025800020212     C                   IF        FKEY = F1
025900020212     C                   MOVE      'PREP1'       @STEP
026000020212     C                   LEAVESR
026100020212     C                   ENDIF
026200020212    ***
026300020213     C                   IF        FKEY = F3
026400020213     C                   MOVE      'T  '         @3
026500020213     C                   CALL      'FM001CL'
026600020213     C                   PARM                    @3
026700020213     C                   IF        @3 <> '*LR'
026800020213     C                   MOVE      @3            WRCOVTP
026900020213     C                   ENDIF
027000021003     C                   IF        WRCOVTP = 'NA'
027100021003     C                   EVAL      O_LDESCR = CON@NA
027200021003     C                   ELSE
027300020213     C                   MOVEL     'T'           KEY@TYPE
027400020213     C                   MOVE      WRCOVTP       KEY@CODE
027500211008     C     KEY#CODES     CHAIN     CODESR
027600020213     C                   IF        %FOUND(CODES)
027700020213     C                   MOVEL     LDESCR        O_LDESCR
027800020213     C                   ELSE
027900020213     C                   MOVE      *BLANKS       O_LDESCR
028000020213     C                   EVAL      @EMSG = 'COVERAGE TYPE IS INVALID'
028100020213     C                   ENDIF
028200021003     C                   ENDIF
028300020213     C                   LEAVESR
028400020213     C                   ENDIF
028500020321    ***
028600020321     C                   IF        FKEY = F5
028700020321     C                   MOVE      *BLANKS       @4                4
028800020321     C                   CALL      'FM034R'
028900020321     C                   PARM                    @4
029000020321     C                   IF        @4 <> '*LR '
029100020321     C                   MOVE      @4            WRCLASS
029200020321     C                   ENDIF
029300020321     C                   LEAVESR
029400020321     C                   ENDIF
029500020213    ***
029600020212     C                   EXSR      $VALIDATE
029700020212     C                   IF        @@V = 'Y'
029800020212     C                   EXSR      $UPDATE
029900020212     C                   MOVE      'PREP1'       @STEP
030000020212     C                   LEAVESR
030100020212     C                   ENDIF
030200020212    ***
030300020212     C                   ENDSR
030400020212   S***S
030500020212     C     $VALIDATE     BEGSR
030600020212    ***
030700020212     C                   EVAL      @@V = 'N'
030800020212     C                   MOVE      *BLANKS       O_LDESCR
030900020212    ***
031000020212     C                   IF        WRCOVTP = *BLANKS
031100020212     C                   EVAL      @EMSG = 'COVERAGE TYPE CANNOT BE BLANK'
031200020212     C                   LEAVESR
031300020212     C                   ENDIF
031400020212    ***
031500021003     C                   IF        WRCOVTP <> 'NA'
031600020212     C                   MOVEL     'T'           KEY@TYPE
031700020212     C                   MOVE      WRCOVTP       KEY@CODE
031800211008     C     KEY#CODES     CHAIN     CODESR
031900020212     C                   IF        %FOUND(CODES)
032000020212     C                   MOVEL     LDESCR        O_LDESCR
032100020212     C                   ELSE
032200020212     C                   EVAL      @EMSG = 'COVERAGE TYPE IS INVALID'
032300020212     C                   LEAVESR
032400020212     C                   ENDIF
032500021003     C                   ELSE
032600021003     C                   MOVEL(P)  CON@NA        O_LDESCR
032700021003     C                   ENDIF
032800020212    ***
032900020212     C                   IF        WRCLASS = *BLANKS
033000020212     C                   EVAL      @EMSG = 'CLASS CANNOT BE BLANK'
033100020212     C                   LEAVESR
033200020212     C                   ENDIF
033300020314    ***
033400021008     C                   IF        WRCOVTP <> 'NA'
033500211008     C     WRCLASS       CHAIN     CMSTR
033600020314     C                   IF        NOT %FOUND(CLASSMST)
033700211008     C                   EVAL      @EMSG = 'INVALID CLASS CODE'
033800020314     C                   LEAVESR
033900020314     C                   ENDIF
034000021008    *C*
034100020212     C                   IF        @ACTION = 'A' OR (@ACTION = 'C' AND
034200020212     C                             WRCOVTP <> SFCOVTP)
034300020212     C                   EVAL      KEY@CVT = 'T' + WRCOVTP
034400020212     C     KEY#CLSB      CHAIN(N)  FCLASS
034500020212     C                   IF        %FOUND(CLASS)
034600020212     C                   EVAL      @EMSG = 'T/S/P/COV TYPE ALREADY EXISTS'
034700020212     C                   LEAVESR
034800020212     C                   ENDIF
034900020212     C                   ENDIF
035000021008     C                   ENDIF
035100020212    ***
035200020212     C                   EVAL      @@V = 'Y'
035300020212    ***
035400020212     C                   ENDSR
035500020212   S***S
035600020314     C     $UPDATE       BEGSR
035700020212    ***
035800020314     C                   MOVE      *BLANKS       @HT28
035900020314    ***
036000020212     C                   IF        @ACTION = 'A'
036100020212     C                   CLEAR                   FCLASS
036200020212     C                   MOVE      KEY@TRS       CLTRST
036300020212     C                   MOVE      KEY@SUB       CLSUB#
036400020212     C                   MOVE      KEY@PLN       CLPLAN
036500020212     C                   EVAL      CLCOVTP = 'T' + WRCOVTP
036600020212     C                   MOVEL     WRCLASS       CLCLASS
036700130225     C                   MOVEL     WRPREFX       CLPREFX
036800020212     C                   WRITE     FCLASS
036900020314     C                   EVAL      @HT28 = 'COV/CLASS ADDED'
037000020314     C                   EXSR      $CLASSHST
037100020212     C                   LEAVESR
037200020212     C                   ENDIF
037300020212    ***
037400020314     C                   EVAL      @HT28 = 'CHANGED FROM CVT:' + SFCOVTP +
037500020314     C                             ' CLS:' + SFCLASS
037600020212     C                   EVAL      KEY@CVT = 'T' + SFCOVTP
037700020212     C     KEY#CLSB      CHAIN     FCLASS
037800020212     C                   IF        %FOUND(CLASS)
037900020212     C                   EVAL      CLCOVTP = 'T' + WRCOVTP
038000020212     C                   MOVEL     WRCLASS       CLCLASS
038100130225     C                   MOVEL     WRPREFX       CLPREFX
038200020212     C                   UPDATE    FCLASS
038300020314     C                   EXSR      $CLASSHST
038400020212     C                   ENDIF
038500020314    ***
038600020314     C                   ENDSR
038700020314   S***S
038800020314     C     $CLASSHST     BEGSR
038900020314    ***
039000020314     C                   CLEAR                   @TIMESTAMP
039100020314     C                   CLEAR                   RCLSHIST
039200020314     C                   MOVE      *BLANKS       @HT15
039300020314     C                   MOVE      *BLANKS       @HT30
039400020314     C                   MOVE      *BLANKS       @TS40
039500020314    ***
039600020314     C                   CALL      'TIMESTMP'
039700020314     C                   PARM                    @TS40
039800020314     C                   MOVEL     @TS40         @TIMESTAMP
039900020314    ***
040000020314     C     #TSCYMD       MULT      10000.0001    #8
040100020314     C                   EVAL      @HT30 = %EDITW(#8:'  /  /    ') +
040200020314     C                             ' ' + %EDITW(#TSTIME:'  :  :  ') + ' ' +
040300020314     C                             @TSUSER
040400020314    ***
040500020314     C                   EVAL      @HT15 = 'CVT:' + WRCOVTP + ' CLS:' +
040600020314     C                             WRCLASS
040700020314    ***
040800020314     C                   EVAL      HTSP = P@TSP
040900020314     C                   EVAL      HCT = WRCOVTP
041000020314     C                   MOVE      #TSCYMD       HDATE
041100020314     C                   MOVE      #TSTIME       HTIME
041200020314     C                   EVAL      HMSG = 'CVT:' + WRCOVTP + ' CLS:' +
041300020314     C                             WRCLASS + ' ' + @HT28
041400020314     C                   MOVE      @HT30         HMSG
041500020314     C                   WRITE     RCLSHIST
041600020212    ***
041700020212     C                   ENDSR
041800020212   S***S
041900020212     C     $CHKSELC      BEGSR
042000020212    ***
042100020212    1C                   DOU       %EOF(FM032D)
042200020212     C                   READC     GBSSFL
042300020212    2C                   IF        NOT %EOF(FM032D) AND SEL <> *BLANKS
042400020212    3C                   IF        SEL = 'C'
042500020212     C                   EVAL      WRCOVTP = SFCOVTP
042600020212     C                   EVAL      O_LDESCR = SFCVDES
042700020212     C                   EVAL      WRCLASS = SFCLASS
042800130225     C                   EVAL      WRPREFX = SFPREFX
042900020212     C                   EVAL      @ACTION = 'C'
043000020212     C                   EVAL      @STEP = *BLANKS
043100020212    4C                   DOU       @STEP = 'PREP1'
043200020212     C                   EXSR      $STEP2
043300020212    4C                   ENDDO
043400020212    3C                   ENDIF
043500020212    2C                   ENDIF
043600020212    1C                   ENDDO
043700020212    ***
043800020212     C                   MOVE      'PREP1'       @STEP
043900020212    ***
044000020212     C                   ENDSR
044100020212   S***S
