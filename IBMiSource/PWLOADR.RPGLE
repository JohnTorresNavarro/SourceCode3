000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900151204     FWEBPAYROLLUF   E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
000901151204     FWEBPAYCHP IF   E           K DISK
001000151204     FMEMBER    IF   E           K DISK    extfile('QS36F/F.MEMBER')
001100150721
001200150721     d payfreq         s              2s 0 inz
001300150721
001400000000      * Program status data structure
001500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001600150721
002200151204     C                   eval      PYTRS = 591
002300151204     C                   eval      PYSUB = 006
002400151204     C                   eval      PYACT = 532
002500150727
002501151204     C     paykey        setll     WEBPAYROLL
002600151204     C     paykey        reade     WEBPAYROLL
002700151204     C                   dow       not %eof(webpayroll)
003900150721
003901151204     C                   exsr      getpayfrq
003902151204
004000150721     C                   If        PYANS = *zeros
004100150721
004200150721     C                   Select
004300150721     C                   When      %trim(PYPFQ) = 'WKY'
004400150721     C                   Eval      PAYFREQ = 52
004500150721     C                   When      %trim(PYPFQ) = 'BW1'
004600150721     C                   Eval      PAYFREQ = 26
004700150721     C                   When      %trim(PYPFQ) = 'SEM'
004800150721     C                   Eval      PAYFREQ = 24
004900150721     C                   When      %trim(PYPFQ) = 'MTH'
005000150721     C                   Eval      PAYFREQ = 12
005100150721     C                   When      %trim(PYPFQ) = 'QTR'
005200150721     C                   Eval      PAYFREQ = 04
005300150721     C                   Endsl
005400150721
005500150721     C                   Select
005600150721     C                   when      pysal <> *zeros
005700150721     C                   eval      pyans = pysal * payfreq
005800150728     C                   eval      pysal = *zeros
005900150721     C                   when      pyrat <> *zeros
006000150721     C                   eval      pyans = pyrat * pyhrs
006100150721     C                   eval      pyans = pyans * payfreq
006200150728     C                   eval      pyrat = *zeros
006300150728     C                   eval      pysal = *zeros
006400150721     C                   Endsl
006700150721
006800150721     C                   End
006801151204
006802151204     C                   update    webpayr
006900150721
007000150721     C     paykey        reade     WEBPAYROLL
007100150721     C                   enddo
007300150721
007400150721     C                   Return
007401151203      *___________________________________________________________________
007402151203      * Get payfreq
007403151203      *___________________________________________________________________
007404151203     C     GETPAYFRQ     BEGSR
007405151203
007406151203     C                   If        PYPFQ = *blanks
007407151203     C                   eval      PCGRPR = 'PAYFRQ'
007408151203     C     paychp        chain     WEBPAYCHP
007409151203     C                   if        %found(WEBPAYCHP)
007410151203     C                   eval      PYPFQ = %trim(PCCODE)
007411151203     C                   else
007412151203     C                   eval      PCGRPR = 'PAYFREQ'
007413151203     C     paychp        chain     WEBPAYCHP
007414151203     C                   if        %found(WEBPAYCHP)
007415151203     C                   eval      PYPFQ = %trim(PCCODE)
007416151203     C                   end
007417151203     C                   end
007418151203     C                   end
007419151204
007420151204     C                   eval      PCGRPR = 'RULE'
007421151204     C     paychp        chain     WEBPAYCHP
007422151204     C                   if        %found(WEBPAYCHP)
007423151204     C                   eval      PYBPC = %trim(PCCODE)
007424151204     C                   end
007425151204
007426151204     C     pyssn         chain     MEMBER
007427151204     C                   if        %found(MEMBER)
007428151204     C                   eval      pyans = salary
007429151204     C                   if        termdt <> 0
007430151204     C                   eval      PYSTS = 'T'
007431151204     C                   else
007432151204     C                   eval      PYPST = 'F'
007433151204     C                   eval      PYSTS = 'A'
007434151204     C                   end
007435151204     C                   end
007436151203
007437151203     C                   ENDSR
007500000000      *___________________________________________________________________
007600000000      * Program open
007700000000      *___________________________________________________________________
007800000000     C     *INZSR        BEGSR
007900150721
008000150721     C     paykey        Klist
008100150721     C                   kfld                    PYTRS
008200150721     C                   kfld                    PYSUB
008300150721     C                   kfld                    PYACT
008301151203
008302151203     C     paychp        Klist
008303151203     C                   kfld                    PYTRS
008304151203     C                   kfld                    PYSUB
008305151203     C                   kfld                    PYACT
008306151203     C                   kfld                    PCGRPR
008400150721
008500000000     C                   ENDSR
008600000000      *___________________________________________________________________
008700000000      * Program error handler
008800000000      *___________________________________________________________________
008900000000     C     *PSSR         BEGSR
009000000000     C                   CALL      'SNDRPGM'                            50
009100000000     C                   PARM                    WQPGMN
009200000000     C                   PARM                    WQSTSC
009300000000     C                   PARM                    WQRPGS
009400000000     C                   PARM                    WQMSG
009500000000     C                   ENDSR     '*CANCL'
