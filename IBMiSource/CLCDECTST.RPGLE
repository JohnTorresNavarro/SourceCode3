000100000000      *_________________________________________________________________________
000200000000      *
000300010406      *  Description:  Calculate Declining Life Benefit Amount
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 06, 2001
000800000000      *_________________________________________________________________________
000900130417     FDeclif    IF   E           K Disk
001000130417
001100130417     D FA              S              3  0 Dim(20)
001200130417     D TA              S              3  0 Dim(20)
001300130417     D DP              S              5P 3 Dim(20)
001400130417
001500010406     D WorkHold        s             13  5 inz
001600010406     D                 ds                  inz
001700010406     D WorkAmt                        9  2
001800010406     D Work1                          1  0 Overlay(WorkAmt:8)
001900010406     D Work10                         1  0 Overlay(WorkAmt:7)
002000010406     D Work100                        1  0 Overlay(WorkAmt:6)
002100010406     D Work1000                       1  0 Overlay(WorkAmt:5)
002200130417     D                 DS
002300130417     D DecFA                   1     60  0
002400130417     D                                     DIM(20)
002500130417     D  ABF01                  1      3  0
002600130417     D  ABF02                  4      6  0
002700130417     D  ABF03                  7      9  0
002800130417     D  ABF04                 10     12  0
002900130417     D  ABF05                 13     15  0
003000130417     D  ABF06                 16     18  0
003100130417     D  ABF07                 19     21  0
003200130417     D  ABF08                 22     24  0
003300130417     D  ABF09                 25     27  0
003400130417     D  ABF10                 28     30  0
003500130417     D  ABF11                 31     33  0
003600130417     D  ABF12                 34     36  0
003700130417     D  ABF13                 37     39  0
003800130417     D  ABF14                 40     42  0
003900130417     D  ABF15                 43     45  0
004000130417     D  ABF16                 46     48  0
004100130417     D  ABF17                 49     51  0
004200130417     D  ABF18                 52     54  0
004300130417     D  ABF19                 55     57  0
004400130417     D  ABF20                 58     60  0
004500130417     D                 DS
004600130417     D DecTA                   1     60  0
004700130417     D                                     DIM(20)
004800130417     D  ABT01                  1      3  0
004900130417     D  ABT02                  4      6  0
005000130417     D  ABT03                  7      9  0
005100130417     D  ABT04                 10     12  0
005200130417     D  ABT05                 13     15  0
005300130417     D  ABT06                 16     18  0
005400130417     D  ABT07                 19     21  0
005500130417     D  ABT08                 22     24  0
005600130417     D  ABT09                 25     27  0
005700130417     D  ABT10                 28     30  0
005800130417     D  ABT11                 31     33  0
005900130417     D  ABT12                 34     36  0
006000130417     D  ABT13                 37     39  0
006100130417     D  ABT14                 40     42  0
006200130417     D  ABT15                 43     45  0
006300130417     D  ABT16                 46     48  0
006400130417     D  ABT17                 49     51  0
006500130417     D  ABT18                 52     54  0
006600130417     D  ABT19                 55     57  0
006700130417     D  ABT20                 58     60  0
006800130417     D                 DS
006900130417     D DecDP                   1     60P 3
007000130417     D                                     DIM(20)
007100130417     D  DPER01                 1      3P 3
007200130417     D  DPER02                 4      6P 3
007300130417     D  DPER03                 7      9P 3
007400130417     D  DPER04                10     12P 3
007500130417     D  DPER05                13     15P 3
007600130417     D  DPER06                16     18P 3
007700130417     D  DPER07                19     21P 3
007800130417     D  DPER08                22     24P 3
007900130417     D  DPER09                25     27P 3
008000130417     D  DPER10                28     30P 3
008100130417     D  DPER11                31     33P 3
008200130417     D  DPER12                34     36P 3
008300130417     D  DPER13                37     39P 3
008400130417     D  DPER14                40     42P 3
008500130417     D  DPER15                43     45P 3
008600130417     D  DPER16                46     48P 3
008700130417     D  DPER17                49     51P 3
008800130417     D  DPER18                52     54P 3
008900130417     D  DPER19                55     57P 3
009000130417     D  DPER20                58     60P 3
009100130417      *
009200130417     C                   Move      591           Dctrst
009300130417     C                   Move      012           Dcsub#
009400130417     C                   Move      'EAKU'        Dcplan
009500130417     C                   z-add     75            age               3 0
009600130417
009700130417     C     De_Key        KLIST
009800130417     C                   KFLD                    Dctrst
009900130417     C                   KFLD                    Dcsub#
010000130417     C                   KFLD                    Dcplan
010100130417
010200130417     C     De_Key        Chain     Declif
010300130417     C                   If        %Found(Declif)
010400130417     C                   Move      DecFA         FA
010500130417     C                   Move      DecTA         TA
010600130417     C                   End
010700130417
010800130417     C                   Do        20            #A                2 0
010900130417     C                   Z-add     DecDP(#A)     DP(#A)
011000130417     C                   Enddo
011100130417      *---
011200130417      * Determine decline percent (if any) for WwDecPer parameter.
011300130417      *---
011400130417     C                   Do        20            DX                2 0
011500130417     C     Age           Ifge      FA(DX)
011600130417     C     Age           Andle     TA(DX)
011700130417     C                   Z-add     DP(DX)        WwDecPer          7 5
011800130417     C     WwDecPer      Div       100           WwDecPer
011900130417     C                   Leave
012000130417     C                   Endif
012100130417     C                   Enddo
012200010406      *
012300010406      * Program Entry
012400130417     C                   z-add     50000         WwBenAmt          7 0
012500130417     C****               z-add     27.462        WwDecPer          7 5
012600130417     C                   z-add     1             WwRndAmt          5 0
012700130417     C                   move      'U'           WwRndFlg          1
012800130417     C                   move      *blanks       WwReturn         10
012900010406      *
013000010406      * Init Return
013100010406     C                   Eval      WwReturn =    *Blanks
013200010406      *
013300010406      * Calculate Benefit Amount
013400010406     C     WwBenAmt      Mult(h)   WwDecPer      WorkHold
013500010406     C                   Z-add     WorkHold      WorkAmt
013600010406      *
013700010406      * If Rounding required, Compute Benefit Amount.
013800020123     C                   If        WwRndAmt >    *Zeros   and
013900020123     C                             WorkAmt  <>   *Zeros
014000010406     C                   Select
014100010406     C                   When      WwRndFlg = 'U'
014200010406     C                   Exsr      AdjustUp
014300010406     C                   When      WwRndFlg = 'D'
014400010406     C     WorkAmt       Div       WwRndAmt      WwBenAmt
014500010406     C     WwBenAmt      Mult      WwRndAmt      WwBenAmt
014600010406     C                   Other
014700010406     C                   Eval      WwReturn =   '*ERROR'
014800010406     C                   Endsl
014900010406     C                   End
015000010406      *
015100010406     C                   Return
015200010406      *--------------------------------------------------------------------*
015300010406     C     AdjustUp      Begsr
015400010406      *--------------------------------------------------------------------*
015500010406      *
015600010406      * Force Half-Adjust UP by rounding factor.
015700010406     C                   Select
015800010406     C                   When      WwRndAmt = 1
015900010406     C                   When      WwRndAmt = 10
016000010411     C                   If        Work1    <> 0
016100010411     C                   z-add     9             Work10
016200010411     C                   End
016300010406     C                   When      WwRndAmt = 100
016400010411     C                   If        Work10   <> 0  or
016500010411     C                             Work1    <> 0
016600010411     C                   z-add     9             Work100
016700010411     C                   End
016800010406     C                   When      WwRndAmt = 1000
016900010411     C                   If        Work100  <> 0  or
017000010411     C                             Work10   <> 0  or
017100010411     C                             Work1    <> 0
017200010411     C                   z-add     9             Work1000
017300010411     C                   End
017400010406     C                   Other
017500010406     C                   Eval      WwReturn =   '*ERROR'
017600010406     C                   Endsl
017700010406     C                   If        WwReturn =    *Blanks
017800010406     C     WorkAmt       Div(h)    WwRndAmt      WwBenAmt
017900010406     C     WwBenAmt      Mult      WwRndAmt      WwBenAmt
018000010406     C                   End
018100010406     C                   Endsr
