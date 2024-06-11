000100001030      ******************************************************************
0001010505100003  * DW363      GROUP BENEFIT SERVICES, Inc.
0001020505100004  *               David Ketterman - 05/10/2005
000103050510      *
000200050510      *            Remove extra dependent cancel rec from dqdep and
000400050510      *            remove nines from cancel date
001039050510      *
001040050510      *
001100001030      ******************************************************************
001101050510     Fdqdep     up   e             DISK
002000990709
0020490505100030 Idqdepr
002051050510     I                                          dqdsubid      l1
002052050510     I                                          dqdseq        l1
002053050510     I                                          dqdgrp        l1
002054050510     I                                          dqdsec        l1
002056011204
002057050510      * on each l1 - clear candt if all nines
002059050510     c                   if        *inl1
002060050510
002061050510     c                   if        dqdcan = '99999999'
002062050510     c                   clear                   dqdcan
002064050510     c                   update    dqdepr
002066050510     c                   end
002069050510
002070050510      * all other rec (not l1) - if active clear candt of nines and keep rec
002071050510      * else delete rec since it is a duplicate cancel rec caused by
002072050510      * multiple gbs plans with the same group #
002073050510
002074050510      * special note : When the first rec has its cancel date changed from
002075050510      *                99999999 to blanks, opnqryf dynamicly includes the
002076050510      *                updated record again in the access path and since
002077050510      *                the sort is by cancel date (decending) it ends up
002078050510      *                at the bottom of the sort causing it to be read
002079050510      *                AGAIN. To avoid this (and the consequential incorrect
002080050510      *                delete of the active record) the following code
002081050510      *                also checks for a blank cancel date (dqdcan = blanks)
002082050510      *                so it does NOT get deleted.
002084050510      *
002085050510
002086050510     c                   else
002087050510
002088050510     c                   if        dqdcan = '99999999' or
002089050510     c                             dqdcan = '        '
002090050510     c                   clear                   dqdcan
002091050510     c                   update    dqdepr
002092050510     c                   else
002093050510     c                   delete    dqdepr
002094050510     c                   end
002095050510
002096050510     c                   end
