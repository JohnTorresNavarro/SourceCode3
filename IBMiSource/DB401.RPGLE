000100000501     H DFTNAME(DB401)
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
001501000405     FCRAT24    IP   F   80        DISK
001502000405     FDATERW1   IF A E           K DISK
001702991214
002201991214
002202000405     DDTECHG           S              1
002203000405     DCOUNT            S              4  0
002204000405     DCNT              S              5  0
002205000405     DERROR            S             45
002206000405     DFRMDY            S              8  0
002207000405     DNEWTSP           S              1
002208000405     DTOMDY            S              8  0
002209000405     DSAVTO            S              8  0
002214991214     DX                S              1  0
002215991214
002223000405     ICRAT24    NS  01
002224000405     I                                  1   10  TSP           L2
002225000405     I                                  1    3 0CRTRST
002226000405     I                                  4    6 0CRSUB#
002227000405     I                                  7   10  CRPLAN
002228000405     I                                 65   72 0FRMDAT        L1
002229000405     I                                 73   80 0TODAT         L1
002230000405     I*                                 1   64  CRREC
003000000405
003100991214      * TO DATE MUST BE >= FROM DATE TO BE VALID
003200000405
003201000405     C     TKEY          KLIST
003202000405     C                   KFLD                    CRTRST
003203000405     C                   KFLD                    CRSUB#
003204000405     C                   KFLD                    CRPLAN
003205000405     C                   KFLD                    FRMDAT
003206000405     C                   KFLD                    TODAT
003207000405     C                   KFLD                    X
003208000405
003209000405     C                   IF        TODAT < FRMDAT
003210991214     C                   EVAL      X = 1
003600991214
003601000405     C     TKEY          CHAIN     DATER1                             50
003602000405     C                   IF        *IN50 = *ON
003603000405     C                   EVAL      TRST# = CRTRST
003604000405     C                   EVAL      SUB# = CRSUB#
003605000405     C                   EVAL      PLAN# = CRPLAN
003606000405     C                   EVAL      FRDT = FRMDAT
003607000405     C                   EVAL      TODT = TODAT
003608000405     C                   EVAL      ERRTYP = X
003609000405     C                   WRITE     DATER1
003610000405     C                   ENDIF
003611000405     C                   ENDIF
004700000405
004800991214      * ON PLAN CHANGE SET FLAG
004900000405
004901991214     C   L2              EVAL      NEWTSP = 'Y'
005200000405
005300991214      * IF NOT FIRST DATE RANGE, CHECK FROM DATE AGAINST HOLD TO DATE
005400991214      * FROM DATE MUST BE > PREVIOUS TO DATE TO BE VALID
005500000405
005700941209     CL1                 IF        NEWTSP = ' '
005701000405     CL1                 IF        FRMDAT <= SAVTO
005702991214     CL1                 EVAL      X = 2
006100991214
006200000405     CL1   TKEY          CHAIN     DATER1                             50
006300000405     CL1                 IF        *IN50 = *ON
006400000405     CL1                 EVAL      TRST# = CRTRST
006500000405     CL1                 EVAL      SUB# = CRSUB#
006600000405     CL1                 EVAL      PLAN# = CRPLAN
006700000405     CL1                 EVAL      FRDT = FRMDAT
006800000405     CL1                 EVAL      TODT = TODAT
006900000405     CL1                 EVAL      ERRTYP = X
007000000405     CL1                 WRITE     DATER1
007100000405     CL1                 ENDIF
007200000405     CL1                 ENDIF
007300000405
007400000405     CL1                 ELSE
007500000405
007600000405     CL1                 EVAL      NEWTSP = ' '
007700000405     CL1                 END
007800000405
007900000405     CL1                 MOVE      TODAT         SAVTO
