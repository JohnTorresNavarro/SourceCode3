000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900150721     FWEBPAYROLLUF   E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
000901151203     FACCMSP    UF   E           K DISK
001000151203     FWEBPAYCHP IF   E           K DISK
001100150721
001200150721     d payfreq         s              2s 0 inz
001300150721
001400000000      * Program status data structure
001500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001600150721
001700150721     C     *Entry        Plist
001800150721     C                   Parm                    TRS               3
001900150721     C                   Parm                    SUB               3
002000150721     C                   Parm                    ACC               4
002100150721
002200150721     C                   move      TRS           PYTRS
002300150721     C                   move      SUB           PYSUB
002400150721     C                   move      ACC           PYACT
002500150727
002600150727     C     paykey        chain     ACCMSP
002700150727     C                   if        %found(ACCMSP)
002800150727     C                   If        %trim(AMPAYR) = 'NPAY' or
002900150727     C                             %trim(AMPAYR) = 'PAYR'
003000150727     C                   eval      AMPAYR = *blanks
003100150727     C                   update    ACCMSPR
003200150727     C                   End
003300150727     C                   End
003400150721
003500150727     C                   If        AMPAYR = *blanks
003600150721     C     paykey        setll     WEBPAYROLL
003700150721     C     paykey        reade     WEBPAYROLL
003800150721     C                   dow       not %eof(webpayroll)
003900150721
004000150721     C                   If        PYANS = *zeros
004001151203
004002151203     C                   exsr      getpayfrq
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
006500150721
006600150721     C                   update    webpayr
006700150721
006800150721     C                   End
006900150721
007000150721     C     paykey        reade     WEBPAYROLL
007100150721     C                   enddo
007200150727     C                   End
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
007419151203
007420151203     C                   ENDSR
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
