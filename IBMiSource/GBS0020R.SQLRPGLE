000001210304       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no)
000002210303          bnddir('GBSBIND');
000003210303
000006210303      *-------------------------------------------------------------------------
000007210303      *
000008210303      *  Description: NVA File Transfer Maintenance
000009210303      *  Programmer.: Brian Rees
000010210303      *  Date.......: 07/26/2017
000011210303      *
000012210303      *-------------------------------------------------------------------------
000013210303      *
000014210303      *  09/04/2018  J. Torres  Added call to new send/not send program that maintains new file
000015210303      *  11/26/2019  J. Torres  changed to differnt prototype to send/not send pgm that maintains
000016210303      *                         new file
000017210303      *  01/02/2020  J. Torres  Fixed parm to TROFF2
000018210303      *  03/03/2021  B.Rees     Redesigned for PL.
000019210303      *
000020210303      *-------------------------------------------------------------------------
000021210303
000022210303
000024210303      *-------------------------------------------------------------------------
000025210303      *
000026210303      * Declare Files
000027210303      *
000028210303      *-------------------------------------------------------------------------
000029210303       Dcl-f Gbs0020d WorkStn
000030210303          Handler('PROFOUNDUI(HANDLER)')
000031210303          SFILE(LstSfl:rrn)    ;
000033210303
000034210303       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
000035210303       dcl-f CarAccp keyed usage( *input : *output : *update : *Delete );
000036210304       dcl-f CarPlnp keyed usage( *Delete );
000037210304       dcl-f Transoff1  keyed usage( *Delete );
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
000057210303       dcl-s reload Char(1);
000058210303       dcl-s UniqueId Char(10);
000061210303       dcl-s canEdit ind;
000062210304       dcl-s canDelete ind;
000063210304       dcl-s iDescr40 Char(40);
000098210303
000099210303      *--------------------------------------------
000100210303      *
000101210303      *  Procedures
000102210303      *
000103210303      *--------------------------------------------
000104210303      /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
000106210303      /include *LIBL/QMODSRC,#ChkFncAth        // Check Function Authority
000107210303
000108210303
000109210303       dcl-pr PlanMaint ExtPgm('GBS0020R1');
000110210303         oTrst Zoned(3) Const;
000111210303         oSub# Zoned(3) Const;
000112210303         oAcct Zoned(4) Const;
000114210303       End-Pr;
000115210303
000116210303       dcl-pr PrintList ExtPgm('GBS0020R1') end-pr;
000117210303
000129210303
000130210303       dcl-pr Acct_Window ExtPgm('WN0011R');
000133210304         cAcct Char(12) Const;
000134210303         iDescr Char(40) const;
000136210303       End-Pr;
000137210303       dcl-s cAcct Char(12);
000147210303
000148210303
000156210303       dcl-pr transOff ExtPgm('TROFF2');
000157210304         trust# packed(3) Const;
000158210304         Sub#   packed(3) Const;
000159210304         Accno  packed(4) Const;
000160210304         inCarrier packed(2) const;
000161210303         inOption Char(1) const;
000162210303         inhistory Char(1) const;
000163210303       End-Pr;
000164210303
000165210304
000166210304       dcl-s inCarrier packed(2);
000167210303       dcl-s inOption Char(1);
000168210303       dcl-s inHistory Char(1);
000169210303
000174210303       dcl-pr AccountInq ExtPgm('INQ008R');
000175210303         oTrst Zoned(3);
000176210303         oSub# Zoned(3);
000177210303         oAcct Zoned(4);
000178210303       End-Pr;
000179210303       dcl-s oTrst Zoned(3);
000180210303       dcl-s  oSub# Zoned(3);
000181210303       dcl-s  oAcct Zoned(4);
000182210303
000183210303
000184210303
000185210303      *-------------------------------------------------------------------------
000186210303      *
000187210303      * Mainline Program
000188210303      *
000189210303      *-------------------------------------------------------------------------
000190210303
010500210304       Exec Sql
010501210304         Set Option Commit = *NONE, Naming = *SYS;
010600170726       UniqueID = '0000000115';
010700160804
010701210303       Init();
010702210303
010703210303
010704210303       Dou btnExit = *on;
010705210303
010706210303         if reload = 'Y';
010707210303           ClearS1();
010708210303           LoadS1();
010709210303           reload = 'N';
010710210303         endif;
010711210303
010712210303         DisplyS1();
010713210303
010714210303
010715210303         //?Process Selections
010716210303         Select;
010717210303
010718210303
010719210303         When btnAddNew = *on;
010720210303           reload = 'Y';
010722210303           Add_Data();
010723210303
010724210304         when SrchChgd = *on;
010725210304           reload = 'Y';
010726210304
010727210303         when actChgd = *on;
010728210303           reload = 'Y';
010729210303           sflscroll = 0;
010730210303
010731210303         When btnRefresh = *on;
010732210303           Reload = 'Y';
010733210303           s1Search = *blanks;
010734210303
010735210303         other;
010736210303           ReadChangedS1();
010737210303
010738210303         EndSl;
010739210303
010740210303
010741210303       enddo;
010742210303
010743210303       *inlr = *on;
010744210303
015200210303       // ----------------------------------------------------------------
015300210303       dcl-Proc Init;
015400151216
015401210303         reload = 'Y';
015402210303
015700210303         //?User Allowed to Edit?
015800210303         canEdit = *off;
016000210303         oFunction = 'EDIT';
016100210303         oDspErrMsg = 'N';
016200160729
016300210303         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
016400210303         if oContinue = 'Y';
016500210303           canEdit = *on;
016700210303         endif;
017000160729
017001210304         //?User Allowed to Delete?
017002210304         canDelete = *off;
017003210304         oFunction = 'DELETE';
017004210304         oDspErrMsg = 'N';
017005210304
017006210304         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
017007210304         if oContinue = 'Y';
017008210304           canDelete = *on;
017009210304         endif;
017010210304
017011210304
017100210303       End-Proc;
017101210303
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
017151210303       Dcl-Proc LoadS1;
017241210303
017242210303         Setll UniqueId CarAccp;
017243210303         Dou %eof(CarAccp);
017244210303
017245210303           reade UniqueId CarAccp;
017246210303           if %eof(CarAccp);
017247210303             leave;
017248210303           endif;
017249210303
017250210303           s1Trst = caTrst;
017251210303           s1Sub# = caSub#;
017252210303           s1Acct = caAcct;
017253210303
017254210303           s1Tsa = %editc(caTrst : 'X') + '-' +
017255210303                   %editc(caSub# : 'X') + '-' +
017256210303                   %editc(caAcct : 'X') ;
017257210303           s1Tsa_nd = %ScanRpl('-' : '' : s1Tsa);
017258210303
017259210303           s1Status = caStatus;
017260210303           s1Cid1 = caCid1;
017261210303           s1Cid2 = caCid2;
017262210303           s1GrpName = '';
017263210303
017264210303           chain ( caTrst : caSub# : caAcct ) AccMst;
017265210303           if %Found( AccMst ) ;
017266210303             s1GrpName = acNam1;
017268210303           EndIf;
017269210303
017270210303           // Get Member Count
017271210304           Exec Sql
017272210304             Select Count(*)
017273210304               Into :S1count
017274210304               From "F.MCOV"
017275210304               Where Mctrst = :s1trst And
017276210304                     Mcsub# = :s1sub# And
017277210304                     Acc# = :s1acct And
017278210304                     Mcplan in (select cpPlan
017279210304                         from carplnp
017280210304                         Where cpUniq = '0000000115' and
017281210304                               cpTrst = :s1Trst and
017282210304                               cpSub# = :s1Sub# and
017283210304                               cpAcct = :s1Acct) and
017284210304                     Candt = 0;
017285210303
017286210303           s1Termed = '';
017287210303           if ATRMDT > 0 and ATRMDT  < %Dec(%Date);
017288210303             s1Termed = 'Y';
017289210303           EndIf;
017290210303
017291210303
017292210303           if s1Active = 'Y' and s1Status <> 'Y';
017293210303             iter;
017294210303           EndIf;
017295210303
017296210303           If s1Search = *Blanks;
017297210303             rrn = rrn + 1;
017298210303             write LstSfl;
017299210303           endIf;
017300210303
017301210303
017302210303           If s1Search > *Blanks;
017304210303             If %Scan( %Trim(s1Search) : uCase(s1GrpName) ) > 0  or
017305210303                %Scan( %Trim(s1Search) : s1tsa_Nd) > 0   or
017306210303                %Scan( %Trim(s1Search) : s1cid1) > 0  or
017307210303                %Scan( %Trim(s1Search) : s1cid2) > 0  ;
017308210303               rrn = rrn + 1;
017309210303               write LstSfl;
017310210303             endIf;
017311210303           endIf;
017312210303
017313210303
017316210303           If rrn >= 9999;
017317210303             leave;
017318210303           endIf;
017319210303
017320210303         enddo;
017321210303
017322210303       End-Proc;
017323210303
017324210303       // ----------------------------------------------------------------
017325210303       Dcl-Proc DisplyS1;
017326210303
017327210303         SflDsp = *on  ;
017328210303         exfmt LstCtl;
017329210303         SflDsp = *off;
017330210303
017331210303       End-Proc;
017332210303
017333210303       // ----------------------------------------------------------------
017334210303       Dcl-Proc ReadChangedS1;
017335210303
017336210303         Dou *in95 = *ON;
017337210303           READC LstSfl;
017338210303           *in95 = %EOF;
017339210303
017340210303           If *in95 = *OFF;
017341210303
017344210303             if btnEdit = *on;
017345210303               Load_Data();
017346210303               Edit_Data();
017347210303             endIf;
017348210303
017349210304             if runOption = 'mnPlan';
017350210304
017351210304              PlanMaint( s1Trst : s1Sub# : s1Acct ) ;
017352210304             EndIf;
017353210304
017354210304
017355210304             if btnDelete = *on;
017356210304               load_Data();
017357210304               Delete_Data();
017358210304             EndIf;
017359210304
017360210304
017361210303             if btnView = *on;
017362210304               Load_Data();
017363210304               Exfmt ViewScreen;
017364210303             EndIf;
017365210303
017366210303             //------------------------------
017367210303             //
017368210304             // Go to Account Inquiry
017369210304             //
017370210304             //------------------------------
017371210304             if SelAcct = *on;
017372210304               oAcct = s1Acct;
017373210304               oTrst = s1Trst;
017374210304               oSub# = s1Sub# ;
017375210303
017376210304               AccountInq( oTrst : oSub# : oAcct );
017377210303
017378210303             endif;
017379210303
017380210303
017381210303             btnView = *off;
017382210304             selAcct = *off;
017383210304             btnEdit = *off;
017384210304             btnDelete = *off;
017385210304             runOption = '';
017386210304
017387210304             update LstSfl;
017388210304             Reload = 'Y';
017389210303
017390210304           endIf;
017391210303
017392210303         enddo;
017393210303
017394210304       End-Proc;
017395210303
017396210304       // ----------------------------------------------------------------
017397210304       Dcl-Proc Load_Data;
017398210303
017399210303         s2Tsa = s1Tsa;
017400210303         s2GrpName = s1GrpName;
017401210303         s2Cid1 = s1Cid1;
017402210304         s2Cid2 = s1Cid2;
017403210304         s2Status = s1Status;
017404210303
017405210304         s2Trst = s1Trst;
017406210304         s2Sub# = s1Sub#;
017407210304         s2Acct = s1Acct;
017408210304
017409210304
017410210304         chain (UniqueId : s1Trst : s1Sub# : s1Acct) CarAccp;
017411210304         if %Found(CarAccp);
017412210303
017413210304           if caCida = 'N/A';
017414210304             caCida = '';
017415210303           endif;
017416210304           s2CrtDt = caCida;
017417210303
017418210304           if caTxta = 'N/A';
017419210304             caTxta = '';
017420210304           endif;
017421210304           s2ChgDt = catxta;
017422210304         endif;
017423210303
017424210304       End-Proc;
017425210303
017426210303
017427210304       // ----------------------------------------------------------------
017428210304       Dcl-Proc Edit_Data;
017429210303
017430210304         Dou btnCancel = *on;
017431210303
017432210304           exfmt EditScreen;
017433210303
017434210304           if btnAccept = *on;
017435210303
017436210303
017437210303             // Update the CarAccp File.
017438210303             caStatus = s2Status;
017439210303             caCid1 = s2Cid1;
017440210303             caCid2 = s2Cid2;
017441210304             caTxtA = 'Changed: ' + WQUSRN  + %Char(%Dec(%Date));
017442210303
017443210304             Update CarAccr;
017444210303
017445210304             // Update the TransFile.
017446210304             add_toTransfile();
017447210304             leave;
017448210304           EndIf;
017449210303
017450210303
017451210304         enddo;
017452210303
017453210304         btnCancel = *off;
017454210303
017455210304       End-Proc;
017456210303
017457210304       // ----------------------------------------------------------------
017458210304       Dcl-Proc Add_Data;
017459210303
017460210304         Clear AddScreen;
017461210303
017462210304         Dou btnCancel = *on;
017463210303
017464210304           exfmt AddScreen;
017465210304           errAcct = *off;
017466210303
017467210304
017468210304           if btnSearch = *on;
017469210303
017470210304             cAcct = '';
017471210304             iDescr40 = '';
017472210303
017473210304             Acct_Window(cAcct : iDescr40 );
017474210304             if cAcct > '';
017475210304               s2Trst = %Dec( %Subst(cAcct:1:3):3:0);
017476210304               s2Sub# = %Dec( %Subst(cAcct:5:3):3:0);
017477210304               s2Acct = %Dec( %Subst(cAcct:9:4):4:0);
017478210304
017479210304               s2Tsa = cAcct;
017480210304               s2GrpName = iDescr40;
017481210304             endif;
017482210304             iter;
017483210304           endif;
017484210303
017485210304
017486210304           //------------------------------------
017487210304           //
017488210304           // Accept: Add Record
017489210304           //
017490210304           //------------------------------------
017492210304           if btnAccept = *on;
017493210303
017494210304             //------------------------------------
017495210304             // Verify...
017496210304             //------------------------------------
017497210304             chain ( UniqueID : s2Trst : s2Sub# : s2Acct ) CarAccp;
017498210304             if %Found(CarAccp);
017499210304               ErrAcct = *on;
017500210304               iter;
017501210304             EndIf;
017502210304
017503210304
017504210304
017505210304             //------------------------------------
017506210304             // Write to the CarAccp File.
017507210304             //------------------------------------
017508210304             caTrst = s2Trst;
017509210304             caSub# = s2Sub#;
017510210304             caAcct = s2Acct;
017511210304
017512210304             CaTxt1 = 'Export File Name';
017513210304             caCid1 = s2Cid1;
017514210304
017515210304             CaTxt2 = 'Control Id';
017516210304             caCid2 = s2Cid2;
017517210304             caStatus = s2Status;
017518210304
017519210304             cacidA = 'Created: ' + WQUSRN  + %Char(%Dec(%Date));
017520210304             caTxtA = '';
017521210304
017522210304             Write CarAccr;
017523210304
017524210304             add_toTransfile();
017525210304             reload = 'Y';
017526210304             leave;
017527210304
017529210304           EndIf;
017530210303
017531210303
017532210304         enddo;
017533210303
017534210304         btnSearch = *off;
017535210304         btnCancel = *off;
017536210303
017537210303       End-Proc;
017538210303
017539210304       // ----------------------------------------------------------------
017540210304       Dcl-Proc Delete_Data;
017541210304
017542210304
017543210304         Dou btnCancel = *on;
017544210304
017545210304           exfmt DelScreen;
017546210304
017547210304           if btnDelete = *on;
017548210304
017549210304             //--------------------------------------
017550210304             //
017551210304             // Remove from the Account File.
017552210304             //
017553210304             //--------------------------------------
017554210304             Setll ( UniqueID : s2Trst : s2Sub# : s2Acct )  Caraccp;
017555210304
017556210304             Dou %Eof(Caraccp);
017557210304               reade ( UniqueID : s2Trst : s2Sub# : s2Acct )  Caraccp;
017558210304               if %eof(Caraccp);
017559210304                 leave;
017560210304               endif;
017561210304
017562210304               delete   Caraccp;
017563210304             enddo;
017564210304
017565210304
017566210304             //--------------------------------------
017567210304             //
017568210304             // Remove from the Carrier Plan File.
017569210304             //
017570210304             //--------------------------------------
017571210304             Setll ( UniqueID : s2Trst : s2Sub# : s2Acct )  CarPlnp;
017572210304
017573210304             Dou %Eof(CarPlnp);
017574210304               reade ( UniqueID : s2Trst : s2Sub# : s2Acct )  Carplnp;
017575210304               if %eof(Carplnp);
017576210304                 leave;
017577210304               endif;
017578210304
017579210304               delete   Carplnp;
017581210304             Enddo;
017582210304
017583210304
017584210304             //--------------------------------------
017585210304             //
017586210304             // Remove from the Do Not Send File.
017587210304             //
017588210304             //--------------------------------------
017589210304             incarrier = 11;
017590210304
017591210304             Setll ( incarrier : s2Trst : s2Sub# : s2Acct )  transoff1;
017592210304
017593210304             Dou %Eof(transoff1);
017594210304               reade ( inCarrier: s2Trst : s2Sub# : s2Acct )  transoff1;
017595210304               if %eof(transoff1);
017596210304                 leave;
017597210304               endif;
017598210304
017599210304               delete   transr;
017602210304             Enddo;
017603210304
017604210304             reload = 'Y';
017605210304             leave;
017607210304           EndIf;
017610210304         enddo;
017611210304
017612210304         btnCancel = *off;
017613210304
017614210304       End-Proc;
017615210304
017616210304
017617210304
017618210304
017619210304
017620210303       // ----------------------------------------------------------------
017621210303       Dcl-Proc add_toTransfile;
017622210303
017623210304         //-------------------------------------------------
017624210304         //
017625210304         // This writes to the Do Not Send File
017626210304         //
017627210304         //-------------------------------------------------
017628210303
017629210304         incarrier = 11;
017630210304         inhistory = 'Y';
017631210303
017632210304         // transmission on
017633210304         if castatus = 'Y';
017634210304           inoption = 'D';
017635210304         endif;
017636210303
017637210304         // transmission off
017638210304         if castatus = 'N';
017639210304           inoption = 'A';
017640210304         endif;
017641210303
017642210304         transOff(catrst : casub# : caacct : incarrier : inoption : inhistory);
017643210303
017644210303       End-Proc;
017645210303
017646210303
