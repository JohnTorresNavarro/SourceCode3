000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Remove current records
000400000000      *
000500000000      *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - August 31, 2004
000800000000      *_________________________________________________________________________
000900040831     FISCRPTCUR UP   E           K DISK
001000040831     FISCRPTPRV IF   E           K DISK    Prefix(X_) rename(ISCRPTR:PRVR)
001100040831     D WDATE           S                   LIKE(IREFDT) INZ
001200040831     C     *ENTRY        PLIST
001300040831     C                   PARM                    WIDATE1           8
001400040831     C                   MOVE      WIDATE1       WDATE
001500040831     C     KEY           Setll     ISCRPTPRV
001600040831     C                   If        %Equal(ISCRPTPRV)
001700040831     C                   Delete    ISCRPTR
001800040831     C                   End
001900040831     C     KEY           KLIST
002000040831     C                   KFLD                    WDATE
002100040901     C                   KFLD                    IRSMAN
002200040831     C                   KFLD                    IRTRST
002300040831     C                   KFLD                    IRSUB#
002400040831     C                   KFLD                    IRACCT
002500040831     C                   KFLD                    IRPLAN
