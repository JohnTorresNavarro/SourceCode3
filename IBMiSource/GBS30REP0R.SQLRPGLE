000100190411
000200190411       Ctl-opt option(*noDebugIo)   DftActGrp(*no) bnddir('GBSBIND');
000300190411
000400190411      *-------------------------------------------------------------------------
000500190411      *
000600221122      *  Description: Remove repository with TSA deleted
000700221027      *  Programmer.: Jon Allen
000800221122      *  Date.......: 11.22.2022
000900190411      *
001000190411      *-------------------------------------------------------------------------
001100211209      * Modifications
001200221018      *
001300211209      *
001400211209      *
001500211209      *-------------------------------------------------------------------------
001600190411
001700190411      *-------------------------------------------------------------------------
001800190411      *
001900190411      * Declare Files
002000190411      *
002100190411      *-------------------------------------------------------------------------
002200190411
002300221122       Dcl-f gbs0030l1 keyed usage( *input );
002400221031       Dcl-f gbs3mbrpp keyed usage( *input : *update );
002500221031       Dcl-f gbs3mcrpp keyed usage( *input : *update );
002600221031       Dcl-f gbs3dprpp keyed usage( *input : *update );
002700221031       Dcl-f gbs3dcrpp keyed usage( *input : *update );
002800190411
002900190411
003000190411      *-------------------------------------------------------------------------
003100190411      *
003200190411      * Global Variables
003300190411      *
003400190411      *-------------------------------------------------------------------------
003500190411
003600190411       dcl-ds pgmd
003700190411         ExtName('IOPGMD') PSDS;
003800190411         @pgmq *proc;
003900190411       end-ds;
004000190411
004100221122       dcl-s wkey   char(20);
004200221122       dcl-s wwtrst char(3);
004300221122       dcl-s wwsub# char(3);
004400221122       dcl-s wwacct char(4);
004500221027       dcl-s wdate Zoned(8);
004600221122       dcl-s  wsql1 char(2000);
004700221122       dcl-s  wsql2 char(2000);
004800221122       dcl-s  wsql3 char(2000);
004900221122       dcl-s  wsql4 char(2000);
005000221122       dcl-s  quote char(1) inz('"');
005100190411
005200190411      *-------------------------------------------------------------------------
005300190411      *
005400190411      * Procedures
005500190411      *
005600190411      *-------------------------------------------------------------------------
005700190411      *
005800190411      * *Entry Procedure
005900190411      *
006000190411      *-------------------------------------------------------------------------
006100190411       Dcl-pr Main ExtPgm;
006200221031         *N  Char(10);
006300190411       End-Pr;
006400190411
006500190411       dcl-pi Main;
006600221031         pKey Char(10);
006700190411       End-Pi;
006800190411
006900190411
007000190411      *-------------------------------------------------------------------------
007100190411      *
007200190411      * Mainline Program
007300190411      *
007400190411      *-------------------------------------------------------------------------
007500221122       Exec Sql
007600221122         Set Option Commit = *None, Naming = *Sys, Closqlcsr = *Endmod;
007700221122
007800221122       wkey = %trim(pkey);
007900221122       chain wkey gbs0030l1;
008000221122       if  %found(gbs0030l1);
008100221122
008200221122       if  FTACTIVE = 'Y' and FTRCDSTS = 'A' and FTPROC = ' ';
008300221122       *inlr = *on;
008400221122       return;
008500221122       endif;
008600190411
008700221122       wwTrst = %Subst(pKey:1:3);
008800221122       wwSub# = %Subst(pKey:4:3);
008900221122       wwAcct = %Subst(pKey:7:4);
009000190411
009100221031      * Member file
009200221122
009300221122           wsql1 = 'delete from GBS3MBRPP where ' +
009400221122                'L1_TRST = ' + wwTrst + ' and ' +
009500221122                'L1_SUB# = ' + wwSub# + ' and ' +
009600221122                'L1_ACCT = ' + wwacct;
009700221122
009800221122         Exec Sql Declare d1 Cursor For wsql1;
009900221122         Exec Sql Prepare d1 From :wsql1;
010000221122         exec sql execute d1 ;
010100221031
010200221031      * Member coverage file
010300221122
010400221122           wsql2 = 'delete from GBS3MCRPP where ' +
010500221122                'L2_TRST = ' + wwTrst + ' and ' +
010600221122                'L2_SUB# = ' + wwSub# + ' and ' +
010700221122                'L2_ACCT = ' + wwacct;
010800221122
010900221122         Exec Sql Declare d2 Cursor For wsql2;
011000221122         Exec Sql Prepare d2 From :wsql2;
011100221122         exec sql execute d2 ;
011200221031
011300221031      * Dependent file
011400221122
011500221122           wsql3 = 'delete from GBS3DPRPP where ' +
011600221122                'L3_TRST = ' + wwTrst + ' and ' +
011700221122                'L3_SUB# = ' + wwSub# + ' and ' +
011800221122                'L3_ACCT = ' + wwacct;
011900221122
012000221122         Exec Sql Declare d3 Cursor For wsql3;
012100221122         Exec Sql Prepare d3 From :wsql3;
012200221122         exec sql execute d3 ;
012300221031
012400221031      * Dependent Coverge file
012500221122
012600221122           wsql4 = 'delete from GBS3DCRPP where ' +
012700221122                'L4_TRST = ' + wwTrst + ' and ' +
012800221122                'L4_SUB# = ' + wwSub# + ' and ' +
012900221122                'L4_ACCT = ' + wwacct;
013000221122
013100221122         Exec Sql Declare d4 Cursor For wsql4;
013200221122         Exec Sql Prepare d4 From :wsql4;
013300221122         exec sql execute d4 ;
013400221122
013500221122       endif;
013600221027
013700190411       *inlr = *on;
013800190411
013900190411
