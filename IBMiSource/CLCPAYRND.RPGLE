000100000000      *_________________________________________________________________________
000200000000      *
000300010503      *  Description:  Calculate Round
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 06, 2001
000800010503      *    Revised by:  SZIEN  - May, 3, 2001
000900010504      *    Revision:    Calculate rounding.
001000000000      *_________________________________________________________________________
001100010406     D WorkHold        s             13  5 inz
001200010406     D                 ds                  inz
001300010406     D WorkAmt                        9  2
001400130315     D Work1                          1  0 Overlay(WorkAmt:8)
001500130315     D Work1U                         2  0 Overlay(WorkAmt:8)
001600130315     D Work10                         1  0 Overlay(WorkAmt:7)
001700130315     D Work10U                        3  0 Overlay(WorkAmt:7)
001800130315     D Work100                        1  0 Overlay(WorkAmt:6)
001900130315     D Work100U                       4  0 Overlay(WorkAmt:6)
002000130315     D Work1000                       1  0 Overlay(WorkAmt:5)
002100130315     D Work1000U                      5  0 Overlay(WorkAmt:5)
002200010406      *
002300010406      * Program Entry
002400130315     C     *Entry        Plist
002500130315     C                   Parm                    WwVarAmt          9 2
002600130315     C                   Parm                    WwRndAmt          5 0
002700130315     C                   Parm                    WwRndFlg          1
002800130315     C                   Parm                    WwReturn         10
002900010406      *
003000010406      * Init Return
003100010406     C                   Eval      WwReturn =    *Blanks
003200010406      *
003300010406      * Calculate Benefit Amount
003400010503     C     WwVarAmt      Mult(h)   1             WorkHold
003500010406     C                   Z-add     WorkHold      WorkAmt
003600010406      *
003700010406      * If Rounding required, Compute Benefit Amount.
003800010406     C                   If        WwRndAmt >    *Zeros
003900010406     C                   Select
004000010406     C                   When      WwRndFlg = 'U'
004100010406     C                   Exsr      AdjustUp
004200010406     C                   When      WwRndFlg = 'D'
004300010503     C     WorkAmt       Div       WwRndAmt      WwVarAmt
004400010503     C     WwVarAmt      Mult      WwRndAmt      WwVarAmt
004500010406     C                   Other
004600010406     C                   Eval      WwReturn =   '*ERROR'
004700010406     C                   Endsl
004800010406     C                   End
004900010406      *
005000010406     C                   Return
005100010406      *--------------------------------------------------------------------*
005200010406     C     AdjustUp      Begsr
005300010406      *--------------------------------------------------------------------*
005400010406      *
005500010406      * Force Half-Adjust UP by rounding factor.
005600010406     C                   Select
005700010406     C                   When      WwRndAmt = 1
005800130315     C                   If        Work1U <> 0
005900130315     C                   z-add     0             Work1U
006000130315     C                   add       WwRndAmt      WorkAmt
006100130208     C                   End
006200010406     C                   When      WwRndAmt = 10
006300130315     C                   If        Work10U <> 0
006400130315     C                   z-add     0             Work10U
006500130315     C                   add       WwRndAmt      WorkAmt
006600010411     C                   End
006700010406     C                   When      WwRndAmt = 100
006800130315     C                   If        Work100U <> 0
006900130315     C                   z-add     0             Work100U
007000130315     C                   add       WwRndAmt      WorkAmt
007100010411     C                   End
007200010406     C                   When      WwRndAmt = 1000
007300130315     C                   If        Work1000U <> 0
007400130315     C                   z-add     0             Work1000U
007500130315     C                   add       WwRndAmt      WorkAmt
007600010411     C                   End
007700010406     C                   Other
007800010406     C                   Eval      WwReturn =   '*ERROR'
007900010406     C                   Endsl
008000010406     C                   If        WwReturn =    *Blanks
008100010503     C     WorkAmt       Div(h)    WwRndAmt      WwVarAmt
008200010503     C     WwVarAmt      Mult      WwRndAmt      WwVarAmt
008300010406     C                   End
008400010406     C                   Endsr
