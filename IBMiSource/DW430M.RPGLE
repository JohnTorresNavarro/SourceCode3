0001000204020002  *****************************************************************************
000200100511      * DW430      Group Benefit Services                                         *
000300110908      *            WRITTEN BY - R.L.J.                                            *
000400110908      *            DATE - 05/2010                                                 *
000500100511      *  DESCRIPTION - Build file opf current FSA Eligibility                     *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800110419      *  04/19/2011 rlj  Populate debit card fields - DBTC and CDAT
000900110915      *  09/15/2011 rlj  DEBCARD - ignore rec if sts = C - Canceled
001000110926      *  09/26/2011 rlj  DEBCARD - add ability to add dep recs for DEBCARD
001100120131      *  01/26/2012 rlj  Add MBI Logic
0012009102150018 F******************************************************************
0013000204020019 FPLNMSTN1  IF   E           K DISK
001400081112     F**MCOVXX    IF   E           K DISK
001500081112     FMCOV39    IF   E           K DISK
001600110331     FMEMBER    IF   E           K DISK
001700110926     FDEPNDC    IF   E           K DISK
001800110331     FACCMST    IF   E           K DISK
001900020404     FGRAT24    IF   E           K DISK
002000081113     FGRAT26    IF   E           K DISK    PREFIX(X) RENAME(GRATER:GRATEX)
0021001005110020 FFSCURP    UF A E           K DISK
0022001104190020 FDEBCARD   UF   E           K DISK
0023000809160025  *
0024000809160250 D                 DS
0025000809160251 D  mcovtp                 1      3
0026001103310251 D   mcovtp2               2      3
0027001103310025  *
0028000903270250 D                 DS
0029001103310251 D  group#                 1     15
0030001103310251 D   grp4                  1      4
0031001201040025  *
0032001201040250 D                 DS
0033001201040251 D  seq#                          2S 0 INZ(0)
0034001201040251 D  dseq                          2S 0 INZ(0)
0035001201040251 D  cutoff                         D   DATFMT(*ISO)
0036001201040251 D  cutofn                        8S 0
0037001201040251 D  day30                          D   DATFMT(*ISO)
0038000910120251 D  day30n                        8S 0
0039001201040251 D  updt                          1A
0040001201040251 D  rate8                         6S 0
0041001201040251 D  planq                         1A
0042001201040251 D  plnkey                        3A
004300120104      *
0044001201040251 D  bkmid#                             LIKE(fcmid#)
0045001201040251 D  bkseq#                             LIKE(fcseq#)
0046001005110251 D  bklnme                             LIKE(fclnme)
0047001005110251 D  bkfnme                             LIKE(fcfnme)
0048001005110251 D  bkbrdt                             LIKE(fcbrdt)
0049001005110251 D  bkgrp#                             LIKE(fcgrp#)
0050001005110251 D  svgrp#                             LIKE(fcgrp#)
0051001004130251 D  todaa                              LIKE(frmdat)
0052001004130251 D  date9                              LIKE(frmdat)
0053001005110251 D  svrate                             LIKE(fcrate)
0054001004130251 D  svfrmdt                            LIKE(xfrmdat)
0055001201270251 D  svtodat                            LIKE(xtodat)
005600120127      *
005700120127     C     bgkey         klist
005800120123     C                   kfld                    bkmid#
005900120127     C                   kfld                    bkseq#
006000120127     C                   kfld                    bklnme
006100111222     C                   kfld                    bkfnme
006200120127     C                   kfld                    bkbrdt
006300120127      *
006400120123     C     grkey         klist
006500120123     C                   kfld                    pltrst
006600120123     C                   kfld                    plsub#
006700120123     C                   kfld                    plplan
006800100118     C                   kfld                    date9
006900120123      *
007000100118     C     mcvky         klist
007100100118     C                   kfld                    pltrst
007200100118     C                   kfld                    plsub#
007300120123     C                   kfld                    plplan
007400120123      *
007500120123     C     rt6ky         klist
007600120123     C                   kfld                    mctrst
007700120123     C                   kfld                    mcsub#
007800081113     C                   kfld                    mcplan
007900120123     C                   kfld                    mcovtp
008000120123     C                   kfld                    date9
008100120123      *
008200120123     C     acckey        klist
008300120123     C                   kfld                    mbtrst
008400120123     C                   kfld                    mbsub#
008500120123     C                   kfld                    mbacct
008600120123      *
008700120123     C     mbrky         klist
008800100422     C                   kfld                    mbssno
008900120123     C                   kfld                    seq#
009000110926      *
009100110926     C     depky         klist
009200110926     C                   kfld                    dbssn
009300110926     C                   kfld                    dbseq
0094000810200291  *   Preprocessing
0095000810200297 C                   movel     UDATE         cutoff
0096000810200297 C                   movel     cutoff        todaa
0097000810200297 C                   z-add     99999999      date9
0098000206130291  * Determine Term date cutoff - 1 year ago
0099000807240297 C     cutoff        subdur    365:*D        cutoff
0100000810200297 C                   movel     cutoff        cutofn
010100081020      *
0102000910020297 C                   movel     UDATE         day30
0103000910020291  *
0104000910020297 C     day30         adddur    30:*D         day30
0105000910020297 C                   movel     day30         day30n
010600091002      *
0107000809150291  * Main Line - Loop thru plan master
0108001007090297 C                   eval      plnkey = 'SAF'
0109001007090296 C                   dou       plnkey = 'XXX'
0110001007090297 C     plnkey        setll     plnmstn1                           21
0111001007090296 C                   dou       *in21 = '1'
0112001007090297 C     plnkey        reade     plnmstn1                               21
0113001001130296 C                   If        *in21 = '0' and pldltd = 'A' and
0114001007090296 C                             pcarr = plnkey
0115001001130291  *
0116000809150291  *        Get GRATE record
0117000809150297 C     grkey         setll     grat24                             22
0118000809150297 C                   readp     grat24                                 22
0119000809150296 C                   If        *in22 = '0'
0120000903300296 C                   movel     group#        svgrp#
0121000809150291  *** ** DEBUG SHIT
0122000809150296 C**** ****          If        GROUP# = '7200           '
0123000809150296 C***** ****         movel     GROUP#        group#
0124000807290296 C****** ************endif
0125000809170291  *
0126000809170291  *        Loop thru mcov file using T,S,P
0127000811120297 C     mcvky         setll     mcov39                             31
0128000809170296 C                   dou       *in31 = '1'
0129000811120297 C     mcvky         reade     mcov39                                 31
0130000809170291  *       DEBUG
0131000911030296 C                   If        mcssno = 230370837 or
0132000911030296 C                             mcssno = 222544123
0133000809170296 C                   eval      mcssno = mcssno
0134000809170296 C                   endif
0135000809170291  *
0136000809170296 C                   If        *in31 = '0' and pltrst = mctrst and
0137000809170296 C                             plsub# = mcsub# and plplan = mcplan and
0138000809120296 C                             (candt = 0 or candt > enrldt)
0139000809120291  *
0140000809120296 C                   If        candt = 0 or candt > cutofn
0141000809120291  *        Get member record
0142000807240297 C     mcssno        chain     member                             32
0143000810200296 C                   If        *in32 = '0'
0144000810200291  *
0145000810200291 C                   exsr      bldmbr
0146000810200291  *
0147000810200297 C                   endif                                                  *in32 = '0'
0148000810200291  *
0149000810200297 C                   endif                                                  candt = 0
0150000810200297 C                   endif                                                  *in31 = '0'
0151000810200297 C                   enddo                                                  *in31 = '1'
0152000810200291  *
0153000810200297 C                   endif                                                  *in22 = '0'
0154000810200291  *
0155000810200297 C                   endif                                                  *in21 = '0'
0156001007090296 C                   If        pcarr > plnkey
0157000808040296 C                   leave
0158000808040297 C                   endif                                                  pcarr > 'EX2'
0159000808040297 C                   enddo                                                  *in21 = '1'
0160000808040291  *
0161001007090296 C                   If        plnkey = 'SAF'
0162001007090296 C                   eval      plnkey = 'HIR'
0163001007090297 C                   else                                                   *in21 = '1'
0164001007090297 C                   leave                                                  pcarr > 'EX2'
0165001007090297 C                   endif                                                  pcarr > 'EX2'
0166001007090297 C                   enddo                                                  *in21 = '1'
0167001007090291  *
0168000808040297 C                   movel     '1'           *inlr
0169000808040297 C                   return
0170000204020107  ********************************************************************************
0171000807290107  *
0172000204020107  *     BLDMBR - Build Member record
0173000807290107  *
0174000204020107  ********************************************************************************
017500080728     C     bldmbr        begsr
017600091002      *         If enroll is more than 30 days out - bypass
017700091002     C                   if        enrldt > day30n
017800091002     C                   leavesr
017900091002     C                   endif
018000111208      *         If Member is a GBS emp - bypass
018100111208     C                   if        mbtrst = 550 and mbsub# = 1 and
018200111208     C                             mbacct = 16
018300111208     C                   leavesr
018400111208     C                   endif
018500100422      *         If mbr already exists and eff date < date - bypass
018600100511     C     mbrky         chain     fscurp                             42
0187001004220296 C                   If        *in42 = '0'
018800100511     C                   if        enrldt > fcefdt
018900100511     C                   delete    fscurr
019000100422     C                   else
019100120126     C                   leavesr
019200120126     C                   endif
019300120126     C                   endif
0194001201260291  *         If member doesn't exist - build record
019500120126     C                   clear                   fscurr
019600120126     C                   movel     mbssno        fcmid#
019700120126     C                   z-add     0             fcseq#
019800120126     C                   movel     mlname        fclnme
019900120126     C                   movel     mfname        fcfnme
020000100511     C                   move      mmi           fcmi
020100100511     C                   movel     addr1         fcadr1
020200100511     C                   movel     addr2         fcadr2
0203000809160107  *
0204001005110296 C                   If        fcadr1 = *blanks and fcadr2 <> *blanks
020500100511     C                   movel(P)  fcadr2        fcadr1
020600100511     C                   movel     *blanks       fcadr2
020700080916     C                   endif                                                  *in62 = '0'
0208000809160107  *
020900100511     C                   movel     city          fccity
021000100511     C                   move      state         fcst
021100100511     C                   z-add     zip           fczip
021200100511     C                   eval      fcarea = area
021300100511     C                   eval      fcphn# = phone
021400100511     C                   z-add     birth         fcbrdt
021500100511     C                   move      sex           fcgndr
021600100511     C                   z-add     enrldt        fcefdt
021700100511     C                   z-add     candt         fctfdt
021800091002     C                   If        candt > day30n
021900100511     C                   z-add     0             fctfdt
022000100423     C                   endif
022100100511     C                   movel     group#        fcgrp#
022200100511     C                   move      mcovtp        fccovt
022300100511     C                   move      mcplan        fcpln
0224001004230291  *        Find rate record and calc yrly rate
0225001004230297 C     rt6ky         setll     grat26                             37
0226001004230296 C                   dou       *in37 = '1'
0227001004230297 C                   read      grat26                                 37
0228001005110296 C                   If        xgrtrst <> mctrst or xgrsub# <> mcsub# or
0229001005110296 C                             xgrplan <> mcplan or xtypecd <> mcovtp
023000081113     C                   leave
023100081113     C                   endif
0232001005110296 C                   If        *in37 = '0' and mcsub# = xgrsub# and
0233001005110296 C                             mcplan = xgrplan
023400110506      *
0235001105060296 C                   If        candt = 0 or (candt >= xfrmdat and
0236001105060296 C                             candt <= xtodat)
023700110506      *
0238001105060296 C                   If        fcgrp# <> '9131           ' and
0239001105060296 C                             fcgrp# <> '9131HR4        '
024000110506     C     12            mult(H)   xnetrte       rate8
024100110506     C                   eval      fcrate = rate8
024200110506     C                   else
024300110506     C                   eval      fcrate = xnetrte * 12
024400110506     C                   endif
024500110506      *
024600110506     C                   eval      fcpefd = xfrmdat
024700110506     C                   eval      fcptrd = xtodat
024800110506     C                   eval      svfrmdt = xfrmdat
024900110506     C                   eval      svtodat = xtodat
025000110506      *
025100100412     C                   leave
025200100412     C                   endif
025300100412     C                   endif
025400081113     C                   enddo
025500081113      ****
025600100511     C                   eval      fcsal = salary
025700100511     C                   eval      fcmardt = mardt
025800100511     C                   eval      fcempdt = empdt
025900100511     C                   eval      fctrmdt = termdt
026000100511     C                   move      mcovtp        fccovt
026100080917      *
026200100511     C                   eval      fctrust = mbtrst
026300100511     C                   eval      fcsub = mbsub#
026400100511     C                   eval      fcacct = mbacct
026500050622     C     acckey        chain     accmst                             51
0266000808210296 C                   If        *in51 = '0'
026700100511     C                   eval      fcacnm = acnam1
026800050622     C                   endif
026900080821      *
0270001104190291  *        See if Debit Card is needed
0271001104190297 C     mbrky         chain     debcard                            42
027200110915     C                   if        *in42 = '0' and dbprsta <> 'C'
027300110419     C                   eval      fccdat = dbtrdat
027400110419     C                   endif                                                  *in62 = '0'
027500110419      *
027600110419      *
027700110419     C                   eval      fcdbtc = pdebit
027800110419      *
0279001005110296 C****               If        fcefdt <> fctfdt
028000100511     C                   write     fscurr
028100051128     C****               endif                                                  *in62 = '0'
0282001109260107  *  Check to see in any dep's get a debit card
0283001109260297 C     mbrky         setll     debcard                            52
0284001109260296 C                   dou       *in52 = '1'
0285001109260297 C                   read      debcard                                52
0286001109260296 C                   If        *in52 = '1' or mbssno <> dbssn
0287001109260296 C                   leave
0288001109260296 C                   endif
0289001109260296 C                   If        *in52 = '0' and mbssno = dbssn and
0290001109260296 C                             dbseq <> 0 and dbprsta = ' '
0291001109260291  *        Write dep rec with debit card info
029200110926     C                   eval      fccdat = dbtrdat
029300110926     C                   eval      fcdbtc = pdebit
0294001109260297 C     depky         chain     depndc                             53
0295001109260296 C                   If        *in53 = '0'
029600110926     C                   z-add     dpseq#        fcseq#
029700110926     C                   movel     dlname        fclnme
029800110926     C                   movel     dfname        fcfnme
029900110926     C                   move      dmi           fcmi
030000110926     C                   z-add     dbirth        fcbrdt
030100110926     C                   move      dsex          fcgndr
030200110926     C                   z-add     0             fcefdt
030300110926     C                   z-add     0             fctfdt
030400110926     C                   eval      fcsal = 0
030500110926     C                   eval      fcmardt = 0
030600110926     C                   eval      fcempdt = 0
030700110926     C                   eval      fctrmdt = 0
030800110926     C                   write     fscurr
030900110926     C                   endif
031000110926     C                   endif
031100110926     C                   enddo
0312001109260291  *
031300020415     C                   endsr
