000100171229
000200171229       Ctl-Opt option(*noDebugIo) bnddir('GBSBIND')  DftActGrp(*no)
000300171229          ActGrp(*New);
000400171227
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700180626      *  Description: Commission Control - Download Excel
000800171229      *  Programmer.: Brian Rees
000900180626      *  Date.......: 06/26/2018
001000171229      *
001100171229      *-------------------------------------------------------------------------
001200161109
001300180228      *-------------------------------------------------------------------------
001400180228      *
001500181102      * Change Log
001600180228      *
001700181102      * 11/2/2018  B.Rees  Changed the location where I was pulling the Group
001800181102      *   number.  Now using F.Grat26
001900180228      *
002000181127      * 11/27/2018  B.Rees  Added Renewal Month *
002100190131      *
002200190131      * 01/31/2019  B.Rees  Added Refrence Plan to Spread Sheet.
002300190503      *
002400190503      * 05/03/2019  B.Rees  Added Primary Broker Field
002500190503      *  Mod: Br01
002600190503      *
002601201001      * 10/01/2020  B.Rees  Added Market Size.
002602210415      * 04/15/2021  B.Rees  Changed the Market Size to date to be the
002603210415      *   current Date. instead of the effective date.
002604210415
002700180228      *-------------------------------------------------------------------------
002800171229
002900171229      *-------------------------------------------------------------------------
003000171229      *
003100171229      * Declare Files
003200171229      *
003300171229      *-------------------------------------------------------------------------
003400171229
003500171227
003600180626       // Universal Dispaly File - Excel
003700180626       dcl-f inq009L WorkStn
003800180626          Handler('UNIVERSAL(HANDLER)')
003900180626          usropn;
004000171227
004100181102       Dcl-f Grat26 ExtDesc('F.GRAT26')  ExtFile(*extdesc) keyed;
004200181102       //Dcl-f Grate  ExtDesc('F.GRATE')  ExtFile(*extdesc) keyed;
004300171227       Dcl-f CMCT14 ExtDesc('F.CMCT14') ExtFile(*extdesc) keyed;
004400171227       Dcl-f SMan   ExtDesc('F.SMAN')   ExtFile(*extdesc) keyed;
004500171227       Dcl-f Class  ExtDesc('F.CLASS')  ExtFile(*extdesc) keyed;
004600171227       Dcl-f CarMst ExtDesc('F.CARMST') ExtFile(*extdesc) keyed;
004700171227       Dcl-f PlnMst ExtDesc('F.PLNMST') ExtFile(*extdesc) keyed;
004800171227       Dcl-f AccMst ExtDesc('F.ACCMST') ExtFile(*extdesc) keyed;
004900180228       Dcl-f pdRefpll1 keyed;
005000180228       dcl-f plnauxp keyed;
005100180111
005200180111       Dcl-f Agency ExtDesc('F.AGENCY') ExtFile(*extdesc) keyed;
005300180111       Dcl-f SMANRLT ExtDesc('F.SMANRLT') ExtFile(*extdesc) keyed;
005400180111       Dcl-f SPRAGXR2 ExtDesc('F.SPRAGXR2') ExtFile(*extdesc) keyed;
005500180111       Dcl-f SUPRAGCY ExtDesc('F.SUPRAGCY') ExtFile(*extdesc) keyed;
005600171227
005700171227       dcl-f iq11sfp  keyed usage(*Update : *Output : *Delete) usropn;
005800180626
005900161109
006000170420
006100171229      *-------------------------------------------------------------------------
006200171229      *
006300171229      * Global Variables
006400171229      *
006500171229      *-------------------------------------------------------------------------
006600180626
006700180627
006800180627       dcl-ds
006900180627          pgmsts psds;
007000180627
007100201001         Parms    Zoned(3) pos( 37 ) ;
007200201001         JobName  Char(10) Pos( 244 );
007300201001         JobNum   Zoned(6) Pos( 264 ) ;
007400201001         CurrentUser Char(10) Pos( 358 );
007500180627       end-ds;
007600180626
007601210415       dcl-s today Zoned(8);
007602210415
007700161111      *--------------------------------------------
007800171229      *
007900171229      * Procedures
008000171229      *
008100161111      *--------------------------------------------
008200180223       dcl-pr Rtv_EndDate zoned(8);
008300201001         *n Zoned(3) value;
008400201001         *n Zoned(3) value;
008500201001         *n Char(4) value;
008600180223       End-Pr;
008700180223
008800180223
008900180223
009000180404
009100180404      *-------------------------------------------------------------------------
009200180404      *
009300180404      * *Entry Procedure
009400180404      *
009500180404      *-------------------------------------------------------------------------
009600180404       Dcl-pr Main ExtPgm;
009700201001         *N  Char(12);
009800201001         *N  Char(1);
009900201001         *N  Char(50);
010000180404       End-Pr;
010100180404
010200180404       dcl-pi Main;
010300201001         iAccount ChaR(12);
010400201001         iHide    ChaR(1);
010500201001         iTempLoc ChaR(50);
010600180404       End-Pi;
010700180404
010800180404
010900180626       dcl-s pTrst Zoned(3);
011000180626       dcl-s pSub# Zoned(3);
011100180626       dcl-s pAcct Zoned(4);
011200180626
011300171227
011400180102      *-------------------------------------------------------------------------
011500171229      *
011600180102      * Mainline Program
011700171229      *
011800180102      *-------------------------------------------------------------------------
011900170607
012000170905
012100180626       pTrst  = %Dec( %Subst( iAccount : 1 : 3 ) : 3 : 0);
012200180626       pSub#  = %Dec( %Subst( iAccount : 5 : 3 ) : 3 : 0);
012300180626       pAcct  = %Dec( %Subst( iAccount : 9 : 4 ) : 4 : 0);
012400180626       xml_Dest = iTempLoc;
012401210415
012402210415       today = %Dec(%Date);
012500180626
012600180626       load();
012700161109
012800180223       *inlr = *on;
012900161109
013000170905
013100171229
013200170905       //-----------------------------------------------------------------
013300180223       //
013400180223       // Load the Subfile Data..
013500180223       //
013600180223       //-----------------------------------------------------------------
013700180223       dcl-proc Load;
013800170606
013900201001         open inq009L;
014000201001         Build_WorkFile();
014100171109
014200201001         // Load Subfile
014300201001         Open Iq11Sfp;
014400180626
014500201001         h_ActNbr = %Editc( pTrst : 'X' ) + '-' +
014600201001            %Editc( pSub# : 'X' ) + '-' +
014700201001            %Editc( pAcct : 'X' );
014800171109
014900201001         chain ( pTrst : pSub# : pAcct ) AccMst;
015000201001         h_ActNam = acNam1;
015100171109
015200201001         h_Date = %Char(%Date:*USA);
015300201001         h_User = CurrentUser;
015400180626
015500201001         Write header;
015600180626
015700180530
015800201001         Read1();
015900201001         Read2();
016000201001         Read3();
016100201001         Read4();
016200171110
016300201001         Close IQ11SFP;
016400171109
016500201001         write Footer;
016600201001         Close Inq009L;
016700180626
016800180223       end-proc;
016900171109
017000180223       //-----------------------------------------------------------------
017100180223       dcl-proc Build_WorkFile;
017200180222
017300201001         dcl-s CommPct Zoned(6:3);
017400180222
017500171109
017600201001         Open Iq11Sfp;
017700171109
017800201001         setll ( pTrst : pSub# : pAcct ) CmCt14;
017900201001         dou %Eof( CmCt14 ) ;
018000201001           reade ( pTrst : pSub# : pAcct ) CmCt14;
018100161109
018200201001           if %Eof( CmCt14 ) ;
018300201001             leave;
018400201001           endif;
018500171109
018600201001           chain SlsMan sMan;
018700171109
018800201001           sfPln = cmPlan;
018900201001           sfRelID = cmRelId;
019000201001           sfSlsM = SlsMan;
019100201001           sfsNam = %Trim( sfname ) + ' ' + %Trim( slname );
019200201001           sfEff = EffDat;
019300201001           sfTrm = cmCan;
019400201001br01       sfpribrk = %subst(free5:1:1);
019500210430           sfpnc = ccpnc;
019501210430
019502210430
019600201001           // Calculate and Hide the commission split
019700201001           if cccmsp > 0;
019800201001             CommPct = %dech(cccmsp:6:3);
019900180222
020000201001             if cccmsp < 10;
020100201001               %Subst(sfsNam : 26 : 6) = %Char(CommPct) + '%';
020200201001             else;
020300201001               %Subst(sfsNam : 25 : 7) = %Char(CommPct) + '%';
020400201001             EndIf;
020500180222
020600201001           EndIf;
020700180222
020800171109
020900201001           // Plan Master Description
021000171109
021100201001           chain ( pTrst : pSub# : cmPlan ) PlnMst;
021200201001           chain ( pTrst : pSub# : cmPlan ) Grat26;
021300201001           // chain ( pTrst : pSub# : cmPlan ) Grate;
021400201001           chain pCarr CarMst;
021500171109
021600201001           sfDesc = pDescr;
021700171109
021800171109
021900171109
022000201001           // Class
022100201001           sfCls = *Blanks;
022200201001           chain ( pTrst : pSub# : cmPlan ) Class;
022300201001           if %Found( Class ) ;
022400201001             sfCls = clClass;
022500201001           endif;
022600171109
022700171109
022800201001           sfRex = Rtv_EndDate( pTrst : pSub# : cmPlan) ;
022900201001           spcarr = pCarr;
023000201001           sgrpcd = cGrpCd;
023100171109
023200201001           Write iq11sfr;
023300171109
023400201001         enddo;
023500171109
023600201001         Close iq11sfp;
023700171109
023800180223       end-proc;
023900180626
024000161109
024100171110
024200171110br03  *-----------------------------------------------------------------
024300180223       dcl-proc Read1;
024400171110
024500201001         // Read1 is only selecting CareFirst Plans for the Subfile.
024600171110
024700201001         Setll *loval iq11sfp;
024800171110
024900201001         dou %eof(iq11sfp);
025000201001           read iq11sfp;
025100171110
025200201001           if %eof( iq11sfp );
025300201001             leave;
025400201001           endif;
025500171110
025600201001           // Skip Cobra Plans
025700201001           if %Subst(sfPln : 1 : 1) = '9';
025800201001             iter;
025900201001           endif;
026000171110
026100201001           if sGrpcd = 'CF';
026200201001             WriteSflRcd();
026300201001           Endif;
026400201001         enddo;
026500171110
026600180223       end-proc;
026700171110
026800171110br03  *-----------------------------------------------------------------
026900180223       dcl-proc Read2;
027000171110
027100201001         // Read2 is selecting any plan that is not CareFirst
027200201001         //       Plans must have a class..
027300171110
027400201001         Setll *loval iq11sfp;
027500171110
027600201001         dou %eof(iq11sfp);
027700201001           read iq11sfp;
027800171110
027900201001           if %eof( iq11sfp );
028000201001             leave;
028100201001           endif;
028200171110
028300201001           // Skip Cobra Plans
028400201001           if %Subst(sfPln : 1 : 1) = '9';
028500201001             iter;
028600201001           endif;
028700171110
028800201001           if sGrpcd <> 'CF' and sfcls > *Blanks;
028900201001             WriteSflRcd();
029000201001           Endif;
029100171110
029200201001         enddo;
029300171110
029400180223       end-proc;
029500171110
029600171110
029700171110br03  *-----------------------------------------------------------------
029800180223       dcl-proc Read3;
029900171110
030000201001         // Read3 is selecting any plan that is not CareFirst
030100201001         //       Plans must have not have a class.
030200171110
030300201001         Setll *loval iq11sfp;
030400171110
030500201001         dou %eof(iq11sfp);
030600201001           read iq11sfp;
030700171110
030800201001           if %eof( iq11sfp );
030900201001             leave;
031000201001           endif;
031100171110
031200201001           // Skip Cobra Plans
031300201001           if %Subst(sfPln : 1 : 1) = '9';
031400201001             iter;
031500201001           endif;
031600171110
031700201001           if sGrpcd <> 'CF' and sfcls = *Blanks;
031800201001             WriteSflRcd();
031900201001           Endif;
032000171110
032100201001         enddo;
032200171110
032300180223       end-proc;
032400171110
032500171110
032600171110br03  *-----------------------------------------------------------------
032700180223       dcl-proc Read4;
032800171110
032900201001         // Read4 Anything Left Over.  ie= Cobra
033000171110
033100201001         Setll *loval iq11sfp;
033200171110
033300201001         dou %eof(iq11sfp);
033400201001           read iq11sfp;
033500171110
033600201001           if %eof( iq11sfp );
033700201001             leave;
033800201001           endif;
033900171110
034000201001           WriteSflRcd();
034100201001         enddo;
034200171110
034300180223       end-proc;
034400171110
034500171110
034600171110br03  *-----------------------------------------------------------------
034700180223       dcl-proc WriteSflRcd;
034800171110
034900201001         Dcl-s wFromSz Zoned(5);
034901201001         Dcl-s wToSz Zoned(5);
034902201001
034903201001
034904201001
035000201001         d1pln = sfpln;
035100210430         d1pnc = sfpnc;
035200180626
035300201001         // Check for Group Number
035400201001         d1Group# = '';
035500201001         chain ( pTrst : pSub# : sfPln ) plnauxp;
035600201001         if %Found( plnauxp );
035700201001           d1Group# = pxGroup;
035800201001         endif;
035900180626
036000180626
036100201001         d1Desc = sfDesc;
036200201001         Exec Sql
036300201001           Select Count(*)
036400201001             Into :D1mbrcnt
036500201001             From "F.MCOV"
036600201001             Where Mctrst = :Ptrst And
036700201001                   Mcsub# = :Psub# And
036800201001                   Acc# = :Pacct And
036900201001                   Mcplan = :Sfpln And
037000201001                   Candt = 0;
037100180626
037200201001         d1Class = sfCls;
037300201001         d1Relid = sfRelid;
037400201001         d1slsm = sfSlsm;
037500201001         d1snam = sfsnam;
037600180626
037700180626
037800201001         d1eff = *Blanks;
037900201001         if sfeff > 0;
038000201001           d1Eff = %Char(%Date(sfEff:*iso):*Usa);
038100201001         endif;
038200171110
038300201001         d1trm = *Blanks;
038400201001         if sfTrm > 0;
038500201001           d1Trm = %Char(%Date(sfTrm:*iso):*Usa);
038600201001         endif;
038700171110
038800190503br01     d1pribrk = '';
038900190503         if sfpribrk = 'Y';
039000190503           d1pribrk = 'Yes';
039100190503         EndIf;
039200190503
039300190503
039400190503
039500201001         d1Rex = *Blanks;
039600201001         if sfRex > 0;
039700201001           d1Rex = %Char(%Date(sfRex:*iso):*Usa);
039800201001         endif;
039900171110
040000171110
040100201001         // Check for Reference Plan
040200201001         d1Refp = *Blanks;
040300201001         chain ( pTrst : pSub# : pAcct : sfPln ) pdRefPll1;
040400201001         if %Found( pdRefPll1 );
040500201001           d1Refp = 'Y';
040600201001         endif;
040700190131
040800201001         evalr d1commpct = %Trim( %Subst(sfsnam : 25 ));
040900180222
041000201001         d1snam =  %Subst(sfsnam : 1 : 24 );
041100180222
041200201001         // Check for Group Number
041300201001         d1Group# = '';
041400201001         //chain ( pTrst : pSub# : sfPln ) plnauxp;
041500201001         //if %Found( plnauxp );
041600201001         //   d1Group# = pxGroup;
041700201001         //endif;
041800180228
041900201001         setll ( pTrst : pSub# : sfPln ) Grat26;
042000201001         dow not %Eof( Grat26 );
042100201001           reade ( pTrst : pSub# : sfPln ) Grat26;
042200201001           if grDltd = 'D';
042300201001             iter;
042400201001           endif;
042500181102
042600201001           d1Group# = Group#;
042700201001           leave;
042800201001         enddo;
042900181102
043000181127
043100201001         // Retrieve the Renewal Month
043200201001         d1RenMth = 0;
043300201001         chain ( pTrst : pSub# : sfPln ) PlnMst;
043400201001         if %Found( PlnMst );
043500201001           d1RenMth = Prenew;
043600201001         endif;
043700181127
043800181127
043801201001         // Get Market Size.
043802201001         wFromSz = 0;
043803201001         wToSz = 0;
043804201001         d1MktSz = '';
043805201001
043806201001         Exec Sql
043807201001           select czfrsz, cztosz
043808201001             into :wFromSz, :wToSz
043809201001             from "F.MKTCARA0"
043810201001                  join "F.CARMKSZ0"
043811201001                    on czcarr = macarr and
043812201001                      czszcd = maszcd
043813201001             Where maTrst = :pTrst and
043814201001                   maSub# = :pSub# and
043815201001                   maAcc# = :pAcct and
043816201001                   maCarr = :pCarr and
043817201001                   (matodt = 0 or
043818210415                     matodt >= :today);
043819201001
043820201001         if wFromSz > 0 or wToSz > 0;
043821201001           d1MktSz = %Editc(wFromSz:'J') + '-' +
043822201001                     %Editc(wToSz:'J');
043823201001         EndIf;
043824201001
043900171110
044000201001         // Check for Active Member
044100201001         delete iq11sfr;
044200171110
044300201001         if iHide = '';
044400201001           write Detail;
044500201001         endif;
044600180627
044700201001         if iHide = 'Y' and d1trm = '';
044800201001           write Detail;
044900201001         endif;
045000180627
045100171110
045200180223       end-proc;
045300171110
045400171110
045500180111
045600180223
045700180223
045800180223      *-----------------------------------------------------------------
045900180223       dcl-proc Rtv_EndDate export;
046000180223
046100201001         dcl-pi *n Zoned(8) ;
046200201001           trst Zoned(3) value;
046300201001           sub Zoned(3)  value;
046400201001           Plan Char(4)  value;
046500201001         End-Pi;
046600180223
046700180223
046800201001         dcl-s ReturnVal Zoned(8);
046900201001         dcl-s SqlStmt Char(500);
047000201001         dcl-c q const('''');
047100180223
047200180223
047300201001         ReturnVal = 00000000;
047400180223
047500201001         SqlStmt =
047600201001            'Select todat from "F.GRAT25" '  +
047700201001            ' Where grTrst = ' + %Char( Trst ) +
047800201001            '   and grSub# = ' + %Char( Sub )  +
047900201001            '   and grPlan = ' + q + plan + q +
048000201001            ' order by todat desc' ;
048100180223
048200180223
048300201001         Exec Sql
048400201001           Declare C2 Cursor For Sqlstmt;
048500201001         Exec Sql
048600201001           Prepare Sqlstmt From :Sqlstmt;
048700201001         Exec Sql
048800201001           Open C2;
048900180223
049000201001         dou SqlCod <> *Zero;
049100201001           Exec Sql
049200201001             Fetch Next From C2
049201201001               Into :Returnval;
049300180223
049400201001           if SqlCod <> *zero;
049500201001             Leave;
049600201001           endif;
049700180223
049800201001           leave;
049900201001         enddo;
050000201001         Exec Sql
050001201001           Close C2;
050100180223
050200180223
050300180223
050400201001         Return returnVal;
050500180223
050600180223       end-proc;
050700180223
