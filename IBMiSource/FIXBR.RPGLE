000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *
000400000000      *  (c)Copyright 2014 by Innovative Outsourcing, Inc.
000500000000      *
000600000000      *    Created by:  JALLEN - June 26, 2014
000700000000      *_________________________________________________________________________
000800220222     FUPDRMGR   UP   E             DISK
000900190318     FSMANRMGP  UF   E           k DISK
001000140626
001100000000      * Program status data structure
001200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001300140626      *
001400220222     C     SMN           chain     SMANRMGP
001500190318     C                   if        %found(SMANRMGP)
001600220222     C                   If        %trim(SMRMGR) <> %trim(MGR)
001700220222     C                   eval      SMRMGR = %trim(MGR)
001800220222     C                   update    SMANRMGR
001900220222     C                   delete    updr
002000220222     C                   end
002100140626     C                   end
