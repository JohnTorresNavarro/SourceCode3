000100221130     H DftActGrp(*NO) bnddir('GBSBIND':'ALLSRVPGMN')
000200221109     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
0003000204020002  **************************************************************************
000400221101      * EASGBDSCR  Amwins Connect Administrators
000500020402      *            WRITTEN BY - R.L.J.
000600221101      *            DATE - 11/2022
000700221101      *  DESCRIPTION - Compare EASE data with GBS data to produce the
000800221101      *                Discrepancy file
0009000204020002  **************************************************************************
0010002211100015  *  Change Log:
001100221110      *   rlj 11/10/2022 - Bypass Ease recs w/ Trust 667 - GA Accts    *
001200221110      *      - If Ease mbr is termed and not in GBS - bypass           *
001300221110      *      - Match ease deps on name, dob and sex                    *
001400221110      *                                                                *
0015009102150018 F******************************************************************
0016002212010020 FGBS3MBRPP UF   E           K DISK
0017002212010020 FGBS3DPRPP UF   E           K DISK
0018002211040020 FACCMST    IF   E           K DISK    PREFIX(M)
0019002211010020 FMEMBER    IF   E           K DISK
0020002211070020 FDEPNDC    IF   E           K DISK
0021002211010020 FMEMEXTP   IF   E           K DISK
0022002211010020 FCFS100P   IF   E           K DISK
0023002211020020 FSMOKE     IF   E           K DISK
0024002211040020 FAACODE    IF   E           K DISK
0025002211210020 FACRELATP  IF   E           K DISK
0026002211090020 FEASEDSCP  O    E             DISK
0027002211090020 FEASEDSCL2 IF   E           K DISK    RENAME(R_EASEDSC:X_EADSC)
0028002211110020 F                                     PREFIX(L)
0029002211110029  *
003000221111      *
003100221111     D                 DS
003200221111     D  uprqs                         8
003300230921     D  uprtn                         8
003400221103     D  upstr                       256
0035000204030029  *
0036000204030250 D                 DS
0037002211010251 D  l1_ssn                 1      9
0038002211010251 D   lssnn                 1      9  0
0039002211100029  *
0040002211100250 D                 DS
0041002211100251 D  l3_termdt              1      8
0042002211100251 D   dtermn                1      8  0
0043002211100029  *
0044002211100250 D                 DS
0045002211100251 D  l3_partssn             1      9
0046002211100251 D   dssnn                 1      9  0
0047002211070029  *
0048002211070250 D                 DS
0049002211070251 D  l3_depseq#             1      3
0050002211070251 D   eds1                  1      1  0
0051002211070251 D   eds2                  2      2
0052002211070251 D   eds12                 1      2  0
0053002211070029  *
0054002211070250 D                 DS
0055002211070251 D  depss#                 1      9  0
0056002211070251 D   gdssn                 1      9
0057002211020029  * GBS TSA
0058002211010250 D                 DS
0059002211020251 D  gtsa                   1     10
0060002211020251 D   mbtrst                1      3  0
0061002211020251 D   mbsub#                4      6  0
0062002211020251 D   mbacct                7     10  0
0063002211070029  *
0064002211020029  * GBS ZIP
0065002211020250 D                 DS
0066002211020251 D  zip                    1      9  0
0067002211070251 D   gzip5                 1      5
0068002211070251 D   gzip4                 6      9
0069002211010029  *
0070002211010029  * Ease ZIP
0071002211010250 D                 DS
0072002211070251 D  l1_zip                 1     10
0073002211070251 D   ezip5                 1      5
0074002211070251 D   ezip4                 7     10
0075002211070029  *
0076002211070029  * GBS ZIP
0077002211070250 D                 DS
0078002211070251 D  dzip                   1      9  0
0079002211070251 D   gzip5d                1      5
0080002211070251 D   gzip4d                6      9
0081002211070029  *
0082002211070029  * Ease ZIP
0083002211070250 D                 DS
0084002211070251 D  l3_zip                 1     10
0085002211070251 D   ezip5d                1      5
0086002211070251 D   ezip4d                7     10
0087002211070029  *
0088002211010029  * Ease State
0089002211010250 D                 DS
0090002211010251 D  l1_state               1     20
0091002211010251 D   est2                  1      2
0092002211070029  *
0093002211070029  * Ease State Dep
0094002211070250 D                 DS
0095002211070251 D  l3_state               1     20
0096002211070251 D   dst2                  1      2
0097002211020029  * Ease Salary
0098002211020250 D                 DS
0099002211020251 D  l1_sal                 1     11
0100002302060251 D   esl14                 1      4
0101002302060251 D   esl15                 1      5
0102002211020251 D   esl16                 1      6
0103002211020251 D   esl17                 1      7
0104002302060251 D   esl5                  5      5
0105002302060251 D   esl6                  6      6
0106002211020251 D   esl7                  7      7
0107002211020251 D   esl8                  8      8
0108002211040251 D   esl9                  9      9
0109002211040251 D   esl10                10     10
0110002302060251 D   esl67                 6      7
0111002302060251 D   esl78                 7      8
0112002211020251 D   esl89                 8      9
0113002211020251 D   esl90                 9     10
0114002211010029  *
0115002211020250 D                 DS
0116002211020251 D  eslda                  1      9
0117002211020251 D   esldn                 1      9S 0
0118002211020251 D  eslca                 10     11
0119002211020251 D   eslcn                10     11S 0
0120002211020029  *
0121002211010250 D                 DS
0122002211010251 D  gphone                 1     10
0123002211010251 D   gph3                  1      3S 0
0124002211010251 D   gph7                  4     10S 0
0125002211010029  *
0126002211010250 D                 DS
0127002211110251 D  fomn                   1      8S 0
0128002211110251 D   fomdd                 7      8s 0
0129002211110251 D  foma                   1      8
0130002211110029  *
0131002211110250 D                 DS
0132002211110251 D  birth                  1      8S 0
0133002211110251 D   gbirth                1      8
0134002211070029  *
0135002211070250 D                 DS
0136002211070251 D  dbirth                 1      8S 0
0137002211070251 D   gbirthd               1      8
0138002211010029  *
0139002211010250 D                 DS
0140002211010251 D  empdt                  1      8S 0
0141002211010251 D   gdoh                  1      8
0142002211020029  *
0143002211020250 D                 DS
0144002211020251 D  termdt                 1      8S 0
0145002211020251 D   gterm                 1      8
014600221102      *
0147002211090250 D                 DS
0148002211090251 D  x_addr1                1     40
0149002211090251 D   addr131              31     40
0150000505250029  *
0151002211090250 D                 DS
0152002211090251 D  x_addr2                1     40
0153002211090251 D   addr231              31     40
0154002211090029  *
0155002211090250 D                 DS
0156002211090251 D  x_city                 1     30
0157002211090251 D   city16               16     30
0158002211090029  *
0159000505250250 D                 DS
0160000505250251 D  hldkey                 1     11  0
0161001008050251 D   fhmid#                1      9  0
0162002211070251 D   fhseq#               10     11  0
016300221107      *
016400221107     D                 DS
016500221107     D  inrec                  1    141
016600221107     D   l1_email              1     75
0167002211070251 D  fill66                76    141
016800221107     D   gemail               76    140
0169002211070029  *
0170002211070250 D                 DS
017100221107     D  ISOToday       S               d     inz
017200221107     D  Today          S              8S 0   inz
0173002211100251 D  etermn         S              8S 0
0174002211070251 D  cutoff         S               D   DATFMT(*ISO)
0175002211110251 D  fomiso         S               D   DATFMT(*ISO)
0176002211300251 D  calcdate       S               D   DATFMT(*ISO)
0177002211070251 D  cutofn         S              8S 0
0178002211300251 D  easedt         S              8S 0
0179002211070251 D  wkdatn         S              8S 0
018000221107     D  wkdat          S               D
018100221103     D  usadt          S               D   DATFMT(*USA/)
018200221103     D  datrec         S             10
018300221103     D  datfnd         S             10
0184002211300251 D  edays          S              2S 0
0185002211300251 D  sq#            S              2S 0
0186002211030251 D  esal           S              9S 0
018700221121     D  fdot           S              1    inz('F')
0188002211010251 D  firstn         S             25
0189002211010251 D  lastn          S             35
0190002211010251 D  gaddr1         S             40
0191002211010251 D  gaddr2         S             40
0192002211010251 D  gcity          S             30
0193002211020251 D  gemail75       S             75
0194002211020251 D  gsmoke         S              1
0195001310070037 D sysdateymd      S               d   datfmt(*iso)
019600221101     D  wkday          S               D     inz
0197002211090037 D x_fname         S                   LIKE(L1_FNAME)
0198002211090037 D x_lname         S                   LIKE(L1_LNAME)
0199000809040029  *
0200000809040250 D                 DS
020100080904     D  gbdate                 1      8  0
020200080904     D   gbyr                  1      4  0
020300080904     D   gbmo                  5      6  0
020400080904     D   gbdy                  7      8  0
0205000809040111  *
020600221109      *--------------------------------------------
020700221109      * Procedures
020800221109      *--------------------------------------------
020900221109     D/COPY *LIBL/QMODSRC,#EdtStngPR           // Edit String
021000221130
021100221130      /define Copy_all_protos_and_fields
021200221130      /copy qcpysrc,datsrvpgmp
021300221130      /Undefine Copy_all_protos_and_fields
021400221130
021500221109
021600110419      *
021700221101     C     acckey        klist
021800221101     C                   kfld                    l1_trst
021900221101     C                   kfld                    l1_sub#
022000221101     C                   kfld                    l1_acct
022100221107      *
022200221121     C     relkym        klist
022300221121     C                   kfld                    fdot
022400221121     C                   kfld                    l1_trst
022500221121     C                   kfld                    l1_sub#
022600221121     C                   kfld                    l1_acct
022700221121     C                   kfld                    mbtrst
022800221121     C                   kfld                    mbsub#
022900221121     C                   kfld                    mbacct
023000221121      *
023100221121     C     relkym2       klist
023200221121     C                   kfld                    fdot
023300221121     C                   kfld                    mbtrst
023400221121     C                   kfld                    mbsub#
023500221121     C                   kfld                    mbacct
023600221121     C                   kfld                    l1_trst
023700221121     C                   kfld                    l1_sub#
023800221121     C                   kfld                    l1_acct
023900221121      *
024000221107     C     acckeyd       klist
024100221107     C                   kfld                    l3_trst
024200221107     C                   kfld                    l3_sub#
024300221107     C                   kfld                    l3_acct
024400091223      *
024500221101     C     c100key       klist
024600221101     C                   kfld                    lssnn
024700221101     C                   kfld                    sq#
024800221107      *
024900221107     C     depkey        klist
025000221107     C                   kfld                    d_ssn
025100221107     C                   kfld                    d_seq
025200221109      *
025300221109     C     easkey        klist
025400221109     C                   kfld                    d_ssn
025500221109     C                   kfld                    d_seq
025600221109     C                   kfld                    d_fldnam
025700221109     C                   kfld                    d_datrec
025800091014      *
025900080904      *
0260002211010291  * CALCULATE DATE TO USE - 3 BUS DAYS PRIOR TO TODAY !!!!!
026100080904     C                   move      udate         ISOtoday
026200080904     C                   move      ISOtoday      today
026300221130     C                   eval      calcdate =ISOtoday
0264002211300291  * Determine EASE file date to run
026500221130     C                   eval      edays = 0
0266002211300296 C                   dou       edays = 4
0267002211300297 C     calcdate      subdur    1:*D          calcdate
026800221130     C                   if        #get_dow(calcdate) <> 'Sunday' and
026900221130     C                             #get_dow(calcdate) <> 'Saturday'
027000221130     C                   eval      edays = edays + 1
027100221130     C                   endif
027200221130     C                   enddo
027300221130      *
027400221130     C                   movel     calcdate      easedt
027500080904      *
027600221103     C                   eval      uprqs = '*UPPER  '
027700221103      *
0278002211010291  * Main Line - Compare Member fields
0279002212010297 C     *LOVAL        setll     GBS3MBRPP
0280002211210296 C                   dou       *in21 = '1'
0281002212010297 C                   read      GBS3MBRPP                              21
0282002211210296 C                   If        *in21 = '1'
0283002211210296 C                   leave
0284002211210296 C                   endif
028500221121      *
0286002211210296 C                   If        l1_rpsts <> ' ' or
0287002211300296 C                             l1_trst = 667 or l1_recdate <> easedt
0288002211010296 C                   iter
0289000807210296 C                   endif
029000221101      *
0291002211010107  *      Set Mbr/Acct default fields for disc recs                      ****
029200221101     C                   clear                   r_easedsc
029300221101     C                   eval      d_datrec = l1_recdate
029400221101     C                   eval      d_datfnd = today
029500221101      *  Member defaults
029600221101     C                   movel     l1_ssn        d_ssn
029700221101     C                   eval      d_seq = 0
029800221101     C                   movel     l1_fname      d_fname
029900221101     C                   movel     l1_lname      d_lname
030000221101      *  Account data
030100221101     C                   eval      d_trst = l1_trst
030200221101     C                   eval      d_sub# = l1_sub#
030300221101     C                   eval      d_acct = l1_acct
030400221101     C     acckey        chain     accmst                             22
030500221101     C                   if        *IN22 = '1'
030600221121     C                   movel     '**ACCMST REC'd_fldnam
030700221101     C                   eval      d_sts = 'A'
0308002211090107  *                                                                     ****
030900221109     C     easkey        chain     easedscl2                          42
031000221109     C                   if        *IN42 = '1'
031100221101     C                   write     r_easedsc
0312002211090296 C                   endif
0313002211210107  *                                                                     ****
0314002211010296 C                   iter
0315002211010296 C                   endif
0316002211010107  *                                                                     ****
031700230906     C                   if        L1_ssn = '         '
031800230906     C                   movel     '**BLANK SSN 'd_fldnam
031900230906     C                   eval      d_sts = 'A'
0320002309060107  *                                                                     ****
032100230906     C     easkey        chain     easedscl2                          42
032200230906     C                   if        *IN42 = '1'
032300230906     C                   write     r_easedsc
0324002309060296 C                   endif
0325002309060107  *                                                                     ****
0326002309060296 C                   iter
0327002309060296 C                   endif
0328002309060107  *                                                                     ****
032900221104     C                   movel(P)  macnam1       d_accnam
033000221104     C                   movel(P)  maacode       d_aacod
0331002211040107  *                                                                     ****
033200221104     C     maacode       chain     aacode                             29
033300221104     C                   if        *IN29 = '0'
033400221104     C                   movel(P)  alnam         d_aalnm
033500221104     C                   movel(P)  afnam         d_aafnm
0336002211040296 C                   endif
0337002211040107  *                                                                     ****
0338002211010107  *                                                                     ****
033900221101     C     lssnn         chain     member                             23
034000221101     C                   if        *IN23 = '1'
0341002211010107  *      Member Rec Missing                                             ****
034200221101     C                   movel     '**MEMBER REC'd_fldnam
034300221101     C                   eval      d_sts = 'M'
0344002211090107  *                                                                     ****
034500221110     C                   eval      etermn = 0
034600221111     C                   if        l1_termdt <> *blanks
0347002211110296 C                   move      l1_termdt     etermn
0348002211100296 C                   endif
0349002211100107  *                                                                     ****
035000221110     C                   if        etermn > today
0351002211100107  *                                                                     ****
035200221109     C     easkey        chain     easedscl2                          42
035300221109     C                   if        *IN42 = '1'
035400221109     C                   write     r_easedsc
0355002211090296 C                   endif
0356002211090107  *                                                                     ****
0357002211100296 C                   endif
0358002211100107  *                                                                     ****
0359002211010296 C                   iter
0360002211010296 C                   endif
0361002211010107  *                                                                     ****
036200221103      *       Set all input demo values to upper case
036300221103     C                   movel     inrec         upstr
036400221103     C                   CALL      'UTLUPLW'
036500221103     C                   PARM                    uprqs
036600221103     C                   PARM                    uprtn
036700221103     C                   PARM                    upstr
036800221103     C                   movel(P)  upstr         inrec
036900221103      *
0370002211010107  *      Compare Member fields                                          ****
0371002211010107  *         Account#                                                    ****
0372002211010296 C                   If        l1_trst <> mbtrst or
0373002211010296 C                             l1_sub# <> mbsub# or
0374002211010296 C                             l1_acct <> mbacct
037500221121      *      Check Related Accounts file
037600221121     C     relkym        chain     acrelatp                           51
037700221121     C                   if        *IN51 = '1'
037800221121     C     relkym2       chain     acrelatp                           52
037900221121     C                   if        *IN52 = '1'
0380002211210107  *                                                                     ****
038100221101     C                   movel(P)  'ACCOUNT#'    d_fldnam
038200221102     C                   eval      d_easval = l1tsa
038300221102     C                   eval      d_gbsval = gtsa
038400221101     C                   eval      d_sts = 'D'
0385002211090107  *                                                                     ****
038600221109     C     easkey        chain     easedscl2                          42
038700221109     C                   if        *IN42 = '1'
0388002211090107  *                                                                     ****
038900221109     C     easkey        chain     easedscl2                          42
039000221109     C                   if        *IN42 = '1'
039100221109     C                   write     r_easedsc
0392002211090296 C                   endif
0393002211090107  *                                                                     ****
0394002211090296 C                   endif
0395002211090107  *                                                                     ****
0396000303310296 C                   endif
0397002211210296 C                   endif
0398002211210296 C                   endif
0399002211010107  *           Mbr in Long Name file?                                    ****
040000221101     C                   movel(P)  mfname        firstn
040100221101     C                   movel(P)  mlname        lastn
040200221101     C                   eval      sq# = 0
040300221101     C     c100key       chain     cfs100p                            24
040400221101     C                   if        *IN24 = '0'
040500221101     C                   movel(P)  cfsfst        firstn
040600221101     C                   movel(P)  cfslst        lastn
0407002211010296 C                   endif
0408002211010107  *         Last Name                                                   ****
0409002211010296 C                   If        l1_lname <> lastn
041000221109     C                   movel(P)  'Last Name'   d_fldnam
0411002211090107  *          Remove Punctuation then check                              ****
041200221109br02       X_LName = EdtString(l1_LName:'NAME');
0413002211100296 C                   If        X_Lname <> lastn
041400221101     C                   movel(P)  l1_lname      d_easval
041500221101     C                   movel(P)  lastn         d_gbsval
041600221101     C                   eval      d_sts = 'D'
0417002211090107  *                                                                     ****
041800221109     C     easkey        chain     easedscl2                          42
041900221109     C                   if        *IN42 = '1'
042000221109     C                   write     r_easedsc
0421002211090296 C                   endif
0422002211090107  *                                                                     ****
0423002211010296 C                   endif
0424002211100296 C                   endif
0425002211010107  *         First Name                                                  ****
0426002211010296 C                   If        l1_fname <> firstn
042700221109     C                   movel(P)  'First Name'  d_fldnam
0428002211090107  *          Remove Punctuation then check                              ****
042900221109br02       X_FName = EdtString(l1_FName:'NAME');
0430002211090296 C                   If        X_fname = firstn
043100221101     C                   movel(P)  l1_fname      d_easval
043200221101     C                   movel(P)  firstn        d_gbsval
043300221101     C                   eval      d_sts = 'D'
0434002211090107  *                                                                     ****
043500221109     C     easkey        chain     easedscl2                          42
043600221109     C                   if        *IN42 = '1'
043700221109     C                   write     r_easedsc
0438002211090296 C                   endif
0439002211090107  *                                                                     ****
044000221110     C                   endif
0441002211010296 C                   endif
0442002211010107  *         MI                                                          ****
0443002211010296 C                   If        l1_mi <> mmi
044400221101     C                   movel(P)  'MI'          d_fldnam
044500221101     C                   movel(P)  l1_mi         d_easval
044600221101     C                   movel(P)  mmi           d_gbsval
044700221101     C                   eval      d_sts = 'D'
0448002211090107  *                                                                     ****
044900221109     C     easkey        chain     easedscl2                          42
045000221109     C                   if        *IN42 = '1'
045100221109     C                   write     r_easedsc
0452002211090296 C                   endif
0453002211090107  *                                                                     ****
0454002211010296 C                   endif
0455002211010291  *         Address 1
045600221101     C                   movel(P)  addr1         gaddr1
0457002211010296 C                   If        l1_addr1 <> gaddr1
045800221101     C                   movel(P)  'Address 1'   d_fldnam
0459002211090107  *          Remove Punctuation then check                              ****
046000221109br02       X_Addr1 = EdtString(l1_Addr1:'ADDR');
0461002211110296 C                   If        X_Addr1 <> gaddr1
0462002211090296 C                   If        addr131 <> *blanks
046300221109     C                   movel(P)  'Addr1 LEN'   d_fldnam
046400221109     C                   endif
046500221101     C                   movel(P)  l1_addr1      d_easval
046600221101     C                   movel(P)  gaddr1        d_gbsval
046700221101     C                   eval      d_sts = 'D'
0468002211090107  *                                                                     ****
046900221109     C     easkey        chain     easedscl2                          42
047000221109     C                   if        *IN42 = '1'
047100221109     C                   write     r_easedsc
0472002211090296 C                   endif
0473002211090107  *                                                                     ****
0474002211010296 C                   endif
0475002211100296 C                   endif
0476002211010291  *         Address 2
047700221101     C                   movel(P)  addr2         gaddr2
0478002211010296 C                   If        l1_addr2 <> gaddr2
047900221101     C                   movel(P)  'Address 2'   d_fldnam
0480002211090107  *          Remove Punctuation then check                              ****
048100221109br02       X_Addr2 = EdtString(l1_Addr2:'ADDR');
0482002211110296 C                   If        X_Addr2 <> gaddr2
0483002211090296 C                   If        addr231 <> *blanks
048400221109     C                   movel(P)  'Addr2 LEN'   d_fldnam
048500221109     C                   endif
048600221101     C                   movel(P)  l1_addr2      d_easval
048700221101     C                   movel(P)  gaddr2        d_gbsval
048800221101     C                   eval      d_sts = 'D'
0489002211090107  *                                                                     ****
049000221109     C     easkey        chain     easedscl2                          42
049100221109     C                   if        *IN42 = '1'
049200221109     C                   write     r_easedsc
0493002211090296 C                   endif
0494002211090107  *                                                                     ****
049500221110     C                   endif
0496002211010296 C                   endif
0497002211010291  *         City
049800221101     C                   movel(P)  city          gcity
0499002211010296 C                   If        l1_city <> gcity
050000221109     C                   movel(P)  'City'        d_fldnam
0501002211090107  *          Remove Punctuation then check                              ****
050200221109br02       X_City = EdtString(l1_City:'NAME');
0503002211110296 C                   If        X_City <> gcity
0504002211090296 C                   If        city16 <> *blanks
050500221109     C                   movel(P)  'City LEN'    d_fldnam
050600221109     C                   endif
050700221101     C                   movel(P)  l1_city       d_easval
050800221101     C                   movel(P)  gcity         d_gbsval
050900221101     C                   eval      d_sts = 'D'
0510002211090107  *                                                                     ****
051100221109     C     easkey        chain     easedscl2                          42
051200221109     C                   if        *IN42 = '1'
051300221109     C                   write     r_easedsc
0514002211090296 C                   endif
0515002211090107  *                                                                     ****
051600221110     C                   endif
0517002211010296 C                   endif
0518002211010291  *         State
0519002211010296 C                   If        est2 <> state
052000221101     C                   movel(P)  'State'       d_fldnam
052100221101     C                   movel(P)  est2          d_easval
052200221101     C                   movel(P)  state         d_gbsval
052300221101     C                   eval      d_sts = 'D'
0524002211090107  *                                                                     ****
052500221109     C     easkey        chain     easedscl2                          42
052600221109     C                   if        *IN42 = '1'
052700221109     C                   write     r_easedsc
0528002211090296 C                   endif
0529002211090107  *                                                                     ****
0530002211010296 C                   endif
0531002211010291  *         Zip 5
0532002211010296 C                   If        ezip5 <> gzip5
053300221101     C                   movel(P)  'Zip'         d_fldnam
053400221101     C                   movel(P)  ezip5         d_easval
053500221101     C                   movel(P)  gzip5         d_gbsval
053600221101     C                   eval      d_sts = 'D'
0537002211090107  *                                                                     ****
053800221109     C     easkey        chain     easedscl2                          42
053900221109     C                   if        *IN42 = '1'
054000221109     C                   write     r_easedsc
0541002211090296 C                   endif
0542002211090107  *                                                                     ****
0543002211010296 C                   endif
0544002211010291  *         Zip 4
0545002211010296 C                   If        ezip4 = '    '
054600221101     C                   eval      ezip4 = '0000'
0547002211010296 C                   endif
0548002211010296 C                   If        ezip4 <> gzip4
054900221101     C                   movel(P)  'Zip+4'       d_fldnam
055000221101     C                   movel(P)  ezip4         d_easval
055100221101     C                   movel(P)  gzip4         d_gbsval
055200221101     C                   eval      d_sts = 'D'
0553002211090107  *                                                                     ****
055400221109     C     easkey        chain     easedscl2                          42
055500221109     C                   if        *IN42 = '1'
055600221109     C                   write     r_easedsc
0557002211090296 C                   endif
0558002211090107  *                                                                     ****
0559002211010296 C                   endif
0560002211010291  *         Phone
0561002211010296 C                   eval      gph3 = area
056200221101     C                   eval      gph7 = phone
0563002211010296  *
0564002211020296 C                   If        gphone  = '0000000000'
0565002211020296 C                   eval      gphone  = '          '
0566002211020296 C                   endif
0567002211020296 C                   If        l1_phone <> gphone
056800221101     C                   movel(P)  'Phone'       d_fldnam
056900221101     C                   movel(P)  l1_phone      d_easval
057000221101     C                   movel(P)  gphone        d_gbsval
057100221101     C                   eval      d_sts = 'D'
0572002211090107  *                                                                     ****
057300221109     C     easkey        chain     easedscl2                          42
057400221109     C                   if        *IN42 = '1'
057500221109     C                   write     r_easedsc
0576002211090296 C                   endif
0577002211090107  *                                                                     ****
0578002211010296 C                   endif
0579002211010291  *         Sex
0580002211010296 C                   If        l1_gender <> sex
058100221101     C                   movel(P)  'Gender'      d_fldnam
058200221101     C                   movel(P)  l1_gender     d_easval
058300221101     C                   movel(P)  sex           d_gbsval
058400221101     C                   eval      d_sts = 'D'
0585002211090107  *                                                                     ****
058600221109     C     easkey        chain     easedscl2                          42
058700221109     C                   if        *IN42 = '1'
058800221109     C                   write     r_easedsc
0589002211090296 C                   endif
0590002211090107  *                                                                     ****
0591002211010296 C                   endif
0592002211010291  *         DOB
0593002211010296 C                   If        l1_dob <> gbirth
059400221101     C                   movel(P)  'DOB'         d_fldnam
0595002211030296 C                   If        l1_dob = '        '
0596002211030296 C                   eval      d_easval = *blanks
0597002211030296 C                   else
059800221103     C                   movel     l1_dob        wkdatn
059900221103     C                   movel     wkdatn        wkdat
060000221103     C                   eval      usadt = wkdat
060100221103     C                   movel(P)  usadt         d_easval
0602002211030296 C                   endif
0603002211030296 C                   If        birth = 0
0604002211030296 C                   eval      d_gbsval = *blanks
0605002211030296 C                   else
060600221103     C                   movel     birth         wkdat
060700221103     C                   eval      usadt = wkdat
060800221103     C                   movel(P)  usadt         d_gbsval
0609002211030296 C                   endif
061000221101     C                   eval      d_sts = 'D'
0611002211090107  *                                                                     ****
061200221109     C     easkey        chain     easedscl2                          42
061300221109     C                   if        *IN42 = '1'
061400221109     C                   write     r_easedsc
0615002211090296 C                   endif
0616002211090107  *                                                                     ****
0617002211010296 C                   endif
0618002211010291  *         DOH
0619002211010296 C                   If        l1_doh <> gdoh
062000221101     C                   movel(P)  'DOH'         d_fldnam
0621002211030296 C                   If        l1_doh = '        '
0622002211030296 C                   eval      d_easval = *blanks
0623002211030296 C                   else
062400221103     C                   movel     l1_doh        wkdatn
062500221103     C                   movel     wkdatn        wkdat
062600221103     C                   eval      usadt = wkdat
062700221103     C                   movel(P)  usadt         d_easval
0628002211030296 C                   endif
0629002211030296 C                   If        empdt = 0
0630002211030296 C                   eval      d_gbsval = *blanks
0631002211030296 C                   else
063200221103     C                   movel     empdt         wkdat
063300221103     C                   eval      usadt = wkdat
063400221103     C                   movel(P)  usadt         d_gbsval
0635002211030296 C                   endif
063600221101     C                   eval      d_sts = 'D'
0637002211090107  *                                                                     ****
063800221109     C     easkey        chain     easedscl2                          42
063900221109     C                   if        *IN42 = '1'
064000221109     C                   write     r_easedsc
0641002211090296 C                   endif
0642002211090107  *                                                                     ****
0643002211010296 C                   endif
0644002211020291  *         Salary
064500221102     C                   eval      eslda = *blanks
064600221102      *
0647002211020296 C                   If        l1_sal = *blanks
064800221102     C                   eval      esldn = 0
064900221102     C                   else
065000221102      *
065100221102     C                   select
065200221102      *
065300230206     C                   when      esl5 = '.'
065400230206     C                   move      esl14         eslda
065500230206     C                   eval      eslca = esl67
065600230206     C                   when      esl6 = '.'
065700230206     C                   move      esl15         eslda
065800221102     C                   eval      eslca = esl78
065900221102     C                   when      esl7 = '.'
066000221102     C                   move      esl16         eslda
066100221102     C                   eval      eslca = esl89
066200221102     C                   when      esl8 = '.'
066300221104     C                   eval      esl10 = '0'
066400221102     C                   move      esl17         eslda
066500221102     C                   eval      eslca = esl90
066600221103     C                   other
066700221103     C                   eval      esldn = 0
066800221102     C                   endsl
066900221102      *
0670002211020296 C                   If        eslcn >= 50
067100221102     C                   eval      esldn = esldn + 1
067200221102     C                   endif
067300221102      *
067400221102     C                   endif
067500221102      *
0676002211020296 C                   If        esldn <> salary
067700221102     C                   movel(P)  'Salary'      d_fldnam
067800221102     C                   movel(P)  esldn         d_easval
067900221102     C                   movel(P)  salary        d_gbsval
068000221102     C                   eval      d_sts = 'D'
0681002211090107  *                                                                     ****
068200221109     C     easkey        chain     easedscl2                          42
068300221109     C                   if        *IN42 = '1'
068400221109     C                   write     r_easedsc
0685002211090296 C                   endif
0686002211090107  *                                                                     ****
0687002211020296 C                   endif
0688002211020291  *         Term Date
0689002211020296 C                   If        gterm  = '00000000'
0690002211020296 C                   eval      gterm  = '        '
0691002211020296 C                   endif
0692002211020296 C                   If        l1_termdt <> gterm
069300221103     C                   movel(P)  'Term Date'   d_fldnam
0694002211030296 C                   If        l1_termdt = '        '
0695002211030296 C                   eval      d_easval = *blanks
0696002211030296 C                   else
069700221103     C                   movel     l1_termdt     wkdatn
069800221103     C                   movel     wkdatn        wkdat
069900221103     C                   eval      usadt = wkdat
070000221103     C                   movel(P)  usadt         d_easval
0701002211030296 C                   endif
0702002211030296 C                   If        gterm  = '        '
0703002211030296 C                   eval      d_gbsval = *blanks
0704002211030296 C                   else
070500221103     C                   movel     termdt        wkdat
070600221103     C                   eval      usadt = wkdat
070700221103     C                   movel(P)  usadt         d_gbsval
0708002211030296 C                   endif
070900221102     C                   eval      d_sts = 'D'
0710002211110291  *
0711002211110296 C                   If        l1_termdt <> '        '
0712002211110297 C                   movel     l1_termdt     fomn
0713002211110297 C                   movel     fomn          fomiso
0714002211110297 C     fomiso        adddur    1:*M          fomiso
0715002211110297 C                   movel     fomiso        fomn
071600221111     C                   eval      fomdd = 01
0717002211110296 C                   If        foma = gterm
071800221111     C                   movel(P)  'Term DT FOM' d_fldnam
0719002211110296 C                   endif
0720002211110296 C                   endif
0721002211110291  *
0722002211090107  *                                                                     ****
072300221109     C     easkey        chain     easedscl2                          42
072400221109     C                   if        *IN42 = '1'
072500221109     C                   write     r_easedsc
0726002211090296 C                   endif
0727002211090107  *                                                                     ****
0728002211020296 C                   endif
0729002211020291  *         Email
073000221102     C                   movel(P)  gemail        gemail75
0731002211020296 C                   If        l1_email <> gemail75
073200221102     C                   movel(P)  'Email'       d_fldnam
073300221102     C                   movel(P)  l1_email      d_easval
073400221102     C                   movel(P)  gemail75      d_gbsval
073500221102     C                   eval      d_sts = 'D'
0736002211090107  *                                                                     ****
073700221109     C     easkey        chain     easedscl2                          42
073800221109     C                   if        *IN42 = '1'
073900221109     C                   write     r_easedsc
0740002211090296 C                   endif
0741002211090107  *                                                                     ****
0742002211020296 C                   endif
0743002211020291  *         Medicare Y/N
0744002211020296 C                   If        l1_medenrl = ' '
0745002211020296 C                   eval      l1_medenrl = 'N'
0746002211020296 C                   endif
0747002211020296 C                   If        l1_medenrl <> medicr
074800221102     C                   movel(P)  'Medicare'    d_fldnam
074900221102     C                   movel(P)  l1_medenrl    d_easval
075000221102     C                   movel(P)  medicr        d_gbsval
075100221102     C                   eval      d_sts = 'D'
0752002211090107  *                                                                     ****
075300221109     C     easkey        chain     easedscl2                          42
075400221109     C                   if        *IN42 = '1'
075500221109     C                   write     r_easedsc
0756002211090296 C                   endif
0757002211090107  *                                                                     ****
0758002211020296 C                   endif
0759002211020291  *         Medicare#
0760002211020296 C                   If        l1_medicar <> med#
076100221102     C                   movel(P)  'Medicare#'   d_fldnam
076200221102     C                   movel(P)  l1_medicar    d_easval
076300221102     C                   movel(P)  med#          d_gbsval
076400221102     C                   eval      d_sts = 'D'
0765002211090107  *                                                                     ****
076600221109     C     easkey        chain     easedscl2                          42
076700221109     C                   if        *IN42 = '1'
076800221109     C                   write     r_easedsc
0769002211090296 C                   endif
0770002211090107  *                                                                     ****
0771002211020296 C                   endif
077200221102      *  Aux file processing
077300221102      *       SMOKE file
0774002211020291  *         Smoker Y/N
0775002211020296 C                   If        l1_smoker = ' '
0776002211020296 C                   eval      l1_smoker = 'N'
0777002211020296 C                   endif
0778002211020296 C                   eval      gsmoke = 'N'
077900221102     C     c100key       chain     smoke                              25
078000221102     C                   if        *IN25 = '0' and skratefr < today and
078100221102     C                             (skrateto > today or skrateto = 0)
0782002211020296 C                   eval      gsmoke = 'Y'
0783002211020296 C                   endif
0784002211020296 C                   If        l1_smoker <> gsmoke
078500221102     C                   movel(P)  'Smoker'      d_fldnam
078600221102     C                   movel(P)  l1_smoker     d_easval
078700221102     C                   movel(P)  gsmoke        d_gbsval
078800221102     C                   eval      d_sts = 'D'
0789002211090107  *                                                                     ****
079000221109     C     easkey        chain     easedscl2                          42
079100221109     C                   if        *IN42 = '1'
079200221109     C                   write     r_easedsc
0793002211090296 C                   endif
0794002211090107  *                                                                     ****
0795002211020296 C                   endif
079600221102      *      MEMEXTP file
0797002211020291  *
079800221102     C     lssnn         chain     memextp                            26
0799002211020296 C                   If        *in26 = '0'
0800002211020291  *         Marital Sts
0801002211020296 C                   If        l1_marsts <> memgs
080200221104     C                   movel(P)  'Marital Sts' d_fldnam
080300221102     C                   movel(P)  l1_marsts     d_easval
080400221102     C                   movel(P)  memgs         d_gbsval
080500221102     C                   eval      d_sts = 'D'
0806002211090107  *                                                                     ****
080700221109     C     easkey        chain     easedscl2                          42
080800221109     C                   if        *IN42 = '1'
080900221109     C                   write     r_easedsc
0810002211090296 C                   endif
0811002211090107  *                                                                     ****
0812002211020296 C                   endif
0813002211090291  *         Race
0814002211020296 C                   If        l1_race <> merace
081500221102     C                   movel(P)  'Race'        d_fldnam
081600221102     C                   movel(P)  l1_race       d_easval
081700221102     C                   movel(P)  merace        d_gbsval
081800221102     C                   eval      d_sts = 'D'
0819002211090107  *                                                                     ****
082000221109     C     easkey        chain     easedscl2                          42
082100221109     C                   if        *IN42 = '1'
082200221109     C                   write     r_easedsc
0823002211090296 C                   endif
0824002211090107  *                                                                     ****
0825002211020296 C                   endif
0826002211020291  *         Job Title
0827002211020296 C                   If        l1_jobtitl <> meocc
082800221102     C                   movel(P)  'Job Title'   d_fldnam
082900221102     C                   movel(P)  l1_jobtitl    d_easval
083000221102     C                   movel(P)  meocc         d_gbsval
083100221102     C                   eval      d_sts = 'D'
0832002211090107  *                                                                     ****
083300221109     C     easkey        chain     easedscl2                          42
083400221109     C                   if        *IN42 = '1'
083500221109     C                   write     r_easedsc
0836002211090296 C                   endif
0837002211090107  *                                                                     ****
0838002211020296 C                   endif
083900221102      *
0840002211020296 C                   endif
084100221109      *
0842000204050296 C                   enddo
0843002211070291  *
0844002211070291  * Process Dependent Data
0845002211070291  *
0846002212010297 C     *LOVAL        setll     GBS3DPRPP
0847002211070296 C                   dou       *in31 = '1'
0848002212010297 C                   read      GBS3DPRPP                              31
0849002211070296 C                   If        *in31 = '1'
0850002211070296 C                   leave
0851002211070296 C                   endif
085200221107      *
0853002405170296 C                   If        l3_rpsts <> ' ' or l3_depseq# = '   ' or
0854002211300296 C                             l3_trst = 667 or l3_recdate <> easedt
0855002211070296 C                   iter
0856002211070296 C                   endif
085700221108      *    Debug shit
0858002211080296 C                   If        l3_partssn = '290866817'
0859002211080296 C                   eval      l3_partssn = l3_partssn
0860002211080296 C                   endif
086100221107      *
0862002211210107  *      Set Dep/Acct default fields for disc recs                      ****
086300221107     C                   clear                   r_easedsc
086400221107     C                   eval      d_datrec = l3_recdate
086500221107     C                   eval      d_datfnd = today
086600221107      *  Depend defaults
086700221107     C                   movel     l3_partssn    d_ssn
086800221107     C                   eval      d_seq = eds1
0869002211070296 C                   if        eds2 <> ' '
087000221107     C                   eval      d_seq = eds12
087100221107     C                   endif
087200221107     C                   movel     l3_fname      d_fname
087300221107     C                   movel     l3_lname      d_lname
087400221107      *  Account data
087500221107     C                   eval      d_trst = l3_trst
087600221107     C                   eval      d_sub# = l3_sub#
087700221107     C                   eval      d_acct = l3_acct
087800221107     C     acckeyd       chain     accmst                             32
087900221107     C                   if        *IN32 = '1'
088000221107     C                   movel     '**ACCMST REC'd_fldnam
088100221107     C                   eval      d_sts = 'A'
0882002211090107  *                                                                     ****
088300221109     C     easkey        chain     easedscl2                          42
088400221109     C                   if        *IN42 = '1'
088500221109     C                   write     r_easedsc
0886002211090296 C                   endif
0887002211090107  *                                                                     ****
0888002211070296 C                   iter
0889002211070296 C                   endif
0890002211070107  *                                                                     ****
089100221107     C                   movel(P)  macnam1       d_accnam
089200221107     C                   movel(P)  maacode       d_aacod
0893002211070107  *                                                                     ****
089400221107     C     maacode       chain     aacode                             39
089500221107     C                   if        *IN39 = '0'
089600221107     C                   movel(P)  alnam         d_aalnm
089700221107     C                   movel(P)  afnam         d_aafnm
0898002211070296 C                   endif
0899002211070107  *                                                                     ****
0900002211070107  *                                                                     ****
090100221107     C     depkey        chain     depndc                             33
090200221107     C                   if        *IN33 = '1'
0903002211110107  *      Depend Rec Missing                                             ****
090400221107     C                   movel     '**DEPEND REC'd_fldnam
090500221107     C                   eval      d_sts = 'M'
0906002211110107  *                                                                     ****
090700221111     C                   eval      etermn = 0
090800221111     C                   if        l3_termdt <> *blanks
0909002211110296 C                   move      l3_termdt     etermn
0910002211110296 C                   endif
0911002211110107  *                                                                     ****
091200221111     C                   if        etermn > today
0913002211110107  *                                                                     ****
091400221109     C     easkey        chain     easedscl2                          42
091500221109     C                   if        *IN42 = '1'
091600221109     C                   write     r_easedsc
0917002211090296 C                   endif
0918002211090107  *                                                                     ****
0919002211110296 C                   endif
0920002211110107  *                                                                     ****
0921002211070296 C                   iter
0922002211070296 C                   endif
0923002211070107  *                                                                     ****
092400221107      *
0925002211070107  *      Compare Depend fields                                          ****
0926002211210107  *           Dep in Long Name file?                                    ****
092700221107     C                   movel(P)  dfname        firstn
092800221107     C                   movel(P)  dlname        lastn
092900221107     C                   eval      sq# = 0
093000221107     C     depkey        chain     cfs100p                            24
093100221107     C                   if        *IN24 = '0'
093200221107     C                   movel(P)  cfsfst        firstn
093300221107     C                   movel(P)  cfslst        lastn
0934002211070296 C                   endif
0935002211070107  *         Last Name                                                   ****
0936002211070296 C                   If        l3_lname <> lastn
093700221107     C                   movel(P)  'Last Name'   d_fldnam
0938002211090107  *          Remove Punctuation then check                              ****
093900221109br02       X_LName = EdtString(l3_LName:'NAME');
0940002211090296 C                   If        X_Lname = lastn
094100221107     C                   movel(P)  l3_lname      d_easval
094200221107     C                   movel(P)  lastn         d_gbsval
094300221107     C                   eval      d_sts = 'D'
0944002211090107  *                                                                     ****
094500221109     C     easkey        chain     easedscl2                          42
094600221109     C                   if        *IN42 = '1'
094700221109     C                   write     r_easedsc
0948002211090296 C                   endif
0949002211090107  *                                                                     ****
095000221110     C                   endif
0951002211070296 C                   endif
0952002211070107  *         First Name                                                  ****
0953002211070296 C                   If        l3_fname <> firstn
095400221107     C                   movel(P)  'First Name'  d_fldnam
0955002211090107  *          Remove Punctuation then check                              ****
095600221109br02       X_FName = EdtString(l3_FName:'NAME');
0957002211090296 C                   If        X_Fname = firstn
095800221107     C                   movel(P)  l3_fname      d_easval
095900221107     C                   movel(P)  firstn        d_gbsval
096000221107     C                   eval      d_sts = 'D'
0961002211090107  *                                                                     ****
096200221109     C     easkey        chain     easedscl2                          42
096300221109     C                   if        *IN42 = '1'
096400221109     C                   write     r_easedsc
0965002211090296 C                   endif
0966002211090107  *                                                                     ****
096700221110     C                   endif
0968002211070296 C                   endif
0969002211070107  *         MI                                                          ****
0970002211070296 C                   If        l3_mi <> dmi
097100221107     C                   movel(P)  'MI'          d_fldnam
097200221107     C                   movel(P)  l3_mi         d_easval
097300221107     C                   movel(P)  dmi           d_gbsval
097400221107     C                   eval      d_sts = 'D'
0975002211090107  *                                                                     ****
097600221109     C     easkey        chain     easedscl2                          42
097700221109     C                   if        *IN42 = '1'
097800221109     C                   write     r_easedsc
0979002211090296 C                   endif
0980002211090107  *                                                                     ****
0981002211070296 C                   endif
0982002211070291  *         Address 1
098300221107     C                   movel(P)  daddr1        gaddr1
0984002211070296 C                   If        l3_addr1 <> gaddr1
098500221107     C                   movel(P)  'Address 1'   d_fldnam
0986002211090107  *          Remove Punctuation then check                              ****
098700221109br02       X_addr1 = EdtString(l3_addr1:'ADDR');
0988002211110296 C                   If        X_addr1 <> gaddr1
0989002211090296 C                   If        addr131 <> *blanks
099000221109     C                   movel(P)  'Addr1 LEN'   d_fldnam
099100221109     C                   endif
099200221107     C                   movel(P)  l3_addr1      d_easval
099300221107     C                   movel(P)  gaddr1        d_gbsval
099400221107     C                   eval      d_sts = 'D'
0995002211090107  *                                                                     ****
099600221109     C     easkey        chain     easedscl2                          42
099700221109     C                   if        *IN42 = '1'
099800221109     C                   write     r_easedsc
0999002211090296 C                   endif
1000002211090107  *                                                                     ****
100100221110     C                   endif
1002002211070296 C                   endif
1003002211070291  *         Address 2
100400221107     C                   movel(P)  daddr2        gaddr2
1005002211070296 C                   If        l3_addr2 <> gaddr2
100600221107     C                   movel(P)  'Address 2'   d_fldnam
1007002211090107  *          Remove Punctuation then check                              ****
100800221109br02       X_addr2 = EdtString(l3_addr2:'ADDR');
1009002211110296 C                   If        X_addr2 <> gaddr2
1010002211090296 C                   If        addr231 <> *blanks
101100221109     C                   movel(P)  'Addr2 LEN'   d_fldnam
101200221109     C                   endif
101300221107     C                   movel(P)  l3_addr2      d_easval
101400221107     C                   movel(P)  gaddr2        d_gbsval
101500221107     C                   eval      d_sts = 'D'
1016002211090107  *                                                                     ****
101700221109     C     easkey        chain     easedscl2                          42
101800221109     C                   if        *IN42 = '1'
101900221109     C                   write     r_easedsc
1020002211090296 C                   endif
1021002211090107  *                                                                     ****
102200221110     C                   endif
1023002211070296 C                   endif
1024002211070291  *         City
102500221107     C                   movel(P)  dcity         gcity
1026002211070296 C                   If        l3_city <> gcity
102700221107     C                   movel(P)  'City'        d_fldnam
1028002211090107  *          Remove Punctuation then check                              ****
102900221109br02       X_city = EdtString(l3_city:'NAME');
1030002211110296 C                   If        X_city <> gcity
1031002211090296 C                   If        city16 <> *blanks
103200221109     C                   movel(P)  'City LEN'    d_fldnam
103300221109     C                   endif
103400221107     C                   movel(P)  l3_city       d_easval
103500221107     C                   movel(P)  gcity         d_gbsval
103600221107     C                   eval      d_sts = 'D'
1037002211090107  *                                                                     ****
103800221109     C     easkey        chain     easedscl2                          42
103900221109     C                   if        *IN42 = '1'
104000221109     C                   write     r_easedsc
1041002211090296 C                   endif
1042002211090107  *                                                                     ****
104300221110     C                   endif
1044002211070296 C                   endif
1045002211070291  *         State
1046002211070296 C                   If        dst2 <> dstate
104700221107     C                   movel(P)  'State'       d_fldnam
104800221107     C                   movel(P)  dst2          d_easval
104900221107     C                   movel(P)  dstate        d_gbsval
105000221107     C                   eval      d_sts = 'D'
1051002211090107  *                                                                     ****
105200221109     C     easkey        chain     easedscl2                          42
105300221109     C                   if        *IN42 = '1'
105400221109     C                   write     r_easedsc
1055002211090296 C                   endif
1056002211090107  *                                                                     ****
1057002211070296 C                   endif
1058002211070291  *         Zip 5
1059002211070296 C                   If        ezip5d <> gzip5d
106000221107     C                   movel(P)  'Zip'         d_fldnam
106100221107     C                   movel(P)  ezip5d        d_easval
106200221107     C                   movel(P)  gzip5d        d_gbsval
106300221107     C                   eval      d_sts = 'D'
1064002211090107  *                                                                     ****
106500221109     C     easkey        chain     easedscl2                          42
106600221109     C                   if        *IN42 = '1'
106700221109     C                   write     r_easedsc
1068002211090296 C                   endif
1069002211090107  *                                                                     ****
1070002211070296 C                   endif
1071002211070291  *         Zip 4
1072002211070296 C                   If        ezip4d = '    '
107300221107     C                   eval      ezip4d = '0000'
1074002211070296 C                   endif
1075002211070296 C                   If        ezip4d <> gzip4d
107600221107     C                   movel(P)  'Zip+4'       d_fldnam
107700221107     C                   movel(P)  ezip4d        d_easval
107800221107     C                   movel(P)  gzip4d        d_gbsval
107900221107     C                   eval      d_sts = 'D'
1080002211090107  *                                                                     ****
108100221109     C     easkey        chain     easedscl2                          42
108200221109     C                   if        *IN42 = '1'
108300221109     C                   write     r_easedsc
1084002211090296 C                   endif
1085002211090107  *                                                                     ****
1086002211070296 C                   endif
1087002211070291  *         Sex
1088002211070296 C                   If        l3_gender <> dsex
108900221107     C                   movel(P)  'Gender'      d_fldnam
109000221107     C                   movel(P)  l3_gender     d_easval
109100221107     C                   movel(P)  dsex          d_gbsval
109200221107     C                   eval      d_sts = 'D'
1093002211090107  *                                                                     ****
109400221109     C     easkey        chain     easedscl2                          42
109500221109     C                   if        *IN42 = '1'
109600221109     C                   write     r_easedsc
1097002211090296 C                   endif
1098002211090107  *                                                                     ****
1099002211070296 C                   endif
1100002211070291  *         DOB
1101002211070296 C                   If        l3_dob <> gbirthd
110200221107     C                   movel(P)  'DOB'         d_fldnam
1103002211070296 C                   If        l3_dob = '        '
1104002211070296 C                   eval      d_easval = *blanks
1105002211070296 C                   else
110600221107     C                   movel     l3_dob        wkdatn
110700221107     C                   movel     wkdatn        wkdat
110800221107     C                   eval      usadt = wkdat
110900221107     C                   movel(P)  usadt         d_easval
1110002211070296 C                   endif
1111002211070296 C                   If        dbirth = 0
1112002211070296 C                   eval      d_gbsval = *blanks
1113002211070296 C                   else
111400221107     C                   movel     dbirth        wkdat
111500221107     C                   eval      usadt = wkdat
111600221107     C                   movel(P)  usadt         d_gbsval
1117002211070296 C                   endif
111800221107     C                   eval      d_sts = 'D'
1119002211090107  *                                                                     ****
112000221109     C     easkey        chain     easedscl2                          42
112100221109     C                   if        *IN42 = '1'
112200221109     C                   write     r_easedsc
1123002211090296 C                   endif
1124002211090107  *                                                                     ****
1125002211070296 C                   endif
1126002211070291  *         Dep SSN
1127002211070296 C                   If        l3_depssn = '000000000'
1128002211070296 C                   eval      l3_depssn = '        0'
1129002211070296 C                   endif
1130002211080296 C                   If        gdssn = '000000000'
1131002211080296 C                   eval      gdssn = '        0'
1132002211080296 C                   endif
1133002211070296 C                   If        l3_depssn <> gdssn
113400221107     C                   movel(P)  'Dep SSN'     d_fldnam
113500221107     C                   movel(P)  l3_depssn     d_easval
113600221107     C                   movel(P)  gdssn         d_gbsval
113700221107     C                   eval      d_sts = 'D'
1138002211090107  *                                                                     ****
113900221109     C     easkey        chain     easedscl2                          42
114000221109     C                   if        *IN42 = '1'
114100221109     C                   write     r_easedsc
1142002211090296 C                   endif
1143002211090107  *                                                                     ****
1144002211080296 C                   endif
1145002211080291  *         Student Y/N
1146002211080296 C                   If        (l3_studnt = 'F' and
1147002211080296 C                             dstudn <> 'Y') or
1148002211080296 C                             (l3_studnt <> 'F' and
1149002211080296 C                             dstudn = 'Y')
115000221108     C                   movel(P)  'Student'     d_fldnam
115100221108     C                   movel(P)  l3_studnt     d_easval
115200221108     C                   movel(P)  dstudn        d_gbsval
115300221108     C                   eval      d_sts = 'D'
1154002211090107  *                                                                     ****
115500221109     C     easkey        chain     easedscl2                          42
115600221109     C                   if        *IN42 = '1'
115700221109     C                   write     r_easedsc
1158002211090296 C                   endif
1159002211090107  *                                                                     ****
1160002211080296 C                   endif
1161002211080291  *         Disabled Y/N
1162002211080296 C                   If        (l3_disabld = 'Y' and
1163002211080296 C                             dhndcp = ' ') or
1164002211080296 C                             (l3_disabld <> 'Y' and
1165002211080296 C                             dhndcp <> ' ')
116600221108     C                   movel(P)  'Disabled'    d_fldnam
116700221108     C                   movel(P)  l3_disabld    d_easval
116800221108     C                   movel(P)  dhndcp        d_gbsval
116900221108     C                   eval      d_sts = 'D'
1170002211090107  *                                                                     ****
117100221109     C     easkey        chain     easedscl2                          42
117200221109     C                   if        *IN42 = '1'
117300221109     C                   write     r_easedsc
1174002211090296 C                   endif
1175002211090107  *                                                                     ****
1176002211070296 C                   endif
1177002211080291  *         Medicare Y/N
1178002211080296 C                   If        (l3_medenrl = 'Y' and
1179002211080296 C                             dmedcr <> 'Y') or
1180002211080296 C                             (l3_medenrl <> 'Y' and
1181002211080296 C                             dmedcr = 'Y')
118200221108     C                   movel(P)  'Medicare Y/N'd_fldnam
118300221108     C                   movel(P)  l3_medenrl    d_easval
118400221108     C                   movel(P)  dmedcr        d_gbsval
118500221107     C                   eval      d_sts = 'D'
1186002211090107  *                                                                     ****
118700221109     C     easkey        chain     easedscl2                          42
118800221109     C                   if        *IN42 = '1'
118900221109     C                   write     r_easedsc
1190002211090296 C                   endif
1191002211090107  *                                                                     ****
1192002211070296 C                   endif
119300221107      *
1194002211080291  *         Medicare
1195002211080296 C                   If        l3_medicar <> dmed#
119600221108     C                   movel(P)  'Medicare#'   d_fldnam
119700221108     C                   movel(P)  l3_medicar    d_easval
119800221108     C                   movel(P)  dmed#         d_gbsval
119900221108     C                   eval      d_sts = 'D'
1200002211090107  *                                                                     ****
120100221109     C     easkey        chain     easedscl2                          42
120200221109     C                   if        *IN42 = '1'
120300221109     C                   write     r_easedsc
1204002211090296 C                   endif
1205002211090107  *                                                                     ****
1206002211080296 C                   endif
120700221108      *
1208002211070296 C                   enddo
120900020405      *
1210000204050296 C                   movel     '1'           *inlr
1211000204050296 C                   return
