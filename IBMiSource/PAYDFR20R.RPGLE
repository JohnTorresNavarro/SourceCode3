0001000204020002  *****************************************************************************
000200200501      * PAYDFR20R  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400200407      *            DATE - 04/2020                                                 *
000500200408      *  DESCRIPTION - Build Report File for Pmt Deferral system for CFS          *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900200428      *  rlj 04/28/2020                                                           *
001000150924      *                                                                *
0011001509170018 F******************************************************************
0012002004080019 FPAYDFRIP  IP   E           K DISK
0013002004280020 FPAYDFROCP IF   E           K DISK
0014002004070019 FACCMST    IF   E           K DISK
0015002004070019 FAC2MSTL2  IF   E           K DISK
001600200407     FSMAN      IF   E           K DISK
001700200408     FAACODE    IF   E           K DISK
001800200407     FINVDET    IF   E           K DISK
0019002004070020 FPAYDFRRP  UF A E           K DISK
0020001712120025  *
0021001712120250 D                 DS
0022001712120251 D azip                    1      9  0
0023002004080251 D  azip5                  1      5
0024002004080251 D  azip9                  1      9
0025000604270025  *
0026000604270250 D                 DS
0027002004150251 D  twomon                        1    INZ('N')
0028001701260251 D  datea                          D   DATFMT(*ISO)
0029001701260251 D  dateb                          D   DATFMT(*ISO)
0030002004130251 D  tgtinv#                       7P 0
0031002004150251 D  zeroo                         7P 0 INZ(0)
0032002004280251 D  wkamt                         9P 2
003300200408      *
0034002004080037 D sysdateymd      S               d   datfmt(*iso)
003500200522      *
003600200522      *
003700200522     IACCMSR
003800200522     I              AACODE                      AACODE_I
003900200522    * *
004000200522     C     acckey        KLIST
004100200522     C                   KFLD                    pitrst
004200200522     C                   KFLD                    pisub#
004300200522     C                   KFLD                    piacct
004400161028    * *
004500200408     C     invkey        KLIST
004600200408     C                   KFLD                    pitrst
004700200408     C                   KFLD                    pisub#
004800200408     C                   KFLD                    piacct
004900200408     C                   KFLD                    pffrmdt
005000170126    * *
005100161028    * *
0052002005220291  *           Clear file - initialize hold flds
0053002005220291 C                   clear                   paydfrrr
0054002005220291  *            Set date range
005500200522     C                   select
0056002005220296 C                   when      pifrmdt = 20200301
0057002005220296 C                   eval      pffrmdt = 20200301
0058002005220296 C                   eval      pftodt = 20200331
0059002005220296 C                   when      pifrmdt = 20200401
0060002005220296 C                   eval      pffrmdt = 20200401
0061002005220296 C                   eval      pftodt = 20200430
0062002005220296 C                   when      pifrmdt = 20200501
0063002005220296 C                   eval      pffrmdt = 20200501
0064002005220296 C                   eval      pftodt = 20200531
006500200522     C                   endsl
006600200522      *
0067002005220291  *  debug shit
0068002005220296 C                   If        piacct = 1272
0069002005220296 C                   eval      pisub# = pisub#
0070002005220296 C                   endif
0071002005220291  *
0072002005220291  *        Get Account Record
0073002005220297 C     acckey        chain     accmst                             21
0074002005220296 C                   If        *in21 = '1'
0075002005220296 C                   eval      pisub# = pisub#
0076002005220296 C                   else
0077002005220291  *
0078002005220296 C                   eval      pftrst = pitrst
0079002005220296 C                   eval      pfsub# = pisub#
0080002004070296 C                   eval      pfacct = piacct
0081002004080107  *          GBS TSA
0082002004070296 C                   eval      pfgtsa = pigtsa
0083002004080107  *
0084002004080296 C                   eval      pfacnm = %TRIM(acnam1) + ' ' + acnam2
0085002004080296 C                   eval      pfcnad = %TRIM(aaddr1) + ' ' + aaddr2
008600200408     C                   movel(P)  acity         pfcnct
008700200408     C                   movel(P)  astate        pfst
008800200408     C                   movel(P)  astate        pfcnst
008900200408     C                   movel     azip5         pfcnzp
009000200408     C                   movel     aarea         pfcnph
009100200408     C                   move      aphone        pfcnph
0092002004080296 C                   eval      pfcntc = %TRIM(contac)
0093002004080107  *
0094002004080291  *        Get Acc 2 Record
0095002004080297 C     acckey        chain     ac2mstl2                           31
0096002004080296 C                   If        *in31 = '0'
0097002004160291  *    Per CW - use the address info from AACMST not AC2MST
0098002004160296 C***********        If        a2address1 <> *blanks
0099002004160296 C*****              eval      pfcnad = %TRIM(a2address1) + ' ' +
0100002004160296 C******                       a2address2
010100200416     C*****              movel(P)  a2city        pfcnct
010200200416     C******             movel(P)  a2state       pfst
010300200416     C*****              movel(P)  a2state       pfcnst
010400200416     C******             movel     a2zip5        pfcnzp
010500200416     C************       endif
0106002004080107  *                                                                     **********
0107002004230296 C                   If        a2state <> *blanks
010800200423     C                   movel(P)  a2state       pfst
010900200408     C                   endif
0110002004230107  *                                                                     **********
011100200423     C                   movel(P)  a2email1      pfcnem
011200200423     C                   endif
0113002004080107  *                                                                     **********
0114002004080297 C     aacode_i      chain     aacode                             31
0115002004080296 C                   If        *in31 = '0'
0116002004080296 C                   eval      pfaa = %TRIM(afnam) + ' ' + alnam
011700200408     C                   endif
0118002004080107  *                                                                     **********
0119002004080297 C     smancd        chain     sman                               31
0120002004080296 C                   If        *in31 = '0'
0121002004080296 C                   eval      pfbrkr = %TRIM(sfname) + ' ' + slname
012200200408     C                   endif
012300200428      *
012400200408      *
0125002004080107  *        Tally invoice amts                                           **********
0126002004130291  *
0127002004130107  *           Get the target invoice#                                   **********
012800200408      *
0129002005040296 C                   eval      tgtinv# = 0
0130002005040297 C     invkey        setgt     invdet                             22
0131002005040296 C                   dou       *in22 = '1'
0132002005040297 C                   readp     invdet                               2222
0133002005040296 C                   if        *in22 = '0'
013400200504      *
0135002005040296 C                   if        idrc = 'KMA' or idrc = 'KCE'
0136002005040296 C                   eval      tgtinv# = idinv#
0137002005040296 C                   eval      pfinv# = idinv#
013800200504     C                   leave
013900200504     C                   endif
014000200504      *
014100200504     C                   endif
014200200504     C                   enddo
014300200504      *
0144002005040297 C     invkey        setll     invdet                             22
0145002005040296 C                   dou       *in22 = '1'
0146002005040297 C     invkey        reade     invdet                                 22
0147002005040296 C                   if        *in22 = '0'
0148002005040291  *
0149002005040296 C                   if        idrc <> 'KCE' and idrc <> 'KMA'
0150002005040296 C                   iter
0151002005040296 C                   endif
0152002004130291  *
0153002004130296 C                   if        idbccc <> 'D' or idinv# <> tgtinv#
0154002004130296 C                   iter
0155002004130296 C                   endif
0156002004080291  *
0157002004080296 C                   eval      pfinv# = idinv#
0158002004080291  *
0159002004080296 C                   if        pfgrp# = *blanks
0160002004080296 C                   eval      pfgrp# = idgrp#
0161002004080296 C                   else
0162002004080296 C                   if        pfgrp# <> idgrp#
0163002004280291  *          ERROR!!!!
0164002004150296 C     pfdamt        div(H)    zeroo         pfmamt
0165002004080296 C                   eval      pfgrp# = pfgrp#
0166002004080296 C                   endif
0167002004080296 C                   endif
0168002004080291  *
0169002004080296 C                   eval      pfdamt = pfdamt + idtramb
0170002004080291  *
0171002004080296 C                   endif
0172002004080296 C                   enddo
0173002004080291  *
017400200415     C                   select
0175002004150296 C                   when      pitodt = 20200331
0176002004150296 C     pfdamt        div(H)    9             pfmamt
0177002004150296 C                   eval      pfinfrm = 20200401
0178002004150296 C                   eval      pfinst# = 9
0179002004150296 C                   when      pitodt  = 20200430
0180002004150296 C     pfdamt        div(H)    8             pfmamt
0181002004150296 C                   eval      pfinfrm = 20200501
0182002004150296 C                   eval      pfinst# = 8
0183002004150296 C                   when      pitodt  = 20200531
0184002004090296 C     pfdamt        div(H)    7             pfmamt
0185002004130296 C                   eval      pfinfrm = 20200601
0186002004150296 C                   eval      pfinst# = 7
0187002004150296 C                   endsl
0188002004080291  *
0189002004130296 C                   eval      pfinto = 20201201
0190002004130291  *
019100200408     C                   eval      sysdateymd = %date
019200200408     C                   MOVE      sysdateymd    pfrptdt
019300200408     C                   eval      pfrpttm = %time
0194002004280291  *
0195002004280296 C                   exsr      comdta
0196002004080291  *
0197002004080296 C                   write     paydfrrr
019800200409      *
019900200409      *
0200002004090291  *        If 2 months on file - process 2nd month
0201002004090291  *
0202002004150296 C                   eval      twomon = 'N'
0203002004150291  *            Set date range
020400200415     C                   select
0205002004150296 C                   when      pifrmdt = 20200301 and pitodt = 20200430
0206002004150296 C                   eval      pffrmdt = 20200401
0207002004150296 C                   eval      pftodt = 20200430
0208002004150296 C                   eval      twomon = 'Y'
0209002004150296 C                   when      pifrmdt = 20200401 and pitodt = 20200531
0210002004150296 C                   eval      pffrmdt = 20200501
0211002004150296 C                   eval      pftodt = 20200531
0212002004150296 C                   eval      twomon = 'Y'
021300200415     C                   endsl
021400200415      *
0215002004150296 C                   if        twomon = 'Y'
021600200409      *
0217002004090296 C                   eval      pfgrp# = *blanks
0218002004090296 C                   eval      pfinv# = 0
021900200409      *
0220002004090296 C                   eval      pfdamt = 0
0221002004090296 C                   eval      pfmamt = 0
022200200409      *
0223002004090107  *        Tally invoice amts                                           **********
022400200409      *
0225002004130291  *
0226002004130107  *           Get the target invoice#                                   **********
022700200413      *
0228002004130296 C                   eval      tgtinv# = 0
0229002004150297 C     invkey        setgt     invdet                             22
0230002004140296 C                   dou       *in22 = '1'
0231002004140297 C                   readp     invdet                               2222
0232002004150296 C                   if        *in22 = '0'
023300200415      *
0234002004150296 C                   if        idrc = 'KMA' or idrc = 'KCE'
0235002004150296 C                   eval      tgtinv# = idinv#
0236002004150296 C                   eval      pfinv# = idinv#
023700200415     C                   leave
023800200415     C                   endif
023900200415      *
024000200414     C                   endif
024100200414     C                   enddo
024200200414      *
0243002004090297 C     invkey        setll     invdet                             22
0244002004090296 C                   dou       *in22 = '1'
0245002004090297 C     invkey        reade     invdet                                 22
0246002004090296 C                   if        *in22 = '0'
0247002004130291  *
0248002004130296 C                   if        idrc <> 'KCE' and idrc <> 'KMA'
0249002004130296 C                   iter
0250002004130296 C                   endif
0251002004130291  *
0252002004130296 C                   if        idbccc <> 'D' or idinv# <> tgtinv#
0253002004130296 C                   iter
0254002004130296 C                   endif
0255002004130291  *
0256002004090296 C                   eval      pfinv# = idinv#
0257002004090291  *
0258002004090296 C                   if        pfgrp# = *blanks
0259002004090296 C                   eval      pfgrp# = idgrp#
0260002004090296 C                   else
0261002004090296 C                   if        pfgrp# <> idgrp#
0262002004090291  *          ERROR!!!!
0263002004150296 C     pfdamt        div(H)    zeroo         pfmamt
0264002004090296 C                   eval      pfgrp# = pfgrp#
0265002004090296 C                   endif
0266002004090296 C                   endif
0267002004090291  *
0268002004090296 C                   eval      pfdamt = pfdamt + idtramb
0269002004090291  *
0270002004090296 C                   endif
0271002004090296 C                   enddo
0272002004150291  *
027300200415     C                   select
0274002004150296 C                   when      pitodt = 20200331
0275002004150296 C     pfdamt        div(H)    9             pfmamt
0276002004150296 C                   eval      pfinfrm = 20200401
0277002004150296 C                   eval      pfinst# = 9
0278002004150296 C                   when      pitodt  = 20200430
0279002004150296 C     pfdamt        div(H)    8             pfmamt
0280002004150296 C                   eval      pfinfrm = 20200501
0281002004150296 C                   eval      pfinst# = 8
0282002004150296 C                   when      pitodt  = 20200531
0283002004150296 C     pfdamt        div(H)    7             pfmamt
0284002004150296 C                   eval      pfinfrm = 20200601
0285002004150296 C                   eval      pfinst# = 7
0286002004150296 C                   endsl
0287002004150291  *
0288002004130296 C                   eval      pfinto = 20201201
0289002004090291  *
029000200409     C                   eval      sysdateymd = %date
029100200409     C                   MOVE      sysdateymd    pfrptdt
029200200409     C                   eval      pfrpttm = %time
0293002004090291  *
0294002004280296 C                   exsr      comdta
0295002004280291  *
0296002004280296 C                   write     paydfrrr
0297002004090291  *
0298002004090296 C                   endif
0299002004090291  *
0300002004090296 C                   endif
0301002004070291  *
030200200428      ******************************************************************
030300200428      *       SUBROUTINE - COMDTA                                      *
030400200428      *              Add commission data to the record                 *
030500200428      ******************************************************************
030600200428     C     comdta        BEGSR
030700200428      *
030800200428      *        Use original input file to get #month deferred
030900200428      *
0310002004280296 C     pfgtsa        chain     paydfrocp                          20
0311002004280296 C                   if        *in20 = '1'
0312002004280291  *          ERROR!!!!
0313002004280296 C     pfdamt        div(H)    zeroo         wkamt
0314002004280296 C                   eval      pfgtsa = pfgtsa
0315002004280296 C                   endif
031600200428    * *
031700200428     C                   select
031800200428    * *
0319002004280296 C                   when      pffrmdt = 20200301
032000200428    * *   March From Date
0321002004280296 C                   if        pofrmdt = '03012020' and
0322002004280296 C                             potodt = '03312020'
032300200428    * *      March Only
0324002004280296 C                   eval      pfmoncnt = 1
0325002004280296 C                   eval      pfcomsch = *blank
0326002004280296 C                   eval      pfcffpd = 20200401
0327002004280296 C                   eval      pfafpd = 20200301
0328002004280296 C                   eval      pfcpoppd1 = 20200401
0329002004280296 C                   eval      pfcpopp1 = .25
0330002004280296 C                   eval      pfcpoppd2 = 20200501
0331002004280296 C                   eval      pfcpopp2 = .25
0332002004280296 C                   eval      pfcpoppd3 = 20200601
0333002004280296 C                   eval      pfcpopp3 = .25
0334002004280296 C                   eval      pfcpoppd4 = 20200701
0335002004280296 C                   eval      pfcpopp4 = .25
0336002004280296 C                   else
033700200428    * *
0338002004280296 C                   if        pofrmdt = '03012020' and
0339002004280296 C                             potodt = '04302020'
034000200428    * *      March and April
0341002004280296 C                   eval      pfmoncnt = 2
0342002004280296 C                   eval      pfcomsch = *blank
0343002004280296 C                   eval      pfcffpd = 20200501
0344002004280296 C                   eval      pfafpd = 20200301
0345002004280296 C                   eval      pfcpoppd1 = 20200501
0346002004280296 C                   eval      pfcpopp1 = .25
0347002004280296 C                   eval      pfcpoppd2 = 20200601
0348002004280296 C                   eval      pfcpopp2 = .25
0349002004280296 C                   eval      pfcpoppd3 = 20200701
0350002004280296 C                   eval      pfcpopp3 = .25
0351002004280296 C                   eval      pfcpoppd4 = 20200801
0352002004280296 C                   eval      pfcpopp4 = .25
0353002004280296 C                   endif
0354002004280296  *
0355002004280296 C                   endif
0356002004280296  *
0357002004280296 C                   when      pffrmdt = 20200401
035800200428    * *   April From Date
0359002004280296 C                   if        pofrmdt = '04012020' and
0360002004280296 C                             potodt = '04302020'
036100200428    * *      April Only
0362002004280296 C                   eval      pfmoncnt = 1
0363002004280296 C                   eval      pfcomsch = *blank
0364002004280296 C                   eval      pfcffpd = 20200501
0365002004280296 C                   eval      pfafpd = 20200401
0366002004280296 C                   eval      pfcpoppd1 = 20200501
0367002004280296 C                   eval      pfcpopp1 = .25
0368002004280296 C                   eval      pfcpoppd2 = 20200601
0369002004280296 C                   eval      pfcpopp2 = .25
0370002004280296 C                   eval      pfcpoppd3 = 20200701
0371002004280296 C                   eval      pfcpopp3 = .25
0372002004280296 C                   eval      pfcpoppd4 = 20200801
0373002004280296 C                   eval      pfcpopp4 = .25
0374002004280296 C                   else
037500200428    * *
0376002004280296 C                   if        pofrmdt = '03012020' and
0377002004280296 C                             potodt = '04302020'
037800200428    * *      March and April
0379002004280296 C                   eval      pfmoncnt = 2
0380002004280296 C                   eval      pfcomsch = *blank
0381002004280296 C                   eval      pfcffpd = 20200901
0382002004280296 C                   eval      pfafpd = 20200401
0383002004280296 C                   eval      pfcpoppd1 = 20200901
0384002004280296 C                   eval      pfcpopp1 = .25
0385002004280296 C                   eval      pfcpoppd2 = 20201001
0386002004280296 C                   eval      pfcpopp2 = .25
0387002004280296 C                   eval      pfcpoppd3 = 20201101
0388002004280296 C                   eval      pfcpopp3 = .25
0389002004280296 C                   eval      pfcpoppd4 = 20201201
0390002004280296 C                   eval      pfcpopp4 = .25
0391002004280296 C                   else
039200200428    * *
0393002004280296 C                   if        pofrmdt = '04012020' and
0394002004280296 C                             potodt = '05312020'
039500200428    * *      April and May
0396002004280296 C                   eval      pfmoncnt = 2
0397002004280296 C                   eval      pfcomsch = *blank
0398002004280296 C                   eval      pfcffpd = 20200601
0399002004280296 C                   eval      pfafpd = 20200401
0400002004280296 C                   eval      pfcpoppd1 = 20200601
0401002004280296 C                   eval      pfcpopp1 = .3333
0402002004280296 C                   eval      pfcpoppd2 = 20200701
0403002004280296 C                   eval      pfcpopp2 = .3333
0404002004280296 C                   eval      pfcpoppd3 = 20200801
0405002004280296 C                   eval      pfcpopp3 = .3333
0406002004280296 C                   eval      pfcpoppd4 = 0
0407002004280296 C                   eval      pfcpopp4 = 0
0408002004280296 C                   endif
0409002004280296  *
0410002004280296 C                   endif
0411002004280296 C                   endif
0412002004280296  *
0413002004280296 C                   when      pffrmdt = 20200501
041400200428    * *   May From Date
041500200428    * *
0416002004280296 C                   if        pofrmdt = '05012020' and
0417002004280296 C                             potodt = '05312020'
041800200428    * *      May Only
0419002004280296 C                   eval      pfmoncnt = 1
0420002004280296 C                   eval      pfcomsch = *blank
0421002004280296 C                   eval      pfcffpd = 20200601
0422002004280296 C                   eval      pfafpd = 20200501
0423002004280296 C                   eval      pfcpoppd1 = 20200601
0424002004280296 C                   eval      pfcpopp1 = .25
0425002004280296 C                   eval      pfcpoppd2 = 20200701
0426002004280296 C                   eval      pfcpopp2 = .25
0427002004280296 C                   eval      pfcpoppd3 = 20200801
0428002004280296 C                   eval      pfcpopp3 = .25
0429002004280296 C                   eval      pfcpoppd4 = 20200901
0430002004280296 C                   eval      pfcpopp4 = .25
0431002004280296 C                   else
043200200428    * *
0433002004280296 C                   if        pofrmdt = '04012020' and
0434002004280296 C                             potodt = '05312020'
043500200428    * *      April and May
0436002004280296 C                   eval      pfmoncnt = 2
0437002004280296 C                   eval      pfcomsch = *blank
0438002004280296 C                   eval      pfcffpd = 20200901
0439002004280296 C                   eval      pfafpd = 20200501
0440002004280296 C                   eval      pfcpoppd1 = 20200901
0441002004280296 C                   eval      pfcpopp1 = .25
0442002004280296 C                   eval      pfcpoppd2 = 20201001
0443002004280296 C                   eval      pfcpopp2 = .25
0444002004280296 C                   eval      pfcpoppd3 = 20201101
0445002004280296 C                   eval      pfcpopp3 = .25
0446002004280296 C                   eval      pfcpoppd4 = 20201201
0447002004280296 C                   eval      pfcpopp4 = .25
0448002004280296 C                   endif
0449002004280296  *
0450002004280296 C                   endif
0451002004280296  *
0452002004280296 C                   endsl
0453002004280296  *
0454002004280296 C                   endsr
