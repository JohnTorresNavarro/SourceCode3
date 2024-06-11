0001009102150002 F******************************************************************
0002000612120003 F* CR213B     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000201100004 F*          David Ketterman                                       *
0005000612120004 F*          12/12/06 - copy of cr213                              *
0006009510040004 F*                                                                *
0007000612120004 F*          Create Coventry Persistency Bonus file.               *
0008000701300015 F* 01/29/07 dlk - change to include all contract counts (BOTH     *
0009000701300015 F*                YEARS) regardless if there were paid records    *
0010000701300015 F*                in CR130HS* file. CVEOYCC is now read from      *
0011000701300015 F*                QTEMP as a copy so I can update each record     *
0012000701300015 F*                as it is used. Then at the end I will read      *
0013000701300015 F*                all the records not used and create cr213CV     *
0014000701300015 F*                records for those records.                      *
0015000712270015 F* 12/20/07 dlk - update for 2007                                 *
0016000812030015 F* 12/03/08 dlk - update for 2008                                 *
0017000911240015 F* 11/24/09 dlk - update for 2009                                 *
0018001001130015 F* 01/13/10 dlk - add dental contract count                       *
0019001011190015 F* 11/19/10 dlk - update for 2010                                 *
0020001112130015 F* 12/13/11 dlk - update for 2011                                 *
0021001212180015 F* 12/18/12 dlk - update for 2012                                 *
0022001306130015 F* 06/13/13 dlk - update for 2013 and remove all count fields not *
0023001306130015 F*                ADMIN since the others (DBE, WHL, NASCO) are    *
0024001306130015 F*                not used for coventry.                          *
0025001306140015 F*              - change field names to get away from the year    *
0026001306140015 F*                being part of the field name. Call them current *
0027001306140015 F*                and prior instead. This way I only have to      *
0028001306140015 F*                change the main selection dates every year      *
0029001306140015 F*                instead of a whole bunch of field names. Also   *
0030001306140015 F*                add effective date field so the current / prior *
0031001306140015 F*                make sense.                                     *
0032001412020015 F* 12/02/14 dlk - update for 2014 (dates to select for contract   *
0033001412020015 F*                count only)                                     *
0034001511180015 F* 11/18/15 dlk - update for 2015 (dates to select for contract   *
0035001511180015 F*                count only)                                     *
0036001611300015 F* 11/30/16 dlk - update for 2016 (dates to select for contract   *
0037001611300015 F*                count only)                                     *
0038001712070015 F* 12/07/17 dlk - update for 2017 (dates to select for contract   *
0039001712070015 F*                count only)                                     *
0040001801240015 F* 01/24/18 dlk - update for special last run, dates to select    *
0041001801240015 F*                will be 12/31/16 - 1/31/18 (13 month)           *
0042001901230015 F* 01/23/19 dlk - update for 2019 (dates to select for contract   *
0043001901230015 F*                count only)                                     *
0044001912130015 F* 12/13/19 dlk - update for 2020 (dates to select for contract   *
0045001912130015 F*                count only)                                     *
0046002012150015 F* 12/15/20 dlk - update for 2021 (dates to select for contract   *
0047002012150015 F*                count only)                                     *
0048002112080015 F* 12/08/21 dlk - update for 2022 (dates to select for contract   *
0049002112080015 F*                count only)                                     *
0050002212290015 F* 12/29/22 dlk - update for 2023 (dates to select for contract   *
0051002212290015 F*                count only)                                     *
0052001412020015 F*                                                                *
0053009102150016 F******************************************************************
0054000201110018 FCR210wk   Ip   E             DISK
0055000701300018 Fcveoycc   uf   E           K DISK    rename (cfeoyccr:cveoyccr)
005600070130     fagency    if   e           k disk
005700070130     fsupragcy  if   e           k disk
005800070130     fsman      if   e           k disk
0059000701300027 Fcr213cv   uf a e           k disk
0060000701300019 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
0061000601040125 D  keyeffdt       s              8  0
006200130613
006300130613      ********************************************************************
006400070130      * dates to select for contract count
0065002212290125 D  prioryear      s              8  0 inz(20220131)
0066002212290125 D  currentyear    s              8  0 inz(20230131)
006700130613      ********************************************************************
006800070130
0069000701300125 D  year           s              1
0070000701300124 D                 DS
0071000701300125 D  cynote                 1    100
0072000701300125 D  cynote98              98    100
0073000108010124 D                UDS
0074000108010125 D  LFYMD                 85     92  0
0075000108010125 D  LTYMD                 93    100  0
007600010724     Icr210wkr
007700060104     I                                          casacode      L1
007800060104     I                                          cagcod        L1
007900060104     I                                          cbcode        L1
008000010724
008100130613      * paid prem and commision total (all months selected)
008200130613      * ** all coventry premiums are in the admin fields **
008300130613      * ** the other fields for DBE, WHL and nasco are not used **
008400030109     c                   add       cpamt         c3aprem
008500030109     c                   add       ccome         c3acom
008600060314     c                   add       cadme         c3aaf
008700060314     c                   add       cbond         c3abd
008800020111
008900060104     cl1                 exsr      #l1sr
009000070130     clr                 exsr      #lrsr
009100010724
009200010724     c***********************************************************
009300061212     c* write to cr213CV  at l1 total (sman change)             *
009400010724     c***********************************************************
009500060104     c     #l1sr         begsr
009600010724
009700130614      * effective date
0098001306140202 C                   move      currentyear   c3effdt                                       SR#NA
009900130614
010000031218      * agency info
0101000304300202 C                   movel(p)  cagnam        c3agname                                      SR#NA
0102000304300202 C                   move      cagtin        c3agtxid                                      SR#NA
010300030109     c                   move      cagcod        c3agcode
010400020111
010500031218      * super agency info
0106000312180202 C                   movel(p)  casanam       c3saname                                      SR#NA
0107000312180202 C                   move      casatid       c3satxid                                      SR#NA
010800031218     c                   move      casacode      c3sacode
010900031218
011000031222      * sman info
0111000312220202 C                   movel(p)  casmnam       c3smname                                      SR#NA
0112000312220202 C                   move      casmtid       c3smtxid                                      SR#NA
011300031222     c                   move      cbcode        c3smcode
011400031222
011500060105      * get contract count from summary history file
011600031219     c                   exsr      #getccnt
011700031219
011800040121      * totals
011900130613     c                   eval      c3tprem = c3aprem
012000060314      * commission
012100130613     c                   eval      c3tcom  = c3acom
012200060314      * admin fee
012300130613     c                   eval      c3taf   = c3aaf
012400060314      * bonus draw
012500130613     c                   eval      c3tbd   = c3abd
012600100113      * current medical contract count
012700130613     c                   eval      c3tcon_CU  = c3acon_CU
012800100113      * last year medical contract count
012900130613     c                   eval      c3tcon_pr  = c3acon_pr
013000100113
013100101119      * current dental contract count
013200130613     c                   eval      c3tDcon_CU  = c3aDcon_CU
013300130613      * last year dental contract count
013400130613     c                   eval      c3tDcon_pr  = c3aDcon_pr
013500100113
013600040121
013700030107     c                   write     cr213r
013800030107     c                   clear                   cr213r
013900010724
014000010724     c                   endsr
014100060104     c************************************************************
014200061212     c* get contract count from CVEOYCC  for this sa/agency/sman *
014300060104     c************************************************************
014400031219
014500031219     c     #getccnt      begsr
014600070130      * current year
014700130613     c                   clear                   c3acon_CU
014800130613     c                   clear                   c3aDcon_CU
014900130613
015000070130     c                   move      currentyear   keyeffdt
015100061212     c     ckey          chain     CVEOYCC
015200061212     c                   if        %found(CVEOYCC)
015300130613     c                   add       cyadcnt       c3acon_CU
015400100113      * dental
015500130613     c                   add       cyadDcnt      c3aDcon_CU
015600070130      * flag rec as used in cr213
015700070130     c                   move      '@@@'         cynote
015800070130     c                   update    cveoyccr
015900031219     c                   end
016000031219
016100070130      * prior year count
016200130613     c                   clear                   c3acon_pr
016300130613     c                   clear                   c3aDcon_pr
016400130613
016500070130     c                   move      prioryear     keyeffdt
016600061212     c     ckey          chain     CVEOYCC
016700061212     c                   if        %found(CVEOYCC)
016800100113      * medical
016900130613     c                   add       cyadcnt       c3acon_pr
017000100113      * dental
017100130613     c                   add       cyadDcnt      c3aDcon_pr
017200130613
017300070130      * flag rec as used in cr213
017400070130     c                   move      '@@@'         cynote
017500070130     c                   update    cveoyccr
017600041208     c                   end
017700041208
017800031219     c                   endsr
017900030109
018000070130     c************************************************************
018100070130     c* LR routine - find all contract count records not included*
018200070130     c* in CR213CV and create a record for them                  *
018300070130     c************************************************************
018400070130
018500070130     c     #lrsr         begsr
018600070130
018700070130      * find prior year records not used
018800070130     c                   eval      year = 'P'
018900070130
019000070130     c     prioryear     setll     cveoycc
019100070130     c                   dou       %eof(cveoycc)
019200070130     c     prioryear     reade     cveoycc
019300070130     c                   if        not %eof(cveoycc) and cynote98 <> '@@@'
019400130613     c                             and (cyadcnt <> 0 or
019500130613     c                                  cyaddcnt <> 0)
019600070130     c     cr213key      chain     cr213cv
019700070130     c                   if        %found(cr213cv)
019800070130      * error - there should not be any sa/ag/sm in cr213cv that match since
019900070130      * that is the whole purpose of this new logic
020000070130     c                   except    error
020100070130     c                   else
020200070130     c                   exsr      #lrwrite
020300070130     c                   end
020400070130     c                   end
020500070130     c                   enddo
020600070130
020700070130      * find current year records not used
020800070130     c                   eval      year = 'C'
020900070130
021000070130     c     currentyear   setll     cveoycc
021100070130     c                   dou       %eof(cveoycc)
021200070130     c     currentyear   reade     cveoycc
021300070130     c                   if        not %eof(cveoycc) and cynote98 <> '@@@'
021400130613     c                             and (cyadcnt <> 0 or
021500130613     c                                  cyaddcnt <> 0)
021600070130     c     cr213key      chain     cr213cv
021700070130     c                   if        %found(cr213cv)
021800070130      * update a rec just added by this program
021900070130     c                   exsr      #lrupdate
022000070130     c                   else
022100070130     c                   exsr      #lrwrite
022200070130     c                   end
022300070130     c                   end
022400070130     c                   enddo
022500070130
022600070130
022700070130     c                   endsr
022800070130
022900070130     c***********************************************************
023000070130     c* write to cr213cv  at LR                                 *
023100070130     c***********************************************************
023200070130     c     #lrwrite      begsr
023300070130
023400070130      * clear cr213 rec
023500070130     c                   clear                   cr213r
023600130614
023700130614      * effective date
0238001306140202 C                   move      currentyear   c3effdt                                       SR#NA
023900070130
024000070130      * super agency info
024100070130     c     cysa          chain     supragcy
024200070130     c                   move      cysa          c3sacode
024300070130     c                   if        %found(supragcy)
0244000701300202 C                   movel(p)  saname1       c3saname                                      SR#NA
0245000801110202 C                   movel     sataxid       c3satxid                                      SR#NA
024600070130     c                   end
024700070130      * agency info
024800070130     c     cyag          chain     agency
024900070130     c                   move      cyag          c3agcode
025000070130     c                   if        %found(agency)
0251000701300202 C                   movel(p)  agnam1        c3agname                                      SR#NA
0252000701300202 C                   move      agtxid        c3agtxid                                      SR#NA
025300070130     c                   end
025400070130
025500070130      * sman info
025600070130     c     cysm          chain     sman
025700070130     c                   move      cysm          c3smcode
025800070130     c                   if        %found(sman)
025900070130     c                   eval      c3smname = %trim(sfname)
026000070130     c                   if        smi <> ' '
026100070130     c                   cat       smi:1         c3smname
026200070130     c                   end
026300070130     c                   cat       slname:1      c3smname
026400070130     c                   move      stin          c3smtxid
026500070130     c                   endif
026600070130
026700070130      * fill contract count from cveoycc file
026800070130      * current or prior year contract count
026900070130     c                   if        year = 'P'
027000100113      * medical
027100130613     c                   z-add     cyadcnt       c3acon_pr
027200100113      * dental
027300130613     c                   z-add     cyaddcnt      c3aDcon_pr
027400130613
027500130613     c                   eval      c3tcon_pr   = c3acon_pr
027600130613     c                   eval      c3tDcon_pr  = c3aDcon_pr
027700100113
027800070130     c                   else
027900100113      * medical
028000130613     c                   z-add     cyadcnt       c3acon_CU
028100100113      * dental
028200130613     c                   z-add     cyadDcnt      c3aDcon_CU
028300100113
028400130613     c                   eval      c3tcon_CU    = c3acon_CU
028500130613     c                   eval      c3tDcon_CU   = c3aDcon_CU
028600070130     c                   end
028700070130
028800070130     c                   write     cr213r
028900070130     c                   clear                   cr213r
029000070130
029100070130     c                   endsr
029200070130
029300070130     c***********************************************************
029400070130     c* update cr213cv  at LR                                   *
029500070130     c***********************************************************
029600070130     c     #lrupdate     begsr
029700070130
029800070130      * fill contract count from cveoycc file
029900070130      * with current year contract count
030000100113      * medical
030100130613     c                   add       cyadcnt       c3acon_CU
030200100113
030300100113      * dental
030400130613     c                   add       cyadDcnt      c3aDcon_CU
030500100113
030600130613     c                   eval      c3tcon_CU   = c3acon_CU
030700130613     c                   eval      c3tDcon_CU  = c3aDcon_CU
030800070130
030900070130     c                   update    cr213r
031000070130     c                   clear                   cr213r
031100070130
031200070130     c                   endsr
031300070130
031400030109     c     *inzsr        begsr
031500031219     c     ckey          klist
031600060104     c                   kfld                    keyeffdt
031700060104     c                   kfld                    casacode
031800031219     c                   kfld                    cagcod
031900031222     c                   kfld                    cbcode
032000070130     c     cr213key      klist
032100070130     c                   kfld                    cysa
032200070130     c                   kfld                    cyag
032300070130     c                   kfld                    cysm
032400030109     c                   endsr
0325000701300237 Oqsysprt   H    1P                     2 03
0326000701300238 O         OR    OF
0327000701300244 O                                           66 'CR213B ERROR REPORT'
0328000701300287 O          E            error          1
0329000701300288 O                       cysa                 3
0330000701300289 O                       cyag                 7
0331001212180289 O                       cysm                11
