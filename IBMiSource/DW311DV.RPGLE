000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Get Depend Earliest Cov Eff Date
000400000000      *
000500000000      *  (c)Copyright 2007 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 30, 2007
000800000000      *_________________________________________________________________________
000900070430     FDCOVC     IF   E           K DISK    Prefix(D_)
001000070430     FPLNMST    IF   E           K DISK    Prefix(P_)
001100070430     FCARMST    IF   E           K DISK    Prefix(C_)
001200080116     fGRAT24    if   e           K disk
001300070430      *
001400080116     d PlanGrp         s             15a   inz
001500070430     D WrkDate         S              8S 0 inz
001600070430     D ISO_DATE        S               D   DATFMT(*ISO)
001700070430     D wdta          e ds                  extname(depend)
001800070430      *
001900070430     C     *entry        Plist
002000080116     C                   Parm                    wdta
002100080116     C                   Parm                    ingrp            15
002200070430     C                   Parm                    OutDate          10
002300070430      *
002400070430     C                   Eval      OutDate = *blanks
002500070430      *
002600070430     C     DEPKEY        Setll     DCOVC
002700070430     C     DEPKEY        Reade     DCOVC                                  50
002800070430     C     *IN50         Doweq     *OFF
002900070430     C                   If        D_DENRDT <> D_CCANDT
003000070430      *
003100070430     C     PlanKey       Chain     PLNMST
003200070430     C                   If        %Found
003300070430     C     P_PCARR       Chain     CARMST
003400080116     C                   If        %Found
003500080116      *
003600080116     C                   Exsr      Rates
003700070430      *
003800080116     C                   If        %trim(plangrp) = %trim(ingrp)
003900070430     C                   Select
004000070430     C                   When      WrkDate = 0
004100070430     C                   Eval      WrkDate = D_DENRDT
004200070430     C                   When      WrkDate > D_DENRDT
004300070430     C                   Eval      WrkDate = D_DENRDT
004400070430     C                   Other
004500070430      * Keep
004600080116     C                   Endsl
004700080116     C                   End
004800070430      *
004900070430     C                   End
005000070430     C                   End
005100070430     C                   End
005200070430     C     DEPKEY        Reade     DCOVC                                  50
005300070430     C                   Enddo
005400070430      *
005500100129     C                   If        WrkDate <> 0
005600070430     C                   Movel     WrkDate       Input_Date
005700070430     C                   Eval      Input_Format  = 'YYYYMMDD'
005800070430     C                   Eval      Output_Format = 'MM/DD/YYYY'
005900070430     C                   Exsr      FormatDateSR
006000070430     C                   Eval      OutDate       = %trim(Output_Date)
006100100129     C                   End
006200070430      *
006300070430     C                   Eval      *inlr = *on
006400070430     C                   Return
006500080116      *
006600080116      *--------------------------------------------------------------------*
006700080116     C     Rates         Begsr
006800080116     C                   Eval      PlanGrp = *blanks
006900080116
007000080116     C     GrtKey        Setll     GRAT24
007100080116     C     GrtKey        Reade     GRAT24
007200080116     C                   Dow       not %eof(GRAT24)
007300080116      * GBS Date Logic
007400080116     C                   If        frmdat <> todat
007500080116     C                   If        todat   = *zeros
007600080116     C                   eval      todat   = 99999999
007700080116     C                   End
007800080116     C                   if        D_DENRDT >= frmdat and
007900080116     C                             D_DENRDT <= todat
008000080116      *
008100080116     C                   Eval      plangrp = %trim(group#)
008200080116     C                   Leave
008300080116     C                   end
008400080116     C                   end
008500080116     C     GrtKey        Reade     GRAT24
008600080116     C                   Enddo
008700080116
008800080116     C                   Endsr
008900070430      *
009000070430      *--------------------------------------------------------------------*
009100070430      * KLIST
009200070430      *--------------------------------------------------------------------*
009300070430     C     KLIST         Begsr
009400070430      *
009500070430     C     DepKey        KLIST
009600070430     C                   KFLD                    DSSNO
009700070430     C                   KFLD                    DPSEQ#
009800070430      *
009900070430     C     PlanKey       KLIST
010000070430     C                   KFLD                    D_DVTRST
010100070430     C                   KFLD                    D_DVSUB#
010200070430     C                   KFLD                    D_DVPlan
010300070430      *
010400080116     C     GrtKey        Klist
010500080116     C                   Kfld                    D_DVTRST
010600080116     C                   Kfld                    D_DVSUB#
010700080116     C                   Kfld                    D_DVPlan
010800080116      *
010900070430     C                   Endsr
011000070430      *___________________________________________________________________
011100070430      * Format Date
011200070430      *___________________________________________________________________
011300070430     C     FormatDateSR  BEGSR
011400070430     C                   Call      'FMTDATE'
011500070430     C                   Parm                    Input_Date       32
011600070430     C                   Parm                    Input_Format     32
011700070430     C                   Parm                    Output_Format    32
011800070430     C                   Parm                    Output_Date      32
011900070430     C                   Parm                    Output_Error     10
012000070430     C                   ENDSR
