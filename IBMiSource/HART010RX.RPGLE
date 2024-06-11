000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200629      * HART010R - Hartford Generate extract (test)
000500200629      *===========================================================================
000600180313      * Date        Int   Description
000700200629      * ----------  ---   --------------------------------------------------------
000800200618      * 06/18/2020  jt    Original creation
000801200819      * 08/19/2020  jt    Re-compiled for database change
000802201124      * 11/24/2020  jt    Added P32 plan category
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
004300200409     fhartdtl   uf a e           k disk    rename(hartr:hartFile)
004400160513
004500200618     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
004600190228
004700200618     fcarplnz   if   e           k disk    rename(carplnr:planFile)
004800190228
004900200228     fharttrm   uf a e           k disk    rename(harttr:termFile)
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
005806190308     d carrierCode6    s              3
005807190308     d carrierCode7    s              3
005900181101     d grouperCode     s              2
006000180913     d cancelDate      s               d
006100180913     d cancelh         s              8  0
006200160519     d today           s              8  0
006300190227     d alreadySent     s              1
006400200228     d alreadySentLIF  s              1
006500190227     d alreadySentV    s              1
006600190227     d alreadySentD    s              1
006700180523     d ssn             s              9  0
006800180523     d seq#            s              2  0
006900190226     d catType         s              3
007000190227     d updateRecord    s              1
007100190227     d writeRecord     s              1
007200180523     d termdt          s              8  0
007201190401     d ok_toTransmit   s              1
007202200618     d unique          s             10
007300200228     d tier            s              1
007400181113     d carrier         s              2  0
007600181105     d candtp          s              8
007700181105     d lastdate        s              8
007800181105     d error           s             20
008001200228     d pos             s              2  0
008002200228     d pos2            s              2  0
008100150820
008200181105     d lastday         pr                  extpgm('LSTDAY')
008300181105     d  candtp                        8
008400181105     d  lastdate                      8    const
008500181105     d  error                        20    const
008600181105
008601200618     d hart010rx       pi
008602200618     d  intype                        1
008603200618
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
011101200629        exsr clearSSN;
011102200629
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
017100200228        %char(birth):mlname:mfname:mmi) hartFile;
017200190227
017300190227        if %found;
017400190227         updateRecord = 'Y';
017500190227        else;
017600190227         writeRecord = 'Y';
017700190227        endif;
017800190227
017900190227        if writeRecord = 'Y';
018000200228         clear hartFile;
018001200401         exsr writeSections;
018100190227        endif;
018200181102
018300200228         psection = '~PII~';
018301200228
018302200228         exsr getGroup;
018400200228         pgroup# = group#;
018404200228         if pgroup# = ' ';
018405200228          leavesr;
018406200228         endif;
018407200228
018408200228         ptcode = 'E';
018409200228         pempssn = %editc(mcssno:'X');
018410200228         pempid = %editc(mcssno:'X');
018411200228         pmssn = %editc(mcssno:'X');
018412200228         prcode = ' ';
018413200228
018414200228         plast = mlname;
018415200228         pfirst = mfname;
018416200228         pmi = mmi;
018417200228         pprefix = ' ';
018418200228         psuffix = ' ';
018419200228         pdob = %char(birth);
018420200228         pmaritalst = 'U';
018421200228         pgender = sex;
018422200228
018423200228         psmoker = 'N';
018424200228         chain mcssno smoker;
018425200228         if %found;
018426200228          psmoker = 'Y';
018427200228         endif;
018428200228
018429200228         //pseccode1 = '~BNK~';
018430200228         //pbankaba = ' ';
018431200228         //pbankact = ' ';
018432200228         //pbankactt = ' ';
018433200228
018434200228         pseccode2 = '~ECI~';
018435200228         padd1 = addr1;
018436200228         padd2 = addr2;
018437200228         pcity = city;
018438200228         pstate = state;
018439200228         pzip = %editc(zip:'X');
018440200228         pcountrycd = '840';
018441200228         pprovcd = ' ';
018442200228         pprovad = ' ';
018443200228         phphone = %editc(area:'X') + %editc(phone:'X');
018444200228         pcphone = ' ';
018445200228         pemail = fill66;
018446200228         pwemail = ' ';
018447200228         peworkst = ' ';
018449200228         pwadd1 = ' ';
018450200228         pwadd2 = ' ';
018454200228         pwcity = ' ';
018456200228         pwstate = ' ';
018458200228         pwzip = ' ';
018460200228         pwcountryc = ' ';
018462200228         pwphone = ' ';
018465200228
018468200228         pseccode4 = '~EMI~';
018469200228         pempst = ' ';
018470200228         select;
018471200228          when empst = 'A';
018472200228           pempst = 'A';
018473200228          when empst <> 'A';
018474200228           pempst = 'I';
018475200228         endsl;
018476200228
018493200228         if empdt > 0;
018494200228          pempeffdt = %char(empdt);
018495200228           pemprhdt = %char(empdt);
018496200228          pempohdt =  %char(empdt);
018498200228         endif;
018499200228         pempsrvdt = ' ';
018500200228
018501200228
018900200228         chain (pltrst : plsub# : acc#) actFile2;
019000190226         if %found;
019100200228          //dtaxid# = %char(a2tax_id#);
019200190226         endif;
019300190226
019301200409      // if plncat = 'PLT';
019302200409      //  pseccod11 = '~LTD~';
019303200409      //  pltdstdt = %char(enrldt);
019304200409      //  termdt = candt;
019305200409      //  exsr checkTerm;
019306200409      //  if alreadySent = 'N';
019307200409
019308200409      //   if candt > 0;
019309200409      //    cancelh = candt;
019310200409      //     exsr sub1_fromDate;
019311200409      //    pltdendt = %char(cancelh);
019312200409      //   endif;
019313200228
019316200409      //   if writeRecord = 'Y';
019317200409      //    write hartFile;
019318200409      //   endif;
019319200409      //   if updateRecord = 'Y';
019320200409      //    update hartFile;
019321200409      //   endif;
019322200409      //  endif;
019323200409      //
019324200409      // endif;
019325200409      //
020700200409      // if plncat = 'PLF';
020800200409      //  pseccod16 = '~LIF~';
020801200409      //  plifstdt = %char(enrldt);
020900200409      //  termdt = candt;
021000200409      //  exsr checkTerm;
021200200409      //  if alreadySent = 'N';
021300190227
022000200409      //   if candt > 0;
022100200409      //    cancelh = candt;
022200200409      //     exsr sub1_fromDate;
022300200409      //    plifendt = %char(cancelh);
022400200409      //   endif;
022403200409
022500200409      //   if writeRecord = 'Y';
022501200409      //    write hartFile;
022502200409      //   endif;
022503200409      //   if updateRecord = 'Y';
022504200409      //    update hartFile;
022505200409      //   endif;
023300200409      //  endif;
023400190227
023500200409      // endif;
023600200409
023601201124         if plncat = 'PCC' or plncat = 'P32';
023602200819          pseccod28 = '~VCI~';
023603200819          pvcistdt = %char(enrldt);
023604200819          ssn = mcssno;
023605200819          termdt = candt;
023606200819          seq# = 0;
023607200819          exsr checkTerm;
023608200819          if alreadySent = 'N';
023609200819
023610200819           if candt > 0;
023611200819            cancelh = candt;
023612200819             exsr sub1_fromDate;
023613200819            pvciendt = %char(cancelh);
023614200819           endif;
023615200819
023622200819           exsr coverageTier;
023623200819           pvcicotr = tier;
023624200819
023625200819           chain (unique : pltrst : plsub# : acc# : plplan) planFile;
023626200819           if %found;
023627200819            pvcigrpid = cpcid3;
023628200819             pvcipln# = cpcid4;
023629200819             pvciclcd = cpcid5;
023630200819            pvcibamt = cpcid6;
023631200819           endif;
023632200819
023633200819           if writeRecord = 'Y';
023634200819            write hartFile;
023635200819           endif;
023636200819           if updateRecord = 'Y';
023637200819            update hartFile;
023638200819           endif;
023639200819          endif;
023640200819
023641200819         endif;
023642200819
023643200228         if plncat = 'PO6';
023644200228          pseccod30 = '~VAC~';
023645200228          pvacstdt = %char(enrldt);
023646200616          ssn = mcssno;
023647200228          termdt = candt;
023648200616          seq# = 0;
023649200228          exsr checkTerm;
023650200228          if alreadySent = 'N';
023651200228
023652200228           if candt > 0;
023653200228            cancelh = candt;
023654200228             exsr sub1_fromDate;
023655200228            pvacendt = %char(cancelh);
023656200228           endif;
023657200228
023658200228           exsr coverageTier;
023659200228           pvaccotr = tier;
023660200618           chain (unique : pltrst : plsub# : acc# : plplan) planFile;
023661200618           if %found;
023662200618            pvacplnopt = cpcid2;
023663200626             pvacgrpid = cpcid3;
023664200626             pvacpln# = cpcid4;
023665200819            pvacclcd = cpcid5;
023666200618           endif;
023667200228
023668200228           if writeRecord = 'Y';
023669200228            write hartFile;
023670200228           endif;
023671200228           if updateRecord = 'Y';
023672200228            update hartFile;
023673200228           endif;
023674200228          endif;
023675200228
023676200228         endif;
023677200228
023678200228         if plncat = 'PHI';
023679200228          pseccod31 = '~HIP~';
023680200228          phipstdt = %char(enrldt);
023681200616          ssn = mcssno;
023682200228          termdt = candt;
023683200616          seq# = 0;
023684200228          exsr checkTerm;
023685200228          if alreadySent = 'N';
023686200228
023687200228           if candt > 0;
023688200228            cancelh = candt;
023689200228             exsr sub1_fromDate;
023690200228            phipendt = %char(cancelh);
023691200228           endif;
023692200228
023693200228           exsr coverageTier;
023694200228           phipcotr = tier;
023695200618           chain (unique : pltrst : plsub# : acc# : plplan) planFile;
023696200618           if %found;
023697200618            phipplnopt = cpcid2;
023698200626             phipgrpid = cpcid3;
023699200626             phippln# = cpcid4;
023700200626            phipclcd = cpcid5;
023701200618           endif;
023702200228
023703200228           if writeRecord = 'Y';
023704200228            write hartFile;
023705200228           endif;
023706200228           if updateRecord = 'Y';
023707200228            update hartFile;
023708200228           endif;
023709200228          endif;
023710200228
023711200228         endif;
026600190226
026601200409      // if plncat = 'PLT';
026602200409      //  pseccod11 = '~LTD~';
026603200409      //  pltdstdt = %char(enrldt);
026604200409      //  termdt = candt;
026605200409      //  exsr checkTerm;
026606200409      //  if alreadySent = 'N';
026607200409
026608200409      //   if candt > 0;
026609200409      //    cancelh = candt;
026610200409      //     exsr sub1_fromDate;
026611200409      //    pltdendt = %char(cancelh);
026612200409      //   endif;
026613200228
026614200409      //   exsr coverageTier;
026615200409
026616200409      //   if writeRecord = 'Y';
026617200409      //    write hartFile;
026618200409      //   endif;
026619200409      //   if updateRecord = 'Y';
026620200409      //    update hartFile;
026621200409      //   endif;
026622200409      //  endif;
026623200228
026624200409      // endif;
026625200409
033300190227         if mcovtp <> 'TIN';
033400190227          exsr dependent;
033500190227         endif;
033600180523
033700160516       endsr;
033800060817
039800180913      //===================================================================
039900180913      // sub 1 from cancel date
040000180913      //===================================================================
040100180913
040200180913       begsr sub1_fromDate;
040300180913
040400181105        candtp = %char(cancelh);
040500181105        lastday(candtp : lastdate : error);
040600181105        cancelh = %dec(lastdate:8:0);
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
044200190227        chain (pltrst:plsub#:acc#:ssn:seq#:catType:plplan:termdt) termFile;
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
045400190227             ttype = catType;
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
049700200409         exsr writeDependent;
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
050800200409       begsr writeDependent;
050900180313
051000190227        updateRecord = 'N';
051100190227        writeRecord = 'N';
051200190227
051300181102        chain
051400190227        (%char(%editc(mcssno:'X')):%editc(depss#:'X'):
051500200228        %char(dbirth):dlname:dfname:dmi) hartFile;
051600190227        if %found;
051700190227         updateRecord = 'Y';
051800190227        else;
051900190227         writeRecord = 'Y';
052000190227        endif;
052100181102
052200190227        if writeRecord = 'Y';
052300200228         clear hartFile;
052301200401         exsr writeSections;
052400190227        endif;
054900190226
054901200228         psection = '~PII~';
054902200228
054903200228         exsr getGroup;
054904200228         pgroup# = group#;
054908200228         if pgroup# = ' ';
054909200228          leavesr;
054910200228         endif;
054911200228
054912200228         ptcode = 'D';
054913200228
054914200228         pempssn = %editc(mcssno:'X');
054915200228         pempid = %editc(mcssno:'X');
054916200228         pmssn = %editc(depss#:'X');
054917200424
054918200424         exsr relCodes;
054919200228
054920200228         plast = dlname;
054921200228         pfirst = dfname;
054922200228         pmi = dmi;
054923200228         pprefix = ' ';
054924200228         psuffix = ' ';
054925200228         pdob = %char(dbirth);
054926200228         pmaritalst = 'U';
054927200228         pgender = dsex;
054928200228
054929200228         psmoker = 'N';
054930200228         chain (mcssno : dpseq#) smoker;
054931200228         if %found;
054932200228          psmoker = 'Y';
054933200228         endif;
054934200228
054937200228         pseccode2 = '~ECI~';
054938200228         padd1 = daddr1;
054939200228         padd2 = daddr2;
054940200228         pcity = dcity;
054941200228         pstate = dstate;
054942200228         pzip = %editc(dzip:'X');
054943200228         pcountrycd = '840';
054944200228         pprovcd = ' ';
054945200228         pprovad = ' ';
054946200228         phphone = %editc(area:'X') + %editc(phone:'X');
054947200228         pcphone = ' ';
054948200228         pemail = fill66;
054949200228         pwemail = ' ';
054950200228         peworkst = ' ';
054951200228         pwadd1 = ' ';
054952200228         pwadd2 = ' ';
054953200228         pwcity = ' ';
054954200228         pwstate = ' ';
054955200228         pwzip = ' ';
054956200228         pwcountryc = ' ';
054957200228         pwphone = ' ';
054958200228
054961200228         pseccode4 = '~EMI~';
054962200228         pempst = ' ';
054963200228         //select;
054964200228         // when empst = 'A';
054965200228         //  pempst = 'A';
054966200228         // when empst <> 'A';
054967200228         //  pempst = 'I';
054968200228         //endsl;
054969200228
054970200228         //if empdt > 0;
054971200228         // pempeffdt = %char(empdt);
054972200228         //endif;
054973200228         pempsrvdt = ' ';
054974200228
054975200228
054976200228         chain (pltrst : plsub# : acc#) actFile2;
054977200228         if %found;
054978200228          //dtaxid# = %char(a2tax_id#);
054979200228         endif;
054980200228
054981200409      // if plncat = 'PLT';
054982200409      //  pseccod11 = '~LTD~';
054983200409      //  pltdstdt = %char(denrdt);
054984200409      //  termdt = ccandt;
054985200409      //  exsr checkTerm;
054986200409      //  if alreadySent = 'N';
054987200409      //
054988200409      //   if ccandt > 0;
054989200409      //    cancelh = ccandt;
054990200409      //     exsr sub1_fromDate;
054991200409      //    pltdendt = %char(cancelh);
054992200409      //   endif;
054993200228
054994200409      //   if writeRecord = 'Y';
054995200409      //    write hartFile;
054996200409      //   endif;
054997200409      //   if updateRecord = 'Y';
054998200409      //    update hartFile;
054999200409      //   endif;
055000200409      //  endif;
055001200228
055002200409      // endif;
055003200228
055004200409      // if plncat = 'PLF';
055005200409      //  pseccod16 = '~LIF~';
055006200409      //  plifstdt = %char(denrdt);
055007200409      //  termdt = ccandt;
055008200409      //  exsr checkTerm;
055009200409      //  if alreadySent = 'N';
055010200228
055011200409      //   if ccandt > 0;
055012200409      //    cancelh = ccandt;
055013200409      //     exsr sub1_fromDate;
055014200409      //    plifendt = %char(cancelh);
055015200409      //   endif;
055016200228
055017200409      //   if writeRecord = 'Y';
055018200409      //    write hartFile;
055019200409      //   endif;
055020200409      //   if updateRecord = 'Y';
055021200409      //    update hartFile;
055022200409      //   endif;
055023200409      //  endif;
055024200228
055025200409      // endif;
055026200228
055027201124         if plncat = 'PCC' or plncat = 'P32';
055028200819          pseccod28 = '~VCI~';
055029200819          pvcistdt = %char(denrdt);
055030200819          ssn = mcssno;
055031200819          termdt = ccandt;
055032200819          seq# = dpseq#;
055033200819          exsr checkTerm;
055034200819          if alreadySent = 'N';
055035200819
055036200819           if ccandt > 0;
055037200819            cancelh = ccandt;
055038200819             exsr sub1_fromDate;
055039200819            pvciendt = %char(cancelh);
055040200819           endif;
055041200819
055049200819           exsr coverageTier;
055050200819           pvcicotr = tier;
055051200819
055052200819           chain (unique : pltrst : plsub# : acc# : plplan) planFile;
055053200819           if %found;
055054200819            pvcigrpid = cpcid3;
055055200819             pvcipln# = cpcid4;
055056200819             pvciclcd = cpcid5;
055057200819            pvcibamt = cpcid6;
055058200819           endif;
055059200819
055060200819           if writeRecord = 'Y';
055061200819            write hartFile;
055062200819           endif;
055063200819           if updateRecord = 'Y';
055064200819            update hartFile;
055065200819           endif;
055066200819          endif;
055067200819
055068200819         endif;
055069200819
055070200409         if plncat = 'PO6';
055071200409          pseccod30 = '~VAC~';
055072200228          pvacstdt = %char(denrdt);
055073200228          termdt = ccandt;
055074200616          ssn = mcssno;
055075200616          seq# = dpseq#;
055076200228          exsr checkTerm;
055077200228          if alreadySent = 'N';
055078200228
055079200228           if ccandt > 0;
055080200228            cancelh = ccandt;
055081200228             exsr sub1_fromDate;
055082200228            pvacendt = %char(cancelh);
055083200228           endif;
055084200228
055085200228           exsr coverageTier;
055086200228           pvaccotr = tier;
055087200618           chain (unique : pltrst : plsub# : acc# : plplan) planFile;
055088200618           if %found;
055089200618            pvacplnopt = cpcid2;
055090200626             pvacgrpid = cpcid3;
055091200626             pvacpln# = cpcid4;
055092200626            pvacclcd = cpcid5;
055093200618           endif;
055094200228
055095200228           if writeRecord = 'Y';
055096200228            write hartFile;
055097200228           endif;
055098200228           if updateRecord = 'Y';
055099200228            update hartFile;
055100200228           endif;
055101200228          endif;
055102200228
055103200228         endif;
055104200228
055105200228         if plncat = 'PHI';
055106200228          pseccod31 = '~HIP~';
055107200228          phipstdt = %char(denrdt);
055108200228          termdt = ccandt;
055109200616          ssn = mcssno;
055110200616          seq# = dpseq#;
055111200228          exsr checkTerm;
055112200228          if alreadySent = 'N';
055113200228
055114200228           if ccandt > 0;
055115200228            cancelh = ccandt;
055116200228             exsr sub1_fromDate;
055117200228            phipendt = %char(cancelh);
055118200228           endif;
055119200228
055120200228           exsr coverageTier;
055121200228           phipcotr = tier;
055122200618           chain (unique : pltrst : plsub# : acc# : plplan) planFile;
055123200618           if %found;
055124200618            phipplnopt = cpcid2;
055125200626             phipgrpid = cpcid3;
055126200626             phippln# = cpcid4;
055127200626            phipclcd = cpcid5;
055128200618           endif;
055129200228
055130200228           if writeRecord = 'Y';
055131200228            write hartFile;
055132200228           endif;
055133200228           if updateRecord = 'Y';
055134200228            update hartFile;
055135200228           endif;
055136200228          endif;
055137200228
055138200228         endif;
055139200228
055140200409      // if plncat = 'PLT';
055141200409      //  pseccod11 = '~LTD~';
055142200409      //  pltdstdt = %char(denrdt);
055143200409      //  termdt = ccandt;
055144200409      //  exsr checkTerm;
055145200409      //  if alreadySent = 'N';
055146200409
055147200409      //   if ccandt > 0;
055148200409      //    cancelh = ccandt;
055149200409      //     exsr sub1_fromDate;
055150200409      //    pltdendt = %char(cancelh);
055151200409      //   endif;
055152200228
055153200409      //   exsr coverageTier;
055154200228
055155200409      //   if writeRecord = 'Y';
055156200409      //    write hartFile;
055157200409      //   endif;
055158200409      //   if updateRecord = 'Y';
055159200409      //    update hartFile;
055160200409      //   endif;
055161200409      //  endif;
055162200228
055163200409      // endif;
066700181102
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
069001200616
069002200618        //if %subst(group#:1:6) <> '460325';
069004200616        //if %subst(group#:1:6) <> '885645';
069005200618        // group# = ' ';
069006200618        // leavesr;
069009200618        //endif;
069010200228
069100200228        //if group# = '885645';
069101200228         //group# = '1309061';
069102200228         //leavesr;
069103200228        //else;
069104200228        // group# = ' ';
069105200228        //endif;
069106200228
069107200228        pos2 = %scan('  ':group#:1);
069108200228        if pos2 > 0;
069109200228         pos2 = pos2 + 2;
069110200228          group# = %subst(group#:pos2:7);
069112200228         leavesr;
069113200228        endif;
069114200228
069115200228        pos = %scan(' ':group#:1);
069116200228        if pos > 0;
069117200228         pos = pos + 1;
069118200228         group# = %subst(group#:pos:7);
069119200228        endif;
069120200228
069200200228       endsr;
069300180313
069400190226      //===================================================================
069500190226      // Determine Type
069600190226      //===================================================================
069700190226
069800190226       begsr determineType;
069900190226
070000190226        catType = ' ';
070100190226
070200190226        chain ('P' : %subst(plncat:2:2)) codesFile;
070300190226        if %found;
070400190226
070500190226         select;
070600200228          when action = 'l';
070700190226           catType = 'MED';
070800190226
070900190226          when action = 'D';
071000190226           catType = 'DEN';
071100190226
071200190226          when action = 'V';
071300190226           catType = 'VIS';
071400190226         endsl;
071500190226
071600190226        endif;
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
072600181030        select;
072700181030         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
072701200424          prcode = 'SP';
072702200424
073000181030         when drelcd = 'RDA' or drelcd = 'RSO';
073100200424          prcode = 'CH';
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
073608200618        ok_toTransmit = 'N';
073609200618
073610200618        chain (unique : pltrst : plsub# : acc#) setupFile;
073611200228        if %found;
073612200618         if castatus = inType;
073613200618          ok_toTransmit = 'Y';
073614200618         endif;
073615200228        endif;
074206190401
075105190401       endsr;
075106190401
075107200228      //===================================================================
075108200228      // check for transmission
075109200228      //===================================================================
075110200228
075111200228       begsr sectionERC;
075113200228
075114200228         pseccode3 = '~ERC~';
075115200228         psuplname = ' ';
075117200228         PSUPFNAME = ' ';
075119200228         PSUPID = ' ';
075121200228         PSUPPH = ' ';
075123200228         PSUPEMAIL = ' ';
075125200228         PHRLNAME = ' ';
075127200228         PHRFNAME = ' ';
075129200228         PHRID = ' ';
075131200228         PHRPH = ' ';
075133200228         PHREMAIL = ' ';
075135200228         PERLNAME = ' ';
075137200228         PERFNAME = ' ';
075139200228         PERID = ' ';
075141200228         PEREMAIL = ' ';
075142200228
075143200228       endsr;
075144200228
075145200228      //===================================================================
075146200228      // check for transmission
075147200228      //===================================================================
075148200228
075149200228       begsr writeSections;
075150200228
075151200401        pseccode1 = '~BNK~';
075152200401        pseccode3 = '~ERC~';
075154200401        pseccode4 = '~EMI~';
075155200401        //pseccod5 = '~CSF~';
075156200401        //pseccod6 = '~NST~';
075157200401        //pseccod7 = '~NSB~';
075158200401        //pseccod8 = '~STA~';
075159200401        //pseccod9 = '~PFL~';
075160200401        //pseccod10 = '~FLX~';
075161200401        //pseccod11 = '~LTD~';
075162200401        //pseccod12 = '~LDB~';
075163200401        //pseccod13 = '~RPL~';
075164200401        //pseccod14 = '~BLF~';
075165200401        //pseccod15 = '~BAD~';
075166200401        //pseccod16 = '~LIF~';
075167200401        //pseccod18 = '~ADD~';
075168200401        //pseccod19 = '~BSD~';
075169200401        //pseccod20 = '~SSA~';
075170200401        //pseccod21 = '~BSL~';
075171200401        //pseccod22 = '~SPL~';
075172200401        //pseccod23 = '~BDL~';
075173200401        //pseccod24 = '~DPL~';
075174200401        //pseccod25 = '~BSA~';
075175200401        //pseccod26 = '~SAD~';
075176200401        //pseccod27 = '~BDA~';
075177200401        //pseccod28 = '~DCA~';
075178200409        //pseccod29 = '~VCI~';
075179200401        //pseccod30 = '~CIB~';
075181200401        //pseccod32 = '~LMS~';
075182200401        //pseccod33 = '~ROL~';
075183200401        //pseccod34 = '~BEN~';
075184200401        //pseccod35 = '~DED~';
075185200228
075186200228       endsr;
075187200228
075188200629      //===================================================================
075189200629      // clear 000000000
075190200629      //===================================================================
075191200629
075192200629       begsr clearSSN;
075193200629
075194200629        setll *loval hartFile;
075195200629        read hartFile;
075196200629
075197200629        dow not %eof;
075198200629
075199200629         if pmssn = '000000000';
075200200629          pmssn = ' ';
075201200629          update hartFile;
075202200629         endif;
075203200629
075204200629        read hartFile;
075205200629        enddo;
075206200629
075207200629       endsr;
075209200629
075210160511      //===================================================================
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
076801200228        carrierCode1 = 'HAR';
076802200228        carrierCode2 = 'SBS';
076803200228        grouperCode = 'HL';
077000200228        carrier = 19;
077100200618        unique = '0000000327';
077200181031
077300160519        today = %dec(%char(%date:*iso0):8:0);
077400181105
077500160511       endsr;
077600010412
077700160511       //==============================================================
