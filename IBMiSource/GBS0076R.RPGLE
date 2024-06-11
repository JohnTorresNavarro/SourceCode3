000001210825
000100210823       Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000101210823       DftActGrp(*no)
000102210823       bnddir('GBSBIND' )   ;
000103210823
000104210823      *-------------------------------------------------------------------------
000105210823      *
000106210823      *  Description: Omit EASE Plans Maintenance
000107210823      *  Programmer.: Brian Rees
000108210823      *  Date.......: 08/23/2021
000109210823      *
000110210823      *-------------------------------------------------------------------------
000111210823
000112210823      *-------------------------------------------------------------------------
000113210823      *
000114210823      * Declare Files
000115210823      *
000116210823      *-------------------------------------------------------------------------
000117210823       Dcl-f GBS0076D WorkStn
000118210823          Handler('PROFOUNDUI(HANDLER)')
000119210823          SFILE(LstSfl:rrn);
000120210823
000121210823       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
000122210823       dcl-f EaseOmit keyed usage(*Input : *output : *update : *delete );
000123210825       dcl-f EasePlanl1 keyed;
000124210825       dcl-f Payfplanp keyed;
000125210825       dcl-f PlanxRefp keyed;
000126210825
000127210823
000128210823
000129210823      *-------------------------------------------------------------------------
000130210823      *
000131210823      * Global Variables
000132210823      *
000133210823      *-------------------------------------------------------------------------
000134210823
000135210823       dcl-ds pgmd
000136210823          ExtName('IOPGMD') PSDS;
000137210823         @pgmq *proc;
000138210823       end-ds;
000139210823
000140210823
000141210823       dcl-s rrn Zoned(5);
000142210823       dcl-s Split_Acct# varchar(100) dim(10);
000143210823       dcl-c digits  '0123456789';
000144210823
000145210823       dcl-s wTrst    Zoned(3);
000146210823       dcl-s wSub#    Zoned(3);
000147210823       dcl-s wAcct    Zoned(4);
000148210823       dcl-s wActNbr like( s2ActNbr );
000149210825       dcl-s caret Char(1);
000150210823
000151210823
000152210823      *--------------------------------------------
000153210823      *
000154210823      * Procedures
000155210823      *
000156210823      *--------------------------------------------
000157210823       /include GBSPGM/QMODSRC,#zFillpr
000158210823
000159210825       dcl-pr wn0011r ExtPgm('WN0011R');
000160210825         oAcct Char(12);
000161210825         oAcctName Char(40);
000162210825       end-Pr;
000163210825
000164210825
000165210825
000166210823      *-------------------------------------------------------------------------
000167210823      *
000168210823      * Mainline Program
000169210823      *
000170210823      *-------------------------------------------------------------------------
000171210823       Dou btnExit = *on;
000172210823
000173210823         ClearS1();
000174210823         LoadS1();
000175210823
000176210823         DisplyS1();
000177210823
000178210823
000179210823         // Process Selections
000180210823         Select;
000181210823
000182210823
000183210823         When btnReset = *on;
000184210823           s1Search = *blanks;
000185210823
000186210823         When BtnAddNew = *on;
000187210823           Add_Rcd();
000188210823
000189210823         other;
000190210823           ReadChangedS1();
000191210823
000192210823         EndSl;
000193210823
000194210823
000195210823       enddo;
000196210823
000197210823       *inlr = *on;
000198210823
000199210823
000200210823
000201210823       // ----------------------------------------------------------------
000202210823       dcl-proc CLEARS1;
000203210823
000204210823         //-------------------------
000205210823         //
000206210823         // Clear the Subfile
000207210823         //
000208210823         //-------------------------
000209210823
000210210823         SflClr = *on;
000211210823         Write LstCtl;
000212210823         SflClr= *off;
000213210823         rrn = 0;
000214210823
000215210823       End-Proc;
000216210823       // ----------------------------------------------------------------
000217210823       Dcl-Proc LoadS1;
000218210823
000219210823         Setll *loval EaseOmit;
000220210823         Dou %eof(EaseOmit);
000221210823
000222210823           read EaseOmit;
000223210823           if %eof(EaseOmit);
000224210823             leave;
000225210823           endif;
000226210823
000227210823           s1Trst = j_Trst;
000228210823           s1Sub# = j_Sub#;
000229210823           s1Acct = j_Acct;
000230210823
000231210823           s1AcctNbr = %Editc(j_Trst:'X') + '-' +
000232210823           %Editc(j_sub#:'X') + '-' +
000233210823           %Editc(j_Acct:'X') ;
000234210823
000235210823           s1ActNam = '';
000236210823           chain ( j_Trst : j_Sub# : j_Acct ) AccMst;
000237210823           if %Found( AccMst ) ;
000238210823             s1ActNam = AcNam1;
000239210823           EndIf;
000240210823
000241210823           s1PlanName = j_Plan;
000242210823
000243210823
000244210823           s1FromDt = '';
000245210823           if j_StrDate > 0;
000246210823             test(de) *iso j_StrDate;
000247210823             if %Error;
000248210823               s1FromDt = %Char(j_StrDate);
000249210823             else;
000250210823               s1FromDt = %Char(%date(j_StrDate) :*usa)  ;
000251210823             endif;
000252210823           endif;
000253210823
000254210823
000255210823
000256210823           s1ToDate = '';
000257210823           if j_EndDate > 0;
000258210823             test(de) *iso j_EndDate;
000259210823             if %Error;
000260210823               s1ToDate = %Char(j_EndDate);
000261210823             else;
000262210823               s1ToDate = %Char(%date(j_EndDate) :*usa)  ;
000263210823             endif;
000264210823           endif;
000265210823
000266210823           if s1Search = *blanks;
000267210823             rrn = rrn + 1;
000268210823             write LstSfl;
000269210823
000270210823           else;   // Search Field
000271210823             if %scan( %Trim(s1Search) : s1AcctNbr ) > 0 or
000272210823             %scan( %Trim(s1Search) : s1ActNam ) > 0 or
000273210823             %scan( %Trim(s1Search) : s1PlanName ) > 0 ;
000274210823
000275210823               rrn = rrn + 1;
000276210823               write LstSfl;
000277210823             endif;
000278210823           endif;
000279210823
000280210823           If rrn >= 9999;
000281210823             leave;
000282210823           endIf;
000283210823
000284210823         enddo;
000285210823
000286210823       End-Proc;
000287210823
000288210823       // ----------------------------------------------------------------
000289210823       Dcl-Proc DisplyS1;
000290210823
000291210823         SflDsp = *on  ;
000292210823         exfmt LstCtl;
000293210823         SflDsp = *off;
000294210823
000295210823       End-Proc;
000296210823
000297210823       // ----------------------------------------------------------------
000298210823       Dcl-Proc ReadChangedS1;
000299210823
000300210823         Dou *in95 = *ON;
000301210823           READC LstSfl;
000302210823           *in95 = %EOF;
000303210823
000304210823           If *in95 = *OFF;
000305210823
000306210823
000307210823             if btnEdit = *on;
000308210823               Clear editScreen;
000309210825               Load_Data();
000310210825               Chg_Data();
000311210823             endIf;
000312210823
000313210823
000314210823             if btnView = *on;
000315210823               Load_Data();
000316210823               Dou btnCancel = *on;
000317210825                 exfmt ViewScreen;
000318210823               enddo;
000319210823
000320210825               btnCancel = *off;
000321210823
000322210823
000323210823             endIf;
000324210823
000325210823
000326210823             if btnDelete = *on;
000327210823               chain ( s1Trst : s1Sub#: s1Acct : s1PlanName ) EaseOmit;
000328210823               if %Found( EaseOmit );
000329210823                 delete r_EaseOmit;
000330210823               EndIf;
000331210823             EndIf;
000332210823
000333210823
000334210823             btnView = *off;
000335210823             btnEdit = *off;
000336210823             btnDelete = *off;
000337210823             update LstSfl;
000338210823
000339210823           endIf;
000340210823
000341210823         enddo;
000342210823
000343210823       End-Proc;
000344210823
000345210823       // ----------------------------------------------------------------
000346210823       dcl-proc Add_Rcd;
000347210823
000348210823         dcl-s x zoned(3);
000349210823
000350210823         dcl-s Trst Char(3);
000351210823         dcl-s Sub  Char(3);
000352210823         dcl-s Acct Char(4);
000353210825
000354210823         Clear AddScreen;
000355210823
000356210824
000400210824
000401210824
000402210823         Dou btnCancel = *on;
000403210823
000404210823
000405210823           Exfmt AddScreen;
000406210823           errAccount = *off;
000407210823           errPlan = *off;
000409210823           s2Msg = '';
000410210823
000411210823
000412210825           // Search for an account by Name.
000413210825           if btnSearch = *on;
000414210825             s2ActNbr = '';
000416210825             wn0011r( s2ActNbr : s2ActName ) ;
000417210825             if s2ActNbr > '';
000418210825               //s2ActNbr = %ScanRpl('-' : '' : s2ActNbr ) ;
000420210825               ActChgd = *on;
000421210825             EndIf;
000423210825           EndIf;
000424210825
000425210825
000426210825
000427210825
000428210825
000429210823           //---------------------------------------------------
000430210823           //
000431210823           // Check to see if the Account Number has changed.
000432210823           //
000433210823           //---------------------------------------------------
000434210823           if ActChgd = *on;
000435210823
000436210823             // For the people who press "Field+"
000437210823             s2ActNbr = %ScanRpl( '+' : '-' : s2ActNbr );
000438210825
000439210825             Clear Split_Acct#;
000441210825             Split_Acct# = %Split( s2ActNbr : '-' );
000442210823
000443210823
000444210823             // we should have 3 array elements filled  in.
000445210823             // the next blank space should be #4.
000446210823             x = %lookup( '' : Split_Acct# ) ;
000447210823             if x = 4;
000448210823               trst = #zFill( 3 : Split_Acct#(1) );
000449210823               Sub  = #zFill( 3 : Split_Acct#(2) );
000450210823               Acct = #zFill( 4 : Split_Acct#(3) );
000451210823
000452210823               s2ActNbr = trst + '-' + Sub + '-' + Acct;
000453210823
000454210823             EndIf;
000455210823
000456210823             wActNbr = s2ActNbr;
000457210823
000458210823             s2ActNbr = %ScanRpl( '-' : '' : s2ActNbr );
000459210823             s2ActNbr = %ScanRpl( ' ' : '' : s2ActNbr );
000460210823
000461210823
000462210823
000463210823             if %check( digits : %Trim( s2ActNbr )) = 0  and
000464210823                %Len(%Trim( s2ActNbr )) = 10;
000465210823
000466210823               wTrst = %Dec( %Subst( s2ActNbr : 1 : 3) : 3 : 0 );
000467210823               wSub# = %Dec( %Subst( s2ActNbr : 4 : 3) : 3 : 0 );
000468210823               wAcct = %Dec( %Subst( s2ActNbr : 7 : 4) : 4 : 0 );
000469210823
000470210823               chain ( wTrst : wSub# : wAcct ) AccMst;
000471210823               if not %Found( AccMst );
000472210823                 ErrAccount = *on;
000473210823                 s2ActNBr = wActNbr;
000474210823                 iter;
000475210823
000476210823               else;
000477210823
000478210823                 // Found
000479210823                 s2ActName = acNam1;
000480210823               endif;
000481210823
000482210823             else;
000483210823
000484210823               // Not a valid number
000485210823               ErrAccount = *on;
000486210823               iter;
000487210823
000488210823             endif;
000489210823
000490210825
000491210825
000492210825             Build_DropDown();
000493210823           endif;   // Account Changed
000494210823
000495210823
000496210823
000497210823           //------------------------------------------
000498210823           //
000499210823           // Accept Button pressed.  Add Record
000500210823           //
000501210823           //------------------------------------------
000502210823           if btnAccept = *on;
000503210823
000504210823             //--------------------
000505210823             //
000506210823             // Verify...
000507210823             //
000508210823             //--------------------
000509210823
000510210823
000511210823             // Split Account Number
000512210823             wTrst = %Dec( %Subst( s2ActNbr : 1 : 3) : 3 : 0 );
000513210823             wSub# = %Dec( %Subst( s2ActNbr : 4 : 3) : 3 : 0 );
000514210823             wAcct = %Dec( %Subst( s2ActNbr : 7 : 4) : 4 : 0 );
000515210823
000516210823             chain(N) ( wTrst : wSub# : wAcct : s2PlanName ) EaseOmit;
000517210823             if %Found( EaseOmit ) ;
000518210823               errPlan = *on;
000519210823               iter;
000520210823             EndIf;
000521210823
000522210823
000523210823
000524210823             // Still here; Add Record
000525210823             j_trst = wTrst;
000526210823             j_Sub# = wSub#;
000527210823             j_Acct = wAcct;
000528210823
000529210826             j_Plan = %upper(s2PlanName);
000530210823             j_StrDate = 0;
000531210823             if s2FromDt > '';
000532210823               j_StrDate = %dec(%char(%date(s2FromDt:*usa/):*iso0):8:0);
000533210823             endif;
000534210823
000535210823             j_EndDate = 0;
000536210823             if s2ToDt > '';
000537210823               j_EndDate = %dec(%char(%date(s2ToDt:*usa/):*iso0):8:0);
000538210823             endif;
000539210823
000540210823             j_Crtby = wqusrn;
000541210823             j_CrtDt = %Dec(%Date);
000542210823             j_CrtTm = %Dec(%Time);
000543210823
000544210823             j_ChgBy = '';
000545210823             j_ChgDt = 0;
000546210823             j_ChgTm = 0;
000547210823
000548210823             write r_EaseOmit;
000549210823
000550210823             s2Msg = 'Plan: ' + %Trim( j_Plan ) + ' Added';
000551210823
000552210823
000553210823           EndIf;
000554210823
000555210823
000556210823         EndDo;
000557210823
000558210823         btnCancel = *off;
000559210823
000560210823
000561210823
000562210823       end-proc;
007500210815
007501210823       // ----------------------------------------------------------------
007502210823       dcl-proc Load_Data;
007503210823
007504210823
007505210823         Chain(n) ( s1trst : s1Sub# : s1Acct : s1PlanName ) EaseOmit;
007506210823
007507210823         s2Trst = s1Trst;
007508210823         s2Sub# = s1Sub#;
007509210823         s2Acct = s1Acct;
007510210823         s2ActNbr = s1AcctNbr;
007511210823         s2ActName = s1ActNam;
007512210823
007514210823
007515210823         s2PlanName = s1PlanName;
007516210823
007517210823         s2FromDt = s1FromDt;
007518210823         s2ToDt   = s1ToDate;
007519210823
007520210825         if j_CrtDt > 0;
007521210825           s2Created = 'Record Created by ' + %Trim( j_CrtBy ) + ' on ' +
007522210825            %Char(%date(j_CrtDt:*iso) :*usa) + ' at ' +
007523210825            %Char(%Time(j_CrtTm:*iso) :*usa);
007524210825         endif;
007525210823
007526210823
007527210825         if j_ChgDt > 0;
007528210825           s2Changed = 'Record Changed by ' + %Trim( j_Chgby ) + ' on ' +
007529210825            %Char(%date(j_ChgDt:*iso) :*usa) + ' at ' +
007530210825            %Char(%Time(j_ChgTm:*iso) :*usa);
007531210825         endif;
007532210823
007533210823
007534210823       End-Proc;
007535210823
007536210823       // ----------------------------------------------------------------
007537210823       dcl-proc Chg_Data;
007538210823
007540210823         Dou btnCancel = *on;
007541210823
007543210823           Exfmt EditScreen;
007547210823           s2Msg = '';
007548210823
007549210823
007613210823           //------------------------------------------
007614210823           //
007615210823           // Accept Button pressed.  Add Record
007616210823           //
007617210823           //------------------------------------------
007618210823           if btnAccept = *on;
007619210823
007620210823             Chain ( s2Trst : s2Sub# : s2Acct: s2PlanName ) EaseOmit;
007621210823
007650210823             j_StrDate = 0;
007651210823             if s2FromDt > '';
007652210823               j_StrDate = %dec(%char(%date(s2FromDt:*usa/):*iso0):8:0);
007653210823             endif;
007654210823
007655210823             j_EndDate = 0;
007656210823             if s2ToDt > '';
007657210823               j_EndDate = %dec(%char(%date(s2ToDt:*usa/):*iso0):8:0);
007658210823             endif;
007659210823
007660210823             j_Chgby = wqusrn;
007661210823             j_ChgDt = %Dec(%Date);
007662210823             j_ChgTm = %Dec(%Time);
007663210823
007668210823             Update r_EaseOmit;
007669210823
007670210823             leave;
007671210823
007672210823
007673210823           EndIf;
007674210823
007675210823
007676210823         EndDo;
007677210823
007678210823         btnCancel = *off;
007679210823
007680210823
007681210823
007682210823       end-proc;
007683210823
007684210825       // ----------------------------------------------------------------
007685210825       dcl-proc Build_DropDown;
007686210825
007687210825
007688210825         //---------------------------------------------------
007689210825         //
007690210825         // Build Drop Down for ADD Screen
007691210825         //
007692210825         //---------------------------------------------------
007693210825
007694210825         inValue = '';
007695210825         inChoice = '';
007696210825
007697210825         Setll ( wTrst : wSub# : wAcct ) Payfplanp;
007698210825
007699210825         Dou %Eof(Payfplanp);
007700210825           reade ( wTrst : wSub# : wAcct ) Payfplanp;
007701210825           if %eof(Payfplanp);
007702210825             leave;
007703210825           endif;
007704210825
007705210825           inValue = %Trim( inValue )  + ',' + %trim( pfInPlan );
007706210825
007707210825
007708210825           // Check if the plan was already used.
007709210825           caret = '';
007710210825           chain ( wTrst : wSub# : wAcct : pfInPlan ) PlanxRefp;
007711210825           if %Found( PlanxRefp ) ;
007712210825             caret = '~';
007713210825           EndIf;
007714210825
007715210825
007716210825           if %Subst(pfInPlan : 1 : 9) = 'EASE_PLAN';
007717210825             chain ( wTrst : wSub# : wAcct : pfInPlan ) EasePlanl1;
007718210825             if %Found( EasePlanl1 );
007719210825               inChoice = %Trim(inChoice) + ',' + caret + %trim( p_PlanName );
007720210825             else;
007721210825               inChoice = %Trim(inChoice) + ',' + caret + %trim( pfInPlan );
007722210825
007723210825             EndIf;
007724210825
007725210825           else;
007726210825             inChoice = %Trim(inChoice) + ',' + caret + %trim( pfInPlan );
007727210825           EndIf;
007728210825         Enddo;
007729210825
007730210825         inValue = %Subst(inValue:2);
007731210825         inChoice = %Subst(inChoice:2);
007732210825
007737210825
007738210825       End-Proc;
007739210825
007740210825
