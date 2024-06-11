000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Convert Cost Centers CCFLG
000400000000      *
000500000000      *  (c)Copyright 2011 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - September 29, 2011
000800000000      *_________________________________________________________________________
000900110929     FMEMAC#    ip   e           k Disk
001000110929     FACCMST    if   e           k Disk
001100110929     FCODESL1   if   e           k Disk
001200130424     FINQCCFL1P if a e           k Disk
001300110929
001400110929     IMEMBR         01
001500110929     I                                          MBTRST        L2
001600110929     I                                          MBSUB#        L2
001700110929     I                                          MBACCT        L2
001800110929
001900110929     C   01              Do
002000110929     C                   If        %trim(CCFLG) <> *blanks
002100110929     C     keyacc        chain     accmst
002200110929     C                   If        %found(ACCMST)
002300110929     C                   If        ATRMDT = 0
002400110929     C     ccflg         chain     codesl1
002500110929     C                   If        %found(CODESL1)
002600130424     C     cckey         chain     INQCCFL1P
002700130424     C                   If        not %found(INQCCFL1P)
002800130424     C                   Write     INQCCFL1R
002900130424     C                   End
003000110929     C                   End
003100110929     C                   End
003200110929     C                   End
003300110929     C                   End
003400110929     C                   Enddo
003500110929
003600110929     C     *inzsr        Begsr
003700130424
003800130424     C     cckey         klist
003900130424     C                   kfld                    ACNAM1
004000130424     C                   kfld                    CCFLG
004100130424
004200110929     C     keyacc        klist
004300110929     C                   kfld                    MBTRST
004400110929     C                   kfld                    MBSUB#
004500110929     C                   kfld                    MBACCT
004600110929
004700110929     C                   Endsr
