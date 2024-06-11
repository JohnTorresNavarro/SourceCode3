0001009408170002 F******************************************************************
0002001001290003 F* OSD072     GROUP BENEFIT SERVICES SOFTWARE                     *
0006009408170007 F*                                                                *
0007000207050008 F*  DESCRIPTION - create a copy of accmst with only the accts in  *
0009001001290010 F*                OS170OUT for OSD070 to read.                    *
0009010207050010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0014001001290015 FOS170OUT  ip   E             DISK
0015001001290015 FACCMST    IF   E           K DISK
0015011001290015 FOSDWK070  o  a e             DISK    rename(accmsr:accmsrwk)
009900020705     C     ackey         CHAIN     ACCMST
009901020702     c                   if        %found(accmst)
009902020705     C                   write     accmsrwk
010001020702     c                   end
010125020701
012000020701     C     *inzsr        BEGSR
012014020703     C     ackey         KLIST
012015100129     C                   KFLD                    OSTRUST
012016100129     C                   KFLD                    OSSUB
012017100129     C                   KFLD                    OSACC
012100020701     C                   ENDSR
