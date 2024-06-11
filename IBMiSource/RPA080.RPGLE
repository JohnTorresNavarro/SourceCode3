000100000000      ******************************************************************
000200131127      *  RPA080    GROUP BENEFIT SERVICES SOFTWARE                     *
000300000000      *                                                                *
000400131127      *  DESCRIPTION - Accounts Receivable report                      *
000500000000      *                                                                *
000600131127      * 11/27/13 dlk - rewrite AR to match new remittance.             *
000700101008      *                                                                *
000800000000      ******************************************************************
000900131127JGE01Fhist      up   e           k DISK
001000131127     Fcodesl1   if   e           k DISK
001100131127JGE01Faccmst    if   e           k DISK
001200131127JGE01Fmember    if   e           k DISK
001300131127JGE01Ftrsmst    if   e           k DISK
001400131127JGE01Farbala    if a e           k DISK
001500131127JGE01Farbalc    if a e           k DISK
001600131213JGE01Farbalal1  if   e           k DISK    rename(arbalar:arbalarl1)
001700131213JGE01Farbalcl1  if   e           k DISK    rename(arbalcr:arbalcrl1)
001800131202JGE01Fgbsecure  if a e           k DISK
001900131203JGE01Frpa080wka if a e           k DISK
002000131203JGE01Frpa080wkc if a e           k DISK
0021001010110017 Frpa080xl  o  a e             DISK
0022001312060005 Frpa080p   o    f  132        printer oflind(*inof)
0023001010110125 Dcsv              c                   const('","')
0024001311270125 Dkeb              s              3a   inz('KEB')
0025001312020125 Dvalidtrans       s              1a
0026001312020125 Dusethistcat      s              1a
0027001312020125 Dname_o           s             40a
0028001312020125 Dacc_o            s             13a
0028011512020125 Das_o             s              1a
0029001312020125 Dtc_o             s              1a
0030001312020125 Dlcatwork         s             10a
0031001312020125 Dcurenr_o         s             11  2
0032001312020125 Dadj_o            s             11  2
0033001312020125 Dtotal_o          s             11  2
0034001312020125 Dbal_o            s             12  2
0035001312020125 Deffmdy_o         s              8  0
0036001312020125 Drecmdy_o         s              8  0
0037001312020125 Dpaytype_o        s              1a
0038001312020125 Duser_o           s             20a
0039001312020125 Dck#not_o         s             30a
0039011602160125 Dbatch_o          s              3a
0039021602170125 Dcheck#_o         s             15a
0039031602170125 Dcheckamt_o       s             12a
0040001312020125 Ddatecheck        s              8  0
0041001312020125 Dtrdes_o          s             30a
0042001312020125 Dtrdatemdy        s              8  0
0043001312130125 Dcandtmdy         s              8  0
0044001312020125 Dssnkey           s              9  0
0045001312020125 Dleffymd31        s              8  0
0046001312020125 Dleffmdy          s              8  0
0047001312040125 Dkeydate          s              8  0
0048001312040125 Dwktrust          s              3  0
0049001312040125 Dendbaltxt        c                   const('ENDING BALANCE   ')
0050001312040125 Dbegbaltxt        c                   const('BEGINNING BALANCE')
0051001312040125 Dnotranstxt       c                   const('NO TRANSACTIONS THIS PERIOD')
0052001312040125 Dworkdtymd        s               d   datfmt(*iso)
0053001312060125 Derracc           s             13
0054001312060125 Derrrptamt        s                   like(ARBAAMT)
0055001312060125 Derrfilamt        s                   like(ARBAAMT)
0055011511200125 Dfirste           s              1
005600131127
005700101013     D                 DS
005800101013     D  tsa                    1     10  0 inz
005900131202     D  t                      1      3  0
006000131202     D  s                      4      6  0
006100131202     D  a                      7     10  0
006200131203     D                 DS
006300131203     D  accwk                  1     10  0 inz
006400131203     D  accwkt                 1      3  0
006500131203     D  accwks                 4      6  0
006600131203     D  accwka                 7     10  0
0067001311270055 D                uds
0068001312020056 D  leffymd                1      8  0
0069001311270056 D  lupdate                9      9
0070001311270056 D  lreprint              10     10
0071001311270056 D  ltrust                11     13
0072001312040056 D  ltrustnum             11     13  0
0073001311270056 D  lsub                  14     16
0074001312040056 D  lsubnum               14     16  0
0075001312040056 D  lacc                  17     20
0076001312040056 D  laccnum               17     20  0
007700131127     D  lcat                  21     30
007800131127     D                                     DIM(10)
0079001311270601 D  CONAME               201    240
0080001311270601 D  luser               1000   1009
008100131202
008200131127     Ihistr
008300131127     I                                          hkey          L1
008400131127      * new ssn or acc#
008500131127     c                   if        *inl1
008600131204     c                   move      hstrst        wktrust
008700131127     c                   exsr      #chktrscat
008800131127     c                   exsr      #l1det
008900101013     C                   end
009000101013
009100131127      * trust category selection
009200131127     c                   if        usethistcat <> 'Y'
009300131127     c                   goto      #end
009400131127     c                   end
009500131127
009600131202      * transaction selection:
009700141030      * accounts only get payments (BMP), invoices (BMB) and void invoices
009800151201      * (AVI).
009801151201      * Members get all financial transactions because cobra adjustments
009802151201      * are not on the corba invoice so they are pulled durectly from hist.
009900131202     c                   if        %subst(hkey:1:1) <> ' ' and
010000131202     c                             (trcode <> 'BMP' and trcode <> 'BMB' and
010100131202     c                              trcode <> 'AVI')
010200131202     c                   goto      #end
010300131202     c                   end
010400131202
010500131202      * date selection:
010600131202      * payments use receive date but all others use effective date
010700131202     c                   move      covtdt        datecheck
010800131211     c                   if        trcode = 'BMP' or trcode = 'BPP'
010900131202     c                   move      recvdt        datecheck
011000131202     c                   end
011100131202
011200131202     c                   if        datecheck > leffymd31
011300131202     c                   goto      #end
011400131202     c                   end
011500131202
011600151207      * At this point a valid transaction has been found for this acct/mem.
011602151207      * On the first valid transaction get the ending balance from the
011603151207      * prior month and print it on spreadsheet as the beginning balance
011604151207      * this month.
011605151207     c                   if        validtrans = *blank
011606151207     c                   eval      validtrans = 'Y'
011607151207     c                   exsr      #getendbal
011608151207     c                   end
011800131202
011900131202      * clear variable fields in spreadhseet output line
012000131202     c                   exsr      #clearvar
012100131202
012200131202      * code description
012300131202     c                   clear                   trdes_o
012400131127     C     trcode        chain     codesl1
012500131127     c                   if        %found(codesl1)
012600131202     c                   eval      trdes_o = ldescr
012700131127     c                   end
012800131127
012900141030      * total amount is the BILLED transaction amount from hist
013000131127     c                   eval      total_o  = tramt
013100131127
013200141030      * Account invoice and void invoice transactions (not COBRA):
013201141030      * The billed amount (tramt) holds the current enrollment total and
013202141030      * the net amount holds the adjustment total
013400131127     c                   if        trcode = 'BMB' or trcode = 'AVI'
013500131127     c                   eval      curenr_o = tramt
013600131127     c                   eval      adj_o    = hstramtn
013700131127     c                   add       hstramtn      total_o
013800131127     c                   end
013900131127
014000131127      * running balance
014100131127     c                   add       total_o       bal_o
014200131127
014300131127      * dates
014400131127     C                   MOVE      covtdt        @DATIN
014500131127     C                   EXSR      #DATYM
014600131127     C                   MOVE      @DATOU        effmdy_o
014700131127     c
014800131127     C                   MOVE      recvdt        @DATIN
014900131127     C                   EXSR      #DATYM
015000131127     C                   MOVE      @DATOU        recmdy_o
015100131202
015200131202     C                   MOVE      trdate        @DATIN
015300131202     C                   EXSR      #DATYM
015400131202     C                   MOVE      @DATOU        trdatemdy
015500131127
015600160216      * fill payment type and batch #
015700131211     c                   if        trcode = 'BMP' or trcode = 'BPP'
015800131127     c                   eval      paytype_o = CM$FLG
015801160216     c                   eval      batch_o    = %subst(note2:28:3)
015802160217     c                   eval      check#_o   = %subst(ck#not:1:15)
015803160217     c                   eval      checkamt_o = %subst(ck#not:19:12)
015900131127     c                   end
016000131127
016100131127      * user name
016200131127     c     hoper         chain     gbsecure
016300131127     c                   if        %found(gbsecure)
016400131127     c                   movel     scname        user_o
016500131127     c                   end
016600131202      * note field
016700131202     c                   eval      ck#not_o = ck#not
016800131202
016900131127      * write to spreadsheet
017000131127     c                   exsr      Writexldet
017100131127
017200131204      * update hist record with this ardate if the update was selected.
017300131204      * only update the ardate field, safeguard in case any other
017400131204      * fields are changed in this program by mistake
017500131204      /free
017600131204       if lupdate = 'Y';
017700131204       hsdate1 = leffymd;
017800131204       update histr %fields(hsdate1);
017900131204       endif;
018000131204      /end-free
018100131204
018200131127     C     #end          tag
018300131127
018400131127      * end of acct / member
018500131127     cl1                 exsr      #l1total
018600131203      * end of new transactions this period
018700131203     clr                 exsr      #lr
018800131127
0189001311270103  ***************************************************
0190001311270104  * l1 detail - change in hkey                      *
0191001311270103  ***************************************************
0192001311270106 C     #l1det        BEGSR
019300131127
019400131202     c                   clear                   name_o
019500131202     c                   clear                   acc_o
019501151202     c                   clear                   as_o
019600131202     c                   clear                   bal_o
019700131203     c                   clear                   accwk
019800131203     c                   clear                   ssnkey
019900131213     c                   clear                   candtmdy
020000131127
020100131127      * skip if this trust is not part of the selection
020200131127     c                   if        usethistcat <> 'Y'
020300131127     c                   leavesr
020400131127     c                   end
020500131127
020600131127      * member transaction
020700131205     C                   if        %subst(hkey:1:1) = *blank
020800131202     c                   move      hkey          ssnkey
020900131205     c                   eval      acc_o = %editw(ssnkey:'0   -  -    ')
020901151202     c                   eval      as_o = 'S'
021000131127     C     ssnkey        CHAIN     MEMBER
021100131127     c                   if        %found(member)
021200131202     c                   eval      name_o  = %trim(mlname) + ', ' +
021300131202     c                             %trim(mfname) + ' ' + %trim(mmi)
021400131213     C                   MOVE      termdt        @DATIN
021500131213     C                   EXSR      #DATYM
021600131213     C                   MOVE      @DATOU        candtmdy
021700131127     C                   end
021800131127
021900131127      * acct transaction
022000131127     c                   else
022100131203     c                   move      hkey          accwk
022200131204     c                   move      hstrst        t
022300131204     c                   move      hssub#        s
022400131204     c                   move      hsacct        a
022500131204     c                   eval      acc_o = %editw(tsa:'0   -   -    ')
022501151202     c                   eval      as_o = 'A'
022600131127     C     acckey        chain     accmst
022700131127     c                   if        %found(accmst)
022800131127     c                   movel     acnam1        name_o
022900131213     C                   MOVE      atrmdt        @DATIN
023000131213     C                   EXSR      #DATYM
023100131213     C                   MOVE      @DATOU        candtmdy
023200131127     C                   end
023300131127
023400131127     c                   end
023500131127
0239001311270120 C                   ENDSR
024000131127
0241001311270103 C***************************************************
0242001311270104 C* check trust category code                       *
0243001311270105 C***************************************************
0244001311270120 C     #chktrscat    begsr
024500131127
024600131202      * get trust category code
024700131202     C                   clear                   tc_o
024800131204     C     wktrust       chain     trsmst
024900131202     c                   if        %found(trsmst)
025000131202     C                   move      tscode        tc_o
025100131202     C                   end
025200131202
025300131127      * was a trust category code selected?
025400131202     c                   clear                   validtrans
025500131202     c                   move      'Y'           usethistcat
025600131202
025700131202     c                   movea     lcat          lcatwork
025800131202     c                   if        lcatwork <> *blanks
025900131202     C     tc_o          LOOKUP    lcat(1)                                70
026000131202     c                   if        not %found
026100131127     c                   clear                   usethistcat
026200131127     c                   end
026300131127     c                   end
026400131202
026500131202      * exclude test trust category "T" from this report
026600131202     c                   if        tc_o = 'T'
026700131202     c                   clear                   usethistcat
026800131202     c                   end
026900131127
0270001311270120 C                   ENDSR
027100131127
0272001312130103 C*********************************************************************
0273001312130104 C* get ending balance from prior month to show as beginning balance
0274001312130104 C* this month
0275001312130103 C*********************************************************************
0276001311270120 C     #getendbal    begsr
027700131127
027800131202      * clear variable fields in spreadhseet output line
027900131202     c                   exsr      #clearvar
028000131202     c                   clear                   trdes_o
028100131204     c                   eval      trdes_o = begbaltxt
028200131202
028300131213      * cobra record - balance file L1 keyed by rec code/ssn/effdt
028400131202     C                   if        %subst(hkey:1:1) = ' '
028500131213     c     arbalckey     setll     arbalcl1
028600131213     c     arbalckey2    readpe    arbalcl1
028700131213     c                   if        (not %eof(arbalcl1))
028800131127     c                   eval      bal_o = arbcamt
028900131213     C***                MOVE      arbceff       @DATIN
029000131213     C***                EXSR      #DATYM
029100131213     C***                MOVE      @DATOU        effmdy_o
029200131213     c                   end
029300131127
029400131213      * acct record - balance file L1 keyed by rec code/tsa/effdt
029500131127     c                   else
029600131127
029700131213     c     arbalakey     setll     arbalal1
029800131213     c     arbalakey2    readpe    arbalal1
029900131213     c                   if        (not %eof(arbalal1))
030000131127     c                   eval      bal_o = arbaamt
030100131213     C***                MOVE      arbaeff       @DATIN
030200131213     C***                EXSR      #DATYM
030300131213     C***                MOVE      @DATOU        effmdy_o
030400131127     c                   end
030500131127
030600131127     c                   end
030700131127
030800131127      * write beginning balance to spreadsheet
030900131127     c                   exsr      Writexldet
031000131127
0311001311270120 C                   ENDSR
031200131127
0313001311270103  ***************************************************
0314001311270104  * l1 total - end of member or acct - write ending balance
0315001311270103  ***************************************************
0316001311270106 C     #l1total      BEGSR
031700131202      * skip if no valid transactions were printed for this break
031800131202     c                   if        validtrans <> 'Y'
031900131127     c                   leavesr
032000131127     c                   end
032100131127
032200131202      * clear variable fields in spreadhseet output line
032300131202     c                   exsr      #clearvar
032400131127     c                   clear                   trdes_o
032500131204     c                   eval      trdes_o = endbaltxt
032600131127
032700131202      * ar date
032800131202     C                   MOVE      leffmdy       effmdy_o
032900131127
033000131203      * write acct or ssn to work files for later use in determining
033100131203      * what accts / members with prior month open balances did not
033200131203      * get included on this report.
033300131205     c                   if        %subst(hkey:1:1) = *blank
033400131203     c                   move      ssnkey        r8cssn
033500131206     c                   move      bal_o         r8cendbal
033600131203     c                   write     rpa080wkCr
033700131203     c                   else
033800131203     c                   move      accwkt        R8ATRUST
033900131203     c                   move      accwks        R8ASUB
034000131203     c                   move      accwka        R8AACC
034100131206     c                   move      bal_o         R8AENDBAL
034200131203     c                   write     rpa080wkAr
034300131203     c                   end
034400131203
034500131203      * write ending balance to spreadsheet
034600131203     c                   exsr      Writexldet
034700131203
034800131127      * write ending balance to ar file if this was an update run
034900131127     c                   if        lupdate = 'Y'
035000131205     c                   exsr      #writearbal
035100131127     c                   end
035200131127
0353001311270120 C                   ENDSR
035400131204
0355001312050103  *********************************************************************
0356001312050104  * End of history records - now get all non-zero ending balances from
0357001312050104  * the ar balance files that did not have activity this month. If
0358001312050104  * reprint selected then use the report date for search, else use the
0359001312050104  * report date - 1 month to carry forward previous balances to the
0360001312050104  * report month when new activity is selected.
0361001312050104  * Chain to workfiles to see if the account / ssn was included
0362001312050104  * on this months report, if not found then write to
0363001312050104  * report as begin and ending balance for the current month since there
0364001312050104  * was no activity. If this was an update run then also add
0365001312050104  * this amount back to the arbal* file as the current date so all
0366001312050104  * outstanding balances carry forward each month even without activity.
0367001312050103  *********************************************************************
0368001312030106 C     #lr           BEGSR
036900131203
037000131205      * use report date for search (reprint)
037100131204     c                   move      leffymd       workdtymd
037200131205      * if new activity selected use last month instead
037300131205     c                   if        lreprint = 'N'
037400131204     c                   subdur    1:*m          workdtymd
037500131205     c                   end
037600131204     c                   move      workdtymd     keydate
037700131204
037800131204      ********************
037900131204      * check accounts
038000131204      ********************
038100131213     c     arbalkeyLR    setll     arbalA
038200131204     c                   dou       %eof(arbalA)
038300131213     c     arbalkeyLR    reade     arbalA
038400131204     c                   if        not %eof(arbalA) and arbaamt <> 0
038500131204      * t/s/a selection from prompt screen
038600131204     c                   if        (ltrust <> 'ALL' and ltrustnum <> ARBATRUST)
038700131204     c                             or
038800131204     c                             (lsub <> 'ALL' and lsubnum <> ARBASUB)
038900131204     c                             or
039000131204     c                             (lacc <> 'ALL ' and laccnum <> ARBAACC)
039100131204     c                   iter
039200131204     c                   end
039300131204
039400131204      * If this acct is not on the report already then add it
039500131204     c     arbaltsa      chain     rpa080wka
039600131204     c                   if        not %found(rpa080wka)
039700131204     c                   exsr      #writemisacc
039800131206
039900131206      * If this acct is on the report and it is a reprint, then check to
040000131206      * make sure the balance calculated matches the ending balance stored
040100131206      * in the arbal files. If it does not match then there is a problem.
040200131206     c                   else
040300131206     c                   if        lreprint = 'R' and R8AENDBAL <> arbaamt
040400131206     c                   eval      erracc = %char(arbatrust) + '-' +
040500131206     c                                      %char(arbasub)   + '-' +
040600131206     c                                      %char(arbaacc)
040700131206     c                   eval      errrptamt = r8aendbal
040800131206     c                   eval      errfilamt = arbaamt
040801151120     c                   if        firste = *blank
040900151120     c                   except    head
040901151120     c                   eval      firste = 'N'
040902151120     c                   end
040903151120     c   of              except    head
041000131206     c                   except    error
041100131206     c                   end
041200131206
041300131204     c                   end
041400131204     c                   end
041500131204     c                   enddo
041600131204
041700131204      ********************
041800131204      * check members
041900131204      ********************
042000131213     c     arbalkeyLR    setll     arbalC
042100131204     c                   dou       %eof(arbalC)
042200131213     c     arbalkeyLR    reade     arbalC
042300131204     c                   if        not %eof(arbalC) and arbcamt <> 0
042400131204
042500131204     c     arbcssn       chain     member
042600131204     c                   if        %found(member)
042700131204      * t/s/a selection from prompt screen
042800131204     c                   if        (ltrust <> 'ALL' and ltrustnum <> mbtrst)
042900131204     c                             or
043000131204     c                             (lsub <> 'ALL' and lsubnum <> mbsub#)
043100131204     c                             or
043200131204     c                             (lacc <> 'ALL ' and laccnum <> mbacct)
043300131204     c                   iter
043400131204     c                   end
043500131204     c                   end
043600131204
043700131204      * if this member was not on the report already then write begin/end bal
043800131204      * record to report.
043900131204     c     arbcssn       chain     rpa080wkC
044000131204     c                   if        not %found(rpa080wkC)
044100131204     c                   exsr      #writemismem
044200131206
044300131206      * If this member is on the report and it is a reprint, then check to
044400131206      * make sure the balance calculated matches the ending balance stored
044500131206      * in the arbal files. If it does not match then there is a problem.
044600131206     c                   else
044700131206     c                   if        lreprint = 'R' and R8CENDBAL <> arbcamt
044800131206     c                   eval      erracc = %editw(arbcssn:'0   -  -    ')
044900131206     c                   eval      errrptamt = r8cendbal
045000131206     c                   eval      errfilamt = arbcamt
045001151120     c                   if        firste = *blank
045002151120     c                   except    head
045003151120     c                   eval      firste = 'N'
045004151120     c                   end
045100131206     c   of              except    head
045200131206     c                   except    error
045300131206     c                   end
045400131206
045500131204     c                   end
045600131204     c                   end
045700131204     c                   enddo
045800131204
045900131204
0460001312030120 C                   ENDSR
046100131127
0462001311270103 C***************************************************
0463001312040104 C* write missing acct to report                    *
0464001311270105 C***************************************************
0465001312040120 C     #writemisacc  begsr
046600131204
046700131204      * clear variable fields in spreadhseet output line
046800131204     c                   exsr      #clearvar
046900131204     c                   clear                   name_o
047000131204     c                   clear                   acc_o
047001151202     c                   clear                   as_o
047100131204     c                   clear                   bal_o
047200131204     c                   clear                   accwk
047300131204     c                   clear                   ssnkey
047400131204     c                   clear                   trdes_o
047500131213     c                   clear                   candtmdy
047600131204     c                   eval      trdes_o = begbaltxt
047700131204     c                   eval      bal_o = arbaamt
047800131213     C***                MOVE      leffmdy       effmdy_o
047900131204
048000131204     c                   move      arbatrust     t
048100131204     c                   move      arbasub       s
048200131204     c                   move      arbaacc       a
048300131204     c                   eval      acc_o = %editw(tsa:'0   -   -    ')
048301151202     c                   eval      as_o = 'A'
048400131204     C     arbaltsa      chain     accmst
048500131204     c                   if        %found(accmst)
048600131204     c                   movel     acnam1        name_o
048700131213     C                   MOVE      atrmdt        @DATIN
048800131213     C                   EXSR      #DATYM
048900131213     C                   MOVE      @DATOU        candtmdy
049000131204     C                   end
049100131204
049200131204      * check trust category
049300131204     c                   move      t             wktrust
049400131204     c                   exsr      #chktrscat
049500131204     c                   if        usethistcat <> 'Y'
049600131204     c                   leavesr
049700131204     c                   end
049800131204
049900131204      * write beginning balance to spreadsheet
050000131204     c                   exsr      Writexldet
050100131204
050200131204      * write ending balance to spreadsheet
050300131204     c                   clear                   trdes_o
050400131204     c                   eval      trdes_o = endbaltxt
050500131204     C                   MOVE      leffmdy       effmdy_o
050600131204     c                   eval      ck#not_o = notranstxt
050700131204
050800131204     c                   exsr      Writexldet
050900131204
051000131204      * also write to arbal file if this was an update run
051100131204     c                   if        lupdate = 'Y'
051200131204     c                   eval      ARBARC = keb
051300131204     c                   eval      ARBAEFF = leffymd
051400131204     c                   eval      ARBAAMT = bal_o
051500131204     c* not necessary    eval      ARBATRUST = arbatrust
051600131204     c* not necessary    eval      ARBASUB = arbasub
051700131204     c* not necessary    eval      ARBAACC = arbaacc
051800131204     c                   write     arbalAr
051900131204     c                   end
052000131204
0521001312040120 C                   ENDSR
052200131204
0523001312040103 C***************************************************
0524001312040104 C* write missing member to report                  *
0525001312040105 C***************************************************
0526001312040120 C     #writemismem  begsr
052700131204
052800131204      * clear variable fields in spreadhseet output line
052900131204     c                   exsr      #clearvar
053000131204     c                   clear                   name_o
053100131204     c                   clear                   acc_o
053101151202     c                   clear                   as_o
053200131204     c                   clear                   bal_o
053300131204     c                   clear                   accwk
053400131204     c                   clear                   ssnkey
053500131204     c                   clear                   trdes_o
053600131213     c                   clear                   candtmdy
053700131204     c                   eval      trdes_o = begbaltxt
053800131204     c                   eval      bal_o = arbCamt
053900131213     C***                MOVE      leffmdy       effmdy_o
054000131204
054100131204     c                   eval      acc_o = %editw(arbcssn:'0   -  -    ')
054101151202     c                   eval      as_o = 'S'
054200131204     c                   eval      name_o  = %trim(mlname) + ', ' +
054300131204     c                             %trim(mfname) + ' ' + %trim(mmi)
054400131213     C                   MOVE      termdt        @DATIN
054500131213     C                   EXSR      #DATYM
054600131213     C                   MOVE      @DATOU        candtmdy
054700131204
054800131204      * check trust category
054900131204     c                   move      mbtrst        wktrust
055000131204     c                   exsr      #chktrscat
055100131204     c                   if        usethistcat <> 'Y'
055200131204     c                   leavesr
055300131204     c                   end
055400131204
055500131204      * write beginning balance to spreadsheet
055600131204     c                   exsr      Writexldet
055700131204
055800131204      * write ending balance to spreadsheet
055900131204     c                   clear                   trdes_o
056000131204     c                   eval      trdes_o = endbaltxt
056100131204     C                   MOVE      leffmdy       effmdy_o
056200131204     c                   eval      ck#not_o = notranstxt
056300131204
056400131204     c                   exsr      Writexldet
056500131204
056600131204      * also write to arbal file if this was an update run
056700131204     c                   if        lupdate = 'Y'
056800131204     c                   eval      ARBCRC = keb
056900131204     c                   eval      ARBCEFF = leffymd
057000131204     c                   eval      ARBCAMT = bal_o
057100131204     c** not necessary   eval      ARBCSSN = arbcssn
057200131204     c                   write     arbalCr
057300131204     c                   end
057400131204
0575001312040120 C                   ENDSR
057600131204
0577001312040103 C***************************************************
0578001312040104 C* write ending balance rec to arbal files         *
0579001312040105 C***************************************************
0580001312050120 C     #writearbal   begsr
058100131127
058200131127      * cobra record
058300131202     C                   if        %subst(hkey:1:1) = ' '
058400131202     c                   eval      ARBCRC = keb
058500131127     c                   eval      ARBCEFF = leffymd
058600131127     c                   eval      ARBCAMT = bal_o
058700131202     c                   eval      ARBCSSN = ssnkey
058800131127     c                   write     arbalCr
058900131127      * acct record
059000131127     c                   else
059100131202     c                   eval      ARBARC = keb
059200131127     c                   eval      ARBAEFF = leffymd
059300131127     c                   eval      ARBAAMT = bal_o
059400131127     c                   eval      ARBATRUST = hstrst
059500131127     c                   eval      ARBASUB = hssub#
059600131127     c                   eval      ARBAACC = hsacct
059700131127     c                   write     arbalAr
059800131127     c                   end
059900131127
0600001311270120 C                   ENDSR
060100131127
0602009903180103 C***************************************************
0603009903180104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0604009903180105 C***************************************************
0605009903180107 C*
0606009903180107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0607009903180107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0608009903180107 C*
0609009903180106 C     #DATYM        BEGSR
061000990318     C                   MOVE      @DATIN        @MD               4 0
061100990318     C                   MOVEL     @DATIN        @Y                4 0
061200990318     C                   MOVEL     @MD           @DATOU            8 0
061300990318     C                   MOVE      @Y            @DATOU
061400990318     C                   MOVE      *ZEROS        @DATIN            8 0
0615009903180120 C                   ENDSR
061600990318     C*
0617001010110164 C*************************************************************
0618001010110164 C*                                                           *
0619001010110164 C* Write Spreadsheet Detail                                  *
0620001010110164 C*                                                           *
0621001010110164 C*************************************************************
062200101011     C     Writexldet    BEGSR
062300101013
062400101011
062500101011     c                   clear                   rpa080fld
062600101013     C                   Eval      rpa080fld  = '"' +
062700131202     C                             %trim(%editc(leffmdy:'Y'))           + csv +
062800131202     C                             %trim(acc_o)                         + csv +
062801151202     C                             %trim(as_o)                          + csv +
062900131202     C                             %trim(tc_o)                          + csv +
063000131202     C                             %trim(name_o)                        + csv +
063100131213     C                             %trim(%editw(candtmdy:'  /  /    ')) + csv +
063200131213     C                             %trim(%editw(trdatemdy:'  /  /    ')) + csv +
063300131202     C                             %trim(trdes_o)                       + csv +
063400131202     C                             %trim(%editw(effmdy_o:'  /  /    ')) + csv +
063500131202     c                             %trim(%editc(curenr_o:'O':*cursym))  + csv +
063600131202     c                             %trim(%editc(adj_o:'O':*cursym))     + csv +
063700131202     c                             %trim(%editc(total_o:'O':*cursym))   + csv +
063800131202     c                             %trim(%editc(bal_o:'N':*cursym))     + csv +
063900131202     C                             %trim(%editw(recmdy_o:'  /  /    ')) + csv +
064000131202     C                             %trim(paytype_o)                     + csv +
064100131202     C                             %trim(ck#not_o)                      + csv +
064101160216     C                             %trim(batch_o)                       + csv +
064102160216     C                             %trim(check#_o)                      + csv +
064103160216     C                             %trim(checkamt_o)                    + csv +
064200131202     C                             %trim(user_o)                        + csv +
064300131127     C                             '",'
064400101011     C                   Write     rpa080xr
0645001010110320 C                   ENDSR
064600101011     C*
064700101011     C*************************************************************
064800101011     C*                                                           *
064900101011     C* Write Spreadsheet heading                                 *
065000101011     C*                                                           *
065100101011     C*************************************************************
065200101011     C     Writexlhead   BEGSR
065300101011
065400101011     c                   clear                   rpa080fld
065500131127     C                   Eval      rpa080fld = '"' +
065600131127     C                             'AR DATE'                      + csv +
065700131127     C                             'ACCT / SSN'                   + csv +
065701151202     C                             'A/S'                          + csv +
065800131127     C                             'TRUST CAT'                    + csv +
065900131127     C                             'NAME'                         + csv +
066000131213     C                             'CANCEL DATE'                  + csv +
066100131213     C                             'TRANSACTION DATE'             + csv +
066200131127     C                             'DESCRIPTION'                  + csv +
066300131202     C                             'EFFECTIVE DATE'               + csv +
066400131127     C                             'CURRENT ENROLL'               + csv +
066500131127     C                             'ADJUSTMENTS'                  + csv +
066600131127     C                             'TOTAL AMOUNT'                 + csv +
066700131127     C                             'RUNNING BALANCE'              + csv +
066800131127     C                             'RECEIVE DATE'                 + csv +
066900131127     C                             'PAY TYPE'                     + csv +
067000131127     C                             'NOTE'                         + csv +
067001160216     C                             'BATCH'                        + csv +
067002160216     C                             'CHECK #'                      + csv +
067003160216     C                             'CHECK AMT'                    + csv +
067100131127     C                             'USER'                         + csv +
067200131127     C                              '",'
067300101011     C                   Write     rpa080xr
067400101011     C*
0675001010110320 C                   ENDSR
067600101011
067700131202     C*************************************************************
067800131202     C* clear variable fields in spreadsheet line                 *
067900131202     C*************************************************************
0680001312020106 C     #clearvar     BEGSR
068100131202
068200131202     c                   clear                   curenr_o
068300131202     c                   clear                   adj_o
068400131202     c                   clear                   total_o
068500131202     c                   clear                   effmdy_o
068600131202     c                   clear                   recmdy_o
068700131202     c                   clear                   paytype_o
068800131202     c                   clear                   user_o
068900131202     c                   clear                   ck#not_o
068901160216     c                   clear                   batch_o
068902160216     c                   clear                   check#_o
068903160216     c                   clear                   checkamt_o
069000131202     c                   clear                   trdatemdy
0691001312020320 C                   ENDSR
069200131202
069300131202     C*************************************************************
069400131202     C* first time only                                           *
069500131202     C*************************************************************
0696001010110106 C     *inzsr        BEGSR
069700131127
069800131127     c     acckey        klist
069900131127     c                   kfld                    hstrst
070000131127     c                   kfld                    hssub#
070100131127     c                   kfld                    hsacct
070200101011
070300131127     c     arbalakey     klist
070400131127     c                   kfld                    keb
070500131127     c                   kfld                    hstrst
070600131127     c                   kfld                    hssub#
070700131127     c                   kfld                    hsacct
070800131213     c                   kfld                    leffymd
070900131213     c     arbalakey2    klist
071000131213     c                   kfld                    keb
071100131213     c                   kfld                    hstrst
071200131213     c                   kfld                    hssub#
071300131213     c                   kfld                    hsacct
071400131203
071500131213     c     arbalkeyLR    klist
071600131203     c                   kfld                    keb
071700131203     c                   kfld                    keydate
071800131127
071900131127     c     arbalckey     klist
072000131127     c                   kfld                    keb
072100131127     c                   kfld                    ssnkey
072200131213     c                   kfld                    leffymd
072300131204
072400131213     c     arbalckey2    klist
072500131213     c                   kfld                    keb
072600131213     c                   kfld                    ssnkey
072700131213
072800131204     c     arbaltsa      klist
072900131204     c                   kfld                    ARBATRUST
073000131204     c                   kfld                    ARBASUB
073100131204     c                   kfld                    ARBAACC
073200131127
073300131127     C                   exsr      writexlhead
073400131202
073500131202     c                   move      leffymd       leffymd31
073600131202     c                   move      31            leffymd31
073700131202
073800131202     C                   MOVE      leffymd       @DATIN
073900131202     C                   EXSR      #DATYM
074000131202     C                   MOVE      @DATOU        leffmdy
074100131206
074200131206     C                   TIME                    HTIME             6 0
0743001010110120 C                   ENDSR
074400131206     oRPA080P   e            head           1  2
0745001312060240 O                       CONAME              95
074600131206     o          e            head           1
0747001312060248 O                                           22 'PROGRAM NAME:   RPA080'
0748001312060244 O                                           75 'A/R BALANCE ERRORS      '
074900131206     O                                          123 'PAGE :'
075000131206     O                       page          z    132
075100131206     o          e            head           1
0752001312060253 O                                           13 'RUN DATE    :'
0753001312060254 O                       UDATE         Y     22
0754001312060255 O                                          123 'TIME :'
0755001312060256 O                       htime              132 '  :  :  '
075600131206     o          e            head           1
075700131206     O                                           26 '--------------------------'
075800131206     O                                           52 '--------------------------'
075900131206     O                                           78 '--------------------------'
076000131206     O                                          104 '--------------------------'
076100131206     O                                          130 '--------------------------'
076200131206     O                                          132 '--'
076300131206     o          e            head           1
076400131206     O                                           13 'ACCOUNT'
076500131206     O                                           37 'REPORT BALANCE'
076600131206     O                                           55 'ARBAL FILE BALANCE'
076700131206     o          e            head           1
076800131206     O                                           26 '--------------------------'
076900131206     O                                           52 '--------------------------'
077000131206     O                                           78 '--------------------------'
077100131206     O                                          104 '--------------------------'
077200131206     O                                          130 '--------------------------'
077300131206     O                                          132 '--'
077400131206     o          e            error       1
077500131206     O                       erracc              13
077600131206     O                       errrptamt     j     37
077700131206     O                       errfilamt     j     55
