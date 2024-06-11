0001000204020002  *****************************************************************************
000200060524      * PRLIFEXR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400060427      *            DATE - 04/2006                                                 *
000500060427      *  DESCRIPTION - Build file for Principal Life Export                       *
000600060427      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900060427      *  xxx mm/dd/yyyy                                                           *
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012000204020019 FPLNMSTN1  IF   E           K DISK
001300020403     FMCOVXX    IF   E           K DISK
001400020404     FMEMBER    IF   E           K DISK
001500060504     FDEPENDL1  IF   E           K DISK
0016000605040020 FPLIFPLNP  UF A E           K DISK
0017000605040020 FPRLIFP    UF A E           K DISK
0018000204020025  *
0019009102150250 D                 DS
0020000605040251 D dssno                   1      9  0
0021000605040251 D dssnoa                  1      9
0022000605040025  *
0023000605040250 D                 DS
0024000605040251 D mcssno                  1      9  0
0025000605040251 D mcssnoa                 1      9
0026000605040025  *
0027000605040250 D                 DS
0028000605040251 D plzip9                  1      9  0
0029000605040251 D  plzip                  1      5
0030000605040251 D  plzip4                 6      9
0031000604270025  *
0032000604280250 D  EMPINFO        DS
0033000604280251 D    plbena                      9
0034000604280251 D    plsmst                      1
0035000605040251 D    plbnef                      8
0036000605040251 D    plcvtm                      8
0037000604280251 D    plmpln                      4
0038000604280025  *
0039000604280250 D  SPSINFO        DS
0040000604280251 D    psbena                      9
0041000604280251 D    pssmst                      1
0042000605040251 D    psdob                       8
0043000605040251 D    psbnef                      8
0044000605040251 D    pscvtm                      8
0045000604280251 D    plspln                      4
0046000604270025  *
0047000604270250 D  CHDINFO        DS
0048000604270251 D    pcbena                      9
0049000605040251 D    pcbnef                      8
0050000605040251 D    pccvtm                      8
0051000604280251 D    plcpln                      4
0052000604270025  *
0053000604270250 D                 DS
0054000604270251 D  cutoff                         D   DATFMT(*ISO)
0055000604270251 D  cutofn                        8S 0
0056000604270251 D  sal92                         9S 2
0057000604280251 D  c2pln                         4
0058000604280251 D  sps                           1
0059000604280251 D  deplif                        1
0060000605040251 D  trst600                       3  0 INZ(600)
0061000605040251 D  sub#3                         3  0 INZ(3)
006200020415      *
006300020613     C     mcvky         klist
006400060504     C                   kfld                    trst600
006500060504     C                   kfld                    sub#3
006600060504     C                   kfld                    pppln
006700060428      *
006800060428     C     mc2ky         klist
006900060428     C                   kfld                    mctrst
007000060428     C                   kfld                    mcsub#
007100060428     C                   kfld                    acc#
007200060428     C                   kfld                    mcssno
007300060428     C                   kfld                    c2pln
007400060428      *
007500060428     C     dexky         klist
007600060428     C                   kfld                    mcssno
0077000206130291  *   Preprocessing
0078000206130297 C                   movel     UDATE         cutoff
0079000206130291  * Determine Term date cutoff - 1 year ago
0080000204040297 C     cutoff        subdur    365:*D        cutoff
0081000204030297 C                   movel     cutoff        cutofn
0082000604270291  *   Set up file defaults
0083000604270297 C                   clear                   prlifr
0084000604270297 C                   eval      plrect = 'E'
0085000604270297 C                   eval      plctrc = 'H33530'
0086000605040297 C                   eval      plunit = '    1'
0087000605040297 C                   eval      pc0 = '0'
008800060504      *   Build Prin Life Plan file
0089000605040297 C     'PVL'         setll     plnmstn1                           21
0090000605040296 C                   dou       *in21 = '1'
0091000605040297 C                   read      plnmstn1                               21
0092000605040296 C                   If        *in21 = '0' and pldltd = 'A' and
0093000605040296 C                             pcarr = 'PVL' and
0094000605040296 C                             (plncat = 'PSL' or plncat = 'PNE' or
0095000605040296 C                             plncat = 'PSP' or plncat = 'PNS' or
0096000605040296 C                             plncat = 'PVD')
0097000605040296 C                   If        plncat = 'PSL' or plncat = 'PNE'
009800060504     C                   eval      pptyp = 'A'
009900060504     C                   endif
0100000605040296 C                   If        plncat = 'PSP' or plncat = 'PNS'
010100060504     C                   eval      pptyp = 'B'
010200060504     C                   endif
0103000605040296 C                   If        plncat = 'PVD'
010400060504     C                   eval      pptyp = 'C'
010500060504     C                   endif
010600060504     C                   eval      pppln = plplan
010700060504     C                   eval      ppcat = plncat
0108000605040296 C                   If        plncat = 'PSL' or plncat = 'PSP'
010900060504     C                   eval      ppsm = 'S'
011000060504     C                   else
011100060504     C                   eval      ppsm = 'N'
011200060504     C                   endif
011300060504     C                   eval      ppben = maxben
011400060504     C                   eval      ppdesc = pdescr
011500060504     C                   write     plifplnr
0116000605040291  *
011700060504     C                   endif
0118000605040291  *
0119000605040296 C                   If        pcarr > 'PVL'
0120000605040296 C                   leave
0121000605040297 C                   endif                                                  pcarr > 'EX2'
0122000605040291  *
0123000605040297 C                   enddo                                                  *in21 = '1'
0124000605040291  *
0125000605040291  * Main Line - Loop thru Prin Life Plan file
012600060504      *
0127000605040297 C     'A'           setll     plifplnp                           22
0128000605040296 C                   dou       *in22 = '1'
0129000605040297 C                   read      plifplnp                               22
0130000605040296 C                   If        *in22 = '0' and pptyp = 'A'
0131000605040291  *  MBR - Loop thru mcov file using T,S,P
0132000204030297 C     mcvky         setll     mcovxx                             31
0133000204020296 C                   dou       *in31 = '1'
0134000204030297 C     mcvky         reade     mcovxx                                 31
0135000605040296 C                   If        *in31 = '0' and mctrst = 600 and
0136000605040296 C                             mcsub# = 3 and mcplan = pppln and
0137000211040296 C                             (candt = 0 or candt > enrldt)
0138000204030291  *
0139000204030296 C                   If        candt = 0 or candt > cutofn
0140000204030291  *        Get member record
0141000204030297 C     mcssno        chain     member                             32
0142000204030296 C                   If        *in32 = '0'
0143000204020291  *
0144000204020291 C                   exsr      bldmbr
0145000204040291  *
0146000604270297 C                   endif                                                  *in33 = '1'
0147000204040291  *
0148000204040297 C                   endif                                                  *in32 = '0'
0149000204030291  *
0150000204040297 C                   endif                                                  candt = 0
0151000204020297 C                   enddo                                                  *in31 = '1'
0152000204020291  *
0153000605040297 C                   else                                                   *in22 = '0'
0154000605040291  *
0155000605040296 C                   If        *in22 = '0' and pptyp = 'B'
0156000605040291  *  SPS - Loop thru mcov file using T,S,P
0157000605040297 C     mcvky         setll     mcovxx                             31
0158000605040296 C                   dou       *in31 = '1'
0159000605040297 C     mcvky         reade     mcovxx                                 31
0160000605040296 C                   If        *in31 = '0' and mctrst = 600 and
0161000605040296 C                             mcsub# = 3 and mcplan = pppln and
0162000605040296 C                             (candt = 0 or candt > enrldt)
0163000605040291  *
0164000605040296 C                   If        candt = 0 or candt > cutofn
0165000605040291  *        Get member record
0166000605040297 C     mcssno        chain     member                             32
0167000605040296 C                   If        *in32 = '0'
0168000605040291  *
0169000605040291 C                   exsr      bldsps
0170000605040291  *
0171000605040297 C                   endif                                                  *in33 = '1'
0172000605040291  *
0173000605040297 C                   endif                                                  *in32 = '0'
0174000605040291  *
0175000605040297 C                   endif                                                  candt = 0
0176000605040297 C                   enddo                                                  *in31 = '1'
0177000605040291  *
0178000605040297 C                   else                                                   *in22 = '0'
0179000605040291  *
0180000605040296 C                   If        *in22 = '0' and pptyp = 'C'
0181000605040291  *  Child - Loop thru mcov file using T,S,P
0182000605040297 C     mcvky         setll     mcovxx                             31
0183000605040296 C                   dou       *in31 = '1'
0184000605040297 C     mcvky         reade     mcovxx                                 31
0185000605040296 C                   If        *in31 = '0' and mctrst = 600 and
0186000605040296 C                             mcsub# = 3 and mcplan = pppln and
0187000605040296 C                             (candt = 0 or candt > enrldt)
0188000605040291  *
0189000605040296 C                   If        candt = 0 or candt > cutofn
0190000605040291  *
0191000605040291 C                   exsr      bldchd
0192000605040291  *
0193000605040297 C                   endif                                                  *in32 = '0'
0194000605040291  *
0195000605040297 C                   endif                                                  candt = 0
0196000605040297 C                   enddo                                                  *in31 = '1'
0197000605040291  *
0198000605040297 C                   endif                                                  *in22 = '0'
0199000605040297 C                   endif                                                  *in22 = '0'
0200000605040297 C                   endif                                                  *in22 = '0'
0201000605040291  *
0202000605040297 C                   enddo                                                  *in21 = '1'
0203000605040291  *
0204000204020297 C                   movel     '1'           *inlr
0205000204020297 C                   return
0206000605040291  *
0207000605040107  ********************************************************************************
0208000204020107  *
0209000204020107  *     BLDMBR - Build Member record
0210000204020107  *
0211000204020107  ********************************************************************************
021200020402     C     bldmbr        begsr
0213000604270107  *
0214000604280296 C                   clear                   SPSINFO
0215000604280296 C                   clear                   CHDINFO
0216000604280296 C                   clear                   EMPINFO
0217000604280107  *
021800060504     C                   move      mbssno        plssn
021900060427     C                   movel     mlname        pllnme
022000060427     C                   movel     mfname        plfnme
022100060427     C                   move      mmi           plmi
022200060504     C                   move      birth         pldob
022300060427     C                   move      sex           plsex
022400060504     C                   move      empdt         pldoh
022500060524     C*****              move      termdt        plterm
022600060524     C                   eval      plterm = %EDITC(termdt:'M')
0227000604270107  *
0228000604270296 C                   If        termdt <> 0
022900060427     C                   If        termcd = 'DDD' or termcd = 'D5 '
023000060427     C                   eval      pltrmc = 'D'
023100060427     C                   else
023200060427     C                   eval      pltrmc = 'M'
023300060427     C                   endif
023400060427     C                   else
023500060427     C                   eval      pltrmc = ' '
023600060427     C                   endif
0237000303270107  *
023800060427     C                   movel(P)  addr1         pladr1
023900060427     C                   movel(P)  addr2         pladr2
024000060427     C                   movel(P)  city          plcity
024100060427     C                   move      state         plst
024200060427     C                   z-add     zip           plzip9
024300060524     C                   If        plzip4 = '0000'
024400060524     C                   eval      plzip4 = '    '
024500060524     C                   endif
0246000604270107  *
024700060504     C                   move      enrldt        ploeff
024800060427     C                   eval      sal92 = salary
024900060427     C                   eval      plsal = %EDITC (sal92:'L')
025000060427     C                   eval      plsalm = 'A'
025100060504     C                   move      enrldt        plseff
0252000604280107  *
025300060504     C                   eval      plbena = %EDITC (benamt:'L')
025400060504     C                   movel     ppsm          plsmst
025500060504     C                   move      enrldt        plbnef
025600060524     C*****              move      candt         plcvtm
025700060524     C                   eval      plcvtm = %EDITC(candt:'M')
025800060428     C                   movel     mcplan        plmpln
0259000604270296  *
026000060427     C                   write     prlifr
0261000204150107  *
026200020415     C                   endsr
0263000605040107  ********************************************************************************
0264000605040107  *
0265000605040107  *     BLDSPS - Update record w/ spouse info
0266000605040107  *
0267000605040107  ********************************************************************************
026800060504     C     bldsps        begsr
0269000605040291  *
0270000605040296 C                   If        enrldt <> candt and
0271000605040296 C                             (candt = 0 or candt > cutofn)
0272000605040296  *
0273000605040297 C     mcssno        chain     dependl1                           32
0274000605040296 C                   If        *in32 = '0'
0275000605040291  *
0276000605040297 C     dssnoa        chain     prlifp                             24
0277000605040296 C                   If        *in24 = '0'
0278000605040107  *
0279000605040296 C                   If        psbena = *blanks
0280000605040291  *
028100060504     C                   eval      psbena = %EDITC (benamt:'L')
028200060504     C                   eval      pssmst = ppsm
028300060504     C                   move      dbirth        psdob
028400060504     C                   move      enrldt        psbnef
028500060524     C*****              move      candt         pscvtm
028600060524     C                   eval      pscvtm = %EDITC(candt:'M')
0287000605040296 C                   movel     mcplan        plspln
028800060504     C                   update    prlifr
0289000605040291  *
0290000605040297 C                   endif                                                  ccandt = 0
0291000605040291  *
0292000605040297 C                   endif                                                  ccandt = 0
0293000605040291  *
0294000605040297 C                   endif                                                  ccandt = 0
0295000605040297  *                                                                         ccandt = 0
0296000605040297 C                   endif                                                  ccandt = 0
0297000605040107  *
029800060504     C                   endsr
0299000605040107  ********************************************************************************
0300000605040107  *
0301000605040107  *     BLDCHD - Update record w/ child info
0302000605040107  *
0303000605040107  ********************************************************************************
030400060504     C     bldchd        begsr
0305000605040107  *
0306000605040296 C                   If        enrldt <> candt and
0307000605040296 C                             (candt = 0 or candt > cutofn)
0308000605040296  *
0309000605040297 C     mcssnoa       chain     prlifp                             24
0310000605040296 C                   If        *in24 = '0'
0311000605040291  *
0312000605040296 C                   If        pcbena = *blanks
0313000605040291  *
031400060504     C                   eval      pcbena = %EDITC (benamt:'L')
031500060504     C                   move      enrldt        pcbnef
031600060524     C*****              move      candt         pccvtm
031700060524     C                   eval      pccvtm = %EDITC(candt:'M')
0318000605040296 C                   movel     mcplan        plcpln
031900060504     C                   update    prlifr
0320000605040291  *
0321000605040297 C                   endif                                                  ccandt = 0
0322000605040291  *
0323000605040297 C                   endif                                                  ccandt = 0
0324000605040291  *
0325000605040297 C                   endif                                                  ccandt = 0
0326000605040297  *                                                                         ccandt = 0
032700060504     C                   endsr
