000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300110906    ? *  Description:  Release On-Demand Deductions
000400000000    ? *
000500110906    ? *  (c)Copyright 2011 by GBS, Inc.
000600000000    ? *
000700000000    ? *___________________________________________________________________
000800110906    ?FWEBPAYONL2UP   E           K DISK
000900000000    ? *___________________________________________________________________
001000000406    ? * Data structure
001100110621    ?D WUDTA         E DS                  EXTNAME(WEBPAYOND)
001200110906
001300110906    ? * Program status data structure
001400110906    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001500110906    ?
001600110906    ? * Send that have not yet been sent
001700110906     C                   If        POSENT = 0
001800110621     C     *Date         Mult      10000.0001    POSENT
001900110621     C                   Time                    POTIME
002000110621     C                   Eval      POUSER = %trim(WQUSRN)
002100160608
002200160608     C                   if        PODAMT = 0
002300160608     C                   select
002400160608     C                   when      po401k <> 0
002500160608     C                   eval      PODAMT = PO401K
002600160608     C                   when      po401p <> 0
002700160608     C                   eval      PODAMT = PO401P
002800160608     C                   when      pofsam <> 0
002900160608     C                   eval      PODAMT = POFSAM
003000160608     C                   when      pofsad <> 0
003100160608     C                   eval      PODAMT = POFSAD
003200160608     C                   when      pofsap <> 0
003300160608     C                   eval      PODAMT = POFSAP
003400160608     C                   when      pofsat <> 0
003500160608     C                   eval      PODAMT = POFSAT
003600160608     C                   endsl
003700160608     C                   end
003800160608
003900110906    ?C                   Update    WEBPAYONR                            99      ADD RECORD
004000110621     C                   Exsr      SENDPAYROLL
004100110906     C                   End
004200110621    ? *___________________________________________________________________
004300110621    ? * Send to Payroll
004400110621    ? *___________________________________________________________________
004500110621    ?C     SENDPAYROLL   Begsr                                                  CHANGE RECORD
004600110622     C                   Call      'SNDONDCL'
004700110621     C                   Parm                    WUDTA
004800110621    ?C                   Endsr                                                  END ADD
