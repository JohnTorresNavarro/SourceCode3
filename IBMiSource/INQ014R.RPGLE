000100171229       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no);
000200171229
000300171229      *-------------------------------------------------------------------------
000400171229      *
000500180226      *  Description: Search by Dependent Information
000600180115      *  Programmer.: Brian Rees
000700180226      *  Date.......: 02/26/2018
000800171229      *
000900171229      *-------------------------------------------------------------------------
001000171229
001100180115
001200171229      *-------------------------------------------------------------------------
001300171229      *
001400171229      * Declare Files
001500171229      *
001600171229      *-------------------------------------------------------------------------
001700180223       Dcl-f Inq014d WorkStn
001800171229          Handler('PROFOUNDUI(HANDLER)')
001900180115          SFILE(MBRSFL:rrn);
002000171229
002100180226       Dcl-f Dependl4 ExtFile(*ExtDesc) ExtDesc('F.DEPENDL4') keyed;
002200180226       Dcl-f Dependl2 ExtFile('F.DEPENDL2') Rename( DEPENR : Rcd1 ) keyed;
002300180223       Dcl-f Member   ExtFile('F.MEMBER')   keyed;
002400171229
002500170525
002600171229      *-------------------------------------------------------------------------
002700171229      *
002800171229      * Global Variables
002900171229      *
003000171229      *-------------------------------------------------------------------------
003100171229       Dcl-s rrn Zoned(5) inz;
003200171229       Dcl-s FirstRun Char(1) inz;
003300171229       Dcl-s Count Zoned(5) inz;
003400171229
003500180223       dcl-s Searchssn Zoned(9);
003600180223       dcl-s Row1ssn   Zoned(9);
003700180223       dcl-s Rowxssn   Zoned(9);
003800171229
003900180226       dcl-s Row1M_Ssn Zoned(9);
004000180226       dcl-s RowxM_Ssn Zoned(9);
004100180226
004200180226       dcl-s Row1lname Char(18);
004300180226       dcl-s Row1fname Char(12);
004400180226
004500180226       dcl-s Rowxlname Char(18);
004600180226       dcl-s Rowxfname Char(12);
004700180226
004800180115       dcl-c digits '0123456789';
004900170525
005000170605
005100171229      *-------------------------------------------------------------------------
005200171229      *
005300171229      * Procedures
005400171229      *
005500171229      *-------------------------------------------------------------------------
005600171229       dcl-pr MemberInq ExtPgm('INQ002R');
005700201014         oMember Zoned(9);
005800171229       End-Pr;
005900171229
006000171229       dcl-s oMember Zoned(9);
006100171229
006200171229
006300161111
006400171229      *-------------------------------------------------------------------------
006500171229      *
006600171229      * Mainline Program
006700171229      *
006800171229      *-------------------------------------------------------------------------
006900170525
007000170525
007100180115       Dou btnCancel = *on;
007200161109
007300201014         ClearS1();
007400180115
007500201014         //   Validate Search Value
007600201014         ErrSearch = *off;
007700201014         if %Check( Digits : %Trim( SrchSSN )) > 0;
007800201014           ErrSearch = *on;
007900201014         EndIf;
008000180223
008100201014         // Only display if there isn't an error
008200201014         if ErrSearch = *off;
008300180226
008400201014           // Searching for Name or SSN?
008500201014           if SrchName > '';
008600180226
008700201014             SetPosName();
008800201014             LoadS1_Name();
008900180226
009000201014           else;
009100180226
009200201014             SetPosS1();
009300201014             LoadS1();
009400180226
009500201014           EndIf;
009600180226
009700201014         endif;
009800161109
009900201014         DisplyS1();
010000161109
010100170528
010200201014         //?Process Selections
010300201014         Select;
010400170528
010500201014         other;
010600201014           ReadChangedS1();
010700201014         EndSl;
010800161109
010900180115       enddo;
011000161109
011100180115       *inlr = *on;
011200180115
011300161109
011400170525       // ----------------------------------------------------------------
011500180115       dcl-proc SetPosS1;
011600170525
011700201014         Select;
011800201014         When FirstRun = 'Y';       //?First Load
011900201014           FirstRun = 'N';
012000201014           SearchSsn = s1DepSSN;
012100201014           setll SearchSsn Dependl4;
012200170527
012300201014         When btnSearch = *on;
012400201014           btnSearch = *off;
012500201014           monitor;
012600180223             SearchSSN = %Dec(SrchssN:9:0);
012700201014           on-error;
012800201014             SearchSSN = 0;
012900201014           endmon;
013000180223
013100201014           setll SearchSSN Dependl4;
013200170529
013300201014         When PageDown = *On;
013400201014           Setll (RowxSSN : RowxM_ssn) Dependl4;
013500170527
013600170527
013700201014         When PageUp = *On;
013800201014           Setll (Row1SSN : Row1M_ssn) Dependl4;
013900201014           Prev();
014000170530
014100201014         other;
014200201014           Setll (Row1SSN : Row1M_Ssn ) Dependl4;
014300170530
014400201014         EndSL;
014500170527
014600171229       End-Proc;
014700171229
014800170525       // ----------------------------------------------------------------
014900171229
015000171229       dcl-proc Prev;
015100170525
015200201014         count = 0;
015300170525
015400201014         //?Read the previous 10 records to set the pointer
015500201014         //?to the right spot.
015600201014         Dou %Eof(Dependl4);
015700201014           readp Dependl4;
015800201014           if %eof(Dependl4);
015900201014             leave;
016000201014           endif;
016100170528
016200201014           Count = Count + 1;
016300201014           RowxSSN = DepSS#;
016400201014           Rowxm_ssn = dssno;
016500180115
016600201014           if Count = 20;
016700201014             leave;
016800201014           endif;
016900201014         enddo;
017000170527
017100201014         Setll (RowxSSN: Rowxm_ssn)  Dependl4;
017200170527
017300171229       End-Proc;
017400171229
017500161109       // ----------------------------------------------------------------
017600171229
017700180115       dcl-proc ClearS1;
017800161109
017900201014         //?Clear the Subfile
018000201014         ClrSfl = *on;
018100201014         Write Screen1;
018200201014         ClrSfl = *off;
018300201014         rrn = 0;
018400161109
018500171229       end-Proc;
018600161109       // ----------------------------------------------------------------
018700180115       dcl-proc LoadS1;
018800161109
018900201014         Count = 0;
019000201014         Dou %Eof(Dependl4);
019100201014           Read Dependl4;
019200170527
019300201014           if %eof(Dependl4);
019400201014             leave;
019500201014           endif;
019600170527
019700201014           Count = count + 1;
019800170527
019900170527
020000201014           if Count = 1;
020100201014             Row1SSN = DepSS#;
020200201014             row1M_Ssn = dssno;
020300201014           endif;
020400170527
020500201014           RowxSSN = DepSS#;
020600201014           rowxm_ssn = dssno;
020700170527
020800180223
020900180223
021000201014           s1Depssn = DepSS#;
021100201014           s1dFulName = %trim(dlname) + ', ' + %Trim(dfname);
021101201014
021102201014
021200201014           //s1bdate  = %Char(%Date(dbirth:*iso):*Usa);
021300180223
021400180223
021401201014           s1bDate = '';
021402201014           if dBirth > 0;
021403201014             test(de) *iso dBirth;
021404201014             if %Error;
021405201014               s1bDate = %Char(dBirth);
021406201014             else;
021407201014               s1bDate = %Char(%date(dBirth) :*usa)  ;
021408201014             endif;
021409201014           endif;
021500201014           s1ssn = dssno;
021600201014           s1FulNAme = '';
021700180223
021800201014           chain s1ssn Member;
021900201014           if %Found( Member );
022000201014             s1FulName = %trim(mlname) + ', ' + %Trim(mfname);
022100201014           EndIf;
022200180223
022300180223
022400201014           rrn = rrn + 1;
022500201014           write MbrSfl;
022600170528
022700170528
022800201014           if rrn = 20;
022900201014             leave;
023000201014           endif;
023100170525
023200201014         enddo;
023300170527
023400170527
023500201014         //?Setup Directional Links.
023600201014         //?Page Down
023700201014         EnableDown = *On;
023800170527
023900201014         Setgt (RowxSSN : Rowxm_ssn) Dependl4;
024000201014         read  Dependl4;
024100201014         if %eof(Dependl4);
024200201014           EnableDown = *Off;
024300201014         endif;
024400170527
024500201014         //?Page Up
024600201014         EnableUp = *On;
024700170527
024800201014         Setll (Row1SSN : row1m_ssn) Dependl4;
024900201014         readp Dependl4;
025000201014         if %eof(Dependl4);
025100201014           EnableUp = *Off;
025200201014         endif;
025300170527
025400161109
025500171229       end-proc;
025600161109
025700161109       // ----------------------------------------------------------------
025800171229
025900180115       dcl-proc DisplyS1;
026000161109
026100201014         DspSfl = *on  ;
026200201014         exfmt Screen1;
026300201014         DspSfl = *off;
026400161109
026500171229       end-proc;
026600171229
026700161109       // ----------------------------------------------------------------
026800171229
026900180115       dcl-proc ReadChangedS1;
027000161109
027100201014         Dou *in95 = *ON;
027200201014           READC MbrSfl;
027300201014           *in95 = %EOF;
027400161109
027500201014           If *in95 = *OFF;
027600161109
027700201014             If SelSSN = *on;
027800201014               //?Go Directly to application;
027900201014               oMember = s1ssn;
028000201014               Clear Screen1;
028100201014               MemberInq( oMember );
028200201014             endIf;
028300170320
028400201014             SelSSN = *off;
028500201014             update MbrSfl;
028600161109
028700201014           endIf;
028800161118
028900161109
029000201014         enddo;
029100171229       end-proc;
029200161109
029300180226
029400180226
029500180226
029600180226
029700180226       // ----------------------------------------------------------------
029800180226       dcl-proc SetPosName;
029900180226
030000201014         Select;
030100180226
030200201014         When btnSearch = *on;
030300201014           btnSearch = *off;
030400201014           setll (SrchName : SrchfName ) Dependl2;
030500180226
030600201014         When PageDown = *On;
030700201014           Setll (RowxlName : Rowxfname) Dependl2;
030800180226
030900180226
031000201014         When PageUp = *On;
031100201014           Setll (Row1lname : Row1fname) Dependl2;
031200201014           Prev_Name();
031300180226
031400201014         other;
031500201014           Setll (Row1lname : Row1fname) Dependl2;
031600180226
031700201014         EndSL;
031800180226
031900180226       End-Proc;
032000180226
032100180226       // ----------------------------------------------------------------
032200180226       dcl-proc LoadS1_Name;
032300180226
032400201014         Count = 0;
032500201014         Dou %Eof(Dependl2);
032600201014           Read Dependl2;
032700180226
032800201014           if %eof(Dependl2);
032900201014             leave;
033000201014           endif;
033100180226
033200201014           Count = count + 1;
033300180226
033400180226
033500201014           if Count = 1;
033600201014             Row1lname = dlname;
033700201014             row1fname = dfname;
033800201014           endif;
033900180226
034000201014           Rowxlname = dlname;
034100201014           rowxfname = dfname;
034200180226
034300180226
034400180226
034500201014           s1Depssn = DepSS#;
034600201014           s1dFulName = %trim(dlname) + ', ' + %Trim(dfname);
034700201014           s1bdate  = %Char(%Date(dbirth:*iso):*Usa);
034800180226
034900180226
035000201014           s1ssn = dssno;
035100201014           s1FulNAme = '';
035200180226
035300201014           chain s1ssn Member;
035400201014           if %Found( Member );
035500201014             s1FulName = %trim(mlname) + ', ' + %Trim(mfname);
035600201014           EndIf;
035700180226
035800180226
035900201014           rrn = rrn + 1;
036000201014           write MbrSfl;
036100180226
036200180226
036300201014           if rrn = 20;
036400201014             leave;
036500201014           endif;
036600180226
036700201014         enddo;
036800180226
036900180226
037000201014         //?Setup Directional Links.
037100201014         //?Page Down
037200201014         EnableDown = *On;
037300180226
037400201014         Setgt (Rowxlname : Rowxfname) Dependl2;
037500201014         read  Dependl2;
037600201014         if %eof(Dependl2);
037700201014           EnableDown = *Off;
037800201014         endif;
037900180226
038000201014         //?Page Up
038100201014         EnableUp = *On;
038200180226
038300201014         Setll (Row1lname : row1fname) Dependl2;
038400201014         readp Dependl2;
038500201014         if %eof(Dependl2);
038600201014           EnableUp = *Off;
038700201014         endif;
038800180226
038900180226
039000180226       end-proc;
039100180226
039200180226       // ----------------------------------------------------------------
039300180226
039400180226       dcl-proc Prev_Name;
039500180226
039600201014         count = 0;
039700180226
039800201014         //?Read the previous 10 records to set the pointer
039900201014         //?to the right spot.
040000201014         Dou %Eof(Dependl2);
040100201014           readp Dependl2;
040200201014           if %eof(Dependl2);
040300201014             leave;
040400201014           endif;
040500180226
040600201014           Count = Count + 1;
040700201014           Rowxlname = dlname;
040800201014           Rowxfname = dfname;
040900180226
041000201014           if Count = 20;
041100201014             leave;
041200201014           endif;
041300201014         enddo;
041400180226
041500201014         Setll (Rowxlname: Rowxfname)  Dependl2;
041600180226
041700180226       End-Proc;
