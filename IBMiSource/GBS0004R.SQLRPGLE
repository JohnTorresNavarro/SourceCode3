000100180614     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBIND' : 'GBSBDIR')
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400150824      *  Description:  WebTran Payroll Report
000500150226      *  Programmer.:  Brian Rees
000600150824      *  Date.......:   8/24/2015
000700150226      *
000800150313      *  (c)Copyright 2015 by GBS, Inc.
000900150226      *
001000150824      *   The ladies requested a CYA report that would list out the changes in
001100150824      *   webtran for the month.
001200150603      *-------------------------------------------------------------------------
001300150603      * Modifications
001400150603      *
001500150603      * Date         Programmer    Mod      Description
001600150603      *-------------------------------------------------------------------------
001700150824      *
001800150824      *
001900150226      *-------------------------------------------------------------------------
002000150824
002100180828       dcl-f PayReptp keyed  usage( *output );
002200180830       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
002300180830       Dcl-f DepNdc keyed ExtDesc('F.DEPNDC') ExtFile(*extdesc);
002400180828
002500150824
002600150226      *-------------------------------------------------------------------------
002700150226
002800150302     D @Data           ds
002900150824     D  sqAccName                    40
003000150824     D  sqMember                      9  0
003100150824     D  sqDepSeq                      2  0
003200150824     D  sqSessId                     16
003300150824     D  sqGrpv                       10
003400150824     D  sqFldv                       20
003500150824     D  sqBefore                    100
003600150824     D  sqAfter                     100
003700150824     D  sqCnfF                        1
003800150824     D  sqCnfU                       10
003900150824     D  sqCnfD                        8  0
004000150824     D  sqSigF                        1
004100150824     D  sqSigU                       10
004200150824     D  sqSigD                        8  0
004300150824
004400150825     d  RptMonth       s              2s 0
004500150825     d  RptYear        s              4s 0
004600150825     d  RptName        s             10
004700150825
004800150824     d  WebCode      e ds                  extname(webcode)
004900180828
005000180828
005100180828       dcl-s pTrust Char(3);
005200180828       dcl-s pSub#  Char(3);
005300180828       dcl-s pAcct  Char(4);
005400180828       dcl-s pStart Char(8);
005500180828       dcl-s pEnd   Char(8);
005600180828
005700180828       dcl-s SqlStmt Char(1000);
005800180828       dcl-s @DedAmt Zoned(10:2);
005900180828       dcl-s sav_SqlCod like(SqlCod);
006000180830
006100180830       dcl-s CharSSN Char(9);
006200180828
006300180830
006400180828
006500180828
006600150824      *-------------------------
006700180828      *
006800180828      * Procedure(s)
006900180828      *
007000150824      *-------------------------
007100150824     D/COPY rpgspbeta/QMODSRC,#WebCodPR
007200150824
007300150824
007400150714    ? *-------------------------------------------------------------------------
007500150714      *?Mainline Program
007600150714    ? *-------------------------------------------------------------------------
007700150825     C     *entry        plist
007800150825     C                   parm                    RptName
007900150825
008000180828
008100180828       pTrust = '3';
008200180828       pSub#  = '1';
008300180828       pAcct = '1145';
008400180828       pStart = '20180807';
008500180828       pEnd  = '20180822';
008600180828
008700150825
008800180828       //?Run the SQL Commamnd and Loop through the results
008900180828       exsr $OpenC1;
009000180828       Dou SqlCod <> *Zero;
009100150302
009200180830          Exec Sql
009300180830             Fetch Next From C1 Into :@data ;
009400150302
009500180828          if SqlCod <> *Zero;
009600180830             Leave;
009700180828          endif;
009800150319
009900180828          //?Populate the Database.
010000180828          ReptDt = %Dec(%Date);
010100150824
010200180830       //   PayCust = sqPayCust;
010300180830       //   prTrst = sqTrust  ;
010400180830       //   prSub# = sqSub#   ;
010500180830       //   prAcct = sqAccount;
010600180828          prAcctName = sqAccName;
010700180830
010800180830          CharSSN = %Editc(sqMember : 'X') ;
010900180830          prMember = 'XXX-XX-' + %Subst( CharSSN : 6 : 4);
011000180830
011100180830         // prDepSeq = sqDepSeq ;
011200180828          prSessId = sqSessId ;
011300180828          WebCode = #WebCod(sqGrpv : sqFldv);
011400180828          prFldVal = wcDesc;
011500150824
011600180828          prBefore = sqBefore ;
011700180828          prAfter = sqAfter;
011800180828          prCnff = sqCnfF;
011900180828          prCnfu = sqCnfU;
012000180828          prCnfd = sqCnfD;
012100180828          prSigf = sqSigF;
012200180828          prSigu = sqSigU;
012300180828          prSigd = sqSigD;
012400150824
012500180830
012600180830
012700180830          if sqDepSeq = 0;
012800180830             prMbrName = '';
012900180830             prDepName = '';
013000180830
013100180830             chain sqMember Member;
013200180830             if %Found( Member );
013300180830                prMbrName = %Trim(mlName) +' , ' + %Trim( mfname );
013400180830             EndIf;
013500180830
013600180830
013700180830          else;
013800180830
013900180830             chain ( sqMember : sqDepSeq ) Depndc ;
014000180830             if %Found( Depndc );
014100180830                prDepName = %Trim(dlName) +' , ' + %Trim( dfname );
014200180830             EndIf;
014300180830
014400180830
014500180830          EndIf;
014600180830
014700180830
014800180830
014900180830          if wcDesc = '**PROGRAMMER ONLY**'
015000180830             or wcDesc = '*NOT FOUND*';
015100180830             iter;
015200180830          EndIf;
015300180830
015400180830
015500180830
015600180828          Write PayRept_r;
015700180828
015800180828
015900180828          if wcDesc = 'GBS Plan';
016000180828
016100180828             sav_SqlCod = SqlCod;
016200180828
016300180830             Exec Sql
016400180830                Select Pqdamt
016500180830                   Into :@dedamt
016600180830                   From Webpayarc
016700180830                   Where Pqssid = :Sqsessid
016800180830                         And Pqpln = :Sqafter
016900180830                   Fetch First 1 Rows Only ;
017000180828
017100180828             if @DedAmt > 0;
017200180828                Prfldval = 'Deduction Amount';
017300180828                prBefore = '';
017400180828                prAfter = %Char(@DedAmt);
017500180828                Write PayRept_r;
017600180828
017700180828             EndIf;
017800180828
017900180828             sqlCod = Sav_SqlCod;
018000180828
018100180828
018200180828
018300180828
018400180828          EndIf;
018500180828
018600180828       enddo;
018700150824
018800180828       Exec Sql  Close C1;
018900180828       Exsr Report_Name;
019000150302
019100180828       *inlr = *on;
019200180828       // ----------------------------------------------------------------
019300150309
019400150302       begsr $OpenC1;
019500150302
019600180828          SqlStmt =
019700180830             'Select Acnam1, Oessno, '   +
019800180828             '       Oedseq, Oessid, Oegrpv, Oefldv, Oebefore, Oeafter,' +
019900180828             '       Oecnff, Oecnfu, Oecnfd,             ' +                // Confirmation
020000180830             '      Oesigf, Oesigu, Oesigd               ' +                // Signature
020100180828             '   From Webtran                            ' +
020200180828             '   Join Accmsp On Amtrst = Oetrst          ' +
020300180828             '              And Amsub# = Oesub#          ' +
020400180828             '              And Amacct = Oeacct          ' +
020500180828             '   Join "F.ACCMST" On Actrst = Oetrst      ' +
020600180828             '                  And Acsub# = Oesub#      ' +
020700180828             '                  And Acacct = Oeacct      ' +
020800180828             '   Where Oetrst = ' + pTrust +
020900180828             '     and oeSub# = ' + pSub#  +
021000180828             '     and oeAcct = ' + pAcct  +
021100180830             '     and  oecnfd between ' + pStart + ' and ' + pEnd ;
021200180828
021300180828
021400180828
021500180828          Exec Sql
021600180828             Declare C1 Cursor For Sqlstmt;
021700180828          Exec Sql
021800180828             Prepare Sqlstmt From :Sqlstmt;
021900180828          Exec Sql
022000180828             Open C1;
022100180828
022200180828
022300150302       endsr;
022400180828       // ----------------------------------------------------------------
022500150825
022600150825       begsr Report_Name;
022700150828
022800150828          //----------------------------------------------------------------
022900150828          // This will calculate the Report Name.  (Month-YYYY)
023000150828          // Thus allowing us to save the Spread sheets by periods.
023100150828          //----------------------------------------------------------------
023200150825          RptMonth = %Subdt(%Date - %Days(1): *M);
023300150825          RptYear = %Subdt(%Date - %Days(1) : *Y);
023400150825
023500150825          Select;
023600180828          When RptMonth = 1;
023700150825             RptName = 'JAN-' + %Char(RptYear);
023800180828          When RptMonth = 2;
023900150825             RptName = 'FEB-' + %Char(RptYear);
024000180828          When RptMonth = 3;
024100150825             RptName = 'MARCH-' + %Char(RptYear);
024200180828          When RptMonth = 4;
024300150825             RptName = 'APRIL-' + %Char(RptYear);
024400180828          When RptMonth = 5;
024500150825             RptName = 'MAY-' + %Char(RptYear);
024600180828          When RptMonth = 6;
024700150825             RptName = 'JUNE-' + %Char(RptYear);
024800180828          When RptMonth = 7;
024900150825             RptName = 'JULY-' + %Char(RptYear);
025000180828          When RptMonth = 8;
025100150825             RptName = 'AUG-' + %Char(RptYear);
025200180828          When RptMonth = 9;
025300150825             RptName = 'SEPT-' + %Char(RptYear);
025400180828          When RptMonth = 10;
025500150825             RptName = 'OCT-' + %Char(RptYear);
025600180828          When RptMonth = 11;
025700150825             RptName = 'NOV-' + %Char(RptYear);
025800180828          When RptMonth = 12;
025900150825             RptName = 'DEC-' + %Char(RptYear);
026000150825          EndSl;
026100150825
026200150825       endsr;
