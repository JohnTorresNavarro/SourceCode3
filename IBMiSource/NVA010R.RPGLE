000100140401    X***X RENAME NVA1EXR TO NVA010R
000200140401      *                                                                *
000300140401      *  Description:  NVA1EXR    Export NV1 Members/Dependents        *
000400140401      *                                                                *
000500140401      *  (c)Copyright 2010 by GBS, Inc.                                *
000600140401      *  This document contains restricted materials of GBS,Inc.       *
000700140401      *                                                                *
000800140401      *  Written by:    S. Zien                                        *
000900140401      *  Date Written:  12/20/10                                       *
001000140401      *                                                                *
001100140401      *  History:                                                      *
001200140401      *            Revised by - szz                                    *
001300140401      *            Date -       5.5.11                                 *
001400140401      *            Revision -   Use actual group# so that groups can   *
001500140401      *                          ultimately be separated into separate *
001600140401      *                          files at Gary Calaman (NVA)'s request.*
001700140401      *                                                                *
001800140401      *            Revised by - szz                                    *
001900140401      *            Date -       5.13.11                                *
002000140401      *            Revision -   Split out group 51345 into a separate  *
002100140401      *                          file p/Gary Calaman.                  *
002200140401      *                                                                *
002300140401      *            Revised by - szz                                    *
002400111220    ? *            Date -       12.20.11                               *
002500111220    ? *            Revision -   Add new groups to non-association      *
002600111220    ? *                          file p/Gary Calaman.                  *
002700111222    ? *                                                                *
002800111222    ? *            Revised by - szz                                    *
002900111222    ? *            Date -       12.22.11                               *
003000111222    ? *            Revision -   Even though Gary Calaman (NVA) said    *
003100111222    ? *                          these groups were non-association, it *
003200111222    ? *                          appears that they are set up as 'NVA' *
003300111222    ? *                          and not 'NV1' so I they will be put   *
003400111222    ? *                          into NVA2EXR, the association program.*
003500120307    ? *                                                                *
003600120307    ? *            Revised by - szz                                    *
003700120307    ? *            Date -        3.7.12                                *
003800120307    ? *            Revision -   Per Shelly, include GBS account number *
003900120307    ? *                          on the email for new groups and check *
004000120307    ? *                          if only the first five digits of the  *
004100120307    ? *                          rate group# are new.                  *
004200131206    ? *________________________________________________________________*
004300131206   X***X
004400131206   X***X 12/06/2013 SSK SHUT OFF PENNEX, TO BE COMPILED ON 12/17/2013
004500131206   X***X
004600140226   X***X 02/26/2014 SSK CHANGE PER GARY CALAMAN & CAROL FAB TO SUBTRACT ONE DAY FROM TERM DATE
004700131206   X***X
004800140403   X***X 03/12/2014 SSK UNITED SOURCE ONE OVERRIDE
004900140403   X***X 04/03/2014 SSK ADD EAST COAST FREIGHT WAYS
005000140514   X***X
005100140514   X***X 05/14/2014 SSK CHANGE PER GARY CALAMAN, 51345 IS NOW 41230
005200140514   X***X                NEW GROUP & FILE, 86310 CHESAPEAKE OPEN MRI, LLC
005300140514   X***X
005400140724   X***X 07/19/2014 SSK 86590 DRB....
005500140724   X***X 07/24/2014 SSK REMOVE ALOT OF HARDCODE AND USE NVACONTROL FILE
005600141020   X***X
005700141020   X***X 10/20/2014 SSK ADD FASCAN
005800141028   X***X 10/28/2014 SSK FIX SOME CODE
005900131206   X***X
006000131206   X***X
006100090728     FPLNMSTN1  IF   E           K Disk
006200090729     FMCOV39    IF   E           K Disk
006300090728     FMEMBER    IF   E           K Disk
006400090804     FDCOV22    IF   E           K Disk
006500090804     FDEPNDC    IF   E           K Disk
006600090831     FGRAT24    IF   E           K Disk
006700130930     FACMUNIQUE IF   E           K Disk
006800140724     FNVACONTROLIF   E           K Disk
006900101220     FNVA1TRMP  UF A E           K Disk
007000101222    ?FNVA1EXP   UF A E           K Disk
007100021004      *
007200101220     D MemDep        E DS                  Extname(NVA1M) Inz
007300101220     D MemDem        E DS                  Extname(NVA1D) Inz
007400101220     D MemCov        E DS                  Extname(NVA1C) Inz
007500140515      *
007600140515     D @@GRATE       E DS                  Extname(GRATE) Inz
007700021004      *
007800061218     D DSRecord        DS
007900061218     D DSRec                   1    236A
008000061218     D  DSRecTyp               1      1A
008100061221     D  DSRecData              2    236A
008200140226    ***
008300140226     D IN#EFF          S              8S 0 INZ
008400140226     D IN#TRM          S              8S 0 INZ
008500140226     D WRK#TRM         S              8A   INZ
008600140226     D WRK#ISO         S               D   DATFMT(*ISO)
008700140226     D OUT#TRM         S              8S 0 INZ
008800140226    ***
008900101223     D Pos             S              2  0
009000101228     D NV1             S              3A   Inz('NV1')
009100061120     D Cobra           S              1    Inz('C')
009200061221     D Active          S              1    Inz('A')
009300021004     D HighDate        S              8S 0 INZ(99999999)
009400090804     D TrmDate         S                   like(CANDT)
009500090303    ?D CalcDate        S               D   datfmt(*ISO)                         Input Request
009600090303    ?D ThirtyDays      S               D   datfmt(*ISO)                         Input Request
009700090303    ?D TodayPlus30     S               D   datfmt(*ISO)                         Input Request
009800090805     D Seq#            S              2S 0 Inz(*Zero)
009900021004      *
010000101230     C     NV1           Setll     PLNMSTN1
010100101230     C     NV1           Reade     PLNMSTN1
010200101220      *
0103001402260214 C                   Dow       Not %Eof(PLNMSTN1)
010400101220     C                   Exsr      Process
010500101230     C     NV1           Reade     PLNMSTN1
010600101220     c                   EndDo
010700100323      *
010800100323    ?C                   Move      *On           *InLR
010900021004    ? *________________________________________________________________
011000051129    ?C     Process       Begsr
011100070110      *
011200110113     C                   If        PLNCAT    =   'PVS'   Or
011300110113     C                             PLNCAT    =   'PVR'
011400101221     C     CovKey        Setll     MCOV39
011500101221     C                   Dou       %Eof(MCOV39)
011600101221     C     CovKey        Reade     MCOV39
011700101221     C                   If        Not %Eof(MCOV39)
011800131206    ***
011900131206     C                   IF        MCTRST = 598 AND MCSUB# = 1 AND ACC# = 1
012000131206     C                   ITER
012100131206     C                   ENDIF
012200131206    ***
012300101221      *
012400101221      * Find out if termed coverage has already been sent as termed once.
012500101221      *
012600101221     C                   Exsr      DetermTerm
012700101221     C                   If        TermSw    =   'N'
012800101221     C                   If        CANDT     <>  ENRLDT
012900101221     C     MCSSNO        Chain     Member
013000101221     C                   Exsr      Process2
013100101221     C                   End
013200101221     C                   End
013300101221      *
013400101221     C                   End
013500101221     C                   EndDo
013600101222     C                   End
013700101221    ?C                   Endsr
013800101221    ? *________________________________________________________________
013900101221    ?C     Process2      Begsr
014000101221      *
014100101221      * If member is Cobra, use the current effective date.
014200090804      *
014300090804     C                   If        EMPST      =  Cobra
014400090804     C                   Eval      BeginDateN =  ENRLDT
014500090804     C                   Eval      EndDateN   =  CANDT
014600090804     C                   Else
014700090804     C                   Movel     MCTRST        Trust
014800090804     C                   Movel     MCSUB#        Sub
014900090804     C                   Movel     MCPLAN        Plan
015000090804     C                   Movel     MCSSNO        Social
015100090804     C                   Eval      BeginDate  =  '00000000'
015200090804     C                   Eval      EndDate    =  '00000000'
015300110513     C                   Call      'ECOVDT1R'
015400110513     C                   Parm                    Trust             3
015500090804     C                   Parm                    Sub               3
015600090804     C                   Parm                    Plan              4
015700090804     C                   Parm                    Social            9
015800090804     C                   Parm                    BeginDate         8
015900090804     C                   Parm                    EndDate           8
016000090804     C                   Parm                    Err               8
016100021004    ? *
016200090805     C                   Movel     BeginDate     BeginDateN        8 0
016300090805     C                   Movel     EndDate       EndDateN          8 0
016400090804     C                   End
016500100607     C
016600051129     C                   Exsr      BuildRecord
016700141028     C                   EXSR      $MBRGRP
016800141028     C                   Exsr      MemDemSr
016900141028     C                   Exsr      MemCovSr
017000051129    ?C                   Endsr
017100021004    ? *________________________________________________________________
017200101223    ? * Build Subscriber Record
017300021004    ? *________________________________________________________________
017400021004    ?C     BuildRecord   Begsr
017500110104     C                   Clear                   MNMEXT
017600101221     C                   Movel     MBSSNO        MPMEMID
017700101223     C                   Movel     MBSSNO        DPMEMID
017800101223     C                   Movel     MBSSNO        CPMEMID
017900101221     C                   Move      *Blanks       MDEPSS#
018000101222     C                   Eval      MLAST    =    %Trim(MLNAME)
018100101222     C                   Eval      MFIRST   =    %Trim(MFNAME)
018200101221     C                   Eval      MMINIT   =    MMI
018300101221     C                   Eval      MSEX     =    SEX
018400101223     C                   Eval      MRELCD   =    '1'
018500101223     C                   Eval      MPREECD  =    'N'
018600101223     C                   Eval      MOTHCOV  =    COB
018700101223     C                   Movel     BIRTH         MBIRDT
018800090804     C     EndDateN      Ifeq      *Zeros
018900101221     C                   Movel     '00000000'    MCTEDT
019000021017     C                   Else
019100101223     C                   Movel     EndDateN      MCTEDT
019200021017     C                   End
019300090303      *---
019400090730      * If future term date > 30, fill w/zeros                         9 10:52am
019500090303      *---
019600090804     C                   If        BeginDateN <= Today    AND
019700090804     C                             EndDateN >=   Today    AND
019800090804     C                             EndDateN <>   *Zeros
019900090303      * Find the date 30 days before the term date.
020000090804     C     *ISO          Move      EndDateN      CalcDate
020100090303     C     CalcDate      Subdur    30:*d         ThirtyDays
020200090730     C                   Move      ThirtyDays    Candt30           8 0
020300090303      * Find the date 30 days into the future from today
020400090303     C     *ISO          Move      Today         CalcDate
020500090424     C     CalcDate      Adddur    30:*d         TodayPlus30
020600090303     C                   Move      TodayPlus30   Today30           8 0
020700090303     C                   Else
020800090730     C                   Z-add     *Zeros        Candt30
020900090303     C                   End
021000090730     C                   If        Candt30    >= Today    AND
021100090730     C                             Candt30    <= Today30
021200091102     C                                                    OR
021300091102     C                             EndDateN   <  Today
021400101223     C                   Movel     EndDateN      MCTEDT
021500090424     C                   Else
021600101221     C                   Movel     '00000000'    MCTEDT
021700090303     C                   End
021800090303      *---
021900090303      * End determining if term date is > 30 days from now.
022000090303      *---
022100101223     C     BeginDateN    Ifeq      *Zeros
022200101221     C                   Movel     '00000000'    MCEFDT
022300101223     C                   Else
022400101223     C                   Movel     BeginDateN    MCEFDT
022500021017     C                   End
022600101221     C                   Eval      DADDR1X  =    ADDR1
022700101221     C                   Eval      DADDR2X  =    ADDR2
022800101221     C                   Eval      DCITYX   =    CITY
022900101221     C                   Eval      DSTATEX  =    STATE
023000101223     C                   Movel     ZIP           Z5                5
023100101223     C                   Move      ZIP           Z4                4
023200101223     C                   Eval      DZIPX     =   %Trim(Z5 + '-' + Z4)
023300101221     C                   Movel     *Blanks       DPHONEX
023400101222     C                   Eval      MLANGCD   =   *Blanks
023500090827      *---
023600090827      * Get the group from the rate file
023700090827      *---
023800141028     C                   EXSR      $MBRGRP
023900141028
024000101222     C                   Eval      MPERCD  =    %Trim('001')
024100100902      *
024200100902      * If there is an active rec for this member, don't send a term
024300101222     C                   Move      'Y'           ExportYN          1
024400141028     C*******************Eval      ExportYN =    'Y'   REDUNDANT CODING
024500100902     C                   If        CANDT    <    Today  AND CANDT <> *Zeros
024600101222     C                   Movel     MCSSNO        SSN               9
024700101222     C                   Movel     MDSEQ#        SEQNO             2
024800101222     C                   Movel     MCTRST        TRST              3
024900101222     C                   Movel     MCSUB#        SUB#              3
025000101222     C                   Movel     MCPLAN        PLAN              4
025100100902     C                   End
025200100902     C                   If        ExportYN  =   'Y'
025300101221     C                   Exsr      MemDepSr
025400100902     C                   Add       1             MemCtr            5 0
025500100607     C                   End
025600101221     C                   Clear                   NVAEXPR
025700100513      *
025800101223     C                   If        MCOVTP    =   'TIN'
025900141028     C*******************Exsr      MemDemSr      MOVED THESE UP TO LINES AFTER EXSR OF THIS
026000141028     C*******************Exsr      MemCovSr        SUBROUTINE
026100141028     C                   LEAVESR
026200101223     C                   End
026300141028      *
026400141028     C*******************Z-add     *Zeros        ChildCounter      2 0 SET TO 2 AND += FROM THERE
026500141028     C                   Z-add     2             ChildCounter      2 0
026600141028     C*******************If        MCOVTP     <> 'TIN'    THE LEAVESR ABOVE MAKES THIS USELESS
026700090804     C     DepKey2       Setll     DCOV22
026800090804     C     DepKey2       Reade     DCOV22                                 50
026900061121      *
027000061121    ?C     *In50         Doweq     *Off
027100091104     C                   Movel     CCANDT        EndDateN
027200100113     C                   Eval      DepTermSw  =  'N'
027300091123     C                   If        EndDateN    < Today     And
027400091123     C                             EndDateN   <> *Zero
027500091104     C                   Move      EndDateN      TrmDate
027600091104     C                   Movel     DSEQ#         Seq#
027700101220     C     TrmKey        Chain     NVA1TRMP
027800101220     C                   If        %Found(NVA1TRMP)
027900091104     C                   Movel     'Y'           DepTermSw         1
028000091104     C                   Else
028100091104     C                   Exsr      TermRtn
028200141028     C                   EndIF
028300141028     C                   EndIF
028400091104     C                   If        DepTermSw  =  'N'
028500090804     C                   Exsr      BuildDep
028600141028     C                   EndIF
028700090804     C     DepKey2       Reade     DCOV22                                 50
028800061121    ?C                   Enddo
028900091123sz   C                   Z-add     *Zeros        Seq#
029000141028     C*******************Exsr      MemDemSr      MOVED THESE UP TO LINES AFTER EXSR OF THIS
029100141028     C*******************Exsr      MemCovSr        SUBROUTINE
029200141028     C*******************End
029300021007      *
029400021004    ?C                   Endsr
029500141028     *****
029600141028    ?C     $MBRGRP       Begsr
029700141028      *
029800141028     c     RatKey        Setll     GRAT24
029900141028     c     RatKey        Reade     GRAT24
030000141028     c                   Dow       Not %Eof(GRAT24)
030100141028
030200141028     C                   Select
030300141028
030400141028      * ignore same day terms
030500141028     C                   When      FRMDAT  =   TODAT
030600141028
030700141028      * Active
030800141028     C                   When      CANDT    =  *Zeros or
030900141028     C                             CANDT    >= Today
031000141028     C                   If        Today  <=  TODAT
031100141028     C                   Exsr      FormatGroup
031200141028     C                   Leave
031300141028     C                   End
031400141028
031500141028      * Termed
031600141028     C                   When      CANDT    <> *Zeros
031700141028     C                   If        (CANDT  >=  FRMDAT) and
031800141028     C                             (CANDT  <=  TODAT)
031900141028     C                   Exsr      FormatGroup
032000141028     C                   Leave
032100141028     C                   End
032200141028     C                   Endsl
032300141028
032400141028     c     RatKey        Reade     GRAT24
032500141028     C                   EndDo
032600141028      *
032700141028    ?C                   Endsr
032800141028     *****
032900061120    ? *________________________________________________________________
033000061120    ? * Build Dependent Record
033100061120    ? *________________________________________________________________
033200061120    ?C     BuildDep      Begsr
033300101223      *
033400101223      * If member is Cobra, use the current effective date.  If not, use
033500101223      * the earliest effective date for this coverage p/D.A. 8/4/09 4:12pm.
033600101223      *
033700090804     C                   If        EMPST      =  Cobra
033800090804     C                   Eval      BeginDateN =  DENRDT
033900090804     C                   Eval      EndDateN   =  CCANDT
034000090804     C                   Else
034100090804     C                   Movel     MCTRST        Trust
034200090804     C                   Movel     MCSUB#        Sub
034300090804     C                   Movel     MCPLAN        Plan
034400090804     C                   Movel     MCSSNO        Social
034500090805     C                   Movel     DSEQ#         Seq
034600090804     C                   Eval      BeginDate  =  '00000000'
034700090804     C                   Eval      EndDate    =  '00000000'
034800090804     C                   Call      'ECOVDT2R'
034900090804     C                   Parm                    Trust
035000090804     C                   Parm                    Sub
035100090804     C                   Parm                    Plan
035200090804     C                   Parm                    Social
035300090805     C                   Parm                    Seq               2
035400090804     C                   Parm                    BeginDate
035500090804     C                   Parm                    EndDate
035600090804     C                   Parm                    Err
035700090804    ? *
035800090804     C                   Movel     BeginDate     BeginDateN
035900090804     C                   Movel     EndDate       EndDateN
036000090804     C                   End
036100091104      *---
036200091104      * If same-day term, there's no begin date.  Don't send an export record.
036300091104      *---
036400091104     C                   If        BeginDateN <> *Zeros
036500090804      *
036600090804     C     DepKey1       Chain     DEPNDC
036700141028    ***
036800141028     C*******************If        DRELCD     =  'RSO'   Or
036900141028     C*******************          DRELCD     =  'RDA'   Or    COMPRESS CODING
037000141028     C*******************          DRELCD     =  'RA'    Or
037100141028     C*******************          DRELCD     =  'RB'          ALSO FILTER IS INCORRECT
037200141028     C*******************Add       1             ChildCounter
037300141028     ***The*first*child*is '003', the second is '004' and so on.
037400141028     C*******************Z-add     ChildCounter  PerCdN            3 0
037500141028     C*******************Add       2             PerCdN   RIGHT IDEA; WRONG EXECUTION
037600141028     C*******************Move      PerCdN        MPERCD
037700141028     C*******************End
037800141028     C*******************If        DRELCD     =  'RHU'   Or
037900141028     C*******************          DRELCD     =  'RWI'
038000141028     C*******************Eval      MPERCD     =  '002'
038100141028     C*******************End
038200141028    ***
038300141028     C                   If        DRELCD = 'RHU' Or DRELCD = 'RWI'
038400141028     C                   Eval      MPERCD     =  '002'
038500141028     C                   ELSE
038600141028      * The first child is '003', the second is '004' and so on.
038700141028     C                   Add       1             ChildCounter
038800141028     C                   Z-add     ChildCounter  PerCdN            3 0
038900141028     C                   Move      PerCdN        MPERCD
039000141028     C                   EndIF
039100141028    ***
039200101223      *
039300101221     C                   Movel     MBSSNO        MPMEMID
039400101221     C                   Movel     DSSNO         MDEPSS#
039500101221     C                   Eval      MSEX     =    DSEX
039600101223     C                   Eval      MOTHCOV  =    DCOB
039700101223     C                   Movel     DBIRTH        MBIRDT
039800101221     C                   Eval      MLAST    =    DLNAME
039900101221     C                   Eval      MFIRST   =    DFNAME
040000101221     C                   Eval      MMINIT   =    DMI
040100101223     C     EndDateN      Ifeq      *Zeros
040200101221     C                   Movel     '00000000'    MCTEDT
040300061121     C                   Else
040400101223     C                   Movel     EndDateN      MCTEDT
040500090312      *---
040600090730      * If future term date > 30, fill w/zeros
040700090312      *---
040800090804     C                   If        BeginDateN <= Today    AND
040900090804     C                             EndDateN   >= Today    AND
041000090804     C                             EndDateN   <> 99999999 AND
041100090804     C                             EndDateN   <> *Zeros
041200090312      * Find the date 30 days before the term date.
041300090804     C     *ISO          Move      EndDateN      CalcDate
041400090312     C     CalcDate      Subdur    30:*d         ThirtyDays
041500090312     C                   Move      ThirtyDays    dqtodate30        8 0
041600090312      * Find the date 30 days into the future from today
041700090312     C     *ISO          Move      Today         CalcDate
041800090429     C     CalcDate      Adddur    30:*d         TodayPlus30
041900090312     C                   Move      TodayPlus30   Today30           8 0
042000090312     C                   Else
042100090312     C                   Z-add     *Zeros        dqtodate30
042200090312     C                   End
042300091104     C                   If        dqtodate30 <= Today30
042400101223     C                   Movel     EndDateN      MCTEDT
042500090429     C                   Else
042600101221     C                   Movel     '00000000'    MCTEDT
042700090312     C                   End
042800090312      *---
042900090312      * End determining if term date is > 30 days from now.
043000090312      *---
043100090312     C                   End
043200101223     C                   Movel     BeginDateN    MCEFDT
043300101221     C                   Move      DEPSS#        MDEPSS#
043400101223     C                   Eval      MPREECD  =    'N'
043500061120     C                   Select
043600140812     C                   When      DHNDCP  = '3'                                Handicapped
043700101222     C                   Eval      MRELCD   =    '6'                            Disabled
043800101222     C                   When      DSTUDN   =    'Y'                            Student
043900101222     C                   Eval      MRELCD   =    '5'                            Student
044000101222     C                   When      DRELCD   =    'RWI' Or                       Wife
044100101222     C                             DRELCD   =    'RHU'                          Husband
044200101222     C                   Eval      MRELCD   =    '2'                            Spouse
044300141028     C                   When      DRELCD   =    'RPA'
044400141028     C                   Eval      MRELCD   =    '8'
044500101222     C                   When      DRELCD   =    'RDA' Or                       Daughter
044600101222     C                             DRELCD   =    'RSO'                          Son
044700101222     C                   Eval      MRELCD   =    '3'                            Child
044800101222     C                   Other                                                  Other
044900101222     C                   Eval      MRELCD   =    '4'                            Other
045000061120     C                   EndSl
045100090827      *---
045200090827      * Get the group from the rate file
045300090827      *---
045400090831     C     RatKey        Setll     GRAT24
045500090831     C     RatKey        Reade     GRAT24
045600090831     C                   Dow       Not %Eof(GRAT24)
045700091019
045800091019     C                   Select
045900091019
046000091019      * ignore same day terms
046100091019     C                   When      FRMDAT  =   TODAT
046200091019
046300091019      * Active
046400091019     C                   When      CCANDT   =  *Zeros or
046500091019     C                             CCANDT   >= Today
046600100618     C                   If        Today  <=  TODAT
046700091019     C                   Exsr      FormatGroup
046800091019     C                   Leave
046900091019     C                   End
047000091019
047100091019      * Termed
047200091019     C                   When      CCANDT   <> *Zeros
047300091019     C                   If        (CCANDT  >=  FRMDAT) and
047400091019     C                             (CCANDT  <=  TODAT)
047500091019     C                   Exsr      FormatGroup
047600091019     C                   Leave
047700091019     C                   End
047800091019     C                   Endsl
047900091019
048000090831     c     RatKey        Reade     GRAT24
048100090827     C                   EndDo
048200101222
048300100902      *
048400100902      * If there is an active rec for this member, don't send a term
048500100902     C                   Eval      ExportYN =    'Y'
048600100902     C                   If        CCANDT   <    Today  AND CCANDT <> *Zeros
048700100902     C                   Movel     SSNO          SSN
048800100902     C                   Movel     DSEQ#         SEQNO
048900100902     C                   Movel     DVTRST        TRST
049000100902     C                   Movel     DVSUB#        SUB#
049100100902     C                   Movel     DVPLAN        PLAN
049200101223     C                   End
049300100902     C                   If        ExportYN  =   'Y'
049400101221     C                   Exsr      MemDepSr
049500100902     C                   Add       1             MemCtr            5 0
049600100607     C                   End
049700101221     C                   Clear                   NVAEXPR
049800091104      *
049900091104     C                   End
050000091104      *
050100061120    ?C                   Endsr
050200061218    ? *________________________________________________________________
050300101220    ? * Create and write Member Dependent record first.
050400061218    ? *________________________________________________________________
050500101220    ?C     MemDepSr      Begsr
050600101222     C                   Eval      MSEGID   =    '10'
050700101221     C                   Movel     Today         MPRCDT
050800140226    ***
050900140226     C                   MOVE      MCEFDT        IN#EFF
051000140226     C                   MOVE      MCTEDT        IN#TRM
051100140226     C                   EXSR      $DTEOVRD
051200140226     C                   MOVE      OUT#TRM       MCTEDT
051300140226    ***
051400101221     C                   Eval      NVADATA  =    MemDep
051500101221     C                   Write     NVAEXPR
051600101221     C                   Clear                   NVAEXPR
051700061218     C                   EndSr
051800140226   S***S
051900140226     C     $DTEOVRD      BEGSR
052000140226    ***
052100140226     C                   EVAL      OUT#TRM = IN#TRM
052200140226    ***
052300140226     C                   IF        IN#TRM = 0 OR
052400140226     C                             IN#TRM = IN#EFF
052500140226     C                   LEAVESR
052600140226     C                   ENDIF
052700140226    ***
052800140226     C                   MOVE      IN#TRM        WRK#TRM
052900140226     C                   IF        %SUBST(WRK#TRM:7:2) <> '01'
053000140226     C                   LEAVESR
053100140226     C                   ENDIF
053200140226    ***
053300140226     C                   MOVE      IN#TRM        WRK#ISO
053400140226     C                   SUBDUR    1:*D          WRK#ISO
053500140226     C                   MOVE      WRK#ISO       OUT#TRM
053600140226    ***
053700140226     C                   ENDSR
053800140226   S***S
053900061218    ? *________________________________________________________________
054000101220    ? * Create and write Member records after the MemDep record.
054100061218    ? *________________________________________________________________
054200101221    ?C     MemDemSr      Begsr
054300101222     C                   Eval      DSEGID   =    '20'
054400101221     C                   Movel     Today         DPRCDT
054500101223     C                   Movel     MPRCTI        DPRCTI
054600101221     C                   Eval      NVADATA  =    MemDem
054700101221     C                   Write     NVAEXPR
054800101221     C                   Clear                   NVAEXPR
054900061218     C                   EndSr
055000061218    ? *________________________________________________________________
055100101220    ? * Create and write MemCov record last.
055200061218    ? *________________________________________________________________
055300101220    ?C     MemCovSr      Begsr
055400101221     C                   Eval      CSEGID   =    '30'
055500101221     C                   Movel     Today         CPRCDT
055600101223     C                   Movel     MPRCTI        CPRCTI
055700101223     C                   Movel     TERMDT        CETEDT
055800101223     C                   Movel     EMPDT         CEHIDT
055900101223     C                   Eval      CPRGRP#  =    *Blanks
056000101223     C                   Eval      CCOEFDT  =    '00000000'
056100101223     C                   Eval      CCOBRCD  =    *Blanks
056200101223     C                   Eval      CPLANID  =    *Blanks
056300101223     C                   Eval      CACTCD   =    *Blanks
056400101223     C                   Movel     ENRLDT        CPEFDT
056500101223     C                   Movel     CANDT         CPTEDT
056600101223     C                   Select
056700101223     C                   When      MCOVTP   =    'TIN'
056800101223     C                   Eval      CCOVIN   =    'S'
056900101223     C                   When      MCOVTP   =    'TFA'
057000101223     C                   Eval      CCOVIN   =    'F'
057100101223     C                   Other
057200101223     C                   Eval      CCOVIN   =    'L'
057300101223     C                   EndSl
057400140226    ***
057500140226     C                   MOVE      CPEFDT        IN#EFF
057600140226     C                   MOVE      CPTEDT        IN#TRM
057700140226     C                   EXSR      $DTEOVRD
057800140226     C                   MOVE      OUT#TRM       CPTEDT
057900140226    ***
058000101221     C                   Eval      NVADATA  =    MemCov
058100101221     C                   Write     NVAEXPR
058200101221     C                   Clear                   NVAEXPR
058300061218     C                   EndSr
058400111220    ? *_
058500090303    ? * For termed coverage
058600090303    ? *________________________________________________________________
058700090303    ?C     TermRtn       Begsr
058800101221     C                   Eval      N1TRUST    =  MCTRST
058900101221     C                   Eval      N1SUB#     =  MCSUB#
059000101221     C                   Eval      N1ACCT     =  ACC#
059100101221     C                   Eval      N1PDTP     =  Today
059200101221     C                   Eval      N1PLAN     =  MCPLAN
059300101221     C                   Eval      N1COV      =  MCOVTP
059400101221     C                   Move      MCSSNO        N1SSNO
059500141028     C                   Eval      N1SEQ#     =  SEQ#
059600141028     C*******************Eval      N1SEQ#     =  MDSEQ#
059700101221     C                   Eval      N1TRDT     =  EndDateN
059800101220     C                   Write     N1TRMR
059900101220     C                   Clear                   N1TRMR
060000090303    ?C                   Endsr
060100090908    ? *________________________________________________________________
060200101220    ? * Group number field
060300090908    ? *________________________________________________________________
060400090908    ?C     FormatGroup   Begsr
060500090908    ? *
060600130926     C                   MOVE      *BLANKS       @G               15
060700140724    ? *
060800140724    ? * DEFAULTS
060900140724     C                   Eval      MPCTLID  =    'PVMS'
061000140724     C                   Eval      DPCTLID  =    'PVMS'
061100140724     C                   Eval      CPCTLID  =    'PVMS'
061200140724     C                   Eval      MSEQ     =    '00'
061300140724     C                   Eval      DSEQ     =    '00'
061400140724     C                   Eval      CSEQ     =    '00'
061500140724    ? *
061600130926     C                   EVAL      @G = %TRIM(GROUP#)
061700140724     C                   MOVEL     @G            @G5               5
061800140724    ***
061900140724     C     @G5           CHAIN     NVACTLF
062000140724     C                   IF        NOT %FOUND(NVACONTROL)
062100140724     C                   Eval      MGRP# = 'XXXXX'
062200140724     C                   Eval      DGRP# = 'XXXXX'
062300140724     C                   Eval      CGRP# = 'XXXXX'
062400140724     C                   Call      'NVANEWCL'
062500140724     C                   Parm                    Group#
062600140724     C                   LEAVESR
062700140724     C                   ENDIF
062800140724    ***
062900140724     C                   IF        NCG5 <> *BLANKS
063000140724     C                   EVAL      %SUBST(@G:1:5) = NCG5
063100140724     C                   ENDIF
063200140724    ***
063300140724     C                   IF        NCGR# <> *BLANKS
063400140724     C                   EVAL      GROUP# = NCGR#
063500140724     C                   ENDIF
063600140724    ***
063700140724     C                   Eval      MPCTLID  = NCCID
063800140724     C                   Eval      DPCTLID  = NCCID
063900140724     C                   Eval      CPCTLID  = NCCID
064000140724    ***
064100130926     C                   Eval      MGRP# = GROUP#
064200130926     C                   Eval      DGRP# = GROUP#
064300130926     C                   Eval      CGRP# = GROUP#
064400140312    ***
064500090908    ?C                   Endsr
064600090805    ? *________________________________________________________________
064700090805    ? * Determine if termed coverage has been sent once
064800090805    ? *________________________________________________________________
064900090805    ?C     DetermTerm    Begsr
065000090805    ? *
065100090805     C                   Movel     CANDT         TrmDate
065200090805     C                   Movel     'N'           TermSw            1
065300090805     C                   If        CANDT     <   Today  And
065400090805     C                             CANDT     <>  *Zero
065500101220     C     TrmKey        Chain     NVA1TRMP
065600101220     C                   If        %Found(NVA1TRMP)
065700090805     C                   Movel     'Y'           TermSw
065800090805     C                   Else
065900090805     C                   Movel     CANDT         EndDateN
066000090805     C                   Exsr      TermRtn
066100090805     C                   End
066200090805     C                   End
066300090805     C                   Clear                   TrmDate
066400090805     C                   EndSr
066500101223    ? *________________________________________________________________
066600101223    ? * NVA wants Jr, Sr, II, III in an "extension" field
066700101223    ? *________________________________________________________________
066800101223    ?C     NameExtension Begsr
066900101223    ? *
067000110104     C                   Eval      Pos      =    *Zero
067100110104     C                   Clear                   MNMEXT
067200101223     C                   Eval      Pos      =    %Scan(' SR ':MLNAME)
067300101223     C                   If        Pos      >    *Zero
067400101223     C                   Eval      MNMEXT   =    %Trim('SR')
067500101223     C                   End
067600101223     C                   Eval      Pos      =    %Scan(' SR. ':MLNAME)
067700101223     C                   If        Pos      >    *Zero
067800101223     C                   Eval      MNMEXT   =    %Trim('SR')
067900101223     C                   End
068000101223     C                   Eval      Pos      =    %Scan(' JR ':MLNAME)
068100101223     C                   If        Pos      >    *Zero
068200101223     C                   Eval      MNMEXT   =    %Trim('JR')
068300101223     C                   End
068400101223     C                   Eval      Pos      =    %Scan(' III ':MLNAME)
068500101223     C                   If        Pos      >    *Zero
068600101223     C                   Eval      MNMEXT   =    %Trim('III')
068700101223     C                   End
068800101223     C                   Eval      Pos      =    %Scan(' II ':MLNAME)
068900101223     C                   If        Pos      >    *Zero
069000101223     C                   Eval      MNMEXT   =    %Trim('II')
069100101223     C                   End
069200101223    ?C                   Endsr
069300051129    ? *________________________________________________________________
069400051129    ? * Key Lists
069500051129    ? *________________________________________________________________
069600051129    ?C     Klist         Begsr
069700051129    ? *
069800090804     C     DepKey1       Klist
069900090804     C                   Kfld                    MCSSNO
070000090805     C                   Kfld                    DSEQ#
070100090804    ? *
070200090804     C     DepKey2       Klist
070300090804     C                   Kfld                    MCTRST
070400090804     C                   Kfld                    MCSUB#
070500090804     C                   Kfld                    MCPLAN
070600101220     C                   Kfld                    MCSSNO
070700090303    ? *
070800090729     C     CovKey        KLIST
070900090729     C                   Kfld                    PLTRST
071000090729     C                   Kfld                    PLSUB#
071100090729     C                   Kfld                    PLPLAN
071200090729    ? *
071300090303     C     TrmKey        Klist
071400090804     C                   Kfld                    MCTRST
071500090728     C                   Kfld                    MCSUB#
071600090804     C                   Kfld                    ACC#
071700090805     C                   Kfld                    MCSSNO
071800090805     C                   Kfld                    Seq#
071900090303     C                   Kfld                    TrmDate
072000100513    ? *
072100100513     C     AccKey        Klist
072200100513     C                   Kfld                    MCTRST
072300100513     C                   Kfld                    MCSUB#
072400100513     C                   Kfld                    ACC#
072500090827    ? *
072600090827     C     RatKey        Klist
072700090827     C                   Kfld                    MCTRST
072800090827     C                   Kfld                    MCSUB#
072900090827     C                   Kfld                    MCPLAN
073000090303    ? *
073100061121    ?C                   Endsr
073200020726    ? *________________________________________________________________
073300020726    ? * Initialization
073400020726    ? *________________________________________________________________
073500001003    ?C     *INZSR        Begsr
073600021007     C     *DATE         Mult      10000.0001    Today             8 0
073700051129     C                   Z-add     99999999      HighDate          8 0
073800101221     C                   Time                    Time              6 0
073900141021     C                   Movel     '080000'      MPRCTI
074000001003    ?C                   Endsr
