000001061017     h option(*nodebugio) datfmt(*MDY)
000100001206     F*********************************************************************
000200120326     F* fm382      - COBRA Invoice Message maintenance                    *
000300001206     F*                                                                   *
000700120326     F* 03/26/12 dlk - adapted from FM380                                 *
000900001206     F*                                                                   *
001400001206     F*                                                                   *
001500001206     F*********************************************************************
001600120326     Fcinvmsg   UF A E           K DISK
001601120326     Fcinvmsgl1 iF   E           K DISK    rename(cinvmsgr:cinvmsgrl1)
001602120326     F                                     prefix(l_)
001603120326     Fcinvmsgl2 iF   E           K DISK    rename(cinvmsgr:cinvmsgrl2)
001604120326     F                                     prefix(l2)
001608120326     Fcinvmsgdlto  a E             DISK
001900120326     Ffm382D    CF   E             WORKSTN INFDS(WSDS)
002000060925     F                                     SFILE(io02S:RRN)
002001061004     F                                     SFILE(io04S:RR4)
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
0023200610170037 D wkcode          S                   like(s4code)
0023210610170037 D wktype          S                   like(s4type)
0023220610170037 D wkfrdtymd       S                   like(s4frdtymd)
0023230610170037 D wktodtymd       S                   like(s4todtymd)
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
006731060925    *
006732070614      * f8 = show by date
006733070614     c                   if        fkey = f8
006734061004     c                   exsr      #showbydate
006735061004     c                   iter
006736061004     c                   end
006772060925
006806060925      * edit values
006807060925
006808060925      * select only one
006809060925     C                   clear                   s1cnt             1 0
006810061002     c                   if        s1selglo <> *blanks
006811060925     C                   add       1             s1cnt
006812060925     c                   end
006828060925
006829061002     c                   if        s1cnt <> 1
006830061002     C                   MOVEL(P)  MSG(1)        s1msg
006831060925     c                   iter
006832060925     c                   end
006854061002
006855061004      * move to screen 2 once all edits are passed
006856061002     c                   leave
006857060925
006858060925    1C                   ENDDO
006859060925
006860060925     C                   MOVEL(P)  'STEP2'       @STEP
006861061002     C                   clear                   s1msg
006862060925     C*
006863060925     C                   ENDSR
006864060328   S* **************************************************
006865060925   S* * step 2 - fill subfile w/o locking records
006866060328   S* **************************************************
008800060925     C     $STEP2        BEGSR
008801060925
008900060925      * fill values for screen 2
008901060925     C                   clear                   s2typed
008902060925     C                   clear                   s2code
008903060925     C                   clear                   s2name
008904060925
009012060922
009013060925     c                   clear                   s2typed
009014060922     c                   select
009015061002     c                   when      s1selglo <> *blanks
009016110707     c                   eval      s2typed = 'GLOBAL      '
009017061002     C                   eval      s2type = 'GLO'
009033060922     c                   endsl
009034060922
009100060925     C                   MOVE      *BLANKS       r2MSG
009200001206     C* CLEAR SFL
009300001206     C                   MOVEA     '011'         *IN(28)
009400060925     C                   WRITE     io02C
009500001206     C                   MOVEA     '010'         *IN(28)
009600001206     C* SFL BUILD
009700060328     C                   Z-ADD     *ZERO         RRN               3 0
009800001206     C                   MOVE      '0'           @1STLOOP          1
009900001206     C*
010000120326     C     invkey        SETLL     cinvmsg
010100120326    1C                   DOU       %EOF(cinvmsg)
010200120326     C     invkey        READE(n)  cinvmsg
010201060328
010300120326    2C                   IF        NOT %EOF(cinvmsg)
010500060925     C                   CLEAR                   io02S
010600001206     C                   MOVE      *ON           *IN28
010700001206     C                   MOVE      *OFF          *IN31
012802060329      * ymd to mdy
013000120326     C                   Z-ADD     cifrdat       #ISA
013100010122     C                   EXSR      $ISOUSA
013200060922     C                   Z-ADD     #ISA          SFfrdt
013201060329
013202060922      * ymd to mdy
013203120326     C                   Z-ADD     citodat       #ISA
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
020001120326     c                   clear                   cinvmsgr
020002060331
020004060925     c                   clear                   r3code
020008060925     c                   clear                   r3coded
020009060925     c                   clear                   r3typed
020010060925     c                   clear                   r3frdt
020011060925     c                   clear                   r3todt
020013060925     c                   clear                   r3lin1
020014060925     c                   clear                   r3lin2
020015060925     c                   clear                   r3lin3
020016060925     c                   clear                   r3lin4
020017060925     c                   clear                   r3lin5
020018060925     c                   clear                   r3lin6
020019060925     c                   clear                   r3lin7
020020060925     c                   clear                   r3lin8
020021060925     c                   clear                   r3lin9
020022060925     c                   clear                   r3lin10
020023060925     c                   clear                   r3lin11
020024060925     c                   clear                   r3lin12
020025060925     c                   clear                   r3lin13
020026060925     c                   clear                   r3lin14
020027060925     c                   clear                   r3lin15
020035060925     c                   clear                   r3msg
020036061003
021300060925     C                   MOVE      'STEP5'       @STEP
021500010109     C                   ENDSR
021600061018   S*
021601060328   S* **************************************************
021602060328   S* * step 4 - display screen 2
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
021813061004     C                   move      s2type        r3type
021814061004     C                   move      s2typed       r3typed
021815061003     C                   move      s2code        r3code
021816061003     C                   move      s2name        r3coded
021817061003
021900060925     C                   EXFMT     io03R
022000060925     C                   MOVE      *BLANKS       r3MSG
022100061002    *** return to screen 2
022200010109    1C                   IF        FKEY = F1
022300060925     C                   MOVEL(P)  'STEP2'       @STEP
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
029900061002    2C                   IF        %ERROR or r3frday <> 01
030000060925     C                   MOVEL(P)  MSG(5)        r3MSG
030100010109     C                   LEAVESR
030200010109    2C                   ENDIF
030201060925     C                   MOVE      r3frdt        #USA
030202060417     C                   MOVE      #USA          #ISO
030203060417     C                   MOVE      #ISO          #begiso           8 0
034131060330
034132070620    * * valid to date (must be last day of month)
034134070620    1C****               IF        r3todt <> 0
034135060925     C     *USA          TEST (DE)               r3todt
034136060922    2C                   IF        %ERROR
034137060925     C                   MOVEL(P)  MSG(6)        r3MSG
034138060922     C                   LEAVESR
034139060922    2C                   ENDIF
034140061002
034143061002     C                   MOVE      r3todt        r3todth
034144061002     C                   MOVE      01            r3todthday
034145061002     C                   MOVE      r3todth       #USA
034146061002     C                   MOVE      #USA          #ISO
034147061002
034148061002      * get last day of month
034149061002     c                   move      #iso          workdt
034151061002     c                   adddur    1:*m          workdt
034152061002     c                   subdur    1:*d          workdt
034153061002
034154061002      * put orig to date back in #iso
034155061002     C                   MOVE      r3todt        #USA
034156061002     C                   MOVE      #USA          #ISO
034157061002
034161061003      * to date must be last day of month
034162061003     c                   if        #iso <> workdt
034163061002     C                   MOVEL(P)  MSG(11)       r3MSG
034164061002     C                   LEAVESR
034165061002     c                   end
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
034176070620     c****               else
034177061017
034178070620     C****               clear                   #endiso
034179061002
034180070620    1C****               ENDIF
034184061002
034185061003      * check for overlapp of date ranges
034186061003
034187120326     C     invkey        SETLL     cinvmsgl1
034188120326    3C                   DOU       %EOF(cinvmsgl1)
034189120326     C     invkey        READE     cinvmsgl1
034190120326    4C                   IF        NOT %EOF(cinvmsgl1)
034191061003
034192061003      * skip records never effective and the current record being changed
034193061003      * (when it is a change)
034194120326     c                   if        l_cifrdat = l_citodat or
034195120326     c                             (addorchg = 'C' and cifrdat = l_cifrdat
034196120326     c                              and citodat = l_citodat)
034197061003     c                   iter
034198061003     c                   end
034199061003
034200120326    5C                   if        (#begiso >= l_cifrdat and
034201120326    5C                               ((#begiso < l_citodat) or (l_citodat = 0)))
034202061003    5C                             or
034203120326    5C                             ((#endiso <> 0) and (#endiso > l_cifrdat) and
034204120326    5C                               (#endiso < l_citodat))
034205061003    5C                             or
034206120326    5C                             ((#endiso <> 0) and (#endiso > l_cifrdat) and
034207120326    5C                               (l_citodat = 0))
034208061003    5C                             or
034209120326    5C                             ((#endiso <> 0) and (#endiso > l_cifrdat) and
034210120326    5C                               (#begiso < l_cifrdat))
034211061003    5C                             or
034212120326    5C                             ((#begiso < l_cifrdat) and (#endiso = 0))
034213061003     C                   MOVEL(P)  MSG(15)       r3MSG
034214061003     C                   leavesr
034215061003    5C                   end
034216061003    4C                   ENDIF
034217061003    3C                   ENDDO
034218061003
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
037700120326     C                   CLEAR                   cinvmsgr
037801120326     C                   MOVEL     r3code        cicode
037802120326     C                   MOVEL     r3type        citype
037803120326     C                   Z-ADD     #begiso       cifrdat
037804120326     C                   Z-ADD     #endiso       citodat
037805120326     C                   MOVEL     r3lin1        cilin1
037806120326     C                   MOVEL     r3lin2        cilin2
037807120326     C                   MOVEL     r3lin3        cilin3
037808120326     C                   MOVEL     r3lin4        cilin4
037809120326     C                   MOVEL     r3lin5        cilin5
037810120326     C                   MOVEL     r3lin6        cilin6
037811120326     C                   MOVEL     r3lin7        cilin7
037812120326     C                   MOVEL     r3lin8        cilin8
037813120326     C                   MOVEL     r3lin9        cilin9
037814120326     C                   MOVEL     r3lin10       cilin10
037815120326     C                   MOVEL     r3lin11       cilin11
037816120326     C                   MOVEL     r3lin12       cilin12
037817120326     C                   MOVEL     r3lin13       cilin13
037818120326     C                   MOVEL     r3lin14       cilin14
037819120326     C                   MOVEL     r3lin15       cilin15
038401060925     C                   MOVEL(P)  'STEP5'       @STEP
038402060925     C                   MOVEL     MSG(13)       r3MSG
038403060329
038404060331      * add rec, if error display error else change to Change mode after
038405060331      * the rec has been added
038406060331
038600120326     C                   WRITE(e)  cinvmsgr
038601060329     c                   if        %error
038603060925     C                   MOVEL     MSG(10)       r3MSG
038604060331     c                   else
038605060331     c                   eval      addorchg = 'C'
038607120326     c     invkey2       chain     cinvmsg
038608060329     c                   end
038609060329
038700010109     C                   LEAVESR
038800010109    1C                   ENDIF
038900060329    *
038901060329
039100120326    1C                   IF        %FOUND(cinvmsg)
040502120326     C                   MOVEL     r3code        cicode
040503120326     C                   MOVEL     r3type        citype
040509120326     C                   Z-ADD     #begiso       cifrdat
040510120326     C                   Z-ADD     #endiso       citodat
040511120326     C                   MOVEL     r3lin1        cilin1
040512120326     C                   MOVEL     r3lin2        cilin2
040513120326     C                   MOVEL     r3lin3        cilin3
040514120326     C                   MOVEL     r3lin4        cilin4
040515120326     C                   MOVEL     r3lin5        cilin5
040516120326     C                   MOVEL     r3lin6        cilin6
040517120326     C                   MOVEL     r3lin7        cilin7
040518120326     C                   MOVEL     r3lin8        cilin8
040519120326     C                   MOVEL     r3lin9        cilin9
040520120326     C                   MOVEL     r3lin10       cilin10
040521120326     C                   MOVEL     r3lin11       cilin11
040522120326     C                   MOVEL     r3lin12       cilin12
040523120326     C                   MOVEL     r3lin13       cilin13
040524120326     C                   MOVEL     r3lin14       cilin14
040525120326     C                   MOVEL     r3lin15       cilin15
040600120326     C                   UPDATE(e) cinvmsgr
040601061003     c                   if        %error
040602061003     C                   MOVEL     MSG(10)       r3MSG
040603061003     c                   else
040700060925     C                   MOVEL(P)  MSG(9)        r3MSG
040701061003     c                   end
040702060330
040703060330      * lock rec again to prevent someone else from updating it before
040704060330      * this screen is released
040706120326     C     invkey2       CHAIN     cinvmsg
040800010109    2C                   ENDIF
041000010109    ***
041100010109     C                   ENDSR
041200060328   S*
041201060328   S* **************************************************
041300060328      * CHECK SUBFILE SELECTION
041301060328   S* **************************************************
041500010109     C     $CHKSELC      BEGSR
041600010109    ***
041700120326     C                   DOU       %EOF(fm382D)
041800060925     C                   READC     io02S
041900120326     C                   IF        NOT %EOF(fm382D) AND SEL <> *BLANKS
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
046324120326     C     invkey2       CHAIN     cinvmsg
046325120326     c                   if        %found(cinvmsg)
046326061018      * write to hold file
046327120326     c                   move      luser         ciuser
046328120326     c                   move      *date         cidate
046329120326     c                   time                    citime
046330120326     C                   write     cinvmsgdr
046332061018      * delete record
046333120326     C                   delete(e) cinvmsgr
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
047602061004     C                   move      s2type        r3type
047603061004     C                   move      s2typed       r3typed
047604061003     C                   move      s2code        r3code
047605061003     C                   move      s2name        r3coded
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
047618060925     c                   clear                   r3coded
047619061002     c                   movel     s2name        r3coded
047620061004     C                   MOVEL     s2type        r3type
047621061004     C                   MOVEL     s2typed       r3typed
049121060329
049122120326     c                   clear                   cinvmsgr
049123120326     C     invkey2       CHAIN     cinvmsg
049124120326     c                   if        not %found(cinvmsg)
049125060925     C                   MOVEL(P)  'STEP3'       @STEP
049126060925     C                   MOVEL     MSG(12)       r2MSG
049127060925     c                   else
049129060922
049131061002      * move values from file to screen 3
049132120326     C                   MOVEL     cicode        r3code
049133120326     C                   MOVEL     cilin1        r3lin1
049134120326     C                   MOVEL     cilin2        r3lin2
049135120326     C                   MOVEL     cilin3        r3lin3
049136120326     C                   MOVEL     cilin4        r3lin4
049137120326     C                   MOVEL     cilin5        r3lin5
049138120326     C                   MOVEL     cilin6        r3lin6
049139120326     C                   MOVEL     cilin7        r3lin7
049140120326     C                   MOVEL     cilin8        r3lin8
049141120326     C                   MOVEL     cilin9        r3lin9
049142120326     C                   MOVEL     cilin10       r3lin10
049143120326     C                   MOVEL     cilin11       r3lin11
049144120326     C                   MOVEL     cilin12       r3lin12
049145120326     C                   MOVEL     cilin13       r3lin13
049146120326     C                   MOVEL     cilin14       r3lin14
049147120326     C                   MOVEL     cilin15       r3lin15
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
050301061004   S* **************************************************
050302061004   S* * show by billing date
050303061004   S* **************************************************
050304061004     C     #showbydate   BEGSR
050305061004
050306061004      * fill values for screen 4
050307061004     C                   clear                   s4effdt
050333061004     C                   clear                   s4msg
050334061004
050335061017      * begin with the 1st of next month
050339061017     c                   move      *date         today                          mdyy
050340061017     c                   move      '01'          todaydd
050341061017     c                   move      today         workdtmdy
050342061017     c                   adddur    1:*m          workdtmdy
050343061017     c                   move      workdtmdy     s4effdt
050344061017
050345061017     C* do this screen until F12 is pressed
050346061017     c                   dou       fkey = f12
050347061004
050348061004     C                   MOVE      s4effdt       #isa
050349061004     C                   exsr      $usaiso
050350061004     C                   MOVE      #isa          s4effdtymd        8 0
050351061004
050352061004     C* CLEAR SFL
050353061004     C                   MOVEA     '011'         *IN(38)
050354061004     C                   WRITE     io04C
050355061004     C                   MOVEA     '010'         *IN(38)
050356061004     C* SFL BUILD
050357061004     C                   Z-ADD     *ZERO         RR4               3 0
050358061004     C                   MOVE      '0'           @1STLOOP          1
050359061004     C*
050360120326     C     *loval        SETLL     cinvmsgl2
050361120326    1C                   DOU       %EOF(cinvmsgl2)
050362120326     C                   READ      cinvmsgl2
050363061004
050364061004      * find all records for the date entered
050365061004
050366120326    2C                   IF        NOT %EOF(cinvmsgl2) and
050367120326     c                             (s4effdtymd >= l2cifrdat and
050368120326     c                              (l2citodat = 0 or l2citodat > s4effdtymd))
050369061004     C                   CLEAR                   io04S
050370061004     C                   MOVE      *ON           *IN38
050371061004     C                   MOVE      *OFF          *IN41
050372061004      * ymd to mdy
050373120326     C                   Z-ADD     l2cifrdat     #ISA
050374061004     C                   EXSR      $ISOUSA
050375061004     C                   Z-ADD     #ISA          s4frdt
050376061004
050377061004      * ymd to mdy
050378120326     C                   Z-ADD     l2citodat     #ISA
050379061004     C                   EXSR      $ISOUSA
050380061004     C                   Z-ADD     #ISA          s4todt
050381061004
050382061004      * set type
050383120326     c                   eval      s4type   = l2citype
050384061004     c                   select
050385120326     c                   when      l2citype = 'GLO'
050386061004     c                   eval      s4typed  = 'GLOBAL      '
050415070614
050416061004     c                   endsl
050417061004
050418061004      * set code
050419120326     c                   eval      s4code   = l2cicode
050420061004
050421061004     C                   ADD       1             RR4
050422061004    3C                   IF        @1STLOOP = '0'
050423061004     C                   Z-ADD     RR4           SFLRR4
050424061004     C                   MOVE      '1'           @1STLOOP
050425061004    3C                   ENDIF
050426061004     C                   WRITE     io04S
050427061004    2C                   ENDIF
050428061004
050429061004    1C                   ENDDO
050430061004
050431061004      * display screen 4
050432061004
050433061017     c                   if        rr4 = 0
050434061017     C                   clear                   io04S
050435061017     c                   eval      *in38 = *on
050436061017     c                   eval      rr4 = 1
050437061017     C                   Z-ADD     RR4           SFLRR4
050438061017     c                   eval      s4coded = '* NO RECORDS FOUND *'
050439061017     C                   WRITE     io04S
050440061017     c                   end
050441061017
050442061004     C                   WRITE     io04fkey
050443061004     C                   EXFMT     io04C
050444061004
050445061017      * process selection if the subfile has records
050446061017     c                   if        rr4 <> 0
050447120326     C                   DOU       %EOF(fm382D)
050448061004     C                   READC     io04S
050449120326     C                   IF        NOT %EOF(fm382D) AND s4sel <> *BLANKS
050450061004     C                   EXSR      #s4tos3
050451061004     C                   clear                   s4sel
050452061004     C                   UPDATE    io04s
050453061004     C                   ENDIF
050454061004     C                   ENDDO
050455061017     C                   end
050456061004
050457061004
050458061004
050459061004    1C                   ENDDO
050460061004     C                   ENDSR
050461060327
050462061004   S* **************************************************
050463061004     C* show screen 3 from screen 4
050464061004   S* **************************************************
050465061004     C     #s4tos3       BEGSR
050466061004    ***
050467061017
050468061004     C                   Z-ADD     S4frdt        r3frdt
050469061004     C                   Z-ADD     S4todt        r3todt
050470061017     C                   move      s4type        r3type
050471061017     C                   move      s4typed       r3typed
050472061004     C                   move      s4code        r3code
050473100607     C                   clear                   r3coded
050474100607     C                   movel     s4coded       r3coded
050475061004
050476061004     C                   MOVE      s4frdt        #USA
050477061004     C                   MOVE      #USA          #ISO
050478061004     C                   MOVE      #ISO          s4frdtymd         8 0
050479061004
050480061004     C                   clear                   s4todtymd         8 0
050481061004     c                   if        s4todt <> 0
050482061004     C                   MOVE      s4todt        #USA
050483061004     C                   MOVE      #USA          #ISO
050484061004     C                   MOVE      #ISO          s4todtymd
050485061004     c                   end
050486061004
050487061017      * fill invkeywk fields
050488061017     c                   move      s4code        wkcode
050489061017     c                   move      s4type        wktype
050490061017     c                   move      s4frdtymd     wkfrdtymd
050491061017     c                   move      s4todtymd     wktodtymd
050492061017
050493120326     c                   clear                   cinvmsgr
050494061017     c                   clear                   r3msg
050495061017     *******
050496061017      * stay on screen 3 until f1
050497061017     c                   dou       fkey = f1
050498061017
050499120326     C     invkeywk      CHAIN     cinvmsg
050500061004
050501061004      * move values from file to screen 3
050502120326     c                   if        %found(cinvmsg)
050503120326     C                   MOVEL     cicode        r3code
050504120326     C                   MOVEL     cilin1        r3lin1
050505120326     C                   MOVEL     cilin2        r3lin2
050506120326     C                   MOVEL     cilin3        r3lin3
050507120326     C                   MOVEL     cilin4        r3lin4
050508120326     C                   MOVEL     cilin5        r3lin5
050509120326     C                   MOVEL     cilin6        r3lin6
050510120326     C                   MOVEL     cilin7        r3lin7
050511120326     C                   MOVEL     cilin8        r3lin8
050512120326     C                   MOVEL     cilin9        r3lin9
050513120326     C                   MOVEL     cilin10       r3lin10
050514120326     C                   MOVEL     cilin11       r3lin11
050515120326     C                   MOVEL     cilin12       r3lin12
050516120326     C                   MOVEL     cilin13       r3lin13
050517120326     C                   MOVEL     cilin14       r3lin14
050518120326     C                   MOVEL     cilin15       r3lin15
050526061004     c                   end
050527061004
050528061004      * *in80-*on = position cursor to line 1 when "change"
050529061004     c                   eval      *in80 = *on
050530061004     c                   eval      addorchg = 'C'
050531061017
050532061004     C                   EXFMT     io03R
050533061017     c                   clear                   r3msg
050534061017
050535061004    *** return to screen 4
050536061004    1C                   IF        FKEY = F1
050537061017     C                   clear                   fkey
050538061017     C                   LEAVESR
050539061004    1C                   ENDIF
050540061004
050541061004    * * validate screen 3 values
050542061004     C                   EXSR      $VALIDATE
050543061017    * * update
050544120326     C                   IF        validrec = 'Y' and %found(cinvmsg)
050545120326     C                   MOVEL     r3code        cicode
050546120326     C                   MOVEL     r3type        citype
050547120326     C                   Z-ADD     #begiso       cifrdat
050548120326     C                   Z-ADD     #endiso       citodat
050549120326     C                   MOVEL     r3lin1        cilin1
050550120326     C                   MOVEL     r3lin2        cilin2
050551120326     C                   MOVEL     r3lin3        cilin3
050552120326     C                   MOVEL     r3lin4        cilin4
050553120326     C                   MOVEL     r3lin5        cilin5
050554120326     C                   MOVEL     r3lin6        cilin6
050555120326     C                   MOVEL     r3lin7        cilin7
050556120326     C                   MOVEL     r3lin8        cilin8
050557120326     C                   MOVEL     r3lin9        cilin9
050558120326     C                   MOVEL     r3lin10       cilin10
050559120326     C                   MOVEL     r3lin11       cilin11
050560120326     C                   MOVEL     r3lin12       cilin12
050561120326     C                   MOVEL     r3lin13       cilin13
050562120326     C                   MOVEL     r3lin14       cilin14
050563120326     C                   MOVEL     r3lin15       cilin15
050571120326     C                   UPDATE(e) cinvmsgr
050572061017     c                   if        %error
050573061017     C                   MOVEL     MSG(10)       r3MSG
050574061017     c                   else
050575061017     C                   MOVEL(P)  MSG(9)        r3MSG
050576061017     c                   end
050577061017      * lock rec again to prevent someone else from updating it before
050578061017      * this screen is released
050579061017
050580061017      * fill invkeywk fields
050581061017     c                   move      r3code        wkcode
050582061017     c                   move      r3type        wktype
050583061017     c                   move      #begiso       wkfrdtymd
050584061017     c                   move      #endiso       wktodtymd
050585061017
050586061017     C                   end
050587061004    ***
050588061017     c                   enddo
050589061017     *******
050590061004     C                   ENDSR
050591060328   S* **************************************************
050592060328   S* * first cycle
050593060328   S* **************************************************
050594060327     C     *INZSR        BEGSR
050595060328
050596060922     C     invkey        KLIST
050597060925     C                   KFLD                    s2code
050598060925     C                   KFLD                    s2type
050599060417
050600060922     C     invkey2       KLIST
050601060925     C                   KFLD                    s2code
050602060925     C                   KFLD                    s2type
050603060922     C                   KFLD                    sffrdtymd
050604061003     C                   KFLD                    sftodtymd
050605061004
050606061017     C     invkeywk      KLIST
050607061017     C                   KFLD                    wkcode
050608061017     C                   KFLD                    wktype
050609061017     C                   KFLD                    wkfrdtymd
050610061017     C                   KFLD                    wktodtymd
050611060327     C*
050612060327     C                   ENDSR
050613010109123456*8901234567890123456789012345678901234567890
050614010109      *  11111111112222222222333333333344444444445
050700061003** MESSAGES
050800061004ERROR - PLEASE SELECT ONE TYPE                               1
050900061004ERROR - PLEASE ENTER THE SUPER AGENCY CODE                   2
050901061004ERROR - PLEASE ENTER THE AGENCY CODE                         3
051100061004ERROR - INVALID SUPER AGENCY                                 4
051200061004ERROR - PLEASE ENTER A VALID FROM DATE (1ST OF THE MONTH)    5
051201061004ERROR - TO DATE IS NOT IN A VALID FORMAT                     6
051400061004ERROR - INVALID AGENCY                                       7
051500061018DELETE OF RECORD COMPLETE                                    8
051600061004UPDATE OF RECORD COMPLETE                                    9
051700061004ERROR - REC EXISTS OR OPEN RECORD ALREADY EXISTS            10
051800061004ERROR - TO DATE MUST BE THE LAST DAY OF THE MONTH           11
051900061004ERROR - RECORD NOT FOUND                                    12
052000061004THIS RECORD HAS BEEN ADDED                                  13
052100061004ERROR - TO DATE MUST BE AFTER FROM DATE                     14
052400061004ERROR - DATE RANGE OVERLAPPS AN EXISTING RECORD             15
052500061018DELETE OF RECORD HAS FAILED - CONTACT IS DEPARTMENT         16
052600070614ERROR - INVALID SALESMAN                                    17
052700070614ERROR - PLEASE ENTER THE SALESMAN CODE                      18
