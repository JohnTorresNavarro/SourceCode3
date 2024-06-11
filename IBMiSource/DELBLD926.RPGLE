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
0151000810300029  *
0152000810300250 D                 DS
0153000810300251 D  kyid           S              1
0154000810300251 D  kydata         S             74    INZ(*BLANKS)
0155001203120251 D  dupmem         S              1
0156001203120251 D  dupem          S              1
0157000810300251 D  updtd          S              1
0158000610240029  *
0159000610240250 D                 DS
0160000610240251 D  datymd                 1      8  0
0161000610240251 D    ymdcc                1      2  0
0162000610240251 D    ymdyy                3      4  0
0163000205070251 D    ymdmd                5      8  0
0164000205170250 D                 DS
0165000205170251 D  mktrst                        3  0 INZ(419)
0166000205170251 D  mksub                         3  0 INZ(1)
0167000205170251 D  mkplan                        4    INZ('7000')
0168000205210251 D  cntspc                        2  0 INZ(0)
0169000205210251 D  cntkid                        2  0 INZ(0)
0170000205210251 D  savrat                        1    INZ(' ')
0171000205210251 D  todaa                         2  0
0172000610240251 D  kcarr                              LIKE(PCARR)
0173000610240251 D  rgrp#                              LIKE(r2grp#)
0174000610240251 D  rsubl                              LIKE(r2subl)
0175000205210250 D                 DS
0176000205210251 D  ISOdate        S               D
0177000205210251 D  ISOnum         S              8  0
0178000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0179000205240251 D  enrdat         S              8  0
0180000205240251 D  trmdat         S              8  0
0181000205210250 D                 DS
0182000205310251 D  wrkdat8                1      8  0
0183000205310251 D   wrkda                 7      8  0
0184000205310250 D                 DS
0185000205310251 D  dftstrt                1      8  0
0186000205210251 D    strtda               7      8  0
0187000205210251 D  dftend                 9     16  0
0188000205210251 D    endda               15     16  0
0189000205210251 D  mdystrt               17     22  0
0190000205210251 D   strta                17     22
0191000205210251 D  mdyend                23     28  0
0192000205210251 D   enda                 23     28
019300020517      *
019400061024     C     grkey         klist
019500061024     C                   kfld                    pltrst
019600061024     C                   kfld                    plsub#
019700061024     C                   kfld                    plplan
019800061024      *
019900061024     C     mckey         klist
020000061024     C                   kfld                    mktrst
020100061024     C                   kfld                    mksub
020200061024     C                   kfld                    mkplan
020300020517      *
020400090917     C     xrkey         klist
020500090917     C                   kfld                    mctrst
020600090917     C                   kfld                    mcsub#
020700090917     C                   kfld                    acc#
020800090917      *
020900020517     C     dpkey         klist
021000090917     C                   kfld                    ssno
021100090917     C                   kfld                    dseq#
021200090917      *
021300020524     C     m38ky         klist
021400090917     C                   kfld                    mcssno
021500090917     C                   kfld                    mdseq#
021600090917     C                   kfld                    mctrst
021700020524     C                   kfld                    mcsub#
021800020524     C                   kfld                    mcplan
021900081030      *
022000081030     C     dekey         klist
022100081030     C                   kfld                    kyid
022200081030     C                   kfld                    kydata
022300020517      *
022400020503      ******************************************************************************
022500020517      *      MainLine
0226000205211304  *         Calculate default action dates
022700020521     C                   move      UDATE         ISOdate
022800020521     C                   move      ISOdate       ISOnum
022900020521     C                   extrct    ISOdate:*D    todaa
023000020521     C                   if        todaa > 25
023100020521     C                   adddur    10:*D         ISOdate
023200020521     C                   endif
023300020521     C                   move      ISOdate       dftstrt
023400020521     C                   z-add     01            strtda
023500020521     C                   move      dftstrt       ISOdate
023600020521     C                   eval      MDYdate = ISOdate
023700020521     C                   move      MDYdate       mdystrt
023800020521     C                   move      dftstrt       ISOdate
023900020521     C                   adddur    1:*M          ISOdate
024000020521     C                   subdur    1:*D          ISOdate
024100020521     C                   move      ISOdate       dftend
024200020521     C                   eval      MDYdate = ISOdate
024300020521     C                   move      MDYdate       mdyend
0244000205211304  *         Build RecId 1
024500061024     C                   clear                   ddelcvgr
024600020521     C                   eval      dcrcid = '1'
024700020521     C                   eval      recid1 = *blanks
024800061024     C                   eval      r1plcd = 'PA'
024900061024     C                   eval      r1grp# = '7414'
025000061024     C                   eval      r1grpn = 'GBS        '
025100061024     C                   eval      r1cntc = 'Carol Fabiszak'
025200061024     C                   eval      r1cnt# = '4108325141'
025300020517     C                   eval      dcdata = recid1
025400020517     C                   add       1             r3cntn
025500061024     C                   write     ddelcvgr
0256000204260111  *
0257001012280107  *      Loop thru PLNMST looking for Carrier = 'DEA', 'DEM' or 'DE1'
025800101228     C                   eval      kcarr = 'DEA'
025900061024     C     kcarr         setll     plnmstn1
026000061024     C                   dou       *in23 = '1'
026100101228     C                   read      plnmstn1                               23
026200101228     C                   if        *in23 = '1' or PCARR > 'DE1'
026300101228     C                   leave
026400101228     C                   endif
026500101228     C                   if        PCARR = 'DEA' or pcarr = 'DEM' or
026600101228     C                             PCARR = 'DE1'
0267000612120111  *
0268000612120107  *   **** Ignore trst = 590 and sub = 008
0269001008260107  *   ****   Removed this 8/26/2010 per C. Fab
0270000610240107  *         Get Grp# and subloc
027100100826     C******             if        pltrst = 590 and
027200100826     C******                       plsub# = 8
027300100826     C******             iter
027400101228     C******             endif
0275000612120107  *   **** Ignore trst = 590 and sub = 008
027600061024     C     grkey         chain     grat25                             24
0277001309180107  *      Loop thru MCOVL1 to locate all mbrs
027800130918     C     grkey         setll     grat25
027900130918     C                   dou       *in24 = '1'
028000130918     C     grkey         reade     grat25                                 24
028100130918     C                   if        *in24 = '0' and frmdat < 20131101
028200061024     C                   eval      rgrp# = grp14
028300061024     C                   eval      rsubl = grp58
028400130918     C                   leave
028500061024     C                   endif
028600130918     C                   enddo
0287000902100107  *   **** Bypass termed grp# 9690 prt Delta 02/2009
0288001201180107  *** Also Bypass termed grp# 7129 per Delta 01/2012 - Chris Gibbons
0289001206070107  *** Also Bypass termed grp# 0997 per Delta 06/2012 - Chris Gibbons
0290001301020107  *** Also Bypass termed grp# 6408 per Delta 06/2012 - Chris Gibbons
0291001309030107  *** Also Bypass termed grp# 1554 per Delta 09/2013 - Chris Gibbons
029200120118     C                   if        rgrp# = '9690' or
029300120607     C                             rgrp# = '0997' or
029400130102     C                             rgrp# = '6408' or
029500130903     C                             rgrp# = '1554' or
029600120118     C                             rgrp# = '7129'
029700090210     C                   iter
029800090210     C                   endif
0299001203060107  *      Debug shit
030000120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
030100120306     C                   eval      mcssno = mcssno
030200120306     C                   endif
0303000610240111  *
0304000610240107  *      Loop thru MCOVL1 to locate all mbrs
030500061024     C     grkey         setll     mcovl1
030600061024     C                   dou       *in21 = '1'
030700061024     C     grkey         reade     mcovl1                                 21
030800061024     C                   if        *in21 = '0'
0309000205240107  *      If enroll date and term date are equal => bypass record
031000020524     C                   if        enrldt = candt
031100020524     C                   iter
031200020524     C                   endif
0313000810310107  *      Debug shit
031400130904     C                   if        mcssno = 217066125
031500081031     C                   eval      mcssno = mcssno
031600081031     C                   endif
0317000205240107  *      Check to see if Member has already been reported on
031800081030     C**** mcssno        chain     ddelwkgp                           29
031900081030     C*****              if        *in29 = '0'
032000081030      ****************************************
032100081030     C*****************  iter
032200081030      ****************************************
032300081030     C******             endif
0324000205240107  *      Mark Member as already been reported on
032500081030     C*****              clear                   ddelwkgr
032600081030     C******             z-add     mcssno        dwssn
032700081030     C*****              write     ddelwkgr
0328000205240107  *
032900020524     C                   exsr      bldmbr
0330001203120107  *     If member was duplicate - skip
033100120312     C                   if        dupmem = 'Y'
033200120312     C                   iter
033300120312     C                   endif
0334000610250107  *      Loop thru DCOV to locate all Delta dependents
033500020517     C     mcssno        setll     dcov
033600020517     C                   dou       *in22 = '1'
033700020517     C     mcssno        reade     dcov                                   22
033800020517     C                   if        *in22 = '0'
0339000206260107  *      If enroll date and term date are equal => bypass record
034000020524     C                   if        denrdt = ccandt
034100020524     C                   iter
034200020524     C                   endif
034300061025     C                   if        mcssno = ssno and dvplan = plplan
034400020517     C                   exsr      blddep
034500020517     C                   endif
034600020517     C                   else
034700020517     C                   leave
034800020517     C                   endif
034900020517     C                   enddo
0350000810300107  *      Create rec2 recs for mbr and dep data
035100081030     C                   exsr      bldrec2
0352000205210107  *      Create members address records
035300020521     C                   exsr      bldadr
035400020517     C                   endif
035500020517     C                   enddo
035600061024     C                   endif
035700061024     C                   enddo
035800020517     C                   exsr      bldrc3
035900020517     C                   movel     '1'           *inlr
036000020517     C                   return
0361000204020107  ********************************************************************************
0362000204020107  *
0363000205170107  *     BLDMBR - Build Record ID = '2' - Member data
0364000204020107  *
0365000204020107  ********************************************************************************
036600020517     C     bldmbr        begsr
036700020521     C                   eval      rec2hld = *blanks
036800020521     C                   eval      cntspc = 0
036900020521     C                   eval      cntkid = 0
037000020517     C     mcssno        chain     member                             31
037100020517     C                   if        *in31 = '0'
0372000205170107  *       Build Record ID 2 - Member Data
037300020521     C*********          clear                   ddelcvr
037400020521     C*********          eval      dcrcid = '2'
037500020517     C                   eval      recid2 = *blanks
037600020517     C                   z-add     mcssno        r2socn
037700020517     C                   eval      r2relc = '1'
037800061024     C                   eval      r2grp# = rgrp#
037900061024     C                   eval      r2subl = rsubl
038000020517     C                   z-add     birth         datymd
038100020517     C                   z-add     ymdyy         r2dobyy
038200020517     C                   z-add     ymdmd         r2dobmd
038300020517     C                   eval      r2fnm = mfname
038400020517     C                   eval      r2lnm = mlname
038500020524     C                   z-add     enrldt        enrdat
038600020524     C                   z-add     candt         trmdat
0387000810310107  *     debug shit
038800120306     C                   if        mcssno = 218867574
038900020524     C                   eval      mcssno = mcssno
039000020524     C                   endif
0391001009130107  *
0392000205240107  *      Loop thru MCOV38 to locate all coverages for Mbr for TK - Delta
039300020524     C     m38ky         setll     mcov38
039400020524     C                   dou       *in28 = '1'
039500020524     C     m38ky         reade     mcov38                                 28
039600020524     C                   if        *in28 = '0'
039700020524     C                   if        xenrldt = enrdat and xcandt = trmdat
039800020524     C                   iter
039900020524     C                   endif
040000020524     C                   if        xenrldt < enrdat
040100020524     C                   z-add     xenrldt       enrdat
040200020524     C                   endif
040300020524     C                   if        trmdat <> 0
0404000205240296 C                   If        xcandt > trmdat or
0405000205240296 C                             xcandt = 0
040600020524     C                   z-add     xcandt        trmdat
040700020524     C                   endif
040800020524     C                   endif
040900020524     C                   endif
041000020524     C                   enddo
0411000205240107  *
041200020524     C                   z-add     enrdat        datymd
041300020517     C                   z-add     ymdyy         r2efyy
041400020517     C                   z-add     ymdmd         r2efmd
041500020523      *
041600020524     C                   if        trmdat = 0
041700020523     C                   eval      r2term = '000000'
041800020523     C                   else
041900020524     C                   move      trmdat        ISOdate
042000020523     C                   subdur    1:*D          ISOdate
042100020523     C                   move      ISOdate       datymd
042200020524     C                   move      datymd        trmdat
042300020517     C                   z-add     ymdyy         r2trmyy
042400020517     C                   z-add     ymdmd         r2trmmd
042500020523     C                   endif
042600020523      *
042700020517     C                   eval      r2actc = 'A'
042800020718      *
042900020718     C                   if        enrdat > dftstrt
043000020521     C                   eval      r2strt = r2effd
043100020531     C                   eval      r2end = r2strt
043200020531     C                   move      enrdat        wrkdat8
043300020531     C                   eval      wrkda = 01
043400020531     C                   move      wrkdat8       ISOdate
043500020531     C                   adddur    1:*M          ISOdate
043600020531     C                   subdur    1:*D          ISOdate
043700020531     C                   extrct    ISOdate:*D    r2endda
043800020718      *
043900020718     C                   else
044000020718     C                   eval      r2strt = strta
044100020524     C                   if        trmdat > dftend or trmdat = 0
044200020521     C                   eval      r2end = enda
044300020521     C                   else
044400020521     C                   eval      r2end =r2term
044500020521     C                   endif
044600020524     C                   if        trmdat < dftstrt and trmdat <> 0
044700020521     C                   eval      r2strt = r2term
044800020524     C                   eval      r2stda = '01'
044900020521     C                   endif
045000020718     C                   endif
0451000810300111  *        See if rec already exists - update
045200120312     C                   eval      dupmem = 'N'
045300081030     C                   eval      kyid = '2'
045400081030     C                   movel     r2socn        kydata
045500081030     C     dekey         setll     ddelcvgl
045600081030     C                   dou       *in38 = '1'
045700081030     C                   read      ddelcvgl                               38
045800081030     C                   if        *in38 = '0'
045900081030     C                   eval      lecid2 = ldcdata
046000081030     C                   if        r2soc# <> l2soc#
046100081030     C                   leave
046200081030     C                   endif
046300120312      *       Found Matching SSN - confirm matching name and DOB
046400081030     C                   if        r2dob = l2dob and
046500081030     C                             r2fnm = l2fnm and
046600081030     C                             r2lnm = l2lnm
046700120312     C                   eval      dupmem = 'Y'
046800081030      *       Duplicate rec - use most recent
046900081030     C                   if        r2term = '000000' and
047000081030     C                             l2term <> '000000'
047100120312     C                   exsr      delrecs
047200120312     C                   eval      dupmem = 'N'
047300081030     C                   leave
047400081030     C                   endif
047500081030      *
047600130904     C                   if        l2term = '000000' and
047700130904     C                             r2term <> '000000'
047800130904     C                   leave
047900130904     C                   endif
048000130904      *
048100081030     C                   if        r2efyy > l2efyy
048200120312     C                   exsr      delrecs
048300120312     C                   eval      dupmem = 'N'
048400081030     C                   leave
048500081030     C                   endif
048600081030      *
048700081030     C                   if        r2efyy = l2efyy and
048800081030     C                             r2efmd > l2efmd
048900120312     C                   exsr      delrecs
049000120312     C                   eval      dupmem = 'N'
049100081030     C                   leave
049200081030     C                   endif
049300081030      *
049400081030     C                   endif
049500081030     C                   endif
049600081030      *                  endif
049700081030     C                   enddo
0498000810300111  *        First 2 rec is always mbr
049900120312     C                   if        dupmem = 'N'
050000081030     C                   eval      rec2a = recid2
050100081030     C                   endif
0502000205170111  *
050300020517     C                   endif
0504000205170111  *
050500020517     C                   endsr
0506000205170107  ********************************************************************************
0507000205170107  *
0508000205170107  *     BLDDEP - Build Record ID = '2' - Dependent data
0509000205170107  *
0510000205170107  ********************************************************************************
051100020517     C     blddep        begsr
051200020517     C     dpkey         chain     depndc                             33
051300020517     C                   if        *in33 = '0'
0514000205170107  *       Build Record ID 2 - Member Data
051500020521     C********           clear                   ddelcvr
051600020521     C********           eval      dcrcid = '2'
051700020517     C                   eval      recid2 = *blanks
051800020517     C                   z-add     ssno          r2socn
051900061024     C                   eval      r2grp# = rgrp#
052000061024     C                   eval      r2subl = rsubl
052100130703     C                   if        drelcd = 'RHU' or drelcd = 'RWI' or
052200130703     C                             drelcd = 'RPA'
052300020517     C                   eval      r2relc = '2'
052400020521     C                   add       1             cntspc
052500020517     C                   else
052600020517     C                   eval      r2relc = '3'
052700020521     C                   add       1             cntkid
052800020517     C                   endif
052900020517     C                   z-add     dbirth        datymd
053000020517     C                   z-add     ymdyy         r2dobyy
053100020517     C                   z-add     ymdmd         r2dobmd
053200020517     C                   eval      r2fnm = dfname
053300020517     C                   eval      r2lnm = dlname
053400020517     C                   z-add     denrdt        datymd
053500020517     C                   z-add     ymdyy         r2efyy
053600020517     C                   z-add     ymdmd         r2efmd
053700020523      *
053800020523     C                   if        ccandt = 0
053900020523     C                   eval      r2term = '000000'
054000020523     C                   else
054100020523     C                   move      ccandt        ISOdate
054200020523     C                   subdur    1:*D          ISOdate
054300020523     C                   move      ISOdate       datymd
054400020524     C                   move      ISOdate       ccandt
054500020523     C                   z-add     ymdyy         r2trmyy
054600020523     C                   z-add     ymdmd         r2trmmd
054700020523     C                   endif
054800020523      *
054900020517     C                   eval      r2actc = 'A'
055000020524      *
055100020718     C                   if        denrdt > dftstrt
055200020521     C                   eval      r2strt = r2effd
055300020531     C                   eval      r2end = r2strt
055400020531     C                   move      denrdt        wrkdat8
055500020531     C                   eval      wrkda = 01
055600020531     C                   move      wrkdat8       ISOdate
055700020531     C                   adddur    1:*M          ISOdate
055800020531     C                   subdur    1:*D          ISOdate
055900020531     C                   extrct    ISOdate:*D    r2endda
056000020718     C                   else
056100020718      *
056200020718     C                   eval      r2strt = strta
056300020521     C                   if        ccandt >= dftend or ccandt = 0
056400020521     C                   eval      r2end = enda
056500020521     C                   else
056600020521     C                   eval      r2end =r2term
056700020521     C                   endif
056800020521     C                   if        ccandt < dftstrt and ccandt <> 0
056900020521     C                   eval      r2strt = r2term
057000020524     C                   eval      r2stda = '01'
057100020521     C                   endif
057200020718     C                   endif
0573000810300111  *        See if rec already exists - update
057400081030     C                   eval      updtd = 'N'
057500081030     C                   eval      kyid = '2'
057600081030     C                   movel     r2socn        kydata
057700081030     C     dekey         setll     ddelcvgl
057800081030     C                   dou       *in38 = '1'
057900081030     C                   read      ddelcvgl                               38
058000081030     C                   if        *in38 = '0'
058100081030     C                   eval      lecid2 = ldcdata
058200081030     C                   if        r2soc# <> l2soc#
058300081030     C                   leave
058400081030     C                   endif
058500081030      *
058600081030     C                   if        r2dob = l2dob and
058700081030     C                             r2fnm = l2fnm and
058800081030     C                             r2lnm = l2lnm
058900081030      *       Duplicate rec - use most recent
059000081030     C                   if        r2term = '000000' and
059100081030     C                             l2term <> '000000'
059200081031     C                   eval      r2rate = l2rate
059300081031     C                   eval      ldcrcid = '2'
059400081031     C                   eval      ldcdata = recid2
059500081030     C                   update    ddellr
059600081030     C                   eval      updtd = 'Y'
059700081030     C                   leave
059800081030     C                   endif
059900081030      *
060000081030     C                   if        r2efyy > l2efyy
060100081031     C                   eval      r2rate = l2rate
060200081031     C                   eval      ldcrcid = '2'
060300081031     C                   eval      ldcdata = recid2
060400081030     C                   update    ddellr
060500081030     C                   eval      updtd = 'Y'
060600081030     C                   leave
060700081030     C                   endif
060800081030      *
060900081030     C                   if        r2efyy = l2efyy and
061000081030     C                             r2efmd > l2efmd
061100081031     C                   eval      r2rate = l2rate
061200081031     C                   eval      ldcrcid = '2'
061300081031     C                   eval      ldcdata = recid2
061400081030     C                   update    ddellr
061500081030     C                   eval      updtd = 'Y'
061600081030     C                   leave
061700081030     C                   endif
061800081030      *
061900081030     C                   endif
062000081030     C                   endif
062100081030      *                  endif
062200081030     C                   enddo
0623000810300111  *       If updated - leave
062400081030     C                   if        updtd = 'Y'
062500081030     C                   leavesr
062600081030     C                   endif
0627000810300111  *       Store in first open rec2 hold area
062800081030     C                   if        rec2b = *blanks
062900081030     C                   movel     recid2        rec2b
063000081030     C                   else
063100020521     C                   if        rec2c = *blanks
063200020521     C                   movel     recid2        rec2c
063300020521     C                   else
063400020521     C                   if        rec2d = *blanks
063500020521     C                   movel     recid2        rec2d
063600020521     C                   else
063700020521     C                   if        rec2e = *blanks
063800020521     C                   movel     recid2        rec2e
063900020521     C                   else
064000020521     C                   if        rec2f = *blanks
064100020521     C                   movel     recid2        rec2f
064200020521     C                   else
064300020521     C                   if        rec2g = *blanks
064400020521     C                   movel     recid2        rec2g
064500020521     C                   else
064600020521     C                   if        rec2h = *blanks
064700020521     C                   movel     recid2        rec2h
064800020521     C                   else
064900020521     C                   if        rec2i = *blanks
065000020521     C                   movel     recid2        rec2i
065100020521     C                   else
065200020521     C                   if        rec2j = *blanks
065300020521     C                   movel     recid2        rec2j
065400020521     C                   else
065500020521     C                   if        rec2k = *blanks
065600020521     C                   movel     recid2        rec2k
065700020521     C                   else
065800020521     C                   if        rec2l = *blanks
065900020521     C                   movel     recid2        rec2l
066000020521     C                   else
066100020521     C                   if        rec2m = *blanks
066200020521     C                   movel     recid2        rec2m
066300020521     C                   else
066400020521     C                   if        rec2n = *blanks
066500020521     C                   movel     recid2        rec2n
066600020521     C                   else
066700020521     C                   seton                                        H1
066800020521     C                   endif                                                  rec2n = *blanks
066900020521     C                   endif                                                  rec2m = *blanks
067000020521     C                   endif                                                  rec2l = *blanks
067100020521     C                   endif                                                  rec2k = *blanks
067200020521     C                   endif                                                  rec2j = *blanks
067300020521     C                   endif                                                  rec2i = *blanks
067400020521     C                   endif                                                  rec2h = *blanks
067500020521     C                   endif                                                  rec2g = *blanks
067600020521     C                   endif                                                  rec2f = *blanks
067700020521     C                   endif                                                  rec2e = *blanks
067800020521     C                   endif                                                  rec2d = *blanks
067900020521     C                   endif                                                  rec2c = *blanks
068000020521     C                   endif                                                  rec2b = *blanks
0681000205210111  *
068200020521     C*************      eval      dcdata = recid2
068300020521     C*************      add       1             r3cntn
068400020521     C*************      write     ddelcvr
0685000205170111  *
068600020517     C                   endif
0687000205170111  *
068800020517     C                   endsr
0689000205210107  ********************************************************************************
0690000205210107  *
0691000205210107  *     BLDREC2 - Build Record ID = '2' - Dep and Mbr Data
0692000205210107  *
0693000205210107  ********************************************************************************
069400020521     C     bldrec2       begsr
0695000205210107  *       Set rate code based on family make up
069600020521     C                   eval      recid2 = rec2a
069700020521     C                   if        cntspc <> 0
0698000205210107  *           Spouce exists - either family or Mbr and spc
069900020521     C                   if        cntkid = 0
070000020521     C                   eval      r2rate = '2'
070100020521     C                   else
070200020521     C                   eval      r2rate = '3'
070300020521     C                   endif                                                  cntkid = 0
070400020521     C                   else
0705000205210107  *           Spouce Doesn't exist
070600020521     C                   if        cntkid = 0
070700020521     C                   eval      r2rate = '1'
070800020521     C                   else
070900020521     C                   if        cntkid = 1
071000020521     C                   eval      r2rate = '5'
071100020521     C                   else
071200020521     C                   eval      r2rate = '6'
071300020521     C                   endif                                                  cntkid = 1
071400020521     C                   endif                                                  cntkid = 0
071500020521     C                   endif                                                  cntspc <> 0
0716000205210111  *       Save rate code
071700020521     C                   eval      savrat = r2rate
0718000205210111  *     Write member record
071900020521     C                   eval      dcdata = recid2
072000020521     C                   eval      dcrcid = '2'
072100020521     C                   add       1             r3cntn
072200061024     C                   write     ddelcvgr
0723000205210111  *
072400020521     C                   if        rec2b <> *blanks
072500020521     C                   eval      recid2 = rec2b
072600020521     C                   eval      r2rate = savrat
072700020521     C                   eval      dcdata = recid2
072800020521     C                   eval      dcrcid = '2'
072900020521     C                   add       1             r3cntn
073000061024     C                   write     ddelcvgr
073100020521     C                   endif                                                  rec2b <> *blanks
0732000205210111  *
073300020521     C                   if        rec2c <> *blanks
073400020521     C                   eval      recid2 = rec2c
073500020521     C                   eval      r2rate = savrat
073600020521     C                   eval      dcdata = recid2
073700020521     C                   eval      dcrcid = '2'
073800020521     C                   add       1             r3cntn
073900061024     C                   write     ddelcvgr
074000020521     C                   endif                                                  rec2c <> *blanks
0741000205210111  *
074200020521     C                   if        rec2d <> *blanks
074300020521     C                   eval      recid2 = rec2d
074400020521     C                   eval      r2rate = savrat
074500020521     C                   eval      dcdata = recid2
074600020521     C                   eval      dcrcid = '2'
074700020521     C                   add       1             r3cntn
074800061024     C                   write     ddelcvgr
074900020521     C                   endif                                                  rec2d <> *blanks
0750000205210111  *
075100020521     C                   if        rec2e <> *blanks
075200020521     C                   eval      recid2 = rec2e
075300020521     C                   eval      r2rate = savrat
075400020521     C                   eval      dcdata = recid2
075500020521     C                   eval      dcrcid = '2'
075600020521     C                   add       1             r3cntn
075700061024     C                   write     ddelcvgr
075800020521     C                   endif                                                  rec2e <> *blanks
0759000205210111  *
076000020521     C                   if        rec2f <> *blanks
076100020521     C                   eval      recid2 = rec2f
076200020521     C                   eval      r2rate = savrat
076300020521     C                   eval      dcdata = recid2
076400020521     C                   eval      dcrcid = '2'
076500020521     C                   add       1             r3cntn
076600061024     C                   write     ddelcvgr
076700020521     C                   endif                                                  rec2f <> *blanks
0768000205210111  *
076900020521     C                   if        rec2g <> *blanks
077000020521     C                   eval      recid2 = rec2g
077100020521     C                   eval      r2rate = savrat
077200020521     C                   eval      dcdata = recid2
077300020521     C                   eval      dcrcid = '2'
077400020521     C                   add       1             r3cntn
077500061024     C                   write     ddelcvgr
077600020521     C                   endif                                                  rec2g <> *blanks
0777000205210111  *
077800020521     C                   if        rec2h <> *blanks
077900020521     C                   eval      recid2 = rec2h
078000020521     C                   eval      r2rate = savrat
078100020521     C                   eval      dcdata = recid2
078200020521     C                   eval      dcrcid = '2'
078300020521     C                   add       1             r3cntn
078400061024     C                   write     ddelcvgr
078500020521     C                   endif                                                  rec2h <> *blanks
0786000205210111  *
078700020521     C                   if        rec2i <> *blanks
078800020521     C                   eval      recid2 = rec2i
078900020521     C                   eval      r2rate = savrat
079000020521     C                   eval      dcdata = recid2
079100020521     C                   eval      dcrcid = '2'
079200020521     C                   add       1             r3cntn
079300061024     C                   write     ddelcvgr
079400020521     C                   endif                                                  rec2i <> *blanks
0795000205210111  *
079600020521     C                   if        rec2j <> *blanks
079700020521     C                   eval      recid2 = rec2j
079800020521     C                   eval      r2rate = savrat
079900020521     C                   eval      dcdata = recid2
080000020521     C                   eval      dcrcid = '2'
080100020521     C                   add       1             r3cntn
080200061024     C                   write     ddelcvgr
080300020521     C                   endif                                                  rec2j <> *blanks
0804000205210111  *
080500020521     C                   if        rec2k <> *blanks
080600020521     C                   eval      recid2 = rec2k
080700020521     C                   eval      r2rate = savrat
080800020521     C                   eval      dcdata = recid2
080900020521     C                   eval      dcrcid = '2'
081000020521     C                   add       1             r3cntn
081100061024     C                   write     ddelcvgr
081200020521     C                   endif                                                  rec2k <> *blanks
0813000205210111  *
081400020521     C                   if        rec2l <> *blanks
081500020521     C                   eval      recid2 = rec2l
081600020521     C                   eval      r2rate = savrat
081700020521     C                   eval      dcdata = recid2
081800020521     C                   eval      dcrcid = '2'
081900020521     C                   add       1             r3cntn
082000061024     C                   write     ddelcvgr
082100020521     C                   endif                                                  rec2l <> *blanks
0822000205210111  *
082300020521     C                   if        rec2m <> *blanks
082400020521     C                   eval      recid2 = rec2m
082500020521     C                   eval      r2rate = savrat
082600020521     C                   eval      dcdata = recid2
082700020521     C                   eval      dcrcid = '2'
082800020521     C                   add       1             r3cntn
082900061024     C                   write     ddelcvgr
083000020521     C                   endif                                                  rec2m <> *blanks
0831000205210111  *
083200020521     C                   if        rec2n <> *blanks
083300020521     C                   eval      recid2 = rec2n
083400020521     C                   eval      r2rate = savrat
083500020521     C                   eval      dcdata = recid2
083600020521     C                   eval      dcrcid = '2'
083700020521     C                   add       1             r3cntn
083800061024     C                   write     ddelcvgr
083900020521     C                   endif                                                  rec2n <> *blanks
0840000205210111  *
084100020521     C                   endsr
0842000205170107  ********************************************************************************
0843000205170107  *
0844000205170107  *     BLDADR - Build Record ID = '5' and '6' - Address data
0845000205170107  *
0846000205170107  ********************************************************************************
084700020517     C     bldadr        begsr
0848000205170107  *       Build Record ID 5 - Mbr Address 1
084900061024     C                   clear                   ddelcvgr
085000020517     C                   eval      dcrcid = '5'
085100020517     C                   eval      recid5a = *blanks
085200020517     C                   movel     mbssno        r5soc#
085300061024     C                   eval      r5grp# = rgrp#
085400020517     C                   eval      r5add1 = addr1
085500020517     C                   eval      r5add2 = addr2
085600020517     C                   eval      r5segc = '1'
085700020517     C                   eval      r5actc = 'A'
085800020517     C                   eval      dcdata = recid5a
0859000205170111  *
086000020517     C                   add       1             r3cntn
086100061024     C                   write     ddelcvgr
0862000205170111  *
0863000205170107  *       Build Record ID 5 - Mbr Address 2
086400061024     C                   clear                   ddelcvgr
086500020517     C                   eval      dcrcid = '5'
086600020517     C                   eval      recid5b = *blanks
086700020517     C                   movel     mbssno        r5socb
086800061025     C                   eval      r5grpb = rgrp#
086900020517     C                   eval      r5city = city
087000020517     C                   eval      r5st = state
087100020517     C                   z-add     zip           r5zipn
087200020522     C                   if        (area = 111 and phone = 1111111) OR
087300020522     C                             (area = 001 and phone = 0000001)
087400020520     C                   movel     *blanks       r5phon
087500020520     C                   else
087600020520     C                   z-add     area          r5ac
087700020517     C                   z-add     phone         r5phnn
087800020520     C                   endif
087900020517     C                   eval      r5segb = '2'
088000020517     C                   eval      r5actb = 'A'
088100020517     C                   eval      dcdata = recid5b
0882000205170111  *
088300020517     C                   add       1             r3cntn
088400061024     C                   write     ddelcvgr
0885000205170111  *
088600020517     C                   endsr
0887000205170107  ********************************************************************************
0888000205170107  *
0889000205170107  *     BLDRC3 - Build Record ID = '3' - Trailer
0890000205170107  *
0891000205170107  ********************************************************************************
089200020517     C     bldrc3        begsr
0893000205170107  *       Build Record ID 3
089400061024     C                   clear                   ddelcvgr
089500020517     C                   eval      dcrcid = '3'
089600020517     C                   eval      dcdata = recid3
0897000205170111  *
089800061024     C                   write     ddelcvgr
0899000205170111  *
090000020517     C                   endsr
0901001203120107  ********************************************************************************
0902001203120107  *
0903001203120107  *     DELRECS - Delete all current records for a SSN
0904001203120107  *
0905001203120107  ********************************************************************************
090600120312     C     delrecs       begsr
0907001203120107  *       Delete rec ID 2
090800120312     C                   eval      kyid = '2'
090900120312     C                   movel     r2socn        kydata
091000120312     C     dekey         setll     ddelcvgl
091100120312     C                   dou       *in38 = '1'
091200120312     C                   read      ddelcvgl                               38
091300120312     C                   eval      lecid2 = ldcdata
091400120312     C                   if        *in38 = '0' and r2socn = l2socn
091500120312     C                   delete    ddellr
091600120312     C                   else
091700120312     C                   leave
091800120312     C                   endif
091900120312     C                   enddo
0920001203120107  *       Delete rec ID 5
092100120312     C                   eval      kyid = '5'
092200120312     C     dekey         setll     ddelcvgl
092300120312     C                   dou       *in38 = '1'
092400120312     C                   read      ddelcvgl                               38
092500120312     C                   eval      lecid2 = ldcdata
092600120312     C                   if        *in38 = '0' and r2socn = l2socn
092700120312     C                   delete    ddellr
092800120312     C                   else
092900120312     C                   leave
093000120312     C                   endif
093100120312     C                   enddo
0932001203120111  *
093300120312     C                   endsr
