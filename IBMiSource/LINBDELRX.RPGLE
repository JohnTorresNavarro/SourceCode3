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
0041000906120251 D  cutoff                         D   DATFMT(*ISO)
0042002005290251 D  cutofx                         D   DATFMT(*ISO)
0043002005290251 D  cutofy                         D   DATFMT(*ISO)
0044000906120251 D  cutofn                        8S 0
0045002005290251 D  cutofa                        8S 0
0046000906120251 D  today8                        8S 0
0047000204150251 D  updt                          1A
0048002104260251 D  tier                               LIKE(LIDTIER)
004900020402      *
0050002104210251 D  todaa                         8S 0
0051002104210251 D  date9                         8S 0
005200200528      *
005300020415      *
005400210421     C     cdkey         klist
005500210421     C                   kfld                    cdkey1
005600210421     C                   kfld                    cdkey2
005700210421      *
005800210421     C     plkey         klist
005900210421     C                   kfld                    mctrst
006000210421     C                   kfld                    mcsub#
006100210421     C                   kfld                    mcplan
006200081103      *
006300041228     C     mcvky         klist
006400210421     C                   kfld                    ktrst             3 0
006500210421     C                   kfld                    ksub#             3 0
006600210421     C                   kfld                    kacct             4 0
006700081103      *
006800020404     C     depky         klist
006900081103     C                   kfld                    mbssno
007000081103     C                   kfld                    dseq#
007100210422      *
007200210422     C     linky         klist
007300210422     C                   kfld                    ssna              9
007400210422     C                   kfld                    per#
007500210422     C                   kfld                    kfnam            15
0076002104210291  *
0077002104210291  *   Preprocessing
0078002104210291  *
0079000907080297 C                   movel     UDATE         cutoff
0080000907080297 C                   movel     cutoff        today8
0081000206130297 C                   movel     cutoff        todaa
0082000207230297 C                   z-add     99999999      date9
0083002005290291  * Determine Term date cutoff to start - 90 days prior to term dt
0084002005290297 C     cutoff        subdur    90:*D         cutofx
0085002005290297 C                   movel     cutofx        cutofn
0086002005290291  * Determine Term date cutoff to end - 60 days after term dt
0087002005290297 C     cutoff        adddur    60:*D         cutofy
0088002005290297 C                   movel     cutofy        cutofa
0089002005280291  *   Update and write the Header Record
0090002104210297 C****               read      ese15hdp
0091002104210297 C****               movel     todaa         echcudt
0092002104210297 C****               update    ese15hdr
0093002104210291  *   Set TSA Key flds
0094002104210297 C                   eval      ktrst = 003
0095002104210297 C                   eval      ksub# = 001
0096002104210297 C                   eval      kacct = 2786
0097000204040291  *
0098002104210291  * Main Line - MCOV looking for Lincoln DEN plans
0099002104210297 C     mcvky         setll     mcovc16                            21
0100000812040296 C                   dou       *in21 = '1'
0101002104210297 C     mcvky         reade     mcovc16                                21
0102002104210296 C                   If        *in21 = '0' and enrldt <> candt
0103002104210291  *      Get Plan MST rec
0104002104210297 C     plkey         chain     plnmst                             22
0105000204040296 C                   If        *in22 = '0'
0106002104210291  *      Chk for Lincoln Carrier
0107002104210296 C                   If        pcarr = 'AD1' or
0108002104210296 C                             pcarr = 'ALD' or
0109002104210296 C                             pcarr = 'GUD'
0110002104210291  *      Chk Codes file for Plan Type
0111002104210297 C     cdkey         chain     codes                              23
0112002104210296 C                   If        *in23 = '0' and ACTION = 'D'
0113000907020291  *
0114000907090291  *        Get member record
0115000907020297 C     mcssno        chain     member                             32
0116000907020296 C                   If        *in32 = '0'
0117000907020291  *
0118000907020291 C                   exsr      bldmbr
0119000907020291  *
0120000907020291  *        Look for dependents of member             7
0121000204040297 C     mcssno        setll     dcov                               33
0122000204040296 C                   dou       *in33 = '1'
0123000204040297 C     mcssno        reade     dcov                                   33
0124000501110296 C                   If        *in33 = '0' and pltrst = dvtrst and
0125002104210296 C                             plsub# = dvsub# and plplan = dvplan
0126000206040291  *
0127002104210296 C                   If        ccandt = denrdt
0128002104210296 C                   iter
0129002104210297 C                   endif                                                  ccandt = 0
0130000204040291  *
0131000204040291 C                   exsr      blddep
0132000906010291  *
0133002104210297 C*****              endif                                                  ccandt = 0
0134002104210297 C****               endif                                                  ccandt = 0
0135000906010291  *
0136002005290297 C                   endif                                                  ccandt = 0
0137000906010291  *
0138000906010297 C                   enddo                                                  *in33 = '1'
0139000906010291  *
0140000204040297 C                   endif                                                  *in32 = '0'
0141000906010291  *
0142002005290297 C                   endif                                                  *in32 = '0'
0143002005290291  *
0144000204040297 C                   endif                                                  candt = 0
0145002104210291  *
0146000204040297 C                   endif                                                  *in31 = '0'
0147002104210291  *
0148002104210297 C                   endif                                                  *in22 = '0'
0149002104210291  *
0150000204020297 C                   enddo                                                  *in31 = '1'
0151000204020291  *
0152000811030291  *
0153000811030297 C                   movel     '1'           *inlr
0154000811030297 C                   return
0155000204020107  ********************************************************************************
0156000204020107  *
0157000204020107  *     BLDMBR - Build Member record
0158000204020107  *
0159000204020107  ********************************************************************************
016000020402     C     bldmbr        begsr
0161002104220107  *  If Mbr rec already exists - update eff/term date
016200210422     C                   movel     mbssno        ssna
016300210422     C                   eval      per# = 0
016400210422     C                   movel(P)  mfname        kfnam
0165002104260107  *  Set Covtyp - Tier
016600210426     C                   If        mcovtp = 'TIN'
016700210426     C                   eval      tier = '1'
016800210426     C                   else
016900210426     C                   If        mcovtp = 'THW'
017000210426     C                   eval      tier = '2'
017100210426     C                   else
017200210426     C                   If        mcovtp = 'TFA'
017300210426     C                   eval      tier = '4'
017400210426     C                   else
017500210426     C                   eval      tier = '3'
017600210426     C                   endif
017700210426     C                   endif
017800210426     C                   endif
0179002104260107  *
018000210422     C     linky         chain     lindtll                            61
018100210422     C                   if        *IN61 = '0'
0182002104220107  *
018300210422     C                   if        candt = 0 or candt > llidtmdt
018400210422     C                   eval      llidtmdt = candt
018500210422     C                   endif
0186002005280107  *
018700210422     C                   if        enrldt < llidefdt
018800210422     C                   eval      llidefdt = enrldt
018900210422     C                   endif
0190002104260107  *
019100210426     C                   if        enrldt < llidefdt
019200210426     C                   eval      llidefdt = enrldt
019300210426     C                   endif
0194002104220107  *
019500210422     C                   update    lindr
019600210422     C                   leavesr
0197002104220107  *
019800210422     C                   endif
0199002104220107  *
0200002104220107  *
020100210421     C                   clear                   lindtlr
0202002005280107  *  Set Default Values
020300210421     C                   eval      lidper# = 0
020400210421     C                   eval      per# = 0
020500210421     C                   eval      lidtyp = 'M'
020600210421     C                   eval      lidrel = 'M'
0207002005280107  *    Participant Values
020800210421     C                   movel     mbssno        lidssn
020900210421     C                   eval      lidefdt = enrldt
021000210421     C                   eval      lidtmdt = candt
021100200528      *
021200210421     C                   movel     mlname        lidlnam
021300210421     C                   movel     mfname        lidfnam
021400210421     C                   move      mmi           lidmi
021500210421     C                   eval      liddob = birth
021600210421     C                   movel     sex           lidsex
021700200528      *
021800210421     C                   MOVEL(P)  addr1         lidadd1
021900210421     C                   movel     addr2         lidadd2
0220002104210107  *     Use adr2 if adr1 is blank
0221002104210296 C                   If        lidadd1 = *blanks and lidadd2 <> *blanks
022200210421     C                   movel(P)  lidadd2       lidadd1
022300210421     C                   movel     *blanks       lidadd2
022400200528     C                   endif                                                  *in62 = '0'
0225002005290107  *
022600210421     C                   movel     city          lidcity
022700210421     C                   move      state         lidst
022800210421     C                   movel     zip           lidzip
022900200529      *
023000210421     C                   eval      liddoh = empdt
023100210421     C                   eval      lidpln# = mcplan
023200200529      *
023300210421     C                   write     lindtlr
0234000907010107  *
023500090701     C                   endsr
0236000204150107  ********************************************************************************
0237000907010107  *
0238000204040107  *     BLDDEP - Build Dependent Record
0239000907010107  *
0240000204040107  ********************************************************************************
024100090701     C     blddep        begsr
0242000907010291  *        Get Dependent record
0243000907010297 C     depky         chain     depndc                             42
0244000907010296 C                   If        *in42 = '0' and
0245000812040296 C                             (ccandt = 0 or ccandt > denrdt)
024600210422     C                   eval      per# = per# + 1
0247002104220107  *  If Dep rec already exists - update eff/term date
024800210422     C                   movel     mbssno        ssna
024900210422     C                   movel(P)  dfname        kfnam
025000210422     C     linky         chain     lindtll                            61
025100210422     C                   if        *IN61 = '0'
0252002104220107  *
025300210422     C                   if        ccandt = 0 or ccandt > llidtmdt
025400210422     C                   eval      llidtmdt = candt
025500210422     C                   endif
0256002104220107  *
025700210422     C                   if        denrdt < llidefdt
025800210422     C                   eval      llidefdt = denrdt
025900210422     C                   endif
0260002104220107  *
026100210422     C                   update    lindr
026200210422     C                   leavesr
0263002104220107  *
026400210422     C                   endif
0265002104220107  *
0266002104220107  *
0267002005290107  *     Dependent Values
0268000812040291  *
0269002104210107  *  Set Default Values
027000210421     C                   eval      lidper# = per#
027100210421     C                   eval      lidtyp = 'D'
027200210421     C                   eval      lidrel = 'M'
0273002104210107  *    Participant Values
027400210421     C                   movel     mbssno        lidssn
0275002104210107  *    Dep Values
027600020404     C                   if        dlname = 'SAME'
027700210421     C                   movel     mlname        lidlnam
027800020404     C                   else
027900210421     C                   movel     dlname        lidlnam
028000020404     C                   endif
0281000204040107  *
028200210421     C                   movel     dfname        lidfnam
028300210421     C                   move      dmi           lidmi
0284000204040107  *
028500200529     C                   if        daddr1 <> 'SAME'
028600210421     C                   movel     daddr1        lidadd1
028700210421     C                   movel     daddr2        lidadd2
028800210421     C                   movel     dcity         lidcity
028900210421     C                   move      dstate        lidst
029000210421     C                   movel     dzip          lidzip
029100090710     C                   endif
0292002005290107  *
029300210421     C                   move      dsex          lidsex
029400210421     C                   eval      liddob = dbirth
029500210421     C                   eval      lidefdt = denrdt
029600210421     C                   eval      lidtmdt = ccandt
029700210421      *
029800210421     C                   movel     depss#        lidpssn
0299000907100107  *
030000210421     C                   eval      lidrel = ' '
030100200529     C                   if        drelcd = 'RWI' or drelcd = 'RHU'
030200210421     C                   eval      lidrel = 'S'
030300090612     C                   else                                                   *in62 = '0'
030400200529     C                   if        drelcd = 'RDA' or drelcd = 'RSO'
030500210421     C                   eval      lidrel = 'C'
030600090612     C                   endif                                                  *in62 = '0'
030700090612     C                   endif                                                  *in62 = '0'
0308000906120107  *
030900210421     C                   write     lindtlr
0310002005290107  *
031100200529     C                   endif                                                  *in62 = '0'
0312002005290107  *
031300020404     C                   endsr
031400020402     C*
