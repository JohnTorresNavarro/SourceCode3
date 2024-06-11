0001000204020002  *****************************************************************************
000200200424      * PAYDFR90R  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400200407      *            DATE - 04/2020                                                 *
000500200424      *  DESCRIPTION - Update new commission flds in PAYDFRCP                     *
000600200609      *                                                                           *
0007000204020002  *****************************************************************************
0008002006090015  *  Change Log:                                                              *
000900200609      *  xxx mm/dd/yyyy                                                           *
001000200609      *                                                                *
0011001509170018 F******************************************************************
0012002006090019 FPAYDFRCP  UP   E           K DISK
0013002006090020 FPAYDFROCP IF   E           K DISK
0014002006090025  *
0015002006090250 D                 DS
0016002006090251 D azip                    1      9  0
0017002006090251 D  azip5                  1      5
0018002006090251 D  azip9                  1      9
0019002006090025  *
0020002006090250 D                 DS
0021002006090251 D zip                     1      9  0
0022002006090251 D  mzip9                  1      9
0023002006090025  *
0024002006090250 D                 DS
0025002006090251 D rnewpd                  1      2  0
0026002006090251 D  svplst                 1      2
0027002006090025  *
0028001701030250 D                 DS
0029001701030251 D mbenrl                  1      8  0
0030001701030251 D  enrmm                  5      6
0031000604270025  *
003200150928      *
003300150928     D                 DS
003400150928     D plncat                  1      3
003500150928     D   cdkey1                1      1
003600150928     D   cdkey2                2      3
003700150928      *
0038000604270025  *
0039000604270250 D                 DS
0040001612300251 D  svempr                      241
0041001701260251 D  a2typ                         1    INZ('F')
0042002004150251 D  twomon                        1    INZ('N')
0043001701260251 D  datea                          D   DATFMT(*ISO)
0044001701260251 D  dateb                          D   DATFMT(*ISO)
0045002004130251 D  tgtinv#                       7P 0
0046002004270251 D  wkamt                         9P 2
0047002004150251 D  zeroo                         7P 0 INZ(0)
004800200408      *
0049002004080037 D sysdateymd      S               d   datfmt(*iso)
005000200408      *
0051002004270296 C     pfgtsa        chain     paydfrocp                          20
0052002004270296 C                   if        *in20 = '1'
0053002004270296 C     pfdamt        div(H)    zeroo         wkamt
0054002004270296 C                   eval      pfgtsa = pfgtsa
0055002004270296 C                   else
005600161028    * *
005700200415     C                   select
005800200427    * *
0059002004270296 C                   when      pffrmdt = 20200301
006000200427    * *   March From Date
0061002004270296 C                   if        pofrmdt = '03012020' and
0062002004270296 C                             potodt = '03312020'
006300200427    * *      March Only
0064002004270296 C                   eval      pfmoncnt = 1
0065002004270296 C                   eval      pfcomsch = *blank
0066002004270296 C                   eval      pfcffpd = 20200401
0067002004270296 C                   eval      pfafpd = 20200301
0068002004270296 C                   eval      pfcpoppd1 = 20200401
0069002004270296 C                   eval      pfcpopp1 = .25
0070002004270296 C                   eval      pfcpoppd2 = 20200501
0071002004270296 C                   eval      pfcpopp2 = .25
0072002004270296 C                   eval      pfcpoppd3 = 20200601
0073002004270296 C                   eval      pfcpopp3 = .25
0074002004270296 C                   eval      pfcpoppd4 = 20200701
0075002004270296 C                   eval      pfcpopp4 = .25
0076002004270296 C                   else
007700200427    * *
0078002004270296 C                   if        pofrmdt = '03012020' and
0079002004270296 C                             potodt = '04302020'
008000200427    * *      March and April
0081002004270296 C                   eval      pfmoncnt = 2
0082002004270296 C                   eval      pfcomsch = *blank
0083002004270296 C                   eval      pfcffpd = 20200501
0084002004270296 C                   eval      pfafpd = 20200301
0085002004270296 C                   eval      pfcpoppd1 = 20200501
0086002004270296 C                   eval      pfcpopp1 = .25
0087002004270296 C                   eval      pfcpoppd2 = 20200601
0088002004270296 C                   eval      pfcpopp2 = .25
0089002004270296 C                   eval      pfcpoppd3 = 20200701
0090002004270296 C                   eval      pfcpopp3 = .25
0091002004270296 C                   eval      pfcpoppd4 = 20200801
0092002004270296 C                   eval      pfcpopp4 = .25
0093002004270296 C                   endif
0094002004270296  *
0095002004270296 C                   endif
0096002004270296  *
0097002004270296 C                   when      pffrmdt = 20200401
009800200427    * *   April From Date
0099002004270296 C                   if        pofrmdt = '04012020' and
0100002004270296 C                             potodt = '04302020'
010100200427    * *      April Only
0102002004270296 C                   eval      pfmoncnt = 1
0103002004270296 C                   eval      pfcomsch = *blank
0104002004270296 C                   eval      pfcffpd = 20200501
0105002004270296 C                   eval      pfafpd = 20200401
0106002004270296 C                   eval      pfcpoppd1 = 20200501
0107002004270296 C                   eval      pfcpopp1 = .25
0108002004270296 C                   eval      pfcpoppd2 = 20200601
0109002004270296 C                   eval      pfcpopp2 = .25
0110002004270296 C                   eval      pfcpoppd3 = 20200701
0111002004270296 C                   eval      pfcpopp3 = .25
0112002004270296 C                   eval      pfcpoppd4 = 20200801
0113002004270296 C                   eval      pfcpopp4 = .25
0114002004270296 C                   else
011500200427    * *
0116002004270296 C                   if        pofrmdt = '03012020' and
0117002004270296 C                             potodt = '04302020'
011800200427    * *      March and April
0119002004270296 C                   eval      pfmoncnt = 2
0120002004270296 C                   eval      pfcomsch = *blank
0121002004270296 C                   eval      pfcffpd = 20200901
0122002004270296 C                   eval      pfafpd = 20200401
0123002004270296 C                   eval      pfcpoppd1 = 20200901
0124002004270296 C                   eval      pfcpopp1 = .25
0125002004270296 C                   eval      pfcpoppd2 = 20201001
0126002004270296 C                   eval      pfcpopp2 = .25
0127002004270296 C                   eval      pfcpoppd3 = 20201101
0128002004270296 C                   eval      pfcpopp3 = .25
0129002004270296 C                   eval      pfcpoppd4 = 20201201
0130002004270296 C                   eval      pfcpopp4 = .25
0131002004270296 C                   else
013200200427    * *
0133002004270296 C                   if        pofrmdt = '04012020' and
0134002004270296 C                             potodt = '05312020'
013500200427    * *      April and May
0136002004270296 C                   eval      pfmoncnt = 2
0137002004270296 C                   eval      pfcomsch = *blank
0138002004270296 C                   eval      pfcffpd = 20200601
0139002004270296 C                   eval      pfafpd = 20200401
0140002004270296 C                   eval      pfcpoppd1 = 20200601
0141002004270296 C                   eval      pfcpopp1 = .3333
0142002004270296 C                   eval      pfcpoppd2 = 20200701
0143002004270296 C                   eval      pfcpopp2 = .3333
0144002004270296 C                   eval      pfcpoppd3 = 20200801
0145002004270296 C                   eval      pfcpopp3 = .3333
0146002004270296 C                   eval      pfcpoppd4 = 0
0147002004270296 C                   eval      pfcpopp4 = 0
0148002004270296 C                   endif
0149002004270296  *
0150002004270296 C                   endif
0151002004270296 C                   endif
0152002004270296  *
0153002004270296 C                   when      pffrmdt = 20200501
015400200427    * *   May From Date
015500200427    * *
0156002004270296 C                   if        pofrmdt = '05012020' and
0157002004270296 C                             potodt = '05312020'
015800200427    * *      May Only
0159002004270296 C                   eval      pfmoncnt = 1
0160002004270296 C                   eval      pfcomsch = *blank
0161002004270296 C                   eval      pfcffpd = 20200601
0162002004270296 C                   eval      pfafpd = 20200501
0163002004270296 C                   eval      pfcpoppd1 = 20200601
0164002004270296 C                   eval      pfcpopp1 = .25
0165002004270296 C                   eval      pfcpoppd2 = 20200701
0166002004270296 C                   eval      pfcpopp2 = .25
0167002004270296 C                   eval      pfcpoppd3 = 20200801
0168002004270296 C                   eval      pfcpopp3 = .25
0169002004270296 C                   eval      pfcpoppd4 = 20200901
0170002004270296 C                   eval      pfcpopp4 = .25
0171002004270296 C                   else
017200200427    * *
0173002004270296 C                   if        pofrmdt = '04012020' and
0174002004270296 C                             potodt = '05312020'
017500200427    * *      April and May
0176002004270296 C                   eval      pfmoncnt = 2
0177002004270296 C                   eval      pfcomsch = *blank
0178002004270296 C                   eval      pfcffpd = 20200901
0179002004270296 C                   eval      pfafpd = 20200501
0180002004270296 C                   eval      pfcpoppd1 = 20200901
0181002004270296 C                   eval      pfcpopp1 = .25
0182002004270296 C                   eval      pfcpoppd2 = 20201001
0183002004270296 C                   eval      pfcpopp2 = .25
0184002004270296 C                   eval      pfcpoppd3 = 20201101
0185002004270296 C                   eval      pfcpopp3 = .25
0186002004270296 C                   eval      pfcpoppd4 = 20201201
0187002004270296 C                   eval      pfcpopp4 = .25
0188002004270296 C                   endif
0189002004270296  *
0190002004270296 C                   endif
0191002004270296  *
0192002004270296  *
0193002004270296 C                   endsl
0194002006090296  *
0195002004270296 C                   update    paydfrcr
0196002006090291  *
0197002004090296 C                   endif
