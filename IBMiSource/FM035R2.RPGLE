000001220808      *==================================================================================
000200180323     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000201220808      *==================================================================================
000400201221      * FM035R2 - Plan Auxiliary File Maintenance
000401220808      *==================================================================================
000600180326      * Date         Int  Description
000700220808      * ----------   ---  ---------------------------------------------------------------
000800201221      * 12/21/2020   jt   Original Creation
000801220610      * 06/10/2022   jt   Fix ISO dates update 8,0 fields as 010101 (from 0001-01-01)
000802220808      * 08/08/2022   jt   Allow trust 80, 81, 82, 83 and 84 to create plan without acct
000804230210      * 02/10/2023   jt   Removed Spouse DOB, is being done in plan master maint.
000805230316      * 03/16/2023   jt   Corrected leap year issue on To Date rate field
000900220808      *==================================================================================
001000210805
001100201221     ffm035d2   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001101201208
001102201221     fplnauxl2  uf a e           k disk    rename(plnauxr:mainFile)
001103210902
001104201221     ftrsmst    if   e           k disk    rename(trsmsr:trustFile)
001105201221     f                                     extfile('F.TRSMST')
001106201221
001107201221     fsubmst    if   e           k disk    rename(submsr:subFile)
001108201221     f                                     extfile('F.SUBMST')
001109201221
001110201221     fplnmst    if   e           k disk    rename(plnmsr:planFile)
001111201221     f                                     extfile('F.PLNMST')
001112201221
001113201221     faccmst    if   e           k disk    rename(accmsr:acctFile)
001114201221     f                                     extfile('F.ACCMST')
001115210716
001116201221     fplnaxhstp uf a e           k disk    rename(plnaxhstr:histFile)
001117201221
001118201221     fmcovl1    if   e           k disk    rename(mcovr:covFile)
001119201221     f                                     extfile('F.MCOVL1')
001120201221
001121210716     fgrate     uf a e           k disk    rename(grater:rateFile)
001122201221     f                                     extfile('F.GRATE')
001123201221
001124201221     fgrthist0  if a e             disk    rename(rgrthist:rateHist)
001125201221     f                                     extfile('F.GRTHIST0')
001126201221
001127201221     fcode20p   if   e           k disk    rename(code20f:codeFile)
001128201221
001129201221     fcarmst    if   e           k disk    rename(carmsr:carrFile)
001130201221     f                                     extfile('F.CARMST')
001131211007
001132211007     fcarmst2p  if   e           k disk    rename(carmst2r:car2File)
001136201208
001137201221     fcarplnl   uf   e           k disk    rename(carplnr:planSetup)
001138201221
001139220505     fcaraccp   if   e           k disk    rename(caraccr:acctSetup)
001140220505
001141220505     f*exagerate if   e           k disk    rename(exagerate:ageFile)
001142220505     fageratel1 if   e           k disk    rename(agerate:ageFile)
001143201221
001300201221      //=======================================================================
001400180323
001500180323     d psds           sds
001600201221     d  proc_name        *proc
001601201221     d  jobName              244    253
001602201221     d  userName             254    263
001603201221     d  jobNumber            264    269
001604201221
001605201221     d action          s              1
001606201221     d fieldAction     s             15
001607201221     d fromField       s             15
001608201221     d toField         s             15
001609201221     d sysdateymd      s               D
001610201221     d wkdat1          s               D
001611201221     d wkdat           s               D
001612201221     d wkdatmm         s              2  0
001613201221     d exportID        s             10
001614201221     d valid           s              1
001615201221     d cgrpcd2         s              2
001616220331     d pxborefdd       s              8  0
001617220331     d pxborlrdd       s              8  0
001618220505     d today           s               d
001620220505     d iso             s               d
001621220505     d currentMonth    s              2  0
001622220505     d carrKey         s            150
001623220505     D arkpln          s                   LIKE(RTPLNID)
001624220505     D arkcar          s                   LIKE(RTCARRIER) INZ(*BLANKS)
001625201221
001626210805     D                 DS
001627201221     D  ratdat                 1      8  0
001628201221     D   rdyyyy                1      4  0
001629201221     D   rdmm                  5      6  0
001630201221     D   rddd                  7      8  0
001700180323
001701201221     d auxHist         pr                  ExtPgm('FM035R3')
001702201221     d  kt#                           3  0 const
001703201221     d  ks#                           3  0 const
001704201221     d  kp#                           4    const
001705201221
001706230208     d e1envir         s             15
001707230208     d e1libl          s             10
001708230208     d e1Lib2          s             10
001709230208     d envColor        s             10
001710230208     d e1Acnm          s             40
001711230208
001712230208     d getEnv          pr                  ExtPgm('GETENVR')
001713230208     d  e1envir                      15
001714230208     d  e1libl                       10
001715230208     d  e1Lib2                       10
001716230208     d  envColor                     10
001717230208     d  e1Acnm                       40
001718230208
002103201221     d fm035r2         pi
002104201221     d  #kt                           3  0
002105201221     d  #ks                           3  0
002106201221     d  #kp                           4
002107201221     d  #ka                           4  0
002108210805     d  #status                       1
002109220331     d  #carrier                      3
002110220331     d  #catcode                      2
002111220505     d  #month                        2
002113201208
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
003501210716        exsr loadFields;
003502210716
003600180323        dow btnExit = '0';
003700180323
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
004577210716         auxHist(#kt : #ks : #kp);
004578201221         btnHist = '0';
004579201221        endif;
004580201221
004581201221        if btnAddUpd = '1';
004582201221         exsr AddUpd;
004583201221         btnAddUpd = '0';
004584201221        endif;
004585201221
004586201208       endsr;
004587201208
004600201221      //=======================================================================
004700201208      // load fields
004800201221      //=======================================================================
004900180323
005000201208       begsr loadFields;
005100180323
005101201221        if #ka > 0;
005102201221         chain(n) (%dec(#kt:3:0): %dec(#ks:3:0) : #kp : %dec(#ka:4:0)) plnauxl2;
005103201221        else;
005104201221         chain(n) (%dec(#kt:3:0) : %dec(#ks:3:0) : #kp) plnauxl2;
005105201221        endif;
005106201221        if %found;
005107201221
005108201221         colorPrt = '#FF0000';
005109201221         tspProtect = '1';
005111210805         action = 'U';
005112201221         updadd = 'Update';
005113201221
005114210805         strust = #kt;
005115210805         chain #kt trustFile;
005116201221         if %found;
005117201221          strustname = tname;
005118201221         endif;
005119201221
005120210805         ssub# = #ks;
005121210805         chain (#kt : #ks) subFile;
005123201221         if %found;
005124201221          ssubname = subnam;
005125201221         endif;
005126201221
005127210805         splan = #kp;
005128210805         chain (#kt : #ks : #kp) planFile;
005129201221         if %found;
005130201221          splandesc = pdescr;
005131201221         endif;
005132201221
005133201221         sacct = pxacct;
005134210805         chain (#kt : #ks : pxacct) acctFile;
005135201221         if %found;
005136201221          sacctname = acnam1;
005137201221         endif;
005138201221
005139201221         swaitp = pxwtpd;
005140211013
005141201221         swtdy = pxwtdy;
005142201221
005143201221         sdnotes = pxwtdn;
005144220331         //if pxwtdn = ' ';
005145220331         // sdnotes = 'N';
005146220331         //endif;
005147201221
005148201221         srwpd = pxrhdy;
005149201221         srhire = pxrhwd;
005150201221         srhirewp = pxrhpd;
005151201221         stermdc = pxtrmc;
005152201221         sempcon = pxecon;
005153201221
005154201221         sptele = pxptyn;
005155220331         sfhours = pxptlo;
005156220331         sthours = pxpthi;
005157220331
005158220331         //if pxptyn = ' ';
005159220331         // sptele = 'N';
005160220331         //endif;
005161201221
005162201221         sdepmaxa = pxdpmx;
005163201221         sdepends = pxdpcd;
005164201221         sgroup# = pxgroup;
005165201221         scarent = pxcfsen;
005166201221         scarid = pxcarpln;
005167201221
005168201221         sexchange = pxexchg;
005169220331         //if pxexchg = ' ';
005170220331         // sexchange = 'N';
005171220331         //endif;
005172201221
005173220331         exsr acaRating2;
005174211007
005175220309         select;
005176220309          when swaitp = ' ';
005177220309           monthDays = 'Months/Days';
005178220309          when swaitp = 'FFM';
005180220309           monthDays = 'Months';
005181220309          when swaitp <> 'FFM';
005182220309           monthDays = 'Days';
005183220309         endsl;
005212220309
005213201221         //if pxacar = ' ';
005214201221         // sacarat = 'N';
005215201221         //endif;
005216201221
005217201221         if pxborefd > 0;
005218201221          sboredate = %date(pxborefd:*iso);
005219220309         endif;
005220201221
005221220309         if pxborlrd > 0;
005222201221          sborlrdate = %date(pxborlrd:*iso);
005223201221         endif;
005224201221
005225201221         smult = pxmpcd;
005226201221
005228220331         //if pxussp = ' ';
005229220331         // ssdob = 'N';
005230220331         //endif;
005231201221
005232201221         sshowweb = pxshww;
005233220331         //if pxshww =' ';
005234220331         // sshowweb = 'N';
005235220331         //endif;
005236201221
005237201221         sstvr = pxdpsv;
005238220331         //if pxdpsv = ' ';
005239220331         // sstvr = 'N';
005240220331         //endif;
005241201221
005242201221         sftmaxa = pxstmx;
005243201221
005244201221        else;
005246201221         clear screen1;
005247230208         getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);
005248220331         btnExit = '0';
005249220331         exsr acaRating;
005250210805         colorPrt = '#FF0000';
005251210805         tspProtect = '1';
005252210716         strust = #kt;
005253210716         ssub# = #ks;
005254210716         splan = #kp;
005255210716         sacct = #ka;
005256201221         action = 'A';
005257201221         updadd = 'Add';
005258210902         sexchange = 'N';
005259210902         sshowweb = 'Y';
005260220331         srhirewp = 'RNA';
005261220331         stermdc = 'TEM';
005262220331         sptele = 'N';
005263220331         sdepmaxa = 26;
005264220331         sdepends = 'EOM';
005265220331         //sacarat = 'Y';
005266220331         sstvr = 'N';
005268220331         smult = ' ';
005269220331         sdnotes = 'N';
005270220331
005271210902         pgmname = proc_name;
005272220309         monthDays = 'Months/Days';
005273201221        endif;
005274201208
005602201208       endsr;
005700180323
005701201221      //=======================================================================
005702201221      // Add/Update
005703201221      //=======================================================================
005704201221
005705201221       begsr AddUpd;
005706201221
005712201221        chain (strust : ssub# : splan) plnauxl2;
005713201221        if not %found;
005714201221         action = 'A';
005715201221        else;
005716201221         action = 'U';
005717201221        endif;
005718201221
005719201221        if pxtrst <> strust;
005720201221
005721201221         exsr validRcd;
005722201221         if valid = '1';
005723201221          leavesr;
005724201221         endif;
005725201221
005726201221         fieldAction = 'Trust';
005727201221          fromField = %editc(pxtrst:'X');
005728201221           toField = %editc(strust:'X');
005729201221          pxtrst = strust;
005730201221          #kt = strust;
005731201221         exsr hist;
005732201221        endif;
005733201221
005734201221        if pxsub# <> ssub#;
005735201221
005736201221         exsr validRcd;
005737201221         if valid = '1';
005738201221          leavesr;
005739201221         endif;
005740201221
005741201221         fieldAction = 'Sub#';
005742201221          fromField = %editc(pxsub#:'X');
005743201221           toField = %editc(ssub#:'X');
005744201221          pxsub# = ssub#;
005745201221          #ks = ssub#;
005746201221         exsr hist;
005747201221        endif;
005748201221
005749201221        if pxplan <> splan;
005750201221
005751201221         exsr validRcd;
005752201221         if valid = '1';
005753201221          leavesr;
005754201221         endif;
005755201221
005756201221         fieldAction = 'Plan';
005757201221          fromField = pxplan;
005758201221           toField = splan;
005759201221          pxplan = splan;
005760201221          #kp = splan;
005761201221         exsr hist;
005762201221        endif;
005763201221
005764201221        if pxacct <> sacct;
005765201221
005766201221         exsr validRcd;
005767201221         if valid = '1';
005768201221          leavesr;
005769201221         endif;
005770201221
005771201221         fieldAction = 'Acct';
005772201221          fromField = %editc(pxacct:'X');
005773201221           toField = %editc(sacct:'X');
005774201221          pxacct = sacct;
005775201221          #ka = sacct;
005776201221         exsr hist;
005777201221        endif;
005778201221
005779201221        if pxwtpd <> swaitp;
005780201221
005781201221         exsr validRcd;
005782201221         if valid = '1';
005783201221          leavesr;
005784201221         endif;
005785201221
005786201221         fieldAction = 'Wait Period';
005787201221          fromField = pxwtpd;
005788201221           toField = swaitp;
005789201221          pxwtpd = swaitp;
005790201221         exsr hist;
005791201221        endif;
005792201221
005793201221        if pxwtdy <> swtdy;
005794201221         fieldAction = 'Wait Prd. Days';
005795201221          fromField = %editc(pxwtdy:'X');
005796201221           toField = %editc(swtdy:'X');
005797201221          pxwtdy = swtdy;
005798201221         exsr hist;
005799201221        endif;
005800201221
005801201221        if pxwtdn <> sdnotes;
005802201221         fieldAction = 'See Dairy Notes';
005803201221          fromField = pxwtdn;
005804201221           toField = sdnotes;
005805201221          pxwtdn = sdnotes;
005806201221         exsr hist;
005807201221        endif;
005808201221
005809201221        if pxrhwd <> srhire;
005810201221         fieldAction = 'Rehire Within';
005811201221          fromField = %editc(pxrhwd:'X');
005812201221           toField = %editc(srhire:'X');
005813201221          pxrhwd = srhire;
005814201221         exsr hist;
005815201221        endif;
005816201221
005817201221        if pxrhpd <> srhirewp;
005818201221         fieldAction = 'Rh Waiting Prd.';
005819201221          fromField = pxrhpd;
005820201221           toField = srhirewp;
005821201221          pxrhpd = srhirewp;
005822201221         exsr hist;
005823201221        endif;
005824201221
005825201221        if pxrhdy <> srwpd;
005826201221         fieldAction = 'Rh Wait PrdDays';
005827201221          fromField = %editc(pxrhdy:'X');
005828201221           toField = %editc(srwpd:'X');
005829201221          pxrhdy = srwpd;
005830201221         exsr hist;
005831201221        endif;
005832201221
005833201221        if pxtrmc <> stermdc;
005834201221         fieldAction = 'Term Date Code';
005835201221          fromField = pxtrmc;
005836201221           toField = stermdc;
005837201221          pxtrmc = stermdc;
005838201221         exsr hist;
005839201221        endif;
005840201221
005841201221        if pxecon <> sempcon;
005842201221
005843201221         exsr validRcd;
005844201221         if valid = '1';
005845201221          leavesr;
005846201221         endif;
005847201221
005848201221         fieldAction = 'Emp Contr %';
005849201221          fromField = %editc(pxecon:'X');
005850201221           toField = %editc(sempcon:'X');
005851201221          pxecon = sempcon;
005852201221         exsr hist;
005853201221        endif;
005854201221
005855201221        if pxptyn <> sptele;
005856201221
005857201221         exsr validRcd;
005858201221         if valid = '1';
005859201221          leavesr;
005860201221         endif;
005861201221
005862201221         fieldAction = 'Part Time';
005863201221          fromField = pxptyn;
005864201221           toField = sptele;
005865201221          pxptyn = sptele;
005866201221         exsr hist;
005867201221        endif;
005868201221
005869220331        if pxptlo <> sfhours;
005870220331         fieldAction = 'From Hours';
005871220331          fromField = %editc(pxptlo:'X');
005872220331           toField = %editc(sfhours:'X');
005873220331          pxptlo = sfhours;
005874220331         exsr hist;
005875220331        endif;
005876220331
005877220331        if pxpthi <> sthours;
005878220331         fieldAction = 'To Hours';
005879220331          fromField = %editc(pxpthi:'X');
005880220331           toField = %editc(sthours:'X');
005881220331          pxpthi = sthours;
005882220331         exsr hist;
005883220331        endif;
005884220331
005885201221        if pxdpmx <> sdepmaxa;
005886201221         fieldAction = 'Dep. Max Age';
005887201221          fromField = %editc(pxdpmx:'X');
005888201221           toField = %editc(sdepmaxa:'X');
005889201221          pxdpmx = sdepmaxa;
005890201221         exsr hist;
005891201221        endif;
005892201221
005893201221        if pxdpcd <> sdepends;
005894201221         fieldAction = 'Dep End Cov.';
005895201221          fromField = pxdpcd;
005896201221           toField = sdepends;
005897201221          pxdpcd = sdepends;
005898201221         exsr hist;
005899201221        endif;
005900201221
005901201221        if pxgroup <> sgroup#;
005902201221
005903201221         exsr validRcd;
005904201221         if valid = '1';
005905201221          leavesr;
005906201221         endif;
005907201221
005908201221         fieldAction = 'Group #';
005909201221          fromField = pxgroup;
005910201221           toField = sgroup#;
005911201221           pxgroup = sgroup#;
005912201221          exsr hist;
005913201221         exsr updGroup#;
005914201221        endif;
005915201221
005916201221        if pxcfsen <> scarent;
005917201221         fieldAction = 'Carrier Entity';
005918201221          fromField = pxcfsen;
005919201221           toField = scarent;
005920201221          pxcfsen = scarent;
005921201221         exsr hist;
005922201221        endif;
005923201221
005924201221        if pxcarpln <> scarid;
005925201221
005926201221         exsr validRcd;
005927201221         if valid = '1';
005928201221          leavesr;
005929201221         endif;
005930201221
005931201221         fieldAction = 'Carrier Plan ID';
005932201221          fromField = pxcarpln;
005933201221           toField = scarid;
005934201221          pxcarpln = scarid;
005935201221         exsr hist;
005936201221        endif;
005937201221
005938201221        if pxexchg <> sexchange;
005939201221         fieldAction = 'Exchange';
005940201221          fromField = pxexchg;
005941201221           toField = sexchange;
005942201221          pxexchg = sexchange;
005943201221         exsr hist;
005944201221        endif;
005945201221
005946220331        if visibleF = '1';
005947220331         if pxacar <> sacarat2;
005948220331          fieldAction = 'ACA Rating';
005949220331           fromField = pxacar;
005950220331            toField = sacarat2;
005951220331            pxacar = sacarat2;
005952220331           exsr hist;
005953220331          exsr updateMapping;
005954220331         endif;
005955220331        endif;
005956201221
005957220331        if visibleD = '1';
005958220331         if pxacar <> sacarat;
005959220331          fieldAction = 'ACA Rating';
005960220331           fromField = pxacar;
005961220331            toField = sacarat;
005962220331            pxacar = sacarat;
005963220331           exsr hist;
005964220331          exsr updateMapping;
005965220331         endif;
005966220331        endif;
005967220331
005968220610        //monitor;
005969220610        // pxborefdd = %dec(sboredate);
005970220610        //on-error;
005971220610        // pxborefdd = 0;
005972220610        //endmon;
005973220331
005975220610        if sboredate > d'0001-01-01';
005976220610         pxborefdd = %dec(sboredate);
005977230208        else;
005978230208         pxborefdd = 0;
005979230208         pxborefd = 0;
005980230208        endif;
005982220610
005983220610        //on-error;
005984220610        // pxborefdd = 0;
005985220610        //endmon;
005986220610
005987220331        if pxborefd <> pxborefdd;
005988220331        //if pxborlrd <> %dec(sboredate);
005989201221
005990201221         exsr validRcd;
005991201221         if valid = '1';
005992201221          leavesr;
005993201221         endif;
005994201221
005995201221         fieldAction = 'BOR Eff Date';
005996201221          fromField = %char(pxborefd);
005997201221           toField = %char(sboredate);
005998201221          pxborefd = %dec(sboredate);
005999201221         exsr hist;
006000201221        endif;
006001220331
006003220610        //monitor;
006004220610        // pxborlrdd = %dec(sborlrdate);
006005220610        //on-error;
006006220610        // pxborlrdd = 0;
006007220610        //endmon;
006008220331
006009220610        if sborlrdate > d'0001-01-01';
006010220610         pxborlrdd = %dec(sborlrdate);
006011230208        else;
006012230208         pxborlrdd = 0;
006013230208         pxborlrd = 0;
006014230208        endif;
006016220610
006017220331        if pxborlrd <> pxborlrdd;
006018220331        //if pxborlrd <> %dec(sborlrdate);
006019201221
006020201221         exsr validRcd;
006021201221         if valid = '1';
006022201221          leavesr;
006023201221         endif;
006024201221
006025201221         fieldAction = 'BOR Lst Re-Date';
006026201221          fromField = %char(pxborlrd);
006027201221           toField = %char(sborlrdate);
006028201221          pxborlrd = %dec(sborlrdate);
006029201221         exsr hist;
006030201221        endif;
006031201221
006032201221        if pxmpcd <> smult;
006033201221         fieldAction = 'Mult/Conv PBV';
006034201221          fromField = pxmpcd;
006035201221           toField = smult;
006036201221          pxmpcd = smult;
006037201221         exsr hist;
006038201221        endif;
006039201221
006048201221        if pxshww <> sshowweb;
006049201221         fieldAction = 'Show on Web';
006050201221          fromField = pxshww;
006051201221           toField = sshowweb;
006052201221          pxshww = sshowweb;
006053201221         exsr hist;
006054201221        endif;
006055201221
006056201221        if pxdpsv <> sstvr;
006057201221
006058201221         exsr validRcd;
006059201221         if valid = '1';
006060201221          leavesr;
006061201221         endif;
006062201221
006063201221         fieldAction = 'Std Verry Rqd';
006064201221          fromField = pxdpsv;
006065201221           toField = sstvr;
006066201221          pxdpsv = sstvr;
006067201221         exsr hist;
006068201221        endif;
006069201221
006070201221        if pxstmx <> sftmaxa;
006071201221         fieldAction = 'FT Max Age';
006072201221          fromField = %editc(pxstmx:'X');
006073201221           toField = %editc(sftmaxa:'X');
006074201221          pxstmx = sftmaxa;
006075201221         exsr hist;
006076201221        endif;
006077201221
006078201221        select;
006079201221         when action = 'A';
006080220331          exsr createRating;
006081210805          exsr Hist;
006082201221          write mainFile;
006083210805          msg = 'Record has been Created';
006084201221          exfmt msgWindow;
006085210805          #status = '0';
006086201221
006087201221         when action = 'U';
006088201221          msg = 'Record has been Updated';
006089201221          update mainFile;
006090201221          exfmt msgWindow;
006091201221        endsl;
006092201221
006093220331        if action = 'A';
006094220331         exsr histW;
006095220331        endif;
006096220331
006097201221       endsr;
006098201221
006099201221      //=======================================================================
006100220505      // validate
006101201221      //=======================================================================
006102201221
006103201221       begsr validRcd;
006104201221
006105201221        valid = '0';
006106201221        errTrst = '0';
006107201221        errSub# = '0';
006108210805        //errPlan = '0';
006109201221        errAcct = '0';
006110201221        errWtngPer = '0';
006111201221        errEcont = '0';
006112201221        errFhours = '0';
006113201221        errThours = '0';
006114201221        errMaxage = '0';
006115201221        errMaxag2 = '0';
006116201221        errGroup = '0';
006117201221        errDate = '0';
006118201221        errDate2 = '0';
006119201221        errCarrid = '0';
006120220505        errCarrid2 = '0';
006121211013        errDairy = '0';
006122220331        errWp = '0';
006123220331        errTDC = '0';
006124220331        errPTE = '0';
006125201221
006126210805        //chain strust trustFile;
006127210805        //if not %found;
006128210805        // errTrst = '1';
006129210805        //  valid = '1';
006130210805        // leavesr;
006131210805        //endif;
006132201221
006133210805        //chain (strust : ssub#) subFile;
006134210805        //if not %found;
006135210805        // errSub# = '1';
006136210805        //  valid = '1';
006137210805        // leavesr;
006138210805        //endif;
006139201221
006140210805        //chain (strust : ssub# : splan) planFile;
006141210805        //if not %found;
006142210805        // errPlan = '1';
006143210805        //  valid = '1';
006144210805        // leavesr;
006145210805        //endif;
006146201221
006147220808        if not(#kt in %list(80:81:82:83:84));
006148220808        //if #kt = 80 or #kt = 81 or #kt = 82 or #kt = 83 or #kt = 84;
006149220808        //else;
006150220808         chain (#kt : #ks : sacct) acctFile;
006151220808         if not %found;
006152220808          errAcct = '1';
006153220808           valid = '1';
006154220808          leavesr;
006155220808         endif;
006156220808        endif;
006157201221
006158201221        if sdnotes <> 'Y';
006159211013         //if swaitp = ' ';
006160211013         // errWtngPer = '1';
006161211013         //  valid = '1';
006162211013         // leavesr;
006163211013         //endif;
006164201221        endif;
006165220808
006166211013        if swaitp = ' ' and sdnotes <> 'Y';
006167220331         //errDairy = '1';
006168220331         // valid = '1';
006169220331         //leavesr;
006170211013        endif;
006171211013
006172211013        if sempcon > 100;
006173201221         errEcont = '1';
006174220331          valid = '1';
006175201221         leavesr;
006176201221        endif;
006177201221
006178201221        if sptele = 'Y' and sfhours = 0;
006179201221         errFhours = '1';
006180201221          valid = '1';
006181201221         leavesr;
006182201221        endif;
006183201221
006184201221        if sptele = 'Y' and sthours = 0;
006185201221         errThours = '1';
006186220331          valid = '1';
006187201221         leavesr;
006188201221        endif;
006189201221
006190201221        if sstvr = 'Y' and sftmaxa = 0;
006191201221         errMaxage = '1';
006192201221          valid = '1';
006193201221         leavesr;
006194201221        endif;
006195201221
006196201221        if sstvr = 'N' and sftmaxa > 0;
006197201221         errMaxag2 = '1';
006198201221          valid = '1';
006199201221         leavesr;
006200201221        endif;
006201201221
006202201221        if strust <> 5;
006203201221         if (sgroup# > ' ' and scarid = ' ') or
006204201221            (sgroup# = ' ' and scarid > ' ');
006205220331            //errGroup = '1';
006206201221           valid = '1';
006207201221          leavesr;
006208201221         endif;
006209201221        endif;
006210201221
006211220505        if #carrier = 'AHM' or #carrier  = 'ABP' or #carrier = 'AHC' or
006212220505         #carrier = 'AHB' or #carrier = 'AUM' or #carrier = 'AAM' or
006213220505         #carrier = 'AKP' or #carrier = 'KA' or #carrier = 'KP';
006214220505         if scarid > ' ' and sacarat <> 'N';
006215220505          chain #carrier carrFile;
006216220505          cgrpcd2 = cgrpcd;
006217220505
006218220505           chain ('RATE CARR ' : cgrpcd2) codeFile;
006219220505           if not %found;
006220220505            errCarrid2 = '1';
006221220505            valid = '1';
006222220505            leavesr;
006223220505           else;
006224220505            if c20actn1 <> 'ENTITY';
006225220505             arkcar= c20actn1;
006226220505            else;
006227220505             select;
006228220505              when scarent = 'A';
006229220505               arkcar = 'BLUEC';
006230220505              when scarent = 'B';
006231220505               arkcar = 'CFMI';
006232220505              when scarent = 'C';
006233220505               arkcar = 'GHMSI';
006234220505             endsl;
006235220505            endif;
006236220505           endif;
006237220505          arkpln = scarid;
006238220505          chain (arkcar : arkpln) ageFile;
006239220505          if not %found;
006240220505           errCarrid2 = '1';
006241220505            valid = '1';
006242220505           leavesr;
006243220505          endif;
006244220505         endif;
006245220505        endif;
006246201221
006247220331        //if sboredate > sborlrdate;
006248220331        // errDate2 = '1';
006249220331        //  valid = '1';
006250220331        // leavesr;
006251220331        //endif;
006252220331
006253201221        if (sboredate > d'0001-01-01' and sborlrdate = d'0001-01-01') or
006254201221           (sboredate = d'0001-01-01' and sborlrdate > d'0001-01-01');
006255201221            errDate = '1';
006256201221          valid = '1';
006257201221         leavesr;
006258201221        endif;
006259201221
006260220331        //if srhirewp = ' ';
006261220331        // errWp = '1';
006262220331        //  valid = '1';
006263220331        // leavesr;
006264220331        //endif;
006265220331
006266220331        if stermdc = ' ';
006267220331         errTDC = '1';
006268220331          valid = '1';
006269220331         leavesr;
006270220331        endif;
006271220331
006272220331        if sptele = ' ';
006273220331         errPTE = '1';
006274220331          valid = '1';
006275220331         leavesr;
006276220331        endif;
006277220331
006278201221       endsr;
006279201221
006280201221      //=======================================================================
006281201221      // histoty file;
006282201221      //=======================================================================
006283201221
006284201221       begsr hist;
006285201221
006286201221        if action = 'U';
006287201221         axtrst = pxtrst;
006288201221          axsub# = pxsub#;
006289201221           axplan = pxplan;
006290201221            axuser = userName;
006291201221             axdate = %dec(%date());
006292201221             axtime = %dec(%time());
006293201221             axtype = 'C';
006294201221            axfld = fieldAction;
006295201221           axfrom = fromField;
006296201221          axto = toField;
006297201221         write histFile;
006298201221        endif;
006299201221
006300201221       endsr;
006301201221
006302220331      //=======================================================================
006303220331      // histoty file;
006304220331      //=======================================================================
006305220331
006306220331       begsr histW;
006307220331
006308220331        axtrst = pxtrst;
006309220331        axsub# = pxsub#;
006310220331        axplan = pxplan;
006311220331        axuser = userName;
006312220331        axdate = %dec(%date());
006313220331        axtime = %dec(%time());
006314220331        axtype = 'A';
006315220331
006316220331        write histFile;
006317220331
006318220331       endsr;
006319220331
006320201221      //=======================================================================
006321201221      // update group#
006322201221      //=======================================================================
006323201221
006324201221       begsr updGroup#;
006325201221
006326201221        if action = 'U';
006327201221
006328210716         setll (#kt : #ks : #kp) rateFile;
006329210716         reade (#kt : #ks : #kp) rateFile;
006330201221         dow not %eof;
006331201221
006332201221          if pxgroup <> group# and netrte = 0;
006333201221           group# = pxgroup;
006334201221           update rateFile;
006335201221          endif;
006336201221
006337210716         reade (#kt : #ks : #kp) rateFile;
006338201221         enddo;
006339201221
006340201221        endif;
006341220331
006342201221       endsr;
006343201221
006344201221      //=======================================================================
006345201221      // create rating
006346201221      //=======================================================================
006347201221
006348201221       begsr createRating;
006349201221
006350201221        if action = 'A';
006351220331
006352220331         if sacarat <> 'N';
006353220513
006354220513          if #catcode = 'MM';
006355201221
006356220513           clear rateFile;
006357220331
006358220513           grtrst = pxtrst;
006359220513           grsub# = pxsub#;
006360220513           grplan = pxplan;
006361220513           group# = pxgroup;
006362220513           grdltd = 'A';
006363220505
006364220513           exsr determineYear;
006365201221
006366220513           rdmm = %dec(#month:2:0);
006367220513           rddd = 01;
006368220505
006369220513           frmdat = ratdat;
006370230316           //iso = %date(%dec(ratdat:8:0)) - %days(1);
006371230316           //iso = iso + %years(1);
006372230316           iso = %date(%dec(ratdat:8:0)) + %years(1);
006373230316           iso = iso - %days(1);
006374220513           todat = %dec(iso);
006375220513           //wkdat = sysdateymd;
006376220505
006377220505
006378201221
006379220505     C****                   extrct    wkdat1:*M     wkdatmm
006380201221
006381220505         //if wkdatmm > prenew;
006382220505     C****                   adddur    01:*Y         wkdat
006383220505         //endif;
006384201221
006385220505     C****                   move      wkdat         frmdat
006386220505     C****                   adddur    01:*Y         wkdat
006387220505     C****                   subdur    01:*D         wkdat
006388220505     C****                   move      wkdat         todat
006389220331
006390220331     C****               move      #KY           rdyyyy
006391220331     C****               eval      rddd = 01
006392220331     C****               move      ratdat        wkdat
006393220331     C****               move      wkdat         frmdat
006394220331     C****               adddur    01:*Y         wkdat
006395220331     C****               subdur    01:*D         wkdat
006396220331     C****               move      wkdat         todat
006397201221
006398220505         //iso = %date(%dec(ratdat:8:0));
006399220505         //eom = (iso + %months(1)) - %days(%subdt(iso + %Months(1):*days));
006400220505         //fonm = iso - %days(%subdt(iso:*days)-1) + %months(1);
006401220505
006402220505
006403220505         //if pxborefd <> 0 and pxborefd <> frmdat;
006404220505         // frmdat = pxborefd;
006405220505         //endif;
006406201221
006407220513           typecd = 'TIN';
006408220513           write rateFile;
006409220513           exsr write_ratingHist;
006410220513
006411220513           typecd = 'TPC';
006412220513           write rateFile;
006413220513           exsr write_ratingHist;
006414220513
006415220513           typecd = 'TP2';
006416220513           write rateFile;
006417220513           exsr write_ratingHist;
006418220513
006419220513           typecd = 'THW';
006420220513           write rateFile;
006421220513           exsr write_ratingHist;
006422220513
006423220513           typecd = 'TFA';
006424220513           write rateFile;
006425220513           exsr write_ratingHist;
006426220513
006427220513          endif;
006428220331
006429220513         endif;
006430220513
006431201221        endif;
006432201221
006433201221       endsr;
006434201221
006435201221      //=======================================================================
006436201221      // write rating histoty record
006437201221      //=======================================================================
006438201221
006439201221       begsr write_ratingHist;
006440201221
006441201221         clear rateHist;
006442201221
006443201221         hftrst = grtrst;
006444201221         hfsub# = grsub#;
006445201221         hfplan = grplan;
006446201221
006447201221         hfuserid = userName;
006448201221         hfdate = %dec(%date);
006449201221         hftime = %dec(%time);
006450201221         hfjobnam = jobName;
006451201221         hfjobnbr = jobNumber;
006452201221
006453201221         hfaffrdt = frmdat;
006454201221         hfaftodt = todat;
006455201221         hfafagbn = agebnd;
006456201221         hfafdltc = grdltd;
006457201221         hfaftycd = typecd;
006458201221         hfafbilr = bilrte;
006459201221         hfafnetr = netrte;
006460201221         hfafgrp# = group#;
006461201221
006462201221         write rateHist;
006463201221
006464201221       endsr;
006465201221
006466201221      //=======================================================================
006467211007      // aca rating
006468201221      //=======================================================================
006469201221
006470220331       begsr acaRating;
006471211007
006472220331        visibleD = '0';
006473220331        visibleF = '1';
006474220331        sacarat2 = 'N';
006475220331
006476220331        if #catcode  = 'MM';
006477220331
006478220331         if #carrier = 'AHM' or #carrier = 'ABP' or #carrier = 'AHC'
006479220331          or #carrier = 'AHB'  or #carrier = 'AUM' or #carrier = 'AAM'
006480220331           or #carrier = 'AKP' or #carrier = 'KA' or #carrier = 'KP';
006481220331            visibleD = '1';
006482220331           visibleF = '0';
006483220331          sacarat = 'Y';
006484220331         endif;
006485220331        //else;
006486220331        // visibleD = '0';
006487220331        // visibleF = '1';
006488220331        // sacarat2 = 'N';
006489220331        endif;
006490220331
006491201221       endsr;
006492201221
006493220331      //=======================================================================
006494220331      // aca rating
006495220331      //=======================================================================
006496220331
006497220331       begsr acaRating2;
006498220331
006499220331        sacarat = pxacar;
006500220331        sacarat2 = pxacar;
006501220331
006502220331        visibleD = '0';
006503220331        visibleF = '1';
006504220331
006505220331        if #catcode  = 'MM';
006506220331         if #carrier = 'AHM' or #carrier = 'ABP' or #carrier = 'AHC'
006507220331          or #carrier = 'AHB'  or #carrier = 'AUM' or #carrier = 'AAM'
006508220331           or #carrier = 'AKP' or #carrier = 'KA' or #carrier = 'KP';
006509220331            visibleD = '1';
006510220331           visibleF = '0';
006511220331         endif;
006512220331        endif;
006513220331
006514220331       endsr;
006515220331
006516220331      //=======================================================================
006517211007      // update mapping files
006518220331      //=======================================================================
006519211007
006520211007       begsr updateMapping;
006521211007
006522211007        if pxacar  = 'Y';
006523211007
006524211007         setll (exportid : #kt : #ks : #kp : sacct) planSetup;
006525211007         reade (exportid : #kt : #ks : #kp : sacct) planSetup;
006526211007         dow not %eof;
006527211007
006528211007          chain (exportID : pxtrst : pxsub# : pxacct) acctSetup;
006529211007          if %found;
006530211007           if cacid6 = 'GBSEDIPRIME';
006531211007            cpcid7 = pxgroup;
006532211007            update planSetup;
006533211007           endif;
006534211007          endif;
006535211007
006536211007         reade (exportid : #kt : #ks : #kp : sacct) planSetup;
006537211007         enddo;
006538211007
006539211007        endif;
006540211007
006541211007       endsr;
006542211007
006543220505      //=======================================================================
006544220505      // determine uear to use for rating file
006545220505      //=======================================================================
006546220505
006547220505       begsr determineYear;
006548220505
006549220505        ratdat = %dec(%date);
006550220505        currentMonth = %subdt(today:*months);
006551220505        if %dec(#month:2:0) < currentMonth;
006552220505         rdyyyy = rdyyyy + 1;
006553220505        endif;
006554220505
006555220505       endsr;
006556220505
006557211007      //=======================================================================
006558220505      // disable Carrier Plan ID
006559211007      //=======================================================================
006560211007
006561211007       begsr dis_carrierID;
006562211007
006563220513        //visCarrid = '1';
006564211007
006565211007        setll (#kt : #ks : #kp) covFile;
006566211007        reade (#kt : #ks : #kp) covFile;
006567211007        dow not %eof;
006568211007
006569211007         if enrldt <> candt;
006570211007          visCarrid = '0';
006571211007          leavesr;
006572211007         endif;
006573211007
006574211007        reade (#kt : #ks : #kp) covFile;
006575211007        enddo;
006576211007
006577211007       endsr;
006578211007
008700201221      //=======================================================================
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
010600180323        btnExit = '0';
010601201221        btnHist = '0';
010602201221        btnAddUpd = '0';
010603210805        #status = '1';
010604201221
010800180323        pgmname = proc_name;
010801201221
010802201221        exportID = '0000000290';
010803201221
010804201221        exsr dis_carrierID;
010805201221
010806201221        chain (#kt : #ks : #kp) planFile;
010807201221        chain pcarr carrFile;
010808220505
010809220505        today = %date;
010810230208
010811230208        getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);
010812220505
011200180323       endsr;
011300180323
011400201221      //=======================================================================
