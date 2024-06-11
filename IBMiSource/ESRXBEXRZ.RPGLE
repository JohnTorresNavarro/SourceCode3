0001000204020002  *****************************************************************************
000200210923      * ESRXBEXRZ  Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400210923      *            DATE - 09/2021                                                 *
000500200527      *  DESCRIPTION - Build file of current Express Scripts (ESI)                *
000600210923      *                Elig - RxBenefits for 1 account                            *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900210923      *  xxx mm/dd/yyyy -                                                         *
001000200828      *
0011009102150018 F******************************************************************
0012000501110019 FPLNMSTN1  IF   E           K DISK
001300200827     FMCOV42    IF   E           K DISK
001400020404     FMEMBER    IF   E           K DISK
001500020404     FGRAT24    IF   E           K DISK
001600020404     FDCOV      IF   E           K DISK
001700020404     FDEPNDC    IF   E           K DISK
0018002110050020 FESRXBHZP  UF A E           K DISK
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
0077002110050297 C                   read      esrxbhZp
0078002105200297 C                   movel     todaa         echcudt
0079002110050297 C                   update    esrxbhZr
0080002105200291  *
0081002105200291  * Main Line - Loop thru plan master
0082002110120297 C     'RXB'         setll     plnmstn1                           21
0083002110120296 C                   dou       *in21 = '1'
0084002110120297 C     'RXB'         reade     plnmstn1                               21
0085002110120296 C                   If        *in21 = '0'
0086002110120291  *     Using GBS info - Get GRATE record
0087002110120297 C     grkey         setll     grat24                             22
0088002110120297 C                   readp     grat24                                 22
0089002110120296 C                   If        *in22 = '0'
0090002110120291  *
0091000204030291  *        Loop thru mcov file using T,S,P
0092002110040297 C     mcvky         setll     mcov42                             31
0093002110040296 C                   dou       *in31 = '1'
0094002110040297 C     mcvky         reade     mcov42                                 31
0095002110040296 C                   If        *in31 = '0' and pltrst = mctrst and
0096002110040296 C                             plsub# = mcsub# and plplan = mcplan and
0097002110040296 C                             (candt = 0 or candt > enrldt)
0098002110040291  *
0099002110050296 C                   If        candt = 0 or candt > cutofn
0100002110050296 C                   If        candt = 0 or candt < cutofa
0101002110050291  *
0102002110050291  *        Only pull from this account
0103002110050296 C                   If        mctrst = 590 and mcsub# = 10 and
0104002110050296 C                             acc# = 9
0105002110050291 C******             iter
0106002110050291 C******             endif
0107002110050291  *
0108002110050291  *        Get member record
0109002110050297 C     mcssno        chain     member                             32
0110002110050296 C                   If        *in32 = '0'
0111002110050291  *
0112002110050291 C                   exsr      bldmbr
0113002110050291  *
0114002110050291  *        Look for dependents of member             7
0115002110050297 C     mcssno        setll     dcov                               33
0116002109240296 C                   dou       *in33 = '1'
0117002109240297 C     mcssno        reade     dcov                                   33
0118002109240296 C****               If        *in33 = '0' and pltrst = dvtrst and
0119002105260296 C*                            plsub# = dvsub# and plplan = dvplan and
0120002105260296 C****                         enrldt = denrdt
0121002204130291  *
0122002204130296 C                   If        ccandt = denrdt
0123002204130296 C                   iter
0124002204130296 C                   endif
0125002204130291  *
0126002110060296 C                   If        *in33 = '0' and pltrst = dvtrst and
0127002110060296 C                             plsub# = dvsub# and plplan = dvplan
0128002110060291  *
0129002110060296 C                   If        ccandt = 0 or ccandt > cutofn
0130002110060296 C                   If        ccandt = 0 or ccandt < cutofa
0131002110060291  *
0132002110060291 C                   exsr      blddep
0133002110060291  *
0134002110060297 C                   endif                                                  ccandt = 0
0135002110060291  *
0136002110060297 C                   endif                                                  ccandt = 0
0137002110060291  *
0138002110060297 C                   endif                                                  *in33 = '0'
0139000906010291  *
0140000906010297 C                   enddo                                                  *in33 = '1'
0141000906010291  *
0142000204040297 C                   endif                                                  *in32 = '0'
0143000906010291  *
0144002005290297 C                   endif                                                  *in32 = '0'
0145002005290291  *
0146002109230297 C                   endif                                                  *in32 = '0'
0147002109230291  *
0148000204040297 C                   endif                                                  candt = 0
0149000204040297 C                   endif                                                  *in31 = '0'
0150000204020297 C                   enddo                                                  *in31 = '1'
0151000204020291  *
0152000204040297 C                   endif                                                  *in22 = '0'
0153000204020291  *
0154000501110297 C                   endif                                                  *in21 = '0'
0155002105120296 C                   If        pcarr > 'RXB'
0156000501110296 C                   leave
0157000811030297 C                   endif                                                  pcarr > 'EX2'
0158000811030297 C                   enddo                                                  *in21 = '1'
0159000811030291  *
0160002005290291  *   Update and write the Trailer Record
0161002105100297 C                   read      esrxbtrp
0162002105200297 C                   eval      reccnt = reccnt + 2
0163002105200297 C                   eval      ectrec = reccna
0164002105200297 C                   movel     todaa         ectcudt
0165002105200297 C                   update    esrxbtrr
016600210520      *
0167002105200291  *
0168002105200297 C                   movel     '1'           *inlr
0169000811030297 C                   return
0170000204020107  ********************************************************************************
0171000204020107  *
0172000204020107  *     BLDMBR - Build Member record
0173000204020107  *
0174000204020107  ********************************************************************************
017500020402     C     bldmbr        begsr
0176002005280107  *****
0177002005280107  *
017800210510     C                   clear                   esrxbdtr
0179002005280107  *  Set Default Values
018000200528     C                   eval      ecdtyp = 'E'
018100200528     C                   movel(P)  '001'         ecdper#
018200200528     C                   eval      ecdtrcd = 'P'
018300200528     C                   eval      ecdrelc = '1'
0184002005280107  *    Participant Values
018500200528     C                   movel     mbssno        ecdsub#
018600210928     C                   movel(P)  group#        ecdgrid
018700210928     C                   movel     enrldt        ecdefdt
018800210928     C                   movel     candt         ecdtmdt
018900210928      *
0190002109280296 C                   If        ecdtmdt = '00000000'
019100210928     C                   eval      ecdtmdt = *blanks
0192002005280296 C                   endif
019300200528      *
019400200528     C                   movel     mlname        ecdlnam
019500200529     C                   movel     mfname        ecdfnam
019600200528     C                   move      mmi           ecdmi
019700200528     C                   movel     birth         ecddob
019800200528     C                   movel     sex           ecdsex
019900200528     C                   movel     mbssno        ecdssn
020000200528      *
020100200528     C                   MOVEL(P)  addr1         ecdadd1
020200200528     C                   movel     addr2         ecdadd2
0203002005280107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0204002109270296 C                   If        ecdadd1 = *blanks and ecdadd2 <> *blanks
020500210927     C                   movel(P)  ecdadd2       ecdadd1
020600200528     C                   movel     *blanks       ecdadd2
020700210927     C                   endif                                                  *in62 = '0'
0208002109270107  *
020900210927     C                   movel     ecdadd1       svadr1
021000210927     C                   movel     ecdadd2       svadr2
0211002109270107  *
021200210927     C                   movel     city          ecdcity
021300210927     C                   movel     ecdcity       svcity
021400210927     C                   move      state         ecdst
021500210927     C                   movel     ecdst         svst
021600210927     C                   movel     zip           ecdzip
021700200528     C                   movel     ecdzip        svzip
021800200529      *           Set Phone# if not 0
0219002005290296 C                   If        area <> 0 and phone <> 0
022000200528     C                   movel     area          ecdphon
022100200528     C                   move      phone         ecdphon
0222002005290296 C                   endif
022300200529      *
022400200529      *           Set coverage level
0225002005290296 C                   If        mcovtp = 'TIN'
022600200529     C                   eval      ecdcvcd = '1'
0227002005290296 C                   else
022800200529     C                   eval      ecdcvcd = '6'
0229002005290296 C                   endif
023000200529      *
023100200529     C                   movel(P)  '00'          ecddep#
0232002005290107  *
0233002005290297 C                   eval      reccnt = reccnt + 1
023400200529      *
023500210511     C                   eval      ecdf8x = 'X'
023600210510     C                   write     esrxbdtr
0237000907010107  *
023800090701     C                   endsr
0239000204150107  ********************************************************************************
0240000907010107  *
0241000204040107  *     BLDDEP - Build Dependent Record
0242000907010107  *
0243000204040107  ********************************************************************************
024400090701     C     blddep        begsr
0245000907010291  *        Get Dependent record
0246000907010297 C     depky         chain     depndc                             42
0247002105200296 C                   If        *in42 = '0' and
0248002105200296 C                             (ccandt = 0 or ccandt > denrdt)
0249002105200107  *     Dependent Values
025000210520     C                   movel     '002'         ecdper#
0251002105200291  *
025200210520     C                   if        dlname = 'SAME'
025300210520     C                   movel     mlname        ecdlnam
025400210520     C                   else
025500200529     C                   movel     dlname        ecdlnam
025600210520     C                   endif
0257002105200107  *
025800210520     C                   movel     dfname        ecdfnam
025900210520     C                   move      dmi           ecdmi
0260002105200107  *
026100210520     C                   if        daddr1 <> 'SAME'
026200200529     C                   movel     daddr1        ecdadd1
026300200529     C                   movel     daddr2        ecdadd2
026400200529     C                   movel     dcity         ecdcity
026500200529     C                   move      dstate        ecdst
026600200529     C                   movel     dzip          ecdzip
026700090710     C                   endif
026800200529      *           Set Phone# if not 0
0269002005290296 C                   eval      ecdphon = *blanks
0270002005290296 C                   If        darea <> 0 and dphone <> 0
027100200529     C                   movel     darea         ecdphon
027200200529     C                   move      dphone        ecdphon
0273002005290296 C                   endif
027400200529      *
0275002110050107  *
027600211005     C                   movel     dbirth        ecddob
027700211005     C                   move      dsex          ecdsex
027800211005     C                   movel     denrdt        ecdefdt
027900211005     C                   movel     ccandt        ecdtmdt
028000211005      *
0281002110050296 C                   If        ecdtmdt = '00000000'
028200211005     C                   eval      ecdtmdt = *blanks
0283002110050296 C                   endif
0284002110050107  *
028500211005     C                   movel(P)  dpseq#        ecddep#
0286002110050107  *
028700211005     C                   movel     depss#        ecdssn
028800200529      *
028900211005     C                   eval      ecdcvcd = ' '
0290002110050107  *
029100211005     C                   eval      ecdrelc = ' '
029200210927     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
029300210927     C                   eval      ecdrelc = '2'
029400210927     C                   else                                                   *in62 = '0'
029500210927     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
029600210927     C                   eval      ecdrelc = '3'
029700210927     C                   else                                                   *in62 = '0'
029800210927     C                   if        drelcd = 'RPA'
029900210927     C                   eval      ecdrelc = '8'
030000090612     C                   endif                                                  *in62 = '0'
030100090612     C                   endif                                                  *in62 = '0'
030200090612     C                   endif                                                  *in62 = '0'
0303000906120107  *
030400200821     C                   if        dhndcp = '3'
030500210524     C                   eval      ecdrelc = '5'
030600210524     C                   endif                                                  *in62 = '0'
0307002105240107  *
030800210524     C                   eval      ecdf8x = 'X'
030900210524     C                   write     esrxbdtr
031000210524     C                   eval      reccnt = reccnt + 1                          *in62 = '0'
0311002105240107  *
031200200529     C                   endif                                                  *in62 = '0'
0313002105240107  *
031400210524     C                   endsr
031500020402     C*
