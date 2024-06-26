000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400180323      * CIGFI010R - Cigna FI - Non Facets Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800180313      * 03/13/2018  jt    Original creation
000900160513      *===========================================================================
001000180523
001100190204     fadvcsvdet if   e             disk    rename(advr:mainFile)
001200190130
001300190204     fadvdetail o    e             disk    rename(advr:outFile)
001400190204
001500190204     fmember    if   e           k disk    ExtFile('F.MEMBER')
001600190204     f                                     rename(membr:memberFile)
001700190204
001800190204     faccmst    if   e           k disk    ExtFile('F.ACCMST')
001900190204     f                                     rename(accmsr:acctFile)
002000190204
002100160512      *=================================================================
002200061017
002300180523     d covtp           s              2
002400150820
002500160511      //==================================================================
002600160511      // mainline
002700160511      //===================================================================
002800150820
002900160511       exsr init;
003000160511       exsr main;
003100160511       exsr exit;
003200160511
003300160511      //===================================================================
003400160511      // main
003500160511      //===================================================================
003600160511
003700160511       begsr main;
003800160511
003900190204       setll 1 mainFile;
004000190204       read mainFile;
004100180424
004200190204       dow not %eof;
004300190130
004400190204        exsr getField;
004500190204
004600190204        write outFile;
004700190130
004800190204       read mainFile;
004900190204       enddo;
005000190204
005100190130       endsr;
005200190130
005300190204      //===================================================================
005400190204      // get field
005500190204      //===================================================================
005600190204
005700190204        begsr getField;
005800190204
005900190204        chain (%dec(subssn#:9:0)) memberFile;
006000190204        if %found;
006100190204         chain (mbtrst : mbsub# : mbacct) acctFile;
006200190204
006300190204          if %found;
006400190204           groupnam = acnam1;
006500190204          endif;
006600190204
006700190204        endif;
006800190204
006900190204       endsr;
007000190204
007100190130      //===================================================================
007200160511      // exit
007300160511      //===================================================================
007400160511
007500160511       begsr exit;
007600160511
007700160511        *inlr = '1';
007800160511        return;
007900180523
008000160511       endsr;
008100160511
008200160511      //===================================================================
008300160511      // init
008400160511      //===================================================================
008500160520
008600160511       begsr init;
008700170710
008800160511       endsr;
008900010412
009000160511       //==============================================================
