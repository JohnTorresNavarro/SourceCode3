000100000501     H DFTNAME(DB391)
000200000113      ******************************************************************
000300000405      * DB390      GROUP BENEFIT SERVICES SOFTWARE           1994      *
000400000113      *                                                                *
000500000113      *            WRITTEN BY - DAVID KETTERMAN                        *
000600000113      *            DATE - 12/09/94                                     *
000700000113      *                                                                *
000800000113      *                                                                *
000900000113      *  DESCRIPTION - THIS PROGRAM WILL PRINT ANY GRATE RECORDS       *
001000000113      *            WITH INVALID FROM / END DATE COMBINATIONS.          *
001100000113      *                                                                *
001200000113      *                                                                *
001300000113      *  Y2K CONVERT - 1998                                            *
001400000113      *                                                                *
001500000113      ******************************************************************
001700000317     FGRAT24    IP   F   80        DISK
001702000113     FDATERW1   IF A E           K DISK
001703000113
002204991214     DDTECHG           S              1
002207991214     DCOUNT            S              4  0
002208991214     DCNT              S              5  0
002209991214     DERROR            S             45
002210991214     DFRMDY            S              8  0
002211991214     DNEWTSP           S              1
002212991214     DTOMDY            S              8  0
002213991214     DSAVTO            S              8  0
002214991214     DX                S              1  0
002215000113
002216000317     IGRAT24    NS  01
002219000317     I                                  1   10  TSP           L2
002220000317     I                                  1    3 0GRTRST
002221000317     I                                  4    6 0GRSUB#
002222000317     I                                  7   10  GRPLAN
002223000317     I                                 65   72 0FRMDAT        L1
002224000317     I                                 73   80 0TODAT         L1
002225000317     I*                                 1   64  GRREC
002226000113
002227000317     I*GRATER
002228000317     I*                                          GRTRST        L2
002229000317     I*                                          GRSUB#        L2
002230000317     I*                                          GRPLAN        L2
002231000317     I*                                          FRMDAT        L1
002232000317     I*                                          TODAT         L1
003100991214
003200991214      * TO DATE MUST BE >= FROM DATE TO BE VALID
003300991214
003301991215     C     TKEY          KLIST
003302991215     C                   KFLD                    GRTRST
003303991215     C                   KFLD                    GRSUB#
003304991215     C                   KFLD                    GRPLAN
003305991215     C                   KFLD                    FRMDAT
003306991215     C                   KFLD                    TODAT
003307991215     C                   KFLD                    X
003308991215
003311991214     C                   IF        TODAT < FRMDAT
003312991214     C                   EVAL      X = 1
003700991214
003701991215     C     TKEY          CHAIN     DATER1                             50
003702991215     C                   IF        *IN50 = *ON
004501991214     C                   EVAL      TRST# = GRTRST
004502991214     C                   EVAL      SUB# = GRSUB#
004504991214     C                   EVAL      PLAN# = GRPLAN
004505991215     C                   EVAL      FRDT = FRMDAT
004506991215     C                   EVAL      TODT = TODAT
004507991214     C                   EVAL      ERRTYP = X
004600991214     C                   WRITE     DATER1
004700991215     C                   ENDIF
004701991215     C                   ENDIF
004800991214
004900991214      * ON PLAN CHANGE SET FLAG
005000991214
005001991214     C   L2              EVAL      NEWTSP = 'Y'
005300991214
005400991214      * IF NOT FIRST DATE RANGE, CHECK FROM DATE AGAINST HOLD TO DATE
005500991214      * FROM DATE MUST BE > PREVIOUS TO DATE TO BE VALID
005600991214
005800941209     CL1                 IF        NEWTSP = ' '
005801991214     CL1                 IF        FRMDAT <= SAVTO
005802991214     CL1                 EVAL      X = 2
006200991214
006201991215     CL1   TKEY          CHAIN     DATER1                             50
006202991215     CL1                 IF        *IN50 = *ON
007001991214     CL1                 EVAL      TRST# = GRTRST
007002991214     CL1                 EVAL      SUB# = GRSUB#
007004991214     CL1                 EVAL      PLAN# = GRPLAN
007005991215     CL1                 EVAL      FRDT = FRMDAT
007006991215     CL1                 EVAL      TODT = TODAT
007007991214     CL1                 EVAL      ERRTYP = X
007008991214     CL1                 WRITE     DATER1
007200991215     CL1                 ENDIF
007201991215     CL1                 ENDIF
007300991214
007400941209     CL1                 ELSE
007500991214
007501991214     CL1                 EVAL      NEWTSP = ' '
007700941209     CL1                 END
007800991214
007801991214     CL1                 MOVE      TODAT         SAVTO
007900000310
008000000310     C     *INZSR        BEGSR
008001000310
008002000310     C*/EXEC SQL
008003000310     C*/END-EXEC
008004000310
008100000310     C                   ENDSR
