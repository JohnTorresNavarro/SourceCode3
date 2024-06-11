000001061017     h option(*nodebugio) datfmt(*MDY)
000100001206     F*********************************************************************
000200180131     F* db472      - Plan dependency file maintenance                     *
000300001206     F*                                                                   *
000700180131     F* 01/31/18 dlk - adapted from FM382                                 *
000900180205     F* 02/05/18 dlk - no time to finish this now, maybe come back later. *
000901191211     F* 12/09/19 dlk - finish this pgm                                    *
000902180205     F*                                                                   *
001400001206     F*                                                                   *
001500001206     F*********************************************************************
001900180131     Fdb472D    CF   E             WORKSTN INFDS(WSDS)
002000060925     F                                     SFILE(io02S:RRN)
002001191209     F                                     SFILE(SF01:RR1)
002002191209     F                                     SFILE(SF02:RR2)
002003191209     Fdb470in   UF A E           K DISK
002004191206     Fplnmst    iF   E           K DISK
002005191206     Faccmst    iF   E           K DISK
002006191209     Fpctmst    iF   E           K DISK
0023180610020037 D workdt          S               d   datfmt(*iso)
0023190610170037 D workdtmdy       S               d   datfmt(*usa)
002320191209     d rr1             s              5  0
002321191209     d rr2             s              5  0
002322191209     d firsttime       s              1
002323191209     d holdacc         s             10s 0
002324191209     D                 DS
002325191209     D  wktsa                  1     10s 0
002326191209     D  wkt                    1      3s 0
002327191209     D  wks                    4      6s 0
002328191209     D  wka                    7     10s 0
002329191209     D                 DS
002330191209     D  s1tsa                  1     10s 0
002331191209     D  s1t                    1      3s 0
002332191209     D  s1s                    4      6s 0
002333191209     D  s1a                    7     10s 0
002334191209     D WSDS            DS
002335191209     D  FKEY                 369    369A
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
006772060925
006807060925
0068081912090070 C* F8 - display type window
006809191209     c                   if        *inkh
0068101912090073 C                   exsr      #dspacc
006811191209     C                   MOVEL(P)  'STEP1'       @STEP
006812191209     c                   leavesr
006813191209     c                   end
006814191209
006815180131      * edit acc #
006828060925
006829180131       chain (s1t:s1s:s1a) accmst;
006830180131       if not %found(accmst);
006831180131       s1msg = msg(1);
006832180131       iter;
006833180131       endif;
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
008802191209      * fill values for screen 2
009200001206     C* CLEAR SFL
009300001206     C                   MOVEA     '011'         *IN(28)
009400060925     C                   WRITE     io02C
009500001206     C                   MOVEA     '010'         *IN(28)
009501191209
009502191209     C                   CLEAR                   r2MSG
009503191209     C                   clear                   s2aname
009504191209     C                   movel     acnam1        s2aname
009505191209
009600001206     C* SFL BUILD
009700060328     C                   Z-ADD     *ZERO         RRN               3 0
009800001206     C                   MOVE      '0'           @1STLOOP          1
009900001206     C*
010000191209     C     tsakey        SETLL     db470in
010100191209    1C                   DOU       %EOF(db470in)
010200191209     C     tsakey        READE(n)  db470in
010201060328
010300191209    2C                   IF        NOT %EOF(db470in)
010500060925     C                   CLEAR                   io02S
010600001206     C                   MOVE      *ON           *IN28
010700001206     C                   MOVE      *OFF          *IN31
010701180131       sfplan1 = d7pln1#;
010702191209       sfplan1t = D7PLN1TYPE;
010703191209       sfplan2 = d7pln2#;
010704191209       sfplan2t = D7PLN2TYPE;
010705180131       sfstat  = d7status;
010706180131
012802180131      * get plan descriptions
012804180131       chain (d7trust:d7sub:d7pln1#) plnmst;
012805180131       if %found(plnmst);
012806180131        sfplan1d = pdescr;
012807180131       endif;
012808180131
012809180131       chain (d7trust:d7sub:d7pln2#) plnmst;
012810180131       if %found(plnmst);
012811180131        sfplan2d = pdescr;
012812180131       endif;
012813180131
012814191209      * get plan category type descriptions
012815191209
012816191209       if    d7pln1type <> *blanks;
012817191209       chain (D7PLN1TYPE) pctmst;
012818191209       if %found(pctmst);
012819191209       SFP1TDES = pcdes;
012820191209       endif;
012821191209       endif;
012822191209
012823191209       if    d7pln2type <> *blanks;
012824191209       chain (D7PLN2TYPE) pctmst;
012825191209       if %found(pctmst);
012826191209       SFP2TDES = pcdes;
012827191209       endif;
012828191209       endif;
012829191209
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
016300191209    * * display subfile
016401060925     C                   WRITE     io02fkey
016402060925     C                   EXFMT     io02C
016500060925     C                   MOVE      *BLANKS       R2MSG
016703060922
016704191209    * * F1 return
016800010109     C                   IF        FKEY = F1
016900061002     C                   MOVEL(P)  'STEP1'       @STEP
017000010109     C                   LEAVESR
017100010109     C                   ENDIF
017200060328    *
017201191209    * * F6 add new rec
017300070614     C                   IF        FKEY = F6
017400060925     C                   MOVEL(P)  'STEP4'       @STEP
017500060328     C                   MOVE      'A'           addorchg          1
017600010109     C                   LEAVESR
017700010109     C                   ENDIF
017800060331    * * get selected rec
017900060328     C                   IF        RRN > 0
018000010109     C                   EXSR      $CHKSELC
018002060925     c                   if        r2msg <> *blanks
018003060329     C                   leavesr
018100060329     C                   end
018101060329     C                   ENDIF
018200010109    ***
018300060925     C                   MOVEL(P)  'STEP2'       @STEP
018400010109    ***
018500010109     C                   ENDSR
019801060328   S*
019802060328   S* **************************************************
019803191209   S* * step 4 - clear screen 3 fields for add new record
019804060328   S* **************************************************
019900060925     C     $STEP4        BEGSR
020001191209     c                   clear                   db470inr
020002060331
020035060925     c                   clear                   r3msg
020036191209     c                   clear                   R3PRIPLN
020037191209     c                   clear                   R3PRITYPE
020038191209     c                   clear                   R3DEPPLN
020039191209     c                   clear                   R3DEPTYP
020040191209     c                   clear                   R3COBRA
020041191209     c                   clear                   R3NOTE
020042191209     c                   clear                   R3STAT
020043191209     c                   clear                   R3PPDES
020044191209     c                   clear                   R3PPTDES
020045191209     c                   clear                   R3DPDES
020046191209     c                   clear                   R3DPTDES
020050061003
021300060925     C                   MOVE      'STEP5'       @STEP
021500010109     C                   ENDSR
021600061018   S*
021601060328   S* **************************************************
021602191209   S* * step 5 - display screen 3
021603060328   S* **************************************************
021700060925     C     $STEP5        BEGSR
021802061002
021803061002      * *in80-*on = position cursor to line 1 when "change"
021805061002     c                   eval      *in80 = *off
021807061002     c                   if        addorchg = 'C'
021808061002     c                   eval      *in80 = *on
021811061002     c                   end
021812061002
021813191209      * get curect descriptions
021814191211       clear r3ppdes;
021815191209       chain (s1t:s1s:R3PRIPLN) plnmst;
021816191209       if %found(plnmst);
021817191209        r3ppdes = pdescr;
021818191209       endif;
021819191209
021820191211       clear r3dpdes;
021821191209       chain (s1t:s1s:r3deppln) plnmst;
021822191209       if %found(plnmst);
021823191209        r3dpdes = pdescr;
021824191209       endif;
021825191209
021826191211       clear r3pptdes;
021827191209       chain (r3pritype) pctmst;
021828191209       if %found(pctmst);
021829191209       r3pptdes = pcdes;
021830191209       endif;
021831191209
021832191211       clear r3dptdes;
021833191209       chain (r3deptyp) pctmst;
021834191209       if %found(pctmst);
021835191209       r3dptdes = pcdes;
021836191209       endif;
021837191209
021900060925     C                   EXFMT     io03R
022000060925     C                   MOVE      *BLANKS       r3MSG
022100061002    *** return to screen 2
022200010109    1C                   IF        FKEY = F1
022300060925     C                   MOVEL(P)  'STEP2'       @STEP
022400010109     C                   LEAVESR
022500010109    1C                   ENDIF
022501191209
0225021912090070 C* F8 - display type window
022503191209     c                   if        *inkh
0225041912090073 C                   exsr      #dsptyp
022505191209     C                   MOVEL(P)  'STEP5'       @STEP
022506191209     c                   leavesr
022507191209     c                   end
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
026201191209
026202191209      * plan or category type must be entered, not both
026203191209       if r3pripln = *blanks and r3pritype = *blanks;
026204191209       r3msg = 'PLEASE ENTER PRIMARY PLAN OR TYPE';
026205191209        leavesr;
026206191209       endif;
026207191209
026208191209       if r3deppln = *blanks and r3deptyp = *blanks;
026209191209       r3msg = 'PLEASE ENTER DEPENDENCY PLAN OR TYPE';
026210191209        leavesr;
026211191209       endif;
026212191209
026213191209       if r3pripln <> *blanks and r3pritype <> *blanks;
026214191209       r3msg = 'PLEASE ENTER PRIMARY PLAN OR TYPE, NOT BOTH';
026215191209        leavesr;
026216191209       endif;
026217191209
026218191209       if r3deppln <> *blanks and r3deptyp <> *blanks;
026219191209       r3msg = 'PLEASE ENTER DEPENDENCY PLAN OR TYPE, NOT BOTH';
026220191209        leavesr;
026221191209       endif;
026222191209
026223191209      * valid primary plan
026224191209       if r3pripln <> *blanks;
026225191209       chain (s1t:s1s:r3pripln) plnmst;
026226191209       if not %found(plnmst);
026227191209       r3msg = 'INVALID PRIMARY PLAN';
026228191209        leavesr;
026229191209       endif;
026230191209       endif;
034153061002
034154191209      * valid dependency plan
034155191209       if r3deppln <> *blanks;
034156191209       chain (s1t:s1s:r3deppln) plnmst;
034157191209       if not %found(plnmst);
034158191209       r3msg = 'INVALID DEPENDENCY PLAN';
034159191209        leavesr;
034160191209       endif;
034161191209       endif;
034162191209
034163191209      * valid primary plan category type
034164191209       if r3pritype <> *blanks;
034165191209       chain (r3pritype) pctmst;
034166191209       if not %found(pctmst);
034167191209       r3msg = 'INVALID PRIMARY CATEGORY TYPE';
034168191209        leavesr;
034169191209       endif;
034170191209       endif;
034171191209
034172191209      * valid dependency plan category type
034173191209       if r3deptyp <> *blanks;
034174191209       chain (r3deptyp) pctmst;
034175191209       if not %found(pctmst);
034176191209       r3msg = 'INVALID DEPENDENCY CATEGORY TYPE';
034177191209        leavesr;
034178191209       endif;
034179191209       endif;
034219061003
034220060328     C                   MOVE      'Y'           Validrec
034300010109    ***
034400010109     C                   ENDSR
037200060328   S*
037201060328   S* **************************************************
037202060328      * update
037203060328   S* **************************************************
037300010109     C     $UPDATE       BEGSR
037400010109    ***
037500060328    1C                   IF        addorchg = 'A'
037700191209     C                   CLEAR                   db470inr
037802191209     C                   MOVE      s1t           D7TRUST
037803191209     C                   MOVE      s1s           D7SUB
037804191209     C                   MOVE      s1a           D7ACC
037805191209     c                   move      R3PRIPLN      D7PLN1#
037806191209     c                   move      R3PRITYPE     D7PLN1TYPE
037807191209     c                   move      R3DEPPLN      D7PLN2#
037808191209     c                   move      R3DEPTYP      D7PLN2TYPE
037809191209     c                   move      R3COBRA       D7INCOBRA
037810191209     c                   move      R3NOTE        D7NOTE
037811191209     c                   move      R3STAT        D7STATUS
037812191209     c                   movel     luser         D7UPUSER
037813191209     c                   eval      D7UPDATE = %date
037814191209     c                   eval      D7UPTIME = %time
037816191209
037817191209
038401060925     C                   MOVEL(P)  'STEP5'       @STEP
038402060925     C                   MOVEL     MSG(13)       r3MSG
038403060329
038404060331      * add rec, if error display error else change to Change mode after
038405060331      * the rec has been added
038406060331
038600191209     C                   WRITE(e)  db470inr
038601060329     c                   if        %error
038603060925     C                   MOVEL     MSG(10)       r3MSG
038604060331     c                   else
038605060331     c                   eval      addorchg = 'C'
038607191209     c     db47key2      chain     db470in
038608060329     c                   end
038609060329
038700010109     C                   LEAVESR
038800010109    1C                   ENDIF
038900060329    *
038901060329
039100191209    1C                   IF        %FOUND(db470in)
040503191209     C**                 MOVE      s1t           D7TRUST
040504191209     C**                 MOVE      s1s           D7SUB
040505191209     C**                 MOVE      s1a           D7ACC
040506191209     c                   move      R3PRIPLN      D7PLN1#
040507191209     c                   move      R3PRITYPE     D7PLN1TYPE
040520191209     c                   move      R3DEPPLN      D7PLN2#
040521191209     c                   move      R3DEPTYP      D7PLN2TYPE
040522191209     c                   move      R3COBRA       D7INCOBRA
040523191209     c                   move      R3NOTE        D7NOTE
040524191209     c                   move      R3STAT        D7STATUS
040525191209     c                   movel     luser         D7UPUSER
040526191209     c                   eval      D7UPDATE = %date
040527191209     c                   eval      D7UPTIME = %time
040528191209
040600191209     C                   UPDATE(e) db470inr
040601061003     c                   if        %error
040602061003     C                   MOVEL     MSG(10)       r3MSG
040603061003     c                   else
040700060925     C                   MOVEL(P)  MSG(9)        r3MSG
040701061003     c                   end
040702060330
040703060330      * lock rec again to prevent someone else from updating it before
040704060330      * this screen is released
040706191209     C     db47key2      CHAIN     db470in
040800010109    2C                   ENDIF
041000010109    ***
041100010109     C                   ENDSR
041200060328   S*
041201060328   S* **************************************************
041300060328      * CHECK SUBFILE SELECTION
041301060328   S* **************************************************
041500010109     C     $CHKSELC      BEGSR
041600010109    ***
041700180131     C                   DOU       %EOF(db472D)
041800060925     C                   READC     io02S
041900180131     C                   IF        NOT %EOF(db472D) AND SEL <> *BLANKS
042000010109     C*
042100010109     C                   SELECT
042101061018      * change
042200010109     C                   WHEN      SEL = 'C'
042300010109     C                   EXSR      $CHGCTL
042301191209     C                   ENDSL
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
046400060328   S*
046401060328   S* **************************************************
046500061003     C* LOAD SCREEN 3 & LOCK REC
046501060328   S* **************************************************
046700010109     C     $LOADNLOCK    BEGSR
046812191209
049122191209     c                   clear                   db470inr
049123191209     C     db47key2      CHAIN     db470in
049124191209     c                   if        not %found(db470in)
049125060925     C                   MOVEL(P)  'STEP3'       @STEP
049126060925     C                   MOVEL     MSG(12)       r2MSG
049127060925     c                   else
049129060922
049130191209      * move values from file to screen 3
049131191209
049132191209     C                   move      D7PLN1#       r3pripln
049133191209     C                   move      D7PLN2#       r3deppln
049134191209
049135191209       chain (d7trust:d7sub:d7pln1#) plnmst;
049136191209       if %found(plnmst);
049137191209        r3ppdes = pdescr;
049138191209       endif;
049139191209
049140191209       chain (d7trust:d7sub:d7pln2#) plnmst;
049141191209       if %found(plnmst);
049142191209        r3dpdes = pdescr;
049143191209       endif;
049144191209
049146191209     C                   move      D7PLN1TYPE    R3PRITYPE
049147191209       chain (r3pritype) pctmst;
049148191209       if %found(pctmst);
049149191209       r3pptdes = pcdes;
049151191209       endif;
049152191209
049154191209     C                   move      D7PLN2TYPE    R3DEPTYP
049155191209       chain (r3deptyp) pctmst;
049156191209       if %found(pctmst);
049157191209       r3dptdes = pcdes;
049158191209       endif;
049159191209
049161191209     C                   move      D7INCOBRA     r3cobra
049162191209     C                   move      d7note        r3note
049163191209     C                   move      d7status      r3stat
049164060925     c                   end
049165060922
049200010109     C                   ENDSR
049201191209
0492021912090147  *********************************
0492031912090147  * display category type window
0492041912090147  *********************************
0492051912090148 C     #dsptyp       BEGSR
049206191209
049207191209     C* CLEAR SUBFILE
049208191209     C                   MOVEA     '001'         *IN(40)
049209191209     C                   WRITE     SF01CTL
049210191209     C                   eval      *IN42 = *off
049211191209     C*
049212191209     C* BUILD SUBFILE
049213191209     C*
049214191209     C                   clear                   RR1
049215191209     C     *loval        SETLL     pctmst
049216191209     C                   dou       %eof(pctmst)
049217191209     C                   READ      pctmst                                 41
049218191209     C                   if        not %eof(pctmst)
049219191209     C                   ADD       1             RR1
049220191209     c                   move      pccode        x1
049221191209     c                   movel     pcdes         x2
049222191209     C                   WRITE     SF01
049223191209     C                   iter
049224191209     C                   END
049225191209     C                   ENDDO
049226191209
049227191209     C* DISPLAY SUBFILE IN WINDOW
049228191209     C                   if        rr1 > 0
049229191209     C                   eval      *in40 = *on
049230191209     C                   END
049231191209     C*
049232191209     C                   WRITE     sf01win
049233191209     C                   EXFMT     SF01CTL
049234191209
0492351912090167 C                   ENDSR
049238191209
0492391912090147  *********************************
0492401912090147  * display accounts already set up
0492411912090147  *********************************
0492421912090148 C     #dspacc       BEGSR
049243191209
049244191209     C* CLEAR SUBFILE
049245191209     C                   MOVEA     '001'         *IN(50)
049246191209     C                   WRITE     SF02CTL
049247191209     C                   eval      *IN52 = *off
049248191209     C*
049249191209     C* BUILD SUBFILE
049250191209     C*
049251191209     C                   clear                   RR2
049252191209     C     *loval        SETLL     db470in
049253191209     C                   dou       %eof(db470in)
049254191209     C                   READ(n)   db470in                                51
049255191209     C                   if        not %eof(db470in)
049256191209       wkt = d7trust;
049257191209       wks = d7sub;
049258191209       wka = d7acc;
049259191209
049260191209      ** only show one line per acc
049265191209
049267191209       if holdacc = wktsa;
049268191209       iter;
049269191209       endif;
049270191209       holdacc = wktsa;
049272191209
049273191209       s02tsa = wktsa;
049275191209       chain (d7trust:d7sub:d7acc) accmst;
049276191209       if %found(accmst);
049278191209       s02acnam = acnam1;
049281191209       endif;
049282191209
049283191209       RR2 = RR2 + 1;
049284191209       WRITE  SF02;
049285191209     C                   iter
049286191209     C                   END
049287191209     C                   ENDDO
049288191209
049289191209     C* DISPLAY SUBFILE IN WINDOW
049290191209     C                   if        rr2 > 0
049291191209     C                   eval      *in50 = *on
049292191209     C                   END
049293191209     C*
049294191209     C                   WRITE     sf02win
049295191209     C                   EXFMT     SF02CTL
049296191209
0492971912090167 C                   ENDSR
049298191209
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
050591060328   S* **************************************************
050592060328   S* * first cycle
050593060328   S* **************************************************
050594060327     C     *INZSR        BEGSR
050595060328
050596180131     C     tsakey        KLIST
050597180131     C                   KFLD                    s1t
050598180131     C                   KFLD                    s1s
050599180131     C                   KFLD                    s1a
050606061004
050607191209     C     db47key       KLIST
050608191209     C                   KFLD                    s1t
050609191209     C                   KFLD                    s1s
050610191209     C                   KFLD                    s1a
050612060327     C*
050613191209     C     db47key2      KLIST
050614191209     C                   KFLD                    s1t
050615191209     C                   KFLD                    s1s
050616191209     C                   KFLD                    s1a
050617191209     C                   KFLD                    sfplan1
050618191209     C                   KFLD                    sfplan1t
050619191209     C*
050620060327     C                   ENDSR
050621180131
050700061003** MESSAGES
050800191211INVALID ACCOUNT NUMBER                                       1
050900191209                                                             2
050901191209                                                             3
051100191209                                                             4
051200191209                                                             5
051201191209                                                             6
051400191209                                                             7
051500191209                                                             8
051600061004UPDATE OF RECORD COMPLETE                                    9
051700061004ERROR - REC EXISTS OR OPEN RECORD ALREADY EXISTS            10
051800191209                                                            11
051900061004ERROR - RECORD NOT FOUND                                    12
052000061004THIS RECORD HAS BEEN ADDED                                  13
052100191209                                                            14
052400191209                                                            15
052500191209                                                            16
052600191209                                                            17
052700191209                                                            18
