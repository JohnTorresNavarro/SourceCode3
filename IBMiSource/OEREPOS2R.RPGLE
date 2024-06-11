000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Clean up OEREPOS2P userid's
000500000000      *
000600000000      *  (c)Copyright 2012 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - June 05, 2012
000900000000      *_________________________________________________________________________
000901120606     FOEREPOSP  UP   E             disk
001100120605     FOEREPOS2P UF   E           k disk
001101120605
001102120606      * Convert USER to upper case
001103120606     C                   Call      'UTLUPLW'
001104120606     C                   Parm      '*UPPER'      WIRQS             8
001105120606     C                   Parm                    WORTN             8
001106120606     C                   Parm      RUSER         WISTR           256
001107120606     C                   Eval      RUSER = %trim(WISTR)
001108120606     C                   Update    OEREPOSR
001109120606
001110120605      * Delete POS2P if found in REPOSP
001301120605     C     RUSER         Delete    OEREPO2R
001400120605
