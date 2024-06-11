0001009807210002 F*---------------------------------------------------------------**
0002009909300003 F* FL155      GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009710210005 F*            WRITTEN BY - MARY L FONTI                           *
0004009807210006 F*            DATE - 07/98                                        *
0005009211230007 F*                                                                *
0006009807210006 F*  DESCRIPTION - THIS PROGRAM WILL LIST COST CENTER CODE FILE    *
0007009807210007 F*                "Y" ONLY.                                       *
000800981118     F*11/18/98 DLW CHANGE UDATE TO *DATE GET 8 BYTE DATE Y2K COMPLIANT
0008010003200007 F* 03/20/00 dlk - fix program to list all cost centers            *
0008020205240007 F*  5/24/02 szz - Recompiled over new AACODE file                 *
0008030003200007 F*                                                                *
0008040003200007 F*                                                                *
0009009710210009 F*---------------------------------------------------------------**
001000980721     FMEMBER    IP   E           K DISK
001100980721     FACCMST    IF   E           K DISK
001200980721     FCODES     IF   E           K DISK
001300980721     FAACODE    IF   E           K DISK
001400980721     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
0015009807210053 D                UDS
001600980721     D  USERID                25     32
0017009807210054 D  CONAME               201    240
001900980721     IACCMSR
002000980721     I              AACODE                      CODEA
0022009807210035 IMEMBR
0023009807210039 I                                          CCFLG         L1
0023010003200039 I                                          mbtrst        L1
0023020003200039 I                                          mbsub#        L1
0023030003200039 I                                          mbacct        L1
002800980721     C     MBRKEY        KLIST
002900980721     C                   KFLD                    MBTRST
003000980721     C                   KFLD                    MBSUB#
003100980721     C                   KFLD                    MBACCT
003101000320     C     codKEY        KLIST
003102000320     C                   KFLD                    cctype
003103000320     C                   KFLD                    cccode
003200971031     C*
003300971031     C     *IN99         IFEQ      '0'
003400971031     C                   EXCEPT    HEAD
003500971031     C                   MOVEA     '1'           *IN(99)
003600971031     C                   END
003700971031     C*
003701000320     c                   if        *inl1
003702000320
004600980721     C     MBRKEY        CHAIN     ACCMST                             61
004700980721     C     *IN61         IFEQ      '0'
004800980721     C                   MOVE      *BLANKS       NAME             25
005100980721     C                   MOVEL     ACNAM1        NAME
005200000320     C     CODEA         CHAIN     AACODE                             81
005300980721     C     *IN81         IFEQ      '0'
005400980721     C                   MOVE      *BLANKS       ANAME            15
005500980721     C                   MOVEL     ALNAM         ANAME
005600980721     C                   END
005700980721     C                   END
005701000320
005702000320     c                   movel     ccflg         cctype            1
005703000320     c                   move      ccflg         cccode            2
005800000320     C     codkey        CHAIN     CODES                              71
005900980721     C     *IN71         IFEQ      '0'
006000980721     C                   MOVE      *BLANKS       LDESC            25
006100980721     C                   MOVEL     LDESCR        LDESC
006200980721     C                   END
006201000320
006300980721     C                   EXCEPT    DETL
006700971022     C*
006800971022     C   OF              EXCEPT    HEAD
006801000320     c                   endif
006802000320
006900971031     C*
007000971031     CLRN99              EXCEPT    HEAD
007100971028     C*------------------------------------------------------
0072009710220237 OQSYSPRT   E            HEAD           1 03
0073009807220248 O                                           16 'PGM      : FL155'
0074009807220240 O                       CONAME              86
0075009807210249 O                                          125 'PAGE :'
0076009807210250 O                       PAGE          Z    132
0077009710220251 O          E            HEAD           2
0078009807210253 O                                           10 'RUN DATE :'
0079009811180254 O                       *DATE               21 '  /  /    '
0080009807210244 O                                           78 'COST CENTER CODE FILE LI'
0081009807210245 O                                           83 'STING'
0082009710220257 O          E            HEAD           1
0083009710240259 O                                           24 '""""""""""""""""""""""""'
0084009710240260 O                                           48 '""""""""""""""""""""""""'
0085009710240261 O                                           72 '""""""""""""""""""""""""'
0086009807210284 O                                           96 '""""""""""""""""""""""""'
0087000003200284 O                                          120 '""""""""""""""""""""""""'
0087010003200284 O                                          132 '""""""""""""'
0089009710280265 O          E            HEAD           1
009000980721     O                                           66 '           '
0091009710220265 O          E            HEAD           1
009200980722     O                                            5 'CODE'
009300980721     O                                           18 'SHORT DESC'
009400980721     O                                           43 'LONG DESC'
009500980721     O                                           76 'ACCOUNT #'
009600980721     O                                           99 'ACCOUNT NAME'
009700980721     O                                          114 'AA#'
009800980721     O                                          130 'ADMINISTRATOR'
0099009710220279 O          E            HEAD           2
0100009710240281 O                                           24 '""""""""""""""""""""""""'
0101009710240282 O                                           48 '""""""""""""""""""""""""'
0102009710240283 O                                           72 '""""""""""""""""""""""""'
0103009807210284 O                                           96 '""""""""""""""""""""""""'
0104000003200284 O                                          120 '""""""""""""""""""""""""'
0105000003200284 O                                          132 '""""""""""""'
0106009710220265 O          E            DETL           1
010800000320     O                       cctype               1
010801000320     O                       cccode               5
010900980721     O                       SDESCR         B    18
011000980721     O                       LDESC          B    50
011100980721     O                       MBTRST         B    69
011200980721     O                                           70 '-'
011300980721     O                       MBSUB#         B    73
011400980721     O                                           74 '-'
011500980721     O                       MBACCT         B    78
011600980721     O                       NAME           B   108
011700980721     O                       CODEA          B   114
011800980721     O                       ANAME          B   132
