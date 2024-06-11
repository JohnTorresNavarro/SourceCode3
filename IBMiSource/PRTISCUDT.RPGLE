000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Return Under/Over Dates in YYYYMMDD order
000400000000      *
000500000000      *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - August 31, 2004
000800000000      *___________________________________________________________________
000900040831     D WDATE1          S               d   datfmt(*ISO)
001000040831     D WDATE2          S               d   datfmt(*ISO)
001100040831     D WWDATE          S              8S 0 inz
001200040831     D WWMTH           S              1S 0 inz(1)
001300040831     C     *ENTRY        PLIST
001400040831     C                   PARM                    WIDATE            8
001500040831     C                   PARM                    W1DATE            8
001600040831     C                   PARM                    W2DATE            8
001700040831     C                   Move      WIDATE        WWDATE
001800040831     C     *ISO          Move      WWDATE        WDATE1
001900040831     C     WDATE1        Subdur    WWMTH:*m      WDATE2
002000040831     C                   Move      WDATE1        WWDATE
002100040831     C                   Move      WWDATE        W1DATE
002200040831     C                   Move      WDATE2        WWDATE
002300040831     C                   Move      WWDATE        W2DATE
002400040831     C                   Return
