000100000000      *_________________________________________________________________________
000200000000      *
000300120829      *  Description:  Load Auto Debit Bank Remote Deposit from Spreadsheet
000400000000      *
000500120829      *  (c)Copyright 2012 by GBS, Inc.
000600000000      *
000700120829      *    Created by:  szz  8/29/2012
000701080303      *
000702130708      * 07/08/13 dlk - fix BKACCT field
000800000000      *_________________________________________________________________________
000900120831     FAUTDEB    IF   E             DISK
001000120829     FAUTREMOTE2O    E             DISK
001100070713      *
001101110901     D                 DS
001102110901     D PullDt                  1      8    Inz
001103110901     D PullCC                  1      2    Inz('20')
001104110901     D Pull6                   3      8    Inz
001105110901     D                 DS
001106110901     D TransferDate            1     16
001107110901     D  XferDate               1     10    Inz
001108110901     D  PullDate               1      6
001109110901     D   M12                   1      2
001110110901     D    M1                   1      1
001111110901     D   D345                  3      5
001112110901     D    D34                  3      4
001113110901     D     D3                  3      3
001114110901     D    D45                  4      5
001115110901     D     D4                  4      4
001116110901     D   Y5678910              5     10
001117110901     D    Y5678                5      8
001118110901     D    Y6789                6      9
001119110901     D    Y78910               7     10
001120110901     D  XferTime                      6    Inz
001121110901     D                 DS
001122110901     D ReceiveDate             1      8
001123110901     D  RM12                   1      2
001124110901     D   RM1                   1      1
001125110901     D   RM2                   2      2
001126110901     D  RD345                  3      5
001127110901     D   RD34                  3      4
001128110901     D    RD3                  3      3
001129110901     D   RD45                  4      5
001130110901     D    RD4                  4      4
001131110901     D   RY5678                5      8
001132110901
001133110901     D ReceiveDt       S              8S 0 Inz
001134110901     D PosM            S              2S 0 Inz
001135110901     D PosD            S              2S 0 Inz
001136110901     D PosC            S              2S 0 Inz
001137110901     D PosX            S              2S 0 Inz
001138110901     D PosRJ           S              2S 0 Inz
001139110901     d stripped        S             10a   inz
001140110901     d cmpfld          S              9a   inz
001141110901     d stripped14      S             14a   inz
001142110901     d cmpfld9         S             13a   inz
001143110901
001144110901010   *   Work array - Strip dashes from fields.
001145110901010  D DASH            S              1    DIM(9)
001146110901010   *   Work array - Strip dashes from fields.
001147110901010  D DAS2            S              1    DIM(9)
001148110901010   *   Work array - Strip dashes from fields.
001149110901010  D DASH9           S              1    DIM(11)
001150110901010   *   Work array - Strip dashes from fields.
001151110901010  D DAS29           S              1    DIM(11)
001153110907    ?D CalcDate        S               D   Datfmt(*ISO)                         Input Request
001155110920     D ThreeMoreDay    S               D   Datfmt(*ISO)
001156110920     D FourMoreDay     S               D   Datfmt(*ISO)
001157110909     D FiveMoreDay     S               D   Datfmt(*ISO)
001158110907     D SixMoreDay      S               D   Datfmt(*ISO)
001159110920    ?D TodayISO        S               D   datfmt(*ISO)                         Input Request
001160110909    ?D PullYMD8ISO     S               D   datfmt(*ISO)                         Input Request
001161110909     D OneMoreDay      S              8S 0 Inz
001162110920     D TwoMoreDay      S              8S 0 Inz
001164110901
007500120831     C                   Read      AUTDEB
007600120831     C                   Dou       %Eof(AUTDEB)
007601110901      *
007602110901      * Acct#: use GBS TSA
007701130708     C                   move      DATSA         BKACCT
007702130708     C*****************  Evalr     BKACCT   =    %Trim(DATSA)
007703130708     C*****************  Movel     '0'           BKACCT
007800071029      *
007801110901      * inv #: use transaction date
007802120831     C********           Move      DAGBS         Invoice#          7 0
007803120831     C                   Move      DAGBS         Invoice#A         7
007804120831     C                   Move      Invoice#A     Invoice#          7 0
007805120831     C                   Eval      BKINV    =    Invoice#
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
009901110420      * check #
009902120831     C                   Movel     DAPUL         BKCHK#
009904110909     C                   Move      BKSEQ         BKCHK#
009905110909     C
011200071029
011201110420      * receive date
011300071025     C                   Exsr      FmtXferDate
011301110420      * source
011400110901     C                   Eval      BKSOURCE  =   %Trim('INTERCEPT ')
011401110420      * status
011500071025     C                   Eval      BKSTAT    =   *Blank
011600120829     C                   Write     AUTREMOTER
011700120831     C                   Read      AUTDEB
011800070713     C                   EndDo
011900070713     C                   Eval      *InLR     =   *On
012000071025    ? *________________________________________________________________
012100071025    ? * Reformat the Transfer Date into the Receive Date
012200071025    ? *________________________________________________________________
012300071025    ?C     FmtXferDate   Begsr
012400071025    ? *
012401110920      *Instead of using the pull date, we will use TWO days from today
012402110920      * per Liliane K email of 9/19/11 5:25 pm.
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
016801120831     C                   Move      DATOT         DATOTA           12
016900120831     C                   Eval      PosX = %Scan(',':DATOTA:1)
017000071029     C                   If        PosX <>       *Zero
017100120831     C                   Movel     DATOT         cmpfld9
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
019100120831     C                   Movel     DATOT         cmpfld
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
021300110907    ? *___________________________________________________________________
021400110907     C     *Inzsr        BEGSR
021500110907    ? *___________________________________________________________________
021600110907     C     *DATE         Mult      10000.0001    Today             8 0
021700110907     C                   Move      Today         TodayYMD          6 0
021800110907     C     *ISO          Move      Today         TodayISO
021900110920     C                   adddur    2:*D          TodayISO
022000110920     C     *ISO          Move      TodayISO      TwoMoreDay
022100110907     C     *ISO          Move      Today         CalcDate
022201110920     C     CalcDate      Adddur    3:*d          ThreeMoreDay
022300110920     C     CalcDate      Adddur    4:*d          FourMoreDay
022400110907     C                   Z-add     99999999      HighDate          8 0
022500110907     C                   Movel     'ACH'         SOURCE            3
022600110907     C                   Z-add     *Zeros        SEQ#              3 0
022700110907     C                   Clear                   BATCH#            3
022800110907     C                   Clear                   STATUS            1
022900110907     C                   Clear                   ACHFound          1
023000110907    ?C                   Call      'DAYOFWEEK'                                  PROCESS REC IO
023100110907    ?C                   Parm                    Day               4            GET RECORD
023200110907     C                   Select
023300110907     C                   When      Day      =    '*SAT'
023400110920     C                   Move      ThreeMoreDay  PullYMD8
023500110907     C                   When      Day      =    '*FRI'
023600110920     C                   Move      FourMoreDay   PullYMD8
023700110907     C                   Other
023800110920     C                   Move      TwoMoreDay    PullYMD8          8 0
023900110907     C                   End
023901110909      * Intercept Holiday Dates
023902110920      *         Friday holiday dates have to go to Monday
023906110909     C                   If        PullYMD8 =    20111111  Or
023907110909     C                             PullYMD8 =    20140704
023908110909     C     *ISO          Move      PullYMD8      PullYMD8ISO
023909110909     C                   adddur    3:*D          PullYMD8ISO
023910110920     C     *ISO          Move      PullYMD8ISO   TwoMoreDay
023911110920     C                   Move      TwoMoreDay    PullYMD8
023912110909     C                   End
023913110909      *         Monday through Thursday dates have to go to the following day
023935130304     C                   If        PullYMD8 =    20130101  Or
023936110909     C                             PullYMD8 =    20130121  Or
023937110909     C                             PullYMD8 =    20130218  Or
023938110909     C                             PullYMD8 =    20130527  Or
023939110909     C                             PullYMD8 =    20130704  Or
023940110909     C                             PullYMD8 =    20130902  Or
023941110909     C                             PullYMD8 =    20131014  Or
023942110909     C                             PullYMD8 =    20131111  Or
023943110909     C                             PullYMD8 =    20131128  Or
023944110909     C                             PullYMD8 =    20131225  Or
023945110909     C                             PullYMD8 =    20140101  Or
023946110909     C                             PullYMD8 =    20140120  Or
023947110909     C                             PullYMD8 =    20140217  Or
023948110909     C                             PullYMD8 =    20140526  Or
023949110909     C                             PullYMD8 =    20140901  Or
023950110909     C                             PullYMD8 =    20141013  Or
023951110909     C                             PullYMD8 =    20141111  Or
023952110909     C                             PullYMD8 =    20141127  Or
023953110909     C                             PullYMD8 =    20141225
023954110909     C     *ISO          Move      PullYMD8      PullYMD8ISO
023955110909     C                   adddur    1:*D          PullYMD8ISO
023956110909     C     *ISO          Move      PullYMD8ISO   OneMoreDay
023957110909     C                   Move      OneMoreDay    PullYMD8
023958110909     C                   End
023959110920     C                   Z-add     0             BKSEQ
024100110907     C                   ENDSR
