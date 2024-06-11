000100191203       Ctl-opt option(*noDebugIo)   DftActGrp(*no) ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400220411      *
000500211216      *  Description: Last Run Autoload OE file write
000600211216      *  Programmer.: Jon Allen
000700211216      *  Date.......: 12/16/2021
000800191115      *
000900211216      *  Create the Last Run OE record
001000191203      *
001100191115      *-------------------------------------------------------------------------
001200220412       dcl-f amw0001p usage( *Output );
001300220412       dcl-f amw0002p usage( *Input: *Delete: *Output ) keyed;
001400191115
001500191115      *-------------------------------------------------------------------------
001600191115      *
001700191115      * *Entry Procedure
001800191115      *
001900191115      *-------------------------------------------------------------------------
002000191115       Dcl-pr Main ExtPgm;
002100211216         *N  Char(20);
002200191115         *N  Char(150);
002300220414         *N  Char(150);
002400221102         *N  Char(15);
002500220414         *N  Char(1);
002600191115       End-Pr;
002700191115
002800191115       dcl-pi Main;
002900211216         pTSA      Char(20);
003000191203         pToFolder Char(150);
003100221102         pFileName Char(150);
003200221102         pFileSize Char(15);
003300220414         pHasData  Char(1);
003400191115       End-Pi;
003500191115
003600220412       dcl-s wdate Zoned(8);
003700221102       dcl-s wtime Zoned(6);
003800221102       dcl-s wSize Zoned(15);
003900191115
004000191115      *-------------------------------------------------------------------------
004100191115      *
004200191115      * Mainline Program
004300191115      *
004400191115      *-------------------------------------------------------------------------
004500220412
004600220412       wDATE  = %Dec(%Date);
004700220412       wTIME  = %Dec(%Time);
004800220412
004900211216       Clear R_AMW0001R;
005000211216
005100211216       A1TRUST = %dec(%subst(pTSA:1:3):3:0);
005200211216       A1SUBNO = %dec(%subst(pTSA:4:3):3:0);
005300211216       A1ACCTN = %dec(%subst(pTSA:7:4):4:0);
005400211216
005500211216       A1FOLDPATH = %Trim( ptoFolder ) + '/Archive/';
005600211216
005700211216       A1FILENAME = %Trim(pFileName);
005800211216
005900220412       A1RCVDATE  = wDate;
006000220414       A1RCVTIME  = wTime;
006100220414       A1HASDATA  = pHasData;
006200221102
006300221102       wSize = %dec(pFileSize:15:0);
006400221102       A1FILSZ  = wSize;
006500211216
006600220412       Write R_AMW0001R;
006700220412
006800220412       chain (A1TRUST:A1SUBNO:A1ACCTN) AMW0002P;
006900220412       if  %found(AMW0002P);
007000220412       delete (A1TRUST:A1SUBNO:A1ACCTN) AMW0002P;
007100220412       endif;
007200220412
007300220412       Clear R_AMW0002R;
007400220412
007500220412       A1TRUST = %dec(%subst(pTSA:1:3):3:0);
007600220412       A1SUBNO = %dec(%subst(pTSA:4:3):3:0);
007700220412       A1ACCTN = %dec(%subst(pTSA:7:4):4:0);
007800220412
007900220412       A1FOLDPATH = %Trim( ptoFolder ) + '/Archive/';
008000220412
008100220412       A1FILENAME = %Trim(pFileName);
008200220412
008300220412       A1RCVDATE  = wDate;
008400220412       A1RCVTIME  = wTime;
008500221102       A1HASDATA  = pHasData;
008600221102
008700221102       wSize = %dec(pFileSize:15:0);
008800221102       A1FILSZ  = wSize;
008900220412
009000220412       Write R_AMW0002R;
009100191203
009200191115       *inlr = *on;
