0001000204020002  *****************************************************************************
000200061024      * DELBLDGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400061024      *            DATE - 10/2006                                                 *
000500061024      *  DESCRIPTION - Build Delta Dental coverage file from GBS files            *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900101228      *  RLJ 12/28/2010 Look for car cod of DEA and DE1 as well as DEM
001000120118      *  RLJ 01/18/2012 Don't send recs for acct 300-1-100 per C Gibbons
001100120607      *  RLJ 06/07/2012 Don't send recs for acct 590-9-119 per C Gibbons
001200120607      *                 and Deb Clark (group# = 0997).
001300130102      *  RLJ 01/02/2013 Don't send recs for acct 598-1-001 per C Gibbons
001400130903      *  RLJ 09/03/2013 Don't send recs for acct 590-9-016 per C Gibbons
001500130918      *  RLJ 09/18/2013 Use GRATE recs prior to 20131101
001600131024      *  RLJ 10/24/2013 Remove recs termed prior to 07/01/2013
001700020402      *                                                                *
0018009102150018 F******************************************************************
0019000610240020 Fplnmstn1  IF   E           K DISK
0020000610240020 Fgrat25    IF   E           K DISK
0021000610240020 Fmcovl1    IF   E           K DISK
0022000205240020 Fmcov38    IF   E           K DISK    RENAME(MCOVR:MC38R)
0023000205240020 F                                     PREFIX(X)
0024000205170020 Fmember    IF   E           K DISK
0025000205170020 Fdepndc    IF   E           K DISK
0026000205170020 Fdcov      IF   E           K DISK
0027001310240020 Fddelgsxp  IF   E           K DISK
0028000810300020 Fddelcvgl  UF   E           K DISK    RENAME(DDELCVGR:DDELLR)
0029000810300020 F                                     PREFIX(L)
0030000610240020 Fddelcvgp  O    E             DISK
0031000204020029  *
0032000204260029  *   Format Input Records
0033009102150250 D                 DS
0034000205020251 D  recid1                 1     74
0035000204260251 D   r1plcd                1      2
0036001112210251 D   r1grp#                3      6
0037001112210251 D   r1grpn                7     36
0038001112210251 D   r1cntc               37     65
0039001112210251 D   r1cnt#               66     75
0040001112210250 D                 DS
0041001112210251 D  recid2                 1     74
0042001112210251 D   r2soc#                1      9
0043000204260251 D    r2socn               1      9S 0
0044000204260251 D   r2grp#               10     13
0045000204260251 D   r2subl               14     17
0046000204260251 D   r2relc               18     18
0047000204260251 D   r2dob                19     24
0048000205020251 D    r2dobmd             19     22  0
0049000205020251 D    r2dobyy             23     24  0
0050000204260251 D   r2rate               25     25
0051000204260251 D   r2fnm                26     33
0052000205080251 D     r2fnm3             26     28
0053000204260251 D   r2lnm                34     49
0054000204260251 D   r2effd               50     55
0055000205020251 D    r2efmd              50     53  0
0056000205020251 D    r2efyy              54     55  0
0057000204260251 D   r2term               56     61
0058000205020251 D    r2trmmd             56     59  0
0059000205020251 D    r2trmyy             60     61  0
0060000204260251 D   r2actc               62     62
0061000204260251 D   r2strt               63     68
0062000205240251 D    r2stmd              63     66  0
0063000205240251 D    r2stda              65     66
0064000205210251 D    r2styy              67     68  0
0065000204260251 D   r2end                69     74
0066000205210251 D    r2endmd             69     72  0
0067000205310251 D    r2endda             71     72  0
0068000205210251 D    r2endyy             73     74  0
0069000204260250 D                 DS
0070000205020251 D  recid3                 1     74
0071000204260251 D   r3cnt                 1      8
0072000205170251 D   r3cntn                1      8  0 INZ(0)
0073000204260250 D                 DS
0074000205020251 D  recid5a                1     74
0075000204260251 D   r5soc#                1      9
0076000204260251 D   r5fil1               10     10
0077000204260251 D   r5grp#               11     14
0078000204260251 D   r5add1               15     38
0079000204260251 D   r5add2               39     62
0080000204260251 D   r5fil2               63     72
0081000204260251 D   r5segc               73     73
0082000204260251 D   r5actc               74     74
0083000204260250 D                 DS
0084000205020251 D  recid5b                1     74
0085000204260251 D   r5socb                1      9
0086000204260251 D   r5fl1b               10     10
0087000204260251 D   r5grpb               11     14
0088000204260251 D   r5city               15     28
0089000204260251 D   r5st                 29     31
0090000204260251 D   r5zip                32     40
0091000205060251 D    r5zip5              32     36
0092000205060251 D    r5zip4              37     40
0093000205020251 D   r5zipn               32     40  0
0094000204260251 D   r5fl2b               41     42
0095000204260251 D   r5phon               43     52
0096000205020251 D    r5ac                43     45  0
0097000205020251 D    r5phnn              46     52  0
0098000204260251 D   r5fl3b               53     72
0099000204260251 D   r5segb               73     73
0100000204260251 D   r5actb               74     74
0101000205210029  *   Save Mbr and Dep input recs
0102000205210250 D                 DS
0103000205210251 D  rec2hld                1   1036    INZ(*BLANKS)
0104000205210251 D  rec2a                  1     74
0105000205210251 D  rec2b                 75    148
0106000205210251 D  rec2c                149    222
0107000205210251 D  rec2d                223    296
0108000205210251 D  rec2e                297    370
0109000205210251 D  rec2f                371    444
0110000205210251 D  rec2g                445    518
0111000205210251 D  rec2h                519    592
0112000205210251 D  rec2i                593    666
0113000205210251 D  rec2j                667    740
0114000205210251 D  rec2k                741    814
0115000205210251 D  rec2l                815    888
0116000205210251 D  rec2m                889    962
0117000205210251 D  rec2n                963   1036
0118000205210029  *
0119000810300250 D                 DS
0120000810300251 D  lecid2                 1     74
0121000810300251 D   l2soc#                1      9
0122000810300251 D    l2socn               1      9S 0
0123000810300251 D   l2grp#               10     13
0124000810300251 D   l2subl               14     17
0125000810300251 D   l2relc               18     18
0126000810300251 D   l2dob                19     24
0127000810300251 D    l2dobmd             19     22  0
0128000810300251 D    l2dobyy             23     24  0
0129000810300251 D   l2rate               25     25
0130000810300251 D   l2fnm                26     33
0131000810300251 D     l2fnm3             26     28
0132000810300251 D   l2lnm                34     49
0133000810300251 D   l2effd               50     55
0134000810300251 D    l2efmd              50     53  0
0135000810300251 D    l2efyy              54     55  0
0136000810300251 D   l2term               56     61
0137000810300251 D    l2trmmd             56     59  0
0138000810300251 D    l2trmyy             60     61  0
0139000810300251 D   l2actc               62     62
0140000810300251 D   l2strt               63     68
0141000810300251 D    l2stmd              63     66  0
0142000810300251 D    l2stda              65     66
0143000810300251 D    l2styy              67     68  0
0144000810300251 D   l2end                69     74
0145000810300251 D    l2endmd             69     72  0
0146000810300251 D    l2endda             71     72  0
0147000810300251 D    l2endyy             73     74  0
0148000810300029  *
0149000204260250 D                 DS
0150000610240251 D  group#                 1     15
0151000610240251 D    grp14                1      4
0152001310240251 D    grp18                1      8
0153001310240251 D    grp110               1     10
0154000610240251 D    grp58                5      8
0155001310240251 D    grp9                 9      9
0156001310240251 D    grp910               9     10
0157000810300029  *
0158000810300250 D                 DS
0159001309260251 D  raty           S              1
0160001309260251 D  kyid           S              1
0161000810300251 D  kydata         S             74    INZ(*BLANKS)
0162001203120251 D  dupmem         S              1
0163001711200251 D  skpmbr         S              1
0164001203120251 D  dupem          S              1
0165000810300251 D  updtd          S              1
0166000610240029  *
0167000610240250 D                 DS
0168000610240251 D  datymd                 1      8  0
0169000610240251 D    ymdcc                1      2  0
0170000610240251 D    ymdyy                3      4  0
0171000205070251 D    ymdmd                5      8  0
0172000205170250 D                 DS
0173000205170251 D  mktrst                        3  0 INZ(419)
0174000205170251 D  mksub                         3  0 INZ(1)
0175000205170251 D  mkplan                        4    INZ('7000')
0176000205210251 D  cntspc                        2  0 INZ(0)
0177000205210251 D  cntkid                        2  0 INZ(0)
0178000205210251 D  savrat                        1    INZ(' ')
0179000205210251 D  todaa                         2  0
0180000610240251 D  kcarr                              LIKE(PCARR)
0181000610240251 D  rgrp#                              LIKE(r2grp#)
0182000610240251 D  rsubl                              LIKE(r2subl)
0183000205210250 D                 DS
0184000205210251 D  ISOdate        S               D
0185000205210251 D  ISOnum         S              8  0
0186000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0187000205240251 D  enrdat         S              8  0
0188000205240251 D  trmdat         S              8  0
0189000205210250 D                 DS
0190000205310251 D  wrkdat8                1      8  0
0191000205310251 D   wrkda                 7      8  0
0192000205310250 D                 DS
0193000205310251 D  dftstrt                1      8  0
0194000205210251 D    strtda               7      8  0
0195000205210251 D  dftend                 9     16  0
0196000205210251 D    endda               15     16  0
0197000205210251 D  mdystrt               17     22  0
0198000205210251 D   strta                17     22
0199000205210251 D  mdyend                23     28  0
0200000205210251 D   enda                 23     28
020100020517      *
020200061024     C     grkey         klist
020300061024     C                   kfld                    pltrst
020400061024     C                   kfld                    plsub#
020500061024     C                   kfld                    plplan
020600061024      *
020700061024     C     mckey         klist
020800061024     C                   kfld                    mktrst
020900061024     C                   kfld                    mksub
021000061024     C                   kfld                    mkplan
021100020517      *
021200090917     C     xrkey         klist
021300090917     C                   kfld                    mctrst
021400090917     C                   kfld                    mcsub#
021500090917     C                   kfld                    acc#
021600090917      *
021700020517     C     dpkey         klist
021800090917     C                   kfld                    ssno
021900090917     C                   kfld                    dseq#
022000090917      *
022100020524     C     m38ky         klist
022200090917     C                   kfld                    mcssno
022300090917     C                   kfld                    mdseq#
022400090917     C                   kfld                    mctrst
022500020524     C                   kfld                    mcsub#
022600020524     C                   kfld                    mcplan
022700081030      *
022800081030     C     dekey         klist
022900081030     C                   kfld                    kyid
023000081030     C                   kfld                    kydata
023100020517      *
023200020503      ******************************************************************************
023300020517      *      MainLine
0234000205211304  *         Calculate default action dates
023500020521     C                   move      UDATE         ISOdate
023600020521     C                   move      ISOdate       ISOnum
023700020521     C                   extrct    ISOdate:*D    todaa
023800020521     C                   if        todaa > 25
023900020521     C                   adddur    10:*D         ISOdate
024000020521     C                   endif
024100020521     C                   move      ISOdate       dftstrt
024200020521     C                   z-add     01            strtda
024300210901     C                   move      dftstrt       ISOdate
024400210901     C                   eval      MDYdate = ISOdate
024500210901     C                   move      MDYdate       mdystrt
024600210901     C                   move      dftstrt       ISOdate
024700210901     C                   adddur    1:*M          ISOdate
024800210901     C                   subdur    1:*D          ISOdate
024900020521     C                   move      ISOdate       dftend
025000020521     C                   eval      MDYdate = ISOdate
025100020521     C                   move      MDYdate       mdyend
0252000205211304  *         Build RecId 1
025300061024     C                   clear                   ddelcvgr
025400020521     C                   eval      dcrcid = '1'
025500020521     C                   eval      recid1 = *blanks
025600061024     C                   eval      r1plcd = 'PA'
025700061024     C                   eval      r1grp# = '7414'
025800061024     C                   eval      r1grpn = 'GBS        '
025900061024     C                   eval      r1cntc = 'Carol Fabiszak'
026000061024     C                   eval      r1cnt# = '4108325141'
026100020517     C                   eval      dcdata = recid1
026200020517     C                   add       1             r3cntn
026300061024     C                   write     ddelcvgr
0264000204260111  *
0265001012280107  *      Loop thru PLNMST looking for Carrier = 'DEA', 'DEM' or 'DE1'
026600101228     C                   eval      kcarr = 'DEA'
026700061024     C     kcarr         setll     plnmstn1
026800061024     C                   dou       *in23 = '1'
026900101228     C                   read      plnmstn1                               23
027000101228     C                   if        *in23 = '1' or PCARR > 'DE1'
027100101228     C                   leave
027200101228     C                   endif
0273002105050111  *
027400210505     C                   if        sfadm = 'Y'
027500210505     C                   iter
027600210505     C                   endif
0277002105050111  *
027800101228     C                   if        PCARR = 'DEA' or pcarr = 'DEM' or
027900101228     C                             PCARR = 'DE1'
0280000612120111  *
0281000612120107  *   **** Ignore trst = 590 and sub = 008
0282001008260107  *   ****   Removed this 8/26/2010 per C. Fab
0283000610240107  *         Get Grp# and subloc
028400100826     C******             if        pltrst = 590 and
028500100826     C******                       plsub# = 8
028600100826     C******             iter
028700101228     C******             endif
0288001310010107  *        Debug shit
028900131001     C                   if        pltrst = 597 and
029000131001     C                             plsub# = 1
029100131001     C                   eval      plplan = plplan
029200131001     C                   endif
0293000612120107  *   **** Ignore trst = 590 and sub = 008
029400130926     C                   eval      raty = 'N'
0295001309180107  *      Loop thru MCOVL1 to locate all mbrs
029600130926     C     grkey         chain     grat25                             24
0297001309260107  *      Loop thru MCOVL1 to locate all mbrs
029800130918     C     grkey         setll     grat25
029900130918     C                   dou       *in24 = '1'
030000130918     C     grkey         reade     grat25                                 24
030100131024     C*******            if        *in24 = '0' and frmdat < 20131101
030200131024     C                   if        *in24 = '0'
0303001310240107  *      check group# for digit 9
030400131024     C                   if        grp9 <> ' '
030500131024     C     grp110        chain     ddelgsxp                           32
030600131024     C                   if        *in32 = '0'
030700131024     C                   movel(P)  dx08gs        group#
030800131024     C                   else
030900131024     C                   eval      group# = group#
031000131024     C                   endif
031100131024     C                   endif
0312001310240107  *
031300131024     C                   eval      rgrp# = grp14
031400061024     C                   eval      rsubl = grp58
031500130926     C                   eval      raty = 'Y'
031600130918     C                   leave
031700061024     C                   endif
031800130918     C                   enddo
0319000902100107  *   **** Bypass termed grp# 9690 prt Delta 02/2009
0320001201180107  *** Also Bypass termed grp# 7129 per Delta 01/2012 - Chris Gibbons
0321001206070107  *** Also Bypass termed grp# 0997 per Delta 06/2012 - Chris Gibbons
0322001301020107  *** Also Bypass termed grp# 6408 per Delta 06/2012 - Chris Gibbons
0323001309030107  *** Also Bypass termed grp# 1554 per Delta 09/2013 - Chris Gibbons
032400120118     C                   if        rgrp# = '9690' or
032500120607     C                             rgrp# = '0997' or
032600130102     C                             rgrp# = '6408' or
032700130903     C                             rgrp# = '1554' or
032800130926     C                             rgrp# = '7129' or
032900130926     C                             raty = 'N'
033000090210     C                   iter
033100090210     C                   endif
0332001203060107  *      Debug shit
033300120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
033400120306     C                   eval      mcssno = mcssno
033500120306     C                   endif
0336000610240111  *
0337000610240107  *      Loop thru MCOVL1 to locate all mbrs
033800061024     C     grkey         setll     mcovl1
033900061024     C                   dou       *in21 = '1'
034000061024     C     grkey         reade     mcovl1                                 21
034100061024     C                   if        *in21 = '0'
0342000205240107  *      If enroll date and term date are equal => bypass record
034300020524     C                   if        enrldt = candt
034400020524     C                   iter
034500020524     C                   endif
0346001310240107  *      If term date is prior to 7/1/2013 => bypass record
034700131024     C                   if        candt <> 0 and candt < 20130701
034800131024     C                   iter
034900131024     C                   endif
0350000810310107  *      Debug shit
035100131025     C                   if        mcssno = 353445365
035200081031     C                   eval      mcssno = mcssno
035300081031     C                   endif
0354000205240107  *
035500020524     C                   exsr      bldmbr
0356001203120107  *     If member was duplicate - skip
035700171120     C                   if        dupmem = 'Y' or skpmbr = 'Y'
035800120312     C                   iter
035900120312     C                   endif
0360000610250107  *      Loop thru DCOV to locate all Delta dependents
036100020517     C     mcssno        setll     dcov
036200020517     C                   dou       *in22 = '1'
036300020517     C     mcssno        reade     dcov                                   22
036400020517     C                   if        *in22 = '0'
0365000206260107  *      If enroll date and term date are equal => bypass record
036600020524     C                   if        denrdt = ccandt
036700020524     C                   iter
036800020524     C                   endif
0369001310240107  *      If term date is prior to 7/1/2013 => bypass record
037000131024     C                   if        ccandt <> 0 and ccandt < 20130701
037100131024     C                   iter
037200131024     C                   endif
0373001310240107  *
037400061025     C                   if        mcssno = ssno and dvplan = plplan
037500020517     C                   exsr      blddep
037600020517     C                   endif
037700020517     C                   else
037800020517     C                   leave
037900020517     C                   endif
038000020517     C                   enddo
0381000810300107  *      Create rec2 recs for mbr and dep data
038200081030     C                   exsr      bldrec2
0383000205210107  *      Create members address records
038400020521     C                   exsr      bldadr
038500020517     C                   endif
038600020517     C                   enddo
038700061024     C                   endif
038800061024     C                   enddo
038900020517     C                   exsr      bldrc3
039000020517     C                   movel     '1'           *inlr
039100020517     C                   return
0392000204020107  ********************************************************************************
0393000204020107  *
0394000205170107  *     BLDMBR - Build Record ID = '2' - Member data
0395000204020107  *
0396000204020107  ********************************************************************************
039700020517     C     bldmbr        begsr
039800020521     C                   eval      rec2hld = *blanks
039900020521     C                   eval      cntspc = 0
040000020521     C                   eval      cntkid = 0
040100020517     C     mcssno        chain     member                             31
040200020517     C                   if        *in31 = '0'
0403001711200107  *      Look for specific account - skip add
040400171120     C*****              eval      skpmbr = 'N'
040500171120     C*****              if        mbtrst = 597 and mbsub# = 1 and
040600171120     C*****                        mbacct = 36
040700171120     C*****              eval      skpmbr = 'Y'
040800171120     C*****              leavesr
040900171120     C******             endif
0410000205170107  *       Build Record ID 2 - Member Data
041100020521     C*********          clear                   ddelcvr
041200020521     C*********          eval      dcrcid = '2'
041300020517     C                   eval      recid2 = *blanks
041400020517     C                   z-add     mcssno        r2socn
041500020517     C                   eval      r2relc = '1'
041600061024     C                   eval      r2grp# = rgrp#
041700061024     C                   eval      r2subl = rsubl
041800020517     C                   z-add     birth         datymd
041900020517     C                   z-add     ymdyy         r2dobyy
042000020517     C                   z-add     ymdmd         r2dobmd
042100020517     C                   eval      r2fnm = mfname
042200020517     C                   eval      r2lnm = mlname
042300020524     C                   z-add     enrldt        enrdat
042400020524     C                   z-add     candt         trmdat
0425000810310107  *     debug shit
042600131016     C                   if        mcssno = 203368142
042700020524     C                   eval      mcssno = mcssno
042800020524     C                   endif
0429001009130107  *
0430000205240107  *      Loop thru MCOV38 to locate all coverages for Mbr for TK - Delta
043100020524     C     m38ky         setll     mcov38
043200020524     C                   dou       *in28 = '1'
043300020524     C     m38ky         reade     mcov38                                 28
0434001310240107  *      If term date is prior to 7/1/2013 => bypass record
043500131024     C                   if        xcandt <> 0 and xcandt < 20130701
043600131024     C                   iter
043700131024     C                   endif
0438001310240107  *
043900020524     C                   if        *in28 = '0'
044000020524     C                   if        xenrldt = enrdat and xcandt = trmdat
044100020524     C                   iter
044200020524     C                   endif
044300020524     C                   if        xenrldt < enrdat
044400020524     C                   z-add     xenrldt       enrdat
044500020524     C                   endif
044600020524     C                   if        trmdat <> 0
0447000205240296 C                   If        xcandt > trmdat or
0448000205240296 C                             xcandt = 0
044900020524     C                   z-add     xcandt        trmdat
045000020524     C                   endif
045100020524     C                   endif
045200020524     C                   endif
045300020524     C                   enddo
0454000205240107  *
045500020524     C                   z-add     enrdat        datymd
045600020517     C                   z-add     ymdyy         r2efyy
045700020517     C                   z-add     ymdmd         r2efmd
0458001310160107  *    Hard coded fix - 10/16/2013
045900131025     C****               if        mcssno = 203368142
046000131025     C*                  eval      trmdat = 0
046100131025     C****               endif
046200020523      *
046300020524     C                   if        trmdat = 0
046400020523     C                   eval      r2term = '000000'
046500020523     C                   else
046600020524     C                   move      trmdat        ISOdate
046700020523     C                   subdur    1:*D          ISOdate
046800020523     C                   move      ISOdate       datymd
046900020524     C                   move      datymd        trmdat
047000020517     C                   z-add     ymdyy         r2trmyy
047100020517     C                   z-add     ymdmd         r2trmmd
047200020523     C                   endif
047300131024      ******?
047400130926     C                   if        r2term = '103113'
047500131024     C****               eval      r2term = '000000'
047600131024     C                   eval      r2term = r2term
047700130926     C                   endif
047800130926      *
047900020517     C                   eval      r2actc = 'A'
048000020718      *
048100020718     C                   if        enrdat > dftstrt
048200020521     C                   eval      r2strt = r2effd
048300020531     C                   eval      r2end = r2strt
048400020531     C                   move      enrdat        wrkdat8
048500020531     C                   eval      wrkda = 01
048600020531     C                   move      wrkdat8       ISOdate
048700020531     C                   adddur    1:*M          ISOdate
048800020531     C                   subdur    1:*D          ISOdate
048900020531     C                   extrct    ISOdate:*D    r2endda
049000020718      *
049100020718     C                   else
049200020718     C                   eval      r2strt = strta
049300020524     C                   if        trmdat > dftend or trmdat = 0
049400020521     C                   eval      r2end = enda
049500020521     C                   else
049600020521     C                   eval      r2end =r2term
049700020521     C                   endif
049800020524     C                   if        trmdat < dftstrt and trmdat <> 0
049900020521     C                   eval      r2strt = r2term
050000020524     C                   eval      r2stda = '01'
050100020521     C                   endif
050200020718     C                   endif
0503000810300111  *        See if rec already exists - update
050400120312     C                   eval      dupmem = 'N'
050500081030     C                   eval      kyid = '2'
050600081030     C                   movel     r2socn        kydata
050700081030     C     dekey         setll     ddelcvgl
050800081030     C                   dou       *in38 = '1'
050900081030     C                   read      ddelcvgl                               38
051000081030     C                   if        *in38 = '0'
051100081030     C                   eval      lecid2 = ldcdata
051200081030     C                   if        r2soc# <> l2soc#
051300081030     C                   leave
051400081030     C                   endif
051500120312      *       Found Matching SSN - confirm matching name and DOB
051600081030     C                   if        r2dob = l2dob and
051700081030     C                             r2fnm = l2fnm and
051800081030     C                             r2lnm = l2lnm
051900120312     C                   eval      dupmem = 'Y'
052000081030      *       Duplicate rec - use most recent
052100081030     C                   if        r2term = '000000' and
052200081030     C                             l2term <> '000000'
052300131024     C                   eval      r2effd = l2effd
052400131024     C                   exsr      delmrecs
052500120312     C                   eval      dupmem = 'N'
052600081030     C                   leave
052700081030     C                   endif
052800081030      *
052900130904     C                   if        l2term = '000000' and
053000130904     C                             r2term <> '000000'
053100131025      *   efffix
053200131025     C                   eval      l2effd = r2effd
053300131025     C                   eval      ldcdata = lecid2
053400131025     C                   update    ddellr
053500131025     C                   eval      dupmem = 'N'
053600131025      *   efffix
053700130904     C                   leave
053800130904     C                   endif
053900130904      *
054000081030     C                   if        r2efyy > l2efyy
054100131024     C                   exsr      delmrecs
054200120312     C                   eval      dupmem = 'N'
054300081030     C                   leave
054400081030     C                   endif
054500081030      *
054600081030     C                   if        r2efyy = l2efyy and
054700081030     C                             r2efmd > l2efmd
054800131024     C                   exsr      delmrecs
054900120312     C                   eval      dupmem = 'N'
055000081030     C                   leave
055100081030     C                   endif
055200081030      *
055300081030     C                   endif
055400081030     C                   endif
055500081030      *                  endif
055600081030     C                   enddo
0557000810300111  *        First 2 rec is always mbr
055800120312     C                   if        dupmem = 'N'
055900081030     C                   eval      rec2a = recid2
056000081030     C                   endif
0561000205170111  *
056200020517     C                   endif
0563000205170111  *
056400020517     C                   endsr
0565000205170107  ********************************************************************************
0566000205170107  *
0567000205170107  *     BLDDEP - Build Record ID = '2' - Dependent data
0568000205170107  *
0569000205170107  ********************************************************************************
057000020517     C     blddep        begsr
057100020517     C     dpkey         chain     depndc                             33
057200020517     C                   if        *in33 = '0'
0573000205170107  *       Build Record ID 2 - Member Data
057400020521     C********           clear                   ddelcvr
057500020521     C********           eval      dcrcid = '2'
057600020517     C                   eval      recid2 = *blanks
057700020517     C                   z-add     ssno          r2socn
057800061024     C                   eval      r2grp# = rgrp#
057900061024     C                   eval      r2subl = rsubl
058000130703     C                   if        drelcd = 'RHU' or drelcd = 'RWI' or
058100130703     C                             drelcd = 'RPA'
058200020517     C                   eval      r2relc = '2'
058300020521     C                   add       1             cntspc
058400020517     C                   else
058500020517     C                   eval      r2relc = '3'
058600020521     C                   add       1             cntkid
058700020517     C                   endif
058800020517     C                   z-add     dbirth        datymd
058900020517     C                   z-add     ymdyy         r2dobyy
059000020517     C                   z-add     ymdmd         r2dobmd
059100020517     C                   eval      r2fnm = dfname
059200020517     C                   eval      r2lnm = dlname
059300020517     C                   z-add     denrdt        datymd
059400020517     C                   z-add     ymdyy         r2efyy
059500020517     C                   z-add     ymdmd         r2efmd
059600020523      *
059700020523     C                   if        ccandt = 0
059800020523     C                   eval      r2term = '000000'
059900020523     C                   else
060000020523     C                   move      ccandt        ISOdate
060100020523     C                   subdur    1:*D          ISOdate
060200020523     C                   move      ISOdate       datymd
060300020524     C                   move      ISOdate       ccandt
060400020523     C                   z-add     ymdyy         r2trmyy
060500020523     C                   z-add     ymdmd         r2trmmd
060600020523     C                   endif
060700131024      ******?
060800131024     C                   if        r2term = '103113'
060900131024     C****               eval      r2term = '000000'
061000131024     C                   eval      r2term = r2term
061100131024     C                   endif
061200130926      *
061300020517     C                   eval      r2actc = 'A'
061400020524      *
061500020718     C                   if        denrdt > dftstrt
061600020521     C                   eval      r2strt = r2effd
061700020531     C                   eval      r2end = r2strt
061800020531     C                   move      denrdt        wrkdat8
061900020531     C                   eval      wrkda = 01
062000020531     C                   move      wrkdat8       ISOdate
062100020531     C                   adddur    1:*M          ISOdate
062200020531     C                   subdur    1:*D          ISOdate
062300020531     C                   extrct    ISOdate:*D    r2endda
062400020718     C                   else
062500020718      *
062600020718     C                   eval      r2strt = strta
062700020521     C                   if        ccandt >= dftend or ccandt = 0
062800020521     C                   eval      r2end = enda
062900020521     C                   else
063000020521     C                   eval      r2end =r2term
063100020521     C                   endif
063200020521     C                   if        ccandt < dftstrt and ccandt <> 0
063300020521     C                   eval      r2strt = r2term
063400020524     C                   eval      r2stda = '01'
063500020521     C                   endif
063600020718     C                   endif
0637000810300111  *        See if rec already exists - update
063800081030     C                   eval      updtd = 'N'
063900081030     C                   eval      kyid = '2'
064000081030     C                   movel     r2socn        kydata
064100081030     C     dekey         setll     ddelcvgl
064200081030     C                   dou       *in38 = '1'
064300081030     C                   read      ddelcvgl                               38
064400081030     C                   if        *in38 = '0'
064500081030     C                   eval      lecid2 = ldcdata
064600081030     C                   if        r2soc# <> l2soc#
064700081030     C                   leave
064800081030     C                   endif
064900081030      *
065000081030     C                   if        r2dob = l2dob and
065100081030     C                             r2fnm = l2fnm and
065200081030     C                             r2lnm = l2lnm
065300081030      *       Duplicate rec - use most recent
065400081030     C                   if        r2term = '000000' and
065500081030     C                             l2term <> '000000'
065600131024     C                   eval      r2effd = l2effd
065700081031     C                   eval      r2rate = l2rate
065800081031     C                   eval      ldcrcid = '2'
065900081031     C                   eval      ldcdata = recid2
066000081030     C                   update    ddellr
066100081030     C                   eval      updtd = 'Y'
066200081030     C                   leave
066300081030     C                   endif
066400131025      *
066500131025     C                   if        l2term = '000000' and
066600131025     C                             r2term <> '000000'
066700131025      *   efffix
066800131025     C                   eval      l2effd = r2effd
066900131025     C                   eval      ldcdata = lecid2
067000131025     C                   update    ddellr
067100131025     C                   eval      updtd = 'Y'
067200131025      *   efffix
067300131025     C                   leave
067400131025     C                   endif
067500131025      *
067600081030      *
067700081030     C                   if        r2efyy > l2efyy
067800081031     C                   eval      r2rate = l2rate
067900081031     C                   eval      ldcrcid = '2'
068000081031     C                   eval      ldcdata = recid2
068100081030     C                   update    ddellr
068200081030     C                   eval      updtd = 'Y'
068300081030     C                   leave
068400081030     C                   endif
068500081030      *
068600081030     C                   if        r2efyy = l2efyy and
068700081030     C                             r2efmd > l2efmd
068800081031     C                   eval      r2rate = l2rate
068900081031     C                   eval      ldcrcid = '2'
069000081031     C                   eval      ldcdata = recid2
069100081030     C                   update    ddellr
069200081030     C                   eval      updtd = 'Y'
069300081030     C                   leave
069400081030     C                   endif
069500081030      *
069600081030     C                   endif
069700081030     C                   endif
069800081030      *                  endif
069900081030     C                   enddo
0700000810300111  *       If updated - leave
070100081030     C                   if        updtd = 'Y'
070200081030     C                   leavesr
070300081030     C                   endif
0704000810300111  *       Store in first open rec2 hold area
070500081030     C                   if        rec2b = *blanks
070600081030     C                   movel     recid2        rec2b
070700081030     C                   else
070800020521     C                   if        rec2c = *blanks
070900020521     C                   movel     recid2        rec2c
071000020521     C                   else
071100020521     C                   if        rec2d = *blanks
071200020521     C                   movel     recid2        rec2d
071300020521     C                   else
071400020521     C                   if        rec2e = *blanks
071500020521     C                   movel     recid2        rec2e
071600020521     C                   else
071700020521     C                   if        rec2f = *blanks
071800020521     C                   movel     recid2        rec2f
071900020521     C                   else
072000020521     C                   if        rec2g = *blanks
072100020521     C                   movel     recid2        rec2g
072200020521     C                   else
072300020521     C                   if        rec2h = *blanks
072400020521     C                   movel     recid2        rec2h
072500020521     C                   else
072600020521     C                   if        rec2i = *blanks
072700020521     C                   movel     recid2        rec2i
072800020521     C                   else
072900020521     C                   if        rec2j = *blanks
073000020521     C                   movel     recid2        rec2j
073100020521     C                   else
073200020521     C                   if        rec2k = *blanks
073300020521     C                   movel     recid2        rec2k
073400020521     C                   else
073500020521     C                   if        rec2l = *blanks
073600020521     C                   movel     recid2        rec2l
073700020521     C                   else
073800020521     C                   if        rec2m = *blanks
073900020521     C                   movel     recid2        rec2m
074000020521     C                   else
074100020521     C                   if        rec2n = *blanks
074200020521     C                   movel     recid2        rec2n
074300020521     C                   else
074400020521     C                   seton                                        H1
074500020521     C                   endif                                                  rec2n = *blanks
074600020521     C                   endif                                                  rec2m = *blanks
074700020521     C                   endif                                                  rec2l = *blanks
074800020521     C                   endif                                                  rec2k = *blanks
074900020521     C                   endif                                                  rec2j = *blanks
075000020521     C                   endif                                                  rec2i = *blanks
075100020521     C                   endif                                                  rec2h = *blanks
075200020521     C                   endif                                                  rec2g = *blanks
075300020521     C                   endif                                                  rec2f = *blanks
075400020521     C                   endif                                                  rec2e = *blanks
075500020521     C                   endif                                                  rec2d = *blanks
075600020521     C                   endif                                                  rec2c = *blanks
075700020521     C                   endif                                                  rec2b = *blanks
0758000205210111  *
075900020521     C*************      eval      dcdata = recid2
076000020521     C*************      add       1             r3cntn
076100020521     C*************      write     ddelcvr
0762000205170111  *
076300020517     C                   endif
0764000205170111  *
076500020517     C                   endsr
0766000205210107  ********************************************************************************
0767000205210107  *
0768000205210107  *     BLDREC2 - Build Record ID = '2' - Dep and Mbr Data
0769000205210107  *
0770000205210107  ********************************************************************************
077100020521     C     bldrec2       begsr
0772000205210107  *       Set rate code based on family make up
077300020521     C                   eval      recid2 = rec2a
077400020521     C                   if        cntspc <> 0
0775000205210107  *           Spouce exists - either family or Mbr and spc
077600020521     C                   if        cntkid = 0
077700020521     C                   eval      r2rate = '2'
077800020521     C                   else
077900020521     C                   eval      r2rate = '3'
078000020521     C                   endif                                                  cntkid = 0
078100020521     C                   else
0782000205210107  *           Spouce Doesn't exist
078300020521     C                   if        cntkid = 0
078400020521     C                   eval      r2rate = '1'
078500020521     C                   else
078600020521     C                   if        cntkid = 1
078700020521     C                   eval      r2rate = '5'
078800020521     C                   else
078900020521     C                   eval      r2rate = '6'
079000020521     C                   endif                                                  cntkid = 1
079100020521     C                   endif                                                  cntkid = 0
079200020521     C                   endif                                                  cntspc <> 0
0793000205210111  *       Save rate code
079400020521     C                   eval      savrat = r2rate
0795000205210111  *     Write member record
079600020521     C                   eval      dcdata = recid2
079700020521     C                   eval      dcrcid = '2'
079800020521     C                   add       1             r3cntn
079900061024     C                   write     ddelcvgr
0800000205210111  *
080100020521     C                   if        rec2b <> *blanks
080200020521     C                   eval      recid2 = rec2b
080300020521     C                   eval      r2rate = savrat
080400020521     C                   eval      dcdata = recid2
080500020521     C                   eval      dcrcid = '2'
080600020521     C                   add       1             r3cntn
080700061024     C                   write     ddelcvgr
080800020521     C                   endif                                                  rec2b <> *blanks
0809000205210111  *
081000020521     C                   if        rec2c <> *blanks
081100020521     C                   eval      recid2 = rec2c
081200020521     C                   eval      r2rate = savrat
081300020521     C                   eval      dcdata = recid2
081400020521     C                   eval      dcrcid = '2'
081500020521     C                   add       1             r3cntn
081600061024     C                   write     ddelcvgr
081700020521     C                   endif                                                  rec2c <> *blanks
0818000205210111  *
081900020521     C                   if        rec2d <> *blanks
082000020521     C                   eval      recid2 = rec2d
082100020521     C                   eval      r2rate = savrat
082200020521     C                   eval      dcdata = recid2
082300020521     C                   eval      dcrcid = '2'
082400020521     C                   add       1             r3cntn
082500061024     C                   write     ddelcvgr
082600020521     C                   endif                                                  rec2d <> *blanks
0827000205210111  *
082800020521     C                   if        rec2e <> *blanks
082900020521     C                   eval      recid2 = rec2e
083000020521     C                   eval      r2rate = savrat
083100020521     C                   eval      dcdata = recid2
083200020521     C                   eval      dcrcid = '2'
083300020521     C                   add       1             r3cntn
083400061024     C                   write     ddelcvgr
083500020521     C                   endif                                                  rec2e <> *blanks
0836000205210111  *
083700020521     C                   if        rec2f <> *blanks
083800020521     C                   eval      recid2 = rec2f
083900020521     C                   eval      r2rate = savrat
084000020521     C                   eval      dcdata = recid2
084100020521     C                   eval      dcrcid = '2'
084200020521     C                   add       1             r3cntn
084300061024     C                   write     ddelcvgr
084400020521     C                   endif                                                  rec2f <> *blanks
0845000205210111  *
084600020521     C                   if        rec2g <> *blanks
084700020521     C                   eval      recid2 = rec2g
084800020521     C                   eval      r2rate = savrat
084900020521     C                   eval      dcdata = recid2
085000020521     C                   eval      dcrcid = '2'
085100020521     C                   add       1             r3cntn
085200061024     C                   write     ddelcvgr
085300020521     C                   endif                                                  rec2g <> *blanks
0854000205210111  *
085500020521     C                   if        rec2h <> *blanks
085600020521     C                   eval      recid2 = rec2h
085700020521     C                   eval      r2rate = savrat
085800020521     C                   eval      dcdata = recid2
085900020521     C                   eval      dcrcid = '2'
086000020521     C                   add       1             r3cntn
086100061024     C                   write     ddelcvgr
086200020521     C                   endif                                                  rec2h <> *blanks
0863000205210111  *
086400020521     C                   if        rec2i <> *blanks
086500020521     C                   eval      recid2 = rec2i
086600020521     C                   eval      r2rate = savrat
086700020521     C                   eval      dcdata = recid2
086800020521     C                   eval      dcrcid = '2'
086900020521     C                   add       1             r3cntn
087000061024     C                   write     ddelcvgr
087100020521     C                   endif                                                  rec2i <> *blanks
0872000205210111  *
087300020521     C                   if        rec2j <> *blanks
087400020521     C                   eval      recid2 = rec2j
087500020521     C                   eval      r2rate = savrat
087600020521     C                   eval      dcdata = recid2
087700020521     C                   eval      dcrcid = '2'
087800020521     C                   add       1             r3cntn
087900061024     C                   write     ddelcvgr
088000020521     C                   endif                                                  rec2j <> *blanks
0881000205210111  *
088200020521     C                   if        rec2k <> *blanks
088300020521     C                   eval      recid2 = rec2k
088400020521     C                   eval      r2rate = savrat
088500020521     C                   eval      dcdata = recid2
088600020521     C                   eval      dcrcid = '2'
088700020521     C                   add       1             r3cntn
088800061024     C                   write     ddelcvgr
088900020521     C                   endif                                                  rec2k <> *blanks
0890000205210111  *
089100020521     C                   if        rec2l <> *blanks
089200020521     C                   eval      recid2 = rec2l
089300020521     C                   eval      r2rate = savrat
089400020521     C                   eval      dcdata = recid2
089500020521     C                   eval      dcrcid = '2'
089600020521     C                   add       1             r3cntn
089700061024     C                   write     ddelcvgr
089800020521     C                   endif                                                  rec2l <> *blanks
0899000205210111  *
090000020521     C                   if        rec2m <> *blanks
090100020521     C                   eval      recid2 = rec2m
090200020521     C                   eval      r2rate = savrat
090300020521     C                   eval      dcdata = recid2
090400020521     C                   eval      dcrcid = '2'
090500020521     C                   add       1             r3cntn
090600061024     C                   write     ddelcvgr
090700020521     C                   endif                                                  rec2m <> *blanks
0908000205210111  *
090900020521     C                   if        rec2n <> *blanks
091000020521     C                   eval      recid2 = rec2n
091100020521     C                   eval      r2rate = savrat
091200020521     C                   eval      dcdata = recid2
091300020521     C                   eval      dcrcid = '2'
091400020521     C                   add       1             r3cntn
091500061024     C                   write     ddelcvgr
091600020521     C                   endif                                                  rec2n <> *blanks
0917000205210111  *
091800020521     C                   endsr
0919000205170107  ********************************************************************************
0920000205170107  *
0921000205170107  *     BLDADR - Build Record ID = '5' and '6' - Address data
0922000205170107  *
0923000205170107  ********************************************************************************
092400020517     C     bldadr        begsr
0925000205170107  *       Build Record ID 5 - Mbr Address 1
092600061024     C                   clear                   ddelcvgr
092700020517     C                   eval      dcrcid = '5'
092800020517     C                   eval      recid5a = *blanks
092900020517     C                   movel     mbssno        r5soc#
093000061024     C                   eval      r5grp# = rgrp#
093100020517     C                   eval      r5add1 = addr1
093200020517     C                   eval      r5add2 = addr2
093300020517     C                   eval      r5segc = '1'
093400020517     C                   eval      r5actc = 'A'
093500020517     C                   eval      dcdata = recid5a
0936000205170111  *
093700020517     C                   add       1             r3cntn
093800061024     C                   write     ddelcvgr
0939000205170111  *
0940000205170107  *       Build Record ID 5 - Mbr Address 2
094100061024     C                   clear                   ddelcvgr
094200020517     C                   eval      dcrcid = '5'
094300020517     C                   eval      recid5b = *blanks
094400020517     C                   movel     mbssno        r5socb
094500061025     C                   eval      r5grpb = rgrp#
094600020517     C                   eval      r5city = city
094700020517     C                   eval      r5st = state
094800020517     C                   z-add     zip           r5zipn
094900020522     C                   if        (area = 111 and phone = 1111111) OR
095000020522     C                             (area = 001 and phone = 0000001)
095100020520     C                   movel     *blanks       r5phon
095200020520     C                   else
095300020520     C                   z-add     area          r5ac
095400020517     C                   z-add     phone         r5phnn
095500020520     C                   endif
095600020517     C                   eval      r5segb = '2'
095700020517     C                   eval      r5actb = 'A'
095800020517     C                   eval      dcdata = recid5b
0959000205170111  *
096000020517     C                   add       1             r3cntn
096100061024     C                   write     ddelcvgr
0962000205170111  *
096300020517     C                   endsr
0964000205170107  ********************************************************************************
0965000205170107  *
0966000205170107  *     BLDRC3 - Build Record ID = '3' - Trailer
0967000205170107  *
0968000205170107  ********************************************************************************
096900020517     C     bldrc3        begsr
0970000205170107  *       Build Record ID 3
097100061024     C                   clear                   ddelcvgr
097200020517     C                   eval      dcrcid = '3'
097300020517     C                   eval      dcdata = recid3
0974000205170111  *
097500061024     C                   write     ddelcvgr
0976000205170111  *
097700020517     C                   endsr
0978001203120107  ********************************************************************************
0979001203120107  *
0980001310240107  *     DELMRECS - Delete all current mbr records for a SSN
0981001203120107  *
0982001203120107  ********************************************************************************
098300131024     C     delmrecs      begsr
0984001203120107  *       Delete rec ID 2
098500120312     C                   eval      kyid = '2'
098600120312     C                   movel     r2socn        kydata
098700120312     C     dekey         setll     ddelcvgl
098800120312     C                   dou       *in38 = '1'
098900120312     C                   read      ddelcvgl                               38
099000120312     C                   eval      lecid2 = ldcdata
099100131024     C                   if        *in38 = '0' and r2socn = l2socn and
099200131024     C                             r2dob = l2dob and r2fnm = l2fnm
099300120312     C                   delete    ddellr
099400120312     C                   else
099500120312     C                   leave
099600120312     C                   endif
099700120312     C                   enddo
0998001203120107  *       Delete rec ID 5
099900120312     C                   eval      kyid = '5'
100000120312     C     dekey         setll     ddelcvgl
100100120312     C                   dou       *in38 = '1'
100200120312     C                   read      ddelcvgl                               38
100300120312     C                   eval      lecid2 = ldcdata
100400120312     C                   if        *in38 = '0' and r2socn = l2socn
100500120312     C                   delete    ddellr
100600120312     C                   else
100700120312     C                   leave
100800120312     C                   endif
100900120312     C                   enddo
1010001203120111  *
101100120312     C                   endsr
