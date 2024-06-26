000100180831      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400180823      * NASCO010R - Nasco - Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800180823      * 08/23/2018  jt    Original creation
000900160513      *===========================================================================
001000160512
001100160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001200180831     F                                     rename(plnmsr:planFile)
001300180412
001400180830     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001500180831     F                                     rename(plnmsr:planFile2)
001600180830
001700180313     Fmcov39    if   e           k disk    extfile('F.MCOV39')
001800180831     F                                     rename(mcovr:mcovFile)
001900170619
002000180831     Fmcovc15   if   e           k disk    extfile('F.MCOVC15')
002100180831     F                                     rename(mcovr:mcovFile2)
002200160513
002300180309     Fmember    if   e           k disk    extfile('F.MEMBER')
002400180831     F                                     rename(membr:memberFile)
002500160513
002600160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
002700180831     F                                     rename(depenr:dependFile)
002800160513
002900160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003000180831     F                                     rename(dcovr:depcovFile)
003100160518
003200180313     fcodes     if   e           k disk    extfile('F.CODES')
003300180313     f                                     rename(codesr:codesFile)
003400180313
003500180828     fpcpl1     if   e           k disk    extfile('F.PCPL1')
003600180831     f                                     rename(pcpr:pcpFile)
003700180508
003800180823     fnascodtl  uf a e           k disk    rename(detailr:nascoFile)
003900160513
004000180827     fnascotrm  if a e           k disk    rename(nascotr:termFile)
004100181120
004200181129     fcaraccl3  if   e           k disk    rename(caraccr:setupFile)
004300180523
004400160512      *=================================================================
004500061017
004600180829     d carrierCode     s              3
004700160519     d term_dt_limit   s               d
004800160519     d today           s              8  0
004900180313     d hiredatet       s               d
005000180313     d catType         s              3
005100180313     d updateRecord    s              1
005200180313     d writeRecord     s              1
005300180508     d unique          s             10
005400180523     d alreadySent     s              1
005500180523     d ssn             s              9  0
005600180523     d seq#            s              2  0
005700180523     d ctype           s              3
005800180523     d termdt          s              8  0
005900180523     d covtp           s              2
006000180827     d holdZip         s              9
006100180829     d mediA           s              8  0
006200180829     d mediB           s              8  0
006300180828     d brthMDY         s              8
006400181129     d name            s             30
006500150820
006600160511      //==================================================================
006700160511      // mainline
006800160511      //===================================================================
006900150820
007000160511       exsr init;
007100160511       exsr main;
007200160511       exsr exit;
007300160511
007400180830      //===================================================================
007500180830      // main
007600180830      //===================================================================
007700180830
007800180830       begsr main;
007900180830
008000180831        setll carrierCode planFile2;
008100180831        reade carrierCode planFile2;
008200180830
008300180830        dow not %eof;
008400180830
008500180831         setll (pltrst : plsub# : plplan) mcovFile;
008600180831         reade (pltrst : plsub# : plplan) mcovFile;
008700180830
008800180830         dow not %eof;
008900180830
009000180830          exsr process;
009100180830
009200180831         reade (pltrst : plsub# : plplan) mcovFile;
009300180830         enddo;
009400180830
009500180831        reade carrierCode planFile2;
009600180830        enddo;
009700180830
009800180830       endsr;
009900180309
010000160511      //===================================================================
010100160511      // process
010200160511      //===================================================================
010300160511
010400160511       begsr process;
010500180508
010600180831        chain mcssno memberFile;
010700160511
010800181129        chain (unique : pltrst : plsub# : acc# : name) setupFile;
010900181129        if %found;
011000181129        if castatus = 'Y';
011100181129
011200180831        chain (pltrst : plsub# : acc# : mcssno : plplan) mcovFile2;
011300181203        //if %found;
011400181120
011500180823        // if record is termed see if we need to stop sending...
011600180823        if candt <> 0;
011700180508
011800180823         term_dt_limit = %date(candt);
011900181203
012000181203         if candt = enrldt;
012100181203          exsr writeMember;
012200181203          leavesr;
012300181203         endif;
012400181203
012500181212         //if %date() > term_dt_limit;
012600181212         // leavesr;
012700181212         //else;
012800180823          exsr writeMember;
012900181212         //endif;
013000180508
013100180823        else;
013200180823         exsr writeMember;
013300180823        endif;
013400180508
013500181129        endif;
013600181120        endif;
013700181120
013800160511       endsr;
013900160511
014000160513      //===================================================================
014100180313      // Write Member
014200160513      //===================================================================
014300160513
014400180313       begsr writeMember;
014500160513
014600180313        updateRecord = 'N';
014700180313        writeRecord = 'N';
014800180313
014900180828        brthMDY = %editc(%dec(%char(%date(birth:*iso):*usa0):8:0):'X');
015000180828
015100180313        chain
015200180828        (%editc(mbssno:'X'):%editc(mbssno:'X'):%char(brthMDY):mlname:mfname:mmi)
015300180823        nascoFile;
015400180313        if %found;
015500180313         updateRecord = 'Y';
015600180313        else;
015700180313         writeRecord = 'Y';
015800180313        endif;
015900180313
016000180313        exsr determineType;
016100180313        if catType = ' ';
016200180824         leavesr;
016300180313        endif;
016400160513
016500180313        if writeRecord = 'Y';
016600180823         clear nascoFile;
016700180313        endif;
016800180827
016900180824        drtype = '20';
017000180824        dfiller1 = ' ';
017100180824
017200180823        dssn = %editc(mbssno:'X');
017300180823        dlast = mlname;
017400180823        dfirst = mfname;
017500180823        dmit = mmi;
017600180828        dsuffix = ' ';
017700180827        ddob = %editc(%dec(%char(%date(birth:*iso):*usa0):8:0):'X');
017800180823        dgen = sex;
017900180828        demp# = ' ';
018000180828        demploc = ' ';
018100180828
018200180828        if salary > 0;
018300180828         dempsal = %char(salary);
018400180828        endif;
018500180828        dempsald = ' ';
018600180828
018700180828        if empdt > 0;
018800180828         demphdate = %editc(%dec(%char(%date(empdt:*iso):*usa0):8:0):'X');
018900180828        endif;
019000180828
019100180828        dmatstat = ' ';
019200180828        dmatdate = ' ';
019300180828
019400180828        select;
019500180828         when empst = 'A';
019600180828          dstatusi = 'A';
019700180828         when empst = 'R';
019800180828          dstatusi = 'R';
019900180829         when empst = 'C';
020000180829          dstatusi = 'C';
020100180828        endsl;
020200180828
020300180828        dadd1 = addr1;
020400180828        dadd2 = addr2;
020500180828        dhcity = city;
020600180828        dstate = state;
020700180828        dhzip = %editc(zip:'X') + '0000';
020800180828        dharea = %editc(area:'X');
020900180828        dhphone = %editc(phone:'X');
021000180828        dwarea = ' ';
021100180828        dwphone = ' ';
021200180828
021300180823        dmbrssn = %editc(mbssno:'X');
021400180312
021500180828        exsr coverageLevel;
021600180828
021700180911        dhic# = med#;
021800180911        if dhic# = ' ';
021900180911         dmedein = '9';
022000180911        endif;
022100180911
022200180911        mediA = medadt;
022300180911        mediB = medbdt;
022400180911        exsr medicare;
022500180911
022600180828        exsr getGroup;
022700180828
022800180823        drel = '1';
022900180312
023000180828        ddisi = 'N';
023100180828        if hndicp = '3';
023200180823         ddisi = 'Y';
023300180312        endif;
023400180828
023500180313        if catType = 'MED';
023600180827
023700180827         dmeffdt = %editc(%dec(%char(%date(enrldt:*iso):*usa0):8:0):'X');
023800180827         if candt > 0;
023900180827          dmtermdt = %editc(%dec(%char(%date(candt:*iso):*usa0):8:0):'X');
024000180828          dmtermcd = '4';
024100180827         endif;
024200180313
024300180828         ssn = mcssno;
024400180828         seq# = 0;
024500180828         ctype = catType;
024600180828         termdt = candt;
024700180523
024800180828         dtcode = 'A';
024900180828         if termdt > 0;
025000180828          dtcode = 'T';
025100180828         endif;
025200180827
025300180828         dcobi = cob;
025400180828         if dcobi <> 'Y';
025500180828          dcobi = 'N';
025600180828         endif;
025700180828
025800180828         dhic# = med#;
025900180828         if dhic# = ' ';
026000180828          dmedein = '9';
026100180828         endif;
026200180828
026300180829         mediA = medadt;
026400180829         mediB = medbdt;
026500180828         exsr medicare;
026600180828
026700180828         exsr pcp;
026800180828
026900180828         dhold = 'X';
027000180828
027100180828         exsr checkTerm;
027200180828         if alreadySent = 'N';
027300180523
027400180828          if writeRecord = 'Y';
027500180828           write nascoFile;
027600180828          endif;
027700180828          if updateRecord = 'Y';
027800180828           update nascoFile;
027900180828          endif;
028000180523
028100180828         endif;
028200180523
028300181018         //if mcovtp <> 'TIN';
028400180828          exsr dependent;
028500181018         //endif;
028600180827
028700180827        endif;
028800180523
028900160516       endsr;
029000060817
029100180828      //===================================================================
029200180828      // medicare
029300180828      //===================================================================
029400180828
029500180828       begsr medicare;
029600180828
029700180828        select;
029800180829         when mediA > 0 and mediB > 0;
029900180828          dmedein = '3';
030000180828
030100180829         when mediA > 0 and mediB = 0;
030200180828          dmedein = '1';
030300180828
030400180829         when mediA = 0 and mediB > 0;
030500180828          dmedein = '2';
030600180828        endsl;
030700180828
030800180828
030900180828        if dmedein <> '9';
031000181120         if mediA > 0;
031100181120          dmedaeffdt = %editc(%dec(%char(%date(mediA:*iso):*usa0):8:0):'X');
031200181120         endif;
031300181120
031400181120         if mediB > 0;
031500181120          dmedbeffdt = %editc(%dec(%char(%date(mediB:*iso):*usa0):8:0):'X');
031600181120         endif;
031700181120        endif;
031800180828
031900180828       endsr;
032000180828
032100180523      //===================================================================
032200180523      // check termed records;
032300180523      //===================================================================
032400180523
032500180523       begsr checkTerm;
032600180523
032700180523       alreadySent = 'N';
032800180523
032900180523       if termdt > 0;
033000180523
033100180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
033200180523        if %found;
033300180523         alreadySent = 'Y';
033400180523         leavesr;
033500180523        endif;
033600180523
033700180523        if not %found;
033800180523         ttrst = pltrst;
033900180523          tsub# = plsub#;
034000180523           tacct = acc#;
034100180524            tssno = ssn;
034200180523             tseq# = seq#;
034300180523             ttype = ctype;
034400180523            tplan = plplan;
034500180523           ttermdt = termdt;
034600180523          ttrnsdt = %dec(%date);
034700180827         write termFile;
034800180523        endif;
034900180523
035000180523       endif;
035100180523
035200180523       endsr;
035300180524
035400160512      //===================================================================
035500160512      // process
035600160512      //===================================================================
035700160512
035800160512       begsr dependent;
035900160512
036000180831        setll mcssno dependFile;
036100180831        reade mcssno dependFile;
036200160512
036300160512        dow not %eof;
036400160512
036500180831        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
036600160512        if %found;
036700180313         exsr dependentCoverage;
036800160512        endif;
036900160512
037000180831        reade mcssno dependFile;
037100160512        enddo;
037200160512
037300160512    ?  endsr;
037400160512
037500160516      //===============================================================
037600160512      // Dependent coverage
037700160512      //===============================================================
037800160513
037900180313       begsr dependentCoverage;
038000160512
038100180831        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
038200180831        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
038300160512
038400160512        dow not %eof;
038500160512
038600180313         if ccandt <> 0;
038700160512
038800160516          term_dt_limit = %date(ccandt);
038900190118         if ccandt = denrdt;
039000190118          exsr writeDep;
039100190118           leavesr;
039200190118          //if %date() > term_dt_limit;
039300190118          // leavesr;
039400160512          else;
039500160512
039600160516           exsr writeDep;
039700160512          endif;
039800160512
039900160512         else;
040000160516          exsr writeDep;
040100160512          leavesr;
040200160512         endif;
040300160512
040400180831        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
040500160512        enddo;
040600160512
040700160512       endsr;
040800160512
040900160516      //===============================================================
041000160516      // write dependent
041100160516      //===============================================================
041200160516
041300160516       begsr writeDep;
041400180313
041500180313        updateRecord = 'N';
041600180313        writeRecord = 'N';
041700180313
041800180828        brthMDY = %editc(%dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
041900180828
042000180313        chain
042100180828        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(brthMDY):dlname:dfname:dmi)
042200180823        nascoFile;
042300180313        if %found;
042400180313         updateRecord = 'Y';
042500180313        else;
042600180313         writeRecord = 'Y';
042700180313        endif;
042800180313
042900180313        exsr determineType;
043000180313        if catType = ' ';
043100180313         leavesr;
043200180313        endif;
043300180313
043400180313        if writeRecord = 'Y';
043500180823         clear nascoFile;
043600180313        endif;
043700180427
043800180824        drtype = '20';
043900180824        dfiller1 = ' ';
044000180824
044100180824        dssn = %editc(mbssno:'X');
044200180828
044300180823        dlast = dlname;
044400180823        dfirst = dfname;
044500180823        dmit = dmi;
044600180828        dsuffix = ' ';
044700180827        ddob = %editc(%dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
044800180823        dgen = dsex;
044900180828        demp# = ' ';
045000180828        demploc = ' ';
045100180313
045200180828        dempsal = ' ';
045300180828        dempsald = ' ';
045400180828        demphdate = ' ';
045500180828
045600180828        dmatstat = ' ';
045700180828        dmatdate = ' ';
045800180828
045900180828        dstatusi = ' ';
046000180828
046100180823        dadd1 = daddr1;
046200180823        dadd2 = daddr2;
046300180823        dcity = dcity;
046400180823        dstate = dstate;
046500180823        dhzip = %editc(dzip:'X') + '0000';
046600180828        dharea = %editc(area:'X');
046700180828        dhphone = %editc(phone:'X');
046800180828
046900180828        dwarea = ' ';
047000180828        dwphone = ' ';
047100180313
047200180828        dmbrssn = %editc(depss#:'X');
047300180907        if dmbrssn = '000000000';
047400181220         //dmbrssn = ' ';
047500180907        endif;
047600180907
047700180828        exsr coverageLevel;
047800180828
047900180911        dhic# = dmed#;
048000180911        if dhic# = ' ';
048100180911         dmedein = '9';
048200180911        endif;
048300180911
048400180911        mediA = dmedad;
048500180911        mediB = dmedbd;
048600180911        exsr medicare;
048700180911
048800180828        exsr getGroup;
048900180828
049000180828        exsr relCodes;
049100180313
049200180828        ddisi = 'N';
049300180828        if dhndcp = '3';
049400180828         ddisi = 'Y';
049500180828        endif;
049600180828
049700180828        dstudata = ' ';
049800180828        if dstudn = 'Y';
049900180828         dstudata = 'Y';
050000180828        endif;
050100180313
050200180313        if catType = 'MED';
050300180827
050400180828         dmeffdt = %editc(%dec(%char(%date(denrdt:*iso):*usa0):8:0):'X');
050500181002         if ccandt > 0;
050600180828          dmtermdt = %editc(%dec(%char(%date(ccandt:*iso):*usa0):8:0):'X');
050700180828          dmtermcd = '4';
050800180828         endif;
050900180828
051000180828         seq# = dpseq#;
051100180828         ctype = catType;
051200180828         termdt = ccandt;
051300180828
051400180828         dtcode = 'A';
051500180828         if termdt > 0;
051600180828          dtcode = 'T';
051700180828         endif;
051800180827
051900180828         dcobi = dcob;
052000180828         if dcobi <> 'Y';
052100180828          dcobi = 'N';
052200180828         endif;
052300180828
052400180828         dhic# = dmed#;
052500180828         if dhic# = ' ';
052600180828          dmedein = '9';
052700180828         endif;
052800180828
052900180828         mediA = dmedad;
053000180828         mediB = dmedbd;
053100180828         exsr medicare;
053200180828
053300180828         exsr pcp;
053400180828
053500180828         dhold = 'X';
053600180828
053700180828         exsr checkTerm;
053800180828         if alreadySent = 'N';
053900180523
054000180828          if writeRecord = 'Y';
054100180828           write nascoFile;
054200180828          endif;
054300180828          if updateRecord = 'Y';
054400180828           update nascoFile;
054500180828          endif;
054600160516
054700180828         endif;
054800180827
054900180827        endif;
055000180523
055100160516       endsr;
055200160511
055300180827      //===================================================================
055400180827      // Get group number
055500180827      //===================================================================
055600180827
055700180828       begsr getGroup;
055800180827
055900180829        if plplan = 'DAD6' or plplan = 'DAD7'
056000180829          or plplan = 'DAD8' or plplan = 'DAD9';
056100180827
056200180827         select;
056300180829          when plplan = 'DAD6';
056400180827           dmedg# = '5802367DC10';
056500180827           ddept# = '00001KU83';
056600180829
056700180829          when plplan = 'DAD7';
056800180829           dmedg# = '5802368DC40';
056900180829           ddept# = '00004KU83';
057000180827
057100180829          when plplan = 'DAD8';
057200180827           dmedg# = '5802369DC10';
057300180827           ddept# = '00001KU84';
057400180829
057500180829          when plplan = 'DAD9';
057600180829            dmedg# = '5802370DC40';
057700180829            ddept# = '00004KU84';
057800180827         endsl;
057900180827
058000180911         //if mcovtp = 'TIN';
058100180911         // dpckcode = '106';
058200180911         //else;
058300180911         // dpckcode = '006';
058400180911         //endif;
058500180911
058600180911         dpckcode = '006';
058700180911         if dmedaeffdt > ' ';
058800180911          dpckcode = '106';
058900180911         endif;
059000180827
059100180827        endif;
059200180827
059300180829        if plplan = 'DAEA' or plplan = 'DAEB'
059400180829          or plplan = 'DAEC' or plplan = 'DAED';
059500180827
059600180827         select;
059700180829          when plplan = 'DAEA';
059800180827           dmedg# = '5802371DC10';
059900180827           ddept# = '00001KU85';
060000180829
060100180829          when plplan = 'DAEB';
060200180829           dmedg# = '5802372DC40';
060300180829           ddept# = '00004KU85';
060400180827
060500180829          when plplan = 'DAEC';
060600180827           dmedg# = '5802373DC10';
060700180827           ddept# = '00001KU86';
060800180829
060900180829          when plplan = 'DAED';
061000180829            dmedg# = '5802374DC40';
061100180829            ddept# = '00004KU86';
061200180827         endsl;
061300180827
061400180911         //if mcovtp = 'TIN';
061500180911         // dpckcode = '241';
061600180911         //else;
061700180911         // dpckcode = '240';
061800180911         //endif;
061900180911
062000180911         dpckcode = '240';
062100180911         if dmedaeffdt > ' ';
062200180911          dpckcode = '241';
062300180911         endif;
062400180827
062500180827        endif;
062600180827
062700180829        if plplan = 'DAEE' or plplan = 'DAEG'
062800180829          or plplan = 'DAEH' or plplan = 'DAEJ';
062900180829
063000180829         select;
063100180829          when plplan = 'DAEE';
063200180829           dmedg# = '5802375DC10';
063300180829           ddept# = '00001KU87';
063400180829
063500180829          when plplan = 'DAEG';
063600180829           dmedg# = '5802376DC40';
063700180829           ddept# = '00004KU87';
063800180829
063900180829          when plplan = 'DAEH';
064000180829           dmedg# = '5802377DC10';
064100180829           ddept# = '00001KU88';
064200180829
064300180829          when plplan = 'DAEJ';
064400180829            dmedg# = '5802378DC40';
064500180829            ddept# = '00004KU88';
064600180829         endsl;
064700180829
064800180829         if mcovtp = 'TIN';
064900180829          dpckcode = '240';
065000180829         else;
065100180829          dpckcode = '241';
065200180829         endif;
065300180829
065400180829         if mcovtp = 'TMI';
065500180829          dpckcode = '242';
065600180829         endif;
065700180829
065800180829        endif;
065900180829
066000180828        dcplancd = '580';
066100180827        dhplancd = '580';
066200180827        holdZip = %editc(zip:'X');
066300180827        if (%subst(holdZip:1:3) >= '210' and %subst(holdZip:1:3) <= '219');
066400180827         dhplancd = '690';
066500180827        endif;
066600180827
066700180827        dmprdid = '00';
066800180827
066900180827    ?  endsr;
067000180827
067100180828      //===================================================================
067200180828      // pcp
067300180828      //===================================================================
067400180828
067500180828       begsr pcp;
067600180828
067700180831        setll (%dec(dssn:9:0) : seq# : 'MED') pcpFile;
067800180831        reade (%dec(dssn:9:0) : seq# : 'MED') pcpFile;
067900180828        dow not %eof;
068000180828
068100180828         if pccan = 0;
068200180828          dpcp# = pcid#;
068300180828
068400180828           dpcpeftrd = ' ';
068500180828           if pceff > 0;
068600180828            dpcpeftrd = %editc(%dec(%char(%date(pceff:*iso):*usa0):8:0):'X');
068700180828           endif;
068800180828
068900180828           dextpi = 'N';
069000180828           if pccur = 'Y';
069100180828            dextpi = 'Y';
069200180828           endif;
069300180828         endif;
069400180828
069500180831        reade (%dec(dssn:9:0) : seq# : 'MED') pcpFile;
069600180828        enddo;
069700180828
069800180828       endsr;
069900180828
070000180312      //===================================================================
070100180312      // Coverage Type
070200180312      //===================================================================
070300180312
070400180312       begsr coverageType;
070500180312
070600180313        if catType = 'MED';
070700180313        endif;
070800180312
070900180313        if catType = 'DEN';
071000180313        endif;
071100180313
071200180313        if catType = 'VIS';
071300180313        endif;
071400180313
071500180312       endsr;
071600180312
071700180824      //===================================================================
071800180824      // Coverage Level
071900180824      //===================================================================
072000180824
072100180824       begsr coverageLevel;
072200180824
072300180824         select;
072400180824          when mcovtp = 'TIN';
072500180824           dcovlvl = '01';
072600180824
072700180824          when mcovtp = 'THW';
072800180824           dcovlvl = '02';
072900180824
073000180824          when mcovtp = 'TPC' or mcovtp = 'TP2';
073100180824           dcovlvl = '03';
073200180824
073300180824          when mcovtp = 'TFA';
073400180824           if drelcd <> 'RPA';
073500180824            dcovlvl = '04';
073600180824           endif;
073700180824
073800180824           if drelcd = 'RPA';
073900180824            dcovlvl = '05';
074000180824           endif;
074100180824         endsl;
074200180824
074300180824       endsr;
074400180824
074500180313      //===================================================================
074600180313      // Determine Type
074700180313      //===================================================================
074800180313
074900180313       begsr determineType;
075000180313
075100180319        catType = ' ';
075200180319
075300180831        chain (mctrst : mcsub# : mcplan) planFile;
075400180824        if %found;
075500180824
075600180824         chain ('P' : %subst(plncat:2:2)) codesFile;
075700180824         if %found;
075800180313
075900180824          select;
076000180824           when action = 'M';
076100180824            catType = 'MED';
076200180313
076300180824           when action = 'D';
076400180824            catType = 'DEN';
076500180313
076600180824           when action = 'V';
076700180824            catType = 'VIS';
076800180827
076900180827           when action = 'R';
077000180827            catType = 'RXD';
077100180824          endsl;
077200180313
077300180824         endif;
077400180824
077500180313        endif;
077600180313
077700180313       endsr;
077800180313
077900180313      //===================================================================
078000180313      // Relationship Codes
078100180313      //===================================================================
078200180313
078300180313       begsr relCodes;
078400180313
078500180313        select;
078600180824         when drelcd = 'RHU' or drelcd = 'RWI';
078700180824          drel = '2';
078800180313
078900180313         when drelcd = 'RDA' or drelcd = 'RSO';
079000180824          drel = '3';
079100180313
079200180824         when drelcd = 'RPA';
079300180824          drel = '4';
079400180313        endsl;
079500180313
079600180313       endsr;
079700180313
079800160511      //===================================================================
079900160511      // exit
080000160511      //===================================================================
080100160511
080200160511       begsr exit;
080300160511
080400160511        *inlr = '1';
080500160511        return;
080600160511
080700160511       endsr;
080800160511
080900160511      //===================================================================
081000160511      // init
081100160511      //===================================================================
081200160520
081300160511       begsr init;
081400160511
081500180829        carrierCode = 'NAS';
081600180823        unique = '0000000261';
081700180309
081800160519        today = %dec(%char(%date:*iso0):8:0);
081900181129        name = 'JOSEPH SMITH & SONS';
082000170710
082100160511       endsr;
082200010412
082300160511       //==============================================================
