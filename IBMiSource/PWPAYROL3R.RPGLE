000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900151120     FWEBPAYJON IP   E           K DISK    EXTFILE('RPGSPDASH/WEBPAYJON')
000901151120     F                                     rename(WEBPAYR:WEBNONR)
001000151120     FWEBPAYROLLIF a E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
001200150721
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001506151120
001507151120     C     paykey        chain     WEBPAYROLL
001508151120     C                   If        not %found(webpayroll)
002500151120     C                   write     WEBPAYR
003800151120     C                   end
003900150721
004000150721     C                   Return
004100000000      *___________________________________________________________________
004200000000      * Program open
004300000000      *___________________________________________________________________
004400000000     C     *INZSR        BEGSR
004500150721
004600150721     C     paykey        Klist
004700150721     C                   kfld                    PYTRS
004800150721     C                   kfld                    PYSUB
004900150721     C                   kfld                    PYACT
005000150721
005100000000     C                   ENDSR
005200000000      *___________________________________________________________________
005300000000      * Program error handler
005400000000      *___________________________________________________________________
005500000000     C     *PSSR         BEGSR
005600000000     C                   CALL      'SNDRPGM'                            50
005700000000     C                   PARM                    WQPGMN
005800000000     C                   PARM                    WQSTSC
005900000000     C                   PARM                    WQRPGS
006000000000     C                   PARM                    WQMSG
006100000000     C                   ENDSR     '*CANCL'
