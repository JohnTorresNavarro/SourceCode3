000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  re-add the flags
000400000000      *
000500000000      *  (c)Copyright 2013 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - January 08, 2013
000800000000      *_________________________________________________________________________
000900130108     FDW311FLG  uf a e           k disk
001000130108     FDW311FLGH uf a e           k disk
001100130108
001200000000      * Program status data structure
001300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001400130108
001500130108     C     *Entry        PLIST
001600130108     C                   parm                    wissn             9
001700130108     C                   parm                    wiseq             2
001800130108     C                   parm                    wiflg             1
001900130108     C                   parm                    wiflgm            1
002000130108     C                   parm                    witypm            2
002100130108     C                   parm                    wiflgr            1
002200130108     C                   parm                    witypr            2
002300130108     C                   parm                    wiflgd            1
002400130108     C                   parm                    witypd            2
002500130108     C                   parm                    wiflgv            1
002600130108     C                   parm                    witypv            2
002700130108     C                   parm                    wieff             8
002800130108     C                   parm                    wiGRP#            4
002900130108     C                   parm                    wiSGRP            4
003000130108
003100130108     C     ' ':'0'       xlate     wissn         wissn
003200130108     C     ' ':'0'       xlate     wiseq         wiseq
003300130108     C     ' ':'0'       xlate     wieff         wieff
003400130108
003500130108     C     flgkey        Klist
003600130108     C                   kfld                    DFSSN
003700130108     C                   kfld                    DFSEQ
003800130108
003900130108     C                   move      wissn         DFSSN
004000130108     C                   move      wiseq         DFSEQ
004100130108
004200130108     C     flgkey        Setll     DW311FLG
004300130108     C     flgkey        Reade     DW311FLG
004400130108     C                   Dow       not %eof(DW311FLG)
004500130108     C     flgkey        Delete    DW311FLGR
004600130108     C     flgkey        Reade     DW311FLG
004700130108     C                   Enddo
004800130108
004900130108     C                   Clear                   DW311FLGR
005000130108     C                   move      wissn         DFSSN
005100130108     C                   move      wiseq         DFSEQ
005200130108     C                   move      wieff         DFORGEF
005300130108     C                   move      wigrp#        DFGRP#
005400130108     C                   move      wisgrp        DFSGRP
005500130108     C                   move      wiflg         DFLG
005600130108     C                   move      wiflgm        DFLGM
005700130108     C                   move      witypm        DTYPM
005800130108     C                   move      wiflgr        DFLGr
005900130108     C                   move      witypr        DTYPr
006000130108     C                   move      wiflgd        DFLGd
006100130108     C                   move      witypd        DTYPd
006200130108     C                   move      wiflgv        DFLGv
006300130108     C                   move      witypv        DTYPv
006400130108     C                   write     DW311FLGR
006500130108
006600130108     C     flgkey        Setll     DW311FLGH
006700130108     C     flgkey        Reade     DW311FLGH
006800130108     C                   Dow       not %eof(DW311FLGH)
006900130108     C     flgkey        Delete    DW311FLGHR
007000130108     C     flgkey        Reade     DW311FLGH
007100130108     C                   Enddo
007200130108
007300130108     C                   Clear                   DW311FLGHR
007400130108     C                   move      wissn         DFSSN
007500130108     C                   move      wiseq         DFSEQ
007600130108     C                   move      wieff         DFORGEF
007700130108     C                   move      wigrp#        DFGRP#
007800130108     C                   move      wisgrp        DFSGRP
007900130108     C                   move      wiflg         DFLG
008000130108     C                   move      wiflgm        DFLGM
008100130108     C                   move      witypm        DTYPM
008200130108     C                   move      wiflgr        DFLGr
008300130108     C                   move      witypr        DTYPr
008400130108     C                   move      wiflgd        DFLGd
008500130108     C                   move      witypd        DTYPd
008600130108     C                   move      wiflgv        DFLGv
008700130108     C                   move      witypv        DTYPv
008800130108     C                   write     DW311FLGHR
008900130108
009000130108     C                   Eval      *inlr = *on
009100130108     C                   Return
009200130108
009300000000      *___________________________________________________________________
009400000000      * Key Lists
009500000000      *___________________________________________________________________
009600000000     C     KLIST         BEGSR
009700000000     C                   ENDSR
009800000000      *___________________________________________________________________
009900000000      * Program open
010000000000      *___________________________________________________________________
010100000000     C     *INZSR        BEGSR
010200000000     C                   ENDSR
010300000000      *___________________________________________________________________
010400000000      * Program error handler
010500000000      *___________________________________________________________________
010600000000     C     *PSSR         BEGSR
010700000000     C                   CALL      'SNDRPGM'                            50
010800000000     C                   PARM                    WQPGMN
010900000000     C                   PARM                    WQSTSC
011000000000     C                   PARM                    WQRPGS
011100000000     C                   PARM                    WQMSG
011200000000     C                   ENDSR     '*CANCL'
