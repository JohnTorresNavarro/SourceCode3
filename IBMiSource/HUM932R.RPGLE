000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400210112      * HUM932R - Humana Mapping drill down
000500191209      *=========================================================================
000600180326      * Date         Int  Description
000700191209      * ---------    ---  ------------------------------------------------------
000800210112      * 01/12/2021   jt   Original Creation
000801210114      * 01/14/2021   jt   Made sure that no Dairy/Hist record is writen when it
000802210114      *                   changes from number to number on  field castatus
000803210308      * 03/09/2021   jt   Unlocked file in entry.
000804210317      * 03/17/2021   jt   Marked subfile record in red when account is canceled.
000900191209      *=========================================================================
001000100520
001100210112     fhum932d   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001200210112     f                                     SFile(SFL1 : RRN)
001300180320
001400210112     ftrsmst    if   e           k disk    ExtFile('F.TRSMST')
001500210112     f                                     rename(trsmsr:trustFile)
001600180410
001700210112     fsubml1    if   e           k disk    ExtFile('F.SUBML1')
001800210112     f                                     rename(submsr:subFile)
001900180906
002000210112     faccmst    if   e           k disk    ExtFile('F.ACCMST')
002100210112     f                                     rename(accmsr:acctFile)
002200180906
002300210112     fcaraccp   uf a e           k disk    rename(caraccr:setupFile)
002400180906
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
005607211202     d selNumberC      s              1
005608211202     d records         s              4
005609211202     d continue        s              1
005610211202     d dsperrMsg       s              1
005611211202     d func            s             20
005612211202     d rtn             s              1
005613211202     d userProfile     s             10
005614211202
005615211202     d getName         pr                  ExtPgm('GETUSRNAME')
005616211202     d  user                         10    const
005617211202     d  userName                     50    const
005618211202
005619211202     d getClass        pr                  ExtPgm('GETCLASS')
005620211202     d  userProfile                  10
005621211202     d  rtn                           1
005622211202
005623211202     d chkAuth         pr                  ExtPgm('CHKFNCAUTH')
005624211202     d  program                      10    const
005625211202     d  func                         20    const
005626211202     d  dsperrMsg                     1    const
005627211202     d  continue                      1    const
005700180322
005800181022     d showAcct        pr                  ExtPgm('INQ008R')
005900181022     d  trstz                         3s 0 const
006000181022     d  sub#z                         3s 0 const
006100181022     d  acctz                         4s 0 const
006200181022
006300210112     d plans           pr                  ExtPgm('HUM933R')
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
007400180910
007401211202     d humTest         pr                  ExtPgm('HUM010CLX')
007403211202     d  records                       4    const
007404211202     d  ctrust                        3    const
007405211202     d  csub#                         3    const
007406211202     d  cacct                         4    const
007408211202
007409211202     d transmitHum     pr                  ExtPgm('FT_023C')
007410211202
007411200224      //========================================================================
007412200224      // includes
007413200224      //========================================================================
007414200224
007415200224      /include GBSPGM/QMODSRC,#GettokPR
007416200224      /include GBSPGM/QMODSRC,#zFillpr
007417200224
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
009901210308         unlock caraccp;
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
014300200224        if s1ActNbr > ' ';
014301200122         setll (unique: trstk : sub#k : acctk) setupFile;
014302200122        else;
014303200122         setll (unique) setupFile;
014305200122        endif;
014306200122
014400210308        reade unique setupFile;
014500180320
014600180409        dow not %eof;
014700210112         if transmitCk  = 'Y';
014701210112          if castatus = 'Y';
014702210112           rrn += 1;
014703210112            exsr moveFields;
014704210112            write sfl1;
014705210112          endif;
014706210112         endif;
014707210112
015300210112         if transmitCk  = ' ';
015301210112          rrn += 1;
015302210112           exsr moveFields;
015303210112          write sfl1;
015304210112         endif;
015305210112
015400210308        reade unique setupFile;
015500180320        enddo;
015600170831
015601221206        unlock caraccp;
015602221206
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
017802201125        exsr getGroup;
017803201125        update setupFile;
017805200630
018300180906        transmit = castatus;
018400180906
019000180322       endsr;
019100180322
019200180410      //========================================================================
019300180410      // checkButton
019400180410      //========================================================================
019500180410
019600180410       begsr checkButton;
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
020505211202
020506211202        if btnTest = '1';
020507211202         exsr send_aTest;
020508211202         btnTest = '0';
020509211202        endif;
020510211202
020600180906        if buttonPlan = '1';
020700180622        endif;
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
021801210112        errTrust = '0';
021802210112        errSub = '0';
021803210112        errAcct = '0';
021804210112
021900180622        strst = 0;
022000180622        ssub# = 0;
022100180622        sacct = 0;
022500180906        stransmit = ' ';
022501210112        sgroup# = ' ';
022802210112        sadmin# = '780405111';
022803210112        slayout = 'AEMEMB15';
022804210112        slinebus = 'COMM';
022805210112        sheadtype = 'F';
022806210112        strailtype = 'X';
022807210112        stermtimes = 3;
022808210112        scatdate = d'0001-01-01';
022809210114        stransmit = 'N';
022810210112
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
027200180906         errAcct = '0';
027202210112         errGroup = '0';
027203210112         errAdmin = '0';
027204210114         //errTrans = '0';
027205210112         errLayout = '0';
027206210112         errLob = '0';
027207210112         errHeadt = '0';
027208210112         errTrailt = '0';
027209210112         errTermt = '0';
027400210112
027500180622         chain strst trustFile;
027600180410         if not %found;
027700180906          errTrust = '1';
027800210112           valid = '1';
027801210112          leavesr;
027900180410         endif;
028000170830
028100180410         chain ssub# subFile;
028200180410         if not %found;
028300180906          errSub = '1';
028400210112           valid = '1';
028401210112          leavesr;
028500180410         endif;
028600180410
028700180622         chain (strst : ssub# : sacct) acctFile;
028800180410         if not %found;
028900210112          errAcct = '1';
029000210112           valid = '1';
029001210112          leavesr;
029100180410         endif;
029101210112
029102210112         if sgroup# = ' ';
029103210112          errGroup = '1';
029104210112           valid = '1';
029105210112          leavesr;
029106210112         endif;
029107210112
029108210112         if sadmin# = ' ';
029109210112          errAdmin = '1';
029110210112           valid = '1';
029111210112          leavesr;
029112210112         endif;
029113210112
029114210112         if slayout = ' ';
029115210112          errLayout = '1';
029116210112           valid = '1';
029117210112          leavesr;
029118210112         endif;
029119210112
029120210112         if slinebus = ' ';
029121210112          errLob = '1';
029122210112           valid = '1';
029123210112          leavesr;
029124210112         endif;
029125210112
029126210112         if sheadtype = ' ';
029127210112          errHeadt = '1';
029128210112           valid = '1';
029129210112          leavesr;
029130210112         endif;
029131210112
029132210112         if strailtype = ' ';
029133210112          errTrailt = '1';
029134210112           valid = '1';
029135210112          leavesr;
029136210112         endif;
029137210112
029138210113         if stermtimes = 0;
029139210112          errTermt = '1';
029140210112           valid = '1';
029141210112          leavesr;
029142210112         endif;
029143210112
029144210112         If
029145210112          not (stransmit in %List('Y':'N':'1':'2':'3':'4':'5':'6':'7':'8':'9'));
029146210114          //errTrans = '1';
029147210112         valid = '1';
029148210112        endif;
029200180410
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
031301200630
031302200630         chain (catrst : casub# : caacct) acctFile;
031303200630         if %found;
031304210112          catxt1 = 'HUMANA GROUP ID FOR' + ' ' + %trim(acnam1);
031305200630         endif;
031306210112
031307210112         cacid1 = sgroup#;
031308210112         cacid2 = sadmin#;
031309210112         catxt2 = 'ADMINISTRATOR NUMBER';
031310210112         cacid3 = slayout;
031311210112         catxt3 = 'LAYOUT NAME';
031312210112         cacid4 = slinebus;
031313210112         catxt4 = 'LINE OF BUSINESS';
031314210112         cacid5 = sheadtype;
031315210112         catxt5 = 'HEADER TRANSACTION TYPE';
031316210112         cacid6 = strailtype;
031317210112         catxt6 = 'TRAILER TRANSACTION TYPE';
031318210112         cacid7 = '0' + %char(stermtimes);
031319210112         catxt7 = '# OF TIMES TO TRANSMIT TERMINATIONS';
031320210113
031322210113         if scatdate = d'0001-01-01';
031323210113          cacid8 = ' ';
031324210113         else;
031325210113          cacid8 = %char(scatdate);
031326210113         endif;
031328210112         catxt8 = 'CATEGORY EFFECTIVE DATE';
031329200630
031800180910         exsr add_toTransfile;
031900180910
032000180906         write setupFile;
032001200630
032200170906        endsr;
032300170830
032301200630      //========================================================================
032302200630      // get group
032303200630      //========================================================================
032304200630
032305200630       begsr getGroup;
032306200630
032333201125        setll (htrst : hsub# : hacct) auxFile;
032334201125        reade (htrst : hsub# : hacct) auxFile;
032335200630        dow not %eof;
032336200630
032337201125         chain (htrst : hsub# : pxplan) planFile;
032338210112         if pcarr = 'HUD' or pcarr = 'HUL' or pcarr = 'HUM' or pcarr = 'ACI';
032339200630
032340201125          chain (htrst : hsub# : pxplan) rateFile;
032341200630          if %found;
032342210112           cacid1 = group#;
032343201125           sgroup# = %subst(group#:1:6);
032345200630           leavesr;
032346200630          endif;
032347200630
032348200630         endif;
032349210112
032350201125        reade (htrst : hsub# : hacct) auxFile;
032351200630        enddo;
032352200630
032353200630       endsr;
032354200630
032411170829      //========================================================================
032500180410      // edit record
032600180410      //========================================================================
032700180410
032800180410       begsr editRecord;
032900180410
033000180622        btnUpdRcd = '0';
033100180410        btnExtEdt = '0';
033101210112        errTrust = '0';
033102210112        errSub = '0';
033103210112        errAcct = '0';
033104210112
033105210112        chain(n) (unique : htrst : hsub# : hacct) setupFile;
033106210112        stransmit = transmit;
033200180906        strst = htrst;
033300180622        ssub# = hsub#;
033400180622        sacct = hacct;
033401210112        sgroup# = cacid1;
033402210112        sadmin# = cacid2;
033404210112        slayout = cacid3;
033406210112        slinebus = cacid4;
033408210112        sheadtype = cacid5;
033410210112        strailtype = cacid6;
033412210112        stermtimes = %dec(cacid7:2:0);
033413210113
033414210113        if cacid8 > ' ';
033415210113         scatdate = %date(%subst(cacid8:1:10) : *ISO );
033417210113        endif;
033500181018
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
036502210113         valid = '0';
036503210113         errTrust = '0';
036504210113         errSub = '0';
036505210113         errAcct = '0';
036506210113         errGroup = '0';
036507210113         errAdmin = '0';
036508210114         //errTrans = '0';
036509210113         errLayout = '0';
036510210113         errLob = '0';
036511210113         errHeadt = '0';
036512210113         errTrailt = '0';
036513210113         errTermt = '0';
036514210113
036515210113         chain strst trustFile;
036516210113         if not %found;
036517210113          errTrust = '1';
036518210113           valid = '1';
036519210113          leavesr;
036520210113         endif;
036521210113
036522210113         chain ssub# subFile;
036523210113         if not %found;
036524210113          errSub = '1';
036525210113           valid = '1';
036526210113          leavesr;
036527210113         endif;
036528210113
036529210113         chain (strst : ssub# : sacct) acctFile;
036530210113         if not %found;
036531210113          errAcct = '1';
036532210113           valid = '1';
036533210113          leavesr;
036534210113         endif;
036535210113
036536210113         if sgroup# = ' ';
036537210113          errGroup = '1';
036538210113           valid = '1';
036539210113          leavesr;
036540210113         endif;
036541210113
036542210113         if sadmin# = ' ';
036543210113          errAdmin = '1';
036544210113           valid = '1';
036545210113          leavesr;
036546210113         endif;
036547210113
036548210113         if slayout = ' ';
036549210113          errLayout = '1';
036550210113           valid = '1';
036551210113          leavesr;
036552210113         endif;
036553210113
036554210113         if slinebus = ' ';
036555210113          errLob = '1';
036556210113           valid = '1';
036557210113          leavesr;
036558210113         endif;
036559210113
036560210113         if sheadtype = ' ';
036561210113          errHeadt = '1';
036562210113           valid = '1';
036563210113          leavesr;
036564210113         endif;
036565210113
036566210113         if strailtype = ' ';
036567210113          errTrailt = '1';
036568210113           valid = '1';
036569210113          leavesr;
036570210113         endif;
036571210113
036572210113         if stermtimes = 0;
036573210113          errTermt = '1';
036574210113           valid = '1';
036575210113          leavesr;
036576210113         endif;
036577210113
036578210113         If
036579210113          not (stransmit in %List('Y':'N':'1':'2':'3':'4':'5':'6':'7':'8':'9'));
036580210114          //errTrans = '1';
036581210113         valid = '1';
036582210113        endif;
036583210113
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
041101210114
041102210114         holdSTransmit = stransmit;
041103210114         holdTransmit = castatus;
041104210114
041105210114         if holdTransmit in %List('1':'2':'3':'4':'5':'6':'7':'8':'9');
041106210114          holdTransmit = 'Z';
041107210114         endif;
041108210114
041109210114         if holdStransmit in %List('1':'2':'3':'4':'5':'6':'7':'8':'9');
041110210114          holdSTransmit = 'Z';
041111210114         endif;
041112210114
041200180906         castatus = stransmit;
041201210112
041202210114         holdHist = 'N';
041203210114         if holdTransmit = holdSTransmit;
041204210114          holdHist = 'Y';
041205210114         endif;
041206210114
041207210112         chain (catrst : casub# : caacct) acctFile;
041208210112         if %found;
041209210112          catxt1 = 'HUMANA GROUP ID FOR' + ' ' + %trim(acnam1);
041210210112         endif;
041211210112
041212210112         cacid1 = sgroup#;
041213210112         cacid2 = sadmin#;
041214210112         catxt2 = 'ADMINISTRATOR NUMBER';
041215210112         cacid3 = slayout;
041216210112         catxt3 = 'LAYOUT NAME';
041217210112         cacid4 = slinebus;
041218210112         catxt4 = 'LINE OF BUSINESS';
041219210112         cacid5 = sheadtype;
041220210112         catxt5 = 'HEADER TRANSACTION TYPE';
041221210112         cacid6 = strailtype;
041222210112         catxt6 = 'TRAILER TRANSACTION TYPE';
041223210112         cacid7 = '0' + %char(stermtimes);
041224210112         catxt7 = '# OF TIMES TO TRANSMIT TERMINATIONS';
041225210113
041226210113         if scatdate = d'0001-01-01';
041227210113          cacid8 = ' ';
041228210113         else;
041229210113          cacid8 = %char(scatdate);
041230210113         endif;
041231210112         catxt8 = 'CATEGORY EFFECTIVE DATE';
041600180410
041700180910         exsr add_toTransfile;
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
052900200630          incarrier = 20;
053000190125          dltadd(catrst : casub# : caacct : incarrier : option);
053100180910
053200190125         when castatus = 'N';
053300190125          option = 'A';
053400200630          incarrier = 20;
053500190125          dltadd(catrst : casub# : caacct : incarrier : option);
053600180910
053700190125         other;
053800190125          option = 'X';
053900200630          incarrier = 20;
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
057100210112          subject = 'HUM-TRANSMISSION TURNED ON';
057200190125
057300190125         when castatus = 'N';
057400210112          subject = 'HUM-TRANSMISSION TURNED OFF';
057500190125
057600190125         other;
057700210112          subject = 'HUM-TRANSMISSION IN TESTING';
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
060601211202      //========================================================================
060602211202      // send test file
060603211202      //========================================================================
060604211202
060605211202       begsr send_aTest;
060606211202
060610211202        records = '0';
060611211202        btnCancel = '0';
060613211202        selNumber = 0;
060614211202
060615211202        dow btnCancel = '0';
060616211202
060619211202         exFmt selWindow;
060620211202
060621211202         if btnCancel ='1';
060622211202          selNumber = 0;
060623211202           btnCancel = '0';
060624211202          leavesr;
060625211202         endif;
060626211202
060627211202         if btnRun = '1';
060628211202          exsr send_toHUM;
060629211202          btnRun = '0';
060630211202
060631211202          if records > '0000';
060632211202           compText = 'File was sent to Humana';
060633211202          else;
060634211202           compText = 'No Records sent to Humana';
060635211202          endif;
060636211202
060637211202          exfmt msgWindow;
060638211202          btnCancel = '1';
060639211202
060640211202         endif;
060641211202
060642211202        enddo;
060643211202
060644211202       endsr;
060645211202
060646211202      //========================================================================
060647211202      // send a test file
060648211202      //========================================================================
060649211202
060650211202       begsr send_toHUM;
060651211202
060652211202        selNumberC = %char(selNumber);
060653211202
060654211202        setll ('0000000093') setupFile;
060655211202        reade ('0000000093') setupfile;
060656211202        dow not %eof;
060657211202         if %char(selNumber) = castatus;
060658211202
060662211202          humTest(records:%editc(catrst:'X'):%editc(casub#:'X'):
060663211202           %editc(caacct:'X'));
060664211202           if records > '0000';
060665211202            transmitHum();
060666211202            leavesr;
060667211202           endif;
060668211202
060669211202         endif;
060670211202        reade ('0000000093') setupfile;
060671211202        enddo;
060672211202
060673211202       endsr;
060674211202
060675211202
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
063700210112        title = 'Humana Account Mapping';
063800180906
063900210112        unique = '0000000093';
063901211202
063902211202        showTest = '0';
063903211202        userProfile = user;
063904211202        getClass(userProfile : rtn);
063905211202        if rtn = 'Y';
063906211202         showTest = '1';
063907211202        endif;
063908211202
063909211202        if rtn = 'N';
063910211202         dspErrMsg = 'N';
063911211202         chkAuth('HUM932R' : func : dsperrMsg : continue);
063912211202         if continue = 'Y';
063913211202          showtest = '1';
063914211202         endif;
063915211202        endif;
063916211202
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
