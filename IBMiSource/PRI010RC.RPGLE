000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200515      * PRI010RC - Principal Generate extract (for non-ssn demog. only)
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800200515      * 05/15/2020  jt    Original creation
000801200825      * 09/11/2020  jt    Changed how it grabs the 111-11 ssn dependents
000802201027      * 10/27/2020  jt    Added smoker flag.
000803201119      * 11/19/2020  jt    Added class ID
000804201201      * 12/03/2020  jt    Fixed benefi ammount.
000805210205      * 02/05/2021  jt    Added more logic to check transmission subr.
000806210216      * 02/16/2021  jt    Added plan id's that were missing. Fixed phone.
000807210217      * 02/17/2021  jt    Changed class ID.
000808210406      * 04/06/2021  jt    Checked for "active" plans
000809210519      * 05/19/2021  jt    Added handicap
000810220223      * 02/23/2022  jt    Added plan categories PLL and PA1
000811230117      * 01/17/2023  jt    Added location ID
000900160513      *===========================================================================
001000160512
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
002100181101     Fcarmstl   if   e           k disk    extfile('F.CARMSTL')
002200181101     F                                     rename(carmsr:carrFile)
002300180412
002301210914     Fmcov41    if   e           k disk    extfile('F.MCOV41')
002302210914     f                                     rename(mcovr:covc41)
002303210914
002304210914     Fmcov40    if   e           k disk    extfile('F.MCOV40')
002305210914     F                                     rename(mcovr:covc40)
002306210914
002400200206     Fmcov42    if   e           k disk    extfile('F.MCOV42')
002500181031
002600210914     F*mcov44    if   e           k disk
002601210914     F*                                     rename(mcovr:covc44)
002602200206
002900180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003000160513
003100160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003200160513
003300160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003400160518
003500160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003600180508
004300200224     fpridetail uf a e           k disk    rename(prhr:priFile)
004400160513
004900230119     fpritrm2   uf a e           k disk    rename(pritr:termFile)
005000180523
005102200514     fmemmem    if   e           k disk    rename(memmemr:linkFile)
005200181113
005201200515     fssntemp   if a e           k disk    rename(ssnr:ssnFile)
005202201027
005203201027     fsmoke     if   e           k disk
005204210216
005205210216     fcarplnp   if   e           k disk    rename(carplnr:planSetup)
005206200825
005207200825     ftransoff1 if   e           k disk    rename(transr:transFile)
005208201117
005209201117     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
005210200825
005300181030      *================================================================================
005301200515      *   xxx = %editc( %dec(%char(%date(numericdate:*iso):*mdy0):8:0):'X');
005400181030      *   opcode to convert yyyymmdd to mmddyyyy
005600160512      *=================================================================
005700061017
005800181101     d carrierCode     s              3
005801190308     d carrierCode1    s              3
005802190308     d carrierCode2    s              3
005803190308     d carrierCode3    s              3
005804190308     d carrierCode4    s              3
005805190308     d carrierCode5    s              3
005900181101     d grouperCode     s              2
006000200514     d mcssno2         s              9  0
006100180913     d cancelh         s              8  0
006200160519     d today           s              8  0
006300190227     d alreadySent     s              1
006700180523     d ssn             s              9  0
006800180523     d seq#            s              2  0
006900200224     d ptype           s              3
007000190227     d updateRecord    s              1
007100190227     d writeRecord     s              1
007200180523     d termdt          s              8  0
007400181113     d carrier         s              2  0
007600181105     d candtp          s              8
007700181105     d lastdate        s              8
007800181105     d error           s             20
007801200224     d pos             s              2  0
007802201117     d pos2            s              2  0
007803200515     d continue        s              1
007804200515     d count           s              2  0
007805200825     d holdBirth       s              8  0
007806200825     d newSeq#         s              2  0
007807200825     d ok_toTransmit   s              1
007808201117     d unique          s             10
007809201119     d holdClass       s              5
007810210406     d foundPlan       s              1
008100150820
008200181105     d lastday         pr                  extpgm('LSTDAY')
008300181105     d  candtp                        8
008400181105     d  lastdate                      8    const
008500181105     d  error                        20    const
008501200224
008502200515     d pri010rc        pi
008503200224     d  p_acct                        7
008504200224
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
012401200515
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
014602200514         if %subst(fill66:66:1) = ' ';
014603200514          leavesr;
014604200514         endif;
014605200514        endif;
014700160511
014701200515        exsr check_ifWriting;
014702200515
014703200515        if continue = 'Y';
014704200515
014800210914         setll (mcssno : 00 : pltrst : plsub# : plplan) covc40;
014801210914         reade (mcssno : 00 : pltrst : plsub# : plplan) covc40;
014803210914
014804210914        //setll (pltrst : plsub# : acc# : mcssno) covc44;
014805210914        //reade (pltrst : plsub# : acc# : mcssno) covc44;
014806200206
014807200206        dow not %eof;
014808200206
014809200515         //if plplan = mcplan;
014810210914         if plplan = mcplan;
014811200206          exsr writeMember;
014812210914         endif;
014813200515         //endif;
014814200206
014815210914        reade (mcssno : 00 : pltrst : plsub# : plplan) covc40;
014816210914        //reade (pltrst : plsub# : acc# : mcssno) covc44;
014817200206        enddo;
014818210914
015200210914        setll (mcssno : 00 : pltrst : plsub#) covc41;
015201210914        reade (mcssno : 00 : pltrst : plsub#) covc41;
015202210914
015203210914        dow not %eof;
015204210914
015205210914         if plplan = mcplan;
015206210914          exsr writeMember;
015207210914         endif;
015208210914
015209210914        reade (mcssno : 00 : pltrst : plsub#) covc41;
015210210914        enddo;
015211200515        endif;
015212200515
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
016201200825
016300200825        exsr checkTransmission;
016301200825        if ok_toTransmit = 'N';
016302200825         leavesr;
016303200825        endif;
016304200825
016305200515        chain mcssno2 member;
016306200515        chain mcssno linkFile;
016307200515        if %found;
016308200515          mcssno2 = mmorssn;
016309200515        endif;
016310200515
016900181102        chain
017000200515        (%char(%editc(mcssno2:'X')):%editc(mcssno2:'X'):
017100200224        %char(birth):mlname:mfname:mmi) priFile;
017200190227
017300190227        if %found;
017401200515         writeRecord = 'Y';
017500190227        else;
017501200515         leavesr;
017700190227        endif;
017800190227
018000200515        clear priFile;
018200181102
018302200228         exsr getGroup;
018401200224         if pacct# = ' ';
018402200228          leavesr;
018403200228         endif;
018404200228
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
044001230119
044002230119        setgt (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
044003230119        readpe (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
044004230119        dow not %eof;
044005230119        if termdt <= ttermdt;
044006230119         alreadySent = 'Y';
044007230119         leavesr;
044008230119        endif;
044009230119        readpe (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
044010230119        enddo;
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
047002200825
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
048001200514        reade mcssno depenr;
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
049101200514        chain mcssno linkFile;
049102200514        if %found;
049103200514          mcssno2 = mmorssn;
049104200514
049200200515         setgt (mctrst:mcsub#:mcplan:mcssno) dcovr;
049300200515         readpe (mctrst:mcsub#:mcplan:mcssno) dcovr;
049400160512
049500200514         dow not %eof;
049501200514
049502200515          if (drelcd = 'RWI' or drelcd = 'RHU') and
049504200515            dpdltd = 'A';
049505200825            holdBirth = dbirth;
049700200514           exsr writeDep;
049702200514          endif;
049800181030
049900200515         readpe (mctrst:mcsub#:mcplan:mcssno) dcovr;
050000200514         enddo;
050001200514
050002200514        endif;
050100200514
050200160512       endsr;
050300160512
050400160516      //===============================================================
050500160516      // write dependent
050600160516      //===============================================================
050700160516
050800160516       begsr writeDep;
050900180313
050901200825        exsr getDependent#;
050902200825
050903200825        //chain (mcssno : dpseq#) depenr;
050904200825        chain (mcssno2 : newSeq#) depenr;
050905200514        if %found;
050906200514
051000190227        updateRecord = 'N';
051100190227        writeRecord = 'N';
051200190227
051300181102        chain
051400200514        (%char(%editc(mcssno2:'X')):%editc(depss#:'X'):
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
052506200514         pempssn = %editc(mcssno2:'X');
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
052528210216         phphone = ' ';
052529210216         if area > 0 and phone > 0;
052530210216          phphone = %editc(area:'X') + %editc(phone:'X');
052531210216         endif;
052532200224
052537230117         plocid = cacid4;
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
052561200515         if writeRecord = 'Y';
052562200515          if continue = 'Y';
052563200515           write priFile;
052564200515          endif;
052565200515         endif;
052566200515
052567200224         exsr determineType;
052568210216         exsr getPlan;
052569200224
052570210406         if foundPlan = 'Y';
052717200224         if plncat = 'PSP';
052718200224         if pcovid6 <> ptype;
052719200514          chain mcssno2 member;
052720200514
052721200514          chain (%editc(mcssno2:'X') : %editc(mcssno2:'X') :
052722200514                 %char(birth)) priFile;
052723200514          if %found;
052725200514           pcovid6 = 'SVL';
052726200514           pcovefdt6 = %char(denrdt);
052727201201           if pbenamtel6 = ' ';
052728210216            pplanid6 = cpcid1;
052730201201            pbenamtel6 = %editc(benamt:'X');
052731201201            pbenamtap6 = %editc(benamt:'X');
052732201201           endif;
052733200514
052734201027           pnicusa = 'N';
052735201028           chain (mcssno : dpseq#) smoker;
052736201027           if %found;
052737201027            pnicusa = 'T';
052738201027           endif;
052739201027
052740200514           seq# = dpseq#;
052741200514           ssn = mcssno2;
052742200514           termdt = ccandt;
052743200514           exsr checkTerm;
052744200514           if alreadySent = 'N';
052745210217
052746210217            if cpcid2 > ' ' and pclassid = ' ';
052747210217             pclassid = cpcid2;
052748210217            endif;
052749210217
052750200514            if ccandt > 0;
052751200514             cancelh = ccandt;
052752200514              exsr sub1_fromDate;
052753200514             pcovtrmdt6 = %char(cancelh);
052754200514            endif;
052755200515
052756200514           endif;
052757200515           update priFile;
052758200224
052759200514          else;
052760200514           if writeRecord = 'Y';
052761200514            write priFile;
052762200514           endif;
052763200224          endif;
052764200514
052765200224         endif;
052766200224         endif;
052767210406         endif;
052768200224
052769210406         if foundPlan = 'Y';
052770200514         if plncat = 'PSA';
052771200514         if pcovid7 <> ptype;
052772200514          chain mcssno2 member;
052773200514
052774200514          chain (%editc(mcssno2:'X') : %editc(mcssno2:'X') :
052775200514                 %char(birth)) priFile;
052776200514          if %found;
052777200514           pcovid7 = 'SVA';
052778210216           pplanid7 = cpcid1;
052779200514           pcovefdt7 = %char(denrdt);
052780200224
052781200514           seq# = dpseq#;
052782200514           ssn = mcssno2;
052783200514           termdt = ccandt;
052784200514           exsr checkTerm;
052785200514           if alreadySent = 'N';
052786210217
052787210217            if cpcid2 > ' ' and pclassid = ' ';
052788210217             pclassid = cpcid2;
052789210217            endif;
052790210217
052791200514            if ccandt > 0;
052792200514             cancelh = ccandt;
052793200514              exsr sub1_fromDate;
052794200514             pcovtrmdt7 = %char(cancelh);
052795200514            endif;
052796200224
052797200514           endif;
052798200515
052799200515           update priFile;
052800200514
052801200514          else;
052802200514           if writeRecord = 'Y';
052803200514            write priFile;
052804200514           endif;
052805200514          endif;
052806200224
052807200514         endif;
052808200514         endif;
052809210406         endif;
052810200224
052811210406         if foundPlan = 'Y';
052971200224         if plncat = 'PCB';
052972200224         if pcovid14 <> ptype;
052973200224          pcovid14 = 'SCI';
052974210216          pplanid14 = cpcid1;
052976200224          pcovefdt14 = %char(denrdt);
052977201201          if pbenamtel4 = ' ';
052978201201           pbenamte14 = %editc(benamt:'X');
052979201201           pbenamta14 = %editc(benamt:'X');
052980201201          endif;
052981201201
052982200224          seq# = dpseq#;
052983200514          ssn = mcssno2;
052984200224          termdt = ccandt;
052985200224          exsr checkTerm;
052986200224          if alreadySent = 'N';
052987210217
052988210217            if cpcid2 > ' ' and pclassid = ' ';
052989210217             pclassid = cpcid2;
052990210217            endif;
052991210217
052992200224           if ccandt > 0;
052993200224            cancelh = ccandt;
052994200224             exsr sub1_fromDate;
052995200224            pcovtrmd14 = %char(cancelh);
052996200224           endif;
052997200224
052998200224           if writeRecord = 'Y';
052999200224            write priFile;
053000200224           endif;
053001200224           if updateRecord = 'Y';
053002200224            update priFile;
053003200224           endif;
053004200224
053005200224          endif;
053006210406
053007200224         endif;
053008200224         endif;
053009210406         endif;
053010200224
053059200514         endif;
053060200514
066800160516       endsr;
066900160511
066901200515      //===================================================================
066902200515      // Get group number
066903200515      //===================================================================
066904200515
066905200515       begsr check_ifWriting;
066906200515
066907200515        chain mcssno ssnFile;
066908200515        if %found;
066909200515         continue = 'Y';
066910200515         leavesr;
066911200515        endif;
066912200515
066914200515        chain mcssno linkFile;
066915200515        if %found;
066916200515          mcssno2 = mmorssn;
066917200515        endif;
066918200515
066919200515        count = 0;
066920200515        continue = 'N';
066921200515
066922200515        setll (%editc(mcssno2:'X')) priDetail;
066923200515        reade (%editc(mcssno2:'X')) pridetail;
066953200515        dow not %eof;
066954200515
066955200515         count = count + 1;
066956200515
066957200515        reade (%editc(mcssno2:'X')) pridetail;
066958200515        enddo;
066959200515
066960200825        if count >= 1;
066962200515          ssnx = mcssno;
066963200825          chain mcssno ssnFile;
066964200825          if not %found;
066965200825           continue = 'Y';
066966200825           write ssnFile;
066967200825          endif;
066968200515        endif;
066969200515
066974200515       endsr;
066975200515
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
069103201117         pos = pos - 1;
069105200224         pacct# = %subst(group#:1:pos);
069106200224        else;
069107200224         pacct# = group#;
069108200224        endif;
069109200224
069128200224        if p_acct > ' ';
069129200224         if pacct# <> p_acct;
069130200224          pacct# = ' ';
069131200224         endif;
069132200224        endif;
069133200224
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
070131201027
070132201027          when plncat = 'PVL';
070133201027           ptype = 'LTD';
070134200224
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
070158200424
070159200224         endsl;
071700190226
071800190226       endsr;
071900190226
071902210216      //===================================================================
071903210216      // Determine Type
071904210216      //===================================================================
071905210216
071906210216       begsr getplan;
071907210216
071908210406        foundPlan = 'N';
071909210216
071910210216        chain (unique : pltrst : plsub# : acc# : ptype : plplan) planSetup;
071911210216        if %found;
071912210406         foundPlan = 'Y';
071913210216        endif;
071914210216
071915210216       endsr;
071916210216
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
073601200825      //===================================================================
073602200825      // get depenent #
073603200825      //===================================================================
073604200825
073605200825       begsr getDependent#;
073606200825
073607200825        newSeq# = 0;
073608200825
073609200825        setll mcssno2 depenr;
073610200825        reade mcssno2 depenr;
073611200825        dow not %eof;
073612200825
073613200825         if holdBirth = dbirth;
073614200825          newSeq# = dpseq#;
073615200825          leavesr;
073616200825         endif;
073617200825
073618200825        reade mcssno2 depenr;
073619200825        enddo;
073620200825
073621200825       endsr;
073622200825
073626200825      //===================================================================
073627200825      // check for transmission
073628200825      //===================================================================
073629200825
073630200825       begsr checkTransmission;
073631200825
073632200825        ok_toTransmit = 'Y';
073633200825
073634201117        chain (unique : pltrst : plsub# : acc#) setupFile;
073635210205        if %found;
073636210917         if castatus <> 'Y';
073637210205          ok_toTransmit = 'N';
073638210205         endif;
073639210205        endif;
073640210205
073641210205        if not %found;
073642210205         ok_toTransmit = 'N';
073643210205        endif;
073644201117
073645200825        chain (carrier : pltrst : plsub# : acc#) transFile;
073646200825        if %found;
073647200825         ok_toTransmit = 'N';
073648200825        endif;
073649200825
073650200825       endsr;
073651200825
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
077000200825        carrier = 19;
077100201117        unique = '0000000329';
077200181031
077300160519        today = %dec(%char(%date:*iso0):8:0);
077400181105
077500160511       endsr;
077600010412
077700160511       //==============================================================
