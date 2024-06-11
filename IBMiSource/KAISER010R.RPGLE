000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400181031      * KAISER010R - Kaiser Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800180314      * 03/14/2018  jt    Original creation
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200180427     F                                     rename(accmsr:actFile)
001300180427
001400160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001500160513
001600160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001700180503     F                                     rename(plnmsr:plnr) prefix(P)
001800181101
001900181101     Fcarmstl   if   e           k disk    extfile('F.CARMSTL')
002000181101     F                                     rename(carmsr:carrFile)
002100180412
002200181031     Fmcov39    if   e           k disk    extfile('F.MCOV39')
002300181031
002400190321     Fmcovc16   if   e           k disk    extfile('F.MCOVC16')
002500190321     F                                     rename(mcovr:covc16)
002600160513
002700180309     Fmember    if   e           k disk    extfile('F.MEMBER')
002800160513
002900160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003000160513
003100160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003200160518
003300160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003400180508
003500181030     fpcpl1     if   e           k disk    extfile('F.PCPL1')
003600181030     f                                     rename(pcpr:pcpFile)
003700181030
003800181030     fkaiserdtl uf a e           k disk    rename(kaiserdr:kaiserFile)
003900160513
004000181030     fkaisertrm uf a e           k disk    rename(kaisertr:termFile)
004100180523
004200181113     ftransoff1 if   e           k disk    rename(transr:transFile)
004300181113
004400181030      *================================================================================
004500181030      *   opcode to convert yyyymmdd to mmddyyyy
004600181030      *   xxx = %editc( %dec(%char(%date(numericdate:*iso):*mdy0):8:0):'X');
004700160512      *=================================================================
004800061017
004900181101     d carrierCode     s              3
005000181101     d grouperCode     s              2
005100180913     d cancelDate      s               d
005200180913     d cancelh         s              8  0
005300160519     d today           s              8  0
005400180523     d alreadySent     s              1
005500180523     d ssn             s              9  0
005600180523     d seq#            s              2  0
005700180523     d ctype           s              3
005800180523     d termdt          s              8  0
005900181113     d iterYN          s              1
006000181113     d carrier         s              2  0
006100181105     d candtp          s              8
006200181105     d lastdate        s              8
006201190507     d dobc            s              8
006300181105     d error           s             20
006400150820
006500181105     d lastday         pr                  extpgm('LSTDAY')
006600181105     d  candtp                        8
006700181105     d  lastdate                      8    const
006800181105     d  error                        20    const
006900181105
007000160511      //==================================================================
007100160511      // mainline
007200160511      //===================================================================
007300150820
007400160511       exsr init;
007500160511       exsr main;
007600160511       exsr exit;
007700160511
007800181031      //===================================================================
007900181031      // main
008000181031      //===================================================================
008100181031
008200181031       begsr main;
008300181031
008400181101        setll grouperCode carrFile;
008500181101        reade grouperCode carrFile;
008600181101
008700181101        dow not %eof;
008800181101
008900181101         carrierCode = carrcd;
009000181101         exsr main2;
009100181101
009200181101        reade grouperCode carrFile;
009300181101        enddo;
009400181031
009500181031       endsr;
009600181031
009700180309      //===================================================================
009800181030      // main
009900180309      //===================================================================
010000180309
010100181031       begsr main2;
010200180309
010300180309        setll carrierCode plnmsr;
010400180309        reade carrierCode plnmsr;
010500180309
010600180309        dow not %eof;
010700180309
010800180313         setll (pltrst : plsub# : plplan) mcov39;
010900180313         reade (pltrst : plsub# : plplan) mcov39;
011000180313
011100180313         dow not %eof;
011200180309
011300180313          exsr process;
011400180309
011500180313         reade (pltrst : plsub# : plplan) mcov39;
011600180313         enddo;
011700180309
011800180309        reade carrierCode plnmsr;
011900180309        enddo;
012000180309
012100180309       endsr;
012200180309
012300160511      //===================================================================
012400160511      // process
012500160511      //===================================================================
012600160511
012700160511       begsr process;
012800160511
012900181030        chain mcssno member;
013000160511
013100190507        setgt (pltrst : plsub# : acc# : mcssno : plplan) covc16;
013101190507        readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
013102190507        dow not %eof;
013103190507         exsr writeMember;
013104190507        readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
013105190507        enddo;
013106190507        //chain (pltrst : plsub# : acc# : mcssno : plplan) covc16;
013200190507        //if %found;
013300190507        // exsr writeMember;
013400190507        //endif;
013500180508
013600160511       endsr;
013700160511
013800160513      //===================================================================
013900180313      // Write Member
014000160513      //===================================================================
014100160513
014200180313       begsr writeMember;
014300180313
014400181128        exsr checkTransmission;
014500181128        if iterYN = 'Y';
014600181128         leavesr;
014700181128        endif;
014701190507
014800190507        dobc = %editc( %dec(%char(%date(birth:*iso):*usa0):8:0):'X');
014801190507
014900181102        chain
015000190507        (%char(%editc(mbssno:'X')):%editc(mbssno:'X'): dobc :
015200181102        mlname:mfname:mmi) kaiserFile;
015300181102        if not %found;
015400181102
015500181102         clear kaiserFile;
015600181102
015700181102         drid = 'M';
015800181102         dlast = mlname;
015900181102         dfirst = mfname;
016000190507         dmit = mmi;
016100181108         dsexd = sex;
016200181108         ddob = %editc( %dec(%char(%date(birth:*iso):*usa0):8:0):'X');
016300181108         deffdate = %editc( %dec(%char(%date(enrldt:*iso):*usa0):8:0):'X');
016400181030
016500181102         if candt > 0;
016600181105          cancelh = candt;
016700181102           exsr sub1_fromDate;
016800181108          dtrmdate = %editc( %dec(%char(%date(cancelh:*iso):*usa0):8:0):'X');
016900181102         endif;
017000181030
017100181102         dadd1 = addr1;
017200181102         dadd2 = addr2;
017300181102         dcityd = city;
017400181108         dstated = state;
017500181102         dzipd = %editc(zip:'X');
017600181102         dhphone = %editc(area:'X') + %editc(phone:'X');
017700181102         dwphone = ' ';
017800181102         dwext = ' ';
017900181102         drel = 'SUB';
018000181102         dmssn = %editc(mbssno:'X');
018100181102         dsssn = %editc(mbssno:'X');
018200181030
018300181102         exsr getGroup;
018400181102         dgrp# = group#;
018500181102
018600181102         if empdt > 0;
018700181108          dhdate = %editc( %dec(%char(%date(empdt:*iso):*usa0):8:0):'X');
018800181102         endif;
018900181102
019000181102         seq# = 0;
019100181102         exsr pcp;
019200181102
019300181102         ssn = mbssno;
019400181102         seq# = 0;
019500181102         ctype = 'MED';
019600181102         termdt = candt;
019700181102
019800181102         exsr checkTerm;
019900181102         if alreadySent = 'N';
020000181102          write kaiserFile;
020100181102          exsr dependent;
020200181102         endif;
020300181102
020400181102        endif;
020500180523
020600160516       endsr;
020700060817
020800180913      //===================================================================
020900180913      // sub 1 from cancel date
021000180913      //===================================================================
021100180913
021200180913       begsr sub1_fromDate;
021300180913
021600181105        candtp = %char(cancelh);
021700181105        lastday(candtp : lastdate : error);
021800181105        cancelh = %dec(lastdate:8:0);
021900180913
022000180913       endsr;
022100180913
022200181030      //===================================================================
022300181030      // pcp
022400181030      //===================================================================
022500181030
022600181030       begsr pcp;
022700181030
022800181030        setll (%dec(mbssno:9:0) : seq# : 'MED') pcpFile;
022900181030        reade (%dec(mbssno:9:0) : seq# : 'MED') pcpFile;
023000181030        dow not %eof;
023100181030
023200181030         if pccan = 0;
023300181030
023400181030          if seq# = 0;
023500181030           dspcpc = pcid#;
023600181030            else;
023700181030           dmpcpc = pcid#;
023800181030          endif;
023900181030
024000181030        endif;
024100181030
024200181030        reade (%dec(mbssno:9:0) : seq# : 'MED') pcpFile;
024300181030        enddo;
024400181030
024500181030       endsr;
024600181030
024700180523      //===================================================================
024800180523      // check termed records;
024900180523      //===================================================================
025000180523
025100180523       begsr checkTerm;
025200180523
025300180523       alreadySent = 'N';
025400180523
025401190326       if dgrp# = ' ';
025402190326        alreadySent = 'Y';
025403190326        leavesr;
025404190326       endif;
025405190326
025500180523       if termdt > 0;
025600180523
025700180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
025800180523        if %found;
025900180523         alreadySent = 'Y';
026000180523         leavesr;
026100180523        endif;
026200180523
026300180523        if not %found;
026400180523         ttrst = pltrst;
026500180523          tsub# = plsub#;
026600180523           tacct = acc#;
026700180524            tssno = ssn;
026800180523             tseq# = seq#;
026900180523             ttype = ctype;
027000180523            tplan = plplan;
027100180523           ttermdt = termdt;
027200180523          ttrnsdt = %dec(%date);
027300180523         write termFile;
027400180523        endif;
027500180523
027600180523       endif;
027700180523
027800180523       endsr;
027900180524
028000160512      //===================================================================
028100160512      // process
028200160512      //===================================================================
028300160512
028400160512       begsr dependent;
028500160512
028600160512        setll mcssno depenr;
028700160512        reade mcssno depenr;
028800160512
028900160512        dow not %eof;
029000160512
029100180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
029200160512        if %found;
029300180313         exsr dependentCoverage;
029400160512        endif;
029500160512
029600160512        reade mcssno depenr;
029700160512        enddo;
029800160512
029900190326       endsr;
030000160512
030100160516      //===============================================================
030200160512      // Dependent coverage
030300160512      //===============================================================
030400160513
030500180313       begsr dependentCoverage;
030600160512
030700180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
030800180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
030900160512
031000160512        dow not %eof;
031100181030
031200181030         exsr writeDep;
031300181030
031400180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
031500160512        enddo;
031600160512
031700160512       endsr;
031800160512
031900160516      //===============================================================
032000160516      // write dependent
032100160516      //===============================================================
032200160516
032300160516       begsr writeDep;
032400180313
032500181102        chain
032600181102        (%char(%editc(depss#:'X')):%editc(mbssno:'X'):
032700181108        %editc( %dec(%char(%date(dbirth:*iso):*usa0):8:0):'X'):
032800181102        mlname:mfname:mmi) kaiserFile;
032900181102
033000181102        if not %found;
033100181102         clear kaiserFile;
033200181102
033300181102         drid = 'M';
033400181102         dlast = dlname;
033500181102         dfirst = dfname;
033600190507         dmit = dmi;
033700181108         dsexd = dsex;
033800181108         ddob = %editc( %dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
033900181108         deffdate = %editc( %dec(%char(%date(denrdt:*iso):*usa0):8:0):'X');
034000181030
034100181102         if ccandt > 0;
034200181105          cancelh = ccandt;
034300181102           exsr sub1_fromDate;
034400181108          dtrmdate = %editc( %dec(%char(%date(cancelh:*iso):*usa0):8:0):'X');
034500181102         endif;
034600181102
034700181102         dadd1 = daddr1;
034800181102         dadd2 = daddr2;
034900181102         dcityd = dcity;
035000181108         dstated = dstate;
035100181102         dzipd = %editc(dzip:'X');
035200181102         dhphone = %editc(area:'X') + %editc(phone:'X');
035300181102         dwphone = ' ';
035400181102         dwext = ' ';
035500181102         dmssn = %editc(depss#:'X');
035600181102         dsssn = %editc(mbssno:'X');
035700181030
035800181102         exsr getGroup;
035900181102         dgrp# = group#;
036000181102
036100181102         dhdate = ' ';
036200181102
036300181102         seq# = dpseq#;
036400181102         exsr pcp;
036500181102
036600181102         exsr relCodes;
036700181102
036800181102         ssn = mcssno;
036900181102         seq# = dpseq#;
037000181102         ctype = 'MED';
037100181102         termdt = ccandt;
037200181102
037300181102         exsr checkTerm;
037400181102         if alreadySent = 'N';
037500181102          write kaiserFile;
037600181102         endif;
037700180523
037800181102        endif;
037900181102
038000160516       endsr;
038100160511
038200160519      //===================================================================
038300160519      // Get group number
038400160519      //===================================================================
038500160519
038600181031       begsr getGroup;
038700160519
038800160519        setll (pltrst : plsub# : plplan) grater;
038900160519        reade (pltrst : plsub# : plplan) grater;
039000160519
039100160519        dow not %eof;
039200160519
039300160519         if today >= frmdat;
039400160519          if today <= todat;
039500160519           leavesr;
039600160519          else;
039700160519           group# = ' ';
039800160519          endif;
039900160519         endif;
040000160519
040100160519        reade (pltrst : plsub# : plplan) grater;
040200160519        enddo;
040300160519
040400190326       endsr;
040500180313
040600180313      //===================================================================
040700180313      // Relationship Codes
040800180313      //===================================================================
040900180313
041000180313       begsr relCodes;
041100180313
041200181030        select;
041300181030         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
041400181030          drel = 'SP';
041500181030
041600181030         when drelcd = 'RDA' or drelcd = 'RSO';
041700181030          drel = 'DEP';
041800181030
041900181030        endsl;
042000181030
042100180313       endsr;
042200180424
042300181113      //===================================================================
042400181113      // check for transmission
042500181113      //===================================================================
042600181113
042700181113       begsr checkTransmission;
042800181113
042900181113        iterYN = 'N';
043000181113
043100181113        chain (carrier : pltrst : plsub# : acc#) transFile;
043200181113        if %found;
043300181113         iterYN = 'Y';
043400181113        endif;
043500181113
043600181113       endsr;
043700181113
043800160511      //===================================================================
043900160511      // exit
044000160511      //===================================================================
044100160511
044200160511       begsr exit;
044300160511
044400160511        *inlr = '1';
044500160511        return;
044600160511
044700160511       endsr;
044800160511
044900160511      //===================================================================
045000160511      // init
045100160511      //===================================================================
045200160520
045300160511       begsr init;
045400160511
045500181101        grouperCode = 'KP';
045600181113        carrier = 15;
045700181031
045800160519        today = %dec(%char(%date:*iso0):8:0);
045900181105
046000160511       endsr;
046100010412
046200160511       //==============================================================
