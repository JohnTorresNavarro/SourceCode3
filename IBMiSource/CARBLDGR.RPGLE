0001000204020002  *****************************************************************************
000200070803      * CARBLDGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400070803      *            DATE - 08/2007                                                 *
000500070803      *  DESCRIPTION - Build Caremark coverage file from GBS files                *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020426      *  XXX mm/dd/yyyy desc
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012000610240020 Fplnmstn1  IF   E           K DISK
0013002401170020 Fgrat25    IF   E           K DISK
0014002401170020 Fmcovl1    IF   E           K DISK
0015002401170020 Fmember    IF   E           K DISK
0016002401170020 Fdepndc    IF   E           K DISK
0017002401170020 Fdcov      IF   E           K DISK
0018002401170020 Faccmst    IF   E           K DISK
0019002401170020 Fcradmbrp  O    E             DISK
0020000204020029  *
0021002401170029  *   Format Output Records
0022002401170250 D                 DS
0023002401170251 D  mrec1                  1    313
0024002401170251 D   m1typ                 1      1    INZ('1')
0025002401170251 D   m1carr                2     10
0026000708060251 D   m1cnam               11     35
0027000708060251 D   m1cad1               36     60
0028000708060251 D   m1cad2               61     75
0029000708060251 D   m1ccty               76     95
0030000708060251 D   m1cst                96     97
0031000708060251 D   m1czip               98    107
0032000708060251 D   m1cphn              108    117
0033000708060251 D   m1cdat              118    124
0034000708060251 D   m1ctim              125    130
0035000708060251 D   m1csrc              131    133
0036000708060251 D   m1ctyp              134    136    INZ('MEM')
0037000708280251 D   m1cfil              137    313
0038000708060250 D                 DS
0039000708280251 D  mrec3                  1    313
0040000708060251 D   m3typ                 1      1    INZ('3')
0041000708060251 D   m3carr                2     10
0042000708060251 D   m3cact               11     25
0043000708060251 D   m3cgrp               26     40
0044000708290251 D   m3mbid               41     49
0045000708290251 D   m3mbpc               50     51
0046000708060251 D   m3prcd               59     61
0047000708060251 D   m3relc               62     62
0048000708060251 D   m3lnam               63     87
0049000708060251 D   m3fnam               88    102
0050000708060251 D   m3mi                103    103
0051000708060251 D   m3sex               104    104
0052000708060251 D   m3dob               105    112
0053000708280251 D   m3effd              113    119
0054000708280251 D   m3trmd              120    126
0055000708280251 D   m3gad1              127    151
0056000708280251 D   m3gad2              152    166
0057000708280251 D   m3gcty              167    186
0058000708280251 D   m3gst               187    188
0059000708280251 D   m3gzip              189    198
0060000708280251 D   m3phon              199    208
0061000708280251 D   m3fil1              209    270
0062000708280251 D   m3mssn              271    288
0063000708280251 D   m3fil2              289    313
0064000708060250 D                 DS
0065000708280251 D  mrec9                  1    313
0066000708070251 D   m9typ                 1      1    INZ('9')
0067000708070251 D   m9carr                2     10
0068000708070251 D   m9totr               11     19
0069000708310251 D   m9tota               20     28    INZ('000000000')
0070000708070251 D   m9totc               29     37
0071000708310251 D   m9totm               38     46    INZ('000000000')
0072000708280251 D   m9totu               47     55    INZ('000000000')
0073000708070251 D   m9tote               56     64
0074000708280251 D   m9gfil               65    313    INZ(*blanks)
0075000205210029  *
0076000204260250 D                 DS
0077000708090251 D  zip                    1      9  0
0078000708090251 D    zip5                 1      5
0079000708090251 D    zip4                 6      9
0080000708090029  *
0081000708090251 D  dzip                   1      9  0
0082000708090251 D    dzip5                1      5
0083000708090251 D    dzip4                6      9
0084000708090029  *
0085000708090250 D                 DS
0086000708090251 D  group#                 1     15
0087000708090251 D    grp14                1      4
0088000708100251 D    grp57                5      7
0089000708100251 D    grp810               8     10
0090000610240029  *
0091000610240250 D                 DS
0092000708090251 D  cgsort                 1      2
0093000708090251 D    gsort1               1      1
0094000708090251 D    gsort2               2      2
0095000708090029  *
0096000708090250 D                 DS
0097000708090251 D  cmsort                 1      2
0098000708090251 D    msort1               1      1
0099000708090251 D    msort2               2      2
0100000708090029  *
0101000708290250 D                 DS
0102000708290251 D  mbrcnt                 1      9  0 INZ(0)
0103000708290251 D   mbrcnta               1      9
0104000708290251 D  totcnt                10     18  0 INZ(0)
0105000708290251 D   totcnta              10     18
0106000708290029  *
0107000708090250 D                 DS
0108000708090251 D  gbsdat                 1      8  0
0109000708090251 D    gdc                  1      2  0
0110000708090251 D    gdymd                3      8  0
0111000708080250 D                 DS
0112000708080251 D  cardat                 1      7
0113000708080251 D    cdc                  1      1
0114000708080251 D    cdymd                2      7
0115000205170250 D                 DS
0116000708080251 D  mbr0                          1    INZ('N')
0117000708090251 D  grp1                          1    INZ('N')
0118000708090251 D  mbr1                          1    INZ('N')
0119000708090251 D  grp3                          1    INZ('N')
0120000708080251 D  todac                         7
0121000708090251 D  grpcnt                        1  0 INZ(0)
0122000708090251 D  kcarr                         3
0123000205210251 D  savrat                        1    INZ(' ')
0124000205210251 D  todaa                         2  0
0125000205210250 D                 DS
0126000205210251 D  ISOdate        S               D
0127000205210251 D  ISOnum         S              8  0
0128000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0129000205240251 D  enrdat         S              8  0
0130000205240251 D  trmdat         S              8  0
0131000811200250 D                 DS
0132000811200251 D  wrkdat8                1      8  0
0133000811200251 D   wrkda                 7      8  0
0134000811200250 D                 DS
0135000811200251 D  dftstrt                1      8  0
0136000811200251 D    strtda               7      8  0
0137000811200251 D  dftend                 9     16  0
0138000811200251 D    endda               15     16  0
0139000811200251 D  mdystrt               17     22  0
0140000811200251 D   strta                17     22
0141000205210251 D  mdyend                23     28  0
0142000811200251 D   enda                 23     28
014300081120      *
014400081120     C     grkey         klist
014500081120     C                   kfld                    pltrst
014600081120     C                   kfld                    plsub#
014700081120     C                   kfld                    plplan
014800081120      *
014900081120     C     acckey        klist
015000081120     C                   kfld                    mctrst
015100081120     C                   kfld                    mcsub#
015200020517     C                   kfld                    acc#
015300020517      *
015400020517     C     dpkey         klist
015500020517     C                   kfld                    ssno
015600020517     C                   kfld                    dseq#
015700020524      *
015800020524     C     m38ky         klist
015900020524     C                   kfld                    mcssno
016000020524     C                   kfld                    mdseq#
016100020524     C                   kfld                    mctrst
016200020524     C                   kfld                    mcsub#
016300020524     C                   kfld                    mcplan
016400020517      *
016500020503      ******************************************************************************
016600020517      *      MainLine
0167000205211304  *         Calculate default action dates
016800020521     C                   move      UDATE         ISOdate
016900020521     C                   move      ISOdate       ISOnum
017000080709     C                   move      ISOnum        gbsdat
017100080709     C                   movel     '1'           cdc
017200070808     C                   move      gdymd         cdymd
017300081120     C                   move      cardat        todac
017400020521     C                   adddur    10:*D         ISOdate
017500020521     C                   move      ISOdate       dftstrt
017600020521     C                   z-add     01            strtda
017700020521     C                   move      dftstrt       ISOdate
017800020521     C                   eval      MDYdate = ISOdate
017900020521     C                   move      MDYdate       mdystrt
018000081120     C                   move      dftstrt       ISOdate
018100081120     C                   adddur    1:*M          ISOdate
018200020521     C                   subdur    1:*D          ISOdate
018300081120     C                   move      ISOdate       dftend
018400081120     C                   eval      MDYdate = ISOdate
018500081120     C                   move      MDYdate       mdyend
018600081120     C                   eval      mbrcnt = 0
0187000811200111  *
0188000708080107  *      Loop thru PLNMST looking for Carrier = 'CAR'
018900070808     C                   eval      kcarr = 'CAR'
019000061024     C     kcarr         setll     plnmstn1
019100061024     C                   dou       *in23 = '1'
019200061024     C     kcarr         reade     plnmstn1                               23
019300061024     C                   if        *in23 = '0'
0194000612120111  *
019500061024     C     grkey         chain     grat25                             24
019600061024     C                   if        *in24 = '0'
0197000708090107  *
019800070808     C                   eval      mbr1 = 'N'
019900070809     C                   eval      grp3 = 'N'
0200000708090107  *
020100070809     C                   eval      grpcnt = grpcnt + 1
0202000610240111  *
0203000610240107  *      Loop thru MCOVL1 to locate all mbrs
020400061024     C     grkey         setll     mcovl1
020500061024     C                   dou       *in21 = '1'
020600061024     C     grkey         reade     mcovl1                                 21
020700061024     C                   if        *in21 = '0'
0208000811200107  *      If enroll date and term date are equal => bypass record
020900081120     C                   if        enrldt = candt
021000081120     C                   iter
021100081120     C                   endif
0212000811200107  *
021300081120     C                   if        mbr1 = 'N'
021400081120     C                   exsr      bldmbr1
021500081120     C                   endif
0216000811200107  *
021700081120     C                   exsr      bldmbr3m
0218000610250107  *      Loop thru DCOV to locate all Delta dependents
021900020517     C     mcssno        setll     dcov
022000020517     C                   dou       *in22 = '1'
022100020517     C     mcssno        reade     dcov                                   22
022200020517     C                   if        *in22 = '0'
0223000206260107  *      If enroll date and term date are equal => bypass record
022400020524     C                   if        denrdt = ccandt
022500020524     C                   iter
022600020524     C                   endif
022700061025     C                   if        mcssno = ssno and dvplan = plplan
022800070809     C                   exsr      bldmbr3d
022900020517     C                   endif
023000020517     C                   else
023100020517     C                   leave
023200020517     C                   endif
023300020517     C                   enddo
023400070809      *
023500020517     C                   endif
023600020517     C                   enddo
023700061024     C                   endif
023800070809     C                   endif
023900070809     C                   enddo
024000070810      *
024100070810     C                   exsr      bldmbr9
024200070810      *
024300020517     C                   movel     '1'           *inlr
024400020517     C                   return
0245000708090107  ********************************************************************************
0246000708090107  *
0247000708090107  *     BLDMBR1 - Build Mbr Rec 1
0248000708090107  *
0249000708090107  ********************************************************************************
0250000708091304  *         Build Mbr Rec 1
025100070809     C     bldmbr1       begsr
025200070828     C                   clear                   cradmbrr
0253000708090111  *
025400070809     C                   eval      m1carr = grp14
025500070809     C                   eval      m1cnam = 'GROUP BENEFIT SERVICES   '
025600070809     C                   eval      m1cad1 = '6 NORTH PARK DR.         '
025700070809     C                   eval      m1cad2 = 'SUITE 310      '
025800070809     C                   eval      m1ccty = 'HUNT VALLEY         '
025900070809     C                   eval      m1cst = 'MD'
026000070809     C                   eval      m1czip = '21030    '
026100070809     C                   eval      m1cphn = '4108321300'
026200070809     C                   eval      m1cdat = todac
026300070810     C                   eval      m1csrc = grp57
026400070809     C                   eval      cmdata = mrec1
026500070828     C                   write     cradmbrr
026600070809     C                   eval      mbr1 = 'Y'
026700070809     C                   endsr
0268000204020107  ********************************************************************************
0269000204020107  *
0270000708090107  *     BLDMBR3M - Build Mbr 3 rec for member
0271000204020107  *
0272000204020107  ********************************************************************************
027300070809     C     bldmbr3m      begsr
027400020517     C     mcssno        chain     member                             31
027500020517     C                   if        *in31 = '0'
027600070828     C                   clear                   cradmbrr
027700070809     C                   eval      m3carr = grp14
027800070810     C                   eval      m3cact = grp57
027900070810     C                   eval      m3cgrp = grp810
028000070809     C                   movel     mcssno        m3mbid
028100070829     C                   eval      m3mbpc = '00'
028200070829     C                   eval      m3prcd = '00'
028300070809     C                   eval      m3relc = '1'
028400070809     C                   eval      m3fnam = mfname
028500070809     C                   eval      m3lnam = mlname
028600070809     C                   eval      m3mi = mmi
028700070809     C                   eval      m3sex = sex
028800070809     C                   movel     birth         m3dob
028900070828     C                   movel     mbssno        m3mssn
029000070809     C                   eval      m3gad1 = addr1
029100070809     C                   eval      m3gad2 = addr2
029200070809     C                   eval      m3gcty = city
029300070809     C                   eval      m3gst = state
029400070828     C                   movel     zip           m3gzip
029500070809     C                   movel     area          m3phon
029600070809     C                   move      phone         m3phon
029700070809     C                   move      enrldt        gbsdat
029800070828     C                   movel     '1'           cdc
029900070809     C                   move      gdymd         cdymd
030000070828     C                   move      cardat        m3effd
030100070828      *
030200240117     C                   if        candt < 20200101
030300240117     C                   leavesr
030400240117     C                   endif
030401240117      *
030402240117     C                   if        candt = 0
030403240117     C                   eval      m3trmd = '9999999'
030404240117     C                   else
030500070809     C                   move      candt         gbsdat
030600070809     C                   move      '1'           cdc
030700070809     C                   move      gdymd         cdymd
030800070828     C                   move      cardat        m3trmd
030900070828     C                   endif
031000070828      *
031100070828     C                   movel     mcssno        m3mssn
031200070809     C                   eval      mbrcnt = mbrcnt + 1
031300070810     C                   eval      totcnt = totcnt + 1
031400070809     C                   eval      cmdata = mrec3
031500070828     C                   write     cradmbrr
0316000205170111  *
031700070809     C                   endif
031800070809     C                   endsr
0319000708090107  ********************************************************************************
0320000708090107  *
0321000708090107  *     BLDMBR3D - Build Mbr 3 rec for dep
0322000708090107  *
0323000708090107  ********************************************************************************
032400070809     C     bldmbr3d      begsr
032500070809     C     dpkey         chain     depndc                             33
032600070809     C                   if        *in33 = '0'
032700070828     C                   clear                   cradmbrr
032800070809     C                   eval      m3carr = grp14
032900070810     C                   eval      m3cact = grp57
033000070810     C                   eval      m3cgrp = grp810
033100070809     C                   movel     mcssno        m3mbid
033200070829     C                   movel     dpseq#        m3mbpc
033300070829     C                   movel     dpseq#        m3prcd
033400070809     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
033500070809     C                   eval      m3relc = '2'
033600070809     C                   else
033700070809     C                   eval      m3relc = '3'
033800070809     C                   endif
033900070809     C                   eval      m3fnam = dfname
034000070809     C                   eval      m3lnam = dlname
034100070809     C                   eval      m3mi = dmi
034200070809     C                   eval      m3sex = dsex
034300070809     C                   movel     dbirth        m3dob
034400070828     C                   movel     mbssno        m3mssn
034500070809     C                   eval      m3gad1 = daddr1
034600070809     C                   eval      m3gad2 = daddr2
034700070809     C                   eval      m3gcty = dcity
034800070809     C                   eval      m3gst = dstate
034900070828     C                   movel     dzip          m3gzip
035000070809     C                   movel     darea         m3phon
035100070809     C                   movel     dphone        m3phon
035200070809     C                   move      denrdt        gbsdat
035300070809     C                   move      '1'           cdc
035400070809     C                   move      gdymd         cdymd
035500070828     C                   move      cardat        m3effd
035501240117      *
035502240117     C                   if        Ccandt < 20200101
035503240117     C                   leavesr
035504240117     C                   endif
035600070828      *
035700070828     C                   if        ccandt = 0
035800070828     C                   eval      m3trmd = '9999999'
035900070828     C                   else
036000070809     C                   move      ccandt        gbsdat
036100070809     C                   move      '1'           cdc
036200070809     C                   move      gdymd         cdymd
036300070828     C                   move      cardat        m3trmd
036400070828     C                   endif
036500070828      *
036600070809     C                   eval      mbrcnt = mbrcnt + 1
036700070810     C                   eval      totcnt = totcnt + 1
036800070809     C                   eval      cmdata = mrec3
036900070828     C                   write     cradmbrr
0370000708090111  *
037100070809     C                   endif
037200070809     C                   endsr
0373000708100107  ********************************************************************************
0374000708100107  *
0375000708100107  *     BLDMBR9 - Build Mbr Rec 9
0376000708100107  *
0377000708100107  ********************************************************************************
0378000708101304  *         Build Mbr Rec 9
037900070810     C     bldmbr9       begsr
038000070828     C                   clear                   cradmbrr
038100070810     C                   eval      m9carr = grp14
038200070829     C                   movel     mbrcnta       m9totr
038300070829     C                   movel     mbrcnta       m9totc
038400070810     C                   eval      cmdata = mrec9
038500070828     C                   write     cradmbrr
038600070810     C                   endsr
