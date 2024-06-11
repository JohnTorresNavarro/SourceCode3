0001000204020002  *****************************************************************************
000200230120      * ACTRBLDR   Amwins Connect Admin                                           *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400230120      *            DATE - 01/2023                                                 *
000500230120      *  DESCRIPTION - Build file for Accout Report process                       *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900230120      *  xxx mm/dd/yyyy                                                           *
001000150924      *                                                                *
0011001509170018 F******************************************************************
0012002301200019 FGBS0030P  IF   E           K DISK
0013002301230020 FACCOSP    IF   E           K DISK
0014002301230020 FAOECOD    IF   E           K DISK
0015002301200019 FCOMCTUNIQ IF   E           K DISK
0016012302100020 FACCMST    IF   E           K DISK    PREFIX(M)
0017002301230019 FPLNMST    IF   E           K DISK
001800200407     FSMAN      IF   E           K DISK
001801230213     FMCOV14    IF   E           K DISK
0018022302100020 FAACODE    IF   E           K DISK
0019002301200020 FACTRPTP   UF A E           K DISK
0021001712120025  *
0022001712120250 D                 DS
0023002301200251 D ftgroup                 1     20
0024002301200251 D  fttrst                 1      3  0
0025002301200251 D  ftsub#                 4      6  0
0026002301200251 D  ftacct                 7     10  0
0027000604270025  *
0028000604270250 D                 DS
002900230123     D  ISOToday       S               d     inz
003000230123     D  Today          S              8S 0   inz
0031002301230251 D  twomon         S              1    INZ('N')
0032002301230251 D  datea          S               D   DATFMT(*ISO)
0033002301230251 D  dateb          S               D   DATFMT(*ISO)
0034002301230251 D  svplan         S                   LIKE(CMPLAN)
0035002301230251 D  tgtinv#        S              7P 0
0036002301230251 D  zeroo          S              7P 0 INZ(0)
0036012302130251 D  date9          S              8S 0 INZ(99999999)
0037002301230251 D  wkamt          S              9P 2
0038002004080037 D sysdateymd      S               d   datfmt(*iso)
003900200522      *
004000200522    * *
004100200522     C     acckey        KLIST
004200230123     C                   KFLD                    eotrst
004300230123     C                   KFLD                    eosub#
004400230123     C                   KFLD                    eoacct
004500230124    * *
004600230124     C     aotsa         KLIST
004700230124     C                   KFLD                    aotrst
004800230124     C                   KFLD                    aosub#
004900230124     C                   KFLD                    aoacct
005000230123    * *
005100230123     C     plnkey        KLIST
005200230123     C                   KFLD                    eotrst
005300230123     C                   KFLD                    eosub#
005400230210     C                   KFLD                    cmplan
005401230213    * *
005402230213     C     mcvkey        KLIST
005403230213     C                   KFLD                    eotrst
005404230213     C                   KFLD                    eosub#
005405230213     C                   KFLD                    eoacct
005406230213     C                   KFLD                    cmplan
005500230210    * *
0056002302100291  *
005700230210     C                   move      udate         ISOtoday
005800230210     C                   move      ISOtoday      today
005900230210    * *
006000230210    * *       Process EASE data
006100230210      *
0062002302100297 C     *LOVAL        setll     gbs0030p                           21
0063002302100296 C                   dou       *in21 = '1'
0064002302100297 C                   read      gbs0030p                               21
0065002302100296 C                   if        *in21 = '0'
0066002302100291  *
0067002302100296 C                   if        ftactive <> 'Y' or ftdept <> 'FI   '
0068002302100296 C                   iter
0069002302100296 C                   endif
0070002302100291  *
0071002301200291  *         Clear file - Initialize first rec for TSA
0072002302030291 C                   clear                   actrptr
0073002302030291  *
0074002302030296 C                   eval      eotrst =  fttrst
0075002302030296 C                   eval      eosub# =  ftsub#
0076002302030296 C                   eval      eoacct =  ftacct
0077002302030291  *
0078002302030296 C                   eval      eopvnd =  ftpayvend
0079002301200291  *
0079012302020296 C                   eval      eofltp =  ftfiletyp
0079022302060291  *
0080002302060296 C                   exsr      prcacct
0081002302060291  *
0082002302060296 C                   endif
0083002302060291  *
0084002302060296 C                   enddo
0085002302060291  *
008600230206    * *       Process OLE data
008700230206      *
0088002302060297 C     *LOVAL        setll     accosp                             22
0089002302060296 C                   dou       *in22 = '1'
0090002302060297 C                   read      accosp                                 22
0091002302060296 C                   if        *in22 = '0'
0092002302060291  *
0093002302060296 C                   if        aobedt > today
0094002302060296 C                   iter
0095002302060296 C                   endif
0096002301230291  *
0097002301300296 C                   if        aoendt < today and aoendt <> 0
0098002301230296 C                   iter
0099002301300296 C                   endif
0100002301240291  *
0101002301300296 C                   if        aocode <> 4 and aocode <> 5 and
0102002301300296 C                             aocode <> 8 and aocode <> 9
0103002301300296 C                   iter
0104002301240296 C                   endif
0105002301300291  *  Check to see if TSA already exists in file
0106002301300297 C     aotsa         chain     actrptp                            31
0107002301240296 C                   if        *IN31 = '0'
0108002301300296 C                   iter
0109002301300296 C                   endif
0110002301300291  *
0111002301300291  *         Clear file - Initialize first rec for TSA
0112002301300291 C                   clear                   actrptr
0113002301300291  *
0114002301300296 C                   eval      eotrst =  aotrst
0115002301300296 C                   eval      eosub# =  aosub#
0116002301300296 C                   eval      eoacct =  aoacct
0117002301300291  *
0118002301300296 C                   eval      eoocod =  aocode
0119002301300291  *
0120002301300297 C     aocode        chain     aoecod                             23
0121002301300296 C                   if        *in23 = '0'
0122002301300291  *
0123002301300296 C                   eval      eoodsc =  aedesc
0124002301230296 C                   endif
0125002301230291  *
0126002301230291  *
0127002301230296 C                   exsr      prcacct
0128002301230291  *
0129002301230296 C                   endif
0130002301230291  *
0131002301230296 C                   enddo
0132002301230291  *
0133002004090291  *
0134002301230296 C                   eval      *INLR = '1'
0135002004090291  *
0136002301230296 C                   return
0137002004070291  *
013800200428      ******************************************************************
013900230123      *       SUBROUTINE - PRCACCT                                     *
014000230123      *              Process account and plan data                     *
014100200428      ******************************************************************
014200230123     C     prcacct       BEGSR
014300200428      *
0144002301230297 C     acckey        chain     accmst                             24
0145002301230296 C                   if        *in24 = '0'
0146002301230291  *
0147002302100296 C                   eval      eoacnm = %TRIM(macnam1) + ' ' +
0148002302100296 C                             %TRIM(macnam2)
0149002302100296 C                   eval      eobrkr = msmancd
0149012302030291  *
0149022302100297 C     msmancd       chain     sman                               27
0149032302030296 C                   if        *in27 = '0'
0149042302030296 C                   eval      eobnam = %TRIM(sfname) + ' ' +
0149052302030296 C                             %TRIM(slname)
0149062302030296 C                   endif
0149072302030291  *
0150002302100296 C                   eval      eoecnt = mnoempl
0151002301230291  *
015301230210     C                   movel(P)  maacode       eoaacod
0153022302100107  *                                                                     ****
015303230210     C     maacode       chain     aacode                             29
015304230210     C                   if        *IN29 = '0'
015305230210     C                   movel(P)  alnam         eoaalnm
015306230210     C                   movel(P)  afnam         eoaafnm
0153072302100296 C                   endif
015309230210      *
0153102302100296 C                   eval      eoaddt = mgbsbdt
015311230210      *
0153122302100296 C                   eval      svplan = *blanks
0153132302100107  *                                                                     ****
0169002301230297 C     acckey        setll     comctuniq                          25
0170002301230296 C                   dou       *in25 = '1'
0171002301230297 C     acckey        reade     comctuniq                              25
0172002301230296 C                   if        *in25 = '0' and cmplan <> svplan
0173002301230291  *
0174002301230296 C                   if        effdat > today
0175002301230296 C                   iter
0176002301230296 C                   endif
0177002301230291  *
0178002301230296 C                   if        cmcan < today and cmcan <> 0
0179002301230296 C                   iter
0180002301230296 C                   endif
0181002301230291  *
0182002301230296 C                   eval      svplan = cmplan
018300200428      *
0184002301230296 C                   eval      eoplan = cmplan
018500230123      *
0186002301230297 C     plnkey        chain     plnmst                             26
0187002301230296 C                   if        *in26 = '0'
0188002301230296 C                   eval      eopdsc = pdescr
0189002301230296 C                   z-add     prenew        eoremo
0190002301230296 C                   endif
019001230213      *
0190022302130296 C                   eval      eoplst = 99999999
0190032302130297 C     mcvkey        setll     mcov14                             28
0190042302130296 C                   dou       *in28 = '1'
0190052302130297 C     mcvkey        reade     mcov14                                 28
0190072302130296 C                   if        *in28 = '0'
0190102302130296 C                   if        enrldt < eoplst
0190112302130296 C                   eval      eoplst = enrldt
0190122302130296 C                   endif
0190132302130296 C                   endif
0190142302130296 C                   enddo
0191002301230291  *
0192002301230296 C                   write     actrptr
0193002301230291  *
0194002301230296 C                   endif
0195002301230291  *
0196002301230296 C                   enddo
0197002301230291  *
0198002301230296 C                   endif
0199002301230291  *
0200002004280296 C                   endsr
