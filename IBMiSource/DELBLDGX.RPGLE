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
001600020402      *                                                                *
0017009102150018 F******************************************************************
0018000610240020 Fplnmstn1  IF   E           K DISK
0019000610240020 Fgrat25    IF   E           K DISK
0020000610240020 Fmcovl1    IF   E           K DISK
0021000205240020 Fmcov38    IF   E           K DISK    RENAME(MCOVR:MC38R)
0022000205240020 F                                     PREFIX(X)
0023000205170020 Fmember    IF   E           K DISK
0024000205170020 Fdepndc    IF   E           K DISK
0025000205170020 Fdcov      IF   E           K DISK
0026000810300020 Fddelcvgl  UF   E           K DISK    RENAME(DDELCVGR:DDELLR)
0027000810300020 F                                     PREFIX(L)
0028000610240020 Fddelcvgp  O    E             DISK
0029000204020029  *
0030000204260029  *   Format Input Records
0031009102150250 D                 DS
0032000205020251 D  recid1                 1     74
0033000204260251 D   r1plcd                1      2
0034001112210251 D   r1grp#                3      6
0035001112210251 D   r1grpn                7     36
0036001112210251 D   r1cntc               37     65
0037001112210251 D   r1cnt#               66     75
0038001112210250 D                 DS
0039001112210251 D  recid2                 1     74
0040001112210251 D   r2soc#                1      9
0041000204260251 D    r2socn               1      9S 0
0042000204260251 D   r2grp#               10     13
0043000204260251 D   r2subl               14     17
0044000204260251 D   r2relc               18     18
0045000204260251 D   r2dob                19     24
0046000205020251 D    r2dobmd             19     22  0
0047000205020251 D    r2dobyy             23     24  0
0048000204260251 D   r2rate               25     25
0049000204260251 D   r2fnm                26     33
0050000205080251 D     r2fnm3             26     28
0051000204260251 D   r2lnm                34     49
0052000204260251 D   r2effd               50     55
0053000205020251 D    r2efmd              50     53  0
0054000205020251 D    r2efyy              54     55  0
0055000204260251 D   r2term               56     61
0056000205020251 D    r2trmmd             56     59  0
0057000205020251 D    r2trmyy             60     61  0
0058000204260251 D   r2actc               62     62
0059000204260251 D   r2strt               63     68
0060000205240251 D    r2stmd              63     66  0
0061000205240251 D    r2stda              65     66
0062000205210251 D    r2styy              67     68  0
0063000204260251 D   r2end                69     74
0064000205210251 D    r2endmd             69     72  0
0065000205310251 D    r2endda             71     72  0
0066000205210251 D    r2endyy             73     74  0
0067000204260250 D                 DS
0068000205020251 D  recid3                 1     74
0069000204260251 D   r3cnt                 1      8
0070000205170251 D   r3cntn                1      8  0 INZ(0)
0071000204260250 D                 DS
0072000205020251 D  recid5a                1     74
0073000204260251 D   r5soc#                1      9
0074000204260251 D   r5fil1               10     10
0075000204260251 D   r5grp#               11     14
0076000204260251 D   r5add1               15     38
0077000204260251 D   r5add2               39     62
0078000204260251 D   r5fil2               63     72
0079000204260251 D   r5segc               73     73
0080000204260251 D   r5actc               74     74
0081000204260250 D                 DS
0082000205020251 D  recid5b                1     74
0083000204260251 D   r5socb                1      9
0084000204260251 D   r5fl1b               10     10
0085000204260251 D   r5grpb               11     14
0086000204260251 D   r5city               15     28
0087000204260251 D   r5st                 29     31
0088000204260251 D   r5zip                32     40
0089000205060251 D    r5zip5              32     36
0090000205060251 D    r5zip4              37     40
0091000205020251 D   r5zipn               32     40  0
0092000204260251 D   r5fl2b               41     42
0093000204260251 D   r5phon               43     52
0094000205020251 D    r5ac                43     45  0
0095000205020251 D    r5phnn              46     52  0
0096000204260251 D   r5fl3b               53     72
0097000204260251 D   r5segb               73     73
0098000204260251 D   r5actb               74     74
0099000205210029  *   Save Mbr and Dep input recs
0100000205210250 D                 DS
0101000205210251 D  rec2hld                1   1036    INZ(*BLANKS)
0102000205210251 D  rec2a                  1     74
0103000205210251 D  rec2b                 75    148
0104000205210251 D  rec2c                149    222
0105000205210251 D  rec2d                223    296
0106000205210251 D  rec2e                297    370
0107000205210251 D  rec2f                371    444
0108000205210251 D  rec2g                445    518
0109000205210251 D  rec2h                519    592
0110000205210251 D  rec2i                593    666
0111000205210251 D  rec2j                667    740
0112000205210251 D  rec2k                741    814
0113000205210251 D  rec2l                815    888
0114000205210251 D  rec2m                889    962
0115000205210251 D  rec2n                963   1036
0116000205210029  *
0117000810300250 D                 DS
0118000810300251 D  lecid2                 1     74
0119000810300251 D   l2soc#                1      9
0120000810300251 D    l2socn               1      9S 0
0121000810300251 D   l2grp#               10     13
0122000810300251 D   l2subl               14     17
0123000810300251 D   l2relc               18     18
0124000810300251 D   l2dob                19     24
0125000810300251 D    l2dobmd             19     22  0
0126000810300251 D    l2dobyy             23     24  0
0127000810300251 D   l2rate               25     25
0128000810300251 D   l2fnm                26     33
0129000810300251 D     l2fnm3             26     28
0130000810300251 D   l2lnm                34     49
0131000810300251 D   l2effd               50     55
0132000810300251 D    l2efmd              50     53  0
0133000810300251 D    l2efyy              54     55  0
0134000810300251 D   l2term               56     61
0135000810300251 D    l2trmmd             56     59  0
0136000810300251 D    l2trmyy             60     61  0
0137000810300251 D   l2actc               62     62
0138000810300251 D   l2strt               63     68
0139000810300251 D    l2stmd              63     66  0
0140000810300251 D    l2stda              65     66
0141000810300251 D    l2styy              67     68  0
0142000810300251 D   l2end                69     74
0143000810300251 D    l2endmd             69     72  0
0144000810300251 D    l2endda             71     72  0
0145000810300251 D    l2endyy             73     74  0
0146000810300029  *
0147000204260250 D                 DS
0148000610240251 D  group#                 1     15
0149000610240251 D    grp14                1      4
0150000610240251 D    grp58                5      8
0151001310160251 D    grp90                9     10
0152000810300029  *
0153000810300250 D                 DS
0154001309260251 D  raty           S              1
0155001309260251 D  kyid           S              1
0156000810300251 D  kydata         S             74    INZ(*BLANKS)
0157001203120251 D  dupmem         S              1
0158001203120251 D  dupem          S              1
0159000810300251 D  updtd          S              1
0160000610240029  *
0161000610240250 D                 DS
0162000610240251 D  datymd                 1      8  0
0163000610240251 D    ymdcc                1      2  0
0164000610240251 D    ymdyy                3      4  0
0165000205070251 D    ymdmd                5      8  0
0166000205170250 D                 DS
0167000205170251 D  mktrst                        3  0 INZ(419)
0168000205170251 D  mksub                         3  0 INZ(1)
0169000205170251 D  mkplan                        4    INZ('7000')
0170000205210251 D  cntspc                        2  0 INZ(0)
0171000205210251 D  cntkid                        2  0 INZ(0)
0172000205210251 D  savrat                        1    INZ(' ')
0173000205210251 D  todaa                         2  0
0174000610240251 D  kcarr                              LIKE(PCARR)
0175000610240251 D  rgrp#                              LIKE(r2grp#)
0176000610240251 D  rsubl                              LIKE(r2subl)
0177000205210250 D                 DS
0178000205210251 D  ISOdate        S               D
0179000205210251 D  ISOnum         S              8  0
0180000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0181000205240251 D  enrdat         S              8  0
0182000205240251 D  trmdat         S              8  0
0183000205210250 D                 DS
0184000205310251 D  wrkdat8                1      8  0
0185000205310251 D   wrkda                 7      8  0
0186000205310250 D                 DS
0187000205310251 D  dftstrt                1      8  0
0188000205210251 D    strtda               7      8  0
0189000205210251 D  dftend                 9     16  0
0190000205210251 D    endda               15     16  0
0191000205210251 D  mdystrt               17     22  0
0192000205210251 D   strta                17     22
0193000205210251 D  mdyend                23     28  0
0194000205210251 D   enda                 23     28
019500020517      *
019600061024     C     grkey         klist
019700061024     C                   kfld                    pltrst
019800061024     C                   kfld                    plsub#
019900061024     C                   kfld                    plplan
020000061024      *
020100061024     C     mckey         klist
020200061024     C                   kfld                    mktrst
020300061024     C                   kfld                    mksub
020400061024     C                   kfld                    mkplan
020500020517      *
020600090917     C     xrkey         klist
020700090917     C                   kfld                    mctrst
020800090917     C                   kfld                    mcsub#
020900090917     C                   kfld                    acc#
021000090917      *
021100020517     C     dpkey         klist
021200090917     C                   kfld                    ssno
021300090917     C                   kfld                    dseq#
021400090917      *
021500020524     C     m38ky         klist
021600090917     C                   kfld                    mcssno
021700090917     C                   kfld                    mdseq#
021800090917     C                   kfld                    mctrst
021900020524     C                   kfld                    mcsub#
022000020524     C                   kfld                    mcplan
022100081030      *
022200081030     C     dekey         klist
022300081030     C                   kfld                    kyid
022400081030     C                   kfld                    kydata
022500020517      *
022600020503      ******************************************************************************
022700020517      *      MainLine
0228000205211304  *         Calculate default action dates
022900020521     C                   move      UDATE         ISOdate
023000020521     C                   move      ISOdate       ISOnum
023100020521     C                   extrct    ISOdate:*D    todaa
023200020521     C                   if        todaa > 25
023300020521     C                   adddur    10:*D         ISOdate
023400020521     C                   endif
023500020521     C                   move      ISOdate       dftstrt
023600020521     C                   z-add     01            strtda
023700020521     C                   move      dftstrt       ISOdate
023800020521     C                   eval      MDYdate = ISOdate
023900020521     C                   move      MDYdate       mdystrt
024000020521     C                   move      dftstrt       ISOdate
024100020521     C                   adddur    1:*M          ISOdate
024200020521     C                   subdur    1:*D          ISOdate
024300020521     C                   move      ISOdate       dftend
024400020521     C                   eval      MDYdate = ISOdate
024500020521     C                   move      MDYdate       mdyend
0246000205211304  *         Build RecId 1
024700061024     C                   clear                   ddelcvgr
024800020521     C                   eval      dcrcid = '1'
024900020521     C                   eval      recid1 = *blanks
025000061024     C                   eval      r1plcd = 'PA'
025100061024     C                   eval      r1grp# = '7414'
025200061024     C                   eval      r1grpn = 'GBS        '
025300061024     C                   eval      r1cntc = 'Carol Fabiszak'
025400061024     C                   eval      r1cnt# = '4108325141'
025500020517     C                   eval      dcdata = recid1
025600020517     C                   add       1             r3cntn
025700061024     C                   write     ddelcvgr
0258000204260111  *
0259001012280107  *      Loop thru PLNMST looking for Carrier = 'DEA', 'DEM' or 'DE1'
026000101228     C                   eval      kcarr = 'DEA'
026100061024     C     kcarr         setll     plnmstn1
026200061024     C                   dou       *in23 = '1'
026300101228     C                   read      plnmstn1                               23
026400101228     C                   if        *in23 = '1' or PCARR > 'DE1'
026500101228     C                   leave
026600101228     C                   endif
026700101228     C                   if        PCARR = 'DEA' or pcarr = 'DEM' or
026800101228     C                             PCARR = 'DE1'
0269000612120111  *
0270000612120107  *   **** Ignore trst = 590 and sub = 008
0271001008260107  *   ****   Removed this 8/26/2010 per C. Fab
0272000610240107  *         Get Grp# and subloc
027300100826     C******             if        pltrst = 590 and
027400100826     C******                       plsub# = 8
027500100826     C******             iter
027600101228     C******             endif
0277001310010107  *        Debug shit
027800131001     C                   if        pltrst = 597 and
027900131001     C                             plsub# = 1
028000131001     C                   eval      plplan = plplan
028100131001     C                   endif
0282000612120107  *   **** Ignore trst = 590 and sub = 008
028300130926     C                   eval      raty = 'N'
0284001309180107  *      Loop thru MCOVL1 to locate all mbrs
028500130926     C     grkey         chain     grat25                             24
0286001309260107  *      Loop thru MCOVL1 to locate all mbrs
028700130918     C     grkey         setll     grat25
028800130918     C                   dou       *in24 = '1'
028900130918     C     grkey         reade     grat25                                 24
029000130918     C                   if        *in24 = '0' and frmdat < 20131101
029100061024     C                   eval      rgrp# = grp14
029200061024     C                   eval      rsubl = grp58
029300130926     C                   eval      raty = 'Y'
029400131016     C                   if        grp90 <> '  '
029500131016     C                   eval      grp90 = grp90
029600061024     C                   endif
029700131016     C                   leave
029800131016     C                   endif
029900130918     C                   enddo
0300000902100107  *   **** Bypass termed grp# 9690 prt Delta 02/2009
0301001201180107  *** Also Bypass termed grp# 7129 per Delta 01/2012 - Chris Gibbons
0302001206070107  *** Also Bypass termed grp# 0997 per Delta 06/2012 - Chris Gibbons
0303001301020107  *** Also Bypass termed grp# 6408 per Delta 06/2012 - Chris Gibbons
0304001309030107  *** Also Bypass termed grp# 1554 per Delta 09/2013 - Chris Gibbons
030500120118     C                   if        rgrp# = '9690' or
030600120607     C                             rgrp# = '0997' or
030700130102     C                             rgrp# = '6408' or
030800130903     C                             rgrp# = '1554' or
030900130926     C                             rgrp# = '7129' or
031000130926     C                             raty = 'N'
031100090210     C                   iter
031200090210     C                   endif
0313001203060107  *      Debug shit
031400120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
031500120306     C                   eval      mcssno = mcssno
031600120306     C                   endif
0317000610240111  *
0318000610240107  *      Loop thru MCOVL1 to locate all mbrs
031900061024     C     grkey         setll     mcovl1
032000061024     C                   dou       *in21 = '1'
032100061024     C     grkey         reade     mcovl1                                 21
032200061024     C                   if        *in21 = '0'
0323000205240107  *      If enroll date and term date are equal => bypass record
032400020524     C                   if        enrldt = candt
032500020524     C                   iter
032600020524     C                   endif
0327000810310107  *      Debug shit
032800131010     C                   if        mcssno = 203368142
032900081031     C                   eval      mcssno = mcssno
033000081031     C                   endif
0331000205240107  *      Check to see if Member has already been reported on
033200081030     C**** mcssno        chain     ddelwkgp                           29
033300081030     C*****              if        *in29 = '0'
033400081030      ****************************************
033500081030     C*****************  iter
033600081030      ****************************************
033700081030     C******             endif
0338000205240107  *      Mark Member as already been reported on
033900081030     C*****              clear                   ddelwkgr
034000081030     C******             z-add     mcssno        dwssn
034100081030     C*****              write     ddelwkgr
0342000205240107  *
034300020524     C                   exsr      bldmbr
0344001203120107  *     If member was duplicate - skip
034500120312     C                   if        dupmem = 'Y'
034600120312     C                   iter
034700120312     C                   endif
0348000610250107  *      Loop thru DCOV to locate all Delta dependents
034900020517     C     mcssno        setll     dcov
035000020517     C                   dou       *in22 = '1'
035100020517     C     mcssno        reade     dcov                                   22
035200020517     C                   if        *in22 = '0'
0353000206260107  *      If enroll date and term date are equal => bypass record
035400020524     C                   if        denrdt = ccandt
035500020524     C                   iter
035600020524     C                   endif
035700061025     C                   if        mcssno = ssno and dvplan = plplan
035800020517     C                   exsr      blddep
035900020517     C                   endif
036000020517     C                   else
036100020517     C                   leave
036200020517     C                   endif
036300020517     C                   enddo
0364000810300107  *      Create rec2 recs for mbr and dep data
036500081030     C                   exsr      bldrec2
0366000205210107  *      Create members address records
036700020521     C                   exsr      bldadr
036800020517     C                   endif
036900020517     C                   enddo
037000061024     C                   endif
037100061024     C                   enddo
037200020517     C                   exsr      bldrc3
037300020517     C                   movel     '1'           *inlr
037400020517     C                   return
0375000204020107  ********************************************************************************
0376000204020107  *
0377000205170107  *     BLDMBR - Build Record ID = '2' - Member data
0378000204020107  *
0379000204020107  ********************************************************************************
038000020517     C     bldmbr        begsr
038100020521     C                   eval      rec2hld = *blanks
038200020521     C                   eval      cntspc = 0
038300020521     C                   eval      cntkid = 0
038400020517     C     mcssno        chain     member                             31
038500020517     C                   if        *in31 = '0'
0386000205170107  *       Build Record ID 2 - Member Data
038700020521     C*********          clear                   ddelcvr
038800020521     C*********          eval      dcrcid = '2'
038900020517     C                   eval      recid2 = *blanks
039000020517     C                   z-add     mcssno        r2socn
039100020517     C                   eval      r2relc = '1'
039200061024     C                   eval      r2grp# = rgrp#
039300061024     C                   eval      r2subl = rsubl
039400020517     C                   z-add     birth         datymd
039500020517     C                   z-add     ymdyy         r2dobyy
039600020517     C                   z-add     ymdmd         r2dobmd
039700020517     C                   eval      r2fnm = mfname
039800020517     C                   eval      r2lnm = mlname
039900020524     C                   z-add     enrldt        enrdat
040000020524     C                   z-add     candt         trmdat
0401000810310107  *     debug shit
040200131016     C                   if        mcssno = 203368142
040300020524     C                   eval      mcssno = mcssno
040400020524     C                   endif
0405001009130107  *
0406000205240107  *      Loop thru MCOV38 to locate all coverages for Mbr for TK - Delta
040700020524     C     m38ky         setll     mcov38
040800020524     C                   dou       *in28 = '1'
040900020524     C     m38ky         reade     mcov38                                 28
041000020524     C                   if        *in28 = '0'
041100020524     C                   if        xenrldt = enrdat and xcandt = trmdat
041200020524     C                   iter
041300020524     C                   endif
041400020524     C                   if        xenrldt < enrdat
041500020524     C                   z-add     xenrldt       enrdat
041600020524     C                   endif
041700020524     C                   if        trmdat <> 0
0418000205240296 C                   If        xcandt > trmdat or
0419000205240296 C                             xcandt = 0
042000020524     C                   z-add     xcandt        trmdat
042100020524     C                   endif
042200020524     C                   endif
042300020524     C                   endif
042400020524     C                   enddo
0425000205240107  *
042600020524     C                   z-add     enrdat        datymd
042700020517     C                   z-add     ymdyy         r2efyy
042800020517     C                   z-add     ymdmd         r2efmd
0429001310160107  *    Hard coded fix - 10/16/2013
043000131016     C                   if        mcssno = 203368142
043100131016     C                   eval      trmdat = 0
043200131016     C                   endif
043300020523      *
043400020524     C                   if        trmdat = 0
043500020523     C                   eval      r2term = '000000'
043600020523     C                   else
043700020524     C                   move      trmdat        ISOdate
043800020523     C                   subdur    1:*D          ISOdate
043900020523     C                   move      ISOdate       datymd
044000020524     C                   move      datymd        trmdat
044100020517     C                   z-add     ymdyy         r2trmyy
044200020517     C                   z-add     ymdmd         r2trmmd
044300020523     C                   endif
044400020523      *
044500130926     C                   if        r2term = '103113'
044600130926     C                   eval      r2term = '000000'
044700130926     C                   endif
044800130926      *
044900020517     C                   eval      r2actc = 'A'
045000020718      *
045100020718     C                   if        enrdat > dftstrt
045200020521     C                   eval      r2strt = r2effd
045300020531     C                   eval      r2end = r2strt
045400020531     C                   move      enrdat        wrkdat8
045500020531     C                   eval      wrkda = 01
045600020531     C                   move      wrkdat8       ISOdate
045700020531     C                   adddur    1:*M          ISOdate
045800020531     C                   subdur    1:*D          ISOdate
045900020531     C                   extrct    ISOdate:*D    r2endda
046000020718      *
046100020718     C                   else
046200020718     C                   eval      r2strt = strta
046300020524     C                   if        trmdat > dftend or trmdat = 0
046400020521     C                   eval      r2end = enda
046500020521     C                   else
046600020521     C                   eval      r2end =r2term
046700020521     C                   endif
046800020524     C                   if        trmdat < dftstrt and trmdat <> 0
046900020521     C                   eval      r2strt = r2term
047000020524     C                   eval      r2stda = '01'
047100020521     C                   endif
047200020718     C                   endif
0473000810300111  *        See if rec already exists - update
047400120312     C                   eval      dupmem = 'N'
047500081030     C                   eval      kyid = '2'
047600081030     C                   movel     r2socn        kydata
047700081030     C     dekey         setll     ddelcvgl
047800081030     C                   dou       *in38 = '1'
047900081030     C                   read      ddelcvgl                               38
048000081030     C                   if        *in38 = '0'
048100081030     C                   eval      lecid2 = ldcdata
048200081030     C                   if        r2soc# <> l2soc#
048300081030     C                   leave
048400081030     C                   endif
048500120312      *       Found Matching SSN - confirm matching name and DOB
048600081030     C                   if        r2dob = l2dob and
048700081030     C                             r2fnm = l2fnm and
048800081030     C                             r2lnm = l2lnm
048900120312     C                   eval      dupmem = 'Y'
049000081030      *       Duplicate rec - use most recent
049100081030     C                   if        r2term = '000000' and
049200081030     C                             l2term <> '000000'
049300120312     C                   exsr      delrecs
049400120312     C                   eval      dupmem = 'N'
049500081030     C                   leave
049600081030     C                   endif
049700081030      *
049800130904     C                   if        l2term = '000000' and
049900130904     C                             r2term <> '000000'
050000130904     C                   leave
050100130904     C                   endif
050200130904      *
050300081030     C                   if        r2efyy > l2efyy
050400120312     C                   exsr      delrecs
050500120312     C                   eval      dupmem = 'N'
050600081030     C                   leave
050700081030     C                   endif
050800081030      *
050900081030     C                   if        r2efyy = l2efyy and
051000081030     C                             r2efmd > l2efmd
051100120312     C                   exsr      delrecs
051200120312     C                   eval      dupmem = 'N'
051300081030     C                   leave
051400081030     C                   endif
051500081030      *
051600081030     C                   endif
051700081030     C                   endif
051800081030      *                  endif
051900081030     C                   enddo
0520000810300111  *        First 2 rec is always mbr
052100120312     C                   if        dupmem = 'N'
052200081030     C                   eval      rec2a = recid2
052300081030     C                   endif
0524000205170111  *
052500020517     C                   endif
0526000205170111  *
052700020517     C                   endsr
0528000205170107  ********************************************************************************
0529000205170107  *
0530000205170107  *     BLDDEP - Build Record ID = '2' - Dependent data
0531000205170107  *
0532000205170107  ********************************************************************************
053300020517     C     blddep        begsr
053400020517     C     dpkey         chain     depndc                             33
053500020517     C                   if        *in33 = '0'
0536000205170107  *       Build Record ID 2 - Member Data
053700020521     C********           clear                   ddelcvr
053800020521     C********           eval      dcrcid = '2'
053900020517     C                   eval      recid2 = *blanks
054000020517     C                   z-add     ssno          r2socn
054100061024     C                   eval      r2grp# = rgrp#
054200061024     C                   eval      r2subl = rsubl
054300130703     C                   if        drelcd = 'RHU' or drelcd = 'RWI' or
054400130703     C                             drelcd = 'RPA'
054500020517     C                   eval      r2relc = '2'
054600020521     C                   add       1             cntspc
054700020517     C                   else
054800020517     C                   eval      r2relc = '3'
054900020521     C                   add       1             cntkid
055000020517     C                   endif
055100020517     C                   z-add     dbirth        datymd
055200020517     C                   z-add     ymdyy         r2dobyy
055300020517     C                   z-add     ymdmd         r2dobmd
055400020517     C                   eval      r2fnm = dfname
055500020517     C                   eval      r2lnm = dlname
055600020517     C                   z-add     denrdt        datymd
055700020517     C                   z-add     ymdyy         r2efyy
055800020517     C                   z-add     ymdmd         r2efmd
055900020523      *
056000020523     C                   if        ccandt = 0
056100020523     C                   eval      r2term = '000000'
056200020523     C                   else
056300020523     C                   move      ccandt        ISOdate
056400020523     C                   subdur    1:*D          ISOdate
056500020523     C                   move      ISOdate       datymd
056600020524     C                   move      ISOdate       ccandt
056700020523     C                   z-add     ymdyy         r2trmyy
056800020523     C                   z-add     ymdmd         r2trmmd
056900020523     C                   endif
057000020523      *
057100130926      *
057200130926     C                   if        r2term = '103113'
057300130926     C                   eval      r2term = '000000'
057400130926     C                   endif
057500130926      *
057600020517     C                   eval      r2actc = 'A'
057700020524      *
057800020718     C                   if        denrdt > dftstrt
057900020521     C                   eval      r2strt = r2effd
058000020531     C                   eval      r2end = r2strt
058100020531     C                   move      denrdt        wrkdat8
058200020531     C                   eval      wrkda = 01
058300020531     C                   move      wrkdat8       ISOdate
058400020531     C                   adddur    1:*M          ISOdate
058500020531     C                   subdur    1:*D          ISOdate
058600020531     C                   extrct    ISOdate:*D    r2endda
058700020718     C                   else
058800020718      *
058900020718     C                   eval      r2strt = strta
059000020521     C                   if        ccandt >= dftend or ccandt = 0
059100020521     C                   eval      r2end = enda
059200020521     C                   else
059300020521     C                   eval      r2end =r2term
059400020521     C                   endif
059500020521     C                   if        ccandt < dftstrt and ccandt <> 0
059600020521     C                   eval      r2strt = r2term
059700020524     C                   eval      r2stda = '01'
059800020521     C                   endif
059900020718     C                   endif
0600000810300111  *        See if rec already exists - update
060100081030     C                   eval      updtd = 'N'
060200081030     C                   eval      kyid = '2'
060300081030     C                   movel     r2socn        kydata
060400081030     C     dekey         setll     ddelcvgl
060500081030     C                   dou       *in38 = '1'
060600081030     C                   read      ddelcvgl                               38
060700081030     C                   if        *in38 = '0'
060800081030     C                   eval      lecid2 = ldcdata
060900081030     C                   if        r2soc# <> l2soc#
061000081030     C                   leave
061100081030     C                   endif
061200081030      *
061300081030     C                   if        r2dob = l2dob and
061400081030     C                             r2fnm = l2fnm and
061500081030     C                             r2lnm = l2lnm
061600081030      *       Duplicate rec - use most recent
061700081030     C                   if        r2term = '000000' and
061800081030     C                             l2term <> '000000'
061900081031     C                   eval      r2rate = l2rate
062000081031     C                   eval      ldcrcid = '2'
062100081031     C                   eval      ldcdata = recid2
062200081030     C                   update    ddellr
062300081030     C                   eval      updtd = 'Y'
062400081030     C                   leave
062500081030     C                   endif
062600081030      *
062700081030     C                   if        r2efyy > l2efyy
062800081031     C                   eval      r2rate = l2rate
062900081031     C                   eval      ldcrcid = '2'
063000081031     C                   eval      ldcdata = recid2
063100081030     C                   update    ddellr
063200081030     C                   eval      updtd = 'Y'
063300081030     C                   leave
063400081030     C                   endif
063500081030      *
063600081030     C                   if        r2efyy = l2efyy and
063700081030     C                             r2efmd > l2efmd
063800081031     C                   eval      r2rate = l2rate
063900081031     C                   eval      ldcrcid = '2'
064000081031     C                   eval      ldcdata = recid2
064100081030     C                   update    ddellr
064200081030     C                   eval      updtd = 'Y'
064300081030     C                   leave
064400081030     C                   endif
064500081030      *
064600081030     C                   endif
064700081030     C                   endif
064800081030      *                  endif
064900081030     C                   enddo
0650000810300111  *       If updated - leave
065100081030     C                   if        updtd = 'Y'
065200081030     C                   leavesr
065300081030     C                   endif
0654000810300111  *       Store in first open rec2 hold area
065500081030     C                   if        rec2b = *blanks
065600081030     C                   movel     recid2        rec2b
065700081030     C                   else
065800020521     C                   if        rec2c = *blanks
065900020521     C                   movel     recid2        rec2c
066000020521     C                   else
066100020521     C                   if        rec2d = *blanks
066200020521     C                   movel     recid2        rec2d
066300020521     C                   else
066400020521     C                   if        rec2e = *blanks
066500020521     C                   movel     recid2        rec2e
066600020521     C                   else
066700020521     C                   if        rec2f = *blanks
066800020521     C                   movel     recid2        rec2f
066900020521     C                   else
067000020521     C                   if        rec2g = *blanks
067100020521     C                   movel     recid2        rec2g
067200020521     C                   else
067300020521     C                   if        rec2h = *blanks
067400020521     C                   movel     recid2        rec2h
067500020521     C                   else
067600020521     C                   if        rec2i = *blanks
067700020521     C                   movel     recid2        rec2i
067800020521     C                   else
067900020521     C                   if        rec2j = *blanks
068000020521     C                   movel     recid2        rec2j
068100020521     C                   else
068200020521     C                   if        rec2k = *blanks
068300020521     C                   movel     recid2        rec2k
068400020521     C                   else
068500020521     C                   if        rec2l = *blanks
068600020521     C                   movel     recid2        rec2l
068700020521     C                   else
068800020521     C                   if        rec2m = *blanks
068900020521     C                   movel     recid2        rec2m
069000020521     C                   else
069100020521     C                   if        rec2n = *blanks
069200020521     C                   movel     recid2        rec2n
069300020521     C                   else
069400020521     C                   seton                                        H1
069500020521     C                   endif                                                  rec2n = *blanks
069600020521     C                   endif                                                  rec2m = *blanks
069700020521     C                   endif                                                  rec2l = *blanks
069800020521     C                   endif                                                  rec2k = *blanks
069900020521     C                   endif                                                  rec2j = *blanks
070000020521     C                   endif                                                  rec2i = *blanks
070100020521     C                   endif                                                  rec2h = *blanks
070200020521     C                   endif                                                  rec2g = *blanks
070300020521     C                   endif                                                  rec2f = *blanks
070400020521     C                   endif                                                  rec2e = *blanks
070500020521     C                   endif                                                  rec2d = *blanks
070600020521     C                   endif                                                  rec2c = *blanks
070700020521     C                   endif                                                  rec2b = *blanks
0708000205210111  *
070900020521     C*************      eval      dcdata = recid2
071000020521     C*************      add       1             r3cntn
071100020521     C*************      write     ddelcvr
0712000205170111  *
071300020517     C                   endif
0714000205170111  *
071500020517     C                   endsr
0716000205210107  ********************************************************************************
0717000205210107  *
0718000205210107  *     BLDREC2 - Build Record ID = '2' - Dep and Mbr Data
0719000205210107  *
0720000205210107  ********************************************************************************
072100020521     C     bldrec2       begsr
0722000205210107  *       Set rate code based on family make up
072300020521     C                   eval      recid2 = rec2a
072400020521     C                   if        cntspc <> 0
0725000205210107  *           Spouce exists - either family or Mbr and spc
072600020521     C                   if        cntkid = 0
072700020521     C                   eval      r2rate = '2'
072800020521     C                   else
072900020521     C                   eval      r2rate = '3'
073000020521     C                   endif                                                  cntkid = 0
073100020521     C                   else
0732000205210107  *           Spouce Doesn't exist
073300020521     C                   if        cntkid = 0
073400020521     C                   eval      r2rate = '1'
073500020521     C                   else
073600020521     C                   if        cntkid = 1
073700020521     C                   eval      r2rate = '5'
073800020521     C                   else
073900020521     C                   eval      r2rate = '6'
074000020521     C                   endif                                                  cntkid = 1
074100020521     C                   endif                                                  cntkid = 0
074200020521     C                   endif                                                  cntspc <> 0
0743000205210111  *       Save rate code
074400020521     C                   eval      savrat = r2rate
0745000205210111  *     Write member record
074600020521     C                   eval      dcdata = recid2
074700020521     C                   eval      dcrcid = '2'
074800020521     C                   add       1             r3cntn
074900061024     C                   write     ddelcvgr
0750000205210111  *
075100020521     C                   if        rec2b <> *blanks
075200020521     C                   eval      recid2 = rec2b
075300020521     C                   eval      r2rate = savrat
075400020521     C                   eval      dcdata = recid2
075500020521     C                   eval      dcrcid = '2'
075600020521     C                   add       1             r3cntn
075700061024     C                   write     ddelcvgr
075800020521     C                   endif                                                  rec2b <> *blanks
0759000205210111  *
076000020521     C                   if        rec2c <> *blanks
076100020521     C                   eval      recid2 = rec2c
076200020521     C                   eval      r2rate = savrat
076300020521     C                   eval      dcdata = recid2
076400020521     C                   eval      dcrcid = '2'
076500020521     C                   add       1             r3cntn
076600061024     C                   write     ddelcvgr
076700020521     C                   endif                                                  rec2c <> *blanks
0768000205210111  *
076900020521     C                   if        rec2d <> *blanks
077000020521     C                   eval      recid2 = rec2d
077100020521     C                   eval      r2rate = savrat
077200020521     C                   eval      dcdata = recid2
077300020521     C                   eval      dcrcid = '2'
077400020521     C                   add       1             r3cntn
077500061024     C                   write     ddelcvgr
077600020521     C                   endif                                                  rec2d <> *blanks
0777000205210111  *
077800020521     C                   if        rec2e <> *blanks
077900020521     C                   eval      recid2 = rec2e
078000020521     C                   eval      r2rate = savrat
078100020521     C                   eval      dcdata = recid2
078200020521     C                   eval      dcrcid = '2'
078300020521     C                   add       1             r3cntn
078400061024     C                   write     ddelcvgr
078500020521     C                   endif                                                  rec2e <> *blanks
0786000205210111  *
078700020521     C                   if        rec2f <> *blanks
078800020521     C                   eval      recid2 = rec2f
078900020521     C                   eval      r2rate = savrat
079000020521     C                   eval      dcdata = recid2
079100020521     C                   eval      dcrcid = '2'
079200020521     C                   add       1             r3cntn
079300061024     C                   write     ddelcvgr
079400020521     C                   endif                                                  rec2f <> *blanks
0795000205210111  *
079600020521     C                   if        rec2g <> *blanks
079700020521     C                   eval      recid2 = rec2g
079800020521     C                   eval      r2rate = savrat
079900020521     C                   eval      dcdata = recid2
080000020521     C                   eval      dcrcid = '2'
080100020521     C                   add       1             r3cntn
080200061024     C                   write     ddelcvgr
080300020521     C                   endif                                                  rec2g <> *blanks
0804000205210111  *
080500020521     C                   if        rec2h <> *blanks
080600020521     C                   eval      recid2 = rec2h
080700020521     C                   eval      r2rate = savrat
080800020521     C                   eval      dcdata = recid2
080900020521     C                   eval      dcrcid = '2'
081000020521     C                   add       1             r3cntn
081100061024     C                   write     ddelcvgr
081200020521     C                   endif                                                  rec2h <> *blanks
0813000205210111  *
081400020521     C                   if        rec2i <> *blanks
081500020521     C                   eval      recid2 = rec2i
081600020521     C                   eval      r2rate = savrat
081700020521     C                   eval      dcdata = recid2
081800020521     C                   eval      dcrcid = '2'
081900020521     C                   add       1             r3cntn
082000061024     C                   write     ddelcvgr
082100020521     C                   endif                                                  rec2i <> *blanks
0822000205210111  *
082300020521     C                   if        rec2j <> *blanks
082400020521     C                   eval      recid2 = rec2j
082500020521     C                   eval      r2rate = savrat
082600020521     C                   eval      dcdata = recid2
082700020521     C                   eval      dcrcid = '2'
082800020521     C                   add       1             r3cntn
082900061024     C                   write     ddelcvgr
083000020521     C                   endif                                                  rec2j <> *blanks
0831000205210111  *
083200020521     C                   if        rec2k <> *blanks
083300020521     C                   eval      recid2 = rec2k
083400020521     C                   eval      r2rate = savrat
083500020521     C                   eval      dcdata = recid2
083600020521     C                   eval      dcrcid = '2'
083700020521     C                   add       1             r3cntn
083800061024     C                   write     ddelcvgr
083900020521     C                   endif                                                  rec2k <> *blanks
0840000205210111  *
084100020521     C                   if        rec2l <> *blanks
084200020521     C                   eval      recid2 = rec2l
084300020521     C                   eval      r2rate = savrat
084400020521     C                   eval      dcdata = recid2
084500020521     C                   eval      dcrcid = '2'
084600020521     C                   add       1             r3cntn
084700061024     C                   write     ddelcvgr
084800020521     C                   endif                                                  rec2l <> *blanks
0849000205210111  *
085000020521     C                   if        rec2m <> *blanks
085100020521     C                   eval      recid2 = rec2m
085200020521     C                   eval      r2rate = savrat
085300020521     C                   eval      dcdata = recid2
085400020521     C                   eval      dcrcid = '2'
085500020521     C                   add       1             r3cntn
085600061024     C                   write     ddelcvgr
085700020521     C                   endif                                                  rec2m <> *blanks
0858000205210111  *
085900020521     C                   if        rec2n <> *blanks
086000020521     C                   eval      recid2 = rec2n
086100020521     C                   eval      r2rate = savrat
086200020521     C                   eval      dcdata = recid2
086300020521     C                   eval      dcrcid = '2'
086400020521     C                   add       1             r3cntn
086500061024     C                   write     ddelcvgr
086600020521     C                   endif                                                  rec2n <> *blanks
0867000205210111  *
086800020521     C                   endsr
0869000205170107  ********************************************************************************
0870000205170107  *
0871000205170107  *     BLDADR - Build Record ID = '5' and '6' - Address data
0872000205170107  *
0873000205170107  ********************************************************************************
087400020517     C     bldadr        begsr
0875000205170107  *       Build Record ID 5 - Mbr Address 1
087600061024     C                   clear                   ddelcvgr
087700020517     C                   eval      dcrcid = '5'
087800020517     C                   eval      recid5a = *blanks
087900020517     C                   movel     mbssno        r5soc#
088000061024     C                   eval      r5grp# = rgrp#
088100020517     C                   eval      r5add1 = addr1
088200020517     C                   eval      r5add2 = addr2
088300020517     C                   eval      r5segc = '1'
088400020517     C                   eval      r5actc = 'A'
088500020517     C                   eval      dcdata = recid5a
0886000205170111  *
088700020517     C                   add       1             r3cntn
088800061024     C                   write     ddelcvgr
0889000205170111  *
0890000205170107  *       Build Record ID 5 - Mbr Address 2
089100061024     C                   clear                   ddelcvgr
089200020517     C                   eval      dcrcid = '5'
089300020517     C                   eval      recid5b = *blanks
089400020517     C                   movel     mbssno        r5socb
089500061025     C                   eval      r5grpb = rgrp#
089600020517     C                   eval      r5city = city
089700020517     C                   eval      r5st = state
089800020517     C                   z-add     zip           r5zipn
089900020522     C                   if        (area = 111 and phone = 1111111) OR
090000020522     C                             (area = 001 and phone = 0000001)
090100020520     C                   movel     *blanks       r5phon
090200020520     C                   else
090300020520     C                   z-add     area          r5ac
090400020517     C                   z-add     phone         r5phnn
090500020520     C                   endif
090600020517     C                   eval      r5segb = '2'
090700020517     C                   eval      r5actb = 'A'
090800020517     C                   eval      dcdata = recid5b
0909000205170111  *
091000020517     C                   add       1             r3cntn
091100061024     C                   write     ddelcvgr
0912000205170111  *
091300020517     C                   endsr
0914000205170107  ********************************************************************************
0915000205170107  *
0916000205170107  *     BLDRC3 - Build Record ID = '3' - Trailer
0917000205170107  *
0918000205170107  ********************************************************************************
091900020517     C     bldrc3        begsr
0920000205170107  *       Build Record ID 3
092100061024     C                   clear                   ddelcvgr
092200020517     C                   eval      dcrcid = '3'
092300020517     C                   eval      dcdata = recid3
0924000205170111  *
092500061024     C                   write     ddelcvgr
0926000205170111  *
092700020517     C                   endsr
0928001203120107  ********************************************************************************
0929001203120107  *
0930001203120107  *     DELRECS - Delete all current records for a SSN
0931001203120107  *
0932001203120107  ********************************************************************************
093300120312     C     delrecs       begsr
0934001203120107  *       Delete rec ID 2
093500120312     C                   eval      kyid = '2'
093600120312     C                   movel     r2socn        kydata
093700120312     C     dekey         setll     ddelcvgl
093800120312     C                   dou       *in38 = '1'
093900120312     C                   read      ddelcvgl                               38
094000120312     C                   eval      lecid2 = ldcdata
094100120312     C                   if        *in38 = '0' and r2socn = l2socn
094200120312     C                   delete    ddellr
094300120312     C                   else
094400120312     C                   leave
094500120312     C                   endif
094600120312     C                   enddo
0947001203120107  *       Delete rec ID 5
094800120312     C                   eval      kyid = '5'
094900120312     C     dekey         setll     ddelcvgl
095000120312     C                   dou       *in38 = '1'
095100120312     C                   read      ddelcvgl                               38
095200120312     C                   eval      lecid2 = ldcdata
095300120312     C                   if        *in38 = '0' and r2socn = l2socn
095400120312     C                   delete    ddellr
095500120312     C                   else
095600120312     C                   leave
095700120312     C                   endif
095800120312     C                   enddo
0959001203120111  *
096000120312     C                   endsr
