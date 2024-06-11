000100210430
000200171229       Ctl-Opt option(*noDebugIo) bnddir('GBSBIND')  DftActGrp(*no)
000300171229          ActGrp(*New);
000400171227
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700171229      *  Description: Commission Control
000800171229      *  Programmer.: Brian Rees
000900171229      *  Date.......: 11/09/2017
001000171229      *
001100171229      *-------------------------------------------------------------------------
001200161109
001300180228      *-------------------------------------------------------------------------
001400180228      *
001500180911      * Change Log
001600180228      *
001700181127      *  2/28/2018  B.Rees  Added Group # to the Commission Control Grid
001800181127      *  6/26/2018  B.Rees  The Display file will now call INQ009R1 to
001900180626      *   Generate and download an Excel Report.  ( By Calling INQ009R1 )
002000181127      *  9/11/2018  B.Rees  Changed the location where I was pulling the Group
002100180911      *   number.  Now using F.Grat26
002200181127      * 11/27/2018  B.Rees  Added Renewal Month
002300190503      * 05/03/2019  B.Rees  Added Primary Broker Field
002400190503      *  Mod: Br01
002500201001      * 10/01/2020  B.Rees  Added Market Size.
002501210415      * 04/15/2021  B.Rees  Changed the Market Size to date to be the
002502210415      *   current Date. instead of the effective date.
002503220422      * 04/29/2202  jt      Using new Plan Auxiliary Inquiry screen
002504230320      * 05/19/2022  jt      Plan Inquiry screen was being called twice
002505230320      * 03/20/2023  jt      Added Carrier Master inquiry screen
002506231023      * 10/22/2023  rj      Added date range to selection for CARMKSZ0
002507201001      *
002600180228      *-------------------------------------------------------------------------
002700171229
002800171229      *-------------------------------------------------------------------------
002900171229      *
003000171229      * Declare Files
003100171229      *
003200171229      *-------------------------------------------------------------------------
003300220422
003400171227       Dcl-f Inq009d Workstn
003500171229          HANDLER('PROFOUNDUI(HANDLER)')
003600171229          SFILE(LSTSFL:rrn)
003700171229          SFILE(MbrSfl:rrn2);
003800171227
003900180911       Dcl-f Grat26 ExtDesc('F.GRAT26')  ExtFile(*extdesc) keyed;
004000171227       Dcl-f CMCT14 ExtDesc('F.CMCT14') ExtFile(*extdesc) keyed;
004100171227       Dcl-f SMan   ExtDesc('F.SMAN')   ExtFile(*extdesc) keyed;
004200171227       Dcl-f Class  ExtDesc('F.CLASS')  ExtFile(*extdesc) keyed;
004300171227       Dcl-f CarMst ExtDesc('F.CARMST') ExtFile(*extdesc) keyed;
004400171227       Dcl-f PlnMst ExtDesc('F.PLNMST') ExtFile(*extdesc) keyed;
004500171227       Dcl-f AccMst ExtDesc('F.ACCMST') ExtFile(*extdesc) keyed;
004600180228       Dcl-f pdRefpll1 keyed;
004700180228       dcl-f plnauxp keyed;
004800180111
004900180111       Dcl-f Agency ExtDesc('F.AGENCY') ExtFile(*extdesc) keyed;
005000180111       Dcl-f SMANRLT ExtDesc('F.SMANRLT') ExtFile(*extdesc) keyed;
005100180111       Dcl-f SPRAGXR2 ExtDesc('F.SPRAGXR2') ExtFile(*extdesc) keyed;
005200180111       Dcl-f SUPRAGCY ExtDesc('F.SUPRAGCY') ExtFile(*extdesc) keyed;
005300171227
005400171227       dcl-f iq11sfp  keyed usage(*Update : *Output : *Delete) usropn;
005500180626
005600161109
005700170420
005800171229      *-------------------------------------------------------------------------
005900171229      *
006000171229      * Global Variables
006100171229      *
006200171229      *-------------------------------------------------------------------------
006300180626       dcl-ds pgmd
006400180626          ExtName('IOPGMD') PSDS;
006500201001         @pgmq *proc;
006600180626       end-ds;
006700180626
006800180626
006900180626
007000171227       Dcl-s rrn  Zoned(5) inz;
007100171227       Dcl-s rrn2 Zoned(5) inz;
007200171227       Dcl-s ReLoad Char(1) inz;
007300171227
007400171229       Dcl-ds @Data;
007500201001         sqSSN    Zoned(9);
007600201001         sqlName  Char(18);
007700201001         sqfname  Char(12);
007800201001         sqEnrlDt Zoned(8);
007900201001         sqCancDt Zoned(8);
008000171227       End-Ds;
008100171227
008200171227
008300171109
008400161111      *--------------------------------------------
008500171229      *
008600171229      * Procedures
008700171229      *
008800161111      *--------------------------------------------
008900180223       dcl-pr Rtv_EndDate zoned(8);
009000201001         *n Zoned(3) value;
009100201001         *n Zoned(3) value;
009200201001         *n Char(4) value;
009300180223       End-Pr;
009400180223
009500180223
009600180223
009700180223       // Plan Inquiry
009800180223       dcl-pr PlanInq ExtPgm('INQ010R');
009900201001         oTrst Zoned(3);
010000201001         oSub# Zoned(3);
010100201001         oAcct Zoned(4);
010200201001         oPlan Char(4);
010300180223       End-Pr;
010400171229
010500180223       dcl-s oTrst Zoned(3);
010600180223       dcl-s oSub# Zoned(3);
010700180227       dcl-s oAcct Zoned(4);
010800180223       dcl-s oPlan Char(4);
010900171229
011000171109
011100180223       // Plan Rates
011200180223       dcl-pr PlanRates ExtPgm('FI037R');
011300201001         oTrst_p packed(3);
011400201001         oSub#_p packed(3);
011500201001         oPlan   Char(4);
011600180223       End-Pr;
011700171229
011800180223       dcl-s oTrst_p packed(3);
011900180223       dcl-s oSub#_p packed(3);
012000171113
012100171227
012200180223       // Plan Benefits
012300180621       dcl-pr FI036R ExtPgm('FI036R');
012400201001         oTrst_p packed(3);
012500201001         oSub#_p packed(3);
012600201001         oPlan   Char(4);
012700201001         oAcct_p packed(4);
012800201001         oType   char(8);
012900180223       End-Pr;
013000180223       dcl-s oType ChaR(8);
013100180223       dcl-s oAcct_p packed(4);
013200171227
013300171227
013301220422       dcl-s xPlan Char(4);
013302220422       dcl-s xTrst Packed(3);
013303220422       dcl-s xSub Packed(3);
013304220422       dcl-s xAcct Packed(4);
013400180223       // Plan Aux
013401220422       Dcl-pr PlanAux ExtPgm('FI035R2');
013501220422         xTrst packed(3);
013502220422         xSub# packed(3);
013503220422         xPlan Char(4);
013504220422         xAcct packed(4);
013505220422       //Dcl-pr PlanAux ExtPgm('FI035CL');
013600220422         //*N char(10);
013700180223       End-Pr;
013800180223       dcl-s tsPlan Char(10);
013900171227
014000171227
014001230320       // Carrier Master Inquiry
014002230320       dcl-s oType2 Char(1);
014003230320       dcl-s oCarr Char(3);
014004230320       dcl-pr CarInq ExtPgm('FM080R2');
014005230320         oCarr char(3);
014006230320         oType2 char(1);
014008230320       End-Pr;
014009230320
014100180223       // Member Inquiry
014200180223       Dcl-pr MemberInq ExtPgm('INQ002R');
014300201001         oMember zoned(9);
014400180223       End-Pr;
014500171227
014600180223       dcl-s oMember Zoned(9);
014601210415       dcl-s today Zoned(8);
014700171227
014800180404
014900180404      *-------------------------------------------------------------------------
015000180404      *
015100180404      * *Entry Procedure
015200180404      *
015300180404      *-------------------------------------------------------------------------
015400180404       Dcl-pr Main ExtPgm;
015500201001         *N  Zoned(3);
015600201001         *N  Zoned(3);
015700201001         *N  Zoned(4);
015800180404       End-Pr;
015900180404
016000180404       dcl-pi Main;
016100201001         pTrst  Zoned(3);
016200201001         pSub#  Zoned(3);
016300201001         pAcct  Zoned(4);
016400180404       End-Pi;
016500180404
016600180404
016700171227
016800171227
016900180102      *-------------------------------------------------------------------------
017000171229      *
017100180102      * Mainline Program
017200171229      *
017300180102      *-------------------------------------------------------------------------
017400170607
017500180223       Reload = 'Y';
017600180223       chkHidePln = 'Y';
017700210415       today = %Dec(%Date);
017701210415
017800170905
017900180223       //----------------------------------------------------------
018000171229
018100180223       // Load Subfile
018200171229
018300180223       //----------------------------------------------------------
018400180223       Dou btnBack = *on;
018500161109
018600201001         If Reload = 'Y';
018700201001           CLEARS1();
018800201001           LOAD();
018900201001           Reload = 'N';
019000201001         endIf;
019100161109
019200201001         DISPLY();
019300161109
019400161109
019500171110
019600171110
019700201001         // Process Selections
019800201001         Select;
019900180626
020000201001         When ChgHidePln = *on;
020100201001           Reload = 'Y';
020200171110
020300201001         When ChgHideAct = *on;
020400201001           Reload = 'Y';
020500170922
020600201001         other;
020700201001           ReadChanged();
020800161109
020900201001         EndSl;
021000161109
021100161109
021200180223       enddo;
021300161109
021400180223       *inlr = *on;
021500161109
021600170905
021700180223       //-----------------------------------------------------------------
021800180223       dcl-proc ClearS1;
021900161109
022000201001         // Clear the Subfile
022100201001         ClrSfl = *on;
022200201001         Write LstCtl;
022300201001         ClrSfl = *off;
022400201001         rrn = 0;
022500161109
022600180111       end-proc;
022700170905
022800171229
022900170905       //-----------------------------------------------------------------
023000180223       //
023100180223       // Load the Subfile Data..
023200180223       //
023300180223       //-----------------------------------------------------------------
023400180223       dcl-proc Load;
023500170606
023600201001         Build_WorkFile();
023700171109
023800201001         // Load Subfile
023900201001         Open Iq11Sfp;
024000201001         s1Account = %Editc( pTrst : 'X' ) + '-' +
024100201001            %Editc( pSub# : 'X' ) + '-' +
024200201001            %Editc( pAcct : 'X' );
024300171109
024400201001         chain ( pTrst : pSub# : pAcct ) AccMst;
024500201001         s1AcNam1 = acNam1;
024600171109
024700201001         s1FileName = %trim( acNam1 ) + ' - ' +
024800201001            %trim(s1Account) ;
024900180530
025000201001         Read1();
025100201001         Read2();
025200201001         Read3();
025300201001         Read4();
025400171110
025500201001         Close IQ11SFP;
025600171109
025700180223       end-proc;
025800171109
025900180223       //-----------------------------------------------------------------
026000180223       dcl-proc Build_WorkFile;
026100180222
026200201001         dcl-s CommPct Zoned(6:3);
026300180222
026400171109
026500201001         Open Iq11Sfp;
026600171109
026700201001         setll ( pTrst : pSub# : pAcct ) CmCt14;
026800201001         dou %Eof( CmCt14 ) ;
026900201001           reade ( pTrst : pSub# : pAcct ) CmCt14;
027000161109
027100201001           if %Eof( CmCt14 ) ;
027200201001             leave;
027300201001           endif;
027400171109
027500201001           chain SlsMan sMan;
027600171109
027700201001           sfPln = cmPlan;
027800201001           sfRelID = cmRelId;
027900201001           sfSlsM = SlsMan;
028000201001           sfsNam = %Trim( sfname ) + ' ' + %Trim( slname );
028100201001           sfEff = EffDat;
028200201001           sfTrm = cmCan;
028300201001br01       sfpribrk = %subst(free5:1:1);
028400210430           sfpnc = ccpnc;
028500180222
028600201001           // Calculate and Hide the commission split
028700201001           if cccmsp > 0;
028800201001             CommPct = %dech(cccmsp:6:3);
028900180222
029000201001             if cccmsp < 10;
029100201001               %Subst(sfsNam : 26 : 6) = %Char(CommPct) + '%';
029200201001             else;
029300201001               %Subst(sfsNam : 25 : 7) = %Char(CommPct) + '%';
029400201001             EndIf;
029500180222
029600201001           EndIf;
029700180222
029800171109
029900201001           // Plan Master Description
030000171109
030100201001           chain ( pTrst : pSub# : cmPlan ) PlnMst;
030200201001           chain ( pTrst : pSub# : cmPlan ) Grat26;
030300201001           chain pCarr CarMst;
030400171109
030500201001           sfDesc = pDescr;
030600171109
030700171109
030800171109
030900201001           // Class
031000201001           sfCls = *Blanks;
031100201001           chain ( pTrst : pSub# : cmPlan ) Class;
031200201001           if %Found( Class ) ;
031300201001             sfCls = clClass;
031400201001           endif;
031500171109
031600171109
031700201001           sfRex = Rtv_EndDate( pTrst : pSub# : cmPlan) ;
031800201001           spcarr = pCarr;
031900201001           sgrpcd = cGrpCd;
032000171109
032100201001           Write iq11sfr;
032200171109
032300201001         enddo;
032400171109
032500201001         Close iq11sfp;
032600171109
032700180223       end-proc;
032800180223       //-----------------------------------------------------------------
032900180223       dcl-proc DISPLY;
033000161109
033100201001         DspSfl = *on  ;
033200201001         exfmt LstCtl;
033300201001         DspSfl = *off;
033400161109
033500180223       end-proc;
033600180223       //-----------------------------------------------------------------
033700180223       dcl-proc ReadChanged;
033800161109
033900201001         Dou *in95 = *ON;
034000201001           READC LstSfl;
034100201001           *in95 = %EOF;
034200161109
034300201001           If *in95 = *OFF;
034400161109
034500201001             // Check Content Menu Options
034600201001             if runOption > *blanks;
034700171110
034701230320               if runOption = 'mnCarMst';
034702230320
034703230320                 xTrst = pTrst;
034704230320                 xSub = pSub#;
034705230320                 xPlan = sfPln;
034706230320                 chain (xTrst : xSub : xPlan) plnmsr;
034707230320                 if %found;
034708230320                 oCarr = pcarr;
034709230320                 oType2 = 'I';
034711230320                 CarInq(oCarr : oType2);
034712230320               endif;
034713230320               endif;
034714230320
034800171110
034900201001               if runOption = 'mnPlnAux';
035000220422                 //tsPlan = %Editc( pTrst : 'X' ) +
035100220422                 //   %Editc( pSub# : 'X' ) + sfPln;
035200171110
035300220422                 //PlanAux( tsPlan );
035301220422                 xTrst = pTrst;
035302220422                 xSub = pSub#;
035303220422                 xPlan = sfPln;
035304220422                 xAcct = pAcct;
035305220422
035306220422                 PlanAux( xTrst : xSub : xPlan : xAcct  ) ;
035400201001               endif;
035500171110
035600171110
035700201001               if runOption = 'mnPlnInq';
035800201001                 oTrst = pTrst;
035900201001                 oSub# = pSub#;
036000201001                 oPlan = sfPln;
036100201001                 oAcct = pAcct;
036200171110
036300201001                 PlanInq( oTrst : oSub# : oAcct : oPlan ) ;
036400171113
036500201001               endif;
036600170607
036601220513               //if runOption = 'mnPlnInq';
036602220513               //  oTrst = pTrst;
036603220513               //  oSub# = pSub#;
036604220513               //  oPlan = sfPln;
036605220513               //  oAcct = pAcct;
036606220513
036607220513               //  PlanInq( oTrst : oSub# : oAcct : oPlan ) ;
036608220422
036609220513               //endif;
036610220422
036700171120
036800201001               if runOption = 'mnPlnRate';
036900180621
037000201001                 // Check for ACA Plans
037100180621
037200201001                 if sfAcar = 'C' or sfAcar = 'N';
037300201001                   oTrst_p = pTrst;
037400201001                   oSub#_p = pSub#;
037500201001                   oPlan = sfPln;
037600171120
037700201001                   PlanRates( oTrst_p : oSub#_p : oPlan ) ;
037800180621
037900201001                 else;
038000171121
038100171120
038200201001                   oTrst_p = pTrst;
038300201001                   oSub#_p = pSub#;
038400201001                   oPlan = sfPln;
038500201001                   oAcct_p = pAcct;
038600201001                   oType = 'RATES';
038700180621
038800201001                   FI036R( oTrst_p : oSub#_p : oPlan : oAcct_p : oType) ;
038900180621
039000201001                 endif;
039100201001               endif;
039200171121
039300171121
039400171121
039500201001               if runOption = 'mnPlnBen';
039600201001                 oTrst_p = pTrst;
039700201001                 oSub#_p = pSub#;
039800201001                 oPlan = sfPln;
039900201001                 oAcct_p = pAcct;
040000201001                 oType = 'BENEFITS';
040100171121
040200201001                 FI036R( oTrst_p : oSub#_p : oPlan : oAcct_p : oType) ;
040300171121
040400201001               endif;
040500171227
040600171227
040700201001               // MemberCnt is set using the OnClick Function
040800201001               if runOption = 'MemberCnt';
040900201001                 MemberList();
041000201001               EndIf;
041100171227
041200180111
041300180111
041400201001               // MemberCnt is set using the OnClick Function
041500201001               if runOption = 'Relation';
041600201001                 Relat_List();
041700201001               EndIf;
041800180111
041900180111
042000180111
042100171227
042200201001             endif;
042300171120
042400170726
042500170607
042600170320
042700201001             runOption = *Blanks;
042800201001             update LstSfl;
042900161109
043000201001             Reload = 'Y';
043100201001           endIf;
043200161118
043300161109
043400201001         enddo;
043500180223       end-proc;
043600161109
043700161109
043800171110
043900190503      *-----------------------------------------------------------------
044000180223       dcl-proc Read1;
044100171110
044200201001         // Read1 is only selecting CareFirst Plans for the Subfile.
044300171110
044400201001         Setll *loval iq11sfp;
044500171110
044600201001         dou %eof(iq11sfp);
044700201001           read iq11sfp;
044800171110
044900201001           if %eof( iq11sfp );
045000201001             leave;
045100201001           endif;
045200171110
045300201001           // Skip Cobra Plans
045400201001           chain ( pTrst : pSub# : sfPln ) PlnMst;
045500201001           if plnCat = 'PCA';
045600201001             iter;
045700201001           endif;
045800190326
045900201001           //   if %Subst(sfPln : 1 : 1) = '9';
046000201001           //    iter;
046100201001           // endif;
046200171110
046300201001           if sGrpcd = 'CF';
046400201001             WriteSflRcd();
046500201001           Endif;
046600201001         enddo;
046700171110
046800180223       end-proc;
046900171110
047000190503      *-----------------------------------------------------------------
047100180223       dcl-proc Read2;
047200171110
047300201001         // Read2 is selecting any plan that is not CareFirst
047400201001         //       Plans must have a class..
047500171110
047600201001         Setll *loval iq11sfp;
047700171110
047800201001         dou %eof(iq11sfp);
047900201001           read iq11sfp;
048000171110
048100201001           if %eof( iq11sfp );
048200201001             leave;
048300201001           endif;
048400171110
048500201001           // Skip Cobra Plans
048600201001           chain ( pTrst : pSub# : sfPln ) PlnMst;
048700201001           if plnCat = 'PCA';
048800201001             iter;
048900201001           endif;
049000190326
049100201001           //   if %Subst(sfPln : 1 : 1) = '9';
049200201001           //    iter;
049300201001           // endif;
049400190326
049500190326
049600201001           if sGrpcd <> 'CF' and sfcls > *Blanks;
049700201001             WriteSflRcd();
049800201001           Endif;
049900171110
050000201001         enddo;
050100171110
050200180223       end-proc;
050300171110
050400171110
050500190503      *-----------------------------------------------------------------
050600180223       dcl-proc Read3;
050700171110
050800201001         // Read3 is selecting any plan that is not CareFirst
050900201001         //       Plans must have not have a class.
051000171110
051100201001         Setll *loval iq11sfp;
051200171110
051300201001         dou %eof(iq11sfp);
051400201001           read iq11sfp;
051500171110
051600201001           if %eof( iq11sfp );
051700201001             leave;
051800201001           endif;
051900171110
052000201001           // Skip Cobra Plans
052100201001           chain ( pTrst : pSub# : sfPln ) PlnMst;
052200201001           if plnCat = 'PCA';
052300201001             iter;
052400201001           endif;
052500190326
052600201001           // Skip Cobra Plans
052700201001           // if %Subst(sfPln : 1 : 1) = '9';
052800201001           //    iter;
052900201001           // endif;
053000171110
053100201001           if sGrpcd <> 'CF' and sfcls = *Blanks;
053200201001             WriteSflRcd();
053300201001           Endif;
053400171110
053500201001         enddo;
053600171110
053700180223       end-proc;
053800171110
053900171110
054000190503      *-----------------------------------------------------------------
054100180223       dcl-proc Read4;
054200171110
054300201001         // Read4 Anything Left Over.  ie= Cobra
054400171110
054500201001         Setll *loval iq11sfp;
054600171110
054700201001         dou %eof(iq11sfp);
054800201001           read iq11sfp;
054900171110
055000201001           if %eof( iq11sfp );
055100201001             leave;
055200201001           endif;
055300171110
055400201001           WriteSflRcd();
055500201001         enddo;
055600171110
055700180223       end-proc;
055800171110
055900171110
056000190503      *-----------------------------------------------------------------
056100180223       dcl-proc WriteSflRcd;
056200171110
056201201001         Dcl-s wFromSz Zoned(5);
056202201001         Dcl-s wToSz Zoned(5);
056203201001
056204210430         s1pnc = sfpnc;
056205210430
056300201001         s1eff = *Blanks;
056400201001         if sfeff > 0;
056500201001           s1Eff = %Char(%Date(sfEff:*iso):*Usa);
056600201001         endif;
056700171110
056800201001         s1trm = *Blanks;
056900201001         if sfTrm > 0;
057000201001           s1Trm = %Char(%Date(sfTrm:*iso):*Usa);
057100201001         endif;
057200171110
057300201001         s1Rex = *Blanks;
057400201001         if sfRex > 0;
057500201001           s1Rex = %Char(%Date(sfRex:*iso):*Usa);
057600201001         endif;
057700171110
057800190503
057900190503br01     s1pribrk = '';
058000190503         if sfpribrk = 'Y';
058100190503           s1pribrk = 'Yes';
058200190503         EndIf;
058300190503
058400171110
058500201001         // Check for Reference Plan
058600201001         s1Refp = *Blanks;
058700201001         chain ( pTrst : pSub# : pAcct : sfPln ) pdRefPll1;
058800201001         if %Found( pdRefPll1 );
058900201001           s1Refp = 'Y';
059000201001         endif;
059100171110
059200201001         evalr s1commpct = %Trim( %Subst(sfsnam : 25 ));
059300180222
059400201001         sfsnam =  %Subst(sfsnam : 1 : 24 );
059500180222
059600201001         // Check for ACA
059700201001         sfacar = '';
059800201001         chain ( pTrst : pSub# : sfPln ) plnauxp;
059900201001         if %Found( plnauxp );
060000201001           sfacar = pxAcar;
060100201001         endif;
060200180228
060300201001         // Check for Group Number
060400201001         sfGroup# = '';
060500201001         setll ( pTrst : pSub# : sfPln ) Grat26;
060600201001         dow not %Eof( Grat26 );
060700201001           reade ( pTrst : pSub# : sfPln ) Grat26;
060800201001           if grDltd = 'D';
060900201001             iter;
061000201001           endif;
061100181031
061200201001           sfGroup# = Group#;
061300201001           leave;
061400201001         enddo;
061500181127
061600181127
061700201001         // Retrieve the Renewal Month
061800201001         s1RenMth = 0;
061900201001         chain ( pTrst : pSub# : sfPln ) PlnMst;
062000201001         if %Found( PlnMst );
062100201001           s1RenMth = Prenew;
062200201001         endif;
062300181127
062400171110
062500201001         // Check for Active Member
062600190326         // plnWeight = '';
062700201001         backColor = '';
062800201001         Exec Sql
062900201001           Select Count(*)
063000201001             Into :S1mbrcnt
063100201001             From "F.MCOV"
063200201001             Where Mctrst = :Ptrst And
063300201001                   Mcsub# = :Psub# And
063400201001                   Acc# = :Pacct And
063500201001                   Mcplan = :Sfpln And
063600201001                   Candt = 0;
063700201001         if s1MbrCnt > 0;
063800201001           backColor = 'Yellow';
063900201001         //     plnWeight = 'Bolder';
064000201001         endif;
064100171110
064200171110
064201201001         // Get Market Size.
064202201001         wFromSz = 0;
064203201001         wToSz = 0;
064204201001         s1MktSz = '';
064205201001
064206201001         Exec Sql
064207201001           select czfrsz, cztosz
064208201001             into :wFromSz, :wToSz
064209201001             from "F.MKTCARA0"
064210201001                  join "F.CARMKSZ0"
064211201001                    on czcarr = macarr and
064212231023                      czszcd = maszcd and
064213231023                      (cztodt = 0 or
064214231023                        cztodt >= :today)
064215201001             Where maTrst = :pTrst and
064216201001                   maSub# = :pSub# and
064217201001                   maAcc# = :pAcct and
064218201001                   maCarr = :pCarr and
064219201001                   (matodt = 0 or
064220210415                     matodt >= :today);
064221201001
064222201001          if wFromSz > 0 or wToSz > 0;
064223201001            s1MktSz = %Editc(wFromSz:'J') + '-' +
064224201001                      %Editc(wToSz:'J');
064225201001          EndIf;
064226201001
064227201001
064300201001         delete iq11sfr;
064400171110
064500201001         // Check the check boxes...
064600201001         //  Hide Cancelled...
064700201001         if chkHidePln = 'Y' and  sfTrm > 0;
064800201001           return;
064900201001         endif;
065000171110
065100201001         //  Hide No Members...
065200201001         if chkHideAct = 'Y' and  s1MbrCnt = 0 ;
065300201001           return;
065400201001         endif;
065500171110
065501210430
065502210430
065600201001         rrn = rrn + 1;
065700201001         write LstSfl;
065800171110
065900180223       end-proc;
066000171110
066100171110
066200190503      *-----------------------------------------------------------------
066300180223       dcl-proc MemberList;
066400171227
066500180111
066600201001         dcl-s wPlanDesc Char(40);
066700180111
066800201001         // Clear the Subfile
066900201001         ClrSfl2 = *on;
067000201001         Write MbrList;
067100201001         ClrSfl2 = *off;
067200201001         rrn2 = 0;
067300171227
067400201001         s2Pln = sfPln;
067500201001         s2desc = sfdesc;
067600171227
067700201001         wPlanDesc =
067800201001            %SCANRPL(' ' : '-' : sfDesc : 1 : %Len(%Trim( sfDesc ))) ;
067900201001         wPlanDesc = %SCANRPL('/' : '-' : wPlanDesc);
068000180111
068100180111
068200201001         s2FileName = %Trim(wPlanDesc) + '_' + %Char( %Date : *iso );
068300171227
068400201001         //Load the Subfile
068500201001         Exec Sql
068600201001           Declare C1 Cursor For
068700201001             Select Mcssno, Mlname, Mfname, Enrldt, Candt
068800201001               From "F.MCOV"
068900201001                    Join "F.MEMBER"
069000201001                      On Mbssno = Mcssno
069100201001               Where Mctrst = :Ptrst And
069200201001                     Mcsub# = :Psub# And
069300201001                     Acc# = :Pacct And
069400201001                     Mcplan = :Sfpln And
069401201001                     Candt = 0;
069500171227
069600201001         Exec Sql
069700201001           Open C1;
069800171227
069900201001         Dou SqlCod <> *Zero;
070000201001           Exec Sql
070100201001             Fetch Next From C1
070101201001               Into :@data;
070200171227
070300201001           if SqlCod <> *Zero;
070400201001             Leave;
070500201001           endif;
070600171227
070700201001           s2ssn =  sqssn;
070800201001           s2FulName = %Trim(sqlname) + ', ' + %Trim(sqfname);
070900201001           s2EnrlDt = *Blanks;
071000201001           s2CancDt = *Blanks;
071100180111
071200201001           if sqEnrlDt > 0;
071300201001             s2EnrlDt = %Char(%Date(sqEnrlDt:*iso):*Usa);
071400201001           endif;
071500180111
071600201001           if sqCancDt > 0;
071700201001             s2CancDt = %Char(%Date(sqCancDt:*iso):*Usa);
071800201001           endif;
071900180111
072000171227
072100201001           rrn2 = rrn2  + 1;
072200201001           write MbrSfl;
072300171227
072400171227
072500201001         enddo;
072600171227
072700201001         Exec Sql
072701201001           Close C1;
072800171227
072900201001         // Display Subfile
073000201001         DspSfl2 = *on  ;
073100201001         exfmt MbrList;
073200201001         DspSfl2 = *off;
073300171227
073400171229
073500201001         // See if any member was selected
073600201001         Dou *in95 = *ON;
073700201001           READC MbrSfl;
073800201001           *in95 = %EOF;
073900171227
074000201001           If *in95 = *OFF;
074100171227
074200201001             If SelSSN = *on;
074300201001               // Go Directly to application;
074400201001               oMember = s2ssn;
074500201001               MemberInq( oMember );
074600201001             endIf;
074700171227
074800201001             SelSSN = *off;
074900201001             update MbrSfl;
075000171227
075100201001           endIf;
075200171227
075300171227
075400201001         enddo;
075500171227
075600171227
075700201001         // Turn off Back Button
075800201001         btnBack = *off;
075900171110
076000180223       end-proc;
076100180111
076200180111
076300180111      *-----------------------------------------------------------------
076400180223       dcl-proc Relat_List;
076500180111
076600180111
076700201001         s3slsm = sfslsm;
076800201001         s3snam = sfsnam;
076900180111
077000180111
077100201001         chain sfRelid SmanRlt;
077200201001         chain srasid  spragxr2;
077300180111
077400201001         // Agency
077500201001         chain sxagcy Agency;
077600201001         s3Agcy = sxAgcy;
077700201001         s3Nam1 = agnam1;
077800180111
077900180111
078000201001         // Super Agency
078100201001         s3Super = sxSuper;
078200201001         s3supNam1 = *Blanks;
078300201001         if sxSuper <> '*NO';
078400201001           chain sxSuper  supragcy;
078500201001           s3SupNam1 = saName1;
078600201001         EndIf;
078700180111
078800201001         exfmt Screen3;
078900180111
079000201001         btnBack = *off;
079100180111
079200180111
079300180223       end-proc;
079400180223
079500180223
079600180223
079700180223      *-----------------------------------------------------------------
079800180223       dcl-proc Rtv_EndDate export;
079900180223
080000201001         dcl-pi *n Zoned(8) ;
080100201001           trst Zoned(3) value;
080200201001           sub Zoned(3)  value;
080300201001           Plan Char(4)  value;
080400201001         End-Pi;
080500180223
080600180223
080700201001         dcl-s ReturnVal Zoned(8);
080800201001         dcl-s SqlStmt Char(500);
080900201001         dcl-c q const('''');
081000180223
081100180223
081200201001         ReturnVal = 00000000;
081300180223
081400201001         SqlStmt =
081500201001            'Select todat from "F.GRAT25" '  +
081600201001            ' Where grTrst = ' + %Char( Trst ) +
081700201001            '   and grSub# = ' + %Char( Sub )  +
081800201001            '   and grPlan = ' + q + plan + q +
081900201001            ' order by todat desc' ;
082000180223
082100180223
082200201001         Exec Sql
082201201001           Declare C2 Cursor For Sqlstmt;
082300201001         Exec Sql
082301201001           Prepare Sqlstmt From :Sqlstmt;
082400201001         Exec Sql
082401201001           Open C2;
082500180223
082600201001         dou SqlCod <> *Zero;
082700201001           Exec Sql
082701201001             Fetch Next From C2
082702201001               Into :Returnval;
082800180223
082900201001           if SqlCod <> *zero;
083000201001             leave;
083100201001           endif;
083200180223
083300201001           leave;
083400201001         enddo;
083500201001         Exec Sql
083501201001           Close C2;
083600180223
083700180223
083800180223
083900201001         Return returnVal;
084000180223
084100180223       end-proc;
