000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400200902      * PRI932R - Principal Mapping drill down
000500201009      *=========================================================================
000600180326      * Date         Int  Description
000700200902      * ----------   ---  ------------------------------------------------------
000800200902      * 09/02/2020   jt   Original Creation
000801201009      * 10/09/2020   jt   Added display of transmittn only on DSPF.
000802201116      * 11/16/2020   jt   Added Class ID flag.
000803210114      * 01/14/2021   jt   Made sure that no Dairy/Hist record is writen when it
000804210216      *                   changes from number to number on field castatus.
000805210216      * 02/16/2021   jt   Added letters (A-H) for testing.
000806210217      * 02/17/2021   jt   Moved class ID at the plan level.
000807210218      * 02/18/2021   jt   Added ability for user to transmit test files.
000808210308      * 03/08/2021   jt   Unlocked file in entry.
000900191209      *=========================================================================
001000100520
001100210217     Fpri932d   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001200100520     F                                     SFile(SFL1 : RRN)
001300180320
001400180410     Ftrsmst    if   e           k disk    ExtFile('F.TRSMST')
001500180410     F                                     rename(trsmsr:trustFile)
001600180410
001700180410     Fsubml1    if   e           k disk    ExtFile('F.SUBML1')
001800180410     F                                     rename(submsr:subFile)
001900180906
002000180906     Faccmst    if   e           k disk    ExtFile('F.ACCMST')
002100180906     F                                     rename(accmsr:acctFile)
002200180906
002300180906     Fcaraccp   uf a e           k disk    rename(caraccr:setupFile)
002400180906
002500200630     fcarplnq   if a e           k disk    rename(carplnr:setup2File)
002600180410
002700180906     fplnmst    if   e           k disk    extfile('F.PLNMST')
002800180906     f                                     rename(plnmsr:planFile)
002900180322
002901200630     fgrate     if   e           k disk    extfile('F.GRATE')
002902200630     f                                     rename(grater:rateFile)
002903200630
002904200630     fplnauxl   if   e           k disk    rename(plnauxr:auxFile)
002905200630
003000181106     Fhist      if a e           k disk    ExtFile('F.HIST')
003100181106     F                                     rename(histr:histFile)
003200181106
003300181106     Fdiaryhd0  if a e           k disk    ExtFile('F.DIARYHD0')
003400181106     F                                     rename(rdiaryhd:diaryFile)
003500181106
003600170829      *=========================================================================
003700170829
003800170907     d psds           sds
003900170907     d proc_name         *proc
004000180404     d user                  254    263
004100170907
004200170829     d rrn             s              5i 0
004400180404     d trstk           s              3  0
004500180404     d sub#k           s              3  0
004600180404     d acctk           s              4  0
004700180410     d valid           s              1
004800180705     d option          s              1
004900180910     d incarrier       s              2  0
005000180906     d unique          s             10
005300181022     d trstz           s              3s 0
005400181022     d sub#z           s              3s 0
005500181022     d acctz           s              4s 0
005600190320     d subject         s             27
005601200224     d trst            s              3
005602200224     d sub             s              3
005603200224     d acct            s              4
005604210114     d holdTransmit    s              1
005605210114     d holdSTransmit   s              1
005606210114     d holdHist        s              1
005607210218     d userProfile     s             10
005608210218     d rtn             s              1
005609210218     d func            s             20
005610210218     d dsperrMsg       s              1
005611210218     d continue        s              1
005612210218     d selNumberC      s              1
005613210218     d records         s              4
005614210218     d newRecord       s              1
005700180322
005800181022     d showAcct        pr                  ExtPgm('INQ008R')
005900181022     d  trstz                         3s 0 const
006000181022     d  sub#z                         3s 0 const
006100181022     d  acctz                         4s 0 const
006200181022
006300200902     d plans           pr                  ExtPgm('PRI933R')
006400180907     d  htrst                         3  0 const
006500180907     d  hsub#                         3  0 const
006600180907     d  hacct                         4  0 const
006700180906
006800180910     d dltadd          pr                  ExtPgm('TROFF3')
006900180910     d  catrst                        3  0
007000180910     d  casub#                        3  0
007100180910     d  caacct                        4  0
007200180910     d  incarrier                     2  0
007300180910     d  option                        1
007301210217
007302210218     d principalTest   pr                  ExtPgm('PRI010CTX')
007303210217     d  selNumberC                    1    const
007304210217     d  records                       4    const
007305210217
007306210218     d transmitPri     pr                  ExtPgm('FT_044C2')
007307210218
007308210218     d getClass        pr                  ExtPgm('GETCLASS')
007309210218     d  userProfile                  10
007310210218     d  rtn                           1
007311210218
007312210218     d chkAuth         pr                  ExtPgm('CHKFNCAUTH')
007313210218     d  program                      10    const
007314210218     d  func                         20    const
007315210218     d  dsperrMsg                     1    const
007316210218     d  continue                      1    const
007400180910
007401200224      //========================================================================
007402200224      // includes
007403200224      //========================================================================
007404200224
007405200224      /include GBSPGM/QMODSRC,#GettokPR
007406200224      /include GBSPGM/QMODSRC,#zFillpr
007407200224
007500170829      //========================================================================
007600180320      // mainline
007700180320      //========================================================================
007800170829
007900170829       exsr init;
008000170829       exsr main;
008100170829       exsr exit;
008200170829
008300170829      //========================================================================
008400170829      // main
008500170829      //========================================================================
008600170829
008700170829       begsr main;
008800170829
008900170829        dow btnEXIT = '0';
009000100520
009100180326         // Clear the subfile...
009200170829         sflclr = '1';
009300170829
009400170829         write sflctl1;
009500170829         sflclr = '0';
009600170829         rrn = 0;
009700100520
009800170829         // Load the subfile...
009900170831         exsr loadSubfile;
010000100520
010100170829         // Display the subfile.
010200170829         sfldsp = '1';
010300170829         exfmt sflctl1;
010400180323
010500170831         exsr checkButton;
010600170829
010700170829         sfldsp = '1';
010800170829
010900180326        // Check for icon click.
011000170829        readc sfl1;
011100170829        if not %eof;
011200170829
011300170829         //Lock record for update, if in change mode.
011400170830         if buttonEdit ='1';
011500180622          exsr editRecord;
011600170829         endif;
011700170829
011800180906         if buttonPlan ='1';
011900181022          exsr planRcd;
012000180622         endif;
012100180622
012200181022         if seltsa = '1';
012300181022          exsr showAccount;
012400181022         endif;
012500181022
012501210308         if runOption = 'mnFailed' or runOption = 'mnClear';
012502210308          exsr changeStage;
012503210308          runOption = ' ';
012504210308         endif;
012505210308
012600170829        endif;
012700170829       enddo;
012800170829
012900170829       endsr;
013000170829
013100170831      //========================================================================
013200170831      // load subfile
013300170831      //========================================================================
013400170831
013500170831       begsr loadSubfile;
013600170831
013700200224        if s1ActNbr > ' ';
013701200224         split();
013702200224         trstk = %dec(trst:3:0);
013703200224         sub#k = %dec(sub:3:0);
013704200224         acctk = %dec(acct:4:0);
013705200224        endif;
013706200224
014300200224        if s1ActNbr > ' ';
014301200122         setll (unique: trstk : sub#k : acctk) setupFile;
014302200122        else;
014303200122         setll (unique) setupFile;
014305200122        endif;
014306200122
014400210308        reade(n) unique setupFile;
014500180320
015302201009        dow not %eof;
015303201009         if transmitCk  = 'Y';
015304201009          if castatus = 'Y';
015305201009           rrn += 1;
015306201009            exsr moveFields;
015307201009           write sfl1;
015308201009          endif;
015309201009         endif;
015310201009
015311201009         if transmitCk  = ' ';
015312201009          rrn += 1;
015313201009           exsr moveFields;
015314201009          write sfl1;
015315201009         endif;
015316201009
015400210308        reade(n) unique setupFile;
015500180320        enddo;
015600170831
015900170831       endsr;
016000170831
016100180322      //========================================================================
016200180322      // move fields
016300180322      //========================================================================
016400180322
016500180322       begsr moveFields;
016600180322
016700180906        htrst = catrst;
016800180906        hsub# = casub#;
016900180906        hacct = caacct;
017000180906        tsa = %editc(catrst:'X') + '-' + %editc(casub#:'X') + '-' +
017100180906              %editc(caacct:'X');
017200180322
017300180322        grnames = ' ';
017400180906        chain (catrst : casub# : caacct) acctFile;
017500180322        if %found;
017600180322         grnames = acnam1;
017700180322        endif;
017800180906
017801200630        if cacid2 = ' ';
017802200630         exsr getGroup;
017803200630         update setupFile;
017804200630        endif;
017807201116
017808201009        sgroup# = %subst(cacid2:1:7);
017810200221
018300180906        transmit = castatus;
018301210308
018303210308        select;
018304210308         when cacida = 'TESTSENT';
018305210308          stage = '#0000ff';
018306210310          boldFont = 'bold';
018307210310          sizeFont = '16px';
018308210308
018309210308         when cacida = 'FAILED';
018310210308          stage = '#ff0000';
018311210310          boldFont = 'bold';
018312210310          sizeFont = '16px';
018313210308
018314210308         other;
018315210308          stage = '#000000';
018316210310          boldFont = 'normal';
018317210310          sizeFont = '12px';
018318210308        endsl;
018319210308
019000180322       endsr;
019100180322
019200180410      //========================================================================
019300180410      // checkButton
019400180410      //========================================================================
019500180410
019600210308       begsr checkButton;
019700180410
019800180410        if buttonEdit = '1';
019900180410         exsr editRecord;
020000180410        endif;
020100180410
020200180410        if buttonAdd  = '1';
020300180410         exsr addRcd;
020400180410        endif;
020401200224
020500200224        if btnRefresh  = '1';
020502200224         s1ActNbr = ' ';
020503200224         btnRefresh = '0';
020504200224        endif;
020505200224
020600210217        if btnTest = '1';
020601210217         exsr send_aTest;
020602210217         btnTest = '0';
020603210217        endif;
020800180622
020900180410       endsr;
021000180410
021100170830      //========================================================================
021200180410      // add record
021300170830      //========================================================================
021400170830
021500180410       begsr addRcd;
021600170831
021700180410        addRecord = '0';
021800180410        btnExtAdd = '0';
021900180622        strst = 0;
022000180622        ssub# = 0;
022100180622        sacct = 0;
022101230113        slocid = ' ';
022500180906        stransmit = ' ';
022600180906        errTrust = '0';
022700180906        errSub = '0';
022800180906        errAcct = '0';
022801210114        stransmit = 'N';
023000180705
023100180410        dow btnExtAdd = '0';
023200180409
023300180410         exfmt adddtl;
023400180410
023500180410         if btnExtAdd = '1';
023600180410          leavesr;
023700180410         endif;
023800180410
023900180410         exsr validAdd;
024000180410
024100180906         if valid  = '1';
024200180906          btnExtAdd = '0';
024300180906         else;
024400180906          btnExtAdd = '1';
024500180906         endif;
024600180409
024700180410        enddo;
024800180409
024900170830       endsr;
025000170830
025100180622      //========================================================================
025200200630      // plan record
025300180622      //========================================================================
025400180622
025500180906       begsr planRcd;
025600180622
025700180907        plans(htrst : hsub# : hacct);
025701200224
025702200224        s1ActNbr = %editc(htrst:'X') + '-' + %editc(hsub#:'X') +
025703200224                   '-' + %editc(hacct:'X');
025800180622
025900180906        buttonPlan = '0';
026000180906
026100180622       endsr;
026200180622
026300170829      //========================================================================
026400170829      // valid record
026500170829      //========================================================================
026600170829
026700180410        begsr validAdd;
026800170830
026900180410         valid = '0';
027000180906         errTrust = '0';
027100180906         errSub = '0';
027101210218         errAcct = '0';
027200210218         errAcct2 = '0';
027201210218         newRecord = 'N';
027400170829
027500180622         chain strst trustFile;
027600180410         if not %found;
027700180906          errTrust = '1';
027800210218           valid = '1';
027801210218          leavesr;
027900180410         endif;
028000170830
028100180410         chain ssub# subFile;
028200180410         if not %found;
028300180906          errSub = '1';
028400210218           valid = '1';
028401210218          leavesr;
028500180410         endif;
028600180410
028700180622         chain (strst : ssub# : sacct) acctFile;
028800180410         if not %found;
028900210218          errAcct = '1';
029000210218           valid = '1';
029001210218          leavesr;
029100180410         endif;
029200180410
029201210218         chain(n) (unique : strst : ssub# : sacct) setupFile;
029202210218         if %found;
029203210218          errAcct2 = '1';
029204210218           valid = '1';
029205210218          leavesr;
029206210218         else;
029207210218          newRecord = 'Y';
029208210218         endif;
029209210218
029800180410         if valid = '0';
029900180410          exsr addRecd;
029901200224          s1ActNbr = %editc(strst:'X') + '-' + %editc(ssub#:'X') +
029902200224                     '-' + %editc(sacct:'X');
030000170830         endif;
030100170906
030200170829        endsr;
030300170829
030400170906      //========================================================================
030500170906      // valid add
030600170906      //========================================================================
030700170906
030800180410        begsr addRecd;
030900170906
031000180906         catrst = strst;
031100180906         casub# = ssub#;
031200180906         caacct = sacct;
031300230113         cacid4 = slocid;
031301230113         castatus = stransmit;
031302201116
031305200630         chain (catrst : casub# : caacct) acctFile;
031306200630         if %found;
031307200630          catxt1 = acnam1;
031308200630         endif;
031309200630
031310200630         exsr getGroup;
031700180410
032000180906         write setupFile;
032001200630
032002210218         exsr add_toTransfile;
032003210218
032200170906        endsr;
032300170830
032301200630      //========================================================================
032302200630      // get group
032303200630      //========================================================================
032304200630
032305200630       begsr getGroup;
032306200630
032333200630        setll (strst : ssub# : sacct) auxFile;
032334200630        reade (strst : ssub# : sacct) auxFile;
032335200630        dow not %eof;
032336200630
032337200630         chain (strst : ssub# : pxplan) planFile;
032338200902         if pcarr = 'PFL' or pcarr = 'PFR' or pcarr = 'PRD' or pcarr = 'PRL'
032339200902           or pcarr = 'PVL';
032340200630
032341200630          chain (strst : ssub# : pxplan) rateFile;
032342200630          if %found;
032343200630           cacid2 = group#;
032344200630           leavesr;
032345200630          endif;
032346200630
032347200630         endif;
032348200630
032349200630        reade (strst : ssub# : sacct) auxFile;
032350200630        enddo;
032351200630
032352200630       endsr;
032353200630
032354200630      //========================================================================
032355200630      // add plans
032356200630      //========================================================================
032357200630
032358200630       begsr addPlans;
032359200630
032360200630        setll (strst : ssub# : sacct) auxFile;
032361200630        reade (strst : ssub# : sacct) auxFile;
032362200630        dow not %eof;
032363200630
032364200630         chain (strst : ssub# : pxplan) planFile;
032365200902         if pcarr = 'PFL' or pcarr = 'PFR' or pcarr = 'PRD' or pcarr = 'PRL'
032366200902           or pcarr = 'PVL';
032367200902
032370200630          chain (unique : strst : ssub# : pxplan : sacct) setup2File;
032371200630          if %found;
032372200630           leavesr;
032373200630          endif;
032374200630
032375200630          chain ('9000000327' : strst : ssub# : pxplan : sacct) setup2File;
032376200630          if not %found;
032377200630           cpuniq = '9000000327';
032378200630           cptrst = strst;
032379200630           cpsub# = ssub#;
032380200630           cpacct = sacct;
032381200630
032382200630           if plncat = 'PHI';
032383200630            cpcctr = 'HIP';
032384200630           endif;
032385200630
032386200630           if plncat = 'PO6';
032387200630            cpcctr = 'VAC';
032388200630           endif;
032389200630
032390200630           cpplan = pxplan;
032391200630
032392200630           chain (strst : ssub# : pxplan) rateFile;
032393200630           if %found;
032394200630            cpcid1 = %subst(group#:1:6);
032395200630            cptxt1 = 'GROUP #';
032396200630           endif;
032397200630
032398200630           cptxt2 = 'PLAN OPTION';
032399200630           cptxt3 = 'GROUP ID';
032400200630           cptxt4 = 'PLAN #';
032401200630           cptxt5 = 'CLASS CODE';
032402200630
032403200630           write setup2File;
032404200630          endif;
032405200630
032406200630         endif;
032407200630
032408200630        reade (strst : ssub# : sacct) auxFile;
032409200630        enddo;
032410200630
032411200630       endsr;
032412200630
032413170829      //========================================================================
032500180410      // edit record
032600180410      //========================================================================
032700180410
032800180410       begsr editRecord;
032900180410
033000180622        btnUpdRcd = '0';
033100180410        btnExtEdt = '0';
033200180906        strst = htrst;
033300180622        ssub# = hsub#;
033400180622        sacct = hacct;
033500181018
033600181018        chain(n) (unique : strst : ssub# : sacct) setupFile;
033601230113        slocid = cacid4;
033700180906        stransmit = transmit;
033701201116
033702210217        //classID = ' ';
033703210217        //if cacid3 = 'Y';
033704210217        // classID = cacid3;
033705210217        //endif;
033706201116
034100180906        errTrust = '0';
034200180906        errSub = '0';
034300180906        errAcct = '0';
034500180410
034600180410        dow btnExtEdt = '0';
034700180410
034800180410         exfmt maintdtl;
034900180410
035000180622         if btnUpdRcd = '1';
035100180622          exsr validEdit;
035200180622         endif;
035300180410
035400180410        enddo;
035500180622
035501200224        s1ActNbr = %editc(htrst:'X') + '-' + %editc(hsub#:'X') +
035502200224                   '-' + %editc(hacct:'X');
035503200224
035600180622        buttonEdit = '0';
035700180410
035800180410       endsr;
035900180410
036000180410      //========================================================================
036100180410      // valid record
036200180410      //========================================================================
036300180410
036400180410        begsr validEdit;
036500180410
036600180410         valid = '0';
036700180906         errTrust = '0';
036800180906         errSub = '0';
036900180906         errAcct = '0';
037100180410
037200180622         chain strst trustFile;
037300180410         if not %found;
037400180906          errTrust = '1';
037500210218           valid = '1';
037501210218          leavesr;
037600180410         endif;
037700180410
037800180410         chain ssub# subFile;
037900180410         if not %found;
038000180906          errSub = '1';
038100210218           valid = '1';
038101210218          leavesr;
038200180410         endif;
038300180410
038400180622         chain (strst : ssub# : sacct) acctFile;
038500180410         if not %found;
038600180906          errAcct = '1';
038700210218           valid = '1';
038701210218          leavesr;
038800180410         endif;
038900180410
039500180410         if valid = '0';
039600180410          exsr edtRecord;
039700180622          btnExtEdt = '1';
039800180410         endif;
039900180410
040000180410        endsr;
040100180410
040200180410      //========================================================================
040300200630      // edit record
040400180410      //========================================================================
040500180410
040600180410        begsr edtRecord;
040700180410
040800180906         chain (unique : htrst : hsub# : hacct) setupFile;
040900180906         catrst = strst;
041000180906         casub# = ssub#;
041100180906         caacct = sacct;
041201201116
041202210114         holdSTransmit = stransmit;
041203210114         holdTransmit = castatus;
041204210114
041205210216         if holdTransmit in %List('1':'2':'3':'4':'5':'6':'7':'8':'9':
041206210217                                  'A':'B':'C':'D':'E':'F':'G':'H':'I':
041207210218                                  'J':'K':'L':'M':'O':'P':'Q':'R':
041208210218                                  'S':'T':'U':'V':'W':'X':'Z');
041209210114          holdTransmit = 'Z';
041210210114         endif;
041211210114
041212210216         if holdStransmit in %List('1':'2':'3':'4':'5':'6':'7':'8':'9':
041213210217                                   'A':'B':'C':'D':'E':'F':'G':'H':'I':
041214210218                                  'J':'K':'L':'M':'O':'P':'Q':'R':
041215210218                                  'S':'T':'U':'V':'W':'X':'Z');
041216210217          holdSTransmit = 'Z';
041218210114         endif;
041219210114
041220230113         cacid4 = slocid;
041221210114         castatus = stransmit;
041222210114
041223210114         holdHist = 'N';
041224210114         if holdTransmit = holdSTransmit;
041225210114          holdHist = 'Y';
041226210114         endif;
041227210114
041700180910         exsr add_toTransfile;
041701210308
041702210308         if castatus = 'Y' or castatus = 'N';
041703210308          cacida = ' ';
041704210308         endif;
041800180910
041900180906         update setupFile;
042000180410
042100180410        endsr;
042200180906
052000180910       //===========================================================================================
052100180910       // Add to Transmission file
052200180910       //===========================================================================================
052300180910
052400180910       begsr add_toTransfile;
052500180910
052600190125        select;
052700190125         when castatus = 'Y';
052800190125          option = 'D';
052900200902          incarrier = 19;
053000210217          dltadd(catrst : casub# : caacct : incarrier : option);
053100180910
053200190125         when castatus = 'N';
053300190125          option = 'A';
053400200902          incarrier = 19;
053500190125          dltadd(catrst : casub# : caacct : incarrier : option);
053600180910
053700190125         other;
053800190125          option = 'X';
053900200902          incarrier = 19;
054000190125          dltadd(catrst : casub# : caacct : incarrier : option);
054100190125        endsl;
054200190125
054300181106        exsr history;
054400181106
054500180910       endsr;
054600180910
054700181022      //========================================================================
054800181022      // show account
054900181022      //========================================================================
055000181022
055100181022       begsr showAccount;
055200181022
055300181022       trstz= htrst;
055400181022       sub#z= hsub#;
055500181022       acctz= hacct;
055600181022
055700181022        showAcct(trstz : sub#z: acctz);
055800181022
055900190125        seltsa = ' ';
056000190125
056100181022       endsr;
056200181022
056300181106      //===========================================================================
056400181106      // history
056500181106      //===========================================================================
056600181106
056700181106       begsr history;
056800181106
056801210114        if holdHist = 'Y';
056802210114         leavesr;
056803210114        endif;
056804210114
056900190125        select;
057000190125         when castatus = 'Y';
057100200902          subject = 'PRI-TRANSMISSION TURNED ON';
057200190125
057300190125         when castatus = 'N';
057400200902          subject = 'PRI-TRANSMISSION TURNED OFF';
057500190125
057600190125         other;
057700200902          subject = 'PRI-TRANSMISSION IN TESTING';
057800190125        endsl;
057801210218
057802210218        if newRecord = 'Y' and castatus = 'N';
057803210218         //if castatus in %list ('A':'B':'C':'D':'E':'F':'G':'H':'I':
057805210218         //                      'J':'K':'L':'M':'O':'P':'Q':'R':
057806210218         //                      'S':'T':'U':'V':'W':'X':'Y':'Z');
057807210218          subject = 'PRI-INITIAL MAPPING CREATED';
057808210218         //endif;
057809210218        endif;
057810210218
058000181106        clear diaryFile;
058100181106        nhkey = %editc(catrst:'X') + %editc(casub#:'X') + %editc(caacct:'X');
058200181106        nhcode = 'WFT';
058300181106        nhaddt = %dec(%date);
058400181106        nhadti = %dec(%time);
058500181106        nhadus = user;
058600190125        nhsubj = subject;
058700181106
058800181106        write diaryFile;
058900181106
059000181106        clear histFile;
059100181106        hkey = %editc(catrst:'X') + %editc(casub#:'X') + %editc(caacct:'X');
059200181106        trcode = 'UHM';
059300181106        hprgnm = proc_name;
059400181106        hstrst = catrst;
059500181106        hssub# = casub#;
059600181106        hsacct = caacct;
059700181106        hsdltd = 'A';
059800181106        trdate = %dec(%date);
059900181106        hstrtime = %time;
060000181106        hoper = user;
060100190125        ck#not = subject;
060200181106
060300181106        write histFile;
060400181106
060500181106       endsr;
060501210218
060600210217      //========================================================================
060601210217      // command line
060602210217      //========================================================================
060603210217
060604210217       begsr send_aTest;
060605210217
060606210217        //command = 'CALL QUSCMDLN';
060607210217        //cmd(%trim(command): %len(%trim(command)));
060608210217
060609210217        records = '0';
060610210217        btnCancel = '0';
060611210218        btnRun = '0';
060612210219        selNumber = ' ';
060613210217
060614210217        dow btnCancel = '0';
060615210217
060618210217         exFmt selWindow;
060619210217
060620210218         if btnCancel = '1';
060621210219          selNumber = ' ';
060622210218           btnCancel = '0';
060623210218          leavesr;
060624210217         endif;
060625210217
060626210218         if btnRun = '1';
060627210217          exsr send_toPrincipal;
060628210218          btnRun = '0';
060629210217
060630210217          if records > '0000';
060631210217           compText = 'File was sent to Principal';
060632210308           exsr changeColor;
060633210217          else;
060634210217           compText = 'No Records sent to Principal' ;
060635210217          endif;
060636210217
060637210217          exfmt msgWindow;
060638210217          btnCancel = '1';
060639210217
060640210217         endif;
060641210217
060642210217        enddo;
060643210217
060644210217       endsr;
060645210217
060646210217      //========================================================================
060647210217      // send a test file
060648210217      //========================================================================
060649210217
060650210217       begsr send_toPrincipal;
060651210217
060652210219        selNumberC = selNumber;
060653210217
060654210218         principalTest(selNumberC : records);
060655210217         if records > '0000';
060656210218          transmitPri();
060657210217         endif;
060658210217
060664210217       endsr;
060665210308
060666210308      //========================================================================
060667210308      // change Status
060668210308      //========================================================================
060669210308
060670210308       begsr changeStage;
060671210308
060673210308         chain (unique : htrst : hsub# : hacct) setupFile;
060674210308         if %found;
060675210308
060676210308          if runOption = 'mnFailed';
060677210308           cacida = 'FAILED';
060678210308          endif;
060679210308
060680210308          if runOption = 'mnClear';
060681210308           cacida = ' ';
060682210308          endif;
060683210308
060684210308          update setupFile;
060685210308         endif;
060686210308
060687210308       endsr;
060688210308
060689210308      //========================================================================
060690210308      // change color
060691210308      //========================================================================
060692210308
060693210308       begsr changeColor;
060694210308
060695210308        setll unique setupFile;
060696210308        reade unique setupFile;
060697210308
060698210308        dow not %eof;
060699210308
060700210308         if castatus = selNumberC;
060701210308          cacida = 'TESTSENT';
060703210308          update setupFile;
060704210308         endif;
060705210308
060706210308        reade unique setupFile;
060707210308        enddo;
060708210308
060709210308       endsr;
060710210308
060800180622      //========================================================================
060900170829      // exit
061000170829      //========================================================================
061100170829
061200170829       begsr exit;
061300170829
061400170829        *inlr = '1';
061500170829        return;
061600100520
061700170829       endsr;
061800170829
061900170829      //========================================================================
062000170829      // init
062100170829      //========================================================================
062200170829
062300170829       begsr init;
062400170829
062500170829        btnREFRESH = '0';
062600170829        btnEXIT = '0';
062700180622        btnUpdRcd = '0';
062800180906        buttonPlan = '0';
062900170831        buttonEdit = '0';
063000180404        buttonAdd = '0';
063100180622
063200180622        sfldsp = '0';
063300180622        sflclr = '0';
063400180622
063500170913        pgmname = proc_name;
063600180706
063700200902        title = 'Principal Account Mapping';
063800180906
063900200902        unique = '0000000329';
063901210218
063902210218        showTest = '0';
063903210218        userProfile = user;
063904210218        getClass(userProfile : rtn);
063905210218        if rtn = 'Y';
063906210218         showTest = '1';
063907210218        endif;
063908210218
063909210218        if rtn = 'N';
063910210218         dspErrMsg = 'N';
063911210219         chkAuth('PRI932R' : func : dsperrMsg : continue);
063912210218         if continue = 'Y';
063913210218          showtest = '1';
063914210218         endif;
063915210218        endif;
064000180710
064100170829       endsr;
064200170829
064201200224      //========================================================================
064202200224      // Split out the account number
064203200224      //========================================================================
064204200224
064205200224       Dcl-Proc Split;
064206200224
064207200224         dcl-s x int(10);
064208200224         dcl-s tokens varchar(100) dim(50);
064209200224
064210200224         tokens(*) = #Gettok( s1ActNbr : '-' : x );
064212200224
064215200224         x = %lookup( '' : tokens ) ;
064216200414         if x = 2;
064217200414           Trst = #zFill( 3 : %Trim( Tokens(1) ));
064218200414           Sub  = '000';
064219200414           Acct = '0000';
064220200414
064221200414           s1ActNbr = trst + '-' + Sub + '-' + Acct;
064222200414         EndIf;
064223200414
064224200414         if x = 3;
064225200414           Trst = #zFill( 3 : %Trim( Tokens(1) ));
064226200414           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
064227200414           Acct = '0000';
064228200414
064229200414           s1ActNbr = trst + '-' + Sub + '-' + Acct;
064230200414         EndIf;
064231200414
064233200224         if x = 4;
064234200224           Trst = #zFill( 3 : %Trim( Tokens(1) ));
064235200224           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
064236200224           Acct = #zFill( 4 : %Trim( Tokens(3) ));
064237200224
064238200224           s1ActNbr = trst + '-' + Sub + '-' + Acct;
064240200224         EndIf;
064241200224
064243200224       End-Proc;
064244200224
064300170829      //========================================================================
