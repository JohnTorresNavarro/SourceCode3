000100180724       Ctl-opt option(*noDebugIo)   DftActGrp(*no)
000200190514         bnddir( 'GBSBIND' );
000300180607
000400180607      *-------------------------------------------------------------------------
000500180607      *
000600190515      *  Description: Generate Generate a Check by Phone PDF for Senior Dental
000700190515      *     Accounts
000800180607      *
000900180607      *  Programmer.: Brian Rees
001000180607      *  Date.......: 06/07/2018
001100180607      *
001200180607      *-------------------------------------------------------------------------
001300180607
001400180607      *-------------------------------------------------------------------------
001500180607      *
001600190516      * Declare Files
001700180607      *
001800180607      *-------------------------------------------------------------------------
001900180917
002000190514       Dcl-f Inq021d WorkStn
002100190514         Handler('PROFOUNDUI(HANDLER)');
002200190514
002300190514       dcl-f INQ021P  usage( *output );
002400190514
002500190515
002600190515       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
002700190515       dcl-f gbsecure keyed;
002800190515
002900190515       dcl-f Diaryhd0 keyed ExtDesc('F.DIARYHD0') ExtFile(*extdesc)
003000190515         usage(*Output);
003100180607
003200190515       dcl-f Diarydt0 keyed ExtDesc('F.DIARYDT0') ExtFile(*extdesc)
003300190515         usage(*Output);
003400190515
003500190515       dcl-f Hist keyed ExtDesc('F.HIST') ExtFile(*extdesc)
003600190515         usage(*output);
003700190515
003800180607      *-------------------------------------------------------------------------
003900180607      *
004000180607      * Global Variables
004100180607      *
004200180607      *-------------------------------------------------------------------------
004300190514
004400190514       dcl-ds pgmd
004500190514         ExtName('IOPGMD') PSDS;
004600190514         @pgmq *proc;
004700190514       end-ds;
004800190514
004900190514
005000190514       dcl-s CharZip Char(9);
005100190514       dcl-s CharPhone Char(10);
005200180824
005300180824      *-------------------------------------------------------------------------
005400180824      *
005500180824      * *Entry Procedure
005600180824      *
005700180824      *-------------------------------------------------------------------------
005800190515       Dcl-pr Main ExtPgm;
005900190515         *N  Zoned(3);
006000190515         *N  Zoned(3);
006100190515         *N  Zoned(4);
006200190516         *N  Char(1);
006300190515       End-Pr;
006400190514
006500190515       dcl-pi Main;
006600190515         pTrst Zoned(3);
006700190515         pSub# Zoned(3);
006800190515         pAcct Zoned(4);
006900190516         pCont Char(1);
007000190515       End-Pi;
007100180607
007200180724
007300180607      *-------------------------------------------------------------------------
007400180607      *
007500180607      * Mainline Program
007600180607      *
007700180607      *-------------------------------------------------------------------------
007800190514
007900190514       loadData();
008000190516       pCont = '';
008100190514
008200190514
008300190514       Dou btnExit = *on;
008400190514
008500190514         exfmt Screen1;
008600190514
008700190514         if btnExit = *on;
008800190514           leave;
008900190514         EndIf;
009000190514
009100190515         if btnAccept = *on;
009200190515           SubmitForm();
009300190515           DiaryNote();
009400190516           pCont = 'Y';
009500190515           leave;
009600190515         EndIf;
009700190514
009800190514
009900190514       enddo;
010000190514
010100180607
010200180607       *inlr = *on;
010300190514
010400190515
010500190515       // ----------------------------------------------------------------
010600190515       dcl-proc DiaryNote;
010700190515
010800190515         Clear rDiaryhd;
010900190515
011000190515         nhKey =  %EditC( pTrst : 'X' ) +
011100190515           %EditC( pSub# : 'X' ) +
011200190515           %EditC( pAcct : 'X' );
011300190515
011400190515         nhCode = 'WPY';
011500190515         nhSubj = 'Check by Phone Submitted. Check: ' +
011600190515           %Trim( s1Check# ) ;
011700190515         nhaddt = %Dec( %Date );
011800190515         nhadti = %Dec( %Time );
011900190515         nhadus = wqusrn;
012000190515         Write rDiaryHd;
012100190515
012200190515
012300190515         Clear rDiaryDt;
012400190515         ndKey = nhKey;
012500190515         ndaddt = nhAddt;
012600190515         ndadti = nhadti;
012700190515         ndseq# = 1;
012800190515         ndText = 'Check: ' + %Trim( s1Check# ) +
012900190515           '  Amount: ' + %Editc( S1Amount : 'J');
013000190515         write rDiaryDt;
013100190515
013200190515
013300190515
013400190515         Clear Histr;
013500190515         hkey = nhKey;
013600190515         trcode = 'L81';
013700190515         hprgnm = @pgmq;
013800190515         hstrst = ptrst;
013900190515         hssub# = psub#;
014000190515         hsacct = pacct;
014100190515         hsdltd = 'A';
014200190515         trdate = %dec(%date);
014300190515         hstrtime = %time;
014400190515         hoper = wqusrn;
014500190515         ck#not = nhSubj;   // Must match for INQ002 to look it up.
014600190515         note2 = 'k: ' + %Trim( s1Check# ) +
014700190515           '  Amount: ' + %Editc( S1Amount : 'J');
014800190515         Write Histr;
014900190515
015000190515
015100190515       End-Proc;
015200190515
015300190514
015400190514       // ----------------------------------------------------------------
015500190514       dcl-proc SubmitForm;
015600190514
015700190514
015800190515         write HEADER1;
015900190514
016000190515         if pTrst >= 25 and pTrst <= 75;
016100190515           pTitle = 'Senior Dental: Check by Phone';
016200190515         endif;
016300190515
016400190515         if pTrst = 76;
016500190515           pTitle = 'Mobile Dental Care: Check by Phone';
016600190515         EndIf;
016700190515
016800190515
016900190515         DPGMNAME = 'INQ021R1';
017000190515
017100190515         write FORM;
017200190514
017300190514         dCompany = s1FulName;
017400190514         dAddr1 = s1Addr1;
017500190514         dAddr2 = s1Addr2;
017600190514         dcsz   = s1csz;
017700190514         dPhone = s1Phone;
017800190514         dEmail = s1Email;
017900190514         dDate  = s1Date;
018000190514         dCheck# = s1Check#;
018100190514         dAmount = %Char(s1Amount);
018200190514         dCobra# = s1Cobra#;
018300190514         dUser = s1User;
018400190514         dRouting = s1Routing;
018500190514         dBank = s1BankName;
018600190514         dBankAct = s1BankAcct;
018700190514         dAuthPmt = s1AuthPmt;
018800190514
018900190514
019000190515         write Data;
019100190514
019200190514
019300190514
019400190514       End-Proc;
019500190514
019600190514
019700190514
019800190514       // ----------------------------------------------------------------
019900190514       dcl-proc LoadData;
020000190514
020100190514
020200190514         // Prefill Screen Data
020300190515         chain ( pTrst : pSub# : pAcct ) AccMSt;
020400190515         s1FulName = acNam1;
020500190515         s1Addr1 = aaddr1;
020600190515         s1Addr2 = aaddr2;
020700190514
020800190514
020900190515         CharZip = %Editc(aZip : 'X' );
021000190515         s1csz   = %Trim( acity ) + ', ' + aState + '  ' +
021100190514           %SubSt(CharZip:1:5);
021200190514
021300190514         if %SubSt(CharZip:6:4) <> '0000';
021400190514           s1csz = %Trim( s1csz ) + '-' + %SubSt(CharZip:6:4);
021500190514         EndIf;
021600190514
021700190515         CharPhone = %Editc(aArea: 'X' ) + %Editc(aPhone:'X');
021800190514         s1Phone = %Subst( CharPhone : 1 : 3 ) + ' ' +
021900190514           %Subst( CharPhone : 4 : 3 ) + '-' +
022000190514           %Subst( CharPhone : 7 : 4 );
022100190514
022200190515         s1Email = ''  ;
022300190514         s1Date  = %Char(%Date:*Usa);
022400190514
022500190515         s1Cobra# = %Editc(pTrst : 'X' ) + '-' +
022600190516           %Editc(pSub# : 'X' ) + '-' +
022700190516           %Editc(pAcct : 'X' );
022800190515
022900190515
023000190514         chain wqusrn gbsecure;
023100190514         if %Found( gbsecure );
023200190514           s1User = scname;
023300190514         endif;
023400190514
023500190514
023600190514       end-proc;
023700180724
023800180917
