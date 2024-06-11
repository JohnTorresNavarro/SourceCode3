000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900150721     FWEBPAYROLLIF   E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
001000150721
001100000000      * Program status data structure
001200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001300150721
001400150721     C     *Entry        Plist
001500150721     C                   Parm                    TRS               3
001600150721     C                   Parm                    SUB               3
001700150721     C                   Parm                    ACC               4
001800150721     C                   Parm                    FLG               1
001900150721
002000150721     C                   move      TRS           PYTRS
002100150721     C                   move      SUB           PYSUB
002200150721     C                   move      ACC           PYACT
002300150721
002400150721     C     paykey        setll     WEBPAYROLL
002500150721     C     paykey        reade     WEBPAYROLL
002600150721     C                   dow       not %eof(webpayroll)
002700150721     C                   eval      FLG = ' '
002800150721     C                   Return
002900150721     C     paykey        reade     WEBPAYROLL
003000150721     C                   enddo
003100150721
003200150721     C                   eval      FLG = 'C'
003300150721     C                   Return
003400000000      *___________________________________________________________________
003500000000      * Program open
003600000000      *___________________________________________________________________
003700000000     C     *INZSR        BEGSR
003800150721
003900150721     C     paykey        Klist
004000150721     C                   kfld                    PYTRS
004100150721     C                   kfld                    PYSUB
004200150721     C                   kfld                    PYACT
004300150721
004400000000     C                   ENDSR
004500000000      *___________________________________________________________________
004600000000      * Program error handler
004700000000      *___________________________________________________________________
004800000000     C     *PSSR         BEGSR
004900000000     C                   CALL      'SNDRPGM'                            50
005000000000     C                   PARM                    WQPGMN
005100000000     C                   PARM                    WQSTSC
005200000000     C                   PARM                    WQRPGS
005300000000     C                   PARM                    WQMSG
005400000000     C                   ENDSR     '*CANCL'
