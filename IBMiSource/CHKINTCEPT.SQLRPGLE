000100171229       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no);
000200171229
000300171229      *-------------------------------------------------------------------------
000400171229      *
000500180115      *  Description: Search by Alternate ID
000600180115      *  Programmer.: Brian Rees
000700180115      *  Date.......: 01/15/2018
000800171229      *
000900171229      *-------------------------------------------------------------------------
001000171229
001100180115
001200171229      *-------------------------------------------------------------------------
001300171229      *
001400171229      * Declare Files
001500171229      *
001600171229      *-------------------------------------------------------------------------
001700190612       dcl-f intcpthstp keyed usage( *Input : *output );
001800170525
001900171229      *-------------------------------------------------------------------------
002000171229      *
002100171229      * Global Variables
002200171229      *
002300171229      *-------------------------------------------------------------------------
002400170525
002500190612       dcl-ds Sq_Data;
002600190612         sqAcct  char(10);
002700190612         sqinv   Zoned(10);
002800190612         sqbatch Zoned(3);
002900190612         sqseq   Zoned(4);
003000190612         sqamt   Zoned(8:2);
003100190612         sqchk#  Zoned(10);
003200190612         sqrcvdt Zoned(8);
003300190612         sqsource  Char(10);
003400190612         sqstat  Char(1);
003500190612       End-Ds;
003600190612
003700190612       dcl-ds Sq_Data2;
003800190612         bkAcct  char(10);
003900190612         bkinv   Zoned(10);
004000190612         bkbatch Zoned(3);
004100190612         bkseq   Zoned(4);
004200190612         bkamt   Zoned(8:2);
004300190612         bkchk#  Zoned(10);
004400190612         bkrcvdt Zoned(8);
004500190612         bksource  Char(10);
004600190612         bkstat  Char(1);
004700190612       End-Ds;
004800190612
004900190612       dcl-s sqlStmt Char(1000);
005000190612
005100190612       Dcl-s Msg Char(2000);
005200190612       dcl-s Subject Char(100);
005300190612       dcl-s toAddr Char(200);
005400190612       dcl-s ccAddr Char(200);
005500190612       dcl-c q '''';
005600190612
005700190612
005800190612      *--------------------------------------------
005900190612      *
006000190612      * Procedures
006100190612      *
006200190612      *--------------------------------------------
006300190612      /include *LIBL/QMODSRC,#COMMANDPR         // Command
006400190612
006500190612
006600190612      *-------------------------------------------------------------------------
006700190612      *
006800190612      * *Entry Procedure
006900190612      *
007000190612      *-------------------------------------------------------------------------
007100190612       Dcl-pr Main ExtPgm;
007200190612         *N  Char(10);
007300190612         *N  Char(1);
007400190612
007500190612       End-Pr;
007600190612
007700190612       dcl-pi Main;
007800190612         pFileName Char(10);
007900190613         pError Char(1) ;
008000190612       End-Pi;
008100161111
008200190612
008300190612
008400171229      *-------------------------------------------------------------------------
008500171229      *
008600171229      * Mainline Program
008700171229      *
008800171229      *-------------------------------------------------------------------------
008900190613       pError = '';
009000190613
009100190613
009200190612       SqlStmt =
009300190612         'Select * from payfiles/' + %Trim( pFileName );
009400190612
009500190612       Exec Sql
009600190612          Declare c1 Cursor For sqlstmt;
009700190612       Exec Sql
009800190612          Prepare sqlstmt From :sqlstmt;
009900190612       Exec Sql
010000190612          Open c1;
010100190612
010200190612       dou SqlCod <> *Zero;
010300190612         Exec Sql
010400190612            Fetch Next From c1 Into :sq_data;
010500190612
010600190612         if SqlCod <> *zero;
010700190612           leave;
010800190612         endif;
010900190612
011000190612
011100190612         chain ( sqacct : sqamt : sqchk# : sqrcvdt ) intcpthstp;
011200190612         if %Found( intCptHstp );
011300190612
011400190612           pError = 'Y';
011500190612
011600190612           Subject = 'Intercept file not processed!';
011700190612           Msg = 'Intercept process was not procssed since we' +
011800190612             ' found duplicate records in file: INTCPTHSTP' +
011900190612             '<p>Intercept File: ' + %Trim( pFileName ) +
012000190612             '<p>Found in : ' + %Trim( FileName ) +
012100190612             ' processed on: ' + %Char(%Date(dateproc:*iso):*Usa) +
012200190612             '<p>Check #: ' + %Char(sqChk#) +
012300190612             '<p>Amount: ' + %Char(sqAmt) +
012400190612             '<p>Account: ' + %Char(sqacct);
012500190612
012600190612
012700220518           toAddr = 'payrolledi@amwins.com';
012800190612           ccAddr = 'as400_operators@gbsio.net';
012900190612
013000190612           CmdString = 'MailTool toAddr(' + toAddr + ') ' +
013100220518             ' FromAddr(payrolledi@amwins.com) ' +
013200190612             ' ccAddr(' + ccAddr + ') ' +
013300190612             ' Subject(' + q + %Trim( Subject)  + q + ') ' +
013400190612             ' Message(' + q + %Trim( Msg ) + q + ')' +
013500190612             ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
013600190612
013700190612           #Command(CmdString:%len(%Trim(CmdString)));
013800190612
013900190612
014000190612           leave;
014100190612
014200190612         EndIf;
014300190612
014400190612
014500190612       enddo;
014600190612       Exec Sql
014700190612          Close c1;
014800190612
014900190612
015000190612
015100190612       if pError = '';
015200190612         // No Errors.. Reopen and write the records.
015300190612         // .. We didn't do this before because we wanted
015400190612         //    to make sure there wasn't any duplicates
015500190612
015600190612         Exec Sql
015700190612            Open c1;
015800190612
015900190612           FileName = pFilename;
016000190612         DateProc = %Dec(%Date);
016100190612
016200190612         dou SqlCod <> *Zero;
016300190612           Exec Sql
016400190612              Fetch Next From c1 Into :sq_data2;
016500190612
016600190612           if SqlCod <> *zero;
016700190612             leave;
016800190612           endif;
016900190612
017000190612           write r_Intercpt;
017100190612
017200190612         enddo;
017300190612         Exec Sql
017400190612            Close c1;
017500190612
017600190612
017700190612
017800190612       endif;
017900190612
018000190612
018100190612
018200190612
018300190612       *inlr = *On;
