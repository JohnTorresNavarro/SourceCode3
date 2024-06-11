000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Convert Cost Centers CCFLG
000400000000      *
000500000000      *  (c)Copyright 2011 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - September 29, 2011
000800000000      *_________________________________________________________________________
000900130619     FACCOSP    ip   e           k Disk
001000130429     FMEMAC#    if   e           k Disk
001100110929     FACCMST    if   e           k Disk
001200110929     FCODESL1   if   e           k Disk
001300110929     FWEBPAYCHP if a e           k Disk
001400110929
001500110929     D wseq#           s              3S 0 inz
001600130429
001700130429    ?D widta         e DS                  extname(inqccflgp)
001800130619
001900130619     C                   If        AOENDT = 0 and
002000130619     C                             AOCODE >= 6
002100110929
002200130429     C                   Eval      wseq# = 10
002300110929
002400130429     C     MEMKEY        Setll     MEMAC#
002500130429     C     MEMKEY        Reade     MEMAC#
002600130429     C                   Dow       not %eof(MEMAC#)
002700110929     C                   If        %trim(CCFLG) <> *blanks
002800110929     C     keyacc        chain     accmst
002900110929     C                   If        %found(ACCMST)
003000110929     C                   If        ATRMDT = 0
003100110929     C     ccflg         chain     codesl1
003200110929     C                   If        %found(CODESL1)
003300110929     C                   Eval      PCGRPR = 'COSTCENTER'
003400110929     C                   Eval      PCCODE = CCFLG
003500110929     C     keyweb        chain     webpaychp
003600110929     C                   If        not %found(WEBPAYCHP)
003700110929     C                   Eval      PCTRST = MBTRST
003800110929     C                   Eval      PCSUB# = MBSUB#
003900110929     C                   Eval      PCACCT = MBACCT
004000110929     C                   Eval      PCGRPR = 'COSTCENTER'
004100110929     C                   Eval      PCCODE = CCFLG
004200110929     C                   Eval      PCDESC = %trim(LDESCR)
004300110929     C                   Eval      PCSEQ# = wseq#
004400110929     C                   Write     WEBPAYCHR
004500110929     C                   Eval      wseq# = wseq# + 10
004600110929     C                   End
004700110929     C                   End
004800110929     C                   End
004900110929     C                   End
005000110929     C                   End
005100130429     C     MEMKEY        Reade     MEMAC#
005200110929     C                   Enddo
005300130429     C                   Eval      wseq# = 0
005400130619
005500130619     C                   End
005600110929
005700110929     C     *inzsr        Begsr
005800130429
005900130429     C     MEMKEY        Klist
006000130619     C                   Kfld                    AOTRST
006100130619     C                   Kfld                    AOSUB#
006200130619     C                   Kfld                    AOACCT
006300130429
006400110929     C     keyacc        klist
006500110929     C                   kfld                    MBTRST
006600110929     C                   kfld                    MBSUB#
006700110929     C                   kfld                    MBACCT
006800110929
006900110929     C     keyweb        klist
007000110929     C                   kfld                    MBTRST
007100110929     C                   kfld                    MBSUB#
007200110929     C                   kfld                    MBACCT
007300110929     C                   kfld                    PCGRPR
007400110929     C                   kfld                    PCCODE
007500110929     C                   Endsr
