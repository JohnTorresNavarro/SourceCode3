001501001109      ******************************************************************
001502001114      * ABR060              GROUP BENEFIT SERVICES              2000   *
001503001109      *                                                                *
001504001109      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
001505001114      *            DATE - 11/14/2000                                   *
001506001109      *                                                                *
001507001114      *  DESCRIPTION - THIS PROGRAM CREATE A GROUP NUMBER              *
001508001114      *                CHANGE LISTING                                  *
001509001109      *                                                                *
001510001212      *                                                                *
001511001212      *                M O D I F I C A T I O N S                       *
001512001212      *  Date                                                          *
001513001212      *  Revised   Initials    Description                             *
001514001212      *  --------  --------    --------------------------------------  *
001515001212      *  12/12/00    KSJ       Add PLNMST to print PCARR on report.    *
001516140725      * 07/25/14 dlk - convert to spreadsheet - liliane request        *
001517140725      *                                                                *
002100001107      ******************************************************************
002200001109     FGRTHIST3  IF   E           K DISK
002401001114     FMCOVXX    IF   E           K DISK
002402001114     FGBSECURE  IF   E           K DISK
002403001212     FPLNMST    IF   E           K DISK
002502140725     FABR060XL  o  a e             DISK
002600001109
002601140725     Dcsv              c                   const('","')
002602140725     Dplan             s              4
002603140725     Dagebnd           s              2  0
002604140725     Dcovtyp           s              2
002605140725     Dcarcd            s              3
002606140725     Dogrp#            s             15
002607140725     Dngrp#            s             15
002608140731     Duser             s             30
003800000211     D                UDS
003801001114     D  LFY                    1      4  0
003802001114     D  LFMD                   5      8  0
003803001117     D  LFYMD                  1      8  0
003804001114     D  LTY                    9     12  0
003805001114     D  LTMD                  13     16  0
003806001117     D  LTYMD                  9     16  0
003807001114     D  LTRUST                17     19
003808001114     D  LSUB                  20     22
003809001114     D  LPLAN                 23     26
003810001114     D  CONAME               201    240
003811001114     D  LTIME                242    247  0
004300001114
004301001116     D@DATIN           S              8  0
004302001116     D@DATOU           S              8  0
004303001116     D@MD              S              4  0
004304001116     D@Y               S              4  0
004305001116
004306001114     C     HSTKEY        KLIST
004307001114     C                   KFLD                    HFTRST
004308001114     C                   KFLD                    HFSUB#
004309001114     C                   KFLD                    HFPLAN
004310001109
006900001108      * MAINLINE
007002001114
007003001108     C                   READ      RGRTHIST                               99
007004001108     C                   DOW       *IN99 = *OFF
007005001114
007006001212     C                   IF        HFBFGRP# <> *BLANKS AND HFBFGRP# <> HFAFGRP#
007007001212     C****               IF        HFBFGRP# <> HFAFGRP#
007008001114
007009001114     C     HSTKEY        SETLL     MCOVR
007010001114     C     HSTKEY        READE     MCOVR                                  98
007011001114     C                   DOW       *IN98 = *OFF
007012001114
007013001114     C                   IF        MCAGEB = HFAFAGBN AND MCOVTP = HFAFTYCD
007014001114
007022140725     C                   MOVE      HFTRST        TRST              3
007023140725     C                   MOVE      HFSUB#        SUB               3
007024001114     C                   EVAL      PLAN = HFPLAN
007026140725     C                   MOVE      ACC#          ACCT              3
007027001114     C                   EVAL      AGEBND = HFAFAGBN
007028140730     C                   EVALr     COVTYP = HFAFTYCD
007029001114     C                   EVAL      OGRP# = HFBFGRP#
007030001114     C                   EVAL      NGRP# = HFAFGRP#
007033001116     C                   MOVE      HFAFFRDT      @DATIN
007034001116     C                   EXSR      #CVTDT
007035140725     C                   MOVE      @DATOU        FDATE             8 0
007036001116     C                   MOVE      HFAFTODT      @DATIN
007037001116     C                   EXSR      #CVTDT
007038140725     C                   MOVE      @DATOU        TDATE             8 0
007039001116     C                   MOVE      HFDATE        @DATIN
007040001116     C                   EXSR      #CVTDT
007041140725     C                   MOVE      @DATOU        TRNDTE            8 0
007042001114
007043140731     c                   clear                   user
007044001114     C     HFUSERID      CHAIN     SECR                               50
007045001114     C                   IF        *IN50 = *OFF
007046001204     C                   EVAL      USER = SCNAME
007047001114     C                   ENDIF
007049001114
007050001212     C     HSTKEY        CHAIN     PLNMSR                             51
007051001212     C                   IF        *IN51 = *OFF
007052001212     C                   EVAL      CARCD = PCARR
007053001212     C                   ENDIF
007054001212
007055140725     C*                  IF        *IN80 = *ON
007056140725     C*                  WRITE     HDR
007057140725     C*                  EVAL      *IN80 = *OFF
007058140725     C*                  ENDIF
007059140725
007060140725     C*                  WRITE     DTL
007061140725     C                   exsr      writexldet
007062140725     C*                  EVAL      CNT = CNT + 1
007063140725     C*                  CLEAR                   DTL
007064001114     C                   LEAVE
007065001114
007066001114     C                   ENDIF
007067001114
007068001114     C     HSTKEY        READE     MCOVR                                  98
007069001114     C                   ENDDO
007070001114
007071001114     C                   ENDIF
007073001108    *
007074001108     C                   READ      RGRTHIST                               99
007075001108     C                   ENDDO
007200001108
007201140725     C*                  IF        *IN80 = *ON
007202140725     C*                  WRITE     HDR
007203140725     C*                  EVAL      *IN80 = *OFF
007204140725     C*                  ENDIF
007205140725     C*                  WRITE     TOT
007206001120
008500991124     C                   MOVE      *ON           *INLR
008600001116
008601140725     C*************************************************************
008603140725     C* Write Spreadsheet Detail                                  *
008605140725     C*************************************************************
008606140725     C     Writexldet    BegSr
008607140725
008608140725     c                   Clear                   ABR060FLD
008609140725     C                   Eval      ABR060FLD  = '"' +
008610140731     C                             %Trim(%Editw(trndte:'  /  /    '))   + csv +
008611140731     C                             %Trim(%Editw(hftime:'  :  :  '))     + csv +
008613140725     C                             TRST                                 + csv +
008614140725     C                             sub                                  + csv +
008615140725     C                             plan                                 + csv +
008616140725     C                             acct                                 + csv +
008617140730     C                             %trim(%editc(agebnd:'Z'))            + csv +
008618140725     C                             covtyp                               + csv +
008619140730     C                             carcd                                + csv +
008620140730     C                             OGRP#                                + csv +
008621140730     C                             NGRP#                                + csv +
008622140725     C                             %Trim(%Editw(fdate:'  /  /    '))    + csv +
008623140725     C                             %Trim(%Editw(tdate:'  /  /    '))    + csv +
008624140731     C                             %trim(user)                          + csv +
008625140725     C                             ' '                                  + '" ,'
008626140725     C*
008627140725     C                   Write     ABR060XR
008628140725     C                   EndSr
008629140725     C*
008630140725     C/EJECT
008631140725     C*************************************************************
008632140725     C* Write Spreadsheet heading                                 *
008633140725     C*************************************************************
008634140725     C     Writexlhead   BEGSR
008635140725
008636140725     c                   Clear                   ABR060FLD
008637140725     C                   Eval      ABR060FLD = '"' +
008638140731     C                             'TRANS. DATE'                    + csv +
008639140731     C                             'TRANS. TIME'                    + csv +
008640140725     C                             'TRUST'                          + csv +
008641140725     C                             'SUB'                            + csv +
008642140725     C                             'PLAN'                           + csv +
008643140725     C                             'ACC #'                          + csv +
008644140725     C                             'AGE BAND'                       + csv +
008645140725     C                             'COVERAGE'                       + csv +
008646140725     C                             'CARRIER'                        + csv +
008647140725     C                             'OLD GROUP #'                    + csv +
008648140725     C                             'NEW GROUP #'                    + csv +
008649140730     C                             'RANGE - FROM'                   + csv +
008650140730     C                             'RANGE - TO'                     + csv +
008651140725     C                             'USER'                           + csv +
008652140725     C                             ' '                              + '",'
008653140725     C                   Write     ABR060XR
008654140725     C*
008655140725     C                   ENDSR
008656001116    * * * * * * * * * * * * * * *
008657001116    * *  S U B R O U T I N E S  *
008658001116    * * * * * * * * * * * * * * *
008659001117
008660001117     C     *INZSR        BEGSR
008661140725     C*                  MOVEL     LFMD          @DATOU
008662140725     C*                  MOVE      LFY           @DATOU
008663140725     C*                  EVAL         LFRDT = @DATOU
008664140725     C*                  MOVEL     LTMD          @DATOU
008665140725     C*                  MOVE      LTY           @DATOU
008666140725     C*                  EVAL         LTODT = @DATOU
008667140725     C*                  CLEAR                   @DATOU
008668001117
008669140725     C*                  EVAL      *IN80 = *ON
008670140725     C                   Exsr      Writexlhead
008671001117
008672001117     C                   ENDSR
008673001117
008674001117    * *
008675001117    * *  CONVERT DATE
008676001117    * *--------------
008700001116     C     #CVTDT        BEGSR
008800001116     C                   MOVE      @DATIN        @MD
008900001116     C                   MOVEL     @DATIN        @Y
009000001116     C                   MOVEL     @MD           @DATOU
009100001116     C                   MOVE      @Y            @DATOU
009200001116     C                   MOVE      *ZEROS        @DATIN
009300001116     C                   ENDSR
