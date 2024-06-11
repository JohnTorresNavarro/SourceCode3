000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check ISC Manager
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 22, 2002
000800000000      *_________________________________________________________________________
000900040730     FISCSM2    if   e           k Disk
001000020222
001100040730    ?D WIDATA        E DS                  EXTNAME(ISCSM2)
001200020222
001300020222     C     *Entry        Plist
001400090122     C                   Parm                    WISMAN           10
001500020222     C                   Parm                    WIDATE            8 0
001600020222     C                   Parm                    WIDATA
001700020222     C                   Parm                    WIRTN             1
001800020222
001900020222      * Reset Return Code
002000020222     C                   Eval      WIRTN   =  'N'
002100040730     C                   Exsr      CHECK
002200040730
002300040730      * Close files and exit.
002400040730     C                   Eval      *INLR = *ON
002500040730     C                   Return
002600020222
002700040730     C     CHECK         Begsr
002800020222      * Read Manager Salesman file.
002900040730     C     WISMAN        Setll     ISCSM2
003000040730     C     WISMAN        Reade     ISCSM2                                 77
003100020222     C                   Dow       *in77 = *off
003200020222
003300020222     C                   Select
003400020222     C                   When      ISEFDT <> *Zeros and
003500020222     C                             ISTRDT <> *Zeros
003600040730     C                   If        (WIDATE >= ISEFDT and
003700040730     C                             WIDATE <= ISTRDT) or
003800040730     C                             (WIDATE >= ISEFDT and
003900040730     C                             ISRUNO = 'Y')
004000020222     C                   Eval      WIRTN   =  'Y'
004100040730     C                   LeaveSR
004200020222     C                   End
004300020222
004400020222     C                   When      ISEFDT <> *Zeros and
004500020222     C                             ISTRDT =  *Zeros
004600020222     C                   If        WIDATE >= ISEFDT
004700020222     C                   Eval      WIRTN   =  'Y'
004800040730     C                   LeaveSR
004900020222     C                   End
005000020222     C                   Endsl
005100040730     C     WISMAN        Reade     ISCSM2                                 77
005200020222     C                   Enddo
005300040730     C                   Endsr
