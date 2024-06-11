000100140401    X***X  RENAME NVA2EXR TO NVA020R
000200140401    X***X                                                              *
000300140401    X***X Description:  NVA2EXR    Export NVA Members/Dependents        *
000400140401    X***X                                                              *
000500140401    X***X (c)Copyright 2010 by GBS, Inc.                                *
000600140401    X***X This document contains restricted materials of GBS,Inc.       *
000700140401    X***X                                                              *
000800140401    X***X Written by:    S. Zien                                        *
000900140401    X***X Date Written:  12/30/10                                       *
001000140401    X***X                                                              *
001100140401    X***X History:                                                      *
001200140401    X***X          Revised by - szz                                    *
001300140401    X***X          Date -       5.4.11                                 *
001400140401    X***X          Revision -   Use actual group# so that groups can   *
001500140401    X***X                        ultimately be separated into separate *
001600140401    X***X                        files at Gary Calaman (NVA)'s request.*
001700140401    X***X                                                              *
001800140401    X***X          Revised by - szz                                    *
001900140401    X***X          Date -       12.22.11                               *
002000140401    X***X          Revision -   Even though Gary Calaman (NVA) said    *
002100140401    X***X                        these groups were non-association, it *
002200140401    X***X                        appears that they are set up as 'NVA' *
002300111222    ? *                          and not 'NV1' so I they will be put   *
002400111222    ? *                          into NVA2EXR, the association program.*
002500110504    ? *                                                                *
002600120307    ? *            Revised by - szz                                    *
002700120307    ? *            Date -       3.7.12                                 *
002800120307    ? *            Revision -   Send email alert if new group.         *
002900131206    ? *________________________________________________________________*
003000131206   X***X
003100131206   X***X 12/06/2013 SSK SHUT OFF PENNEX, TO BE COMPILED ON 12/17/2013
003200131209   X***X 12/09/2013 SSK MOSAIC CLIENT FILE
003300131227   X***X 12/27/2013 SSK PRECISION CUSTOM COMPONENTS
003400131206   X***X
003500140226   X***X 02/26/2014 SSK CHANGE PER GARY CALAMAN & CAROL FAB TO SUBTRACT ONE DAY FROM TERM DATE
003600131206   X***X
003700140312   X***X 03/12/2014 SSK UNITED SOURCE ONE OVERRIDE
003800140403   X***X
003900140403   X***X 04/03/2014 SSK ADD EAST COAST FREIGHT WAYS
004000131206   X***X
004100140514   X***X 05/14/2014 SSK CHANGE PER GARY CALAMAN, 51345 IS NOW 41230
004200140514   X***X                NEW GROUP & FILE, 86310 CHESAPEAKE OPEN MRI, LLC
004300140514   X***X
004400140714   X***X 07/14/2014 SSK MANUFACT ASSOC OF SOUTH CENT PA CHANGE
004500140514   X***X
004600140718   X***X 07/18/2014 SSK ADD DRB ENTERPRISES
004700140724   X***X 07/24/2014 SSK SWITCH TO NVACONTROL
004800140514   X***X
004900141020   X***X 10/20/2014 SSK ADD FASCAN
005000141028   X***X
005100141028   X***X 10/28/2014 SSK TWEAK SOME CODE TO BE CLEANER
005200141020   X***X
005300140514   X***X
005400090728     FPLNMSTN1  IF   E           K Disk
005500090729     FMCOV39    IF   E           K Disk
005600090728     FMEMBER    IF   E           K Disk
005700090804     FDCOV22    IF   E           K Disk
005800090804     FDEPNDC    IF   E           K Disk
005900090831     FGRAT24    IF   E           K Disk
006000130930     FACMUNIQUE IF   E           K Disk
006100101230     FNVA2TRMP  UF A E           K Disk
006200101230    ?FNVA2EXP   UF A E           K Disk
006300140724     FNVACONTROLIF   E           K Disk
006400021004      *
006500140714     D @@G           E DS                  Extname(GRATE) Inz
006600101220     D MemDep        E DS                  Extname(NVA1M) Inz
006700101220     D MemDem        E DS                  Extname(NVA1D) Inz
006800101220     D MemCov        E DS                  Extname(NVA1C) Inz
006900021004      *
007000061218     D DSRecord        DS
007100061218     D DSRec                   1    236A
007200061218     D  DSRecTyp               1      1A
007300061221     D  DSRecData              2    236A
007400140226    ***
007500140226     D IN#EFF          S              8S 0 INZ
007600140226     D IN#TRM          S              8S 0 INZ
007700140226     D WRK#TRM         S              8A   INZ
007800140226     D WRK#ISO         S               D   DATFMT(*ISO)
007900140226     D OUT#TRM         S              8S 0 INZ
008000140226    ***
008100101223     D Pos             S              2  0
008200101230     D NVA             S              3A   Inz('NVA')
008300061120     D Cobra           S              1    Inz('C')
008400061221     D Active          S              1    Inz('A')
008500021004     D HighDate        S              8S 0 INZ(99999999)
008600090804     D TrmDate         S                   like(CANDT)
008700090303    ?D CalcDate        S               D   datfmt(*ISO)                         Input Request
008800090303    ?D ThirtyDays      S               D   datfmt(*ISO)                         Input Request
008900090303    ?D TodayPlus30     S               D   datfmt(*ISO)                         Input Request
009000090805     D Seq#            S              2S 0 Inz(*Zero)
009100021004      *
009200101230     C     NVA           Setll     PLNMSTN1
009300101230     C     NVA           Reade     PLNMSTN1
009400101220      *
009500101230    ?C                   Dow       Not %Eof(PLNMSTN1)
009600101220     C                   Exsr      Process
009700101230     C     NVA           Reade     PLNMSTN1
009800101220     c                   EndDo
009900100323      *
010000100323    ?C                   Move      *On           *InLR
010100021004    ? *________________________________________________________________
010200051129    ?C     Process       Begsr
010300070110      *
010400110113     C                   If        PLNCAT    =   'PVS' Or
010500110113     C                             PLNCAT    =   'PVR'
010600101221     C     CovKey        Setll     MCOV39
010700101221     C                   Dou       %Eof(MCOV39)
010800101221     C     CovKey        Reade     MCOV39
010900101221     C                   If        Not %Eof(MCOV39)
011000131206    ***
011100131216    *** SHUTOFF PENNEX; NOW SELF FUNDED
011200131216    ***
011300131216     C                   IF        MCTRST = 598 AND MCSUB# = 1 AND ACC# = 1
011400131216     C                   ITER
011500131216     C                   ENDIF
011600131206    ***
011700101221      *
011800101221      * Find out if termed coverage has already been sent as termed once.
011900101221      *
012000101221     C                   Exsr      DetermTerm
012100101221     C                   If        TermSw    =   'N'
012200101221     C                   If        CANDT     <>  ENRLDT
012300101221     C     MCSSNO        Chain     Member
012400101221     C                   Exsr      Process2
012500101221     C                   End
012600101221     C                   End
012700101221      *
012800101221     C                   End
012900101221     C                   EndDo
013000101222     C                   End
013100101221    ?C                   Endsr
013200101221    ? *________________________________________________________________
013300101221    ?C     Process2      Begsr
013400101221      *
013500101221      * If member is Cobra, use the current effective date.
013600090804      *
013700090804     C                   If        EMPST      =  Cobra
013800090804     C                   Eval      BeginDateN =  ENRLDT
013900090804     C                   Eval      EndDateN   =  CANDT
014000090804     C                   Else
014100090804     C                   Movel     MCTRST        Trust
014200090804     C                   Movel     MCSUB#        Sub
014300090804     C                   Movel     MCPLAN        Plan
014400090804     C                   Movel     MCSSNO        Social
014500090804     C                   Eval      BeginDate  =  '00000000'
014600090804     C                   Eval      EndDate    =  '00000000'
014700090804     C                   Call      'ECOVDT1R'
014800090804     C                   Parm                    Trust             3
014900090804     C                   Parm                    Sub               3
015000090804     C                   Parm                    Plan              4
015100090804     C                   Parm                    Social            9
015200090804     C                   Parm                    BeginDate         8
015300090804     C                   Parm                    EndDate           8
015400090804     C                   Parm                    Err               8
015500021004    ? *
015600090805     C                   Movel     BeginDate     BeginDateN        8 0
015700090805     C                   Movel     EndDate       EndDateN          8 0
015800090804     C                   End
015900100607     C
016000051129     C                   Exsr      BuildRecord
016100141028     C                   EXSR      $MBRGRP
016200141028     C                   Exsr      MemDemSr
016300141028     C                   Exsr      MemCovSr
016400051129    ?C                   Endsr
016500021004    ? *________________________________________________________________
016600101223    ? * Build Subscriber Record
016700021004    ? *________________________________________________________________
016800021004    ?C     BuildRecord   Begsr
016900110104     C                   Clear                   MNMEXT
017000101221     C                   Movel     MBSSNO        MPMEMID
017100101223     C                   Movel     MBSSNO        DPMEMID
017200101223     C                   Movel     MBSSNO        CPMEMID
017300101221     C                   Move      *Blanks       MDEPSS#
017400101222     C                   Eval      MLAST    =    %Trim(MLNAME)
017500101222     C                   Eval      MFIRST   =    %Trim(MFNAME)
017600101221     C                   Eval      MMINIT   =    MMI
017700101221     C                   Eval      MSEX     =    SEX
017800101223     C                   Eval      MRELCD   =    '1'
017900101223     C                   Eval      MPREECD  =    'N'
018000101223     C                   Eval      MOTHCOV  =    COB
018100101223     C                   Movel     BIRTH         MBIRDT
018200090804     C     EndDateN      Ifeq      *Zeros
018300101221     C                   Movel     '00000000'    MCTEDT
018400021017     C                   Else
018500101223     C                   Movel     EndDateN      MCTEDT
018600021017     C                   End
018700090303      *---
018800101230      * If future term date > 30, fill w/zeros
018900090303      *---
019000090804     C                   If        BeginDateN <= Today    AND
019100090804     C                             EndDateN >=   Today    AND
019200090804     C                             EndDateN <>   *Zeros
019300090303      * Find the date 30 days before the term date.
019400090804     C     *ISO          Move      EndDateN      CalcDate
019500090303     C     CalcDate      Subdur    30:*d         ThirtyDays
019600090730     C                   Move      ThirtyDays    Candt30           8 0
019700090303      * Find the date 30 days into the future from today
019800090303     C     *ISO          Move      Today         CalcDate
019900090424     C     CalcDate      Adddur    30:*d         TodayPlus30
020000090303     C                   Move      TodayPlus30   Today30           8 0
020100090303     C                   Else
020200090730     C                   Z-add     *Zeros        Candt30
020300090303     C                   End
020400090730     C                   If        Candt30    >= Today    AND
020500090730     C                             Candt30    <= Today30
020600091102     C                                                    OR
020700091102     C                             EndDateN   <  Today
020800101223     C                   Movel     EndDateN      MCTEDT
020900090424     C                   Else
021000101221     C                   Movel     '00000000'    MCTEDT
021100090303     C                   End
021200090303      *---
021300090303      * End determining if term date is > 30 days from now.
021400090303      *---
021500101223     C     BeginDateN    Ifeq      *Zeros
021600101221     C                   Movel     '00000000'    MCEFDT
021700101223     C                   Else
021800101223     C                   Movel     BeginDateN    MCEFDT
021900021017     C                   End
022000101221     C                   Eval      DADDR1X  =    ADDR1
022100101221     C                   Eval      DADDR2X  =    ADDR2
022200101221     C                   Eval      DCITYX   =    CITY
022300101221     C                   Eval      DSTATEX  =    STATE
022400101223     C                   Movel     ZIP           Z5                5
022500101223     C                   Move      ZIP           Z4                4
022600101223     C                   Eval      DZIPX     =   %Trim(Z5 + '-' + Z4)
022700101221     C                   Movel     *Blanks       DPHONEX
022800101222     C                   Eval      MLANGCD   =   *Blanks
022900090827      *---
023000090827      * Get the group from the rate file
023100090827      *---
023200141028     C                   EXSR      $MBRGRP
023300141028
023400091019
023500101222     C                   Eval      MPERCD  =    %Trim('001')
023600100902      *
023700100902      * If there is an active rec for this member, don't send a term
023800101222     C                   Move      'Y'           ExportYN          1
023900141028     C*******************Eval      ExportYN =    'Y'                REDUNDANT CODE
024000100902     C                   If        CANDT    <    Today  AND CANDT <> *Zeros
024100101222     C                   Movel     MCSSNO        SSN               9
024200101222     C                   Movel     MDSEQ#        SEQNO             2
024300101222     C                   Movel     MCTRST        TRST              3
024400101222     C                   Movel     MCSUB#        SUB#              3
024500101222     C                   Movel     MCPLAN        PLAN              4
024600100902     C                   End
024700100902     C                   If        ExportYN  =   'Y'
024800101221     C                   Exsr      MemDepSr
024900100902     C                   Add       1             MemCtr            5 0
025000100607     C                   End
025100101221     C                   Clear                   NVAEXPR
025200100513      *
025300101223     C                   If        MCOVTP    =   'TIN'
025400141028     C*******************Exsr      MemDemSr          MOVED UP IN PROGRAM
025500141028     C*******************Exsr      MemCovSr
025600141028     C                   LEAVESR
025700101223     C                   End
025800141028      *
025900141028     C*******************Z-add     *Zeros        ChildCounter      2 0  SET TO START AT 2
026000141028     C                   Z-add     2             ChildCounter      2 0
026100141028      *
026200141028     C*******************If        MCOVTP     <> 'TIN'        OBSOLETE
026300090804     C     DepKey2       Setll     DCOV22
026400090804     C     DepKey2       Reade     DCOV22                                 50
026500061121      *
026600061121    ?C     *In50         Doweq     *Off
026700091104     C                   Movel     CCANDT        EndDateN
026800100113     C                   Eval      DepTermSw  =  'N'
026900091123     C                   If        EndDateN    < Today     And
027000091123     C                             EndDateN   <> *Zero
027100091104     C                   Move      EndDateN      TrmDate
027200091104     C                   Movel     DSEQ#         Seq#
027300101230     C     TrmKey        Chain     NVA2TRMP
027400101230     C                   If        %Found(NVA2TRMP)
027500091104     C                   Movel     'Y'           DepTermSw         1
027600091104     C                   Else
027700091104     C                   Exsr      TermRtn
027800091104     C                   End
027900091104     C                   End
028000091104     C                   If        DepTermSw  =  'N'
028100090804     C                   Exsr      BuildDep
028200091104     C                   End
028300090804     C     DepKey2       Reade     DCOV22                                 50
028400061121    ?C                   Enddo
028500091123sz   C                   Z-add     *Zeros        Seq#
028600141028     C*******************Exsr      MemDemSr
028700141028     C*******************Exsr      MemCovSr
028800141028     C*******************End
028900021007      *
029000021004    ?C                   Endsr
029100141028     *****
029200141028    ?C     $MBRGRP       Begsr
029300141028      *
029400141028     c     RatKey        Setll     GRAT24
029500141028     c     RatKey        Reade     GRAT24
029600141028     c                   Dow       Not %Eof(GRAT24)
029700141028
029800141028     C                   Select
029900141028
030000141028      * ignore same day terms
030100141028     C                   When      FRMDAT  =   TODAT
030200141028
030300141028      * Active
030400141028     C                   When      CANDT    =  *Zeros or
030500141028     C                             CANDT    >= Today
030600141028     C                   If        Today  <=  TODAT
030700141028     C                   Exsr      FormatGroup
030800141028     C                   Leave
030900141028     C                   End
031000141028
031100141028      * Termed
031200141028     C                   When      CANDT    <> *Zeros
031300141028     C                   If        (CANDT  >=  FRMDAT) and
031400141028     C                             (CANDT  <=  TODAT)
031500141028     C                   Exsr      FormatGroup
031600141028     C                   Leave
031700141028     C                   End
031800141028     C                   Endsl
031900141028     c     RatKey        Reade     GRAT24
032000141028     C                   EndDo
032100141028      *
032200141028    ?C                   Endsr
032300141028     *****
032400061120    ? *________________________________________________________________
032500061120    ? * Build Dependent Record
032600061120    ? *________________________________________________________________
032700061120    ?C     BuildDep      Begsr
032800101223      *
032900101223      * If member is Cobra, use the current effective date.  If not, use
033000101223      * the earliest effective date for this coverage p/D.A. 8/4/09 4:12pm.
033100101223      *
033200141028    1C                   If        EMPST      =  Cobra
033300090804     C                   Eval      BeginDateN =  DENRDT
033400090804     C                   Eval      EndDateN   =  CCANDT
033500141028    1C                   Else
033600090804     C                   Movel     MCTRST        Trust
033700090804     C                   Movel     MCSUB#        Sub
033800090804     C                   Movel     MCPLAN        Plan
033900090804     C                   Movel     MCSSNO        Social
034000090805     C                   Movel     DSEQ#         Seq
034100090804     C                   Eval      BeginDate  =  '00000000'
034200090804     C                   Eval      EndDate    =  '00000000'
034300090804     C                   Call      'ECOVDT2R'
034400090804     C                   Parm                    Trust
034500090804     C                   Parm                    Sub
034600090804     C                   Parm                    Plan
034700090804     C                   Parm                    Social
034800090805     C                   Parm                    Seq               2
034900090804     C                   Parm                    BeginDate
035000090804     C                   Parm                    EndDate
035100090804     C                   Parm                    Err
035200090804    ? *
035300090804     C                   Movel     BeginDate     BeginDateN
035400090804     C                   Movel     EndDate       EndDateN
035500141028    1C                   End
035600091104      *---
035700091104      * If same-day term, there's no begin date.  Don't send an export record.
035800091104      *---
035900141028    1C                   If        BeginDateN <> *Zeros
036000090804      *
036100090804     C     DepKey1       Chain     DEPNDC
036200141028     **
036300141028     C*******************If        DRELCD     =  'RSO'   Or
036400141028     C*******************          DRELCD     =  'RDA'   Or           CLEAN UP CODE
036500141028     C*******************          DRELCD     =  'RA'    Or
036600141028     C*******************          DRELCD     =  'RB'
036700141028     C*******************Add       1             ChildCounter
036800141028     ***The*first*child*is '003', the second is '004' and so on.
036900141028     C*******************Z-add     ChildCounter  PerCdN            3 0
037000141028     C*******************Add       2             PerCdN
037100141028     C*******************Move      PerCdN        MPERCD
037200141028     C*******************End
037300141028     C*******************If        DRELCD     =  'RHU'   Or
037400141028     C*******************          DRELCD     =  'RWI'
037500141028     C*******************Eval      MPERCD     =  '002'
037600141028     C*******************End
037700141028     **
037800141028    2C                   If        DRELCD     =  'RHU'   Or
037900141028     C                             DRELCD     =  'RWI'
038000141028     C                   Eval      MPERCD     =  '002'
038100141028    2C                   ELSE
038200141028      * The first child is '003', the second is '004' and so on.
038300141028     C                   Add       1             ChildCounter
038400141028     C                   Z-add     ChildCounter  PerCdN            3 0
038500141028     C                   Move      PerCdN        MPERCD
038600141028    2C                   End
038700141028     **
038800101223      *
038900101221     C                   Movel     MBSSNO        MPMEMID
039000101221     C                   Movel     DSSNO         MDEPSS#
039100101221     C                   Eval      MSEX     =    DSEX
039200101223     C                   Eval      MOTHCOV  =    DCOB
039300101223     C                   Movel     DBIRTH        MBIRDT
039400101221     C                   Eval      MLAST    =    DLNAME
039500101221     C                   Eval      MFIRST   =    DFNAME
039600101221     C                   Eval      MMINIT   =    DMI
039700141028    2C     EndDateN      Ifeq      *Zeros
039800101221     C                   Movel     '00000000'    MCTEDT
039900141028    2C                   Else
040000101223     C                   Movel     EndDateN      MCTEDT
040100090312      *---
040200090730      * If future term date > 30, fill w/zeros
040300090312      *---
040400141028    3C                   If        BeginDateN <= Today    AND
040500090804     C                             EndDateN   >= Today    AND
040600090804     C                             EndDateN   <> 99999999 AND
040700090804     C                             EndDateN   <> *Zeros
040800090312      * Find the date 30 days before the term date.
040900090804     C     *ISO          Move      EndDateN      CalcDate
041000090312     C     CalcDate      Subdur    30:*d         ThirtyDays
041100090312     C                   Move      ThirtyDays    dqtodate30        8 0
041200090312      * Find the date 30 days into the future from today
041300090312     C     *ISO          Move      Today         CalcDate
041400090429     C     CalcDate      Adddur    30:*d         TodayPlus30
041500090312     C                   Move      TodayPlus30   Today30           8 0
041600141028    3C                   Else
041700090312     C                   Z-add     *Zeros        dqtodate30
041800141028    3C                   End
041900141028    3C                   If        dqtodate30 <= Today30
042000101223     C                   Movel     EndDateN      MCTEDT
042100141028    3C                   Else
042200101221     C                   Movel     '00000000'    MCTEDT
042300141028    3C                   End
042400090312      *---
042500090312      * End determining if term date is > 30 days from now.
042600090312      *---
042700141028    2C                   End
042800101223     C                   Movel     BeginDateN    MCEFDT
042900101221     C                   Move      DEPSS#        MDEPSS#
043000101223     C                   Eval      MPREECD  =    'N'
043100141028    2C                   Select
043200141028    2C                   When      DHNDCP = '3'                                 Handicapped
043300101222     C                   Eval      MRELCD   =    '6'                            Disabled
043400141028    2C                   When      DSTUDN   =    'Y'                            Student
043500101222     C                   Eval      MRELCD   =    '5'                            Student
043600141028    2C                   When      DRELCD   =    'RPA'
043700141028     C                   Eval      MRELCD   =    '8'
043800141028    2C                   When      DRELCD   =    'RWI' Or                       Wife
043900101222     C                             DRELCD   =    'RHU'                          Husband
044000101222     C                   Eval      MRELCD   =    '2'                            Spouse
044100141028    2C                   When      DRELCD   =    'RDA' Or                       Daughter
044200101222     C                             DRELCD   =    'RSO'                          Son
044300101222     C                   Eval      MRELCD   =    '3'                            Child
044400141028    2C                   Other                                                  Other
044500101222     C                   Eval      MRELCD   =    '4'                            Other
044600141028    2C                   EndSl
044700090827      *---
044800090827      * Get the group from the rate file
044900090827      *---
045000090831     C     RatKey        Setll     GRAT24
045100090831     C     RatKey        Reade     GRAT24
045200141028    2C                   Dow       Not %Eof(GRAT24)
045300091019
045400141028    3C                   Select
045500091019
045600091019      * ignore same day terms
045700141028    3C                   When      FRMDAT  =   TODAT
045800091019
045900091019      * Active
046000141028    3C                   When      CCANDT   =  *Zeros or
046100091019     C                             CCANDT   >= Today
046200141028    4C                   If        Today  <=  TODAT
046300091019     C                   Exsr      FormatGroup
046400091019     C                   Leave
046500141028    4C                   End
046600091019
046700091019      * Termed
046800141028    3C                   When      CCANDT   <> *Zeros
046900141028    4C                   If        (CCANDT  >=  FRMDAT) and
047000091019     C                             (CCANDT  <=  TODAT)
047100091019     C                   Exsr      FormatGroup
047200091019     C                   Leave
047300141028    4C                   End
047400141028    3C                   Endsl
047500091019
047600090831     c     RatKey        Reade     GRAT24
047700141028    2C                   EndDo
047800101222
047900101221     C**   KLDATA        Chain     NVAEXPR
048000101221     C**                 If        Not %Found(NVAEXPR)
048100100902      *
048200100902      * If there is an active rec for this member, don't send a term
048300100902     C                   Eval      ExportYN =    'Y'
048400141028    2C                   If        CCANDT   <    Today  AND CCANDT <> *Zeros
048500100902     C                   Movel     SSNO          SSN
048600100902     C                   Movel     DSEQ#         SEQNO
048700100902     C                   Movel     DVTRST        TRST
048800100902     C                   Movel     DVSUB#        SUB#
048900100902     C                   Movel     DVPLAN        PLAN
049000141028    2C                   End
049100141028    2C                   If        ExportYN  =   'Y'
049200101221     C                   Exsr      MemDepSr
049300100902     C                   Add       1             MemCtr            5 0
049400141028    2C                   End
049500101221     C                   Clear                   NVAEXPR
049600091104      *
049700141028    1C                   End
049800091104      *
049900061120    ?C                   Endsr
050000061218    ? *________________________________________________________________
050100101220    ? * Create and write Member Dependent record first.
050200061218    ? *________________________________________________________________
050300101220    ?C     MemDepSr      Begsr
050400101222     C                   Eval      MSEGID   =    '10'
050500101221     C                   Movel     Today         MPRCDT
050600140226    ***
050700140226     C                   MOVE      MCEFDT        IN#EFF
050800140226     C                   MOVE      MCTEDT        IN#TRM
050900140226     C                   EXSR      $DTEOVRD
051000140226     C                   MOVE      OUT#TRM       MCTEDT
051100140226    ***
051200101221     C                   Eval      NVADATA  =    MemDep
051300101221     C                   Write     NVAEXPR
051400101221     C                   Clear                   NVAEXPR
051500061218     C                   EndSr
051600140226   S***S
051700140226     C     $DTEOVRD      BEGSR
051800140226    ***
051900140226     C                   EVAL      OUT#TRM = IN#TRM
052000140226    ***
052100140226     C                   IF        IN#TRM = 0 OR
052200140226     C                             IN#TRM = IN#EFF
052300140226     C                   LEAVESR
052400140226     C                   ENDIF
052500140226    ***
052600140226     C                   MOVE      IN#TRM        WRK#TRM
052700140226     C                   IF        %SUBST(WRK#TRM:7:2) <> '01'
052800140226     C                   LEAVESR
052900140226     C                   ENDIF
053000140226    ***
053100140226     C                   MOVE      IN#TRM        WRK#ISO
053200140226     C                   SUBDUR    1:*D          WRK#ISO
053300140226     C                   MOVE      WRK#ISO       OUT#TRM
053400140226    ***
053500140226     C                   ENDSR
053600140226   S***S
053700061218    ? *________________________________________________________________
053800101220    ? * Create and write Member records after the MemDep record.
053900061218    ? *________________________________________________________________
054000101221    ?C     MemDemSr      Begsr
054100101222     C                   Eval      DSEGID   =    '20'
054200101221     C                   Movel     Today         DPRCDT
054300101223     C                   Movel     MPRCTI        DPRCTI
054400101221     C                   Eval      NVADATA  =    MemDem
054500101221     C                   Write     NVAEXPR
054600101221     C                   Clear                   NVAEXPR
054700061218     C                   EndSr
054800061218    ? *________________________________________________________________
054900101220    ? * Create and write MemCov record last.
055000061218    ? *________________________________________________________________
055100101220    ?C     MemCovSr      Begsr
055200101221     C                   Eval      CSEGID   =    '30'
055300101221     C                   Movel     Today         CPRCDT
055400101223     C                   Movel     MPRCTI        CPRCTI
055500101223     C                   Movel     TERMDT        CETEDT
055600101223     C                   Movel     EMPDT         CEHIDT
055700101223     C                   Eval      CPRGRP#  =    *Blanks
055800101223     C                   Eval      CCOEFDT  =    '00000000'
055900101223     C                   Eval      CCOBRCD  =    *Blanks
056000101223     C                   Eval      CPLANID  =    *Blanks
056100101223     C                   Eval      CACTCD   =    *Blanks
056200101223     C                   Movel     ENRLDT        CPEFDT
056300101223     C                   Movel     CANDT         CPTEDT
056400101223     C                   Select
056500101223     C                   When      MCOVTP   =    'TIN'
056600101223     C                   Eval      CCOVIN   =    'S'
056700101223     C                   When      MCOVTP   =    'TFA'
056800101223     C                   Eval      CCOVIN   =    'F'
056900101223     C                   Other
057000101223     C                   Eval      CCOVIN   =    'L'
057100101223     C                   EndSl
057200140226    ***
057300140226     C                   MOVE      CPEFDT        IN#EFF
057400140226     C                   MOVE      CPTEDT        IN#TRM
057500140226     C                   EXSR      $DTEOVRD
057600140226     C                   MOVE      OUT#TRM       CPTEDT
057700140226    ***
057800101221     C                   Eval      NVADATA  =    MemCov
057900101221     C                   Write     NVAEXPR
058000101221     C                   Clear                   NVAEXPR
058100061218     C                   EndSr
058200090303    ? *________________________________________________________________
058300090303    ? * For termed coverage
058400090303    ? *________________________________________________________________
058500090303    ?C     TermRtn       Begsr
058600101230     C                   Eval      N2TRUST    =  MCTRST
058700101230     C                   Eval      N2SUB#     =  MCSUB#
058800101230     C                   Eval      N2ACCT     =  ACC#
058900101230     C                   Eval      N2PDTP     =  Today
059000101230     C                   Eval      N2PLAN     =  MCPLAN
059100101230     C                   Eval      N2COV      =  MCOVTP
059200101230     C                   Move      MCSSNO        N2SSNO
059300141028     C*******************Eval      N2SEQ#     =  MDSEQ#
059400141028     C                   Eval      N2SEQ#     =  SEQ#
059500101230     C                   Eval      N2TRDT     =  EndDateN
059600101230     C                   Write     N2TRMR
059700101230     C                   Clear                   N2TRMR
059800090303    ?C                   Endsr
059900090908    ? *________________________________________________________________
060000101220    ? * Group number field
060100090908    ? *________________________________________________________________
060200090908    ?C     FormatGroup   Begsr
060300140724    ? *
060400140724     C                   MOVE      *BLANKS       @G               15
060500140724    ? *
060600140724    ? * DEFAULTS
060700140724     C                   Eval      MPCTLID  =    'PVMS'
060800140724     C                   Eval      DPCTLID  =    'PVMS'
060900140724     C                   Eval      CPCTLID  =    'PVMS'
061000140724     C                   Eval      MSEQ     =    '00'
061100140724     C                   Eval      DSEQ     =    '00'
061200140724     C                   Eval      CSEQ     =    '00'
061300140724    ? *
061400140724     C                   EVAL      @G = %TRIM(GROUP#)
061500140724     C                   MOVEL     @G            @G5               5
061600140724    ***
061700140724     C     @G5           CHAIN     NVACTLF
061800140724     C                   IF        NOT %FOUND(NVACONTROL)
061900140724     C                   Eval      MGRP# = 'XXXXX'
062000140724     C                   Eval      DGRP# = 'XXXXX'
062100140724     C                   Eval      CGRP# = 'XXXXX'
062200140724     C                   Call      'NVANEWCL'
062300140724     C                   Parm                    Group#
062400140724     C                   LEAVESR
062500140724     C                   ENDIF
062600140724    ***
062700140724     C                   IF        NCG5 <> *BLANKS
062800140724     C                   EVAL      %SUBST(@G:1:5) = NCG5
062900140724     C                   ENDIF
063000140724    ***
063100140724     C                   IF        NCGR# <> *BLANKS
063200140724     C                   EVAL      GROUP# = NCGR#
063300140724     C                   ENDIF
063400140724    ***
063500140724     C                   Eval      MPCTLID  = NCCID
063600140724     C                   Eval      DPCTLID  = NCCID
063700140724     C                   Eval      CPCTLID  = NCCID
063800140724    ***
063900140724     C                   Eval      MGRP# = GROUP#
064000140724     C                   Eval      DGRP# = GROUP#
064100140724     C                   Eval      CGRP# = GROUP#
064200140724    ***
064300090908    ?C                   Endsr
064400090805    ? *________________________________________________________________
064500090805    ? * Determine if termed coverage has been sent once
064600090805    ? *________________________________________________________________
064700090805    ?C     DetermTerm    Begsr
064800090805    ? *
064900090805     C                   Movel     CANDT         TrmDate
065000090805     C                   Movel     'N'           TermSw            1
065100090805     C                   If        CANDT     <   Today  And
065200090805     C                             CANDT     <>  *Zero
065300101230     C     TrmKey        Chain     NVA2TRMP
065400101230     C                   If        %Found(NVA2TRMP)
065500090805     C                   Movel     'Y'           TermSw
065600090805     C                   Else
065700090805     C                   Movel     CANDT         EndDateN
065800090805     C                   Exsr      TermRtn
065900090805     C                   End
066000090805     C                   End
066100090805     C                   Clear                   TrmDate
066200090805     C                   EndSr
066300101223    ? *________________________________________________________________
066400101223    ? * NVA wants Jr, Sr, II, III in an "extension" field
066500101223    ? *________________________________________________________________
066600101223    ?C     NameExtension Begsr
066700101223    ? *
066800110104     C                   Eval      Pos      =    *Zero
066900110104     C                   Clear                   MNMEXT
067000101223     C                   Eval      Pos      =    %Scan(' SR ':MLNAME)
067100101223     C                   If        Pos      >    *Zero
067200101223     C                   Eval      MNMEXT   =    %Trim('SR')
067300101223     C                   End
067400101223     C                   Eval      Pos      =    %Scan(' SR. ':MLNAME)
067500101223     C                   If        Pos      >    *Zero
067600101223     C                   Eval      MNMEXT   =    %Trim('SR')
067700101223     C                   End
067800101223     C                   Eval      Pos      =    %Scan(' JR ':MLNAME)
067900101223     C                   If        Pos      >    *Zero
068000101223     C                   Eval      MNMEXT   =    %Trim('JR')
068100101223     C                   End
068200101223     C                   Eval      Pos      =    %Scan(' III ':MLNAME)
068300101223     C                   If        Pos      >    *Zero
068400101223     C                   Eval      MNMEXT   =    %Trim('III')
068500101223     C                   End
068600101223     C                   Eval      Pos      =    %Scan(' II ':MLNAME)
068700101223     C                   If        Pos      >    *Zero
068800101223     C                   Eval      MNMEXT   =    %Trim('II')
068900101223     C                   End
069000101223    ?C                   Endsr
069100051129    ? *________________________________________________________________
069200051129    ? * Key Lists
069300051129    ? *________________________________________________________________
069400051129    ?C     Klist         Begsr
069500120307    ? *
069600090804     C     DepKey1       Klist
069700090804     C                   Kfld                    MCSSNO
069800090805     C                   Kfld                    DSEQ#
069900090804    ? *
070000090804     C     DepKey2       Klist
070100090804     C                   Kfld                    MCTRST
070200090804     C                   Kfld                    MCSUB#
070300090804     C                   Kfld                    MCPLAN
070400101220     C                   Kfld                    MCSSNO
070500090303    ? *
070600090729     C     CovKey        KLIST
070700090729     C                   Kfld                    PLTRST
070800090729     C                   Kfld                    PLSUB#
070900090729     C                   Kfld                    PLPLAN
071000090729    ? *
071100090303     C     TrmKey        Klist
071200090804     C                   Kfld                    MCTRST
071300090728     C                   Kfld                    MCSUB#
071400090804     C                   Kfld                    ACC#
071500090805     C                   Kfld                    MCSSNO
071600090805     C                   Kfld                    Seq#
071700090303     C                   Kfld                    TrmDate
071800100513    ? *
071900100513     C     AccKey        Klist
072000100513     C                   Kfld                    MCTRST
072100100513     C                   Kfld                    MCSUB#
072200100513     C                   Kfld                    ACC#
072300090827    ? *
072400090827     C     RatKey        Klist
072500090827     C                   Kfld                    MCTRST
072600090827     C                   Kfld                    MCSUB#
072700090827     C                   Kfld                    MCPLAN
072800090303    ? *
072900061121    ?C                   Endsr
073000020726    ? *________________________________________________________________
073100020726    ? * Initialization
073200020726    ? *________________________________________________________________
073300001003    ?C     *INZSR        Begsr
073400021007     C     *DATE         Mult      10000.0001    Today             8 0
073500051129     C                   Z-add     99999999      HighDate          8 0
073600101221     C                   Time                    Time              6 0
073700141021     C                   Movel     '080000'      MPRCTI
073800001003    ?C                   Endsr
