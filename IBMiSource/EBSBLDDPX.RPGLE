0001000204020002  *****************************************************************************
000200210804      * EBSBDDP    Group Benefit Services                                         *
000300110908      *            WRITTEN BY - R.L.J.                                            *
000400210804      *            DATE - 08/2021                                                 *
000500210804      *  DESCRIPTION - Build file of current EBS Eligibility                      *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800210804      *  mm/dd/yyyy xxx
0009002108050018  ******************************************************************
0010002108050019 FEBSXREFP  IP   E           K DISK
001100210805     FMCOVC18   IF   E           K DISK
001200210805     FMEMAC#1   IF   E           K DISK
001300191202     FDEPNDC    IF   E           K DISK
001400210805     FDCOV1     IF   E           K DISK
001500191202     FACCMST    IF   E           K DISK
001600210805     FPLNMST    IF   E           K DISK
001700210805     FCODES     IF   E           K DISK
0018002108050020 FEBSDTLP   O    E             DISK
0019000809160025  *
0020002108110025  *
002100210811     D PCARRAY       E DS                  EXTNAME(PARTCOVG)
002200210811     D  P@COV                 57    104A   Dim(16)
002300210811     D  P@PLAN               105    424A   DIM(16)
002400210811     D  P@ENR                425    472A   DIM(16)
002500210811    * *
002600210811     D DCARRAY       E DS                  EXTNAME(DEPNCOVGL2)
002700210811     D  D@COV                 59    106A   DIM(16)
002800210811     D  D@PLN                107    426A   DIM(16)
002900210811     D  D@ENR                427    474A   DIM(16)
0030002108110025  *
003100210811      *
0032000809160250 D                 DS
0033000809160251 D  mcovtp                 1      3
0034001103310251 D   mcovtp2               2      3
0035001103310025  *
0036000903270250 D                 DS
0037002108050251 D  plncat                 1      3
0038002108050251 D   plc1                  1      1
0039002108050251 D   plc23                 2      3
0040002108050025  *
0041002108050250 D                 DS
0042002108050251 D  mbssno                 1      9  0
0043002108050251 D   ssnoa                 1      9
0044002108050251 D   ssn4                  6      9
0045002108050025  *
0046002108050250 D                 DS
0047002108050251 D  depss#                 1      9  0
0048002108050251 D   dsnoa                 1      9
0049002108050251 D   dssn4                 6      9
0050002108110025  *
0051001201040025  *
0052001201040250 D                 DS
0053002108050251 D  x                             2S 0 INZ(0)
0054002108110251 D  xm                            2S 0 INZ(0)
0055002108110251 D  xd                            2S 0 INZ(0)
0056002108110251 D  xv                            2S 0 INZ(0)
0057002108050251 D  seq#                          2S 0 INZ(0)
0058001201040251 D  dseq                          2S 0 INZ(0)
0059002108050251 D  date9                         8S 0 INZ(99999999)
0060001201040251 D  cutoff                         D   DATFMT(*ISO)
0061001201040251 D  cutofn                        8S 0
0062001201040251 D  day30                          D   DATFMT(*ISO)
0063000910120251 D  day30n                        8S 0
0064002108110251 D  medc                          1A
0065002108110251 D  denc                          1A
0066002108110251 D  visc                          1A
0067002108110251 D  updt                          1A
0068001201040251 D  rate8                         6S 0
0069001201040251 D  planq                         1A
0070001201040251 D  plnkey                        3A
0071001911120251 D  email                        65A
007200120104      *
0073002108050251 D  todaa                              LIKE(termdt)
007400120127      *
007500210805     C     codky         klist
007600210805     C                   kfld                    plc1
007700210805     C                   kfld                    plc23
007800210805      *
007900210805     C     dcvky         klist
008000210805     C                   kfld                    dssno
008100210805     C                   kfld                    dpseq#
008200161010      *
008300161010     C     mcvky         klist
008400210805     C                   kfld                    mbtrst
008500210805     C                   kfld                    mbsub#
008600210805     C                   kfld                    mbacct
008700210805     C                   kfld                    mbssno
008800210805     C                   kfld                    date9
008900210805      *
009000210805     C     plnkym        klist
009100210805     C                   kfld                    mctrst
009200210805     C                   kfld                    mcsub#
009300210805     C                   kfld                    mcplan
009400210805      *
009500210805     C     plnkyd        klist
009600210805     C                   kfld                    mctrst
009700210805     C                   kfld                    mcsub#
009800210805     C                   kfld                    dvplan
009900120123      *
010000120123     C     acckey        klist
010100210805     C                   kfld                    extrst
010200210805     C                   kfld                    exsub
010300210805     C                   kfld                    exacct
010400191202      *
0105002108050291  * Main Line
0106002108100291  *
0107002108100296 C                   If        exsyst = 'FI' and exaflg = 'Y'
0108002108110291  *  Process GBS data
0109002108110291  *    Make sure TSA matches up
0110002108050297 C     acckey        chain     accmst                             21
0111002108050296 C                   If        *in21 = '1'
0112002108050297 C                   eval      exsub = exsub
0113002108050296 C                   else
0114002108050291  *
0115002108050296 C                   If        exgnam <> acnam1
0116002108050297 C                   eval      exsub = exsub
0117002108050296 C                   endif
0118002108050291  *
0119002108050297 C     acckey        setll     MEMAC#1                            22
0120002108050296 C                   dou       *in22 = '1'
0121002108050297 C     acckey        reade     memac#1                                22
0122002108100296 C                   If        *in22 = '0'
0123002108100291  *
0124002108100291 C                   exsr      bldmbr
0125002108100291  *
0126002108100291 C                   exsr      chkdep
0127002108100291  *
0128002108100291 C                   endif
0129002108100291  *
0130002108100291 C                   enddo
0131002108050291  *
0132002108050291 C                   endif
0133002108100291  *
0134002108110291 C                   else
0135002108110291  *
0136002108110291 C                   endif
0137002108050291  *
0138000204020107  ********************************************************************************
0139000807290107  *
0140000204020107  *     BLDMBR - Build Member record
0141000807290107  *
0142000204020107  ********************************************************************************
014300080728     C     bldmbr        begsr
014400091002      *         If enroll is more than 30 days out - bypass
014500150320      *     Removed per instructions by WA 3/20/15
014600150320     C********           if        enrldt > day30n
014700150320     C****               leavesr
014800150320     C********           endif
0149002108050291  *
015000210812     C                   clear                   ebsdtlr
015100210812     C                   eval      ebsyst = exsyst
015200210812     C                   eval      ebtrust = mbtrst
015300210812     C                   eval      ebsub = mbsub#
015400210812     C                   eval      ebacct = mbacct
0155002108120291  *
015600210810     C                   movel     mbssno        ebmid#
015700210810     C                   z-add     0             ebseq#
015800210810     C                   z-add     0             ebdssn
015900210810     C                   movel     mlname        eblnme
016000210805     C                   movel     mfname        ebfnme
016100210812     C                   move      mmi           ebmi
016200210812     C                   movel     addr1         ebadr1
016300210812     C                   movel     addr2         ebadr2
016400210812     C                   movel     fill66        ebemail
0165002108120107  *
0166002108120296 C                   If        ebadr1 = *blanks and ebadr2 <> *blanks
016700210812     C                   movel(P)  ebadr2        ebadr1
016800210812     C                   movel     *blanks       ebadr2
016900080916     C                   endif                                                  *in62 = '0'
0170000809160107  *
017100210805     C                   movel     city          ebcity
017200210805     C                   move      state         ebst
017300210805     C                   z-add     zip           ebzip
017400210805     C                   eval      ebarea = area
017500210805     C                   eval      ebphn# = phone
017600210805     C                   z-add     birth         ebbrdt
017700210805     C                   movel     ssn4          ebssn4
0178002108050107  *
017900210805     C                   z-add     mbenrl        ebefdt
018000210805     C                   if        mbenrl = 0
018100210805     C                   z-add     empdt         ebefdt
018200210805     C                   endif                                                  *in62 = '0'
0183002108050107  *
018400210805     C                   z-add     termdt        ebtmdt
0185002108050107  *
0186002108050291  *        Get plan/coverage data
0187002108050291  *
0188002108100297 C     mcvky         setgt     mcovc18                            31
0189002108100296 C                   dou       *in31 = '1'
0190002108100297 C                   readp     mcovc18                                31
0191002108100291  *       DEBUG SHIT
0192002108100296 C                   If        mcssno = 003686889 or
0193002108100296 C                             mcssno = 003686889
0194002108100296 C                   eval      mcssno = mcssno
0195002108130296 C                   endif
0196002108130291  *
0197002108130296 C                   If        *in31 = '1' or mcssno <> mbssno
0198002108130296 C                   leave
0199002108130296 C                   endif
0200002108130291  *
020100210805     C                   If        candt = enrldt or enrldt > todaa
0202002108050296 C                   iter
0203002108050296 C                   endif
0204002108050291  *
020500210805     C                   If        candt < todaa and candt <> 0
0206002108050296 C                   iter
0207002108050296 C                   endif
0208002108050291  *          Plan is Active - check type
0209002108050297 C     plnkym        chain     plnmst                             32
021000210805     C                   if        *in32 = '0'
0211002108050291  *
0212002108050297 C     codky         chain     codes                              33
021300210805     C                   if        *in33 = '0'
0214002108050291  *
021500210805     C                   if        action = 'M'
021600210805     C                   movel     plplan        ebmgpl
0217002108050291  *
021800210805     C                   movel(P)  'EE'          ebcovt
021900210805     C                   if        mcovtp <> 'TIN'
022000210805     C                   movel(P)  'Family'      ebcovt
022100210805     C                   endif
0222002108050291  *
022300210812     C***  'PPO '        scan      pdescr        X                        35
022400210812     C***                if        *IN35 = '1'
022500210812     C                   movel     pdescr        ebmpln
0226002108050291  *
022700210805     C                   else
0228002108050291  *
022900210805     C                   if        action = 'D'
023000210805     C                   movel     plplan        ebdgpl
0231002108050291  *
023200210805     C     'PPO '        scan      pdescr        X                        35
023300210805     C                   if        *IN35 = '1'
023400210805     C                   movel     'PPO'         ebdpln
0235002108050291  *
023600210805     C                   else
023700210805     C     'HSA '        scan      pdescr        X                        35
023800210805     C                   if        *IN35 = '1'
023900210805     C                   movel     'HSA'         ebdpln
024000210805     C                   endif
024100210805     C                   endif
0242002108050291  *
024300210805     C                   else
0244002108050291  *
024500210805     C                   if        action = 'V'
024600210805     C                   movel     plplan        ebvgpl
024700210805     C                   movel     'Base Plan'   ebvpln
024800210805     C                   endif
0249002108050291  *
025000210805     C                   endif
025100210805     C                   endif
0252002108050291  *
0253002108050291  *
0254002108050296 C                   endif
0255002108050296 C                   endif
0256002108050291  *
025700210805     C                   If        ebmgpl <> *blanks and
025800210805     C                             ebdgpl <> *blanks and
025900210805     C                             ebvgpl <> *blanks
0260002108050296 C                   leave
0261002108050296 C                   endif
0262002108050291  *
0263002108050296 C                   enddo
0264002108050291  *
0265002108050291  *
026600210805     C                   If        ebmgpl = *blanks
0267002108050296 C                   movel     'Waived'      ebmpln
0268002108050296 C                   endif
0269002108050291  *
027000210805     C                   If        ebdgpl = *blanks
0271002108050296 C                   movel     'Waived'      ebdpln
0272002108050296 C                   endif
0273002108050291  *
027400210805     C                   If        ebvgpl = *blanks
0275002108050296 C                   movel     'Waived'      ebvpln
0276002108050296 C                   endif
0277001610310291  *
0278002108050296 C                   movel     exegrp        ebegrp
0279002108050296 C                   movel     exepkg        ebepkg
0280002108050291  *
0281002108050296 C                   write     ebsdtlr
0282002108050291  *
028300161031     C                   endsr
0284002108050107  ********************************************************************************
0285002108050107  *
0286002108050107  *     CHKDEP - Check for Dependents
0287002108050107  *
0288002108050107  ********************************************************************************
028900210805     C     chkdep        begsr
0290002108050291  *        Get Dependent record
0291002108050291  *
0292002108050297 C     mbssno        setll     depndc                             41
0293002108050296 C                   dou       *in41 = '1'
0294002108050297 C     mbssno        reade     depndc                                 41
0295002108050296 C                   If        *in41 = '0'
0296002108050291  *
0297002108050107  *     Dependent Values
0298002108050291  *
029900210805     C                   clear                   ebsdtlr
030000210805     C                   eval      ebtrust = mbtrst
030100210805     C                   eval      ebsub = mbsub#
030200210805     C                   eval      ebacct = mbacct
0303002108050291  *
030400210805     C                   movel     mbssno        ebmid#
030500210805     C                   z-add     dpseq#        ebseq#
030600210805     C                   z-add     depss#        ebdssn
0307002108050291  *
030800210805     C                   movel     ssn4          ebssn4
0309002108050296 C                   If        depss# <> 0
031000210805     C                   movel     dssn4         ebssn4
031100210805     C                   endif
0312002108050107  *
031300210805     C                   movel     dlname        eblnme
031400210805     C                   movel     dfname        ebfnme
031500210805     C                   move      dmi           ebmi
031600210805     C                   movel     daddr1        ebadr1
031700210805     C                   movel     daddr2        ebadr2
0318002108050107  *
0319002108050296 C                   If        ebadr1 = *blanks and ebadr2 <> *blanks
032000210805     C                   movel(P)  ebadr2        ebadr1
032100210805     C                   movel     *blanks       ebadr2
032200210805     C                   endif                                                  *in62 = '0'
0323002108050107  *
032400210805     C                   movel     dcity         ebcity
032500210805     C                   move      dstate        ebst
032600210805     C                   z-add     dzip          ebzip
032700210805     C                   eval      ebarea = darea
032800210805     C                   eval      ebphn# = dphone
032900210805     C                   z-add     dbirth        ebbrdt
0330002108050107  *
033100210805     C                   movel     denrdt        ebefdt
033200210805     C                   movel     ccandt        ebtmdt
0333002108050107  *
033400210805     C                   movel(P)  dpseq#        ebseq#
0335002108050107  *
033600210805     C                   movel     depss#        ebdssn
033700210805      *
033800210805     C                   eval      ebrelcd = drelcd
0339002108050107  *
0340002108050291  *        Get plan/coverage data
0341002108050291  *
0342002108050297 C     dcvky         setll     dcov1                              45
0343002108050296 C                   dou       *in45 = '1'
0344002108050297 C     dcvky         reade     dcov1                                  45
0345002108050296 C                   if        *in45 = '1' or dssno <> ssno or
0346002108050296 C                             dseq# <> dpseq#
0347002108050296 C                   leave
0348002108050296 C                   endif
0349002108050291  *
035000210805     C                   If        ccandt = denrdt or denrdt > todaa
0351002108050296 C                   iter
0352002108050296 C                   endif
0353002108050291  *
035400210805     C                   If        ccandt < todaa and ccandt <> 0
0355002108050296 C                   iter
0356002108050296 C                   endif
0357002108050291  *          Plan is Active - check type
0358002108050297 C     plnkyd        chain     plnmst                             32
035900210805     C                   if        *in32 = '0'
0360002108050291  *
0361002108050297 C     codky         chain     codes                              33
036200210805     C                   if        *in33 = '0'
0363002108050291  *
036400210805     C                   if        action = 'M'
036500210805     C                   movel     plplan        ebmgpl
0366002108050291  *
036700210812     C***  'PPO '        scan      pdescr        X                        35
036800210812     C**                 if        *IN35 = '1'
036900210812     C                   movel     pdescr        ebmpln
0370002108120291  *
037100210805     C                   else
0372002108050291  *
037300210805     C                   if        action = 'D'
037400210805     C                   movel     plplan        ebdgpl
0375002108050291  *
037600210805     C     'PPO '        scan      pdescr        X                        35
037700210805     C                   if        *IN35 = '1'
037800210805     C                   movel     'PPO'         ebdpln
0379002108050291  *
038000210805     C                   else
038100210805     C     'HSA '        scan      pdescr        X                        35
038200210805     C                   if        *IN35 = '1'
038300210805     C                   movel     'HSA'         ebdpln
038400210805     C                   endif
038500210805     C                   endif
0386002108050291  *
038700210805     C                   else
0388002108050291  *
038900210805     C                   if        action = 'V'
039000210805     C                   movel     plplan        ebvgpl
039100210805     C                   movel     'Base Plan'   ebvpln
039200210805     C                   endif
0393002108050291  *
039400210805     C                   endif
039500210805     C                   endif
0396002108050291  *
0397002108050291  *
0398002108050296 C                   endif
0399002108050296 C                   endif
0400002108050291  *
040100210805     C                   If        ebmgpl <> *blanks and
040200210805     C                             ebdgpl <> *blanks and
040300210805     C                             ebvgpl <> *blanks
0404002108050296 C                   leave
0405002108050296 C                   endif
0406002108050291  *
0407002108050296 C                   enddo
0408002108050291  *
0409002108050291  *
041000210805     C                   If        ebmgpl = *blanks
0411002108050296 C                   movel     'Waived'      ebmpln
0412002108050296 C                   endif
0413002108050291  *
041400210805     C                   If        ebdgpl = *blanks
0415002108050296 C                   movel     'Waived'      ebdpln
0416002108050296 C                   endif
0417002108050291  *
041800210805     C                   If        ebvgpl = *blanks
0419002108050296 C                   movel     'Waived'      ebvpln
0420002108050296 C                   endif
0421002108050291  *
0422002108050296 C                   movel     exegrp        ebegrp
0423002108050296 C                   movel     exepkg        ebepkg
0424002108050291  *
0425002108050296 C                   write     ebsdtlr
0426002108050107  *
042700210805     C                   endif                                                  *in62 = '0'
0428002108050107  *
042900210805     C                   enddo                                                  *in62 = '0'
0430002108050107  *
043100210805     C                   endsr
043200210811      *
0433002108050107  ********************************************************************************
0434002108050107  *
0435002108050107  *     *INZSR - Preprossing
0436002108050107  *
0437002108050107  ********************************************************************************
043800210805     C     *inzsr        begsr
0439002108050291  *
0440002108050297 C                   movel     UDATE         cutoff
0441002108050297 C                   movel     cutoff        todaa
0442002108050291  * Determine Term date cutoff - 1 year ago
0443002108050297 C     cutoff        subdur    365:*D        cutoff
0444002108050297 C                   movel     cutoff        cutofn
044500210805      *
0446002108050297 C                   movel     UDATE         day30
0447002108050291  *
0448002108050297 C     day30         adddur    30:*D         day30
0449002108050297 C                   movel     day30         day30n
0450002108050291  *
045100210805     C                   endsr
