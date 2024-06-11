0001009111250002 F******************************************************************
0002000004140003 F* COB151     GROUP BENEFIT SERVICES SOFTWARE           1991      *
0003009111250004 F*                                                                *
0004009111250005 F*            WRITTEN  BY - WALTER J. PICCININI                   *
0005009111250006 F*            DATE - 11/91                                        *
0008009111250012 F*                                                                *
0009009111250013 F*  DESCRIPTION - THIS PROGRAM WILL SPIN THRU MEMBER FILE TO FIND *
0010009111250014 F*                COBRA MEMBERS WHOSE EXPIRATION DATE IS EITHER   *
0011009111250014 F*                ONE MONTH OR SIX MONTHS FROM LDA ENTERED...     *
0013009807290011 F*                                                                *
0014009807290010 F*  Y2K CONVERT - 1998                                            *
0015009807290010 F*                                                                *
0015010111150015 F* 11/14/01 dlk - convert to RPGLE                                *
0015020508010015 F* 08/01/05 dlk - change fill01 to fill02                         *
0015031208060015 F* 08/06/12 dlk - exclude test trusts                             *
0015040111140015 F*                                                                *
0016009111250016 F******************************************************************
0017009111250017 F*                                                                *
0018000111140012 FMEMBER    IP   e             DISK
0018011208060012 Ftrsmst    If   e           k DISK
001900011114     Fmemout    O  A e             DISK    rename(membr:memoutr)
0020009111250049 D                 DS
0021000111140050 D  yymmH                  1      6  0
0021010111140051 D  YYH                    1      4  0
0022000111140051 D  MMH                    5      6  0
0027020111140049 D                 DS
0027030111140050 D  status                 1      2
0027040111140051 D  stat2                  2      2
0028009111220065 D                UDS
002900911122     D  LMM                    1      2  0
003000980729     D  LYY                    3      6  0
003001120806     C* skip test trusts
003002120806     c     mbtrst        chain     trsmst
003003120806     c                   if        not %found(trsmst) or tscode = 'O T'
003004120806     C                   GOTO      END
003005120806     C                   END
005800911122     C*
005900911122     C*   SEE IF COBRA EXPIRATION DATE IS 1 MONTH AWAY FROM LDA DATE...
006000911122     C*
006001011115     c                   movel     cexpdt        cexpdtym          6 0
006002050801     c                   clear                   fill02
007100911122     C*
007200011115     C     yearmonth1    IFEQ      cexpdtym
007301050801     c                   move      1             fill02
007400011114     C                   write     memoutr
007500911122     C                   GOTO      END
007600911122     C                   END
007700911122     C*
007800911122     C*   SEE IF COBRA EXPIRATION DATE IS 6 MONTHS AWAY FROM LDA DATE..
007900911122     C*
008900911122     C*
009000011115     C     yearmonth6    IFEQ      cexpdtym
009102050801     c                   move      2             fill02
009103011114     C                   write     memoutr
009300911122     C                   GOTO      END
009400911122     C                   END
009500911122     C*
009600911122     C     END           TAG
009608011114
009700011114     c     *inzsr        begsr
009705011114     C                   Z-ADD     LYY           YYH
009706011114     C     LMM           ADD       1             MMH
009707011114     C     MMH           IFGT      12
009708011114     C                   Z-ADD     1             MMH
009709011114     C                   ADD       1             YYH
009710011114     C                   END
009711011114     c                   move      yymmh         yearmonth1        6 0
009712011114
009713011114     C                   Z-ADD     LYY           YYH
009714011114     C     LMM           ADD       6             MMH
009715011114     C     MMH           IFGT      12
009716011205     C                   sub       12            MMH
009717011114     C                   ADD       1             YYH
009718011114     C                   END
009719011114     c                   move      yymmh         yearmonth6        6 0
010200011114     c                   endsr
