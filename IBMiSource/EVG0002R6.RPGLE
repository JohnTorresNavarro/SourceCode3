000100170111     H option(*noDebugIo)
000200170111      *================================================================
000300170111
000400170124     Fevrgrenxpfuf   e             disk    rename(EVGXPTF:mainFile)
000500170112
000600170111      *================================================================
000700170111
000800170111       exsr init;
000900170111       exsr main;
001000170111       exsr exit;
001100170111
001200170111      //========================
001300170111      // main
001400170111      //========================
001500170111
001600170111       begsr main;
001700170111
001800170124       setll 1 mainFile;
001900170124       read mainFile;
002000170111
002100170111       dow not %eof;
002200170124
002300170124       if %subst(evzip:6:4) = '0000' or %subst(evzip:6:4) = '9999';
002400170124        evzip = %subst(evzip:1:5);
002500170124        update mainFile;
002600170124       endif;
002700170124
002800170124       read mainFile;
002900170111       enddo;
003000170111
003100170111       endsr;
003200170111
003300170111      //========================
003400170111      // exit
003500170111      //========================
003600170111
003700170111       begsr exit;
003800170111
003900170111       *inlr = *on;
004000170111       return;
004100170111
004200170111       endsr;
004300170111
004400170111      //========================
004500170111      // init
004600170111      //========================
004700170111
004800170111       begsr init;
004900170111
005000170111       endsr;
005100170111
005200170111      //========================
