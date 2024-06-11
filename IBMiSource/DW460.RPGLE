0001000204020002  *****************************************************************************
000200080429      * DW460      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400080429      *            DATE - 04/2008                                                 *
000500080429      *  DESCRIPTION - Build file of current Phase One Consulting                 *
000600020402      *                Eligibility.                                               *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900080429      *  mm/dd/yyyy xxx
0010009102150018 F******************************************************************
001100020403     FMCOVXX    IF   E           K DISK
001200020404     FMEMBER    IF   E           K DISK
001300020404     FDCOV      IF   E           K DISK
001400020404     FDEPNDC    IF   E           K DISK
0015000804290020 FP1CURL    UF A E           K DISK
0016000204020025  *
0017009102150250 D                 DS
0018000508240251 D  mcovtp                 1      3
0019000508240251 D   mcovtp2               2      3
0020000508240025  *
0021000508240250 D                 DS
0022000508240251 D  dseq                          2S 0 INZ(0)
0023000508240251 D  cutoff                         D   DATFMT(*ISO)
0024000204030251 D  cutofn                        8S 0
0025000204150251 D  updt                          1A
002600050920      *
0027000804290251 D  ktrst                              LIKE(mctrst)
0028000804290251 D  ksub#                              LIKE(mcsub#)
0029000804290251 D  kplan                              LIKE(mcplan)
0030000804290251 D  bkplan                             LIKE(mcplan)
0031000804290251 D  bkmid#                             LIKE(p1mid#)
0032000804290251 D  bkseq#                             LIKE(p1seq#)
0033000804290251 D  bklnme                             LIKE(p1lnme)
0034000804290251 D  bkfnme                             LIKE(p1fnme)
0035000804290251 D  bkbrdt                             LIKE(p1brdt)
0036000804290251 D  todaa                              LIKE(candt)
0037000804290251 D  date9                              LIKE(candt)
003800020415      *
003900050610     C     bgkey         klist
004000050610     C                   kfld                    bkmid#
004100050920     C                   kfld                    bkseq#
004200050920     C                   kfld                    bklnme
004300050920     C                   kfld                    bkfnme
004400050610     C                   kfld                    bkbrdt
004500080429     C                   kfld                    bkplan
004600020613      *
004700080429     C     mcvky         klist
004800080429     C                   kfld                    ktrst
004900080429     C                   kfld                    ksub#
005000080429     C                   kfld                    kplan
005100020402      *
005200020404     C     depky         klist
005300020402     C                   kfld                    mbssno
005400020404     C                   kfld                    dseq#
0055000206130291  *   Preprocessing
0056000206130297 C                   movel     UDATE         cutoff
0057000206130297 C                   movel     cutoff        todaa
0058000207230297 C                   z-add     99999999      date9
0059000206130291  * Determine Term date cutoff - 1 year ago
0060000204040297 C     cutoff        subdur    365:*D        cutoff
0061000204030297 C                   movel     cutoff        cutofn
006200020402      *
0063000804290291  * Main Line
0064000804290297 C                   eval      ktrst = 591
0065000804290297 C                   eval      ksub# = 4
0066000804290297 C                   eval      kplan = '96N1'
0067000207230291  *
0068000204030291  *        Loop thru mcov file using T,S,P
0069000204030297 C     mcvky         setll     mcovxx                             31
0070000204020296 C                   dou       *in31 = '1'
0071000804290297 C                   read      mcovxx                                 31
0072000804290296 C                   If        *in31 = '0' and
0073000804290296 C                             mcsub# = 4
0074000611070291  *       DEBUG
0075000804240296 C                   If        mcssno = 167545198 or
0076000804240296 C                             mcssno = 167545198
0077000611070296 C                   eval      mcssno = mcssno
0078000611070296 C                   endif
0079000611070291  *
0080000804290296 C                   If        mcplan > '96S1'
0081000804290296 C                   leave
0082000804290296 C                   endif
0083000509200291  *
0084000509200296 C                   If        candt = 0 or candt > cutofn
0085000509200291  *        Get member record
0086000204030297 C     mcssno        chain     member                             32
0087000509200296 C                   If        *in32 = '0'
0088000509200291  *
0089000509200291 C                   exsr      bldmbr
0090000509200291  *
0091000204040291  *        Look for dependents of member
0092000204040297 C     mcssno        setll     dcov                               33
0093000204040296 C                   dou       *in33 = '1'
0094000204040297 C     mcssno        reade     dcov                                   33
0095000804290296 C                   If        *in33 = '0' and mctrst = dvtrst and
0096000804290296 C                             mcsub# = dvsub# and mcplan = dvplan
0097000206040291  *
0098000802280296 C                   If        ccandt = denrdt
0099000802280296 C                   iter
0100000802280296 C                   endif
0101000802280291  *
0102000802280296 C                   If        ccandt = 0 or ccandt > cutofn
0103000204040291  *
0104000204040291 C                   exsr      blddep
0105000206040291  *
0106000206040297 C                   endif                                                  ccandt = 0
0107000204040291  *
0108000204040297 C                   endif                                                  *in33 = '0'
0109000204040291  *
0110000204040297 C                   enddo                                                  *in33 = '1'
0111000204040291  *
0112000204040297 C                   endif                                                  *in32 = '0'
0113000204030291  *
0114000204040297 C                   endif                                                  candt = 0
0115000204040297 C                   endif                                                  *in31 = '0'
0116000204020297 C                   enddo                                                  *in31 = '1'
0117000204020291  *
0118000204020297 C                   movel     '1'           *inlr
0119000204020297 C                   return
0120000204020107  ********************************************************************************
0121000204020107  *
0122000204020107  *     BLDMBR - Build Member record
0123000204020107  *
0124000204020107  ********************************************************************************
012500020402     C     bldmbr        begsr
0126000204150107  *      First see if member record exists
012700050517     C                   movel     mbssno        bkmid#
012800050517     C                   z-add     0             bkseq#
012900050517     C                   movel     mlname        bklnme
013000050517     C                   movel     mfname        bkfnme
013100050517     C                   eval      bkbrdt = birth
013200080429     C                   eval      bkplan = mcplan
0133000804290297 C     bgkey         chain     p1curl                             62
0134000804290296 C                   If        *in62 = '0' and p1covt = mcovtp2
0135000204150291  *         Set effective and term dates
013600020415     C                   movel     ' '           updt
0137000804290296 C                   If        enrldt < p1efdt
013800080429     C                   z-add     enrldt        p1efdt
013900020415     C                   movel     'Y'           updt
014000020415     C                   endif
0141000206200291  *         Set term date - if any term date = 0 => keep it
0142000804290296 C                   If        p1tfdt <> 0
0143000804290296 C                   If        candt > p1tfdt or
0144000204150296 C                             candt = 0
014500080429     C                   z-add     candt         p1tfdt
014600020415     C                   movel     'Y'           updt
014700020415     C                   endif
014800020620     C                   endif
0149000206200291  *
0150000204150296 C                   If        updt = 'Y'
015100080429     C                   update    p1curr
015200020415     C                   endif
0153000204150291  *         If member doesn't exist - build record
015400020415     C                   else
015500080429     C                   clear                   p1curr
015600080429     C                   movel     mbssno        p1mid#
015700080429     C                   z-add     0             p1seq#
015800080429     C                   movel     mlname        p1lnme
015900080429     C                   movel     mfname        p1fnme
016000080429     C                   move      mmi           p1mi
016100080429     C                   movel     addr1         p1adr1
016200080429     C                   movel     addr2         p1adr2
0163000505170107  *
0164000804290296 C                   If        p1adr1 = *blanks and p1adr2 <> *blanks
016500080429     C                   movel(P)  p1adr2        p1adr1
016600080429     C                   movel     *blanks       p1adr2
016700030327     C                   endif                                                  *in62 = '0'
0168000303270107  *
016900080429     C                   movel     city          p1city
017000080429     C                   move      state         p1st
017100080429     C                   z-add     zip           p1zip
017200080429     C                   eval      p1area = area
017300080429     C                   eval      p1phn# = phone
017400080429     C                   z-add     birth         p1brdt
017500080429     C                   move      sex           p1gndr
017600080429     C                   z-add     enrldt        p1efdt
017700080429     C                   z-add     candt         p1tfdt
017800080429     C                   move      mcovtp        p1covt
017900080429     C                   move      mcplan        p1plan
018000080429     C                   eval      p1sal = salary
018100080429     C                   eval      p1mardt = mardt
018200080429     C                   eval      p1empdt = empdt
018300080429     C                   eval      p1trmdt = termdt
018400080429     C                   move      mcovtp        p1covt
018500050622      *
018600080429     C                   write     p1curr
0187000211040107  *
018800020415     C                   endif                                                  *in62 = '0'
0189000204150107  *
019000020415     C                   endsr
0191000204150107  ********************************************************************************
0192000204040107  *
0193000204040107  *     BLDDEP - Build Dependent Record
0194000204040107  *
0195000204040107  ********************************************************************************
019600020404     C     blddep        begsr
019700020404     C                   endsr
019800020402     C*
