0001000204020002  *****************************************************************************
000200211110      * EBSBLDDP   Group Benefit Services                                         *
000300240130      *            WRITTEN BY - R.L.J.                                            *
000400240130      *            DATE - 08/2021                                                 *
000500240130      *  DESCRIPTION - Build file of current EBS Eligibility                      *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800240130      *  12/06/2021 rlj Set FB Pkg name to AdvantageA+SEC if plan desc
000900240130      *                 contains '+SEC'.
0010002108050018  ******************************************************************
0011002108180019 F***EBSXREFP  IP   E           K DISK
0012002108190019 FPLNMSTN1  IF   E           K DISK    RENAME(PLNMSR:PLN1MSR)
0013002108190020 F                                     PREFIX(L)
001400210819     FMEMBER    IF   E           K DISK
001500210819     FMCOV42    IF   E           K DISK    RENAME(MCOVR:MCOVR1)
0016002108190020 F                                     PREFIX(L)
001700210805     FMCOVC18   IF   E           K DISK
001800210819     FGRAT25    IF   E           K DISK
001900210902     FCFS100P   IF   E           K DISK
002000191202     FDEPNDC    IF   E           K DISK
002100210805     FDCOV1     IF   E           K DISK
002200210805     FPLNMST    IF   E           K DISK
002300210805     FCODES     IF   E           K DISK
0024002108050020 FEBSDTLP   O    E             DISK
0025000809160025  *
002600210811      *
0027000809160250 D                 DS
0028000809160251 D  mcovtp                 1      3
0029001103310251 D   mcovtp2               2      3
0030001103310025  *
0031000903270250 D                 DS
0032002108050251 D  plncat                 1      3
0033002108050251 D   plc1                  1      1
0034002108050251 D   plc23                 2      3
0035002108050025  *
0036002108050250 D                 DS
0037002108050251 D  mbssno                 1      9  0
0038002108050251 D   ssnoa                 1      9
0039002108050251 D   ssn4                  6      9
0040002108050025  *
0041002108050250 D                 DS
0042002108050251 D  depss#                 1      9  0
0043002108050251 D   dsnoa                 1      9
0044002108050251 D   dssn4                 6      9
0045002108110025  *
0046001201040025  *
0047001201040250 D                 DS
0048002108050251 D  x                             2S 0 INZ(0)
0049002108110251 D  xm                            2S 0 INZ(0)
0050002108110251 D  xd                            2S 0 INZ(0)
0051002108110251 D  xv                            2S 0 INZ(0)
0052002108050251 D  seq#                          2S 0 INZ(0)
0053001201040251 D  dseq                          2S 0 INZ(0)
0054002108050251 D  date9                         8S 0 INZ(99999999)
0055001201040251 D  cutoff                         D   DATFMT(*ISO)
0056001201040251 D  cutofn                        8S 0
0057001201040251 D  day30                          D   DATFMT(*ISO)
0058000910120251 D  day30n                        8S 0
0059002108190251 D  day90                          D   DATFMT(*ISO)
0060002108190251 D  day90n                        8S 0
0061002108110251 D  medc                          1A
0062002108110251 D  denc                          1A
0063002108110251 D  visc                          1A
0064002108110251 D  updt                          1A
0065001201040251 D  rate8                         6S 0
0066001201040251 D  planq                         1A
0067001201040251 D  plnkey                        3A
0068002108190251 D  egrp#                        12A
0069002108190251 D  epkg                         20A
0071002108190251 D  menr                          8S 0
0072002108190251 D  mtrm                          8S 0
007300120104      *
0074002108190251 D  svcovt                             LIKE(ebcovt)
0075002108190251 D  todaa                              LIKE(termdt)
007600120127      *
007700210805     C     codky         klist
007800210805     C                   kfld                    plc1
007900210805     C                   kfld                    plc23
008000210805      *
008100210902     C     cf1ky         klist
008200210902     C                   kfld                    mbssno
008300210902     C                   kfld                    seq#
008400210902      *
008500210902     C     cf1kyd        klist
008600210902     C                   kfld                    mbssno
008700210902     C                   kfld                    dpseq#
008800210902      *
008900210902     C     dcvky         klist
009000210902     C                   kfld                    dssno
009100210902     C                   kfld                    dpseq#
009200161010      *
009300161010     C     mcvky         klist
009400210805     C                   kfld                    mbtrst
009500210805     C                   kfld                    mbsub#
009600210805     C                   kfld                    mbacct
009700210805     C                   kfld                    mbssno
009800210805     C                   kfld                    date9
009900210819      *
010000210819     C     mcvky42       klist
010100210819     C                   kfld                    grtrst
010200210819     C                   kfld                    grsub#
010300210819     C                   kfld                    grplan
010400210805      *
010500210805     C     plnkym        klist
010600210805     C                   kfld                    mctrst
010700210805     C                   kfld                    mcsub#
010800210805     C                   kfld                    mcplan
010900210805      *
011000210805     C     plnkyd        klist
011100210805     C                   kfld                    mctrst
011200210805     C                   kfld                    mcsub#
011300210805     C                   kfld                    dvplan
011400210819      *
011500210819     C     grkey         klist
011600210819     C                   kfld                    lpltrst
011700210819     C                   kfld                    lplsub#
011800210819     C                   kfld                    lplplan
011900210819     C                   kfld                    date9
012000191202      *
0121002108170291  *    Preprocessing
0122002108170297 C                   movel     UDATE         cutoff
0123002108170297 C                   movel     cutoff        todaa
0124002108170291  * Determine Term date cutoff - 1 year ago
0125002108170297 C     cutoff        subdur    365:*D        cutoff
0126002108170297 C                   movel     cutoff        cutofn
012700210817      *
0128002108190297 C                   movel     UDATE         day90
0129002108170291  *
0130002108190297 C     day90         adddur    90:*D         day90
0131002108190297 C                   movel     day90         day90n
0132002108170291  *
0133002108170291  * Main Line - Loop thru plan master
0134002108170291  *
0135002108170297 C     'FBS'         setll     plnmstn1                           21
0136002108240296 C                   dou       *in21 = '1'
0137002108240297 C     'FBS'         reade     plnmstn1                               21
0138002108240296 C                   If        *in21 = '0'
0139002108240291  *           Find Pkg Name
014000210824     C                   movel(P)  'AdvantageA'  epkg
014100210824     C     'POWER'       scan      lpdescr       X                        35
014200210824     C                   if        *IN35 = '1'
014300210824     C                   movel(P)  'POWER'       epkg
014400210824     C                   endif
0145002108240291  *
014600211206     C     '+SEC'        scan      lpdescr       X                        35
014700211206     C                   if        *IN35 = '1'
014800211206     C                   eval      epkg = 'AdvantageA+SEC      '
014900211206     C                   endif
0150002112060291  *
0151002108240291  *     Using GBS info - Get GRATE record
0152002108240297 C     grkey         setll     grat25                             22
0153002108240297 C                   read      grat25                                 22
0154002108240296 C                   If        *in22 = '0'
015500210824     C                   movel(P)  group#        egrp#
0156002108230291  *
0157002108240291  *        Loop thru mcov file using T,S,P
0158002108190297 C     mcvky42       setll     mcov42                             31
0159002108170296 C                   dou       *in31 = '1'
0160002108190297 C     mcvky42       reade     mcov42                                 31
0161002108190296 C                   If        *in31 = '0' and grtrst = lmctrst and
0162002108190296 C                             grsub# = lmcsub# and grplan = lmcplan and
0163002108230296 C                             (lcandt = 0 or lcandt > lenrldt)
0164002108170291  *
0165002108190296 C                   If        lcandt = 0 or lcandt > todaa
0166002108190296 C                   If        lenrldt < day90n
0167002108170291  *
016800210819     C                   eval      menr = lenrldt
0169002108230291  *          There s/b no term dates on file even if in the future
017000210823     C                   eval      mtrm = 0
0171002108190291  *
0172002108170291  *        Get member record
0173002108100291  *
0174002108190297 C     lmcssno       chain     MEMBER                             22
0175002108100296 C                   If        *in22 = '0'
0176002108100291  *
0177002111100296 C                   If        mbtrst <> 905 or mbsub# <> 1 or
0178002111100296 C                             mbacct <> 592
0179002111100291  *
0180002108100291 C                   exsr      bldmbr
0181002108100291  *
0182002108100291 C                   exsr      chkdep
0183002108100291  *
0184002108100291 C                   endif
0185002111100291  *
0186002111100291 C                   endif
0187002108190291 C                   endif
0188002108190291 C                   endif
0189002108190291  *
0190002108190291 C                   endif
0191002108100291  *
0192002108100291 C                   enddo
0193002108050291  *
0194002108050291 C                   endif
0195002108100291  *
0196002108190291 C                   endif
0197002108110291  *
0198002108190291 C                   enddo
0199002108190291  *
0200002108190291 C                   move      '1'           *inlr
0201002108190291 C                   return
0202002108050291  *
0203000204020107  ********************************************************************************
0204000807290107  *
0205000204020107  *     BLDMBR - Build Member record
0206000807290107  *
0207000204020107  ********************************************************************************
020800080728     C     bldmbr        begsr
0209002108050291  *
021000210812     C                   clear                   ebsdtlr
021100210819     C                   eval      ebsyst = 'FI'
021200210812     C                   eval      ebtrust = mbtrst
021300210817     C                   eval      ebsub = mbsub#
021400210817     C                   eval      ebacct = mbacct
0215002108120291  *
021600210817     C                   movel     mbssno        ebmid#
021700210817     C                   z-add     0             ebseq#
021800210810     C                   z-add     0             ebdssn
021900210817     C                   movel     mlname        eblnme
022000210817     C                   movel     mfname        ebfnme
0221002109020291  *          Longer Names ??
0222002109020297 C     cf1ky         chain     cfs100p                            29
0223002109020296 C                   If        *in29 = '0'
022400210902     C                   movel     cfslst        eblnme
022500210902     C                   movel     cfsfst        ebfnme
0226002109020291 C                   endif
0227002109020291  *
022800210817     C                   move      mmi           ebmi
022900210817     C                   movel     addr1         ebadr1
023000210817     C                   movel     addr2         ebadr2
023100210817     C                   movel     fill66        ebemail
0232002108170107  *
0233002108170296 C                   If        ebadr1 = *blanks and ebadr2 <> *blanks
023400210812     C                   movel(P)  ebadr2        ebadr1
023500210817     C                   movel     *blanks       ebadr2
023600080916     C                   endif                                                  *in62 = '0'
0237000809160107  *
023800210805     C                   movel     city          ebcity
023900210805     C                   move      state         ebst
024000210805     C                   z-add     zip           ebzip
024100210805     C                   eval      ebarea = area
024200210805     C                   eval      ebphn# = phone
024300210805     C                   z-add     birth         ebbrdt
024400210805     C                   movel     ssn4          ebssn4
0245002108050107  *
024600210819     C                   z-add     menr          ebefdt
024700210819     C                   z-add     mtrm          ebtmdt
0248002108050107  *
0249002108050291  *        Get plan/coverage data
0250002108050291  *
025100210819     C                   movel(P)  *blanks       svcovt
0252002108170297 C     mcvky         setgt     mcovc18                            31
0253002108170296 C                   dou       *in31 = '1'
0254002108170297 C                   readp     mcovc18                                31
0255002108170291  *       DEBUG SHIT
0256002111230296 C                   If        mcssno = 217705481 or
0257002108100296 C                             mcssno = 003686889
0258002108100296 C                   eval      mcssno = mcssno
0259002108130296 C                   endif
0260002108130291  *
0261002108130296 C                   If        *in31 = '1' or mcssno <> mbssno
0262002108130296 C                   leave
0263002108130296 C                   endif
0264002108130291  *
026500210819     C                   If        candt = enrldt or enrldt > day90n
0266002108050296 C                   iter
0267002108050296 C                   endif
0268002108050291  *
026900210805     C                   If        candt < todaa and candt <> 0
0270002108050296 C                   iter
0271002108050296 C                   endif
0272002108050291  *          Plan is Active - check type
0273002108050297 C     plnkym        chain     plnmst                             32
027400210805     C                   if        *in32 = '0'
0275002108050291  *
0276002108050297 C     codky         chain     codes                              33
027700210805     C                   if        *in33 = '0'
0278002108190291  *        MED Plan
027900210805     C                   if        action = 'M'
028000210805     C                   movel     plplan        ebmgpl
0281002108050291  *
028200210805     C                   movel(P)  'EE'          ebcovt
028300210805     C                   if        mcovtp <> 'TIN'
028400210805     C                   movel(P)  'Family'      ebcovt
028500210819     C                   endif
028600210819     C                   movel(P)  ebcovt        svcovt
0287002108050291  *
028800210812     C                   movel     pdescr        ebmpln
0289002108050291  *
029000210805     C                   else
0291002108190291  *        DEN Plan
029200210805     C                   if        action = 'D'
029300210805     C                   movel     plplan        ebdgpl
029400210819     C                   movel     pdescr        ebdpln
0295002108050291  *
029600210805     C                   else
0297002108190291  *        VIS Plan
029800210805     C                   if        action = 'V'
029900210805     C                   movel     plplan        ebvgpl
030000210819     C                   movel     pdescr        ebvpln
030100210805     C                   endif
0302002108050291  *
030300210805     C                   endif
030400210805     C                   endif
0305002108050291  *
0306002108050291  *
0307002108050296 C                   endif
0308002108050296 C                   endif
0309002108050291  *
031000210805     C                   If        ebmgpl <> *blanks and
031100210805     C                             ebdgpl <> *blanks and
031200210805     C                             ebvgpl <> *blanks
0313002108050296 C                   leave
0314002108050296 C                   endif
0315002108050291  *
0316002108050296 C                   enddo
0317002108050291  *
0318002108050291  *
031900210805     C                   If        ebmgpl = *blanks
0320002108050296 C                   movel     'Waived'      ebmpln
0321002108050296 C                   endif
0322002108050291  *
032300210805     C                   If        ebdgpl = *blanks
0324002108050296 C                   movel     'Waived'      ebdpln
0325002108050296 C                   endif
0326002108050291  *
032700210805     C                   If        ebvgpl = *blanks
0328002108050296 C                   movel     'Waived'      ebvpln
0329002108050296 C                   endif
0330001610310291  *
0331002108190296 C                   movel     egrp#         ebegrp
0332002108190296 C                   movel     epkg          ebepkg
033300210819     C                   eval      ebrect = 'A'
0334002108050291  *
0335002108050296 C                   write     ebsdtlr
0336002108050291  *
033700161031     C                   endsr
0338002108050107  ********************************************************************************
0339002108050107  *
0340002108050107  *     CHKDEP - Check for Dependents
0341002108050107  *
0342002108050107  ********************************************************************************
034300210805     C     chkdep        begsr
0344002108050291  *        Get Dependent record
0345002108050291  *
0346002108050297 C     mbssno        setll     depndc                             41
0347002108050296 C                   dou       *in41 = '1'
0348002108050297 C     mbssno        reade     depndc                                 41
0349002108050296 C                   If        *in41 = '0'
0350002108050291  *
0351002111230296 C                   If        dpdltd = 'C'
0352002111230296 C                   iter
0353002111230296 C                   endif
0354002111230291  *
0355002108050107  *     Dependent Values
0356002108050291  *
035700210805     C                   clear                   ebsdtlr
035800210819     C                   eval      ebsyst = 'FI'
035900210805     C                   eval      ebtrust = mbtrst
036000210805     C                   eval      ebsub = mbsub#
036100210805     C                   eval      ebacct = mbacct
0362002108050291  *
036300210805     C                   movel     mbssno        ebmid#
036400210805     C                   z-add     dpseq#        ebseq#
036500210805     C                   z-add     depss#        ebdssn
0366002108050291  *
036700210805     C                   movel     ssn4          ebssn4
0368002108050296 C                   If        depss# <> 0
036900210805     C                   movel     dssn4         ebssn4
037000210805     C                   endif
0371002108050107  *
037200210805     C                   movel     dlname        eblnme
037300210805     C                   movel     dfname        ebfnme
0374002109020291  *          Longer Names ??
0375002109020297 C     cf1kyd        chain     cfs100p                            29
0376002109020296 C                   If        *in29 = '0'
037700210902     C                   movel     cfslst        eblnme
037800210902     C                   movel     cfsfst        ebfnme
0379002109020291 C                   endif
0380002109020291  *
038100210805     C                   move      dmi           ebmi
038200210805     C                   movel     daddr1        ebadr1
038300210805     C                   movel     daddr2        ebadr2
0384002108050107  *
0385002108050296 C                   If        ebadr1 = *blanks and ebadr2 <> *blanks
038600210805     C                   movel(P)  ebadr2        ebadr1
038700210805     C                   movel     *blanks       ebadr2
038800210805     C                   endif                                                  *in62 = '0'
0389002108050107  *
039000210805     C                   movel     dcity         ebcity
039100210805     C                   move      dstate        ebst
039200210805     C                   z-add     dzip          ebzip
039300210805     C                   eval      ebarea = darea
039400210805     C                   eval      ebphn# = dphone
039500210805     C                   z-add     dbirth        ebbrdt
0396002108050107  *
039700210819     C                   movel     menr          ebefdt
039800210819     C                   movel     mtrm          ebtmdt
0399002108050107  *
040000210805     C                   movel(P)  dpseq#        ebseq#
0401002108050107  *
040200210805     C                   movel     depss#        ebdssn
040300210805      *
040400210805     C                   eval      ebrelcd = drelcd
0405002108190107  *
040600210819     C                   eval      ebrect = 'S'
0407002108190296 C                   If        drelcd <> 'RHU' and drelcd <> 'RWI'
040800210819     C                   eval      ebrect = 'D'
040900210819     C                   endif                                                  *in62 = '0'
0410002108190107  *
0411002108050107  *
0412002108050291  *        Get plan/coverage data
0413002108050291  *
0414002108050297 C     dcvky         setll     dcov1                              45
0415002108050296 C                   dou       *in45 = '1'
0416002108050297 C     dcvky         reade     dcov1                                  45
0417002108050296 C                   if        *in45 = '1' or dssno <> ssno or
0418002108050296 C                             dseq# <> dpseq#
0419002108050296 C                   leave
0420002108050296 C                   endif
0421002108050291  *
042200210819     C                   If        ccandt = denrdt or denrdt > day90n
0423002108050296 C                   iter
0424002108050296 C                   endif
0425002108050291  *
042600210805     C                   If        ccandt < todaa and ccandt <> 0
0427002108050296 C                   iter
0428002108050296 C                   endif
0429002108050291  *          Plan is Active - check type
0430002108050297 C     plnkyd        chain     plnmst                             32
043100210805     C                   if        *in32 = '0'
0432002108050291  *
0433002108050297 C     codky         chain     codes                              33
043400210805     C                   if        *in33 = '0'
0435002108050291  *
043600210805     C                   if        action = 'M'
043700210805     C                   movel     plplan        ebmgpl
0438002108050291  *
043900210812     C                   movel     pdescr        ebmpln
0440002108120291  *
044100210805     C                   else
0442002108050291  *
044300210805     C                   if        action = 'D'
044400210805     C                   movel     plplan        ebdgpl
044500210819     C                   movel     pdescr        ebdpln
0446002108050291  *
044700210805     C                   else
0448002108050291  *
044900210805     C                   if        action = 'V'
045000210805     C                   movel     plplan        ebvgpl
045100210819     C                   movel     pdescr        ebvpln
045200210805     C                   endif
0453002108050291  *
045400210805     C                   endif
045500210805     C                   endif
0456002108050291  *
0457002108050291  *
0458002108050296 C                   endif
0459002108050296 C                   endif
0460002108050291  *
046100210805     C                   If        ebmgpl <> *blanks and
046200210805     C                             ebdgpl <> *blanks and
046300210805     C                             ebvgpl <> *blanks
0464002108050296 C                   leave
0465002108050296 C                   endif
0466002108050291  *
0467002108050296 C                   enddo
0468002108050291  *
0469002108050291  *
047000210805     C                   If        ebmgpl = *blanks
0471002108050296 C                   movel     'Waived'      ebmpln
0472002108050296 C                   endif
0473002108050291  *
047400210805     C                   If        ebdgpl = *blanks
0475002108050296 C                   movel     'Waived'      ebdpln
0476002108050296 C                   endif
0477002108050291  *
047800210805     C                   If        ebvgpl = *blanks
0479002108050296 C                   movel     'Waived'      ebvpln
0480002108050296 C                   endif
0481002108050291  *
0482002108190296 C                   movel     egrp#         ebegrp
0483002108190296 C                   movel     epkg          ebepkg
0484002108190296 C                   movel     svcovt        ebcovt
0485002108050291  *
0486002108050296 C                   write     ebsdtlr
0487002108050107  *
048800210805     C                   endif                                                  *in62 = '0'
0489002108050107  *
049000210805     C                   enddo                                                  *in62 = '0'
0491002108050107  *
049200210805     C                   endsr
049300210811      *
