0001000204020002  *****************************************************************************
000200200527      * ESE15EXR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400200527      *            DATE - 05/2020                                                 *
000500200527      *  DESCRIPTION - Build file of current Express Scripts (ESI)                *
000600200527      *                Eligibility - ESI 1500 East Format                         *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900200821      *  rlj 08/21/2020 If Dependent is handicapped set relcd to '5'              *
001000200827      *  rlj 08/27/2020 Put older coverage periods prior to newer - MCOV42        *
001100200828      *                 Use enroll dt or match cov for dependents                 *
001200210504      *  rlj 05/04/2021 Remove need for Dep enroll dt to equal mbr's              *
001300200828      *
0014009102150018 F******************************************************************
0015000501110019 FPLNMSTN1  IF   E           K DISK
001600200827     FMCOV42    IF   E           K DISK
001700020404     FMEMBER    IF   E           K DISK
001800020404     FGRAT24    IF   E           K DISK
001900020404     FDCOV      IF   E           K DISK
002000020404     FDEPNDC    IF   E           K DISK
0021002005270020 FESE15HDP  UF A E           K DISK
0022002005270020 FESE15DTP  UF A E           K DISK
0023002005270020 FESE15TRP  UF A E           K DISK
0024000204020025  *
002500200529      *
0026002005290250 D                 DS
0027002005290251 D  fill66                 1     66
0028002005290251 D   gemail                1     65
002900200529      *
0030002005290250 D                 DS
0031002005290251 D  reccnt                 1      9S 0 INZ(0)
0032002005290251 D  reccna                 1      9
003300200529      *
0034000906120250 D                 DS
0035000906120251 D  dseq                          2S 0 INZ(0)
0036000906120251 D  cutoff                         D   DATFMT(*ISO)
0037002005290251 D  cutofx                         D   DATFMT(*ISO)
0038002005290251 D  cutofy                         D   DATFMT(*ISO)
0039000906120251 D  cutofn                        8S 0
0040002005290251 D  cutofa                        8S 0
0041000906120251 D  today8                        8S 0
0042000204150251 D  updt                          1A
004300020402      *
0044000508190251 D  todaa                              LIKE(frmdat)
0045000207230251 D  date9                              LIKE(frmdat)
004600020415      *
0047002005280251 D  svadr1                             LIKE(ecdadd1)
0048002005280251 D  svadr2                             LIKE(ecdadd2)
0049002005280251 D  svcity                             LIKE(ecdcity)
0050002005280251 D  svst                               LIKE(ecdst)
0051002005280251 D  svzip                              LIKE(ecdzip)
005200200528      *
005300020415      *
005400020613     C     grkey         klist
005500081103     C                   kfld                    pltrst
005600081103     C                   kfld                    plsub#
005700081103     C                   kfld                    plplan
005800081103     C                   kfld                    date9
005900081103      *
006000041228     C     mcvky         klist
006100081103     C                   kfld                    pltrst
006200081103     C                   kfld                    plsub#
006300081103     C                   kfld                    plplan
006400081103      *
006500020404     C     depky         klist
006600081103     C                   kfld                    mbssno
006700081103     C                   kfld                    dseq#
0068000907080291  *   Preprocessing
0069000907080297 C                   movel     UDATE         cutoff
0070000907080297 C                   movel     cutoff        today8
0071000206130297 C                   movel     cutoff        todaa
0072000207230297 C                   z-add     99999999      date9
0073002005290291  * Determine Term date cutoff to start - 90 days prior to term dt
0074002005290297 C     cutoff        subdur    90:*D         cutofx
0075002005290297 C                   movel     cutofx        cutofn
0076002005290291  * Determine Term date cutoff to end - 60 days after term dt
0077002005290297 C     cutoff        adddur    60:*D         cutofy
0078002005290297 C                   movel     cutofy        cutofa
0079002005280291  *   Update and write the Header Record
0080002005280297 C                   read      ese15hdp
0081002005280297 C                   movel     todaa         echcudt
0082002005280297 C                   update    ese15hdr
0083000204040291  *
0084000501110291  * Main Line - Loop thru plan master
0085000812040297 C     'ESI'         setll     plnmstn1                           21
0086000812040296 C                   dou       *in21 = '1'
0087000906120297 C     'ESI'         reade     plnmstn1                               21
0088000906120296 C                   If        *in21 = '0'
0089000412280291  *     Using GBS info - Get GRATE record
0090000206130297 C     grkey         setll     grat24                             22
0091000206130297 C                   readp     grat24                                 22
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
0145000906120296 C                   If        pcarr > 'ESI'
0146000501110296 C                   leave
0147000811030297 C                   endif                                                  pcarr > 'EX2'
0148000811030297 C                   enddo                                                  *in21 = '1'
0149000811030291  *
0150002005290291  *   Update and write the Trailer Record
0151002005290297 C                   read      ese15trp
0152002005290297 C                   eval      reccnt = reccnt + 2
0153002005290297 C                   eval      ectrec = reccna
0154002005290297 C                   movel     todaa         ectcudt
0155002005290297 C                   update    ese15trr
015600200529      *
0157000906120291  *
0158000811030297 C                   movel     '1'           *inlr
0159000811030297 C                   return
0160000204020107  ********************************************************************************
0161000204020107  *
0162000204020107  *     BLDMBR - Build Member record
0163000204020107  *
0164000204020107  ********************************************************************************
016500020402     C     bldmbr        begsr
0166002005280107  *****
0167002005280107  *
016800200528     C                   clear                   ese15dtr
0169002005280107  *  Set Default Values
017000200528     C                   eval      ecdtyp = 'E'
017100200528     C                   movel(P)  '001'         ecdper#
017200200528     C                   eval      ecdtrcd = 'P'
017300200528     C                   eval      ecdrelc = '1'
0174002005280107  *    Participant Values
017500200528     C                   movel     mbssno        ecdsub#
017600200529     C                   movel(P)  group#        ecdgrid
017700200528     C                   movel     enrldt        ecdefdt
017800200528     C                   movel     candt         ecdtmdt
017900200528      *
0180002005280296 C                   If        ecdtmdt = '00000000'
018100200528     C                   eval      ecdtmdt = *blanks
0182002005280296 C                   endif
018300200528      *
018400200528     C                   movel     mlname        ecdlnam
018500200529     C                   movel     mfname        ecdfnam
018600200528     C                   move      mmi           ecdmi
018700200528     C                   movel     birth         ecddob
018800200528     C                   movel     sex           ecdsex
018900200528     C                   movel     mbssno        ecdssn
019000200528      *
019100200528     C                   MOVEL(P)  addr1         ecdadd1
019200200528     C                   movel     addr2         ecdadd2
0193002005280107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0194002005280296 C                   If        ecdadd1 = *blanks and ecdadd2 <> *blanks
019500200528     C                   movel(P)  ecdadd2       ecdadd1
019600200528     C                   movel     *blanks       ecdadd2
019700200528     C                   endif                                                  *in62 = '0'
0198002005280107  *
019900200529     C                   movel     gemail        ecdemal
0200002005290107  *
020100200529     C                   movel     ecdadd1       svadr1
020200200528     C                   movel     ecdadd2       svadr2
0203002005280107  *
020400200528     C                   movel     city          ecdcity
020500200528     C                   movel     ecdcity       svcity
020600200528     C                   move      state         ecdst
020700200528     C                   movel     ecdst         svst
020800200528     C                   movel     zip           ecdzip
020900200528     C                   movel     ecdzip        svzip
021000200529      *           Set Phone# if not 0
0211002005290296 C                   If        area <> 0 and phone <> 0
021200200528     C                   movel     area          ecdphon
021300200528     C                   move      phone         ecdphon
0214002005290296 C                   endif
021500200529      *
021600200529      *           Set coverage level
0217002005290296 C                   If        mcovtp = 'TIN'
021800200529     C                   eval      ecdcvcd = '1'
0219002005290296 C                   else
022000200529     C                   eval      ecdcvcd = '6'
0221002005290296 C                   endif
022200200529      *
022300200529     C                   movel(P)  '00'          ecddep#
0224002005290107  *
0225002005290297 C                   eval      reccnt = reccnt + 1
022600200529      *
022700200529     C                   write     ese15dtr
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
0238000907010296 C                   If        *in42 = '0' and
0239000812040296 C                             (ccandt = 0 or ccandt > denrdt)
0240002005290107  *     Dependent Values
024100200529     C                   movel     '002'         ecdper#
0242000812040291  *
024300020404     C                   if        dlname = 'SAME'
024400200529     C                   movel     mlname        ecdlnam
024500020404     C                   else
024600200529     C                   movel     dlname        ecdlnam
024700020404     C                   endif
0248000204040107  *
024900200529     C                   movel     dfname        ecdfnam
025000200529     C                   move      dmi           ecdmi
0251000204040107  *
025200200529     C                   if        daddr1 <> 'SAME'
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
026700200529     C                   movel     *blanks       ecdemal
0268002005290107  *
026900200529     C                   movel     dbirth        ecddob
027000200529     C                   move      dsex          ecdsex
027100200529     C                   movel     denrdt        ecdefdt
027200200529     C                   movel     ccandt        ecdtmdt
027300200529      *
0274002005290296 C                   If        ecdtmdt = '00000000'
027500200529     C                   eval      ecdtmdt = *blanks
0276002005290296 C                   endif
0277002005290107  *
027800200529     C                   movel(P)  dpseq#        ecddep#
0279002005290107  *
028000200529     C                   movel     depss#        ecdssn
028100200529      *
028200200529     C                   eval      ecdcvcd = ' '
0283000907100107  *
028400200529     C                   eval      ecdrelc = ' '
028500200529     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
028600200529     C                   eval      ecdrelc = '2'
028700090612     C                   else                                                   *in62 = '0'
028800200529     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
028900200529     C                   eval      ecdrelc = '3'
029000090612     C                   else                                                   *in62 = '0'
029100200529     C                   if        drelcd = 'RPA'
029200200529     C                   eval      ecdrelc = '8'
029300090612     C                   endif                                                  *in62 = '0'
029400090612     C                   endif                                                  *in62 = '0'
029500090612     C                   endif                                                  *in62 = '0'
0296000906120107  *
029700200821     C                   if        dhndcp = '3'
029800200821     C                   eval      ecdrelc = '5'
029900200821     C                   endif                                                  *in62 = '0'
0300002005290107  *
030100200529     C                   write     ese15dtr
030200200529     C                   eval      reccnt = reccnt + 1                          *in62 = '0'
0303002005290107  *
030400200529     C                   endif                                                  *in62 = '0'
0305002005290107  *
030600020404     C                   endsr
030700020402     C*
