000100001206     F*********************************************************************
000200060417     F* fm065      - Carrier begin date maintenance                       *
000300001206     F*                                                                   *
000700060417     F* 04/17/06 dlk - adapted from FM064                                 *
000900001206     F*                                                                   *
001400001206     F*                                                                   *
001500001206     F*********************************************************************
001600060417     Fcarbeg    UF A E           K DISK
001800060327     Fcarmst    IF   E           K DISK
001900060417     Ffm065D    CF   E             WORKSTN INFDS(WSDS)
002000060328     F                                     SFILE(IO01S:RRN)
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
010000060417     C     cbkey1        SETLL     carbeg
010100060417    1C                   DOU       %EOF(carbeg)
010200060417     C     cbkey1        READE(n)  carbeg
010201060328
010300060417    2C                   IF        NOT %EOF(carbeg)
010500001206     C                   CLEAR                   IO01S
010600001206     C                   MOVE      *ON           *IN28
010700001206     C                   MOVE      *OFF          *IN31
010702060331      * get carrier desc
010703060417*****C                   move      cbcarr        SFcar
012101060331     c     sfcar         chain     carmst
012103060331     c                   if        %found(carmst)
012104060331     c                   movel     cname         sfcard
012105060331     c                   end
012802060329      * ymd to mdy
013000060417     C                   Z-ADD     cbbegdt       #ISA
013100010122     C                   EXSR      $ISOUSA
013200060417     C                   Z-ADD     #ISA          SFbegdt
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
020001060417     c                   clear                   carbegr
020002060331
020003060331     c                   clear                   r2car
020004060331     c                   clear                   r2card
020008060417     c                   clear                   r2begdt
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
029501060417    * * valid date
029600060417    1C                   IF        R2begdt <> 0
029800060417     C     *USA          TEST (DE)               R2begdt
029900010109    2C                   IF        %ERROR
030000060329     C                   MOVEL(P)  MSG(5)        R2MSG
030100010109     C                   LEAVESR
030200010109    2C                   ENDIF
030201060417     C                   MOVE      R2begdt       #USA
030202060417     C                   MOVE      #USA          #ISO
030203060417     C                   MOVE      #ISO          #begiso           8 0
030800010109    1C                   ENDIF
034131060330
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
037700060417     C                   CLEAR                   carbegr
037801060417     C                   MOVEL     I_trust       cbtrust
037802060417     C                   MOVEL     I_sub         cbsub
037803060417     C                   MOVEL     I_acc         cbacct
037804060417*****C                   move      R2car         cbcarr
038100060417     C                   Z-ADD     #begiso       cbbegdt
038401060331     C                   MOVEL(P)  'STEP4'       @STEP
038402060331     C                   MOVEL     MSG(13)       R2MSG
038403060329
038404060331      * add rec, if error display error else change to Change mode after
038405060331      * the rec has been added
038406060331
038600060417     C                   WRITE(e)  carbegr
038601060329     c                   if        %error
038603060329     C                   MOVEL     MSG(10)       R2MSG
038604060331     c                   else
038605060331     c                   eval      addorchg = 'C'
038606060417     c     cbkey         chain     carbeg
038607060329     c                   end
038608060329
038700010109     C                   LEAVESR
038800010109    1C                   ENDIF
038900060329    *
038901060329
039100060417    1C                   IF        %FOUND(carbeg)
040502060417     C                   MOVEL     I_trust       cbtrust
040503060417     C                   MOVEL     I_sub         cbsub
040504060417     C                   MOVEL     I_acc         cbacct
040505060417*****C                   move      R2car         cbcarr
040509060417     C                   Z-ADD     #begiso       cbbegdt
040600060417     C                   UPDATE    carbegr
040700010109     C                   MOVEL(P)  MSG(9)        R2MSG
040701060330
040702060330      * lock rec again to prevent someone else from updating it before
040703060330      * this screen is released
040706060417     C     cbkey         CHAIN     carbeg
040800010109    2C                   ENDIF
041000010109    ***
041100010109     C                   ENDSR
041200060328   S*
041201060328   S* **************************************************
041300060328      * CHECK SUBFILE SELECTION
041301060328   S* **************************************************
041500010109     C     $CHKSELC      BEGSR
041600010109    ***
041700060417     C                   DOU       %EOF(fm065D)
041800010109     C                   READC     IO01S
041900060417     C                   IF        NOT %EOF(fm065D) AND SEL <> *BLANKS
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
047600060417     C                   Z-ADD     SFbegdt       R2begdt
049001060328
049002060328      * get carrier description
049003060328     C     r2car         CHAIN     carmst
049004060328     c                   clear                   r2card
049005060328     c                   if        %found(carmst)
049006060328     c                   movel     cname         r2card
049007060328     c                   else
049008060328     c                   eval      r2card = '* INVALID CARRIER *'
049009060328     c                   end
049121060329
049122060417     C     cbkey         CHAIN     carbeg
049123060417     c                   if        not %found(carbeg)
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
050308060417     C* parmacname = pass acc name
050309060327     C     *ENTRY        PLIST
050311060329     C                   PARM                    parmtsa          10
050314060329     C                   PARM                    parmacname       40
050328060327
050330060417     C     *LIKE         DEFINE    cbbegdt       #begdt
050331060328
050336060417     C     cbkey1        KLIST
050338060327     C                   KFLD                    I_trust
050339060327     C                   KFLD                    I_sub
050340060328     C                   KFLD                    I_acc
050341060417
050342060417     C     cbkey         KLIST
050343060328     C                   KFLD                    I_trust
050344060328     C                   KFLD                    I_sub
050345060328     C                   KFLD                    I_acc
050346060328     C                   KFLD                    r2car
050350060327     C*
050351060327     C                   ENDSR
050500010109123456*8901234567890123456789012345678901234567890
050600010109      *  11111111112222222222333333333344444444445
050700010109** CTDATA MSG
050800060328INVALID CARRIER
050900060417
051000060417
051100060417
051200060417BEGIN DATE IS NOT IN A VALID FORMAT
051300060417
051400060417
051500060417
051600010109UPDATE OF RECORD COMPLETE
051700010109REC EXISTS OR OPEN RECORD ALREADY EXISTS
051800060417
051900060329RECORD NOT FOUND
052000060331THIS RECORD HAS BEEN ADDED
052100060417
