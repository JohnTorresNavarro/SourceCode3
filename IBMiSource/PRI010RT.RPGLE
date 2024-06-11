000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200224      * PRI010R - Principal Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800200228      * 02/28/2020  jt    Original creation
000801200810      * 08/10/2020  jt    Change to be less hardcoding
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200180427     F                                     rename(accmsr:actFile)
001300180427
001400190226     Fac2mstl2  if   e           k disk    rename(accmsr2:actFile2)
001500190226
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
002100181101     Fcarmstl   if   e           k disk    extfile('F.CARMSTL')
002200181101     F                                     rename(carmsr:carrFile)
002300180412
002400200206     Fmcov42    if   e           k disk    extfile('F.MCOV42')
002500181031
002600200206     Fmcov44    if   e           k disk
002601200206     F                                     rename(mcovr:covc44)
002602200206
002900180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003000160513
003100160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003200160513
003300160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003400160518
003500160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003600180508
003700190226     fcodes     if   e           k disk    extfile('F.CODES')
003800190226     f                                     rename(codesr:codesFile)
003900190226
004000200228     fsmoke     if   e           k disk
004200181030
004300200224     fpridetail uf a e           k disk    rename(prhr:priFile)
004400160513
004401200810     fcarplnp   if   e           k disk    rename(carplnr:planSetup)
004402200810
004900200224     fpritrm    uf a e           k disk    rename(pritr:termFile)
005000180523
005100181113     ftransoff1 if   e           k disk    rename(transr:transFile)
005200181113
005300181030      *================================================================================
005400181030      *   opcode to convert yyyymmdd to mmddyyyy
005500181030      *   xxx = %editc( %dec(%char(%date(numericdate:*iso):*mdy0):8:0):'X');
005600160512      *=================================================================
005700061017
005800181101     d carrierCode     s              3
005801190308     d carrierCode1    s              3
005802190308     d carrierCode2    s              3
005803190308     d carrierCode3    s              3
005804190308     d carrierCode4    s              3
005805190308     d carrierCode5    s              3
005900181101     d grouperCode     s              2
006000200810     d foundPlan       s              1
006001200810     d unique          s             10
006002200810     d cancelDate      s               d
006100180913     d cancelh         s              8  0
006200160519     d today           s              8  0
006300190227     d alreadySent     s              1
006700180523     d ssn             s              9  0
006800180523     d seq#            s              2  0
006900200224     d ptype           s              3
007000190227     d updateRecord    s              1
007100190227     d writeRecord     s              1
007200180523     d termdt          s              8  0
007201190401     d ok_toTransmit   s              1
007300200228     d tier            s              1
007400181113     d carrier         s              2  0
007600181105     d candtp          s              8
007700181105     d lastdate        s              8
007800181105     d error           s             20
007801200224     d pos             s              2  0
007802200424     d size            s              1  0
007803200424     d salaryHold      s             15
008100200810     d outDate         s              8
008101200810
008200200810     d lastday         pr                  extpgm('LASTDAY2')
008201200810     d  ctrust                        3    const
008202200810     d  csub                          3    const
008203200810     d  cplan                         4    const
008204200810     d  inDate                        8    const
008205200810     d  outDate                       8    const
008206200810
008502200810     d pri010rt        pi
008503200810     d  p_acct                        7
008504200810
008700160511      //==================================================================
008800160511      // mainline
008900160511      //===================================================================
009000150820
009100160511       exsr init;
009200160511       exsr main;
009300160511       exsr exit;
009400160511
009500181031      //===================================================================
009600181031      // main
009700181031      //===================================================================
009800181031
009900200228       begsr main;
009901190308
010100200228        setll grouperCode carrFile;
010200200228        reade grouperCode carrFile;
010300190308
010400200228        dow not %eof;
010500181101
010600200228         carrierCode = carrcd;
010700200228         exsr main2;
010800181101
010900200228        reade grouperCode carrFile;
011000200228        enddo;
011100181031
011200181031       endsr;
011300181031
011400180309      //===================================================================
011500181030      // main
011600180309      //===================================================================
011700180309
011800200228       begsr main2;
011900180309
012000180309        setll carrierCode plnmsr;
012100180309        reade carrierCode plnmsr;
012200180309
012300180309        dow not %eof;
012400180309
012500200206         setll (pltrst : plsub# : plplan) mcov42;
012501200206         reade (pltrst : plsub# : plplan) mcov42;
012502200206
012800180313         dow not %eof;
012900180309
013000180313          exsr process;
013100180309
013200200206          reade (pltrst : plsub# : plplan) mcov42;
013300180313         enddo;
013400180309
013500180309        reade carrierCode plnmsr;
013600180309        enddo;
013700180309
013800180309       endsr;
013900180309
014000160511      //===================================================================
014100160511      // process
014200160511      //===================================================================
014300160511
014400160511       begsr process;
014500160511
014600181030        chain mcssno member;
014601200514        if %found;
014602200514         if %subst(fill66:66:1) = 'Y';
014603200514          leavesr;
014604200514         endif;
014605200514        endif;
014700160511
014800200206        setll (pltrst : plsub# : acc# : mcssno) covc44;
014801200206        reade (pltrst : plsub# : acc# : mcssno) covc44;
014802200206
014803200206        dow not %eof;
014804200206
014805200206         if plplan = mcplan;
014806200206          exsr writeMember;
014807200206         endif;
014808200206
014809200206        reade (pltrst : plsub# : acc# : mcssno) covc44;
014810200206        enddo;
015200180508
015300160511       endsr;
015400160511
015500160513      //===================================================================
015600180313      // Write Member
015700160513      //===================================================================
015800160513
015900180313       begsr writeMember;
016000180313
016100190227        updateRecord = 'N';
016200190227        writeRecord = 'N';
016300190227
016400181128        exsr checkTransmission;
016500190401        if ok_toTransmit = 'N';
016600181128         leavesr;
016700181128        endif;
016800181113
016900181102        chain
017000190227        (%char(%editc(mcssno:'X')):%editc(mcssno:'X'):
017100200224        %char(birth):mlname:mfname:mmi) priFile;
017200190227
017300190227        if %found;
017400190227         updateRecord = 'Y';
017401200224         writeRecord = 'N';
017500190227        else;
017600190227         writeRecord = 'Y';
017601200224         updateRecord = 'N';
017700190227        endif;
017800190227
017900190227        if writeRecord = 'Y';
018000200224         clear priFile;
018100190227        endif;
018200181102
018302200228         exsr getGroup;
018401200224         if pacct# = ' ';
018402200228          leavesr;
018403200228         endif;
018404200228
018406200228         pempssn = %editc(mcssno:'X');
018407200424         pempid = ' ';
018408200224         ppssn = %editc(mcssno:'X');
018410200228
018411200224         plname = mlname;
018412200224         pfname = mfname;
018413200228         pmi = mmi;
018415200228         psuffix = ' ';
018416200228         pdob = %char(birth);
018417200224         psex = sex;
018418200224         prel = 'E';
018419200224
018420200224         padd1 = addr1;
018421200224         padd2 = addr2;
018422200224         pcity = city;
018423200224         pstate = state;
018424200224         pprov = ' ';
018425200424         pzip = %subst(%editc(zip:'X'):1:5);
018426200224         pcountry = ' ';
018427200224
018428200224         phphone = %editc(area:'X') + %editc(phone:'X');
018429200514         pemail = %subst(fill66:1:65);
018430200224
018431200424         //pnicusa = 'N';
018432200224         chain mcssno smoker;
018433200224         if %found;
018434200424          //pnicusa = 'T';
018435200224         endif;
018436200224
018437200224         plocid = ' ';
018438200224         pclassid = ' ';
018439200224         psupid1 = ' ';
018440200224         psupid2 = ' ';
018441200224         psupid3 = ' ';
018442200224         psupid4 = ' ';
018443200224         psupid5 = ' ';
018444200224         psupid6 = ' ';
018445200224
018446200224         peventcd = ' ';
018447200224         peventdt = ' ';
018448200224
018449200224         if empdt > 0;
018450200224          pempdt = %char(empdt);
018451200224         endif;
018452200224         pelegdt = ' ';
018453200224         pemphrs = ' ';
018454200224
018455200224         pcocostdt = ' ';
018456200224         pcocoendt = ' ';
018457200224         pretdt = ' ';
018458200224         pempendt = ' ';
018460200224
018461200224         exsr determineType;
018462200810         exsr getPlan;
018463200224
018900200228         chain (pltrst : plsub# : acc#) actFile2;
019000190226         if %found;
019100200228          //dtaxid# = %char(a2tax_id#);
019200190226         endif;
019300190226
019301200810         if foundPlan = 'Y';
019302200224         if plncat = 'PLF';
019303200224         if pcovid1 <> ptype;
019304200224          pcovid1 = 'BLF';
019305200424          pplanid1 = '1';
019306200224          pcovefdt1 = %char(enrldt);
019307200424
019308200224          if salary > 0;
019309200424           exsr formatSalary;
019310200424            pempsala1 = salaryHold;
019322200424           pempsalm1 = 'A';
019323200224          endif;
019324200224
019325200224          if empdt > 0;
019326200224           pempsaedt1 = %char(empdt);
019327200224          endif;
019328200224
019329200224          ssn = mcssno;
019330200224          termdt = candt;
019331200228          exsr checkTerm;
019332200228          if alreadySent = 'N';
019333200228
019334200228           if candt > 0;
019335200228            cancelh = candt;
019336200810             exsr get_planDate;
019337200224            pcovtrmdt1 = %char(cancelh);
019338200228           endif;
019339200228
019340200228           if writeRecord = 'Y';
019341200224            write priFile;
019342200228           endif;
019343200228           if updateRecord = 'Y';
019344200224            update priFile;
019345200228           endif;
019346200224
019347200228          endif;
019348200228         endif;
019349200224         endif;
019350200810         endif;
019351200228
019352200810
019353200810         if foundPlan = 'Y';
019354200224         if plncat = 'PAC';
019355200224         if pcovid2 <> ptype;
019356200224          pcovid2 = 'ADD';
019357200424          pplanid2 = '1';
019358200224          pcovefdt2 = %char(enrldt);
019359200224
019360200224          ssn = mcssno;
019361200224          termdt = candt;
019362200224          exsr checkTerm;
019363200224          if alreadySent = 'N';
019364200224
019365200224           if candt > 0;
019366200224            cancelh = candt;
019367200810             exsr get_planDate;
019368200224            pcovtrmdt2 = %char(cancelh);
019369200224           endif;
019370200224
019371200224           if writeRecord = 'Y';
019372200224            write priFile;
019373200224           endif;
019374200224           if updateRecord = 'Y';
019375200224            update priFile;
019376200224           endif;
019377200224
019378200224          endif;
019379200224         endif;
019380200224         endif;
019381200810         endif;
019382200224
019383200810         if foundPlan = 'Y';
019384200424         if plncat = 'PSF';
019385200224         if pcovid3 <> ptype;
019386200224          pcovid3 = 'DLF';
019387200224          pcovefdt3 = %char(enrldt);
019388200224
019389200224          ssn = mcssno;
019390200224          termdt = candt;
019391200224          exsr checkTerm;
019392200224          if alreadySent = 'N';
019393200224
019394200224           if candt > 0;
019395200224            cancelh = candt;
019396200810             exsr get_planDate;
019397200224            pcovtrmdt3 = %char(cancelh);
019398200224           endif;
019399200224
019400200224           if writeRecord = 'Y';
019401200224            write priFile;
019402200224           endif;
019403200224           if updateRecord = 'Y';
019404200224            update priFile;
019405200224           endif;
019406200224
019407200224          endif;
019408200224         endif;
019409200224         endif;
019410200810         endif;
023626200228
023627200810         if foundPlan = 'Y';
026601200224         if plncat = 'PSL';
026602200224         if pcovid4 <> ptype;
026603200224          pcovid4 = 'EVL';
026604200224          pcovefdt4 = %char(enrldt);
026605200424          pbenamtel4 = %editc(benamt:'X');
026606200424          pbenamtap4 = %editc(benamt:'X');
026607200424          pbenperel4 = ' ';
026608200224          pplanid4 = '1';
026609200224
026610200224          if salary > 0;
026611200424           exsr formatSalary;
026612200424            pempsala4 = salaryHold;
026624200224           pempsalm4 = 'A';
026625200224          endif;
026626200224
026627200224          if empdt > 0;
026628200224           pempsaedt4 = %char(empdt);
026629200224          endif;
026630200224
026631200224          ssn = mcssno;
026632200224          termdt = candt;
026633200224          exsr checkTerm;
026634200224          if alreadySent = 'N';
026635200224
026636200224           if candt > 0;
026637200224            cancelh = candt;
026638200810             exsr get_planDate;
026639200224            pcovtrmdt4 = %char(cancelh);
026640200224           endif;
026641200224
026642200224           if writeRecord = 'Y';
026643200224            write priFile;
026644200224           endif;
026645200224           if updateRecord = 'Y';
026646200224            update priFile;
026647200224           endif;
026648200224
026649200224          endif;
026650200224         endif;
026651200224         endif;
026652200810         endif;
026653200224
026654200810         if foundPlan = 'Y';
026655200224         if plncat = 'POA';
026656200224         if pcovid5 <> ptype;
026657200224          pcovid5 = 'EVA';
026658200224          pcovefdt5 = %char(enrldt);
026659200224          pplanid5 = '1';
026660200224
026661200224          ssn = mcssno;
026662200224          termdt = candt;
026663200224          exsr checkTerm;
026664200224          if alreadySent = 'N';
026665200224
026666200224           if candt > 0;
026667200224            cancelh = candt;
026668200810             exsr get_planDate;
026669200224            pcovtrmdt5 = %char(cancelh);
026670200224           endif;
026671200224
026672200224           if writeRecord = 'Y';
026673200224            write priFile;
026674200224           endif;
026675200224           if updateRecord = 'Y';
026676200224            update priFile;
026677200224           endif;
026678200224
026679200224          endif;
026680200224         endif;
026681200224         endif;
026682200810         endif;
026683200224
026684200810         if foundPlan = 'Y';
026685200224         if plncat = 'PSP';
026686200224         if pcovid6 <> ptype;
026687200224          pcovid6 = 'SVL';
026688200224          pcovefdt6 = %char(enrldt);
026689200424          pbenamtel6 = %editc(benamt:'X');
026690200424          pbenamtap6 = %editc(benamt:'X');
026691200224          pplanid6 = '1';
026692200224
026693200224          ssn = mcssno;
026694200224          termdt = candt;
026695200224          exsr checkTerm;
026696200224          if alreadySent = 'N';
026697200224
026698200224           if candt > 0;
026699200224            cancelh = candt;
026700200810             exsr get_planDate;
026701200224            pcovtrmdt6 = %char(cancelh);
026702200224           endif;
026703200224
026704200224           if writeRecord = 'Y';
026705200224            write priFile;
026706200224           endif;
026707200224           if updateRecord = 'Y';
026708200224            update priFile;
026709200224           endif;
026710200224
026711200224          endif;
026712200224         endif;
026713200224         endif;
026714200810         endif;
026715200224
026716200224         if plncat = 'PSA';
026717200810         if foundPlan = 'Y';
026718200224         if pcovid7 <> ptype;
026719200224          pcovid7 = 'SVA';
026720200424          pplanid7 = '1';
026721200224          pcovefdt7 = %char(enrldt);
026722200224
026723200224          ssn = mcssno;
026724200224          termdt = candt;
026725200224          exsr checkTerm;
026726200224          if alreadySent = 'N';
026727200224
026728200224           if candt > 0;
026729200224            cancelh = candt;
026730200810             exsr get_planDate;
026731200224            pcovtrmdt7 = %char(cancelh);
026732200224           endif;
026733200224
026734200224           if writeRecord = 'Y';
026735200224            write priFile;
026736200224           endif;
026737200224           if updateRecord = 'Y';
026738200224            update priFile;
026739200224           endif;
026740200224
026741200224          endif;
026742200224         endif;
026743200224         endif;
026744200810         endif;
026745200224
026746200810         if foundPlan = 'Y';
026747200424         if plncat = 'PVD' or plncat = 'PSD';
026748200224         if pcovid8 <> ptype;
026749200224          pcovid8 = 'CVL';
026750200224          pcovefdt8 = %char(enrldt);
026751200424          pbenamtel8 = %editc(benamt:'X');
026752200424          pbenamtap8 = %editc(benamt:'X');
026753200224          pplanid8 = '1';
026754200224
026755200224          ssn = mcssno;
026756200224          termdt = candt;
026757200224          exsr checkTerm;
026758200224          if alreadySent = 'N';
026759200224
026760200224           if candt > 0;
026761200224            cancelh = candt;
026762200810             exsr get_planDate;
026763200224            pcovtrmdt8 = %char(cancelh);
026764200224           endif;
026765200224
026766200224           if writeRecord = 'Y';
026767200224            write priFile;
026768200224           endif;
026769200224           if updateRecord = 'Y';
026770200224            update priFile;
026771200224           endif;
026772200224
026773200224          endif;
026774200224         endif;
026775200224         endif;
026776200810         endif;
026777200224
026778200810         if foundPlan = 'Y';
026779200224         if plncat = 'PWD';
026780200224         if pcovid9 <> ptype;
026781200224          pcovid9 = 'STD';
026782200224          pcovefdt9 = %char(enrldt);
026783200424          pbenamtel9 = %editc(benamt:'X');
026784200424          pbenamtap9 = %editc(benamt:'X');
026785200424
026786200224          pplanid9 = '1';
026787200424          pos = %scan('PARTNER':pdescr:1);
026788200424          if pos > 0;
026789200424           pplanid9 = '2';
026790200424          endif;
026791200224
026792200224          if salary > 0;
026793200424           exsr formatSalary;
026794200424            pempsala9 = salaryHold;
026796200224           pempsalm9 = 'A';
026797200224          endif;
026798200224
026799200224          if empdt > 0;
026800200424           pempsaedt9 = %char(empdt);
026801200224          endif;
026802200224
026803200224          ssn = mcssno;
026804200224          termdt = candt;
026805200224          exsr checkTerm;
026806200224          if alreadySent = 'N';
026807200224
026808200224           if candt > 0;
026809200224            cancelh = candt;
026810200810             exsr get_planDate;
026811200224            pcovtrmdt9 = %char(cancelh);
026812200224           endif;
026813200224
026814200224           if writeRecord = 'Y';
026815200224            write priFile;
026816200224           endif;
026817200224           if updateRecord = 'Y';
026818200224            update priFile;
026819200224           endif;
026820200224
026821200224          endif;
026822200224         endif;
026823200224         endif;
026824200810         endif;
026825200224
026826200810         if foundPlan = 'Y';
026827200224         if plncat = 'PLT';
026828200224         if pcovid10 <> ptype;
026829200224          pcovid10 = 'LTD';
026830200424
026831200424          pplanid10 = '1';
026832200424          pos = %scan('ATTORNEY':pdescr:1);
026833200424          if pos > 0;
026834200424           pplanid10 = '2';
026835200424          endif;
026836200424          pos = %scan('PARTNER':pdescr:1);
026837200424          if pos > 0;
026838200424           pplanid10 = '3';
026839200424          endif;
026840200424
026841200224          pcovefdt10 = %char(enrldt);
026842200224
026843200224          if salary > 0;
026844200424           exsr formatSalary;
026845200424            pempsala10 = salaryHold;
026856200224           pempsalm10 = 'A';
026857200224          endif;
026858200224
026859200224          if empdt > 0;
026860200224           pempsaed10 = %char(empdt);
026861200224          endif;
026862200224
026863200224          ssn = mcssno;
026864200224          termdt = candt;
026865200224          exsr checkTerm;
026866200224          if alreadySent = 'N';
026867200224
026868200224           if candt > 0;
026869200224            cancelh = candt;
026870200810             exsr get_planDate;
026871200224            pcovtrmd10 = %char(cancelh);
026872200224           endif;
026873200224
026874200224           if writeRecord = 'Y';
026875200224            write priFile;
026876200224           endif;
026877200224           if updateRecord = 'Y';
026878200224            update priFile;
026879200224           endif;
026880200224
026881200224          endif;
026882200224         endif;
026883200810         endif;
026884200810         endif;
026885200224
026886200810         if foundPlan = 'Y';
026887200224         if plncat = 'PDN';
026888200224         if pcovid11 <> ptype;
026889200224          pcovid11 = 'DEN';
026890200224          pcovefdt11 = %char(enrldt);
026891200424
026892200424          //pplanid11 = '2';
026893200424          //pos = %scan('CORE':pdescr:1);
026894200424          //if pos > 0;
026895200224           pplanid11 = '1';
026896200424          //endif;
026897200224
026898200224          ssn = mcssno;
026899200224          termdt = candt;
026900200224          exsr checkTerm;
026901200224          if alreadySent = 'N';
026902200224
026903200224           if candt > 0;
026904200224            cancelh = candt;
026905200810             exsr get_planDate;
026906200224            pcovtrmd11 = %char(cancelh);
026907200224           endif;
026908200224
026909200224           if writeRecord = 'Y';
026910200224            write priFile;
026911200224           endif;
026912200224           if updateRecord = 'Y';
026913200224            update priFile;
026914200224           endif;
026915200224
026916200224          endif;
026917200224         endif;
026918200224         endif;
026919200810         endif;
026920200224
026921200810         if foundPlan = 'Y';
026922200224         if plncat = 'PVS';
026923200224         if pcovid12 <> ptype;
026924200224          pcovid12 = 'VIS';
026925200424          pplanid12 = '1';
026926200424
026927200224          pcovefdt12 = %char(enrldt);
026928200224
026929200224          ssn = mcssno;
026930200224          termdt = candt;
026931200224          exsr checkTerm;
026932200224          if alreadySent = 'N';
026933200224
026934200224           if candt > 0;
026935200224            cancelh = candt;
026936200810             exsr get_planDate;
026937200224            pcovtrmd12 = %char(cancelh);
026938200224           endif;
026939200224
026940200224           if writeRecord = 'Y';
026941200224            write priFile;
026942200224           endif;
026943200224           if updateRecord = 'Y';
026944200224            update priFile;
026945200224           endif;
026946200224
026947200224          endif;
026948200224         endif;
026949200224         endif;
026950200810         endif;
026951200224
026952200810         if foundPlan = 'Y';
026953200224         if plncat = 'PCC';
026954200224         if pcovid13 <> ptype;
026955200224          pcovid13 = 'ECI';
026956200224          pcovefdt13 = %char(enrldt);
026957200424          pbenamte13 = %editc(benamt:'X');
026958200424          pbenamta13 = %editc(benamt:'X');
026959200224
026960200224          ssn = mcssno;
026961200224          termdt = candt;
026962200224          exsr checkTerm;
026963200224          if alreadySent = 'N';
026964200224
026965200224           if candt > 0;
026966200224            cancelh = candt;
026967200810             exsr get_planDate;
026968200224            pcovtrmd13 = %char(cancelh);
026969200224           endif;
026970200224
026971200224           if writeRecord = 'Y';
026972200224            write priFile;
026973200224           endif;
026974200224           if updateRecord = 'Y';
026975200224            update priFile;
026976200224           endif;
026977200224
026978200224          endif;
026979200224         endif;
026980200224         endif;
026981200810         endif;
026983200224
026984200810         if foundPlan = 'Y';
026985200224         if plncat = 'PCB';
026986200224         if pcovid14 <> ptype;
026987200224          pcovid14 = 'SCI';
026988200224          pcovefdt14 = %char(enrldt);
026989200424          pbenamte14 = %editc(benamt:'X');
026990200424          pbenamta14 = %editc(benamt:'X');
026991200224
026992200224          ssn = mcssno;
026993200224          termdt = candt;
026994200224          exsr checkTerm;
026995200224          if alreadySent = 'N';
026996200224
026997200224           if candt > 0;
026998200224            cancelh = candt;
026999200810             exsr get_planDate;
027000200224            pcovtrmd14 = %char(cancelh);
027001200224           endif;
027002200224
027003200224           if writeRecord = 'Y';
027004200224            write priFile;
027005200224           endif;
027006200224           if updateRecord = 'Y';
027007200224            update priFile;
027008200224           endif;
027009200224
027010200224          endif;
027011200224         endif;
027012200224         endif;
027013200810         endif;
027014200224
027015200810         if foundPlan = 'Y';
027016200224         if plncat = 'PCG';
027017200224         if pcovid15 <> ptype;
027018200224          pcovid15 = 'CCI';
027019200224          pcovefdt15 = %char(enrldt);
027020200424          pbenamte15 = %editc(benamt:'X');
027021200424          pbenamta15 = %editc(benamt:'X');
027022200224
027023200224          ssn = mcssno;
027024200224          termdt = candt;
027025200224          exsr checkTerm;
027026200224          if alreadySent = 'N';
027027200224
027028200224           if candt > 0;
027029200224            cancelh = candt;
027030200810             exsr get_planDate;
027031200224            pcovtrmd15 = %char(cancelh);
027032200224           endif;
027033200224
027034200224           if writeRecord = 'Y';
027035200224            write priFile;
027036200224           endif;
027037200224           if updateRecord = 'Y';
027038200224            update priFile;
027039200224           endif;
027040200224
027041200224          endif;
027042200224         endif;
027043200224         endif;
027044200810         endif;
027045200224
027046200810         if foundPlan = 'Y';
027047200224         if plncat = 'PO6';
027048200224         if pcovid16 <> ptype;
027049200224          pcovid16 = 'ACC';
027050200224          pcovefdt16 = %char(enrldt);
027051200224
027052200224          ssn = mcssno;
027053200224          termdt = candt;
027054200224          exsr checkTerm;
027055200224          if alreadySent = 'N';
027056200224
027057200224           if candt > 0;
027058200224            cancelh = candt;
027059200810             exsr get_planDate;
027060200224            pcovtrmd16 = %char(cancelh);
027061200224           endif;
027062200224
027063200224           if writeRecord = 'Y';
027064200224            write priFile;
027065200224           endif;
027066200224           if updateRecord = 'Y';
027067200224            update priFile;
027068200224           endif;
027069200224
027070200224          endif;
027071200224         endif;
027072200224         endif;
027073200810         endif;
027074200224
033300190227         if mcovtp <> 'TIN';
033400190227          exsr dependent;
033500190227         endif;
033600180523
033700160516       endsr;
033800060817
033801200810      //===================================================================
033802200810      // get canceled date according to plan setup
033803200810      //===================================================================
033804200810
033805200810       begsr get_planDate;
033806200810
033807200810        lastday(%char(pltrst):%char(plsub#):tplan:%char(cancelh):outDate);
033808200810        cancelh = %dec(outDate:8:0);
033809200810
033810200810       endsr;
033811200810
043200180523      //===================================================================
043300180523      // check termed records;
043400180523      //===================================================================
043500180523
043600180523       begsr checkTerm;
043700180523
043800180523       alreadySent = 'N';
043900180523
044000180523       if termdt > 0;
044100180523
044200200224        chain (pltrst:plsub#:acc#:ssn:seq#:plncat:plplan:termdt) termFile;
044300180523        if %found;
044400180523         alreadySent = 'Y';
044500180523         leavesr;
044600180523        endif;
044700180523
044800180523        if not %found;
044900180523         ttrst = pltrst;
045000180523          tsub# = plsub#;
045100180523           tacct = acc#;
045200180524            tssno = ssn;
045300180523             tseq# = seq#;
045400200224             ttype = plncat;
045500180523            tplan = plplan;
045600180523           ttermdt = termdt;
045700180523          ttrnsdt = %dec(%date);
045800180523         write termFile;
045900180523        endif;
046000180523
046100180523       endif;
046200180523
046300180523       endsr;
046400180524
046500160512      //===================================================================
046600160512      // process
046700160512      //===================================================================
046800160512
046900160512       begsr dependent;
047000160512
047100160512        setll mcssno depenr;
047200160512        reade mcssno depenr;
047300160512
047400160512        dow not %eof;
047500160512
047600180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
047700160512        if %found;
047800180313         exsr dependentCoverage;
047900160512        endif;
048000160512
048100160512        reade mcssno depenr;
048200160512        enddo;
048300160512
048400190429       endsr;
048500160512
048600160516      //===============================================================
048700160512      // Dependent coverage
048800160512      //===============================================================
048900160513
049000180313       begsr dependentCoverage;
049100160512
049200180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
049300180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
049400160512
049500160512        dow not %eof;
049600181030
049700181030         exsr writeDep;
049800181030
049900180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
050000160512        enddo;
050100160512
050200160512       endsr;
050300160512
050400160516      //===============================================================
050500160516      // write dependent
050600160516      //===============================================================
050700160516
050800160516       begsr writeDep;
050900180313
051000190227        updateRecord = 'N';
051100190227        writeRecord = 'N';
051200190227
051300181102        chain
051400190227        (%char(%editc(mcssno:'X')):%editc(depss#:'X'):
051500200224        %char(dbirth):dlname:dfname:dmi) priFile;
051600190227        if %found;
051700190227         updateRecord = 'Y';
051701200224         writeRecord = 'N';
051800190227        else;
051900190227         writeRecord = 'Y';
051901200224         updateRecord = 'N';
052000190227        endif;
052100181102
052200190227        if writeRecord = 'Y';
052300200224         clear priFile;
052400190227        endif;
052500181102
052501200224         exsr getGroup;
052502200224         if pacct# = ' ';
052503200224          leavesr;
052504200224         endif;
052505200224
052506200224         pempssn = %editc(mcssno:'X');
052507200424         pempid = ' ';
052508200224         ppssn = %editc(depss#:'X');
052509200224
052510200224         plname = dlname;
052511200224         pfname = dfname;
052512200224         pmi = dmi;
052513200224         psuffix = ' ';
052514200224         pdob = %char(dbirth);
052515200224         psex = dsex;
052516200224
052517200224         exsr relCodes;
052519200224
052520200224         padd1 = daddr1;
052521200224         padd2 = daddr2;
052522200224         pcity = dcity;
052523200224         pstate = dstate;
052524200224         pprov = ' ';
052525200424         pzip = %subst(%editc(dzip:'X'):1:5);
052526200224         pcountry = ' ';
052527200224
052528200224         phphone = %editc(area:'X') + %editc(phone:'X');
052530200224
052531200424         //pnicusa = 'N';
052532200224         chain (mcssno : dpseq#) smoker;
052533200224         if %found;
052534200424          //pnicusa = 'T';
052535200224         endif;
052536200224
052537200224         plocid = '';
052538200224         pclassid = '';
052539200224         psupid1 = ' ';
052540200224         psupid2 = ' ';
052541200224         psupid3 = ' ';
052542200224         psupid4 = ' ';
052543200224         psupid5 = ' ';
052544200224         psupid6 = ' ';
052545200224
052546200224         peventcd = ' ';
052547200224         peventdt = ' ';
052548200224
052549200224         pempdt = ' ';
052552200224         pelegdt = ' ';
052553200224         pemphrs = ' ';
052554200224
052555200224         pcocostdt = ' ';
052556200224         pcocoendt = ' ';
052557200224         pretdt = ' ';
052558200224         pempendt = ' ';
052560200224
052561200224         exsr determineType;
052562200810         exsr getPlan;
052563200224
052564200224         chain (pltrst : plsub# : acc#) actFile2;
052565200224         if %found;
052566200224          //dtaxid# = %char(a2tax_id#);
052567200224         endif;
052568200224
052569200810         if foundPlan = 'Y';
052570200224         if plncat = 'PLF';
052571200224         if pcovid1 <> ptype;
052572200224          pcovid1 = 'BLF';
052573200424          pplanid1 = '1';
052574200224          pcovefdt1 = %char(denrdt);
052575200224
052576200224          seq# = dpseq#;
052577200224          ssn = mcssno;
052578200224          termdt = ccandt;
052579200224          exsr checkTerm;
052580200224          if alreadySent = 'N';
052581200224
052582200224           if ccandt > 0;
052583200224            cancelh = ccandt;
052584200810             exsr get_planDate;
052585200224            pcovtrmdt1 = %char(cancelh);
052586200224           endif;
052587200224
052588200224           if writeRecord = 'Y';
052589200224            write priFile;
052590200224           endif;
052591200224           if updateRecord = 'Y';
052592200224            update priFile;
052593200224           endif;
052594200224
052595200224          endif;
052596200224         endif;
052597200224         endif;
052598200810         endif;
052599200224
052600200810         if foundPlan = 'Y';
052601200224         if plncat = 'PAC';
052602200224         if pcovid2 <> ptype;
052603200224          pcovid2 = 'ADD';
052604200424          pplanid2 = '1';
052605200224          pcovefdt2 = %char(denrdt);
052606200224
052607200224          seq# = dpseq#;
052608200224          ssn = mcssno;
052609200224          termdt = ccandt;
052610200224          exsr checkTerm;
052611200224          if alreadySent = 'N';
052612200224
052613200224           if ccandt > 0;
052614200224            cancelh = ccandt;
052615200810             exsr get_planDate;
052616200224            pcovtrmdt2 = %char(cancelh);
052617200224           endif;
052618200224
052619200224           if writeRecord = 'Y';
052620200224            write priFile;
052621200224           endif;
052622200224           if updateRecord = 'Y';
052623200224            update priFile;
052624200224           endif;
052625200224
052626200224          endif;
052627200224         endif;
052628200224         endif;
052629200810         endif;
052630200224
052631200810         if foundPlan = 'Y';
052632200424         if plncat = 'PSF';
052633200224         if pcovid3 <> ptype;
052634200224          pcovid3 = 'DLF';
052635200224          pcovefdt3 = %char(denrdt);
052636200224
052637200224          seq# = dpseq#;
052638200224          ssn = mcssno;
052639200224          termdt = ccandt;
052640200224          exsr checkTerm;
052641200224          if alreadySent = 'N';
052642200224
052643200224           if ccandt > 0;
052644200224            cancelh = ccandt;
052645200810             exsr get_planDate;
052646200224            pcovtrmdt3 = %char(cancelh);
052647200224           endif;
052648200224
052649200224           if writeRecord = 'Y';
052650200224            write priFile;
052651200224           endif;
052652200224           if updateRecord = 'Y';
052653200224            update priFile;
052654200224           endif;
052655200224
052656200224          endif;
052657200224         endif;
052658200224         endif;
052659200810         endif;
052660200224
052661200810         if foundPlan = 'Y';
052662200224         if plncat = 'PSL';
052663200224         if pcovid4 <> ptype;
052664200224          pcovid4 = 'EVL';
052665200224          pcovefdt4 = %char(denrdt);
052666200424          pbenamtel4 = %editc(benamt:'X');
052667200424          pbenamtap4 = %editc(benamt:'X');
052668200424          pbenperel4 = ' ';
052669200224          pplanid4 = '1';
052670200224
052671200224          seq# = dpseq#;
052672200224          ssn = mcssno;
052673200224          termdt = ccandt;
052674200224          exsr checkTerm;
052675200224          if alreadySent = 'N';
052676200224
052677200224           if ccandt > 0;
052678200224            cancelh = ccandt;
052679200810             exsr get_planDate;
052680200224            pcovtrmdt4 = %char(cancelh);
052681200224           endif;
052682200224
052683200224           if writeRecord = 'Y';
052684200224            write priFile;
052685200224           endif;
052686200224           if updateRecord = 'Y';
052687200224            update priFile;
052688200224           endif;
052689200224
052690200224          endif;
052691200224         endif;
052692200224         endif;
052693200810         endif;
052694200224
052695200810         if foundPlan = 'Y';
052696200224         if plncat = 'POA';
052697200224         if pcovid5 <> ptype;
052698200224          pcovid5 = 'EVA';
052699200224          pcovefdt5 = %char(enrldt);
052700200224          pplanid5 = '1';
052701200224
052702200224          seq# = dpseq#;
052703200224          ssn = mcssno;
052704200224          termdt = ccandt;
052705200224          exsr checkTerm;
052706200224          if alreadySent = 'N';
052707200224
052708200224           if ccandt > 0;
052709200224            cancelh = ccandt;
052710200810             exsr get_planDate;
052711200224            pcovtrmdt5 = %char(cancelh);
052712200224           endif;
052713200224
052714200224           if writeRecord = 'Y';
052715200224            write priFile;
052716200224           endif;
052717200224           if updateRecord = 'Y';
052718200224            update priFile;
052719200224           endif;
052720200224
052721200224          endif;
052722200224         endif;
052723200224         endif;
052724200810         endif;
052725200224
052726200810         if foundPlan = 'Y';
052727200224         if plncat = 'PSP';
052728200224         if pcovid6 <> ptype;
052729200224          pcovid6 = 'SVL';
052730200224          pcovefdt6 = %char(denrdt);
052731200424          pbenamtel6 = %editc(benamt:'X');
052732200424          pbenamtap6 = %editc(benamt:'X');
052733200224          pplanid6 = '1';
052734200224
052735200224          seq# = dpseq#;
052736200224          ssn = mcssno;
052737200224          termdt = ccandt;
052738200224          exsr checkTerm;
052739200224          if alreadySent = 'N';
052740200224
052741200224           if ccandt > 0;
052742200224            cancelh = ccandt;
052743200810             exsr get_planDate;
052744200224            pcovtrmdt6 = %char(cancelh);
052745200224           endif;
052746200224
052747200224           if writeRecord = 'Y';
052748200224            write priFile;
052749200224           endif;
052750200224           if updateRecord = 'Y';
052751200224            update priFile;
052752200224           endif;
052753200224
052754200224          endif;
052755200224         endif;
052756200224         endif;
052757200810         endif;
052758200224
052759200424         //if plncat = 'PSA';
052760200424         //if pcovid7 <> ptype;
052761200424         // pcovid7 = 'SVA';
052762200424         // pplanid7 = '1';
052763200424         // pcovefdt7 = %char(denrdt);
052764200224
052765200424         // seq# = dpseq#;
052766200424         // ssn = mcssno;
052767200424         // termdt = ccandt;
052768200424         // exsr checkTerm;
052769200424         // if alreadySent = 'N';
052770200224
052771200424         //  if ccandt > 0;
052772200424         //   cancelh = ccandt;
052773200810         //    exsr get_planDate;
052774200424         //   pcovtrmdt7 = %char(cancelh);
052775200424         //  endif;
052776200224
052777200424         //  if writeRecord = 'Y';
052778200424         //   write priFile;
052779200424         //  endif;
052780200424         //  if updateRecord = 'Y';
052781200424         //   update priFile;
052782200424         //  endif;
052783200224
052784200424         // endif;
052785200424         //endif;
052786200424         //endif;
052787200224
052788200424         //if plncat = 'PVD' or plncat = 'PSD';
052789200424         //if pcovid8 <> ptype;
052790200424         // pcovid8 = 'CVL';
052791200424         // pcovefdt8 = %char(denrdt);
052792200424         // pbenamtel8 = %editc(benamt:'X');
052793200424         // pbenamtap8 = %editc(benamt:'X');
052794200424         // pplanid8 = '1';
052795200224
052796200424         // seq# = dpseq#;
052797200424         // ssn = mcssno;
052798200424         // termdt = ccandt;
052799200424         // exsr checkTerm;
052800200424         // if alreadySent = 'N';
052801200224
052802200424         //  if candt > 0;
052803200424         //   cancelh = ccandt;
052804200810         //    exsr get_planDate;
052805200424         //   pcovtrmdt8 = %char(cancelh);
052806200424         //  endif;
052807200224
052808200424         //  if writeRecord = 'Y';
052809200424         //   write priFile;
052810200424         //  endif;
052811200424         //  if updateRecord = 'Y';
052812200424         //   update priFile;
052813200424         //  endif;
052814200224
052815200424          //endif;
052816200424         //endif;
052817200424         //endif;
052818200224
052819200810         if foundPlan = 'Y';
052820200224         if plncat = 'PWD';
052821200224         if pcovid9 <> ptype;
052822200224          pcovid9 = 'STD';
052823200224          pcovefdt9 = %char(enrldt);
052824200424          pbenamtel9 = %editc(benamt:'X');
052825200424          pbenamtap9 = %editc(benamt:'X');
052826200224          pplanid9 = '1';
052827200224
052828200224          ssn = mcssno;
052829200224          termdt = candt;
052830200224          exsr checkTerm;
052831200224          if alreadySent = 'N';
052832200224
052833200224           if candt > 0;
052834200224            cancelh = candt;
052835200810             exsr get_planDate;
052836200224            pcovtrmdt9 = %char(cancelh);
052837200224           endif;
052838200224
052839200224           if writeRecord = 'Y';
052840200224            write priFile;
052841200224           endif;
052842200224           if updateRecord = 'Y';
052843200224            update priFile;
052844200224           endif;
052845200224
052846200224          endif;
052847200224         endif;
052848200224         endif;
052849200810         endif;
052850200224
052851200810         if foundPlan = 'Y';
052852200224         if plncat = 'PLT';
052853200224         if pcovid10 <> ptype;
052854200224          pcovid10 = 'LTD';
052855200224          pcovefdt10 = %char(denrdt);
052856200424          pbenamte10 = %editc(benamt:'X');
052857200424          pbenamta10 = %editc(benamt:'X');
052858200224
052859200224          seq# = dpseq#;
052860200224          ssn = mcssno;
052861200224          termdt = ccandt;
052862200224          exsr checkTerm;
052863200224          if alreadySent = 'N';
052864200224
052865200224           if ccandt > 0;
052866200224            cancelh = ccandt;
052867200810             exsr get_planDate;
052868200224            pcovtrmd10 = %char(cancelh);
052869200224           endif;
052870200224
052871200224           if writeRecord = 'Y';
052872200224            write priFile;
052873200224           endif;
052874200224           if updateRecord = 'Y';
052875200224            update priFile;
052876200224           endif;
052877200224
052878200224          endif;
052879200224         endif;
052880200224         endif;
052881200810         endif;
052882200224
052883200810         if foundPlan = 'Y';
052884200224         if plncat = 'PDN';
052885200224         if pcovid11 <> ptype;
052886200224          pcovid11 = 'DEN';
052887200224          pcovefdt11 = %char(denrdt);
052888200224
052889200424          pplanid11 = '1';
052890200224
052891200224          seq# = dpseq#;
052892200224          ssn = mcssno;
052893200224          termdt = ccandt;
052894200224          exsr checkTerm;
052895200224          if alreadySent = 'N';
052896200224
052897200224           if ccandt > 0;
052898200224            cancelh = ccandt;
052899200810             exsr get_planDate;
052900200224            pcovtrmd11 = %char(cancelh);
052901200224           endif;
052902200224
052903200224           if writeRecord = 'Y';
052904200224            write priFile;
052905200224           endif;
052906200224           if updateRecord = 'Y';
052907200224            update priFile;
052908200224           endif;
052909200224
052910200224          endif;
052911200224         endif;
052912200224         endif;
052913200810         endif;
052914200224
052915200810         if foundPlan = 'Y';
052916200224         if plncat = 'PVS';
052917200224         if pcovid12 <> ptype;
052918200224          pcovid12 = 'VIS';
052919200424          pplanid12 = '1';
052920200424
052921200224          pcovefdt12 = %char(denrdt);
052922200224
052923200224          seq# = dpseq#;
052924200224          ssn = mcssno;
052925200224          termdt = ccandt;
052926200224          exsr checkTerm;
052927200224          if alreadySent = 'N';
052928200224
052929200224           if ccandt > 0;
052930200224            cancelh = ccandt;
052931200810             exsr get_planDate;
052932200224            pcovtrmd12 = %char(cancelh);
052933200224           endif;
052934200224
052935200224           if writeRecord = 'Y';
052936200224            write priFile;
052937200224           endif;
052938200224           if updateRecord = 'Y';
052939200224            update priFile;
052940200224           endif;
052941200224
052942200224          endif;
052943200224         endif;
052944200224         endif;
052945200810         endif;
052946200224
052947200810         if foundPlan = 'Y';
052948200224         if plncat = 'PCC';
052949200224         if pcovid13 <> ptype;
052950200224          pcovid13 = 'ECI';
052951200224          pcovefdt13 = %char(denrdt);
052952200424          pbenamte13 = %editc(benamt:'X');
052953200424          pbenamta13 = %editc(benamt:'X');
052954200224
052955200224          seq# = dpseq#;
052956200224          ssn = mcssno;
052957200224          termdt = ccandt;
052958200224          exsr checkTerm;
052959200224          if alreadySent = 'N';
052960200224
052961200224           if ccandt > 0;
052962200224            cancelh = ccandt;
052963200810             exsr get_planDate;
052964200224            pcovtrmd13 = %char(cancelh);
052965200224           endif;
052966200224
052967200224           if writeRecord = 'Y';
052968200224            write priFile;
052969200224           endif;
052970200224           if updateRecord = 'Y';
052971200224            update priFile;
052972200224           endif;
052973200224
052974200224          endif;
052975200224         endif;
052976200224         endif;
052977200810         endif;
052978200224
052979200810         if foundPlan = 'Y';
052980200224         if plncat = 'PCB';
052981200224         if pcovid14 <> ptype;
052982200224          pcovid14 = 'SCI';
052983200224          pcovefdt14 = %char(denrdt);
052984200424          pbenamte14 = %editc(benamt:'X');
052985200424          pbenamta14 = %editc(benamt:'X');
052986200224
052987200224          seq# = dpseq#;
052988200224          ssn = mcssno;
052989200224          termdt = ccandt;
052990200224          exsr checkTerm;
052991200224          if alreadySent = 'N';
052992200224
052993200224           if ccandt > 0;
052994200224            cancelh = ccandt;
052995200810             exsr get_planDate;
052996200224            pcovtrmd14 = %char(cancelh);
052997200224           endif;
052998200224
052999200224           if writeRecord = 'Y';
053000200224            write priFile;
053001200224           endif;
053002200224           if updateRecord = 'Y';
053003200224            update priFile;
053004200224           endif;
053005200224
053006200224          endif;
053007200224         endif;
053008200224         endif;
053009200810         endif;
053010200224
053011200810         if foundPlan = 'Y';
053012200224         if plncat = 'PCG';
053013200224         if pcovid15 <> ptype;
053014200224          pcovid15 = 'CCI';
053015200224          pcovefdt15 = %char(denrdt);
053016200424          pbenamte15 = %editc(benamt:'X');
053017200424          pbenamta15 = %editc(benamt:'X');
053018200224
053019200224          seq# = dpseq#;
053020200224          ssn = mcssno;
053021200224          termdt = ccandt;
053022200224          exsr checkTerm;
053023200224          if alreadySent = 'N';
053024200224
053025200224           if ccandt > 0;
053026200224            cancelh = ccandt;
053027200810             exsr get_planDate;
053028200224            pcovtrmd15 = %char(cancelh);
053029200224           endif;
053030200224
053031200224           if writeRecord = 'Y';
053032200224            write priFile;
053033200224           endif;
053034200224           if updateRecord = 'Y';
053035200224            update priFile;
053036200224           endif;
053037200224
053038200224          endif;
053039200224         endif;
053040200224         endif;
053041200810         endif;
053042200224
053043200810         if foundPlan = 'Y';
053044200224         if plncat = 'PO6';
053045200224         if pcovid16 <> ptype;
053046200224          pcovid16 = 'ACC';
053047200224          pcovefdt16 = %char(denrdt);
053048200224
053049200224          seq# = dpseq#;
053050200224          ssn = mcssno;
053051200224          termdt = ccandt;
053052200224          exsr checkTerm;
053053200224          if alreadySent = 'N';
053054200224
053055200224           if ccandt > 0;
053056200224            cancelh = ccandt;
053057200810             exsr get_planDate;
053058200224            pcovtrmd16 = %char(cancelh);
053059200224           endif;
053060200224
053061200224           if writeRecord = 'Y';
053062200224            write priFile;
053063200224           endif;
053064200224           if updateRecord = 'Y';
053065200224            update priFile;
053066200224           endif;
053067200224
053068200224          endif;
053069200224         endif;
053070200224         endif;
053071200810         endif;
053072200224
066800160516       endsr;
066900160511
067000160519      //===================================================================
067100160519      // Get group number
067200160519      //===================================================================
067300160519
067400181031       begsr getGroup;
067500160519
067600160519        setll (pltrst : plsub# : plplan) grater;
067700160519        reade (pltrst : plsub# : plplan) grater;
067800160519
067900160519        dow not %eof;
068000160519
068100160519         if today >= frmdat;
068200160519          if today <= todat;
068300200228           //leavesr;
068301200228           leave;
068400160519          else;
068500160519           group# = ' ';
068600160519          endif;
068700160519         endif;
068800160519
068900160519        reade (pltrst : plsub# : plplan) grater;
069000160519        enddo;
069001200228
069100200224        pos = %scan('-':group#);
069101200224        if pos > 0;
069102200224         pos = pos -1;
069103200224         pacct# = %subst(group#:1:pos);
069104200224        else;
069105200224         pacct# = group#;
069106200224        endif;
069107200224
069108200224        if p_acct > ' ';
069109200224         if pacct# <> p_acct;
069110200224          pacct# = ' ';
069111200224         endif;
069112200224        endif;
069113200224
069200200228       endsr;
069300180313
069400190226      //===================================================================
069500190226      // Determine Type
069600190226      //===================================================================
069700190226
069800190226       begsr determineType;
069900190226
070000200224        ptype = ' ';
070100190226
070101200224         select;
070102200224          when plncat = 'PLF';
070103200224           ptype = 'BLF';
070104200224
070105200424          when plncat = 'PAC';
070106200424           ptype = 'ADD';
070107200424
070108200424          when plncat = 'PSF';
070109200224           ptype = 'DLF';
070110200224
070111200224          when plncat = 'PSL';
070112200224           ptype = 'EVL';
070113200224
070114200224          when plncat = 'POA';
070115200224           ptype = 'EVA';
070116200224
070117200224          when plncat = 'PSP';
070118200224           ptype = 'SVL';
070119200224
070120200224          when plncat = 'PSA';
070121200224           ptype = 'SVA';
070122200224
070123200224          when plncat = 'PVD';
070124200224           ptype = 'CVL';
070125200224
070126200424          when plncat = 'PSD';
070127200424           ptype = 'CVL';
070128200424
070129200224          when plncat = 'PLT';
070130200224           ptype = 'LTD';
070131200224
070132200224          when plncat = 'PDN';
070133200224           ptype = 'DEN';
070134200224
070135200224          when plncat = 'PVS';
070136200224           ptype = 'VIS';
070137200224
070138200224          when plncat = 'PCC';
070139200224           ptype = 'ECI';
070140200224
070141200224          when plncat = 'PCB';
070142200224           ptype = 'SCI';
070143200224
070144200224          when plncat = 'PCG';
070145200224           ptype = 'CCI';
070146200224
070147200224          when plncat = 'PO6';
070148200224           ptype = 'ACC';
070149200224
070150200424          when plncat = 'PWD';
070151200424           ptype = 'STD';
070152200424
070153200224         endsl;
071700190226
071800190226       endsr;
071900190226
071901200228      //===================================================================
071902200228      // coverage tier
071903200228      //===================================================================
071904200228
071905200228       begsr coverageTier;
071906200228
071907200228       tier = ' ';
071908200228
071909200228       select;
071910200228        when mcovtp = 'TIN';
071911200228         tier = '1';
071912200228
071913200228        when mcovtp = 'TFA';
071914200228         tier = '2';
071915200228
071916200228        when mcovtp = 'THW';
071917200228         tier = '3';
071918200228
071919200228        when mcovtp = 'TPC' or mcovtp = 'TP2';
071920200228         tier = '4';
071921200228
071922200228        when mcovtp = 'TU1' or mcovtp = 'TU2' or mcovtp = 'TU3';
071924200228         tier = '5';
071928200228       endsl;
071929200228
071930200228       endsr;
071931200228
072000180313      //===================================================================
072100180313      // Relationship Codes
072200180313      //===================================================================
072300180313
072400180313       begsr relCodes;
072500180313
072501200424        prel = ' ';
072502200424
072600181030        select;
072700181030         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
072701200224          prel = 'S';
072702200224
073000181030         when drelcd = 'RDA' or drelcd = 'RSO';
073001200224          prel = 'C';
073200181030
073300181030        endsl;
073400181030
073500180313       endsr;
073600180424
073601200228      //===================================================================
073602200228      // check for transmission
073603200228      //===================================================================
073604200228
073605200228       begsr checkTransmission;
073606200228
073608200228        ok_toTransmit = 'Y';
073609200228        leavesr;
073610200228        chain (carrier : pltrst : plsub# : acc#) transFile;
073611200228        if %found;
073612200228         ok_toTransmit = 'N';
073614200228        endif;
074206190401
075105190401       endsr;
075106190401
075107200424      //===================================================================
075108200424      // format salary
075109200424      //===================================================================
075110200424
075111200424       begsr formatSalary;
075112200424
075113200424        salaryHold = ' ';
075114200424
075115200424        size = %len(%trim(%char(salary)));
075116200424        if size = 5;
075117200424         salaryHold = %replace('00000000':salaryHold:1);
075118200424         salaryHold = %replace(%char(salary):salaryHold:9);
075120200424        endif;
075121200424
075122200424        if size = 6;
075123200424         salaryHold = %replace('0000000':salaryHold:1);
075124200424         salaryHold = %replace(%char(salary):salaryHold:8);
075125200424        endif;
075126200424
075127200424        salaryHold = %replace('00':salaryHold:14);
075128200424
075129200424       endsr;
075130200424
075131200810      //===================================================================
075132200810      // get plan
075133200810      //===================================================================
075134200810
075135200810       begsr getPlan;
075136200810
075137200810        foundPlan = 'N';
075138200810
075139200810        chain (unique : pltrst : plsub# : acc# : ptype : plplan) planSetup;
075140200810        if %found;
075141200810         foundPlan = 'Y';
075142200810        endif;
075143200810
075144200810       endsr;
075145200810
075200160511      //===================================================================
075300160511      // exit
075400160511      //===================================================================
075500160511
075600160511       begsr exit;
075700160511
075800160511        *inlr = '1';
075900160511        return;
076000160511
076100160511       endsr;
076200160511
076300160511      //===================================================================
076400160511      // init
076500160511      //===================================================================
076600160520
076700160511       begsr init;
076800160511
076801200224        carrierCode1 = 'PFL';
076802200224        carrierCode2 = 'PFR';
076803200224        carrierCode3 = 'PRD';
076804200224        carrierCode4 = 'PRL';
076805200224        carrierCode5 = 'PVL';
076806200224        grouperCode = 'PL';
077000200224        carrier = 20;
077100200810        unique = '0000000329';
077200181031
077300160519        today = %dec(%char(%date:*iso0):8:0);
077400181105
077500160511       endsr;
077600010412
077700160511       //==============================================================
