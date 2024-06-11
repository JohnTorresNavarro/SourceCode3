000100210805      *========================================================================
000200210709     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300201221      *========================================================================
000400220823      * FM080R2 - Carrier Master File Maintenance
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700201208      * ----------   ---  -----------------------------------------------------
000800220721      * 07/21/2022   jt   Original Creation
000801230320      * 03/20/2023   jt   Recompiled for screen change. Added parm to FM080R3
000802230407      * 04/07/2023   jt   Changed loading of zip code (failed when zip code
000803230407      *                   started with a 0).
000900180326      *========================================================================
001000180628
001100220823     ffm080d2   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001101201208
001104220810     fcarmst    uf a e           k disk    rename(carmsr:carrFile)
001105220810     f                                     extfile('F.CARMST')
001106220721
001107220829     fcarmst2p  uf a e           k disk    rename(carmst2r:carr2File)
001108220810
001109220810     fsubcar    uf a e           k disk    rename(subcarr:stcbrFile)
001110220810
001111220823     fcpayad    if   e           k disk    rename(cpayar:claimsFile)
001112220823     f                                     extfile('F.CPAYAD')
001113220823
001114220829     fcarmksz1  if   e           k disk    rename(rcarmksz:marketFile)
001115220829     f                                     extfile('F.CARMKSZ1')
001116220829
001117220829     fadmnfee1  if   e           k disk    rename(radmnfee:adminFile)
001118220829     f                                     extfile('F.ADMNFEE1')
001119220829
001120220829     fbonusdr1  if   e           k disk    rename(rbonusdr:bunusFile)
001121220829     f                                     extfile('F.BONUSDR1')
001122220829
001123220829     fbrkrcom1  if   e           k disk    rename(rbrkrcom:brokerFile)
001124220829     f                                     extfile('F.BRKRCOM1')
001125220829
001126230320     fprrule    if   e           k disk    rename(prrulr:ruleFile)
001127230320     f                                     extfile('F.PRRULE')
001128230320
001300201221      //=======================================================================
001400180323
001500180323     d psds           sds
001600201221     d  proc_name        *proc
001601201221     d  jobName              244    253
001602201221     d  userName             254    263
001603201221     d  jobNumber            264    269
001604220823
001605220823     d wddta         e ds           345    extname(CPAYAD)
001606220823     d  inCarr2                1      3
001607210709
001612220721     d process         s              1
001618201221     d valid           s              1
001619220721     d strustc         s              3
001621220721     d trstc           s              3
001624210706     d cancel          s              1
001625220721     d changed         s              1
001626220721     d continue        s              1
001627220810     d valid2          s              1
001628220810     d found@          s              2  0
001629220810     d foundCom        s              2  0
001630220810     d foundNet        s              2  0
001631220810     d foundOrg        s              2  0
001632220810     d foundGov        s              2  0
001633220823     d foundEdu        s              2  0
001634220823     d parm1           s              8
001635220823     d parm2           s              8
001636220823     d parm5           s             60
001638220810     d e1envir         s             15
001639220810     d e1libl          s             10
001640220810     d e1Lib2          s             10
001641220810     d envColor        s             10
001642220810     d e1Acnm          s             40
001643220829     d marketAdded     s              1
001644220829     d adminAdded      s              1
001645220829     d bonusAdded      s              1
001646220829     d brokerAdded     s              1
001647220829     d qualAdded       s              1
001648220829     d czipchar        s              9
001650220829     d czipchar4       s              4
001651230320     d inquiry         s              1
001652220810
001653220810     d getEnv          pr                  ExtPgm('GETENVR')
001654220810     d  e1envir                      15
001655220810     d  e1libl                       10
001656220810     d  e1Lib2                       10
001657220810     d  envColor                     10
001658220810     d  e1Acnm                       40
001659220810
001714220823     d adminFee        pr                  ExtPgm('FM081CL')
001715220823     d  inCarr                        3
001718210716
001719220823     d bonusDraw       pr                  ExtPgm('FM082CL')
001720220823     d  inCarr                        3
001721220823
001722220823     d brokerComm      pr                  ExtPgm('FM083CL')
001723220823     d  inCarr                        3
001724220823
001725220823     d marketSize      pr                  ExtPgm('FM084CL')
001726220823     d  inCarr                        3
001727220823
001728220823     d eventRules      pr                  ExtPgm('FM080R3')
001729220823     d  inCarr                        3
001731220823     d  sc2coneml                    50
001732220823     d  sc2820                        1
001733220823     d  sc2remit                      1
001734220823     d  sc2acart                      1
001735220823     d  sc2pcpopt                     1
001736220823     d  sc2exchg                      1
001738220823     d  qualAdded                     1
001739230320     d  inquiry                       1
001740220823
001741220823     d claimsPay       pr                  ExtPgm('CHGCPA')
001742220823     d  parm1                         8
001743220823     d  parm2                         8
001744220823     d  pgmnam                       10
001745220823     d  wddta                       345
001746220823     d  parm5                        60
001747220823
001748220721     d ChkPgmAuth      pr                  extpgm('CHKPGMAUTH')
001749220721     d  pgmname                      10
001750220721     d  continue                      1
001751220721
002103220823     d fm080r2         pi
002104220810     d  inCarr                        3
002105220721     d  inMode                        1
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
004661210805
004662220810        //if buttonCode = '1';
004663220810        // getCode(trstc : 'O' : cancel);
004664220810        //  if trstc > ' ';
004665220810        //   strstct = trstc;
004666220810        //  endif;
004667220810        //  buttonCode = '0';
004668220810        //leavesr;
004669220810        //endif;
004670220721
004671220721        if btnGreen = '1';
004672220721         exsr validRcd;
004673220721         if valid = '0';
004674220721          exsr moveFields;
004675220721         endif;
004676220721         btnGreen = '0';
004677220721        endif;
004678220721
004679220810        if btnCancel = '1';
004680220810         exsr deleteRestore;
004681220810         btnCancel = '0';
004683220810        endif;
004686220810
004687220823        if btnAdmin = '1';
004688220823         adminFee(inCarr);
004689220823         btnAdmin = '0';
004690220823        endif;
004691220823
004692220823        if btnBonus = '1';
004693220823         bonusDraw(inCarr);
004694220823         btnBonus = '0';
004695220823        endif;
004696220823
004697220823        if btnBroker = '1';
004698220823         brokerComm(inCarr);
004699220823         btnBroker = '0';
004700220823        endif;
004701220823
004702220823        if btnMarket = '1';
004703220823         marketSize(inCarr);
004704220823         btnMarket = '0';
004705220823        endif;
004706220823
004707220823        if btnClaim = '1';
004708220823         exsr claims;
004709220823         btnClaim = '0';
004710220823        endif;
004711220823
004712220823        if btnEvent = '1';
004713220829         unlock carmst2p;
004714230320         inquiry = inMode;
004715220823         eventRules(inCarr:sc2coneml:sc2820:sc2remit:sc2acart:sc2pcpopt
004716230320                    :sc2exchg:qualAdded:inquiry);
004723220823         btnEvent = '0';
004724220823        endif;
004725220823
004726201208       endsr;
004727201208
004728201221      //=======================================================================
004729210716      // load fields
004800201221      //=======================================================================
004900180323
005000201208       begsr loadFields;
005100180323
005101230322        if inMode = 'I';
005102230322         chain(n) scarrcd carrFile;
005103230322        else;
005104230322         chain scarrcd carrFile;
005105230322        endif;
005106210716        if %found;
005107220810         scname = cname;
005108220810         scnamec = cnamec;
005109220810         scaddr1 = caddr1;
005110220810         scaddr2 = caddr2;
005111220810         sccity = ccity;
005112220810         scstate = cstate;
005113220829
005114220829         if czip > 0;
005115230407          czipchar = %editc(czip:'X');
005116230407          sczip1 = %subst(czipchar:1:5);
005117230407          sczip2 = %subst(czipchar:6:4);
005118230407          //sczip1 = %subst(%char(czip):1:5);
005119230407          //sczip2 = %subst(%char(czip):6:4);
005120220829         endif;
005121220829
005122220810         sccntct = ccntct;
005123220810         scarea = carea;
005124220810         scphone = cphone;
005125220810         scprrul = cprrul;
005126220810         scwebd = cwebd;
005127220810         scgrpcd = cgrpcd;
005128220810         scapdty = capdty;
005129220810         scarbc = carbc;
005130220810         scomsch = comsch;
005131220810         scthresh = cthresh;
005132220810         scgaonly = cgaonly;
005133220810         scapbcc = capbcc;
005134220810         scapbpc = capbpc;
005135220810
005136230322         if inMode = 'I';
005137230322          chain(n) scarrcd carr2File;
005138230322         else;
005139230322          chain scarrcd carr2File;
005140230322         endif;
005141230322
005142220810         if %found;
005143220810          sc2coneml = c2coneml;
005144220810          sc2820 = c2820;
005145220810          sc2remit = c2remit;
005146220810          sc2acart = c2acart;
005147220810          sc2pcpopt = c2pcpopt;
005148220810          sc2exchg = c2exchg;
005149220810         endif;
005150220810
005151230322         if inMode = 'I';
005152230322          chain(n) scarrcd stcbrFile;
005153230322         else;
005154230322          chain scarrcd stcbrFile;
005155230322         endif;
005156230322
005157220810         if %found;
005158220810          sscpart = scpart;
005159220810         endif;
005160230320
005161230320         chain cprrul ruleFile;
005162230320         if %found;
005163230320          ruledesc = rldsc;
005164230320         endif;
005165220810
005166210716        endif;
005167210716
005602201208       endsr;
005700180323
006127220721
006128201221      //=======================================================================
006129210706      // valid record
006130201221      //=======================================================================
006131201221
006132210716       begsr validRcd;
006133220721
006134220721        valid = '0';
006135220810        errCarr = '0';
006136220810        errCarrNm = '0';
006451220810        errAddr = '0';
006452220810        errCity = '0';
006453220810        errState = '0';
006454220810        errZip = '0';
006455220810        errRemName = '0';
006456220810        errEmail = '0';
006457220810        errArea = '0';
006458220810        errPhone = '0';
006459220810        errPro = '0';
006460220810        err820 = '0';
006461220810        errGrpCode = '0';
006462220810        errComm = '0';
006463220810        errRemit = '0';
006464220810        errAbr = '0';
006465220810        errPdty = '0';
006466220810        errRThresh = '0';
006467220810        errPcp = '0';
006468220810        errACA = '0';
006469220810        errExch = '0';
006470220810
006471230322        if inMode = 'I';
006472230322         chain(n) scarrcd carrFile;
006473230322        else;
006474230322         chain scarrcd carrFile;
006475230322        endif;
006476230322
006477220810        if process = 'W';
006478220810         if %found or scarrcd = ' ';
006479220810          errCarr = '1';
006480220810           valid = '1';
006481220810          leavesr;
006482220810         endif;
006483220810        endif;
006484220810
006485220810        if scname = ' ';
006486220810         errCarrNm = '1';
006487220810          valid = '1';
006488220810         leavesr;
006491220810        endif;
006492220810
006493220810        if scaddr1 = ' ';
006494220810         errAddr = '1';
006495220810          valid = '1';
006496220810         leavesr;
006497220810        endif;
006499220810
006500220810        if sccity = ' ';
006501220810         errCity = '1';
006502220810          valid = '1';
006503220810         leavesr;
006504220810        endif;
006505220810
006506220810        if scstate = ' ';
006507220810         errState = '1';
006508220810          valid = '1';
006509220810         leavesr;
006510220810        endif;
006511220810
006513220829        if sczip1 = ' ';
006514220829         errZip = '1';
006515220810          valid = '1';
006516220810         leavesr;
006517220810        endif;
006518220810
006519220810        if sccntct = ' ';
006520220810         errRemName = '1';
006521220810          valid = '1';
006522220810         leavesr;
006523220810        endif;
006524220810
006525220810        exsr validEmail;
006530220810        if valid2 = '1';
006531220810         errEmail = '1';
006532220810          valid = '1';
006533220810         leavesr;
006534220810        endif;
006536220810
006537220810        if scarea = 0;
006538220810         errArea = '1';
006539220810          valid = '1';
006540220810         leavesr;
006541220810        endif;
006542220810
006543220810        if scphone = 0;
006544220810         errPhone = '1';
006545220810          valid = '1';
006546220810         leavesr;
006547220810        endif;
006548220810
006549221010        //if scprrul = ' ';
006550221010        // errPro = '1';
006551221010        //  valid = '1';
006552221010        // leavesr;
006553221010        //endif;
006554220810
006555221010        if sc2820 = ' ';
006556220810         err820 = '1';
006557220810          valid = '1';
006558220810         leavesr;
006559220810        endif;
006560220810
006561220810        if scgrpcd = ' ';
006562220810         errGrpCode = '1';
006563220810          valid = '1';
006564220810         leavesr;
006565220810        endif;
006566220810
006567220810        if scomsch = ' ';
006568220810         errComm = '1';
006569220810          valid = '1';
006570220810         leavesr;
006571220810        endif;
006572220810
006573220810        if sc2remit = ' ';
006574220810         errRemit = '1';
006575220810          valid = '1';
006576220810         leavesr;
006577220810        endif;
006578220810
006579220810        if scarbc = ' ';
006580220810         errAbr = '1';
006581220810          valid = '1';
006582220810         leavesr;
006583220810        endif;
006584220810
006585220810        if scapdty = ' ';
006586220810         errPdty = '1';
006587220810          valid = '1';
006588220810         leavesr;
006589220810        endif;
006590220810
006591220810        if scthresh = 0;
006592220810         errRThresh = '1';
006593220810          valid = '1';
006594220810         leavesr;
006595220810        endif;
006596220810
006597220810        if sc2pcpopt = ' ';
006598220810         errPcp = '1';
006599220810          valid = '1';
006600220810         leavesr;
006601220810        endif;
006602220810
006603220810        if sc2acart = ' ';
006604220810         errACA = '1';
006605220810          valid = '1';
006606220810         leavesr;
006607220810        endif;
006608220810
006609220810        if sc2exchg = ' ';
006610220810         errExch = '1';
006611220810          valid = '1';
006612220810         leavesr;
006613220810        endif;
006614220810
006615220721       endsr;
006616201221
006617220810      //========================================================================
006618220810      // validate email
006619220810      //========================================================================
006620220810
006621220810        begsr validEmail;
006622220810
006623220810         valid2 = '1';
006624220810         found@ = 0;
006625220810         foundCom = 0;
006626220810         foundNet = 0;
006627220810         foundOrg = 0;
006628220810
006629220810         found@ = %scan('@':sc2coneml);
006630220810         if found@ = 0;
006631220810          valid2 = '1';
006632220810          leavesr;
006633220810         endif;
006634220810
006635220810         valid2 = '1';
006636220810
006637220810         foundCom = %scan('.com':sc2coneml);
006638220810         if foundCom > 0;
006639220810          valid2 = '0';
006640220810          leavesr;
006641220810         endif;
006642220810
006643220810         foundNet = %scan('.net':sc2coneml);
006644220810         if foundNet > 0;
006645220810          valid2 = '0';
006646220810          leavesr;
006647220810         endif;
006648220810
006649220810         foundOrg = %scan('.org':sc2coneml);
006650220810         if foundOrg > 0;
006651220810          valid2 = '0';
006652220810          leavesr;
006653220810         endif;
006654220810
006655220810         foundEdu = %scan('.edu':sc2coneml);
006656220810         if foundEdu > 0;
006657220810          valid2 = '0';
006658220810          leavesr;
006659220810         endif;
006660220810
006661220810         foundGov = %scan('.gov':sc2coneml);
006662220810         if foundGov > 0;
006663220810          valid2 = '0';
006664220810          leavesr;
006665220810         endif;
006666220810
006667220810        endsr;
006668220810
006669210706      //=======================================================================
006670220810      // delete/restore record
006671210706      //=======================================================================
006672210706
006673220810       begsr deleteRestore;
006674220810
006675220810        if cadltd = 'D' or cadltd = ' ';
006676220810         cadltd = 'A';
006677220810          AddUpdate = '1';
006678220810           DltRst = '1';
006679220810            btnDelete = 'Delete';
006680220810            btnText = 'Update';
006681220901            tspProtect = '0';
006682220901           tspProtec2 = '1';
006683220901          process = 'U';
006684220810         update carrFile;
006685220810
006686220810        else;
006687220810
006688220810         cadltd = 'D';
006689220810          AddUpdate = '0';
006690220810           DltRst = '1';
006691220810           btnDelete = 'Restore';
006692220901           tspProtect = '1';
006693220901          process = 'U';
006694220810         update carrFile;
006695220810        endif;
006696220810
006697220810        exsr loadFields;
006698220810
006699220810       endsr;
006700210706
006701220721      //=======================================================================
006702220721      // move fields
006703220721      //=======================================================================
006704220721
006705220721       begsr moveFields;
006706220810
006754220823        if process = 'U';
006755220901         exsr updateCarr;
006756220901          exsr updateCarr2;
006757220901           exsr updateSubCarr;
006761220823           msg = 'Record Updated';
006762220823          msg2 = ' ';
006763220823         exfmt msgWindow;
006764220823        else;
006765220823
006766220823         exsr screens;
006767220829         if marketAdded = 'Y' and adminAdded = 'Y' and
006768220829          bonusAdded = 'Y' and brokerAdded = 'Y';
006769220901           exsr writeCarr;
006770220901            exsr writeCarr2;
006771220901             exsr writeSubCarr;
006772220901             process = 'U';
006773220823             msg = 'Record Added';
006774220823            msg2 = ' ';
006775220823           exfmt msgWindow;
006776220823          else;
006777220829           select;
006778220829            when marketAdded = 'N';
006779220829             msg = 'Market Sizes';
006780220829             msg2 = 'Must be Added 1st';
006781220829             exfmt msgWindow;
006782220829
006783220829            when adminAdded = 'N';
006784220829             msg = 'Admnin Fee';
006785220829             msg2 = 'Must be Added 1st';
006786220829             exfmt msgWindow;
006787220829
006788220829            when bonusAdded = 'N';
006789220829             msg = 'Bonus Draw';
006790220829             msg2 = 'Must be Added 1st';
006791220829             exfmt msgWindow;
006792220829
006793220901            when brokerAdded = 'N';
006794220829             msg = 'Broker Comm';
006795220829             msg2 = 'Must be Added 1st';
006796220829             exfmt msgWindow;
006797220829           endsl;
006798220823         endif;
006799220823
006800220823        endif;
006801220721
006802220721       endsr;
006803220721
006804220901      //=======================================================================
006805220901      // carrier master
006806220901      //=======================================================================
006807220901
006808220901       begsr updateCarr;
006809220901
006810220901        chain inCarr carrFile;
006811220901        if %found;
006812220901        carrcd = inCarr;
006813220901        cname = scname;
006814220901        cnamec = scnamec;
006815220901        caddr1 = scaddr1;
006816220901        caddr2 = scaddr2;
006817220901        ccity = sccity;
006818220901        cstate = scstate;
006819220901        ccntct = sccntct;
006820220901        carea = scarea;
006821220901        cphone = scphone;
006822220901        cprrul = scprrul;
006823220901        cwebd = scwebd;
006824220901        cgrpcd = scgrpcd;
006825220901        capdty = scapdty;
006826220901        carbc = scarbc;
006827220901        comsch = scomsch;
006828220901        cthresh = scthresh;
006829220901        cgaonly = scgaonly;
006830220901        capbcc = scapbcc;
006831220901        capbpc = scapbpc;
006832220901
006833220901        czipchar4 = '0000';
006834220901        if sczip2 > '0000';
006835220901         czipchar4 = sczip2;
006836220901        endif;
006837220901
006838230407        czipchar = ' ';
006839230407        czipchar = sczip1 + czipchar4;
006840220901        czip = %dec(czipchar:9:0);
006841220901
006842220901        update carrFile;
006843220901
006844220901        endif;
006845220901
006846220901       endsr;
006847220901
006848220901      //=======================================================================
006849220901      // carrier master 2
006850220901      //=======================================================================
006851220901
006852220901       begsr updateCarr2;
006853220901
006854220901        chain inCarr carr2File;
006855220901        if %found;
006856220901         c2carcd = inCarr;
006857220901          c2coneml = sc2coneml;
006858220901           c2820 = sc2820;
006859220901            c2remit = sc2remit;
006860220901            c2acart = sc2acart;
006861220901           c2pcpopt = sc2pcpopt;
006862220901          c2exchg = sc2exchg;
006863220901
006864220901         update carr2File;
006865220901        endif;
006885220901
006888220901       endsr;
006889220901
006890220901      //=======================================================================
006891220901      // sub carrier
006892220901      //=======================================================================
006893220901
006894220901       begsr updateSubCarr;
006895220901
006896220901        chain inCarr stcbrFile;
006897220901        if %found;
006898220901         sccarr = inCarr;
006899220901          scpart = sscpart;
006900220901         update stcbrFile;
006901220901        endif;
006909220901
006910220901       endsr;
006911220901
006912220901      //=======================================================================
006913220901      // carrier master
006914220901      //=======================================================================
006915220901
006916220901       begsr writeCarr;
006917220901
006920220901        carrcd = inCarr;
006921220901        cname = scname;
006922220901        cnamec = scnamec;
006923220901        caddr1 = scaddr1;
006924220901        caddr2 = scaddr2;
006925220901        ccity = sccity;
006926220901        cstate = scstate;
006927220901        ccntct = sccntct;
006928220901        carea = scarea;
006929220901        cphone = scphone;
006930220901        cprrul = scprrul;
006931220901        cwebd = scwebd;
006932220901        cgrpcd = scgrpcd;
006933220901        capdty = scapdty;
006934220901        carbc = scarbc;
006935220901        comsch = scomsch;
006936220901        cthresh = scthresh;
006937220901        cgaonly = scgaonly;
006938220901        capbcc = scapbcc;
006939220901        capbpc = scapbpc;
006940220901
006941220901        czipchar4 = '0000';
006942220901        if sczip2 > '0000';
006943220901         czipchar4 = sczip2;
006944220901        endif;
006945220901
006946230407        czipchar = ' ';
006947220901        czipchar = sczip1 + czipchar4;
006948220901        czip = %dec(czipchar:9:0);
006949220901
006950220901        write carrFile;
006951220901
006953220901       endsr;
006954220901
006955220901      //=======================================================================
006956220901      // carrier master 2
006957220901      //=======================================================================
006958220901
006959220901       begsr writeCarr2;
006960220901
006963220901        c2carcd = inCarr;
006964220901        c2coneml = sc2coneml;
006965220901        c2820 = sc2820;
006966220901        c2remit = sc2remit;
006967220901        c2acart = sc2acart;
006968220901        c2pcpopt = sc2pcpopt;
006969220901        c2exchg = sc2exchg;
006970220901
006971220901        write carr2File;
006973220901
006974220901       endsr;
006975220901
006976220901      //=======================================================================
006977220901      // sub carrier
006978220901      //=======================================================================
006979220901
006980220901       begsr writeSubCarr;
006981220901
006984220901        sccarr = inCarr;
006985220901        scpart = sscpart;
006986220901
006987220901        write stcbrFile;
006988220901
006989220901       endsr;
006990220901
006991220823      //=======================================================================
006992220823      // claims
006993220823      //=======================================================================
006994220823
006995220823       begsr claims;
006996220823
006997220823        clear wddta;
006998220823        chain inCarr claimsFile;
006999220823        inCarr2 = inCarr;
007000220823        parm5 = 'X 03    ';
007001220829        unlock carmst;
007002220823        if %found;
007003220823         parm1 = 'CHANGE';
007004220823         parm2 = 'CHANGE';
007005220823         claimsPay(parm1 : parm2 : pgmname : wddta : parm5);
007006220823        else;
007007220823         parm1 = 'ADD';
007008220823         parm2 = '   P    ';
007009220823         claimsPay(parm1 : parm2 : pgmname : wddta : parm5);
007010220823        endif;
007011220823
007012220829        pgmname = proc_name;
007013220829
007014220823       endsr;
007015220823
007016220823      //=======================================================================
007017220823      // claims
007018220823      //=======================================================================
007019220823
007020220823       begsr screens;
007021220823
007022220829        marketAdded = 'N';
007023220829        adminAdded = 'N';
007024220829        bonusAdded = 'N';
007025220829        brokerAdded = 'N';
007026220829
007027220829        chain incarr marketFile;
007028220829        if not %found;
007029220829         marketSize(inCarr);
007030220901         chain inCarr marketFile;
007031220901         if %found;
007032220901          marketAdded = 'Y';
007033220901         endif;
007034220829        else;
007035220829         marketAdded = 'Y';
007036220829        endif;
007037220829
007038220901        chain incarr adminFile;
007039220829        if not %found;
007040220829         adminFee(inCarr);
007041220901         chain incarr adminFile;
007042220901         if %found;
007043220901           adminAdded = 'Y';
007044220901         endif;
007045220829        else;
007046220829         adminAdded = 'Y';
007047220829        endif;
007048220829
007049220829        chain incarr bunusFile;
007050220829        if not %found;
007051220829         bonusDraw(inCarr);
007052220901         chain incarr bunusFile;
007053220901         if %found;
007054220901          bonusAdded = 'Y';
007055220901         endif;
007056220829        else;
007057220829         bonusAdded = 'Y';
007058220829        endif;
007059220829
007060220829        chain incarr brokerFile;
007061220829        if not %found;
007062220829         brokerComm(inCarr);
007063220901         chain incarr brokerFile;
007064220901         if %found;
007065220901          brokerAdded = 'Y';
007066220901         endif;
007067220829        else;
007068220829         brokerAdded = 'Y';
007069220829        endif;
007070220829
007071220829        //eventRules(inCarr:sc2coneml:sc2820:sc2remit:sc2acart:sc2pcpopt
007072220829        //           :sc2exchg:qualAdded);
007073220829        //exsr claims;
007074220823
007075220823       endsr;
007076220823
008760210805      //=======================================================================
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
010301220810        chain inCarr carrFile;
010302211013        if not %found;
010303211013         clear screen1;
010304220810          AddUpdate = '1';
010305220810           tspProtect = '0';
010306220823           tspProtec2 = '1';
010307220810           DltRst = '0';
010308220810          btnText = 'Add';
010309220810         process = 'W';
010310220810        endif;
010311220721
010312220721        if %found;
010313220810         if cadltd = 'D' or cadltd = ' ';
010314220810          tspProtect = '1';
010315220810           tspProtec2 = '1';
010316220810            AddUpdate = '0';
010317220810            DltRst = '1';
010318220810           btnDelete = 'Restore';
010319220810          process = 'U';
010320220810         endif;
010321220810        endif;
010322211013
010323220721        if %found;
010324220810         if cadltd = 'A';
010325220810          tspProtec2 = '1';
010326220829           tspProtect = '0';
010327220810            btnText = 'Update';
010328220810             btnDelete = 'Delete';
010329220810            AddUpdate = '1';
010330220810           DltRst = '1';
010331220810          process = 'U';
010332220810         endif;
010333220810        endif;
010334220721
010600180323        btnExit = '0';
010603220721        btnGreen = '0';
010604201221
010800180323        pgmname = proc_name;
010801201221
010806220810        scarrcd = inCarr;
010816220721
010819220810        //AddUpdate = '1';
010820220810        //DltRst = '1';
010821220810        if inMode = 'I';
010822220810         AddUpdate = '0';
010823220810          DltRst = '0';
010824220810         tspProtect = '1';
010825230417        else;
010826230417         tspProtect = '0';
010828220810        endif;
010829220721
010830220829        //if inMode = 'M';
010831220829        // ChkPgmAuth(pgmname : continue);
010832220829        // if continue = 'N';
010833220829        //  exsr exit;
010834220829        // endif;
010835220829        //endif;
010836220810
010837220810        getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);
010838220810
011200180323       endsr;
011300180323
011400201221      //=======================================================================
