000100140327     H option(*nodebugio)
000200990630      *? ***************************************************************
000300020523      *
000400131010      *             GROUP BENEFIT SERVICES SOFTWARE           2012     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700120824      *  Date Written:   8/24/12                                       *
000800120824      *  Description:   Auto Debit                                     *
000900120824      *                                                                *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500220331      *  3/12/13   szz         We are using first of the month only
001600220331      *                         per Dave A. email 3/11/13 12:32 pm.
001700220331      *                        Per Claire, 1st of month is "E".
001800220331
001900220331      *  7/1/13    szz         Contrary to original specs, the invoice
002000220331      *                         is the current month invoice, not the
002100220331      *                         following month.
002200220331
002300130708      *  7/8/13    dlk         change the way datsa is loaded
002400220331
002500131010      * 10/10/13   sbt         hist file expansion project
002600220331
002700131104      * 11/04/13   dpb         Per email from Dave A - exclude two test
002800131104      *                        accounts (888.009.0001 & 888.001.0001)
002900220331
003000220331      * 03/14/14   dpb         Stop moving holdcdt into covbegmo in FINDINV
003100220331
003200140421      * 04/02/14   dpb         Job now runs on the last GBS working day of
003300140425      *                        the month....also, "trial run" and "update
003400140425      *                        run" are the same job and programs now.      s
003500140425      *                        Update to HIST only done if update run.
003600220331
003700150330      * 03/30/15   dpb         Per Shelly, Dave and Cindy: Auto debit
003800150330      *                        amount should be : a) total amount due if
003900150330      *                        the acct is active OR b) the sum of the
004000190515      *                        amount array if the acct is terminated
004100220331
004200220331      * 03/31/22   jt          Added call to program that would clean acct
004300220331      *                        name in acct master file before sending.
004400220512      * 04/29/22   RJ          disable checkname subroutine
004500220513      * 05/12/22   DLK         add amount to note 1 and remove check name
004600220930      * 09/30/22   DLK         add "AUTO DEBIT" text to hist note2
004700220331      *
004800220331      ****************************************************************
004900190515      * Note: 'E' means they are enrolled in Auto Debit. Blank means they
005000190515      *       don't have it (AHDEBIT flag)
005100190515      *
005200190515      *
005300220331      ****************************************************************
005400120824     FSECACH    IF   E           K Disk
005500130313     FINVELE    IF   E           K Disk
005600091029     FACCMST    IF   E           K Disk
005700090709     FACHINV    UF A E           K Disk
005800140402     FAUTDEB    O    E             Disk
005900140402     FAUTDEBCSV O    E             Disk
006000140402     FAUTERRCSV O    E             Disk
006100140402     FAUTBALCSV O    E             Disk
006200140402     FAUTBAACSV O    E             Disk
006300140402     FHIST      O    E             Disk
006400140402
006500150420     D bal_ds          DS
006600150420     D  BAL1
006700150420     D  BAL2
006800150420     D  BAL3
006900150420     D  BAL4
007000150420     D  BAL5
007100150420     D  BAL6
007200150420     D  BAL7
007300150420     D  BAL8
007400150420     D  BAL9
007500150420     D  BAL10
007600150420     D  BAL11
007700150420     D  BAL12
007800150420     D bal_arry                            DIM(12) like(bal1) overlay(bal_ds)
007900140402
008000110214     D  ACVTDTMDY      DS
008100110214     D  ACVTDTYY               1      4  0
008200110214     D  ACVTDTMM               5      6  0
008300110214     D  ACVTDTDD               7      8  0
008400140402
008500110223     D                 DS
008600110225     D  CovBegMo               1      8  0
008700110225     D   CvYr                  1      4  0 Inz
008800110225     D   CvMo                  5      6  0 Inz
008900110225     D   CvDa                  7      8  0 Inz
009000140402
009100090909     D                 DS
009200130313     D  TSA                    1     10  0
009300130313     D  IETRST                 1      3  0
009400130313     D  IESUBD                 4      6  0
009500130313     D  IEACCT                 7     10  0
009600140402
009700110831    ?D CalcDate        S               D   Datfmt(*ISO)
009800110831     D ThreeMoreDay    S               D   Datfmt(*ISO)
009900150407     D TwoMoreDay      S               D   Datfmt(*ISO)
010000110831    ?D TodayISO        S               D   datfmt(*ISO)
010100120830    ?D NextMISO        S               D   datfmt(*ISO)
010200110831     D Tomorrow        S              8S 0 inz
010300120830     D NextMonth       S              8S 0 inz
010400110911     D @ACCT           S              4A
010500110911     D @SUBD           S              3A
010600110911     D @TRST           S              3A
010700140325
010800061017     D                UDS
010900110912     D LUSER                   1     10
011000061017
011100090916     D ACHFound        S              1A   Inz(' ')
011200130320     D CurrentEnr      S              2A   Inz('20')
011300130319     D Transaction     S              2A   Inz('30')
011400090813     D RoutMsg         C                   'Routing Number is Missing.'
011500090813     D BActMsg         C                   'Bank Account# is Missing.'
011600090813     D CSFlMsg         C                   'Checking/Savings Flag is Missing'
011700090916     D NoFdMsg         C                   'No ACH Record for Date Entered'
011800140402    ? *___________________________________________________________________
011900090904     C
012000120824     C                   Read      SECACH
012100220331     C                   Dow       Not %Eof(SECACH)
012200110314     C                   Move      'N'           ValidFlag         1
012300131104
012400131104      * Per Dave A, skip these two test accounts
012500131104     C                   if        (ahtrst = 888 and ahsub# = 009 and
012600131104     C                              ahacct = 0001) or (ahtrst = 888 and
012700131104     C                              ahsub# = 001 and ahacct = 0001)
012800131202     C                   else
012900110225      *
013000140327     C                   if        AHDEBIT    =    'E'
013100120828      *
013200120824     C                   If        AHENDT     =    *Zero     Or
013300120824     C                             AHENDT     >    Today
013400110314     C                   Eval      ValidFlag  =  'Y'
013500061010     C                   Exsr      Process
013600090916     C                   Eval      ACHFound   =  'Y'
013700090813     C                   End
013800110216     C                   End
013900131104
014000131202     C                   End
014100120824     C                   Read      SECACH
014200061010     C                   EndDo
014300131104
014400110314     C                   If        ACHFound  <>  'Y'    And
014500110314     C                             ValidFlag =   'Y'
014600090916     C                   Eval      Error     =   NoFdMsg
014700090916     C     NoFdMsg       Cat(P)    ':':0         ErrorMsg         50
014800120828     C     ErrorMsg      Cat(P)    TodayA:2      Error            50
014900110301     C                   Exsr      SendEmail1
015000090916     C                   End
015100140402
015200060817     C                   Eval      *InLR     =   *On
015300060815     C                   Return
015400010403
015500060817      *---------------------------------------------------------------*
015600061010     C     Process       Begsr
015700060817      *---------------------------------------------------------------*
015800090813     C                   If        AHROUT     =  *Zero
015900090903     C                   Eval      Error      =  RoutMsg
016000110301     C                   Exsr      SendEmail1
016100090813     C                   End
016200140402
016300090813     C                   If        AHACT#     =  *Blanks
016400090903     C                   Eval      Error      =  BActMsg
016500110301     C                   Exsr      SendEmail1
016600090813     C                   End
016700140402
016800090813     C                   If        AHCSFL     =  *Blanks
016900090903     C                   Eval      Error      =  CSFlMsg
017000110301     C                   Exsr      SendEmail1
017100090813     C                   End
017200140402
017300061010     C                   Add       1             PrtCtr            5 0
017400150416     C******             Exsr      FindInv
017500150416
017600150416      * dpb 04/16/2015 - execute calc_amoutn instead of findinv
017700150407     C                   Exsr      calc_amount
017800140402
017900090909     C                   EndSr
018000090909      *---------------------------------------------------------------*
018100090909     C     WriteOut      Begsr
018200090909      *---------------------------------------------------------------*
018300120824     C                   Clear                   AUTDEBR
018400150416
018500090909     C                   Add       1             SEQ#
018600110328     C                   Movel     SEQ#          ShellySeq#        3
018700110328     C                   Clear                   Shelly           15
018800120828     C                   Eval      Shelly   =    %Trim('ACH' + TodayA +
018900110328     C                                                 ShellySeq#)
019000110214     C                   Move      ACVTDT        ACVTDTMDY
019100110214      *
019200110214     C                   Z-add     BAL1          TOTBAL
019300110214     C                   Add       BAL2          TOTBAL
019400110214     C                   Add       BAL3          TOTBAL
019500110214     C                   Add       BAL4          TOTBAL
019600110214     C                   Add       BAL5          TOTBAL
019700110214     C                   Add       BAL6          TOTBAL
019800110214     C                   Add       BAL7          TOTBAL
019900110214     C                   Add       BAL8          TOTBAL
020000110214     C                   Add       BAL9          TOTBAL
020100110214     C                   Add       BAL10         TOTBAL
020200110214     C                   Add       BAL11         TOTBAL
020300110214     C                   Add       BAL12         TOTBAL            9 2
020400130313     C     ACVTDTMM      SUB       1             AX                2 0
020500130313     C     AX            IFEQ      0
020600130313     C                   Z-ADD     12            AX
020700130313     C                   END
020800091029
020900130320      *---
021000130320      * Dave A said we don't check the balance (email 3/20/2013 10:45 am)
021100130627      * Dave A said we should check the balance meeting 6/26/2013 3pm)
021200130627     C                   If        TOTBAL  >     *Zero
021300130627     C                   Exsr      ClcRemBal
021400220331     C
021500120830     C                   Move      HoldInv       HoldInvA          7
021600110421     C                   Eval      WKRECORD =                   '"' +
021700110428     C                             %Trim('DVZ')                  + '","' +
021800120828     C                             %Trim('CCD')                  + '","' +
021900120831     C                             %Trim('GBS,INC. ' + HoldInvA) + '","' +
022000120828     C                             %Trim('9ii1200892')           + '","' +
022100120828     C                             %Trim('GBS PREMIUM')          + '","' +
022200110421     C                             %Trim('4108321300DEBIT')      + '","' +
022300110831     C                             %Trim(%Editc(PullYMD:'P'))    + '","' +
022400110421     C                             %Trim(ACNAM1)                 + '","' +
022500110527     C                             %Trim(%Editw(AHROUT:'0         '))    +
022600110527     C                                                             '","' +
022700110421     C                             %Trim(AHACT#)                 + '","' +
022800110421     C                             %Trim(AHCSFL)                 + '","' +
022900110421     C                             %Trim('7')                    + '","' +
023000110421     C                             %Trim(%Editw(TSA:'0          ')) + '","' +
023100110421     C                             %Trim(%Editc(InvTotOut:'P'))     + '","' +
023200110421     C                             '  ' + '",'
023300120824     C                   Write     AUTDEBR
023400140402
023500140402      *?update HIST if this is the update job (not trial run)
023600140402     C                   if        runjob = 'U'
023700110912     C                   Exsr      $COMNHIST
023800110911     C                   Move      'L72'         TRCODE
023900131010     c                   eval      hstrtime = %time
024000110912     C                   WRITE     HISTR
024100140402     C                   endif
024200110906      *
024300120824      * Load field values to the physical file version of AUTDEBCSV (AUTDEB)
024400110906     C                   Eval      DATRST =  AHTRST
024500110906     C                   Eval      DASUB# =  AHSUB#
024600110906     C                   Eval      DAACCT =  AHACCT
024700110906     C                   Eval      DADVZ  =  %Trim('DVZ')
024800120828     C                   Eval      DAPPD  =  %Trim('CCD')
024900120830     C                   Eval      DAGBS  =  %Trim('GBS,INC. ' + HoldInvA)
025000110906     C                   Eval      DA9II  =  %Trim('9ii1200892')
025100110906     C                   Eval      DASRD  =  %Trim('SR DEN PRM')
025200110906     C                   Eval      DADEB  =  %Trim('4108321300DEBIT')
025300110906     C                   Eval      DAPUL  =  %Trim(%Editc(PullYMD:'P'))
025400110906     C                   Eval      DAACN  =  %Trim(ACNAM1)
025500110906     C                   Eval      DAROU  =  %Trim(%Editw(AHROUT:'0         '))
025600110906     C                   Eval      DAACT  =  %Trim(AHACT#)
025700110906     C                   Eval      DACSF  =  %Trim(AHCSFL)
025800110906     C                   Eval      DA7    =  %Trim('7')
025900130708     C                   move      TSA           datsa
026000110906     C                   Eval      DATOT  =  InvTotOut
026100110906     C                   Eval      DABLK  =  *Blanks
026200120824     C                   Write     AUTDEBXR
026300120824     C                   Clear                   AUTDEBXR
026400150416
026500130627     C                   Else
026600130627     C                   Exsr      NoBalance
026700121011      *---
026800121011      * If there is no balance in the account, remove the ACHINV record
026900121011      *---
027000130627     C                   Eval      RC      =     %Trim(IERC)
027100130627     C     HstKey        Chain     ACHINV
027200130627     C                   If        %Found(ACHINV)
027300130627     C                   Delete    ACHINVR
027400130627     C                   End
027500130627     C                   End
027600140402
027700120824     C                   Clear                   AUTDEBR
027800150416
027900090709     C                   EndSr
028000150407      *--------------------------------------------------------------------*
028100150330      * calc_amount:  determine the amount to auto debit
028200150407      *--------------------------------------------------------------------*
028300150330       begsr calc_amount ;
028400150330
028500150330        clear invtotout ;
028600150330
028700150407        //?ensure ACH begin date is BEFORE coverage through date...else LEAVE
028800150330        if ahbedt > covbegmo ;
028900150330         leavesr ;
029000150330        endif ;
029100150330
029200150330        //?get acct master record..if not found leave subroutine
029300150407        chain inpkey accmst ;
029400150330        if not %found(accmst) ;
029500150330         leavesr ;
029600150330        endif ;
029700150330
029800150407        //?get ending balance record (type 50) from invele...
029900150330        recordcode = '50' ;
030000150330        clear ieendb ;
030100150407        chain invkey invele ;
030200150330
030300150330        //?determine amt to debit:  if acct is termed use sum of 12 monthly
030400150330        //?buckets from ACCMST.  If active use ending balance on last invoice
030500150330        if atrmdt <> *zeros ;
030600150420         invtotout = %xfoot(bal_arry) ;
030700150330        elseif %found(invele) ;
030800150330         holdinv = ieinv# ;
030900150330         holdcdt = ievcdt ;
031000150330         exsr checkhis ;
031100150330         if inhistory = 'Y' ;
031200150330          leavesr ;
031300150330         endif ;
031400150330         invtotout = ieendb ;
031500150330        endif ;
031600150330
031700150420        if invtotout <= *zeros ;
031800150330         leavesr ;
031900150330        endif ;
032000150330
032100150330       //?write ACHINV if this is the update job (not trial run)
032200150330        if runjob = 'U' ;
032300150330         exsr writehis ;
032400150330        endif ;
032500150330
032600150330        exsr writeout ;
032700150330
032800220331       endsr ;
032900220331
033000090903      *---------------------------------------------------------------*
033100130312     C     FindInv       Begsr
033200130313      *---------------------------------------------------------------*
033300090909     C                   Z-add     *Zeros        InvTotOut         9 2
033400130319     C                   Eval      RecordCode =  CurrentEnr
033500130319     C                   Z-add     *Zeros        TRAMBTot          9 2
033600140402
033700130319     C     InvKey        Setll     INVELE
033800130319     C     InvKey        Reade     INVELE
033900140402
034000130319     C                   Dow       Not %Eof(INVELE)
034100130319     C                   Add       IETRAMB       TRAMBTot
034200130319     C     InvKey        Reade     INVELE
034300130319     C                   EndDo
034400140402
034500130320     C                   Eval      RecordCode =  Transaction
034600130320     C     InvKey        Setll     INVELE
034700140402
034800130320     C     InvKey        Reade     INVELE
034900130320     C                   Dow       Not %Eof(INVELE)
035000130320     C                   Add       IETRAMB       InvTotOut
035100130320     C     InvKey        Reade     INVELE
035200130320     C                   EndDo
035300140402
035400130320     C                   Eval      InvTotOut  =  (TRAMBTot + InvTotOut)
035500130313     C                   Move      IEINV#        HoldInv          10 0
035600130313     C                   Move      IEVCDT        HoldCdt           8 0
035700140304     C*****              Move      HoldCdt       CovBegMo
035800140402
035900120824     C                   If        HoldCdt   >=  AHBEDT
036000101222     C                   Exsr      CheckHis
036100140402
036200101222     C                   If        InHistory <>  'Y'
036300130315     C                   If        InvTotOut >   *Zero
036400140402
036500140402      *?write ACHINV if this is the update job (not trial run)
036600140402     C                   if        runjob = 'U'
036700090904     C                   Exsr      WriteHis
036800140402     C                   endif
036900140402
037000130320     C     InPKey        Chain     ACCMST
037100130320     C                   If        %Found(ACCMST)
037200130320     C                   If        ATRMDT   =    *Zero  Or
037300130320     C                             ATRMDT   >    Today
037400130320     C                   Exsr      WriteOut
037500130320     C                   End
037600130320     C                   End
037700090909     C                   End
037800130315     C                   End
037900120824     C                   End
038000130320     C***                Z-add     *Zeros        InvTotOut
038100090908
038200090903    ?C                   Endsr
038300140402
038400090904    ? *___________________________________________________________________
038500090904    ? * Write a ACH-invoice history record
038600090904    ? *___________________________________________________________________
038700090904    ?C     WriteHis      Begsr
038800090904     C                   Clear                   ACHINVR
038900130313     C                   Eval      AITRST    =   IETRST
039000130313     C                   Eval      AISUB#    =   IESUBD
039100130313     C                   Eval      AIACCT    =   IEACCT
039200130313     C                   Eval      AIINV#    =   IEINV#
039300130313     C                   Eval      AIIAMT    =   InvTotOut
039400090904     C                   Eval      AIAPDT    =   Today
039500130313     C                   Eval      AIIEDT    =   IEVCDT
039600130627     C                   Eval      AIINRC    =   IERC
039700120927     C                   Eval      AIROUT    =   AHROUT
039800120927     C                   Eval      AIACT#    =   AHACT#
039900090904     C                   Write     ACHINVR
040000090904    ?C                   Endsr
040100090909    ? *___________________________________________________________________
040200090909    ? * Check whether invoice has already been processed
040300090909    ? *___________________________________________________________________
040400090909    ?C     CheckHis      Begsr
040500090909      *
040600090909     C                   Move      'N'           InHistory         1
040700130313     C                   Move      IEINV#        Invoice#
040800130313     C                   Z-add     InvTotOut     InvTot
040900130313     C                   Eval      RC      =     %Trim(IERC)
041000090909     C     HstKey        Chain     ACHINV
041100090909     C                   If        %Found(ACHINV)
041200090909     C                   Eval      InHistory   = 'Y'
041300090909     C                   End
041400140402
041500090909    ?C                   Endsr
041600090813      *---------------------------------------------------------------*
041700090813     C     SendEmail1    Begsr
041800090813      *---------------------------------------------------------------*
041900090904     C                   Movel     AHTRST        Trust             3
042000090904     C                   Movel     AHSUB#        Sub#              3
042100090904     C                   Movel     AHACCT        Acct              4
042200110830     C                   Eval      WKERROR  =                   '"' +
042300110830     C                             %Trim(Trust)             + '","' +
042400110830     C                             %Trim(Sub#)              + '","' +
042500110830     C                             %Trim(Acct)              + '","' +
042600110830     C                             %Trim(Error)             + '",'
042700120824     C                   Write     AUTERRSR
042800140402
042900090813    ?C                   Endsr
043000080409      * ? _____________________________________________________________
043100080409      *? *                                                             *
043200080409      *? *        Write Excel Spreadsheet Title to CSV File            *
043300080409      *? *_____________________________________________________________*
043400080409     C     WriteSpTitle  BEGSR
043500140402
043600110421     C                   Eval      WKRECORD        =        '"'    +
043700110421     C                                                      'PIN'  + '","' +
043800110421     C                                              'Entry Class'  + '","' +
043900110421     C                                             'Company Name'  + '","' +
044000110421     C                                              'Fed Tax ID#'  + '","' +
044100110421     C                                              'Description'  + '","' +
044200110421     C                                            'Discretionary'  + '","' +
044300110421     C                                           'Effective Date'  + '","' +
044400110421     C                                            'Customer Name'  + '","' +
044500110421     C                                                 'Routing#'  + '","' +
044600110421     C                                            'Bank Account#'  + '","' +
044700110421     C                                             'Account Type'  + '","' +
044800110421     C                                         'Transaction Type'  + '","' +
044900110421     C                                          'Identification#'  + '","' +
045000110421     C                                                   'Amount'  + '","' +
045100110421     C                                                'Misc Info'  + '",'
045200120824     C                   Write     AUTDEBR
045300120824     C                   Clear                   AUTDEBR
045400140402
045500120824     C                   ENDSR
045600060817
045700110907    ? *___________________________________________________________________
045800110907     C     $COMNHIST     BEGSR
045900110907    ? *___________________________________________________________________
046000110907     C                   CLEAR                   HISTR
046100110907     C                   MOVE      AHTRST        @TRST
046200110907     C                   MOVE      AHSUB#        @SUBD
046300110907     C                   MOVE      AHACCT        @ACCT
046400110907     C     @TRST         CAT(P)    @SUBD:0       HKEY
046500110907     C                   CAT       @ACCT:0       HKEY
046600110907     C                   MOVE      *Blanks       TRMFLG
046700110907     C                   MOVE      *Blanks       TRLFLG
046800110907     C                   MOVE      *ZEROS        HDSEQ#
046900131025     C                   MOVEL     'AUTDEB1R'    HPRGNM
047000110907     C                   Z-ADD     AHTRST        HSTRST
047100110907     C                   Z-ADD     AHSUB#        HSSUB#
047200110907     C                   Z-ADD     AHACCT        HSACCT
047300110911     C                   MOVEL     LUSER         HOPER
047400110907     C                   MOVE      'A'           HSDLTD
047500110907     C     *DATE         Mult      10000.0001    TRDATE
047600220516        ck#not = %editc(InvTotOut:'J');
047700220930        note2  = 'AUTO DEBIT';
047800140402
047900110907     C                   ENDSR
048000130627      *---------------------------------------------------------------*
048100130627     C     ClcRemBal     Begsr
048200140402
048300130627     C                   Clear                   StillBal          9 2
048400130627     C                   Eval      StillBal   =  TOTBAL - InvTotOut
048500130627     C                   If        StillBal   >  *Zero
048600130627     C                   Clear                   AUTBAACR
048700130627     C                   Eval      WKRECA   =                   '"' +
048800130627     C                             %Trim(ACNAM1)                    + '","' +
048900130627     C                             %Trim(%Editw(TSA:'0          ')) + '","' +
049000130627     C                             %Trim(%Editc(TOTBAL:'P'))       + '","' +
049100130627     C                             %Trim(%Editc(InvTotOut:'P'))    + '","' +
049200130627     C                             %Trim(%Editc(StillBal:'P'))      + '","' +
049300130627     C                                                                '",'
049400130627     C                   Write     AUTBAACR
049500130627     C                   End
049600140402
049700130627     C                   Endsr
049800130627      *---------------------------------------------------------------*
049900130627     C     NoBalance     Begsr
050000130627      *---------------------------------------------------------------*
050100130627     C                   Clear                   AUTBALCR
050200130627     C                   Eval      WKREC    =                   '"' +
050300130627     C                             %Trim(ACNAM1)                 + '","' +
050400130627     C                             %Trim(%Editw(TSA:'0          ')) + '","' +
050500130627     C                             %Trim(%Editc(TOTBAL:'P'))        + '","' +
050600130627     C                             '  ' + '",'
050700130627     C                   Write     AUTBALCR
050800140402
050900130627     C                   Endsr
051000090813    ? *___________________________________________________________________
051100090813    ? * Parameter lists
051200090813    ? *___________________________________________________________________
051300090904    ?C     PLIST         Begsr
051400140402
051500140402     C     *entry        plist
051600140402     C                   parm                    runjob            1
051700140402
051800090813    ?C                   Endsr
051900090903    ? *___________________________________________________________________
052000090903    ? * Klists
052100090903    ? *___________________________________________________________________
052200090904    ?C     KList         Begsr
052300140402
052400130313     C     InvKey        Klist
052500130312    ?C                   Kfld                    AHTRST
052600130312    ?C                   Kfld                    AHSUB#
052700130312    ?C                   Kfld                    AHACCT
052800130312     C                   Kfld                    CovBegMo
052900130313     C                   Kfld                    RecordCode        2
053000140402
053100090909     C     InPKey        Klist
053200090909    ?C                   Kfld                    AHTRST
053300090909    ?C                   Kfld                    AHSUB#
053400090909    ?C                   Kfld                    AHACCT
053500140402
053600090909     C     HstKey        Klist
053700090909     C                   Kfld                    AHTRST
053800090909     C                   Kfld                    AHSUB#
053900090909     C                   Kfld                    AHACCT
054000090909     C                   Kfld                    Invoice#         10 0
054100130313     C                   Kfld                    RC                3
054200090909     C                   Kfld                    InvTot            8 2
054300130313     C                   Kfld                    IEVCDT
054400140402
054500090903    ?C                   Endsr
054600090903    ? *___________________________________________________________________
054700090903     C     *Inzsr        BEGSR
054800090903    ? *___________________________________________________________________
054900140402
055000220513     C     *DATE         Mult      10000.0001    Today             8 0
055100220513
055200220513    ? *********************************************************************
055300220513    ? *                                                                   *
055400220513    ? * testing 5/13/22 - force today to be 20220429 so it runs like      *
055500220513    ? *                   today is the last business day of month         *
055600220516     C**************     z-add     20220429      Today             8 0
055700220513    ? *********************************************************************
055800220513
055900120828     C                   Move      Today         TodayA            8
056000140402
056100140402      *?As of 04/2014 this job does NOT run on the 1st of each month....
056200140402      *?Instead it runs on the last GBS business day, which is obviously
056300140402      *?variable.  So we need to look for invoices with a date of next
056400140402      *?month.
056500120830     C     *ISO          Move      Today         NextMISO
056600140327     C                   Adddur    1:*M          NextMISO
056700120830     C     *ISO          Move      NextMISO      NextMonth
056800120830      *
056900120830     C                   Move      NextMonth     CovBegMo
057000120830     C                   Eval      CVDA    =     1
057100110831     C     *ISO          Move      Today         TodayISO
057200110831     C                   adddur    1:*D          TodayISO
057300110831     C     *ISO          Move      TodayISO      Tomorrow
057400110831     C     *ISO          Move      Today         CalcDate
057500110831     C     CalcDate      Adddur    2:*d          TwoMoreDay
057600110831     C     CalcDate      Adddur    3:*d          ThreeMoreDay
057700110225     C                   Z-add     99999999      HighDate          8 0
057800090709     C                   Movel     'ACH'         SOURCE            3
057900090709     C                   Z-add     *Zeros        SEQ#              3 0
058000090709     C                   Clear                   BATCH#            3
058100090709     C                   Clear                   STATUS            1
058200090813     C                   Clear                   ACHFound          1
058300110831    ?C                   Call      'DAYOFWEEK'
058400110831    ?C                   Parm                    Day               4
058500110831     C                   Select
058600110831     C                   When      Day      =    '*SAT'
058700110902     C                   Move      TwoMoreDay    PullYMD8
058800110831     C                   When      Day      =    '*FRI'
058900110902     C                   Move      ThreeMoreDay  PullYMD8
059000110831     C                   Other
059100110902     C                   Move      Tomorrow      PullYMD8          8 0
059200110831     C                   End
059300110902     C                   Move      PullYMD8      PullYMD           6 0
059400140402
059500130627     C                   Clear                   AUTBALCR
059600130627     C                   Eval      WKREC    =                   '"' +
059700130627     C                                            'Customer Name'  + '","' +
059800130627     C                                            'Account#'       + '","' +
059900130627     C                                            'Balance'        + '",'
060000130627     C                   Write     AUTBALCR
060100140402
060200130627     C                   Clear                   AUTBAACR
060300130627     C                   Eval      WKRECA   =                  '"' +
060400130627     C                                             'Customer Name' + '","' +
060500130627     C                                                  'Account#' + '","' +
060600130627     C                                           'Account Balance' + '","' +
060700130627     C                                       'Auto Debited Amount' + '","' +
060800130627     C                                         'Remaining Balance' + '",'
060900130627     C                   Write     AUTBAACR
061000060817     C                   ENDSR
061100010412
061200140402    ? *___________________________________________________________________
