000100190909       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no);
000200190905
000300171229      *-------------------------------------------------------------------------
000400171229      *
000500171229      *  Description:
000600171229      *  Programmer.:  Brian Rees
000700171229      *  Date.......:  05/25/2017
000800171229      *
000900171229      *-------------------------------------------------------------------------
001000171229
001100180227      *-------------------------------------------------------------------------
001200180227      *
001300180227      *  Modifications:
001400180227      *
001500180227      *  B.Rees      2/27/2018
001600180227      *       Added Other search options: Dependent, Group ID, Invoice Number
001700180227      *
001800180228      *  B.Rees      2/28/2018
001900180228      *       Added Contains to Screen 3
001901200930      *
001902200930      *  B.Rees      09/30/2020
001903200930      *   Changed AccNm3 to ACCNM3
002000180227      *
002001220117      *  1/17/2022 B.Rees  Use Full Account Number for Search...
002002220117      *
002100180227      *-------------------------------------------------------------------------
002200180227
002300180227
002400171229      *-------------------------------------------------------------------------
002500171229      *
002600171229      * Declare Files
002700171229      *
002800171229      *-------------------------------------------------------------------------
002900171229       Dcl-f Inq001d WorkStn
003000190909          Handler('PROFOUNDUI(HANDLER)')
003100171229          SFILE(MBRSFL:rrn)
003200171229          SFILE(ACCTSFL:rrn2) ;
003300171229
003400171229       Dcl-f MemNam keyed
003501220117          ExtDesc('F.MEMNAM')
003502220117          ExtFile(*extdesc);
003600171229
003700220117       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
003800171229
003900200930       Dcl-f AccNm3 keyed
004000200930          ExtDesc('F.ACCNM3') ExtFile(*extdesc)
004100180227          Rename(AccMsr:Rcd1);
004200171229
004300220117       Dcl-f Codesl1 keyed ExtDesc('F.CODESL1') ExtFile(*extdesc);
004400171229
004500190905       Dcl-f Member keyed
004501220117         ExtDesc('F.MEMBER')
004600220117          ExtFile(*extdesc)
004700180227          Rename( Membr : Rcd2 );
004800171229
004900171229
005000171229
005100170525
005200171229      *-------------------------------------------------------------------------
005300171229      *
005400171229      * Global Variables
005500171229      *
005600171229      *-------------------------------------------------------------------------
005700171229       Dcl-s rrn Zoned(5) inz;
005800190905       Dcl-s FirstRun Char(1) inz;
005900171229       Dcl-s Count Zoned(5) inz;
006000171229       Dcl-s rrn2 Zoned(5) inz;
006100171229
006200171229       dcl-s SearchVal Char(18);
006300180125       dcl-s Search_FName Char(12);
006400171229       dcl-s Row1lName Char(18);
006500171229       dcl-s Row1fName Char(12);
006600171229       dcl-s RowxlName Char(18);
006700171229       dcl-s RowxfName Char(12);
006800171229
006900200930       dcl-s SearchName Char(40);
006902200930
007000200930       dcl-s Row1Name Char(40);
007001200930       dcl-s Row1Trst Zoned(3);
007002200930       dcl-s Row1Sub# Zoned(3);
007003200930       dcl-s Row1Acct Zoned(4);
007004200930
007100200930       dcl-s RowxName Char(40);
007101200930       dcl-s RowxTrst Zoned(3);
007102200930       dcl-s RowxSub# Zoned(3);
007103200930       dcl-s RowxAcct Zoned(4);
007200171229
007300171229       dcl-s CodeSrch Char(3);
007301220117
007400220117       dcl-s Acct_Arry Char(4) Dim(10);
007600170525
007700170605
007800171229      *-------------------------------------------------------------------------
007900171229      *
008000171229      * Procedures
008100171229      *
008200171229      *-------------------------------------------------------------------------
008300171229       dcl-pr MemberInq ExtPgm('INQ002R');
008400220117         oMember Zoned(9);
008500171229       End-Pr;
008600171229
008700190905       dcl-s oMember Zoned(9);
008800171229
008900171229
009000171229       dcl-pr AccountInq ExtPgm('INQ008R');
009100220117         oTrst Zoned(3);
009200220117         oSub# Zoned(3);
009300220117         oAcct Zoned(4);
009400171229       End-Pr;
009500171229
009600171229       dcl-s oTrst Zoned(3);
009700171229       dcl-s oSub# Zoned(3);
009800171229       dcl-s oAcct Zoned(4);
009900171229
010000171108
010100180115       dcl-pr AltID_Search ExtPgm('INQ013R') end-pr;
010200180227       dcl-pr Dependent_Search ExtPgm('INQ014R') end-pr;
010300180227       dcl-pr Group_Search ExtPgm('INQ016R') end-pr;
010400180227       dcl-pr Invoice_Search ExtPgm('INQ015R') end-pr;
010500190603       dcl-pr TaxId_Search ExtPgm('INQ023R') end-pr;
010600161111
010700171229      *-------------------------------------------------------------------------
010800171229      *
010900171229      * Mainline Program
011000171229      *
011100171229      *-------------------------------------------------------------------------
011200170525
011300170525       Dou btnExit = *on;
011400220117         exfmt Screen1;
011500171127
011600220117         errMember = *off;
011700220117         errAccount = *off;
011800170525
011900220117         Select;
012000180227
012100180227
012200220117         when OthSrchOpt = *on;
012300220117           if SrchOption = 'AltId';
012400220117             AltID_Search();
012500220117           EndIf;
012600180227
012700220117           if srchOption = 'Depnd';
012800220117             Dependent_Search();
012900220117           EndIf;
013000180227
013100220117           if srchOption = 'groupid';
013200220117             Group_Search();
013300220117           EndIf;
013400180227
013500220117           if srchOption = 'invoicenbr';
013600220117             Invoice_Search();
013700220117           EndIf;
013800180227
013900220117           if srchOption = 'TaxId';
014000220117             TaxId_Search();
014100220117           EndIf;
014200190603
014300190603
014400190603
014500220117         When btnMbrSrch = *on;
014600220117           if s1ssn > 0 ;
014700220117             chain s1ssn Member;
014800220117             if %Found( Member );
014900171229
015000220117               //?Go Directly to application;
015100220117               oMember = s1ssn;
015200220117               MemberInq( oMember );
015300220117               Clear Screen1;
015400220117             else;
015500220117               errMember = *on;
015600220117             endif;
015700220117           else;
015800171229
015900220117             //?Search for a member.
016000220117             FirstRun = 'Y';
016100220117             ListMembers();
016200171229
016300220117             Clear Screen1;
016400220117           endif;
016500170525
016600220117         When btnAccSrch = *on;
016700220117           select;
016800220117           When s1Trst > 0;
016900171229
017000220117             //?Make sure all values are listed.
017100220117             //?if missing a value and s1actnam = *blank; show error.
017200220117             //?Go Directly to application;
017300220117             oTrst = s1Trst;
017400220117             oSub# = s1Sub ;
017500220117             oAcct = s1Acct;
017600171108
017700220117             Clear Screen1;
017800220117             AccountInq( oTrst : oSub# : oAcct );
017900171108
017901220117
017902220117           When s1ActNBr > '';
017903220117             s1ActNbr = %ScanRpl( '+' : '-' : s1ActNbr );
017904220117             clear Acct_Arry;
017905220117             Acct_Arry = %Split(s1ActNbr : '-' );
017906220224
017907220224             if %Scan( '-' : s1ActNbr) = 0 and
017908220224               %len( %Trim( s1ActNbr )) = 10  ;
017909220224
017910220224               Acct_Arry(1) = %Subst( s1ActNbr : 1 : 3 );
017911220224               Acct_Arry(2) = %Subst( s1ActNbr : 4 : 3 );
017912220224               Acct_Arry(3) = %Subst( s1ActNbr : 7 : 4 );
017913220224
017914220224             EndIf;
017915220224
017916220224
017917220224             monitor;
017918220117
017919220224
017920220224               oTrst = %Dec( Acct_Arry(1): 3 : 0 );
017921220224               oSub# = %Dec( Acct_Arry(2): 3 : 0 );
017922220224               oAcct = %Dec( Acct_Arry(3): 4 : 0 );
017923220117
017924220224             on-error;
017925220117
017926220224             EndMon;
017927220117
017928220117             chain (oTrst : oSub# : oAcct) AccMst;
017929220117             if not %Found( AccMst );
017930220117               errAccount = *on;
017931220117             else;
017932220117
017933220117               Clear Screen1;
017934220117               AccountInq( oTrst : oSub# : oAcct );
017935220117             endif;
017936220117
017937220117
017938220117
017939220117
018000220117           When s1tr > 0;
018100220117             oTrst = s1tr;
018200220117             oSub# = s1Sb ;
018300220117             oAcct = s1Ac;
018400171128
018500171130
018600220117             chain (oTrst : oSub# : oAcct) AccMst;
018700220117             if not %Found( AccMst );
018800220117               errAccount = *on;
018900220117             else;
019000171130
019100220117               Clear Screen1;
019200220117               AccountInq( oTrst : oSub# : oAcct );
019300220117             endif;
019400171130
019500171108
019600220117           When s1ActNam > *Blanks;
019700220117             //?Search for a Acct
019800220117             FirstRun = 'Y';
019900220117             ListAccounts();
020000220117             Clear Screen1;
020100170529
020200220117           When s1Contains > *Blanks;
020300220117             //?Search for a Acct
020400220117             FirstRun = 'Y';
020500220117             ListAccounts();
020600220117             Clear Screen1;
020700220117           endsl;
020800170529
020900220117         endsl;
021000170525
021100220117         btnMbrSrch = *off;
021200220117         btnAccSrch = *off;
021300170525       enddo;
021400170529
021500170525       *inlr = *on;
021600170525
021700170525
021800170525
021900170525
022000170525
022100170525
022200171229      *-------------------------------------------------------------------------
022300171229      * List the Members
022400171229      *-------------------------------------------------------------------------
022500171229       dcl-proc ListMembers;
022600170525
022700220117         Dou btnCancel = *on;
022800161109
022900220117           ClearS2();
023000220117           SetPosS2();
023100220117           LoadS2();
023200161109
023300220117           DisplyS2();
023400161109
023500170528
023600220117           //?Process Selections
023700220117           Select;
023800170528
023900220117           When ChgShowAct = *on;
024000220117           //?Reload
024100170528
024200220117           other;
024300220117             ReadChangedS2();
024400220117           EndSl;
024500161109
024600220117         enddo;
024700161109
024800171229       End-Proc;
024900161109
025000170525       // ----------------------------------------------------------------
025100171229       dcl-proc SetPosS2;
025200170525
025300220117         Select;
025400220117         When FirstRun = 'Y';       //?First Load
025500220117           FirstRun = 'N';
025600220117           SearchVal = s1lname;
025700220117           Search_FName = s1fname;
025800180125
025900220117           setll (SearchVal : Search_FName) MemNam;
026000170527
026100220117         When btnSearch = *on;
026200220117           btnSearch = *off;
026300220117           SearchVal = SrchName;
026400220117           Search_FName = srchfName;
026500180125
026600220117           setll (SearchVal : Search_FName) MemNam;
026700170529
026800220117         When PageDown = *On;
026900220117           Setll (RowxLname : RowxFName) MemNam;
027000170527
027100170527
027200220117         When PageUp = *On;
027300220117           Setll (Row1Lname : Row1fName) MemNam;
027400220117           Prev();
027500170530
027600220117         other;
027700220117           Setll (Row1Lname : Row1fName) MemNam;
027800170530
027900220117         EndSL;
028000170527
028100171229       End-Proc;
028200171229
028300170525       // ----------------------------------------------------------------
028400171229
028500171229       dcl-proc Prev;
028600170525
028700220117         count = 0;
028800170525
028900220117         //?Read the previous 10 records to set the pointer
029000220117         //?to the right spot.
029100220117         Dou %Eof(MemNam);
029200220117           readp MemNam;
029300220117           if %eof(MemNam);
029400220117             leave;
029500220117           endif;
029600170528
029700170528
029800220117           if chkActOnly = 'Y' and %subst(Status:2:1) = 'A';
029900220117             Count = Count + 1;
030000220117             RowxlName = mlname;
030100220117             RowxfName = mfname;
030200220117           endif;
030300170528
030400220117           if chkActOnly = ' ';
030500220117             Count = Count + 1;
030600220117             RowxlName = mlname;
030700220117             RowxfName = mfname;
030800220117           endif;
030900170528
031000220117           if Count = 20;
031100220117             leave;
031200220117           endif;
031300220117         enddo;
031400170527
031500220117         Setll (RowxLname : RowxfName) MemNam;
031600170527
031700171229       End-Proc;
031800171229
031900161109       // ----------------------------------------------------------------
032000171229
032100171229       dcl-proc ClearS2;
032200161109
032300220117         //?Clear the Subfile
032400220117         ClrSfl = *on;
032500220117         Write Screen2;
032600220117         ClrSfl = *off;
032700220117         rrn = 0;
032800161109
032900171229       end-Proc;
033000161109       // ----------------------------------------------------------------
033100171229       dcl-proc LoadS2;
033200161109
033300220117         Count = 0;
033400220117         Dou %Eof(MemNam);
033500220117           Read MemNam;
033600170527
033700220117           if %eof(MemNam);
033800220117             leave;
033900220117           endif;
034000170527
034100220117           Count = count + 1;
034200170527
034300220117           s2ssn = mbssno;
034400170527
034500220117           if Count = 1;
034600220117             Row1lName = mlname;
034700220117             Row1fName = mfname;
034800220117           endif;
034900170527
035000220117           RowxlName = mlname;
035100220117           RowxfName = mfname;
035200170527
035300220117           s2tsa = %editc(mbTrst : 'X') + '-' +
035400220117              %editc(mbSub# : 'X') + '-' +
035500220117              %editc(mbAcct : 'X') ;
035600170529
035700220117           s2FulName = %trim(mlname) + ', ' + %Trim(mfname) + '  ' +
035800220117              mmi;
035900220117           s2dob = %Char(%Date(Birth:*iso):*Usa);
036000170527
036100220117           chain (mbTrst : mbSub# : mbAcct) AccMst;
036200220117           s2ActName = acnam1;
036300170527
036400220117           CodeSrch = 'S' + Status;
036500220117           chain CodeSrch Codesl1;
036600220117           s2Sts = sdescr;
036700170525
036800220117           if chkActOnly = 'Y' and %subst(Status:2:1) = 'A';
036900220117             rrn = rrn + 1;
037000220117             write MbrSfl;
037100220117           endif;
037200170528
037300220117           if chkActOnly = ' ';
037400220117             rrn = rrn + 1;
037500220117             write MbrSfl;
037600220117           endif;
037700170528
037800170528
037900220117           if rrn = 20;
038000220117             leave;
038100220117           endif;
038200170525
038300220117         enddo;
038400170527
038500170527
038600220117         //?Setup Directional Links.
038700220117         //?Page Down
038800220117         EnableDown = *On;
038900170527
039000220117         Setgt (RowxLname : RowxFName) MemNam;
039100220117         read  MemNam;
039200220117         if %eof(MemNam);
039300220117           EnableDown = *Off;
039400220117         endif;
039500170527
039600220117         //?Page Up
039700220117         EnableUp = *On;
039800170527
039900220117         Setll (Row1Lname : Row1FName) MemNam;
040000220117         readp MemNam;
040100220117         if %eof(MemNam);
040200220117           EnableUp = *Off;
040300220117         endif;
040400170527
040500170525
040600170525
040700161109
040800171229       end-proc;
040900161109
041000161109       // ----------------------------------------------------------------
041100171229
041200171229       dcl-proc DisplyS2;
041300161109
041400220117         DspSfl = *on  ;
041500220117         exfmt Screen2;
041600220117         DspSfl = *off;
041700161109
041800171229       end-proc;
041900171229
042000161109       // ----------------------------------------------------------------
042100171229
042200171229       dcl-proc ReadChangedS2;
042300161109
042400220117         Dou *in95 = *ON;
042500220117           READC MbrSfl;
042600220117           *in95 = %EOF;
042700161109
042800220117           If *in95 = *OFF;
042900161109
043000220117             If SelSSN = *on;
043100220117               //?Go Directly to application;
043200220117               oMember = s2ssn;
043300220117               Clear Screen1;
043400220117               MemberInq( oMember );
043500220117             endIf;
043600170320
043700220117             SelSSN = *off;
043800220117             update MbrSfl;
043900161109
044000220117           endIf;
044100161118
044200161109
044300220117         enddo;
044400171229       end-proc;
044500161109
044600170529
044700171229      *-------------------------------------------------------------------------
044800171229      *
044900171229      * List the Accounts
045000171229      *
045100171229      *-------------------------------------------------------------------------
045200171229       dcl-proc ListAccounts;
045300170529
045400220117         Dou btnCancel = *on;
045500170529
045600220117           ClearS3();
045700220117           SetPosS3();
045800220117           LoadS3();
045900170529
046000220117           DisplyS3();
046100170529
046200170529
046300220117           //?Process Selections
046400220117           Select;
046500170529
046600220117           When ChgShowAct = *on;
046700220117           //?Reload
046800170529
046900220117           other;
047000220117             ReadChangedS3();
047100220117           EndSl;
047200170529
047300220117         enddo;
047400170529
047500171229       end-proc;
047600170529
047700170529       // ----------------------------------------------------------------
047800171229       dcl-proc ClearS3;
047900170529
048000220117         // Clear the Subfile
048100220117         ClrSfl = *on;
048200220117         Write Screen3;
048300220117         ClrSfl = *off;
048400220117         rrn2 = 0;
048500170529
048600171229       end-proc;
048700171229
048800170529       // ----------------------------------------------------------------
048900171229
049000171229       dcl-proc SetPosS3;
049100170529
049200220117         Select;
049300220117         When FirstRun = 'Y';       // First Load
049400220117           FirstRun = 'N';
049500220117           SearchName = s1ActNam;
049600220117           s1ActNam  = *blanks;
049700220117           setll SearchName AccNm3;
049800170529
049900220117         When btnSearch = *on;
050000220117           btnSearch = *off;
050100220117           SearchName = SrchAcct;
050200220117           setll SearchName AccNm3;
050300170529
050400170529
050500220117         When PageDown = *On;
050600220117           Setll (RowxName : RowxTrst : RowxSub#: RowxAcct) AccNm3;
050700170529
050800170529
050900220117         When PageUp = *On;
051000220117           Setll (Row1Name : Row1Trst : Row1Sub#: Row1Acct) AccNm3;
051100220117           Prevs3();
051200170529
051300220117         other;
051301220117           Setll (Row1Name : Row1Trst : Row1Sub#: Row1Acct) AccNm3;
051500170530
051600220117         EndSL;
051700170529
051800171229       end-proc;
051900171229
052000170529       // ----------------------------------------------------------------
052100171229
052200171229       dcl-proc Prevs3;
052300170529
052400220117         count = 0;
052500170529
052600220117         // Read the previous 10 records to set the pointer
052700220117         // to the right spot.
052800220117         Dou %Eof(AccNm3);
052900220117           readp AccNm3;
053000220117           if %eof(AccNm3);
053100220117             leave;
053200220117           endif;
053300170529
053400220117           //---------------------------------
053500220117           // s1Contains is blank
053600220117           //---------------------------------
053700220117           if s1Contains = *Blanks;
053800170529
053900220117             if chkActAcct = 'Y' and acdltd = 'A';
054000220117               Count = Count + 1;
054100220117               RowxName = acnam1;
054101220117               RowxTrst = acTrst;
054102220117               RowxSub# = acSub#;
054103220117               RowxAcct = acAcct;
054200220117             endif;
054300170529
054400220117             if chkActAcct = ' ';
054500220117               Count = Count + 1;
054600220117               RowxName = acnam1;
054601220117               RowxTrst = acTrst;
054602220117               RowxSub# = acSub#;
054603220117               RowxAcct = acAcct;
054700220117             endif;
054800220117           endif;
054900170529
055000220117           //---------------------------------
055100220117           // s1Contains has a value.
055200220117           //---------------------------------
055300220117           if s1Contains > *Blanks  and
055400220117              %Scan( %Trim(s1Contains) : acnam1 ) > 0;
055500170529
055600220117             if chkActAcct = 'Y' and acdltd = 'A';
055700220117               Count = Count + 1;
055800220117               RowxName = acnam1;
055801220117               RowxTrst = acTrst;
055802220117               RowxSub# = acSub#;
055803220117               RowxAcct = acAcct;
055900220117             endif;
056000170529
056100220117             if chkActAcct = ' ';
056200220117               Count = Count + 1;
056300220117               RowxName = acnam1;
056301220117               RowxTrst = acTrst;
056302220117               RowxSub# = acSub#;
056303220117               RowxAcct = acAcct;
056400220117             endif;
056500220117           endif;
056600170529
056700170529
056800220117           if Count = 10;
056900220117             leave;
057000220117           endif;
057100220117         enddo;
057200170529
057300220117         Setll (RowxName : RowxTrst : RowxSub#: RowxAcct) AccNm3;
057400170529
057500171229       end-proc;
057600170529       // ----------------------------------------------------------------
057700171229       dcl-proc LoadS3;
057800170529
057900220117         Count = 0;
058000220117         Dou %Eof(AccNm3);
058100220117           Read AccNm3;
058200170529
058300220117           if %eof(AccNm3);
058400220117             leave;
058500220117           endif;
058600170529
058700220117           Count = count + 1;
058800220117           if Count = 1;
058900220117             Row1Name = acNam1;
058901220117             Row1Trst = acTrst;
058902220117             Row1Sub# = acSub#;
058903220117             Row1Acct = acAcct;
059000220117           endif;
059100220117           RowxName = acNam1;
059200170529
059300220117           s3Acct# = %editc(acTrst : 'X') + '-' +
059400220117              %editc(acSub# : 'X') + '-' +
059500220117              %editc(acAcct : 'X') ;
059600170529
059700220117           s3Trst = acTrst;
059800220117           s3Sub  = acSub#;
059900220117           s3Acct = acAcct;
060000171110
060100171110
060200220117           s3AcctNam = acnam1;
060300220117           s3City = aCity;
060400220117           s3State = aState;
060500220117           s3Contact = Contac;
060600170529
060700220117           s3atrmdt = *Blanks;
060800220117           if atrmdt > 0;
060900220117             test(de) *iso atrmdt;
061000220117             if %Error;
061100220117               s3atrmdt = %Char(atrmdt);
061200220117             else;
061300220117               s3atrmdt = %Char(%date(atrmdt) :*usa)  ;
061400220117             endif;
061500220117           endif;
061600170529
061700170529
061800220117           s3Status =  *blanks;
061900220117           if acdltd = 'A';
062000220117             s3Status = 'Active';
062100220117           endif;
062200220117           if acdltd = 'C';
062300220117             s3Status = 'Cancelled';
062400220117           endif;
062500170529
062600220117           //---------------------------------------
062700220117           //?S1Contains = *Blank
062800220117           //---------------------------------------
062900220117           if s1Contains = *Blanks;
063000220117             if chkActAcct = 'Y' and acdltd = 'A';
063100220117               rrn2 = rrn2 + 1;
063200220117               write AcctSfl;
063300220117             endif;
063400170529
063500220117             if chkActAcct = ' ';
063600220117               rrn2 = rrn2 + 1;
063700220117               write AcctSfl;
063800220117             endif;
063900220117           endif;
064000170529
064100220117           //---------------------------------------
064200220117           //?S1Contains has a value
064300220117           //---------------------------------------
064400220117           if s1Contains > *Blanks  and
064500220117              %Scan( %Trim(s1Contains) : s3AcctNam ) > 0;
064600170529
064700220117             if chkActAcct = 'Y' and acdltd = 'A';
064800220117               rrn2 = rrn2 + 1;
064900220117               write AcctSfl;
065000220117             endif;
065100170529
065200220117             if chkActAcct = ' ';
065300220117               rrn2 = rrn2 + 1;
065400220117               write AcctSfl;
065500220117             endif;
065600220117           endif;
065700170529
065800220117           if rrn2 = 20;
065900220117             leave;
066000220117           endif;
066100170529
066200220117         enddo;
066300170529
066400170529
066500220117         //------------------------------------------------
066600220117         //?Setup Directional Links.
066700220117         //------------------------------------------------
066800170529
066900170529
067000220117         //?Page Down
067100220117         EnableDown = *On;
067200170529
067300220117         //---------------------------------------
067400220117         //?S1Contains has a value
067500220117         //---------------------------------------
067600220117         if s1Contains > *Blanks;
067700170530
067800220117           dou %eof(AccNm3);
067900220117             read AccNm3;
068000170529
068100220117             if %eof(AccNm3);
068200220117               EnableDown = *Off;
068300220117             endif;
068400170530
068500220117             if %Scan( %Trim(s1Contains) : acNam1 ) > 0;
068600170529
068700220117               if chkActAcct = 'Y' and acdltd = 'A';
068800220117                 leave;
068900220117               endif;
069000170529
069100220117               if chkActAcct = ' ';
069200220117                 leave;
069300220117               endif;
069400220117             endif;
069500170529
069600220117           enddo;
069700170529
069800220117         endif;
069900170529
070000170529
070100170529
070200220117         //---------------------------------------
070300220117         //?S1Contains = *Blank
070400220117         //---------------------------------------
070500220117         if s1Contains = *Blanks;
070600170529
070700220117           dou %eof(AccNm3);
070800220117             read AccNm3;
070900220117             if %eof(AccNm3);
071000220117               EnableDown = *Off;
071100220117             endif;
071200170529
071300220117             if chkActAcct = 'Y' and acdltd = 'A';
071400220117               leave;
071500220117             endif;
071600170529
071700220117             if chkActAcct = ' ';
071800220117               leave;
071900220117             endif;
072000220117           enddo;
072100170529
072200220117         endif;
072300170529
072400170529
072500170529
072600170529
072700220117         //---------------------------------------
072800220117         //?Page Up
072900220117         //---------------------------------------
073000220117         EnableUp = *On;
073001220117         Setll (Row1Name : Row1Trst : Row1Sub#: Row1Acct) AccNm3;
073200170529
073300220117         //---------------------------------------
073400220117         //?S1Contains has a value
073500220117         //---------------------------------------
073600220117         if s1Contains > *Blanks;
073700220117           readp AccNm3;
073800220117           dou %eof(AccNm3);
073900170529
074000220117             if %eof(AccNm3);
074100220117               EnableUp = *Off;
074200220117             endif;
074300170530
074400220117             if %Scan( %Trim(s1Contains) : acNam1 ) > 0;
074500170529
074600220117               if chkActAcct = 'Y' and acdltd = 'A';
074700220117                 leave;
074800220117               endif;
074900170529
075000220117               if chkActAcct = ' ';
075100220117                 leave;
075200220117               endif;
075300220117             endif;
075400170529
075500220117             readp AccNm3;
075600220117           enddo;
075700170529
075800220117         endif;
075900170529
076000170529
076100170529
076200170529
076300220117         //---------------------------------------
076400220117         //?S1Contains = *Blank
076500220117         //---------------------------------------
076600220117         if s1Contains = *Blanks;
076700170529
076800220117           dou %eof(AccNm3);
076900220117             readp AccNm3;
077000220117             if %eof(AccNm3);
077100220117               EnableUp = *Off;
077200220117             endif;
077300170529
077400220117             if chkActAcct = 'Y' and acdltd = 'A';
077500220117               leave;
077600220117             endif;
077700170529
077800220117             if chkActAcct = ' ';
077900220117               leave;
078000220117             endif;
078100220117           enddo;
078200170529
078300220117         endif;
078400170529
078500170529
078600170529
078700170529
078800170529
078900170529
079000171229       end-proc;
079100170529
079200170529       // ----------------------------------------------------------------
079300171229       dcl-proc DisplyS3;
079400170529
079500220117         DspSfl = *on  ;
079600220117         exfmt Screen3;
079700220117         DspSfl = *off;
079800170529
079900171229       end-proc;
080000170529
080100170529       // ----------------------------------------------------------------
080200171229       dcl-proc ReadChangedS3;
080300170529
080400220117         Dou *in95 = *ON;
080500220117           READC AcctSfl;
080600220117           *in95 = %EOF;
080700170529
080800220117           If *in95 = *OFF;
080900170529
081000220117             If SelAcct = *on;
081100220117               //?Go Directly to application;
081200171110
081300220117               oTrst = s3Trst;
081400220117               oSub# = s3Sub ;
081500220117               oAcct = s3Acct;
081600171110
081700220117               Clear Screen1;
081800220117               AccountInq( oTrst : oSub# : oAcct );
081900220117             endIf;
082000170529
082100220117             SelAcct = *off;
082200220117             update AcctSfl;
082300170529
082400220117           endIf;
082500170529
082600170529
082700220117         enddo;
082800171229       end-proc;
082900170529
083000170529
