000100171229
000200171229       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000300171229          ActGrp(*New);
000400171229
000500180102      *-------------------------------------------------------------------------
000600180102      *
000700180102      *  Description:
000800180102      *  Programmer.:  Brian Rees
000900180102      *  Date.......:  05/25/2017
001000180102      *
001100180102      *-------------------------------------------------------------------------
001200191212      * Change Log
001201191212      * 12/12/2019  B.Rees   Added Check for COBRA and ACTIVE Records
001205200113      * 01/13/2020  B.Rees   Added Term Date
001206200113      *
001207200113      *-------------------------------------------------------------------------
001208200113      *
001209191212      *
001210191212      *-------------------------------------------------------------------------
001300171229
001400171229      *-------------------------------------------------------------------------
001500171229      *
001600171229      * Declare Files
001700171229      *
001800171229      *-------------------------------------------------------------------------
001900171229
002000171229       Dcl-f MemAcc  keyed ExtDesc('F.MEMACC')  ExtFile(*ExtDesc);
002100171229       Dcl-f AccMst  keyed ExtDesc('F.ACCMST')  ExtFile(*ExtDesc);
002200171229       Dcl-f CodesL1 keyed ExtDesc('F.CODESL1') ExtFile(*ExtDesc);
002300171229
002400180301       Dcl-f MCov40  keyed ExtDesc('F.MCOV40')  ExtFile(*ExtDesc);
002500180301       dcl-f PlnMst  keyed ExtDesc('F.PLNMST')  ExtFile(*ExtDesc);
002600180301       dcl-f Class   keyed ExtDesc('F.CLASS')   ExtFile(*ExtDesc);
002700180301       dcl-f Grate   keyed ExtDesc('F.GRATE')   ExtFile(*ExtDesc);
002800180301       dcl-f PlnAuxp keyed;
002900180301       dcl-f INQ011P usage(*Output);
003000161109
003100170525
003200171229      *-------------------------------------------------------------------------
003300171229      *
003400171229      * Global Variables
003500171229      *
003600171229      *-------------------------------------------------------------------------
003700171229       dcl-s CodeSrch Char(3);
003800171229
003900171229       dcl-s iTrst Zoned(3);
004000171229       dcl-s iSub# Zoned(3);
004100171229       dcl-s iAcct Zoned(4);
004200180301
004300180301       dcl-s wBirth Date(*iso);
004400180301       dcl-s MedicalPlan Char(4);
004401191212       dcl-s Write_Rec Char(1);
004500170320
004600180404
004700180404      *-------------------------------------------------------------------------
004800180404      *
004900180404      * *Entry Procedure
005000180404      *
005100180404      *-------------------------------------------------------------------------
005200180404       Dcl-pr Main ExtPgm;
005300191119         *N  Char(12);
005301191212         *N  Char(1);
005302191212         *N  Char(1);
005400180404       End-Pr;
005500180404
005600180404       dcl-pi Main;
005700191119         iAcct# Char(12);
005701191212         iCobra  Char(1);
005702191212         iActive Char(1);
005800180404       End-Pi;
005900180404
006000180404
006100171108
006200180102      *-------------------------------------------------------------------------
006300171229      *
006400180102      * Mainline Program
006500171229      *
006600180102      *-------------------------------------------------------------------------
006700171121
006800180301       iTrst  = %Dec( %Subst( iAcct# : 1 : 3 ) : 3 : 0);
006900180301       iSub#  = %Dec( %Subst( iAcct# : 5 : 3 ) : 3 : 0);
007000180301       iAcct  = %Dec( %Subst( iAcct# : 9 : 4 ) : 4 : 0);
007100171121
007200180301       setll ( iTrst : iSub# : iAcct ) MemAcc;
007300171229       ListMembers();
007400171121
007500171229       *inlr = *on;
007600170525
007700170525
007800170525
007900161109
008000171229       // ----------------------------------------------------------------
008100180301       dcl-proc ListMembers;
008200161109
008300191119         dcl-s CharSSN char(9);
008400180301
008500180301
008600191119         Dou %Eof(MemAcc);
008700191119           Reade (iTrst : iSub# : iAcct ) MemAcc;
008800170527
008900191119           if %eof(MemAcc);
009000191119             leave;
009100191119           endif;
009200170527
009300191119           Charssn = %Editc( mbssno : 'X') ;
009400180301
009500191119           mlss# = %Subst( Charssn : 1 : 3 ) + '-' +
009600191119                   %Subst( Charssn : 4 : 2 ) + '-' +
009700191119                   %Subst( Charssn : 6 : 4 ) ;
009800180301
009900170529
010000191119           mlFulName = %trim(mlname) + ', ' + %Trim(mfname) + '  ' +
010100191119              mmi;
010200181113
010300191119           mldob = '';
010400191119           if birth > 0 and birth <> 10101;
010500191119             mlDob = %Char(%Date(Birth:*iso):*Usa);
010600191119           endif;
010700181113
010800191119           mlsex = sex;
010900180302
011000180302
011100191119           chain (mbTrst : mbSub# : mbAcct) AccMst;
011200191119           mlActName = acnam1;
011300170527
011400191119           CodeSrch = 'S' + Status;
011500191119           chain CodeSrch Codesl1;
011600191119           mlStatus = sdescr;
011700191119           mlccntr = ccflg;
011800180327
011900191119           mlcdescr = '';
012000191119           chain ccflg Codesl1;
012100191119           if %Found( Codesl1 );
012200191119             mlcdescr = ldescr;
012300191119           EndIf;
012400180327
012500171208
012600191119           // Find the Coverage of the active Major Medical Plan
012700191119           Load_PremInfo();
012800171218
012900171206
013000191119           // Calculate Age
013100191119           mlAge = 0;
013200181113
013300191119           if birth > 0 and birth <> 10101;
013400191119             mldob = %Char(%date(birth : *iso));
013500180301
013600191119             wBirth = %date(birth : *iso);
013700191119             mlage = %Diff( %Date() : wBirth : *Years ) ;
013800191119           endif;
013900181113
014000191119           mldoh = *Blanks;
014100191119           if empdt > 0;
014101191119             test(de) *iso empdt;
014102191119             if not %Error;
014200191119               mldoh =  %Char(%Date(empdt:*iso):*Usa);
014201191119             endif;
014300191119           EndIf;
014400171206
014401200113
014402200113           mlTermDt = '';
014403200113           if TermDt > 0;
014404200113
014405200113             test(de) *iso TermDt;
014406200113             if not %Error;
014407200113               mlTermDt =  %Char(%Date(TermDt:*iso):*Usa);
014408200113             endif;
014409200113           EndIf;
014410200113
014411200113
014412200113
014413191212           Check_Record();
014414191212           if Write_Rec = 'Y';
014500191212             write r_Inq011p;
014600170525
014601191212           endif;
014602191212
014700191119         enddo;
014800170527
014900170527
015000170527
015100170525
015200170525
015300161109
015400171229       end-proc;
015401191212
015402191212       // ----------------------------------------------------------------
015403191212       dcl-proc Check_Record;
015404191212
015405191212         Write_Rec = 'N';
015406191212
015407191212         if iActive = 'Y' and %subst(Status:2:1) = 'A';
015408191212           Write_Rec = 'Y';
015409191212         endif;
015410191212
015411191212         if iActive = 'N';
015412191212           Write_Rec = 'Y';
015413191212         endif;
015414191212
015415191212
015416191212         // Check Cobra...
015417191212         if Write_rec = 'Y';
015418191212           if iCobra = 'Y' and Elecrt <> 'Y';
015419191212             Write_Rec = 'N';
015420191212           endif;
015421191212         endif;
015422191212
015431191212
015432191212       end-proc;
015433191212
015434191212
015500161109
015600171229       // ----------------------------------------------------------------
015700171229       dcl-proc Load_PremInfo;
015800171218
015900191119         // Get the Major Medical Plan;
016000191212         Exec Sql
016100191212           Select Mcplan
016200191212             Into :Medicalplan
016300191212             From "F.MCOV"
016400191212             Join "F.PLNMST" On Pltrst = Mctrst And
016500191212                                Plsub# = Mcsub# And
016600191212                                Plplan = Mcplan
016700191212             Join "F.CODESL1" On Plncat = Key3
016800191212             Where Mcssno = :mbssno And
016900191212                   Mcdltd = 'A' And
017000191212                   Action = 'M' And
017001191212                   Plncat Not In ('P1P', 'POO');
017100171218
017200171218
017300191119         mlGroup = '';
017400191119         mlPrem = 0;
017500191119         mlType = '';
017600171229
017700191119         // Retrive the Active Records..
017800191119         setll mbssno mCov40;
017900171218
018000191119         dou %Eof(mCov40);
018100191119           reade mbssno mCov40;
018200171218
018300191119           if %eof( mCov40 );
018400191119             leave;
018500191119           endif;
018600171218
018700171218
018800191119           chain (mcTrst : mcSub# : mcPlan ) PlnMst;
018900191119           chain (mcTrst : mcSub# : mcPlan ) PlnAuxp;
019000191119           chain (mcTrst : mcSub# : mcPlan : mCovtp ) Class;
019100191119           if not %Found(Class);
019200191119             chain (mcTrst : mcSub# : mcPlan : 'TNA' ) Class;
019300191119           endif;
019400171218
019500191119           chain (mcTrst : mcSub# : mcPlan : mcAgeb : mCovtp ) Grate;
019600171218
019700191119           mlPrem = mlPrem + lPrem;
019800171218
019900191119           if mcPlan = MedicalPlan;
020000191119             mlGroup = Group#;
020100171218
020200191119             chain mCovTp Codesl1;
020300191119             mlType = sdescr;
020400191119           Endif;
020500171218
020600191119         Enddo;
020700171218
020800171218
020900171218
021000171218
021100171229       end-proc;
