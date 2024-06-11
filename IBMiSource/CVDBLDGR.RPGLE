0001000204020002  *****************************************************************************
000200090313      * CVDBLDGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400090313      *            DATE - 03/2009                                                 *
000500090714      *  DESCRIPTION - Build Coventry Dental coverage file from GBS files         *
000600020426      *
0007000204020002  *****************************************************************************
0008000909100015  *  Change Log:                                                              *
000900100907      *  rlj 09/07/2010 Bypass 300-6-138 per Andrea/Amy Luthardt
001000110428      *  RLJ 04/28/2011 Treat covtyp PC the same as P2 per S Rapski
001100110817      *  RLJ 08/17/2011 If dep's eff dt is prior to mbr's, set dep's eff
001200110817      *                 to that of the mbr - per Andrea Rose
001300090714      *                                                                *
0014009102150018 F******************************************************************
0015000909100020 Fplnmstn1  IF   E           K DISK
0016000909100020 Fgrat25    IF   E           K DISK
0017000909100020 Fmcov39    IF   E           K DISK
0018000205240020 Fmcov38    IF   E           K DISK    RENAME(MCOVR:MC38R)
0019000703050020 F                                     PREFIX(X)
0020000205170020 Fmember    IF   E           K DISK
0021000205170020 Fdepndc    IF   E           K DISK
0022000205170020 Fdcov      IF   E           K DISK
0023000903130020 Fcdxrefp   IF   E           K DISK
0024000702200020 F***ddelwkgp  UF A E           K DISK
0025000903130020 Fcdcurp    O    E             DISK
0026000205210029  *
0027000702200250 D                 DS
0028000702200251 D  zip                    1      9  0
0029000702200251 D    mzip5                1      5
0030000702200251 D    mzip4                6      9
0031000702200029  *
0032000702200250 D                 DS
0033000702200251 D  dzip                   1      9  0
0034000909110251 D    dzip5                1      5
0035000909110251 D    dzip4                6      9
0036000909110029  *
0037000909110250 D                 DS
0038000909110251 D  datymd                 1      8  0
0039000909110251 D    ymdcc                1      2  0
0040000610240251 D    ymdyy                3      4  0
0041000205070251 D    ymdmd                5      8  0
0042000702200029  *
0043000702200250 D                 DS
0044000702200251 D  gbsphn                 1      7  0
0045000702200251 D   gbphn3                1      3
0046000702200251 D   gbphn4                4      7
0047000702200029  *
0048000702200250 D                 DS
0049000903130251 D  cdphn                  1     14
0050000903130251 D   cdarea                1      3
0051000903130251 D   cdp1                  4      4    INZ('-')
0052000903130251 D   cdph3                 5      7
0053000903130251 D   cdp2                  8      8    INZ('-')
0054000903130251 D   cdph4                 9     12
0055000205170250 D                 DS
0056000205210251 D  cntspc                        2  0 INZ(0)
0057000205210251 D  cntkid                        2  0 INZ(0)
0058000205210251 D  savrat                        1    INZ(' ')
0059000702160251 D  todaa                         2  0
0060000702160251 D  kcarr                              LIKE(PCARR)
0061000707110251 D  svssno                             LIKE(mcssno)
0062000707110251 D                                     INZ(999999999)
0063000702160250 D                 DS
0064000702160251 D  ISOdate        S               D
0065000205210251 D  ISOnum         S              8  0
0066000205210251 D  MDYdate        S               D   DATFMT(*MDY)
006700080414     D  wkday          S               D     inz
0068001108170251 D  memeff         S              8  0
0069001108170251 D  enrdat         S              8  0
0070000205240251 D  trmdat         S              8  0
0071000205210250 D                 DS
0072000702080251 D  gbsdat                 1      8  0
0073000702080251 D   gccmm                 1      4
0074000702080251 D   gmmdd                 5      8
0075000804140251 D   gbdy                  7      8
0076000702080250 D                 DS
0077000702080251 D  dxdat                  1      8
0078000702080251 D   dmmdd                 1      4
0079000804140251 D   dxddd                 3      4
0080000702080251 D   dccmm                 5      8
0081000205310250 D                 DS
0082000205310251 D  dftstrt                1      8  0
0083000205210251 D    strtda               7      8  0
0084000205210251 D  dftend                 9     16  0
0085000205210251 D    endda               15     16  0
0086000205210251 D  mdystrt               17     22  0
0087000205210251 D   strta                17     22
0088000205210251 D  mdyend                23     28  0
0089000205210251 D   enda                 23     28
009000020517      *
009100061024     C     grkey         klist
009200061024     C                   kfld                    pltrst
009300061024     C                   kfld                    plsub#
009400061024     C                   kfld                    plplan
009500080626      *
009600080626     C     xrefky        klist
009700080626     C                   kfld                    mbtrst
009800080626     C                   kfld                    mbsub#
009900080626     C                   kfld                    mbacct
010000020517      *
010100020517     C     xrkey         klist
010200020517     C                   kfld                    mctrst
010300020517     C                   kfld                    mcsub#
010400020517     C                   kfld                    acc#
010500020517      *
010600020517     C     dpkey         klist
010700020517     C                   kfld                    ssno
010800020517     C                   kfld                    dseq#
010900020524      *
011000020524     C     m38ky         klist
011100020524     C                   kfld                    mcssno
011200020524     C                   kfld                    mdseq#
011300020524     C                   kfld                    mctrst
011400020524     C                   kfld                    mcsub#
011500020524     C                   kfld                    mcplan
011600020517      *
011700020503      ******************************************************************************
011800020517      *      MainLine
0119000205211304  *         Calculate default action dates
012000020521     C                   move      UDATE         ISOdate
012100020521     C                   move      ISOdate       ISOnum
012200020521     C                   extrct    ISOdate:*D    todaa
012300020521     C                   if        todaa > 25
012400020521     C                   adddur    10:*D         ISOdate
012500020521     C                   endif
012600020521     C                   move      ISOdate       dftstrt
012700020521     C                   z-add     01            strtda
012800020521     C                   move      dftstrt       ISOdate
012900070302     C                   eval      MDYdate = ISOdate
013000070302     C                   move      MDYdate       mdystrt
013100070302     C                   move      dftstrt       ISOdate
013200070302     C                   adddur    1:*M          ISOdate
013300070302     C                   subdur    1:*D          ISOdate
013400070302     C                   move      ISOdate       dftend
013500070302     C                   eval      MDYdate = ISOdate
013600020521     C                   move      MDYdate       mdyend
0137000702081304  *
0138000204260111  *
0139000903130107  *      Loop thru PLNMST looking for Carrier = 'COD'
014000090313     C                   eval      kcarr = 'COD'
014100061024     C     kcarr         setll     plnmstn1
014200061024     C                   dou       *in23 = '1'
014300061024     C     kcarr         reade     plnmstn1                               23
014400080414     C                   if        *in23 = '0'
0145000706150111  *
014600210505     C                   if        sfadm = 'Y'
014700210505     C                   iter
014800071213     C                   endif
0149002105050111  *
015000210505     C                   if        (*in23 = '0' and pltrst = 900 and
015100210505     C                             plsub# = 108)
015200210505     C                   eval      crgrp# = crgrp#
015300210505     C                   endif
0154002105050111  *
0155000707110107  *      Loop thru MCOV39 to locate all mbrs
015600070711     C     grkey         setll     mcov39
015700061024     C                   dou       *in21 = '1'
015800090313     C     grkey         reade     mcov39                                 21
015900090313     C                   if        *in21 = '0'
0160000803190107  *      Debug shit
016100110817     C                   if        mcssno = 215640230 or
016200110817     C                             mcssno = 213063847
016300070711     C                   eval      mcssno = mcssno
016400020524     C                   endif
0165000205240107  *
0166000707130107  *      If enroll date and term date are equal => sub 1 from trm date
016700070711     C                   if        enrldt = candt
016800070713     C                   move      candt         ISOdate
016900070713     C                   subdur    1:*D          ISOdate
017000070713     C                   move      ISOdate       candt
017100070711     C                   endif
0172000707110107  *      If same ssn - bypass
017300070711     C                   if        svssno = mcssno
017400070711     C                   iter
017500070711     C                   endif
017600070711     C                   eval      svssno = mcssno
0177000707110107  *
017800020524     C                   exsr      bldmbr
0179000903130107  *       See if Plan is termed in Coventry
018000090313     C                   if        crftpid <> 'XX              '
0181000610250107  *      Loop thru DCOV to locate all Delta dependents
018200020517     C     mcssno        setll     dcov
018300020517     C                   dou       *in22 = '1'
018400020517     C     mcssno        reade     dcov                                   22
018500020517     C                   if        *in22 = '0'
0186000707130107  *      If enroll date and term date are equal => sub 1 frm trm date
018700020524     C                   if        denrdt = ccandt
018800070713     C                   move      ccandt        ISOdate
018900070713     C                   subdur    1:*D          ISOdate
019000070713     C                   move      ISOdate       ccandt
019100070713     C                   endif
019200070713      *
019300061025     C                   if        mcssno = ssno and dvplan = plplan
019400020517     C                   exsr      blddep
019500020517     C                   endif
019600020517     C                   else
019700020517     C                   leave
019800020517     C                   endif
019900020517     C                   enddo
020000020517     C                   endif
020100070821     C                   endif
020200090313     C                   enddo
020300080414     C                   endif
020400070821     C                   enddo
020500020517     C                   movel     '1'           *inlr
020600020517     C                   return
0207000204020107  ********************************************************************************
0208000204020107  *
0209000702080107  *     BLDMBR - Build Record - Member data
0210000204020107  *
0211000204020107  ********************************************************************************
021200020517     C     bldmbr        begsr
021300070208      *
021400080611     C                   if        candt <> 0 and
021500080627     C                             candt < 20080101
021600080611     C                   leavesr
021700080611     C                   endif
021800080611      *
021900020521     C                   eval      cntspc = 0
022000020521     C                   eval      cntkid = 0
022100020517     C     mcssno        chain     member                             31
022200020517     C                   if        *in31 = '0'
022300090313     C     xrefky        chain     cdxrefp                            32
022400080626     C                   if        *in32 = '1'
022500090313     C                   eval      cdfnme = cdfnme
022600090313     C                   movel(P)  'XXX'         cdgrp#
022700090313     C                   movel     mbtrst        cdgrp#
022800090313     C                   movel(P)  mbsub#        cdpln
022900090313     C                   movel(P)  mbacct        cdftpid
023000080626     C                   else
023100090313     C                   movel(P)  crgrp#        cdgrp#
023200090313     C                   movel(P)  crpln         cdpln
023300090313     C                   movel(P)  crftpid       cdftpid
023400080626     C                   endif
0235000903130107  *       See if Plan is termed in Coventry
023600090313     C                   if        cdftpid = 'XX              '
023700090216     C                   leavesr
023800090216     C                   endif
0239000902160107  *       Build Record - Member Data
024000090313     C                   eval      cdfnme = mfname
024100090313     C                   eval      cdlnme = mlname
024200090313     C                   eval      cdmi = mmi
024300090313     C                   eval      cdsex = sex
024400090313     C                   eval      gbsdat = birth
024500070208     C                   eval      dccmm = gccmm
024600070208     C                   eval      dmmdd = gmmdd
024700090313     C                   eval      cddob = dxdat
024800090313     C                   eval      cdadd1 = addr1
024900090313     C                   eval      cdadd2 = addr2
025000090313     C                   eval      cdcity = city
025100090313     C                   eval      cdst = state
025200090313     C                   eval      cdzip = mzip5
025300090313     C                   eval      cdz4 = mzip4
025400090313     C                   movel     area          cdarea
025500070220     C                   move      phone         gbsphn
025600090313     C                   eval      cdph3  = gbphn3
025700090313     C                   eval      cdph4  = gbphn4
025800090313     C                   movel     mbssno        cdsssn
025900090313     C                   movel     mbssno        cdmssn
026000090427     C****               movel     mbssno        cdemid
026100090427     C****               movel     mbssno        cdmbid
026200070208     C                   eval      gbsdat = enrldt
026300081013      *
026400090313     C                   if        crrdat > enrldt
026500090313     C                   eval      gbsdat = crrdat
026600081013     C                   endif
026700081013      *
026800110817     C                   eval      memeff = gbsdat
026900110817      *
027000070208     C                   eval      dccmm = gccmm
027100070208     C                   eval      dmmdd = gmmdd
027200090313     C                   eval      cdeff = dxdat
027300080414      *
027400070208     C                   eval      gbsdat = candt
027500080414     C                   if        gbdy  = '01'
027600080414     C                   movel     gbsdat        wkday
027700080414     C                   subdur    1:*D          wkday
027800080414     C                   movel     wkday         gbsdat
027900080414     C                   endif
028000070208     C                   eval      dccmm = gccmm
028100070208     C                   eval      dmmdd = gmmdd
028200090313     C                   eval      cdtrm = dxdat
028300080414      *
028400070208     C                   if        mardt = 0
028500090313     C                   eval      cdmar = '1'
028600070208     C                   else
028700090313     C                   eval      cdmar = '2'
028800070208     C                   endif
028900090313     C                   eval      cdrelc = '0'
029000070220      *
029100070220     C                   eval      gbsdat = empdt
029200070220     C                   eval      dccmm = gccmm
029300070220     C                   eval      dmmdd = gmmdd
029400090313     C                   eval      cddoh = dxdat
029500070220      *
029600070220     C                   eval      gbsdat = termdt
029700070220     C                   eval      dccmm = gccmm
029800070220     C                   eval      dmmdd = gmmdd
029900090313     C                   eval      cddot = dxdat
030000070208      *
030100090313     C                   eval      cdtyp = *blanks
030200070208     C                   if        mcovtp = 'TIN'
030300090313     C                   eval      cdtyp = ' 1'
030400070208     C                   else
030500070208     C                   if        mcovtp = 'THW'
030600090313     C                   eval      cdtyp = ' 2'
030700070208     C                   else
030800070208     C                   if        mcovtp = 'TFA'
030900090313     C                   eval      cdtyp = ' 3'
031000070208     C                   else
031100110428     C                   if        mcovtp = 'TPC' or
031200110428     C                             mcovtp = 'TP2'
031300090313     C                   eval      cdtyp = '11'
031400070208     C                   endif
031500070208     C                   endif
031600070208     C                   endif
031700070208     C                   endif
031800070212      *
0319000702200107  *      Loop thru MCOV38 to locate all coverages for Mbr
032000020524     C     m38ky         setll     mcov38
032100020524     C                   dou       *in28 = '1'
032200020524     C     m38ky         reade     mcov38                                 28
032300020524     C                   if        *in28 = '0'
032400070220      *
032500070220     C                   if        xenrldt = enrldt and xcandt = candt
032600070220     C                   iter
032700070220     C                   endif
032800070220      *
032900070220     C                   eval      xenrldt = xenrldt
033000070220     C*                  if        xenrldt < enrdat
033100070220     C*                  z-add     xenrldt       enrdat
033200070220     C*                  endif
033300070220     C*                  if        trmdat <> 0
0334000702200296 C*                  If        xcandt > trmdat or
0335000702200296 C*                            xcandt = 0
033600070220     C*                  z-add     xcandt        trmdat
033700070220     C*                  endif
033800070220     C*                  endif
033900020524     C                   endif
034000070220     C                   enddo
034100070220     C                   endif
0342000205240107  *
034300090313     C                   eval      cdstf = ' '
0344000702200107  *
034500090313     C                   eval      cdrect = 'U'
034600081013      *
034700090313     C                   write     cdcurr
034800070220      *
034900070220     C                   endsr
0350000205170107  ********************************************************************************
0351000205170107  *
0352000903130107  *     BLDDEP - Build Record - Dependent data
0353000205170107  *
0354000205170107  ********************************************************************************
035500020517     C     blddep        begsr
035600080611      *
035700080611     C                   if        ccandt <> 0 and
035800080627     C                             ccandt < 20080101
035900080611     C                   leavesr
036000080611     C                   endif
036100080611      *
036200020517     C     dpkey         chain     depndc                             33
036300020517     C                   if        *in33 = '0'
0364000702200107  *       Build Dep rec
036500090313     C                   eval      cdfnme = dfname
036600090313     C                   eval      cdlnme = dlname
036700090313     C                   eval      cdmi = dmi
036800090313     C                   eval      cdsex = dsex
036900070220     C                   eval      gbsdat = dbirth
037000070220     C                   eval      dccmm = gccmm
037100070220     C                   eval      dmmdd = gmmdd
037200090313     C                   eval      cddob = dxdat
037300090313     C                   eval      cdadd1 = daddr1
037400090313     C                   eval      cdadd2 = daddr2
037500090313     C                   eval      cdcity = dcity
037600090313     C                   eval      cdst = dstate
037700090313     C                   eval      cdzip = dzip5
037800090313     C                   eval      cdz4 = dzip4
037900090313     C                   movel     darea         cdarea
038000070220     C                   move      dphone        gbsphn
038100090313     C                   eval      cdph3  = gbphn3
038200090313     C                   eval      cdph4  = gbphn4
038300090313     C                   movel     depss#        cdmssn
038400090427     C*****              movel     depss#        cdmbid
038500070220     C                   eval      gbsdat = denrdt
038600081013      *
038700090313     C                   if        crrdat > denrdt
038800090313     C                   eval      gbsdat = crrdat
038900081013     C                   endif
039000110817      *
039100110817     C                   if        memeff > gbsdat
039200110817     C                   eval      gbsdat = memeff
039300110817     C                   endif
039400081013      *
039500070220     C                   eval      dccmm = gccmm
039600070220     C                   eval      dmmdd = gmmdd
039700090313     C                   eval      cdeff = dxdat
039800070220     C                   eval      gbsdat = ccandt
039900070220     C                   eval      dccmm = gccmm
040000070220     C                   eval      dmmdd = gmmdd
040100090313     C                   eval      cdtrm = dxdat
040200090313     C                   eval      cdmar = ' '
040300070220     C                   if        drelcd = 'RHU' or drelcd = 'RWI'
040400090313     C                   eval      cdrelc = '1'
040500070220     C                   else
040600090313     C                   eval      cdrelc = '2'
040700070220     C                   endif
040800070220      *
040900090313     C                   eval      cdmar = '0'
041000090313     C                   eval      cddoh = *blanks
041100090313     C                   eval      cddot = *blanks
041200070220      *
041300090313     C                   eval      cdstf = '0'
041400070220     C                   if        dstudn = 'Y'
041500090313     C                   eval      cdstf = ' 1'
041600070220     C                   endif
041700070220      *
041800090313     C                   eval      cdrect = 'U'
041900090313      *
042000090313     C                   write     cdcurr
0421000205170111  *
042200020517     C                   endif
0423000205170111  *
042400020517     C                   endsr
