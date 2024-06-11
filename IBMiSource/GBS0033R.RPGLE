000100180326
000200171229       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000300171229          ActGrp(*New);
000400171229
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700180327      *  Description:  Cost Center Report
000800171229      *  Programmer.:  Brian Rees
000900180327      *  Date.......:  03/27/2018
001000171229      *
001100180327      *  The AA's had an X4 that would generate a list of Cost Centers
001200180327      *  This program replaces the X4.
001300171229      *-------------------------------------------------------------------------
001400180227
001500171229
001600171229      *-------------------------------------------------------------------------
001700171229      *
001800171229      * Declare Files
001900171229      *
002000171229      *-------------------------------------------------------------------------
002100180326       Dcl-f Gbs0033d WorkStn
002200180326          Handler('PROFOUNDUI(HANDLER)');
002300171229
002400220113       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
002500180326
002600180326
002700171229      *-------------------------------------------------------------------------
002800171229      *
002900171229      * Global Variables
003000171229      *
003100171229      *-------------------------------------------------------------------------
003200180326       dcl-s wTrst    Zoned(3);
003300180326       dcl-s wSub#    Zoned(3);
003400180326       dcl-s wAcct    Zoned(4);
003500180326       dcl-s wActNbr like( s1ActNbr );
003600180326       dcl-c digits  '0123456789';
003700180327       dcl-c q       '''';
003800180327       dcl-s sqlStmt  char(1000);
003900180327       dcl-s AcctName Char(40);
004000180326
004100161111      *--------------------------------------------
004200171229      *
004300171229      * Procedures
004400171229      *
004500161111      *--------------------------------------------
004600180222
004700180222       /include GBSPGM/QMODSRC,#GettokPR
004800180222       /include GBSPGM/QMODSRC,#zFillpr
004900180327       /include GBSPGM/QMODSRC,#commandpr
005000180222
005100171108
005200171229
005300171229      *-------------------------------------------------------------------------
005400171229      *
005500171229      * Mainline Program
005600171229      *
005700171229      *-------------------------------------------------------------------------
005800170605
005900180327       SqlStmt = 'Select Distinct mbtrst, mbsub#, mbacct, acNam1, ccflg, +
006000180327          ldescr, Enroll, atrmdt +
006100180327          From [F.MEMBER] +
006200180327          Join [F.ACCMST] on mbtrst = actrst and mbsub# = acSub# +
006300180327          and mbacct = acacct +
006400180327          Join [F.CODESL1] on ccflg = key3 +
006500180327          Where ccflg > ""'  ;
006600180327
006700180327
006800180327
006900180327
007000180326       Dou btnBack = *on;
007100170605
007200180326
007300180326          exfmt Screen1;
007400180327          errAccount = *off;
007500180326
007600180102          // Check to see if the Account Number has changed.
007700180327          if  RptType = 'SINGLE';
007800180222
007900180222             split();
008000171130             wActNbr = s1ActNbr;
008100171130
008200171128             s1ActNbr = %ScanRpl( '-' : '' : s1ActNbr );
008300171130             s1ActNbr = %ScanRpl( ' ' : '' : s1ActNbr );
008400171130
008500180327             if %Len( %Trim( s1actnbr )) <> 10;
008600180327                errAccount = *on;
008700180327                iter;
008800180327             EndIf;
008900180327
009000171130             if %check( digits : %Trim( s1ActNbr )) = 0;
009100171130                wTrst = %Dec( %Subst( s1ActNbr : 1 : 3) : 3 : 0 );
009200171130                wSub# = %Dec( %Subst( s1ActNbr : 4 : 3) : 3 : 0 );
009300171130                wAcct = %Dec( %Subst( s1ActNbr : 7 : 4) : 4 : 0 );
009400171130
009500171130                chain ( wTrst : wSub# : wAcct ) AccMst;
009600171130                if not %Found( AccMst );
009700171130                   Clear Screen1;
009800171130                   ErrAccount = *on;
009900171130                   s1ActNBr = wActNbr;
010000180327                else;
010100180327                   AcctName = acNam1;
010200171130                endif;
010300171130
010400171130             else;
010500171130
010600171130                errAccount = *on;
010700171130             endif;
010800171130
010900171128          endif;
011000171128
011100180326
011200180326
011300180326
011400171130          if errAccount = *on;
011500180326             iter;
011600171130          Else;
011700171130
011800180326
011900180326             //-------------------------------------------
012000180326             //
012100180326             // Process the Accept Button
012200180326             //
012300180326             //-------------------------------------------
012400180326
012500180326             if btnAccept = *on;
012600180326
012700180326                // Process Single Account
012800180326                if RptType = 'SINGLE';
012900180326
013000180327                   SqlStmt = %Trim( SqlStmt ) +
013100180327                      ' and mbtrst = ' + %Char( wTrst ) +
013200180327                      ' and mbsub# = ' + %Char( wSub# ) +
013300180327                      ' and mbacct = ' + %Char( wAcct );
013400180327
013500180327                   CmdString = 'Sql2Eml +
013600180327                      SqlStmt(' + q + %Trim(SqlStmt ) + q + ') ' +
013700180327                      ' toxls(Cost_Centers.xls)  Subj(' + q +
013800180327                      'Cost Centers Report for: ' +  %Trim(AcctName) + q + ')';
013900180327
014000180327                   #Command( CmdString : %len(%Trim(CmdString)));
014100180327
014200180327                   exfmt Info;
014300180326                EndIf;
014400180326
014500180326
014600180326                // Process All of the Accounts
014700180326                if RptType = 'ALL';
014800180326
014900180327                   CmdString = 'Sql2Eml +
015000180327                      SqlStmt(' + q + %Trim(SqlStmt ) + q + ') ' +
015100180327                      ' toxls(Cost_Centers.xls)  Subj(' + q +
015200180327                      'Cost Centers Report' + q + ')';
015300180327
015400180327                   #Command( CmdString : %len(%Trim(CmdString)));
015500180327
015600180327                   exfmt Info;
015700180326                EndIf;
015800180326
015900180327
016000180327                btnBack = *off;
016100180327                iter;
016200180327
016300180327
016400180326             EndIf;
016500180227
016600171130          endif;
016700171130
016800171103
016900170606
017000170525       enddo;
017100170529
017200170525       *inlr = *on;
017300170525
017400171106
017500170607
017600180222      *-------------------------------------------------------------------------
017700180222       Dcl-Proc Split;
017800180222
017900180326          dcl-s x int(10);
018000180326          dcl-s tokens varchar(100) dim(50);
018100180326          dcl-s Trst Char(3);
018200180326          dcl-s Sub  Char(3);
018300180326          dcl-s Acct Char(4);
018400180222
018500180326          tokens(*) = #Gettok( s1ActNbr : '-' : x );
018600180222
018700180222
018800180326          // we should have 3 array elements filled  in.
018900180326          // the next blank space should be #4.
019000180326          x = %lookup( '' : tokens ) ;
019100180326          if x = 4;
019200180326             Trst = #zFill( 3 : %Trim( Tokens(1) ));
019300180326             Sub  = #zFill( 3 : %Trim( Tokens(2) ));
019400180326             Acct = #zFill( 4 : %Trim( Tokens(3) ));
019500180222
019600180326             s1ActNbr = trst + '-' + Sub + '-' + Acct;
019700180222
019800180326          EndIf;
019900180222
020000180222
020100180222       End-Proc;
020200180222
