000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Convert Cost Centers CCFLG
000500000000      *
000600000000      *  (c)Copyright 2011 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - September 29, 2011
000900000000      *_________________________________________________________________________
000901120104     FMEMAC#    if   e           k Disk
000902110929     FACCMST    if   e           k Disk
000903110929     FCODESL1   if   e           k Disk
001100120104     FINQCCFLGP if a e           k Disk
001101110929
001102110929     D wseq#           s              3S 0 inz
001103120104
001104120104     D wdta          e ds                  extname(inqccflgp)
001105110929
001106120104     C     *Entry        Plist
001107120104     C                   Parm                    wdta
001108110929
001109120104     C                   Eval      wseq# = 10
001110120104     C     keyacc        setll     memac#
001111120104     C     keyacc        reade     memac#
001112120104     C                   Dow       not %eof(MEMAC#)
001113110929
001114110929     C                   If        %trim(CCFLG) <> *blanks
001200110929     C     keyacc        chain     accmst
001300110929     C                   If        %found(ACCMST)
001301110929     C                   If        ATRMDT = 0
001302110929     C     ccflg         chain     codesl1
001303110929     C                   If        %found(CODESL1)
001304110929     C                   Eval      PCGRPR = 'COSTCENTER'
001305110929     C                   Eval      PCCODE = CCFLG
001306120104     C     keyweb        chain     inqccflgp
001307120104     C                   If        not %found(INQCCFLGP)
001309110929     C                   Eval      PCTRST = MBTRST
001310110929     C                   Eval      PCSUB# = MBSUB#
001311110929     C                   Eval      PCACCT = MBACCT
001312110929     C                   Eval      PCGRPR = 'COSTCENTER'
001313110929     C                   Eval      PCCODE = CCFLG
001314110929     C                   Eval      PCDESC = %trim(LDESCR)
001315110929     C                   Eval      PCSEQ# = wseq#
001316120104     C                   Write     INQCCFLGR
001317110929     C                   Eval      wseq# = wseq# + 10
001318110929     C                   End
001319110929     C                   End
001320110929     C                   End
001321110929     C                   End
001322110929     C                   End
001323120104     C     keyacc        reade     memac#
001324120104     C                   Enddo
001325120104
001326120104     C                   Return
001402110929
001500110929     C     *inzsr        Begsr
001600110929     C     keyacc        klist
001700120104     C                   kfld                    PCTRST
001800120104     C                   kfld                    PCSUB#
001900120104     C                   kfld                    PCACCT
001901110929
002000110929     C     keyweb        klist
002100110929     C                   kfld                    MBTRST
002200110929     C                   kfld                    MBSUB#
002300110929     C                   kfld                    MBACCT
002400110929     C                   kfld                    PCGRPR
002500110929     C                   kfld                    PCCODE
002600110929     C                   Endsr
