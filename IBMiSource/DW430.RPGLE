0001000204020002  *****************************************************************************
000200100511      * DW430      Group Benefit Services                                         *
000300110908      *            WRITTEN BY - R.L.J.                                            *
000400110908      *            DATE - 05/2010                                                 *
000500100511      *  DESCRIPTION - Build file opf current FSA Eligibility                     *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800191122      *  04/19/2011 rlj  Populate debit card fields - DBTC and C6AT
000900110915      *  09/15/2011 rlj  DEBCARD - ignore rec if sts = C - Canceled
001000110926      *  09/26/2011 rlj  DEBCARD - add ability to add dep recs for DEBCARD
001100121004      *  10/04/2012 rlj  Do not include carrier code HIR in search
001200150320      *  03/20/2015 rlj  Do not bypass recs due to future eff dates
001300191112      *  11/12/2019 rlj  Add email address to FSCURP from F.MEMBER
0014009102150018 F******************************************************************
0015000204020019 FPLNMSTN1  IF   E           K DISK
001600081112     F**MCOVXX    IF   E           K DISK
001700191202     FMCOV39    IF   E           K DISK
001800191202     FMEMBER    IF   E           K DISK
001900191202     FDEPNDC    IF   E           K DISK
002000191202     FACCMST    IF   E           K DISK
002100191202     FGRAT24    IF   E           K DISK
002200191202     FGRAT26    IF   E           K DISK    PREFIX(X) RENAME(GRATER:GRATEX)
0023001912020020 FFSCURP    UF A E           K DISK
0024001912020020 FDEBCARD   UF   E           K DISK
0025000809160025  *
0026000809160250 D                 DS
0027000809160251 D  mcovtp                 1      3
0028001103310251 D   mcovtp2               2      3
0029001103310025  *
0030000903270250 D                 DS
0031001103310251 D  group#                 1     15
0032001103310251 D   grp4                  1      4
0033001201040025  *
0034001201040250 D                 DS
0035001201040251 D  seq#                          2S 0 INZ(0)
0036001201040251 D  dseq                          2S 0 INZ(0)
0037001201040251 D  cutoff                         D   DATFMT(*ISO)
0038001201040251 D  cutofn                        8S 0
0039001201040251 D  day30                          D   DATFMT(*ISO)
0040000910120251 D  day30n                        8S 0
0041001201040251 D  updt                          1A
0042001201040251 D  rate8                         6S 0
0043001201040251 D  planq                         1A
0044001201040251 D  plnkey                        3A
0045001911120251 D  email                        65A
004600120104      *
0047001201040251 D  bkmid#                             LIKE(fcmid#)
0048001201040251 D  bkseq#                             LIKE(fcseq#)
0049001005110251 D  bklnme                             LIKE(fclnme)
0050001005110251 D  bkfnme                             LIKE(fcfnme)
0051001005110251 D  bkbrdt                             LIKE(fcbrdt)
0052001005110251 D  bkgrp#                             LIKE(fcgrp#)
0053001005110251 D  svgrp#                             LIKE(fcgrp#)
0054001004130251 D  todaa                              LIKE(frmdat)
0055001004130251 D  date9                              LIKE(frmdat)
0056001005110251 D  svrate                             LIKE(fcrate)
0057001004130251 D  svfrmdt                            LIKE(xfrmdat)
0058001201270251 D  svtodat                            LIKE(xtodat)
005900120127      *
006000120127     C     bgkey         klist
006100120123     C                   kfld                    bkmid#
006200120127     C                   kfld                    bkseq#
006300120127     C                   kfld                    bklnme
006400111222     C                   kfld                    bkfnme
006500120127     C                   kfld                    bkbrdt
006600120127      *
006700120123     C     grkey         klist
006800120123     C                   kfld                    pltrst
006900120123     C                   kfld                    plsub#
007000120123     C                   kfld                    plplan
007100100118     C                   kfld                    date9
007200161010      *
007300161010     C     mcvky         klist
007400100118     C                   kfld                    pltrst
007500100118     C                   kfld                    plsub#
007600120123     C                   kfld                    plplan
007700120123      *
007800120123     C     rt6ky         klist
007900120123     C                   kfld                    mctrst
008000120123     C                   kfld                    mcsub#
008100081113     C                   kfld                    mcplan
008200120123     C                   kfld                    mcovtp
008300120123     C                   kfld                    date9
008400120123      *
008500120123     C     acckey        klist
008600120123     C                   kfld                    mbtrst
008700120123     C                   kfld                    mbsub#
008800120123     C                   kfld                    mbacct
008900120123      *
009000191202     C     mbrky         klist
009100191202     C                   kfld                    mbssno
009200191202     C                   kfld                    seq#
009300191202      *
009400191202     C     depky         klist
009500191202     C                   kfld                    dbssn
009600191202     C                   kfld                    dbseq
0097001912020291  *   Preprocessing
0098001912020297 C                   movel     UDATE         cutoff
0099001912020297 C                   movel     cutoff        todaa
0100000810200297 C                   z-add     99999999      date9
0101001912020291  * Determine Term date cutoff - 1 year ago
0102000807240297 C     cutoff        subdur    365:*D        cutoff
0103000810200297 C                   movel     cutoff        cutofn
010400191202      *
0105001912020297 C                   movel     UDATE         day30
0106001912020291  *
0107001912020297 C     day30         adddur    30:*D         day30
0108001912020297 C                   movel     day30         day30n
010900191202      *
0110001912020291  * Main Line - Loop thru plan master
0111001912020297 C                   eval      plnkey = 'SAF'
0112001912020296 C*******            dou       plnkey > 'XXX'
0113001912020297 C     plnkey        setll     plnmstn1                           21
0114001912020296 C                   dou       *in21 = '1' or pcarr <> 'SAF'
0115001912020297 C     plnkey        reade     plnmstn1                               21
0116001001130296 C                   If        *in21 = '0' and pldltd = 'A' and
0117001007090296 C                             pcarr = plnkey
0118001409080291  *      Bypass Admin plans per Shelly
0119002105050296 C                   If        plncat = 'PFS' or sfadm = 'Y'
0120001409080296 C                   iter
0121001409080296 C                   endif
0122000809150291  *        Get GRATE record
0123000809150297 C     grkey         setll     grat24                             22
0124000809150297 C                   readp     grat24                                 22
0125000809150296 C                   If        *in22 = '0'
0126000903300296 C                   movel     group#        svgrp#
0127000809150291  *** ** DEBUG SHIT
0128000809150296 C**** ****          If        GROUP# = '7200           '
0129000809150296 C***** ****         movel     GROUP#        group#
0130000807290296 C****** ************endif
0131000809170291  *
0132000809170291  *        Loop thru mcov file using T,S,P
0133000811120297 C     mcvky         setll     mcov39                             31
0134000809170296 C                   dou       *in31 = '1'
0135000811120297 C     mcvky         reade     mcov39                                 31
0136000809170291  *       DEBUG
0137001210010296 C                   If        mcssno = 003686889 or
0138001210010296 C                             mcssno = 003686889
0139000809170296 C                   eval      mcssno = mcssno
0140000809170296 C                   endif
0141000809170291  *
0142000809170296 C                   If        *in31 = '0' and pltrst = mctrst and
0143000809170296 C                             plsub# = mcsub# and plplan = mcplan and
0144000809120296 C                             (candt = 0 or candt > enrldt)
0145000809120291  *
0146000809120296 C                   If        candt = 0 or candt > cutofn
0147000809120291  *        Get member record
0148000807240297 C     mcssno        chain     member                             32
0149000810200296 C                   If        *in32 = '0'
0150000810200291  *
0151000810200291 C                   exsr      bldmbr
0152000810200291  *
0153000810200297 C                   endif                                                  *in32 = '0'
0154000810200291  *
0155000810200297 C                   endif                                                  candt = 0
0156000810200297 C                   endif                                                  *in31 = '0'
0157000810200297 C                   enddo                                                  *in31 = '1'
0158000810200291  *
0159000810200297 C                   endif                                                  *in22 = '0'
0160000810200291  *
0161000810200297 C                   endif                                                  *in21 = '0'
0162001007090296 C                   If        pcarr > plnkey
0163000808040296 C                   leave
0164000808040297 C                   endif                                                  pcarr > 'EX2'
0165000808040297 C                   enddo                                                  *in21 = '1'
0166000808040291  *
0167001210040296 C*************      If        plnkey = 'SAF'
0168001210040296 C***                eval      plnkey = 'HIR'
0169001210040297 C***                else                                                   *in21 = '1'
0170001210040297 C***                leave                                                  pcarr > 'EX2'
0171001210040297 C***                endif                                                  pcarr > 'EX2'
0172001210040297 C*************      enddo                                                  *in21 = '1'
0173001007090291  *
0174000808040297 C                   movel     '1'           *inlr
0175000808040297 C                   return
0176000204020107  ********************************************************************************
0177000807290107  *
0178000204020107  *     BLDMBR - Build Member record
0179000807290107  *
0180000204020107  ********************************************************************************
018100080728     C     bldmbr        begsr
018200091002      *         If enroll is more than 30 days out - bypass
018300150320      *     Removed per instructions by WA 3/20/15
018400150320     C********           if        enrldt > day30n
018500150320     C****               leavesr
018600150320     C********           endif
018700111208      *         If Member is a GBS emp - bypass
018800111208     C                   if        mbtrst = 550 and mbsub# = 1 and
018900111208     C                             mbacct = 16
019000111208     C                   leavesr
019100111208     C                   endif
019200191122      *         If mbr already exists and eff date < 4444 - bypass
019300100511     C     mbrky         chain     fscurp                             42
0194001004220296 C                   If        *in42 = '0'
019500100511     C                   if        enrldt > fcefdt
019600100511     C                   delete    fscurr
019700100422     C                   else
019800120126     C                   leavesr
019900120126     C                   endif
020000120126     C                   endif
0201001201260291  *         If member doesn't exist - build record
020200120126     C                   clear                   fscurr
020300120126     C                   movel     mbssno        fcmid#
020400120126     C                   z-add     0             fcseq#
020500120126     C                   movel     mlname        fclnme
020600120126     C                   movel     mfname        fcfnme
020700100511     C                   move      mmi           fcmi
020800100511     C                   movel     addr1         fcadr1
020900100511     C                   movel     addr2         fcadr2
0210000809160107  *
0211001005110296 C                   If        fcadr1 = *blanks and fcadr2 <> *blanks
021200100511     C                   movel(P)  fcadr2        fcadr1
021300100511     C                   movel     *blanks       fcadr2
021400080916     C                   endif                                                  *in62 = '0'
0215001911120107  *
021600191112     C                   eval      email = %Subst( Fill66 : 1 : 65)
021700191112     C                   movel(P)  email         fcemal
0218000809160107  *
021900100511     C                   movel     city          fccity
022000100511     C                   move      state         fcst
022100100511     C                   z-add     zip           fczip
022200100511     C                   eval      fcarea = area
022300100511     C                   eval      fcphn# = phone
022400100511     C                   z-add     birth         fcbrdt
022500100511     C                   move      sex           fcgndr
022600100511     C                   z-add     enrldt        fcefdt
022700100511     C                   z-add     candt         fctfdt
022800150320     C                   If        candt > day30n and enrldt <> candt
022900100511     C                   z-add     0             fctfdt
023000100423     C                   endif
023100100511     C                   movel     group#        fcgrp#
023200100511     C                   move      mcovtp        fccovt
023300100511     C                   move      mcplan        fcpln
0234001004230291  *        Find rate record and calc yrly rate
0235001004230297 C     rt6ky         setll     grat26                             37
0236001004230296 C                   dou       *in37 = '1'
0237001004230297 C                   read      grat26                                 37
0238001005110296 C                   If        xgrtrst <> mctrst or xgrsub# <> mcsub# or
0239001005110296 C                             xgrplan <> mcplan or xtypecd <> mcovtp
024000081113     C                   leave
024100081113     C                   endif
0242001005110296 C                   If        *in37 = '0' and mcsub# = xgrsub# and
0243001005110296 C                             mcplan = xgrplan
024400191122      *
0245001911220296 C                   If        candt = 0 or (candt >= xfrmdat and
0246001911220296 C                             candt <= xtodat)
024700191122      *
0248001911220296 C                   If        fcgrp# <> '9131           ' and
0249001911220296 C                             fcgrp# <> '9131HR4        '
025000191122     C     12            mult(H)   xnetrte       rate8
025100191122     C                   eval      fcrate = rate8
025200191122     C                   else
025300191122     C                   eval      fcrate = xnetrte * 12
025400191122     C                   endif
025500191122      *
025600191122     C                   eval      fcpefd = xfrmdat
025700191122     C                   eval      fcptrd = xtodat
025800191122     C                   eval      svfrmdt = xfrmdat
025900191122     C                   eval      svtodat = xtodat
026000191122      *
026100100412     C                   leave
026200100412     C                   endif
026300100412     C                   endif
026400081113     C                   enddo
026500081113      ****
026600100511     C                   eval      fcsal = salary
026700100511     C                   eval      fcmardt = mardt
026800100511     C                   eval      fcempdt = empdt
026900100511     C                   eval      fctrmdt = termdt
027000100511     C                   move      mcovtp        fccovt
027100080917      *
027200100511     C                   eval      fctrust = mbtrst
027300100511     C                   eval      fcsub = mbsub#
027400100511     C                   eval      fcacct = mbacct
027500050622     C     acckey        chain     accmst                             51
0276000808210296 C                   If        *in51 = '0'
027700100511     C                   eval      fcacnm = acnam1
027800050622     C                   endif
027900080821      *
0280001104190291  *        See if Debit Card is needed
0281001104190297 C     mbrky         chain     debcard                            42
028200110915     C                   if        *in42 = '0' and dbprsta <> 'C'
028300110419     C                   eval      fccdat = dbtrdat
028400110419     C                   endif                                                  *in62 = '0'
028500110419      *
028600110419      *
028700110419     C                   eval      fcdbtc = pdebit
028800110419      *
0289001005110296 C****               If        fcefdt <> fctfdt
029000100511     C                   write     fscurr
029100051128     C****               endif                                                  *in62 = '0'
0292001109260107  *  Check to see in any dep's get a debit card
0293001109260297 C     mbrky         setll     debcard                            52
0294001109260296 C                   dou       *in52 = '1'
0295001109260297 C                   read      debcard                                52
0296001109260296 C                   If        *in52 = '1' or mbssno <> dbssn
0297001109260296 C                   leave
0298001109260296 C                   endif
0299001109260296 C                   If        *in52 = '0' and mbssno = dbssn and
0300001109260296 C                             dbseq <> 0 and dbprsta = ' '
0301001610310291  *        Write dep rec with debit card info
030200161031     C                   eval      fccdat = dbtrdat
030300161031     C                   eval      fcdbtc = pdebit
0304001610310297 C     depky         chain     depndc                             53
0305001610310296 C                   If        *in53 = '0'
030600161031     C                   z-add     dpseq#        fcseq#
030700161031     C                   movel     dlname        fclnme
030800161031     C                   movel     dfname        fcfnme
030900161031     C                   move      dmi           fcmi
031000161031     C                   z-add     dbirth        fcbrdt
031100161031     C                   move      dsex          fcgndr
031200161031     C                   z-add     0             fcefdt
031300161031     C                   z-add     0             fctfdt
031400161031     C                   eval      fcsal = 0
031500161031     C                   eval      fcmardt = 0
031600161031     C                   eval      fcempdt = 0
031700161031     C                   eval      fctrmdt = 0
031800161031     C                   write     fscurr
031900161031     C                   endif
032000161031     C                   endif
032100161031     C                   enddo
0322001610310291  *
032300161031     C                   endsr
