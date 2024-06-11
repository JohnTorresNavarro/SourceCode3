000100170224      *=========================================================================
000200170224     H option(*noDebugIo)
000300170224      *=========================================================================
000400170224
000500170301     Fsmanrmgp  if   e           k disk    rename(smanrmgr:xrefFile)
000600170301
000700170301     Fsmanbrokl if   e           k disk    rename(smanbr:csvFile)
000800170301
000900170224     Fsman      if   e           k disk    rename(smanr:smanFile)
001000170224     F                                     extfile('F.SMAN')
001100170224
001200170301     Frmgrmst0  if   e           k disk    rename(rmgrmstr:relaFile)
001300170301
001400170301     Fjohnbrokerif   e           k disk    rename(rmgrmstr:johnFile)
001500170224
001600170224     Fbrokererr o    e             disk    rename(brkerrr:errorFile)
001700170224
001800170224      *=========================================================================
001900170224
002000170224     D john            s              1
002100170224
002200170224      *=========================================================================
002300170224
002400170301       setll *loval smanFile;
002500170301       read smanFile;
002600170224
002700170224       dow not %eof;
002800170224
002900170301        if smancd <> '...';
003000170301
003100170301        chain smancd xrefFile;
003200170301        if not %found;
003300170301         write errorFile;
003400170301
003500170301        else;
003600170301         chain smrmgr relaFile;
003700170301         if not %found;
003800170301          if smrmgr <> 'TERM';
003900170301          smancode = smancd;
004000170301          brkrep2 = smrmgr;
004100170301          chain smrmgr johnFile;
004200170301          if %found;
004300170301           brkname = rmname;
004400170301          endif;
004500170301          write errorFile;
004600170301          endif;
004700170301
004800170301         else;
004900170301          chain (rmname) csvFile;
005000170301          if not %found;
005100170301           if RMNAME <> 'Broker Terminated'
005200170301           and RMNAME <> 'Unassigned'
005300170301           and RMNAME <> 'Broker Retired';
005400170301           write errorFile;
005500170301           endif;
005600170301          endif;
005700170301
005800170301         endif;
005900170301
006000170301        endif;
006100170224
006200170301       endif;
006300170301       read smanFile;
006400170224       enddo;
006500170224
006600170224       *inlr = *on;
006700170224       return;
006800170224
