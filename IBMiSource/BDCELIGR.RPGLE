0001000204020002  *****************************************************************************
000200230314      * BDCELIGR   Amwins Connect Administrators                                  *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400220615      *            DATE - 06/2022                                                 *
000500220615      *  DESCRIPTION - Build Beam Dental coverage file from GBS files             *
000600020426      *
0007000204020002  *****************************************************************************
0008000909100015  *  Change Log:                                                              *
000900220615      *  xxx mm/dd/yyyy
001000090714      *                                                                *
0011009102150018 F******************************************************************
0012000909100020 Fplnmstn1  IF   E           K DISK
0013000909100020 Fgrat25    IF   E           K DISK
0014000909100020 Fmcov39    IF   E           K DISK
0015000205240020 Fmcov38    IF   E           K DISK    RENAME(MCOVR:MC38R)
0016000703050020 F                                     PREFIX(X)
0017000205170020 Fmember    IF   E           K DISK
0018002206220020 Fmemextp   IF   E           K DISK
0019000205170020 Fdepndc    IF   E           K DISK
0020000205170020 Fdcov      IF   E           K DISK
0021002207050020 Fcodes     IF   E           K DISK
0022002206150020 Fbdeligp   O    E             DISK
0023000205210029  *
0024000702200250 D                 DS
0025002207050251 D  plncat                 1      3
0026002207050251 D    plnc1                1      1
0027002207050251 D    plnc2                2      3
0028002207050029  *
0029002207050250 D                 DS
0030002207050251 D  zip                    1      9  0
0031002207050251 D    mzip5                1      5
0032002207050251 D    mzip4                6      9
0033000702200029  *
0034000702200250 D                 DS
0035000702200251 D  dzip                   1      9  0
0036000909110251 D    dzip5                1      5
0037000909110251 D    dzip4                6      9
0038002208290029  *
0039002208290250 D                 DS
0040002208290251 D  pdescr                 1     40
0041002208290251 D    descr5               1      5
0042002208290251 D    descr6               6     40
0043000909110029  *
0044000909110250 D                 DS
0045000909110251 D  datymd                 1      8  0
0046000909110251 D    ymdcc                1      2  0
0047000610240251 D    ymdyy                3      4  0
0048000205070251 D    ymdmd                5      8  0
0049002207140029  *
0050002207140250 D                 DS
0051002207140251 D  GROUP#                 1     15
0052002207140251 D   grp7                  1      7
0053000702200029  *
0054000702200250 D                 DS
0055000702200251 D  gbsphn                 1      7  0
0056000702200251 D   gbphn3                1      3
0057000702200251 D   gbphn4                4      7
0058000702200029  *
0059000702200250 D                 DS
0060002206170251 D  fill66                 1     66
0061002206170251 D   emal65                1     65
0062000205170250 D                 DS
0063000205210251 D  savrat                        1    INZ(' ')
0064000702160251 D  todaa                         2  0
0065000702160251 D  kcarr                              LIKE(PCARR)
0066000707110251 D  svssno                             LIKE(mcssno)
0067000707110251 D                                     INZ(999999999)
0068000702160250 D                 DS
0069000702160251 D  ISOdate        S               D
0070000205210251 D  ISOnum         S              8  0
0071000205210251 D  MDYdate        S               D   DATFMT(*MDY)
007200080414     D  wkday          S               D     inz
0073001108170251 D  memeff         S              8  0
0074001108170251 D  enrdat         S              8  0
0075000205240251 D  trmdat         S              8  0
0076002206150251 D  svgrp          S                   like(GROUP#)
0077000205210250 D                 DS
0078000702080251 D  gbsdat                 1      8  0
0079002302270251 D   gccmm                 1      4
0080002302270251 D   gmmdd                 5      8
0081002302270251 D   gbdy                  7      8
0082002302270250 D                 DS
0083002302270251 D  dxdat                  1      8
0084002302270251 D   dmmdd                 1      4
0085002302270251 D   dxddd                 3      4
0086002302270251 D   dccmm                 5      8
0087000205310250 D                 DS
0088002302270251 D  dftstrt                1      8  0
0089000205210251 D    strtda               7      8  0
0090000205210251 D  dftend                 9     16  0
0091000205210251 D    endda               15     16  0
0092000205210251 D  mdystrt               17     22  0
0093000205210251 D   strta                17     22
0094000205210251 D  mdyend                23     28  0
0095000205210251 D   enda                 23     28
009600220615      *
009700220705     C     codkey        klist
009800230228     C                   kfld                    plnc1
009900230228     C                   kfld                    plnc2
010000230228      *
010100230228     C     grkey         klist
010200230228     C                   kfld                    pltrst
010300230228     C                   kfld                    plsub#
010400230228     C                   kfld                    plplan
010500230228      *
010600230228     C     xrefky        klist
010700080626     C                   kfld                    mbtrst
010800230316     C                   kfld                    mbsub#
010900230316     C                   kfld                    mbacct
011000230316      *
011100230316     C     xrkey         klist
011200230316     C                   kfld                    mctrst
011300230316     C                   kfld                    mcsub#
011400230316     C                   kfld                    acc#
011500020517      *
011600020517     C     dpkey         klist
011700020517     C                   kfld                    ssno
011800020517     C                   kfld                    dseq#
011900020524      *
012000020524     C     m38ky         klist
012100020524     C                   kfld                    mcssno
012200020524     C                   kfld                    mdseq#
012300020524     C                   kfld                    mctrst
012400020524     C                   kfld                    mcsub#
012500020524     C                   kfld                    mcplan
012600020517      *
012700020503      ******************************************************************************
012800020517      *      MainLine
0129000205211304  *         Calculate default action dates
013000020521     C                   move      UDATE         ISOdate
013100020521     C                   move      ISOdate       ISOnum
013200020521     C                   move      ISOdate       dftstrt
013300020521     C                   z-add     01            strtda
013400020521     C                   move      dftstrt       ISOdate
013500220707     C                   eval      MDYdate = ISOdate
013600220707     C                   move      MDYdate       mdystrt
013700220707     C                   move      dftstrt       ISOdate
013800220707     C                   adddur    1:*M          ISOdate
013900230316     C                   subdur    1:*D          ISOdate
014000230316     C                   move      ISOdate       dftend
014100230316     C                   eval      MDYdate = ISOdate
014200230316     C                   move      MDYdate       mdyend
0143002303161304  *
0144002303160111  *
0145002303160107  *      Loop thru PLNMST looking for Carrier = 'BMD'
014600230316     C                   eval      kcarr = 'BMD'
014700230316     C     kcarr         setll     plnmstn1
014800230316     C                   dou       *in23 = '1'
014900230316     C     kcarr         reade     plnmstn1                               23
015000230316     C                   if        *in23 = '0'
0151002303160111  *       Debug Shit
015200230302     C                   if        (*in23 = '0' and pltrst = 900 and
015300230302     C                             plsub# = 108)
015400230302     C                   eval      svgrp = svgrp
015500230224     C                   endif
0156002303020107  *       Get Plan Type
015700230302     C     codkey        chain     codes                              24
0158002303020107  *       Get GROUP# from GRATE
015900230302     C                   eval      svgrp = *blanks
016000230302     C     grkey         chain     grat25                             25
016100230302     C                   if        *in25 = '0'
016200230302     C                   eval      svgrp = GROUP#
016300230302     C                   endif
0164002303020111  *   Process 1 group only
016500230302     C                   if        grp7 <> 'MD09079'
016501230313     C                   eval      grp7 = grp7
016600230313     C******             iter
016700230302     C                   endif
0168002303020111  *
0169002303020107  *      Loop thru MCOV39 to locate all mbrs
017000230302     C     grkey         setll     mcov39
017100230302     C                   dou       *in21 = '1'
017200090313     C     grkey         reade     mcov39                                 21
017300090313     C                   if        *in21 = '0'
0174000803190107  *      Debug shit
017500110817     C                   if        mcssno = 215640230 or
017600110817     C                             mcssno = 213063847
017700070711     C                   eval      mcssno = mcssno
017800020524     C                   endif
0179000205240107  *
0180002206150107  *      If enroll date and term date are equal - bypass
018100070711     C                   if        enrldt = candt
018200220615     C                   iter
018300220705     C                   endif
0184002206150107  *
0185000707110107  *      If same ssn - bypass
018600070711     C                   if        svssno = mcssno
018700070711     C                   iter
018800070711     C                   endif
0189002303020107  *
019000230302     C                   eval      svssno = mcssno
0191002303020107  *
019200020524     C                   exsr      bldmbr
0193000610250107  *      Loop thru DCOV to locate all Delta dependents
019400020517     C     mcssno        setll     dcov
019500020517     C                   dou       *in22 = '1'
019600020517     C     mcssno        reade     dcov                                   22
019700020517     C                   if        *in22 = '0'
0198002206150107  *      If enroll date and term date are equal - bypass
019900020524     C                   if        denrdt = ccandt
020000220615     C                   iter
020100070713     C                   endif
020200070713      *
020300061025     C                   if        mcssno = ssno and dvplan = plplan
020400020517     C                   exsr      blddep
020500020517     C                   endif
020600220624      *
020700020517     C                   else
020800020517     C                   leave
020900020517     C                   endif
021000020517     C                   enddo
021100070821     C                   endif
021200090313     C                   enddo
021300080414     C                   endif
021400070821     C                   enddo
021500020517     C                   movel     '1'           *inlr
021600020517     C                   return
0217000204020107  ********************************************************************************
0218000204020107  *
0219000702080107  *     BLDMBR - Build Record - Member data
0220000204020107  *
0221000204020107  ********************************************************************************
022200020517     C     bldmbr        begsr
022300070208      *
022400220617     C                   clear                   bdeligr
022500020517     C     mcssno        chain     member                             31
022600020517     C                   if        *in31 = '0'
0227000902160107  *       Build Record - Member Data
022800220615     C                   movel     svgrp         bdgrp#
022900220615     C                   movel     mbssno        bdessn
023000220615     C                   movel     mbssno        bdissn
023100220705     C                   eval      bddseq = 0
023200220617     C                   movel     'Employee'    bdrel
023300220617     C                   movel     mfname        bdfnme
023400220617     C                   movel     mmi           bdmi
023500220617     C                   movel     mfname        bdfnme
023600220617     C                   movel     mlname        bdlnme
023700220617     C                   eval      bdgndr = sex
023800220617     C                   eval      bdbrdt = birth
023900220617     C                   movel     emal65        bdemal
024000220706      *
024100220706     C                   if        area = 0 or phone = 0
024200220706     C                   movel     *blanks       bdhphn
024300220706     C                   else
024400220617     C                   movel     area          bdhphn
024500220617     C                   move      phone         bdhphn
024600220706     C                   endif
024700220706      *
024800220617     C                   movel     addr1         bdadr1
024900220617     C                   movel     addr2         bdadr2
025000220617     C                   movel     city          bdcity
025100220617     C                   movel     state         bdst
025200220617     C                   eval      bdzip = zip
025300220705      *
025400220617     C                   movel     'No '         bdhand
025500220617     C                   if        hndicp <> ' '
025600220617     C                   movel     'Yes'         bdhand
025700220617     C                   endif
025800220705      *
025900220617     C                   eval      bddoh = empdt
026000220705      *
026100220617     C                   if        salary <> 0
026200220617     C                   eval      bdwage = salary
026300220617     C                   movel     'Anually'     bdwagf
026400220617     C                   endif
026500220705      *
026600220705     C                   movel     'Dental'      bdcovt
026700220705     C                   if        action = 'V'
026800220705     C                   movel     'Vision'      bdcovt
026900220705     C                   endif
027000220705      *
027001230301     C                   eval      bdplan = plplan
027002230301      *
0271002208290107  *      If first 5 chars of PDESCR = 'BEAM ' - use chars 6-40
027200220829     C                   if        descr5 = 'BEAM '
027300220829     C                   movel     descr6        bdpoln
027400220829     C                   else
027500220829     C                   movel     pdescr        bdpoln
027600220829     C                   endif
027700220617      *
0278002206170107  *      Loop thru MCOV38 to locate all coverages for Mbr
027900220705     C                   z-add     99999999      enrdat
028000220705     C                   z-add     0             trmdat
028100220617     C     m38ky         setll     mcov38
028200220617     C                   dou       *in28 = '1'
028300220617     C     m38ky         reade     mcov38                                 28
028400220617     C                   if        *in28 = '0'
028500220617      *
028600220617     C                   if        xenrldt = xcandt
028700220617     C                   iter
028800220617     C                   endif
028900220617      *
029000220622     C                   if        xenrldt < enrdat
029100220622     C                   z-add     xenrldt       enrdat
029200220622     C                   endif
029300220705      *
029400220705     C                   if        xcandt = 0
029500220705     C                   z-add     99999999      trmdat
029600220705     C                   else
029700220705     C                   if        trmdat <> 99999999
0298002207050296 C                   If        xcandt > trmdat
029900220617     C                   z-add     xcandt        trmdat
030000220617     C                   endif
030100220705     C                   endif
030200220617     C                   endif
030300220705      *
030400220622     C                   endif
030500220622      *
030600220622     C                   enddo
030700220622      *
030800230410     C*****              z-add     enrdat        bdefdt    ****
030801230410     C                   z-add     frmdat        bdefdt
030900220622     C                   z-add     trmdat        bdtmdt
031000220622      *
031100220622      *      Mbr Ext file data
031200220622     C     mcssno        chain     memextp                            32
031300220622     C                   if        *in32 = '0'
0314002206220107  *
031500220705     C                   eval      bdsmok = mesmoke
031600220622     C                   eval      bdwgef = mesaldt
031700220622     C                   movel     meocc         bdtitl
031800220622      *
031900220622     C                   endif
032000220622      *
032100220622      *
032200220622     C                   write     bdeligr
032300220622      *
032400220622     C                   endif
032500220622      *
032600070220     C                   endsr
0327000205170107  ********************************************************************************
0328000205170107  *
0329000903130107  *     BLDDEP - Build Record - Dependent data
0330000205170107  *
0331000205170107  ********************************************************************************
033200020517     C     blddep        begsr
033300080611      *
033400020517     C     dpkey         chain     depndc                             33
033500020517     C                   if        *in33 = '0'
0336000702200107  *       Build Dep rec
033700220622     C                   movel     svgrp         bdgrp#
033800220622     C                   movel     mbssno        bdessn
033900220707      *
034000220707     C                   movel     *blanks       bdissn
034100220707     C                   if        depss# <> 0
034200220622     C                   movel     depss#        bdissn
034300220707     C                   endif
034400220707      *
034500220705     C                   eval      bddseq = dpseq#
034600220705      *
034700220622     C                   if        drelcd = 'RHU' or drelcd = 'RWI'
034800220622     C                   movel(P)  'Spouse'      bdrel
034900220622     C                   else
035000220622     C                   movel(P)  'Child'       bdrel
035100220622     C                   endif
035200220622      *
035300220622     C                   movel     dfname        bdfnme
035400220622     C                   movel     dmi           bdmi
035500220622     C                   movel     dlname        bdlnme
035600220622     C                   eval      bdgndr = dsex
035700220622     C                   eval      bdbrdt = dbirth
035800220705     C                   eval      bdfnme = dfname
035900220705     C                   eval      bdlnme = dlname
036000220705     C                   eval      bdmi = dmi
036100220705     C                   eval      bdgndr = dsex
036200220705     C                   eval      bdbrdt = dbirth
036300220622     C                   movel     daddr1        bdadr1
036400220622     C                   movel     daddr2        bdadr2
036500220622     C                   movel     dcity         bdcity
036600220705     C                   movel     dstate        bdst
036700220622     C                   eval      bdzip = dzip
036800220706      *
036900220706     C                   if        darea = 0 or dphone = 0
037000220706     C                   movel     *blanks       bdhphn
037100220706     C                   else
037200220624     C                   movel     darea         bdhphn
037300220624     C                   move      dphone        bdhphn
037400220706     C                   endif
037500220705      *
037600220705     C                   movel     'No '         bdhand
037700220705     C                   if        dhndcp <> ' '
037800220705     C                   movel     'Yes'         bdhand
037900220705     C                   endif
038000220705      *
038100230301     C                   movel     *blanks       bdtitl
038200230301     C                   movel     *blanks       bdwagf
038300230301     C                   movel     *blanks       bdemal
038400230301     C                   z-add     0             bdwage
038500230301     C                   z-add     0             bdwgef
038600230301     C                   z-add     0             bddoh
038700230301      *
038800220829     C                   eval      bdefdt = denrdt
038900220829     C                   eval      bdtmdt = ccandt
039000220829      *
039100220829     C                   write     bdeligr
0392002208290111  *
039300220829     C                   endif
0394002208290111  *
039500220829     C                   endsr
