0001009408170002 F******************************************************************
0002000207050003 F* rpf072     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000207050006 F*            DATE - 07/05/02                                     *
0006009408170007 F*                                                                *
0007000207050008 F*  DESCRIPTION - create a copy of accmst with only the accts in  *
0009000207050010 F*                rp170out for rpf070 to read.                    *
0009010207050010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0014000207050015 Frp170out  ip   E             DISK
0015000207050015 FACCmst    IF   E           K DISK
0015010207100015 FACCwk070  o  a e             DISK    rename(accmsr:accmsrwk)
009900020705     C     ackey         CHAIN     ACCMST
009901020702     c                   if        %found(accmst)
009902020705     C                   write     accmsrwk
010001020702     c                   end
010125020701
012000020701     C     *inzsr        BEGSR
012014020703     C     ackey         KLIST
012015020703     C                   KFLD                    rptrust
012016020703     C                   KFLD                    rpsub
012017020703     C                   KFLD                    rpacc
012100020701     C                   ENDSR
