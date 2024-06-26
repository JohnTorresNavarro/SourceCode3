000100160513      *===========================================================================
000200180220     H option(*noDebugIo)
000300180220      *===========================================================================
000400180220      * EYEMED12R - Move records to new format
000500180220      *===========================================================================
000600180220      * Date        Int   Description
000700180220      * ----------  ---   --------------------------------------------------------
000800180220      * 02/20/2018  jt    Original creation
000900180220
001000160513      *===========================================================================
001100160518
001200180220     Feyemed081 uf   e             disk    rename(eyemedr:oldFormat)
001300160513
001400161123     Feyemed084 uf a e             disk    rename(eyemedr:newFormat)
001500150820
001600161026      //==================================================================
001700161026
001800161026     d id9             s              9
001900161026
002000160511      //==================================================================
002100160511      // mainline
002200160511      //===================================================================
002300150820
002400160511       exsr init;
002500160511       exsr main;
002600160511       exsr exit;
002700160511
002800160511      //===================================================================
002900160511      // main
003000160511      //===================================================================
003100160511
003200160511       begsr main;
003300160511
003400161025        setll 1 oldFormat;
003500161025        read oldFormat;
003600160511
003700160511        dow not %eof;
003800161025
003900161026          esubgrp = '1001';
004000161026          id9 = ememid;
004100161026          ememid = id9;
004200161026
004300161026          if erel = 'H';
004400161026           erel = 'M';
004500161026          endif;
004600161026
004700161025          write newFormat;
004800161025
004900161025        read oldFormat;
005000161025        enddo;
005100161123
005200160511       endsr;
005300161130
005400160511      //===================================================================
005500160511      // exit
005600160511      //===================================================================
005700160511
005800160511       begsr exit;
005900160511
006000160511        *inlr = '1';
006100160511        return;
006200160511
006300160511       endsr;
006400160511
006500160511      //===================================================================
006600160511      // init
006700160511      //===================================================================
006800160520
006900160511       begsr init;
007000160519
007100160511       endsr;
007200010412
007300160511       //==============================================================
