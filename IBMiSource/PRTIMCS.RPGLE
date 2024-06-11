000100000000      *_________________________________________________________________________
000200000000      *
000300010313      *  Description:  Internal Sales Commissions Manager Report
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700010226      *    Created by:  JALLEN - February 26, 2001
000800030709      *    JALLEN TEMP CHANGE for ZERO COMMISSION PRINTING. 07/09/2003
000900000000      *_________________________________________________________________________
001000010226     FISCRPT    IP   E           k Disk
001100020226     FISCPZC    IF   E           k Disk
001200010313     FPRTIMCSP  O    E             Printer oflind(*IN91)
001300010227
001400010227     D Elements        s              3  0 inz
001500020228     D AccBreak        s              1    inz
001600020228     D AgyBreak        s              1    inz
001700020228     D PZCPrinted      s              1    inz
001800020228     D PZCPrintedL6    s              1    inz
001900010227
002000010227     D                 DS                           inz
0021000102270032 D ary                           77    Dim(200)                             carrier array
0022000102270032 D Car                            3    Overlay(ary)                         carrier array
0023000102270032 D cad                           40    Overlay(ary:*Next)                   carrier desc array
0024000102270032 D nbr                            7  2 Overlay(ary:*Next)                   members array
0025000102270032 D pre                            9  2 Overlay(ary:*Next)                   prem array
0026000102270032 D inc                            9  2 Overlay(ary:*Next)                   comm array
0027000102270032 D com                            9  2 Overlay(ary:*Next)                   comm array
002800010201
002900010226     D                 DS                           inz
003000010226     D  WWEFDT                 1      8  0
003100010226     D  IREIYY                 1      4  0
003200010226     D  IREIMM                 5      6  0
003300010226     D  IREIDD                 7      8  0
003400010226
003500010201     D                UDS
003600010226     D  WNAME                201    240
003700010201
003800010226     IISCRPTR       01
003900010313     I                                          IRSMGR        L7
004000010226     I                                          IRAGNY        L6
004100010226     I                                          IRTRST        L5
004200020228gsp  I                                          IRSUB#        L5
004300020228     I                                          IRACCT        L5
004400010201      *
004500010226     C   L6              Exsr      AgencyBreak
004600010226     C   L5              Exsr      AccountBreak
004700010201     C   01              Exsr      PrintDetail
004800010226     CL5                 Exsr      AccountTotal
004900010226     CL6                 Exsr      AgencyTotal
005000010313     CL7                 Exsr      ManagerTotal
005100010226      *___________________________________________________________________
005200010226      * Agency Break
005300010226      *___________________________________________________________________
005400010226     C     AgencyBreak   BEGSR
005500020228     C                   Eval      AgyBreak = 'Y'
005600010226     C                   ENDSR
005700010201      *___________________________________________________________________
005800010201      * Account Break
005900010201      *___________________________________________________________________
006000010201     C     AccountBreak  BEGSR
006100020228     C                   Eval      AccBreak = 'Y'
006200010201     C                   ENDSR
006300010201      *___________________________________________________________________
006400010201      * Print Detail
006500010201      *___________________________________________________________________
006600010201     C     PrintDetail   BEGSR
006700020228     C                   If        IRINMP <> 0
006800020228     C                   If        AgyBreak = 'Y'
006900020228     C                   Move      *on           *In91
007000020228     C                   Exsr      CheckOverflow
007100020228     C                   Eval      AgyBreak = 'N'
007200020228     C                   End
007300020228     C                   If        AccBreak = 'Y'
007400020228     C                   Exsr      CheckOverflow
007500020228     C                   Write     PRTACH
007600020228     C                   Eval      AccBreak = 'N'
007700020228     C                   End
007800020228     C                   Exsr      CheckOverflow
007900010226     C     WWEFDT        Mult      10000.0001    WPEFDT
008000010201     C                   Write     PRTDTL
008100010201     C                   Exsr      AccumDetail
008200020226     C                   Else
008300020226     C     IRCARR        Chain     ISCPZC
008400020226     C                   If        %Found
008500020228     C                   Eval      PZCPrinted = 'Y'
008600020228     C                   If        AgyBreak = 'Y'
008700020228     C                   Move      *on           *In91
008800020228     C                   Exsr      CheckOverflow
008900020228     C                   Eval      AgyBreak = 'N'
009000020228     C                   End
009100020228     C                   If        AccBreak = 'Y'
009200020228     C                   Exsr      CheckOverflow
009300020228     C                   Write     PRTACH
009400020228     C                   Eval      AccBreak = 'N'
009500020228     C                   End
009600020228     C                   Exsr      CheckOverflow
009700020226     C     WWEFDT        Mult      10000.0001    WPEFDT
009800020226     C                   Write     PRTDTL
009900020226     C                   Exsr      AccumDetail
010000030709     C                   Else
010100030709     C                   If        AgyBreak = 'Y'
010200030709     C                   Move      *on           *In91
010300030709     C                   Exsr      CheckOverflow
010400030709     C                   Eval      AgyBreak = 'N'
010500030709     C                   End
010600030709     C                   If        AccBreak = 'Y'
010700030709     C                   Exsr      CheckOverflow
010800030709     C                   Write     PRTACH
010900030709     C                   Eval      AccBreak = 'N'
011000030709     C                   End
011100030709     C                   Exsr      CheckOverflow
011200030709     C     WWEFDT        Mult      10000.0001    WPEFDT
011300030709     C                   Write     PRTDTL
011400030709     C                   Exsr      AccumDetail
011500020226     C                   End
011600020226     C                   End
011700010201     C                   ENDSR
011800010201      *___________________________________________________________________
011900010201      * Accumulate Detail
012000010201      *___________________________________________________________________
012100010201     C     AccumDetail   BEGSR
012200010226     C                   Eval      W1#CNT   =    W1#CNT + IR#CNT
012300010226     C                   Eval      W1PPRM   =    W1PPRM + IRPAID
012400010226     C                   Eval      W1INCR   =    W1INCR + IRINCR
012500010313     C                   Eval      W1COMM   =    W1COMM + IRINMP
012600010226     C                   Eval      W2#CNT   =    W2#CNT + IR#CNT
012700010226     C                   Eval      W2PPRM   =    W2PPRM + IRPAID
012800010226     C                   Eval      W2INCR   =    W2INCR + IRINCR
012900010313     C                   Eval      W2COMM   =    W2COMM + IRINMP
013000010226     C                   Eval      W3#CNT   =    W3#CNT + IR#CNT
013100010226     C                   Eval      W3PPRM   =    W3PPRM + IRPAID
013200010226     C                   Eval      W3INCR   =    W3INCR + IRINCR
013300010313     C                   Eval      W3COMM   =    W3COMM + IRINMP
013400010201      *
013500010313      * Manager Break
013600010201     C                   z-add     1             pos               3 0
013700010226     C     IRCARR        Lookup    car(pos)                               80
013800010201     C                   If        %Equal
013900010226     C                   Eval      nbr(pos) =    nbr(pos) + IR#CNT
014000010226     C                   Eval      pre(pos) =    pre(pos) + IRPAID
014100010226     C                   Eval      inc(pos) =    inc(pos) + IRINCR
014200010313     C                   Eval      com(pos) =    com(pos) + IRINMP
014300010201     C                   Else
014400010201     C                   Eval      Pos      =    Last + 1
014500010226     C                   Eval      car(pos) =    IRCARR
014600010226     C                   Eval      cad(pos) =    IRCARD
014700010226     C                   Eval      nbr(pos) =    nbr(pos) + IR#CNT
014800010226     C                   Eval      pre(pos) =    pre(pos) + IRPAID
014900010226     C                   Eval      inc(pos) =    inc(pos) + IRINCR
015000010313     C                   Eval      com(pos) =    com(pos) + IRINMP
015100010201     C                   Z-add     Pos           Last              3 0
015200010201     C                   End
015300010201      *
015400010201     C                   ENDSR
015500010201      *___________________________________________________________________
015600010201      * Account Total
015700010201      *___________________________________________________________________
015800010201     C     AccountTotal  BEGSR
015900010201     C                   If        *In91    =   *On
016000010201     C                   Exsr      CheckOverflow
016100010201     C                   Write     PRTACH
016200010201     C                   Endif
016300020228     C                   If        W1COMM <> 0
016400010226     C                   Write     PRTDTT
016500010226     C                   Eval      W1#CNT   =    0
016600010226     C                   Eval      W1PPRM   =    0
016700010226     C                   Eval      W1INCR   =    0
016800010226     C                   Eval      W1COMM   =    0
016900020228     C                   Else
017000020228     C                   If        PZCPrinted = 'Y'
017100020228     C                   Write     PRTDTT
017200020228     C                   Eval      W1#CNT   =    0
017300020228     C                   Eval      W1PPRM   =    0
017400020228     C                   Eval      W1INCR   =    0
017500020228     C                   Eval      W1COMM   =    0
017600020228     C                   Eval      PZCPrinted = 'N'
017700020228     C                   Eval      PZCPrintedL6 = 'Y'
017800020228     C                   End
017900020228     C                   End
018000010201     C                   ENDSR
018100010201      *___________________________________________________________________
018200010226      * Agency Total
018300010201      *___________________________________________________________________
018400010226     C     AgencyTotal   BEGSR
018500010201     C                   Exsr      CheckOverflow
018600020228     C                   If        W2COMM <> 0
018700010226     C                   Write     PRTDAT
018800010226     C                   Eval      W2#CNT   =    0
018900010201     C                   Eval      W2PPRM   =    0
019000010226     C                   Eval      W2INCR   =    0
019100010226     C                   Eval      W2COMM   =    0
019200020228     C                   Else
019300020228     C                   If        PZCprintedL6 = 'Y'
019400020228     C                   Write     PRTDAT
019500020228     C                   Eval      W2#CNT   =    0
019600020228     C                   Eval      W2PPRM   =    0
019700020228     C                   Eval      W2INCR   =    0
019800020228     C                   Eval      W2COMM   =    0
019900020228     C                   Eval      PZCPrintedL6 = 'N'
020000020228     C                   End
020100020228     C                   End
020200010201     C                   ENDSR
020300010201      *___________________________________________________________________
020400010313      * Manager Total
020500010201      *___________________________________________________________________
020600010313     C     ManagerTotal  BEGSR
020700010201     C                   Exsr      CheckOverflow
020800010201     C                   Write     PRTDST
020900010226     C                   Eval      W3#CNT   =    0
021000010201     C                   Eval      W3PPRM   =    0
021100010226     C                   Eval      W3INCR   =    0
021200010226     C                   Eval      W3COMM   =    0
021300010201     C                   Move      *on           *In91
021400010201     C                   Exsr      CheckOverflow
021500010201     C                   Write     PRTSBC
021600010227     C                   sorta     ary
021700010227     C                   Eval      Elements =    %elem(ary)
021800010227     C                   Do        elements      pos
021900010201     C                   Eval      W4CARR   =    car(pos)
022000010201     C                   Eval      W4CNAM   =    cad(pos)
022100010226     C                   z-add     nbr(pos)      W4#CNT
022200010201     C                   z-add     pre(pos)      W4PPRM
022300010226     C                   z-add     inc(pos)      W4INCR
022400010226     C                   z-add     com(pos)      W4COMM
022500010227     C                   If        car(pos) <> *Blanks
022600010201     C                   Write     PRTSBD
022700010227     C                   End
022800010226     C                   Eval      W5#CNT   =    W5#CNT + W4#CNT
022900010201     C                   Eval      W5PPRM   =    W5PPRM + W4PPRM
023000010226     C                   Eval      W5INCR   =    W5INCR + W4INCR
023100010226     C                   Eval      W5COMM   =    W5COMM + W4COMM
023200010201     C                   Enddo
023300010201     C                   Write     PRTSBT
023400010226     C                   Eval      W4#CNT   =    0
023500010201     C                   Eval      W4PPRM   =    0
023600010226     C                   Eval      W4INCR   =    0
023700010226     C                   Eval      W4COMM   =    0
023800010226     C                   Eval      W5#CNT   =    0
023900010201     C                   Eval      W5PPRM   =    0
024000010226     C                   Eval      W5INCR   =    0
024100010226     C                   Eval      W5COMM   =    0
024200010201     C                   Eval      Last     =    0
024300010201     C                   Clear                   car
024400010201     C                   Clear                   cad
024500010201     C                   Clear                   nbr
024600010201     C                   Clear                   pre
024700010201     C                   Clear                   com
024800010226     C                   Clear                   inc
024900010201     C                   ENDSR
025000010201      *___________________________________________________________________
025100000000      * Key Lists
025200000000      *___________________________________________________________________
025300000000     C     KLIST         BEGSR
025400000000     C                   ENDSR
025500010201      *___________________________________________________________________
025600010201      * Check Overflow - Print Header
025700010201      *___________________________________________________________________
025800010201     C     CheckOverflow BEGSR
025900010201     C                   If        *in91  = *on
026000010226     C     IREFDT        Mult      10000.0001    WDATE
026100010201     C                   Write     PRTHDR
026200010201     C                   Move      *off          *In91
026300010201     C                   End
026400010201     C                   ENDSR
026500010201      *___________________________________________________________________
026600010201      * Program Open
026700010201      *___________________________________________________________________
026800010201     C     *INZSR        BEGSR
026900010201     C                   Move      *on           *In91
027000010201     C                   ENDSR
