000100151106     h Option(*NoDebugIo)
000200151106      *--------------------------------------------------------------------
000300151106      ** RATING REGION MAINTENANCE
000400151106      ** SSK JANUARY 2014
000500151106      **
000600151106      ** SSK.02.17.2014 ADD CARRIER GROUPER
000700151106      **                ADD REGION DATE RANGE CHECK
000800151106      **
000900151106      ** SSK.07.22.2014 CHANGE TO DATE LOGIC
001000151106      ** SBT.03.11.2015 Replace Stephen with me as user that can do maintenance
001100151106      ** SBT.09.09.2015 Add Brandon to users that can do maintenance
001200151106      ** B.Rees  11/6/2015  BR01  Added a Delete Function to the Screen
001300151106      *     Added Function Security to this program.
001400151229      *  B.Rees  12/29/2015  BR02  Fixed an issue where Brandon could not add
001500151229      *   an Evergreen Rating Region.
001600160201      ** dlk 02/01/2016 - fix hist effective date
001700160218      *  B.Rees  02/28/2016  BR03  Removed Writing to ACARGRPH. Now writing to
001800160218      *        f.hist.
001900151106      *--------------------------------------------------------------------
002000140127     FFM520D    CF   E             WORKSTN INFDS(WSDS) SFILE(TSASFL:RRT)
002100140224     FACARGRP   UF A E           K DISK
002200140127     FHIST      O  A E             DISK
002300140127     FAC2MSTL2  IF   E           K DISK
002400140127     FACMUNIQUE IF   E           K DISK
002500140127     FCOUNTYCOL1IF   E           K DISK
002600140127     FRATEREGIONIF   E           K DISK
002700140127     FSTATECD   IF   E           K DISK
002800140217     FHYPERCARR IF   E           K DISK
002900140220     FCODE20P   IF   E           K DISK
003000140127     FDIARYHD0  O  A E             DISK
003100140127     FDIARYDT0  O  A E             DISK
003200160218br01 F**ACARGRPH  O  A E           K DISK    ExtDesc('HISTORY/ACARGRPH')
003300160218br01 F**                                     ExtFile(*extdesc)
003400160218br01 F**                                     prefix('H')
003500151106      *--------------------------------------------------------------------
003600151106
003700140127     D WSDS            DS
003800140127     D  FKEY                 369    369A
003900140127    ***
004000151106br01 D ENTER           C                   CONST(X'F1')
004100140127     D  F1             C                   CONST(X'31')
004200140127     D  F2             C                   CONST(X'32')
004300140127     D  F3             C                   CONST(X'33')
004400140127     D  F4             C                   CONST(X'34')
004500140127     D  F5             C                   CONST(X'35')
004600140127     D  F6             C                   CONST(X'36')
004700140127     D  F7             C                   CONST(X'37')
004800140127     D  F8             C                   CONST(X'38')
004900140127     D  F9             C                   CONST(X'39')
005000140127     D  F10            C                   CONST(X'3A')
005100140127     D  F11            C                   CONST(X'3B')
005200140127     D  F12            C                   CONST(X'3C')
005300140127     D  F13            C                   CONST(X'B1')
005400140127     D  F14            C                   CONST(X'B2')
005500140127     D  F15            C                   CONST(X'B3')
005600140127     D  F16            C                   CONST(X'B4')
005700140127     D  F17            C                   CONST(X'B5')
005800140127     D  F18            C                   CONST(X'B6')
005900140127     D  F19            C                   CONST(X'B7')
006000140127     D  F20            C                   CONST(X'B8')
006100140127     D  F21            C                   CONST(X'B9')
006200140127     D  F22            C                   CONST(X'BA')
006300140127     D  F23            C                   CONST(X'BB')
006400140127     D  F24            C                   CONST(X'BC')
006500151106
006600151106     D pgmsts         sDS
006700151106     D  @pgmq            *proc
006800151106     D  Routine          *ROUTINE
006900151106     D  Jobname              244    253
007000151106     D  @User                254    263
007100151106     D  Jobnum               264    269s 0
007200151106
007300151106
007400140127     D                 DS
007500140127     D  PARM10                 1     10A
007600140127     D  T                      1      3S 0
007700140127     D  S                      4      6S 0
007800140127     D  A                      7     10S 0
007900140218     D @T                      1      3A
008000140218     D @S                      4      6A
008100140218     D @A                      7     10A
008200140127    ***
008300140220     D KF@TYPE         S                   LIKE(C20TYPE)
008400140220     D KF@CODE         S                   LIKE(C20CODE)
008500140127     D KF@TRS          S                   LIKE(AGTRST)
008600140127     D KF@SUB          S                   LIKE(AGSUB#)
008700140127     D KF@ACC          S                   LIKE(AGACCT)
008800140218     D KF@CGR          S                   LIKE(AGCARGRP)
008900140127     D KF@PDT          S                   LIKE(AGPDT)
009000140127     D KF@FR           S                   LIKE(AGRNWLFR)
009100140127     D KF@TO           S                   LIKE(AGRNWLTO)
009200140127     D KF@REGN         S                   LIKE(AGRATRGN)
009300140220     D KF@STATE        S              2A   INZ
009400140220     D KF@CNTY         S              2A   INZ
009500140220     D B_CNTY          S             30A   INZ
009600140220     D P_CNTY          S             30A   INZ
009700170117     D KF@ACAR         S              6A   INZ
009800170117     D @22             S             22A   INZ
009900140220     D #9S0            S              9S 0 INZ
010000140127    ***
010100140127     D SYSDATEYMD      S               D   DATFMT(*ISO)
010200140127     D SYSTIME         S               T
010300140220     D TO#LIMIT        S              8S 0 INZ
010400140127    ***
010500140220     D @PROC           S             10A   INZ
010600140220     D PRM@AA          S             69A   INZ
010700140220     D @EMSG           S                   LIKE(EMSG)
010800140220     D @SORTBY         S              1A   INZ
010900140220     D ORIGTO          S              8A   INZ
011000140220     D ORIGFROM        S              8A   INZ
011100140402     D ORIGCNTY        S              2A   INZ
011200140220     D ORIGSTATE       S              2A   INZ
011300140220     D ORIGREGN        S              7A   INZ
011400140220     D RRT             S              4S 0 INZ
011500140220     D #CNTREC         S              4S 0 INZ
011600140220     D #ISO            S               D   DATFMT(*ISO)
011700140220     D #XSX            S              8S 0 INZ
011800140220     D @1STLOOP        S              1A   INZ
011900140220     D @8FLD           S              8A   INZ
012000140220     D @FLAG           S              1A   INZ
012100140220     D ACCDESC         S             60A   INZ
012200140127    ***
012300140127     D                 DS
012400140127     D AA@DS                   1     69A
012500140127     D PRM_DTA                16     65A
012600140127     D PRM_AA                 66     68
012700140127     D PRM_RES                69     69A
012800140127    ***
012900140220     D @50             S             50A   INZ
013000140127    ***
013100140127     D @TIMESTAMP      DS
013200140127     D  #TSCYMD                1      8S 0
013300140127     D  #TSTIME                9     14S 0
013400140127     D  @TSJOB                15     24
013500140127     D  @TSUSER               25     34
013600140127     D  #TSNBR                35     40S 0
013700140127    ***
013800140127     D @TS40           S             40A
013900140127    ***
014000140220     D IN_USE          S               N   INZ(*OFF)
014100140218     D DUPE_FND        S               N   INZ(*OFF)
014200140218     D GOOD_DTA        S               N   INZ(*OFF)
014300140722     D ALLOW_MNT       S               N   INZ(*OFF)
014400140722     D TODATEONLY      S               N   INZ(*OFF)
014500140127     D YES             S               N   INZ(*ON)
014600140127     D NO              S               N   INZ(*OFF)
014700140128    ***
014800140128     D DS@AC2        E DS                  EXTNAME(AC2MST)
014900140127    ***
015000140127     D DS@ACM        E DS                  EXTNAME(ACCMST)
015100140127    ***
015200140127     D CLR@COUNTY    E DS                  EXTNAME(COUNTYCODE)
015300140127    ***
015400140224     D CLR@ACARGR    E DS                  EXTNAME(ACARGRP)
015500151106     D
015600151106     D
015700151106br01 D SecFunc         s             20
015800151106br01 D Continue        s              1
015900151223br01 D DspErrMsg       s              1
016000151106      *--------------------------------------------------------------------
016100140127    ***
016200140127   X***X
016300140127     D                UDS
016400140127     D  CONAME               201    240
016500140127   X***X
016600140127     C                   EVAL      @PROC = 'GET SET UP'
016700140127    ***
016800140127     C                   DOU       @PROC = 'LEAVE PGM '
016900140218     C     @PROC         CASEQ     'ADD FUNCTN'  $ADDFXN
017000140127     C     @PROC         CASEQ     'GET SET UP'  $SETUP
017100140127     C     @PROC         CASEQ     'GET ACCTS '  $ACCTINFO
017200140127     C     @PROC         CASEQ     'LOAD SUBFL'  $LOADSFL
017300140127     C     @PROC         CASEQ     'SELECTION '  $SELECT
017400140127     C                   ENDCS
017500140127     C                   ENDDO
017600140127    ***
017700140127     C                   EVAL      *INLR = *ON
017800140127    ***
017900140127    ***
018000140127   S***S
018100140220    *** SET THE STAGE FOR APP TO DISPLAY
018200140220    ***
018300140127     C     $SETUP        BEGSR
018400140127    ***
018500140127     C                   EVAL      @PROC = 'GET ACCTS '
018600140127    ***
018700140127     C                   EVAL      KF@TRS = T
018800140127     C                   EVAL      KF@SUB = S
018900140127     C                   EVAL      KF@ACC = A
019000140127    ***
019100140218     C                   CLEAR                   DS@ACM
019200140127     C                   CLEAR                   TSACTL
019300140127     C                   CLEAR                   SCREEN
019400140218     C                   CLEAR                   ADDSCRN
019500140127    ***
019600140127     C* CLEAR SFL
019700140127     C                   MOVEA     '011'         *IN(25)
019800140127     C                   WRITE     TSACTL
019900140127     C                   MOVEA     '010'         *IN(25)
020000140127     C                   Z-ADD     *ZERO         RRT
020100140127    ***
020200140127     C                   EVAL      CONAM = CONAME
020300140127    ***
020400140127     C                   ENDSR
020500140127   S***S
020600140220    *** GET ADDRESS INFORMATION
020700140220    ***
020800140127     C     $ACCTINFO     BEGSR
020900140127    ***
021000140127     C                   EVAL      @PROC = 'LOAD SUBFL'
021100140127    ***
021200140127     C     KL#TSA        CHAIN     ACCMSR
021300140127     C                   IF        NOT %FOUND(ACMUNIQUE)
021400140127     C                   CLEAR                   DS@ACM
021500140218     C                   EVAL      ACCDESC = @T + ' ' + @S + ' ' + @A +
021600140218     C                             '  *INVALID ACCT*'
021700140218     C                   EVAL      ADMDESC = '*INVALID ACCT*'
021800140218     C                   ELSE
021900140218     C                   EXSR      $ACCTFMT
022000140127     C                   ENDIF
022100140127    ***
022200140127     C     KL#TSA        CHAIN     ACCMSR2
022300140127     C                   IF        NOT %FOUND(AC2MSTL2) OR
022400140127     C                             (%FOUND(AC2MSTL2) AND
022500140127     C                             A2STATE = *BLANKS)
022600140128     C                   CLEAR                   DS@AC2
022700140128     C                   ELSE
022800140127     C                   EVAL      KF@STATE = A2STATE
022900140127     C                   EVAL      KF@CNTY = A2COUNTYCD
023000140127     C                   EXSR      $COUNTY
023100140127     C                   EVAL      P_CNTY = CDESCR
023200140128     C                   EVAL      SCPADR1    = A2ADDRESS1
023300140128     C                   EVAL      SCPADR2    = A2ADDRESS2
023400140128     C                   EVAL      SCPCITY    = A2CITY
023500140128     C                   EVAL      SCPSTATE   = A2STATE
023600140128     C                   EVAL      SCPZIP     = %EDITC(A2ZIP5:'X')
023700140128     C                   EVAL      SCPCNTY    = A2COUNTYCD
023800140128     C                   EVAL      SCPCNTYDES = P_CNTY
023900140127     C                   ENDIF
024000140127    ***
024100140127     C     KL#TSA        SETLL     ACARGRF
024200140127    ***
024300140218     C                   EVAL      SCACCT = ACCDESC
024400140127     C                   EVAL      @FLAG = 'L'
024500140127     C                   MOVE      *ZEROS        #CNTREC
024600140127     C                   MOVE      '0'           @1STLOOP
024700140218    ***
024800140218     C                   ENDSR
024900140218   S***S
025000140220    *** FORMAT BILLING ADDRESS, COVER THRU DATE, AND ACCOUNT NAME + ADMIN
025100140220    ***
025200140218     C     $ACCTFMT      BEGSR
025300140218    ***
025400140218     C                   EVAL      ACCDESC = @T + ' ' + @S + ' ' + @A +
025500140218     C                             '  ' + %TRIM(ACNAM1)
025600140218    ***
025700140218     C                   EVAL      PRM@AA = PARM10 + 'NAME '
025800140218     C                   CALL      'GETAA'
025900140218     C                   PARM                    PRM@AA
026000140218     C                   EVAL      AA@DS = PRM@AA
026100140218     C                   EVAL      ADMDESC = %TRIM(PRM_DTA)
026200140218    ***
026300140218     C                   EVAL      SCBADR1    = AADDR1
026400140218     C                   EVAL      SCBADR2    = AADDR2
026500140218     C                   EVAL      SCBCITY    = ACITY
026600140218     C                   EVAL      SCBSTATE   = ASTATE
026700140218     C                   EVAL      SCBZIP     = %SUBST(%EDITC(AZIP:'X'):1:5)
026800140218     C                   EVAL      SCBCNTY    = ACONTY
026900140127    ***
027000140218     C                   EVAL      KF@STATE = ASTATE
027100140218     C                   EVAL      KF@CNTY = ACONTY
027200140218     C                   EXSR      $COUNTY
027300140218     C                   EVAL      B_CNTY = CDESCR
027400140218     C                   EVAL      SCBCNTYDES = B_CNTY
027500140218    ***
027600140218     C                   IF        ACVTDT = 0
027700140218     C                   EVAL      SCLAST = 0
027800140218     C                   ELSE
027900140218     C     ACVTDT        MULT      10000.0001    SCLAST
028000140218     C                   ENDIF
028100140218    ***
028200140127     C                   ENDSR
028300140127   S***S
028400140220    *** GET COUNTY INFORMATION
028500140220    ***
028600140127     C     $COUNTY       BEGSR
028700140127    ***
028800140127     C     KL#SC         CHAIN     COUNTYCODR
028900140127    ***
029000140127     C                   IF        NOT %FOUND(COUNTYCOL1)
029100140127     C                   CLEAR                   CLR@COUNTY
029200140127     C                   ENDIF
029300140127    ***
029400140127     C                   ENDSR
029500140127   S***S
029600140220    *** LOAD THE SUBFILE RECORDS
029700140220    ***
029800140127     C     $LOADSFL      BEGSR
029900140127    ***
030000140127     C                   IF        @FLAG = 'X' OR #CNTREC >= 280
030100140127     C                   EVAL      @PROC = 'SELECTION '
030200140127     C                   LEAVESR
030300140127     C                   ENDIF
030400140127    ***
030500140127     C     KL#TSA        READE     ACARGRF
030600140127    ***
030700140224     C                   IF        %EOF(ACARGRP)
030800140127     C                   EVAL      @FLAG = 'X'
030900140127     C                   LEAVESR
031000140127     C                   ENDIF
031100140127    ***
031200140127     C                   MOVE      *ON           *IN25
031300140127    ***
031400140127     C                   EVAL      S01 = *BLANKS
031500140127     C                   EVAL      SFSTATE = AGSTATE
031600140127     C                   EVAL      SFREGN = AGRATRGN
031700140217     C                   EVAL      SFCARGRP = AGCARGRP
031800140401     C                   EVAL      SFCNTY = AGCNTY
031900140401    ***
032000140127     C                   SELECT
032100140127     C                   WHEN      AGPDT = 'M'
032200140127     C                   EVAL      SFPDT = 'MEDICAL'
032300140127     C                   WHEN      AGPDT = 'D'
032400140127     C                   EVAL      SFPDT = 'DENTAL'
032500140127     C                   WHEN      AGPDT = 'V'
032600140127     C                   EVAL      SFPDT = 'VISION'
032700140127     C                   OTHER
032800140127     C                   EVAL      SFPDT = 'UNKNOWN'
032900140127     C                   ENDSL
033000140127    ***
033100140127     C                   EVAL      H@PDT = SFPDT
033200140221     C                   EVAL      H@ACA = CLR@ACARGR
033300140127    ***
033400140127     C                   EVAL      KF@STATE = AGSTATE
033500140127     C                   EXSR      $STATE
033600140217     C                   EVAL      SFSTADES = %TRIM(@50)
033700140217     C                   EVAL      H@STATE = %TRIM(@50)
033800140217    ***
033900140220     C                   EVAL      KF@CGR = AGCARGRP
034000140217     C                   EXSR      $HYPER
034100140217     C                   EVAL      SFCGRDES = %TRIM(@50)
034200140217     C                   EVAL      H@HYC = %TRIM(@50)
034300140127    ***
034400140127     C                   EVAL      KF@REGN = AGRATRGN
034500140127     C                   EXSR      $REGION
034600140127     C                   EVAL      SFREGNDES = %TRIM(@50)
034700140127    ***
034800140402     C                   EVAL      KF@CNTY = AGCNTY
034900140401     C                   EXSR      $COUNTY
035000140401     C                   EVAL      SFCNTYDES = CDESCR
035100140401    ***
035200140127     C     AGRNWLFR      MULT      10000.0001    SFRNWLFR
035300140127     C     AGRNWLTO      MULT      10000.0001    SFRNWLTO
035400140127    ***
035500140127     C                   ADD       1             #CNTREC
035600140127     C                   ADD       1             RRT
035700140127    ***
035800140127     C                   IF        @1STLOOP = '0'
035900140127     C                   Z-ADD     RRT           SFLPOS
036000140127     C                   MOVE      '1'           @1STLOOP
036100140127     C                   ENDIF
036200140127    ***
036300140127     C                   WRITE     TSASFL
036400140127    ***
036500140127     C                   ENDSR
036600140127   S***S
036700140220    *** RETRIEVE STATE/REGION DESCRIPTION
036800140220    ***
036900140127     C     $REGION       BEGSR
037000140127    ***
037100140127     C                   EVAL      @50 = '*UNKNOWN*'
037200140127    ***
037300140127     C     KL#SR         CHAIN     RATEREGIOR
037400140127    ***
037500140127     C                   IF        %FOUND(RATEREGION)
037600140127     C                   EVAL      @50 = MDESCR
037700140127     C                   ENDIF
037800140127    ***
037900140127     C                   ENDSR
038000140127   S***S
038100140220    *** RETRIEVE STATE DESCRIPTION
038200140220    ***
038300140127     C     $STATE        BEGSR
038400140127    ***
038500140127     C                   EVAL      @50 = '*UNKNOWN*'
038600140127    ***
038700140127     C     KF@STATE      CHAIN     STATEF
038800140127    ***
038900140127     C                   IF        %FOUND(STATECD)
039000140127     C                   EVAL      @50 = %TRIM(STNAME)
039100140127     C                   ENDIF
039200140127    ***
039300140127     C                   ENDSR
039400140127   S***S
039500140220    *** RETRIEVE CARRIER GROUPER
039600140220    ***
039700140217     C     $HYPER        BEGSR
039800140217    ***
039900140217     C                   EVAL      @50 = '*UNKNOWN*'
040000140217    ***
040100140220     C     KF@CGR        CHAIN     RHC
040200140217    ***
040300140217     C                   IF        %FOUND(HYPERCARR)
040400140217     C                   EVAL      @50 = %TRIM(HCNAME)
040500140217     C                   ENDIF
040600140217    ***
040700140217     C                   ENDSR
040800140217   S***S
040900140220    *** CONTROL LOOP FOR SUBFILE SCREEN
041000140220    ***
041100140127     C     $SELECT       BEGSR
041200140127    ***
041300140127     C                   EVAL      EMSG = @EMSG
041400140127     C                   WRITE     TSAREC
041500140127     C                   EXFMT     TSACTL
041600140127     C                   EVAL      EMSG = *BLANKS
041700140127     C                   EVAL      @EMSG = *BLANKS
041800140127    ***
041900140127     C                   IF        FKEY = F3 OR FKEY = F12
042000140127     C                   EVAL      @PROC = 'LEAVE PGM '
042100140127     C                   LEAVESR
042200140127     C                   ENDIF
042300140127    ***
042400140220    *** ADD A NEW RANGE
042500140220    ***
042600140722     C                   IF        FKEY = F6 AND ALLOW_MNT = YES
042700140218     C                   EVAL      @PROC = 'ADD FUNCTN'
042800140218     C                   LEAVESR
042900140218     C                   ENDIF
043000140218    ***
043100140220    *** CHECK FOR A SELECTED RECORD TO INQUIRE OR MAINTAIN
043200140220    ***
043300140722     C                   IF        #CNTREC > 0 AND ALLOW_MNT = YES
043400140127     C                   EXSR      $CHKSELC
043500140127     C                   ENDIF
043600140218    ***
043700140218     C                   ENDSR
043800140218   S***S
043900140220    *** ADD FUNTION CONTROL
044000140220    ***
044100140218     C     $ADDFXN       BEGSR
044200140218    ***
044300140218     C                   CLEAR                   ADDSCRN
044400140218     C                   EVAL      CONAM = CONAME
044500140218     C                   CLEAR                   CLR@ACARGR
044600140218     C                   EVAL      SAACCT = ACCDESC
044700140218     C                   EVAL      *IN40 = *ON
044800140218     C                   EVAL      *IN50 = *OFF
044900140722     C                   EVAL      *IN51 = *OFF
045000140224     C                   EVAL      *IN60 = *ON
045100140224     C                   EVAL      *IN61 = *OFF
045200140218    ***
045300140218     C                   DOU       FKEY = F12
045400140218     C                   EXSR      $ADDLOOP
045500140218     C                   ENDDO
045600140218    ***
045700140219     C                   EVAL      @PROC = 'GET SET UP'
045800140219    ***
045900140218     C                   ENDSR
046000140218   S***S
046100140220    *** ADD FUNTION LOOP
046200140220    ***
046300140218     C     $ADDLOOP      BEGSR
046400140218    ***
046500140220    *** DISPLAY SCREEN
046600140220    ***
046700140218     C                   EVAL      EMSG = @EMSG
046800140220     C                   EXFMT     ADDSCRN
046900140218     C                   EVAL      EMSG = *BLANKS
047000140218     C                   EVAL      @EMSG = *BLANKS
047100140218    ***
047200140220    *** EXIT ADD FUNCTION
047300140220    ***
047400140218     C                   IF        FKEY = F12
047500140218     C                   EVAL      *IN50 = *OFF
047600140722     C                   EVAL      *IN51 = *OFF
047700140219     C                   LEAVESR
047800140218     C                   ENDIF
047900140127    ***
048000140220    *** PROMPT
048100140220    ***
048200140224     C                   IF        FKEY = F4 AND *IN60 = *ON
048300140722     C                   EVAL      *IN50 = *OFF
048400140218     C                   EXSR      $F4A
048500140218     C                   LEAVESR
048600140218     C                   ENDIF
048700140218    ***
048800140224    *** UPDATE REQUEST
048900140220    ***
049000140224     C                   IF        FKEY = F10 AND *IN61 = *ON
049100140224     C                   EVAL      *IN50 = *ON
049200140224     C                   EVAL      *IN60 = *OFF
049300140224     C                   EVAL      *IN61 = *OFF
049400140219     C                   EXSR      $WRITE
049500140220     C                   LEAVESR
049600140219     C                   ENDIF
049700140224    ***
049800140224    *** VALIDATE
049900140224    ***
050000140224     C                   EXSR      $VALIDADD
050100140218    ***
050200140220    *** VALIDATION WAS SUCCESSFUL
050300140220    ***
050400140219     C                   IF        GOOD_DTA = YES
050500140224     C                   EVAL      *IN61 = *ON
050600140219     C                   ENDIF
050700140219    ***
050800140219     C                   ENDSR
050900140219   S***S
051000140220    *** WRITE CONTROL LOOP
051100140220    ***
051200140219     C     $WRITE        BEGSR
051300140220    ***
051400140220     C                   EVAL      @EMSG =
051500140220     C                             'PRESS ANY KEY TO CONFIRM OR F12 TO CANCEL'
051600140220    ***
051700140219     C                   EVAL      EMSG = @EMSG
051800140221     C                   EXFMT     ADDSCRN
051900140219     C                   EVAL      EMSG = *BLANKS
052000140219     C                   EVAL      @EMSG = *BLANKS
052100140220    ***
052200140220    *** BACK TO ADD EDITING LOOP
052300140220    ***
052400140220     C                   IF        FKEY = F12
052500140220     C                   EVAL      FKEY = F1
052600140220     C                   EVAL      *IN50 = *OFF
052700140722     C                   EVAL      *IN51 = *OFF
052800140224     C                   EVAL      *IN60 = *ON
052900140224     C                   EVAL      *IN61 = *OFF
053000140220     C                   LEAVESR
053100140220     C                   ENDIF
053200140220    ***
053300140220     C                   CLEAR                   ACARGRF
053400140220     C                   EVAL      AGTRST = KF@TRS
053500140220     C                   EVAL      AGSUB# = KF@SUB
053600140220     C                   EVAL      AGACCT = KF@ACC
053700140220     C                   EVAL      AGPDT  = SAPDT
053800140220     C                   EVAL      AGCARGRP = SACARGRP
053900140220     C                   EVAL      AGRNWLFR = KF@FR
054000140220     C                   EVAL      AGRNWLTO = KF@TO
054100140220     C                   EVAL      AGRATRGN = SAREGN
054200140220     C                   EVAL      AGSTATE = SASTATE
054300140402     C                   EVAL      AGCNTY = SACNTY
054400140220     C                   WRITE     ACARGRF
054500160218
054600160218     C*?Write to F.Hist
054700160218     C                   eval      hkey = parm10
054800160218     C                   eval      trCode = 'LRA'
054900160218     C                   eval      ck#Not = agcargrp + '-' +
055000160218     C                                      %Char(agrnwlfr) + '-' +
055100160218     C                                      %Char(agrnwlto)
055200160218     C                   eval      note2 = agRatrgn + ' - ' + agState
055300160218     C                   eval      hPrgnm = 'FM520R'
055400160218     C                   eval      trDate = %Dec(%Date)
055500160218     C                   eval      hsTrst = t
055600160218     C                   eval      hsSub# = s
055700160218     C                   eval      hsAcct = a
055800160218     C                   eval      hsDltD = 'A'
055900160218     C                   eval      hsTrTime = %Time
056000160218     C                   eval      covtDt = ck#to
056100160218     C                   eval      hOper = @Tsuser
056200160218     C                   write     histr
056300160218     C
056400160218     C
056500140220    ***
056600140220     C                   EVAL      @EMSG = 'RECORD ADDED'
056700140220     C                   EVAL      FKEY = F12
056800140219     C                   EVAL      *IN50 = *OFF
056900140220    ***
057000140218     C                   ENDSR
057100140218   S***S
057200140218     C     $VALIDADD     BEGSR
057300140218    ***
057400140218    *** GUILTY UNTIL PROVEN OTHERWISE
057500140218    ***
057600140218     C                   EVAL      GOOD_DTA = NO
057700140218    ***
057800140220    *** ONLY MEDICAL AND DENTAL
057900140220    ***
058000140218     C                   IF        SAPDT <> 'M' AND SAPDT <> 'D'
058100140218     C                   EVAL      @EMSG = 'INVALID PRODUCT'
058200140218     C                   LEAVESR
058300140218     C                   ENDIF
058400140218    ***
058500140218     C                   EVAL      KF@PDT = SAPDT
058600140218     C                   EVAL      KF@STATE = SASTATE
058700140218    ***
058800140220    *** ONLY VALID STATE CODE
058900140220    ***
059000140218     C                   EXSR      $STATE
059100140218     C                   EVAL      D_STATE = %TRIM(@50)
059200140218     C                   IF        @50 = '*UNKNOWN*'
059300140218     C                   EVAL      @EMSG = 'INVALID STATE CODE'
059400140218     C                   LEAVESR
059500140218     C                   ENDIF
059600140218    ***
059700140220    *** ONLY STATE CODES SET UP IN CODE20 ARE ACCEPTABLE
059800140220    ***
059900140220     C                   EVAL      KF@TYPE = 'RATE STATE'
060000140220     C                   EVAL      KF@CODE = KF@STATE
060100140220     C     KL#C20        CHAIN     CODE20F
060200140220     C                   IF        NOT %FOUND(CODE20P)
060300140220     C                   EVAL      @EMSG = 'RATE STATE NOT SET UP, CONTACT I.S.'
060400140220     C                   LEAVESR
060500140220     C                   ENDIF
060600140220    ***
060700140220    *** DEFAULT FEATURE FOR 'VALUE' STATES; NOT 'RETRIEVE' STATES
060800140220    ***
060900140220     C                   IF        C20ACTN1 = 'VALUE' AND
061000140220     C                             SAREGN = *BLANKS
061100140220     C                   EVAL      SAREGN = C20ACTN2
061200140220     C                   ENDIF
061300140220    ***
061400140218     C                   EVAL      KF@REGN = SAREGN
061500140220    ***
061600140220    *** REGION MUST EXIST
061700140220    ***
061800140218     C                   EXSR      $REGION
061900140218     C                   EVAL      D_REGNDES = %TRIM(@50)
062000140218     C                   IF        @50 = '*UNKNOWN*'
062100140218     C                   EVAL      @EMSG = 'INVALID STATE/REGION COMBINATION'
062200140218     C                   LEAVESR
062300140218     C                   ENDIF
062400140220    ***
062500140220    *** CANNOT BE A DIFFERENT REGION FOR STATE IT IS SET UP FOR IF RESTRICTED
062600140220    ***
062700140220     C                   IF        C20ACTN1 = 'VALUE' AND
062800140220     C                             C20ACTN2 <> KF@REGN
062900140220     C                   EVAL      @EMSG = 'INVALID REGION FOR STATE'
063000140220     C                   LEAVESR
063100140220     C                   ENDIF
063200140218    ***
063300140220    *** VALID CARRIER GROUPER
063400140220    ***
063500140220     C                   EVAL      KF@CGR = SACARGRP
063600140218     C                   EXSR      $HYPER
063700140218     C                   EVAL      D_CARGRP = %TRIM(@50)
063800140218     C                   IF        @50 = '*UNKNOWN*'
063900140218     C                   EVAL      @EMSG = 'INVALID CARRIER GROUPER'
064000140218     C                   LEAVESR
064100140218     C                   ENDIF
064200140220    ***
064300140220    *** CARRIER GROUPER MUST BE SET UP FOR ACA RATE RETRIEVAL
064400140220    ***
064500140220     C                   EVAL      KF@TYPE = 'RATE CARR'
064600140220     C                   EVAL      KF@CODE = KF@CGR
064700140220     C     KL#C20        CHAIN     CODE20F
064800140220     C                   IF        NOT %FOUND(CODE20P)
064900140220     C                   EVAL      @EMSG = 'CARRIER GROUPER NOT SET UP, CONTA' +
065000140220     C                             'CT I.S.'
065100140220     C                   LEAVESR
065200140220     C                   ENDIF
065300140220    ***
065400140220    *** CHECK FOR EXISTING REGION AND CARRIER RECORD ON AGERATE
065500140220    ***
065600140220     C                   EXSR      $INUSE
065700140220     C                   IF        IN_USE = NO
065800140220     C                   EVAL      @EMSG = 'ACA RATE TABLE DOES NOT HAVE THIS' +
065900140220     C                             ' CARRIER/REGION DATA'
066000140220     C                   LEAVESR
066100140220     C                   ENDIF
066200140220    ***
066300140220    *** VALID FROM DATE OF COURSE
066400140220    ***
066500140218     C     *USA          TEST(DE)                SARNWLFR
066600140218     C                   IF        %ERROR
066700140218     C                   EVAL      @EMSG = 'INVALID FROM DATE'
066800140218     C                   LEAVESR
066900140218     C                   ENDIF
067000140218     C     SARNWLFR      MULT      10000.0001    KF@FR
067100140220    ***
067200140220    *** 12 MONTHS FROM THE FROM DATE
067300140220    ***
067400140220     C                   MOVE      KF@FR         #ISO
067500140220     C                   ADDDUR    1:*Y          #ISO
067600140220     C                   SUBDUR    1:*D          #ISO
067700140220     C                   MOVE      #ISO          TO#LIMIT
067800140218    ***
067900140220    *** IF TO DATE IS ZERO, WE CALCULATE FOR YOU.
068000140220    ***
068100140218     C                   IF        SARNWLTO = 0
068200140220     C                   EVAL      KF@TO = TO#LIMIT
068300140221     C     KF@TO         MULT      10000.0001    SARNWLTO
068400140218     C                   ELSE
068500140218     C     *USA          TEST(DE)                SARNWLTO
068600140218     C                   IF        %ERROR
068700140218     C                   EVAL      @EMSG = 'INVALID TO DATE'
068800140218     C                   LEAVESR
068900140218     C                   ENDIF
069000140218     C     SARNWLTO      MULT      10000.0001    KF@TO
069100140218     C                   ENDIF
069200140220    ***
069300140220    *** NO SPANS BEYOND 12 MONTHS
069400140220    ***
069500140220     C                   IF        KF@TO > TO#LIMIT
069600140224     C                   EVAL      @EMSG = '**WARNING**YEAR LIMIT EXCEEDED'
069700140220     C                   ENDIF
069800140722    ***
069900140722    *** NO TO-DATE PRIOR TO FROM-DATE
070000140722    ***
070100140722     C                   IF        KF@TO < KF@FR
070200140722     C                   EVAL      @EMSG = 'TO DATE MUST BE GREATER THAN FROM'
070300140722     C                   LEAVESR
070400140722     C                   ENDIF
070500140220    ***
070600140220    *** NO SAME DAY TERMS
070700140220    ***
070800140220     C                   IF        KF@TO = KF@FR
070900140220     C                   EVAL      @EMSG = 'YOU CANNOT SAME DAY TERM'
071000140220     C                   LEAVESR
071100140220     C                   ENDIF
071200140220    ***
071300140220    *** NO EXACT DUPES
071400140218    ***
071500140218     C     KL#ACAR       CHAIN     ACARGRF
071600140722     C                   IF        %FOUND(ACARGRP)
071700140218     C                   EVAL      @EMSG = 'RECORD ALREADY EXISTS'
071800140218     C                   LEAVESR
071900140218     C                   ENDIF
072000140220    ***
072100140722    *** IF ACCOUNT HAS BEEN INVOICED, CHECK FROM/TO AGAINST COVER THRU
072200140722    ***   NEW RANGE MUST BE GREATER THAN COVER THRU
072300140722    ***
072400140722     C                   IF        ACVTDT > 0
072500140722     C                   MOVEL     ACVTDT        ACV@YM            6
072600140722     C                   MOVEL     KF@FR         RGF@YM            6
072700140722     C                   MOVEL     KF@TO         RGT@YM            6
072800140722     C                   IF        RGT@YM <= ACV@YM OR RGF@YM <= ACV@YM
072900140722     C                   EVAL      @EMSG = 'CANNOT ADD TO INVOICED PERIOD'
073000140220     C                   LEAVESR
073100140722     C                   ENDIF
073200140220     C                   ENDIF
073300140218    ***
073400140218     C                   EXSR      $DUPESCAN
073500140219     C                   IF        DUPE_FND = YES
073600140219     C                   EVAL      @EMSG = 'RANGE OVERLAP'
073700140219     C                   LEAVESR
073800140219     C                   ENDIF
073900140401    ***
074000140401     C                   IF        SACNTY <> *BLANKS
074100140401     C                   EVAL      KF@CNTY = SACNTY
074200140401     C                   EXSR      $COUNTY
074300140401     C                   EVAL      D_CNTY = CDESCR
074400140401     C                   ENDIF
074500140219    ***
074600140219     C                   EVAL      GOOD_DTA = YES
074700140220    ***
074800140220     C                   ENDSR
074900140220   S***S
075000140220    *** COUNT UP SOME RATE RECORDS AND SEE THE RESULT
075100140220    ***
075200140220     C     $ACARATE      BEGSR
075300140220    ***
075400170117     C                   EVAL      @22 = '000000000' + KF@REGN +
075500140220     C                             KF@ACAR
075600140220    ***
075700140220     C                   CALL      'FM521R'
075800170117     C                   PARM                    @22
075900140220    ***
076000170117     C                   MOVEL     @22           #9S0
076100140220    ***
076200140220     C                   ENDSR
076300140220   S***S
076400140220    *** CARRIER & ENTITY USAGE
076500140220    ***
076600140220     C     $INUSE        BEGSR
076700140220    ***
076800140220     C                   EVAL      IN_USE = YES
076900140220    ***
077000140220     C                   IF        C20ACTN1 <> 'ENTITY'
077100151229br02 C                   eval      kf@aCar = c20ACTN1
077200140220     C                   EXSR      $ACARATE
077300140220     C                   IF        #9S0 = 0
077400140220     C                   EVAL      IN_USE = NO
077500140220     C                   ENDIF
077600140220     C                   LEAVESR
077700140220     C                   ENDIF
077800140220    ***
077900140220     C                   EVAL      KF@ACAR = 'BLUEC'
078000140220     C                   EXSR      $ACARATE
078100140220     C                   IF        #9S0 > 0
078200140220     C                   LEAVESR
078300140220     C                   ENDIF
078400140220    ***
078500140220     C                   EVAL      KF@ACAR = 'CFMI '
078600140220     C                   EXSR      $ACARATE
078700140220     C                   IF        #9S0 > 0
078800140220     C                   LEAVESR
078900140220     C                   ENDIF
079000140220    ***
079100140220     C                   EVAL      KF@ACAR = 'GHMSI'
079200140220     C                   EXSR      $ACARATE
079300140220     C                   IF        #9S0 > 0
079400140220     C                   LEAVESR
079500140220     C                   ENDIF
079600140220    ***
079700140220     C                   EVAL      IN_USE = NO
079800140218    ***
079900140218     C                   ENDSR
080000140218   S***S
080100140218     C     $DUPESCAN     BEGSR
080200140218    ***
080300140218     C                   EVAL      DUPE_FND = NO
080400140218    ***
080500140218     C     KL#APG        CHAIN(N)  ACARGRF
080600140224     C                   IF        NOT %FOUND(ACARGRP)
080700140218     C                   LEAVESR
080800140218     C                   ENDIF
080900140218    ***
081000140218     C     KL#APG        SETLL     ACARGRF
081100140224     C                   DOU       %EOF(ACARGRP)
081200140218     C     KL#APG        READE(N)  ACARGRF
081300140224     C                   IF        NOT %EOF(ACARGRP)
081400140218    ***
081500140219     C                   IF        KF@TO < AGRNWLFR OR
081600140219     C                             KF@FR > AGRNWLTO
081700140219     C                   ITER
081800140219     C                   ENDIF
081900140219    ***
082000140219     C                   EVAL      DUPE_FND = YES
082100140219     C                   LEAVESR
082200140219    ***
082300140219     C                   ENDIF
082400140219     C                   ENDDO
082500140219    ***
082600140127     C                   ENDSR
082700140127   S***S
082800140218     C     $F4A          BEGSR
082900140218    ***
083000140218     C                   EVAL      @8FLD = %SUBST(SAFLD:3:8)
083100140218    ***
083200140218     C                   EXSR      $F4COMN
083300140218    ***
083400140218     C                   SELECT
083500140218    *** **
083600140218     C                   WHEN      SAFLD = 'SAREGN' OR SAFLD = 'SASTATE'
083700140218     C                   IF        @39 = *BLANKS
083800140218     C                   LEAVESR
083900140218     C                   ENDIF
084000140218     C                   EVAL      SASTATE = %SUBST(@39:1:2)
084100140218     C                   EVAL      SAREGN = %SUBST(@39:3:7)
084200140218     C                   EVAL      KF@STATE = SASTATE
084300140218     C                   EVAL      KF@REGN = SAREGN
084400140218     C                   EXSR      $STATE
084500140218     C                   EVAL      D_STATE = %TRIM(@50)
084600140218     C                   EXSR      $REGION
084700140218     C                   EVAL      D_REGNDES = %TRIM(@50)
084800140218    *** **
084900140220     C                   WHEN      SAFLD = 'SACARGRP'
085000140218     C                   IF        @33 = *BLANKS
085100140218     C                   LEAVESR
085200140218     C                   ENDIF
085300140218     C                   EVAL      SACARGRP = %SUBST(@33:1:2)
085400140220     C                   EVAL      KF@CGR = %SUBST(@33:1:2)
085500140218     C                   EXSR      $HYPER
085600140218     C                   EVAL      D_CARGRP = %TRIM(@50)
085700140218    *** **
085800140218     C                   ENDSL
085900140218    ***
086000140218     C                   ENDSR
086100140218   S***S
086200140218     C     $F4COMN       BEGSR
086300140218    ***
086400140218     C                   SELECT
086500140218    *** *
086600140218     C                   WHEN      @8FLD = 'REGN    ' OR
086700140218     C                             @8FLD = 'STATE   '
086800140218     C                   MOVE      *BLANKS       @39              39
086900140218     C                   CALL      'SLCREGNCL'
087000140218     C                   PARM                    @39
087100140218    ***
087200140218     C                   WHEN      @8FLD = 'CARGRP  '
087300140218     C                   MOVE      *BLANKS       @33              33
087400140218     C                   CALL      'SLCHYPER'
087500140218     C                   PARM      'LOAD'        WIRQS             8
087600140218     C                   PARM      *BLANKS       WORTN             8
087700140218     C                   PARM      'X'           WUPGM            10
087800140218     C                   PARM                    @33
087900140218    ***
088000140218     C                   ENDSL
088100140218    ***
088200140218     C                   ENDSR
088300151106   S* *------------------------------------------------------------------------
088400140127     C     $CHKSELC      BEGSR
088500140127    ***
088600140127    1C                   DOU       %EOF(FM520D)
088700140127     C                   READC     TSASFL
088800151106    2C                   IF        NOT %EOF(FM520D)
088900151106     C
089000151106     C                   if        s01 = 'C'
089100151106     C
089200140722     C                   CLEAR                   CLR@ACARGR
089300140722     C                   EVAL      CLR@ACARGR = H@ACA
089400151106     C
089500140722     C                   MOVEL     ACVTDT        ACV@YM            6
089600140722     C                   MOVEL     AGRNWLFR      RGF@YM            6
089700140722     C                   MOVEL     AGRNWLTO      RGT@YM            6
089800151106     C
089900140722       *IN50 = *OFF;
090000140722       *IN51 = *OFF;
090100140722     C*
090200140722     C*         F--------------------T
090300140722     C* 0  X    X         X          X    X
090400140722     C*
090500140722       SELECT;
090600140722         WHEN ACVTDT = 0 OR ACV@YM < RGF@YM;
090700140722           EXSR $MNTSCR;
090800140722         WHEN ACV@YM >= RGF@YM AND ACV@YM < RGT@YM;
090900140722           *IN51 = *ON;
091000140722           EXSR $MNTSCR;
091100140722         WHEN ACV@YM >= RGT@YM;
091200140722           EXSR $INQSCR;
091300140722       ENDSL;
091400140127     C*
091500151106    2C                   ENDIF                                                  'Change Mode'
091600151106     C
091700151106br01 C*?Delete Mode Option
091800151106     C
091900151106     C                   if        S01 = 'D'
092000151106     C*?Check Security...
092100151106     C                   eval      SecFunc = 'DELETE'
092200151223     C                   eval      DspErrMsg = 'Y'
092300151106     C                   call      'CHKFNCAUTH'
092400151106     C                   parm                    @pgmq
092500151106     C                   parm                    SecFunc
092600151223     C                   parm                    DspErrMsg
092700151106     C                   parm                    Continue
092800151106     C
092900151106     C                   if        Continue <> 'N'
093000151106     C                   CLEAR                   CLR@ACARGR
093100151106     C                   EVAL      CLR@ACARGR = H@ACA
093200151106     C
093300151106     C                   MOVEL     ACVTDT        ACV@YM            6
093400151106     C                   MOVEL     AGRNWLFR      RGF@YM            6
093500151106     C                   MOVEL     AGRNWLTO      RGT@YM            6
093600151106     C
093700151106     C                   exsr      $DltScr
093800151106     C                   endif
093900151106     C                   endif
094000151106     C
094100151106     C                   endif
094200151106     C
094300140127    1C                   ENDDO
094400140127    ***
094500140127     C                   EVAL      @PROC = 'GET SET UP'
094600140127    ***
094700140127     C                   ENDSR
094800151106   S* *------------------------------------------------------------------------
094900140127     C     $INQSCR       BEGSR
095000140127    ***
095100140127     C                   EVAL      *IN40 = *OFF
095200140127     C                   EVAL      *IN50 = *ON
095300140127    ***
095400140127     C                   EXSR      $FMTSCR
095500140127    ***
095600140127     C                   DOU       FKEY = F12
095700140127    ***
095800140127     C                   EVAL      EMSG = @EMSG
095900140127     C                   EXFMT     SCREEN
096000140127     C                   EVAL      EMSG = *BLANKS
096100140127     C                   EVAL      @EMSG = *BLANKS
096200140127    ***
096300140127     C                   IF        FKEY = F12
096400140127     C                   ITER
096500140127     C                   ENDIF
096600140127    ***
096700140127     C                   ENDDO
096800140127    ***
096900140127     C                   EVAL      *IN50 = *OFF
097000140722     C                   EVAL      *IN51 = *OFF
097100140127    ***
097200140127     C                   ENDSR
097300140127   S***S
097400140127     C     $FMTSCR       BEGSR
097500140127    ***
097600140127     C     AGRNWLFR      MULT      10000.0001    SCRNWLFR
097700140127     C     AGRNWLTO      MULT      10000.0001    SCRNWLTO
097800140220    ***
097900140220     C                   EVAL      SCPDT = H@PDT
098000140220     C                   EVAL      KF@FR = AGRNWLFR
098100140220     C                   EVAL      KF@TO = AGRNWLTO
098200140220    ***
098300140127     C                   EVAL      SCSTATE = AGSTATE
098400140127     C                   EVAL      SCREGN = AGRATRGN
098500140217     C                   EVAL      SCCARGRP = AGCARGRP
098600140402     C                   EVAL      SCCNTY = AGCNTY
098700140127    ***
098800140220     C                   EVAL      KF@PDT = AGPDT
098900140220     C                   EVAL      KF@CGR = AGCARGRP
099000140127     C                   EVAL      KF@STATE = AGSTATE
099100140127     C                   EVAL      KF@REGN = AGRATRGN
099200140402    ***
099300140402     C                   IF        SCCNTY <> *BLANKS
099400140402     C                   EVAL      KF@CNTY = SCCNTY
099500140402     C                   EXSR      $COUNTY
099600140402     C                   EVAL      D_CNTY = CDESCR
099700140402     C                   ENDIF
099800140127    ***
099900140127     C                   EXSR      $STATE
100000140127     C                   EVAL      D_STATE = %TRIM(@50)
100100140127    ***
100200140217     C                   EXSR      $HYPER
100300140217     C                   EVAL      D_CARGRP = %TRIM(@50)
100400140217    ***
100500140127     C                   EXSR      $REGION
100600140127     C                   EVAL      D_REGNDES = %TRIM(@50)
100700140127    ***
100800140127     C                   ENDSR
100900151106      *-------------------------------------------------------------------
101000140127     C     $MNTSCR       BEGSR
101100140127    ***
101200140127     C                   EVAL      *IN40 = *ON
101300140127     C                   EXSR      $FMTSCR
101400140127    ***
101500140127     C                   DOU       FKEY = F12
101600140127    ***
101700140127     C                   EVAL      EMSG = @EMSG
101800140127     C                   EXFMT     SCREEN
101900140127     C                   EVAL      EMSG = *BLANKS
102000140127     C                   EVAL      @EMSG = *BLANKS
102100140127    ***
102200140127     C                   IF        FKEY = F12
102300140127     C                   EVAL      *IN50 = *OFF
102400140722     C                   EVAL      *IN51 = *OFF
102500140127     C                   ITER
102600140127     C                   ENDIF
102700140127    ***
102800140722     C                   IF        FKEY = F4 AND *IN50 = *OFF AND *IN51 = *OFF
102900140217     C                   EXSR      $F4C
103000140127     C                   ITER
103100140127     C                   ENDIF
103200140127    ***
103300140722     C                   SELECT
103400140722     C                   WHEN      *IN50 = *OFF AND *IN51 = *OFF
103500140127     C                   EXSR      $EDIT
103600140722     C                   WHEN      *IN50 = *OFF AND *IN51 = *ON
103700140722     C                   EXSR      $EDIT2
103800140722     C                   WHEN      *IN50 = *ON
103900140127     C                   EXSR      $UPDATE
104000140722     C                   ENDSL
104100140127    ***
104200140127     C                   ENDDO
104300140127    ***
104400140127     C                   ENDSR
104500151106      *-------------------------------------------------------------------
104600151106br01 C     $DLTSCR       BEGSR
104700151106     C
104800151106     C                   EXSR      $FMTSCR
104900151106     C
105000151106     C                   DOU       FKEY = F12
105100151106     C                   Exfmt     DLTRCD
105200151106     C
105300151106     C                   IF        FKEY = F12
105400151106     C                   leave
105500151106     C                   ENDIF
105600151106     C
105700151106     C*?Delete Record...
105800151106     C                   if        FKey = ENTER
105900151106     C
106000151106     C
106100151106     C
106200151106     C
106300151106     C*?Write to History File...
106400151106     C
106500151106     C     KL#ACAR       CHAIN     ACARGRF
106600151106     C                   IF        %FOUND(ACARGRP)
106700160218     C
106800160218     C*?Write to F.Hist
106900160218     C                   eval      hkey = parm10
107000160218     C                   eval      trCode = 'LRD'
107100160218     C                   eval      ck#Not = agcargrp + '-' +
107200160218     C                                      %Char(agrnwlfr) + '-' +
107300160218     C                                      %Char(agrnwlto)
107400160218     C                   eval      note2 = agRatrgn + ' - ' + agState
107500160218     C                   eval      hPrgnm = 'FM520R'
107600160218     C                   eval      trDate = %Dec(%Date)
107700160218     C                   eval      hsTrst = t
107800160218     C                   eval      hsSub# = s
107900160218     C                   eval      hsAcct = a
108000160218     C                   eval      hsDltD = 'A'
108100160218     C                   eval      hsTrTime = %Time
108200160218     C                   eval      covtDt = ck#to
108300160218     C                   eval      hOper = @Tsuser
108400160218     C                   write     histr
108500160218     C
108600160218     C
108700160218     C
108800160218     C
108900160218     C
109000151106     C                   delete    ACARGRF
109100151106     C                   eval      @EMSG = 'Record Deleted'
109200151106     C
109300151106     C                   LEAVESR
109400151106     C                   ENDIF
109500151106     C
109600151106     C                   endif
109700151106     C
109800151106     C                   ENDDO
109900151106     C
110000151106     C                   ENDSR
110100151106      *-------------------------------------------------------------------
110200140217     C     $F4C          BEGSR
110300140127    ***
110400140217     C                   EVAL      @8FLD = %SUBST(SCFLD:3:8)
110500140217    ***
110600140217     C                   EXSR      $F4COMN
110700140217    ***
110800140217     C                   SELECT
110900140217    *** **
111000140217     C                   WHEN      SCFLD = 'SCREGN' OR SCFLD = 'SCSTATE'
111100140217     C                   IF        @39 = *BLANKS
111200140217     C                   LEAVESR
111300140217     C                   ENDIF
111400140217     C                   EVAL      SCSTATE = %SUBST(@39:1:2)
111500140217     C                   EVAL      SCREGN = %SUBST(@39:3:7)
111600140127     C                   EVAL      KF@STATE = SCSTATE
111700140127     C                   EVAL      KF@REGN = SCREGN
111800140127     C                   EXSR      $STATE
111900140127     C                   EVAL      D_STATE = %TRIM(@50)
112000140127     C                   EXSR      $REGION
112100140127     C                   EVAL      D_REGNDES = %TRIM(@50)
112200140217    *** **
112300140217     C                   WHEN      SCFLD = 'SCCARGRP'
112400140217     C                   IF        @33 = *BLANKS
112500140217     C                   LEAVESR
112600140217     C                   ENDIF
112700140217     C                   EVAL      SCCARGRP = %SUBST(@33:1:2)
112800140220     C                   EVAL      KF@CGR = %SUBST(@33:1:2)
112900140217     C                   EXSR      $HYPER
113000140217     C                   EVAL      D_CARGRP = %TRIM(@50)
113100140217    *** **
113200140217     C                   ENDSL
113300140127    ***
113400140127     C                   ENDSR
113500140217   S***S
113600140127     C     $EDIT         BEGSR
113700140127    ***
113800140716     C     SCRNWLFR      MULT      10000.0001    CK#FR             8 0
113900140716     C     SCRNWLTO      MULT      10000.0001    CK#TO             8 0
114000140716    ***
114100140127     C                   IF        FKEY = F12 OR
114200140220     C                             (SCCARGRP = AGCARGRP AND
114300140716     C                              CK#FR = AGRNWLFR AND CK#TO = AGRNWLTO AND
114400140220     C                              SCSTATE = AGSTATE AND SCREGN = AGRATRGN)
114500140127     C                   LEAVESR
114600140127     C                   ENDIF
114700140127    ***
114800140127     C                   EVAL      KF@STATE = SCSTATE
114900140127    ***
115000140127     C                   EXSR      $STATE
115100140127     C                   EVAL      D_STATE = %TRIM(@50)
115200140127     C                   IF        @50 = '*UNKNOWN*'
115300140127     C                   EVAL      @EMSG = 'INVALID STATE CODE'
115400140127     C                   LEAVESR
115500140127     C                   ENDIF
115600140127    ***
115700140220     C                   EVAL      KF@TYPE = 'RATE STATE'
115800140220     C                   EVAL      KF@CODE = KF@STATE
115900140220     C     KL#C20        CHAIN     CODE20F
116000140220     C                   IF        NOT %FOUND(CODE20P)
116100140220     C                   EVAL      @EMSG = 'RATE STATE NOT SET UP, CONTACT I.S.'
116200140220     C                   LEAVESR
116300140220     C                   ENDIF
116400140220    ***
116500140220     C                   IF        C20ACTN1 = 'VALUE' AND
116600140220     C                             SCREGN = *BLANKS
116700140220     C                   EVAL      SCREGN = C20ACTN2
116800140220     C                   ENDIF
116900140220    ***
117000140220     C                   EVAL      KF@REGN = SCREGN
117100140220    ***
117200140127     C                   EXSR      $REGION
117300140127     C                   EVAL      D_REGNDES = %TRIM(@50)
117400140127     C                   IF        @50 = '*UNKNOWN*'
117500140127     C                   EVAL      @EMSG = 'INVALID STATE/REGION COMBINATION'
117600140127     C                   LEAVESR
117700140127     C                   ENDIF
117800140127    ***
117900140220     C                   IF        C20ACTN1 = 'VALUE' AND
118000140220     C                             C20ACTN2 <> KF@REGN
118100140220     C                   EVAL      @EMSG = 'INVALID REGION FOR STATE'
118200140220     C                   LEAVESR
118300140220     C                   ENDIF
118400140220    ***
118500140220     C                   EVAL      KF@CGR = SCCARGRP
118600140220     C                   EXSR      $HYPER
118700140220     C                   EVAL      D_CARGRP = %TRIM(@50)
118800140220     C                   IF        @50 = '*UNKNOWN*'
118900140220     C                   EVAL      @EMSG = 'INVALID CARRIER GROUPER'
119000140220     C                   LEAVESR
119100140220     C                   ENDIF
119200140220    ***
119300140220     C                   EVAL      KF@TYPE = 'RATE CARR'
119400140220     C                   EVAL      KF@CODE = KF@CGR
119500140220     C     KL#C20        CHAIN     CODE20F
119600140220     C                   IF        NOT %FOUND(CODE20P)
119700140220     C                   EVAL      @EMSG = 'CARRIER GROUPER NOT SET UP, CONTA' +
119800140220     C                             'CT I.S. IF IT SHOULD BE'
119900140220     C                   LEAVESR
120000140220     C                   ENDIF
120100140220    ***
120200140220    *** VALID FROM DATE OF COURSE
120300140220    ***
120400140220     C     *USA          TEST(DE)                SCRNWLFR
120500140220     C                   IF        %ERROR
120600140220     C                   EVAL      @EMSG = 'INVALID FROM DATE'
120700140220     C                   LEAVESR
120800140220     C                   ENDIF
120900140220     C     SCRNWLFR      MULT      10000.0001    KF@FR
121000140220    ***
121100140220    *** 12 MONTHS FROM THE FROM DATE
121200140220    ***
121300140220     C                   MOVE      KF@FR         #ISO
121400140220     C                   ADDDUR    1:*Y          #ISO
121500140220     C                   SUBDUR    1:*D          #ISO
121600140220     C                   MOVE      #ISO          TO#LIMIT
121700140220    ***
121800140220    *** IF TO DATE IS ZERO, WE CALCULATE FOR YOU.
121900140220    ***
122000140220     C                   IF        SCRNWLTO = 0
122100140220     C                   EVAL      KF@TO = TO#LIMIT
122200140224     C     KF@TO         MULT      10000.0001    SCRNWLTO
122300140220     C                   ELSE
122400140220     C     *USA          TEST(DE)                SCRNWLTO
122500140220     C                   IF        %ERROR
122600140220     C                   EVAL      @EMSG = 'INVALID TO DATE'
122700140220     C                   LEAVESR
122800140220     C                   ENDIF
122900140220     C     SCRNWLTO      MULT      10000.0001    KF@TO
123000140220     C                   ENDIF
123100140220    ***
123200140220    *** NO SPANS BEYOND 12 MONTHS
123300140220    ***
123400140220     C                   IF        KF@TO > TO#LIMIT
123500140224     C                   EVAL      @EMSG = '**WARNING**YEAR LIMIT EXCEEDED'
123600140220     C                   ENDIF
123700140220    ***
123800140220    *** NO EXACT DUPES
123900140220    ***
124000140220     C     KL#ACAR       CHAIN     ACARGRF
124100140224     C                   IF        %FOUND(ACARGRP) AND
124200140220     C                              SCCARGRP = AGCARGRP AND
124300140220     C                              SCSTATE = AGSTATE AND SCREGN = AGRATRGN
124400140220     C                   EVAL      @EMSG = 'RECORD ALREADY EXISTS'
124500140220     C                   LEAVESR
124600140220     C                   ENDIF
124700140220    ***
124800140220    *** NO SAME DAY TERMS
124900140220    ***
125000140220     C                   IF        KF@TO = KF@FR
125100140220     C                   EVAL      @EMSG = 'YOU CANNOT SAME DAY TERM'
125200140220     C                   LEAVESR
125300140220     C                   ENDIF
125400140220    ***
125500140402     C                   IF        SCCNTY <> *BLANKS
125600140402     C                   EVAL      KF@CNTY = SCCNTY
125700140402     C                   EXSR      $COUNTY
125800140402     C                   EVAL      D_CNTY = CDESCR
125900140402     C                   ENDIF
126000140402    ***
126100140220    *** WELL, SEEMS TO BE A VALID CHANGE
126200140220    ***
126300140127     C                   EVAL      *IN50 = *ON
126400140127     C                   EVAL      @EMSG = 'ENTER TO CONFIRM; F12 TO RESET'
126500140127    ***
126600140127     C                   ENDSR
126700140127   S***S
126800140722     C     $EDIT2        BEGSR
126900140722    ***
127000140722     C     SCRNWLFR      MULT      10000.0001    CK#FR             8 0
127100140722     C     SCRNWLTO      MULT      10000.0001    CK#TO             8 0
127200140722    ***
127300140722     C                   IF        FKEY = F12 OR
127400140722     C                             (SCCARGRP = AGCARGRP AND
127500140722     C                              CK#FR = AGRNWLFR AND CK#TO = AGRNWLTO AND
127600140722     C                              SCSTATE = AGSTATE AND SCREGN = AGRATRGN)
127700140722     C                   LEAVESR
127800140722     C                   ENDIF
127900140722    ***
128000140722     C                   EVAL      KF@STATE = SCSTATE
128100140722     C                   EVAL      KF@REGN = SCREGN
128200140722     C                   EVAL      KF@CGR = SCCARGRP
128300140722    ***
128400140722     C     SCRNWLFR      MULT      10000.0001    KF@FR
128500140722    ***
128600140722    *** 12 MONTHS FROM THE FROM DATE
128700140722    ***
128800140722     C                   MOVE      KF@FR         #ISO
128900140722     C                   ADDDUR    1:*Y          #ISO
129000140722     C                   SUBDUR    1:*D          #ISO
129100140722     C                   MOVE      #ISO          TO#LIMIT
129200140722    ***
129300140722    *** IF TO DATE IS ZERO, WE CALCULATE FOR YOU.
129400140722    ***
129500140722     C                   IF        SCRNWLTO = 0
129600140722     C                   EVAL      KF@TO = TO#LIMIT
129700140722     C     KF@TO         MULT      10000.0001    SCRNWLTO
129800140722     C                   ELSE
129900140722     C     *USA          TEST(DE)                SCRNWLTO
130000140722     C                   IF        %ERROR
130100140722     C                   EVAL      @EMSG = 'INVALID TO DATE'
130200140722     C                   LEAVESR
130300140722     C                   ENDIF
130400140722     C     SCRNWLTO      MULT      10000.0001    KF@TO
130500140722     C                   ENDIF
130600140722    ***
130700140722     C                   IF        ACVTDT > 0
130800140722     C                   MOVEL     ACVTDT        ACV@YM            6
130900140722     C                   MOVEL     KF@FR         RGF@YM            6
131000140722     C                   MOVEL     KF@TO         RGT@YM            6
131100140722     C                   IF        RGT@YM <= ACV@YM
131200140722       @EMSG = 'CANNOT BACK DATE INTO AN INVOICED PERIOD';
131300140722     C                   LEAVESR
131400140722     C                   ENDIF
131500140722     C                   ENDIF
131600140722    ***
131700140722    *** NO SPANS BEYOND 12 MONTHS
131800140722    ***
131900140722     C                   IF        KF@TO > TO#LIMIT
132000140722     C                   EVAL      @EMSG = '**WARNING**YEAR LIMIT EXCEEDED'
132100140722     C                   ENDIF
132200140722    ***
132300140722    *** NO EXACT DUPES
132400140722    ***
132500140722     C     KL#ACAR       CHAIN     ACARGRF
132600140722     C                   IF        %FOUND(ACARGRP)
132700140722     C                   EVAL      @EMSG = 'RECORD ALREADY EXISTS'
132800140722     C                   LEAVESR
132900140722     C                   ENDIF
133000140722    ***
133100140722    *** NO SAME DAY TERMS
133200140722    ***
133300140722     C                   IF        KF@TO = KF@FR
133400140722     C                   EVAL      @EMSG = 'YOU CANNOT SAME DAY TERM'
133500140722     C                   LEAVESR
133600140722     C                   ENDIF
133700140722    ***
133800140722     C                   EVAL      KF@CNTY = SCCNTY
133900140722    ***
134000140722    *** WELL, SEEMS TO BE A VALID CHANGE
134100140722    ***
134200140722     C                   EVAL      *IN50 = *ON
134300140722     C                   EVAL      @EMSG = 'ENTER TO CONFIRM; F12 TO RESET'
134400140722    ***
134500140722     C                   ENDSR
134600140722   S***S
134700140127     C     $UPDATE       BEGSR
134800140127    ***
134900140127     C                   IF        FKEY = F12
135000140127     C                   EVAL      *IN50 = *OFF
135100140127     C                   EXSR      $FMTSCR
135200140127     C                   EVAL      FKEY = F1
135300140127     C                   LEAVESR
135400140127     C                   ENDIF
135500140127    ***
135600140127     C                   EVAL      KF@TRS = AGTRST
135700140127     C                   EVAL      KF@SUB = AGSUB#
135800140127     C                   EVAL      KF@ACC = AGACCT
135900140127     C                   EVAL      KF@PDT = AGPDT
136000140220     C                   EVAL      KF@FR = AGRNWLFR
136100140220     C                   EVAL      KF@TO = AGRNWLTO
136200140127    ***
136300140127     C     KL#ACAR       CHAIN     ACARGRF
136400140224     C                   IF        NOT %FOUND(ACARGRP)
136500140127     C                   EVAL      @EMSG = 'FAILED TO FIND ACCT REGION'
136600140127     C                   LEAVESR
136700140127     C                   ENDIF
136800140127    ***
136900140127     C                   MOVEL(P)  SCPDT         @7PDT             7
137000140402     C                   EVAL      ORIGCNTY = AGCNTY
137100140127     C                   EVAL      ORIGSTATE = AGSTATE
137200140127     C                   EVAL      ORIGREGN = AGRATRGN
137300140127     C                   EVAL      ORIGFROM = %EDITC(AGRNWLFR:'X')
137400140127     C                   EVAL      ORIGTO = %EDITC(AGRNWLTO:'X')
137500140127    ***
137600140402     C                   EVAL      AGCNTY = SCCNTY
137700140127     C                   EVAL      AGRATRGN = SCREGN
137800140127     C                   EVAL      AGSTATE = SCSTATE
137900140716     C     SCRNWLFR      MULT      10000.0001    CK#FR
138000140716     C                   EVAL      AGRNWLFR = CK#FR
138100140716     C     SCRNWLTO      MULT      10000.0001    CK#TO
138200140716     C                   EVAL      AGRNWLTO = CK#TO
138300140127     C                   UPDATE    ACARGRF
138400140127     C                   EVAL      @EMSG = 'ACCT REGION UPDATED'
138500140127     C                   EXSR      $HIST
138600140127    ***
138700140127     C                   EVAL      EMSG = @EMSG
138800140127     C                   EXFMT     SCREEN
138900140127     C                   EVAL      EMSG = *BLANKS
139000140127     C                   EVAL      @EMSG = *BLANKS
139100140127     C                   EVAL      FKEY = F12
139200140127     C                   EVAL      *IN50 = *OFF
139300140127    ***
139400140127     C                   ENDSR
139500140127   S***S
139600140127     C     $HIST         BEGSR
139700140127    ***
139800140127     C                   CLEAR                   HISTR
139900140127    ***
140000140220     C                   EVAL      HKEY = PARM10
140100140127     C                   EVAL      TRCODE = 'LRG'
140200140127    ***
140300140220     C                   EVAL      CK#NOT = ORIGSTATE + ' ' + ORIGREGN + ' '
140400140220     C                             + AGCARGRP
140500140402     C                   EVAL      NOTE2 = SCSTATE + ' ' + SCREGN + ' '
140600140402     C                             + SCCARGRP
140700140127    ***
140800140127     C                   EVAL      HPRGNM = 'FM520R'
140900140127     C                   MOVE      #TSCYMD       TRDATE
141000140220     C                   MOVE      T             HSTRST
141100140220     C                   MOVE      S             HSSUB#
141200140220     C                   MOVE      A             HSACCT
141300140127     C                   EVAL      HSDLTD = 'A'
141400140127     C                   EVAL      HSTRTIME = %TIME
141500160201     C                   MOVE      ck#to         COVTDT
141600140127     C                   EVAL      HOPER = @TSUSER
141700140127    ***
141800140127     C                   WRITE     HISTR
141900140127    ***
142000140127     C                   CLEAR                   @TIMESTAMP
142100140127     C                   MOVE      *BLANKS       @TS40
142200140127     C                   CALL      'TIMESTMP'
142300140127     C                   PARM                    @TS40
142400140127     C                   MOVEL     @TS40         @TIMESTAMP
142500140127    ***
142600140127     C                   CLEAR                   RDIARYHD
142700140127     C                   EVAL      NHKEY = PARM10
142800140127     C                   EVAL      NHCODE = 'WRG'
142900140127     C                   EVAL      NHSUBJ = 'REGION CHG: ' + @7PDT +
143000140219     C                             ' FOR: ' + ORIGFROM + ' TO: ' +
143100140219     C                             ORIGTO
143200140127     C                   EVAL      NHADUS = @TSUSER
143300140127     C                   EVAL      NHADDT = #TSCYMD
143400140127     C                   EVAL      NHADTI = #TSTIME
143500140127     C                   WRITE     RDIARYHD
143600140127    ***
143700140127     C                   CLEAR                   RDIARYDT
143800140127     C                   EVAL      NDKEY = PARM10
143900140127     C                   EVAL      NDADDT = #TSCYMD
144000140127     C                   EVAL      NDADTI = #TSTIME
144100140127    ***
144200140127     C                   EVAL      NDSEQ# = 1
144300140716     C                   EVAL      NDTEXT = 'PRODUCT: ' + @7PDT + ' FOR RENEW' +
144400140219     C                             'AL PERIOD: ' + ORIGFROM + ' TO ' + ORIGTO +
144500140219     C                             ' CARRIER: ' + AGCARGRP
144600140127     C                   WRITE     RDIARYDT
144700140127    ***
144800140127     C                   EVAL      NDSEQ# = 2
144900140127     C                   EVAL      NDTEXT = 'CHANGED FROM STATE: ' +
145000140127     C                             ORIGSTATE + ' AND REGION: ' +
145100140127     C                             ORIGREGN
145200140127     C                   WRITE     RDIARYDT
145300140127    ***
145400140127     C                   EVAL      NDSEQ# = 3
145500140127     C                   EVAL      NDTEXT = 'CHANGED TO STATE: ' + SCSTATE +
145600140127     C                             ' AND REGION: ' + SCREGN + ' LAST INVOICE' +
145700140127     C                             ' DATE: ' + %EDITC(ACVTDT:'X')
145800140127     C                   WRITE     RDIARYDT
145900140127    ***
146000140402     C                   EVAL      NDSEQ# = 4
146100140402     C                   EVAL      NDTEXT = 'CHANGED FROM COUNTY: ' +
146200140402     C                             ORIGCNTY + ' TO COUNTY: ' +
146300140402     C                             SCCNTY
146400140402     C                   WRITE     RDIARYDT
146500140402    ***
146600140716     C                   MOVE      CK#FR         @8F               8
146700140716     C                   MOVE      CK#TO         @8T               8
146800140716     C                   IF        @8F <> ORIGFROM OR @8T <> ORIGTO
146900140716     C                   EVAL      NDSEQ# = 5
147000140716     C                   EVAL      NDTEXT = 'CHANGED TO PERIOD FROM: ' +
147100140716     C                             @8F + ' TO: ' + @8T
147200140716     C                   WRITE     RDIARYDT
147300140716     C                   ENDIF
147400140716    ***
147500140127     C                   ENDSR
147600140127   S***S
147700140127     C     *INZSR        BEGSR
147800140127    ***
147900140127     C     *ENTRY        PLIST
148000140127     C                   PARM                    @10              10
148100140127    ***
148200140127     C                   EVAL      PARM10 = @10
148300140722       ALLOW_MNT = NO;
148400140127    ***
148500140127     C                   CLEAR                   @TIMESTAMP
148600140127     C                   MOVE      *BLANKS       @TS40
148700140127    ***
148800140127     C                   CALL      'TIMESTMP'
148900140127     C                   PARM                    @TS40
149000140127    ***
149100140127     C                   MOVEL     @TS40         @TIMESTAMP
149200140127    ***
149300140626       IF @TSUSER = 'GBSTEST' OR @TSUSER = 'CINDY' OR @TSUSER = 'CANDACEF' OR
149400150909          @TSUSER = 'DAVEA' OR  @TSUSER = 'BRANDONS' OR @TSUSER = 'BREES' OR
149500180823          @TSUSER = 'SHELLY' OR @TSUSER = 'STREUSDELL' OR @TSUSER = 'DLK' or
149600180823          @TSUSER = 'RONM';
149700180823
149800140722          ALLOW_MNT = YES;
149900140626       ENDIF;
150000140626    ***
150100140127     C     KL#SC         KLIST
150200140127     C                   KFLD                    KF@STATE
150300140127     C                   KFLD                    KF@CNTY
150400140127    ***
150500140220     C     KL#C20        KLIST
150600140220     C                   KFLD                    KF@TYPE
150700140220     C                   KFLD                    KF@CODE
150800140220    ***
150900140127     C     KL#TSA        KLIST
151000140127     C                   KFLD                    KF@TRS
151100140127     C                   KFLD                    KF@SUB
151200140127     C                   KFLD                    KF@ACC
151300140127    ***
151400140127     C     KL#SR         KLIST
151500140127     C                   KFLD                    KF@STATE
151600140127     C                   KFLD                    KF@REGN
151700140218    ***
151800140218     C     KL#APG        KLIST
151900140218     C                   KFLD                    KF@TRS
152000140218     C                   KFLD                    KF@SUB
152100140218     C                   KFLD                    KF@ACC
152200140218     C                   KFLD                    KF@PDT
152300140218     C                   KFLD                    KF@CGR
152400140127    ***
152500140127     C     KL#ACAR       KLIST
152600140127     C                   KFLD                    KF@TRS
152700140127     C                   KFLD                    KF@SUB
152800140127     C                   KFLD                    KF@ACC
152900140218     C                   KFLD                    KF@PDT
153000140218     C                   KFLD                    KF@CGR
153100140218     C                   KFLD                    KF@FR
153200140218     C                   KFLD                    KF@TO
153300140127    ***
153400140127     C                   ENDSR
153500140127   S***S
