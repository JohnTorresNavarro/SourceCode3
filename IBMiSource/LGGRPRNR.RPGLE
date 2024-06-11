000001230928     H option(*noDebugIo)
0001002203230002  *****************************************************************************
000200230927      * LGGRPRNR   Amwins Connect Administrators                                  *
000300220323      *            WRITTEN BY - R.L.J.                                            *
000400230927      *            DATE - 09/2023                                                 *
000500230927      *  DESCRIPTION - Create wrk file for Lg Grp Renewal Report                  *
000600220323      *
0007002203230002  *****************************************************************************
0008002203230015  *  Change Log:                                                              *
000900220323      *  xxx mm/dd/yyyy
001000230929      *                                                                *
0011002203230018 F******************************************************************
0012012309270020 Fgrat25    IP   E           K DISK
0014002203210020 Fplnmst    IF   E           K DISK
0016002309280020 Faccmst    IF   E           K DISK    prefix(a)
0017002309280020 Fac2mstl2  IF   E           K DISK
0018002309270020 Fcmctpldt  IF   E           K DISK
0018012309280020 Fgbs0030l1 IF   E           K DISK
001802230928     faacode    IF   E           K disk    rename(aacodr:aaFile)
0019002309280020 Fsman      IF   E           K DISK
0019012309290020 Fsmanrmgp  IF   E           K DISK
0019022311270020 Faccosp    IF   E           K DISK
0019032309290020 Frmgrmst0  IF   E           K DISK
0021002309280020 Fmktcara2  IF   E           K DISK
0021012309280020 Fcarmksz3  IF   E           K DISK
0025002309280020 Flggrprnwp UF A E           K DISK
003300200317      *
0034001902010250 D                 DS
0035002309280251 D  prenew                 1      8  0
0036002309280251 D    ren2                 7      8
003601230928      *
0036022309280250 D                 DS
0036032309280251 D  pvgrp                  1     20
0036042309280251 D    pvtrst               1      3
0036052309280251 D    pvsub#               4      6
0036062309280251 D    pvacct               7     10
004000220505      *
0041002205050250 D                 DS
0042002203210251 D  svwkey                 1     14
0043002205050251 D    svtrst               1      3  0
0044002205050251 D    svsub#               4      6  0
0045002205050251 D    svacct               7     10  0
0046002205050251 D    svplan              11     14
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
0092002309280251 D  mkty           S              1
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
0111002309270251 D  dat0           S              8  0
0111012309270251 D  dat120         S              8  0
0111022310260251 D  dat10m         S              8  0
0112002206010251 D  trmacut        S              8  0
0113002206010251 D  svatrm         S              8  0
0114002205060251 D  trmcux         S               D
0115002205030251 D  invdax         S               D
0116002204140251 D  date9          S              8  0 inz(99999999)
0117002203220251 D  MDYdate        S               D   DATFMT(*MDY)
0118002309280251 D* smanky         S                   LIKE(smancd)
011900220322      *
012000200317      *
012100200317     C     ackey         klist
012200230927     C                   kfld                    cmtrst
012300230927     C                   kfld                    csubdv
012400230927     C                   kfld                    cmacct
013000220322      *
013100230927     C     cxkey         klist
013200230927     C                   kfld                    grtrst
013300230927     C                   kfld                    grsub#
013400230927     C                   kfld                    grplan
013401230928      *
013402230928     C     lgkey         klist
013403230928     C                   kfld                    grtrst
013404231031     C                   kfld                    grsub#
013405231031     C                   kfld                    cmacct
013406231031     C                   kfld                    grplan
013700231031      *
013800231031     C     mktkey        klist
013900231031     C                   kfld                    aactrst
014000231031     C                   kfld                    aacsub#
014100231031     C                   kfld                    aacacct
014200231031     C                   kfld                    pcarr
014201231031      *
014202231031     C     cmskey        klist
014206231031     C                   kfld                    pcarr
014207231031     C                   kfld                    maszcd
015000020503      ******************************************************************************
015100231025      *      MainLine
015200231025      *          Look for Plans Renewing from GRATE
015300231026     C                   if        todat > dat0 and todat <= dat10m
015304231025      *                                                                     ********
015305231025     C     cxkey         chain     cmctpldt                           22
015306231025     C                   if        *in22 = '0'
015307231025      *          Chk to see if plan already processed                       ********
015308231025     C     lgkey         chain     lggrprnwp                          21
015309231025     C                   if        *in21 = '1'
015310231027      *                                                                     ********
015311231101     C     ackey         chain     accmst                             23
015312231101     C                   if        *in23 = '0'
015313231101      *                                                                     ********
015314231101     C     cxkey         chain     plnmst                             24
015315231101     C                   if        *in24 = '0' and PLDLTD = 'A'
015316231101      *     Debug shit
015317231101     C                   if        plplan = 'NDPY' and aacacct = 85
015318231101     C                   eval      plplan = plplan
0153192311010297 C                   endif
015320231101      *          Only use mkt size > 50                                     ********
015321231101     C                   eval      mkty = 'N'
015322231101     C     mktkey        setll     mktcara2                           25
015323231101     C                   dou       *in25 = '1'
015324231101     C     mktkey        reade     mktcara2                               25
015325231101     C                   if        *in25 = '1' or matodt = 0
015326231101     C                   leave
015327231031     C                   endif
015328231031     C                   if        matodt <> 0
015329231031     C                   iter
015330231031     C                   endif
015331231031     C                   enddo
015332231031      *     Debug shit
015333231031     C                   if        plplan = 'NDPY' and aacacct = 85
015334231031     C                   eval      plplan = plplan
0153352310310297 C                   endif
015336230928      *                                                                     ********
015337230928     C                   if        *in25 = '0'
015338230928     C     cmskey        chain     carmksz3                           26
015339231026     C                   if        *in26 = '0' and cztodt = 0 and
015340231026     C                             czfrsz > 50
015341231026     C                   eval      mkty = 'Y'
015342231026     C                   endif
015343231026     C                   endif
015344231026      *                                                                     ********
015345230928     C                   if        mkty = 'Y'
015346231026      *                                                                     ********
016100231026      *       Create new Large Group Renewal record
016200231031     C                   clear                   lggrprnwr
0163002310310297 C                   movel     aactrst       lrtrst
0164002310310297 C                   movel     aacsub#       lrsub#
0165002310310297 C                   movel     aacacct       lracct
0165012310310297 C                   movel     aacnam1       lranam
016502231031      *                                                                     ********
0165032310310297 C                   movel     plplan        lrplan
0165042310310297 C                   movel     pcarr         lrcarr
016505231031     C                   if        pcarr = 'BSF'
016506231031     C                   movel     'YES'         lrbrkf
0165072310310297 C                   endif
0165082310310297 C                   movel     pdescr        lrpdsc
0165092310310297 C                   movel     ren2          lrrnmo
016510230928      *                                                                     ********
0165112309280297 C                   movel     group#        lrgrp#
0165122309280297 C                   movel     frmdat        gdate
0165132309280297 C                   exsr      datrtn
0165142309280297 C                   movel     ddate         lrefdt
0165152309280297 C                   movel     todat         gdate
0165162309280297 C                   exsr      datrtn
0165172309280297 C                   movel     ddate         lrtmdt
016518230928      *                                                                     ********
0165192309290297 C                   movel     todat         gdate
0165202309290297 C                   exsr      datrtn
0165212309290297 C                   movel     ddate         lrrtend
016522230929      *                                                                     ********
0165232309280297 C                   movel     aactrst       pvtrst
0165242309280297 C                   movel     aacsub#       pvsub#
0165252309280297 C                   movel     aacacct       pvacct
016526230928     C     pvgrp         chain     gbs0030l1                          31
016527230928     C                   if        *in31 = '0'
0165282309280297 C                   movel     ftpayvend     lrprvnd
0165292309280297 C                   endif
016530230928      *                                                                     ********
016531230928     C     aaacode       chain     aafile                             32
016532230928     C                   if        *in32 = '0'
0165332309280297 C                   eval      lrcsvc = %trim(afnam) + ' ' +
0165342309280297 C                             %trim(alnam)
0165352309280297 C                   endif
016536230928      *                                                                     ********
0165372309280297 C                   movel     maszcd        lrmksz
016538230928      *                                                                     ********
0165392310260297 C                   eval      lrmkfm = czfrsz
0165402310260297 C                   eval      lrmkto = cztosz
016541231026      *                                                                     ********
016542230928     C     slsman        chain     sman                               33
016543230928     C                   if        *in33 = '0'
0165442309280297 C                   eval      lrbrkr = %trim(sfname) + ' ' +
0165452309280297 C                             %trim(slname)
0165462309280297 C                   endif
016547230928      *                                                                     ********
016548230929     C     smancd        chain     smanrmgp                           34
016549230929     C                   if        *in34 = '0' and smrmgr <> '*UA*'
016550230929     C     smrmgr        chain     rmgrmst0                           35
016551230929     C                   if        *in35 = '0'
0165522309290297 C                   movel     rmname        LRRSMNM
0165532309290297 C                   endif
0165542309290297 C                   endif
016555231127      *        Account Type                                                 ********
016557231127     C     ackey         setll     accosp                             36
016559231127     C                   dou       *in36 = '1'
016560231127     C     ackey         reade     accosp                                 36
016561231127     C                   if        *in36 = '1'
016562231127     C                   leave
016563231127     C                   endif
016564231127     C                   if        aoendt <> 0
016565231127     C                   iter
016566231127     C                   endif
016567231127      *
016568231127     C                   select
016569231127     C                   when      aocode = 1
016570231127     C                   eval      lractp = 'Amwins View Only    '
016571231127     C                   when      aocode = 6
016572231127     C                   eval      lractp = 'Non Payroll         '
016573231127     C                   when      aocode = 7
016574231127     C                   eval      lractp = 'Non Payroll         '
016575231127     C                   when      aocode = 8
016576231127     C                   eval      lractp = 'Dashboard           '
016577231127     C                   when      aocode = 9
016578231127     C                   eval      lractp = 'Dashboard           '
016579231127     C                   when      aocode = 10
016580231127     C                   eval      lractp = 'EASE                '
016582231127     C                   endsl
016583230929      *                                                                     ********
016584231127     C                   leave
016585231127      *                                                                     ********
016586231127     C                   enddo
016587231127      *                                                                     ********
0399002309280297 C                   write     lggrprnwr
039901230928      *
0400002003200297 C                   endif
040100220601      *
0402002206010297 C                   endif
040201230928      *
0402022309280297 C                   endif
040203230928      *
0402042309280297 C                   endif
040205230928      *
0402062309280297 C                   endif
040207230928      *
0402082309280297 C                   endif
040209230928      ****************************************************
040210230928      *
040211230928      *   DATRTN - Convert dates
040212230928      *
040213230928      ****************************************************
040214230928     C     datrtn        begsr
040215230928      *
040216230928     C                   eval      ddyy = gdyy
040217230928     C                   eval      ddmm = gdmm
040218230928     C                   eval      dddd = gddd
040219230928      *
040220230928     C                   endsr
040221230928      *
044100220322      ****************************************************
044200220322      *              One time initialization
044300220322      ****************************************************
044400220322     C     *INZSR        BEGSR
0445002203221304  *         Calculate cutoff dates
044600220322     C                   move      UDATE         ISOdate
044700230927     C                   move      ISOdate       dat0
044800220421     C                   move      ISOnum        ISOtda
045000230927      *  Calc cutoff date
045001231026     C*****              adddur    120:*D        ISOdate
0451002310260297 C*****              move      ISODATE       dat120
045101231026     C                   adddur    10:*M         ISOdate
0451022310260297 C                   move      ISODATE       dat10M
046300220322     C                   ENDSR
