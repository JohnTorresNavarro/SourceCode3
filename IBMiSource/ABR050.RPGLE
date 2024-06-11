000100001109      ******************************************************************
000200001109      * ABR050              GROUP BENEFIT SERVICES              2000   *
000300001109      *                                                                *
000400001109      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000500001109      *            DATE - 11/06/2000                                   *
000600001109      *                                                                *
000700001109      *  DESCRIPTION - THIS PROGRAM CREATE A LISTING OF COBRA          *
000800001109      *                MEMBERS AFFECTED BY A GROUP RATE CHANGE         *
000900010118      *                                                                *
001000010118      *                                                                *
001100010118      *    MODIFICATIONS:                                              *
001200010118      *    --------------                                              *
001300010118      *    01/18/01 KSJ - MODIFIED TO ALSO WRITE RECORD WHEN THERE IS  *
001400010118      *                   A CHANGE IN GROUP#                           *
001500010118      *                                                                *
001600050601      *    06/01/05 szz - Added type code to the report.               *
001700050607      *    06/07/05 szz - Don't search rate file for changes; only     *
001800050607      *                   show changes evident from rate history file. *
001900050601      *                                                                *
002000070926      *    09/26/07 dlk - change bilrte to 6 decimal and clean up      *
002100070926      *                   method of output                             *
002200140114      *                                                                *
002300140114      * 01/14/2014 SSK REMOVE COMMENTED OUT CODE CLUTTER.              *
002400140114      *                                                                *
002500140114      *                                                                *
002600070926      *                                                                *
002700001107      ******************************************************************
002800001109     FGRTHIST3  IF   E           K DISK
002900001107     FMEMBER    IF   E           K DISK
003000001114     FMCOVXX    IF   E           K DISK
003100001107     FABR050P   O    E             PRINTER OFLIND(*IN80)
003200001109
003300000211     D                UDS
003400001114     D  LFY                    1      4  0
003500001114     D  LFMD                   5      8  0
003600001117     D  LFYMD                  1      8  0
003700001114     D  LTY                    9     12  0
003800001114     D  LTMD                  13     16  0
003900001117     D  LTYMD                  9     16  0
004000001114     D  LTRUST                17     19
004100001114     D  LSUB                  20     22
004200001114     D  LPLAN                 23     26
004300001114     D  CONAME               201    240
004400001114     D  LTIME                242    247  0
004500001107    *
004600010117    *
004700001116     D@DATIN           S              8  0
004800001116     D@DATOU           S              8  0
004900001116     D@MD              S              4  0
005000001116     D@Y               S              4  0
005100010119     DX                S              5  0
0052000101190020 DFLG              S              1
005300001116    *
005400001114     C     HSTKEY        KLIST
005500001114     C                   KFLD                    HFTRST
005600001114     C                   KFLD                    HFSUB#
005700001114     C                   KFLD                    HFPLAN
005800001109
005900010119     C     GRTKEY        KLIST
006000010119     C                   KFLD                    HFTRST
006100010119     C                   KFLD                    HFSUB#
006200010119     C                   KFLD                    HFPLAN
006300010119     C                   KFLD                    HFAFAGBN
006400010119     C                   KFLD                    HFAFTYCD
006500010119     C                   KFLD                    HFAFFRDT
006600010119     C                   KFLD                    HFAFTODT
006700010119
006800010119     C     GRTKY2        KLIST
006900010119     C                   KFLD                    HFTRST
007000010119     C                   KFLD                    HFSUB#
007100010119     C                   KFLD                    HFPLAN
007200010119     C                   KFLD                    HFAFAGBN
007300010119     C                   KFLD                    HFAFTYCD
007400010119
007500001108      * MAINLINE
007600001109
007700001108     C                   READ      RGRTHIST                               99
007800001108     C                   DOW       *IN99 = *OFF
007900001114
008000010117     C                   SELECT
008100050607     C                   WHEN      HFBFGRP# <> *BLANKS AND
008200050607     C                              HFBFGRP# <> HFAFGRP#
008300010117     C                   EVAL      TYPE   = 'GROUP# '
008400010117     C                   EXSR      DETAIL
008500010117
008600010117     C                   OTHER
008700010119
008800050607     C                   IF        HFBFNETR <> HFAFNETR    And
008900050607     C                             HFBFFRDT <> *Zero
009000010117     C                   EVAL      TYPE   = 'NET    '
009100001114     C                   EXSR      DETAIL
009200001114     C                   ENDIF
009300001109
009400050607     C                   IF        HFBFBILR <> HFAFBILR    And
009500050607     C                             HFBFFRDT <> *Zero
009600010117     C                   EVAL      TYPE   = 'BILLED '
009700001114     C                   EXSR      DETAIL
009800001114     C                   ENDIF
009900010119
010000050607     C                   IF        HFBFTODT <> HFAFTODT    And
010100050607     C                             HFBFFRDT <> *Zero
010200050607     C                   EVAL      TYPE   = 'TO-DATE'
010300050607     C                   EXSR      DETAIL
010400050607     C                   ENDIF
010500050607
010600010119     C                   EVAL      *IN97 = *OFF
010700001108    *
010800010117     C                   ENDSL
010900010117    *
011000001108     C                   READ      RGRTHIST                               99
011100001108     C                   ENDDO
011200001108
011300001120     C                   IF        *IN80 = *ON
011400001120     C                   WRITE     HDR
011500001120     C                   EVAL      *IN80 = *OFF
011600001120     C                   ENDIF
011700001120     C                   WRITE     TOT
011800001120
011900991124     C                   MOVE      *ON           *INLR
012000001109
012100001108    * * * * * * * * * * * * * * *
012200001108    * *  S U B R O U T I N E S  *
012300001108    * * * * * * * * * * * * * * *
012400001114
012500001117     C     *INZSR        BEGSR
012600001117     C                   MOVEL     LFMD          @DATOU
012700001117     C                   MOVE      LFY           @DATOU
012800001117     C                   EVAL         LFRDT = @DATOU
012900001117     C                   MOVEL     LTMD          @DATOU
013000001117     C                   MOVE      LTY           @DATOU
013100001117     C                   EVAL         LTODT = @DATOU
013200001117     C                   CLEAR                   @DATOU
013300001117
013400001117     C                   EVAL      *IN80 = *ON
013500001117
013600001117     C                   ENDSR
013700001117
013800001114    * *  DETAIL SR
013900001114    * *-----------
014000001114     C     DETAIL        BEGSR
014100001114
014200001114     C     HSTKEY        SETLL     MCOVR
014300001114     C     HSTKEY        READE     MCOVR                                  98
014400001114     C                   DOW       *IN98 = *OFF
014500001114
014600001114     C                   IF        MCAGEB = HFAFAGBN AND MCOVTP = HFAFTYCD
014700001114
014800001114     C                   IF        (ENRLDT >= HFAFFRDT AND ENRLDT <= HFAFTODT)
014900001117     C                             OR (CANDT >= HFAFFRDT AND CANDT <= HFAFTODT)
015000001117     C                             OR (CANDT = *ZEROS AND ENRLDT <= HFAFTODT)
015100001114
015200001114     C     MCSSNO        CHAIN     MEMBR                              50
015300001114     C                   IF        *IN50 = *OFF
015400001114     C                   IF        CEXPDT <> *ZEROS
015500001114
015600001116     C                   MOVE      HFDATE        @DATIN
015700001116     C                   EXSR      #CVTDT
015800001116     C                   MOVE      @DATOU        TRNDTE
015900001114     C                   MOVE      HFTRST        TRST
016000001114     C                   MOVE      HFSUB#        SUB#
016100001114     C                   EVAL      PLN = HFPLAN
016200001114     C                   EVAL      SSNO = MCSSNO
016300001114
016400001114     C     MLNAME        CAT(P)    ',':0         NAME
016500001114     C     NAME          CAT(P)    MFNAME:1      NAME
016600001114     C     NAME          CAT(P)    MMI:1         NAME
016700001114     C     NAME          CAT(P)    '.':0         NAME
016800001114
016900001114     C                   MOVE      ACC#          ACCT
017000050601
017100050607      *  Move from right to left to drop the "T"
017200050607     C                   Move      HFAFTYCD      TYP2
017300010119
017400010117     C                   SELECT
017500010119
017600050607     C                   WHEN      TYPE = 'BILLED '      Or
017700050607     C                             Type = 'TO-DATE'
017800070926     C                   eval      oldval = %editc(HFBFBILR:'4')
017900010119
018000070926     C                   eval      newval = %editc(HFAFBILR:'4')
018100010119
018200050607     C                   WHEN      TYPE = 'NET    '      Or
018300050607     C                             Type = 'TO-DATE'
018400070926     C                   eval      oldval = %editc(HFBFNETR:'4')
018500010119
018600070926     C                   eval      newval = %editc(HFAFNETR:'4')
018700010119
018800010117     C                   WHEN      TYPE = 'GROUP# '
018900010117     C                   EVAL      OLDVAL = HFBFGRP#
019000010117     C                   EVAL      NEWVAL = HFAFGRP#
019100010117     C                   ENDSL
019200010119
019300050607     C                   Move      HFBFTODT      @DATIN
019400050607     C                   Exsr      #CVTDT
019500050607     C                   Move      @DATOU        BTDATE
019600001116     C                   MOVE      HFAFFRDT      @DATIN
019700001116     C                   EXSR      #CVTDT
019800001116     C                   MOVE      @DATOU        FDATE
019900001116     C                   MOVE      HFAFTODT      @DATIN
020000001116     C                   EXSR      #CVTDT
020100001116     C                   MOVE      @DATOU        TDATE
020200001116     C                   MOVE      ENRLDT        @DATIN
020300001116     C                   EXSR      #CVTDT
020400001116     C                   MOVE      @DATOU        ENRDTE
020500001116     C                   MOVE      CANDT         @DATIN
020600001116     C                   EXSR      #CVTDT
020700001116     C                   MOVE      @DATOU        CNLDTE
020800001114
020900001114     C                   IF        *IN80 = *ON
021000001114     C                   WRITE     HDR
021100001114     C                   EVAL      *IN80 = *OFF
021200001114     C                   ENDIF
021300001114     C                   WRITE     DTL
021400010119     C                   CLEAR                   OLDVAL
021500010119     C                   CLEAR                   NEWVAL
021600001120     C                   EVAL      CNT = CNT + 1
021700001114
021800001114     C                   ENDIF
021900001114
022000001114     C                   ENDIF
022100001114
022200001114     C                   ENDIF
022300001114
022400001114     C                   ENDIF
022500001114
022600001114     C     HSTKEY        READE     MCOVR                                  98
022700001114     C                   ENDDO
022800001114
022900001114     C                   ENDSR
023000001116
023100010119    * *  CONVERT DATE
023200010119    * *--------------
023300001117     C     #CVTDT        BEGSR
023400001116     C                   MOVE      @DATIN        @MD
023500001116     C                   MOVEL     @DATIN        @Y
023600001116     C                   MOVEL     @MD           @DATOU
023700001116     C                   MOVE      @Y            @DATOU
023800001116     C                   MOVE      *ZEROS        @DATIN
023900001116     C                   ENDSR
024000010125
