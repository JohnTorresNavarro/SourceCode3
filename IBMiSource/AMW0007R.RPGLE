000100191203       Ctl-opt option(*noDebugIo)   DftActGrp(*no) ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400220411      *
000500230331      *  Description: Make First Received OE File
000600211216      *  Programmer.: Jon Allen
000700230331      *  Date.......: 03/31/2023
000800191115      *
000900230331      *  Create the Last Run OE record
001000191203      *
001100191115      *-------------------------------------------------------------------------
001200230403       dcl-f amw0006lf usage( *Input ) keyed;
001300230403       dcl-f amw0007p usage( *Input: *Delete: *Output ) keyed;
001400230403       dcl-f amw0071p usage( *Input: *Delete: *Output ) keyed;
001500191115
001600191115      *-------------------------------------------------------------------------
001700191115      *
001800191115      * *Entry Procedure
001900191115      *
002000191115      *-------------------------------------------------------------------------
002100191115       Dcl-pr Main ExtPgm;
002200230331         *N  Char(10);
002300191115         *N  Char(150);
002400220414         *N  Char(150);
002500221026         *N  Char(1);
002600191115       End-Pr;
002700191115
002800191115       dcl-pi Main;
002900230331         pTSA      Char(10);
003000191203         pToFolder Char(150);
003100221026         pFileName Char(150);
003200221026         pRtn      Char(1);
003300191115       End-Pi;
003400191115
003500220412       dcl-s wdate Zoned(8);
003600230403       dcl-s wtime Zoned(6);
003700230403       dcl-s wcount Zoned(3);
003800230331
003900230331       dcl-ds pgmd
004000230331         ExtName('IOPGMD') PSDS;
004100230331         @pgmq *proc;
004200230331       end-ds;
004300191115
004400191115      *-------------------------------------------------------------------------
004500191115      *
004600191115      * Mainline Program
004700191115      *
004800191115      *-------------------------------------------------------------------------
004900220412
005000220412       wDATE  = %Dec(%Date);
005100220412       wTIME  = %Dec(%Time);
005200220412
005300230331       Clear R_AMW0007R;
005400221026       pRtn = ' ';
005500211216
005600230331       A7TRUST = %dec(%subst(pTSA:1:3):3:0);
005700230331       A7SUBNO = %dec(%subst(pTSA:4:3):3:0);
005800230331       A7ACCTN = %dec(%subst(pTSA:7:4):4:0);
005900221024
006000230403       wcount = 0;
006100230331       chain (A7TRUST:A7SUBNO:A7ACCTN) AMW0007P;
006200230331       if  %found(AMW0007P);
006300230403       wcount = A7MAKE;
006400230403       chain (A7TRUST:A7SUBNO:A7ACCTN) AMW0006LF;
006500230403       if  %found(AMW0006LF);
006600230403       A7OPENED = A6OPENED;
006700230403       A7CLOSED = A6CLOSED;
006800230403         write   R_AMW0071R;
006900230403       endif;
007000230331         Delete   R_AMW0007R;
007100230331       endif;
007200211216
007300230331       A7TRUST = %dec(%subst(pTSA:1:3):3:0);
007400230331       A7SUBNO = %dec(%subst(pTSA:4:3):3:0);
007500230331       A7ACCTN = %dec(%subst(pTSA:7:4):4:0);
007600230403       A7MAKE = wcount + 1;
007700230331
007800221216       pToFolder = %scanrpl('/Archive/':'':pToFolder);
007900221024
008000230331       A7FOLDPATH = %Trim( ptoFolder );
008100211216
008200230331       A7FILENAME = %Trim(pFileName);
008300211216
008400230331       A7ADDUSER  = %trim(WQUSRN);
008500230331       A7ADDDATE  = wDate;
008600230331       A7ADDTIME  = wTime;
008700211216
008800230331       Write R_AMW0007R;
008900221026       pRtn = 'A';
009000220412
009100191115       *inlr = *on;
