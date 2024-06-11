000100190315      *====================================================================
000200161020     H option(*noDebugIo)
000300190315      *====================================================================
000400190205      * ADVEX11R - Generate Advantica Export
000500190315      *====================================================================
000600190205      * Date        Int   Description
000700190315      * ----------  ---   -------------------------------------------------
000800190205      * 01/01/2009  szz   Original creation
000900190205
001000190205      * 08/31/2099  szz   Per Aliesha at Advantica:  If Cobra, use SSM 3 as
001100190205      *                   group#; if TNT, use SSM TNT and if anything else
001200190205      *                   (for SSM) use SSM GEN.
001300161020
001400190205      * 09/11/2009  szz   Per Aliesha at Advantica:  No TNT; all are SSM GEN.
001500161020
001600190205      * 04/29/2010  szz   Per Dave A Only send terms once.
001700161020
001800190205      * 02/21/2011  szz   Per Dave A send same-day terms based on Carlos
001900190205      *                   (at Advantica's) request.
002000161020
002100190205      * 03/02/2011  szz   Per Dave A send same-day terms only if no active
002200190205      *                   Advantica coverage exists for the member.
002300161020
002400190205      * 06/06/2012  SSK   FIX ZIP CODE EDIT PER ARSINEH VERTANI. CHANGE FROM EDIT
002500190205      *                   CODE "P" TO "X"
002600161020
002700190205      * 07/23/2012  szz   Per Deborah Clark and Dave A: do not send account
002800190205      *                   590-10-6 anymore so that they will not show as termed.
002900161020
003000190205      * 03/08/2013  szz   Per email from Stephen from Brenda Chaid do not
003100190205      *                   send a term for Thermoform as they are still active
003200190205      *                   w/Advantica (590.12.13)
003300161020
003400190205      * 09/16/2013  SSK   PER DEB CLARK, REMOVE REDZONE FROM EXPORT
003500161020
003600190205      * 01/22/2013  SSK   PER WENDY, REMOVE VAPOTHERM (FI) VERSION
003700161020
003800190205      * 02/24/2015  DMA   Per Deborah, remove 300.8.66
003900161020
004000190205      * 03/17/2015  DMA   Change edit code to keep leading 0's in SSN
004100161020
004200190205      * 04/24/2015  DMA   Change DP relationship code from 21 to 53
004300161020
004400190205      * 04/25/2015  DMA   Change several coverage level codes
004500161020
004600190205      * 08/03/2015  DMA   Go back to 3 character coverage level codes
004700161020
004800190205      * 08/27/2015  JT    Created a xRef file to use new coverage level codes
004900161020
005000190205      * 10/02/2015  JT    Commented out hardcoding to an account (590-009-0017).
005100190205      *                   Advantica said codes were wrong.
005200161020
005300190205      * 01/13/2016  JT    Added Planet Finess (003-001-0569) and Brick
005400190205      *                   Boddies (003-001-0536) to not send.
005500160113
005600190205      * 11/21/2016  JT    Added logic to automatically creat xRef records, eliminating manual
005700190205      *                   entry.
005800161121
005900190205      * 09/27/2017  JT    Added Chrysalis House (591-006-0396) and Brick
006000190205      *                   Boddies (003-001-0536) to not send.
006100170927
006200190205      * 10/04/2017  JT    Hardcoded 321501126 to send 01/01/2017 as effective date.
006300171025
006400190205      * 10/25/2017  JT    Added Akehurst Landscape (905-001-0021) to not send.
006500171025
006600190205      * 10/26/2017  JT    Created a file (advantcoff) instead of hardcoding
006700190205      *                   T/S/A to not send.
006800171026
006900190205      * 02/04/2019  jt    Rewritten
007000190205
007100190315      *====================================================================
007200161020
007300190204     FPLNMSTN1  IF   E           K Disk    ExtFile('F.PLNMSTN1')
007400161020
007500110302     FPLNMST    IF   E           K Disk    Rename(PLNMSR:PLNR) Prefix(P)
007600190204     F                                     ExtFile('F.PLNMST')
007700161020
007800190206     FMCOV39    IF   E           K Disk    ExtFile('F.MCOV39')
007900161020
008000110302     FMCOV      IF   E           K Disk    Rename(MCOVR:COVR) Prefix(M)
008100190204     F                                     ExtFile('F.MCOV')
008200161020
008300190205     faccmst    if   e           k disk    ExtFile('F.ACCMST')
008400190205     f                                     rename(accmsr:acctFile)
008500190205
008600190206     fac2mstl2  if   e           k disk    rename(accmsr2:acct2File)
008700190206
008800190205     fmember    if   e           k disk    ExtFile('F.MEMBER')
008900190205     f                                     rename(membr:memberFile)
009000161020
009100190204     FDEPNDC    IF   E           K Disk    ExtFile('F.DEPNDC')
009200161020
009300190204     FDCOV22    IF   E           K Disk    ExtFile('F.DCOV22')
009400161020
009500190204     FGRATE     IF   E           K Disk    ExtFile('F.GRATE')
009600161020
009700190206     fadvtrmp   uf a e           k disk    rename(advtrmr:termFile)
009800161020
009900190206     fadvxref   if   e           k disk    rename(advxrefr:xrefFile)
010000171025
010100190206     fadvantcoffif   e           k disk
010200190204
010300190204     fadvdetail uf a e           k disk    rename(advr:mainFile)
010400161020
010500190315      *====================================================================
010600161020
010700171031     D*               UDS
010800171031     D*LUSER                  25     32
010900061017
011000190318     D Advantica       s              3A
011100190318     D tier            s              7
011200190318     d ok_toTransmit   s              1
011300171026     d today           s              8  0
011400171026     d h@ssn           s              9  0
011500171027     d activePlan      s              1
011600171031     d lastdate        s              8
011700171030     d lastdaten       s              8  0
011800171030     d candtp          s              8
011900171030     d error           s             20
012000171030     d expdt           s              8  0
012100171030     d group#new       s             15
012200171030     d subpol          s             11
012300171030     d mempol          s             11
012400171030     d hp              s             10
012500171030     d wp              s             10
012600171030     d cp              s             10
012700171030     d nsuf            s             11
012800171030     d email           s              5
012900171030     d marsts          s             14
013000171030     d prel            s              3
013100171030     d lname           s             18
013200171030     d fname           s             12
013300171030     d mi              s              1
013400171030     d gender          s              1
013500171031     d dob             s              8  0
013600171031     d effdt           s              8  0
013700190204     d cssno           s              9
013800190204     d tssno           s              9
013900190206     d writeRecord     s              1
014000190318     d updateRecord    s              1
014100150820
014200171030     d lastday         pr                  extpgm('LSTDAY')
014300171030     d  candtp                        8    const
014400171030     d  lastdate                      8    const
014500171030     d  error                        20    const
014600171030
014700171030     d xref            pr                  extpgm('ADVXREFR')
014800171030     d  mctrst                        3  0
014900171030     d  mcsub#                        3  0
015000171030     d  acc#                          4  0
015100171030     d  mcplan                        4
015200171030
015300190204     d convertPF       pr                  extpgm('ADVEX12R')
015400190204
015500190205     d advex11r        pi
015600190205     d  type                          3
015700190205
015800171026      //===================================================================
015900171026      // mainline
016000171026      //===================================================================
016100171026
016200171026       exsr init;
016300171026       exsr main;
016400171026       exsr exit;
016500150820
016600171026      //===================================================================
016700171026      // main
016800171026      //===================================================================
016900171026
017000171026       begsr main;
017100171026
017200171026        setll advantica plnmsr;
017300190204        reade advantica plnmsr;
017400190204
017500190204        dow not %eof;
017600171026
017700190315         //updateRecord = 'N';
017800190315         //writeRecord = 'N';
017900190206
018000190205        if plncat = type;
018100161020
018200190206          h@ssn = 0;
018300171026
018400190206          setll (pltrst : plsub# : plplan) mcov39;
018500190206          reade (pltrst : plsub# : plplan) mcov39;
018600190204
018700190204          dow not %eof;
018800171027
018900190204          if candt = 0;
019000190204           candt = 99999999;
019100190204          endif;
019200171027
019300190206           if mcssno <> h@ssn;
019400190204
019500190204            if enrldt = candt;
019600190204             exsr determineSDT;
019700190204            else;
019800190204             activePlan = 'N';
019900190204            endif;
020000171027
020100190204            if activePlan = 'N';
020200190204             exsr process;
020300190204             h@ssn = mcssno;
020400190204            endif;
020500171027
020600190206           endif;
020700171027
020800190206          reade (pltrst : plsub# : plplan) mcov39;
020900171031          enddo;
021000171027
021100171031         endif;
021200190204
021300190204        reade advantica plnmsr;
021400171031        enddo;
021500010403
021600171027       endsr;
021700171026
021800171030      //===================================================================
021900171030      // process
022000171030      //===================================================================
022100171030
022200171030       begsr process;
022300171030
022400190205        chain mcssno memberFile;
022500171030
022600171030        if candt <> 99999999;
022700171030
022800171030         chain (mcssno:mdseq#:candt:mcplan:mcovtp:mctrst:mcsub#:acc#) advtrmp;
022900171030         if %found(ADVTRMP);
023000171030          leavesr;
023100171030         else;
023200190206          clear termFile;
023300171030          assno = mcssno;
023400171030          adepno = 00;
023500171030          aplan = mcplan;
023600171030          acovtyp = mcovtp;
023700171030          atrst = mctrst;
023800171030          asub# = mcsub#;
023900171030          aacct = acc#;
024000171030          atrmpdt = today;
024100171030          atermdt = candt;
024200171030          candtp = %editc(candt:'X');
024300171030
024400171030          // Determine last day of month as term date...
024500171030          lastday(candtp : lastdate : error);
024600171026
024700171030          lastdaten = %dec(lastdate:8:0);
024800190206          //write termFile;
024900171030          exsr writeExport;
025000171030         endif;
025100171030
025200171030        else;
025300171030         exsr writeExport;
025400171030        endif;
025500171030
025600171030       endsr;
025700171027
025800171027      //===================================================================
025900171027      // This subroutine is only executed if it's a same-day term.
026000171027      // It will search the member's coverages to determine if there is an
026100171027      // active Advantica plan OTHER than the one that is a same-day term.
026200171027      // The same-day term will be sent ONLY if there is no other active
026300171027      // Advantica plan for the member.
026400171027      //===================================================================
026500171027
026600171027       begsr determineSDT;
026700171027
026800171030        activePlan = 'N';
026900171027
027000171030        setll mcssno mcov;
027100171030        reade mcssno mcov;
027200171027
027300171030        dow not %eof;
027400171030         if mcandt = 0 or mcandt > today and mmcplan <> mcplan;
027500171027
027600171030         chain (mmctrst : mmcsub# : mmcplan) plnmst;
027700171030         if %found;
027800171027
027900171030          if ppcarr = advantica;
028000171030           activePlan = 'Y';
028100171030           leave;
028200171030          endif;
028300171027
028400171030         endif;
028500171027
028600171030        endif;
028700171027
028800171027        reade mcssno mcov;
028900171027        enddo;
029000171027
029100171027       endsr;
029200171027
029300171030      //===================================================================
029400171030      // write export
029500171030      //===================================================================
029600171030
029700171030       begsr writeExport;
029800171030
029900190205        exsr checkAcct;
030000190205
030100190318        if ok_toTransmit = 'N';
030200190205         leavesr;
030300190205        endif;
030400190205
030500171030        exsr miscFields;
030600171031
030700190206        dob = birth;
030800190206        effdt = enrldt;
030900171030
031000171030        if candt = 0 or candt = 99999999;
031100190206         expdt = 99991231;
031200171030        else;
031300171030         candtp = %editc(candt:'X');
031400171031          lastday(candtp : lastdate : error);
031500171031          lastdaten = %dec(lastdate:8:0);
031600190206         expdt = lastDateN;
031700171030        endif;
031800171030
031900171030        if enrldt = candt;
032000171030         expdt = enrldt;
032100171030        endif;
032200171030
032300171030        ssno = mcssno;
032400171030        prel = '18 ';
032500171030        group#new = ' ';
032600171030
032700171030        if group# = 'SSMGEN    '  or group# = 'SSMTNT    ';
032800171030
032900171030         if empst = 'C';
033000171030          group#new = 'SSM 3     ';
033100171030         else;
033200171030
033300171030          if group# =   'SSM       ';
033400171030           group#new = 'SSM GEN   ';
033500171030          endif;
033600171030
033700171030          if group# = 'SSMGEN    ';
033800171030           group#new = 'SSM GEN   ';
033900171030          endif;
034000171030
034100171030          if group# =   'SSMTNT    ';
034200171030           group#new = 'SSM TNT   ';
034300171030          endif;
034400171030
034500171030         endif;
034600171030
034700171030        else;
034800171030         group#new = group#;
034900171030        endif;
035000171030
035100190206        exsr writeRcd;
035200171030
035300171030        if mcovtp <> 'TIN';
035400171030         exsr dependent;
035500171030        endif;
035600171030
035700171030       endsr;
035800171030
035900171026      //===================================================================
036000190204      // write record
036100171026      //===================================================================
036200171026
036300190206       begsr writeRcd;
036400171004
036500190315        updateRecord = 'N';
036600190315        writeRecord = 'N';
036700190315
036800171026        if mcssno = 321501126;
036900190206         effdt = 20170101;
037000171026        endif;
037100190206
037200190206        chain (cssno:tssno:lname:fname:mi:%char(dob)) mainFile;
037300190204        if %found;
037400190206         updateRecord = 'Y';
037500190206        else;
037600190206         writeRecord = 'Y';
037700190206        endif;
037800190205
037900190206        if updateRecord = 'Y';
038000190206
038100190205         if type = 'PVS';
038200190206           vinscod = 'VIS';
038300190206           veffdate = %char(effdt);
038400190204
038500190205           if expdt > 0;
038600190206            vcandate = %char(expdt);
038700190205           endif;
038800190206
038900190206         endif;
039000190205
039100190205         if type = 'PDN';
039200190206           dinscod = 'DEN';
039300190206           deffdate = %char(effdt);
039400190206
039500190206           if expdt > 0;
039600190206            dcandate = %char(expdt);
039700190206           endif;
039800190205
039900190205         endif;
040000190204
040100190206         update mainfile;
040200190205
040300190206        endif;
040400190204
040500190206        if writeRecord = 'Y';
040600190206
040700190206         group# = group#new;
040800190206         tiercode = tier;
040900190206         lastname = lname;
041000190206         firstname = fname;
041100190206         address1 = addr1;
041200190206         address2 = addr2;
041300190206         ccity = city;
041400190206         cstate = state;
041500190206         czip = %editc(zip:'X');
041600190206         dateofbth = %char(dob);
041700190206         relcd = prel;
041800190204
041900190206         if type = 'PVS';
042000190206           vinscod = 'VIS';
042100190206           veffdate = %char(effdt);
042200190206
042300190206           if expdt > 0;
042400190206            vcandate = %char(expdt);
042500190206           endif;
042600190206
042700190206         endif;
042800190204
042900190206         if type = 'PDN';
043000190206           dinscod = 'DEN';
043100190206           deffdate = %char(effdt);
043200190206
043300190206           if expdt > 0;
043400190206            dcandate = %char(expdt);
043500190206           endif;
043600190206
043700190206         endif;
043800190205
043900190205         exsr getName;
044000190205
044100190206         transcode = '30';
044200190206         transdate = %char(%dec(%date));
044300190206
044400190204         write mainfile;
044500190204        endif;
044600171026
044700171026       endsr;
044800060817
044900171030      //===================================================================
045000171030      // misc. fields
045100171030      //===================================================================
045200171030
045300171030       begsr miscFields;
045400171030
045500190205        exsr getGroup;
045600171030
045700190206        dob = birth;
045800171030
045900190206        memssn = %editc(mcssno:'X');
046000190206        depssn = %editc(mcssno:'X');
046100190206        cssno = %editc(mcssno:'X');
046200190206        tssno = %editc(mcssno:'X');
046300190206        subsid = 'Y';
046400190206
046500171030        lname = mlname;
046600171030        fname = mfname;
046700171030        mi = mmi;
046800171030        gender = sex;
046900171030
047000171030        subpol = ' ';
047100171030        mempol = ' ';
047200171030        hp = ' ';
047300171030        wp = ' ';
047400171030        cp = ' ';
047500171030        nsuf = ' ';
047600171030        email = ' ';
047700171030        marsts = ' ';
047800171030
047900171030        exsr covCXref;
048000171030
048100190318       endsr;
048200090202
048300171030      //===================================================================
048400171030      // dependent
048500171030      //===================================================================
048600171030
048700171030       begsr dependent;
048800171030
048900171030        setll mcssno depenr;
049000171030        reade mcssno depenr;
049100190206        dow not %eof;
049200171030
049300190206         chain (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
049400171030
049500190206         if %found;
049600190206          exsr $dcov;
049700190206         endif;
049800171030
049900190206        reade mcssno depenr;
050000171030        enddo;
050100171030
050200190318       endsr;
050300171030
050400171030      //===================================================================
050500171030      // dependent
050600171030      //===================================================================
050700171030
050800171030       begsr $dcov;
050900171030
051000171026        setgt (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
051100190206        readpe (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
051200190206        dow not %eof;
051300171030
051400171030          if ccandt <> 99999999 and ccandt <> 0;
051500171030           mdseq# = dseq#;
051600171030           candt = ccandt;
051700171030           mcplan = dvplan;
051800171030
051900171030           chain (mcssno:mdseq#:candt:mcplan:mcovtp:mctrst:mcsub#:acc#) advtrmp;
052000171030           if %found(ADVTRMP);
052100171030            leavesr;
052200171030           else;
052300190206            clear termFile;
052400171031             assno = mcssno;
052500171031              adepno = dseq#;
052600171031               aplan = dvplan;
052700171031                acovtyp = mcovtp;
052800171031                 atrst = dvtrst;
052900171031                 asub# = dvsub#;
053000171031                aacct = acc#;
053100171031               atrmpdt = today;
053200171031              atermdt = ccandt;
053300190206             //write termFile;
053400171030            exsr writedepExp;
053500171030           endif;
053600171030
053700171030          else;
053800171030           exsr writedepExp;
053900171030           leavesr;
054000171030          endif;
054100171030
054200190206        readpe (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
054300171030        enddo;
054400171030
054500171030       endsr;
054600171030
054700171030      //===================================================================
054800171030      // write dep
054900171030      //===================================================================
055000171030
055100171030       begsr writedepExp;
055200171030
055300190206        memssn = %editc(mcssno:'X');
055400190206        depssn = %editc(depss#:'X');
055500190206        cssno = %editc(mcssno:'X');
055600190206        tssno = %editc(depss#:'X');
055700190206        subsid = 'N';
055800190206
055900171030        lname = dlname;
056000171030        fname = dfname;
056100171030        mi = dmi;
056200171030        gender = dsex;
056300171030        ssno = depss#;
056400171030
056500190206        // effdt = %dec( %char( %date(denrdt : *iso) : *usa0) : 8 : 0);
056600190206        dob = dbirth;
056700190206        effdt = denrdt;
056800171030
056900171030        if ccandt = 0;
057000190206         expdt = 99991231;
057100171030        else;
057200171030         candtp = %editc(ccandt:'X');
057300171030          lastday(candtp : lastdate : error);
057400171031          lastdaten = %dec(lastdate:8:0);
057500190206         expdt = lastDateN;
057600171030        endif;
057700171030
057800171030        if denrdt = ccandt;
057900171030         expdt = denrdt;
058000171030        endif;
058100171030
058200171030        if ccandt = 0;
058300171030
058400171030         if denrdt = ccandt;
058500171030          expdt = denrdt;
058600171030         endif;
058700171030
058800171030        endif;
058900171030
059000171030        select;
059100171030         when drelcd = 'RWI';
059200171030          prel = '01 ';
059300171030
059400171030         when drelcd = 'RHU';
059500171030          prel = '01 ';
059600171030
059700171030         when drelcd = 'RDA';
059800171030          prel = '19 ';
059900171030
060000171030         when drelcd = 'RSO';
060100171030          prel = '19 ';
060200171030
060300171030         other;
060400171030          prel = '53 ';
060500171030        endsl;
060600171030
060700190206        exsr writeRcd;
060800171030
060900171030       endSr;
061000171030
061100190205      //===================================================================
061200190205      // Check acct
061300190205      //===================================================================
061400190205
061500190205       begsr checkAcct;
061600190205
061700190318        ok_toTransmit = 'Y';
061800190205
061900190205        chain (mctrst : mcsub# : acc#) avofr;
062000190205        if %found;
062100190318         ok_toTransmit = 'N';
062200190205         leavesr;
062300190205        endif;
062400190205
062500190205       endsr;
062600190205
062700171030      //===================================================================
062800171030      // coverage Xref
062900171030      //===================================================================
063000171030
063100171030       begsr covCxref;
063200171030
063300171030        tier = ' ';
063400150819
063500171030        // Use xRef file to translate to codes...
063600171030        chain(n) (mctrst : mcsub# : mcplan :acc#) xrefFile;
063700171030        if not %found;
063800171030         xref (mctrst : mcsub# : acc# : mcplan);
063900171030        endif;
064000161024
064100171030        setll (mctrst : mcsub# : mcplan :acc#) xrefFile;
064200171030        reade (mctrst : mcsub# : mcplan :acc#) xrefFile;
064300150820
064400171030        dow not %eof;
064500150820
064600171030         if mcovtp = advcode1a;
064700171030          tier = advcode1b;
064800171030          leave;
064900171030         endif;
065000150820
065100171030        reade (mctrst : mcsub# : mcplan :acc#) xrefFile;
065200171030        enddo;
065300150820
065400190318       endsr;
065500150820
065600171026      //===================================================================
065700190205      // get group
065800171026      //===================================================================
065900171026
066000190318       begsr getGroup;
066100171026
066200171026        setll (mctrst : mcsub# : mcplan : mcageb : mcovtp) grate;
066300171026        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grate;
066400171026
066500171026        dow not %eof;
066600171026         if (enrldt >= frmdat) and (candt <= todat);
066700171026          leavesr;
066800171026         endif;
066900171026
067000171026        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grate;
067100171026        enddo;
067200171026
067300190318       endsr;
067400171026
067500190205      //===================================================================
067600190205      // get name
067700190205      //===================================================================
067800190205
067900190205        begsr getName;
068000190205
068100190205         chain (mbtrst : mbsub# : mbacct) acctFile;
068200190205         if %found;
068300190205          groupnam = acnam1;
068400190205         endif;
068500190205
068600190206         chain (mbtrst : mbsub# : mbacct) acct2File;
068700190206         if %found;
068800190206          dein = %editc(a2tax_id#:'X');
068900190206         endif;
069000190206
069100190205       endsr;
069200190205
069300171026      //===================================================================
069400171026      // exit
069500171026      //===================================================================
069600171026
069700171026       begsr exit;
069800171026
069900171026        *inlr = '1';
070000171026        return;
070100171026
070200171026       endsr;
070300171026
070400171026      //===================================================================
070500171026      // init
070600171026      //===================================================================
070700171026
070800171026       begsr init;
070900190318
071000171026        today = %dec(%date);
071100190318        advantica = 'ADV';
071101190318
071200171026       endsr;
071300171026
071400171026      //===================================================================
