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
0018002204200020 Fsmanrlt   IF   E           K DISK
0019002203210020 Finvele    IF   E           K DISK
0020002204210020 Finvdet    IF   E           K DISK
0021002204210020 Fagency    IF   E           K DISK
0022002204200020 Fcmctplan  IF   E           K DISK
0023002204200020 Fspragxr2  IF   E           K DISK
0024002203220020 Fgrat26    IF   E           K DISK
0025002204130020 Fgrat24    IF   E           K DISK    RENAME(GRATER:GRAT24R)
0026002204130020 F                                     PREFIX(X)
0027002204060020 Fddmgrpwp  O    E             DISK
002800220322      *
002900220322     D                 DS
003000220322     D  addrar         S              1A   DIM(30)
003100220322     D  addrarx        S              1A   DIM(30)
003200220322     D  namear         S              1A   DIM(40)
003300220322     D  namearx        S              1A   DIM(40)
003400220322    * *
003500200317      *
0036001902010250 D                 DS
0037002203210251 D  wrkkey                 1     14
0038002203210251 D    dwtrst               1      3  0
0039002203210251 D    dwsub#               4      6  0
0040002203210251 D    dwacct               7     10  0
0041002203210251 D    dwplan              11     14
004200220321      *
0043002203210250 D                 DS
0044002203210251 D  svwkey                 1     14
0045002203210251 D    svtrst               1      3  0
0046002203210251 D    svsub#               4      6  0
0047002203210251 D    svacct               7     10  0
0048002203210251 D    svplan              11     14
004900220321      *
0050002203210250 D                 DS
0051002203210251 D  dwgrp#                 1     15
0052002203210251 D    grp14                1      4
0053002203210251 D    grp15                1      5
0054002203210251 D    grp18                1      8
0055002203210251 D    grp110               1     10
0056002203210251 D    grp58                5      8
0057002203210251 D    grp610               6     10
0058002203210251 D    grp10               10     10
005900220321      *
0060002203210250 D                 DS
0061002203210251 D  azip                   1      9  0
0062002203210251 D    azip5                1      5
0063002203210251 D    azip4                6      9
006400220321      *
0065002203210250 D                 DS
0066002203210251 D  a2tax_id#              1     10  0
0067002203210251 D    tax2                 2      3
0068002203210251 D    tax7                 4     10
0069002203210029  *
0070002003170250 D                 DS
0071002003170251 D  svaphn                 1     10
0072002003170251 D    aarea                1      3  0
0073002003170251 D    aphone               4     10  0
007400200317      *
0075002204210250 D                 DS
0076002204210251 D  invdat                 1      8  0
0077002204210251 D   invddd                7      8  0
007800220421      *
0079002003170250 D                 DS
0080002003200251 D  gdate                  1      8
0081002003200251 D   gdyy                  1      4
0082002003200251 D   gdmm                  5      6
0083002003200251 D   gddd                  7      8
008400200320      *
0085002003200250 D                 DS
0086002003200251 D  ddate                  1     10
0087002003200251 D   ddyy                  1      4
0088002003200251 D   ddd1                  5      5    INZ('-')
0089002003200251 D   ddmm                  6      7
0090002003200251 D   ddd2                  8      8    INZ('-')
0091002003200251 D   dddd                  9     10
009200200320      *
0093002003200250 D                 DS
0094002203210251 D  gxkey          S             10
0095002203210251 D  in20           S              2    INZ('20')
0096002203210251 D  invamt         S              9  2
0097002203220251 D  name40         S             40
0098002203220251 D  name40x        S             40
0099002203220251 D  x              S              2  0
0100002203220251 D  y              S              2  0
0101002203220251 D  z              S              2  0
0102002205020251 D  slscnt         S              2  0
0103002205020251 D  slscan         S              8  0
0104002203220251 D  ISOdate        S               D
0105002203220251 D  ISOnum         S              8  0
0106002203220251 D  ISOtda         S              8  0
0107002204210251 D  invdax         S               D
0108002204140251 D  date9          S              8  0 inz(99999999)
0109002203220251 D  MDYdate        S               D   DATFMT(*MDY)
0110002204200251 D  smanky         S                   LIKE(smancd)
0111002205020251 D  svrel          S                   LIKE(cmrelid)
0112002205020251 D  svrelc         S                   LIKE(cmrelid)
011300220322      *
011400200317      *
011500200317     C     ackey         klist
011600220321     C                   kfld                    dwtrst
011700220321     C                   kfld                    dwsub#
011800220321     C                   kfld                    dwacct
011900150408      *
012000150408     C     plkey         klist
012100220321     C                   kfld                    dwtrst
012200220321     C                   kfld                    dwsub#
012300220321     C                   kfld                    dwplan
012400220322      *
012500220322     C     grkey         klist
012600220322     C                   kfld                    dwtrst
012700220322     C                   kfld                    dwsub#
012800220322     C                   kfld                    dwplan
012900220322     C                   kfld                    dwcovt
013000220322     C                   kfld                    grdat             8 0
013100220322      *
013200220321     C     invkey        klist
013300220321     C                   kfld                    dwtrst
013400220321     C                   kfld                    dwsub#
013500220321     C                   kfld                    dwacct
013600220421     C                   kfld                    invdat
013700220420      *
013800220420     C     cmckey        klist
013900220420     C                   kfld                    dwtrst
014000220420     C                   kfld                    dwsub#
014100220420     C                   kfld                    dwplan
014200220420     C                   kfld                    dwacct
014300020503      ******************************************************************************
014400020517      *      MainLine
014500220321      *          Look for new Plan
014600220321     C                   if        dwacct = 0
014700220321     C     dwssn         chain     member                             21
014800220321     C                   if        *in21 = '0'
014900220321     C                   eval      dwacct = mbacct
015000220321     C                   endif
015100220321     C                   endif
015200220321     C                   if        wrkkey <> svwkey
015300220321     C                   eval      svwkey = wrkkey
015400220321      *       Create new Group record
015500220321     C                   clear                   ddmgrpwr
0156002203210297 C                   movel     dwtrst        dytrst
0157002203210297 C                   movel     dwsub#        dysub#
0158002203210297 C                   movel     dwacct        dyacct
0159002203210297 C                   eval      dyplan = dwplan
016000220413      *     Debug shit
016100220503     C**                 if        dyplan = 'ZD04'
016200220503     C                   if        dyplan = 'DAGX' and dwacct = 155
016300220503     C**                 if        dwacct = 110
0164002204130297 C                   eval      dyplan = dyplan
0165002204130297 C                   endif
016600220413      *
016700220325      *  Plan Info
016800220321     C     plkey         chain     plnmst
0169002203220107  *
017000220322     C                   movel(P)  pdescr        name40
017100220322     C                   exsr      getname
017200220322     C                   movel(P)  name40x       dypdsc
0173002203220297  *
0174002203210297 C                   eval      dyemr# = dytrst + '-' + dysub# +
0175002203210297 C                             '-' + dyacct
017600220321      *       Chk group# for 10 digits
017700220321     C                   if        grp10 = ' '
017800220321     C                   movel(P)  grp18         gxkey
017900220321     C     gxkey         chain     ddelgsxl                           52
018000220321     C                   if        *in52 = '0'
018100220321     C                   movel(P)  dx10gs        dwgrp#
018200220321     C                   else
018300220321     C                   eval      dwgrp# = dwgrp#
018400220321     C                   endif
018500220321     C                   endif
018600220321      *
018700220321     C                   movel(P)  grp15         dygrp#
018800220321     C                   movel(P)  grp610        dydiv#
018900220322      *  Rate Info
0190002203220297 C                   eval      grdat = ISOtda
019100220322     C     grkey         setll     grat26                             29
019200220322     C                   read      grat26                               2929
019300220322      *
019400220322     C                   if        *in29 = '1'
0195002203220297 C                   eval      grdat = 99999999
019600220322     C     grkey         setll     grat26                             29
019700220322     C                   read      grat26                               2929
019800220322     C                   endif
019900220322      *
020000220322     C                   if        *in29 = '0'
0201002204140297 C******             movel     frmdat        gdate
0202002204140297 C**                 exsr      datrtn
0203002204140297 C******             movel     ddate         dyceff
020400220322      *
020500220322     C                   move      todat         ISOdate
020600220322     C                   adddur    1:*D          ISOdate
020700220322     C                   move      ISOdate       ISOnum
020800220322     C                   move      ISOnum        gdate
0209002203220297 C                   exsr      datrtn
0210002203220297 C                   movel     ddate         dyrenew
021100220322      *
021200220322     C                   endif
0213002203221304  *
021400220322      *  Account Info
021500220321     C     ackey         chain     accmst                             23
021600220321     C                   if        *in23 = '0'
0217002203220297 C******             movel     acnam1        dyanam
0218002203220107  *
021900220322     C                   movel(P)  acnam1        name40
022000220322     C                   exsr      getname
022100220322     C                   movel(P)  name40x       dyanam
0222002203220107  *
0223002203210297 C                   movel     svaphn        dyaphn
0224002203220107  *
022500220322     C                   movel(P)  aaddr1        name40
022600220322     C                   exsr      getname
022700220322     C                   movel(P)  name40x       dyaad1
0228002203220107  *
0229002203210297 C                   movel     aaddr2        dyaad2
0230002203210297 C                   movel     acity         dyacty
0231002203210297 C                   movel     astate        dyast
0232002203210297 C                   movel     azip5         dyazip5
0233002203210297 C                   movel     azip4         dyazip4
0234002203210297 C                   movel     contac        dycntc
023500220321      *
0236002203210297 C                   if        siccod <> 0
0237002203210297 C                   movel     siccod        dysic
0238002203210297 C                   endif
023900200320      *
0240002204140297 C                   movel     gbsbdt        gdate
0241002003200297 C                   exsr      datrtn
0242002203210297 C                   movel     ddate         dyoeff
024300220414      *
0244002204140297 C                   if        atrmdt <> 0
0245002204140297 C                   movel     atrmdt        gdate
0246002204140297 C                   exsr      datrtn
0247002204140297 C                   movel     ddate         dyetrm
0248002204140297 C                   endif
024900200320      *
0250001504080297 C                   endif
025100220414      *
025200220414     C     plkey         chain     grat24                             28
025300220414     C                   if        *in28 = '0'
0254002204140297 C                   movel     xfrmdat       gdate
0255002204140297 C                   exsr      datrtn
0256002204140297 C                   movel     ddate         dyceff
0257002204140297 C                   endif
025800220321      *
025900220321     C     ackey         chain     ac2mstl2                           24
026000220321     C                   if        *in24 = '0' and a2tax_id# <> 0
0261002203210297 C                   eval      dytin = tax2 + '-' + tax7
0262002003200297 C                   endif
0263002204140297 C                   eval      dyblst = '4'
0264002204140107  *       If Acct is NOT termed
026500220414     C                   if        dyetrm = *blanks
026600220322      * Invoice info - Calc Yrly premium
0267002204210297 C                   eval      dyyprm = 0
026800220421      *       Calc Yrly premium for Cobra Plans
0269002204210297 C                   if        plncat = 'PCD'
027000220421     C     invkey        setll     invdet                             35
027100220421     C                   dou       *in35 = '1'
027200220421     C     invkey        reade     invdet                                 35
0273002204140107  *
027400220421     C                   if        *in35 = '0' and idplan = dyplan and
027500220421     C                             idcob = 'C' and idcvdt = invdat and
027600220421     C                             (idrc = 'CCE' or idrc = 'VCE')
0277002204210297 C                   eval      dyyprm = dyyprm + idtram
0278002203210297 C                   endif
0279002204140107  *
0280002204210297 C                   if        invdat <> idcvdt
0281002204140297 C                   leave
0282002204140297 C                   endif
0283002204140107  *
0284002203210297 C                   enddo
0285002204140107  *
0286002204210297 C                   else
028700220421      *       Invoice info - Calc Yrly prem for non-Cobra plans
028800220421     C     invkey        setll     invele                             25
028900220421     C                   dou       *in25 = '1'
029000220421     C     invkey        reade     invele                                 25
0291002204210107  *
029200220421     C                   if        *in25 = '0' and ieplan = dyplan and
029300220421     C                             ierc = '20' and ievcdt = invdat
0294002204210297 C                   eval      dyyprm = dyyprm + ietramb
0295002204210297 C                   endif
0296002204210107  *
0297002204210297 C                   if        invdat <> ievcdt
0298002204210297 C                   leave
0299002204210297 C                   endif
0300002204210107  *
0301002204210297 C                   enddo
0302002204210107  *
0303002204140297 C                   endif
0304002204210107  *
0305002204210297 C                   eval      dyyprm = dyyprm * 12
0306002204210107  *
0307002204210297 C                   endif
030800220420    4 *  Comm Ctl Info
0309002205020297 C                   eval      slscnt = 0
0310002205020297 C                   eval      slscan = 0
0311002205020297 C                   eval      svrel = *blanks
0312002205020297 C                   eval      svrelc = *blanks
031300220502     C     cmckey        setll     cmctplan                           26
031400220502     C                   dou       *in26 = '1'
031500220502     C     cmckey        reade     cmctplan                             2626
031600220502     C                   if        *in26 = '0' and effdat < invdat and
031700220502     C                             (cmcan = 0 or cmcan > invdat)
0318002205020297 C                   eval      slscnt = slscnt + 1
0319002205020297 C                   eval      svrel = cmrelid
032000220502     C                   else
0321002205020297 C                   if        cmcan > slscan
0322002205020297 C                   eval      slscan = cmcan
0323002205020297 C                   eval      svrelc = cmrelid
032400220502     C                   endif
032500220502     C                   endif
032600220502     C                   enddo
032700220502    4 *
032800220502     C                   if        slscnt = 1
0329002205020297 C                   eval      cmrelid = svrel
033000220502     C                   endif
033100220502    4 *
033200220502     C                   if        slscnt = 0 and svrelc <> *blanks
0333002205020297 C                   eval      cmrelid = svrelc
033400220502     C                   endif
033500220502    4 *
033600220502     C                   if        slscnt > 1
0337002205020297 C                   exsr      fndsls
033800220502     C                   endif
033900220502    4 *         If cnt = 99 => did not find the right salesman - problem!
0340002205020297 C                   if        slscnt <> 99
034100220421    4 *
034200220421     C     cmrelid       chain     smanrlt                            36
034300220421     C                   if        *in36 = '0'
034400220421    4 *
034500220421     C     srasid        chain     spragxr2                           46
034600220421     C                   if        *in46 = '0'
034700220421    4 *
034800220421     C     sxagcy        chain     agency                             56
034900220421     C                   if        *in56 = '0'
035000220421    4 *
035100220421    4 *  Broker/Agency Info
0352002203220107  *
035300220421     C                   movel(P)  agnam1        name40
035400220322     C                   exsr      getname
035500220421     C                   movel(P)  name40x       dybkcn
0356002203220107  *
0357002204210297 C                   movel     agtxid        dybktn
0358002203220107  *
035900220421     C                   movel(P)  agadd1        name40
036000220322     C                   exsr      getname
036100220322     C                   movel(P)  name40x       dybkad
0362002203220107  *
036300220421     C                   movel(P)  agcity        name40
036400220322     C                   exsr      getname
036500220322     C                   movel(P)  name40x       dybkct
0366002203220107  *
0367002204210297 C                   movel     agstat        dybkst
0368002204210297 C                   movel     agzip5        dybkzp
0369002204210297 C                   movel     agtlx3        dybkph
0370002204210297 C                   move      agtlx7        dybkph
0371002204210297  *
0372002204210297 C                   endif
0373002204210297  *
0374002204210297 C                   endif
0375002204210297  *
0376002205020297 C                   endif
0377002205020297  *
0378002204210297 C                   endif
037900220322    4 *  Master Broker Info
038000220421    4 *     Leaving Mast Broker info blank!
0381002003200297  *
0382002204210297 C                   movel     'A'           dybkpt
0383002203210297 C                   write     ddmgrpwr
0384002003200297 C                   endif
038500220502      ****************************************************
038600220502      *
038700220502      *   FNDSLS - Find the correct salesman - matches BOR in Acct Mst
038800220502      *
038900200320      ****************************************************
039000220502     C     fndsls        begsr
039100220502    4 *  Comm Ctl Info
039200220502     C     cmckey        setll     cmctplan                           26
039300220502     C                   dou       *in26 = '1'
039400220502     C     cmckey        reade     cmctplan                             2626
039500220502     C                   if        *in26 = '0' and effdat < invdat and
039600220502     C                             (cmcan = 0 or cmcan > invdat)
039700220502    4C                   if        smancd = slsman
0398002205020297 C                   leavesr
039900220502     C                   endif
040000220502     C                   endif
040100220502     C                   enddo
040200220502    4 *   No match on ACCMST smancd - lool for % over 50
040300220502     C     cmckey        setll     cmctplan                           26
040400220502     C                   dou       *in26 = '1'
040500220502     C     cmckey        reade     cmctplan                             2626
040600220502     C                   if        *in26 = '0' and effdat < invdat and
040700220502     C                             (cmcan = 0 or cmcan > invdat)
040800220502    4C                   if        cccmsp >= 50
0409002205020297 C                   leavesr
041000220502     C                   endif
041100220502     C                   endif
041200220502     C                   enddo
041300220502    4 *
041400220502     C                   eval      slscnt = 99
041500220502     C                   endsr
041600220502      ****************************************************
041700200320      *
041800200320      *   DATRTN - Convert dates
041900200320      *
042000200320      ****************************************************
042100200320     C     datrtn        begsr
042200200320      *
042300200320     C                   eval      ddyy = gdyy
042400200320     C                   eval      ddmm = gdmm
042500200320     C                   eval      dddd = gddd
042600200320      *
042700200320     C                   endsr
0428002203220107  ********************************************************************************
0429002203220107  *
0430002203220107  *     GETNAME - Strip Name fields of unwanted chars
0431002203220107  *
0432002203220107  ********************************************************************************
043300220322     C     getname       begsr
0434002203220107  *
043500220322     C                   movel     *blanks       name40x
043600220322     C                   movel     *blanks       namearx
0437002203220107  *
043800220322     C                   movea     name40        namear
043900220322     C                   eval      z = 1
0440002203220107  *
044100220322    3C     1             DO        40            X
044200220322    4C                   IF        namear(X) <> ','
044300220322     C                   eval      namearx(z) = namear(x)
044400220322     C                   eval      z = z + 1
044500220322    4C                   else
044600220322     C                   eval      namearx(z) = ' '
044700220322     C                   eval      z = z + 1
044800220322    4C                   endif
044900220322    3C                   enddo
0450002203220291  *
045100220322     C                   movea     namearx       name40x
0452002203220111  *
045300220322     C                   endsr
045400220322      ****************************************************
045500220322      *              One time initialization
045600220322      ****************************************************
045700220322     C     *INZSR        BEGSR
0458002203221304  *         Calculate cutoff dates
045900220322     C                   move      UDATE         ISOdate
046000220322     C                   move      ISOdate       ISOnum
046100220421     C                   move      ISOnum        ISOtda
046200220322     C                   subdur    60:*D         ISOdate
046300220421      * Invoice info - Calc Yrly premium
0464002204210297 C                   move      ISOtda        invdax
0465002204210297 C                   subdur    1:*M          invdax
0466002204210297 C                   move      invdax        invdat
0467002204210297 C                   z-add     01            invddd
046800220322     C                   ENDSR
