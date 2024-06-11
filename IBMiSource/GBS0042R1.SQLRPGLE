000100180614     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBIND' : 'GBSBDIR')
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400180905      *  Description: OLE Transaction Report
000500180905      *  Programmer.: Brian Rees
000600180905      *  Date.......:  9/05/2018
000700150226      *
000800180905      *  This will provide a list of demographic, plans and
000900180905      *    deduction changes at any time
001000180905      *
001100180905      *
001200150603      *-------------------------------------------------------------------------
001300150603      * Modifications
001400150603      *
001500150603      * Date         Programmer    Mod      Description
001600150603      *-------------------------------------------------------------------------
001700150824      *
001800150824      *
001900150226      *-------------------------------------------------------------------------
002000150824
002100180905       dcl-f GBS0042P1 keyed  usage( *output );
002200180906       Dcl-f Member  keyed ExtDesc('F.MEMBER')  ExtFile(*extdesc);
002300180906       Dcl-f DepNdc  keyed ExtDesc('F.DEPNDC')  ExtFile(*extdesc);
002400180906       Dcl-f CodesL1 keyed ExtDesc('F.CODESL1') ExtFile(*extdesc);
002500180828
002600150824
002700150226      *-------------------------------------------------------------------------
002800150226
002900180905
003000180905       Dcl-ds @Data ExtName('WEBTRAN') end-ds;
003100180912
003200180905       dcl-s SqlStmt Char( 1000 );
003300180830
003400180905       dcl-s CharSSN Char( 9 );
003500180906       dcl-s Date_8  Zoned( 8 );
003600180906       dcl-s wArea   Char( 3 );
003700180906       dcl-s wPhone  Char( 15 );
003800180906       dcl-s rCode   Char( 3 );
003900180828
004000180906       dcl-s SavSSID Char( 16 );
004100180906       dcl-s SavDSEQ Zoned( 2 );
004200180906       dcl-s hasInfo Char( 1 ) ;
004300180830
004400180912      *-------------------------------------------------------------------------
004500180912      *
004600180912      * *Entry Procedure
004700180912      *
004800180912      *-------------------------------------------------------------------------
004900180912       Dcl-pr Main ExtPgm;
005000180912          *N  Char(3);
005100180912          *N  Char(3);
005200180912          *N  Char(4);
005300180912          *N  Char(8);
005400180912          *N  Char(8);
005500180912
005600180912       End-Pr;
005700180912
005800180912       dcl-pi Main;
005900180912          pTrust Char(3);
006000180912          pSub#  Char(3);
006100180912          pAcct  Char(4);
006200180912          pStart   Char(8);
006300180912          PEnd  Char(8);
006400180912       End-Pi;
006500180912
006600180828
006700180828
006800150824      *-------------------------
006900180828      *
007000180828      * Procedure(s)
007100180828      *
007200150824      *-------------------------
007300150824
007400150824
007500180906      *-------------------------------------------------------------------------
007600180906      *
007700180906      * Mainline Program
007800180906      *
007900180906      *-------------------------------------------------------------------------
008000150825
008100180828
008200180906       hasInfo = '';
008300180828
008400150825
008500180828       //?Run the SQL Commamnd and Loop through the results
008600180905       $OpenC1();
008700180905
008800180828       Dou SqlCod <> *Zero;
008900150302
009000180907          Exec Sql
009100180907             Fetch Next From C1 Into :@data ;
009200150302
009300180828          if SqlCod <> *Zero;
009400180830             Leave;
009500180828          endif;
009600150319
009700180906          // Initial Save
009800180906          if savSSID = '';
009900180906             savSSID = oeSSID;
010000180906             savDSEQ = oedseq;
010100180906          EndIf;
010200180906
010300180906
010400180906
010500180906          if oessid <> SavSSID;
010600180906
010700180906
010800180906             SavSSID = oeSSID;
010900180906             savDSEQ = oedseq;
011000180906
011100180906             if hasInfo = 'Y';
011200180906
011300180907                getNames();
011400180906
011500180906                Write r_0042p1;
011600180906             endif;
011700180906
011800180906             Clear R_0042P1 ;
011900180906             hasInfo = '';
012000180906
012100180906
012200180906
012300180906          EndIf;
012400180906
012500180906          if savDSeq <> oedseq;
012600180906
012700180906             if hasInfo = 'Y';
012800180907                getNames();
012900180907
013000180906                Write r_0042p1;
013100180906             endif;
013200180906             Clear R_0042P1 ;
013300180906             hasInfo = '';
013400180907             savDSEQ = oedseq;
013500180906
013600180906
013700180906          EndIf;
013800180906
013900180906
014000180906
014100180905          //-------------------------------
014200180905          //
014300180905          // Global Variables
014400180905          //
014500180905          //-------------------------------
014600180905          g1Trst = oeTrst;
014700180905          g1Sub  = oeSub#;
014800180905          g1Acct = oeAcct;
014900180905          g1SSN  = oessno;
015000180907          g1dSeq = oedseq;
015100180905
015200180905          CharSSN = %Editc(oessno : 'X') ;
015300180905          g1ssn_mx = 'XXX-XX-' + %Subst( CharSSN : 6 : 4);
015400180906          g1Transdt = %Char(%Date(OECNFD : *iso) : *Usa) ;
015500180906          g1User =   oeUsrd;
015600180906          g1SSID = oessid;
015700180830
015800180905
015900180905
016000180905          //-------------------------------
016100180905          //
016200180905          // Field Specific Variables
016300180905          //
016400180905          //-------------------------------
016500180905
016600180905
016700180905
016800180905          // Member Info
016900180905          if oeGrpv = 'ADD_EMP' or
017000180905             oeGrpv = 'PER_INFO'   or
017100180905             oeGrpv = 'EMP_INFO' ;
017200180906
017300180905
017400180905             Select;
017500180906             When %Subst( oeFldv : 1 : 5 ) = 'EFFDT';
017600180906                Date_8 = %Dec( %subst( oeAfter : 1 : 8 )  : 8 : 0 );
017700180906                g1Effdt =  %Char(%Date(Date_8 : *iso) : *Usa) ;
017800180907                hasInfo = 'Y';
017900180905
018000180906             When %Subst( oeFldv : 1 : 5 ) = 'ADDR1';
018100180906                g1Addr1 =  %Trim( oeAfter );
018200180907                hasInfo = 'Y';
018300180905
018400180905
018500180906             When %Subst( oeFldv : 1 : 5 ) = 'ADDR2';
018600180906                g1Addr2 =  %Trim( oeAfter );
018700180907                hasInfo = 'Y';
018800180905
018900180905
019000180906             When %Subst( oeFldv : 1 : 4 ) = 'AREA';
019100180906                wArea =  %Trim( oeAfter );
019200180907                hasInfo = 'Y';
019300180905
019400180906             When %Subst( oeFldv : 1 : 5 ) = 'PHONE';
019500180906                wPhone =  %Trim( oeAfter );
019600180907                hasInfo = 'Y';
019700180905
019800180906             When %Subst( oeFldv : 1 : 5 ) = 'BIRTH';
019900180906                Date_8 = %Dec( %subst( oeAfter : 1 : 8 )  : 8 : 0 );
020000180906                g1bDate =  %Char(%Date(Date_8 : *iso) : *Usa) ;
020100180907                hasInfo = 'Y';
020200180905
020300180906             When %Subst( oeFldv : 1 : 4 ) = 'CITY';
020400180906                g1City =  %Trim( oeAfter );
020500180907                hasInfo = 'Y';
020600180905
020700180906             When %Subst( oeFldv : 1 : 5 ) = 'STATE';
020800180906                g1State =  %Trim( oeAfter );
020900180907                hasInfo = 'Y';
021000180905
021100180906             When %Subst( oeFldv : 1 : 3 ) = 'ZIP';
021200180906                g1Zip =  %Trim( oeAfter );
021300180907                hasInfo = 'Y';
021400180905
021500180906             When %Subst( oeFldv : 1 : 6 ) = 'MFNAME';
021600180906                g1fname =  %Trim( oeAfter );
021700180907                hasInfo = 'Y';
021800180905
021900180906             When %Subst( oeFldv : 1 : 6 ) = 'MLNAME';
022000180906                g1lname =  %Trim( oeAfter );
022100180907                hasInfo = 'Y';
022200180905
022300180906             When %Subst( oeFldv : 1 : 3 ) = 'MMI';
022400180906                g1mi =  %Trim( oeAfter );
022500180907                hasInfo = 'Y';
022600180905
022700180905             EndSl;
022800180905
022900180905
023000180905          EndIf;
023100180905
023200180906
023300180906
023400180905          if oeGrpv = 'ADD_DEPN' or
023500180905             oeGrpv = 'DEP_INFO'  ;
023600180905
023700180906
023800180905             Select;
023900180905
024000180906             When %Subst( oeFldv : 1 : 6 ) = 'DRELCD';
024100180906                rCode = %Trim( oeAfter );
024200180906                g1Gender = '';
024300180907                hasInfo = 'Y';
024400180906
024500180906                chain rCode Codesl1;
024600180906                if %Found( Codesl1 );
024700180906                   g1Gender = %Trim( Fill18 );
024800180906                EndIf;
024900180906
025000180905
025100180906             When %Subst( oeFldv : 1 : 6 ) = 'DEPSS#';
025200180906                g1DepSsn = 'XXX-XX-' + %Subst( oeAfter : 6 : 4);
025300180907                hasInfo = 'Y';
025400180905
025500180906             When %Subst( oeFldv : 1 : 6 ) = 'DLNAME';
025600180906                g1dlname =  %Trim( oeAfter );
025700180907                hasInfo = 'Y';
025800180905
025900180906             When %Subst( oeFldv : 1 : 6 ) = 'DFNAME';
026000180906                g1dfname =  %Trim( oeAfter );
026100180907                hasInfo = 'Y';
026200180905
026300180906             When %Subst( oeFldv : 1 : 3 ) = 'DMI';
026400180906                g1dmi =  %Trim( oeAfter );
026500180907                hasInfo = 'Y';
026600180905
026700180906             When %Subst( oeFldv : 1 : 6 ) = 'DADDR1';
026800180906                g1Addr1 =  %Trim( oeAfter );
026900180907                hasInfo = 'Y';
027000180905
027100180906             When %Subst( oeFldv : 1 : 6 ) = 'DADDR2';
027200180906                g1Addr2 =  %Trim( oeAfter );
027300180907                hasInfo = 'Y';
027400180905
027500180906             When %Subst( oeFldv : 1 : 5 ) = 'DCITY';
027600180906                g1city =  %Trim( oeAfter );
027700180907                hasInfo = 'Y';
027800180905
027900180906             When %Subst( oeFldv : 1 : 6 ) = 'DSTATE';
028000180906                g1State =  %Trim( oeAfter );
028100180907                hasInfo = 'Y';
028200180905
028300180906             When %Subst( oeFldv : 1 : 4 ) = 'DZIP';
028400180906                g1Zip =  %Trim( oeAfter );
028500180907                hasInfo = 'Y';
028600180905
028700180906             When %Subst( oeFldv : 1 : 5 ) = 'DAREA';
028800180906                wArea =  %Trim( oeAfter );
028900180907                hasInfo = 'Y';
029000180905
029100180906             When %Subst( oeFldv : 1 : 6 ) = 'DPHONE';
029200180906                wPhone =  %Trim( oeAfter );
029300180907                hasInfo = 'Y';
029400180905
029500180906             When %Subst( oeFldv : 1 : 6 ) = 'DBIRTH';
029600180907                hasInfo = 'Y';
029700180906                Date_8 = %Dec( %subst( oeAfter : 1 : 8 )  : 8 : 0 );
029800180906                g1bDate =  %Char(%Date(Date_8 : *iso) : *Usa);
029900180905
030000180906             When %Subst( oeFldv : 1 : 13) = 'MEDICARE_FLAG';
030100180911                g1Medi =  %Trim( oeAfter );
030200180907                hasInfo = 'Y';
030300180905
030400180906             When %Subst( oeFldv : 1 : 13) = 'HANDICAP_FLAG';
030500180911                g1Handi =  %Trim( oeAfter );
030600180907                hasInfo = 'Y';
030700180906
030800180906
030900180906             When %Subst( oeFldv : 1 : 6 ) = 'DSTUDN';
031000180906                g1Studnt =  %Trim( oeAfter );
031100180907                hasInfo = 'Y';
031200180905
031300180906             When %Subst( oeFldv : 1 : 5 ) = 'PYSMK';
031400180906                g1Smoker =  %Trim( oeAfter );
031500180907                hasInfo = 'Y';
031600180905
031700180905
031800180905             EndSl;
031900180905
032000180906          endif;
032100180905
032200180905
032300180830
032400180828       enddo;
032500150824
032600180828       Exec Sql  Close C1;
032700150302
032800180828       *inlr = *on;
032900180905
033000180828       // ----------------------------------------------------------------
033100150309
033200180905       dcl-proc $OpenC1;
033300150302
033400180828          SqlStmt =
033500180905             'Select WebTran.* ' +
033600180905             '   From Webtran                            ' +
033700180905             '   Where Oetrst = ' + pTrust +
033800180905             '     and oeSub# = ' + pSub#  +
033900180905             '     and oeAcct = ' + pAcct  +
034000180905             '     and  oecnfd between ' + pStart + ' and ' + pEnd  +
034100180906             ' order by oessid, oedseq';
034200180828
034300180828          Exec Sql
034400180828             Declare C1 Cursor For Sqlstmt;
034500180828          Exec Sql
034600180828             Prepare Sqlstmt From :Sqlstmt;
034700180905          Exec Sql
034800180905             Open C1;
034900180828
035000180828
035100180905       end-proc;
035200180905
035300180906
035400180906       // ----------------------------------------------------------------
035500180906
035600180907       dcl-proc GetNames;
035700180906
035800180906
035900180906          //-----------------------------------------------------
036000180906          //
036100180906          // If this transaction doens't have the Dependents name,
036200180906          // retrieve it from the system
036300180906          //
036400180906          //-----------------------------------------------------
036500180906
036600180906          if g1fname = '' or g1lname = '';
036700180906             chain g1SSN Member;
036800180906             if %Found( Member );
036900180906                if g1fname = '';
037000180906                   g1fname = mfname;
037100180906                EndIf;
037200180906
037300180906                if g1lname = '';
037400180906                   g1lname = mlname;
037500180906                EndIf;
037600180906
037700180906             EndIf;
037800180906          EndIf;
037900180906
038000180907
038100180907          if g1dseq > 0;
038200180906             if g1dfname = '' or g1dlname = '';
038300180907
038400180907                chain ( g1ssn : g1dseq ) Depndc;
038500180907                if %Found( Depndc );
038600180907
038700180906                   if g1dfname = '';
038800180906                      g1dfname = dfname;
038900180906                   EndIf;
039000180906
039100180906                   if g1dlname = '';
039200180906                      g1dlname = dlname;
039300180906                   EndIf;
039400180906
039500180906                EndIf;
039600180906             EndIf;
039700180906          EndIf;
039800180906
039900180906       End-Proc;
