000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200514      * PRI010RB - Principal Generate extract (for non-ssn records)
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800200514      * 05/14/2020  jt    Original creation
000900200825      * 09/10/2020  jt    Changed how it grabs the 111-11 ssn dependents
001000201027      * 10/27/2020  jt    Added smoker flag.
001100201116      * 11/16/2020  jt    Added category PVW.
001200201119      * 11/19/2020  jt    Added class ID
001300210205      * 02/05/2021  jt    Added more logic to check transmission subr.
001400210216      * 02/16/2021  jt    Added plan id's that were missing. Fixed phone.
001500210217      * 02/17/2021  jt    Changed class ID.
001600210406      * 04/06/2021  jt    Checked for "active" plans
001700210519      * 05/19/2021  jt    Added handicap
001701220203      * 02/23/2022  jt    Added plan categories PLL and PA1.
001702230117      * 01/17/2023  jt    Added location ID
001800160513      *===========================================================================
001900160512
002000160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
002100160513
002200181101     Fcarmstl   if   e           k disk    extfile('F.CARMSTL')
002300181101     F                                     rename(carmsr:carrFile)
002400180412
002500210914     Fmcov41    if   e           k disk    extfile('F.MCOV41')
002600210914     f                                     rename(mcovr:covc41)
002700210914
002800210914     Fmcov40    if   e           k disk    extfile('F.MCOV40')
002900210914     F                                     rename(mcovr:covc40)
003000210914
003100200206     Fmcov42    if   e           k disk    extfile('F.MCOV42')
003200181031
003300210914     F*mcov44    if   e           k disk
003400210914     F*                                     rename(mcovr:covc44)
003500200206
003600180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003700160513
003800160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003900160513
004000160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
004100160518
004200160518     Fgrate     if   e           k disk    extfile('F.GRATE')
004300180508
004400200224     fpridetail uf a e           k disk    rename(prhr:priFile)
004500160513
004600230119     fpritrm2   uf a e           k disk    rename(pritr:termFile)
004700180523
004800200514     fmemmem    if   e           k disk    rename(memmemr:linkFile)
004900201027
005000201027     fsmoke     if   e           k disk
005100210216
005200210217     fcarplnz   if   e           k disk    rename(carplnr:planSetup)
005300200911
005400200911     ftransoff1 if   e           k disk    rename(transr:transFile)
005500201116
005600201116     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
005700200911
005800181030      *================================================================================
005900181030      *   opcode to convert yyyymmdd to mmddyyyy
006000181030      *   xxx = %editc( %dec(%char(%date(numericdate:*iso):*mdy0):8:0):'X');
006100160512      *=================================================================
006200061017
006300181101     d carrierCode     s              3
006400190308     d carrierCode1    s              3
006500190308     d carrierCode2    s              3
006600190308     d carrierCode3    s              3
006700190308     d carrierCode4    s              3
006800190308     d carrierCode5    s              3
006900181101     d grouperCode     s              2
007000200514     d mcssno2         s              9  0
007100180913     d cancelh         s              8  0
007200160519     d today           s              8  0
007300190227     d alreadySent     s              1
007400180523     d ssn             s              9  0
007500180523     d seq#            s              2  0
007600200224     d ptype           s              3
007700190227     d updateRecord    s              1
007800190227     d writeRecord     s              1
007900180523     d termdt          s              8  0
008000181113     d carrier         s              2  0
008100181105     d candtp          s              8
008200181105     d lastdate        s              8
008300181105     d error           s             20
008400200224     d pos             s              2  0
008500201116     d pos2            s              2  0
008600200825     d holdBirth       s              8  0
008700200825     d newSeq#         s              2  0
008800200825     d holdCcandt      s              8  0
008900200911     d ok_toTransmit   s              1
009000201116     d unique          s             10
009100201119     d holdClass       s              5
009200210406     d foundPlan       s              1
009300150820
009400181105     d lastday         pr                  extpgm('LSTDAY')
009500181105     d  candtp                        8
009600181105     d  lastdate                      8    const
009700181105     d  error                        20    const
009800200224
009900200514     d pri010rb        pi
010000200224     d  p_acct                        7
010100200224
010200160511      //==================================================================
010300160511      // mainline
010400160511      //===================================================================
010500150820
010600160511       exsr init;
010700160511       exsr main;
010800160511       exsr exit;
010900160511
011000181031      //===================================================================
011100181031      // main
011200181031      //===================================================================
011300181031
011400200228       begsr main;
011500190308
011600200228        setll grouperCode carrFile;
011700200228        reade grouperCode carrFile;
011800190308
011900200228        dow not %eof;
012000181101
012100200228         carrierCode = carrcd;
012200200228         exsr main2;
012300181101
012400200228        reade grouperCode carrFile;
012500200228        enddo;
012600181031
012700181031       endsr;
012800181031
012900180309      //===================================================================
013000181030      // main
013100180309      //===================================================================
013200180309
013300200228       begsr main2;
013400180309
013500180309        setll carrierCode plnmsr;
013600180309        reade carrierCode plnmsr;
013700180309
013800180309        dow not %eof;
013900180309
014000200206         setll (pltrst : plsub# : plplan) mcov42;
014100200206         reade (pltrst : plsub# : plplan) mcov42;
014200200206
014300180313         dow not %eof;
014400180309
014500180313          exsr process;
014600180309
014700200206          reade (pltrst : plsub# : plplan) mcov42;
014800180313         enddo;
014900180309
015000180309        reade carrierCode plnmsr;
015100180309        enddo;
015200180309
015300180309       endsr;
015400180309
015500160511      //===================================================================
015600160511      // process
015700160511      //===================================================================
015800160511
015900160511       begsr process;
016000160511
016100181030        chain mcssno member;
016200200514        if %found;
016300200514         if %subst(fill66:66:1) = ' ';
016400200514          leavesr;
016500200514         endif;
016600200514        endif;
016700160511
016800210914        setll (mcssno : 00 : pltrst : plsub# : plplan) covc40;
016900210914        reade (mcssno : 00 : pltrst : plsub# : plplan) covc40;
017000210914
017100210914        //setll (pltrst : plsub# : acc# : mcssno) covc44;
017200210914        //reade (pltrst : plsub# : acc# : mcssno) covc44;
017300200206
017400200206        dow not %eof;
017500200206
017600200206         if plplan = mcplan;
017700200206          exsr writeMember;
017800200206         endif;
017900200206
018000210914         //reade (pltrst : plsub# : acc# : mcssno) covc44;
018100210914         reade (mcssno : 00 : pltrst : plsub# : plplan) covc40;
018200200206        enddo;
018300210914
018400210914        setll (mcssno : 00 : pltrst : plsub#) covc41;
018500210914        reade (mcssno : 00 : pltrst : plsub#) covc41;
018600210914
018700210914        dow not %eof;
018800210914
018900210914         if plplan = mcplan;
019000210914          exsr writeMember;
019100210914         endif;
019200210914
019300210914        reade (mcssno : 00 : pltrst : plsub#) covc41;
019400210914        enddo;
019500180508
019600160511       endsr;
019700160511
019800160513      //===================================================================
019900180313      // Write Member
020000160513      //===================================================================
020100160513
020200180313       begsr writeMember;
020300180313
020400190227        updateRecord = 'N';
020500190227        writeRecord = 'N';
020600200911
020700200911        exsr checkTransmission;
020800200911        if ok_toTransmit = 'N';
020900200911         leavesr;
021000200911        endif;
021100200911
021200181102        chain
021300190227        (%char(%editc(mcssno:'X')):%editc(mcssno:'X'):
021400200224        %char(birth):mlname:mfname:mmi) priFile;
021500190227
021600190227        if %found;
021700190227         updateRecord = 'Y';
021800200224         writeRecord = 'N';
021900190227        else;
022000190227         writeRecord = 'Y';
022100200224         updateRecord = 'N';
022200190227        endif;
022300190227
022400190227        if writeRecord = 'Y';
022500200224         clear priFile;
022600190227        endif;
022700181102
022800200228         exsr getGroup;
022900200224         if pacct# = ' ';
023000200228          leavesr;
023100200228         endif;
023200200228
023300190227         if mcovtp <> 'TIN';
023400190227          exsr dependent;
023500190227         endif;
023600180523
023700160516       endsr;
023800060817
023900180913      //===================================================================
024000180913      // sub 1 from cancel date
024100180913      //===================================================================
024200180913
024300180913       begsr sub1_fromDate;
024400180913
024500181105        candtp = %char(cancelh);
024600181105        lastday(candtp : lastdate : error);
024700181105        cancelh = %dec(lastdate:8:0);
024800180913
024900180913       endsr;
025000180913
025100180523      //===================================================================
025200180523      // check termed records;
025300180523      //===================================================================
025400180523
025500180523       begsr checkTerm;
025600180523
025700180523       alreadySent = 'N';
025800180523
025900180523       if termdt > 0;
025901230119
025902230119        setgt (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
025903230119        readpe (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
025904230119        dow not %eof;
025905230119        if termdt <= ttermdt;
025906230119         alreadySent = 'Y';
025907230119         leavesr;
025908230119        endif;
025909230119        readpe (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
025910230119        enddo;
026000180523
026100200224        chain (pltrst:plsub#:acc#:ssn:seq#:plncat:plplan:termdt) termFile;
026200180523        if %found;
026300180523         alreadySent = 'Y';
026400180523         leavesr;
026500180523        endif;
026600180523
026700180523        if not %found;
026800180523         ttrst = pltrst;
026900180523          tsub# = plsub#;
027000180523           tacct = acc#;
027100180524            tssno = ssn;
027200180523             tseq# = seq#;
027300200224             ttype = plncat;
027400180523            tplan = plplan;
027500180523           ttermdt = termdt;
027600180523          ttrnsdt = %dec(%date);
027700180523         write termFile;
027800180523        endif;
027900180523
028000180523       endif;
028100180523
028200180523       endsr;
028300180524
028400160512      //===================================================================
028500160512      // process
028600160512      //===================================================================
028700160512
028800160512       begsr dependent;
028900160512
029000160512        setll mcssno depenr;
029100160512        reade mcssno depenr;
029200160512
029300160512        dow not %eof;
029400160512
029500200825        holdCcandt = ccandt;
029600200825
029700180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
029800160512        if %found;
029900180313         exsr dependentCoverage;
030000160512        endif;
030100160512
030200200514        reade mcssno depenr;
030300160512        enddo;
030400160512
030500190429       endsr;
030600160512
030700160516      //===============================================================
030800160512      // Dependent coverage
030900160512      //===============================================================
031000160513
031100180313       begsr dependentCoverage;
031200160512
031300200514        chain mcssno linkFile;
031400200514        if %found;
031500200514          mcssno2 = mmorssn;
031600200514
031700200514         setgt (mctrst:mcsub#:mcplan:mcssno) dcovr;
031800200514         readpe (mctrst:mcsub#:mcplan:mcssno) dcovr;
031900160512
032000200514         dow not %eof;
032100200514
032200200514          if birth = dbirth and (drelcd = 'RWI' or drelcd = 'RHU') and
032300200514            dpdltd = 'A';
032400200825
032500200825            holdBirth = birth;
032600181030
032700200514           exsr writeDep;
032800200514
032900200514          endif;
033000181030
033100200514         readpe (mctrst:mcsub#:mcplan:mcssno) dcovr;
033200200514         enddo;
033300200514
033400200514        endif;
033500200514
033600160512       endsr;
033700160512
033800160516      //===============================================================
033900160516      // write dependent
034000160516      //===============================================================
034100160516
034200160516       begsr writeDep;
034300180313
034400200825        exsr getDependent#;
034500200825
034600200825        //if holdCcandt = 0;
034700200825        // ccandt = 0;
034800200825        //endif;
034900200825
035000200825        //chain (mcssno2 : dpseq#) depenr;
035100200825        chain (mcssno2 : newSeq#) depenr;
035200200825        if %found;
035300200514
035400190227        updateRecord = 'N';
035500190227        writeRecord = 'N';
035600190227
035700181102        chain
035800200514        (%char(%editc(mcssno2:'X')):%editc(depss#:'X'):
035900200224        %char(dbirth):dlname:dfname:dmi) priFile;
036000190227        if %found;
036100190227         updateRecord = 'Y';
036200200224         writeRecord = 'N';
036300190227        else;
036400190227         writeRecord = 'Y';
036500200224         updateRecord = 'N';
036600190227        endif;
036700181102
036800190227        if writeRecord = 'Y';
036900200224         clear priFile;
037000190227        endif;
037100181102
037200200224         exsr getGroup;
037300200224         if pacct# = ' ';
037400200224          leavesr;
037500200224         endif;
037600200224
037700200514         pempssn = %editc(mcssno2:'X');
037800200424         pempid = ' ';
037900200224         ppssn = %editc(depss#:'X');
038000200224
038100200224         plname = dlname;
038200200224         pfname = dfname;
038300200224         pmi = dmi;
038400200224         psuffix = ' ';
038500200224         pdob = %char(dbirth);
038600200224         psex = dsex;
038700200224
038800200224         exsr relCodes;
038900200224
039000200224         padd1 = daddr1;
039100200224         padd2 = daddr2;
039200200224         pcity = dcity;
039300200224         pstate = dstate;
039400200224         pprov = ' ';
039500200424         pzip = %subst(%editc(dzip:'X'):1:5);
039600200224         pcountry = ' ';
039700200224
039800210216         phphone = ' ';
039900210216         if area > 0 and phone > 0;
040000210216          phphone = %editc(area:'X') + %editc(phone:'X');
040100210216         endif;
040200200224
040300230117         plocid = cacid4;
040400200224         psupid1 = ' ';
040500200224         psupid2 = ' ';
040600200224         psupid3 = ' ';
040700200224         psupid4 = ' ';
040800200224         psupid5 = ' ';
040900200224         psupid6 = ' ';
041000200224
041100200224         peventcd = ' ';
041200200224         peventdt = ' ';
041300200224
041400200224         pempdt = ' ';
041500200224         pelegdt = ' ';
041600201116         pemphrs = ' ';
041700200224
041800200224         pcocostdt = ' ';
041900200224         pcocoendt = ' ';
042000200224         pretdt = ' ';
042100200224         pempendt = ' ';
042200200224
042300200224         exsr determineType;
042400210216         exsr getplan;
042500200224
042600210406         if foundPlan = 'Y';
042700220203         if plncat = 'PLF' or plncat = 'PLL';
042800200224         if pcovid1 <> ptype;
042900200224          pcovid1 = 'BLF';
043000210216          pplanid1 = cpcid1;
043100200224          pcovefdt1 = %char(denrdt);
043200200224
043300200224          seq# = dpseq#;
043400200514          ssn = mcssno2;
043500200224          termdt = ccandt;
043600200224          exsr checkTerm;
043700200224          if alreadySent = 'N';
043800210217
043900210217            if cpcid2 > ' ' and pclassid = ' ';
044000210217             pclassid = cpcid2;
044100210217            endif;
044200210217
044300210216           if ccandt > 0;
044400200224            cancelh = ccandt;
044500200224             exsr sub1_fromDate;
044600200224            pcovtrmdt1 = %char(cancelh);
044700200224           endif;
044800200224
044900200224           if writeRecord = 'Y';
045000200224            write priFile;
045100200224           endif;
045200200224           if updateRecord = 'Y';
045300200224            update priFile;
045400200224           endif;
045500200224
045600200224          endif;
045700200224         endif;
045800200224         endif;
045900210406         endif;
046000200224
046100210406         if foundPlan = 'Y';
046200220203         if plncat = 'PAC' or plncat = 'PA1';
046300200224         if pcovid2 <> ptype;
046400200224          pcovid2 = 'ADD';
046500210216          pplanid2 = cpcid1;
046600200224          pcovefdt2 = %char(denrdt);
046700200224
046800200224          seq# = dpseq#;
046900200514          ssn = mcssno2;
047000200224          termdt = ccandt;
047100200224          exsr checkTerm;
047200200224          if alreadySent = 'N';
047300210217
047400210217            if cpcid2 > ' ' and pclassid = ' ';
047500210217             pclassid = cpcid2;
047600210217            endif;
047700210217
047800200224           if ccandt > 0;
047900200224            cancelh = ccandt;
048000200224             exsr sub1_fromDate;
048100200224            pcovtrmdt2 = %char(cancelh);
048200200224           endif;
048300200224
048400200224           if writeRecord = 'Y';
048500200224            write priFile;
048600200224           endif;
048700200224           if updateRecord = 'Y';
048800200224            update priFile;
048900200224           endif;
049000200224
049100200224          endif;
049200200224         endif;
049300200224         endif;
049400210406         endif;
049500200224
049600210406         if foundPlan = 'Y';
049700200424         if plncat = 'PSF';
049800200224         if pcovid3 <> ptype;
049900200224          pcovid3 = 'DLF';
050000210216          pplanid3 = cpcid1;
050100200224          pcovefdt3 = %char(denrdt);
050200200224
050300200224          seq# = dpseq#;
050400200514          ssn = mcssno2;
050500200224          termdt = ccandt;
050600200224          exsr checkTerm;
050700200224          if alreadySent = 'N';
050800210217
050900210217            if cpcid2 > ' ' and pclassid = ' ';
051000210217             pclassid = cpcid2;
051100210217            endif;
051200210217
051300200224           if ccandt > 0;
051400200224            cancelh = ccandt;
051500200224             exsr sub1_fromDate;
051600200224            pcovtrmdt3 = %char(cancelh);
051700200224           endif;
051800200224
051900200224           if writeRecord = 'Y';
052000200224            write priFile;
052100200224           endif;
052200200224           if updateRecord = 'Y';
052300200224            update priFile;
052400200224           endif;
052500200224
052600200224          endif;
052700200224         endif;
052800200224         endif;
052900210406         endif;
053000200224
053100210406         if foundPlan = 'Y';
053200200224         if plncat = 'PSL';
053300200224         if pcovid4 <> ptype;
053400200224          pcovid4 = 'EVL';
053500200224          pcovefdt4 = %char(denrdt);
053600200424          pbenamtel4 = %editc(benamt:'X');
053700200424          pbenamtap4 = %editc(benamt:'X');
053800200424          pbenperel4 = ' ';
053900210216          pplanid4 = cpcid1;
054000200224
054100201027          pnicusa = 'N';
054200201028          chain (mcssno : dpseq#) smoker;
054300201027          if %found;
054400201027           pnicusa = 'T';
054500201027          endif;
054600201027
054700200224          seq# = dpseq#;
054800200514          ssn = mcssno2;
054900200224          termdt = ccandt;
055000200224          exsr checkTerm;
055100200224          if alreadySent = 'N';
055200210217
055300210217            if cpcid2 > ' ' and pclassid = ' ';
055400210217             pclassid = cpcid2;
055500210217            endif;
055600210217
055700200224           if ccandt > 0;
055800200224            cancelh = ccandt;
055900200224             exsr sub1_fromDate;
056000200224            pcovtrmdt4 = %char(cancelh);
056100200224           endif;
056200200224
056300200224           if writeRecord = 'Y';
056400200224            write priFile;
056500200224           endif;
056600200224           if updateRecord = 'Y';
056700200224            update priFile;
056800200224           endif;
056900200224
057000200224          endif;
057100200224         endif;
057200200224         endif;
057300210406         endif;
057400200224
057500210406         if foundPlan = 'Y';
057600200224         if plncat = 'POA';
057700200224         if pcovid5 <> ptype;
057800200224          pcovid5 = 'EVA';
057900200224          pcovefdt5 = %char(enrldt);
058000210216          pplanid5 = cpcid1;
058100200224
058200200224          seq# = dpseq#;
058300200514          ssn = mcssno2;
058400200224          termdt = ccandt;
058500200224          exsr checkTerm;
058600200224          if alreadySent = 'N';
058700210217
058800210217            if cpcid2 > ' ' and pclassid = ' ';
058900210217             pclassid = cpcid2;
059000210217            endif;
059100210217
059200200224           if ccandt > 0;
059300200224            cancelh = ccandt;
059400200224             exsr sub1_fromDate;
059500200224            pcovtrmdt5 = %char(cancelh);
059600200224           endif;
059700200224
059800200224           if writeRecord = 'Y';
059900200224            write priFile;
060000200224           endif;
060100200224           if updateRecord = 'Y';
060200200224            update priFile;
060300200224           endif;
060400200224
060500200224          endif;
060600200224         endif;
060700200224         endif;
060800210406         endif;
060900200224
061000210406         if foundPlan = 'Y';
061100200224         if plncat = 'PSP';
061200200224         if pcovid6 <> ptype;
061300200514          chain mcssno2 member;
061400200514
061500200514          chain (%editc(mcssno2:'X') : %editc(mcssno2:'X') :
061600200514                 %char(birth)) priFile;
061700200514          if %found;
061800200514           pcovid6 = 'SVL';
061900200514           pcovefdt6 = %char(denrdt);
062000200514           pbenamtel6 = %editc(benamt:'X');
062100200514           pbenamtap6 = %editc(benamt:'X');
062200210216           pplanid6 = cpcid1;
062300200514
062400201027           pnicusa = 'N';
062500201028           chain (mcssno : dpseq#) smoker;
062600201027           if %found;
062700201027            pnicusa = 'T';
062800201027           endif;
062900201027
063000200514           seq# = dpseq#;
063100200514           ssn = mcssno2;
063200200514           termdt = ccandt;
063300200514           exsr checkTerm;
063400200514           if alreadySent = 'N';
063500210217
063600210217            if cpcid2 > ' ' and pclassid = ' ';
063700210217             pclassid = cpcid2;
063800210217            endif;
063900210217
064000200514            if ccandt > 0;
064100200514             cancelh = ccandt;
064200200514              exsr sub1_fromDate;
064300200514             pcovtrmdt6 = %char(cancelh);
064400200514            endif;
064500200224
064600200514            if updateRecord = 'Y';
064700200514             update priFile;
064800200514            endif;
064900200514
065000200514           endif;
065100200224
065200200514          else;
065300200514           if writeRecord = 'Y';
065400200514            write priFile;
065500200514           endif;
065600200224          endif;
065700200514
065800200224         endif;
065900200224         endif;
066000210406         endif;
066100200224
066200210406         if foundPlan = 'Y';
066300210406         if plncat = 'PSA';
066400200514         if pcovid7 <> ptype;
066500200514          chain mcssno2 member;
066600200514
066700200514          chain (%editc(mcssno2:'X') : %editc(mcssno2:'X') :
066800200514                 %char(birth)) priFile;
066900200514          if %found;
067000200514           pcovid7 = 'SVA';
067100210216           pplanid7 = cpcid1;
067200200514           pcovefdt7 = %char(denrdt);
067300200224
067400200514           seq# = dpseq#;
067500200514           ssn = mcssno2;
067600200514           termdt = ccandt;
067700200514           exsr checkTerm;
067800200514           if alreadySent = 'N';
067900210217
068000210217            if cpcid2 > ' ' and pclassid = ' ';
068100210217             pclassid = cpcid2;
068200210217            endif;
068300210217
068400200514            if ccandt > 0;
068500200514             cancelh = ccandt;
068600200514              exsr sub1_fromDate;
068700200514             pcovtrmdt7 = %char(cancelh);
068800200514            endif;
068900200224
069000200514            if updateRecord = 'Y';
069100200514             update priFile;
069200200514            endif;
069300200514
069400200514           endif;
069500200514
069600200514          else;
069700200514           if writeRecord = 'Y';
069800200514            write priFile;
069900200514           endif;
070000200514          endif;
070100200224
070200200514         endif;
070300200514         endif;
070400210406         endif;
070500200224
070600210406         if foundPlan = 'Y';
070700201116         if plncat = 'PWD' or plncat = 'PVW';
070800200224         if pcovid9 <> ptype;
070900200224          pcovid9 = 'STD';
071000200224          pcovefdt9 = %char(enrldt);
071100200424          pbenamtel9 = %editc(benamt:'X');
071200200424          pbenamtap9 = %editc(benamt:'X');
071300210216          pplanid9 = cpcid1;
071400200224
071401230119          seq# = dpseq#;
071500200514          ssn = mcssno2;
071600230119          termdt = ccandt;
071700200224          exsr checkTerm;
071800200224          if alreadySent = 'N';
071900210217
072000210217            if cpcid2 > ' ' and pclassid = ' ';
072100210217             pclassid = cpcid2;
072200210217            endif;
072300210217
072400230120           if ccandt > 0;
072500230120            cancelh = ccandt;
072600200224             exsr sub1_fromDate;
072700200224            pcovtrmdt9 = %char(cancelh);
072800200224           endif;
072900200224
073000200224           if writeRecord = 'Y';
073100200224            write priFile;
073200200224           endif;
073300200224           if updateRecord = 'Y';
073400200224            update priFile;
073500200224           endif;
073600200224
073700200224          endif;
073800210406         endif;
073900200224         endif;
074000200224         endif;
074100200224
074200210406         if foundPlan = 'Y';
074300201027         if plncat = 'PLT' or plncat = 'PVL';
074400200224         if pcovid10 <> ptype;
074500201027          pcovid10 = 'LTD';
074600200224          pcovefdt10 = %char(denrdt);
074700210216          pplanid10 = cpcid1;
074800200424          pbenamte10 = %editc(benamt:'X');
074900200424          pbenamta10 = %editc(benamt:'X');
075000200224
075100200224          seq# = dpseq#;
075200200514          ssn = mcssno2;
075300200224          termdt = ccandt;
075400200224          exsr checkTerm;
075500200224          if alreadySent = 'N';
075600210217
075700210217            if cpcid2 > ' ' and pclassid = ' ';
075800210217             pclassid = cpcid2;
075900210217            endif;
076000210217
076100200224           if ccandt > 0;
076200200224            cancelh = ccandt;
076300200224             exsr sub1_fromDate;
076400200224            pcovtrmd10 = %char(cancelh);
076500200224           endif;
076600200224
076700200224           if writeRecord = 'Y';
076800200224            write priFile;
076900200224           endif;
077000200224           if updateRecord = 'Y';
077100200224            update priFile;
077200200224           endif;
077300200224
077400200224          endif;
077500200224         endif;
077600200224         endif;
077700210406         endif;
077800200224
077900210406         if foundPlan = 'Y';
078000200224         if plncat = 'PDN';
078100200224         if pcovid11 <> ptype;
078200200224          pcovid11 = 'DEN';
078300200224          pcovefdt11 = %char(denrdt);
078400210216          pplanid11 = cpcid1;
078500200224
078600200224          seq# = dpseq#;
078700200514          ssn = mcssno2;
078800200224          termdt = ccandt;
078900200224          exsr checkTerm;
079000200224          if alreadySent = 'N';
079100210217
079200210217            if cpcid2 > ' ' and pclassid = ' ';
079300210217             pclassid = cpcid2;
079400210217            endif;
079500210217
079600200224           if ccandt > 0;
079700200224            cancelh = ccandt;
079800200224             exsr sub1_fromDate;
079900200224            pcovtrmd11 = %char(cancelh);
080000200224           endif;
080100200224
080200200224           if writeRecord = 'Y';
080300200224            write priFile;
080400200224           endif;
080500200224           if updateRecord = 'Y';
080600200224            update priFile;
080700200224           endif;
080800200224
080900200224          endif;
081000200224         endif;
081100200224         endif;
081200210406         endif;
081300200224
081400210406         if foundPlan = 'Y';
081500200224         if plncat = 'PVS';
081600200224         if pcovid12 <> ptype;
081700200224          pcovid12 = 'VIS';
081800210216          pplanid12 = cpcid1;
081900200424
082000200224          pcovefdt12 = %char(denrdt);
082100200224
082200200224          seq# = dpseq#;
082300200514          ssn = mcssno2;
082400200224          termdt = ccandt;
082500200224          exsr checkTerm;
082600200224          if alreadySent = 'N';
082700210217
082800210217            if cpcid2 > ' ' and pclassid = ' ';
082900210217             pclassid = cpcid2;
083000210217            endif;
083100210217
083200200224           if ccandt > 0;
083300200224            cancelh = ccandt;
083400200224             exsr sub1_fromDate;
083500200224            pcovtrmd12 = %char(cancelh);
083600200224           endif;
083700200224
083800200224           if writeRecord = 'Y';
083900200224            write priFile;
084000200224           endif;
084100200224           if updateRecord = 'Y';
084200200224            update priFile;
084300200224           endif;
084400200224
084500200224          endif;
084600200224         endif;
084700200224         endif;
084800210406         endif;
084900210406
085000210406         if foundPlan = 'Y';
085100200224         if plncat = 'PCC';
085200200224         if pcovid13 <> ptype;
085300200224          pcovid13 = 'ECI';
085400200224          pcovefdt13 = %char(denrdt);
085500210216          pplanid13 = cpcid1;
085600200424          pbenamte13 = %editc(benamt:'X');
085700200424          pbenamta13 = %editc(benamt:'X');
085800200224
085900200224          seq# = dpseq#;
086000200514          ssn = mcssno2;
086100200224          termdt = ccandt;
086200200224          exsr checkTerm;
086300200224          if alreadySent = 'N';
086400210217
086500210217            if cpcid2 > ' ' and pclassid = ' ';
086600210217             pclassid = cpcid2;
086700210217            endif;
086800210217
086900200224           if ccandt > 0;
087000200224            cancelh = ccandt;
087100200224             exsr sub1_fromDate;
087200200224            pcovtrmd13 = %char(cancelh);
087300200224           endif;
087400200224
087500200224           if writeRecord = 'Y';
087600200224            write priFile;
087700200224           endif;
087800200224           if updateRecord = 'Y';
087900200224            update priFile;
088000200224           endif;
088100200224
088200200224          endif;
088300200224         endif;
088400200224         endif;
088500210406         endif;
088600200224
088700210406         if foundPlan = 'Y';
088800200224         if plncat = 'PCB';
088900200224         if pcovid14 <> ptype;
089000200224          pcovid14 = 'SCI';
089100210216          pplanid14 = cpcid1;
089200200224          pcovefdt14 = %char(denrdt);
089300200424          pbenamte14 = %editc(benamt:'X');
089400200424          pbenamta14 = %editc(benamt:'X');
089500200224
089600200224          seq# = dpseq#;
089700200514          ssn = mcssno2;
089800200224          termdt = ccandt;
089900200224          exsr checkTerm;
090000200224          if alreadySent = 'N';
090100210217
090200210217            if cpcid2 > ' ' and pclassid = ' ';
090300210217             pclassid = cpcid2;
090400210217            endif;
090500210217
090600200224           if ccandt > 0;
090700200224            cancelh = ccandt;
090800200224             exsr sub1_fromDate;
090900200224            pcovtrmd14 = %char(cancelh);
091000200224           endif;
091100200224
091200200224           if writeRecord = 'Y';
091300200224            write priFile;
091400200224           endif;
091500200224           if updateRecord = 'Y';
091600200224            update priFile;
091700200224           endif;
091800200224
091900200224          endif;
092000200224         endif;
092100200224         endif;
092200210406         endif;
092300200224
092400210406         if foundPlan = 'Y';
092500200224         if plncat = 'PCG';
092600200224         if pcovid15 <> ptype;
092700200224          pcovid15 = 'CCI';
092800210216          pplanid15 = cpcid1;
092900200224          pcovefdt15 = %char(denrdt);
093000200424          pbenamte15 = %editc(benamt:'X');
093100200424          pbenamta15 = %editc(benamt:'X');
093200200224
093300200224          seq# = dpseq#;
093400200514          ssn = mcssno2;
093500200224          termdt = ccandt;
093600200224          exsr checkTerm;
093700200224          if alreadySent = 'N';
093800210217
093900210217            if cpcid2 > ' ' and pclassid = ' ';
094000210217             pclassid = cpcid2;
094100210217            endif;
094200210217
094300200224           if ccandt > 0;
094400200224            cancelh = ccandt;
094500200224             exsr sub1_fromDate;
094600200224            pcovtrmd15 = %char(cancelh);
094700200224           endif;
094800200224
094900200224           if writeRecord = 'Y';
095000200224            write priFile;
095100200224           endif;
095200200224           if updateRecord = 'Y';
095300200224            update priFile;
095400200224           endif;
095500200224
095600200224          endif;
095700200224         endif;
095800200224         endif;
095900210406         endif;
096000200224
096100210406         if foundPlan = 'Y';
096200210406         if plncat = 'PO6';
096300200224         if pcovid16 <> ptype;
096400200224          pcovid16 = 'ACC';
096500210216          pplanid16 = cpcid1;
096600210216
096700200224          pcovefdt16 = %char(denrdt);
096800200224
096900200224          seq# = dpseq#;
097000200514          ssn = mcssno2;
097100200224          termdt = ccandt;
097200200224          exsr checkTerm;
097300200224          if alreadySent = 'N';
097400210217
097500210217            if cpcid2 > ' ' and pclassid = ' ';
097600210217             pclassid = cpcid2;
097700210217            endif;
097800210217
097900200224           if ccandt > 0;
098000200224            cancelh = ccandt;
098100200224             exsr sub1_fromDate;
098200200224            pcovtrmd16 = %char(cancelh);
098300200224           endif;
098400200224
098500200224           if writeRecord = 'Y';
098600200224            write priFile;
098700200224           endif;
098800200224           if updateRecord = 'Y';
098900200224            update priFile;
099000200224           endif;
099100200224
099200200224          endif;
099300200224         endif;
099400200224         endif;
099500210406         endif;
099600200224
099700200825         endif;
099800200514
099900160516       endsr;
100000160511
100100160519      //===================================================================
100200160519      // Get group number
100300160519      //===================================================================
100400160519
100500181031       begsr getGroup;
100600160519
100700160519        setll (pltrst : plsub# : plplan) grater;
100800160519        reade (pltrst : plsub# : plplan) grater;
100900160519
101000160519        dow not %eof;
101100160519
101200160519         if today >= frmdat;
101300160519          if today <= todat;
101400200228           leave;
101500160519          else;
101600160519           group# = ' ';
101700160519          endif;
101800160519         endif;
101900160519
102000160519        reade (pltrst : plsub# : plplan) grater;
102100160519        enddo;
102200200228
102300200224        pos = %scan('-':group#);
102400200224        if pos > 0;
102500201116         pos = pos - 1;
102600200224         pacct# = %subst(group#:1:pos);
102700200224        else;
102800200224         pacct# = group#;
102900200224        endif;
103000200224
103100200224        if p_acct > ' ';
103200200224         if pacct# <> p_acct;
103300200224          pacct# = ' ';
103400200224         endif;
103500200224        endif;
103600200224
103700200228       endsr;
103800180313
103900190226      //===================================================================
104000190226      // Determine Type
104100190226      //===================================================================
104200190226
104300190226       begsr determineType;
104400190226
104500200224        ptype = ' ';
104600190226
104700200224         select;
104800220203          when plncat = 'PLF' or plncat = 'PLL';
104900200224           ptype = 'BLF';
105000200224
105100220203          when plncat = 'PAC' or plncat = 'PA1';
105200200424           ptype = 'ADD';
105300200424
105400200424          when plncat = 'PSF';
105500200224           ptype = 'DLF';
105600200224
105700200224          when plncat = 'PSL';
105800200224           ptype = 'EVL';
105900200224
106000200224          when plncat = 'POA';
106100200224           ptype = 'EVA';
106200200224
106300200224          when plncat = 'PSP';
106400200224           ptype = 'SVL';
106500200224
106600200224          when plncat = 'PSA';
106700200224           ptype = 'SVA';
106800200224
106900200224          when plncat = 'PVD';
107000200224           ptype = 'CVL';
107100200224
107200200424          when plncat = 'PSD';
107300200424           ptype = 'CVL';
107400200424
107500200224          when plncat = 'PLT';
107600200224           ptype = 'LTD';
107700201027
107800201027          when plncat = 'PVL';
107900201027           ptype = 'LTD';
108000201027
108100200224          when plncat = 'PDN';
108200200224           ptype = 'DEN';
108300200224
108400200224          when plncat = 'PVS';
108500200224           ptype = 'VIS';
108600200224
108700200224          when plncat = 'PCC';
108800200224           ptype = 'ECI';
108900200224
109000200224          when plncat = 'PCB';
109100200224           ptype = 'SCI';
109200200224
109300200224          when plncat = 'PCG';
109400200224           ptype = 'CCI';
109500200224
109600200224          when plncat = 'PO6';
109700200224           ptype = 'ACC';
109800200224
109900200424          when plncat = 'PWD';
110000200424           ptype = 'STD';
110100201027
110200201027          when plncat = 'PVW';
110300201027           ptype = 'STD';
110400200424
110500200224         endsl;
110600190226
110700190226       endsr;
110800190226
110900210216      //===================================================================
111000210216      // Determine Type
111100210216      //===================================================================
111200210216
111300210216       begsr getplan;
111400210216
111500210406        foundPlan = 'N';
111600210216
111700210217        chain (unique : pltrst : plsub# : acc# : plplan) planSetup;
111800210216        if %found;
111900210406         foundPlan = 'Y';
112000210216        endif;
112100210216
112200210216       endsr;
112300210216
112400180313      //===================================================================
112500180313      // Relationship Codes
112600180313      //===================================================================
112700180313
112800180313       begsr relCodes;
112900180313
113000200424        prel = ' ';
113100200424
113200181030        select;
113300181030         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
113400200224          prel = 'S';
113500200224
113600181030         when drelcd = 'RDA' or drelcd = 'RSO';
113700200224          prel = 'C';
113800181030
113900181030        endsl;
114000181030
114100210519        if dhndcp = '1' or dhndcp = '2' or dhndcp = '3';
114200210519         prel = 'H';
114300210519        endif;
114400210519
114500180313       endsr;
114600180424
114700200825      //===================================================================
114800200825      // get depenent #
114900200825      //===================================================================
115000200825
115100200825       begsr getDependent#;
115200200825
115300200825        newSeq# = 0;
115400200825
115500200825        setll mcssno2 depenr;
115600200825        reade mcssno2 depenr;
115700200825        dow not %eof;
115800200825
115900200825         if holdBirth = dbirth;
116000200825          newSeq# = dpseq#;
116100200825          leavesr;
116200200825         endif;
116300200825
116400200825        reade mcssno2 depenr;
116500200825        enddo;
116600200825
116700200825       endsr;
116800200825
116900200911      //===================================================================
117000200911      // check for transmission
117100200911      //===================================================================
117200200911
117300200911       begsr checkTransmission;
117400200911
117500210205        ok_toTransmit = 'Y';
117600210205
117700210205        chain (unique : pltrst : plsub# : acc#) setupFile;
117800210205        if %found;
117900210917         if castatus <> 'Y';
118000210205          ok_toTransmit = 'N';
118100210205         endif;
118200210205        endif;
118300210205
118400210205        if not %found;
118500210205         ok_toTransmit = 'N';
118600210205        endif;
118700201116
118800200911        chain (carrier : pltrst : plsub# : acc#) transFile;
118900200911        if %found;
119000200911         ok_toTransmit = 'N';
119100200911        endif;
119200200911
119300200911       endsr;
119400200911
119500160511      //===================================================================
119600160511      // exit
119700160511      //===================================================================
119800160511
119900160511       begsr exit;
120000160511
120100160511        *inlr = '1';
120200160511        return;
120300160511
120400160511       endsr;
120500160511
120600160511      //===================================================================
120700160511      // init
120800160511      //===================================================================
120900160520
121000160511       begsr init;
121100160511
121200200224        carrierCode1 = 'PFL';
121300200224        carrierCode2 = 'PFR';
121400200224        carrierCode3 = 'PRD';
121500200224        carrierCode4 = 'PRL';
121600200224        carrierCode5 = 'PVL';
121700200224        grouperCode = 'PL';
121800200911        carrier = 19;
121900201116        unique = '0000000329';
122000181031
122100160519        today = %dec(%char(%date:*iso0):8:0);
122200181105
122300160511       endsr;
122400010412
122500160511       //==============================================================
