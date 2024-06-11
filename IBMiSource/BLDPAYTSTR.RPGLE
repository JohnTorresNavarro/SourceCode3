001900101105     d pos             s              2s 0 inz
002032101116     d CovLevel        s             20a   inz
002033101105     d NewHire         s              1s 0 inz
002034110727     d wwrtn           s              1a   inz
002036110727     d wwsal           s              1a
002100061122
002101101105     d Today           S               d   datfmt(*iso)
002102101105     d  wiso           s               d   datfmt(*iso)
002103101105     d w80date         s              8s 0 inz
002105101105
002106101116     d wdta          e ds                  extname(WEBPAYGBS)
002110101116
002111110803     C                   Clear                   WDTA
002117101116
002118101116      * Load Keys
002119110803     C                   Eval      PGTRS = 590
002120110803     C                   Eval      PGSUB = 12
002121110803     C                   Eval      PGACT = 12
002122110803     C                   Eval      PGSSN = 213297646
002123110803     C                   Eval      PGSEQ = 0
002124110803     C                   Eval      PGCAT = 'PMM'
002125110803     C                   Eval      PGPLN = 'BAAW'
002126110803     C                   Eval      PGBENAM = 0
002127110803     C                   Eval      PGSTART = 08012011
002128110803     C                   Eval      PGSTOP = 0
002129110803
002130110803     C                   call      'BLDPAYDEDR'
002131110803     C                   Parm                    wdta
002132110803     C                   Parm      'Y'           wwsal
005020101116
005021101116     C                   Eval      *inlr = *on
005022101116     C                   Return
005023101105
007600061122      *--------------------------------------------------------------*
007601101105     C     *inzsr        Begsr
010016101105
010100061122     C                   Endsr
