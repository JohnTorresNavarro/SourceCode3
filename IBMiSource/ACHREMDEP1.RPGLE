000100000000      *_________________________________________________________________________
000200000000      *
000300120530      *  Description:  Load ACH Bank Remote On-demand Deposit from Spreadsheet
000400000000      *
000500120530      *  (c)Copyright 2012 by GBS, Inc.
000600000000      *
000700120530      *    Created by:  szz  5/30/2012
000701080303      *
000702120601      * Notes:  Lilliane has requested that the date input to this
000703120601      *         program should have 3 business days added to it and
000704120601      *         bank holidays must be taken into consideration.
000705120601      * If the day is:
000706120601      *  Sun     Mon     Tue     Wed     Thu     Fri    Sat
000707120601      * Add this number of days to get this day:
000708120601      * +3=W     +3=Th   +3=F    +5=M    +5=T    +5=W   +4=W
000709120607      *
000710120607      * 06/07/12 szz Linda B. requested to remove the invoice#.
000711120905      * 09/05/12 szz Linda B. said that it is not enough to not sent on a
000712120905      *                holiday, we must actually add a day if any of the
000713120905      *                three added days is on a holiday.
000800000000      *_________________________________________________________________________
000900110901     FACHREMP   IF   E             DISK
001000110901     FACHREMOTE2O    E             DISK
001100070713      *
001101110901     D                 DS
001102120604     D PullBatch               1     12    Inz
001103120604     D PullD1B                 1      3
001104120604     D PullBB                  4      5    Inz
001105120604     D PullMM                  6      7    Inz
001106120604     D PullDD                  8      9    Inz
001107120604     D Pulldp                 10     10    Inz
001108120604     D PullYY                 11     12
001109120604     D                 DS
001110120604     D FmtBatch                1     10    Inz
001111120604     D FmtBB                   1      2    Inz
001112120604     D FmtMM                   3      4    Inz
001113120604     D FmtDD                   5      6    Inz
001115120604     D                 DS
001116110901     D PullDt                  1      8    Inz
001117110901     D PullCC                  1      2    Inz('20')
001118110901     D Pull6                   3      8    Inz
001119110901     D                 DS
001120110901     D TransferDate            1     16
001121110901     D  XferDate               1     10    Inz
001122110901     D  PullDate               1      6
001123110901     D   M12                   1      2
001124110901     D    M1                   1      1
001125110901     D   D345                  3      5
001126110901     D    D34                  3      4
001127110901     D     D3                  3      3
001128110901     D    D45                  4      5
001129110901     D     D4                  4      4
001130110901     D   Y5678910              5     10
001131110901     D    Y5678                5      8
001132110901     D    Y6789                6      9
001133110901     D    Y78910               7     10
001134110901     D  XferTime                      6    Inz
001135110901     D                 DS
001136110901     D ReceiveDate             1      8
001137110901     D  RM12                   1      2
001138110901     D   RM1                   1      1
001139110901     D   RM2                   2      2
001140110901     D  RD345                  3      5
001141110901     D   RD34                  3      4
001142110901     D    RD3                  3      3
001143110901     D   RD45                  4      5
001144110901     D    RD4                  4      4
001145110901     D   RY5678                5      8
001146110901
001147120601     D                 DS
001148120531     D RAPULfmt                1      8
001149120531     D  RAmm                   1      2
001150120914     D* RAs1                   3      3
001151120531     D  RAdd                   4      5
001152120914     D* RAs2                   6      6
001153120531     D  RAyy                   7      8
001154120531
001155120601     D                 DS
001156120531     D RAPULout                1      8S 0 Inz
001157120601     D  RAccout                1      2S 0 Inz
001158120601     D  RAyyout                3      4S 0 Inz
001159120601     D  RAmmout                5      6S 0 Inz
001160120601     D  RAddout                7      8S 0 Inz
001161120531
001162110901     D ReceiveDt       S              8S 0 Inz
001163110901     D PosM            S              2S 0 Inz
001164110901     D PosD            S              2S 0 Inz
001165110901     D PosC            S              2S 0 Inz
001166110901     D PosX            S              2S 0 Inz
001167110901     D PosRJ           S              2S 0 Inz
001168110901     d stripped        S             10a   inz
001169110901     d cmpfld          S              9a   inz
001170110901     d stripped14      S             14a   inz
001171110901     d cmpfld9         S             13a   inz
001172110901
001173110901010   *   Work array - Strip dashes from fields.
001174110901010  D DASH            S              1    DIM(9)
001175110901010   *   Work array - Strip dashes from fields.
001176110901010  D DAS2            S              1    DIM(9)
001177110901010   *   Work array - Strip dashes from fields.
001178110901010  D DASH9           S              1    DIM(11)
001179110901010   *   Work array - Strip dashes from fields.
001180110901010  D DAS29           S              1    DIM(11)
001181110907    ?D CalcDate        S               D   Datfmt(*ISO)                         Input Request
001182120601     D ThreeMoreDay    S               D   Datfmt(*ISO)
001183120601     D FourMoreDay     S               D   Datfmt(*ISO)
001184120601     D FiveMoreDay     S               D   Datfmt(*ISO)
001185120705     D OneMoreDay      S               D   Datfmt(*ISO)
001190110909    ?D PullYMD8ISO     S               D   datfmt(*ISO)                         Input Request
001196120601
001197120601     D Day_of_Week     S              1P 0
001198120601     D My_date         S               D   Inz(d'2012-12-31')
001199120601     D My_date2        S              8S 0 Inz(20121231)
001200120705      *
001201120705      * The holiday ISO dates have to be changed every year.
001205130102     D VeteransDay     S               D   Inz(d'2013-11-11')
001206130102     D Thanksgiving    S               D   Inz(d'2013-11-28')
001207130102     D Christmas       S               D   Inz(d'2013-12-25')
001208120705     D NewYearsDay     S               D   Inz(d'2013-01-01')
001209121011     D MLKDay          S               D   Inz(d'2013-01-21')
001210121011     D MemorialDay     S               D   Inz(d'2013-05-27')
001211121011     D IndependDay     S               D   Inz(d'2013-07-04')
001212121011     D LaborDay        S               D   Inz(d'2013-09-01')
001213121011     D ColumbusDay     S               D   Inz(d'2013-09-14')
001214110901
007500110901     C                   Read      ACHREMP
007600110901     C                   Dou       %Eof(ACHREMP)
007601120530      *
007602120530      * Skip the total record...the TSA field does not contain the TSA
007603120530     C                   If        RATSA    <>   'II1200892'
007604120531      * Add three business days to the RAPUL date.
007605120531     C                   Exsr      Add3Days
007606110901      *
007607110901      * Acct#: use GBS TSA
007701110901     C                   Evalr     BKACCT   =    %Trim(RATSA)
007800071029      *
007801110901      * inv #: use transaction date
007804120607     C                   Clear                   BKINV
008200071029      *
008201110420      * seq #
008300110901     C                   Z-add     1             BKBATCH
008301110920     C                   Add       1             BKSEQ
009300071029      *
009301110420      * amount
009400071029     C                   Exsr      stripcmp
009500071030     C                   Move      *Blanks       cmpfldA           9
009600071030     C                   Evalr     cmpfldA   =   %Trim(cmpfld)
009700071030     C                   Movel     cmpfldA       cmpfldN           9 0
009800071106     C     cmpfldN       MULT      .01           BKAMT
009900071029      *
009901120604      * check #  (After posting, this will appear in the history Note1.
009903120604     C                   Movel     RADVZ         PullBatch
009904120604     C                   Exsr      XlateBatch
009907120604     C                   Movel     PullMM        FmtMM
009908120604     C                   Movel     PullDD        FmtDD
009910120604     C                   Movel     FmtBatch      BKCHK#
009911120604     C                   Move      BKSEQ         BKCHK#
011200071029
011201110420      * receive date
011300071025     C                   Exsr      FmtXferDate
011301110420      * source
011400110901     C                   Eval      BKSOURCE  =   %Trim('INTERCEPT ')
011401110420      * status
011500071025     C                   Eval      BKSTAT    =   *Blank
011600110901     C                   Write     ACHREMOTER
011601120530     C                   End
011700110901     C                   Read      ACHREMP
011800070713     C                   EndDo
011900070713     C                   Eval      *InLR     =   *On
011901120604    ? *________________________________________________________________
011902120604    ? * Translate the batch from letters to digits
011903120604    ? *________________________________________________________________
011904120604    ?C     XlateBatch    Begsr
011905120604     C                   Select
011906120604     C                   When      PullBB    =   'AA'
011907120604     C                   Eval      FmtBB     =   '01'
011908120604     C                   When      PullBB    =   'AB'
011909120604     C                   Eval      FmtBB     =   '02'
011910120604     C                   When      PullBB    =   'AC'
011911120604     C                   Eval      FmtBB     =   '03'
011912120604     C                   When      PullBB    =   'AD'
011913120604     C                   Eval      FmtBB     =   '04'
011914120604     C                   When      PullBB    =   'AE'
011915120604     C                   Eval      FmtBB     =   '05'
011916120604     C                   When      PullBB    =   'AF'
011917120604     C                   Eval      FmtBB     =   '06'
011918120604     C                   When      PullBB    =   'AG'
011919120604     C                   Eval      FmtBB     =   '07'
011920120604     C                   When      PullBB    =   'AH'
011921120604     C                   Eval      FmtBB     =   '08'
011922120604     C                   When      PullBB    =   'AI'
011923120604     C                   Eval      FmtBB     =   '09'
011924120604     C                   When      PullBB    =   'AJ'
011925120604     C                   Eval      FmtBB     =   '10'
011926120604     C                   When      PullBB    =   'AK'
011927120604     C                   Eval      FmtBB     =   '11'
011928120604     C                   When      PullBB    =   'AL'
011929120604     C                   Eval      FmtBB     =   '12'
011930120604     C                   When      PullBB    =   'AM'
011931120604     C                   Eval      FmtBB     =   '13'
011932120604     C                   When      PullBB    =   'AN'
011933120604     C                   Eval      FmtBB     =   '14'
011934120604     C                   When      PullBB    =   'AO'
011935120604     C                   Eval      FmtBB     =   '15'
011936120604     C                   When      PullBB    =   'AP'
011937120604     C                   Eval      FmtBB     =   '16'
011938120604     C                   When      PullBB    =   'AQ'
011939120604     C                   Eval      FmtBB     =   '17'
011940120604     C                   When      PullBB    =   'AR'
011941120604     C                   Eval      FmtBB     =   '18'
011942120604     C                   When      PullBB    =   'AS'
011943120604     C                   Eval      FmtBB     =   '19'
011944120604     C                   When      PullBB    =   'AT'
011945120604     C                   Eval      FmtBB     =   '20'
011946120604     C                   When      PullBB    =   'AU'
011947120604     C                   Eval      FmtBB     =   '21'
011948120604     C                   When      PullBB    =   'AV'
011949120604     C                   Eval      FmtBB     =   '22'
011950120604     C                   When      PullBB    =   'AW'
011951120604     C                   Eval      FmtBB     =   '23'
011952120604     C                   When      PullBB    =   'AX'
011953120604     C                   Eval      FmtBB     =   '24'
011954120604     C                   When      PullBB    =   'AY'
011955120604     C                   Eval      FmtBB     =   '25'
011956120604     C                   When      PullBB    =   'AZ'
011957120604     C                   Eval      FmtBB     =   '26'
011958120604     C                   EndSl
011959120604    ?C                   Endsr
012000071025    ? *________________________________________________________________
012100071025    ? * Reformat the Transfer Date into the Receive Date
012200071025    ? *________________________________________________________________
012300071025    ?C     FmtXferDate   Begsr
012400071025    ? *
012401120531      *Per Lilliane & Linda B., we should use THREE business days from
012402120531      * the day in the file per meeting 5/31/12 2:30.
015701110907     C                   Move      PullYMD8      BKRCVDT
015900071025    ?C                   Endsr
016000071025    ? *
016100071029    ? *________________________________________________________________
016200071029    ? * Strip decimal point and comma out of field
016300071029    ? *________________________________________________________________
016400071029
016500071029     C     StripCmp      Begsr
016600071029
016700071029     C                   Clear                   cmpfld
016800071029     C                   Clear                   cmpfld9
016900110901     C                   Eval      PosX = %Scan(',':RATOT:1)
017000071029     C                   If        PosX <>       *Zero
017100110901     C                   Movel     RATOT         cmpfld9
017200071029     C                   MOVEA     cmpfld9       DASH9
017300110920     C                   Z-ADD     1             DX                3 0
017400110920     C     ','           LOOKUP    DASH9(DX)                              80
017500071029     C     *IN80         IFEQ      '1'
017600071029     C                   Z-ADD     0             E                 3 0
017700071029     C                   MOVEA     *ALL' '       DAS29
017800110920     C     1             DO        11            DX
017900110920     C     DASH9(DX)     IFNE      ','
018000071029     C                   ADD       1             E
018100110920     C                   MOVE      DASH9(DX)     DAS29(E)
018200071029     C                   ENDIF
018300071029     C                   ENDDO
018400080401     C                   MOVEA(P)  DAS29         Stripped14
018500071029     C                   ELSE
018600080401     C                   MOVEL     cmpfld9       Stripped14
018700071029     C                   ENDIF
018800080401     C                   Eval      cmpfld9   =   %Trim(Stripped14)
018900071029     C                   MOVEl     cmpfld9       cmpfld
019000071029     C                   Else
019100110901     C                   Movel     RATOT         cmpfld
019200071029     C                   End
019300071029      **
019400071029     C                   MOVEA     cmpfld        DASH
019500110920     C                   Z-ADD     1             DX                3 0
019600110920     C     '.'           LOOKUP    DASH(DX)                               80
019700071029     C     *IN80         IFEQ      '1'
019800071029     C                   Z-ADD     0             E                 3 0
019900071029     C                   MOVEA     *ALL' '       DAS2
020000110920     C     1             DO        9             DX
020100110920     C     DASH(DX)      IFNE      '.'
020200071029     C                   ADD       1             E
020300110920     C                   MOVE      DASH(DX)      DAS2(E)
020400071029     C                   ENDIF
020500071029     C                   ENDDO
020600071029     C                   MOVEA(P)  DAS2          Stripped
020700071029     C                   ELSE
020800071029     C                   MOVEL     cmpfld        Stripped
020900071029     C                   ENDIF
021000071029     C                   Eval      cmpfld    =   Stripped
021100071029
021200071029    ?C                   Endsr
021201120531    ? *___________________________________________________________________
021202120531     C     Add3Days      BEGSR
021203120531    ? *___________________________________________________________________
021204120531      * Put received (pull) date in format for calc
021205120531     C                   Movel     RAPUL         RAPULfmt
021206120919     C*******            Movel     Today         RAccout
021207120919     C*******            Movel     RAyy          RAyyout
021208120919     C*******            Movel     RAmm          RAmmout
021209120919     C*******            Movel     RAdd          RAddout
021210120919     C                   Eval      RAPULOUT  =   Today
021211120531      *
021215120531     C     *ISO          Move      RAPULOUT      CalcDate
021216120601     C                   Move      CalcDate      My_date
021217120601     C                   Move      RAPULOut      My_date2
021218120905     C                   Move      CalcDate      PullYMD8
021228120601     C                   Exsr      DayofWeek
021229120531     C                   Select
021230120905     C                   When      Day      =    '*SUN'      Or
021231120905     C                             Day      =    '*MON'      Or
021232120905     C                             Day      =    '*TUE'
021233120905     C                   Exsr      Add1Day
021234120905     C                   Exsr      Add1Day
021235120905     C                   Exsr      Add1Day
021236120905     C                   When      Day      =    '*SAT'
021237120905     C                   Exsr      Add1Day
021238120905     C                   Exsr      Add1Day
021239120905     C                   Exsr      Add1Day
021240120905     C                   Exsr      Add1Day
021244120905     C                   When      Day      =    '*WED'       Or
021247120905     C                             Day      =    '*THU'       Or
021250120905     C                             Day      =    '*FRI'
021251120905     C                   Exsr      Add1Day
021252120905     C                   Exsr      Add1Day
021253120905     C                   Exsr      Add1Day
021254120905     C                   Exsr      Add1Day
021255120905     C                   Exsr      Add1Day
021256120905     C                   EndSl
021313120531    ?C                   Endsr
021314120905    ? *___________________________________________________________________
021315120905     C     Add1Day       BEGSR
021316120905    ? *___________________________________________________________________
021317120905      * Add 1 day to the pull date.
021318120905      * Determine if the day is on the Intercept holiday list.
021319120905      * If it is on the Intercept holiday list, add an additional day
021320120905      *
021321120905     C     *ISO          Move      PullYMD8      CalcDate
021322120905     C     CalcDate      Adddur    1:*d          OneMoreDay
021323120905     C                   Move      OneMoreDay    PullYMD8
021324121011     C                   If        PullYMD8 =    20130902  Or
021325120905     C                             PullYMD8 =    20120704  Or
021326121011     C                             PullYMD8 =    20130914  Or
021327120905     C                             PullYMD8 =    20121112  Or
021328120905     C                             PullYMD8 =    20121225  Or
021329120905     C                             PullYMD8 =    20130101  Or
021330120905     C                             PullYMD8 =    20130704  Or
021331120905     C                             PullYMD8 =    20140704
021333120905     C     *ISO          Move      PullYMD8      CalcDate
021334120905     C     CalcDate      Adddur    1:*d          OneMoreDay
021335120905     C                   Move      OneMoreDay    PullYMD8
021336120905     C                   End
021337120905    ?C                   Endsr
021371120601    ? *___________________________________________________________________
021372120601     C     DayofWeek     BEGSR
021373120601    ?C*___________________________________________________________________
021374120601      /free
021375120601         // *Mon = 0 ... Sun = 6
021376120601         Day_of_Week = %rem(%diff(%date():d'0001-01-01':*days):7);
021377120601         Day_of_Week = %rem(%diff(My_date:d'0001-01-01':*days):7);
021378120601         Day_of_Week = %rem(%diff(%date(My_date2):d'0001-01-01':*days):7);
021379120601
021380120601      /end-free
021381120601     C                   Select
021382120601     C                   When      Day_of_Week = 0
021383120601     C                   Movel     '*MON'        Day               4
021384120601     C                   When      Day_of_Week = 1
021385120601     C                   Movel     '*TUE'        Day
021386120601     C                   When      Day_of_Week = 2
021387120601     C                   Movel     '*WED'        Day
021388120601     C                   When      Day_of_Week = 3
021389120601     C                   Movel     '*THU'        Day
021390120601     C                   When      Day_of_Week = 4
021391120601     C                   Movel     '*FRI'        Day
021392120601     C                   When      Day_of_Week = 5
021393120601     C                   Movel     '*SAT'        Day
021394120601     C                   When      Day_of_Week = 6
021395120601     C                   Movel     '*SUN'        Day
021396120601     C                   Endsl
021397120601
021398120601
021399120601    ?C                   Endsr
021400110907    ? *___________________________________________________________________
021401110907     C     *Inzsr        BEGSR
021500110907    ? *___________________________________________________________________
021600110907     C     *DATE         Mult      10000.0001    Today             8 0
021601120601     C                   Z-add     99999999      HighDate          8 0
021602120601     C                   Movel     'ACH'         SOURCE            3
021603120601     C                   Z-add     *Zeros        SEQ#              3 0
021604120601     C                   Z-add     0             BKSEQ
021605120601     C                   Clear                   BATCH#            3
021606120601     C                   Clear                   STATUS            1
021607120601     C                   Clear                   ACHFound          1
021608120905     C                   Clear                   PullYMD8          8 0
024100110907     C                   ENDSR
