000100000000      *_________________________________________________________________________
000200000000      *
000300010226      *  Description:  Internal Sales Commissions Salesman Report
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700010226      *    Created by:  JALLEN - February 26, 2001
000800000000      *_________________________________________________________________________
000900040831     FISCRPTCUR IP   E           k Disk
001000040831     FPRTISUSP  O    E             Printer oflind(*IN91)
001100010227
001200010227     D Elements        s              3  0 inz
001300010227
001400010227     D                 DS                           inz
0015000102270032 D ary                           77    Dim(200)                             carrier array
0016000102270032 D Car                            3    Overlay(ary)                         carrier array
0017000102270032 D cad                           40    Overlay(ary:*Next)                   carrier desc array
0018000102270032 D nbr                            7  2 Overlay(ary:*Next)                   members array
0019000102270032 D pre                            9  2 Overlay(ary:*Next)                   prem array
0020000102270032 D inc                            9  2 Overlay(ary:*Next)                   comm array
0021000102270032 D com                            9  2 Overlay(ary:*Next)                   comm array
002200010201
002300010226     D                 DS                           inz
002400010226     D  WWEFDT                 1      8  0
002500010226     D  IREIYY                 1      4  0
002600010226     D  IREIMM                 5      6  0
002700010226     D  IREIDD                 7      8  0
002800040901
002900040901     D                 DS
003000040915     D  WWACTN                 1     12
003100040901     D  IRTRST                 1      3  0
003200040901     D  D1                     4      5              inz('-')
003300040901     D  IRSUB#                 5      7  0
003400040901     D  D2                     8      8              inz('-')
003500040901     D  IRACCT                 9     12  0
003600010226
003700010201     D                UDS
003800010226     D  WNAME                201    240
003900010201
004000010226     IISCRPTR       01
004100010226     I                                          IRSMAN        L7
004200010226     I                                          IRAGNY        L6
004300010226     I                                          IRTRST        L5
004400010316gsp  I                                          IRSUB#        L5
004500010316     I                                          IRACCT        L5
004600010201      *
004700040901     C   L7              Exsr      SalesmBreak
004800040901     C** L5              Exsr      AccountBreak
004900010201     C   01              Exsr      CheckOverflow
005000010201     C   01              Exsr      PrintDetail
005100040901     C*5                 Exsr      AccountTotal
005200040901     C*6                 Exsr      AgencyTotal
005300040901     CL7                 Exsr      SalesmanTotal
005400010226      *___________________________________________________________________
005500040901      * Salesman Break
005600010226      *___________________________________________________________________
005700040901     C     SalesmBreak   BEGSR
005800040901     C                   Move      *on           *In91
005900040901     C                   Exsr      CheckOverflow
006000010226     C                   ENDSR
006100010201      *___________________________________________________________________
006200010201      * Account Break
006300010201      *___________________________________________________________________
006400010201     C     AccountBreak  BEGSR
006500040901     C                   Exsr      CheckOverflow
006600040901     C                   Write     PRTACH
006700010201     C                   ENDSR
006800010201      *___________________________________________________________________
006900010201      * Print Detail
007000010201      *___________________________________________________________________
007100010201     C     PrintDetail   BEGSR
007200010201     C                   Exsr      CheckOverflow
007300010226     C     WWEFDT        Mult      10000.0001    WPEFDT
007400040901     C                   Eval      WACTN = %trim(WWACTN) + '  ' +
007500040901     C                                     %trim(IRTSAD)
007600010201     C                   Write     PRTDTL
007700010201     C                   Exsr      AccumDetail
007800010201     C                   ENDSR
007900010201      *___________________________________________________________________
008000010201      * Accumulate Detail
008100010201      *___________________________________________________________________
008200010201     C     AccumDetail   BEGSR
008300081120     C***                Eval      W1#CNT   =    W1#CNT + IR#CNT
008400081120     C***                Eval      W1PPRM   =    W1PPRM + IRPAID
008500081120     C***                Eval      W1INCR   =    W1INCR + IRINCR
008600010226     C                   Eval      W1COMM   =    W1COMM + IRINSP
008700081120     C***                Eval      W2#CNT   =    W2#CNT + IR#CNT
008800081120     C***                Eval      W2PPRM   =    W2PPRM + IRPAID
008900081120     C***                Eval      W2INCR   =    W2INCR + IRINCR
009000010226     C                   Eval      W2COMM   =    W2COMM + IRINSP
009100081120     C***                Eval      W3#CNT   =    W3#CNT + IR#CNT
009200081120     C***                Eval      W3PPRM   =    W3PPRM + IRPAID
009300081120     C***                Eval      W3INCR   =    W3INCR + IRINCR
009400010226     C                   Eval      W3COMM   =    W3COMM + IRINSP
009500010201      *
009600010204      * Salesman Break
009700010201     C                   z-add     1             pos               3 0
009800010226     C     IRCARR        Lookup    car(pos)                               80
009900010201     C                   If        %Equal
010000010226     C                   Eval      nbr(pos) =    nbr(pos) + IR#CNT
010100010226     C                   Eval      pre(pos) =    pre(pos) + IRPAID
010200010226     C                   Eval      inc(pos) =    inc(pos) + IRINCR
010300010226     C                   Eval      com(pos) =    com(pos) + IRINSP
010400010201     C                   Else
010500010201     C                   Eval      Pos      =    Last + 1
010600010226     C                   Eval      car(pos) =    IRCARR
010700010226     C                   Eval      cad(pos) =    IRCARD
010800010226     C                   Eval      nbr(pos) =    nbr(pos) + IR#CNT
010900010226     C                   Eval      pre(pos) =    pre(pos) + IRPAID
011000010226     C                   Eval      inc(pos) =    inc(pos) + IRINCR
011100010226     C                   Eval      com(pos) =    com(pos) + IRINSP
011200010201     C                   Z-add     Pos           Last              3 0
011300010201     C                   End
011400010201      *
011500010201     C                   ENDSR
011600010201      *___________________________________________________________________
011700010201      * Account Total
011800010201      *___________________________________________________________________
011900010201     C     AccountTotal  BEGSR
012000010201     C                   If        *In91    =   *On
012100010201     C                   Exsr      CheckOverflow
012200010201     C                   Write     PRTACH
012300010201     C                   Endif
012400010226     C                   Write     PRTDTT
012500081120     C***                Eval      W1#CNT   =    0
012600081120     C***                Eval      W1PPRM   =    0
012700081120     C***                Eval      W1INCR   =    0
012800010226     C                   Eval      W1COMM   =    0
012900010201     C                   ENDSR
013000010201      *___________________________________________________________________
013100010226      * Agency Total
013200010201      *___________________________________________________________________
013300010226     C     AgencyTotal   BEGSR
013400010201     C                   Exsr      CheckOverflow
013500010226     C                   Write     PRTDAT
013600081120     C***                Eval      W2#CNT   =    0
013700081120     C***                Eval      W2PPRM   =    0
013800081120     C***                Eval      W2INCR   =    0
013900010226     C                   Eval      W2COMM   =    0
014000010201     C                   ENDSR
014100010201      *___________________________________________________________________
014200010201      * Salesman Total
014300010201      *___________________________________________________________________
014400010201     C     SalesmanTotal BEGSR
014500010201     C                   Exsr      CheckOverflow
014600010201     C                   Write     PRTDST
014700081120     C**                 Eval      W3#CNT   =    0
014800081120     C**                 Eval      W3PPRM   =    0
014900081120     C**                 Eval      W3INCR   =    0
015000010226     C                   Eval      W3COMM   =    0
015100010201     C                   Move      *on           *In91
015200010201     C                   Exsr      CheckOverflow
015300010201     C                   Write     PRTSBC
015400010227     C                   sorta     ary
015500010227     C                   Eval      Elements =    %elem(ary)
015600010227     C                   Do        elements      pos
015700010201     C                   Eval      W4CARR   =    car(pos)
015800010201     C                   Eval      W4CNAM   =    cad(pos)
015900081120     C***                z-add     nbr(pos)      W4#CNT
016000081120     C***                z-add     pre(pos)      W4PPRM
016100081120     C***                z-add     inc(pos)      W4INCR
016200010226     C                   z-add     com(pos)      W4COMM
016300010227     C                   If        car(pos) <> *Blanks
016400010201     C                   Write     PRTSBD
016500010227     C                   End
016600081120     C***                Eval      W5#CNT   =    W5#CNT + W4#CNT
016700081120     C***                Eval      W5PPRM   =    W5PPRM + W4PPRM
016800081120     C***                Eval      W5INCR   =    W5INCR + W4INCR
016900010226     C                   Eval      W5COMM   =    W5COMM + W4COMM
017000010201     C                   Enddo
017100010201     C                   Write     PRTSBT
017200081120     C***                Eval      W4#CNT   =    0
017300081120     C***                Eval      W4PPRM   =    0
017400081120     C***                Eval      W4INCR   =    0
017500010226     C                   Eval      W4COMM   =    0
017600081120     C***                Eval      W5#CNT   =    0
017700081120     C***                Eval      W5PPRM   =    0
017800081120     C***                Eval      W5INCR   =    0
017900010226     C                   Eval      W5COMM   =    0
018000010201     C                   Eval      Last     =    0
018100010201     C                   Clear                   car
018200010201     C                   Clear                   cad
018300010201     C                   Clear                   nbr
018400010201     C                   Clear                   pre
018500010201     C                   Clear                   com
018600010226     C                   Clear                   inc
018700010201     C                   ENDSR
018800010201      *___________________________________________________________________
018900000000      * Key Lists
019000000000      *___________________________________________________________________
019100000000     C     KLIST         BEGSR
019200000000     C                   ENDSR
019300010201      *___________________________________________________________________
019400010201      * Check Overflow - Print Header
019500010201      *___________________________________________________________________
019600010201     C     CheckOverflow BEGSR
019700010201     C                   If        *in91  = *on
019800010201     C                   Write     PRTHDR
019900010201     C                   Move      *off          *In91
020000010201     C                   End
020100010201     C                   ENDSR
020200010201      *___________________________________________________________________
020300010201      * Program Open
020400010201      *___________________________________________________________________
020500010201     C     *INZSR        BEGSR
020600040831     C     *Entry        Plist
020700040831     C                   Parm                    W1DATE            8
020800040831     C                   Parm                    W2DATE            8
020900040831     C                   move      W1DATE        WDATE             8 0
021000040831     C     WDATE         Mult      10000.0001    WDATE1
021100040831     C                   move      W2DATE        WDATE             8 0
021200040831     C     WDATE         Mult      10000.0001    WDATE2
021300010201     C                   Move      *on           *In91
021400010201     C                   ENDSR
