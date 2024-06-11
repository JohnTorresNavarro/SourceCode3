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
001600020404     FMEMBER    IF   E           K DISK
001700020404     FGRAT24    IF   E           K DISK
001800020404     FDCOV      IF   E           K DISK
001900220302     FHISTLF    IF   E           K DISK
002000020404     FDEPNDC    IF   E           K DISK
0021002108250020 FREN834P   UF A E           K DISK
0022002110260020 FREN834L   UF   E           K DISK    PREFIX(X) RENAME(REN834R:REN834X)
0023000204020025  *
002400200529      *
0025002005290250 D                 DS
0026002108270251 D  cursalary9             1      9
0027002108270251 D   cursalary             2      9
002800210827      *
0029002203020250 D                 DS
0030002203020251 D  hiskey                 1     10
0031002203020251 D   hiskey9               2     10
003200220302      *
0033002108270250 D                 DS
0034002108270251 D  fill66                 1     66
0035002108270251 D   gemail                1     65
003600211227      *
0037002112270250 D                 DS
0038002112270251 D  epprods                1      4
0039002112270251 D   pden                  1      1
0040002112270251 D   pvis                  2      2
0041002112270251 D   plif                  3      3
0042002112270251 D   peap                  4      4
004300211227      *
0044002112270250 D                 DS
0045002112270251 D  xepprods               1      4
0046002112270251 D   xden                  1      1
0047002112270251 D   xvis                  2      2
0048002112270251 D   xlif                  3      3
0049002110260251 D   xeap                  4      4
005000211026      *
0051002005290250 D                 DS
0052002005290251 D  reccnt                 1      9S 0 INZ(0)
0053002005290251 D  reccna                 1      9
005400210727      *
0055002107270250 D                 DS
0056002107270251 D  dseq                          2S 0 INZ(0)
0057002107270251 D  cutoff                         D   DATFMT(*ISO)
0058002107270251 D  cutofx                         D   DATFMT(*ISO)
0059002107270251 D  cutofy                         D   DATFMT(*ISO)
0060002203080251 D  cdat                           D   DATFMT(*ISO)
0061002203080251 D  cndat                         8S 0
0062002203080251 D  cutofn                        8S 0
0063002107270251 D  cutofa                        8S 0
0064002107270251 D  today8                        8S 0
0065002108260251 D  yrsService                    8S 0
0066002107270251 D  updt                          1A
0067002110260251 D  usedep                        1A
0068002108260251 D  hiredatet                      D
0069002108270251 D  todad                          D
007000210727      *
0071002107090251 D  todaa                              LIKE(frmdat)
0072002107090251 D  date9                              LIKE(frmdat)
007300210825      *
0074002108250251 D  kmemid                             LIKE(memid)
0075002110260251 D  svmemid                            LIKE(memid)
0076002110260251 D  svepsubcl                          LIKE(epsubcl)
0077002108250251 D  kmbrssn                            LIKE(mbrssn)
0078002108250251 D  kdob                               LIKE(dateofbth)
0079002108250251 D  klname                             LIKE(lastname)
0080002108250251 D  kfname                             LIKE(firstname)
0081002108250251 D  kmi                                LIKE(mi)
0082002109300251 D  hldsub                             LIKE(epsubcl)
008300210709      *
008400210709      *
008500210825     C     renky         klist
008600210825     C                   kfld                    kmemid
008700210825     C                   kfld                    kmbrssn
008800210825     C                   kfld                    kdob
008900210825     C                   kfld                    klname
009000210825     C                   kfld                    kfname
009100210825     C                   kfld                    kmi
009200210825      *
009300210825     C     accky         klist
009400210825     C                   kfld                    mbtrst
009500210825     C                   kfld                    mbsub#
009600210825     C                   kfld                    mbacct
009700210825      *
009800210825     C     grkey         klist
009900210825     C                   kfld                    pltrst
010000210825     C                   kfld                    plsub#
010100210825     C                   kfld                    plplan
010200210825     C                   kfld                    date9
010300081103      *
010400041228     C     mcvky         klist
010500081103     C                   kfld                    pltrst
010600081103     C                   kfld                    plsub#
010700081103     C                   kfld                    plplan
010800081103      *
010900020404     C     depky         klist
011000210827     C                   kfld                    ssno
011100210723     C                   kfld                    dseq#
011200220218      *
0113002107230291  *   Preprocessing
0114002107230297 C                   movel     UDATE         cutoff
0115002107230297 C                   movel     cutoff        today8
0116002107230297 C                   movel     cutoff        todaa
0117002109080297 C                   movel     cutoff        todad
0118002107230297 C                   z-add     99999999      date9
0119002109080291  * Determine Term date cutoff to start - 90 days prior to term dt
0120002109080297 C     cutoff        subdur    90:*D         cutofx
0121002107230297 C                   movel     cutofx        cutofn
0122002107230291  * Determine Term date cutoff to end - 60 days after term dt
0123002109080297 C     cutoff        adddur    60:*D         cutofy
0124002109080297 C                   movel     cutofy        cutofa
0125000204040291  *
0126000501110291  * Main Line - Loop thru plan master
0127002202250291  *
0128002109080297 C     'REN'         setll     plnmstn1                           21
0129002109080296 C                   dou       *in21 = '1'
0130002109290297 C     'REN'         reade     plnmstn1                               21
0131002111240296 C                   If        *in21 = '0'
0132002202090291  *       Debug shit
0133002202090296 C                   If        plplan = 'NENW'
0134002202090297 C                   eval      plplan = plplan
0135002202090297 C                   endif
0136002202090291  *     Using GBS info - Get GRATE record
0137002202090297 C     grkey         setll     grat24                             22
0138002202090297 C                   readp     grat24                                 22
0139002202090296 C                   If        *in22 = '0'
0140002111240291  *
0141002111240291  *        Loop thru mcov file using T,S,P
0142002111240297 C     mcvky         setll     mcov42                             31
0143002111240296 C                   dou       *in31 = '1'
0144002111240297 C     mcvky         reade     mcov42                                 31
0145002111240296 C                   If        *in31 = '0' and pltrst = mctrst and
0146002110250296 C                             plsub# = mcsub# and plplan = mcplan and
0147002110250296 C                             (candt = 0 or candt > enrldt)
0148002110200291  *
0149002110200296 C                   If        candt = enrldt
0150002110200296 C                   Iter
0151002109210296 C                   endif
0152002110200291  *
0153002110200296 C                   If        candt = 0 or candt > cutofn
0154002110200296 C                   If        candt = 0 or candt < cutofa
0155002110200291  *
0156002110200291  *        Get member record
0157002110290297 C     mcssno        chain     member                             32
0158002110290296 C                   If        *in32 = '0'
0159002110290291  *
0160002202180296 C                   If        mcssno = 040809725
0161002201140297 C                   eval      mcssno = mcssno
0162002201140296 C                   endif
0163002201140291  *
0164002110290291 C                   exsr      chkmbr
0165002110290291  *
0166002110290291 C                   exsr      lokdep
0167002110290291  *
0168002110290297 C                   endif                                                  *in33 = '1'
0169002110290297 C                   endif                                                  *in32 = '0'
0170002111050297 C                   endif                                                  *in32 = '0'
0171002111050297 C                   endif                                                  *in32 = '0'
0172002110290291  *
0173002203040297 C                   enddo                                                  *in33 = '1'
0174002111050291  *
0175002111050297 C                   endif                                                  *in32 = '0'
0176002203040291  *
0177002203040297 C                   endif                                                  *in32 = '0'
0178002203040291  *
0179002203040297 C                   enddo                                                  *in31 = '1'
0180002203040291  *
0181002203040291 C                   exsr      upddep
0182002203040291  *
0183002203040297 C                   movel     '1'           *inlr
0184002203040297 C                   return
0185000204020107  ********************************************************************************
0186000204020107  *
0187002108250107  *     CHKMBR - Check for Member record
0188000204020107  *
0189000204020107  ********************************************************************************
019000210825     C     chkmbr        begsr
0191002005280107  *
0192002108250107  *  Set REN Key values
019300211104     C                   eval      kmemid = %editc(mbssno:'X')
019400211104     C                   eval      kmbrssn = %editc(mbssno:'X')
019500211104     C                   eval      kdob = %char(birth)
019600211104     C                   movel(P)  mlname        klname
019700211104     C                   movel(P)  mfname        kfname
019800220114     C                   movel     mmi           kmi
0199002108270291  *        See if record already exists
0200002108310297 C     renky         chain     ren834p                            41
0201002111040296 C                   If        *in41 = '1'
020200210831      *          If not - create member record
020300211104     C                   exsr      crtmbr
020400210831      *
0205002108310291  *          Retrieve just created member record
0206002108310297 C     renky         chain     ren834p                            41
0207002109010296 C                   If        *in41 = '1'
0208002109010291  *             WHAT????
020900210901     C                   eval      mi = mi
021000210901     C                   endif
021100210901      *
021200210901     C                   endif
021300210901      *          Add coverge data to mbr rec
021400210901     C                   exsr      addcvgm
0215000907010107  *
021600090701     C                   endsr
0217002108250107  ********************************************************************************
0218002108250107  *
0219002108250107  *     CRTMBR - Create Member rec - load demographics
0220002108250107  *
0221002108250107  ********************************************************************************
022200210825     C     crtmbr        begsr
0223002108310107  *
022400211108     C                   clear                   ren834r
022500211108     C                   eval      recid = '01'
022600211108     C                   eval      prkeyty = 'S'
022700211108     C                   eval      relcd = 'EE'
0228002111080107  *
022900211108     C                   eval      epprods = '    '
0230002111080291  *        Get Account data
0231002111080297 C     accky         chain     accmst                             51
0232002111080296 C                   If        *in51 = '0'
023300211108     C                   movel(P)  acnam1        groupnam
023400211108     C                   endif
023500211108      *
0236002111080297 C     accky         chain     ac2mstl2                           51
0237002111080296 C                   If        *in51 = '0'
023800211108     C                   eval      grouptid = %editc(a2tax_id#:'X')
023900211105     C                   endif
024000211108      *      Mbr demo data
024100210922     C                   eval      memid = %editc(mbssno:'X')
024200210922     C                   eval      dateofbth = %char(birth)
024300210922     C                   movel     mlname        lastname
024400210922     C                   movel     mfname        firstname
024500210831     C                   movel     mmi           mi
024600210831     C                   movel     sex           gender
024700210831     C                   eval      mbrssn = %editc(mbssno:'X')
024800210826     C                   eval      cphone = %editc(area:'X') + %editc(phone:'X')
024900210826     C                   movel     addr1         address1
025000210826     C                   movel     addr2         address2
025100210826     C                   movel     city          ccity
025200210826     C                   movel     state         cstate
025300210826     C                   eval      czip = %editc(zip:'X')
025400210825      *
0255002108260296 C                   If        hndicp > ' '
025600210826     C                   eval      disabled = 'H'
025700210826     C                   endif
025800210826      *
0259002108260296 C                   If        salary > 0
026000210827     C                   eval      cursalary9 = %editc(salary:'Z')
026100210826     C                   eval      salfreq = 'A'
026200220302     C                   eval      saldate = %char(mbenrl)
0263002203030291  *        Look for change of salary
026400220303     C                   eval      hiskey9 = %editc(mbssno:'X')
0265002203030297 C     hiskey        setll     histlf                             53
0266002203030296 C                   dou       *in53 = '1'
0267002203030297 C     hiskey        reade     histlf                                 53
0268002203030296 C                   If        *in53 = '0'
0269002203030296 C                   If        trcode = 'ASC' or trcode = 'M17'
027000220303     C                   eval      saldate = %char(covtdt)
0271002203080297 C                   leave
0272002203080297 C                   endif
0273002203080297 C                   endif
0274002203030291  *
0275002203080297 C                   enddo                                                            '
0276002203030107  *
027700220303     C                   endif
027800210826      *
0279002109020296 C                   If        empdt > 0
028000210902     C                   eval      hiredate = %char(empdt)
028100210902     C                   eval      hiredateT = %date(empdt)
0282002109030297 C     todad         subdur    hiredatet     yrsService:*Y
028300210903     C                   eval      yrofServ = %editw(yrsService:'       0')
0284002109030296 C                   If        yrsService = 0
028500210903     C                   eval      yrofserv = '       0'
028600210903     C                   endif
028700210831     C                   endif
028800210903      *
028900210908     C                   movel     fill66        email
029000210908      *
029100210908     C                   eval      estatus = 'A'
0292002109080296 C                   If        empst <> 'A'
029300210908     C                   eval      estatus = 'I'
029400210908     C                   endif
029500210908      *
029600210908     C                   eval      tssn = %editc(mbssno:'X')
029700220211     C                   eval      feditin = %editc(mbssno:'X')
029800220211     C                   eval      policy# = %subst(group#:1:7)
029900210908      *
030000220211      *
030100220211     C                   write     ren834r
0302002108260107  *
030300210826     C                   endsr
030400220211      *
0305002108260107  ********************************************************************************
0306002108260107  *
0307002108260107  *     ADDCVGM - Add coverage data to member record
0308002108260107  *               Already have REN mbr rec, mcov + plnmst records
0309002108260107  *
0310002108260107  ********************************************************************************
031100210826     C     addcvgm       begsr
0312002108260107  *
0313002108260296 C                   If        plncat = 'PDN'
031400210826      *         Process Dental Coverage
031500210902     C                   movel     policy#       dacct#
031600210909     C                   movel     'DEN'         dtype
031700210909     C                   eval      dcovedate = %char(enrldt)
031800220308      *
031900220308     C                   if        candt <> 0
032000220308     C                   movel     candt         cdat
0321002203080297 C     cdat          subdur    1:*D          cdat
0322002203080297 C                   movel     cdat          candt
032300220308     C                   eval      dcovcdate = %char(candt)
032400220308     C                   endif
032500210909      *
032600210909     C                   eval      dencovl = 'ESP'
032700210909      *
032800210909     C                   select
032900211026      *
033000211026     C                   when      mcovtp = 'TIN'
033100211026     C                   eval      dencovl = 'EMP'
033200211026     C                   when      mcovtp = 'THW'
033300211026     C                   eval      dencovl = 'ESP'
033400211026     C                   when      mcovtp = 'TFA'
033500211026     C                   eval      dencovl = 'FAM'
033600211026     C                   when      mcovtp = 'TPC'
033700211026     C                   eval      dencovl = 'E1D'
033800211026     C                   when      mcovtp = 'TP2'
033900211026     C                   eval      dencovl = 'ECH'
034000211026     C                   endsl
034100211026      *
034200211026     C                   eval      decovin = 'Y'
0343002109020107  *
0344002109020296 C                   If        mcovtp = 'TPC' or mcovtp = 'TP2'
034500210902     C                   eval      dccovin = 'Y'
034600210902     C                   endif
0347002108260107  *
0348002108260296 C                   If        mcovtp = 'THW'
034900210826     C                   eval      dscovin = 'Y'
035000210826     C                   endif
0351002108260107  *
0352002108260296 C                   If        mcovtp = 'TFA'
035300210826     C                   eval      dscovin = 'Y'
035400210826     C                   eval      dccovin = 'Y'
035500210826     C                   endif
035600210826      *
035700210916     C                   eval      pden = '1'
035800210916      *
035900210917     C                   exsr      setsub
036000210930      *
036100210826     C                   update    ren834r
0362002108260107  *
036300210826     C                   leavesr
036400210826     C                   endif
0365002108260107  *
0366002108260107  *
0367002108260296 C                   If        plncat = 'PVS'
036800210826      *         Process Vision Coverage
036900210826     C                   movel     policy#       vacct#
037000210826     C                   movel     'VIS'         vtype
037100210826     C                   eval      vcovedate = %char(enrldt)
037200220308      *
037300220308     C                   if        candt <> 0
037400220308     C                   movel     candt         cdat
0375002203080297 C     cdat          subdur    1:*D          cdat
0376002203080297 C                   movel     cdat          candt
037700220308     C                   eval      vcovcdate = %char(candt)
037800220308     C                   endif
037900210903      *
038000210903      *
038100210903     C                   eval      viscovl = 'ESP'
038200210903      *
038300210903     C                   select
038400210903      *
038500210910     C                   when      mcovtp = 'TIN'
038600210910     C                   eval      viscovl = 'EMP'
038700210910     C                   when      mcovtp = 'THW'
038800210910     C                   eval      viscovl = 'ESP'
038900210910     C                   when      mcovtp = 'TFA'
039000210910     C                   eval      viscovl = 'FAM'
039100210910     C                   when      mcovtp = 'TPC'
039200210903     C                   eval      viscovl = 'E1D'
039300210910     C                   when      mcovtp = 'TP2'
039400210910     C                   eval      viscovl = 'ECH'
039500210910     C                   endsl
039600210903      *
039700210826     C                   eval      vecovin = 'Y'
0398002108260107  *
0399002108260296 C                   If        mcovtp = 'TPC' or mcovtp = 'TP2'
040000210826     C                   eval      vccovin = 'Y'
040100210826     C                   endif
0402002108260107  *
0403002108260296 C                   If        mcovtp = 'THW'
040400210827     C                   eval      vscovin = 'Y'
040500210826     C                   endif
0406002108260107  *
0407002108260296 C                   If        mcovtp = 'TFA'
040800210826     C                   eval      vscovin = 'Y'
040900210826     C                   eval      vccovin = 'Y'
041000210826     C                   endif
041100210826      *
041200210916      *
041300210916     C                   eval      pvis = '1'
041400210916      *
041500210917     C                   exsr      setsub
041600210916      *
041700210826     C                   update    ren834r
0418002109160107  *
041900210826     C                   leavesr
042000210826     C                   endif
0421002108260107  *
0422002108260107  *
0423002108260296 C                   If        plncat = 'PLF'
042400210826      *         Process EE Life Coverage
042500210826     C                   movel     policy#       elacct#
042600210827     C                   movel     'LIF'         eltype
042700210826     C                   eval      eledate = %char(enrldt)
042800220308      *
042900220308     C                   if        candt <> 0
043000220308     C                   movel     candt         cdat
0431002203080297 C     cdat          subdur    1:*D          cdat
0432002203080297 C                   movel     cdat          candt
043300220308     C                   eval      elcdate = %char(candt)
043400220308     C                   endif
043500220308      *
043600210827     C                   eval      elbamt = %editc(benamt:'Z')
043700210903      *
043800210903      *
043900210903     C                   eval      elcovl = 'ESP'
044000210903      *
044100210903     C                   select
044200210903      *
044300210903     C                   when      mcovtp = 'TIN'
044400210903     C                   eval      elcovl = 'EMP'
044500210903     C                   when      mcovtp = 'THW'
044600210903     C                   eval      elcovl = 'ESP'
044700210903     C                   when      mcovtp = 'TFA'
044800211028     C                   eval      elcovl = 'FAM'
044900211028     C                   when      mcovtp = 'TPC'
045000211028     C                   eval      elcovl = 'E1D'
045100211028     C                   when      mcovtp = 'TP2'
045200211028     C                   eval      elcovl = 'ECH'
045300211028     C                   endsl
045400211028      *
045500211028     C                   eval      plif = '1'
045600211028      *
045700211028     C                   exsr      setsub
045800211028      *
045900211028     C                   update    ren834r
0460002110280107  *
046100210826     C                   leavesr
046200210826     C                   endif
0463002108260107  *
0464002108270107  *
0465002108270296 C                   If        plncat = 'PAC'
046600210827      *         Process EE ADD Coverage
046700210827     C                   movel     policy#       eaacct#
046800210827     C                   movel     'ADD'         eatype
046900210827     C                   eval      eaedate = %char(enrldt)
047000220308      *
047100220308     C                   if        candt <> 0
047200220308     C                   movel     candt         cdat
0473002203080297 C     cdat          subdur    1:*D          cdat
0474002203080297 C                   movel     cdat          candt
047500220308     C                   eval      eacdate = %char(candt)
047600220308     C                   endif
047700220308      *
047800210827     C                   eval      eabamt = %editc(benamt:'Z')
047900210903      *
048000210903      *
048100210903     C                   eval      eacovl = 'ESP'
048200210903      *
048300210903     C                   select
048400210903      *
048500210903     C                   when      mcovtp = 'TIN'
048600210903     C                   eval      eacovl = 'EMP'
048700210903     C                   when      mcovtp = 'THW'
048800210903     C                   eval      eacovl = 'ESP'
048900210903     C                   when      mcovtp = 'TFA'
049000210903     C                   eval      eacovl = 'FAM'
049100210903     C                   when      mcovtp = 'TPC'
049200210903     C                   eval      eacovl = 'E1D'
049300210903     C                   when      mcovtp = 'TP2'
049400210903     C                   eval      eacovl = 'ECH'
049500210903     C                   endsl
049600210903      *
049700210916      *
049800210916     C                   eval      plif = '1'
049900210916      *
050000210917     C                   exsr      setsub
050100210827      *
050200210827     C                   update    ren834r
0503002109160107  *
050400210827     C                   leavesr
050500210827     C                   endif
0506002108270107  *
0507002108270107  *
0508002108270296 C                   If        plncat = 'POA'
050900210827      *         Process EE Sup Life Coverage
051000210827     C                   movel     policy#       easacct#
051100210827     C                   movel     'SEA'         eastype
051200210827     C                   eval      easedate = %char(enrldt)
051300220308      *
051400220308     C                   if        candt <> 0
051500220308     C                   movel     candt         cdat
0516002203080297 C     cdat          subdur    1:*D          cdat
0517002203080297 C                   movel     cdat          candt
051800220308     C                   eval      eascdate = %char(candt)
051900220308     C                   endif
052000220308      *
052100210827     C                   eval      easbamt = %editc(benamt:'Z')
052200210903      *
052300210903      *
052400210903     C                   eval      eascovl = 'ESP'
052500210903      *
052600210903     C                   select
052700210903      *
052800210903     C                   when      mcovtp = 'TIN'
052900210903     C                   eval      eascovl = 'EMP'
053000210903     C                   when      mcovtp = 'THW'
053100210903     C                   eval      eascovl = 'ESP'
053200210903     C                   when      mcovtp = 'TFA'
053300210903     C                   eval      eascovl = 'FAM'
053400210903     C                   when      mcovtp = 'TPC'
053500210903     C                   eval      eascovl = 'E1D'
053600210903     C                   when      mcovtp = 'TP2'
053700210903     C                   eval      eascovl = 'ECH'
053800210903     C                   endsl
053900210903      *
054000210916      *
054100210916     C                   eval      plif = '1'
054200210916      *
054300210917     C                   exsr      setsub
054400210827      *
054500210827     C                   update    ren834r
0546002108270107  *
054700210827     C                   leavesr
054800210827     C                   endif
0549002108270107  *
0550002108270107  *
0551002108270296 C                   If        plncat = 'PSL'
055200210827      *         Process EE Sup Life Coverage
055300210827     C                   movel     policy#       elsacct#
055400210827     C                   movel     'SEL'         elstype
055500210827     C                   eval      elsedate = %char(enrldt)
055600220308      *
055700220308     C                   if        candt <> 0
055800220308     C                   movel     candt         cdat
0559002203080297 C     cdat          subdur    1:*D          cdat
0560002203080297 C                   movel     cdat          candt
056100220308     C                   eval      elscdate = %char(candt)
056200220308     C                   endif
056300220308      *
056400210827     C                   eval      elsbamt = %editc(benamt:'Z')
056500210903      *
056600210903     C                   eval      elscovl = 'ESP'
056700210903      *
056800210903     C                   select
056900210903      *
057000210903     C                   when      mcovtp = 'TIN'
057100210903     C                   eval      elscovl = 'EMP'
057200210903     C                   when      mcovtp = 'THW'
057300210903     C                   eval      elscovl = 'ESP'
057400210903     C                   when      mcovtp = 'TFA'
057500210903     C                   eval      elscovl = 'FAM'
057600210903     C                   when      mcovtp = 'TPC'
057700210903     C                   eval      elscovl = 'E1D'
057800210903     C                   when      mcovtp = 'TP2'
057900210903     C                   eval      elscovl = 'ECH'
058000210903     C                   endsl
058100210903      *
058200210916      *
058300210916     C                   eval      plif = '1'
058400210916      *
058500210917     C                   exsr      setsub
058600210827      *
058700210827     C                   update    ren834r
0588002108270107  *
058900210827     C                   leavesr
059000210827     C                   endif
0591002108270107  *
0592002108270107  *
0593002108270107  *
0594002108270296 C                   If        plncat = 'PSP' or plncat = 'PSA'
0595002108270296 C                   If        sltype = *blanks
059600210827      *         Process Spouse Life or ADD coverage
059700210827     C                   movel     policy#       slacct#
059800210827     C                   movel     'SSL'         sltype
059900210827     C                   eval      sledate = %char(enrldt)
060000220308      *
060100220308     C                   if        candt <> 0
060200220308     C                   movel     candt         cdat
0603002203080297 C     cdat          subdur    1:*D          cdat
0604002203080297 C                   movel     cdat          candt
060500220308     C                   eval      slcdate = %char(candt)
060600220308     C                   endif
060700220308      *
060800210827     C                   eval      slbamt = %editc(benamt:'Z')
060900210903      *
061000210903     C                   eval      slcovl = 'ESP'
061100210903      *
061200210903     C                   select
061300210903      *
061400210903     C                   when      mcovtp = 'TIN'
061500210903     C                   eval      slcovl = 'EMP'
061600210903     C                   when      mcovtp = 'THW'
061700210903     C                   eval      slcovl = 'ESP'
061800210903     C                   when      mcovtp = 'TFA'
061900210903     C                   eval      slcovl = 'FAM'
062000210903     C                   when      mcovtp = 'TPC'
062100210903     C                   eval      slcovl = 'E1D'
062200210903     C                   when      mcovtp = 'TP2'
062300210903     C                   eval      slcovl = 'ECH'
062400210903     C                   endsl
062500210903      *
062600210916      *
062700210916     C                   eval      plif = '1'
062800210916      *
062900210917     C                   exsr      setsub
063000210827      *
063100210827     C                   update    ren834r
0632002109160107  *
063300210827     C                   endif
063400210827     C                   leavesr
063500210827     C                   endif
0636002108270107  *
0637002108270107  *
0638002108270296 C                   If        plncat = 'PSD' or plncat = 'PAA'
0639002108270296 C                   If        sltype = *blanks
064000210827      *         Process Dep Life or ADD coverage
064100210827     C                   movel     policy#       dlacct#
064200210827     C                   movel     'SDL'         dltype
064300210827     C                   eval      dledate = %char(enrldt)
064400220308      *
064500220308     C                   if        candt <> 0
064600220308     C                   movel     candt         cdat
0647002203080297 C     cdat          subdur    1:*D          cdat
0648002203080297 C                   movel     cdat          candt
064900220308     C                   eval      dlcdate = %char(candt)
065000220308     C                   endif
065100220308      *
065200210827     C                   eval      dlbamt = %editc(benamt:'Z')
065300210827      *
065400210903      *
065500210903     C                   eval      dlcovl = 'ESP'
065600210903      *
065700210903     C                   select
065800210903      *
065900210903     C                   when      mcovtp = 'TIN'
066000210903     C                   eval      dlcovl = 'EMP'
066100210903     C                   when      mcovtp = 'THW'
066200210903     C                   eval      dlcovl = 'ESP'
066300210903     C                   when      mcovtp = 'TFA'
066400210903     C                   eval      dlcovl = 'FAM'
066500210903     C                   when      mcovtp = 'TPC'
066600210903     C                   eval      dlcovl = 'E1D'
066700210903     C                   when      mcovtp = 'TP2'
066800210903     C                   eval      dlcovl = 'ECH'
066900210903     C                   endsl
067000210903      *
067100210916      *
067200210916     C                   eval      plif = '1'
067300210916      *
067400210917     C                   exsr      setsub
067500210916      *
067600210827     C                   update    ren834r
0677002109160107  *
067800210827     C                   endif
067900210827     C                   leavesr
068000210827     C                   endif
0681002108270107  *
0682002108270107  *
0683002202160296 C                   If        plncat = 'PWD' or plncat = 'PVW'
068400210827      *         Process Short Trm Dis Coverage
068500210827     C                   movel     policy#       sdacct#
068600210827     C                   movel     'STD'         sdtype
068700210827     C                   eval      sdedate = %char(enrldt)
068800220308      *
068900220308     C                   if        candt <> 0
069000220308     C                   movel     candt         cdat
0691002203080297 C     cdat          subdur    1:*D          cdat
0692002203080297 C                   movel     cdat          candt
069300220308     C                   eval      sdcdate = %char(candt)
069400220308     C                   endif
069500220308      *
069600210827     C                   eval      sdbamt = %editc(benamt:'Z')
069700210827      *
069800210903      *
069900210903     C                   eval      sdcovl = 'ESP'
070000210903      *
070100210903     C                   select
070200210903      *
070300210903     C                   when      mcovtp = 'TIN'
070400210903     C                   eval      sdcovl = 'EMP'
070500210903     C                   when      mcovtp = 'THW'
070600210903     C                   eval      sdcovl = 'ESP'
070700211104     C                   when      mcovtp = 'TFA'
070800211104     C                   eval      sdcovl = 'FAM'
070900211104     C                   when      mcovtp = 'TPC'
071000211104     C                   eval      sdcovl = 'E1D'
071100211104     C                   when      mcovtp = 'TP2'
071200211104     C                   eval      sdcovl = 'ECH'
071300211104     C                   endsl
071400211104      *
071500211104      *
071600211104     C                   eval      plif = '1'
071700211104      *
071800211104     C                   exsr      setsub
071900211104      *
072000210827     C                   update    ren834r
0721002111040107  *
072200211104     C                   leavesr
072300210827     C                   endif
0724002108270107  *
0725002108270107  *
0726002202090296 C                   If        plncat = 'PVL' or plncat = 'PLT'
072700210827      *         Process Long Trm Dis Coverage
072800210827     C                   movel     policy#       ldacct#
072900210827     C                   movel     'LTD'         ldtype
073000210827     C                   eval      ldedate = %char(enrldt)
073100220308      *
073200220308     C                   if        candt <> 0
073300220308     C                   movel     candt         cdat
0734002203080297 C     cdat          subdur    1:*D          cdat
0735002203080297 C                   movel     cdat          candt
073600220308     C                   eval      ldcdate = %char(candt)
073700220308     C                   endif
073800220308      *
073900210827     C                   eval      ldbamt = %editc(benamt:'Z')
074000210903      *
074100210903     C                   eval      ldcovl = 'ESP'
074200210903      *
074300210903     C                   select
074400210903      *
074500210903     C                   when      mcovtp = 'TIN'
074600210903     C                   eval      ldcovl = 'EMP'
074700210903     C                   when      mcovtp = 'THW'
074800210903     C                   eval      ldcovl = 'ESP'
074900210903     C                   when      mcovtp = 'TFA'
075000210903     C                   eval      ldcovl = 'FAM'
075100210903     C                   when      mcovtp = 'TPC'
075200210903     C                   eval      ldcovl = 'E1D'
075300210903     C                   when      mcovtp = 'TP2'
075400210903     C                   eval      ldcovl = 'ECH'
075500210903     C                   endsl
075600210903      *
075700210916      *
075800210916     C                   eval      plif = '1'
075900210916      *
076000210917     C                   exsr      setsub
076100210916      *
076200210827     C                   update    ren834r
0763002108270107  *
076400210827     C                   leavesr
076500210827     C                   endif
0766002108270107  *
0767002108270107  *
0768002108270296 C                   If        plncat = 'PEP'
076900210827      *         Process EAP Coverage
077000210827     C                   movel     policy#       epacct#
077100210827     C                   movel     'EAP'         eptype
077200210827     C                   eval      epedate = %char(enrldt)
077300220308      *
077400220308     C                   if        candt <> 0
077500220308     C                   movel     candt         cdat
0776002203080297 C     cdat          subdur    1:*D          cdat
0777002203080297 C                   movel     cdat          candt
077800220308     C                   eval      epcdate = %char(candt)
077900220308     C                   endif
078000220308      *
078100210827     C                   eval      epbamt = %editc(benamt:'Z')
078200210827      *
078300210903     C                   eval      epcovl = 'ESP'
078400210903      *
078500210903     C                   select
078600210903      *
078700210903     C                   when      mcovtp = 'TIN'
078800210903     C                   eval      epcovl = 'EMP'
078900210903     C                   when      mcovtp = 'THW'
079000210903     C                   eval      epcovl = 'ESP'
079100210903     C                   when      mcovtp = 'TFA'
079200210903     C                   eval      epcovl = 'FAM'
079300210903     C                   when      mcovtp = 'TPC'
079400210903     C                   eval      epcovl = 'E1D'
079500210903     C                   when      mcovtp = 'TP2'
079600210903     C                   eval      epcovl = 'ECH'
079700210903     C                   endsl
079800210903      *
079900210916      *
080000210916     C                   eval      peap = '1'
080100210916      *
080200210917     C                   exsr      setsub
080300210916      *
080400210827     C                   update    ren834r
0805002108270107  *
080600210827     C                   leavesr
080700210827     C                   endif
0808002108270107  *
080900210826     C                   endsr
081000210826      *
0811002108270107  ********************************************************************************
0812002108270107  *
0813002108270107  *     LOKDEP - Look for Deps with same plan
0814002108270107  *
0815002108270107  ********************************************************************************
081600210827     C     lokdep        begsr
0817002108270107  *
0818002108270291  *        Look for dependents of member
0819002108270297 C     mcssno        setll     dcov                               33
0820002108270296 C                   dou       *in33 = '1'
0821002108270297 C     mcssno        reade     dcov                                   33
0822002108270296 C                   If        *in33 = '0' and pltrst = dvtrst and
0823002108270296 C                             plsub# = dvsub# and plplan = dvplan
0824002108270291  *
0825002108270296 C                   If        ccandt = 0 or ccandt > cutofn
0826002108270296 C                   If        ccandt = 0 or ccandt < cutofa
0827002108270291  *
0828002108270296 C                   If        ccandt = denrdt
0829002108270297 C                   iter                                                   ccandt = 0
0830002108270297 C                   endif                                                  ccandt = 0
0831002108270291  *
0832002108270291 C                   exsr      chkdep
0833002108270291  *
0834002108270297 C                   endif                                                  ccandt = 0
0835002108270291  *
0836002108270297 C                   endif                                                  ccandt = 0
0837002108270291  *
0838002108270297 C                   endif                                                  *in33 = '0'
0839002108270291  *
0840002108270297 C                   enddo                                                  *in33 = '1'
0841002108270291  *
0842002108270107  *
084300210827     C                   endsr
084400210827      *
0845002108270107  ********************************************************************************
0846002108270107  *
0847002108270107  *     CHKDEP - Check for Dependent record
0848002108270107  *
0849002108270107  ********************************************************************************
085000210827     C     chkdep        begsr
0851002108270107  *
0852002108270291  *        get Dependent rec
0853002108270297 C     depky         chain     depndc                             61
0854002108270296 C                   If        *in61 = '0'
0855002108270107  *  Set REN Key values
085600210827     C                   eval      kmemid = %editc(mbssno:'X')
085700210827     C                   eval      kmbrssn = %editc(depss#:'X')
085800210827     C                   eval      kdob = %char(dbirth)
085900210827     C                   movel(P)  dlname        klname
086000210827     C                   movel(P)  dfname        kfname
086100210827     C                   movel     dmi           kmi
0862002108270291  *        See if reord already exists
0863002108270297 C     renky         chain     ren834p                            62
0864002108270296 C                   If        *in62 = '1'
086500210827      *          If not - create member record
086600210827     C                   exsr      crtdep
086700210827      *
0868002108270291  *          Retrieve just created member record
0869002108270297 C     renky         chain     ren834p                            62
0870002108270296 C                   If        *in62 = '1'
0871002108270291  *             WHAT????
087200210827     C                   eval      mi = mi
087300210827     C                   endif
087400210827      *
087500210827     C                   endif
087600210827      *          Add coverge data to mbr rec
087700210827     C                   exsr      addcvgd
087800210827      *
087900210827     C                   endif
0880002108270107  *
088100210827     C                   endsr
0882002108270107  ********************************************************************************
0883002108270107  *
0884002108270107  *     CRTDEP - Create Dep rec - load demographics
0885002108270107  *
0886002108270107  ********************************************************************************
088700210827     C     crtdep        begsr
0888002108270107  *
088900210827     C                   clear                   ren834r
089000210827     C                   eval      recid = '02'
089100210827     C                   eval      prkeyty = 'S'
0892002108270291  *
089300210827     C                   eval      relcd = 'CH'
0894002108270296 C                   If        drelcd = 'RWI' or drelcd = 'RHU'
089500210827     C                   eval      relcd = 'SP'
089600210827     C                   endif
0897002109160107  *
089800210916     C                   eval      epprods = '    '
0899002108270291  *        Get Account data
0900002108270297 C     accky         chain     accmst                             51
0901002108270296 C                   If        *in51 = '0'
090200210827     C                   movel(P)  acnam1        groupnam
090300210827     C                   endif
090400210827      *
0905002108270297 C     accky         chain     ac2mstl2                           51
0906002108270296 C                   If        *in51 = '0'
090700210827     C                   eval      grouptid = %editc(a2tax_id#:'X')
090800210827     C                   endif
090900210827      *      Mbr demo data
091000210827     C                   eval      memid = %editc(mbssno:'X')
091100210827     C                   eval      dateofbth = %char(dbirth)
091200210827     C                   movel     dlname        lastname
091300210827     C                   movel     dfname        firstname
091400210827     C                   movel     dmi           mi
091500210827     C                   movel     dsex          gender
091600210827     C                   eval      mbrssn = %editc(depss#:'X')
091700210827     C                   eval      cphone = %editc(darea:'X') +
091800210827     C                             %editc(dphone:'X')
091900210827     C                   movel     daddr1        address1
092000210827     C                   movel     daddr2        address2
092100210827     C                   movel     dcity         ccity
092200210827     C                   movel     dstate        cstate
092300210827     C                   eval      czip = %editc(dzip:'X')
092400210827      *
0925002108270296 C                   If        dhndcp > ' '
092600210827     C                   eval      disabled = 'H'
092700210827     C                   endif
092800210827      *
092900210827     C                   eval      tssn = %editc(depss#:'X')
093000220211     C                   eval      feditin = %editc(depss#:'X')
093100220211     C                   eval      policy# = %subst(group#:1:7)
093200220211      *
093300220211     C                   eval      epsubcl = hldsub
093400220211      *
093500220211      *
093600210827     C                   write     ren834r
0937002108270107  *
093800210827     C                   endsr
093900210827      *
0940002108270107  ********************************************************************************
0941002108270107  *
0942002108270107  *     ADDCVGD - Add coverage data to dep record
0943002108270107  *               Already have REN dep rec, dcov + plnmst records
0944002108270107  *
0945002108270107  ********************************************************************************
094600210827     C     addcvgd       begsr
0947002108270107  *
0948002108270296 C                   If        plncat = 'PDN'
094900210827      *         Process Dental Coverage
095000210827     C                   movel     policy#       dacct#
095100210827     C                   movel     'DEN'         dtype
095200210827     C                   eval      dcovedate = %char(denrdt)
095300220308      *
095400220308     C                   if        ccandt <> 0
095500220308     C                   movel     ccandt        cdat
0956002203080297 C     cdat          subdur    1:*D          cdat
0957002203080297 C                   movel     cdat          ccandt
095800220308     C                   eval      dcovcdate = %char(ccandt)
095900220308     C                   endif
096000220308      *
0961002108270107  *
096200210903      *
096300210903     C                   eval      dencovl = 'ESP'
096400210903      *
096500210903     C                   select
096600210903      *
096700210903     C                   when      mcovtp = 'TIN'
096800210903     C                   eval      dencovl = 'EMP'
096900210903     C                   when      mcovtp = 'THW'
097000210903     C                   eval      dencovl = 'ESP'
097100210903     C                   when      mcovtp = 'TFA'
097200210903     C                   eval      dencovl = 'FAM'
097300210903     C                   when      mcovtp = 'TPC'
097400210903     C                   eval      dencovl = 'E1D'
097500210903     C                   when      mcovtp = 'TP2'
097600210903     C                   eval      dencovl = 'ECH'
097700210903     C                   endsl
097800210903      *
097900210827     C                   eval      decovin = 'Y'
0980002108270107  *
0981002108270296 C                   If        mcovtp = 'TPC' or mcovtp = 'TP2'
098200210827     C                   eval      dccovin = 'Y'
098300210827     C                   endif
0984002108270107  *
0985002108270296 C                   If        mcovtp = 'THW'
098600210827     C                   eval      dscovin = 'Y'
098700210827     C                   endif
0988002108270107  *
0989002108270296 C                   If        mcovtp = 'TFA'
099000210827     C                   eval      dscovin = 'Y'
099100210827     C                   eval      dccovin = 'Y'
099200210827     C                   endif
099300210916      *
099400210916     C                   eval      pden = '1'
099500210916      *
099600210930     C***                exsr      setsub
099700210930     C                   eval      epsubcl = hldsub
099800210827      *
099900210827     C                   update    ren834r
1000002108270107  *
100100210827     C                   leavesr
100200210827     C                   endif
1003002108270107  *
1004002108270107  *
1005002108270296 C                   If        plncat = 'PVS'
100600210827      *         Process Vision Coverage
100700210827     C                   movel     policy#       vacct#
100800210827     C                   movel     'VIS'         vtype
100900210827     C                   eval      vcovedate = %char(denrdt)
101000220308      *
101100220308     C                   if        ccandt <> 0
101200220308     C                   movel     ccandt        cdat
1013002203080297 C     cdat          subdur    1:*D          cdat
1014002203080297 C                   movel     cdat          ccandt
101500220308     C                   eval      vcovcdate = %char(ccandt)
101600220308     C                   endif
101700220308      *
101800210903     C                   eval      viscovl = 'ESP'
101900210903      *
102000210903     C                   select
102100210903      *
102200210903     C                   when      mcovtp = 'TIN'
102300210903     C                   eval      viscovl = 'EMP'
102400210903     C                   when      mcovtp = 'THW'
102500210903     C                   eval      viscovl = 'ESP'
102600210903     C                   when      mcovtp = 'TFA'
102700210903     C                   eval      viscovl = 'FAM'
102800210903     C                   when      mcovtp = 'TPC'
102900210903     C                   eval      viscovl = 'E1D'
103000210903     C                   when      mcovtp = 'TP2'
103100210903     C                   eval      viscovl = 'ECH'
103200210903     C                   endsl
103300210903      *
103400210827     C                   eval      vecovin = 'Y'
1035002108270107  *
1036002108270296 C                   If        mcovtp = 'TPC' or mcovtp = 'TP2'
103700210827     C                   eval      vccovin = 'Y'
103800210827     C                   endif
1039002108270107  *
1040002108270296 C                   If        mcovtp = 'THW'
104100210827     C                   eval      vscovin = 'Y'
104200210827     C                   endif
1043002108270107  *
1044002108270296 C                   If        mcovtp = 'TFA'
104500210827     C                   eval      vscovin = 'Y'
104600210827     C                   eval      vccovin = 'Y'
104700210827     C                   endif
104800210916      *
104900210916     C                   eval      pvis = '1'
105000210916      *
105100210930     C****               exsr      setsub
105200210930     C                   eval      epsubcl = hldsub
105300210827      *
105400210827     C                   update    ren834r
1055002108270107  *
105600210827     C                   leavesr
105700210827     C                   endif
1058002108270107  *
1059002108270107  *
1060002108270296 C                   If        plncat = 'PLF'
106100210827      *         Process EE Life Coverage
106200210827     C                   movel     policy#       elacct#
106300210827     C                   movel     'LIF'         eltype
106400210827     C                   eval      eledate = %char(denrdt)
106500220308      *
106600220308     C                   if        ccandt <> 0
106700220308     C                   movel     ccandt        cdat
1068002203080297 C     cdat          subdur    1:*D          cdat
1069002203080297 C                   movel     cdat          ccandt
107000220308     C                   eval      elcdate = %char(ccandt)
107100220308     C                   endif
107200220308      *
107300210827     C                   eval      elbamt = %editc(benamt:'Z')
107400210827      *
107500210903      *
107600210903     C                   eval      elcovl = 'ESP'
107700210903      *
107800210903     C                   select
107900210903      *
108000210903     C                   when      mcovtp = 'TIN'
108100210903     C                   eval      elcovl = 'EMP'
108200210903     C                   when      mcovtp = 'THW'
108300210903     C                   eval      elcovl = 'ESP'
108400210903     C                   when      mcovtp = 'TFA'
108500210903     C                   eval      elcovl = 'FAM'
108600210903     C                   when      mcovtp = 'TPC'
108700210903     C                   eval      elcovl = 'E1D'
108800210903     C                   when      mcovtp = 'TP2'
108900210903     C                   eval      elcovl = 'ECH'
109000210903     C                   endsl
109100210916      *
109200210916     C                   eval      plif = '1'
109300210916      *
109400210930     C*****              exsr      setsub
109500210903      *
109600210827     C                   update    ren834r
1097002108270107  *
109800210827     C                   leavesr
109900210827     C                   endif
1100002108270107  *
1101002108270107  *
1102002108270296 C                   If        plncat = 'PAC'
110300210827      *         Process EE ADD Coverage
110400210827     C                   movel     policy#       eaacct#
110500210827     C                   movel     'ADD'         eatype
110600210827     C                   eval      eaedate = %char(denrdt)
110700220308      *
110800220308     C                   if        ccandt <> 0
110900220308     C                   movel     ccandt        cdat
1110002203080297 C     cdat          subdur    1:*D          cdat
1111002203080297 C                   movel     cdat          ccandt
111200220308     C                   eval      eacdate = %char(ccandt)
111300220308     C                   endif
111400220308      *
111500210827     C                   eval      eabamt = %editc(benamt:'Z')
111600210827      *
111700210903      *
111800210903     C                   eval      eacovl = 'ESP'
111900210903      *
112000210903     C                   select
112100210903      *
112200210903     C                   when      mcovtp = 'TIN'
112300210903     C                   eval      eacovl = 'EMP'
112400210903     C                   when      mcovtp = 'THW'
112500210903     C                   eval      eacovl = 'ESP'
112600210903     C                   when      mcovtp = 'TFA'
112700210903     C                   eval      eacovl = 'FAM'
112800210903     C                   when      mcovtp = 'TPC'
112900210903     C                   eval      eacovl = 'E1D'
113000210903     C                   when      mcovtp = 'TP2'
113100210903     C                   eval      eacovl = 'ECH'
113200210903     C                   endsl
113300210916      *
113400210916     C                   eval      plif = '1'
113500210916      *
113600210930     C****               exsr      setsub
113700210930     C                   eval      epsubcl = hldsub
113800210903      *
113900210827     C                   update    ren834r
1140002108270107  *
114100210827     C                   leavesr
114200210827     C                   endif
1143002108270107  *
1144002108270107  *
1145002108270296 C                   If        plncat = 'POA'
114600210827      *         Process EE Sup Life Coverage
114700210827     C                   movel     policy#       easacct#
114800210827     C                   movel     'SEA'         eastype
114900210827     C                   eval      easedate = %char(denrdt)
115000220308      *
115100220308     C                   if        ccandt <> 0
115200220308     C                   movel     ccandt        cdat
1153002203080297 C     cdat          subdur    1:*D          cdat
1154002203080297 C                   movel     cdat          ccandt
115500220308     C                   eval      eascdate = %char(ccandt)
115600220308     C                   endif
115700220308      *
115800210827     C                   eval      easbamt = %editc(benamt:'Z')
115900210903      *
116000210903     C                   eval      eascovl = 'ESP'
116100210903      *
116200210903     C                   select
116300210903      *
116400210903     C                   when      mcovtp = 'TIN'
116500210903     C                   eval      eascovl = 'EMP'
116600210903     C                   when      mcovtp = 'THW'
116700210903     C                   eval      eascovl = 'ESP'
116800210903     C                   when      mcovtp = 'TFA'
116900210903     C                   eval      eascovl = 'FAM'
117000210903     C                   when      mcovtp = 'TPC'
117100210903     C                   eval      eascovl = 'E1D'
117200210903     C                   when      mcovtp = 'TP2'
117300210903     C                   eval      eascovl = 'ECH'
117400210903     C                   endsl
117500210916      *
117600210916     C                   eval      plif = '1'
117700210916      *
117800210930     C****               exsr      setsub
117900210930     C                   eval      epsubcl = hldsub
118000210903      *
118100210827     C                   update    ren834r
1182002108270107  *
118300210827     C                   leavesr
118400210827     C                   endif
1185002108270107  *
1186002108270107  *
1187002108270296 C                   If        plncat = 'PSL'
118800210827      *         Process EE Sup Life Coverage
118900210827     C                   movel     policy#       elsacct#
119000210827     C                   movel     'SEL'         elstype
119100210827     C                   eval      elsedate = %char(denrdt)
119200220308      *
119300220308     C                   if        ccandt <> 0
119400220308     C                   movel     ccandt        cdat
1195002203080297 C     cdat          subdur    1:*D          cdat
1196002203080297 C                   movel     cdat          ccandt
119700220308     C                   eval      elscdate = %char(ccandt)
119800220308     C                   endif
119900220308      *
120000210827     C                   eval      elsbamt = %editc(benamt:'Z')
120100210903      *
120200210903     C                   eval      elscovl = 'ESP'
120300210903      *
120400210903     C                   select
120500210903      *
120600210903     C                   when      mcovtp = 'TIN'
120700210903     C                   eval      elscovl = 'EMP'
120800210903     C                   when      mcovtp = 'THW'
120900210903     C                   eval      elscovl = 'ESP'
121000210903     C                   when      mcovtp = 'TFA'
121100210903     C                   eval      elscovl = 'FAM'
121200210903     C                   when      mcovtp = 'TPC'
121300210903     C                   eval      elscovl = 'E1D'
121400210903     C                   when      mcovtp = 'TP2'
121500210903     C                   eval      elscovl = 'ECH'
121600210903     C                   endsl
121700210903      *
121800210916      *
121900210916     C                   eval      plif = '1'
122000210916      *
122100210930     C****               exsr      setsub
122200210930     C                   eval      epsubcl = hldsub
122300210827      *
122400210827     C                   update    ren834r
1225002108270107  *
122600210827     C                   leavesr
122700210827     C                   endif
1228002108270107  *
1229002108270107  *
1230002108270107  *
1231002108270296 C                   If        plncat = 'PSP' or plncat = 'PSA'
1232002108270296 C                   If        sltype = *blanks
123300210827      *         Process Spouse Life or ADD coverage
123400210827     C                   movel     policy#       slacct#
123500210827     C                   movel     'SSL'         sltype
123600210827     C                   eval      sledate = %char(denrdt)
123700220308      *
123800220308     C                   if        ccandt <> 0
123900220308     C                   movel     ccandt        cdat
1240002203080297 C     cdat          subdur    1:*D          cdat
1241002203080297 C                   movel     cdat          ccandt
124200220308     C                   eval      slcdate = %char(ccandt)
124300220308     C                   endif
124400220308      *
124500210827     C                   eval      slbamt = %editc(benamt:'Z')
124600210903      *
124700210903     C                   eval      slcovl = 'ESP'
124800210903      *
124900210903     C                   select
125000210903      *
125100210903     C                   when      mcovtp = 'TIN'
125200210903     C                   eval      slcovl = 'EMP'
125300210903     C                   when      mcovtp = 'THW'
125400210903     C                   eval      slcovl = 'ESP'
125500210903     C                   when      mcovtp = 'TFA'
125600210903     C                   eval      slcovl = 'FAM'
125700210903     C                   when      mcovtp = 'TPC'
125800210903     C                   eval      slcovl = 'E1D'
125900210903     C                   when      mcovtp = 'TP2'
126000210903     C                   eval      slcovl = 'ECH'
126100210903     C                   endsl
126200210903      *
126300210916      *
126400210916     C                   eval      plif = '1'
126500210916      *
126600210930     C****               exsr      setsub
126700210930     C                   eval      epsubcl = hldsub
126800210827      *
126900210827     C                   update    ren834r
1270002108270107  *
127100210827     C                   endif
127200210827     C                   leavesr
127300210827     C                   endif
1274002108270107  *
1275002108270107  *
1276002108270296 C                   If        plncat = 'PSD' or plncat = 'PAA'
1277002108270296 C                   If        sltype = *blanks
127800210827      *         Process Dep Life or ADD coverage
127900210827     C                   movel     policy#       dlacct#
128000210827     C                   movel     'SDL'         dltype
128100210827     C                   eval      dledate = %char(denrdt)
128200220308      *
128300220308     C                   if        ccandt <> 0
128400220308     C                   movel     ccandt        cdat
1285002203080297 C     cdat          subdur    1:*D          cdat
1286002203080297 C                   movel     cdat          ccandt
128700220308     C                   eval      dlcdate = %char(ccandt)
128800220308     C                   endif
128900220308      *
129000210827     C                   eval      dlbamt = %editc(benamt:'Z')
129100210827      *
129200210903      *
129300210903     C                   eval      dlcovl = 'ESP'
129400210903      *
129500210903     C                   select
129600210903      *
129700210903     C                   when      mcovtp = 'TIN'
129800210903     C                   eval      dlcovl = 'EMP'
129900210903     C                   when      mcovtp = 'THW'
130000210903     C                   eval      dlcovl = 'ESP'
130100210903     C                   when      mcovtp = 'TFA'
130200210903     C                   eval      dlcovl = 'FAM'
130300210903     C                   when      mcovtp = 'TPC'
130400210903     C                   eval      dlcovl = 'E1D'
130500210903     C                   when      mcovtp = 'TP2'
130600210903     C                   eval      dlcovl = 'ECH'
130700210903     C                   endsl
130800210903      *
130900210916      *
131000210916     C                   eval      plif = '1'
131100210916      *
131200210930     C****               exsr      setsub
131300210930     C                   eval      epsubcl = hldsub
131400210916      *
131500210827     C                   update    ren834r
1316002108270107  *
131700210827     C                   endif
131800210827     C                   leavesr
131900210827     C                   endif
1320002108270107  *
1321002108270107  *
1322002108270296 C                   If        plncat = 'PWD'
132300210827      *         Process Short Trm Dis Coverage
132400210827     C                   movel     policy#       sdacct#
132500210827     C                   movel     'STD'         sdtype
132600210827     C                   eval      sdedate = %char(denrdt)
132700220308      *
132800220308     C                   if        ccandt <> 0
132900220308     C                   movel     ccandt        cdat
1330002203080297 C     cdat          subdur    1:*D          cdat
1331002203080297 C                   movel     cdat          ccandt
133200220308     C                   eval      sdcdate = %char(ccandt)
133300220308     C                   endif
133400220308      *
133500210827     C                   eval      sdbamt = %editc(benamt:'Z')
133600210903      *
133700210903     C                   eval      sdcovl = 'ESP'
133800210903      *
133900210903     C                   select
134000210903      *
134100210903     C                   when      mcovtp = 'TIN'
134200210903     C                   eval      sdcovl = 'EMP'
134300210903     C                   when      mcovtp = 'THW'
134400210903     C                   eval      sdcovl = 'ESP'
134500210903     C                   when      mcovtp = 'TFA'
134600210903     C                   eval      sdcovl = 'FAM'
134700210903     C                   when      mcovtp = 'TPC'
134800210903     C                   eval      sdcovl = 'E1D'
134900210903     C                   when      mcovtp = 'TP2'
135000210903     C                   eval      sdcovl = 'ECH'
135100210903     C                   endsl
135200210903      *
135300210916      *
135400210916     C                   eval      plif = '1'
135500210916      *
135600210930     C****               exsr      setsub
135700210930     C                   eval      epsubcl = hldsub
135800210916      *
135900210827     C                   update    ren834r
1360002108270107  *
136100210827     C                   leavesr
136200210827     C                   endif
1363002108270107  *
1364002108270107  *
1365002202090296 C                   If        plncat = 'PVL' or plncat = 'PLT'
136600210827      *         Process Long Trm Dis Coverage
136700210827     C                   movel     policy#       ldacct#
136800210827     C                   movel     'LTD'         ldtype
136900210827     C                   eval      ldedate = %char(denrdt)
137000220308      *
137100220308     C                   if        ccandt <> 0
137200220308     C                   movel     ccandt        cdat
1373002203080297 C     cdat          subdur    1:*D          cdat
1374002203080297 C                   movel     cdat          ccandt
137500220308     C                   eval      ldcdate = %char(ccandt)
137600220308     C                   endif
137700220308      *
137800210827     C                   eval      ldbamt = %editc(benamt:'Z')
137900210827      *
138000210903      *
138100210903     C                   eval      ldcovl = 'ESP'
138200210903      *
138300210903     C                   select
138400210903      *
138500210903     C                   when      mcovtp = 'TIN'
138600210903     C                   eval      ldcovl = 'EMP'
138700210903     C                   when      mcovtp = 'THW'
138800210903     C                   eval      ldcovl = 'ESP'
138900210903     C                   when      mcovtp = 'TFA'
139000210903     C                   eval      ldcovl = 'FAM'
139100210903     C                   when      mcovtp = 'TPC'
139200210903     C                   eval      ldcovl = 'E1D'
139300210903     C                   when      mcovtp = 'TP2'
139400210903     C                   eval      ldcovl = 'ECH'
139500210903     C                   endsl
139600210903      *
139700210916      *
139800210916     C                   eval      plif = '1'
139900210916      *
140000210930     C****               exsr      setsub
140100210930     C                   eval      epsubcl = hldsub
140200210917      *
140300210917     C                   update    ren834r
1404002109170107  *
140500210917     C                   leavesr
140600210917     C                   endif
1407002109170107  *
1408002108270107  *
1409002109170296 C                   If        plncat = 'PEP'
141000210827      *         Process EAP Coverage
141100210827     C                   movel     policy#       epacct#
141200210827     C                   movel     'EAP'         eptype
141300210827     C                   eval      epedate = %char(denrdt)
141400220308      *
141500220308     C                   if        ccandt <> 0
141600220308     C                   movel     ccandt        cdat
1417002203080297 C     cdat          subdur    1:*D          cdat
1418002203080297 C                   movel     cdat          ccandt
141900220308     C                   eval      epcdate = %char(ccandt)
142000220308     C                   endif
142100220308      *
142200210827     C                   eval      epbamt = %editc(benamt:'Z')
142300210903      *
142400210903     C                   eval      epcovl = 'ESP'
142500210903      *
142600210903     C                   select
142700210903      *
142800210903     C                   when      mcovtp = 'TIN'
142900210903     C                   eval      epcovl = 'EMP'
143000210903     C                   when      mcovtp = 'THW'
143100210903     C                   eval      epcovl = 'ESP'
143200210903     C                   when      mcovtp = 'TFA'
143300210903     C                   eval      epcovl = 'FAM'
143400210903     C                   when      mcovtp = 'TPC'
143500210903     C                   eval      epcovl = 'E1D'
143600210903     C                   when      mcovtp = 'TP2'
143700210903     C                   eval      epcovl = 'ECH'
143800210903     C                   endsl
143900210903      *
144000210916      *
144100210916     C                   eval      peap = '1'
144200210916      *
144300210930     C****               exsr      setsub
144400210930     C                   eval      epsubcl = hldsub
144500210827      *
144600210827     C                   update    ren834r
1447002108270107  *
144800210827     C                   leavesr
144900210827     C                   endif
1450002108270107  *
145100210827     C                   endsr
145200210827      *
1453002109170107  ********************************************************************************
1454002109170107  *
1455002109170107  *     SETSUB - Set the Subclient/Location code based on Prods
1456002109170107  *
1457002109170107  ********************************************************************************
145800210917     C     setsub        begsr
1459002109170107  *
146000210917      *
146100210917     C                   eval      epsubcl = '     '
146200210917     C                   select
146300211025      *   No VIS
146400210917     C                   when      epprods = '1 11'
146500210917     C                   eval      epsubcl = '10000'
146600211025     C                   when      epprods = '1 1 '
146700211025     C                   eval      epsubcl = '10000'
146800211025     C                   when      epprods = '1  1'
146900211025     C                   eval      epsubcl = '10000'
147000211025      *    DEN + VIS + LIF/DIS/EAP
147100210917     C                   when      epprods = '1111'
147200210917     C                   eval      epsubcl = '29511'
147300210917     C                   when      epprods = '111 '
147400210917     C                   eval      epsubcl = '29511'
147500211025     C                   when      epprods = '11 1'
147600211025     C                   eval      epsubcl = '29511'
147700211025      *   LIF/DIS only
147800211105     C                   when      epprods = '  11'
147900211105     C                   eval      epsubcl = '88888'
148000211105     C                   when      epprods = '  1 '
148100211105     C                   eval      epsubcl = '88888'
148200211105      *   EAP only
148300211105     C                   when      epprods = '   1'
148400211105     C                   eval      epsubcl = '89001'
148500211105      *   No DEN
148600211105     C                   when      epprods = '  11'
148700211112     C                   eval      epsubcl = '99511'
148800211105     C                   when      epprods = ' 111'
148900211112     C                   eval      epsubcl = '99511'
149000211105     C                   when      epprods = ' 1 1'
149100211112     C                   eval      epsubcl = '99511'
149200211025     C                   when      epprods = ' 11 '
149300211112     C                   eval      epsubcl = '99511'
149400211025     C                   endsl
149500210930      *
149600210930     C                   eval      hldsub = epsubcl
1497002109170107  *
149800210917     C                   endsr
149900210917      *
1500002110260107  ********************************************************************************
1501002110260107  *
1502002110260107  *     UPDDEP - Update dep recs based on Mbr settings
1503002110260107  *
1504002110260107  ********************************************************************************
150500211026     C     upddep        begsr
1506002110260107  *
1507002110260291  *  Loop thru REN834L
1508002110260297 C     *loval        setll     ren834l                            61
1509002110260296 C                   dou       *in61 = '1'
1510002111020297 C                   read      ren834l                                61
1511002111020296 C                   If        *in61 = '1'
151200211102     C                   leavesr
151300211102     C                   endif
151400211102      *
1515002111020296 C                   If        xmemid = '218450026'
151600211102     C                   eval      xrecid = xrecid
151700211102     C                   endif
151800211102      *
1519002111020296 C                   If        xrecid = '01'
152000211102     C                   eval      svmemid = xmemid
152100211102     C                   eval      svepsubcl = xepsubcl
152200211102     C                   eval      usedep = 'Y'
1523002111020296 C                   If        xepsubcl = '88888' or xepsubcl = '890001'
152400211026     C                   eval      usedep = 'N'
152500211026     C                   endif
152600211026     C                   iter
152700211026     C                   endif
1528002110260291  *     Process Dep rec
152900211026     C                   if        svmemid = xmemid
153000211112     C                   if        usedep = 'N' or
153100211112     C                             (xden = ' ' and xvis = ' ')
153200211112     C                   delete    ren834x
153300211112     C                   iter
153400211112     C                   endif
153500211112      *
153600211112     C                   eval      xepsubcl = svepsubcl
153700211112     C                   update    ren834x
153800211112     C                   iter
153900211112     C                   endif
154000211112      *
154100211112     C                   enddo
154200211026      *
154300211026     C                   endsr
