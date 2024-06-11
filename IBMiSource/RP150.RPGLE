000100910215     H DFTNAME(RP150)
000200991007      ******************************************************************
000300000414      * RP150      GROUP BENEFIT SERVICES SOFTWARE           1990      *
000400991007      *                                                                *
000500991007      *            MODIFIED BY - WALTER PICCININI                      *
000600991007      *            DATE - 01/90                                        *
000700991007      *                                                                *
000800000217      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A  DEPENDENT          *
000900991007      *                ATTAINING AGE ?? LISTING                        *
001000991007      *               ** AGE NOW INPUT FROM PROMPT SCREEN 7/91         *
001100991007      *                                                                *
001200991007      *                                                                *
001300991007      *  Y2K CONVERT - 1998                                            *
001400991007      *                                                                *
001401100301      * 03/01/10 szz - Exclude On-site Dental (Trust Category Code N)
001402100301      *                 per Shelly R. and Dave A.
001403130531      * 05/31/13 szz - Use the RP15RWK file to drive the program so that
001404130531      *                 all dependents attaining age will appear on the
001405130531      *                 report; not just those qualifying for letters.
001500991007      ******************************************************************
001601130531     FRP15RWK   IF   E           K DISK
001800991007     FACCMST    IF   E           K DISK
001801100301     FTRSMST    IF   E           K DISK
001900991008     FRP150P    O    E             PRINTER OFLIND(*IN80)
003100991007
003900991007     D                UDS
003901991007     D LTRUST                  3      5
003902991007     D LFMMYY                 13     18  0
003903991007     D   LFMM                 13     14  0
003904991007     D   LFYY                 15     18  0
003905991007     D LTMMYY                 19     24  0
003906991007     D   LTMM                 19     20  0
003907991007     D   LTYY                 21     24  0
003908991011     D LAGE                   25     26  0
004400991007     D CONAME                201    240
004601991007
004602991007     D                 DS
004603991007     D UD8YMD                  1      8  0
004604991007     D   UD8Y                  5      8  0
004605991007
004606991007     D                 DS
004607991007     D DYYMM                   1      6  0
004608991007     D   DYY                   1      4  0
004609991007     D   DMM                   5      6  0
004610991007
004611991008     D                 DS
004612991008     D ZIP                     1      9
004613991008     D  ZIP1                   1      5
004614991008     D  ZIP2                   6      9
004615991008
004616991011     D                 DS
004617991011     D @DATOU                  1      8  0
004618991011     D   @MD                   1      4  0
004619991011     D   @Y                    5      8  0
004620991011
004621991008     DACCNO            S              4  0
004622991008     DACCOUT           S              6  0
004623991008     DFLAG             S              1    INZ('Y')
004624991008     DHLDACC           S              4
004625991008     DHLDSSN           S              9  0
004626991008     DHLDSUB           S              3
004627991008     DHLDTRS           S              3
004628991008     DMEMCNT           S              5  0
004629991008     DSUBNO            S              3  0
004630991007     DTRUST            S              3  0
004631991008     D@DATIN           S              8  0
004635991007
004636991007     D CNTC            C                   CONST('CONTACT IS ')
004637991007     D ECNTC           C                   CONST('EXECUTIVE CONTACT IS ')
004638991007     D NA              C                   CONST('NOT AVAILABLE')
004639991007
008501991007     C     ACCKEY        KLIST
008502991007     C                   KFLD                    TRUST
008503991007     C                   KFLD                    SUBNO
008504991007     C                   KFLD                    ACCNO
008515991007
008518130531     C                   READ      RP15RR                                 90
008519991008
008520130531     C                   EVAL      HLDTRS = RTRUSTC
008521130531     C                   EVAL      HLDSUB = RSUBC
008522130531     C                   EVAL      HLDACC = RACCTC
008523130531     C                   EVAL      HLDSSN = RSSNO
008524991008     C                   EXSR      HEAD2
008525991008
008526991007     C                   DOW       *IN90 = *OFF
008527991008
008528991011     C                   SELECT
008529991011
008530130531     C                   WHEN      HLDTRS <> RTRUSTC
008531991011     C                   EXSR      ACCBRK
008532991011     C                   EXSR      TRSBRK
008534991011     C
008535991008
008536130531     C                   WHEN      HLDSUB <> RSUBC OR HLDACC <> RACCTC
008537991011     C                   EXSR      ACCBRK
008538991013     C                   IF        *IN80 = *ON
008539991013     C                   WRITE     HDR1
008540991013     C                   EVAL      *IN80 = *OFF
008541991013     C                   ENDIF
008542991011     C                   EXSR      HEAD2
008544991011     C                   ENDSL
008546991011     C
008556991008
008557130603     C                   Eval      MBSSNO = RSSNO
008558991014     C                   IF        HLDSSN <> MBSSNO
008559991014     C                   EVAL      HLDSSN = MBSSNO
008560991014     C                   EVAL      MEMCNT = MEMCNT + 1
008561991008     C                   ELSE
008562991008     C                   IF        FLAG = 'N'
008563991008     C                   EVAL      *IN01 = *ON
008564991022     C                   ELSE
008565991022     C                   EVAL      MEMCNT = MEMCNT + 1
008566991008     C                   ENDIF
008567991008     C                   EVAL      FLAG = 'N'
008568991008     C                   ENDIF
008569991008
008570130603     C                   EVAL      MNAME1 = RMFNAME
008571130603     C                   IF        RMMI <> *BLANKS
008572130603     C     MNAME1        CAT       RMMI:1        MNAME1
008573991007     C                   CAT       '.':0         MNAME1
008574991007     C                   ENDIF
008575130603     C                   CAT       RMLNAME:1     MNAME1
008576130603     C                   EVAL      MNAME2 = RDFNAME
008577130603     C                   IF        RDMI <> *BLANKS
008578130603     C     MNAME2        CAT       RDMI:1        MNAME2
008579991007     C                   CAT       '.':0         MNAME2
008580991007     C                   ENDIF
008581130603     C                   IF        RDLNAME = 'SAME'
008582130603     C                   CAT       RMLNAME:1     MNAME2
008583991007     C                   ELSE
008584130603     C                   CAT       RDLNAME:1     MNAME2
008585991007     C                   ENDIF
008586991007
008587130603     C                   MOVE      RMBENRL       @DATIN
008588991007     C                   EXSR      #DATYM
008589991007     C                   MOVE      @DATOU        ENRMDY
008590991007
008592130603     C                   MOVE      RDBIRTH       @DATIN
008593991007     C                   EXSR      #DATYM
008594991007     C                   MOVE      @DATOU        BIRMDY
008595991007
008596130603     C                   MOVE      RDRELCD       RELCD
008608991008
008609100301     C     TRUST         Chain     TRSMST
008610100301     C                   If        TSCODE <> 'O N'
008615991007     C                   WRITE     DTL
008616991014     C                   EVAL      *IN01 = *OFF
008617100301     C                   End
008618991008
008619130603     C                   READ      RP15RR                                 90
008620991008
008621991007     C                   ENDDO
008622991008
008626991014     C                   EXSR      ACCBRK
008627991014     C                   EXSR      TRSBRK
008685991014
008686991007     C                   WRITE     TOT3
008687991007     C
008688991007     C                   EVAL      *INLR = *ON
012400991007
014800991007      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
014801991007      *                    S U B R O U T I N E S                    *
014802991007      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
022100991007
022300991007      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY
022400991007      *-----------------------------------------
022500991007
022600991007      * DATE IN  = @DATIN (8.0) YYYYMMDD
022700991007      * DATE OUT = @DATOU (8.0) MMDDYYYY
022800991007
022900991007     C     #DATYM        BEGSR
023000991007     C                   MOVE      @DATIN        @MD
023001991008     C                   MOVEL     @DATIN        @Y
023400991007     C                   EVAL      @DATIN = *ZEROS
023500991007     C                   ENDSR
023600991007
023601991008
023602991008      * HEADER 2 SUBROUTINE
023603991008      *---------------------
023604991007     C     HEAD2         BEGSR
023605130531     C                   MOVE      RTRUSTC       TRUST
023606130531     C                   MOVE      RSUBC         SUBNO
023607130531     C                   MOVE      RACCTC        ACCNO
023608991008     C     ACCKEY        CHAIN     ACCMSR                             50
023609991008     C                   IF        *IN50 = *OFF
023610991007     C                   EVAL      LINE1 = ACNAM1
023611991007     C                   IF        ACNAM2 <> *BLANKS
023612991007     C                   EVAL      LINE2 = ACNAM2
023613991007     C     CNTC          CAT       CONTAC        LINE3
023614991007     C     ECNTC         CAT       ECNTAC        LINE4
023615991007     C                   EVAL      LINE5 = AADDR1
023616991007     C                   IF        AADDR2 <> *BLANKS
023617991007     C                   EVAL      LINE6 = AADDR2
023618991011     C     ACITY         CAT       ',':0         LINE7
023619991011     C                   CAT       ASTATE:1      LINE7
023620991011     C                   CAT       '.':0         LINE7
023621991008     C                   MOVE      AZIP          ZIP
023622991011     C                   CAT       ZIP1:2        LINE7
023623991008     C                   IF        ZIP2 <> '0000'
023624991008     C                   CAT       '-':0         LINE7
023625991008     C                   CAT       ZIP2:0        LINE7
023626991008     C                   ENDIF
023627991007     C                   ELSE
023628991011     C     ACITY         CAT       ',':0         LINE6
023629991011     C                   CAT       ASTATE:1      LINE6
023630991011     C                   CAT       '.':0         LINE6
023631991008     C                   MOVE      AZIP          ZIP
023632991011     C                   CAT       ZIP1:2        LINE6
023633991008     C                   IF        ZIP2 <> '0000'
023634991008     C                   CAT       '-':0         LINE6
023635991008     C                   CAT       ZIP2:0        LINE6
023636991008     C                   ENDIF
023638991007     C                   EVAL      LINE7 = *BLANKS
023639991007     C                   ENDIF
023640991007     C                   ELSE
023641991007     C     CNTC          CAT       CONTAC        LINE2
023642991007     C     ECNTC         CAT       ECNTAC        LINE3
023643991007     C                   EVAL      LINE4 = AADDR1
023644991007     C                   IF        AADDR2 <> *BLANKS
023645991007     C                   EVAL      LINE5 = AADDR2
023646991011     C     ACITY         CAT       ',':0         LINE6
023647991011     C                   CAT       ASTATE:1      LINE6
023648991011     C                   CAT       '.':0         LINE6
023649991008     C                   MOVE      AZIP          ZIP
023650991011     C                   CAT       ZIP1:2        LINE6
023651991008     C                   IF        ZIP2 <> '0000'
023652991008     C                   CAT       '-':0         LINE6
023653991008     C                   CAT       ZIP2:0        LINE6
023654991008     C                   ENDIF
023656991007     C                   EVAL      LINE7 = *BLANKS
023657991007     C                   ELSE
023658991011     C     ACITY         CAT       ',':0         LINE5
023659991011     C                   CAT       ASTATE:1      LINE5
023660991011     C                   CAT       '.':0         LINE5
023661991008     C                   MOVE      AZIP          ZIP
023662991011     C                   CAT       ZIP1:2        LINE5
023663991008     C                   IF        ZIP2 <> '0000'
023664991008     C                   CAT       '-':0         LINE5
023665991008     C                   CAT       ZIP2:0        LINE5
023666991008     C                   ENDIF
023668991007     C                   EVAL      LINE6 = *BLANKS
023669991007     C                   EVAL      LINE7 = *BLANKS
023670991007     C                   ENDIF
023671991007     C                   ENDIF
023672991007     C                   WRITE     HDR2
023673991011     C                   CLEAR                   HDR2
023674991008     C                   ENDIF
023675991007     C                   ENDSR
023676991011
023677991011      * SUB/ACC BREAK SUBROUTINE
023678991011      *-------------------------
023679991011     C     ACCBRK        BEGSR
023681991011     C                   EVAL      MEMTOT = MEMTOT + MEMCNT
023682991011     C                   EVAL      MEMOUT = MEMCNT
023683991011     C                   EVAL      ACCOUT = ACCOUT + MEMCNT
023684991011     C                   CLEAR                   MEMCNT
023685991011     C                   WRITE     TOT1
023686130531     C                   EVAL      HLDSUB = RSUBC
023687130531     C                   EVAL      HLDACC = RACCTC
023688991011     C                   ENDSR
023689991011
023690991011      * SUB/ACC BREAK SUBROUTINE
023691991011      *-------------------------
023692991011     C     TRSBRK        BEGSR
023693991011     C                   WRITE     TOT2
023694991011     C                   CLEAR                   ACCOUT
023695991014     C                   IF        *IN90 = *OFF
023696991011     C                   WRITE     HDR1
023697991014     C                   EVAL      *IN80 = *OFF
023699991011     C                   EXSR      HEAD2
023700130531     C                   EVAL      HLDTRS = RTRUSTC
023701991014     C                   ENDIF
023702991011     C                   ENDSR
023703991011
023704991008      * INITIALIZATION SUBROUTINE
023705991008      *---------------------------
023706991007     C     *INZSR        BEGSR
023707991007     C                   EVAL      UD8YMD = *DATE
023709991008     C                   WRITE     HDR1
023710991007     C                   ENDSR
