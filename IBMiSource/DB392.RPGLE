000100000501     H DFTNAME(DB392)
000200991214      ******************************************************************
000300000405      * DB390      GROUP BENEFIT SERVICES SOFTWARE           1994      *
000400991214      *                                                                *
000500991214      *            WRITTEN BY - DAVID KETTERMAN                        *
000600991214      *            DATE - 12/09/94                                     *
000700991214      *                                                                *
000800991214      *                                                                *
000900991214      *  DESCRIPTION - THIS PROGRAM WILL PRINT ANY GRATE RECORDS       *
001000991214      *            WITH INVALID FROM / END DATE COMBINATIONS.          *
001100991214      *                                                                *
001200991214      *                                                                *
001300991214      *  Y2K CONVERT - 1998                                            *
001400991214      *                                                                *
001500991214      ******************************************************************
001700991214     FDATERW1   IF   E           K DISK
001701000314     FMCOVXX    IF   E           K DISK
001702000427     FACCMST    IF   E           K DISK
001703991214     FDATERW2   IF A E           K DISK
001704991214     FDB390P    O    E             PRINTER OFLIND(*IN80)
001801991214
001900000427     D ERR             S             30    DIM(2) CTDATA PERRCD(1)
001901991214
002000991214     D                UDS
002100991214     D  CONAME               201    240
002200991214     D  HMS                  242    247  0
002201991214
002202991215     D@DATIN           S              8  0
002203991215     D@DATOU           S              8  0
002204991215     D@MD              S              4  0
002205991215     D@Y               S              4  0
002206000404     DACC              S              4  0
002207991215
003302991214     C     TSKEY         KLIST
003303991214     C                   KFLD                    TRST#
003304991214     C                   KFLD                    SUB#
003305000314     C                   KFLD                    PLAN#
003306000118
003307000427     C     ACCKEY        KLIST
003308000427     C                   KFLD                    TRST2
003309000427     C                   KFLD                    SUB2
003310000427     C                   KFLD                    ACCT2
003311991214
003312991214     C     TSAPKY        KLIST
003313991214     C                   KFLD                    MCTRST
003314991214     C                   KFLD                    MCSUB#
003315000404     C                   KFLD                    ACC
003316991214     C                   KFLD                    MCPLAN
003317991214     C                   KFLD                    ERR(ERRTYP)
003318991214
003319991214     C                   READ      DATER1                                 99
003320991214     C                   DOW       *IN99 = *OFF
003321000404     C     TSKEY         CHAIN     MCOVR                              51
003322000404     C                   IF        *IN51 = *OFF
003323991214     C     *LOVAL        SETLL     MCOVR
003324991214     C     TSKEY         SETLL     MCOVR
003325991214     C     TSKEY         READE     MCOVR                                  98
003326991214     C                   DOW       *IN98 = *OFF
003327000404     C                   EVAL      ACC = ACC#
003328991214     C     TSAPKY        CHAIN     DATER2                             50
003329991214     C                   IF        *IN50 = *ON
003330991214     C                   EVAL      TRST2 = TRST#
003331991214     C                   EVAL      SUB2 = SUB#
003332000404     C                   EVAL      ACCT2 = ACC
003333991214     C                   EVAL      PLAN2 = PLAN#
003334991214     C                   EVAL      FRDT2 = FRDT
003335991214     C                   EVAL      TODT2 = TODT
003336991214     C                   EVAL      MSG2 = ERR(ERRTYP)
003337991214     C                   WRITE     DATER2
003338991214     C                   ENDIF
003339991214     C     TSKEY         READE     MCOVR                                  98
003340991214     C                   ENDDO
003341000404     C                   ELSE
003342000404     C                   EVAL      ACC = *ZEROS
003343000404     C     TSAPKY        CHAIN     DATER2                             50
003344000404     C                   IF        *IN50 = *ON
003345000404     C                   EVAL      TRST2 = TRST#
003346000404     C                   EVAL      SUB2 = SUB#
003347000404     C                   EVAL      ACCT2 = ACC
003348000404     C                   EVAL      PLAN2 = PLAN#
003349000404     C                   EVAL      FRDT2 = FRDT
003350000404     C                   EVAL      TODT2 = TODT
003351000404     C                   EVAL      MSG2 = ERR(ERRTYP)
003352000404     C                   WRITE     DATER2
003353000404     C                   ENDIF
003354000404     C                   ENDIF
003355991214     C                   READ      DATER1                                 99
003356991214     C                   ENDDO
003357991214      ************************************************************************************
003358991214     C                   EVAL      *IN80 = *ON
003359991214     C     *LOVAL        SETLL     DATER2
003360991214     C                   READ      DATER2                                 97
003361991214     C                   DOW       *IN97 = *OFF
003362991214     C                   MOVE      TRST2         TRST
003363991214     C                   MOVE      SUB2          SUB
003364991214     C                   MOVE      ACCT2         ACCT
003365991214     C                   EVAL      PLAN = PLAN2
003366991215
003367991215     C                   MOVE      FRDT2         @DATIN
003368991215     C                   EXSR      #DATYM
003369991215     C                   MOVE      @DATOU        FDATE
003370991215
003371991215     C                   MOVE      TODT2         @DATIN
003372991215     C                   EXSR      #DATYM
003373991215     C                   MOVE      @DATOU        TDATE
003374991215
003375991214     C                   EVAL      ERRMSG = MSG2
003376000427
003377000427     C     ACCKEY        CHAIN     ACCMSR                             52
003378000427     C                   IF        *IN52 = *OFF
003379000427     C                   EVAL      ACTNAM = ACNAM1
003380000427     C                   EVAL      AACOD = AACODE
003381000427     C                   ENDIF
003382000427
003383991214     C                   IF        *IN80 = *ON
003384991214     C                   WRITE     HDR
003385991214     C                   EVAL      *IN80 = *OFF
003386991214     C                   ENDIF
003387991214     C                   WRITE     DTL
003388000427     C                   CLEAR                   DTL
003389991214     C                   EVAL      CNT = CNT + 1
003390991214     C                   READ      DATER2                                 97
003391991214     C                   ENDDO
003392991214     C                   IF        *IN80 = *ON
003393991214     C                   WRITE     HDR
003394991214     C                   EVAL      *IN80 = *OFF
003395991214     C                   ENDIF
003396991214     C                   WRITE     TOT
003397991214     C                   EVAL      *INLR = *ON
003398991215
003399000113      ***************************************************
003400000113      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
003401000113      ***************************************************
003402000113
003403000113      * DATE IN  = @DATIN (8.0) YYYYMMDD
003404000113      * DATE OUT = @DATOU (8.0) MMDDYYYY
003405000113
003406000113     C     #DATYM        BEGSR
003407991215     C                   MOVE      @DATIN        @MD
003408991215     C                   MOVEL     @DATIN        @Y
003409991215     C                   MOVEL     @MD           @DATOU
003410991215     C                   MOVE      @Y            @DATOU
003411991215     C                   MOVE      *ZEROS        @DATIN
003412000113     C                   ENDSR
003413991215
003414991214
015000920924** ERROR TABLE
015100000427FR DT GTR THAN TO DT
015200000427FR DT LS THAN PREV PLANS TO DT
