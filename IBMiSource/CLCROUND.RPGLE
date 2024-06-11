000100000000      *_________________________________________________________________________
000200000000      *
000300010503      *  Description:  Calculate Round
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 06, 2001
000701010503      *    Revised by:  SZIEN  - May, 3, 2001
000702010504      *    Revision:    Calculate rounding.
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
001900010503     C                   Parm                    WwVarAmt          7 0
002100010406     C                   Parm                    WwRndAmt          5 0
002200010406     C                   Parm                    WwRndFlg          1
002300010406     C                   Parm                    WwReturn         10
002400010406      *
002500010406      * Init Return
002600010406     C                   Eval      WwReturn =    *Blanks
002700010406      *
002800010406      * Calculate Benefit Amount
002900010503     C     WwVarAmt      Mult(h)   1             WorkHold
003000010406     C                   Z-add     WorkHold      WorkAmt
003100010406      *
003200010406      * If Rounding required, Compute Benefit Amount.
003300010406     C                   If        WwRndAmt >    *Zeros
003400010406     C                   Select
003500010406     C                   When      WwRndFlg = 'U'
003600010406     C                   Exsr      AdjustUp
003700010406     C                   When      WwRndFlg = 'D'
003800010503     C     WorkAmt       Div       WwRndAmt      WwVarAmt
003900010503     C     WwVarAmt      Mult      WwRndAmt      WwVarAmt
004000010406     C                   Other
004100010406     C                   Eval      WwReturn =   '*ERROR'
004200010406     C                   Endsl
004300010406     C                   End
004400010406      *
004500010406     C                   Return
004600010406      *--------------------------------------------------------------------*
004700010406     C     AdjustUp      Begsr
004800010406      *--------------------------------------------------------------------*
004900010406      *
005000010406      * Force Half-Adjust UP by rounding factor.
005100010406     C                   Select
005200010406     C                   When      WwRndAmt = 1
005300010406     C                   When      WwRndAmt = 10
005400010411     C                   If        Work1    <> 0
005500010411     C                   z-add     9             Work10
005600010411     C                   End
005700010406     C                   When      WwRndAmt = 100
005800010411     C                   If        Work10   <> 0  or
005900010411     C                             Work1    <> 0
006000010411     C                   z-add     9             Work100
006100010411     C                   End
006200010406     C                   When      WwRndAmt = 1000
006300010411     C                   If        Work100  <> 0  or
006400010411     C                             Work10   <> 0  or
006500010411     C                             Work1    <> 0
006600010411     C                   z-add     9             Work1000
006700010411     C                   End
006800010406     C                   Other
006900010406     C                   Eval      WwReturn =   '*ERROR'
007000010406     C                   Endsl
007100010406     C                   If        WwReturn =    *Blanks
007200010503     C     WorkAmt       Div(h)    WwRndAmt      WwVarAmt
007300010503     C     WwVarAmt      Mult      WwRndAmt      WwVarAmt
007400010406     C                   End
007500010406     C                   Endsr
