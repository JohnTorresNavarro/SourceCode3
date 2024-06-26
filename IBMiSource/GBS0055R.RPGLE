000100180718       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200180718
000300180718      *-------------------------------------------------------------------------
000400180718      *
000500190508      *  Description: Retrieve  the files needed to compare
000600180718      *  Programmer.: Brian Rees
000700190508      *  Date.......: 05/08/2019
000800180723      *
000900180723      *
001000180718      *-------------------------------------------------------------------------
001100180718
001200180718      *-------------------------------------------------------------------------
001300180718      *
001400180718      * Declare Files
001500180718      *
001600180718      *-------------------------------------------------------------------------
001700190508       Dcl-f GBS0055d WorkStn
001800190508         Handler('PROFOUNDUI(HANDLER)');
001900180718
002000180718
002100180718
002200180718
002300180718
002400180718      *-------------------------------------------------------------------------
002500180718      *
002600180718      * Global Variables
002700180718      *
002800180718      *-------------------------------------------------------------------------
002900180718       dcl-ds uploadFile Qualified;
003000190508         numFiles Zoned(3);
003100190508         Directory Char(256);
003200190508         Files Char(256);
003300180718       End-Ds;
003400180718
003500190508
003600190508
003700190508      *-------------------------------------------------------------------------
003800190508      *
003900190508      * *Entry Procedure
004000190508      *
004100190508      *-------------------------------------------------------------------------
004200190508       Dcl-pr Main ExtPgm;
004300190508         pCont Char(1);
004400190508         pScreen Char(1);
004500190508       End-Pr;
004600190508
004700190508       dcl-pi Main;
004800190508         pCont Char(1);
004900190508         pScreen Char(1);
005000190508       End-Pi;
005100180719
005200190508
005300190508
005400180718      *-------------------------------------------------------------------------
005500180718      *
005600180718      * Mainline Program
005700180718      *
005800180718      *-------------------------------------------------------------------------
005900190508       if pScreen = '1';
006000190508         Show_Screen1();
006100190508       EndIf;
006200190508
006300190508
006400190508
006500190508       if pScreen = '2';
006600190508         Show_Screen2();
006700190508       EndIf;
006800190508
006900190508
007000190508
007100190508       *inlr = *on;
007200190508
007300190508
007400190508       // ----------------------------------------------------------------
007500190508       dcl-proc Show_Screen1;
007600190508
007700190508         pCont = '';
007800190508
007900190508         Dou btnExit = *on;
008000190508           Exfmt Screen1;
008100180718
008200190508           if btnExit = *on;
008300180724             leave;
008400190508           endif;
008500180718
008600190508
008700190508           if btnAccept = *on;
008800190508             pCont = 'Y';
008900190508             leave;
009000190508           EndIf;
009100180718
009200190508         enddo;
009300180718
009400190508       end-proc;
009500190508
009600190508
009700190508
009800190508       // ----------------------------------------------------------------
009900190508       dcl-proc Show_Screen2;
010000190508
010100190508         Dou btnExit = *on;
010200190508
010300190508           exfmt Screen2;
010400190508         enddo;
010500190508
010600190508         *inlr = *on;
010700190508
010800190508       end-proc;
