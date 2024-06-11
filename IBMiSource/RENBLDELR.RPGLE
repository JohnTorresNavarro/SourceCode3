0001000204020002  *****************************************************************************
000200210701      * RENBLDELR  Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400210701      *            DATE - 07/2021                                                 *
000500210701      *  DESCRIPTION - Build file of current Renaissance Benefits                 *
000600210701      *                Eligibility                                                *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900210701      *  xxx mm/dd/yyyy                                                           *
001000200828      *
0011009102150018 F******************************************************************
0012000501110019 FPLNMSTN1  IF   E           K DISK
001300210826     FACCMST    IF   E           K DISK
001400210826     FAC2MSTL2  IF   E           K DISK
001500210826     FMCOV42    IF   E           K DISK
001600220615     FMCOV43    IF   E           K DISK    PREFIX(X) RENAME(MCOVR:MCOVRX)
001700020404     FMEMBER    IF   E           K DISK
001800020404     FGRAT24    IF   E           K DISK
001900220314     FDCOV22    IF   E           K DISK
002000220302     FHISTLF    IF   E           K DISK
002100020404     FDEPNDC    IF   E           K DISK
0022002108250020 FREN834P   UF A E           K DISK
0023002110260020 FREN834L   UF   E           K DISK    PREFIX(X) RENAME(REN834R:REN834X)
0024000204020025  *
002500200529      *
0026002005290250 D                 DS
0027002108270251 D  cursalary9             1      9
0028002108270251 D   cursalary             2      9
002900210827      *
0030002203020250 D                 DS
0031002203020251 D  hiskey                 1     10
0032002203020251 D   hiskey9               2     10
003300220302      *
0034002108270250 D                 DS
0035002108270251 D  fill66                 1     66
0036002108270251 D   gemail                1     65
003700211227      *
0038002112270250 D                 DS
0039002112270251 D  epprods                1      4
0040002112270251 D   pden                  1      1
0041002112270251 D   pvis                  2      2
0042002112270251 D   plif                  3      3
0043002112270251 D   peap                  4      4
004400211227      *
0045002112270250 D                 DS
0046002112270251 D  xepprods               1      4
0047002112270251 D   xden                  1      1
0048002112270251 D   xvis                  2      2
0049002112270251 D   xlif                  3      3
0050002110260251 D   xeap                  4      4
005100211026      *
0052002005290250 D                 DS
0053002005290251 D  reccnt                 1      9S 0 INZ(0)
0054002005290251 D  reccna                 1      9
005500210727      *
0056002107270250 D                 DS
0057002107270251 D  dseq                          2S 0 INZ(0)
0058002107270251 D  cutoff                         D   DATFMT(*ISO)
0059002107270251 D  cutofx                         D   DATFMT(*ISO)
0060002107270251 D  cutofy                         D   DATFMT(*ISO)
0061002203080251 D  cdat                           D   DATFMT(*ISO)
0062002203080251 D  cndat                         8S 0
0063002203080251 D  cutofn                        8S 0
0064002107270251 D  cutofa                        8S 0
0065002107270251 D  today8                        8S 0
0066002108260251 D  yrsService                    8S 0
0067002107270251 D  updt                          1A
0068002110260251 D  usedep                        1A
0069002108260251 D  hiredatet                      D
0070002108270251 D  todad                          D
007100210727      *
0072002107090251 D  todaa                              LIKE(frmdat)
0073002107090251 D  date9                              LIKE(frmdat)
007400210825      *
0075002108250251 D  kmemid                             LIKE(memid)
0076002207280251 D  xmemid                             LIKE(memid)
0077002110260251 D  svmemid                            LIKE(memid)
0078002110260251 D  svepsubcl                          LIKE(epsubcl)
0079002108250251 D  kmbrssn                            LIKE(mbrssn)
0080002108250251 D  kdob                               LIKE(dateofbth)
0081002207280251 D  xdob                               LIKE(dateofbth)
0082002108250251 D  klname                             LIKE(lastname)
0083002207280251 D  xlname                             LIKE(lastname)
0084002207140251 D  kfname                             LIKE(firstname)
0085002207280251 D  xfname                             LIKE(firstname)
0086002207140251 D  kmi                                LIKE(mi)
0087002207280251 D  xmi                                LIKE(mi)
0088002207140251 D  hldsub                             LIKE(epsubcl)
008900220714      *
0090002207140251 D  svplan                             LIKE(mcplan)
0091002207140251 D  svssn                              LIKE(mcssno)
0092002207140251 D  svcovt                             LIKE(mcovtp)
0093002207140251 D  svbeamt                            LIKE(benamt)
0094002207140251 D  sveff                              LIKE(enrldt)
0095002207140251 D  svtrm                              LIKE(candt)
0096002207140251 D  svdeff                             LIKE(enrldt)
0097002203140251 D  svdtrm                             LIKE(candt)
0098002203140251 D  svseq#                             LIKE(dseq#)
009900220310      *
010000210709      *
010100220728     C     renky         klist
010200210825     C                   kfld                    kmemid
010300210825     C                   kfld                    kmbrssn
010400210825     C                   kfld                    kdob
010500210825     C                   kfld                    klname
010600210825     C                   kfld                    kfname
010700210825     C                   kfld                    kmi
010800220728      *
010900220728     C     renkyx        klist
011000220728     C                   kfld                    xmemid
011100220728     C                   kfld                    xmbrssn
011200220728     C                   kfld                    xdob
011300220728     C                   kfld                    xlname
011400220728     C                   kfld                    xfname
011500220728     C                   kfld                    xmi
011600210825      *
011700210825     C     accky         klist
011800210825     C                   kfld                    mbtrst
011900210825     C                   kfld                    mbsub#
012000210825     C                   kfld                    mbacct
012100210825      *
012200210825     C     grkey         klist
012300210825     C                   kfld                    pltrst
012400210825     C                   kfld                    plsub#
012500210825     C                   kfld                    plplan
012600210825     C                   kfld                    date9
012700081103      *
012800041228     C     mcvky         klist
012900081103     C                   kfld                    pltrst
013000081103     C                   kfld                    plsub#
013100081103     C                   kfld                    plplan
013200220615      *
013300220615     C     mcvky3        klist
013400220615     C                   kfld                    svssn
013500220615     C                   kfld                    pltrst
013600220615     C                   kfld                    plsub#
013700220615     C                   kfld                    plplan
013800220314      *
013900220314     C     dcvky         klist
014000220314     C                   kfld                    pltrst
014100220314     C                   kfld                    plsub#
014200220314     C                   kfld                    plplan
014300220314     C                   kfld                    svssn
014400081103      *
014500020404     C     depky         klist
014600220314     C                   kfld                    svssn
014700220314     C                   kfld                    svseq#
014800220218      *
0149002107230291  *   Preprocessing
0150002107230297 C                   movel     UDATE         cutoff
0151002107230297 C                   movel     cutoff        today8
0152002107230297 C                   movel     cutoff        todaa
0153002109080297 C                   movel     cutoff        todad
0154002107230297 C                   z-add     99999999      date9
0155002109080291  * Determine Term date cutoff to start - 90 days prior to term dt
0156002109080297 C     cutoff        subdur    90:*D         cutofx
0157002107230297 C                   movel     cutofx        cutofn
0158002107230291  * Determine Term date cutoff to end - 60 days after term dt
0159002109080297 C     cutoff        adddur    60:*D         cutofy
0160002109080297 C                   movel     cutofy        cutofa
0161000204040291  *
0162000501110291  * Main Line - Loop thru plan master
0163002202250291  *
0164002109080297 C     'REN'         setll     plnmstn1                           21
0165002109080296 C                   dou       *in21 = '1'
0166002109290297 C     'REN'         reade     plnmstn1                               21
0167002111240296 C                   If        *in21 = '0'
0168002202090291  *       Debug shit
0169002208240296 C                   If        plplan = 'NENZ' or
0170002208240296 C                             plplan = 'NEN1'
0171002208240297 C                   eval      plplan = plplan
0172002208240297 C                   endif
0173002202090291  *     Using GBS info - Get GRATE record
0174002202090297 C     grkey         setll     grat24                             22
0175002202090297 C                   readp     grat24                                 22
0176002202090296 C                   If        *in22 = '0'
0177002111240291  *
0178002111240291  *        Loop thru mcov file using T,S,P
0179002207280297 C                   eval      sveff = 99999999
0180002207280297 C                   eval      svtrm = 00000000
0181002207280297 C                   eval      svplan = *blanks
0182002207280297 C                   eval      svssn = 0
0183002207280297 C     mcvky         setll     mcov42                             31
0184002207280296 C                   dou       *in31 = '1'
0185002207280297 C     mcvky         reade     mcov42                                 31
0186002207280296 C                   If        *in31 = '0' and pltrst = mctrst and
0187002207280296 C                             plsub# = mcsub# and plplan = mcplan and
0188002207280296 C                             (candt = 0 or candt > enrldt)
0189002207280291  *
0190002207280296 C                   If        candt = enrldt
0191002207280296 C                   Iter
0192002109210296 C                   endif
0193002207110291  * debug shit
0194002208240296 C                   If        mcssno = 568590690
0195002208240297 C                   eval      mcssno = mcssno
0196002208240296 C                   endif
0197002208240291  *
0198002208170296 C                   If        candt = 0 or candt > cutofn
0199002208170296 C                   If        candt = 0 or candt < cutofa
0200002208170291  *
0201002208170296 C                   If        mcssno <> svssn
0202002208170291  *
0203002208170296 C                   If        svssn <> 0
0204002208170291  *
0205002208170291  *        Get member record
0206002208170297 C     svssn         chain     member                             32
0207002208180296 C                   If        *in32 = '0'
0208002208180291  *        Get most recent coverage rec for mbr/plan
0209002208220297 C     mcvky3        chain     mcov43                             43
0210002208220296 C                   If        *in43 = '0'
0211002208220291  *
0212002208220291  *
0213002208220291 C                   exsr      chkmbr
0214002208220291  *
0215002208220291 C                   exsr      lokdep
0216002208220291  *
0217002208220297 C                   endif                                                  *in33 = '1'
0218002208220297 C                   endif                                                  *in33 = '1'
0219002208220297 C                   endif                                                  *in32 = '0'
0220002208220291  *        Reset saved values
0221002208220297 C                   eval      sveff = 99999999
0222002208220297 C                   eval      svtrm = 00000000
0223002208220297 C                   eval      svssn = mcssno
0224002208220297 C                   endif                                                  *in32 = '0'
0225002203100291  *
0226002208220296 C                   If        candt > svtrm or candt = 0
0227002208220297 C                   eval      svtrm = candt
0228002208220297 C                   endif                                                  *in32 = '0'
0229002208220291  *
0230002208220296 C                   If        enrldt < sveff
0231002208220297 C                   eval      sveff = enrldt
0232002208220297 C                   endif                                                  *in32 = '0'
0233002208220291  *
0234002208220297 C                   endif                                                  *in32 = '0'
0235002208220297 C                   endif                                                  *in32 = '0'
0236002208040291  *
0237002208220291  *
0238002208220297 C                   endif                                                  *in32 = '0'
0239002208040291  *
0240002208040297 C                   enddo                                                  *in33 = '1'
0241002111050291  *
0242002203140296 C                   If        svssn <> 0
0243002203140291  *
0244002203140291  *        Get member record
0245002203140297 C     svssn         chain     member                             32
0246002203140296 C                   If        *in32 = '0'
0247002203140291  *
0248002206150291  *        Get most recent coverage rec for mbr/plan
0249002206150297 C     mcvky3        chain     mcov43                             43
0250002206150296 C                   If        *in43 = '0'
0251002206150291  *
0252002203140291 C                   exsr      chkmbr
0253002203140291  *
0254002203140291 C                   exsr      lokdep
0255002203140291  *
0256002203140297 C                   endif                                                  *in33 = '1'
0257002206150291  *
0258002206150297 C                   endif                                                  *in33 = '1'
0259002203140297 C                   endif                                                  *in32 = '0'
0260002111050297 C                   endif                                                  *in32 = '0'
0261002203040291  *
0262002203040297 C                   endif                                                  *in32 = '0'
0263002203040291  *
0264002203040297 C                   enddo                                                  *in31 = '1'
0265002203040291  *
0266002203040291 C                   exsr      upddep
0267002203040291  *
0268002203040297 C                   movel     '1'           *inlr
0269002203040297 C                   return
0270000204020107  ********************************************************************************
0271000204020107  *
0272002108250107  *     CHKMBR - Check for Member record
0273000204020107  *
0274000204020107  ********************************************************************************
027500210825     C     chkmbr        begsr
0276002005280107  *
0277002108250107  *  Set REN Key values
027800211104     C                   eval      kmemid = %editc(mbssno:'X')
027900211104     C                   eval      kmbrssn = %editc(mbssno:'X')
028000211104     C                   eval      kdob = %char(birth)
028100211104     C                   movel(P)  mlname        klname
028200211104     C                   movel(P)  mfname        kfname
028300220114     C                   movel     mmi           kmi
0284002108270291  *        See if record already exists
0285002108310297 C     renky         chain     ren834p                            41
0286002111040296 C                   If        *in41 = '1'
028700210831      *          If not - create member record
028800211104     C                   exsr      crtmbr
028900210831      *
0290002108310291  *          Retrieve just created member record
0291002108310297 C     renky         chain     ren834p                            41
0292002109010296 C                   If        *in41 = '1'
0293002109010291  *             WHAT????
029400210901     C                   eval      mi = mi
029500210901     C                   endif
029600210901      *
029700210901     C                   endif
029800210901      *          Add coverge data to mbr rec
029900210901     C                   exsr      addcvgm
0300000907010107  *
030100090701     C                   endsr
0302002108250107  ********************************************************************************
0303002108250107  *
0304002108250107  *     CRTMBR - Create Member rec - load demographics
0305002108250107  *
0306002108250107  ********************************************************************************
030700210825     C     crtmbr        begsr
0308002108310107  *
030900211108     C                   clear                   ren834r
031000211108     C                   eval      recid = '01'
031100211108     C                   eval      prkeyty = 'S'
031200211108     C                   eval      relcd = 'EE'
0313002111080107  *
031400211108     C                   eval      epprods = '    '
0315002111080291  *        Get Account data
0316002111080297 C     accky         chain     accmst                             51
0317002111080296 C                   If        *in51 = '0'
031800211108     C                   movel(P)  acnam1        groupnam
031900211108     C                   endif
032000211108      *
0321002111080297 C     accky         chain     ac2mstl2                           51
0322002111080296 C                   If        *in51 = '0'
032300211108     C                   eval      grouptid = %editc(a2tax_id#:'X')
032400211105     C                   endif
032500211108      *      Mbr demo data
032600210922     C                   eval      memid = %editc(mbssno:'X')
032700210922     C                   eval      dateofbth = %char(birth)
032800210922     C                   movel     mlname        lastname
032900210922     C                   movel     mfname        firstname
033000210831     C                   movel     mmi           mi
033100210831     C                   movel     sex           gender
033200210831     C                   eval      mbrssn = %editc(mbssno:'X')
033300210826     C                   eval      cphone = %editc(area:'X') + %editc(phone:'X')
033400210826     C                   movel     addr1         address1
033500210826     C                   movel     addr2         address2
033600210826     C                   movel     city          ccity
033700210826     C                   movel     state         cstate
033800210826     C                   eval      czip = %editc(zip:'X')
033900210825      *
0340002108260296 C                   If        hndicp > ' '
034100210826     C                   eval      disabled = 'H'
034200210826     C                   endif
034300210826      *
0344002108260296 C                   If        salary > 0
034500210827     C                   eval      cursalary9 = %editc(salary:'Z')
034600210826     C                   eval      salfreq = 'A'
034700220302     C                   eval      saldate = %char(mbenrl)
0348002203030291  *        Look for change of salary
034900220303     C                   eval      hiskey9 = %editc(mbssno:'X')
0350002203030297 C     hiskey        setll     histlf                             53
0351002203030296 C                   dou       *in53 = '1'
0352002203030297 C     hiskey        reade     histlf                                 53
0353002203030296 C                   If        *in53 = '0'
0354002203030296 C                   If        trcode = 'ASC' or trcode = 'M17'
035500220303     C                   eval      saldate = %char(covtdt)
0356002203080297 C                   leave
0357002203080297 C                   endif
0358002203080297 C                   endif
0359002203030291  *
0360002203080297 C                   enddo                                                            '
0361002203030107  *
036200220303     C                   endif
036300210826      *
0364002109020296 C                   If        empdt > 0
036500210902     C                   eval      hiredate = %char(empdt)
036600210902     C                   eval      hiredateT = %date(empdt)
0367002109030297 C     todad         subdur    hiredatet     yrsService:*Y
036800210903     C                   eval      yrofServ = %editw(yrsService:'       0')
0369002109030296 C                   If        yrsService = 0
037000210903     C                   eval      yrofserv = '       0'
037100210903     C                   endif
037200210831     C                   endif
037300210903      *
037400210908     C                   movel     fill66        email
037500210908      *
037600210908     C                   eval      estatus = 'A'
0377002109080296 C                   If        empst <> 'A'
037800210908     C                   eval      estatus = 'I'
037900210908     C                   endif
038000210908      *
038100210908     C                   eval      tssn = %editc(mbssno:'X')
038200220211     C                   eval      feditin = %editc(mbssno:'X')
038300220211     C                   eval      policy# = %subst(group#:1:7)
038400210908      *
038500220211      *
038600220211     C                   write     ren834r
0387002108260107  *
038800210826     C                   endsr
038900220211      *
0390002108260107  ********************************************************************************
0391002108260107  *
0392002108260107  *     ADDCVGM - Add coverage data to member record
0393002108260107  *               Already have REN mbr rec, mcov + plnmst records
0394002108260107  *
0395002108260107  ********************************************************************************
039600210826     C     addcvgm       begsr
0397002108260107  *
039800220310      *    Subtract 1 day from term date if not 0
039900220310     C                   if        svtrm <> 0
040000220714     C                   movel     svtrm         cdat
0401002207140297 C     cdat          subdur    1:*D          cdat
0402002207140297 C                   movel     cdat          svtrm
0403002207140297 C                   endif
0404002207140107  *
0405002207140296 C                   If        plncat = 'PDN'
040600210826      *         Process Dental Coverage
040700220714     C                   movel     policy#       dacct#
040800220714     C                   movel     'DEN'         dtype
040900220714     C                   eval      dcovedate = %char(sveff)
041000220714     C                   eval      dcovcdate = %char(svtrm)
041100220714      *
041200220714     C                   eval      dencovl = 'ESP'
041300220714      *
041400210909     C                   select
041500220714      *
041600220615     C                   when      xmcovtp = 'TIN'
041700211026     C                   eval      dencovl = 'EMP'
041800220615     C                   when      xmcovtp = 'THW'
041900211026     C                   eval      dencovl = 'ESP'
042000220615     C                   when      xmcovtp = 'TFA'
042100211026     C                   eval      dencovl = 'FAM'
042200220615     C                   when      xmcovtp = 'TPC'
042300211026     C                   eval      dencovl = 'E1D'
042400220615     C                   when      xmcovtp = 'TP2'
042500211026     C                   eval      dencovl = 'ECH'
042600211026     C                   endsl
042700211026      *
042800211026     C                   eval      decovin = 'Y'
0429002109020107  *
0430002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
043100210902     C                   eval      dccovin = 'Y'
043200210902     C                   endif
0433002108260107  *
0434002206150296 C                   If        xmcovtp = 'THW'
043500210826     C                   eval      dscovin = 'Y'
043600210826     C                   endif
0437002108260107  *
0438002206150296 C                   If        xmcovtp = 'TFA'
043900210826     C                   eval      dscovin = 'Y'
044000210826     C                   eval      dccovin = 'Y'
044100210826     C                   endif
044200210826      *
044300210916     C                   eval      pden = '1'
044400210916      *
044500210917     C                   exsr      setsub
044600210930      *
044700210826     C                   update    ren834r
0448002108260107  *
044900210826     C                   leavesr
045000210826     C                   endif
0451002108260107  *
0452002108260107  *
0453002108260296 C                   If        plncat = 'PVS'
045400210826      *         Process Vision Coverage
045500210826     C                   movel     policy#       vacct#
045600210826     C                   movel     'VIS'         vtype
045700220310     C                   eval      vcovedate = %char(sveff)
045800220310     C                   eval      vcovcdate = %char(svtrm)
045900210903      *
046000210903      *
046100210903     C                   eval      viscovl = 'ESP'
046200210903      *
046300210903     C                   select
046400210903      *
046500220615     C                   when      xmcovtp = 'TIN'
046600210910     C                   eval      viscovl = 'EMP'
046700220615     C                   when      xmcovtp = 'THW'
046800210910     C                   eval      viscovl = 'ESP'
046900220615     C                   when      xmcovtp = 'TFA'
047000210910     C                   eval      viscovl = 'FAM'
047100220615     C                   when      xmcovtp = 'TPC'
047200210903     C                   eval      viscovl = 'E1D'
047300220615     C                   when      xmcovtp = 'TP2'
047400210910     C                   eval      viscovl = 'ECH'
047500210910     C                   endsl
047600210903      *
047700210826     C                   eval      vecovin = 'Y'
0478002108260107  *
0479002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
048000210826     C                   eval      vccovin = 'Y'
048100210826     C                   endif
0482002108260107  *
0483002206150296 C                   If        xmcovtp = 'THW'
048400210827     C                   eval      vscovin = 'Y'
048500210826     C                   endif
0486002108260107  *
0487002206150296 C                   If        xmcovtp = 'TFA'
048800210826     C                   eval      vscovin = 'Y'
048900210826     C                   eval      vccovin = 'Y'
049000210826     C                   endif
049100210826      *
049200210916      *
049300210916     C                   eval      pvis = '1'
049400210916      *
049500210917     C                   exsr      setsub
049600210916      *
049700210826     C                   update    ren834r
0498002109160107  *
049900210826     C                   leavesr
050000210826     C                   endif
0501002108260107  *
0502002108260107  *
0503002108260296 C                   If        plncat = 'PLF'
050400210826      *         Process EE Life Coverage
050500210826     C                   movel     policy#       elacct#
050600210827     C                   movel     'LIF'         eltype
050700220310     C                   eval      eledate = %char(sveff)
050800220310     C                   eval      elcdate = %char(svtrm)
050900220308      *
051000220615     C                   eval      elbamt = %editc(xbenamt:'Z')
051100210903      *
051200210903      *
051300210903     C                   eval      elcovl = 'ESP'
051400210903      *
051500210903     C                   select
051600210903      *
051700220615     C                   when      xmcovtp = 'TIN'
051800210903     C                   eval      elcovl = 'EMP'
051900220615     C                   when      xmcovtp = 'THW'
052000210903     C                   eval      elcovl = 'ESP'
052100220615     C                   when      xmcovtp = 'TFA'
052200211028     C                   eval      elcovl = 'FAM'
052300220615     C                   when      xmcovtp = 'TPC'
052400211028     C                   eval      elcovl = 'E1D'
052500220615     C                   when      xmcovtp = 'TP2'
052600211028     C                   eval      elcovl = 'ECH'
052700211028     C                   endsl
052800211028      *
052900211028     C                   eval      plif = '1'
053000211028      *
053100211028     C                   exsr      setsub
053200211028      *
053300211028     C                   update    ren834r
0534002110280107  *
053500210826     C                   leavesr
053600210826     C                   endif
0537002108260107  *
0538002108270107  *
0539002108270296 C                   If        plncat = 'PAC'
054000210827      *         Process EE ADD Coverage
054100210827     C                   movel     policy#       eaacct#
054200210827     C                   movel     'ADD'         eatype
054300220310     C                   eval      eaedate = %char(sveff)
054400220310     C                   eval      eacdate = %char(svtrm)
054500220308      *
054600220615     C                   eval      eabamt = %editc(xbenamt:'Z')
054700210903      *
054800210903      *
054900210903     C                   eval      eacovl = 'ESP'
055000210903      *
055100210903     C                   select
055200210903      *
055300220615     C                   when      xmcovtp = 'TIN'
055400210903     C                   eval      eacovl = 'EMP'
055500220615     C                   when      xmcovtp = 'THW'
055600210903     C                   eval      eacovl = 'ESP'
055700220615     C                   when      xmcovtp = 'TFA'
055800210903     C                   eval      eacovl = 'FAM'
055900220615     C                   when      xmcovtp = 'TPC'
056000210903     C                   eval      eacovl = 'E1D'
056100220615     C                   when      xmcovtp = 'TP2'
056200210903     C                   eval      eacovl = 'ECH'
056300210903     C                   endsl
056400210903      *
056500210916      *
056600210916     C                   eval      plif = '1'
056700210916      *
056800210917     C                   exsr      setsub
056900210827      *
057000210827     C                   update    ren834r
0571002109160107  *
057200210827     C                   leavesr
057300210827     C                   endif
0574002108270107  *
0575002108270107  *
0576002108270296 C                   If        plncat = 'POA'
057700210827      *         Process EE Sup Life Coverage
057800210827     C                   movel     policy#       easacct#
057900210827     C                   movel     'SEA'         eastype
058000220310     C                   eval      easedate = %char(sveff)
058100220310     C                   eval      eascdate = %char(svtrm)
058200220308      *
058300220615     C                   eval      easbamt = %editc(xbenamt:'Z')
058400210903      *
058500210903      *
058600210903     C                   eval      eascovl = 'ESP'
058700210903      *
058800210903     C                   select
058900210903      *
059000220615     C                   when      xmcovtp = 'TIN'
059100210903     C                   eval      eascovl = 'EMP'
059200220615     C                   when      xmcovtp = 'THW'
059300210903     C                   eval      eascovl = 'ESP'
059400220615     C                   when      xmcovtp = 'TFA'
059500210903     C                   eval      eascovl = 'FAM'
059600220615     C                   when      xmcovtp = 'TPC'
059700210903     C                   eval      eascovl = 'E1D'
059800220615     C                   when      xmcovtp = 'TP2'
059900210903     C                   eval      eascovl = 'ECH'
060000210903     C                   endsl
060100210903      *
060200210916      *
060300210916     C                   eval      plif = '1'
060400210916      *
060500210917     C                   exsr      setsub
060600210827      *
060700210827     C                   update    ren834r
0608002108270107  *
060900210827     C                   leavesr
061000210827     C                   endif
0611002108270107  *
0612002108270107  *
0613002108270296 C                   If        plncat = 'PSL'
061400210827      *         Process EE Sup Life Coverage
061500210827     C                   movel     policy#       elsacct#
061600210827     C                   movel     'SEL'         elstype
061700220310     C                   eval      elsedate = %char(sveff)
061800220310     C                   eval      elscdate = %char(svtrm)
061900220308      *
062000220615     C                   eval      elsbamt = %editc(xbenamt:'Z')
062100210903      *
062200210903     C                   eval      elscovl = 'ESP'
062300210903      *
062400210903     C                   select
062500210903      *
062600220615     C                   when      xmcovtp = 'TIN'
062700210903     C                   eval      elscovl = 'EMP'
062800220615     C                   when      xmcovtp = 'THW'
062900210903     C                   eval      elscovl = 'ESP'
063000220615     C                   when      xmcovtp = 'TFA'
063100210903     C                   eval      elscovl = 'FAM'
063200220615     C                   when      xmcovtp = 'TPC'
063300210903     C                   eval      elscovl = 'E1D'
063400220615     C                   when      xmcovtp = 'TP2'
063500210903     C                   eval      elscovl = 'ECH'
063600210903     C                   endsl
063700210903      *
063800210916      *
063900210916     C                   eval      plif = '1'
064000210916      *
064100210917     C                   exsr      setsub
064200210827      *
064300210827     C                   update    ren834r
0644002108270107  *
064500210827     C                   leavesr
064600210827     C                   endif
0647002108270107  *
0648002108270107  *
0649002108270107  *
0650002108270296 C                   If        plncat = 'PSP' or plncat = 'PSA'
0651002108270296 C                   If        sltype = *blanks
065200210827      *         Process Spouse Life or ADD coverage
065300210827     C                   movel     policy#       slacct#
065400210827     C                   movel     'SSL'         sltype
065500220310     C                   eval      sledate = %char(sveff)
065600220310     C                   eval      slcdate = %char(svtrm)
065700220308      *
065800220615     C                   eval      slbamt = %editc(xbenamt:'Z')
065900210903      *
066000210903     C                   eval      slcovl = 'ESP'
066100210903      *
066200210903     C                   select
066300210903      *
066400220615     C                   when      xmcovtp = 'TIN'
066500210903     C                   eval      slcovl = 'EMP'
066600220615     C                   when      xmcovtp = 'THW'
066700210903     C                   eval      slcovl = 'ESP'
066800220615     C                   when      xmcovtp = 'TFA'
066900210903     C                   eval      slcovl = 'FAM'
067000220615     C                   when      xmcovtp = 'TPC'
067100210903     C                   eval      slcovl = 'E1D'
067200220615     C                   when      xmcovtp = 'TP2'
067300210903     C                   eval      slcovl = 'ECH'
067400210903     C                   endsl
067500210903      *
067600210916      *
067700210916     C                   eval      plif = '1'
067800210916      *
067900210917     C                   exsr      setsub
068000210827      *
068100210827     C                   update    ren834r
0682002109160107  *
068300210827     C                   endif
068400210827     C                   leavesr
068500210827     C                   endif
0686002108270107  *
0687002108270107  *
0688002108270296 C                   If        plncat = 'PSD' or plncat = 'PAA'
0689002108270296 C                   If        sltype = *blanks
069000210827      *         Process Dep Life or ADD coverage
069100210827     C                   movel     policy#       dlacct#
069200210827     C                   movel     'SDL'         dltype
069300220310     C                   eval      dledate = %char(sveff)
069400220310     C                   eval      dlcdate = %char(svtrm)
069500220308      *
069600220615     C                   eval      dlbamt = %editc(xbenamt:'Z')
069700210827      *
069800210903      *
069900210903     C                   eval      dlcovl = 'ESP'
070000210903      *
070100210903     C                   select
070200210903      *
070300220615     C                   when      xmcovtp = 'TIN'
070400210903     C                   eval      dlcovl = 'EMP'
070500220615     C                   when      xmcovtp = 'THW'
070600210903     C                   eval      dlcovl = 'ESP'
070700220615     C                   when      xmcovtp = 'TFA'
070800210903     C                   eval      dlcovl = 'FAM'
070900220615     C                   when      xmcovtp = 'TPC'
071000210903     C                   eval      dlcovl = 'E1D'
071100220615     C                   when      xmcovtp = 'TP2'
071200210903     C                   eval      dlcovl = 'ECH'
071300210903     C                   endsl
071400210903      *
071500210916      *
071600210916     C                   eval      plif = '1'
071700210916      *
071800210917     C                   exsr      setsub
071900210916      *
072000210827     C                   update    ren834r
0721002109160107  *
072200210827     C                   endif
072300210827     C                   leavesr
072400210827     C                   endif
0725002108270107  *
0726002108270107  *
0727002202160296 C                   If        plncat = 'PWD' or plncat = 'PVW'
072800210827      *         Process Short Trm Dis Coverage
072900210827     C                   movel     policy#       sdacct#
073000210827     C                   movel     'STD'         sdtype
073100220310     C                   eval      sdedate = %char(sveff)
073200220310     C                   eval      sdcdate = %char(svtrm)
073300220308      *
073400220615     C                   eval      sdbamt = %editc(xbenamt:'Z')
073500210827      *
073600210903      *
073700210903     C                   eval      sdcovl = 'ESP'
073800210903      *
073900210903     C                   select
074000210903      *
074100220615     C                   when      xmcovtp = 'TIN'
074200210903     C                   eval      sdcovl = 'EMP'
074300220615     C                   when      xmcovtp = 'THW'
074400210903     C                   eval      sdcovl = 'ESP'
074500220615     C                   when      xmcovtp = 'TFA'
074600211104     C                   eval      sdcovl = 'FAM'
074700220615     C                   when      xmcovtp = 'TPC'
074800211104     C                   eval      sdcovl = 'E1D'
074900220615     C                   when      xmcovtp = 'TP2'
075000211104     C                   eval      sdcovl = 'ECH'
075100211104     C                   endsl
075200211104      *
075300211104      *
075400211104     C                   eval      plif = '1'
075500211104      *
075600211104     C                   exsr      setsub
075700211104      *
075800210827     C                   update    ren834r
0759002111040107  *
076000211104     C                   leavesr
076100210827     C                   endif
0762002108270107  *
0763002108270107  *
0764002202090296 C                   If        plncat = 'PVL' or plncat = 'PLT'
076500210827      *         Process Long Trm Dis Coverage
076600210827     C                   movel     policy#       ldacct#
076700210827     C                   movel     'LTD'         ldtype
076800220310     C                   eval      ldedate = %char(sveff)
076900220310     C                   eval      ldcdate = %char(svtrm)
077000220308      *
077100220615     C                   eval      ldbamt = %editc(xbenamt:'Z')
077200210903      *
077300210903     C                   eval      ldcovl = 'ESP'
077400210903      *
077500210903     C                   select
077600210903      *
077700220615     C                   when      xmcovtp = 'TIN'
077800210903     C                   eval      ldcovl = 'EMP'
077900220615     C                   when      xmcovtp = 'THW'
078000210903     C                   eval      ldcovl = 'ESP'
078100220615     C                   when      xmcovtp = 'TFA'
078200210903     C                   eval      ldcovl = 'FAM'
078300220615     C                   when      xmcovtp = 'TPC'
078400210903     C                   eval      ldcovl = 'E1D'
078500220615     C                   when      xmcovtp = 'TP2'
078600210903     C                   eval      ldcovl = 'ECH'
078700210903     C                   endsl
078800210903      *
078900210916      *
079000210916     C                   eval      plif = '1'
079100210916      *
079200210917     C                   exsr      setsub
079300210916      *
079400210827     C                   update    ren834r
0795002108270107  *
079600210827     C                   leavesr
079700210827     C                   endif
0798002108270107  *
0799002108270107  *
0800002108270296 C                   If        plncat = 'PEP'
080100210827      *         Process EAP Coverage
080200210827     C                   movel     policy#       epacct#
080300210827     C                   movel     'EAP'         eptype
080400220310     C                   eval      epedate = %char(sveff)
080500220310     C                   eval      epcdate = %char(svtrm)
080600220308      *
080700220615     C                   eval      epbamt = %editc(xbenamt:'Z')
080800210827      *
080900210903     C                   eval      epcovl = 'ESP'
081000210903      *
081100210903     C                   select
081200210903      *
081300220615     C                   when      xmcovtp = 'TIN'
081400210903     C                   eval      epcovl = 'EMP'
081500220615     C                   when      xmcovtp = 'THW'
081600210903     C                   eval      epcovl = 'ESP'
081700220615     C                   when      xmcovtp = 'TFA'
081800210903     C                   eval      epcovl = 'FAM'
081900220615     C                   when      xmcovtp = 'TPC'
082000210903     C                   eval      epcovl = 'E1D'
082100220615     C                   when      xmcovtp = 'TP2'
082200210903     C                   eval      epcovl = 'ECH'
082300210903     C                   endsl
082400210903      *
082500210916      *
082600210916     C                   eval      peap = '1'
082700210916      *
082800210917     C                   exsr      setsub
082900210916      *
083000210827     C                   update    ren834r
0831002108270107  *
083200210827     C                   leavesr
083300210827     C                   endif
0834002108270107  *
083500210826     C                   endsr
083600210826      *
0837002108270107  ********************************************************************************
0838002108270107  *
0839002108270107  *     LOKDEP - Look for Deps with same plan
0840002108270107  *
0841002108270107  ********************************************************************************
084200210827     C     lokdep        begsr
0843002108270107  *
0844002108270291  *        Look for dependents of member
0845002203140297 C                   eval      svdeff = 99999999
0846002203140297 C                   eval      svdtrm = 00000000
0847002203140297 C                   eval      svseq# = 0
0848002203140297 C     dcvky         setll     dcov22                             33
0849002108270296 C                   dou       *in33 = '1'
0850002203140297 C     dcvky         reade     dcov22                                 33
0851002108270296 C                   If        *in33 = '0' and pltrst = dvtrst and
0852002108270296 C                             plsub# = dvsub# and plplan = dvplan
0853002108270291  *
0854002108270296 C                   If        ccandt = 0 or ccandt > cutofn
0855002108270296 C                   If        ccandt = 0 or ccandt < cutofa
0856002108270291  *
0857002108270296 C                   If        ccandt = denrdt
0858002108270297 C                   iter                                                   ccandt = 0
0859002108270297 C                   endif                                                  ccandt = 0
0860002108270291  *
0861002203140296 C                   If        svseq# <> dseq#
0862002203140291  *
0863002203140296 C                   If        svseq# <> 0
0864002203140291 C                   exsr      chkdep
0865002203140297 C                   endif                                                  *in32 = '0'
0866002203140291  *
0867002203140291  *        Reset saved values
0868002203140297 C                   eval      svdeff = 99999999
0869002203140297 C                   eval      svdtrm = 00000000
0870002203140297 C                   eval      svseq# = dseq#
0871002203140291  *
0872002203140296 C                   If        ccandt > svdtrm or ccandt = 0
0873002203140297 C                   eval      svdtrm = ccandt
0874002203140297 C                   endif                                                  *in32 = '0'
0875002203140291  *
0876002203140296 C                   If        denrdt < svdeff
0877002203140297 C                   eval      svdeff = denrdt
0878002203140297 C                   endif                                                  *in32 = '0'
0879002203140291  *
0880002203140297 C                   endif                                                  *in32 = '0'
0881002108270297 C                   endif                                                  ccandt = 0
0882002108270291  *
0883002108270297 C                   endif                                                  ccandt = 0
0884002108270291  *
0885002108270297 C                   endif                                                  *in33 = '0'
0886002108270291  *
0887002108270297 C                   enddo                                                  *in33 = '1'
0888002203140291  *
0889002203140296 C                   If        svseq# <> 0
0890002203140291 C                   exsr      chkdep
0891002203140297 C                   endif                                                  *in32 = '0'
0892002108270107  *
089300210827     C                   endsr
089400210827      *
0895002108270107  ********************************************************************************
0896002108270107  *
0897002108270107  *     CHKDEP - Check for Dependent record
0898002108270107  *
0899002108270107  ********************************************************************************
090000210827     C     chkdep        begsr
0901002108270107  *
0902002108270291  *        get Dependent rec
0903002108270297 C     depky         chain     depndc                             61
0904002108270296 C                   If        *in61 = '0'
0905002108270107  *  Set REN Key values
090600210827     C                   eval      kmemid = %editc(mbssno:'X')
090700210827     C                   eval      kmbrssn = %editc(depss#:'X')
090800210827     C                   eval      kdob = %char(dbirth)
090900210827     C                   movel(P)  dlname        klname
091000210827     C                   movel(P)  dfname        kfname
091100210827     C                   movel     dmi           kmi
0912002108270291  *        See if reord already exists
0913002108270297 C     renky         chain     ren834p                            62
0914002108270296 C                   If        *in62 = '1'
091500210827      *          If not - create member record
091600210827     C                   exsr      crtdep
091700210827      *
0918002108270291  *          Retrieve just created member record
0919002108270297 C     renky         chain     ren834p                            62
0920002108270296 C                   If        *in62 = '1'
0921002108270291  *             WHAT????
092200210827     C                   eval      mi = mi
092300210827     C                   endif
092400210827      *
092500210827     C                   endif
092600220728      *          Add coverge data to mbr rec for certain plncats
0927002207280296 C                   If        plncat = 'PSP' or plncat = 'PSA' or
0928002207280296 C                             plncat = 'PSD' or plncat = 'PAA'
092900220728     C                   exsr      addcvgx
093000220728     C                   else
093100220728      *          Add coverge data to dep rec
093200210827     C                   exsr      addcvgd
093300210827     C                   endif
093400220728      *
093500220728     C                   endif
0936002108270107  *
093700210827     C                   endsr
0938002108270107  ********************************************************************************
0939002108270107  *
0940002108270107  *     CRTDEP - Create Dep rec - load demographics
0941002108270107  *
0942002108270107  ********************************************************************************
094300210827     C     crtdep        begsr
0944002108270107  *
094500210827     C                   clear                   ren834r
094600210827     C                   eval      recid = '02'
094700210827     C                   eval      prkeyty = 'S'
0948002108270291  *
094900210827     C                   eval      relcd = 'CH'
0950002108270296 C                   If        drelcd = 'RWI' or drelcd = 'RHU'
095100210827     C                   eval      relcd = 'SP'
095200210827     C                   endif
0953002109160107  *
095400210916     C                   eval      epprods = '    '
0955002108270291  *        Get Account data
0956002108270297 C     accky         chain     accmst                             51
0957002108270296 C                   If        *in51 = '0'
095800210827     C                   movel(P)  acnam1        groupnam
095900210827     C                   endif
096000210827      *
0961002108270297 C     accky         chain     ac2mstl2                           51
0962002108270296 C                   If        *in51 = '0'
096300210827     C                   eval      grouptid = %editc(a2tax_id#:'X')
096400210827     C                   endif
096500210827      *      Mbr demo data
096600210827     C                   eval      memid = %editc(mbssno:'X')
096700210827     C                   eval      dateofbth = %char(dbirth)
096800210827     C                   movel     dlname        lastname
096900210827     C                   movel     dfname        firstname
097000210827     C                   movel     dmi           mi
097100210827     C                   movel     dsex          gender
097200210827     C                   eval      mbrssn = %editc(depss#:'X')
097300210827     C                   eval      cphone = %editc(darea:'X') +
097400210827     C                             %editc(dphone:'X')
097500210827     C                   movel     daddr1        address1
097600210827     C                   movel     daddr2        address2
097700210827     C                   movel     dcity         ccity
097800210827     C                   movel     dstate        cstate
097900210827     C                   eval      czip = %editc(dzip:'X')
098000210827      *
0981002108270296 C                   If        dhndcp > ' '
098200210827     C                   eval      disabled = 'H'
098300210827     C                   endif
098400210827      *
098500210827     C                   eval      tssn = %editc(depss#:'X')
098600220211     C                   eval      feditin = %editc(depss#:'X')
098700220211     C                   eval      policy# = %subst(group#:1:7)
098800220211      *
098900220211     C                   eval      epsubcl = hldsub
099000220211      *
099100220211      *
099200210827     C                   write     ren834r
0993002108270107  *
099400210827     C                   endsr
099500210827      *
0996002108270107  ********************************************************************************
0997002108270107  *
0998002108270107  *     ADDCVGD - Add coverage data to dep record
0999002108270107  *               Already have REN dep rec, dcov + plnmst records
1000002108270107  *
1001002108270107  ********************************************************************************
100200210827     C     addcvgd       begsr
1003002108270107  *
1004002108270296 C                   If        plncat = 'PDN'
100500210827      *         Process Dental Coverage
100600210827     C                   movel     policy#       dacct#
100700210827     C                   movel     'DEN'         dtype
100800220314     C                   eval      dcovedate = %char(svdeff)
100900220308      *
101000220314     C                   if        svdtrm <> 0
101100220314     C                   movel     svdtrm        cdat
1012002203080297 C     cdat          subdur    1:*D          cdat
1013002203140297 C                   movel     cdat          svdtrm
101400220314     C                   eval      dcovcdate = %char(svdtrm)
101500220308     C                   endif
101600220308      *
1017002108270107  *
101800210903      *
101900210903     C                   eval      dencovl = 'ESP'
102000210903      *
102100210903     C                   select
102200210903      *
102300220615     C                   when      xmcovtp = 'TIN'
102400210903     C                   eval      dencovl = 'EMP'
102500220615     C                   when      xmcovtp = 'THW'
102600210903     C                   eval      dencovl = 'ESP'
102700220615     C                   when      xmcovtp = 'TFA'
102800210903     C                   eval      dencovl = 'FAM'
102900220615     C                   when      xmcovtp = 'TPC'
103000210903     C                   eval      dencovl = 'E1D'
103100220615     C                   when      xmcovtp = 'TP2'
103200210903     C                   eval      dencovl = 'ECH'
103300210903     C                   endsl
103400210903      *
103500210827     C                   eval      decovin = 'Y'
1036002108270107  *
1037002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
103800210827     C                   eval      dccovin = 'Y'
103900210827     C                   endif
1040002108270107  *
1041002206150296 C                   If        xmcovtp = 'THW'
104200210827     C                   eval      dscovin = 'Y'
104300210827     C                   endif
1044002108270107  *
1045002206150296 C                   If        xmcovtp = 'TFA'
104600210827     C                   eval      dscovin = 'Y'
104700210827     C                   eval      dccovin = 'Y'
104800210827     C                   endif
104900210916      *
105000210916     C                   eval      pden = '1'
105100210916      *
105200210930     C***                exsr      setsub
105300210930     C                   eval      epsubcl = hldsub
105400210827      *
105500210827     C                   update    ren834r
1056002108270107  *
105700210827     C                   leavesr
105800210827     C                   endif
1059002108270107  *
1060002108270107  *
1061002108270296 C                   If        plncat = 'PVS'
106200210827      *         Process Vision Coverage
106300210827     C                   movel     policy#       vacct#
106400210827     C                   movel     'VIS'         vtype
106500220314     C                   eval      vcovedate = %char(svdeff)
106600220308      *
106700220314     C                   if        svdtrm <> 0
106800220314     C                   movel     svdtrm        cdat
1069002203080297 C     cdat          subdur    1:*D          cdat
1070002203140297 C                   movel     cdat          svdtrm
107100220314     C                   eval      vcovcdate = %char(svdtrm)
107200220308     C                   endif
107300220308      *
107400210903     C                   eval      viscovl = 'ESP'
107500210903      *
107600210903     C                   select
107700210903      *
107800220615     C                   when      xmcovtp = 'TIN'
107900210903     C                   eval      viscovl = 'EMP'
108000220615     C                   when      xmcovtp = 'THW'
108100210903     C                   eval      viscovl = 'ESP'
108200220615     C                   when      xmcovtp = 'TFA'
108300210903     C                   eval      viscovl = 'FAM'
108400220615     C                   when      xmcovtp = 'TPC'
108500210903     C                   eval      viscovl = 'E1D'
108600220615     C                   when      xmcovtp = 'TP2'
108700210903     C                   eval      viscovl = 'ECH'
108800210903     C                   endsl
108900210903      *
109000210827     C                   eval      vecovin = 'Y'
1091002108270107  *
1092002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
109300210827     C                   eval      vccovin = 'Y'
109400210827     C                   endif
1095002108270107  *
1096002206150296 C                   If        xmcovtp = 'THW'
109700210827     C                   eval      vscovin = 'Y'
109800210827     C                   endif
1099002108270107  *
1100002206150296 C                   If        xmcovtp = 'TFA'
110100210827     C                   eval      vscovin = 'Y'
110200210827     C                   eval      vccovin = 'Y'
110300210827     C                   endif
110400210916      *
110500210916     C                   eval      pvis = '1'
110600210916      *
110700210930     C****               exsr      setsub
110800210930     C                   eval      epsubcl = hldsub
110900210827      *
111000210827     C                   update    ren834r
1111002108270107  *
111200210827     C                   leavesr
111300210827     C                   endif
1114002108270107  *
1115002108270107  *
1116002108270296 C                   If        plncat = 'PLF'
111700210827      *         Process EE Life Coverage
111800210827     C                   movel     policy#       elacct#
111900210827     C                   movel     'LIF'         eltype
112000220314     C                   eval      eledate = %char(svdeff)
112100220308      *
112200220314     C                   if        svdtrm <> 0
112300220314     C                   movel     svdtrm        cdat
1124002203080297 C     cdat          subdur    1:*D          cdat
1125002203140297 C                   movel     cdat          svdtrm
112600220314     C                   eval      elcdate = %char(svdtrm)
112700220308     C                   endif
112800220308      *
112900220615     C                   eval      elbamt = %editc(xbenamt:'Z')
113000210827      *
113100210903      *
113200210903     C                   eval      elcovl = 'ESP'
113300210903      *
113400210903     C                   select
113500210903      *
113600220615     C                   when      xmcovtp = 'TIN'
113700210903     C                   eval      elcovl = 'EMP'
113800220615     C                   when      xmcovtp = 'THW'
113900210903     C                   eval      elcovl = 'ESP'
114000220615     C                   when      xmcovtp = 'TFA'
114100210903     C                   eval      elcovl = 'FAM'
114200220615     C                   when      xmcovtp = 'TPC'
114300210903     C                   eval      elcovl = 'E1D'
114400220615     C                   when      xmcovtp = 'TP2'
114500210903     C                   eval      elcovl = 'ECH'
114600210903     C                   endsl
114700210916      *
114800210916     C                   eval      plif = '1'
114900210916      *
115000210930     C*****              exsr      setsub
115100210903      *
115200210827     C                   update    ren834r
1153002108270107  *
115400210827     C                   leavesr
115500210827     C                   endif
1156002108270107  *
1157002108270107  *
1158002108270296 C                   If        plncat = 'PAC'
115900210827      *         Process EE ADD Coverage
116000210827     C                   movel     policy#       eaacct#
116100210827     C                   movel     'ADD'         eatype
116200220314     C                   eval      eaedate = %char(svdeff)
116300220308      *
116400220314     C                   if        svdtrm <> 0
116500220314     C                   movel     svdtrm        cdat
1166002203080297 C     cdat          subdur    1:*D          cdat
1167002203140297 C                   movel     cdat          svdtrm
116800220314     C                   eval      eacdate = %char(svdtrm)
116900220308     C                   endif
117000220308      *
117100220615     C                   eval      eabamt = %editc(xbenamt:'Z')
117200210827      *
117300210903      *
117400210903     C                   eval      eacovl = 'ESP'
117500210903      *
117600210903     C                   select
117700210903      *
117800220615     C                   when      xmcovtp = 'TIN'
117900210903     C                   eval      eacovl = 'EMP'
118000220615     C                   when      xmcovtp = 'THW'
118100210903     C                   eval      eacovl = 'ESP'
118200220615     C                   when      xmcovtp = 'TFA'
118300210903     C                   eval      eacovl = 'FAM'
118400220615     C                   when      xmcovtp = 'TPC'
118500210903     C                   eval      eacovl = 'E1D'
118600220615     C                   when      xmcovtp = 'TP2'
118700210903     C                   eval      eacovl = 'ECH'
118800210903     C                   endsl
118900210916      *
119000210916     C                   eval      plif = '1'
119100210916      *
119200210930     C****               exsr      setsub
119300210930     C                   eval      epsubcl = hldsub
119400210903      *
119500210827     C                   update    ren834r
1196002108270107  *
119700210827     C                   leavesr
119800210827     C                   endif
1199002108270107  *
1200002108270107  *
1201002108270296 C                   If        plncat = 'POA'
120200210827      *         Process EE Sup Life Coverage
120300210827     C                   movel     policy#       easacct#
120400210827     C                   movel     'SEA'         eastype
120500220314     C                   eval      easedate = %char(svdeff)
120600220308      *
120700220314     C                   if        svdtrm <> 0
120800220314     C                   movel     svdtrm        cdat
1209002203080297 C     cdat          subdur    1:*D          cdat
1210002203140297 C                   movel     cdat          svdtrm
121100220314     C                   eval      eascdate = %char(svdtrm)
121200220308     C                   endif
121300220308      *
121400220615     C                   eval      easbamt = %editc(xbenamt:'Z')
121500210903      *
121600210903     C                   eval      eascovl = 'ESP'
121700210903      *
121800210903     C                   select
121900210903      *
122000220615     C                   when      xmcovtp = 'TIN'
122100210903     C                   eval      eascovl = 'EMP'
122200220615     C                   when      xmcovtp = 'THW'
122300210903     C                   eval      eascovl = 'ESP'
122400220615     C                   when      xmcovtp = 'TFA'
122500210903     C                   eval      eascovl = 'FAM'
122600220615     C                   when      xmcovtp = 'TPC'
122700210903     C                   eval      eascovl = 'E1D'
122800220615     C                   when      xmcovtp = 'TP2'
122900210903     C                   eval      eascovl = 'ECH'
123000210903     C                   endsl
123100210916      *
123200210916     C                   eval      plif = '1'
123300210916      *
123400210930     C****               exsr      setsub
123500210930     C                   eval      epsubcl = hldsub
123600210903      *
123700210827     C                   update    ren834r
1238002108270107  *
123900210827     C                   leavesr
124000210827     C                   endif
1241002108270107  *
1242002108270107  *
1243002108270296 C                   If        plncat = 'PSL'
124400210827      *         Process EE Sup Life Coverage
124500210827     C                   movel     policy#       elsacct#
124600210827     C                   movel     'SEL'         elstype
124700220314     C                   eval      elsedate = %char(svdeff)
124800220308      *
124900220314     C                   if        svdtrm <> 0
125000220314     C                   movel     svdtrm        cdat
1251002203080297 C     cdat          subdur    1:*D          cdat
1252002203140297 C                   movel     cdat          svdtrm
125300220314     C                   eval      elscdate = %char(svdtrm)
125400220308     C                   endif
125500220308      *
125600210827     C                   eval      elsbamt = %editc(benamt:'Z')
125700210903      *
125800210903     C                   eval      elscovl = 'ESP'
125900210903      *
126000210903     C                   select
126100210903      *
126200220615     C                   when      xmcovtp = 'TIN'
126300210903     C                   eval      elscovl = 'EMP'
126400220615     C                   when      xmcovtp = 'THW'
126500210903     C                   eval      elscovl = 'ESP'
126600220615     C                   when      xmcovtp = 'TFA'
126700210903     C                   eval      elscovl = 'FAM'
126800220615     C                   when      xmcovtp = 'TPC'
126900210903     C                   eval      elscovl = 'E1D'
127000220615     C                   when      xmcovtp = 'TP2'
127100210903     C                   eval      elscovl = 'ECH'
127200210903     C                   endsl
127300210903      *
127400210916      *
127500210916     C                   eval      plif = '1'
127600210916      *
127700210930     C****               exsr      setsub
127800210930     C                   eval      epsubcl = hldsub
127900210827      *
128000210827     C                   update    ren834r
1281002108270107  *
128200210827     C                   leavesr
128300210827     C                   endif
1284002108270107  *
1285002108270107  *
1286002108270107  *
1287002108270296 C                   If        plncat = 'PWD'
128800210827      *         Process Short Trm Dis Coverage
128900210827     C                   movel     policy#       sdacct#
129000210827     C                   movel     'STD'         sdtype
129100220314     C                   eval      sdedate = %char(svdeff)
129200220308      *
129300220314     C                   if        svdtrm <> 0
129400220314     C                   movel     svdtrm        cdat
1295002203080297 C     cdat          subdur    1:*D          cdat
1296002203140297 C                   movel     cdat          svdtrm
129700220314     C                   eval      sdcdate = %char(svdtrm)
129800220308     C                   endif
129900220308      *
130000210827     C                   eval      sdbamt = %editc(benamt:'Z')
130100210903      *
130200210903     C                   eval      sdcovl = 'ESP'
130300210903      *
130400210903     C                   select
130500210903      *
130600220615     C                   when      xmcovtp = 'TIN'
130700210903     C                   eval      sdcovl = 'EMP'
130800220615     C                   when      xmcovtp = 'THW'
130900210903     C                   eval      sdcovl = 'ESP'
131000220615     C                   when      xmcovtp = 'TFA'
131100210903     C                   eval      sdcovl = 'FAM'
131200220615     C                   when      xmcovtp = 'TPC'
131300210903     C                   eval      sdcovl = 'E1D'
131400220615     C                   when      xmcovtp = 'TP2'
131500210903     C                   eval      sdcovl = 'ECH'
131600210903     C                   endsl
131700210903      *
131800210916      *
131900210916     C                   eval      plif = '1'
132000210916      *
132100210930     C****               exsr      setsub
132200210930     C                   eval      epsubcl = hldsub
132300210916      *
132400210827     C                   update    ren834r
1325002108270107  *
132600210827     C                   leavesr
132700210827     C                   endif
1328002108270107  *
1329002108270107  *
1330002202090296 C                   If        plncat = 'PVL' or plncat = 'PLT'
133100210827      *         Process Long Trm Dis Coverage
133200210827     C                   movel     policy#       ldacct#
133300210827     C                   movel     'LTD'         ldtype
133400220314     C                   eval      ldedate = %char(svdeff)
133500220308      *
133600220314     C                   if        svdtrm <> 0
133700220314     C                   movel     svdtrm        cdat
1338002203080297 C     cdat          subdur    1:*D          cdat
1339002203140297 C                   movel     cdat          svdtrm
134000220314     C                   eval      ldcdate = %char(svdtrm)
134100220308     C                   endif
134200220308      *
134300210827     C                   eval      ldbamt = %editc(benamt:'Z')
134400210827      *
134500210903      *
134600210903     C                   eval      ldcovl = 'ESP'
134700210903      *
134800210903     C                   select
134900210903      *
135000220615     C                   when      xmcovtp = 'TIN'
135100210903     C                   eval      ldcovl = 'EMP'
135200220615     C                   when      xmcovtp = 'THW'
135300210903     C                   eval      ldcovl = 'ESP'
135400220615     C                   when      xmcovtp = 'TFA'
135500210903     C                   eval      ldcovl = 'FAM'
135600220615     C                   when      xmcovtp = 'TPC'
135700210903     C                   eval      ldcovl = 'E1D'
135800220615     C                   when      xmcovtp = 'TP2'
135900210903     C                   eval      ldcovl = 'ECH'
136000210903     C                   endsl
136100210903      *
136200210916      *
136300210916     C                   eval      plif = '1'
136400210916      *
136500210930     C****               exsr      setsub
136600210930     C                   eval      epsubcl = hldsub
136700210917      *
136800210917     C                   update    ren834r
1369002109170107  *
137000210917     C                   leavesr
137100210917     C                   endif
1372002109170107  *
1373002108270107  *
1374002109170296 C                   If        plncat = 'PEP'
137500210827      *         Process EAP Coverage
137600210827     C                   movel     policy#       epacct#
137700210827     C                   movel     'EAP'         eptype
137800220314     C                   eval      epedate = %char(svdeff)
137900220308      *
138000220811     C                   if        svdtrm <> 0
138100220811     C                   movel     svdtrm        cdat
1382002208110297 C     cdat          subdur    1:*D          cdat
1383002208110297 C                   movel     cdat          svdtrm
138400220811     C                   eval      epcdate = %char(svdtrm)
138500220811     C                   endif
138600220811      *
138700220811     C                   eval      epbamt = %editc(benamt:'Z')
138800220811      *
138900220811     C                   eval      epcovl = 'ESP'
139000220811      *
139100220811     C                   select
139200220811      *
139300220615     C                   when      xmcovtp = 'TIN'
139400220811     C                   eval      epcovl = 'EMP'
139500220811     C                   when      xmcovtp = 'THW'
139600220811     C                   eval      epcovl = 'ESP'
139700220615     C                   when      xmcovtp = 'TFA'
139800210903     C                   eval      epcovl = 'FAM'
139900220615     C                   when      xmcovtp = 'TPC'
140000210903     C                   eval      epcovl = 'E1D'
140100220615     C                   when      xmcovtp = 'TP2'
140200210903     C                   eval      epcovl = 'ECH'
140300210903     C                   endsl
140400210903      *
140500210916      *
140600210916     C                   eval      peap = '1'
140700210916      *
140800210930     C****               exsr      setsub
140900210930     C                   eval      epsubcl = hldsub
141000210827      *
141100210827     C                   update    ren834r
1412002108270107  *
141300210827     C                   leavesr
141400210827     C                   endif
1415002108270107  *
141600210827     C                   endsr
141700210827      *
1418002207280107  ********************************************************************************
1419002207280107  *
1420002207280107  *     ADDCVGX - Add dep coverage data to mbr record
1421002207280107  *               Already have REN dep rec, dcov + plnmst records
1422002207280107  *
1423002207280107  ********************************************************************************
142400220728     C     addcvgx       begsr
1425002207280107  *
1426002207280107  *  Set REN Key values for mbr
142700220801     C                   eval      xmemid = %editc(mbssno:'X')
142800220801     C                   eval      xmbrssn = %editc(mbssno:'X')
142900220801     C                   eval      xdob = %char(birth)
143000220801     C                   movel(P)  mlname        xlname
143100220801     C                   movel(P)  mfname        xfname
143200220801     C                   movel     mmi           xmi
1433002208010291  *
1434002208010297 C     renkyx        chain     ren834p                            41
1435002207280296 C                   If        *in41 = '0'
1436002207280107  *
1437002207280296 C                   If        plncat = 'PSP' or plncat = 'PSA'
1438002207280296 C                   If        sltype = *blanks
143900220728      *         Process Spouse Life or ADD coverage
144000220728     C                   movel     policy#       slacct#
144100220728     C                   movel     'SSL'         sltype
144200220728     C                   eval      sledate = %char(svdeff)
144300220728      *
144400220728     C                   if        svdtrm <> 0
144500220728     C                   movel     svdtrm        cdat
1446002207280297 C     cdat          subdur    1:*D          cdat
1447002207280297 C                   movel     cdat          svdtrm
144800220728     C                   eval      slcdate = %char(svdtrm)
144900220728     C                   endif
145000220728      *
145100220728     C                   eval      slbamt = %editc(benamt:'Z')
145200220728      *
145300220728     C                   eval      slcovl = 'ESP'
145400220728      *
145500220728     C                   select
145600220728      *
145700220728     C                   when      xmcovtp = 'TIN'
145800220728     C                   eval      slcovl = 'EMP'
145900220728     C                   when      xmcovtp = 'THW'
146000220728     C                   eval      slcovl = 'ESP'
146100220728     C                   when      xmcovtp = 'TFA'
146200220728     C                   eval      slcovl = 'FAM'
146300220728     C                   when      xmcovtp = 'TPC'
146400220728     C                   eval      slcovl = 'E1D'
146500220728     C                   when      xmcovtp = 'TP2'
146600220728     C                   eval      slcovl = 'ECH'
146700220728     C                   endsl
146800220728      *
146900220728      *
147000220728     C                   eval      plif = '1'
147100220728      *
147200220728     C****               exsr      setsub
147300220728     C                   eval      epsubcl = hldsub
147400220728      *
147500220728     C                   update    ren834r
1476002207280107  *
147700220728     C                   endif
147800220728     C                   leavesr
147900220728     C                   endif
1480002207280107  *
1481002207280107  *
1482002207280296 C                   If        plncat = 'PSD' or plncat = 'PAA'
1483002207280296 C                   If        sltype = *blanks
148400220728      *         Process Dep Life or ADD coverage
148500220728     C                   movel     policy#       dlacct#
148600220728     C                   movel     'SDL'         dltype
148700220728     C                   eval      dledate = %char(svdeff)
148800220728      *
148900220728     C                   if        svdtrm <> 0
149000220728     C                   movel     svdtrm        cdat
1491002207280297 C     cdat          subdur    1:*D          cdat
1492002207280297 C                   movel     cdat          svdtrm
149300220728     C                   eval      dlcdate = %char(svdtrm)
149400220728     C                   endif
149500220728      *
149600220728     C                   eval      dlbamt = %editc(benamt:'Z')
149700220728      *
149800220728      *
149900220728     C                   eval      dlcovl = 'ESP'
150000220728      *
150100220728     C                   select
150200220728      *
150300220728     C                   when      xmcovtp = 'TIN'
150400220728     C                   eval      dlcovl = 'EMP'
150500220728     C                   when      xmcovtp = 'THW'
150600220728     C                   eval      dlcovl = 'ESP'
150700220728     C                   when      xmcovtp = 'TFA'
150800220728     C                   eval      dlcovl = 'FAM'
150900220728     C                   when      xmcovtp = 'TPC'
151000220728     C                   eval      dlcovl = 'E1D'
151100220728     C                   when      xmcovtp = 'TP2'
151200220728     C                   eval      dlcovl = 'ECH'
151300220728     C                   endsl
151400220728      *
151500220728      *
151600220728     C                   eval      plif = '1'
151700220728      *
151800220728     C****               exsr      setsub
151900220728     C                   eval      epsubcl = hldsub
152000220728      *
152100220728     C                   update    ren834r
1522002207280107  *
152300220728     C                   endif
152400220728     C                   leavesr
152500220728     C                   endif
1526002207280107  *
152700220728     C                   endif
1528002207280107  *
152900220728     C                   endsr
1530002207280107  ********************************************************************************
1531002109170107  *
1532002109170107  *     SETSUB - Set the Subclient/Location code based on Prods
1533002109170107  *
1534002109170107  ********************************************************************************
153500210917     C     setsub        begsr
1536002109170107  *
153700210917      *
153800210917     C                   eval      epsubcl = '     '
153900210917     C                   select
154000211025      *   No VIS
154100210917     C                   when      epprods = '1 11'
154200210917     C                   eval      epsubcl = '10000'
154300211025     C                   when      epprods = '1 1 '
154400211025     C                   eval      epsubcl = '10000'
154500211025     C                   when      epprods = '1  1'
154600211025     C                   eval      epsubcl = '10000'
154700220812      *    DEN + VIS + LIF/DIS/EAP
154800220812     C                   when      epprods = '1111'
154900220812     C                   eval      epsubcl = '29511'
155000220812     C                   when      epprods = '111 '
155100210917     C                   eval      epsubcl = '29511'
155200220812     C                   when      epprods = '11 1'
155300220812     C                   eval      epsubcl = '29511'
155400220812      *   LIF/DIS only
155500220812     C                   when      epprods = '  11'
155600220812     C                   eval      epsubcl = '88888'
155700220812     C                   when      epprods = '  1 '
155800220812     C                   eval      epsubcl = '88888'
155900211105      *   EAP only
156000211105     C                   when      epprods = '   1'
156100211105     C                   eval      epsubcl = '89001'
156200211105      *   No DEN
156300211105     C                   when      epprods = '  11'
156400211112     C                   eval      epsubcl = '99511'
156500211105     C                   when      epprods = ' 111'
156600211112     C                   eval      epsubcl = '99511'
156700211105     C                   when      epprods = ' 1 1'
156800211112     C                   eval      epsubcl = '99511'
156900211025     C                   when      epprods = ' 11 '
157000211112     C                   eval      epsubcl = '99511'
157100211025     C                   endsl
157200210930      *
157300210930     C                   eval      hldsub = epsubcl
1574002109170107  *
157500210917     C                   endsr
157600210917      *
1577002110260107  ********************************************************************************
1578002110260107  *
1579002110260107  *     UPDDEP - Update dep recs based on Mbr settings
1580002110260107  *
1581002110260107  ********************************************************************************
158200211026     C     upddep        begsr
1583002110260107  *
1584002110260291  *  Loop thru REN834L
1585002208220297 C                   UNLOCK    REN834p
1586002208220297 C     *loval        setll     ren834l                            61
1587002110260296 C                   dou       *in61 = '1'
1588002208220297 C                   read      ren834l                              6161
1589002111020296 C                   If        *in61 = '1'
159000211102     C                   leavesr
159100211102     C                   endif
159200211102      *
1593002208220296 C                   If        xmemid = '562335131'
159400211102     C                   eval      xrecid = xrecid
159500211102     C                   endif
159600211102      *
1597002111020296 C                   If        xrecid = '01'
159800211102     C                   eval      svmemid = xmemid
159900211102     C                   eval      svepsubcl = xepsubcl
160000211102     C                   eval      usedep = 'Y'
1601002111020296 C                   If        xepsubcl = '88888' or xepsubcl = '890001'
160200211026     C                   eval      usedep = 'N'
160300211026     C                   endif
160400211026     C                   iter
160500211026     C                   endif
1606002110260291  *     Process Dep rec
160700220315     C                   if        svmemid = xmemid
160800220315     C                   if        usedep = 'N' or
160900220315     C                             (xden = ' ' and xvis = ' ')
161000220315     C                   delete    ren834x
161100220315     C                   iter
161200220315     C                   endif
161300220315      *
161400220315     C                   eval      xepsubcl = svepsubcl
161500220315     C                   update    ren834x
161600220315     C                   iter
161700220315     C                   endif
161800211112      *
161900211112     C                   enddo
162000211026      *
162100211026     C                   endsr
