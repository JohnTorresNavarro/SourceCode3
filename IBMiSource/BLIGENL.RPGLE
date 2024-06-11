000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Broker Licensing Generate LMAN Code
000500000000      *
000600000000      *  (c)Copyright 2003 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - November 17, 2003
000900000000      *_________________________________________________________________________
001000031117     FBLILMAN   IF A E           K DISK
001001031117      *
001002031117     D HIVAL           S              3S 0 INZ(*HIVAL)
001003031117      *
001004031117     D WDTA          E DS                  EXTNAME(BLIXLSP)
001005031117      *
001100031117     C     *ENTRY        PLIST
001101031117     C                   PARM                    WDTA
001103031117      *
001104031117     C     HIVAL         SETGT     BLILMAN
001105031117     C                   READP     BLILMAN
001106031117     C                   IF        Not %EOF
001107031117     C                   EVAL      LMAN#+= 1
001108031117     C                   Z-ADD     LMAN#         LREL#
001109031117     C                   move      lrel#         WREL              7
001110031117     C                   EVAL      LRELC = 'L' + WREL
001111031117     C                   EVAL      LSUPN = 'NO SUPER AGENCY'
001112031117     C                   EVAL      LAGCN = %TRIM(XFLD12)
001113031117     C                   EVAL      LMANN = %TRIM(XFLD10) + ' ' +
001114031117     C                                     %TRIM(XFLD11) + ' ' +
001115031117     C                                     %TRIM(XFLD09)
001116031117     C                   EVAL      LSUPR = '*NO'
001117031117     C                   EVAL      LAGCY = XAGEN
001118031117     C                   SELECT
001119031117     C                   WHEN      LMAN# <= 99
001120031117     C                   MOVE      LMAN#         LMANC
001121031117     C                   EVAL      %subst(LMANC:1:1) = '@'
001122031117     C                   WHEN      LMAN# <= 199
001123031117     C                   MOVE      LMAN#         LMANC
001124031117     C                   EVAL      %subst(LMANC:1:1) = '#'
001125031117     C                   WHEN      LMAN# <= 299
001126031117     C                   MOVE      LMAN#         LMANC
001127031117     C                   EVAL      %subst(LMANC:1:1) = '$'
001128031117     C                   WHEN      LMAN# <= 399
001129031117     C                   MOVE      LMAN#         LMANC
001130031117     C                   EVAL      %subst(LMANC:1:1) = '%'
001131031117     C                   WHEN      LMAN# <= 499
001132031117     C                   MOVE      LMAN#         LMANC
001133031117     C                   EVAL      %subst(LMANC:1:1) = '&'
001134031117     C                   WHEN      LMAN# <= 599
001135031117     C                   MOVE      LMAN#         LMANC
001136031117     C                   EVAL      %subst(LMANC:1:1) = '+'
001137031117     C                   WHEN      LMAN# <= 699
001138031117     C                   MOVE      LMAN#         LMANC
001139031117     C                   EVAL      %subst(LMANC:1:1) = '='
001140031117     C                   WHEN      LMAN# <= 799
001141031117     C                   MOVE      LMAN#         LMANC
001142031117     C                   EVAL      %subst(LMANC:1:1) = '*'
001143031117     C                   ENDSL
001144031117     C                   WRITE     LMANR
001145031117     C                   Eval      xsman = lmanc
001146031117     C                   RETURN
001147031117     C                   END
001200031117      *
