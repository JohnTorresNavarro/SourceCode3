0001000204020002  *****************************************************************************
000200090612      * DW250R     Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400090612      *            DATE - 05/2009                                                 *
000500020402      *  DESCRIPTION - Build file opf current Express Scripts                     *
000600020402      *                Eligibility.                                               *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900090612      *  xxx mm/dd/yyyy                                                           *
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012000501110019 FPLNMSTN1  IF   E           K DISK
001300090612     FMCOV39    IF   E           K DISK
001400020404     FMEMBER    IF   E           K DISK
001500020404     FGRAT24    IF   E           K DISK
001600020404     FDCOV      IF   E           K DISK
001700020404     FDEPNDC    IF   E           K DISK
0018000906120020 FES2HDRP   UF A E           K DISK
0019000906120020 FES2CURP   UF A E           K DISK
0020000906120020 FES2TRLP   UF A E           K DISK
0021000204020025  *
0022009102150250 D                 DS
0023000906120251 D  e2zip9                 1      9
0024000906120251 D   e2zip                 1      5
0025000906120251 D   e2zip4                6      9
0026000906120025  *
0027000906120250 D                 DS
0028000906120251 D  dseq                          2S 0 INZ(0)
0029000906120251 D  cutoff                         D   DATFMT(*ISO)
0030000906120251 D  cutofn                        8S 0
0031000906120251 D  today8                        8S 0
0032000204150251 D  updt                          1A
003300020402      *
0034000906150251 D  ekcnid                             LIKE(e2cnid)
0035000906150251 D  ekdpsq                             LIKE(e2dpsq)
0036000906120251 D  ekcgrp                             LIKE(e2cgrp)
0037000906120251 D  ekcvcd                             LIKE(e2cvcd)
0038000508190251 D  todaa                              LIKE(frmdat)
0039000207230251 D  date9                              LIKE(frmdat)
004000020415      *
004100020415     C     eckey         klist
004200090615     C                   kfld                    ekcnid
004300090615     C                   kfld                    ekdpsq
004400090612     C                   kfld                    ekcgrp
004500090612     C                   kfld                    ekcvcd
004600020415      *
004700020613     C     grkey         klist
004800081103     C                   kfld                    pltrst
004900081103     C                   kfld                    plsub#
005000081103     C                   kfld                    plplan
005100081103     C                   kfld                    date9
005200081103      *
005300041228     C     mcvky         klist
005400081103     C                   kfld                    pltrst
005500081103     C                   kfld                    plsub#
005600081103     C                   kfld                    plplan
005700081103      *
005800020404     C     depky         klist
005900081103     C                   kfld                    mbssno
006000081103     C                   kfld                    dseq#
0061000907080291  *   Preprocessing
0062000907080297 C                   movel     UDATE         cutoff
0063000907080297 C                   movel     cutoff        today8
0064000206130297 C                   movel     cutoff        todaa
0065000207230297 C                   z-add     99999999      date9
0066000206130291  * Determine Term date cutoff - 1 year ago
0067000509290297 C     cutoff        subdur    90:*D         cutoff
0068000204030297 C                   movel     cutoff        cutofn
0069000906120291  * Update Header Rec
0070000906120297 C     'JP2'         chain     es2hdrp
0071000906120297 C                   eval      ehfldt = today8
0072000906120297 C                   eval      ehpdat = today8
0073000907010297 C                   eval      ehfnum = ehfnum + 1
0074000907010297 C                   eval      ehdtrm = today8
0075000907010297 C                   update    es2hdrr
0076000906120291  * Get Trailer Rec
0077000906120297 C     'JP2'         chain     es2trlp
0078000907010291  *          Count Hdr and Trl recs
0079000907010297 C                   eval      etrcnt = 2
0080000906120291  * Populate default fields
0081000906120297 C                   eval      e2rtyp = 'M'
0082000906120297 C                   eval      e2clnt = 'JP2'
0083000906120297 C                   eval      e2z1 = '00000000'
0084000906120297 C                   eval      e2z2 = '0000000000000000000000000000'
0085000906120297 C                   eval      e2z3 = '0000000'
0086000906120297 C                   eval      e2z4 = '0000000000000000'
0087000906120297 C                   eval      e2z5 = '00000000'
008800020402      *
0089000204040291  *
0090000501110291  * Main Line - Loop thru plan master
0091000812040297 C     'ESI'         setll     plnmstn1                           21
0092000812040296 C                   dou       *in21 = '1'
0093000906120297 C     'ESI'         reade     plnmstn1                               21
0094000906120296 C                   If        *in21 = '0'
0095000412280291  *     Using GBS info - Get GRATE record
0096000206130297 C     grkey         setll     grat24                             22
0097000206130297 C                   readp     grat24                                 22
0098000204040296 C                   If        *in22 = '0'
0099000207230291  *
0100000204030291  *        Loop thru mcov file using T,S,P
0101000906120297 C     mcvky         setll     mcov39                             31
0102000812040296 C                   dou       *in31 = '1'
0103000906120297 C     mcvky         reade     mcov39                                 31
0104000907020296 C                   If        *in31 = '0' and pltrst = mctrst and
0105000907020296 C                             plsub# = mcsub# and plplan = mcplan and
0106000907020296 C                             (candt = 0 or candt > enrldt)
0107000907090291  *
0108000907020296 C                   If        candt = 0 or candt > cutofn
0109000907020291  *
0110000907090291  *        Get member record
0111000907020297 C     mcssno        chain     member                             32
0112000907020296 C                   If        *in32 = '0'
0113000907020291  *
0114000907020291 C                   exsr      bldmbr
0115000907020291  *
0116000907020291  *        Look for dependents of member             7
0117000204040297 C     mcssno        setll     dcov                               33
0118000204040296 C                   dou       *in33 = '1'
0119000204040297 C     mcssno        reade     dcov                                   33
0120000501110296 C                   If        *in33 = '0' and pltrst = dvtrst and
0121000501110296 C                             plsub# = dvsub# and plplan = dvplan
0122000206040291  *
0123000206040296 C                   If        ccandt = 0 or ccandt > cutofn
0124000204040291  *
0125000204040291 C                   exsr      blddep
0126000906010291  *
0127000906010297 C                   endif                                                  ccandt = 0
0128000906010291  *
0129000906010297 C                   endif                                                  *in33 = '0'
0130000906010291  *
0131000906010297 C                   enddo                                                  *in33 = '1'
0132000906010291  *
0133000204040297 C                   endif                                                  *in32 = '0'
0134000906010291  *
0135000204040297 C                   endif                                                  candt = 0
0136000204040297 C                   endif                                                  *in31 = '0'
0137000204020297 C                   enddo                                                  *in31 = '1'
0138000204020291  *
0139000204040297 C                   endif                                                  *in22 = '0'
0140000204020291  *
0141000501110297 C                   endif                                                  *in21 = '0'
0142000906120296 C                   If        pcarr > 'ESI'
0143000501110296 C                   leave
0144000811030297 C                   endif                                                  pcarr > 'EX2'
0145000811030297 C                   enddo                                                  *in21 = '1'
0146000811030291  *
0147000906120297 C                   update    es2trlr
0148000906120291  *
0149000811030297 C                   movel     '1'           *inlr
0150000811030297 C                   return
0151000204020107  ********************************************************************************
0152000204020107  *
0153000204020107  *     BLDMBR - Build Member record
0154000204020107  *
0155000204020107  ********************************************************************************
015600020402     C     bldmbr        begsr
0157000204150107  *      First see if member record exists
015800090615     C                   movel     mbssno        ekcnid
015900090615     C                   eval      ekdpsq = 0
016000090612     C                   movel     mcplan        ekcgrp
016100090612     C                   eval      ekcvcd = '3'
0162000906120296 C                   If        mcovtp = 'TIN'
016300090612     C                   eval      ekcvcd = '1'
016400090612     C                   else
0165000906120296 C                   If        mcovtp = 'TFA'
016600090612     C                   eval      ekcvcd = '3'
016700090612     C                   else
0168000906120296 C                   If        mcovtp = 'THW'
016900090612     C                   eval      ekcvcd = '2'
017000090612     C                   else
0171000906120296 C                   If        mcovtp = 'TPC'
017200090612     C                   eval      ekcvcd = '8'
017300090612     C                   else
0174000906120296 C                   If        mcovtp = 'TP2'
017500090612     C                   eval      ekcvcd = '4'
017600090612     C                   endif
017700090612     C                   endif
017800090612     C                   endif
017900090612     C                   endif
018000090612     C                   endif
0181000906120297 C     eckey         chain     es2curp                            62
0182000204150296 C                   If        *in62 = '0'
0183000204150291  *         Set effective and term dates
018400020415     C                   movel     ' '           updt
0185000906120296 C                   If        enrldt < e2efdt
018600090612     C                   z-add     enrldt        e2efdt
018700020415     C                   movel     'Y'           updt
018800020415     C                   endif
0189000206200291  *         Set term date - if any term date = 0 => keep it
0190000906120296 C                   If        e2exdt <> 0
0191000906120296 C                   If        candt > e2exdt or
0192000204150296 C                             candt = 0
019300090612     C                   z-add     candt         e2exdt
019400020415     C                   movel     'Y'           updt
019500020415     C                   endif
019600020620     C                   endif
0197000206200291  *
0198000204150296 C                   If        updt = 'Y'
019900090612     C                   update    es2curr
020000020415     C                   endif
0201000204150291  *         If member doesn't exist - build record
020200020415     C                   else
0203000906150107  *     Per Chad(ESI) - leave MID# blank
020400090615     C**********         movel     mbssno        e2mid#
020500090612     C                   z-add     enrldt        e2efdt
020600090612     C                   movel     mfname        e2fnme
020700090612     C                   movel     mlname        e2lnme
020800090612     C                   move      mmi           e2mi
020900090612     C                   movel     addr1         e2adr1
021000090612     C                   movel     addr2         e2adr2
0211000906120107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0212000906120296 C                   If        e2adr1 = *blanks and e2adr2 <> *blanks
021300090612     C                   movel(P)  e2adr2        e2adr1
021400090612     C                   movel     *blanks       e2adr2
021500090612     C                   endif                                                  *in62 = '0'
0216000906120107  *
021700090612     C                   movel     city          e2city
021800090612     C                   move      state         e2st
021900090612     C                   movel     zip           e2zip9
022000090612     C                   z-add     birth         e2brdt
022100090612     C                   move      sex           e2gndr
022200090612     C                   movel     mbssno        e2cnid
022300090615     C                   eval      e2dpsq = 0
022400090612     C                   move      '1'           e2relc
022500090612     C                   movel     mcplan        e2cgrp
022600090612     C                   z-add     candt         e2exdt
022700090612     C                   movel     med#          e2mdid
022800090612      *
022900090612     C                   eval      e2cvcd = ekcvcd
023000090612     C                   eval      e2cntp = 'AC'
0231000906120296 C                   If        mcplan = 'X3TZ'
023200090612     C                   eval      e2cntp = 'CB'
023300090612     C                   endif                                                  *in62 = '0'
023400090612      *
023500090612     C                   movel     mbssno        e2mssn
023600090612     C                   movel     medicr        e2mrfl
023700090612     C                   movel     area          e2phn#
023800090612     C                   move      phone         e2phn#
023900090612     C                   write     es2curr
0240000907010107  *
024100090701     C                   eval      etrcnt = etrcnt + 1
0242000907010107  *
024300090701     C                   endif                                                  *in62 = '0'
0244000907010107  *
024500090701     C                   endsr
0246000204150107  ********************************************************************************
0247000907010107  *
0248000204040107  *     BLDDEP - Build Dependent Record
0249000907010107  *
0250000204040107  ********************************************************************************
025100090701     C     blddep        begsr
0252000907010291  *        Get Dependent record
0253000907010297 C     depky         chain     depndc                             42
0254000907010296 C                   If        *in42 = '0' and
0255000812040296 C                             (ccandt = 0 or ccandt > denrdt)
0256000812040291  *
0257000204150107  *      First see if depend record exists
025800090615     C                   move      dpseq#        ekdpsq
0259000906120297 C     eckey         chain     es2curp                            62
0260000204150296 C                   If        *in62 = '0'
0261000204150291  *         Set effective and term dates
026200020415     C                   movel     ' '           updt
0263000906120296 C                   If        denrdt < e2efdt
026400090612     C                   z-add     denrdt        e2efdt
026500020415     C                   movel     'Y'           updt
026600020415     C                   endif
0267000209260291  *         Set term date - if any term date = 0 => keep it
0268000906120296 C                   If        e2exdt <> 0
0269000906120296 C                   If        ccandt > e2exdt or
0270000204150296 C                             ccandt = 0
027100090612     C                   z-add     ccandt        e2exdt
027200020415     C                   movel     'Y'           updt
027300020415     C                   endif
027400020926     C                   endif
0275000204150296 C                   If        updt = 'Y'
027600090612     C                   update    es2curr
027700020415     C                   endif
0278000204150291  *         If member doesn't exist - build record
027900020415     C                   else
028000090615     C                   move      dpseq#        e2dpsq
0281000204040107  *
028200020404     C                   if        dlname = 'SAME'
028300090612     C                   movel     mlname        e2lnme
028400020404     C                   else
028500090612     C                   movel     dlname        e2lnme
028600020404     C                   endif
0287000204040107  *
028800090612     C                   movel     dfname        e2fnme
028900090612     C                   move      dmi           e2mi
0290000204040107  *
029100020404     C                   if        daddr1 = 'SAME'
029200090612     C                   movel     addr1         e2adr1
029300090612     C                   movel     addr2         e2adr2
029400090612     C                   movel     city          e2city
029500090612     C                   move      state         e2st
029600090612     C                   movel     zip           e2zip9
029700090710     C                   else
029800090710     C                   movel     daddr1        e2adr1
029900090612     C                   movel     daddr2        e2adr2
030000090710     C                   movel     dcity         e2city
030100090710     C                   move      dstate        e2st
030200090710     C                   movel     dzip          e2zip9
030300090710     C                   endif
0304000907100107  *
030500090710     C                   z-add     dbirth        e2brdt
030600090710     C                   move      dsex          e2gndr
030700090710     C                   z-add     denrdt        e2efdt
030800090710     C                   z-add     ccandt        e2exdt
030900090710     C                   movel     depss#        e2mssn
0310000907100107  *
031100090612     C                   if        drelcd = 'RWI'
031200090612     C                   eval      e2relc = '2'
031300090612     C                   eval      e2gndr = 'F'
031400090612     C                   else                                                   *in62 = '0'
031500090612     C                   if        drelcd = 'RDA'
031600090612     C                   eval      e2relc = '3'
031700090612     C                   eval      e2gndr = 'F'
031800090612     C                   else                                                   *in62 = '0'
031900090612     C                   if        drelcd = 'RSO'
032000090612     C                   eval      e2relc = '3'
032100090612     C                   eval      e2gndr = 'M'
032200090612     C                   else                                                   *in62 = '0'
032300090612     C                   if        drelcd = 'RHU'
032400090612     C                   eval      e2relc = '2'
032500090612     C                   eval      e2gndr = 'M'
032600140521     C                   else                                                   *in62 = '0'
032700140521     C                   if        drelcd = 'RPA'
032800140521     C                   eval      e2relc = '8'
032900140521     C                   eval      e2gndr = dsex
033000140521     C                   endif                                                  *in62 = '0'
033100090612     C                   endif                                                  *in62 = '0'
033200090612     C                   endif                                                  *in62 = '0'
033300090612     C                   endif                                                  *in62 = '0'
033400140521     C                   endif                                                  *in62 = '0'
0335000906120107  *
033600090612     C                   write     es2curr
0337000907060107  *
033800090706     C                   eval      etrcnt = etrcnt + 1
0339000907060107  *
034000090706     C                   endif                                                  *in62 = '0'
0341000907060291  *
0342000204040297 C                   endif                                                  *in42 = '0'
034300020404     C                   endsr
034400020402     C*
