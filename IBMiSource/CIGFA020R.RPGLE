000100220729      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400220729      * CIGFA020R - Cigna FI - Facets Generate extract (rewrite)
000500200424      *===========================================================================
000600180313      * Date        Int   Description
000700200424      * ----------  ---   --------------------------------------------------------
000800220729      * 07/29/2022  jt    Original Creation
000801230424      * 04/24/2023  jt    If group rate expired before term of member, grab group #
000802230424      *                   within expiration date.
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200211129     F                                     rename(accmsr:actFile) prefix(M)
001300180427
001400180427     Fac2mstl2  if   e           k disk    rename(accmsr2:act2File)
001500180427
001700160513
001800220729     F*plnmst    if   e           k disk    extfile('F.PLNMST')
001900220729     F*                                     rename(plnmsr:plnr) prefix(P)
002000170619
002100220729     F*plnauxl   if   e           k disk    rename(plnauxr:auxFile)
002200180412
002201220729     F*mcov42    if   e           k disk    extfile('F.MCOV42')
002300200109     F*mcov39    if   e           k disk    extfile('F.MCOV39')
002400170619
002500190611     F*mcovc17   if   e           k disk    rename(mcovr:covc17)
002501200109     F*mcovc16   if   e           k disk    extfile('F.MCOVC16')
002503220729     F*mcov44    if   e           k disk
002504220729     F*                                     rename(mcovr:covc44)
002505200115
002800220729     F*mcov      if   e           k disk    extfile('F.MCOV')
002900220729     F*                                     rename(mcovr:covr) prefix(M)
002901220729
002902220729     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
002903220729
002904220729     Fplnmst    if   e           k disk    extfile('F.PLNMST')
002905220729     f                                     rename(plnmsr:plnmstFile)
002906220729
002907220729     Fmcov40    if   e           k disk    extfile('F.MCOV40')
002908220729     F                                     rename(mcovr:covc40)
002909220729
002910220729     Fmcov41    if   e           k disk    extfile('F.MCOV41')
002911220729     f                                     rename(mcovr:covc41)
002912220729
003000220729     fmemac#1   if   e           k disk    extfile('F.MEMAC#1')
003001220729     f                                     rename(membr:member)
003002220729
003200160513
003300160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003400160513
003500160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003600160518
003700160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003800160518
003900180313     fcodes     if   e           k disk    extfile('F.CODES')
004000180313     f                                     rename(codesr:codesFile)
004001190509
004002211129     faacode    if   e           k disk    rename(aacodr:aaFile)
004003190509
004100180313
004200180508     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
004300180508
004400180518     fcarplnm   if   e           k disk    rename(carplnr:planFile)
004401220729
004600180314     fcignafa   uf a e           k disk    rename(cignar:cignaFile)
004700160513
004800180523     fcignatrm  uf a e           k disk    rename(cignatr:termFile)
004900180523
004901190509     fcignafaer o    e             disk    rename(cignaer:errorFile)
004902220413
004903220413     freinstate if   e           k disk    rename(reinsr:reinstFile)
004904190509
005000160512      *=================================================================
005100061017
005200180309     d carrierCode     s              3
005300180309     d carrierCode1    s              3
005400180309     d carrierCode2    s              3
005500180314     d carrierCode3    s              3
005600160519     d term_dt_limit   s               d
005700180913     d cancelDate      s               d
005701220728     d cancelh         s              8  0
005702220728     d enrollDate      s               d
005800220728     d enrollh         s              8  0
005900160519     d today           s              8  0
006000180313     d hiredatet       s               d
006100180313     d yrsService      s              8  0
006200180313     d catType         s              3
006300180313     d updateRecord    s              1
006400180313     d writeRecord     s              1
006500180411     d hgroup#         s              6
006501200728     d hgroup#2        s              8
006600180503     d pos             s              2  0
006700180508     d unique          s             10
006800180523     d alreadySent     s              1
006801190715     d alreadySentM    s              1
006802190715     d alreadySentV    s              1
006803190715     d alreadySentD    s              1
006804210715     d alreadySentF    s              1
006900180523     d ssn             s              9  0
007000180523     d seq#            s              2  0
007100180523     d ctype           s              3
007200180523     d termdt          s              8  0
007300180523     d covtp           s              2
007301201202     d planFound       s              1
007302220729     d ok_toContinue   s              1
007303220729
007304220729     d enrollDateM     s               d
007305220729     d enrollDateD     s               d
007306220729     d enrollDateV     s               d
007400150820
007401220729     d cancelDateM     s               d
007402220729     d cancelDateD     s               d
007403220729     d cancelDateV     s               d
007404220729
007500160511      //==================================================================
007600160511      // mainline
007700160511      //===================================================================
007800150820
007900160511       exsr init;
008000160511       exsr main;
008100160511       exsr exit;
008101220729
008200220729      //===================================================================
008201220729      // main
008202220729      //===================================================================
008203220729
008204220729       begsr main;
008205220729
008206220729        setll (unique) setupFile;
008207220729        reade (unique) setupFile;
008208220729        dow not %eof;
008209220729
008210220729        if castatus = 'Y' or castatus = 'F';
008212220729          exsr main2;
008213220729         endif;
008214220729
008215220729        reade (unique) setupFile;
008216220729        enddo;
008217220729
008218220729        exsr clearSSN;
008219220729        exsr checkFile;
008220220729        exsr doHardcodes;
008221220729        exsr fixDates;
008222220729
008223220729       endsr;
008224220729
008225220729      //===================================================================
008226220729      // main
008227220729      //===================================================================
008228220729
008229220729       begsr main2;
008230220729
008231220729        setll (catrst : casub# : caacct) member;
008232220729        reade (catrst : casub# : caacct) member;
008233220729        dow not %eof;
008234220729
008235220729         exsr process;
008236220729
008237220729        reade (catrst : casub# : caacct) member;
008238220729        enddo;
008239220729
008240220729       endsr;
008241220729
012800160511      //===================================================================
012900160511      // process
013000160511      //===================================================================
013100160511
013200160511       begsr process;
013300160511
013800220729
013900220729        setll (mbssno : 00 : catrst : casub#) covc40;
013901220729        reade (mbssno : 00 : catrst : casub#) covc40;
013902220729
014005190611        dow not %eof;
014006220729        exsr checkPlan;
014008220729        if ok_toContinue = 'Y';
014900220729         exsr writeMember;
015000220729        endif;
015001220729
015502220729        reade (mbssno : 00 : catrst : casub#) covc40;
015503220729        enddo;
015504220729
015505220729        setll (mbssno : 00 : catrst : casub#) covc41;
015506220729        reade (mbssno : 00 : catrst : casub#) covc41;
015507220729
015508220729        dow not %eof;
015509220729        exsr checkPlan;
015510220729        if ok_toContinue = 'Y';
015511220729          exsr writeMember;
015512220729         endif;
015513220729        reade (mbssno : 00 : catrst : casub#) covc41;
015514220729        enddo;
015800180508
015900160511       endsr;
016000160511
016100160513      //===================================================================
016200180313      // Write Member
016300160513      //===================================================================
016400160513
016500180313       begsr writeMember;
016600160513
016700180313        updateRecord = 'N';
016800180313        writeRecord = 'N';
016900180313
017000180313        chain
017100180313        (%editc(mbssno:'X'):%editc(mbssno:'X'):%char(birth):mlname:mfname:mmi)
017200180313        cignaFile;
017300180313        if %found;
017400180313         updateRecord = 'Y';
017500180313        else;
017600180313         writeRecord = 'Y';
017601190828         alreadySentM = 'N';
017602190828         alreadySentD = 'N';
017603190828         alreadySentV = 'N';
017604210715         alreadySentF = 'N';
017700180313        endif;
017800180313
017900180313        exsr determineType;
018000180313        if catType = ' ';
018100180313         leavesr;
018200180313        endif;
018300180313
018600180313        if writeRecord = 'Y';
018700180313         clear cignaFile;
018800180313        endif;
018900180312
019000180427        chain (pltrst : plsub# : acc#) actFile;
019100180427        if %found;
019200211129         groupnam = macnam1;
019300180427        endif;
019400180427
019500180427        chain (pltrst : plsub# : acc#) act2File;
019600180427        if %found;
019700180427         grouptid = %editc(a2tax_id#:'X');
019800180427        endif;
019900180427
020000180312        recid = '01';
020100180312        prkeyty = 'S';
020200180312        memid = %editc(mbssno:'X');
020300180312        lastname = mlname;
020400180313        firstname = mfname;
020500180312        mi = mmi;
020600180312        dateofbth = %char(birth);
020700180312        gender = sex;
020800180417
020900180312        mbrssn = %editc(mbssno:'X');
021000180417        if mbrssn = '000000000';
021100180417         mbrssn = ' ';
021200180417         tssn = ' ';
021300180417        endif;
021400180312
021500180312        oritype = ' ';
021600180312        orikey = ' ';
021700180312
021800180313        cphone = %editc(area:'X') + %editc(phone:'X');
021900180312        bphone = ' ';
022000180312
022100180312        address1 = addr1;
022200180312        address2 = addr2;
022300180312        ccity = city;
022400180405        cstate = state;
022500180313        czip = %editc(zip:'X');
022600180312        wzip = ' ';
022700180312        ftstdnt = ' ';
022800180312        relcd = 'EE';
022900180312        deceased = ' ';
023000180312        decdate = ' ';
023100180312
023200180313        if hndicp > ' ';
023300180312         disabled = 'H';
023400180312        endif;
023500180312
023600180312        retired = ' ';
023700180312        retdate = ' ';
023800180312        oritype2 = ' ';
023900180312        orikey2 = ' ';
024000180312
024100180312        if salary > 0;
024200180313         cursalary = %char(salary);
024300180312         salfreq = 'A';
024400180312        endif;
024500180312
024600180312        saldate = ' ';
024700180312
024800180312        if empdt > 0;
024900180312         hiredate = %char(empdt);
025000180312          hiredateT = %date(empdt);
025100180312          yrsService = %diff(%date():hiredateT:*years);
025200180312         yrofserv = %char(yrsService);
025300180312        endif;
025400180312
025500180312        email = ' ';
025600180312        eid = ' ';
025700180312
025800180312        oins = ' ';
025900180312        mhicid = ' ';
026000180312
026100180312        covtype = ' ';
026200180312        carrier = ' ';
026300180312        medtype = ' ';
026400180417        oeffdate = %char(frmdat);
026600180312        ocandate = ' ';
026700180312        pcode = ' ';
026800180312        fresp = ' ';
026900180312        covtype2 = ' ';
027000180312        carrier2 = ' ';
027100180312        medtype2 = ' ';
027200180312        oeffdate2 = ' ';
027300180312        ocandate2 = ' ';
027400180312        pcode2 = ' ';
027500180312        fresp2 = ' ';
027600180312        policy#2 = ' ';
027700180312        covtype3 = ' ';
027800180312        carrier3 = ' ';
027900180312        medtype3 = ' ';
028000180312        oeffdate3 = ' ';
028100180312        ocandate3 = ' ';
028200180312        pcode3 = ' ';
028300180312        fresp3 = ' ';
028400180312        policy#3 = ' ';
028500180312
028600180313        estatus = ' ';
028700180313        select;
028800180313         when empst = 'A';
028900180313          estatus = 'A';
029000180313         when empst <> 'A';
029100180313          estatus = 'I';
029200180313        endsl;
029300180312
029400180312        estatusdt = ' ';
029500180312
029800180312        eloc = ' ';
029900180313        feditin = %editc(mbssno:'X');
030000180411
030100180411        hgroup# = group#;
030101200728        hgroup#2 = group#;
030102200109        if hgroup# = ' ';
030103200109         hgroup# = cacid3;
030104200728         hgroup#2 = cacid3;
030105200109        endif;
030106200728
030202210401        policy# = cacid6 + %trim('-F');
030400180313        if catType = 'MED';
030401220729        if mcovedate = ' ';
030402191101         ssn = mcssno;
030403190903         ctype = catType;
030404190715         termdt = candt;
030414190715         seq# = 0;
030415190715         exsr checkTerm;
030417190715         if alreadySentM = 'N';
030418200109
030421200109          macct# = cacid3;
030423200109
030600180410         mtype = 'HLT';
030700180313
030800180524         exsr getValues;
030900180503
031000180524         mcovedate = %char(enrldt);
031001220413         chain (pltrst : plsub# : acc# : mcssno : plplan) reinstFile;
031002220413         if %found;
031003220413          if enrldt < rdate;
031004220413           mcovedate = %char(rdate);
031005220413          endif;
031006220413         endif;
031100180313
031200180313         if candt > 0;
031300180913          cancelh = candt;
031400180913           exsr sub1_fromDate;
031401220728            enrollh = enrldt;
031402220728           exsr checkSameday;
031500220728          mcovcdate = %char(cancelh);
031600180313         endif;
031700180312
031701230424         exsr getgrp;
031702230424
031800180313         exsr coverageType;
031900180313
032000180313         if qedt > 0 and empst = 'C';
032100180313          mcbovedate = %char(qedt);
032200180313          mcbpddate = %char(cexpdt);
032300180313         endif;
032400180313
032500180313         mnetid = ' ';
032600180313         medpcpid = ' ';
032700180313         medestpid = ' ';
032800180313         mpnetefdt = ' ';
032900180313         mpeclmedt = ' ';
033000190715         endif;
033001190715        endif;
033100220729        endif;
033101220729
033200180313        if catType = 'DEN';
033201220729        if dcovedate = ' ';
033202190903         ctype = catType;
033203191101         ssn = mcssno;
033204190715         termdt = candt;
033205190715         seq# = 0;
033206190715         exsr checkTerm;
033207190715         if alreadySentD = 'N';
033208200109
033302200109          dacct# = cacid4;
033304200109
033400180410         dtype = 'DEN';
033500180313
033600180510          exsr getValues;
033700180503
033800180524          dcovedate = %char(enrldt);
033801220413          chain (pltrst : plsub# : acc# : mcssno : plplan) reinstFile;
033802220413          if %found;
033803220413           if enrldt < rdate;
033804220413            dcovedate = %char(rdate);
033805220413           endif;
033806220413          endif;
033900180313
034000180524          if candt > 0;
034100180913           cancelh = candt;
034200180913            exsr sub1_fromDate;
034201220728             enrollh = enrldt;
034202220728            exsr checkSameday;
034300180913           dcovcdate = %char(cancelh);
034400180524          endif;
034500180313
034501230424         exsr getgrp;
034502230424
034600180313         exsr coverageType;
034700180313
034800180313         if qedt > 0 and empst = 'C';
034900180313          dcbovedate = %char(qedt);
035000180313          dcbpddate = %char(cexpdt);
035100180313         endif;
035200180313
035300190715         endif;
035301190715        endif;
035302220729        endif;
035400180313
035500180313        if catType = 'VIS';
035501220729        if vcovedate = ' ';
035502191101         ssn = mcssno;
035503190903         ctype = catType;
035504190715         termdt = candt;
035505190715         seq# = 0;
035506190715         exsr checkTerm;
035507190715         if alreadySentV = 'N';
035508200109
035602220729         vacct# = cacid5;
035604200109
035700180410         vtype = 'VIS';
035800180405
035900180524         exsr getValues;
036000180502
036100220413         vcovedate = %char(enrldt);
036101220413         chain (pltrst : plsub# : acc# : mcssno : plplan) reinstFile;
036102220413         if %found;
036103220413          if enrldt < rdate;
036104220413           vcovedate = %char(rdate);
036105220413          endif;
036106220413         endif;
036200180313
036300180313         if candt > 0;
036400180913          cancelh = candt;
036500180913           exsr sub1_fromDate;
036501220728            enrollh = enrldt;
036502220728           exsr checkSameday;
036600180913          vcovcdate = %char(cancelh);
036700180313         endif;
036800180313
036801230424         exsr getgrp;
036802230424
036900180313         exsr coverageType;
037000180313
037100180313         if qedt > 0 and empst = 'C';
037200180313          vcbovedate = %char(qedt);
037300180313          vcbpddate = %char(cexpdt);
037400180313         endif;
037401190715        endif;
037500180313
037600180313        endif;
037601220729        endif;
037700180313
037701210715        if catType = 'FSA';
037702210715         ssn = mcssno;
037703210715         ctype = catType;
037704210715         termdt = candt;
037705210715         seq# = 0;
037706210715         exsr checkTerm;
037708210715         if alreadySentF = 'N';
037709210715
037712210715          facct# = cacid3;
037714210715
037715210715         ftype = 'AH ';
037716210715
037717210715         exsr getValues;
037718210715
037719210715         fcovedate = %char(enrldt);
037720210715
037721210715         if candt > 0;
037722210715          cancelh = candt;
037723210715           exsr sub1_fromDate;
037724220728            enrollh = enrldt;
037725220728           exsr checkSameday;
037726210715          fcovcdate = %char(cancelh);
037727210715         endif;
037728210715
037729230424         exsr getgrp;
037730230424
037731210715         exsr coverageType;
037732210715
037739210715         endif;
037740210715        endif;
037741210715
037800180523        ssn = mcssno;
037900180523        seq# = 0;
038000180523        ctype = catType;
038100180523        termdt = candt;
038200180523
038501220729         select;
038502220729          when catType = 'MED';
038503220729           if alreadySentM = 'N';
038504220729            if planFound = 'Y';
038505220729             if writeRecord = 'Y';
038506220729              write cignaFile;
038507220729             endif;
038508220729
038509220729             if updateRecord = 'Y';
038510220729              update cignaFile;
038511220729             endif;
038512220729            endif;
038513220729
038514220729           exsr setFlags;
038515220729          endif;
038516220729
038517220729          when catType = 'DEN';
038518220729           if alreadySentD = 'N';
038519220729            if planFound = 'Y';
038520220729             if writeRecord = 'Y';
038521220729              write cignaFile;
038522220729             endif;
038523220729
038524220729             if updateRecord = 'Y';
038525220729              update cignaFile;
038526220729             endif;
038527220729            endif;
038528220729
038529220729           exsr setFlags;
038530220729          endif;
038531220729
038532220729          when catType = 'VIS';
038533220729           if alreadySentV = 'N';
038534220729            if planFound = 'Y';
038535220729             if writeRecord = 'Y';
038536220729              write cignaFile;
038537220729             endif;
038538220729
038539220729             if updateRecord = 'Y';
038540220729              update cignaFile;
038541220729             endif;
038542220729            endif;
038543220729
038544220729           exsr setFlags;
038545220729          endif;
038546220729
038547220729          when catType = 'FSA';
038548220729           if alreadySentF = 'N';
038549220729            if planFound = 'Y';
038550220729             if writeRecord = 'Y';
038551220729              write cignaFile;
038552220729             endif;
038553220729
038554220729             if updateRecord = 'Y';
038555220729              update cignaFile;
038556220729             endif;
038557220729            endif;
038558220729
038559220729           exsr setFlags;
038560220729          endif;
038561220729
038562220729         endsl;
038563220729
038564220729        // if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N'
038565220729        //  or alreadySentF = 'N';
038566220729        //  if planFound = 'Y';
038600220729        //   if writeRecord = 'Y';
038700220729        //    write cignaFile;
038800220729        //   endif;
038801190715
038900220729        //   if updateRecord = 'Y';
039000220729        //    update cignaFile;
039100220729        //   endif;
039101220729        //  endif;
039102201202
039103220729        // exsr setFlags;
039105220729        // endif;
039200180523
039500180523        if mcovtp <> 'TIN';
039600180523         exsr dependent;
039700180523        endif;
039800180523
039900160516       endsr;
040000060817
040100180913      //===================================================================
040200180913      // sub 1 from cancel date
040300180913      //===================================================================
040400180913
040500180913       begsr sub1_fromDate;
040600180913
040606220728        cancelDate = %date(cancelh) - %days(1);
040800180913        cancelh = %dec(cancelDate);
040900180913
041000180913       endsr;
041100180913
041101220728      //===================================================================
041102220728      // check same day terms
041103220728      //===================================================================
041104220728
041105220728       begsr checkSameday;
041106220728
041107220728        cancelDate = %date(cancelh);
041108220728        enrollDate = %date(enrollh);
041109220728
041110220728        if cancelDate = enrollDate;
041111220728         cancelDate = %date(cancelh) + %days(1);
041112220728         cancelh = %dec(cancelDate);
041113220728        endif;
041114220728
041115220728        cancelh = %dec(cancelDate);
041116220728
041117220728       endsr;
041118220728
041200180523      //===================================================================
041300180523      // check termed records;
041400180523      //===================================================================
041500180523
041600180523       begsr checkTerm;
041700180523
041800190903       //alreadySent = 'N';
041801190903       alreadySentM = 'N';
041802190903       alreadySentD = 'N';
041803190903       alreadySentV = 'N';
041804210715       alreadySentF = 'N';
041900180523
042000180523       if termdt > 0;
042100180523
042200180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
042300180523        if %found;
042301190903
042302190903         if ctype = 'MED';
042303190903          alreadySentM = 'Y';
042304190903         endif;
042305190903
042306190903         if ctype = 'DEN';
042307190903          alreadySentD = 'Y';
042308190903         endif;
042309190903
042310190903         if ctype = 'VIS';
042311190903          alreadySentV = 'Y';
042312190903         endif;
042313190903
042314210715         if ctype = 'FSA';
042315210715          alreadySentF = 'Y';
042316210715         endif;
042317210715
042400190903         //alreadySent = 'Y';
042500190903         //leavesr;
042600180523        endif;
042700180523
042800180523        if not %found;
042900180523         ttrst = pltrst;
043000180523          tsub# = plsub#;
043100180523           tacct = acc#;
043200180524            tssno = ssn;
043300180523             tseq# = seq#;
043400180523             ttype = ctype;
043500180523            tplan = plplan;
043600180523           ttermdt = termdt;
043700180523          ttrnsdt = %dec(%date);
043800220729         write termFile;
043900180523        endif;
044000180523
044001220729        if termdt < %dec(term_dt_limit);
044002220729         select;
044003220729         when ctype = 'MED';
044004220729          alreadySentM = 'Y';
044006220729
044007220729         when ctype = 'DEN';
044008220729          alreadySentD = 'Y';
044010220729
044011220729         when ctype = 'VIS';
044012220729          alreadySentV = 'Y';
044014220729
044015220729         when ctype = 'FSA';
044016220729          alreadySentF = 'Y';
044018220729         endsl;
044019220729        endif;
044020220729
044100180523       endif;
044200180523
044300180523       endsr;
044400180508
044500180518      //===================================================================
044600180518      // get values
044700180518      //===================================================================
044800180518
044900180518       begsr getValues;
045000180518
045001201202        planFound = 'N';
045002201202
045100180523        covtp = %subst(mcovtp:2:2);
045200180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:covtp) planFile;
045300180518        if %found;
045301201202         planFound = 'Y';
045400201202          exsr get_valuesCategory;
045500180524         leavesr;
045600180524        endif;
045700180518
045800180523        covtp = %subst(mcovtp:2:2);
045900180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':covtp) planFile;
046000180523        if %found;
046001201202         planFound = 'Y';
046100201202          exsr get_valuesCategory;
046200180524         leavesr;
046300180524        endif;
046400180523
046500180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:'ALL') planFile;
046600180525        if %found;
046601201202         planFound = 'Y';
046700201202          exsr get_valuesCategory;
046800180525         leavesr;
046900180525        endif;
047000180525
047100180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':'ALL') planFile;
047200180525        if %found;
047201201202         planFound = 'Y';
047300201202          exsr get_valuesCategory;
047400180525         leavesr;
047500180525        endif;
047600180525
047601190509        exsr errorReport;
047602190509
047700180518       endsr;
047800190828      //===================================================================
047801190828      // setflags
047802190828      //===================================================================
047803190828
047804190828       begsr setFlags;
047805190828
047806190828        if catType = 'MED';
047807190828         alreadySentM = 'Y';
047808190828        endif;
047809190828
047810190828        if catType = 'DEN';
047811190828         alreadySentD = 'Y';
047812190828        endif;
047813190828
047814190828        if catType = 'VIS';
047815190828         alreadySentV = 'Y';
047816190828        endif;
047817190828
047818210715        if catType = 'FSA';
047819210715         alreadySentF = 'Y';
047820210715        endif;
047821210715
047822190828       endsr;
047823190828
047900180524      //===================================================================
048000180524      // get values category
048100180524      //===================================================================
048200180524
048300180524       begsr get_valuesCategory;
048400180524
048500180524        if catType = 'MED';
048600180524         mplanid = cpcid4;
048700180524          mbranchcd = cpcid3;
048800190509         mboptcode = cpcid2;
048900180524        endif;
049000180524
049100180524        if catType = 'DEN';
049200180524         dplanid = cpcid4;
049300180524          dbranchcd = cpcid3;
049400190509         dboptcode = cpcid2;
049500180524        endif;
049600180524
049700180524        if catType = 'VIS';
049800180524         vplanid = cpcid4;
049900180524          vbranchcd = cpcid3;
050000190509         vboptcode = cpcid2;
050100180524        endif;
050200180524
050201210715        if catType = 'FSA';
050202210715         fplanid = cpcid4;
050203210715          fbranchcd = cpcid3;
050204210715         fboptcode = cpcid2;
050205210715        endif;
050206210715
050300180524       endsr;
050400180524
050500160512      //===================================================================
050600160512      // process
050700160512      //===================================================================
050800160512
050900160512       begsr dependent;
051000160512
051500220729        setll mcssno depenr;
051501220729        reade mcssno depenr;
051502220729
051503220729        dow not %eof;
051504220729
051505220729        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
051506220729        if %found;
051507220729         exsr dependentCoverage;
051508220729        endif;
051509220729
051510220729        reade mcssno depenr;
051511220729        enddo;
051512220729
051513220729       endsr;
052500160512
052600160516      //===============================================================
052700160512      // Dependent coverage
052800160512      //===============================================================
052900160513
053000180313       begsr dependentCoverage;
053100160512
053200180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
053300180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
053400160512
053500160512        dow not %eof;
053501220729
054400220729         exsr writeDep;
054401220729
055200180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
055300160512        enddo;
055400160512
055500160512       endsr;
055600160512
055700160516      //===============================================================
055800160516      // write dependent
055900160516      //===============================================================
056000160516
056100160516       begsr writeDep;
056200180313
056300180313        updateRecord = 'N';
056400180313        writeRecord = 'N';
056500180313
056600180313        chain
056700180313        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(dbirth):dlname:dfname:dmi)
056800180313        cignaFile;
056900180313        if %found;
057000180313         updateRecord = 'Y';
057100180313        else;
057200180313         writeRecord = 'Y';
057201190828         alreadySentM = 'N';
057202190828         alreadySentD = 'N';
057203190828         alreadySentV = 'N';
057204210715         alreadySentF = 'N';
057300180313        endif;
057400180313
057500180313        exsr determineType;
057600180313        if catType = ' ';
057700180313         leavesr;
057800180313        endif;
057900180313
058100180313
058200180313        if writeRecord = 'Y';
058300180313         clear cignaFile;
058400180313        endif;
058500180313
058600180427        chain (pltrst : plsub# : acc#) actFile;
058700180427        if %found;
058800211129         groupnam = macnam1;
058900180427        endif;
059000180427
059100180427        chain (pltrst : plsub# : acc#) act2File;
059200180427        if %found;
059300180427         grouptid = %editc(a2tax_id#:'X');
059400180427        endif;
059500180427
059600180313        recid = '02';
059700180313        prkeyty = 'S';
059800180313        memid = %editc(mbssno:'X');
059900180313        lastname = dlname;
060000180313        firstname = dfname;
060100180313        mi = dmi;
060200180313        dateofbth = %char(dbirth);
060300180313        gender = dsex;
060400180417
060500180313        mbrssn = %editc(depss#:'X');
060600180417        if mbrssn = '000000000';
060700180502         //mbrssn = ' ';
060800180417         tssn = ' ';
060900180417        endif;
061000180313
061100180313        oritype = ' ';
061200180313        orikey = ' ';
061300180313
061400180313        cphone = %editc(area:'X') + %editc(phone:'X');
061500180313        bphone = ' ';
061600180313
061700180313        address1 = daddr1;
061800180313        address2 = daddr2;
061900180313        ccity = dcity;
062000180405        cstate = dstate;
062100180313        czip = %editc(dzip:'X');
062200180313        wzip = ' ';
062300180313        ftstdnt = ' ';
062400180313
062500180313        exsr relCodes;
062600180313
062700180313        deceased = ' ';
062800180313        decdate = ' ';
062900180313
063000180313        if dhndcp > ' ';
063100180313         disabled = 'H';
063200180313        endif;
063300180313
063400180313        retired = ' ';
063500180313        retdate = ' ';
063600180313        oritype2 = ' ';
063700180313        orikey2 = ' ';
063800180313
063900180313        cursalary = ' ';
064000180313        salfreq = ' ';
064100180313        saldate = ' ';
064200180313
064300180313        hiredate = ' ';
064400180313        yrofserv = ' ';
064500180313
064600180313        email = ' ';
064700180313        eid = ' ';
064800180313
064900180313        oins = ' ';
065000180313        mhicid = ' ';
065100180313
065200180313        covtype = ' ';
065300180313        carrier = ' ';
065400180313        medtype = ' ';
065500180417        oeffdate = %char(frmdat);
065600180417        //oeffdate = ' ';
065700180313        ocandate = ' ';
065800180313        pcode = ' ';
065900180313        fresp = ' ';
066000180313        covtype2 = ' ';
066100180313        carrier2 = ' ';
066200180313        medtype2 = ' ';
066300180313        oeffdate2 = ' ';
066400180313        ocandate2 = ' ';
066500180313        pcode2 = ' ';
066600180313        fresp2 = ' ';
066700180313        policy#2 = ' ';
066800180313        covtype3 = ' ';
066900180313        carrier3 = ' ';
067000180313        medtype3 = ' ';
067100180313        oeffdate3 = ' ';
067200180313        ocandate3 = ' ';
067300180313        pcode3 = ' ';
067400180313        fresp3 = ' ';
067500180313        policy#3 = ' ';
067600180313
067700180313        estatus = ' ';
067800180313
067900180313        estatusdt = ' ';
068000180313
068100180417        //tssn = %editc(depss#:'X');
068200180313
068300180313        eloc = ' ';
068400180313        feditin = %editc(depss#:'X');
068500180411
068600200728        //hgroup# = group#;
068601200728        //if hgroup# = ' ';
068602200728         //hgroup# = cacid3;
068603200728        //endif;
068700200728        //policy# = %trim('00') + %trim(hgroup#) + %trim('-F');
068701200728
068703200728        hgroup# = group#;
068704200728        hgroup#2 = group#;
068705200728        if hgroup# = ' ';
068706200728         hgroup# = cacid3;
068707200728         hgroup#2 = cacid3;
068708200728        endif;
068709200728
068710200728        pos = %scan('00' : group# : 1);
068711200728        if pos = 1;
068712200728         policy# = %trim(hgroup#2) + %trim('-F');
068713200728        else;
068714200728         policy# = %trim('00') + %trim(hgroup#) + %trim('-F');
068715200728        endif;
068716210401
068800210401        policy# = cacid6 + %trim('-F');
068801210401
068900180313        if catType = 'MED';
068901220729        if mcovedate = ' ';
068902190715        ssn = mcssno;
068903190715        seq# = dpseq#;
068904190715        ctype = catType;
068905190715        termdt = ccandt;
068906190715        exsr checkTerm;
068907190828        //alreadySentM = alreadySent;
068908190715
068909190715        if alreadySentM = 'N';
068910190715
069000200728         //macct# = group#;
069001200728         //if macct# = ' ';
069002200728          macct# = cacid3;
069003200728         //endif;
069004200109
069100180410         mtype = 'HLT';
069200180508
069300180524         exsr getValues;
069400180503
069500180524         mcovedate = %char(denrdt);
069600180606
069601220729         if ccandt = 0;
069700180606         if denrdt < enrldt;
069800180606          mcovedate = %char(enrldt);
069900180606         endif;
069901220729         endif;
070000180606
070100180606         if dbirth > denrdt;
070200180606          mcovedate = %char(dbirth);
070300180606         endif;
070301220413
070302220413         chain (pltrst : plsub# : acc# : mcssno : plplan) reinstFile;
070303220413         if %found;
070304220413          if mcovedate < %char(rdate);
070305220413           mcovedate = %char(rdate);
070306220413          endif;
070307220413         endif;
070400180313
070500180523         if ccandt > 0;
070600180913          cancelh = ccandt;
070700180913           exsr sub1_fromDate;
070701220728            enrollh = denrdt;
070702220728           exsr checkSameday;
070800180913          mcovcdate = %char(cancelh);
070900180313         endif;
071000180413
071001230424         exsr getgrp;
071002230424
071100180313         mecovin = ' ';
071200180313         mscovin = ' ';
071300180313         mccovin = ' ';
071400180313         mcocovin = ' ';
071500180313         decovin = ' ';
071600180313         dscovin = ' ';
071700180313         dccovin = ' ';
071800180313         dcocovin = ' ';
071900180313         vecovin = ' ';
072000180313         vscovin = ' ';
072100180313         vccovin = ' ';
072200180313         vcocovin = ' ';
072201210715         fecovin = ' ';
072202210715         fscovin = ' ';
072203210715         fccovin = ' ';
072204210715         fcocovin = ' ';
072300180313
072400180413         exsr coverageType;
072500180413
072600180313         if qedt > 0 and empst = 'C';
072700180313          mcbovedate = %char(qedt);
072800180313          mcbpddate = %char(cexpdt);
072900180313         endif;
073000180313
073100180313         mnetid = ' ';
073200180313         medpcpid = ' ';
073300180313         medestpid = ' ';
073400180313         mpnetefdt = ' ';
073500180313         mpeclmedt = ' ';
073600180313        endif;
073601190715        endif;
073602220729        endif;
073700180313
073800180313        if catType = 'DEN';
073801220729        if dcovedate = ' ';
073802190715        ssn = mcssno;
073803190715        seq# = dpseq#;
073804190715        ctype = catType;
073805190715        termdt = ccandt;
073806190715        exsr checkTerm;
073807190828        //alreadySentD = alreadySent;
073808190715
073809190715        if alreadySentD = 'N';
073810200109
073900200728         //dacct# = group#;
073901200728         //if dacct# = ' ';
073902200109          dacct# = cacid4;
073903200728         //endif;
073904200109
074000180410         dtype = 'DEN';
074100180313
074200180524         exsr getValues;
074300180503
074400180524         dcovedate = %char(denrdt);
074500180606
074501220729         if ccandt = 0;
074600180606         if denrdt < enrldt;
074700180606          dcovedate = %char(enrldt);
074800180606         endif;
074801220729         endif;
074900180606
075000180606         if dbirth > denrdt;
075100180606          dcovedate = %char(dbirth);
075200180606         endif;
075201220413
075202220413         chain (pltrst : plsub# : acc# : mcssno : plplan) reinstFile;
075203220413         if %found;
075204220413          if dcovedate < %char(rdate);
075205220413           dcovedate = %char(rdate);
075206220413          endif;
075207220413         endif;
075300180313
075400180523         if ccandt > 0;
075500180913          cancelh = ccandt;
075600180913           exsr sub1_fromDate;
075601220728            enrollh = denrdt;
075602220728           exsr checkSameday;
075700180913          dcovcdate = %char(cancelh);
075800180313         endif;
075900180313
075901230424         exsr getgrp;
075902230424
076000180313         exsr coverageType;
076100180313
076200180313         if qedt > 0 and empst = 'C';
076300180313          dcbovedate = %char(qedt);
076400180313          dcbpddate = %char(cexpdt);
076500180313         endif;
076501190715         endif;
076600180313
076700180313        endif;
076701220729        endif;
076800180313
076900180313        if catType = 'VIS';
076901220729        if vcovedate = ' ';
076902190715        ssn = mcssno;
076903190715        seq# = dpseq#;
076904190715        ctype = catType;
076905190715        termdt = ccandt;
076906190715        exsr checkTerm;
076907190828        //alreadySentV = alreadySent;
076908190715
076909190715        if alreadySentV = 'N';
076910200109
077000200728         //vacct# = group#;
077001200728         //if vacct# = ' ';
077002200109          vacct# = cacid5;
077003200728         //endif;
077005200109
077006180410         vtype = 'VIS';
077200180313
077300180524         exsr getValues;
077400180503
077500180524         vcovedate = %char(denrdt);
077501220413
077601220729         if ccandt = 0;
077700180606         if denrdt < enrldt;
077800180606          vcovedate = %char(enrldt);
077900180606         endif;
077901220729         endif;
078000180606
078100180606         if dbirth > denrdt;
078200180606          vcovedate = %char(dbirth);
078300180606         endif;
078301220413
078302220413         chain (pltrst : plsub# : acc# : mcssno : plplan) reinstFile;
078303220413         if %found;
078304220413          if vcovedate < %char(rdate);
078305220413           vcovedate = %char(rdate);
078306220413          endif;
078307220413         endif;
078308220413
078500180523         if ccandt > 0;
078600180913          cancelh = ccandt;
078700180913           exsr sub1_fromDate;
078701220728            enrollh = denrdt;
078702220728           exsr checkSameday;
078800180913          vcovcdate = %char(cancelh);
078900180313         endif;
079000180313
079001230424         exsr getgrp;
079002230424
079100180313         exsr coverageType;
079200180313
079300180313         if qedt > 0 and empst = 'C';
079400180313          vcbovedate = %char(qedt);
079500180313          vcbpddate = %char(cexpdt);
079600180313         endif;
079601190715         endif;
079700180313
079800180313        endif;
079801220729        endif;
079900180313
079901210715        if catType = 'FSA';
079902210715        ssn = mcssno;
079903210715        seq# = dpseq#;
079904210715        ctype = catType;
079905210715        termdt = ccandt;
079906210715        exsr checkTerm;
079907210715        //alreadySentM = alreadySent;
079908210715
079909210715        if alreadySentF = 'N';
079910220729
079911210715         //macct# = group#;
079912210715         //if macct# = ' ';
079913210715          facct# = cacid3;
079914210715         //endif;
079915210715
079916210716         ftype = 'AH ';
079917210715
079918210715         exsr getValues;
079919210715
079920210715         fcovedate = %char(denrdt);
079921210715
079922220729         if ccandt = 0;
079923210715         if denrdt < enrldt;
079924210715          fcovedate = %char(enrldt);
079925210715         endif;
079926220729         endif;
079927210715
079928210715         if dbirth > denrdt;
079929210715          fcovedate = %char(dbirth);
079930210715         endif;
079931210715
079932210715         if ccandt > 0;
079933210715          cancelh = ccandt;
079934210715           exsr sub1_fromDate;
079935220728            enrollh = denrdt;
079936220728           exsr checkSameday;
079937210715          fcovcdate = %char(cancelh);
079938210715         endif;
079939210715
079940230424         exsr getgrp;
079941230424
079942210715         fecovin = ' ';
079943210715         fscovin = ' ';
079944210715         fccovin = ' ';
079947210715         fcocovin = ' ';
079948210715
079949210715         exsr coverageType;
079950210715
079961210715        endif;
079962210715        endif;
079963210715
080000190715        //ssn = mcssno;
080100190715        //seq# = dpseq#;
080200190715        //ctype = catType;
080300190715        //termdt = ccandt;
080400180523
080500190715        //exsr checkTerm;
080600190715        //if alreadySent = 'N';
080700180523
080701220729         select;
080702220729          when catType = 'MED';
080703220729           if alreadySentM = 'N';
080704220729            if planFound = 'Y';
080705220729             if writeRecord = 'Y';
080706220729              write cignaFile;
080707220729             endif;
080708220729
080709220729             if updateRecord = 'Y';
080710220729              update cignaFile;
080711220729             endif;
080712220729            endif;
080713220729
080714220729           exsr setFlags;
080715220729          endif;
080716220729
080717220729          when catType = 'DEN';
080718220729           if alreadySentD = 'N';
080719220729            if planFound = 'Y';
080720220729             if writeRecord = 'Y';
080721220729              write cignaFile;
080722220729             endif;
080723220729
080724220729             if updateRecord = 'Y';
080725220729              update cignaFile;
080726220729             endif;
080727220729            endif;
080728220729
080729220729           exsr setFlags;
080730220729          endif;
080731220729
080732220729          when catType = 'VIS';
080733220729           if alreadySentV = 'N';
080734220729            if planFound = 'Y';
080735220729             if writeRecord = 'Y';
080736220729              write cignaFile;
080737220729             endif;
080738220729
080739220729             if updateRecord = 'Y';
080740220729              update cignaFile;
080741220729             endif;
080742220729            endif;
080743220729
080744220729           exsr setFlags;
080745220729          endif;
080746220729
080747220729          when catType = 'FSA';
080748220729           if alreadySentF = 'N';
080749220729            if planFound = 'Y';
080750220729             if writeRecord = 'Y';
080751220729              write cignaFile;
080752220729             endif;
080753220729
080754220729             if updateRecord = 'Y';
080755220729              update cignaFile;
080756220729             endif;
080757220729            endif;
080758220729
080759220729           exsr setFlags;
080760220729          endif;
080761220729
080762220729         endsl;
080763220729
080764220729         //if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N'
080765220729         //  or alreadySentF = 'N';
080766220729         // if planFound = 'Y';
080800220729         //  if writeRecord = 'Y';
080900220729         //   write cignaFile;
081000220729         //  endif;
081001190715
081100220729         //  if updateRecord = 'Y';
081200220729         //   update cignaFile;
081300220729         //  endif;
081301220729         // endif;
081302201202
081303220729         //exsr setFlags;
081304220729         //endif;
081400160516
081500190715        //endif;
081600180523
081700160516       endsr;
081800160511
081900160519      //===================================================================
082000160519      // Get group number
082100160519      //===================================================================
082200160519
082300160519       begsr getgrp;
082400160519
082500160519        setll (pltrst : plsub# : plplan) grater;
082600160519        reade (pltrst : plsub# : plplan) grater;
082700160519
082800160519        dow not %eof;
082900160519
083000160519         if today >= frmdat;
083100160519          if today <= todat;
083200160519           leavesr;
083300160519          else;
083400160519           group# = ' ';
083500160519          endif;
083600160519         endif;
083700160519
083800160519        reade (pltrst : plsub# : plplan) grater;
083900160519        enddo;
084000160519
084001230424        if group# = ' ' and cancelh > 0;
084002230424        setll (pltrst : plsub# : plplan) grater;
084003230424        reade (pltrst : plsub# : plplan) grater;
084004230424
084005230424        dow not %eof;
084006230424
084007230424         if cancelh >= frmdat;
084008230424          if cancelh <= todat;
084009230424           leavesr;
084010230424          else;
084011230424           group# = ' ';
084012230424          endif;
084013230424         endif;
084014230424
084015230424         reade (pltrst : plsub# : plplan) grater;
084016230424         enddo;
084017230424        endif;
084018230424
084019230424
084100190509       endsr;
084200160519
084300180312      //===================================================================
084400180312      // Coverage Type
084500180312      //===================================================================
084600180312
084700180312       begsr coverageType;
084800180312
084900180313        if catType = 'MED';
085000180313         mecovin = 'N';
085100180313         mscovin = 'N';
085200180313         mccovin = 'N';
085300180313         mcocovin = 'N';
085400180313
085500180313         select;
085600180313          when mcovtp = 'TIN';
085700180313           mecovin = 'Y';
085800180313
085900180313          when mcovtp = 'THW';
086000180313           mecovin = 'Y';
086100180313           mscovin = 'Y';
086200180313
086300180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
086400180313           mecovin = 'Y';
086500180313           mccovin = 'Y';
086600180313
086700180313          when mcovtp = 'TFA';
086800180313           mecovin = 'Y';
086900180313           mscovin = 'Y';
087000180313           mccovin = 'Y';
087100180313         endsl;
087200180313        endif;
087300180312
087400180313        if catType = 'DEN';
087500180313         decovin = 'N';
087600180313         dscovin = 'N';
087700180313         dccovin = 'N';
087800180313         dcocovin = 'N';
087900180313
088000180313         select;
088100180313          when mcovtp = 'TIN';
088200180313           decovin = 'Y';
088300180313
088400180313          when mcovtp = 'THW';
088500180313           decovin = 'Y';
088600180313           dscovin = 'Y';
088700180313
088800180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
088900180313           decovin = 'Y';
089000180313           dccovin = 'Y';
089100180313
089200180313          when mcovtp = 'TFA';
089300180313           decovin = 'Y';
089400180313           dscovin = 'Y';
089500180313           dccovin = 'Y';
089600180313         endsl;
089700180313        endif;
089800180313
089900180313        if catType = 'VIS';
090000180313         vecovin = 'N';
090100180313         vscovin = 'N';
090200180313         vccovin = 'N';
090300180313         vcocovin = 'N';
090400180313
090500180313         select;
090600180313          when mcovtp = 'TIN';
090700180313           vecovin = 'Y';
090800180313
090900180313          when mcovtp = 'THW';
091000180313           vecovin = 'Y';
091100180313           vscovin = 'Y';
091200180313
091300180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
091400180313           vecovin = 'Y';
091500180313           vccovin = 'Y';
091600180313
091700180313          when mcovtp = 'TFA';
091800180313           vecovin = 'Y';
091900180313           vscovin = 'Y';
092000180313           vccovin = 'Y';
092100180313         endsl;
092200180313        endif;
092300180313
092301210715        if catType = 'FSA';
092302210715         fecovin = 'N';
092303210715         fscovin = 'N';
092304210715         fccovin = 'N';
092305210715         fcocovin = 'N';
092306210715
092307210715         select;
092308210715          when mcovtp = 'TIN';
092309210715           fecovin = 'Y';
092310210715
092311210715          when mcovtp = 'THW';
092312210715           fecovin = 'Y';
092313210715           fscovin = 'Y';
092314210715
092315210715          when mcovtp = 'TPC' or mcovtp = 'TP2';
092316210715           fecovin = 'Y';
092317210715           fccovin = 'Y';
092318210715
092319210715          when mcovtp = 'TFA';
092320210715           fecovin = 'Y';
092321210715           fscovin = 'Y';
092322210715           fccovin = 'Y';
092323210715         endsl;
092324210715        endif;
092325210715
092400180312       endsr;
092500180312
092600180313      //===================================================================
092700180313      // Determine Type
092800180313      //===================================================================
092900180313
093000180313       begsr determineType;
093100180313
093200180319        catType = ' ';
093300180319
093400180313        chain ('P' : %subst(plncat:2:2)) codesFile;
093500180313        if %found;
093600180313
093700180313         select;
093800180313          when action = 'M';
093900180313           catType = 'MED';
094000180313
094100180313          when action = 'D';
094200180313           catType = 'DEN';
094300180313
094400180313          when action = 'V';
094500180313           catType = 'VIS';
094501210715
094502210715          when action = 'U' and code = 'FS';
094503210715           catType = 'FSA';
094504210715         endsl;
094505210715
094800180313        endif;
094900180313
095000180313       endsr;
095100180313
095200180313      //===================================================================
095300180313      // Relationship Codes
095400180313      //===================================================================
095500180313
095600180313       begsr relCodes;
095700180313
095800180313        select;
095900180313         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
096000180313          relcd = 'SP';
096100180313
096200180313         when drelcd = 'RDA' or drelcd = 'RSO';
096300180313          relcd = 'CH';
096400180313
096500180313         when drelcd = 'RDA' or drelcd = 'RSO';
096600180313          relcd = 'CH';
096700180313        endsl;
096800180313
096900180313       endsr;
097000180313
097100180424      //===================================================================
097200180424      // clear ssn
097300180424      //===================================================================
097400180424
097500180424       begsr clearSSN;
097600180424
097700180424        setll *loval cignaFile;
097800180424        read cignaFile;
097900180424        dow  not %eof;
098000180424         if mbrssn = '000000000';
098100180424          mbrssn = ' ';
098200180424           tssn = ' ';
098300180424          update cignaFile;
098400180424         endif;
098500180424
098600180424        read cignaFile;
098700180424        enddo;
098800180424
098900180424       endsr;
099000180424
099001190719      //===================================================================
099002190719      // clear file
099003190719      //===================================================================
099004190719
099005190719       begsr checkFile;
099006190719
099007190719        setll *loval cignaFile;
099008190719        read cignaFile;
099009190719        dow  not %eof;
099010190719
099011190719        if MACCT# = ' ' and  MTYPE  = ' ' and  MPLANID = ' ' and
099012190719            MBRANCHCD = ' ' and MBOPTCODE = ' ' and  MCOVEDATE = ' ' and
099013190719            MCOVCDATE = ' ' and  MECOVIN = ' ' and  MSCOVIN = ' ' and
099014190719             MCCOVIN  = ' ' and  MCOCOVIN = ' ' and
099015190719
099016190719           dACCT# = ' ' and  dTYPE  = ' ' and  dPLANID = ' ' and
099017190719            dBRANCHCD = ' ' and dBOPTCODE = ' ' and  dCOVEDATE = ' ' and
099018190719            dCOVCDATE = ' ' and  dECOVIN = ' ' and  dSCOVIN = ' ' and
099019190719             dCCOVIN  = ' ' and  dCOCOVIN = ' ' and
099020190719
099021190719           vACCT# = ' ' and  vTYPE  = ' ' and  vPLANID = ' ' and
099022190719            vBRANCHCD = ' ' and vBOPTCODE = ' ' and  vCOVEDATE = ' ' and
099023190719            vCOVCDATE = ' ' and  vECOVIN = ' ' and  vSCOVIN = ' ' and
099024190719             vCCOVIN  = ' ' and  vCOCOVIN = ' ';
099025190719           delete cignaFile;
099026190719           endif;
099027190719
099028190719        read cignaFile;
099029190719        enddo;
099046200423
099047190719       endsr;
099048190719
099049200423      //===================================================================
099050200424      // hardcodes
099051200423      //===================================================================
099052200423
099053200423       begsr doHardcodes;
099054200424
099055200424        exsr akvarr;
099056200617        exsr childrensHome;
099057200512        exsr ase;
099058200424
099059200424       endsr;
099060200423
099061200424      //===================================================================
099062200424      // Akvarr
099063200424      //===================================================================
099064200424
099065200424       begsr akvarr;
099066200424
099067200423        setll *loval cignaFile;
099068200423        read cignaFile;
099069200423        dow  not %eof;
099070200423
099071200423         if macct# = '622407';
099072200423          if mcovcdate = ' ';
099073200423           if mcovedate < '20200501';
099074200423            mcovedate = '20200501';
099075200423           endif;
099076200423          endif;
099077200423         endif;
099078200423
099079200423         if dacct# = '622407';
099080200423          if dcovcdate = ' ';
099081200423           if dcovedate < '20200501';
099082200423            dcovedate = '20200501';
099083200423           endif;
099084200423          endif;
099085200423         endif;
099086200423
099087200423         if vacct# = '622407';
099088200423          if vcovcdate = ' ';
099089200423           if vcovedate < '20200501';
099090200423            vcovedate = '20200501';
099091200423           endif;
099092200423          endif;
099093200423         endif;
099094200423
099095200424         update cignaFile;
099096200423
099097200423        read cignaFile;
099098200423        enddo;
099099200423
099100200423       endsr;
099101200423
099102220729      //===================================================================
099103220729      // fix dates
099104220729      //===================================================================
099105220729
099106220729       begsr fixDates;
099107220729
099108220729        setll *loval cignaFile;
099109220729        read cignaFile;
099110220729        dow  not %eof;
099111220729
099112220729         clear enrollDateM;
099113220729         clear enrollDateD;
099114220729         clear enrollDateV;
099115220729
099116220729         clear cancelDateM;
099117220729         clear cancelDateD;
099118220729         clear cancelDateV;
099119220729
099120220729         if mcovcdate = '0';
099121220729          mcovcdate = ' ';
099122220729         endif;
099123220729
099124220729         if dcovcdate = '0';
099125220729          dcovcdate = ' ';
099126220729         endif;
099127220729
099128220729         if vcovcdate = '0';
099129220729          vcovcdate = ' ';
099130220729         endif;
099131220729
099132220729
099133220729         if mcovedate > ' ';
099134220729          enrollDateM = %date(%dec(mcovedate:8:0));
099135220729         endif;
099136220729
099137220729         if dcovedate > ' ';
099138220729          enrollDateD = %date(%dec(dcovedate:8:0));
099139220729         endif;
099140220729
099141220729         if vcovedate > ' ';
099142220729          enrollDateV = %date(%dec(vcovedate:8:0));
099143220729         endif;
099144220729
099145220729         if mcovcdate > ' ';
099146220729          cancelDateM = %date(%dec(mcovcdate:8:0));
099147220729         endif;
099148220729
099149220729         if dcovcdate > ' ';
099150220729          cancelDateD = %date(%dec(dcovcdate:8:0));
099151220729         endif;
099152220729
099153220729         if vcovcdate > ' ';
099154220729          cancelDateV = %date(%dec(vcovcdate:8:0));
099155220729         endif;
099156220729
099157220729         if cancelDateM > d'0001-01-01' and enrollDateM > d'0001-01-01';
099158220729          if cancelDateM = (enrollDateM - %days(1));
099159220729           mcovcdate = mcovedate;
099160220729          endif;
099161220729         endif;
099162220729
099163220729         if cancelDateD > d'0001-01-01' and enrollDateD > d'0001-01-01';
099164220729          if cancelDateD = (enrollDateD - %days(1));
099165220729           dcovcdate = dcovedate;
099166220729          endif;
099167220729         endif;
099168220729
099169220729         if cancelDateV > d'0001-01-01' and enrollDateV > d'0001-01-01';
099170220729          if cancelDateV = (enrollDateV - %days(1));
099171220729           vcovcdate = vcovedate;
099172220729          endif;
099173220729         endif;
099174220729
099175220729         update cignafile;
099176220729
099177220729        read cignaFile;
099178220729        enddo;
099179220729
099180220729       endsr;
099181220729
099182200424      //===================================================================
099183200424      // Childrens Home
099184200424      //===================================================================
099185200424
099186200424       begsr childrensHome;
099187200424
099188200424        setll *loval cignaFile;
099189200424        read cignaFile;
099190200424        dow  not %eof;
099191200424
099192200424         if macct# = '622524';
099193200424          if mcovcdate = ' ';
099194200424           if mcovedate < '20200601';
099195200424            mcovedate = '20200601';
099196200424           endif;
099197200424          endif;
099198200424         endif;
099199200424
099200200424         update cignaFile;
099201200424
099202200424        read cignaFile;
099203200424        enddo;
099204200424
099205200424       endsr;
099206200424
099207200512      //===================================================================
099208200512      // American Society of Engineering
099209200512      //===================================================================
099210200512
099211200512       begsr ase;
099212200512
099213200512        setll *loval cignaFile;
099214200512        read cignaFile;
099215200512        dow  not %eof;
099216200512
099217200512         if macct# = '611156';
099218200512          if mcovcdate = ' ';
099219200512           if mcovedate < '20200601';
099220200512            mcovedate = '20200601';
099221200512           endif;
099222200512          endif;
099223200512         endif;
099224200512
099225200512         update cignaFile;
099226200512
099227200512        read cignaFile;
099228200512        enddo;
099229200512
099230200512       endsr;
099231220729      //===================================================================
099232220729      // check plan;
099233220729      //===================================================================
099234220729
099235220729       begsr checkPlan;
099236220729
099237220729        ok_toContinue = 'N';
099238220729
099239220729        chain (unique : mctrst : mcsub# : mcplan : acc#) planFile;
099240220729        if %found;
099241220729         ok_toContinue = 'Y';
099242220729        endif;
099243220729
099244220729        if ok_toContinue = 'Y';
099245220729         chain (mctrst : mcsub# : mcplan) plnmstFile;
099246220729         if pcarr = 'CIR' or pcarr = 'CIE' or pcarr = 'CIF';
099247220729          ok_toContinue = 'Y';
099248220729         else;
099249220729          ok_toContinue = 'N';
099250220729         endif;
099251220729        endif;
099252220729
099253220729       endsr;
099254220729
099255190509      //===================================================================
099256190509      // error report
099257190509      //===================================================================
099258190509
099259190509       begsr errorReport;
099260190509
099261190509        if macct# > ' ';
099262190509
099263190509         if mplanid = ' ';
099264190509          ctext = 'Plan ID/Benefit Opt missing';
099265190509          exsr writeError;
099266190509         endif;
099267190509
099268190509         if mbranchcd = ' ';
099269190509          ctext = 'Class ID/Branch Code missing';
099270190509          exsr writeError;
099271190509         endif;
099272190509
099273190509         if mboptcode = ' ';
099274190509          ctext = 'Subgroup/Parent Branch Code missing';
099275190509          exsr writeError;
099276190509         endif;
099277190509
099278190509        endif;
099279190509
099280190509        if dacct# > ' ';
099281190509
099282190509         if dplanid = ' ';
099283190509          ctext = 'Plan ID/Benefit Opt missing';
099284190509          exsr writeError;
099285190509         endif;
099286190509
099287190509         if dbranchcd = ' ';
099288190509          ctext = 'Class ID/Branch Code missing';
099289190509          exsr writeError;
099290190509         endif;
099291190509
099292190509         if dboptcode = ' ';
099293190509          ctext = 'Subgroup/Parent Branch Code missing';
099294190509          exsr writeError;
099295190509         endif;
099296190509
099297190509        endif;
099298190509
099299190509        if vacct# > ' ';
099300190509
099301190509         if vplanid = ' ';
099302190509          ctext = 'Plan ID/Benefit Opt missing';
099303190509          exsr writeError;
099304190509         endif;
099305190509
099306190509         if vbranchcd = ' ';
099307190509          ctext = 'Class ID/Branch Code missing';
099308190509          exsr writeError;
099309190509         endif;
099310190509
099311190509         if vboptcode = ' ';
099312190509          ctext = 'Subgroup/Parent Branch Code missing';
099313190509          exsr writeError;
099314190509         endif;
099315190509
099316190509        endif;
099317190509
099318210715        if facct# > ' ';
099319210715
099320210715         if fplanid = ' ';
099321210715          ctext = 'Plan ID/Benefit Opt missing';
099322210715          exsr writeError;
099323210715         endif;
099324210715
099325210715         if fbranchcd = ' ';
099326210715          ctext = 'Class ID/Branch Code missing';
099327210715          exsr writeError;
099328210715         endif;
099329210715
099330210715         if fboptcode = ' ';
099331210715          ctext = 'Subgroup/Parent Branch Code missing';
099332210715          exsr writeError;
099333210715         endif;
099334210715
099335210715        endif;
099336210715
099337190509       endsr;
099338190509
099339190509      //===================================================================
099340190509      // Write Error
099341190509      //===================================================================
099342190509
099343190509       begsr writeError;
099344190509
099345190509        mbrid = memid;
099346190509        ctrust = %char(mbtrst);
099347190509        csub# = %char(mbsub#);
099348190509        cacct = %char(mbacct);
099349190509        mbrlast = mlname;
099350190509        mbrfirst = mfname;
099351190509        mbrplan = plplan;
099352190509        mbrst = state;
099353190509
099354190509        chain (mbtrst : mbsub# : mbacct) actFile;
099355190509        if %found;
099356190509
099357211129         chain (maacode) aaFile;
099358190509         if %found;
099359190509          acctaa = %trim(afnam) + ' ' + %trim(alnam);
099360190509         endif;
099361190509
099362190509         write errorFile;
099363190509        endif;
099364190509
099365190509       endsr;
099366190509
099367160511      //===================================================================
099368160511      // exit
099369160511      //===================================================================
099400160511
099500160511       begsr exit;
099600160511
099700160511        *inlr = '1';
099800160511        return;
099900160511
100000160511       endsr;
100100160511
100200160511      //===================================================================
100300160511      // init
100400160511      //===================================================================
100500160520
100600160511       begsr init;
100700160511
100800180314        carrierCode1 = 'CIR';
100900180314        carrierCode2 = 'CIE';
101000180314        carrierCode3 = 'CIF';
101100180508        unique = '0000000251';
101200180309
101300160519        today = %dec(%char(%date:*iso0):8:0);
101301180315        term_dt_limit = %date - %days(60);
101400170710
101500160511       endsr;
101600010412
101700160511       //==============================================================
