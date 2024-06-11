000001061017     h option(*nodebugio) datfmt(*MDY)
000100001206     F*********************************************************************
000200090507     F* cob160     - Cobra subsidy maintenance                            *
000300001206     F*                                                                   *
000700090507     F* 05/07/09 dlk - adapted from FM380                                 *
000900001206     F*                                                                   *
001400001206     F*                                                                   *
001500001206     F*********************************************************************
001600090507     Fsubmem    UF A E           K DISK
001603090513     Fmember    iF   E           K DISK
001604090513     Faccmst    iF   E           K DISK
001900090507     Fcob160d   CF   E             WORKSTN INFDS(WSDS)
002000060925     F                                     SFILE(io02S:RRN)
002309061002     D                 DS
002310061017     D today                   1      8  0
002311061017     D todaydd                 3      4  0
002312061017     D                 DS
002313061017     D r3frdt                  1      8  0
002314061017     D r3frday                 3      4  0
002315061002     D                 DS
002316061002     D r3todth                 1      8  0
002317061002     D r3todthday              3      4  0
0023180610020037 D workdt          S               d   datfmt(*iso)
0023190610170037 D workdtmdy       S               d   datfmt(*usa)
002324061002     D WSDS            DS
002325061002     D  FKEY                 369    369A
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
004801060925     D  s1chk          s              4a
004900001206     ***
005000070614     D MSG             S             60A   DIM(18) CTDATA PERRCD(1)
005100010109     D @STEP           S              5A   INZ('STEP1')
005200010109     D #ISO            S               D   DATFMT(*ISO)
005300010109     D #USA            S               D   DATFMT(*USA)
005301060328     D #isa            S              8s 0
005400001206     ***
0054010905070600 D                 DS
0054020905070601 D  mtsa                   1     10  0
0054030905070601 D  mbtrst                 1      3  0
0054040905070601 D  mbsub#                 4      6  0
0054050905070601 D  mbacct                 7     10  0
005500001206     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
005600001206     D                UDS
005700060925     D  coname               201    240
005701061018     D  luser                  1     10
005800001206     ***
005900010109     C                   DOU       @STEP = 'EXIT'
006000010109     C     @STEP         CASEQ     'STEP1'       $STEP1
006100010109     C     @STEP         CASEQ     'STEP2'       $STEP2
006200010109     C     @STEP         CASEQ     'STEP3'       $STEP3
006300060925     C     @STEP         CASEQ     'STEP4'       $STEP4
006301060925     C     @STEP         CASEQ     'STEP5'       $STEP5
006400001206     C                   ENDCS
006500001206     C                   ENDDO
006600001206     C*
006700001206     C                   MOVE      *ON           *INLR
006701060329
006702060925   S* **************************************************
006703060925   S* * step 1 - display first screen
006704060925   S* **************************************************
006705060925     C     $STEP1        BEGSR
006706060925
006707060925     c                   clear                   io01r
006708060925     c                   move      coname        title
006709060925
006710060925     c                   dou       s1chk = 'DONE'
006711060925     c                   exfmt     io01r
006716061002     c                   clear                   s1msg
006726060925      * exit
006727060925     C                   IF        FKEY = F1
006728060925     C                   MOVEL(P)  'EXIT'        @STEP
006729060925     C                   LEAVESR
006730060925     C                   ENDIF
006808090507
006809090507     C* VALIDATE SSN
006810090507     C     s1ssn         CHAIN     MEMBER
006811090507     C                   if        not %found(member)
006812090507     C                   MOVEL(P)  MSG(1)        s1msg
006814090507     c                   iter
006815090507     c                   else
006817090507     c                   move      s1ssn         s2ssn
006818090507     c                   move      mtsa          s2acc
006819090507     c     mfname        cat       mlname:1      s2name
006820090507     C     acckey        CHAIN     accmst
006821090507     C                   if        %found(accmst)
006822090507     c                   movel     acnam1        s2aname
006823090507     c                   end
006824090507     c                   end
006864061002
006865061004      * move to screen 2 once all edits are passed
006866061002     c                   leave
006867060925
006868060925    1C                   ENDDO
006869060925
006870060925     C                   MOVEL(P)  'STEP2'       @STEP
006871061002     C                   clear                   s1msg
006872060925     C*
006873060925     C                   ENDSR
006874060328   S* **************************************************
006875060925   S* * step 2 - fill subfile w/o locking records
006876060328   S* **************************************************
008800060925     C     $STEP2        BEGSR
009028060922
009100060925     C                   MOVE      *BLANKS       r2MSG
009200001206     C* CLEAR SFL
009300001206     C                   MOVEA     '011'         *IN(28)
009400060925     C                   WRITE     io02C
009500001206     C                   MOVEA     '010'         *IN(28)
009600001206     C* SFL BUILD
009700060328     C                   Z-ADD     *ZERO         RRN               3 0
009800001206     C                   MOVE      '0'           @1STLOOP          1
009900001206     C*
010000090507     C     s1ssn         SETLL     submem
010100090507    1C                   DOU       %EOF(submem)
010200090507     C     s1ssn         READE(n)  submem
010201060328
010300090507    2C                   IF        NOT %EOF(submem)
010500060925     C                   CLEAR                   io02S
010600001206     C                   MOVE      *ON           *IN28
010700001206     C                   MOVE      *OFF          *IN31
012802060329      * ymd to mdy
013000090507     C                   Z-ADD     smfrdt        #ISA
013100010122     C                   EXSR      $ISOUSA
013200060922     C                   Z-ADD     #ISA          SFfrdt
013201060329
013202060922      * ymd to mdy
013203090507     C                   Z-ADD     smtodt        #ISA
013204060922     C                   EXSR      $ISOUSA
013205060922     C                   Z-ADD     #ISA          SFtodt
013206060922
013400060328     C                   ADD       1             RRN
013500001206    3C                   IF        @1STLOOP = '0'
013600060328     C                   Z-ADD     RRN           SFLRRN
013700001206     C                   MOVE      '1'           @1STLOOP
013800001206    3C                   ENDIF
014101060925     C                   WRITE     io02S
014200001206    2C                   ENDIF
014201060328
014400001206    1C                   ENDDO
014500060328
014501061018      * if no records found write KEEP / OVERLAY display to clear screen
014502061018     c                   if        rrn = 0
014503061018     c                   write     junk
014509061018     c                   end
014510061018
014600060925     C                   MOVEL(P)  'STEP3'       @STEP
014700060925     C                   MOVE      *BLANKS       r2MSG
014800001206     C*
014900001206     C                   ENDSR
016101060328   S* **************************************************
016102061002   S* * step 3 display screen 2
016103060328   S* **************************************************
016200060925     C     $STEP3        BEGSR
016300061002    * * display 2nd screen
016401060925     C                   WRITE     io02fkey
016402060925     C                   EXFMT     io02C
016500060925     C                   MOVE      *BLANKS       R2MSG
016703060922
016800010109     C                   IF        FKEY = F1
016900061002     C                   MOVEL(P)  'STEP1'       @STEP
017000010109     C                   LEAVESR
017100010109     C                   ENDIF
017200060328    *
017201060328    * * add new rec
017300070614     C                   IF        FKEY = F6
017400060925     C                   MOVEL(P)  'STEP4'       @STEP
017500060328     C                   MOVE      'A'           addorchg          1
017600010109     C                   LEAVESR
017700010109     C                   ENDIF
017800060331    * * get selected rec
017900060328     C                   IF        RRN > 0
018000010109     C                   EXSR      $CHKSELC
018001060925     c                   if        r2msg <> *blanks
018002060329     C                   leavesr
018100060329     C                   end
018101060329     C                   ENDIF
018200010109    ***
018300060925     C                   MOVEL(P)  'STEP2'       @STEP
018400010109    ***
018500010109     C                   ENDSR
019801060328   S*
019802060328   S* **************************************************
019803060925   S* * step 4 - clear screen 3 fields
019804060328   S* **************************************************
019900060925     C     $STEP4        BEGSR
020001090507     c                   clear                   submemr
020002060331
020010060925     c                   clear                   r3frdt
020011060925     c                   clear                   r3todt
020012090507     c                   clear                   r3ssn
020013090507     c                   clear                   r3name
020036061003
021300060925     C                   MOVE      'STEP5'       @STEP
021500010109     C                   ENDSR
021600061018   S*
021601060328   S* **************************************************
021602090507   S* * step 5 - display screen 3
021603060328   S* **************************************************
021700060925     C     $STEP5        BEGSR
021800010109    ***
021801060925     c     #STEP5        tag
021802061002
021803061002      * *in80-*on = position cursor to line 1 when "change"
021805061002     c                   eval      *in80 = *off
021807061002     c                   if        addorchg = 'C'
021808061002     c                   eval      *in80 = *on
021811061002     c                   end
021812061002
021813090507     C                   move      s2ssn         r3ssn
021814090507     C                   move      s2name        r3name
021817061003
021900060925     C                   EXFMT     io03R
022000060925     C                   MOVE      *BLANKS       r3MSG
022100090513    *** return to screen 2
022200010109    1C                   IF        FKEY = F1
022300090513     C                   MOVEL(P)  'STEP2'       @STEP
022400010109     C                   LEAVESR
022500010109    1C                   ENDIF
024944060331
024945061002    * * validate screen 3 values
025000010109     C                   EXSR      $VALIDATE
025100010109    ***
025200060328     C                   IF        validrec = 'Y'
025300010109     C                   EXSR      $UPDATE
025400010109     C                   ENDIF
025500010109    ***
025600010109     C                   ENDSR
025900010109    ***
025901060328   S* **************************************************
025902061002      * VALIDATE screen 3 VALUES
025904060328   S* **************************************************
026000010109     C     $VALIDATE     BEGSR
026100060329    *
026200060328     C                   MOVE      'N'           Validrec          1
026201060329
029501060922    * * valid from date
029800060925     C     *USA          TEST (DE)               r3frdt
029900090513    2C                   IF        %ERROR
030000060925     C                   MOVEL(P)  MSG(5)        r3MSG
030100010109     C                   LEAVESR
030200010109    2C                   ENDIF
030201060925     C                   MOVE      r3frdt        #USA
030202060417     C                   MOVE      #USA          #ISO
030203060417     C                   MOVE      #ISO          #begiso           8 0
034131060330
034132090513    * * valid to date
034135060925     C     *USA          TEST (DE)               r3todt
034136060922    2C                   IF        %ERROR
034137060925     C                   MOVEL(P)  MSG(6)        r3MSG
034138060922     C                   LEAVESR
034139060922    2C                   ENDIF
034153061002
034154090513      * put to date in #iso
034155061002     C                   MOVE      r3todt        #USA
034156061002     C                   MOVE      #USA          #ISO
034166061002
034167061002     C                   MOVE      #ISO          #endiso           8 0
034168061002
034169061004      * to date must be > from date
034170061002
034171061004     c                   if        #endiso <= #begiso
034172061002     C                   MOVEL(P)  MSG(14)       r3MSG
034173061002     C                   LEAVESR
034174061002     c                   end
034175061017
034219061003
034220060328     C                   MOVE      'Y'           Validrec
034300010109    ***
034400010109     C                   ENDSR
037200060328   S*
037201060328   S* **************************************************
037202060328      * update
037203060328   S* **************************************************
037300010109     C     $UPDATE       BEGSR
037301060922     C                   Z-ADD     #begiso       sffrdtymd
037302061003     C                   Z-ADD     #endiso       sftodtymd
037400010109    ***
037500060328    1C                   IF        addorchg = 'A'
037700090507     C                   CLEAR                   submemr
037803090513     C                   Z-ADD     r3ssn         smssn
037804090513     C                   Z-ADD     #begiso       smfrdt
037805090513     C                   Z-ADD     #endiso       smtodt
038401060925     C                   MOVEL(P)  'STEP5'       @STEP
038402060925     C                   MOVEL     MSG(13)       r3MSG
038403060329
038404060331      * add rec, if error display error else change to Change mode after
038405060331      * the rec has been added
038406060331
038600090507     C                   WRITE(e)  submemr
038601060329     c                   if        %error
038603060925     C                   MOVEL     MSG(10)       r3MSG
038604060331     c                   else
038605060331     c                   eval      addorchg = 'C'
038607090507     c     submkey2      chain     submem
038608060329     c                   end
038609060329
038700010109     C                   LEAVESR
038800010109    1C                   ENDIF
038900060329    *
038901060329
039100090507    1C                   IF        %FOUND(submem)
040509090513     C                   Z-ADD     #begiso       smfrdt
040510090513     C                   Z-ADD     #endiso       smtodt
040600090507     C                   UPDATE(e) submemr
040601061003     c                   if        %error
040602061003     C                   MOVEL     MSG(10)       r3MSG
040603061003     c                   else
040700060925     C                   MOVEL(P)  MSG(9)        r3MSG
040701061003     c                   end
040702060330
040703060330      * lock rec again to prevent someone else from updating it before
040704060330      * this screen is released
040706090507     C     submkey2      CHAIN     submem
040800010109    2C                   ENDIF
041000010109    ***
041100010109     C                   ENDSR
041200060328   S*
041201060328   S* **************************************************
041300060328      * CHECK SUBFILE SELECTION
041301060328   S* **************************************************
041500010109     C     $CHKSELC      BEGSR
041600010109    ***
041700090507     C                   DOU       %EOF(cob160d)
041800060925     C                   READC     io02S
041900090507     C                   IF        NOT %EOF(cob160d) AND SEL <> *BLANKS
042000010109     C*
042100010109     C                   SELECT
042101061018      * change
042200010109     C                   WHEN      SEL = 'C'
042300010109     C                   EXSR      $CHGCTL
042301061018      * delete
042302061018     C                   WHEN      SEL = 'D'
042303061018     C                   EXSR      $DLTCTL
042400010109     C                   ENDSL
042500010109     C*
042600060925     C                   IF        r2MSG <> *BLANKS
042700010109     C                   LEAVESR
042800010109     C                   ENDIF
042900010109     C*
043000010109     C                   MOVE      *BLANKS       SEL
043100060925     C                   UPDATE    io02S
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
044600060925     C                   IF        r2MSG <> *BLANKS
044700010109     C                   LEAVESR
044800010109     C                   ENDIF
044900060925    *
045000010109     C                   MOVE      '0'           @@E               1
045100010109     C                   DOU       @@E = '1'
045200010109     C*
045300060925     C                   EXSR      $STEP5
045400010109     C*
045500060925     C                   IF        @STEP = 'STEP2'
045600060925     C**                 MOVE      @stephld      @STEP
045700060925     C                   MOVE      '1'           @@E
045800060925     C                   LEAVESR
045900060925     C                   ENDIF
046000060925
046100010109     C                   ENDDO
046200060925    *
046300010109     C                   ENDSR
046301061018
046302061018   S* **************************************************
046303061018     C* DELETE CONTROL ROUTINE
046304061018   S* **************************************************
046305061018     C     $DLTCTL       BEGSR
046306061018    ***
046307061018     C                   exfmt     confirm                                      ACTION TYPE
046308061018
046310061018     C                   if        yorn = 'Y'
046311061018
046312061018     C                   clear                   sffrdtymd
046313061018     C                   clear                   sftodtymd
046314061018     C                   MOVE      sffrdt        #USA
046315061018     C                   MOVE      #USA          #ISO
046316061018     C                   MOVE      #ISO          sffrdtymd
046317061018     c                   if        sftodt <> 0
046318061018     C                   MOVE      sftodt        #USA
046319061018     C                   MOVE      #USA          #ISO
046320061018     C                   MOVE      #ISO          sftodtymd
046321061018     c                   end
046323061018
046324090507     C     submkey2      CHAIN     submem
046325090507     c                   if        %found(submem)
046332061018      * delete record
046333090507     C                   delete(e) submemr
046334061018
046335061018     c                   if        %error
046336061018     C                   MOVEL     MSG(16)       r2MSG
046337061018     c                   else
046338061018     C                   MOVEL     MSG(8)        r2MSG
046339061018     c                   end
046340061018
046341061018     c                   end
046342061018     c                   end
046343061018
046344061018     c                   MOVEL(P)  'STEP2'       @STEP
046345061018
046346061018     C                   ENDSR
046400060328   S*
046401060328   S* **************************************************
046500061003     C* LOAD SCREEN 3 & LOCK REC
046501060328   S* **************************************************
046700010109     C     $LOADNLOCK    BEGSR
046800010109    ***
046900060925     C**                 MOVEL(P)  @STEP         @stephld          5
047000060925     C**                 EXSR      $STEP4
047100060925     C**                 MOVEL(P)  @stephld      @STEP
047200010109    ***
047600060925     C                   Z-ADD     SFfrdt        r3frdt
047601060925     C                   Z-ADD     SFtodt        r3todt
047606060922
047607060922     C                   MOVE      sffrdt        #USA
047608060922     C                   MOVE      #USA          #ISO
047609060922     C                   MOVE      #ISO          sffrdtymd         8 0
047610060922
047611061003     C                   clear                   sftodtymd         8 0
047612061003     c                   if        sftodt <> 0
047613061003     C                   MOVE      sftodt        #USA
047614061003     C                   MOVE      #USA          #ISO
047615061003     C                   MOVE      #ISO          sftodtymd
047616061003     c                   end
047617061003
047620090507     C                   MOVEL     s2ssn         r3ssn
047621090507     C                   MOVEL     s2name        r3name
049121060329
049122090507     c                   clear                   submemr
049123090507     C     submkey2      CHAIN     submem
049124090507     c                   if        not %found(submem)
049125060925     C                   MOVEL(P)  'STEP3'       @STEP
049126060925     C                   MOVEL     MSG(12)       r2MSG
049127060925     c                   else
049128090507      * move values from file to screen 3
049129060922
049155060925     c                   end
049156060922
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
050455060327
050584060328   S* **************************************************
050585060328   S* * first cycle
050586060328   S* **************************************************
050587060327     C     *INZSR        BEGSR
050588060328
050593090507     C     submkey2      KLIST
050594090507     C                   KFLD                    s2ssn
050596060922     C                   KFLD                    sffrdtymd
050597061003     C                   KFLD                    sftodtymd
050598090513     C     acckey        KLIST
050599090513     C                   KFLD                    mbtrst
050600090513     C                   KFLD                    mbsub#
050601090513     C                   KFLD                    mbacct
050602061004
050604060327     C*
050605060327     C                   ENDSR
050606010109123456*8901234567890123456789012345678901234567890
050607010109      *  11111111112222222222333333333344444444445
050700061003** MESSAGES
050800090507ERROR - PLEASE ENTER A VALID SSN                             1
050900090513ERROR -                                                      2
050901090513ERROR -                                                      3
051100090513ERROR -                                                      4
051200061004ERROR - PLEASE ENTER A VALID FROM DATE (1ST OF THE MONTH)    5
051201061004ERROR - TO DATE IS NOT IN A VALID FORMAT                     6
051400090513ERROR -                                                      7
051500061018DELETE OF RECORD COMPLETE                                    8
051600061004UPDATE OF RECORD COMPLETE                                    9
051700061004ERROR - REC EXISTS OR OPEN RECORD ALREADY EXISTS            10
051800090513ERROR -                                                     11
051900061004ERROR - RECORD NOT FOUND                                    12
052000061004THIS RECORD HAS BEEN ADDED                                  13
052100061004ERROR - TO DATE MUST BE AFTER FROM DATE                     14
052400061004ERROR - DATE RANGE OVERLAPPS AN EXISTING RECORD             15
052500061018DELETE OF RECORD HAS FAILED - CONTACT IS DEPARTMENT         16
052600090513ERROR -                                                     17
052700090513ERROR -                                                     18
