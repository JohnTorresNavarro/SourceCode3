000100990630      *? ***************************************************************
0002000004140003  *             GROUP BENEFIT SERVICES SOFTWARE           2000      *
0003009906300007  *                                                                *
0004000004100006  *  DESCRIPTION - Build a file containing enrollment renewals     *
0005000004100007  *                based on LDA parameters obtained in RP481.      *
000600000410      *                The file will be used in a spreadsheet.         *
0007009906300008  *                                                                *
000800000410      *  Written by  - S. Zien                                         *
000900000410      *  Date        - 4/10/00                                         *
001000000410      *                                                                *
001100000505      *                                                                *
001200000505      *            Revised by - S. Zien                                *
001300000505      *            Date -       5/05/00                                *
001400000505      *            Revision:    Find the rate dates which apply at the *
001500000505      *                         account level by determining if ANY    *
001600000505      *                         of the plans for the account are up    *
001700000505      *                         for renewal.                           *
0018000005050008  *                                                                *
001900000512      *            Revised by - S. Zien                                *
002000000512      *            Date -       5/12/00                                *
002100000512      *            Revision:    Add more fields to the file at         *
002200000512      *                         Noreen's request.                      *
0023000002090008  *                                                                *
002400990630      *? ***************************************************************
002500000410     FRP481WK   IF   E           K DISK
002600000410     FMCOVX     IF   E           K DISK
002700000410     FPLNMST    IF   E           K DISK
002800000410     FGRATE     IF   E           K DISK
002900000512     FSMAN      IF   E           K DISK
003000000410     FENRREN    UF A E           K DISK
003100000410      *
0032000004100036 D                 DS
0033000004100047 D  FRMDAT                 1      8  0
003400000410     D   frmccyy               1      6  0
0035000004100046 D   frmmm                 7      8  0
0036000004100036 D                 DS
0037000004100047 D  TODAT                  1      8  0
003800000410     D   toccyy                1      6  0
0039000004100046 D   tomm                  7      8  0
0040000004100040 D                 DS
0041000004100041 D  Lyymm                  1      6  0
0042000004100042 D  Ly                     1      2  0
0043000004100043 D  Lm                     3      6  0
0044000004100040 D                UDS
0045000004100041 D  LMMYY                  1      6  0
0046000004100042 D  LMM                    1      2  0
0047000004100043 D  LYY                    3      6  0
0048000004100044 D  LTRUST                 7      9
004900000410      *
005000000410     c                   read      rp481wk                                50
005100000410     c     *in50         doweq     *off
005200000410     c     *in50         ifeq      *off
005300000410     c                   exsr      process
005400000410     c                   read      rp481wk                                50
005500000410     c                   endif
005600000410     c                   enddo
005700000410     c                   seton                                        lr
005800000410      *___________________________________________________________________
005900000410      * Main process routine
006000000410      *___________________________________________________________________
006100000410     C     Process       BEGSR
006200000410      *
006300000410     c                   move      actrst        mctrst
006400000410     c                   move      acsub#        mcsub#
006500000410     c                   move      acacct        acc#
006600000410      *
006700000505     c     Mcovxk        setll     mcovx
006800000505    ?C                   DOU       %EOF(mcovx)
006900000505    ?C     Mcovxk        READE     mcovx
007000000410     c                   move      mcplan        PLPLAN
007100000410     C                   move      actrst        PLTRST
007200000410     C                   move      acsub#        PLSUB#
007300000410      *
007400000410     c     Plnkey        chain     plnmst
007500000410     c                   if        %found(plnmst)
007600000410      *
007700000410     c                   exsr      getgrp
007800000410     c                   endif
007900000505     c                   enddo
008000000410      *
008100000410     c                   ENDSR
008200000410      *___________________________________________________________________
008300000410      * Write encounter renewal record.
008400000410      *___________________________________________________________________
008500000410     C     Wrtenr        BEGSR
008600000410      *
008700000410     C                   move      actrst        ENTRST
008800000410     C                   move      acsub#        ENSUB#
008900000410     C                   move      acacct        ENACCT
009000000505     c                   move      group#        ENGRP#
009100000410     c     Enrkey        chain     Enrren
009200000410     c                   move      pcarr         encarr
009300000410     c                   move      plncat        enplnc
009400000410     c                   movel     acnam1        ennam1
009500000505     c                   if        NOT %found(Enrren)
009600000512     c                   z-add     medemp        enmede
009700000512     c     Smancd        chain     Sman
009800000512     c                   move      smancd        ensman
009900000512     c                   movel     sfname        ensfna
010000000512     c                   movel     slname        enslna
010100000505     c                   write     Enrrenr
010200000512     c                   reset                   ensman
010300000512     c                   reset                   ensfna
010400000512     c                   reset                   enslna
010500000505     c                   endif
010600000410      *
010700000410     c                   ENDSR
010800000410      *___________________________________________________________________
010900000410      * Retrieve the group number/s from the GRATE file.
011000000410      *___________________________________________________________________
011100000410     C     Getgrp        BEGSR
011200000410      *
011300000410     c     ratkey        setll     grate
011400000410     c     *in77         doueq     *on
011500000410     c     ratkey        reade     grate                                77
011600000410     c                   if        %eof(grate)
011700000410     c                   leave
011800000410     c                   endif
011900000410     c                   z-add     LMM           lm
012000000410     c                   z-add     LYY           ly
012100000410     c     *in77         ifeq      *off
012200000410     c     lyymm         ifge      frmccyy
012300000410     c     lyymm         andle     toccyy
012400000410     c                   leave
012500000410     c                   endif
012600000505     c                   exsr      wrtenr
012700000410     c                   endif
012800000410     c                   enddo
012900000410      *
013000000410     c                   ENDSR
013100000410      *___________________________________________________________________
013200000410      * Initialization
013300000410      *___________________________________________________________________
013400000410     C     *INZSR        BEGSR
013500000410      *
013600000410     C     ENRKEY        KLIST
013700000410     C                   KFLD                    ENTRST
013800000410     C                   KFLD                    ENSUB#
013900000410     C                   KFLD                    ENACCT
014000000505     c                   KFLD                    ENGRP#
014100000410      *
014200000410     C     MCOVXK        KLIST
014300000410     C                   KFLD                    MCTRST
014400000410     C                   KFLD                    MCSUB#
014500000410     C                   KFLD                    ACC#
014600000410      *
014700000410     C     PLNKEY        KLIST
014800000410     C                   KFLD                    PLTRST
014900000410     C                   KFLD                    PLSUB#
015000000410     C                   KFLD                    PLPLAN
015100000410      *
015200000410     C     RATKEY        KLIST
015300000410     C                   KFLD                    MCTRST
015400000410     C                   KFLD                    MCSUB#
015500000410     C                   KFLD                    MCPLAN
015600000410     C                   KFLD                    MCAGEB
015700000410     C                   KFLD                    MCOVTP
015800000410      *
015900000410     c                   ENDSR
