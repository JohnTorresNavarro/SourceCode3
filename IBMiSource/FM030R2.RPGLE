000100231226      *========================================================================
000200210709     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300201221      *========================================================================
000400210709      * FM030R2 - Plan Maintenance
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700201208      * ----------   ---  -----------------------------------------------------
000800210709      * 07/31/2021   jt   Original Creation
000801220602      * 06/07/2022   jt   Fixed Invoice Column field, Debid Card field, Round
000802220602      *                   Preminum field and Company Paid field.
000803220617      * 06/17/2022   jt   Fixed Invoice colum error message. Cleared out some
000804220617      *                   defaulted values for new plans.
000805220621      * 06/21/2022   jt   Changed when Class screen pops up.
000806220623      * 06/23/2022   jt   Added more class codes.
000807221013      * 10/14/2022   jt   Allow 0 in Remittance Format %.
000808221202      * 12/02/2022   jt   Defaulted 2 fields when category defaults are not selected
000809230125      * 01/25/2023   jt   Eliminated check for rounding
000810230203      * 02/02/2023   jt   Initialized rounding field to 0 when new plan is
000811230203      *                   created.
000812230314      * 03/14/2023   jt   Allowed for all carrier codes to add a class. Still
000813230314      *                   forcing CareFirst codes to add a class.
000814231226      * 01/05/2024   jt   Call to new class screen
000900180326      *========================================================================
001000180628
001100210706     ffm030d2   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001101201208
001104201221     ftrsmst    if   e           k disk    rename(trsmsr:trustFile)
001105201221     f                                     extfile('F.TRSMST')
001106201221
001107201221     fsubmst    if   e           k disk    rename(submsr:subFile)
001108201221     f                                     extfile('F.SUBMST')
001109201221
001111210709     fplnmst    uf a e           k disk    rename(plnmsr:planFile)
001112210709     f                                     extfile('F.PLNMST')
001113201221
001114201221     faccmst    if   e           k disk    rename(accmsr:acctFile)
001115201221     f                                     extfile('F.ACCMST')
001116201221
001125210709     fplnhist0  if a e             disk    rename(rplnhist:histFile)
001126210709     f                                     extfile('F.PLNHIST0')
001127201221
001128210709     fcodes     if   e           k disk    rename(codesr:codesFile)
001129210709     f                                     extfile('F.CODES')
001130210709
001133201221     fcarmst    if   e           k disk    rename(carmsr:carrFile)
001134201221     f                                     extfile('F.CARMST')
001136201208
001137201221     fcarplnl   uf   e           k disk    rename(carplnr:planSetup)
001138201221
001141210709     fplnauxp   uf   e           k disk    rename(plnauxr:auxFile)
001142210709
001143210709     fcarmst2p  if   e           k disk    rename(carmst2r:car2File)
001144211007
001145211007     fclass     if   e           k disk    rename(fclass:classFile)
001146211007     f                                     extfile('F.CLASS')
001147210709
001148210706     foeplan    uf a e           k disk    rename(oeplanr:oeFile)
001149211007
001150210709     fcarplnz   uf   e           k disk    rename(carplnr:uhcPlan)
001151210709
001152210709     fuhcplancrtif   e           k disk    rename(uhcpcr:uhcPlncrt) usropn
001153201221
001154210805     fcatdefaultif   e           k disk    rename(catdr:catDef)
001155210805
001300201221      //=======================================================================
001400180323
001500180323     d psds           sds
001600201221     d  proc_name        *proc
001601201221     d  jobName              244    253
001602201221     d  userName             254    263
001603201221     d  jobNumber            264    269
001604210709
001605210709     d poss            s              2  0
001606210709     d poss2           s              2  0
001607210709     d lenght          s              1  0
001608210709
001609210716     d result          s              2  0
001610201221     d action          s              1
001617201221     d exportID        s             10
001618201221     d valid           s              1
001620210706     d @50             s             50
001621210706     d @3              s              3
001622210709     d @90             s             90
001623210706     d srenmond        s              2  0
001624210706     d cancel          s              1
001625210706     d pType           s              1
001626210709     d doAction        s              1
001627210709     d before          s            200
001628210709     d after           s            200
001629210709     d trustList       s              3
001630210805     d #status         s              1
001631211007     d need            s              1
001632220331     d #carrier        s              3
001633220331     d #catcode        s              2
001634220505     d #month          s              2
001635231226     d #trust          s              3
001636231226     d #sub#           s              3
001637210706
001638210716     d ds@hold       e ds                  extname(plnmst)
001639210709
001640210716     d*holdInvCol      s                   like(invcoldesc) dim(9) ctdata
001641210716
001642210716     d*holdArr         ds                  qualified dim(9)
001643210716     d* invoiceVal                   14    varying
001644210716
001645210709     d                 ds
001646210709     d @parmDS                 1     90
001647210709     d p@trs                   1      3  0
001648210709     d p@sub                   4      6  0
001649210709     d p@pln                   7     10
001650210709     d p@td                   11     30
001651210709     d p@sd                   31     50
001652210709     d p@pd                   51     90
001653210709
001654210709     d                 ds
001655210706     d @P2DS                   1     50
001656210706     d P@TRS2                  1      3  0
001657210706     d P@SUB2                  4      6  0
001658210706     d P@PLN2                  7     10
001659210706     d P@TD2                  11     30
001660210706     d P@SD2                  31     50
001661201221
001662231226     d classScreen     pr                  ExtPgm('FM032R2')
001663231226     d  #trust                        3
001664231226     d  #sub#                         3
001665231226     d  #kp                           4
001666210709
001701210706     d planAux         pr                  ExtPgm('FM035R2')
001702210706     d  #kt                           3  0
001703210706     d  #ks                           3  0
001704210706     d  #kp                           4
001705210706     d  #ka                           4  0
001706210805     d  #status                       1
001707220331     d  #carrier                      3
001708220505     d  #catcode                      2
001709220505     d  #month                        2
001711210706
001712210716     d*get_planHist    pr                  ExtPgm('FM031R')
001713210716     d* @50                          50    const
001714201221
001715210716     d get_planHist    pr                  ExtPgm('FM031R2')
001716210716     d  #kt                           3  0
001717210716     d  #ks                           3  0
001718210716     d  #kp                           4
001719210716
001720210706     d getCarrier      pr                  ExtPgm('WNCARMSTR')
001721210706     d  @3                            3
001722210706     d  cancel                        1
001723210706
001724210706     d getCode         pr                  ExtPgm('WNCODEMSTR')
001725210706     d  @3                            3
001726210706     d  pType                         3    const
001727210706     d  cancel                        1
001728210706
001729221202     d e1envir         s             15
001730221202     d e1libl          s             10
001731221202     d e1Lib2          s             10
001732221202     d envColor        s             10
001733221202     d e1Acnm          s             40
001734221202
001735221202     d getEnv          pr                  ExtPgm('GETENVR')
001736221202     d  e1envir                      15
001737221202     d  e1libl                       10
001738221202     d  e1Lib2                       10
001739221202     d  envColor                     10
001740221202     d  e1Acnm                       40
001741221202
002103210706     d fm030r2         pi
002104201221     d  #kt                           3  0
002105201221     d  #ks                           3  0
002106201221     d  #kp                           4
002107201221     d  #ka                           4  0
002108201208
002200201221      //=======================================================================
002300180323      // mainline
002400201221      //=======================================================================
002500180323
002600180323       exsr init;
002700180323       exsr main;
002800180323       exsr exit;
002900180323
003000201221      //=======================================================================
003100180323      // main
003200201221      //=======================================================================
003300180323
003400180323       begsr main;
003500180323
003501210709        exsr loadFields;
003502210709
003600180323        dow btnExit = '0';
003702201221
003703201221         exfmt screen1;
003900180323
004000180323         exsr checkButton;
004100180323
004200180323        enddo;
004300180323
004400180323       endsr;
004500180323
004566201221      //=======================================================================
004567201208      // checkButton
004568201221      //=======================================================================
004569201208
004570201208       begsr checkButton;
004571201208
004572201208        if btnExit = '1';
004573201208         leavesr;
004574201208        endif;
004575201208
004576201221        if btnHist = '1';
004577210706         P@TRS2 = strust;
004578210706          P@SUB2 = ssub#;
004583210706           P@PLN2 = splan;
004584210709
004585210709           chain strust trustFile;
004586210709           if %found;
004587210709            p@td2 = tdescr;
004588210709           endif;
004589210709
004590210709           chain (strust : ssub#) subFile;
004591210709           if %found;
004592210709            p@sd2 = subdsc;
004593210709           endif;
004594210709
004596210706          @50 = @P2DS;
004597210706
004598210716          get_planHist(strust : ssub# : splan);
004599210706         btnHist = '0';
004600201221        endif;
004601201221
004602201221        if btnAddUpd = '1';
004603201221         exsr AddUpd;
004604201221         btnAddUpd = '0';
004605201221        endif;
004606201221
004607210706        if buttonCarr = '1';
004608210706         getCarrier(@3 : cancel);
004609211007          errCarr = '0';
004610211007           colorCarr = ' ';
004611210706          scarriercd = @3;
004612210706         buttonCarr = '0';
004613210706        endif;
004614210706
004615210706        if buttonCode = '1';
004616210706         getCode(@3 : 'P' : cancel);
004617210706          splancd = @3;
004618210706         buttonCode = '0';
004619210706        endif;
004620210706
004621210706        if buttonDeb = '1';
004622210706         getCode(@3 : 'a' : cancel);
004623210716          buttonDeb = '0';
004624220505          sdebcard = %subst(@3:2:1);
004625210706        endif;
004626210706
004627210706        if buttonAux = '1';
004628220331         #carrier = scarriercd;
004629220331         #catcode = splancd;
004630220505         #month = srenmon;
004632230209         planAux(#kt:#ks:#kp:#ka:#status:#carrier:#catcode:#month);
004633210706         buttonAux = '0';
004634210902         visible6 = '1';
004635210706        endif;
004636210706
004637210706        if buttonDel = '1';
004638210706         exsr deleteRcd;
004639210706         buttonDel = '0';
004640210706        endif;
004641210709
004642210709        if btnClass = '1';
004643211007         exsr class1;
004644210716         btnClass = '0';
004645210709        endif;
004646210706
004647210805        if scarrovr = 'Y';
004648210709         visible2 = '1';
004649210706        else;
004650210706         visible2 = '0';
004651210716        endif;
004652210706
004653210716        if ssalbased = 'Y';
004654210716         visible4 = '1';
004655210716        else;
004656210716         visible4 = '0';
004657210716        endif;
004658210716
004659210805        if scatdef = 'Y' or scatdef = ' ';
004660210805         exsr defaults;
004661210805        endif;
004662210805
004663201208       endsr;
004664201208
004665201221      //=======================================================================
004700210716      // load fields
004800201221      //=======================================================================
004900180323
005000201208       begsr loadFields;
005100180323
005101230209        chain(n) (strust : ssub# : splan) auxFile;
005102230209        if %found;
005103230209         ssdob = pxussp;
005104230209        endif;
005105230209
005107210716        chain strust trustFile;
005108210716        if %found;
005109210716         strustname = tdescr;
005110210716        endif;
005111210716
005113210830
005114210716        chain (strust : ssub#) subFile;
005115210716        if %found;
005116210716         ssubname = subdsc;
005117210716        endif;
005118210716
005119230210        visible5 = '0';
005120210706        chain(n) (#kt : #ks : #kp) planFile;
005121210706        if %found;
005122230210         visible5  = '1';
005123210805         action = 'U';
005124210805
005125210706         if pldltd = 'A';
005126210706          DelRes = 'Delete';
005127210706         else;
005128210706          DelRes = 'Restore';
005129210716         endif;
005130210706
005131210706         colorPrt = '#FF0000';
005132210706         tspProtect = '1';
005133210706         updadd = 'Update';
005134210709
005135210709         sdescrp = pdescr;
005136210709         srenmond = prenew;
005137210706         srenmon = %editc(srenmond:'X');
005138210706
005139210709         if scarriercd = ' ';
005140210706          scarriercd = pcarr;
005141210706         endif;
005142210706
005143210706         if #ka > 0;
005144210706          chain (#kt : #ks : #ka) acctFile;
005145210706          if %found;
005146210706           visible = '1';
005147220602           sacct = acacct;
005148210706           saccdesc = acnam1;
005149210706          endif;
005150210706         else;
005151210706          visible = '0';
005152210706         endif;
005153210706
005154210706         chain (strust : ssub# : splan) oeFile;
005155210706         if %found;
005156210706          soedesc = odesc;
005157210706         endif;
005158210706
005159210706         if sdebcard = ' ';
005160210706          sdebcard = pdebit;
005161210706         endif;
005162210706
005163220602         if sdebcard = ' ';
005164220602          sdebcard = 'N';
005165220602         endif;
005166220602
005167210706         sgrrenfl = sgrrmt;
005168210706         sinvcol = invcol;
005169210706         sageband = pabfl;
005170210716
005171230125         if round >= 0;
005172230202          //sround = %char(round);
005173230202          sround = round;
005174210716         endif;
005175210706
005176210716         if maxben >= 1;
005177210716          smaxamt = maxben;
005178210716         endif;
005179210716
005180210706         if splancd = ' ';
005181210706          splancd = %subst(plncat:2:2);
005182210706         endif;
005183210706
005184210706          sratetp = prtype;
005185210706           srndpre = prndprm;
005186210706            sretfmt = remitf;
005187210716           sretper = remitp * 10;
005188210706          ssubpln = sfadm;
005189210805         spcp = pcp_req;
005190210706
005191210706         scomppaid = pfill1;
005192210706         if scomppaid = ' ';
005193210706          scomppaid = 'N';
005194210716         endif;
005195210706
005196210709         //if scarrovr = 'Y';
005197210716
005198210716          if pcomp > 0;
005199210716           scom = pcomp;
005200210716          endif;
005201210716
005202210716          if pafp > 0;
005203210716           sadminfee = pafp;
005204210716          endif;
005205210716
005206220624          if prndfl = 'U';
005207220624           sroundflag = 'Up';
005208220624          else;
005209220624           sroundflag = 'Down';
005210220624          endif;
005211220624
005212210716          if mult > 0;
005213210716           sbmult = mult;
005214210716          endif;
005215210716
005216210709         if scarrovr = 'Y';
005217210709          visible2 = '1';
005218210709         else;
005219210709          visible2 = '0';
005220210709         endif;
005221210706
005222210709         if scom > 0 or sadminfee > 0 or sbonusdr > 0;
005223210709          visible2 = '1';
005224210709         endif;
005225210709
005226210716         if ssalbased = 'Y';
005227210716          visible4 = '1';
005228210716         else;
005229210716          visible4 = '0';
005230210716         endif;
005231210716
005232210716         if plncat = 'PLF' or plncat = 'PSL' or plncat = 'PWD'
005233210805          or plncat = 'PLT' or plncat = 'PVL' or plncat = 'PLS';
005234210716          visible4 = '1';
005235210716         endif;
005236210805
005237210716         exsr get_invoiceColumn;
005238210902         visible6 = '1';
005259201221        else;
005262211013         //clear screen1;
005263210805
005264210716         exsr get_invoiceColumn;
005265210716
005266210716         chain #kt trustFile;
005267210716         if %found;
005268210716          strustname = tdescr;
005269210716         endif;
005270210716
005271210716         chain (#kt : #ks) subFile;
005272210716         if %found;
005273210716          ssubname = subdsc;
005274210716         endif;
005275210716
005276210805        visible3 = '0';
005277210805        chain strust trustFile;
005278210805        if %subst(tscode:3:1) in %list ('N' : 'M' : 'D');
005281210805         visible3 = '1';
005282210805        endif;
005284210805
005285210805         if #ka > 0;
005286210805          chain (#kt : #ks : #ka) acctFile;
005287210805          if %found;
005288210805           visible = '1';
005289210805           sacct = acacct;
005290210805           saccdesc = acnam1;
005291210805          endif;
005292210805         else;
005293210805          visible = '0';
005294210805         endif;
005295210805
005296210709         btnExit = '0';
005297210709         colorPrt = '#FF0000';
005298210709         tspProtect = '1';
005299210709         strust = #kt;
005300210709         ssub# = #ks;
005301210709         splan = #kp;
005302210709         sacct = #ka;
005303201221         action = 'A';
005304201221         updadd = 'Add';
005305210830         sretfmt = ' ';
005306210830         sretper = 0;
005307210830         sgrrenfl = ' ';
005308210830         ssubpln = ' ';
005309210709         DelRes = 'Delete';
005310210830         visible5 = '1';
005311210805         pgmname = proc_name;
005312210902         visible6 = '0';
005313220617         //exsr defaults;
005314201221        endif;
005315201208
005602201208       endsr;
005700180323
005701201221      //=======================================================================
005702201221      // Add/Update
005703210805      //=======================================================================
005704201221
005705201221       begsr AddUpd;
005706210709
005707210709        //unlock plnunique;
005709210716        chain (#kt : #ks : #kp) planFile;
005710201221        if not %found;
005711210709         doAction = 'A';
005712201221        else;
005713210709         doAction = 'U';
005714201221        endif;
005715201221
005718201221         exsr validRcd;
005719201221         if valid = '1';
005721201221          leavesr;
005722210709         else;
005723210709          exsr moveFields;
005724201221         endif;
005725201221
006026201221       endsr;
006027201221
006028201221      //=======================================================================
006029210706      // valid record
006030201221      //=======================================================================
006031201221
006032210716       begsr validRcd;
006033210706
006034210709        valid = '0';
006035210706        errTrst = '0';
006036210706        errSub# = '0';
006037210706        errPlan = '0';
006038210706        errPdesc = '0';
006039210716        //errOEPdesc = '0';
006040210709        errRenmon = '0';
006041210709        errCarr = '0';
006042210709        errInvcol = '0';
006043210709        errAgeband = '0';
006044210709        errPlancat = '0';
006045210709        errRetfmt = '0';
006046210709        errRetpert = '0';
006047210709        errSbplan = '0';
006048210709        errRprem = '0';
006049210709        errPCP = '0';
006050210709        errCompp =  '0';
006051210709        errSGR = '0';
006052210709        errMult = '0';
006053210709        errRound = '0';
006054210709        errRoundFl = '0';
006055210709        errMaxamt = '0';
006056210805        errRatetp = '0';
006057211007        colorCarr = ' ';
006058230210        errAnc = '0';
006059210706
006131210716        chain (#kt) trustFile;
006132210706        if not %found;
006133210706         errTrst = '1';
006134210709          valid = '1';
006135210706         leavesr;
006136210706        endif;
006137201221
006138210716        chain (#kt : #ks) subFile;
006139210706        if not %found;
006140210706         errSub# = '1';
006141210709          valid = '1';
006142210706         leavesr;
006143210706        endif;
006144210706
006145210706        if splan = ' ';
006146210706         errPlan = '1';
006147210709          valid = '1';
006148210706         leavesr;
006149210706        endif;
006150210706
006151210706        if splan = ' ';
006152210706         errPlan = '1';
006153210709          valid = '1';
006154210706         leavesr;
006155210706        endif;
006156210706
006157210709        if sdescrp = ' ';
006158210706         errPdesc = '1';
006159210709          valid = '1';
006160210706         leavesr;
006161210706        endif;
006162210706
006163210706        if soedesc = ' ';
006164210716         //errOEPdesc = '1';
006165210716          //valid = '1';
006166210716         //leavesr;
006167210706        endif;
006168210706
006169210709        if srenmon = ' ';
006170210709         errRenmon = '1';
006171210709          valid = '1';
006172210709         leavesr;
006173210709        endif;
006174210709
006175210709        chain scarriercd carrFile;
006176211007        if not %found or cadltd = 'D';
006177210709         errCarr = '1';
006178211007          colorCarr = '#FF0000';
006180210709          valid = '1';
006181210709         leavesr;
006182210709        endif;
006183210709
006184210716        select;
006185210716         when sinvcol = '1';
006186210716          if ih1t = ' ';
006187220617           //errInvcol = '1';
006188220617           // valid = '1';
006189220617           //leavesr;
006190210716          endif;
006191210716
006192210716         when sinvcol = '2';
006193220617          if ih2t = ' ';
006194220617          // errInvcol = '1';
006195220617          //  valid = '1';
006196220617          // leavesr;
006197210716          endif;
006198210716
006199210716         when sinvcol = '3';
006200220617          if ih3t = ' ';
006201220617          // errInvcol = '1';
006202220617          //  valid = '1';
006203220617          // leavesr;
006204210716          endif;
006205210716
006206210716         when sinvcol = '4';
006207210716          if ih4t = ' ';
006208220617          // errInvcol = '1';
006209220617          //  valid = '1';
006210220617          // leavesr;
006211210716          endif;
006212210716
006213210716         when sinvcol = '5';
006214220617          if ih5t = ' ';
006215220617          // errInvcol = '1';
006216220617          // valid = '1';
006217220617          // leavesr;
006218210716          endif;
006219210716
006220210716         when sinvcol = '6';
006221210716          if ih6t = ' ';
006222220617          // errInvcol = '1';
006223220617          // valid = '1';
006224210716           leavesr;
006225210716          endif;
006226210716
006227210716         when sinvcol = '7';
006228210716          if ih7t = ' ';
006229220617          // errInvcol = '1';
006230220617          //  valid = '1';
006231220617          // leavesr;
006232210716          endif;
006233210716
006234210716         when sinvcol = '8';
006235210716          if ih8t = ' ';
006236220617          // errInvcol = '1';
006237220617          //  valid = '1';
006238220617          // leavesr;
006239210716          endif;
006240210716
006241210716         when sinvcol = '9';
006242210716          if ih9t = ' ';
006243220617          // errInvcol = '1';
006244220617          //  valid = '1';
006245220617          // leavesr;
006246210716          endif;
006247210716        endsl;
006248210716
006249210902        if plncat = 'PLF' or plncat = 'PSL' or plncat = 'PWD'
006250210902         or plncat = 'PLT' or plncat = 'PVL' or plncat = 'PLS';
006251210902          if srndpre = ' ';
006252220331           //errRprem = '1';
006253220331           // valid = '1';
006254220331           // ssalbased = 'Y';
006255220331           // visible4 = '1';
006256220331           //leavesr;
006257210902          endif;
006258210902        endif;
006259210902
006269210902        //if srndpre = ' ';
006270210902        // errRprem = '1';
006271210902        //  valid = '1';
006272210902        //  ssalbased = 'Y';
006273210902        //  visible4 = '1';
006274210902        // leavesr;
006275210902        //endif;
006276210709
006277210716        //if sinvcol = ' ';
006278210716        // errInvcol = '1';
006279210716        //  valid = '1';
006280210716        // leavesr;
006281210716        //endif;
006282210709
006283230210        if ssalbased = 'Y' and scatdef <> 'Y';
006284230210         errAnc = '1';
006285230210          valid = '1';
006286230210           ssalbased = 'Y';
006287230210          visible4 = '1';
006288230210         leavesr;
006289230210        endif;
006290230210
006291221202        exsr defaults;
006292210709        if sageband = ' ';
006293210716         errAgeband = '1';
006294210709          valid = '1';
006295210805          ssalbased = 'Y';
006296210805          visible4 = '1';
006297210709         leavesr;
006298210709        endif;
006299210709
006300210709        chain ('P' : splancd) codesFile;
006301210709        if not %found;
006302210709         errPlancat = '1';
006303210709          valid = '1';
006304210709         leavesr;
006305210709        endif;
006306210709
006307210709        if sratetp = ' ';
006308210709         errRatetp = '1';
006309210709          valid = '1';
006310210709         leavesr;
006311210709        endif;
006312210709
006313210709        if sretfmt = ' ';
006314210709         errRetfmt = '1';
006315210709          valid = '1';
006316210709         leavesr;
006317210709        endif;
006318210709
006319221013        //if sretper = 0;
006320221013        // errRetpert = '1';
006321221013        //  valid = '1';
006322221013        // leavesr;
006323221013        //endif;
006324210709
006325210709        if ssubpln = ' ';
006326210709         errSbplan = '1';
006327210709          valid = '1';
006328210709         leavesr;
006329210709        endif;
006330210709
006331210805        if spcp = ' ';
006332210709         errPCP = '1';
006333210709          valid = '1';
006334210709         leavesr;
006335210709        endif;
006336210709
006337210709        if scomppaid = ' ';
006338210709         errCompp = '1';
006339210709          valid = '1';
006340210805          ssalbased = 'Y';
006341210805          visible4 = '1';
006342210709         leavesr;
006343210709        endif;
006344210709
006345210709        if sgrrenfl = ' ';
006346210709         errSGR = '1';
006347210709          valid = '1';
006348210709         leavesr;
006349210709        endif;
006350210709
006351211007        //chain scarriercd carrFile;
006352211007        //if not %found or cadltd = 'D';
006353211007        // errCarr = '1';
006354211007        //  colorCarr = '#FF0000';
006355211007        //  valid = '1';
006356211007        // leavesr;
006357211007        //endif;
006358210709
006359210716        //if splancd > ' ';
006360210716
006361210716        //chain ('P' : splancd) codesFile;
006362210716        // if code = 'LF' or code = 'SL' or code=  'WD' or code = 'LT'
006363210716        //  or code = 'VL';
006364210709
006365210716         // if sbmult = 0;
006366210716         //  errMult = '1';
006367210716         // valid = '1';
006368210716         //  leavesr;
006369210716         // endif;
006370210709
006371210716         // if sround = 0;
006372210716         //  errRound = '1';
006373210716         // valid = '1';
006374210716         //  leavesr;
006375210716         // endif;
006376210709
006377210716         // if sroundflag = ' ';
006378210716         //  errRoundFl = '1';
006379210716         // valid = '1';
006380210716         //  leavesr;
006381210716         // endif;
006382210709
006383210716         // if smaxamt = 0;
006384211007         //  errMaxamt = '1';
006385210716         // valid = '1';
006386210716         //  leavesr;
006387210716         // endif;
006388210709
006389210716         //endif;
006390210716
006391210716        //endif;
006392210709
006393201221       endsr;
006394201221
006395210706      //=======================================================================
006396210709      // delete/restore file;
006397210706      //=======================================================================
006398210706
006399210706       begsr deleteRcd;
006400210706
006401210706        chain (#kt : #ks : #kp) planFile;
006402210706        if %found;
006403210706
006404210706         if pldltd = 'A';
006405210706          pldltd = 'D';
006406210706         else;
006407210706          pldltd = 'A';
006408210706         endif;
006409210706
006410210706         update planFile;
006411210706        endif;
006412210706
006413210706       endsr;
006414210706
006415210709      //=======================================================================
006416210709      // move fields
006417210709      //=======================================================================
006418210709
006419210709       begsr moveFields;
006420210709
006421210716        if doAction = 'A';
006422210716         clear planFile;
006423210716        endif;
006424210716
006425230209        //chain (strust : ssub# : splan) auxFile;
006426230209        //if %found;
006427230209        // pxussp = ssdob;
006428230209        //endif;
006429230209
006430210709        pltrst = strust;
006431210709        plsub# = ssub#;
006432210709        plplan = splan;
006433210709        pdescr = sdescrp;
006434210709
006435210709        chain (strust : ssub# : splan) oeFile;
006436210709        if %found;
006437210709         odesc = soedesc;
006438210709         update oeFile;
006439210709        else;
006440210709         otrst = strust;
006441210709          osub# = ssub#;
006442210709          oplan = splan;
006443210709         odesc = soedesc;
006444220802         write oeFile;
006445210709        endif;
006446210709
006447210716        prenew = %dec(srenmon:2:0);
006448220602        pcarr = scarriercd;
006449210709        pdebit = sdebcard;
006450220602
006451210709        invcol = sinvcol;
006452220602        if invcol = ' ';
006453220602         invcol = '3';
006454220602        endif;
006455220602
006456210709        pabfl = sageband;
006457210709
006458210716        sgrrmt = sgrrenfl;
006459210716
006460230202        //if sround <> ' ';
006461230202         //round = %dec(sround:5:0);
006462230202         round = sround;
006463210716
006464210709        plncat = 'P' + %trim(splancd);
006465210709        prtype = sratetp;
006466220602
006467210709        prndprm = srndpre;
006468220602        if prndprm = ' ';
006469220602         prndprm = 'N';
006470220602        endif;
006471210709        remitf = sretfmt;
006472221013
006473221013        remitp = 0;
006474221013        if sretper > 0;
006475221013         remitp = sretper / 10;
006476221013        endif;
006477221013
006478210709        sfadm = ssubpln;
006479210805        pcp_req = spcp;
006480220602
006481210709        pfill1 = scomppaid;
006482220602        if pfill1 = 'N';
006483220602         pfill1 = ' ';
006484220602        endif;
006485210716
006486210716        if scom >= 1;
006487210716         pcomp = scom;
006488210716        else;
006489210716         pcomp = 0;
006490210716        endif;
006491210716
006492210716        if sadminfee >= 1;
006493210716         pafp = sadminfee;
006494210716        else;
006495210716         pafp = 0;
006496210716        endif;
006497210716
006498210716        if sbonusdr >= 1;
006499210716         pbonp = sbonusdr;
006500210716        else;
006501210716         pbonp = 0;
006502210716        endif;
006503210709
006504220624        if sbmult > 0;
006505220624         mult = sbmult;
006506210716        else;
006507210716         mult = 0;
006508210716        endif;
006509220624
006510220624        prndfl = sroundflag;
006511230209        pxussp = ssdob;
006512210716
006513210716        if smaxamt >= 1;
006514210716         maxben = smaxamt;
006515210716        else;
006516210716         maxben = 0;
006517210716        endif;
006518210716
006519210709        if doAction = 'A';
006520220309         exsr ageBands;
006521211007         exsr class2;
006522211007         if need = 'Y';
006523211007
006524211007          chain (#kt : #ks : #kp) classFile;
006525211007          if %found;
006526211007
006527220331          #carrier = scarriercd;
006528220331          #catcode = splancd;
006529220505          #month = srenmon;
006530230209           planAux(#kt:#ks:#kp:#ka:#status:#carrier:#catcode:#month);
006531211007            if #status = '0';
006532211007             pldltd = 'A';
006533211007              write PlanFile;
006534211007               visible6 = '1';
006535211007                after = ds@hold;
006536211007               exsr hist;
006537211007              msg = 'Plan has been Created';
006538211007             exfmt msgWindow;
006539211007            endif;
006540211007
006541211007          else;
006542211007           exfmt msgWindow3;
006543211007          endif;
006544211007
006545211007         else;
006546220331          #carrier = scarriercd;
006547220331          #catcode = splancd;
006548220505          #month = srenmon;
006549230209          planAux(#kt:#ks:#kp:#ka:#status:#carrier:#catcode:#month);
006550211007           if #status = '0';
006551211007            pldltd = 'A';
006552211007             write PlanFile;
006553230209
006554230209             chain (strust : ssub# : splan) auxFile;
006555230209             if %found;
006556230209              pxussp = ssdob;
006557230209              update auxfile;
006558230209             endif;
006559230209
006560211007              visible6 = '1';
006561211007               after = ds@hold;
006562211007              exsr hist;
006563211007             msg = 'Plan has been Created';
006564211007            exfmt msgWindow;
006565211007           endif;
006566211007         endif;
006567211007
006568210709        else;
006569220309         exsr ageBands;
006570210709         update planFile;
006571230209         chain (strust : ssub# : splan) auxFile;
006572230209         if %found;
006573230209          pxussp = ssdob;
006574230209          update auxfile;
006575230209         endif;
006576210709         after = ds@hold;
006577210709         exsr updateAux;
006578210716         exsr updateUHC;
006579210709         exsr hist;
006580211007         msg = 'Plan has been Updated';
006581210709         exfmt msgWindow;
006582210709        endif;
006583210709
006584210709       endsr;
006585210709
006586201221      //=======================================================================
006587201221      // histoty file;
006588201221      //=======================================================================
006589201221
006590201221       begsr hist;
006591201221
006592210709        if before <> after;
006593210709         hftrst = strust;
006594210709          hfsub# = ssub#;
006595210709           hfplan = splan;
006596210709            hjob = jobNumber;
006597210709            huserid = userName;
006598210709             hdate = %dec(%date());
006599210709            htime = %dec(%time());
006600210709           hbefore = before;
006601210709          hafter = after;
006602210709         write histFile;
006603210709        endif;
006604201221
006605201221       endsr;
006606210709
006607210709      //=======================================================================
006608210709      // update UHC files
006609210709      //=======================================================================
006610210709
006611210709       begsr updateUHC;
006612210709
006613210709        if not %open(uhcplancrt);
006614210709         open uhcplancrt;
006615210709        endif;
006616210709
006617210709        chain (pltrst : plsub# : pxacct : plplan) uhcPlncrt;
006618210709        if %found;
006619210716
006620210709         chain ('9000000290' : pltrst : plsub# : pxacct : plplan) uhcPlan;
006621210709         if %found;
006622210709
006623210709          if plncat = 'PMM';
006624210709           poss = %scan('(':pdescr:1);
006625210709
006626210709           if poss > 0;
006627210709            poss2 = %scan(')':pdescr:poss);
006628210709             lenght = poss2 - poss - 1;
006629210709             poss = poss + 1;
006630210709            cpcid5 = %subst(pdescr:poss:lenght);
006631210709           endif;
006632210709
006633210709           update uhcPlan;
006634210709          endif;
006635210709
006636210709         endif;
006637210709
006638210709        endif;
006639210709
006640210709        unlock carplnz;
006641210709        if %open(uhcplancrt);
006642210709         close uhcplancrt;
006643210709        endif;
006644210709
006645210709       endsr;
006646210709
006647210709      //=======================================================================
006648210709      // update plan auxiliary
006649210709      //=======================================================================
006650210709
006651210709       begsr updateAux;
006652210709
006653210709        chain scarriercd car2File;
006654210709        if %found;
006655230209
006656210709         chain (strust : ssub# : splan) auxFile;
006657210709         if %found;
006658210709          if c2acart = 'N' and (pxacar <> 'N');
006659230209            pxussp = ssdob;
006660230209            pxacar = 'N';
006661230209            pxussp = ssdob;
006662210709           update auxFile;
006663210709          else;
006664210709           if c2acart = 'Y' and (pxacar = 'N');
006665210709            pxacar = 'Y';
006666230209            pxussp = ssdob;
006667210709            update auxFile;
006668210709           endif;
006669210709          endif;
006670210709         endif;
006671210709
006672210709        endif;
006673210805
006674210709        unlock plnauxp;
006675210709
006676210709       endsr;
006677210709
006678210709      //=======================================================================
006679210709      // class
006680210709      //=======================================================================
006681210709
006682211007       begsr class1;
006683210709
006684210805        chain scarriercd carrFile;
006685220621        //if scarriercd in %list('CAB':'NAD':'NAE':'DAG':'GAL':'GAR')
006686220621        // or carbc = 'D';
006687210709
006688230314        if not(scarriercd in %list('BVP':'FAS':'HRA':'HRX':'HSA':'NHD':'NHM'
006689230314                                  :'NID':'NIM':'NRX':'HRI':'HRH':'HSI':'HSH'
006690230314                                  :'HXR':'NHB':'NHC':'AHC':'AHM':'AHB':'ABP'
006691230314                                  :'DNF':'PSM':'PSX'));
006692230314         clear @90;
006693230314         clear @parmDS;
006694230314         p@trs = strust;
006695230314         p@sub = ssub#;
006696230314         p@pln = splan;
006697230314         p@td = ' ';
006698230314         p@sd = ' ';
006699230314         p@pd = ' ';
006700230314         @90 = @parmDS;
006701230314
006702231226         #trust = %editc(strust:'X');
006703231226         #sub# = %editc(ssub#:'X');
006706240110         classScreen(#trust : #sub# : #kp);
006707230314         leavesr;
006708230314        endif;
006709230314
006710220621        if scarriercd in %list('BVP':'FAS':'HRA':'HRX':'HSA':'NHD':'NHM'
006711220621                              :'NID':'NIM':'NRX':'HRI':'HRH':'HSI':'HSH'
006712220621                              :'HXR':'NHB':'NHC':'AHC':'AHM':'AHB':'ABP'
006713220623                              :'DNF':'PSM':'PSX');
006714210709         clear @90;
006715210709         clear @parmDS;
006716210709         p@trs = strust;
006717210709         p@sub = ssub#;
006718210709         p@pln = splan;
006719210709         p@td = ' ';
006720210709         p@sd = ' ';
006721210709         p@pd = ' ';
006722210709         @90 = @parmDS;
006723210709
006724231226         #trust = %editc(strust:'X');
006725231226         #sub# = %editc(ssub#:'X');
006727240110         classScreen(#trust : #sub# : #kp);
006728210709        else;
006729210709         exfmt msgWindow2;
006730210709        endif;
006731210709
006732210709       endsr;
006733210709
006734210902      //=======================================================================
006735210902      // class 2
006736210902      //=======================================================================
006737210902
006738210902       begsr class2;
006739210902
006740211007        Need = 'N';
006741211007
006742210902        chain scarriercd carrFile;
006743220621        //if scarriercd in %list('CAB':'NAD':'NAE':'DAG':'GAL':'GAR')
006744220621        // or carbc = 'D';
006745210902
006746220621        if scarriercd in %list('BVP':'FAS':'HRA':'HRX':'HSA':'NHD':'NHM'
006747220621                              :'NID':'NIM':'NRX':'HRI':'HRH':'HSI':'HSH'
006748220621                              :'HXR':'NHB':'NHC':'AHC':'AHM':'AHB':'ABP'
006749220623                              :'DNF':'PSM':'PSX');
006750211007         need = 'Y';
006751210902         clear @90;
006752210902         clear @parmDS;
006753210902         p@trs = strust;
006754210902         p@sub = ssub#;
006755210902         p@pln = splan;
006756210902         p@td = ' ';
006757210902         p@sd = ' ';
006758210902         p@pd = ' ';
006759210902         @90 = @parmDS;
006760210902
006761231226         #trust = %editc(strust:'X');
006762231226         #sub# = %editc(ssub#:'X');
006764240110         classScreen(#trust : #sub# : #kp);
006765210902        endif;
006766210902
006767210902       endsr;
006768210902
006769220309      //=======================================================================
006770220309      // age bands
006771220309      //=======================================================================
006772220309
006773220309       begsr ageBands;
006774220309
006775220309        if sageband = 'R' or sageband = 'M';
006776220309
006777220309         clear ageBanding;
006778220309         btnAccept = '0';
006779220309
006780220309         spabf01 = pabf01;
006781220309         spabf02 = pabf02;
006782220309         spabf03 = pabf03;
006783220309         spabf04 = pabf04;
006784220309         spabf05 = pabf05;
006785220309         spabf06 = pabf06;
006786220309         spabf07 = pabf07;
006787220309         spabf08 = pabf08;
006788220309         spabf09 = pabf09;
006789220309         spabf10 = pabf10;
006790220309         spabf11 = pabf11;
006791220309         spabf12 = pabf12;
006792220309         spabf13 = pabf13;
006793220309         spabf14 = pabf14;
006794220309         spabf15 = pabf15;
006795220309         spabf16 = pabf16;
006796220309         spabf17 = pabf17;
006797220309         spabf18 = pabf18;
006798220309         spabf19 = pabf19;
006799220309         spabf20 = pabf20;
006800220309
006801220309         spabt01 = pabt01;
006802220309         spabt02 = pabt02;
006803220309         spabt03 = pabt03;
006804220309         spabt04 = pabt04;
006805220309         spabt05 = pabt05;
006806220309         spabt06 = pabt06;
006807220309         spabt07 = pabt07;
006808220309         spabt08 = pabt08;
006809220309         spabt09 = pabt09;
006810220309         spabt10 = pabt10;
006811220309         spabt11 = pabt11;
006812220309         spabt12 = pabt12;
006813220309         spabt13 = pabt13;
006814220309         spabt14 = pabt14;
006815220309         spabt15 = pabt15;
006816220309         spabt16 = pabt16;
006817220309         spabt17 = pabt17;
006818220309         spabt18 = pabt18;
006819220309         spabt19 = pabt19;
006820220309         spabt20 = pabt20;
006821220309
006822220309         dow btnAccept = '0';
006823220309
006824220309          exfmt ageBanding;
006825220309
006826220309          pabf01 = spabf01;
006827220309          pabf02 = spabf02;
006828220309          pabf03 = spabf03;
006829220309          pabf04 = spabf04;
006830220309          pabf05 = spabf05;
006831220309          pabf06 = spabf06;
006832220309          pabf07 = spabf07;
006833220309          pabf08 = spabf08;
006834220309          pabf09 = spabf09;
006835220309          pabf10 = spabf10;
006836220309          pabf11 = spabf11;
006837220309          pabf12 = spabf12;
006838220309          pabf13 = spabf13;
006839220309          pabf14 = spabf14;
006840220309          pabf15 = spabf15;
006841220309          pabf16 = spabf16;
006842220309          pabf17 = spabf17;
006843220309          pabf18 = spabf18;
006844220309          pabf19 = spabf19;
006845220309          pabf20 = spabf20;
006846220309
006847220309          pabt01 = spabt01;
006848220309          pabt02 = spabt02;
006849220309          pabt03 = spabt03;
006850220309          pabt04 = spabt04;
006851220309          pabt05 = spabt05;
006852220309          pabt06 = spabt06;
006853220309          pabt07 = spabt07;
006854220309          pabt08 = spabt08;
006855220309          pabt09 = spabt09;
006856220309          pabt10 = spabt10;
006857220309          pabt11 = spabt11;
006858220309          pabt12 = spabt12;
006859220309          pabt13 = spabt13;
006860220309          pabt14 = spabt14;
006861220309          pabt15 = spabt15;
006862220309          pabt16 = spabt16;
006863220309          pabt17 = spabt17;
006864220309          pabt18 = spabt18;
006865220309          pabt19 = spabt19;
006866220309          pabt20 = spabt20;
006867220309
006868220309         enddo;
006869220309
006870220309        endif;
006871220309
006872220309       endsr;
006873210716      //=======================================================================
006874210716      // invoice column
006875210716      //=======================================================================
006876210716
006877210716       begsr get_invoiceColumn;
006878210716
006879210716        chain (#kt : #ks) subFile;
006880210716        if %found;
006881210716          invcoldesc = %trim(ih1t) +
006882210716                       %trim(ih1b) + ',';
006883210716
006884210716          invcoldesc = %trim(invcoldesc) + ' ' +
006885210716                       %trim(ih2t) + ' ' + %trim(ih2b) + ',';
006886210716
006887210716          invcoldesc = %trim(invcoldesc) + ' ' +
006888210716                       %trim(ih3t) + ' ' + %trim(ih3b) + ',';
006889210716
006890210716          invcoldesc = %trim(invcoldesc) + ' ' +
006891210716                       %trim(ih4t) + ' ' + %trim(ih4b) + ',';
006892210716
006893210716          invcoldesc = %trim(invcoldesc) + ' ' +
006894210716                       %trim(ih5t) + ' ' + %trim(ih5b) + ',';
006895210716
006896210716          invcoldesc = %trim(invcoldesc) + ' ' +
006897210716                       %trim(ih6t) + ' ' + %trim(ih6b) + ',';
006898210716
006899210716          invcoldesc = %trim(invcoldesc) + ' ' +
006900210716                       %trim(ih7t) + ' ' + %trim(ih7b) + ',';
006901210716
006902210716          invcoldesc = %trim(invcoldesc) + ' ' +
006903210716                       %trim(ih8t) + ' ' + %trim(ih8b) + ',';
006904210716
006905210716          invcoldesc = %trim(invcoldesc) + ' ' +
006906210716                       %trim(ih9t) + ' ' + %trim(ih9b) + ',';
006907210716
006908210716        else;
006909210716         invcoldesc = 'Blue Choice,Blue Pref,Medical,BC/BS Dental,' +
006910210716                      'BC/BS Vision,Vision Dental,Life AD&D, STD LTD, Cobra';
006911210716        endif;
006912210716
006913210716       endsr;
006914210716
008701210805      //=======================================================================
008702230210      // plan category defaults
008703210805      //=======================================================================
008704210805
008705210805       begsr defaults;
008706210805
008707230210        errAnc = '0';
008708230210
008709230210        if ssalbased = 'Y' and scatdef <> 'Y';
008710230210         errAnc = '1';
008711230210          valid = '1';
008712230210           ssalbased = 'Y';
008713230210          visible4 = '0';
008714230210         leavesr;
008715230210        endif;
008716230210
008718210805        if action = 'A';
008719230209
008720230209         //ssdob = ' ';
008721230209
008722210805         if scatdef = 'Y';
008723210805          chain ('P' : splancd) catDef;
008724210805          if %found;
008725210805           sageband = dageb;
008726210902            //srndpre = drndprm;
008727210805             sdebcard = ddebtcard;
008728210805              sratetp = dratetype;
008729210805               sretfmt = dremfmt;
008730210805               sretper = dpercent * 10;
008731210805              ssubpln = dsubsidy;
008732220309             spcp = dpcp;
008733210805            scomppaid = dcompd;
008734210805           sgrrenfl = dsgrrem;
008735220309          endif;
008736210805
008737210805         endif;
008742210805
008743221202         if scatdef <> 'Y';
008744221202          sageband = 'N';
008745221202          scomppaid = 'N';
008746221202          visible4 = '0';
008747221202          ssalbased = ' ';
008751221202         endif;
008752221202
008753221202         //if scatdef <> 'Y';
008754221202         // sageband = ' ';
008755220617           //srndpre = ' ';
008756221202         //   sdebcard = ' ';
008757221202         //    sratetp = ' ';
008758221202         //     sretfmt = ' ';
008759221202         //     sretper = 0;
008760221202         //    ssubpln = ' ';
008761221202         //   spcp = ' ';
008762221202         //  scomppaid = ' ';
008763221202         // sgrrenfl = ' ';
008764221202         //endif;
008765210805
008766210805        endif;
008767210805
008768210805       endsr;
008769210805
008770210805      //=======================================================================
008800201221      // exit
008900201221      //=======================================================================
009000180323
009100180323       begsr exit;
009200180323
009300180323        *inlr = '1';
009400180323        return;
009500180323
009600180323       endsr;
009700180323
009800201221      //=======================================================================
009900180323      // init
010000201221      //=======================================================================
010100180323
010200180323       begsr init;
010300180323
010301211013        chain(n) (#kt : #ks : #kp) planFile;
010302211013        if not %found;
010303211013         clear screen1;
010304211013        endif;
010305211013
010600180323        btnExit = '0';
010602201221        btnHist = '0';
010603201221        btnAddUpd = '0';
010604201221
010800180323        pgmname = proc_name;
010801201221
010802210716        exportID = '0000000290';
010803201221
010806210706        strust = #kt;
010807210706        ssub# = #ks;
010808210706        splan = #kp;
010809210709
010810211013        //chain(n) (strust : ssub# : splan) planFile;
010814211013
010815210709        before = ds@hold;
010816210709
010817210709        trustList = %editc(strust:'X');
010818210709        visible3 = '0';
010819210716        chain strust trustFile;
010820210716        if %subst(tscode:3:1) in %list ('N' : 'M' : 'D');
010821210716        //if trustlist in %list('025':'026':'027':'028':'029':'030':
010822210716        //                      '031':'076':'080':'081':'082:''083');
010823210709         visible3 = '1';
010824210709        endif;
010825210706
010826221202        getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);
010827221202
011200180323       endsr;
011300180323
011400201221      //=======================================================================
