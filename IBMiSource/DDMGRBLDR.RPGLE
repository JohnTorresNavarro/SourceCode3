0001002203230002  *****************************************************************************
000200220323      * DDMGRBLDR  Amwins Connect Administrators                                  *
000300220323      *            WRITTEN BY - R.L.J.                                            *
000400220323      *            DATE - 03/2022                                                 *
000500220323      *  DESCRIPTION - Bld Delta Dental PA Mnthly Grp data work file              *
000600220323      *
0007002203230002  *****************************************************************************
0008002203230015  *  Change Log:                                                              *
000900220323      *  xxx mm/dd/yyyy
001000220323      *                                                                *
0011002203230018 F******************************************************************
0012002203210020 Fdelwrkl   IP   E           K DISK
0013002203210020 Fmember    IF   E           K DISK
0014002203210020 Fplnmst    IF   E           K DISK
0015002203210020 Fddelgsxl  IF   E           K DISK
0016001504080020 Faccmst    IF   E           K DISK
0017002003200020 Fac2mstl2  IF   E           K DISK
0018002203210020 Finvele    IF   E           K DISK
0019002204210020 Finvdet    IF   E           K DISK
0020002204210020 Fagency    IF   E           K DISK
0021002205030020 Fcr130hso  IF   E           K DISK
0022002203220020 Fgrat26    IF   E           K DISK
0023002204130020 Fgrat24    IF   E           K DISK    RENAME(GRATER:GRAT24R)
0024002204130020 F                                     PREFIX(X)
0025002204060020 Fddmgrpwp  O    E             DISK
002600220322      *
002700220322     D                 DS
002800220322     D  addrar         S              1A   DIM(30)
002900220322     D  addrarx        S              1A   DIM(30)
003000220322     D  namear         S              1A   DIM(40)
003100220322     D  namearx        S              1A   DIM(40)
003200220322    * *
003300200317      *
0034001902010250 D                 DS
0035002203210251 D  wrkkey                 1     14
0036002203210251 D    dwtrst               1      3  0
0037002203210251 D    dwsub#               4      6  0
0038002203210251 D    dwacct               7     10  0
0039002203210251 D    dwplan              11     14
004000220505      *
0041002205050250 D                 DS
0042002203210251 D  svwkey                 1     14
0043002205050251 D    svtrst               1      3  0
0044002205050251 D    svsub#               4      6  0
0045002205050251 D    svacct               7     10  0
0046002205050251 D    svplan              11     14
004700220321      *
0048002203210250 D                 DS
0049002203210251 D  dwgrp#                 1     15
0050002203210251 D    grp14                1      4
0051002203210251 D    grp15                1      5
0052002203210251 D    grp18                1      8
0053002203210251 D    grp110               1     10
0054002203210251 D    grp58                5      8
0055002203210251 D    grp610               6     10
0056002203210251 D    grp10               10     10
005700220321      *
0058002203210250 D                 DS
0059002203210251 D  azip                   1      9  0
0060002203210251 D    azip5                1      5
0061002203210251 D    azip4                6      9
006200220321      *
0063002203210250 D                 DS
0064002203210251 D  a2tax_id#              1     10  0
0065002203210251 D    tax2                 2      3
0066002203210251 D    tax7                 4     10
0067002203210029  *
0068002003170250 D                 DS
0069002003170251 D  svaphn                 1     10
0070002003170251 D    aarea                1      3  0
0071002003170251 D    aphone               4     10  0
007200200317      *
0073002204210250 D                 DS
0074002204210251 D  invdat                 1      8  0
0075002204210251 D   invddd                7      8  0
007600220421      *
0077002003170250 D                 DS
0078002003200251 D  gdate                  1      8
0079002003200251 D   gdyy                  1      4
0080002003200251 D   gdmm                  5      6
0081002003200251 D   gddd                  7      8
008200200320      *
0083002003200250 D                 DS
0084002003200251 D  ddate                  1     10
0085002003200251 D   ddyy                  1      4
0086002003200251 D   ddd1                  5      5    INZ('-')
0087002003200251 D   ddmm                  6      7
0088002003200251 D   ddd2                  8      8    INZ('-')
0089002003200251 D   dddd                  9     10
009000200320      *
0091002003200250 D                 DS
0092002205030251 D  cr13y          S              1
0093002205030251 D  gxkey          S             10
0094002203210251 D  in20           S              2    INZ('20')
0095002205030251 D  crcd           S              3
0096002203210251 D  invamt         S              9  2
0097002203220251 D  name40         S             40
0098002203220251 D  name40x        S             40
0099002203220251 D  x              S              2  0
0100002203220251 D  y              S              2  0
0101002203220251 D  z              S              2  0
0102002205020251 D  slscnt         S              2  0
0103002205060251 D  trmdat         S              8  0
0104002205020251 D  slscan         S              8  0
0105002203220251 D  ISOdate        S               D
0106002203220251 D  ISOnum         S              8  0
0107002203220251 D  ISOtda         S              8  0
0108002205030251 D  crdat          S              8  0
0109002205030251 D  crdax          S               D
0110002205060251 D  wrkdt          S               D
0111002205060251 D  trmcut         S              8  0
0112002206010251 D  trmacut        S              8  0
0113002206010251 D  svatrm         S              8  0
0114002205060251 D  trmcux         S               D
0115002205030251 D  invdax         S               D
0116002204140251 D  date9          S              8  0 inz(99999999)
0117002203220251 D  MDYdate        S               D   DATFMT(*MDY)
0118002204200251 D  smanky         S                   LIKE(smancd)
011900220322      *
012000200317      *
012100200317     C     ackey         klist
012200220321     C                   kfld                    dwtrst
012300220321     C                   kfld                    dwsub#
012400220321     C                   kfld                    dwacct
012500150408      *
012600150408     C     plkey         klist
012700220321     C                   kfld                    dwtrst
012800220321     C                   kfld                    dwsub#
012900220321     C                   kfld                    dwplan
013000220322      *
013100220322     C     grkey         klist
013200220322     C                   kfld                    dwtrst
013300220322     C                   kfld                    dwsub#
013400220322     C                   kfld                    dwplan
013500220322     C                   kfld                    dwcovt
013600220322     C                   kfld                    grdat             8 0
013700220322      *
013800220321     C     invkey        klist
013900220321     C                   kfld                    dwtrst
014000220321     C                   kfld                    dwsub#
014100220321     C                   kfld                    dwacct
014200220421     C                   kfld                    invdat
014300220420      *
014400220503     C     crkey         klist
014500220503     C                   kfld                    crdat
014600220503     C                   kfld                    crcd
014700220503     C                   kfld                    dwtrst
014800220420     C                   kfld                    dwsub#
014900220420     C                   kfld                    dwacct
015000020503      ******************************************************************************
015100020517      *      MainLine
015200220321      *          Look for new Plan
015300220321     C                   if        dwacct = 0
015400220321     C     dwssn         chain     member                             21
015500220321     C                   if        *in21 = '0'
015600220321     C                   eval      dwacct = mbacct
015700220321     C                   endif
015800220321     C                   endif
015900220321     C                   if        wrkkey <> svwkey
016000220321     C                   eval      svwkey = wrkkey
016100220321      *       Create new Group record
016200220321     C                   clear                   ddmgrpwr
0163002203210297 C                   movel     dwtrst        dytrst
0164002203210297 C                   movel     dwsub#        dysub#
0165002203210297 C                   movel     dwacct        dyacct
0166002203210297 C                   eval      dyplan = dwplan
016700220413      *     Debug shit
016800220505     C****               if        dyplan = 'DEJZ'
016900220505     C                   if        dyplan = 'DAGX' and dwacct = 155
017000220503     C**                 if        dwacct = 110
0171002204130297 C                   eval      dyplan = dyplan
0172002204130297 C                   endif
017300220413      *
017400220325      *  Plan Info
017500220321     C     plkey         chain     plnmst
0176002203220107  *
017700220322     C                   movel(P)  pdescr        name40
017800220322     C                   exsr      getname
017900220322     C                   movel(P)  name40x       dypdsc
0180002203220297  *
0181002203210297 C                   eval      dyemr# = dytrst + '-' + dysub# +
0182002203210297 C                             '-' + dyacct
018300220321      *       Chk group# for 10 digits
018400220321     C                   if        grp10 = ' '
018500220321     C                   movel(P)  grp18         gxkey
018600220321     C     gxkey         chain     ddelgsxl                           52
018700220321     C                   if        *in52 = '0'
018800220321     C                   movel(P)  dx10gs        dwgrp#
018900220321     C                   else
019000220321     C                   eval      dwgrp# = dwgrp#
019100220321     C                   endif
019200220321     C                   endif
019300220321      *
019400220321     C                   movel(P)  grp15         dygrp#
019500220321     C                   movel(P)  grp610        dydiv#
019600220322      *  Rate Info
0197002203220297 C                   eval      grdat = ISOtda
019800220322     C     grkey         setll     grat26                             29
019900220322     C                   read      grat26                               2929
020000220322      *
020100220322     C                   if        *in29 = '1'
0202002203220297 C                   eval      grdat = 99999999
020300220322     C     grkey         setll     grat26                             29
020400220322     C                   read      grat26                               2929
020500220322     C                   endif
020600220322      *
020700220322     C                   if        *in29 = '0'
0208002204140297 C******             movel     frmdat        gdate
0209002204140297 C**                 exsr      datrtn
0210002204140297 C******             movel     ddate         dyceff
021100220322      *
021200220322     C                   move      todat         ISOdate
021300220322     C                   adddur    1:*D          ISOdate
021400220322     C                   move      ISOdate       ISOnum
021500220322     C                   move      ISOnum        gdate
0216002203220297 C                   exsr      datrtn
0217002203220297 C                   movel     ddate         dyrenew
021800220322      *
021900220322     C                   endif
0220002203221304  *
022100220322      *  Account Info
022200220321     C     ackey         chain     accmst                             23
022300220321     C                   if        *in23 = '0'
0224002203220297 C******             movel     acnam1        dyanam
0225002203220107  *
022600220322     C                   movel(P)  acnam1        name40
022700220322     C                   exsr      getname
022800220322     C                   movel(P)  name40x       dyanam
0229002203220107  *
0230002203210297 C                   movel     svaphn        dyaphn
0231002203220107  *
023200220322     C                   movel(P)  aaddr1        name40
023300220322     C                   exsr      getname
023400220322     C                   movel(P)  name40x       dyaad1
0235002203220107  *
0236002203210297 C                   movel     aaddr2        dyaad2
0237002203210297 C                   movel     acity         dyacty
0238002203210297 C                   movel     astate        dyast
0239002203210297 C                   movel     azip5         dyazip5
0240002203210297 C                   movel     azip4         dyazip4
0241002203210297 C                   movel     contac        dycntc
024200220321      *
0243002203210297 C                   if        siccod <> 0
0244002203210297 C                   movel     siccod        dysic
0245002203210297 C                   endif
024600200320      *
0247002204140297 C                   movel     gbsbdt        gdate
0248002003200297 C                   exsr      datrtn
0249002203210297 C                   movel     ddate         dyoeff
025000220414      *
0251002206010297 C                   eval      svatrm = 0
025200220601      *
0253002206010297 C                   if        atrmdt <> 0
025400220601     C                   move      atrmdt        svatrm
025500220601     C                   move      atrmdt        wrkdt
0256002205060297 C                   subdur    1:*d          wrkdt
0257002205060297 C                   movel     wrkdt         ISOnum
0258002205060297 C                   movel     ISOnum        gdate
0259002204140297 C                   exsr      datrtn
0260002204140297 C                   movel     ddate         dyetrm
0261002204140297 C                   endif
026200200320      *
0263001504080297 C                   endif
026400220414      *
026500220414     C     plkey         chain     grat24                             28
026600220414     C                   if        *in28 = '0'
0267002204140297 C                   movel     xfrmdat       gdate
0268002204140297 C                   exsr      datrtn
0269002204140297 C                   movel     ddate         dyceff
0270002204140297 C                   endif
027100220321      *
027200220321     C     ackey         chain     ac2mstl2                           24
027300220321     C                   if        *in24 = '0' and a2tax_id# <> 0
0274002203210297 C                   eval      dytin = tax2 + '-' + tax7
0275002003200297 C                   endif
0276002204140297 C                   eval      dyblst = '4'
0277002204140107  *       If Acct is NOT termed
027800220414     C                   if        dyetrm = *blanks
027900220322      * Invoice info - Calc Yrly premium
0280002204210297 C                   eval      dyyprm = 0
028100220421      *       Calc Yrly premium for Cobra Plans
0282002204210297 C                   if        plncat = 'PCD'
028300220421     C     invkey        setll     invdet                             35
028400220421     C                   dou       *in35 = '1'
028500220421     C     invkey        reade     invdet                                 35
0286002204140107  *
028700220421     C                   if        *in35 = '0' and idplan = dyplan and
028800220421     C                             idcob = 'C' and idcvdt = invdat and
028900220421     C                             (idrc = 'CCE' or idrc = 'VCE')
0290002204210297 C                   eval      dyyprm = dyyprm + idtram
0291002203210297 C                   endif
0292002204140107  *
0293002204210297 C                   if        invdat <> idcvdt
0294002204140297 C                   leave
0295002204140297 C                   endif
0296002204140107  *
0297002203210297 C                   enddo
0298002204140107  *
0299002204210297 C                   else
030000220421      *       Invoice info - Calc Yrly prem for non-Cobra plans
030100220421     C     invkey        setll     invele                             25
030200220421     C                   dou       *in25 = '1'
030300220421     C     invkey        reade     invele                                 25
0304002204210107  *
030500220421     C                   if        *in25 = '0' and ieplan = dyplan and
030600220421     C                             ierc = '20' and ievcdt = invdat
0307002204210297 C                   eval      dyyprm = dyyprm + ietramb
0308002204210297 C                   endif
0309002204210107  *
0310002204210297 C                   if        invdat <> ievcdt
0311002204210297 C                   leave
0312002204210297 C                   endif
0313002204210107  *
0314002204210297 C                   enddo
0315002204210107  *
0316002204140297 C                   endif
0317002204210107  *
0318002204210297 C                   eval      dyyprm = dyyprm * 12
0319002204210107  *
0320002204210297 C                   endif
032100220503    4 *  Find Broker data - CR130HSO and Agency
0322002205030297 C                   eval      cr13y = 'N'
0323002205030297 C                   eval      crdat = invdat
0324002205030297 C                   eval      crcd = 'DEA'
0325002205030297 C                   dou       cr13y = 'Y'
032600220503     C     crkey         setll     cr130hso                           26
032700220502     C                   dou       *in26 = '1'
032800220503     C     crkey         reade     cr130hso                             2626
032900220503     C                   if        *in26 = '0' and cplan = dyplan
0330002205030297 C                   eval      cr13y = 'Y'
0331002205030297 C                   leave
0332002205030297 C                   endif
033300220503     C                   enddo
033400220503    4 *
033500220503     C                   move      crdat         crdax
0336002205030297 C                   subdur    1:*M          crdax
033700220503     C                   move      crdax         crdat
0338002205030297 C                   if        cr13y = 'Y' or
0339002205030297 C                             (crcd = 'DEM' and crdat < 20050101)
0340002205030297 C                   leave
0341002205030297 C                   else
034200220503    4 *
0343002205030297 C                   if        crdat < 20050101 and crcd = 'DEA'
0344002205030297 C                   eval      crcd = 'DEM'
0345002205030297 C                   eval      crdat = invdat
034600220502     C                   endif
034700220503     C                   endif
034800220502     C                   enddo
034900220502    4 *
035000220503     C                   if        cr13y = 'Y'
035100220506    4 *
035200220506     C                   if        crdat < trmcut
035300220506     C                   move      crdat         ISOnum
035400220601     C                   move      crdat         svatrm
035500220506     C                   move      ISOnum        wrkdt
0356002205060297 C                   subdur    1:*d          wrkdt
035700220506     C******             move      wrkdt         dyetrm
0358002205060297 C                   movel     wrkdt         ISOnum
0359002205060297 C                   movel     ISOnum        gdate
0360002205060297 C                   exsr      datrtn
0361002205060297 C                   movel     ddate         dyetrm
036200220506     C                   endif
036300220421    4 *
036400220503     C     cagcod        chain     agency                             56
036500220421     C                   if        *in56 = '0'
036600220421    4 *
036700220421    4 *  Broker/Agency Info
0368002203220107  *
036900220421     C                   movel(P)  agnam1        name40
037000220322     C                   exsr      getname
037100220421     C                   movel(P)  name40x       dybkcn
0372002203220107  *
0373002204210297 C                   movel     agtxid        dybktn
0374002203220107  *
037500220421     C                   movel(P)  agadd1        name40
037600220322     C                   exsr      getname
037700220322     C                   movel(P)  name40x       dybkad
0378002203220107  *
037900220421     C                   movel(P)  agcity        name40
038000220322     C                   exsr      getname
038100220322     C                   movel(P)  name40x       dybkct
0382002203220107  *
0383002204210297 C                   movel     agstat        dybkst
0384002204210297 C                   movel     agzip5        dybkzp
0385002204210297 C                   movel     agtlx3        dybkph
0386002204210297 C                   move      agtlx7        dybkph
0387002204210297  *
0388002204210297 C                   endif
0389002204210297  *
0390002204210297 C                   endif
0391002204210297  *
039200220322    4 *  Master Broker Info
039300220421    4 *     Leaving Mast Broker info blank!
0394002003200297  *
039500220601     C                   if        svatrm = 0 or
039600220601     C                             trmacut < svatrm
0397002206010297  *
0398002204210297 C                   movel     'A'           dybkpt
0399002203210297 C                   write     ddmgrpwr
0400002003200297 C                   endif
040100220601      *
0402002206010297 C                   endif
040300220601      ****************************************************
040400200320      *
040500200320      *   DATRTN - Convert dates
040600200320      *
040700200320      ****************************************************
040800200320     C     datrtn        begsr
040900200320      *
041000200320     C                   eval      ddyy = gdyy
041100200320     C                   eval      ddmm = gdmm
041200200320     C                   eval      dddd = gddd
041300200320      *
041400200320     C                   endsr
0415002203220107  ********************************************************************************
0416002203220107  *
0417002203220107  *     GETNAME - Strip Name fields of unwanted chars
0418002203220107  *
0419002203220107  ********************************************************************************
042000220322     C     getname       begsr
0421002203220107  *
042200220322     C                   movel     *blanks       name40x
042300220322     C                   movel     *blanks       namearx
0424002203220107  *
042500220322     C                   movea     name40        namear
042600220322     C                   eval      z = 1
0427002203220107  *
042800220322    3C     1             DO        40            X
042900220322    4C                   IF        namear(X) <> ','
043000220322     C                   eval      namearx(z) = namear(x)
043100220322     C                   eval      z = z + 1
043200220322    4C                   else
043300220322     C                   eval      namearx(z) = ' '
043400220322     C                   eval      z = z + 1
043500220322    4C                   endif
043600220322    3C                   enddo
0437002203220291  *
043800220322     C                   movea     namearx       name40x
0439002203220111  *
044000220322     C                   endsr
044100220322      ****************************************************
044200220322      *              One time initialization
044300220322      ****************************************************
044400220322     C     *INZSR        BEGSR
0445002203221304  *         Calculate cutoff dates
044600220322     C                   move      UDATE         ISOdate
044700220322     C                   move      ISOdate       ISOnum
044800220421     C                   move      ISOnum        ISOtda
044900220322     C                   subdur    60:*D         ISOdate
045000220421      * Invoice info - Calc Yrly premium
0451002204210297 C                   move      ISOtda        invdax
0452002204210297 C                   subdur    1:*M          invdax
0453002204210297 C                   move      invdax        invdat
0454002204210297 C                   z-add     01            invddd
045500220506      * Calc Term Date Cutoff
0456002205060297 C                   move      ISOtda        trmcux
0457002205060297 C                   subdur    3:*M          trmcux
0458002205060297 C                   move      trmcux        trmcut
045900220601      * Calc Acct Term Date Cutoff
0460002206010297 C                   move      ISOtda        trmcux
0461002206010297 C                   subdur    3:*Y          trmcux
0462002206010297 C                   move      trmcux        trmacut
046300220322     C                   ENDSR
