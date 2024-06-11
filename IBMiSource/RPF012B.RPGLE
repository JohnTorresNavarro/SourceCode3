000100000407    ? *  COMPILE:
000200991101    ? *    OVRDBF     FILE(RPF050) TOFILE(HIST)
000300000000    ? *    CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DBGVIEW(*SOURCE)
000400000000    ? *_________________________________________________________________________
000500000000    ? *
000600991104    ? *  Description:  ID Card Print - File Build
000700000000    ? *
000800000000    ? *  (c)Copyright 1999 by Inovative Outsourcing, Inc.
000900000000    ? *  This document contains restricted materials of IO, Inc.
001000000000    ? *
001100991104    ? *  Note:  Key to IDCARDPF is by IFORM, SSN. (Sort order)
001200991102    ? *
001300000000    ? *  History:
001400000000    ? *_________________________________________________________________________
001500991104    ?FMEMBER    IF   E           K DISK    rename(membr:memi)
001600991230    ?FMEMACC    IF   E           K DISK    rename(membr:mema)
001700000615    ?FRPF050    IF A E           K DISK
001800991104    ? *
001900991105    ?D                 DS                                                       DB020
002000991105    ?D  SocSec                 1      9  0
002100991104    ?D                 DS                                                       DB020
002200991104    ?D  ACCTNO                 1     10  0
002300991104    ?D  Trst                   1      3  0
002400991104    ?D  Sub#                   4      6  0
002500991104    ?D  Acct                   7     10  0
002600991105    ?D                 DS                                                       DB020
002700991105    ?D  HKEY                   1     10
002800991105    ?D  MbSSNo                 2     10  0
002900980126    ? *
003000991104    ?C     *Entry        Plist
003100991105    ?C                   Parm                    WiSSN             9
003200991104    ?C                   Parm                    WiACC            10
003300991104    ?C                   Parm                    WiTYP             1
003400991105    ? *
003500991105    ?C     ' ':'0'       Xlate     WiSSN         wiSSN
003600991105    ?C     ' ':'0'       Xlate     WiACC         wiACC
003700991104    ? *
003800991104B001?C                   Select
003900991104 001? * By Individual
004000991104 001?C                   When      WiTyp = 'I'
004100991105 001?C                   Move      WiSSN         SocSec
004200991105 001?C     SocSec        Chain     Memi                               50
004300000615     C     HKEY          Chain(n)  RPF050
004400000615     C                   If        not %found
004500991104 001?C                   Write     HistR
004600000615     C                   End
004700991104 001? * By Account
004800991104 001?C                   When      WiTyp = 'A'
004900991104 001?C                   Move      WiAcc         AcctNo
005000991104 001?C                   Eval      WkTrst = Trst
005100991104 001?C                   Eval      WkSub# = Sub#
005200991104 001?C                   Eval      WkAcct = Acct
005300991230     C                   Select
005400991230 001? * By Trust.
005500991230     C                   When      WkTrst  <>    *Zeros
005600991230     C                             and WkSub# =  *Zeros
005700991230     C                             and WkAcct =  *Zeros
005800991230 001?C     WkAcc1        Setll     Mema
005900991230 001?C     WkAcc1        Reade     Mema                                   50
006000991230B002?C     *IN50         Doweq     *OFF
006100991230 002?C                   Write     HistR
006200991230 002?C     WkAcc1        Reade     Mema                                   50
006300991230E002?C                   Enddo
006400991230 001? * By Trust,Divistion.
006500991230     C                   When      WkTrst  <>    *Zeros
006600991230     C                             and WkSub# <> *Zeros
006700991230     C                             and WkAcct =  *Zeros
006800991230 001?C     WkAcc2        Setll     Mema
006900991230 001?C     WkAcc2        Reade     Mema                                   50
007000991230B002?C     *IN50         Doweq     *OFF
007100991230 002?C                   Write     HistR
007200991230 002?C     WkAcc2        Reade     Mema                                   50
007300991230E002?C                   Enddo
007400991230 001? * By Account.
007500991230     C                   Other
007600991230 001?C     WkAcc3        Setll     Mema
007700991230 001?C     WkAcc3        Reade     Mema                                   50
007800991104B002?C     *IN50         Doweq     *OFF
007900991104 002?C                   Write     HistR
008000991230 002?C     WkAcc3        Reade     Mema                                   50
008100991104E002?C                   Enddo
008200991230     C                   Endsl
008300991104 001? *
008400991104 001?C                   Other
008500991104E001?C                   Endsl
008600991104    ? *
008700991104    ?C                   Move      *on           *inlr
008800991102    ? *-------------------------------------------------------------------*
008900991104    ? * Definitions
009000991102    ? *-------------------------------------------------------------------*
009100991104    ?C     Defn          Begsr
009200991102    ? *
009300991104    ?C     *like         Define    MbTrst        WkTrst
009400991104    ?C     *like         Define    MbSub#        WkSub#
009500991104    ?C     *like         Define    MbAcct        WkAcct
009600991104    ? *
009700991230    ?C     WkAcc1        Klist
009800991104    ?C                   Kfld                    WkTrst
009900991230    ? *
010000991230    ?C     WkAcc2        Klist
010100991230    ?C                   Kfld                    WkTrst
010200991230    ?C                   Kfld                    WkSub#
010300991230    ? *
010400991230    ?C     WkAcc3        Klist
010500991230    ?C                   Kfld                    WkTrst
010600991230    ?C                   Kfld                    WkSub#
010700991230    ?C                   Kfld                    WkAcct
010800991102    ? *
010900991102    ?C                   Endsr
