000100170111     H option(*noDebugIo)
000200170111      *================================================================
000300170111
000400170321     Fevrgrenxpnif a e           k disk    rename(EVGXPTF:mainFile)
000500170321
000600170321     Fevrgrenxpqif   e             disk    rename(EVGXPTF:tempFile)
000700170321
000800170321     Fevrgrenxplif   e           k disk    rename(EVGXPTS:saveFile)
000900170321
001000170213      *================================================================
001100170111
001200170111       exsr init;
001300170111       exsr main;
001400170111       exsr exit;
001500170111
001600170111      //========================
001700170111      // main
001800170111      //========================
001900170111
002000170111       begsr main;
002100170111
002200170321       setll 1 tempFile;
002300170321       read tempFile;
002400170111
002500170111       dow not %eof;
002600170213
002700170321       if evmbrdep = 'DEP';
002800170321
002900170321        setll evsubscr saveFile;
003000170321        reade evsubscr saveFile;
003100170321
003200170321        dow not %eof;
003300170321
003400170321         chain evgrpseq mainFile;
003500170321         if not %found;
003600170321          evtdate =  %char(%dec(%date: *iso));
003700170321           evtrncode = '030';
003800170321           evreasoncd = ' ';
003900170321          write mainfile;
004000170321         endif;
004100170214
004200170321        reade evsubscr saveFile;
004300170321        enddo;
004400170321
004500170321       endif;
004600170321
004700170321       read tempFile;
004800170111       enddo;
004900170111
005000170322       setll 1 tempFile;
005100170322       read tempFile;
005200170322
005300170322       dow not %eof;
005400170322
005500170322       if evmbrdep = 'MBR';
005600170322
005700170322        setll evsubscr saveFile;
005800170322        reade evsubscr saveFile;
005900170322
006000170322        dow not %eof;
006100170322
006200170322         chain evgrpseq mainFile;
006300170322         if not %found;
006400170322          evtdate =  %char(%dec(%date: *iso));
006500170322           evtrncode = '030';
006600170322           evreasoncd = ' ';
006700170322          write mainfile;
006800170322         endif;
006900170322
007000170322        reade evsubscr saveFile;
007100170322        enddo;
007200170322
007300170322       endif;
007400170322
007500170322       read tempFile;
007600170322       enddo;
007700170322
007800170111       endsr;
007900170111
008000170111      //========================
008100170111      // exit
008200170111      //========================
008300170111
008400170111       begsr exit;
008500170111
008600170111       *inlr = *on;
008700170111       return;
008800170111
008900170111       endsr;
009000170111
009100170111      //========================
009200170111      // init
009300170111      //========================
009400170111
009500170111       begsr init;
009600170111
009700170111       endsr;
009800170111
009900170111      //========================
