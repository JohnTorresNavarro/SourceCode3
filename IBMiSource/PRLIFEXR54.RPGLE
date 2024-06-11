0001000204020002  *****************************************************************************
000200060427      * PRLIBEXR   Group Benefit Services                                         *
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
001400060428     FMCOV22    IF   E           K DISK    RENAME(MCOVR:MCOV2R)
001500060428     F                                     PREFIX(X)
001600020404     FMEMBER    IF   E           K DISK
001700020404     FDEPNDC    IF   E           K DISK
0018000604270020 FPRLIFP    UF A E           K DISK
0019000204020025  *
0020009102150250 D                 DS
0021000604270251 D plzip9                  1      9  0
0022000604270251 D  plzip                  1      5  0
0023000604270251 D  plzip4                 6      9  0
0024000604270025  *
0025000604280250 D  EMPINFO        DS
0026000604280251 D    plbena                      9
0027000604280251 D    plsmst                      1
0028000604280251 D    plbnef                      8  0
0029000604280251 D    plcvtm                      8  0
0030000604280251 D    plmpln                      4
0031000604280025  *
0032000604280250 D  SPSINFO        DS
0033000604280251 D    psbena                      9
0034000604280251 D    pssmst                      1
0035000604280251 D    psdob                       8  0
0036000604280251 D    psbnef                      8  0
0037000604280251 D    pscvtm                      8  0
0038000604280251 D    plspln                      4
0039000604270025  *
0040000604270250 D  CHDINFO        DS
0041000604270251 D    pcbena                      9
0042000604270251 D    pcbnef                      8  0
0043000604270251 D    pccvtm                      8  0
0044000604280251 D    plcpln                      4
0045000604270025  *
0046000604270250 D                 DS
0047000604270251 D  cutoff                         D   DATFMT(*ISO)
0048000604270251 D  cutofn                        8S 0
0049000604270251 D  sal92                         9S 2
0050000604280251 D  c2pln                         4
0051000604280251 D  sps                           1
0052000604280251 D  deplif                        1
005300020415      *
005400020613     C     mcvky         klist
005500020613     C                   kfld                    pltrst
005600020613     C                   kfld                    plsub#
005700020613     C                   kfld                    plplan
005800060428      *
005900060428     C     mc2ky         klist
006000060428     C                   kfld                    mctrst
006100060428     C                   kfld                    mcsub#
006200060428     C                   kfld                    acc#
006300060428     C                   kfld                    mcssno
006400060428     C                   kfld                    c2pln
006500020402      *
006600020404     C     depky         klist
006700060428     C                   kfld                    xmcssno
006800060428      *
006900060428     C     dexky         klist
007000060428     C                   kfld                    mcssno
0071000206130291  *   Preprocessing
0072000206130297 C                   movel     UDATE         cutoff
0073000206130291  * Determine Term date cutoff - 1 year ago
0074000204040297 C     cutoff        subdur    365:*D        cutoff
0075000204030297 C                   movel     cutoff        cutofn
0076000604270291  *   Set up file defaults
0077000604270297 C                   clear                   prlifr
0078000604270297 C                   eval      plrect = 'E'
0079000604270297 C                   eval      plctrc = 'H33530'
0080000604270297 C                   eval      plunit = 1
008100020402      *
0082000204020291  * Main Line - Loop thru plan master
0083000604270297 C     'PVL'         setll     plnmstn1                           21
0084000204020296 C                   dou       *in21 = '1'
0085000204030297 C                   read      plnmstn1                               21
0086000204240296 C                   If        *in21 = '0' and pldltd = 'A' and
0087000604280296 C                             pcarr = 'PVL' and
0088000604280296 C                             (plncat = 'PSL' or plncat = 'PNE' or
0089000604280296 C                             plncat = 'PSP' or plncat = 'PNS' or
0090000605010296 C                             plncat = 'PVD')
0091000605010291  *
0092000605010291  *        Loop thru mcov file using T,S,P
0093000204030297 C     mcvky         setll     mcovxx                             31
0094000204020296 C                   dou       *in31 = '1'
0095000204030297 C     mcvky         reade     mcovxx                                 31
0096000204030296 C                   If        *in31 = '0' and pltrst = mctrst and
0097000211040296 C                             plsub# = mcsub# and plplan = mcplan and
0098000211040296 C                             (candt = 0 or candt > enrldt)
0099000204030291  *
0100000204030296 C                   If        candt = 0 or candt > cutofn
0101000604280291  *
0102000604280296 C                   eval      deplif = 'N'
0103000604280291  *        See if rec exists
0104000604280296 C                   If        plncat = 'PSP' or plncat = 'PNS' or
0105000604280296 C                             plncat = 'PVD'
0106000604280296 C                   eval      deplif = 'Y'
0107000604280297 C     mcssno        chain     prlifp                             24
0108000604280296 C                   If        *in24 = '0'
0109000604280291 C                   exsr      updtmbr
0110000604280297 C                   iter                                                   *in33 = '1'
0111000604280297 C                   endif                                                  *in33 = '1'
0112000604280297 C                   endif                                                  *in33 = '1'
0113000604280291  *
0114000204030291  *        Get member record
0115000204030297 C     mcssno        chain     member                             32
0116000204030296 C                   If        *in32 = '0'
0117000204020291  *
0118000204020291 C                   exsr      bldmbr
0119000204040291  *
0120000604270297 C                   endif                                                  *in33 = '1'
0121000204040291  *
0122000204040297 C                   endif                                                  *in32 = '0'
0123000204030291  *
0124000204040297 C                   endif                                                  candt = 0
0125000204020297 C                   enddo                                                  *in31 = '1'
0126000204020291  *
0127000204040297 C                   endif                                                  *in22 = '0'
0128000204040291  *
0129000604270296 C                   If        pcarr > 'PVL'
0130000204030296 C                   leave
0131000204030297 C                   endif                                                  pcarr > 'EX2'
0132000204020297 C                   enddo                                                  *in21 = '1'
0133000204020291  *
0134000204020297 C                   movel     '1'           *inlr
0135000204020297 C                   return
0136000204020107  ********************************************************************************
0137000204020107  *
0138000204020107  *     BLDMBR - Build Member record
0139000204020107  *
0140000204020107  ********************************************************************************
014100020402     C     bldmbr        begsr
0142000604270107  *
0143000604280296 C                   clear                   SPSINFO
0144000604280296 C                   clear                   CHDINFO
0145000604280296 C                   clear                   EMPINFO
0146000604280107  *
014700060427     C                   movel     mbssno        plssn
014800060427     C                   movel     mlname        pllnme
014900060427     C                   movel     mfname        plfnme
015000060427     C                   move      mmi           plmi
015100060427     C                   z-add     birth         pldob
015200060427     C                   move      sex           plsex
015300060427     C                   z-add     empdt         pldoh
015400060427     C                   z-add     termdt        plterm
0155000604270107  *
0156000604270296 C                   If        termdt <> 0
015700060427     C                   If        termcd = 'DDD' or termcd = 'D5 '
015800060427     C                   eval      pltrmc = 'D'
015900060427     C                   else
016000060427     C                   eval      pltrmc = 'M'
016100060427     C                   endif
016200060427     C                   else
016300060427     C                   eval      pltrmc = ' '
016400060427     C                   endif
0165000303270107  *
016600060427     C                   movel(P)  addr1         pladr1
016700060427     C                   movel(P)  addr2         pladr2
016800060427     C                   movel(P)  city          plcity
016900060427     C                   move      state         plst
017000060427     C                   z-add     zip           plzip9
0171000604270107  *
017200060427     C                   z-add     enrldt        ploeff
017300060427     C                   eval      sal92 = salary
017400060427     C                   eval      plsal = %EDITC (sal92:'L')
017500060427     C                   eval      plsalm = 'A'
017600060427     C                   z-add     enrldt        plseff
0177000604280107  *
017800060428     C                   if        deplif = 'Y'
0179000604280296 C                   clear                   EMPINFO
0180000604280291  *          Spouse
0181000605020296 C********           If        mcplan = 'D863' or mcplan = 'D864' or
0182000605020296 C********                     mcplan = 'D866'
0183000605020296 C                   If        plncat = 'PSP' or plncat = 'PNS'
0184000604280296 C                   If        psbena = *blanks
0185000604280291  *
0186000604280296 C                   If        enrldt <> candt and
0187000604280296 C                             (candt = 0 or candt > cutofn)
018800060428     C                   eval      sps = 'N'
0189000604280297 C     dexky         setll     depndc                             42
0190000604280296 C                   dou       *in42 = '1' or dssno <> mcssno
0191000604280297 C     dexky         reade     depndc                                 42
0192000604280296 C                   If        *in42 = '0' and  pssmst = ' ' and
0193000604280296 C                             (drelcd = 'RWI' or drelcd = 'RHU')
019400060428     C                   eval      sps = 'Y'
019500060428     C                   leave
019600060428     C                   endif
0197000604280297 C                   enddo                                                  ccandt = 0
0198000604280291  *
019900060428     C                   if        sps = 'Y'
020000060428     C                   eval      psbena = '    10000'
0201000605020296 C************       If        mcplan = 'D863'
0202000605020296 C                   If        plncat = 'PSP'
020300060428     C                   eval      pssmst = 'S'
020400060428     C                   else
020500060428     C                   eval      pssmst = 'N'
020600060428     C                   endif
0207000604280291  *
020800060428     C                   z-add     dbirth        psdob
020900060428     C                   z-add     enrldt        psbnef
021000060428     C                   z-add     candt         pscvtm
0211000604280296 C                   movel     mcplan        plspln
021200060428     C                   write     prlifr
0213000604280297 C                   leavesr                                                ccandt = 0
0214000604280291  *
0215000604280297 C                   endif                                                  ccandt = 0
0216000604280291  *
0217000604280297 C                   endif                                                  ccandt = 0
0218000604280291  *
0219000604280297 C                   endif                                                  ccandt = 0
0220000604280297 C                   leavesr                                                ccandt = 0
0221000604280297 C                   endif                                                  ccandt = 0
0222000604280291  *         Child
0223000605020296 C*************      If        mcplan = 'D867' or mcplan = 'D868'
0224000605020296 C                   If        plncat = 'PVD'
0225000604280291  *
0226000604280296 C                   If        pcbena = *blanks
0227000604280291  *
0228000604280296 C                   If        enrldt <> candt and
0229000604280296 C                             (candt = 0 or candt > cutofn)
0230000604280291  *
023100060428     C                   eval      pcbena = '    10000'
023200060428     C                   z-add     enrldt        pcbnef
023300060428     C                   z-add     candt         pccvtm
0234000604280296 C                   movel     mcplan        plcpln
023500060428     C                   write     prlifr
0236000604280297 C                   leavesr                                                ccandt = 0
0237000604280291  *
0238000604280297 C                   endif                                                  ccandt = 0
0239000604280297 C                   endif                                                  *in33 = '0'
0240000604280297 C                   leavesr                                                *in33 = '0'
0241000604280297 C                   endif                                                  *in33 = '0'
0242000604280107  *
0243000604280107 C                   endif
0244000604280107  *
024500060428     C                   move      benamt        plbena
0246000605020296 C*******            If        (mcplan > 'D846' and mcplan < 'D851') or
0247000605020296 C*******                      (mcplan = 'D855' or mcplan = 'D856')
0248000605020296 C                   If        plncat = 'PSL'
024900060427     C                   movel     'S'           plsmst
025000060427     C                   else
025100060427     C                   movel     'N'           plsmst
025200060427     C                   endif
025300060427     C                   z-add     enrldt        plbnef
025400060427     C                   z-add     candt         plcvtm
025500060428     C                   movel     mcplan        plmpln
0256000604270291  *
0257000604270291  *        Look for dependents of member
0258000604270296 C                   clear                   SPSINFO
0259000604270296 C                   clear                   CHDINFO
026000060428     C                   movel     'D863'        c2pln
0261000604280297 C     mc2ky         setll     mcov22                             33
0262000604280296 C                   dou       *in33 = '1' or mcssno <> xmcssno
0263000604280297 C                   read      mcov22                                 33
0264000604280296 C                   If        *in33 = '0' and mcssno = xmcssno
0265000605020296 C                   If        xmc125
0266000605020296 C                   if        xmcplan = 'D866'
0267000604270291  *
0268000604280296 C                   If        xenrldt <> xcandt and
0269000604280296 C                             (xcandt = 0 or xcandt > cutofn)
027000060428     C                   eval      sps = 'N'
0271000604280297 C     depky         setll     depndc                             42
0272000604280296 C                   dou       *in42 = '1' or dssno <> xmcssno
0273000604280297 C     depky         reade     depndc                                 42
0274000604270296 C                   If        *in42 = '0' and  pssmst = ' ' and
0275000604270296 C                             (drelcd = 'RWI' or drelcd = 'RHU')
027600060428     C                   eval      sps = 'Y'
027700060428     C                   leave
027800060428     C                   endif
0279000604280297 C                   enddo                                                  ccandt = 0
0280000604270291  *
028100060428     C                   if        sps = 'Y'
028200060427     C                   eval      psbena = '    10000'
0283000604280296 C                   If        xmcplan = 'D863'
028400060427     C                   eval      pssmst = 'S'
028500060427     C                   else
028600060427     C                   eval      pssmst = 'N'
028700060427     C                   endif
0288000604270291  *
028900060427     C                   z-add     dbirth        psdob
029000060428     C                   z-add     xenrldt       psbnef
029100060428     C                   z-add     xcandt        pscvtm
0292000604280296 C                   movel     xmcplan       plspln
0293000604270291  *
0294000604270297 C                   endif                                                  ccandt = 0
0295000604280291  *
0296000604280297 C                   endif                                                  ccandt = 0
0297000604270291  *
0298000604280297 C                   endif                                                  ccandt = 0
0299000604280291  *
0300000604280296 C                   If        xmcplan = 'D867' or xmcplan = 'D868'
0301000604270291  *
0302000604280296 C                   If        xenrldt <> xcandt and
0303000604280296 C                             (xcandt = 0 or xcandt > cutofn)
0304000604280291  *
030500060428     C                   eval      pcbena = '    10000'
030600060428     C                   z-add     xenrldt       pcbnef
030700060428     C                   z-add     xcandt        pccvtm
0308000604280296 C                   movel     xmcplan       plcpln
0309000604270291  *
0310000604270297 C                   endif                                                  ccandt = 0
0311000604270297 C                   endif                                                  *in33 = '0'
0312000604270297 C                   endif                                                  *in33 = '0'
0313000604270291  *
0314000604270296 C                   If        psbena <> *blanks and
0315000604270296 C                             pcbena <> *blanks
031600060427     C                   leave                                                  *in62 = '0'
031700060427     C                   endif                                                  *in62 = '0'
0318000604270296  *
031900060427     C                   enddo                                                  *in62 = '0'
0320000604270296  *
032100060427     C                   write     prlifr
0322000204150107  *
032300020415     C                   endsr
0324000604280107  ********************************************************************************
0325000604280107  *
0326000604280107  *     UPDTMBR - Update Member record
0327000604280107  *
0328000604280107  ********************************************************************************
032900060428     C     updtmbr       begsr
0330000604280291  *
0331000604280296 C                   If        mcplan = 'D863' or mcplan = 'D864' or
0332000604280296 C                             mcplan = 'D866'
0333000604280296 C                   If        psbena = *blanks
0334000604280291  *
0335000604280296 C                   If        enrldt <> candt and
0336000604280296 C                             (candt = 0 or candt > cutofn)
033700060428     C                   eval      sps = 'N'
0338000604280297 C     dexky         setll     depndc                             42
0339000604280296 C                   dou       *in42 = '1' or dssno <> mcssno
0340000604280297 C     dexky         reade     depndc                                 42
0341000604280296 C                   If        *in42 = '0' and  pssmst = ' ' and
0342000604280296 C                             (drelcd = 'RWI' or drelcd = 'RHU')
034300060428     C                   eval      sps = 'Y'
034400060428     C                   leave
034500060428     C                   endif
0346000604280297 C                   enddo                                                  ccandt = 0
0347000604280291  *
034800060428     C                   if        sps = 'Y'
034900060428     C                   eval      psbena = '    10000'
0350000604280296 C                   If        mcplan = 'D863'
035100060428     C                   eval      pssmst = 'S'
035200060428     C                   else
035300060428     C                   eval      pssmst = 'N'
035400060428     C                   endif
0355000604280291  *
035600060428     C                   z-add     dbirth        psdob
035700060428     C                   z-add     enrldt        psbnef
035800060428     C                   z-add     candt         pscvtm
0359000604280296 C                   movel     mcplan        plspln
036000060428     C                   update    prlifr
0361000604280291  *
0362000604280297 C                   endif                                                  ccandt = 0
0363000604280291  *
0364000604280297 C                   endif                                                  ccandt = 0
0365000604280291  *
0366000604280297 C                   endif                                                  ccandt = 0
0367000604280297 C                   endif                                                  ccandt = 0
0368000604280291  *
0369000605020296 C*******            If        mcplan = 'D867' or mcplan = 'D868'
0370000605020296 C                   If        plncat = 'PVD'
0371000604280291  *
0372000604280296 C                   If        pcbena = *blanks
0373000604280291  *
0374000604280296 C                   If        enrldt <> candt and
0375000604280296 C                             (candt = 0 or candt > cutofn)
0376000604280291  *
037700060428     C                   eval      pcbena = '    10000'
037800060428     C                   z-add     enrldt        pcbnef
037900060428     C                   z-add     candt         pccvtm
0380000604280296 C                   movel     mcplan        plcpln
038100060428     C                   update    prlifr
0382000604280291  *
0383000604280297 C                   endif                                                  ccandt = 0
0384000604280297 C                   endif                                                  *in33 = '0'
0385000604280297 C                   endif                                                  *in33 = '0'
0386000604280107  *
038700060428     C                   endsr
