0001009102150002 F******************************************************************
0002000301070003 F* cr213      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000201100004 F*          David Ketterman                                       *
0005000301070004 F*          01/07/03                                              *
0006009510040004 F*                                                                *
0007000301070004 F*          Create CFS Annual Persistency Bonus file.             *
0008000201110013 F*          Read workfile (CR210WK). Accululate and break by      *
0009000612120014 F*          agency creating CR213CF                               *
0010009808120015 F*                                                                *
0011000301130015 F* 01/13/03 dlk - only certain carrier codes are used for certain *
0012000301140015 F*                pieces. add carrier code to l1 and key to       *
0013000301140015 F*                cfsbonus02 because the same group # exists for  *
0014000301140015 F*                mulitple carriers.                              *
0015000301140015 F*                                                                *
0016000304300015 F* 03/30/03 ssk - salesman relationship project                   *
0017000312220015 F* 12/22/03 dlk - Change sort/break to sa/agency/sman. New file   *
0018000312220015 F*                name for 2003 = cfccnt03                        *
0019000401210015 F* 01/21/04 dlk - Add total fields per CF request.                *
0020000412080015 F* 12/06/04 dlk - new file name = cfccnt04, also add count for    *
0021000412080015 F*                2003 from cfccnt03 and change some carrier      *
0022000412080015 F*                codes for 2004.                                 *
0023000507050015 F* 07/05/05 dlk - new file name = cfccnt05, get last year count   *
0024000507050015 F*                from cfccnt04 and add 1 carrier                 *
0025000601040015 F* 01/04/06 dlk - the contract count will now come from a new     *
0026000601040015 F*                summary file named "CFEOYCC" instead of the     *
0027000601050015 F*                detail files CFCCNT**. Even though the new file *
0028000601050015 F*                CFEOYCC will eventually contain the GA count,   *
0029000601050015 F*                I will not include it in this program since     *
0030000601050015 F*                Stephens program will add it later.             *
0031000602200015 F* 02/20/06 dlk - use new fields from carrier master (included    *
0032000602200015 F*                in cr20wk) for selection instead of hard        *
0033000602200015 F*                coded list.                                     *
0034000603140015 F* 03/14/06 dlk - add admin fee and bonus draw to persistency     *
0035000603140015 F*                file for next year. Also remove PHN.            *
0036000701290015 F* 01/29/07 dlk - change to include all contract counts (BOTH     *
0037000701290015 F*                YEARS) regardless if there were paid records    *
0038000701290015 F*                in CR130HS* file. CFEOYCC is now read from      *
0039000701290015 F*                QTEMP as a copy so I can update each record     *
0040000701290015 F*                as it is used. Then at the end I will read      *
0041000701290015 F*                all the records not used and create cr213CF     *
0042000701290015 F*                records for those records.                      *
0043000712270015 F* 12/20/07 dlk - update for 2007                                 *
0044000812030015 F* 12/03/08 dlk - update for 2008                                 *
0045000911240015 F* 11/24/09 dlk - update for 2009                                 *
0046001001130015 F* 01/13/10 dlk - add dental contract count                       *
0047001011190015 F* 11/19/10 dlk - update for 2010                                 *
0048001112130015 F* 12/13/11 dlk - update for 2011                                 *
0049001212180015 F* 12/18/12 dlk - update for 2012                                 *
0050001306130015 F* 06/13/13 dlk - update for 2013, add NASCO and change field     *
0051001306130015 F*                names to get away from the year being part of   *
0052001306130015 F*                the field name. Call them current and prior     *
0053001306130015 F*                instead. This way I only have to change the     *
0054001306130015 F*                main selection dates every year instead of a    *
0055001306140015 F*                whole bunch of field names. Also add effective  *
0056001306140015 F*                date field so the current / prior make sense    *
0057001412020015 F* 12/02/14 dlk - update for 2014 (dates to select for contract   *
0058001412020015 F*                count only)                                     *
0059001511180015 F* 11/18/15 dlk - update for 2015 (dates to select for contract   *
0060001511180015 F*                count only)                                     *
0061001611300015 F* 11/30/16 dlk - update for 2016 (dates to select for contract   *
0062001611300015 F*                count only)                                     *
0063001712070015 F* 12/07/17 dlk - update for 2017 (dates to select for contract   *
0064001712070015 F*                count only)                                     *
0065001801240015 F* 01/24/18 dlk - update for special last run, dates to select    *
0066001801240015 F*                will be 12/31/16 - 1/31/18 (13 month)           *
0067001901230015 F* 01/23/19 dlk - update for 2019 (dates to select for contract   *
0068001901230015 F*                count only)                                     *
0069001912130015 F* 12/13/19 dlk - update for 2020 (dates to select for contract   *
0070001912130015 F*                count only)                                     *
0071002012150015 F* 12/15/20 dlk - update for 2021 (dates to select for contract   *
0072002012150015 F*                count only)                                     *
0073002112080015 F* 12/08/21 dlk - update for 2022 (dates to select for contract   *
0074002112080015 F*                count only)                                     *
0075002212290015 F* 12/29/22 dlk - update for 2023 (dates to select for contract   *
0076002212290015 F*                count only)                                     *
0077002112080015 F*                                                                *
0078009102150016 F******************************************************************
0079000201110018 FCR210wk   Ip   E             DISK
0080000701290018 Fcfeoycc   uf   E           K DISK
008100070129     fagency    if   e           k disk
008200070129     fsupragcy  if   e           k disk
008300070129     fsman      if   e           k disk
0084000701290027 Fcr213cf   uf a e           k disk
0085000701300019 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
0086000601040125 D  keyeffdt       s              8  0
008700130613
008800130613      ********************************************************************
008900130613      * dates to select for contract count - NEED TO CHANGE EVERY YEAR
0090002312200125 D  prioryear      s              8  0 inz(20220131)
0091002312200125 D  currentyear    s              8  0 inz(20230131)
009200130613      ********************************************************************
009300070129
0094000701290125 D  year           s              1
0095000701290124 D                 DS
0096000701290125 D  cynote                 1    100
0097000701290125 D  cynote98              98    100
0098000701290124 D                UDS
0099000701290125 D  LFYMD                 85     92  0
0100000108010125 D  LTYMD                 93    100  0
010100010724     Icr210wkr
010200060104     I                                          casacode      L1
010300060104     I                                          cagcod        L1
010400060104     I                                          cbcode        L1
010500010724
010600060105      * paid prem and commision total (all months selected)
010700030113      * only certain carriers will be included in the totals (based
010800030113      * on the list from finance)
010900060220      * 02/20/06 - use new field from carrier instead of hard coded list
011000060220      *
011100060110      **********************************************************************
011200060110      * *** Remember to change RPA163 to match this list of carriers ***
011300060110      **********************************************************************
011400030113
011500060220     c                   select
011600060220      * admin prem & com
011700060220     c                   when      cr2capbpc = 'Y' and
011800060220     c                             (cr2carbc = '1' or cr2carbc = '2' or
011900060220     c                              cr2carbc = '3' or cr2carbc = '4')
012000030109     c                   add       cpamt         c3aprem
012100030109     c                   add       ccome         c3acom
012200060314     c                   add       cadme         c3aaf
012300060314     c                   add       cbond         c3abd
012400060220      * dbe prem & com
012500060220     c                   when      cr2capbpc = 'Y' and (cr2carbc = 'D')
012600030109     c                   add       cpamt         c3dprem
012700030109     c                   add       ccome         c3dcom
012800060314     c                   add       cadme         c3daf
012900060314     c                   add       cbond         c3dbd
013000130613      * NASCO prem & com
013100130613     c                   when      cr2capbpc = 'Y' and (cbpd = 'N')
013200130613     c                   add       cpamt         c3nprem
013300130613     c                   add       ccome         c3ncom
013400130613     c                   add       cadme         c3naf
013500130613     c                   add       cbond         c3nbd
013600130613
013700030109     c                   endsl
013800020111
013900060104     cl1                 exsr      #l1sr
014000070129     clr                 exsr      #lrsr
014100010724
014200010724     c***********************************************************
014300061212     c* write to cr213CF  at l1 total (sman change)             *
014400010724     c***********************************************************
014500060104     c     #l1sr         begsr
014600010724
014700130614      * effective date
0148001306140202 C                   move      currentyear   c3effdt                                       SR#NA
014900130614
015000130614      * agency info
0151000304300202 C                   movel(p)  cagnam        c3agname                                      SR#NA
0152000304300202 C                   move      cagtin        c3agtxid                                      SR#NA
015300030109     c                   move      cagcod        c3agcode
015400020111
015500031218      * super agency info
0156000312180202 C                   movel(p)  casanam       c3saname                                      SR#NA
0157000312180202 C                   move      casatid       c3satxid                                      SR#NA
015800031218     c                   move      casacode      c3sacode
015900031218
016000031222      * sman info
0161000312220202 C                   movel(p)  casmnam       c3smname                                      SR#NA
0162000312220202 C                   move      casmtid       c3smtxid                                      SR#NA
016300031222     c                   move      cbcode        c3smcode
016400031222
016500060105      * get contract count from summary history file
016600031219     c                   exsr      #getccnt
016700031219
016800040121      * totals
016900130613     c                   eval      c3tprem = c3aprem + c3dprem + c3wprem +
017000130613     c                             c3nprem
017100060314      * commission
017200130613     c                   eval      c3tcom  = c3acom  + c3dcom  + c3wcom +
017300130613     c                             c3ncom
017400060314      * admin fee
017500130613     c                   eval      c3taf   = c3aaf + c3daf + c3waf +
017600130613     c                             c3naf
017700060314      * bonus draw
017800130613     c                   eval      c3tbd   = c3abd + c3dbd + c3wbd +
017900130613     c                             c3nbd
018000100113      * current medical contract count
018100130614     c                   eval      c3tcon_cu  = c3acon_cu  + c3dcon_cu
018200130614     c                             + c3wcon_cu   + c3ncon_cu
018300100113      * last year medical contract count
018400130613     c                   eval      c3tcon_pr   = c3acon_pr  + c3dcon_pr
018500130613     c                             + c3wcon_pr  + c3ncon_pr
018600100113      * current dental contract count
018700130614     c                   eval      c3tDcon_cu  = c3aDcon_cu  + c3dDcon_cu
018800130614     c                             + c3wDcon_cu  + c3nDcon_cu
018900100113      * last year dental contract count
019000130613     c                   eval      c3tDcon_pr  = c3aDcon_pr  + c3dDcon_pr
019100130613     c                             + c3wDcon_pr  + c3nDcon_pr
019200040121
019300030107     c                   write     cr213r
019400030107     c                   clear                   cr213r
019500010724
019600010724     c                   endsr
019700060104     c************************************************************
019800060104     c* get contract count from cfeoycc  for this sa/agency/sman *
019900060104     c************************************************************
020000031219
020100031219     c     #getccnt      begsr
020200070129      * current year
020300130614     c                   clear                   c3acon_cu
020400130614     c                   clear                   c3aDcon_cu
020500130614     c                   clear                   c3dcon_cu
020600130614     c                   clear                   c3dDcon_cu
020700130614     c                   clear                   c3wcon_cu
020800130614     c                   clear                   c3wDcon_cu
020900130614     c                   clear                   c3ncon_cu
021000130614     c                   clear                   c3nDcon_cu
021100130613
021200070129     c                   move      currentyear   keyeffdt
021300060104     c     ckey          chain     cfeoycc
021400060104     c                   if        %found(cfeoycc)
021500100113      * medical
021600130614     c                   add       cyadcnt       c3acon_cu
021700130614     c                   add       cydbcnt       c3dcon_cu
021800130614     c**                 add       cygacnt       c3wcon_cu
021900130614     c                   add       cynacnt       c3ncon_cu
022000100113      * dental
022100130614     c                   add       cyadDcnt      c3adcon_cu
022200130614     c                   add       cydbDcnt      c3dDcon_cu
022300130614     c**                 add       cygaDcnt      c3wDcon_cu
022400130614     c                   add       cynaDcnt      c3nDcon_cu
022500070129      * flag rec as used in cr213
022600070129     c                   move      '@@@'         cynote
022700070129     c                   update    cfeoyccr
022800031219     c                   end
022900031219
023000070129      * prior year count
023100130613     c                   clear                   c3acon_pr
023200130613     c                   clear                   c3aDcon_pr
023300130613     c                   clear                   c3dcon_pr
023400130613     c                   clear                   c3dDcon_pr
023500130613     c                   clear                   c3wcon_pr
023600130613     c                   clear                   c3wDcon_pr
023700130613     c                   clear                   c3ncon_pr
023800130613     c                   clear                   c3nDcon_pr
023900130613
024000070129     c                   move      prioryear     keyeffdt
024100060104     c     ckey          chain     cfeoycc
024200060104     c                   if        %found(cfeoycc)
024300100113      * medical
024400130613     c                   add       cyadcnt       c3acon_pr
024500130613     c                   add       cydbcnt       c3dcon_pr
024600130613     c**                 add       cygacnt       c3wcon_pr
024700130613     c                   add       cynacnt       c3ncon_pr
024800100113      * dental
024900130613     c                   add       cyadDcnt      c3aDcon_pr
025000130613     c                   add       cydbDcnt      c3dDcon_pr
025100130613     c**                 add       cygaDcnt      c3wDcon_pr
025200130613     c                   add       cynaDcnt      c3nDcon_pr
025300070129      * flag rec as used in cr213
025400070129     c                   move      '@@@'         cynote
025500070129     c                   update    cfeoyccr
025600041208     c                   end
025700041208
025800031219     c                   endsr
025900030109
026000070129     c************************************************************
026100070129     c* LR routine - find all contract count records not included*
026200070129     c* in CR213CF and create a record for them                  *
026300070129     c************************************************************
026400070129
026500070129     c     #lrsr         begsr
026600070129
026700070129      * find prior year records not used
026800070129     c                   eval      year = 'P'
026900070129
027000070129     c     prioryear     setll     cfeoycc
027100070129     c                   dou       %eof(cfeoycc)
027200070129     c     prioryear     reade     cfeoycc
027300070130     c                   if        not %eof(cfeoycc) and cynote98 <> '@@@'
027400100128     c                             and (cyadcnt <> 0 or cydbcnt <> 0 or
027500130613     c                                  cynacnt <> 0 or
027600130613     c                                  cyaddcnt <> 0 or cydbdcnt <> 0 or
027700130613     c                                  cynadcnt <> 0)
027800070130     c     cr213key      chain     cr213cf
027900070129     c                   if        %found(cr213cf)
028000070129      * error - there should not be any sa/ag/sm in cr213cf that match since
028100070129      * that is the whole purpose of this new logic
028200070130     c                   except    error
028300070129     c                   else
028400070129     c                   exsr      #lrwrite
028500070129     c                   end
028600070129     c                   end
028700070129     c                   enddo
028800070129
028900070129      * find current year records not used
029000070129     c                   eval      year = 'C'
029100070129
029200070129     c     currentyear   setll     cfeoycc
029300070129     c                   dou       %eof(cfeoycc)
029400070129     c     currentyear   reade     cfeoycc
029500070130     c                   if        not %eof(cfeoycc) and cynote98 <> '@@@'
029600100128     c                             and (cyadcnt <> 0 or cydbcnt <> 0 or
029700130613     c                                  cynacnt <> 0 or
029800130613     c                                  cyaddcnt <> 0 or cydbdcnt <> 0 or
029900130613     c                                  cynadcnt <> 0)
030000070130     c     cr213key      chain     cr213cf
030100070129     c                   if        %found(cr213cf)
030200070129      * update a rec just added by this program
030300070129     c                   exsr      #lrupdate
030400070129     c                   else
030500070129     c                   exsr      #lrwrite
030600070129     c                   end
030700070129     c                   end
030800070129     c                   enddo
030900070129
031000070129
031100070129     c                   endsr
031200070129
031300070129     c***********************************************************
031400070129     c* write to cr213CF  at LR                                 *
031500070129     c***********************************************************
031600070129     c     #lrwrite      begsr
031700070129
031800070129      * clear cr213 rec
031900070129     c                   clear                   cr213r
032000130614
032100130614      * effective date
0322001306140202 C                   move      currentyear   c3effdt                                       SR#NA
032300070129
032400070129      * super agency info
032500070129     c     cysa          chain     supragcy
032600070129     c                   move      cysa          c3sacode
032700070129     c                   if        %found(supragcy)
0328000701290202 C                   movel(p)  saname1       c3saname                                      SR#NA
0329000801110202 C                   movel     sataxid       c3satxid                                      SR#NA
033000070129     c                   end
033100070129      * agency info
033200070129     c     cyag          chain     agency
033300070129     c                   move      cyag          c3agcode
033400070129     c                   if        %found(agency)
0335000701290202 C                   movel(p)  agnam1        c3agname                                      SR#NA
0336000701290202 C                   move      agtxid        c3agtxid                                      SR#NA
033700070129     c                   end
033800070129
033900070129      * sman info
034000070129     c     cysm          chain     sman
034100070129     c                   move      cysm          c3smcode
034200070129     c                   if        %found(sman)
034300070129     c                   eval      c3smname = %trim(sfname)
034400070129     c                   if        smi <> ' '
034500070129     c                   cat       smi:1         c3smname
034600070129     c                   end
034700070129     c                   cat       slname:1      c3smname
034800070129     c                   move      stin          c3smtxid
034900070129     c                   endif
035000070129
035100070129      * fill contract count from cfeoycc file
035200100128      * prior year contract count
035300070129     c                   if        year = 'P'
035400100113      * medical
035500130613     c                   z-add     cyadcnt       c3acon_pr
035600130613     c                   z-add     cydbcnt       c3dcon_pr
035700130613     c***                z-add     cygacnt       c3wcon_pr
035800130613     c                   z-add     cynacnt       c3ncon_pr
035900100113      * dental
036000130613     c                   z-add     cyaddcnt      c3aDcon_pr
036100130613     c                   z-add     cydbdcnt      c3dDcon_pr
036200130613     c***                z-add     cygadcnt      c3wDcon_pr
036300130613     c                   z-add     cynadcnt      c3nDcon_pr
036400130613
036500130613     c                   eval      c3tcon_pr   = c3acon_pr  + c3dcon_pr
036600130613     c                             + c3wcon_pr  + c3ncon_pr
036700130613     c                   eval      c3tDcon_pr  = c3aDcon_pr  + c3dDcon_pr
036800130613     c                             + c3wDcon_pr  + c3nDcon_pr
036900100113
037000100128      * current year contract count
037100070129     c                   else
037200100113      * medical
037300130613     c                   z-add     cyadcnt       c3acon_cu
037400130613     c                   z-add     cydbcnt       c3dcon_cu
037500130613     c***                z-add     cygacnt       c3wcon_cu
037600130613     c                   z-add     cynacnt       c3ncon_cu
037700100113      * dental
037800130613     c                   z-add     cyadDcnt      c3adcon_cu
037900130613     c                   z-add     cydbDcnt      c3dDcon_cu
038000130613     c***                z-add     cygaDcnt      c3wDcon_cu
038100130613     c                   z-add     cynaDcnt      c3nDcon_cu
038200100113
038300130613     c                   eval      c3tcon_cu  = c3acon_cu  + c3dcon_cu   +
038400130613     c                             + c3wcon_cu  + c3ncon_cu
038500130613     c                   eval      c3tDcon_cu  = c3aDcon_cu  + c3dDcon_cu
038600130613     c                             + c3wDcon_cu  + c3nDcon_cu
038700070129     c                   end
038800070129
038900070129     c                   write     cr213r
039000070129     c                   clear                   cr213r
039100070129
039200070129     c                   endsr
039300070129
039400070129     c***********************************************************
039500070129     c* update cr213CF  at LR                                   *
039600070129     c***********************************************************
039700070129     c     #lrupdate     begsr
039800070129
039900070129      * fill contract count from cfeoycc file
040000070129      * with current year contract count
040100100113      * medical
040200130613     c                   add       cyadcnt       c3acon_cu
040300130613     c                   add       cydbcnt       c3dcon_cu
040400130613     c***                add       cygacnt       c3wcon_cu
040500130613     c                   add       cynacnt       c3ncon_cu
040600100113
040700100113      * dental
040800130613     c                   add       cyadDcnt      c3adcon_cu
040900130613     c                   add       cydbDcnt      c3dDcon_cu
041000130613     c***                add       cygaDcnt      c3wDcon_cu
041100130613     c                   add       cynaDcnt      c3nDcon_cu
041200100113
041300130613     c                   eval      c3tcon_cu  = c3acon_cu  + c3dcon_cu
041400130613     c                             + c3wcon_cu  + c3ncon_cu
041500130613     c                   eval      c3tDcon_cu  = c3aDcon_cu  + c3dDcon_cu
041600130613     c                             + c3wDcon_cu  + c3nDcon_cu
041700070129
041800070129     c                   update    cr213r
041900070129     c                   clear                   cr213r
042000070129
042100070129     c                   endsr
042200070129
042300030109     c     *inzsr        begsr
042400031219     c     ckey          klist
042500060104     c                   kfld                    keyeffdt
042600060104     c                   kfld                    casacode
042700031219     c                   kfld                    cagcod
042800031222     c                   kfld                    cbcode
042900070129     c     cr213key      klist
043000070129     c                   kfld                    cysa
043100070129     c                   kfld                    cyag
043200070129     c                   kfld                    cysm
043300030109     c                   endsr
0434000701300237 Oqsysprt   H    1P                     2 03
0435000701300238 O         OR    OF
0436000701300244 O                                           66 'CR213 ERROR REPORT'
0437000701300287 O          E            error          1
0438000701300288 O                       cysa                 3
0439000701300289 O                       cyag                 7
0440000701300289 O                       cysm                11
