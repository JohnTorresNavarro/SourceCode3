0001000503030002 F******************************************************************
0002000503030003 F* DB430      GROUP BENEFIT SERVICES, INC.                        *
0003000503030004 F*                                                                *
0004000503030005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000503030006 F*            DATE - 03/01/05                                     *
0006000503030007 F*                                                                *
0007000503030011 F* THIS PROGRAM WILL LIST THE ACTIVE ELIGIBLE MEMBERS IN FULL     *
0008000503030011 F* SERVICE COBRA ACCOUNTS THAT DO NOT HAVE A COBRA ADMIN FEE PLAN.*
0009000503030011 F*                                                                *
0010000506300011 F* 06/27/05 dlk - change logic to use cobra admin fee to select   *
0011000506300011 F*                accts who pay or do not pay for full service    *
0012000506300011 F*                cobra.                                          *
0013000506300011 F* 06/30/05 dlk - use new field in member file "nonemp" to skip   *
0014000506300011 F*                non-employees.                                  *
0015000605240011 F* 05/24/06 dlk - include accts w/negative cobadm fee when        *
0016000605250011 F*                select no fee is used (fees paid by the broker).*
0017000605250011 F*                Also exclude retirees (memner status = 'R').    *
0018000904070011 F* 04/07/09 dlk - add edit for members with a cobadm fee plan but *
0019000904070011 F*                no other cobra eligible plan (med,den,vis,rx)   *
0020001102040011 F* 02/04/11 dlk - per Shelly and Dave A - Exclude plans OPTM & OPTD
0021001312060011 F*                even though they are a cat type "M". - Per Dave A and Shelly
0022001201190011 F* 01/19/12 dlk - per Shelly add begin admin date to xls
0023001206180011 F* 06/18/12 dlk - add FSA plan category type "F" to list of plans
0024001206180011 F*                eligible for admin fee
0025001312060011  * DLK 12/06/13 - Hard coded exclusion of plans WAVM, WAVD, WAVV due
0026001312060011  *                to a design flaw in OLE. - Per Dave A.
0027001510230011  * DLK 10/23/15 - Hard coded exclusion of plans DECD, DECM and DECV
0028001510230011  *                since no other soultion has been accepted yet
0029001809250011  * 09/24/18 dlk - add EAP plan category type "C" (fed cobra only)
0030001809250011 F*                as eligible for admin fee
0031001812100011  * DLK 12/10/18 - Hard code Humana med and den carriers in md state
0032001812100011  *                accts as ineligible. Humana does not allow state
0033001812100011  *                extension.
0034000904070011 F*                                                                *
0035000503030013 F******************************************************************
003600050228      *
0037000111260005 Faccmst    ip   e           k disk
0038000502280005 Fmemac#    if   e           k disk
0039000502280005 Fmcov      if   e           k disk
0040000506270005 Fmcovx     if   e           k disk    rename(mcovr:mcovxr)
0041000111260005 Fsman      if   e           k disk
0042000503020005 Faacode    if   e           k disk
0043000502280018 FPLNMST    IF   e           k DISK
004400050228     Fcodesl1   IF   E           K DISK
0045000503040017 FDB430xl   o  a e             DISK
0046000503040005 FDB430P    o    f  150        printer oflind(*inof)
0047000503030125 Dmemwoplan        s              5  0
0048000904070125 Dmemwplanerr      s              5  0
0049000503030125 Dmemwithplan      s              5  0
0050000503030125 Dsmantot          s              5  0
0051000904070125 Dsmantot2         s              5  0
0052000503030125 Dlrmem            s              6  0
0053000904070125 Dlrmem2           s              6  0
005400050303
0055000503040125 Dcsv              c                   const('","')
0056000503040125 Daaname           s             20
0057000503030125 Dsmanname         s             25
0058000506270125 Dsmanname20       s             20
0059000503030125 Dmedflg           s              1
0060000503030125 Dyesfee           s              1
0061000503030125 Dmemname          s             20
0062000503040125 Dacnam30          s             30
0063000506270125 Dacnam25          s             25
006400050302     D                 dS
0065000503020125 D  tsa                    1     10  0
0066000503010125 D  actrst                 1      3  0
0067000503010125 D  acsub#                 4      6  0
0068000503010125 D  acacct                 7     10  0
006900050302     D                udS
0070000503020125 D  ldet                   1      1
0071000503020125 D  lacctot                2      2
0072000503020125 D  lsmantot               3      3
0073000506270125 D  lxnofee                4      4
0074000503030125 D  laa                    5      7
0075000503040125 D  lxl                    8      8
0076000503030054 D  CONAME               201    240
0077000503030055 D  TIME                 242    247  0
0078000503030157 D  UD8YMD               248    255  0
007900050228     iaccmsr
008000050301     i                                          smancd        l2
008100050301     i                                          actrst        l1
008200050301     i                                          acsub#        l1
008300050302     i                                          acacct        l1
008400050302     i              aacode                      a_aacode
008500050228
008600050301     c                   if        *inl2
008700050303     c                   clear                   smanname
008800050627     c                   clear                   smanname20
008900050301     c     smancd        chain     sman
009000050301     c                   if        %found(sman)
009100050301     c     sfname        cat       slname:1      smanname
009200050627     c     sfname        cat       slname:1      smanname20
009300050301     c                   end
009400050301     c                   end
009500050301
009600050627      * select acct
009700050302     c                   if        *inl1
009800050627
009900050627     c                   clear                   memwithplan
010000050627     c                   clear                   memwoplan
010100090407     c                   clear                   memwplanerr
010200050627
010300050627      * if "exclude no fee accts" option is selected and acct
010400060524      * does not have a fee
010500050627      * then skip this acct
010600050627      * or skip active acct without full service cobra
010700050627
010800060524     c******             if        (lxnofee = 'Y' and cobadm <= 0) or
010900060524     c                   if        (lxnofee = 'Y' and cobadm = 0) or
011000050627     c                             atrmdt <> 0 or fcstfl = 'N' or
011100050627     c                             acobsrv <> 'F' or actrst = 888
011200050627     c                   goto      #end
011300050627     c                   end
011400050627
011500050627      * check acct for plan # used for admin fee
011600050627     c                   exsr      #chkact
011700050627
011800050303     c                   clear                   aaname
011900050304     c                   movel     acnam1        acnam30
012000050627     c                   movel     acnam1        acnam25
012100120119
012200120119     C                   MOVE      gbsbdt        @DATIN
012300120119     C                   EXSR      #DATYM
012400120119     C                   MOVE      @DATOU        gbsbdtmdy         8 0
012500120119
012600050627
012700050627      * get aa name
012800050302     c     a_aacode      chain     aacode
012900050302     c                   if        %found(aacode)
013000050302     c     afnam         cat       alnam:1       aaname
013100050302     c                   end
013200050302     c                   end
013300050302
013400050630      * read members in acct, skip cobra memebrs and non-employees
013500060525      * and retirees
013600050228     c     acckey        setll     memac#
0137000502280131 C                   dou       %eof(memac#)
0138000502280132 C     acckey        READE     memac#
0139000503040133 C                   if        %eof(memac#) or cexpdt <> 0 or
014000050630     c                             termdt <> 0 or empst = 'C' or
014100060525     c                             empst = 'R' or nonemp = 'Y'
014200050304     c                   iter
014300050304     c                   end
014400050228
014500050303     c                   clear                   medflg
014600050228     c                   clear                   yesfee
014700050302     c                   clear                   memname
014800050303      * find active mcov
014900050228     c     mbssno        setll     mcov
0150000502280131 C                   dou       %eof(mcov)
0151000502280132 C     mbssno        READE     mcov
0152000503040133 c                   if        %eof(mcov) or (enrldt = candt) or
015300050304     c**do not skip future enroll  (enrldt > ud8ymd) or
015400110204     c                             (candt <> 0 and candt <= ud8ymd) or
015500110204      * 2/4/11 exclude opt out payroll plans
015600131206      * 12/06/13 exclude opt out waiver plans per Dave A
015700151023      * 10/23/15 exclude decline plans
015800131206     c                             (mcplan = 'OPTM' or mcplan = 'OPTD' or
015900131206     c                              mcplan = 'WAVM' or mcplan = 'WAVD' or
016000151023     c                              mcplan = 'WAVV' or
016100151023     c                              mcplan = 'DECM' or mcplan = 'DECD' or
016200151023     c                              mcplan = 'DECV')
016300050304     c                   iter
016400050304     c                   end
016500050228
0166000502280171 C     PLNKEY        CHAIN     PLNMST
016700050228     c                   if        %found(plnmst)
016800181210
016900181210      * 12/10/18 - Skip Humana med & den in state accounts since they are
017000181210      *            not elig for state extension
017100181210     c                   if        (pcarr = 'HUM' or pcarr = 'HUD')
017200181210     c                             and fcstfl = 'S'
017300181210     c                   iter
017400181210     c                   end
017500181210
017600180925      * only include medical, dental, vision, rx, FSA and
017700180925      * EAP (Fed cobra only)
017800050303     c     plncat        chain     codesl1
017900050228     c                   if        %found(codesl1) and
018000050228     c                             (action = 'M' or action = 'D' or
018100120618     c                             action = 'V' or action = 'R' or
018200180925     c                             action = 'F' or
018300180925     c                             (action = 'C' and fcstfl = 'F'))
018400050228     c                   eval      medflg = 'Y'
0185000502280184 c                   end
0186000502280184 c                   end
018700050301
018800050301      * plan cat "PCA" = cobra admin fee
018900050302      * count # admin plans in acct
019000050301     c                   if        plncat = 'PCA'
019100050303     c                   move      'Y'           yesfee
019200050302     c                   add       1             memwithplan
019300000928     c                   end
019400050228
019500050304     c                   enddo                                                  MCOV search
019600981229
019700090407      *************
019800050228      * if no cobra admin fee and member has medical plan - print member
019900090407      *************
020000050301     c                   if        yesfee <> 'Y' and medflg = 'Y'
020100050303     c                   add       1             memwoplan
020200050303     c     mfname        cat       mlname:1      memname
020300050304      * print detail
020400050304     c                   if        ldet = 'Y'
020500011126     c   of              except    head
020600011126     c                   except    prt
020700050304     c                   end
020800050304      * write to spreadsheet if requested
020900050304     c                   if        lxl = 'Y'
021000050304     C                   exsr      writexldet
021100050304     c                   end
021200011126     c                   end
021300090407
021400090407      *************
021500090407      * if member has the fee plan but no medical plan - print member
021600090407      * this is an ineligible member with the fee
021700090407      *************
021800090407     c                   if        yesfee = 'Y' and medflg <> 'Y'
021900090407     c                   add       1             memwplanErr
022000090407     c     mfname        cat       mlname:1      memname
022100090407     c                   move      'YES'         NOTELIG           3
022200090407      * print detail
022300090407     c                   if        ldet = 'Y'
022400090407     c   of              except    head
022500090407     c                   except    prt
022600090407     c                   end
022700090407      * write to spreadsheet if requested
022800090407     c                   if        lxl = 'Y'
022900090407     C                   exsr      writexldet
023000090407     c                   end
023100090407     c                   clear                   NOTELIG
023200090407     c                   end
023300090407
023400050228     c                   enddo
023500050301
023600050302     c     #end          tag
023700050302
023800050301     cl1                 exsr      #l1
023900050301     cl2                 exsr      #l2
024000050228     clr                 except    lrtot
024100050301
024200050301      ********************
024300050301      * acct totals
024400050301      ********************
024500050301     c     #l1           begsr
024600050302
024700090407     c                   if        memwoplan <> 0 or memwplanErr <> 0
024800050304      * print acct total
024900050304     c                   if        lacctot = 'Y'
025000050301     c   of              except    head
025100050301     c                   except    prtl1
025200050304     c                   end
025300050304
025400050303     c                   add       memwoplan     smantot
025500090407     c                   add       memwplanerr   smantot2
025600050301     c                   end
025700050302
025800050302     c                   clear                   memwoplan
025900090407     c                   clear                   memwplanerr
026000050301     c                   endsr
026100050301
026200050301      ********************
026300050301      * sman totals
026400050301      ********************
026500050301     c     #l2           begsr
026600050304
026700090407     c                   if        smantot <> 0 or smantot2 <> 0
026800050304      * print sman totals
026900050304     c                   if        lsmantot = 'Y'
027000050301     c   of              except    head
027100050301     c                   except    prtl2
027200050304     c                   end
027300050304
027400050304     c                   add       smantot       lrmem
027500090407     c                   add       smantot2      lrmem2
027600050301     c                   clear                   smantot
027700090407     c                   clear                   smantot2
027800050301     c                   end
027900050304
028000050301     c                   endsr
028100050228
028200050627      ********************
028300050627      * check acct for active admin fee plan #
028400050627      ********************
028500050627     c     #chkact       begsr
028600050627
028700050627     c                   move      'N/A '        caplannum         4
028800050627     c     acckey        setll     mcovx
0289000506270131 C                   dou       %eof(mcovx)
0290000506270132 C     acckey        READE     mcovx
0291000506270133 c                   if        %eof(mcovx) or (enrldt = candt) or
029200050627     c**do not skip future enroll  (enrldt > ud8ymd) or
029300050627     c                             (candt <> 0 and candt <= ud8ymd)
029400050627     c                   iter
029500050627     c                   end
0296000506270171 C     PLNKEY        CHAIN     PLNMST
029700050627     c                   if        %found(plnmst) and
029800050627     c                             plncat = 'PCA'
029900050627     c                   move      mcplan        caplannum
030000050627     c                   leavesr
030100050627     c                   end
030200050627
030300050627     c                   enddo
030400050627
030500050627     c                   endsr
030600050627
0307000503040313 C*
0308000503040164 C*************************************************************
0309000503040164 C*                                                           *
0310000503040164 C* Write Spreadsheet Detail                                  *
0311000503040164 C*                                                           *
0312000503040164 C*************************************************************
031300050304     C     Writexldet    BEGSR
031400050304
031500050304     c                   clear                   db430fld
031600050304     C                   Eval      db430fld  = '"' +
031700050304     C                             smancd + ' '                         + csv +
031800050304     C                             %trim(smanname)                      + csv +
031900050304     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
032000050304     C                             %trim(acnam30)                       + csv +
032100120119     C                             %trim(%editc(gbsbdtmdy:'Y'))         + csv +
032200050627     C                             %trim(%editc(cobadm:'L':*cursym))    + csv +
032300050304     C                             caplannum                            + csv +
032400050304     C                             %trim(aaname)                        + csv +
032500050304     C                             %trim(%editw(mbssno:'0   -  -    ')) + csv +
032600090407     C                             %Trim(memname)                       + csv +
032700090407     C                             %Trim(notelig)               + '",'
032800050304     C*
032900050304     C                   Write     db430xr
0330000503040320 C                   ENDSR
033100050304     C*
033200050304     C/EJECT
033300050304     C*************************************************************
033400050304     C*                                                           *
033500050304     C* Write Spreadsheet heading                                 *
033600050304     C*                                                           *
033700050304     C*************************************************************
033800050304     C     Writexlhead   BEGSR
033900050304
034000050304     c                   clear                   db430fld
034100050304     C                   Eval      db430fld = '"' + 'SMAN'          + csv +
034200050304     C                                              'SALESMAN NAME' + csv +
034300050304     C                                              'ACCOUNT #'     + csv +
034400050304     C                                              'ACCOUNT NAME'  + csv +
034500120119     C                                              'BEGIN ADMIN'   + csv +
034600050627     C                                              'ADMIN FEE'     + csv +
034700050627     C                                              'ADMIN PLAN'    + csv +
034800050304     C                                              'AA NAME'       + csv +
034900050304     C                                              'MEMBER SSN'    + csv +
035000090407     C                                              'MEMBER NAME'   + csv +
035100090407     C                                              'INELIG W/FEE'   + '",'
035200050304     C                   Write     db430xr
035300050304     C*
0354000503040320 C                   ENDSR
0355001201190103 C***************************************************
0356001201190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0357001201190105 C***************************************************
0358001201190107 C*
0359001201190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0360001201190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0361001201190107 C*
0362001201190106 C     #DATYM        BEGSR
036300120119     C                   MOVE      @DATIN        @MD               4 0
036400120119     C                   MOVEL     @DATIN        @Y                4 0
036500120119     C                   MOVEL     @MD           @DATOU            8 0
036600120119     C                   MOVE      @Y            @DATOU
036700120119     C                   MOVE      *ZEROS        @DATIN            8 0
0368001201190120 C                   ENDSR
036900120119     C*
037000050302      *******************************************
037100011126     c     *inzsr        begsr
037200050302      *******************************************
037300050304
037400011126     c                   except    head
037500050304     c                   if        lxl = 'Y'
037600050304     C                   Exsr      Writexlhead
037700050304     c                   end
037800050302
037900050228     c     plnkey        klist
038000050228     c                   kfld                    mctrst
038100050228     c                   kfld                    mcsub#
038200050228     c                   kfld                    mcplan
038300050228     c     acckey        klist
038400011126     c                   kfld                    actrst
038500011126     c                   kfld                    acsub#
038600011126     c                   kfld                    acacct
038700011126     c                   endsr
038800050303     oDB430P    e            head           1  2
0389000503040240 O                       CONAME              95
039000050303     o          e            head           1
0391000503040248 O                                           22 'PROGRAM NAME:    DB430'
0392000503040244 O                                           75 'COBRA ADMIN FEE AUDIT - '
0393000503040244 O                                           +0 'ELIGIBLE MEMBERS W/O PLAN'
039400050304     O                                          141 'PAGE :'
039500050304     O                       page          z    150
039600050303     o          e            head           1
0397000503030253 O                                           13 'RUN DATE    :'
0398000503030254 O                       UDATE         Y     22
039900050304     O                                           +4 'Select: Detail-'
040000050302     O                       ldet                +1
040100050302     O                                           +2 'Acct Tot-'
040200050302     O                       lacctot             +1
040300050302     O                                           +2 'Sman Tot-'
040400050302     O                       lsmantot            +1
040500050627     O                                           +2 'Exclude NO FEE accts-'
040600050627     O                       lxnofee             +1
040700050303     O                                           +2 'AA-'
040800050303     O                       laa                 +1
040900050304     O                                           +2 'Spreadsheet-'
041000050304     O                       lxl                 +1
0411000503040255 O                                          141 'TIME :'
0412000503040256 O                       TIME               150 '  :  :  '
041300050303     o          e            head           1
041400050303     O                                           26 '--------------------------'
041500050303     O                                           52 '--------------------------'
041600050303     O                                           78 '--------------------------'
041700050303     O                                          104 '--------------------------'
041800050303     O                                          130 '--------------------------'
041900050303     O                                          146 '--------------------------'
042000050304     O                                          150 '----'
042100050303     o          e            head           1
042200050302     O                                            8 'SALESMAN'
042300050627     O                                           35 'ACCOUNT'
042400050627     O                                           54 'ACCCOUNT NAME'
042500050627     O                                           74 'ADMIN'
042600050627     O                                           82 'ADMIN'
042700050304     O                                           91 'AA NAME'
042800050304     O                                          115 'MEMBER SSN'
042900050304     O                                          128 'MEMBER NAME'
043000090407     O                                          150 'INELIG'
043100050304     o          e            head           1
043200050627     O                                           35 'NUMBER '
043300050627     O                                           74 'FEE'
043400050627     O                                           82 'PLAN'
043500090407     O                                          150 'W/PLAN'
043600050303     o          e            head           1
043700050302     O                                           26 '--------------------------'
043800050302     O                                           52 '--------------------------'
043900050302     O                                           78 '--------------------------'
044000050302     O                                          104 '--------------------------'
044100050302     O                                          130 '--------------------------'
044200050302     O                                          146 '--------------------------'
044300050304     O                                          150 '----'
044400050304     o          e            prt         1
044500050228     O                       smancd               3
044600050627     O                       smanname20          25
044700050627     O                       tsa                 40 '0   -   -    '
044800050627     O                       acnam25             66
044900050627     O                       cobadm        l     74
045000050627     O                       caplannum           82
045100050304     O                       aaname             104
045200050304     O                       mbssno             116 '0   -  -    '
045300050304     O                       memname            137
045400090407     O                       notelig            150
045500050304     o          e            prtl1       1  1
045600090407     O                                              '*  ELIG MEM W/O PLAN IN '
045700050302     O                       actrst              +0
045800050302     O                                           +0 '-'
045900050302     O                       acsub#              +0
046000050302     O                                           +0 '-'
046100050302     O                       acacct              +0
046200050302     O                                           +1 ': '
046300050302     O                       memwoplan     1     +0
046400090407     O                                           +1 '# W/ PLAN : '
046500050302     O                       memwithplan   1     +0
046600090407     O                                           +1 'AA : '
046700050302     O                       aaname              +0
046800090407     O                                           +1 'SMAN : '
046900090407     O                       smanname20          +1
047000090407     O                                           +1 'INELIG W/PLAN :'
047100090407     O                       memwplanerr   1     +0
047200050304     o          e            prtl2       1  1
047300090407     O                                              '** # ELIG MEM W/O PL'
047400050303     O                                           +0 'AN FOR SMAN '
047500050302     O                       smanname            +1
047600050302     O                                           +1 ': '
047700050302     O                       smantot       1     +0
047800090407     O                                           +1 'INELIG MEM W/PLAN :'
047900090407     O                       smantot2      1     +0
048000050303     o          e            lrtot       1
048100050303     O                                              'TOTAL ELIG MEMBERS W/O ADM'
048200050303     O                                           +0 'IN PLAN :'
048300050302     O                       lrmem         1     +0
048400090407     O                                           +1 'INELIG MEMBERS W/PLAN :'
048500090407     O                       lrmem2        1     +0
