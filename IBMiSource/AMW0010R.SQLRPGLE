000100220404     H option(*noDebugIo)  DftActGrp(*no)    bnddir('GBSBIND')
000200000000      *_________________________________________________________________________
000300000000      *
000400220418      *  Description:  Load TEST Library record
000500000000      *
000600000000      *  (c)Copyright 2022 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - April 04, 2022
000900000000      *_________________________________________________________________________
001000220404
001100220404      *-------------------------------------------------------------------------
001200220404      *
001300220404      * Declare Files
001400220404      *
001500220404      *-------------------------------------------------------------------------
001600220404
001700220404      *-------------------------------------------------------------------------
001800220404      *
001900220404      * Global Variables
002000220404      *
002100220404      *-------------------------------------------------------------------------
002200220404
002300220418       dcl-s  wsql  char(2000);
002400221111       dcl-s  wsql2 char(2000);
002500221111       dcl-s  wsql3 char(2000);
002600221114       dcl-s  wsql4 char(2000);
002700221114       dcl-s  wsql5 char(2000);
002800220418       dcl-s  quote char(1) inz('''');
002900220404       dcl-s  wlibF char(20);
003000220404       dcl-s  wlibT char(20);
003100221110       dcl-s  wfil  char(10) inz('GBS30HMBR');
003200221111       dcl-s  wfil2 char(10) inz('GBS30HMCOV');
003300221111       dcl-s  wfil3 char(10) inz('GBS30HDEP');
003400221114       dcl-s  wfil4 char(10) inz('GBS30HDCOV');
003500221114       dcl-s  wfil5 char(10) inz('EASEWAIVE');
003600220404
003700221114       dcl-s ptrs char(3);
003800221114       dcl-s psub char(3);
003900221114       dcl-s pacc char(4);
004000221114
004100220404       dcl-ds pgmd
004200220404         ExtName('IOPGMD') PSDS;
004300220404       end-ds;
004400220404
004500220404      *--------------------------------------------
004600220404      *
004700220404      * Procedures
004800220404      *
004900220404      *--------------------------------------------
005000220404
005100220404      *-----------------------------------------------------------------------
005200220404      *
005300220404      * *Entry Procedure
005400220404      *
005500220404      *-----------------------------------------------------------------------
005600220404       Dcl-pr Main ExtPgm;
005700220404         *N  Char(10);
005800220404         *N  Char(1);
005900220404       End-Pr;
006000220404
006100220404       dcl-pi Main;
006200221110         pTSA  Char(10);
006300220404         pRtn  Char(1);
006400220404       End-Pi;
006500220404
006600220404
006700220404      *-------------------------------------------------------------------------
006800220404      *
006900220404      * Mainline Program
007000220404      *
007100220404      *-------------------------------------------------------------------------
007200220404       Exec Sql
007300220407         Set Option Commit = *None, Naming = *Sys, Closqlcsr = *Endmod;
007400221114
007500221114       pTrs = %Subst(pTSA:1:3);
007600221114       pSub = %Subst(pTSA:4:3);
007700221114       pAcc = %Subst(pTSA:7:4);
007800220418
007900221110         wlibT = 'OE_EASE.' + %trim(wfil);
008000220405
008100221110         wsql = 'delete from ' + %trim(wlibT) +
008200221110         ' where HACCOUNT = ' + pTSA ;
008300220405
008400220405         Exec Sql Declare d1 Cursor For wsql;
008500220405         Exec Sql Prepare d1 From :wsql;
008600220405         exec sql execute d1 ;
008700221111
008800221111         wlibT = 'OE_EASE.' + %trim(wfil2);
008900221111
009000221111         wsql2 = 'delete from ' + %trim(wlibT) +
009100221111         ' where HACCOUNT = ' + pTSA ;
009200221111
009300221111         Exec Sql Declare d2 Cursor For wsql2;
009400221111         Exec Sql Prepare d2 From :wsql2;
009500221111         exec sql execute d2 ;
009600221111
009700221111         wlibT = 'OE_EASE.' + %trim(wfil3);
009800221111
009900221111         wsql3 = 'delete from ' + %trim(wlibT) +
010000221111         ' where HACCOUNT = ' + pTSA ;
010100221111
010200221111         Exec Sql Declare d3 Cursor For wsql3;
010300221111         Exec Sql Prepare d3 From :wsql3;
010400221111         exec sql execute d3 ;
010500221111
010600221111         wlibT = 'OE_EASE.' + %trim(wfil4);
010700221111
010800221111         wsql4 = 'delete from ' + %trim(wlibT) +
010900221111         ' where HACCOUNT = ' + pTSA ;
011000221111
011100221111         Exec Sql Declare d4 Cursor For wsql4;
011200221111         Exec Sql Prepare d4 From :wsql4;
011300221111         exec sql execute d4 ;
011400221114
011500221114         wlibT = 'OE_EASE.' + %trim(wfil5);
011600221114
011700221114         wsql5 = 'delete from ' + %trim(wlibT) +
011800221114         ' where W_TRST = ' + ptrs + ' and ' +
011900221114                'W_SUB# = ' + psub + ' and ' +
012000221114                'W_ACCT = ' + pacc;
012100221114
012200221114         Exec Sql Declare d5 Cursor For wsql5;
012300221114         Exec Sql Prepare d5 From :wsql5;
012400221114         exec sql execute d5 ;
012500220405
012600220405       *inlr = *on;
012700220404
