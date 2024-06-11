0001009602140002 F******************************************************************
0002009909300003 F* RPF120     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009602140004 F*                                                                *
0004009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009802200006 F*            DATE -  2/20/98                                     *
0006009602140007 F*                                                                *
0007009802200008 F*  DESCRIPTION - COST CENTER MAINT                               *
0008009602140012 F*                                                                *
0009009812220014 F*                                                                *
0010009812220010 F*  Y2K CONVERT - 1998                                            *
0011009812220015 F*                                                                *
0012009602140013 F******************************************************************
001300980220     FRPF120D   CF   E             WORKSTN
001400980220     FMEMBER    UF   E           K DISK
001500980220     FCODES     IF   E           K DISK
0016009708070124 D                UDS
0017009708070054 D  CONAME               201    240
001800980220     C     CODKEY        KLIST
001900980220     C                   KFLD                    TYPE              1
002000980220     C                   KFLD                    CC                2
002100921015     C*
002200960208     C* WRITE FIRST SCREEN
002300960208     C*
002400960206     C     #T0010        TAG
002500980220     C                   MOVE      *ZEROS        MBSSNO
002600961111     C     #T0015        TAG
002700961030     C                   EXFMT     SCRN01
002800921013     C*
002900960208     C* CMD7 END
003000960208     C*
003100960208     C     *INKG         CABEQ     '1'           #END
003200970808     C*
003300980220     C     MBSSNO        CHAIN     MEMBER                             61
003400980220     C     *IN61         CABEQ     *ON           #T0015
003500980220     C*
003600980220     C     #T0020        TAG
003700980220     C                   EXFMT     SCRN02
003800980220     C*
003900980220     C     *INKG         CABEQ     '1'           #END
004000980220     C     *INKA         CABEQ     '1'           #T0015
004100980220     C*
004200980220     C                   MOVEL     CCFLG         TYPE
004300980220     C                   MOVE      CCFLG         CC
004400980220     C     CCFLG         IFNE      *BLANKS
004500980220     C     CODKEY        CHAIN     CODES                              60
004600980220     C     *IN60         CABEQ     *ON           #T0020
004700980220     C                   END
004800980220     C*
004900980220     C                   UPDATE    MEMBR
005000960208     C*
005100960219     C                   GOTO      #T0010
005200960208     C*
005300960208     C     #END          TAG
005400960208     C                   MOVE      '1'           *INLR
