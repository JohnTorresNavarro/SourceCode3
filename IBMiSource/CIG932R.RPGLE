000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400180906      * CIG932R - Cigna Mapping drill down
000500191209      *=========================================================================
000600180326      * Date         Int  Description
000700191209      * ---------    ---  ------------------------------------------------------
000800180906      * 09/06/2018   jt   Original Creation
000801191209      * 12/09/2019   jt   Changed wording in hist/diary note to 'CIG' from 'CIGNA'.
000802200122      * 01/22/2020   jt   Fixed positoning to
000803200221      * 02/21/2020   jt   Added group # to subfile
000804200224      * 03/13/2020   jt   Added new position to feature
000805200414      * 04/14/2020   jt   Fix split subprocedure
000806200707      * 07/07/2020   jt   Recompiled to accomodate larger group # on dspf file.
000807200728      * 07/13/2020   jt   Changed descrition on DSPF from NON-FACETS to PROCALAIM
000808200728      * 07/28/2020   jt   Added check to display transmitting only
000809210114      * 01/14/2021   jt   Made sure that no Dairy/Hist record is writen when it
000810210114      *                   changes from number to number on  field castatus
000811210308      * 03/09/2021   jt   Unlocked file in entry.
000812210317      * 03/17/2021   jt   Marked subfile record in red when account is canceled.
000813210324      * 03/24/2021   jt   Alert user when record is being edited by another user.
000814210401      * 04/01/2021   jt   Aded new field for policy #
000815240122      * 01/23/2024   jt   Added button to let users send test files.
000900191209      *=========================================================================
001000100520
001100180906     Fcig932d   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
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
002301210324     f                                     InfDS(iodbfd)
002400180906
002500180906     fcarplnz   if   e           k disk    rename(carplnr:setup2File)
002600180410
002700180906     fplnmst    if   e           k disk    extfile('F.PLNMST')
002800180906     f                                     rename(plnmsr:planFile)
002900180322
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
004100210322     d jobName               244    253
004101210322     d user                  254    263
004102210322     d jobNumber             264    269
004103210322
004200170829     d rrn             s              5i 0
004400180404     d trstk           s              3  0
004500180404     d sub#k           s              3  0
004600180404     d acctk           s              4  0
004700180410     d valid           s              1
004800180705     d option          s              1
004900180910     d incarrier       s              2  0
005000180906     d unique          s             10
005100180906     d fndFacets       s              1
005200180906     d fnd_nonFacets   s              1
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
005607210322     d recrrn          s             10
005608210322     d returnUser      s             10
005609210322     d return          s              1
005610210322     d userName        s             50
005611240122     d continue        s              1
005612240122     d function        s             20
005613240122     d dspErrMsg       s              1
005614210322
005615210322     d iodbfd        e ds                  extname(iodbfd)
005616210322     d  file                  83     94
005617210322     d  library               93    102
005618210322     d  #rrn                 397    400B 0
005619210322
005620210322     d getLock         pr                  ExtPgm('RCDLCK')
005621210322     d  library                      10    const
005622210322     d  file                         10    const
005623210322     d  recrrn                       10    const
005624210322     d  jobNumber                     5    const
005625210322     d  user                         10    const
005626210322     d  jobName                      10    const
005627210322     d  returnUser                   10    const
005628210322     d  return                        1    const
005629210322
005630210322     d getName         pr                  ExtPgm('GETUSRNAME')
005631210322     d  user                         10    const
005632210322     d  userName                     50    const
005700180322
005800181022     d showAcct        pr                  ExtPgm('INQ008R')
005900181022     d  trstz                         3s 0 const
006000181022     d  sub#z                         3s 0 const
006100181022     d  acctz                         4s 0 const
006200181022
006300180907     d plans           pr                  ExtPgm('CIG933R')
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
007301230120
007302230120     d e1envir         s             15
007303230120     d e1libl          s             10
007304230120     d e1Lib2          s             10
007305230120     d envColor        s             10
007306230120     d e1Acnm          s             40
007307230120
007308230120     d getEnv          pr                  ExtPgm('GETENVR')
007309230120     d  e1envir                      15
007310230120     d  e1libl                       10
007311230120     d  e1Lib2                       10
007312230120     d  envColor                     10
007313230120     d  e1Acnm                       40
007314240119
007315240122     d sendCigna       pr                  ExtPgm('CIGNAX2')
007317240119     d  numopt                        1
007318240122
007319240122     d chkFncAuth      pr                  ExtPgm('CHKFNCAUTH')
007320240122     d  pgmname                      10
007321240122     d  function                     20
007322240122     d  dspErrMsg                     1
007323240122     d  continue                      1
007324240119
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
013707200224        //if tsaPos > 0;
013800200224        // trstk = %dec(%subst(%editc(tsaPos:'X'):1:3):3:0);
013900200224        //  sub#k = %dec(%subst(%editc(tsaPos:'X'):4:3):3:0);
014000200224        // acctk = %dec(%subst(%editc(tsaPos:'X'):7:4):4:0);
014100200224        //endif;
014200180404
014300200224        if s1ActNbr > ' ';
014301200122         setll (unique: trstk : sub#k : acctk) setupFile;
014302200122        else;
014303200122         setll (unique) setupFile;
014305200122        endif;
014306200122
014400210308        reade(n) unique setupFile;
014500180320
014600180409        dow not %eof;
014700200728         if transmitCk  = 'Y';
014701200728          if castatus = 'Y';
014702200728           rrn += 1;
014703200728            exsr moveFields;
014704200728            write sfl1;
014705200728          endif;
014706200728         endif;
014707200728
014900200728         if transmitCk  = ' ';
014901200728          rrn += 1;
014902200728           exsr moveFields;
014903200728          write sfl1;
014904200728         endif;
014905200728
015400210308        reade(n) unique setupFile;
015500180320        enddo;
015600170831
015700200224        //tsaPos = 0;
015800180404
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
017601210317
017602210317         canceled = ' ';
017603210317         if atrmdt > 0;
017604210317          canceled = '#ff0000';
017605210317         endif;
017606210317
017700180322        endif;
017800180906
017810230120        sgroup# = cacid6;
017811230120        if sgroup# = ' ';
017812230120         select;
017813230120          when cacid3 > ' ';
017814230120           sgroup# = cacid3;
017815230120          when cacid4 > ' ';
017816230120           sgroup# = cacid4;
017817230120          when cacid5 > ' ';
017818230120           sgroup# = cacid5;
017819230120         endsl;
017820230120        endif;
017821200221
017900181018        medgroup# = cacid3;
018000181018        dengroup# = cacid4;
018100181018        visgroup# = cacid5;
018101210401
018300180906        transmit = castatus;
018400180906
018500180906        type = ' ';
018600180906        exsr findFacets;
018700180906        exsr find_nonFacets;
018800180906        exsr determineType;
018900180703
019000180322       endsr;
019100180322
019200180410      //========================================================================
019300180410      // checkButton
019400180410      //========================================================================
019500180410
019600180410       begsr checkButton;
019700180410
019800240119        if btnSend = '1';
019900240119         exsr sendFile;
019901240119         btnSend = '0';
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
020900180410       endsr;
021000180410
021001240119      //========================================================================
021002240119      // send file
021003240119      //========================================================================
021004240119
021005240119       begsr sendFile;
021006240119
021021240119        errNumber = '0';
021022240119        btnExit2 = '0';
021023240119
021024240119        dow btnExit2 = '0';
021025240119
021026240119         exfmt screen1;
021027240119
021028240119         if btnOk2 = '1';
021029240119
021030240119          if numopt = ' ';
021031240119           errNumber = '1';
021032240119          endif;
021033240119
021036240119          if numopt > ' ';
021037240122           sendCigna(numopt);
021039240119            exfmt screen2;
021040240119           btnExit2 = '1';
021041240119          endif;
021042240119
021043240119         endif;
021044240119
021045240119        enddo;
021046240119
021047240119       endsr;
021048240119
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
022200181018        medgroup# = ' ';
022300181018        dengroup# = ' ';
022400181018        visgroup# = ' ';
022500180906        stransmit = ' ';
022600180906        errTrust = '0';
022700180906        errSub = '0';
022800180906        errAcct = '0';
022801210114        stransmit = 'N';
022900181018        //errTrx = '0';
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
025200180622      // delete record
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
027200180906         errAcct = '0';
027300181018         //errTrx = '0';
027400170829
027500180622         chain strst trustFile;
027600180410         if not %found;
027700180906          errTrust = '1';
027800180410          valid = '1';
027900180410         endif;
028000170830
028100180410         chain ssub# subFile;
028200180410         if not %found;
028300180906          errSub = '1';
028400180410          valid = '1';
028500210114         endif;
028600180410
028700180622         chain (strst : ssub# : sacct) acctFile;
028800180410         if not %found;
028900180906          erracct = '1';
029000180410          valid = '1';
029100180410         endif;
029200180410
029300181018         //if stransmit <> 'Y' and stransmit <> 'N' and stransmit <> 'X';
029400181018         // errTrx = '1';
029500181018         // valid = '1';
029600181018         //endif;
029700180906
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
031300180906         castatus = stransmit;
031400181018         cacid3 = medgroup#;
031500181018         cacid4 = dengroup#;
031600181018         cacid5 = visgroup#;
031601210401         cacid6 = polgroup#;
031700180410
031800180910         exsr add_toTransfile;
031900180910
032000180906         write setupFile;
032100180410
032200170906        endsr;
032300170830
032400170829      //========================================================================
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
033501210322        exsr get_userLock;
033502210322        if return = '1';
033503210322         leavesr;
033504210322        endif;
033505210322
033600210322        //chain(n) (unique : strst : ssub# : sacct) setupFile;
033700180906        stransmit = transmit;
033800181018        medgroup# = cacid3;
033900181018        dengroup# = cacid4;
034000210401        visgroup# = cacid5;
034001210401
034002210401        polgroup# = cacid6;
034003210401        if polgroup# = ' ';
034004210401         polgroup# = sgroup#;
034005210401        endif;
034006210401
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
037000181018         //errTrx = '0';
037100180410
037200180622         chain strst trustFile;
037300180410         if not %found;
037400180906          errTrust = '1';
037500180410          valid = '1';
037600180410         endif;
037700180410
037800180410         chain ssub# subFile;
037900180410         if not %found;
038000180906          errSub = '1';
038100180410          valid = '1';
038200180410         endif;
038300180410
038400180622         chain (strst : ssub# : sacct) acctFile;
038500180410         if not %found;
038600180906          errAcct = '1';
038700180410          valid = '1';
038800180410         endif;
038900180410
039000181018         //if stransmit <> 'Y' and stransmit <> 'N' and stransmit <> 'X';
039100181018         // errTrx = '1';
039200181018         // valid = '1';
039300181018         //endif;
039400180906
039500180410         if valid = '0';
039600180410          exsr edtRecord;
039700180622          btnExtEdt = '1';
039800180410         endif;
039900180410
040000180410        endsr;
040100180410
040200180410      //========================================================================
040300180410      // valid add
040400180410      //========================================================================
040500180410
040600180410        begsr edtRecord;
040700180410
040701210114         holdTransmit = ' ';
040702210114
040800180906         chain (unique : htrst : hsub# : hacct) setupFile;
040900180906         catrst = strst;
041000180906         casub# = ssub#;
041100180906         caacct = sacct;
041101210114
041102210114         holdSTransmit = stransmit;
041103210114         holdTransmit = castatus;
041106210114
041107210114         if holdTransmit in %List('1':'2':'3':'4':'5':'6':'7':'8':'9');
041108210114          holdTransmit = 'Z';
041109210114         endif;
041110210114
041207210114         if holdStransmit in %List('1':'2':'3':'4':'5':'6':'7':'8':'9');
041208210114          holdSTransmit = 'Z';
041210210114         endif;
041211210114
041212210114         castatus = stransmit;
041213210114
041214210114         holdHist = 'N';
041215210114         if holdTransmit = holdSTransmit;
041216210114          holdHist = 'Y';
041217210114         endif;
041218210114
041300181018         cacid3 = medgroup#;
041400181018         cacid4 = dengroup#;
041500181018         cacid5 = visgroup#;
041501210401         cacid6 = polgroup#;
041600180410
041700180910         exsr add_toTransfile;
041800180910
041900180906         update setupFile;
042000180410
042100180410        endsr;
042200180906
042300180906       //===========================================================================================
042400180906       // find Facets
042500180906       //===========================================================================================
042600180906
042700180906       begsr findFacets;
042800180906
042900180906        fndFacets = 'N';
043000180906
043100180906        setll (unique : htrst : hsub# : hacct) setup2File;
043200180906        reade (unique : htrst : hsub# : hacct) setup2File;
043300180906        dow not %eof;
043400180906
043500180906         setll (htrst : hsub# : cpplan) planFile;
043600180906         reade (htrst : hsub# : cpplan) planFile;
043700180906         dow not %eof;
043800180906
043900180906          if pcarr = 'CIR';
044000180906           fndFacets = 'Y';
044100180906           leavesr;
044200180906          endif;
044300180906
044400180906          if pcarr = 'CIE';
044500180906           fndFacets = 'Y';
044600180906           leavesr;
044700180906          endif;
044800180906
044900180906          if pcarr = 'CIF';
045000180906           fndFacets = 'Y';
045100180906           leavesr;
045200180906          endif;
045300180906
045400180906         reade (htrst : hsub# : cpplan) planFile;
045500180906         enddo;
045600180906
045700180906        reade (unique : htrst : hsub# : hacct) setup2File;
045800180906        enddo;
045900180906
046000180906       endsr;
046100180906
046200180906       //===========================================================================================
046300180906       // find NonFacets
046400180906       //===========================================================================================
046500180906
046600180906       begsr find_nonFacets;
046700180906
046800180906        fnd_nonFacets = 'N';
046900180906
047000180906        setll (unique : htrst : hsub# : hacct) setup2File;
047100180906        reade (unique : htrst : hsub# : hacct) setup2File;
047200180906        dow not %eof;
047300180906
047400180906         setll (htrst : hsub# : cpplan) planFile;
047500180906         reade (htrst : hsub# : cpplan) planFile;
047600180906         dow not %eof;
047700180906
047800180906          if pcarr = 'CID';
047900180906           fnd_nonFacets = 'Y';
048000180906           leavesr;
048100180906          endif;
048200180906
048300180906          if pcarr = 'CIG';
048400180906           fnd_nonFacets = 'Y';
048500180906           leavesr;
048600180906          endif;
048700180906
048800180906         reade (htrst : hsub# : cpplan) planFile;
048900180906         enddo;
049000180906
049100180906        reade (unique : htrst : hsub# : hacct) setup2File;
049200180906        enddo;
049300180906
049400180906       endsr;
049500180906
049600180906       //===========================================================================================
049700180906       // determine type
049800180906       //===========================================================================================
049900180906
050000180906       begsr determineType;
050100180906
050200180906        if fndFacets = 'Y';
050300180906         type = 'FACETS';
050400180906        endif;
050500180906
050600180906        if fnd_nonFacets = 'Y';
050700200713         type = 'PROCLAIM';
050800180906        endif;
050900180906
051000180906        if fndFacets = 'Y' and fnd_nonFacets = 'Y';
051100200713         type = 'FACETS/PROCLAIM';
051200180906        endif;
051300180906
051400180906        if fndFacets = 'N' and fnd_nonFacets = 'N';
051500180906         type = 'NO PLAN FND';
051600180906        endif;
051700180906
051800180906       endsr;
051900180906
052000180910       //===========================================================================================
052100180910       // Add to Transmission file
052200180910       //===========================================================================================
052300180910
052400180910       begsr add_toTransfile;
052500180910
052600190125        select;
052700190125         when castatus = 'Y';
052800190125          option = 'D';
052900190125          incarrier = 8;
053000190125          dltadd(catrst : casub# : caacct : incarrier : option);
053100180910
053200190125         when castatus = 'N';
053300190125          option = 'A';
053400190125          incarrier = 8;
053500190125          dltadd(catrst : casub# : caacct : incarrier : option);
053600180910
053700190125         other;
053800190125          option = 'X';
053900190125          incarrier = 8;
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
057100191209          subject = 'CIG-TRANSMISSION TURNED ON';
057200190125
057300190125         when castatus = 'N';
057400191209          subject = 'CIG-TRANSMISSION TURNED OFF';
057500190125
057501211202         when castatus = 'F';
057502211202          subject = 'CIG-PROCLAIM TRANS. IN TESTING';
057503211202
057504211202         when castatus = 'P';
057505211202          subject = 'CIG-FACETS TRANS. IN TESTING';
057506211202
057600190125         other;
057700191209          subject = 'CIG-TRANSMISSION IN TESTING';
057800190125        endsl;
057900181106
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
060600181106
060601210322      //========================================================================
060602210322      // get user lock
060603210322      //========================================================================
060604210322
060605210322       begsr get_userLock;
060606210322
060607210322        chain(n) (unique : strst : ssub# : sacct) setupFile;
060608210322        recrrn = %char(#rrn);
060609210322        GetLock(library : file : recrrn : jobNumber : user : jobName :
060610210322                returnUser : return);
060611210322        if return = '0';
060612210322         chain (unique : strst : ssub# : sacct) setupFile;
060613210322        else;
060614210322         errorTitle = 'Edit';
060615210322         errorText = 'Record being Edited by:';
060616210322         exsr get_userName;
060617210322         exfmt lockWindow;
060618210322         buttonEdit = '0';
060619210322        endif;
060620210322
060621210322       endsr;
060622210322
060623210322      //========================================================================
060624210322      // get user name
060625210322      //========================================================================
060626210322
060627210322       begsr get_userName;
060628210322
060629210322        getName(user : userName);
060630210322        userLock = userName;
060631210322
060632210322       endsr;
060633210322
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
063801200728        transmitCk  = ' ';
063802200728
063900180906        unique = '0000000251';
063901230120
063902230120        getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);
063903240122
063904240122        function = 'SENDFILE';
063905240122        dspErrMsg = 'N';
063906240122
063907240122        ChkFncAuth(pgmname : function : dspErrMsg : continue);
063908240122        if continue = 'Y';
063909240122         visSend = '1';
063910240122        else;
063911240122         visSend = '0';
063912240122        endif;
063913240122
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
