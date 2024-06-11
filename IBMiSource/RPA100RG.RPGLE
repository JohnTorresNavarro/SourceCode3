000100980218      * RPA100RG - Prints a listing of BlueCross/BlueShield accounts with
000200980211      *            51 or more members.
000300980210      *            MCOV is ordered by trust/sub/acct/ssn, and includes only
000400980210      *            active members (MCDLTD = 'A'), & Subscribers (MDSEQ# = 00)
000500980210      *
000600980224      * 2/24/98 GSPHIPPS
000700990316      *
000800980210      *       mm/dd/yy gsp  ....
000900990223      *
001000990223      *  DMA 2.23.99  fixed Y2K loop and 'illogic'
001100990223      *
001200980218     FACCMST    IF   E           K DISK
001300980218     FCARMST    IF   E           K DISK
001400980218     FGRATE     IF   E           K DISK
001500980220     FMCOV      IP   E             DISK
001600980218     FPLNMST    IF   E           K DISK
001700980218     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
001800980218      *
001900980224     D GRP             S             15    DIM(9)
002000980223     D***                                           MCSSNOL4
002100980218     D                 DS
002200980218     D  ANVYM                  1      6  0
002300980218     D  ANVCY                  1      4  0
002400980218     D  ANVCC                  1      2  0
002500980218     D  ANVYY                  3      4  0
002600980218     D  ANVMM                  5      6  0
002700980218      *
002800980218     IMCOVR         01
002900980218     I                                          MCTRST        L5
003000980218     I                                          MCSUB#        L5
003100980218     I                                          ACC#          L5
003200980223     I                                          MCPLAN        L4
003300980218     C/EJECT
003400980218     C                   MOVE      MCTRST        KPTRST
003500980218     C                   MOVE      MCSUB#        KPSUB#
003600980218     C                   MOVE      MCPLAN        KPPLAN
003700980218      *
003800980218     C     PLNKEY        CHAIN     PLNMST                             98
003900980218      *
004000980218     C                   MOVE      PCARR         KCCARR            3
004100980218     C     KCCARR        CHAIN     CARMST                             97
004200980218      *
004300980218      * Determine if plan is BC/BS which is CARBC = 1-4
004400980218     C                   SELECT
004500980218     C     CARBC         WHENEQ    '1'
004600980218     C                   EXSR      CNTMBR
004700980218     C     CARBC         WHENEQ    '2'
004800980218     C                   EXSR      CNTMBR
004900980218     C     CARBC         WHENEQ    '3'
005000980218     C                   EXSR      CNTMBR
005100980218     C     CARBC         WHENEQ    '4'
005200980218     C                   EXSR      CNTMBR
005300980218     C                   ENDSL
005400980219     C/EJECT
005500980224     CL4                 DO
005600980224     CL0                 ADD       L4CNT         L5CNT
005700980220     CL0                 Z-ADD     *ZEROS        L4CNT
005800980219     CL0                 ENDDO
005900980219      **
006000980218     CL5                 DO
006100980219     CL0   L5CNT         IFGE      51
006200980216      **
006300980218     CL0                 MOVE      MCTRST        KATRST
006400980218     CL0                 MOVE      MCSUB#        KASUB#
006500980218     CL0                 MOVE      ACC#          KAACC#
006600980216      *
006700980218     CL0   ACCKEY        CHAIN     ACCMST                             96
006800980216      **
006900980223     CL0                 EXSR      RENLSR
007000980216      **
007100981130     CL0                 MOVE      ENRLDT        CYMD#             8
007200981130     CL0                 EXSR      #CYMD8
007300981130     CL0                 MOVE      MDCY#         ENRDAT            8 0
007400980224     CL0                 EXCEPT    L5OUT
007500980218     CL0                 ADD       1             ACCCNT            3 0
007600980219     CL0                 ADD       L5CNT         LRCNT             6 0
007700980218     CL0                 ENDIF
007800980224     CL0                 Z-ADD     *ZEROS        L5CNT             4 0
007900980218     CL0                 Z-ADD     1             X
008000980224     CL0                 MOVE      *BLANKS       GRP
008100980223      **
008200980218     CL0   *INOF         IFEQ      *ON
008300980218     CL0                 EXCEPT    HEADER
008400980218     CL0                 MOVE      *OFF          *INOF
008500980218     CL0                 ENDIF
008600980218     CL0                 ENDDO
008700980218      *
008800980224     C** TEST              EXCPTHEADER   possible future enhancment
008900980223     CLR                 EXCEPT    LROUT
009000980219     C/EJECT
009100980218      **------------------------**
009200980218     C     CNTMBR        BEGSR
009300980218      **------------------------**
009400980218      *
009500980218     C     MCSSNO        IFNE      HLDSSN
009600980218      * Date test - is this an active member?
009700980223     C*  *       CANDT     IFEQ *ZEROS
009800980223     C*  *                 MOVE '0'       INVREC  1
009900980223     C*  *                 ELSE
010000980223      *  *
010100980223     C*  *       UDATE     IFLT ENRLDT
010200980223     C*  *       UDATE     ORGT CANDT
010300980223     C*  *                 MOVE '1'       INVREC
010400980223     C*  *                 ENDIF                           udate if/and
010500980223     C*  *                 ENDIF                           candt = 0
010600980223      *  *
010700980223     C*  *       INVREC    IFEQ '1'
010800980223     C*  *                 GOTO ENDSBR
010900980223     C*  *                 ENDIF                           invrec = 1
011000980219      *
011100980219     C                   ADD       1             L4CNT             4 0
011200980218     C                   MOVE      MCSSNO        HLDSSN            9 0
011300980218     C                   ENDIF
011400980223     C                   EXSR      GRP#SR
011500980218      *
011600980219     C     ENDSBR        ENDSR
011700980219      **------------------------**
011800980219     C     GRP#SR        BEGSR
011900980219      **------------------------**
012000980219      *
012100980219     C                   MOVE      *OFF          *IN77
012200980219     C                   MOVE      *OFF          *IN88
012300980219      *
012400980219     C                   MOVE      MCTRST        KGTRST
012500980219     C                   MOVE      MCSUB#        KGSUB#
012600980219     C                   MOVE      MCPLAN        KGPLAN
012700980219     C                   MOVE      *ZEROS        KGAGEB
012800980219     C                   MOVE      MCOVTP        KGTYPE
012900980219      *
013000980219     C     GRAKEY        CHAIN     GRATE                              95
013100980219      *
013200980219     C     *IN95         IFEQ      *OFF
013300980224      * Look for Group# in array
013400980224      * If found bypass remainder of routine
013500980224      * If not found reset indx to 1 and look for blank element
013600980224      *  to store Group#
013700980224      **
013800980224     C                   Z-ADD     1             X                 2 0
013900980224      *
014000980224     C     X             DOUGT     9
014100980224      *
014200980224     C     GRP(X)        IFEQ      *BLANKS
014300980224     C                   MOVE      GROUP#        GRP(X)
014400980224     C                   ELSE
014500980224      *
014600980224     C     GRP(X)        IFEQ      GROUP#
014700980224     C                   LEAVE
014800980224     C                   ELSE
014900980224     C                   ADD       1             X
015000980224     C                   ENDIF
015100980224     C                   ENDIF
015200980224     C                   ENDDO
015300980219     C                   ENDIF
015400980219     C     ENDGRP        ENDSR
015500980218      **------------------------**
015600980218     C     RENLSR        BEGSR
015700980218      **------------------------**
015800980218     C     RNEWPD        IFNE      *ZEROS
015900990223     C                   MOVEL     ENROLL        ANVYM
016000980218      *
016100980218     C     ANVYM         DOUGE     RUNCYM
016200980218     C                   ADD       RNEWPD        ANVMM
016300980218      *
016400980218     C     ANVMM         DOWGT     12
016500980218     C                   SUB       12            ANVMM
016600980218     C                   ADD       1             ANVYY
016700990223     C     ANVYY         IFEQ      0
016800990223     C                   Z-ADD     20            ANVCC
016900990223     C                   ENDIF
017000980224     C                   ENDDO
017100980224     C                   ENDDO
017200980218     C                   ENDIF
017300980218     C                   ENDSR
017400980218      **------------------------**
017500980218     C     *INZSR        BEGSR
017600980218      **------------------------**
017700980218     C     *ENTRY        PLIST
017800980218     C                   PARM                    CONAME           40
017900980218      * Account Master file
018000980218     C     ACCKEY        KLIST
018100980218     C                   KFLD                    KATRST            3 0
018200980218     C                   KFLD                    KASUB#            3 0
018300980218     C                   KFLD                    KAACC#            4 0
018400980216      * Group Rate file
018500980218     C     GRAKEY        KLIST
018600980218     C                   KFLD                    KGTRST            3 0
018700980218     C                   KFLD                    KGSUB#            3 0
018800981130     C                   KFLD                    KGPLAN            4
018900980218     C                   KFLD                    KGAGEB            2 0
019000980218     C                   KFLD                    KGTYPE            3
019100980224      * Plan Master file
019200980224     C     PLNKEY        KLIST
019300980224     C                   KFLD                    KPTRST            3 0
019400980224     C                   KFLD                    KPSUB#            3 0
019500981130     C                   KFLD                    KPPLAN            4
019600980218      *
019700980218     C                   TIME                    #TIME            12 0
019800980218     C                   MOVEL     #TIME         TOR               6 0
019900980218      *
020000980218     C                   MOVEL     *YEAR         RUNCYM            6 0
020100980218     C                   MOVE      *MONTH        RUNCYM
020200980224*******                    MOVE UDATE     LYY     20
020300980224*******                    MOVELUDATE     LMM     20
020400980224*******                    MOVELLYY       LDAYM   40
020500980224*******                    MOVE LMM       LDAYM
020600980218     C                   EXCEPT    HEADER
020700980218      *
020800980218     C                   ENDSR
020900981130     C*****************************************************************
021000981130     C* REARRANGE DATE / CCYYMMDD TO MMDDCCYY                         *
021100981130     C*****************************************************************
021200981130     C     #CYMD8        BEGSR
021300981130     C                   MOVE      CYMD#         MMDD#             4
021400981130     C                   MOVEL     CYMD#         CCYY#             4
021500981130     C                   MOVEL     MMDD#         MDCY#             8
021600981130     C                   MOVE      CCYY#         MDCY#
021700981130     C                   ENDSR
021800981130     C*****************************************************************
021900980224     O/EJECT
022000980220     OREPORT    E            HEADER      0  2  1
022100980206     O                                           78 '*****'
022200980206     O                       CONAME             118
022300980206     O                                          124 '*****'
022400980216     O          E            HEADER         1
022500980219     O                                           10 'RPA100RG'
022600980206     O                                          105 'BC/BS 51+ REPORT'
022700980206     O                                          185 'PAGE:'
022800980206     O                       PAGE          Z    192
022900980216     O          E            HEADER         1
023000980219     O                       TOR                 10 '  :  :  '
023100980216     O          E            HEADER         1
023200980206     O                       *DATE         Y     10
023300980216     O          E            HEADER      1  1
023400980224     O                                           61 'Member'
023500990512     O                                           72 'Enroll'
023600990512     O                                           80 'Renew'
023700990512     O                                           88 'Renew'
023800980216     O          E            HEADER         1
023900980224     O                                           13 'Trst Sub Acct'
024000980224     O                                           27 'Account Name'
024100980224     O                                           61 'Count'
024200990512     O                                           72 'Date'
024300990512     O                                           80 'Period'
024400990512     O                                           88 'Date'
024500980224     O          E            HEADER         1
024600980206     O                                           24 '------------------------'
024700980206     O                                           48 '------------------------'
024800980206     O                                           72 '------------------------'
024900980206     O                                           96 '------------------------'
025000980206     O                                          120 '------------------------'
025100980206     O                                          144 '------------------------'
025200980206     O                                          168 '------------------------'
025300980206     O                                          192 '------------------------'
025400980206     O                                          198 '------'
025500980224     O          E            HEADER         1
025600980224     O                                           76 'Group Numbers'
025700980224     O          E            HEADER         2
025800980224     O                                           24 '------------------------'
025900980224     O                                           48 '------------------------'
026000980224     O                                           72 '------------------------'
026100980224     O                                           96 '------------------------'
026200980224     O                                          120 '------------------------'
026300980224     O                                          144 '------------------------'
026400980224     O                                          168 '------------------------'
026500981130     O                                          192 '------------------------'
026600980224     O                                          198 '------'
026700980224      **
026800980223     O          E            L5OUT          1
026900980224     O                       MCTRST               4
027000980224     O                       MCSUB#               8
027100980224     O                       ACC#                13
027200980224     O                       ACNAM1              55
027300980224     O                       L5CNT         2     61
027400990512     O                       ENRDAT        Y     72
027500990512     O                       RNEWPD              79
027600990512     O                       ANVMM          B    84
027700990512     O                                           85 '/'
027800990512     O                       ANVCY          B    89
027900980224      *
028000980224     O          E            L5OUT          1
028100980224     O                       GRP            B   198
028200980223     O          E            LROUT       1  1
028300980212     O                                           24 '*** # of Accts w/51+ ***'
028400980224     O                       ACCCNT        2     35
028500980219     O                                           85 '*** Grand Total ***'
028600980224     O                       LRCNT         2     93
