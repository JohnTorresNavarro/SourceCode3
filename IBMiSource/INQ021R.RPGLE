000100180724       Ctl-opt option(*noDebugIo)   DftActGrp(*no)
000200190514         bnddir( 'GBSBIND' );
000300180607
000400180607      *-------------------------------------------------------------------------
000500180607      *
000600190515      *  Description: Generate a Check by Phone PDF for COBRA Members
000700180607      *
000800180607      *  Programmer.: Brian Rees
000900180607      *  Date.......: 06/07/2018
001000180607      *
001100180607      *-------------------------------------------------------------------------
001200180607
001300180607      *-------------------------------------------------------------------------
001400180607      *
001500180607      * Declare Files
001600180607      *
001700180607      *-------------------------------------------------------------------------
001800180917
001900190514       Dcl-f Inq021d WorkStn
002000190514         Handler('PROFOUNDUI(HANDLER)');
002100190514
002200190514       dcl-f INQ021P  usage( *output );
002300190514
002400190514       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
002500190514       dcl-f MemAlt keyed;
002600190514       dcl-f Gbsecure keyed;
002700190515
002800190515       dcl-f Diaryhd0 keyed ExtDesc('F.DIARYHD0') ExtFile(*extdesc)
002900190515         usage(*Output);
003000180607
003100190515       dcl-f Diarydt0 keyed ExtDesc('F.DIARYDT0') ExtFile(*extdesc)
003200190515         usage(*Output);
003300190515
003400190515       dcl-f Hist keyed ExtDesc('F.HIST') ExtFile(*extdesc)
003500190515         usage(*output);
003600190515
003700180607      *-------------------------------------------------------------------------
003800180607      *
003900180607      * Global Variables
004000180607      *
004100180607      *-------------------------------------------------------------------------
004200190514
004300190514       dcl-ds pgmd
004400190514         ExtName('IOPGMD') PSDS;
004500190514         @pgmq *proc;
004600190514       end-ds;
004700190514
004800190514
004900190514       dcl-s CharZip Char(9);
005000190514       dcl-s CharPhone Char(10);
005100190514       dcl-s AltType Char(4) inz('GBS');
005200180824
005300180824      *-------------------------------------------------------------------------
005400180824      *
005500180824      * *Entry Procedure
005600180824      *
005700180824      *-------------------------------------------------------------------------
005800190515       Dcl-pr Main ExtPgm;
005900190515         *N  Zoned(9);
006000190515         *N  Char(1);
006100190515       End-Pr;
006200190514
006300190515       dcl-pi Main;
006400190515         pSSN  Zoned(9);
006500190515         pCont Char(1);
006600190515       End-Pi;
006700180607
006800180724
006900180607      *-------------------------------------------------------------------------
007000180607      *
007100180607      * Mainline Program
007200180607      *
007300180607      *-------------------------------------------------------------------------
007400190514
007500190514
007600190514       loadData();
007700190514
007800190514
007900190514       Dou btnExit = *on;
008000190514
008100190514         exfmt Screen1;
008200190514
008300190514         if btnExit = *on;
008400190514           leave;
008500190514         EndIf;
008600190514
008700190515         if btnAccept = *on;
008800190515           SubmitForm();
008900190515           DiaryNote();
009000190515           pCont = 'Y';
009100190515           leave;
009200190515         EndIf;
009300190514
009400190514
009500190514       enddo;
009600190514
009700180607
009800180607       *inlr = *on;
009900190514
010000190515
010100190515       // ----------------------------------------------------------------
010200190515       dcl-proc DiaryNote;
010300190515
010400190515         Clear rDiaryhd;
010500190515
010600190515         nhKey = ' ' + %EditC( pssn : 'X' );
010700190515         nhCode = 'WPY';
010800190515         nhSubj = 'Check by Phone Submitted. Check: ' +
010900190515           %Trim( s1Check# ) ;
011000190515         nhaddt = %Dec( %Date );
011100190515         nhadti = %Dec( %Time );
011200190515         nhadus = wqusrn;
011300190515         Write rDiaryHd;
011400190515
011500190515
011600190515         Clear rDiaryDt;
011700190515         ndKey = nhKey;
011800190515         ndaddt = nhAddt;
011900190515         ndadti = nhadti;
012000190515         ndseq# = 1;
012100190515         ndText = 'Check: ' + %Trim( s1Check# ) +
012200190515           '  Amount: ' + %Editc( S1Amount : 'J');
012300190515         write rDiaryDt;
012400190515
012500190515
012600190515
012700190515         Clear Histr;
012800190515         hkey = ' ' + %Editc( pSsn : 'X' );
012900190515         trcode = 'M81';
013000190515         hprgnm = @pgmq;
013100190515         hstrst = mbtrst;
013200190515         hssub# = mbsub#;
013300190515         hsacct = mbacct;
013400190515         hsdltd = 'A';
013500190515         trdate = %dec(%date);
013600190515         hstrtime = %time;
013700190515         hoper = wqusrn;
013800190515         ck#not = nhSubj;   // Must match for INQ002 to look it up.
013900190515         note2 = 'k: ' + %Trim( s1Check# ) +
014000190515           '  Amount: ' + %Editc( S1Amount : 'J');
014100190515         Write Histr;
014200190515
014300190515
014400190515       End-Proc;
014500190515
014600190514
014700190514       // ----------------------------------------------------------------
014800190514       dcl-proc SubmitForm;
014900190514
015000190514
015100190515         write HEADER1;
015200190514
015300190514
015400190515         pTitle = 'COBRA - Fully Insured Check by Phone';
015500190515         DPGMNAME = 'INQ021R';
015600190515
015700190515         write FORM;
015800190514
015900190514         dCompany = s1FulName;
016000190514         dAddr1 = s1Addr1;
016100190514         dAddr2 = s1Addr2;
016200190514         dcsz   = s1csz;
016300190514         dPhone = s1Phone;
016400190514         dEmail = s1Email;
016500190514         dDate  = s1Date;
016600190514         dCheck# = s1Check#;
016700190514         dAmount = %Char(s1Amount);
016800190514         dCobra# = s1Cobra#;
016900190514         dUser = s1User;
017000190514         dRouting = s1Routing;
017100190514         dBank = s1BankName;
017200190514         dBankAct = s1BankAcct;
017300190514         dAuthPmt = s1AuthPmt;
017400190514
017500190514
017600190515         write Data;
017700190514
017800190514
017900190514
018000190514       End-Proc;
018100190514
018200190514
018300190514
018400190514       // ----------------------------------------------------------------
018500190514       dcl-proc LoadData;
018600190514
018700190515          pCont = '';
018800190515
018900190514         // Prefill Screen Data
019000190514         chain pSSN Member;
019100190514         s1FulName = %Trim( mfname ) + ' ' + %Trim( mlname );
019200190514         s1Addr1 = Addr1;
019300190514         s1Addr2 = Addr2;
019400190514
019500190514
019600190514         CharZip = %Editc(Zip : 'X' );
019700190514         s1csz   = %Trim( city ) + ', ' + State + '  ' +
019800190514           %SubSt(CharZip:1:5);
019900190514
020000190514         if %SubSt(CharZip:6:4) <> '0000';
020100190514           s1csz = %Trim( s1csz ) + '-' + %SubSt(CharZip:6:4);
020200190514         EndIf;
020300190514
020400190514         CharPhone = %Editc(Area: 'X' ) + %Editc(Phone:'X');
020500190514         s1Phone = %Subst( CharPhone : 1 : 3 ) + ' ' +
020600190514           %Subst( CharPhone : 4 : 3 ) + '-' +
020700190514           %Subst( CharPhone : 7 : 4 );
020800190514
020900190514         s1Email = Fill66;
021000190514         s1Date  = %Char(%Date:*Usa);
021100190514
021200190514         s1Cobra# = '';
021300190514         chain (pSSN : AltType) MemAlt;
021400190514         if %Found( MemAlt );
021500190514           s1COBRA# = maAltId;
021600190514         EndIf;
021700190514
021800190514
021900190514         chain wqusrn gbsecure;
022000190514         if %Found( gbsecure );
022100190514           s1User = scname;
022200190514         endif;
022300190514
022400190514
022500190514       end-proc;
022600180724
022700180917
