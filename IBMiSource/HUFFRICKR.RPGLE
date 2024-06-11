000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Brooks Huff - Load Ricks file
000500000000      *
000600000000      *  (c)Copyright 2012 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - February 08, 2012
000900000000      *_________________________________________________________________________
001000120208     FHUFFRAW   IP   E             Disk
001100120208     FXG01BHP   O  A E             Disk
001101120208     C                   clear                   XG01MKR
001102120208     C                   move      doh           X1DOH
001103120208     C                   Eval      X1LNAM = %trim(LST)
001104120208     C                   Eval      X1FNAM = %trim(FST)
001105120208     C                   Eval      X1MI   = %trim(MID)
001106120208     C                   Eval      X1RAD1 = %trim(AD1)
001107120208     C                   Eval      X1RAD2 = %trim(AD2)
001108120208     C                   Eval      X1CITY = %trim(CTY)
001109120208     C                   Eval      X1ST   = %trim(STA)
001110120208     C                   movel     zipx          X1ZIP
001111120208     C                   Eval      X1SSN  = %trim(SSN)
001112120208     C                   move      dob           X1DOB
001113120208     C                   Eval      X1SEX  = %subst(GEN:1:1)
001114120208     C                   Eval      X1PHN  = %trim(PHN)
001200120208     C                   Write     XG01MKR
