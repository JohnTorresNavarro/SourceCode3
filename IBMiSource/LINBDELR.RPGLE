0001000204020002  *****************************************************************************
000200210421      * LINBDELR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400210421      *            DATE - 04/2021                                                 *
000500210421      *  DESCRIPTION - Build file of current Lincoln Dental                       *
000600210421      *                Eligibility - Lincoln Fmt V2                               *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900210421      *  xxx mm/dd/yyyy                                                           *
001000200828      *
0011009102150018 F******************************************************************
001200210421     FMCOVC16   IF   E           K DISK
001300020404     FMEMBER    IF   E           K DISK
001400020404     FDCOV      IF   E           K DISK
0015002104210019 FPLNMST    IF   E           K DISK
001600210421     FCODES     IF   E           K DISK
001700210421     FCARMST    IF   E           K DISK
001800020404     FDEPNDC    IF   E           K DISK
0019002104210020 F***LINHDRP   UF A E           K DISK
0020002104220020 FLINDTLP   O    E             DISK
0021002104220020 FLINDTLL   UF   E           K DISK    RENAME(LINDTLR:LINDR)
0022002104220020 F                                     PREFIX(L)
0023000204020025  *
002400200529      *
0025002005290250 D                 DS
0026002005290251 D  fill66                 1     66
0027002005290251 D   gemail                1     65
002800210421      *
0029002104210250 D                 DS
0030002104210251 D  plncat                 1      3
0031002104210251 D   cdkey1                1      1
0032002104210251 D   cdkey2                2      3
003300200529      *
0034002005290250 D                 DS
0035002005290251 D  reccnt                 1      9S 0 INZ(0)
0036002005290251 D  reccna                 1      9
003700200529      *
0038000906120250 D                 DS
0039000906120251 D  dseq                          2S 0 INZ(0)
0040002104210251 D  per#                          2S 0 INZ(0)
0041002105140251 D  depage                        3S 0 INZ(0)
0042002105140251 D  dobi                           D   DATFMT(*ISO)
0043002105140251 D  todayi                         D   DATFMT(*ISO)
0044002005290251 D  cutofx                         D   DATFMT(*ISO)
0045002005290251 D  cutofy                         D   DATFMT(*ISO)
0046000906120251 D  cutofn                        8S 0
0047002005290251 D  cutofa                        8S 0
0048000906120251 D  today8                        8S 0
0049000204150251 D  updt                          1A
0050002104260251 D  tier                               LIKE(LIDTIER)
005100020402      *
0052002104210251 D  todaa                         8S 0
0053002104210251 D  date9                         8S 0
005400200528      *
005500020415      *
005600210421     C     cdkey         klist
005700210421     C                   kfld                    cdkey1
005800210421     C                   kfld                    cdkey2
005900210421      *
006000210421     C     plkey         klist
006100210421     C                   kfld                    mctrst
006200210421     C                   kfld                    mcsub#
006300210421     C                   kfld                    mcplan
006400081103      *
006500041228     C     mcvky         klist
006600210421     C                   kfld                    ktrst             3 0
006700210421     C                   kfld                    ksub#             3 0
006800210421     C                   kfld                    kacct             4 0
006900081103      *
007000020404     C     depky         klist
007100081103     C                   kfld                    mbssno
007200081103     C                   kfld                    dseq#
007300210422      *
007400210422     C     linky         klist
007500210422     C                   kfld                    ssna              9
007600210422     C                   kfld                    per#
007700210422     C                   kfld                    kfnam            15
0078002104210291  *
0079002104210291  *   Preprocessing
0080002105040291  *
0081002105140297 C                   movel     UDATE         todayi
0082002105140297 C                   movel     todayi        today8
0083002105140297 C                   movel     todayi        todaa
0084002105110297 C                   z-add     99999999      date9
0085002105040291  * Determine Term date cutoff to start - 90 days prior to term dt
0086002105140297 C     todayi        subdur    90:*D         cutofx
0087002105040297 C                   movel     cutofx        cutofn
0088002105040291  * Determine Term date cutoff to end - 60 days after term dt
0089002105140297 C     todayi        adddur    60:*D         cutofy
0090002105040297 C                   movel     cutofy        cutofa
0091002005280291  *   Update and write the Header Record
0092002104210297 C****               read      ese15hdp
0093002104210297 C****               movel     todaa         echcudt
0094002104210297 C****               update    ese15hdr
0095002104210291  *   Set TSA Key flds
0096002104290297 C                   eval      ktrst = 003
0097002104290297 C                   eval      ksub# = 001
0098002104290297 C                   eval      kacct = 2786
0099000204040291  *
0100002104210291  * Main Line - MCOV looking for Lincoln DEN plans
0101002105130297 C     mcvky         setll     mcovc16                            21
0102002105130296 C                   dou       *in21 = '1'
0103002105130297 C     mcvky         reade     mcovc16                                21
0104002105130296 C                   If        *in21 = '0' and enrldt <> candt
0105002105130291  *      Get Plan MST rec
0106002105130297 C     plkey         chain     plnmst                             22
0107002105130296 C                   If        *in22 = '0'
0108002105130291  *      Chk for Lincoln Carrier
0109002105130296 C                   If        pcarr = 'AD1' or
0110002105130296 C                             pcarr = 'ALD' or
0111002105180296 C                             pcarr = 'GUD'
0112002105180291  *      Chk Codes file for Plan Type
0113002105180297 C     cdkey         chain     codes                              23
0114002105180296 C                   If        *in23 = '0' and ACTION = 'D'
0115002105180291  *
0116002105270291  *        Debug shit
0117002105270296 C                   If        mcssno = 217317750
0118002105270297 C                   eval      pcarr = pcarr
0119002105270297 C                   endif
0120002105180291  *
0121002105270291  *        Get member record
0122002105270297 C     mcssno        chain     member                             32
0123002105270296 C                   If        *in32 = '0'
0124002105270291  *
0125002105180291 C                   exsr      bldmbr
0126002105180291  *
0127000907020291  *        Look for dependents of member             7
0128002105180297 C     mcssno        setll     dcov                               33
0129002105180296 C                   dou       *in33 = '1'
0130002105130297 C     mcssno        reade     dcov                                   33
0131002105130296 C                   If        *in33 = '0' and pltrst = dvtrst and
0132002104210296 C                             plsub# = dvsub# and plplan = dvplan
0133000206040291  *
0134002104210296 C                   If        ccandt = denrdt
0135002104210296 C                   iter
0136002104210297 C                   endif                                                  ccandt = 0
0137002105130291  *   Don't use termed deps
0138002105130296 C                   If        ccandt <> 0 and ccandt < today8
0139002105130296 C                   iter
0140002105130297 C                   endif                                                  ccandt = 0
0141000204040291  *
0142000204040291 C                   exsr      blddep
0143000906010291  *
0144002104210297 C*****              endif                                                  ccandt = 0
0145002104210297 C****               endif                                                  ccandt = 0
0146000906010291  *
0147002005290297 C                   endif                                                  ccandt = 0
0148000906010291  *
0149000906010297 C                   enddo                                                  *in33 = '1'
0150000906010291  *
0151000204040297 C                   endif                                                  *in32 = '0'
0152000906010291  *
0153002005290297 C                   endif                                                  *in32 = '0'
0154002005290291  *
0155000204040297 C                   endif                                                  candt = 0
0156002104210291  *
0157000204040297 C                   endif                                                  *in31 = '0'
0158002104210291  *
0159002104210297 C                   endif                                                  *in22 = '0'
0160002104210291  *
0161000204020297 C                   enddo                                                  *in31 = '1'
0162000204020291  *
0163000811030291  *
0164000811030297 C                   movel     '1'           *inlr
0165000811030297 C                   return
0166000204020107  ********************************************************************************
0167000204020107  *
0168000204020107  *     BLDMBR - Build Member record
0169000204020107  *
0170000204020107  ********************************************************************************
017100020402     C     bldmbr        begsr
0172002104260107  *  Set Covtyp - Tier
017300210623     C                   If        mcovtp = 'TIN'
017400210623     C                   eval      tier = '1'
017500210623     C                   else
017600210623     C                   If        mcovtp = 'THW'
017700210623     C                   eval      tier = '2'
017800210623     C                   else
017900210623     C                   If        mcovtp = 'TFA'
018000210623     C                   eval      tier = '4'
018100210623     C                   else
018200210623     C                   eval      tier = '3'
018300210623     C                   endif
018400210505     C                   endif
018500210426     C                   endif
0186002104260107  *
0187002104220107  *  If Mbr rec already exists - update eff/term date
018800210422     C                   movel     mbssno        ssna
018900210422     C                   eval      per# = 0
019000210422     C                   movel(P)  mfname        kfnam
019100210506     C     linky         chain     lindtll                            61
019200210506     C                   if        *IN61 = '0'
0193002105060107  *
019400210506     C                   if        candt = 0 or candt > llidtmdt
019500210506     C                   eval      llidtmdt = candt
019600210506     C                   endif
0197002005280107  *
019800210506     C                   if        enrldt < llidefdt
019900210506     C                   eval      llidefdt = enrldt
020000210506     C                   endif
0201002105060107  *
020200210527     C******             if        candt = 0 or candt < todaa
020300210527     C                   if        enrldt < todaa
020400210527     C                   if        tier <> llidtier
020500210527     C                   eval      llidtier = tier
020600210527     C                   endif
020700210527     C                   endif
0208002105270107  *
020900210527     C                   update    lindr
021000210527     C                   leavesr
0211002105270107  *
021200210527     C                   endif
0213002105270107  *
0214002104220107  *
021500210421     C                   clear                   lindtlr
0216002005280107  *  Set Default Values
021700210429     C                   eval      lidper# = 0
021800210429     C                   eval      per# = 0
021900210429     C                   eval      lidtyp = 'M'
022000210429     C                   eval      lidrel = 'M'
0221002104290107  *    Participant Values
022200210429     C                   movel     mbssno        lidssn
022300210429     C                   eval      lidefdt = enrldt
022400210429     C                   eval      lidtmdt = candt
022500210429      *
022600210429     C                   movel     mlname        lidlnam
022700210429     C                   movel     mfname        lidfnam
022800210429     C                   move      mmi           lidmi
022900210421     C                   eval      liddob = birth
023000210421     C                   movel     sex           lidsex
023100200528      *
023200210421     C                   MOVEL(P)  addr1         lidadd1
023300210421     C                   movel     addr2         lidadd2
0234002104210107  *     Use adr2 if adr1 is blank
0235002104210296 C                   If        lidadd1 = *blanks and lidadd2 <> *blanks
023600210421     C                   movel(P)  lidadd2       lidadd1
023700210421     C                   movel     *blanks       lidadd2
023800200528     C                   endif                                                  *in62 = '0'
0239002005290107  *
024000210421     C                   movel     city          lidcity
024100210421     C                   move      state         lidst
024200210421     C                   movel     zip           lidzip
024300200529      *
024400210421     C                   eval      liddoh = empdt
024500210421     C                   eval      lidpln# = mcplan
024600210426     C                   eval      lidtier = tier
024700200529      *
024800210421     C                   write     lindtlr
0249000907010107  *
025000090701     C                   endsr
0251000204150107  ********************************************************************************
0252000907010107  *
0253000204040107  *     BLDDEP - Build Dependent Record
0254000907010107  *
0255000204040107  ********************************************************************************
025600090701     C     blddep        begsr
0257000907010291  *        Get Dependent record
0258000907010297 C     depky         chain     depndc                             42
0259000907010296 C                   If        *in42 = '0' and
0260000812040296 C                             (ccandt = 0 or ccandt > denrdt)
026100210422     C                   eval      per# = per# + 1
0262002104220107  *  If Dep rec already exists - update eff/term date
026300210422     C                   movel     mbssno        ssna
026400210422     C                   movel(P)  dfname        kfnam
026500210422     C     linky         chain     lindtll                            61
026600210422     C                   if        *IN61 = '0'
0267002104220107  *
026800210422     C                   if        ccandt = 0 or ccandt > llidtmdt
026900210422     C                   eval      llidtmdt = candt
027000210422     C                   endif
0271002104220107  *
027200210422     C                   if        denrdt < llidefdt
027300210422     C                   eval      llidefdt = denrdt
027400210422     C                   endif
0275002104220107  *
027600210422     C                   update    lindr
027700210422     C                   leavesr
0278002104220107  *
027900210422     C                   endif
0280002104220107  *
0281002104220107  *
0282002005290107  *     Dependent Values
0283000812040291  *
0284002104210107  *  Set Default Values
028500210421     C                   eval      lidper# = per#
028600210421     C                   eval      lidtyp = 'D'
028700210421     C                   eval      lidrel = 'M'
0288002104210107  *    Participant Values
028900210421     C                   movel     mbssno        lidssn
0290002104210107  *    Dep Values
029100020404     C                   if        dlname = 'SAME'
029200210421     C                   movel     mlname        lidlnam
029300020404     C                   else
029400210421     C                   movel     dlname        lidlnam
029500020404     C                   endif
0296000204040107  *
029700210421     C                   movel     dfname        lidfnam
029800210421     C                   move      dmi           lidmi
0299000204040107  *
030000200529     C                   if        daddr1 <> 'SAME'
030100210421     C                   movel     daddr1        lidadd1
030200210421     C                   movel     daddr2        lidadd2
030300210421     C                   movel     dcity         lidcity
030400210421     C                   move      dstate        lidst
030500210421     C                   movel     dzip          lidzip
030600090710     C                   endif
0307002005290107  *
030800210421     C                   move      dsex          lidsex
030900210421     C                   eval      liddob = dbirth
031000210421     C                   eval      lidefdt = denrdt
031100210421     C                   eval      lidtmdt = ccandt
031200210421      *
031300210421     C                   movel     depss#        lidpssn
0314000907100107  *
031500210421     C                   eval      lidrel = ' '
031600200529     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
031700210421     C                   eval      lidrel = 'S'
031800090612     C                   else                                                   *in62 = '0'
031900200529     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
032000210421     C                   eval      lidrel = 'C'
0321002105140107  *       If child's age > 18, check student code
032200210514     C                   move      dbirth        dobi
032300210514     C     todayi        subdur    dobi          depage:*Y
032400210514     C                   if        depage < 19
032500210514     C                   eval      lidstd = 'Y'
032600210514     C                   else                                                   *in62 = '0'
032700210514     C                   eval      lidstd = 'N'
032800210514     C                   if        dstudn = 'Y'
032900210514     C                   eval      lidstd = 'Y'
033000210514     C                   endif                                                  *in62 = '0'
033100210514     C                   endif                                                  *in62 = '0'
0332002105140107  *
033300090612     C                   endif                                                  *in62 = '0'
033400210514     C                   endif                                                  *in62 = '0'
0335000906120107  *
033600210421     C                   write     lindtlr
0337002005290107  *
033800200529     C                   endif                                                  *in62 = '0'
0339002005290107  *
034000020404     C                   endsr
034100020402     C*
