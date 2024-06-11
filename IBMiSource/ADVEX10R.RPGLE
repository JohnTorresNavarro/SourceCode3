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
006400130916      *                                                                *
006500120606      *  ***************************************************************
006600090202     FPLNMSTN1  IF   E           K Disk
006700110302     FPLNMST    IF   E           K Disk    Rename(PLNMSR:PLNR) Prefix(P)
006800090202     FMCOV39    IF   E           K Disk
006900110302     FMCOV      IF   E           K Disk    Rename(MCOVR:COVR) Prefix(M)
007000090202     FMEMBER    IF   E           K Disk
007100090202     FDEPNDC    IF   E           K Disk
007200090202     FDCOV22    IF   E           K Disk
007300090202     FGRATE     IF   E           K Disk
007400090203     FADVTRMP   UF A E           K Disk
007500090129     FADV10CSV  O  A E             Disk
007600010326
007700061017     D                UDS
007800061017     D LUSER                  25     32
007900061017
008000061017     D NumA            S             12A   Inz('000000000000') Varying
008100090202     D Advantica       S              3A   Inz('ADV')
008200090202     D Vision          S              3A   Inz('PVS')
008300060816      *
008400090202     C     Advantica     Setll     PLNMSR
008500090202     C                   Dou       %Eof(PLNMSTN1)
008600090202     C     Advantica     Reade     PLNMSR
008700130916     C                   If        Not %Eof(PLNMSTN1) AND PLNCAT = VISION
008800090202     C     PlnKey        Chain     MCOV39
008900090202     C                   If        Not %Found(MCOV39)
009000090202     C                   Iter
009100090202     C                   End
009200130916     ***
009300130916     C                   IF        (MCTRST = 590 And MCSUB# = 010 AND
009400130916     C                             ACC# = 0006) OR
009500130916     C                             (MCTRST = 590 And MCSUB# = 012 AND
009600130916     C                             ACC# = 0013) OR
009700140122     C                             (MCTRST = 590 And MCSUB# = 009 AND
009800140122     C                             ACC# = 0024) OR
009900130916     C                             (MCTRST = 591 And MCSUB# = 004 AND
010000150224     C                             ACC# = 0366)  OR
010100150224     C                             (MCTRST = 300 AND MCSUB# = 008 AND
010200150224     C                             ACC# = 0066)
010300120723     C                   Iter
010400120723     C                   End
010500090202      *
010600090203     C                   Move      *Zeros        H@SSN             9 0
010700090202     C     PlnKey        Setll     MCOV39
010800090202     C                   Dou       %Eof(MCOV39)
010900090202     C     PlnKey        Reade     MCOV39
011000110221     C***************    If        Not %Eof(MCOV39) AND  ENRLDT  <> CANDT
011100110221     C                   If        Not %Eof(MCOV39)
011200090202     C                   If        CANDT     =   *Zeros
011300090202     C                   Eval      CANDT     =   99999999
011400090202     C                   End
011500090202     C                   If        MCSSNO   <>   H@SSN
011600110302     C                   If        ENRLDT    =   CANDT
011700110302     C                   Exsr      DetermineSDT
011800110302     C                   Else
011900110302     C                   Eval      ActivePlan = 'N'
012000110302     C                   End
012100110302     C                   If        ActivePlan = 'N'
012200061010     C                   Exsr      Process
012300090202     C                   Eval      H@SSN     =   MCSSNO
012400110302     C                   End
012500061017     C                   End
012600090202     C                   End
012700061010     C                   EndDo
012800090202     C                   End
012900090202     C                   EndDo
013000060817     C                   Eval      *InLR     =   *On
013100010403
013200060817      *---------------------------------------------------------------*
013300061010     C     Process       Begsr
013400060817      *---------------------------------------------------------------*
013500090202     C     MCSSNO        Chain     Member
013600090202      * If record is termed and has not been sent before, post it to term file & send it
013700090202     C                   If        CANDT    <>   99999999
013800090202     C     TrmKey        Chain     ADVTRMP
013900090202     C                   If        %Found(ADVTRMP)
014000090202     C                   LeaveSR
014100090202     C                   Else
014200090202     C                   Clear                   ADVTRMR
014300090202     C                   Eval      ASSNO     =   MCSSNO
014400090202     C                   Eval      ADEPNO    =   00
014500090202     C                   Eval      APLAN     =   MCPLAN
014600090202     C                   Eval      ACOVTYP   =   MCOVTP
014700090202     C                   Eval      ATRST     =   MCTRST
014800090202     C                   Eval      ASUB#     =   MCSUB#
014900090202     C                   Eval      AACCT     =   ACC#
015000090202     C                   Eval      ATRMPDT   =   Today
015100100429     C                   Eval      ATERMDT   =   CANDT
015200090203     C                   Move      CANDT         CANDTP
015300090202      *
015400090202      * Determine last day of month as term date
015500090202     C                   Call      'LSTDAY'
015600090203     C                   Parm                    CANDTP            8
015700090202     C                   Parm                    LastDate          8
015800090202     C                   Parm                    Error            20
015900090203     C                   Move      LastDate      LastDateN
016000100429     C****************** Eval      ATERMDT   =   LastDateN
016100090203     C                   Write     ADVTRMR
016200100429     C                   Exsr      WriteExport
016300090202     C                   Endif
016400100429     C                   Else
016500100429     C                   Exsr      WriteExport
016600090202     C                   Endif
016700100429      *
016800100429     C                   Endsr
016900110302      *---------------------------------------------------------------*
017000110302     C     DetermineSDT  Begsr
017100110302      *---------------------------------------------------------------*
017200110302      * This subroutine is only executed if it's a same-day term.
017300110302      * It will search the member's coverages to determine if there is an
017400110302      * active Advantica plan OTHER than the one that is a same-day term.
017500110302      * The same-day term will be sent ONLY if there is no other active
017600110302      * Advantica plan for the member.
017700110302     C                   Move      'N'           ActivePlan        1
017800110302     C     MCSSNO        Setll     MCOV
017900110302     C     MCSSNO        Reade     MCOV
018000110302     C                   Dow       Not %Eof(MCOV)
018100110302     C                   If        MCANDT = *Zeros OR MCANDT > Today
018200110302     C                                       AND MMCPLAN <> MCPLAN
018300110302     C     PlnCovKey     Chain     PLNMST
018400110302     C                   If        %Found(PLNMST)
018500110302     C                   If        PPCARR     = Advantica
018600110302     C                   Eval      ActivePlan = 'Y'
018700110302     C                   Leave
018800110302     C                   End
018900110302     C                   End
019000110302     C                   End
019100110302     C     MCSSNO        Reade     MCOV
019200110302     C                   Enddo
019300110302     C                   Endsr
019400100429      *---------------------------------------------------------------*
019500100429     C     WriteExport   BEGSR
019600100429      *---------------------------------------------------------------*
019700090202     C                   Exsr      MiscFields
019800090202     C     BIRTH         Mult      10000.0001    DOB               8 0
019900090202     C     ENRLDT        Mult      10000.0001    EFFDT             8 0
020000090202     C                   If        CANDT = 0  OR CANDT = 99999999
020100090204     C                   Move      12319999      EXPDT             8 0
020200090202     C                   Else
020300090203     C                   Move      CANDT         CANDTP
020400090202      * Determine last day of month as term date
020500090202     C                   Call      'LSTDAY'
020600090203     C                   Parm                    CANDTP
020700090203     C                   Parm                    LastDate
020800090203     C                   Parm                    Error
020900090203     C                   Move      LastDate      LastDateN         8 0
021000090203     C     LastDateN     Mult      10000.0001    EXPDT
021100090202     C                   Endif
021200110221      * Carlos at Advantica has requested same day terms
021300110221     C                   If        ENRLDT    =   CANDT
021400110221     C                   Eval      EXPDT     =   ENRLDT
021500110221     C     EXPDT         Mult      10000.0001    EXPDT
021600110221     C                   End
021700110221      *
021800090202     C                   Eval      SSNO      =   MCSSNO
021900090130     C                   Eval      REL       =   '18 '
022000090901     C                   Clear                   Group#New        15
022100090923      *
022200090923     C                   If        GROUP#    =   'SSMGEN    '  Or
022300090923     C                             GROUP#    =   'SSMTNT    '
022400090831     C                   If        EMPST     =   'C'
022500090831     C                   Eval      Group#New =   'SSM 3     '
022600090831     C                   Else
022700090831     C                   If        GROUP#    =   'SSM       '
022800090831     C                   Eval      Group#New =   'SSM GEN   '
022900090831     C                   End
023000090923     C                   If        GROUP#    =   'SSMGEN    '
023100090923     C                   Eval      Group#New =   'SSM GEN   '
023200090923     C                   End
023300090923     C                   If        GROUP#    =   'SSMTNT    '
023400090923     C                   Eval      Group#New =   'SSM TNT   '
023500090923     C                   End
023600090831     C                   End
023700090901     C                   Else
023800090901     C                   Eval      Group#New =   GROUP#
023900090831     C                   End
024000090130     C                   Exsr      WriteSpLine
024100090130     C                   If        MCOVTP   <>   'TIN'
024200090202     C                   Exsr      Dependent
024300090130     C                   End
024400060829      *
024500060817     C                   Endsr
024600090130      *---------------------------------------------------------------*
024700090130     C     WriteSpLine   BEGSR
024800090130      *---------------------------------------------------------------*
024900090130     C                   Eval      WKRECORD  =   '"' +
025000090831     C                                           GROUP#New      + '","' +
025100150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
025200090130     C                                           SUBPOL         + '","' +
025300150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
025400090130     C                                           MEMPOL         + '","' +
025500150317     C                                %Trim(%Editc(SSNO:'X'))   + '","' +
025600150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
025700090130     C                                           TIER           + '","' +
025800090204     C                                           LNAME          + '","' +
025900090204     C                                           FNAME          + '","' +
026000090204     C                                           MI             + '","' +
026100090130     C                                           ADDR1          + '","' +
026200090130     C                                           ADDR2          + '","' +
026300090130     C                                           CITY           + '","' +
026400090130     C                                           STATE          + '","' +
026500120606     C*****************             %Trim(%Editc(ZIP:'P'))      + '","' +
026600120606     C                              %Trim(%Editc(ZIP:'X'))      + '","' +
026700090130     C                                           HP             + '","' +
026800090130     C                                           WP             + '","' +
026900090130     C                                           CP             + '","' +
027000090204     C                                           GENDER         + '","' +
027100090204     C                                 %Trim(%Editw(DOB:'0  /  /    ')) +
027200090202     C                                                            '","' +
027300090130     C                                           REL            + '","' +
027400090204     C                               %Trim(%Editw(EFFDT:'0  /  /    ')) +
027500090202     C                                                            '","' +
027600090204     C                               %Trim(%Editw(EXPDT:'0  /  /    ')) +
027700090202     C                                                            '","' +
027800090130     C                                           NSUF           + '","' +
027900090130     C                                           EMAIL          + '","' +
028000090130     C                                           MARSTS         + '",'
028100090130     C                   Write     ADV10CSR
028200090130      *
028300090130     C                   Endsr
028400080409      * ? _____________________________________________________________
028500080409      *? *                                                             *
028600080409      *? *        Write Excel Spreadsheet Title to CSV File            *
028700080409      *? *_____________________________________________________________*
028800080409     C     WriteSpTitle  BEGSR
028900080409     C*
029000090202     C                   Eval      WKRECORD = '"' + 'GroupNumber' + '","' +
029100090202     C                                         'SubscriberNumber' + '","' +
029200090202     C                                   'SubscriberPolicyNumber' + '","' +
029300090202     C                                             'MemberNumber' + '","' +
029400090202     C                                        'MemerPolicyNumber' + '","' +
029500090202     C                                     'SocialSecurityNumber' + '","' +
029600090202     C                                            'SubscriberSSN' + '","' +
029700090202     C                                                 'TierCode' + '","' +
029800090202     C                                                 'LastName' + '","' +
029900090202     C                                                'FirstName' + '","' +
030000090202     C                                               'MiddleName' + '","' +
030100090202     C                                                 'Address1' + '","' +
030200090202     C                                                 'Address2' + '","' +
030300090202     C                                                     'City' + '","' +
030400090202     C                                                    'State' + '","' +
030500090202     C                                                      'Zip' + '","' +
030600090202     C                                                'HomePhone' + '","' +
030700090202     C                                                'WorkPhone' + '","' +
030800090202     C                                                'CellPhone' + '","' +
030900090202     C                                                   'Gender' + '","' +
031000090202     C                                              'DateOfBirth' + '","' +
031100090202     C                                         'RelationshipCode' + '","' +
031200090202     C                                            'EffectiveDate' + '","' +
031300090202     C                                           'ExpirationDate' + '","' +
031400090202     C                                               'NameSuffix' + '","' +
031500090202     C                                                    'Email' + '","' +
031600090202     C                                            'MaritalStatus' + '",'
031700090129     C                   Write     ADV10CSR
031800080409     C*
0319000901290320 C                   EndSr
032000060817
032100090202      *---------------------------------------------------------------*
032200090202     C     MiscFields    Begsr
032300090202      *---------------------------------------------------------------*
032400090202      *
032500090202     C                   Exsr      GetGrp
032600090202     C     BIRTH         Mult      10000.0001    DOB               8 0
032700090204     C                   Eval      LNAME      =  MLNAME
032800090204     C                   Eval      FNAME      =  MFNAME
032900090204     C                   Eval      MI         =  MMI
033000090204     C                   Eval      GENDER     =  SEX
033100090202     C                   Move      *Blanks       SUBPOL           11
033200090202     C                   Move      *Blanks       MEMPOL           11
033300090202     C                   Move      *Blanks       HP               10
033400090202     C                   Move      *Blanks       WP               10
033500090202     C                   Move      *Blanks       CP               10
033600090202     C                   Move      *Blanks       NSUF             11
033700090202     C                   Move      *Blanks       EMAIL             5
033800090202     C                   Move      *Blanks       MARSTS           14
033900090202     C                   Exsr      CovCxref
0340000902020320 C                   EndSr
034100090202
034200090130      *---------------------------------------------------------------*
034300090130     C     Dependent     Begsr
034400090130      *---------------------------------------------------------------*
034500090130      *
034600090130     C     MCSSNO        Setll     DEPENR
034700090130     C                   Dou       %Eof(DEPNDC)
034800090130     C     MCSSNO        Reade     DEPENR
034900090130     C                   IF        Not %Eof(DEPNDC)
035000090130      *
035100090130     C     DepKey        Chain     DCOVR
035200090130     C                   IF        %Found(DCOV22)
035300090130      *
035400090130     C                   Exsr      $DCOV
035500090130      *
035600090130     C                   Endif
035700090130      *
035800090130     C                   Endif
035900090130     C                   Enddo
036000090130      *
036100090130    ?C                   Endsr
036200090130      *---------------------------------------------------------------*
036300090130     C     $DCOV         BegSr
036400090130      *---------------------------------------------------------------*
036500090130     C     DepKey        SetGt     DCOVR
036600090130     C                   Dou       %Eof(DCOV22)
036700090130     C     DepKey        Readpe    DCOVR
036800110221     C***************    If        Not %Eof(DCOV22) AND DENRDT <> CCANDT
036900110221     C                   If        Not %Eof(DCOV22)
037000090130      *
037100100429     C                   If        CCANDT   <>   99999999  And
037200100429     C                             CCANDT   <>   *Zero
037300100429      * Prepare dependent-info part of term file key
037400100429     C                   Eval      MDSEQ#   =    DSEQ#
037500100429     C                   Eval      CANDT    =    CCANDT
037600100429     C                   Eval      MCPLAN   =    DVPLAN
037700100429     C     TrmKey        Chain     ADVTRMP
037800100429     C                   If        %Found(ADVTRMP)
037900100429     C                   LeaveSr
038000100429     C                   Else
038100100429     C                   Clear                   ADVTRMR
038200100429     C                   Eval      ASSNO    =    MCSSNO
038300100429     C                   Eval      ADEPNO   =    DSEQ#
038400100429     C                   Eval      APLAN    =    DVPLAN
038500100429     C                   Eval      ACOVTYP  =    MCOVTP
038600100429     C                   Eval      ATRST    =    DVTRST
038700100429     C                   Eval      ASUB#    =    DVSUB#
038800100429     C                   Eval      AACCT    =    ACC#
038900100429     C                   Eval      ATRMPDT  =    Today
039000100429     C                   Eval      ATERMDT  =    CCANDT
039100100429     C                   Write     ADVTRMR
039200100429     C                   Exsr      WriteDepExp
039300100429     C                   Endif
039400100429     C                   Else
039500100429     C                   Exsr      WriteDepExp
039600090130     C                   LEAVESR
039700100429     C                   Endif
039800090130      *
039900090130     C                   Endif
040000090130     C                   Enddo
040100090130      *
040200090130     C                   EndSr
040300100429      *---------------------------------------------------------------*
040400100429     C     WriteDepExp   Begsr
040500100429      *---------------------------------------------------------------*
040600100429     C                   Movel     DLNAME        LNAME            18
040700100429     C                   Movel     DFNAME        FNAME            12
040800100429     C                   Movel     DMI           MI                1
040900100429     C                   Movel     DSEX          GENDER            1
041000100429     C                   Eval      SSNO      =   DEPSS#
041100100429     C     DBIRTH        Mult      10000.0001    DOB
041200100429     C     DENRDT        Mult      10000.0001    EFFDT
041300100429     C                   If        CCANDT    =   *Zeros
041400100429     C                   Move      12319999      EXPDT
041500100429     C                   Else
041600100429     C                   Move      CCANDT        CANDTP
041700100429      * Determine last day of month as term date
041800100429     C                   Call      'LSTDAY'
041900100429     C                   Parm                    CANDTP
042000100429     C                   Parm                    LastDate
042100100429     C                   Parm                    Error
042200100429     C                   Move      LastDate      LastDateN
042300100429     C     LastDateN     Mult      10000.0001    EXPDT
042400100429     C                   Endif
042500110221      * Carlos at Advantica has requested same day terms
042600110310     C                   If        DENRDT    =   CCANDT
042700110310     C                   Eval      EXPDT     =   DENRDT
042800110221     C     EXPDT         Mult      10000.0001    EXPDT
042900110221     C                   End
043000110310     C                   If        CCANDT   <>   *Zeros
043100110221     C                   If        DENRDT    =   CCANDT
043200110221     C                   Eval      EXPDT     =   DENRDT
043300110221     C     EXPDT         Mult      10000.0001    EXPDT
043400110221     C                   End
043500110221     C                   End
043600100429      *
043700100429     C                   Select
043800100429     C                   When      DRELCD   =    'RWI'
043900100429     C                   Movel     '01 '         REL               3
044000100429     C                   When      DRELCD   =    'RHU'
044100100429     C                   Movel     '01 '         REL
044200100429     C                   When      DRELCD   =    'RDA'
044300100429     C                   Movel     '19 '         REL
044400100429     C                   When      DRELCD   =    'RSO'
044500100429     C                   Movel     '19 '         REL
044600100429     C                   Other
044700100429     C                   Movel     '21 '         REL
044800100429     C                   EndSl
044900100429     C                   Exsr      WriteSpLine
045000100429      *
045100100429     C                   EndSr
045200090130      *---------------------------------------------------------------*
045300090202     C     CovCxref      Begsr
045400090130      *---------------------------------------------------------------*
045500090130      *
045600140925     ****
045700140925       IF MCTRST = 590 AND MCSUB# = 009 AND ACC# = 0017;
045800140925          IF MCOVTP = 'TIN';
045900140925             TIER = 'EMP';
046000140925          ELSEIF MCOVTP = 'TFA' AND MCOVTP = 'TP2';
046100140925             TIER = 'FAM';
046200140925          ELSE;
046300140925             TIER = 'E1D';
046400140925          ENDIF;
046500140925          LEAVESR;
046600140925       ENDIF;
046700140925     ****
046800090130     C                   Select
046900090202     C                   When      MCOVTP   =    'TIN'
047000090202     C                   Movel     'EMP'         TIER              3
047100090130     C                   When      MCOVTP   =    'TFA'
047200090202     C                   Movel     'FAM'         TIER
047300090130     C                   When      MCOVTP   =    'THW'
047400090202     C                   Movel     'EMS'         TIER
047500090130     C                   When      MCOVTP   =    'TPC'
047600090202     C                   Movel     'ECH'         TIER
047700090130     C                   When      MCOVTP   =    'TP2'
047800090202     C                   Movel     'ECH'         TIER
047900090130     C                   EndSl
048000090130      *
048100090130    ?C                   Endsr
048200090202      *---------------------------------------------------------------*
048300090202     C     GetGrp        BEGSR
048400090202      *---------------------------------------------------------------*
048500090202     c     RatKey        Setll     GRATE
048600090202     c     RatKey        Reade     GRATE
048700090202     c                   Dow       Not %Eof(GRATE)
048800090202     C                   If        (ENRLDT   >=  FRMDAT) and
048900090203     C                             (CANDT    <=  TODAT)
049000090204     C                   LeaveSr
049100090202     C                   End
049200090202     c     RatKey        Reade     GRATE
049300090202     C                   EndDo
049400090202      *
049500090202    ?C                   Endsr
049600090129      *---------------------------------------------------------------*
049700090129     C     Klist         Begsr
049800090129      *---------------------------------------------------------------*
049900090129      *
050000090202     C     PlnKey        Klist
050100090202     C                   Kfld                    PLTRST
050200090202     C                   Kfld                    PLSUB#
050300090202     C                   Kfld                    PLPLAN
050400090202    ? *
050500110302     C     PlnCovKey     Klist
050600110302     C                   Kfld                    MMCTRST
050700110302     C                   Kfld                    MMCSUB#
050800110302     C                   Kfld                    MMCPLAN
050900110302    ? *
051000090202     C     DepKey        Klist
051100090202     C                   Kfld                    MCTRST
051200090202     C                   Kfld                    MCSUB#
051300090202     C                   Kfld                    MCPLAN
051400090202     C                   Kfld                    DSSNO
051500090202     C                   Kfld                    DPSEQ#
051600090202    ? *
051700090202     C     TrmKey        Klist
051800090202     C                   Kfld                    MCSSNO
051900090202     C                   Kfld                    MDSEQ#
052000090202     C                   Kfld                    CANDT
052100090202     C                   Kfld                    MCPLAN
052200090202     C                   Kfld                    MCOVTP
052300090202     C                   Kfld                    MCTRST
052400090202     C                   Kfld                    MCSUB#
052500090202     C                   Kfld                    ACC#
052600090202    ? *
052700090202     C     RatKey        Klist
052800090202     C                   Kfld                    MCTRST
052900090202     C                   Kfld                    MCSUB#
053000090202     C                   Kfld                    MCPLAN
053100090202     C                   Kfld                    MCAGEB
053200090202     C                   Kfld                    MCOVTP
053300090202    ? *
053400090129    ?C                   Endsr
053500060817      *---------------------------------------------------------------*
053600060817     C     *INZSR        BEGSR
053700060817      *---------------------------------------------------------------*
053800060817     C     *DATE         Mult      10000.0001    Today             8 0
053900070111     C                   Movel     Today         ThisYear          4 0
054000090202     C                   Exsr      WriteSpTitle
054100090129     C                   EndSr
054200010412
054300010403     C/EJECT
