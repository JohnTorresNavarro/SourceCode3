000100171229
000200180912       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND' )
000300180912          DftActGrp(*no)      ;
000400171229
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700180912      *  Description: Generate the Multi-tabbed excel spreadsheet using
000800180912      *    Profound Logic's universal display files
000900180912      *
001000180912      *  Programmer.: Brian Rees
001100180912      *  Date.......: 09/12/2018
001200171229      *
001300171229      *-------------------------------------------------------------------------
001400180227
001500180227      *-------------------------------------------------------------------------
001600180227      *
001700180912      *  Change Log:
001800180227      *
001900180227      *-------------------------------------------------------------------------
002000171229
002100171229      *-------------------------------------------------------------------------
002200171229      *
002300171229      * Declare Files
002400171229      *
002500171229      *-------------------------------------------------------------------------
002600180912       Dcl-f GBS0042E WorkStn
002700180912          Handler('UNIVERSAL(HANDLER)');
002800180912
002900180912       dcl-f GBS0042P1 keyed ;
003000180912       dcl-f GBS0042P2 keyed ;
003100180912       dcl-f PAYCHG1P  keyed ;
003200180912
003300180912       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
003400171229
003500171229      *-------------------------------------------------------------------------
003600171229      *
003700171229      * Global Variables
003800171229      *
003900171229      *-------------------------------------------------------------------------
004000180227
004100170605
004200180912
004300180912      *-------------------------------------------------------------------------
004400180912      *
004500180912      * *Entry Procedure
004600180912      *
004700180912      *-------------------------------------------------------------------------
004800180912       Dcl-pr Main ExtPgm;
004900180912          *N  Char(3);
005000180912          *N  Char(3);
005100180912          *N  Char(4);
005200180912          *N  Char(8);
005300180912          *N  Char(8);
005400180912          *N  Char(50);
005500180912
005600180912       End-Pr;
005700180912
005800180912       dcl-pi Main;
005900180912          pTrst  Char(3);
006000180912          pSub#  Char(3);
006100180912          pAcct  Char(4);
006200180912          pFromDt  Char(8);
006300180912          PToDate  Char(8);
006400180912          pFileName Char(50);
006500180912       End-Pi;
006600180912
006700180912
006800161111      *--------------------------------------------
006900171229      *
007000171229      * Procedures
007100171229      *
007200161111      *--------------------------------------------
007300180222
007400180912      * ----------------------------------------------------------
007500180912      *  The tmpnam() call is an IBM-provided API to calculate a
007600180912      *  unique temporary file name. So this will just generate a name
007700180912      *  that's not in use. The tmpnam() will return a path name
007800180912      *  beginning with /tmp/Qxxxx -- but since PUI wants the directory
007900180912      *  name in a separate variable, we use %SUBST to remove the
008000180912      *  first 5 characters to remove "/tmp/" from the start.
008100180912      * ----------------------------------------------------------
008200180912     D tmpnam          PR              *   extproc('_C_IFS_tmpnam')
008300180912     D   string                      39A   options(*omit)
008400180912
008500180912
008600180404      *-------------------------------------------------------------------------
008700180404      *
008800180913      * Mainline Program
008900180404      *
009000180404      *-------------------------------------------------------------------------
009100171106
009200180912       oFileName    = %str(tmpnam(*omit)) ;
009300180912       oFileName    = %Trim(oFileName) + '.xml';
009400180912       pFileName =  oFileName;
009500180912
009600180912       hFromDate =  %Char(%Date( %Dec(pFromDt : 8 : 0 ) :*iso):*Usa);
009700180912       hToDate =  %Char(%Date( %Dec(pToDate : 8 : 0 ) :*iso):*Usa);
009800180912
009900180912
010000180912       chain ( %Dec(pTrst : 3 : 0 )  :
010100180912          %Dec(pSub# : 3 : 0 )  :
010200180912          %Dec(pAcct : 4 : 0 ))  AccMst;
010300180912
010400180912       if %Found( AccMst ) ;
010500180912          hAccName =  acNam1;
010600180912       EndIf;
010700180912
010800180912
010900180912
011000180912
011100180912       //----------------------------------------------------
011200180912       //
011300180912       //  Demographics Data
011400180912       //
011500180912       //----------------------------------------------------
011600180912       Write Header;
011700180912
011800180912       Setll *loval GBS0042P1;
011900180912       Dou %Eof(GBS0042P1);
012000180912          read GBS0042P1;
012100180912          if %eof(GBS0042P1);
012200180912             leave;
012300180912          endif;
012400180912
012500180912          write DemoData;
012600180912       Enddo;
012700180912
012800180912
012900180912
013000180912       //----------------------------------------------------
013100180912       //
013200180912       //  Employee Changes
013300180912       //
013400180912       //----------------------------------------------------
013500180912       Write Header2;
013600180912
013700180912       Setll *loval GBS0042P2;
013800180912
013900180912       Dou %Eof(GBS0042P2);
014000180912          read GBS0042P2;
014100180912          if %eof(GBS0042P2);
014200180912             leave;
014300180912          endif;
014400180912
014500180912          write EmpData;
014600180912
014700180912       Enddo;
014800180912
014900180912
015000180912       //----------------------------------------------------
015100180912       //
015200180912       //  Benefit Summary
015300180912       //
015400180912       //----------------------------------------------------
015500180912       Write Header3;
015600180912
015700180912       Setll *loval PAYCHG1P;
015800180912
015900180912       Dou %Eof(PAYCHG1P);
016000180912          read PAYCHG1P;
016100180912          if %eof(PAYCHG1P);
016200180912             leave;
016300180912          endif;
016400180912
016500180913          r1Cod = %scanrpl( '&' : '&amp;' :r1Cod );
016600180913          r1Pln = %scanrpl( '&' : '&amp;' :r1Pln );
016700180913          r1ssn = 'XXX-XX-' + %Subst( r1ssn : 8 : 4 ) ;
016800180913
016900180912          write BeneData;
017000180912
017100180912       Enddo;
017200180912
017300180912
017400180912
017500180912
017600180912
017700180912       //----------------------------------------------------
017800180912       //
017900180912       //  Close File
018000180912       //
018100180912       //----------------------------------------------------
018200180912
018300180912       write footer;
018400180912
018500180912
018600180913       *inlr = *on;
018700180912
018800180613
