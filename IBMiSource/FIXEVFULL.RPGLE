000100170111     H option(*noDebugIo)
000200170111      *================================================================
000300170111
000400170112     Fevrgrenxpfif   e           k disk    rename(EVGXPTF:fullFile)
000500170112
000600170112     Fevergrnfxluf a e           k disk    rename(EVGXPTF:tfullFile)
000700170112     F                                     prefix(t_)
000800170210
000900170210     Fevrgrenfixuf a e           k disk    rename(EVGXPTF:tfullFileP)
001000170210     F                                     prefix(p_)
001100170112
001200170111      *================================================================
001300170111
001400170111       exsr init;
001500170111       exsr main;
001600170111       exsr exit;
001700170111
001800170111      //========================
001900170111      // main
002000170111      //========================
002100170111
002200170111       begsr main;
002300170111
002400170112       exsr canceled;
002500170112       exsr effective;
002600170112
002700170112       endsr;
002800170112
002900170112      //========================
003000170112      // effective
003100170112      //========================
003200170112
003300170112       begsr effective;
003400170112
003500170112       setll *loval fullFile;
003600170112       read fullFile;
003700170111
003800170111       dow not %eof;
003900170111
004000170112       if evssnmbr > ' ';
004100170111
004200170112        setll evsubscr tfullFile;
004300170112        reade evsubscr tfullFile;
004400170112
004500170112        dow not %eof;
004600170112
004700170112        if t_evmbrdep = 'DEP';
004800170112
004900170112         if evcoveff <> t_evcoveff;
005000170112          t_evcoveff = evcoveff;
005100170112          update tfullFile;
005200170112         endif;
005300170112
005400170112        endif;
005500170112
005600170112        reade evsubscr tfullFile;
005700170112        enddo;
005800170112
005900170112       endif;
006000170112
006100170112       read fullFile;
006200170111       enddo;
006300170111
006400170111       endsr;
006500170111
006600170112      //========================
006700170112      // canceled
006800170112      //========================
006900170112
007000170112       begsr canceled;
007100170112
007200170112       setll *loval fullFile;
007300170112       read fullFile;
007400170112
007500170112       dow not %eof;
007600170112
007700170112       if evcovend > ' ';
007800170210       if evmbrdep = 'DEP';
007900170112
008000170210        chain evgrpseq tfullFileP;
008100170210        if %found;
008200170210         delete tfullFileP;
008300170210        endif;
008400170112
008500170210       endif;
008600170112       endif;
008700170112
008800170112       read fullFile;
008900170112       enddo;
009000170112
009100170210       setll *loval fullFile;
009200170210       read fullFile;
009300170210
009400170210       dow not %eof;
009500170210
009600170210       if evcovend > ' ';
009700170210       if evmbrdep = 'MBR';
009800170210
009900170210        setll evsubscr tfullFile;
010000170210        reade evsubscr tfullFile;
010100170210
010200170210        dow not %eof;
010300170210
010400170210         delete tfullFile;
010500170210
010600170210        reade evsubscr tfullFile;
010700170210        enddo;
010800170210
010900170210       endif;
011000170210       endif;
011100170210
011200170210       read fullFile;
011300170210       enddo;
011400170210
011500170112       endsr;
011600170112
011700170111      //========================
011800170111      // exit
011900170111      //========================
012000170111
012100170111       begsr exit;
012200170111
012300170111       *inlr = *on;
012400170111       return;
012500170111
012600170111       endsr;
012700170111
012800170111      //========================
012900170111      // init
013000170111      //========================
013100170111
013200170111       begsr init;
013300170111
013400170111       endsr;
013500170111
013600170111      //========================
