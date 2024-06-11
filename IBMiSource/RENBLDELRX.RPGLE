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
0076002110260251 D  svmemid                            LIKE(memid)
0077002110260251 D  svepsubcl                          LIKE(epsubcl)
0078002108250251 D  kmbrssn                            LIKE(mbrssn)
0079002108250251 D  kdob                               LIKE(dateofbth)
0080002108250251 D  klname                             LIKE(lastname)
0081002207140251 D  kfname                             LIKE(firstname)
0082002207140251 D  kmi                                LIKE(mi)
0083002207140251 D  hldsub                             LIKE(epsubcl)
008400220714      *
0085002207140251 D  svplan                             LIKE(mcplan)
0086002207140251 D  svssn                              LIKE(mcssno)
0087002207140251 D  svcovt                             LIKE(mcovtp)
0088002207140251 D  svbeamt                            LIKE(benamt)
0089002207140251 D  sveff                              LIKE(enrldt)
0090002207140251 D  svtrm                              LIKE(candt)
0091002207140251 D  svdeff                             LIKE(enrldt)
0092002203140251 D  svdtrm                             LIKE(candt)
0093002203140251 D  svseq#                             LIKE(dseq#)
009400220310      *
009500210709      *
009600210825     C     renky         klist
009700210825     C                   kfld                    kmemid
009800210825     C                   kfld                    kmbrssn
009900210825     C                   kfld                    kdob
010000210825     C                   kfld                    klname
010100210825     C                   kfld                    kfname
010200210825     C                   kfld                    kmi
010300210825      *
010400210825     C     accky         klist
010500210825     C                   kfld                    mbtrst
010600210825     C                   kfld                    mbsub#
010700210825     C                   kfld                    mbacct
010800210825      *
010900210825     C     grkey         klist
011000210825     C                   kfld                    pltrst
011100210825     C                   kfld                    plsub#
011200210825     C                   kfld                    plplan
011300210825     C                   kfld                    date9
011400081103      *
011500041228     C     mcvky         klist
011600081103     C                   kfld                    pltrst
011700081103     C                   kfld                    plsub#
011800081103     C                   kfld                    plplan
011900220615      *
012000220615     C     mcvky3        klist
012100220615     C                   kfld                    svssn
012200220615     C                   kfld                    pltrst
012300220615     C                   kfld                    plsub#
012400220615     C                   kfld                    plplan
012500220314      *
012600220314     C     dcvky         klist
012700220314     C                   kfld                    pltrst
012800220314     C                   kfld                    plsub#
012900220314     C                   kfld                    plplan
013000220314     C                   kfld                    svssn
013100081103      *
013200020404     C     depky         klist
013300220314     C                   kfld                    svssn
013400220314     C                   kfld                    svseq#
013500220218      *
0136002107230291  *   Preprocessing
0137002107230297 C                   movel     UDATE         cutoff
0138002107230297 C                   movel     cutoff        today8
0139002107230297 C                   movel     cutoff        todaa
0140002109080297 C                   movel     cutoff        todad
0141002107230297 C                   z-add     99999999      date9
0142002109080291  * Determine Term date cutoff to start - 90 days prior to term dt
0143002109080297 C     cutoff        subdur    90:*D         cutofx
0144002107230297 C                   movel     cutofx        cutofn
0145002107230291  * Determine Term date cutoff to end - 60 days after term dt
0146002109080297 C     cutoff        adddur    60:*D         cutofy
0147002109080297 C                   movel     cutofy        cutofa
0148000204040291  *
0149000501110291  * Main Line - Loop thru plan master
0150002202250291  *
0151002109080297 C     'REN'         setll     plnmstn1                           21
0152002109080296 C                   dou       *in21 = '1'
0153002109290297 C     'REN'         reade     plnmstn1                               21
0154002111240296 C                   If        *in21 = '0'
0155002202090291  *       Debug shit
0156002207120296 C                   If        plplan = 'NDZT' or
0157002207120296 C                             plplan = 'NENZ'
0158002202090297 C                   eval      plplan = plplan
0159002202090297 C                   endif
0160002202090291  *     Using GBS info - Get GRATE record
0161002202090297 C     grkey         setll     grat24                             22
0162002202090297 C                   readp     grat24                                 22
0163002202090296 C                   If        *in22 = '0'
0164002111240291  *
0165002111240291  *        Loop thru mcov file using T,S,P
0166002207280297 C                   eval      sveff = 99999999
0167002207280297 C                   eval      svtrm = 00000000
0168002207280297 C                   eval      svplan = *blanks
0169002207280297 C                   eval      svssn = 0
0170002207280297 C     mcvky         setll     mcov42                             31
0171002207280296 C                   dou       *in31 = '1'
0172002207280297 C     mcvky         reade     mcov42                                 31
0173002207280296 C                   If        *in31 = '0' and pltrst = mctrst and
0174002207280296 C                             plsub# = mcsub# and plplan = mcplan and
0175002207280296 C                             (candt = 0 or candt > enrldt)
0176002207280291  *
0177002207280296 C                   If        candt = enrldt
0178002207280296 C                   Iter
0179002109210296 C                   endif
0180002207110291  * debug shit
0181002207210296 C                   If        mcssno = 066787152
0182002207210297 C                   eval      mcssno = mcssno
0183002207210296 C                   endif
0184002110200291  *
0185002207110296 C                   If        candt = 0 or candt > cutofn
0186002207110296 C                   If        candt = 0 or candt < cutofa
0187002203100291  *
0188002207210296 C                   If        mcssno <> svssn
0189002207080291  *
0190002207210296 C                   If        svssn <> 0
0191002207080291  *
0192002207080291  *        Get member record
0193002207080297 C     svssn         chain     member                             32
0194002207080296 C                   If        *in32 = '0'
0195002207080291  *        Get most recent coverage rec for mbr/plan
0196002207080297 C     mcvky3        chain     mcov43                             43
0197002207080296 C                   If        *in43 = '0'
0198002207080291  *
0199002207080291  *
0200002207080291 C                   exsr      chkmbr
0201002207080291  *
0202002207080291 C                   exsr      lokdep
0203002207080291  *
0204002110290297 C                   endif                                                  *in33 = '1'
0205002206150297 C                   endif                                                  *in33 = '1'
0206002110290297 C                   endif                                                  *in32 = '0'
0207002203100291  *        Reset saved values
0208002203100297 C                   eval      sveff = 99999999
0209002203100297 C                   eval      svtrm = 00000000
0210002203100297 C                   eval      svssn = mcssno
0211002111050297 C                   endif                                                  *in32 = '0'
0212002203100291  *
0213002203100296 C                   If        candt > svtrm or candt = 0
0214002203100297 C                   eval      svtrm = candt
0215002111050297 C                   endif                                                  *in32 = '0'
0216002203100291  *
0217002203100296 C                   If        enrldt < sveff
0218002203100297 C                   eval      sveff = enrldt
0219002203100297 C                   endif                                                  *in32 = '0'
0220002110290291  *
0221002203100297 C                   endif                                                  *in32 = '0'
0222002203100297 C                   endif                                                  *in32 = '0'
0223002203100291  *
0224002203100291  *
0225002203100297 C                   endif                                                  *in32 = '0'
0226002203100291  *
0227002203040297 C                   enddo                                                  *in33 = '1'
0228002111050291  *
0229002203140296 C                   If        svssn <> 0
0230002203140291  *
0231002203140291  *        Get member record
0232002203140297 C     svssn         chain     member                             32
0233002203140296 C                   If        *in32 = '0'
0234002203140291  *
0235002206150291  *        Get most recent coverage rec for mbr/plan
0236002206150297 C     mcvky3        chain     mcov43                             43
0237002206150296 C                   If        *in43 = '0'
0238002206150291  *
0239002203140291 C                   exsr      chkmbr
0240002203140291  *
0241002203140291 C                   exsr      lokdep
0242002203140291  *
0243002203140297 C                   endif                                                  *in33 = '1'
0244002206150291  *
0245002206150297 C                   endif                                                  *in33 = '1'
0246002203140297 C                   endif                                                  *in32 = '0'
0247002111050297 C                   endif                                                  *in32 = '0'
0248002203040291  *
0249002203040297 C                   endif                                                  *in32 = '0'
0250002203040291  *
0251002203040297 C                   enddo                                                  *in31 = '1'
0252002203040291  *
0253002203040291 C                   exsr      upddep
0254002203040291  *
0255002203040297 C                   movel     '1'           *inlr
0256002203040297 C                   return
0257000204020107  ********************************************************************************
0258000204020107  *
0259002108250107  *     CHKMBR - Check for Member record
0260000204020107  *
0261000204020107  ********************************************************************************
026200210825     C     chkmbr        begsr
0263002005280107  *
0264002108250107  *  Set REN Key values
026500211104     C                   eval      kmemid = %editc(mbssno:'X')
026600211104     C                   eval      kmbrssn = %editc(mbssno:'X')
026700211104     C                   eval      kdob = %char(birth)
026800211104     C                   movel(P)  mlname        klname
026900211104     C                   movel(P)  mfname        kfname
027000220114     C                   movel     mmi           kmi
0271002108270291  *        See if record already exists
0272002108310297 C     renky         chain     ren834p                            41
0273002111040296 C                   If        *in41 = '1'
027400210831      *          If not - create member record
027500211104     C                   exsr      crtmbr
027600210831      *
0277002108310291  *          Retrieve just created member record
0278002108310297 C     renky         chain     ren834p                            41
0279002109010296 C                   If        *in41 = '1'
0280002109010291  *             WHAT????
028100210901     C                   eval      mi = mi
028200210901     C                   endif
028300210901      *
028400210901     C                   endif
028500210901      *          Add coverge data to mbr rec
028600210901     C                   exsr      addcvgm
0287000907010107  *
028800090701     C                   endsr
0289002108250107  ********************************************************************************
0290002108250107  *
0291002108250107  *     CRTMBR - Create Member rec - load demographics
0292002108250107  *
0293002108250107  ********************************************************************************
029400210825     C     crtmbr        begsr
0295002108310107  *
029600211108     C                   clear                   ren834r
029700211108     C                   eval      recid = '01'
029800211108     C                   eval      prkeyty = 'S'
029900211108     C                   eval      relcd = 'EE'
0300002111080107  *
030100211108     C                   eval      epprods = '    '
0302002111080291  *        Get Account data
0303002111080297 C     accky         chain     accmst                             51
0304002111080296 C                   If        *in51 = '0'
030500211108     C                   movel(P)  acnam1        groupnam
030600211108     C                   endif
030700211108      *
0308002111080297 C     accky         chain     ac2mstl2                           51
0309002111080296 C                   If        *in51 = '0'
031000211108     C                   eval      grouptid = %editc(a2tax_id#:'X')
031100211105     C                   endif
031200211108      *      Mbr demo data
031300210922     C                   eval      memid = %editc(mbssno:'X')
031400210922     C                   eval      dateofbth = %char(birth)
031500210922     C                   movel     mlname        lastname
031600210922     C                   movel     mfname        firstname
031700210831     C                   movel     mmi           mi
031800210831     C                   movel     sex           gender
031900210831     C                   eval      mbrssn = %editc(mbssno:'X')
032000210826     C                   eval      cphone = %editc(area:'X') + %editc(phone:'X')
032100210826     C                   movel     addr1         address1
032200210826     C                   movel     addr2         address2
032300210826     C                   movel     city          ccity
032400210826     C                   movel     state         cstate
032500210826     C                   eval      czip = %editc(zip:'X')
032600210825      *
0327002108260296 C                   If        hndicp > ' '
032800210826     C                   eval      disabled = 'H'
032900210826     C                   endif
033000210826      *
0331002108260296 C                   If        salary > 0
033200210827     C                   eval      cursalary9 = %editc(salary:'Z')
033300210826     C                   eval      salfreq = 'A'
033400220302     C                   eval      saldate = %char(mbenrl)
0335002203030291  *        Look for change of salary
033600220303     C                   eval      hiskey9 = %editc(mbssno:'X')
0337002203030297 C     hiskey        setll     histlf                             53
0338002203030296 C                   dou       *in53 = '1'
0339002203030297 C     hiskey        reade     histlf                                 53
0340002203030296 C                   If        *in53 = '0'
0341002203030296 C                   If        trcode = 'ASC' or trcode = 'M17'
034200220303     C                   eval      saldate = %char(covtdt)
0343002203080297 C                   leave
0344002203080297 C                   endif
0345002203080297 C                   endif
0346002203030291  *
0347002203080297 C                   enddo                                                            '
0348002203030107  *
034900220303     C                   endif
035000210826      *
0351002109020296 C                   If        empdt > 0
035200210902     C                   eval      hiredate = %char(empdt)
035300210902     C                   eval      hiredateT = %date(empdt)
0354002109030297 C     todad         subdur    hiredatet     yrsService:*Y
035500210903     C                   eval      yrofServ = %editw(yrsService:'       0')
0356002109030296 C                   If        yrsService = 0
035700210903     C                   eval      yrofserv = '       0'
035800210903     C                   endif
035900210831     C                   endif
036000210903      *
036100210908     C                   movel     fill66        email
036200210908      *
036300210908     C                   eval      estatus = 'A'
0364002109080296 C                   If        empst <> 'A'
036500210908     C                   eval      estatus = 'I'
036600210908     C                   endif
036700210908      *
036800210908     C                   eval      tssn = %editc(mbssno:'X')
036900220211     C                   eval      feditin = %editc(mbssno:'X')
037000220211     C                   eval      policy# = %subst(group#:1:7)
037100210908      *
037200220211      *
037300220211     C                   write     ren834r
0374002108260107  *
037500210826     C                   endsr
037600220211      *
0377002108260107  ********************************************************************************
0378002108260107  *
0379002108260107  *     ADDCVGM - Add coverage data to member record
0380002108260107  *               Already have REN mbr rec, mcov + plnmst records
0381002108260107  *
0382002108260107  ********************************************************************************
038300210826     C     addcvgm       begsr
0384002108260107  *
038500220310      *    Subtract 1 day from term date if not 0
038600220310     C                   if        svtrm <> 0
038700220714     C                   movel     svtrm         cdat
0388002207140297 C     cdat          subdur    1:*D          cdat
0389002207140297 C                   movel     cdat          svtrm
0390002207140297 C                   endif
0391002207140107  *
0392002207140296 C                   If        plncat = 'PDN'
039300210826      *         Process Dental Coverage
039400220714     C                   movel     policy#       dacct#
039500220714     C                   movel     'DEN'         dtype
039600220714     C                   eval      dcovedate = %char(sveff)
039700220714     C                   eval      dcovcdate = %char(svtrm)
039800220714      *
039900220714     C                   eval      dencovl = 'ESP'
040000220714      *
040100210909     C                   select
040200220714      *
040300220615     C                   when      xmcovtp = 'TIN'
040400211026     C                   eval      dencovl = 'EMP'
040500220615     C                   when      xmcovtp = 'THW'
040600211026     C                   eval      dencovl = 'ESP'
040700220615     C                   when      xmcovtp = 'TFA'
040800211026     C                   eval      dencovl = 'FAM'
040900220615     C                   when      xmcovtp = 'TPC'
041000211026     C                   eval      dencovl = 'E1D'
041100220615     C                   when      xmcovtp = 'TP2'
041200211026     C                   eval      dencovl = 'ECH'
041300211026     C                   endsl
041400211026      *
041500211026     C                   eval      decovin = 'Y'
0416002109020107  *
0417002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
041800210902     C                   eval      dccovin = 'Y'
041900210902     C                   endif
0420002108260107  *
0421002206150296 C                   If        xmcovtp = 'THW'
042200210826     C                   eval      dscovin = 'Y'
042300210826     C                   endif
0424002108260107  *
0425002206150296 C                   If        xmcovtp = 'TFA'
042600210826     C                   eval      dscovin = 'Y'
042700210826     C                   eval      dccovin = 'Y'
042800210826     C                   endif
042900210826      *
043000210916     C                   eval      pden = '1'
043100210916      *
043200210917     C                   exsr      setsub
043300210930      *
043400210826     C                   update    ren834r
0435002108260107  *
043600210826     C                   leavesr
043700210826     C                   endif
0438002108260107  *
0439002108260107  *
0440002108260296 C                   If        plncat = 'PVS'
044100210826      *         Process Vision Coverage
044200210826     C                   movel     policy#       vacct#
044300210826     C                   movel     'VIS'         vtype
044400220310     C                   eval      vcovedate = %char(sveff)
044500220310     C                   eval      vcovcdate = %char(svtrm)
044600210903      *
044700210903      *
044800210903     C                   eval      viscovl = 'ESP'
044900210903      *
045000210903     C                   select
045100210903      *
045200220615     C                   when      xmcovtp = 'TIN'
045300210910     C                   eval      viscovl = 'EMP'
045400220615     C                   when      xmcovtp = 'THW'
045500210910     C                   eval      viscovl = 'ESP'
045600220615     C                   when      xmcovtp = 'TFA'
045700210910     C                   eval      viscovl = 'FAM'
045800220615     C                   when      xmcovtp = 'TPC'
045900210903     C                   eval      viscovl = 'E1D'
046000220615     C                   when      xmcovtp = 'TP2'
046100210910     C                   eval      viscovl = 'ECH'
046200210910     C                   endsl
046300210903      *
046400210826     C                   eval      vecovin = 'Y'
0465002108260107  *
0466002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
046700210826     C                   eval      vccovin = 'Y'
046800210826     C                   endif
0469002108260107  *
0470002206150296 C                   If        xmcovtp = 'THW'
047100210827     C                   eval      vscovin = 'Y'
047200210826     C                   endif
0473002108260107  *
0474002206150296 C                   If        xmcovtp = 'TFA'
047500210826     C                   eval      vscovin = 'Y'
047600210826     C                   eval      vccovin = 'Y'
047700210826     C                   endif
047800210826      *
047900210916      *
048000210916     C                   eval      pvis = '1'
048100210916      *
048200210917     C                   exsr      setsub
048300210916      *
048400210826     C                   update    ren834r
0485002109160107  *
048600210826     C                   leavesr
048700210826     C                   endif
0488002108260107  *
0489002108260107  *
0490002108260296 C                   If        plncat = 'PLF'
049100210826      *         Process EE Life Coverage
049200210826     C                   movel     policy#       elacct#
049300210827     C                   movel     'LIF'         eltype
049400220310     C                   eval      eledate = %char(sveff)
049500220310     C                   eval      elcdate = %char(svtrm)
049600220308      *
049700220615     C                   eval      elbamt = %editc(xbenamt:'Z')
049800210903      *
049900210903      *
050000210903     C                   eval      elcovl = 'ESP'
050100210903      *
050200210903     C                   select
050300210903      *
050400220615     C                   when      xmcovtp = 'TIN'
050500210903     C                   eval      elcovl = 'EMP'
050600220615     C                   when      xmcovtp = 'THW'
050700210903     C                   eval      elcovl = 'ESP'
050800220615     C                   when      xmcovtp = 'TFA'
050900211028     C                   eval      elcovl = 'FAM'
051000220615     C                   when      xmcovtp = 'TPC'
051100211028     C                   eval      elcovl = 'E1D'
051200220615     C                   when      xmcovtp = 'TP2'
051300211028     C                   eval      elcovl = 'ECH'
051400211028     C                   endsl
051500211028      *
051600211028     C                   eval      plif = '1'
051700211028      *
051800211028     C                   exsr      setsub
051900211028      *
052000211028     C                   update    ren834r
0521002110280107  *
052200210826     C                   leavesr
052300210826     C                   endif
0524002108260107  *
0525002108270107  *
0526002108270296 C                   If        plncat = 'PAC'
052700210827      *         Process EE ADD Coverage
052800210827     C                   movel     policy#       eaacct#
052900210827     C                   movel     'ADD'         eatype
053000220310     C                   eval      eaedate = %char(sveff)
053100220310     C                   eval      eacdate = %char(svtrm)
053200220308      *
053300220615     C                   eval      eabamt = %editc(xbenamt:'Z')
053400210903      *
053500210903      *
053600210903     C                   eval      eacovl = 'ESP'
053700210903      *
053800210903     C                   select
053900210903      *
054000220615     C                   when      xmcovtp = 'TIN'
054100210903     C                   eval      eacovl = 'EMP'
054200220615     C                   when      xmcovtp = 'THW'
054300210903     C                   eval      eacovl = 'ESP'
054400220615     C                   when      xmcovtp = 'TFA'
054500210903     C                   eval      eacovl = 'FAM'
054600220615     C                   when      xmcovtp = 'TPC'
054700210903     C                   eval      eacovl = 'E1D'
054800220615     C                   when      xmcovtp = 'TP2'
054900210903     C                   eval      eacovl = 'ECH'
055000210903     C                   endsl
055100210903      *
055200210916      *
055300210916     C                   eval      plif = '1'
055400210916      *
055500210917     C                   exsr      setsub
055600210827      *
055700210827     C                   update    ren834r
0558002109160107  *
055900210827     C                   leavesr
056000210827     C                   endif
0561002108270107  *
0562002108270107  *
0563002108270296 C                   If        plncat = 'POA'
056400210827      *         Process EE Sup Life Coverage
056500210827     C                   movel     policy#       easacct#
056600210827     C                   movel     'SEA'         eastype
056700220310     C                   eval      easedate = %char(sveff)
056800220310     C                   eval      eascdate = %char(svtrm)
056900220308      *
057000220615     C                   eval      easbamt = %editc(xbenamt:'Z')
057100210903      *
057200210903      *
057300210903     C                   eval      eascovl = 'ESP'
057400210903      *
057500210903     C                   select
057600210903      *
057700220615     C                   when      xmcovtp = 'TIN'
057800210903     C                   eval      eascovl = 'EMP'
057900220615     C                   when      xmcovtp = 'THW'
058000210903     C                   eval      eascovl = 'ESP'
058100220615     C                   when      xmcovtp = 'TFA'
058200210903     C                   eval      eascovl = 'FAM'
058300220615     C                   when      xmcovtp = 'TPC'
058400210903     C                   eval      eascovl = 'E1D'
058500220615     C                   when      xmcovtp = 'TP2'
058600210903     C                   eval      eascovl = 'ECH'
058700210903     C                   endsl
058800210903      *
058900210916      *
059000210916     C                   eval      plif = '1'
059100210916      *
059200210917     C                   exsr      setsub
059300210827      *
059400210827     C                   update    ren834r
0595002108270107  *
059600210827     C                   leavesr
059700210827     C                   endif
0598002108270107  *
0599002108270107  *
0600002108270296 C                   If        plncat = 'PSL'
060100210827      *         Process EE Sup Life Coverage
060200210827     C                   movel     policy#       elsacct#
060300210827     C                   movel     'SEL'         elstype
060400220310     C                   eval      elsedate = %char(sveff)
060500220310     C                   eval      elscdate = %char(svtrm)
060600220308      *
060700220615     C                   eval      elsbamt = %editc(xbenamt:'Z')
060800210903      *
060900210903     C                   eval      elscovl = 'ESP'
061000210903      *
061100210903     C                   select
061200210903      *
061300220615     C                   when      xmcovtp = 'TIN'
061400210903     C                   eval      elscovl = 'EMP'
061500220615     C                   when      xmcovtp = 'THW'
061600210903     C                   eval      elscovl = 'ESP'
061700220615     C                   when      xmcovtp = 'TFA'
061800210903     C                   eval      elscovl = 'FAM'
061900220615     C                   when      xmcovtp = 'TPC'
062000210903     C                   eval      elscovl = 'E1D'
062100220615     C                   when      xmcovtp = 'TP2'
062200210903     C                   eval      elscovl = 'ECH'
062300210903     C                   endsl
062400210903      *
062500210916      *
062600210916     C                   eval      plif = '1'
062700210916      *
062800210917     C                   exsr      setsub
062900210827      *
063000210827     C                   update    ren834r
0631002108270107  *
063200210827     C                   leavesr
063300210827     C                   endif
0634002108270107  *
0635002108270107  *
0636002108270107  *
0637002108270296 C                   If        plncat = 'PSP' or plncat = 'PSA'
0638002108270296 C                   If        sltype = *blanks
063900210827      *         Process Spouse Life or ADD coverage
064000210827     C                   movel     policy#       slacct#
064100210827     C                   movel     'SSL'         sltype
064200220310     C                   eval      sledate = %char(sveff)
064300220310     C                   eval      slcdate = %char(svtrm)
064400220308      *
064500220615     C                   eval      slbamt = %editc(xbenamt:'Z')
064600210903      *
064700210903     C                   eval      slcovl = 'ESP'
064800210903      *
064900210903     C                   select
065000210903      *
065100220615     C                   when      xmcovtp = 'TIN'
065200210903     C                   eval      slcovl = 'EMP'
065300220615     C                   when      xmcovtp = 'THW'
065400210903     C                   eval      slcovl = 'ESP'
065500220615     C                   when      xmcovtp = 'TFA'
065600210903     C                   eval      slcovl = 'FAM'
065700220615     C                   when      xmcovtp = 'TPC'
065800210903     C                   eval      slcovl = 'E1D'
065900220615     C                   when      xmcovtp = 'TP2'
066000210903     C                   eval      slcovl = 'ECH'
066100210903     C                   endsl
066200210903      *
066300210916      *
066400210916     C                   eval      plif = '1'
066500210916      *
066600210917     C                   exsr      setsub
066700210827      *
066800210827     C                   update    ren834r
0669002109160107  *
067000210827     C                   endif
067100210827     C                   leavesr
067200210827     C                   endif
0673002108270107  *
0674002108270107  *
0675002108270296 C                   If        plncat = 'PSD' or plncat = 'PAA'
0676002108270296 C                   If        sltype = *blanks
067700210827      *         Process Dep Life or ADD coverage
067800210827     C                   movel     policy#       dlacct#
067900210827     C                   movel     'SDL'         dltype
068000220310     C                   eval      dledate = %char(sveff)
068100220310     C                   eval      dlcdate = %char(svtrm)
068200220308      *
068300220615     C                   eval      dlbamt = %editc(xbenamt:'Z')
068400210827      *
068500210903      *
068600210903     C                   eval      dlcovl = 'ESP'
068700210903      *
068800210903     C                   select
068900210903      *
069000220615     C                   when      xmcovtp = 'TIN'
069100210903     C                   eval      dlcovl = 'EMP'
069200220615     C                   when      xmcovtp = 'THW'
069300210903     C                   eval      dlcovl = 'ESP'
069400220615     C                   when      xmcovtp = 'TFA'
069500210903     C                   eval      dlcovl = 'FAM'
069600220615     C                   when      xmcovtp = 'TPC'
069700210903     C                   eval      dlcovl = 'E1D'
069800220615     C                   when      xmcovtp = 'TP2'
069900210903     C                   eval      dlcovl = 'ECH'
070000210903     C                   endsl
070100210903      *
070200210916      *
070300210916     C                   eval      plif = '1'
070400210916      *
070500210917     C                   exsr      setsub
070600210916      *
070700210827     C                   update    ren834r
0708002109160107  *
070900210827     C                   endif
071000210827     C                   leavesr
071100210827     C                   endif
0712002108270107  *
0713002108270107  *
0714002202160296 C                   If        plncat = 'PWD' or plncat = 'PVW'
071500210827      *         Process Short Trm Dis Coverage
071600210827     C                   movel     policy#       sdacct#
071700210827     C                   movel     'STD'         sdtype
071800220310     C                   eval      sdedate = %char(sveff)
071900220310     C                   eval      sdcdate = %char(svtrm)
072000220308      *
072100220615     C                   eval      sdbamt = %editc(xbenamt:'Z')
072200210827      *
072300210903      *
072400210903     C                   eval      sdcovl = 'ESP'
072500210903      *
072600210903     C                   select
072700210903      *
072800220615     C                   when      xmcovtp = 'TIN'
072900210903     C                   eval      sdcovl = 'EMP'
073000220615     C                   when      xmcovtp = 'THW'
073100210903     C                   eval      sdcovl = 'ESP'
073200220615     C                   when      xmcovtp = 'TFA'
073300211104     C                   eval      sdcovl = 'FAM'
073400220615     C                   when      xmcovtp = 'TPC'
073500211104     C                   eval      sdcovl = 'E1D'
073600220615     C                   when      xmcovtp = 'TP2'
073700211104     C                   eval      sdcovl = 'ECH'
073800211104     C                   endsl
073900211104      *
074000211104      *
074100211104     C                   eval      plif = '1'
074200211104      *
074300211104     C                   exsr      setsub
074400211104      *
074500210827     C                   update    ren834r
0746002111040107  *
074700211104     C                   leavesr
074800210827     C                   endif
0749002108270107  *
0750002108270107  *
0751002202090296 C                   If        plncat = 'PVL' or plncat = 'PLT'
075200210827      *         Process Long Trm Dis Coverage
075300210827     C                   movel     policy#       ldacct#
075400210827     C                   movel     'LTD'         ldtype
075500220310     C                   eval      ldedate = %char(sveff)
075600220310     C                   eval      ldcdate = %char(svtrm)
075700220308      *
075800220615     C                   eval      ldbamt = %editc(xbenamt:'Z')
075900210903      *
076000210903     C                   eval      ldcovl = 'ESP'
076100210903      *
076200210903     C                   select
076300210903      *
076400220615     C                   when      xmcovtp = 'TIN'
076500210903     C                   eval      ldcovl = 'EMP'
076600220615     C                   when      xmcovtp = 'THW'
076700210903     C                   eval      ldcovl = 'ESP'
076800220615     C                   when      xmcovtp = 'TFA'
076900210903     C                   eval      ldcovl = 'FAM'
077000220615     C                   when      xmcovtp = 'TPC'
077100210903     C                   eval      ldcovl = 'E1D'
077200220615     C                   when      xmcovtp = 'TP2'
077300210903     C                   eval      ldcovl = 'ECH'
077400210903     C                   endsl
077500210903      *
077600210916      *
077700210916     C                   eval      plif = '1'
077800210916      *
077900210917     C                   exsr      setsub
078000210916      *
078100210827     C                   update    ren834r
0782002108270107  *
078300210827     C                   leavesr
078400210827     C                   endif
0785002108270107  *
0786002108270107  *
0787002108270296 C                   If        plncat = 'PEP'
078800210827      *         Process EAP Coverage
078900210827     C                   movel     policy#       epacct#
079000210827     C                   movel     'EAP'         eptype
079100220310     C                   eval      epedate = %char(sveff)
079200220310     C                   eval      epcdate = %char(svtrm)
079300220308      *
079400220615     C                   eval      epbamt = %editc(xbenamt:'Z')
079500210827      *
079600210903     C                   eval      epcovl = 'ESP'
079700210903      *
079800210903     C                   select
079900210903      *
080000220615     C                   when      xmcovtp = 'TIN'
080100210903     C                   eval      epcovl = 'EMP'
080200220615     C                   when      xmcovtp = 'THW'
080300210903     C                   eval      epcovl = 'ESP'
080400220615     C                   when      xmcovtp = 'TFA'
080500210903     C                   eval      epcovl = 'FAM'
080600220615     C                   when      xmcovtp = 'TPC'
080700210903     C                   eval      epcovl = 'E1D'
080800220615     C                   when      xmcovtp = 'TP2'
080900210903     C                   eval      epcovl = 'ECH'
081000210903     C                   endsl
081100210903      *
081200210916      *
081300210916     C                   eval      peap = '1'
081400210916      *
081500210917     C                   exsr      setsub
081600210916      *
081700210827     C                   update    ren834r
0818002108270107  *
081900210827     C                   leavesr
082000210827     C                   endif
0821002108270107  *
082200210826     C                   endsr
082300210826      *
0824002108270107  ********************************************************************************
0825002108270107  *
0826002108270107  *     LOKDEP - Look for Deps with same plan
0827002108270107  *
0828002108270107  ********************************************************************************
082900210827     C     lokdep        begsr
0830002108270107  *
0831002108270291  *        Look for dependents of member
0832002203140297 C                   eval      svdeff = 99999999
0833002203140297 C                   eval      svdtrm = 00000000
0834002203140297 C                   eval      svseq# = 0
0835002203140297 C     dcvky         setll     dcov22                             33
0836002108270296 C                   dou       *in33 = '1'
0837002203140297 C     dcvky         reade     dcov22                                 33
0838002108270296 C                   If        *in33 = '0' and pltrst = dvtrst and
0839002108270296 C                             plsub# = dvsub# and plplan = dvplan
0840002108270291  *
0841002108270296 C                   If        ccandt = 0 or ccandt > cutofn
0842002108270296 C                   If        ccandt = 0 or ccandt < cutofa
0843002108270291  *
0844002108270296 C                   If        ccandt = denrdt
0845002108270297 C                   iter                                                   ccandt = 0
0846002108270297 C                   endif                                                  ccandt = 0
0847002108270291  *
0848002203140296 C                   If        svseq# <> dseq#
0849002203140291  *
0850002203140296 C                   If        svseq# <> 0
0851002203140291 C                   exsr      chkdep
0852002203140297 C                   endif                                                  *in32 = '0'
0853002203140291  *
0854002203140291  *        Reset saved values
0855002203140297 C                   eval      svdeff = 99999999
0856002203140297 C                   eval      svdtrm = 00000000
0857002203140297 C                   eval      svseq# = dseq#
0858002203140291  *
0859002203140296 C                   If        ccandt > svdtrm or ccandt = 0
0860002203140297 C                   eval      svdtrm = ccandt
0861002203140297 C                   endif                                                  *in32 = '0'
0862002203140291  *
0863002203140296 C                   If        denrdt < svdeff
0864002203140297 C                   eval      svdeff = denrdt
0865002203140297 C                   endif                                                  *in32 = '0'
0866002203140291  *
0867002203140297 C                   endif                                                  *in32 = '0'
0868002108270297 C                   endif                                                  ccandt = 0
0869002108270291  *
0870002108270297 C                   endif                                                  ccandt = 0
0871002108270291  *
0872002108270297 C                   endif                                                  *in33 = '0'
0873002108270291  *
0874002108270297 C                   enddo                                                  *in33 = '1'
0875002203140291  *
0876002203140296 C                   If        svseq# <> 0
0877002203140291 C                   exsr      chkdep
0878002203140297 C                   endif                                                  *in32 = '0'
0879002108270107  *
088000210827     C                   endsr
088100210827      *
0882002108270107  ********************************************************************************
0883002108270107  *
0884002108270107  *     CHKDEP - Check for Dependent record
0885002108270107  *
0886002108270107  ********************************************************************************
088700210827     C     chkdep        begsr
0888002108270107  *
0889002108270291  *        get Dependent rec
0890002108270297 C     depky         chain     depndc                             61
0891002108270296 C                   If        *in61 = '0'
0892002108270107  *  Set REN Key values
089300210827     C                   eval      kmemid = %editc(mbssno:'X')
089400210827     C                   eval      kmbrssn = %editc(depss#:'X')
089500210827     C                   eval      kdob = %char(dbirth)
089600210827     C                   movel(P)  dlname        klname
089700210827     C                   movel(P)  dfname        kfname
089800210827     C                   movel     dmi           kmi
0899002108270291  *        See if reord already exists
0900002108270297 C     renky         chain     ren834p                            62
0901002108270296 C                   If        *in62 = '1'
090200210827      *          If not - create member record
090300210827     C                   exsr      crtdep
090400210827      *
0905002108270291  *          Retrieve just created member record
0906002108270297 C     renky         chain     ren834p                            62
0907002108270296 C                   If        *in62 = '1'
0908002108270291  *             WHAT????
090900210827     C                   eval      mi = mi
091000210827     C                   endif
091100210827      *
091200210827     C                   endif
091300210827      *          Add coverge data to mbr rec
091400210827     C                   exsr      addcvgd
091500210827      *
091600210827     C                   endif
0917002108270107  *
091800210827     C                   endsr
0919002108270107  ********************************************************************************
0920002108270107  *
0921002108270107  *     CRTDEP - Create Dep rec - load demographics
0922002108270107  *
0923002108270107  ********************************************************************************
092400210827     C     crtdep        begsr
0925002108270107  *
092600210827     C                   clear                   ren834r
092700210827     C                   eval      recid = '02'
092800210827     C                   eval      prkeyty = 'S'
0929002108270291  *
093000210827     C                   eval      relcd = 'CH'
0931002108270296 C                   If        drelcd = 'RWI' or drelcd = 'RHU'
093200210827     C                   eval      relcd = 'SP'
093300210827     C                   endif
0934002109160107  *
093500210916     C                   eval      epprods = '    '
0936002108270291  *        Get Account data
0937002108270297 C     accky         chain     accmst                             51
0938002108270296 C                   If        *in51 = '0'
093900210827     C                   movel(P)  acnam1        groupnam
094000210827     C                   endif
094100210827      *
0942002108270297 C     accky         chain     ac2mstl2                           51
0943002108270296 C                   If        *in51 = '0'
094400210827     C                   eval      grouptid = %editc(a2tax_id#:'X')
094500210827     C                   endif
094600210827      *      Mbr demo data
094700210827     C                   eval      memid = %editc(mbssno:'X')
094800210827     C                   eval      dateofbth = %char(dbirth)
094900210827     C                   movel     dlname        lastname
095000210827     C                   movel     dfname        firstname
095100210827     C                   movel     dmi           mi
095200210827     C                   movel     dsex          gender
095300210827     C                   eval      mbrssn = %editc(depss#:'X')
095400210827     C                   eval      cphone = %editc(darea:'X') +
095500210827     C                             %editc(dphone:'X')
095600210827     C                   movel     daddr1        address1
095700210827     C                   movel     daddr2        address2
095800210827     C                   movel     dcity         ccity
095900210827     C                   movel     dstate        cstate
096000210827     C                   eval      czip = %editc(dzip:'X')
096100210827      *
0962002108270296 C                   If        dhndcp > ' '
096300210827     C                   eval      disabled = 'H'
096400210827     C                   endif
096500210827      *
096600210827     C                   eval      tssn = %editc(depss#:'X')
096700220211     C                   eval      feditin = %editc(depss#:'X')
096800220211     C                   eval      policy# = %subst(group#:1:7)
096900220211      *
097000220211     C                   eval      epsubcl = hldsub
097100220211      *
097200220211      *
097300210827     C                   write     ren834r
0974002108270107  *
097500210827     C                   endsr
097600210827      *
0977002108270107  ********************************************************************************
0978002108270107  *
0979002108270107  *     ADDCVGD - Add coverage data to dep record
0980002108270107  *               Already have REN dep rec, dcov + plnmst records
0981002108270107  *
0982002108270107  ********************************************************************************
098300210827     C     addcvgd       begsr
0984002108270107  *
0985002108270296 C                   If        plncat = 'PDN'
098600210827      *         Process Dental Coverage
098700210827     C                   movel     policy#       dacct#
098800210827     C                   movel     'DEN'         dtype
098900220314     C                   eval      dcovedate = %char(svdeff)
099000220308      *
099100220314     C                   if        svdtrm <> 0
099200220314     C                   movel     svdtrm        cdat
0993002203080297 C     cdat          subdur    1:*D          cdat
0994002203140297 C                   movel     cdat          svdtrm
099500220314     C                   eval      dcovcdate = %char(svdtrm)
099600220308     C                   endif
099700220308      *
0998002108270107  *
099900210903      *
100000210903     C                   eval      dencovl = 'ESP'
100100210903      *
100200210903     C                   select
100300210903      *
100400220615     C                   when      xmcovtp = 'TIN'
100500210903     C                   eval      dencovl = 'EMP'
100600220615     C                   when      xmcovtp = 'THW'
100700210903     C                   eval      dencovl = 'ESP'
100800220615     C                   when      xmcovtp = 'TFA'
100900210903     C                   eval      dencovl = 'FAM'
101000220615     C                   when      xmcovtp = 'TPC'
101100210903     C                   eval      dencovl = 'E1D'
101200220615     C                   when      xmcovtp = 'TP2'
101300210903     C                   eval      dencovl = 'ECH'
101400210903     C                   endsl
101500210903      *
101600210827     C                   eval      decovin = 'Y'
1017002108270107  *
1018002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
101900210827     C                   eval      dccovin = 'Y'
102000210827     C                   endif
1021002108270107  *
1022002206150296 C                   If        xmcovtp = 'THW'
102300210827     C                   eval      dscovin = 'Y'
102400210827     C                   endif
1025002108270107  *
1026002206150296 C                   If        xmcovtp = 'TFA'
102700210827     C                   eval      dscovin = 'Y'
102800210827     C                   eval      dccovin = 'Y'
102900210827     C                   endif
103000210916      *
103100210916     C                   eval      pden = '1'
103200210916      *
103300210930     C***                exsr      setsub
103400210930     C                   eval      epsubcl = hldsub
103500210827      *
103600210827     C                   update    ren834r
1037002108270107  *
103800210827     C                   leavesr
103900210827     C                   endif
1040002108270107  *
1041002108270107  *
1042002108270296 C                   If        plncat = 'PVS'
104300210827      *         Process Vision Coverage
104400210827     C                   movel     policy#       vacct#
104500210827     C                   movel     'VIS'         vtype
104600220314     C                   eval      vcovedate = %char(svdeff)
104700220308      *
104800220314     C                   if        svdtrm <> 0
104900220314     C                   movel     svdtrm        cdat
1050002203080297 C     cdat          subdur    1:*D          cdat
1051002203140297 C                   movel     cdat          svdtrm
105200220314     C                   eval      vcovcdate = %char(svdtrm)
105300220308     C                   endif
105400220308      *
105500210903     C                   eval      viscovl = 'ESP'
105600210903      *
105700210903     C                   select
105800210903      *
105900220615     C                   when      xmcovtp = 'TIN'
106000210903     C                   eval      viscovl = 'EMP'
106100220615     C                   when      xmcovtp = 'THW'
106200210903     C                   eval      viscovl = 'ESP'
106300220615     C                   when      xmcovtp = 'TFA'
106400210903     C                   eval      viscovl = 'FAM'
106500220615     C                   when      xmcovtp = 'TPC'
106600210903     C                   eval      viscovl = 'E1D'
106700220615     C                   when      xmcovtp = 'TP2'
106800210903     C                   eval      viscovl = 'ECH'
106900210903     C                   endsl
107000210903      *
107100210827     C                   eval      vecovin = 'Y'
1072002108270107  *
1073002206150296 C                   If        xmcovtp = 'TPC' or xmcovtp = 'TP2'
107400210827     C                   eval      vccovin = 'Y'
107500210827     C                   endif
1076002108270107  *
1077002206150296 C                   If        xmcovtp = 'THW'
107800210827     C                   eval      vscovin = 'Y'
107900210827     C                   endif
1080002108270107  *
1081002206150296 C                   If        xmcovtp = 'TFA'
108200210827     C                   eval      vscovin = 'Y'
108300210827     C                   eval      vccovin = 'Y'
108400210827     C                   endif
108500210916      *
108600210916     C                   eval      pvis = '1'
108700210916      *
108800210930     C****               exsr      setsub
108900210930     C                   eval      epsubcl = hldsub
109000210827      *
109100210827     C                   update    ren834r
1092002108270107  *
109300210827     C                   leavesr
109400210827     C                   endif
1095002108270107  *
1096002108270107  *
1097002108270296 C                   If        plncat = 'PLF'
109800210827      *         Process EE Life Coverage
109900210827     C                   movel     policy#       elacct#
110000210827     C                   movel     'LIF'         eltype
110100220314     C                   eval      eledate = %char(svdeff)
110200220308      *
110300220314     C                   if        svdtrm <> 0
110400220314     C                   movel     svdtrm        cdat
1105002203080297 C     cdat          subdur    1:*D          cdat
1106002203140297 C                   movel     cdat          svdtrm
110700220314     C                   eval      elcdate = %char(svdtrm)
110800220308     C                   endif
110900220308      *
111000220615     C                   eval      elbamt = %editc(xbenamt:'Z')
111100210827      *
111200210903      *
111300210903     C                   eval      elcovl = 'ESP'
111400210903      *
111500210903     C                   select
111600210903      *
111700220615     C                   when      xmcovtp = 'TIN'
111800210903     C                   eval      elcovl = 'EMP'
111900220615     C                   when      xmcovtp = 'THW'
112000210903     C                   eval      elcovl = 'ESP'
112100220615     C                   when      xmcovtp = 'TFA'
112200210903     C                   eval      elcovl = 'FAM'
112300220615     C                   when      xmcovtp = 'TPC'
112400210903     C                   eval      elcovl = 'E1D'
112500220615     C                   when      xmcovtp = 'TP2'
112600210903     C                   eval      elcovl = 'ECH'
112700210903     C                   endsl
112800210916      *
112900210916     C                   eval      plif = '1'
113000210916      *
113100210930     C*****              exsr      setsub
113200210903      *
113300210827     C                   update    ren834r
1134002108270107  *
113500210827     C                   leavesr
113600210827     C                   endif
1137002108270107  *
1138002108270107  *
1139002108270296 C                   If        plncat = 'PAC'
114000210827      *         Process EE ADD Coverage
114100210827     C                   movel     policy#       eaacct#
114200210827     C                   movel     'ADD'         eatype
114300220314     C                   eval      eaedate = %char(svdeff)
114400220308      *
114500220314     C                   if        svdtrm <> 0
114600220314     C                   movel     svdtrm        cdat
1147002203080297 C     cdat          subdur    1:*D          cdat
1148002203140297 C                   movel     cdat          svdtrm
114900220314     C                   eval      eacdate = %char(svdtrm)
115000220308     C                   endif
115100220308      *
115200220615     C                   eval      eabamt = %editc(xbenamt:'Z')
115300210827      *
115400210903      *
115500210903     C                   eval      eacovl = 'ESP'
115600210903      *
115700210903     C                   select
115800210903      *
115900220615     C                   when      xmcovtp = 'TIN'
116000210903     C                   eval      eacovl = 'EMP'
116100220615     C                   when      xmcovtp = 'THW'
116200210903     C                   eval      eacovl = 'ESP'
116300220615     C                   when      xmcovtp = 'TFA'
116400210903     C                   eval      eacovl = 'FAM'
116500220615     C                   when      xmcovtp = 'TPC'
116600210903     C                   eval      eacovl = 'E1D'
116700220615     C                   when      xmcovtp = 'TP2'
116800210903     C                   eval      eacovl = 'ECH'
116900210903     C                   endsl
117000210916      *
117100210916     C                   eval      plif = '1'
117200210916      *
117300210930     C****               exsr      setsub
117400210930     C                   eval      epsubcl = hldsub
117500210903      *
117600210827     C                   update    ren834r
1177002108270107  *
117800210827     C                   leavesr
117900210827     C                   endif
1180002108270107  *
1181002108270107  *
1182002108270296 C                   If        plncat = 'POA'
118300210827      *         Process EE Sup Life Coverage
118400210827     C                   movel     policy#       easacct#
118500210827     C                   movel     'SEA'         eastype
118600220314     C                   eval      easedate = %char(svdeff)
118700220308      *
118800220314     C                   if        svdtrm <> 0
118900220314     C                   movel     svdtrm        cdat
1190002203080297 C     cdat          subdur    1:*D          cdat
1191002203140297 C                   movel     cdat          svdtrm
119200220314     C                   eval      eascdate = %char(svdtrm)
119300220308     C                   endif
119400220308      *
119500220615     C                   eval      easbamt = %editc(xbenamt:'Z')
119600210903      *
119700210903     C                   eval      eascovl = 'ESP'
119800210903      *
119900210903     C                   select
120000210903      *
120100220615     C                   when      xmcovtp = 'TIN'
120200210903     C                   eval      eascovl = 'EMP'
120300220615     C                   when      xmcovtp = 'THW'
120400210903     C                   eval      eascovl = 'ESP'
120500220615     C                   when      xmcovtp = 'TFA'
120600210903     C                   eval      eascovl = 'FAM'
120700220615     C                   when      xmcovtp = 'TPC'
120800210903     C                   eval      eascovl = 'E1D'
120900220615     C                   when      xmcovtp = 'TP2'
121000210903     C                   eval      eascovl = 'ECH'
121100210903     C                   endsl
121200210916      *
121300210916     C                   eval      plif = '1'
121400210916      *
121500210930     C****               exsr      setsub
121600210930     C                   eval      epsubcl = hldsub
121700210903      *
121800210827     C                   update    ren834r
1219002108270107  *
122000210827     C                   leavesr
122100210827     C                   endif
1222002108270107  *
1223002108270107  *
1224002108270296 C                   If        plncat = 'PSL'
122500210827      *         Process EE Sup Life Coverage
122600210827     C                   movel     policy#       elsacct#
122700210827     C                   movel     'SEL'         elstype
122800220314     C                   eval      elsedate = %char(svdeff)
122900220308      *
123000220314     C                   if        svdtrm <> 0
123100220314     C                   movel     svdtrm        cdat
1232002203080297 C     cdat          subdur    1:*D          cdat
1233002203140297 C                   movel     cdat          svdtrm
123400220314     C                   eval      elscdate = %char(svdtrm)
123500220308     C                   endif
123600220308      *
123700210827     C                   eval      elsbamt = %editc(benamt:'Z')
123800210903      *
123900210903     C                   eval      elscovl = 'ESP'
124000210903      *
124100210903     C                   select
124200210903      *
124300220615     C                   when      xmcovtp = 'TIN'
124400210903     C                   eval      elscovl = 'EMP'
124500220615     C                   when      xmcovtp = 'THW'
124600210903     C                   eval      elscovl = 'ESP'
124700220615     C                   when      xmcovtp = 'TFA'
124800210903     C                   eval      elscovl = 'FAM'
124900220615     C                   when      xmcovtp = 'TPC'
125000210903     C                   eval      elscovl = 'E1D'
125100220615     C                   when      xmcovtp = 'TP2'
125200210903     C                   eval      elscovl = 'ECH'
125300210903     C                   endsl
125400210903      *
125500210916      *
125600210916     C                   eval      plif = '1'
125700210916      *
125800210930     C****               exsr      setsub
125900210930     C                   eval      epsubcl = hldsub
126000210827      *
126100210827     C                   update    ren834r
1262002108270107  *
126300210827     C                   leavesr
126400210827     C                   endif
1265002108270107  *
1266002108270107  *
1267002108270107  *
1268002108270296 C                   If        plncat = 'PSP' or plncat = 'PSA'
1269002108270296 C                   If        sltype = *blanks
127000210827      *         Process Spouse Life or ADD coverage
127100210827     C                   movel     policy#       slacct#
127200210827     C                   movel     'SSL'         sltype
127300220314     C                   eval      sledate = %char(svdeff)
127400220308      *
127500220314     C                   if        svdtrm <> 0
127600220314     C                   movel     svdtrm        cdat
1277002203080297 C     cdat          subdur    1:*D          cdat
1278002203140297 C                   movel     cdat          svdtrm
127900220314     C                   eval      slcdate = %char(svdtrm)
128000220308     C                   endif
128100220308      *
128200210827     C                   eval      slbamt = %editc(benamt:'Z')
128300210903      *
128400210903     C                   eval      slcovl = 'ESP'
128500210903      *
128600210903     C                   select
128700210903      *
128800220615     C                   when      xmcovtp = 'TIN'
128900210903     C                   eval      slcovl = 'EMP'
129000220615     C                   when      xmcovtp = 'THW'
129100210903     C                   eval      slcovl = 'ESP'
129200220615     C                   when      xmcovtp = 'TFA'
129300210903     C                   eval      slcovl = 'FAM'
129400220615     C                   when      xmcovtp = 'TPC'
129500210903     C                   eval      slcovl = 'E1D'
129600220615     C                   when      xmcovtp = 'TP2'
129700210903     C                   eval      slcovl = 'ECH'
129800210903     C                   endsl
129900210903      *
130000210916      *
130100210916     C                   eval      plif = '1'
130200210916      *
130300210930     C****               exsr      setsub
130400210930     C                   eval      epsubcl = hldsub
130500210827      *
130600210827     C                   update    ren834r
1307002108270107  *
130800210827     C                   endif
130900210827     C                   leavesr
131000210827     C                   endif
1311002108270107  *
1312002108270107  *
1313002108270296 C                   If        plncat = 'PSD' or plncat = 'PAA'
1314002108270296 C                   If        sltype = *blanks
131500210827      *         Process Dep Life or ADD coverage
131600210827     C                   movel     policy#       dlacct#
131700210827     C                   movel     'SDL'         dltype
131800220314     C                   eval      dledate = %char(svdeff)
131900220308      *
132000220314     C                   if        svdtrm <> 0
132100220314     C                   movel     svdtrm        cdat
1322002203080297 C     cdat          subdur    1:*D          cdat
1323002203140297 C                   movel     cdat          svdtrm
132400220314     C                   eval      dlcdate = %char(svdtrm)
132500220308     C                   endif
132600220308      *
132700210827     C                   eval      dlbamt = %editc(benamt:'Z')
132800210827      *
132900210903      *
133000210903     C                   eval      dlcovl = 'ESP'
133100210903      *
133200210903     C                   select
133300210903      *
133400220615     C                   when      xmcovtp = 'TIN'
133500210903     C                   eval      dlcovl = 'EMP'
133600220615     C                   when      xmcovtp = 'THW'
133700210903     C                   eval      dlcovl = 'ESP'
133800220615     C                   when      xmcovtp = 'TFA'
133900210903     C                   eval      dlcovl = 'FAM'
134000220615     C                   when      xmcovtp = 'TPC'
134100210903     C                   eval      dlcovl = 'E1D'
134200220615     C                   when      xmcovtp = 'TP2'
134300210903     C                   eval      dlcovl = 'ECH'
134400210903     C                   endsl
134500210903      *
134600210916      *
134700210916     C                   eval      plif = '1'
134800210916      *
134900210930     C****               exsr      setsub
135000210930     C                   eval      epsubcl = hldsub
135100210916      *
135200210827     C                   update    ren834r
1353002108270107  *
135400210827     C                   endif
135500210827     C                   leavesr
135600210827     C                   endif
1357002108270107  *
1358002108270107  *
1359002108270296 C                   If        plncat = 'PWD'
136000210827      *         Process Short Trm Dis Coverage
136100210827     C                   movel     policy#       sdacct#
136200210827     C                   movel     'STD'         sdtype
136300220314     C                   eval      sdedate = %char(svdeff)
136400220308      *
136500220314     C                   if        svdtrm <> 0
136600220314     C                   movel     svdtrm        cdat
1367002203080297 C     cdat          subdur    1:*D          cdat
1368002203140297 C                   movel     cdat          svdtrm
136900220314     C                   eval      sdcdate = %char(svdtrm)
137000220308     C                   endif
137100220308      *
137200210827     C                   eval      sdbamt = %editc(benamt:'Z')
137300210903      *
137400210903     C                   eval      sdcovl = 'ESP'
137500210903      *
137600210903     C                   select
137700210903      *
137800220615     C                   when      xmcovtp = 'TIN'
137900210903     C                   eval      sdcovl = 'EMP'
138000220615     C                   when      xmcovtp = 'THW'
138100210903     C                   eval      sdcovl = 'ESP'
138200220615     C                   when      xmcovtp = 'TFA'
138300210903     C                   eval      sdcovl = 'FAM'
138400220615     C                   when      xmcovtp = 'TPC'
138500210903     C                   eval      sdcovl = 'E1D'
138600220615     C                   when      xmcovtp = 'TP2'
138700210903     C                   eval      sdcovl = 'ECH'
138800210903     C                   endsl
138900210903      *
139000210916      *
139100210916     C                   eval      plif = '1'
139200210916      *
139300210930     C****               exsr      setsub
139400210930     C                   eval      epsubcl = hldsub
139500210916      *
139600210827     C                   update    ren834r
1397002108270107  *
139800210827     C                   leavesr
139900210827     C                   endif
1400002108270107  *
1401002108270107  *
1402002202090296 C                   If        plncat = 'PVL' or plncat = 'PLT'
140300210827      *         Process Long Trm Dis Coverage
140400210827     C                   movel     policy#       ldacct#
140500210827     C                   movel     'LTD'         ldtype
140600220314     C                   eval      ldedate = %char(svdeff)
140700220308      *
140800220314     C                   if        svdtrm <> 0
140900220314     C                   movel     svdtrm        cdat
1410002203080297 C     cdat          subdur    1:*D          cdat
1411002203140297 C                   movel     cdat          svdtrm
141200220314     C                   eval      ldcdate = %char(svdtrm)
141300220308     C                   endif
141400220308      *
141500210827     C                   eval      ldbamt = %editc(benamt:'Z')
141600210827      *
141700210903      *
141800210903     C                   eval      ldcovl = 'ESP'
141900210903      *
142000210903     C                   select
142100210903      *
142200220615     C                   when      xmcovtp = 'TIN'
142300210903     C                   eval      ldcovl = 'EMP'
142400220615     C                   when      xmcovtp = 'THW'
142500210903     C                   eval      ldcovl = 'ESP'
142600220615     C                   when      xmcovtp = 'TFA'
142700210903     C                   eval      ldcovl = 'FAM'
142800220615     C                   when      xmcovtp = 'TPC'
142900210903     C                   eval      ldcovl = 'E1D'
143000220615     C                   when      xmcovtp = 'TP2'
143100210903     C                   eval      ldcovl = 'ECH'
143200210903     C                   endsl
143300210903      *
143400210916      *
143500210916     C                   eval      plif = '1'
143600210916      *
143700210930     C****               exsr      setsub
143800210930     C                   eval      epsubcl = hldsub
143900210917      *
144000210917     C                   update    ren834r
1441002109170107  *
144200210917     C                   leavesr
144300210917     C                   endif
1444002109170107  *
1445002108270107  *
1446002109170296 C                   If        plncat = 'PEP'
144700210827      *         Process EAP Coverage
144800210827     C                   movel     policy#       epacct#
144900210827     C                   movel     'EAP'         eptype
145000220314     C                   eval      epedate = %char(svdeff)
145100220308      *
145200220314     C                   if        svdtrm <> 0
145300220314     C                   movel     svdtrm        cdat
1454002203080297 C     cdat          subdur    1:*D          cdat
1455002203140297 C                   movel     cdat          svdtrm
145600220314     C                   eval      epcdate = %char(svdtrm)
145700220308     C                   endif
145800220308      *
145900210827     C                   eval      epbamt = %editc(benamt:'Z')
146000210903      *
146100210903     C                   eval      epcovl = 'ESP'
146200210903      *
146300210903     C                   select
146400210903      *
146500220615     C                   when      xmcovtp = 'TIN'
146600210903     C                   eval      epcovl = 'EMP'
146700220615     C                   when      xmcovtp = 'THW'
146800210903     C                   eval      epcovl = 'ESP'
146900220615     C                   when      xmcovtp = 'TFA'
147000210903     C                   eval      epcovl = 'FAM'
147100220615     C                   when      xmcovtp = 'TPC'
147200210903     C                   eval      epcovl = 'E1D'
147300220615     C                   when      xmcovtp = 'TP2'
147400210903     C                   eval      epcovl = 'ECH'
147500210903     C                   endsl
147600210903      *
147700210916      *
147800210916     C                   eval      peap = '1'
147900210916      *
148000210930     C****               exsr      setsub
148100210930     C                   eval      epsubcl = hldsub
148200210827      *
148300210827     C                   update    ren834r
1484002108270107  *
148500210827     C                   leavesr
148600210827     C                   endif
1487002108270107  *
148800210827     C                   endsr
148900210827      *
1490002109170107  ********************************************************************************
1491002109170107  *
1492002109170107  *     SETSUB - Set the Subclient/Location code based on Prods
1493002109170107  *
1494002109170107  ********************************************************************************
149500210917     C     setsub        begsr
1496002109170107  *
149700210917      *
149800210917     C                   eval      epsubcl = '     '
149900210917     C                   select
150000211025      *   No VIS
150100210917     C                   when      epprods = '1 11'
150200210917     C                   eval      epsubcl = '10000'
150300211025     C                   when      epprods = '1 1 '
150400211025     C                   eval      epsubcl = '10000'
150500211025     C                   when      epprods = '1  1'
150600211025     C                   eval      epsubcl = '10000'
150700211025      *    DEN + VIS + LIF/DIS/EAP
150800210917     C                   when      epprods = '1111'
150900210917     C                   eval      epsubcl = '29511'
151000210917     C                   when      epprods = '111 '
151100210917     C                   eval      epsubcl = '29511'
151200211025     C                   when      epprods = '11 1'
151300211025     C                   eval      epsubcl = '29511'
151400211025      *   LIF/DIS only
151500211105     C                   when      epprods = '  11'
151600211105     C                   eval      epsubcl = '88888'
151700211105     C                   when      epprods = '  1 '
151800211105     C                   eval      epsubcl = '88888'
151900211105      *   EAP only
152000211105     C                   when      epprods = '   1'
152100211105     C                   eval      epsubcl = '89001'
152200211105      *   No DEN
152300211105     C                   when      epprods = '  11'
152400211112     C                   eval      epsubcl = '99511'
152500211105     C                   when      epprods = ' 111'
152600211112     C                   eval      epsubcl = '99511'
152700211105     C                   when      epprods = ' 1 1'
152800211112     C                   eval      epsubcl = '99511'
152900211025     C                   when      epprods = ' 11 '
153000211112     C                   eval      epsubcl = '99511'
153100211025     C                   endsl
153200210930      *
153300210930     C                   eval      hldsub = epsubcl
1534002109170107  *
153500210917     C                   endsr
153600210917      *
1537002110260107  ********************************************************************************
1538002110260107  *
1539002110260107  *     UPDDEP - Update dep recs based on Mbr settings
1540002110260107  *
1541002110260107  ********************************************************************************
154200211026     C     upddep        begsr
1543002110260107  *
1544002110260291  *  Loop thru REN834L
1545002110260297 C     *loval        setll     ren834l                            61
1546002110260296 C                   dou       *in61 = '1'
1547002111020297 C                   read      ren834l                                61
1548002111020296 C                   If        *in61 = '1'
154900211102     C                   leavesr
155000211102     C                   endif
155100211102      *
1552002111020296 C                   If        xmemid = '218450026'
155300211102     C                   eval      xrecid = xrecid
155400211102     C                   endif
155500211102      *
1556002111020296 C                   If        xrecid = '01'
155700211102     C                   eval      svmemid = xmemid
155800211102     C                   eval      svepsubcl = xepsubcl
155900211102     C                   eval      usedep = 'Y'
1560002111020296 C                   If        xepsubcl = '88888' or xepsubcl = '890001'
156100211026     C                   eval      usedep = 'N'
156200211026     C                   endif
156300211026     C                   iter
156400211026     C                   endif
1565002110260291  *     Process Dep rec
156600220315     C                   if        svmemid = xmemid
156700220315     C                   if        usedep = 'N' or
156800220315     C                             (xden = ' ' and xvis = ' ')
156900220315     C                   delete    ren834x
157000220315     C                   iter
157100220315     C                   endif
157200220315      *
157300220315     C                   eval      xepsubcl = svepsubcl
157400220315     C                   update    ren834x
157500220315     C                   iter
157600220315     C                   endif
157700211112      *
157800211112     C                   enddo
157900211026      *
158000211026     C                   endsr
