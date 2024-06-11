0001000204020002  *****************************************************************************
000200200501      * PAYDFR32R  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400200501      *            DATE - 05/2020                                                 *
000500200501      *  DESCRIPTION - Build CFS Rpt File for Pmt Def - 1 rec/acct                *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900200428      *  rlj 04/28/2020                                                           *
001000150924      *                                                                *
0011001509170018 F******************************************************************
0012002005010019 FPAYDFRCP  IP   E           K DISK
0013002005010020 FPAYDFCFP  O    E           K DISK
0014000604270025  *
0015000604270250 D                 DS
0016002005010251 D  svgtsa                       12    INZ(*blanks)
0017001701260251 D  a2typ                         1    INZ('F')
0018002004150251 D  twomon                        1    INZ('N')
0019001701260251 D  datea                          D   DATFMT(*ISO)
0020001701260251 D  dateb                          D   DATFMT(*ISO)
0021002004130251 D  tgtinv#                       7P 0
0022002004150251 D  zeroo                         7P 0 INZ(0)
0023002004280251 D  wkamt                         9P 2
002400200408      *
0025002004080037 D sysdateymd      S               d   datfmt(*iso)
002600200408      *
002700170126    * *
002800161028    * *
0029002005010296 C                   If        svgtsa = pfgtsa
0030002005010291  *           Still same TSA - add to existing record
0031002005010296 C                   eval      pctodt = pftodt
0032002005010296 C                   eval      pcdamt = pcdamt + pfdamt
0033002005010296 C                   eval      pcmamt = pcmamt + pfmamt
003400200501    * *
003500200501     C                   else
0036002005010296 C                   eval      svgtsa = pfgtsa
0037002005010291  *           Different TSA - see if need to write existing rec
0038002005010296 C                   If        pcgtsa <> *blanks
0039002005010291 C                   write     paydfcfr
004000200501     C                   endif
0041002005010291  *             Populate static fields
0042002005010291 C                   clear                   paydfcfr
0043002005010296 C                   eval      pctrst = pftrst
0044002005010296 C                   eval      pcsub# = pfsub#
0045002005010296 C                   eval      pcacct = pfacct
0046002005010296 C                   eval      pcgrp# = pfgrp#
0047002005010296 C                   eval      pcacnm = pfacnm
0048002005010296 C                   eval      pcinv# = pfinv#
0049002005010296 C                   eval      pcst   = pfst
0050002005010296 C                   eval      pcfrmdt = pffrmdt
0051002005010296 C                   eval      pctodt = pftodt
0052002005010296 C                   eval      pcdamt = pfdamt
0053002005010296 C                   eval      pcmamt = pfmamt
0054002005010296 C                   eval      pcinfrm = pfinfrm
0055002005010296 C                   eval      pcinto = pfinto
0056002005010296 C                   eval      pcinst# = pfinst#
0057002005010296 C                   eval      pccntc = pfcntc
0058002005010296 C                   eval      pccnph = pfcnph
0059002005010296 C                   eval      pccnem = pfcnem
0060002005010296 C                   eval      pccnad = pfcnad
0061002005010296 C                   eval      pccnct = pfcnct
0062002005010296 C                   eval      pccnst = pfcnst
0063002005010296 C                   eval      pccnzp = pfcnzp
0064002005010296 C                   eval      pcgtsa = pfgtsa
0065002005010296 C                   eval      pcdamt = pfdamt
0066002005010296 C                   eval      pcaa   = pfaa
0067002005010296 C                   eval      pcbrkr = pfbrkr
0068002005010291  *
0069002005010296 C                   eval      pcrptdt = pfrptdt
0070002005010296 C                   eval      pcrpttm = pfrpttm
0071002005010291  *
007200200501     C                   endif
007300200501      * Process last record
007400200501     CLR                 Exsr      Process_LR
0075002005010107  ********************************************************************************
007600200501      * Process LR
0077002005010107  ********************************************************************************
007800200501     C     Process_LR    BEGSR
007900200501      *
0080002005010296 C                   If        pcgtsa <> *blanks
0081002005010291 C                   write     paydfcfr
008200200501     C                   endif
008300200501      *
008400200501     C                   ENDSR
