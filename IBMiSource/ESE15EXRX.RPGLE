0001000204020002  *****************************************************************************
000200200527      * ESE15EXR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400200527      *            DATE - 05/2020                                                 *
000500200527      *  DESCRIPTION - Build file of current Express Scripts (ESI)                *
000600200527      *                Eligibility - ESI 1500 East Format                         *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900200821      *  rlj 08/21/2020 If Dependent is handicapped set relcd to '5'              *
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012000501110019 FPLNMSTN1  IF   E           K DISK
001300090612     FMCOV39    IF   E           K DISK
001400020404     FMEMBER    IF   E           K DISK
001500020404     FGRAT24    IF   E           K DISK
001600020404     FDCOV      IF   E           K DISK
001700020404     FDEPNDC    IF   E           K DISK
0018002005270020 FESE15HDP  UF A E           K DISK
0019002005270020 FESE15DTP  UF A E           K DISK
0020002005270020 FESE15TRP  UF A E           K DISK
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
0036000906120251 D  cutofn                        8S 0
0037002005290251 D  cutofa                        8S 0
0038000906120251 D  today8                        8S 0
0039000204150251 D  updt                          1A
004000020402      *
0041000508190251 D  todaa                              LIKE(frmdat)
0042000207230251 D  date9                              LIKE(frmdat)
004300020415      *
0044002005280251 D  svadr1                             LIKE(ecdadd1)
0045002005280251 D  svadr2                             LIKE(ecdadd2)
0046002005280251 D  svcity                             LIKE(ecdcity)
0047002005280251 D  svst                               LIKE(ecdst)
0048002005280251 D  svzip                              LIKE(ecdzip)
004900200528      *
005000020415      *
005100020613     C     grkey         klist
005200081103     C                   kfld                    pltrst
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
0076002005280291  *   Update and write the Header Record
0077002005280297 C                   read      ese15hdp
0078002005280297 C                   movel     todaa         echcudt
0079002005280297 C                   update    ese15hdr
0080000204040291  *
0081000501110291  * Main Line - Loop thru plan master
0082000812040297 C     'ESI'         setll     plnmstn1                           21
0083000812040296 C                   dou       *in21 = '1'
0084000906120297 C     'ESI'         reade     plnmstn1                               21
0085000906120296 C                   If        *in21 = '0'
0086000412280291  *     Using GBS info - Get GRATE record
0087000206130297 C     grkey         setll     grat24                             22
0088000206130297 C                   readp     grat24                                 22
0089000204040296 C                   If        *in22 = '0'
0090000207230291  *
0091000204030291  *        Loop thru mcov file using T,S,P
0092000906120297 C     mcvky         setll     mcov39                             31
0093000812040296 C                   dou       *in31 = '1'
0094000906120297 C     mcvky         reade     mcov39                                 31
0095000907020296 C                   If        *in31 = '0' and pltrst = mctrst and
0096000907020296 C                             plsub# = mcsub# and plplan = mcplan and
0097000907020296 C                             (candt = 0 or candt > enrldt)
0098000907090291  *
0099000907020296 C                   If        candt = 0 or candt > cutofn
0100002005290296 C                   If        candt = 0 or candt < cutofa
0101000907020291  *
0102000907090291  *        Get member record
0103000907020297 C     mcssno        chain     member                             32
0104000907020296 C                   If        *in32 = '0'
0105000907020291  *
0106000907020291 C                   exsr      bldmbr
0107000907020291  *
0108000907020291  *        Look for dependents of member             7
0109000204040297 C     mcssno        setll     dcov                               33
0110000204040296 C                   dou       *in33 = '1'
0111000204040297 C     mcssno        reade     dcov                                   33
0112000501110296 C                   If        *in33 = '0' and pltrst = dvtrst and
0113000501110296 C                             plsub# = dvsub# and plplan = dvplan
0114000206040291  *
0115000206040296 C                   If        ccandt = 0 or ccandt > cutofn
0116002005290296 C                   If        ccandt = 0 or ccandt < cutofa
0117000204040291  *
0118000204040291 C                   exsr      blddep
0119000906010291  *
0120000906010297 C                   endif                                                  ccandt = 0
0121000906010291  *
0122002005290297 C                   endif                                                  ccandt = 0
0123002005290291  *
0124000906010297 C                   endif                                                  *in33 = '0'
0125000906010291  *
0126000906010297 C                   enddo                                                  *in33 = '1'
0127000906010291  *
0128000204040297 C                   endif                                                  *in32 = '0'
0129000906010291  *
0130002005290297 C                   endif                                                  *in32 = '0'
0131002005290291  *
0132000204040297 C                   endif                                                  candt = 0
0133000204040297 C                   endif                                                  *in31 = '0'
0134000204020297 C                   enddo                                                  *in31 = '1'
0135000204020291  *
0136000204040297 C                   endif                                                  *in22 = '0'
0137000204020291  *
0138000501110297 C                   endif                                                  *in21 = '0'
0139000906120296 C                   If        pcarr > 'ESI'
0140000501110296 C                   leave
0141000811030297 C                   endif                                                  pcarr > 'EX2'
0142000811030297 C                   enddo                                                  *in21 = '1'
0143000811030291  *
0144002005290291  *   Update and write the Trailer Record
0145002005290297 C                   read      ese15trp
0146002005290297 C                   eval      reccnt = reccnt + 2
0147002005290297 C                   eval      ectrec = reccna
0148002005290297 C                   movel     todaa         ectcudt
0149002005290297 C                   update    ese15trr
015000200529      *
0151000906120291  *
0152000811030297 C                   movel     '1'           *inlr
0153000811030297 C                   return
0154000204020107  ********************************************************************************
0155000204020107  *
0156000204020107  *     BLDMBR - Build Member record
0157000204020107  *
0158000204020107  ********************************************************************************
015900020402     C     bldmbr        begsr
0160002005280107  *****
0161002005280107  *
016200200528     C                   clear                   ese15dtr
0163002005280107  *  Set Default Values
016400200528     C                   eval      ecdtyp = 'E'
016500200528     C                   movel(P)  '001'         ecdper#
016600200528     C                   eval      ecdtrcd = 'P'
016700200528     C                   eval      ecdrelc = '1'
0168002005280107  *    Participant Values
016900200528     C                   movel     mbssno        ecdsub#
017000200529     C                   movel(P)  group#        ecdgrid
017100200528     C                   movel     enrldt        ecdefdt
017200200528     C                   movel     candt         ecdtmdt
017300200528      *
0174002005280296 C                   If        ecdtmdt = '00000000'
017500200528     C                   eval      ecdtmdt = *blanks
0176002005280296 C                   endif
017700200528      *
017800200528     C                   movel     mlname        ecdlnam
017900200529     C                   movel     mfname        ecdfnam
018000200528     C                   move      mmi           ecdmi
018100200528     C                   movel     birth         ecddob
018200200528     C                   movel     sex           ecdsex
018300200528     C                   movel     mbssno        ecdssn
018400200528      *
018500200528     C                   MOVEL(P)  addr1         ecdadd1
018600200528     C                   movel     addr2         ecdadd2
0187002005280107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0188002005280296 C                   If        ecdadd1 = *blanks and ecdadd2 <> *blanks
018900200528     C                   movel(P)  ecdadd2       ecdadd1
019000200528     C                   movel     *blanks       ecdadd2
019100200528     C                   endif                                                  *in62 = '0'
0192002005280107  *
019300200529     C                   movel     gemail        ecdemal
0194002005290107  *
019500200529     C                   movel     ecdadd1       svadr1
019600200528     C                   movel     ecdadd2       svadr2
0197002005280107  *
019800200528     C                   movel     city          ecdcity
019900200528     C                   movel     ecdcity       svcity
020000200528     C                   move      state         ecdst
020100200528     C                   movel     ecdst         svst
020200200528     C                   movel     zip           ecdzip
020300200528     C                   movel     ecdzip        svzip
020400200529      *           Set Phone# if not 0
0205002005290296 C                   If        area <> 0 and phone <> 0
020600200528     C                   movel     area          ecdphon
020700200528     C                   move      phone         ecdphon
0208002005290296 C                   endif
020900200529      *
021000200529      *           Set coverage level
0211002005290296 C                   If        mcovtp = 'TIN'
021200200529     C                   eval      ecdcvcd = '1'
0213002005290296 C                   else
021400200529     C                   eval      ecdcvcd = '6'
0215002005290296 C                   endif
021600200529      *
021700200529     C                   movel(P)  '00'          ecddep#
0218002005290107  *
0219002005290297 C                   eval      reccnt = reccnt + 1
022000200529      *
022100200529     C                   write     ese15dtr
0222000907010107  *
022300090701     C                   endsr
0224000204150107  ********************************************************************************
0225000907010107  *
0226000204040107  *     BLDDEP - Build Dependent Record
0227000907010107  *
0228000204040107  ********************************************************************************
022900090701     C     blddep        begsr
0230000907010291  *        Get Dependent record
0231000907010297 C     depky         chain     depndc                             42
0232000907010296 C                   If        *in42 = '0' and
0233000812040296 C                             (ccandt = 0 or ccandt > denrdt)
0234002005290107  *     Dependent Values
023500200529     C                   movel     '002'         ecdper#
0236000812040291  *
023700020404     C                   if        dlname = 'SAME'
023800200529     C                   movel     mlname        ecdlnam
023900020404     C                   else
024000200529     C                   movel     dlname        ecdlnam
024100020404     C                   endif
0242000204040107  *
024300200529     C                   movel     dfname        ecdfnam
024400200529     C                   move      dmi           ecdmi
0245000204040107  *
024600200529     C                   if        daddr1 <> 'SAME'
024700200529     C                   movel     daddr1        ecdadd1
024800200529     C                   movel     daddr2        ecdadd2
024900200529     C                   movel     dcity         ecdcity
025000200529     C                   move      dstate        ecdst
025100200529     C                   movel     dzip          ecdzip
025200090710     C                   endif
025300200529      *           Set Phone# if not 0
0254002005290296 C                   eval      ecdphon = *blanks
0255002005290296 C                   If        darea <> 0 and dphone <> 0
025600200529     C                   movel     darea         ecdphon
025700200529     C                   move      dphone        ecdphon
0258002005290296 C                   endif
025900200529      *
0260000907100107  *
026100200529     C                   movel     *blanks       ecdemal
0262002005290107  *
026300200529     C                   movel     dbirth        ecddob
026400200529     C                   move      dsex          ecdsex
026500200529     C                   movel     denrdt        ecdefdt
026600200529     C                   movel     ccandt        ecdtmdt
026700200529      *
0268002005290296 C                   If        ecdtmdt = '00000000'
026900200529     C                   eval      ecdtmdt = *blanks
0270002005290296 C                   endif
0271002005290107  *
027200200529     C                   movel(P)  dpseq#        ecddep#
0273002005290107  *
027400200529     C                   movel     depss#        ecdssn
027500200529      *
027600200529     C                   eval      ecdcvcd = ' '
0277000907100107  *
027800200529     C                   eval      ecdrelc = ' '
027900200529     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
028000200529     C                   eval      ecdrelc = '2'
028100090612     C                   else                                                   *in62 = '0'
028200200529     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
028300200529     C                   eval      ecdrelc = '3'
028400090612     C                   else                                                   *in62 = '0'
028500200529     C                   if        drelcd = 'RPA'
028600200529     C                   eval      ecdrelc = '8'
028700090612     C                   endif                                                  *in62 = '0'
028800090612     C                   endif                                                  *in62 = '0'
028900090612     C                   endif                                                  *in62 = '0'
0290000906120107  *
029100200821     C                   if        dhndcp = '3'
029200200821     C                   eval      ecdrelc = '5'
029300200821     C                   endif                                                  *in62 = '0'
0294002005290107  *
029500200529     C                   write     ese15dtr
029600200529     C                   eval      reccnt = reccnt + 1                          *in62 = '0'
0297002005290107  *
029800200529     C                   endif                                                  *in62 = '0'
0299002005290107  *
030000020404     C                   endsr
030100020402     C*
