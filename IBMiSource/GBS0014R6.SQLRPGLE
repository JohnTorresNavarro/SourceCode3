000100190408
000200190408       Ctl-opt option(*noDebugIo)  DftActGrp(*no)
000300190408         BndDir('*libl/GBSBIND');
000400190408
000500190408      *-------------------------------------------------------------------------
000600190408      *
000700190408      *  Description: Daily Job Schedule - Check for File Transfer Jobs
000800190408      *  Programmer.: Brian Rees
000900190408      *  Date.......: 04/08/2019
001000190408      *
001100190408      *  Note.......: To Compile: Add JMS400L to your library list
001200190408      *
001300190408      *  This program will read through the job schedule.
001400190408      *  If there are any active file transfer jobs that have not yet
001500190408      *  processed, this will send a break message to the AA, Deb Clark and
001600190408      *  Brian.
001700190408      *
001800190408      *  This was created to let the AA's know when a file has not come in.
001900190408      *
002000190408      *
002100190408      *-------------------------------------------------------------------------
002200190408
002300190408      *-------------------------------------------------------------------------
002400190408      *
002500190408      * Declare Files
002600190408      *
002700190408      *-------------------------------------------------------------------------
002800190408       dcl-f jmshstlf keyed;
002900190408       dcl-f jmsnotp  keyed usage(*output : *input) ;
003000190408
003100190408
003200190408
003300190408      *-------------------------------------------------------------------------
003400190408      *
003500190408      * Global Variables
003600190408      *
003700190408      *-------------------------------------------------------------------------
003800190408
003900190408       dcl-ds pgmd
004000190408         ExtName('IOPGMD') PSDS;
004100190408         @pgmq *proc;
004200190408       end-ds;
004300190408
004400190408       dcl-s wTime Time;
004500190408       dcl-s wHour time;
004600190408       dcl-s t_String Char(10);
004700190408       dcl-s wDate date;
004800190408       dcl-s wGroup Char(20);
004900190408       dcl-s wDept  Char(5);
005000190408       dcl-s wTrst Zoned(3);
005100190408       dcl-s wSub Zoned(3);
005200190408       dcl-s wAcct Zoned(4);
005300190408       dcl-s wUser Char(10);
005400190408       dcl-c q '''';
005500190619       dcl-s wEmail Char(30);
005600190619       Dcl-s Msg Char(2000);
005700190619       dcl-s Subject Char(100);
005800190619
005900190408
006000190408
006100190408      *--------------------------------------------
006200190408      *
006300190408      * Procedures
006400190408      *
006500190408      *--------------------------------------------
006600190408       /include *LIBL/QMODSRC,#COMMANDPR         // Command
006700190408
006800190408
006900190408      *-------------------------------------------------------------------------
007000190408      *
007100190408      * Mainline Program
007200190408      *
007300190408      *-------------------------------------------------------------------------
007400190408       wDate = %Date;
007500190408       wTime = %Time;
007600190408       Setll wDate jmshstlf;
007700190408
007800190408       Dou %Eof(jmshstlf);
007900190619         reade wDate jmshstlf;
008000190619         if %eof(jmshstlf);
008100190619           leave;
008200190408         endif;
008300190408
008400190408
008500190619         if jhcomp > '';
008600190619           iter;
008700190408         EndIf;
008800190408
008900190619         if %Subst( jhjobn : 1 : 3 )  = 'FT_';
009000190408
009100190408
009200190619           Exec Sql
009300190619              Select ftgroup, ftdept
009400190619                 Into :wgroup, :wdept
009500190619                 From gbs0030p
009600190619                 Where jobschname = :jhjobn;
009700190408
009800190619           if wDept <> 'FI';
009900190408             iter;
010000190619           EndIf;
010100190408
010200190408
010300190408           // Get the AA Name.
010400190619           wTrst = %Dec( %Subst(wGroup : 1 : 3) : 3: 0 );
010500190408           wSub  = %Dec( %Subst(wGroup : 4 : 3) : 3: 0 );
010600190408           wAcct = %Dec( %Subst(wGroup : 7 : 4) : 4: 0 );
010700190408
010800201205           wEmail = '';
010900190619           Exec Sql
011000190619              Select Upper(eausrprf), Lower(eaemail)
011100190619                 Into :wuser, :wemail
011200190619                 From aacode
011300190619                 Join qgpl.emailaddr On Lower(aemla) = Lower(eaemail)
011400190619                 Where acode = (Select aacode
011500190619                                   From QS36F."F.ACCMST"
011600190619                                   Where actrst = :wtrst
011700190619                                         And acsub# = :wsub
011800190619                                         And acacct = :wacct);
011900190408
012000190408
012100190619           t_string = %subst(%editc(jhhour : 'X')
012200190408             :1:2) + ':' + %subst(%editc(jhhour : 'X')
012300190408             :3:2) + ':00' ;
012400190408           wHour = %Time( t_String : *hms) ;
012500190408
012600190408
012700190408
012800190408
012900190408           if %Diff(  wTime : wHour  : *Hours ) > 1;
013000190408
013100190619             // Did we already send an email to the AA?
013200190408             chain ( jhjobn : jhDate : wUser ) JmsNotp;
013300190408             if not %Found( jmsnotp );
013400190619               ntJobn = jhjobn;
013500190408               ntdate = jhdate;
013600190408               ntuser = wuser;
013700190408               nttime = %Time;
013800190408
013900190408               Write jmsnot_r;
014000190408
014100190408
014200190619               Subject = 'File Transfer Job: ' + %Trim( jhjobn );
014300190619               Msg = 'File Transfer Job: ' + %Trim( jhjobn ) +
014400190619                 ' has not run yet. ' +
014500190619                 'The IT Department has been notified. We will contact you ' +
014600190619                 'if further action is required.' ;
014700190619
014800190619
014900190619               CmdString = 'Mailtool toAddr(' + wEmail + ') ' +
015000190619                 ' ccAddr(dclark@gbsio.net) ' +
015100190619                 ' Subject(' + q + %Trim( Subject)  + q + ') ' +
015200190619                 ' Message(' + q + %Trim( Msg ) + q + ')' +
015300190628                 ' FromAddr(as400_operators@gbsio.net)' +
015400190619                 ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
015500190619
015600201205
015700201205               if wEmail > '';
015800190619               #Command(CmdString:%len(%Trim(CmdString)));
015900201205               endif;
016000190408
016100190408
016200190408
016300190408
016400190619             EndIf;
016500190408
016600190619
016700190619             // Send Message to Brian
016800190619             Subject = 'File Transfer Job: ' + %Trim( jhjobn );
016900190619             Msg = 'File Transfer Job: ' + %Trim( jhjobn ) +
017000190619               ' has not run yet. ' +
017100190619               '<p>Please look into this ASAP ';
017200190619
017300190619
017400220518             CmdString = 'Mailtool toAddr(payrolledi@amwins.com) ' +
017500190619               ' Subject(' + q + %Trim( Subject)  + q + ') ' +
017600190619               ' Message(' + q + %Trim( Msg ) + q + ')' +
017700190628               ' FromAddr(as400_operators@gbsio.net)' +
017800190619               ' Imp(*HIGH)' +
017900190619               ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
018000190619
018100190619             #Command(CmdString:%len(%Trim(CmdString)));
018200190619
018300190619
018400190619             // Send Message to AS400_Operators
018500190619             CmdString = 'Mailtool toAddr(AS400_Operators@gbsio.net) ' +
018600190619               ' Subject(' + q + %Trim( Subject)  + q + ') ' +
018700190619               ' Message(' + q + %Trim( Msg ) + q + ')' +
018800190628               ' FromAddr(as400_operators@gbsio.net)' +
018900190619               ' Imp(*HIGH)' +
019000190619               ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
019100190619
019200190619             #Command(CmdString:%len(%Trim(CmdString)));
019300190619
019400190408
019500190408
019600190408
019700190619           EndIf;
019800190619         EndIf;
019900190408
020000190408
020100190619       Enddo;
020200190408
020300190408
020400161109
020500161109       *inlr = *on;
020600161109
