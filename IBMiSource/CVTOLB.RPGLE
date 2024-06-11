000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Convert existing
000500000000      *
000600000000      *  (c)Copyright 2007 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - October 05, 2007
000900000000      *_________________________________________________________________________
000901071005    ?FOLFSUBPLF UP   E           k DISK
000902071005     D  l2seq          S              2s 0 inz
001000071005     IOLFSUBPR      01
001100071005     I                                          OSCARC        L2
001200071005     I                                          OSTYPC        L2
001300071005     I                                          OSPLAN        L2
001401071005     C   01              eval      l2seq  = l2seq + 1
001500071005     C   01              eval      OSSORT = l2seq
001600071005     C   01              Update    OLFSUBPR
001700071005     CL2                 eval      l2seq = 0
