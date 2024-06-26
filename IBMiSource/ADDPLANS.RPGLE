000100170224      *=========================================================================
000200170224     H option(*noDebugIo)
000300170224      *=========================================================================
000400170313      * This program adds plans to member and dependent coverage but only in a
000500170313      * file being overwritten to a qtemp file... this does not add records to
000600170313      * the actual files...
000700170313      *=========================================================================
000800170224
000900170310     Fevergreenlif   e           k disk    rename(evergreenv:everFile)
001000170310
001100170310     Fmcovmpln  if a e           k disk    rename(mcovr:memcovFile)
001200170301
001300170310     Ftrnmcov   uf   e           k disk    rename(tmcovr:tranmFile)
001400170224
001500170310     Fdcova     if a e           k disk    rename(dcovr:depcovFile)
001600170301
001700170310     Ftrndcov   uf   e           k disk    rename(tdcovr:trandFile)
001800170224
001900170310      //========================================================================
002000170310      // mainline
002100170310      //========================================================================
002200170310
002300170310       exsr init;
002400170310       exsr main;
002500170310       exsr exit;
002600170310
002700170310      //========================================================================
002800170310      // main
002900170310      //========================================================================
003000170224
003100170310       begsr main;
003200170310
003300170313       // Add plans to member plans (qtemp file)...
003400170310       setll *loval tranmfile;
003500170310       read tranmFile;
003600170224
003700170224       dow not %eof;
003800170224
003900170310        if processed = ' ';
004000170301
004100170310         chain (mctrst : mcsub# : mcplan) everFile;
004200170310         if %found;
004300170310          write memcovFile;
004400170310         endif;
004500170301
004600170310         processed = 'Y';
004700170310         update tranmfile;
004800170310        endif;
004900170224
005000170310       read tranmFile;
005100170310       enddo;
005200170310
005300170313       // ... then add plans to dep. plans (qtemp file)...
005400170310       setll *loval trandfile;
005500170310       read trandFile;
005600170310
005700170310       dow not %eof;
005800170310
005900170310        if processed = ' ';
006000170310
006100170310         chain (dvtrst : dvsub# : dvplan) everFile;
006200170310         if %found;
006300170310          write depcovFile;
006400170310         endif;
006500170310
006600170310         processed = 'Y';
006700170310         update trandfile;
006800170310        endif;
006900170310
007000170310       read trandFile;
007100170310       enddo;
007200170310
007300170310       endsr;
007400170310
007500170310      //========================================================================
007600170310      // exit
007700170310      //========================================================================
007800170310
007900170310       begsr exit;
008000170310
008100170310        *inlr = *on;
008200170310        return;
008300170310
008400170310       endsr;
008500170224
008600170310      //========================================================================
008700170310      // init
008800170310      //========================================================================
008900170310
009000170310       begsr init;
009100170310
009200170310       endsr;
009300170310
009400170310      //========================================================================
