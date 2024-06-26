000100211216      *================================================================================
000200211216     H option(*noDebugIo)
000300211216      *================================================================================
000400211216      * FM121BR - Agency Master App - Next Agency Number
000500211216      *================================================================================
000600211216      * Date        Int   Description
000700211216      * ----------  ---   -------------------------------------------------------------
000800211216      * 12/16/2021  jt    Original creation
000900211216      *================================================================================
001000211216
001100221024     fftFmtFil  uf   e           k disk
001200221024     f                                     rename(r_ftfmtfil:trFile)
001300211216
001400221024     faccmst    if   e           k disk
001500221024     f                                     extfile('F.ACCMST')
001600211221
001700221024     faacode    if   e           k disk    rename(aacodr:aaFile)
001800211221     f
001900211221
002000211221      //=======================================================================
002100211221
002200221024
002300221024     iACCMSR
002400221024     i              AACODE                      A_AACODE
002500211221
002600211216      //=======================================================================
002700211216      // mainline
002800211216      //=======================================================================
002900211216
003000211216       exsr init;
003100211216       exsr main;
003200211216       exsr exit;
003300211216
003400211216       //=======================================================================
003500211216       // main2subr
003600211216       //=======================================================================
003700211216
003800211216       begsr main;
003900211216
004000221024        setll *loval trFile;
004100221024        read trFile;
004200211221        dow not %eof;
004300211221
004400221107           if FFCRTDT = 20221106;
004500211221
004600221024          chain (fftrst : ffsub# :ffacct) accmst;
004700221024          if %found;
004800221103
004900221024           chain a_aacode aafile;
005000221024            if %found;
005100221024             if a_aacode = '200' or a_aacode = '201' or a_aaCode = '202'
005200221024              or a_aacode = '203' or a_aacode = '204';
005300221024              ffasgn_aa = afnam;
005400221103              //else;
005500221103              //ffasgn_aa = ' ';
005600221024              update trFile;
005700221024             endif;
005800221024            endif;
005900221103
006000221024          endif;
006100211221
006200221107          endif;
006300211221
006400221024        read trFile;
006500211216        enddo;
006600211216
006700211216       endsr;
006800211216
006900211216       //=======================================================================
007000211216       // exit
007100211216       //=======================================================================
007200211216
007300211216       begsr exit;
007400211216
007500211216        *inlr = '1';
007600211216        return;
007700211216
007800211216       endsr;
007900211216
008000211216       //=======================================================================
008100211216       // init subr
008200211216       //=======================================================================
008300211216
008400211216       begsr init;
008500211216
008600211216       endsr;
008700211216
008800211216       //=======================================================================
