000100020621     H*Indent ('| ')
000200120606      *  ***************************************************************
000300020523      *
000400090129      *             GROUP BENIFIT SERVICES SOFTWARE           2009     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700090129      *  Date Written:   1/29/09                                       *
000800090205      *  Description:  Generate CSV file for Advantica Vision export   *
000900000118      *                                                                *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500090831      *  8/31/09     szz       Per Aliesha at Advantica:  If Cobra,    *
001600090831      *                        use SSM 3 as group#; if TNT, use        *
001700090831      *                        SSM TNT and if anything else (for SSM)  *
001800090831      *                        use SSM GEN.
001900090911      *  9/11/09     szz       Per Aliesha at Advantica:  No TNT; all  *
002000090911      *                        are SSM GEN.                            *
002100110221      *  4/29/10     szz       Per Dave A (email 4/28/10 5pm) Only     *
002200100429      *                        send terms once.                        *
002300110221      *  2/21/11     szz       Per Dave A send same-day terms based on *
002400110221      *                        Carlos (at Advantica's) request.        *
002500110302      *  3/02/11     szz       Per Dave A send same-day terms only if  *
002600110302      *                        no active Advantica coverage exists for *
002700110302      *                        the member.                             *
002800120606      * 06/06/2012  SSK  FIX ZIP CODE EDIT PER ARSINEH VERTANI
002900120606      *                    CHANGE FROM EDIT CODE "P" TO "X"            *
003000120723      *  7/23/12     szz       Per Deborah Clark and Dave A:  do not   *
003100120723      *                        send account 590-10-6 anymore so that   *
003200120723      *                        they will not show as termed.           *
003300120723      * I just did an account cancellation for Corridor Mortgage 590-10-6.
003400120723      * Susie, on the next file to Advantica for this group please be
003500120723      * sure not to send terms for members in group # CORR.
003600120723      * Deborah K. Clark
003700120723      * Client Services Manager                                        *
003800120723      *
003900120723      * From: Susie Zien
004000120723      * Sent: Monday, July 23, 2012 8:40 AM
004100120723      * To: Dave Abeshouse
004200120723      * Subject: FW: Carrier files
004300120723      * Importance: High
004400120723      *
004500120723      * Do you think Deborah's request below means to hard code this
004600120723      * group from being exported (so that a term date will never get sent).
004700120723      *
004800120723      * From: Dave Abeshouse
004900120723      * Sent: Monday, July 23, 2012 8:44 AM
005000120723      * To: Susie Zien
005100120723      * Subject: RE: Carrier files
005200120723      *
005300120723      * That's what she is asking.  They have a cancellation code for t
005400130308      *  3/08/13     szz       Per email from Stephen from Brenda Chaid*
005500130308      *                        3/7/13, do not send a term for Thermoform
005600130308      *                        as they are still active w/Advantica    *
005700130308      *                        590.12.13                               *
005800020621      *                                                                *
005900130916      * 09/16/2013 SSK PER DEB CLARK, REMOVE REDZONE FROM EXPORT       *
006000130916      *                                                                *
006100140122      * 01/22/2013 SSK PER WENDY, REMOVE VAPOTHERM (FI) VERSION        *
006200150224      * 02.24.2015 DMA Per Deborah, remove 300.8.66                   *
006300130916      *                                                                *
006400120606      *  ***************************************************************
006500090202     FPLNMSTN1  IF   E           K Disk
006600110302     FPLNMST    IF   E           K Disk    Rename(PLNMSR:PLNR) Prefix(P)
006700090202     FMCOV39    IF   E           K Disk
006800110302     FMCOV      IF   E           K Disk    Rename(MCOVR:COVR) Prefix(M)
006900090202     FMEMBER    IF   E           K Disk
007000090202     FDEPNDC    IF   E           K Disk
007100090202     FDCOV22    IF   E           K Disk
007200090202     FGRATE     IF   E           K Disk
007300090203     FADVTRMP   UF A E           K Disk
007400090129     FADV10CSV  O  A E             Disk
007500010326
007600061017     D                UDS
007700061017     D LUSER                  25     32
007800061017
007900061017     D NumA            S             12A   Inz('000000000000') Varying
008000090202     D Advantica       S              3A   Inz('ADV')
008100090202     D Vision          S              3A   Inz('PVS')
008200060816      *
008300090202     C     Advantica     Setll     PLNMSR
008400090202     C                   Dou       %Eof(PLNMSTN1)
008500090202     C     Advantica     Reade     PLNMSR
008600130916     C                   If        Not %Eof(PLNMSTN1) AND PLNCAT = VISION
008700090202     C     PlnKey        Chain     MCOV39
008800090202     C                   If        Not %Found(MCOV39)
008900090202     C                   Iter
009000090202     C                   End
009100130916     ***
009200130916     C                   IF        (MCTRST = 590 And MCSUB# = 010 AND
009300130916     C                             ACC# = 0006) OR
009400130916     C                             (MCTRST = 590 And MCSUB# = 012 AND
009500130916     C                             ACC# = 0013) OR
009600140122     C                             (MCTRST = 590 And MCSUB# = 009 AND
009700140122     C                             ACC# = 0024) OR
009800130916     C                             (MCTRST = 591 And MCSUB# = 004 AND
009900150224     C                             ACC# = 0366)  OR
010000150224     C                             (MCTRST = 300 AND MCSUB# = 008 AND
010100150224     C                             ACC# = 0066)
010200120723     C                   Iter
010300120723     C                   End
010400090202      *
010500090203     C                   Move      *Zeros        H@SSN             9 0
010600090202     C     PlnKey        Setll     MCOV39
010700090202     C                   Dou       %Eof(MCOV39)
010800090202     C     PlnKey        Reade     MCOV39
010900110221     C***************    If        Not %Eof(MCOV39) AND  ENRLDT  <> CANDT
011000110221     C                   If        Not %Eof(MCOV39)
011100090202     C                   If        CANDT     =   *Zeros
011200090202     C                   Eval      CANDT     =   99999999
011300090202     C                   End
011400090202     C                   If        MCSSNO   <>   H@SSN
011500110302     C                   If        ENRLDT    =   CANDT
011600110302     C                   Exsr      DetermineSDT
011700110302     C                   Else
011800110302     C                   Eval      ActivePlan = 'N'
011900110302     C                   End
012000110302     C                   If        ActivePlan = 'N'
012100061010     C                   Exsr      Process
012200090202     C                   Eval      H@SSN     =   MCSSNO
012300110302     C                   End
012400061017     C                   End
012500090202     C                   End
012600061010     C                   EndDo
012700090202     C                   End
012800090202     C                   EndDo
012900060817     C                   Eval      *InLR     =   *On
013000010403
013100060817      *---------------------------------------------------------------*
013200061010     C     Process       Begsr
013300060817      *---------------------------------------------------------------*
013400090202     C     MCSSNO        Chain     Member
013500090202      * If record is termed and has not been sent before, post it to term file & send it
013600090202     C                   If        CANDT    <>   99999999
013700090202     C     TrmKey        Chain     ADVTRMP
013800090202     C                   If        %Found(ADVTRMP)
013900090202     C                   LeaveSR
014000090202     C                   Else
014100090202     C                   Clear                   ADVTRMR
014200090202     C                   Eval      ASSNO     =   MCSSNO
014300090202     C                   Eval      ADEPNO    =   00
014400090202     C                   Eval      APLAN     =   MCPLAN
014500090202     C                   Eval      ACOVTYP   =   MCOVTP
014600090202     C                   Eval      ATRST     =   MCTRST
014700090202     C                   Eval      ASUB#     =   MCSUB#
014800090202     C                   Eval      AACCT     =   ACC#
014900090202     C                   Eval      ATRMPDT   =   Today
015000100429     C                   Eval      ATERMDT   =   CANDT
015100090203     C                   Move      CANDT         CANDTP
015200090202      *
015300090202      * Determine last day of month as term date
015400090202     C                   Call      'LSTDAY'
015500090203     C                   Parm                    CANDTP            8
015600090202     C                   Parm                    LastDate          8
015700090202     C                   Parm                    Error            20
015800090203     C                   Move      LastDate      LastDateN
015900100429     C****************** Eval      ATERMDT   =   LastDateN
016000150317     C*******RJ          Write     ADVTRMR
016100100429     C                   Exsr      WriteExport
016200090202     C                   Endif
016300100429     C                   Else
016400100429     C                   Exsr      WriteExport
016500090202     C                   Endif
016600100429      *
016700100429     C                   Endsr
016800110302      *---------------------------------------------------------------*
016900110302     C     DetermineSDT  Begsr
017000110302      *---------------------------------------------------------------*
017100110302      * This subroutine is only executed if it's a same-day term.
017200110302      * It will search the member's coverages to determine if there is an
017300110302      * active Advantica plan OTHER than the one that is a same-day term.
017400110302      * The same-day term will be sent ONLY if there is no other active
017500110302      * Advantica plan for the member.
017600110302     C                   Move      'N'           ActivePlan        1
017700110302     C     MCSSNO        Setll     MCOV
017800110302     C     MCSSNO        Reade     MCOV
017900110302     C                   Dow       Not %Eof(MCOV)
018000110302     C                   If        MCANDT = *Zeros OR MCANDT > Today
018100110302     C                                       AND MMCPLAN <> MCPLAN
018200110302     C     PlnCovKey     Chain     PLNMST
018300110302     C                   If        %Found(PLNMST)
018400110302     C                   If        PPCARR     = Advantica
018500110302     C                   Eval      ActivePlan = 'Y'
018600110302     C                   Leave
018700110302     C                   End
018800110302     C                   End
018900110302     C                   End
019000110302     C     MCSSNO        Reade     MCOV
019100110302     C                   Enddo
019200110302     C                   Endsr
019300100429      *---------------------------------------------------------------*
019400100429     C     WriteExport   BEGSR
019500100429      *---------------------------------------------------------------*
019600090202     C                   Exsr      MiscFields
019700090202     C     BIRTH         Mult      10000.0001    DOB               8 0
019800090202     C     ENRLDT        Mult      10000.0001    EFFDT             8 0
019900090202     C                   If        CANDT = 0  OR CANDT = 99999999
020000090204     C                   Move      12319999      EXPDT             8 0
020100090202     C                   Else
020200090203     C                   Move      CANDT         CANDTP
020300090202      * Determine last day of month as term date
020400090202     C                   Call      'LSTDAY'
020500090203     C                   Parm                    CANDTP
020600090203     C                   Parm                    LastDate
020700090203     C                   Parm                    Error
020800090203     C                   Move      LastDate      LastDateN         8 0
020900090203     C     LastDateN     Mult      10000.0001    EXPDT
021000090202     C                   Endif
021100110221      * Carlos at Advantica has requested same day terms
021200110221     C                   If        ENRLDT    =   CANDT
021300110221     C                   Eval      EXPDT     =   ENRLDT
021400110221     C     EXPDT         Mult      10000.0001    EXPDT
021500110221     C                   End
021600110221      *
021700090202     C                   Eval      SSNO      =   MCSSNO
021800090130     C                   Eval      REL       =   '18 '
021900090901     C                   Clear                   Group#New        15
022000090923      *
022100090923     C                   If        GROUP#    =   'SSMGEN    '  Or
022200090923     C                             GROUP#    =   'SSMTNT    '
022300090831     C                   If        EMPST     =   'C'
022400090831     C                   Eval      Group#New =   'SSM 3     '
022500090831     C                   Else
022600090831     C                   If        GROUP#    =   'SSM       '
022700090831     C                   Eval      Group#New =   'SSM GEN   '
022800090831     C                   End
022900090923     C                   If        GROUP#    =   'SSMGEN    '
023000090923     C                   Eval      Group#New =   'SSM GEN   '
023100090923     C                   End
023200090923     C                   If        GROUP#    =   'SSMTNT    '
023300090923     C                   Eval      Group#New =   'SSM TNT   '
023400090923     C                   End
023500090831     C                   End
023600090901     C                   Else
023700090901     C                   Eval      Group#New =   GROUP#
023800090831     C                   End
023900090130     C                   Exsr      WriteSpLine
024000090130     C                   If        MCOVTP   <>   'TIN'
024100090202     C                   Exsr      Dependent
024200090130     C                   End
024300060829      *
024400060817     C                   Endsr
024500090130      *---------------------------------------------------------------*
024600090130     C     WriteSpLine   BEGSR
024700090130      *---------------------------------------------------------------*
024800090130     C                   Eval      WKRECORD  =   '"' +
024900090831     C                                           GROUP#New      + '","' +
025000150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
025100090130     C                                           SUBPOL         + '","' +
025200090130     C                              %Trim(%Editc(MCSSNO:'P'))   + '","' +
025300090130     C                                           MEMPOL         + '","' +
025400090202     C                                %Trim(%Editc(SSNO:'P'))   + '","' +
025500090130     C                              %Trim(%Editc(MCSSNO:'P'))   + '","' +
025600090130     C                                           TIER           + '","' +
025700090204     C                                           LNAME          + '","' +
025800090204     C                                           FNAME          + '","' +
025900090204     C                                           MI             + '","' +
026000090130     C                                           ADDR1          + '","' +
026100090130     C                                           ADDR2          + '","' +
026200090130     C                                           CITY           + '","' +
026300090130     C                                           STATE          + '","' +
026400120606     C*****************             %Trim(%Editc(ZIP:'P'))      + '","' +
026500120606     C                              %Trim(%Editc(ZIP:'X'))      + '","' +
026600090130     C                                           HP             + '","' +
026700090130     C                                           WP             + '","' +
026800090130     C                                           CP             + '","' +
026900090204     C                                           GENDER         + '","' +
027000090204     C                                 %Trim(%Editw(DOB:'0  /  /    ')) +
027100090202     C                                                            '","' +
027200090130     C                                           REL            + '","' +
027300090204     C                               %Trim(%Editw(EFFDT:'0  /  /    ')) +
027400090202     C                                                            '","' +
027500090204     C                               %Trim(%Editw(EXPDT:'0  /  /    ')) +
027600090202     C                                                            '","' +
027700090130     C                                           NSUF           + '","' +
027800090130     C                                           EMAIL          + '","' +
027900090130     C                                           MARSTS         + '",'
028000090130     C                   Write     ADV10CSR
028100090130      *
028200090130     C                   Endsr
028300080409      * ? _____________________________________________________________
028400080409      *? *                                                             *
028500080409      *? *        Write Excel Spreadsheet Title to CSV File            *
028600080409      *? *_____________________________________________________________*
028700080409     C     WriteSpTitle  BEGSR
028800080409     C*
028900090202     C                   Eval      WKRECORD = '"' + 'GroupNumber' + '","' +
029000090202     C                                         'SubscriberNumber' + '","' +
029100090202     C                                   'SubscriberPolicyNumber' + '","' +
029200090202     C                                             'MemberNumber' + '","' +
029300090202     C                                        'MemerPolicyNumber' + '","' +
029400090202     C                                     'SocialSecurityNumber' + '","' +
029500090202     C                                            'SubscriberSSN' + '","' +
029600090202     C                                                 'TierCode' + '","' +
029700090202     C                                                 'LastName' + '","' +
029800090202     C                                                'FirstName' + '","' +
029900090202     C                                               'MiddleName' + '","' +
030000090202     C                                                 'Address1' + '","' +
030100090202     C                                                 'Address2' + '","' +
030200090202     C                                                     'City' + '","' +
030300090202     C                                                    'State' + '","' +
030400090202     C                                                      'Zip' + '","' +
030500090202     C                                                'HomePhone' + '","' +
030600090202     C                                                'WorkPhone' + '","' +
030700090202     C                                                'CellPhone' + '","' +
030800090202     C                                                   'Gender' + '","' +
030900090202     C                                              'DateOfBirth' + '","' +
031000090202     C                                         'RelationshipCode' + '","' +
031100090202     C                                            'EffectiveDate' + '","' +
031200090202     C                                           'ExpirationDate' + '","' +
031300090202     C                                               'NameSuffix' + '","' +
031400090202     C                                                    'Email' + '","' +
031500090202     C                                            'MaritalStatus' + '",'
031600090129     C                   Write     ADV10CSR
031700080409     C*
0318000901290320 C                   EndSr
031900060817
032000090202      *---------------------------------------------------------------*
032100090202     C     MiscFields    Begsr
032200090202      *---------------------------------------------------------------*
032300090202      *
032400090202     C                   Exsr      GetGrp
032500090202     C     BIRTH         Mult      10000.0001    DOB               8 0
032600090204     C                   Eval      LNAME      =  MLNAME
032700090204     C                   Eval      FNAME      =  MFNAME
032800090204     C                   Eval      MI         =  MMI
032900090204     C                   Eval      GENDER     =  SEX
033000090202     C                   Move      *Blanks       SUBPOL           11
033100090202     C                   Move      *Blanks       MEMPOL           11
033200090202     C                   Move      *Blanks       HP               10
033300090202     C                   Move      *Blanks       WP               10
033400090202     C                   Move      *Blanks       CP               10
033500090202     C                   Move      *Blanks       NSUF             11
033600090202     C                   Move      *Blanks       EMAIL             5
033700090202     C                   Move      *Blanks       MARSTS           14
033800090202     C                   Exsr      CovCxref
0339000902020320 C                   EndSr
034000090202
034100090130      *---------------------------------------------------------------*
034200090130     C     Dependent     Begsr
034300090130      *---------------------------------------------------------------*
034400090130      *
034500090130     C     MCSSNO        Setll     DEPENR
034600090130     C                   Dou       %Eof(DEPNDC)
034700090130     C     MCSSNO        Reade     DEPENR
034800090130     C                   IF        Not %Eof(DEPNDC)
034900090130      *
035000090130     C     DepKey        Chain     DCOVR
035100090130     C                   IF        %Found(DCOV22)
035200090130      *
035300090130     C                   Exsr      $DCOV
035400090130      *
035500090130     C                   Endif
035600090130      *
035700090130     C                   Endif
035800090130     C                   Enddo
035900090130      *
036000090130    ?C                   Endsr
036100090130      *---------------------------------------------------------------*
036200090130     C     $DCOV         BegSr
036300090130      *---------------------------------------------------------------*
036400090130     C     DepKey        SetGt     DCOVR
036500090130     C                   Dou       %Eof(DCOV22)
036600090130     C     DepKey        Readpe    DCOVR
036700110221     C***************    If        Not %Eof(DCOV22) AND DENRDT <> CCANDT
036800110221     C                   If        Not %Eof(DCOV22)
036900090130      *
037000100429     C                   If        CCANDT   <>   99999999  And
037100100429     C                             CCANDT   <>   *Zero
037200100429      * Prepare dependent-info part of term file key
037300100429     C                   Eval      MDSEQ#   =    DSEQ#
037400100429     C                   Eval      CANDT    =    CCANDT
037500100429     C                   Eval      MCPLAN   =    DVPLAN
037600100429     C     TrmKey        Chain     ADVTRMP
037700100429     C                   If        %Found(ADVTRMP)
037800100429     C                   LeaveSr
037900100429     C                   Else
038000100429     C                   Clear                   ADVTRMR
038100100429     C                   Eval      ASSNO    =    MCSSNO
038200100429     C                   Eval      ADEPNO   =    DSEQ#
038300100429     C                   Eval      APLAN    =    DVPLAN
038400100429     C                   Eval      ACOVTYP  =    MCOVTP
038500100429     C                   Eval      ATRST    =    DVTRST
038600100429     C                   Eval      ASUB#    =    DVSUB#
038700100429     C                   Eval      AACCT    =    ACC#
038800100429     C                   Eval      ATRMPDT  =    Today
038900100429     C                   Eval      ATERMDT  =    CCANDT
039000150317     C********RJ         Write     ADVTRMR
039100100429     C                   Exsr      WriteDepExp
039200100429     C                   Endif
039300100429     C                   Else
039400100429     C                   Exsr      WriteDepExp
039500090130     C                   LEAVESR
039600100429     C                   Endif
039700090130      *
039800090130     C                   Endif
039900090130     C                   Enddo
040000090130      *
040100090130     C                   EndSr
040200100429      *---------------------------------------------------------------*
040300100429     C     WriteDepExp   Begsr
040400100429      *---------------------------------------------------------------*
040500100429     C                   Movel     DLNAME        LNAME            18
040600100429     C                   Movel     DFNAME        FNAME            12
040700100429     C                   Movel     DMI           MI                1
040800100429     C                   Movel     DSEX          GENDER            1
040900100429     C                   Eval      SSNO      =   DEPSS#
041000100429     C     DBIRTH        Mult      10000.0001    DOB
041100100429     C     DENRDT        Mult      10000.0001    EFFDT
041200100429     C                   If        CCANDT    =   *Zeros
041300100429     C                   Move      12319999      EXPDT
041400100429     C                   Else
041500100429     C                   Move      CCANDT        CANDTP
041600100429      * Determine last day of month as term date
041700100429     C                   Call      'LSTDAY'
041800100429     C                   Parm                    CANDTP
041900100429     C                   Parm                    LastDate
042000100429     C                   Parm                    Error
042100100429     C                   Move      LastDate      LastDateN
042200100429     C     LastDateN     Mult      10000.0001    EXPDT
042300100429     C                   Endif
042400110221      * Carlos at Advantica has requested same day terms
042500110310     C                   If        DENRDT    =   CCANDT
042600110310     C                   Eval      EXPDT     =   DENRDT
042700110221     C     EXPDT         Mult      10000.0001    EXPDT
042800110221     C                   End
042900110310     C                   If        CCANDT   <>   *Zeros
043000110221     C                   If        DENRDT    =   CCANDT
043100110221     C                   Eval      EXPDT     =   DENRDT
043200110221     C     EXPDT         Mult      10000.0001    EXPDT
043300110221     C                   End
043400110221     C                   End
043500100429      *
043600100429     C                   Select
043700100429     C                   When      DRELCD   =    'RWI'
043800100429     C                   Movel     '01 '         REL               3
043900100429     C                   When      DRELCD   =    'RHU'
044000100429     C                   Movel     '01 '         REL
044100100429     C                   When      DRELCD   =    'RDA'
044200100429     C                   Movel     '19 '         REL
044300100429     C                   When      DRELCD   =    'RSO'
044400100429     C                   Movel     '19 '         REL
044500100429     C                   Other
044600100429     C                   Movel     '21 '         REL
044700100429     C                   EndSl
044800100429     C                   Exsr      WriteSpLine
044900100429      *
045000100429     C                   EndSr
045100090130      *---------------------------------------------------------------*
045200090202     C     CovCxref      Begsr
045300090130      *---------------------------------------------------------------*
045400090130      *
045500140925     ****
045600140925       IF MCTRST = 590 AND MCSUB# = 009 AND ACC# = 0017;
045700140925          IF MCOVTP = 'TIN';
045800140925             TIER = 'EMP';
045900140925          ELSEIF MCOVTP = 'TFA' AND MCOVTP = 'TP2';
046000140925             TIER = 'FAM';
046100140925          ELSE;
046200140925             TIER = 'E1D';
046300140925          ENDIF;
046400140925          LEAVESR;
046500140925       ENDIF;
046600140925     ****
046700090130     C                   Select
046800090202     C                   When      MCOVTP   =    'TIN'
046900090202     C                   Movel     'EMP'         TIER              3
047000090130     C                   When      MCOVTP   =    'TFA'
047100090202     C                   Movel     'FAM'         TIER
047200090130     C                   When      MCOVTP   =    'THW'
047300090202     C                   Movel     'EMS'         TIER
047400090130     C                   When      MCOVTP   =    'TPC'
047500090202     C                   Movel     'ECH'         TIER
047600090130     C                   When      MCOVTP   =    'TP2'
047700090202     C                   Movel     'ECH'         TIER
047800090130     C                   EndSl
047900090130      *
048000090130    ?C                   Endsr
048100090202      *---------------------------------------------------------------*
048200090202     C     GetGrp        BEGSR
048300090202      *---------------------------------------------------------------*
048400090202     c     RatKey        Setll     GRATE
048500090202     c     RatKey        Reade     GRATE
048600090202     c                   Dow       Not %Eof(GRATE)
048700090202     C                   If        (ENRLDT   >=  FRMDAT) and
048800090203     C                             (CANDT    <=  TODAT)
048900090204     C                   LeaveSr
049000090202     C                   End
049100090202     c     RatKey        Reade     GRATE
049200090202     C                   EndDo
049300090202      *
049400090202    ?C                   Endsr
049500090129      *---------------------------------------------------------------*
049600090129     C     Klist         Begsr
049700090129      *---------------------------------------------------------------*
049800090129      *
049900090202     C     PlnKey        Klist
050000090202     C                   Kfld                    PLTRST
050100090202     C                   Kfld                    PLSUB#
050200090202     C                   Kfld                    PLPLAN
050300090202    ? *
050400110302     C     PlnCovKey     Klist
050500110302     C                   Kfld                    MMCTRST
050600110302     C                   Kfld                    MMCSUB#
050700110302     C                   Kfld                    MMCPLAN
050800110302    ? *
050900090202     C     DepKey        Klist
051000090202     C                   Kfld                    MCTRST
051100090202     C                   Kfld                    MCSUB#
051200090202     C                   Kfld                    MCPLAN
051300090202     C                   Kfld                    DSSNO
051400090202     C                   Kfld                    DPSEQ#
051500090202    ? *
051600090202     C     TrmKey        Klist
051700090202     C                   Kfld                    MCSSNO
051800090202     C                   Kfld                    MDSEQ#
051900090202     C                   Kfld                    CANDT
052000090202     C                   Kfld                    MCPLAN
052100090202     C                   Kfld                    MCOVTP
052200090202     C                   Kfld                    MCTRST
052300090202     C                   Kfld                    MCSUB#
052400090202     C                   Kfld                    ACC#
052500090202    ? *
052600090202     C     RatKey        Klist
052700090202     C                   Kfld                    MCTRST
052800090202     C                   Kfld                    MCSUB#
052900090202     C                   Kfld                    MCPLAN
053000090202     C                   Kfld                    MCAGEB
053100090202     C                   Kfld                    MCOVTP
053200090202    ? *
053300090129    ?C                   Endsr
053400060817      *---------------------------------------------------------------*
053500060817     C     *INZSR        BEGSR
053600060817      *---------------------------------------------------------------*
053700060817     C     *DATE         Mult      10000.0001    Today             8 0
053800070111     C                   Movel     Today         ThisYear          4 0
053900090202     C                   Exsr      WriteSpTitle
054000090129     C                   EndSr
054100010412
054200010403     C/EJECT
