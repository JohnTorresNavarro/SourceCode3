000100180831      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400200427      * NASPV010R - Nasco - Generate ext (MED) Pivot
000500181019      *===========================================================================
000600180313      * Date        Int   Description
000700181019      * ----------  ---   --------------------------------------------------------
000800210630      * 04/27/2020  jt    Original creation
000801210324      * 03/24/2021  jt    Sending 'X' for all members in position 1350
000802210630      * 06/30/2021  jt    Added status for dependents.
000803210722      * 07/22/2021  jt    Blank out phone number when 0
000804220824      * 08/24/2022  jt    Sending blanks when dep. SSN = to 000000000
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
003800200427     fnaspvdtl  uf a e           k disk    rename(detailr:naspvFile)
003900160513
004000200427     fnaspvtrm  if a e           k disk    rename(nascotr:termFile)
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
008901200427          if plplan = 'DGVJ' or plplan = 'DGVR' or plplan = 'DGVU' or
008902200427           plplan = 'DGVX' or plplan = 'DGV0' or plplan = 'DGV3' or
008903200427            plplan = 'DGV6' or plplan = 'DGV9';
008904200427
009000200427           exsr process;
009001200427
009100200427          endif;
009101200427
009200180831         reade (pltrst : plsub# : plplan) mcovFile;
009300180830         enddo;
009400180830
009500180831        reade carrierCode planFile2;
009600180830        enddo;
009601220929
009602220929        exsr clearZeros;
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
011000200427         if castatus = 'Y';
011100181128
011200200427         chain (pltrst : plsub# : acc# : mcssno : plplan) mcovFile2;
011400180508
011500200427         // if record is termed see if we need to stop sending...
011600200427          if candt <> 0;
011700180508
011800200427           term_dt_limit = %date(candt);
011900181203
012000200427            if candt = enrldt;
012100200427             exsr writeMember;
012200200427             leavesr;
012300200427            endif;
012400181203
012800200427           exsr writeMember;
013000180508
013100200427          else;
013200200427           exsr writeMember;
013300200427          endif;
013400180508
013500200427         endif;
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
015300200427        naspvFile;
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
016600200427         clear naspvFile;
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
018100180828
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
020701210722
020800180828        dharea = %editc(area:'X');
020900180828        dhphone = %editc(phone:'X');
020901210722        if dharea = '000' or dhphone = '0000000';
020902210722         dharea = ' ';
020903210722         dhphone = ' ';
020904210722        endif;
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
026602210324         dfiller10 = %replace('X':dfiller10:141);
026603210324
027100180828         exsr checkTerm;
027200180828         if alreadySent = 'N';
027300180523
027400180828          if writeRecord = 'Y';
027500200427           write naspvFile;
027600180828          endif;
027700180828          if updateRecord = 'Y';
027800200427           update naspvFile;
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
037100200427       endsr;
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
042000200427        naspvFile;
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
043300200427         clear naspvFile;
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
044900180313
045400180828        dmatstat = ' ';
045500180828        dmatdate = ' ';
045600180828
045700210630        //dstatusi = ' ';
045701210630        select;
045702210630         when empst = 'A';
045703210630          dstatusi = 'A';
045704210630         when empst = 'R';
045705210630          dstatusi = 'R';
045706210630         when empst = 'C';
045707210630          dstatusi = 'C';
045708210630        endsl;
045800180828
045900180823        dadd1 = daddr1;
046000180823        dadd2 = daddr2;
046100181128        dhcity = dcity;
046200181128        dstated = dstate;
046300180823        dhzip = %editc(dzip:'X') + '0000';
046301210722
046400180828        dharea = %editc(area:'X');
046500180828        dhphone = %editc(phone:'X');
046901210722        if dharea = '000' or dhphone = '0000000';
046902210722         dharea = ' ';
046903210722         dhphone = ' ';
046904210722        endif;
046905210722
047000180828        dmbrssn = %editc(depss#:'X');
047100221005        //if dmbrssn = '000000000';
047200221005        // dmbrssn = ' ';
047300221005        //endif;
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
053400180828
053401210324         dfiller10 = %replace('X':dfiller10:141);
053402210324
053500180828         exsr checkTerm;
053600180828         if alreadySent = 'N';
053700180523
053800180828          if writeRecord = 'Y';
053900200427           write naspvFile;
054000180828          endif;
054100180828          if updateRecord = 'Y';
054200200427           update naspvFile;
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
055700200427        if plplan = 'DGVJ' or plplan = 'DGVR';
055800180827
055900180827         select;
056000200427          when plplan = 'DGVJ';
056100200427           dmedg# = '1903287';
056101200427           dmedsec# = 'MD10';
056300180829
056400200427          when plplan = 'DGVR';
056500200427           dmedg# = '1903288';
056501200427           dmedsec# = 'MD40';
056700180827         endsl;
056701200427
056702200427         exsr getDept;
056800180911
056900200427         select;
056901200427          when mcovtp = 'TIN';
056902200427           dpckcode = '006';
056903200427
056904200427          when mcovtp = 'TPC' or mcovtp = 'TP2' or mcovtp = 'THW'  or
056905200427               mcovtp = 'TFM' or mcovtp = 'TFA';
056906200427           dpckcode = '016';
056907200427
056908200427          //when mcovtp = 'TPC' or mcovtp = 'TP2';
056909200427          // dpckcode = '026';
056911200427         endsl;
056912200427
057000180911         if dmedaeffdt > ' ';
057100181128
057101200427          select;
057200200427           when mcovtp = 'TMI';
057300200427            dpckcode = '106';
057301200427
057302200427           when mcovtp = 'TMH' or mcovtp = 'TMP' or
057303200427                mcovtp = 'TFM' or mcovtp = 'TMF' or mcovtp = 'TFA';
057304200427            dpckcode = '116';
057305200427
057306200427           //when mcovtp = 'TFM' or mcovtp = 'TMF';
057307200427           // dpckcode = '126';
057308200427          endsl;
057309200427
057400200427         endif;
058300181128
058400200427        endif;
058500180827
058800200427        if plplan = 'DGVU' or plplan = 'DGVX';
058900180827
059000180827         select;
059100200427          when plplan = 'DGVU';
059200200427           dmedg# = '1903289';
059201200427           dmedsec# = 'MD10';
059400180829
059500200427          when plplan = 'DGVX';
059600200427           dmedg# = '1903290';
059601200427           dmedsec# = 'MD40';
059900180827         endsl;
060000180911
060001200427         exsr getDept;
060002200427
060003200427         select;
060004200427          when mcovtp = 'TIN';
060005200427           dpckcode = '036';
060006200427
060007200427          when mcovtp = 'TPC' or mcovtp = 'TP2' or mcovtp = 'THW'  or
060008200427               mcovtp = 'TFM' or mcovtp = 'TFA';
060009200427           dpckcode = '046';
060010200427
060011200427          //when mcovtp = 'TPC' or mcovtp = 'TP2';
060012200427          // dpckcode = '026';
060013200427         endsl;
060014200427
060600181128         if dmedaeffdt > ' ';
060601200427
060700200427          select;
060800200427           when mcovtp = 'TMI';
060900200427            dpckcode = '136';
061100181128
061200200427           when mcovtp = 'TMH' or mcovtp = 'TMP';
061300200427            dpckcode = '146';
061400200427
061600200427           //when mcovtp = 'TFM' or mcovtp = 'TMF';
061700200427           // dpckcode = '156';
061701200427          endsl;
061900181128
062000200427         endif;
062001200427
062002200427        endif;
062003200427
062400200427        if plplan = 'DGV0' or plplan = 'DGV3';
062500180829
062600180829         select;
062700200427          when plplan = 'DGV0';
062800200427           dmedg# = '1903291';
062801200427           dmedsec# = 'MD10';
063000180829
063100200427          when plplan = 'DGV3';
063200200427           dmedg# = '1903292';
063201200427           dmedsec# = 'MD40';
063400180829         endsl;
063500180829
063501200427         exsr getDept;
063502200427
063503200427         select;
063504200427          when mcovtp = 'TIN';
063505200427           dpckcode = '006';
063506200427
063507200427          when mcovtp = 'TPC' or mcovtp = 'TP2' or mcovtp = 'THW'  or
063508200427               mcovtp = 'TFM' or mcovtp = 'TFA';
063509200427           dpckcode = '016';
063510200427
063511200427          //when mcovtp = 'TPC' or mcovtp = 'TP2';
063512200427          // dpckcode = '026';
063513200427         endsl;
063514200427
064100181128         if dmedaeffdt > ' ';
064200181128
064201200427          select;
064300200427           when mcovtp = 'TMI';
064400200427            dpckcode = '106';
064600181128
064700200427           when mcovtp = 'TMH' or mcovtp = 'TMP';
064800200427            dpckcode = '116';
065000181128
065100200427           //when mcovtp = 'TFM' or mcovtp = 'TMF';
065200200427           // dpckcode = '126';
065201200427          endsl;
065400181128
065500181128         endif;
065600180829
065700180829        endif;
065800180829
065900200427        if plplan = 'DGV6' or plplan = 'DGV9';
066000181127
066100181127         select;
066200200427          when plplan = 'DGV6';
066300200427           dmedg# = '1903293';
066301200427           dmedsec# = 'MD10';
066500181127
066600200427          when plplan = 'DGV9';
066700200427           dmedg# = '1903294';
066701200427           dmedsec# = 'MD40';
067000181127         endsl;
067001200427
067002200427         exsr getDept;
067100181127
067101200427         select;
067105200427          when mcovtp = 'TIN' or mcovtp = 'TPC' or mcovtp = 'TP2' or
067106200427               mcovtp = 'THW' or mcovtp = 'TFM' or mcovtp = 'TFA';
067107200427           dpckcode = '006';
067108200427
067109200427          //when mcovtp = 'TPC' or mcovtp = 'TP2';
067110200427          // dpckcode = '106';
067111200427         endsl;
067600181128
067700181128         if dmedaeffdt > ' ';
067800181128
067801200427          select;
067802200427           when mcovtp = 'TMI';
067803200427            dpckcode = '106';
067804200427
067805200427           when mcovtp = 'TMH' or mcovtp = 'TMP';
067806200427            dpckcode = '116';
067807200427
067808200427           //when mcovtp = 'TFM' or mcovtp = 'TMF';
067809200427           // dpckcode = '126';
067810200427          endsl;
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
070800200427       endsr;
070900180827
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
084201200427      //===================================================================
084202200427      // get department
084203200427      //===================================================================
084204200427
084205200427       begsr getDept;
084206200427
084210200427        if plplan = 'DGVJ';
084211200427
084212200427         select;
084213200427          when ccflg = 'Yph';
084214200427           ddept# = '00000K0T4';
084216200427
084217200427          when ccflg = 'Ypm';
084218200427           ddept# = '00000K0T6';
084219200427
084220200427          when ccflg = 'Ypr';
084221200427           ddept# = '00001K0T6';
084222200427
084223200427          when ccflg = 'Ypd';
084224200427           ddept# = '00002K0T6';
084225200427
084226200427          when ccflg = 'Ypg';
084227200427           ddept# = '00003K0T6';
084228200427
084229200427          when ccflg = 'Ypp';
084230200427           ddept# = '00000K0T8';
084231200427
084232200427          when ccflg = 'Ypb';
084233200427           ddept# = '00000K0U0';
084234200427
084235200427          when ccflg = 'Ypl';
084236200427           ddept# = '00000K0U2';
084237200427
084238200427          when ccflg = 'Ypt';
084239200427           ddept# = '00000K0U4';
084240200427
084241200427          when ccflg = 'Ypa';
084242200427           ddept# = '00000K0U6';
084243200427
084244200427          when ccflg = 'Ypk';
084245200427           ddept# = '00000K0U8';
084246200427
084247200427          when ccflg = 'Ypf';
084248200427           ddept# = '00000K0V0';
084249200427
084250200427          when ccflg = 'Ypc';
084251200427           ddept# = '00000K0V2';
084252200427
084253200427          when ccflg = 'Ype';
084254200427           ddept# = '00000K0V4';
084255200427
084256200427          when ccflg = 'Ypi';
084257200427           ddept# = '00000K0V6';
084258200427
084259200427          when ccflg = 'Ypn';
084260200427           ddept# = '00000K0V8';
084261200427
084262200427          when ccflg = 'Ypj';
084263200427           ddept# = '00000K0W0';
084264200427
084265200427          when ccflg = 'Ypo';
084266200427           ddept# = '00000K0W2';
084267200427
084268200427          when ccflg = 'Ypq';
084269200427           ddept# = '00000KBAL';
084270200427
084271200427          when ccflg = 'Yps';
084272200427           ddept# = '00000KBAQ';
084274200427         endsl;
084275200427
084276200427        endif;
084277200427
084278200427        if plplan = 'DGVR';
084279200427
084280200427         select;
084281200427          when ccflg = 'Yph';
084282200427           ddept# = '00000K0T5';
084283200427
084284200427          when ccflg = 'Ypm';
084285200427           ddept# = '00000K0T7';
084286200427
084287200427          when ccflg = 'Ypr';
084288200427           ddept# = '00001K0T7';
084289200427
084290200427          when ccflg = 'Ypd';
084291200427           ddept# = '00002K0T7';
084292200427
084293200427          when ccflg = 'Ypg';
084294200427           ddept# = '00003K0T7';
084295200427
084296200427          when ccflg = 'Ypp';
084297200427           ddept# = '00000K0T9';
084298200427
084299200427          when ccflg = 'Ypb';
084300200427           ddept# = '00000K0U1';
084301200427
084302200427          when ccflg = 'Ypl';
084303200427           ddept# = '00000K0U3';
084304200427
084305200427          when ccflg = 'Ypt';
084306200427           ddept# = '00000K0U5';
084307200427
084308200427          when ccflg = 'Ypa';
084309200427           ddept# = '00000K0U7';
084310200427
084311200427          when ccflg = 'Ypk';
084312200427           ddept# = '00000K0U9';
084313200427
084314200427          when ccflg = 'Ypf';
084315200427           ddept# = '00000K0V1';
084316200427
084317200427          when ccflg = 'Ypc';
084318200427           ddept# = '00000K0V3';
084319200427
084320200427          when ccflg = 'Ype';
084321200427           ddept# = '00000K0V5';
084322200427
084323200427          when ccflg = 'Ypi';
084324200427           ddept# = '00000K0V7';
084325200427
084326200427          when ccflg = 'Ypn';
084327200427           ddept# = '00000K0V9';
084328200427
084329200427          when ccflg = 'Ypj';
084330200427           ddept# = '00000K0W1';
084331200427
084332200427          when ccflg = 'Ypo';
084333200427           ddept# = '00000K0W3';
084334200427
084335200427          when ccflg = 'Ypq';
084336200427           ddept# = '00000KBAM';
084337200427
084338200427          when ccflg = 'Yps';
084339200427           ddept# = '00000KBAR';
084340200427         endsl;
084341200427
084342200427        endif;
084343200427
084344200427        if plplan = 'DGVU';
084345200427
084346200427         select;
084347200427          when ccflg = 'Yph';
084348200427           ddept# = '00000K0W4';
084349200427
084350200427          when ccflg = 'Ypm';
084351200427           ddept# = '00000K0W6';
084352200427
084353200427          when ccflg = 'Ypr';
084354200427           ddept# = '00001K0W6';
084355200427
084356200427          when ccflg = 'Ypd';
084357200427           ddept# = '00002K0W6';
084358200427
084359200427          when ccflg = 'Ypg';
084360200427           ddept# = '00003K0W6';
084361200427
084362200427          when ccflg = 'Ypp';
084363200427           ddept# = '00000K0W8';
084364200427
084365200427          when ccflg = 'Ypb';
084366200427           ddept# = '00000K0X0';
084367200427
084368200427          when ccflg = 'Ypl';
084369200427           ddept# = '00000K0X2';
084370200427
084371200427          when ccflg = 'Ypt';
084372200427           ddept# = '00000K0X4';
084373200427
084374200427          when ccflg = 'Ypa';
084375200427           ddept# = '00000K0X6';
084376200427
084377200427          when ccflg = 'Ypk';
084378200427           ddept# = '00000K0X8';
084379200427
084380200427          when ccflg = 'Ypf';
084381200427           ddept# = '00000K0Y0';
084382200427
084383200427          when ccflg = 'Ypc';
084384200427           ddept# = '00000K0Y2';
084385200427
084386200427          when ccflg = 'Ype';
084387200427           ddept# = '00000K0Z4';
084388200427
084389200427          when ccflg = 'Ypi';
084390200427           ddept# = '00000K0Z6';
084391200427
084392200427          when ccflg = 'Ypn';
084393200427           ddept# = '00000K0Z8';
084394200427
084395200427          when ccflg = 'Ypj';
084396200427           ddept# = '00000K0AA';
084397200427
084398200427          when ccflg = 'Ypo';
084399200427           ddept# = '00000K0AC';
084400200427
084401200427          when ccflg = 'Ypq';
084402200427           ddept# = '00000KBAN';
084403200427
084404200427          when ccflg = 'Yps';
084405200427           ddept# = '00000KBAS';
084406200427         endsl;
084407200427
084408200427        endif;
084409200427
084410200427        if plplan = 'DGVX';
084411200427
084412200427         select;
084413200427          when ccflg = 'Yph';
084414200427           ddept# = '00000K0W5';
084415200427
084416200427          when ccflg = 'Ypm';
084417200427           ddept# = '00000K0W7';
084418200427
084419200427          when ccflg = 'Ypr';
084420200427           ddept# = '00001K0W7';
084421200427
084422200427          when ccflg = 'Ypd';
084423200427           ddept# = '00002K0W7';
084424200427
084425200427          when ccflg = 'Ypg';
084426200427           ddept# = '00003K0W7';
084427200427
084428200427          when ccflg = 'Ypp';
084429200427           ddept# = '00000K0W9';
084430200427
084431200427          when ccflg = 'Ypb';
084432200427           ddept# = '00000K0X1';
084433200427
084434200427          when ccflg = 'Ypl';
084435200427           ddept# = '00000K0X3';
084436200427
084437200427          when ccflg = 'Ypt';
084438200427           ddept# = '00000K0X5';
084439200427
084440200427          when ccflg = 'Ypa';
084441200427           ddept# = '00000K0X7';
084442200427
084443200427          when ccflg = 'Ypk';
084444200427           ddept# = '00000K0X9';
084445200427
084446200427          when ccflg = 'Ypf';
084447200427           ddept# = '00000K0Y1';
084448200427
084449200427          when ccflg = 'Ypc';
084450200427           ddept# = '00000K0Y3';
084451200427
084452200427          when ccflg = 'Ype';
084453200427           ddept# = '00000K0Z5';
084454200427
084455200427          when ccflg = 'Ypi';
084456200427           ddept# = '00000K0Z7';
084457200427
084458200427          when ccflg = 'Ypn';
084459200427           ddept# = '00000K0Z9';
084460200427
084461200427          when ccflg = 'Ypj';
084462200427           ddept# = '00000K0AB';
084463200427
084464200427          when ccflg = 'Ypo';
084465200427           ddept# = '00000K0AD';
084466200427
084467200427          when ccflg = 'Ypq';
084468200427           ddept# = '00000KBAP';
084469200427
084470200427          when ccflg = 'Yps';
084471200427           ddept# = '00000KBAT';
084472200427         endsl;
084473200427
084474200427        endif;
084475200427
084476200427        if plplan = 'DGV0';
084477200427
084478200427         select;
084479200427          when ccflg = 'Yph';
084480200427           ddept# = '00000K0AE';
084481200427
084482200427          when ccflg = 'Ypm';
084483200427           ddept# = '00000K0AG';
084484200427
084485200427          when ccflg = 'Ypr';
084486200427           ddept# = '00001K0AG';
084487200427
084488200427          when ccflg = 'Ypd';
084489200427           ddept# = '00002K0AG';
084490200427
084491200427          when ccflg = 'Ypg';
084492200427           ddept# = '00003K0AG';
084493200427
084494200427          when ccflg = 'Ypp';
084495200427           ddept# = '00000K0AJ';
084496200427
084497200427          when ccflg = 'Ypb';
084498200427           ddept# = '00000K0AL';
084499200427
084500200427          when ccflg = 'Ypl';
084501200427           ddept# = '00000K0AN';
084502200427
084503200427          when ccflg = 'Ypt';
084504200427           ddept# = '00000K0AQ';
084505200427
084506200427          when ccflg = 'Ypa';
084507200427           ddept# = '00000K0AS';
084508200427
084509200427          when ccflg = 'Ypk';
084510200427           ddept# = '00000K0BL';
084511200427
084512200427          when ccflg = 'Ypf';
084513200427           ddept# = '00000K0BN';
084514200427
084515200427          when ccflg = 'Ypc';
084516200427           ddept# = '00000K0BQ';
084517200427
084518200427          when ccflg = 'Ype';
084519200427           ddept# = '00000K0BS';
084520200427
084521200427          when ccflg = 'Ypi';
084522200427           ddept# = '00000K0BU';
084523200427
084524200427          when ccflg = 'Ypn';
084525200427           ddept# = '00000K0BW';
084526200427
084527200427          when ccflg = 'Ypj';
084528200427           ddept# = '00000K0BY';
084529200427
084530200427          when ccflg = 'Ypo';
084531200427           ddept# = '00000K0CA';
084532200427
084533200427          when ccflg = 'Ypq';
084534200427           ddept# = '00000KBAU';
084535200427
084536200427          when ccflg = 'Yps';
084537200427           ddept# = '00000KBAW';
084538200427         endsl;
084539200427
084540200427        endif;
084541200427
084542200427        if plplan = 'DGV3';
084543200427
084544200427         select;
084545200427          when ccflg = 'Yph';
084546200427           ddept# = '00000K0AF';
084547200427
084548200427          when ccflg = 'Ypm';
084549200427           ddept# = '00000K0AH';
084550200427
084551200427          when ccflg = 'Ypr';
084552200427           ddept# = '00001K0AH';
084553200427
084554200427          when ccflg = 'Ypd';
084555200427           ddept# = '00002K0AH';
084556200427
084557200427          when ccflg = 'Ypg';
084558200427           ddept# = '00003K0AH';
084559200427
084560200427          when ccflg = 'Ypp';
084561200427           ddept# = '00000K0AK';
084562200427
084563200427          when ccflg = 'Ypb';
084564200427           ddept# = '00000K0AM';
084565200427
084566200427          when ccflg = 'Ypl';
084567200427           ddept# = '00000K0AP';
084568200427
084569200427          when ccflg = 'Ypt';
084570200427           ddept# = '00000K0AR';
084571200427
084572200427          when ccflg = 'Ypa';
084573200427           ddept# = '00000K0AT';
084574200427
084575200427          when ccflg = 'Ypk';
084576200427           ddept# = '00000K0BM';
084577200427
084578200427          when ccflg = 'Ypf';
084579200427           ddept# = '00000K0BP';
084580200427
084581200427          when ccflg = 'Ypc';
084582200427           ddept# = '00000K0BR';
084583200427
084584200427          when ccflg = 'Ype';
084585200427           ddept# = '00000K0BT';
084586200427
084587200427          when ccflg = 'Ypi';
084588200427           ddept# = '00000K0BV';
084589200427
084590200427          when ccflg = 'Ypn';
084591200427           ddept# = '00000K0BX';
084592200427
084593200427          when ccflg = 'Ypj';
084594200427           ddept# = '00000K0BZ';
084595200427
084596200427          when ccflg = 'Ypo';
084597200427           ddept# = '00000K0CB';
084598200427
084599200427          when ccflg = 'Ypq';
084600200427           ddept# = '00000KBAV';
084601200427
084602200427          when ccflg = 'Yps';
084603200427           ddept# = '00000KBAX';
084604200427         endsl;
084605200427
084606200427        endif;
084607200427
084608200427        if plplan = 'DGV6';
084609200427
084610200427         select;
084611200427          when ccflg = 'Yph';
084612200427           ddept# = '00001KCSG';
084613200427
084614200427          when ccflg = 'Ypm';
084615200427           ddept# = '00002KCSG';
084616200427
084617200427          when ccflg = 'Ypr';
084618200427           ddept# = '00003KCSG';
084619200427
084620200427          when ccflg = 'Ypd';
084621200427           ddept# = '00004KCSG';
084622200427
084623200427          when ccflg = 'Ypg';
084624200427           ddept# = '00005KCSG';
084625200427
084626200427          when ccflg = 'Ypp';
084627200427           ddept# = '00006KCSG';
084628200427
084629200427          when ccflg = 'Ypb';
084630200427           ddept# = '00007KCSG';
084631200427
084632200427          when ccflg = 'Ypl';
084633200427           ddept# = '00008KCSG';
084634200427
084635200427          when ccflg = 'Ypt';
084636200427           ddept# = '00009KCSG';
084637200427
084638200427          when ccflg = 'Ypa';
084639200427           ddept# = '00010KCSG';
084640200427
084641200427          when ccflg = 'Ypk';
084642200427           ddept# = '00011KCSG';
084643200427
084644200427          when ccflg = 'Ypf';
084645200427           ddept# = '00012KCSG';
084646200427
084647200427          when ccflg = 'Ypc';
084648200427           ddept# = '00013KCSG';
084649200427
084650200427          when ccflg = 'Ype';
084651200427           ddept# = '00014KCSG';
084652200427
084653200427          when ccflg = 'Ypi';
084654200427           ddept# = '00015KCSG';
084655200427
084656200427          when ccflg = 'Ypn';
084657200427           ddept# = '00016KCSG';
084658200427
084659200427          when ccflg = 'Ypj';
084660200427           ddept# = '00017KCSG';
084661200427
084662200427          when ccflg = 'Ypo';
084663200427           ddept# = '00018KCSG';
084664200427
084665200427          when ccflg = 'Ypq';
084666200427           ddept# = '00019KCSG';
084667200427
084668200427          when ccflg = 'Yps';
084669200427           ddept# = '00020KCSG';
084670200427         endsl;
084671200427
084672200427        endif;
084673200427
084674200427        if plplan = 'DGV9';
084675200427
084676200427         select;
084677200427          when ccflg = 'Yph';
084678200427           ddept# = '00001KCSH';
084679200427
084680200427          when ccflg = 'Ypm';
084681200427           ddept# = '00002KCSH';
084682200427
084683200427          when ccflg = 'Ypr';
084684200427           ddept# = '00003KCSH';
084685200427
084686200427          when ccflg = 'Ypd';
084687200427           ddept# = '00004KCSH';
084688200427
084689200427          when ccflg = 'Ypg';
084690200427           ddept# = '00005KCSH';
084691200427
084692200427          when ccflg = 'Ypp';
084693200427           ddept# = '00006KCSH';
084694200427
084695200427          when ccflg = 'Ypb';
084696200427           ddept# = '00007KCSH';
084697200427
084698200427          when ccflg = 'Ypl';
084699200427           ddept# = '00008KCSH';
084700200427
084701200427          when ccflg = 'Ypt';
084702200427           ddept# = '00009KCSH';
084703200427
084704200427          when ccflg = 'Ypa';
084705200427           ddept# = '00010KCSH';
084706200427
084707200427          when ccflg = 'Ypk';
084708200427           ddept# = '00011KCSH';
084709200427
084710200427          when ccflg = 'Ypf';
084711200427           ddept# = '00012KCSH';
084712200427
084713200427          when ccflg = 'Ypc';
084714200427           ddept# = '00013KCSH';
084715200427
084716200427          when ccflg = 'Ype';
084717200427           ddept# = '00014KCSH';
084718200427
084719200427          when ccflg = 'Ypi';
084720200427           ddept# = '00015KCSH';
084721200427
084722200427          when ccflg = 'Ypn';
084723200427           ddept# = '00016KCSH';
084724200427
084725200427          when ccflg = 'Ypj';
084726200427           ddept# = '00017KCSH';
084727200427
084728200427          when ccflg = 'Ypo';
084729200427           ddept# = '00018KCSH';
084730200427
084731200427          when ccflg = 'Ypq';
084732200427           ddept# = '00019KCSH';
084733200427
084734200427          when ccflg = 'Yps';
084735200427           ddept# = '00020KCSH';
084736200427         endsl;
084737200427
084738200427        endif;
084739200427
084740200427       endsr;
084741200427
084742220929      //===================================================================
084743220929      // clear dependents 000000000
084744220929      //===================================================================
084745220929
084746220929       begsr clearZeros;
084747220929
084748220929        setll *loval naspvFile;
084767220929        read naspvFile;
084768220929        dow not %eof;
084769220929
084770221004         if dmbrssn = '000000000';
084771221004          dmbrssn = ' ';
084772221004         endif;
084773221004
084774221004         update naspvFile;
084775220929
084776220929        read naspvFile;
084777220929        enddo;
084778220929
084779220929       endsr;
084780220929
084781160511      //===================================================================
084782160511      // exit
084783160511      //===================================================================
084784160511
084785160511       begsr exit;
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
086200200427        name = 'PT NETWORK';
086300180309
086400160519        today = %dec(%char(%date:*iso0):8:0);
086401210324
086600160511       endsr;
086700010412
086800160511       //==============================================================
