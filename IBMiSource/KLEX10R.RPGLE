000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300090728    ? *  Description:  KLEX10R    Export Kaiser (local) Members        *
000400001003    ? *                                                                *
000500090728    ? *  (c)Copyright 2009 by GBS, Inc.                                *
000600051129    ? *  This document contains restricted materials of GBS,Inc.       *
000700001003    ? *                                                                *
000800051129    ? *  Written by:    S. Zien                                        *
000900090728    ? *  Date Written:   7/28/09                                       *
001000051207    ? *                                                                *
001100090730    ? *  Note:  "MAS " means Mid-Atlantic States                       *
001200090730    ? *                                                                *
001300051212    ? *  History:                                                      *
001400100323    ? *            Revised by - S. Zien                                *
001500100323    ? *            Date -        3.23.2010                             *
001600100323    ? *            Revision -   Add new Carrier Code: KA per Carol F.  *
001700070821    ? *                                                                *
001800100513    ? *            Revised by -  szz                                   *
001900100513    ? *            Date -        05.13.2010                            *
002000100513    ? *            Revision -    Write all groups to a file to deter-  *
002100100513      *                          mine if there are any new groups for  *
002200100513      *                          the next run.                         *
002300100607    ? *                                                                *
002400100607    ? *            Revised by -  szz                                   *
002500100607    ? *            Date -        06.07.2010                            *
002600100607    ? *            Revision -    Per Jackie at Kaiser & Deborah Clark  *
002700100607      *                          do not send group 4761-1 or 4761-4.   *
002800100616    ? *                                                                *
002900100616    ? *            Revised by -  szz                                   *
003000100616    ? *            Date -        06.16.2010                            *
003100100616    ? *            Revision -    Per Deborah Clark and confirmed by    *
003200100616      *                          Dave A. do not send groups            *
003300100616      *                          17563-0, 17563-7 and 17563-8.         *
003400100618    ? *                                                                *
003500100618    ? *            Revised by -  szz                                   *
003600100618    ? *            Date -        06.18.2010                            *
003700100618    ? *            Revision -    The group# was not being formatted    *
003800100618      *                          if it was a future effective date.    *
003900100826    ? *                                                                *
004000100826    ? *            Revised by -  szz                                   *
004100100826    ? *            Date -        08.26.2010                            *
004200100826    ? *            Revision -    Per Deborah Clark via Elizabeth Kasper*
004300100826      *                          email of 8/26/2010 12:14 pm, do not   *
004400100826      *                          send 600-5-19 or 600-5-20 anymore     *
004500100826      *                          since they have been termed for GBS   *
004600100826      *                          but not for Kaiser.                   *
004700110104    ? *                                                                *
004800110104    ? *            Revised by -  szz                                   *
004900110104    ? *            Date -        01.04.2011                            *
005000110104    ? *            Revision -    Per Jackie at Kaiser email 1/4/11     *
005100110104      *                          12:59 pm, do not send group 21275     *
005200110104      *                          (300-9-70) because they have termed   *
005300110104      *                          Kaiser.                               *
005400110131    ? *                                                                *
005500110131    ? *            Revised by -  szz                                   *
005600110131    ? *            Date -        01.31.2011                            *
005700110131    ? *            Revision -    Per Deborah Clark email 1/31/11       *
005800110131      *                          12:31 pm, do not send group 8234-5    *
005900110131      *                          (900-107-40) because they have termed *
006000110131      *                          GBS but are still active with Kaiser. *
006100110404    ? *                                                                *
006200110404    ? *            Revised by -  szz                                   *
006300110404    ? *            Date -        04.04.2011                            *
006400110404    ? *            Revision -    Per Deborah Clark email 4/1/11       *
006500110404      *                          1:01 pm, do not send group 8174-6/7/8/9
006600110404      *                          (600-12-29) because they have termed *
006700110404      *                          GBS but are still active with Kaiser. *
006800110705    ? *                                                                *
006900110705    ? *            Revised by -  szz                                   *
007000110705    ? *            Date -        07.05.2011                            *
007100110705    ? *            Revision -    Do not use the rate if it has a "D".  *
007200111011    ? *                                                                *
007300111011    ? *            Revised by -  szz                                   *
007400111011    ? *            Date -        10.11.2011                            *
007500111011    ? *            Revision -    Check the daily BOR file to see if a  *
007600111011    ? *                           "termed" plan should not be sent to  *
007700111011    ? *                           Kaiser as termed because it is only  *
007800111011    ? *                           termed from GBS but not Kaiser. This *
007900111011    ? *                           only applies if the COVDTD has passed*
008000111011    ? *                           and the account is currently termed. *
008100111208    ? *                                                                *
008200111208    ? *            Revised by -  SSK                                   *
008300111208    ? *            Date -        12.08.2011                            *
008400111208    ? *            Revision -    AZAR BRIDAL OVERRIDE                  *
008500111208      *                          PER MEMBERSHIP TEAM AT KAISER, 20545-5 IS
008600111208    ? *                          INVALID; OVERRIDE IND COVERAGE TO -6 AND
008700111208    ? *                          OTHER TIERS TO -7
008800120214    ? *                                                                *
008900120214    ? *            Revised by -  szz                                   *
009000120214    ? *            Date -        02.14.2012                            *
009100120214    ? *            Revision - ...Zero as dep seq# was never getting    *
009200120214      *                          into the KLTRMP file for the sub-     *
009300120214      *                          scriber.  01 was always instead of 00.*
009400120214      *                       ...Per Dave A. and Carol F. (email of    *
009500120214      *                          2/13/2012 10:34 am) subtract one day  *
009600120214      *                          from the member's coverage term date  *
009700120214      *                          so that it will fall within the rate  *
009800120214      *                          date range.                           *
009900120629    ? *                                                                *
010000120629    ? *            Revised by -  szz                                   *
010100120629    ? *            Date -        06.29.2012                            *
010200120629    ? *            Revision - ...Dependents have the same rule as      *
010300120629      *                          subscribers for future term dates.    *
010400120629      *                          Also, do not send Calico 650-9-6      *
010500120629      *                          anymore.                              *
010600120723    ? *                                                                *
010700120723    ? *            Revised by -  szz                                   *
010800120723    ? *            Date -        07.23.2012                            *
010900120723    ? *            Revision -    Per Deborah Clark email 7/23/11       *
011000120723      *                          1:48 pm, do not send group 18797-0    *
011100120723      *                          (600-4-18) because they have termed   *
011200120723      *                          GBS but are still active with Kaiser. *
011300120927    ? *                                                                *
011400120927    ? *            Revised by -  szz                                   *
011500120927    ? *            Date -        09.27.2012                            *
011600120927    ? *            Revision -    Per Deborah Clark email 9/26/12       *
011700120927      *                          5:21 pm, do not send group 20843-1    *
011800120927      *                          (300-3-76) because they have termed   *
011900120927      *                          GBS but are still active with Kaiser. *
012000121008      *                                                                *
012100121008      * 10/08/12 dlk - add plan category code PCM to include cobra     *
012200121008      *                medical plans.                                  *
012300121019    ? *                                                                *
012400121019    ? *            Revised by -  szz                                   *
012500121019    ? *            Date -        10.19.2012                            *
012600121019    ? *            Revision -    Per Deborah Clark email 10/18/12      *
012700121019      *                          5:20 pm, do not send group 20897-...  *
012800121023      *                          (591-3-204) because they have termed   *
012900121019      *                          GBS but are still active with Kaiser. *
013000121019      *                                                                *
013100121022    ? *            Revised by -  szz                                   *
013200121022    ? *            Date -        10.22.2012                            *
013300121022    ? *            Revision -    Per Deborah Clark email 10/22/12      *
013400121022      *                          2:40 pm, do not send group 20843-0/-1.*
013500121022      *                          (300-3-76) because they have termed   *
013600121022      *                          GBS but are still active with Kaiser. *
013700121115    ? *            Revised by -  szz                                   *
013800121115    ? *            Date -        11.15.2012                            *
013900121115    ? *            Revision -    Per Deborah Clark email 11/15/12      *
014000121115      *                         12:54 pm, do not send group 18361 &    *
014100121115      *                          associated subgroups; they have termed*
014200121115      *                          GBS but are still active with Kaiser. *
014300121115      *                          This is most but not all of 590.5.3.  *
014400130204    ? *            Revised by -  szz                                   *
014500130204    ? *            Date -        2.4.2013                              *
014600130204    ? *            Revision -    Per Deborah Clark email 2/2/2013      *
014700130204      *                         12:09 pm, do not send group 22155 &    *
014800130204      *                          associated subgroups; they have termed*
014900130204      *                          GBS but are still active with Kaiser. *
015000130204      *                          This corresponds to 300-8-69.         *
015100121022      *                                                                *
015200130906    ? *            Revised by -  SSK                                   *
015300130906    ? *            Date -        09.06.2013                            *
015400130906    ? *            Revision -    PER LISHA; THE GROUP 300.009.0070     *
015500130906      *                          SHOULD HAVE BEEN SWITCHED ON BACK IN  *
015600130906      *                          LATE JANUARY 2011.                    *
015700130906      *                                                                *
015800140326    ? *            Revised by -  SSK                                   *
015900140326    ? *            Date -        03.26.2014                            *
016000140326    ? *            Revision -    NEW CARRIER CODE AKP                  *
016100130906      *                                                                *
016200140702    ? *            Revised by -  SSK                                   *
016300140702    ? *            Date -        07.02.2014                            *
016400140702    ? *            Revision -    DOMESTIC PARTNER                      *
016500130906      *                                                                *
016600130906      *                                                                *
016700130906      *                                                                *
016800130906      *                                                                *
016900130906      *                                                                *
017000130906    ? *________________________________________________________________*
017100090728     FPLNMSTN1  IF   E           K Disk
017200090729     FMCOV39    IF   E           K Disk
017300090728     FMEMBER    IF   E           K Disk
017400090804     FDCOV22    IF   E           K Disk
017500090804     FDEPNDC    IF   E           K Disk
017600090831     FGRAT24    IF   E           K Disk
017700100513     FACCMST    IF   E           K Disk
017800111011     FKLEX12P   IF   E           K Disk
017900090728     FKLTRMP    UF A E           K Disk
018000091102    ?FKLEXP     UF A E           K Disk    USROPN
018100090728    ?FKLEXP2    IF A E           K Disk
018200100513    ?FKANEWG    IF A E           K DISK
018300021004      *
018400090728     D Header        E DS                  Extname(KLEXH) Inz
018500090804     D MemberFmt     E DS                  Extname(KLEXM) Inz
018600090728     D Footer        E DS                  Extname(KLEXF) Inz
018700021004      *
018800061218     D DSRecord        DS
018900061218     D DSRec                   1    236A
019000061218     D  DSRecTyp               1      1A
019100061221     D  DSRecData              2    236A
019200061221     D*
019300090804     D KP              S              3A   Inz('KP ')
019400100323     D KA              S              3A   Inz('KA ')
019500140326     D AKP             S              3A   Inz('AKP')
019600100323     D CC              S              3A   Inz('   ')
019700061120     D Cobra           S              1    Inz('C')
019800061221     D Active          S              1    Inz('A')
019900070102     D Retired         S              1    Inz('R')
020000021004     D Pos             S              2S 0 INZ
020100021004     D HighDate        S              8S 0 INZ(99999999)
020200120214    ?D CalcDate1       S               D   datfmt(*ISO)                         Input Request
020300120214    ?D PrevDay         S               D   datfmt(*ISO)                         Input Request
020400090804     D TrmDate         S                   like(CANDT)
020500090303    ?D CalcDate        S               D   datfmt(*ISO)                         Input Request
020600090303    ?D ThirtyDays      S               D   datfmt(*ISO)                         Input Request
020700090303    ?D TodayPlus30     S               D   datfmt(*ISO)                         Input Request
020800090805     D Seq#            S              2S 0 Inz(*Zero)
020900100513     D NoAcctErrMsg    C                   'Account Not Found. Please forward -
021000100513     D                                      this to AS400OPERATORS@GBSIO.NET'
021100021004      *
021200100323     C                   Eval      CC   =   KA
021300100323     C                   Exsr      Process_CC
021400100323     C                   Eval      CC   =   KP
021500100323     C                   Exsr      Process_CC
021600140326     C                   Eval      CC   =  AKP
021700140326     C                   Exsr      Process_CC
021800100323     C                   Close     KLEXP
021900100323      *
022000100323     C                   Exsr      HeaderSr
022100100323     C                   Exsr      MemberSr
022200100323     C                   Exsr      FooterSr
022300100323    ?C                   Move      *On           *InLR
022400100323    ? *________________________________________________________________
022500100323    ?C     Process_CC    Begsr
022600100323      *
022700100323     C
022800100323     C     CC            Setll     PLNMSTN1
022900100323     C     CC            Reade     PLNMSTN1
023000021003      *
0231000907290214?C                   Dow       Not %Eof(PLNMSTN1)
023200121008     C                   If        PLNCAT = 'PMM' or plncat = 'PCM'
023300090729     C     CovKey        Setll     MCOV39
023400090805     C                   Dou       %Eof(MCOV39)
023500100805     C     CovKey        Reade     MCOV39
023600090804     C                   If        Not %Eof(MCOV39)
023700100826      * Washington Center for the Aging Services - GBS Termed but not Kaiser
023800100805     C                   If        MCTRST  = 600   And
023900100805     C                             MCSUB#  = 1     And
024000100805     C                             ACC#    = 19
024100100805     C                   Iter
024200100805     C                   End
024300110104      * Vacaro's Italian Pastry Shop             - Termed Kaiser
024400130906     C***                If        MCTRST  = 300   And
024500130906     C***                          MCSUB#  = 9     And
024600130906     C***                          ACC#    = 70
024700130906     C***                Iter
024800130906     C***                End
024900100826      * Smyth Annapolist  -  GBS Termed but not Kaiser
025000100826     C                   If        MCTRST  = 600   And
025100100826     C                             MCSUB#  = 5     And
025200100826     C                             ACC#    = 19
025300100826     C                   Iter
025400100826     C                   End
025500140826      * FAMILY SERVICES  -  GBS Termed but not Kaiser
025600140826     C                   If        MCTRST  = 905   And
025700140826     C                             MCSUB#  = 1     And
025800140826     C                             ACC#    = 484
025900140826     C                   Iter
026000140826     C                   End
026100100826      * Smyth Ellicott City - GBS Termed but not Kaiser
026200100826     C                   If        MCTRST  = 600   And
026300100826     C                             MCSUB#  = 5     And
026400100826     C                             ACC#    = 20
026500100826     C                   Iter
026600100826     C                   End
026700100913      *
026800100913      * Lenox Lazer - Do not send terms anymore per Jackie L. at Kaiser
026900100913     C                   If        MCTRST  = 591   And
027000100913     C                             MCSUB#  = 5     And
027100100913     C                             ACC#    = 234
027200100913     C                   Iter
027300100913     C                   End
027400110131      * Custom Electric Systems, Inc. -  GBS Termed but not Kaiser
027500110131     C                   If        MCTRST  = 900   And
027600110131     C                             MCSUB#  = 107   And
027700110131     C                             ACC#    = 40
027800110131     C                   Iter
027900110131     C                   End
028000110404      * Hopkins & Porter              -  GBS Termed but not Kaiser
028100110404     C                   If        MCTRST  = 600   And
028200110404     C                             MCSUB#  = 12    And
028300110404     C                             ACC#    = 29
028400110404     C                   Iter
028500110404     C                   End
028600120629      * Calico                        -  GBS Termed but not Kaiser
028700120629     C                   If        MCTRST  = 650   And
028800120629     C                             MCSUB#  = 9     And
028900120629     C                             ACC#    = 6
029000120629     C                   Iter
029100120629     C                   End
029200120723      * The Barkley Condominiums      -  GBS Termed but not Kaiser
029300120723     C                   If        MCTRST  = 600   And
029400120723     C                             MCSUB#  = 4     And
029500120723     C                             ACC#    = 18
029600120723     C                   Iter
029700120723     C                   End
029800140818      *
029900140818      * NEVER SEND THIS PARTICULAR MEMBER EVER AGAIN; THIS IS THE 2013 TERM THING
030000140818      * LISHA AND LINDA BLAKE
030100140818      *
030200140818     C                   IF        MCSSNO = 231905614
030300140818     C                   Iter
030400140818     C                   End
030500090805      *
030600090805      * Find out if termed coverage has already been sent as termed once.
030700090805      *
030800090805     C                   Exsr      DetermTerm
030900090805     C                   If        TermSw    =   'N'
031000090804     C                   If        CANDT     <>  ENRLDT
031100090729     C     MCSSNO        Chain     Member
031200090729     C                   If        MEDICR    <>  'Y'
031300051129     C                   Exsr      Process
031400070110     C                   End
031500090804     C                   End
031600090805     C                   End
031700090729      *
031800090805     C                   End
031900090805     C                   EndDo
032000090805     C                   End
032100090729      *
032200100323     C     CC            Reade     PLNMSTN1
032300001003    ?C                   Enddo
032400100513    ?C                   Endsr
032500021004     C
032600021004    ? *________________________________________________________________
032700051129    ?C     Process       Begsr
032800070110      *
032900090804      * If member is Cobra, use the current effective date.  If not, use
033000090804      * the earliest effective date for this coverage p/D.A. 8/4/09 4:12pm.
033100090804      *
033200090804     C                   If        EMPST      =  Cobra
033300090804     C                   Eval      BeginDateN =  ENRLDT
033400090804     C                   Eval      EndDateN   =  CANDT
033500090804     C                   Else
033600090804     C                   Movel     MCTRST        Trust
033700090804     C                   Movel     MCSUB#        Sub
033800090804     C                   Movel     MCPLAN        Plan
033900090804     C                   Movel     MCSSNO        Social
034000090804     C                   Eval      BeginDate  =  '00000000'
034100090804     C                   Eval      EndDate    =  '00000000'
034200090804     C                   Call      'ECOVDT1R'
034300090804     C                   Parm                    Trust             3
034400090804     C                   Parm                    Sub               3
034500090804     C                   Parm                    Plan              4
034600090804     C                   Parm                    Social            9
034700090804     C                   Parm                    BeginDate         8
034800090804     C                   Parm                    EndDate           8
034900090804     C                   Parm                    Err               8
035000021004    ? *
035100090805     C                   Movel     BeginDate     BeginDateN        8 0
035200090805     C                   Movel     EndDate       EndDateN          8 0
035300090804     C                   End
035400100607     C
035500051129     C                   Exsr      BuildRecord
035600051129    ?C                   Endsr
035700021004    ? *________________________________________________________________
035800021004    ? * Build Record
035900021004    ? *________________________________________________________________
036000021004    ?C     BuildRecord   Begsr
036100061218     C                   Eval      MPRECID  =    'M'
036200090729     C                   Movel     MBSSNO        MPSSSNO
036300090729     C                   Movel     MBSSNO        MPSSNO
036400090729     C                   Eval      MPLNAME  =    MLNAME
036500090729     C                   Eval      MPFNAME  =    MFNAME
036600090729     C                   Eval      MPMI     =    MMI
036700090729     C                   Eval      MPSEX    =    SEX
036800090729     C     BIRTH         Mult      10000.0001    MPBIDT
036900090804     C     EndDateN      Ifeq      *Zeros
037000061218     C                   Z-add     *Zeros        MPTEDT
037100021017     C                   Else
037200090804     C     EndDateN      Mult      10000.0001    MPTEDT
037300021017     C                   End
037400090303      *---
037500090730      * If future term date > 30, fill w/zeros                         9 10:52am
037600090303      *---
037700090804     C                   If        BeginDateN <= Today    AND
037800090804     C                             EndDateN >=   Today    AND
037900090804     C                             EndDateN <>   *Zeros
038000090303      * Find the date 30 days before the term date.
038100090804     C     *ISO          Move      EndDateN      CalcDate
038200090303     C     CalcDate      Subdur    30:*d         ThirtyDays
038300090730     C                   Move      ThirtyDays    Candt30           8 0
038400090303      * Find the date 30 days into the future from today
038500090303     C     *ISO          Move      Today         CalcDate
038600090424     C     CalcDate      Adddur    30:*d         TodayPlus30
038700090303     C                   Move      TodayPlus30   Today30           8 0
038800090303     C                   Else
038900090730     C                   Z-add     *Zeros        Candt30
039000090303     C                   End
039100090730     C                   If        Candt30    >= Today    AND
039200090730     C                             Candt30    <= Today30
039300091102     C                                                    OR
039400091102     C                             EndDateN   <  Today
039500090804     C     EndDateN      Mult      10000.0001    MPTEDT
039600090424     C                   Else
039700090424     C                   Z-add     *Zeros        MPTEDT
039800090303     C                   End
039900090303      *---
040000090303      * End determining if term date is > 30 days from now.
040100090303      *---
040200090805     C     BeginDateN    Mult      10000.0001    MPEFDT
040300090730     C     MPTEDT        Ifeq      *Zeros
040400061218     C                   Z-add     *Zeros        MPTEDT
040500021017     C                   End
040600090730     C                   Eval      MPADD1   =    ADDR1
040700090730     C                   Eval      MPADD2   =    ADDR2
040800090730     C                   Eval      MPCITY   =    CITY
040900090730     C                   Eval      MPSTATE  =    STATE
041000090730     C                   Movel     ZIP           MPZIP
041100090730     C                   Movel     AREA          MPHPHON
041200090730     C                   Move      PHONE         MPHPHON
041300061218     C                   Move      *Blanks       MPWPHON
041400061218     C                   Movel     *Blanks       MPWPHOE
041500090827      *---
041600090827      * Get the group from the rate file
041700090827      *---
041800120214      * Subtract 1 day from the member coverage date to find the group#
041900120214     C                   If        CANDT   <>    *Zeros
042000120214     C     *ISO          Move      CANDT         CalcDate1
042100120214     C     CalcDate1     Subdur    1:*d          PrevDay
042200120214     C                   Move      PrevDay       Candtm1           8 0
042300120214     C                   Else
042400120214     C                   Eval      Candtm1  =    *Zeros
042500120214     C                   End
042600090831     c     RatKey        Setll     GRAT24
042700090831     c     RatKey        Reade     GRAT24
042800090831     c                   Dow       Not %Eof(GRAT24)
042900110705      *
043000091019     C                   Select
043100091019
043200091019      * ignore same day terms
043300091019     C                   When      FRMDAT  =   TODAT
043400091019
043500120214
043600091019      * Active
043700120214     C                   When      Candtm1  =  *Zeros or
043800120214     C                             Candtm1  >= Today
043900100618     C                   If        Today  <=  TODAT
044000110705     C                   If        GRDLTD <>  'D'
044100091019     C                   Exsr      FormatGroup
044200091019     C                   Leave
044300110705     C                   End
044400100618     C                   End
044500091019
044600091019      * Termed
044700120214     C                   When      Candtm1  <> *Zeros
044800120214     C                   If        (Candtm1 >=  FRMDAT) and
044900120214     C                             (Candtm1 <=  TODAT)
045000110705     C                   If        GRDLTD <>  'D'
045100090908     C                   Exsr      FormatGroup
045200090827     C                   Leave
045300110705     C                   End
045400090827     C                   End
045500091019     C                   Endsl
045600091019
045700090831     c     RatKey        Reade     GRAT24
045800090827     C                   EndDo
045900070102     C                   Eval      MPSUBPC  =    *Blanks
046000070103     C                   Eval      MPMEMPC  =    '         *'
046100061218     C                   Eval      MPREL    =    %Trim('SUB')
046200090804     C                   Eval      KLDATA   =    MemberFmt
046300091102     C     KLDATA        Chain     KLEXP
046400091102     C                   If        Not %Found(KLEXP)
046500100607     C                   If        MPSEMPG   <>  '4761-1'   And
046600100616     C                             MPSEMPG   <>  '4761-4'   And
046700130204     C                             MPSEMPG   <>  '22155-0'  And
046800130204     C                             MPSEMPG   <>  '22155-1'  And
046900120927     C                             MPSEMPG   <>  '20843-1'  and
047000121019     C                             MPSEMPG   <>  '20897-0'  and
047100121019     C                             MPSEMPG   <>  '20897-1'  and
047200121019     C                             MPSEMPG   <>  '20897-2'  and
047300121019     C                             MPSEMPG   <>  '20897-3'  and
047400121019     C                             MPSEMPG   <>  '20897-4'  and
047500121022     C                             MPSEMPG   <>  '20843-0'  and
047600121022     C                             MPSEMPG   <>  '20843-1'  and
047700121115     C                             MPSEMPG   <>  '18361'    and
047800121115     C                             MPSEMPG   <>  '183611'   and
047900121115     C                             MPSEMPG   <>  '183612'   and
048000121115     C                             MPSEMPG   <>  '183613'   and
048100121115     C                             MPSEMPG   <>  '183615'   and
048200121115     C                             MPSEMPG   <>  '183616'   and
048300121115     C                             MPSEMPG   <>  '18361625' and
048400121115     C                             MPSEMPG   <>  '18361626' and
048500121115     C                             MPSEMPG   <>  '18361-1'  and
048600121115     C                             MPSEMPG   <>  '18361-2'  and
048700121115     C                             MPSEMPG   <>  '18361-5'  and
048800121115     C                             MPSEMPG   <>  '18361-6'  and
048900121115     C                             MPSEMPG   <>  '18361-7'  and
049000121115     C                             MPSEMPG   <>  '18361-8'  and
049100121115     C                             MPSEMPG   <>  '18361-625' and
049200121115     C                             MPSEMPG   <>  '18361-626' and
049300100616     C                             MPSEMPG   <>  '17563-0'  And
049400100616     C                             MPSEMPG   <>  '17563-7'  And
049500100616     C                             MPSEMPG   <>  '17563-8'
049600100902      *
049700100902      * If there is an active rec for this member, don't send a term
049800100902     C                   Eval      ExportYN =    'Y'
049900100902     C                   If        CANDT    <    Today  AND CANDT <> *Zeros
050000100902     C                   Movel     MCSSNO        SSN
050100100902     C                   Movel     MDSEQ#        SEQNO
050200100902     C                   Movel     MCTRST        TRST
050300100902     C                   Movel     MCSUB#        SUB#
050400100902     C                   Movel     MCPLAN        PLAN
050500100902     C                   Call      'KLEX11R'
050600100902    ?C                   Parm                    SSN               9
050700100902     C                   Parm                    SEQNO             2
050800100902     C                   Parm                    TRST              3
050900100902     C                   Parm                    SUB#              3
051000100902     C                   Parm                    PLAN              4
051100100903     C                   Parm                    CC
051200100902    ?C                   Parm                    ExportYN          1
051300100902     C                   End
051400100902     C                   If        ExportYN  =   'Y'
051500090728     C                   Write     KLEXPR
051600100902     C                   Add       1             MemCtr            5 0
051700100607     C                   End
051800100902     C                   End
051900100513      * If the group number isn't in the KANEWG file, add it & email Kaiser.
052000100513      *
052100100513     C     AccKey        Chain     ACCMST
052200100513     C                   If        %Found(ACCMST)
052300100513     C                   Eval      Name      =   ACNAM1
052400100513     C                   Else
052500100513     C                   Eval      Name      =   NoAcctErrMsg
052600100513     C                   End
052700100513     C     MPSEMPG       Chain     KANEWG
052800100513     C                   If        Not %Found(KANEWG)
052900100513     C                   Eval      NSEMPG    =   MPSEMPG
053000100513     C                   Eval      NADDDT    =   Today
053100100513     C                   Eval      NADDUS    =   'KLEX10R'
053200100513     C                   Write     KANEWGR
053300100513     C                   Call      'KANEWCL'
053400100513     C                   Parm                    MPSEMPG
053500100513     C                   Parm                    Name             40
053600100513     C                   End
053700100513      *
053800091102     C                   End
053900090804     C                   Clear                   MemberFmt
054000090728     C                   Clear                   KLEXPR
054100100513      *
054200090729     C                   If        MCOVTP     <> 'TIN'
054300090804     C     DepKey2       Setll     DCOV22
054400090804     C     DepKey2       Reade     DCOV22                                 50
054500061121      *
054600061121    ?C     *In50         Doweq     *Off
054700091104     C                   Movel     CCANDT        EndDateN
054800100113     C                   Eval      DepTermSw  =  'N'
054900091123     C                   If        EndDateN    < Today     And
055000091123     C                             EndDateN   <> *Zero
055100091104     C                   Move      EndDateN      TrmDate
055200091104     C                   Movel     DSEQ#         Seq#
055300111011     C
055400091104     C     TrmKey        Chain     KLTRMP
055500091104     C                   If        %Found(KLTRMP)
055600091104     C                   Movel     'Y'           DepTermSw         1
055700091104     C                   Else
055800091104     C                   Move      DSEQ#         PTSEQ#
055900091104     C                   Exsr      TermRtn
056000091104     C                   End
056100091104     C                   End
056200091104      **********************
056300091104     C                   If        DepTermSw  =  'N'
056400090804     C                   Exsr      BuildDep
056500091104     C                   End
056600091104     C****************** End
056700091104     C****************** End
056800090804     C     DepKey2       Reade     DCOV22                                 50
056900061121    ?C                   Enddo
057000091123sz   C                   Z-add     *Zeros        Seq#
057100031126     C                   End
057200021007      *
057300021004    ?C                   Endsr
057400061120    ? *________________________________________________________________
057500061120    ? * Build Dependent Record
057600061120    ? *________________________________________________________________
057700061120    ?C     BuildDep      Begsr
057800061120      *
057900090804      * If member is Cobra, use the current effective date.  If not, use
058000090804      * the earliest effective date for this coverage p/D.A. 8/4/09 4:12pm.
058100090804      *
058200090804     C                   If        EMPST      =  Cobra
058300090804     C                   Eval      BeginDateN =  DENRDT
058400090804     C                   Eval      EndDateN   =  CCANDT
058500090804     C                   Else
058600090804     C                   Movel     MCTRST        Trust
058700090804     C                   Movel     MCSUB#        Sub
058800090804     C                   Movel     MCPLAN        Plan
058900090804     C                   Movel     MCSSNO        Social
059000090805     C                   Movel     DSEQ#         Seq
059100090804     C                   Eval      BeginDate  =  '00000000'
059200090804     C                   Eval      EndDate    =  '00000000'
059300090804     C                   Call      'ECOVDT2R'
059400090804     C                   Parm                    Trust
059500090804     C                   Parm                    Sub
059600090804     C                   Parm                    Plan
059700090804     C                   Parm                    Social
059800090805     C                   Parm                    Seq               2
059900090804     C                   Parm                    BeginDate
060000090804     C                   Parm                    EndDate
060100090804     C                   Parm                    Err
060200090804    ? *
060300090804     C                   Movel     BeginDate     BeginDateN
060400090804     C                   Movel     EndDate       EndDateN
060500090804     C                   End
060600091104      *---
060700091104      * If same-day term, there's no begin date.  Don't send an export record.
060800091104      *---
060900091104     C                   If        BeginDateN <> *Zeros
061000090804      *
061100090804     C     DepKey1       Chain     DEPNDC
061200061218     C                   Eval      MPRECID  =    'M'
061300090730     C                   Move      MBSSNO        MPSSSNO
061400090831     C                   Move      DSSNO         MPSSNO
061500090730     C                   Eval      MPSEX    =    DSEX
061600090730     C     DBIRTH        Mult      10000.0001    MPBIDT
061700090730     C                   Eval      MPLNAME  =    DLNAME
061800090730     C                   Eval      MPFNAME  =    DFNAME
061900090730     C                   Eval      MPMI     =    DMI
062000090804     C     EndDateN      Ifeq      99999999
062100061218     C                   Z-add     *Zeros        MPTEDT
062200061121     C                   Else
062300090804xxxx C     EndDateN      Mult      10000.0001    MPTEDT
062400090312      *---
062500090730      * If future term date > 30, fill w/zeros
062600090312      *---
062700090804     C                   If        BeginDateN <= Today    AND
062800090804     C                             EndDateN   >= Today    AND
062900090804     C                             EndDateN   <> 99999999 AND
063000090804     C                             EndDateN   <> *Zeros
063100090312      * Find the date 30 days before the term date.
063200090804     C     *ISO          Move      EndDateN      CalcDate
063300090312     C     CalcDate      Subdur    30:*d         ThirtyDays
063400090312     C                   Move      ThirtyDays    dqtodate30        8 0
063500090312      * Find the date 30 days into the future from today
063600090312     C     *ISO          Move      Today         CalcDate
063700090429     C     CalcDate      Adddur    30:*d         TodayPlus30
063800090312     C                   Move      TodayPlus30   Today30           8 0
063900090312     C                   Else
064000090312     C                   Z-add     *Zeros        dqtodate30
064100090312     C                   End
064200120629     C                   If        dqtodate30 >= Today    AND
064300120629     C                             dqtodate30 <= Today30
064400120629     C                                                    OR
064500120629     C                             EndDateN   <  Today
064600090804     C     EndDateN      Mult      10000.0001    MPTEDT
064700090429     C                   Else
064800090429     C                   Z-add     *Zeros        MPTEDT
064900090312     C                   End
065000090312      *---
065100090312      * End determining if term date is > 30 days from now.
065200090312      *---
065300090312     C                   End
065400090805     C     BeginDateN    Mult      10000.0001    MPEFDT
065500090831     C                   Move      DEPSS#        MPSSNO
065600061120     C                   Select
065700090730     C                   When      DRELCD   =    'RWI' Or                       Spouse
065800140702     C                             DRELCD   =    'RPA' OR
065900090730     C                             DRELCD   =    'RHU'                          Spouse
066000061218     C                   Eval      MPREL    =    %Trim('SP')                    Husband
066100061218     C                   Other                                                  Child,step,foster
066200061218     C                   Eval      MPREL    =    %Trim('DEP')                   Husband
066300061120     C                   EndSl
066400090827      *---
066500090827      * Get the group from the rate file
066600090827      *---
066700090831     C     RatKey        Setll     GRAT24
066800090831     C     RatKey        Reade     GRAT24
066900090831     C                   Dow       Not %Eof(GRAT24)
067000091019
067100120214      * Subtract 1 day from the depend coverage date to find the group#
067200120214     C                   If        CCANDT   <>   *Zeros
067300120214     C     *ISO          Move      CCANDT        CalcDate1
067400120214     C     CalcDate1     Subdur    1:*d          PrevDay
067500120214     C                   Move      PrevDay       CCandtm1          8 0
067600120214     C                   Else
067700120214     C                   Eval      CCandtm1  =   *Zeros
067800120214     C                   End
067900120214
068000091019     C                   Select
068100091019
068200091019      * ignore same day terms
068300091019     C                   When      FRMDAT  =   TODAT
068400091019
068500091019      * Active
068600120214     C                   When      CCandtm1 =  *Zeros or
068700120214     C                             CCandtm1 >= Today
068800100618     C                   If        Today  <=  TODAT
068900110705     C                   If        GRDLTD <>  'D'
069000091019     C                   Exsr      FormatGroup
069100091019     C                   Leave
069200091019     C                   End
069300110705     C                   End
069400091019
069500091019      * Termed
069600120214     C                   When      CCandtm1 <> *Zeros
069700120214     C                   If        (CCandtm1 >=  FRMDAT) and
069800120214     C                             (CCandtm1 <=  TODAT)
069900110705     C                   If        GRDLTD <>  'D'
070000091019     C                   Exsr      FormatGroup
070100091019     C                   Leave
070200091019     C                   End
070300110705     C                   End
070400091019     C                   Endsl
070500091019
070600090831     c     RatKey        Reade     GRAT24
070700090827     C                   EndDo
070800070102     C                   Eval      MPSUBPC  =    *Blanks
070900070103     C                   Eval      MPMEMPC  =    '         *'
071000090730     C                   Eval      MPADD1   =    %Trim(DADDR1)
071100090730     C                   Eval      MPADD2   =    %Trim(DADDR2)
071200090730     C                   Eval      MPCITY   =    %Trim(DCITY)
071300090730     C                   Eval      MPSTATE  =    %Trim(DSTATE)
071400090730     C                   Movel     DZIP          MPZIP
071500090730     C                   Movel     DAREA         MPHPHON
071600090730     C                   Move      DPHONE        MPHPHON
071700061221      *---
071800061221      *  Move subscriber's address data here since there's no dep addr rec
071900061221      *---
072000090730     C                   Eval      MPADD1   =    ADDR1
072100090730     C                   Eval      MPADD2   =    ADDR2
072200090730     C                   Eval      MPCITY   =    CITY
072300090730     C                   Eval      MPSTATE  =    STATE
072400090730     C                   Movel     ZIP           MPZIP
072500090730     C                   Movel     AREA          MPHPHON
072600090730     C                   Move      PHONE         MPHPHON
072700090804     C                   Eval      KLDATA   =    MemberFmt
072800091102     C     KLDATA        Chain     KLEXP
072900091102     C                   If        Not %Found(KLEXP)
073000100607     C                   If        MPSEMPG   <>  '4761-1' And
073100100616     C                             MPSEMPG   <>  '4761-4' And
073200130204     C                             MPSEMPG   <>  '22155-0'  And
073300130204     C                             MPSEMPG   <>  '22155-1'  And
073400121019     C                             MPSEMPG   <>  '20843-1'  and
073500121019     C                             MPSEMPG   <>  '20897-0'  and
073600121019     C                             MPSEMPG   <>  '20897-1'  and
073700121019     C                             MPSEMPG   <>  '20897-2'  and
073800121019     C                             MPSEMPG   <>  '20897-3'  and
073900121019     C                             MPSEMPG   <>  '20897-4'  and
074000121022     C                             MPSEMPG   <>  '20843-0'  and
074100121022     C                             MPSEMPG   <>  '20843-1'  and
074200121115     C                             MPSEMPG   <>  '18361'    and
074300121115     C                             MPSEMPG   <>  '183611'   and
074400121115     C                             MPSEMPG   <>  '183612'   and
074500121115     C                             MPSEMPG   <>  '183613'   and
074600121115     C                             MPSEMPG   <>  '183615'   and
074700121115     C                             MPSEMPG   <>  '183616'   and
074800121115     C                             MPSEMPG   <>  '18361625' and
074900121115     C                             MPSEMPG   <>  '18361626' and
075000121115     C                             MPSEMPG   <>  '18361-1'  and
075100121115     C                             MPSEMPG   <>  '18361-2'  and
075200121115     C                             MPSEMPG   <>  '18361-5'  and
075300121115     C                             MPSEMPG   <>  '18361-6'  and
075400121115     C                             MPSEMPG   <>  '18361-7'  and
075500121115     C                             MPSEMPG   <>  '18361-8'  and
075600121115     C                             MPSEMPG   <>  '18361-625' and
075700121115     C                             MPSEMPG   <>  '18361-626' and
075800100616     C                             MPSEMPG   <>  '17563-0'  And
075900100616     C                             MPSEMPG   <>  '17563-7'  And
076000100616     C                             MPSEMPG   <>  '17563-8'
076100100902      *
076200100902      * If there is an active rec for this member, don't send a term
076300100902     C                   Eval      ExportYN =    'Y'
076400100902     C                   If        CCANDT   <    Today  AND CCANDT <> *Zeros
076500100902     C                   Movel     SSNO          SSN
076600100902     C                   Movel     DSEQ#         SEQNO
076700100902     C                   Movel     DVTRST        TRST
076800100902     C                   Movel     DVSUB#        SUB#
076900100902     C                   Movel     DVPLAN        PLAN
077000100902     C                   Call      'KLEX11R'
077100100902    ?C                   Parm                    SSN
077200100902     C                   Parm                    SEQNO
077300100902     C                   Parm                    TRST
077400100902     C                   Parm                    SUB#
077500100902     C                   Parm                    PLAN
077600100903     C                   Parm                    CC
077700100902    ?C                   Parm                    ExportYN
077800100902     C                   End
077900100902     C                   If        ExportYN  =   'Y'
078000091102     C                   Write     KLEXPR
078100100902     C                   Add       1             MemCtr            5 0
078200100607     C                   End
078300100902     C                   End
078400091102     C                   End
078500100902     C***************    Add       1             MemCtr            5 0
078600090804     C                   Clear                   MemberFmt
078700090728     C                   Clear                   KLEXPR
078800091104      *
078900091104     C                   End
079000091104      *
079100061120    ?C                   Endsr
079200061218    ? *________________________________________________________________
079300061218    ? * Create and write Header record first.
079400061218    ? *________________________________________________________________
079500061218    ?C     HeaderSr      Begsr
079600061218     C                   Eval      HPRECID  =    'H'
079700090730     C                   Eval      HPGRPNM  =    %Trim('MAS ')
079800061218     C                   Eval      HPRECNT  =    MemCtr
079900061218     C                   Eval      HPFPFI   =    'F'
080000061218     C     Today         Mult      10000.0001    HPFCDT
080100090728     C                   Eval      KLDATA2  =    Header
080200090730     C                   Write     KLEXPR2
080300090730     C                   Clear                   KLEXPR2
080400061218     C                   EndSr
080500061218    ? *________________________________________________________________
080600061218    ? * Create and write Member records after the Header record.
080700061218    ? *________________________________________________________________
080800061218    ?C     MemberSr      Begsr
080900090728     C                   Open      KLEXP
081000090728     C                   Read      KLEXP
081100090728     C                   Dou       %Eof(KLEXP)
081200090728     C                   Eval      DSRec    =    KLDATA
081300061218     C                   If        DSRecTyp =    'M'
081400090728     C                   Eval      KLDATA2  =    DSRec
081500090804     C                   Write     KLEXPR2
081600090804     C                   Clear                   KLEXPR2
081700061218     C                   End
081800090728     C                   Read      KLEXP
081900061218     C                   EndDo
082000090728     C                   Close     KLEXP
082100061218     C                   EndSr
082200061218    ? *________________________________________________________________
082300061218    ? * Create and write Footer record last.
082400061218    ? *________________________________________________________________
082500061218    ?C     FooterSr      Begsr
082600061218     C                   Eval      FPRECID  =    'F'
082700090730     C                   Eval      FPGRPNM  =    %Trim('MAS ')
082800061218     C                   Eval      FPRECNT  =    MemCtr
082900061218     C                   Eval      FPFPFI   =    'F'
083000061218     C     Today         Mult      10000.0001    FPFCDT
083100090728     C                   Eval      KLDATA2  =    Footer
083200090728     C                   Write     KLEXPR2
083300090728     C                   Clear                   KLEXPR2
083400061218     C                   EndSr
083500090303    ? *________________________________________________________________
083600090303    ? * For termed coverage
083700090303    ? *________________________________________________________________
083800090303    ?C     TermRtn       Begsr
083900090805     C                   Eval      PTTRUST    =  MCTRST
084000090805     C                   Eval      PTSUB#     =  MCSUB#
084100090805     C                   Eval      PTACCT     =  ACC#
084200090303     C                   Eval      PTPDTP     =  Today
084300090728     C                   Eval      PTPLAN     =  MCPLAN
084400090728     C                   Eval      PTCOV      =  MCOVTP
084500090805     C                   Move      MCSSNO        PTSSNO
084600120214     C****************   If        MCOVTP     <> 'TIN'
084700120214     C****************   Eval      PTSEQ#     =  DSEQ#
084800120214     C****************   Else
084900120214     C****************   Eval      PTSEQ#     =  MDSEQ#
085000120214     C****************   End
085100090805     C                   Eval      PTTRDT     =  EndDateN
085200090728     C                   Write     KLTRMR
085300090728     C                   Clear                   KLTRMR
085400090303    ?C                   Endsr
085500090908    ? *________________________________________________________________
085600090908    ? * Split groups based on Jackie Livingston's 9/8/09 email 9 am
085700090908    ? *________________________________________________________________
085800090908    ?C     FormatGroup   Begsr
085900090908    ? *
086000090908     C                   Select
086100090908     C                   When      GROUP#   =    '102165'
086200090908     C                   Eval      MPSEMPG  =    %Trim('10216-5')
086300090908     C                   When      GROUP#   =    '102166'
086400090908     C                   Eval      MPSEMPG  =    %Trim('10216-6')
086500090908     C                   When      GROUP#   =    '102167'
086600090908     C                   Eval      MPSEMPG  =    %Trim('10216-7')
086700090908     C                   When      GROUP#   =    '102168'
086800090908     C                   Eval      MPSEMPG  =    %Trim('10216-8')
086900090908      *
087000090908     C                   When      GROUP#   =    '147512'
087100090908     C                   Eval      MPSEMPG  =    %Trim('1475-12')
087200090908     C                   When      GROUP#   =    '147513'
087300090908     C                   Eval      MPSEMPG  =    %Trim('1475-13')
087400090908     C                   When      GROUP#   =    '147514'
087500090908     C                   Eval      MPSEMPG  =    %Trim('1475-14')
087600090908     C                   When      GROUP#   =    '147515'
087700090908     C                   Eval      MPSEMPG  =    %Trim('1475-15')
087800100113    ? *
087900100113     C                   When      GROUP#   =    '1756300'
088000100113     C                   Eval      MPSEMPG  =    %Trim('17563-0')
088100100113     C                   When      GROUP#   =    '1756310'
088200100113     C                   Eval      MPSEMPG  =    %Trim('17563-1')
088300100113     C                   When      GROUP#   =    '1756330'
088400100113     C                   Eval      MPSEMPG  =    %Trim('17563-3')
088500100113     C                   When      GROUP#   =    '1756340'
088600100113     C                   Eval      MPSEMPG  =    %Trim('17563-4')
088700100113     C                   When      GROUP#   =    '1756370'
088800100113     C                   Eval      MPSEMPG  =    %Trim('17563-7')
088900100113     C                   When      GROUP#   =    '1756380'
089000100113     C                   Eval      MPSEMPG  =    %Trim('17563-8')
089100100113     C                   When      GROUP#   =    '1756390'
089200100113     C                   Eval      MPSEMPG  =    %Trim('17563-9')
089300090908    ? *
089400090908     C                   When      GROUP#   =    '179550'
089500090908     C                   Eval      MPSEMPG  =    %Trim('17955-0')
089600090908     C                   When      GROUP#   =    '179551'
089700090908     C                   Eval      MPSEMPG  =    %Trim('17955-1')
089800090908     C                   When      GROUP#   =    '179552'
089900090908     C                   Eval      MPSEMPG  =    %Trim('17955-2')
090000090908     C                   When      GROUP#   =   '179553'
090100090908     C                   Eval      MPSEMPG  =    %Trim('17955-3')
090200090908     C                   When      GROUP#   =   '179554'
090300090908     C                   Eval      MPSEMPG  =    %Trim('17955-4')
090400090908     C                   When      GROUP#   =   '179555'
090500090908     C                   Eval      MPSEMPG  =    %Trim('17955-5')
090600090908      *
090700090908     C                   When      GROUP#   =   '183611'
090800090908     C                   Eval      MPSEMPG  =    %Trim('18361-1')
090900090908     C                   When      GROUP#   =    '183612'
091000090908     C                   Eval      MPSEMPG  =    %Trim('18361-2')
091100090908     C                   When      GROUP#   =    '183615'
091200090908     C                   Eval      MPSEMPG  =    %Trim('18361-5')
091300090908     C                   When      GROUP#   =    '183616'
091400090908     C                   Eval      MPSEMPG  =    %Trim('18361-6')
091500090908     C                   When      GROUP#   =    '18361625'
091600090908     C                   Eval      MPSEMPG  =    %Trim('18361-625')
091700090908     C                   When      GROUP#   =    '18361626'
091800090908     C                   Eval      MPSEMPG  =    %Trim('18361-626')
091900090908    ? *
092000090908     C                   When      GROUP#   =    '186340'
092100090908     C                   Eval      MPSEMPG  =    %Trim('18634-0')
092200090908     C                   When      GROUP#   =    '186341'
092300091102     C                   Eval      MPSEMPG  =    %Trim('18634-1')
092400090908     C                   When      GROUP#   =    '186342'
092500090908     C                   Eval      MPSEMPG  =    %Trim('18634-2')
092600090908     C                   When      GROUP#   =    '1863410'
092700090908     C                   Eval      MPSEMPG  =    %Trim('18634-10')
092800090908     C                   When      GROUP#   =    '1863411'
092900090908     C                   Eval      MPSEMPG  =    %Trim('18634-11')
093000090908     C                   When      GROUP#   =    '1863412'
093100090908     C                   Eval      MPSEMPG  =    %Trim('18634-12')
093200091113    ? *
093300091113     C                   When      GROUP#   =    '1880900'
093400091113     C                   Eval      MPSEMPG  =    %Trim('18809-0')
093500091113     C                   When      GROUP#   =    '1880910'
093600091113     C                   Eval      MPSEMPG  =    %Trim('18809-1')
093700091113     C                   When      GROUP#   =    '1880930'
093800091113     C                   Eval      MPSEMPG  =    %Trim('18809-3')
093900091113     C                   When      GROUP#   =    '1880940'
094000091113     C                   Eval      MPSEMPG  =    %Trim('18809-4')
094100091113     C                   When      GROUP#   =    '18809100'
094200091113     C                   Eval      MPSEMPG  =    %Trim('18809-10')
094300091113     C                   When      GROUP#   =    '18809110'
094400091113     C                   Eval      MPSEMPG  =    %Trim('18809-11')
094500091113     C                   When      GROUP#   =    '18809130'
094600091113     C                   Eval      MPSEMPG  =    %Trim('18809-13')
094700091113     C                   When      GROUP#   =    '18809140'
094800091113     C                   Eval      MPSEMPG  =    %Trim('18809-14')
094900090908    ? *
095000090908     C                   When      GROUP#   =    '188650'
095100090908     C                   Eval      MPSEMPG  =    %Trim('18865-0')
095200090908     C                   When      GROUP#   =    '188651'
095300090908     C                   Eval      MPSEMPG  =    %Trim('18865-1')
095400090908     C                   When      GROUP#   =    '188652'
095500090908     C                   Eval      MPSEMPG  =    %Trim('18865-2')
095600090908     C                   When      GROUP#   =    '1886510'
095700090908     C                   Eval      MPSEMPG  =    %Trim('18865-10')
095800090908     C                   When      GROUP#   =    '1886511'
095900090908     C                   Eval      MPSEMPG  =    %Trim('18865-11')
096000090908     C                   When      GROUP#   =    '1886512'
096100090908     C                   Eval      MPSEMPG  =    %Trim('18865-12')
096200090908    ? *
096300090908     C                   When      GROUP#   =    '196150'
096400090908     C                   Eval      MPSEMPG  =    %Trim('19615-0')
096500090908     C                   When      GROUP#   =    '196151'
096600090908     C                   Eval      MPSEMPG  =    %Trim('19615-1')
096700090908     C                   When      GROUP#   =    '196152'
096800090908     C                   Eval      MPSEMPG  =    %Trim('19615-2')
096900090908     C                   When      GROUP#   =    '1961510'
097000090908     C                   Eval      MPSEMPG  =    %Trim('19615-10')
097100090908     C                   When      GROUP#   =    '1961511'
097200090908     C                   Eval      MPSEMPG  =    %Trim('19615-11')
097300090908     C                   When      GROUP#   =    '1961512'
097400090908     C                   Eval      MPSEMPG  =    %Trim('19615-12')
097500090908    ? *
097600090908     C                   When      GROUP#   =    '196700'
097700090908     C                   Eval      MPSEMPG  =    %Trim('19670-0')
097800090908     C                   When      GROUP#   =    '196701'
097900090908     C                   Eval      MPSEMPG  =    %Trim('19670-1')
098000090908     C                   When      GROUP#   =    '196702'
098100090908     C                   Eval      MPSEMPG  =    %Trim('19670-2')
098200090908     C                   When      GROUP#   =    '196703'
098300090908     C                   Eval      MPSEMPG  =    %Trim('19670-3')
098400090908     C                   When      GROUP#   =    '1967010'
098500090908     C                   Eval      MPSEMPG  =    %Trim('19670-10')
098600090908     C                   When      GROUP#   =    '1967011'
098700090908     C                   Eval      MPSEMPG  =    %Trim('19670-11')
098800090908     C                   When      GROUP#   =    '1967012'
098900090908     C                   Eval      MPSEMPG  =    %Trim('19670-12')
099000090908     C                   When      GROUP#   =    '1967013'
099100090908     C                   Eval      MPSEMPG  =    %Trim('19670-13')
099200090908     C                   When      GROUP#   =    '19670690'
099300090908     C                   Eval      MPSEMPG  =    %Trim('19670-690')
099400090908     C                   When      GROUP#   =    '19670691'
099500090908     C                   Eval      MPSEMPG  =    %Trim('19670-691')
099600090908    ? *
099700091020     C                   When      GROUP#   =    '196710'
099800091020     C                   Eval      MPSEMPG  =    %Trim('19671-0')
099900091020     C                   When      GROUP#   =    '196711'
100000091020     C                   Eval      MPSEMPG  =    %Trim('19671-1')
100100091020     C                   When      GROUP#   =    '1967110'
100200091020     C                   Eval      MPSEMPG  =    %Trim('19671-10')
100300091020     C                   When      GROUP#   =    '1967111'
100400091020     C                   Eval      MPSEMPG  =    %Trim('19671-11')
100500091020    ? *
100600090908     C                   When      GROUP#   =    '198600'
100700090908     C                   Eval      MPSEMPG  =    %Trim('19860-0')
100800090908     C                   When      GROUP#   =    '19860'
100900090908     C                   Eval      MPSEMPG  =    %Trim('19860-0')
101000090908     C                   When      GROUP#   =    '198601'
101100090908     C                   Eval      MPSEMPG  =    %Trim('19860-1')
101200090908    ? *
101300090908     C                   When      GROUP#   =    '2016500'
101400090908     C                   Eval      MPSEMPG  =    %Trim('20165-0')
101500090908     C                   When      GROUP#   =    '201650'
101600090908     C                   Eval      MPSEMPG  =    %Trim('20165-0')
101700090908     C                   When      GROUP#   =    '201651'
101800090908     C                   Eval      MPSEMPG  =    %Trim('20165-1')
101900090908     C                   When      GROUP#   =    '201652'
102000090908     C                   Eval      MPSEMPG  =    %Trim('20165-2')
102100090908     C                   When      GROUP#   =    '201653'
102200090908     C                   Eval      MPSEMPG  =    %Trim('20165-3')
102300090908     C                   When      GROUP#   =    '2016510'
102400090908     C                   Eval      MPSEMPG  =    %Trim('20165-10')
102500090908     C                   When      GROUP#   =    '2016511'
102600090908     C                   Eval      MPSEMPG  =    %Trim('20165-11')
102700090908     C                   When      GROUP#   =    '2016512'
102800090908     C                   Eval      MPSEMPG  =    %Trim('20165-12')
102900090908     C                   When      GROUP#   =    '2016513'
103000090908     C                   Eval      MPSEMPG  =    %Trim('20165-13')
103100090908    ? *
103200090908     C                   When      GROUP#   =    '2020800'
103300090908     C                   Eval      MPSEMPG  =    %Trim('20208-0')
103400090908     C                   When      GROUP#   =    '202080'
103500090908     C                   Eval      MPSEMPG  =    %Trim('20208-0')
103600090908     C                   When      GROUP#   =    '202081'
103700090908     C                   Eval      MPSEMPG  =    %Trim('20208-1')
103800090908     C                   When      GROUP#   =    '202082'
103900090908     C                   Eval      MPSEMPG  =    %Trim('20208-2')
104000090908     C                   When      GROUP#   =    '2020810'
104100090908     C                   Eval      MPSEMPG  =    %Trim('20208-10')
104200090908     C                   When      GROUP#   =    '2020811'
104300090908     C                   Eval      MPSEMPG  =    %Trim('20208-11')
104400090908     C                   When      GROUP#   =    '2020812'
104500090908     C                   Eval      MPSEMPG  =    %Trim('20208-12')
104600100810     C                   When      GROUP#   =    '2020813'
104700100810     C                   Eval      MPSEMPG  =    %Trim('20208-13')
104800110705     C                   When      GROUP#   =    '2020814'
104900110705     C                   Eval      MPSEMPG  =    %Trim('20208-14')
105000100811     C                   When      GROUP#   =    '2020815'
105100100811     C                   Eval      MPSEMPG  =    %Trim('20208-15')
105200090908    ? *
105300090908     C                   When      GROUP#   =    '202550'
105400090908     C                   Eval      MPSEMPG  =    %Trim('20255-0')
105500090908     C                   When      GROUP#   =    '202551'
105600090908     C                   Eval      MPSEMPG  =    %Trim('20255-1')
105700090908     C                   When      GROUP#   =    '202552'
105800090908     C                   Eval      MPSEMPG  =    %Trim('20255-2')
105900111208    ? *                                                                         SSK
106000111208     C                   When      GROUP#   =    '20545-5 '  AND                SSK
106100111208     C                             MCOVTP   =    'TIN'                          SSK
106200111208     C                   Eval      MPSEMPG  =    %Trim('20255-6')               SSK
106300111208     C                   When      GROUP#   =    '20545-5 '  AND                SSK
106400111208     C                             MCOVTP   <>   'TIN'                          SSK
106500111208     C                   Eval      MPSEMPG  =    %Trim('20255-7')               SSK
106600091124    ? *
106700100113     C                   When      GROUP#   =    '204040'
106800100113     C                   Eval      MPSEMPG  =    %Trim('20404-0')
106900100113     C                   When      GROUP#   =    '204041'
107000100113     C                   Eval      MPSEMPG  =    %Trim('20404-1')
107100091124     C                   When      GROUP#   =    '204042'
107200091124     C                   Eval      MPSEMPG  =    %Trim('20404-2')
107300091124     C                   When      GROUP#   =    '204043'
107400091124     C                   Eval      MPSEMPG  =    %Trim('20404-3')
107500091124     C                   When      GROUP#   =    '204047'
107600091124     C                   Eval      MPSEMPG  =    %Trim('20404-7')
107700090908      *
107800091013     C                   Other
107900091013      *------------------------------------------------------------*
108000091013     C                   Eval      MPSEMPG  =    GROUP#
108100091013      *------------------------------------------------------------*
108200090908     C                   EndSl
108300090908    ?C                   Endsr
108400090805    ? *________________________________________________________________
108500090805    ? * Determine if termed coverage has been sent once
108600090805    ? *________________________________________________________________
108700090805    ?C     DetermTerm    Begsr
108800090805    ? *
108900090805     C                   Movel     CANDT         TrmDate
109000090805     C                   Movel     'N'           TermSw            1
109100090805     C                   If        CANDT     <   Today  And
109200090805     C                             CANDT     <>  *Zero
109300111011      *---
109400111011      * If account is termed for BOR (TC=#), don't sent the termed record
109500111011      *---
109600111011     C     AccKey        Chain     KLEX12P
109700111012     C                   If        %Found(KLEX12P)
109800111011     C     AccKey        Chain     ACCMST
109900111025      * Carol F said we cannot look at the account term date because
110000111025      *  the account may not yet be termed.
110100111025     C*********          If        ATRMDT  <>    *Zero
110200111011     C                   Movel     'Y'           TermSw
110300111011     C                   LeaveSr
110400111025     C**********         End
110500111012     C                   End
110600111011      *
110700090805     C     TrmKey        Chain     KLTRMP
110800090805     C                   If        %Found(KLTRMP)
110900090805     C                   Movel     'Y'           TermSw
111000090805     C                   Else
111100090805     C                   Movel     CANDT         EndDateN
111200120214     C                   Eval      PTSEQ#     =  MDSEQ#
111300090805     C                   Exsr      TermRtn
111400090805     C                   End
111500090805     C                   End
111600090805     C                   Clear                   TrmDate
111700090805     C                   EndSr
111800051129    ? *________________________________________________________________
111900051129    ? * Key Lists
112000051129    ? *________________________________________________________________
112100051129    ?C     Klist         Begsr
112200051129    ? *
112300090804     C     DepKey1       Klist
112400090804     C                   Kfld                    MCSSNO
112500090805     C                   Kfld                    DSEQ#
112600090804    ? *
112700090804     C     DepKey2       Klist
112800090804     C                   Kfld                    MCTRST
112900090804     C                   Kfld                    MCSUB#
113000090804     C                   Kfld                    MCPLAN
113100090804     C                   Kfld                    MCSSNO
113200090303    ? *
113300090729     C     CovKey        KLIST
113400090729     C                   Kfld                    PLTRST
113500090729     C                   Kfld                    PLSUB#
113600090729     C                   Kfld                    PLPLAN
113700090729    ? *
113800090303     C     TrmKey        Klist
113900090804     C                   Kfld                    MCTRST
114000090728     C                   Kfld                    MCSUB#
114100090804     C                   Kfld                    ACC#
114200090805     C                   Kfld                    MCSSNO
114300090805     C                   Kfld                    Seq#
114400090303     C                   Kfld                    TrmDate
114500100513    ? *
114600100513     C     AccKey        Klist
114700100513     C                   Kfld                    MCTRST
114800100513     C                   Kfld                    MCSUB#
114900100513     C                   Kfld                    ACC#
115000090827    ? *
115100090827     C     RatKey        Klist
115200090827     C                   Kfld                    MCTRST
115300090827     C                   Kfld                    MCSUB#
115400090827     C                   Kfld                    MCPLAN
115500111011    ? *
115600061121    ?C                   Endsr
115700020726    ? *________________________________________________________________
115800020726    ? * Initialization
115900020726    ? *________________________________________________________________
116000001003    ?C     *INZSR        Begsr
116100090728     C                   Open      KLEXP
116200021007     C     *DATE         Mult      10000.0001    Today             8 0
116300051129     C                   Z-add     99999999      HighDate          8 0
116400061218     C                   Movel     *Blanks       Kaiser           50
116500061218     C                   Eval      Kaiser    =   '000080008'
116600001003    ?C                   Endsr
