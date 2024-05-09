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
006300150317      * 03/17/2015 Change edit code to keep leading 0's in SSN        *
006400150424      * 04.24.2015 DMA change DP relationship code from 21 to 53       *
006500150424      * 04.25.2015 DMA change several coverage level codes             *
006600150803      * 08.03.2015 DMA go back to 3 character coverage level codes     *
006700150827      * 08.27.2015 JT  Created a xRef file to use new coverage level   *
006800150827      *                codes
                  * 05/09/2024 jt  test fetch 
                  * 05/09/2024 jt  removed *inlr = *on
                  * 05/05/2024 jt  Show VJ
006900150827
007000120606      *  ***************************************************************
007100090202     FPLNMSTN1  IF   E           K Disk
007200110302     FPLNMST    IF   E           K Disk    Rename(PLNMSR:PLNR) Prefix(P)
007300090202     FMCOV39    IF   E           K Disk
007400110302     FMCOV      IF   E           K Disk    Rename(MCOVR:COVR) Prefix(M)
007500090202     FMEMBER    IF   E           K Disk
007600090202     FDEPNDC    IF   E           K Disk
007700090202     FDCOV22    IF   E           K Disk
007800090202     FGRATE     IF   E           K Disk
007900090203     FADVTRMP   UF A E           K Disk
008000090129     FADV10CSV  O  A E             Disk
008100150820     FADVXREF   IF   E           K Disk
008200010326
008300061017     D                UDS
008400061017     D LUSER                  25     32
008500061017
008600061017     D NumA            S             12A   Inz('000000000000') Varying
008700090202     D Advantica       S              3A   Inz('ADV')
008800090202     D Vision          S              3A   Inz('PVS')
008900150820     D tier            S              7
009000150820
009100150820      *====================================================================
009200150820
009300090202     C     Advantica     Setll     PLNMSR
009400090202     C                   Dou       %Eof(PLNMSTN1)
009500090202     C     Advantica     Reade     PLNMSR
009600130916     C                   If        Not %Eof(PLNMSTN1) AND PLNCAT = VISION
009700090202     C     PlnKey        Chain     MCOV39
009800090202     C                   If        Not %Found(MCOV39)
009900090202     C                   Iter
010000090202     C                   End
010100130916     ***
010200130916     C                   IF        (MCTRST = 590 And MCSUB# = 010 AND
010300130916     C                             ACC# = 0006) OR
010400130916     C                             (MCTRST = 590 And MCSUB# = 012 AND
010500130916     C                             ACC# = 0013) OR
010600140122     C                             (MCTRST = 590 And MCSUB# = 009 AND
010700140122     C                             ACC# = 0024) OR
010800130916     C                             (MCTRST = 591 And MCSUB# = 004 AND
010900150224     C                             ACC# = 0366)  OR
011000150224     C                             (MCTRST = 300 AND MCSUB# = 008 AND
011100150224     C                             ACC# = 0066)
011200120723     C                   Iter
011300120723     C                   End
011400090202      *
011500090203     C                   Move      *Zeros        H@SSN             9 0
011600090202     C     PlnKey        Setll     MCOV39
011700090202     C                   Dou       %Eof(MCOV39)
011800090202     C     PlnKey        Reade     MCOV39
011900110221     C***************    If        Not %Eof(MCOV39) AND  ENRLDT  <> CANDT
012000110221     C                   If        Not %Eof(MCOV39)
012100090202     C                   If        CANDT     =   *Zeros
012200090202     C                   Eval      CANDT     =   99999999
012300090202     C                   End
012400090202     C                   If        MCSSNO   <>   H@SSN
012500110302     C                   If        ENRLDT    =   CANDT
012600110302     C                   Exsr      DetermineSDT
012700110302     C                   Else
012800110302     C                   Eval      ActivePlan = 'N'
012900110302     C                   End
013000110302     C                   If        ActivePlan = 'N'
013100061010     C                   Exsr      Process
013200090202     C                   Eval      H@SSN     =   MCSSNO
013300110302     C                   End
013400061017     C                   End
013500090202     C                   End
013600061010     C                   EndDo
013700090202     C                   End
013800090202     C                   EndDo
013900060817        *InLR = '1';
014000010403
014100060817      *---------------------------------------------------------------*
014200061010     C     Process       Begsr
014300060817      *---------------------------------------------------------------*
014400090202     C     MCSSNO        Chain     Member
014500090202      * If record is termed and has not been sent before, post it to term file & send it
014600090202     C                   If        CANDT    <>   99999999
014700090202     C     TrmKey        Chain     ADVTRMP
014800090202     C                   If        %Found(ADVTRMP)
014900090202     C                   LeaveSR
015000090202     C                   Else
015100090202     C                   Clear                   ADVTRMR
015200090202     C                   Eval      ASSNO     =   MCSSNO
015300090202     C                   Eval      ADEPNO    =   00
015400090202     C                   Eval      APLAN     =   MCPLAN
015500090202     C                   Eval      ACOVTYP   =   MCOVTP
015600090202     C                   Eval      ATRST     =   MCTRST
015700090202     C                   Eval      ASUB#     =   MCSUB#
015800090202     C                   Eval      AACCT     =   ACC#
015900090202     C                   Eval      ATRMPDT   =   Today
016000100429     C                   Eval      ATERMDT   =   CANDT
016100090203     C                   Move      CANDT         CANDTP
016200090202      *
016300090202      * Determine last day of month as term date
016400090202     C                   Call      'LSTDAY'
016500090203     C                   Parm                    CANDTP            8
016600090202     C                   Parm                    LastDate          8
016700090202     C                   Parm                    Error            20
016800090203     C                   Move      LastDate      LastDateN
016900100429     C****************** Eval      ATERMDT   =   LastDateN
017000090203     C                   Write     ADVTRMR
017100100429     C                   Exsr      WriteExport
017200090202     C                   Endif
017300100429     C                   Else
017400100429     C                   Exsr      WriteExport
017500090202     C                   Endif
017600100429      *
017700100429     C                   Endsr
017800110302      *---------------------------------------------------------------*
017900110302     C     DetermineSDT  Begsr
018000110302      *---------------------------------------------------------------*
018100110302      * This subroutine is only executed if it's a same-day term.
018200110302      * It will search the member's coverages to determine if there is an
018300110302      * active Advantica plan OTHER than the one that is a same-day term.
018400110302      * The same-day term will be sent ONLY if there is no other active
018500110302      * Advantica plan for the member.
018600110302     C                   Move      'N'           ActivePlan        1
018700110302     C     MCSSNO        Setll     MCOV
018800110302     C     MCSSNO        Reade     MCOV
018900110302     C                   Dow       Not %Eof(MCOV)
019000110302     C                   If        MCANDT = *Zeros OR MCANDT > Today
019100110302     C                                       AND MMCPLAN <> MCPLAN
019200110302     C     PlnCovKey     Chain     PLNMST
019300110302     C                   If        %Found(PLNMST)
019400110302     C                   If        PPCARR     = Advantica
019500110302     C                   Eval      ActivePlan = 'Y'
019600110302     C                   Leave
019700110302     C                   End
019800110302     C                   End
019900110302     C                   End
020000110302     C     MCSSNO        Reade     MCOV
020100110302     C                   Enddo
020200110302     C                   Endsr
020300100429      *---------------------------------------------------------------*
020400100429     C     WriteExport   BEGSR
020500100429      *---------------------------------------------------------------*
020600090202     C                   Exsr      MiscFields
020700090202     C     BIRTH         Mult      10000.0001    DOB               8 0
020800090202     C     ENRLDT        Mult      10000.0001    EFFDT             8 0
020900090202     C                   If        CANDT = 0  OR CANDT = 99999999
021000090204     C                   Move      12319999      EXPDT             8 0
021100090202     C                   Else
021200090203     C                   Move      CANDT         CANDTP
021300090202      * Determine last day of month as term date
021400090202     C                   Call      'LSTDAY'
021500090203     C                   Parm                    CANDTP
021600090203     C                   Parm                    LastDate
021700090203     C                   Parm                    Error
021800090203     C                   Move      LastDate      LastDateN         8 0
021900090203     C     LastDateN     Mult      10000.0001    EXPDT
022000090202     C                   Endif
022100110221      * Carlos at Advantica has requested same day terms
022200110221     C                   If        ENRLDT    =   CANDT
022300110221     C                   Eval      EXPDT     =   ENRLDT
022400110221     C     EXPDT         Mult      10000.0001    EXPDT
022500110221     C                   End
022600110221      *
022700090202     C                   Eval      SSNO      =   MCSSNO
022800090130     C                   Eval      REL       =   '18 '
022900090901     C                   Clear                   Group#New        15
023000090923      *
023100090923     C                   If        GROUP#    =   'SSMGEN    '  Or
023200090923     C                             GROUP#    =   'SSMTNT    '
023300090831     C                   If        EMPST     =   'C'
023400090831     C                   Eval      Group#New =   'SSM 3     '
023500090831     C                   Else
023600090831     C                   If        GROUP#    =   'SSM       '
023700090831     C                   Eval      Group#New =   'SSM GEN   '
023800090831     C                   End
023900090923     C                   If        GROUP#    =   'SSMGEN    '
024000090923     C                   Eval      Group#New =   'SSM GEN   '
024100090923     C                   End
024200090923     C                   If        GROUP#    =   'SSMTNT    '
024300090923     C                   Eval      Group#New =   'SSM TNT   '
024400090923     C                   End
024500090831     C                   End
024600090901     C                   Else
024700090901     C                   Eval      Group#New =   GROUP#
024800090831     C                   End
024900090130     C                   Exsr      WriteSpLine
025000090130     C                   If        MCOVTP   <>   'TIN'
025100090202     C                   Exsr      Dependent
025200090130     C                   End
025300060829      *
025400060817     C                   Endsr
025500090130      *---------------------------------------------------------------*
025600090130     C     WriteSpLine   BEGSR
025700090130      *---------------------------------------------------------------*
025800090130     C                   Eval      WKRECORD  =   '"' +
025900090831     C                                           GROUP#New      + '","' +
026000150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
026100090130     C                                           SUBPOL         + '","' +
026200150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
026300090130     C                                           MEMPOL         + '","' +
026400150317     C                                %Trim(%Editc(SSNO:'X'))   + '","' +
026500150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
026600090130     C                                           TIER           + '","' +
026700090204     C                                           LNAME          + '","' +
026800090204     C                                           FNAME          + '","' +
026900090204     C                                           MI             + '","' +
027000090130     C                                           ADDR1          + '","' +
027100090130     C                                           ADDR2          + '","' +
027200090130     C                                           CITY           + '","' +
027300090130     C                                           STATE          + '","' +
027400120606     C*****************             %Trim(%Editc(ZIP:'P'))      + '","' +
027500120606     C                              %Trim(%Editc(ZIP:'X'))      + '","' +
027600090130     C                                           HP             + '","' +
027700090130     C                                           WP             + '","' +
027800090130     C                                           CP             + '","' +
027900090204     C                                           GENDER         + '","' +
028000090204     C                                 %Trim(%Editw(DOB:'0  /  /    ')) +
028100090202     C                                                            '","' +
028200090130     C                                           REL            + '","' +
028300090204     C                               %Trim(%Editw(EFFDT:'0  /  /    ')) +
028400090202     C                                                            '","' +
028500090204     C                               %Trim(%Editw(EXPDT:'0  /  /    ')) +
028600090202     C                                                            '","' +
028700090130     C                                           NSUF           + '","' +
028800090130     C                                           EMAIL          + '","' +
028900090130     C                                           MARSTS         + '",'
029000090130     C                   Write     ADV10CSR
029100090130      *
029200090130     C                   Endsr
029300080409      *  _____________________________________________________________
029400080409      * *                                                             *
029500080409      * *        Write Excel Spreadsheet Title to CSV File            *
029600080409      * *_____________________________________________________________*
029700080409     C     WriteSpTitle  BEGSR
029800080409     C*
029900090202     C                   Eval      WKRECORD = '"' + 'GroupNumber' + '","' +
030000090202     C                                         'SubscriberNumber' + '","' +
030100090202     C                                   'SubscriberPolicyNumber' + '","' +
030200090202     C                                             'MemberNumber' + '","' +
030300090202     C                                        'MemerPolicyNumber' + '","' +
030400090202     C                                     'SocialSecurityNumber' + '","' +
030500090202     C                                            'SubscriberSSN' + '","' +
030600090202     C                                                 'TierCode' + '","' +
030700090202     C                                                 'LastName' + '","' +
030800090202     C                                                'FirstName' + '","' +
030900090202     C                                               'MiddleName' + '","' +
031000090202     C                                                 'Address1' + '","' +
031100090202     C                                                 'Address2' + '","' +
031200090202     C                                                     'City' + '","' +
031300090202     C                                                    'State' + '","' +
031400090202     C                                                      'Zip' + '","' +
031500090202     C                                                'HomePhone' + '","' +
031600090202     C                                                'WorkPhone' + '","' +
031700090202     C                                                'CellPhone' + '","' +
031800090202     C                                                   'Gender' + '","' +
031900090202     C                                              'DateOfBirth' + '","' +
032000090202     C                                         'RelationshipCode' + '","' +
032100090202     C                                            'EffectiveDate' + '","' +
032200090202     C                                           'ExpirationDate' + '","' +
032300090202     C                                               'NameSuffix' + '","' +
032400090202     C                                                    'Email' + '","' +
032500090202     C                                            'MaritalStatus' + '",'
032600090129     C                   Write     ADV10CSR
032700080409     C*
0328000901290320 C                   EndSr
032900060817
033000090202      *---------------------------------------------------------------*
033100090202     C     MiscFields    Begsr
033200090202      *---------------------------------------------------------------*
033300090202      *
033400090202     C                   Exsr      GetGrp
033500090202     C     BIRTH         Mult      10000.0001    DOB               8 0
033600090204     C                   Eval      LNAME      =  MLNAME
033700090204     C                   Eval      FNAME      =  MFNAME
033800090204     C                   Eval      MI         =  MMI
033900090204     C                   Eval      GENDER     =  SEX
034000090202     C                   Move      *Blanks       SUBPOL           11
034100090202     C                   Move      *Blanks       MEMPOL           11
034200090202     C                   Move      *Blanks       HP               10
034300090202     C                   Move      *Blanks       WP               10
034400090202     C                   Move      *Blanks       CP               10
034500090202     C                   Move      *Blanks       NSUF             11
034600090202     C                   Move      *Blanks       EMAIL             5
034700090202     C                   Move      *Blanks       MARSTS           14
034800090202     C                   Exsr      CovCxref
0349000902020320 C                   EndSr
035000090202
035100090130      *---------------------------------------------------------------*
035200090130     C     Dependent     Begsr
035300090130      *---------------------------------------------------------------*
035400090130      *
035500090130     C     MCSSNO        Setll     DEPENR
035600090130     C                   Dou       %Eof(DEPNDC)
035700090130     C     MCSSNO        Reade     DEPENR
035800090130     C                   IF        Not %Eof(DEPNDC)
035900090130      *
036000090130     C     DepKey        Chain     DCOVR
036100090130     C                   IF        %Found(DCOV22)
036200090130      *
036300090130     C                   Exsr      $DCOV
036400090130      *
036500090130     C                   Endif
036600090130      *
036700090130     C                   Endif
036800090130     C                   Enddo
036900090130      *
037000090130    C                   Endsr
037100090130      *---------------------------------------------------------------*
037200090130     C     $DCOV         BegSr
037300090130      *---------------------------------------------------------------*
037400090130     C     DepKey        SetGt     DCOVR
037500090130     C                   Dou       %Eof(DCOV22)
037600090130     C     DepKey        Readpe    DCOVR
037700110221     C***************    If        Not %Eof(DCOV22) AND DENRDT <> CCANDT
037800110221     C                   If        Not %Eof(DCOV22)
037900090130      *
038000100429     C                   If        CCANDT   <>   99999999  And
038100100429     C                             CCANDT   <>   *Zero
038200100429      * Prepare dependent-info part of term file key
038300100429     C                   Eval      MDSEQ#   =    DSEQ#
038400100429     C                   Eval      CANDT    =    CCANDT
038500100429     C                   Eval      MCPLAN   =    DVPLAN
038600100429     C     TrmKey        Chain     ADVTRMP
038700100429     C                   If        %Found(ADVTRMP)
038800100429     C                   LeaveSr
038900100429     C                   Else
039000100429     C                   Clear                   ADVTRMR
039100100429     C                   Eval      ASSNO    =    MCSSNO
039200100429     C                   Eval      ADEPNO   =    DSEQ#
039300100429     C                   Eval      APLAN    =    DVPLAN
039400100429     C                   Eval      ACOVTYP  =    MCOVTP
039500100429     C                   Eval      ATRST    =    DVTRST
039600100429     C                   Eval      ASUB#    =    DVSUB#
039700100429     C                   Eval      AACCT    =    ACC#
039800100429     C                   Eval      ATRMPDT  =    Today
039900100429     C                   Eval      ATERMDT  =    CCANDT
040000100429     C                   Write     ADVTRMR
040100100429     C                   Exsr      WriteDepExp
040200100429     C                   Endif
040300100429     C                   Else
040400100429     C                   Exsr      WriteDepExp
040500090130     C                   LEAVESR
040600100429     C                   Endif
040700090130      *
040800090130     C                   Endif
040900090130     C                   Enddo
041000090130      *
041100090130     C                   EndSr
041200100429      *---------------------------------------------------------------*
041300100429     C     WriteDepExp   Begsr
041400100429      *---------------------------------------------------------------*
041500100429     C                   Movel     DLNAME        LNAME            18
041600100429     C                   Movel     DFNAME        FNAME            12
041700100429     C                   Movel     DMI           MI                1
041800100429     C                   Movel     DSEX          GENDER            1
041900100429     C                   Eval      SSNO      =   DEPSS#
042000100429     C     DBIRTH        Mult      10000.0001    DOB
042100100429     C     DENRDT        Mult      10000.0001    EFFDT
042200100429     C                   If        CCANDT    =   *Zeros
042300100429     C                   Move      12319999      EXPDT
042400100429     C                   Else
042500100429     C                   Move      CCANDT        CANDTP
042600100429      * Determine last day of month as term date
042700100429     C                   Call      'LSTDAY'
042800100429     C                   Parm                    CANDTP
042900100429     C                   Parm                    LastDate
043000100429     C                   Parm                    Error
043100100429     C                   Move      LastDate      LastDateN
043200100429     C     LastDateN     Mult      10000.0001    EXPDT
043300100429     C                   Endif
043400110221      * Carlos at Advantica has requested same day terms
043500110310     C                   If        DENRDT    =   CCANDT
043600110310     C                   Eval      EXPDT     =   DENRDT
043700110221     C     EXPDT         Mult      10000.0001    EXPDT
043800110221     C                   End
043900110310     C                   If        CCANDT   <>   *Zeros
044000110221     C                   If        DENRDT    =   CCANDT
044100110221     C                   Eval      EXPDT     =   DENRDT
044200110221     C     EXPDT         Mult      10000.0001    EXPDT
044300110221     C                   End
044400110221     C                   End
044500100429      *
044600100429     C                   Select
044700100429     C                   When      DRELCD   =    'RWI'
044800100429     C                   Movel     '01 '         REL               3
044900100429     C                   When      DRELCD   =    'RHU'
045000100429     C                   Movel     '01 '         REL
045100100429     C                   When      DRELCD   =    'RDA'
045200100429     C                   Movel     '19 '         REL
045300100429     C                   When      DRELCD   =    'RSO'
045400100429     C                   Movel     '19 '         REL
045500100429     C                   Other
045600150424     C                   Movel     '53 '         REL
045700100429     C                   EndSl
045800100429     C                   Exsr      WriteSpLine
045900100429      *
046000100429     C                   EndSr
046100090130      *---------------------------------------------------------------*
046200090202     C     CovCxref      Begsr
046300090130      *---------------------------------------------------------------*
046400090130      *
046500140925     ****
046600150824       tier = ' ';
046700150824
046800140925       IF MCTRST = 590 AND MCSUB# = 009 AND ACC# = 0017;
046900140925          IF MCOVTP = 'TIN';
047000140925             TIER = 'EMP';
047100140925          ELSEIF MCOVTP = 'TFA' AND MCOVTP = 'TP2';
047200140925             TIER = 'FAM';
047300140925          ELSE;
047400140925             TIER = 'E1D';
047500140925          ENDIF;
047600140925          LEAVESR;
047700140925       ENDIF;
047800150819
047900150824       // Use xRef file to translate to codes...
048000150824       setll (mctrst : mcsub# : mcplan :acc#) advxrefr;
048100150824       reade (mctrst : mcsub# : mcplan :acc#) advxrefr;
048200150820
048300150820       dow not %eof;
048400150820
048500150820        if mcovtp = advcode1a;
048600150820         tier = advcode1b;
048700150820         leave;
048800150820        endif;
048900150820
049000150824       reade (mctrst : mcsub# : mcplan :acc#) advxrefr;
049100150824
049200150820       enddo;
049300150820
049400090130    C                   Endsr
049500150820
049600090202      *---------------------------------------------------------------*
049700090202     C     GetGrp        BEGSR
049800090202      *---------------------------------------------------------------*
049900090202     c     RatKey        Setll     GRATE
050000090202     c     RatKey        Reade     GRATE
050100090202     c                   Dow       Not %Eof(GRATE)
050200090202     C                   If        (ENRLDT   >=  FRMDAT) and
050300090203     C                             (CANDT    <=  TODAT)
050400090204     C                   LeaveSr
050500090202     C                   End
050600090202     c     RatKey        Reade     GRATE
050700090202     C                   EndDo
050800090202      *
050900090202    C                   Endsr
051000090129      *---------------------------------------------------------------*
051100090129     C     Klist         Begsr
051200090129      *---------------------------------------------------------------*
051300090129      *
051400090202     C     PlnKey        Klist
051500090202     C                   Kfld                    PLTRST
051600090202     C                   Kfld                    PLSUB#
051700090202     C                   Kfld                    PLPLAN
051800090202     *
051900110302     C     PlnCovKey     Klist
052000110302     C                   Kfld                    MMCTRST
052100110302     C                   Kfld                    MMCSUB#
052200110302     C                   Kfld                    MMCPLAN
052300110302     *
052400090202     C     DepKey        Klist
052500090202     C                   Kfld                    MCTRST
052600090202     C                   Kfld                    MCSUB#
052700090202     C                   Kfld                    MCPLAN
052800090202     C                   Kfld                    DSSNO
052900090202     C                   Kfld                    DPSEQ#
053000090202     *
053100090202     C     TrmKey        Klist
053200090202     C                   Kfld                    MCSSNO
053300090202     C                   Kfld                    MDSEQ#
053400090202     C                   Kfld                    CANDT
053500090202     C                   Kfld                    MCPLAN
053600090202     C                   Kfld                    MCOVTP
053700090202     C                   Kfld                    MCTRST
053800090202     C                   Kfld                    MCSUB#
053900090202     C                   Kfld                    ACC#
054000090202     *
054100090202     C     RatKey        Klist
054200090202     C                   Kfld                    MCTRST
054300090202     C                   Kfld                    MCSUB#
054400090202     C                   Kfld                    MCPLAN
054500090202     C                   Kfld                    MCAGEB
054600090202     C                   Kfld                    MCOVTP
054700090202     *
054800090129    C                   Endsr
054900060817      *---------------------------------------------------------------*
055000060817     C     *INZSR        BEGSR
055100060817      *---------------------------------------------------------------*
055200060817     C     *DATE         Mult      10000.0001    Today             8 0
055300070111     C                   Movel     Today         ThisYear          4 0
055400090202     C                   Exsr      WriteSpTitle
055500090129     C                   EndSr
055600010412
055700010403     C/EJECT
