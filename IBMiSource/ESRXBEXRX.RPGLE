0001000204020002  *****************************************************************************
000200210525      * ESRXBEXRX  Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400210510      *            DATE - 05/2021                                                 *
000500200527      *  DESCRIPTION - Build file of current Express Scripts (ESI)                *
000600210525      *                Elig - ESI 1500 East Format - RxBenefits TEST              *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900210510      *  xxx mm/mm/yyyy                                                           *
001000200828      *
0011009102150018 F******************************************************************
0012000501110019 FPLNMSTN1  IF   E           K DISK
001300200827     FMCOV42    IF   E           K DISK
001400020404     FMEMBER    IF   E           K DISK
001500020404     FGRAT24    IF   E           K DISK
001600020404     FDCOV      IF   E           K DISK
001700020404     FDEPNDC    IF   E           K DISK
0018002105100020 FESRXBHDP  UF A E           K DISK
0019002105100020 FESRXBDTP  UF A E           K DISK
0020002105100020 FESRXBTRP  UF A E           K DISK
0021000204020025  *
002200200529      *
0023002005290250 D                 DS
0024002005290251 D  fill66                 1     66
0025002005290251 D   gemail                1     65
002600200529      *
0027002005290250 D                 DS
0028002005290251 D  reccnt                 1      9S 0 INZ(0)
0029002005290251 D  reccna                 1      9
003000200529      *
0031000906120250 D                 DS
0032000906120251 D  dseq                          2S 0 INZ(0)
0033000906120251 D  cutoff                         D   DATFMT(*ISO)
0034002005290251 D  cutofx                         D   DATFMT(*ISO)
0035002005290251 D  cutofy                         D   DATFMT(*ISO)
0036002105210251 D  cutofn                        8S 0
0037002105210251 D  cutofa                        8S 0
0038002105210251 D  today8                        8S 0
0039002105210251 D  updt                          1A
004000210521      *
0041002105210251 D  todaa                              LIKE(frmdat)
0042002105210251 D  date9                              LIKE(frmdat)
004300210521      *
0044002105210251 D  svadr1                             LIKE(ecdadd1)
0045002105210251 D  svadr2                             LIKE(ecdadd2)
0046002105210251 D  svcity                             LIKE(ecdcity)
0047002105210251 D  svst                               LIKE(ecdst)
0048002105210251 D  svzip                              LIKE(ecdzip)
004900210521      *
005000210521      *
005100210521     C     grkey         klist
005200210521     C                   kfld                    pltrst
005300081103     C                   kfld                    plsub#
005400081103     C                   kfld                    plplan
005500081103     C                   kfld                    date9
005600081103      *
005700041228     C     mcvky         klist
005800081103     C                   kfld                    pltrst
005900081103     C                   kfld                    plsub#
006000081103     C                   kfld                    plplan
006100081103      *
006200020404     C     depky         klist
006300081103     C                   kfld                    mbssno
006400081103     C                   kfld                    dseq#
0065000907080291  *   Preprocessing
0066000907080297 C                   movel     UDATE         cutoff
0067000907080297 C                   movel     cutoff        today8
0068000206130297 C                   movel     cutoff        todaa
0069000207230297 C                   z-add     99999999      date9
0070002005290291  * Determine Term date cutoff to start - 90 days prior to term dt
0071002005290297 C     cutoff        subdur    90:*D         cutofx
0072002005290297 C                   movel     cutofx        cutofn
0073002005290291  * Determine Term date cutoff to end - 60 days after term dt
0074002005290297 C     cutoff        adddur    60:*D         cutofy
0075002005290297 C                   movel     cutofy        cutofa
0076002105200291  *   Update and write the Header Record
0077002105200297 C                   read      esrxbhdp
0078002105200297 C                   movel     todaa         echcudt
0079002105200297 C                   update    esrxbhdr
0080002105200291  *
0081002105200291  * Main Line - Loop thru plan master
0082002105250297 C**** 'RXB'         setll     plnmstn1                           21
0083002105250297 C     'ESI'         setll     plnmstn1                           21
0084002105200296 C                   dou       *in21 = '1'
0085002105250297 C**** 'RXB'         reade     plnmstn1                               21
0086002105250297 C     'ESI'         reade     plnmstn1                               21
0087002105250296 C****               If        *in21 = '0'
0088002105250296 C                   If        *in21 = '0' and pltrst = 3 and plsub# = 1
0089002105200291  *     Using GBS info - Get GRATE record
0090002105200297 C     grkey         setll     grat24                             22
0091002105200297 C                   readp     grat24                                 22
0092000204040296 C                   If        *in22 = '0'
0093000207230291  *
0094000204030291  *        Loop thru mcov file using T,S,P
0095002008270297 C     mcvky         setll     mcov42                             31
0096000812040296 C                   dou       *in31 = '1'
0097002008270297 C     mcvky         reade     mcov42                                 31
0098002105040296 C                   If        *in31 = '0' and pltrst = mctrst and
0099002105040296 C                             plsub# = mcsub# and plplan = mcplan and
0100002105040296 C                             (candt = 0 or candt > enrldt)
0101000907090291  *
0102000907020296 C                   If        candt = 0 or candt > cutofn
0103002005290296 C                   If        candt = 0 or candt < cutofa
0104000907020291  *
0105000907090291  *        Get member record
0106000907020297 C     mcssno        chain     member                             32
0107000907020296 C                   If        *in32 = '0'
0108000907020291  *
0109000907020291 C                   exsr      bldmbr
0110000907020291  *
0111000907020291  *        Look for dependents of member             7
0112000204040297 C     mcssno        setll     dcov                               33
0113000204040296 C                   dou       *in33 = '1'
0114000204040297 C     mcssno        reade     dcov                                   33
0115002105040296 C****               If        *in33 = '0' and pltrst = dvtrst and
0116002105040296 C*                            plsub# = dvsub# and plplan = dvplan and
0117002105040296 C****                         enrldt = denrdt
0118002105040296 C                   If        *in33 = '0' and pltrst = dvtrst and
0119002105040296 C                             plsub# = dvsub# and plplan = dvplan
0120000206040291  *
0121000206040296 C                   If        ccandt = 0 or ccandt > cutofn
0122002005290296 C                   If        ccandt = 0 or ccandt < cutofa
0123000204040291  *
0124000204040291 C                   exsr      blddep
0125000906010291  *
0126000906010297 C                   endif                                                  ccandt = 0
0127000906010291  *
0128002005290297 C                   endif                                                  ccandt = 0
0129002005290291  *
0130000906010297 C                   endif                                                  *in33 = '0'
0131000906010291  *
0132000906010297 C                   enddo                                                  *in33 = '1'
0133000906010291  *
0134000204040297 C                   endif                                                  *in32 = '0'
0135000906010291  *
0136002005290297 C                   endif                                                  *in32 = '0'
0137002005290291  *
0138000204040297 C                   endif                                                  candt = 0
0139000204040297 C                   endif                                                  *in31 = '0'
0140000204020297 C                   enddo                                                  *in31 = '1'
0141000204020291  *
0142000204040297 C                   endif                                                  *in22 = '0'
0143000204020291  *
0144000501110297 C                   endif                                                  *in21 = '0'
0145002105250296 C*****              If        pcarr > 'RXB'
0146002105250296 C                   If        pcarr > 'ESI'
0147000501110296 C                   leave
0148000811030297 C                   endif                                                  pcarr > 'EX2'
0149000811030297 C                   enddo                                                  *in21 = '1'
0150000811030291  *
0151002005290291  *   Update and write the Trailer Record
0152002105100297 C                   read      esrxbtrp
0153002105200297 C                   eval      reccnt = reccnt + 2
0154002105200297 C                   eval      ectrec = reccna
0155002105200297 C                   movel     todaa         ectcudt
0156002105200297 C                   update    esrxbtrr
015700210520      *
0158002105200291  *
0159002105200297 C                   movel     '1'           *inlr
0160000811030297 C                   return
0161000204020107  ********************************************************************************
0162000204020107  *
0163000204020107  *     BLDMBR - Build Member record
0164000204020107  *
0165000204020107  ********************************************************************************
016600020402     C     bldmbr        begsr
0167002005280107  *****
0168002005280107  *
016900210510     C                   clear                   esrxbdtr
0170002005280107  *  Set Default Values
017100200528     C                   eval      ecdtyp = 'E'
017200200528     C                   movel(P)  '001'         ecdper#
017300200528     C                   eval      ecdtrcd = 'P'
017400200528     C                   eval      ecdrelc = '1'
0175002005280107  *    Participant Values
017600200528     C                   movel     mbssno        ecdsub#
017700200529     C                   movel(P)  group#        ecdgrid
017800200528     C                   movel     enrldt        ecdefdt
017900200528     C                   movel     candt         ecdtmdt
018000200528      *
0181002005280296 C                   If        ecdtmdt = '00000000'
018200200528     C                   eval      ecdtmdt = *blanks
0183002005280296 C                   endif
018400200528      *
018500200528     C                   movel     mlname        ecdlnam
018600200529     C                   movel     mfname        ecdfnam
018700200528     C                   move      mmi           ecdmi
018800200528     C                   movel     birth         ecddob
018900200528     C                   movel     sex           ecdsex
019000200528     C                   movel     mbssno        ecdssn
019100200528      *
019200200528     C                   MOVEL(P)  addr1         ecdadd1
019300200528     C                   movel     addr2         ecdadd2
0194002005280107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0195002005280296 C                   If        ecdadd1 = *blanks and ecdadd2 <> *blanks
019600200528     C                   movel(P)  ecdadd2       ecdadd1
019700200528     C                   movel     *blanks       ecdadd2
019800200528     C                   endif                                                  *in62 = '0'
0199002005280107  *
020000200529     C                   movel     ecdadd1       svadr1
020100200528     C                   movel     ecdadd2       svadr2
0202002005280107  *
020300200528     C                   movel     city          ecdcity
020400200528     C                   movel     ecdcity       svcity
020500200528     C                   move      state         ecdst
020600200528     C                   movel     ecdst         svst
020700200528     C                   movel     zip           ecdzip
020800200528     C                   movel     ecdzip        svzip
020900200529      *           Set Phone# if not 0
0210002005290296 C                   If        area <> 0 and phone <> 0
021100200528     C                   movel     area          ecdphon
021200200528     C                   move      phone         ecdphon
0213002005290296 C                   endif
021400200529      *
021500200529      *           Set coverage level
0216002005290296 C                   If        mcovtp = 'TIN'
021700200529     C                   eval      ecdcvcd = '1'
0218002005290296 C                   else
021900200529     C                   eval      ecdcvcd = '6'
0220002005290296 C                   endif
022100200529      *
022200200529     C                   movel(P)  '00'          ecddep#
0223002005290107  *
0224002005290297 C                   eval      reccnt = reccnt + 1
022500200529      *
022600210511     C                   eval      ecdf8x = 'X'
022700210510     C                   write     esrxbdtr
0228000907010107  *
022900090701     C                   endsr
0230000204150107  ********************************************************************************
0231000907010107  *
0232000204040107  *     BLDDEP - Build Dependent Record
0233000907010107  *
0234000204040107  ********************************************************************************
023500090701     C     blddep        begsr
0236000907010291  *        Get Dependent record
0237000907010297 C     depky         chain     depndc                             42
0238002105200296 C                   If        *in42 = '0' and
0239002105200296 C                             (ccandt = 0 or ccandt > denrdt)
0240002105200107  *     Dependent Values
024100210520     C                   movel     '002'         ecdper#
0242002105200291  *
024300210520     C                   if        dlname = 'SAME'
024400210520     C                   movel     mlname        ecdlnam
024500210520     C                   else
024600200529     C                   movel     dlname        ecdlnam
024700210520     C                   endif
0248002105200107  *
024900210520     C                   movel     dfname        ecdfnam
025000210520     C                   move      dmi           ecdmi
0251002105200107  *
025200210520     C                   if        daddr1 <> 'SAME'
025300200529     C                   movel     daddr1        ecdadd1
025400200529     C                   movel     daddr2        ecdadd2
025500200529     C                   movel     dcity         ecdcity
025600200529     C                   move      dstate        ecdst
025700200529     C                   movel     dzip          ecdzip
025800090710     C                   endif
025900200529      *           Set Phone# if not 0
0260002005290296 C                   eval      ecdphon = *blanks
0261002005290296 C                   If        darea <> 0 and dphone <> 0
026200200529     C                   movel     darea         ecdphon
026300200529     C                   move      dphone        ecdphon
0264002005290296 C                   endif
026500200529      *
0266000907100107  *
026700200529     C                   movel     dbirth        ecddob
026800200529     C                   move      dsex          ecdsex
026900200529     C                   movel     denrdt        ecdefdt
027000200529     C                   movel     ccandt        ecdtmdt
027100200529      *
0272002005290296 C                   If        ecdtmdt = '00000000'
027300200529     C                   eval      ecdtmdt = *blanks
0274002005290296 C                   endif
0275002005290107  *
027600200529     C                   movel(P)  dpseq#        ecddep#
0277002005290107  *
027800200529     C                   movel     depss#        ecdssn
027900200529      *
028000200529     C                   eval      ecdcvcd = ' '
0281000907100107  *
028200200529     C                   eval      ecdrelc = ' '
028300200529     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
028400200529     C                   eval      ecdrelc = '2'
028500090612     C                   else                                                   *in62 = '0'
028600200529     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
028700200529     C                   eval      ecdrelc = '3'
028800090612     C                   else                                                   *in62 = '0'
028900200529     C                   if        drelcd = 'RPA'
029000200529     C                   eval      ecdrelc = '8'
029100090612     C                   endif                                                  *in62 = '0'
029200090612     C                   endif                                                  *in62 = '0'
029300090612     C                   endif                                                  *in62 = '0'
0294000906120107  *
029500200821     C                   if        dhndcp = '3'
029600210524     C                   eval      ecdrelc = '5'
029700210524     C                   endif                                                  *in62 = '0'
0298002105240107  *
029900210524     C                   eval      ecdf8x = 'X'
030000210524     C                   write     esrxbdtr
030100210524     C                   eval      reccnt = reccnt + 1                          *in62 = '0'
0302002105240107  *
030300200529     C                   endif                                                  *in62 = '0'
0304002105240107  *
030500210524     C                   endsr
030600020402     C*
