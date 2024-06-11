000100000000      *_________________________________________________________________________
000200000000      *
000300121113      *  Description:  DW310 Preprocessor - UPDATE PLAN CATS
000400000000      *
000500121113      *  (c)Copyright 2012 by GBS, Inc.
000600090819
000700121113      *    Created by:  JALLEN - November 13, 2012
000800000000      *_________________________________________________________________________
000900121113     FDW310PF   UP   E           K DISK
001000121113
001100121113      * make them all the same
001200121113     C                   Select
001300121113     C                   When      %trim(DWPCAT) = 'PDR'
001400121113     C                   Eval      DWPCAT = 'PDN'
001500121113     C                   Update    DW310R
001600140917     C                   When      %trim(DWPCAT) = 'PCD'
001700140917     C                   Eval      DWPCAT = 'PDN'
001800140917     C                   Update    DW310R
001900130118     C                   When      %trim(DWPCAT) = 'PDE'
002000130118     C                   Eval      DWPCAT = 'PDN'
002100130118     C                   Update    DW310R
002200121113     C                   When      %trim(DWPCAT) = 'PVR'
002300121113     C                   Eval      DWPCAT = 'PVS'
002400130725     C                   When      %trim(DWPCAT) = 'PCV'
002500130725     C                   Eval      DWPCAT = 'PVS'
002600121113     C                   Update    DW310R
002700121113     C                   Endsl
002800121113
