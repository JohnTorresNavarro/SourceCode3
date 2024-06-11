000100000000      *_________________________________________________________________________
000200000000      *
000300010226      *  Description:  Internal Sales Commissions Salesman Report
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700010226      *    Created by:  JALLEN - February 26, 2001
000800000000      *_________________________________________________________________________
000900010226     FISCRPT    IP   E           k Disk
001000010226     FPRTISCSP  O    E             Printer oflind(*IN91)
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
002800010226
002900010201     D                UDS
003000010226     D  WNAME                201    240
003100010201
003200010226     IISCRPTR       01
003300010226     I                                          IRSMAN        L7
003400010226     I                                          IRAGNY        L6
003500010226     I                                          IRTRST        L5
003600010316gsp  I                                          IRSUB#        L5
003700010316     I                                          IRACCT        L5
003800010201      *
003900010226     C   L6              Exsr      AgencyBreak
004000010226     C   L5              Exsr      AccountBreak
004100010201     C   01              Exsr      CheckOverflow
004200010201     C   01              Exsr      PrintDetail
004300010226     CL5                 Exsr      AccountTotal
004400010226     CL6                 Exsr      AgencyTotal
004500010226     CL7                 Exsr      SalesmanTotal
004600010226      *___________________________________________________________________
004700010226      * Agency Break
004800010226      *___________________________________________________________________
004900010226     C     AgencyBreak   BEGSR
005000010226     C                   Move      *on           *In91
005100010226     C                   Exsr      CheckOverflow
005200010226     C                   ENDSR
005300010201      *___________________________________________________________________
005400010201      * Account Break
005500010201      *___________________________________________________________________
005600010201     C     AccountBreak  BEGSR
005700010201     C                   Exsr      CheckOverflow
005800010201     C                   Write     PRTACH
005900010201     C                   ENDSR
006000010201      *___________________________________________________________________
006100010201      * Print Detail
006200010201      *___________________________________________________________________
006300010201     C     PrintDetail   BEGSR
006400010201     C                   Exsr      CheckOverflow
006500010226     C     WWEFDT        Mult      10000.0001    WPEFDT
006600010201     C                   Write     PRTDTL
006700010201     C                   Exsr      AccumDetail
006800010201     C                   ENDSR
006900010201      *___________________________________________________________________
007000010201      * Accumulate Detail
007100010201      *___________________________________________________________________
007200010201     C     AccumDetail   BEGSR
007300010226     C                   Eval      W1#CNT   =    W1#CNT + IR#CNT
007400010226     C                   Eval      W1PPRM   =    W1PPRM + IRPAID
007500010226     C                   Eval      W1INCR   =    W1INCR + IRINCR
007600010226     C                   Eval      W1COMM   =    W1COMM + IRINSP
007700010226     C                   Eval      W2#CNT   =    W2#CNT + IR#CNT
007800010226     C                   Eval      W2PPRM   =    W2PPRM + IRPAID
007900010226     C                   Eval      W2INCR   =    W2INCR + IRINCR
008000010226     C                   Eval      W2COMM   =    W2COMM + IRINSP
008100010226     C                   Eval      W3#CNT   =    W3#CNT + IR#CNT
008200010226     C                   Eval      W3PPRM   =    W3PPRM + IRPAID
008300010226     C                   Eval      W3INCR   =    W3INCR + IRINCR
008400010226     C                   Eval      W3COMM   =    W3COMM + IRINSP
008500010201      *
008600010204      * Salesman Break
008700010201     C                   z-add     1             pos               3 0
008800010226     C     IRCARR        Lookup    car(pos)                               80
008900010201     C                   If        %Equal
009000010226     C                   Eval      nbr(pos) =    nbr(pos) + IR#CNT
009100010226     C                   Eval      pre(pos) =    pre(pos) + IRPAID
009200010226     C                   Eval      inc(pos) =    inc(pos) + IRINCR
009300010226     C                   Eval      com(pos) =    com(pos) + IRINSP
009400010201     C                   Else
009500010201     C                   Eval      Pos      =    Last + 1
009600010226     C                   Eval      car(pos) =    IRCARR
009700010226     C                   Eval      cad(pos) =    IRCARD
009800010226     C                   Eval      nbr(pos) =    nbr(pos) + IR#CNT
009900010226     C                   Eval      pre(pos) =    pre(pos) + IRPAID
010000010226     C                   Eval      inc(pos) =    inc(pos) + IRINCR
010100010226     C                   Eval      com(pos) =    com(pos) + IRINSP
010200010201     C                   Z-add     Pos           Last              3 0
010300010201     C                   End
010400010201      *
010500010201     C                   ENDSR
010600010201      *___________________________________________________________________
010700010201      * Account Total
010800010201      *___________________________________________________________________
010900010201     C     AccountTotal  BEGSR
011000010201     C                   If        *In91    =   *On
011100010201     C                   Exsr      CheckOverflow
011200010201     C                   Write     PRTACH
011300010201     C                   Endif
011400010226     C                   Write     PRTDTT
011500010226     C                   Eval      W1#CNT   =    0
011600010226     C                   Eval      W1PPRM   =    0
011700010226     C                   Eval      W1INCR   =    0
011800010226     C                   Eval      W1COMM   =    0
011900010201     C                   ENDSR
012000010201      *___________________________________________________________________
012100010226      * Agency Total
012200010201      *___________________________________________________________________
012300010226     C     AgencyTotal   BEGSR
012400010201     C                   Exsr      CheckOverflow
012500010226     C                   Write     PRTDAT
012600010226     C                   Eval      W2#CNT   =    0
012700010201     C                   Eval      W2PPRM   =    0
012800010226     C                   Eval      W2INCR   =    0
012900010226     C                   Eval      W2COMM   =    0
013000010201     C                   ENDSR
013100010201      *___________________________________________________________________
013200010201      * Salesman Total
013300010201      *___________________________________________________________________
013400010201     C     SalesmanTotal BEGSR
013500010201     C                   Exsr      CheckOverflow
013600010201     C                   Write     PRTDST
013700010226     C                   Eval      W3#CNT   =    0
013800010201     C                   Eval      W3PPRM   =    0
013900010226     C                   Eval      W3INCR   =    0
014000010226     C                   Eval      W3COMM   =    0
014100010201     C                   Move      *on           *In91
014200010201     C                   Exsr      CheckOverflow
014300010201     C                   Write     PRTSBC
014400010227     C                   sorta     ary
014500010227     C                   Eval      Elements =    %elem(ary)
014600010227     C                   Do        elements      pos
014700010201     C                   Eval      W4CARR   =    car(pos)
014800010201     C                   Eval      W4CNAM   =    cad(pos)
014900010226     C                   z-add     nbr(pos)      W4#CNT
015000010201     C                   z-add     pre(pos)      W4PPRM
015100010226     C                   z-add     inc(pos)      W4INCR
015200010226     C                   z-add     com(pos)      W4COMM
015300010227     C                   If        car(pos) <> *Blanks
015400010201     C                   Write     PRTSBD
015500010227     C                   End
015600010226     C                   Eval      W5#CNT   =    W5#CNT + W4#CNT
015700010201     C                   Eval      W5PPRM   =    W5PPRM + W4PPRM
015800010226     C                   Eval      W5INCR   =    W5INCR + W4INCR
015900010226     C                   Eval      W5COMM   =    W5COMM + W4COMM
016000010201     C                   Enddo
016100010201     C                   Write     PRTSBT
016200010226     C                   Eval      W4#CNT   =    0
016300010201     C                   Eval      W4PPRM   =    0
016400010226     C                   Eval      W4INCR   =    0
016500010226     C                   Eval      W4COMM   =    0
016600010226     C                   Eval      W5#CNT   =    0
016700010201     C                   Eval      W5PPRM   =    0
016800010226     C                   Eval      W5INCR   =    0
016900010226     C                   Eval      W5COMM   =    0
017000010201     C                   Eval      Last     =    0
017100010201     C                   Clear                   car
017200010201     C                   Clear                   cad
017300010201     C                   Clear                   nbr
017400010201     C                   Clear                   pre
017500010201     C                   Clear                   com
017600010226     C                   Clear                   inc
017700010201     C                   ENDSR
017800010201      *___________________________________________________________________
017900000000      * Key Lists
018000000000      *___________________________________________________________________
018100000000     C     KLIST         BEGSR
018200000000     C                   ENDSR
018300010201      *___________________________________________________________________
018400010201      * Check Overflow - Print Header
018500010201      *___________________________________________________________________
018600010201     C     CheckOverflow BEGSR
018700010201     C                   If        *in91  = *on
018800010226     C     IREFDT        Mult      10000.0001    WDATE
018900010201     C                   Write     PRTHDR
019000010201     C                   Move      *off          *In91
019100010201     C                   End
019200010201     C                   ENDSR
019300010201      *___________________________________________________________________
019400010201      * Program Open
019500010201      *___________________________________________________________________
019600010201     C     *INZSR        BEGSR
019700010201     C                   Move      *on           *In91
019800010201     C                   ENDSR
