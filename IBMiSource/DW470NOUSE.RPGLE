0001000204020002  *****************************************************************************
000200080603      * DW470      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400080603      *            DATE - 06/2008                                                 *
000500080603      *  DESCRIPTION - Build file of Benegap Accounts                             *
0006000204020002  *****************************************************************************
0007000204020015  *  Change Log:                                                              *
000800080603      *  mm/dd/yyyy xxx
0009009102150018 F******************************************************************
0010000204020019 FPLNMSTN1  IF   E           K DISK
001100050622     FACCMST    IF   E           K DISK
001200020404     FGRAT24    IF   E           K DISK
0013000806030020 FBGaccp    UF A E           K DISK
0014000204020025  *
0015009102150250 D                 DS
0016000508240251 D  mcovtp                 1      3
0017000508240251 D   mcovtp2               2      3
0018000508240025  *
0019000508240250 D                 DS
0020000508240251 D  dseq                          2S 0 INZ(0)
0021000508240251 D  cutoff                         D   DATFMT(*ISO)
0022000204030251 D  cutofn                        8S 0
0023000204150251 D  updt                          1A
002400050920      *
0025000509200251 D  bkmid#                             LIKE(bcmid#)
0026000509200251 D  bkseq#                             LIKE(bcseq#)
0027000509200251 D  bklnme                             LIKE(bclnme)
0028000509200251 D  bkfnme                             LIKE(bcfnme)
0029000508250251 D  bkbrdt                             LIKE(bcbrdt)
0030000508250251 D  bkgrp#                             LIKE(bcgrp#)
0031000206130251 D  todaa                              LIKE(frmdat)
0032000207230251 D  date9                              LIKE(frmdat)
003300020415      *
003400050610     C     bgkey         klist
003500050610     C                   kfld                    bkmid#
003600080721     C                   kfld                    bkseq#
003700080721     C                   kfld                    bklnme
003800080721     C                   kfld                    bkfnme
003900080721     C                   kfld                    bkbrdt
004000080721      *
004100080711     C     grkey         klist
004200080721     C                   kfld                    pltrst
004300080711     C                   kfld                    plsub#
004400020415     C                   kfld                    plplan
004500080711     C                   kfld                    date9
004600020613      *
004700020613     C     mcvky         klist
004800020613     C                   kfld                    pltrst
004900020613     C                   kfld                    plsub#
005000020613     C                   kfld                    plplan
005100050622      *
005200050622     C     acckey        klist
005300050622     C                   kfld                    mbtrst
005400050622     C                   kfld                    mbsub#
005500050622     C                   kfld                    mbacct
005600020402      *
005700020404     C     depky         klist
005800020402     C                   kfld                    mbssno
005900020404     C                   kfld                    dseq#
0060000206130291  *   Preprocessing
0061000206130297 C                   movel     UDATE         cutoff
0062000206130297 C                   movel     cutoff        todaa
0063000207230297 C                   z-add     99999999      date9
0064000206130291  * Determine Term date cutoff - 1 year ago
0065000204040297 C     cutoff        subdur    365:*D        cutoff
0066000204030297 C                   movel     cutoff        cutofn
006700020402      *
0068000204020291  * Main Line - Loop thru plan master
0069000510050297 C     'BEN'         setll     plnmstn1                           21
0070000510050296 C                   dou       *in21 = '1'
0071000510050297 C     'BEN'         reade     plnmstn1                               21
0072000510050296 C                   If        *in21 = '0' and pldltd = 'A' and
0073000510050296 C                             pcarr = 'BEN'
0074000510050291  *
0075000204040291  *        Get GRATE record
0076000509200297 C     grkey         setll     grat24                             22
0077000509200297 C                   readp     grat24                                 22
0078000509200296 C                   If        *in22 = '0'
0079000207230291  ****** DEBUG SHIT
0080000207240296 C*********          If        GROUP# = '7200           '
0081000207240296 C**********         movel     GROUP#        group#
0082000207240296 C*******************endif
0083000207230291  *
0084000204030291  *        Loop thru mcov file using T,S,P
0085000204030297 C     mcvky         setll     mcovxx                             31
0086000204020296 C                   dou       *in31 = '1'
0087000204030297 C     mcvky         reade     mcovxx                                 31
0088000611070291  *       DEBUG
0089000804240296 C                   If        mcssno = 167545198 or
0090000804240296 C                             mcssno = 167545198
0091000611070296 C                   eval      mcssno = mcssno
0092000611070296 C                   endif
0093000611070291  *
0094000509200296 C                   If        *in31 = '0' and pltrst = mctrst and
0095000509200296 C                             plsub# = mcsub# and plplan = mcplan and
0096000802280296 C                             (candt = 0 or candt > enrldt)
0097000509200291  *
0098000509200296 C                   If        candt = 0 or candt > cutofn
0099000509200291  *        Get member record
0100000204030297 C     mcssno        chain     member                             32
0101000509200296 C                   If        *in32 = '0'
0102000509200291  *
0103000509200291 C                   exsr      bldmbr
0104000509200291  *
0105000204040291  *        Look for dependents of member
0106000204040297 C     mcssno        setll     dcov                               33
0107000204040296 C                   dou       *in33 = '1'
0108000204040297 C     mcssno        reade     dcov                                   33
0109000204040296 C                   If        *in33 = '0' and pltrst = dvtrst and
0110000204040296 C                             plsub# = dvsub# and plplan = dvplan
0111000206040291  *
0112000802280296 C                   If        ccandt = denrdt
0113000802280296 C                   iter
0114000802280296 C                   endif
0115000802280291  *
0116000802280296 C                   If        ccandt = 0 or ccandt > cutofn
0117000204040291  *
0118000204040291 C                   exsr      blddep
0119000206040291  *
0120000206040297 C                   endif                                                  ccandt = 0
0121000204040291  *
0122000204040297 C                   endif                                                  *in33 = '0'
0123000204040291  *
0124000204040297 C                   enddo                                                  *in33 = '1'
0125000204040291  *
0126000204040297 C                   endif                                                  *in32 = '0'
0127000204030291  *
0128000204040297 C                   endif                                                  candt = 0
0129000204040297 C                   endif                                                  *in31 = '0'
0130000204020297 C                   enddo                                                  *in31 = '1'
0131000204020291  *
0132000204040297 C                   endif                                                  *in22 = '0'
0133000204040291  *
0134000204040297 C                   endif                                                  *in21 = '0'
0135000505170296 C                   If        pcarr > 'BEN'
0136000204030296 C                   leave
0137000204030297 C                   endif                                                  pcarr > 'EX2'
0138000204020297 C                   enddo                                                  *in21 = '1'
0139000204020291  *
0140000204020297 C                   movel     '1'           *inlr
0141000204020297 C                   return
0142000204020107  ********************************************************************************
0143000204020107  *
0144000204020107  *     BLDMBR - Build Member record
0145000204020107  *
0146000204020107  ********************************************************************************
014700020402     C     bldmbr        begsr
0148000204150107  *      First see if member record exists
014900050517     C                   movel     mbssno        bkmid#
015000050517     C                   z-add     0             bkseq#
015100050517     C                   movel     mlname        bklnme
015200050517     C                   movel     mfname        bkfnme
015300050517     C                   eval      bkbrdt = birth
015400050517     C*******            movel     group#        ekgrp#
015500050517     C********           move      mcovtp        ekf002
0156000505170297 C     bgkey         chain     bgcurl                             62
0157000508240296 C                   If        *in62 = '0' and bccovt = mcovtp2
0158000204150291  *         Set effective and term dates
015900020415     C                   movel     ' '           updt
0160000505170296 C                   If        enrldt < bcefdt
016100050517     C                   z-add     enrldt        bcefdt
016200020415     C                   movel     'Y'           updt
016300020415     C                   endif
0164000206200291  *         Set term date - if any term date = 0 => keep it
0165000505170296 C                   If        bctfdt <> 0
0166000505170296 C                   If        candt > bctfdt or
0167000204150296 C                             candt = 0
016800050517     C                   z-add     candt         bctfdt
016900020415     C                   movel     'Y'           updt
017000020415     C                   endif
017100020620     C                   endif
0172000206200291  *
0173000204150296 C                   If        updt = 'Y'
017400050517     C                   update    bgcurr
017500020415     C                   endif
0176000204150291  *         If member doesn't exist - build record
017700020415     C                   else
017800050523     C                   clear                   bgcurr
017900050517     C                   movel     mbssno        bcmid#
018000050517     C                   z-add     0             bcseq#
018100050517     C                   movel     mlname        bclnme
018200050517     C                   movel     mfname        bcfnme
018300050517     C                   move      mmi           bcmi
018400050517     C                   movel     addr1         bcadr1
018500050517     C                   movel     addr2         bcadr2
0186000505170107  *
0187000505170296 C                   If        bcadr1 = *blanks and bcadr2 <> *blanks
018800050517     C                   movel(P)  bcadr2        bcadr1
018900050517     C                   movel     *blanks       bcadr2
019000030327     C                   endif                                                  *in62 = '0'
0191000303270107  *
019200050517     C                   movel     city          bccity
019300050517     C                   move      state         bcst
019400050517     C                   z-add     zip           bczip
019500050523     C                   eval      bcarea = area
019600050523     C                   eval      bcphn# = phone
019700050517     C                   z-add     birth         bcbrdt
019800050517     C                   move      sex           bcgndr
019900050517     C                   z-add     enrldt        bcefdt
020000050517     C                   z-add     candt         bctfdt
020100050517     C                   movel     group#        bcgrp#
020200050517     C                   move      mcovtp        bccovt
020300070816     C                   move      mcplan        bcplan
020400050523     C                   eval      bcsal = salary
020500050523     C                   eval      bcmardt = mardt
020600050523     C                   eval      bcempdt = empdt
020700050523     C                   eval      bctrmdt = termdt
020800050523     C                   move      mcovtp        bccovt
020900050622      *
021000050622     C                   eval      bctrst = mbtrst
021100050622     C                   eval      bcsub = mbsub#
021200050622     C                   eval      bcacct = mbacct
021300050622     C     acckey        chain     accmst                             51
0214000506220296 C                   If        *in51 = '0'
021500050622     C                   eval      bcacnm = acnam1
021600050622     C                   endif
021700050622      *
0218000511280296 C****               If        bcefdt <> bctfdt
021900050517     C                   write     bgcurr
022000070816     C                   write     bgcur2r
022100051128     C****               endif                                                  *in62 = '0'
0222000211040107  *
022300020415     C                   endif                                                  *in62 = '0'
0224000204150107  *
022500020415     C                   endsr
0226000204150107  ********************************************************************************
0227000204040107  *
0228000204040107  *     BLDDEP - Build Dependent Record
0229000204040107  *
0230000204040107  ********************************************************************************
023100020404     C     blddep        begsr
0232000204040291  *        Get Dependent record
0233000204040297 C     depky         chain     depndc                             42
0234000211040296 C                   If        *in42 = '0' and
0235000703130296 C                             (ccandt = 0 or ccandt >= denrdt)
0236000204040291  *
0237000204150107  *      First see if depend record exists
0238000508240291  *       DEBUG
0239000508240296 C                   If        mbssno = 324649685
0240000508240296 C                   eval      mbssno = mbssno
0241000508240296 C                   endif
0242000508240291  *
024300050517     C                   movel     mbssno        bkmid#
024400050824     C                   z-add     dseq#         bkseq#
024500050517     C                   movel     mlname        bklnme
0246000204150107  *
024700020415     C                   if        dlname = 'SAME'
024800050517     C                   movel     mlname        bklnme
024900020415     C                   else
025000050517     C                   movel     dlname        bklnme
025100020415     C                   endif
0252000204150107  *
025300050517     C                   movel     dfname        bkfnme
025400050517     C                   eval      bkbrdt = dbirth
0255000505170297 C     bgkey         chain     bgcurl                             62
0256000204150296 C                   If        *in62 = '0'
0257000204150291  *         Set effective and term dates
025800020415     C                   movel     ' '           updt
0259000505170296 C                   If        denrdt < bcefdt
026000050517     C                   z-add     denrdt        bcefdt
026100020415     C                   movel     'Y'           updt
026200020415     C                   endif
0263000209260291  *         Set term date - if any term date = 0 => keep it
0264000505170296 C                   If        bctfdt <> 0
0265000505170296 C                   If        ccandt > bctfdt or
0266000204150296 C                             ccandt = 0
026700050517     C                   z-add     ccandt        bctfdt
026800020415     C                   movel     'Y'           updt
026900020415     C                   endif
027000020926     C                   endif
0271000204150296 C                   If        updt = 'Y'
027200050517     C                   update    bgcurr
027300020415     C                   endif
0274000204150291  *         If member doesn't exist - build record
027500020415     C                   else
027600050523     C                   clear                   bgcurr
027700050517     C                   movel     mbssno        bcmid#
027800050523     C                   z-add     dpseq#        bcseq#
027900050523     C                   eval      bcdssn = depss#
0280000204040107  *
028100020404     C                   if        dlname = 'SAME'
028200050517     C                   movel     mlname        bclnme
028300020404     C                   else
028400050517     C                   movel     dlname        bclnme
028500020404     C                   endif
0286000204040107  *
028700050517     C                   movel     dfname        bcfnme
028800050517     C                   move      dmi           bcmi
0289000204040107  *
029000020404     C                   if        daddr1 = 'SAME'
029100050517     C                   movel     addr1         bcadr1
029200050517     C                   movel     addr2         bcadr2
029300050517     C                   movel     city          bccity
029400050517     C                   move      state         bcst
029500050517     C                   z-add     zip           bczip
029600050523     C                   eval      bcarea = area
029700050523     C                   eval      bcphn# = phone
029800020404     C                   else
029900050517     C                   movel     daddr1        bcadr1
030000050517     C                   movel     daddr2        bcadr2
030100050517     C                   movel     dcity         bccity
030200050517     C                   move      dstate        bcst
030300050517     C                   z-add     dzip          bczip
030400050523     C                   eval      bcarea = darea
030500050523     C                   eval      bcphn# = dphone
030600020404     C                   endif
0307000204040107  *
030800050517     C                   z-add     dbirth        bcbrdt
030900050517     C                   move      dsex          bcgndr
031000050517     C                   z-add     denrdt        bcefdt
031100050517     C                   z-add     ccandt        bctfdt
031200050517     C                   movel     group#        bcgrp#
031300050825     C                   move      mcovtp        bccovt
031400070816     C                   move      dvplan        bcplan
031500050825     C                   move      drelcd        bcrelcd
031600050825      *
031700050825     C                   eval      bctrst = mbtrst
031800050825     C                   eval      bcsub = mbsub#
031900050825     C                   eval      bcacct = mbacct
032000050622     C                   eval      bcacnm = acnam1
032100050622      *
032200050517     C                   write     bgcurr
032300070816     C                   write     bgcur2r
0324000204150107  *
032500020415     C                   endif                                                  *in62 = '0'
0326000204040291  *
0327000204040297 C                   endif                                                  *in42 = '0'
032800020404     C                   endsr
032900020402     C*
