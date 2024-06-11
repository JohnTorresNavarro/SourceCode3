000100210217      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200224      * PRI010R - Principal Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800200228      * 02/28/2020  jt    Original creation
000801200810      * 08/10/2020  jt    Change to be less hardcoding
000802200909      * 09/11/2020  jt    Change transmission check
000803201027      * 10/27/2020  jt    Added smoker flag.
000804201116      * 11/16/2020  jt    Added category PVW
000805201119      * 11/19/2020  jt    Added hours worked and class ID
000806210205      * 02/05/2021  jt    Added more logic to check transmission subr.
000807210216      * 02/16/2021  jt    Added plan id's that were missing. Fixed phone.
000808210217      * 02/17/2021  jt    Changed class ID.
000809210519      * 05/19/2021  jt    Added handicap
000810220223      * 02/23/2022  jt    Added plan categories PLL and PA1
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
002300210217
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
004201210217     fcarplnz   if   e           k disk    rename(carplnr:planSetup)
004202200810
004300200224     fpridetail uf a e           k disk    rename(prhr:priFile)
004400160513
004900200224     fpritrm    uf a e           k disk    rename(pritr:termFile)
005000180523
005100200915     fcaraccp   if   e           k disk    rename(caraccr:transFile)
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
005901200810     d unique          s             10
005902200810     d foundPlan       s              1
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
007801200224     d pos             s              2  0
007802201116     d pos2            s              2  0
007803200424     d size            s              1  0
007804200424     d salaryHold      s             15
007805200810     d outDate         s              8
007806201119     d holdClass       s              5
008100150820
008502200810     d lastday         pr                  extpgm('LASTDAY2')
008503200810     d  ctrust                        3    const
008504200810     d  csub                          3    const
008505200810     d  cplan                         4    const
008506200810     d  inDate                        8    const
008507200810     d  outDate                       8    const
008509200810
008510200915     d pri010rz        pi
008511200224     d  p_acct                        7
008512200915     d  inType                        1
008513200224
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
014702200915        exsr checkTransmission;
014703200915        if ok_toTransmit = 'N';
014704200915         leavesr;
014705200915        endif;
014707200915
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
018424210217         //pclassid = ' ';
018425200224         pprov = ' ';
018426200424         pzip = %subst(%editc(zip:'X'):1:5);
018427200224         pcountry = ' ';
018428200224
018429210216         phphone = ' ';
018430210216         if area > 0 and phone > 0;
018431210216          phphone = %editc(area:'X') + %editc(phone:'X');
018432210216         endif;
018433210216
018434200514         pemail = %subst(fill66:1:65);
018435200224
018437230113         plocid = cacid4;
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
018453201116         pemphrs = '4000';
018454200224
018455200224         pcocostdt = ' ';
018456200224         pcocoendt = ' ';
018457200224         pretdt = ' ';
018458200224         pempendt = ' ';
018460200224
018462200224         exsr determineType;
018463200810         exsr getplan;
018464200224
018900200228         chain (pltrst : plsub# : acc#) actFile2;
019000190226         if %found;
019100200228          //dtaxid# = %char(a2tax_id#);
019200190226         endif;
019300190226
019301200810         if foundPlan = 'Y';
019302220223         if plncat = 'PLF' or plncat = 'PLL';
019303200224         if pcovid1 <> ptype;
019304200224          pcovid1 = 'BLF';
019305200810          pplanid1 = cpcid1;
019306210217
019310200224          pcovefdt1 = %char(enrldt);
019311200424
019312200224          if salary > 0;
019313200424           exsr formatSalary;
019314200424            pempsala1 = salaryHold;
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
019335210217           if cpcid2 > ' ' and pclassid = ' ';
019336210217            pclassid = cpcid2;
019337210217           endif;
019338210217
019339200228           if candt > 0;
019340200228            cancelh = candt;
019341200810             exsr get_planDate;
019342200224            pcovtrmdt1 = %char(cancelh);
019343200228           endif;
019344200228
019345200228           if writeRecord = 'Y';
019346200224            write priFile;
019347200228           endif;
019348200228           if updateRecord = 'Y';
019349200224            update priFile;
019350200228           endif;
019351200224
019352200228          endif;
019353200228         endif;
019354200224         endif;
019355200810         endif;
019356200810
019357200810         if foundPlan = 'Y';
019358220223         if plncat = 'PAC' or plncat = 'PA1';
019359200224         if pcovid2 <> ptype;
019360200224          pcovid2 = 'ADD';
019361200810          pplanid2 = cpcid1;
019364200224          pcovefdt2 = %char(enrldt);
019365200224
019366200224          ssn = mcssno;
019367200224          termdt = candt;
019368200224          exsr checkTerm;
019369200224          if alreadySent = 'N';
019370200224
019371210217           if cpcid2 > ' ' and pclassid = ' ';
019372210217            pclassid = cpcid2;
019373210217           endif;
019374210217
019375200224           if candt > 0;
019376200224            cancelh = candt;
019377200810             exsr get_planDate;
019378200224            pcovtrmdt2 = %char(cancelh);
019379200224           endif;
019380200224
019381200224           if writeRecord = 'Y';
019382200224            write priFile;
019383200224           endif;
019384200224           if updateRecord = 'Y';
019385200224            update priFile;
019386200224           endif;
019387200224
019388200224          endif;
019389200224         endif;
019390200224         endif;
019391200810         endif;
019392200224
019393200810         if foundPlan = 'Y';
019394200424         if plncat = 'PSF';
019395200224         if pcovid3 <> ptype;
019396200224          pcovid3 = 'DLF';
019397210216          pplanid3 = cpcid1;
019401200224          pcovefdt3 = %char(enrldt);
019402200224
019403200224          ssn = mcssno;
019404200224          termdt = candt;
019405200224          exsr checkTerm;
019406200224          if alreadySent = 'N';
019407200224
019408210217           if cpcid2 > ' ' and pclassid = ' ';
019409210217            pclassid = cpcid2;
019410210217           endif;
019411210217
019412200224           if candt > 0;
019413200224            cancelh = candt;
019414200810             exsr get_planDate;
019415200224            pcovtrmdt3 = %char(cancelh);
019416200224           endif;
019417200224
019418200224           if writeRecord = 'Y';
019419200224            write priFile;
019420200224           endif;
019421200224           if updateRecord = 'Y';
019422200224            update priFile;
019423200224           endif;
019424200224
019425200224          endif;
019426200224         endif;
019427200224         endif;
019428200810         endif;
023626200228
023627200810         if foundPlan = 'Y';
026601200224         if plncat = 'PSL';
026602200224         if pcovid4 <> ptype;
026603200224          pcovid4 = 'EVL';
026604200224          pcovefdt4 = %char(enrldt);
026605200424          pbenamtel4 = %editc(benamt:'X');
026606200424          pbenamtap4 = %editc(benamt:'X');
026607200424          pbenperel4 = ' ';
026608200810          pplanid4 = cpcid1;
026612201027
026613201027          pnicusa = 'N';
026614201027          chain mcssno smoker;
026615201027          if %found;
026616201027           pnicusa = 'T';
026617201027          endif;
026618201028
026619200224          if salary > 0;
026620200424           exsr formatSalary;
026621200424            pempsala4 = salaryHold;
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
026636210217           if cpcid2 > ' ' and pclassid = ' ';
026637210217            pclassid = cpcid2;
026638210217           endif;
026639210217
026640200224           if candt > 0;
026641200224            cancelh = candt;
026642200810             exsr get_planDate;
026643200224            pcovtrmdt4 = %char(cancelh);
026644200224           endif;
026645200224
026646200224           if writeRecord = 'Y';
026647200224            write priFile;
026648200224           endif;
026649200224           if updateRecord = 'Y';
026650200224            update priFile;
026651200224           endif;
026652200224
026653200224          endif;
026654200224         endif;
026655200224         endif;
026656200810         endif;
026657200224
026658200810         if foundPlan = 'Y';
026659200224         if plncat = 'POA';
026660200224         if pcovid5 <> ptype;
026661200224          pcovid5 = 'EVA';
026662200224          pcovefdt5 = %char(enrldt);
026663200810          pplanid5 = cpcid1;
026668200224          ssn = mcssno;
026669200224          termdt = candt;
026670200224          exsr checkTerm;
026671200224          if alreadySent = 'N';
026672200224
026673210217           if cpcid2 > ' ' and pclassid = ' ';
026674210217            pclassid = cpcid2;
026675210217           endif;
026676210217
026677200224           if candt > 0;
026678200224            cancelh = candt;
026679200810             exsr get_planDate;
026680200224            pcovtrmdt5 = %char(cancelh);
026681200224           endif;
026682200224
026683200224           if writeRecord = 'Y';
026684200224            write priFile;
026685200224           endif;
026686200224           if updateRecord = 'Y';
026687200224            update priFile;
026688200224           endif;
026689200224
026690200224          endif;
026691200224         endif;
026692200224         endif;
026693200810         endif;
026694200224
026695200810         if foundPlan = 'Y';
026696200224         if plncat = 'PSP';
026697200224         if pcovid6 <> ptype;
026698200224          pcovid6 = 'SVL';
026699200224          pcovefdt6 = %char(enrldt);
026700200424          pbenamtel6 = %editc(benamt:'X');
026701200424          pbenamtap6 = %editc(benamt:'X');
026702200810          pplanid6 = cpcid1;
026706200224
026707201027          pnicusa = 'N';
026708201027          chain mcssno smoker;
026709201027          if %found;
026710201027           pnicusa = 'T';
026711201027          endif;
026712201027
026713200224          ssn = mcssno;
026714200224          termdt = candt;
026715200224          exsr checkTerm;
026716200224          if alreadySent = 'N';
026717200224
026718210217           if cpcid2 > ' ' and pclassid = ' ';
026719210217            pclassid = cpcid2;
026720210217           endif;
026721210217
026722200224           if candt > 0;
026723200224            cancelh = candt;
026724200810             exsr get_planDate;
026725200224            pcovtrmdt6 = %char(cancelh);
026726200224           endif;
026727200224
026728200224           if writeRecord = 'Y';
026729200224            write priFile;
026730200224           endif;
026731200224           if updateRecord = 'Y';
026732200224            update priFile;
026733200224           endif;
026734200224
026735200224          endif;
026736200224         endif;
026737200224         endif;
026738200810         endif;
026739200224
026740200810         if foundPlan = 'Y';
026741200224         if plncat = 'PSA';
026742200224         if pcovid7 <> ptype;
026743200224          pcovid7 = 'SVA';
026744200810          pplanid7 = cpcid1;
026749200224          pcovefdt7 = %char(enrldt);
026750200224
026751200224          ssn = mcssno;
026752200224          termdt = candt;
026753200224          exsr checkTerm;
026754200224          if alreadySent = 'N';
026755200224
026756210217           if cpcid2 > ' ' and pclassid = ' ';
026757210217            pclassid = cpcid2;
026758210217           endif;
026759210217
026760200224           if candt > 0;
026761200224            cancelh = candt;
026762200810             exsr get_planDate;
026763200224            pcovtrmdt7 = %char(cancelh);
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
026779200424         if plncat = 'PVD' or plncat = 'PSD';
026780200224         if pcovid8 <> ptype;
026781200224          pcovid8 = 'CVL';
026782200224          pcovefdt8 = %char(enrldt);
026783200424          pbenamtel8 = %editc(benamt:'X');
026784200424          pbenamtap8 = %editc(benamt:'X');
026785200810          pplanid8 = cpcid1;
026790200224          ssn = mcssno;
026791200224          termdt = candt;
026792200224          exsr checkTerm;
026793200224          if alreadySent = 'N';
026794200224
026795210217           if cpcid2 > ' ' and pclassid = ' ';
026796210217            pclassid = cpcid2;
026797210217           endif;
026798210217
026799200224           if candt > 0;
026800200224            cancelh = candt;
026801200810             exsr get_planDate;
026802200224            pcovtrmdt8 = %char(cancelh);
026803200224           endif;
026804200224
026805200224           if writeRecord = 'Y';
026806200224            write priFile;
026807200224           endif;
026808200224           if updateRecord = 'Y';
026809200224            update priFile;
026810200224           endif;
026811200224
026812200224          endif;
026813200224         endif;
026814200224         endif;
026815200810         endif;
026816200224
026817200810         if foundPlan = 'Y';
026818201116         if plncat = 'PWD' or plncat = 'PVW';
026819200224         if pcovid9 <> ptype;
026820200224          pcovid9 = 'STD';
026821200224          pcovefdt9 = %char(enrldt);
026822200424          pbenamtel9 = %editc(benamt:'X');
026823200424          pbenamtap9 = %editc(benamt:'X');
026824200810          pplanid9 = cpcid1;
026829200224          if salary > 0;
026830200424           exsr formatSalary;
026831200424            pempsala9 = salaryHold;
026832200224           pempsalm9 = 'A';
026833200224          endif;
026834200224
026835200224          if empdt > 0;
026836200424           pempsaedt9 = %char(empdt);
026837200224          endif;
026838200224
026839200224          ssn = mcssno;
026840200224          termdt = candt;
026841200224          exsr checkTerm;
026842200224          if alreadySent = 'N';
026843200224
026844210217           if cpcid2 > ' ' and pclassid = ' ';
026845210217            pclassid = cpcid2;
026846210217           endif;
026847210217
026848200224           if candt > 0;
026849200224            cancelh = candt;
026850200810             exsr get_planDate;
026851200224            pcovtrmdt9 = %char(cancelh);
026852200224           endif;
026853200224
026854200224           if writeRecord = 'Y';
026855200224            write priFile;
026856200224           endif;
026857200224           if updateRecord = 'Y';
026858200224            update priFile;
026859200224           endif;
026860200224
026861200224          endif;
026862200224         endif;
026863200224         endif;
026864200810         endif;
026865200224
026866200810         if foundPlan = 'Y';
026867201027         if plncat = 'PLT' or plncat = 'PVL';
026868200224         if pcovid10 <> ptype;
026869200224          pcovid10 = 'LTD';
026870200810          pplanid10 = cpcid1;
026874200424
026875200224          pcovefdt10 = %char(enrldt);
026876200224
026877200224          if salary > 0;
026878200424           exsr formatSalary;
026879200424            pempsala10 = salaryHold;
026880200224           pempsalm10 = 'A';
026881200224          endif;
026882200224
026883200224          if empdt > 0;
026884200224           pempsaed10 = %char(empdt);
026885200224          endif;
026886200224
026887200224          ssn = mcssno;
026888200224          termdt = candt;
026889200224          exsr checkTerm;
026890200224          if alreadySent = 'N';
026891200224
026892210217           if cpcid2 > ' ' and pclassid = ' ';
026893210217            pclassid = cpcid2;
026894210217           endif;
026895210217
026896200224           if candt > 0;
026897200224            cancelh = candt;
026898200810             exsr get_planDate;
026899200224            pcovtrmd10 = %char(cancelh);
026900200224           endif;
026901200224
026902200224           if writeRecord = 'Y';
026903200224            write priFile;
026904200224           endif;
026905200224           if updateRecord = 'Y';
026906200224            update priFile;
026907200224           endif;
026908200224
026909200224          endif;
026910200224         endif;
026911200224         endif;
026912200810         endif;
026913200224
026914200810         if foundPlan = 'Y';
026915200224         if plncat = 'PDN';
026916200224         if pcovid11 <> ptype;
026917200224          pcovid11 = 'DEN';
026918210217          pplanid11 = cpcid1;
026922200224          pcovefdt11 = %char(enrldt);
026923200224
026924200224          ssn = mcssno;
026925200224          termdt = candt;
026926200224          exsr checkTerm;
026927200224          if alreadySent = 'N';
026928200224
026929210217           if cpcid2 > ' ' and pclassID = ' ';
026930210217            pclassid = cpcid2;
026933210217           endif;
026934210217
026935200224           if candt > 0;
026936200224            cancelh = candt;
026937200810             exsr get_planDate;
026938200224            pcovtrmd11 = %char(cancelh);
026939200224           endif;
026940200224
026941200224           if writeRecord = 'Y';
026942200224            write priFile;
026943200224           endif;
026944200224           if updateRecord = 'Y';
026945200224            update priFile;
026946200224           endif;
026947200224
026948200224          endif;
026949200224         endif;
026950200224         endif;
026951200810         endif;
026952200224
026953200810         if foundPlan = 'Y';
026954200224         if plncat = 'PVS';
026955200224         if pcovid12 <> ptype;
026956200224          pcovid12 = 'VIS';
026957200810          pplanid12 = cpcid1;
026958200424
026959200224          pcovefdt12 = %char(enrldt);
026960200224
026961200224          ssn = mcssno;
026962200224          termdt = candt;
026963200224          exsr checkTerm;
026964200224          if alreadySent = 'N';
026965200224
026966210217           if cpcid2 > ' ' and pclassID = ' ';
026967210217            pclassid = cpcid2;
026970210217           endif;
026971210217
026972200224           if candt > 0;
026973200224            cancelh = candt;
026974200810             exsr get_planDate;
026975200224            pcovtrmd12 = %char(cancelh);
026976200224           endif;
026977200224
026978200224           if writeRecord = 'Y';
026979200224            write priFile;
026980200224           endif;
026981200224           if updateRecord = 'Y';
026982200224            update priFile;
026983200224           endif;
026984200224
026985200224          endif;
026986200224         endif;
026987200224         endif;
026988200810         endif;
026989200224
026990200810         if foundPlan = 'Y';
026991200224         if plncat = 'PCC';
026992200224         if pcovid13 <> ptype;
026993200224          pcovid13 = 'ECI';
026994200224          pcovefdt13 = %char(enrldt);
026995210216          pplanid13 = cpcid1;
026996200424          pbenamte13 = %editc(benamt:'X');
026997200424          pbenamta13 = %editc(benamt:'X');
026998200224
026999200224          ssn = mcssno;
027000200224          termdt = candt;
027001200224          exsr checkTerm;
027002200224          if alreadySent = 'N';
027003200224
027004210217           if cpcid2 > ' ' and pclassid = ' ';
027005210217            pclassid = cpcid2;
027006210217           endif;
027007210217
027008200224           if candt > 0;
027009200224            cancelh = candt;
027010200810             exsr get_planDate;
027011200224            pcovtrmd13 = %char(cancelh);
027012200224           endif;
027013200224
027014200224           if writeRecord = 'Y';
027015200224            write priFile;
027016200224           endif;
027017200224           if updateRecord = 'Y';
027018200224            update priFile;
027019200224           endif;
027020200224
027021200224          endif;
027022200224         endif;
027023200224         endif;
027024200810         endif;
027025200224
027026200810         if foundPlan = 'Y';
027027200224         if plncat = 'PCB';
027028200224         if pcovid14 <> ptype;
027029200224          pcovid14 = 'SCI';
027030210216          pplanid14 = cpcid1;
027033200224          pcovefdt14 = %char(enrldt);
027034200424          pbenamte14 = %editc(benamt:'X');
027035200424          pbenamta14 = %editc(benamt:'X');
027036200224
027037200224          ssn = mcssno;
027038200224          termdt = candt;
027039200224          exsr checkTerm;
027040200224          if alreadySent = 'N';
027041200224
027042210217           if cpcid2 > ' ' and pclassid = ' ';
027043210217            pclassid = cpcid2;
027044210217           endif;
027045210217
027046200224           if candt > 0;
027047200224            cancelh = candt;
027048200810             exsr get_planDate;
027049200224            pcovtrmd14 = %char(cancelh);
027050200224           endif;
027051200224
027052200224           if writeRecord = 'Y';
027053200224            write priFile;
027054200224           endif;
027055200224           if updateRecord = 'Y';
027056200224            update priFile;
027057200224           endif;
027058200224
027059200224          endif;
027060200224         endif;
027061200224         endif;
027062200810         endif;
027063200224
027064200810         if foundPlan = 'Y';
027065200224         if plncat = 'PCG';
027066200224         if pcovid15 <> ptype;
027067200224          pcovid15 = 'CCI';
027068210216          pplanid15 = cpcid1;
027073200224          pcovefdt15 = %char(enrldt);
027074200424          pbenamte15 = %editc(benamt:'X');
027075200424          pbenamta15 = %editc(benamt:'X');
027076200224
027077200224          ssn = mcssno;
027078200224          termdt = candt;
027079200224          exsr checkTerm;
027080200224          if alreadySent = 'N';
027081200224
027082210217           if cpcid2 > ' ' and pclassid = ' ';
027083210217            pclassid = cpcid2;
027084210217           endif;
027085210217
027086200224           if candt > 0;
027087200224            cancelh = candt;
027088200810             exsr get_planDate;
027089200224            pcovtrmd15 = %char(cancelh);
027090200224           endif;
027091200224
027092200224           if writeRecord = 'Y';
027093200224            write priFile;
027094200224           endif;
027095200224           if updateRecord = 'Y';
027096200224            update priFile;
027097200224           endif;
027098200224
027099200224          endif;
027100200224         endif;
027101200224         endif;
027102200810         endif;
027103200224
027104200810         if foundPlan = 'Y';
027105200224         if plncat = 'PO6';
027106200224         if pcovid16 <> ptype;
027107200224          pcovid16 = 'ACC';
027108210216          pplanid16 = cpcid1;
027113200224          pcovefdt16 = %char(enrldt);
027114200224
027115200224          ssn = mcssno;
027116200224          termdt = candt;
027117200224          exsr checkTerm;
027118200224          if alreadySent = 'N';
027119200224
027120210217           if cpcid2 > ' ' and pclassid = ' ';
027121210217            pclassid = cpcid2;
027122210217           endif;
027123210217
027124200224           if candt > 0;
027125200224            cancelh = candt;
027126200810             exsr get_planDate;
027127200224            pcovtrmd16 = %char(cancelh);
027128200224           endif;
027129200224
027130200224           if writeRecord = 'Y';
027131200224            write priFile;
027132200224           endif;
027133200224           if updateRecord = 'Y';
027134200224            update priFile;
027135200224           endif;
027136200224
027137200224          endif;
027138200224         endif;
027139200224         endif;
027140200810         endif;
027141200224
033300190227         if mcovtp <> 'TIN';
033400190227          exsr dependent;
033500190227         endif;
033600180523
033700160516       endsr;
033800060817
039800180913      //===================================================================
039900200810      // get canceled date according to plan setup
040000180913      //===================================================================
040100180913
040200200810       begsr get_planDate;
040300180913
040301200810        lastday(%char(pltrst):%char(plsub#):tplan:%char(cancelh):outDate);
040600200810        cancelh = %dec(outDate:8:0);
040700180913
040800180913       endsr;
040900180913
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
052524210217         //pclassid = ' ';
052525200224         pprov = ' ';
052526200424         pzip = %subst(%editc(dzip:'X'):1:5);
052527200224         pcountry = ' ';
052528200224
052529210216         phphone = ' ';
052530210216         if area > 0 and phone > 0;
052531210216          phphone = %editc(area:'X') + %editc(phone:'X');
052532210216         endif;
052533200224
052534200424         //pnicusa = 'N';
052535200224         chain (mcssno : dpseq#) smoker;
052536200224         if %found;
052537200424          //pnicusa = 'T';
052538200224         endif;
052539200224
052540230113         plocid = cacid4;
052541200224         psupid1 = ' ';
052542200224         psupid2 = ' ';
052543200224         psupid3 = ' ';
052544200224         psupid4 = ' ';
052545200224         psupid5 = ' ';
052546200224         psupid6 = ' ';
052547200224
052548200224         peventcd = ' ';
052549200224         peventdt = ' ';
052550200224
052551200224         pempdt = ' ';
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
052570220223         if plncat = 'PLF' or plncat = 'PLL';
052571200224         if pcovid1 <> ptype;
052572200224          pcovid1 = 'BLF';
052573200810          pplanid1 = cpcid1;
052577200224          pcovefdt1 = %char(denrdt);
052578200224
052579200224          seq# = dpseq#;
052580200224          ssn = mcssno;
052581200224          termdt = ccandt;
052582200224          exsr checkTerm;
052583200224          if alreadySent = 'N';
052584200224
052585210217           if cpcid2 > ' ' and pclassid = ' ';
052586210217            pclassid = cpcid2;
052587210217           endif;
052588210217
052589200224           if ccandt > 0;
052590200224            cancelh = ccandt;
052591200810             exsr get_planDate;
052592200224            pcovtrmdt1 = %char(cancelh);
052593200224           endif;
052594200224
052595200224           if writeRecord = 'Y';
052596200224            write priFile;
052597200224           endif;
052598200224           if updateRecord = 'Y';
052599200224            update priFile;
052600200224           endif;
052601200224
052602200224          endif;
052603200224         endif;
052604200224         endif;
052605200810         endif;
052606200224
052607200810         if foundPlan = 'Y';
052608220223         if plncat = 'PAC' or plncat = 'PA1';
052609200224         if pcovid2 <> ptype;
052610200224          pcovid2 = 'ADD';
052611200810          pplanid2 = cpcid1;
052615200224          pcovefdt2 = %char(denrdt);
052616200224
052617200224          seq# = dpseq#;
052618200224          ssn = mcssno;
052619200224          termdt = ccandt;
052620200224          exsr checkTerm;
052621200224          if alreadySent = 'N';
052622200224
052623210217           if cpcid2 > ' ' and pclassid = ' ';
052624210217            pclassid = cpcid2;
052625210217           endif;
052626210217
052627200224           if ccandt > 0;
052628200224            cancelh = ccandt;
052629200810             exsr get_planDate;
052630200224            pcovtrmdt2 = %char(cancelh);
052631200224           endif;
052632200224
052633200224           if writeRecord = 'Y';
052634200224            write priFile;
052635200224           endif;
052636200224           if updateRecord = 'Y';
052637200224            update priFile;
052638200224           endif;
052639200224
052640200224          endif;
052641200224         endif;
052642200224         endif;
052643200810         endif;
052644200224
052645200810         if foundPlan = 'Y';
052646200424         if plncat = 'PSF';
052647200224         if pcovid3 <> ptype;
052648210216          pplanid3 = cpcid1;
052652200224          pcovid3 = 'DLF';
052653200224          pcovefdt3 = %char(denrdt);
052654200224
052655200224          seq# = dpseq#;
052656200224          ssn = mcssno;
052657200224          termdt = ccandt;
052658200224          exsr checkTerm;
052659200224          if alreadySent = 'N';
052660200224
052661210217           if cpcid2 > ' ' and pclassid = ' ';
052662210217            pclassid = cpcid2;
052663210217           endif;
052664210217
052665200224           if ccandt > 0;
052666200224            cancelh = ccandt;
052667200810             exsr get_planDate;
052668200224            pcovtrmdt3 = %char(cancelh);
052669200224           endif;
052670200224
052671200224           if writeRecord = 'Y';
052672200224            write priFile;
052673200224           endif;
052674200224           if updateRecord = 'Y';
052675200224            update priFile;
052676200224           endif;
052677200224
052678200224          endif;
052679200224         endif;
052680200224         endif;
052681200810         endif;
052682200810
052683200810         if foundPlan = 'Y';
052684200224         if plncat = 'PSL';
052685200224         if pcovid4 <> ptype;
052686200224          pcovid4 = 'EVL';
052687200224          pcovefdt4 = %char(denrdt);
052688200424          pbenamtel4 = %editc(benamt:'X');
052689200424          pbenamtap4 = %editc(benamt:'X');
052690200424          pbenperel4 = ' ';
052691200810          pplanid4 = cpcid1;
052695200224
052696201027          pnicusa = 'N';
052697201028          chain (mcssno : dpseq#) smoker;
052698201027          if %found;
052699201027           pnicusa = 'T';
052700201027          endif;
052701201027
052702200224          seq# = dpseq#;
052703200224          ssn = mcssno;
052704200224          termdt = ccandt;
052705200224          exsr checkTerm;
052706200224          if alreadySent = 'N';
052707200224
052708210217           if cpcid2 > ' ' and pclassid = ' ';
052709210217            pclassid = cpcid2;
052710210217           endif;
052711210217
052712200224           if ccandt > 0;
052713200224            cancelh = ccandt;
052714200810             exsr get_planDate;
052715200224            pcovtrmdt4 = %char(cancelh);
052716200224           endif;
052717200224
052718200224           if writeRecord = 'Y';
052719200224            write priFile;
052720200224           endif;
052721200224           if updateRecord = 'Y';
052722200224            update priFile;
052723200224           endif;
052724200224
052725200224          endif;
052726200224         endif;
052727200224         endif;
052728200810         endif;
052729200224
052730200810         if foundPlan = 'Y';
052731200224         if plncat = 'POA';
052732200224         if pcovid5 <> ptype;
052733200224          pcovid5 = 'EVA';
052734200224          pcovefdt5 = %char(enrldt);
052735200810          pplanid5 = cpcid1;
052740200224          seq# = dpseq#;
052741200224          ssn = mcssno;
052742200224          termdt = ccandt;
052743200224          exsr checkTerm;
052744200224          if alreadySent = 'N';
052745200224
052746210217           if cpcid2 > ' ' and pclassid = ' ';
052747210217            pclassid = cpcid2;
052748210217           endif;
052749210217
052750200224           if ccandt > 0;
052751200224            cancelh = ccandt;
052752200810             exsr get_planDate;
052753200224            pcovtrmdt5 = %char(cancelh);
052754200224           endif;
052755200224
052756200224           if writeRecord = 'Y';
052757200224            write priFile;
052758200224           endif;
052759200224           if updateRecord = 'Y';
052760200224            update priFile;
052761200224           endif;
052762200224
052763200224          endif;
052764200224         endif;
052765200224         endif;
052766200810         endif;
052767200224
052768201228         //if foundPlan = 'Y';
052769201228         //if plncat = 'PSP';
052770201228         //if pcovid6 <> ptype;
052771201228         // pcovid6 = 'SVL';
052772201228         // pcovefdt6 = %char(denrdt);
052773201228         // pbenamtel6 = %editc(benamt:'X');
052774201228         // pbenamtap6 = %editc(benamt:'X');
052775201228         // pplanid6 = cpcid1;
052776201027
052777201228         // pnicusa = 'N';
052778201228         // chain (mcssno : dpseq#)  smoker;
052779201228         // if %found;
052780201228         //  pnicusa = 'T';
052781201228         // endif;
052782201027
052783201228         // seq# = dpseq#;
052784201228         // ssn = mcssno;
052785201228         // termdt = ccandt;
052786201228         // exsr checkTerm;
052787201228         // if alreadySent = 'N';
052788200224
052789201228         //  if ccandt > 0;
052790201228         //   cancelh = ccandt;
052791201228         //    exsr get_planDate;
052792201228         //   pcovtrmdt6 = %char(cancelh);
052793201228         //  endif;
052794200224
052795201228         //  if writeRecord = 'Y';
052796201228         //   write priFile;
052797201228         //  endif;
052798201228         //  if updateRecord = 'Y';
052799201228         //   update priFile;
052800201228         //  endif;
052801200224
052802201228         // endif;
052803201228         //endif;
052804201228         //endif;
052805201228         //endif;
052806200224
052807200424         //if plncat = 'PSA';
052808200424         //if pcovid7 <> ptype;
052809200424         // pcovid7 = 'SVA';
052810200424         // pplanid7 = '1';
052811200424         // pcovefdt7 = %char(denrdt);
052812200224
052813200424         // seq# = dpseq#;
052814200424         // ssn = mcssno;
052815200424         // termdt = ccandt;
052816200424         // exsr checkTerm;
052817200424         // if alreadySent = 'N';
052818200224
052819200424         //  if ccandt > 0;
052820200424         //   cancelh = ccandt;
052821200810         //    exsr get_planDate;
052822200424         //   pcovtrmdt7 = %char(cancelh);
052823200424         //  endif;
052824200224
052825200424         //  if writeRecord = 'Y';
052826200424         //   write priFile;
052827200424         //  endif;
052828200424         //  if updateRecord = 'Y';
052829200424         //   update priFile;
052830200424         //  endif;
052831200224
052832200424         // endif;
052833200424         //endif;
052834200424         //endif;
052835200224
052836201228         //if plncat = 'PVD' or plncat = 'PSD';
052837201228         //if pcovid8 <> ptype;
052838200424         // pcovid8 = 'CVL';
052839200424         // pcovefdt8 = %char(denrdt);
052840200424         // pbenamtel8 = %editc(benamt:'X');
052841200424         // pbenamtap8 = %editc(benamt:'X');
052842200424         // pplanid8 = '1';
052843200224
052844201228         // seq# = dpseq#;
052845201228         // ssn = mcssno;
052846201228         // termdt = ccandt;
052847201228         // exsr checkTerm;
052848201228         // if alreadySent = 'N';
052849200224
052850200424         //  if candt > 0;
052851200424         //   cancelh = ccandt;
052852200810         //    exsr get_planDate;
052853200424         //   pcovtrmdt8 = %char(cancelh);
052854200424         //  endif;
052855200224
052856201228          // if writeRecord = 'Y';
052857201228          //  write priFile;
052858201228          // endif;
052859201228          // if updateRecord = 'Y';
052860201228          //  update priFile;
052861201228          // endif;
052862200224
052863201228         //endif;
052864201228         //endif;
052865201228         //endif;
052866200224
052867200810         if foundPlan = 'Y';
052868200224         if plncat = 'PWD';
052869200224         if pcovid9 <> ptype;
052870200224          pcovid9 = 'STD';
052871200224          pcovefdt9 = %char(enrldt);
052872200424          pbenamtel9 = %editc(benamt:'X');
052873200424          pbenamtap9 = %editc(benamt:'X');
052874200810          pplanid9 = cpcid1;
052878200224
052879200224          ssn = mcssno;
052880200224          termdt = candt;
052881200224          exsr checkTerm;
052882200224          if alreadySent = 'N';
052883200224
052884210217           if cpcid2 > ' ' and pclassid = ' ';
052885210217            pclassid = cpcid2;
052886210217           endif;
052887210217
052888200224           if candt > 0;
052889200224            cancelh = candt;
052890200810             exsr get_planDate;
052891200224            pcovtrmdt9 = %char(cancelh);
052892200224           endif;
052893200224
052894200224           if writeRecord = 'Y';
052895200224            write priFile;
052896200224           endif;
052897200224           if updateRecord = 'Y';
052898200224            update priFile;
052899200224           endif;
052900200224
052901200224          endif;
052902200224         endif;
052903200224         endif;
052904200810         endif;
052905200224
052906200224         if plncat = 'PLT';
052907200810         if foundPlan = 'Y';
052908200224         if pcovid10 <> ptype;
052909200224          pcovid10 = 'LTD';
052910210216          pplanid10 = cpcid1;
052915200224          pcovefdt10 = %char(denrdt);
052916200424          pbenamte10 = %editc(benamt:'X');
052917200424          pbenamta10 = %editc(benamt:'X');
052918200224
052919200224          seq# = dpseq#;
052920200224          ssn = mcssno;
052921200224          termdt = ccandt;
052922200224          exsr checkTerm;
052923200224          if alreadySent = 'N';
052924200224
052925210217           if cpcid2 > ' ' and pclassid = ' ';
052926210217            pclassid = cpcid2;
052927210217           endif;
052928210217
052929200224           if ccandt > 0;
052930200224            cancelh = ccandt;
052931200810             exsr get_planDate;
052932200224            pcovtrmd10 = %char(cancelh);
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
052948200224         if plncat = 'PDN';
052949200224         if pcovid11 <> ptype;
052950200224          pcovid11 = 'DEN';
052951200224          pcovefdt11 = %char(denrdt);
052952200224
052953200810          pplanid11 = cpcid1;
052957200224
052958200224          seq# = dpseq#;
052959200224          ssn = mcssno;
052960200224          termdt = ccandt;
052961200224          exsr checkTerm;
052962200224          if alreadySent = 'N';
052963200224
052964210217           if cpcid2 > ' ' and pclassID = ' ';
052965210217            pclassid = cpcid2;
052966210217           endif;
052967210217
052968200224           if ccandt > 0;
052969200224            cancelh = ccandt;
052970200810             exsr get_planDate;
052971200224            pcovtrmd11 = %char(cancelh);
052972200224           endif;
052973200224
052974200224           if writeRecord = 'Y';
052975200224            write priFile;
052976200224           endif;
052977200224           if updateRecord = 'Y';
052978200224            update priFile;
052979200224           endif;
052980200224
052981200224          endif;
052982200224         endif;
052983200224         endif;
052984200810         endif;
052985200224
052986200224         if plncat = 'PVS';
052987200810         if foundPlan = 'Y';
052988200224         if pcovid12 <> ptype;
052989200224          pcovid12 = 'VIS';
052990200810          pplanid12 = cpcid1;
052994200424
052995200224          pcovefdt12 = %char(denrdt);
052996200224
052997200224          seq# = dpseq#;
052998200224          ssn = mcssno;
052999200224          termdt = ccandt;
053000200224          exsr checkTerm;
053001200224          if alreadySent = 'N';
053002200224
053003210217           if cpcid2 > ' ' and pclassID = ' ';
053004210217            pclassid = cpcid2;
053005210217           endif;
053006210217
053007200224           if ccandt > 0;
053008200224            cancelh = ccandt;
053009200810             exsr get_planDate;
053010200224            pcovtrmd12 = %char(cancelh);
053011200224           endif;
053012200224
053013200224           if writeRecord = 'Y';
053014200224            write priFile;
053015200224           endif;
053016200224           if updateRecord = 'Y';
053017200224            update priFile;
053018200224           endif;
053019200224
053020200224          endif;
053021200224         endif;
053022200224         endif;
053023200810         endif;
053024200224
053025200810         if foundPlan = 'Y';
053026200224         if plncat = 'PCC';
053027200224         if pcovid13 <> ptype;
053028200224          pcovid13 = 'ECI';
053029210216          pplanid13 = cpcid1;
053033200224          pcovefdt13 = %char(denrdt);
053034200424          pbenamte13 = %editc(benamt:'X');
053035200424          pbenamta13 = %editc(benamt:'X');
053036200224
053037200224          seq# = dpseq#;
053038200224          ssn = mcssno;
053039200224          termdt = ccandt;
053040200224          exsr checkTerm;
053041200224          if alreadySent = 'N';
053042200224
053043210217           if cpcid2 > ' 'and pclassid = ' ';
053044210217            pclassid = cpcid2;
053045210217           endif;
053046210217
053047200224           if ccandt > 0;
053048200224            cancelh = ccandt;
053049200810             exsr get_planDate;
053050200224            pcovtrmd13 = %char(cancelh);
053051200224           endif;
053052200224
053053200224           if writeRecord = 'Y';
053054200224            write priFile;
053055200224           endif;
053056200224           if updateRecord = 'Y';
053057200224            update priFile;
053058200224           endif;
053059200224
053060200224          endif;
053061200224         endif;
053062200224         endif;
053063200810         endif;
053064200224
053065200810         if foundPlan = 'Y';
053066200224         if plncat = 'PCB';
053067200224         if pcovid14 <> ptype;
053068200224          pcovid14 = 'SCI';
053069210216          pplanid14 = cpcid1;
053073200224          pcovefdt14 = %char(denrdt);
053074200424          pbenamte14 = %editc(benamt:'X');
053075200424          pbenamta14 = %editc(benamt:'X');
053076200224
053077200224          seq# = dpseq#;
053078200224          ssn = mcssno;
053079200224          termdt = ccandt;
053080200224          exsr checkTerm;
053081200224          if alreadySent = 'N';
053082200224
053083210217           if cpcid2 > ' ' and pclassid = ' ';
053084210217            pclassid = cpcid2;
053085210217           endif;
053086210217
053087200224           if ccandt > 0;
053088200224            cancelh = ccandt;
053089200810             exsr get_planDate;
053090200224            pcovtrmd14 = %char(cancelh);
053091200224           endif;
053092200224
053093200224           if writeRecord = 'Y';
053094200224            write priFile;
053095200224           endif;
053096200224           if updateRecord = 'Y';
053097200224            update priFile;
053098200224           endif;
053099200224
053100200224          endif;
053101200224         endif;
053102200224         endif;
053103200810         endif;
053104200224
053105200810         if foundPlan = 'Y';
053106200224         if plncat = 'PCG';
053107200224         if pcovid15 <> ptype;
053108200224          pcovid15 = 'CCI';
053113200224          pcovefdt15 = %char(denrdt);
053114200424          pbenamte15 = %editc(benamt:'X');
053115200424          pbenamta15 = %editc(benamt:'X');
053116200224
053117200224          seq# = dpseq#;
053118200224          ssn = mcssno;
053119200224          termdt = ccandt;
053120200224          exsr checkTerm;
053121200224          if alreadySent = 'N';
053122200224
053123210217           if cpcid2 > ' ' and pclassid = ' ';
053124210217            pplanid15 = cpcid1;
053125210217           endif;
053126210217
053127200224           if ccandt > 0;
053128200224            cancelh = ccandt;
053129200810             exsr get_planDate;
053130200224            pcovtrmd15 = %char(cancelh);
053131200224           endif;
053132200224
053133200224           if writeRecord = 'Y';
053134200224            write priFile;
053135200224           endif;
053136200224           if updateRecord = 'Y';
053137200224            update priFile;
053138200224           endif;
053139200224
053140200224          endif;
053141200224         endif;
053142200224         endif;
053143200810         endif;
053144200224
053145200810         if foundPlan = 'Y';
053146200224         if plncat = 'PO6';
053147200224         if pcovid16 <> ptype;
053148200224          pcovid16 = 'ACC';
053149210216          pplanid16 = cpcid1;
053153200224          pcovefdt16 = %char(denrdt);
053154200224
053155200224          seq# = dpseq#;
053156200224          ssn = mcssno;
053157200224          termdt = ccandt;
053158200224          exsr checkTerm;
053159200224          if alreadySent = 'N';
053160200224
053161210217           if cpcid2 > ' ' and pclassid = ' ';
053162210217            pclassid = cpcid2 ;
053163210217           endif;
053164210217
053165200224           if ccandt > 0;
053166200224            cancelh = ccandt;
053167200810             exsr get_planDate;
053168200224            pcovtrmd16 = %char(cancelh);
053169200224           endif;
053170200224
053171200224           if writeRecord = 'Y';
053172200224            write priFile;
053173200224           endif;
053174200224           if updateRecord = 'Y';
053175200224            update priFile;
053176200224           endif;
053177200224
053178200224          endif;
053179200224         endif;
053180200224         endif;
053181200810         endif;
053182200224
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
069102200224        if pos > 0;
069104201116         pos = pos - 1;
069106200224         pacct# = %subst(group#:1:pos);
069108200224        else;
069109200224         pacct# = group#;
069111200224        endif;
069112200224
069132201116
069133200224        if p_acct > ' ';
069134200224         if pacct# <> p_acct;
069135200224          pacct# = ' ';
069136200224         endif;
069137200224        endif;
069138200224
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
070102220223          when plncat = 'PLF' or plncat = 'PLL';
070103200224           ptype = 'BLF';
070104200224
070105220223          when plncat = 'PAC' or plncat = 'PA1';
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
070132201027          when plncat = 'PVL';
070133201027           ptype = 'LTD';
070134201027
070135200224          when plncat = 'PDN';
070136200224           ptype = 'DEN';
070137200224
070138200224          when plncat = 'PVS';
070139200224           ptype = 'VIS';
070140200224
070141200224          when plncat = 'PCC';
070142200224           ptype = 'ECI';
070143200224
070144200224          when plncat = 'PCB';
070145200224           ptype = 'SCI';
070146200224
070147200224          when plncat = 'PCG';
070148200224           ptype = 'CCI';
070149200224
070150200224          when plncat = 'PO6';
070151200224           ptype = 'ACC';
070152200224
070153200424          when plncat = 'PWD';
070154200424           ptype = 'STD';
070155201027
070156201027          when plncat = 'PVW';
070157201027           ptype = 'STD';
070158201027
070159200224         endsl;
071700190226
071800190226       endsr;
071900190226
071901200810      //===================================================================
071902200810      // Determine Type
071903200810      //===================================================================
071904200810
071905201119       begsr getPlan;
071906200810
071907200810        foundPlan = 'N';
071908200810
071909210217        chain (unique : pltrst : plsub# : acc# : plplan) planSetup;
071910200810        if %found;
071911200810         foundPlan = 'Y';
071912200810        endif;
071913200810
071916200810       endsr;
071917200810
071918200228      //===================================================================
071919200228      // coverage tier
071920200228      //===================================================================
071921200228
071922200228       begsr coverageTier;
071923200228
071924200228       tier = ' ';
071925200228
071926200228       select;
071927200228        when mcovtp = 'TIN';
071928200228         tier = '1';
071929200228
071930200228        when mcovtp = 'TFA';
071931200228         tier = '2';
071932200228
071933200228        when mcovtp = 'THW';
071934200228         tier = '3';
071935200228
071936200228        when mcovtp = 'TPC' or mcovtp = 'TP2';
071937200228         tier = '4';
071938200228
071939200228        when mcovtp = 'TU1' or mcovtp = 'TU2' or mcovtp = 'TU3';
071940200228         tier = '5';
071941200228       endsl;
071942200228
071943200228       endsr;
071944200228
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
073301210519
073302210519        if dhndcp = '1' or dhndcp = '2' or dhndcp = '3';
073303210519         prel = 'H';
073304210519        endif;
073400181030
073500180313       endsr;
073600180424
073601200228      //===================================================================
073602200228      // check for transmission
073603200228      //===================================================================
073604200228
073605200228       begsr checkTransmission;
073606200228
073608200915        ok_toTransmit = 'N';
073609200909
073610200915        chain (unique : pltrst : plsub# : acc#) transFile;
073611200228        if %found;
073612200915         if castatus = inType;
073613200915          ok_toTransmit = 'Y';
073614200915          p_acct = %subst(cacid2:1:7);
073615200915         endif;
073616200915        endif;
073617210205
073618210205        if not %found;
073619210205         ok_toTransmit = 'N';
073620210205        endif;
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
077000200911        carrier = 19;
077100200810        unique = '0000000329';
077200181031
077300160519        today = %dec(%char(%date:*iso0):8:0);
077400181105
077500160511       endsr;
077600010412
077700160511       //==============================================================
