0001000204020002  **************************************************************************
000200020402      * DW250      Group Benefit Services
000300020402      *            WRITTEN BY - R.L.J.
000400020402      *            DATE - 04/2002
000500020402      *  DESCRIPTION - Build file opf current Express Scripts
000600020402      *                Eligibility.
0007000204020002  **************************************************************************
0008000204020015  *  Change Log:
000900020402      *  RLJ 04/02/2002 New Program (replaced DW150/1 series)
001000030327      *  RLJ 03/27/2003 If ADDR1 is bl and ADDR2 is not - use ADDR2
001100050929      *  RLJ 09/29/2005 Allow eff date = term date. Report on term dates up
001200050929      *                 to 90 days old.
001300020402      *                                                                *
0014009102150018 F******************************************************************
0015000501110019 FPLNMSTN1  IF   E           K DISK
001600020403     FMCOVXX    IF   E           K DISK
001700020404     FMEMBER    IF   E           K DISK
001800020404     FGRAT24    IF   E           K DISK
001900020404     FDCOV      IF   E           K DISK
002000020404     FDEPNDC    IF   E           K DISK
0021000509260020 FEGCUR2L   UF A E           K DISK
0022000204020025  *
0023009102150250 D                 DS
0024000204030251 D  dseq                          2S 0 INZ(0)
0025000204030251 D  cutoff                         D   DATFMT(*ISO)
0026000204030251 D  cutofn                        8S 0
0027000204150251 D  updt                          1A
002800020402      *
0029000204150251 D  ekmid#                             LIKE(ecmid#)
0030000204150251 D  eksfx#                             LIKE(ecsfx#)
0031000508190251 D  eklnme                             LIKE(eclnme)
0032000508190251 D  ekfnme                             LIKE(ecfnme)
0033000508190251 D  ekbrdt                             LIKE(ecbrdt)
0034000508190251 D  ekgrp#                             LIKE(ecgrp#)
0035000508190251 D  ekf002                             LIKE(ecf002)
0036000508190251 D  todaa                              LIKE(frmdat)
0037000207230251 D  date9                              LIKE(frmdat)
003800020415      *
003900020415     C     eckey         klist
004000020415     C                   kfld                    ekmid#
004100020415     C                   kfld                    eksfx#
004200020415     C                   kfld                    eklnme
004300020415     C                   kfld                    ekfnme
004400021029     C                   kfld                    ekbrdt
004500020620     C                   kfld                    ekgrp#
004600020415      *
004700020613     C     grkey         klist
004800050111     C                   kfld                    pltrst
004900050111     C                   kfld                    plsub#
005000050111     C                   kfld                    plplan
005100020723     C                   kfld                    date9
005200041228      *
005300041228     C     mcvky         klist
005400050111     C                   kfld                    pltrst
005500050111     C                   kfld                    plsub#
005600050111     C                   kfld                    plplan
005700020402      *
005800020404     C     depky         klist
005900020402     C                   kfld                    mbssno
006000020404     C                   kfld                    dseq#
0061000206130291  *   Preprocessing
0062000206130297 C                   movel     UDATE         cutoff
0063000206130297 C                   movel     cutoff        todaa
0064000207230297 C                   z-add     99999999      date9
0065000206130291  * Determine Term date cutoff - 1 year ago
0066000509290297 C     cutoff        subdur    90:*D         cutoff
0067000204030297 C                   movel     cutoff        cutofn
006800020402      *
0069000204040291  *
0070000501110291  * Main Line - Loop thru plan master
0071000501110297 C     'ESI'         setll     plnmstn1                           21
0072000501110296 C                   dou       *in21 = '1'
0073000501110297 C                   read      plnmstn1                               21
0074000501110296 C                   If        *in21 = '0' and pldltd = 'A' and
0075000501110296 C                             (pcarr = 'ESI' or pcarr = 'EXP' or
0076000501110296 C                             pcarr = 'EX2')
0077000501110291  *     Bypass GBS Trust, sub# - ESI plan
0078000501110296 C                   If        pltrst <> 550 or plsub# <> 1
0079000501110296 C                   iter
0080000501110296 C                   endif
0081000501110291  *
0082000412280291  *     Using GBS info - Get GRATE record
0083000206130297 C     grkey         setll     grat24                             22
0084000206130297 C                   readp     grat24                                 22
0085000204040296 C                   If        *in22 = '0'
0086000207230291  ****** DEBUG SHIT
0087000207240296 C*********          If        GROUP# = '7200           '
0088000207240296 C**********         movel     GROUP#        group#
0089000207240296 C*******************endif
0090000207230291  *
0091000204030291  *        Loop thru mcov file using T,S,P
0092000204030297 C     mcvky         setll     mcovxx                             31
0093000204020296 C                   dou       *in31 = '1'
0094000204030297 C     mcvky         reade     mcovxx                                 31
0095000501110296 C                   If        *in31 = '0' and pltrst = mctrst and
0096000501110296 C                             plsub# = mcsub# and plplan = mcplan and
0097000211040296 C                             (candt = 0 or candt > enrldt)
0098000204030291  *
0099000204030296 C                   If        candt = 0 or candt > cutofn
0100000204030291  *
0101000204030291  *        Get member record
0102000204030297 C     mcssno        chain     member                             32
0103000204030296 C                   If        *in32 = '0'
0104000204020291  *
0105000204020291 C                   exsr      bldmbr
0106000204040291  *
0107000501110291  *        Look for dependents of member             7
0108000204040297 C     mcssno        setll     dcov                               33
0109000204040296 C                   dou       *in33 = '1'
0110000204040297 C     mcssno        reade     dcov                                   33
0111000501110296 C                   If        *in33 = '0' and pltrst = dvtrst and
0112000501110296 C                             plsub# = dvsub# and plplan = dvplan
0113000206040291  *
0114000206040296 C                   If        ccandt = 0 or ccandt > cutofn
0115000204040291  *
0116000204040291 C                   exsr      blddep
0117000206040291  *
0118000206040297 C                   endif
0119000204040291  *
0120000204040297 C                   endif
0121000204040291  *
0122000204040297 C                   enddo
0123000204040291  *
0124000204040297 C                   endif
0125000204030291  *
0126000204040297 C                   endif
0127000204040297 C                   endif
0128000204020297 C                   enddo
0129000204020291  *
0130000204040297 C                   endif
0131000204020291  *
0132000501110297 C                   endif
0133000501110296 C                   If        pcarr > 'EX2'
0134000501110296 C                   leave
0135000501110297 C                   endif
0136000501110297 C                   enddo
0137000501110291  *
0138000204020297 C                   movel     '1'           *inlr
0139000204020297 C                   return
0140000204020107  **************************************************************************
0141000204020107  *
0142000204020107  *     BLDMBR - Build Member record
0143000204020107  *
0144000204020107  **************************************************************************
014500020402     C     bldmbr        begsr
0146000204150107  *      First see if member record exists
014700020415     C                   movel     mbssno        ekmid#
014800020415     C                   z-add     0             eksfx#
014900020415     C                   movel     mlname        eklnme
015000020415     C                   movel     mfname        ekfnme
015100021029     C                   eval      ekbrdt = birth
015200020620     C                   movel     group#        ekgrp#
015300020620     C                   move      mcovtp        ekf002
0154000509260297 C     eckey         chain     egcur2l                            62
0155000204150296 C                   If        *in62 = '0'
0156000204150291  *         Set effective and term dates
015700020415     C                   movel     ' '           updt
0158000204150296 C                   If        enrldt < ecefdt
015900020415     C                   z-add     enrldt        ecefdt
016000020415     C                   movel     'Y'           updt
016100020415     C                   endif
0162000206200291  *         Set term date - if any term date = 0 => keep it
0163000206200296 C                   If        ectfdt <> 0
0164000204150296 C                   If        candt > ectfdt or
0165000204150296 C                             candt = 0
016600020415     C                   z-add     candt         ectfdt
016700020415     C                   movel     'Y'           updt
016800020415     C                   endif
016900020620     C                   endif
0170000206200291  *
0171000204150296 C                   If        updt = 'Y'
017200050926     C                   update    egcur2r
017300020415     C                   endif
0174000204150291  *         If member doesn't exist - build record
017500020415     C                   else
017600020402     C                   movel     mbssno        ecmid#
017700050926     C                   movel     mbssno        ecaltid
017800020402     C                   z-add     0             ecsfx#
017900020402     C                   movel     mlname        eclnme
018000020402     C                   movel     mfname        ecfnme
018100020402     C                   move      mmi           ecmi
018200020402     C                   movel     addr1         ecadr1
018300020402     C                   movel     addr2         ecadr2
0184000303270107  *     Use adr2 if adr1 is blank - Per ESI 3/27/03
0185000303270296 C                   If        ecadr1 = *blanks and ecadr2 <> *blanks
018600030327     C                   movel(P)  ecadr2        ecadr1
018700030327     C                   movel     *blanks       ecadr2
018800030327     C                   endif
0189000303270107  *
019000020402     C                   movel     city          eccity
019100020402     C                   move      state         ecst
019200020402     C                   z-add     zip           eczip
019300020402     C                   z-add     birth         ecbrdt
019400020402     C                   move      sex           ecgndr
019500020408     C                   z-add     enrldt        ecefdt
019600020408     C                   z-add     candt         ectfdt
019700020404     C                   movel     group#        ecgrp#
019800020405     C                   move      mcovtp        ecf002
019900050926     C                   write     egcur2r
0200000211040107  *
020100020415     C                   endif
0202000204150107  *
020300020415     C                   endsr
0204000204150107  **************************************************************************
0205000204040107  *
0206000204040107  *     BLDDEP - Build Dependent Record
0207000204040107  *
0208000204040107  **************************************************************************
020900020404     C     blddep        begsr
0210000204040291  *        Get Dependent record
0211000204040297 C     depky         chain     depndc                             42
0212000211040296 C                   If        *in42 = '0' and
0213000211040296 C                             (ccandt = 0 or ccandt > denrdt)
0214000204040291  *
0215000204150107  *      First see if depend record exists
021600020415     C                   movel     mbssno        ekmid#
021700020415     C                   z-add     99            eksfx#
021800020415     C                   movel     mlname        eklnme
0219000204150107  *
022000020415     C                   if        dlname = 'SAME'
022100020415     C                   movel     mlname        eklnme
022200020415     C                   else
022300020415     C                   movel     dlname        eklnme
022400020415     C                   endif
0225000204150107  *
022600020415     C                   movel     dfname        ekfnme
022700021029     C                   eval      ekbrdt = dbirth
0228000509260297 C     eckey         chain     egcur2l                            62
0229000204150296 C                   If        *in62 = '0'
0230000204150291  *         Set effective and term dates
023100020415     C                   movel     ' '           updt
0232000204150296 C                   If        denrdt < ecefdt
023300020415     C                   z-add     denrdt        ecefdt
023400020415     C                   movel     'Y'           updt
023500020415     C                   endif
0236000209260291  *         Set term date - if any term date = 0 => keep it
0237000209260296 C                   If        ectfdt <> 0
0238000204150296 C                   If        ccandt > ectfdt or
0239000204150296 C                             ccandt = 0
024000020415     C                   z-add     ccandt        ectfdt
024100020415     C                   movel     'Y'           updt
024200020415     C                   endif
024300020926     C                   endif
0244000204150296 C                   If        updt = 'Y'
024500050926     C                   update    egcur2r
024600020415     C                   endif
0247000204150291  *         If member doesn't exist - build record
024800020415     C                   else
024900020404     C                   movel     mbssno        ecmid#
025000050926     C                   movel     mbssno        ecaltid
025100020404     C                   z-add     99            ecsfx#
0252000204040107  *
025300020404     C                   if        dlname = 'SAME'
025400020404     C                   movel     mlname        eclnme
025500020404     C                   else
025600020404     C                   movel     dlname        eclnme
025700020404     C                   endif
0258000204040107  *
025900020404     C                   movel     dfname        ecfnme
026000020404     C                   move      dmi           ecmi
0261000204040107  *
026200020404     C                   if        daddr1 = 'SAME'
026300020404     C                   movel     addr1         ecadr1
026400020404     C                   movel     addr2         ecadr2
026500020404     C                   movel     city          eccity
026600020404     C                   move      state         ecst
026700020404     C                   z-add     zip           eczip
026800020404     C                   else
026900020404     C                   movel     daddr1        ecadr1
027000020404     C                   movel     daddr2        ecadr2
027100020404     C                   movel     dcity         eccity
027200020404     C                   move      dstate        ecst
027300020404     C                   z-add     dzip          eczip
027400020404     C                   endif
0275000204040107  *
027600020404     C                   z-add     dbirth        ecbrdt
027700020404     C                   move      dsex          ecgndr
027800020404     C                   z-add     denrdt        ecefdt
027900020404     C                   z-add     ccandt        ectfdt
028000020404     C                   movel     group#        ecgrp#
028100020405     C                   move      mcovtp        ecf002
028200050926     C                   write     egcur2r
0283000204150107  *
028400020415     C                   endif
0285000204040291  *
0286000204040297 C                   endif
028700020404     C                   endsr
028800020402     C*
