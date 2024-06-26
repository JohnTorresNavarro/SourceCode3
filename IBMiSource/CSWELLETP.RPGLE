000100170711      *=========================================================================
000200170711     H option(*noDebugIo)
000300170711      *=========================================================================
000400210915      * CSWELLETP - Sr. Dental Welcome Letter - for reprinting
000500170711      *=========================================================================
000600170711      *  Date        Int  Description
000700170711      *  ----------  ---  ------------------------------------------------------
000800170817      *  08/10/2017  jt   Original Creation
000900210210      *  02/10/2021  jt   Fixed reprinting issue
001000170711      *=========================================================================
001100180517
001200210915     Fprtcsmhst uf   e           k disk    rename(MOBHSTR:cshistFile)
001300170810
001400210915     Fcswelletf uf   e           k disk    rename(amwelr:welFile)
001500210210
001600210210      //========================================================================
001700210210      // data stuctures
001800210210      //========================================================================
001900210210
002000210210     d today           s             10
002100210210     d todayd          s              8  0
002200210210     d todayiso        s               d
002300210210
002400210915     d cswelletp       pi
002500210210     d  date                          8
002600210210
002700170711      //========================================================================
002800170711      // mainline
002900170711      //========================================================================
003000170711
003100170711       exsr init;
003200170711       exsr main;
003300170711       exsr exit;
003400170711
003500170711      //========================================================================
003600170711      // main
003700170711      //========================================================================
003800170711
003900170711       begsr main;
004000170711
004100180611        setll *loval welFile;
004200180611        read welFile;
004300170711
004400170711        dow not %eof;
004500210210
004600210915         if amprocess = today;
004700210210          exsr process;
004800210915           amprocess = ' ';
004900210210          update welFile;
005000210210         endif;
005100170711
005200180611        read welFile;
005300170711        enddo;
005400170711
005500170711       endsr;
005600170711
005700170711      //========================================================================
005800170711      // process
005900170711      //========================================================================
006000170711
006100170711       begsr process;
006200180517
006300210915        chain (%dec(%subst(amtsaf:1:3):3:0) :
006400210915               %dec(%subst(amtsaf:5:3):3:0) :
006500210915               %dec(%subst(amtsaf:9:4):4:0)) cshistFile;
006600180611        if %found;
006700210915         delete cshistFile;
006800180611        endif;
006900180517
007000180517       endsr;
007100210210
007200170711      //=======================================================================
007300170711      // Exit
007400170711      //=======================================================================
007500170711
007600170711       begsr exit;
007700170711
007800170711        *inlr = '1';
007900170711        return;
008000170711
008100170711       endsr;
008200170711
008300170711      //=======================================================================
008400170711      // Init
008500170711      //=======================================================================
008600170711
008700170711       begsr init;
008800210210
008900210210        if date = ' ';
009000210210         today = %char(%date() : *usa);
009100210210        else;
009200210210         todayd = %dec(date:8:0);
009300210210         todayiso = %date(todayd);
009400210210         today = %char(todayiso : *usa);
009500210210        endif;
009600180426
009700170711       endsr;
009800170711
009900170711      //=======================================================================
