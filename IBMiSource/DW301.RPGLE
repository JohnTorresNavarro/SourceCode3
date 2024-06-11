0001000210160015  ******************************************************************
000200030128      * dw301          Group Benefit Services, Inc.                    *
000300021016      *                                                                *
000400021016      *    WRITTEN BY - DAVID KETTERMAN                                *
000500030128      *    DATE       - 01/28/03                                       *
000600021016      *                                                                *
000700030128      * correct group count in trailer rec.                            *
0008000212230015  *                                                                *
0009000210160015  ******************************************************************
0010000301280017 Fdbpears   iP   E             DISK
0011000301280016 fdbpeart   uF   E             DISK
0012000301280056 Dgcount           s              7s 0
0013000301280053 Idbpearsr
001400030128     I                                          psgrp         L1
001500030128     cl1                 add       1             gcount
001600030128
001700030128     clr                 read      dbpeart
001800030128     clr                 if        not %eof(dbpeart)
001900030128     clr                 move      gcount        pttotgrp
002000030128     clr                 update    dbpeartr
002100030128     clr                 end
