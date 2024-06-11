000100210716      *========================================================================
000200220420     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300201221      *========================================================================
000400220516      * FI035R2 - Plan Auxiliary File Maintenance (Display Only).
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700201208      * ----------   ---  -----------------------------------------------------
000800220516      * 04/21/2022   jt   Original Creation
000801220516      * 05/16/2022   jt   Added warning window when no plan auxiliary rcd exits.
000802220516      * 05/19/2022   jt   Added additional warning when plan is COBRA
000803220608      * 06/08/2022   jt   Eliminated COBRA warning message.
000804240206      * 02/06/2024   jt   Combiled fields srhirewp, srhirewpds and srwpd into
000805240206      *                   one field to display better in screen
000900180326      *========================================================================
001000210805
001100220420     ffi035d2   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001101201208
001102220420     fplnauxl2  if   e           k disk    rename(plnauxr:mainFile)
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
001129201221     fcarmst    if   e           k disk    rename(carmsr:carrFile)
001130201221     f                                     extfile('F.CARMST')
001131211007
001132211007     fcarmst2p  if   e           k disk    rename(carmst2r:car2File)
001136201208
001300201221      //=======================================================================
001400180323
001500180323     d psds           sds
001600201221     d  proc_name        *proc
001601201221     d  jobName              244    253
001602201221     d  userName             254    263
001603201221     d  jobNumber            264    269
001604201221
001605201221     d action          s              1
001606240206     d srhirewpds      s             30
001616201221
001701201221     d auxHist         pr                  ExtPgm('FM035R3')
001702201221     d  kt#                           3  0 const
001703201221     d  ks#                           3  0 const
001704201221     d  kp#                           4    const
001705201221
002103220420     d fi035r2         pi
002104201221     d  #kt                           3  0
002105201221     d  #ks                           3  0
002106201221     d  #kp                           4
002107201221     d  #ka                           4  0
002109201208
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
003600220420        dow btnBack = '0';
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
004572220420        if btnBack = '1';
004573201208         leavesr;
004574201208        endif;
004575201208
004576220420        if btnHist = '1';
004577220420         auxHist(#kt : #ks : #kp);
004578220420         btnHist = '0';
004579220420        endif;
004580220516
004587201208       endsr;
004588201208
004600201221      //=======================================================================
004700201208      // load fields
004800201221      //=======================================================================
004900180323
005000201208       begsr loadFields;
005100180323
005101220420        clear screen1;
005102220420
005103220420        pgmname = proc_name;
005104220420        btnBack = '0';
005105220420
005106201221        if #ka > 0;
005107220420         chain (%dec(#kt:3:0): %dec(#ks:3:0) : #kp : %dec(#ka:4:0)) plnauxl2;
005108201221        else;
005109220420         chain (%dec(#kt:3:0) : %dec(#ks:3:0) : #kp) plnauxl2;
005110201221        endif;
005115201221        if %found;
005116201221
005117210805         action = 'U';
005118201221
005119220420         pltrst = #kt;
005120210805         chain #kt trustFile;
005121201221         if %found;
005122220420          tdescr = tname;
005123201221         endif;
005124201221
005125220420         plsub# = #ks;
005126220420         chain (#kt : #ks) subFile;
005127201221         if %found;
005128220420          subdsc = subnam;
005129201221         endif;
005130201221
005131220420         plplan = #kp;
005132210805         chain (#kt : #ks : #kp) planFile;
005133201221         if %found;
005134220420          //splandesc = pdescr;
005135201221         endif;
005136201221
005137220420         pacct = pxacct;
005138210805         chain (#kt : #ks : pxacct) acctFile;
005139201221         if %found;
005140220420          //acnam1 = acnam1;
005141201221         endif;
005142201221
005143201221         swaitp = pxwtpd;
005144220420         select;
005145220420          when swaitp = 'N/A';
005146220420           swaitpd = 'NOT APPLICABLE';
005147220420
005148220420          when swaitp = 'DOH';
005149220420           swaitpd = 'DATE OF HIRE PLUS';
005150220420
005151220420          when swaitp = 'FAD';
005152220420           swaitpd = '1st OF MON AFTER DOH +';
005153220420
005154220420          when swaitp = 'FFD';
005155220420           swaitpd = '1st OF MON FOLLOW DOH +';
005156220420
005157220420          when swaitp = 'DAD';
005158220420           swaitpd = '1st DAY AFTER DOH +';
005159220420
005160220420          when swaitp = 'DFD';
005161220420           swaitpd = '1st DAY FOLLOW DOH +';
005162220420
005163220420          when swaitp = 'FFM';
005164220420           swaitpd = '1st OF MON FOLLOW +';
005165220420         endsl;
005166211013
005167220420         swtdy = %editc(pxwtdy:'X');
005168201221
005169220420         sdnotes = pxwtdn;
005170201221         srhire = pxrhwd;
005171220420
005172240206         //srhirewp = pxrhpd;
005173220420         select;
005174240206          when pxrhpd = 'RDH';
005175220420           srhirewpds = 'DATE OF REHIRE PLUS';
005176220420
005177240206          when pxrhpd = 'RFM';
005178220420           srhirewpds = 'FIRST OF MONTH FOLLOW DOR +';
005179220420
005180240206          when pxrhpd = 'RFF';
005181220420           srhirewpds = ' FIRST DAY FOLLOWING';
005182220420
005183240206          when pxrhpd = 'RNA';
005184220420           srhirewpds = 'N/A';
005185220420         endsl;
005186220420
005187240206         //srwpd = pxrhdy;
005188240206
005189240206         //srhirewpt = srhirewp + '  ' + %trim(srhirewpds) + ' ' +
005190240206         //            %trim(%char(srwpd)) + ' ' + ('Days');
005191240206         srhirewpt = pxrhpd + '  ' + %trim(srhirewpds) + ' ' +
005192240206                     %trim(%char(pxrhdy)) + ' ' + ('Days');
005193240206
005194220420         ///rwpd = pxrhdy;
005195220420
005196201221         stermdc = pxtrmc;
005197220420         select;
005198220420          when stermdc = 'TAD';
005199220420           stermdesc = 'ACTUAL DATE OF TERMINATION';
005200220420
005201220420          when stermdc = 'TEM';
005202220420           stermdesc = 'EOM FOLLOWING TERMINATION';
005203220420
005204220420          when stermdc = 'TFM';
005205220420           stermdesc = '1st OF MONTH AFTER TERMINATION';
005206220420
005207220420          when stermdc = 'TDA';
005208220420           stermdesc = 'DAY AFTER TERMINATION';
005209220420         endsl;
005210220420
005211201221         sempcon = pxecon;
005212201221
005213201221         sptele = pxptyn;
005214220331         sfhours = pxptlo;
005215220331         sthours = pxpthi;
005216220331
005217201221         sdepmaxa = pxdpmx;
005218220420
005219201221         sdepends = pxdpcd;
005220220420         select;
005221220420          when sdepends = 'DOB';
005222220420           sdependesc = 'TERM DATE OF BIRTH';
005223220420
005224220420          when sdepends = 'EOM';
005225220420           sdependesc = 'TERM END OF BIRTHDAY MONTH';
005226220420
005227220420          when sdepends = 'EOY';
005228220420           sdependesc = 'TERM END OF BIRTHDAY YEAR';
005229220420
005230220420          when sdepends = 'DEM';
005231220420           sdependesc = 'END OF MONTH';
005232220420
005233220420          when sdepends = 'EOP';
005234220420           sdependesc = 'TERM END OF PLAN YEAR';
005235220420         endsl;
005236220420
005237201221         sgroup# = pxgroup;
005238201221         scarent = pxcfsen;
005239201221         scarid = pxcarpln;
005240220420         sstvr = pxdpsv;
005241201221
005242201221         sexchange = pxexchg;
005243201221
005244211007         exsr acaRating;
005245220420         scarent = pxcfsen;
005246220420         sftmaxa = pxstmx;
005247240206         //srhirewp = pxrhpd;
005248220420
005249220309         select;
005250220420          when swaitp > ' ';
005251220420           monthDays = ' Months/Days';
005252220309          when swaitp = 'FFM';
005253220420           monthDays = ' Months';
005254220309          when swaitp <> 'FFM';
005255220420           monthDays = ' Days';
005256220309         endsl;
005257220309
005258220420         if swaitp > ' ';
005259220420          swaitpd = %trim(swaitpd) + ' ' + %trim(swtdy) + ' ' +
005260220420                    %trim(monthDays);
005261220420         endif;
005262220420
005263220420         if pxborefd > 0;
005264201221          sboredate = %date(pxborefd:*iso);
005265220309         endif;
005266201221
005267220309         if pxborlrd > 0;
005268201221          sborlrdate = %date(pxborlrd:*iso);
005269201221         endif;
005270201221
005271201221         smult = pxmpcd;
005272201221
005273230210         //ssdob = pxussp;
005274201221         sshowweb = pxshww;
005275201221
005276220420         //sstvr = pxdpsv;
005277201221
005278220420         //sftmaxa = pxstmx;
005279201221
005280201221        endif;
005281201208
005602201208       endsr;
005700180323
006359201221      //=======================================================================
006360211007      // aca rating
006361201221      //=======================================================================
006362201221
006363211007       begsr acaRating;
006364211007
006368220420        //if pxacar = ' ';
006369211007
006370220420        chain (#kt : #ks : #kp) planFile;
006371211007         chain (pcarr) car2File;
006372211007         sacarat2 = c2acart;
006381220516
006394220420        //endif;
006395211007
006396201221       endsr;
006397201221
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
010807201221        chain pcarr carrFile;
010808220516
010809220516        chain (%dec(#kt:3:0): %dec(#ks:3:0) : #kp) planFile;
010810220516        if %found;
010811220608        // if plncat = 'PCA';
010812220608        //  text1 = 'Plan Auxiliary display not';
010813220608        //   text2 = 'available for COBRA Plans';
010814220608        //   exfmt msgWindow;
010815220608        //  exsr exit;
010817220608        // endif;
010818220516        endif;
010819220516
010820220516        chain (%dec(#kt:3:0): %dec(#ks:3:0) : #kp : %dec(#ka:4:0)) plnauxl2;
010821220516        if not %found;
010822220516         text1 = 'This Plan Auxiliary display';
010823220516          text2 = 'is missing an account number';
010824220516          exfmt msgWindow;
010825220516         exsr exit;
010826220516        endif;
010827201221
011200180323       endsr;
011300180323
011400201221      //=======================================================================
