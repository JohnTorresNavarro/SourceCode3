000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400191002      * METLIF010R - Melife  - Medical extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800191002      * 10/03/2018  jt    Original creation
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200180427     F                                     rename(accmsr:actFile)
001300180427
001400180427     Fac2mstl2  if   e           k disk    rename(accmsr2:act2File)
001500180427
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
001800160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001900160516     F                                     rename(PLNMSR:PLNR) prefix(P)
002000170619
002100180313     Fmcov39    if   e           k disk    extfile('F.MCOV39')
002200170619
002400190923     Fmcovc16   if   e           k disk    extfile('F.MCOVC16')
002500190923     F                                     rename(mcovr:covc16)
002600160513
002700160516     Fmcov      if   e           k disk    extfile('F.MCOV')
002800160516     F                                     rename(MCOVR:COVR) Prefix(M)
002900160513
003000180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003100160513
003200160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003300160513
003400160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003500160518
003600160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003700160518
003800180313     fcodes     if   e           k disk    extfile('F.CODES')
003900180313     f                                     rename(codesr:codesFile)
004000190514
004100191003     f*aacodel1  if   e           k disk    rename(aacodr:aaFile)
004200180313
004500191003     f*carplnm   if   e           k disk    rename(carplnr:planFile)
004600180523
004700191003     fmetlifmd  if a e           k disk    rename(metlifmr:metFile)
004701191002
004702191002     fmetransoffif   e           k disk    rename(mtof:transOff)
004800160513
004900191003     fmetlifetrmif a e           k disk    rename(mettrmr:termFile)
005000190514
005100191003     f*cignafier o    e             disk    rename(cignaer:errorFile)
005200180523
005300160512      *=================================================================
005400061017
005500180309     d carrierCode     s              3
005600180309     d carrierCode1    s              3
005700180309     d carrierCode2    s              3
005800160519     d term_dt_limit   s               d
005900180913     d cancelDate      s               d
006000180913     d cancelh         s              8  0
006100160519     d today           s              8  0
006200191003     d bcode           s              3
006300180313     d yrsService      s              8  0
006400180313     d catType         s              3
006500180313     d updateRecord    s              1
006600180313     d writeRecord     s              1
006700191002     d skip            s              1
006800180605     d pos2            s              2  0
006900180523     d unique          s             10
007001191003     d alreadySent     s              1
007100180523     d ssn             s              9  0
007200180523     d seq#            s              2  0
007300180523     d ctype           s              3
007400180523     d termdt          s              8  0
007500180523     d covtp           s              2
007501191003
007502191003     d metlif010r      pi
007503191003     d  intype                        3
007600150820
007700160511      //==================================================================
007800160511      // mainline
007900160511      //===================================================================
008000150820
008100160511       exsr init;
008200160511       exsr main;
008300160511       exsr exit;
008400160511
008500160511      //===================================================================
008600160511      // main
008700160511      //===================================================================
008800160511
008900160511       begsr main;
009000160511
009100180309        carrierCode = carrierCode1;
009200180309        exsr main2;
009300180309
009400180309        carrierCode = carrierCode2;
009500180309        exsr main2;
009600180424
009700191003        //exsr clearSSN;
009800180424
009900160511       endsr;
010000160511
010100180309      //===================================================================
010200180309      // main2
010300180309      //===================================================================
010400180309
010500180309       begsr main2;
010600180309
010700180309        setll carrierCode plnmsr;
010800180309        reade carrierCode plnmsr;
010900180309
011000180309        dow not %eof;
011100180309
011200180313         setll (pltrst : plsub# : plplan) mcov39;
011300180313         reade (pltrst : plsub# : plplan) mcov39;
011400180313
011500180313         dow not %eof;
011600180309
011700180313          exsr process;
011800180309
011900180313         reade (pltrst : plsub# : plplan) mcov39;
012000180313         enddo;
012100180309
012200180309        reade carrierCode plnmsr;
012300180309        enddo;
012400180309
012500180309       endsr;
012600180309
012700160511      //===================================================================
012800160511      // process
012900160511      //===================================================================
013000160511
013100160511       begsr process;
013200160511
013300191002        chain (mctrst : mcsub# : acc#) transoff;
013400191002        if %found and today > mtolasdte and mtolasdte <> 0;
013600191002         skip = 'Y';
013601191002        else;
013602191002         skip = 'N';
013603191002        endif;
013604191002
013605191002        if skip = 'N';
013700180523         chain mcssno member;
013800160511
014101191003         setgt (pltrst : plsub# : acc# : mcssno : plplan) covc16;
014102191003         readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
014200191003         dow not %eof;
015500191003          exsr writeMember;
015702191003          readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
015900191003         enddo;
015901191003
016100180523        endif;
016200180523
016300160511       endsr;
016400160511
016500160513      //===================================================================
016600180313      // Write Member
016700160513      //===================================================================
016800160513
016900180313       begsr writeMember;
017000160513
017301191003        exsr determineType;
017302191003        exsr benefitCode;
017303191003
017304191003        if catType = intype;
017400191003         chain
017500191003         ((%trim('0') + %editc(mbssno:'X')):
017501191003         (%trim('0') + %editc(mbssno:'X')):mlname:mfname:mmi:%char(birth):bcode)
017600191003         metFile;
017700191003         if not %found;
017701191003
017702191003          ctype = catType;
017703191003          termdt = candt;
017704191003          seq# = 0;
017705191003          ssn = mbssno;
017706191003          exsr checkTerm;
017707191003          if alreadySent = 'N';
017708191003           clear metFile;
019300180312
019400191003           chain (pltrst : plsub# : acc#) actFile;
019500191003           if %found;
019700191003           endif;
019800180427
019900191003           chain (pltrst : plsub# : acc#) act2File;
020000191003           if %found;
020100191003            //grouptid = %editc(a2tax_id#:'X');
020200191003           endif;
020300180427
020301191003           dclntcode = ' ';
020302191003
020303191007           exsr getgrp;
020400191007           dpol# = group#;
020801191003
020802191003           dcert# = ' ';
020804191003           dtype = 'M';
020805191003           dlast = mlname;
020806191003           dfirst = mfname;
020807191003           dmid = mmi;
020808191003
020809191003           ddepncode = ' ';
020810191003           ddob = %char(birth);
020811191003           dsex = sex;
020812191003           dmstatus = ' ';
020813191003           dreqid = ' ';
020814191003
021200191003           dmemssn = %trim('0') + %editc(mbssno:'X');
021201191003           dsubssn = %trim('0') + %editc(mbssno:'X');
021800180424
021802191003           if empdt > 0;
021803191003            dempdate = %char(empdt);
021804191003           endif;
021805191003
021806191003           dsubcode = ' ';
021807191003           ddeptcode = ' ';
021808191003           doccup = ' ';
021809191003
021810191003           dsaleffdt = ' ';
021811191003           if salary > 0;
021812191003            dsalary = %char(salary);
021813191003            dsalmode = 'A';
021814191003           endif;
021815191003
023100191003           dadd1 = addr1;
023200191003           dadd2 = addr2;
023201191003           dadd3 = ' ';
023300191003           dcityd = city;
023400191003           dstated = state;
023500191003           dzipcode = %editc(zip:'X');
023501191003           dphoned = %editc(area:'X') + %editc(phone:'X');
024100180312
024101191003           dmemdeps = 'A';
024102191003           dreqtype = 'New Enrollment';
024103191003           if candt > 0;
024104191003            dmemdeps = 'T';
024105191003             dreqtype = 'Terminate Enrollment';
024106191003             cancelh = candt;
024107191003             exsr sub1_fromDate;
024108191003            deffdate = %char(cancelh);
024109191003           endif;
024110191003
025700191003           dmaxagee = ' ';
026500191003           demail = fill66;
026501191003           dmcountry = ' ';
026502191003           dhcountry = ' ';
026503191003           dhomest = ' ';
026504191003           dacountry = ' ';
026505191003           dacity = ' ';
026506191003           dpcode = bcode;
026507191003
026508191003           exsr benefitNumber;
026509191003           exsr coverageType;
026510191003
026511191003           dpsumas = ' ';
031106190715
031900191003           deffdate = %char(enrldt);
032402190725
032403191003           if candt = enrldt;
032404191003            deffdate = %char(candt);
032405191003           endif;
032406191003
032407191003           djurstate = ' ';
032800180313
033400191003           exsr getValues;
033500180411
034105191003           write metFile;
034106191003          endif;
034107191003
034108191003         endif;
034109191003
034110191003        endif;
034200180312
041400180313        if mcovtp <> 'TIN';
041500180313         exsr dependent;
041600180313        endif;
041700160518
041800160516       endsr;
041900060817
042000180913      //===================================================================
042100180913      // sub 1 from cancel date
042200180913      //===================================================================
042300180913
042400180913       begsr sub1_fromDate;
042501190725
042600180913        cancelDate = %date(cancelh) - %days(1);
042700180913        cancelh = %dec(cancelDate);
042800180913
042900180913       endsr;
043000180913
043100180523      //===================================================================
043200180523      // check termed records;
043300180523      //===================================================================
043400180523
043500180523       begsr checkTerm;
043600180523
043701191003        alreadySent = 'N';
043800180523
043900191003        if termdt > 0;
044000180523
044100191003         chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
044200191003         if %found;
044201191003          alreadySent = 'Y';
044202191003          leavesr;
044401191003         endif;
044600180523
044700191003         if not %found;
044800191003          ttrst = pltrst;
044900191003           tsub# = plsub#;
045000191003            tacct = acc#;
045100191003             tssno = ssn;
045200191003              tseq# = seq#;
045300191003              ttype = ctype;
045400191003             tplan = plplan;
045500191003            ttermdt = termdt;
045600191003           ttrnsdt = %dec(%date);
045700191003          write termFile;
045800191003         endif;
045900180523
046000191003        endif;
046100180523
046200180523       endsr;
046300180523
046400180523      //===================================================================
046500180523      // get values
046600180523      //===================================================================
046700180523
046800180523       begsr getValues;
046900180523
047000191003        //covtp = %subst(mcovtp:2:2);
047100191003        //chain (unique:mbtrst:mbsub#:plplan:mbacct:state:covtp) planFile;
047200191003        //if %found;
047300191003        // exsr get_valuesCategory;
047400191003        // leavesr;
047500191003        //endif;
047600180523
047700191003        //covtp = %subst(mcovtp:2:2);
047800191003        //chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':covtp) planFile;
047900191003        //if %found;
048000191003        // exsr get_valuesCategory;
048100191003        // leavesr;
048200191003        //endif;
048300180523
048400191003        //chain (unique:mbtrst:mbsub#:plplan:mbacct:state:'ALL') planFile;
048500191003        //if %found;
048600191003        // exsr get_valuesCategory;
048700191003        // leavesr;
048800191003        //endif;
048900180525
049000191003        //chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':'ALL') planFile;
049100191003        //if %found;
049200191003        // exsr get_valuesCategory;
049300191003        // leavesr;
049400191003        //endif;
049500190514
049600191003        //exsr errorReport;
049700180525
049800180523       endsr;
049900180523
052600160512      //===================================================================
052700160512      // process
052800160512      //===================================================================
052900160512
053000160512       begsr dependent;
053100160512
053200160512        setll mcssno depenr;
053300160512        reade mcssno depenr;
053400160512
053500160512        dow not %eof;
053600160512
053700180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
053800160512        if %found;
053900180313         exsr dependentCoverage;
054000160512        endif;
054100160512
054200160512        reade mcssno depenr;
054300160512        enddo;
054400160512
054500190715       endsr;
054600160512
054700160516      //===============================================================
054800160512      // Dependent coverage
054900160512      //===============================================================
055000160513
055100180313       begsr dependentCoverage;
055200160512
055300180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
055400180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
055500160512
055600191003        dow not %eof;
056900191003         exsr writeDependent;
057000191003          leavesr;
057300191003         readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
057400160512        enddo;
057500160512
057600160512       endsr;
057700160512
057800160516      //===============================================================
057900160516      // write dependent
058000160516      //===============================================================
058100160516
058200191003       begsr writeDependent;
058300180313
058601191003        exsr determineType;
058602191003        exsr benefitCode;
058603191003
058700180313        chain
058800191002        ((%trim('0') + %editc(mbssno:'X')):
058802191003        (%trim('0') + %editc(depss#:'X')):mlname:mfname:mmi:%char(birth):bcode)
058900191002        metFile;
059000191003        if not %found;
059500180313
059502191003         if ccandt <> 0;
059503191003          ssn = mcssno;
059504191003          seq# = dpseq#;
059505191003          ctype = catType;
059506191003          termdt = ccandt;
059507191003          exsr checkTerm;
059508191003          if alreadySent = 'N';
059509191003
059510191003          clear metFile;
060600180313
060700191003          chain (pltrst : plsub# : acc#) actFile;
060800191003          if %found;
061000191003          endif;
061100191003
061200191003          chain (pltrst : plsub# : acc#) act2File;
061300191003          if %found;
061400191003           //grouptid = %editc(a2tax_id#:'X');
061500191003          endif;
061600180427
061601191003          dclntcode = ' ';
061602191003
061603191007          exsr getgrp;
061604191007          dpol# = group#;
062200180605
062201191003          dcert# = ' ';
062203191003
062204191003          exsr relCodes;
062205191003
062206191003          dlast = dlname;
062207191003          dfirst = dfname;
062208191003          dmid = dmi;
062209191003
062210191003          ddepncode = ' ';
062211191003          ddob = %char(dbirth);
062212191003          dsex = dsex;
062213191003          dmstatus = ' ';
062214191003          dreqid = ' ';
062215191003
062500191003          dmemssn = %trim('0') + %editc(mbssno:'X');
062501191003          dsubssn = %trim('0') +  %editc(depss#:'X');
062502191003
062503191003          dempdate = ' ';
062504191003
062505191003          dsubcode = ' ';
062506191003          ddeptcode = ' ';
062507191003          doccup = ' ';
062508191003
062509191003          dsaleffdt = ' ';
062510191003          dsalary = ' ';
062512191003          dsalmode = ' ';
062513191003
063101191003          dadd1 = daddr1;
063102191003          dadd2 = daddr2;
063103191003          dadd3 = ' ';
063104191003          dcityd = dcity;
063105191003          dstated = dstate;
063106191003          dzipcode = %editc(dzip:'X');
064100191003          dphoned = %editc(area:'X') + %editc(phone:'X');
066900180313
066901191003          dmemdeps = 'A';
066902191003          dreqtype = 'New Enrollment';
066903191003          if ccandt > 0;
066904191003           dmemdeps = 'T';
066905191003            dreqtype = 'Terminate Enrollment';
066906191003            cancelh = ccandt;
066907191003            exsr sub1_fromDate;
066908191003           deffdate = %char(cancelh);
066909191003
066910191003           if ccandt = denrdt;
066911191003            deffdate = %char(candt);
066912191003           endif;
066913191003          endif;
066914191003
066915191003          dmaxagee = ' ';
067300191003          demail = ' ';
067800191003          dmcountry = ' ';
067801191003          dhcountry = ' ';
067802191003          dhomest = ' ';
067803191003          dacountry = ' ';
067804191003          dacity = ' ';
067805191003          dpcode = bcode;
067806191003
067807191003          exsr benefitNumber;
067808191003          exsr coverageType;
067809191003
067810191003          dpsumas = ' ';
067811191003
072300191003          if denrdt < enrldt;
072400191003           deffdate = %char(enrldt);
072500191003          endif;
072600180607
072700191003          if dbirth > denrdt;
072800191003           deffdate = %char(dbirth);
072900191003          endif;
073000180607
075100180423
075200191003          if qedt > 0 and empst = 'C';
075300191003           //mcbovedate = %char(qedt);
075400191003           //mcbpddate = %char(cexpdt);
075500191003          endif;
075600180313
075601191003          djurstate = ' ';
075602191003
075700191003          exsr getValues;
075800180411
076400191003          endif;
076401191002
076402191003         endif;
084500180523
084700191003         write metFile;
084800191003        endif;
084801191003
085500191003       endsr;
085600160511
085700160519      //===================================================================
085800160519      // Get group number
085900160519      //===================================================================
086000160519
086100160519       begsr getgrp;
086200160519
086300160519        setll (pltrst : plsub# : plplan) grater;
086400160519        reade (pltrst : plsub# : plplan) grater;
086500160519
086600160519        dow not %eof;
086700160519
086800160519         if today >= frmdat;
086900160519          if today <= todat;
087000160519           leavesr;
087100160519          else;
087200160519           group# = ' ';
087300160519          endif;
087400160519         endif;
087500160519
087600160519        reade (pltrst : plsub# : plplan) grater;
087700160519        enddo;
087800160519
087900191002       endsr;
088000160519
088100180312      //===================================================================
088200180312      // Coverage Type
088300180312      //===================================================================
088400180312
088500180312       begsr coverageType;
088600180312
089300191003        select;
089400191003         when mcovtp = 'TIN';
089401191003          dcovcode = 'AME';
089600180313
089700191003         when mcovtp = 'THW';
089701191003          dcovcode = 'AMS';
090000180313
090100191003         when mcovtp = 'TPC';
090101191003          dcovcode = 'AMC';
090400180313
090401191003         when mcovtp = 'TP2';
090402191003          dcovcode = 'ACH';
090403191003
090500191003         when mcovtp = 'TFA';
090501191003          dcovcode = 'AFM';
090900191003        endsl;
093600180313
096200180312       endsr;
096300180312
096301191003      //===================================================================
096302191003      // Determine Type
096303191003      //===================================================================
096304191003
096305191003       begsr benefitCode;
096306191003
096307191003        select;
096308191003         when intype = 'MED';
096309191003          bcode = 'CMM';
096310191003
096311191003         when intype = 'DEN';
096312191003          bcode = 'DEN';
096313191003        endsl;
096314191003
096315191003       endsr;
096316191003
096317191003      //===================================================================
096318191003      // Determine Type
096319191003      //===================================================================
096320191003
096321191003       begsr benefitNumber;
096322191003
096323191003        select;
096324191003         when intype = 'MED';
096325191003          dbplancode = '05';
096326191003
096327191003         when intype = 'DEN';
096328191003          dbplancode = 'D01';
096329191003        endsl;
096330191003
096331191003       endsr;
096332191003
096400180313      //===================================================================
096500180313      // Determine Type
096600180313      //===================================================================
096700180313
096800180313       begsr determineType;
096900180313
097000180319        catType = ' ';
097100180313        chain ('P' : %subst(plncat:2:2)) codesFile;
097200180313        if %found;
097300180313
097400180313         select;
097500180313          when action = 'M';
097600180313           catType = 'MED';
097700180313
097800180313          when action = 'D';
097900180313           catType = 'DEN';
098000191002         endsl;
098500180313        endif;
098600180313
098700180313       endsr;
098800180313
098900180313      //===================================================================
099000180313      // Relationship Codes
099100180313      //===================================================================
099200180313
099300180313       begsr relCodes;
099400180313
099500180313        select;
099600180313         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
099700191002          dtype = 'S';
099800180313
099900180313         when drelcd = 'RDA' or drelcd = 'RSO';
100000191003          dtype = 'C';
100400180313        endsl;
100500180313
100600180313       endsr;
100700180313
102800191002      //===================================================================
102900190514      // error report
103000190514      //===================================================================
103100190514
103200190514       begsr errorReport;
103300190514
103400191003        //if macct# > ' ';
103500190514
103600191003         //if mplanid = ' ';
103700191003         // ctext = 'Plan ID/Benefit Opt missing';
103800191003         // exsr writeError;
103900191003         //endif;
104000190514
104100191003        // if mbranchcd = ' ';
104200191003         // ctext = 'Class ID/Branch Code missing';
104300191003         // exsr writeError;
104400191003        // endif;
104500190514
104600191003        //if mboptcode = ' ';
104700191003         //ctext = 'Subgroup/Parent Branch Code missing';
104800191003          //exsr writeError;
104900191003         //endif;
105000190514
105100191003        //endif;
105200190514
109100190514       endsr;
109200190514
109300190514      //===================================================================
109400190514      // Write Error
109500190514      //===================================================================
109600190514
109700190514       begsr writeError;
109800190514
109900191003        //mbrid = memid;
110000191003        //ctrust = %char(mbtrst);
110100191003        //csub# = %char(mbsub#);
110200191003        //cacct = %char(mbacct);
110300191003        //mbrlast = mlname;
110400191003        //mbrfirst = mfname;
110500191003        //mbrplan = plplan;
110600191003        //mbrst = state;
110700190514
110800191003        //chain (mbtrst : mbsub# : mbacct) actFile;
110900191003        //if %found;
111000190514
111100191003        // chain (aacode) aaFile;
111200191003        // if %found;
111300191003        //  acctaa = %trim(afnam) + ' ' + %trim(alnam);
111400191003        // endif;
111500190514
111600191003         //write errorFile;
111700191003        //endif;
111800190514
111900190514       endsr;
112000180424
112100160511      //===================================================================
112200160511      // exit
112300160511      //===================================================================
112400160511
112500160511       begsr exit;
112600160511
112700160511        *inlr = '1';
112800160511        return;
112900160511
113400160511       endsr;
113500160511
113600160511      //===================================================================
113700160511      // init
113800160511      //===================================================================
113900160520
114000160511       begsr init;
114100160511
114200191002        carrierCode1 = 'ML4';
114300191002        carrierCode2 = 'ML5';
114500180309
114501191002        today = %dec(%date);
114700170710
114800160511       endsr;
114900010412
115000160511       //==============================================================
