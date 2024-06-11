000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400180622      * Transmission off - Do not send to carrier
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700180326      * ---------    ---  -----------------------------------------------------
000800190401      * 03/15/2019   jt   Original Creation
000900190401      * 04/01/2019   jt   Added logic to have a "position to"
001000180326      *========================================================================
001100100520
001200190228     Facaexd    cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001300100520     F                                     SFile(SFL1 : RRN)
001400180320
001500190305     Facaauditaruf a e           k disk    rename(aauditar:auditFileP)
001600190305
001700190228     Facaauditaluf a e           k disk    rename(aauditar:auditFile)
001800180322
001900190228     Facarptexc uf a e           k disk    rename(acarptr:exFile)
002000190228
002100190305     Facarptexlfuf a e           k disk    rename(acarptr:exlFile)
002200190305
002300190401     Facarptexlguf a e           k disk    rename(acarptr:exlFileg)
002400190401
002500190401     Fmember    if   e           k disk    extfile('F.MEMBER')
002600190401     F                                     rename(membr:memberFile)
002700190401
002800190401     Fplnmst    if   e           k disk    extfile('F.PLNMST')
002900190401     F                                     rename(plnmsr:planFile)
003000190401
003100170829      *=========================================================================
003200170829
003300170907     d psds           sds
003400190401     d proc_name         *proc
003500180404     d user                  254    263
003600170907
003700170829     d rrn             s              5i 0
003800190305     d daten           s              8  0
003900180404     d trstk           s              3  0
004000180404     d sub#k           s              3  0
004100180404     d acctk           s              4  0
004200180410     d valid           s              1
004300180629     d carrier         s              2  0
004400180705     d option          s              1
004500180710     d history         s              1
004600180912     d trstz           s              3s 0
004700180912     d sub#z           s              3s 0
004800190228     d acctz           s              4s 0
004900190401     d postrust        s              3  0
005000190401     d possub#         s              3  0
005100190401     d posacct         s              4  0
005200190228     d socsec#         s              9s 0
005300190228     d ssn1            s              3
005400190228     d ssn2            s              2
005500190228     d ssn3            s              4
005600190228     d trstc           s              3
005700190228     d sub#c           s              3
005800190228     d acctc           s              4
005900190228     d ssnc            s              9
006000190228     d ssndash         s             11
006100190305     d ssndash2        s             12
006200190401     d ssnd3           s              3
006300190401     d ssnd2           s              2
006400190401     d ssnd4           s              4
006500190305     d loadRcd         s              1
006600190305     d userName        s            100
006700190401     d pos             s              1
006800190401     d pos2            s              2
006900190228
007000190228     d ssn#            ds             9
007100190228     d  ssn1d                         3  0
007200190228     d  ssn2d                         2  0
007300190228     d  ssn3d                         4  0
007400190228
007500190228     d* acaexr          pi
007600190228     d*  intype                        2  0 const
007700190228
007800190305     d showMem         pr                  ExtPgm('INQ002R')
007900190228     d  socsec#                       9s 0 const
008000180912
008100190305     d getUser         pr                  ExtPgm('TROFFPR')
008200190305     d  oUser                        10    const
008300190305     d  userName                    100    const
008400190305
008500190305     d showAcct        pr                  ExtPgm('INQ008R')
008600190305     d  trstz                         3s 0 const
008700190305     d  sub#z                         3s 0 const
008800190305     d  acctz                         4s 0 const
008900190305
009000190305        dcl-s numbersonly varchar(50);
009100190305        dcl-c nuffink const('                           ');
009200190305        dcl-c gubbins const('-');
009300190305
009400170829      //========================================================================
009500190228      // mainline
009600180320      //========================================================================
009700170829
009800170829       exsr init;
009900170829       exsr main;
010000170829       exsr exit;
010100170829
010200170829      //========================================================================
010300170829      // main
010400170829      //========================================================================
010500170829
010600170829       begsr main;
010700170829
010800170829        dow btnEXIT = '0';
010900100520
011000180326         // Clear the subfile...
011100170829         sflclr = '1';
011200170829
011300170829         write sflctl1;
011400170829         sflclr = '0';
011500170829         rrn = 0;
011600100520
011700170829         // Load the subfile...
011800170831         exsr loadSubfile;
011900100520
012000170829         // Display the subfile.
012100170829         sfldsp = '1';
012200170829         exfmt sflctl1;
012300180323
012400170829         sfldsp = '1';
012500170829
012600180326        // Check for icon click.
012700170829        readc sfl1;
012800170829        if not %eof;
012900170829
013000190228         if sexclude ='Y';
013100190305          exsr addReason;
013200190305           sexclude = ' ';
013300190326
013400190305            if btnUpdRcd = '1' and sreason> ' ';
013500190305             exsr add_toExclude;
013600190305            endif;
013700190305
013800180622         endif;
013900180622
014000190305         if sdisplay ='1';
014100190305          exsr dspRecord;
014200190305          sdisplay = '0';
014300190305         endif;
014400190305
014500190228         if selssn = '1';
014600190305          exsr showMember;
014700190228          selssn = ' ';
014800190228         endif;
014900190305
015000190305         if seltsa = '1';
015100190305          exsr showAccount;
015200190305          seltsa = ' ';
015300190305         endif;
015400180913
015500170829        endif;
015600190305
015700170829       enddo;
015800170829
015900170829       endsr;
016000170829
016100170831      //========================================================================
016200170831      // load subfile
016300170831      //========================================================================
016400170831
016500170831       begsr loadSubfile;
016600190401
016700190401        if showgroup = 'shownonexc';
016800190305
016900190305        if posto = 'posssn';
017000190305         if ssnPos > ' ';
017100190305           evalr ssndash2 = %triml(ssnpos:'0');
017200190305           setll (ssndash2) auditFile;
017300190305          ssnPos = ' ';
017400190305         else;
017500190305          setll *loval auditFile;
017600190305         endif;
017700190305        endif;
017800180409
017900190305        if posto = 'posacct';
018000190305         if ssnPos > ' ';
018100190305          setll (ssnpos) auditFileP;
018200190305          ssnPos = ' ';
018300190305         else;
018400190305          setll *loval auditFileP;
018500190305         endif;
018600190305        endif;
018700190305
018800190305        if posto = 'posssn';
018900190305         read auditFile;
019000190305        endif;
019100190305        if posto = 'posacct';
019200190305         read auditFileP;
019300190305        endif;
019400180320
019500180409        dow not %eof;
019600190228
019700190305         exsr displayWhat;
019800190305         if loadRcd = 'Y';
019900190305           rrn += 1;
020000190305            exsr moveFields;
020100190305           write sfl1;
020200190305          endif;
020300180322
020400190305        if posto = 'posssn';
020500190305         read auditFile;
020600190305        endif;
020700190305        if posto = 'posacct';
020800190305         read auditFileP;
020900190305        endif;
021000190305
021100180320        enddo;
021200170831
021300190305        ssnPos = ' ';
021400190401        endif;
021500180404
021600190401        //-------------------------------
021700190401
021800190401        if showgroup = 'showexc';
021900190401
022000190401        if posto = 'posssn';
022100190401         if ssnPos > ' ';
022200190401          ssn1d = %dec(%subst(ssnPos:1:3):3:0);
022300190401          ssn2d = %dec(%subst(ssnPos:5:2):2:0);
022400190401          ssn3d = %dec(%subst(ssnPos:8:4):4:0);
022500190401          socsec# = %dec(ssn#:9:0);
022600190401            setll (socsec#) exlFile;
022700190401           ssnPos = ' ';
022800190401         else;
022900190401           setll *loval exlFile;
023000190401         endif;
023100190401        endif;
023200190401
023300190401        if posto = 'posacct';
023400190401         if ssnPos > ' ';
023500190401          exsr removeDashes2;
023600190401          setll (postrust : possub# : posacct) exlFileg;
023700190401          ssnPos = ' ';
023800190401         else;
023900190401          setll *loval exlFileg;
024000190401         endif;
024100190401        endif;
024200190401
024300190401        if posto = 'posssn';
024400190401         read exlFile;
024500190401        endif;
024600190401        if posto = 'posacct';
024700190401         read exlFileg;
024800190401        endif;
024900190401
025000190401        dow not %eof;
025100190401
025200190401         exsr displayWhat;
025300190401         if loadRcd = 'Y';
025400190401           rrn += 1;
025500190401            exsr moveFields2;
025600190401           write sfl1;
025700190401          endif;
025800190401
025900190401        if posto = 'posssn';
026000190401         read exlFile;
026100190401        endif;
026200190401        if posto = 'posacct';
026300190401         read exlFileg;
026400190401        endif;
026500190401
026600190401        enddo;
026700190401
026800190401        ssnPos = ' ';
026900190401        endif;
027000170831       endsr;
027100170831
027200190228      //========================================================================
027300190305      // show member
027400190228      //========================================================================
027500190228
027600190305       begsr showMember;
027700190228
027800190228        ssn1d = %dec(%subst(sssn:1:3):3:0);
027900190228        ssn2d = %dec(%subst(sssn:5:2):2:0);
028000190228        ssn3d = %dec(%subst(sssn:8:4):4:0);
028100190228        socsec# = %dec(ssn#:9:0);
028200190228
028300190305        showMem(socsec#);
028400190228
028500190228       endsr;
028600190228
028700190305      //========================================================================
028800190305      // show account
028900190305      //========================================================================
029000190305
029100190305       begsr showAccount;
029200190305
029300190305       trstz= htrst;
029400190305       sub#z= hsub#;
029500190305       acctz= hacct;
029600190305
029700190305        showAcct(trstz : sub#z: acctz);
029800190305
029900190305        seltsa = ' ';
030000190305
030100190305       endsr;
030200190305
030300190305      //========================================================================
030400190305      // display records
030500190305      //========================================================================
030600190305
030700190305       begsr displayWhat;
030800190305
030900190305        loadRcd = 'N';
031000190305        rowColor = '';
031100190305        sbox = '1';
031200190305        sview = '0';
031300190305
031400190305        if showgroup = 'shownonexc';
031500190305         if a1arcf = ' ';
031600190305          loadRcd = 'Y';
031700190305         endif;
031800190305        endif;
031900190305
032000190305        if showgroup = 'showexc';
032100190401         if acachkoff = 'Y';
032200190305           sbox = '0';
032300190305            sview = '1';
032400190305           rowColor = ' ';
032500190305          loadRcd = 'Y';
032600190305         endif;
032700190305        endif;
032800190305
032900190401        //if showgroup = 'showall';
033000190401        // if a1arcf = 'Y';
033100190401        //  rowColor = '#FF9999';
033200190401        //   sbox = '0';
033300190401        //   sview = '1';
033400190401        //  endif;
033500190401        // loadRcd = 'Y';
033600190401        //endif;
033700190401
033800190305       endsr;
033900190305
034000190305      //========================================================================
034100180322      // move fields
034200180322      //========================================================================
034300180322
034400180322       begsr moveFields;
034500180322
034600190228        sexclude = 'N';
034700190305        sdisplay = '0';
034800190228        sname = a1nam;
034900190228        sssn = a1ssn;
035000190401        pos = %subst(sssn:1:1);
035100190401        if pos = ' ';
035200190401         sssn = %replace('0': sssn);
035300190401        endif;
035400190401
035500190401        pos2 = %subst(sssn:1:2);
035600190401        if pos2 = '0 ';
035700190401         sssn = %replace('00': sssn);
035800190401        endif;
035900190401
036000190228        splan = a1pln;
036100190228        sdesc = a1plnd;
036200190228        sacct = a1act;
036300190305        htrst = %dec(%subst(a1act:1:3):3:0);
036400190305        hsub# = %dec(%subst(a1act:5:3):3:0);
036500190305        hacct = %dec(%subst(a1act:9:4):4:0);
036600190228        spremium = a1prem;
036700190228        smamount = a1manamt;
036800190228        seffdate = a1eff;
036900190401        scovdate = a1cdt;
037000190228        sseq# = a1seq;
037100190305        sdname = a1dnm;
037200190305        sdreason = a1errd;
037300180703
037400180322       endsr;
037500180322
037600190401      //========================================================================
037700190401      // move fields
037800190401      //========================================================================
037900190401
038000190401       begsr moveFields2;
038100190401
038200190401        sexclude = 'N';
038300190401        sdisplay = '0';
038400190401        chain (acassn) memberFile;
038500190401        sname = %trim(mlname) + ',' + %trim(mfname) + ' ' + %trim(mmi);
038600190401
038700190401        ssnc = %editc(acassn:'X');
038800190401        ssnd3 = %subst(ssnc:1:3);
038900190401        ssnd2 = %subst(ssnc:4:2);
039000190401        ssnd4 = %subst(ssnc:6:4);
039100190401
039200190401        sssn = %trim(ssnd3) + %trim('-') + %trim(ssnd2) + %trim('-') +
039300190401               %trim(ssnd4);
039400190401        splan = acaplan;
039500190401        sacct = %editc(acatrust:'X') + %trim('-') + %editc(acasub#:'X') +
039600190401                %trim('-') + %editc(acaacct:'X');
039700190401
039800190401        chain (acatrust : acasub# : acaplan) planFile;
039900190401        sdesc = pdescr;
040000190401        htrst = acatrust;
040100190401        hsub# = acasub#;
040200190401        hacct = acaacct;
040300190401        spremium = acapremium;
040400190401         seffdate = %char( %date(acainvdate : *iso) : *usa);
040500190401        sseq# = %char(acadepseq#);
040600190401        //sdname = a1dnm;
040700190401        //sdreason = a1errd;
040800190401
040900190401        smamount = 0;
041000190401        scovdate = ' ';
041100190401        chain (sssn:sseq#:splan:spremium:seffdate) auditFile;
041200190401        if %found;
041300190401         smamount = a1manamt;
041400190401         scovdate = a1cdt;
041500190401        endif;
041600190401
041700190401       endsr;
041800190401
041900180410      //========================================================================
042000180410      // checkButton
042100180410      //========================================================================
042200180410
042300180410       begsr checkButton;
042400180410
042500190228        if sexclude = 'Y';
042600190305         exsr addReason;
042700190305
042800190305          if btnUpdRcd = '1';
042900190305           exsr add_toExclude;
043000190305          endif;
043100190305
043200180410        endif;
043300180410
043400180410       endsr;
043500180410
043600190305      //========================================================================
043700190305      // add reason
043800190305      //========================================================================
043900190305
044000190305       begsr addReason;
044100190305
044200190305        btnUpdRcd = '0';
044300190305        btnExtEdt = '0';
044400190305        sreason = ' ';
044500190305        errReason = '0';
044600190305
044700190305        dname = sdname;
044800190305        dow btnUpdRcd = '0';
044900190305
045000190305         exfmt maintdtl;
045100190305
045200190305         if sreason > ' ' and btnUpdRcd = '1';
045300190305          leavesr;
045400190305         endif;
045500190305
045600190305         if sreason = ' ' and btnUpdRcd = '1';
045700190305          btnUpdRcd = '0';
045800190305          errReason = '1';
045900190305         endif;
046000190305
046100190305         if btnExtEdt = '1';
046200190305          btnUpdRcd = '1';
046300190305          leavesr;
046400190305         endif;
046500190305
046600190305        enddo;
046700190305
046800190305       endsr;
046900190305
047000170829      //========================================================================
047100190228      // add to exlude file
047200180410      //========================================================================
047300180410
047400190228       begsr add_toExclude;
047500190326
047600190326        exsr removeDashes;
047700190326        chain (socsec#:%dec(sseq#:2:0):splan:spremium:daten) exlFile;
047800190326        if not %found;
047900180410
048000190326         acainvdate = %dec( %char( %date(seffdate : *usa) : *iso0) : 8 : 0);
048100190326         ssn1d = %dec(%subst(sssn:1:3):3:0);
048200190326         ssn2d = %dec(%subst(sssn:5:2):2:0);
048300190326         ssn3d = %dec(%subst(sssn:8:4):4:0);
048400190326         acassn = %dec(ssn#:9:0);
048500190228
048600190326         acaplan = splan;
048700190326         acachkoff = 'Y';
048800190326         acadepseq# = %dec(sseq#:2:0);
048900190228
049000190326         acatrust = %dec(%subst(a1act:1:3):3:0);
049100190326         acasub# = %dec(%subst(a1act:5:3):3:0);
049200190326         acaacct = %dec(%subst(a1act:9:4):4:0);
049300190326
049400190326         acapremium = spremium;
049500190326         acareason = sreason;
049600190326
049700190326         acacuser = user;
049800190326         acactime = %time();
049900190326         acacdate = %date();
050000190326
050100190326         acaeuser = user;
050200190326         acaetime = %time();
050300190326         acaedate = %date();
050400190326
050500190326         write exfile;
050600190326        else;
050700190326         acachkoff = 'Y';
050800190326         update exlFile;
050900190326        endif;
051000190326
051100190401        pos = %subst(sssn:1:1);
051200190401        if pos = '0';
051300190401         sssn = %replace(' ': sssn);
051400190401        endif;
051500190401
051600190401        pos2 = %subst(sssn:1:2);
051700190401        if pos2 = ' 0';
051800190401         sssn = %replace('  ': sssn);
051900190401        endif;
052000190401
052100190401        chain (sssn:sseq#:splan:spremium:seffdate) auditFile;
052200190228        a1arcf = 'Y';
052300190228        update auditfile;
052400190228
052500180410       endsr;
052600180410
052700190305      //========================================================================
052800190305      // display record
052900190305      //========================================================================
053000190305
053100190305       begsr dspRecord;
053200190305
053300190305        btnExtDsp = '0';
053400190305        btnUnexRcd = '0';
053500190305
053600190305        exsr removeDashes;
053700190305        chain (socsec# : %dec(sseq#:2:0) : splan : spremium : daten) exlFile;
053800190305        if %found;
053900190305         sreason = acareason;
054000190305          sdate = %char(acacdate);
054100190326
054200190326           suser = 'INIT LOAD';
054300190326           if acacuser <> 'INIT LOAD';
054400190326            getUser(acacuser : userName);
054500190326            suser = userName;
054600190326           endif;
054700190326
054800190305        endif;
054900190305
055000190305        dow btnExtDsp = '0';
055100190305
055200190305         exfmt dspdtl;
055300190305
055400190305         if btnExtDsp = '1';
055500190305          btnExtDsp = '0';
055600190305          leavesr;
055700190305         endif;
055800190305
055900190305         if btnUnexRcd = '1';
056000190305          btnExtDsp = '0';
056100190305           btnUnexRcd = '0';
056200190401           pos = %subst(sssn:1:1);
056300190401           if pos = '0';
056400190401            sssn = %replace(' ': sssn);
056500190401           endif;
056600190401
056700190401           pos2 = %subst(sssn:1:2);
056800190401           if pos2 = ' 0';
056900190401            sssn = %replace('  ': sssn);
057000190401           endif;
057100190401            chain (sssn:sseq#:splan:spremium:seffdate) auditFile;
057200190305            a1arcf = ' ';
057300190305             update auditFile;
057400190305            chain (socsec#:%dec(sseq#:2:0):splan:spremium:daten) exlFile;
057500190401            if %found;
057600190401             delete exlFile;
057700190401            endif;
057800190305          leavesr;
057900190305         endif;
058000190305
058100190305        enddo;
058200190305
058300190305       endsr;
058400190305
058500190305      //========================================================================
058600190401      // remove dashes
058700190305      //========================================================================
058800190305
058900190305       begsr removeDashes;
059000190305
059100190305        numbersonly = sssn;
059200190305        numbersonly = %xlate(gubbins:nuffink:numbersonly);
059300190305        daten = %dec( %char( %date(seffdate : *usa) : *iso0) : 8 : 0);
059400190305
059500190305        dow %scan(' ': %trimr(numbersonly)) > 0;
059600190305         numbersonly =
059700190305          %replace('':numbersonly:%scan(' ':%trimr(numbersonly)):1);
059800190305          socsec# = %dec(numbersonly:9:0);
059900190305        enddo;
060000190305
060100190305       endsr;
060200190305
060300190401      //========================================================================
060400190401      // remove dashes 2
060500190401      //========================================================================
060600190401
060700190401       begsr removeDashes2;
060800190401
060900190401         postrust = %dec(%subst(ssnPos:1:3):3:0);
061000190401         possub# = %dec(%subst(ssnPos:5:3):3:0);
061100190401         posacct = %dec(%subst(ssnPos:9:4):4:0);
061200190401
061300190401
061400190401       endsr;
061500190401
061600180622      //========================================================================
061700170829      // exit
061800170829      //========================================================================
061900170829
062000170829       begsr exit;
062100170829
062200170829        *inlr = '1';
062300170829        return;
062400100520
062500170829       endsr;
062600170829
062700170829      //========================================================================
062800170829      // init
062900170829      //========================================================================
063000170829
063100170829       begsr init;
063200170829
063300170829        btnREFRESH = '0';
063400170829        btnEXIT = '0';
063500180622        btnUpdRcd = '0';
063600170831        buttonEdit = '0';
063700180404        buttonAdd = '0';
063800180622
063900180622        sfldsp = '0';
064000180622        sflclr = '0';
064100180622
064200170913        pgmname = proc_name;
064300180322
064400190228        //carrier = intype;
064500180706
064600190305        title = 'Error File to Exclude';
064700180710        history = 'Y';
064800190305        showgroup = 'shownonexc';
064900190305        posto = 'posssn';
065000170829       endsr;
065100170829
065200170829      //========================================================================
