000100000000      *_________________________________________________________________________
000200130716      *
000300130716      *  NOTES:  You must first put all "MT" and "DT" on "D"  DONTSEND
000400130716      *          Then release all "MA" and "DA" as "R"  RELEASED
000500130716      *          Then run step 1 only of the 834 process.
000600130716      *          Then cpyf DBEDTL834 to DBEDTL834J
000700130716      *          Then change hard coding in this program
000800130716      *          Then run this program over J file
000900130716      *          Create X4 send to Cindie/Brandon for review
001000130716      *          If all good, copy back to DBEDTL834 replace
001100130716      *
001200000000      *
001300130716      *  (c)Copyright 2013 by Innovative Outsourcing, Inc.
001400000000      *
001500130716      *    Created by:  JALLEN - July 16, 2013
001600000000      *_________________________________________________________________________
001700130716     FDBEDTL834JUP   E             DISK
001800090320      *
001900090409     D SKIPWRT         S              1A   INZ
002000000000      *
002100130716     IDBEDTLR       01
002200130716     I*******                                   D3SUB         L2
002300130716
002400121112      * Update Trans
002500130716     C   01              Exsr      Update834
002600090320      *___________________________________________________________________
002700130716      * update records
002800090320      *___________________________________________________________________
002900130716     C     Update834     BEGSR
003000130716
003100130716      * HARD CODED
003200130716     C                   Eval      D3TAXID = 462292218
003300130716
003400130716     C                   If        D3GRP <> *blanks
003500130716     C                   Eval      D3GRP = '1RB7'
003600130716     C                   End
003700130716
003800130716     C                   If        D3GRP1 <> *blanks
003900130716     C                   Eval      D3GRP1 = '1RB7'
004000130716     C                   End
004100130716
004200130716     C                   If        D3GRP2 <> *blanks
004300130716     C                   Eval      D3GRP2 = '1RB7'
004400130716     C                   End
004500130716
004600130716     C                   If        D3GRP3 <> *blanks
004700130716     C                   Eval      D3GRP3 = '1RB7'
004800130716     C                   End
004900130716
005000130716     C                   If        D3GRP4 <> *blanks
005100130716     C                   Eval      D3GRP4 = '1RB7'
005200130716     C                   End
005300130716
005400130716     C                   Eval      D3SLVL5 = *blanks
005500130716     C                   Eval      D3SLVL6 = *blanks
005600130716     C                   Eval      D3SLVL7 = *blanks
005700130716     C                   Eval      D3SLVL8 = *blanks
005800130716
005900130716     C                   Eval      D3FIL45 = *blanks
006000130716     C                   Eval      D3FIL46 = *blanks
006100130716     C                   Eval      D3FIL47 = *blanks
006200130716     C                   Eval      D3FIL48 = *blanks
006300130716
006400130716     C                   Eval      D3SLVL5 = *blanks
006500130716     C                   Eval      D3SLVL6 = *blanks
006600130716     C                   Eval      D3SLVL7 = *blanks
006700130716     C                   Eval      D3SLVL8 = *blanks
006800130716
006900130716     C                   Eval      D3SCEF5 = *blanks
007000130716     C                   Eval      D3SCEF6 = *blanks
007100130716     C                   Eval      D3SCEF7 = *blanks
007200130716     C                   Eval      D3SCEF8 = *blanks
007300130716
007400130716     C                   Eval      D3SCTR5 = *blanks
007500130716     C                   Eval      D3SCTR6 = *blanks
007600130716     C                   Eval      D3SCTR7 = *blanks
007700130716     C                   Eval      D3SCTR8 = *blanks
007800130716
007900130716     C                   If        D3FIL41 <> *blanks
008000130716     C                   Eval      D3FIL41 = 'A'
008100130716     C                   End
008200130716
008300130716     C                   If        D3FIL42 <> *blanks
008400130716     C                   Eval      D3FIL42 = 'A'
008500130716     C                   End
008600130716
008700130716     C                   If        D3FIL43 <> *blanks
008800130716     C                   Eval      D3FIL43 = 'A'
008900130716     C                   End
009000130716
009100130716     C                   If        D3FIL44 <> *blanks
009200130716     C                   Eval      D3FIL44 = 'A'
009300130716     C                   End
009400130716
009500130716     C                   If        D3MNTYP <> *blanks
009600130716     C                   Eval      D3MNTYP = 'A'
009700130716     C                   End
009800130716
009900130716     C                   If        D3MNRSN <> *blanks
010000130716     C                   Eval      D3MNRSN = '1'
010100130716     C                   End
010200130716
010300130716     C                   Update    DBEDTLR
010400090330
010500090320     C                   ENDSR
