000100001206     F*********************************************************************
000200060327     F* fm064      - admin fee / bonus draw overide maintenance           *
000300001206     F*                                                                   *
000700060327     F* 03/27/06 dlk - adapted from FM082                                 *
000900001206     F*                                                                   *
001400001206     F*                                                                   *
001500001206     F*********************************************************************
001600060327     Fabover    UF A E           K DISK
001800060327     Fcarmst    IF   E           K DISK
001801060327     Fcodes     IF   E           K DISK
001900060327     Ffm064D    CF   E             WORKSTN INFDS(WSDS)
002000060328     F                                     SFILE(IO01S:RRN)
002200060328     D                 DS
002300060328     D  r2plncat3              1      3
002301060329     D  ppre                   1      1    inz('P')
002302060328     D  r2plncat               2      3
002303060328     D                 DS
002304060328     D  i_tsa                  1     10s 0
002305060328     D  i_trust                1      3s 0
002306060328     D  i_sub                  4      6s 0
002307060328     D  i_acc                  7     10s 0
002308060328     ***
002309060328     D WSDS            DS
002310060328     D  FKEY                 369    369A
002400001206     ***
002500001206     D  F1             C                   CONST(X'31')
002600001206     D  F2             C                   CONST(X'32')
002700001206     D  F3             C                   CONST(X'33')
002800001206     D  F4             C                   CONST(X'34')
002900001206     D  F5             C                   CONST(X'35')
003000001206     D  F6             C                   CONST(X'36')
003100001206     D  F7             C                   CONST(X'37')
003200001206     D  F8             C                   CONST(X'38')
003300001206     D  F9             C                   CONST(X'39')
003400001206     D  F10            C                   CONST(X'3A')
003500001206     D  F11            C                   CONST(X'3B')
003600001206     D  F12            C                   CONST(X'3C')
003700001206     D  F13            C                   CONST(X'B1')
003800001206     D  F14            C                   CONST(X'B2')
003900001206     D  F15            C                   CONST(X'B3')
004000001206     D  F16            C                   CONST(X'B4')
004100001206     D  F17            C                   CONST(X'B5')
004200001206     D  F18            C                   CONST(X'B6')
004300001206     D  F19            C                   CONST(X'B7')
004400001206     D  F20            C                   CONST(X'B8')
004500001206     D  F21            C                   CONST(X'B9')
004600001206     D  F22            C                   CONST(X'BA')
004700001206     D  F23            C                   CONST(X'BB')
004800001206     D  F24            C                   CONST(X'BC')
004900001206     ***
005000060331     D MSG             S             50A   DIM(14) CTDATA PERRCD(1)
005100010109     D @STEP           S              5A   INZ('STEP1')
005200010109     D #ISO            S               D   DATFMT(*ISO)
005300010109     D #USA            S               D   DATFMT(*USA)
005301060328     D #isa            S              8s 0
005302060328     D fee2txt         S             11a
005304060328     D p               s              1a   inz('P')
005400001206     ***
005500001206     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
005600001206     D                UDS
005700001206     D  TITLE                201    240
005800001206     ***
005900010109     C                   DOU       @STEP = 'EXIT'
006000010109     C     @STEP         CASEQ     'STEP1'       $STEP1
006100010109     C     @STEP         CASEQ     'STEP2'       $STEP2
006200010109     C     @STEP         CASEQ     'STEP3'       $STEP3
006300010109     C     @STEP         CASEQ     'STEP4'       $STEP4
006400001206     C                   ENDCS
006500001206     C                   ENDDO
006600001206     C*
006700001206     C                   MOVE      *ON           *INLR
006701060329
006801060328   S* **************************************************
006802060328   S* * step 1 - fill subfile w/o locking records
006803060328   S* **************************************************
008800001206     C     $STEP1        BEGSR
008900001206     C*
009000060329     C                   MOVEL     parmtsa       I_tsa
009001060329     C                   MOVEL     parmacname    I_acname
009100001206     C                   MOVE      *BLANKS       R1MSG
009200001206     C* CLEAR SFL
009300001206     C                   MOVEA     '011'         *IN(28)
009400001206     C                   WRITE     IO01C
009500001206     C                   MOVEA     '010'         *IN(28)
009600001206     C* SFL BUILD
009700060328     C                   Z-ADD     *ZERO         RRN               3 0
009800001206     C                   MOVE      '0'           @1STLOOP          1
009900001206     C*
010000060328     C     abkey1        SETLL     abover
010100060327    1C                   DOU       %EOF(abover)
010200060328     C     abkey1        READE(n)  abover
010201060328
010300060327    2C                   IF        NOT %EOF(abover)
010500001206     C                   CLEAR                   IO01S
010600001206     C                   MOVE      *ON           *IN28
010700001206     C                   MOVE      *OFF          *IN31
010702060331      * get carrier desc
010703060331*****C                   move      abcarr        SFcar
012101060331     c     sfcar         chain     carmst
012103060331     c                   if        %found(carmst)
012104060331     c                   movel     cname         sfcard
012105060331     c                   end
012106060331      * get plan cat desc
012107060331*****C                   move      abpcat        SFplncat
012109060331      /Free
012110060331        chain ('P' : sfplncat) codes;
012111060331      /END-FREE
012114060331     c                   if        %found(codes)
012115060331     c                   movel     ldescr        sfpcatd
012116060331     c                   end
012117060331
012118060328*****C                   move      abpcat        SFplncat
012119060328*****C                   Z-ADD     abovpp        SFpp
012200060328*****C                   Z-ADD     abovra        SFff
012300060328     C                   Z-ADD     abOVPC        SFPC
012301060329      * ymd to mdy
012600060327     C                   Z-ADD     abFRDT        #ISA
012700010122     C                   EXSR      $ISOUSA
012800010122     C                   Z-ADD     #ISA          SFFRDT
012801060329
012802060329      * ymd to mdy
013000060327     C                   Z-ADD     abTODT        #ISA
013100010122     C                   EXSR      $ISOUSA
013200010122     C                   Z-ADD     #ISA          SFTODT
013201060329
013400060328     C                   ADD       1             RRN
013500001206    3C                   IF        @1STLOOP = '0'
013600060328     C                   Z-ADD     RRN           SFLRRN
013700001206     C                   MOVE      '1'           @1STLOOP
013800001206    3C                   ENDIF
014101060328     C                   WRITE     IO01S
014200001206    2C                   ENDIF
014201060328
014400001206    1C                   ENDDO
014500060328
014600001206     C                   MOVEL(P)  'STEP2'       @STEP
014700001206     C                   MOVE      *BLANKS       R1MSG
014800001206     C*
014900001206     C                   ENDSR
016101060328   S* **************************************************
016102060329   S* * step 2 display screen 1
016103060328   S* **************************************************
016200010109     C     $STEP2        BEGSR
016300060328    * * display 1st screen
016401060329     C                   WRITE     IO01fkey
016402060328     C                   EXFMT     IO01C
016500010109     C                   MOVE      *BLANKS       R1MSG
016700010109    ***
016800010109     C                   IF        FKEY = F1
016900010109     C                   MOVEL(P)  'EXIT'        @STEP
017000010109     C                   LEAVESR
017100010109     C                   ENDIF
017200060328    *
017201060328    * * add new rec
017300010109     C                   IF        FKEY = F6
017400010109     C                   MOVEL(P)  'STEP3'       @STEP
017500060328     C                   MOVE      'A'           addorchg          1
017600010109     C                   LEAVESR
017700010109     C                   ENDIF
017800060331    * * get selected rec
017900060328     C                   IF        RRN > 0
018000010109     C                   EXSR      $CHKSELC
018001060329     c                   if        r1msg <> *blanks
018002060329     C                   leavesr
018100060329     C                   end
018101060329     C                   ENDIF
018200010109    ***
018300010109     C                   MOVEL(P)  'STEP1'       @STEP
018400010109    ***
018500010109     C                   ENDSR
019801060328   S*
019802060328   S* **************************************************
019803060329   S* * step 3 - clear screen 2 fields
019804060328   S* **************************************************
019900010109     C     $STEP3        BEGSR
020001060328     c                   clear                   abovrr
020002060331
020003060331     c                   clear                   r2car
020004060331     c                   clear                   r2card
020005060331     c                   clear                   r2plncat
020006060331     c                   clear                   r2pcatd
020007060331     c                   clear                   r2frdt
020008060331     c                   clear                   r2todt
020009060331     c                   clear                   r2ff
020011060331     c                   clear                   r2pp
020012060331     c                   clear                   r2pc
020013060331     c                   clear                   r2msg
021300010109     C                   MOVE      'STEP4'       @STEP
021500010109     C                   ENDSR
021600010109   S***S
021601060328   S* **************************************************
021602060328   S* * step 4 - display screen 2
021603060328   S* **************************************************
021700010109     C     $STEP4        BEGSR
021800010109    ***
021801060331     c     #step4        tag
021802060330*****C                   movel     fee2txt       R2feetxt
021900010109     C                   EXFMT     IO02R
022000010109     C                   MOVE      *BLANKS       R2MSG
022100060331    *** return to screen 1
022200010109    1C                   IF        FKEY = F1
022300010109     C                   MOVEL(P)  'STEP1'       @STEP
022400010109     C                   LEAVESR
022500010109    1C                   ENDIF
022501060331
024900060330    * * F4 = Carrier window
024901060330    1C                   IF        FKEY = F4
024902060330     C                   MOVE      *BLANKS       parmcar           3
024903060330     C                   CALL      'FM002R'
024904060330     C                   PARM                    parmcar
024906060331    2C                   IF        parmcar <> '*LR'
024911060330     C                   MOVEL(P)  parmcar       r2car
024912060331     C     r2car         CHAIN     carmst
024913060331     c                   clear                   r2card
024914060331     c                   if        %found(carmst)
024915060331     c                   movel     cname         r2card
024919060331     c                   end
024921060330    2C                   ENDIF
024922060331     c                   goto      #step4
024923060330    1C                   ENDIF
024924060330    ***
024925060331
024926060331    * * F5 = plan category
024927060331    1C                   IF        FKEY = F5
024928060331     C                   clear                   parmcode          3
024929060331     C                   MOVEL(P)  'P'           parmcode
024930060331     C                   CALL      'FM001CL'
024931060331     C                   PARM                    parmcode
024932060331    2C                   IF        parmcode <> '*LR'
024933060331     C                   MOVE      parmcode      r2plncat
024935060331     C     plncatkey     CHAIN     codes
024936060331     c                   clear                   r2pcatd
024937060331     c                   if        %found(codes)
024938060331     c                   movel     ldescr        r2pcatd
024940060331     c                   end
024941060331    2C                   ENDIF
024942060331     c                   goto      #step4
024943060331    1C                   ENDIF
024944060331
024945060331    * * validate screen 2 values
025000010109     C                   EXSR      $VALIDATE
025100010109    ***
025200060328     C                   IF        validrec = 'Y'
025300010109     C                   EXSR      $UPDATE
025400010109     C                   ENDIF
025500010109    ***
025600010109     C                   ENDSR
025900010109    ***
025901060328   S* **************************************************
025902060328      * VALIDATE VALUES
025904060328   S* **************************************************
026000010109     C     $VALIDATE     BEGSR
026100060329    *
026200060328     C                   MOVE      'N'           Validrec          1
026201060329
026202060329      * validate carrier
026203060329     C     r2car         CHAIN     carmst
026204060329     c                   clear                   r2card
026205060329     c                   if        %found(carmst)
026206060329     c                   movel     cname         r2card
026207060329     c                   else
026208060330     C                   MOVEL     MSG(1)        R2MSG
026209060329     C                   LEAVESR
026210060329     c                   end
026211060329
026212060329      * get plan category
026213060329     C     plncatkey     CHAIN     codes
026214060329     c                   clear                   r2pcatd
026215060329     c                   if        %found(codes)
026216060329     c                   movel     ldescr        r2pcatd
026217060329     c                   else
026218060330     C                   MOVEL     MSG(2)        R2MSG
026219060329     C                   LEAVESR
026220060329     c                   end
026221060329
028001060329    * * valid from date
028100010109     C                   IF        R2FRDT = 0
028200060329     C                   MOVEL(P)  MSG(3)        R2MSG
028300010109     C                   LEAVESR
028400010109    1C                   ENDIF
028600010109     C     *USA          TEST (DE)               R2FRDT
028700010109     C                   IF        %ERROR
028800060329     C                   MOVEL(P)  MSG(4)        R2MSG
028900010109     C                   LEAVESR
029000010109     C                   ENDIF
029200010109     C                   MOVE      R2FRDT        #USA
029300010109     C                   MOVE      #USA          #ISO
029400010109     C                   MOVE      #ISO          #FRISO            8 0
029500060329    *
029501060329    * * valid to date
029600010109    1C                   IF        R2TODT <> 0
029800010109     C     *USA          TEST (DE)               R2TODT
029900010109    2C                   IF        %ERROR
030000060329     C                   MOVEL(P)  MSG(5)        R2MSG
030100010109     C                   LEAVESR
030200010109    2C                   ENDIF
030400010109     C                   MOVE      R2TODT        #USA
030500010109     C                   MOVE      #USA          #ISO
030600010109     C                   MOVE      #ISO          #TOISO            8 0
030601060331    2C                   IF        #toiso < #friso
030602060331     C                   MOVEL(P)  MSG(14)       R2MSG
030603060331     C                   LEAVESR
030604060331    2C                   ENDIF
030800010109    1C                   ENDIF
030801060329
030900060329    * * valid flat fee
031000060329    1C                   IF        R2ff <> 999.99 and
031001060329    1C                             R2ff > 100.00
031100060329     C                   MOVEL     MSG(11)       R2MSG
031200010125     C                   LEAVESR
031300010125    1C                   ENDIF
034101060329
034102060329    * * valid % of prem
034103060518    1C                   IF        R2PP <> 999.9999 and
034104060518    1C                             R2PP > 100.0000
034105060329     C                   MOVEL     MSG(6)        R2MSG
034106060329     C                   LEAVESR
034107060329    1C                   ENDIF
034108060329    *
034109060329    * * valid % of com
034110060328    1C                   IF        R2PC <> 999.9999 and
034111060328    1C                             R2PC > 100.0000
034112060328     C                   MOVEL     MSG(7)        R2MSG
034113060328     C                   LEAVESR
034114060328    1C                   ENDIF
034115060330    * * only 1 selected
034116060330     c                   clear                   count             1 0
034117060330    1C                   if        r2ff <> 0
034118060330     c                   add       1             count
034119060330     c                   end
034120060330    1C                   if        r2pp <> 0
034121060330     c                   add       1             count
034122060330     c                   end
034123060330    1C                   if        r2pc <> 0
034124060330     c                   add       1             count
034125060330     c                   end
034126060330
034127060331     c                   if        count > 1 or count = 0
034128060330     C                   MOVEL     MSG(8)        R2MSG
034129060330     C                   leavesr
034130060330    1C                   end
034131060330
034132060330
034200060328     C                   MOVE      'Y'           Validrec
034300010109    ***
034400010109     C                   ENDSR
037200060328   S*
037201060328   S* **************************************************
037202060328      * update
037203060328   S* **************************************************
037300010109     C     $UPDATE       BEGSR
037400010109    ***
037500060328    1C                   IF        addorchg = 'A'
037700060328     C                   CLEAR                   abovrr
037800060329     C                   MOVE      parmab        abab
037801060329     C                   MOVEL     I_trust       abtrust
037802060328     C                   MOVEL     I_sub         absub
037803060328     C                   MOVEL     I_acc         abacct
037804060328*****C                   move      R2car         abcarr
037805060328*****C                   movel     'P'           abpcat
037806060328*****C                   move      R2plncat      abpcat
038000060327     C                   Z-ADD     #FRISO        abFRDT
038100060327     C                   Z-ADD     #TOISO        abTODT
038200060328     C                   Z-ADD     R2pc          abOVPC
038300060328*****C                   Z-ADD     R2pp          abOVPP
038400060328*****C                   Z-ADD     R2ff          abOVRA
038401060331     C                   MOVEL(P)  'STEP4'       @STEP
038402060331     C                   MOVEL     MSG(13)       R2MSG
038403060329
038404060331      * add rec, if error display error else change to Change mode after
038405060331      * the rec has been added
038406060331
038600060329     C                   WRITE(e)  abovrr
038601060329     c                   if        %error
038603060329     C                   MOVEL     MSG(10)       R2MSG
038604060331     c                   else
038605060331     c                   eval      addorchg = 'C'
038606060331     c     abkey         chain     abover
038607060329     c                   end
038608060329
038700010109     C                   LEAVESR
038800010109    1C                   ENDIF
038900060329    *
038901060329
038902060329     C**                 Z-ADD     #FRISO        fromymd
038903060329     C**                 Z-ADD     #TOISO        toymd
039000060329     C**   abkey         CHAIN     abover
039100060329    1C                   IF        %FOUND(abover)
039101060329     C                   MOVE      parmab        abab
040502060328     C                   MOVEL     I_trust       abtrust
040503060328     C                   MOVEL     I_sub         absub
040504060328     C                   MOVEL     I_acc         abacct
040505060328*****C                   move      R2car         abcarr
040506060328*****C                   movel     'P'           abpcat
040507060328*****C                   move      R2plncat      abpcat
040508060328     C                   Z-ADD     #FRISO        abFRDT
040509060328     C                   Z-ADD     #TOISO        abTODT
040510060328     C                   Z-ADD     R2pc          abOVPC
040511060328*****C                   Z-ADD     R2pp          abOVPP
040512060328*****C                   Z-ADD     R2ff          abOVRA
040600060328     C                   UPDATE    abovrr
040700010109     C                   MOVEL(P)  MSG(9)        R2MSG
040701060330
040702060330      * lock rec again to prevent someone else from updating it before
040703060330      * this screen is released
040704060330     C                   Z-ADD     #FRISO        fromymd
040705060330     C                   Z-ADD     #TOISO        toymd
040706060330     C     abkey         CHAIN     abover
040800010109    2C                   ENDIF
041000010109    ***
041100010109     C                   ENDSR
041200060328   S*
041201060328   S* **************************************************
041300060328      * CHECK SUBFILE SELECTION
041301060328   S* **************************************************
041500010109     C     $CHKSELC      BEGSR
041600010109    ***
041700060327     C                   DOU       %EOF(fm064D)
041800010109     C                   READC     IO01S
041900060327     C                   IF        NOT %EOF(fm064D) AND SEL <> *BLANKS
042000010109     C*
042100010109     C                   SELECT
042200010109     C                   WHEN      SEL = 'C'
042300010109     C                   EXSR      $CHGCTL
042400010109     C                   ENDSL
042500010109     C*
042600010109     C                   IF        R1MSG <> *BLANKS
042700010109     C                   LEAVESR
042800010109     C                   ENDIF
042900010109     C*
043000010109     C                   MOVE      *BLANKS       SEL
043100010109     C                   UPDATE    IO01S
043200010109     C*
043300010109     C                   ENDIF
043400010109     C                   ENDDO
043500010109    ***
043600010109     C                   ENDSR
043700060328   S*
043701060328   S* **************************************************
043800010109     C* CHANGE CONTROL ROUTINE
043801060328   S* **************************************************
044000010109     C     $CHGCTL       BEGSR
044100010109    ***
044200060328     C                   MOVE      'C'           addorchg                       ACTION TYPE
044300010109     C                   MOVE      *OFF          *IN30
044400010109     C                   EXSR      $LOADNLOCK
044500010109     C*
044600010109     C                   IF        R1MSG <> *BLANKS
044700010109     C                   LEAVESR
044800010109     C                   ENDIF
044900010109    ***
045000010109     C                   MOVE      '0'           @@E               1
045100010109     C                   DOU       @@E = '1'
045200010109     C*
045300010109     C                   EXSR      $STEP4
045400010109     C*
045500010109     C                   IF        @STEP = 'STEP1'
045600060329     C                   MOVE      @stephld      @STEP
045700010109     C                   MOVE      '1'           @@E
045800010109     C                   LEAVESR
045900010109     C                   ENDIF
046000010109     C*
046100010109     C                   ENDDO
046200010109    ***
046300010109     C                   ENDSR
046400060328   S*
046401060328   S* **************************************************
046500060329     C* LOAD SCREEN 2 & LOCK REC
046501060328   S* **************************************************
046700010109     C     $LOADNLOCK    BEGSR
046800010109    ***
046900060329     C                   MOVEL(P)  @STEP         @stephld          5
047000010109     C                   EXSR      $STEP3
047100060329     C                   MOVEL(P)  @stephld      @STEP
047200010109    ***
047300060328     C                   move      SFcar         R2car
047400060328     C                   MOVE      SFplncat      R2plncat
047500010109     C                   Z-ADD     SFFRDT        R2FRDT
047600010109     C                   Z-ADD     SFTODT        R2TODT
047700060328     C                   Z-ADD     SFpc          R2pc
047800060328*****C                   Z-ADD     SFff          R2ff
047900060328*****C                   Z-ADD     SFpp          R2pp
049001060328
049002060328      * get carrier description
049003060328     C     r2car         CHAIN     carmst
049004060328     c                   clear                   r2card
049005060328     c                   if        %found(carmst)
049006060328     c                   movel     cname         r2card
049007060328     c                   else
049008060328     c                   eval      r2card = '* INVALID CARRIER *'
049009060328     c                   end
049101060328
049102060328      * get plan category
049103060328     C     plncatkey     CHAIN     codes
049104060328     c                   clear                   r2pcatd
049105060328     c                   if        %found(codes)
049106060328     c                   movel     ldescr        r2pcatd
049107060328     c                   else
049108060328     c                   eval      r2pcatd = '* INVALID CATEGORY *'
049109060328     c                   end
049111060328    ***
049112060329     c                   movel     r2frdt        wk40              4 0
049113060329     c                   move      wk40          fromymd
049114060329     c                   move      r2frdt        wk40
049115060329     c                   movel     wk40          fromymd
049116060329
049117060329     c                   movel     r2todt        wk40
049118060329     c                   move      wk40          toymd
049119060330     c                   move      r2todt        wk40
049120060329     c                   movel     wk40          toymd
049121060329
049122060328     C     abkey         CHAIN     abover
049123060329     c                   if        not %found(abover)
049124060329     C                   MOVEL(P)  'STEP2'       @STEP
049125060329     C                   MOVEL     MSG(12)       R1MSG
049128060329     c                   end
049129060328     C*
049200010109     C                   ENDSR
049301060328   S* **************************************************
049302060329   S* * date change ymd - mdy
049303060328   S* **************************************************
049304060328     C     $ISOUSA       BEGSR
049305060328     C     *ISO          TEST (DE)               #ISA
049306060328     C                   IF        %ERROR
049307060328     C                   MOVE      *ZEROS        #ISA
049308060328     C                   ELSE
049309060328     C                   MOVE      #ISA          #ISO
049310060328     C                   MOVE      #ISO          #USA
049311060328     C                   MOVE      #USA          #ISA
049312060328     C                   ENDIF
049313060328     C                   ENDSR
049314060328   S*
049315060328   S* **************************************************
049317060329   S* * date change mdy - ymd
049318060328   S* **************************************************
049400010122     C     $USAISO       BEGSR
049500010122     C     *USA          TEST (DE)               #ISA
049600010122     C                   IF        %ERROR
049700010122     C                   MOVE      *ZEROS        #ISA
049800010122     C                   ELSE
049900010122     C                   MOVE      #ISA          #USA
050000010122     C                   MOVE      #USA          #ISO
050100010122     C                   MOVE      #ISO          #ISA
050200010122     C                   ENDIF
050300010122     C                   ENDSR
050301060327
050302060328   S* **************************************************
050303060328   S* * first cycle
050304060328   S* **************************************************
050305060327     C     *INZSR        BEGSR
050306060327
050307060329     C* parmtsa = pass t/s/a
050308060329     C* parmab = A-admin fee or B-bonus draw
050309060327     C     *ENTRY        PLIST
050310060329     C                   PARM                    parmab            1
050311060329     C                   PARM                    parmtsa          10
050314060329     C                   PARM                    parmacname       40
050315060327     C*
050316060329     c                   if        parmab = 'A'
050317060327     c                   eval      headab  = ' Admin Fee'
050318060327     c                   eval      feetxt  = 'Comm    '
050319060327     c                   eval      fee2txt = 'Commission '
050320060327     c                   else
050321060327     c                   eval      headab  = 'Bonus Draw'
050322060327     c                   eval      feetxt  = 'Admin   '
050323060327     c                   eval      fee2txt = 'Admin Fee  '
050324060403      * 98-*on = protect flat fee on the bonus draw - Future use
050326060403     c                   eval      *in98 = *on
050327060327     c                   end
050328060327
050329060327     C     *LIKE         DEFINE    abFRDT        #FRDT
050330060327     C     *LIKE         DEFINE    abTODT        #TODT
050331060328
050332060328     C     plncatkey     KLIST
050333060328     C                   KFLD                    p
050334060328     C                   KFLD                    r2plncat
050335060327     C*
050336060328     C     abkey1        KLIST
050337060329     C                   KFLD                    parmab
050338060327     C                   KFLD                    I_trust
050339060327     C                   KFLD                    I_sub
050340060328     C                   KFLD                    I_acc
050341060328     C     abkey         KLIST
050342060329     C                   KFLD                    parmab
050343060328     C                   KFLD                    I_trust
050344060328     C                   KFLD                    I_sub
050345060328     C                   KFLD                    I_acc
050346060328     C                   KFLD                    r2car
050347060328     C                   KFLD                    r2plncat3
050348060329     C                   KFLD                    fromymd           8 0
050349060329     C                   KFLD                    toymd             8 0
050350060327     C*
050351060327     C                   ENDSR
050500010109123456*8901234567890123456789012345678901234567890
050600010109      *  11111111112222222222333333333344444444445
050700010109** CTDATA MSG
050800060328INVALID CARRIER
050900060328INVALID PLAN CATEGORY
051000010109FROM DATE CANNOT BE ZERO
051100010109FROM DATE IS IN A NON-VALID FORMAT
051200010109TO DATE IS IN A NON-VALID FORMAT
051300010109%AGE OF PREMIUM CANNOT EXCEED 100%
051400010109%AGE OF COMMISSION CANNOT EXCEED 100%
051500060403PLEASE CHOOSE ONLY ONE OF THE OVERRIDES
051600010109UPDATE OF RECORD COMPLETE
051700010109REC EXISTS OR OPEN RECORD ALREADY EXISTS
051800060329FLAT FEE CANNOT EXCEED $100, use 999.99 for $0.00
051900060329RECORD NOT FOUND
052000060331THIS RECORD HAS BEEN ADDED
052100060331TO DATE CANNOT BE BEFORE THE FROM DATE
