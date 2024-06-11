000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300080616    ? *  Description: Return 70 days from today for House Bill 1057    *
000400080616    ? *   letters and report.                                          *
000500080616    ? *  (c)Copyright 2008 by GBS, Inc.                                *
000600080616    ? *  This document contains restricted materials of GBS, Inc.      *
000700001003    ? *                                                                *
000800001003    ? *  Written by: S. Zien                                           *
000900080616    ? *  Date Written:  6/16/08                                        *
001000001003    ? *                                                                *
001100001003    ? *  History:                                                      *
001200040219    ? *            Revised by -                                        *
001300040219    ? *            Date -                                              *
001400040219    ? *            Revision -                                          *
001500040219    ? *                                                                *
001501030513      *                                                                *
001800991207    ? *_________________________________________________________________________
002600991209    ? * Program status data structure
002700991209    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002800000922      *
003101080616    ?D RunDate         S               D   Datfmt(*ISO)                         Input Request
003102080616     D Seventy         S               D   datfmt(*ISO)
005600991208      *
005700021015    ?C                   Move      *On           *InLR
005701080616      *___________________________________________________________________
005702080616      * Entry parameter list
005703080616      *___________________________________________________________________
005704080616     C     PLIST         Begsr                                                  PARM LISTS
005705080616     C     *ENTRY        Plist                                                  *ENTRY LIST
005710080616     C                   Parm                    SeventyA          8
005712080616     C                   Endsr
038500020816    ? *________________________________________________________________
038600020816    ? * Initialization
038700020816    ? *________________________________________________________________
038800020816    ?C     *INZSR        Begsr
041600021016    ? *
042100021011     C     *DATE         Mult      10000.0001    Today             8 0
042204080616     C     *ISO          Move      Today         RunDate
042205080616     C     RunDate       Adddur    70:*D         Seventy
042206080616     C     Seventy       Adddur    1:*M          Seventy
042207080616     C                   Move      Seventy       SeventyDays       8 0
042208080616     C                   Movel     SeventyDays   SCCYY             4
042209080616     C                   Move      SCCYY         SYY               2
042210080616     C                   Move      SeventyDays   SMMDD             4
042211080616     C                   Movel     SMMDD         SMM               2
042212080616     C                   Move      SMMDD         SDD               2
042213080616     C                   Eval      SeventyA  =   SMM + SDD + SYY + '  '
042300020816    ? *
042400020816    ?C                   Endsr
