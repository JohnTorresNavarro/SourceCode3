000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for 8+9 starting today
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 28, 2015
000800000000      *_________________________________________________________________________
000900150728     FACCOSP    IP   E           K DISK
001000150728
001100150728     D TRS             s              3a   inz
001200150728     D SUB             s              3a   inz
001300150728     D ACC             s              4a   inz
001400150728
001500150728     D Today           s              8S 0 inz
001600150728     D Tomorrow        s              8S 0 inz
001700150728    ?D  TodayISO       S               D   datfmt(*ISO)
001800150728
001900000000      * Program status data structure
002000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100150728
002200150728      * If starting 8 or 9 tomorrow, copy the screen 1+2 info to dash
002300150728     C                   If        AOBEDT = Tomorrow
002400150728     C                   If        AOCODE = 08 or
002500150728     C                             AOCODE = 09
002600150728     C                   move      AOTRST        TRS
002700150728     C                   move      AOSUB#        SUB
002800150728     C                   move      AOACCT        ACC
002900160225     C                   call      'PWPAYROLLT'
003000150728     C                   parm                    TRS
003100150728     C                   parm                    SUB
003200150728     C                   parm                    ACC
003300150728     C                   End
003400150728     C                   End
003500150728
003600000000      *___________________________________________________________________
003700000000      * Key Lists
003800000000      *___________________________________________________________________
003900000000     C     KLIST         BEGSR
004000000000     C                   ENDSR
004100000000      *___________________________________________________________________
004200000000      * Program open
004300000000      *___________________________________________________________________
004400000000     C     *INZSR        BEGSR
004500150728     C                   eval      Today  = %int(%char(%date : *iso0))
004600150728     C     *ISO          Move      Today         TodayISO
004700150728     C                   adddur    1:*D          TodayISO
004800150728     C     *ISO          Move      TodayISO      Tomorrow
004900000000     C                   ENDSR
005000000000      *___________________________________________________________________
005100000000      * Program error handler
005200000000      *___________________________________________________________________
005300000000     C     *PSSR         BEGSR
005400000000     C                   CALL      'SNDRPGM'                            50
005500000000     C                   PARM                    WQPGMN
005600000000     C                   PARM                    WQSTSC
005700000000     C                   PARM                    WQRPGS
005800000000     C                   PARM                    WQMSG
005900000000     C                   ENDSR     '*CANCL'
