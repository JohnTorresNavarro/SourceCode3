0000010701160002  ******************************************************************
0000020701160003  * RP360      GROUP BENEFIT SERVICES, INC.              2007      *
0000030701160004  *                                                                *
0000040701160005  *            WRITTEN BY - DAVID KETTERMAN                        *
0000050701160006  *            DATE - 01/09/07                                     *
0000060701160007  *                                                                *
0000070701160008  *  DESCRIPTION - THIS PROGRAM SELECTS ACTIVE ACCOUNTS WITH >= 25 *
0000080701160009  *                MEDICAL MEMBERS TO PRODUCE THE OE GROUP SIZE    *
0000270701160015  *                REPORT.                                         *
0000280701160015  *                                                                *
0000290701160015  *                                                                *
0000300701160013  ******************************************************************
000031070109
0001000701050005 Faccmst    ip   e             disk
0001020111260005 Fsman      if   e           k disk
0001030701150005 Fac2mst    if   e           k disk
0001040701150014 Fmktcara1  IF   e           k DISK
0001050701150016 Fmcov14    IF   e           k DISK
0001060701150016 Fcmct14    IF   e           k DISK
0001070701150016 Fplnmst    IF   e           k DISK
0001080701150017 Frp360xl   o  a e             DISK
0001090701170005 Frp360p    o    f  132        printer oflind(*inof)
0001170701150125 Dsname            s             25
0001180701150125 Df                s              1    inz('F')
0001190701150125 Da                s              1  0
0001200701150125 Dfinact           s              6  0
0001210701150125 Dfinmed           s              7  0
0001220701150125 Dfintot           s              7  0
0001230701150125 Dparityout        s                   like(a2par)
000124070105      * the size ranges for this report
0001250701050125 Dsize1            s              7  0 inz(25)                              25 - 49
0001260701050125 Dsize2            s              7  0 inz(50)                              50 - 99
0001270701050125 Dsize3            s              7  0 inz(100)                             100 - 199
0001280701050125 Dsize4            s              7  0 inz(200)                             200+
0001290701150125 Dsize1des         s              9    inz('25  - 49 ')                     25 - 49
0001300701150125 Dsize2des         s              9    inz('50  - 99 ')                     50 - 99
0001310701150125 Dsize3des         s              9    inz('100 - 199')                     100 - 199
0001320701150125 Dsize4des         s              9    inz('200+     ')                     200+
0001330701150045 D desout          s              9
0001340701150045 D actout          s              5  0
0001350701150045 D medout          s              7  0
0001360701150045 D totout          s              7  0
0001370701150044 D                 dS
0001380701150045 D tsa                     1     10  0
0001390701150045 D actrst                  1      3  0
0001400701150045 D acsub#                  4      6  0
0001410701150045 D acacct                  7     10  0
000142070115
000143070115      * broker totals
0001440701150044 D bktot           dS                  dim(4) qualified inz
0001450701150045 D des                            9
0001460701150045 D act                            5  0
0001470701150045 D med                            7  0
0001480701150045 D tot                            7  0
000149070115      * final totals
0001500701150044 D lrtot           dS                  dim(4) qualified inz
0001510701150045 D des                            9
0001520701150045 D act                            6  0
0001530701150045 D med                            7  0
0001540701150045 D tot                            7  0
0001550701150044 D                 dS
0001560701150045 D  runymd                 1      8  0
0001570701150045 D  RUNy                   1      4  0
0001580701150045 D  RUNm                   5      6  0
0001590701150045 D  RUNd                   7      8  0
0001600701150044 D                udS
0001610701160045 D lexclude                1      1
0001620701160045 D  coname               201    240
000163070105      *
000164070105     iaccmsr
000165070105     i                                          smancd        l1
000166070105
000167070105      * new sman - get name
000168070105     c                   if        *inl1
000169070105     c                   clear                   sname
000170070115     c                   clear                   bktot
000171070115     c                   eval      bktot(4).des = size4des
000172070115     c                   eval      bktot(3).des = size3des
000173070115     c                   eval      bktot(2).des = size2des
000174070115     c                   eval      bktot(1).des = size1des
000175070115
000176070105     c     smancd        chain     sman
000177070105     c                   if        %found(sman)
000178070105     c                   eval      sname = %trim(sfname) + ' ' +
000179070105     c                                     %trim(slname)
000180070116     c                   end
000181070105     c   of              except    head
000182070105     c                   except    l1det
000183070105     c                   end
000184011126
000185070105      * accumulate # of med members by size
000186070105     c                   select
000187070105     c                   when      medemp >= size4
000702070115     c                   eval      bktot(4).act = bktot(4).act + 1
000703070115     c                   eval      bktot(4).med = bktot(4).med + medemp
000704070115     c                   eval      bktot(4).tot = bktot(4).tot + totemp
000705070105     c                   when      medemp >= size3
000707070115     c                   eval      bktot(3).act = bktot(3).act + 1
000708070115     c                   eval      bktot(3).med = bktot(3).med + medemp
000709070115     c                   eval      bktot(3).tot = bktot(3).tot + totemp
000710070105     c                   when      medemp >= size2
000712070115     c                   eval      bktot(2).act = bktot(2).act + 1
000713070115     c                   eval      bktot(2).med = bktot(2).med + medemp
000714070115     c                   eval      bktot(2).tot = bktot(2).tot + totemp
000715070105     c                   when      medemp >= size1
000717070115     c                   eval      bktot(1).act = bktot(1).act + 1
000718070115     c                   eval      bktot(1).med = bktot(1).med + medemp
000719070115     c                   eval      bktot(1).tot = bktot(1).tot + totemp
000720070105     c                   endsl
000721070105
000722070115      * get parity flag
000723070115     c                   clear                   parityout
000724070115     c     ac2key        chain     ac2mst
000725070115     c                   if        %found(ac2mst)
000726070115     c                   eval      parityout = a2par
000727070115     c                   end
000729070115
000730070115      * get market size
000731070115     c                   exsr      #getmkt
000732070115
000743070105      * print detail line
000744011126     c   of              except    head
000745011126     c                   except    prt
000746070105
000747070115      * write excel file
000748070115     c                   exsr      writexldet
000749070115
000750070105     cl1                 exsr      #l1tot
000751070105     clr                 exsr      #lrtot
000752070105
000795070115      *************************************************************
000796070115      * get market size for this acct's medical plan
000797070115      *************************************************************
000798070115     c     #getmkt       begsr
000799070115
000800070115     c                   clear                   activemed
000801070115     c                   clear                   medcarr
000802070115     c                   clear                   sizeout
000803070115
000804070115     C     CCKEY         SETLL     CMCT14
0008050701150078 C                   dou       %eof(cmct14) or activemed = 'Y'
0008060701150080 C     CCKEY         READE     CMCT14
000807070115     c                   if        not %eof(cmct14) and cmcan = 0
000808070115     c     plnkey        chain     plnmst
000809070115     c                   if        not %found(plnmst) or plncat <> 'PMM'
000810070115     C                   iter
000811070115     C                   end
000812070115     C                   move      pcarr         medcarr           3
000813070116
000814070116      * look for active coverage
000815070115     C     mckey         SETLL     mcov14
0008160701150078 C                   dou       %eof(mcov14)
0008170701150080 C     mckey         READE     mcov14
000818070115     c                   if        not %eof(mcov14) and candt = 0
000819070115     C                   move      'Y'           activemed         1
000820070115     C                   leave
0008210701150523 C                   end
000822070115     c                   enddo
000823070115
0008240701150523 C                   end
000825070115     c                   enddo
000826070115
000827070115      * if active medical found get market size
000828070115     c                   if        activemed = 'Y'
000829070115     c* get market size - defalut to 50
000830070115     c                   movel     '50   '       sizeout           5
000831070115     c     mkcaky        setll     mktcara1
000832070115     C                   dou       %eof(mktcara1)
000833070115     c     mkcaky        reade     mktcara1
000834070115     c                   if        %eof(mktcara1)
000835070115     c                   leave
000836070115     c                   end
000837070115     c                   if        runymd < mafrdt or (matodt <> 0 and
000838070115     c                             runymd > matodt) or (mafrdt = matodt)
000839070115     c                   iter
000840070115     c                   end
000841070115     c                   movel     maszcd        sizeout
000842070115     c                   enddo
000843070115
000844070115     c                   end
000845070115
000846070115     c                   endsr
000847070115
000848070115      **************************************************
000849070115      * print broker totals
000850070115      **************************************************
000851070115     c     #l1tot        begsr
000852070115
000853070115        // print totals in descending order by size
000854070115      /free
000855070115       a=4;
000856070115       except l1tothead;
000857070115       dow a >= 1;
000858070115        if *inof = *on;
000859070115        except head;
000860070115        endif;
000861070115        desout = bktot(a).des;
000862070115        actout = bktot(a).act;
000863070115        medout = bktot(a).med;
000864070115        totout = bktot(a).tot;
000865070115        except l1tot;
000866070115
000867070115        // accumulate final totals
000868070115        lrtot(a).des = bktot(a).des;
000869070115        lrtot(a).act = lrtot(a).act + bktot(a).act;
000870070115        lrtot(a).med = lrtot(a).med + bktot(a).med;
000871070115        lrtot(a).tot = lrtot(a).tot + bktot(a).tot;
000872070115
000873070115        a=a-1;
000874070115       enddo;
000875070115      /end-free
000876070115
000877070115     c                   endsr
000878070115
000879070115      *************************************************
000880070115      * totals
000881070115      *************************************************
000882070105     c     #lrtot        begsr
000883070115      /free
000884070115       a=4;
000885070115       except head;
000886070115       except lrtothed;
000887070115       dow a >= 1;
000888070115        desout = lrtot(a).des;
000889070115        actout = lrtot(a).act;
000890070115        medout = lrtot(a).med;
000891070115        totout = lrtot(a).tot;
000892070115        finact = finact + lrtot(a).act;
000893070115        finmed = finmed + lrtot(a).med;
000894070115        fintot = fintot + lrtot(a).tot;
000895070115        except l1tot;
000896070115        a=a-1;
000897070115       enddo;
000898070115        except lrtotfoot;
000899070115      /end-free
000900070115
000901070105     c                   endsr
000902070105
000903070115     C*************************************************************
000904070115     C*                                                           *
000905070115     C* Write Spreadsheet heading                                 *
000906070115     C*                                                           *
000907070115     C*************************************************************
000908070115     C     Writexlhead   BEGSR
000909070115
000910070115     c                   clear                   rp360fld
000911070115     C                   Eval      rp360fld  =   '"' + 'SALESMAN CODE' + '","' +
000912070115     C                                                 'SALESMAN NAME' + '","' +
000913070115     C                                                 'ACCT #'        + '","' +
000914070115     C                                                 'ACCT NAME'     + '","' +
000915070115     C                                                 'MED LIVES'     + '","' +
000916070115     C                                                 'TOTAL LIVES'   + '","' +
000917070115     C                                                 'PARITY'        + '","' +
000918070115     C                                                 'MKTSZ CARRIER' + '","' +
000919070115     C                                                 'MARKET SIZE'   + '","' +
000920070115     C                                                 ' '             + '",'
000921070115     C                   Write     rp360xr
000922070115     C*
0009230701150320 C                   ENDSR
0009240701150164 C*************************************************************
0009250701150164 C*                                                           *
0009260701150164 C* Write Spreadsheet Detail                                  *
0009270701150164 C*                                                           *
0009280701150164 C*************************************************************
000929070115     C     Writexldet    BEGSR
000930070115
000931070115     c                   clear                   rp360fld
000932070115     C                   Eval      rp360fld  =   '"' +
000933070115     C                             smancd                              + '","' +
000934070115     C                             sname                               + '","' +
000935070115     C                             %trim(%editw(tsa:'0   -   -    '))  + '","' +
000936070115     C                             acnam1                              + '","' +
000937070115     C                             %Trim(%Editc(medemp:'4'))           + '","' +
000938070115     C                             %Trim(%Editc(totemp:'4'))           + '","' +
000939070115     C                             parityout                           + '","' +
000940070115     C                             medcarr                             + '","' +
000941070115     C                             sizeout                             + '","' +
000942070115     C                             ' '                          + '",'
000943070115     C*
000944070115     C                   Write     rp360xr
0009450701150320 C                   ENDSR
000946070115     C*
0009470701050059 C     *inzsr        begsr
000948070105     C                   TIME                    HTIME             6 0
000949070115     C                   move      *year         runy
000950070115     C                   move      *month        runm
000951070115     C                   move      *day          rund
000952070116     c                   if        lexclude = 'Y'
000953070116     c                   eval      *in98 = *on
000954070116     c                   end
000955070105     c                   except    head
000956070115     C                   Exsr      Writexlhead
000957070115
000958070115     c     mkcaky        klist
000959070115     c                   kfld                    actrst
000960070115     c                   kfld                    acsub#
000961070115     c                   kfld                    acacct
000962070115     c                   kfld                    medcarr
000963070115
000964070115     c     cckey         klist
000965070115     c                   kfld                    actrst
000966070115     c                   kfld                    acsub#
000967070115     c                   kfld                    acacct
000968070115
000969070115     c     plnkey        klist
000970070115     c                   kfld                    actrst
000971070115     c                   kfld                    acsub#
000972070115     c                   kfld                    cmplan
000973070115
000974070115     c     mckey         klist
000975070115     c                   kfld                    actrst
000976070115     c                   kfld                    acsub#
000977070115     c                   kfld                    acacct
000978070115     c                   kfld                    cmplan
000979070115
000980070115     c     ac2key        klist
000981070115     c                   kfld                    f
000982070115     c                   kfld                    actrst
000983070115     c                   kfld                    acsub#
000984070115     c                   kfld                    acacct
000985070105     C                   endsr
000986011126
001000070117     Orp360p    E            HEAD           2 02
001100070115     O                       CONAME              83
001300070105     O          E            HEAD           1
001400070105     O                       UDATE         Y      8
001500070116     O                                           65 'OE GROUP SIZE REPORT'
001501070116     O               98                          +1 '- EXCLUDING DC & VA'
001700070105     O                                          123 'PAGE :'
001800070105     O                       PAGE          Z    132
001900070105     O*
002000070105     O          E            HEAD           1
002100070115     O                                           11 'PROG: RP360'
002600070105     O                                          123 'TIME :'
002700070105     O                       htime              132 '  :  :  '
003300070105     O*
003400070105     O          E            HEAD           1
003500070105     O                                           24 '------------------------'
003600070105     O                                           48 '------------------------'
003700070105     O                                           72 '------------------------'
003800070105     O                                           96 '------------------------'
003900070105     O                                          120 '------------------------'
004000070105     O                                          132 '------------'
004100070105     O*
004200070105     O          E            HEAD           1
004300070105     O                                            9 'ACCOUNT #'
004400070105     O                                           18 'NAME'
004800070105     O                                           70 'MEDICAL'
004801070115     O                                           80 'TOTAL'
004802070115     O                                           88 'PARITY'
004803070115     O                                          102 'MARKET'
005900070105
005901070115     O          E            HEAD           1
005904070115     O                                           70 'LIVES'
005905070115     O                                           80 'LIVES'
005906070115     O                                          102 '  SIZE'
005907070115
006000070105     O          E            HEAD           1
006100070105     O                                           24 '------------------------'
006200070105     O                                           48 '------------------------'
006300070105     O                                           72 '------------------------'
006400070105     O                                           96 '------------------------'
006500070105     O                                          120 '------------------------'
006600070105     O                                          132 '------------'
006700070105
006701070115     O          E            l1det       1  1
006702070115     O                       smancd               3
006703070115     O                                            5 '-'
006704070115     O                       sname               31
006800070105     O          E            prt            1
006900070105     O                       ACTRST               3
007000070105     O                                            4 '-'
007100070105     O                       ACSUB#               7
007200070105     O                                            8 '-'
007300070105     O                       ACACCT              12
007400070105     O                       ACNAM1              54
007800070105     O                       medemp        4     70
007801070115     O                       totemp        4     80
007802070115     O                       parityout           86
007803070115     O                       medcarr             96
007804070115     O                       sizeout            102
008300070115     O          E            l1tothead   1  1
008400070105     O                                           13 'BROKER TOTAL:'
008500070115     O                                           28 'MED SIZE '
008501070115     O                                           36 'ACCTS'
008502070115     O                                           52 'MED LIVES'
008503070115     O                                           63 'TOT LIVES'
008504070115     O          E            l1tot          1
008505070115     o                       desout              28
008506070115     O                       actout        4     36
008507070115     O                       medout        2     52
008508070115     O                       totout        2     63
008800070115     O          E            lrtothed    1  1
008900070105     O                                           13 'FINAL TOTAL: '
008901070115     O                                           28 'MED SIZE '
009000070105     O                                           36 'ACCTS'
009001070115     O                                           52 'MED LIVES'
009002070115     O                                           63 'TOT LIVES'
010800070115     O          E            lrtotfoot      1
010900070108     O                                           36 '------'
011000070115     O                                           52 '---------'
011001070115     O                                           63 '---------'
011100070115     O          E            lrtotfoot      1
011200070115     O                       finact        4     36
011300070115     O                       finmed        2     52
011400070115     O                       fintot        2     63
