0001000204020002  *****************************************************************************
000200210510      * ESRXBEXR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400210510      *            DATE - 05/2021                                                 *
000500200527      *  DESCRIPTION - Build file of current Express Scripts (ESI)                *
000600210512      *                Elig - ESI 1500 East Format - RxBenefits                   *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900210923      *  RLJ 09/23/2021 - Omit acct 590-10-9 per Brandon                          *
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
0082002105250297 C     'RXB'         setll     plnmstn1                           21
0083002105250296 C                   dou       *in21 = '1'
0084002105250297 C     'RXB'         reade     plnmstn1                               21
0085002105250296 C                   If        *in21 = '0'
0086002105250291  *     Using GBS info - Get GRATE record
0087002105250297 C     grkey         setll     grat24                             22
0088002105200297 C                   readp     grat24                                 22
0089000204040296 C                   If        *in22 = '0'
0090000207230291  *
0091000204030291  *        Loop thru mcov file using T,S,P
0092002008270297 C     mcvky         setll     mcov42                             31
0093002105250296 C                   dou       *in31 = '1'
0094002105250297 C     mcvky         reade     mcov42                                 31
0095002105250296 C                   If        *in31 = '0' and pltrst = mctrst and
0096002105250296 C                             plsub# = mcsub# and plplan = mcplan and
0097002105040296 C                             (candt = 0 or candt > enrldt)
0098000907090291  *
0099000907020296 C                   If        candt = 0 or candt > cutofn
0100002005290296 C                   If        candt = 0 or candt < cutofa
0101002110060291  *
0102002110060291  *  Bypass certain accounts!!!!!
0103002109230296 C                   If        mctrst = 590 and mcsub# = 10 and
0104002109230296 C                             acc# = 9
0105002109230291 C                   iter
0106002109230291 C                   endif
0107000907020291  *
0108002105260291  *        Get member record
0109002105260297 C     mcssno        chain     member                             32
0110002105260296 C                   If        *in32 = '0'
0111002105260291  *
0112002105260291 C                   exsr      bldmbr
0113002109230291  *
0114002105260291  *        Look for dependents of member             7
0115002105260297 C     mcssno        setll     dcov                               33
0116002105260296 C                   dou       *in33 = '1'
0117002105260297 C     mcssno        reade     dcov                                   33
0118002105260296 C****               If        *in33 = '0' and pltrst = dvtrst and
0119002105260296 C*                            plsub# = dvsub# and plplan = dvplan and
0120002105260296 C****                         enrldt = denrdt
0121002204130291  *
0122002204130296 C                   If        ccandt = denrdt
0123002204130296 C                   iter
0124002204130296 C                   endif
0125002204130291  *
0126002105260296 C                   If        *in33 = '0' and pltrst = dvtrst and
0127002105040296 C                             plsub# = dvsub# and plplan = dvplan
0128000206040291  *
0129000206040296 C                   If        ccandt = 0 or ccandt > cutofn
0130002005290296 C                   If        ccandt = 0 or ccandt < cutofa
0131000204040291  *
0132000204040291 C                   exsr      blddep
0133000906010291  *
0134000906010297 C                   endif                                                  ccandt = 0
0135000906010291  *
0136002005290297 C                   endif                                                  ccandt = 0
0137002005290291  *
0138000906010297 C                   endif                                                  *in33 = '0'
0139000906010291  *
0140000906010297 C                   enddo                                                  *in33 = '1'
0141000906010291  *
0142000204040297 C                   endif                                                  *in32 = '0'
0143000906010291  *
0144002005290297 C                   endif                                                  *in32 = '0'
0145002005290291  *
0146000204040297 C                   endif                                                  candt = 0
0147000204040297 C                   endif                                                  *in31 = '0'
0148000204020297 C                   enddo                                                  *in31 = '1'
0149000204020291  *
0150000204040297 C                   endif                                                  *in22 = '0'
0151000204020291  *
0152000501110297 C                   endif                                                  *in21 = '0'
0153002105120296 C                   If        pcarr > 'RXB'
0154000501110296 C                   leave
0155000811030297 C                   endif                                                  pcarr > 'EX2'
0156000811030297 C                   enddo                                                  *in21 = '1'
0157000811030291  *
0158002005290291  *   Update and write the Trailer Record
0159002105100297 C                   read      esrxbtrp
0160002105200297 C                   eval      reccnt = reccnt + 2
0161002105200297 C                   eval      ectrec = reccna
0162002105200297 C                   movel     todaa         ectcudt
0163002105200297 C                   update    esrxbtrr
016400210520      *
0165002105200291  *
0166002105200297 C                   movel     '1'           *inlr
0167000811030297 C                   return
0168000204020107  ********************************************************************************
0169000204020107  *
0170000204020107  *     BLDMBR - Build Member record
0171000204020107  *
0172000204020107  ********************************************************************************
017300020402     C     bldmbr        begsr
0174002005280107  *****
0175002005280107  *
017600210510     C                   clear                   esrxbdtr
0177002005280107  *  Set Default Values
017800200528     C                   eval      ecdtyp = 'E'
017900200528     C                   movel(P)  '001'         ecdper#
018000200528     C                   eval      ecdtrcd = 'P'
018100200528     C                   eval      ecdrelc = '1'
0182002005280107  *    Participant Values
018300211007     C                   movel     mbssno        ecdsub#
018400211007     C                   movel(P)  group#        ecdgrid
018500211007     C                   movel     enrldt        ecdefdt
018600211007     C                   movel     candt         ecdtmdt
018700211007      *
0188002110070296 C                   If        ecdtmdt = '00000000'
018900211007     C                   eval      ecdtmdt = *blanks
0190002110070296 C                   endif
019100211007      *
019200211007     C                   movel     mlname        ecdlnam
019300200529     C                   movel     mfname        ecdfnam
019400200528     C                   move      mmi           ecdmi
019500200528     C                   movel     birth         ecddob
019600200528     C                   movel     sex           ecdsex
019700200528     C                   movel     mbssno        ecdssn
019800200528      *
019900200528     C                   MOVEL(P)  addr1         ecdadd1
020000200528     C                   movel     addr2         ecdadd2
0201002005280107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0202002005280296 C                   If        ecdadd1 = *blanks and ecdadd2 <> *blanks
020300200528     C                   movel(P)  ecdadd2       ecdadd1
020400200528     C                   movel     *blanks       ecdadd2
020500200528     C                   endif                                                  *in62 = '0'
0206002005280107  *
020700200529     C                   movel     ecdadd1       svadr1
020800200528     C                   movel     ecdadd2       svadr2
0209002005280107  *
021000200528     C                   movel     city          ecdcity
021100200528     C                   movel     ecdcity       svcity
021200200528     C                   move      state         ecdst
021300200528     C                   movel     ecdst         svst
021400200528     C                   movel     zip           ecdzip
021500200528     C                   movel     ecdzip        svzip
021600200529      *           Set Phone# if not 0
0217002005290296 C                   If        area <> 0 and phone <> 0
021800200528     C                   movel     area          ecdphon
021900200528     C                   move      phone         ecdphon
0220002005290296 C                   endif
022100200529      *
022200200529      *           Set coverage level
0223002005290296 C                   If        mcovtp = 'TIN'
022400200529     C                   eval      ecdcvcd = '1'
0225002005290296 C                   else
022600200529     C                   eval      ecdcvcd = '6'
0227002005290296 C                   endif
022800200529      *
022900200529     C                   movel(P)  '00'          ecddep#
0230002005290107  *
0231002005290297 C                   eval      reccnt = reccnt + 1
023200200529      *
023300210511     C                   eval      ecdf8x = 'X'
023400210510     C                   write     esrxbdtr
0235000907010107  *
023600090701     C                   endsr
0237000204150107  ********************************************************************************
0238000907010107  *
0239000204040107  *     BLDDEP - Build Dependent Record
0240000907010107  *
0241000204040107  ********************************************************************************
024200090701     C     blddep        begsr
0243000907010291  *        Get Dependent record
0244000907010297 C     depky         chain     depndc                             42
0245002105200296 C                   If        *in42 = '0' and
0246002105200296 C                             (ccandt = 0 or ccandt > denrdt)
0247002105200107  *     Dependent Values
024800210520     C                   movel     '002'         ecdper#
0249002105200291  *
025000210520     C                   if        dlname = 'SAME'
025100210520     C                   movel     mlname        ecdlnam
025200210520     C                   else
025300200529     C                   movel     dlname        ecdlnam
025400210520     C                   endif
0255002105200107  *
025600210520     C                   movel     dfname        ecdfnam
025700210520     C                   move      dmi           ecdmi
0258002105200107  *
025900210520     C                   if        daddr1 <> 'SAME'
026000200529     C                   movel     daddr1        ecdadd1
026100200529     C                   movel     daddr2        ecdadd2
026200200529     C                   movel     dcity         ecdcity
026300200529     C                   move      dstate        ecdst
026400200529     C                   movel     dzip          ecdzip
026500090710     C                   endif
026600200529      *           Set Phone# if not 0
0267002005290296 C                   eval      ecdphon = *blanks
0268002005290296 C                   If        darea <> 0 and dphone <> 0
026900200529     C                   movel     darea         ecdphon
027000200529     C                   move      dphone        ecdphon
0271002005290296 C                   endif
027200200529      *
0273000907100107  *
027400200529     C                   movel     dbirth        ecddob
027500200529     C                   move      dsex          ecdsex
027600200529     C                   movel     denrdt        ecdefdt
027700200529     C                   movel     ccandt        ecdtmdt
027800200529      *
0279002005290296 C                   If        ecdtmdt = '00000000'
028000200529     C                   eval      ecdtmdt = *blanks
0281002005290296 C                   endif
0282002005290107  *
028300200529     C                   movel(P)  dpseq#        ecddep#
0284002005290107  *
028500200529     C                   movel     depss#        ecdssn
028600200529      *
028700200529     C                   eval      ecdcvcd = ' '
0288000907100107  *
028900200529     C                   eval      ecdrelc = ' '
029000200529     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
029100200529     C                   eval      ecdrelc = '2'
029200090612     C                   else                                                   *in62 = '0'
029300200529     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
029400200529     C                   eval      ecdrelc = '3'
029500090612     C                   else                                                   *in62 = '0'
029600200529     C                   if        drelcd = 'RPA'
029700200529     C                   eval      ecdrelc = '8'
029800090612     C                   endif                                                  *in62 = '0'
029900090612     C                   endif                                                  *in62 = '0'
030000090612     C                   endif                                                  *in62 = '0'
0301000906120107  *
030200200821     C                   if        dhndcp = '3'
030300210524     C                   eval      ecdrelc = '5'
030400210524     C                   endif                                                  *in62 = '0'
0305002105240107  *
030600210524     C                   eval      ecdf8x = 'X'
030700210524     C                   write     esrxbdtr
030800210524     C                   eval      reccnt = reccnt + 1                          *in62 = '0'
0309002105240107  *
031000200529     C                   endif                                                  *in62 = '0'
0311002105240107  *
031200210524     C                   endsr
031300020402     C*
