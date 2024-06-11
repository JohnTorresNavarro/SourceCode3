000100000000      *_________________________________________________________________________
000200000000      *
000300010406      *  Description:  Calculate the Benefit Amount
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - March 30, 2001
000800080107      *                                                                    *
000900080107      * 01/07/08 szz - For salary-based plans:  If the salary multiplier   *
001000080107      *                is not equal to zero, the salary must be zero.      *
001001100222      *                                                                    *
001002100222      * 02/22/10     - For a round factor of 1, the round was not being    *
001003100222      *                forced.                                             *
001004110728      *                                                                    *
001005110728      * 07/27/11     - If the Work1000 has the first value coming from the *
001006110728      *                right, it still has to be rounded.  Before the      *
001007110728      *                program was only checking for a value (other than   *
001008110728      *                zero in the Work100 position.                       *
001100000000      *_________________________________________________________________________
001200010403     D                 ds                  inz
001300010403     D WorkAmt                        9  2
001400100222     D WorkCents                      2  0 Overlay(WorkAmt:8)
001500010403     D Work1                          1  0 Overlay(WorkAmt:8)
001600010403     D Work10                         1  0 Overlay(WorkAmt:7)
001700010403     D Work100                        1  0 Overlay(WorkAmt:6)
001800010403     D Work1000                       1  0 Overlay(WorkAmt:5)
001900010403      *
002000010406      * Program Entry
002100010330     C     *Entry        Plist
002200010406     C                   Parm                    WwSalary          9 0
002300010406     C                   Parm                    WwMaxBen          7 0
002400010406     C                   Parm                    WwMult            6 5
002500010406     C                   Parm                    WwRound           5 0
002600010406     C                   Parm                    WwPrnDfl          1
002700010406     C                   Parm                    WwBenAmt          7 0
002800010330     C                   Parm                    WwReturn         10
002900010406      *
003000010406      * Init Return
003100010330     C                   Eval      WwReturn =    *Blanks
003200010403      *
003300010406      * Flat Benefit Amount?
003400010406     C                   If        WwMult  <=    *Zeros
003500010406     C                   Eval      WwBenAmt =    WwMaxBen
003600010406     C                   Return
003700010406     C                   End
003800010406      *
003900010403      * Calculate Benefit Amount
004000080107     C     WwSalary      Mult      WwMult        WorkAmt
004100080107     C                   If        WwMult   <>   *Zero
004200080107     C                   If        WwSalary =    *Zero
004300080107     C                   Eval      WwReturn =   '*ERRORSA'
004400080107     C                   End
004500080107     C                   End
004600010403      *
004700010406      * If Rounding required, Compute Benefit Amount.
004800010406     C                   If        WwRound  >    *Zeros
004900010330     C                   Select
005000010406     C                   When      WwPrnDfl = 'U'
005100010403     C                   Exsr      AdjustUp
005200010406     C                   When      WwPrnDfl = 'D'
005300010406     C     WorkAmt       Div       WwRound       WwBenAmt
005400010406     C     WwBenAmt      Mult      WwRound       WwBenAmt
005500010330     C                   Other
005600010403     C                   Eval      WwReturn =   '*ERROR'
005700010406     C                   Endsl
005800010406     C                   End
005900010508      **********************************************************
006000010508      * Now, remove decimal places to whole number.
006100010508     C*****WwBenAmt      div       100           WwBenAmt
006200010508      **********************************************************
006300010508      *
006400010406      * If Computed Benefit Amount is greater than the maximum benefit
006500010406      * allowed, replace computed benefit with maximum benefit from
006600010406      * plan record.
006700010406     C                   If        WwBenAmt  >   WwMaxBen
006800010406     C                   Eval      WwBenAmt =    WwMaxBen
006900010406     C                   End
007000010406      *
007100010406     C                   Return
007200010403      *--------------------------------------------------------------------*
007300010403     C     AdjustUp      Begsr
007400010403      *--------------------------------------------------------------------*
007500010403      *
007600010406      * Force Half-Adjust UP by rounding factor.
007700010403     C                   Select
007800010406     C                   When      WwRound  = 1
007900100222     C                   If        WorkCents > 0
008000100222     C                   z-add     99            WorkCents
008100100222     C                   End
008200010406     C                   When      WwRound  = 10
008300010411     C                   If        Work1    <> 0
008400010403     C                   z-add     9             Work10
008500010411     C                   End
008600010406     C                   When      WwRound  = 100
008700010411     C                   If        Work10   <> 0  or
008800010411     C                             Work1    <> 0
008900010403     C                   z-add     9             Work100
009000010411     C                   End
009100010406     C                   When      WwRound  = 1000
009200010411     C                   If        Work100  <> 0  or
009300010411     C                             Work10   <> 0  or
009400010411     C                             Work1    <> 0
009401110728     C                                               OR
009402110728     C                             Work1000 <> 0
009500010403     C                   z-add     9             Work1000
009600010411     C                   End
009700010403     C                   Other
009800010403     C                   Eval      WwReturn =   '*ERROR'
009900010403     C                   Endsl
010000010403     C                   If        WwReturn =    *Blanks
010100010406     C     WorkAmt       Div(h)    WwRound       WwBenAmt
010200010406     C     WwBenAmt      Mult      WwRound       WwBenAmt
010300010403     C                   End
010400010403     C                   Endsr
