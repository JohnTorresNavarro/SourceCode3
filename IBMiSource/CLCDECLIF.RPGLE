000100000000      *_________________________________________________________________________
000200000000      *
000300010406      *  Description:  Calculate Declining Life Benefit Amount
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 06, 2001
000800000000      *_________________________________________________________________________
000900010406     D WorkHold        s             13  5 inz
001000010406     D                 ds                  inz
001100010406     D WorkAmt                        9  2
001200010406     D Work1                          1  0 Overlay(WorkAmt:8)
001300010406     D Work10                         1  0 Overlay(WorkAmt:7)
001400010406     D Work100                        1  0 Overlay(WorkAmt:6)
001500010406     D Work1000                       1  0 Overlay(WorkAmt:5)
001600010406      *
001700010406      * Program Entry
001800010406     C     *Entry        Plist
001900010406     C                   Parm                    WwBenAmt          7 0
002000130418     C                   Parm                    WwDecPer          7 5
002100010406     C                   Parm                    WwRndAmt          5 0
002200010406     C                   Parm                    WwRndFlg          1
002300010406     C                   Parm                    WwReturn         10
002400010406      *
002500010406      * Init Return
002600010406     C                   Eval      WwReturn =    *Blanks
002700010406      *
002800010406      * Calculate Benefit Amount
002900010406     C     WwBenAmt      Mult(h)   WwDecPer      WorkHold
003000010406     C                   Z-add     WorkHold      WorkAmt
003100010406      *
003200010406      * If Rounding required, Compute Benefit Amount.
003300020123     C                   If        WwRndAmt >    *Zeros   and
003400020123     C                             WorkAmt  <>   *Zeros
003500010406     C                   Select
003600010406     C                   When      WwRndFlg = 'U'
003700010406     C                   Exsr      AdjustUp
003800010406     C                   When      WwRndFlg = 'D'
003900010406     C     WorkAmt       Div       WwRndAmt      WwBenAmt
004000010406     C     WwBenAmt      Mult      WwRndAmt      WwBenAmt
004100010406     C                   Other
004200010406     C                   Eval      WwReturn =   '*ERROR'
004300010406     C                   Endsl
004400010406     C                   End
004500010406      *
004600010406     C                   Return
004700010406      *--------------------------------------------------------------------*
004800010406     C     AdjustUp      Begsr
004900010406      *--------------------------------------------------------------------*
005000010406      *
005100010406      * Force Half-Adjust UP by rounding factor.
005200010406     C                   Select
005300010406     C                   When      WwRndAmt = 1
005400010406     C                   When      WwRndAmt = 10
005500010411     C                   If        Work1    <> 0
005600010411     C                   z-add     9             Work10
005700010411     C                   End
005800010406     C                   When      WwRndAmt = 100
005900010411     C                   If        Work10   <> 0  or
006000010411     C                             Work1    <> 0
006100010411     C                   z-add     9             Work100
006200010411     C                   End
006300010406     C                   When      WwRndAmt = 1000
006400010411     C                   If        Work100  <> 0  or
006500010411     C                             Work10   <> 0  or
006600010411     C                             Work1    <> 0
006700010411     C                   z-add     9             Work1000
006800010411     C                   End
006900010406     C                   Other
007000010406     C                   Eval      WwReturn =   '*ERROR'
007100010406     C                   Endsl
007200010406     C                   If        WwReturn =    *Blanks
007300010406     C     WorkAmt       Div(h)    WwRndAmt      WwBenAmt
007400010406     C     WwBenAmt      Mult      WwRndAmt      WwBenAmt
007500010406     C                   End
007600010406     C                   Endsr
