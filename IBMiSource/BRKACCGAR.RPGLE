000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Broker Carrier Grouper Summery load
000400000000      *
000500000000      *  (c)Copyright 2005 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 18, 2005
000800000000      *_________________________________________________________________________
000900050302     FACCMSTP   IP   E           K DISK
001000050218
001100080102     D BRANGE          S               D   DATFMT(*ISO) INZ(D'2007-01-01')
001200080102     D ERANGE          S               D   DATFMT(*ISO) INZ(D'2007-12-31')
001300050302     D DTA           E DS                  EXTNAME(ACCMSTP)
001400050218
001500050302     IACCMSTR       01
001600050302     I                                          ADACCT        L2
001700050218
001800050218     C   L2              exsr      Account
001900050218      *
002000050218      * Process Account
002100050218     C     Account       Begsr
002200050302     C                   If        ADGEFD >= BRANGE and
002300050302     C                             ADGEFD <= ERANGE
002400050302     C                   call      'BRKSUMGAR'
002500050218     C                   parm                    dta
002600050302     C                   End
002700050218     C                   Endsr
002800050218      *
