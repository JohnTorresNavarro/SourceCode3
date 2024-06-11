000001210306       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no)
000002210303          bnddir('GBSBIND');
000003210303
000006210303      *-------------------------------------------------------------------------
000007210303      *
000008210306      *  Description: OLE Side by Side File Maintenace
000009210303      *  Programmer.: Brian Rees
000010210306      *  Date.......: 03/06/2021
000011210303      *
000012210308      *  Overview: This replaces an Excel program to load the side by side
000013210308      *   ole Data.
000016210308      *
000017210916      *-------------------------------------------------------------------------
000018210916      * Modifications
000019210916      * 9/16/2021     B.Rees  Added Class to WN0012
000020210916      *
000021210916      *
000022210303      *-------------------------------------------------------------------------
000023210303
000024210303      *-------------------------------------------------------------------------
000025210303      *
000026210303      * Declare Files
000027210303      *
000028210303      *-------------------------------------------------------------------------
000029210306       Dcl-f Gbs0068d WorkStn
000030210303          Handler('PROFOUNDUI(HANDLER)')
000031210303          SFILE(LstSfl:rrn)    ;
000033210303
000034210303       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
000035210306       Dcl-f PlnMst keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
000036210306       dcl-f BeneCovgp keyed usage(*Input:*output:*Delete:*update);
000037210308       dcl-f DntlCovgp keyed usage(*Input:*output:*Delete:*update);
000038210304
000043210303
000044210303      *-------------------------------------------------------------------------
000045210303      *
000046210303      * Global Variables
000047210303      *
000048210303      *-------------------------------------------------------------------------
000049210303
000050210303       dcl-ds pgmd
000051210303          ExtName('IOPGMD') PSDS;
000052210303         @pgmq *proc;
000053210303       end-ds;
000054210303
000055210303
000056210303       dcl-s rrn Zoned(5);
000098210303
000099210303      *--------------------------------------------
000100210303      *
000101210303      *  Procedures
000102210303      *
000103210303      *--------------------------------------------
000104210303      /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
000107210306      /include GBSPGM/QMODSRC,#GettokPR
000108210306      /include GBSPGM/QMODSRC,#zFillpr
000109210306
000129210303
000130210303       dcl-pr Acct_Window ExtPgm('WN0011R');
000133210304         cAcct Char(12) Const;
000134210303         iDescr Char(40) const;
000136210303       End-Pr;
000137210303       dcl-s cAcct Char(12);
000138210306       dcl-s iDescr Char(40);
000147210303
000169210303
000174210303       dcl-pr AccountInq ExtPgm('INQ008R');
000175210303         oTrst Zoned(3);
000176210303         oSub# Zoned(3);
000177210303         oAcct Zoned(4);
000178210303       End-Pr;
000179210303       dcl-s oTrst Zoned(3);
000180210303       dcl-s  oSub# Zoned(3);
000181210303       dcl-s  oAcct Zoned(4);
000182210306       dcl-c digits  '0123456789';
000183210306       dcl-s wtsa like( s2tsa );
000184210306
000185210303
000186210306       dcl-pr wn0012r ExtPgm('WN0012R');
000187210306         oTrst Zoned(3);
000188210306         oSub# Zoned(3);
000189210306         oAcct Zoned(4);
000190210306         oPlan Char(4);
000191210306         oCancel Char(1);
000192210916         oCls  Char(4);
000193210306       End-Pr;
000194210306       dcl-s oPlan Char(4);
000195210306       dcl-s oCancel Char(1);
000196210916       dcl-s oCls  Char(4);
000197210306
000198210303
000199210303      *-------------------------------------------------------------------------
000200210303      *
000201210303      * Mainline Program
000202210303      *
000203210303      *-------------------------------------------------------------------------
000204210303
010500210308       Exec Sql
010501210308         Set Option Commit = *NONE, Naming = *SYS;
010700160804
010703210303
010704210303       Dou btnExit = *on;
010705210303
010707210306         ClearS1();
010708210308         LoadMedical();
010709210308         LoadDental();
010710210308
010712210303         DisplyS1();
010713210303
010714210303
010715210303         //?Process Selections
010716210303         Select;
010717210303
010718210303
010719210303         When btnAddNew = *on;
010720210306
010721210306           dou btnCancel = *on;
010722210306             exfmt SelType;
010723210306
010724210306             if btnCancel = *on;
010725210306               leave;
010726210306             EndIf;
010727210306
010728210306             if btnAccept = *on;
010729210306
010730210306               if s3SelType = 'Medical';
010731210306                 Add_MedData();
010732210306                 leave;
010733210306               EndIf;
010734210306
010735210306               if s3SelType = 'Dental';
010736210308                 Add_DenData();
010737210306                 leave;
010738210306               EndIf;
010739210306             EndIf;
010740210306
010741210306
010742210306
010743210306           EndDo;
010744210306           btnCancel = *off;
010745210306
010746210303
010747210304         when SrchChgd = *on;
010748210304
010749210303
010750210303         When btnRefresh = *on;
010751210303           s1Search = *blanks;
010752210303
010753210303         other;
010754210303           ReadChangedS1();
010755210303
010756210303         EndSl;
010757210303
010758210303
010759210303       enddo;
010760210303
010761210303       *inlr = *on;
010762210303
017134210303
017135210303       // ----------------------------------------------------------------
017136210303       dcl-proc CLEARS1;
017137210303
017138210303         //-------------------------
017139210303         //
017140210303         // Clear the Subfile
017141210303         //
017142210303         //-------------------------
017143210303
017144210303         SflClr = *on;
017145210303         Write LstCtl;
017146210303         SflClr= *off;
017147210303         rrn = 0;
017148210303
017149210303       End-Proc;
017150210303       // ----------------------------------------------------------------
017151210308       Dcl-Proc LoadMedical;
017241210303
017242210306         Setll *loval BeneCovgp;
017243210306         Dou %eof(BeneCovgp);
017244210303
017245210306           read BeneCovgp;
017246210306           if %eof(BeneCovgp);
017247210303             leave;
017248210303           endif;
017249210303
017250210306           s1Trst = lbTrst;
017251210306           s1Sub# = lbSub#;
017252210306           s1Acct = lbAcct;
017253210306           s1PlanId = lbPlan;
017254210306           s1Type = 'Medical';
017255210303
017256210306           s1Tsa = %editc(s1Trst : 'X') + '-' +
017257210306                   %editc(s1Sub# : 'X') + '-' +
017258210306                   %editc(s1Acct : 'X') ;
017259210303           s1Tsa_nd = %ScanRpl('-' : '' : s1Tsa);
017260210303
017262210303           s1GrpName = '';
017264210306           chain ( s1Trst : s1Sub# : s1Acct ) AccMst;
017265210303           if %Found( AccMst ) ;
017266210303             s1GrpName = acNam1;
017268210303           EndIf;
017269210303
017285210303
017286210303           s1Termed = '';
017287210303           if ATRMDT > 0 and ATRMDT  < %Dec(%Date);
017288210303             s1Termed = 'Y';
017289210303           EndIf;
017290210303
017291210303
017296210303           If s1Search = *Blanks;
017297210303             rrn = rrn + 1;
017298210303             write LstSfl;
017299210303           endIf;
017300210303
017301210303
017302210303           If s1Search > *Blanks;
017304210303             If %Scan( %Trim(s1Search) : uCase(s1GrpName) ) > 0  or
017305210306                %Scan( %Trim(s1Search) : s1tsa_Nd) > 0  or
017306210308                %Scan( %Trim(s1Search) : s1type) > 0  or
017307210308                %Scan( %Trim(s1Search) : s1PlanId) > 0  or
017308210306                %Scan( %Trim(s1Search) : s1tsa) > 0  ;
017309210303               rrn = rrn + 1;
017310210303               write LstSfl;
017311210303             endIf;
017312210303           endIf;
017313210303
017314210303
017316210303           If rrn >= 9999;
017317210303             leave;
017318210303           endIf;
017319210303
017320210303         enddo;
017321210303
017322210303       End-Proc;
017323210303
017324210308       // ----------------------------------------------------------------
017325210308       Dcl-Proc LoadDental;
017326210308
017327210308         Setll *loval DntlCovgp;
017328210308         Dou %eof(DntlCovgp);
017329210308
017330210308           read DntlCovgp;
017331210308           if %eof(DntlCovgp);
017332210308             leave;
017333210308           endif;
017334210308
017335210308           s1Trst = lbTrst;
017336210308           s1Sub# = lbSub#;
017337210308           s1Acct = lbAcct;
017338210308           s1PlanId = lbPlan;
017339210308           s1Type = 'Dental';
017340210308
017341210308           s1Tsa = %editc(s1Trst : 'X') + '-' +
017342210308                   %editc(s1Sub# : 'X') + '-' +
017343210308                   %editc(s1Acct : 'X') ;
017344210308           s1Tsa_nd = %ScanRpl('-' : '' : s1Tsa);
017345210308
017346210308           s1GrpName = '';
017347210308           chain ( s1Trst : s1Sub# : s1Acct ) AccMst;
017348210308           if %Found( AccMst ) ;
017349210308             s1GrpName = acNam1;
017350210308           EndIf;
017351210308
017352210308
017353210308           s1Termed = '';
017354210308           if ATRMDT > 0 and ATRMDT  < %Dec(%Date);
017355210308             s1Termed = 'Y';
017356210308           EndIf;
017357210308
017358210308
017359210308           If s1Search = *Blanks;
017360210308             rrn = rrn + 1;
017361210308             write LstSfl;
017362210308           endIf;
017363210308
017364210308
017365210308           If s1Search > *Blanks;
017366210308             If %Scan( %Trim(s1Search) : uCase(s1GrpName) ) > 0  or
017367210308                %Scan( %Trim(s1Search) : s1tsa_Nd) > 0  or
017368210308                %Scan( %Trim(s1Search) : s1type) > 0  or
017369210308                %Scan( %Trim(s1Search) : s1PlanId) > 0  or
017370210308                %Scan( %Trim(s1Search) : s1tsa) > 0  ;
017371210308               rrn = rrn + 1;
017372210308               write LstSfl;
017373210308             endIf;
017374210308           endIf;
017375210308
017376210308
017377210308           If rrn >= 9999;
017378210308             leave;
017379210308           endIf;
017380210308
017381210308         enddo;
017382210308
017383210308       End-Proc;
017384210308
017385210303       // ----------------------------------------------------------------
017386210303       Dcl-Proc DisplyS1;
017387210303
017388210303         SflDsp = *on  ;
017389210303         exfmt LstCtl;
017390210303         SflDsp = *off;
017391210303
017392210303       End-Proc;
017393210303
017394210303       // ----------------------------------------------------------------
017395210303       Dcl-Proc ReadChangedS1;
017396210303
017397210303         Dou *in95 = *ON;
017398210303           READC LstSfl;
017399210303           *in95 = %EOF;
017400210303
017401210303           If *in95 = *OFF;
017402210303
017403210308
017404210308
017405210308             //----------------------------
017406210308             // Edit Plan
017407210308             //----------------------------
017408210303             if btnEdit = *on;
017409210306
017410210306               if s1Type = 'Medical';
017411210306                 Load_MedData();
017412210306                 Edit_MedData();
017413210306               endif;
017414210306
017415210308
017416210308               if s1Type = 'Dental';
017417210308                 Load_DenData();
017418210308                 Edit_DenData();
017419210308               endif;
017420210308
017421210306
017422210303             endIf;
017423210303
017424210308
017425210308
017426210308             //----------------------------
017427210308             // View Plan
017428210308             //----------------------------
017429210306             if btnView = *on;
017430210308
017431210308               if s1Type = 'Medical';
017432210308                 Load_MedData();
017433210308                 Exfmt ViewMed;
017434210308               endif;
017435210306
017436210308               if s1Type = 'Dental';
017437210308                 Load_DenData();
017438210308                 Exfmt ViewDen;
017439210308               endif;
017440210306
017441210306             EndIf;
017442210306
017443210306
017444210308             //----------------------------
017445210308             // Delete Plan
017446210308             //----------------------------
017447210304             if btnDelete = *on;
017448210308               if s1Type = 'Medical';
017449210308                 Load_MedData();
017450210308                 Delete_MedData();
017451210308               endif;
017452210308
017453210308               if s1Type = 'Dental';
017454210308                 Load_DenData();
017455210308                 Delete_DenData();
017456210308               endif;
017457210304             EndIf;
017458210304
017459210303
017460210303             //------------------------------
017461210303             //
017462210304             // Go to Account Inquiry
017463210304             //
017464210304             //------------------------------
017465210304             if SelAcct = *on;
017466210304               oAcct = s1Acct;
017467210304               oTrst = s1Trst;
017468210304               oSub# = s1Sub# ;
017469210303
017470210304               AccountInq( oTrst : oSub# : oAcct );
017471210303
017472210303             endif;
017473210303
017474210303
017475210304             selAcct = *off;
017476210304             btnEdit = *off;
017477210304             btnDelete = *off;
017478210306             btnView = *off;
017479210304
017480210304             update LstSfl;
017481210303
017482210304           endIf;
017483210303
017484210303         enddo;
017485210303
017486210304       End-Proc;
017487210303
017488210304       // ----------------------------------------------------------------
017489210308       //
017490210308       //
017491210308       //   Medical Data
017492210308       //
017493210308       //
017494210308       // ----------------------------------------------------------------
017495210306       Dcl-Proc Load_MedData;
017496210303
017497210303         s2Tsa = s1Tsa;
017498210303         s2GrpName = s1GrpName;
017499210303
017500210304         s2Trst = s1Trst;
017501210304         s2Sub# = s1Sub#;
017502210304         s2Acct = s1Acct;
017503210304
017504210306         s2PlanId = s1PlanId;
017505210306
017506210306         chain ( s2Trst : s2Sub# : s2Acct : s2PlanId ) BeneCovgp;
017507210306         if %Found( BeneCovgp );
017508210306           s2Desc = lbDesc;
017509210306           s2pTyp = lbpTyp;
017510210306           s2mdin = lbmdin;
017511210306           s2mdot = lbmdot;
017512210306           s2chgin = lbchgin;
017513210306           s2chgot = lbchgot;
017514210306           s2rxcovg = lbrxcovg;
017515210306           s2rxamt = lbrxamt;
017516210306           s2mxoopin = lbmxoopin;
017517210306           s2mxoopot = lbmxoopot;
017518210306
017519210306         EndIf;
017520210306
017521210306         s2PlanDsc = '';
017522210306         chain ( s2Trst : s2Sub#: s2PlanId ) PlnMst;
017523210306         if %Found( PlnMst ) ;
017524210306           s2PlanDsc = pdescr;
017525210306         EndIf;
017526210306
017527210306
017528210304
017529210304       End-Proc;
017530210303
017531210303
017532210304       // ----------------------------------------------------------------
017533210306       Dcl-Proc Edit_MedData;
017534210303
017535210304         Dou btnCancel = *on;
017536210303
017537210306           exfmt EditMed;
017538210303
017539210304           if btnAccept = *on;
017540210306             lbDesc = s2Desc;
017541210306             lbpTyp = s2pTyp;
017542210306             lbmdin = s2mdin;
017543210306             lbmdot = s2mdot;
017544210306             lbchgin = s2chgin;
017545210306             lbchgot = s2chgot;
017546210306             lbrxcovg = s2rxcovg;
017547210306             lbrxamt = s2rxamt;
017548210306             lbmxoopin = s2mxoopin;
017549210306             lbmxoopot = s2mxoopot;
017550210303
017551210306             update rBeneCovgp;
017552210306
017553210304             leave;
017554210304           EndIf;
017555210303
017556210304         enddo;
017557210303
017558210306         unlock Benecovgp;
017559210304         btnCancel = *off;
017560210303
017561210304       End-Proc;
017562210303
017563210304       // ----------------------------------------------------------------
017564210306       Dcl-Proc Add_MedData;
017565210303
017566210306
017567210306         Clear AddMed;
017568210306
017569210306
017570210303
017571210304         Dou btnCancel = *on;
017572210303
017573210306           exfmt AddMed;
017574210306           errAccount = *off;
017575210308           errPlan = *off;
017576210306           s2MSg = '';
017577210306
017578210308
017579210308
017580210308           //-------------------------------------------------
017581210306           // Check to see if the Account Number has changed.
017582210308           //-------------------------------------------------
017583210308           if btnLookup = *on;
017584210306             s2GrpName = '';
017585210306
017586210306             wtsa = s2tsa;
017587210306             // For the people who press "Field+"
017588210306             wtsa =  %ScanRpl( '+' : '-' : wtsa );
017589210306
017590210306             split();
017591210306             s2tsa = wtsa;
017592210306
017593210306             if %check( digits : %Subst( s2tsa : 1 : 3)) = 0  and
017594210306                %check( digits : %Subst( s2tsa : 5 : 3)) = 0  and
017595210306                %check( digits : %Subst( s2tsa : 9 : 4)) = 0 ;
017596210306
017597210306               s2Trst = %Dec( %Subst( s2tsa : 1 : 3) : 3 : 0 );
017598210306               s2Sub# = %Dec( %Subst( s2tsa : 5 : 3) : 3 : 0 );
017599210306               s2Acct = %Dec( %Subst( s2tsa : 9 : 4) : 4 : 0 );
017600210306
017601210306               chain ( s2Trst : s2Sub# : s2Acct ) AccMst;
017602210306               if not %Found( AccMst );
017603210306                 ErrAccount = *on;
017604210306               else;
017605210306                 s2GrpName = acNam1;
017606210306               endif;
017607210306
017608210306             else;
017609210306               errAccount = *on;
017610210306             endif;
017611210306
017612210306             iter;
017613210306           endif;
017614210306
017615210306
017616210308
017617210308           //-------------------------------------------------
017618210306           // Search for Plan ID.
017619210308           //-------------------------------------------------
017620210306           if btnPlan = *on;
017621210306
017622210306             if s2Trst = 0 or s2Sub# = 0 or s2Acct = 0;
017623210306               ErrAcct = *on;
017624210306               iter;
017625210306             EndIf;
017626210306
017627210308             oTrst = s2Trst;
017628210308             oSub# = s2Sub#;
017629210308             oAcct = s2Acct;
017630210308
017631210916             wn0012r( oTrst : oSub# : oAcct : oPlan : oCancel:oCls);
017632210306             if oCancel = '';
017633210306               s2Planid = oPlan;
017634210306               chain ( s2Trst : s2Sub# : s2PlanID) PlnMst;
017635210306               if %Found( PlnMst ) ;
017636210306                 s2PlanDsc = pDescr;
017637210306               EndIf;
017638210306
017639210306             EndIf;
017640210306
017641210306             btnPlan = *off;
017642210306             iter;
017643210306           EndIf;
017644210306
017645210306
017646210306
017647210306
017648210304           if btnSearch = *on;
017649210303
017650210304             cAcct = '';
017651210306             iDescr = '';
017652210303
017653210306             Acct_Window(cAcct : iDescr );
017654210304             if cAcct > '';
017655210304               s2Trst = %Dec( %Subst(cAcct:1:3):3:0);
017656210304               s2Sub# = %Dec( %Subst(cAcct:5:3):3:0);
017657210304               s2Acct = %Dec( %Subst(cAcct:9:4):4:0);
017658210304
017659210304               s2Tsa = cAcct;
017660210306               s2GrpName = iDescr;
017661210304             endif;
017662210304             iter;
017663210304           endif;
017664210303
017665210304
017666210304           //------------------------------------
017667210304           //
017668210304           // Accept: Add Record
017669210304           //
017670210304           //------------------------------------
017671210304           if btnAccept = *on;
017672210303
017673210308             // Alrady Setup?
017674210308             chain (s2Trst : s2Sub# : s2Acct : s2PlanId ) BeneCovgp;
017675210308             if %Found( BeneCovgp );
017676210308               errPlan = *on;
017677210308               iter;
017678210308             EndIf;
017679210308
017680210308
017681210308             //-------------------------------------------------
017682210308             // Write Record.
017683210308             //-------------------------------------------------
017684210308             lbTrst = s2Trst;
017685210308             lbSub# = s2Sub#;
017686210308             lbAcct = s2Acct;
017687210308             lbplan = s2Planid;
017688210308
017689210308             lbDesc = s2Desc;
017690210308             lbpTyp = s2pTyp;
017691210308             lbmdin = s2mdin;
017692210308             lbmdot = s2mdot;
017693210308             lbchgin = s2chgin;
017694210308             lbchgot = s2chgot;
017695210308             lbrxcovg = s2rxcovg;
017696210308             lbrxamt = s2rxamt;
017697210308             lbmxoopin = s2mxoopin;
017698210308             lbmxoopot = s2mxoopot;
017699210308
017700210308             Write rBeneCovgp;
017701210308
017702210308
017703210306             s2Msg = 'Plan: ' + s2PlanId + ' has been added.';
017704210308
017705210308             s2Planid = '';
017706210308             iter;
017707210304
017708210304           EndIf;
017709210303
017710210303
017711210304         enddo;
017712210303
017713210304         btnCancel = *off;
017714210303
017715210303       End-Proc;
017716210303
017717210304       // ----------------------------------------------------------------
017718210308       Dcl-Proc Delete_MedData;
017719210304
017720210304
017721210304         Dou btnCancel = *on;
017722210304
017723210308           exfmt DelMed;
017724210304
017725210304           if btnDelete = *on;
017726210304
017727210308             chain ( s2Trst  : s2Sub# : s2Acct : s2PlanId ) BeneCovgp;
017728210308             if %Found( BeneCovgp );
017729210308               Delete BeneCovgp;
017730210308               leave;
017731210308             EndIf;
017732210308
017733210308
017734210306           endif;
017735210306         enddo;
017736210304         btnCancel = *off;
017737210304
017738210304       End-Proc;
017739210304
017740210304
017741210306      *-------------------------------------------------------------------------
017742210306      * Split out the account number
017743210306      *-------------------------------------------------------------------------
017744210306       Dcl-Proc Split;
017745210306
017746210306         dcl-s x int(10);
017747210306         dcl-s tokens varchar(100) dim(50);
017748210306         dcl-s Trst Char(3);
017749210306         dcl-s Sub  Char(3);
017750210306         dcl-s Acct Char(4);
017751210306
017752210306         tokens(*) = #Gettok( wtsa : '-' : x );
017753210306
017754210306
017755210306         // we should have 3 array elements filled  in.
017756210306         // the next blank space should be #4.
017757210306         x = %lookup( '' : tokens ) ;
017758210306         if x = 4;
017759210306           Trst = #zFill( 3 : %Trim( Tokens(1) ));
017760210306           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
017761210306           Acct = #zFill( 4 : %Trim( Tokens(3) ));
017762210306
017763210306           wtsa = trst + '-' + Sub + '-' + Acct;
017764210306
017765210306         EndIf;
017766210306
017767210306
017768210306       End-Proc;
017769210306
017770210308
017771210308       // ----------------------------------------------------------------
017772210308       //
017773210308       //
017774210308       //   Dental Data
017775210308       //
017776210308       //
017777210308       // ----------------------------------------------------------------
017778210308       Dcl-Proc Load_DenData;
017779210308
017780210308         s2Tsa = s1Tsa;
017781210308         s2GrpName = s1GrpName;
017782210308
017783210308         s2Trst = s1Trst;
017784210308         s2Sub# = s1Sub#;
017785210308         s2Acct = s1Acct;
017786210308
017787210308         s2PlanId = s1PlanId;
017788210308
017789210308         chain ( s2Trst : s2Sub# : s2Acct : s2PlanId ) DntlCovgp;
017790210308         if %Found( DntlCovgp );
017791210308           s2Desc = lbDesc;
017792210308           s2clas1 = lbclas1;
017793210308           s2clas2 = lbclas2;
017794210308           s2clas3 = lbclas3;
017795210308           s2clas4 = lbclas4;
017796210308           s2clas5 = lbclas5;
017797210308           s2indded = lbindded;
017798210308           s2famded = lbfamded;
017799210308           s2annmax = lbannmax;
017800210308           s2orthmax = lborthmax;
017801210308         EndIf;
017802210308
017803210308         s2PlanDsc = '';
017804210308         chain ( s2Trst : s2Sub#: s2PlanId ) PlnMst;
017805210308         if %Found( PlnMst ) ;
017806210308           s2PlanDsc = pdescr;
017807210308         EndIf;
017808210308
017809210308
017810210308       End-Proc;
017811210308
017812210308
017813210308       // ----------------------------------------------------------------
017814210308       Dcl-Proc Edit_DenData;
017815210308
017816210308         Dou btnCancel = *on;
017817210308
017818210308           exfmt EditDen;
017819210308
017820210308           if btnAccept = *on;
017821210308             lbDesc = s2Desc;
017822210308
017823210308             lbClas1 = s2Clas1;
017824210308             lbClas2 = s2Clas2;
017825210308             lbClas3 = s2Clas3;
017826210308             lbClas4 = s2Clas4;
017827210308             lbClas5 = s2Clas5;
017828210308
017829210308             lbindded = s2indded;
017830210308             lbfamded = s2famded;
017831210308             lbannmax = s2annmax;
017832210308             lborthmax = s2orthmax;
017833210308
017834210308             update rDntlCovgp;
017835210308
017836210308             leave;
017837210308           EndIf;
017838210308
017839210308         enddo;
017840210308
017841210308         unlock DntlCovgp;
017842210308         btnCancel = *off;
017843210308
017844210308       End-Proc;
017845210308
017846210308       // ----------------------------------------------------------------
017847210308       Dcl-Proc Add_DenData;
017848210308
017849210308
017850210308         Clear AddDen;
017851210308
017852210308
017853210308
017854210308         Dou btnCancel = *on;
017855210308
017856210308           exfmt AddDen;
017857210308           errAccount = *off;
017858210308           errPlan = *off;
017859210308           s2MSg = '';
017860210308
017861210308
017862210308
017863210308           //-------------------------------------------------
017864210308           // Check to see if the Account Number has changed.
017865210308           //-------------------------------------------------
017866210308           if btnLookup = *on;
017867210308             s2GrpName = '';
017868210308
017869210308             wtsa = s2tsa;
017870210308             // For the people who press "Field+"
017871210308             wtsa =  %ScanRpl( '+' : '-' : wtsa );
017872210308
017873210308             split();
017874210308             s2tsa = wtsa;
017875210308
017876210308             if %check( digits : %Subst( s2tsa : 1 : 3)) = 0  and
017877210308                %check( digits : %Subst( s2tsa : 5 : 3)) = 0  and
017878210308                %check( digits : %Subst( s2tsa : 9 : 4)) = 0 ;
017879210308
017880210308               s2Trst = %Dec( %Subst( s2tsa : 1 : 3) : 3 : 0 );
017881210308               s2Sub# = %Dec( %Subst( s2tsa : 5 : 3) : 3 : 0 );
017882210308               s2Acct = %Dec( %Subst( s2tsa : 9 : 4) : 4 : 0 );
017883210308
017884210308               chain ( s2Trst : s2Sub# : s2Acct ) AccMst;
017885210308               if not %Found( AccMst );
017886210308                 ErrAccount = *on;
017887210308               else;
017888210308                 s2GrpName = acNam1;
017889210308               endif;
017890210308
017891210308             else;
017892210308               errAccount = *on;
017893210308             endif;
017894210308
017895210308             iter;
017896210308           endif;
017897210308
017898210308
017899210308
017900210308           //-------------------------------------------------
017901210308           // Search for Plan ID.
017902210308           //-------------------------------------------------
017903210308           if btnPlan = *on;
017904210308
017905210308             if s2Trst = 0 or s2Sub# = 0 or s2Acct = 0;
017906210308               ErrAcct = *on;
017907210308               iter;
017908210308             EndIf;
017909210308
017910210308             oTrst = s2Trst;
017911210308             oSub# = s2Sub#;
017912210308             oAcct = s2Acct;
017913210308
017914210916             wn0012r( oTrst : oSub# : oAcct : oPlan : oCancel:oCls);
017915210308             if oCancel = '';
017916210308               s2Planid = oPlan;
017917210308               chain ( s2Trst : s2Sub# : s2PlanID) PlnMst;
017918210308               if %Found( PlnMst ) ;
017919210308                 s2PlanDsc = pDescr;
017920210308               EndIf;
017921210308
017922210308             EndIf;
017923210308
017924210308             btnPlan = *off;
017925210308             iter;
017926210308           EndIf;
017927210308
017928210308
017929210308
017930210308
017931210308           if btnSearch = *on;
017932210308
017933210308             cAcct = '';
017934210308             iDescr = '';
017935210308
017936210308             Acct_Window(cAcct : iDescr );
017937210308             if cAcct > '';
017938210308               s2Trst = %Dec( %Subst(cAcct:1:3):3:0);
017939210308               s2Sub# = %Dec( %Subst(cAcct:5:3):3:0);
017940210308               s2Acct = %Dec( %Subst(cAcct:9:4):4:0);
017941210308
017942210308               s2Tsa = cAcct;
017943210308               s2GrpName = iDescr;
017944210308             endif;
017945210308             iter;
017946210308           endif;
017947210308
017948210308
017949210308           //------------------------------------
017950210308           //
017951210308           // Accept: Add Record
017952210308           //
017953210308           //------------------------------------
017954210308           if btnAccept = *on;
017955210308
017956210308             // Alrady Setup?
017957210308             chain (s2Trst : s2Sub# : s2Acct : s2PlanId ) DntlCovgp;
017958210308             if %Found( DntlCovgp );
017959210308               errPlan = *on;
017960210308               iter;
017961210308             EndIf;
017962210308
017963210308
017964210308             //-------------------------------------------------
017965210308             // Write Record.
017966210308             //-------------------------------------------------
017967210308             lbTrst = s2Trst;
017968210308             lbSub# = s2Sub#;
017969210308             lbAcct = s2Acct;
017970210308             lbplan = s2Planid;
017971210308
017972210308             lbDesc = s2Desc;
017973210308
017974210308             lbClas1 = s2Clas1;
017975210308             lbClas2 = s2Clas2;
017976210308             lbClas3 = s2Clas3;
017977210308             lbClas4 = s2Clas4;
017978210308             lbClas5 = s2Clas5;
017979210308
017980210308             lbindded = s2indded;
017981210308             lbfamded = s2famded;
017982210308             lbannmax = s2annmax;
017983210308             lborthmax = s2orthmax;
017984210308
017985210308             Write rDntlCovgp;
017986210308
017987210308
017988210308             s2Msg = 'Plan: ' + s2PlanId + ' has been added.';
017989210308
017990210308             s2Planid = '';
017991210308             iter;
017992210308
017993210308           EndIf;
017994210308
017995210308
017996210308         enddo;
017997210308
017998210308         btnCancel = *off;
017999210308
018000210308       End-Proc;
018001210308
018002210308       // ----------------------------------------------------------------
018003210308       Dcl-Proc Delete_DenData;
018004210308
018005210308
018006210308         Dou btnCancel = *on;
018007210308
018008210308           exfmt DelDen;
018009210308
018010210308           if btnDelete = *on;
018011210308
018012210308             chain ( s2Trst  : s2Sub# : s2Acct : s2PlanId ) DntlCovgp;
018013210308             if %Found( DntlCovgp );
018014210308               Delete DntlCovgp;
018015210308               leave;
018016210308             EndIf;
018017210308
018018210308
018019210308           endif;
018020210308         enddo;
018021210308         btnCancel = *off;
018022210308
018023210308       End-Proc;
018024210308
018025210308
018026210308
018027210308
018028210308
