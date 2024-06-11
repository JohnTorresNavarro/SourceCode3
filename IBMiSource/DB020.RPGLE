000100910215     H DFTNAME(DB020)
0002009102150002 F******************************************************************  DB0201
0003000004140003 F* DB020      GROUP BENEFIT SERVICES SOFTWARE           1988      *  DB0201
0004009102150004 F*                                                                *  DB0201
0005009102150005 F*            WRITTEN BY - MICHAEL C. DUNPHY                      *  DB0201
0006009102150006 F*            DATE - 03/22/89                                     *  DB0201
0007009102150007 F*                                                                *  DB0201
0008009102150008 F*  DESCRIPTION - THIS PROGRAM WILL ISOLATE ANY MCOV RECORDS      *  DB0201
0009001305230009 F*            WITH INVALID AGE BAND FOR MEMBER AGE.               *
0010001305230010 F*                                                                *
0011009808200014 F*                                                                *
0012009808200010 F*  Y2K CONVERT - 1998                                            *
001202130524     F* SSK  02.21.2001  RPGIV COVERSION
0013001109020015 F* 09/02/11 dlk - clean up report and add age as of date.         *
0014001110190015 F* 10/19/11 dlk - fix ab display                                  *
0014011305230015 F* 05/23/13 dlk - rewrite to use plan renewal month and BOR       *
0015001305230015 F*                override date                                   *
0015011603110015 F* 03/11/16 dlk - use plan enroll date instead of acct covtdt when
002100160311     F*                monthly ab plan has a future effective date.
0021011603110015 F*              - change mcov30 to mcov38 so earliest plan effdt
002102160311     F*                can be found.
002200010221     F*
0023001305230011 F******************************************************************
0024001305230013 FMCOV      IP   e           k DISK
0025001305230016 FACCMST    IF   e           k DISK
0026001305230014 FMEMBER    IF   e           k DISK
0027001305230015 FPLNMST    IF   e           k DISK
002801160311     Fmcov38    if   e           k disk    rename(mcovr:mcovr38) prefix(x_)
002802130717     Fplnauxp   if   e           k disk
0029011305230019 Fdb020xl   O  a e             disk
0030001305230037 D workdt          S               d   datfmt(*iso)
003100130523     D pxborlrd_1yr    S              8s 0
003101130523     D errtxt          S             35
0031021305230125 Dcsv              c                   const('","')
003103130524     D aodtype         S             20
003104130830     D waittype        S             12
003105130524     D oldmcvenr       S              8s 0
003106130621     D aodtype1        S             20    inz('ACCT COVER THROUGH  ')
003107130717     D aodtype2        S             20    inz('BOR: LAST RENEWAL   ')
003108130621     D aodtype3        S             20    inz('LAST RENEWAL        ')
003109130621     D aodtype4        S             20    inz('COVERAGE ENROLL     ')
003110130717     D aodtype5        S             20    inz('BOR: DOH + WAIT     ')
0032001305230039 D/SPACE
003300130523DTAQ D                 DS
003400130523      * date for age calculation YYYYMMDD
003500130523DTAQ D  agedatwk               1      8  0
003600130523DTAQ D  agedatyr               1      4  0
003700130523DTAQ D  agedatmo               5      6  0
003800130523
003900130523     D                 DS
004000130523     D  prenew                 1      8  0
004100130523     D  prenewmm               7      8  0
0041011305230049 D                 DS                  Inz
004102130523y2k  D  lastprenewwk           1      8  0
0041031305230052 D  lastprenmm             5      6  0
004200130523     D                 DS
004300130523     D  fa                     1     60  0 dim(20)
004400130523     D  PabF01                 1      3  0
004500130523     D  PabF02                 4      6  0
004600130523     D  PabF03                 7      9  0
004700130523     D  PabF04                10     12  0
004800130523     D  PabF05                13     15  0
004900130523     D  PabF06                16     18  0
005000130523     D  PabF07                19     21  0
005100130523     D  PabF08                22     24  0
005200130523     D  PabF09                25     27  0
005300130523     D  PabF10                28     30  0
005400130523     D  PabF11                31     33  0
005500130523     D  PabF12                34     36  0
005600130523     D  PabF13                37     39  0
005700130523     D  PabF14                40     42  0
005800130523     D  PabF15                43     45  0
005900130523     D  PabF16                46     48  0
006000130523     D  PabF17                49     51  0
006100130523     D  PabF18                52     54  0
006200130523     D  PabF19                55     57  0
006300130523     D  PabF20                58     60  0
006400130523     D                 DS
006500130523     D  ta                     1     60  0 dim(20)
006600130523     D  PabT01                 1      3  0
006700130523     D  PabT02                 4      6  0
006800130523     D  PabT03                 7      9  0
006900130523     D  PabT04                10     12  0
007000130523     D  PabT05                13     15  0
007100130523     D  PabT06                16     18  0
007200130523     D  PabT07                19     21  0
007300130523     D  PabT08                22     24  0
007400130523     D  PabT09                25     27  0
007500130523     D  PabT10                28     30  0
007600130523     D  PabT11                31     33  0
007700130523     D  PabT12                34     36  0
007800130523     D  PabT13                37     39  0
007900130523     D  PabT14                40     42  0
008000130523     D  PabT15                43     45  0
008100130523     D  PabT16                46     48  0
008200130523     D  PabT17                49     51  0
008300130523     D  PabT18                52     54  0
008400130523     D  PabT19                55     57  0
008500130523     D  PabT20                58     60  0
0085011305230158 D                 DS
0085021305230159 D  tsa                    1     10  0
0085031305230160 D  mctrst                 1      3  0
0085041305230161 D  mcsub#                 4      6  0
0085051305230161 D  acc#                   7     10  0
008600130523     D                 DS
008700130523     D  birth                  1      8  0
008800130523     D  bcy                    1      4  0
008900130523     D  bmo                    5      6  0
009000910425     D                 DS
009100980820     D  RENWDT                 1      8  0
009200980820     D  RENYR                  1      4  0
009300990709     D  RENMO                  5      6  0
0094009104110040 D* LDA                                                               DB020
0095009102150041 D                UDS                                                       DB020
0096009102150042 D  CONAME               201    240                                         DB020Y
0097009102150043 D  STIME                242    253  0                                      DB020Y
0098009102150044 D  HMS                  242    247  0                                      DB020Y
009900980820Y2K  D  UD8YMD               248    255  0                                      COMPNY
010000980820Y2K  D  UYR4                 248    251  0                                      COMPNY
010100130523     imcovr
010200130523     i                                          MCTRST        l1
010300130523     i                                          MCSUB#        l1
010400130523     i                                          acc#          l1
010500920623     C*
010600130523     c                   if        *inl1
010700130523     c                   clear                   badacc            1
010800130523     C     tsakey        CHAIN     ACCMST
010900130523     c                   if        not %found(accmst)
011000130523     c                   eval      badacc = 'Y'
011100130523     c                   end
011200130523     c                   end
011300910410      *
011400130523     c                   if        (badacc = 'Y')
011500130523     C                   GOTO      #END
011600910410     C                   END
011700910410      *
0118001305230065  * GET PLAN RECORD
0119001305230066  *
0120001305230067 C     tsp           CHAIN     PLNMST
012100130523     C                   if        not %found(plnmst) or pabfl = 'N'
012200130523     C                   GOTO      #END
012300910410     C                   END
0124001305230045 C*
0125001305230046 C* GET MEMBER RECORD
0126001305230047 C*
0127001305230048 C     mcssno        CHAIN     MEMBER
012800130523     c                   if        not %found(member) or birth = 0
0129001305230055 C                   GOTO      #END
0130001305230056 C                   END
013100130524
0131011305240089 C* find correct age band
013200130523     C                   EXSR      #findab
013300920707      *
0134001305230089 C* if ACTUAL AGE BAND <> CALCULATED AGE BAND - print on reprot
0135001305230090 C*
0136001305230092 C                   if        mcageb <> ab_out
0137001305230093 C                   ADD       1             CNT               7 0
013800980820     C*
013900980820     C* CONVERT DATES TO MDY
014000980820     C*
014100980820     C                   MOVE      ENRLDT        @DATIN
014200980820     C                   EXSR      #DATYM
014300980820     C                   MOVE      @DATOU        ENRMDY            8 0
014400980820     C*
014500980820     C                   MOVE      BIRTH         @DATIN
014600980820     C                   EXSR      #DATYM
014700980820     C                   MOVE      @DATOU        BIRMDY            8 0
015200110902     C*
015201130717     C                   MOVE      empdt         @DATIN
015202130717     C                   EXSR      #DATYM
015203130717     C                   MOVE      @DATOU        EMPMDY            8 0
015204130717     C*
015300130523     C                   MOVE      agedatwk      @DATIN
015400110902     C                   EXSR      #DATYM
015500130523     C                   MOVE      @DATOU        agedatmdy         8 0
015600111019
015700130523     C                   MOVE      bordtused     @DATIN
015800130523     C                   EXSR      #DATYM
015900130523     C                   MOVE      @DATOU        bordtusedmdy      8 0
016000130523
016100130717      * get waiting period code and days for report
016102130717     c                   clear                   waittype
016103130717     C     tsp           CHAIN     plnauxp
016104130717     c                   if        %found(plnauxp)
016105130717     c                   eval      waittype = PXWTPD + ' / ' +
016106130717     c                             %editc(pxwtdy:'3')
016109130717     c                   end
016111130717
016112130717      * if there is a valid age band range, move it to output
016200111019     c                   clear                   fromab            3 0
016300111019     c                   clear                   toab              3 0
016400130523     c                   if        mcageb <> 0
016500130523     c                   move      fa(mcageb)    fromab
016600130523     c                   move      ta(mcageb)    toab
016700111019     c                   end
016800130523      * this mcov is an error
016801130523     C                   clear                   errtxt
016802130523     c                   eval      errtxt = 'AGE BAND DOES NOT MATCH CALC AB'
016901130523     C                   exsr      writexldet
0170001305230095 C                   END                                                                   DB020
017100111019
0172001305230096 C     #END          TAG
017300130523
0174001305232653 C****************************************************************
017500130523     C* Find the age band for the account cover thru date
017600130523     C* AB_OUT    is the field returned from this routine
0177001305232653 C****************************************************************
017800130523     C     #findab       BEGSR
017900130523     C                   clear                   ab_out            2 0
018000130523     c                   clear                   bordtused         8 0
018001130524     c                   clear                   aodtype
018100130523y2k  C                   Z-ADD     ACVTDT        ACVYMD            8 0
018200130523
018300130621      * calc age band as of acvtdt (default for monthly AB plans) - type1
018301160311      * unless mcov has a future enroll date, then use the enroll date
018400130523     c                   z-add     acvtdt        agedatwk
018401130621     c                   eval      aodtype = aodtype1
018402160311
018403160311     c                   if        enrldt > acvtdt
018404160311     c                   z-add     enrldt        agedatwk
018405160311     c                   eval      aodtype = aodtype4
018406160311     c                   end
018500130523
018600130523     C********************************
018601130523     C* Renewl based plans
018602130523     C********************************
018603130523     C                   if        pabfl = 'R'
018604130523     C*
019401130524      **************
019402130621      * Check for BOR plan
019403130524      **************
019404130716
019405130716     C* check for BOR age calc date OVERRIDE for renewal based plans
019406130716     C* Field getborad_ADR = the Age Date Returned from the call, this
019407130716     C* is the date to use for the age calcualtion
019408130716     c                   clear                   getborad_tsp     10
019409130716     c                   move      mctrst        trustchar         3
019410130716     c                   move      mcsub#        subchar           3
019411130716     c                   eval      getborad_tsp = trustchar +
019412130716     c                             subchar + mcplan
019413130716     c                   move      enrldt        getborad_mceff    8            coverage effdt
019414130716     c                   move      empdt         getborad_empdt    8            Employment date
019415130716     c                   clear                   getborad_ADR      8            Age date returned
019416130717     c                   clear                   getborad_ADT      2            Age date type return
019417130716     c                   clear                   getborad_error    1            Error
019418130716     c                   call      'GETBORAD'
019419130716     c                   parm                    getborad_tsp
019420130716     c                   parm                    getborad_mceff
019421130716     c                   parm                    getborad_empdt
019422130716     c                   parm                    getborad_ADR
019423130717     c                   parm                    getborad_ADT
019424130716     c                   parm                    getborad_error
019425130716
019426130716      * as long as no error was found, use the date returned
019427130716     c                   if        getborad_error = *blanks and
019428130716     c                             getborad_ADR <> *blanks
019429130716     c                   move      getborad_ADR  agedatwk
019430130716      *
019431130717      * what type of date was used:
019432130717      * LR = Last Renewal
019433130903      * IE = Initial Eligibility
019434130717      * CE = Coverage Enroll
019435130717     c                   select
019436130717     c                   when      getborad_ADT = 'LR'
019437130716     c                   eval      aodtype = aodtype2
019438130717     c                   when      getborad_ADT = 'IE'
019439130717     c                   eval      aodtype = aodtype5
019440130717     c                   when      getborad_ADT = 'CE'
019441130717     c                   eval      aodtype = aodtype4
019442130717     c                   endsl
019443130716
019444130716     c                   end
019445130716
020803130524
020804130524      **************
020805130903      * Non BOR plan - default of aodtype1 (acct covtdt) or aodtype4
020806130903      *                (cov enroll).
020807130524      **************
020808130903     c                   if        aodtype = aodtype1 or
020809130903     c                             aodtype = aodtype4
020810130524
020907130524      * find last plan renew date
020908130523     c                   exsr      #fndlstprenew
020912130523
020914130523     c                   if        lastprenewwk <> 0
020916130524      * calc age as of last plan renewal if mcov was enrolled prior to the
020917130621      * last renewal - type3
020918130524     c                   if        enrldt < lastprenewwk
020919130523     c                   z-add     lastprenewwk  agedatwk
020920130621     c                   eval      aodtype = aodtype3
020921130524      * else, calc age as of mcov effdt since it was added after the last
020922130524      * renewal
020923130524     c                   else
020924130524
020925130524      * find previous mcov enroll date for this plan/AB (w/o break in cov)
020926130524      * this will find the right date when a benfit amount change occured
020927130621      * w/o an age band change, that would throw off the date used. -
020928130621      * type 4
020929130524     c                   z-add     enrldt        oldmcvenr
020930130524     c                   exsr      #fndprvmcov
020932130524     c                   z-add     oldmcvenr     agedatwk
020933130621     c                   eval      aodtype = aodtype4
020934130524     c                   end
020935130523     c                   end
020936130523
020937130524     c                   end
020938130524
021000130523     c                   end
021001130523
021100130523
021300130524     C* calculate age as of the acvtdt, BOR date, last plan renewal date
021301130524     C* or mcov effective date depending on what was needed in the
021302130524     C* logic above
021500130523     c                   exsr      #calcage
021600130523     c                   z-add     age           age_effdt         3 0
021700130523
021800130523     c                   exsr      #calcageband
021900130523     c                   z-add     agbandwk      ab_effdt          2 0
022000130523
022100130523      * place AB in ab_out field returned from this routine
022200130523     c                   z-add     ab_effdt      ab_out
022300130523
022400130523     C                   ENDSR
022500130523
022600130523      **************************************************
022700130523      * calculate the members age as of agedtwk
022800130523      **************************************************
022900130523     C     #calcage      BEGSR
023000130523
023100130523     C                   eval      age = agedatyr - bcy
023200130523     C                   if        (agedatmo <> 12) and (agedatmo < bmo)
023300130523     C                   sub       1             age               3 0
023400130523     C                   end
023500130523
023600130523     C                   endsr
023700130523
0238001305233760  ****************************************************************
0239001305233762  *----------------- CALCULATE AGE BAND -------------------------*
0240001305233762  * Field returned by this routine = agbandwk
0241001305233762  *
0242001305233760  ****************************************************************
0243001305233764 C     #calcageband  BEGSR
0244001305233775
024500130523     C                   clear                   agbandwk          2 0
024600130523     C                   DO        20            D                 2 0
024700130523     c                   if        (age >= fa(d)) and
024800130523     c                             (age <= ta(d))
024900130523     C                   Z-ADD     D             agbandwk
025000130523     c                   leave
025100130523     C                   end
025200130523     C                   enddo
025300130523
0254001305233797 C                   ENDSR
025500130523
0255011305232653  ****************************************************************
025502130523      * find most recent plan renewal based on acct covtdt.
0255031305232653  ****************************************************************
025504130523     C     #fndlstprenew BEGSR
025505130523
025506130523     c                   clear                   lastprenewwk
025507130523
025508130523     C                   if        prenewmm = 0
025509130523     C                   leavesr
025510130523     C                   end
025511130523
025512130523     c                   move      acvtdt        lastprenewwk
025513130523
025514130523      * same year renew
025515130523     c                   if        prenewmm <= lastprenmm
025516130523     c                   move      prenewmm      lastprenmm
025517130523     c                   else
025518130523      * last year renew
025519130523     c                   move      prenewmm      lastprenmm
025520130523     c                   move      lastprenewwk  workdt
025521130523     c                   subdur    1:*y          workdt
025522130523     c                   move      workdt        lastprenewwk
025523130523     c                   end
025524130523
025525130523     C                   ENDSR
025526130523
025527130524
0255281305242653  ****************************************************************
025529160311      * find earliest mcov enroll date for the plan/ab w/o break in cov
025530160311      * this is needed because multiple benefit amount changes create
025531160311      * additional mcov records with new effective dates.
0255331305242653  ****************************************************************
025534130524     C     #fndprvmcov   BEGSR
025535130524
025536160311      *
025537160311      * mcov38 is ordered by ssn/seq/t/s/p/ab/ct/enroll/cancel. Set limits
025538160311      * past the last record for this ssn/seq/t/s/p/ab and read backwards
025539160311      * for the same key (first rec should the the active rec) holding
025540160311      * the enroll date until a break in coverage is found.
025541160311      *
025542160311     c     mcov38key     setgt     mcov38
025543160311     c                   dou       %eof(mcov38)
025544160311     c     mcov38key     readpe    mcov38
025545160311     c                   if        not %eof(mcov38) and
025546130524     c                             (x_candt = oldmcvenr) and
025547130524     c                             (x_enrldt < oldmcvenr)
025548130524     c                   move      x_enrldt      oldmcvenr
025549130524     c                   end
025550130524     c                   enddo
025551130524
025552130524     C                   ENDSR
025600980820     C*
0257009808200103 C***************************************************
0258009808200104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0259009808200105 C***************************************************
0260009808200107 C*
0261009808200107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0262009808200107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0263009808200107 C*
0264009808200106 C     #DATYM        BEGSR
026500980820     C                   MOVE      @DATIN        @MD               4 0
026600980820     C                   MOVEL     @DATIN        @Y                4 0
026700980820     C                   MOVEL     @MD           @DATOU            8 0
026800980820     C                   MOVE      @Y            @DATOU
026900980820     C                   MOVE      *ZEROS        @DATIN            8 0
0270009808200120 C                   ENDSR
027100130523
0271011305230164 C*************************************************************
0271021305230164 C* Write Spreadsheet Detail                                  *
0271031305230164 C*************************************************************
027104130523     C     Writexldet    BEGSR
027105130523
027106130523      * count errors = test with small number of errors
027107130523     c**                 add       1             errcnt           10 0
027108130523     c**                 if        errcnt > 100
027109130523     c**                 eval      *inlr = *on
027110130523     c**                 end
027111130523
027112130523      * format current ab range out field
027113130523
027114130523     c                   clear                   currangout       15
027116130523     c                   eval      currangout = %char(mcageb) + '    ' +
027117130523     c                             %char(fromab) + '-' +
027118130523     c                             %char(toab)
027120130523
027121130523     c                   clear                   db020fld
027122130523     C                   Eval      db020fld  = '"' +
027123130523     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
027124130523     C                             %trim(%editw(mcssno:'0   -  -    ')) + csv +
027125130523     C                             mcplan                               + csv +
027126130523     C                             %trim(pdescr)                        + csv +
027127130717     C                             %trim(%editw(enrmdy:'  /  /    '))    + csv +
027128130523     C                             %trim(pabfl)                         + csv +
027129130523     C                             %editc(prenewmm:'1')                 + csv +
027131130717     C                             %trim(%editw(empmdy:'  /  /    '))    + csv +
027132130717     C                             %trim(waittype)                       + csv +
027133130717     C                             %trim(%editw(birmdy:'  /  /    '))    + csv +
027134130523     C                             %editc(age:'1')                      + csv +
027135130717     C                             %editc(ab_out:'1')                    + csv +
027136130523     C                             %trim(%editw(agedatmdy:'  /  /    ')) + csv +
027137130524     C                             %trim(aodtype)                        + csv +
027138130523     C                             %trim(currangout)                     + csv +
027148130523     C                             errtxt                               + csv +
027149130523     C                             ' '                                  + '",'
027150130523     C*
027151130523     C                   Write     db020xr
0271521305230320 C                   ENDSR
027153130523     C*
027154130523     C/EJECT
027155130523     C*************************************************************
027156130523     C* Write Spreadsheet heading                                 *
027157130523     C*************************************************************
027158130523     C     Writexlhead   BEGSR
027159130523
027160130523     c                   clear                   db020fld
027161130523     C                   Eval      db020fld = '"' +
027162130523     C                             'ACCOUNT #'                          + csv +
027163130523     C                             'SS #'                               + csv +
027164130523     C                             'PLAN'                               + csv +
027165130523     C                             'PLAN DESCRIPTION'                   + csv +
027166130717     C                             'COV. ENROLL'                        + csv +
027167130523     C                             'AB TYPE'                            + csv +
027168130523     C                             'RENEWAL MONTH'                      + csv +
027169130717     C                             'HIRE DATE'                          + csv +
027170130717     C                             'WAIT CODE / DAYS'                   + csv +
027171130717     C                             'BIRTH DATE'                         + csv +
027172130523     C                             'CALC AGE'                           + csv +
027173130717     C                             'CALC A.B.'                          + csv +
027174130523     C                             'CALC AS OF DATE'                    + csv +
027175130524     C                             'AS OF DATE TYPE'                    + csv +
027177130523     C                             'CURRENT AB & RANGE'                 + csv +
027179130523     C                             'ERROR'                              + csv +
027180130523     C                             ' '                                  + '",'
027181130523     C                   Write     db020xr
027182130523     C*
0271831305230320 C                   ENDSR
027184130523
0272001305230106 C     *inzsr        BEGSR
027300130523
027400130523     c     tsp           klist
027500130523     c                   kfld                    mctrst
027600130523     c                   kfld                    mcsub#
027700130523     c                   kfld                    mcplan
027701130524
027702160311     c     mcov38key     klist
027703130524     c                   kfld                    MCSSNO
027704130524     c                   kfld                    MDSEQ#
027705130524     c                   kfld                    MCTRST
027706130524     c                   kfld                    MCSUB#
027708130524     c                   kfld                    MCPLAN
027709130524     c                   kfld                    MCAGEB
027800130523
027900130523     c     tsakey        klist
028000130523     c                   kfld                    mctrst
028100130523     c                   kfld                    mcsub#
028200130523     c                   kfld                    acc#
028201130523
028202130523     C                   Exsr      Writexlhead
0283001305230120 C                   ENDSR
