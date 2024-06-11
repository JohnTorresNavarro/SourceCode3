000100221028      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000304200401      * EYEMED10R - Generate extract file for EyeMed
000305200401      *===========================================================================
001202200401      * Date        Int   Description
001203200401      * ----------  ---   --------------------------------------------------------
001204200401      * 05/12/2016  jt    Original creation
001205200401      * 04/01/2020  jt    %subst group#
001206200401      *===========================================================================
001207200401
001300160512
001400160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001500160513
001600160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001700160516     F                                     rename(PLNMSR:PLNR) prefix(P)
001800170619
001900170619     Fmcov39    if   e           k disk    extfile('F.MCOV39')
002000170619
002100170619     Fmcovc15   if   e           k disk    extfile('F.MCOVC15')
002200170619     F                                     rename(MCOVR:COVC15)
002300160513
002400160516     Fmcov      if   e           k disk    extfile('F.MCOV')
002500160516     F                                     rename(MCOVR:COVR) Prefix(M)
002600160513
002700160516     Fmember    if   e           k disk    extfile('F.MEMBER')
002800160513
002900160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003000160513
003100160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003200160513
003300160518     Fcaraccp   if   e           k disk
003400160518
003500160518     Fcarplnl   if   e           k disk
003600160518
003700160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003800160518
003900160518     Feyemed081auf a e           k disk
004000160513
004100160512      *=================================================================
004200061017
004300160516     d EyeMed          S              3A   Inz('EYV')
004400160519     d vision          S              3A   Inz('PVS')
004500160513     d h@ssn           S              9  0
004600160519     d term_dt_limit   s               d
004700160519     d unique          s             10    inz('0000000161')
004800160519     d deptotal        s              2  0
004900160519     d today           s              8  0
005000170710     D work_date       S               d
005100190724     D writeRecord     S              1
005200150820
005300160511      //==================================================================
005400160511      // mainline
005500160511      //===================================================================
005600150820
005700160511       exsr init;
005800160511       exsr main;
005900160511       exsr exit;
006000160511
006100160511      //===================================================================
006200160511      // main
006300160511      //===================================================================
006400160511
006500160511       begsr main;
006600160511
006700160516        setll eyemed plnmsr;
006800160511        reade eyemed plnmsr;
006900160511
007000160511        dow not %eof;
007100160511
007200160511         if plncat = vision;
007300160511
007400160511          h@ssn = 0;
007500160511
007600170619          setll (pltrst : plsub# : plplan) mcov39;
007700170619          reade (pltrst : plsub# : plplan) mcov39;
007800160511
007900160511          dow not %eof;
008000160511
008100160518           chain (unique : pltrst : plsub# : plplan) carplnr;
008200160518           if %found;
008300160518            chain (unique : pltrst : plsub# : cpacct) caraccr;
008400160518             if %found;
008500160518              if castatus = 'N';
008600160518               leave;
008700160518               else;
008800160518
008900160518               if candt = 0;
009000160518                candt = 99999999;
009100160518               endif;
009200160511
009300160518               if mcssno <> h@ssn;
009400160518                exsr process;
009500160518                h@ssn = mcssno;
009600160518               endif;
009700160511
009800160518              endif;
009900160518             endif;
010000160518            endif;
010100160518
010200170619          reade (pltrst : plsub# : plplan) mcov39;
010300160511          enddo;
010400160511
010500160511         endif;
010600160511
010700160511        reade eyemed plnmsr;
010800160511        enddo;
010900160511
011000160511       endsr;
011100160511
011200160511      //===================================================================
011300160511      // process
011400160511      //===================================================================
011500160511
011600160511       begsr process;
011700160511
011800170619        chain mcssno member;
011900160511
012000170619        chain (pltrst : plsub# : cpacct : mcssno : plplan) covc15;
012100170619
012101190923        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
012102190923           pltrst = 3 and plsub# = 1 and cpacct = 2497;
012103190923
012104190923        if candt <> 99999999 and candt <> 0;
012105190923
012107190923         if candt <= 20190801;
012108190923          leavesr;
012109190923         else;
012110190923          exsr writeExport;
012111190923          leavesr;
012112190923         endif;
012113190923
012114190923        else;
012115190923         exsr writeExport;
012116190923          leavesr;
012117190923        endif;
012118190923
012119190923        endif;
012200160517        //If record is termed see if we need to stop sending...
012300160517        if candt <> 99999999 and candt <> 0;
012400160511
012500160517         term_dt_limit = %date(candt);
012600190923         if %date() - %days(11) > term_dt_limit;
012700160517          leavesr;
012800160517         else;
012900160517          exsr writeExport;
013000160517         endif;
013100160511
013200160517        else;
013300160517         exsr writeExport;
013400160517        endif;
013500160511
013600160511       endsr;
013700160511
013800160513      //===================================================================
013900160513      // write export
014000160513      //===================================================================
014100160513
014200160516       begsr writeExport;
014300160513
014400160519        exsr getgrp;
014401221012
014500200401        eplanid = %subst(group#:1:7);
014600190724        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
014700190724           pltrst = 3 and plsub# = 1 and cpacct = 2497;
014800190724          eplanid = '1023529';
014900190724        endif;
015000190724
015100160517        ememid = %trim(%editc(mcssno:'X'));
015200160516        efname = mfname;
015300160516        elname = mlname;
015400160516        emi = mmi;
015500160516        eaddr1 = addr1;
015600160516        eaddr2 = addr2;
015700160516        ecity = city;
015800160516        estate = state;
015900160516        ezip = %trim(%editc(zip:'X'));
016000160520        edob = %trim(%editc(%dec(%char(%date(birth : *iso) : *usa0) : 8 : 0)
016100160520                     :'X'));
016200160517        ebopt = 'LEV1';
016300160523        ediv = ' ';
016400160517        epsub = %trim(%editc(mcssno:'X'));
016500160516        essn = %trim(%editc(mcssno:'X'));
016600160517
016700160517        ephone = ' ';
016800160517        if area > 0 and phone > 0;
016900160517         ephone = %char(area) + %char(phone);
017000160517        endif;
017100160517
017200160516        egender = sex;
017300160516        emeduse = ' ';
017400160520        eedate = %trim(%editc(
017500160520                       %dec(%char(%date(enrldt : *iso) : *usa0) : 8 : 0):'X'));
017600190724
017700190724        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
017800190724           pltrst = 3 and plsub# = 1 and cpacct = 2497;
017900190724         if enrldt < 20190801;
018000190724          eedate = '08012019';
018100190724         endif;
018200221012        endif;
018300160517
018400160517        if candt = 99999999 or candt = 0;
018500160517         etdate = ' ';
018600160517        else;
018601221012
018602221012         if enrldt <> candt;
018700221012          work_date = %date(%dec(candt:8:0)) - %days(1);
018701221012         else;
018702221012          work_date = %date(%dec(candt:8:0));
018703221012         endif;
018704221012
018800221012         candt = %dec(work_date);
018900221012         etdate = %trim(%editc(
019000160520                  %dec(%char(%date(candt:*iso):*usa0):8:0):'X'));
019100160516        endif;
019200160516
019300190724
019400160516        emtype = 'S';
019500160516        erel = 'H';
019600160517        etier = ' ';
019700160517        eupdact = ' ';
019800190725
019900190725        elcode = ' ';
020000190725        if pltrst = 3 and plsub# = 1 and cpacct = 911;
020100190725         elcode = 'Cava Mezze Grille';
020200190725        endif;
020201221012
020300190725        if pltrst = 3 and plsub# = 1 and cpacct = 2497;
020400190725         elcode = 'Zoes Kitchen';
020500190725        endif;
020600190725
020700160517        ememail = fill66;
020800160513
020900190724        writeRecord = 'Y';
021000190724        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
021100190724           pltrst = 3 and plsub# = 1 and cpacct = 2497;
021200190923          //if etdate > ' ';
021300190923          // writeRecord = 'N';
021400190923          //endif;
021500190923        endif;
021600190724
021700190724        if writeRecord = 'Y';
021800190724         write eyemedr;
021900190724        endif;
022000160516
022100160518        deptotal = 0;
022200160518
022300160516        if mcovtp <> 'TIN';
022400160516         exsr dependent;
022500160516        endif;
022600160516
022700160518        chain (%trim(%editc(mcssno:'X'))) eyemedr;
022800160518        if %found;
022900160518         if emtype = 'S';
023000160518          enumdep = %char(deptotal);
023100160518          update eyemedr;
023200160518         endif;
023300160518        endif;
023400160518
023500160516       endsr;
023600060817
023700160512      //===================================================================
023800160512      // process
023900160512      //===================================================================
024000160512
024100160512       begsr dependent;
024200160512
024300160512        setll mcssno depenr;
024400160512        reade mcssno depenr;
024500160512
024600160512        dow not %eof;
024700160512
024800160516        chain (mctrst:mcsub#:mcplan:dssno:dpseq#) dcovr;
024900160512        if %found;
025000160512         exsr $dcov;
025100160512        endif;
025200160512
025300160512        reade mcssno depenr;
025400160512        enddo;
025500160512
025600190923       endsr;
025700160512
025800160516      //===============================================================
025900160512      // Dependent coverage
026000160512      //===============================================================
026100160513
026200160512       begsr $dcov;
026300160512
026400160516        setgt (mctrst:mcsub#:mcplan:dssno:dpseq#) dcovr;
026500160516        readpe (mctrst:mcsub#:mcplan:dssno:dpseq#) dcovr;
026600160512
026700160512        dow not %eof;
026800160512
026801190923        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
026802190923           pltrst = 3 and plsub# = 1 and cpacct = 2497;
026803190923
026804190923        if ccandt <> 99999999 and ccandt <> 0;
026805190923
026806190923         if ccandt <= 20190801;
026807190923          leavesr;
026808190923         else;
026809190923          exsr writeDep;
026810190923          leavesr;
026811190923         endif;
026812190923
026813190923        else;
026814190923         exsr writeDep;
026815190923          leavesr;
026816190923        endif;
026817190923
026818190923        endif;
026819190923
026900160512         if ccandt <> 99999999  and ccandt <> 0;
027000160512
027100160516          term_dt_limit = %date(ccandt);
027101190923          if %date() - %days(11) > term_dt_limit;
027300160512           leavesr;
027400160512          else;
027500160512
027600160516           exsr writeDep;
027700160512          endif;
027800160512
027900160512         else;
028000160516          exsr writeDep;
028100160512          leavesr;
028200160512         endif;
028300160512
028400160516        readpe (mctrst:mcsub#:mcplan:dssno:dpseq#) dcovr;
028500160512        enddo;
028600160512
028700160512       endsr;
028800160512
028900160516      //===============================================================
029000160516      // write dependent
029100160516      //===============================================================
029200160516
029300160516       begsr writeDep;
029400160516
029500160520        exsr getgrp;
029501221012
029600200401        eplanid = %subst(group#:1:7);
029700190724        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
029800190724           pltrst = 3 and plsub# = 1 and cpacct = 2497;
029900190724          eplanid = '1023529';
030000190724        endif;
030100160518
030200160517        ememid = %trim(%editc(mcssno:'X')) + %trim(%editc(dpseq#:'X'));
030300160517        efname = dfname;
030400160517        emi = dmi;
030500160517        elname = dlname;
030600160517        eaddr1 = daddr1;
030700160517        eaddr2 = daddr2;
030800160517        ecity = dcity;
030900160517        estate = dstate;
031000190822        ezip = %trim(%editc(dzip:'X'));
031100160520        edob = %trim(%editc(%dec(%char(%date(dbirth : *iso) : *usa0) : 8 : 0)
031200160520                     :'X'));
031300160517        ebopt = 'LEV1';
031400160523        ediv = ' ';
031500160520        epsub = %trim(%editc(mcssno:'X'));
031600160517        essn = %trim(%editc(depss#:'X'));
031700160517
031800160517        ephone = ' ';
031900160517        if darea > 0 and dphone > 0;
032000160517         ephone = %char(darea) + %char(dphone);
032100160517        endif;
032200160517
032300160517        egender = %char(dsex);
032400160517        emeduse = ' ';
032500160520        eedate = %trim(%editc(
032600160520                       %dec(%char(%date(denrdt : *iso) : *usa0) : 8 : 0):'X'));
032700160516
032800190724        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
032900190724           pltrst = 3 and plsub# = 1 and cpacct = 2497;
032901221012
033000190724         if denrdt < 20190801;
033100190724          eedate = '08012019';
033200190724         endif;
033201221012
033300221012        endif;
033400190724
033500160517        if ccandt = 99999999 or ccandt = 0;
033600160517         etdate = ' ';
033700160517        else;
033701221012
033702221012         if enrldt <> candt;
033800221012          work_date = %date(%dec(ccandt:8:0)) - %days(1);
033801221012         else;
033802221012          work_date = %date(%dec(ccandt:8:0));
033803221012         endif;
033804221012
033900221012         ccandt = %dec(work_date);
034000221012         etdate = %trim(%editc(
034100160520                        %dec(%char(%date(ccandt : *iso) : *usa0) : 8 : 0):'X'));
034200221012        endif;
034300160517
034400160517        emtype = 'D';
034500160517
034600160517        select;
034700160517         when drelcd = 'RWI';
034800160517          erel = 'S';
034900160517
035000160517         when drelcd = 'RHU';
035100160517          erel = 'S';
035200160517
035300160517         when drelcd = 'RDA';
035400160517          erel = 'C';
035500160517
035600160517         when drelcd = 'RSO';
035700160517          erel = 'C';
035800160517
035900160517         when drelcd = 'RPA';
036000160517          erel = 'P';
036100160517
036200160517         other;
036300160517          erel = 'O';
036500221012        endsl;
036600160517
036700160517        etier = ' ';
036800160517        eupdact = ' ';
036900190725
037000160518        elcode = ' ';
037100190725        if pltrst = 3 and plsub# = 1 and cpacct = 911;
037200190725         elcode = 'Cava Mezze Grille';
037300190725        endif;
037400190725        if pltrst = 3 and plsub# = 1 and cpacct = 2497;
037500190725         elcode = 'Zoes Kitchen';
037600190725        endif;
037700190725
037800160518        enumdep = ' ';
037900160517        ememail = ' ';
038000160513
038100160518        deptotal = deptotal + 1;
038200160518
038300190724        writeRecord = 'Y';
038400190724        if pltrst = 3 and plsub# = 1 and cpacct = 911 or
038500190724           pltrst = 3 and plsub# = 1 and cpacct = 2497;
038600190923          //if etdate > ' ';
038700190923          // writeRecord = 'N';
038800190923          //endif;
038900190724         endif;
039000190724
039100190724        if writeRecord = 'Y';
039200221012         write eyemedr;
039300190724        endif;
039400160516
039500160516       endsr;
039600160511
039700160519      //===================================================================
039800160519      // Get group number
039900160519      //===================================================================
040000160519
040100160519       begsr getgrp;
040200160519
040300160519        setll (pltrst : plsub# : plplan) grater;
040400160519        reade (pltrst : plsub# : plplan) grater;
040500160519
040600160519        dow not %eof;
040700160519
040800160519         if today >= frmdat;
040900160519          if today <= todat;
041000160519           leavesr;
041100160519          else;
041200160519           group# = ' ';
041300160519          endif;
041400160519         endif;
041500160519
041600160519        reade (pltrst : plsub# : plplan) grater;
041700160519        enddo;
041800160519
041900190923       endsr;
042000160519
042100160511      //===================================================================
042200160511      // exit
042300160511      //===================================================================
042400160511
042500160511       begsr exit;
042600160511
042700160511        *inlr = '1';
042800160511        return;
042900160511
043000160511       endsr;
043100160511
043200160511      //===================================================================
043300160511      // init
043400160511      //===================================================================
043500160520
043600160511       begsr init;
043700160511
043800160519        today = %dec(%char(%date:*iso0):8:0);
043900170710
044000160511       endsr;
044100010412
044200160511       //==============================================================
