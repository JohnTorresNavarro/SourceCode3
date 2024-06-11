000100180831      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400181019      * NASCO010R - Nasco - Generate extract (Antwerpen Automotive)
000500181019      *===========================================================================
000600180313      * Date        Int   Description
000700181019      * ----------  ---   --------------------------------------------------------
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
002000181220     Fmcovc15   if   e           k disk    extfile('F.MCOVC15')
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
003800181019     fnasaadtl  uf a e           k disk    rename(detailr:nasaaFile)
003900160513
004000181019     fnasaatrm  if a e           k disk    rename(nascotr:termFile)
004100181120
004200181128     fcaraccl3  if   e           k disk    rename(caraccr:setupFile)
004300181120
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
006400181128     d name            s             30
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
010800181128        chain (unique : pltrst : plsub# : acc# : name) setupFile;
010900181128        if %found;
011000181204        if castatus = 'Y';
011100181128
011200180831        chain (pltrst : plsub# : acc# : mcssno : plplan) mcovFile2;
011300181203        //if %found;
011400180508
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
012900181212        // endif;
013000180508
013100180823        else;
013200180823         exsr writeMember;
013300180823        endif;
013400180508
013500181128        endif;
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
015300181019        nasaaFile;
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
016600181019         clear nasaaFile;
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
020600181128        dstated = state;
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
024900181220         if candt > 0;
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
027500181019           write nasaaFile;
027600180828          endif;
027700180828          if updateRecord = 'Y';
027800181019           update nasaaFile;
027900180828          endif;
028000180523
028100180828         endif;
028200180523
028300181127         exsr dependent;
028400180827
028500180827        endif;
028600180523
028700160516       endsr;
028800060817
028900180828      //===================================================================
029000180828      // medicare
029100180828      //===================================================================
029200180828
029300180828       begsr medicare;
029400180828
029500180828        select;
029600180829         when mediA > 0 and mediB > 0;
029700180828          dmedein = '3';
029800180828
029900180829         when mediA > 0 and mediB = 0;
030000180828          dmedein = '1';
030100180828
030200180829         when mediA = 0 and mediB > 0;
030300180828          dmedein = '2';
030400180828        endsl;
030500180828
030600180828
030700180828        if dmedein <> '9';
030800181128         if mediA > 0;
030900181128          dmedaeffdt = %editc(%dec(%char(%date(mediA:*iso):*usa0):8:0):'X');
031000181128         endif;
031100181128
031200181128         if mediB > 0;
031300181128          dmedbeffdt = %editc(%dec(%char(%date(mediB:*iso):*usa0):8:0):'X');
031400181128         endif;
031500180828        endif;
031600180828
031700180828       endsr;
031800180828
031900180523      //===================================================================
032000180523      // check termed records;
032100180523      //===================================================================
032200180523
032300180523       begsr checkTerm;
032400180523
032500180523       alreadySent = 'N';
032600180523
032700180523       if termdt > 0;
032800180523
032900180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
033000180523        if %found;
033100180523         alreadySent = 'Y';
033200180523         leavesr;
033300180523        endif;
033400180523
033500180523        if not %found;
033600180523         ttrst = pltrst;
033700180523          tsub# = plsub#;
033800180523           tacct = acc#;
033900180524            tssno = ssn;
034000180523             tseq# = seq#;
034100180523             ttype = ctype;
034200180523            tplan = plplan;
034300180523           ttermdt = termdt;
034400180523          ttrnsdt = %dec(%date);
034500180827         write termFile;
034600180523        endif;
034700180523
034800180523       endif;
034900180523
035000180523       endsr;
035100180524
035200160512      //===================================================================
035300160512      // process
035400160512      //===================================================================
035500160512
035600160512       begsr dependent;
035700160512
035800180831        setll mcssno dependFile;
035900180831        reade mcssno dependFile;
036000160512
036100160512        dow not %eof;
036200160512
036300180831        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
036400160512        if %found;
036500180313         exsr dependentCoverage;
036600160512        endif;
036700160512
036800180831        reade mcssno dependFile;
036900160512        enddo;
037000160512
037100160512    ?  endsr;
037200160512
037300160516      //===============================================================
037400160512      // Dependent coverage
037500160512      //===============================================================
037600160513
037700180313       begsr dependentCoverage;
037800160512
037900180831        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
038000180831        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
038100160512
038200160512        dow not %eof;
038300160512
038400180313         if ccandt <> 0;
038500160512
038600160516          term_dt_limit = %date(ccandt);
038700190118         if ccandt = denrdt;
038800190118          exsr writeDep;
038900190118           leavesr;
039000190118          //if %date() > term_dt_limit;
039100190118          // leavesr;
039200160512          else;
039300160512
039400160516           exsr writeDep;
039500160512          endif;
039600160512
039700160512         else;
039800160516          exsr writeDep;
039900160512          leavesr;
040000160512         endif;
040100160512
040200180831        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) depcovFile;
040300160512        enddo;
040400160512
040500160512       endsr;
040600160512
040700160516      //===============================================================
040800160516      // write dependent
040900160516      //===============================================================
041000160516
041100160516       begsr writeDep;
041200180313
041300180313        updateRecord = 'N';
041400180313        writeRecord = 'N';
041500180313
041600180828        brthMDY = %editc(%dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
041700180828
041800180313        chain
041900180828        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(brthMDY):dlname:dfname:dmi)
042000181019        nasaaFile;
042100180313        if %found;
042200180313         updateRecord = 'Y';
042300180313        else;
042400180313         writeRecord = 'Y';
042500180313        endif;
042600180313
042700180313        exsr determineType;
042800180313        if catType = ' ';
042900180313         leavesr;
043000180313        endif;
043100180313
043200180313        if writeRecord = 'Y';
043300181019         clear nasaaFile;
043400180313        endif;
043500180427
043600180824        drtype = '20';
043700180824        dfiller1 = ' ';
043800180824
043900180824        dssn = %editc(mbssno:'X');
044000180828
044100180823        dlast = dlname;
044200180823        dfirst = dfname;
044300180823        dmit = dmi;
044400180828        dsuffix = ' ';
044500180827        ddob = %editc(%dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
044600180823        dgen = dsex;
044700180828        demp# = ' ';
044800180828        demploc = ' ';
044900180313
045000180828        dempsal = ' ';
045100180828        dempsald = ' ';
045200180828        demphdate = ' ';
045300180828
045400180828        dmatstat = ' ';
045500180828        dmatdate = ' ';
045600180828
045700180828        dstatusi = ' ';
045800180828
045900180823        dadd1 = daddr1;
046000180823        dadd2 = daddr2;
046100181128        dhcity = dcity;
046200181128        dstated = dstate;
046300180823        dhzip = %editc(dzip:'X') + '0000';
046400180828        dharea = %editc(area:'X');
046500180828        dhphone = %editc(phone:'X');
046600180828
046700180828        dwarea = ' ';
046800180828        dwphone = ' ';
046900180313
047000180828        dmbrssn = %editc(depss#:'X');
047100180907        if dmbrssn = '000000000';
047200181220         //dmbrssn = ' ';
047300180907        endif;
047400180907
047500180828        exsr coverageLevel;
047600180828
047700180911        dhic# = dmed#;
047800180911        if dhic# = ' ';
047900180911         dmedein = '9';
048000180911        endif;
048100180911
048200180911        mediA = dmedad;
048300180911        mediB = dmedbd;
048400180911        exsr medicare;
048500180911
048600180828        exsr getGroup;
048700180828
048800180828        exsr relCodes;
048900180313
049000180828        ddisi = 'N';
049100180828        if dhndcp = '3';
049200180828         ddisi = 'Y';
049300180828        endif;
049400180828
049500180828        dstudata = ' ';
049600180828        if dstudn = 'Y';
049700180828         dstudata = 'Y';
049800180828        endif;
049900180313
050000180313        if catType = 'MED';
050100180827
050200180828         dmeffdt = %editc(%dec(%char(%date(denrdt:*iso):*usa0):8:0):'X');
050300181002         if ccandt > 0;
050400180828          dmtermdt = %editc(%dec(%char(%date(ccandt:*iso):*usa0):8:0):'X');
050500180828          dmtermcd = '4';
050600180828         endif;
050700180828
050800180828         seq# = dpseq#;
050900180828         ctype = catType;
051000180828         termdt = ccandt;
051100180828
051200180828         dtcode = 'A';
051300181220         if ccandt > 0;
051400180828          dtcode = 'T';
051500180828         endif;
051600180827
051700180828         dcobi = dcob;
051800180828         if dcobi <> 'Y';
051900180828          dcobi = 'N';
052000180828         endif;
052100180828
052200180828         dhic# = dmed#;
052300180828         if dhic# = ' ';
052400180828          dmedein = '9';
052500180828         endif;
052600180828
052700180828         mediA = dmedad;
052800180828         mediB = dmedbd;
052900180828         exsr medicare;
053000180828
053100180828         exsr pcp;
053200180828
053300180828         dhold = 'X';
053400180828
053500180828         exsr checkTerm;
053600180828         if alreadySent = 'N';
053700180523
053800180828          if writeRecord = 'Y';
053900181019           write nasaaFile;
054000180828          endif;
054100180828          if updateRecord = 'Y';
054200181019           update nasaaFile;
054300180828          endif;
054400160516
054500180828         endif;
054600180827
054700180827        endif;
054800180523
054900160516       endsr;
055000160511
055100180827      //===================================================================
055200180827      // Get group number
055300180827      //===================================================================
055400180827
055500180828       begsr getGroup;
055600180827
055700181127        if plplan = 'EALK' or plplan = 'EALL';
055800180827
055900180827         select;
056000181127          when plplan = 'EALK';
056100181127           dmedg# = '1903048MD10';
056200181127           ddept# = '00001KCGE';
056300180829
056400181127          when plplan = 'EALL';
056500181127           dmedg# = '1903049MD40';
056600181127           ddept# = '00002KCGE';
056700180827         endsl;
056800180911
056900180911         dpckcode = '006';
057000180911         if dmedaeffdt > ' ';
057100181128
057200181128          if mcovtp = 'TMI';
057300181128           dpckcode = '106';
057400181128          endif;
057500181128
057600181128          if mcovtp = 'TMH' or mcovtp = 'TMP';
057700181128           dpckcode = '116';
057800181128          endif;
057900181128
058000181128          if mcovtp = 'TFM' or mcovtp = 'TMF';
058100181128           dpckcode = '126';
058200181128          endif;
058300181128
058400181128         endif;
058500180827
058600181128        endif;
058700180827
058800181127        if plplan = 'EALM' or plplan = 'EALN';
058900180827
059000180827         select;
059100181127          when plplan = 'EALM';
059200181127           dmedg# = '1903050MD10';
059300181203           ddept# = '00001KCGF';
059400180829
059500181127          when plplan = 'EALN';
059600181203           dmedg# = '1903051MD40';
059700181203           ddept# = '00002KCGF';
059800180827
059900180827         endsl;
060000180911
060100180911         dpckcode = '240';
060200181128         if mcovtp <> 'TIN';
060300180911          dpckcode = '241';
060400180911         endif;
060500180827
060600181128         if dmedaeffdt > ' ';
060700181128
060800181128          if mcovtp = 'TMI';
060900181128           dpckcode = '242';
061000181128          endif;
061100181128
061200181128          if mcovtp = 'TMH' or mcovtp = 'TMP';
061300181128           dpckcode = '243';
061400181128          endif;
061500181128
061600181128          if mcovtp = 'TFM' or mcovtp = 'TMF';
061700181128           dpckcode = '244';
061800181128          endif;
061900181128
062000181128         endif;
062100181128
062200180827        endif;
062300180827
062400181127        if plplan = 'EALP' or plplan = 'EALQ';
062500180829
062600180829         select;
062700181127          when plplan = 'EALP';
062800181127           dmedg# = '1903052MD10';
062900181127           ddept# = '00001KCGG';
063000180829
063100181127          when plplan = 'EALQ';
063200181127           dmedg# = '1903053MD40';
063300181127           ddept# = '00002KCGG';
063400180829         endsl;
063500180829
063600181128         dpckcode = '240';
063700181128         if mcovtp <> 'TIN';
063800181128          dpckcode = '241';
063900181128         endif;
064000181128
064100181128         if dmedaeffdt > ' ';
064200181128
064300181128          if mcovtp = 'TMI';
064400181128           dpckcode = '242';
064500181128          endif;
064600181128
064700181128          if mcovtp = 'TMH' or mcovtp = 'TMP';
064800181128           dpckcode = '243';
064900181128          endif;
065000181128
065100181128          if mcovtp = 'TFM' or mcovtp = 'TMF';
065200181128           dpckcode = '244';
065300181128          endif;
065400181128
065500181128         endif;
065600180829
065700180829        endif;
065800180829
065900181127        if plplan = 'EALR' or plplan = 'EALS';
066000181127
066100181127         select;
066200181127          when plplan = 'EALR';
066300181127           dmedg# = '1903054MD10';
066400181127           ddept# = '00001KCGH';
066500181127
066600181127          when plplan = 'EALS';
066700181127           dmedg# = '1903055MD40';
066800181206           ddept# = '00002KCGH';
066900181127
067000181127         endsl;
067100181127
067200181128         dpckcode = '240';
067300181128         if mcovtp <> 'TIN';
067400181128          dpckcode = '241';
067500181128         endif;
067600181128
067700181128         if dmedaeffdt > ' ';
067800181128
067900181128          if mcovtp = 'TMI';
068000181128           dpckcode = '242';
068100181128          endif;
068200181128
068300181128          if mcovtp = 'TMH' or mcovtp = 'TMP';
068400181128           dpckcode = '243';
068500181128          endif;
068600181128
068700181128          if mcovtp = 'TFM' or mcovtp = 'TMF';
068800181128           dpckcode = '244';
068900181128          endif;
069000181128
069100181128         endif;
069200181127
069300181127        endif;
069400181128
069500181203        dcplancd = '690';
069600180827        dhplancd = '580';
069700180827        holdZip = %editc(zip:'X');
069800180827        if (%subst(holdZip:1:3) >= '210' and %subst(holdZip:1:3) <= '219');
069900180827         dhplancd = '690';
070000180827        endif;
070100180827
070200181203        if dstated <> 'DC' and dstated <> 'MD';
070300181203         dhplancd = '690';
070400181203        endif;
070500181203
070600180827        dmprdid = '00';
070700180827
070800180827    ?  endsr;
070900180827
071000180828      //===================================================================
071100180828      // pcp
071200180828      //===================================================================
071300180828
071400180828       begsr pcp;
071500180828
071600180831        setll (%dec(dssn:9:0) : seq# : 'MED') pcpFile;
071700180831        reade (%dec(dssn:9:0) : seq# : 'MED') pcpFile;
071800180828        dow not %eof;
071900180828
072000180828         if pccan = 0;
072100180828          dpcp# = pcid#;
072200180828
072300180828           dpcpeftrd = ' ';
072400180828           if pceff > 0;
072500180828            dpcpeftrd = %editc(%dec(%char(%date(pceff:*iso):*usa0):8:0):'X');
072600180828           endif;
072700180828
072800180828           dextpi = 'N';
072900180828           if pccur = 'Y';
073000180828            dextpi = 'Y';
073100180828           endif;
073200180828         endif;
073300180828
073400180831        reade (%dec(dssn:9:0) : seq# : 'MED') pcpFile;
073500180828        enddo;
073600180828
073700181203        if dmedg# = '1903048MD10' or dmedg# = '1903049MD40';
073800181203         dpcp# = ' ';
073900181203          dpcpeftrd = ' ';
074000181203         dextpi = ' ';
074100181203        endif;
074200181203
074300180828       endsr;
074400180828
074500180312      //===================================================================
074600180312      // Coverage Type
074700180312      //===================================================================
074800180312
074900180312       begsr coverageType;
075000180312
075100180313        if catType = 'MED';
075200180313        endif;
075300180312
075400180313        if catType = 'DEN';
075500180313        endif;
075600180313
075700180313        if catType = 'VIS';
075800180313        endif;
075900180313
076000180312       endsr;
076100180312
076200180824      //===================================================================
076300180824      // Coverage Level
076400180824      //===================================================================
076500180824
076600180824       begsr coverageLevel;
076700180824
076800180824         select;
076900180824          when mcovtp = 'TIN';
077000180824           dcovlvl = '01';
077100180824
077200180824          when mcovtp = 'THW';
077300180824           dcovlvl = '02';
077400180824
077500180824          when mcovtp = 'TPC' or mcovtp = 'TP2';
077600180824           dcovlvl = '03';
077700180824
077800180824          when mcovtp = 'TFA';
077900180824           if drelcd <> 'RPA';
078000180824            dcovlvl = '04';
078100180824           endif;
078200180824
078300180824           if drelcd = 'RPA';
078400180824            dcovlvl = '05';
078500180824           endif;
078600180824         endsl;
078700180824
078800180824       endsr;
078900180824
079000180313      //===================================================================
079100180313      // Determine Type
079200180313      //===================================================================
079300180313
079400180313       begsr determineType;
079500180313
079600180319        catType = ' ';
079700180319
079800180831        chain (mctrst : mcsub# : mcplan) planFile;
079900180824        if %found;
080000180824
080100180824         chain ('P' : %subst(plncat:2:2)) codesFile;
080200180824         if %found;
080300180313
080400180824          select;
080500180824           when action = 'M';
080600180824            catType = 'MED';
080700180313
080800180824           when action = 'D';
080900180824            catType = 'DEN';
081000180313
081100180824           when action = 'V';
081200180824            catType = 'VIS';
081300180827
081400180827           when action = 'R';
081500180827            catType = 'RXD';
081600180824          endsl;
081700180313
081800180824         endif;
081900180824
082000180313        endif;
082100180313
082200180313       endsr;
082300180313
082400180313      //===================================================================
082500180313      // Relationship Codes
082600180313      //===================================================================
082700180313
082800180313       begsr relCodes;
082900180313
083000180313        select;
083100180824         when drelcd = 'RHU' or drelcd = 'RWI';
083200180824          drel = '2';
083300180313
083400180313         when drelcd = 'RDA' or drelcd = 'RSO';
083500180824          drel = '3';
083600180313
083700180824         when drelcd = 'RPA';
083800180824          drel = '4';
083900180313        endsl;
084000180313
084100180313       endsr;
084200180313
084300160511      //===================================================================
084400160511      // exit
084500160511      //===================================================================
084600160511
084700160511       begsr exit;
084800160511
084900160511        *inlr = '1';
085000160511        return;
085100160511
085200160511       endsr;
085300160511
085400160511      //===================================================================
085500160511      // init
085600160511      //===================================================================
085700160520
085800160511       begsr init;
085900160511
086000180829        carrierCode = 'NAS';
086100180823        unique = '0000000261';
086200181128        name = 'ANTWERPEN AUTOMOTIVE';
086300180309
086400160519        today = %dec(%char(%date:*iso0):8:0);
086500170710
086600160511       endsr;
086700010412
086800160511       //==============================================================
