0001009903160019  ****************************************************************
0002009810020014  *  FL160 - THE GROUP RATE FILE CONTAINS THE NET AND BILLING RATE
0003009810020015  *          FOR EACH VALID COVERAGE TYPE IN EACH GROUP USED IN THE
0004009810020016  *          COBRA SYSTEM.
0005009810020004  *                                                              *
0006009810020003  *                  COMMISSION RATE FILE LISTING                *
0007009810020019  ****************************************************************
000800050228   X***X
000900050228   X***X converted to native and mess cleaned up from previous mods.
001000050228   X***X
001100050228   X***X SK
001200050228   X***X
0013000502280020 Ffl160wf   Ipe  e           k DISK
0014000502280023 FCODES     IF   E           K DISK
0015000502280024 FPLNMST    IF   E           K DISK    prefix(z)
0016000502280027 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
001700050228   X***X
0018009102150065 D                UDS
0019009102150068 D  CONAME               201    240
0020009102150069 D  TIME                 242    247  0
0021009102150034 I*  COMMISSION  RATE FILE
0022000502280030 If160
002300050228     I                                          crtrst        L3
002400050228     I                                          crsubd        L3
0025000502280033 I                                          crplan        L2
0026000502280034 I                                          cslstp        L1
002700050228y2k  I                                          FRDATE        L4                frdate
002800050228y2k  I                                          TODATE        L5                todate
0029000502280070 c     plkey         klist
0030000502280070 c                   kfld                    crtrst
0031000502280070 c                   kfld                    crsubd
0032000502280070 c                   kfld                    crplan
0033000502280070 c
0034000502280070 c     codekey       klist
0035000502280070 c                   kfld                    k@1               1
0036000502280070 c                   kfld                    k@2               2
0037000502280070 c
0038009810020071  *-----------------------------------------------------------------------*
0039009810020072  *      M A I N   L I N E   C A L C U L A T I O N S                      *
0040009810020073  *-----------------------------------------------------------------------*
0041009810020074  *
0042009810020075  *   FIRST CYCLE LOGIC................
0043009810020076  *
004400981002      *
004500981002      * SELECT FROM DATE FROM LDA
004600981002      *
004700920106     C   L1              EXCEPT    SPACE
0048009810020082  *
0049009810020083  * SET OFF INDICATORS
0050000502280084 C                   SETOFF                                       21
005100981002Y2K   *
005200981002y2k  C   L4              MOVE      FRDATE        CYMD#             8
005300981002Y2K  C   L4              EXSR      #CYMD8
005400981002y2k  C   L4              MOVE      MDCY#         FRMDT2            8 0
005500981002Y2K   *
005600981002y2k  C   L4              MOVE      TODATE        CYMD#             8
005700981002Y2K  C   L4              EXSR      #CYMD8
005800981002y2k  C   L4              MOVE      MDCY#         TODT2             8 0
005900910215     C   L4
006000910215     COR L3
006100910215     CANNL4              EXCEPT    HEAD
006200981002      *
0063009810020093  * CHAIN TO PLAN MASTER FILE
0064000502280094 C     PLKEY         CHAIN     PLNMST                             21
0065009810020095  *
0066009810020096  * CHAIN TO CODES FILE
006700050301     c                   move      comtyp        comty2            2
006800050228     c                   movel     comtyp        k@1
006900050228     c                   move      comtyp        k@2
007000050228     C     codekey       CHAIN     CODES                              62
007100050228     C  N62              MOVE      sDESCR        CDESC1           10
007200050228      *
007300050301     c                   move      crptyp        crpty2            2
007400050228     c                   movel     crptyp        k@1
007500050228     c                   move      crptyp        k@2
007600050228     C     codekey       CHAIN     CODES                              62
007700050228     C  N62              MOVE      sDESCR        CDESC2           10
007800050228      *
007900050301     c                   move      cslstp        cslst2            2
008000050228     c                   movel     cslstp        k@1
008100050228     c                   move      cslstp        k@2
008200050228     C     codekey       CHAIN     CODES                              62
008300050228     C  N62              MOVE      sDESCR        SLSDSC           10
008400981002      *
008500910215     C   OF              EXCEPT    HEAD
008600981002     C     #END          TAG
0087009810020099  *-----------------------------------------------------------------------*
0088009810020100  *   E N D   O F   M A I N   L I N E   C A L C U L A T I O N S           *
0089009810020101  *-----------------------------------------------------------------------*
009000050228
009100981002      **-------------------------------------------------**
009200981002      * Rearrange date / ccyymmdd to mmddccyy
009300981002     C     #CYMD8        BEGSR
009400981002     C                   MOVE      CYMD#         MMDD#             4
009500981002     C                   MOVEL     CYMD#         CCYY#             4
009600981002     C                   MOVEL     MMDD#         MDCY#             8
009700981002     C                   MOVE      CCYY#         MDCY#
009800981002     C                   ENDSR
009900981002     C/EJECT
0100009810020102 OREPORT    E            HEAD           1 01
0101009810020113 O                                            5 'FL160'
0102009102150104 O                       CONAME              84
0103009810020105 O          E            HEAD           1
0104009810020107 O                       UDATE         Y      8
0105009810020111 O          E            HEAD           2
0106009810020115 O                       TIME                 8 '  :  :  '
0107009102150108 O                                           75 'COMMISSION RATE SCHEDULE'
0108009810020109 O                                          125 'PAGE:'
0109009810020110 O                       PAGE          Z    130
0110009102150116 O          E            HEAD           2
0111009102150118 O                                           59 'FOR PERIOD :'
011200981002y2k  O                       FRMDT2              68 '  /  /    '
011300981002     O                                           71 '-'
011400981002y2k  O                       TODT2               83 '  /  /    '
0115009810020122 O          E            HEAD           1
0116009102150124 O                                           24 '------------------------'
0117009102150125 O                                           48 '------------------------'
0118009102150126 O                                           72 '------------------------'
0119009102150127 O                                           96 '------------------------'
0120009102150128 O                                          120 '------------------------'
0121009102150129 O                                          132 '------------'
0122009810020130 O          E            HEAD           1
012300910215     O                                           77 'COMM'
012400910215     O                                           86 'COMM'
012500910215     O                                           92 'COMM'
012600910215     O                                          110 'CORP'
012700910215     O                                          116 'CORP'
0128009810020136 O          E            HEAD           1
012900910215     O                                            9 'PLAN #'
013000910215     O                                           26 'DESCRIPTION'
013100910215     O                                           70 'SALESMAN TYPE'
013200910215     O                                           78 'PERIOD'
013300910215     O                                           86 'RATE'
013400910215     O                                           92 'TYPE'
013500910215     O                                          110 'RATE'
013600910215     O                                          116 'TYPE'
0137009810020141 O          E            HEAD           1
0138009102150143 O                                           24 '------------------------'
0139009102150144 O                                           48 '------------------------'
0140009102150145 O                                           72 '------------------------'
0141009102150146 O                                           96 '------------------------'
0142009102150147 O                                          120 '------------------------'
0143009102150148 O                                          132 '------------'
0144000502280149 O          D                           1
014500050228     O               L2      crtrst               3
014600910215     O               L2                           4 '-'
014700050228     O               L2      crsubd               7
014800910215     O               L2                           8 '-'
014900050228     O               L2      crplan              12
015000050301     O               L2      zPDESCR             55
015100050301     O                       cslst2              60
015200910215     O                                           61 '-'
015300910215     O                       SLSDSC         B    71
015400910215     O                       COMPRD        Z     76
015500910215     O                       COMRTE        4     86
015600050301     O                       COMTY2              90
015700910215     O                                           91 '-'
015800910215     O                       CDESC1         B   101
015900910215     O                       CRPRTE        4    110
016000050301     O                       CRPTY2             114
016100910215     O                                          115 '-'
016200910215     O                       CDESC2         B   125
0163009201060175 O          E            SPACE       1
0164009201060176 O                                            2 ' '
