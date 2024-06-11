000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000300020523      *
000400130507      *             GROUP BENIFIT SERVICES SOFTWARE           2013     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700130507      *  Date Written:   5/07/13                                       *
000800130507      *  Description:   Pre Auto Debit Notification                    *
000900120824      *                                                                *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500131010      * 10/10/13   sbt         hist file expansion project             *
001600190515      *
001700190515      * Note: 'E' means they are enrolled in Auto Debit. Blank means they
001800190515      *       don't have it (AHDEBIT flag)
001900240118      *
002000240118      * ** Auto debit email notice to accounts: Claire has a stored
002100240118      *    procedue ([dbo].[usp_app_invoice_generate_ebill]) that reads
002200240118      *    the AUTNOT file in QS36F on the 25th of the month to send out
002300240118      *    emails based on accts in AUTNOT file at that time.
002400240118      *
002500190625      * 06/25/2019 B.Rees       Added the Invoice Amount to the History
002600190625      *  ModID: Br01            File.
002700190625      *
002800240112      * 01/12/2024 J.Allen      Check TOTBAL before sending notification
002900240112      *  ModID: j001
003000190625      *
003100190625      *
003200990630      *? ***************************************************************
003300120824     FSECACH    IF   E           K Disk
003400130313     FINVELE    IF   E           K Disk
003500091029     FACCMST    IF   E           K Disk
003600150420     FACHINV    IF   E           K Disk
003700130507     FAUTNOT    O  A E             Disk
003800120824     FAUTERRCSV O  A E             Disk
003900130521     FHIST      O  A E           K Disk
004000150420
004100150420     D bal_ds          DS
004200150420     D  BAL1
004300150420     D  BAL2
004400150420     D  BAL3
004500150420     D  BAL4
004600150420     D  BAL5
004700150420     D  BAL6
004800150420     D  BAL7
004900150420     D  BAL8
005000150420     D  BAL9
005100150420     D  BAL10
005200150420     D  BAL11
005300150420     D  BAL12
005400150420     D bal_arry                            DIM(12) like(bal1) overlay(bal_ds)
005500150420
005600110214     D  ACVTDTMDY      DS
005700110214     D  ACVTDTYY               1      4  0
005800110214     D  ACVTDTMM               5      6  0
005900110214     D  ACVTDTDD               7      8  0
006000110223      *
006100110225     D                 DS
006200110225     D  CovMonth               1      8  0
006300110225     D   UsrCovYY              1      4  0
006400120828     D   UsrCovMO              5      6  0 Inz(1)
006500110225     D   AllMonth              7      8  0 Inz(*Zero)
006600110225      *
006700110223     D                 DS
006800110225     D  CovBegMo               1      8  0
006900110225     D   CvYr                  1      4  0 Inz
007000110225     D   CvMo                  5      6  0 Inz
007100110225     D   CvDa                  7      8  0 Inz
007200110223      *
007300090909     D                 DS
007400130313     D  TSA                    1     10  0
007500130313     D  IETRST                 1      3  0
007600130313     D  IESUBD                 4      6  0
007700130313     D  IEACCT                 7     10  0
007800110831    ?D CalcDate        S               D   Datfmt(*ISO)
007900110831     D ThreeMoreDay    S               D   Datfmt(*ISO)
008000110831     D TwoMoreDay      S               D   Datfmt(*ISO)
008100110831    ?D TodayISO        S               D   datfmt(*ISO)
008200120830    ?D NextMISO        S               D   datfmt(*ISO)
008300110831     D Tomorrow        S              8S 0 inz
008400120830     D NextMonth       S              8S 0 inz
008500110911     D @ACCT           S              4A
008600110911     D @SUBD           S              3A
008700110911     D @TRST           S              3A
008800061017     D                UDS
008900110912     D LUSER                   1     10
009000061017
009100240112     D ACHFound        S              1A   Inz(' ')
009200130320     D CurrentEnr      S              2A   Inz('20')
009300130319     D Transaction     S              2A   Inz('30')
009400090813     D RoutMsg         C                   'Routing Number is Missing.'
009500090813     D BActMsg         C                   'Bank Account# is Missing.'
009600090813     D CSFlMsg         C                   'Checking/Savings Flag is Missing'
009700090916     D NoFdMsg         C                   'No ACH Record for Date Entered'
009800060816      *
009900090904     C
010000120824     C                   Read      SECACH
010100120824     C                   Dow       Not %Eof(SECACH)
010200110314     C                   Move      'N'           ValidFlag         1
010300110225      *
010400130320      ***********************************************************
010500130320      ***********************************************************
010600130320      *****                                                 *****
010700130320      *****      T   E   S   T     -   Remove to install!   *****
010800240119      *****  i.e. todaydd = 25 and covbegmo = 20240101      *****
010900240119      *****  would simulate the 12/25/23 run looking for    *****
011000240119      *****  the January 2024 invoice.                      *****
011100240119      *****                                                 *****
011200240119     C***                Eval      TodayDD    =    25
011300240119     C***                Eval      CovBegMo   =    20240101
011400130320      *****                                                 *****
011500130320      *****                                                 *****
011600130320      ***********************************************************
011700130320      ***********************************************************
011800130507     C                   If        TodayDD    =    25        And
011900130312     C                             AHDEBIT    =    'E'
012000120828      *
012100120824     C                   If        AHENDT     =    *Zero     Or
012200120824     C                             AHENDT     >    Today
012300110314     C                   Eval      ValidFlag  =  'Y'
012400061010     C                   Exsr      Process
012500090916     C                   Eval      ACHFound   =  'Y'
012600090813     C                   End
012700110216     C                   End
012800120824     C                   Read      SECACH
012900061010     C                   EndDo
013000110314     C                   If        ACHFound  <>  'Y'    And
013100110314     C                             ValidFlag =   'Y'
013200090916     C                   Eval      Error     =   NoFdMsg
013300090916     C     NoFdMsg       Cat(P)    ':':0         ErrorMsg         50
013400120828     C     ErrorMsg      Cat(P)    TodayA:2      Error            50
013500110301     C                   Exsr      SendEmail1
013600090916     C                   End
013700060817     C                   Eval      *InLR     =   *On
013800060815     C                   Return
013900010403
014000060817      *---------------------------------------------------------------*
014100061010     C     Process       Begsr
014200060817      *---------------------------------------------------------------*
014300090813     C                   If        AHROUT     =  *Zero
014400090903     C                   Eval      Error      =  RoutMsg
014500110301     C                   Exsr      SendEmail1
014600090813     C                   End
014700090813     C                   If        AHACT#     =  *Blanks
014800090903     C                   Eval      Error      =  BActMsg
014900110301     C                   Exsr      SendEmail1
015000090813     C                   End
015100090813     C                   If        AHCSFL     =  *Blanks
015200090903     C                   Eval      Error      =  CSFlMsg
015300110301     C                   Exsr      SendEmail1
015400090813     C                   End
015500061010     C                   Add       1             PrtCtr            5 0
015600080409
015700150416     C******             Exsr      FindInv
015800150416
015900150416      * dpb 04/16/2015 - execute calc_amoutn instead of findinv
016000150416     C                   Exsr      calc_amount
016100090904      *
016200090909     C                   EndSr
016300090909      *---------------------------------------------------------------*
016400090909     C     WriteOut      Begsr
016500090909      *---------------------------------------------------------------*
016600150416
016700090909     C                   Add       1             SEQ#
016800110328     C                   Movel     SEQ#          ShellySeq#        3
016900110328     C                   Clear                   Shelly           15
017000120828     C                   Eval      Shelly   =    %Trim('ACH' + TodayA +
017100110328     C                                                 ShellySeq#)
017200110214     C                   Move      ACVTDT        ACVTDTMDY
017300110214      *
017400110214     C                   Z-add     BAL1          TOTBAL
017500110214     C                   Add       BAL2          TOTBAL
017600110214     C                   Add       BAL3          TOTBAL
017700110214     C                   Add       BAL4          TOTBAL
017800110214     C                   Add       BAL5          TOTBAL
017900110214     C                   Add       BAL6          TOTBAL
018000110214     C                   Add       BAL7          TOTBAL
018100110214     C                   Add       BAL8          TOTBAL
018200110214     C                   Add       BAL9          TOTBAL
018300110214     C                   Add       BAL10         TOTBAL
018400110214     C                   Add       BAL11         TOTBAL
018500110214     C                   Add       BAL12         TOTBAL            9 2
018600130313     C     ACVTDTMM      SUB       1             AX                2 0
018700130313     C     AX            IFEQ      0
018800130313     C                   Z-ADD     12            AX
018900130313     C                   END
019000240112
019100240112J001  *---
019200240112J001  * Dave A said we don't check the balance (email 3/20/2013 10:45 am)
019300240112J001  * Dave A said we should check the balance meeting 6/26/2013 3pm)
019400240112J001 C                   If        TOTBAL  >     *Zero
019500091029
019600120830     C                   Move      HoldInv       HoldInvA          7
019700110906      *
019800130507      * Load field values to the physical file for Tracy's email process
019900130507     C                   Eval      DNTRST =  AHTRST
020000130507     C                   Eval      DNSUB# =  AHSUB#
020100130507     C                   Eval      DNACCT =  AHACCT
020200130507     C                   Eval      DNTSA  =  %Trim(%Editw(TSA:'0          '))
020300130507     C                   Eval      DNTOT  =  InvTotOut
020400130507     C                   Write     AUTNOTXR
020500130507     C                   Clear                   AUTNOTXR
020600130521     C                   Exsr      $COMNHIST
020700130521     C                   Move      'U82'         TRCODE
020800131010     c                   eval      hstrtime = %time
020900130521     C                   WRITE     HISTR
021000240112      *
021100240112J001 C                   End
021200130521      *
021300090709     C                   EndSr
021400150416
021500150416      *--------------------------------------------------------------------*
021600150416      * calc_amount:  determine the amount to auto debit
021700150416      *--------------------------------------------------------------------*
021800150416       begsr calc_amount ;
021900150416
022000150416        clear invtotout ;
022100150416
022200150416        //?ensure ACH begin date is BEFORE coverage through date...else LEAVE
022300150416        if ahbedt > covbegmo ;
022400150416         leavesr ;
022500150416        endif ;
022600150416
022700150416        //?get acct master record..if not found leave subroutine
022800150416        chain inpkey accmst ;
022900150416        if not %found(accmst) ;
023000150416         leavesr ;
023100150416        endif ;
023200150416
023300150416        //?get ending balance record (type 50) from invele...
023400150416        recordcode = '50' ;
023500150416        clear ieendb ;
023600150416        chain invkey invele ;
023700150416
023800150416        //?determine amt to debit:  if acct is termed use sum of 12 monthly
023900150416        //?buckets from ACCMST.  If active use ending balance on last invoice
024000150416        if atrmdt <> *zeros ;
024100150420         invtotout = %xfoot(bal_arry) ;
024200150416        elseif %found(invele) ;
024300150416         holdinv = ieinv# ;
024400150416         holdcdt = ievcdt ;
024500150416         exsr checkhis ;
024600150416         if inhistory = 'Y' ;
024700150416          leavesr ;
024800150416         endif ;
024900150416         invtotout = ieendb ;
025000150416        endif ;
025100150416
025200150420        if invtotout <= *zeros ;
025300150416         leavesr ;
025400150416        endif ;
025500150416
025600150416        exsr writeout ;
025700150416
025800150416       endsr ;
025900090903      *---------------------------------------------------------------*
026000130312     C     FindInv       Begsr
026100130313      *---------------------------------------------------------------*
026200090909     C                   Z-add     *Zeros        InvTotOut         9 2
026300130319     C                   Eval      RecordCode =  CurrentEnr
026400130319     C                   Z-add     *Zeros        TRAMBTot          9 2
026500130319     C     InvKey        Setll     INVELE
026600130319     C     InvKey        Reade     INVELE
026700130319     C                   Dow       Not %Eof(INVELE)
026800130319     C                   Add       IETRAMB       TRAMBTot
026900130319     C     InvKey        Reade     INVELE
027000130319     C                   EndDo
027100130320     C                   Eval      RecordCode =  Transaction
027200130320     C     InvKey        Setll     INVELE
027300130320     C     InvKey        Reade     INVELE
027400130320     C                   Dow       Not %Eof(INVELE)
027500130320     C                   Add       IETRAMB       InvTotOut
027600130320     C     InvKey        Reade     INVELE
027700130320     C                   EndDo
027800130320     C                   Eval      InvTotOut  =  (TRAMBTot + InvTotOut)
027900130313     C                   Move      IEINV#        HoldInv          10 0
028000130313     C                   Move      IEVCDT        HoldCdt           8 0
028100110225     C                   Move      HoldCdt       CovBegMo
028200120824     C                   If        HoldCdt   >=  AHBEDT
028300101222     C                   Exsr      CheckHis
028400101222     C                   If        InHistory <>  'Y'
028500130315     C                   If        InvTotOut >   *Zero
028600130320     C     InPKey        Chain     ACCMST
028700130320     C                   If        %Found(ACCMST)
028800130320     C                   If        ATRMDT   =    *Zero  Or
028900130320     C                             ATRMDT   >    Today
029000130320     C                   Exsr      WriteOut
029100130320     C                   End
029200130320     C                   End
029300090909     C                   End
029400130315     C                   End
029500120824     C                   End
029600090908
029700090903    ?C                   Endsr
029800070111      *
029900090904    ? *___________________________________________________________________
030000090904    ? * Write a ACH-invoice history record
030100090909    ? *___________________________________________________________________
030200090909    ? * Check whether invoice has already been processed
030300090909    ? *___________________________________________________________________
030400090909    ?C     CheckHis      Begsr
030500090909      *
030600090909     C                   Move      'N'           InHistory         1
030700130313     C                   Move      IEINV#        Invoice#
030800130313     C                   Z-add     InvTotOut     InvTot
030900130313     C                   Eval      RC      =     %Trim(IERC)
031000090909     C     HstKey        Chain     ACHINV
031100090909     C                   If        %Found(ACHINV)
031200090909     C                   Eval      InHistory   = 'Y'
031300090909     C                   End
031400090909    ?C                   Endsr
031500090813      *---------------------------------------------------------------*
031600090813     C     SendEmail1    Begsr
031700090813      *---------------------------------------------------------------*
031800090904     C                   Movel     AHTRST        Trust             3
031900090904     C                   Movel     AHSUB#        Sub#              3
032000090904     C                   Movel     AHACCT        Acct              4
032100110830     C                   Eval      WKERROR  =                   '"' +
032200110830     C                             %Trim(Trust)             + '","' +
032300110830     C                             %Trim(Sub#)              + '","' +
032400110830     C                             %Trim(Acct)              + '","' +
032500110830     C                             %Trim(Error)             + '",'
032600120824     C                   Write     AUTERRSR
032700090813      *
032800090813    ?C                   Endsr
032900130521    ? *___________________________________________________________________
033000130521     C     $COMNHIST     BEGSR
033100130521    ? *___________________________________________________________________
033200130521     C                   CLEAR                   HISTR
033300130521     C                   MOVE      AHTRST        @TRST
033400130521     C                   MOVE      AHSUB#        @SUBD
033500130521     C                   MOVE      AHACCT        @ACCT
033600130521     C     @TRST         CAT(P)    @SUBD:0       HKEY
033700130521     C                   CAT       @ACCT:0       HKEY
033800130521     C                   MOVE      *Blanks       TRMFLG
033900130521     C                   MOVE      *Blanks       TRLFLG
034000130521     C                   MOVE      *ZEROS        HDSEQ#
034100131025     C                   MOVEL     'AUTDEB5R'    HPRGNM
034200130521     C                   Z-ADD     AHTRST        HSTRST
034300130521     C                   Z-ADD     AHSUB#        HSSUB#
034400130521     C                   Z-ADD     AHACCT        HSACCT
034500130521     C                   MOVEL     LUSER         HOPER
034600130521     C                   MOVE      'A'           HSDLTD
034700130521     C     *DATE         Mult      10000.0001    TRDATE
034800190625br01       ck#Not = %Editc( InvTotOut : 'J' );
034900130521      *
035000130521     C                   ENDSR
035100130521    ? *___________________________________________________________________
035200090813    ? *___________________________________________________________________
035300090813    ? * Parameter lists
035400090813    ? *___________________________________________________________________
035500090904    ?C     PLIST         Begsr
035600090813    ?C                   Endsr
035700090903    ? *___________________________________________________________________
035800090903    ? * Klists
035900090903    ? *___________________________________________________________________
036000090904    ?C     KList         Begsr
036100130312    ? *
036200130313     C     InvKey        Klist
036300130312    ?C                   Kfld                    AHTRST
036400130312    ?C                   Kfld                    AHSUB#
036500130312    ?C                   Kfld                    AHACCT
036600130312     C                   Kfld                    CovBegMo
036700130313     C                   Kfld                    RecordCode        2
036800090909    ? *
036900090909     C     InPKey        Klist
037000090909    ?C                   Kfld                    AHTRST
037100090909    ?C                   Kfld                    AHSUB#
037200090909    ?C                   Kfld                    AHACCT
037300090909    ? *
037400090909     C     HstKey        Klist
037500090909     C                   Kfld                    AHTRST
037600090909     C                   Kfld                    AHSUB#
037700090909     C                   Kfld                    AHACCT
037800090909     C                   Kfld                    Invoice#         10 0
037900130313     C                   Kfld                    RC                3
038000090909     C                   Kfld                    InvTot            8 2
038100130313     C                   Kfld                    IEVCDT
038200110225    ? *
038300090903    ?C                   Endsr
038400090903    ? *___________________________________________________________________
038500090903     C     *Inzsr        BEGSR
038600090903    ? *___________________________________________________________________
038700150422     C     *DATE         Mult      10000.0001    Today             8 0
038800120828     C                   Move      Today         TodayA            8
038900120830      *---
039000120830      * Dave A. said we will be looking at the following month's invoice
039100120830      *---
039200120830     C     *ISO          Move      Today         NextMISO
039300120830     C                   Adddur    1:*M          NextMISO
039400120830     C     *ISO          Move      NextMISO      NextMonth
039500120830      *
039600120830     C                   Move      NextMonth     CovMonth
039700120830     C                   Move      NextMonth     CovBegMo
039800120830     C                   Eval      CVDA    =     1
039900120828     C                   Eval      AllMonth =    *Zeros
040000120827     C                   Move      Today         TodayYMD          6 0
040100120824     C                   Move      Today         TodayDD           2 0
040200110831     C     *ISO          Move      Today         TodayISO
040300110831     C                   adddur    1:*D          TodayISO
040400110831     C     *ISO          Move      TodayISO      Tomorrow
040500110831     C     *ISO          Move      Today         CalcDate
040600110831     C     CalcDate      Adddur    2:*d          TwoMoreDay
040700110831     C     CalcDate      Adddur    3:*d          ThreeMoreDay
040800110225     C                   Z-add     99999999      HighDate          8 0
040900090709     C                   Movel     'ACH'         SOURCE            3
041000090709     C                   Z-add     *Zeros        SEQ#              3 0
041100090709     C                   Clear                   BATCH#            3
041200090709     C                   Clear                   STATUS            1
041300090813     C                   Clear                   ACHFound          1
041400110831    ?C                   Call      'DAYOFWEEK'
041500110831    ?C                   Parm                    Day               4
041600110831     C                   Select
041700110831     C                   When      Day      =    '*SAT'
041800110902     C                   Move      TwoMoreDay    PullYMD8
041900110831     C                   When      Day      =    '*FRI'
042000110902     C                   Move      ThreeMoreDay  PullYMD8
042100110831     C                   Other
042200110902     C                   Move      Tomorrow      PullYMD8          8 0
042300110831     C                   End
042400110902     C                   Move      PullYMD8      PullYMD           6 0
042500130507     C                   EndSr
042600010412
042700010403     C/EJECT
