0001000204020002  *****************************************************************************
000200220407      * ELIGPUWFR  Amwins Connect Adminstrators                                   *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400220407      *            DATE - 04/2022                                                 *
000500220407      *  DESCRIPTION - Build file of current mbrs/deps for a SMAN                 *
0006000204020002  *****************************************************************************
0007000204020015  *  Change Log:                                                              *
000800210701      *  xxx mm/dd/yyyy                                                           *
000900200828      *
0010009102150018 F******************************************************************
0011002204070019 FCMCTPLDT  IP   E           K DISK
0012002204080019 FPLNMST    IF   E           K DISK
001300220408     FCODES     IF   E           K DISK
001400210826     FMCOV42    IF   E           K DISK
001500020404     FMEMBER    IF   E           K DISK
001600220408     FGRAT25    IF   E           K DISK
001700220314     FDCOV22    IF   E           K DISK
001800020404     FDEPNDC    IF   E           K DISK
001900220407     FSMOKE     IF   E           K DISK
0020002204070020 FELIGPUXP  UF A E           K DISK
0021000204020025  *
002200200529      *
0023002005290250 D                 DS
0024002108270251 D  cursalary9             1      9
0025002108270251 D   cursalary             2      9
002600210827      *
0027002203020250 D                 DS
0028002203020251 D  hiskey                 1     10
0029002203020251 D   hiskey9               2     10
003000220302      *
0031002108270250 D                 DS
0032002108270251 D  fill66                 1     66
0033002108270251 D   gemail                1     65
003400211227      *
0035002112270250 D                 DS
0036002204070251 D  curkey                 1     10
0037002204070251 D   cmtrst                1      3  0
0038002204070251 D   csubdv                4      6  0
0039002204070251 D   cmplan                7     10
004000211227      *
0041002204070250 D                 DS
0042002204070251 D  hldkey                 1     10
0043002204070251 D   hmtrst                1      3  0
0044002204070251 D   hsubdv                4      6  0
0045002204070251 D   hmplan                7     10
0046002204070025  *
0047002204070250 D                 DS
0048002204070251 D  plncat                 1      3
0049002204070251 D   plc1                  1      1
0050002204070251 D   plc23                 2      3
005100210727      *
0052002107270250 D                 DS
0053002107270251 D  dseq                          2S 0 INZ(0)
0054002107270251 D  cutoff                         D   DATFMT(*ISO)
0055002107270251 D  cutofx                         D   DATFMT(*ISO)
0056002107270251 D  cutofy                         D   DATFMT(*ISO)
0057002203080251 D  cdat                           D   DATFMT(*ISO)
0058002204070037 D wkdate                          D   datfmt(*iso)
005900220407     D usadt                           D   DATFMT(*USA/)
0060002204070251 D  mdydat                         D   DATFMT(*USA)
0061002203080251 D  cndat                         8S 0
0062002203080251 D  cutofn                        8S 0
0063002107270251 D  cutofa                        8S 0
0064002107270251 D  today8                        8S 0
0065002108260251 D  hiredatet                      D
0066002108270251 D  todad                          D
006700210727      *
0068002107090251 D  todaa                              LIKE(frmdat)
0069002107090251 D  date9                              LIKE(frmdat)
007000210825      *
0071002203100251 D  svplan                             LIKE(mcplan)
0072002204080251 D  scovtp                             LIKE(mcovtp)
0073002203100251 D  svssn                              LIKE(mcssno)
0074002203100251 D  sveff                              LIKE(enrldt)
0075002203100251 D  svtrm                              LIKE(candt)
0076002203140251 D  svdeff                             LIKE(enrldt)
0077002203140251 D  svdtrm                             LIKE(candt)
0078002203140251 D  svseq#                             LIKE(dseq#)
0079002204070251 D  wkseq#                             LIKE(dseq#)
008000220310      *
008100220407      *
008200220407     C     elgky         klist
008300220407     C                   kfld                    pltrst
008400220407     C                   kfld                    plsub#
008500220408     C                   kfld                    acc#
008600220407     C                   kfld                    svssn
008700220407     C                   kfld                    wkseq#
008800210825      *
008900220407     C     plnkey        klist
009000220407     C                   kfld                    cmtrst
009100220407     C                   kfld                    csubdv
009200220407     C                   kfld                    cmplan
009300210825      *
009400210825     C     grkey         klist
009500210825     C                   kfld                    pltrst
009600210825     C                   kfld                    plsub#
009700210825     C                   kfld                    plplan
009800210825     C                   kfld                    date9
009900220407      *
010000220407     C     codky         klist
010100220407     C                   kfld                    plc1
010200220407     C                   kfld                    plc23
010300081103      *
010400041228     C     mcvky         klist
010500081103     C                   kfld                    pltrst
010600081103     C                   kfld                    plsub#
010700081103     C                   kfld                    plplan
010800220314      *
010900220314     C     dcvky         klist
011000220314     C                   kfld                    pltrst
011100220314     C                   kfld                    plsub#
011200220314     C                   kfld                    plplan
011300220314     C                   kfld                    svssn
011400081103      *
011500020404     C     depky         klist
011600220314     C                   kfld                    svssn
011700220314     C                   kfld                    svseq#
011800220407      *
011900220407     C     smkky         klist
012000220407     C                   kfld                    epmssn
012100220407     C                   kfld                    epseq#
012200220218      *
0123000204040291  *
0124002204070291  * Main Line - Loop thru Commission Ctl File
0125002202250291  *
0126002204070291  *     For Specific RELID
0127002204070296 C                   If        cmrelid = '00007037' and
0128002204070296 C                             (cmcan = 0 or cmcan >= today8)
0129002204070296 C                   If        curkey <> hldkey
0130002204070296 C                   eval      hldkey = curkey
0131002204080291  *
0132002204080296 C                   If        cmplan = 'EALQ' and cmtrst = 591
0133002204080296 C                   eval      cmplan = cmplan
0134002204080296 C                   endif
0135002204070291  *
0136002204070297 C     plnkey        chain     plnmst                             21
0137002204070296 C                   if        *in21 = '0'
0138002204070291  *     Using GBS info - Get GRATE record
0139002204070297 C     grkey         setll     grat25                             22
0140002204070297 C                   read      grat25                                 22
0141002204070296 C                   If        *in22 = '0'
0142002204070291  *
0143002204070297 C     codky         chain     codes                              33
014400220407     C                   if        *in33 = '0'
0145002204070291  *        DEN or VIS Plan
014600220408     C                   if        action = 'D' or action = 'V'
0147002111240291  *
0148002111240291  *        Loop thru mcov file using T,S,P
0149002203100297 C                   eval      sveff = 99999999
0150002203100297 C                   eval      svtrm = 00000000
0151002203100297 C                   eval      svplan = *blanks
0152002203100297 C                   eval      svssn = 0
0153002111240297 C     mcvky         setll     mcov42                             31
0154002111240296 C                   dou       *in31 = '1'
0155002111240297 C     mcvky         reade     mcov42                                 31
0156002111240296 C                   If        *in31 = '0' and pltrst = mctrst and
0157002110250296 C                             plsub# = mcsub# and plplan = mcplan and
0158002110250296 C                             (candt = 0 or candt > enrldt)
0159002204080291  *
0160002204080296 C                   If        mcssno = 481110648
0161002204080296 C                   eval      cmplan = cmplan
0162002204080296 C                   endif
0163002204080291  *
0164002110200291  *
0165002110200296 C                   If        candt = enrldt
0166002110200296 C                   Iter
0167002109210296 C                   endif
0168002203100291  * debug shit
0169002203100296 C                   If        mcssno = 150602351
0170002203100297 C                   eval      mcssno = mcssno
0171002203100296 C                   endif
0172002110200291  *
0173002203100296 C                   If        mcssno <> svssn
0174002110200291  *
0175002203100296 C                   If        svssn <> 0
0176002203100291  *
0177002204070296 C                   If        svtrm = 0 or svtrm > today8
0178002204070291  *
0179002110290291 C                   exsr      chkmbr
0180002110290291  *
0181002110290291 C                   exsr      lokdep
0182002110290291  *
0183002110290297 C                   endif                                                  *in33 = '1'
0184002204070297 C                   endif                                                  *in33 = '1'
0185002203100291  *        Reset saved values
0186002203100297 C                   eval      sveff = 99999999
0187002203100297 C                   eval      svtrm = 00000000
0188002203100297 C                   eval      svssn = mcssno
0189002204080297 C                   endif                                                  *in32 = '0'
0190002111050297 C                   endif                                                  *in32 = '0'
0191002203100291  *
0192002203100296 C                   If        candt > svtrm or candt = 0
0193002203100297 C                   eval      svtrm = candt
0194002111050297 C                   endif                                                  *in32 = '0'
0195002203100291  *
0196002203100296 C                   If        enrldt < sveff
0197002203100297 C                   eval      sveff = enrldt
0198002203100297 C                   endif                                                  *in32 = '0'
0199002110290291  *
0200002204080297 C                   eval      scovtp = mcovtp
0201002203100291  *
0202002203040297 C                   enddo                                                  *in33 = '1'
0203002111050291  *
0204002203140296 C                   If        svssn <> 0
0205002204080291  *
0206002204080296 C                   If        svtrm = 0 or svtrm > today8
0207002203140291  *
0208002203140291 C                   exsr      chkmbr
0209002203140291  *
0210002203140291 C                   exsr      lokdep
0211002203140291  *
0212002203140297 C                   endif                                                  *in33 = '1'
0213002204080297 C                   endif                                                  *in33 = '1'
0214002203140297 C                   endif                                                  *in32 = '0'
0215002111050297 C                   endif                                                  *in32 = '0'
0216002203040291  *
0217002203040297 C                   endif                                                  *in32 = '0'
0218002203040291  *
0219002204070297 C                   endif                                                  *in31 = '1'
0220002203040291  *
0221002204070291  *
0222002204070297 C                   endif
0223002204070291  *
0224002204070297 C                   endif
0225000204020107  ********************************************************************************
0226000204020107  *
0227002108250107  *     CHKMBR - Check for Member record
0228000204020107  *
0229000204020107  ********************************************************************************
023000210825     C     chkmbr        begsr
0231002005280107  *
0232002204070107  *  Set Elig Pull Key values
023300220407     C                   eval      wkseq# = 0
0234002108270291  *        See if record already exists
0235002204080297 C     elgky         chain     eligpuxp                           46
0236002204080296 C                   If        *in46 = '1'
023700210831      *          If not - create member record
023800211104     C                   exsr      crtmbr
023900210831      *
0240002108310291  *          Retrieve just created member record
0241002204080297 C     elgky         chain     eligpuxp                           47
0242002204080296 C                   If        *in47 = '1'
0243002109010291  *             WHAT????
024400220408     C                   eval      mmi = mmi
024500210901     C                   endif
024600210901      *
024700210901     C                   endif
024800210901      *          Add coverge data to mbr rec
024900220408     C                   exsr      addcvg
0250000907010107  *
025100090701     C                   endsr
0252002108250107  ********************************************************************************
0253002108250107  *
0254002108250107  *     CRTMBR - Create Member rec - load demographics
0255002108250107  *
0256002108250107  ********************************************************************************
025700210825     C     crtmbr        begsr
0258002204070291  *        Get member record
0259002204070297 C     svssn         chain     member                             32
0260002204070296 C                   If        *in32 = '0'
0261002108310107  *
026200220407     C                   clear                   eligpuxr
026300220407     C                   eval      epseq# = 0
026400220407     C                   eval      epaseq = ' 0'
026500220408     C                   eval      eprel = 'EMPLOYEE  '
026600220407     C                   movel     'ACTIVE'      epsts
0267002111080107  *
026800211108      *      Mbr demo data
026900220407     C                   eval      eptrst = mbtrst
027000220407     C                   eval      epsub# = mbsub#
027100220407     C                   eval      epacct = mbacct
027200220407     C                   eval      epmssn = mbssno
027300220407     C                   eval      epissn = mbssno
027400220407     C                   eval      epname = %TRIM(MLNAME) + ', ' +
027500220407     C                             %TRIM(MFNAME) + ' ' + MMI
027600220407     C                   eval      epsex = sex
027700220407   X* *
027800220407     C                   movel     birth         wkdate
027900220407     C                   move      wkdate        usadt
028000220407     C                   move      usadt         epdob
028100220407   X* *
028200220407     C                   movel     'NO'          epsmk
0283002204070297 C     smkky         chain     smoke                              37
0284002204070296 C                   If        *in37 = '0' and skrateto = 0
028500220407     C                   movel     'YES'         epsmk
028600220407     C                   endif
0287002204070107  *
028800220407     C                   movel     addr1         epadd1
028900220407     C                   movel     addr2         epadd2
029000220408     C                   movel     city          epcty
029100220407     C                   movel     state         epst
029200220407     C                   movel     zip           epzip
029300220407     C                   movel     area          epac
029400220407     C                   movel     phone         epphn
029500220407   X* *
029600220407     C                   movel     empdt         wkdate
029700220407     C                   move      wkdate        usadt
029800220407     C                   move      usadt         epdoh
029900220407   X* *
030000220408     C                   if        salary = 0
030100220408     C                   eval      epsal = '        0'
030200220408     C                   else
030300220408     C                   eval      epsal = %EDITC(SALARY:'C')
030400220408     C                   endif
030500220211      *
030600220407     C                   write     eligpuxr
0307002108260107  *
030800220408     C                   endif
0309002204080107  *
031000220408     C                   endsr
031100220211      *
0312002108260107  ********************************************************************************
0313002108260107  *
0314002204080107  *     ADDCVG  - Add coverage data to member record
0315002108260107  *               Already have REN mbr rec, mcov + plnmst records
0316002108260107  *
0317002108260107  ********************************************************************************
031800220408     C     addcvg        begsr
0319002108260107  *
0320002204070296 C                   If        action = 'D'
0321002204070296 C                   If        epdpln <> '    '
032200220407      *          WHAT!!
0323002204070296 C                   eval      epdpln = epdpln
0324002204070296 C                   else
032500210826      *         Process Dental Coverage
032600220407     C                   movel     plplan        epdpln
032700220407      *
032800220408     C                   EVAL      epdter = *blanks
0329002204080296 C                   If        epseq# = 0
033000220408      *          Populate cov level and group# for mbr only
033100220407     C                   SELECT
033200220408     C                   WHEN      scovtp = 'TDB'
033300220407     C                   EVAL      epdter = 'EMPLOYEE+1'
033400220408     C                   WHEN      scovtp = 'TED'
033500220407     C                   EVAL      epdter = 'EMPLOYEE+1 DEP'
033600220408     C                   WHEN      scovtp = 'TFA'
033700220407     C                   EVAL      epdter = 'EMPLOYEE+FAMILY'
033800220408     C                   WHEN      scovtp = 'TFM'
033900220407     C                   EVAL      epdter = 'EMPL+FAMILY MED SUPP'
034000220408     C                   WHEN      scovtp = 'THM'
034100220407     C                   EVAL      epdter = 'EMPL+SPOUSE MED SUPP'
034200220408     C                   WHEN      scovtp = 'THW'
034300220407     C                   EVAL      epdter = 'EMPL+SPOUSE'
034400220408     C                   WHEN      scovtp = 'TIN'
034500220408     C                   EVAL      epdter = 'EMPLOYEE ONLY'
034600220408     C                   WHEN      scovtp = 'TMF'
034700220408     C                   EVAL      epdter = 'EMPL+FAMILY MEDICARE'
034800220408     C                   WHEN      scovtp = 'TMH'
034900220407     C                   EVAL      epdter = 'EMPL+SPOUSE MEDICARE'
035000220408     C                   WHEN      scovtp = 'TMI'
035100220407     C                   EVAL      epdter = 'EMPLOYEE MEDICARE'
035200220408     C                   WHEN      scovtp = 'TMM'
035300220407     C                   EVAL      epdter = 'EMPL+FAMILY MED SUPP'
035400220408     C                   WHEN      scovtp = 'TMP'
035500220407     C                   EVAL      epdter = 'EMPL+CHILD MEDICARE'
035600220408     C                   WHEN      scovtp = 'TM2'
035700220407     C                   EVAL      epdter = 'EMPL+CHILD MED SUPP'
035800220408     C                   WHEN      scovtp = 'TPC'
035900220407     C                   EVAL      epdter = 'EMPLOYEE+CHILD'
036000220408     C                   WHEN      scovtp = 'TP2'
036100220407     C                   EVAL      epdter = 'EMPLOYEE+CHILDREN'
036200220408     C                   WHEN      scovtp = 'T2P'
036300220407     C                   EVAL      epdter = 'EMPLOYEE+1'
036400220407     C                   OTHER
036500220407     C                   EVAL      epdter = '*UNKNOWN*'
036600220407     C                   ENDSL
036700220408   X* *
036800220408     C                   movel     group#        epdgrp
036900220408   X* *
037000220408     C                   movel     sveff         wkdate
037100220408     C                   move      wkdate        usadt
037200220408     C                   move      usadt         epdeff
037300220407      *
037400220408     C                   else
037500220408   X* *
037600220408     C                   movel     svdeff        wkdate
037700220408     C                   move      wkdate        usadt
037800220408     C                   move      usadt         epdeff
037900220408      *
038000220408     C                   endif
038100220408      *
038200220407     C                   movel     pdescr        epddsc
038300220408      *
038400220407     C                   endif
038500220407      *
038600220407     C                   else
0387002204080107  *
0388002204080296 C                   If        action = 'V'
0389002204080296 C                   If        epvpln <> '    '
039000220408      *          WHAT!!
0391002204080296 C                   eval      epvpln = epvpln
0392002204080296 C                   else
039300220408      *         Process Dental Coverage
039400220408     C                   movel     plplan        epvpln
039500220408      *
039600220408     C                   EVAL      epvter = *blanks
0397002204080296 C                   If        epseq# = 0
039800220408      *          Populate cov level and group# for mbr only
039900220408     C                   SELECT
040000220408     C                   WHEN      scovtp = 'TDB'
040100220408     C                   EVAL      epvter = 'EMPLOYEE+1'
040200220408     C                   WHEN      scovtp = 'TED'
040300220408     C                   EVAL      epvter = 'EMPLOYEE+1 DEP'
040400220408     C                   WHEN      scovtp = 'TFA'
040500220408     C                   EVAL      epvter = 'EMPLOYEE+FAMILY'
040600220408     C                   WHEN      scovtp = 'TFM'
040700220408     C                   EVAL      epvter = 'EMPL+FAMILY MED SUPP'
040800220408     C                   WHEN      scovtp = 'THM'
040900220408     C                   EVAL      epvter = 'EMPL+SPOUSE MED SUPP'
041000220408     C                   WHEN      scovtp = 'THW'
041100220408     C                   EVAL      epvter = 'EMPL+SPOUSE'
041200220408     C                   WHEN      scovtp = 'TIN'
041300220408     C                   EVAL      epvter = 'EMPLOYEE ONLY'
041400220408     C                   WHEN      scovtp = 'TMF'
041500220408     C                   EVAL      epvter = 'EMPL+FAMILY MEDICARE'
041600220408     C                   WHEN      scovtp = 'TMH'
041700220408     C                   EVAL      epvter = 'EMPL+SPOUSE MEDICARE'
041800220408     C                   WHEN      scovtp = 'TMI'
041900220408     C                   EVAL      epvter = 'EMPLOYEE MEDICARE'
042000220408     C                   WHEN      scovtp = 'TMM'
042100220408     C                   EVAL      epvter = 'EMPL+FAMILY MED SUPP'
042200220408     C                   WHEN      scovtp = 'TMP'
042300220408     C                   EVAL      epvter = 'EMPL+CHILD MEDICARE'
042400220408     C                   WHEN      scovtp = 'TM2'
042500220408     C                   EVAL      epvter = 'EMPL+CHILD MED SUPP'
042600220408     C                   WHEN      scovtp = 'TPC'
042700220408     C                   EVAL      epvter = 'EMPLOYEE+CHILD'
042800220408     C                   WHEN      scovtp = 'TP2'
042900220408     C                   EVAL      epvter = 'EMPLOYEE+CHILDREN'
043000220408     C                   WHEN      scovtp = 'T2P'
043100220408     C                   EVAL      epvter = 'EMPLOYEE+1'
043200220408     C                   OTHER
043300220408     C                   EVAL      epvter = '*UNKNOWN*'
043400220408     C                   ENDSL
043500220408   X* *
043600220408     C                   movel     group#        epvgrp
043700220408   X* *
043800220408     C                   movel     sveff         wkdate
043900220408     C                   move      wkdate        usadt
044000220408     C                   move      usadt         epveff
044100220408      *
044200220408     C                   else
044300220408   X* *
044400220408     C                   movel     svdeff        wkdate
044500220408     C                   move      wkdate        usadt
044600220408     C                   move      usadt         epveff
044700220408      *
044800220408     C                   endif
044900220408   X* *
045000220408     C                   movel     pdescr        epvdsc
045100220408      *
045200220408     C                   endif
045300220408      *
045400220408     C                   endif
0455002204080107  *
045600220408     C                   endif
0457002108270107  *
045800220408     C                   update    eligpuxr
0459002204080107  *
046000210826     C                   endsr
046100210826      *
0462002108270107  ********************************************************************************
0463002108270107  *
0464002108270107  *     LOKDEP - Look for Deps with same plan
0465002108270107  *
0466002108270107  ********************************************************************************
046700210827     C     lokdep        begsr
0468002108270107  *
0469002108270291  *        Look for dependents of member
0470002203140297 C                   eval      svdeff = 99999999
0471002203140297 C                   eval      svdtrm = 00000000
0472002203140297 C                   eval      svseq# = 0
0473002203140297 C     dcvky         setll     dcov22                             33
0474002108270296 C                   dou       *in33 = '1'
0475002203140297 C     dcvky         reade     dcov22                                 33
0476002108270296 C                   If        *in33 = '0' and pltrst = dvtrst and
0477002108270296 C                             plsub# = dvsub# and plplan = dvplan
0478002108270291  *
0479002108270291  *
0480002108270296 C                   If        ccandt = denrdt
0481002108270297 C                   iter                                                   ccandt = 0
0482002108270297 C                   endif                                                  ccandt = 0
0483002108270291  *
0484002203140296 C                   If        svseq# <> dseq#
0485002203140291  *
0486002203140296 C                   If        svseq# <> 0
0487002204080296 C                   If        svdtrm = 0 or svtrm > today8
0488002203140291 C                   exsr      chkdep
0489002203140297 C                   endif                                                  *in32 = '0'
0490002204080297 C                   endif                                                  *in32 = '0'
0491002203140291  *
0492002203140291  *        Reset saved values
0493002203140297 C                   eval      svdeff = 99999999
0494002203140297 C                   eval      svdtrm = 00000000
0495002203140297 C                   eval      svseq# = dseq#
0496002203140291  *
0497002203140296 C                   If        ccandt > svdtrm or ccandt = 0
0498002203140297 C                   eval      svdtrm = ccandt
0499002203140297 C                   endif                                                  *in32 = '0'
0500002203140291  *
0501002203140296 C                   If        denrdt < svdeff
0502002203140297 C                   eval      svdeff = denrdt
0503002203140297 C                   endif                                                  *in32 = '0'
0504002108270291  *
0505002108270297 C                   endif                                                  ccandt = 0
0506002108270291  *
0507002108270297 C                   endif                                                  *in33 = '0'
0508002108270291  *
0509002108270297 C                   enddo                                                  *in33 = '1'
0510002203140291  *
0511002203140296 C                   If        svseq# <> 0
0512002204080296 C                   If        svdtrm = 0 or svtrm > today8
0513002203140291 C                   exsr      chkdep
0514002203140297 C                   endif                                                  *in32 = '0'
0515002204080297 C                   endif                                                  *in32 = '0'
0516002108270107  *
051700210827     C                   endsr
051800210827      *
0519002108270107  ********************************************************************************
0520002108270107  *
0521002108270107  *     CHKDEP - Check for Dependent record
0522002108270107  *
0523002108270107  ********************************************************************************
052400210827     C     chkdep        begsr
0525002108270107  *
0526002204080107  *  Set Elig Pull Key values
052700220408     C                   eval      wkseq# = svseq#
0528002204080291  *        See if record already exists
0529002204080297 C     elgky         chain     eligpuxp                           41
0530002204080296 C                   If        *in41 = '1'
053100210827      *          If not - create member record
053200210827     C                   exsr      crtdep
053300210827      *
0534002108270291  *          Retrieve just created member record
0535002204080297 C     elgky         chain     eligpuxp                           62
0536002108270296 C                   If        *in62 = '1'
0537002108270291  *             WHAT????
053800220408     C                   eval      mmi = mmi
053900210827     C                   endif
054000210827      *
054100210827     C                   endif
054200210827      *          Add coverge data to mbr rec
054300220408     C                   exsr      addcvg
0544002108270107  *
054500210827     C                   endsr
0546002108270107  ********************************************************************************
0547002108270107  *
0548002108270107  *     CRTDEP - Create Dep rec - load demographics
0549002108270107  *
0550002108270107  ********************************************************************************
055100210827     C     crtdep        begsr
0552002108270107  *
0553002204080291  *        get Dependent rec
0554002204080297 C     depky         chain     depndc                             61
0555002204080296 C                   If        *in61 = '0'
055600220408      *
055700220408     C                   eval      epseq# = svseq#
055800220408     C                   eval      epaseq = %EDITC(svseq#:'C')
055900220408     C                   eval      eprel = *blanks
056000220408     C                   movel     *blanks       epsts
056100220408     C                   movel     *blanks       epdoh
056200220408     C                   movel     *blanks       epsal
0563002204080107  *
056400220408      *      Dep demo data
056500220408     C                   eval      epissn = depss#
056600220408     C                   eval      epname = %TRIM(DLNAME) + ', ' +
056700220408     C                             %TRIM(DFNAME) + ' ' + DMI
056800220408     C                   eval      epsex = dsex
056900220408   X* *
057000220408     C                   movel     dbirth        wkdate
057100220408     C                   move      wkdate        usadt
057200220408     C                   move      usadt         epdob
057300220408   X* *
057400220408     C                   movel     'NO'          epsmk
0575002204080297 C     smkky         chain     smoke                              37
0576002204080296 C                   If        *in37 = '0' and skrateto = 0
057700220408     C                   movel     'YES'         epsmk
057800220408     C                   endif
0579002204080107  *
058000220408     C                   SELECT
058100220408     C                   WHEN      DRELCD = 'RSO'
058200220408     C                   EVAL      eprel = 'CHILD'
058300220408     C                   WHEN      DRELCD = 'RDA'
058400220408     C                   EVAL      eprel = 'CHILD'
058500220408     C                   WHEN      DRELCD = 'RHU'
058600220408     C                   EVAL      eprel = 'SPOUSE'
058700220408     C                   WHEN      DRELCD = 'RWI'
058800220408     C                   EVAL      eprel = 'SPOUSE'
058900220408     C                   WHEN      DRELCD = 'ROO'
059000220408     C                   EVAL      eprel = 'OTHER'
059100220408     C                   WHEN      DRELCD = 'RPA'
059200220408     C                   EVAL      eprel = 'DSPOUSE'
059300220408     C                   ENDSL
059400220408      *      Blank out Coverage data
059500220408     C                   eval      epdpln = *blanks
059600220408     C                   eval      epdter = *blanks
059700220408     C                   eval      epddsc = *blanks
059800220408     C                   eval      epdeff = *blanks
059900220408     C                   eval      epdgrp = *blanks
060000220408      *
060100220408     C                   eval      epvpln = *blanks
060200220408     C                   eval      epvter = *blanks
060300220408     C                   eval      epvdsc = *blanks
060400220408     C                   eval      epveff = *blanks
060500220408     C                   eval      epvgrp = *blanks
060600220408      *
060700220408     C                   write     eligpuxr
0608002108270107  *
060900220408     C                   endif
0610002204080107  *
061100220408     C                   endsr
061200210827      *
0613002204070107  ********************************************************************************
0614002204070107  *
0615002204070107  *     Initialization SR
0616002204070107  *
0617002204070107  ********************************************************************************
061800220407     C     *INZSR        begsr
0619002204070291  *   Preprocessing
0620002204070297 C                   movel     UDATE         cutoff
0621002204070297 C                   movel     cutoff        today8
0622002204070297 C                   movel     cutoff        todaa
0623002204070297 C                   movel     cutoff        todad
0624002204070297 C                   z-add     99999999      date9
0625002204070291  * Determine Term date cutoff to start - 90 days prior to term dt
0626002204070297 C     cutoff        subdur    90:*D         cutofx
0627002204070297 C                   movel     cutofx        cutofn
0628002204070291  * Determine Term date cutoff to end - 60 days after term dt
0629002204070297 C     cutoff        adddur    60:*D         cutofy
0630002204070297 C                   movel     cutofy        cutofa
063100220407      *
063200220407     C                   endsr
