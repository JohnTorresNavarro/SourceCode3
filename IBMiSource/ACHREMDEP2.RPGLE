000100140623     Hoption(*nodebugio) dftactgrp(*no) actgrp(*caller) bnddir('ALLSRVPGMN')
000200000000      *_________________________________________________________________________
000300000000      *
000400120530      *  Description:  Load ACH Bank Remote On-demand Deposit from Spreadsheet
000500000000      *
000600120530      *  (c)Copyright 2012 by GBS, Inc.
000700000000      *
000800120530      *    Created by:  szz  5/30/2012
000900080303      *
001000120601      * Notes:  Lilliane has requested that the date input to this
001100120601      *         program should have 3 business days added to it and
001200120601      *         bank holidays must be taken into consideration.
001300120601      * If the day is:
001400120601      *  Sun     Mon     Tue     Wed     Thu     Fri    Sat
001500120601      * Add this number of days to get this day:
001600120601      * +3=W     +3=Th   +3=F    +5=M    +5=T    +5=W   +4=W
001700120607      *
001800120607      * 06/07/12 szz Linda B. requested to remove the invoice#.
001900131025      * 10/23/12 DPB Externalize holidays into table and use external
002000131025      *              functions to check if banking holiday.  Simplify RATOT
002100131025      *              formatting via %dec function, simplify date logic.
002200000000      *_________________________________________________________________________
002300110901     FACHREMP   IF   E             DISK
002400110901     FACHREMOTE2O    E             DISK
002500131023
002600110901     D                 DS
002700120604     D PullBatch               1     12    Inz
002800120604     D PullD1B                 1      3
002900120604     D PullBB                  4      5    Inz
003000120604     D PullMM                  6      7    Inz
003100120604     D PullDD                  8      9    Inz
003200120604     D Pulldp                 10     10    Inz
003300120604     D PullYY                 11     12
003400131023
003500120604     D                 DS
003600120604     D FmtBatch                1     10    Inz
003700120604     D FmtBB                   1      2    Inz
003800120604     D FmtMM                   3      4    Inz
003900120604     D FmtDD                   5      6    Inz
004000120531
004100120601     D                 DS
004200120531     D RAPULout                1      8S 0 Inz
004300120601     D  RAccout                1      2S 0 Inz
004400120601     D  RAyyout                3      4S 0 Inz
004500120601     D  RAmmout                5      6S 0 Inz
004600120601     D  RAddout                7      8S 0 Inz
004700110901
004800110907    ?D CalcDate        S               D   Datfmt(*ISO)                         Input Request
004900120601     D ThreeMoreDay    S               D   Datfmt(*ISO)
005000120601     D FourMoreDay     S               D   Datfmt(*ISO)
005100120601     D FiveMoreDay     S               D   Datfmt(*ISO)
005200120705     D OneMoreDay      S               D   Datfmt(*ISO)
005300120705     D TwoMoreDay      S               D   Datfmt(*ISO)
005400120705     D SixMoreDay      S               D   Datfmt(*ISO)
005500120601     D SevMoreDay      S               D   Datfmt(*ISO)
005600110909    ?D PullYMD8ISO     S               D   datfmt(*ISO)                         Input Request
005700120705     D ExtraDay        S               D   Datfmt(*ISO)
005800120601
005900131023     D My_date         S               D
006000110901
006100131022      /define Copy_all_protos_and_fields
006200131022      /copy qcpysrc,datsrvpgmp
006300131022      /Undefine Copy_all_protos_and_fields
006400131022
006500110901     C                   Read      ACHREMP
006600110901     C                   Dou       %Eof(ACHREMP)
006700120530      *
006800120530      * Skip the total record...the TSA field does not contain the TSA
006900120530     C                   If        RATSA    <>   'II1200892'
007000120531      * Add three business days to the RAPUL date.
007100120531     C                   Exsr      Add3Days
007200110901      *
007300110901      * Acct#: use GBS TSA
007400110901     C                   Evalr     BKACCT   =    %Trim(RATSA)
007500071029      *
007600110901      * inv #: use transaction date
007700120607     C                   Clear                   BKINV
007800071029      *
007900110420      * seq #
008000110920     C                   Add       1             BKSEQ
008100131022
008200131022      * field RATOT is alpha with formatting - convert to dec field bkamt
008300131022     C                   eval      bkamt = %dec(ratot:8:2)
008400131022
008500120604      * check #  (After posting, this will appear in the history Note1.
008600120604     C                   Movel     RADVZ         PullBatch
008700120604     C                   Exsr      XlateBatch
008800120604     C                   Movel     PullMM        FmtMM
008900120604     C                   Movel     PullDD        FmtDD
009000120604     C                   Movel     FmtBatch      BKCHK#
009100120604     C                   Move      BKSEQ         BKCHK#
009200071029
009300110420      * receive date
009400071025     C                   Exsr      FmtXferDate
009500131022
009600110901     C                   Write     ACHREMOTER
009700120530     C                   End
009800110901     C                   Read      ACHREMP
009900131022
010000070713     C                   EndDo
010100070713     C                   Eval      *InLR     =   *On
010200120604    ? *________________________________________________________________
010300120604    ? * Translate the batch from letters to digits
010400120604    ? *________________________________________________________________
010500120604    ?C     XlateBatch    Begsr
010600120604     C                   Select
010700120604     C                   When      PullBB    =   'AA'
010800120604     C                   Eval      FmtBB     =   '01'
010900120604     C                   When      PullBB    =   'AB'
011000120604     C                   Eval      FmtBB     =   '02'
011100120604     C                   When      PullBB    =   'AC'
011200120604     C                   Eval      FmtBB     =   '03'
011300120604     C                   When      PullBB    =   'AD'
011400120604     C                   Eval      FmtBB     =   '04'
011500120604     C                   When      PullBB    =   'AE'
011600120604     C                   Eval      FmtBB     =   '05'
011700120604     C                   When      PullBB    =   'AF'
011800120604     C                   Eval      FmtBB     =   '06'
011900120604     C                   When      PullBB    =   'AG'
012000120604     C                   Eval      FmtBB     =   '07'
012100120604     C                   When      PullBB    =   'AH'
012200120604     C                   Eval      FmtBB     =   '08'
012300120604     C                   When      PullBB    =   'AI'
012400120604     C                   Eval      FmtBB     =   '09'
012500120604     C                   When      PullBB    =   'AJ'
012600120604     C                   Eval      FmtBB     =   '10'
012700120604     C                   When      PullBB    =   'AK'
012800120604     C                   Eval      FmtBB     =   '11'
012900120604     C                   When      PullBB    =   'AL'
013000120604     C                   Eval      FmtBB     =   '12'
013100120604     C                   When      PullBB    =   'AM'
013200120604     C                   Eval      FmtBB     =   '13'
013300120604     C                   When      PullBB    =   'AN'
013400120604     C                   Eval      FmtBB     =   '14'
013500120604     C                   When      PullBB    =   'AO'
013600120604     C                   Eval      FmtBB     =   '15'
013700120604     C                   When      PullBB    =   'AP'
013800120604     C                   Eval      FmtBB     =   '16'
013900120604     C                   When      PullBB    =   'AQ'
014000120604     C                   Eval      FmtBB     =   '17'
014100120604     C                   When      PullBB    =   'AR'
014200120604     C                   Eval      FmtBB     =   '18'
014300120604     C                   When      PullBB    =   'AS'
014400120604     C                   Eval      FmtBB     =   '19'
014500120604     C                   When      PullBB    =   'AT'
014600120604     C                   Eval      FmtBB     =   '20'
014700120604     C                   When      PullBB    =   'AU'
014800120604     C                   Eval      FmtBB     =   '21'
014900120604     C                   When      PullBB    =   'AV'
015000120604     C                   Eval      FmtBB     =   '22'
015100120604     C                   When      PullBB    =   'AW'
015200120604     C                   Eval      FmtBB     =   '23'
015300120604     C                   When      PullBB    =   'AX'
015400120604     C                   Eval      FmtBB     =   '24'
015500120604     C                   When      PullBB    =   'AY'
015600120604     C                   Eval      FmtBB     =   '25'
015700120604     C                   When      PullBB    =   'AZ'
015800120604     C                   Eval      FmtBB     =   '26'
015900120604     C                   EndSl
016000120604    ?C                   Endsr
016100071025    ? *________________________________________________________________
016200071025    ? * Reformat the Transfer Date into the Receive Date
016300071025    ? *________________________________________________________________
016400071025    ?C     FmtXferDate   Begsr
016500071025    ? *
016600120531      *Per Lilliane & Linda B., we should use THREE business days from
016700120531      * the day in the file per meeting 5/31/12 2:30.
016800110907     C                   Move      PullYMD8      BKRCVDT
016900071025    ?C                   Endsr
017000071025    ? *
017100120531    ? *___________________________________________________________________
017200120531     C     Add3Days      BEGSR
017300120531    ? *___________________________________________________________________
017400231103     C                   eval      calcdate = %date(rapul:*mdy/)
017500120601     C                   Move      CalcDate      My_date
017600131025
017700120705     C     CalcDate      Adddur    1:*d          OneMoreDay
017800120705     C     CalcDate      Adddur    2:*d          TwoMoreDay
017900120531     C     CalcDate      Adddur    3:*d          ThreeMoreDay
018000120531     C     CalcDate      Adddur    4:*d          FourMoreDay
018100120601     C     CalcDate      Adddur    5:*d          FiveMoreDay
018200120601     C     CalcDate      Adddur    6:*d          SixMoreDay
018300120601     C     CalcDate      Adddur    7:*d          SevMoreDay
018400131022
018500131025     c                   if        #get_dow(calcdate) = 'Sunday' or
018600131025     C                             #get_dow(calcdate) = 'Monday' or
018700131025     C                             #get_dow(calcdate) = 'Tuesday'
018800120601     C                   Move      ThreeMoreDay  PullYMD8
018900131025     C                   if        #get_dow(calcdate) = 'Tuesday'
019000131025     C     ThreeMoreDay  Adddur    3:*d          ExtraDay
019100131025     C                   else
019200120705     C     ThreeMoreDay  Adddur    1:*d          ExtraDay
019300131025     C                   endif
019400131025
019500131025     c                   elseif    #get_dow(calcdate) = 'Wednesday' or
019600131025     c                             #get_dow(calcdate) = 'Thursday' or
019700131025     c                             #get_dow(calcdate) = 'Friday'
019800120601     C                   Move      FiveMoreDay   PullYMD8
019900120705     C     FiveMoreDay   Adddur    1:*d          ExtraDay
020000131025
020100131025     c                   elseif    #get_dow(calcdate) = 'Saturday'
020200120601     C                   Move      FourMoreDay   PullYMD8          8 0
020300120705     C     FourMoreDay   Adddur    1:*d          ExtraDay
020400131025     C                   Endif
020500131025
020600120705     C                   Exsr      Holiday
020700131022
020800120531      * Intercept Holiday Dates
020900120705      *         Monday thru Thursday holiday, add 1 more day.
021000120705     C                   If        PullYMD8 =    20120903  Or
021100120705     C                             PullYMD8 =    20120704  Or
021200120705     C                             PullYMD8 =    20121008  Or
021300120705     C                             PullYMD8 =    20121112  Or
021400120705     C                             PullYMD8 =    20121225  Or
021500120705     C                             PullYMD8 =    20130101  Or
021600121011     C                             PullYMD8 =    20130121  Or
021700121011     C                             PullYMD8 =    20130218  Or
021800121011     C                             PullYMD8 =    20130527  Or
021900120705     C                             PullYMD8 =    20130704  Or
022000120705     C                             PullYMD8 =    20140704
022100120705     C
022200120601     C     *ISO          Move      PullYMD8      CalcDate
022300120705     C     CalcDate      Adddur    1:*d          OneMoreDay
022400120705     C                   Move      OneMoreDay    PullYMD8
022500120531     C                   End
022600120531    ?C                   Endsr
022700120705    ? *___________________________________________________________________
022800120705     C     Holiday       BEGSR
022900120705    ? *___________________________________________________________________
023000131023     C                   if        #chk_holiday(onemoreday) = 'Y' or
023100131023     C                             #chk_holiday(twomoreday) = 'Y' or
023200131023     C                             #chk_holiday(threemoreday) = 'Y'
023300120705     C                   Move      ExtraDay      PullYMD8
023400131022     C                   Endif
023500120705     C
023600120705    ?C                   Endsr
023700110907    ? *___________________________________________________________________
023800110907     C     *Inzsr        BEGSR
023900110907    ? *___________________________________________________________________
024000131022
024100120601     C                   Movel     'ACH'         SOURCE            3
024200131022     C                   Eval      BKSOURCE  =   %Trim('INTERCEPT ')
024300131023     C                   Z-add     1             BKBATCH
024400131022
024500110907     C                   ENDSR
