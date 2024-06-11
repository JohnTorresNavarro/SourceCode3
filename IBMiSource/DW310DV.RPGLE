000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Get Depend Earliest Cov Eff Date
000500000000      *
000600000000      *  (c)Copyright 2007 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - April 30, 2007
000900000000      *_________________________________________________________________________
000901070430     FDCOVC     IF   E           K DISK    Prefix(D_)
000902070430     FPLNMST    IF   E           K DISK    Prefix(P_)
000903070430     FCARMST    IF   E           K DISK    Prefix(C_)
000904080116     fGRAT24    if   e           K disk
000905070430      *
000906080116     d PlanGrp         s             15a   inz
000907070430     D WrkDate         S              8S 0 inz
000908070430     D ISO_DATE        S               D   DATFMT(*ISO)
000909070430     D wdta          e ds                  extname(depend)
000910070430      *
000911070430     C     *entry        Plist
000912080116     C                   Parm                    wdta
000913080116     C                   Parm                    ingrp            15
000914070430     C                   Parm                    OutDate          10
000915070430      *
000916070430     C                   Eval      OutDate = *blanks
000917070430      *
000918070430     C     DEPKEY        Setll     DCOVC
000919070430     C     DEPKEY        Reade     DCOVC                                  50
000920070430     C     *IN50         Doweq     *OFF
000921070430     C                   If        D_DENRDT <> D_CCANDT
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
000933070430     C                   Eval      WrkDate = D_DENRDT
000934070430     C                   When      WrkDate > D_DENRDT
000935070430     C                   Eval      WrkDate = D_DENRDT
000936070430     C                   Other
000937070430      * Keep
000938080116     C                   Endsl
000939080116     C                   End
000940070430      *
000941070430     C                   End
000942070430     C                   End
000943070430     C                   End
000944070430     C     DEPKEY        Reade     DCOVC                                  50
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
000972080116     C                   if        D_DENRDT >= frmdat and
000973080116     C                             D_DENRDT <= todat
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
001600070430     C     DepKey        KLIST
001700070430     C                   KFLD                    DSSNO
001800070430     C                   KFLD                    DPSEQ#
001900070430      *
002000070430     C     PlanKey       KLIST
002100070430     C                   KFLD                    D_DVTRST
002200070430     C                   KFLD                    D_DVSUB#
002300070430     C                   KFLD                    D_DVPlan
002400070430      *
002401080116     C     GrtKey        Klist
002402080116     C                   Kfld                    D_DVTRST
002403080116     C                   Kfld                    D_DVSUB#
002404080116     C                   Kfld                    D_DVPlan
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
