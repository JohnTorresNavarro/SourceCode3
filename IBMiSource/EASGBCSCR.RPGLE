000100221130     H DftActGrp(*NO) bnddir('GBSBIND':'ALLSRVPGMN')
000200221109     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
0003000204020002  **************************************************************************
000400221101      * EASGBDSCR  Amwins Connect Administrators
000500020402      *            WRITTEN BY - R.L.J.
000600221206      *            DATE - 12/2022
000700221101      *  DESCRIPTION - Compare EASE data with GBS data to produce the
000800221206      *                Discrepancy file  - Coverages
0009000204020002  **************************************************************************
0010002211100015  *  Change Log:
001100221206      *   xxx mm/dd/yyyy -                                             *
001200221110      *                                                                *
0013009102150018 F******************************************************************
0014002212060020 FGBS3MCRPP UF   E           K DISK
0015002212060020 FGBS3DCRPP UF   E           K DISK
0016002212060020 FPLANXREFL2IF   E           K DISK
0017002211040020 FACCMST    IF   E           K DISK    PREFIX(M)
0018002211010020 FMEMBER    IF   E           K DISK
0019002211070020 FDEPNDC    IF   E           K DISK
0020002212180020 FMCOV39    IF   E           K DISK
0021002302080020 FDCOVC     IF   E           K DISK
0022002211040020 FAACODE    IF   E           K DISK
0023002211210020 FACRELATP  IF   E           K DISK
0024002212180020 FEASECDSP  O    E             DISK
0025002212180020 FEASECDSL2 IF   E           K DISK    RENAME(R_EASECDS:X_EADSC)
0026002211110020 F                                     PREFIX(L)
0027002211110029  *
002800221111      *
002900221111     D                 DS
003000221111     D  uprqs                         8
003100221111     D  uprtn                         8
003200221103     D  upstr                       256
0033000204030029  *
0034000204030250 D                 DS
0035002212150251 D  l2_ssn                 1      9
0036002211010251 D   lssnn                 1      9  0
0037002211100029  *
0038002211100250 D                 DS
0039002212170251 D  l2_effdt               1      8
0040002212170251 D   ceff                  1      8  0
0041002212170029  *
0042002212170250 D                 DS
0043002212170251 D  l2_termdt              1      8
0044002212170251 D   ctermn                1      8  0
0045002211100029  *
0046002212270250 D                 DS
0047002212270251 D  l4_partssn             1      9
0048002212270251 D   dmssnn                1      9  0
0049002212270029  *
0050002212270250 D                 DS
0051002212270251 D  l4_depseq#             1      3
0052002212270251 D   eds1                  1      1  0
0053002212270251 D   eds2                  2      2
0054002212270251 D   eds12                 1      2  0
0055002212270029  *
0056002212270250 D                 DS
0057002212270251 D  depss#                 1      9  0
0058002212270251 D   gdssn                 1      9
0059002212270029  * GBS TSA
0060002212270250 D                 DS
0061002212270251 D  gtsa                   1     10
0062002211020251 D   mbtrst                1      3  0
0063002211020251 D   mbsub#                4      6  0
0064002211020251 D   mbacct                7     10  0
0065002211070029  *
0066002211020250 D                 DS
0067002212170251 D  mcovtp                 1      3
0068002212170251 D   gcvtp                 2      3
0069002212170029  *
0070002212170250 D                 DS
0071002212170251 D  l2_enrl                1      3
0072002212170251 D   ecvtp                 1      2
0073002212130029  *
0074002212170029  * Ease Volume Amount
0075002211020250 D                 DS
0076002212200251 D  l2_volamt              1     11
0077002212200251 D   esl1                  1      1
0078002212200251 D   esl2                  2      2
0079002212200251 D   esl3                  3      3
0080002212200251 D   esl4                  4      4
0081002212200251 D   esl5                  5      5
0082002212200251 D   esl6                  6      6
0083002212200251 D   esl7                  7      7
0084002212200251 D   esl12                 1      2
0085002212200251 D   esl13                 1      3
0086002212200251 D   esl14                 1      4
0087002212200251 D   esl15                 1      5
0088002212200251 D   esl16                 1      6
0089002211020251 D   esl17                 1      7
0090002212200251 D   esl311                3     11
0091002212200251 D   esl411                4     11
0092002212200251 D   esl511                5     11
0093002212200251 D   esl611                6     11
0094002212200251 D   esl711                7     11
0095002212200251 D   esl811                8     11
0096002212200251 D   esl34                 3      4
0097002212200251 D   esl45                 4      5
0098002212200251 D   esl56                 5      6
0099002212200251 D   esl67                 6      7
0100002302170251 D   esl78                 7      8
0101002302170029  *
0102002302170250 D                 DS
0103002302170251 D  esamt                  1     11S 0
0104002302170251 D  eslda                  1      9
0105002302170251 D   esldn                 1      9S 0
0106002302170251 D  eslca                 10     11
0107002302170251 D   eslcn                10     11S 0
0108002302170029  *
0109002302170250 D                 DS
0110002302170251 D  enrldt                 1      8S 0
0111002302170251 D   geff                  1      8
0112002302170029  *
0113002302170250 D                 DS
0114002302170251 D  candt                  1      8S 0
0115002302170251 D   gterm                 1      8
0116002212230029  *
0117002212230250 D                 DS
0118002212230251 D  denrdt                 1      8S 0
0119002212230251 D   deff                  1      8
0120002301190029  *
0121002301190250 D                 DS
0122002301190251 D  ccandt                 1      8S 0
0123002301190251 D   dterm                 1      8
0124002301190029  *
0125002301190250 D                 DS
0126002301190251 D  hldkey                 1     11  0
0127002301190251 D   fhmid#                1      9  0
0128002301190251 D   fhseq#               10     11  0
012900230119      *
013000230119     D                 DS
013100221220     D  inrec                  1    141
0132002301190029  *
0133002301190250 D                 DS
013400221223     D  ISOToday       S               d   inz
013500221223     D  Today          S              8S 0 inz
0136002211100251 D  etermn         S              8S 0
0137002212230251 D  date9          S              8S 0 INZ(99999999)
0138002211070251 D  cutoff         S               D   DATFMT(*ISO)
0139002211300251 D  calcdate       S               D   DATFMT(*ISO)
0140002211070251 D  cutofn         S              8S 0
0141002211300251 D  easedt         S              8S 0
0142002211070251 D  wkdatn         S              8S 0
014300221107     D  wkdat          S               D
014400221103     D  usadt          S               D   DATFMT(*USA/)
014500221103     D  datrec         S             10
014600221103     D  datfnd         S             10
0147002211300251 D  edays          S              2S 0
0148002211300251 D  sq#            S              2S 0
014900221121     D  fdot           S              1    inz('F')
0150002211010251 D  lastn          S             35
0151002212150251 D  kyplan         S            100
0152002212180251 D  plnfnd         S              1
0153002212200251 D  pt             S              2  0
0154001310070037 D sysdateymd      S               d   datfmt(*iso)
015500221101     D  wkday          S               D     inz
0156000809040029  *
0157000809040250 D                 DS
015800080904     D  gbdate                 1      8  0
015900080904     D   gbyr                  1      4  0
016000080904     D   gbmo                  5      6  0
016100080904     D   gbdy                  7      8  0
0162000809040111  *
016300221109      *--------------------------------------------
016400221109      * Procedures
016500221109      *--------------------------------------------
016600221109     D/COPY *LIBL/QMODSRC,#EdtStngPR           // Edit String
016700221130
016800221130      /define Copy_all_protos_and_fields
016900221130      /copy qcpysrc,datsrvpgmp
017000221130      /Undefine Copy_all_protos_and_fields
017100221130
017200221109
017300110419      *
017400221101     C     acckey        klist
017500221215     C                   kfld                    l2_trst
017600221215     C                   kfld                    l2_sub#
017700221215     C                   kfld                    l2_acct
017800221217      *
017900221218     C     mc39ky        klist
018000221217     C                   kfld                    l2_trst
018100221217     C                   kfld                    l2_sub#
018200221218     C                   kfld                    PXPLANID
018300221218     C                   kfld                    lssnn
018400221222      *
018500230208     C     dcvcky        klist
018501230208     C                   kfld                    dmssnn
018502230208     C                   kfld                    c_seq
018600221222     C                   kfld                    l4_trst
018700221222     C                   kfld                    l4_sub#
018800221222     C                   kfld                    PXPLANID
019200221107      *
019300221121     C     relkym        klist
019400221121     C                   kfld                    fdot
019500221215     C                   kfld                    l2_trst
019600221215     C                   kfld                    l2_sub#
019700221215     C                   kfld                    l2_acct
019800221121     C                   kfld                    mbtrst
019900221121     C                   kfld                    mbsub#
020000221121     C                   kfld                    mbacct
020100221121      *
020200221121     C     relkym2       klist
020300221121     C                   kfld                    fdot
020400221121     C                   kfld                    mbtrst
020500221121     C                   kfld                    mbsub#
020600221121     C                   kfld                    mbacct
020700221215     C                   kfld                    l2_trst
020800221215     C                   kfld                    l2_sub#
020900221215     C                   kfld                    l2_acct
021000221223      *
021100221223     C     relkyd        klist
021200221223     C                   kfld                    fdot
021300221223     C                   kfld                    l4_trst
021400221223     C                   kfld                    l4_sub#
021500221223     C                   kfld                    l4_acct
021600221223     C                   kfld                    mbtrst
021700221223     C                   kfld                    mbsub#
021800221223     C                   kfld                    mbacct
021900221223      *
022000221223     C     relkyd2       klist
022100221223     C                   kfld                    fdot
022200221223     C                   kfld                    mbtrst
022300221223     C                   kfld                    mbsub#
022400221223     C                   kfld                    mbacct
022500221223     C                   kfld                    l4_trst
022600221223     C                   kfld                    l4_sub#
022700221223     C                   kfld                    l4_acct
022800221121      *
022900221107     C     acckeyd       klist
023000230208     C                   kfld                    l4_trst
023100230208     C                   kfld                    l4_sub#
023200230208     C                   kfld                    l4_acct
023300221107      *
023400221107     C     depkey        klist
023500221208     C                   kfld                    c_ssn
023600221208     C                   kfld                    c_seq
023700221109      *
023800221109     C     easkey        klist
023900221208     C                   kfld                    c_ssn
024000221208     C                   kfld                    c_seq
024100221208     C                   kfld                    c_fldnam
024200221208     C                   kfld                    c_datrec
024300091014      *
024400080904      *
0245002302070291  * CALCULATE DATE TO USE - 4 BUS DAYS PRIOR TO TODAY !!!!!
024600080904     C                   move      udate         ISOtoday
024700080904     C                   move      ISOtoday      today
024800221130     C                   eval      calcdate =ISOtoday
0249002211300291  * Determine EASE file date to run
025000230106     C                   eval      edays = 0
0251002301060296 C                   dou       edays = 4
0252002301250297 C     calcdate      subdur    1:*D          calcdate
025300230125     C                   if        #get_dow(calcdate) <> 'Sunday' and
025400230125     C                             #get_dow(calcdate) <> 'Saturday'
025500230125     C                   eval      edays = edays + 1
025600230125     C                   endif
025700230125     C                   enddo
025800230125      *
025900230125     C                   movel     calcdate      easedt
026000230125      *
026100230125     C                   eval      uprqs = '*UPPER  '
026200230125      *
0263002301250291  * Main Line - Compare Member fields
0264002301250297 C     *LOVAL        setll     GBS3MCRPP
0265002301250296 C                   dou       *in21 = '1'
0266002301250297 C                   read      GBS3MCRPP                              21
0267002301250296 C                   If        *in21 = '1'
0268002301250296 C                   leave
0269002301170296 C                   endif
027000230117      *
0271002301260296 C                   If        l2_rpsts <> ' ' or
0272002301260296 C                             l2_trst = 667 or l2_recdate <> easedt
0273002301260296 C                   iter
0274002301260296 C                   endif
027500230126      *       See if plan is in Cross Ref file
027600230126     C                   movel     l2_plan       kyplan
027700230126     C     kyplan        chain     planxrefl2                         20
027800230126     C                   if        *IN20 = '1'
0279002301260296 C                   iter
0280002301260296 C                   endif
028100230126      *
0282002211010107  *      Set Mbr/Acct default fields for disc recs                      ****
028300230126     C                   clear                   r_easecds
028400230126     C                   eval      c_datrec = l2_recdate
028500230126     C                   eval      c_datfnd = today
028600221101      *  Member defaults
028700221215     C                   movel     l2_ssn        c_ssn
028800221208     C                   eval      c_seq = 0
028900221101      *  Account data
029000221215     C                   eval      c_trst = l2_trst
029100221215     C                   eval      c_sub# = l2_sub#
029200230106     C                   eval      c_acct = l2_acct
029300230106     C     acckey        chain     accmst                             22
029400230106     C                   if        *IN22 = '1'
029500230106     C                   movel     '**ACCMST REC'c_fldnam
029600230106     C                   eval      c_sts = 'A'
0297002301060107  *                                                                     ****
029800230106     C     easkey        chain     easecdsl2                          42
029900230106     C                   if        *IN42 = '1'
030000230217     C***                write     r_easecds
0301002301060296 C                   endif
0302002301060107  *                                                                     ****
0303002301060296 C                   iter
0304002301060296 C                   endif
0305002301060107  *                                                                     ****
030600230106     C                   movel(P)  macnam1       c_accnam
030700230106     C                   movel(P)  maacode       c_aacod
0308002301060107  *                                                                     ****
030900221216     C     maacode       chain     aacode                             29
031000221216     C                   if        *IN29 = '0'
031100221216     C                   movel(P)  alnam         c_aalnm
031200221216     C                   movel(P)  afnam         c_aafnm
0313002212160296 C                   endif
0314002212160107  *                                                                     ****
0315002212160107  *                                                                     ****
031600221216     C     lssnn         chain     member                             23
031700221216     C                   if        *IN23 = '1'
0318002212160107  *      Member Rec Missing                                             ****
031900221216     C                   movel     '**MEMBER REC'c_fldnam
032000221216     C                   eval      c_sts = 'M'
0321002212160107  *                                                                     ****
032200221216     C                   eval      etermn = 0
032300221217     C                   if        l2_termdt <> *blanks
0324002212170296 C                   move      l2_termdt     etermn
0325002211100296 C                   endif
0326002212190107  *                                                                     ****
032700221219     C                   if        etermn > today or etermn = 0
0328002211100107  *                                                                     ****
032900221215     C     easkey        chain     easecdsl2                          42
033000221109     C                   if        *IN42 = '1'
033100221217     C                   write     r_easecds
0332002211090296 C                   endif
0333002211090107  *                                                                     ****
0334002211100296 C                   endif
0335002211100107  *                                                                     ****
0336002211010296 C                   iter
0337002212080296 C                   endif
033800221103      *
0339002212190296 C                   movel     mlname        c_lname
0340002212190296 C                   movel     mfname        c_fname
034100221219      *
0342002212080107  *      Compare Member fields                                          ****
0343002212080107  *         Account#                                                    ****
0344002212150296 C                   If        l2_trst <> mbtrst or
0345002212150296 C                             l2_sub# <> mbsub# or
0346002212150296 C                             l2_acct <> mbacct
034700230109      *      Check Related Accounts file
034800230109     C     relkym        chain     acrelatp                           51
034900230109     C                   if        *IN51 = '1'
035000230109     C     relkym2       chain     acrelatp                           52
035100230109     C                   if        *IN52 = '1'
0352002301090107  *                                                                     ****
035300230109     C                   movel(P)  'ACCOUNT#'    c_fldnam
035400230109     C                   eval      c_easval = l2tsa
035500230109     C                   eval      c_gbsval = gtsa
035600230109     C                   eval      c_sts = 'D'
0357002301090107  *                                                                     ****
035800230109     C     easkey        chain     easecdsl2                          42
035900230109     C                   if        *IN42 = '1'
036000230217     C****               write     r_easecds
0361002301090296 C                   endif
0362002212070107  *                                                                     ****
0363000303310296 C                   endif
0364002212070296 C                   endif
0365002211210296 C                   endif
0366002212170107  *                                                                     ****
0367002212170291  *      Look for EASE Plan in MCOV recs - There can be multiple
0368002212170291  *          GBS Plans tied to an EASE Input Plan Name
0369002212170107  *                                                                     ****
0370002212170296 C                   eval      plnfnd = 'N'
0371002212170297 C     kyplan        setll     PLANXREFL2
0372002212170296 C                   dou       *in41 = '1'
0373002301060297 C     kyplan        reade     PLANXREFL2                             41
0374002212170296 C                   If        *in41 = '1'
0375002301060296 C                   leave
0376002301060296 C                   endif
037700230106      *
0378002301060297 C     mc39ky        chain     mcov39                             52
0379002301060296 C                   If        *in52 = '0'
0380002301060296 C                   eval      plnfnd = 'Y'
0381002301060296 C                   eval      c_plan# = mcplan
0382002301060296 C                   leave
0383002301060296 C                   endif
038400230106      *
0385002212170296 C                   enddo
038600230106      *
0387002301060296 C                   if        plnfnd = 'N'
0388002301190291  *      No Plan Match - create disc rec
038900230119     C                   movel(P)  'Plan ID'     c_fldnam
039000230119     C                   movel(P)  l2_plan       c_easval
039100230119     C                   movel(P)  *blanks       c_gbsval
039200230119     C                   eval      c_sts = 'D'
0393002301190107  *                                                                     ****
039400230119     C     easkey        chain     easecdsl2                          42
039500230119     C                   if        *IN42 = '1'
039600230119     C                   write     r_easecds
0397002301190296 C                   endif
0398002301190107  *                                                                     ****
0399002301190296 C                   iter
0400002212170296 C                   endif
0401002212170107  *                                                                     ****
0402002212170291  *      Plan Match - check other fileds
0403002212170107  *           Eff Date                                                  ****
0404002302080296 C                   If        l2_effdt < geff
040500221217     C                   movel(P)  'EFF DT'      c_fldnam
0406002212170296 C                   If        l2_effdt = '        '
0407002212300296 C                   eval      c_easval = *blanks
0408002212170296 C                   else
040900230105     C                   movel     l2_effdt      wkdatn
041000230105     C                   movel     wkdatn        wkdat
041100230105     C                   eval      usadt = wkdat
041200230105     C                   movel(P)  usadt         c_easval
0413002301050296 C                   endif
0414002301050296 C                   If        enrldt = 0
0415002301050296 C                   eval      c_gbsval = *blanks
0416002301050296 C                   else
041700230105     C                   movel     enrldt        wkdat
041800230105     C                   eval      usadt = wkdat
041900230105     C                   movel(P)  usadt         c_gbsval
0420002301050296 C                   endif
042100230105     C                   eval      c_sts = 'D'
0422002301050107  *                                                                     ****
042300230105     C     easkey        chain     easecdsl2                          42
042400230105     C                   if        *IN42 = '1'
042500230105     C                   write     r_easecds
0426002212170296 C                   endif
0427002212170107  *                                                                     ****
0428002212170296 C                   endif
0429002212170107  *          Term Date                                                  ****
0430002212180296 C                   If        l2_termdt = '        '
0431002212180296 C                   eval      l2_termdt = '00000000'
0432002212180296 C                   endif
0433002212180296 C                   If        l2_termdt <> gterm
0434002301190107  *          If EASE term = 0 and mbr had prior covg - bypass           ****
0435002301190296 C                   If        l2_termdt <> '00000000' or
0436002301190296 C                             candt = 0
0437002301190107  *                                                                     ****
043800221217     C                   movel(P)  'TERM DT'     c_fldnam
0439002212180296 C                   If        l2_termdt = '00000000'
0440002212170296 C                   eval      c_easval = *blanks
0441002212170296 C                   else
044200221217     C                   movel     l2_termdt     wkdatn
044300221217     C                   movel     wkdatn        wkdat
044400221217     C                   eval      usadt = wkdat
044500221217     C                   movel(P)  usadt         c_easval
0446002212170296 C                   endif
0447002212170296 C                   If        candt = 0
0448002212170296 C                   eval      c_gbsval = *blanks
0449002212270296 C                   else
045000221227     C                   movel     candt         wkdat
045100221227     C                   eval      usadt = wkdat
045200221227     C                   movel(P)  usadt         c_gbsval
0453002301170296 C                   endif
045400230117     C                   eval      c_sts = 'D'
0455002301170107  *                                                                     ****
045600230117     C     easkey        chain     easecdsl2                          42
045700230117     C                   if        *IN42 = '1'
045800230117     C                   write     r_easecds
0459002301170296 C                   endif
0460002301170107  *                                                                     ****
0461002301170296 C                   endif
0462002301190107  *                                                                     ****
0463002301190296 C                   endif
0464002301170291  *         Coverage Type
0465002301170296 C                   If        ecvtp <> gcvtp
046600230117     C                   movel(P)  'Cov Type'    c_fldnam
046700230117     C                   movel(P)  ecvtp         c_easval
046800230117     C                   movel(P)  gcvtp         c_gbsval
046900230117     C                   eval      c_sts = 'D'
0470002301170107  *                                                                     ****
047100230117     C     easkey        chain     easecdsl2                          42
047200221217     C                   if        *IN42 = '1'
047300221217     C                   write     r_easecds
0474002212170296 C                   endif
0475002212170107  *                                                                     ****
0476002212170296 C                   endif
0477002212170291  *         Volume Amount
047800221220     C                   eval      esamt = 0
047900221217      *
0480002212200296 C                   If        l2_volamt = *blanks or
0481002212200296 C                             l2_volamt = '0          '
048200221220     C                   eval      esamt = 0
048300221220     C                   else
048400221220     C                   exsr      calcamt
048500221220     C                   endif
048600221217      *
0487002212200296 C                   If        esldn <> benamt
048800221220     C                   movel(P)  'Vol Amount'  c_fldnam
048900221220     C                   eval      c_easval = %EDITC(esldn:'A')
049000221220     C                   eval      c_gbsval = %EDITC(benamt:'A')
049100221220     C                   eval      c_sts = 'D'
0492002212170107  *                                                                     ****
049300221220     C     easkey        chain     easecdsl2                          42
049400221220     C                   if        *IN42 = '1'
049500221220     C                   write     r_easecds
0496002212200296 C                   endif
0497002212170107  *                                                                     ****
0498002212200296 C                   endif
0499002212200291  *
0500000204050296 C                   enddo
0501002211070291  *
0502002211070291  * Process Dependent Data
0503002211070291  *
0504002301040297 C     *LOVAL        setll     GBS3DCRPP
0505002301040296 C                   dou       *in31 = '1'
0506002301040297 C                   read      GBS3DCRPP                              31
0507002302080296 C                   If        *in31 = '1'
0508002302090291  *
0509002301040296 C                   leave
0510002302080296 C                   endif
051100230104      *
0512002301040296 C                   If        l4_rpsts <> ' ' or
0513002301040296 C                             l4_trst = 667 or l4_recdate <> easedt
0514002301040296 C                   iter
0515002301040296 C                   endif
051600230104      *       See if plan is in Cross Ref file
051700230104     C                   movel     l4_plan       kyplan
051800230104     C     kyplan        chain     planxrefl2                         20
051900221222     C                   if        *IN20 = '1'
0520002212220296 C                   iter
0521002212220296 C                   endif
052200221222      *
052300221222      *    Debug shit
0524002212220296 C                   If        l4_partssn = '290866817'
0525002212220296 C                   eval      l4_partssn = l4_partssn
0526002212220296 C                   endif
052700221222      *
0528002212220107  *      Set Dep/Acct default fields for disc recs                      ****
052900221222     C                   clear                   r_easecds
053000221223     C                   eval      c_datrec = l4_recdate
053100221222     C                   eval      c_datfnd = today
053200221222      *  Depend defaults
053300230105     C                   movel     l4_partssn    c_ssn
053400230105     C                   eval      c_seq = eds1
0535002301050296 C                   if        eds2 <> ' '
053600230105     C                   eval      c_seq = eds12
053700230105     C                   endif
053800230105      *  Account data
053900230105     C                   eval      c_trst = l4_trst
054000230105     C                   eval      c_sub# = l4_sub#
054100230105     C                   eval      c_acct = l4_acct
054200230105     C     acckeyd       chain     accmst                             32
054300230105     C                   if        *IN32 = '1'
054400230105     C                   movel     '**ACCMST REC'c_fldnam
054500230105     C                   eval      c_sts = 'A'
0546002301050107  *                                                                     ****
054700230105     C     easkey        chain     easecdsl2                          42
054800221222     C                   if        *IN42 = '1'
054900230217     C****               write     r_easecds
0550002212220296 C                   endif
0551002212220107  *                                                                     ****
0552002212220296 C                   iter
0553002212220296 C                   endif
0554002212220107  *                                                                     ****
055500221222     C                   movel(P)  macnam1       c_accnam
055600221222     C                   movel(P)  maacode       c_aacod
0557002212220107  *                                                                     ****
055800221222     C     maacode       chain     aacode                             39
055900221222     C                   if        *IN39 = '0'
056000221222     C                   movel(P)  alnam         c_aalnm
056100221222     C                   movel(P)  afnam         c_aafnm
0562002212220296 C                   endif
0563002212220107  *                                                                     ****
0564002212220107  *                                                                     ****
056500221222     C     depkey        chain     depndc                             33
056600221222     C                   if        *IN33 = '1'
0567002212220107  *      Depend Rec Missing                                             ****
056800221222     C                   movel     '**DEPEND REC'c_fldnam
056900221222     C                   eval      c_sts = 'M'
0570002212220107  *                                                                     ****
057100221222     C                   eval      etermn = 0
057200221223     C                   if        l4_termdt <> *blanks
0573002212230296 C                   move      l4_termdt     etermn
0574002212220296 C                   endif
0575002212220107  *                                                                     ****
057600221222     C                   if        etermn > today
0577002212220107  *                                                                     ****
057800221223     C     easkey        chain     easecdsl2                          42
057900230104     C                   if        *IN42 = '1'
058000230104     C                   write     r_easecds
0581002301040296 C                   endif
0582002301040107  *                                                                     ****
0583002301040296 C                   endif
0584002301040107  *                                                                     ****
0585002301040296 C                   iter
0586002301040296 C                   endif
058700230104      *
0588002212230296 C                   movel     dlname        c_lname
0589002301040296 C                   movel     dfname        c_fname
059000230104      *
0591002301040296 C                   eval      plnfnd = 'N'
0592002301040297 C     kyplan        setll     PLANXREFL2
0593002301040296 C                   dou       *in41 = '1' or plnfnd = 'Y'
0594002301040297 C     kyplan        reade     PLANXREFL2                             41
0595002212220296 C                   If        *in41 = '1'
0596002212220296 C                   leave
0597002212220296 C                   endif
0598002212230291  *
0601002302090297 C     dcvcky        chain     dcovc                              39
0602002302090291  *
0603002302090296 C                   If        *in39 = '0'
0603012302090296 C                   eval      plnfnd = 'Y'
0603022302090296 C                   eval      c_plan# = dvplan
0605002302090296 C                   leave
0606002212230296 C                   endif
062000230209      *
0621002302090296 C                   enddo
062200230209      *
0623002212220296 C                   if        plnfnd = 'N'
0624002302090291  *      No Plan Match - create disc rec
062500230209     C                   movel(P)  'Plan ID'     c_fldnam
062600230209     C                   movel(P)  l4_plan       c_easval
062700230209     C                   movel(P)  *blanks       c_gbsval
062800230209     C                   eval      c_sts = 'D'
0629002212220107  *                                                                     ****
063000221222     C     easkey        chain     easecdsl2                          42
063100221222     C                   if        *IN42 = '1'
063200221222     C                   write     r_easecds
0633002212220296 C                   endif
0634002212220107  *                                                                     ****
0635002212220296 C                   iter
0636002212220296 C                   endif
0637002212220107  *                                                                     ****
0638002212220291  *      Plan Match - check other fileds
0639002212220107  *           Eff Date                                                  ****
0640002302070296 C                   If        l4_effdt < deff
064100221222     C                   movel(P)  'EFF DT'      c_fldnam
0642002212230296 C                   If        l4_effdt = '        '
0643002212220296 C                   eval      c_easval = *blanks
0644002212220296 C                   else
064500221223     C                   movel     l4_effdt      wkdatn
064600221222     C                   movel     wkdatn        wkdat
064700221222     C                   eval      usadt = wkdat
064800221222     C                   movel(P)  usadt         c_easval
0649002212220296 C                   endif
0650002212230296 C                   If        denrdt = 0
0651002212220296 C                   eval      c_gbsval = *blanks
0652002212220296 C                   else
065300221223     C                   movel     denrdt        wkdat
065400221222     C                   eval      usadt = wkdat
065500221222     C                   movel(P)  usadt         c_gbsval
0656002212220296 C                   endif
065700221222     C                   eval      c_sts = 'D'
0658002212220107  *                                                                     ****
065900221222     C     easkey        chain     easecdsl2                          42
066000221222     C                   if        *IN42 = '1'
066100221222     C                   write     r_easecds
0662002212220296 C                   endif
0663002212220107  *                                                                     ****
0664002212220296 C                   endif
0665002212220107  *          Term Date                                                  ****
0666002212230296 C                   If        l4_termdt = '        '
0667002212230296 C                   eval      l4_termdt = '00000000'
0668002212220296 C                   endif
0669002212230296 C                   If        l4_termdt <> dterm
067000221222     C                   movel(P)  'TERM DT'     c_fldnam
0671002212230296 C                   If        l4_termdt = '00000000'
0672002212220296 C                   eval      c_easval = *blanks
0673002212220296 C                   else
067400221223     C                   movel     l4_termdt     wkdatn
067500221222     C                   movel     wkdatn        wkdat
067600221222     C                   eval      usadt = wkdat
067700221222     C                   movel(P)  usadt         c_easval
0678002212220296 C                   endif
0679002212230296 C                   If        ccandt = 0
0680002212220296 C                   eval      c_gbsval = *blanks
0681002212220296 C                   else
068200221223     C                   movel     ccandt        wkdat
068300221222     C                   eval      usadt = wkdat
068400221222     C                   movel(P)  usadt         c_gbsval
0685002212220296 C                   endif
068600221222     C                   eval      c_sts = 'D'
0687002212220107  *                                                                     ****
068800221222     C     easkey        chain     easecdsl2                          42
068900221222     C                   if        *IN42 = '1'
069000221222     C                   write     r_easecds
0691002212220296 C                   endif
0692002212220107  *                                                                     ****
0693002212220296 C                   endif
0694002212220296 C                   enddo
069500221223      *
0696000204050296 C                   movel     '1'           *inlr
0697000204050296 C                   return
0698002212200291  ****************************************************************
0699002212200291  *                                                              *
0700002212200291  *        CALCAMT - Calculate EASE Volume Amount                *
0701002212200291  *                                                              *
0702002212200291  ****************************************************************
070300221220     C     calcamt       begsr
070400221220     C                   eval      eslcn = 0
070500221220     C                   Eval      pt = %scan('.' : l2_volamt:1)
070600221220     C                   if        pt <> 0
070700221220      *
070800221220     C                   select
070900221220      *
071000221220     C                   when      pt = 2
071100221220     C                   move      esl1          eslda
071200221220     C                   if        esl411 = '        '
071300221220     C                   movel     esl3          eslca
071400221220     C                   move      '0'           eslca
071500221220     C                   else
071600221220     C                   movel     esl34         eslca
071700221220     C                   endif
071800221220      *
071900221220     C                   when      pt = 3
072000230125     C                   move      esl12         eslda
072100230125     C                   if        esl511 = '       '
072200230125     C                   movel     esl4          eslca
072300230125     C                   move      '0'           eslca
072400230125     C                   else
072500230125     C                   movel     esl45         eslca
072600230125     C                   endif
072700230125      *
072800230125     C                   when      pt = 4
072900230125     C                   move      esl13         eslda
073000230125     C                   if        esl611 = '      '
073100221220     C                   movel     esl5          eslca
073200221220     C                   move      '0'           eslca
073300221220     C                   else
073400221220     C                   movel     esl56         eslca
073500221220     C                   endif
073600221220      *
073700221220     C                   when      pt = 5
073800221220     C                   move      esl14         eslda
073900221220     C                   if        esl711 = '     '
074000221220     C                   movel     esl6          eslca
074100221220     C                   move      '0'           eslca
074200221220     C                   else
074300221220     C                   movel     esl67         eslca
074400221220     C                   endif
074500221220      *
074600221220     C                   when      pt = 6
074700221220     C                   move      esl15         eslda
074800221220     C                   if        esl811 = '     '
074900221220     C                   movel     esl7          eslca
075000221220     C                   move      '0'           eslca
075100221220     C                   else
075200221220     C                   movel     esl78         eslca
075300221220     C                   endif
075400221220      *
075500221220     C                   endsl
075600221220      *
075700221221     C                   if        eslcn > 00
075800221220     C                   eval      esldn = esldn + 1
075900221220     C                   endif
076000221220      *
076100221220     C                   else
076200221220      *   No decimal point
076300221220     C                   select
076400221220      *
076500221220     C                   when      esl311 = '         '
076600221220     C                   move      esl12         eslda
076700221220     C                   when      esl411 = '        '
076800221220     C                   move      esl13         eslda
076900221220     C                   when      esl511 = '       '
077000221220     C                   move      esl14         eslda
077100221220     C                   when      esl611 = '      '
077200221220     C                   move      esl15         eslda
077300221220     C                   when      esl711 = '     '
077400221220     C                   move      esl16         eslda
077500221220      *
077600221220     C                   endsl
077700221220      *
077800221220     C                   endif
077900221220      *
078000221220     C                   endsr
