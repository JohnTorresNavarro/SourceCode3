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
001101200113      * Change Log
001102200113      *
001103200113      * Date          Programmer          Description
001104200113      * 01/13/2020    B.Rees              Added Term Date
001105200113      *
001106200113      *-------------------------------------------------------------------------
001200180102
001300171229
001400171229      *-------------------------------------------------------------------------
001500171229      *
001600171229      * Declare Files
001700171229      *
001800171229      *-------------------------------------------------------------------------
001900171229       Dcl-f Inq011d Workstn
002000171229          HANDLER('PROFOUNDUI(HANDLER)')
002100171229          SFILE(MBRSFL:rrn)                    ;
002200171229
002300171229       Dcl-f MemAcc  keyed ExtDesc('F.MEMACC')  ExtFile(*ExtDesc);
002400171229       Dcl-f AccMst  keyed ExtDesc('F.ACCMST')  ExtFile(*ExtDesc);
002500171229       Dcl-f CodesL1 keyed ExtDesc('F.CODESL1') ExtFile(*ExtDesc);
002600171229
002700171229       Dcl-f MCov40  keyed ExtDesc('F.MCOV40')  ExtFile(*ExtDesc);
002800171229       dcl-f PlnMst  keyed ExtDesc('F.PLNMST')  ExtFile(*ExtDesc);
002900171229       dcl-f Class   keyed ExtDesc('F.CLASS')   ExtFile(*ExtDesc);
003000171229       dcl-f Grate   keyed ExtDesc('F.GRATE')   ExtFile(*ExtDesc);
003100171229       dcl-f PlnAuxp keyed;
003200171229
003300161109
003400170525
003500171229      *-------------------------------------------------------------------------
003600171229      *
003700171229      * Global Variables
003800171229      *
003900171229      *-------------------------------------------------------------------------
004000171229       dcl-s rrn Zoned(5) inz;
004100171229       dcl-s FirstRun Char(1);
004200171229       dcl-s Count Zoned(5);
004300171229
004400170527
004500171229       dcl-s SearchVal char(18);
004600171229       dcl-s Row1lName char(18);
004700171229       dcl-s Row1fname char(12);
004800171229       dcl-s RowxlName char(18);
004900171229       dcl-s Rowxfname char(12);
005000171229
005100171229
005200171229       dcl-s CodeSrch Char(3);
005300171229       dcl-s wBirth Date(*iso);
005400171229       dcl-s MedicalPlan Char(4);
005500171229
005600171229       dcl-s Write_Rrn Char(1);
005700180606       dcl-c CRLF x'0d25';
005800171229
005900161111      *--------------------------------------------
006000171229      *
006100180102      * Procedures
006200171229      *
006300161111      *--------------------------------------------
006400171229       dcl-pr MemberInq ExtPgm('INQ002R');
006500191119         oMember Zoned(9);
006600171229       End-Pr;
006700180102       dcl-s oMember Zoned(9);
006800171208
006900180404
007000180404      *-------------------------------------------------------------------------
007100180404      *
007200180404      * *Entry Procedure
007300180404      *
007400180404      *-------------------------------------------------------------------------
007500180404       Dcl-pr Main ExtPgm;
007600191119         *N  Zoned(3);
007700191119         *N  Zoned(3);
007800191119         *N  Zoned(4);
007900191119         *N  Char(1);
008000180404       End-Pr;
008100180404
008200180404       dcl-pi Main;
008300191119         iTrst  Zoned(3);
008400191119         iSub#  Zoned(3);
008500191119         iAcct  Zoned(4);
008600191119         iCobra Char(1);
008700180404       End-Pi;
008800180404
008900180404
009000170320
009100171108
009200180102      *-------------------------------------------------------------------------
009300171229      *
009400180102      * Mainline Program
009500171229      *
009600180102      *-------------------------------------------------------------------------
009700170525
009800171229       ListMembers();
009900171121
010000171229       *inlr = *on;
010100170525
010200170525
010300170525
010400180102      *-------------------------------------------------------------------------
010500171229      *
010600180102      * List the Members
010700171229      *
010800180102      *-------------------------------------------------------------------------
010900171229       dcl-proc ListMembers;
011000170525
011100191119         Dou btnExit = *on;
011200161109
011300191119           ClearS2();
011400191119           SetPosS2();
011500191119           LoadS2();
011600161109
011700191119           DisplyS2();
011800161109
011900170528
012000191119           // Process Selections
012100191119           Select;
012200170528
012300191119           When ChgShowAct = *on;
012400191119           //?Reload
012500170528
012600191119           other;
012700191119             ReadChangedS2();
012800191119           EndSl;
012900161109
013000191119         enddo;
013100161109
013200171229       end-proc;
013300161109
013400171229       // ----------------------------------------------------------------
013500171229       dcl-proc SetPosS2;
013600170525
013700191119         Select;
013800191119         When FirstRun = 'Y';       // First Load
013900191119           FirstRun = 'N';
014000191119         //   SearchVal = s1lname;
014100191119         //   setll SearchVal MemAcc;
014200170527
014300191119         When btnSearch = *on;
014400191119           btnSearch = *off;
014500191119           SearchVal = SrchName;
014600191119           setll ( iTrst : iSub# : iAcct : SearchVal) MemAcc;
014700170529
014800191119         When PageDown = *On;
014900191119           Setll ( iTrst : iSub# : iAcct : RowxLname : RowxFName) MemAcc;
015000170527
015100170527
015200191119         When PageUp = *On;
015300191119           Setll ( iTrst : iSub# : iAcct : Row1Lname : Row1fName) MemAcc;
015400191119           Prev();
015500170530
015600191119         other;
015700191119           Setll ( iTrst : iSub# : iAcct : Row1Lname : Row1fName) MemAcc;
015800170530
015900191119         EndSL;
016000170527
016100171229       end-proc;
016200171229       // ----------------------------------------------------------------
016300171229       dcl-proc Prev;
016400170525
016500191119         count = 0;
016600170525
016700191119         // Read the previous 20 records to set the pointer
016800191119         // to the right spot.
016900191119         Dou %Eof(MemAcc);
017000191119           readpe (iTrst : iSub# : iAcct ) MemAcc;
017100191119           if %eof(MemAcc);
017200191119             leave;
017300191119           endif;
017400170528
017500170528
017600191119           if chkActOnly = 'Y' and %subst(Status:2:1) = 'A';
017700191119             Count = Count + 1;
017800191119             RowxlName = mlname;
017900191119             RowxfName = mfname;
018000191119           endif;
018100170528
018200191119           if chkActOnly = ' ';
018300191119             Count = Count + 1;
018400191119             RowxlName = mlname;
018500191119             RowxfName = mfname;
018600191119           endif;
018700170528
018800191119           if Count = 20;
018900191119             leave;
019000191119           endif;
019100191119         enddo;
019200170527
019300191119         Setll ( iTrst : iSub# : iAcct : RowxLname : RowxfName) MemAcc;
019400170527
019500171229       end-proc;
019600171229       // ----------------------------------------------------------------
019700171229       dcl-proc ClearS2;
019800161109
019900191119         // Clear the Subfile
020000191119         ClrSfl = *on;
020100191119         Write Screen2;
020200191119         ClrSfl = *off;
020300191119         rrn = 0;
020400161109
020500171229       end-proc;
020600171229       // ----------------------------------------------------------------
020700171229       dcl-proc LoadS2;
020800161109
020900180301
021000191119         h_tsa = %editc(iTrst : 'X') + '-' +
021100191119            %editc(iSub# : 'X') + '-' +
021200191119            %editc(iAcct : 'X') ;
021300180301
021400191119         Count = 0;
021500191119         Dou %Eof(MemAcc);
021600191119           Reade (iTrst : iSub# : iAcct ) MemAcc;
021700170527
021800191119           if %eof(MemAcc);
021900191119             leave;
022000191119           endif;
022100170527
022200191119           Count = count + 1;
022300170527
022400191119           s2ssn = mbssno;
022500170527
022600191119           if Count = 1;
022700191119             Row1lName = mlname;
022800191119             Row1fName = mfname;
022900191119           endif;
023000170527
023100191119           RowxlName = mlname;
023200191119           RowxfName = mfname;
023300170527
023400191119           s2tsa = %editc(mbTrst : 'X') + '-' +
023500191119              %editc(mbSub# : 'X') + '-' +
023600191119              %editc(mbAcct : 'X') ;
023700170529
023800191119           s2FulName = %trim(mlname) + ', ' + %Trim(mfname) + '  ' +
023900191119              mmi;
024000191119           s2dob = '';
024100191119           if birth > 0 and birth <> 10101;
024200191119             s2dob = %Char(%Date(Birth:*iso):*Usa);
024300191119           endif;
024400181113
024500191119           s2ToolTip = %Trim(Addr1);
024600191119           if addr2 > '';
024700191119             s2ToolTip = %Trim(S2ToolTip) + CRLF + %Trim(Addr2);
024800191119           endif;
024900191119           if City > '';
025000191119             s2ToolTip = %Trim(S2ToolTip) + CRLF  +
025100191119             %Trim(City) + ', ' + %Trim(State) + '  ' +
025200191119             %Char(Zip);
025300191119           endif;
025400180606
025500180606
025600191119           chain (mbTrst : mbSub# : mbAcct) AccMst;
025700191119           s2ActName = acnam1;
025800170527
025900191119           CodeSrch = 'S' + Status;
026000191119           chain CodeSrch Codesl1;
026100191119           s2Sts = sdescr;
026200191119           s2ccntr = ccflg;
026300171208
026400191119           s2cctip = '';
026500191119           chain ccflg Codesl1;
026600191119           if %Found( codesl1 );
026700191119             s2cctip = ldescr;
026800191119           EndIf;
026900180327
027000191119           // Find the Coverage of the active Major Medical Plan
027100191119           Load_PremInfo();
027200171218
027300171206
027400191119           // Calculate Age
027500191119           s2Age = 0;
027600181113
027700191119           if birth > 0 and birth <> 10101;
027800191119             wBirth = %date(birth : *iso);
027900191119             s2Age = %Diff( %Date() : wBirth : *Years ) ;
028000191119           endif;
028100181113
028200191119           s2Hire = *Blanks;
028300191119           if empdt > 0;
028301191119
028302191119             test(de) *iso empdt;
028303191119             if not %Error;
028304191119               s2Hire =  %Char(%Date(empdt:*iso):*Usa);
028305191119             endif;
028500191119           EndIf;
028600171206
028601200113           s2TermDt = '';
028603200113           if TermDt > 0;
028604200113
028605200113             test(de) *iso TermDt;
028606200113             if not %Error;
028607200113               s2TermDt =  %Char(%Date(TermDt:*iso):*Usa);
028608200113             endif;
028609200113           EndIf;
028610200113
028611200113
028612200113
028700191119           Check_RRN();
028800170528
028900191119           if rrn = 19;
029000191119             leave;
029100191119           endif;
029200170525
029300191119         enddo;
029400170527
029500170527
029600191119         // Setup Directional Links.
029700191119         // Page Down
029800191119         EnableDown = *On;
029900170527
030000191119         Setgt ( iTrst : iSub# : iAcct : RowxLname : RowxFName) MemAcc;
030100191119         read  MemAcc;
030200191119         if %eof(MemAcc);
030300191119           EnableDown = *Off;
030400191119         endif;
030500170527
030600191119         // Page Up
030700191119         EnableUp = *On;
030800170527
030900191119         Setll ( iTrst : iSub# : iAcct : Row1Lname : Row1FName) MemAcc;
031000191119         readp MemAcc;
031100191119         if %eof(MemAcc);
031200191119           EnableUp = *Off;
031300191119         endif;
031400170527
031500170525
031600170525
031700161109
031800171229       end-proc;
031900161109
032000171229       // ----------------------------------------------------------------
032100171229       dcl-proc DisplyS2;
032200161109
032300191119         DspSfl = *on  ;
032400191119         exfmt Screen2;
032500191119         DspSfl = *off;
032600161109
032700171229       end-proc;
032800171229       // ----------------------------------------------------------------
032900171229       dcl-proc ReadChangedS2;
033000161109
033100191119         Dou *in95 = *ON;
033200191119           READC MbrSfl;
033300191119           *in95 = %EOF;
033400161109
033500191119           If *in95 = *OFF;
033600161109
033700191119             If SelSSN = *on;
033800191119               // Go Directly to application;
033900191119               oMember = s2ssn;
034000191119               MemberInq( oMember );
034100191119             endIf;
034200170320
034300191119             SelSSN = *off;
034400191119             update MbrSfl;
034500161109
034600191119           endIf;
034700161118
034800161109
034900191119         enddo;
035000171229       end-proc;
035100171121
035200171229       // ----------------------------------------------------------------
035300171229       dcl-proc Check_RRN;
035400171121
035500191119         Write_RRN = 'N';
035600171121
035700191119         if chkActOnly = 'Y' and %subst(Status:2:1) = 'A';
035800191119           Write_RRN = 'Y';
035900191119         endif;
036000171121
036100191119         if chkActOnly = ' ';
036200191119           Write_RRN = 'Y';
036300191119         endif;
036400171121
036500171121
036600191119         // Check Cobra...
036700191119         if Write_rrn = 'Y';
036800191119           if iCobra = 'Y' and Elecrt <> 'Y';
036900191119             Write_RRN = 'N';
037000191119           endif;
037100191119         endif;
037200171121
037300171121
037400171121
037500191119         // Write RRN
037600191119         if Write_RRN = 'Y';
037700191119           rrn = rrn + 1;
037800191119           write MbrSfl;
037900191119         endif;
038000171121
038100171121
038200171229       end-proc;
038300171218
038400171229       // ----------------------------------------------------------------
038500171229       dcl-proc Load_PremInfo;
038600171218
038700191119         // Get the Major Medical Plan;
038800191119         Exec Sql
038900191119           Select Mcplan
039000191119             Into :Medicalplan
039100191119             From "F.MCOV"
039200191119             Join "F.PLNMST" On Pltrst = Mctrst And
039300191119                                Plsub# = Mcsub# And
039400191119                                Plplan = Mcplan
039500191119             Join "F.CODESL1" On Plncat = Key3
039600191119             Where Mcssno = :S2ssn And
039700191119                   Action = 'M' And
039800191119                   Mcdltd = 'A' And
039801191119                   Plncat Not In ('P1P', 'POO');
039900171218
040000171218
040100191119            s2Group = '';
040200191119         s2Prem = 0;
040300191119         s2Type = '';
040400171229
040500191119         // Retrive the Active Records..
040600191119         setll s2ssn mCov40;
040700171218
040800191119         dou %Eof(mCov40);
040900191119           reade s2ssn mCov40;
041000171218
041100191119           if %eof( mCov40 );
041200191119             leave;
041300191119           endif;
041400171218
041500171218
041600191119           chain (mcTrst : mcSub# : mcPlan ) PlnMst;
041700191119           chain (mcTrst : mcSub# : mcPlan ) PlnAuxp;
041800191119           chain (mcTrst : mcSub# : mcPlan : mCovtp ) Class;
041900191119           if not %Found(Class);
042000191119             chain (mcTrst : mcSub# : mcPlan : 'TNA' ) Class;
042100191119           endif;
042200171218
042300191119           chain (mcTrst : mcSub# : mcPlan : mcAgeb : mCovtp ) Grate;
042400171218
042500191119           s2Prem = s2Prem + lPrem;
042600171218
042700191119           if mcPlan = MedicalPlan;
042800191119             s2Group = Group#;
042900171218
043000191119             chain mCovTp Codesl1;
043100191119             s2Type = sdescr;
043200191119           Endif;
043300171218
043400191119         Enddo;
043500171218
043600171218
043700171218
043800171218
043900171229       end-proc;
