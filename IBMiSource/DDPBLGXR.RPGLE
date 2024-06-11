0001002003200020 Fddgrpwp   IP   E           K DISK
0002001504080020 Fplnmst    IF   E           K DISK
0003001504080020 Faccmst    IF   E           K DISK
0004002003200020 Fac2mstl2  IF   E           K DISK
0005001807240020 Fsman      IF   E           K DISK
0005012303160020 Fsman2l    IF   E           K DISK
0006001504080020 Fddggrpxp  O    E             DISK
000700200317      *
0008001902010250 D                 DS
0009002003170251 D  svemr#                 1     10
0010002003170251 D    dgtrst               1      3  0
0011002003170251 D    dgsub#               4      6  0
0012002003170251 D    dgacct               7     10  0
001300200317      *
0014002003170250 D                 DS
0015002003170251 D  svaphn                 1     10
0016002003170251 D    aarea                1      3  0
0017002003170251 D    aphone               4     10  0
001800200317      *
0019002003170250 D                 DS
0020002003200251 D  gdate                  1      8
0021002003200251 D   gdyy                  1      4
0022002003200251 D   gdmm                  5      6
0023002003200251 D   gddd                  7      8
002400200320      *
0025002003200250 D                 DS
0026002003200251 D  ddate                  1     10
0027002003200251 D   ddyy                  1      4
0028002003200251 D   ddd1                  5      5    INZ('-')
0029002003200251 D   ddmm                  6      7
0030002003200251 D   ddd2                  8      8    INZ('-')
0031002003200251 D   dddd                  9     10
003200200320      *
0033002003200250 D                 DS
0034002003200251 D  z              S              3  0
003500200320      *          c
003600200317      *
003700200317     C     ackey         klist
003800200317     C                   kfld                    dgtrst
003900200317     C                   kfld                    dgsub#
004000150408     C                   kfld                    dgacct
004100150408      *
004200150408     C     plkey         klist
004300150408     C                   kfld                    dgtrst
004400150408     C                   kfld                    dgsub#
004500150408     C                   kfld                    dgplan
004600020503      ******************************************************************************
004700020517      *      MainLine
004800150408     C                   clear                   ddggrpxr
0049001504080297 C                   eval      dxplan = dgplan
005000150408     C     plkey         chain     plnmst                             21
0051002003200297 C                   movel     pdescr        dxpdsc
005200200320      *     Do not include EHIP or EHIT plans
005300200320    4C                   eval      Z = %scan ('EHIP':dxpdsc)
005400200320    4C                   IF        z = 0
005500200320    4C                   eval      Z = %scan ('EHIT':dxpdsc)
005600200320    4C                   IF        z = 0
005700200320      *
0058001504080297 C                   eval      dxemr# = svemr#
0059001504080297 C                   eval      dxgrp# = dggrp#
0060001504080297 C                   eval      dxdiv# = dgdiv#
006100150408     C     ackey         chain     accmst                             21
006200150408     C                   if        *in21 = '0'
0063001504080297 C                   movel     acnam1        dxanam
0064001504080297 C                   movel     svaphn        dxaphn
0065001504080297 C                   movel     aaddr1        dxaad1
0066001504080297 C                   movel     aaddr2        dxaad2
0067001504080297 C                   movel     acity         dxacty
0068001504080297 C                   movel     astate        dxast
0069001504080297 C                   movel     azip          dxazip
0070001504080297 C                   movel     contac        dxcntc
0071002003200297 C                   movel     siccod        dxsic
007200200320      *
0073002003200297 C                   movel     enroll        gdate
0074002003200297 C                   exsr      datrtn
0075002003200297 C                   movel     ddate         dxoeff
007600200320      *
0077001504080297 C                   endif
007800200320     C     ackey         chain     ac2mstl2                           21
007900200320     C                   if        *in21 = '0'
0080002003200297 C                   movel     a2tax_id#     dxtin
0080012303160297 C                   movel(p)  a2email1      dxaeml
0081002003200297 C                   endif
0081012303160297  *
008200180724     C     smancd        chain     sman                               22
008300180724     C                   if        *in22 = '0'
0084001807240297 C                   movel     sfname        dxsfnm
0085001807240297 C                   movel     slname        dxslnm
0086001807240297 C                   movel     saddr         dxsadr
0087001807240297 C                   movel     scity         dxscty
0088001807240297 C                   movel     sstate        dxsst
0089001807240297 C                   movel     szipcd        dxszip
0090001807240297 C                   movel     sarea         dxsare
0091001807240297 C                   movel     sphone        dxsphn
0092001807240297 C                   endif
0092012303160297  *
009202230316     C     sgrp          chain     sman2l                             22
009203230316     C                   if        *in22 = '0'
0092042303160297 C                   movel(p)  sbreml        dxseml
0092052303160297 C                   endif
0093002003200297  *
0094002003200297 C                   eval      dxempc1 = dgempc1
0095002003200297 C                   z-add     dxempc1       dxempt
0096002003200297 C                   eval      dxempc2 = dgempc2
0097002003200297 C                   eval      dxempt = dxempt + dxempc2
0098002003200297 C                   eval      dxempc3 = dgempc3
0099002003200297 C                   eval      dxempt = dxempt + dxempc3
0100002003200297 C                   eval      dxempc4 = dgempc4
0101002003200297 C                   eval      dxempt = dxempt + dxempc4
0102002003200297 C                   eval      dxtotc = dxempt + dgdepct
0103002003200297  *
0104002003200297 C                   eval      dxtotp = dgtotp * 12
010500200320      *
0106002003200297 C                   movel     dgeffdt       gdate
0107002003200297 C                   exsr      datrtn
0108002003200297 C                   movel     ddate         dxceff
010900200320      *
0110002003200297 C                   movel     dgtrmdt       gdate
0111002003200297 C                   exsr      datrtn
0112002003200297 C                   movel     ddate         dxrenew
011300200320      *
0114002003200297  *
0115001504080297 C                   write     ddggrpxr
0116002003200297 C                   endif
0117002003200297 C                   endif
011800200320      ****************************************************
011900200320      *
012000200320      *   DATRTN - Convert dates
012100200320      *
012200200320      ****************************************************
012300200320     C     datrtn        begsr
012400200320      *
012500200320     C                   eval      ddyy = gdyy
012600200320     C                   eval      ddmm = gdmm
012700200320     C                   eval      dddd = gddd
012800200320      *
012900200320     C                   endsr
