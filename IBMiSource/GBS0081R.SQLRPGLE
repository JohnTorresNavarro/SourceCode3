000100220302
000200210607       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no);
000300210607
000400210607      *-------------------------------------------------------------------------
000500210607      *
000600220302      *  Description: Add Plan Beneficaries
000700210607      *  Programmer.: Brian Rees
000800220302      *  Date.......: 03/03/2022
000900210607      *
000901220306      *  This will be called from FM070 whenever there is a Ancillary plan
000902220306      *  that requires beneficiaries.
000903220306      *
000906220302      *  Note: We can only have 5 beneficiaries and 5 contingents
000907220302      *        this was a decision made for OLE.
001000210607      *-------------------------------------------------------------------------
001100210607
001200210607      *-------------------------------------------------------------------------
001300210607      *
001400210607      * Declare Files
001500210607      *
001600210607      *-------------------------------------------------------------------------
001700220302       Dcl-f GBS0081d WorkStn
001800220302          Handler('PROFOUNDUI(HANDLER)')
001801220302          SFILE(PriSfl:rrn)
001802220302          SFILE(ContSfl:rrn2);
001900210607
002200210607
002500220302       dcl-f PlnBen keyed
002501220302          usage(*Input : *output : *Update : *Delete );
002600210607
002601220302       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
002605220302       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
002608220302       Dcl-f CFS100P keyed;
002611220302       Dcl-f PlnMst keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
002612220302       Dcl-f CodesL1 keyed ExtDesc('F.CODESL1') ExtFile(*extdesc);
002613220302       Dcl-f Codes keyed
002614220302          ExtDesc('F.CODES') ExtFile(*extdesc)
002615220302          Rename( Codesr : Rcd1 );
002616220302
002617220302
002700210607
002800210607      *-------------------------------------------------------------------------
002900210607      *
003000210607      * Global Variables
003100210607      *
003200210607      *-------------------------------------------------------------------------
003300210607
003400210607       dcl-ds pgmd
003500210607          ExtName('IOPGMD') PSDS;
003700210607       end-ds;
003800210607
004500210707       dcl-s wTrst Zoned(3);
004600210707       dcl-s wSub# Zoned(3);
004700210707       dcl-s wAcct Zoned(4);
004800210707
004804220302       dcl-s rrn  Zoned(5);
004805220302       dcl-s rrn2 Zoned(5);
004806220302
004807220302       dcl-s DepSeq Zoned(2) inz;
006800220302       dcl-s RelCode Char(3);
006900220302       dcl-c q '''';
006901220302
006902220211
006903220302       // Arrays for the Copy Process
006904220302       dcl-s AryFlag Char(1) Dim(100);
006905220302       dcl-s AryPerc Zoned(3) Dim(100);
006906220302       dcl-s AryRelt Char(10) Dim(100);
006907220302       dcl-s AryName Char(60) Dim(100);
006908220302       dcl-s i Zoned(4);
006909220302       dcl-s j Zoned(4);
006910220306       dcl-s CodeKey Char(1) inz('R');
006911220306       dcl-s wLine Zoned(3);
006912220306       dcl-s NewFlag Char(1);
006913220211
007000210706      *-------------------------------------------------------------------------
007100210706      *
007200210706      * *Entry Procedure
007300210706      *
007400210706      *-------------------------------------------------------------------------
007500210706       Dcl-pr Main ExtPgm;
007501220302         *N  Char(10);
007600210706         *N  Zoned(9);
007800220302         *N  Char(4);
007801220302         *N  Zoned(8);
008100210706       End-Pr;
008200210706
008300210706       dcl-pi Main;
008301220302         pAccount   Char(10);
008400220302         pMember    Zoned(9);
008401220302         pPlan      Char(4);
008402220302         pEffd      Zoned(8);
008900210706       End-Pi;
009000210607
009100210607
009200210607      *-------------------------------------------------------------------------
009300210607      *
009400210607      * Mainline Program
009500210607      *
009600210607      *-------------------------------------------------------------------------
009700220306       Exec Sql
009701220306         Set Option Commit = *None, Naming = *Sys;
009800210706
009801220302
009802220302       wTrst = %Dec( %Subst( pAccount : 1 : 3) : 3 : 0 );
009803220302       wSub# = %Dec( %Subst( pAccount : 4 : 3) : 3 : 0 );
009804220302       wAcct = %Dec( %Subst( pAccount : 7 : 4) : 4 : 0 );
009805220211
009901220211
009902220302       Dou btnExit = *on;
009903220302
009905220302         ClearS1();
009906220302         LoadS1();
009909220302
009910220302         exfmt Screen1;
009911220302
009912220302         select;
009913220302
009914220306         when btnAddP = *on;
009915220306           NewFlag = 'P';
009916220306           add_Data();
009917220306
009918220306         when btnAddC = *on;
009919220306           NewFlag = 'C';
009920220306           add_Data();
009921220306
009922220302         when mnuOption = 'mnCopy';
009923220302           CopyPlan_Bene();
009924220302
009925220302         other;
009926220302           ReadChangedS1();
009927220302           ReadChangedS2();
009928220302
009929220302         EndSl;
009930220302
009931220302
009932220302
009933220302       enddo;
009934220302
009935220302       *inlr = *on;
009936220302
009937220302
009938220302
009939220302       // ----------------------------------------------------------------
009940220302       dcl-proc CLEARS1;
009941220302
009942220302         //-------------------------
009943220302         //
009944220302         // Clear the Subfile
009945220302         //
009946220302         //-------------------------
009947220302
009948220302         SflClr = *on;
009949220302         Write Screen1;
009950220302         SflClr= *off;
009951220302         rrn = 0;
009952220302         rrn2 = 0;
009953220302
009954220302       End-Proc;
009955220302       // ----------------------------------------------------------------
009956220302       Dcl-Proc LoadS1;
009957220302
009958220302         //--------------------------------
009959220302         //
009960220302         // Load Heading
009961220302         //
009962220302         //--------------------------------
009963220302         s1Acct = %Subst( pAccount : 1 : 3 ) + '-' +
009964220302                  %Subst( pAccount : 4 : 3 ) + '-' +
009965220302                  %Subst( pAccount : 7 : 4 );
009966220302
009967220302         chain ( wTrst : wSub# : wAcct ) AccMst;
009968220302         if %Found ( AccMst ) ;
009969220302           s1AcctNAm = acNam1;
009970220302         EndIf;
009971220302
009972220302
009973220302         s1ssn = pMember;
009974220302         chain pMember Member;
009975220302         if %Found ( Member ) ;
009976220302           s1FullNam = %Trim( mlName ) + ', '  + %Trim( mfName );
009977220302         EndIf;
009978220302
009979220302
009980220302         chain ( pMember : DepSeq ) Cfs100p;
009981220302         if %Found ( Cfs100p ) ;
009982220302           s1FullNam = %Trim( cfsLst ) + ', '  + %Trim( cfsfst );
009983220302         EndIf;
009984220302
009985220302
009986220302         s1Plan = pPlan;
009987220302         chain ( wTrst : wSub# : pPlan ) PlnMst;
009988220302         if %Found ( PlnMst ) ;
009989220302           s1PlanName = pDescr;
009990220302         EndIf;
009991220302
009992220302
009993220302         s1Total = 0;
009994220302         s2Total = 0;
009995220302
009996220302
009997220302         //--------------------------------
009998220302         //
009999220302         // Load Grids
010000220302         //
010001220302         //--------------------------------
010002220302         Setll ( wTrst : wSub# : wAcct : pPlan : pMember )  PlnBen;
010003220302         Dou %eof(PlnBen);
010004220302
010005220302           reade ( wTrst : wSub# : wAcct : pPlan : pMember )  PlnBen;
010006220302           if %eof(PlnBen);
010007220302             leave;
010008220302           endif;
010009220302
010010220302
010011220302           //--------------------------
010012220302           // Primary Grid
010013220302           //--------------------------
010014220302           if pbFlag = 'P';
010015220302             s1Name = pbName;
010016220302             s1Perc = pbPerc;
010017220302             s1Relat = pbRelt;
010018220302             s1Line = pbLine;
010019220302             s1Relt = pbRelt;
010020220302             s1Line = pbLine;
010021220302
010022220302             relCode = %Trim( pbRelt );
010023220302             chain relCode Codesl1;
010024220302             if %Found( Codesl1 );
010025220302               s1Relat = lDescr;
010026220302             EndIf;
010027220302
010028220302
010029220302             if s1EffDate = '';
010030220302               s1EffDate =  %Char(%Date(pbEffd :*iso):*Usa);
010031220302             endif;
010032220302
010033220302             s1Total = s1Total + s1Perc;
010034220302             s1Color = 'Red';
010035220302             if s1Total = 0 or s1Total = 100;
010036220302               s1Color = 'White';
010037220302             EndIf;
010038220302
010039220302             rrn = rrn + 1;
010040220302             write PriSfl;
010041220302           endif;
010042220302
010043220302
010044220302           //--------------------------
010045220302           // Contingent Grid
010046220302           //--------------------------
010047220302           if pbFlag = 'C';
010048220302             s2Name = pbName;
010049220302             s2Perc = pbPerc;
010050220302             s2Relat = pbRelt;
010051220302             s2Line = pbLine;
010052220302             s2Relt = pbRelt;
010053220302             s2Line = pbLine;
010054220302
010055220302             relCode = %Trim( pbRelt );
010056220302             chain relCode Codesl1;
010057220302             if %Found( Codesl1 );
010058220302               s2Relat = lDescr;
010059220302             EndIf;
010060220302
010061220302
010062220302             if s1EffDate = '';
010063220302               s1EffDate =  %Char(%Date(pbEffd :*iso):*Usa);
010064220302             endif;
010065220302
010066220302             s2Total = s2Total + s2Perc;
010067220302             s2Color = 'Red';
010068220302             if s2Total = 0 or s2Total = 100;
010069220302               s2Color = 'White';
010070220302             EndIf;
010071220302
010072220302             rrn2 = rrn2 + 1;
010073220302             write ContSfl;
010074220302           endif;
010075220302
010076220302
010077220302         enddo;
010078220302
010079220306
010080220306         ShowAddP = *on;
010081220306         if rrn = 5;
010082220306           ShowAddP = *off;
010083220306         EndIf;
010084220306
010085220306         ShowAddC = *on;
010086220306         if rrn2 = 5;
010087220306           ShowAddC = *off;
010088220306         EndIf;
010089220306
010090220302       End-Proc;
010091220302
010092220302
010093220302       // ----------------------------------------------------------------
010094220302       Dcl-Proc ReadChangedS1;
010095220302
010096220302         Dou *in95 = *ON;
010097220302           READC PriSfl;
010098220302           *in95 = %EOF;
010099220302
010100220302           If *in95 = *OFF;
010101220302
010102220302             if BtnDelete = *on;
010103220302               Chain ( wTrst :wSub# :wAcct :pPlan :pMember :s1Line ) PlnBen;
010104220302               if %Found( plnBen );
010105220302                 delete plnbenr;
010106220302               EndIf;
010107220302
010108220302             EndIf;
010109220302
010110220302             if btnEdit = *on;
010111220302               s3Line = s1Line;
010112220302               s3Flag = 'P';
010113220302               s3Name = s1Name;
010114220302               s3Perc = s1Perc;
010115220302               s3Relt = s1Relt;
010116220302
010117220302               Edit_Data();
010118220302             endIf;
010119220302
010120220306
010121220306             if btnView = *on;
010122220306               Chain(n) ( wTrst :wSub# :wAcct :pPlan
010123220306                          :pMember :s1Line ) PlnBen;
010124220306
010125220306               s3Name = pbName;
010126220306               s3Perc = pbPerc;
010127220306
010128220306               s3Relat = s1Relat;
010129220306               s3CrtInfo = %Trim( pbadby ) + ' on ' +
010130220306               %Char(%Date(pbaddt:*iso):*Usa);
010131220306
010132220306               exfmt ViewBene;
010133220306
010134220306             endIf;
010135220302
010136220306
010137220306             BtnView = *off;
010138220306             BtnDelete = *off;
010139220302             btnEdit = *off;
010140220302             update PriSfl;
010141220302
010142220302           endIf;
010143220302
010144220302         enddo;
010145220302
010146220302       End-Proc;
010147220302
010148220302       // ----------------------------------------------------------------
010149220302       Dcl-Proc ReadChangedS2;
010150220302
010151220302         Dou *in95 = *ON;
010152220302           READC ContSfl;
010153220302           *in95 = %EOF;
010154220302
010155220302           If *in95 = *OFF;
010156220302
010157220302             if BtnDelete = *on;
010158220302               Chain ( wTrst :wSub# :wAcct :pPlan :pMember :s2Line ) PlnBen;
010159220302               if %Found( plnBen );
010160220302                 delete plnbenr;
010161220302               EndIf;
010162220302
010163220302             EndIf;
010164220302
010165220302             if btnEdit = *on;
010166220302               s3Line = s2Line;
010167220302               s3Flag = 'C';
010168220302               s3Name = s2Name;
010169220302               s3Perc = s2Perc;
010170220302               s3Relt = s2Relt;
010171220302
010172220302               Edit_Data();
010173220302             endIf;
010174220302
010175220302
010176220306
010177220306             if btnView = *on;
010178220306               Chain(n) ( wTrst :wSub# :wAcct :pPlan
010179220306                          :pMember :s2Line ) PlnBen;
010180220306
010181220306               s3Name = pbName;
010182220306               s3Perc = pbPerc;
010183220306
010184220306               s3Relat = s2Relat;
010185220306               s3CrtInfo = %Trim( pbadby ) + ' on ' +
010186220306               %Char(%Date(pbaddt:*iso):*Usa);
010187220306
010188220306               exfmt ViewBene;
010189220306
010190220306             endIf;
010191220306
010192220306             btnView = *off;
010193220306             btnDelete = *off;
010194220302             btnEdit = *off;
010195220302             update ContSfl;
010196220302
010197220302           endIf;
010198220302
010199220302         enddo;
010200220302
010201220302
010202220302
010203220302       End-Proc;
010204220302
010205220302
010206220302       // ----------------------------------------------------------------
010207220302       Dcl-Proc CopyPlan_Bene;
010208220302
010209220302         dcl-s sqPlan Char(4);
010210220302         dcl-s sqDesc Char(40);
010211220302         dcl-s SqlStmt Char(1000);
010212220302
010213220302
010214220302         //-------------------------
010215220302         // Build Drop Down Box.
010216220302         //-------------------------
010217220302
010218220302
010219220302         // Using SQL since I dont feel like creating a new
010220220302         // logical.
010221220302
010222220302         SqlStmt =
010223220302           'Select distinct(pbplan), pDescr ' +
010224220302           'from PlnBen ' +
010225220302           'join  "F.PLNMST" on ' +
010226220302               ' pbTrst = plTrst and pbSub# = plSub# and ' +
010227220302               ' pbPlan = plPlan ' +
010228220302            'Where pbTrst = ' + %char( wTrst )  +
010229220302            '  and pbSub# = ' + %char( wSub# )  +
010230220302            '  and pbAcct = ' + %char( wAcct )  +
010231220302            '  and pbssno = ' + %char( pMember )  +
010232220302            '  and pbplan <> ' +  q + pPlan  + q ;
010233220302
010234220302
010235220302
010236220306         Exec Sql
010237220306           Declare C1 Cursor For Sqlstmt;
010238220306         Exec Sql
010239220306           Prepare Sqlstmt From :Sqlstmt;
010240220306         Exec Sql
010241220306           Open C1;
010242220302
010243220302         dou SqlCod <> *Zero;
010244220306           Exec Sql
010245220306             Fetch Next From C1
010246220306               Into :SqPlan, :sqDesc;
010247220302
010248220302           if SqlCod <> *zero;
010249220302             leave;
010250220302           endif;
010251220302
010252220302           plnValues = %Trim(plnValues) + ',' + %Trim( sqPlan );
010253220302           plnChoices = %Trim(plnChoices) + ',' + %Trim( sqDesc );
010254220302
010255220302         enddo;
010256220306         Exec Sql
010257220306           Close C1;
010258220302
010259220302
010260220302         //------------------------------
010261220302         //
010262220302         // Display Screen
010263220302         //
010264220302         //------------------------------
010265220302
010266220302         Dou btnCancel = *on;
010267220302
010268220302           exfmt CopyBene;
010269220302
010270220302           if btnAccept = *on;
010271220302             btnAccept = *off;
010272220302
010273220302
010274220302             //-----------------------------------
010275220302             // Read Through database and
010276220302             //   save values to array
010277220302             //-----------------------------------
010278220302             i = 0;
010279220302             Setll ( wTrst : wSub# : wAcct : s2FromPlan : pMember ) PlnBen;
010280220302
010281220302             Dou %Eof(PlnBen);
010282220302               reade ( wTrst : wSub# : wAcct : s2FromPlan : pMember) PlnBen;
010283220302               if %eof(PlnBen);
010284220302                 leave;
010285220302               endif;
010286220302
010287220302               i = i + 1;
010288220302               AryFlag(i) = pbFlag;
010289220302               AryPerc(i) = pbPerc;
010290220302               AryRelt(i) = pbRelt;
010291220302               AryName(i) = pbName;
010292220302
010293220302             Enddo;
010294220302
010295220302
010296220302
010297220302             //-----------------------------------
010298220302             // Write the values back to
010299220306             // the table. This will only write
010300220306             // up to 5 records per group.
010301220302             //-----------------------------------
010302220302
010303220302             for j = 1 to i;
010304220302
010305220302               pbTrst = wTrst;
010306220302               pbSub# = wSub#;
010307220302               pbAcct = wAcct;
010308220302               pbPlan = pPlan;
010309220302               pbSSno = pMember;
010310220302
010311220302               pbEffd = pEffd;
010312220302
010313220302               pbFlag = aryFlag(j);
010314220302
010315220302
010316220306               exec sql
010317220306                 Select max(pbLine)
010318220306                   into :wLine
010319220306                   From plnBen
010320220306                   Where pbTrst = :wTrst and
010321220306                         pbSub# = :wSub# and
010322220306                         pbAcct = :wAcct and
010323220306                         pbssno = :pMember and
010324220306                         pbplan = :pPlan and
010325220306                         pbFlag = :pbFlag;
010326220302
010327220302
010328220302               // Contingent Line Count Starts at 6
010329220302               if pbFlag = 'C';
010330220302                 if pbLine = 0;
010331220302                   pbLine = 5;
010332220302                 EndIf;
010333220302               EndIf;
010334220302
010335220302               pbLine = wLine +1;
010336220302
010337220302
010338220302               pbPerc = aryPerc(j);
010339220302               pbRelt = aryRelt(j);
010340220302               pbName = aryName(j);
010341220302
010342220302
010343220302
010344220302               // Can only have 5 beneficiaries
010345220302
010346220302               if pbFlag = 'P' and pbLine <= 5;
010347220302                 write plnBenr;
010348220302               endif;
010349220302
010350220302               if pbFlag = 'C' and pbLine in %Range(6 : 10) ;
010351220302                 write plnBenr;
010352220302               endif;
010353220302
010354220302
010355220302             EndFor;
010356220302
010357220302
010358220302             leave;
010359220302
010360220302           EndIf;
010361220302
010362220302         enddo;
010363220302
010364220302         btnCancel = *off;
010365220302
010366220302
010367220302       End-Proc;
010368220302
010369220302
010370220302
010371220302       // ----------------------------------------------------------------
010372220302       Dcl-Proc Edit_Data;
010373220302
010374220302
010375220302         // Build Relationship Drop Down.
010376220302         Setll CodeKey Codes;
010377220302
010378220302         Dou %Eof(Codes);
010379220302           reade CodeKey Codes;
010380220302           if %eof(Codes);
010381220302             leave;
010382220302           endif;
010383220302
010384220302           if cdDltd <> 'A';
010385220302             iter;
010386220302           EndIf;
010387220302
010388220302           s3Choice = %Trim( s3Choice ) + ',' + %Trim( lDescr );
010389220302           s3Values = %Trim( s3Values ) + ',' + Type + Code;
010390220302
010391220302         Enddo;
010392220302
010393220302
010394220307         dou btnCancel = *on;
010395220302           exfmt Screen2;
010396220302
010397220302
010398220302           if btnOk  = *on;
010399220302
010400220306             chain ( wTrst : wSub# : wAcct : pPlan : pMember : s3Line )  PlnBen;
010401220302
010402220306             pbName = s3Name;
010403220306             pbPerc = s3Perc;
010404220306             pbRelt = s3Relt;
010405220302             update PlnBenr;
010406220302
010407220302             btnOk = *off;
010408220302             return;
010409220302
010410220302           EndIf;
010411220302
010412220302         enddo;
010413220302
010414220307         btnCancel = *off;
010415220302
010416220302       End-Proc;
010417220306
010418220306
010419220306       // ----------------------------------------------------------------
010420220306       Dcl-Proc Add_Data;
010421220306
010422220306
010423220306         //-----------------------------------
010424220306         // Build Relationship Drop Down.
010425220306         //-----------------------------------
010426220306         Setll CodeKey Codes;
010427220306
010428220306         Dou %Eof(Codes);
010429220306           reade CodeKey Codes;
010430220306           if %eof(Codes);
010431220306             leave;
010432220306           endif;
010433220306
010434220306           if cdDltd <> 'A';
010435220306             iter;
010436220306           EndIf;
010437220306
010438220306           s3Choice = %Trim( s3Choice ) + ',' + %Trim( lDescr );
010439220306           s3Values = %Trim( s3Values ) + ',' + Type + Code;
010440220306
010441220306         Enddo;
010442220306
010443220306
010444220306         //-----------------------------------
010445220306         // Get the Next Sequence Number.
010446220306         //-----------------------------------
010447220306         exec sql
010448220306           Select max(pbLine)
010449220306             into :wLine
010450220306             From plnBen
010451220306             Where pbTrst = :wTrst and
010452220306                   pbSub# = :wSub# and
010453220306                   pbAcct = :wAcct and
010454220306                   pbssno = :pMember and
010455220306                   pbplan = :pPlan and
010456220306                   pbFlag = :newFlag;
010457220306
010458220306
010459220306         wLine = wLine + 1;
010460220306
010461220306         // Clear Screen Data.
010462220306         s3Name = '';
010463220306         s3Perc = 0;
010464220306         s3Relt = '';
010465220306
010466220307         dou btnCancel = *on;
010467220306           exfmt Screen2;
010468220306
010469220306
010470220306           if btnOk  = *on;
010471220306
010472220306             pbTrst = wTrst;
010473220306             pbSub# = wSub#;
010474220306             pbAcct = wAcct;
010475220306             pbPlan = pPlan;
010476220306             pbssno = pMember;
010477220306
010478220306             pbLine = wLine;
010479220306             pbFlag = newFlag;
010480220306             pbEffd = pEffd;
010481220306
010482220306             pbName = s3Name;
010483220306             pbPerc = s3Perc;
010484220306             pbRelt = s3Relt;
010485220306
010486220306             pbaddt = %Dec(%Date);
010487220306             pbadby = wqusrn;
010488220306
010489220306             write PlnBenr;
010490220306
010491220306             btnOk = *off;
010492220306             return;
010493220306
010494220306           EndIf;
010495220306
010496220306         enddo;
010497220306
010498220307         btnCancel = *off;
010499220306
010500220306       End-Proc;
