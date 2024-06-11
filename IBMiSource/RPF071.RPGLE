0001009408170002 F******************************************************************
0002000207030003 F* rpf071     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000207030006 F*            DATE - 07/03/02                                     *
0006009408170007 F*                                                                *
0007000207030008 F*  DESCRIPTION - display rp170out file on screen                 *
0009009408170010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012000207030013 Frpf071d   CF   E             WORKSTN
001300970401     F                                     SFILE(SF01:RRN)
0014000207030015 Frp170out  iF   E           K DISK
0015009703310015 FACCMST    IF   E           K DISK
001501020709     D mdyy            s               d   datfmt(*usa)
001900970401     D                 DS
002000970401     D  TSA                    1     10  0
002100020703     D  rptrust                1      3  0
002200020703     D  rpsub                  4      6  0
002300020703     D  rpacc                  7     10  0
004300020702
008500970401     C*
008600970401     C* CLEAR SUBFILE
008700970401     C*
008800970401     C                   MOVEA     '001'         *IN(90)
008900970401     C                   WRITE     SF01CTL
009000970401     C                   MOVE      '0'           *IN92
009100970401     C*
009200970401     C* BUILD SUBFILE
009300970401     C*
009400970401     C                   MOVE      *ZEROS        RRN               5 0
009500020703     C     *LOVAL        SETLL     rp170out
009501020702
009600020703     C                   dou       %eof(rp170out)
009601020702
009700020703     C                   READ      rp170out                               91
009800020702     C                   if        *in91 = *off
009900020703     C     ackey         CHAIN     ACCMST                             50
009901020702     c                   if        %found(accmst)
009902020702     C                   MOVEL     ACNAM1        NAME
009903020702     c                   else
010000020702     C                   clear                   NAME
010001020702     c                   end
010125020701
010126020709     c                   move      rptrdate      mdyy
010127020709     c                   move      mdyy          dateout
010200970401     C                   ADD       1             RRN
010300970401     C                   WRITE     SF01
010500970401     C                   END
010501020702
010502020702     c                   enddo
010600970401     C*
010700970401     C* DISPLAY SUBFILE IN WINDOW
010800970401     C*
011000020703     C                   if        rrn > 0
011100020703     C                   eval      *in90 = *on
011200020703     C                   end
011300970401     C*
011400970401     C                   WRITE     WINDOW
011500970401     C                   EXFMT     SF01CTL
011959020701
011960020703     c                   eval      *inlr = *on
011961020703
012000020701     C     *inzsr        BEGSR
012014020703     C     ackey         KLIST
012015020703     C                   KFLD                    rptrust
012016020703     C                   KFLD                    rpsub
012017020703     C                   KFLD                    rpacc
012100020701     C                   ENDSR
