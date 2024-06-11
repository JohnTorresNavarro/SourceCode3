0001009408170002 F******************************************************************
0002000207020003 F* fm181      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000207020006 F*            DATE - 07/02/02                                     *
0006009408170007 F*                                                                *
0007000207020008 F*  DESCRIPTION - read ulexcl and create a work file in qtemp     *
0008000207020009 F*            containning the current aa code for use in a report *
0009000207020010 F*            to follow that is sorted by aa/account.             *
0009010207020010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0014000207020015 Fulexcl    ip   E             DISK
0014010207020015 Faccmst    if   E           k DISK
0015000207020015 Fulwk      o  a E             DISK    rename (ulr:ulwkr)
006100020702     C     ulkey         CHAIN     ACCMST
006101020702
006102020702     c                   if        %found(accmst)
006103020702     c                   move      aacode        ulaawk
007200020702     C                   WRITE     ulwkr
007300970401     C                   END
007301020702
012000020701     C     *inzsr        BEGSR
012010020702     C     ulkey         KLIST
012011020702     C                   KFLD                    ultrust
012012020701     C                   KFLD                    ulSUB
012013020701     C                   KFLD                    ulACC
012100020701     C                   ENDSR
