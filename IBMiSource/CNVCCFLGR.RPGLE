000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Convert Cost Centers CCFLG
000400000000      *
000500000000      *  (c)Copyright 2011 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - September 29, 2011
000800000000      *_________________________________________________________________________
000900130429     FMEMAC#    if   e           k Disk
001000110929     FACCMST    if   e           k Disk
001100110929     FCODESL1   if   e           k Disk
001200110929     FWEBPAYCHP if a e           k Disk
001300110929
001400110929     D wseq#           s              3S 0 inz
001500130429
001600130429    ?D widta         e DS                  extname(inqccflgp)
001700130429
001800130429     C     *Entry        Plist
001900130429     C                   Parm                    widta
002000110929
002100130429     C                   Eval      wseq# = 10
002200110929
002300130429     C     MEMKEY        Setll     MEMAC#
002400130429     C     MEMKEY        Reade     MEMAC#
002500130429     C                   Dow       not %eof(MEMAC#)
002600110929     C                   If        %trim(CCFLG) <> *blanks
002700110929     C     keyacc        chain     accmst
002800110929     C                   If        %found(ACCMST)
002900110929     C                   If        ATRMDT = 0
003000110929     C     ccflg         chain     codesl1
003100110929     C                   If        %found(CODESL1)
003200110929     C                   Eval      PCGRPR = 'COSTCENTER'
003300110929     C                   Eval      PCCODE = CCFLG
003400110929     C     keyweb        chain     webpaychp
003500110929     C                   If        not %found(WEBPAYCHP)
003600110929     C                   Eval      PCTRST = MBTRST
003700110929     C                   Eval      PCSUB# = MBSUB#
003800110929     C                   Eval      PCACCT = MBACCT
003900110929     C                   Eval      PCGRPR = 'COSTCENTER'
004000110929     C                   Eval      PCCODE = CCFLG
004100110929     C                   Eval      PCDESC = %trim(LDESCR)
004200110929     C                   Eval      PCSEQ# = wseq#
004300110929     C                   Write     WEBPAYCHR
004400110929     C                   Eval      wseq# = wseq# + 10
004500110929     C                   End
004600110929     C                   End
004700110929     C                   End
004800110929     C                   End
004900110929     C                   End
005000130429     C     MEMKEY        Reade     MEMAC#
005100110929     C                   Enddo
005200130429     C                   Eval      wseq# = 0
005300130429
005400130429     C                   Eval      *inLR = *on
005500130429     C                   Return
005600110929
005700110929     C     *inzsr        Begsr
005800130429
005900130429     C     MEMKEY        Klist
006000130429     C                   Kfld                    PCTRST
006100130429     C                   Kfld                    PCSUB#
006200130429     C                   Kfld                    PCACCT
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
