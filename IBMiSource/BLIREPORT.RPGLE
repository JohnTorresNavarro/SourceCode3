000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  BLI Report
000400000000      *
000500000000      *  (c)Copyright 2006 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - September 11, 2006
000800000000      *_________________________________________________________________________
000900060911     FBLICON    IP   E           k DISK
001000060911     FSMANRLT   IF   E           k DISK
001100060911     FSPRAGXR2  IF   E           k DISK
001200060911     FSMAN      IF   E           k DISK
001300060911     FAGENCY    IF   E           k DISK
001400060911     FSUPRAGCY  IF   E           k DISK
001500060911     FBLILMANL2 IF   E           k DISK
001600060911     FBLILSM    IF   E           k DISK
001700060911     FBLIEOC    IF   E           k DISK
001800060911     FBLIRPT    O    E             DISK
001900230811
002000230811     C                   eval      LCRELI = '00004532'
002100060911     C     LCRELI        Chain     SMANRLT
002200060911     C                   If        %found
002300060911     C                   eval      LMANC = SRSMAN
002400060911     C     SRASID        Chain     SPRAGXR2
002500060911     C                   If        %found
002600060911     C                   eval      LMANC = SRSMAN
002700060911     C                   eval      LAGCY = SXAGCY
002800060911     C                   eval      LSUPR = SXSUPER
002900060911     C                   Exsr      FAGENCY
003000060911     C                   If        SENDDT = 0  or
003100230811     C                             SENDDT >= 20220101  and
003200230811     C                             SENDDT <= 20231231
003300060911     C                   Exsr      GETLIC
003400060911     C                   End
003500060911     C                   End
003600060911     C                   Else
003700060911     C     LCRELI        Chain     BLILMANL2
003800060911     C                   If        %found
003900060911     C                   Exsr      GETLIC
004000060911     C                   End
004100060911     C                   End
004200230811
004300230811     C                   eval      *inLR = *on
004400230811     C                   return
004500060911
004600060911     C     GETLIC        Begsr
004700060911     C     LCRELI        Chain     BLIEOC
004800060911     C     LMANC         SETLL     BLILSM
004900060911     C     LMANC         READE     BLILSM
005000060911     C                   Dow       not %eof(BLILSM)
005100060911     C                   Write     BLIRPTR
005200060911     C     LMANC         READE     BLILSM
005300060911     C                   Enddo
005400060911     C                   Clear                   BLIRPTR
005500060911     C                   Endsr
005600060911
005700060911     C     FAGENCY       Begsr
005800060911     C     LMANC         Chain     SMAN
005900060911     C                   If        %found
006000060911     C                   Eval      LMANN = %trim(AGNAM1)
006100060911     C                   End
006200060911     C     LAGCY         Chain     AGENCY
006300060911     C                   If        %found
006400060911     C                   Eval      LAGCN = %trim(AGNAM1)
006500060911     C                   End
006600060911     C     LSUPR         Chain     SUPRAGCY
006700060911     C                   If        %found
006800060911     C                   Eval      LSUPN = %trim(SANAME1)
006900060911     C                   End
007000060911     C                   Endsr
