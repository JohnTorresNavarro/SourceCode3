0001000204020002  *****************************************************************************
000200200501      * PAYDFR32R  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400200501      *            DATE - 05/2020                                                 *
000500200501      *  DESCRIPTION - Build CFS Rpt File for Pmt Def - 1 rec/acct                *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900200605      *  rlj 06/05/2020 Add logic for Billed fields                               *
001000200813      *  rlj 08/14/2020 Add logic for Acct Term Date                              *
001100200826      *  rlj 08/26/2020 Use Override File, PAYDFOVP to set values                 *
001200150924      *                                                                *
0013001509170018 F******************************************************************
0014002005010019 FPAYDFRCP  IP   E           K DISK
0015002008250019 FPAYDFOVP  IF   E           K DISK
0016002006050019 FINVELE    IF   E           K DISK
0017002008130019 FACCMST    IF   E           K DISK
0018002005010020 FPAYDFCFP  O    E           K DISK
0019002006050484 D                 DS
0020002006050485 D  parmtsa                1     10
0021002006050486 D   ptrst                 1      3
0022002006050486 D   psub#                 4      6
0023002006050486 D   pacct                 7     10
0024000604270025  *
0025000604270250 D                 DS
0026002005010251 D  svgtsa                       12    INZ(*blanks)
0027002006100251 D  svtmran                            LIKE(pctmran)
0028002006100251 D                                     INZ(*LOVAL)
0029002006100251 D  a2typ                         1    INZ('F')
0030002004150251 D  twomon                        1    INZ('N')
0031001701260251 D  datea                          D   DATFMT(*ISO)
0032001701260251 D  dateb                          D   DATFMT(*ISO)
0033002004130251 D  tgtinv#                       7P 0
0034002006050251 D  pdmnths                       2S 0
0035002004150251 D  zeroo                         7P 0 INZ(0)
0036002004280251 D  wkamt                         9P 2
0037002006050037 D sysdateymd                      d   datfmt(*iso)
003800200605     D parmptdate                     8
003900200820      *
004000200820    * *
004100200820    * *
004200200820     C     invkey        KLIST
004300200820     C                   KFLD                    pftrst
004400200820     C                   KFLD                    pfsub#
004500200820     C                   KFLD                    pfacct
004600200820    * *
004700200820     C     acckey        KLIST
004800200820     C                   KFLD                    pctrst
004900200820     C                   KFLD                    pcsub#
005000200820     C                   KFLD                    pcacct
005100200820    * *
005200200820    * *
0053002008200291  *           Debug shit
0054002008200296 C                   If        pfgtsa = '003-001-0608'
0055002008200291 C                   eval      pfgtsa = pfgtsa
005600200820     C                   endif
005700200820    * *
005800200820    * *
0059002008200296 C                   If        svgtsa = pfgtsa
0060002005010291  *           Still same TSA - add to existing record
0061002005010296 C                   eval      pctodt = pftodt
0062002005010296 C                   eval      pcdamt = pcdamt + pfdamt
0063002005010296 C                   eval      pcmamt = pcmamt + pfmamt
006400200501    * *
006500200501     C                   else
006600200609    * *
0067002005010296 C                   eval      svgtsa = pfgtsa
0068002005010291  *           Different TSA - see if need to write existing rec
0069002005010296 C                   If        pcgtsa <> *blanks
007000200609      *           Calculate Paid Amt
0071002006090291 C                   eval      pcpamt = 0
0072002006090296 C                   If        pcpdth > 0
007300200609     C                   movel     pcpdth        datea
007400200609     C                   movel     pcinfrm       dateb
007500200609     C     datea         subdur    dateb         pdmnths:*M
0076002006090296 C                   If        pdmnths > -1
0077002006090291 C                   eval      pdmnths = pdmnths + 1
0078002006090291 C                   eval      pcpamt = pdmnths * pcmamt
007900200609     C                   endif
008000200609     C                   endif
008100200612      *     Count Deferral months as Paid months
008200200612     C                   if        pcpdth < pctodt
008300200612     C                   eval      pcpdth = pctodt
0084002006120291 C                   endif
008500200609      *
0086002006090291 C                   eval      pcramt = pcdamt - pcpamt
0087002006090291  *
008800200609     C                   eval      sysdateymd = %date
008900200609     C                   MOVE      sysdateymd    pcdtran
009000200610     C                   if        svtmran = *loval
009100200610     C                   eval      svtmran = %time
009200200610     C                   endif
009300200610     C                   eval      pctmran = svtmran
009400200609      *
0095002008130297 C     acckey        chain     accmst
0096002008130296 C                   eval      pcatrmd = atrmdt
009700200813      *
009800200826      *  Use Override File values if a Termed Acct
0099002008260297 C     acckey        chain     paydfovp                           61
0100002008260296 C                   if        *in61 = '0'
0101002008260296 C                   eval      pcdamt = podamt
0102002008260296 C                   eval      pcmamt = pomamt
0103002008260296 C                   eval      pcinst# = poinst#
0104002008260296 C                   eval      pcinfrm = poinfrm
0105002008260296 C                   eval      pcbamt = pobamt
0106002008260296 C                   eval      pcpamt = popamt
0107002008260296 C                   eval      pcramt = poramt
0108002008260296 C                   eval      pcpdth = popdth
010900200826     C                   endif
011000200826      *
0111002005010291 C                   write     paydfcfr
011200200501     C                   endif
0113002005010291  *             Populate static fields
0114002005010291 C                   clear                   paydfcfr
0115002005010296 C                   eval      pctrst = pftrst
0116002005010296 C                   eval      pcsub# = pfsub#
0117002005010296 C                   eval      pcacct = pfacct
0118002005010296 C                   eval      pcgrp# = pfgrp#
0119002005010296 C                   eval      pcacnm = pfacnm
0120002005010296 C                   eval      pcinv# = pfinv#
0121002005010296 C                   eval      pcst   = pfst
0122002005010296 C                   eval      pcfrmdt = pffrmdt
0123002005010296 C                   eval      pctodt = pftodt
0124002005010296 C                   eval      pcdamt = pfdamt
0125002005010296 C                   eval      pcmamt = pfmamt
0126002005010296 C                   eval      pcinfrm = pfinfrm
0127002005010296 C                   eval      pcinto = pfinto
0128002005010296 C                   eval      pcinst# = pfinst#
0129002005010296 C                   eval      pccntc = pfcntc
0130002005010296 C                   eval      pccnph = pfcnph
0131002005010296 C                   eval      pccnem = pfcnem
0132002005010296 C                   eval      pccnad = pfcnad
0133002005010296 C                   eval      pccnct = pfcnct
0134002005010296 C                   eval      pccnst = pfcnst
0135002005010296 C                   eval      pccnzp = pfcnzp
0136002005010296 C                   eval      pcgtsa = pfgtsa
0137002005010296 C                   eval      pcdamt = pfdamt
0138002005010296 C                   eval      pcaa   = pfaa
0139002005010296 C                   eval      pcbrkr = pfbrkr
0140002005010291  *
0141002005010296 C                   eval      pcrptdt = pfrptdt
0142002005010296 C                   eval      pcrpttm = pfrpttm
0143002006090291  *
0144002006090296 C*******            eval      svinfrm = pfinfrm
0145002006090291  *
0146002006050291  *       Populate Billed Fields
0147002006050296 C                   eval      pcbamt = 0
0148002006050297 C     invkey        setll     invele                             22
0149002006050296 C                   dou       *in22 = '1'
0150002006050297 C     invkey        reade     invele                                 22
0151002006050296 C                   if        *in22 = '0'
0152002006050291  *
0153002006050296 C                   if        ierc = '30'
0154002006050296 C                   if        ietrcd = 'GDI' or ietrcd = 'ADI'
0155002006050296 C                   eval      pcbamt = pcbamt + ietramb
015600200605     C                   endif
015700200605     C                   endif
015800200605     C                   endif
0159002005010291  *
016000200605     C                   enddo
0161002006050291  *
016200200605     C                   movel     pftrst        ptrst
016300200605     C                   movel     pfsub#        psub#
016400200605     C                   movel     pfacct        pacct
016500200605     C                   eval      parmptdate = *blanks
0166002006050694 c                   call      'GETPTHRUCL'
016700200605     c                   parm                    parmtsa
016800200605     c                   parm                    parmptdate
016900200605     C                   movel     parmptdate    pcpdth
017000200611      *
0171002006110291 C                   endif
017200200501      * Process last record
017300200501     CLR                 Exsr      Process_LR
0174002005010107  ********************************************************************************
017500200501      * Process LR
0176002005010107  ********************************************************************************
017700200501     C     Process_LR    BEGSR
017800200501      *
0179002005010296 C                   If        pcgtsa <> *blanks
018000200609      *           Calculate Paid Amt
0181002006090291 C                   eval      pcpamt = 0
0182002006090296 C                   If        pcpdth > 0
018300200609     C                   movel     pcpdth        datea
018400200609     C                   movel     pcinfrm       dateb
018500200609     C     datea         subdur    dateb         pdmnths:*M
0186002006090296 C                   If        pdmnths > -1
0187002006090291 C                   eval      pdmnths = pdmnths + 1
0188002006090291 C                   eval      pcpamt = pdmnths * pcmamt
018900200609     C                   endif
019000200609     C                   endif
019100200609      *
0192002006090291 C                   eval      pcramt = pcdamt - pcpamt
0193002006120291  *          Count deferral months as Paid Months
019400200612     C                   if        pcpdth < pctodt
019500200612     C                   eval      pcpdth = pctodt
0196002006120291 C                   endif
019700200612      *
019800200609     C                   eval      sysdateymd = %date
019900200609     C                   MOVE      sysdateymd    pcdtran
020000200610     C                   eval      pctmran = svtmran
020100200813      *
0202002008130297 C     acckey        chain     accmst
0203002008130296 C                   eval      pcatrmd = atrmdt
020400200813      *
020500200826      *  Use Override File values if a Termed Acct
0206002008260297 C     acckey        chain     paydfovp                           61
0207002008260296 C                   if        *in61 = '0'
0208002008260296 C                   eval      pcdamt = podamt
0209002008260296 C                   eval      pcmamt = pomamt
0210002008260296 C                   eval      pcinst# = poinst#
0211002008260296 C                   eval      pcinfrm = poinfrm
0212002008260296 C                   eval      pcbamt = pobamt
0213002008260296 C                   eval      pcpamt = popamt
0214002008260296 C                   eval      pcramt = poramt
0215002008260296 C                   eval      pcpdth = popdth
021600200826     C                   endif
021700200826      *
0218002005010291 C                   write     paydfcfr
021900200609      *
022000200501     C                   endif
022100200501      *
022200200501     C                   ENDSR
