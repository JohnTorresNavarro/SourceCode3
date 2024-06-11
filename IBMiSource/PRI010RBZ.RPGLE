000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200514      * PRI010RB - Principal Generate extract (for non-ssn records)
000500180313      *================================================================================
000600201027      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800200514      * 05/14/2020  jt    Original creation
000801200825      * 09/10/2020  jt    Changed how it grabs the 111-11 ssn dependents
000802201027      * 10/27/2020  jt    Added smoker flag.
000803201116      * 11/16/2020  jt    Added category PVW.
000804201119      * 11/19/2020  jt    Added class ID
000805210205      * 02/05/2021  jt    Added more logic to check transmission subr.
000806210216      * 02/16/2021  jt    Added plan id's that were missing. Fixed phone.
000807210519      * 02/17/2021  jt    Changed class ID.
000808210519      * 05/19/2021  jt    Added handicap
000809220223      * 02/23/2022  jt    Added plan categoies PLL and PA1
000900160513      *===========================================================================
001000160512
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
002100181101     Fcarmstl   if   e           k disk    extfile('F.CARMSTL')
002200181101     F                                     rename(carmsr:carrFile)
002300180412
002400200206     Fmcov42    if   e           k disk    extfile('F.MCOV42')
002500181031
002600200514     Fmcov44    if   e           k disk    rename(mcovr:covc44)
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
004900200224     fpritrm    uf a e           k disk    rename(pritr:termFile)
005000180523
005102200514     fmemmem    if   e           k disk    rename(memmemr:linkFile)
005103201027
005104201027     fsmoke     if   e           k disk
005105210216
005106210217     fcarplnz   if   e           k disk    rename(carplnr:planSetup)
005200200911
005201200915     fcaraccp   if   e           k disk    rename(caraccr:transFile)
005202200911
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
007802201116     d pos2            s              2  0
007803200825     d holdBirth       s              8  0
007804200825     d newSeq#         s              2  0
007805200825     d holdCcandt      s              8  0
007806200911     d ok_toTransmit   s              1
007807200915     d unique          s             10
007808201119     d holdClass       s              5
007809210506     d foundPlan       s              1
008100150820
008200181105     d lastday         pr                  extpgm('LSTDAY')
008300181105     d  candtp                        8
008400181105     d  lastdate                      8    const
008500181105     d  error                        20    const
008501200224
008502200915     d pri010rbz       pi
008503200224     d  p_acct                        7
008504200915     d  inType                        1
008505200224
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
014602200514         if %subst(fill66:66:1) = ' ';
014603200514          leavesr;
014604200514         endif;
014605200514        endif;
014700160511
014701200915        exsr checkTransmission;
014702200915        if ok_toTransmit = 'N';
014703200915         leavesr;
014704200915        endif;
014705200915
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
016201200911
016300200911        exsr checkTransmission;
016301200911        if ok_toTransmit = 'N';
016302200911         leavesr;
016303200911        endif;
016304200911
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
047501200825        holdCcandt = ccandt;
047502200825
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
049200200514         setgt (mctrst:mcsub#:mcplan:mcssno) dcovr;
049300200514         readpe (mctrst:mcsub#:mcplan:mcssno) dcovr;
049400160512
049500200514         dow not %eof;
049501200514
049502200514          if birth = dbirth and (drelcd = 'RWI' or drelcd = 'RHU') and
049503200514            dpdltd = 'A';
049504200825
049505200825            holdBirth = birth;
049600181030
049700200514           exsr writeDep;
049701200514
049702200514          endif;
049800181030
049900200514         readpe (mctrst:mcsub#:mcplan:mcssno) dcovr;
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
050903200825        //if holdCcandt = 0;
050904200825        // ccandt = 0;
050905200825        //endif;
050906200825
050907200825        //chain (mcssno2 : dpseq#) depenr;
050908200825        chain (mcssno2 : newSeq#) depenr;
050909200825        if %found;
050910200514
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
052537230113         plocid = cacid4;
052539200224         psupid1 = ' ';
052540200224         psupid2 = ' ';
052542200224         psupid3 = ' ';
052543200224         psupid4 = ' ';
052544200224         psupid5 = ' ';
052545200224         psupid6 = ' ';
052546200224
052547200224         peventcd = ' ';
052548200224         peventdt = ' ';
052549200224
052550200224         pempdt = ' ';
052552200224         pelegdt = ' ';
052553200224         pemphrs = ' ';
052554200224
052555200224         pcocostdt = ' ';
052556200224         pcocoendt = ' ';
052557200224         pretdt = ' ';
052558200224         pempendt = ' ';
052560200224
052561200224         exsr determineType;
052562210216         exsr getPlan;
052563200224
052564210506         if foundPlan = 'Y';
052568220223         if plncat = 'PLF' or plncat = 'PLL';
052569200224         if pcovid1 <> ptype;
052570210216          pcovid1 = 'BLF';
052571210216          pplanid1 = cpcid1;
052586200224          pcovefdt1 = %char(denrdt);
052587200224
052588200224          seq# = dpseq#;
052589200514          ssn = mcssno2;
052590200224          termdt = ccandt;
052591200224          exsr checkTerm;
052592200224          if alreadySent = 'N';
052593200224
052594210217           if cpcid2 > ' ' and pclassid = ' ';
052595210217            pclassid = cpcid2;
052596210217           endif;
052597210217
052598200224           if ccandt > 0;
052599200224            cancelh = ccandt;
052600200224             exsr sub1_fromDate;
052601200224            pcovtrmdt1 = %char(cancelh);
052602200224           endif;
052603200224
052604200224           if writeRecord = 'Y';
052605200224            write priFile;
052606200224           endif;
052607200224           if updateRecord = 'Y';
052608200224            update priFile;
052609200224           endif;
052610200224
052611200224          endif;
052612200224         endif;
052613200224         endif;
052614210506         endif;
052615200224
052616210506         exsr determineType;
052617210506         exsr getPlan;
052618210506
052619210506         if foundPlan = 'Y';
052620220223         if plncat = 'PAC' or plncat = 'PA1';
052621200224         if pcovid2 <> ptype;
052622200224          pcovid2 = 'ADD';
052623210216          pplanid2 = cpcid1;
052624200224          pcovefdt2 = %char(denrdt);
052625200224
052626200224          seq# = dpseq#;
052627200514          ssn = mcssno2;
052628200224          termdt = ccandt;
052629200224          exsr checkTerm;
052630200224          if alreadySent = 'N';
052631200224
052632210217           if cpcid2 > ' ' and pclassid = ' ';
052633210217            pclassid = cpcid2;
052634210217           endif;
052635210217
052636200224           if ccandt > 0;
052637200224            cancelh = ccandt;
052638200224             exsr sub1_fromDate;
052639200224            pcovtrmdt2 = %char(cancelh);
052640200224           endif;
052641200224
052642200224           if writeRecord = 'Y';
052643200224            write priFile;
052644200224           endif;
052645200224           if updateRecord = 'Y';
052646200224            update priFile;
052647200224           endif;
052648200224
052649200224          endif;
052650200224         endif;
052651200224         endif;
052652210506         endif;
052653200224
052655210506         exsr determineType;
052656210506         exsr getPlan;
052657210506
052658210506         if foundPlan = 'Y';
052659200424         if plncat = 'PSF';
052660200224         if pcovid3 <> ptype;
052661200224          pcovid3 = 'DLF';
052662210216          pplanid3 = cpcid3;
052663200224          pcovefdt3 = %char(denrdt);
052664200224
052665200224          seq# = dpseq#;
052666200514          ssn = mcssno2;
052667200224          termdt = ccandt;
052668200224          exsr checkTerm;
052669200224          if alreadySent = 'N';
052670200224
052671200224           if ccandt > 0;
052672200224            cancelh = ccandt;
052673200224             exsr sub1_fromDate;
052674200224            pcovtrmdt3 = %char(cancelh);
052675200224           endif;
052676200224
052677200224           if writeRecord = 'Y';
052678200224            write priFile;
052679200224           endif;
052680200224           if updateRecord = 'Y';
052681200224            update priFile;
052682200224           endif;
052683200224
052684200224          endif;
052685200224         endif;
052686200224         endif;
052687210506         endif;
052688200224
052689210506         exsr determineType;
052690210506         exsr getPlan;
052691210506
052692210506         if foundPlan = 'Y';
052693200224         if plncat = 'PSL';
052694200224         if pcovid4 <> ptype;
052695200224          pcovid4 = 'EVL';
052696200224          pcovefdt4 = %char(denrdt);
052697200424          pbenamtel4 = %editc(benamt:'X');
052698200424          pbenamtap4 = %editc(benamt:'X');
052699200424          pbenperel4 = ' ';
052700210216          pplanid4 = cpcid1;
052701201027          pnicusa = 'N';
052702201028          chain (mcssno : dpseq#) smoker;
052703201027          if %found;
052704201027           pnicusa = 'T';
052705201027          endif;
052706201027
052707200224          seq# = dpseq#;
052708200514          ssn = mcssno2;
052709200224          termdt = ccandt;
052710200224          exsr checkTerm;
052711200224          if alreadySent = 'N';
052712200224
052713210217           if cpcid2 > ' ' and pclassid = ' ';
052714210217            pclassid = cpcid2;
052715210217           endif;
052716210217
052717200224           if ccandt > 0;
052718200224            cancelh = ccandt;
052719200224             exsr sub1_fromDate;
052720200224            pcovtrmdt4 = %char(cancelh);
052721200224           endif;
052722200224
052723200224           if writeRecord = 'Y';
052724200224            write priFile;
052725200224           endif;
052726200224           if updateRecord = 'Y';
052727200224            update priFile;
052728200224           endif;
052729200224
052730200224          endif;
052731200224         endif;
052732200224         endif;
052733210506         endif;
052734200224
052735210506         exsr determineType;
052736210506         exsr getPlan;
052737210506
052738210506         if foundPlan = 'Y';
052739200224         if plncat = 'POA';
052740200224         if pcovid5 <> ptype;
052741200224          pcovid5 = 'EVA';
052742200224          pcovefdt5 = %char(enrldt);
052743210216          pplanid5 = cpcid5;
052744200224
052745200224          seq# = dpseq#;
052746200514          ssn = mcssno2;
052747200224          termdt = ccandt;
052748200224          exsr checkTerm;
052749200224          if alreadySent = 'N';
052750200224
052751200224           if ccandt > 0;
052752200224            cancelh = ccandt;
052753200224             exsr sub1_fromDate;
052754200224            pcovtrmdt5 = %char(cancelh);
052755200224           endif;
052756200224
052757200224           if writeRecord = 'Y';
052758200224            write priFile;
052759200224           endif;
052760200224           if updateRecord = 'Y';
052761200224            update priFile;
052762200224           endif;
052763200224
052764200224          endif;
052765200224         endif;
052766210506         endif;
052767210506         endif;
052768200224
052769210506
052770210506         exsr determineType;
052771210506         exsr getPlan;
052772210506
052773210506         if foundPlan = 'Y';
052774200224         if plncat = 'PSP';
052775200224         if pcovid6 <> ptype;
052776200514          chain mcssno2 member;
052777200514
052778200514          chain (%editc(mcssno2:'X') : %editc(mcssno2:'X') :
052779200514                 %char(birth)) priFile;
052780200514          if %found;
052781200514           pcovid6 = 'SVL';
052782200514           pcovefdt6 = %char(denrdt);
052783200514           pbenamtel6 = %editc(benamt:'X');
052784200514           pbenamtap6 = %editc(benamt:'X');
052785210216           pplanid6 = cpcid1;
052786200514
052787201027           pnicusa = 'N';
052788201028           chain (mcssno : dpseq#) smoker;
052789201027           if %found;
052790201027            pnicusa = 'T';
052791201027           endif;
052792201027
052793200514           seq# = dpseq#;
052794200514           ssn = mcssno2;
052795200514           termdt = ccandt;
052796200514           exsr checkTerm;
052797200514           if alreadySent = 'N';
052798200514
052799210217            if cpcid2 > ' ' and pclassid = ' ';
052800210217             pclassid = cpcid2;
052801210217            endif;
052802210217
052803200514            if ccandt > 0;
052804200514             cancelh = ccandt;
052805200514              exsr sub1_fromDate;
052806200514             pcovtrmdt6 = %char(cancelh);
052807200514            endif;
052808200224
052809200514            if updateRecord = 'Y';
052810200514             update priFile;
052811200514            endif;
052812200514
052813200514           endif;
052814200224
052815200514          else;
052816200514           if writeRecord = 'Y';
052817200514            write priFile;
052818200514           endif;
052819200224          endif;
052820200514
052821200224         endif;
052822200224         endif;
052823210506         endif;
052824200224
052825210506         exsr determineType;
052826210506         exsr getPlan;
052827210506
052828210506         if foundPlan = 'Y';
052829200514         if plncat = 'PSA';
052830200514         if pcovid7 <> ptype;
052831200514          chain mcssno2 member;
052832200514
052833200514          chain (%editc(mcssno2:'X') : %editc(mcssno2:'X') :
052834201228                 %char(birth)) priFile;
052835200514          if %found;
052836200514           pcovid7 = 'SVA';
052837210216           pplanid7 = cpcid1;
052838200514           pcovefdt7 = %char(denrdt);
052839200224
052840200514           seq# = dpseq#;
052841200514           ssn = mcssno2;
052842200514           termdt = ccandt;
052843200514           exsr checkTerm;
052844200514           if alreadySent = 'N';
052845210217
052846210217            if cpcid2 > ' ' and pclassid = ' ';
052847210217             pclassid = cpcid2;
052848210217            endif;
052849200224
052850200514            if ccandt > 0;
052851200514             cancelh = ccandt;
052852200514              exsr sub1_fromDate;
052853200514             pcovtrmdt7 = %char(cancelh);
052854200514            endif;
052855200224
052856200514            if updateRecord = 'Y';
052857200514             update priFile;
052858200514            endif;
052859200514
052860200514           endif;
052861200514
052862200514          else;
052863200514           if writeRecord = 'Y';
052864200514            write priFile;
052865200514           endif;
052866200514          endif;
052867200224
052868200514         endif;
052869200514         endif;
052870210506         endif;
052871200224
052872210506         exsr determineType;
052873210506         exsr getPlan;
052874210506
052875210506         if foundPlan = 'Y';
052876201116         if plncat = 'PWD' or plncat = 'PVW';
052877200224         if pcovid9 <> ptype;
052878200224          pcovid9 = 'STD';
052879200224          pcovefdt9 = %char(enrldt);
052880200424          pbenamtel9 = %editc(benamt:'X');
052881200424          pbenamtap9 = %editc(benamt:'X');
052882210216          pplanid9 = cpcid1;
052883200224
052884200514          ssn = mcssno2;
052885200224          termdt = candt;
052886200224          exsr checkTerm;
052887200224          if alreadySent = 'N';
052888200224
052889210217           if cpcid2 > ' ' and pclassid = ' ';
052890210217            pclassid = cpcid2;
052891210217           endif;
052892210217
052893200224           if candt > 0;
052894200224            cancelh = candt;
052895200224             exsr sub1_fromDate;
052896200224            pcovtrmdt9 = %char(cancelh);
052897200224           endif;
052898200224
052899200224           if writeRecord = 'Y';
052900200224            write priFile;
052901200224           endif;
052902200224           if updateRecord = 'Y';
052903200224            update priFile;
052904200224           endif;
052905200224
052906200224          endif;
052907200224         endif;
052908200224         endif;
052909210506         endif;
052910200224
052911210506         exsr determineType;
052912210506         exsr getPlan;
052913210506
052914210506         if foundPlan = 'Y';
052915201027         if plncat = 'PLT' or plncat = 'PVL';
052916200224         if pcovid10 <> ptype;
052917200224          pcovid10 = 'LTD';
052918210216          pplanid10 = cpcid1;
052919200224          pcovefdt10 = %char(denrdt);
052920200424          pbenamte10 = %editc(benamt:'X');
052921200424          pbenamta10 = %editc(benamt:'X');
052922200224
052923200224          seq# = dpseq#;
052924200514          ssn = mcssno2;
052925200224          termdt = ccandt;
052926200224          exsr checkTerm;
052927200224          if alreadySent = 'N';
052928200224
052929210217           if cpcid2 > ' ' and pclassid = ' ';
052930210217            pclassid = cpcid2;
052931210217           endif;
052932210217
052933200224           if ccandt > 0;
052934200224            cancelh = ccandt;
052935200224             exsr sub1_fromDate;
052936200224            pcovtrmd10 = %char(cancelh);
052937200224           endif;
052938200224
052939200224           if writeRecord = 'Y';
052940200224            write priFile;
052941200224           endif;
052942200224           if updateRecord = 'Y';
052943200224            update priFile;
052944200224           endif;
052945200224
052946200224          endif;
052947200224         endif;
052948200224         endif;
052949210506         endif;
052950200224
052951210506         exsr determineType;
052952210506         exsr getPlan;
052953210506
052954210506         if foundPlan = 'Y';
052955200224         if plncat = 'PDN';
052956200224         if pcovid11 <> ptype;
052957200224          pcovid11 = 'DEN';
052958200224          pcovefdt11 = %char(denrdt);
052959200224
052960210216          pplanid11 = cpcid1;
052961200224
052962200224          seq# = dpseq#;
052963200514          ssn = mcssno2;
052964200224          termdt = ccandt;
052965200224          exsr checkTerm;
052966200224          if alreadySent = 'N';
052967200224
052968210217           if cpcid2 > ' ' and pclassid = ' ';
052969210217            pclassid = cpcid2;
052970210217           endif;
052971210217
052972200224           if ccandt > 0;
052973200224            cancelh = ccandt;
052974200224             exsr sub1_fromDate;
052975200224            pcovtrmd11 = %char(cancelh);
052976200224           endif;
052977200224
052978200224           if writeRecord = 'Y';
052979200224            write priFile;
052980200224           endif;
052981200224           if updateRecord = 'Y';
052982200224            update priFile;
052983200224           endif;
052984200224
052985200224          endif;
052986200224         endif;
052987200224         endif;
052988210506         endif;
052989200224
052990210506         exsr determineType;
052991210506         exsr getPlan;
052992210506
052993210506         if foundPlan = 'Y';
052994200224         if plncat = 'PVS';
052995200224         if pcovid12 <> ptype;
052996200224          pcovid12 = 'VIS';
052997210216          pplanid12 = cpcid1;
052998200424
052999200224          pcovefdt12 = %char(denrdt);
053000200224
053001200224          seq# = dpseq#;
053002200514          ssn = mcssno2;
053003200224          termdt = ccandt;
053004200224          exsr checkTerm;
053005200224          if alreadySent = 'N';
053006200224
053007210217           if cpcid2 > ' ' and pclassid = ' ';
053008210217            pclassid = cpcid2;
053009210217           endif;
053010210217
053011200224           if ccandt > 0;
053012200224            cancelh = ccandt;
053013200224             exsr sub1_fromDate;
053014200224            pcovtrmd12 = %char(cancelh);
053015200224           endif;
053016200224
053017200224           if writeRecord = 'Y';
053018200224            write priFile;
053019200224           endif;
053020200224           if updateRecord = 'Y';
053021200224            update priFile;
053022200224           endif;
053023200224
053024200224          endif;
053025200224         endif;
053026200224         endif;
053027210506         endif;
053028200224
053029210506         exsr determineType;
053030210506         exsr getPlan;
053031210506
053032210506         if foundPlan = 'Y';
053033200224         if plncat = 'PCC';
053034200224         if pcovid13 <> ptype;
053035200224          pcovid13 = 'ECI';
053036210216          pplanid13 = cpcid1;
053037200224          pcovefdt13 = %char(denrdt);
053038200424          pbenamte13 = %editc(benamt:'X');
053039200424          pbenamta13 = %editc(benamt:'X');
053040200224
053041200224          seq# = dpseq#;
053042200514          ssn = mcssno2;
053043200224          termdt = ccandt;
053044200224          exsr checkTerm;
053045200224          if alreadySent = 'N';
053046200224
053047210217           if cpcid2 > ' ' and pclassid = ' ';
053048210217            pclassid = cpcid2;
053049210217           endif;
053050210217
053051200224           if ccandt > 0;
053052200224            cancelh = ccandt;
053053200224             exsr sub1_fromDate;
053054200224            pcovtrmd13 = %char(cancelh);
053055200224           endif;
053056200224
053057200224           if writeRecord = 'Y';
053058200224            write priFile;
053059200224           endif;
053060200224           if updateRecord = 'Y';
053061200224            update priFile;
053062200224           endif;
053063200224
053064200224          endif;
053065200224         endif;
053066200224         endif;
053067210506         endif;
053068200224
053069210506         exsr determineType;
053070210506         exsr getPlan;
053071210506
053072210506         if foundPlan = 'Y';
053073200224         if plncat = 'PCB';
053074200224         if pcovid14 <> ptype;
053075200224          pcovid14 = 'SCI';
053076210216          pplanid14 = cpcid1;
053077200224          pcovefdt14 = %char(denrdt);
053078200424          pbenamte14 = %editc(benamt:'X');
053079200424          pbenamta14 = %editc(benamt:'X');
053080200224
053081200224          seq# = dpseq#;
053082200514          ssn = mcssno2;
053083200224          termdt = ccandt;
053084200224          exsr checkTerm;
053085200224          if alreadySent = 'N';
053086200224
053087210217           if cpcid2 > ' ' and pclassid = ' ';
053088210217            pclassid = cpcid2;
053089210217           endif;
053090210217
053091200224           if ccandt > 0;
053092200224            cancelh = ccandt;
053093200224             exsr sub1_fromDate;
053094200224            pcovtrmd14 = %char(cancelh);
053095200224           endif;
053096200224
053097200224           if writeRecord = 'Y';
053098200224            write priFile;
053099200224           endif;
053100200224           if updateRecord = 'Y';
053101200224            update priFile;
053102200224           endif;
053103200224
053104200224          endif;
053105200224         endif;
053106200224         endif;
053107210506         endif;
053108200224
053109210506         exsr determineType;
053110210506         exsr getPlan;
053111210506
053112210506         if foundPlan = 'Y';
053113200224         if plncat = 'PCG';
053114200224         if pcovid15 <> ptype;
053115200224          pcovid15 = 'CCI';
053116210216          pplanid15 = cpcid1;
053117200224          pcovefdt15 = %char(denrdt);
053118200424          pbenamte15 = %editc(benamt:'X');
053119200424          pbenamta15 = %editc(benamt:'X');
053120200224
053121200224          seq# = dpseq#;
053122200514          ssn = mcssno2;
053123200224          termdt = ccandt;
053124200224          exsr checkTerm;
053125200224          if alreadySent = 'N';
053126200224
053127210217           if cpcid2 > ' ' and pclassid = ' ';
053128210217            pclassid = cpcid2;
053129210217           endif;
053130210217
053131200224           if ccandt > 0;
053132200224            cancelh = ccandt;
053133200224             exsr sub1_fromDate;
053134200224            pcovtrmd15 = %char(cancelh);
053135200224           endif;
053136200224
053137200224           if writeRecord = 'Y';
053138200224            write priFile;
053139200224           endif;
053140200224           if updateRecord = 'Y';
053141200224            update priFile;
053142200224           endif;
053143200224
053144200224          endif;
053145200224         endif;
053146210506         endif;
053147210506         endif;
053148200224
053149210506         exsr determineType;
053150210506         exsr getPlan;
053151210506
053152210506         if foundPlan = 'Y';
053153200224         if plncat = 'PO6';
053154200224         if pcovid16 <> ptype;
053155200224          pcovid16 = 'ACC';
053156200224          pcovefdt16 = %char(denrdt);
053157200224
053158200224          seq# = dpseq#;
053159200514          ssn = mcssno2;
053160200224          termdt = ccandt;
053161200224          exsr checkTerm;
053162200224          if alreadySent = 'N';
053163200224
053164200224           if ccandt > 0;
053165200224            cancelh = ccandt;
053166200224             exsr sub1_fromDate;
053167200224            pcovtrmd16 = %char(cancelh);
053168200224           endif;
053169200224
053170200224           if writeRecord = 'Y';
053171200224            write priFile;
053172200224           endif;
053173200224           if updateRecord = 'Y';
053174200224            update priFile;
053175200224           endif;
053176200224
053177200224          endif;
053178200224         endif;
053179200224         endif;
053180210506         endif;
053181200224
053182200825         endif;
053183200514
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
069103201116         pos = pos - 1;
069105200224         pacct# = %subst(group#:1:pos);
069108200224        else;
069109200224         pacct# = group#;
069111200224        endif;
069130201116
069131200224        if p_acct > ' ';
069132200224         if pacct# <> p_acct;
069133200224          pacct# = ' ';
069134200224         endif;
069135200224        endif;
069136200224
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
070158201027
070159200224         endsl;
071700190226
071800190226       endsr;
071900190226
071901210216      //===================================================================
071902210216      // Determine Type
071903210216      //===================================================================
071904210216
071905210216       begsr getplan;
071906210216
071907210506        foundPlan = 'N';
071908210216
071909210217        chain (unique : pltrst : plsub# : acc# : plplan) planSetup;
071910210216        if %found;
071911210506         foundPlan = 'Y';
071912210216        endif;
071913210216
071914210216       endsr;
071915210216
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
073401210519        if dhndcp = '1' or dhndcp = '2' or dhndcp = '3';
073402210519         prel = 'H';
073403210519        endif;
073404210519
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
073623200911      //===================================================================
073624200911      // check for transmission
073625200911      //===================================================================
073626200911
073627200911       begsr checkTransmission;
073628200911
073629200915        ok_toTransmit = 'N';
073630200911
073631200915        chain (unique : pltrst : plsub# : acc#) transFile;
073632200915        if %found;
073633200915         if castatus = inType;
073634200915          ok_toTransmit = 'Y';
073635200915          p_acct = %subst(cacid2:1:7);
073636200915         endif;
073637200915        endif;
073638210205
073639210205        if not %found;
073640210205         ok_toTransmit = 'N';
073641210205        endif;
073643200915
073644200911       endsr;
073645200911
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
077100200915        unique = '0000000329';
077200181031
077300160519        today = %dec(%char(%date:*iso0):8:0);
077400181105
077500160511       endsr;
077600010412
077700160511       //==============================================================
