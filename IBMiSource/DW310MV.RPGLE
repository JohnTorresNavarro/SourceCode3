000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Get Depend Earliest Cov Eff Date
000500000000      *
000600000000      *  (c)Copyright 2007 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - April 30, 2007
000900000000      *_________________________________________________________________________
000901080505     FMCOVC     IF   E           K DISK    Prefix(M_)
000902070430     FPLNMST    IF   E           K DISK    Prefix(P_)
000903070430     FCARMST    IF   E           K DISK    Prefix(C_)
000904080116     fGRAT24    if   e           K disk
000905070430      *
000906080116     d PlanGrp         s             15a   inz
000907070430     D WrkDate         S              8S 0 inz
000908070430     D ISO_DATE        S               D   DATFMT(*ISO)
000909080505     D wdta          e ds                  extname(MEMBER)
000910070430      *
000911070430     C     *entry        Plist
000912080116     C                   Parm                    wdta
000913080116     C                   Parm                    ingrp            15
000914070430     C                   Parm                    OutDate          10
000915070430      *
000916070430     C                   Eval      OutDate = *blanks
000917070430      *
000918080505     C     MEMKEY        Setll     MCOVC
000919080505     C     MEMKEY        Reade     MCOVC                                  50
000920070430     C     *IN50         Doweq     *OFF
000921080505     C                   If        M_ENRLDT <> M_CANDT
000922070430      *
000923070430     C     PlanKey       Chain     PLNMST
000924070430     C                   If        %Found
000925070430     C     P_PCARR       Chain     CARMST
000926080116     C                   If        %Found
000927080116      *
000928080116     C                   Exsr      Rates
000929070430      *
000930080116     C                   If        %trim(plangrp) = %trim(ingrp)
000931070430     C                   Select
000932070430     C                   When      WrkDate = 0
000933080505     C                   Eval      WrkDate = M_ENRLDT
000934080505     C                   When      WrkDate > M_ENRLDT
000935080505     C                   Eval      WrkDate = M_ENRLDT
000936070430     C                   Other
000937070430      * Keep
000938080116     C                   Endsl
000939080116     C                   End
000940070430      *
000941070430     C                   End
000942070430     C                   End
000943070430     C                   End
000944080505     C     MEMKEY        Reade     MCOVC                                  50
000945070430     C                   Enddo
000946070430      *
000947070430     C                   Movel     WrkDate       Input_Date
000948070430     C                   Eval      Input_Format  = 'YYYYMMDD'
000949070430     C                   Eval      Output_Format = 'MM/DD/YYYY'
000950070430     C                   Exsr      FormatDateSR
000951070430     C                   Eval      OutDate       = %trim(Output_Date)
000952070430      *
000953070430     C                   Eval      *inlr = *on
000954070430     C                   Return
000955080116      *
000956080116      *--------------------------------------------------------------------*
000957080116     C     Rates         Begsr
000958080116     C                   Eval      PlanGrp = *blanks
000963080116
000964080116     C     GrtKey        Setll     GRAT24
000965080116     C     GrtKey        Reade     GRAT24
000966080116     C                   Dow       not %eof(GRAT24)
000967080116      * GBS Date Logic
000968080116     C                   If        frmdat <> todat
000969080116     C                   If        todat   = *zeros
000970080116     C                   eval      todat   = 99999999
000971080116     C                   End
000972080505     C                   if        M_ENRLDT >= frmdat and
000973080505     C                             M_ENRLDT <= todat
000974080116      *
000975080116     C                   Eval      plangrp = %trim(group#)
000976080116     C                   Leave
000977080116     C                   end
000978080116     C                   end
000979080116     C     GrtKey        Reade     GRAT24
000980080116     C                   Enddo
000981080116
000982080116     C                   Endsr
001000070430      *
001100070430      *--------------------------------------------------------------------*
001200070430      * KLIST
001300070430      *--------------------------------------------------------------------*
001400070430     C     KLIST         Begsr
001500070430      *
001600080505     C     MEMKey        KLIST
001700080505     C                   KFLD                    MBSSNO
001900070430      *
002000070430     C     PlanKey       KLIST
002100080505     C                   KFLD                    M_MCTRST
002200080505     C                   KFLD                    M_MCSUB#
002300080505     C                   KFLD                    M_MCPlan
002400070430      *
002401080116     C     GrtKey        Klist
002402080505     C                   Kfld                    M_MCTRST
002403080505     C                   Kfld                    M_MCSUB#
002404080505     C                   Kfld                    M_MCPlan
002405080116      *
003900070430     C                   Endsr
004000070430      *___________________________________________________________________
004100070430      * Format Date
004200070430      *___________________________________________________________________
004300070430     C     FormatDateSR  BEGSR
004400070430     C                   Call      'FMTDATE'
004500070430     C                   Parm                    Input_Date       32
004600070430     C                   Parm                    Input_Format     32
004700070430     C                   Parm                    Output_Format    32
004800070430     C                   Parm                    Output_Date      32
004900070430     C                   Parm                    Output_Error     10
005000070430     C                   ENDSR
