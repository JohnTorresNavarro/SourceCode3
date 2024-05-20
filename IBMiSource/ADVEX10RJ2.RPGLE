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
<<<<<<< Upstream, based on origin/master
                  * 05/09/2024 jt  test fetch 
                  * 05/09/2024 jt  removed *inlr = *on
                  * 05/05/2024 jt  Show VJ
                  * 05/09/2024 jt 3rd tst
                  * 05/09/2024 jt WTF
                  * 05/09/2024 jt Showing JA
                  * 05/16/2024 jt testing pull/fetch
                  * 05/16/2024 jt testing pull/fetch #2
                  * 05/16/2024 jt fetch #3
                  * 05/16/2024 jt #4
                  * 05/20/2024 jt #5
                  * 05/202024  jt #6
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
=======
006900            * 05/09/2024 jt  test fetch
007000            * 05/09/2024 jt  removed *inlr = *on
007100            * 05/05/2024 jt  Show VJ
007200            * 05/09/2024 jt 3rd tst
007300            * 05/09/2024 jt WTF
007400            * 05/09/2024 jt Showing JA
007500            * 05/16/2024 jt testing pull/fetch
007600            * 05/16/2024 jt testing pull/fetch #2
007700            * 05/16/2024 jt fetch #3
007800            * 05/16/2024 jt #4
007801240520      * 05/20/2024 jt #5
007900150827
008000120606      *  ***************************************************************
008100090202     FPLNMSTN1  IF   E           K Disk
008200110302     FPLNMST    IF   E           K Disk    Rename(PLNMSR:PLNR) Prefix(P)
008300090202     FMCOV39    IF   E           K Disk
008400110302     FMCOV      IF   E           K Disk    Rename(MCOVR:COVR) Prefix(M)
008500090202     FMEMBER    IF   E           K Disk
008600090202     FDEPNDC    IF   E           K Disk
008700090202     FDCOV22    IF   E           K Disk
008800090202     FGRATE     IF   E           K Disk
008900090203     FADVTRMP   UF A E           K Disk
009000090129     FADV10CSV  O  A E             Disk
009100150820     FADVXREF   IF   E           K Disk
009200010326
009300061017     D                UDS
009400061017     D LUSER                  25     32
009500061017
009600061017     D NumA            S             12A   Inz('000000000000') Varying
009700090202     D Advantica       S              3A   Inz('ADV')
009800090202     D Vision          S              3A   Inz('PVS')
009900150820     D tier            S              7
010000150820
010100150820      *====================================================================
010200150820
010300090202     C     Advantica     Setll     PLNMSR
010400090202     C                   Dou       %Eof(PLNMSTN1)
010500090202     C     Advantica     Reade     PLNMSR
010600130916     C                   If        Not %Eof(PLNMSTN1) AND PLNCAT = VISION
010700090202     C     PlnKey        Chain     MCOV39
010800090202     C                   If        Not %Found(MCOV39)
010900090202     C                   Iter
011000090202     C                   End
011100130916     ***
011200130916     C                   IF        (MCTRST = 590 And MCSUB# = 010 AND
011300130916     C                             ACC# = 0006) OR
011400130916     C                             (MCTRST = 590 And MCSUB# = 012 AND
011500130916     C                             ACC# = 0013) OR
011600140122     C                             (MCTRST = 590 And MCSUB# = 009 AND
011700140122     C                             ACC# = 0024) OR
011800130916     C                             (MCTRST = 591 And MCSUB# = 004 AND
011900150224     C                             ACC# = 0366)  OR
012000150224     C                             (MCTRST = 300 AND MCSUB# = 008 AND
012100150224     C                             ACC# = 0066)
012200120723     C                   Iter
012300120723     C                   End
012400090202      *
012500090203     C                   Move      *Zeros        H@SSN             9 0
012600090202     C     PlnKey        Setll     MCOV39
012700090202     C                   Dou       %Eof(MCOV39)
012800090202     C     PlnKey        Reade     MCOV39
012900110221     C***************    If        Not %Eof(MCOV39) AND  ENRLDT  <> CANDT
013000110221     C                   If        Not %Eof(MCOV39)
013100090202     C                   If        CANDT     =   *Zeros
013200090202     C                   Eval      CANDT     =   99999999
013300090202     C                   End
013400090202     C                   If        MCSSNO   <>   H@SSN
013500110302     C                   If        ENRLDT    =   CANDT
013600110302     C                   Exsr      DetermineSDT
013700110302     C                   Else
013800110302     C                   Eval      ActivePlan = 'N'
013900110302     C                   End
014000110302     C                   If        ActivePlan = 'N'
014100061010     C                   Exsr      Process
014200090202     C                   Eval      H@SSN     =   MCSSNO
014300110302     C                   End
014400061017     C                   End
014500090202     C                   End
014600061010     C                   EndDo
014700090202     C                   End
014800090202     C                   EndDo
014900060817        *InLR = '1';
015000010403
015100060817      *---------------------------------------------------------------*
015200061010     C     Process       Begsr
015300060817      *---------------------------------------------------------------*
015400090202     C     MCSSNO        Chain     Member
015500090202      * If record is termed and has not been sent before, post it to term file & send it
015600090202     C                   If        CANDT    <>   99999999
015700090202     C     TrmKey        Chain     ADVTRMP
015800090202     C                   If        %Found(ADVTRMP)
015900090202     C                   LeaveSR
016000090202     C                   Else
016100090202     C                   Clear                   ADVTRMR
016200090202     C                   Eval      ASSNO     =   MCSSNO
016300090202     C                   Eval      ADEPNO    =   00
016400090202     C                   Eval      APLAN     =   MCPLAN
016500090202     C                   Eval      ACOVTYP   =   MCOVTP
016600090202     C                   Eval      ATRST     =   MCTRST
016700090202     C                   Eval      ASUB#     =   MCSUB#
016800090202     C                   Eval      AACCT     =   ACC#
016900090202     C                   Eval      ATRMPDT   =   Today
017000100429     C                   Eval      ATERMDT   =   CANDT
017100090203     C                   Move      CANDT         CANDTP
017200090202      *
017300090202      * Determine last day of month as term date
017400090202     C                   Call      'LSTDAY'
017500090203     C                   Parm                    CANDTP            8
017600090202     C                   Parm                    LastDate          8
017700090202     C                   Parm                    Error            20
017800090203     C                   Move      LastDate      LastDateN
017900100429     C****************** Eval      ATERMDT   =   LastDateN
018000090203     C                   Write     ADVTRMR
018100100429     C                   Exsr      WriteExport
018200090202     C                   Endif
018300100429     C                   Else
018400100429     C                   Exsr      WriteExport
018500090202     C                   Endif
018600100429      *
018700100429     C                   Endsr
018800110302      *---------------------------------------------------------------*
018900110302     C     DetermineSDT  Begsr
019000110302      *---------------------------------------------------------------*
019100110302      * This subroutine is only executed if it's a same-day term.
019200110302      * It will search the member's coverages to determine if there is an
019300110302      * active Advantica plan OTHER than the one that is a same-day term.
019400110302      * The same-day term will be sent ONLY if there is no other active
019500110302      * Advantica plan for the member.
019600110302     C                   Move      'N'           ActivePlan        1
019700110302     C     MCSSNO        Setll     MCOV
019800110302     C     MCSSNO        Reade     MCOV
019900110302     C                   Dow       Not %Eof(MCOV)
020000110302     C                   If        MCANDT = *Zeros OR MCANDT > Today
020100110302     C                                       AND MMCPLAN <> MCPLAN
020200110302     C     PlnCovKey     Chain     PLNMST
020300110302     C                   If        %Found(PLNMST)
020400110302     C                   If        PPCARR     = Advantica
020500110302     C                   Eval      ActivePlan = 'Y'
020600110302     C                   Leave
020700110302     C                   End
020800110302     C                   End
020900110302     C                   End
021000110302     C     MCSSNO        Reade     MCOV
021100110302     C                   Enddo
021200110302     C                   Endsr
021300100429      *---------------------------------------------------------------*
021400100429     C     WriteExport   BEGSR
021500100429      *---------------------------------------------------------------*
021600090202     C                   Exsr      MiscFields
021700090202     C     BIRTH         Mult      10000.0001    DOB               8 0
021800090202     C     ENRLDT        Mult      10000.0001    EFFDT             8 0
021900090202     C                   If        CANDT = 0  OR CANDT = 99999999
022000090204     C                   Move      12319999      EXPDT             8 0
022100090202     C                   Else
022200090203     C                   Move      CANDT         CANDTP
022300090202      * Determine last day of month as term date
022400090202     C                   Call      'LSTDAY'
022500090203     C                   Parm                    CANDTP
022600090203     C                   Parm                    LastDate
022700090203     C                   Parm                    Error
022800090203     C                   Move      LastDate      LastDateN         8 0
022900090203     C     LastDateN     Mult      10000.0001    EXPDT
023000090202     C                   Endif
023100110221      * Carlos at Advantica has requested same day terms
023200110221     C                   If        ENRLDT    =   CANDT
023300110221     C                   Eval      EXPDT     =   ENRLDT
023400110221     C     EXPDT         Mult      10000.0001    EXPDT
023500110221     C                   End
023600110221      *
023700090202     C                   Eval      SSNO      =   MCSSNO
023800090130     C                   Eval      REL       =   '18 '
023900090901     C                   Clear                   Group#New        15
024000090923      *
024100090923     C                   If        GROUP#    =   'SSMGEN    '  Or
024200090923     C                             GROUP#    =   'SSMTNT    '
024300090831     C                   If        EMPST     =   'C'
024400090831     C                   Eval      Group#New =   'SSM 3     '
024500090831     C                   Else
024600090831     C                   If        GROUP#    =   'SSM       '
024700090831     C                   Eval      Group#New =   'SSM GEN   '
>>>>>>> ea8ad00 test
024800090831     C                   End
024900090923     C                   If        GROUP#    =   'SSMGEN    '
025000090923     C                   Eval      Group#New =   'SSM GEN   '
025100090923     C                   End
025200090923     C                   If        GROUP#    =   'SSMTNT    '
025300090923     C                   Eval      Group#New =   'SSM TNT   '
025400090923     C                   End
025500090831     C                   End
025600090901     C                   Else
025700090901     C                   Eval      Group#New =   GROUP#
025800090831     C                   End
025900090130     C                   Exsr      WriteSpLine
026000090130     C                   If        MCOVTP   <>   'TIN'
026100090202     C                   Exsr      Dependent
026200090130     C                   End
026300060829      *
026400060817     C                   Endsr
026500090130      *---------------------------------------------------------------*
026600090130     C     WriteSpLine   BEGSR
026700090130      *---------------------------------------------------------------*
026800090130     C                   Eval      WKRECORD  =   '"' +
026900090831     C                                           GROUP#New      + '","' +
027000150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
027100090130     C                                           SUBPOL         + '","' +
027200150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
027300090130     C                                           MEMPOL         + '","' +
027400150317     C                                %Trim(%Editc(SSNO:'X'))   + '","' +
027500150317     C                              %Trim(%Editc(MCSSNO:'X'))   + '","' +
027600090130     C                                           TIER           + '","' +
027700090204     C                                           LNAME          + '","' +
027800090204     C                                           FNAME          + '","' +
027900090204     C                                           MI             + '","' +
028000090130     C                                           ADDR1          + '","' +
028100090130     C                                           ADDR2          + '","' +
028200090130     C                                           CITY           + '","' +
028300090130     C                                           STATE          + '","' +
028400120606     C*****************             %Trim(%Editc(ZIP:'P'))      + '","' +
028500120606     C                              %Trim(%Editc(ZIP:'X'))      + '","' +
028600090130     C                                           HP             + '","' +
028700090130     C                                           WP             + '","' +
028800090130     C                                           CP             + '","' +
028900090204     C                                           GENDER         + '","' +
029000090204     C                                 %Trim(%Editw(DOB:'0  /  /    ')) +
029100090202     C                                                            '","' +
029200090130     C                                           REL            + '","' +
029300090204     C                               %Trim(%Editw(EFFDT:'0  /  /    ')) +
029400090202     C                                                            '","' +
029500090204     C                               %Trim(%Editw(EXPDT:'0  /  /    ')) +
029600090202     C                                                            '","' +
029700090130     C                                           NSUF           + '","' +
029800090130     C                                           EMAIL          + '","' +
029900090130     C                                           MARSTS         + '",'
030000090130     C                   Write     ADV10CSR
030100090130      *
030200090130     C                   Endsr
030300080409      *  _____________________________________________________________
030400080409      * *                                                             *
030500080409      * *        Write Excel Spreadsheet Title to CSV File            *
030600080409      * *_____________________________________________________________*
030700080409     C     WriteSpTitle  BEGSR
030800080409     C*
030900090202     C                   Eval      WKRECORD = '"' + 'GroupNumber' + '","' +
031000090202     C                                         'SubscriberNumber' + '","' +
031100090202     C                                   'SubscriberPolicyNumber' + '","' +
031200090202     C                                             'MemberNumber' + '","' +
031300090202     C                                        'MemerPolicyNumber' + '","' +
031400090202     C                                     'SocialSecurityNumber' + '","' +
031500090202     C                                            'SubscriberSSN' + '","' +
031600090202     C                                                 'TierCode' + '","' +
031700090202     C                                                 'LastName' + '","' +
031800090202     C                                                'FirstName' + '","' +
031900090202     C                                               'MiddleName' + '","' +
032000090202     C                                                 'Address1' + '","' +
032100090202     C                                                 'Address2' + '","' +
032200090202     C                                                     'City' + '","' +
032300090202     C                                                    'State' + '","' +
032400090202     C                                                      'Zip' + '","' +
032500090202     C                                                'HomePhone' + '","' +
032600090202     C                                                'WorkPhone' + '","' +
032700090202     C                                                'CellPhone' + '","' +
032800090202     C                                                   'Gender' + '","' +
032900090202     C                                              'DateOfBirth' + '","' +
033000090202     C                                         'RelationshipCode' + '","' +
033100090202     C                                            'EffectiveDate' + '","' +
033200090202     C                                           'ExpirationDate' + '","' +
033300090202     C                                               'NameSuffix' + '","' +
033400090202     C                                                    'Email' + '","' +
033500090202     C                                            'MaritalStatus' + '",'
033600090129     C                   Write     ADV10CSR
033700080409     C*
0338000901290320 C                   EndSr
033900060817
034000090202      *---------------------------------------------------------------*
034100090202     C     MiscFields    Begsr
034200090202      *---------------------------------------------------------------*
034300090202      *
034400090202     C                   Exsr      GetGrp
034500090202     C     BIRTH         Mult      10000.0001    DOB               8 0
034600090204     C                   Eval      LNAME      =  MLNAME
034700090204     C                   Eval      FNAME      =  MFNAME
034800090204     C                   Eval      MI         =  MMI
034900090204     C                   Eval      GENDER     =  SEX
035000090202     C                   Move      *Blanks       SUBPOL           11
035100090202     C                   Move      *Blanks       MEMPOL           11
035200090202     C                   Move      *Blanks       HP               10
035300090202     C                   Move      *Blanks       WP               10
035400090202     C                   Move      *Blanks       CP               10
035500090202     C                   Move      *Blanks       NSUF             11
035600090202     C                   Move      *Blanks       EMAIL             5
035700090202     C                   Move      *Blanks       MARSTS           14
035800090202     C                   Exsr      CovCxref
0359000902020320 C                   EndSr
036000090202
036100090130      *---------------------------------------------------------------*
036200090130     C     Dependent     Begsr
036300090130      *---------------------------------------------------------------*
036400090130      *
036500090130     C     MCSSNO        Setll     DEPENR
036600090130     C                   Dou       %Eof(DEPNDC)
036700090130     C     MCSSNO        Reade     DEPENR
036800090130     C                   IF        Not %Eof(DEPNDC)
036900090130      *
037000090130     C     DepKey        Chain     DCOVR
037100090130     C                   IF        %Found(DCOV22)
037200090130      *
037300090130     C                   Exsr      $DCOV
037400090130      *
037500090130     C                   Endif
037600090130      *
037700090130     C                   Endif
037800090130     C                   Enddo
037900090130      *
038000090130    C                   Endsr
038100090130      *---------------------------------------------------------------*
038200090130     C     $DCOV         BegSr
038300090130      *---------------------------------------------------------------*
038400090130     C     DepKey        SetGt     DCOVR
038500090130     C                   Dou       %Eof(DCOV22)
038600090130     C     DepKey        Readpe    DCOVR
038700110221     C***************    If        Not %Eof(DCOV22) AND DENRDT <> CCANDT
038800110221     C                   If        Not %Eof(DCOV22)
038900090130      *
039000100429     C                   If        CCANDT   <>   99999999  And
039100100429     C                             CCANDT   <>   *Zero
039200100429      * Prepare dependent-info part of term file key
039300100429     C                   Eval      MDSEQ#   =    DSEQ#
039400100429     C                   Eval      CANDT    =    CCANDT
039500100429     C                   Eval      MCPLAN   =    DVPLAN
039600100429     C     TrmKey        Chain     ADVTRMP
039700100429     C                   If        %Found(ADVTRMP)
039800100429     C                   LeaveSr
039900100429     C                   Else
040000100429     C                   Clear                   ADVTRMR
040100100429     C                   Eval      ASSNO    =    MCSSNO
040200100429     C                   Eval      ADEPNO   =    DSEQ#
040300100429     C                   Eval      APLAN    =    DVPLAN
040400100429     C                   Eval      ACOVTYP  =    MCOVTP
040500100429     C                   Eval      ATRST    =    DVTRST
040600100429     C                   Eval      ASUB#    =    DVSUB#
040700100429     C                   Eval      AACCT    =    ACC#
040800100429     C                   Eval      ATRMPDT  =    Today
040900100429     C                   Eval      ATERMDT  =    CCANDT
041000100429     C                   Write     ADVTRMR
041100100429     C                   Exsr      WriteDepExp
041200100429     C                   Endif
041300100429     C                   Else
041400100429     C                   Exsr      WriteDepExp
041500090130     C                   LEAVESR
041600100429     C                   Endif
041700090130      *
041800090130     C                   Endif
041900090130     C                   Enddo
042000090130      *
042100090130     C                   EndSr
042200100429      *---------------------------------------------------------------*
042300100429     C     WriteDepExp   Begsr
042400100429      *---------------------------------------------------------------*
042500100429     C                   Movel     DLNAME        LNAME            18
042600100429     C                   Movel     DFNAME        FNAME            12
042700100429     C                   Movel     DMI           MI                1
042800100429     C                   Movel     DSEX          GENDER            1
042900100429     C                   Eval      SSNO      =   DEPSS#
043000100429     C     DBIRTH        Mult      10000.0001    DOB
043100100429     C     DENRDT        Mult      10000.0001    EFFDT
043200100429     C                   If        CCANDT    =   *Zeros
043300100429     C                   Move      12319999      EXPDT
043400100429     C                   Else
043500100429     C                   Move      CCANDT        CANDTP
043600100429      * Determine last day of month as term date
043700100429     C                   Call      'LSTDAY'
043800100429     C                   Parm                    CANDTP
043900100429     C                   Parm                    LastDate
044000100429     C                   Parm                    Error
044100100429     C                   Move      LastDate      LastDateN
044200100429     C     LastDateN     Mult      10000.0001    EXPDT
044300100429     C                   Endif
044400110221      * Carlos at Advantica has requested same day terms
044500110310     C                   If        DENRDT    =   CCANDT
044600110310     C                   Eval      EXPDT     =   DENRDT
044700110221     C     EXPDT         Mult      10000.0001    EXPDT
044800110221     C                   End
044900110310     C                   If        CCANDT   <>   *Zeros
045000110221     C                   If        DENRDT    =   CCANDT
045100110221     C                   Eval      EXPDT     =   DENRDT
045200110221     C     EXPDT         Mult      10000.0001    EXPDT
045300110221     C                   End
045400110221     C                   End
045500100429      *
045600100429     C                   Select
045700100429     C                   When      DRELCD   =    'RWI'
045800100429     C                   Movel     '01 '         REL               3
045900100429     C                   When      DRELCD   =    'RHU'
046000100429     C                   Movel     '01 '         REL
046100100429     C                   When      DRELCD   =    'RDA'
046200100429     C                   Movel     '19 '         REL
046300100429     C                   When      DRELCD   =    'RSO'
046400100429     C                   Movel     '19 '         REL
046500100429     C                   Other
046600150424     C                   Movel     '53 '         REL
046700100429     C                   EndSl
046800100429     C                   Exsr      WriteSpLine
046900100429      *
047000100429     C                   EndSr
047100090130      *---------------------------------------------------------------*
047200090202     C     CovCxref      Begsr
047300090130      *---------------------------------------------------------------*
047400090130      *
047500140925     ****
047600150824       tier = ' ';
047700150824
047800140925       IF MCTRST = 590 AND MCSUB# = 009 AND ACC# = 0017;
047900140925          IF MCOVTP = 'TIN';
048000140925             TIER = 'EMP';
048100140925          ELSEIF MCOVTP = 'TFA' AND MCOVTP = 'TP2';
048200140925             TIER = 'FAM';
048300140925          ELSE;
048400140925             TIER = 'E1D';
048500140925          ENDIF;
048600140925          LEAVESR;
048700140925       ENDIF;
048800150819
048900150824       // Use xRef file to translate to codes...
049000150824       setll (mctrst : mcsub# : mcplan :acc#) advxrefr;
049100150824       reade (mctrst : mcsub# : mcplan :acc#) advxrefr;
049200150820
049300150820       dow not %eof;
049400150820
049500150820        if mcovtp = advcode1a;
049600150820         tier = advcode1b;
049700150820         leave;
049800150820        endif;
049900150820
050000150824       reade (mctrst : mcsub# : mcplan :acc#) advxrefr;
050100150824
050200150820       enddo;
050300150820
050400090130    C                   Endsr
050500150820
050600090202      *---------------------------------------------------------------*
050700090202     C     GetGrp        BEGSR
050800090202      *---------------------------------------------------------------*
050900090202     c     RatKey        Setll     GRATE
051000090202     c     RatKey        Reade     GRATE
051100090202     c                   Dow       Not %Eof(GRATE)
051200090202     C                   If        (ENRLDT   >=  FRMDAT) and
051300090203     C                             (CANDT    <=  TODAT)
051400090204     C                   LeaveSr
051500090202     C                   End
051600090202     c     RatKey        Reade     GRATE
051700090202     C                   EndDo
051800090202      *
051900090202    C                   Endsr
052000090129      *---------------------------------------------------------------*
052100090129     C     Klist         Begsr
052200090129      *---------------------------------------------------------------*
052300090129      *
052400090202     C     PlnKey        Klist
052500090202     C                   Kfld                    PLTRST
052600090202     C                   Kfld                    PLSUB#
052700090202     C                   Kfld                    PLPLAN
052800090202     *
052900110302     C     PlnCovKey     Klist
053000110302     C                   Kfld                    MMCTRST
053100110302     C                   Kfld                    MMCSUB#
053200110302     C                   Kfld                    MMCPLAN
053300110302     *
053400090202     C     DepKey        Klist
053500090202     C                   Kfld                    MCTRST
053600090202     C                   Kfld                    MCSUB#
053700090202     C                   Kfld                    MCPLAN
053800090202     C                   Kfld                    DSSNO
053900090202     C                   Kfld                    DPSEQ#
054000090202     *
054100090202     C     TrmKey        Klist
054200090202     C                   Kfld                    MCSSNO
054300090202     C                   Kfld                    MDSEQ#
054400090202     C                   Kfld                    CANDT
054500090202     C                   Kfld                    MCPLAN
054600090202     C                   Kfld                    MCOVTP
054700090202     C                   Kfld                    MCTRST
054800090202     C                   Kfld                    MCSUB#
054900090202     C                   Kfld                    ACC#
055000090202     *
055100090202     C     RatKey        Klist
055200090202     C                   Kfld                    MCTRST
055300090202     C                   Kfld                    MCSUB#
055400090202     C                   Kfld                    MCPLAN
055500090202     C                   Kfld                    MCAGEB
055600090202     C                   Kfld                    MCOVTP
055700090202     *
055800090129    C                   Endsr
055900060817      *---------------------------------------------------------------*
056000060817     C     *INZSR        BEGSR
056100060817      *---------------------------------------------------------------*
056200060817     C     *DATE         Mult      10000.0001    Today             8 0
056300070111     C                   Movel     Today         ThisYear          4 0
056400090202     C                   Exsr      WriteSpTitle
056500090129     C                   EndSr
056600010412
056700010403     C/EJECT
