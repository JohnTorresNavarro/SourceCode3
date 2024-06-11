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
0020002212170020 FMCOVC16   IF   E           K DISK
0021002211020020 FSMOKE     IF   E           K DISK
0022002211040020 FAACODE    IF   E           K DISK
0023002211210020 FACRELATP  IF   E           K DISK
0024002211090020 FEASEDSCP  O    E             DISK
0025002211090020 FEASEDSCL2 IF   E           K DISK    RENAME(R_EASEDSC:X_EADSC)
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
0046002211100250 D                 DS
0047002211100251 D  l3_partssn             1      9
0048002211100251 D   dssnn                 1      9  0
0049002211070029  *
0050002211070250 D                 DS
0051002211070251 D  l3_depseq#             1      3
0052002211070251 D   eds1                  1      1  0
0053002211070251 D   eds2                  2      2
0054002211070251 D   eds12                 1      2  0
0055002211070029  *
0056002211070250 D                 DS
0057002211070251 D  depss#                 1      9  0
0058002211070251 D   gdssn                 1      9
0059002211020029  * GBS TSA
0060002211010250 D                 DS
0061002211020251 D  gtsa                   1     10
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
0076002212170251 D  l2_volamt              1     11
0077002211020251 D   esl15                 1      5
0078002211020251 D   esl16                 1      6
0079002211020251 D   esl17                 1      7
0080002211020251 D   esl6                  6      6
0081002211020251 D   esl7                  7      7
0082002211020251 D   esl8                  8      8
0083002211040251 D   esl9                  9      9
0084002211040251 D   esl10                10     10
0085002211020251 D   esl78                 7      8
0086002211020251 D   esl89                 8      9
0087002211020251 D   esl90                 9     10
0088002211010029  *
0089002211020250 D                 DS
0090002211020251 D  eslda                  1      9
0091002211020251 D   esldn                 1      9S 0
0092002211020251 D  eslca                 10     11
0093002211020251 D   eslcn                10     11S 0
0094002211020029  *
0095002211010250 D                 DS
0096002211010251 D  gphone                 1     10
0097002211010251 D   gph3                  1      3S 0
0098002211010251 D   gph7                  4     10S 0
0099002211010029  *
0100002211010250 D                 DS
0101002211110251 D  fomn                   1      8S 0
0102002211110251 D   fomdd                 7      8s 0
0103002211110251 D  foma                   1      8
0104002211110029  *
0105002211010250 D                 DS
0106002212170251 D  enrldt                 1      8S 0
0107002212170251 D   geff                  1      8
0108002211020029  *
0109002211020250 D                 DS
0110002212170251 D  candt                  1      8S 0
0111002211020251 D   gterm                 1      8
0112002211090029  *
0113002211090250 D                 DS
0114002211090251 D  x_city                 1     30
0115002211090251 D   city16               16     30
0116002211090029  *
0117000505250250 D                 DS
0118000505250251 D  hldkey                 1     11  0
0119001008050251 D   fhmid#                1      9  0
0120002211070251 D   fhseq#               10     11  0
012100221107      *
012200221107     D                 DS
012300221107     D  inrec                  1    141
012400221107     D   l1_email              1     75
0125002211070251 D  fill66                76    141
012600221107     D   gemail               76    140
0127002211070029  *
0128002211070250 D                 DS
012900221107     D  ISOToday       S               d     inz
013000221107     D  Today          S              8S 0   inz
0131002211100251 D  etermn         S              8S 0
0132002211070251 D  cutoff         S               D   DATFMT(*ISO)
0133002211110251 D  fomiso         S               D   DATFMT(*ISO)
0134002211300251 D  calcdate       S               D   DATFMT(*ISO)
0135002211070251 D  cutofn         S              8S 0
0136002211300251 D  easedt         S              8S 0
0137002211070251 D  wkdatn         S              8S 0
013800221107     D  wkdat          S               D
013900221103     D  usadt          S               D   DATFMT(*USA/)
014000221103     D  datrec         S             10
014100221103     D  datfnd         S             10
0142002211300251 D  edays          S              2S 0
0143002211300251 D  sq#            S              2S 0
0144002211030251 D  esal           S              9S 0
014500221121     D  fdot           S              1    inz('F')
0146002211010251 D  firstn         S             25
0147002211010251 D  lastn          S             35
0148002211010251 D  gaddr1         S             40
0149002211010251 D  gaddr2         S             40
0150002211010251 D  gcity          S             30
0151002212150251 D  kyplan         S            100
0152002211020251 D  gsmoke         S              1
0153001310070037 D sysdateymd      S               d   datfmt(*iso)
015400221101     D  wkday          S               D     inz
0155000809040029  *
0156000809040250 D                 DS
015700080904     D  gbdate                 1      8  0
015800080904     D   gbyr                  1      4  0
015900080904     D   gbmo                  5      6  0
016000080904     D   gbdy                  7      8  0
0161000809040111  *
016200221109      *--------------------------------------------
016300221109      * Procedures
016400221109      *--------------------------------------------
016500221109     D/COPY *LIBL/QMODSRC,#EdtStngPR           // Edit String
016600221130
016700221130      /define Copy_all_protos_and_fields
016800221130      /copy qcpysrc,datsrvpgmp
016900221130      /Undefine Copy_all_protos_and_fields
017000221130
017100221109
017200110419      *
017300221101     C     acckey        klist
017400221215     C                   kfld                    l2_trst
017500221215     C                   kfld                    l2_sub#
017600221215     C                   kfld                    l2_acct
017700221217      *
017800221217     C     mc16ky        klist
017900221217     C                   kfld                    l2_trst
018000221217     C                   kfld                    l2_sub#
018100221217     C                   kfld                    l2_acct
018200221217     C                   kfld                    lssnn
018300221217     C                   kfld                    kyplan
018400221107      *
018500221121     C     relkym        klist
018600221121     C                   kfld                    fdot
018700221215     C                   kfld                    l2_trst
018800221215     C                   kfld                    l2_sub#
018900221215     C                   kfld                    l2_acct
019000221121     C                   kfld                    mbtrst
019100221121     C                   kfld                    mbsub#
019200221121     C                   kfld                    mbacct
019300221121      *
019400221121     C     relkym2       klist
019500221121     C                   kfld                    fdot
019600221121     C                   kfld                    mbtrst
019700221121     C                   kfld                    mbsub#
019800221121     C                   kfld                    mbacct
019900221215     C                   kfld                    l2_trst
020000221215     C                   kfld                    l2_sub#
020100221215     C                   kfld                    l2_acct
020200221121      *
020300221107     C     acckeyd       klist
020400221107     C                   kfld                    l3_trst
020500221107     C                   kfld                    l3_sub#
020600221107     C                   kfld                    l3_acct
020700221107      *
020800221107     C     depkey        klist
020900221208     C                   kfld                    c_ssn
021000221208     C                   kfld                    c_seq
021100221109      *
021200221109     C     easkey        klist
021300221208     C                   kfld                    c_ssn
021400221208     C                   kfld                    c_seq
021500221208     C                   kfld                    c_fldnam
021600221208     C                   kfld                    c_datrec
021700091014      *
021800080904      *
0219002211010291  * CALCULATE DATE TO USE - 3 BUS DAYS PRIOR TO TODAY !!!!!
022000080904     C                   move      udate         ISOtoday
022100080904     C                   move      ISOtoday      today
022200221130     C                   eval      calcdate =ISOtoday
0223002211300291  * Determine EASE file date to run
022400221130     C                   eval      edays = 0
0225002211300296 C                   dou       edays = 4
0226002211300297 C     calcdate      subdur    1:*D          calcdate
022700221130     C                   if        #get_dow(calcdate) <> 'Sunday' and
022800221130     C                             #get_dow(calcdate) <> 'Saturday'
022900221130     C                   eval      edays = edays + 1
023000221130     C                   endif
023100221130     C                   enddo
023200221130      *
023300221130     C                   movel     calcdate      easedt
023400080904      *
023500221103     C                   eval      uprqs = '*UPPER  '
023600221103      *
0237002211010291  * Main Line - Compare Member fields
0238002212150297 C     *LOVAL        setll     GBS3MCRPP
0239002211210296 C                   dou       *in21 = '1'
0240002212150297 C                   read      GBS3CBRPP                              21
0241002211210296 C                   If        *in21 = '1'
0242002211210296 C                   leave
0243002211210296 C                   endif
024400221121      *
0245002212150296 C                   If        l2_rpsts <> ' ' or
0246002212150296 C                             l2_trst = 667 or l2_recdate <> easedt
0247002211010296 C                   iter
0248000807210296 C                   endif
024900221215      *       See if plan is in Cross Ref file
025000221215     C                   movel     l2_plan       kyplan
025100221215     C     kyplan        chain     planxrefl2                         20
025200221215     C                   if        *IN20 = '1'
0253002212150296 C                   iter
0254002212150296 C                   endif
025500221101      *
0256002211010107  *      Set Mbr/Acct default fields for disc recs                      ****
025700221215     C                   clear                   r_easecds
025800221215     C                   eval      c_datrec = l2_recdate
025900221208     C                   eval      c_datfnd = today
026000221101      *  Member defaults
026100221215     C                   movel     l2_ssn        c_ssn
026200221208     C                   eval      c_seq = 0
026300221101      *  Account data
026400221215     C                   eval      c_trst = l2_trst
026500221215     C                   eval      c_sub# = l2_sub#
026600221215     C                   eval      c_acct = l2_acct
026700221101     C     acckey        chain     accmst                             22
026800221101     C                   if        *IN22 = '1'
026900221208     C                   movel     '**ACCMST REC'c_fldnam
027000221208     C                   eval      c_sts = 'A'
0271002211090107  *                                                                     ****
027200221215     C     easkey        chain     easecdsl2                          42
027300221109     C                   if        *IN42 = '1'
027400221215     C                   write     r_easecds
0275002211090296 C                   endif
0276002211210107  *                                                                     ****
0277002211010296 C                   iter
0278002211010296 C                   endif
0279002211010107  *                                                                     ****
028000221208     C                   movel(P)  macnam1       c_accnam
028100221216     C                   movel(P)  maacode       c_aacod
0282002212160107  *                                                                     ****
028300221216     C     maacode       chain     aacode                             29
028400221216     C                   if        *IN29 = '0'
028500221216     C                   movel(P)  alnam         c_aalnm
028600221216     C                   movel(P)  afnam         c_aafnm
0287002212160296 C                   endif
0288002212160107  *                                                                     ****
0289002212160107  *                                                                     ****
029000221216     C     lssnn         chain     member                             23
029100221216     C                   if        *IN23 = '1'
0292002212160107  *      Member Rec Missing                                             ****
029300221216     C                   movel     '**MEMBER REC'c_fldnam
029400221216     C                   eval      c_sts = 'M'
0295002212160107  *                                                                     ****
029600221216     C                   eval      etermn = 0
029700221217     C                   if        l2_termdt <> *blanks
0298002212170296 C                   move      l2_termdt     etermn
0299002211100296 C                   endif
0300002211100107  *                                                                     ****
030100221110     C                   if        etermn > today
0302002211100107  *                                                                     ****
030300221215     C     easkey        chain     easecdsl2                          42
030400221109     C                   if        *IN42 = '1'
030500221217     C                   write     r_easecds
0306002211090296 C                   endif
0307002211090107  *                                                                     ****
0308002211100296 C                   endif
0309002211100107  *                                                                     ****
0310002211010296 C                   iter
0311002212080296 C                   endif
031200221103      *
0313002212080107  *      Compare Member fields                                          ****
0314002212080107  *         Account#                                                    ****
0315002212150296 C                   If        l2_trst <> mbtrst or
0316002212150296 C                             l2_sub# <> mbsub# or
0317002212150296 C                             l2_acct <> mbacct
031800221121      *      Check Related Accounts file
031900221208     C     relkym        chain     acrelatp                           51
032000221121     C                   if        *IN51 = '1'
032100221121     C     relkym2       chain     acrelatp                           52
032200221121     C                   if        *IN52 = '1'
0323002211210107  *                                                                     ****
032400221208     C                   movel(P)  'ACCOUNT#'    c_fldnam
032500221215     C                   eval      c_easval = l2tsa
032600221208     C                   eval      c_gbsval = gtsa
032700221208     C                   eval      c_sts = 'D'
0328002211090107  *                                                                     ****
032900221215     C     easkey        chain     easecdsl2                          42
033000221207     C                   if        *IN42 = '1'
033100221217     C                   write     r_easecds
0332002212070296 C                   endif
0333002212070107  *                                                                     ****
0334000303310296 C                   endif
0335002212070296 C                   endif
0336002211210296 C                   endif
0337002212170107  *                                                                     ****
0338002212170291  *      Look for EASE Plan in MCOV recs - There can be multiple
0339002212170291  *          GBS Plans tied to an EASE Input Plan Name
0340002212170107  *                                                                     ****
0341002212170296 C                   eval      plnfnd = 'N'
0342002212170297 C     kyplan        setll     PLANXREFL2
0343002212170296 C                   dou       *in41 = '1'
0344002212170297 C     kyplan        reade     PLANXREFL2                             41
0345002212170296 C                   If        *in41 = '1'
0346002212170296 C                   leave
0347002212170296 C                   endif
034800221217      *
0349002212170297 C     mc15ky        chain     mcovc16                            52
0350002212170296 C                   If        *in52 = '0'
0351002212170296 C                   eval      plnfnd = 'Y'
0352002212170296 C                   eval      c_plan# = mcplan
0353002212170296 C                   leave
0354002212170296 C                   endif
035500221217      *
0356002212170296 C                   enddo
035700221217      *
0358002212170296 C                   if        plnfnd = 'N'
0359002212170291  *      No Plan Match - create disc rec
036000221217     C                   movel(P)  'Plan ID'     c_fldnam
036100221217     C                   movel(P)  l2_plan       c_easval
036200221217     C                   movel(P)  *blanks       c_gbsval
036300221217     C                   eval      c_sts = 'D'
0364002212170107  *                                                                     ****
036500221217     C     easkey        chain     easecdsl2                          42
036600221217     C                   if        *IN42 = '1'
036700221217     C                   write     r_easecds
0368002212170296 C                   endif
0369002212170107  *                                                                     ****
0370002212170296 C                   iter
0371002212170296 C                   endif
0372002212170107  *                                                                     ****
0373002212170291  *      Plan Match - check other fileds
0374002212170107  *           Eff Date                                                  ****
0375002212170296 C                   If        l2_effdt <> geff
037600221217     C                   movel(P)  'EFF DT'      c_fldnam
0377002212170296 C                   If        l2_effdt = '        '
0378002212170296 C                   eval      c_easval = *blanks
0379002212170296 C                   else
038000221217     C                   movel     l2_effdt      wkdatn
038100221217     C                   movel     wkdatn        wkdat
038200221217     C                   eval      usadt = wkdat
038300221217     C                   movel(P)  usadt         c_easval
0384002212170296 C                   endif
0385002212170296 C                   If        enrldt = 0
0386002212170296 C                   eval      c_gbsval = *blanks
0387002212170296 C                   else
038800221217     C                   movel     enrldt        wkdat
038900221217     C                   eval      usadt = wkdat
039000221217     C                   movel(P)  usadt         c_gbsval
0391002212170296 C                   endif
039200221217     C                   eval      c_sts = 'D'
0393002212170107  *                                                                     ****
039400221217     C     easkey        chain     easedscl2                          42
039500221217     C                   if        *IN42 = '1'
039600221217     C                   write     r_easecds
0397002212170296 C                   endif
0398002212170107  *                                                                     ****
0399002212170296 C                   endif
0400002212170107  *          Term Date                                                  ****
0401002212170296 C                   If        l2_termdt <> gterm
040200221217     C                   movel(P)  'TERM DT'     c_fldnam
0403002212170296 C                   If        l2_termdt = '        '
0404002212170296 C                   eval      c_easval = *blanks
0405002212170296 C                   else
040600221217     C                   movel     l2_termdt     wkdatn
040700221217     C                   movel     wkdatn        wkdat
040800221217     C                   eval      usadt = wkdat
040900221217     C                   movel(P)  usadt         c_easval
0410002212170296 C                   endif
0411002212170296 C                   If        candt = 0
0412002212170296 C                   eval      c_gbsval = *blanks
0413002212170296 C                   else
041400221217     C                   movel     candt         wkdat
041500221217     C                   eval      usadt = wkdat
041600221217     C                   movel(P)  usadt         c_gbsval
0417002212170296 C                   endif
041800221217     C                   eval      c_sts = 'D'
0419002212170107  *                                                                     ****
042000221217     C     easkey        chain     easedscl2                          42
042100221217     C                   if        *IN42 = '1'
042200221217     C                   write     r_easecds
0423002212170296 C                   endif
0424002212170107  *                                                                     ****
0425002212170296 C                   endif
0426002212170291  *         Coverage Type
0427002212170296 C                   If        ecvtp <> gcvtp
042800221217     C                   movel(P)  'Cov Type'    c_fldnam
042900221217     C                   movel(P)  ecvtp         c_easval
043000221217     C                   movel(P)  gcvtp         c_gbsval
043100221217     C                   eval      c_sts = 'D'
0432002212170107  *                                                                     ****
043300221217     C     easkey        chain     easecdsl2                          42
043400221217     C                   if        *IN42 = '1'
043500221217     C                   write     r_easecds
0436002212170296 C                   endif
0437002212170107  *                                                                     ****
0438002212170296 C                   endif
0439002212170291  *         Volume Amount
0440002212170291  ***????   Volume Amount
0441002212170291  *         Volume Amount
044200221217     C*****              eval      eslda = *blanks
044300221217      *
0444002212170296 C*                  If        l2_volamt = *blanks
044500221217     C*                  eval      esldn = 0
044600221217     C*                  else
044700221217      *
044800221217     C*                  select
044900221217      *
045000221217     C*                  when      esl6 = '.'
045100221217     C*                  move      esl15         eslda
045200221217     C*                  eval      eslca = esl78
045300221217     C*                  when      esl7 = '.'
045400221217     C*                  move      esl16         eslda
045500221217     C*                  eval      eslca = esl89
045600221217     C*                  when      esl8 = '.'
045700221217     C*                  eval      esl10 = '0'
045800221217     C*                  move      esl17         eslda
045900221217     C*                  eval      eslca = esl90
046000221217     C*                  other
046100221217     C*                  eval      esldn = 0
046200221217     C*                  endsl
046300221217      *
0464002212170296 C*                  If        eslcn >= 50
046500221217     C*                  eval      esldn = esldn + 1
046600221217     C*                  endif
046700221217      *
046800221217     C*                  endif
046900221217      *
0470002212170296 C*                  If        esldn <> salary
047100221217     C*                  movel(P)  'Salary'      c_fldnam
047200221217     C*                  movel(P)  esldn         c_easval
047300221217     C*                  movel(P)  salary        c_gbsval
047400221217     C*                  eval      c_sts = 'D'
0475002212170107  *                                                                     ****
047600221217     C*    easkey        chain     easedscl2                          42
047700221217     C*                  if        *IN42 = '1'
047800221217     C*                  write     r_easedsc
0479002212170296 C*                  endif
0480002212170107  *                                                                     ****
0481002212170296 C*                  endif
0482002212170291  ********>>>>>>>>>>>
048300221102      *
0484002211020296 C                   endif
048500221109      *
0486000204050296 C                   enddo
0487002211070291  *
0488002211070291  * Process Dependent Data
0489002211070291  *
0490002212170297 C     *LOVAL        setll     GBS3CPRPP
0491002211070296 C                   dou       *in31 = '1'
0492002212170297 C                   read      GBS3CPRPP                              31
0493002211070296 C                   If        *in31 = '1'
0494002211070296 C                   leave
0495002211070296 C                   endif
049600221107      *
0497002211100296 C                   If        l3_rpsts <> ' ' or
0498002211300296 C                             l3_trst = 667 or l3_recdate <> easedt
0499002211070296 C                   iter
0500002211070296 C                   endif
050100221108      *    Debug shit
0502002211080296 C                   If        l3_partssn = '290866817'
0503002211080296 C                   eval      l3_partssn = l3_partssn
0504002211080296 C                   endif
050500221107      *
0506002211210107  *      Set Dep/Acct default fields for disc recs                      ****
050700221107     C                   clear                   r_easedsc
050800221208     C                   eval      c_datrec = l3_recdate
050900221208     C                   eval      c_datfnd = today
051000221107      *  Depend defaults
051100221208     C                   movel     l3_partssn    c_ssn
051200221208     C                   eval      c_seq = eds1
0513002211070296 C                   if        eds2 <> ' '
051400221208     C                   eval      c_seq = eds12
051500221107     C                   endif
051600221208     C                   movel     l3_fname      c_fname
051700221208     C                   movel     l3_lname      c_lname
051800221107      *  Account data
051900221216     C                   eval      c_trst = l3_trst
052000221216     C                   eval      c_sub# = l3_sub#
052100221216     C                   eval      c_acct = l3_acct
052200221216     C     acckeyd       chain     accmst                             32
052300221216     C                   if        *IN32 = '1'
052400221216     C                   movel     '**ACCMST REC'c_fldnam
052500221216     C                   eval      c_sts = 'A'
0526002212160107  *                                                                     ****
052700221216     C     easkey        chain     easedscl2                          42
052800221216     C                   if        *IN42 = '1'
052900221216     C                   write     r_easedsc
0530002212160296 C                   endif
0531002211090107  *                                                                     ****
0532002211070296 C                   iter
0533002211070296 C                   endif
0534002211070107  *                                                                     ****
053500221208     C                   movel(P)  macnam1       c_accnam
053600221208     C                   movel(P)  maacode       c_aacod
0537002211070107  *                                                                     ****
053800221107     C     maacode       chain     aacode                             39
053900221107     C                   if        *IN39 = '0'
054000221208     C                   movel(P)  alnam         c_aalnm
054100221208     C                   movel(P)  afnam         c_aafnm
0542002211070296 C                   endif
0543002211070107  *                                                                     ****
0544002211070107  *                                                                     ****
054500221107     C     depkey        chain     depndc                             33
054600221107     C                   if        *IN33 = '1'
0547002211110107  *      Depend Rec Missing                                             ****
054800221208     C                   movel     '**DEPEND REC'c_fldnam
054900221208     C                   eval      c_sts = 'M'
0550002211110107  *                                                                     ****
055100221111     C                   eval      etermn = 0
055200221111     C                   if        l3_termdt <> *blanks
0553002211110296 C                   move      l3_termdt     etermn
0554002211110296 C                   endif
0555002211110107  *                                                                     ****
055600221111     C                   if        etermn > today
0557002211110107  *                                                                     ****
055800221109     C     easkey        chain     easedscl2                          42
055900221109     C                   if        *IN42 = '1'
056000221109     C                   write     r_easedsc
0561002211090296 C                   endif
0562002211090107  *                                                                     ****
0563002211110296 C                   endif
0564002211110107  *                                                                     ****
0565002211070296 C                   iter
0566002211070296 C                   endif
0567002211090107  *                                                                     ****
0568002211080296 C                   endif
056900221108      *
0570002211070296 C                   enddo
057100020405      *
0572000204050296 C                   movel     '1'           *inlr
0573000204050296 C                   return
