000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Broker Carrier Grouper Summery load
000400000000      *
000500000000      *  (c)Copyright 2005 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 18, 2005
000800000000      *_________________________________________________________________________
000900050218     FACCMST    IP   E           K DISK
001000050218
001100050218     D DTA           E DS                  EXTNAME(ACCMST)
001200050218
001300050218     IACCMSR        01
001400050218     I                                          ACTRST        L2
001500050218     I                                          ACSUB#        L2
001600050218     I                                          ACACCT        L2
001700050218
001800050218     C   L2              exsr      Account
001900050218      *
002000050218      * Process Account
002100050218     C     Account       Begsr
002200050316     C                   call      'PHNSUMR'
002300050218     C                   parm                    dta
002400050218     C                   Endsr
002500050218      *
