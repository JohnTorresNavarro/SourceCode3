000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check ISCRPT for mulitiple jobs
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 10, 2002
000800000000      *_________________________________________________________________________
000900020610    ?FISCRPT    IF   E           K DISK
001000020610     D WWDATE          S              8S 0
001100020610    ?C     *ENTRY        Plist                                                  *ENTRY LIST
001200020610    ?C                   Parm                    WODATE            8            INTERNAL MODE
001300020610    ?C                   Move      WODATE        WWDATE                         INTERNAL MODE
001400020610     C     WWDATE        Chain     ISCRPT
001500020610     C                   If        %Found
001600020610    ?C                   Clear                   WODATE                         INTERNAL MODE
001700020610    ?C                   End                                                    END ERROR
001800020610     C                   Eval      *INLR = *ON
001900020610     C                   Return
