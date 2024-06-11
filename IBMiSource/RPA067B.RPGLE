000100000724     Hdatfmt(*ymd)
000200991007      ******************************************************************
000300010125      * CCTEDR2    GROUP BENEFIT SERVICES SOFTWARE           2001      *
000400991007      *                                                                *
000401000714      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000402010125      *            DATE - 01/25/01                                     *
000700991007      *                                                                *
000800010125      *  DESCRIPTION - THIS PROGRAM WILL READ THROUGH WORKFILE AND     *
000900010207      *                CREATE AN EDIT REPORT                           *
001400991007      *                                                                *
001401080404      * 04/04/08 dlk - show abr code selected                          *
001500991007      ******************************************************************
001601010309     FCOMCTXWK  UF   E           K DISK
001901010309     FRPA067BP  O    E             PRINTER OFLIND(*IN80)
003100991007
003101010207     D @DATIN          S              8  0
003102010207     D @DATOU          S              8  0
003103010207     D @MD             S              4  0
003104010207     D @Y              S              4  0
003105010207     DSETFLG           S              1
003106010313     DSPCFLG           S              1
003107010309     DERROR            S              1
003108010207
003109010207      * Hold Fields *
003110010207      *-------------*
003111010125     DHTRST            S              3  0
003112010125     DHSUB#            S              3  0
003113010125     DHACCT            S              4  0
003114010125     DHPLAN            S              4
003115010125     DHCCOVPP          S              7  4
003116010125     DHCCOVRA          S              5  2
003117010125     DHCCOVPC          S              7  4
003118010125     DHCCPNC           S              1
003119010126     DHSLST            S              3
003120010126     DHSLSC            S              3
003121010126     DHEFFDT           S              8  0
003122010207     DHERROR           S              1
003123010314     DHSLNAME          S             18
003124010314     DHACODE           S              3
003125010126
0031260103120044 D                UDS
0031270103120045 D  RUNDAT                 1      8  0
0031280103120045 D  RUNmd                  1      4  0
0031290103120045 D  RUNy                   5      8  0
0031300103120045 D  aorc                  10     10
0031310804040045 D  labrcode              12     12
0031320103120050 D  CONAME               201    240
003133010312
003134010207      * PART I - UPDATE WORKFILE *
003135010207      *--------------------------*
003136010207
003137010207      * This section reads through the workfile and flags T/S/A/P records with errors by writing
003138010207      * a 'Y' to the ERROR field in the workfile.  An error occors when there are multiple records
003139010207      * with the same T/S/A/P and at least one of those records contains no data in the following
003140010207      * fields: CCOVPP, CCOVRA, CCOVPC and CCPNC.
003141010207
003142010207     C                   EVAL      HERROR = 'N'
003143010207
008544010309     C                   READ      COMCWK                                 90
008545991008
008546991007     C                   DOW       *IN90 = *OFF
008547000718
008548010314     C                   IF        CMCAN = *ZEROS
008549010314
008550010125     C                   IF        HTRST = CMTRST AND HSUB# = CSUBDV AND
008551010125     C                             HACCT = CMACCT AND HPLAN = CMPLAN
008554010125
008561010206     C                   IF        (HCCOVPP = *ZEROS  AND HCCOVRA = *ZEROS  AND
008562010125     C                             HCCOVPC = *ZEROS AND HCCPNC = *BLANK
008567010206     C                             AND HERROR = 'N') OR
008568010126
008571010207     C                             (CCOVPP = *ZEROS  AND CCOVRA = *ZEROS  AND
008572010206     C                             CCOVPC = *ZEROS AND CCPNC = *BLANK
008573010206     C                             AND HERROR = 'N')
008574010206
008575010206     C                   EVAL      ERROR = 'Y'
008576010206
008577010309     C                   UPDATE    COMCWK
008578010206
008579010206     C                   ENDIF
008580010206     C                   ENDIF
008581010206
008582010206     C                   IF        HTRST <> CMTRST OR HSUB# <> CSUBDV OR
008583010206     C                             HACCT <> CMACCT OR HPLAN <> CMPLAN
008584010207     C                   EVAL      HERROR = 'N'
008585010206     C                   ENDIF
008586010206
008587010206     C                   EVAL      HTRST = CMTRST
008588010206     C                   EVAL      HSUB# = CSUBDV
008589010206     C                   EVAL      HACCT = CMACCT
008590010206     C                   EVAL      HPLAN = CMPLAN
008591010206     C                   EVAL      HCCOVPP = CCOVPP
008592010206     C                   EVAL      HCCOVRA = CCOVRA
008593010206     C                   EVAL      HCCOVPC = CCOVPC
008594010206     C                   EVAL      HCCPNC  = CCPNC
008595010206     C                   EVAL      HSLST = SLSTYP
008596010206     C                   EVAL      HSLSC = SLSMAN
008597010206     C                   EVAL      HEFFDT  = EFFDAT
008598010314     C                   EVAL      HSLNAME = SLNAME
008599010314     C                   EVAL      HACODE = ACODE
008600010206
008601010314     C                   ENDIF
008602010314
008603010309     C                   READ      COMCWK                                 90
008604010206
008605010206     C                   ENDDO
008606010206
008607010207     C                   EVAL      HERROR = 'N'
008608010314     C**                 EVAL      *IN80 = *ON
008609010207     C                   EVAL      SETFLG = 'N'
008610010206
008611010207      * PART II - WRITE EDIT REPORT *
008612010207      *-----------------------------*
008613010207
008614010207      * First the file is repositioned to the very first record and is resorted using the 'Y' in
008615010207      * the ERROR field.  Once a record is read it is compared to the hold fields to check for
008616010207      * multiple records with the same T/S/A/P.  If a 'Y' is detected, all records with the same
008617010207      * T/S/A/P are written to the report even if ERROR is not equal to 'Y'.
008618010207
008619010309     C     *LOVAL        SETLL     COMCWK
008620010309     C                   READ      COMCWK                                 91
008621010206
008622010206     C                   DOW       *IN91 = *OFF
008623010206
008631010207     C                   IF        (HTRST = CMTRST AND HSUB# = CSUBDV AND
008632010207     C                             HACCT = CMACCT AND HPLAN = CMPLAN  AND
008633010207     C                             HERROR = 'Y') OR HERROR = 'Y'
008634010206
008635010313     C*                  IF        HTRST <> CMTRST OR HSUB# <> CSUBDV OR
008636010313     C*                            HACCT <> CMACCT OR HPLAN <> CMPLAN
008637010313     C*                  EVAL      SPCFLG = 'Y'
008638010313     C*                  ENDIF
008639010313
008640010206     C                   EVAL      TRST = HTRST
008641010206     C                   EVAL      SUB# = HSUB#
008642010206     C                   EVAL      ACCT = HACCT
008643010206     C                   EVAL      PLAN = HPLAN
008644010206     C                   EVAL      SLST = HSLST
008645010206     C                   EVAL      SLSC = HSLSC
008646010126     C                   EVAL      @DATIN = HEFFDT
008647010126     C                   EXSR      #DATYM
008648010126     C                   EVAL      EFFDTE = @DATOU
008649010313     C                   EVAL      CCOVPPF = HCCOVPP
008650010313     C                   EVAL      CCOVRAF = HCCOVRA
008651010313     C                   EVAL      CCOVPCF = HCCOVPC
008652010313     C                   EVAL      CCPNCF  = HCCPNC
008653010314     C                   EVAL      SLNAM  = HSLNAME
008654010314     C                   EVAL      AACOD  = HACODE
008655010125
008656010125     C                   IF        *IN80 = *ON
008657010312     c                   if        aorc = 'C'
008658010312     c                   eval      runfor = 'PRE COMMISSION'
008659010312     c                   else
008660010312     c                   eval      runfor = 'PRE ABR       '
008661010312     c                   end
008662010125     C                   WRITE     HDR
008663010125     C                   EVAL      *IN80 = *OFF
008664010125     C                   ENDIF
008665010313     C                   IF        SPCFLG = 'Y'
008666010313     C                   WRITE     SPACE
008667010313     C                   EVAL      SPCFLG = 'N'
008668010313     C                   ENDIF
008669010125     C                   WRITE     DTL
008670010125     C                   CLEAR                   DTL
008671010206     C                   EVAL      SETFLG = 'Y'
008672010125     C                   EVAL      CNT = CNT + 1
008673010125
008674010125     C                   ENDIF
008683010125
008684010126     C                   IF        HTRST <> CMTRST OR HSUB# <> CSUBDV OR
008685010126     C                             HACCT <> CMACCT OR HPLAN <> CMPLAN
008686010206     C                   EVAL      HERROR = 'N'
008687010313     C                   EVAL      SPCFLG = 'Y'
008688010126     C                   ENDIF
008689010126
008690010125     C                   EVAL      HTRST = CMTRST
008691010125     C                   EVAL      HSUB# = CSUBDV
008692010125     C                   EVAL      HACCT = CMACCT
008693010125     C                   EVAL      HPLAN = CMPLAN
008694010125     C                   EVAL      HCCOVPP = CCOVPP
008695010125     C                   EVAL      HCCOVRA = CCOVRA
008696010125     C                   EVAL      HCCOVPC = CCOVPC
008697010125     C                   EVAL      HCCPNC  = CCPNC
008698010126     C                   EVAL      HSLST = SLSTYP
008699010126     C                   EVAL      HSLSC = SLSMAN
008700010126     C                   EVAL      HEFFDT  = EFFDAT
008701010314     C                   EVAL      HSLNAME = SLNAME
008702010125
008703010207     C                   IF        ERROR = 'Y'
008704010207     C                   EVAL      HERROR = 'Y'
008705010207     C                   ENDIF
008706010207
008707010309     C                   READ      COMCWK                                 91
008708010125
008709010125
008710010125     C                   ENDDO
008711010125
008712010125     C                   WRITE     TOT
008713000724
008714010206     C                   IF        SETFLG = 'Y'
008715010126     C                   SETON                                        U1
008716010126     C                   ENDIF
008717010126
008718991007     C                   EVAL      *INLR = *ON
008719010126
008720010314      * Initialization Subroutine *
008721010314      *---------------------------*
008722010314     C     *INZSR        BEGSR
008723010314     c                   if        aorc = 'C'
008724010314     c                   eval      runfor = 'PRE COMMISSION'
008725010314     c                   else
008726010314     c                   eval      runfor = 'PRE ABR       '
008727010314     c                   end
008728010314     C                   WRITE     HDR
008729010314     C                   EVAL      *IN80 = *OFF
008730010314     C                   ENDSR
008731010314
008732010207      * Convert Date Subroutine *
008733010207      *-------------------------*
008800010126     C     #DATYM        BEGSR
008900010126     C                   MOVE      @DATIN        @MD
009000010126     C                   MOVEL     @DATIN        @Y
009100010126     C                   MOVEL     @MD           @DATOU
009200010126     C                   MOVE      @Y            @DATOU
009300010126     C                   EVAL      @DATIN = *ZEROS
009400010126     C                   ENDSR
