000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *_________________________________________________________________________
000400141211     FMCOV      IF   E           K DISK    extfile('F.MCOV') rename(mcovr:mcor)
000500141211     F                                     Prefix(D_)
000600040416      *
000700040416     D W90DATE1        S               d   datfmt(*ISO)
000800040416     D W90DATE2        S               d   datfmt(*ISO)
000900040416     D W90DAYS         S              5S 0 inz
001000041202     D WWDATE          S              8S 0 inz
001100041202     D COUNT           S              2S 0 inz
001200090430     D COUNTT          S              2S 0 inz
001300090331     D Pos             s              2S 0 inz
001400091112     D X               s              2S 0 inz
001500091112     D W_CAT           s              3    inz
001600091124     D TSENT           s              1A   inz
001700090408      *
001800141211     D X_xxxx        E DS                  EXTNAME(DW310PF) inz
001900130618     D X_DS310JF     E DS                  EXTNAME(DW310JF) inz
002000090430     D W_MCOV        E DS                  EXTNAME(MCOV) Prefix(W_) inz
002100090331      *
002200090331     D W_PLANS         DS                  OCCURS(20)
002300090331     D APLN                    1     80A   DIM(20)
002400021203      *
002500130618     I*OINR         01
002600130618     I*                                         SOCSOC        L4
002700130618     I*                                         PLAN#         L2
002800090331      *
002900141211      *
003000141211     C                   Eval      TRUST = 507
003100141211     C                   Eval      SUBNO = 005
003200141211     C                   Eval      PLAN# = 'TABL'
003300141211     C                   Eval      SOCSOC = 172689792
003400090331      *
003500141211     C                   Exsr      doublechk
003600130618      *
003700130618     C                   Eval      *inlr = *on
003800130618     C                   Return
003900091124      *-------------------------------------------------------------*
004000141211     C     doublechk     Begsr
004100141211      *-------------------------------------------------------------*
004200141211
004300141211      * we are looking for another term where selected effective
004400141211      * date is within another records range (weird situation)
004500141211
004600141211     C     dblkey        klist
004700141211     C                   kfld                    socsoc
004800141211
004900141211     C     dblkey        Setgt     MCOV
005000141211     C     dblkey        Readpe    MCOV                                   52
005100141211     C     *IN52         Doweq     *OFF
005200141211      *
005300141211     C                   Eval      DWPLAN = D_MCPLAN
005400141211     C                   Eval      DWENRL = D_ENRLDT
005500141211     C                   Eval      DWCAND = D_CANDT
005600141211     C                   Eval      DWACCT = D_ACC#
005700141211     C                   Eval      DWCOVT = D_MCOVTP
005800141211      *
005900141211     C     dblkey        Readpe    MCOV                                   50
006000141211     C                   Enddo
006100141211
006200141211     C                   Endsr
006300090331      *-------------------------------------------------------------*
