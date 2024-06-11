000100000000      *_________________________________________________________________________
000200000000      *
000300030828      *  Description:  Dependent Affidavit
000400000000      *
000500000000      *  (c)Copyright 2003 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - August 12, 2003
000800030812      *_________________________________________________________________________
000801081020     FMEMAC#    IF   E           K DISK
001101081020     FDEPEND    IF   E           K DISK
001102081020     FKAT447P   O  A E             DISK
001400030812
001800040308     D CurAge          S              5S 0
002400030910     D Today           S              8s 0 INZ
002600030812    ?D isoDate         S               D   datfmt(*ISO)                         Input Request
002700030827    ?D isobirth        S               D   datfmt(*ISO)                         Input Request
002800030827    ?D isotoday        S               D   datfmt(*ISO)                         Input Request
004701081020
005001081020     C     PKEY          KLIST
005002081020     C                   KFLD                    MBTRST
005003081020     C                   KFLD                    MBSUB#
005004081020     C                   KFLD                    MBACCT
005005081020
005006081020     C                   EVAL      MBTRST  = 590
005007081020     C                   EVAL      MBSUB#  = 008
005008081020     C                   EVAL      MBACCT  = 0001
005009081020
005010081020     C                   EXSR      PART
005011081020
005012081020     C                   Eval      *INLR = *ON
005013081020     C                   return
005014081020      *_________________________________________________________________________
005015081020     C     PART          BEGSR
005017081020     C     PKEY          Setll     MEMAC#
005018081020     C     PKEY          reade     MEMAC#
005019081020     C                   Dow       not %eof(MEMAC#)
005020081020
005022081020     C                   If        TERMDT = 0
005023081020
013200030827     C                   Z-add     0             Curage
013400081020     C     *ISO          Move      birth         isoBirth
013500030827     C     *ISO          Move      Today         isoToday
013600081020     C     isoToday      Subdur    IsoBirth      Curage:*Y
013601081020
013602081020     C                   eval      age = curage
013603081020     C                   eval      type  = 'E'
013604081020     C                   If        Curage > 64
013605081020     C                   Write     KATPR
013606081020     C                   End
013607081020
013608081020     C                   EXSR      DEPN
014001081020
014002081020     C                   End
014003081020     C     PKEY          reade     MEMAC#
014004081020     C                   enddo
014005081020
014006081020     C                   ENDSR
014007081020      *_________________________________________________________________________
014008081020     C     DEPN          BEGSR
014014081020      *
014016081020     C     MBSSNO        Setll     DEPEND
014017081020     C     MBSSNO        reade     DEPEND
014018081020     C                   Dow       not %eof(DEPEND)
014019081020
014021081020     C                   If        DPDLTD = 'A'
014022081020
014023081020     C                   Z-add     0             Curage
014024081020     C     *ISO          Move      dbirth        isoBirth
014025081020     C     *ISO          Move      Today         isoToday
014026081020     C     isoToday      Subdur    IsoBirth      Curage:*Y
014027081020
014028081020     C                   eval      type  = 'D'
014029081020     C                   eval      page = curage
014030081020     C                   eval      mlname = %trim(dlname)
014031081020     C                   eval      mfname = %trim(dfname)
014032081020     C                   eval      mmi    = %trim(dmi)
014033081020     C                   eval      addr1  = %trim(daddr1)
014034081020     C                   eval      addr2  = %trim(daddr2)
014035081020     C                   eval      city  = %trim(dcity)
014036081020     C                   eval      state  = %trim(dstate)
014037081020     C                   eval      zip  = dzip
014038081020     C                   If        Curage > 64
014039081020     C                   Write     KATPR
014040081020     C                   End
014041081020     C                   End
014042081020
014043081020     C     MBSSNO        reade     DEPEND
014044081020     C                   enddo
014045081020
014046081020     C                   ENDSR
021700000000      *_________________________________________________________________________
021800000000      * Program open
021900000000      *___________________________________________________________________
022000000000     C     *INZSR        BEGSR
022800030812     C     *Date         Mult      10000.0001    Today
024200000000     C                   ENDSR
