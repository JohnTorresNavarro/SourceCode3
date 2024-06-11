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
0018001807240020 Fsman      IF   E           K DISK
0019002203210020 Fsman2l    IF   E           K DISK
0020002203210020 Finvele    IF   E           K DISK
0021002203220020 Fgrat26    IF   E           K DISK
0022002204130020 Fgrat24    IF   E           K DISK    RENAME(GRATER:GRAT24R)
0023002204130020 F                                     PREFIX(X)
0024002204060020 Fddmgrpwp  O    E             DISK
002500220322      *
002600220322     D                 DS
002700220322     D  addrar         S              1A   DIM(30)
002800220322     D  addrarx        S              1A   DIM(30)
002900220322     D  namear         S              1A   DIM(40)
003000220322     D  namearx        S              1A   DIM(40)
003100220322    * *
003200200317      *
0033001902010250 D                 DS
0034002203210251 D  wrkkey                 1     14
0035002203210251 D    dwtrst               1      3  0
0036002203210251 D    dwsub#               4      6  0
0037002203210251 D    dwacct               7     10  0
0038002203210251 D    dwplan              11     14
003900220321      *
0040002203210250 D                 DS
0041002203210251 D  svwkey                 1     14
0042002203210251 D    svtrst               1      3  0
0043002203210251 D    svsub#               4      6  0
0044002203210251 D    svacct               7     10  0
0045002203210251 D    svplan              11     14
004600220321      *
0047002203210250 D                 DS
0048002203210251 D  dwgrp#                 1     15
0049002203210251 D    grp14                1      4
0050002203210251 D    grp15                1      5
0051002203210251 D    grp18                1      8
0052002203210251 D    grp110               1     10
0053002203210251 D    grp58                5      8
0054002203210251 D    grp610               6     10
0055002203210251 D    grp10               10     10
005600220321      *
0057002203210250 D                 DS
0058002203210251 D  azip                   1      9  0
0059002203210251 D    azip5                1      5
0060002203210251 D    azip4                6      9
006100220321      *
0062002203210250 D                 DS
0063002203210251 D  a2tax_id#              1     10  0
0064002203210251 D    tax2                 2      3
0065002203210251 D    tax7                 4     10
0066002203210029  *
0067002003170250 D                 DS
0068002003170251 D  svaphn                 1     10
0069002003170251 D    aarea                1      3  0
0070002003170251 D    aphone               4     10  0
007100200317      *
0072002003170250 D                 DS
0073002003200251 D  gdate                  1      8
0074002003200251 D   gdyy                  1      4
0075002003200251 D   gdmm                  5      6
0076002003200251 D   gddd                  7      8
007700200320      *
0078002003200250 D                 DS
0079002003200251 D  ddate                  1     10
0080002003200251 D   ddyy                  1      4
0081002003200251 D   ddd1                  5      5    INZ('-')
0082002003200251 D   ddmm                  6      7
0083002003200251 D   ddd2                  8      8    INZ('-')
0084002003200251 D   dddd                  9     10
008500200320      *
0086002003200250 D                 DS
0087002203210251 D  gxkey          S             10
0088002203210251 D  in20           S              2    INZ('20')
0089002203210251 D  invamt         S              9  2
0090002203220251 D  name40         S             40
0091002203220251 D  name40x        S             40
0092002203220251 D  x              S              2  0
0093002203220251 D  y              S              2  0
0094002203220251 D  z              S              2  0
0095002203220251 D  ISOdate        S               D
0096002203220251 D  ISOnum         S              8  0
0097002203220251 D  ISOtda         S              8  0
0098002204140251 D  invdat         S              8P 0
0099002204140251 D  date9          S              8  0 inz(99999999)
0100002203220251 D  MDYdate        S               D   DATFMT(*MDY)
010100220322      *
010200200317      *
010300200317     C     ackey         klist
010400220321     C                   kfld                    dwtrst
010500220321     C                   kfld                    dwsub#
010600220321     C                   kfld                    dwacct
010700150408      *
010800150408     C     plkey         klist
010900220321     C                   kfld                    dwtrst
011000220321     C                   kfld                    dwsub#
011100220321     C                   kfld                    dwplan
011200220322      *
011300220322     C     grkey         klist
011400220322     C                   kfld                    dwtrst
011500220322     C                   kfld                    dwsub#
011600220322     C                   kfld                    dwplan
011700220322     C                   kfld                    dwcovt
011800220322     C                   kfld                    grdat             8 0
011900220322      *
012000220321     C     invkey        klist
012100220321     C                   kfld                    dwtrst
012200220321     C                   kfld                    dwsub#
012300220321     C                   kfld                    dwacct
012400220414     C                   kfld                    date9
012500020503      ******************************************************************************
012600020517      *      MainLine
012700220321      *          Look for new Plan
012800220321     C                   if        dwacct = 0
012900220321     C     dwssn         chain     member                             21
013000220321     C                   if        *in21 = '0'
013100220321     C                   eval      dwacct = mbacct
013200220321     C                   endif
013300220321     C                   endif
013400220321     C                   if        wrkkey <> svwkey
013500220321     C                   eval      svwkey = wrkkey
013600220321      *       Create new Group record
013700220321     C                   clear                   ddmgrpwr
0138002203210297 C                   movel     dwtrst        dytrst
0139002203210297 C                   movel     dwsub#        dysub#
0140002203210297 C                   movel     dwacct        dyacct
0141002203210297 C                   eval      dyplan = dwplan
014200220413      *     Debug shit
014300220413     C                   if        dyplan = 'KALU'
0144002204130297 C                   eval      dyplan = dyplan
0145002204130297 C                   endif
014600220413      *
014700220325      *  Plan Info
014800220321     C     plkey         chain     plnmst
0149002203220107  *
015000220322     C                   movel(P)  pdescr        name40
015100220322     C                   exsr      getname
015200220322     C                   movel(P)  name40x       dypdsc
0153002203220297  *
0154002203210297 C                   eval      dyemr# = dytrst + '-' + dysub# +
0155002203210297 C                             '-' + dyacct
015600220321      *       Chk group# for 10 digits
015700220321     C                   if        grp10 = ' '
015800220321     C                   movel(P)  grp18         gxkey
015900220321     C     gxkey         chain     ddelgsxl                           52
016000220321     C                   if        *in52 = '0'
016100220321     C                   movel(P)  dx10gs        dwgrp#
016200220321     C                   else
016300220321     C                   eval      dwgrp# = dwgrp#
016400220321     C                   endif
016500220321     C                   endif
016600220321      *
016700220321     C                   movel(P)  grp15         dygrp#
016800220321     C                   movel(P)  grp610        dydiv#
016900220322      *  Rate Info
0170002203220297 C                   eval      grdat = ISOtda
017100220322     C     grkey         setll     grat26                             29
017200220322     C                   read      grat26                               2929
017300220322      *
017400220322     C                   if        *in29 = '1'
0175002203220297 C                   eval      grdat = 99999999
017600220322     C     grkey         setll     grat26                             29
017700220322     C                   read      grat26                               2929
017800220322     C                   endif
017900220322      *
018000220322     C                   if        *in29 = '0'
0181002204140297 C******             movel     frmdat        gdate
0182002204140297 C**                 exsr      datrtn
0183002204140297 C******             movel     ddate         dyceff
018400220322      *
018500220322     C                   move      todat         ISOdate
018600220322     C                   adddur    1:*D          ISOdate
018700220322     C                   move      ISOdate       ISOnum
018800220322     C                   move      ISOnum        gdate
0189002203220297 C                   exsr      datrtn
0190002203220297 C                   movel     ddate         dyrenew
019100220322      *
019200220322     C                   endif
0193002203221304  *
019400220322      *  Account Info
019500220321     C     ackey         chain     accmst                             23
019600220321     C                   if        *in23 = '0'
0197002203220297 C******             movel     acnam1        dyanam
0198002203220107  *
019900220322     C                   movel(P)  acnam1        name40
020000220322     C                   exsr      getname
020100220322     C                   movel(P)  name40x       dyanam
0202002203220107  *
0203002203210297 C                   movel     svaphn        dyaphn
0204002203220107  *
020500220322     C                   movel(P)  aaddr1        name40
020600220322     C                   exsr      getname
020700220322     C                   movel(P)  name40x       dyaad1
0208002203220107  *
0209002203210297 C                   movel     aaddr2        dyaad2
0210002203210297 C                   movel     acity         dyacty
0211002203210297 C                   movel     astate        dyast
0212002203210297 C                   movel     azip5         dyazip5
0213002203210297 C                   movel     azip4         dyazip4
0214002203210297 C                   movel     contac        dycntc
021500220321      *
0216002203210297 C                   if        siccod <> 0
0217002203210297 C                   movel     siccod        dysic
0218002203210297 C                   endif
021900200320      *
0220002204140297 C                   movel     gbsbdt        gdate
0221002003200297 C                   exsr      datrtn
0222002203210297 C                   movel     ddate         dyoeff
022300220414      *
0224002204140297 C                   if        atrmdt <> 0
0225002204140297 C                   movel     atrmdt        gdate
0226002204140297 C                   exsr      datrtn
0227002204140297 C                   movel     ddate         dyetrm
0228002204140297 C                   endif
022900200320      *
0230001504080297 C                   endif
023100220414      *
023200220414     C     plkey         chain     grat24                             28
023300220414     C                   if        *in28 = '0'
0234002204140297 C                   movel     xfrmdat       gdate
0235002204140297 C                   exsr      datrtn
0236002204140297 C                   movel     ddate         dyceff
0237002204140297 C                   endif
023800220321      *
023900220321     C     ackey         chain     ac2mstl2                           24
024000220321     C                   if        *in24 = '0' and a2tax_id# <> 0
0241002203210297 C                   eval      dytin = tax2 + '-' + tax7
0242002003200297 C                   endif
0243002204140297 C                   eval      dyblst = '4'
0244002204140107  *       If Acct is NOT termed
024500220414     C                   if        dyetrm = *blanks
024600220322      * Invoice info - Calc Yrly premium
0247002203210297 C                   eval      dyyprm = 0
0248002204140297 C                   eval      invdat = 0
024900220414     C     invkey        setgt     invele                             25
025000220321     C                   dou       *in25 = '1'
025100220414     C                   readp     invele                                 25
0252002204140107  *       Use recs for last invoice date
025300220414     C                   if        invdat = 0
0254002204140297 C                   eval      invdat = ievcdt
0255002204140297 C                   eval      dyindt = ievcdt
0256002204140297 C                   endif
0257002204140107  *
025800220414     C                   if        *in25 = '0' and ieplan = dyplan and
025900220414     C                             ierc = '20' and ievcdt = invdat
0260002203210297 C                   eval      dyyprm = dyyprm + ietramb
0261002203210297 C                   endif
0262002204140107  *
0263002204140297 C                   if        invdat <> ievcdt
0264002204140297 C                   leave
0265002204140297 C                   endif
0266002204140107  *
0267002203210297 C                   enddo
0268002204140107  *
0269002204140297 C                   endif
027000220322    4 *  Broker Info
027100220321     C     smancd        chain     sman                               26
027200220321     C                   if        *in26 = '0'
0273002203210297 C                   movel     sfname        dybkfn
0274002203220107  *
027500220322     C                   movel(P)  slname        name40
027600220322     C                   exsr      getname
027700220322     C                   movel(P)  name40x       dybkln
0278002203220107  *
0279002203210297 C                   movel     stin          dybktn
0280002203220107  *
028100220322     C                   movel(P)  saddr         name40
028200220322     C                   exsr      getname
028300220322     C                   movel(P)  name40x       dybkad
0284002203220107  *
028500220322     C                   movel(P)  scity         name40
028600220322     C                   exsr      getname
028700220322     C                   movel(P)  name40x       dybkct
0288002203220107  *
0289002203210297 C                   movel     sstate        dybkst
0290002203210297 C                   movel     szipcd        dybkzp
0291002203210297 C                   movel     sarea         dybkph
0292002203210297 C                   move      sphone        dybkph
029300220322    4 *  Master Broker Info
029400220321     C     sgrp          chain     sman2l                             27
029500220321     C                   if        *in27 = '0'
0296002203210297 C                   movel     sasnam        dymbnm
0297002203210297 C                   movel     *blanks       dymbtn
0298002203220107  *
029900220322     C                   movel(P)  sbrbadd1      name40
030000220322     C                   exsr      getname
030100220322     C                   movel(P)  name40x       dymbad
0302002203220107  *
0303002203210297 C                   movel     sbrbcty       dymbct
0304002203210297 C                   movel     sbrbst        dymbst
030500220321     C                   if        sbrbzip5 <> 0
0306002203210297 C                   movel     sbrbzip5      dymbzp
0307002203210297 C                   endif
030800220321     C                   if        sbradph <> 0
0309002203210297 C                   movel     sbradph       dymbph
0310002203210297 C                   endif
0311002203210297 C                   movel     sbrbst        dymbst
0312002203210297 C                   movel     saseml        dymbem
0313001807240297 C                   endif
0314002003200297  *
0315002203210297 C                   endif
0316002003200297  *
0317002204140297 C                   movel     'I'           dybkpt
0318002203210297 C                   write     ddmgrpwr
0319002003200297 C                   endif
032000200320      ****************************************************
032100200320      *
032200200320      *   DATRTN - Convert dates
032300200320      *
032400200320      ****************************************************
032500200320     C     datrtn        begsr
032600200320      *
032700200320     C                   eval      ddyy = gdyy
032800200320     C                   eval      ddmm = gdmm
032900200320     C                   eval      dddd = gddd
033000200320      *
033100200320     C                   endsr
0332002203220107  ********************************************************************************
0333002203220107  *
0334002203220107  *     GETNAME - Strip Name fields of unwanted chars
0335002203220107  *
0336002203220107  ********************************************************************************
033700220322     C     getname       begsr
0338002203220107  *
033900220322     C                   movel     *blanks       name40x
034000220322     C                   movel     *blanks       namearx
0341002203220107  *
034200220322     C                   movea     name40        namear
034300220322     C                   eval      z = 1
0344002203220107  *
034500220322    3C     1             DO        40            X
034600220322    4C                   IF        namear(X) <> ','
034700220322     C                   eval      namearx(z) = namear(x)
034800220322     C                   eval      z = z + 1
034900220322    4C                   else
035000220322     C                   eval      namearx(z) = ' '
035100220322     C                   eval      z = z + 1
035200220322    4C                   endif
035300220322    3C                   enddo
0354002203220291  *
035500220322     C                   movea     namearx       name40x
0356002203220111  *
035700220322     C                   endsr
035800220322      ****************************************************
035900220322      *              One time initialization
036000220322      ****************************************************
036100220322     C     *INZSR        BEGSR
0362002203221304  *         Calculate cutoff dates
036300220322     C                   move      UDATE         ISOdate
036400220322     C                   move      ISOdate       ISOnum
036500220322     C                   move      ISOnum        ISOtda
036600220322     C                   subdur    60:*D         ISOdate
036700220322     C                   ENDSR
