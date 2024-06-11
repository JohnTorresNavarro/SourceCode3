0001000204020002  *****************************************************************************
000200131029      * DELBLDWGR  Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400131029      *            DATE - 10/2013                                                 *
000500131029      *  DESCRIPTION - Build Delta Dental coverage file from Work File            *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900131024      *  RLJ 10/24/2013 Remove recs termed prior to 07/01/2013
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012001310290020 Fdelwrkp   IF   E           K DISK
0013001310290020 Fmember    IF   E           K DISK
0014000205170020 Fdepndc    IF   E           K DISK
0015001310240020 Fddelgsxp  IF   E           K DISK
0016000610240020 Fddelcvgp  O    E             DISK
0017000204020029  *
0018000204260029  *   Format Input Records
0019009102150250 D                 DS
0020000205020251 D  recid1                 1     74
0021000204260251 D   r1plcd                1      2
0022001112210251 D   r1grp#                3      6
0023001112210251 D   r1grpn                7     36
0024001112210251 D   r1cntc               37     65
0025001112210251 D   r1cnt#               66     75
0026001112210250 D                 DS
0027001112210251 D  recid2                 1     74
0028001112210251 D   r2soc#                1      9
0029000204260251 D    r2socn               1      9S 0
0030000204260251 D   r2grp#               10     13
0031000204260251 D   r2subl               14     17
0032000204260251 D   r2relc               18     18
0033000204260251 D   r2dob                19     24
0034000205020251 D    r2dobmd             19     22  0
0035000205020251 D    r2dobyy             23     24  0
0036000204260251 D   r2rate               25     25
0037000204260251 D   r2fnm                26     33
0038000205080251 D     r2fnm3             26     28
0039000204260251 D   r2lnm                34     49
0040000204260251 D   r2effd               50     55
0041000205020251 D    r2efmd              50     53  0
0042000205020251 D    r2efyy              54     55  0
0043000204260251 D   r2term               56     61
0044000205020251 D    r2trmmd             56     59  0
0045000205020251 D    r2trmyy             60     61  0
0046000204260251 D   r2actc               62     62
0047000204260251 D   r2strt               63     68
0048000205240251 D    r2stmd              63     66  0
0049000205240251 D    r2stda              65     66
0050000205210251 D    r2styy              67     68  0
0051000204260251 D   r2end                69     74
0052000205210251 D    r2endmd             69     72  0
0053000205310251 D    r2endda             71     72  0
0054000205210251 D    r2endyy             73     74  0
0055000204260250 D                 DS
0056000205020251 D  recid3                 1     74
0057000204260251 D   r3cnt                 1      8
0058000205170251 D   r3cntn                1      8  0 INZ(0)
0059000204260250 D                 DS
0060000205020251 D  recid5a                1     74
0061000204260251 D   r5soc#                1      9
0062000204260251 D   r5fil1               10     10
0063000204260251 D   r5grp#               11     14
0064000204260251 D   r5add1               15     38
0065000204260251 D   r5add2               39     62
0066000204260251 D   r5fil2               63     72
0067000204260251 D   r5segc               73     73
0068000204260251 D   r5actc               74     74
0069000204260250 D                 DS
0070000205020251 D  recid5b                1     74
0071000204260251 D   r5socb                1      9
0072000204260251 D   r5fl1b               10     10
0073000204260251 D   r5grpb               11     14
0074000204260251 D   r5city               15     28
0075000204260251 D   r5st                 29     31
0076000204260251 D   r5zip                32     40
0077000205060251 D    r5zip5              32     36
0078000205060251 D    r5zip4              37     40
0079000205020251 D   r5zipn               32     40  0
0080000204260251 D   r5fl2b               41     42
0081000204260251 D   r5phon               43     52
0082000205020251 D    r5ac                43     45  0
0083000205020251 D    r5phnn              46     52  0
0084000204260251 D   r5fl3b               53     72
0085000204260251 D   r5segb               73     73
0086000204260251 D   r5actb               74     74
0087000810300029  *
0088000204260250 D                 DS
0089001310290251 D  dwgrp#                 1     15
0090000610240251 D    grp14                1      4
0091001310240251 D    grp18                1      8
0092001310240251 D    grp110               1     10
0093000610240251 D    grp58                5      8
0094001310240251 D    grp9                 9      9
0095001310240251 D    grp910               9     10
0096000810300029  *
0097000810300250 D                 DS
0098001309260251 D  raty           S              1
0099001309260251 D  kyid           S              1
0100000810300251 D  kydata         S             74    INZ(*BLANKS)
0101001203120251 D  dupmem         S              1
0102001203120251 D  dupem          S              1
0103000810300251 D  updtd          S              1
0104000610240029  *
0105000610240250 D                 DS
0106000610240251 D  datymd                 1      8  0
0107000610240251 D    ymdcc                1      2  0
0108000610240251 D    ymdyy                3      4  0
0109000205070251 D    ymdmd                5      8  0
0110000205170250 D                 DS
0111000205170251 D  mktrst                        3  0 INZ(419)
0112000205170251 D  mksub                         3  0 INZ(1)
0113000205170251 D  mkplan                        4    INZ('7000')
0114000205210251 D  cntspc                        2  0 INZ(0)
0115000205210251 D  cntkid                        2  0 INZ(0)
0116001310290251 D  badgrp                        1    INZ('N')
0117001310290251 D  savrat                        1    INZ(' ')
0118000205210251 D  todaa                         2  0
0119000610240251 D  rgrp#                              LIKE(r2grp#)
0120000610240251 D  rsubl                              LIKE(r2subl)
0121001310290251 D  svrate                             LIKE(r2rate)
0122001310290251 D  svssn                              LIKE(dwssn)
0123001310290251 D  sveff                              LIKE(dweff)
0124000205210250 D                 DS
0125000205210251 D  ISOdate        S               D
0126000205210251 D  ISOnum         S              8  0
0127000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0128000205240251 D  enrdat         S              8  0
0129000205240251 D  trmdat         S              8  0
0130000205210250 D                 DS
0131000205310251 D  wrkdat8                1      8  0
0132000205310251 D   wrkda                 7      8  0
0133000205310250 D                 DS
0134000205310251 D  dftstrt                1      8  0
0135000205210251 D    strtda               7      8  0
0136000205210251 D  dftend                 9     16  0
0137000205210251 D    endda               15     16  0
0138000205210251 D  mdystrt               17     22  0
0139000205210251 D   strta                17     22
0140000205210251 D  mdyend                23     28  0
0141000205210251 D   enda                 23     28
014200020517      *
014300090917      *
014400020517     C     dpkey         klist
014500131029     C                   kfld                    dwssn
014600131029     C                   kfld                    dwseq#
014700090917      *
014800020517      *
014900020503      ******************************************************************************
015000020517      *      MainLine
0151000205211304  *         Calculate default action dates
015200020521     C                   move      UDATE         ISOdate
015300020521     C                   move      ISOdate       ISOnum
015400020521     C                   extrct    ISOdate:*D    todaa
015500020521     C                   if        todaa > 25
015600020521     C                   adddur    10:*D         ISOdate
015700020521     C                   endif
015800020521     C                   move      ISOdate       dftstrt
015900020521     C                   z-add     01            strtda
016000020521     C                   move      dftstrt       ISOdate
016100020521     C                   eval      MDYdate = ISOdate
016200020521     C                   move      MDYdate       mdystrt
016300020521     C                   move      dftstrt       ISOdate
016400020521     C                   adddur    1:*M          ISOdate
016500020521     C                   subdur    1:*D          ISOdate
016600020521     C                   move      ISOdate       dftend
016700020521     C                   eval      MDYdate = ISOdate
016800020521     C                   move      MDYdate       mdyend
0169000205211304  *         Build RecId 1
017000061024     C                   clear                   ddelcvgr
017100020521     C                   eval      dcrcid = '1'
017200020521     C                   eval      recid1 = *blanks
017300061024     C                   eval      r1plcd = 'PA'
017400061024     C                   eval      r1grp# = '7414'
017500061024     C                   eval      r1grpn = 'GBS        '
017600061024     C                   eval      r1cntc = 'Carol Fabiszak'
017700061024     C                   eval      r1cnt# = '4108325141'
017800020517     C                   eval      dcdata = recid1
017900020517     C                   add       1             r3cntn
018000061024     C                   write     ddelcvgr
0181000204260111  *
0182001310290107  *
018300131029     C                   eval      svssn = 0
018400061024     C                   dou       *in23 = '1'
018500131029     C                   read      delwrkp                                23
018600131029     C                   if        *in23 = '1'
018700131029     C                   if        svssn <> 0
018800131029     C                   exsr      bldadr
018900131029     C                   endif
019000131029     C                   leave
019100101228     C                   endif
0192001310290111  *       If term date older than 7/1/2013 - bypass rec
019300131029     C                   if        dwterm <> 0 and dwterm < 20130701
019400131029     C                   iter
019500131029     C                   endif
0196001310290111  *         Member Record?
019700131029     C                   if        dwseq# = 0
0198001310290111  *
019900131029     C                   if        svssn <> 0 and badgrp = 'N'
020000131029     C                   exsr      bldadr
020100131029     C                   endif
0202000612120111  *
020300131029     C                   eval      svssn = dwssn
020400131029     C                   exsr      bldmbr
020500131029     C                   else
0206001310290111  *
020700131029     C                   if        badgrp = 'N'
020800131029     C                   exsr      blddep
020900131029     C                   endif
0210001310290111  *
021100131029     C                   endif
021200061024     C                   enddo
021300020517     C                   exsr      bldrc3
021400020517     C                   movel     '1'           *inlr
021500020517     C                   return
0216000204020107  ********************************************************************************
0217000204020107  *
0218000205170107  *     BLDMBR - Build Record ID = '2' - Member data
0219000204020107  *
0220000204020107  ********************************************************************************
022100020517     C     bldmbr        begsr
022200131029      *
022300131029     C                   eval      badgrp = 'N'
022400020521     C                   eval      cntspc = 0
022500020521     C                   eval      cntkid = 0
022600131029     C     svssn         chain     member                             31
022700020517     C                   if        *in31 = '0'
0228000205170107  *       Build Record ID 2 - Member Data
022900131029     C                   clear                   ddelcvgr
023000131029     C                   eval      dcrcid = '2'
023100020517     C                   eval      recid2 = *blanks
023200131029     C                   z-add     mbssno        r2socn
023300020517     C                   eval      r2relc = '1'
023400131029      *
023500131029     C                   select
023600131029     C                   when      dwcovt = 'TIN'
023700131029     C                   eval      r2rate = '1'
023800131029     C                   when      dwcovt = 'THW'
023900131029     C                   eval      r2rate = '2'
024000131029     C                   when      dwcovt = 'TFA'
024100131029     C                   eval      r2rate = '3'
024200131029     C                   when      dwcovt = 'TPC'
024300131029     C                   eval      r2rate = '5'
024400131029     C                   when      dwcovt = 'TP2'
024500131029     C                   eval      r2rate = '6'
024600131029     C                   endsl
024700131029     C                   eval      svrate = r2rate
024800131029      *
0249001310290107  *      check group# for digit 9
025000131029     C                   if        grp9 <> ' '
025100131029     C     grp110        chain     ddelgsxp                           32
025200131029     C                   if        *in32 = '0'
025300131029     C                   movel(P)  dx08gs        dwgrp#
025400131029     C                   else
025500131029     C                   eval      dwgrp# = dwgrp#
025600131029     C                   endif
025700131029     C                   endif
0258001310290107  *
025900131029     C                   eval      rgrp# = grp14
026000131029     C                   eval      rsubl = grp58
0261001310290107  *
026200131029     C                   if        rgrp# = '9690' or
026300131029     C                             rgrp# = '0997' or
026400131029     C                             rgrp# = '6408' or
026500131029     C                             rgrp# = '1554' or
026600131029     C                             rgrp# = '7129'
026700131029     C                   eval      badgrp = 'Y'
026800131029     C                   leavesr
026900131029     C                   endif
0270001310300107  *
027100131030     C                   if        rgrp# = '7523' and rsubl = '4092'
027200131030     C                   eval      badgrp = 'Y'
027300131030     C                   leavesr
027400131030     C                   endif
0275001310290107  *      Debug shit
0276001310290107  *
027700131029     C                   eval      r2grp# = rgrp#
027800131029     C                   eval      r2subl = rsubl
0279001310290107  *
028000020517     C                   z-add     birth         datymd
028100020517     C                   z-add     ymdyy         r2dobyy
028200020517     C                   z-add     ymdmd         r2dobmd
028300020517     C                   eval      r2fnm = mfname
028400020517     C                   eval      r2lnm = mlname
0285000810310107  *     debug shit
028600131029     C                   if        mbssno = 203368142
028700131029     C                   eval      mbssno = mbssno
028800020524     C                   endif
0289000205240107  *
029000131029     C                   z-add     dweff         sveff
0291001310290107  *
029200131029     C                   z-add     dweff         datymd
029300020517     C                   z-add     ymdyy         r2efyy
029400020517     C                   z-add     ymdmd         r2efmd
0295001310160107  *    Hard coded fix - 10/16/2013
029600131029     C****               if        mbssno = 203368142
029700131025     C*                  eval      trmdat = 0
029800131025     C****               endif
029900020523      *
030000131029     C                   if        dwterm = 0
030100020523     C                   eval      r2term = '000000'
030200020523     C                   else
030300131029     C                   move      dwterm        ISOdate
030400020523     C                   subdur    1:*D          ISOdate
030500020523     C                   move      ISOdate       datymd
030600020524     C                   move      datymd        trmdat
030700020517     C                   z-add     ymdyy         r2trmyy
030800020517     C                   z-add     ymdmd         r2trmmd
030900020523     C                   endif
031000130926      *
031100020517     C                   eval      r2actc = 'A'
031200020718      *
031300131029     C                   if        dweff > dftstrt
031400020521     C                   eval      r2strt = r2effd
031500020531     C                   eval      r2end = r2strt
031600131029     C                   move      dweff         wrkdat8
031700020531     C                   eval      wrkda = 01
031800020531     C                   move      wrkdat8       ISOdate
031900020531     C                   adddur    1:*M          ISOdate
032000020531     C                   subdur    1:*D          ISOdate
032100020531     C                   extrct    ISOdate:*D    r2endda
032200020718      *
032300020718     C                   else
032400020718     C                   eval      r2strt = strta
032500020524     C                   if        trmdat > dftend or trmdat = 0
032600020521     C                   eval      r2end = enda
032700020521     C                   else
032800020521     C                   eval      r2end =r2term
032900020521     C                   endif
033000020524     C                   if        trmdat < dftstrt and trmdat <> 0
033100020521     C                   eval      r2strt = r2term
033200020524     C                   eval      r2stda = '01'
033300020521     C                   endif
033400020718     C                   endif
0335001310290111  *
033600131029     C                   eval      dcdata = recid2
033700131029     C                   add       1             r3cntn
033800131029     C                   write     ddelcvgr
0339000205170111  *
034000020517     C                   endif
0341000205170111  *
034200020517     C                   endsr
0343000205170107  ********************************************************************************
0344000205170107  *
0345000205170107  *     BLDDEP - Build Record ID = '2' - Dependent data
0346000205170107  *
0347000205170107  ********************************************************************************
034800020517     C     blddep        begsr
0349001310290107  *
035000020517     C     dpkey         chain     depndc                             33
035100131029     C                   if        *in33 = '0'
0352001310290107  *       Build Record ID 2 - Dep Data
035300131029     C                   clear                   ddelcvgr
035400131029     C                   eval      dcrcid = '2'
035500131029     C                   eval      recid2 = *blanks
035600131029     C                   z-add     dwssn         r2socn
035700131029      *
035800131029     C                   if        drelcd = 'RHU' or drelcd = 'RWI' or
035900131029     C                             drelcd = 'RPA'
036000131029     C                   eval      r2relc = '2'
036100131029     C                   add       1             cntspc
036200131029     C                   else
036300131029     C                   eval      r2relc = '3'
036400131029     C                   add       1             cntkid
036500131029     C                   endif
036600131029      *
036700131029     C                   eval      r2rate = svrate
036800131029      *
036900131029     C                   eval      r2grp# = rgrp#
037000131029     C                   eval      r2subl = rsubl
0371001310290107  *
037200131029     C                   z-add     dbirth        datymd
037300131029     C                   z-add     ymdyy         r2dobyy
037400131029     C                   z-add     ymdmd         r2dobmd
037500131029     C                   eval      r2fnm = dfname
037600131029     C                   eval      r2lnm = dlname
0377001310290107  *     debug shit
037800131029     C                   if        mbssno = 203368142
037900131029     C                   eval      mbssno = mbssno
038000131029     C                   endif
0381001310290107  *
038200131029     C                   if        dweff < sveff
038300131029     C                   eval      dweff = sveff
038400131029     C                   endif
0385001310290107  *
038600131029     C                   z-add     dweff         datymd
038700131029     C                   z-add     ymdyy         r2efyy
038800131029     C                   z-add     ymdmd         r2efmd
0389001310290107  *    Hard coded fix - 10/16/2013
039000131029     C****               if        mbssno = 203368142
039100131029     C*                  eval      trmdat = 0
039200131029     C****               endif
039300131029      *
039400131029     C                   if        dwterm = 0
039500131029     C                   eval      r2term = '000000'
039600131029     C                   else
039700131029     C                   move      dwterm        ISOdate
039800131029     C                   subdur    1:*D          ISOdate
039900131029     C                   move      ISOdate       datymd
040000131029     C                   move      datymd        trmdat
040100131029     C                   z-add     ymdyy         r2trmyy
040200131029     C                   z-add     ymdmd         r2trmmd
040300131029     C                   endif
040400131029      *
040500131029     C                   eval      r2actc = 'A'
040600131029      *
040700131029     C                   if        dweff > dftstrt
040800131029     C                   eval      r2strt = r2effd
040900131029     C                   eval      r2end = r2strt
041000131029     C                   move      dweff         wrkdat8
041100131029     C                   eval      wrkda = 01
041200131029     C                   move      wrkdat8       ISOdate
041300131029     C                   adddur    1:*M          ISOdate
041400131029     C                   subdur    1:*D          ISOdate
041500131029     C                   extrct    ISOdate:*D    r2endda
041600131029      *
041700131029     C                   else
041800131029     C                   eval      r2strt = strta
041900131029     C                   if        trmdat > dftend or trmdat = 0
042000131029     C                   eval      r2end = enda
042100131029     C                   else
042200131029     C                   eval      r2end =r2term
042300131029     C                   endif
042400131029     C                   if        trmdat < dftstrt and trmdat <> 0
042500131029     C                   eval      r2strt = r2term
042600131029     C                   eval      r2stda = '01'
042700131029     C                   endif
042800131029     C                   endif
0429001310290111  *
043000131029     C                   eval      dcdata = recid2
043100131029     C                   add       1             r3cntn
043200131029     C                   write     ddelcvgr
0433001310290111  *
043400131029     C                   endif
0435000205170111  *
043600020517     C                   endsr
0437000205170107  ********************************************************************************
0438000205170107  *
0439000205170107  *     BLDADR - Build Record ID = '5' and '6' - Address data
0440000205170107  *
0441000205170107  ********************************************************************************
044200020517     C     bldadr        begsr
0443000205170107  *       Build Record ID 5 - Mbr Address 1
044400061024     C                   clear                   ddelcvgr
044500020517     C                   eval      dcrcid = '5'
044600020517     C                   eval      recid5a = *blanks
044700020517     C                   movel     mbssno        r5soc#
044800061024     C                   eval      r5grp# = rgrp#
044900020517     C                   eval      r5add1 = addr1
045000020517     C                   eval      r5add2 = addr2
045100020517     C                   eval      r5segc = '1'
045200020517     C                   eval      r5actc = 'A'
045300020517     C                   eval      dcdata = recid5a
0454000205170111  *
045500020517     C                   add       1             r3cntn
045600061024     C                   write     ddelcvgr
0457000205170111  *
0458000205170107  *       Build Record ID 5 - Mbr Address 2
045900061024     C                   clear                   ddelcvgr
046000020517     C                   eval      dcrcid = '5'
046100020517     C                   eval      recid5b = *blanks
046200020517     C                   movel     mbssno        r5socb
046300061025     C                   eval      r5grpb = rgrp#
046400020517     C                   eval      r5city = city
046500020517     C                   eval      r5st = state
046600020517     C                   z-add     zip           r5zipn
046700020522     C                   if        (area = 111 and phone = 1111111) OR
046800020522     C                             (area = 001 and phone = 0000001)
046900020520     C                   movel     *blanks       r5phon
047000020520     C                   else
047100020520     C                   z-add     area          r5ac
047200020517     C                   z-add     phone         r5phnn
047300020520     C                   endif
047400020517     C                   eval      r5segb = '2'
047500020517     C                   eval      r5actb = 'A'
047600020517     C                   eval      dcdata = recid5b
0477000205170111  *
047800020517     C                   add       1             r3cntn
047900061024     C                   write     ddelcvgr
0480000205170111  *
048100020517     C                   endsr
0482000205170107  ********************************************************************************
0483000205170107  *
0484000205170107  *     BLDRC3 - Build Record ID = '3' - Trailer
0485000205170107  *
0486000205170107  ********************************************************************************
048700020517     C     bldrc3        begsr
0488000205170107  *       Build Record ID 3
048900061024     C                   clear                   ddelcvgr
049000020517     C                   eval      dcrcid = '3'
049100020517     C                   eval      dcdata = recid3
0492000205170111  *
049300061024     C                   write     ddelcvgr
0494000205170111  *
049500020517     C                   endsr
