0001000204020002  *****************************************************************************
000200070208      * DENBLDGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400070220      *            DATE - 12/2006                                                 *
000500070208      *  DESCRIPTION - Build Denex Dental coverage file from GBS files            *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900070306      *  RLJ 03/05/2007 Select only Novo1 mbrs
001000070618      *  RLJ 06/18/2007 Add Cesar Chavez PS Charter mbrs - 590-007-0009
001100070821      *  RLJ 08/21/2007 Use GROUP fld from GRATE to assign values
001200080414      *  RLJ 04/14/2008 Make term dates be last day of month
001300090402      *  RLJ 04/02/2009 Add new fields for new file layout
001400110427      *  RLJ 04/27/2011 Treat covtyp PC the same as P2
001500020402      *                                                                *
0016009102150018 F******************************************************************
0017000610240020 Fplnmstn1  IF   E           K DISK
0018000610240020 Fgrat25    IF   E           K DISK
0019000707110020 Fmcov39    IF   E           K DISK
0020001707180020 Fmcovc16   IF   E           K DISK    RENAME(MCOVR:MC16R)
0021001707180020 F                                     PREFIX(X)
0022000205170020 Fmember    IF   E           K DISK
0023000205170020 Fdepndc    IF   E           K DISK
0024000205170020 Fdcov      IF   E           K DISK
0025000806260020 Fdxxrefp   IF   E           K DISK
0026000702200020 F***ddelwkgp  UF A E           K DISK
0027000806110020 Fdxcuxp    O    E             DISK
0028000702200029  *
0029000702200250 D                 DS
0030000702200251 D  zip                    1      9  0
0031000702200251 D    mzip5                1      5
0032000702200251 D    mzip4                6      9
0033000702200029  *
0034000702200250 D                 DS
0035000702200251 D  dzip                   1      9  0
0036000702200251 D    dzip5                1      5
0037000702200251 D    dzip4                6      9
0038000610240029  *
0039000610240250 D                 DS
0040000610240251 D  datymd                 1      8  0
0041000610240251 D    ymdcc                1      2  0
0042000610240251 D    ymdyy                3      4  0
0043000205070251 D    ymdmd                5      8  0
0044000702200029  *
0045000702200250 D                 DS
0046000702200251 D  gbsphn                 1      7  0
0047000702200251 D   gbphn3                1      3
0048000702200251 D   gbphn4                4      7
0049000702200029  *
0050000702200250 D                 DS
0051000702200251 D  dxphn                  1     14
0052000702200251 D   dxarea                1      3
0053000702200251 D   dxp1                  4      4    INZ('-')
0054000702200251 D   dxph3                 5      7
0055000702200251 D   dxp2                  8      8    INZ('-')
0056000702200251 D   dxph4                 9     12
0057000205170250 D                 DS
0058000205210251 D  savrat                        1    INZ(' ')
0059000905010251 D  wrtrc                         1    INZ('N')
0060000702160251 D  todaa                         2  0
0061001707180251 D  sveff                              LIKE(enrldt)
0062001707180251 D  svtrm                              LIKE(candt)
0063001707180251 D  kcarr                              LIKE(PCARR)
0064000707110251 D  svssno                             LIKE(mcssno)
0065000707110251 D                                     INZ(999999999)
0066000702160250 D                 DS
0067000702160251 D  ISOdate        S               D
0068000205210251 D  ISOnum         S              8  0
0069000205210251 D  MDYdate        S               D   DATFMT(*MDY)
007000080414     D  wkday          S               D     inz
0071000205240251 D  enrdat         S              8  0
0072000205240251 D  trmdat         S              8  0
0073000205210250 D                 DS
0074000702080251 D  gbsdat                 1      8  0
0075000702080251 D   gccmm                 1      4
0076000702080251 D   gmmdd                 5      8
0077000804140251 D   gbdy                  7      8
0078000702080250 D                 DS
0079000702080251 D  dxdat                  1      8
0080000702080251 D   dmmdd                 1      4
0081000804140251 D   dxddd                 3      4
0082000702080251 D   dccmm                 5      8
0083000205310250 D                 DS
0084000905010251 D  dat30                  1      8  0
0085000205210251 D    strtda               7      8  0
0086000205210251 D  dftend                 9     16  0
0087000205210251 D    endda               15     16  0
0088000205210251 D  mdystrt               17     22  0
0089000205210251 D   strta                17     22
0090000205210251 D  mdyend                23     28  0
0091000205210251 D   enda                 23     28
009200020517      *
009300061024     C     grkey         klist
009400061024     C                   kfld                    pltrst
009500061024     C                   kfld                    plsub#
009600061024     C                   kfld                    plplan
009700080626      *
009800080626     C     xrefky        klist
009900080626     C                   kfld                    mbtrst
010000080626     C                   kfld                    mbsub#
010100080626     C                   kfld                    mbacct
010200020517      *
010300020517     C     xrkey         klist
010400020517     C                   kfld                    mctrst
010500020517     C                   kfld                    mcsub#
010600020517     C                   kfld                    acc#
010700170718      *
010800170718     C     c16ky         klist
010900170718     C                   kfld                    mctrst
011000170718     C                   kfld                    mcsub#
011100170718     C                   kfld                    acc#
011200170718     C                   kfld                    mcssno
011300170718     C                   kfld                    mcplan
011400020517      *
011500020517     C     dpkey         klist
011600020517     C                   kfld                    ssno
011700020517     C                   kfld                    dseq#
011800020517      *
011900020503      ******************************************************************************
012000020517      *      MainLine
0121000905011304  *         Set dat30 - 30 days beyond cur date
012200020521     C                   move      UDATE         ISOdate
012300090501     C                   subdur    31:*D         ISOdate
012400020521     C                   move      ISOdate       ISOnum
012500090501     C                   eval      dat30 = isonum
0126000204260111  *
0127000702080107  *      Loop thru PLNMST looking for Carrier = 'DNX'
012800070208     C                   eval      kcarr = 'DNX'
012900061024     C     kcarr         setll     plnmstn1
013000061024     C                   dou       *in23 = '1'
013100061024     C     kcarr         reade     plnmstn1                               23
013200080414     C                   if        *in23 = '0'
0133002105050111  *
013400210505     C                   if        sfadm = 'Y'
013500210505     C                   iter
013600210505     C                   endif
0137002105050111  *
0138000706150111  *
013900080414     C                   if        (*in23 = '0' and pltrst = 900 and
014000080414     C                             plsub# = 108)
014100071213     C                   eval      dxgrp# = dxgrp#
014200071213     C                   endif
0143000610240111  *
0144000707110107  *      Loop thru MCOV39 to locate all mbrs
014500070711     C     grkey         setll     mcov39
014600061024     C                   dou       *in21 = '1'
014700070711     C     grkey         reade     mcov39                                 21
014800070821     C                   if        *in21 = '0'
0149001707180107  *      Bypass same day terms
015000170718     C                   if        enrldt = candt
015100170718     C                   iter
015200170718     C                   endif
0153001707180107  *
0154000803190107  *      Debug shit
015500170712     C                   if        mcssno = 214279745 or
015600170712     C                             mcssno = 214279745
015700070711     C                   eval      mcssno = mcssno
015800020524     C                   endif
0159000205240107  *
0160001006210107  *      If Roll Off Express - ignore certain records
016100100621     C                   if        mctrst = 301 and mcsub# = 4 and
016200100621     C                             mcplan = 'DAAA' and acc# = 1 and
016300100621     C                             enrldt = 20100501 and candt = 20100501
016400070711     C                   iter
016500070711     C                   endif
0166001006210107  *
0167001006210107  *      If same ssn - bypass
016800100621     C                   if        svssno = mcssno
016900100621     C                   iter
017000100621     C                   endif
0171000707110107  *
017200090501     C                   if        candt = 0 or
017300090501     C                             candt > dat30
017400101007     C                   eval      svssno = mcssno
017500020524     C                   exsr      bldmbr
0176000902160107  *       See if Plan is termed in Denex
017700090216     C                   if        dxftpid <> 'XX              '
0178000610250107  *      Loop thru DCOV to locate all Delta dependents
017900020517     C     mcssno        setll     dcov
018000020517     C                   dou       *in22 = '1'
018100020517     C     mcssno        reade     dcov                                   22
018200020517     C                   if        *in22 = '0'
018300070713      *
018400061025     C                   if        mcssno = ssno and dvplan = plplan
018500090501     C                   if        ccandt = 0 or
018600090501     C                             ccandt > dat30
018700090429     C                   exsr      blddep
018800090429     C                   endif
018900090501     C                   endif
019000090429     C                   else
019100090429     C                   leave
019200020517     C                   endif
019300020517     C                   enddo
019400020517     C                   endif
019500090216     C                   endif
019600090501     C                   endif
019700020517     C                   enddo
019800080414     C                   endif
019900070821     C                   enddo
020000020517     C                   movel     '1'           *inlr
020100020517     C                   return
0202000204020107  ********************************************************************************
0203000204020107  *
0204000702080107  *     BLDMBR - Build Record - Member data
0205000204020107  *
0206000204020107  ********************************************************************************
020700020517     C     bldmbr        begsr
020800070208      *
020900020517     C     mcssno        chain     member                             31
021000020517     C                   if        *in31 = '0'
0211000902160107  *       Build Record - Member Data
021200090216     C                   eval      dxfnme = mfname
021300070208     C                   eval      dxlnme = mlname
021400070208     C                   eval      dxmi = mmi
021500070208     C                   eval      dxsex = sex
021600070208     C                   eval      gbsdat = birth
021700070208     C                   eval      dccmm = gccmm
021800070208     C                   eval      dmmdd = gmmdd
021900070208     C                   eval      dxdob = dxdat
022000070208     C                   eval      dxadd1 = addr1
022100070208     C                   eval      dxadd2 = addr2
022200070208     C                   eval      dxcity = city
022300070208     C                   eval      dxst = state
022400070208     C                   eval      dxzip = mzip5
022500070208     C                   eval      dxz4 = mzip4
022600070220     C                   movel     area          dxarea
022700070220     C                   move      phone         gbsphn
022800070220     C                   eval      dxph3  = gbphn3
022900070220     C                   eval      dxph4  = gbphn4
023000070220     C                   movel     mbssno        dxsssn
023100070220     C                   movel     mbssno        dxmssn
023200080414      *
023300070208     C                   if        mardt = 0
023400070208     C                   eval      dxmar = '1'
023500070208     C                   else
023600070208     C                   eval      dxmar = '2'
023700070208     C                   endif
023800070208     C                   eval      dxrelc = '0'
023900070220      *
024000070220     C                   eval      gbsdat = empdt
024100070220     C                   eval      dccmm = gccmm
024200070220     C                   eval      dmmdd = gmmdd
024300070220     C                   eval      dxdoh = dxdat
024400070220      *
024500070220     C                   eval      gbsdat = termdt
024600070220     C                   eval      dccmm = gccmm
024700070220     C                   eval      dmmdd = gmmdd
024800070220     C                   eval      dxdot = dxdat
024900070208      *
025000070208     C                   eval      dxtyp = *blanks
025100070208     C                   if        mcovtp = 'TIN'
025200070208     C                   eval      dxtyp = ' 1'
025300070208     C                   else
025400070208     C                   if        mcovtp = 'THW'
025500070208     C                   eval      dxtyp = ' 2'
025600070208     C                   else
025700070208     C                   if        mcovtp = 'TFA'
025800070208     C                   eval      dxtyp = ' 3'
025900070208     C                   else
026000110427     C                   if        mcovtp = 'TPC' or
026100110427     C                             mcovtp = 'TP2'
026200070208     C                   eval      dxtyp = '11'
026300070208     C                   endif
026400070208     C                   endif
026500070208     C                   endif
026600070208     C                   endif
026700090501      *
026800070220     C                   eval      dxstf = ' '
0269000702200107  *
027000090402     C                   eval      dxrect = 'U'
0271000905010107  *
027200090501     C                   movel     mbtrst        dxgrp#
027300090501     C                   movel(P)  mbsub#        dxpln
027400090501     C                   movel(P)  mbacct        dxftpid
0275000905010107  *
027600090501     C                   eval      wrtrc = 'N'
027700170717      *
027800170717     C     xrefky        chain     dxxrefp                            32
027900170717     C                   if        *in32 = '1'
028000170717     C                   eval      dxpln = dxpln
028100170717     C                   else
028200170718      *
028300090501     C                   movel(P)  drgrp#        dxgrp#
028400090501     C                   movel(P)  drpln         dxpln
028500090501     C                   movel(P)  drftpid       dxftpid
0286000905010107  *       Special code for SYSTCOM - 2 plans
028700090501     C                   if        mbtrst = 502 and mbsub# = 2 and
028800090501     C                             mbacct = 11 and mcplan = '3731'
028900090501     C                   movel(P)  '53'          dxpln
029000090501     C                   endif
0291000905010107  *       See if Plan is termed in Denex
029200090501     C                   if        dxftpid = 'XX              '
029300090501     C                   leavesr
029400090501     C                   endif
029500081013      *
0296001707180107  *      Loop thru MCOVC16 to get eff and term dates
029700170718     C                   eval      sveff = 99999999
029800170718     C                   eval      svtrm = 1
029900170718     C     c16ky         setll     mcovc16
030000170718     C                   dou       *in28 = '1'
030100170718     C                   read      mcovc16                                28
030200170718     C                   if        *in28 = '1' or mcssno <> xmcssno or
030300170718     C                             mcplan <> xmcplan
030400170718     C                   leave
030500170718     C                   endif
0306001707180107  *
0307001707180107  *      If enroll date and term date are equal => bypass record
030800170718     C                   if        xenrldt = xcandt
030900170718     C                   iter
031000170718     C                   endif
0311001707180107  *
031200170718     C                   if        xenrldt < sveff
031300170718     C                   z-add     xenrldt       sveff
031400170718     C                   endif
0315001707180107  *
031600170718     C                   if        svtrm <> 0
0317001707180107  *
0318001707180296 C                   If        xcandt = 0
031900170718     C                   z-add     0             svtrm
032000170718     C                   else
032100170718     C                   if        xcandt > svtrm
032200170718     C                   z-add     xcandt        svtrm
032300170718     C                   endif
032400170718     C                   endif
032500170718     C                   endif
032600170718      *
032700170718     C                   enddo
032800090501      *
032900170718     C                   eval      gbsdat = sveff
033000090501     C                   eval      dccmm = gccmm
033100090501     C                   eval      dmmdd = gmmdd
033200090501     C                   eval      dxeff = dxdat
033300090501      *
033400170718     C                   eval      gbsdat = svtrm
033500090501     C                   eval      dccmm = gccmm
033600090501     C                   eval      dmmdd = gmmdd
033700090501     C                   eval      dxtrm = dxdat
033800090501      *
033900080611     C                   write     dxcuxr
034000090501     C                   eval      wrtrc = 'Y'
034100070220      *
034200090501     C                   endif
034300090501      *
034400090501     C                   if        wrtrc = 'N'
034500090501     C                   write     dxcuxr
034600090501     C                   endif
034700090501      *
034800090501     C                   endif
034900090501      *
035000070220     C                   endsr
0351000205170107  ********************************************************************************
0352000205170107  *
0353000205170107  *     BLDDEP - Build Record ID = '2' - Dependent data
0354000205170107  *
0355000205170107  ********************************************************************************
035600020517     C     blddep        begsr
035700080611      *
035800020517     C     dpkey         chain     depndc                             33
035900020517     C                   if        *in33 = '0'
0360000702200107  *       Build Dep rec
036100070220     C                   eval      dxfnme = dfname
036200070220     C                   eval      dxlnme = dlname
036300070220     C                   eval      dxmi = dmi
036400070220     C                   eval      dxsex = dsex
036500070220     C                   eval      gbsdat = dbirth
036600070220     C                   eval      dccmm = gccmm
036700070220     C                   eval      dmmdd = gmmdd
036800070220     C                   eval      dxdob = dxdat
036900070220     C                   eval      dxadd1 = daddr1
037000070220     C                   eval      dxadd2 = daddr2
037100090429     C                   eval      dxcity = dcity
037200090429     C                   eval      dxst = dstate
037300090429     C                   eval      dxzip = dzip5
037400090429     C                   eval      dxz4 = dzip4
037500090429     C                   movel     darea         dxarea
037600070220     C                   move      dphone        gbsphn
037700090429     C                   eval      dxph3  = gbphn3
037800090429     C                   eval      dxph4  = gbphn4
037900090429     C                   movel     depss#        dxmssn
038000090427     C****               movel     depss#        dxmbid
038100070220     C                   eval      dxmar = ' '
038200070220     C                   if        drelcd = 'RHU' or drelcd = 'RWI'
038300070220     C                   eval      dxrelc = '1'
038400070220     C                   else
038500070220     C                   eval      dxrelc = '2'
038600070220     C                   endif
038700070220      *
038800070226     C                   eval      dxmar = '0'
038900070220     C                   eval      dxdoh = *blanks
039000070220     C                   eval      dxdot = *blanks
039100070220      *
039200070220     C                   eval      dxstf = '0'
039300070220     C                   if        dstudn = 'Y'
039400070220     C                   eval      dxstf = ' 1'
039500070220     C                   endif
039600090402      *
039700090402     C                   eval      dxrect = 'U'
0398000905010107  *
039900090501     C                   movel     mbtrst        dxgrp#
040000090501     C                   movel(P)  mbsub#        dxpln
040100090501     C                   movel(P)  mbacct        dxftpid
0402000905010107  *
040300090501     C                   eval      wrtrc = 'N'
040400170717     C     xrefky        chain     dxxrefp                            32
040500170717     C                   if        *in32 = '1'
040600170717     C                   eval      dxpln = dxpln
040700170717     C                   else
0408001707180107  *
040900090501     C                   movel(P)  drgrp#        dxgrp#
041000090501     C                   movel(P)  drpln         dxpln
041100090501     C                   movel(P)  drftpid       dxftpid
0412000905010107  *       Special code for SYSTCOM - 2 plans
041300090501     C                   if        mbtrst = 502 and mbsub# = 2 and
041400090501     C                             mbacct = 11 and mcplan = '3731'
041500090501     C                   movel(P)  '53'          dxpln
041600090501     C                   endif
0417000905010107  *       See if Plan is termed in Denex
041800090501     C                   if        dxftpid = 'XX              '
041900090501     C                   leavesr
042000090501     C                   endif
042100090501      *
042200090610     C                   eval      gbsdat = denrdt
042300090501     C                   eval      dccmm = gccmm
042400090501     C                   eval      dmmdd = gmmdd
042500090501     C                   eval      dxeff = dxdat
042600090501      *
042700090610     C                   eval      gbsdat = ccandt
042800090501     C                   eval      dccmm = gccmm
042900090501     C                   eval      dmmdd = gmmdd
043000090501     C                   eval      dxtrm = dxdat
043100090501      *
043200090501     C                   write     dxcuxr
043300090501     C                   eval      wrtrc = 'Y'
043400090501      *
043500090501     C                   endif
043600090501      *
043700090501     C                   if        wrtrc = 'N'
043800090501     C                   write     dxcuxr
043900090501     C                   endif
044000090501      *
044100020517     C                   endif
0442000205170111  *
044300020517     C                   endsr
