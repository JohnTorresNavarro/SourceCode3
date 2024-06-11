000100981215      ****************************************************************
000200981215      *                                                              *
000300981215      * CR090RG - Prints a listing of BlueCross/BlueShield members   *
000400981215      *         enrolled 15 days prior to the BC/BS Effective Date.  *
000500981215      *         MCOV is ordered by trust/sub/acct/ssn, and includes only
000600981215      *         active members (MCDLTD = 'A'), & Subscribers (MDSEQ# = 00)
000700981215      *                                                              *
000800981215      *  6.01.98 GSPHIPPS                                            *
000900981215      *                                                              *
001000981215      *    JGE  12.13.98 - Modified for Y2k date conversion          *
001100981215      *        JGE01   All dates modified to use a 4 digit year for  *
001200981215      *                comparisons and output.  File record lengths  *
001300981215      *                modified as needed for new date positions.    *
001400981215      *                                                              *
001500981215      ****************************************************************
001600980603     FMCOV      IP   E             DISK
001700980218     FCARMST    IF   E           K DISK
001800980218     FGRATE     IF   E           K DISK
001900980218     FPLNMST    IF   E           K DISK
002000980218     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
002100980218     IMCOVR         01
002200980218     I                                          MCTRST        L5
002300980218     I                                          MCSUB#        L5
002400980218     I                                          ACC#          L5
002500980605     I*                                             MCPLANL4
002600981215     I*                                             MCSSNOL4
002700980604     C                   MOVE      DOR           MDCY              8
002800980604     C                   EXSR      #YMDSR
002900980604     C                   MOVE      CYMD          JOBDTE            8 0
003000981215     C*
003100981215JGE01C     JOBDTE        IFLE      ENRLDT
003200980218     C                   MOVE      MCTRST        KPTRST
003300980218     C                   MOVE      MCSUB#        KPSUB#
003400980218     C                   MOVE      MCPLAN        KPPLAN
003500981215     C*
003600980218     C     PLNKEY        CHAIN     PLNMST                             98
003700981215     C*
003800980218     C                   MOVE      PCARR         KCCARR            3
003900980218     C     KCCARR        CHAIN     CARMST                             97
004000981215     C*
004100981215      *  Determine if plan is BC/BS which is CARBC = 1-4
004200981215      *  C. Fabiszak is only interested in 1 & 2 at this time
004300981215     C*
004400980218     C                   SELECT
004500980218     C     CARBC         WHENEQ    '1'
004600980218     C                   EXSR      CNTMBR
004700980218     C     CARBC         WHENEQ    '2'
004800980218     C                   EXSR      CNTMBR
004900980218     C                   ENDSL
005000980605     C                   ENDIF
005100980219     C/EJECT
005200981215     C*
005300980605     CL5                 DO
005400981215     C*
005500980605     CL0                 ADD       L4CNT         L5CNT
005600980605     CL0                 Z-ADD     *ZEROS        L4CNT
005700980605     CL0                 ADD       L5CNT         LRCNT             6 0
005800981215     C*
005900980605     CL0   L5CNT         IFNE      *ZEROS
006000980605     CL0                 EXCEPT    L5OUT
006100980605     CL0                 Z-ADD     *ZEROS        L5CNT             4 0
006200980605     CL0                 ADD       1             ACCCNT            3 0
006300980605     CL0                 ENDIF
006400981215      *
006500980605     CL0   *INOF         IFEQ      *ON
006600980605     CL0                 EXCEPT    HEADER
006700980605     CL0                 MOVE      *OFF          *INOF
006800980605     CL0                 ENDIF
006900980605     CL0                 ENDDO
007000981215     C*
007100980223     CLR                 EXCEPT    LROUT
007200980219     C/EJECT
007300980604      **--------------------------------------------**
007400980604      * Change date format from mmddccyy to ccyymmdd
007500980604      **--------------------------------------------**
007600981215JGE01C     #YMDSR        BEGSR
007700981215JGE01C                   MOVE      MDCY          CCYY              4
007800981215JGE01C                   MOVEL     MDCY          MMDD              4
007900981215JGE01C     CCYY          CAT       MMDD:0        CYMD              8
008000981215JGE01C                   ENDSR
008100981215     C*
008200981215      **--------------------------------------------**
008300980218     C     CNTMBR        BEGSR
008400981215      **--------------------------------------------**
008500981215     C*
008600980218     C     MCSSNO        IFNE      HLDSSN
008700980219     C                   ADD       1             L4CNT             4 0
008800980218     C                   MOVE      MCSSNO        HLDSSN            9 0
008900980218     C                   ENDIF
009000980223     C                   EXSR      GRP#SR
009100981215     C*
009200980603     C     *INOF         IFEQ      *ON
009300980603     C                   EXCEPT    HEADER
009400980603     C                   MOVE      *OFF          *INOF
009500980603     C                   ENDIF
009600990323     C                   EXSR      DATE01
009700980603     C                   EXCEPT    MBRDTL
009800981215     C*
009900980219     C     ENDSBR        ENDSR
010000981215      *
010100990105      **--------------------------------------------**
010200980219     C     GRP#SR        BEGSR
010300990105      **--------------------------------------------**
010400981215     C*
010500980219     C                   MOVE      *OFF          *IN77
010600980219     C                   MOVE      *OFF          *IN88
010700981215     C*
010800980219     C                   MOVE      MCTRST        KGTRST
010900980219     C                   MOVE      MCSUB#        KGSUB#
011000980219     C                   MOVE      MCPLAN        KGPLAN
011100980219     C                   MOVE      *ZEROS        KGAGEB
011200980219     C                   MOVE      MCOVTP        KGTYPE
011300981215     C*
011400980219     C     GRAKEY        CHAIN     GRATE                              95
011500981215     C*
011600980219     C     *IN95         IFEQ      *OFF
011700980602     C                   MOVE      GROUP#        GRPOUT           15
011800980219     C                   ENDIF
011900980219     C     ENDGRP        ENDSR
012000990105JGE01C***
012100990105JGE01C*****************************************************
012200990105JGE01C*  SUBROUTINE TO REVERSE ALL FILE DATES USED
012300990105JGE01C*  FROM YYYYMMDD TO MMDDYYYY  FOR SCREEN DISPLAY
012400990105JGE01C*****************************************************
012500990105JGE01C***
012600990105JGE01C     DATE01        BEGSR
012700990105JGE01C                   Z-ADD     ENRLDT        @DATIN
012800990105JGE01C                   EXSR      #DATYM
012900990105JGE01C                   Z-ADD     @DATOU        PENRDT            8 0
013000990105JGE01C***
013100990105JGE01C                   Z-ADD     CANDT         @DATIN
013200990105JGE01C                   EXSR      #DATYM
013300990105JGE01C                   Z-ADD     @DATOU        PCANDT            8 0
013400990105JGE01C                   ENDSR
013500990105JGE01C***
013600990105JGE01C*****************************************************
013700990105JGE01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
013800990105JGE01C*****************************************************
013900990105JGE01C***
014000990105JGE01C*   DATE IN  = @DATIN (8.0) YYYYMMDD
014100990105JGE01C*   DATE OUT = @DATOU (8.0) MMDDYYYY
014200990105JGE01C***
014300990105JGE01C     #DATYM        BEGSR
014400990105JGE01C                   MOVE      @DATIN        @MD               4 0
014500990105JGE01C                   MOVEL     @DATIN        @Y                4 0
014600990105JGE01C                   MOVEL     @MD           @DATOU            8 0
014700990105JGE01C                   MOVE      @Y            @DATOU
014800990105JGE01C                   Z-ADD     *ZEROS        @DATIN            8 0
014900990105JGE01C                   ENDSR
015000981215     C*
015100981215      **----------------------------------------**
015200980218     C     *INZSR        BEGSR
015300981215      **----------------------------------------**
015400980218     C     *ENTRY        PLIST
015500980218     C                   PARM                    CONAME           40
015600981215     C*
015700980216      * Group Rate file
015800980218     C     GRAKEY        KLIST
015900980218     C                   KFLD                    KGTRST            3 0
016000980218     C                   KFLD                    KGSUB#            3 0
016100981215     C                   KFLD                    KGPLAN            4
016200980218     C                   KFLD                    KGAGEB            2 0
016300980218     C                   KFLD                    KGTYPE            3
016400981215      *
016500980224      * Plan Master file
016600980224     C     PLNKEY        KLIST
016700980224     C                   KFLD                    KPTRST            3 0
016800980224     C                   KFLD                    KPSUB#            3 0
016900981215     C                   KFLD                    KPPLAN            4
017000981215     C*
017100980604     C                   TIME                    TMDTCN           14 0
017200980604     C                   MOVEL     TMDTCN        TOR               6 0
017300980604     C                   MOVE      TMDTCN        DOR               8 0
017400981215     C*
017500980218     C                   EXCEPT    HEADER
017600981215     C*
017700980218     C                   ENDSR
017800980220     OREPORT    E            HEADER      0  2  1
017900980206     O                                           78 '*****'
018000980206     O                       CONAME             118
018100980206     O                                          124 '*****'
018200981215     O*
018300980216     O          E            HEADER         1
018400980605     O                                           10 'CR090RG'
018500980603     O                                          105 'BC/BS 15 DAY REPORT'
018600980206     O                                          185 'PAGE:'
018700980206     O                       PAGE          Z    192
018800981215     O*
018900980216     O          E            HEADER         1
019000980219     O                       TOR                 10 '  :  :  '
019100981215     O*
019200980216     O          E            HEADER         1
019300980206     O                       *DATE         Y     10
019400981215     O*
019500980216     O          E            HEADER      1  1
019600980605     O                                           23 'Enroll'
019700980605     O                                           58 'Cancel'
019800981215     O*
019900980216     O          E            HEADER         1
020000980604     O                                            3 'SSN'
020100980605     O                                           23 'Date'
020200980605     O                                           29 'Plan'
020300980605     O                                           44 'Group Numbers'
020400980605     O                                           58 'Date'
020500980605     O                                          114 'Trst Sub Acct'
020600981215     O*
020700980224     O          E            HEADER         2
020800980224     O                                           24 '------------------------'
020900980224     O                                           48 '------------------------'
021000980224     O                                           72 '------------------------'
021100980224     O                                           96 '------------------------'
021200980224     O                                          120 '------------------------'
021300980224     O                                          144 '------------------------'
021400980224     O                                          168 '------------------------'
021500980224     O                                          192 '------------------------'
021600980224     O                                          198 '------'
021700981215     O*
021800980603     O          E            MBRDTL         1
021900980604     O                       MCSSNO         B    11 '   .  .    '
022000981215JGE01O***                      ENRLDTY   23
022100990105JGE01O                       PENRDT              23 '0 /  /    '
022200980605     O                       MCPLAN         B    29
022300980605     O                       GRPOUT         B    46
022400981215JGE01O***                      CANDT ZB  58
022500990105JGE01O                       PCANDT        ZB    60
022600980608     O*                        JOBDTEZB 123
022700980608     O*                        ENRDTEZB 132
022800981215     O*
022900980605     O          E            L5OUT          1
023000980605     O                                           86 'Nmbr Mbrs 15 Days Prior'
023100980605     O                       L5CNT         2     93
023200980608     O                       MCTRST             105
023300980608     O                       MCSUB#             109
023400980608     O                       ACC#               114
023500981215     O*
023600980605     O          E            LROUT       1  1
023700980608     O                                           24 '* Total # of Accounts *'
023800980605     O                       ACCCNT        2     35
023900980608     O                                           85 '* Total # of Members *'
024000980605     O                       LRCNT         2     93
