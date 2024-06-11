0001000204020002  *****************************************************************************
000200100511      * DW430      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400110414      *            DATE - 05/2010                                                 *
000500100511      *  DESCRIPTION - Build file opf current FSA Eligibility                     *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800100511      *  MM/DD/YYYY xxx
0009009102150018 F******************************************************************
0010000204020019 FPLNMSTN1  IF   E           K DISK
001100081112     F**MCOVXX    IF   E           K DISK
001200081112     FMCOV39    IF   E           K DISK
001300110331     FMEMBER    IF   E           K DISK
001400110331     FACCMST    IF   E           K DISK
001500020404     FGRAT24    IF   E           K DISK
001600081113     FGRAT26    IF   E           K DISK    PREFIX(X) RENAME(GRATER:GRATEX)
0017001005110020 FFSCURP    UF A E           K DISK
0018000809160025  *
0019000809160250 D                 DS
0020000809160251 D  mcovtp                 1      3
0021001103310251 D   mcovtp2               2      3
0022001103310025  *
0023000903270250 D                 DS
0024001103310251 D  group#                 1     15
0025001103310251 D   grp4                  1      4
0026001103310025  *
0027001103310250 D                 DS
0028001103310251 D  seq#                          2S 0 INZ(0)
0029001004220251 D  dseq                          2S 0 INZ(0)
0030000809160251 D  cutoff                         D   DATFMT(*ISO)
0031000809160251 D  cutofn                        8S 0
0032000910120251 D  day30                          D   DATFMT(*ISO)
0033000910120251 D  day30n                        8S 0
0034000910120251 D  updt                          1A
0035000910120251 D  rate8                         6S 0
0036000911030251 D  planq                         1A
0037001007090251 D  plnkey                        3A
003800091012      *
0039001005110251 D  bkmid#                             LIKE(fcmid#)
0040001005110251 D  bkseq#                             LIKE(fcseq#)
0041001005110251 D  bklnme                             LIKE(fclnme)
0042001005110251 D  bkfnme                             LIKE(fcfnme)
0043001005110251 D  bkbrdt                             LIKE(fcbrdt)
0044001005110251 D  bkgrp#                             LIKE(fcgrp#)
0045001005110251 D  svgrp#                             LIKE(fcgrp#)
0046001004130251 D  todaa                              LIKE(frmdat)
0047001004130251 D  date9                              LIKE(frmdat)
0048001005110251 D  svrate                             LIKE(fcrate)
0049001004130251 D  svfrmdt                            LIKE(xfrmdat)
0050001004130251 D  svtodat                            LIKE(xtodat)
005100100413      *
005200100413     C     bgkey         klist
005300110412     C                   kfld                    bkmid#
005400110412     C                   kfld                    bkseq#
005500110412     C                   kfld                    bklnme
005600110412     C                   kfld                    bkfnme
005700110412     C                   kfld                    bkbrdt
005800110412      *
005900110412     C     grkey         klist
006000110412     C                   kfld                    pltrst
006100100118     C                   kfld                    plsub#
006200100118     C                   kfld                    plplan
006300100118     C                   kfld                    date9
006400100118      *
006500100118     C     mcvky         klist
006600100118     C                   kfld                    pltrst
006700100118     C                   kfld                    plsub#
006800081008     C                   kfld                    plplan
006900081113      *
007000081113     C     rt6ky         klist
007100081113     C                   kfld                    mctrst
007200081113     C                   kfld                    mcsub#
007300081113     C                   kfld                    mcplan
007400081113     C                   kfld                    mcovtp
007500081113     C                   kfld                    date9
007600081008      *
007700081008     C     acckey        klist
007800081008     C                   kfld                    mbtrst
007900081008     C                   kfld                    mbsub#
008000081008     C                   kfld                    mbacct
008100100422      *
008200100422     C     mbrky         klist
008300100422     C                   kfld                    mbssno
008400100422     C                   kfld                    seq#
0085000810200291  *   Preprocessing
0086000810200297 C                   movel     UDATE         cutoff
0087000810200297 C                   movel     cutoff        todaa
0088000810200297 C                   z-add     99999999      date9
0089000206130291  * Determine Term date cutoff - 1 year ago
0090000807240297 C     cutoff        subdur    365:*D        cutoff
0091000810200297 C                   movel     cutoff        cutofn
009200081020      *
0093000910020297 C                   movel     UDATE         day30
0094000910020291  *
0095000910020297 C     day30         adddur    30:*D         day30
0096000910020297 C                   movel     day30         day30n
009700091002      *
0098000809150291  * Main Line - Loop thru plan master
0099001007090297 C                   eval      plnkey = 'SAF'
0100001007090296 C                   dou       plnkey = 'XXX'
0101001007090297 C     plnkey        setll     plnmstn1                           21
0102001007090296 C                   dou       *in21 = '1'
0103001007090297 C     plnkey        reade     plnmstn1                               21
0104001001130296 C                   If        *in21 = '0' and pldltd = 'A' and
0105001007090296 C                             pcarr = plnkey
0106001001130291  *
0107000809150291  *        Get GRATE record
0108000809150297 C     grkey         setll     grat24                             22
0109000809150297 C                   readp     grat24                                 22
0110000809150296 C                   If        *in22 = '0'
0111000903300296 C                   movel     group#        svgrp#
0112000809150291  *** ** DEBUG SHIT
0113000809150296 C**** ****          If        GROUP# = '7200           '
0114000809150296 C***** ****         movel     GROUP#        group#
0115000807290296 C****** ************endif
0116000809170291  *
0117000809170291  *        Loop thru mcov file using T,S,P
0118000811120297 C     mcvky         setll     mcov39                             31
0119000809170296 C                   dou       *in31 = '1'
0120000811120297 C     mcvky         reade     mcov39                                 31
0121000809170291  *       DEBUG
0122000911030296 C                   If        mcssno = 230370837 or
0123000911030296 C                             mcssno = 222544123
0124000809170296 C                   eval      mcssno = mcssno
0125000809170296 C                   endif
0126000809170291  *
0127000809170296 C                   If        *in31 = '0' and pltrst = mctrst and
0128000809170296 C                             plsub# = mcsub# and plplan = mcplan and
0129000809120296 C                             (candt = 0 or candt > enrldt)
0130000809120291  *
0131000809120296 C                   If        candt = 0 or candt > cutofn
0132000809120291  *        Get member record
0133000807240297 C     mcssno        chain     member                             32
0134000810200296 C                   If        *in32 = '0'
0135000810200291  *
0136000810200291 C                   exsr      bldmbr
0137000810200291  *
0138000810200297 C                   endif                                                  *in32 = '0'
0139000810200291  *
0140000810200297 C                   endif                                                  candt = 0
0141000810200297 C                   endif                                                  *in31 = '0'
0142000810200297 C                   enddo                                                  *in31 = '1'
0143000810200291  *
0144000810200297 C                   endif                                                  *in22 = '0'
0145000810200291  *
0146000810200297 C                   endif                                                  *in21 = '0'
0147001007090296 C                   If        pcarr > plnkey
0148000808040296 C                   leave
0149000808040297 C                   endif                                                  pcarr > 'EX2'
0150000808040297 C                   enddo                                                  *in21 = '1'
0151000808040291  *
0152001007090296 C                   If        plnkey = 'SAF'
0153001007090296 C                   eval      plnkey = 'HIR'
0154001007090297 C                   else                                                   *in21 = '1'
0155001007090297 C                   leave                                                  pcarr > 'EX2'
0156001007090297 C                   endif                                                  pcarr > 'EX2'
0157001007090297 C                   enddo                                                  *in21 = '1'
0158001007090291  *
0159000808040297 C                   movel     '1'           *inlr
0160000808040297 C                   return
0161000204020107  ********************************************************************************
0162000807290107  *
0163000204020107  *     BLDMBR - Build Member record
0164000807290107  *
0165000204020107  ********************************************************************************
016600080728     C     bldmbr        begsr
016700091002      *         If enroll is more than 30 days out - bypass
016800091002     C                   if        enrldt > day30n
016900091002     C                   leavesr
017000091002     C                   endif
017100100422      *         If mbr already exists and eff date < date - bypass
017200100511     C     mbrky         chain     fscurp                             42
0173001004220296 C                   If        *in42 = '0'
017400100511     C                   if        enrldt > fcefdt
017500100511     C                   delete    fscurr
017600100422     C                   else
017700100422     C                   leavesr
017800100422     C                   endif
017900100422     C                   endif
0180000910020291  *         If member doesn't exist - build record
018100100511     C                   clear                   fscurr
018200100511     C                   movel     mbssno        fcmid#
018300100511     C                   z-add     0             fcseq#
018400100511     C                   movel     mlname        fclnme
018500100511     C                   movel     mfname        fcfnme
018600100511     C                   move      mmi           fcmi
018700100511     C                   movel     addr1         fcadr1
018800100511     C                   movel     addr2         fcadr2
0189000809160107  *
0190001005110296 C                   If        fcadr1 = *blanks and fcadr2 <> *blanks
019100100511     C                   movel(P)  fcadr2        fcadr1
019200100511     C                   movel     *blanks       fcadr2
019300080916     C                   endif                                                  *in62 = '0'
0194000809160107  *
019500100511     C                   movel     city          fccity
019600100511     C                   move      state         fcst
019700100511     C                   z-add     zip           fczip
019800100511     C                   eval      fcarea = area
019900100511     C                   eval      fcphn# = phone
020000100511     C                   z-add     birth         fcbrdt
020100100511     C                   move      sex           fcgndr
020200100511     C                   z-add     enrldt        fcefdt
020300100511     C                   z-add     candt         fctfdt
020400091002     C                   If        candt > day30n
020500100511     C                   z-add     0             fctfdt
020600100423     C                   endif
020700100511     C                   movel     group#        fcgrp#
020800100511     C                   move      mcovtp        fccovt
020900100511     C                   move      mcplan        fcpln
0210001004230291  *        Find rate record and calc yrly rate
0211001004230297 C     rt6ky         setll     grat26                             37
0212001004230296 C                   dou       *in37 = '1'
0213001004230297 C                   read      grat26                                 37
0214001005110296 C                   If        xgrtrst <> mctrst or xgrsub# <> mcsub# or
0215001005110296 C                             xgrplan <> mcplan or xtypecd <> mcovtp
021600081113     C                   leave
021700081113     C                   endif
0218001005110296 C                   If        *in37 = '0' and mcsub# = xgrsub# and
0219001005110296 C                             mcplan = xgrplan
022000100423      *
0221001004230296 C                   If        candt = 0 or (candt >= xfrmdat and
0222001104130296 C                             candt <= xtodat)
022300110413      *
0224001104130296 C                   If        fcgrp# <> '9131           ' and
0225001104130296 C                             fcgrp# <> '9131HR4        '
022600110413     C     12            mult(H)   xnetrte       rate8
022700110413     C                   eval      fcrate = rate8
022800110413     C                   else
022900110413     C                   eval      fcrate = xnetrte * 12
023000110413     C                   endif
023100110413      *
023200110413     C                   eval      fcpefd = xfrmdat
023300110413     C                   eval      fcptrd = xtodat
023400110413     C                   eval      svfrmdt = xfrmdat
023500110413     C                   eval      svtodat = xtodat
023600110413      *
023700100412     C                   leave
023800100412     C                   endif
023900100412     C                   endif
024000081113     C                   enddo
024100081113      ****
024200100511     C                   eval      fcsal = salary
024300100511     C                   eval      fcmardt = mardt
024400100511     C                   eval      fcempdt = empdt
024500100511     C                   eval      fctrmdt = termdt
024600100511     C                   move      mcovtp        fccovt
024700080917      *
024800100511     C                   eval      fctrust = mbtrst
024900100511     C                   eval      fcsub = mbsub#
025000100511     C                   eval      fcacct = mbacct
025100050622     C     acckey        chain     accmst                             51
0252000808210296 C                   If        *in51 = '0'
025300100511     C                   eval      fcacnm = acnam1
025400050622     C                   endif
025500080821      *
0256001005110296 C****               If        fcefdt <> fctfdt
025700100511     C                   write     fscurr
025800051128     C****               endif                                                  *in62 = '0'
0259000211040107  *
026000020415     C                   endsr
