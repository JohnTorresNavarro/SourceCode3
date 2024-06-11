0001000204020002  *****************************************************************************
000200240319      * HRCV10R    Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400240319      *            DATE - 03/2024                                                 *
000500201006      *  DESCRIPTION - Build file of current HRA Eligibility                      *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800240319      *  mm/dd/yyyy xxx
0014009102150018 F******************************************************************
0015000204020019 FPLNMSTN1  IF   E           K DISK
001700081112     FMCOV39    IF   E           K DISK
001800110308     FMEMBER    IF   E           K DISK
001900110308     FACCMST    IF   E           K DISK
002000110308     FGRAT24    IF   E           K DISK
002100101223     FGRAT26    IF   E           K DISK    PREFIX(X) RENAME(GRATER:GRATEX)
002200101223     FDCOV      IF   E           K DISK
002300101223     FDEPNDC    IF   E           K DISK
0023012403190020 FDEBCARD   IF   E           K DISK
0024002403190020 FHRCVCURP  UF A E           K DISK
0027001012230025  *
0028000809160250 D                 DS
0029001012230251 D  mcovtp                 1      3
0030001012230251 D   mcovtp2               2      3
0031001012230025  *
0032001012230250 D                 DS
0033000903270251 D  group#                 1     15
0034000903270251 D   grp4                  1      4
0035000809160025  *
0036000809160250 D                 DS
0037001004220251 D  seq#                          2S 0 INZ(0)
0038001004220251 D  dseq                          2S 0 INZ(0)
0039000809160251 D  cutoff                         D   DATFMT(*ISO)
0040000809160251 D  cutofn                        8S 0
0041000910120251 D  day30                          D   DATFMT(*ISO)
0042000910120251 D  day30n                        8S 0
0043000910120251 D  updt                          1A
0044000910120251 D  rate8                         6S 0
0045000911030251 D  planq                         1A
0046001112080251 D  gbsmbr                        1A
0047001911120251 D  email                        65A
004800091012      *
0049000809160251 D  bkmid#                             LIKE(mcmid#)
0050001103080251 D  bkseq#                             LIKE(mcseq#)
0051001103080251 D  bklnme                             LIKE(mclnme)
0052001103080251 D  bkfnme                             LIKE(mcfnme)
0053001001130251 D  bkbrdt                             LIKE(mcbrdt)
0054001103080251 D  bkgrp#                             LIKE(mcgrp#)
0055001103080251 D  svgrp#                             LIKE(mcgrp#)
0056001004130251 D  todaa                              LIKE(frmdat)
0057001004130251 D  date9                              LIKE(frmdat)
0058001004130251 D  svrate                             LIKE(mcrate)
0059001004130251 D  svfrmdt                            LIKE(xfrmdat)
0060001004130251 D  svtodat                            LIKE(xtodat)
006100110117      *
006200110117     C     bgkey         klist
006300110309     C                   kfld                    bkmid#
006400110309     C                   kfld                    bkseq#
006500110309     C                   kfld                    bklnme
006600110309     C                   kfld                    bkfnme
006700110309     C                   kfld                    bkbrdt
006800110309      *
006900110309     C     grkey         klist
007000110309     C                   kfld                    pltrst
007100110309     C                   kfld                    plsub#
007200110309     C                   kfld                    plplan
007300101108     C                   kfld                    date9
007400110215      *
007500110215     C     mcvky         klist
007600110215     C                   kfld                    pltrst
007700110215     C                   kfld                    plsub#
007800110215     C                   kfld                    plplan
007900110215      *
008000101108     C     rt6ky         klist
008100110215     C                   kfld                    mctrst
008200110215     C                   kfld                    mcsub#
008300110215     C                   kfld                    mcplan
008400110215     C                   kfld                    mcovtp
008500110215     C                   kfld                    date9
008600110215      *
008700110215     C     acckey        klist
008800110215     C                   kfld                    mbtrst
008900081008     C                   kfld                    mbsub#
009000081008     C                   kfld                    mbacct
009100081008      *
009200081008     C     depky         klist
009300081008     C                   kfld                    mbssno
009400080917     C                   kfld                    dseq#
009500100422      *
009600100422     C     mbrky         klist
009700240326     C                   kfld                    mbssno
009800240326     C                   kfld                    seq#
0099002403260291  *   Preprocessing
0100002403260297 C                   movel     UDATE         cutoff
0101002403260297 C                   movel     cutoff        todaa
0102002403260297 C                   z-add     99999999      date9
0103002403260291  * Determine Term date cutoff - 1 year ago
0104002403260297 C     cutoff        subdur    365:*D        cutoff
0105002403260297 C                   movel     cutoff        cutofn
010600240326      *
0107002403260297 C                   movel     UDATE         day30
0108002403260291  *
0109002403260297 C     day30         adddur    30:*D         day30
0110002403260297 C                   movel     day30         day30n
011100240326      *
0112002403260291  * Main Line - Loop thru plan master
0113002403260297 C     'ABF'         setll     plnmstn1                           21
0114001008230296 C                   dou       *in21 = '1' or pcarr > 'MBF'
0115001008230297 C                   read      plnmstn1                               21
0116001008230296 C                   If        (*in21 = '0' and pldltd = 'A' and
0117002403190296 C                             plncat = 'PBN')
0117012403190296 C******             If        (*in21 = '0' and pldltd = 'A' and
0117022403190296 C**                           pcarr = 'MBC') or
0118002403190296 C**                           (*in21 = '0' and pldltd = 'A' and
0119002403190296 C**                           pcarr = 'MBF') or
0120002403190296 C**                           (*in21 = '0' and pldltd = 'A' and
0121002403190296 C*******                      pcarr = 'ABF')
0122001001130291  *
0123002105050296 C                   If        sfadm = 'Y'
0124002105050296 C                   iter
0125002105050296 C                   endif
0126002105050291  *
0127000809150291  *        Get GRATE record
0128000809150297 C     grkey         setll     grat24                             22
0129000809150297 C                   readp     grat24                                 22
0130000809150296 C                   If        *in22 = '0'
0131000903300296 C                   movel     group#        svgrp#
0132000809150291  *** ** DEBUG SHIT
0133000809150296 C**** ****          If        GROUP# = '7200           '
0134000809150296 C***** ****         movel     GROUP#        group#
0135000807290296 C****** ************endif
0136000809170291  *
0137000809170291  *        Loop thru mcov file using T,S,P
0138001012220297 C     mcvky         setll     mcov39                             31
0139001012220296 C                   dou       *in31 = '1'
0140001012220297 C     mcvky         reade     mcov39                                 31
0141001012220291  *      DEBUG SHIT
0142001012220296 C                   If        mcssno = 194462488 or
0143001012220296 C                             mcssno = 194462488
0144001012220296 C                   eval      mcssno = mcssno
0145001012220296 C                   endif
0146001012220291  *
0147000809170296 C                   If        *in31 = '0' and pltrst = mctrst and
0148000809170296 C                             plsub# = mcsub# and plplan = mcplan and
0149000809120296 C                             (candt = 0 or candt > enrldt)
0150000809120291  *
0151000809120296 C                   If        candt = 0 or candt > cutofn
0152000809120291  *        Get member record
0153000807240297 C     mcssno        chain     member                             32
0154000810200296 C                   If        *in32 = '0'
0155000810200291  *
0156000810200291 C                   exsr      bldmbr
0157000810200291  *
015800111208     C                   if        gbsmbr <> 'Y'
0159000810200291  *        Look for dependents of member
0160000809080297 C     mcssno        setll     dcov                               33
0161000810200296 C                   dou       *in33 = '1'
0162000809080297 C     mcssno        reade     dcov                                   33
0163000810200296 C                   If        *in33 = '0' and pltrst = dvtrst and
0164000810200296 C                             plsub# = dvsub# and plplan = dvplan
0165000810200291  *
0166000810200296 C                   If        ccandt = denrdt
0167000810200296 C                   iter
0168000810200296 C                   endif
0169000810200291  *
0170000810200296 C                   If        ccandt = 0 or ccandt > cutofn
0171000810200291  *
0172000810200291 C                   exsr      blddep
0173000810200291  *
0174000810200297 C                   endif                                                  ccandt = 0
0175000810200291  *
0176000809150297 C                   endif                                                  *in33 = '0'
0177000810200291  *
0178000809150297 C                   enddo                                                  *in33 = '1'
0179000810200291  *
0180000810200297 C                   endif                                                  *in32 = '0'
0181000810200291  *
0182001112080297 C                   endif                                                  *in32 = '0'
0183001112080291  *
0184002010070297 C                   endif                                                  candt = 0
0185002010070297 C                   endif                                                  *in31 = '0'
0186002010070297 C                   enddo                                                  *in31 = '1'
0187002010070291  *
0188002010070297 C                   endif                                                  *in22 = '0'
0189002010070291  *
0190002010070297 C                   endif                                                  *in21 = '0'
0191002010070296 C                   If        pcarr > 'MBF'
0192002010070296 C                   leave
0193002010070297 C                   endif                                                  pcarr > 'EX2'
0194002010070297 C                   enddo                                                  *in21 = '1'
0195002010070291  *
0196002010070297 C                   movel     '1'           *inlr
0197000808040297 C                   return
0198000204020107  ********************************************************************************
0199000807290107  *
0200000204020107  *     BLDMBR - Build Member record
0201000807290107  *
0202000204020107  ********************************************************************************
020300080728     C     bldmbr        begsr
020400091002      *         If enroll is more than 30 days out - bypass
020500150320      *     Remove per instructions from WA 3/20/15
020600150320     C*********          if        enrldt > day30n
020700150320     C*****              leavesr
020800150320     C*********          endif
020900111208      *         If Member is a GBS emp - bypass
021000111208     C                   eval      gbsmbr = 'N'
021100111208     C                   if        mbtrst = 550 and mbsub# = 1 and
021200111208     C                             mbacct = 16
021300111208     C                   leavesr
021400111208     C                   eval      gbsmbr = 'Y'
021500111208     C                   endif
021600100422      *         If mbr already exists and eff date < date - bypass
021700240319     C     mbrky         chain     HRCVCURP                           42
0218001011120296 C                   If        *in42 = '0'
021900101112     C                   if        enrldt > mcefdt
022000240319     C                   delete    HRCVCURR
022100101112     C                   else
022200101112     C                   leavesr
022300101112     C                   endif
022400101112     C                   endif
0225001011120291  *         If member doesn't exist - build record
022600240319     C                   clear                   HRCVCURR
022700101112     C                   movel     mbssno        mcmid#
022800101112     C                   z-add     0             mcseq#
022900101112     C                   movel     mlname        mclnme
023000101112     C                   movel     mfname        mcfnme
023100080915     C                   move      mmi           mcmi
023200080916     C                   movel     addr1         mcadr1
023300080916     C                   movel     addr2         mcadr2
0234001911110107  *
0235000809160296 C                   If        mcadr1 = *blanks and mcadr2 <> *blanks
023600080916     C                   movel(P)  mcadr2        mcadr1
023700080916     C                   movel     *blanks       mcadr2
023800080916     C                   endif                                                  *in62 = '0'
0239001911110107  *
024000191112     C                   eval      email = %Subst( Fill66 : 1 : 65)
024100191112     C                   movel(P)  email         mcemal
0242000809160107  *
024300080916     C                   movel     city          mccity
024400080916     C                   move      state         mcst
024500080916     C                   z-add     zip           mczip
024600080915     C                   eval      mcarea = area
024700080916     C                   eval      mcphn# = phone
024800080916     C                   z-add     birth         mcbrdt
024900080916     C                   move      sex           mcgndr
025000080915     C                   z-add     enrldt        mcefdt
025100080915     C                   z-add     candt         mctfdt
025200150320     C                   If        candt > day30n and enrldt <> candt
025300091002     C                   z-add     0             mctfdt
025400100423     C                   endif
025500100423     C                   movel     group#        mcgrp#
025600240319     C                   move      mcovtp2       mccovt
025700100423     C                   move      mcplan        mcpln
0258001004230291  *        Find rate record and calc yrly rate
0259001004230297 C     rt6ky         setll     grat26                             37
0260001004230296 C                   dou       *in37 = '1'
0261001004230297 C                   read      grat26                                 37
0262000811130296 C                   If        xgrtrst <> mctrst or xgrsub# <> mcsub# or
0263001004230296 C                             xgrplan <> mcplan or xtypecd <> mcovtp
026400101014     C                   leave
026500101014     C                   endif
0266001010140296 C                   If        *in37 = '0' and mcsub# = xgrsub# and
0267001010140296 C                             mcplan = xgrplan
026800181011      *
0269001810110296 C                   If        candt = 0 or (candt >= xfrmdat and
0270001810110296 C                             candt <= xtodat)
027100181011      *
0272001810110296 C                   If        mcgrp# <> '9131           ' and
0273001810110296 C                             mcgrp# <> '9131HR4        '
027400181011     C     12            mult(H)   xnetrte       rate8
027500181011     C                   eval      mcrate = rate8
027600181011     C                   else
027700181011     C                   eval      mcrate = xnetrte * 12
027800181011     C                   endif
027900181011      *
028000181011     C                   eval      mcpefd = xfrmdat
028100101109     C                   eval      mcptrd = xtodat
028200181011     C                   eval      svfrmdt = xfrmdat
028300181011     C                   eval      svtodat = xtodat
028400181011      *
028500100412     C                   leave
028600100412     C                   endif
028700100412     C                   endif
028800081113     C                   enddo
028900081113      ****
0290001010220291  *      If rate rec was not found - use most recent date range
029100101022     C                   if        mcpefd = 0
0292001010220297 C     rt6ky         setll     grat26                             37
0293001010220297 C                   read      grat26                                 37
0294001010220296 C                   If        *in37 = '0' and mcsub# = xgrsub# and
0295001010220296 C                             mcplan = xgrplan
029600101022      *
0297001010220296 C                   If        mcgrp# <> '9131           ' and
0298001010220296 C                             mcgrp# <> '9131HR4        '
029900101022     C     12            mult(H)   xnetrte       rate8
030000101022     C                   eval      mcrate = rate8
030100101022     C                   else
030200101022     C                   eval      mcrate = xnetrte * 12
030300101022     C                   endif
030400101022      *
030500101022     C                   eval      mcpefd = xfrmdat
030600101022     C                   eval      mcptrd = xtodat
030700101022     C                   eval      svfrmdt = xfrmdat
030800101022     C                   eval      svtodat = xtodat
030900101022      *
031000101022     C                   endif
031100101022     C                   endif
031200101022      ****
031300080917     C                   eval      mcsal = salary
031400080917     C                   eval      mcmardt = mardt
031500080917     C                   eval      mcempdt = empdt
031600080917     C                   eval      mctrmdt = termdt
031700240319     C                   move      mcovtp2       mccovt
031800080917      *
031900081113     C                   eval      mctrust = mbtrst
032000080829     C                   eval      mcsub = mbsub#
032100080829     C                   eval      mcacct = mbacct
032200050622     C     acckey        chain     accmst                             51
0323000808210296 C                   If        *in51 = '0'
032400080829     C                   eval      mcacnm = acnam1
032500050622     C                   endif
0331001103110291  *        See if Debit Card is needed
0332001103110297 C     mbrky         chain     debcard                            42
033300110915     C                   if        *in42 = '0' and dbprsta <> 'C'
033400110311     C                   eval      mccdat = dbtrdat
033500110311     C                   endif                                                  *in62 = '0'
033700080821      *
033800100610     C                   eval      mcdbtc = pdebit
033900100610      *
0340000808290296 C****               If        mcefdt <> mctfdt
034100240319     C                   write     HRCVCURR
034200051128     C****               endif                                                  *in62 = '0'
0343000211040107  *
034400020415     C                   endsr
0345000204150107  ********************************************************************************
0346000204040107  *
0347000204040107  *     BLDDEP - Build Dependent Record
0348000204040107  *
0349000204040107  ********************************************************************************
035000020404     C     blddep        begsr
035100091002      *         If enroll is more than 30 days out - bypass
035200150320      *     Remove per instructions from WA 3/20/15
035300150320     C*********          if        denrdt > day30n
035400150320     C*****              leavesr
035500150320     C*********          endif
0356002403190291  *        See if alrady in HRCVDURP - if so, bypass
0357002403190297 C     depky         chain     HRCVCURP                           49
035800100413     C                   if        *in49 = '0'
035900100422     C                   if        denrdt > mcefdt
036000240319     C                   delete    HRCVCURR
036100100422     C                   else
036200100422     C                   leavesr
036300100422     C                   endif
036400100422     C                   endif
0365001004130291  *        Get Dependent record
0366001004130297 C     depky         chain     depndc                             42
0367000808210296 C                   If        *in42 = '0' and
0368000808210296 C                             (ccandt = 0 or ccandt >= denrdt)
0369000808210291  *
0370000808210107  *      First see if depend record exists
0371000808210291  *       DEBUG
0372000808210296 C                   If        mbssno = 324649685
0373000808210296 C                   eval      mbssno = mbssno
0374000808210296 C                   endif
0375000204150291  *         If member doesn't exist - build record
037600240319     C                   clear                   HRCVCURR
037700080829     C                   movel     mbssno        mcmid#
037800080829     C                   z-add     dpseq#        mcseq#
037900080829     C                   eval      mcdssn = depss#
0380000204040107  *
038100020404     C                   if        dlname = 'SAME'
038200080829     C                   movel     mlname        mclnme
038300020404     C                   else
038400080829     C                   movel     dlname        mclnme
038500020404     C                   endif
0386000204040107  *
038700080917     C                   movel     dfname        mcfnme
038800080917     C                   move      dmi           mcmi
0389000809170107  *
039000080917     C                   if        daddr1 = 'SAME'
039100080917     C                   movel     addr1         mcadr1
039200080917     C                   movel     addr2         mcadr2
039300080917     C                   movel     city          mccity
039400080917     C                   move      state         mcst
039500080829     C                   z-add     zip           mczip
039600240318     C                   eval      mcarea = area
039700240318     C                   eval      mcphn# = phone
039800240318     C                   else
039900240318     C                   movel     daddr1        mcadr1
040000240318     C                   movel     daddr2        mcadr2
040100240318     C                   movel     dcity         mccity
040200240318     C                   move      dstate        mcst
040300240318     C                   z-add     dzip          mczip
040400240318     C                   eval      mcarea = darea
040500240318     C                   eval      mcphn# = dphone
040600240318     C                   endif
0407002403180107  *
040800080829     C                   z-add     dbirth        mcbrdt
040900080829     C                   move      dsex          mcgndr
041000080829     C                   z-add     denrdt        mcefdt
041100080829     C                   z-add     ccandt        mctfdt
041200150320     C                   If        ccandt > day30n and denrdt <> ccandt
041300091002     C                   z-add     0             mctfdt
041400091002     C                   endif
041500090330     C                   movel     group#        mcgrp#
041600240319     C                   move      mcovtp2       mccovt
041700100407     C                   move      dvplan        mcpln
041800100407     C                   move      drelcd        mcrelcd
041900100407      *
042000100407     C                   eval      mctrust = mbtrst
042100100407     C                   eval      mcsub = mbsub#
042200100407     C                   eval      mcacct = mbacct
042300100407     C                   eval      mcacnm = acnam1
042400100407      *
042500100407     C                   eval      mcpefd = svfrmdt
042600091013     C                   eval      mcptrd = svtodat
0427001008200291  *        See if Debit Card is needed
0428001008200297 C     depky         chain     debcard                            42
042900100820     C                   if        *in42 = '0'
043000100820     C                   eval      mcdbtc = dbdeliv
043100110311     C                   eval      mccdat = dbtrdat
043200100820     C                   endif                                                  *in62 = '0'
043300050622      *
043400240319     C                   write     HRCVCURR
0435000204150107  *
043600020415     C                   endif                                                  *in62 = '0'
043700020404     C                   endsr
043800020402     C*
