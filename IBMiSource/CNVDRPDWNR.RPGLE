000100160804     H ALWNULL(*USRCTL)
000200000000      *_________________________________________________________________________
000300000000      *
000400160804      *  Description:  Convert EDTIN to dropdown file
000500000000      *
000600160804      *  (c)Copyright 2016 by GBS, Inc.
000700000000      *
000800160804      *    Created by:  JALLEN - Aug 04, 2016
000900000000      *_________________________________________________________________________
001000160804     FEDTIN     IF   E           K Disk
001100160804     FWEBPAYCHP IF A E           K Disk
001200160726
001300160804     D  lowtrs         s              3s 0 inz
001400160725     D  pos            s              3s 0 inz
001500160804     D  w80date        S              8S 0
001600160804     D Tic             s              1a   inz(x'7D')
001700160725
001800000000      * Program status data structure
001900000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000160725
002100160804     C     lowtrs        setll     EDTIN
002200160804     C                   read      EDTIN
002300160804     C                   dow       not %eof(EDTIN)
002400160804
002500160804      * hide the salary
002600160804     C                   clear                   webpaychr
002700160804     C                   eval      pcseq# = 0
002800160804     C                   eval      pcgrpr = 'SCR1SALARY'
002900160804     C                   eval      pccode = '*ALL'
003000160804     C     PYCHP         Chain     webpaychp
003100160804     C                   If        not %found(webpaychp)
003200160804     C                   eval      pcseq# = pcseq# + 10
003300160804     C                   eval      PCTRST = XTRUST
003400160804     C                   eval      PCSUB# = XSUB
003500160804     C                   eval      PCACCT = XACCT
003600160804     C                   eval      pcgrpr = 'SCR1SALARY'
003700160804     C                   eval      pccode = '*ALL'
003800160804     C                   eval      pcdesc = 'Hide the Salary'
003900160804     C                   write     webpaychr
004000160804     C                   End
004100160725
004200160804      * Default to Rule 1
004300160804     C                   clear                   webpaychr
004400160804     C                   eval      pcseq# = 0
004500160804     C                   eval      pcgrpr = 'RULE'
004600160804     C                   eval      pccode = '1'
004700160804     C     PYCHP         Chain     webpaychp
004800160804     C                   If        not %found(webpaychp)
004900160804     C                   eval      pcseq# = pcseq# + 10
005000160804     C                   eval      PCTRST = XTRUST
005100160804     C                   eval      PCSUB# = XSUB
005200160804     C                   eval      PCACCT = XACCT
005300160804     C                   eval      pcgrpr = 'RULE'
005400160804     C                   eval      pccode = '1'
005500160804     C                   eval      pcdesc = 'All Eligible EE' + tic + 's'
005600160804     C                   write     webpaychr
005700160804     C                   End
005800160804
005900160804      * hide cost
006000160804     C                   clear                   webpaychr
006100160804     C                   eval      pcseq# = 0
006200160804     C                   eval      pcgrpr = 'HIDE COLMN'
006300160804     C                   eval      pccode = 'MONTH_EMPE_COST'
006400160804     C     PYCHP         Chain     webpaychp
006500160804     C                   If        not %found(webpaychp)
006600160804     C                   eval      pcseq# = pcseq# + 10
006700160804     C                   eval      PCTRST = XTRUST
006800160804     C                   eval      PCSUB# = XSUB
006900160804     C                   eval      PCACCT = XACCT
007000160804     C                   eval      pcgrpr = 'HIDE COLMN'
007100160804     C                   eval      pccode = 'MONTH_EMPE_COST'
007200160804     C                   eval      pcdesc = 'Hide employee cost'
007300160804     C                   write     webpaychr
007400160804     C                   End
007500160804
007600160804      * hide cost
007700160804     C                   clear                   webpaychr
007800160804     C                   eval      pcseq# = 0
007900160804     C                   eval      pcgrpr = 'HIDE COLMN'
008000160804     C                   eval      pccode = 'MONTH_EMPR_COST'
008100160804     C     PYCHP         Chain     webpaychp
008200160804     C                   If        not %found(webpaychp)
008300160804     C                   eval      pcseq# = pcseq# + 10
008400160804     C                   eval      PCTRST = XTRUST
008500160804     C                   eval      PCSUB# = XSUB
008600160804     C                   eval      PCACCT = XACCT
008700160804     C                   eval      pcgrpr = 'HIDE COLMN'
008800160804     C                   eval      pccode = 'MONTH_EMPR_COST'
008900160804     C                   eval      pcdesc = 'Hide employer cost'
009000160804     C                   write     webpaychr
009100160804     C                   End
009200160804
009300160804      * hide cost
009400160804     C                   clear                   webpaychr
009500160804     C                   eval      pcseq# = 0
009600160804     C                   eval      pcgrpr = 'HIDE COLMN'
009700160804     C                   eval      pccode = 'PER_PAY_DEDUCT'
009800160804     C     PYCHP         Chain     webpaychp
009900160804     C                   If        not %found(webpaychp)
010000160804     C                   eval      pcseq# = pcseq# + 10
010100160804     C                   eval      PCTRST = XTRUST
010200160804     C                   eval      PCSUB# = XSUB
010300160804     C                   eval      PCACCT = XACCT
010400160804     C                   eval      pcgrpr = 'HIDE COLMN'
010500160804     C                   eval      pccode = 'PER_PAY_DEDUCT'
010600160804     C                   eval      pcdesc = 'Hide per-pay deduction'
010700160804     C                   write     webpaychr
010800160804     C                   End
010900160804
011000160804     C                   read      EDTIN
011100160725     C                   enddo
011200160725
011300160725     C                   eval      *inlr = *on
011400160725     C                   return
011500160804
011600160804     C     PYCHP         Klist
011700160804     C                   Kfld                    XTRUST
011800160804     C                   Kfld                    XSUB
011900160804     C                   Kfld                    XACCT
012000160804     C                   Kfld                    PCGRPR
012100160804     C                   Kfld                    PCCODE
