000101211216      *================================================================================
000102211216     H option(*noDebugIo)
000103211216      *================================================================================
000104220520      * PLANSHARED - Plans that are shared with missing aux
000105211216      *================================================================================
000106211216      * Date        Int   Description
000107211216      * ----------  ---   -------------------------------------------------------------
000108220520      * 05/20/2022  jt    Original creation
000109211216      *================================================================================
000111211216
001403220526     fplnmst    if   e           k disk    rename(plnmsr:planFile)
001404220526     f                                     extFile('F.PLNMST')
001406211221
001407220526     fplnauxp   if   e           k disk    rename(plnauxr:auxfile)
001408220520
001409220526     fsharedplanuf a e           k disk    rename(plansr:outFile)
001410220526
001411220526     fcomcontrl2if   e           k disk    rename(comcontrol:commFile2)
001412220526
001413220526     fcomcontrl1if   e           k disk    rename(comcontrol:commFile1)
001414220526
001415220526     fgbs0030l1 if   e           k disk    rename(r_gbs0030:transFile)
001416220526
001417220526     faccospl1  if   e           k disk    rename(accospr:oeFile)
001418220526
001419220526     faoecod    if   e           k disk    rename(aoecodr:oeDesc)
001420220526
001421211221      //=======================================================================
001422211221
001500220526     d count           s              1  0
001501220526     d group           s             10
001502211221
002104220526      //=======================================================================
002105211216      // mainline
002106211216      //=======================================================================
002107211216
002108211216       exsr init;
002109211216       exsr main;
002110211216       exsr exit;
002111211216
002126211216       //=======================================================================
002127211216       // main2subr
002128211216       //=======================================================================
002129211216
002130211216       begsr main;
002131211216
002132220526        setll *loval planFile;
002133220526        read planFile;
002137211221        dow not %eof;
002138220526         if pltrst > 0 and plsub# > 0 and plplan > ' ';
002139220526
002140220526          if plncat <> 'PCA' and plncat <> 'PBG'
002141220526           and plncat <> 'P1P' and plncat <> 'PAD'
002142220526            and plncat <> 'PHR' and plncat <> 'PBN';
002143220526
002144220526            chain (pltrst : plsub# : plplan) auxFile;
002145220526            if not %found;
002146220526             exsr writeRecord;
002147220526            endif;
004352220526
004353220526            if %found;
004354220526             if pxacct = 0;
004355220526              exsr writeRecord;
004356220526             endif;
004358220526            endif;
004359220526
004360220526          endif;
004361220526
004362220526         endif;
004363220526
004364220526        read planFile;
004601211216        enddo;
004602220526
004603220526        exsr updateRecord;
005700211216
005905211216       endsr;
005906211216
005907220526       //=======================================================================
005908220526       // write record
005909220526       //=======================================================================
005910220526
005911220526       begsr writeRecord;
005912220526
005913220526        trst = %editc(pltrst:'X');
005914220526        sub# = %editc(plsub#:'X');
005915220526        plan = plplan;
005916220526        plancat = plncat;
005917220526        carriercd = pcarr;
005918220526
005919220526        write outfile;
005920220526
005921220526       endsr;
005922220526
005923220526       //=======================================================================
005924220526       // write record
005925220526       //=======================================================================
005926220526
005927220526       begsr updateRecord;
005928220526
005929220526        setll *loval outFile;
005930220526        read outFile;
005931220526        dow not %eof;
005932220526
005933220526         setll (%dec(trst:3:0) : %dec(sub#:3:0) : plan) commFile2;
005934220526         reade (%dec(trst:3:0) : %dec(sub#:3:0) : plan) commFile2;
005935220526         dow not %eof;
005936220526
005937220526          count = count + 1;
005938220526          if count > 3;
005939220526           leave;
005940220526          endif;
005941220526
005942220526          select;
005943220526           when count = 1;
005944220526            acct1 = %editc(cmacct:'X');
005945220526
005946220526           when count = 2;
005947220526            acct2 = %editc(cmacct:'X');
005948220526
005949220526           when count = 3;
005950220526            acct3 = %editc(cmacct:'X');
005951220526          endsl;
005952220526
005953220526         reade (%dec(trst:3:0) : %dec(sub#:3:0) : plan) commFile2;
005954220526         enddo;
005955220526
005956220526         count = 0;
005957220526
005958220526         update outFile;
005959220526        read outFile;
005960220526        enddo;
005961220526
005962220526        setll *loval outFile;
005963220526        read outFile;
005964220526        dow not %eof;
005965220526         if acct1 > ' ';
005966220526          chain (%dec(trst:3:0):%dec(sub#:3:0):%dec(acct1:4:0):plan) commFile1;
005967220526          if %found;
005968220526           if cmcan > 0;
005969220526           if cmcan < 20220531;
005970220526            acct1 = ' ';
005971220526            update outFile;
005972220526           endif;
005973220526           endif;
005974220526           if cmcan > 20220531;
005975220526            date = %date(cmcan);
005976220526            update outFile;
005977220526           endif;
005978220526          endif;
005979220526         endif;
005980220526        read outFile;
005981220526        enddo;
005982220526
005983220526        setll *loval outFile;
005984220526        read outFile;
005985220526        dow not %eof;
005986220526         if acct2 > ' ';
005987220526          chain (%dec(trst:3:0):%dec(sub#:3:0):%dec(acct2:4:0):plan) commFile1;
005988220526          if %found;
005989220526           if cmcan > 0;
005990220526           if cmcan < 20220531;
005991220526            acct2 = ' ';
005992220526            update outFile;
005993220526           endif;
005994220526           endif;
005995220526           if cmcan > 20220531;
005996220526            date = %date(cmcan);
005997220526            update outFile;
005998220526           endif;
005999220526          endif;
006000220526         endif;
006001220526        read outFile;
006002220526        enddo;
006003220526
006004220526        setll *loval outFile;
006005220526        read outFile;
006006220526        dow not %eof;
006007220526         if acct3 > ' ';
006008220526          chain (%dec(trst:3:0):%dec(sub#:3:0):%dec(acct3:4:0):plan) commFile1;
006009220526          if %found;
006010220526           if cmcan > 0;
006011220526           if cmcan < 20220531;
006012220526            acct3 = ' ';
006013220526            update outFile;
006014220526           endif;
006015220526           endif;
006016220526           if cmcan > 20220531;
006017220526            date = %date(cmcan);
006018220526            update outFile;
006019220526           endif;
006020220526          endif;
006021220526         endif;
006022220526
006023220526        read outFile;
006024220526        enddo;
006025220526
006026220526        setll *loval outFile;
006027220526        read outFile;
006028220526        dow not %eof;
006029220526
006030220526         if acct1 = ' ' and acct2 = ' ' and acct3 = ' ';
006031220526          delete outFile;
006032220526         endif;
006033220526
006034220526        read outFile;
006035220526        enddo;
006036220526
006037220526        setll *loval outFile;
006038220526        read outFile;
006039220526        dow not %eof;
006040220526
006041220526         if trst = '025' or trst = '076' or trst = '080'
006042220526          or trst = '081' or trst = '082' or trst = '083' or trst = '084'
006043220526           or trst = '005' or trst = '026' or trst = '029' or trst = '031';
006044220526          delete outFile;
006045220526         endif;
006046220526
006047220526        read outFile;
006048220526        enddo;
006049220526
006050220526        setll *loval outFile;
006051220526        read outFile;
006052220526        dow not %eof;
006053220526
006054220526         if acct1 = ' ' and acct2 = ' ' and acct3 = ' ';
006055220526          delete outFile;
006056220526         endif;
006057220526
006058220526        read outFile;
006059220526        enddo;
006060220526
006061220526        setll *loval outFile;
006062220526        read outFile;
006063220526        dow not %eof;
006064220526
006065220526         group = %trim(trst) + %trim(sub#) + %trim(acct1);
006066220526         chain (group) transFile;
006067220526         if %found;
006068220526          vendor = ftpayvend;
006069220526          update outFile;
006070220526         endif;
006071220526
006072220526        read outFile;
006073220526        enddo;
006074220526
006075220526        setll *loval outFile;
006076220526        read outFile;
006077220526        dow not %eof;
006078220526
006079220526         setgt (%dec(trst:3:0):%dec(sub#:3:0):%dec(acct1:4:0)) oeFile;
006080220526         readpe (%dec(trst:3:0):%dec(sub#:3:0):%dec(acct1:4:0)) oeFile;
006081220526         dow not %eof;
006082220526
006083220526          if aoendt = 0 or aoendt > 20220531;
006084220526           chain aocode oeDesc;
006085220526           if %found;
006086220526            oledesc = aedesc;
006087220526             update outFile;
006088220526            leave;
006089220526           endif;
006090220526          endif;
006091220526
006092220526         readpe (%dec(trst:3:0):%dec(sub#:3:0):%dec(acct1:4:0)) oeFile;
006093220526         enddo;
006094220526
006095220526        read outFile;
006096220526        enddo;
006097220526
006098220526       endsr;
006099220526
006100211216       //=======================================================================
006101211216       // exit
006102211216       //=======================================================================
006103211216
006104211216       begsr exit;
006105220526
006106211216        *inlr = '1';
006107211216        return;
006108211216
006109211216       endsr;
006110211216
006111211216       //=======================================================================
006112211216       // init subr
006113211216       //=======================================================================
006114211216
006115211216       begsr init;
006116211216
006117211216       endsr;
006118211216
006119211216       //=======================================================================
