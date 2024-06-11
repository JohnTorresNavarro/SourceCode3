000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200224      * PRI010R - Principal Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800200228      * 02/28/2020  jt    Original creation
000900200810      * 08/10/2020  jt    Change to be less hardcoding
001000201008      * 09/11/2020  jt    Changed transmission check
001100201008      * 10/08/2020  jt    Changed to new transmission check
001200201027      * 10/27/2020  jt    Added smoker flag.
001300201117      * 11/19/2020  jt    Added hours worked and class ID
001400210216      * 02/16/2021  jt    Added plan id's that were missing. Fixed phone.
001500210217      * 02/17/2021  jt    Changed class ID.
001600210519      * 05/19/2021  jt    Added handicap
001601220223      * 07/21/2021  jt    Added COBRA event date
001602220223      * 02/23/2021  jt    Added PLL and PA1 plan categories
001603230117      * 02/23/2021  jt    Added location ID
001604230424      * 04/24/2023  jt    If group rate expired before term of member, grab group #
001605230424      *                   within expiration date.
001700160513      *===========================================================================
001800160512
001900180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
002000180427     F                                     rename(accmsr:actFile)
002100180427
002200190226     Fac2mstl2  if   e           k disk    rename(accmsr2:actFile2)
002300190226
002400160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
002500160513
002600181101     Fcarmstl   if   e           k disk    extfile('F.CARMSTL')
002700181101     F                                     rename(carmsr:carrFile)
002800180412
002900210913     Fmcov41    if   e           k disk    extfile('F.MCOV41')
003000210913     f                                     rename(mcovr:covc41)
003100210913
003200210913     Fmcov40    if   e           k disk    extfile('F.MCOV40')
003300210913     F                                     rename(mcovr:covc40)
003400210913
003500210913     Fmcov42    if   e           k disk    extfile('F.MCOV42')
003600181031
003700210913     F*mcov44    if   e           k disk
003800210913     F*                                     rename(mcovr:covc44)
003900200206
004000180309     Fmember    if   e           k disk    extfile('F.MEMBER')
004100160513
004200160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
004300160513
004400160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
004500160518
004600160518     Fgrate     if   e           k disk    extfile('F.GRATE')
004700180508
004800190226     fcodes     if   e           k disk    extfile('F.CODES')
004900190226     f                                     rename(codesr:codesFile)
005000190226
005100200228     fsmoke     if   e           k disk
005200181030
005300200810     fcarplnp   if   e           k disk    rename(carplnr:planSetup)
005400200810
005500200224     fpridetail uf a e           k disk    rename(prhr:priFile)
005600160513
005700230119     fpritrm2   uf a e           k disk    rename(pritr:termFile)
005800180523
005900201008     f*transoff1 if   e           k disk    rename(transr:transFile)
006000201008
006100201008     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
006200181113
006300181030      *================================================================================
006400181030      *   opcode to convert yyyymmdd to mmddyyyy
006500181030      *   xxx = %editc( %dec(%char(%date(numericdate:*iso):*mdy0):8:0):'X');
006600160512      *=================================================================
006700061017
006800181101     d carrierCode     s              3
006900190308     d carrierCode1    s              3
007000190308     d carrierCode2    s              3
007100190308     d carrierCode3    s              3
007200190308     d carrierCode4    s              3
007300190308     d carrierCode5    s              3
007400181101     d grouperCode     s              2
007500200810     d unique          s             10
007600200810     d foundPlan       s              1
007700180913     d cancelh         s              8  0
007800160519     d today           s              8  0
007900190227     d alreadySent     s              1
008000180523     d ssn             s              9  0
008100180523     d seq#            s              2  0
008200200224     d ptype           s              3
008300190227     d updateRecord    s              1
008400190227     d writeRecord     s              1
008500180523     d termdt          s              8  0
008600190401     d ok_toTransmit   s              1
008700200228     d tier            s              1
008800181113     d carrier         s              2  0
008900200224     d pos             s              2  0
009000201116     d pos2            s              2  0
009100200424     d size            s              1  0
009200200424     d salaryHold      s             15
009300200810     d outDate         s              8
009400201117     d holdClass       s              5
009500210913     d dateMinus1      s               d
009600150820
009700200810     d lastday         pr                  extpgm('LASTDAY2')
009800200810     d  ctrust                        3    const
009900200810     d  csub                          3    const
010000200810     d  cplan                         4    const
010100200810     d  inDate                        8    const
010200200810     d  outDate                       8    const
010300200810
010400200224     d pri010r         pi
010500200224     d  p_acct                        7
010600200224
010700160511      //==================================================================
010800160511      // mainline
010900160511      //===================================================================
011000150820
011100160511       exsr init;
011200160511       exsr main;
011300210917       exsr exit;
011400160511
011500181031      //===================================================================
011600181031      // main
011700181031      //===================================================================
011800181031
011900200228       begsr main;
012000190308
012100200228        setll grouperCode carrFile;
012200200228        reade grouperCode carrFile;
012300190308
012400200228        dow not %eof;
012500181101
012600200228         carrierCode = carrcd;
012700200228         exsr main2;
012800181101
012900200228        reade grouperCode carrFile;
013000200228        enddo;
013100181031
013200181031       endsr;
013300181031
013400180309      //===================================================================
013500181030      // main
013600180309      //===================================================================
013700180309
013800200228       begsr main2;
013900180309
014000180309        setll carrierCode plnmsr;
014100180309        reade carrierCode plnmsr;
014200180309
014300180309        dow not %eof;
014400210913         setll (pltrst : plsub# : plplan) mcov42;
014500210913         reade (pltrst : plsub# : plplan) mcov42;
014600200206
014700180313         dow not %eof;
014800180309
014900180313          exsr process;
015000180309
015100210913          reade (pltrst : plsub# : plplan) mcov42;
015200180313         enddo;
015300180309
015400180309        reade carrierCode plnmsr;
015500180309        enddo;
015600180309
015700180309       endsr;
015800180309
015900160511      //===================================================================
016000160511      // process
016100160511      //===================================================================
016200160511
016300160511       begsr process;
016400160511
016500181030        chain mcssno member;
016600200514        if %found;
016700200514         if %subst(fill66:66:1) = 'Y';
016800200514          leavesr;
016900200514         endif;
017000200514        endif;
017100160511
017200210913         setll (mbssno : 00 : pltrst : plsub# : plplan) covc40;
017300210913         reade (mbssno : 00 : pltrst : plsub# : plplan) covc40;
017400210913
017500210913        //setll (pltrst : plsub# : acc# : mcssno) covc44;
017600210913        //reade (pltrst : plsub# : acc# : mcssno) covc44;
017700200206
017800200206        dow not %eof;
017900200206
018000200206         if plplan = mcplan;
018100200206          exsr writeMember;
018200200206         endif;
018300200206
018400210913         //reade (pltrst : plsub# : acc# : mcssno) covc44;
018500210913         reade (mbssno : 00 : pltrst : plsub# : plplan) covc40;
018600200206        enddo;
018700180508
018800210913        setll (mbssno : 00 : pltrst : plsub#) covc41;
018900210913        reade (mbssno : 00 : pltrst : plsub#) covc41;
019000210913
019100210913        dow not %eof;
019200210913
019300210913         if plplan = mcplan;
019400210913          exsr writeMember;
019500210913         endif;
019600210913
019700210913        reade (mbssno : 00 : pltrst : plsub#) covc41;
019800210913        enddo;
019900210913
020000160511       endsr;
020100160511
020200160513      //===================================================================
020300180313      // Write Member
020400160513      //===================================================================
020500160513
020600180313       begsr writeMember;
020700180313
020800190227        updateRecord = 'N';
020900190227        writeRecord = 'N';
021000190227
021100181128        exsr checkTransmission;
021200190401        if ok_toTransmit = 'N';
021300181128         leavesr;
021400181128        endif;
021500181113
021600181102        chain
021700190227        (%char(%editc(mcssno:'X')):%editc(mcssno:'X'):
021800200224        %char(birth):mlname:mfname:mmi) priFile;
021900190227
022000190227        if %found;
022100190227         updateRecord = 'Y';
022200200224         writeRecord = 'N';
022300190227        else;
022400190227         writeRecord = 'Y';
022500200224         updateRecord = 'N';
022600190227        endif;
022700190227
022800190227        if writeRecord = 'Y';
022900200224         clear priFile;
023000190227        endif;
023100181102
023600200228
023700200228         pempssn = %editc(mcssno:'X');
023800200424         pempid = ' ';
023900200224         ppssn = %editc(mcssno:'X');
024000200228
024100200224         plname = mlname;
024200200224         pfname = mfname;
024300200228         pmi = mmi;
024400200228         psuffix = ' ';
024500200228         pdob = %char(birth);
024600200224         psex = sex;
024700200224         prel = 'E';
024800200224
024900200224         padd1 = addr1;
025000200224         padd2 = addr2;
025100200224         pcity = city;
025200200224         pstate = state;
025300200224         pprov = ' ';
025400200424         pzip = %subst(%editc(zip:'X'):1:5);
025500200224         pcountry = ' ';
025600200224
025700210216         phphone = ' ';
025800210216         if area > 0 and phone > 0;
025900210216          phphone = %editc(area:'X') + %editc(phone:'X');
026000210216         endif;
026100210216
026200200514         pemail = %subst(fill66:1:65);
026300200224
026400230117         plocid = cacid4;
026500200224         psupid1 = ' ';
026600200224         psupid2 = ' ';
026700200224         psupid3 = ' ';
026800200224         psupid4 = ' ';
026900200224         psupid5 = ' ';
027000200224         psupid6 = ' ';
027100200224
027200200224         peventcd = ' ';
027300200224         peventdt = ' ';
027400200224
027500200224         if empdt > 0;
027600200224          pempdt = %char(empdt);
027700200224         endif;
027800200224         pelegdt = ' ';
027900201116         pemphrs = '4000';
028000200224
028100200224         pcocostdt = ' ';
028200200224         pcocoendt = ' ';
028300200224         pretdt = ' ';
028301210917
028302210921         pempendt = ' ';
028303210917         if termdt > 0;
028400210917          pempendt = %char(termdt);
028401210917         endif;
028500200224
028600200224         exsr determineType;
028700200810         exsr getplan;
028800200224
028900200228         chain (pltrst : plsub# : acc#) actFile2;
029000190226         if %found;
029100200228          //dtaxid# = %char(a2tax_id#);
029200190226         endif;
029300190226
029400200810         if foundPlan = 'Y';
029500220223         if plncat = 'PLF' or plncat = 'PLL';
029600200224         if pcovid1 <> ptype;
029700200224          pcovid1 = 'BLF';
029800200810          pplanid1 = cpcid1;
029900210217
030000200224          pcovefdt1 = %char(enrldt);
030100200424
030200200224          if salary > 0;
030300200424           exsr formatSalary;
030400200424            pempsala1 = salaryHold;
030500200424           pempsalm1 = 'A';
030600200224          endif;
030700200224
030800200224          if empdt > 0;
030900200224           pempsaedt1 = %char(empdt);
031000200224          endif;
031100200224
031200200224          ssn = mcssno;
031300200224          termdt = candt;
031301230119          seq# = 0;
031400200228          exsr checkTerm;
031500200228          if alreadySent = 'N';
031600210217
031700210217            if cpcid2 > ' ' and pclassid = ' ';
031800210217             pclassid = cpcid2;
031900210217            endif;
032000210217
032100200228           if candt > 0;
032200200228            cancelh = candt;
032300200810             exsr get_planDate;
032400200224            pcovtrmdt1 = %char(cancelh);
032500200228           endif;
032600200228
032601230424           exsr getGroup;
032602230424           if pacct# = ' ';
032603230424            leavesr;
032604230424           endif;
032605230424
032700200228           if writeRecord = 'Y';
032800200224            write priFile;
032900200228           endif;
033000200228           if updateRecord = 'Y';
033100200224            update priFile;
033200200228           endif;
033300200224
033400200228          endif;
033500200228         endif;
033600200224         endif;
033700200810         endif;
033800200810
033900200810         if foundPlan = 'Y';
034000220223         if plncat = 'PAC' or plncat = 'PA1';
034100200224         if pcovid2 <> ptype;
034200200224          pcovid2 = 'ADD';
034300200810          pplanid2 = cpcid1;
034400200224          pcovefdt2 = %char(enrldt);
034500200224
034600200224          ssn = mcssno;
034700200224          termdt = candt;
034701230119          seq# = 0;
034800200224          exsr checkTerm;
034900200224          if alreadySent = 'N';
035000210217
035100210217            if cpcid2 > ' ' and pclassid = ' ';
035200210217             pclassid = cpcid2;
035300210217            endif;
035400210217
035500200224           if candt > 0;
035600200224            cancelh = candt;
035700200810             exsr get_planDate;
035800200224            pcovtrmdt2 = %char(cancelh);
035900200224           endif;
036000200224
036001230424           exsr getGroup;
036002230424           if pacct# = ' ';
036003230424            leavesr;
036004230424           endif;
036005230424
036100200224           if writeRecord = 'Y';
036200200224            write priFile;
036300200224           endif;
036400200224           if updateRecord = 'Y';
036500200224            update priFile;
036600200224           endif;
036700200224
036800200224          endif;
036900200224         endif;
037000200224         endif;
037100200810         endif;
037200200224
037300200810         if foundPlan = 'Y';
037400200424         if plncat = 'PSF';
037500200224         if pcovid3 <> ptype;
037600200224          pcovid3 = 'DLF';
037700210216          pplanid3 = cpcid1;
037800200224          pcovefdt3 = %char(enrldt);
037900200224
038000200224          ssn = mcssno;
038100200224          termdt = candt;
038101230119          seq# = 0;
038200200224          exsr checkTerm;
038300200224          if alreadySent = 'N';
038400210217
038500210217            if cpcid2 > ' ' and pclassid = ' ';
038600210217             pclassid = cpcid2;
038700210217            endif;
038800210217
038900200224           if candt > 0;
039000200224            cancelh = candt;
039100200810             exsr get_planDate;
039200200224            pcovtrmdt3 = %char(cancelh);
039300200224           endif;
039400200224
039401230424           exsr getGroup;
039402230424           if pacct# = ' ';
039403230424            leavesr;
039404230424           endif;
039405230424
039500200224           if writeRecord = 'Y';
039600200224            write priFile;
039700200224           endif;
039800200224           if updateRecord = 'Y';
039900200224            update priFile;
040000200224           endif;
040100200224
040200200224          endif;
040300200224         endif;
040400200224         endif;
040500200810         endif;
040600200228
040700200810         if foundPlan = 'Y';
040800200224         if plncat = 'PSL';
040900200224         if pcovid4 <> ptype;
041000200224          pcovid4 = 'EVL';
041100200224          pcovefdt4 = %char(enrldt);
041200200424          pbenamtel4 = %editc(benamt:'X');
041300200424          pbenamtap4 = %editc(benamt:'X');
041400200424          pbenperel4 = ' ';
041500200810          pplanid4 = cpcid1;
041600200224
041700201009          pnicusa = 'N';
041800201009          chain mcssno smoker;
041900201009          if %found;
042000201009           pnicusa = 'T';
042100201009          endif;
042200201009
042300200224          if salary > 0;
042400200424           exsr formatSalary;
042500200424            pempsala4 = salaryHold;
042600200224           pempsalm4 = 'A';
042700200224          endif;
042800200224
042900200224          if empdt > 0;
043000200224           pempsaedt4 = %char(empdt);
043100200224          endif;
043200200224
043300200224          ssn = mcssno;
043400200224          termdt = candt;
043401230119          seq# = 0;
043500200224          exsr checkTerm;
043600200224          if alreadySent = 'N';
043700210217
043800210217            if cpcid2 > ' ' and pclassid = ' ';
043900210217             pclassid = cpcid2;
044000210217            endif;
044100210217
044200200224           if candt > 0;
044300200224            cancelh = candt;
044400200810             exsr get_planDate;
044500200224            pcovtrmdt4 = %char(cancelh);
044600200224           endif;
044700200224
044701230424           exsr getGroup;
044702230424           if pacct# = ' ';
044703230424            leavesr;
044704230424           endif;
044705230424
044800200224           if writeRecord = 'Y';
044900200224            write priFile;
045000200224           endif;
045100200224           if updateRecord = 'Y';
045200200224            update priFile;
045300200224           endif;
045400200224
045500200224          endif;
045600200224         endif;
045700200224         endif;
045800200810         endif;
045900200224
046000200810         if foundPlan = 'Y';
046100200224         if plncat = 'POA';
046200200224         if pcovid5 <> ptype;
046300200224          pcovid5 = 'EVA';
046400200224          pcovefdt5 = %char(enrldt);
046500200810          pplanid5 = cpcid1;
046600200224
046700200224          ssn = mcssno;
046800200224          termdt = candt;
046801230119          seq# = 0;
046900200224          exsr checkTerm;
047000200224          if alreadySent = 'N';
047100210217
047200210217            if cpcid2 > ' ' and pclassid = ' ';
047300210217             pclassid = cpcid2;
047400210217            endif;
047500210217
047600200224           if candt > 0;
047700200224            cancelh = candt;
047800200810             exsr get_planDate;
047900200224            pcovtrmdt5 = %char(cancelh);
048000200224           endif;
048100200224
048101230424           exsr getGroup;
048102230424           if pacct# = ' ';
048103230424            leavesr;
048104230424           endif;
048105230424
048200200224           if writeRecord = 'Y';
048300200224            write priFile;
048400200224           endif;
048500200224           if updateRecord = 'Y';
048600200224            update priFile;
048700200224           endif;
048800200224
048900200224          endif;
049000200224         endif;
049100200224         endif;
049200200810         endif;
049300200224
049400200810         if foundPlan = 'Y';
049500200224         if plncat = 'PSP';
049600200224         if pcovid6 <> ptype;
049700200224          pcovid6 = 'SVL';
049800200224          pcovefdt6 = %char(enrldt);
049900200424          pbenamtel6 = %editc(benamt:'X');
050000200424          pbenamtap6 = %editc(benamt:'X');
050100200810          pplanid6 = cpcid1;
050200200224
050300201027          pnicusa = 'N';
050400201027          chain mcssno smoker;
050500201027          if %found;
050600201027           pnicusa = 'T';
050700201027          endif;
050800201027
050900200224          ssn = mcssno;
051000200224          termdt = candt;
051001230119          seq# = 0;
051100200224          exsr checkTerm;
051200200224          if alreadySent = 'N';
051300210217
051400210217            if cpcid2 > ' ' and pclassid = ' ';
051500210217             pclassid = cpcid2;
051600210217            endif;
051700210217
051800200224           if candt > 0;
051900200224            cancelh = candt;
052000200810             exsr get_planDate;
052100200224            pcovtrmdt6 = %char(cancelh);
052200200224           endif;
052300200224
052301230424           exsr getGroup;
052302230424           if pacct# = ' ';
052303230424            leavesr;
052304230424           endif;
052305230424
052400200224           if writeRecord = 'Y';
052500200224            write priFile;
052600200224           endif;
052700200224           if updateRecord = 'Y';
052800200224            update priFile;
052900200224           endif;
053000200224
053100200224          endif;
053200200224         endif;
053300200224         endif;
053400200810         endif;
053500200224
053600200810         if foundPlan = 'Y';
053700200224         if plncat = 'PSA';
053800200224         if pcovid7 <> ptype;
053900200224          pcovid7 = 'SVA';
054000200810          pplanid7 = cpcid1;
054100200224          pcovefdt7 = %char(enrldt);
054200200224
054300200224          ssn = mcssno;
054400200224          termdt = candt;
054401230119          seq# = 0;
054500200224          exsr checkTerm;
054600200224          if alreadySent = 'N';
054700210217
054800210217            if cpcid2 > ' ' and pclassid = ' ';
054900210217             pclassid = cpcid2;
055000210217            endif;
055100210217
055200200224           if candt > 0;
055300200224            cancelh = candt;
055400200810             exsr get_planDate;
055500200224            pcovtrmdt7 = %char(cancelh);
055600200224           endif;
055700200224
055701230424           exsr getGroup;
055702230424           if pacct# = ' ';
055703230424            leavesr;
055704230424           endif;
055705230424
055800200224           if writeRecord = 'Y';
055900200224            write priFile;
056000200224           endif;
056100200224           if updateRecord = 'Y';
056200200224            update priFile;
056300200224           endif;
056400200224
056500200224          endif;
056600200224         endif;
056700200224         endif;
056800200810         endif;
056900200224
057000200810         if foundPlan = 'Y';
057100200424         if plncat = 'PVD' or plncat = 'PSD';
057200200224         if pcovid8 <> ptype;
057300200224          pcovid8 = 'CVL';
057400200224          pcovefdt8 = %char(enrldt);
057500200424          pbenamtel8 = %editc(benamt:'X');
057600200424          pbenamtap8 = %editc(benamt:'X');
057700200810          pplanid8 = cpcid1;
057800210217
057900200224          ssn = mcssno;
058000200224          termdt = candt;
058001230119          seq# = 0;
058100200224          exsr checkTerm;
058200200224          if alreadySent = 'N';
058300210217
058400210217            if cpcid2 > ' ' and pclassid = ' ';
058500210217             pclassid = cpcid2;
058600210217            endif;
058700210217
058800200224           if candt > 0;
058900200224            cancelh = candt;
059000200810             exsr get_planDate;
059100200224            pcovtrmdt8 = %char(cancelh);
059200200224           endif;
059300200224
059301230424           exsr getGroup;
059302230424           if pacct# = ' ';
059303230424            leavesr;
059304230424           endif;
059305230424
059400200224           if writeRecord = 'Y';
059500200224            write priFile;
059600200224           endif;
059700200224           if updateRecord = 'Y';
059800200224            update priFile;
059900200224           endif;
060000200224
060100200224          endif;
060200200224         endif;
060300200224         endif;
060400200810         endif;
060500200224
060600200810         if foundPlan = 'Y';
060700200224         if plncat = 'PWD';
060800200224         if pcovid9 <> ptype;
060900200224          pcovid9 = 'STD';
061000200224          pcovefdt9 = %char(enrldt);
061100200424          pbenamtel9 = %editc(benamt:'X');
061200200424          pbenamtap9 = %editc(benamt:'X');
061300200810          pplanid9 = cpcid1;
061400200424
061500200224          if salary > 0;
061600200424           exsr formatSalary;
061700200424            pempsala9 = salaryHold;
061800200224           pempsalm9 = 'A';
061900200224          endif;
062000200224
062100200224          if empdt > 0;
062200200424           pempsaedt9 = %char(empdt);
062300200224          endif;
062400200224
062500200224          ssn = mcssno;
062600200224          termdt = candt;
062601230119          seq# = 0;
062700200224          exsr checkTerm;
062800200224          if alreadySent = 'N';
062900210217
063000210217            if cpcid2 > ' ' and pclassid = ' ';
063100210217             pclassid = cpcid2;
063200210217            endif;
063300210217
063400200224           if candt > 0;
063500200224            cancelh = candt;
063600200810             exsr get_planDate;
063700200224            pcovtrmdt9 = %char(cancelh);
063800200224           endif;
063900200224
063901230424           exsr getGroup;
063902230424           if pacct# = ' ';
063903230424            leavesr;
063904230424           endif;
063905230424
064000200224           if writeRecord = 'Y';
064100200224            write priFile;
064200200224           endif;
064300200224           if updateRecord = 'Y';
064400200224            update priFile;
064500200224           endif;
064600200224
064700200224          endif;
064800200224         endif;
064900200224         endif;
065000200810         endif;
065100200224
065200200810         if foundPlan = 'Y';
065300201009         if plncat = 'PLT' or plncat = 'PVL';
065400200224         if pcovid10 <> ptype;
065500200224          pcovid10 = 'LTD';
065600200810          pplanid10 = cpcid1;
065700200424
065800200224          pcovefdt10 = %char(enrldt);
065900200224
066000200224          if salary > 0;
066100200424           exsr formatSalary;
066200200424            pempsala10 = salaryHold;
066300200224           pempsalm10 = 'A';
066400200224          endif;
066500200224
066600200224          if empdt > 0;
066700200224           pempsaed10 = %char(empdt);
066800200224          endif;
066900200224
067000200224          ssn = mcssno;
067100200224          termdt = candt;
067101230119          seq# = 0;
067200200224          exsr checkTerm;
067300200224          if alreadySent = 'N';
067400210217
067500210217            if cpcid2 > ' ' and pclassid = ' ';
067600210217             pclassid = cpcid2;
067700210217            endif;
067800210217
067900200224           if candt > 0;
068000200224            cancelh = candt;
068100200810             exsr get_planDate;
068200200224            pcovtrmd10 = %char(cancelh);
068300200224           endif;
068400200224
068401230424           exsr getGroup;
068402230424           if pacct# = ' ';
068403230424            leavesr;
068404230424           endif;
068405230424
068500200224           if writeRecord = 'Y';
068600200224            write priFile;
068700200224           endif;
068800200224           if updateRecord = 'Y';
068900200224            update priFile;
069000200224           endif;
069100200224
069200200224          endif;
069300200224         endif;
069400200224         endif;
069500200810         endif;
069600200224
069700200810         if foundPlan = 'Y';
069800200224         if plncat = 'PDN';
069900200224         if pcovid11 <> ptype;
070000200224          pcovid11 = 'DEN';
070001210917
070100200224          pcovefdt11 = %char(enrldt);
070101210917
070102210917          if empst  = 'C' and qedt > 0;
070103210917           pcovefdt11 = %char(qedt);
070104210917           pcocostdt = %char(qedt);
070105210917          endif;
070106210917
070200210217          pplanid11 = cpcid1;
070300200224
070400200224          ssn = mcssno;
070500200224          termdt = candt;
070501230119          seq# = 0;
070600200224          exsr checkTerm;
070700200224          if alreadySent = 'N';
070800210217
070900210217            if cpcid2 > ' ' and pclassid = ' ';
071000210217             pclassid = cpcid2;
071100210217            endif;
071200210217
071300200224           if candt > 0;
071400200224            cancelh = candt;
071500200810             exsr get_planDate;
071600200224            pcovtrmd11 = %char(cancelh);
071700200224           endif;
071800200224
071801230424           exsr getGroup;
071802230424           if pacct# = ' ';
071803230424            leavesr;
071804230424           endif;
071805230424
071900200224           if writeRecord = 'Y';
072000200224            write priFile;
072100200224           endif;
072200200224           if updateRecord = 'Y';
072300200224            update priFile;
072400200224           endif;
072500200224
072600200224          endif;
072700200224         endif;
072800200224         endif;
072900200810         endif;
073000200224
073100200810         if foundPlan = 'Y';
073200200224         if plncat = 'PVS';
073300200224         if pcovid12 <> ptype;
073400200224          pcovid12 = 'VIS';
073500200810          pplanid12 = cpcid1;
073600200424
073700200224          pcovefdt12 = %char(enrldt);
073701210917
073703210917          if empst  = 'C' and qedt > 0;
073704210917           pcocostdt = %char(qedt);
073705210917           pcovefdt12 = %char(qedt);
073706210917          endif;
073800200224
073900200224          ssn = mcssno;
074000200224          termdt = candt;
074001230119          seq# = 0;
074100200224          exsr checkTerm;
074200200224          if alreadySent = 'N';
074300210217
074400210217            if cpcid2 > ' ' and pclassid = ' ';
074500210217             pclassid = cpcid2;
074600210217            endif;
074700210217
074800200224           if candt > 0;
074900200224            cancelh = candt;
075000200810             exsr get_planDate;
075100200224            pcovtrmd12 = %char(cancelh);
075200200224           endif;
075300200224
075301230424           exsr getGroup;
075302230424           if pacct# = ' ';
075303230424            leavesr;
075304230424           endif;
075305230424
075400200224           if writeRecord = 'Y';
075500200224            write priFile;
075600200224           endif;
075700200224           if updateRecord = 'Y';
075800200224            update priFile;
075900200224           endif;
076000200224
076100200224          endif;
076200200224         endif;
076300200224         endif;
076400200810         endif;
076500200224
076600200810         if foundPlan = 'Y';
076700200224         if plncat = 'PCC';
076800200224         if pcovid13 <> ptype;
076900200224          pcovid13 = 'ECI';
077000210216          pplanid13 = cpcid1;
077100200224          pcovefdt13 = %char(enrldt);
077200200424          pbenamte13 = %editc(benamt:'X');
077300200424          pbenamta13 = %editc(benamt:'X');
077400200224
077500200224          ssn = mcssno;
077600200224          termdt = candt;
077601230119          seq# = 0;
077700200224          exsr checkTerm;
077800200224          if alreadySent = 'N';
077900210217
078000210217            if cpcid2 > ' ' and pclassid = ' ';
078100210217             pclassid = cpcid2;
078200210217            endif;
078300210217
078400200224           if candt > 0;
078500200224            cancelh = candt;
078600200810             exsr get_planDate;
078700200224            pcovtrmd13 = %char(cancelh);
078800200224           endif;
078900200224
078901230424           exsr getGroup;
078902230424           if pacct# = ' ';
078903230424            leavesr;
078904230424           endif;
078905230424
079000200224           if writeRecord = 'Y';
079100200224            write priFile;
079200200224           endif;
079300200224           if updateRecord = 'Y';
079400200224            update priFile;
079500200224           endif;
079600200224
079700200224          endif;
079800200224         endif;
079900200224         endif;
080000200810         endif;
080100200224
080200200810         if foundPlan = 'Y';
080300200224         if plncat = 'PCB';
080400200224         if pcovid14 <> ptype;
080500200224          pcovid14 = 'SCI';
080600210216          pplanid14 = cpcid1;
080700200224          pcovefdt14 = %char(enrldt);
080800200424          pbenamte14 = %editc(benamt:'X');
080900200424          pbenamta14 = %editc(benamt:'X');
081000200224
081100200224          ssn = mcssno;
081200200224          termdt = candt;
081201230119          seq# = 0;
081300200224          exsr checkTerm;
081400200224          if alreadySent = 'N';
081500210217
081600210217            if cpcid2 > ' ' and pclassid = ' ';
081700210217             pclassid = cpcid2;
081800210217            endif;
081900210217
082000200224           if candt > 0;
082100200224            cancelh = candt;
082200200810             exsr get_planDate;
082300200224            pcovtrmd14 = %char(cancelh);
082400200224           endif;
082500200224
082501230424           exsr getGroup;
082502230424           if pacct# = ' ';
082503230424            leavesr;
082504230424           endif;
082505230424
082600200224           if writeRecord = 'Y';
082700200224            write priFile;
082800200224           endif;
082900200224           if updateRecord = 'Y';
083000200224            update priFile;
083100200224           endif;
083200200224
083300200224          endif;
083400200224         endif;
083500200224         endif;
083600200810         endif;
083700200224
083800200810         if foundPlan = 'Y';
083900200224         if plncat = 'PCG';
084000200224         if pcovid15 <> ptype;
084100200224          pcovid15 = 'CCI';
084200210216          pplanid15 = cpcid1;
084300210216
084400200224          pcovefdt15 = %char(enrldt);
084500200424          pbenamte15 = %editc(benamt:'X');
084600200424          pbenamta15 = %editc(benamt:'X');
084700200224
084800200224          ssn = mcssno;
084900200224          termdt = candt;
084901230119          seq# = 0;
085000200224          exsr checkTerm;
085100200224          if alreadySent = 'N';
085200210217
085300210217            if cpcid2 > ' ' and pclassid = ' ';
085400210217             pclassid = cpcid2;
085500210217            endif;
085600210217
085700200224           if candt > 0;
085800200224            cancelh = candt;
085900200810             exsr get_planDate;
086000200224            pcovtrmd15 = %char(cancelh);
086100200224           endif;
086200200224
086201230424           exsr getGroup;
086202230424           if pacct# = ' ';
086203230424            leavesr;
086204230424           endif;
086205230424
086300200224           if writeRecord = 'Y';
086400200224            write priFile;
086500200224           endif;
086600200224           if updateRecord = 'Y';
086700200224            update priFile;
086800200224           endif;
086900200224
087000200224          endif;
087100200224         endif;
087200200224         endif;
087300200810         endif;
087400200224
087500200810         if foundPlan = 'Y';
087600200224         if plncat = 'PO6';
087700200224         if pcovid16 <> ptype;
087800200224          pcovid16 = 'ACC';
087900210216          pplanid16 = cpcid1;
088000210216
088100200224          pcovefdt16 = %char(enrldt);
088200200224
088300200224          ssn = mcssno;
088400200224          termdt = candt;
088401230119          seq# = 0;
088500200224          exsr checkTerm;
088600200224          if alreadySent = 'N';
088700210217
088800210217            if cpcid2 > ' ' and pclassid = ' ';
088900210217             pclassid = cpcid2;
089000210217            endif;
089100210217
089200200224           if candt > 0;
089300200224            cancelh = candt;
089400200810             exsr get_planDate;
089500200224            pcovtrmd16 = %char(cancelh);
089600200224           endif;
089700200224
089701230424           exsr getGroup;
089702230424           if pacct# = ' ';
089703230424            leavesr;
089704230424           endif;
089705230424
089800200224           if writeRecord = 'Y';
089900200224            write priFile;
090000200224           endif;
090100200224           if updateRecord = 'Y';
090200200224            update priFile;
090300200224           endif;
090400200224
090500200224          endif;
090600200224         endif;
090700200224         endif;
090800200810         endif;
090900200224
091000190227         if mcovtp <> 'TIN';
091100190227          exsr dependent;
091200190227         endif;
091300180523
091400160516       endsr;
091500060817
091600180913      //===================================================================
091700200810      // get canceled date according to plan setup
091800180913      //===================================================================
091900180913
092000200810       begsr get_planDate;
092100180913
092200210913        //lastday(%char(pltrst):%char(plsub#):tplan:%char(cancelh):outDate);
092300210913        //cancelh = %dec(outDate:8:0);
092400210913
092500210913        dateMinus1 = %date(cancelh);
092600210913        dateMinus1 = dateMinus1 - %days(1);
092700210913        cancelh = %dec(dateMinus1);
092800180913
092900180913       endsr;
093000180913
093100201009      //===================================================================
093200180523      // check termed records;
093300180523      //===================================================================
093400180523
093500180523       begsr checkTerm;
093600180523
093700180523       alreadySent = 'N';
093800180523
093900180523       if termdt > 0;
093901230119
093902230119        setgt (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
093903230119        readpe (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
093904230119        dow not %eof;
093905230119        if termdt <= ttermdt;
093906230119         alreadySent = 'Y';
093907230119         leavesr;
093908230119        endif;
093909230119        readpe (pltrst:plsub#:acc#:ssn:seq#:plncat) termFile;
093910230119        enddo;
094000180523
094100200224        chain (pltrst:plsub#:acc#:ssn:seq#:plncat:plplan:termdt) termFile;
094200180523        if %found;
094300180523         alreadySent = 'Y';
094400180523         leavesr;
094500180523        endif;
094600180523
094700180523        if not %found;
094800180523         ttrst = pltrst;
094900180523          tsub# = plsub#;
095000180523           tacct = acc#;
095100180524            tssno = ssn;
095200180523             tseq# = seq#;
095300200224             ttype = plncat;
095400180523            tplan = plplan;
095500180523           ttermdt = termdt;
095600180523          ttrnsdt = %dec(%date);
095700180523         write termFile;
095800180523        endif;
095900180523
096000180523       endif;
096100180523
096200180523       endsr;
096300180524
096400160512      //===================================================================
096500160512      // process
096600160512      //===================================================================
096700160512
096800160512       begsr dependent;
096900160512
097000160512        setll mcssno depenr;
097100160512        reade mcssno depenr;
097200160512
097300160512        dow not %eof;
097400160512
097500180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
097600160512        if %found;
097700180313         exsr dependentCoverage;
097800160512        endif;
097900160512
098000160512        reade mcssno depenr;
098100160512        enddo;
098200160512
098300190429       endsr;
098400160512
098500160516      //===============================================================
098600160512      // Dependent coverage
098700160512      //===============================================================
098800160513
098900180313       begsr dependentCoverage;
099000160512
099100180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
099200180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
099300160512
099400160512        dow not %eof;
099500181030
099600181030         exsr writeDep;
099700181030
099800180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
099900160512        enddo;
100000160512
100100160512       endsr;
100200160512
100300160516      //===============================================================
100400160516      // write dependent
100500160516      //===============================================================
100600160516
100700160516       begsr writeDep;
100800180313
100900190227        updateRecord = 'N';
101000190227        writeRecord = 'N';
101100190227
101200181102        chain
101300190227        (%char(%editc(mcssno:'X')):%editc(depss#:'X'):
101400200224        %char(dbirth):dlname:dfname:dmi) priFile;
101500190227        if %found;
101600190227         updateRecord = 'Y';
101700200224         writeRecord = 'N';
101800190227        else;
101900190227         writeRecord = 'Y';
102000200224         updateRecord = 'N';
102100190227        endif;
102200181102
102300190227        if writeRecord = 'Y';
102400200224         clear priFile;
102500190227        endif;
102600181102
103200200224         pempssn = %editc(mcssno:'X');
103300200424         pempid = ' ';
103400200224         ppssn = %editc(depss#:'X');
103500200224
103600200224         plname = dlname;
103700200224         pfname = dfname;
103800200224         pmi = dmi;
103900200224         psuffix = ' ';
104000200224         pdob = %char(dbirth);
104100200224         psex = dsex;
104200200224
104300200224         exsr relCodes;
104400200224
104500200224         padd1 = daddr1;
104600200224         padd2 = daddr2;
104700200224         pcity = dcity;
104800200224         pstate = dstate;
104900200224         pprov = ' ';
105000200424         pzip = %subst(%editc(dzip:'X'):1:5);
105100200224         pcountry = ' ';
105200200224
105300210216         phphone = ' ';
105400210216         if area > 0 and phone > 0;
105500210216          phphone = %editc(area:'X') + %editc(phone:'X');
105600210216         endif;
105700200224
105800200424         //pnicusa = 'N';
105900200224         chain (mcssno : dpseq#) smoker;
106000200224         if %found;
106100200424          //pnicusa = 'T';
106200200224         endif;
106300200224
106400230117         plocid = cacid4;
106500200224         psupid1 = ' ';
106600200224         psupid2 = ' ';
106700200224         psupid3 = ' ';
106800200224         psupid4 = ' ';
106900200224         psupid5 = ' ';
107000200224         psupid6 = ' ';
107100200224
107200200224         peventcd = ' ';
107300200224         peventdt = ' ';
107400200224
107500200224         pempdt = ' ';
107600200224         pelegdt = ' ';
107700200224         pemphrs = ' ';
107800200224
107900200224         pcocostdt = ' ';
108000200224         pcocoendt = ' ';
108100200224         pretdt = ' ';
108200200224         pempendt = ' ';
108300200224
108400200224         exsr determineType;
108500200810         exsr getPlan;
108600200224
108700200224         chain (pltrst : plsub# : acc#) actFile2;
108800200224         if %found;
108900200224          //dtaxid# = %char(a2tax_id#);
109000200224         endif;
109100200224
109200200810         if foundPlan = 'Y';
109300220223         if plncat = 'PLF' or plncat = 'PLL';
109400200224         if pcovid1 <> ptype;
109500200224          pcovid1 = 'BLF';
109600200810          pplanid1 = cpcid1;
109700200224          pcovefdt1 = %char(denrdt);
109800200224
109900200224          seq# = dpseq#;
110000200224          ssn = mcssno;
110100200224          termdt = ccandt;
110200200224          exsr checkTerm;
110300200224          if alreadySent = 'N';
110400210217
110500210217            if cpcid2 > ' ' and pclassid = ' ';
110600210217             pclassid = cpcid2;
110700210217            endif;
110800210217
110900200224           if ccandt > 0;
111000200224            cancelh = ccandt;
111100200810             exsr get_planDate;
111200200224            pcovtrmdt1 = %char(cancelh);
111300200224           endif;
111400200224
111401230424           exsr getGroup;
111402230424           if pacct# = ' ';
111403230424            leavesr;
111404230424           endif;
111405230424
111500200224           if writeRecord = 'Y';
111600200224            write priFile;
111700200224           endif;
111800200224           if updateRecord = 'Y';
111900200224            update priFile;
112000200224           endif;
112100200224
112200200224          endif;
112300200224         endif;
112400200224         endif;
112500200810         endif;
112600200224
112700200810         if foundPlan = 'Y';
112800220223         if plncat = 'PAC' or plncat = 'PA1';
112900200224         if pcovid2 <> ptype;
113000200224          pcovid2 = 'ADD';
113100200810          pplanid2 = cpcid1;
113200200224          pcovefdt2 = %char(denrdt);
113300200224
113400200224          seq# = dpseq#;
113500200224          ssn = mcssno;
113600200224          termdt = ccandt;
113700200224          exsr checkTerm;
113800200224          if alreadySent = 'N';
113900210217
114000210217            if cpcid2 > ' ' and pclassid = ' ';
114100210217             pclassid = cpcid2;
114200210217            endif;
114300210217
114400200224           if ccandt > 0;
114500200224            cancelh = ccandt;
114600200810             exsr get_planDate;
114700200224            pcovtrmdt2 = %char(cancelh);
114800200224           endif;
114900200224
114901230424           exsr getGroup;
114902230424           if pacct# = ' ';
114903230424            leavesr;
114904230424           endif;
114905230424
115000200224           if writeRecord = 'Y';
115100200224            write priFile;
115200200224           endif;
115300200224           if updateRecord = 'Y';
115400200224            update priFile;
115500200224           endif;
115600200224
115700200224          endif;
115800200224         endif;
115900200224         endif;
116000200810         endif;
116100200224
116200200810         if foundPlan = 'Y';
116300200424         if plncat = 'PSF';
116400200224         if pcovid3 <> ptype;
116500200224          pcovid3 = 'DLF';
116600210216          pplanid3 = cpcid1;
116700200224          pcovefdt3 = %char(denrdt);
116800200224
116900200224          seq# = dpseq#;
117000200224          ssn = mcssno;
117100200224          termdt = ccandt;
117200200224          exsr checkTerm;
117300200224          if alreadySent = 'N';
117400210217
117500210217            if cpcid2 > ' ' and pclassid = ' ';
117600210217             pclassid = cpcid2;
117700210217            endif;
117800210217
117900200224           if ccandt > 0;
118000200224            cancelh = ccandt;
118100200810             exsr get_planDate;
118200200224            pcovtrmdt3 = %char(cancelh);
118300200224           endif;
118400200224
118401230424           exsr getGroup;
118402230424           if pacct# = ' ';
118403230424            leavesr;
118404230424           endif;
118405230424
118500200224           if writeRecord = 'Y';
118600200224            write priFile;
118700200224           endif;
118800200224           if updateRecord = 'Y';
118900200224            update priFile;
119000200224           endif;
119100200224
119200200224          endif;
119300200224         endif;
119400200224         endif;
119500200810         endif;
119600200810
119700200810         if foundPlan = 'Y';
119800200224         if plncat = 'PSL';
119900200224         if pcovid4 <> ptype;
120000200224          pcovid4 = 'EVL';
120100200224          pcovefdt4 = %char(denrdt);
120200200424          pbenamtel4 = %editc(benamt:'X');
120300200424          pbenamtap4 = %editc(benamt:'X');
120400200424          pbenperel4 = ' ';
120500200810          pplanid4 = cpcid1;
120600200224
120700201009          pnicusa = 'N';
120800201028          chain (mcssno : dpseq#) smoker;
120900201009          if %found;
121000201009           pnicusa = 'T';
121100201009          endif;
121200201009
121300200224          seq# = dpseq#;
121400200224          ssn = mcssno;
121500200224          termdt = ccandt;
121600200224          exsr checkTerm;
121700200224          if alreadySent = 'N';
121800210217
121900210217            if cpcid2 > ' ' and pclassid = ' ';
122000210217             pclassid = cpcid2;
122100210217            endif;
122200210217
122300200224           if ccandt > 0;
122400200224            cancelh = ccandt;
122500200810             exsr get_planDate;
122600200224            pcovtrmdt4 = %char(cancelh);
122700200224           endif;
122800200224
122801230424           exsr getGroup;
122802230424           if pacct# = ' ';
122803230424            leavesr;
122804230424           endif;
122805230424
122900200224           if writeRecord = 'Y';
123000200224            write priFile;
123100200224           endif;
123200200224           if updateRecord = 'Y';
123300200224            update priFile;
123400200224           endif;
123500200224
123600200224          endif;
123700200224         endif;
123800200224         endif;
123900200810         endif;
124000200224
124100200810         if foundPlan = 'Y';
124200200224         if plncat = 'POA';
124300200224         if pcovid5 <> ptype;
124400200224          pcovid5 = 'EVA';
124500200224          pcovefdt5 = %char(enrldt);
124600200810          pplanid5 = cpcid1;
124700200224
124800200224          seq# = dpseq#;
124900200224          ssn = mcssno;
125000200224          termdt = ccandt;
125100200224          exsr checkTerm;
125200200224          if alreadySent = 'N';
125300210217
125400210217            if cpcid2 > ' ' and pclassid = ' ';
125500210217             pclassid = cpcid2;
125600210217            endif;
125700210217
125800200224           if ccandt > 0;
125900200224            cancelh = ccandt;
126000200810             exsr get_planDate;
126100200224            pcovtrmdt5 = %char(cancelh);
126200200224           endif;
126300200224
126301230424           exsr getGroup;
126302230424           if pacct# = ' ';
126303230424            leavesr;
126304230424           endif;
126305230424
126400200224           if writeRecord = 'Y';
126500200224            write priFile;
126600200224           endif;
126700200224           if updateRecord = 'Y';
126800200224            update priFile;
126900200224           endif;
127000200224
127100200224          endif;
127200200224         endif;
127300201009         endif;
127400200810         endif;
127500200224
127600200810         if foundPlan = 'Y';
127700200224         if plncat = 'PSP';
127800200224         if pcovid6 <> ptype;
127900200224          pcovid6 = 'SVL';
128000200224          pcovefdt6 = %char(denrdt);
128100200424          pbenamtel6 = %editc(benamt:'X');
128200200424          pbenamtap6 = %editc(benamt:'X');
128300200810          pplanid6 = cpcid1;
128400200224
128500201027          pnicusa = 'N';
128600201028          chain (mcssno : dpseq#) smoker;
128700201027          if %found;
128800201027           pnicusa = 'T';
128900201027          endif;
129000201027
129100200224          seq# = dpseq#;
129200200224          ssn = mcssno;
129300200224          termdt = ccandt;
129400200224          exsr checkTerm;
129500200224          if alreadySent = 'N';
129600210217
129700210217            if cpcid2 > ' ' and pclassid = ' ';
129800210217             pclassid = cpcid2;
129900210217            endif;
130000210217
130100200224           if ccandt > 0;
130200200224            cancelh = ccandt;
130300200810             exsr get_planDate;
130400200224            pcovtrmdt6 = %char(cancelh);
130500200224           endif;
130600200224
130601230424           exsr getGroup;
130602230424           if pacct# = ' ';
130603230424            leavesr;
130604230424           endif;
130605230424
130700200224           if writeRecord = 'Y';
130800200224            write priFile;
130900200224           endif;
131000200224           if updateRecord = 'Y';
131100200224            update priFile;
131200200224           endif;
131300200224
131400200224          endif;
131500200224         endif;
131600200224         endif;
131700200810         endif;
131800200224
131900200424         //if plncat = 'PSA';
132000200424         //if pcovid7 <> ptype;
132100200424         // pcovid7 = 'SVA';
132200200424         // pplanid7 = '1';
132300200424         // pcovefdt7 = %char(denrdt);
132400200224
132500200424         // seq# = dpseq#;
132600200424         // ssn = mcssno;
132700200424         // termdt = ccandt;
132800200424         // exsr checkTerm;
132900200424         // if alreadySent = 'N';
133000200224
133100200424         //  if ccandt > 0;
133200200424         //   cancelh = ccandt;
133300200810         //    exsr get_planDate;
133400200424         //   pcovtrmdt7 = %char(cancelh);
133500200424         //  endif;
133600200224
133700200424         //  if writeRecord = 'Y';
133800200424         //   write priFile;
133900200424         //  endif;
134000200424         //  if updateRecord = 'Y';
134100200424         //   update priFile;
134200200424         //  endif;
134300200224
134400200424         // endif;
134500200424         //endif;
134600200424         //endif;
134700200224
134800200424         //if plncat = 'PVD' or plncat = 'PSD';
134900200424         //if pcovid8 <> ptype;
135000200424         // pcovid8 = 'CVL';
135100200424         // pcovefdt8 = %char(denrdt);
135200200424         // pbenamtel8 = %editc(benamt:'X');
135300200424         // pbenamtap8 = %editc(benamt:'X');
135400200424         // pplanid8 = '1';
135500200224
135600200424         // seq# = dpseq#;
135700200424         // ssn = mcssno;
135800200424         // termdt = ccandt;
135900200424         // exsr checkTerm;
136000200424         // if alreadySent = 'N';
136100200224
136200200424         //  if candt > 0;
136300200424         //   cancelh = ccandt;
136400200810         //    exsr get_planDate;
136500200424         //   pcovtrmdt8 = %char(cancelh);
136600200424         //  endif;
136700200224
136800200424         //  if writeRecord = 'Y';
136900200424         //   write priFile;
137000200424         //  endif;
137100200424         //  if updateRecord = 'Y';
137200200424         //   update priFile;
137300200424         //  endif;
137400200224
137500200424          //endif;
137600200424         //endif;
137700200424         //endif;
137800200224
137900200810         if foundPlan = 'Y';
138000201009         if plncat = 'PWD' or plncat = 'PVW';
138100200224         if pcovid9 <> ptype;
138200200224          pcovid9 = 'STD';
138300200224          pcovefdt9 = %char(enrldt);
138400200424          pbenamtel9 = %editc(benamt:'X');
138500200424          pbenamtap9 = %editc(benamt:'X');
138600200810          pplanid9 = cpcid1;
138700200224
138701230119          seq# = dpseq#;
138800200224          ssn = mcssno;
138900230119          termdt = ccandt;
139000200224          exsr checkTerm;
139100200224          if alreadySent = 'N';
139200210217
139300210217            if cpcid2 > ' ' and pclassid = ' ';
139400210217             pclassid = cpcid2;
139500210217            endif;
139600210217
139700230120           if ccandt > 0;
139800230120            cancelh = ccandt;
139900200810             exsr get_planDate;
140000200224            pcovtrmdt9 = %char(cancelh);
140100200224           endif;
140200200224
140201230424           exsr getGroup;
140202230424           if pacct# = ' ';
140203230424            leavesr;
140204230424           endif;
140205230424
140300200224           if writeRecord = 'Y';
140400200224            write priFile;
140500200224           endif;
140600200224           if updateRecord = 'Y';
140700200224            update priFile;
140800200224           endif;
140900200224
141000200224          endif;
141100200224         endif;
141200200224         endif;
141300200810         endif;
141400200224
141500201009         if plncat = 'PLT' or plncat = 'PVL';
141600200810         if foundPlan = 'Y';
141700200224         if pcovid10 <> ptype;
141800200224          pcovid10 = 'LTD';
141900210216          pplanid10 = cpcid1;
142000200224          pcovefdt10 = %char(denrdt);
142100200424          pbenamte10 = %editc(benamt:'X');
142200200424          pbenamta10 = %editc(benamt:'X');
142300200224
142400200224          seq# = dpseq#;
142500200224          ssn = mcssno;
142600200224          termdt = ccandt;
142700200224          exsr checkTerm;
142800200224          if alreadySent = 'N';
142900210217
143000210217            if cpcid2 > ' ' and pclassid = ' ';
143100210217             pclassid = cpcid2;
143200210217            endif;
143300210217
143400200224           if ccandt > 0;
143500200224            cancelh = ccandt;
143600200810             exsr get_planDate;
143700200224            pcovtrmd10 = %char(cancelh);
143800200224           endif;
143900200224
143901230424           exsr getGroup;
143902230424           if pacct# = ' ';
143903230424            leavesr;
143904230424           endif;
143905230424
144000200224           if writeRecord = 'Y';
144100200224            write priFile;
144200200224           endif;
144300200224           if updateRecord = 'Y';
144400200224            update priFile;
144500200224           endif;
144600200224
144700200224          endif;
144800200224         endif;
144900200224         endif;
145000200810         endif;
145100200224
145200200810         if foundPlan = 'Y';
145300200224         if plncat = 'PDN';
145400200224         if pcovid11 <> ptype;
145500200224          pcovid11 = 'DEN';
145600200224          pcovefdt11 = %char(denrdt);
145700200810          pplanid11 = cpcid1;
145800200224
145900200224          seq# = dpseq#;
146000200224          ssn = mcssno;
146100200224          termdt = ccandt;
146200200224          exsr checkTerm;
146300200224          if alreadySent = 'N';
146400210217
146500210217            if cpcid2 > ' ' and pclassid = ' ';
146600210217             pclassid = cpcid2;
146700210217            endif;
146800210217
146900200224           if ccandt > 0;
147000200224            cancelh = ccandt;
147100200810             exsr get_planDate;
147200200224            pcovtrmd11 = %char(cancelh);
147300200224           endif;
147400200224
147401230424           exsr getGroup;
147402230424           if pacct# = ' ';
147403230424            leavesr;
147404230424           endif;
147405230424
147500200224           if writeRecord = 'Y';
147600200224            write priFile;
147700200224           endif;
147800200224           if updateRecord = 'Y';
147900200224            update priFile;
148000200224           endif;
148100200224
148200200224          endif;
148300200224         endif;
148400200224         endif;
148500200810         endif;
148600200224
148700200224         if plncat = 'PVS';
148800200810         if foundPlan = 'Y';
148900200224         if pcovid12 <> ptype;
149000200224          pcovid12 = 'VIS';
149100200810          pplanid12 = cpcid1;
149200200424
149300200224          pcovefdt12 = %char(denrdt);
149400200224
149500200224          seq# = dpseq#;
149600200224          ssn = mcssno;
149700200224          termdt = ccandt;
149800200224          exsr checkTerm;
149900200224          if alreadySent = 'N';
150000210217
150100210217            if cpcid2 > ' ' and pclassid = ' ';
150200210217             pclassid = cpcid2;
150300210217            endif;
150400210217
150500200224           if ccandt > 0;
150600200224            cancelh = ccandt;
150700200810             exsr get_planDate;
150800200224            pcovtrmd12 = %char(cancelh);
150900200224           endif;
151000200224
151001230424           exsr getGroup;
151002230424           if pacct# = ' ';
151003230424            leavesr;
151004230424           endif;
151005230424
151100200224           if writeRecord = 'Y';
151200200224            write priFile;
151300200224           endif;
151400200224           if updateRecord = 'Y';
151500200224            update priFile;
151600200224           endif;
151700200224
151800200224          endif;
151900200224         endif;
152000200224         endif;
152100200810         endif;
152200200224
152300200810         if foundPlan = 'Y';
152400200224         if plncat = 'PCC';
152500200224         if pcovid13 <> ptype;
152600200224          pcovid13 = 'ECI';
152700210216          pplanid13 = cpcid1;
152800200224          pcovefdt13 = %char(denrdt);
152900200424          pbenamte13 = %editc(benamt:'X');
153000200424          pbenamta13 = %editc(benamt:'X');
153100200224
153200200224          seq# = dpseq#;
153300200224          ssn = mcssno;
153400200224          termdt = ccandt;
153500200224          exsr checkTerm;
153600200224          if alreadySent = 'N';
153700210217
153800210217            if cpcid2 > ' ' and pclassid = ' ';
153900210217             pclassid = cpcid2;
154000210217            endif;
154100210217
154200200224           if ccandt > 0;
154300200224            cancelh = ccandt;
154400200810             exsr get_planDate;
154500200224            pcovtrmd13 = %char(cancelh);
154600200224           endif;
154700200224
154701230424           exsr getGroup;
154702230424           if pacct# = ' ';
154703230424            leavesr;
154704230424           endif;
154705230424
154800200224           if writeRecord = 'Y';
154900200224            write priFile;
155000200224           endif;
155100200224           if updateRecord = 'Y';
155200200224            update priFile;
155300200224           endif;
155400200224
155500200224          endif;
155600200224         endif;
155700200224         endif;
155800200810         endif;
155900200224
156000200810         if foundPlan = 'Y';
156100200224         if plncat = 'PCB';
156200200224         if pcovid14 <> ptype;
156300200224          pcovid14 = 'SCI';
156400210216          pplanid14 = cpcid1;
156500210217
156600200224          pcovefdt14 = %char(denrdt);
156700200424          pbenamte14 = %editc(benamt:'X');
156800200424          pbenamta14 = %editc(benamt:'X');
156900200224
157000200224          seq# = dpseq#;
157100200224          ssn = mcssno;
157200200224          termdt = ccandt;
157300200224          exsr checkTerm;
157400200224          if alreadySent = 'N';
157500210217
157600210217            if cpcid2 > ' ' and pclassid = ' ';
157700210217             pclassid = cpcid2;
157800210217            endif;
157900210217
158000200224           if ccandt > 0;
158100200224            cancelh = ccandt;
158200200810             exsr get_planDate;
158300200224            pcovtrmd14 = %char(cancelh);
158400200224           endif;
158500200224
158501230424           exsr getGroup;
158502230424           if pacct# = ' ';
158503230424            leavesr;
158504230424           endif;
158505230424
158600200224           if writeRecord = 'Y';
158700200224            write priFile;
158800200224           endif;
158900200224           if updateRecord = 'Y';
159000200224            update priFile;
159100200224           endif;
159200200224
159300200224          endif;
159400200224         endif;
159500200224         endif;
159600200810         endif;
159700200224
159800200810         if foundPlan = 'Y';
159900200224         if plncat = 'PCG';
160000200224         if pcovid15 <> ptype;
160100200224          pcovid15 = 'CCI';
160200210216          pplanid15 = cpcid1;
160300200224          pcovefdt15 = %char(denrdt);
160400200424          pbenamte15 = %editc(benamt:'X');
160500200424          pbenamta15 = %editc(benamt:'X');
160600200224
160700200224          seq# = dpseq#;
160800200224          ssn = mcssno;
160900200224          termdt = ccandt;
161000200224          exsr checkTerm;
161100200224          if alreadySent = 'N';
161200210217
161300210217            if cpcid2 > ' ' and pclassid = ' ';
161400210217             pclassid = cpcid2;
161500210217            endif;
161600210217
161700200224           if ccandt > 0;
161800200224            cancelh = ccandt;
161900200810             exsr get_planDate;
162000200224            pcovtrmd15 = %char(cancelh);
162100200224           endif;
162200200224
162201230424           exsr getGroup;
162202230424           if pacct# = ' ';
162203230424            leavesr;
162204230424           endif;
162205230424
162300200224           if writeRecord = 'Y';
162400200224            write priFile;
162500200224           endif;
162600200224           if updateRecord = 'Y';
162700200224            update priFile;
162800200224           endif;
162900200224
163000200224          endif;
163100200224         endif;
163200200224         endif;
163300200810         endif;
163400200224
163500200810         if foundPlan = 'Y';
163600200224         if plncat = 'PO6';
163700200224         if pcovid16 <> ptype;
163800200224          pcovid16 = 'ACC';
163900210216          pplanid16 = cpcid1;
164000200224          pcovefdt16 = %char(denrdt);
164100200224
164200200224          seq# = dpseq#;
164300200224          ssn = mcssno;
164400200224          termdt = ccandt;
164500200224          exsr checkTerm;
164600200224          if alreadySent = 'N';
164700210217
164800210217            if cpcid2 > ' ' and pclassid = ' ';
164900210217             pclassid = cpcid2;
165000210217            endif;
165100210217
165200200224           if ccandt > 0;
165300200224            cancelh = ccandt;
165400200810             exsr get_planDate;
165500200224            pcovtrmd16 = %char(cancelh);
165600200224           endif;
165700200224
165701230424           exsr getGroup;
165702230424           if pacct# = ' ';
165703230424            leavesr;
165704230424           endif;
165705230424
165800200224           if writeRecord = 'Y';
165900200224            write priFile;
166000200224           endif;
166100200224           if updateRecord = 'Y';
166200200224            update priFile;
166300200224           endif;
166400200224
166500200224          endif;
166600200224         endif;
166700200224         endif;
166800200810         endif;
166900200224
167000160516       endsr;
167100160511
167200160519      //===================================================================
167300160519      // Get group number
167400160519      //===================================================================
167500160519
167600181031       begsr getGroup;
167700160519
167800160519        setll (pltrst : plsub# : plplan) grater;
167900160519        reade (pltrst : plsub# : plplan) grater;
168000160519
168100160519        dow not %eof;
168200160519
168300160519         if today >= frmdat;
168400160519          if today <= todat;
168600200228           leave;
168700160519          else;
168800160519           group# = ' ';
168900160519          endif;
169000160519         endif;
169100160519
169200160519        reade (pltrst : plsub# : plplan) grater;
169300160519        enddo;
169301230424
169400230424        if group# = ' ' and cancelh > 0;
169401230424        setll (pltrst : plsub# : plplan) grater;
169402230424        reade (pltrst : plsub# : plplan) grater;
169403230424
169404230424        dow not %eof;
169405230424
169406230424         if cancelh >= frmdat;
169407230424          if cancelh <= todat;
169408230424           leave;
169409230424          else;
169410230424           group# = ' ';
169411230424          endif;
169412230424         endif;
169413230424
169414230424         reade (pltrst : plsub# : plplan) grater;
169415230424         enddo;
169416230424        endif;
169417230424
169500200224        pos = %scan('-':group#);
169600200224        if pos > 0;
169700201116         pos = pos - 1;
169800200224         pacct# = %subst(group#:1:pos);
169900200224        else;
170000200224         pacct# = group#;
170100200224        endif;
170200200224
172100200224        if p_acct > ' ';
172200200224         if pacct# <> p_acct;
172300200224          pacct# = ' ';
172400200224         endif;
172500200224        endif;
172600200224
172700200228       endsr;
172800180313
172900190226      //===================================================================
173000190226      // Determine Type
173100190226      //===================================================================
173200190226
173300190226       begsr determineType;
173400190226
173500200224        ptype = ' ';
173600190226
173700200224         select;
173800220223          when plncat = 'PLF' or plncat = 'PLL';
173900200224           ptype = 'BLF';
174000200224
174100220223          when plncat = 'PAC' or plncat = 'PA1';
174200200424           ptype = 'ADD';
174300200424
174400200424          when plncat = 'PSF';
174500200224           ptype = 'DLF';
174600200224
174700200224          when plncat = 'PSL';
174800200224           ptype = 'EVL';
174900200224
175000200224          when plncat = 'POA';
175100200224           ptype = 'EVA';
175200200224
175300200224          when plncat = 'PSP';
175400200224           ptype = 'SVL';
175500200224
175600200224          when plncat = 'PSA';
175700200224           ptype = 'SVA';
175800200224
175900200224          when plncat = 'PVD';
176000200224           ptype = 'CVL';
176100200224
176200200424          when plncat = 'PSD';
176300200424           ptype = 'CVL';
176400200424
176500200224          when plncat = 'PLT';
176600200224           ptype = 'LTD';
176700200224
176800201009          when plncat = 'PVL';
176900201009           ptype = 'LTD';
177000201009
177100200224          when plncat = 'PDN';
177200200224           ptype = 'DEN';
177300200224
177400200224          when plncat = 'PVS';
177500200224           ptype = 'VIS';
177600200224
177700200224          when plncat = 'PCC';
177800200224           ptype = 'ECI';
177900200224
178000200224          when plncat = 'PCB';
178100200224           ptype = 'SCI';
178200200224
178300200224          when plncat = 'PCG';
178400200224           ptype = 'CCI';
178500200224
178600200224          when plncat = 'PO6';
178700200224           ptype = 'ACC';
178800200224
178900200424          when plncat = 'PWD';
179000200424           ptype = 'STD';
179100200424
179200201009          when plncat = 'PVW';
179300201009           ptype = 'STD';
179400201009
179500200224         endsl;
179600190226
179700190226       endsr;
179800190226
179900200810      //===================================================================
180000200810      // Determine Type
180100200810      //===================================================================
180200200810
180300200810       begsr getplan;
180400200810
180500200810        foundPlan = 'N';
180600200810
180700200810        chain (unique : pltrst : plsub# : acc# : ptype : plplan) planSetup;
180800200810        if %found;
180900200810         foundPlan = 'Y';
181000200810        endif;
181100200810
181200200810       endsr;
181300200810
181400200228      //===================================================================
181500200228      // coverage tier
181600200228      //===================================================================
181700200228
181800200228       begsr coverageTier;
181900200228
182000200228       tier = ' ';
182100200228
182200200228       select;
182300200228        when mcovtp = 'TIN';
182400200228         tier = '1';
182500200228
182600200228        when mcovtp = 'TFA';
182700200228         tier = '2';
182800200228
182900200228        when mcovtp = 'THW';
183000200228         tier = '3';
183100200228
183200200228        when mcovtp = 'TPC' or mcovtp = 'TP2';
183300200228         tier = '4';
183400200228
183500200228        when mcovtp = 'TU1' or mcovtp = 'TU2' or mcovtp = 'TU3';
183600200228         tier = '5';
183700200228       endsl;
183800200228
183900200228       endsr;
184000200228
184100180313      //===================================================================
184200180313      // Relationship Codes
184300180313      //===================================================================
184400180313
184500180313       begsr relCodes;
184600180313
184700200424        prel = ' ';
184800200424
184900181030        select;
185000181030         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
185100200224          prel = 'S';
185200200224
185300181030         when drelcd = 'RDA' or drelcd = 'RSO';
185400200224          prel = 'C';
185500181030
185600181030        endsl;
185700210519
185800210519        if dhndcp = '1' or dhndcp = '2' or dhndcp = '3';
185900210519         prel = 'H';
186000210519        endif;
186100181030
186200180313       endsr;
186300180424
186400200228      //===================================================================
186500200228      // check for transmission
186600200228      //===================================================================
186700200228
186800200228       begsr checkTransmission;
186900200228
187000200228        ok_toTransmit = 'Y';
187100200909
187200201008        chain (unique : pltrst : plsub# : acc#) setupFile;
187300200228        if %found;
187400210917         if castatus <> 'Y';
187500201008          ok_toTransmit = 'N';
187600201008         endif;
187700201008        endif;
187800201008
187900201008        if not %found;
188000201008         ok_toTransmit = 'N';
188100201008        endif;
188200190401
188300190401       endsr;
188400190401
188500200424      //===================================================================
188600200424      // format salary
188700200424      //===================================================================
188800200424
188900200424       begsr formatSalary;
189000200424
189100200424        salaryHold = ' ';
189200200424
189300200424        size = %len(%trim(%char(salary)));
189400200424        if size = 5;
189500200424         salaryHold = %replace('00000000':salaryHold:1);
189600200424         salaryHold = %replace(%char(salary):salaryHold:9);
189700200424        endif;
189800200424
189900200424        if size = 6;
190000200424         salaryHold = %replace('0000000':salaryHold:1);
190100200424         salaryHold = %replace(%char(salary):salaryHold:8);
190200200424        endif;
190300200424
190400200424        salaryHold = %replace('00':salaryHold:14);
190500200424
190600200424       endsr;
190700200424
190800160511      //===================================================================
190900160511      // exit
191000160511      //===================================================================
191100160511
191200160511       begsr exit;
191300160511
191400160511        *inlr = '1';
191500160511        return;
191600160511
191700160511       endsr;
191800160511
191900160511      //===================================================================
192000160511      // init
192100160511      //===================================================================
192200160520
192300160511       begsr init;
192400160511
192500200224        carrierCode1 = 'PFL';
192600200224        carrierCode2 = 'PFR';
192700200224        carrierCode3 = 'PRD';
192800200224        carrierCode4 = 'PRL';
192900200224        carrierCode5 = 'PVL';
193000200224        grouperCode = 'PL';
193100200911        carrier = 19;
193200200810        unique = '0000000329';
193300181031
193400160519        today = %dec(%char(%date:*iso0):8:0);
193500201008
193600160511       endsr;
193700010412
193800160511       //==============================================================
