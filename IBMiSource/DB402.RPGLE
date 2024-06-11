000100000501     H DFTNAME(DB402)
0002009912140002  ******************************************************************
0003000004050003  * DB400      GROUP BENEFIT SERVICES SOFTWARE           1994      *
0004009912140004  *                                                                *
0005009912140005  *            WRITTEN BY - DAVID KETTERMAN                        *
0006009912140006  *            DATE - 12/09/94                                     *
0007009912140007  *                                                                *
0008009912140008  *                                                                *
0009009912140013  *  DESCRIPTION - THIS PROGRAM WILL PRINT ANY CRATE RECORDS       *
0010009912140014  *            WITH INVALID FROM / END DATE COMBINATIONS.          *
0011009912140015  *                                                                *
0012009912140014  *                                                                *
0013009912140010  *  Y2K CONVERT - 1998                                            *
0014009912140015  *                                                                *
0015009912140016  ******************************************************************
001501991214     FDATERW1   IF   E           K DISK
001502991214     FMCOVXX    IF   E           K DISK
001503000427     FACCMST    IF   E           K DISK
001504991214     FDATERW2   IF A E           K DISK
001701991214     FDB400P    O    E             PRINTER OFLIND(*IN80)
001702991214
001900000427     D ERR             S             30    DIM(2) CTDATA PERRCD(1)
001901991214
0020009108290055 D                UDS                                                       DB020
0021009108290056 D  CONAME               201    240                                         DB020Y
0022009108290058 D  HMS                  242    247  0                                      DB020Y
002201991214
002202000405     D@DATIN           S              8  0
002203000405     D@DATOU           S              8  0
002204000405     D@MD              S              4  0
002205000405     D@Y               S              4  0
002206000405     DACC              S              4  0
002207000405
002208991214     C     TSKEY         KLIST
002209991214     C                   KFLD                    TRST#
002210991214     C                   KFLD                    SUB#
002211991214     C                   KFLD                    PLAN#
002212991214
002213000427     C     ACCKEY        KLIST
002214000427     C                   KFLD                    TRST2
002215000427     C                   KFLD                    SUB2
002216000427     C                   KFLD                    ACCT2
002217000427
002218991214     C     TSAPKY        KLIST
002219991214     C                   KFLD                    MCTRST
002220991214     C                   KFLD                    MCSUB#
002221000405     C                   KFLD                    ACC
002222991214     C                   KFLD                    MCPLAN
002223991214     C                   KFLD                    ERR(ERRTYP)
002224991214
002225991214     C                   READ      DATER1                                 99
002226991214     C                   DOW       *IN99 = *OFF
002227000405     C     TSKEY         CHAIN     MCOVR                              51
002228000405     C                   IF        *IN51 = *OFF
002229991214     C     *LOVAL        SETLL     MCOVR
002230991214     C     TSKEY         SETLL     MCOVR
002231991214     C     TSKEY         READE     MCOVR                                  98
002232991214     C                   DOW       *IN98 = *OFF
002233000405     C                   EVAL      ACC = ACC#
002234991214     C     TSAPKY        CHAIN     DATER2                             50
002235991214     C                   IF        *IN50 = *ON
002236991214     C                   EVAL      TRST2 = TRST#
002237991214     C                   EVAL      SUB2 = SUB#
002238000405     C                   EVAL      ACCT2 = ACC
002239991214     C                   EVAL      PLAN2 = PLAN#
002240991214     C                   EVAL      FRDT2 = FRDT
002241991214     C                   EVAL      TODT2 = TODT
002242991214     C                   EVAL      MSG2 = ERR(ERRTYP)
002243991214     C                   WRITE     DATER2
002244991214     C                   ENDIF
002245991214     C     TSKEY         READE     MCOVR                                  98
002246991214     C                   ENDDO
002247000405     C                   ELSE
002248000405     C                   EVAL      ACC = *ZEROS
002249000405     C     TSAPKY        CHAIN     DATER2                             50
002250000405     C                   IF        *IN50 = *ON
002251000405     C                   EVAL      TRST2 = TRST#
002252000405     C                   EVAL      SUB2 = SUB#
002253000405     C                   EVAL      ACCT2 = ACC
002254000405     C                   EVAL      PLAN2 = PLAN#
002255000405     C                   EVAL      FRDT2 = FRDT
002256000405     C                   EVAL      TODT2 = TODT
002257000405     C                   EVAL      MSG2 = ERR(ERRTYP)
002258000405     C                   WRITE     DATER2
002259000405     C                   ENDIF
002260000405     C                   ENDIF
002261991214     C                   READ      DATER1                                 99
002262991214     C                   ENDDO
002263991214      ************************************************************************************
002264991214     C                   EVAL      *IN80 = *ON
002265991214     C     *LOVAL        SETLL     DATER2
002266991214     C                   READ      DATER2                                 97
002267991214     C                   DOW       *IN97 = *OFF
002268991214     C                   MOVE      TRST2         TRST
002269991214     C                   MOVE      SUB2          SUB
002270991214     C                   MOVE      ACCT2         ACCT
002271991214     C                   EVAL      PLAN = PLAN2
002272000405
002273000405     C                   MOVE      FRDT2         @DATIN
002274000405     C                   EXSR      #DATYM
002275000405     C                   MOVE      @DATOU        FDATE
002276000405
002277000405     C                   MOVE      TODT2         @DATIN
002278000405     C                   EXSR      #DATYM
002279000405     C                   MOVE      @DATOU        TDATE
002280000405
002281991214     C                   EVAL      ERRMSG = MSG2
002282000427
002283000427     C     ACCKEY        CHAIN     ACCMSR                             52
002284000427     C                   IF        *IN52 = *OFF
002285000427     C                   EVAL      ACTNAM = ACNAM1
002286000427     C                   EVAL      AACOD = AACODE
002287000427     C                   ENDIF
002288000427
002289991214     C                   IF        *IN80 = *ON
002290991214     C                   WRITE     HDR
002291991214     C                   EVAL      *IN80 = *OFF
002292991214     C                   ENDIF
002293991214     C                   WRITE     DTL
002294000427     C                   CLEAR                   DTL
002295991214     C                   EVAL      CNT = CNT + 1
002296991214     C                   READ      DATER2                                 97
002297991214     C                   ENDDO
002298991214     C                   IF        *IN80 = *ON
002299991214     C                   WRITE     HDR
002300991214     C                   EVAL      *IN80 = *OFF
002301991214     C                   ENDIF
002302991214     C                   WRITE     TOT
002303991214     C                   EVAL      *INLR = *ON
002304991214
002305000405      ***************************************************
002306000405      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
002307000405      ***************************************************
002308000405
002309000405      * DATE IN  = @DATIN (8.0) YYYYMMDD
002310000405      * DATE OUT = @DATOU (8.0) MMDDYYYY
002311000405
002312000405     C     #DATYM        BEGSR
002313000405     C                   MOVE      @DATIN        @MD
002314000405     C                   MOVEL     @DATIN        @Y
002315000405     C                   MOVEL     @MD           @DATOU
002316000405     C                   MOVE      @Y            @DATOU
002317000405     C                   MOVE      *ZEROS        @DATIN
002318000405     C                   ENDSR
002319000405
014900920924** ERROR TABLE
014901000427FR DT GTR THAN TO DT
014902000427FR DT LS THAN PREV PLANS TO DT
