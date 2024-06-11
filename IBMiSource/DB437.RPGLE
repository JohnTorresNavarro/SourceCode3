000100060524     H  OPTION(*NODEBUGIO : *SRCSTMT)
0002000503030002 F******************************************************************
0003001111290003 F* DB437      GROUP BENEFIT SERVICES, INC.                        *
0004000503030004 F*                                                                *
0005000503030005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006001111290006 F*            DATE - 11/29/11                                     *
0007000503030007 F*                                                                *
0008001111290011 F* THIS PROGRAM WILL LIST ALL ACTIVE COBRA MEMBERS WITH THE       *
0009001111290011 F* RENEWAL DATE OF EACH ACTIVE PLAN.                              *
0010001201190011 F* 01/19/12 - before this program could go live Admin changed     *
0011001201190011 F*            the definition of the plan renewal so that only     *
0012001201190011 F*            a month is stored and they do not want a m/d/y for  *
0013001201190011 F*            renewal. This report will now only be able to       *
0014001201190011 F*            show the renewal month.                             *
0015001207300011 F* 07/30/12 - add acct sman code to xls                           *
0016002106290011 F* 06/29/21 - add carrier to xls                                  *
0017001201190011 F*                                                                *
0018000503030013 F******************************************************************
001900050228      *
0020001111290005 Fmember    iP   e           k disk
0021001111290005 Faccmst    if   e           k disk
0022000502280005 Fmcov      if   e           k disk
0023000502280018 FPLNMST    IF   e           k DISK
0024002106290018 Fcarmst    if   e           k DISK
0025001111290017 Fdb437xl   o  a e             DISK
002600060524
0027001111300037 D workdtymd       S               d   datfmt(*iso)
0028001111300037 D runymdiso       S               d   datfmt(*iso)
0029000503040125 Dcsv              c                   const('","')
0030001111300125 Dxlmname          s             34
0031001111300037 Dxltsa            S             10  0
0032001111300125 Dxlacnam          s                   like(acnam1)
0033001207300125 Dxlsmancd         s                   like(smancd)
0034001111300125 Dxladdr1          s                   like(addr1)
0035001111300125 Dxladdr2          s                   like(addr2)
0036001111300125 Dxlcsz            s             31
0037001111300037 D xlplan          S                   like(mcplan)
0038001111300037 D xlpland         S                   like(pdescr)
0039002106290037 D xlcname         S                   like(cname)
0040001201200037 D xrenmon         S             15
0041001201200037 D xrenmon#        S              2
004200111130
0043001201190040 D TAB1            S              2  0 DIM(12) CTDATA PERRCD(1)
0044001201190040 D TAB2            S             10    DIM(12) ALT(TAB1)
004500120119
004600071011     D                 dS
0047000503020125 D  tsa                    1     10  0
0048000503010125 D  actrst                 1      3  0
0049000503010125 D  acsub#                 4      6  0
0050000503010125 D  acacct                 7     10  0
005100120120     D                 dS
0052001201200125 D  prenew                 1      8  0
0053001201250125 D  prenewmm               7      8  0
005400111130     D                 dS
0055001111300125 D  zip                    1      9  0
0056001111300125 D  zip5                   1      5
0057001111300125 D  zip4                   6      9
005800050302     D                udS
0059000605240054 D  CONAME               201    240
0060000503030055 D  TIME                 242    247  0
0061000503030157 D  UD8YMD               248    255  0
006200050627
006300111130     c                   exsr      #clear
006400111129
006500060523     c                   clear                   xlmname
006600111129     c                   movel     mfname        xlmname
006700111130     c                   if        mmi <> *blank
006800111130     c                   cat       mmi:1         xlmname
006900111129     c                   cat       '.':0         xlmname
007000111129     c                   end
007100111129     c                   cat       mlname:1      xlmname
007200111130     c                   movel     addr1         xladdr1
007300111130     c                   movel     addr2         xladdr2
007400111130     c                   movel     CITY          xlcsz
007500111130     c                   cat       STATE:2       xlcsz
007600111130     c                   cat       ZIP5:1        xlcsz
007700111130     c                   if        zip4 <> '0000'
007800111130     c                   cat       '-':0         xlcsz
007900111130     c                   cat       ZIP4:0        xlcsz
008000111130     c                   end
008100111130     C                   MOVE      cexpdt        @DATIN
008200111130     C                   EXSR      #DATYM
008300111130     C                   MOVE      @DATOU        xlcexpdt          8 0
008400111130
008500060524
0086001111290171 C     acckey        CHAIN     accmst
008700111129     c                   if        %found(accmst)
008800111130     c                   move      tsa           xltsa
008900111130     c                   movel     acnam1        xlacnam
009000120730     c                   movel     smancd        xlsmancd
009100111129     c                   end
009200111129
009300050303      * find active mcov
009400050228     c     mbssno        setll     mcov
0095000605250131 C                   dou       %eof(mcov)
0096000502280132 C     mbssno        READE     mcov
0097000503040133 c                   if        %eof(mcov) or (enrldt = candt) or
009800111129     c                             (candt <> 0 and candt <= runymd)
009900111129     c                   iter
010000050304     c                   end
010100050228
010200111129      * get plan desc
0103000502280171 C     PLNKEY        CHAIN     PLNMST
010400050228     c                   if        %found(plnmst)
010500060525     c                   move      mcplan        xlplan
010600111130     c                   move      pdescr        xlpland
0107002106290171 C     pcarr         CHAIN     carmst
010800210629     c                   if        %found(carmst)
010900210629     c                   move      cname         xlcname
011000210629     c                   end
011100120119      * get renewl month for this plan
011200111129     c                   exsr      #getrenew
0113001111300184 c                   end
011400111129      * print line here
011500111129     C                   exsr      writexldet
011600060602
011700050304     c                   enddo
011800981229
0119001111290164 C*************************************************************
0120001201190164 C* get plan renewal month
0121001111290164 C*************************************************************
012200111129     C     #getrenew     BEGSR
012300111129
012400120119     c                   clear                   xrenmon
012500120120     c                   clear                   xrenmon#
012600120120     c                   movel     prenewmm      xrenmon#
012700111130
0128001201200209 C     prenewmm      LOOKUP    TAB1          TAB2                     10
012900120119     c                   if        %found
013000120120     c                   movel     tab2          xrenmon
013100120119     c                   end
013200111130
013300111129     c                   endsr
013400111130
0135001111300103  ***************************************************
0136001111300103  * clear output fields
0137001111300103  ***************************************************
0138001111300106 C     #clear        BEGSR
013900111130
014000111130     c                   clear                   xlmname
014100111130     c                   clear                   xladdr1
014200111130     c                   clear                   xladdr2
014300111130     c                   clear                   xlcsz
014400111130     c                   clear                   xlplan
014500111130     c                   clear                   xlpland
014600210629     c                   clear                   xlcname
014700111130     c                   clear                   xltsa
014800111130     c                   clear                   xlacnam
014900120730     c                   clear                   xlsmancd
015000120119     c                   clear                   xrenmon
015100120120     c                   clear                   xrenmon#
015200111130
015300111130     c                   endsr
015400111129
0155001111300103  ***************************************************
0156001111300104  * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0157001111300105  ***************************************************
0158001111300107
0159001111300107  * DATE IN  = @DATIN (8.0) YYYYMMDD
0160001111300107  * DATE OUT = @DATOU (8.0) MMDDYYYY
0161001111300107
0162001111300106 C     #DATYM        BEGSR
016300111130     C                   MOVE      @DATIN        @MD               4 0
016400111130     C                   MOVEL     @DATIN        @Y                4 0
016500111130     C                   MOVEL     @MD           @DATOU            8 0
016600111130     C                   MOVE      @Y            @DATOU
016700111130     C                   MOVE      *ZEROS        @DATIN            8 0
0168001111300120 C                   ENDSR
016900111130
0170000503040164 C*************************************************************
0171000503040164 C*                                                           *
0172000503040164 C* Write Spreadsheet Detail                                  *
0173000503040164 C*                                                           *
0174000503040164 C*************************************************************
017500050304     C     Writexldet    BEGSR
017600050304
017700111129     c                   clear                   db437fld
017800060524
017900111129     C                   Eval      db437fld  = '"' +
018000111130     C                             %trim(%editw(xltsa:'0   -   -    '))  + csv +
018100111130     C                             %trim(xlacnam)                       + csv +
018200120730     C                             %trim(xlsmancd)                      + csv +
018300111130     C                             %trim(%editw(MBSSNO:'0   -  -    ')) + csv +
018400111130     C                             %trim(xlmname)                       + csv +
018500111130     C                             %trim(xladdr1)                       + csv +
018600111130     C                             %trim(xladdr2)                       + csv +
018700111130     C                             %trim(xlcsz)                         + csv +
018800111130     C                             %trim(xlplan)                        + csv +
018900111130     C                             %trim(xlpland)                       + csv +
019000210629     C                             %trim(xlcname)                       + csv +
019100120120     C                             %trim(xrenmon)                       + csv +
019200120120     C                             %trim(xrenmon#)                      + csv +
019300111130     C                             %trim(%editw(xlcexpdt:'0  /  /    ')) + csv +
019400111130     C                             ' '                                  + csv +
019500060526     C                                                                    '",'
019600060524
019700111129     C                   Write     db437xr
0198000503040320 C                   ENDSR
019900050304     C*
020000050304     C/EJECT
020100050304     C*************************************************************
020200050304     C*                                                           *
020300050304     C* Write Spreadsheet heading                                 *
020400050304     C*                                                           *
020500050304     C*************************************************************
020600050304     C     Writexlhead   BEGSR
020700050304
020800111129     c                   clear                   db437fld
020900060524
021000111130     C                   Eval      db437fld = '"' + 'ACCOUNT #'     + csv +
021100111130     C                                              'ACCOUNT NAME'  + csv +
021200120730     C                                              'SMAN'          + csv +
021300111130     C                                              'SSN'           + csv +
021400111130     C                                              'MEMBER NAME'   + csv +
021500111130     C                                              'ADDRESS 1'     + csv +
021600111130     C                                              'ADDRESS 2'     + csv +
021700111130     C                                              'CITY/ST/ZIP'   + csv +
021800111130     C                                              'PLAN'          + csv +
021900111130     C                                              'PLAN DESCRIPTION' + csv +
022000210629     C                                              'CARRIER NAME'  + csv +
022100120120     C                                              'RENEWAL'       + csv +
022200120120     C                                              'MONTH'         + csv +
022300111130     C                                              'COBRA END DT'  + csv +
022400111130     C*                                             ' '             + csv +
022500060526     C                                                                '",'
022600060524
022700111129     C                   Write     db437xr
022800050304     C*
0229000503040320 C                   ENDSR
023000050302      *******************************************
023100011126     c     *inzsr        begsr
023200050302      *******************************************
023300050304
023400050304     C                   Exsr      Writexlhead
023500050302
023600050228     c     plnkey        klist
023700050228     c                   kfld                    mctrst
023800050228     c                   kfld                    mcsub#
023900050228     c                   kfld                    mcplan
024000050228     c     acckey        klist
024100111129     c                   kfld                    mbtrst
024200111129     c                   kfld                    mbsub#
024300111129     c                   kfld                    mbacct
024400060602
024500111130      * default run date to today
024600111130     c                   move      ud8ymd        runymd            8 0
024700111130     c                   move      ud8ymd        runymdiso
024800011126     c                   endsr
024900120119** MONTH NAME TABLE
02500012011901JANUARY
02510012011902FEBRUARY
02520012011903MARCH
02530012011904APRIL
02540012011905MAY
02550012011906JUNE
02560012011907JULY
02570012011908AUGUST
02580012011909SEPTEMBER
02590012011910OCTOBER
02600012011911NOVEMBER
02610012011912DECEMBER
