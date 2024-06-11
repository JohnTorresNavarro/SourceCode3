000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900150727     FWEBPAYROLLIF   E           K DISK    EXTFILE('RPGSPPAYR/WEBPAYROLL')
001000150727     FWEBPAYNONPIF   E           K DISK    EXTFILE('RPGSPPAYR/WEBPAYNONP')
001100150727     F                                     rename(WEBPAYR:WEBNONR)
001200150721
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001500150721
001600150721     C     *Entry        Plist
001700150721     C                   Parm                    TRS               3
001800150721     C                   Parm                    SUB               3
001900150721     C                   Parm                    ACC               4
002000150721     C                   Parm                    FLG               1
002100150721
002200150721     C                   move      TRS           PYTRS
002300150721     C                   move      SUB           PYSUB
002400150721     C                   move      ACC           PYACT
002500150721
002600150721     C     paykey        setll     WEBPAYROLL
002700150721     C     paykey        reade     WEBPAYROLL
002800150721     C                   dow       not %eof(webpayroll)
002900150727     C                   eval      FLG = 'P'
002901151120     C                   Return
003000150721     C     paykey        reade     WEBPAYROLL
003100150721     C                   enddo
003200150727
003300150727     C     paykey        setll     WEBPAYNONP
003400150727     C     paykey        reade     WEBPAYNONP
003500150727     C                   dow       not %eof(webpaynonp)
003600150727     C                   eval      FLG = 'N'
003601151120     C                   Return
003700150727     C     paykey        reade     WEBPAYNONP
003800150727     C                   enddo
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
